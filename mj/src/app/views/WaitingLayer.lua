local BaseView = import(".BaseView")

local TAG = {
    ZZ_LAYER = 100,
    CIRCLE = 101
}

local WaitingLayer = class("WaitingLayer",function ()
  return BaseView.new()
end)

function WaitingLayer:ctor()
    BaseView.initBase(self)
    self:setSwallowTouches(false)
    self:initView()
end

function WaitingLayer:initView()
    local waitSprite = self:getChildByTag(TAG.ZZ_LAYER)

    if waitSprite ~= nil then
        waitSprite:removeFromParent()
    end

    waitSprite = display.newSprite("#".."com_loading_bg.png")
    waitSprite:align(display.CENTER,display.cx,display.cy):addTo(self,0,TAG.ZZ_LAYER)

    local circleSprite = display.newSprite("#".."com_loading.png")
    circleSprite:align(display.CENTER,W2(waitSprite),H2(waitSprite)):addTo(waitSprite,0,TAG.CIRCLE)
    circleSprite:runAction(cc.RepeatForever:create(cc.RotateBy:create(1.5,360)))
end

function WaitingLayer:setDisplayTime(time)
    self:performWithDelay(function() self:dismiss() end, time)
end

--禁止触摸，拦截所有点击
function WaitingLayer:setTouchProhibit(touchProhibit)
    if touchProhibit == true then
        self:setSwallowTouches(true)
    end
end


return WaitingLayer
