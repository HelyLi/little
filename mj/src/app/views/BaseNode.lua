local BaseNode = class("BaseNode", function()
    return display.newNode()
end)

function BaseNode:ctor()

end

function BaseNode:initBase()
    self._listenerId = {}
    self:regBaseEvent()
end

function BaseNode:onEnter()

end

function BaseNode:onExit()
    self:removeAllMsgListener()
end

return BaseNode