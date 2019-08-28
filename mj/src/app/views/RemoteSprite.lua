require("lfs")

UserMD5Data = {}

local RemoteSprite = class("RemoteSprite", function ()
    return display.newSprite()--display.newNode()
end)

--[[ {
    defaultImg 
    size = cc.size()
    userId,
}]]
function RemoteSprite:ctor(params)
    --本地存储目录
    self.m_path = device.writablePath.."user/"
    if not io.exists(self.m_path) then
        lfs.mkdir(self.m_path)
    end
    self.m_size = params.size
    self:setContentSize(self.m_size)
    self.m_url = Game:getAppConfig():getUserImgPicDownUrl(params.userId)
    local imageName = self:getUserMD5(params.userId)
    local bExist = cc.FileUtils:getInstance():isFileExist(imageName)
    if bExist then
        self:updateTexture(imageName)
    else
        self:updateTexture(params.defaultImg)
        -- self:updateTexture(params.defaultImg)
    end
    self.m_userId = params.userId
    self:createSprite()
end

function RemoteSprite:createSprite()
    local bExist, fileName = self:getUserUrlMd5()
    if not bExist then
        --如果不存在，启动http下载
		if network.getInternetConnectionStatus() == cc.kCCNetworkStatusNotReachable then
			print("have not reachable net~")
			return
		end
		local request = network.createHTTPRequest(function(event)
            if self == nil or self.onRequestFinished == nil then
                return
            end
            self:onRequestFinished(event,fileName)
        end, self.m_url, "GET")
		request:start()
    end
end

function RemoteSprite:getUserMD5(userId)
    return Game:getAppConfig():getLocalUserImage(userId)
end

function RemoteSprite:getUserUrlMd5()
    local md5 = self:getUserMD5(self.m_userId)
    --判断本地保存数据是否存在
    if UserMD5Data.netSprite == nil then
        UserMD5Data.netSprite = {}
    else
        for i,v in ipairs(UserMD5Data.netSprite) do
            if v == md5 then
                return true, self.m_path .. md5
            end
        end
    end
    --不存在, 返回将要存储的文件路径
    return false, self.m_path .. md5
end

function RemoteSprite:setUserUrlMd5(overtime)
    --如果不是超时
    if not overtime then
        table.insert(UserMD5Data, self:getUserMD5(self.m_userId))
    end
end

function RemoteSprite:onRequestFinished(event,fileName)
    local ok = (event.name == "completed")
    local request = event.request
    if not ok then
        return
    end

    local code = request:getResponseStatusCode()
    if code ~= 200 then
        -- 请求结束，但没有返回 200 响应代码
        print(request:getErrorCode(),request:getErrorMessage())
        return
    end
    -- 请求成功，显示服务端返回的内容
    local response = request:getResponseString()
    --保存下载数据到本地文件，如果不成功，重试30次。
    local times = 1
    local ret = request:saveResponseData(fileName)
    while ret == 0 and times < 30 do
    	ret = request:saveResponseData(fileName)
    	times = times + 1
    end
    --是否超时
    local isOvertime = (times == 30)
    --保存md5
    self:setUserUrlMd5(isOvertime)
    --重新加载图片
    cc.Director:getInstance():getTextureCache():reloadTexture(fileName)
    --更新纹理
    self:updateTexture(fileName)
end

function RemoteSprite:updateTexture(filename)
    -- local sprite = display.newSprite(filename)
    -- if not sprite then
    --     return
    -- end
    -- --
    -- local newsize = sprite:getContentSize()
    -- local oldsize = self.m_size
    -- sprite:setScale(oldsize.width/newsize.width, oldsize.height/newsize.height)
    -- self:removeAllChildren()
    -- sprite:align(display.BOTTOM_LEFT, 0, 0):addTo(self)
    self:setSpriteFrame(filename)
    local newsize = self:getContentSize()
    local oldsize = self.m_size
    self:setScale(oldsize.width/newsize.width,oldsize.height/newsize.height)
end

-- function RemoteSprite:updateTexture(fileName)

-- 	local sprite = display.newSprite(fileName) --创建下载成功的sprite
-- 	if not sprite then return end
-- 	local texture = sprite:getTexture()--获取纹理
-- 	local size = texture:getContentSize()
-- 	local oldSize = cc.size(self:getBoundingBox().width,self:getBoundingBox().height)
-- 	self:setTexture(texture)--更新自身纹理
-- 	self:setContentSize(size)
-- 	self:setTextureRect(cc.rect(0,0,size.width,size.height))
	
-- 	self:setScale(oldSize.width/size.width,oldSize.height/size.height)

-- end

return RemoteSprite