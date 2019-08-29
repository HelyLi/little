local BaseNode = class("BaseNode", function()
    return display.newNode()
end)

function BaseNode:ctor()
    print("BaseNode:ctor")
    self.m_touchSwallow = false
    self:setNodeEventEnabled(true)
    self:addTouchListener()
end

function BaseNode:onEnter()
    print("BaseNode:onEnter")
end

function BaseNode:onExit()
    print("BaseNode:onExit")
    Game:getEventDispatcher().removeListenersByTag(self)
end

--touch event
function BaseNode:onTouchBegan(touch)
    print("onTouchBegan")
    return self.m_touchSwallow and self:hitTest(touch)
end

function BaseNode:onTouchMoved(touch)

end

function BaseNode:onTouchEnded(touch)
    print("onTouchEnded")
end

function BaseNode:onTouchCancelled(touch)

end

function BaseNode:addTouchListener()
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
        self._touchListener:setSwallowTouches(self.m_touchSwallow)
        self._touchListener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
        self._touchListener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
        self._touchListener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
        self._touchListener:registerScriptHandler(onTouchCancelled,cc.Handler.EVENT_TOUCH_CANCELLED)
        self:getEventDispatcher():addEventListenerWithSceneGraphPriority(self._touchListener, self)
    end
end

function BaseNode:setSwallowTouches(swallow)
    self.m_touchSwallow = swallow
    self._touchListener:setSwallowTouches(swallow)
end

function BaseNode:removeTouchListener()
    if self._touchListener ~=nil then
        self:getEventDispatcher():removeEventListener(self._touchListener)
        self._touchListener = nil
    end
end

--事件处理
function BaseNode:addMsgListener(eventname, callback)
    Game:getEventDispatcher().addListener(eventname, callback, self)
end

function BaseNode:removeMsgListener(eventname)
    Game:getEventDispatcher().removeListenerByNameAndTag(eventname, self)
end

return BaseNode