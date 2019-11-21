-- local ByteArray = import("app.utils.ByteArray")
local Subgame_Def = import("app.pb.Subgame_Def")
local Presenter = import("app.network.Presenter")

local GamePresenter = class("GamePresenter",function()
    return Presenter.new()
end)

function GamePresenter:ctor(view)
    Presenter.init(self, view)
    self:initRoomHandlerMsg()
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

function GamePresenter:getRoomData()
    return self.m_roomData
end

function GamePresenter:getPlayingData()
    return self.m_playingData
end
-- G2M_CONN_CLOSE = 1;
-- M2G_PLAYER_KICK = 2;
-- G2C_PLAYER_KICK = 3;
-- REGISTER_SERVER = 4;
function GamePresenter:initRoomHandlerMsg()
    -- self.m_handlerTable = {}

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
    --处理errorcode
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

-- - "--->>> 玩家的基本信息" = {
--      "baseinfo" = {
--          "accountId"    = "1"
--          "diamond"      = 100
--          "goldCoin"     = 1000
--          "level"        = 1
--          "name"         = "test1"
--          "password"     = "1"
--          "player_id"    = 10001
--          "registerDate" = 1565272816
--      }
--      "messageID" = 22003
--      "state"     = 4
--  }
-- "baseinfo" = {
--     [LUA-print] -         "accountId"    = "1"
--     [LUA-print] -         "diamond"      = 100
--     [LUA-print] -         "exp"          = 0
--     [LUA-print] -         "goldCoin"     = 1000
--     [LUA-print] -         "level"        = 1
--     [LUA-print] -         "name"         = "test1"
--     [LUA-print] -         "password"     = "1"
--     [LUA-print] -         "player_id"    = 10001
--     [LUA-print] -         "registerDate" = 1565272816
--     [LUA-print] -         "sex"          = 0
--     [LUA-print] -         "vip"          = 0
--     [LUA-print] -     }
function GamePresenter:M2C_PLAYER_BASEINFO_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_BASEINFO_ACK(msgData)
    dump(data, "--->>> 玩家的基本信息")
    
    local playerInfo = {}
    playerInfo.userId = data.baseinfo.player_id
    playerInfo.name = data.baseinfo.name
    playerInfo.gender = data.sex
    -- playerInfo.registerDate = data.baseinfo.registerDate
    -- playerInfo.userstate = data.userstate
    -- playerInfo.chairId = 0--data.tableposid
    -- playerInfo.score = 0
    playerInfo.card = data.baseinfo.diamond
    playerInfo.gold = data.baseinfo.goldCoin

    -- self.m_myBaseInfo.userId = data.userId
    -- self.m_myBaseInfo.nickname = data.name
    -- self.m_myBaseInfo.gender = data.gender
    -- self.m_myBaseInfo.card = data.Card
    -- self.m_myBaseInfo.gold = data.Gold
    -- self.m_myBaseInfo.chairId = -1
    -- self.m_myBaseInfo.viewId = 1

    self.m_roomData:setMyBaseInfo(playerInfo)
    -- self.m_roomData:addRoomPlayer(playerInfo)

    --ui
    -- self:getContainer():getUIRoomPart(GameConstants.UI_PLAYERS):playerEntry(playerInfo)
    -- self.m_view:getUIRoomPart(GameConstants.ROOM_UI.Players):playerEnter(playerInfo)

    -- Message_Def:C2M_PLAYER_SIT_DOWN_SYN()
    local msg, msgId = Message_Def:C2M_PLAYER_SIT_DOWN_SYN()
    Game:getSocketMgr():cardGameSocketSend(msg, msgId)
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
-- "--->>> 桌子的基本信息" = {
--      "messageID"     = 22004
--      "room_baseinfo" = {
--          "areaid"        = 2
--          "difen"         = 1
--          "ju_num"        = 8
--          "kindid"        = 255
--          "paytype"       = 2
--          "playernum"     = 4
--          "sub_game_rule" = "{"gameAreaRule":0,"xgRule":{"piao_prize":1,"fengding":-1,"hu_laizinum":1}}"
--      }
--      "roomid"        = 280839
--      "roomstate"     = 2
--  }
function GamePresenter:M2C_PLAYER_ROOM_BASEINFO_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_ROOM_BASEINFO_ACK(msgData)
    dump(data, "--->>> 桌子的基本信息")

    self.m_roomData:enterRoomData(data)

    
    --ui
    self.m_view:getUIRoomPart(GameConstants.ROOM_UI.RoomId):display(data.roomid)
end

