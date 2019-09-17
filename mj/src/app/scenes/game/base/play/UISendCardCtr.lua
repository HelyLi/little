local UIParent = import("app.scenes.game.base.UIParent")

local UISendCardCtr = class("UISendCardCtr", function()
    return UIParent.new()
end)

function UISendCardCtr:ctor(container)
    self.m_container = container

    self:addTo(self.m_container)
end

return UISendCardCtr