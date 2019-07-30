local LoginLayer = import(".LoginLayer")

local LoginScene = class("LoginScene", function()
    return display.newScene("LoginScene")
end)

function LoginScene:ctor()
	local layer = LoginLayer.new()
    layer:align(display.CENTER, display.cx, display.cy)
    layer:addTo(self)
end

return LoginScene
