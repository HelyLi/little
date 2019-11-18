local UIParent = import("app.scenes.game.base.UIParent")

local UIWaitMenu = class("UIWaitMenu", function()
    return UIParent.new()
end)

function UIWaitMenu:ctor(container, order, tag)
    self.m_container = container
    self:initMenu()
    self:addTo(container, order, tag)
end

function UIWaitMenu:onEnter()
    
end

function UIWaitMenu:onExit()
    
end

function UIWaitMenu:initMenu()
    --解散房间
    comui.Button({
        normal = "com_red_btn.png",
        text = "解散房间",
        fontSize = 35,
        pos = cc.p(display.width - 34 - UIAdapter.paddingR, UIAdapter.adRatioY(109)),
        callfunc = function ()
            
        end,
        anchor = display.TOP_RIGHT,
        parent = self
    })

    --返回大厅
    comui.Button({
        normal = "com_green_btn.png",
        text = "返回大厅",
        fontSize = 35,
        pos = cc.p(34 + UIAdapter.paddingL, UIAdapter.adRatioY(109)),
        callfunc = function ()
            
        end,
        anchor = display.TOP_LEFT,
        parent = self
    })
end

return UIWaitMenu