BaseView = class("BaseView",function()
    return display.newLayer()
end)

function BaseView:ctor()
    print("BaseView:ctor")
    self:initBase()
end

function BaseView:initBase()
    self:initBaseData()
    self:setContentSize(display.size)
    self:setNodeEventEnabled(true)
    self:addTouchListener()
end

function BaseView:initBaseData()
    self.m_keyCanClose = true
    self.m_touchListener = nil
    self.m_isTouchSwallow = true
end

function BaseView:onEnter()
    print("BaseView:onEnter")
end

function BaseView:onExit()
    print("BaseView:onExit")
    Game:getEventDispatcher().removeListenersByTag(self)
end

function BaseView:onTouchBegan(touch)
    return self.m_isTouchSwallow
end

function BaseView:onTouchMoved(touch)

end

function BaseView:onTouchEnded(touch)

end

function BaseView:onTouchCancelled(touch)

end

function BaseView:addTouchListener()
    local function onTouchBegan(touch, event)
        return self.onTouchBegan(self,touch:getLocation())
    end

    local function onTouchMoved(touch, event)
        self.onTouchMoved(self,touch:getLocation())
    end

    local function onTouchEnded(touch, event)
        self.onTouchEnded(self,touch:getLocation())
    end

    local function onTouchCancelled(touch, event)
        self.onTouchCancelled(self,touch:getLocation())
    end

    if self._touchListener == nil and self ~= nil then
        self._touchListener = cc.EventListenerTouchOneByOne:create()
        self._touchListener:setSwallowTouches(self._isTouchSwallow)
        self._touchListener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
        self._touchListener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
        self._touchListener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
        self._touchListener:registerScriptHandler(onTouchCancelled,cc.Handler.EVENT_TOUCH_CANCELLED)
        self:getEventDispatcher():addEventListenerWithSceneGraphPriority(self._touchListener, self)
    end
end

function BaseView:setSwallowTouches(isSwallow)
    self._isTouchSwallow = isSwallow
    if self._touchListener ~= nil then
        self._touchListener:setSwallowTouches(isSwallow)
    end
end

function BaseView:removeTouchListener()
    if self._touchListener ~=nil then
        self:getEventDispatcher():removeEventListener(self._touchListener)
        self._touchListener = nil
    end
end

--事件处理
function BaseView:addMsgListener(eventname, callback)
    Game:getEventDispatcher().addListener(eventname, callback, self)
end

function BaseView:removeMsgListener(eventname)
    Game:getEventDispatcher().removeListenerByNameAndTag(eventname, self)
end

function BaseView:dismiss()
    self:dismissCallBack()
    if self ~= nil and self:getParent() ~= nil then
        self:stopAllActions()
        self:removeFromParent()
    end
end

function BaseView:dismissCallBack()
    
end

return BaseView