require("app.pb.Subgame_ID")
require("app.pb.Subgame_pb")

Subgame_Def = Subgame_Def or {}

AREA_TYPE ={
    xian_tao = 0,--仙桃
    tian_men = 1,--天门
    qian_jiang = 2,--潜江
}

HU_ACTION ={
    hu_no = 0,
    hu_zimo = 1,--自摸
    hu_dian_pao = 2,--点炮
    hu_gang_pao =3,--杠后炮
    hu_qiang_gang = 4,--抢杠胡
    hu_gang_kai = 5,--杠开
}

HU_FLAG = {
    invalid = 0,--
    gang_shang_pao = 1,-- 杠上炮
    gang_shang_hua = 2,-- 杠上花
    qiang_gang_hu = 3,-- 抢杠胡
}

-- C2M_PLAYER_DISCARD_SYN = 200000
-- C2M_MAHJONG_INTERCEPTED_EVENTS_SYN = 200001

function Subgame_Def:C2M_PLAYER_DISCARD_SYN(data)
    local msg = Subgame_pb.MSG_C2M_PLAYER_DISCARD_SYN()
    dump(msg, "C2M_PLAYER_DISCARD_SYN", 8)

    return msg:SerializeToString(), C2M_PLAYER_DISCARD_SYN 
end

function Subgame_Def:C2M_MAHJONG_INTERCEPTED_EVENTS_SYN(data)
    local msg = Subgame_pb.MSG_C2M_MAHJONG_INTERCEPTED_EVENTS_SYN()
    dump(msg, "C2M_MAHJONG_INTERCEPTED_EVENTS_SYN", 8)
    

    return msg:SerializeToString(), C2M_MAHJONG_INTERCEPTED_EVENTS_SYN  
end

-- M2C_GAME_START_NOTIFY = 100000
-- M2C_PLAYER_CATCH_CARD_NOTIFY = 100001
-- M2C_PLAYER_DISCARD_ACK = 100002
-- M2C_MAHJONG_INTERCEPTED_EVENTS_NOTIFY = 100003
-- M2C_MAHJONG_INTERCEPTED_DELETE_ACK = 100004
-- M2C_MAHJONG_INTERCEPTED_EVENTS_ACK = 100005
-- M2C_PLAYER_SCORE_CHANGE = 100006
-- M2C_GAME_END_NOTIFY = 100007
-- M2C_GAME_SUMMARIZATION_INFO_NOTIFY = 100008
-- M2C_ROOM_STATE_FREE_NOTIFY = 100020
-- M2C_ROOM_STATE_PLAYING_NOTIFY = 100021
function Message_Def:M2C_GAME_START_NOTIFY(msgData)
    local msg = Subgame_pb.MSG_M2C_GAME_START_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageid = 0, 
        gamestartinfo = {
            curgameround = 0, 
            bankerstation = 0, 
            curdiscardstation = 0, 
            lastdiscardstation = 0, 
            restcardnums = 0, 
            deletedcardnum = 0,
            actiontypevalue = 0,
            pengcardvalue = 0, 
            gangcardvalue = 0,
            handcardsinfo = {},
            sicecount = 0,
            replay_code = 0, 
            playerinfo = {},
            laiziinfo = {} 
        }
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_CATCH_CARD_NOTIFY(msgData)
    local msg = Subgame_pb.MSG_M2C_PLAYER_CATCH_CARD_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageid = 0, 
        actiontypevalue = 0,
        playerstation = 0, 
        cardvalue = 0, 
        handcardnums = 0, 
        handcards = 0,
        restcardnums = 0, 
        catchdirection = 0, 
        gangcardvalue = 0,
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_DISCARD_ACK(msgData)
    local msg = Subgame_pb.MSG_M2C_PLAYER_DISCARD_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageid = 0, 
        errorcode = 0, 
        playerstation = 0, 
        cardvalue = 0, 
        handcardnums = 0, 
        cardindex = 0, 
        handcards = 0,
        playerdiscards = 0,
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_MAHJONG_INTERCEPTED_EVENTS_NOTIFY(msgData)
    local msg = Subgame_pb.MSG_M2C_MAHJONG_INTERCEPTED_EVENTS_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageid = 0, 
        actiontypevalue = 0,
        playerstation = 0, 
        pengorhucardvalue = 0, 
        gangcardvalue = 0,
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_MAHJONG_INTERCEPTED_DELETE_ACK(msgData)
    local msg = Subgame_pb.MSG_M2C_MAHJONG_INTERCEPTED_DELETE_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageid = 0, 
        errorcode = 0, 
        clearaction = 0, 
        playerstation = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_MAHJONG_INTERCEPTED_EVENTS_ACK(msgData)
    local msg = Subgame_pb.MSG_M2C_MAHJONG_INTERCEPTED_EVENTS_ACK()
    msg:ParseFromString(msgData)

    local T = {
        messageid = 0, 
        errorcode = 0, 
        interceptedinfo = {
            operationcode = 0, 
            suboperationcode = 0, 
            havestation = 0, 
            bestation = 0, 
            operationdata = 0,
            operationdataindex = 0,
            gang_operate = 0, 
            hu_type = 0, 
            hu_station = 0,
        },
        handcardnums = 0,
        handcards = 0,
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_PLAYER_SCORE_CHANGE(msgData)
    local msg = Subgame_pb.MSG_M2C_PLAYER_SCORE_CHANGE()
    msg:ParseFromString(msgData)

    local T = {
        messageid = 0, 
        data = {}
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_GAME_SUMMARIZATION_INFO_NOTIFY(msgData)
    local msg = Subgame_pb.MSG_M2C_GAME_SUMMARIZATION_INFO_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageid = 0, 
        gamesummarizationinfo = {},
        end_type = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_ROOM_STATE_FREE_NOTIFY(msgData)
    local msg = Subgame_pb.MSG_M2C_ROOM_STATE_FREE_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageid = 0, 
        playerfree = {},
        game_time = 0, 
        currjushu = 0, 
    }
    ComFunc.parseMsg(msg, T)
    return T
end

function Message_Def:M2C_ROOM_STATE_PLAYING_NOTIFY(msgData)
    local msg = Subgame_pb.MSG_M2C_ROOM_STATE_PLAYING_NOTIFY()
    msg:ParseFromString(msgData)

    local T = {
        messageid = 0, 
        gamestartinfo = {
            curgameround = 0, 
            bankerstation = 0, 
            curdiscardstation = 0, 
            lastdiscardstation = 0, 
            restcardnums = 0, 
            deletedcardnum = 0,
            actiontypevalue = 0,
            pengcardvalue = 0, 
            gangcardvalue = 0,
            handcardsinfo = {},
            sicecount = 0,
            replay_code = 0, 
            playerinfo = {},
            laiziinfo = {} 
        },
        havediscardsinfo = {},
        havecpgmaininfo = {},
        playerinfo = {}
    }
    ComFunc.parseMsg(msg, T)
    return T
end

return Subgame_Def