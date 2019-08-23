local BaseNode = import("app.views.BaseNode")

local UIParent = class("UIParent", function ()
    return BaseNode.new()
end)

function UIParent:ctor()
    
end

function UIParent:setPresenter(presenter)
    self.m_presenter = presenter
end

function UIParent:getPresenter()
    return self.m_presenter
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