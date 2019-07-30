local http = import("app.network.http.HttpCtrl")
local BaseView = import("app.views.BaseView")

local UpdateLayer = class("LobbyLayer",function()
    return  BaseView.new()
end)

function UpdateLayer:ctor()
    BaseView.initBase(self)
    self:initView()
end

function UpdateLayer:initView()
    self.m_bg = display.newSprite("BigBg/login_bg_skin.png"):align(display.CENTER, display.cx, display.cy):addTo(self)

    self.m_loadingBarBg = display.newSprite("#login_update_bg.png"):align(display.CENTER_BOTTOM,display.cx,160):addTo(self)

    self.m_loadingBar = ccui.LoadingBar:create()
    self.m_loadingBar:loadTexture("login_update_progress.png", ccui.TextureResType.plistType)
    self.m_loadingBar:setDirection(ccui.LoadingBarDirection.LEFT)
    self.m_loadingBar:align(display.BOTTOM_LEFT, 0, 0):addTo(self.m_loadingBarBg)

    -- self.m_loadingBar = cc.ui.UILoadingBar.new({
    --     scale9 = false,
    --     image =  "#login_update_progress.png",
    --     viewRect = cc.rect(0,0,706,25),
    --     percent = 0,
    --     direction = 1 
    -- }):align(display.BOTTOM_LEFT,0,0):addTo(self.m_loadingBarBg)

    self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function ()
        Game:getSceneMgr():goLoginScene()
    end)))

end

return UpdateLayer