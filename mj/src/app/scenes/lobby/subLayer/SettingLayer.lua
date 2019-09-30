local ComLayer = import("app.views.ComLayer")
local SettingLayer = class("SettingLayer", function()
    return ComLayer.new()
end)

function SettingLayer:ctor()
    print("SettingLayer:ctor")
end

return SettingLayer