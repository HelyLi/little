local UIParent = import("app.scenes.game.base.UIParent")

local UIDeskMenu = class("UIDeskMenu", function()
    return UIParent.new()
end)

function UIDeskMenu:ctor(container, order, tag)
    self.m_container = container
    self:initMenu()
    self:addTo(container, order, tag)
end

function UIDeskMenu:onEnter()
    
end

function UIDeskMenu:onExit()
    
end

function UIDeskMenu:initMenu()
    --设置
    comui.Button({
        normal = "mj_bt_setting.png",
        pos = cc.p(display.width - 8 - UIAdapter.paddingR, display.height - 8),
        callfunc = function ()
            self.m_container:displaySetting()
        end,
        anchor = display.TOP_RIGHT,
        parent = self
    })

    --重新连接
    comui.Button({
        normal = "mj_bt_reconnect.png",
        pos = cc.p(18 + UIAdapter.paddingL, display.height - 70),
        callfunc = function ()
            
        end,
        anchor = display.TOP_LEFT,
        parent = self
    })
end

return UIDeskMenu