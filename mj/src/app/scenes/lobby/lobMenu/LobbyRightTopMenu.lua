--右上角按钮
local BaseNode = import("app.views.BaseNode")

local LobbyRightTopMenu = class("LobbyLayer",function()
    return BaseNode.new()
end)

local TAG = {
    red = 1,
    activity = 100
}

function LobbyRightTopMenu:ctor()
    self:initMenu()
    self:regMsgHandler()
end

function LobbyRightTopMenu:initMenu()

    local menuConfigs = {
        --
        {normal = "", tag = TAG.activity, x = 100, y = 100, anchor = display.CENTER},
    }

    for i,config in ipairs(menuConfigs) do
        local btn = comui.Button({
            normal = config.normal,
            pos = cc.p(config.x, config.y),
            anchor = config.anchor,
            parent = self,
            tag = config.tag,
            callfunc = handler(self, self.menuCallback)
        })
        
        display.newSprite("#lob_red_icon.png"):align(display.RIGHT_TOP, W(btn), H(btn)):addTo(btn, 0, TAG.red):setVisible(false)
    end
end

function LobbyRightTopMenu:menuCallback(tag)
    if tag == TAG.activity then
        
    end
    local btn = self:getChildByTag(tag)
    local red = btn:getChildByTag(TAG.red)
    red:setVisible(false)
end

function LobbyRightTopMenu:regMsgHandler()
    self:addMsgListener(AppGlobal.EventMsg.ACTIVITY_RED_REFRESH, handler(self, self.refreshState))
end

function LobbyRightTopMenu:refreshState(data)
    
end

return LobbyRightTopMenu

