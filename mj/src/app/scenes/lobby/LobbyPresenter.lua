-- require("app.pb.Message_pb")
local Rx = require 'app.utils.rx'
local ByteArray = import("app.utils.ByteArray")
local Presenter = import("app.network.Presenter")


local LobbyPresenter = class("LobbyPresenter",function()
    return Presenter.new()
end)

function LobbyPresenter:ctor(view)
    Presenter.init(self, view)
    self:initHandlerMsg()
    self:initLobbySocket()
end

function LobbyPresenter:initLobbySocket()
    Game:getSocketMgr():setLobbyListener(self)
    Game:getSocketMgr():lobbySocketConnect()
end

function LobbyPresenter:onConnected()
    print("onConnected")
end

function LobbyPresenter:onClosed()
    
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

    self.m_handlerTable[D2L_PLAYER_PLAYER_TOTALINFO_ACK] = handler(self, self.d2l_player_player_totalinfo_ack)

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

return LobbyPresenter