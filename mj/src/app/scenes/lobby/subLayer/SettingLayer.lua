local SubLayer = import("app.views.SubLayer")
local SettingLayer = class("SettingLayer", function()
    return SubLayer.new()
end)

-- local DIALOG_SIZE_WIDTH = 890
-- local DIALOG_SIZE_HEIGHT = 504

function SettingLayer:ctor()
    print("SettingLayer:ctor")
    
    self:initView()

end

function SettingLayer:initView()
    self:initSub({size = cc.size(890, 504)})
    self.v_bg = self:addBg2()
    self.v_menu_bg = self:addMenuBg()
end




return SettingLayer