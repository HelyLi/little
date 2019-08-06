local BaseView = import("app.views.BaseView")
local LobbyPresenter = import(".LobbyPresenter")


local LobbyLayer = class("LobbyLayer",function()
    return BaseView.new()
end)

function LobbyLayer:ctor()
    BaseView.initBase(self)
    self.m_presenter = LobbyPresenter.new(self)
    self:initView()
end

function LobbyLayer:initView()
    self.m_bg = display.newSprite("BigBg/login_bg_skin.png"):align(display.CENTER, display.cx, display.cy):addTo(self)

    comui.Button({
        normal = "login_btn_yk_skin.png",
        pos = cc.p(display.cx, display.cy-135),
        callfunc = handler(self.m_presenter, self.m_presenter.MSG_L2D_PLAYER_LOGIN_SYN),
        parent = self
    })
end

return LobbyLayer