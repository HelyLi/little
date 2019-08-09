local UIParent = import("app.scenes.game.base.UIParent")

local UISpeaker = class("UISpeaker", function ()
    return UIParent.new()
end)

function UISpeaker:ctor(presenter, order, tag, roomType)
    self.m_presenter = presenter
    self.m_roomType = roomType

    self:addTo(presenter, order, tag)
end

function UISpeaker:onEnter()
    
end

function UISpeaker:onExit()
    
end

return UISpeaker