-- - "--->>> 桌子上玩家信息" = {
-- [LUA-print] -     "isonline"     = 1
-- [LUA-print] -     "messageID"    = 22005
-- [LUA-print] -     "name"         = "test1"
-- [LUA-print] -     "player_id"    = 10001
-- [LUA-print] -     "registerdate" = 1565272816
-- [LUA-print] -     "tableposid"   = 1
-- [LUA-print] -     "userstate"    = 5
-- [LUA-print] - }

-- 桌子上玩家信息
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
-- "--->>> 桌子上玩家信息" = {
-- [LUA-print] -     "isonline"     = 1
-- [LUA-print] -     "messageID"    = 22005
-- [LUA-print] -     "name"         = "test1"
-- [LUA-print] -     "player_id"    = 10001
-- [LUA-print] -     "registerdate" = 1565272816
-- [LUA-print] -     "sex"          = 0
-- [LUA-print] -     "tableposid"   = 0
-- [LUA-print] -     "userstate"    = 5
-- [LUA-print] - }
-- self:setUserId(playerInfo.userId)
-- self:setChairId(playerInfo.chairId)
-- self:setUserName(playerInfo.name)
-- self:setUserScore(playerInfo.score)
-- self:setViewId(playerInfo.viewId)
-- self.m_gender = playerInfo.gender
-- self.m_deskStatus = playerInfo.status
function GamePresenter:M2C_TABLE_PLAYER_INFO_NOTIFY(msgData)
    local data = Message_Def:M2C_TABLE_PLAYER_INFO_NOTIFY(msgData)
    dump(data, "--->>> 桌子上玩家信息")

    local playerInfo = {}
    playerInfo.userId = data.player_id
    playerInfo.name = data.name
    playerInfo.gender = data.sex
    -- playerInfo.registerdate = data.registerdate
    playerInfo.status = data.userstate
    playerInfo.chairId = data.tableposid
    playerInfo.score = 0

    if data.player_id == Game:getUserData():getUserId() then
        --设置自己的椅子Id
        self.m_roomData:setMyChairId(data.tableposid)
    end

    self.m_roomData:addRoomPlayer(playerInfo)
    local playerT = self.m_roomData:getPlayerTable()
    if #playerT == self.m_roomData:getPlayersNum() then
        print("C2M_PLAYER_READY_SYN")
        local msg, msgId = Message_Def:C2M_PLAYER_READY_SYN()
        Game:getSocketMgr():cardGameSocketSend(msg, msgId)
    end

    --ui
    -- self:getContainer():getUIRoomPart(GameConstants.UI_PLAYERS):playerEntry(playerInfo)
    self.m_view:getUIRoomPart(GameConstants.ROOM_UI.Players):playerEnter(playerInfo)
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
function GamePresenter:M2C_PLAYER_ROOM_FREE_SCENE_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_ROOM_FREE_SCENE_ACK(msgData) 
    dump(data, "--->>> 桌子空闲场景消息")
end

--桌子战斗场景消息
-- message MSG_M2C_PLAYER_ROOM_PLAYING_SCENE_ACK
-- {
-- 	optional int32 messageID = 1;

-- 	optional int32 outtime = 2;			//出牌时间		
-- 	optional int32 blocktime = 3;		//拦牌思考时间	
-- 	optional int32 playintcount = 4;		//进行局数
-- 	optional int32 buycount = 5;			//购买局数

-- 	repeated int32 outpai = 6;  //出牌牌值
-- 	optional int32 mennums = 7;			//门牌数量
-- 	optional int32 nowoutstation = 8;	//出牌位置
-- 	optional int32 laizipi = 9;
-- 	optional int32 laizi = 10;
-- 	optional int32 ntstation = 11 ;		//当前操作玩家
	
-- 	message CPGMEG
-- 	{
-- 	optional 	int32 type = 1;					//吃碰杠类型
-- 	optional 	int32 station = 2;				//吃碰杠玩家位置
-- 	optional 	int32 bestation = 3;			//被吃碰杠的玩家位置
-- 	optional 	int32 outpai = 4; 				//别人出的牌
-- 	repeated int32 cpgdata = 5;    //吃碰杠数据 
-- 	}

-- 	message PLAYER_ITEM
-- 	{
-- 	optional 	int32 playerid = 1;
-- 	optional 	int32 chairid = 2;
-- 	optional 	int32 score = 3;
-- 	optional 	int32 online = 4;
--     optional 	USER_STATE state = 5;	//玩家状态
--     repeated int32 handpai = 6;
-- 	optional 	int32 handpaicount = 7;
-- 	repeated CPGMEG cpgmsg  = 8;
-- 	}
	
-- 	repeated PLAYER_ITEM player_item = 12;
-- 	optional CPGNotify	cpgnotify = 13; //吃碰杠提示
-- }
function GamePresenter:M2C_PLAYER_ROOM_PLAYING_SCENE_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_ROOM_PLAYING_SCENE_ACK(msgData) 
    dump(data, "--->>> 桌子战斗场景消息")
