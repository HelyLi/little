local LobbyLayer = import(".LobbyLayer")

local LobbyScene = class("LobbyScene", function()
    return display.newScene("LobbyScene")
end)

function LobbyScene:ctor()
	local layer = LobbyLayer.new()
    layer:align(display.CENTER, display.cx, display.cy)
    layer:addTo(self)
end

return LobbyScene