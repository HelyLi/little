local ByteArray = import("app.utils.ByteArray")
local Presenter = import("app.network.Presenter")

local GamePresenter = class("GamePresenter",function()
    return Presenter.new()
end)

function GamePresenter:ctor()
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

function GamePresenter:initHandlerMsg()
    self.m_handlerTable = {}

    self.m_handlerTable[M2C_PLAYER_ENTER_GAME_ROOM_ACK] = handler(self, self.M2C_PLAYER_ENTER_GAME_ROOM_ACK)
    self.m_handlerTable[M2C_PLAYER_RECONNECT_GAME_ACK] = handler(self, self.M2C_PLAYER_RECONNECT_GAME_ACK)
    self.m_handlerTable[M2C_PLAYER_BASEINFO_ACK] = handler(self, self.M2C_PLAYER_BASEINFO_ACK)
    self.m_handlerTable[M2C_PLAYER_ROOM_BASEINFO_ACK] = handler(self, self.M2C_PLAYER_ROOM_BASEINFO_ACK)
    self.m_handlerTable[M2C_TABLE_PLAYER_INFO_NOTIFY] = handler(self, self.M2C_TABLE_PLAYER_INFO_NOTIFY) 
    self.m_handlerTable[M2C_PLAYER_ROOM_FREE_SCENE_ACK] = handler(self, self.M2C_PLAYER_ROOM_FREE_SCENE_ACK)
    self.m_handlerTable[M2C_PLAYER_ROOM_PLAYING_SCENE_ACK] = handler(self, self.M2C_PLAYER_ROOM_PLAYING_SCENE_ACK)
    self.m_handlerTable[M2C_PLAYER_STATE_UPDATA_ACK] = handler(self, self.M2C_PLAYER_STATE_UPDATA_ACK)
    self.m_handlerTable[M2C_PLAYER_ROOM_STATE_UPDATA_ACK] = handler(self, self.M2C_PLAYER_ROOM_STATE_UPDATA_ACK)
    self.m_handlerTable[M2C_PLAYER_SIT_DOWN_ACK] = handler(self, self.M2C_PLAYER_SIT_DOWN_ACK)
    self.m_handlerTable[M2C_PLAYER_READY_ACK] = handler(self, self.M2C_PLAYER_READY_ACK)
    self.m_handlerTable[M2C_PLAYER_OP_ACK] = handler(self, self.M2C_PLAYER_OP_ACK)
    self.m_handlerTable[M2C_PLAYER_DISMISS_ROOM_ACK] = handler(self, self.M2C_PLAYER_DISMISS_ROOM_ACK)
    self.m_handlerTable[M2C_PLAYER_VOTE_ACK] = handler(self, self.M2C_PLAYER_VOTE_ACK)
    self.m_handlerTable[M2C_PLAYER_GAME_START_ACK] = handler(self, self.M2C_PLAYER_GAME_START_ACK)
    self.m_handlerTable[M2C_PLAYER_MONEY_UPDATA_ACK] = handler(self, self.M2C_PLAYER_MONEY_UPDATA_ACK)
    self.m_handlerTable[M2C_PLAYER_OPERATE_NOTIFY_ACK] = handler(self, self.M2C_PLAYER_OPERATE_NOTIFY_ACK)
    self.m_handlerTable[M2C_PLAYER_OPERATE_RESULT_ACK] = handler(self, self.M2C_PLAYER_OPERATE_RESULT_ACK)
    self.m_handlerTable[M2C_SUB_GAME_END_ACK] = handler(self, self.M2C_SUB_GAME_END_ACK)
    self.m_handlerTable[M2C_SUB_GAME_END_ALL_ACK] = handler(self, self.M2C_SUB_GAME_END_ALL_ACK)
    
end

--请求进入游戏房间成功
-- message MSG_M2C_PLAYER_ENTER_GAME_ROOM_ACK
-- {
-- 	repeated int32	messageID = 1;
-- 	repeated int32	errorcode = 2;
-- 	repeated int32 	roomid = 3;
-- 	repeated uint64  tokenid = 4;
-- 	repeated int32   userstate = 5;
-- 	repeated int32 	playerid = 6;
-- }
function GamePresenter:M2C_PLAYER_ENTER_GAME_ROOM_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_ENTER_GAME_ROOM_ACK(msgData)
    dump(data, "--->>> 请求进入游戏房间成功")
end

--重连成功
-- message MSG_M2C_PLAYER_RECONNECT_GAME_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 errorcode = 2;
-- }
function GamePresenter:M2C_PLAYER_RECONNECT_GAME_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_RECONNECT_GAME_ACK(msgData)
    dump(data, "--->>> 重连成功")
end

--玩家的基本信息
-- message MSG_M2C_PLAYER_BASEINFO_ACK
-- {
-- 	optional int32 messageid = 1;
-- 	optional int32 infotype = 2; //1:自己的信息   2：其他玩家
-- 	optional bool online = 3;	//玩家是否在线
-- 	optional USER_STATE state = 4;	//玩家状态
-- 	optional PlayerBaseInfo baseinfo =5;
-- }
function GamePresenter:M2C_PLAYER_BASEINFO_ACK()
    local data = Message_Def:M2C_PLAYER_BASEINFO_ACK(msgData)
    dump(data, "--->>> 玩家的基本信息")
end

--桌子的基本信息
-- message MSG_M2C_PLAYER_ROOM_BASEINFO_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional uint32 roomid = 2;
-- 	optional int32 gamecurcount = 3;
-- 	optional ROOM_STATE roomstate = 4;
-- 	optional ROOM_RUlES room_baseinfo = 5;
-- }
function GamePresenter:M2C_PLAYER_ROOM_BASEINFO_ACK()
    local data = Message_Def:M2C_PLAYER_ROOM_BASEINFO_ACK(msgData) 
    dump(data, "--->>> 桌子的基本信息")
