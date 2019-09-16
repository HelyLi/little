local BaseNode = import("app.views.BaseNode")

local UIParent = class("UIParent", function ()
    return BaseNode.new()
end)

function UIParent:ctor()
    
end

function UIParent:setContainer(container)
    self.m_container = container
end

function UIParent:getContainer()
    return self.m_container
end

function UIParent:onEnter()
    print("UIParent:onEnter")
    BaseNode.onEnter(self)
end

function UIParent:onExit()
    print("UIParent:onExit")
    BaseNode.onExit(self)
end

function UIParent:clear()
    
end

function UIParent:updateAll()
    
end

return UIParent