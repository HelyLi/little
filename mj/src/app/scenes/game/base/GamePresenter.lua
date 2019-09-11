-- local Rx = require 'app.utils.rx'
local ByteArray = import("app.utils.ByteArray")
local Presenter = import("app.network.Presenter")


local GamePresenter = class("GamePresenter",function()
    return Presenter.new()
end)

function GamePresenter:ctor(view)
    Presenter.init(self, view)
    self:initHandlerMsg()
    self:initCardGameSocket()
end

function GamePresenter:initCardGameSocket()
    Game:getSocketMgr():setCardGameListener(self)
    Game:getSocketMgr():cardGameSocketConnect()
end

function GamePresenter:onConnected()
    print("onConnected")
end

function GamePresenter:onClosed()
    
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

function GamePresenter:initHandlerMsg()
    self.m_handlerTable = {}

    self.m_handlerTable[M2C_PLAYER_ENTER_GAME_ROOM_SYN] = handler(self, self.m2c_player_enter_game_room_syn)
    self.m_handlerTable[M2C_PLAYER_ENTER_GAME_ROOM_SYN] = handler(self, self.m2c_player_enter_game_room_syn)
    self.m_handlerTable[M2C_PLAYER_ENTER_GAME_ROOM_SYN] = handler(self, self.m2c_player_enter_game_room_syn)
    self.m_handlerTable[M2C_PLAYER_ENTER_GAME_ROOM_SYN] = handler(self, self.m2c_player_enter_game_room_syn)
    self.m_handlerTable[M2C_PLAYER_ENTER_GAME_ROOM_SYN] = handler(self, self.m2c_player_enter_game_room_syn)
    self.m_handlerTable[M2C_PLAYER_ENTER_GAME_ROOM_SYN] = handler(self, self.m2c_player_enter_game_room_syn)
    self.m_handlerTable[M2C_PLAYER_ENTER_GAME_ROOM_SYN] = handler(self, self.m2c_player_enter_game_room_syn)
    self.m_handlerTable[M2C_PLAYER_ENTER_GAME_ROOM_SYN] = handler(self, self.m2c_player_enter_game_room_syn)
    self.m_handlerTable[M2C_PLAYER_ENTER_GAME_ROOM_SYN] = handler(self, self.m2c_player_enter_game_room_syn)
    self.m_handlerTable[M2C_PLAYER_ENTER_GAME_ROOM_SYN] = handler(self, self.m2c_player_enter_game_room_syn)
    
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

-- function GamePresenter:C2M_PLAYER_ENTER_GAME_ROOM_SYN()
    

-- end

-- 	M2C_PLAYER_ENTER_GAME_ROOM_SYN							= 22001;			//请求进入游戏房间成功
-- 	M2C_PLAYER_RECONNECT_GAME_ACK							= 22002;			//重连成功
-- 	M2C_PLAYER_BASEINFO_ACK									= 22003;			//玩家的基本信息
-- 	M2C_PLAYER_ROOM_BASEINFO_ACK							= 22004;			//桌子的基本信息
-- 	M2C_PLAYER_ROOM_FREE_SCENE_ACK							= 22005;			//桌子空闲场景消息
-- 	M2C_PLAYER_ROOM_PLAYING_SCENE_ACK						= 22006;			//桌子战斗场景消息
-- 	M2C_PLAYER_STATE_UPDATA_ACK								= 22007;			//玩家状态更新
-- 	M2C_PLAYER_ROOM_STATE_UPDATA_ACK						= 22008;			//桌子状态更新
-- 	M2C_PLAYER_SIT_DOWN_ACK									= 22009;			//玩家坐下成功
-- 	M2C_PLAYER_READY_ACK									= 22010;			//玩家准备成功
-- 	M2C_PLAYER_OPER_LEAVE_ROOM_ACK							= 22011;			//玩家离开成功
-- 	M2C_PLAYER_DISMISS_ROOM_ACK								= 22012;			//玩家解散房间成功
-- 	M2C_PLAYER_VOTE_SYN										= 22013;			//玩家投票成功
-- 	M2C_PLAYER_GAME_START_ACK								= 22014;			//游戏开始
-- 	M2C_PLAYER_MONEY_UPDATA_ACK								= 22015;			//货币更新
-- 	M2C_PLAYER_OPERATE_NOTIFY_ACK							= 22016;			//操作提示
-- 	M2C_PLAYER_OPERATE_RESULT_ACK							= 21017;			//操作命令
-- 	M2C_SUB_GAME_END_ACK									= 21018;			//游戏结束
-- 	M2C_SUB_GAME_END_ALL_ACK								= 21019;			//所有游戏结束




return GamePresenter