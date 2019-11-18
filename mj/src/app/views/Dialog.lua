local SubLayer = import(".SubLayer")

local Dialog = class("Dialog", function()
    return SubLayer.new()
end)

function Dialog:ctor()
    self:initSub({size = cc.size(800, 480)})
    self.v_bg2 = self:addBg2()
    self.v_menuBg = self:addMenuBg()
end

function Dialog:display(text)
    
end

return Dialog
