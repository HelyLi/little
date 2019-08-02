local BaseView = import("app.views.BaseView")
local LoginPresenter = import(".LoginPresenter")


local LobbyLayer = class("LobbyLayer",function()
    return BaseView.new()
end)

function LobbyLayer:ctor()
    BaseView.initBase(self)
    self.m_presenter = LoginPresenter.new(self)
    self:initView()
end

function LobbyLayer:initView()
    self.m_bg = display.newSprite("BigBg/login_bg_skin.png"):align(display.CENTER, display.cx, display.cy):addTo(self)

    comui.Button({
        normal = "login_btn_yk_skin.png",
        pos = cc.p(display.cx, display.cy-135),
        callfunc = handler(self.m_presenter, self.m_presenter.audio),
        parent = self
    })
end

return LobbyLayer