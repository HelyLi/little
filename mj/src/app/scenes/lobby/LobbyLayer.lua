local BaseView = import("app.views.BaseView")
local LobbyPresenter = import(".LobbyPresenter")

--UI
local LobbyMainMenu = import("app.scenes.lobby.room.LobbyMainMenu")
local CreateRoomLayer = import("app.scenes.lobby.room.CreateRoomLayer")
local AddRoomLayer = import("app.scenes.lobby.room.AddRoomLayer")
local UserInfoLayer = import("app.scenes.lobby.subLayer.UserInfoLayer")


local LobbyLayer = class("LobbyLayer",function()
    return BaseView.new()
end)

function LobbyLayer:ctor()
    BaseView.initBase(self)
    self.m_presenter = LobbyPresenter.new(self)

    self:initView()
    self:regMsgHandler()
end

function LobbyLayer:initView()
    self.v_bg = display.newSprite("BigBg/lob_bg_skin.png"):align(display.CENTER, display.cx, display.cy):addTo(self)

    self.v_userInfo = UserInfoLayer.new():addTo(self)
    self.v_mainMenu = LobbyMainMenu.new():addTo(self)
    
    

end

function LobbyLayer:regMsgHandler()
    self:addMsgListener(AppGlobal.EventMsg.GAME_ROOM_CREATE, function ()
        
    end)
    self:addMsgListener(AppGlobal.EventMsg.GAME_ROOM_ADD, function ()
        
    end)
end

return LobbyLayer