-- local BaseView = import("app.views.BaseView")
local GameLayer = import("app.scenes.game.base.GameLayer")
local GameConstants = import("app.scenes.game.base.data.GameConstants")

--RoomParts
local UIPhoneInfo = import("app.scenes.game.base.room.UIPhoneInfo")
local UIRoomId = import("app.scenes.game.cardGame.base.room.UIRoomId")
local UIDeskInfo = import("app.scenes.game.cardGame.base.room.UIRoomId")
local UIDeskMenu = import("app.scenes.game.cardGame.base.room.UIDeskMenu")
local UIWaitMenu = import("app.scenes.game.cardGame.base.room.UIWaitMenu")
local UIShareScreen = import("app.scenes.game.cardGame.base.room.UIShareScreen")

local UIPlayers = import("app.scenes.game.base.room.UIPlayers")
local UIGameHeart = import("app.scenes.game.base.room.UIGameHeart")
local UISpeaker = import("app.scenes.game.base.room.UISpeaker")

local UIMyPlayingCards = import("app.scenes.game.base.play.UIMyPlayingCards")
local UIPlayingCardsA = import("app.scenes.game.base.play.UIPlayingCardsA")
local UIPlayingCardsB = import("app.scenes.game.base.play.UIPlayingCardsB")
local UIPlayingCardsC = import("app.scenes.game.base.play.UIPlayingCardsC")

local UIDeskGoldCard = import("app.scenes.game.base.play.UIDeskGoldCard")
local UIDeskOutCards = import("app.scenes.game.base.play.UIDeskOutCards")
local UIGameDirection = import("app.scenes.game.base.play.UIDeskOutCards")
local UIGameInfo = import("app.scenes.game.base.play.UIGameInfo")
local GameFlow = import("app.scenes.game.base.play.GameFlow")
local UISendCardCtr = import("app.scenes.game.base.play.UISendCardCtr")
local UITipOpResult = import("app.scenes.game.base.play.UITipOpResult")
local UITipProcess = import("app.scenes.game.base.play.UITipProcess")
local UIGameHuFlow = import("app.scenes.game.base.play.UIGameHuFlow")

local SettingLayer = import("app.scenes.lobby.subLayer.SettingLayer")

local CardLayer = class("LobbyLayer",function()
    return GameLayer.new()
end)

function CardLayer:ctor()
    self:regRoomParts()
    self:regPlayParts()
end

function CardLayer:getBgImg()
    return "BigRes/game_four_bg.png"
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

    if self:isGameReplay() == false then
        --心跳
        self.m_UIRoomParts[GameConstants.ROOM_UI.GameHeart] = UIGameHeart.new(self)
        --桌面常用按钮
        self.m_UIRoomParts[GameConstants.ROOM_UI.DeskMenu] = UIDeskMenu.new(self, GameConstants.Z_ORDER.DeskMenu, GameConstants.TAG.DeskMenu)
        --等待游戏开始期间的按钮
        self.m_UIRoomParts[GameConstants.ROOM_UI.WaitMenu] = UIWaitMenu.new(self, GameConstants.Z_ORDER.WaitMenu, GameConstants.TAG.WaitMenu)
        --截屏分享
        self.m_UIRoomParts[GameConstants.ROOM_UI.ShareScreen] = UIShareScreen.new(self, GameConstants.Z_ORDER.ShareScreen, GameConstants.TAG.ShareScreen)
        --聊天
        --大喇叭
        self.m_UIRoomParts[GameConstants.ROOM_UI.Speaker] = UISpeaker.new(self, GameConstants.Z_ORDER.Speaker, GameConstants.TAG.Speaker, GameConstants.ROOM_TYPE.CARD)
        --雷达检测

    end
end

-- GameConstants.GAME_UI = {
--     MyPlayingCards = 1,
--     PlayingCardsA = 2,
--     PlayingCardsB = 3,
--     PlayingCardsC = 4,
--     GoldCardOnDesk = 5,
--     OutCardsOnDesk = 6,
--     GameDirection = 7,
--     RemainCards = 8,
--     GameFlow = 9,
--     PlayStatus = 10,
--     SendCardCtr = 11,
--     TipOpResult = 12,
--     TipProcess = 13,
-- }
function CardLayer:regPlayParts()
    self.m_UIPlayParts = {}
    --自己的麻将区
    self.m_UIPlayParts[GameConstants.GAME_UI.MyPlayingCards] = UIMyPlayingCards.new(self, GameConstants.Z_ORDER.MyPlayingCards)
    --
    self.m_UIPlayParts[GameConstants.GAME_UI.PlayingCardsA] = UIMyPlayingCards.new(self, GameConstants.Z_ORDER.PlayingCardsA)
    self.m_UIPlayParts[GameConstants.GAME_UI.PlayingCardsB] = UIMyPlayingCards.new(self, GameConstants.Z_ORDER.PlayingCardsB)
    self.m_UIPlayParts[GameConstants.GAME_UI.PlayingCardsC] = UIMyPlayingCards.new(self, GameConstants.Z_ORDER.PlayingCardsC)
    
    --桌上的金牌
    self.m_UIPlayParts[GameConstants.GAME_UI.DeskGoldCard] = UIDeskGoldCard.new(self, GameConstants.Z_ORDER.DeskGoldCard)
    --桌上玩家出的牌
    self.m_UIPlayParts[GameConstants.GAME_UI.DeskOutCards] = UIDeskOutCards.new(self, GameConstants.Z_ORDER.DeskOutCards)
    --东西南北
    self.m_UIPlayParts[GameConstants.GAME_UI.GameDirection] = UIGameDirection.new(self, GameConstants.Z_ORDER.GameDirection)
    --游戏展示信息
    self.m_UIPlayParts[GameConstants.GAME_UI.GameInfo] = UIGameInfo.new(self, GameConstants.Z_ORDER.GameInfo)
    
    --游戏流程
    self.m_UIPlayParts[GameConstants.GAME_UI.GameFlow] = GameFlow.new(self)
    --发牌控制
    self.m_UIPlayParts[GameConstants.GAME_UI.SendCardCtr] = UISendCardCtr.new(self)
    --操作提示
    self.m_UIPlayParts[GameConstants.GAME_UI.TipOpResult] = UITipOpResult.new(self, GameConstants.Z_ORDER.TipOpResult)
    --流程提示
    self.m_UIPlayParts[GameConstants.GAME_UI.TipProcess] = UITipProcess.new(self, GameConstants.Z_ORDER.TipProcess)
    --金牌动画
    --胡牌流程
    self.m_UIPlayParts[GameConstants.GAME_UI.GameHuFlow] = UIGameHuFlow.new(self, GameConstants.Z_ORDER.GameHuFlow)
end

function CardLayer:displaySetting()
    local settingLayer = SettingLayer.new(AppGlobal.SettingType.CARD):addTo(self, GameConstants.Z_ORDER.Setting)
end

function CardLayer:displayDialogOne(text, callback)
    local dialog = comui.showDialog({
        parent = self,
        tag = GameConstants.TAG.Dialog,
        text = text,
        callback1 = callback
    })
end

function CardLayer:displayDialogTwo(text, callback1, callback2)
    local dialog = comui.showDialog({
        parent = self,
        tag = GameConstants.TAG.Dialog,
        text = text,
        callback1 = callback1,
        callback2 = callback2
    })
end

return CardLayer