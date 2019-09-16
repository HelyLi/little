local UIParent = import("app.scenes.game.base.UIParent")

local UIMyPlayingCards = class("UIMyPlayingCards", function()
    return UIParent.new()
end)

function UIMyPlayingCards:ctor(container, order)
    self.m_container = container
    self.m_viewId = GameConstants.VIEW_ID.PlayerA
    
end

return UIMyPlayingCards