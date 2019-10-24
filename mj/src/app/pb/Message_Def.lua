require("app.pb.Message_ID")
require("app.pb.Message_pb")
--消息在此处解析和组合
Message_Def = Message_Def or {}

-- --踢玩家
KICK_CLIENT_REASON = {
    CLIENT_REPEAT_LOGIN = 0,
    CLIENT_TOKEN_EXPIRE = 1,
    CLIENT_SYSTEM_ERROR = 2,
    CLIENT_ROOM_NOT_FOUND = 3,
    CLIENT_ROOM_FULL = 4,
    CLIENT_ROOM_DISMISS = 5,
    CLIENT_LEAVE_ROOM = 6
}

-- --玩家状态
USER_STATE = {
    USER_STATE_INIT = 0,
    USER_STATE_IN_LOBBY = 1,
    USER_STATE_WAIT_CREATE_ROOM = 2,
    USER_STATE_WAIT_IN_GAME = 3,
    USER_STATE_IN_GAME = 4,
    USER_STATE_SIT_DOWN = 5,
    USER_STATE_PLAYING = 6,
    USER_STATE_WAIT_LEAVE_GAME = 7
}

-- --桌子状态
ROOM_STATE = {
    ROOM_STATE_INIT = 0,
    ROOM_STATE_WAIT_CREATE = 1,
    ROOM_STATE_CREATED = 2,
    ROOM_STATE_ROUND_GAME_START = 3,
    ROOM_STATE_CALL_BANKER = 4,
    ROOM_STATE_ADD_SCORE = 5,
    ROOM_STATE_PLAYING = 6,
    ROOM_STATE_ROUND_GAME_END = 7,
    ROOM_STATE_GAME_ALL_END = 8
}

-- --操作码
OPERATE_CODE = {
    SUB_OPER_INIT = 0,
    SUB_OPER_CHI = 1,
    SUB_OPER_PENG = 2,
    SUB_OPER_AN_GANG = 3,
    SUB_OPER_MING_GANG = 4,
    SUB_OPER_BU_GANG = 5,
    SUB_OPER_HU = 6
}

-- --错误码
ERRORCODE = 
{
	ERROR_INIT											 = 0,								--初始值								
	ERROR_GAME_SERVER_UNUSUAL							 = -601,							--服务器异常
	ERROR_ROOM_NOT_FIND									 = -602,							--房间没找到
	ERROR_TOKEN_NO_EQUAL								 = -603,							--大厅和游戏服务器token不相等
	ERROR_PLAYER_NOT_EXIT								 = -604,							--玩家不存在
	ERROR_PLAYER_STATE									 = -605,							--玩家状态错误
	ERROR_ROOM_NOTCAN_ENTER								 = -606,							--玩家不能进入
	ERROR_GAME_PLAYER_FULL								 = -607,							--房间满
	ERROR_GAME_PLAYER_EXIT								 = -608,							--玩家在该房间	
	ERROR_ROOM_NOT_EXIT									 = -609,							--房间不存在
	ERROR_SIT_DOWN_FAIL									 = -610,							--玩家坐下失败
	ERROR_LEAVE_FAILL									 = -6011,							--玩家离开失败
	ERROR_DISMISS_ROOM_FAILL							 = -6012,							--玩家解散房间失败
	ERROR_NEED_VOTE_DISMISS_ROOM						 = -6013,							--需要投票解散
}

-- --客户端请求大厅消息
-- 	C2L_PLAYER_LOGIN_SYN			 					= 10001;     					--登入
-- 	C2L_PLAYER_CREATE_ROOM_SYN 							= 10002;						--创建房间
-- 	C2L_PLAYER_ENTER_ROOM_SYN							= 10003;						--加入房间
-- 	C2L_PLAYER_MONEY_UPDATA_SYN							= 10004;						--玩家货币更新
-- -------------------------------------------------------------------------------------------------------------------------------------

-- message MSG_C2L_PLAYER_LOGIN_SYN
-- {
-- 	required int32 messageID = 1;
-- 	required string openid = 2;
-- 	required string accesstoken = 3;
-- 	required string nickname = 4;
-- 	required int32 sex = 5;
-- }

