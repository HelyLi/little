local UIParent = import("app.scenes.game.base.UIParent")

local UIGameInfo = class("UIGameInfo", function()
    return UIParent.new()
end)

function UIGameInfo:ctor(container)
    self.m_container = container

    self:addTo(self.m_container)
end

return UIGameInfo