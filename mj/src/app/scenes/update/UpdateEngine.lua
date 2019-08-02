local UpdateEngine = class("UpdateEngine")

UpdateEventCode = {
    ERROR_NETWORK = 0,
    START_DOWNLOAD_UPDATE_CONFIG = 1,
    ERROR_DOWNLOAD_UPDATE_CONFIG = 2,
    FINISH_DOWNLOAD_UPDATE_CONFIG = 3,
    START_DOWNLOAD_UPDATE_FILE = 4,
    ERROR_DOWNLOAD_UPDATE_FILE = 5,
    FINISH_DOWNLOAD_UPDATE_FILE = 6,
    FINISH_UPDATE = 7,
    NO_UPDATE_VERSIONS = 8,

    SUB_UPDATE_GAME_START = 9,
    SUB_UPDATE_GAME_FINISHED = 10,
    SUB_UPDATE_GAME_PROGRESS = 11,
}

DLFileErrCode = {
    ERROR_NETWORK = 0,      --网络错误
    ERROR_SAVE = 1,         --保存失败
    ERROR_MD5 = 2,          --文件MD5错误
    ERROR_HTTP = 3,         --http错误（比如服务器连接不上）
    ERROR_UNZIP = 4,        --解压文件失败
    ERROR_JSON = 5,         --文件JSon格式错
}

function UpdateEngine:ctor(params)
    print("UpdateEngine:ctor")
    self.m_dowloadPath = params.dlpath--cc.FileUtils:getInstance():getWritablePath() .. "main_version"
    self.m_updateConfig = params.updateConfig
    self.m_callback = params.callback
    self:initUpdateConfig(params.updateConfig)
end

CompareVerCode = {
    CODE_N_2 = -2,  --差分更新
    CODE_N_1 = -1,  --整包更新
    CODE_0 = 0,     --不需要更新
    CODE_1 = 1,     --删除更新文件
}
local function  compareVersion(ver1,ver2)
    if ver2 == nil then
       return 1
    end

    if ver1 == nil then
       return -1
    end

    local vers1 = string.split(ver1,".")
    local vers2 = string.split(ver2,".")
    
    if vers2 == nil or vers2 == "" or #vers1 ~= #vers2 then
       return 1
    end

    for i = 1,#vers1 do
       local i1 = tonumber(vers1[i]) or 0
       local i2 = tonumber(vers2[i]) or 0
       if i1 > i2 then
         return 1
       end

       if i1 < i2 then
         return 0-i
       end
    end
    return 0
end

local function isInTable(tb, val)
    if tb == nil then
        return false
    end
    for _,v in ipairs(tb) do
        if v == val then
            return true
        end
    end
    return false
end

function UpdateEngine:startDownloadNextZip()
    local next = self:getNextZip()
    if next then
        self:downloadZip(next)
    else
        self:notifyCallback({})
        self.m_downloadFinish = true
    end
end

--获取下一个更新包版本
function UpdateEngine:getNextVersion(ver, packages)
    local compare = 0
    for i,package in ipairs(packages) do
        compare = compareVersion(ver, package.ver)
        if compare < 0 then
            return package.ver
        end
    end
    return nil
end

--获取下一个更新包配置
function UpdateEngine:getPkgByVersion(ver, packages)
    for i,package in ipairs(packages) do
        if ver == package.ver then
            return package
        end
    end
end

function UpdateEngine:initUpdateConfig(config)
    self.m_dlsize = 0
    self.m_dltotal = 0
    self.m_subdlsize = 0

    dump(config, "config", 8)

    local packages = config.packages or {}
    --排序
    table.sort(packages, function(a,b)
        dump(a, "a")
        dump(b, "b")
        local result = compareVersion(a.ver, b.ver)
        print("result:,", result)
        if result < 0 then
            return true
        end
        return false
    end)
    local resVersion = self:getLocalResVersion()
    print(resVersion)
    if #packages > 0 then
        for j,v2 in ipairs(packages) do
            print("v2.ver:", v2.ver)
            if v2.ver > resVersion then
                self.m_dltotal = self.m_dltotal + v2.size
            end
        end
    end
    self.m_resVersion = resVersion

    print("m_dltotal:", self.m_dltotal)
end

function UpdateEngine:getLocalResVersion()
    local fileResVersion = Game:getAppConfig():getResVersion()
    local resVersion = Game:getSettingData():getResVersion()
    print("fileResVersion:", fileResVersion, "resVersion", resVersion)
    if resVersion == nil or string.len(resVersion) == 0 then
        resVersion = fileResVersion
        Game:getSettingData():setResVersion(resVersion)
    end
    return resVersion
end

function UpdateEngine:getProgress()
    if self.m_dltotal <= 0 then
        return 1
    end
    return self.m_dlsize/self.m_dltotal
end

