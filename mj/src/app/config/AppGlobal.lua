AppGlobal = {}

BACK_EVENT_TAG = 1000
FORE_EVENT_TAG = 1100

ZODER_LEVEL_0 = 100
ZODER_LEVEL_1 = 110
ZODER_LEVEL_2 = 120
ZODER_LEVEL_3 = 130
ZODER_LEVEL_4 = 140 
ZODER_LEVEL_5 = 150
ZODER_LEVEL_6 = 160
ZODER_LEVEL_MAX = 1000

APP_ENTER_BACKGROUND_EVENT = "APP_ENTER_BACKGROUND_EVENT"
APP_ENTER_FOREGROUND_EVENT = "APP_ENTER_FOREGROUND_EVENT"

XTMJ_CARD_GAME_ID = 255
QJMJ_CARD_GAME_ID = 260

AppGlobal.ChannelId = {
    ANDROID = 2,
    IOS = 3,
}

AppGlobal.LoginStatus = {

}

AppGlobal.LoginType = {

}

AppGlobal.ShopType = {
    CARD = "card",
    GOLD = "gold"
}

AppGlobal.SceneType = {
    LOGIN = 1,
    LOBBY = 2,
    GAME = 3,
    CLUB = 4
}

AppGlobal.CardPayType = {
    --房主付费
    FZ = 0,
    AA = 1,
    --会长付费
    AGENCY = 2,
    CLUBAA = 3
}

AppGlobal.EventMsg = {
    --user info --
    USER_INFO = "user_info",
    --view --
    DIALOG_EXIT_GAME = "dialog_exit_game",
    
    GAME_ROOM_CREATE = "game_room_create",
    GAME_ROOM_ADD = "game_room_add",
    LAYER_SETTING = "layer_setting",
    LAYER_SHARE = "layer_share",
    LAYER_HELP = "layer_help",
    LAYER_HISTORY = "layer_history",
    LAYER_ACTIVITY = "layer_activity",
    LAYER_SHOP = "layer_shop",

    SPEAKER_POP_UP = "speaker_pop_up",
    ACTIVITY_RED_REFRESH = "activity_red_refresh",
    --data
    SERVICE_TEST = "service_test"
}

AppGlobal.RoomOptonStyle = {
    SMALL = 1,
    NORMAL = 2,
    BIG = 3
}

return AppGlobal