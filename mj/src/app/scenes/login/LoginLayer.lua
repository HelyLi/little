local BaseView = import("app.views.BaseView")
local LoginPresenter = import(".LoginPresenter")

local LoginLayer = class("LobbyLayer",function()
    return BaseView.new()
end)

function LoginLayer:ctor()
    self.m_presenter = LoginPresenter.new(self)
    self:initView()
end

function LoginLayer:initView()
    self.v_bg = display.newSprite("BigRes/lob_bg.png"):align(display.CENTER, display.cx, display.cy):addTo(self)

    comui.Button({
        normal = "login_btn_wx.png",
        pos = cc.p(display.cx - 200, display.cy-135),
        callfunc = handler(self.m_presenter, self.m_presenter.toLogin),
        parent = self
    })

    comui.Button({
        normal = "login_btn_wx.png",
        pos = cc.p(display.cx + 200, display.cy-135),
        callfunc = handler(self.m_presenter, self.m_presenter.toLogin1),
        parent = self
    })

end

return LoginLayer