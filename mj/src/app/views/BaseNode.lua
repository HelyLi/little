local BaseNode = class("BaseNode", function()
    return display.newNode()
end)

function BaseNode:ctor()
    print("BaseNode:ctor")
    self.m_eventListeners = {}
    self:regBaseEvent()
end

function BaseNode:regBaseEvent()
    local function onNodeEvent(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "exit" then
            self:onExit()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end

function BaseNode:onEnter()
    print("BaseNode:onEnter")
end

function BaseNode:onExit()
    print("BaseNode:onExit")
    Game:getEventDispatcher().removeListenersByTag(self)
    self.m_eventListeners = {}
end

--事件处理
function BaseNode:addMsgListener(eventname, callback)
    print("eventname:", eventname)
    Game:getEventDispatcher().addListener(eventname, callback, self)
    self.m_eventListeners[eventname] = callback
end

function BaseNode:removeMsgListener(eventname)
    Game:getEventDispatcher().removeListenerByNameAndTag(eventname, self)
    self.m_eventListeners[eventname] = nil
end


return BaseNode