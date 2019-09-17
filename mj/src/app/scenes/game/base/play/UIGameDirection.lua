local UIParent = import("app.scenes.game.base.UIParent")

local UIGameDirection = class("UIGameDirection", function()
    return UIParent.new()
end)

function UIGameDirection:ctor(container)
    self.m_container = container

    self:addTo(self.m_container)
end

return UIGameDirection