local SubLayer = import("app.views.SubLayer")
local SettingLayer = class("SettingLayer", function()
    return SubLayer.new()
end)

-- local DIALOG_SIZE_WIDTH = 890
-- local DIALOG_SIZE_HEIGHT = 504

function SettingLayer:ctor(type)
    print("SettingLayer:ctor")
    self.m_settingType = type
    self:initSub({size = cc.size(890, 504)})
    self:addTitle("com_dialog_title_bg.png")
    self.v_bg = self:addBg2()
    self.v_menu_bg = self:addMenuBg()

    self:initView()
end

function SettingLayer:initView()
    if self.m_settingType == AppGlobal.SettingType.LOBBY then

    elseif self.m_settingType == AppGlobal.SettingType.CARD then

    elseif self.m_settingType == AppGlobal.SettingType.GOLD then

    end
end

return SettingLayer