require("app.pb.Message_pb")
local ByteArray = import("app.utils.ByteArray")
local Presenter = import("app.network.Presenter")

local AsyncRes = {
    "LoginRes"
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
    self:preloadRes()
end
-- message MSG_L2D_PLAYER_LOGIN_SYN
-- {
--  required int32 messageID = 1;
--  required uint64 clientid = 2;
--  required string openid = 3;
--  required string accesstoken = 4;
--  required string nickname = 5;
--  required int32 sex = 6;
-- }

-- message MSG_C2L_PLAYER_LOGIN_SYN
-- {
-- 	optional int32 messageID = 1;
-- 	optional string openid = 2;
-- 	optional string accesstoken = 3;
-- 	optional string nickname = 4;
-- 	optional int32 sex = 5;
-- }

function LoginPresenter:toLogin()
    print("LoginPresenter:toLogin:", C2L_PLAYER_LOGIN_SYN)
    local msg = Message_pb.MSG_C2L_PLAYER_LOGIN_SYN()
    msg.messageID = C2L_PLAYER_LOGIN_SYN
    msg.openid = "1111111111111111111"
    msg.accesstoken = "22222222222222222222"
    msg.nickname= "test"
    msg.sex = 0
    
    local data = msg:SerializeToString()

    Game:getSocketMgr():loginSocketSend(data, C2L_PLAYER_LOGIN_SYN)
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
end

function LoginPresenter:l2c_player_login_ack(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_LOGIN_ACK()
	msg:ParseFromString(msgData)

	print("msg.messageID", msg.messageID)
	print("msg.errorcode", msg.errorcode)
	print("msg.clienttoken", msg.clienttoken)

    if msg.errorcode == -2 then
        -- Game:getSocketMgr():loginSocketClose()
    end
end

function LoginPresenter:startLoadResTimeout()
    
end

return LoginPresenter