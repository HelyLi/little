local UIParent = import("app.scenes.game.base.UIParent")

local UIDeskOutCards = class("UIDeskOutCards", function()
    return UIParent.new()
end)

function UIDeskOutCards:ctor(container)
    self.m_container = container

    self:addTo(self.m_container)
end

return UIDeskOutCards