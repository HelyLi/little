local BaseNode = import("app.views.BaseNode")
local LobbyRightTopMenu = import(".LobbyRightTopMenu")

local LobbyMenu = class("LobbyLayer",function()
    return BaseNode.new()
end)

local TAG = {
    shop = 100,
}

function LobbyMenu:ctor()
    
end

function LobbyMenu:initMenu()
    local bg =  display.newScale9Sprite("#lob_menu_bg_skin.png", 0, 0, cc.size(display.width - UIAdapter.paddingL - UIAdapter.paddingR, 68), cc.rect(500, 45, 42, 8))
	bg:align(display.BOTTOM_CENTER, display.cx, 0):addTo(self)

    local menuConfigs = {
        --
        {normal = "", tag = TAG.shop, x = 100, y = 100, anchor = display.CENTER},
    }

    for i,config in ipairs(menuConfigs) do
        comui.Button({
            normal = config.normal,
            pos = cc.p(config.x, config.y),
            anchor = config.anchor,
            parent = bg,
            tag = config.tag,
            callfunc = handler(self, self.menuCallback)
        })
    end

end

function LobbyMenu:menuCallback(tag)
    if tag == TAG.shop then

    end
end

function LobbyMenu:onExit()
    
end

return LobbyMenu
