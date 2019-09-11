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

-- //客户端请求游戏服务器消息
-- 	C2M_PLAYER_ENTER_GAME_ROOM_SYN							= 21001;		//请求进入游戏房间
-- 	C2M_PLAYER_RECONNECT_GAME_SYN							= 21002;		//断线重连
-- 	C2M_PLAYER_SIT_DOWN_SYN									= 21003;		//请求坐下
-- 	C2M_PLAYER_READY_SYN									= 21004;		//玩家准备
-- 	C2M_PLAYER_LEAVE_ROOM_SYN								= 21005;		//玩家离开
-- 	C2M_PLAYER_DISMISS_ROOM_SYN								= 21006;		//请求房间解散
-- 	C2M_PLAYER_VOTE_SYN										= 21007;		//玩家解散投票
-- 	C2M_PLAYER_OUT_CARD_SYN									= 21008;		//玩家出牌
-- 	C2M_PLAYER_OPERATE_RESULT_SYN							= 21009;		//操作命令
-- 	C2M_PLAYER_TRUSTEE_SYN									= 21010;		//玩家托管
-- //--------------------------------------------------------------------------------------------------------------------------------------


-- message MSG_D2L_PLAYER_PLAYER_TOTALINFO_ACK
-- {
-- 	required int32 messageID = 1;
-- 	required int32 errorcode = 2;
-- 	required PlayerTotalInfo playerInfo = 3;
-- 	required uint64 clientid = 4;
-- }


return CardPresenter