--10001 登入
function Message_Def:C2L_PLAYER_LOGIN_SYN(data)
    local msg = Message_pb.MSG_C2L_PLAYER_LOGIN_SYN()
    msg.messageID = C2L_PLAYER_LOGIN_SYN
    msg.openid = data.openid
    msg.accesstoken = data.accesstoken
    msg.nickname = data.nickname
    msg.sex = data.sex

    return msg:SerializeToString(), C2L_PLAYER_LOGIN_SYN
end

-- message MSG_C2L_PLAYER_CREATE_ROOM_SYN
-- {
-- 	required int32 messageID = 1;
-- 	required ROOM_RUlES room_rules = 2;
-- }
--

-- message ROOM_RUlES
-- {
-- 	required int32 kindid = 1;
-- 	required int32 paytype = 2;   --1:房主支付  2：AA支付
-- 	required int32 playernum = 3; --玩家人数
-- 	required int32 ju_num =4;	--局数
-- 	required int32 difen = 5;      --底分
-- 	required int32 fengding = 6;  --封顶
-- 	message XTHH_RULES
-- 	{
-- 	required 	int32 piao_prize =1; --1:飘癞子没奖 2：飘癞子有奖
-- 	required 	int32 hu_laizinum = 2; --1：最多一个癞子胡牌 2：任意癞子胡牌
-- 	}
-- 	required XTHH_RULES xthh_rules = 7;
-- }

function Message_Def:C2L_PLAYER_CREATE_ROOM_SYN(data)
    dump(data, "C2L_PLAYER_CREATE_ROOM_SYN", 8)

    local msg = Message_pb.MSG_C2L_PLAYER_CREATE_ROOM_SYN()
    msg.messageID = C2L_PLAYER_CREATE_ROOM_SYN

    local room_rules = msg.room_rules--:add() 
    room_rules.kindid = data.dwGameId
    room_rules.paytype = data.payment_default
    room_rules.playernum = data.playernum_default
    room_rules.ju_num = data.jushu_default
    room_rules.difen = data.difen_default
    room_rules.fengding = data.fengding_default

    -- room_rules.xthh_rules = room_rules.xthh_rules:add()
    room_rules.xthh_rules.piao_prize = data.piao_laizi_prize_default
    room_rules.xthh_rules.hu_laizinum = data.hu_laizi_num_default

    return msg:SerializeToString(), C2L_PLAYER_CREATE_ROOM_SYN
end

function Message_Def:L2C_PLAYER_CREATE_ROOM_SYN(msgData)
    local msg = Message_pb.MSG_C2L_PLAYER_CREATE_ROOM_SYN()
    msg:ParseFromString(msgData)

    local T = {}
    self:parseMsg(msg, T)
    return T
end


function Message_Def:C2L_PLAYER_ENTER_ROOM_SYN(data)
end

function Message_Def:C2L_PLAYER_MONEY_UPDATA_SYN()
    local msg = Message_pb.MSG_C2L_PLAYER_MONEY_UPDATA_SYN()
    msg.messageID = C2L_PLAYER_MONEY_UPDATA_SYN

    return msg:SerializeToString()
end

-- -------------------------------------------------------------------------------------------------------------------------------------
-- --大厅发送给客户端消息
-- 	L2C_PLAYER_LOGIN_ACK 								= 11001;   						--登入成功
-- 	L2C_PLAYER_BASEINFO_ACK 							= 11002;						--玩家基本信息
-- 	L2C_PLAYER_GAME_ROOM_CONFIG_ACK						= 11003;						--游戏房间基本配置
-- 	L2C_PLAYER_CREATE_ROOM_ACK 							= 11004;						--房间创建成功
-- 	L2C_PLAYER_ENTER_ROOM_ACK							= 11005;						--加入房间成功
-- 	L2C_PLAYER_MONEY_UPDATA_ACK							= 11006;						--货币更新成功
-- -------------------------------------------------------------------------------------------------------------------------------------
function Message_Def:parseMsg(msg, data)
    local fields = msg._fields
    for k1,v1 in pairs(fields) do
        if type(msg[k1.name]) == "table" then
            data[k1.name] = {}
            if #msg[k1.name] > 0 then
                for i2,v2 in ipairs(msg[k1.name]) do
                    local t = {}
                    self:parseMsg(msg[k1.name][i2], t)
                    data[k1.name][i2] = t
                end
            else
                self:parseMsg(msg[k1.name], data[k1.name])
            end
        else
            data[k1.name] = msg[k1.name]
        end
    end
