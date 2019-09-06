-- local Rx = require 'app.utils.rx'
local ByteArray = import("app.utils.ByteArray")
local Presenter = import("app.network.Presenter")


local CardPresenter = class("CardPresenter",function()
    return Presenter.new()
end)

function CardPresenter:ctor(view)
    Presenter.init(self, view)
    self:initHandlerMsg()
    self:initCardGameSocket()
end

function CardPresenter:initCardGameSocket()
    Game:getSocketMgr():setCardGameListener(self)
    Game:getSocketMgr():cardGameSocketConnect()
end

function CardPresenter:onConnected()
    print("onConnected")
end

function CardPresenter:onClosed()
    
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

-- MSG_L2D_PLAYER_LOGIN_SYN

-- L2D_PLAYER_LOGIN_SYN = 10008
-- D2L_PLAYER_PLAYER_TOTALINFO_ACK = 10009
-- L2D_PLAYERINFO_UPDATE_SYN = 10012

function CardPresenter:initHandlerMsg()
    self.m_handlerTable = {}

    -- self.m_handlerTable[D2L_PLAYER_PLAYER_TOTALINFO_ACK] = handler(self, self.d2l_player_player_totalinfo_ack)

end

-- message MSG_D2L_PLAYER_PLAYER_TOTALINFO_ACK
-- {
-- 	required int32 messageID = 1;
-- 	required int32 errorcode = 2;
-- 	required PlayerTotalInfo playerInfo = 3;
-- 	required uint64 clientid = 4;
-- }


return CardPresenter