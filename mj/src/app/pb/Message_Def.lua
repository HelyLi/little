require("app.pb.Message_ID")
require("app.pb.Message_pb")
require("app.pb.Subgame_pb")


--消息在此处解析和组合
Message_Def = {}

--SubGame
-- xian_tao = 0
-- tian_men = 1
-- qian_jiang = 2
-- hu_no = 0
-- hu_zimo = 1
-- hu_dian_pao = 2
-- hu_gang_pao = 3
-- hu_qiang_gang = 4
-- hu_gang_kai = 5
-- invalid = 0
-- gang_shang_pao = 1
-- gang_shang_hua = 2
-- qiang_gang_hu = 3

--踢玩家
KICK_CLIENT_REASON = {
	CLIENT_REPEAT_LOGIN = 0;
	CLIENT_TOKEN_EXPIRE=1;
	CLIENT_SYSTEM_ERROR=2;
	CLIENT_ROOM_NOT_FOUND = 3;
	CLIENT_ROOM_FULL = 4;
	CLIENT_ROOM_DISMISS = 5;
	CLIENT_LEAVE_ROOM = 6;
};

--玩家状态
USER_STATE =
{
	USER_STATE_INIT = 0;
	USER_STATE_IN_LOBBY = 1;
	USER_STATE_WAIT_CREATE_ROOM = 2;
	USER_STATE_WAIT_IN_GAME = 3;
	USER_STATE_IN_GAME = 4;
	USER_STATE_SIT_DOWN = 5;
	USER_STATE_PLAYING = 6;
	USER_STATE_WAIT_LEAVE_GAME = 7;
};

--桌子状态
ROOM_STATE = {
	ROOM_STATE_INIT = 0;
	ROOM_STATE_WAIT_CREATE = 1;
	ROOM_STATE_CREATED = 2;
	ROOM_STATE_ROUND_GAME_START = 3;

	ROOM_STATE_CALL_BANKER = 4;
	ROOM_STATE_ADD_SCORE = 5;
	ROOM_STATE_PLAYING = 6;

	ROOM_STATE_ROUND_GAME_END = 7;
	ROOM_STATE_GAME_ALL_END = 8;
};

----操作码
OPERATE_CODE = {
	SUB_OPER_INIT = 0;
	SUB_OPER_CHI = 1;
	SUB_OPER_PENG = 2;
	SUB_OPER_AN_GANG = 3;
	SUB_OPER_MING_GANG = 4;
	SUB_OPER_BU_GANG = 5;
	SUB_OPER_HU	= 6;
}

----错误码
ERRORCODE = {
	ERROR_INIT											 = 0;								--初始值								
	ERROR_GAME_SERVER_UNUSUAL							 = -601;							--服务器异常
	ERROR_ROOM_NOT_FIND									 = -602;							--房间没找到
	ERROR_TOKEN_NO_EQUAL								 = -603;							--大厅和游戏服务器token不相等
	ERROR_PLAYER_NOT_EXIT								 = -604;							--玩家不存在
	ERROR_PLAYER_STATE									 = -605;							--玩家状态错误
	ERROR_ROOM_NOTCAN_ENTER								 = -606;							--玩家不能进入
	ERROR_GAME_PLAYER_FULL								 = -607;							--房间满
	ERROR_GAME_PLAYER_EXIT								 = -608;							--玩家在该房间	
	ERROR_ROOM_NOT_EXIT									 = -609;							--房间不存在
	ERROR_SIT_DOWN_FAIL									 = -610;							--玩家坐下失败
	ERROR_LEAVE_FAILL									 = -6011;							--玩家离开失败
	ERROR_DISMISS_ROOM_FAILL							 = -6012;							--玩家解散房间失败
	ERROR_NEED_VOTE_DISMISS_ROOM						 = -6013;							--需要投票解散
}

