local UIParent = import("app.scenes.game.base.UIParent")

local UIDeskMenu = class("UIDeskMenu", function()
    return UIParent.new()
end)

function UIDeskMenu:ctor(container, order, tag)
    self.m_container = container

    self:addTo(container, order, tag)
end

function UIDeskMenu:onEnter()
    
end

function UIDeskMenu:onExit()
    
end

return UIDeskMenu