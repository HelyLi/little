local UIParent = import("app.scenes.game.base.UIParent")

local UIDeskGoldCard = class("UIDeskGoldCard", function()
    return UIParent.new()
end)

function UIDeskGoldCard:ctor(container)
    self.m_container = container

    self:addTo(self.m_container)
end

return UIDeskGoldCard