-- local BaseView = import("app.views.BaseView")
local CreateRoomGameXT = import(".CreateRoomGameXT")
local CreateRoomGameQJ = import(".CreateRoomGameQJ")

local CreateRoomFactory = class("CreateRoomFactory")

local CREATE_ROOM_GAME = {
    [XTMJ_CARD_GAME_ID] = CreateRoomGameXT,
    [QJMJ_CARD_GAME_ID] = CreateRoomGameQJ,
}

function CreateRoomFactory:ctor()
    
end

function CreateRoomFactory:createRoomLayer(gameId)
    print("gameId:", gameId)
    local CreateRoomGame = CREATE_ROOM_GAME[gameId]
    if CreateRoomGame then
        return CreateRoomGame.new()
    end
    return display.newNode()
end

return CreateRoomFactory