ERRORCODE_DESCRIBE = {
    [ERRORCODE.ERROR_GAME_SERVER_UNUSUAL]							 = "服务器异常",
	[ERRORCODE.ERROR_ROOM_NOT_FIND]									 = "房间没找到",
	[ERRORCODE.ERROR_TOKEN_NO_EQUAL]								 = "大厅和游戏服务器token不相等",
	[ERRORCODE.ERROR_PLAYER_NOT_EXIT]								 = "玩家不存在",
	[ERRORCODE.ERROR_PLAYER_STATE]									 = "玩家状态错误",
	[ERRORCODE.ERROR_ROOM_NOTCAN_ENTER]								 = "玩家不能进入",
	[ERRORCODE.ERROR_GAME_PLAYER_FULL]								 = "房间满",
	[ERRORCODE.ERROR_GAME_PLAYER_EXIT]								 = "玩家在该房间",	
	[ERRORCODE.ERROR_ROOM_NOT_EXIT]									 = "房间不存在",
	[ERRORCODE.ERROR_SIT_DOWN_FAIL]									 = "玩家坐下失败",
	[ERRORCODE.ERROR_LEAVE_FAILL]									 = "玩家离开失败",
	[ERRORCODE.ERROR_DISMISS_ROOM_FAILL]							 = "玩家解散房间失败",
	[ERRORCODE.ERROR_NEED_VOTE_DISMISS_ROOM]						 = "需要投票解散"
}

-- 客户端请求大厅消息
-- C2L_PLAYER_LOGIN_SYN			 					    = 10001;     					//登入
-- C2L_PLAYER_CREATE_ROOM_SYN 							= 10002;						//创建房间
-- C2L_PLAYER_ENTER_ROOM_SYN							= 10003;						//加入房间
-- C2L_PLAYER_MONEY_UPDATA_SYN							= 10004;						//玩家货币更新
-- C2L_PLAYER_RECONNECT_LOBBY_SYN						= 10005;						//大厅断线重连	
-- -------------------------------------------------------------------------------------------------------------------------------------
function Message_Def:C2L_PLAYER_LOGIN_SYN(data)
    local msg = Message_pb.MSG_C2L_PLAYER_LOGIN_SYN()
    msg.messageID = C2L_PLAYER_LOGIN_SYN
    msg.openid = data.openid
    msg.accesstoken = data.accesstoken
    msg.nickname = data.nickname
    msg.sex = data.sex

    dump(msg, "C2L_PLAYER_LOGIN_SYN.1", 8)

    return msg:SerializeToString(), C2L_PLAYER_LOGIN_SYN
end

function Message_Def:C2L_PLAYER_CREATE_ROOM_SYN(data)
    dump(data, "C2L_PLAYER_CREATE_ROOM_SYN", 8)

    local msg = Message_pb.MSG_C2L_PLAYER_CREATE_ROOM_SYN()
    msg.messageID = C2L_PLAYER_CREATE_ROOM_SYN

    local room_rules = msg.room_rules
    room_rules.kindid = data.dwGameId
    room_rules.areaid = data.areaId
    room_rules.paytype = data.payment_default
    room_rules.playernum = data.playernum_default
    room_rules.ju_num = data.jushu_default
    room_rules.difen = data.difen_default

    local subgame = Subgame_pb.MSG_SUB_ROOM_RULE()
    subgame.gameAreaRule = 0
    local sub_rules = subgame.xgRule
    sub_rules.piao_prize = data.piao_laizi_prize_default
    sub_rules.hu_laizinum = data.hu_laizi_num_default
    sub_rules.fengding = data.fengding_default

    local sub = subgame:SerializeToString()
    local sub_msg = Subgame_pb.MSG_SUB_ROOM_RULE()
    sub_msg:ParseFromString(sub)

    local T = {}
    ComFunc.parseMsg(sub_msg, T)

    room_rules.sub_game_rule = json.encode(T)

    return msg:SerializeToString(), C2L_PLAYER_CREATE_ROOM_SYN
end

--加入房间
-- message MSG_C2L_PLAYER_ENTER_ROOM_SYN
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 roomid = 2; 
-- 	optional int32 playerid = 3;
-- }
function Message_Def:C2L_PLAYER_ENTER_ROOM_SYN(data)
    local msg = Message_pb.MSG_C2L_PLAYER_ENTER_ROOM_SYN()
    msg.messageID = C2L_PLAYER_ENTER_ROOM_SYN

    msg.roomid = data.roomid
    msg.playerid = data.playerid

    return msg:SerializeToString(), C2L_PLAYER_ENTER_ROOM_SYN
