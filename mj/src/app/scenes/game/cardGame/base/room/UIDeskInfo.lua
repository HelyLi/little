local UIParent = import("app.scenes.game.base.UIParent")

local UIDeskInfo = class("UIDeskInfo", function ()
    return UIParent.new()
end)

function UIDeskInfo:ctor(container, order, tag)
    self.m_container = container

    self:addTo(container, order, tag)
end

function UIDeskInfo:onEnter()
    
end

function UIDeskInfo:onExit()
    
end

return UIDeskInfo