--麻将
local XTMJPresenter = import(".XTMJPresenter")
local CardLayer = import("..base.CardLayer")
local XTMJScene = class("XTMJScene", function ()
    return display.newScene("XTMJScene")
end)

function XTMJScene:ctor()
    local layer = CardLayer.new():align(display.CENTER, display.cx, display.cy):addTo(self)
    self.m_presenter = XTMJPresenter.new(layer)
end

function XTMJScene:getGamePresenter()
    return self.m_presenter
end

function XTMJScene:onEnter()
    if self.m_presenter then
        self.m_presenter:onEnter()
    end
end

function XTMJScene:onExit()
    if self.m_presenter then
        self.m_presenter:onExit()
    end
end

return XTMJScene