end

function Message_Def:C2L_PLAYER_MONEY_UPDATA_SYN()
    local msg = Message_pb.MSG_C2L_PLAYER_MONEY_UPDATA_SYN()
    msg.messageID = C2L_PLAYER_MONEY_UPDATA_SYN

    return msg:SerializeToString(), C2L_PLAYER_MONEY_UPDATA_SYN
end

-- message MSG_C2L_PLAYER_RECONNECT_LOBBY_SYN
-- {
-- 	optional int32 messageID = 1;
-- 	optional uint64 playerid = 2;
-- 	optional uint64 clienttoken = 3;
-- }
function Message_Def:C2L_PLAYER_RECONNECT_LOBBY_SYN(data)
    local msg = Message_pb.MSG_C2L_PLAYER_RECONNECT_LOBBY_SYN()
    msg.messageID = C2L_PLAYER_RECONNECT_LOBBY_SYN
    msg.playerid = data.userId
    msg.clienttoken = data.token

    return msg:SerializeToString(), C2L_PLAYER_RECONNECT_LOBBY_SYN
end

----
-- G2M_CONN_CLOSE = 1;
-- M2G_PLAYER_KICK = 2;
-- G2C_PLAYER_KICK = 3;
-- REGISTER_SERVER = 4;
function Message_Def:G2M_CONN_CLOSE(msgData)
    local msg = Message_pb.MSG_G2M_CONN_CLOSE()
    msg:ParseFromString(msgData)

    local T = {}
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2G_PLAYER_KICK(msgData)
    local msg = Message_pb.MSG_M2G_PLAYER_KICK()
    msg:ParseFromString(msgData)

    local T = {}
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:G2C_PLAYER_KICK(msgData)
    local msg = Message_pb.MSG_G2C_PLAYER_KICK()
    msg:ParseFromString(msgData)

    local T = {}
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:REGISTER_SERVER(msgData)
    local msg = Message_pb.MSG_REGISTER_SERVER()
    msg:ParseFromString(msgData)

    local T = {}
    ComFunc.parseMsg(msg, T)
    return T
end

-- -------------------------------------------------------------------------------------------------------------------------------------
-- --大厅发送给客户端消息
-- L2C_PLAYER_LOGIN_ACK 								= 11001;   						//登入成功
-- L2C_PLAYER_BASEINFO_ACK 							    = 11002;						//玩家基本信息
-- L2C_PLAYER_GAME_ROOM_CONFIG_ACK						= 11003;						//游戏房间基本配置
-- L2C_PLAYER_CREATE_ROOM_ACK 							= 11004;						//房间创建成功
-- L2C_PLAYER_ENTER_ROOM_ACK							= 11005;						//加入房间成功
-- L2C_PLAYER_MONEY_UPDATA_ACK							= 11006;						//货币更新成功
-- L2C_PLAYER_RECONNECT_LOBBY_ACK						= 11007;						//大厅断线重连成功
-- L2C_GAME_SERVER_INFO_NOTIFY							= 11008;						//通知连接游戏服务器
-- -------------------------------------------------------------------------------------------------------------------------------------

