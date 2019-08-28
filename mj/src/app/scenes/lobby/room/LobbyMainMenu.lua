local BaseView = import("app.views.BaseView")
local LobbyMainMenu = class("LobbyMainMenu", function()
    return BaseView.new()
end)

local TAG = {
    ROOM_CREATE_BTN = 0x01,
    ROOM_ADD_BTN    = 0x02
}

function LobbyMainMenu:ctor()
    self:init()
end

function LobbyMainMenu:init()
    BaseView.initBase(self)
    self:regMsgHandler()
    self:initRoomMenu()
end

function LobbyMainMenu:onExit()
    BaseView.onExit(self)
end

function LobbyMainMenu:regMsgHandler()
    
end

function LobbyMainMenu:initRoomMenu()
    
    --加入房间
    comui.Button({
        normal = "lob_room_b_skin.png",
        pos = cc.p(UIAdapter.adUIRatioX(1131 - UIAdapter.paddingRight), UIAdapter.adUIRatioY(293 - 265)),
        tag = TAG.ROOM_ADD_BTN,
        anchor = display.CENTER_TOP,
        callfunc = handler(self, self.menuCallback),
        parent = self
    })

    --创建房间
    comui.Button({
        normal = "lob_room_a_skin.png",
        pos = cc.p(UIAdapter.adUIRatioX(891 - UIAdapter.paddingRight), UIAdapter.adUIRatioY(272 - 285)),
        tag = TAG.ROOM_CREATE_BTN,
        anchor = display.CENTER_TOP,
        callfunc = handler(self, self.menuCallback),
        parent = self
    })

end

function LobbyMainMenu:menuCallback(tag)
    if tag == TAG.ROOM_ADD_BTN then
        Game:getEventDispatcher().pushEvent(AppGlobal.EventMsg.GAME_ROOM_ADD)
    elseif tag == TAG.ROOM_CREATE_BTN then
        Game:getEventDispatcher().pushEvent(AppGlobal.EventMsg.GAME_ROOM_CREATE)
    end
end


return LobbyMainMenu