local UIParent = import("app.scenes.game.base.UIParent")
local UIPlayersItem = import(".UIPlayersItem")

local FourPlayerPos = {
    cc.p(UIAdapter.adCX(9), display.cy - 222),
    cc.p(UIAdapter.adCX(1253), display.cy + 54),
    cc.p(UIAdapter.adCX(960), display.cy + 244),
    cc.p(UIAdapter.adCX(9), display.cy + 54)
}

local FourPlayerMidPos = {
    cc.p(UIAdapter.adCX(636), display.cy - 246),
    cc.p(UIAdapter.adCX(987), display.cy + 32),
    cc.p(UIAdapter.adCX(636), display.cy + 244),
    cc.p(UIAdapter.adCX(276), display.cy + 32)
}

local UIPlayers = class("UIPlayers", function ()
    return UIParent.new()
end)

function UIPlayers:ctor(container, order, tag, roomType)
    self.m_container = container

    self.m_roomType = roomType
    self.m_playersT = {}

    self:initUser()
    self:addTo(container, order, tag)
end

function UIPlayers:initUser()
    for i=1,4 do
        local playerItem = UIPlayersItem.new(self, i, self.m_roomType)
        playerItem:align(display.BOTTOM_LEFT, FourPlayerMidPos[i].x, FourPlayerMidPos[i].y)
        playerItem:setClickCallback(handler(self, self.displayUserInfo))
        table.insert(self.m_playersT, playerItem)
    end
end

function UIPlayers:playerEnter(playerInfo)
    -- local

    local player = self:getPlayerByUserId(playerInfo.userId)
    if player then
        player:clear()
    end

    player = self:getPlayerByViewId(playerInfo.viewId)
    if player then
        player:playerEnter(playerInfo)
    end

    --Game:getAudioMgr():playEffect(AUDIO_GAME_EFFECT.SITDOWN)
end

function UIPlayers:getPlayerByViewId(viewId)
    for i,v in ipairs(self.m_playersT) do
        if v:getViewId() == viewId then
            return v
        end
    end
    return nil
end

function UIPlayers:getPlayerByChairId(chairId)
    for i,v in ipairs(self.m_playersT) do
        if v:getChairId() == chairId then
            return v
        end
    end
    return nil
end

function UIPlayers:getPlayerByUserId(userId)
    for i,v in ipairs(self.m_playersT) do
        if v:getUserId() == userId then
            return v
        end
    end
    return nil
end

function UIPlayers:refreshUserScore()
    for i,v in ipairs(self.m_playersT) do

    end
end

function UIPlayers:userToMiddle(isMove)
    
end

function UIPlayers:displayUserInfo(viewId)
    
end

return UIPlayers