local BaseNode = import("app.views.BaseNode")

local MenuSprite = class("MenuSprite", function ()
    return BaseNode.new()
end)

--[[
    params.normal = nil
    params.selected = nil
    params.position = cc.p(0,0)
    params.anchor = display.CENTER
    params.tag = 0
    params.parent = 
    params.order = 
    params.callfunc = nil
]]

function MenuSprite:ctor(params)
    assert(params.normal or params.selected, "normalNode or selectedNode is nil")
    
    local n_size = SIZE(params.normal)
    local s_size = SIZE(params.selected)

    S_SIZE(self, math.max(n_size.width, s_size.width), math.max(n_size.height, s_size.height))

    self.v_normal = params.normal
    self.v_normal:align(display.CENTER, W2(self), H2(self)):addTo(self)

    self.v_selected = params.selected
    self.v_selected:align(display.CENTER, W2(self), H2(self)):addTo(self)

    self:align(params.anchor or display.CENTER, params.position.x,params.position.y):addTo(params.parent, params.order or 0, params.tag or 0)

    self.m_callback = params.callfunc or function() end
    self:addOnClick(handler(self, self.onClick))
    self:setTouchEnabled(true)
    self:unselected()
end

function MenuSprite:onClick(event)
    dump(event, "OnClick", 8)
    if event.name == "began" then
        self:selected()
    elseif event.name == "ended" then
        self:unselected()
        self.m_callback()
    end
end

function MenuSprite:selected()
    self.v_normal:setVisible(false)
    self.v_selected:setVisible(true)
end

function MenuSprite:unselected()
    self.v_normal:setVisible(true)
    self.v_selected:setVisible(false)
end

return MenuSprite
