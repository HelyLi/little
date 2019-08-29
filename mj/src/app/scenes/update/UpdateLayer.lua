local http = import("app.network.http.HttpCtrl")
local BaseView = import("app.views.BaseView")
local UpdatePresenter = import(".UpdatePresenter")

local UpdateLayer = class("LobbyLayer",function()
    return  BaseView.new()
end)

function UpdateLayer:ctor()
    self.m_presenter = UpdatePresenter.new(self)
    self:initView()
end

function UpdateLayer:initView()
    self.v_bg = display.newSprite("BigBg/login_bg_skin.png"):align(display.CENTER, display.cx, display.cy):addTo(self)
    self:displayVersion()
    
    self.v_loadingBarBg = display.newSprite("#login_update_bg.png"):align(display.CENTER_BOTTOM,display.cx,160):addTo(self)

    self.v_loadingBar = ccui.LoadingBar:create()
    self.v_loadingBar:loadTexture("login_update_progress.png", ccui.TextureResType.plistType)
    self.v_loadingBar:setDirection(ccui.LoadingBarDirection.LEFT)
    self.v_loadingBar:setPercent(0)
    self.v_loadingBar:align(display.BOTTOM_LEFT, 0, 0):addTo(self.v_loadingBarBg)

    self.v_loadingTip = display.newTTFLabel({
        text = "正在检查资源更新...",
        size = 40,
        color = display.COLOR_WHITE
    }):align(display.CENTER_BOTTOM,display.cx,200):addTo(self)

    self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function ()
        Game:getSceneMgr():goLoginScene()
    end)))
end

function UpdateLayer:displayVersion()
    if self.v_version == nil then
        self.v_version = display.newTTFLabel({
            text = string.format("App V%s Res V%s", Game:getAppConfig():getAppVersion(), Game:getAppConfig():getLocalResVersion()),
            size = 27,
        })
        self.v_version:align(display.TOP_LEFT, 16 + UIAdapter.padding,display.top-10):addTo(self)
    else
        self.v_version:setString(string.format("App V%s Res V%s", Game:getAppConfig():getAppVersion(), Game:getAppConfig():getLocalResVersion()))
    end
end

return UpdateLayer