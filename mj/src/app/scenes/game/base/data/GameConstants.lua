GameConstants = GameConstants or {}

GameConstants.ROOM_UI = {

}

GameConstants.GAME_UI = {

}

GameConstants.Z_ORDER = {

}

GameConstants.TAG = {

}

GameConstants.PROCESS = {
    
}

GameConstants.CARD_TYPE = {
    WAN = 1,            --万
    TIAO = 2,           --条
    TONG = 3,           --筒
    FENG = 4,           --风
    HUA = 5,            --花
}

GameConstants.STAND_CARD_TYPE = {
    SHUIZI     = 1,            --顺子（吃）
    KEZI       = 2,            --刻子（碰）
    GANG_MING  = 3,            --明杠
    GANG_AN    = 4,            --暗杠
    GANG_JIA   = 5,            --加杠 
}

GameConstants.OP_TYPE = {
    NULL = 0,           --无
    CHI_LEFT = 1,       --左吃
    CHI_CENTER = 2,     --中吃
    CHI_RIGHT = 3,      --右吃
    PENG = 4,           --碰
    GANG_MING = 5,      --明杠
    GANG_AN = 6,        --暗杠
    GANG_JIA = 7,       --加杠
    CHI_HU = 8,         --吃胡
    ZI_MO = 9,          --自摸
    OUTCARD = 15,       --自摸
    CANCEL = 16,        --取消
}

GameConstants.HU_TYPE = {

}

GameConstants.ROOM_TYPE = {
    CARD = "card",
    GOLD = "gold",
    MATCH = "match"
}

GameConstants.HANDCARD_MODE = {
    NORMAL = 0,             --手牌正常显示
    DISPLAY = 1             --手牌明牌
}

GameConstants.CARD_NUM = {
    MAX_HAND = 14,          --最大手牌张数
    MAX_STAND = 5           --最大组合个数
}

GameConstants.GAME_STATUS = {
    WAITING = 0,
    PLAYING = 1,
    PLAYEND = 2
}


return GameConstants