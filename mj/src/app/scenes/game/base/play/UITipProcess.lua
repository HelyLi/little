local UIParent = import("app.scenes.game.base.UIParent")

local UITipProcess = class("UITipProcess", function()
    return UIParent.new()
end)

function UITipProcess:ctor(container)
    self.m_container = container

    self:addTo(self.m_container)
end

return UITipProcess