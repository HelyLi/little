require("app.pb.Subgame_pb")
--消息在此处解析和组合
Subgame_Def = Subgame_Def or {}

NULL = 0
M2C_GAME_START_NOTIFY = 1000
M2C_PLAYER_CATCH_CARD_NOTIFY = 1001
M2C_PLAYER_DISCARD_ACK = 1002
M2C_MAHJONG_INTERCEPTED_EVENTS_NOTIFY = 1003
M2C_MAHJONG_INTERCEPTED_DELETE_ACK = 1004
M2C_MAHJONG_INTERCEPTED_EVENTS_ACK = 1005
M2C_PLAYER_SCORE_CHANGE = 1006
M2C_GAME_END_NOTIFY = 1007
M2C_GAME_SUMMARIZATION_INFO_NOTIFY = 1008
M2C_ROOM_STATE_FREE_NOTIFY = 1020
M2C_ROOM_STATE_PLAYING_NOTIFY = 1021
C2M_PLAYER_DISCARD_SYN = 2000
C2M_MAHJONG_INTERCEPTED_EVENTS_SYN = 2001

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

AREA_TYPE =
{
    xian_tao = 0,-- 仙桃
    tian_men = 1,-- 天门
    qian_jiang = 2-- 潜江
}

HU_ACTION =
{
    hu_no = 0,
    hu_zimo = 1,--自摸
    hu_dian_pao = 2,--点炮
    hu_gang_pao =3,--杠后炮
    hu_qiang_gang = 4,--抢杠胡
    hu_gang_kai = 5,--/杠开
}

HU_FLAG =
{
    invalid = 0;
    gang_shang_pao = 1,--杠上炮
    gang_shang_hua = 2,--杠上花
    qiang_gang_hu = 3,--抢杠胡
}


