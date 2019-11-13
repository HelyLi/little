GameConstants = GameConstants or {}

GameConstants.ROOM_UI = {
    PhoneInfo = 1,
    RoomId = 2,
    DeskInfo = 3,
    DeskMenu = 4,
    WaitMenu = 5,
    GameHeart = 6,
    Speaker = 7,
    Players = 8,
    GameChat = 9,
    TrustMenu = 10,
    ShareScreen = 11
}

GameConstants.VIEW_ID = {
    My = 1,
    PlayerA = 2,
    PlayerB = 3,
    PlayerC = 4
}

GameConstants.GAME_UI = {
    MyPlayingCards = 1,
    PlayingCardsA = 2,
    PlayingCardsB = 3,
    PlayingCardsC = 4,
    DeskGoldCard = 5,
    DeskOutCards = 6,
    GameDirection = 7,
    GameInfo = 8,
    GameFlow = 9,
    -- PlayStatus = 10,
    SendCardCtr = 11,
    TipOpResult = 12,
    TipProcess = 13,
    GameHuFlow = 14,
}

GameConstants.Z_ORDER = {
    PhoneInfo = 1,
    RoomId = 5,
    DeskInfo = 10,
    Players = 15,
    DeskMenu = 20,
    WaitMenu = 25,
    Setting = 30,
    ShareScreen = 30,
    Speaker = 35,
    MyPlayingCards = 1,
    PlayingCardsA = 2,
    PlayingCardsB = 3,
    PlayingCardsC = 4,
    DeskGoldCard= 5,
    DeskOutCards = 6,
    GameDirection = 7,
    GameInfo = 8,
    GameFlow = 9,
    PlayStatus = 10,
    SendCardCtr = 11,
    TipOpResult = 12,
    TipProcess = 13,
    GameHuFlow = 14
}

GameConstants.TAG = {
    PhoneInfo = 1,
    RoomId = 2,
    DeskInfo = 3,
    Players = 4,
    DeskMenu = 5,
    WaitMenu = 6,
    ShareScreen = 7,
    Speaker = 8
}

GameConstants.CARD_TAG = {
    TXT_B       = 10,
    TXT_M       = 11,
    ZZ_ORANGE   = 12
}

GameConstants.PROCESS = {
    NONE                = 0,
    GAME_START          = 1,    --开局
    SHOW_BANKER         = 2,    --定庄家
    ROCK_DICE           = 3,    --摇骰子
    START_SEND_CARD     = 4,    --开局
    OPEN_GOLD_CARD      = 5,    --翻金牌
    SORT_HANDCARD       = 6,    --刷新手牌
    GAME_END_LIUJU      = 7,    --流局
    GAME_END_HU         = 8,    --胡牌
    GAME_END_RESULT     = 9,    --结算
}

GameConstants.CARD_TYPE = {
    WAN     = 1,            --万
    TIAO    = 2,            --条
    TONG    = 3,            --筒
    FENG    = 4,            --风
    HUA     = 5,            --花
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