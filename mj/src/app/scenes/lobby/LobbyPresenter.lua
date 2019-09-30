-- require("app.pb.Message_pb")
local Rx = require 'app.utils.rx'
local ByteArray = import("app.utils.ByteArray")
local Presenter = import("app.network.Presenter")
local Message_Def = import("app.pb.Message_Def")

local LobbyPresenter = class("LobbyPresenter",function()
    return Presenter.new()
end)

function LobbyPresenter:ctor(view)
    Presenter.init(self, view)
    self:initHandlerMsg()
    self:initLobbySocket()
    self.m_enterRoom = false
end

function LobbyPresenter:initLobbySocket()
    Game:getSocketMgr():setLobbyListener(self)
    Game:getSocketMgr():lobbySocketConnect()
end

function LobbyPresenter:onConnected()
    print("onConnected")
    self:toLogin()
end

function LobbyPresenter:onClosed()
    if self.m_enterRoom == true then
        self.m_enterRoom = false
        self.m_view:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function ()
            Game:getSceneMgr():goCardGameScene()
        end)))
    end
end
-- message MSG_L2D_PLAYER_LOGIN_SYN
-- {
-- 	required int32 messageID = 1;
-- 	required uint64 clientid = 2;
-- 	required string openid = 3;
-- 	required string accesstoken = 4;
-- 	required string nickname = 5;
-- 	required int32 sex = 6;
-- }
function LobbyPresenter:MSG_L2D_PLAYER_LOGIN_SYN()
    print("LobbyPresenter:MSG_L2D_PLAYER_LOGIN_SYN:", L2D_PLAYER_LOGIN_SYN)
    local msg = Message_pb.MSG_L2D_PLAYER_LOGIN_SYN()
    msg.messageID = L2D_PLAYER_LOGIN_SYN
    msg.clientid = 100002
    msg.openid = "1111111111111111111"
    msg.accesstoken = "22222222222222222222"
    msg.nickname= "test"
    msg.sex = 0
    
    local data = msg:SerializeToString()

    print(string.len(data))

    Game:getSocketMgr():lobbySocketSend(data, L2D_PLAYER_LOGIN_SYN)
end

-- MSG_L2D_PLAYER_LOGIN_SYN

-- L2D_PLAYER_LOGIN_SYN = 10008
-- D2L_PLAYER_PLAYER_TOTALINFO_ACK = 10009
-- L2D_PLAYERINFO_UPDATE_SYN = 10012

function LobbyPresenter:initHandlerMsg()
    self.m_handlerTable = {}

    self.m_handlerTable[L2C_PLAYER_LOGIN_ACK] = handler(self, self.l2c_player_login_ack)
    self.m_handlerTable[L2C_PLAYER_BASEINFO_ACK] = handler(self, self.l2c_player_baseinfo_ack)
    self.m_handlerTable[L2C_PLAYER_GAME_ROOM_CONFIG_ACK] = handler(self, self.l2c_player_game_room_config_ack)
    self.m_handlerTable[D2L_PLAYER_PLAYER_TOTALINFO_ACK] = handler(self, self.d2l_player_player_totalinfo_ack)
    self.m_handlerTable[L2C_PLAYER_CREATE_ROOM_ACK] = handler(self, self.l2c_player_create_room_ack)
end

function LobbyPresenter:toLogin()
    -- pushEvent
    -- Game:getEventDispatcher().pushEvent(AppGlobal.EventMsg.SPEAKER_POP_UP, { data = "data" })
    -- WeChat.doLogin()
    -- comui.addWaitingLayer()

    local msg = {}
    msg.openid = "2"
    msg.accesstoken = ""
    msg.nickname = "test1"
    msg.sex = 0
    
    local msg, msgId = Message_Def:C2L_PLAYER_LOGIN_SYN(msg)

    -- local data = {
    --     roomId = 999040,
    --     token  = 1568560920023,
    --     userId = 10001,
    --     }
        

    -- local msg, msgId = Message_Def:C2M_PLAYER_ENTER_GAME_ROOM_SYN(data)

    Game:getSocketMgr():lobbySocketSend(msg, msgId)
end

function LobbyPresenter:serviceTest()
    local data = {
        roomId = 999040,
        token  = 1568560920023,
        userId = 10001,
    }

    local msg, msgId = Message_Def:C2M_PLAYER_ENTER_GAME_ROOM_SYN(data)

    Game:getSocketMgr():lobbySocketSend(msg, msgId)
end

-- message MSG_D2L_PLAYER_PLAYER_TOTALINFO_ACK
-- {
-- 	required int32 messageID = 1;
-- 	required int32 errorcode = 2;
-- 	required PlayerTotalInfo playerInfo = 3;
-- 	required uint64 clientid = 4;
-- }

function LobbyPresenter:d2l_player_player_totalinfo_ack(msgData)
    local msg = Message_pb.MSG_D2L_PLAYER_PLAYER_TOTALINFO_ACK()
    msg:ParseFromString(msgData)

    print("msg.messageID", msg.messageID)
	print("msg.errorcode", msg.errorcode)
	print("msg.clientid", msg.clientid)

end

function LobbyPresenter:l2c_player_login_ack(msgData)
    local data = Message_Def:L2C_PLAYER_LOGIN_ACK(msgData)
    dump(data, "L2C_PLAYER_LOGIN_ACK")

    if data.errorcode == nil then
        print(string.format("token:%u", data.clienttoken))
        Game:getUserData():setToken(data.clienttoken)
        
        -- self:preloadRes()
    end
end

function LobbyPresenter:l2c_player_baseinfo_ack(msgData)
    local data = Message_Def:L2C_PLAYER_BASEINFO_ACK(msgData)
    dump(data, "L2C_PLAYER_BASEINFO_ACK", 8)
    
  

    Game:getUserData():setPlayerInfo(data.playerInfo)

end

function LobbyPresenter:l2c_player_game_room_config_ack(msgData)
    local data = Message_Def:L2C_PLAYER_GAME_ROOM_CONFIG_ACK(msgData)
    dump(data, "L2C_PLAYER_GAME_ROOM_CONFIG_ACK")

    Game:getGameData():getCreateRoomInfo():decodeCardRoomInfo(data)
    
end

-- - "L2C_PLAYER_CREATE_ROOM_ACK" = {
--         "gameip"    = "47.94.233.203"
--         "gameport"  = 9000
--         "messageID" = 11004
--         "ownerid"   = 10001
--         "roomid"    = 756608
--     }

function LobbyPresenter:l2c_player_create_room_ack(msgData)
    print("l2c_player_create_room_ack")
    local data = Message_Def:L2C_PLAYER_CREATE_ROOM_ACK(msgData)
    dump(data, "L2C_PLAYER_CREATE_ROOM_ACK")

    if data.errorcode == nil then
        Game:getSocketMgr():lobbySocketClose()
        Game:getGameData():setCreateRoomAck(data)
        self.m_enterRoom = true
    end

    -- data = {
    --         gameip    = "47.94.233.203",
    --         gameport  = 9000,
    --         messageID = 11004,
    --         ownerid   = 10001,
    --         roomid    = 544384,
    --     }

    --     Game:getSocketMgr():lobbySocketClose()
    --     Game:getGameData():setCreateRoomAck(data)
    --     self.m_enterRoom = true
    
end

return LobbyPresenter