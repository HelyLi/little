local BaseView = import("app.views.BaseView")

local CardLayer = class("LobbyLayer",function()
    return BaseView.new()
end)

function CardLayer:ctor()
    
    self:initBG()
end

function CardLayer:initBg()
    self.v_bg = display.newSprite(self:getBgImg()):align(display.CENTER, display.cx, display.cy):addTo(self)
end

function CardLayer:getBgImg()
    return "BigBg/game_four_bg.png"
end

return CardLayer