end

function Message_Def:L2C_PLAYER_LOGIN_ACK(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_LOGIN_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    self:parseMsg(msg, T)
    return T
end

function Message_Def:L2C_PLAYER_BASEINFO_ACK(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_BASEINFO_ACK()
    msg:ParseFromString(msgData)

    print("playerInfo:"..#msg.playerInfo)

    local T = {}
    self:parseMsg(msg, T)
    return T
end

function Message_Def:L2C_PLAYER_GAME_ROOM_CONFIG_ACK(msgData)
    local msg = Message_pb.MSG_L2C_PLAYER_GAME_ROOM_CONFIG_ACK()
    msg:ParseFromString(msgData)

    dump(msg, "L2C_PLAYER_GAME_ROOM_CONFIG_ACK", 8)

    print(#msg.room_config)

    local T = {}
    self:parseMsg(msg, T)
    return T
end

function Message_Def:L2C_PLAYER_CREATE_ROOM_ACK()
    local msg = Message_pb.MSG_L2C_PLAYER_CREATE_ROOM_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    self:parseMsg(msg, T)
    return T
end

function Message_Def:L2C_PLAYER_ENTER_ROOM_ACK()
    local msg = Message_pb.MSG_L2C_PLAYER_ENTER_ROOM_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    self:parseMsg(msg, T)
    return T
end

function Message_Def:L2C_PLAYER_MONEY_UPDATA_ACK()
    local msg = Message_pb.MSG_L2C_PLAYER_MONEY_UPDATA_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    self:parseMsg(msg, T)
    return T
end

-- -------------------------------------------------------------------------------------------------------------------------------------
-- --客户端请求游戏服务器消息
-- 	C2M_PLAYER_ENTER_GAME_ROOM_SYN							= 21001;		--请求进入游戏房间
-- 	C2M_PLAYER_RECONNECT_GAME_SYN							= 21002;		--断线重连
-- 	C2M_PLAYER_SIT_DOWN_SYN									= 21003;		--请求坐下
-- 	C2M_PLAYER_READY_SYN									= 21004;		--玩家准备
-- 	C2M_PLAYER_LEAVE_ROOM_SYN								= 21005;		--玩家离开
-- 	C2M_PLAYER_DISMISS_ROOM_SYN								= 21006;		--请求房间解散
-- 	C2M_PLAYER_VOTE_SYN										= 21007;		--玩家解散投票
-- 	C2M_PLAYER_OUT_CARD_SYN									= 21008;		--玩家出牌
-- 	C2M_PLAYER_OPERATE_RESULT_SYN							= 21009;		--操作命令
-- 	C2M_PLAYER_TRUSTEE_SYN									= 21010;		--玩家托管
-- ----------------------------------------------------------------------------------------------------------------------------------------

function Message_Def:C2M_PLAYER_ENTER_GAME_ROOM_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_ENTER_GAME_ROOM_SYN()

    return msg:SerializeToString()
end

function Message_Def:C2M_PLAYER_RECONNECT_GAME_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_RECONNECT_GAME_SYN()

    return msg:SerializeToString()
end

function Message_Def:C2M_PLAYER_SIT_DOWN_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_SIT_DOWN_SYN()

    return msg:SerializeToString()
end

function Message_Def:C2M_PLAYER_READY_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_READY_SYN()

    return msg:SerializeToString()
end

function Message_Def:C2M_PLAYER_LEAVE_ROOM_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_LEAVE_ROOM_SYN()

    return msg:SerializeToString()
end

function Message_Def:C2M_PLAYER_DISMISS_ROOM_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_DISMISS_ROOM_SYN()

    return msg:SerializeToString()
end

function Message_Def:C2M_PLAYER_VOTE_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_VOTE_SYN()

    return msg:SerializeToString()
end

function Message_Def:C2M_PLAYER_OUT_CARD_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_OUT_CARD_SYN()

    return msg:SerializeToString()
end

function Message_Def:C2M_PLAYER_OPERATE_RESULT_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_OPERATE_RESULT_SYN()

    return msg:SerializeToString()
end

function Message_Def:C2M_PLAYER_TRUSTEE_SYN(data)
    local msg = Message_pb.MSG_C2M_PLAYER_TRUSTEE_SYN()

    return msg:SerializeToString()
end

-- ---------------------------------------------------------------------------------------------------------------------------------------
-- --游戏服务器发送给客户端的消息
-- 	M2C_PLAYER_ENTER_GAME_ROOM_SYN							= 22001;			--请求进入游戏房间成功
-- 	M2C_PLAYER_RECONNECT_GAME_ACK							= 22002;			--重连成功
-- 	M2C_PLAYER_BASEINFO_ACK									= 22003;			--玩家的基本信息
-- 	M2C_PLAYER_ROOM_BASEINFO_ACK							= 22004;			--桌子的基本信息
-- 	M2C_PLAYER_ROOM_FREE_SCENE_ACK							= 22005;			--桌子空闲场景消息
-- 	M2C_PLAYER_ROOM_PLAYING_SCENE_ACK						= 22006;			--桌子战斗场景消息
-- 	M2C_PLAYER_STATE_UPDATA_ACK								= 22007;			--玩家状态更新
-- 	M2C_PLAYER_ROOM_STATE_UPDATA_ACK						= 22008;			--桌子状态更新
-- 	M2C_PLAYER_SIT_DOWN_ACK									= 22009;			--玩家坐下成功
-- 	M2C_PLAYER_READY_ACK									= 22010;			--玩家准备成功
-- 	M2C_PLAYER_OPER_LEAVE_ROOM_ACK							= 22011;			--玩家离开成功
-- 	M2C_PLAYER_DISMISS_ROOM_ACK								= 22012;			--玩家解散房间成功
-- 	M2C_PLAYER_VOTE_SYN										= 22013;			--玩家投票成功
-- 	M2C_PLAYER_GAME_START_ACK								= 22014;			--游戏开始
-- 	M2C_PLAYER_MONEY_UPDATA_ACK								= 22015;			--货币更新
-- 	M2C_PLAYER_OPERATE_NOTIFY_ACK							= 22016;			--操作提示
-- 	M2C_PLAYER_OPERATE_RESULT_ACK							= 21017;			--操作命令
-- 	M2C_SUB_GAME_END_ACK									= 21018;			--游戏结束
-- 	M2C_SUB_GAME_END_ALL_ACK								= 21019;			--所有游戏结束
-- ----------------------------------------------------------------------------------------------------------------------------------------
function Message_Def:M2C_PLAYER_ENTER_GAME_ROOM_SYN()
    local msg = Message_pb.MSG_M2C_PLAYER_ENTER_GAME_ROOM_SYN()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_RECONNECT_GAME_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_RECONNECT_GAME_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_BASEINFO_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_BASEINFO_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_ROOM_BASEINFO_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_ROOM_BASEINFO_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_ROOM_FREE_SCENE_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_ROOM_FREE_SCENE_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_ROOM_PLAYING_SCENE_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_ROOM_PLAYING_SCENE_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_STATE_UPDATA_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_STATE_UPDATA_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_ROOM_STATE_UPDATA_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_ROOM_STATE_UPDATA_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_SIT_DOWN_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_SIT_DOWN_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_READY_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_READY_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_OPER_LEAVE_ROOM_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_OPER_LEAVE_ROOM_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_DISMISS_ROOM_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_DISMISS_ROOM_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_VOTE_SYN()
    local msg = Message_pb.MSG_M2C_PLAYER_VOTE_SYN()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_GAME_START_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_GAME_START_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_MONEY_UPDATA_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_MONEY_UPDATA_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_OPERATE_NOTIFY_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_OPERATE_NOTIFY_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_PLAYER_OPERATE_RESULT_ACK()
    local msg = Message_pb.MSG_M2C_PLAYER_OPERATE_RESULT_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_SUB_GAME_END_ACK()
    local msg = Message_pb.MSG_M2C_SUB_GAME_END_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

function Message_Def:M2C_SUB_GAME_END_ALL_ACK()
    local msg = Message_pb.MSG_M2C_SUB_GAME_END_ALL_ACK()
    msg:ParseFromString(msgData)

    local T = {}
    return T
end

return Message_Def
