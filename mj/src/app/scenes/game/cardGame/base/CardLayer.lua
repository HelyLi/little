-- local BaseView = import("app.views.BaseView")
local GameLayer = import("app.scenes.game.base.GameLayer")
local GameConstants = import("app.scenes.game.base.data.GameConstants")

--RoomParts
local UIPhoneInfo = import("app.scenes.game.base.room.UIPhoneInfo")
local UIRoomId = import("app.scenes.game.cardGame.base.room.UIRoomId")
local UIDeskInfo = import("app.scenes.game.cardGame.base.room.UIRoomId")

local UIPlayers = import("app.scenes.game.base.room.UIPlayers")

local CardLayer = class("LobbyLayer",function()
    return GameLayer.new()
end)

function CardLayer:ctor()
    
end

function CardLayer:getBgImg()
    return "BigBg/game_four_bg.png"
end

-- GameConstants.ROOM_UI = {
--     PHONE_INFO = 1,
--     ROOM_ID = 2,
--     DESK_INFO = 3,
--     DESK_MENU = 4,
--     WAIT_MENU = 5,
--     GAME_HEART = 6,
--     SPEAKER = 7,
--     PLAYERS = 8,
--     GAME_CHAT = 9,
--     TRUST_MENU = 10,
-- }

-- GameConstants.ROOM_TYPE = {
--     CARD = "card",
--     GOLD = "gold",
--     MATCH = "match"
-- }
function CardLayer:regRoomParts()
    self.m_UIRoomParts = {}
    --手机信息
    self.m_UIRoomParts[GameConstants.ROOM_UI.PhoneInfo] = UIPhoneInfo.new(self, GameConstants.Z_ORDER.PhoneInfo, GameConstants.TAG.PhoneInfo, GameConstants.ROOM_TYPE.CARD)
    --房间信息
    self.m_UIRoomParts[GameConstants.ROOM_UI.RoomId] = UIRoomId.new(self, GameConstants.Z_ORDER.RoomId, GameConstants.TAG.RoomId)
    --桌子信息
    self.m_UIRoomParts[GameConstants.ROOM_UI.DeskInfo] = UIDeskInfo.new(self, GameConstants.Z_ORDER.DeskInfo, GameConstants.TAG.DeskInfo)
    --玩家
    self.m_UIRoomParts[GameConstants.ROOM_UI.Players] = UIPlayers.new(self, GameConstants.Z_ORDER.Players, GameConstants.TAG.Players, GameConstants.ROOM_TYPE.CARD)

    
end

function CardLayer:regPlayParts()
    
end

return CardLayer