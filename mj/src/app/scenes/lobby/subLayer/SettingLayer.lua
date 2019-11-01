local SubLayer = import("app.views.SubLayer")
local SettingLayer = class("SettingLayer", function()
    return SubLayer.new()
end)

function SettingLayer:ctor()
    print("SettingLayer:ctor")
end



return SettingLayer