local Presenter = import("app.network.Presenter")
local Message_Def = import("app.pb.Message_Def")

local AsyncRes = {
    "LoginRes",
    "ComRes",
    "LobMainRoomRes"
}

local LoginPresenter = class("LoginPresenter",function()
    return Presenter.new()
end)

function LoginPresenter:ctor(view)
    Presenter.init(self, view)
    self:initHandlerMsg()
    self:initLoginSocket()
end

function LoginPresenter:initLoginSocket()
    Game:getSocketMgr():setLoginListener(self)
    Game:getSocketMgr():loginSocketConnect()
end

function LoginPresenter:onConnected()
    
end

function LoginPresenter:onClosed()
    print("socket:onClosed")
    -- self:preloadRes()
end

function LoginPresenter:toLogin()
    -- pushEvent
    -- Game:getEventDispatcher().pushEvent(AppGlobal.EventMsg.SPEAKER_POP_UP, { data = "data" })
    
    local msg = {}
    msg.openid = "1"
    msg.accesstoken = ""
    msg.nickname = "test1"
    msg.sex = 0
    
    local data, msgId = Message_Def:C2L_PLAYER_LOGIN_SYN(msg)

    Game:getSocketMgr():loginSocketSend(data, msgId)
end

function LoginPresenter:preloadRes()
    
    local resNum = #AsyncRes
    local curNum = 0
    
    --异步回调
    local callback = function ()
        curNum =  curNum + 1
        print("加载"..AsyncRes[curNum]..".pvr.ccz")
        display.addSpriteFrames(AsyncRes[curNum]..".plist",AsyncRes[curNum]..".pvr.ccz")
        if curNum == resNum and self then
            print("异步图片加载完成")
            -- self:beginLoginGame()
            Game:getSceneMgr():goLobbyScene()
        end
    end
    if #AsyncRes > 0 then
        self:startLoadResTimeout()
    end

    for i,v in ipairs(AsyncRes) do
        display.addImageAsync(v..".pvr.ccz",callback)
    end
end

function LoginPresenter:initHandlerMsg()
    self.m_handlerTable = {}

    self.m_handlerTable[L2C_PLAYER_LOGIN_ACK] = handler(self, self.l2c_player_login_ack)
    self.m_handlerTable[L2C_PLAYER_BASEINFO_ACK] = handler(self, self.l2c_player_baseinfo_ack)
    self.m_handlerTable[L2C_PLAYER_GAME_ROOM_CONFIG_ACK] = handler(self, self.l2c_player_game_room_config_ack)
end

function LoginPresenter:l2c_player_login_ack(msgData)
    local data = Message_Def:L2C_PLAYER_LOGIN_ACK(msgData)
    dump(data, "L2C_PLAYER_LOGIN_ACK")

    if data.errorcode == nil then
        self:preloadRes()
    end
end

function LoginPresenter:l2c_player_baseinfo_ack(msgData)
    local data = Message_Def:L2C_PLAYER_BASEINFO_ACK(msgData)
    dump(data, "L2C_PLAYER_BASEINFO_ACK")
    
end

function LoginPresenter:l2c_player_game_room_config_ack(msgData)
    local data = Message_Def:L2C_PLAYER_GAME_ROOM_CONFIG_ACK(msgData)
    dump(data, "L2C_PLAYER_GAME_ROOM_CONFIG_ACK")

end

function LoginPresenter:startLoadResTimeout()
    
end

return LoginPresenter