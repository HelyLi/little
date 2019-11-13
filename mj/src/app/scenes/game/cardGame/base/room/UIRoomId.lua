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

function UIRoomId:initView()
    
    comui.serialize({

    })
end

function UIRoomId:display(roomid)
    
    local label = display.newTTFLabel({
        text = tostring(roomid),
        size = 30,
        align = cc.TEXT_ALIGNMENT_CENTER -- 文字内部居中对齐
    }):align(display.CENTER_RIGHT, display.width - 100 - UIAdapter.paddingR, display.height - 50):addTo(self)

end

return UIRoomId