end

--玩家状态更新
-- message MSG_M2C_PLAYER_STATE_UPDATA_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 playerid = 2;
-- 	optional USER_STATE state = 5;	//玩家状态
-- }
function GamePresenter:M2C_PLAYER_STATE_UPDATA_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_STATE_UPDATA_ACK(msgData) 
    dump(data, "--->>> 玩家状态更新")
end

--桌子状态更新
-- message MSG_M2C_PLAYER_ROOM_STATE_UPDATA_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 roomid = 2;
-- 	optional ROOM_STATE roomstate = 3;
-- }
function GamePresenter:M2C_PLAYER_ROOM_STATE_UPDATA_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_ROOM_STATE_UPDATA_ACK(msgData) 
    dump(data, "--->>> 桌子状态更新")
end

-- 玩家坐下成功
-- message MSG_M2C_PLAYER_SIT_DOWN_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 errorcode = 2;
-- 	optional int32 playerid = 3;
-- 	optional int32 tableposid = 4;
-- }
function GamePresenter:M2C_PLAYER_SIT_DOWN_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_SIT_DOWN_ACK(msgData) 
    dump(data, "--->>> 玩家坐下成功")
    -- if data.errorcode == 0 then
    --     if data.playerid == Game:getUserData():getUserId() then
    --         self.m_roomData:setMyChairId(data.tableposid)
    --     end
    -- end
end

--玩家准备成功
-- message MSG_M2C_PLAYER_READY_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 errorcode = 2;
-- 	optional int32 playerid = 3;
-- }
function GamePresenter:M2C_PLAYER_READY_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_READY_ACK(msgData) 
    dump(data, "--->>> 玩家准备成功")
end

--玩家离开成功
-- message MSG_M2C_PLAYER_OP_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 errorcode = 2;
-- 	optional int32 opcode = 3; //1:离开 2：解散
-- }
function GamePresenter:M2C_PLAYER_OP_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_OP_ACK(msgData) 
    dump(data, "--->>> 玩家离开成功")
    ComFunc.HandlingErrorCode(data, handler(self.m_view, self.m_view.backToLobby))
end

function GamePresenter:backToLobby(data)
    
end

--玩家解散房间成功
-- message MSG_M2C_PLAYER_DISMISS_ROOM_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 errorcode = 2;
-- 	optional int32 playerid = 3;
-- 	optional string name = 4;
-- 	optional string faceurl = 5;
-- }
function GamePresenter:M2C_PLAYER_DISMISS_ROOM_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_DISMISS_ROOM_ACK(msgData) 
    dump(data, "--->>> 玩家解散房间成功")
end

--玩家投票成功
-- message MSG_M2C_PLAYER_VOTE_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 errorcode = 2;
-- 	optional int32 vote = 3; //1:同意 2：拒绝
-- 	optional int32 playerid = 4;
-- 	optional string name = 5;
-- 	optional string faceurl = 6;
-- }
function GamePresenter:M2C_PLAYER_VOTE_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_VOTE_ACK(msgData) 
    dump(data, "--->>> 玩家投票成功")
end

--游戏开始
-- message MSG_M2C_PLAYER_GAME_START_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional bool bgang = 2;
-- 	optional bool bhu = 3;
-- 	optional int32 bankeruser = 4;								//庄家用户
-- 	optional int32 currentuser = 5;								//当前用户
-- 	optional int32 useraction = 6;								//用户动作
-- 	optional int32 laizipicard = 7;								//癞子皮信息
-- 	optional int32 laizicard = 8;								//癞子信息
-- 	repeated int32 isicecount = 9;						//骰子点数	
-- 	optional int32 imennums = 10;								//门牌数量
-- 	optional int32 iplayingcount = 11;							//局数
-- 	optional CPGNotify	 gangdata = 12;						//杠牌信息
-- 	message HAND_CARD
-- 	{
-- 	optional 	int32 chairid = 1;
-- 	repeated int32 card = 2;
-- 	optional 	int32 cardcount = 3;
-- 	}
-- 	repeated HAND_CARD hand_card = 13;					//手牌信息
-- }
function GamePresenter:M2C_PLAYER_GAME_START_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_GAME_START_ACK(msgData) 
    dump(data, "--->>> 游戏开始")
end