function Message_Def:L2C_PLAYER_LOGIN_ACK(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_LOGIN_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        errorcode = 0, 
        clienttoken = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:L2C_PLAYER_BASEINFO_ACK(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_BASEINFO_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        playerInfo = {
            player_id = 0, 
            name ='', 
            level = 0, 
            exp = 0, 
            accountId ='', 
            goldCoin = 0, 
            diamond = 0, 
            vip = 0, 
            registerDate = 0, 
            password ='', 
            sex = 0, 
        },
        userstate = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:L2C_PLAYER_GAME_ROOM_CONFIG_ACK(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_GAME_ROOM_CONFIG_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        room_config = {
            kindid = 0, 
            name ='', 
            config ='', 
            free = 0, 
            areaid = 0, 
        }
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:L2C_PLAYER_CREATE_ROOM_ACK(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_CREATE_ROOM_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        errorcode = 0, 
        gameip ='', 
        gameport = 0, 
        roomid = 0, 
        ownerid = 0, 
        kindid = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:L2C_PLAYER_ENTER_ROOM_ACK(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_ENTER_ROOM_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        errorcode = 0, 
        gameip ='', 
        gameport = 0, 
        roomid = 0, 
        ownerid = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:L2C_PLAYER_MONEY_UPDATA_ACK(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_MONEY_UPDATA_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:L2C_PLAYER_RECONNECT_LOBBY_ACK(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_RECONNECT_LOBBY_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        errorcode = 0
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:L2C_GAME_SERVER_INFO_NOTIFY(msgData)
    local msg = Message_pb.MSG_L2C_GAME_SERVER_INFO_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        gameip = '',
	    gameport = 0,
	    roomid = 0,
	    ownerid = 0,
    }
    ComFunc.parseMsg(msg, T)
    return T
end

-- -------------------------------------------------------------------------------------------------------------------------------------
-- //客户端请求游戏服务器消息
-- C2M_PLAYER_ENTER_GAME_ROOM_SYN							= 21001;		//请求进入游戏房间
-- C2M_PLAYER_RECONNECT_GAME_SYN							= 21002;		//断线重连
-- C2M_PLAYER_SIT_DOWN_SYN									= 21003;		//请求坐下
-- C2M_PLAYER_READY_SYN									= 21004;		//玩家准备
-- C2M_PLAYER_OP_SYN										= 21005;		//玩家请求离开和解散（不需要投票）
-- C2M_PLAYER_VOTE_BEGIN_SYN								= 21006;		//请求投票解散
-- C2M_PLAYER_VOTE_SYN										= 21007;		//玩家解散投票
-- C2M_PLAYER_OUT_CARD_SYN									= 21008;		//玩家出牌
-- C2M_PLAYER_OPERATE_RESULT_SYN							= 21009;		//操作命令
-- C2M_PLAYER_TRUSTEE_SYN									= 21010;		//玩家托管
-- ----------------------------------------------------------------------------------------------------------------------------------------

-- message MSG_C2M_PLAYER_ENTER_GAME_ROOM_SYN
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 roomid = 2;
-- 	optional uint64 token = 3;
-- 	optional int32 playerid = 4;
-- }

function Message_Def:C2M_PLAYER_ENTER_GAME_ROOM_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_ENTER_GAME_ROOM_SYN()
    msg.messageID = C2M_PLAYER_ENTER_GAME_ROOM_SYN
    msg.roomid = data.roomId
    msg.token = data.token
    msg.playerid = data.userId

    return msg:SerializeToString(), C2M_PLAYER_ENTER_GAME_ROOM_SYN
end

-- message MSG_C2M_PLAYER_RECONNECT_GAME_SYN
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 playerid = 2;
-- 	optional uint64 token = 3 ;
-- }

function Message_Def:C2M_PLAYER_RECONNECT_GAME_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_RECONNECT_GAME_SYN()
    msg.messageID = C2M_PLAYER_RECONNECT_GAME_SYN
    msg.playerid = data.userId
    msg.token = data.token

    return msg:SerializeToString(), C2M_PLAYER_RECONNECT_GAME_SYN
end

function Message_Def:C2M_PLAYER_SIT_DOWN_SYN()
    local msg = Message_pb.MSG_C2M_PLAYER_SIT_DOWN_SYN()
    msg.messageID = C2M_PLAYER_SIT_DOWN_SYN

    return msg:SerializeToString(), C2M_PLAYER_SIT_DOWN_SYN
end

function Message_Def:C2M_PLAYER_READY_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_READY_SYN()
    msg.messageID = C2M_PLAYER_READY_SYN
    return msg:SerializeToString(), C2M_PLAYER_READY_SYN
end

function Message_Def:C2M_PLAYER_OP_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_OP_SYN()
    msg.messageID = C2M_PLAYER_OP_SYN
    msg.opcode = data.opcode

    return msg:SerializeToString(), C2M_PLAYER_OP_SYN
end

function Message_Def:C2M_PLAYER_VOTE_BEGIN_SYN(data)
    local msg = Message_pb.C2M_PLAYER_VOTE_BEGIN_SYN()
    mgs.messageID = C2M_PLAYER_VOTE_BEGIN_SYN

    return msg:SerializeToString(), C2M_PLAYER_VOTE_BEGIN_SYN
end

-- message MSG_C2M_PLAYER_VOTE_SYN
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 oper = 2;	--1:同意 2：拒绝
-- }
function Message_Def:C2M_PLAYER_VOTE_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_VOTE_SYN()
    msg.messageID = C2M_PLAYER_VOTE_SYN
    msg.voteval = data.voteval

    return msg:SerializeToString(), C2M_PLAYER_VOTE_SYN
end

-- message MSG_C2M_PLAYER_OUT_CARD_SYN
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 cardval =2;
-- 	optional int32 cardindex = 3; 
-- }
function Message_Def:C2M_PLAYER_OUT_CARD_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_OUT_CARD_SYN()
    msg.messageID = C2M_PLAYER_OUT_CARD_SYN
    msg.cardval = data.cardval
    msg.cardindex = data.cardindex

    return msg:SerializeToString(), C2M_PLAYER_OUT_CARD_SYN
end

-- message MSG_C2M_PLAYER_OPERATE_RESULT_SYN
-- {
-- 	optional int32 messageID = 1;
-- 	optional OPERATE_CODE oper = 2;			--操作码
-- 	repeated int32 actiondata = 3;  --吃碰杠数据
-- }
-- --操作码
-- enum OPERATE_CODE
-- {
-- 	SUB_OPER_INIT = 0;
-- 	SUB_OPER_CHI = 1;
-- 	SUB_OPER_PENG = 2;
-- 	SUB_OPER_AN_GANG = 3;
-- 	SUB_OPER_MING_GANG = 4;
-- 	SUB_OPER_BU_GANG = 5;
-- 	SUB_OPER_HU	= 6;
-- }
function Message_Def:C2M_PLAYER_OPERATE_RESULT_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_OPERATE_RESULT_SYN()
    msg.messageID = C2M_PLAYER_OPERATE_RESULT_SYN
    msg.oper = data.oper
    msg.actiondata = data.actiondata

    return msg:SerializeToString(), C2M_PLAYER_OPERATE_RESULT_SYN
end

-- message MSG_C2M_PLAYER_TRUSTEE_SYN
-- {
-- 	optional int32 messageID = 1;
-- 	optional bool btrustee = 2;							--是否托管
-- }
function Message_Def:C2M_PLAYER_TRUSTEE_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_TRUSTEE_SYN()
    msg.messageID = C2M_PLAYER_TRUSTEE_SYN
    msg.btrustee = data.btrustee

    return msg:SerializeToString(), C2M_PLAYER_TRUSTEE_SYN
end

-- //-------------------------------------------------------------------------------------------------------------------------------------
-- //游戏服务器发送给客户端的消息
-- 	M2C_PLAYER_ENTER_GAME_ROOM_ACK							= 22001;			//请求进入游戏房间成功
-- 	M2C_PLAYER_RECONNECT_GAME_ACK							= 22002;			//重连成功
-- 	M2C_PLAYER_BASEINFO_ACK									= 22003;			//玩家的基本信息
-- 	M2C_PLAYER_ROOM_BASEINFO_ACK							= 22004;			//桌子的基本信息
-- 	M2C_TABLE_PLAYER_INFO_NOTIFY							= 22005;			//桌子上玩家信息
-- 	M2C_PLAYER_ROOM_FREE_SCENE_ACK							= 22006;			//桌子空闲场景消息
-- 	M2C_PLAYER_ROOM_PLAYING_SCENE_ACK						= 22007;			//桌子战斗场景消息
-- 	M2C_PLAYER_STATE_UPDATA_ACK								= 22008;			//玩家状态更新
-- 	M2C_PLAYER_ROOM_STATE_UPDATA_ACK						= 22009;			//桌子状态更新
-- 	M2C_PLAYER_SIT_DOWN_ACK									= 22010;			//玩家坐下成功
-- 	M2C_PLAYER_READY_ACK									= 22011;			//玩家准备成功
-- 	M2C_PLAYER_OP_ACK										= 22012;			//玩家离开或解散成功
-- 	M2C_PLAYER_DISMISS_ROOM_ACK								= 22013;			//玩家解散房间成功
-- 	M2C_PLAYER_VOTE_ACK										= 22014;			//玩家投票成功
-- 	M2C_PLAYER_GAME_START_ACK								= 22015;			//游戏开始
-- 	M2C_PLAYER_MONEY_UPDATA_ACK								= 22016;			//货币更新
-- 	M2C_PLAYER_OPERATE_NOTIFY_ACK							= 22017;			//操作提示
-- 	M2C_PLAYER_OPERATE_RESULT_ACK							= 21018;			//操作命令
-- 	M2C_SUB_GAME_END_ACK									= 21019;			//游戏结束
-- 	M2C_SUB_GAME_END_ALL_ACK								= 21020;			//所有游戏结束
	
-- 	M2C_PLAYER_VOTE_BEGIN_ACK								= 21030;			//玩家开始投票解散结果
-- 	M2C_PLAYER_VOTE_NOTIFY									= 21031;			//玩家解散投票结果
-- 	M2C_PLAYER_VOTE_END_NOTIFY								= 21032;			//房间解散投票结果
-- 	M2C_PLAYER_LEAVE_FROM_ROOM								= 21033;			//玩家离开
-- 	M2C_PLAYER_VOTE_BEGIN_NOTIFY							= 21034;			//房间解散投票开始
-- 	M2C_DISMISS_ROOM_NOTIFY									= 21035;			//房间解散通知
--  M2C_PLAYER_ENTER_GAME_ROOM_ACK							= 22001;			//请求进入游戏房间成功
-- 	M2C_PLAYER_RECONNECT_GAME_ACK							= 22002;			//重连成功
-- 	M2C_PLAYER_BASEINFO_ACK									= 22003;			//玩家的基本信息
-- 	M2C_PLAYER_ROOM_BASEINFO_ACK							= 22004;			//桌子的基本信息
-- 	M2C_TABLE_PLAYER_INFO_NOTIFY							= 22005;			//桌子上玩家信息
-- 	M2C_PLAYER_ROOM_FREE_SCENE_ACK							= 22006;			//桌子空闲场景消息
-- 	M2C_PLAYER_ROOM_PLAYING_SCENE_ACK						= 22007;			//桌子战斗场景消息
-- 	M2C_PLAYER_STATE_UPDATA_ACK								= 22008;			//玩家状态更新
-- 	M2C_PLAYER_ROOM_STATE_UPDATA_ACK						= 22009;			//桌子状态更新
-- 	M2C_PLAYER_SIT_DOWN_ACK									= 22010;			//玩家坐下成功
-- 	M2C_PLAYER_READY_ACK									= 22011;			//玩家准备成功
-- 	M2C_PLAYER_OP_ACK										= 22012;			//玩家离开或解散成功
-- 	M2C_PLAYER_DISMISS_ROOM_ACK								= 22013;			//玩家解散房间成功
-- 	M2C_PLAYER_VOTE_ACK										= 22014;			//玩家投票成功
-- 	M2C_PLAYER_GAME_START_ACK								= 22015;			//游戏开始
-- 	M2C_PLAYER_MONEY_UPDATA_ACK								= 22016;			//货币更新
-- 	M2C_PLAYER_OPERATE_NOTIFY_ACK							= 22017;			//操作提示
-- 	M2C_PLAYER_OPERATE_RESULT_ACK							= 21018;			//操作命令
-- 	M2C_SUB_GAME_END_ACK									= 21019;			//游戏结束
-- 	M2C_SUB_GAME_END_ALL_ACK								= 21020;			//所有游戏结束
	
-- 	M2C_PLAYER_VOTE_BEGIN_ACK								= 21030;			//玩家开始投票解散结果
-- 	M2C_PLAYER_VOTE_NOTIFY									= 21031;			//玩家解散投票结果
-- 	M2C_PLAYER_VOTE_END_NOTIFY								= 21032;			//房间解散投票结果
-- 	M2C_PLAYER_LEAVE_FROM_ROOM								= 21033;			//玩家离开
-- 	M2C_PLAYER_VOTE_BEGIN_NOTIFY							= 21034;			//房间解散投票开始
-- 	M2C_DISMISS_ROOM_NOTIFY									= 21035;			//房间解散通知
-- //--------------------------------------------------------------------------------------------------------------------------------------
-- message MSG_M2C_PLAYER_ENTER_GAME_ROOM_ACK
-- {
-- 	int32	messageID = 1;
-- 	int32	errorcode = 2;
-- 	int32 	roomid = 3;
-- 	uint64  tokenid = 4;
-- 	int32   userstate = 5;
-- 	int32 	playerid = 6;
-- }
function Message_Def:M2C_PLAYER_ENTER_GAME_ROOM_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_ENTER_GAME_ROOM_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        errorcode = 0, 
        roomid = 0, 
        tokenid = 0, 
        playerid = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_RECONNECT_GAME_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_RECONNECT_GAME_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        errorcode = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

-- message MSG_M2C_PLAYER_BASEINFO_ACK
-- {
-- 	optional int32 messageID = 1;
-- 	optional int32 infotype = 2; //1:自己的信息   2：其他玩家
-- 	optional bool online = 3;	//玩家是否在线
-- 	optional int32 state = 4;	//玩家状态
-- 	optional PlayerBaseInfo baseinfo =5;
-- }
function Message_Def:M2C_PLAYER_BASEINFO_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_BASEINFO_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        state = 0, 
        baseinfo = {
            player_id = 0, 
            name ='', 
            level = 0, 
            exp = 0, 
            accountId ='', 
            goldCoin = 0, 
            diamond = 0, 
            vip = 0, 
            registerDate = 0, 
            password ='', 
            sex = 0, 
        }
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_ROOM_BASEINFO_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_ROOM_BASEINFO_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        roomid = 0, 
        gamecurcount = 0, 
        roomstate = 0, 
        room_baseinfo = {
            kindid = 0, 
            areaid = 0, 
            paytype = 0, 
            playernum = 0, 
            ju_num = 0, 
            difen = 0, 
            sub_game_rule ='', 
        }
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_TABLE_PLAYER_INFO_NOTIFY(msgData)
    local msg = Message_pb.MSG_M2C_TABLE_PLAYER_INFO_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        name ='', 
        player_id = 0, 
        sex = 0, 
        registerdate = 0, 
        userstate = 0, 
        tableposid = 0, 
        isonline = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_ROOM_FREE_SCENE_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_ROOM_FREE_SCENE_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        roomstate = 0,
        outtime = 0, 
        blocktime = 0, 
        Playintcount = 0, 
        buycount = 0, 
        item = {}
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_ROOM_PLAYING_SCENE_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_ROOM_PLAYING_SCENE_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        outtime = 0, 
        blocktime = 0, 
        playintcount = 0, 
        buycount = 0, 
        outpai = 0,
        mennums = 0, 
        nowoutstation = 0, 
        laizipi = 0, 
        laizi = 0, 
        ntstation = 0, 
        player_item = {},
        cpgnotify = {
            bzhuapai = false, 
            bchi = false, 
            bpeng = false, 
            bgang = false, 
            bhu = false, 
            bispiaolai = false, 
            bCanAction = false, 
            outpaistation = 0, 
            outpaival = 0, 
            chi = {},
            pengpai = 0, 
            gang = {}
        }
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_STATE_UPDATA_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_STATE_UPDATA_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        playerid = 0, 
        state = 0 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_ROOM_STATE_UPDATA_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_ROOM_STATE_UPDATA_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        roomid = 0, 
        roomstate = 0 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_SIT_DOWN_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_SIT_DOWN_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        errorcode = 0, 
        playerid = 0, 
        tableposid = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_READY_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_READY_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        errorcode = 0, 
        playerid = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_OP_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_OP_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        errorcode = 0, 
        opcode = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

-- function Message_Def:M2C_PLAYER_OPER_LEAVE_ROOM_ACK(msgData)
--     local msg = Message_pb.MSG_M2C_PLAYER_OPER_LEAVE_ROOM_ACK()
--     msg:ParseFromString(msgData)

--     local T = {}
--     ComFunc.parseMsg(msg, T)
--     return T
-- end

function Message_Def:M2C_PLAYER_DISMISS_ROOM_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_DISMISS_ROOM_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        errorcode = 0, 
        playerid = 0, 
        name ='', 
        faceurl ='', 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_VOTE_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_VOTE_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        errorcode = 0, 
        vote = 0, 
        playerid = 0, 
        name ='', 
        faceurl ='', 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

-- function Message_Def:M2C_PLAYER_VOTE_SYN(msgData)
--     local msg = Message_pb.MSG_M2C_PLAYER_VOTE_SYN()
--     msg:ParseFromString(msgData)

--     local T = {}
--     ComFunc.parseMsg(msg, T)
--     return T
-- end

function Message_Def:M2C_PLAYER_GAME_START_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_GAME_START_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        bgang = false, 
        bhu = false, 
        bankeruser = 0, 
        currentuser = 0, 
        useraction = 0, 
        laizipicard = 0, 
        laizicard = 0, 
        isicecount = 0,
        imennums = 0, 
        iplayingcount = 0, 
        gangdata = {
            bzhuapai = false, 
            bchi = false, 
            bpeng = false, 
            bgang = false, 
            bhu = false, 
            bispiaolai = false, 
            bCanAction = false, 
            outpaistation = 0, 
            outpaival = 0, 
            chi = {},
            pengpai = 0, 
            gang = {},
        },
        hand_card = {}
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_MONEY_UPDATA_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_MONEY_UPDATA_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        money = {}
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_OPERATE_NOTIFY_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_OPERATE_NOTIFY_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        playerid = 0, 
        chairid = 0, 
        cpgnotify = {
            bzhuapai = false, 
            bchi = false, 
            bpeng = false, 
            bgang = false, 
            bhu = false, 
            bispiaolai = false, 
            bCanAction = false, 
            outpaistation = 0, 
            outpaival = 0, 
            chi = {},
            pengpai = 0, 
            gang = {}
        }
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_OPERATE_RESULT_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_OPERATE_RESULT_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        bclearaction = false, 
        bzhua = false, 
        type = 0, 
        istation = 0, 
        ibestation = 0, 
        ioutpai = 0, 
        data = 0,
        handcardcount = 0,
        outpai = 0,
        cardcount = 0, 
        laizicard = 0, 
        userscore = 0,
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_SUB_GAME_END_ACK(msgData)
    local msg = Message_pb.MSG_M2C_SUB_GAME_END_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        bzimo = false, 
        bisliuju = false, 
        dianpaostation = 0, 
        laizicard = 0, 
        hupaistation = 0, 
        hucard = 0, 
        imennums = 0, 
        hu_info = {}
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_SUB_GAME_END_ALL_ACK(msgData)
    local msg = Message_pb.MSG_M2C_SUB_GAME_END_ALL_ACK()
    msg:ParseFromString(msgData)

    local T =  {
        messageID = 0, 
        end_all = {}
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_VOTE_BEGIN_ACK(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_VOTE_BEGIN_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        errorcode = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_VOTE_NOTIFY(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_VOTE_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        playerpos = 0, 
        playervoteval = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_VOTE_END_NOTIFY(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_VOTE_END_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        voteresult = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_LEAVE_FROM_ROOM(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_LEAVE_FROM_ROOM()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        player_id = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_VOTE_BEGIN_NOTIFY(msgData)
    local msg = Message_pb.MSG_M2C_PLAYER_VOTE_BEGIN_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        sponsorpos = 0, 
        voteinfo = {}
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_DISMISS_ROOM_NOTIFY(msgData)
    local msg = Message_pb.MSG_M2C_DISMISS_ROOM_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:MSG_M2C_GAME_START_NOTIFY(msgData)
    local msg = Message_pb.MSG_M2C_GAME_START_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageID = 0, 
        gamestartinfo = {
            curgameround = 0,
            bankerstation = 0;
            curdiscardstation = 0;
            lastdiscardstation = 0;
            restcardnums = 0;
            deletedcardnum = {};
            actiontypevalue = {};
            pengcardvalue = 8;
            gangcardvalue = {};
            handcardsinfo = {};
            sicecount = {};
            replay_code = 0;
            laizipi                   = 0;
            laizi                     = 0;
        }
    }
    T = {}
    ComFunc.parseMsg(msg, T)
    return T
end

return Message_Def
