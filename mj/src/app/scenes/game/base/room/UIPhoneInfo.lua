local UIParent = import("app.scenes.game.base.UIParent")

local UIPhoneInfo = class("UIPhoneInfo", function ()
    return UIParent.new()
end)

function UIPhoneInfo:ctor(presenter, order, tag, roomType)
    self.m_presenter = presenter
    self.m_roomType = roomType

    self:addTo(presenter, order, tag)
end

function UIPhoneInfo:onEnter()
    
end

function UIPhoneInfo:onExit()
    
end

return UIPhoneInfo

