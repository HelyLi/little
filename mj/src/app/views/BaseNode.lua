local BaseNode = class("BaseNode", function()
    return display.newNode()
end)

function BaseNode:ctor()
    print("BaseNode:ctor")
    self:setNodeEventEnabled(true)
end

function BaseNode:onEnter()
    print("BaseNode:onEnter")
end

function BaseNode:onExit()
    print("BaseNode:onExit")
    Game:getEventDispatcher().removeListenersByTag(self)
end

--事件处理
function BaseNode:addMsgListener(eventname, callback)
    Game:getEventDispatcher().addListener(eventname, callback, self)
end

function BaseNode:removeMsgListener(eventname)
    Game:getEventDispatcher().removeListenerByNameAndTag(eventname, self)
end

return BaseNode