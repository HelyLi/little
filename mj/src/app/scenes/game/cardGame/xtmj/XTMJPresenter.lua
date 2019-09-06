local CardPresenter = import("..base.CardPresenter")

local XTMJPresenter = class("XTMJPresenter",function()
    return CardPresenter.new()
end)

function XTMJPresenter:ctor()
    
end

function XTMJPresenter:onConnected()
    print("onConnected")
end

function XTMJPresenter:onEnter()
    
end

function XTMJPresenter:onExit()
    
end

return XTMJPresenter