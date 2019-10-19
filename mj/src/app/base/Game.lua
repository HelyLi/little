require("config")
require("cocos.init")
require("framework.init")

Game = {
    --游戏配置
    m_appConfig = nil,
    --本地设置
    m_settingData = nil,
    --用户信息
    m_userData = nil,
    --游戏玩法信息
    m_gameData = nil,
    --事件处理
    m_eventDispatch = nil,
    --场景管理
    m_sceneMgr = nil,
    --socket管理
    m_socketMgr = nil,
    --音效管理
    m_audioMgr = nil
}

local Modules = {
    -- "app.utils.rx",
    -- "pack",
    "app.utils.utf8",
    "app.utils.DataStruct",
    "app.utils.SimpleApi",
    "app.base.UIAdapter",
    "app.utils.ByteArray",
    "app.config.AppGlobal",
    "app.views.Comui",
    "app.native.System",
    "app.utils.bitOp",
    "app.native.NativeApi",
    "app.native.System",
    "app.native.WeChat"
}

function Game:init()
    self:clear()
    self:reloadModules()
    self.m_appConfig = require("app.config.AppConfig").new()
    self.m_eventDispatch = require("app.utils.PushCenter")
    self.m_settingData = require("app.data.SettingData").new()
    self.m_userData = require("app.data.UserData").new()
    self.m_gameData = require("app.data.GameData").new()
    self.m_sceneMgr = require("app.base.SceneMgr").new()
    self.m_socketMgr = require("app.network.socket.SocketMgr").new()
    self.m_audioMgr = require("app.base.AudioMgr").new()
end

function Game:clear()
    self.m_appConfig = nil
    self.m_eventDispatch = nil
    self.m_settingData = nil
    self.m_userData = nil
    self.m_gameData = nil
    self.m_sceneMgr = nil
    self.m_socketMgr = nil
    self.m_audioMgr = nil
end

function Game:getAppConfig()
    return self.m_appConfig
end

function Game:getEventDispatcher()
    return self.m_eventDispatch
end

function Game:getSettingData()
    return self.m_settingData
end

function Game:getUserData()
    return self.m_userData
end

function Game:getGameData()
    return self.m_gameData
end

function Game:getSceneMgr()
    return self.m_sceneMgr
end

function Game:getSocketMgr()
    return self.m_socketMgr
end

function Game:getAudioMgr()
    return self.m_audioMgr
end

function Game:loadModules()
    for _,module in ipairs(Modules) do
        require(module)
    end
end

function Game:reloadModules()
    for _,module in ipairs(Modules) do
        package.loaded[module] = nil
        package.preload[module] = nil
        require(module)
    end
end

return Game