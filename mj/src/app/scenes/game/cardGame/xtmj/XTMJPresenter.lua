local CardPresenter = import("..base.CardPresenter")
local XTMJRoomData = import(".XTMJRoomData")
local XTMJPlayingData = import(".XTMJPlayingData")

local XTMJPresenter = class("XTMJPresenter",CardPresenter)

function XTMJPresenter:ctor(view)
    XTMJPresenter.super.ctor(self, view)
    self.m_roomData = XTMJRoomData.new()
    self.m_playingData = XTMJPlayingData.new()
end

function XTMJPresenter:onEnter()
    
end

function XTMJPresenter:onExit()
    
end

return XTMJPresenter