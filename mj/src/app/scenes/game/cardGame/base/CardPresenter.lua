-- local Rx = require 'app.utils.rx'
-- local ByteArray = import("app.utils.ByteArray")

local GamePresenter = import("app.scenes.game.base.GamePresenter")

local CardPresenter = class("CardPresenter",GamePresenter)

function CardPresenter:ctor(view)
    CardPresenter.super.ctor(self, view)
end
-- - "L2C_PLAYER_CREATE_ROOM_ACK" = {
--         "gameip"    = "47.94.233.203"
--         "gameport"  = 9000
--         "messageID" = 11004
--         "ownerid"   = 10001
--         "roomid"    = 756608
--     }
function CardPresenter:initCardGameSocket()
    Game:getSocketMgr():setCardGameListener(self)
    local ack = Game:getGameData():getCreateRoomAck()
    dump(ack, "initCardGameSocket")
    Game:getSocketMgr():cardGameSocketConnect(ack.gameip, ack.gameport)
end
-- function Message_Def:C2M_PLAYER_ENTER_GAME_ROOM_SYN(data)
--     local msg = Message_pb.MSG_C2M_PLAYER_ENTER_GAME_ROOM_SYN()
--     msg.messageID = C2M_PLAYER_ENTER_GAME_ROOM_SYN
--     msg.roomid = data.roomId
--     msg.token = data.token
--     msg.playerid = data.userI
function CardPresenter:onConnected()
    print("CardPresenter.onConnected")
    local ack = Game:getGameData():getCreateRoomAck()
    local data = {}
    data.roomId = ack.roomid
    data.token = Game:getUserData():getToken()
    data.userId = ack.ownerid

    dump(data, "onConnected")

    local msg, msgId = Message_Def:C2M_PLAYER_ENTER_GAME_ROOM_SYN(data)
    Game:getSocketMgr():cardGameSocketSend(msg, msgId)
end



return CardPresenter