--货币更新
-- message MSG_M2C_PLAYER_MONEY_UPDATA_ACK
-- {
-- 	optional int32 messageID = 1;

-- 	message MONEY
-- 	{
-- 	optional 	int32 chairid = 1;
-- 	optional 	MONEY_INFO money_info = 2;
-- 	}
-- 	repeated MONEY money = 2;
-- }
function GamePresenter:M2C_PLAYER_MONEY_UPDATA_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_MONEY_UPDATA_ACK(msgData) 
    dump(data, "--->>> 货币更新")
end

--操作提示
-- message MSG_M2C_PLAYER_OPERATE_NOTIFY_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 playerid = 2;
-- 	optional int32 chairid = 3;
-- 	optional CPGNotify cpgnotify  = 4;
-- }
function GamePresenter:M2C_PLAYER_OPERATE_NOTIFY_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_OPERATE_NOTIFY_ACK(msgData) 
    dump(data, "--->>> 操作提示")
end

-- 操作命令
-- message MSG_M2C_PLAYER_OPERATE_RESULT_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional bool  bclearaction = 2;//清楚动作用
-- 	optional bool  bzhua = 3;	 //是否抓牌有动作
-- 	optional int32  type = 4;    //吃碰杠类型
-- 	optional int32  istation = 5;  //吃碰杠玩家位置
-- 	optional int32  ibestation = 6;//被吃碰杠玩家位置
-- 	optional int32  ioutpai = 7;   //别人出的牌
-- 	repeated int32 data = 8; //吃碰杠牌数据 
-- 	repeated int32 handcardcount = 9; //手牌数据
-- 	repeated  int32 outpai = 10; //出牌数据
-- 	optional int32  cardcount = 11;//手牌数量
-- 	optional int32 laizicard = 12;	//宝牌
-- 	repeated int64 userscore = 13; //玩家实时得分
-- }
function GamePresenter:M2C_PLAYER_OPERATE_RESULT_ACK(msgData)
    local data = Message_Def:M2C_PLAYER_OPERATE_RESULT_ACK(msgData) 
    dump(data, "--->>> 操作命令")
end

-- 游戏结束
-- message MSG_M2C_SUB_GAME_END_ACK
-- {
-- 	optional int32 messageID = 1;

-- 	optional bool bzimo = 2;				//是否自摸
-- 	optional bool bisliuju = 3;			//是否流局
-- 	optional int32 dianpaostation = 4;		//点炮玩家位置
-- 	optional int32 laizicard = 5;			//宝牌
-- 	optional int32 hupaistation = 6;		//胡牌玩家位置
-- 	optional int32 hucard = 7;				//胡的牌
-- 	optional int32 imennums = 8;			//门牌数量

-- 	message HU_INFO
-- 	{
-- 	optional 	int32 chairid = 1;
-- 	optional 	int32 hutype = 2;
-- 	optional 	int32 fan = 3;
-- 	optional 	int32 gangscore = 4;
-- 	optional 	int64 gamescore = 5;
-- 	optional 	int64 playergold = 6;
-- 	repeated TCPGMSG tcmpmsg = 7; //吃碰杠
-- 	repeated  int32 handpai = 8;
-- 	optional 	int32 handpaicount = 9;
-- 	}
-- 	repeated 	HU_INFO hu_info = 	9;			
-- }
function GamePresenter:M2C_SUB_GAME_END_ACK(msgData)
    local data = Message_Def:M2C_SUB_GAME_END_ACK(msgData) 
    dump(data, "--->>> 游戏结束")
end

--所有游戏结束
-- message MSG_M2C_SUB_GAME_END_ALL_ACK
-- {
-- 	optional int32 messageID = 1;
	
-- 	message END_ALL
-- 	{
-- 	optional 	int64 gamescore = 1;
-- 	optional 	int32		fan = 2;//番
-- 	optional 	int32		gangscore = 3;//杠
-- 	optional 	int32       hucount = 4; //胡牌次数
-- 	optional 	int32		piaocount = 5;//飘次数
-- 	optional 	int32 		heimocounts = 6;//黑摸次数
-- 	}
-- 	repeated END_ALL end_all = 2;
-- }
function GamePresenter:M2C_SUB_GAME_END_ALL_ACK(msgData)
    local data = Message_Def:M2C_SUB_GAME_END_ALL_ACK(msgData) 
    dump(data, "--->>> 所有游戏结束")
end

-------------------------------------------------------
--21005;		玩家请求离开和解散（不需要投票）
function GamePresenter:C2M_PLAYER_OP_SYN(opcode)
    local data = {}
    data.opcode = opcode

    local msg, msgId = Message_Def:C2M_PLAYER_OP_SYN(data)
    Game:getSocketMgr():cardGameSocketSend(msg, msgId)
end


return GamePresenter