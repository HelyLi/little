local UIParent = import("app.scenes.game.base.UIParent")

local UITipOpResult = class("UITipOpResult", function()
    return UIParent.new()
end)

function UITipOpResult:ctor(container)
    self.m_container = container

    self:addTo(self.m_container)
end

return UITipOpResult