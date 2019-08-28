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

AppGlobal.LoginStatus = {

}

AppGlobal.LoginType = {

}

AppGlobal.ShopType = {
    card = "card",
    gold = "gold"
}

AppGlobal.SceneType = {
    login = 1,
    lobby = 2,
    game = 3,
    club = 4
}

AppGlobal.CardPayType = {
    --房主付费
    fz = 0,
    aa = 1,
    --会长付费
    agency = 2,
    clubaa = 3
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

    SPEAKER_POP_UP = "speaker_pop_up"
    --data
}

return AppGlobal