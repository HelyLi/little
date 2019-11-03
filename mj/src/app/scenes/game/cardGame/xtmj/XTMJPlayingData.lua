local GamePlayingData = import("app.scenes.game.base.data.GamePlayingData")

local XTMJPlayingData = class("XTMJPlayingData", GamePlayingData)

function XTMJPlayingData:ctor()
    XTMJPlayingData.super.ctor(self)
end



return XTMJPlayingData