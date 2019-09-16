local UIParent = import("app.scenes.game.base.UIParent")

local UIShareScreen = class("UIShareScreen", function()
    return UIParent.new()
end)

function UIShareScreen:ctor(container, order, tag)
    self.m_container = container

    self:addTo(container, order, tag)
end

function UIShareScreen:onEnter()
    
end

function UIShareScreen:onExit()
    
end

return UIShareScreen