function UpdateEngine:downloadPatches(isFirstUpdate, callback)
    --获取下个更新包
    if self.m_curDownVersion == nil then
        self.m_curDownVersion = self:getNextVersion(self.m_resVersion, self.m_updateConfig.packages)
    else
        self.m_curDownVersion = self:getNextVersion(self.m_curDownVersion, self.m_updateConfig.packages)
    end

    if self.m_curDownVersion == nil then
        if isFirstUpdate then
            callback({
                code = UpdateEventCode.NO_UPDATE_VERSIONS
            })
        else
            callback({
                code = UpdateEventCode.FINISH_UPDATE
            })
        end
        return
    end
    --下载版本
    callback({
        code = UpdateEventCode.SUB_UPDATE_GAME_START, dlver = self.m_curDownVersion
    })
    local package = self:getPkgByVersion(self.m_curDownVersion, self.m_updateConfig.packages)
    self:downloadPatch(self.m_dowloadPath .. "/update.zip", package, callback)
end

function UpdateEngine:downloadPatch(filename, package, callback)
    print(filename)
    dump(package, "package")
    --删掉旧文件
    if cc.FileUtils:getInstance():isFileExist(filename) then
        cc.FileUtils:getInstance():removeFile(filename)
    end
    -- --创建下载目录
    if not cc.FileUtils:getInstance():isDirectoryExist(self.m_dowloadPath)  then
        cc.FileUtils:getInstance():createDirectory(self.m_dowloadPath) 
    end
    if network.getInternetConnectionStatus() == cc.kCCNetworkStatusNotReachable then
        self:notifyCallBack({code = UpdateEventCode.ERROR_NETWORK})
        return
    end
    local request = network.createHTTPRequest(function(event)
        if self == nil or callback == nil then
            return
        end
        local request = event.request
        if event.name == "completed" then
            local code = request:getResponseStatusCode()
            if code ~= 200 and code ~= 304 then
                callback({
                    code = UpdateEventCode.ERROR_DOWNLOAD_UPDATE_FILE, dlfile = filename, errorCode = DLFileErrCode.ERROR_NETWORK
                })
                return
            end
            local times = 1
            while (not request:saveResponseData(filename)) and times < 10 do
                times = times + 1
            end
            if cc.FileUtils:getInstance():isFileExist(filename) then
                local filemd5 = crypto.md5file(filename)
                if filemd5 ~= package.MD5 then
                    callback({
                        code = UpdateEventCode.ERROR_DOWNLOAD_UPDATE_FILE, dlfile = filename, errorCode = DLFileErrCode.ERROR_MD5
                    })
                    return
                end
                if game.system.unZip(filename) then
                    
                    cc.UserDefault:getInstance():setStringForKey("res_version",self.m_curDownVersion)
                    cc.UserDefault:getInstance():flush()
                    self.m_resVersion = self.m_curDownVersion

                    callback({
                        code = UpdateEventCode.SUB_UPDATE_GAME_FINISHED
                    })
                else
                    callback({
                        code = UpdateEventCode.ERROR_DOWNLOAD_UPDATE_FILE,
                        dlfile = filename,
                        errorCode = DLFileErrCode.ERROR_UNZIP
                    })
                end
            else
                callback({
                    code = UpdateEventCode.ERROR_DOWNLOAD_UPDATE_FILE,
                    dlfile = filename,
                    errorCode = DLFileErrCode.ERROR_SAVE
                })
            end
        elseif event.name == "progress" then
            print("progress:", event.dltotal)
            callback({
                code = UpdateEventCode.SUB_UPDATE_GAME_PROGRESS,
                dltotal = event.dltotal
            })
        elseif event.name == "failed" then
            callback({
                code = UpdateEventCode.ERROR_DOWNLOAD_UPDATE_FILE, 
                dlfile = filename,
                errorCode = DLFileErrCode.ERROR_HTTP
            })
        end
    end, package.patch, "GET")
    request:setTimeout(60)
    request:start()
end

function UpdateEngine:downloadCallback(event)
    if type(event) ~= "table" then
        return
    end
    local eventCode = event.code
    if eventCode == UpdateEventCode.SUB_UPDATE_GAME_FINISHED then
        self.m_subdlsize = 0
        self:downloadPatches(false, handler(self, self.downloadCallback))
    elseif eventCode == UpdateEventCode.SUB_UPDATE_GAME_PROGRESS then
        local dltotal = event.dltotal or 0
        local dloffset = dltotal - self.m_subdlsize
        self.m_subdlsize = dltotal
        self.m_dlsize = self.m_dlsize + dloffset
        self.m_dltotal = self.m_dltotal or 100

        printInfo("下载进度更新, %.2f", self.m_dlsize/self.m_dltotal)
        printInfo("downloadedSize=%d, downloadTotal=%d", self.m_dlsize, self.m_dltotal)
    end

end

function UpdateEngine:startUpdate()
    self.m_downloadFinish = false
    if self.m_dltotal <= 0 then
        self.m_callback({ code = UpdateEventCode.NO_UPDATE_VERSIONS })
        self.m_downloadFinish = true
        return
    end
    self:startDownloadPatch()
end

function UpdateEngine:startDownloadPatch()
    self:downloadPatches(false, handler(self, self.downloadCallback))
end

return UpdateEngine