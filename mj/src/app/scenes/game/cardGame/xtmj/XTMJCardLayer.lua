local CardLayer = import("..base.CardLayer")
local XTMJPresenter = import(".XTMJPresenter")

local XTMJCardLayer = class("XTMJCardLayer", function()
    return CardLayer.new()
end)

function XTMJCardLayer:ctor()
    self.m_presenter = XTMJPresenter.new(self)
end

function XTMJCardLayer:getPresenter()
    return self.m_presenter
end

function XTMJCardLayer:onEnter()
    if self.m_presenter then
        self.m_presenter:onEnter()
    end
end

function XTMJCardLayer:onExit()
    if self.m_presenter then
        self.m_presenter:onExit()
    end
end

return XTMJCardLayer