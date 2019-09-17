local UIParent = import("app.scenes.game.base.UIParent")

local UIGameHuFlow = class("UIGameHuFlow", function()
    return UIParent.new()
end)

function UIGameHuFlow:ctor(container)
    self.m_container = container

    self:addTo(self.m_container)
end

return UIGameHuFlow