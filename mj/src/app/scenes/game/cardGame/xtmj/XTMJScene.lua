--麻将
local XTMJCardLayer = import(".XTMJCardLayer")

local XTMJScene = class("XTMJScene", function ()
    return display.newScene("XTMJScene")
end)

function XTMJScene:ctor()
    XTMJCardLayer.new():align(display.CENTER, display.cx, display.cy):addTo(self)
end

return XTMJScene