end

-- 桌子上玩家信
-- message MSG_M2C_TABLE_PLAYER_INFO_NOTIFY
-- {
-- 	optional int32 messageID = 1;
-- 	optional string name  = 2;
-- 	optional int32 player_id = 3;
-- 	optional int32 sex = 4;
-- 	optional int64 registerdate = 5;
-- 	optional int32 userstate = 6;
-- 	optional int32 tableposid = 7;
-- 	optional int32 isonline = 8;
-- }
function GamePresenter:M2C_TABLE_PLAYER_INFO_NOTIFY()
    local data = Message_Def:M2C_TABLE_PLAYER_INFO_NOTIFY(msgData) 
    dump(data, "--->>> 桌子上玩家信")
end

-- 桌子空闲场景消息
-- message MSG_M2C_PLAYER_ROOM_FREE_SCENE_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional ROOM_STATE roomstate = 2;
-- 	optional int32 outtime = 3;		//出牌超时间
-- 	optional int32 blocktime = 4;
-- 	optional int32 Playintcount = 5;		//进行局数
-- 	optional int32 buycount = 6;			//购买局数

-- 	message PLAYER_INFO
-- 	{
-- 	optional 	int32 playerid = 1;
-- 	optional 	int32 chairid = 2;
-- 	optional 	int32 score = 3;
-- 	optional 	int32 online = 4;
-- 	optional 	USER_STATE state = 5;	//玩家状态
-- 	}
-- 	repeated PLAYER_INFO item  = 7;
-- }
function GamePresenter:M2C_PLAYER_ROOM_FREE_SCENE_ACK()
    local data = Message_Def:M2C_PLAYER_ROOM_FREE_SCENE_ACK(msgData) 
    dump(data, "--->>> 桌子空闲场景消息")
end

--桌子战斗场景消息
function GamePresenter:M2C_PLAYER_ROOM_PLAYING_SCENE_ACK()
    local data = Message_Def:M2C_PLAYER_ROOM_PLAYING_SCENE_ACK(msgData) 
    dump(data, "--->>> 桌子战斗场景消息")
end

--玩家状态更新
function GamePresenter:M2C_PLAYER_STATE_UPDATA_ACK()
    local data = Message_Def:M2C_PLAYER_STATE_UPDATA_ACK(msgData) 
    dump(data, "--->>> 玩家状态更新")
end

--桌子状态更新
function GamePresenter:M2C_PLAYER_ROOM_STATE_UPDATA_ACK()
    local data = Message_Def:M2C_PLAYER_ROOM_STATE_UPDATA_ACK(msgData) 
    dump(data, "--->>> 桌子状态更新")
end
-- 玩家坐下成功
function GamePresenter:M2C_PLAYER_SIT_DOWN_ACK()
    local data = Message_Def:M2C_PLAYER_SIT_DOWN_ACK(msgData) 
    dump(data, "--->>> 玩家坐下成功")
end

--玩家准备成功
function GamePresenter:M2C_PLAYER_READY_ACK()
    local data = Message_Def:M2C_PLAYER_READY_ACK(msgData) 
    dump(data, "--->>> 玩家准备成功")
end

--玩家离开成功
function GamePresenter:M2C_PLAYER_OP_ACK()
    local data = Message_Def:M2C_PLAYER_OP_ACK(msgData) 
    dump(data, "--->>> 玩家离开成功")
end

--玩家解散房间成功
function GamePresenter:M2C_PLAYER_DISMISS_ROOM_ACK()
    local data = Message_Def:M2C_PLAYER_DISMISS_ROOM_ACK(msgData) 
    dump(data, "--->>> 玩家解散房间成功")
end

--玩家投票成功
function GamePresenter:M2C_PLAYER_VOTE_ACK()
    local data = Message_Def:M2C_PLAYER_VOTE_ACK(msgData) 
    dump(data, "--->>> 玩家投票成功")
end

--游戏开始
function GamePresenter:M2C_PLAYER_GAME_START_ACK()
    local data = Message_Def:M2C_PLAYER_GAME_START_ACK(msgData) 
    dump(data, "--->>> 游戏开始")
end

--货币更新
function GamePresenter:M2C_PLAYER_MONEY_UPDATA_ACK()
    local data = Message_Def:M2C_PLAYER_MONEY_UPDATA_ACK(msgData) 
    dump(data, "--->>> 货币更新")
end

--操作提示

function GamePresenter:M2C_PLAYER_OPERATE_NOTIFY_ACK()
    local data = Message_Def:M2C_PLAYER_OPERATE_NOTIFY_ACK(msgData) 
    dump(data, "--->>> 操作提示")
end

-- 操作命令
function GamePresenter:M2C_PLAYER_OPERATE_RESULT_ACK()
    local data = Message_Def:M2C_PLAYER_OPERATE_RESULT_ACK(msgData) 
    dump(data, "--->>> 操作命令")
end

-- 游戏结束
function GamePresenter:M2C_SUB_GAME_END_ACK()
    local data = Message_Def:M2C_SUB_GAME_END_ACK(msgData) 
    dump(data, "--->>> 游戏结束")
end

--所有游戏结束
function GamePresenter:M2C_SUB_GAME_END_ALL_ACK()
    local data = Message_Def:M2C_SUB_GAME_END_ALL_ACK(msgData) 
    dump(data, "--->>> 所有游戏结束")
end

-------------------------------------------------------

return GamePresenter