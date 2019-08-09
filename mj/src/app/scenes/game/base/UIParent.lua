local UIParent = class("UIParent", function ()
    return display.newNode()
end)

function UIParent:ctor()
    
end

function UIParent:setPresenter(presenter)
    self.m_presenter = presenter
end

function UIParent:getPresenter()
    return self.m_presenter
end

return UIParent