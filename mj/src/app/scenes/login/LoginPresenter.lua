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
    -- pushEvent
    Game:getEventDispatcher().pushEvent(AppGlobal.EventMsg.SPEAKER_POP_UP, { data = "data" })
    print("LoginPresenter:toLogin:", C2L_PLAYER_LOGIN_SYN)
    local msg = Message_pb.MSG_C2L_PLAYER_LOGIN_SYN()
    msg.messageID = C2L_PLAYER_LOGIN_SYN
    msg.openid = "1"
    msg.accesstoken = ""
    msg.nickname= "test1"
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

    print("L2C_PLAYER_LOGIN_ACK:", L2C_PLAYER_LOGIN_ACK)

    self.m_handlerTable[L2C_PLAYER_LOGIN_ACK] = handler(self, self.l2c_player_login_ack)
    self.m_handlerTable[L2C_PLAYER_BASEINFO_ACK] = handler(self, self.l2c_player_baseinfo_ack)
    self.m_handlerTable[L2C_PLAYER_GAME_ROOM_CONFIG_ACK] = handler(self, self.l2c_player_game_room_config_ack)
end

--
function LoginPresenter:l2c_player_login_ack(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_LOGIN_ACK()
	msg:ParseFromString(msgData)

	print("msg.messageID", msg.messageID)
	print("msg.errorcode", msg.errorcode)
	print(string.format("msg.clienttoken=%d", msg.clienttoken))

    if msg.errorcode == -2 then
        -- Game:getSocketMgr():loginSocketClose()
    end
end

-- message MSG_L2C_PLAYER_BASEINFO_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional PlayerBaseInfo playerInfo = 2;
-- 	optional uint32 userstate = 3;
-- }

-- message PlayerBaseInfo 
-- {
-- 	optional uint64  player_id = 1;
-- 	optional string name = 2;
-- 	optional uint32  level = 3;
-- 	optional uint32  exp = 4;
-- 	optional string accountId = 5;
-- 	optional uint32	goldCoin = 6;
-- 	optional uint32	diamond = 7;
-- 	optional uint32	vip = 8;
-- 	optional int64	registerDate = 9;
-- 	optional string password = 10;
-- 	optional uint32 sex = 11;
-- }


function LoginPresenter:l2c_player_baseinfo_ack(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_BASEINFO_ACK()
    msg:ParseFromString(msgData)

    print("msg.messageID", msg.messageID)

    local v = msg.playerInfo

    print(v.player_id, v.name, v.level, v.exp, v.accountId, v.goldCoin, v.diamond, v.vip, v.registerDate, v.password, v.sex )
    
    
    -- Message_pb.PlayerBaseInfo() baseInfo = 
    print(string.format("msg.userstate=%d", msg.userstate))
end

-- message MSG_L2C_PLAYER_GAME_ROOM_CONFIG_ACK
-- {
-- 	required int32 messageID = 1;
-- 	repeated ROOM_CONFIG room_config = 2;
-- }

-- message ROOM_CONFIG
-- {
-- 	required int32 kindid = 1;
-- 	required string name = 2;
-- 	required int32 ownerpay_junum = 3;
-- 	required int32 ownerpay_diamond = 4;
-- 	required int32 aapay_junum = 5;
-- 	required int32 aapay_diamond = 6;
-- }

-- message ROOM_CONFIG
-- {
-- 	required int32 kindid = 1;
-- 	required string name = 2;
-- 	required string config = 3;
-- }

function LoginPresenter:l2c_player_game_room_config_ack(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_GAME_ROOM_CONFIG_ACK()
    msg:ParseFromString(msgData)
    print("msg.messageID", msg.messageID)

    print(type(msg.room_config))
    dump(msg.room_config, "sss", 8)
    -- local v = msg.room_config
    for _, v in ipairs(msg.room_config) do
		print(v.kindid)
		print(v.name)
		print(v.config)
	end

end

function LoginPresenter:startLoadResTimeout()
    
end

return LoginPresenter