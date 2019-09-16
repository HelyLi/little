local CardRoomData = import("app.scenes.game.cardGame.base.data.CardRoomData")

local XTMJRoomData = class("XTMJRoomData", CardRoomData)

function XTMJRoomData:ctor()
    XTMJRoomData.super.ctor(self)
end

return XTMJRoomData