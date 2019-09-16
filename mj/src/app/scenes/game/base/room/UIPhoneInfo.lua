local UIParent = import("app.scenes.game.base.UIParent")

local UIPhoneInfo = class("UIPhoneInfo", function ()
    return UIParent.new()
end)

function UIPhoneInfo:ctor(container, order, tag, roomType)
    self.m_container = container
    self.m_roomType = roomType

    self:addTo(container, order, tag)
end

function UIPhoneInfo:onEnter()
    
end

function UIPhoneInfo:onExit()
    
end

return UIPhoneInfo

