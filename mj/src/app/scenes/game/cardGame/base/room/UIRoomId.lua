local UIParent = import("app.scenes.game.base.UIParent")

local UIRoomId = class("UIRoomId", function ()
    return UIParent.new()
end)

function UIRoomId:ctor(container, order, tag)
    self.m_container = container

    self:addTo(container, order, tag)
end

function UIRoomId:onEnter()
    
end

function UIRoomId:onExit()
    
end

return UIRoomId