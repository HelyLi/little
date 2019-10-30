local UIParent = import("app.scenes.game.base.UIParent")
local UIPlayersItem = import(".UIPlayersItem")

local UIPlayers = class("UIPlayers", function ()
    return UIParent.new()
end)

function UIPlayers:ctor(presenter, order, tag, roomType)
    self.m_presenter = presenter

    self.m_roomType = roomType
    self.m_playersT = {}

    self:initUser()
    self:addTo(presenter, order, tag)
end

function UIPlayers:initUser()
    for i=1,4 do
        local playerItem = UIPlayersItem.new(self, i, self.m_roomType)
        table.insert(self.m_playersT, playerItem)
    end
end

function UIPlayers:playerEnter(playerInfo)
    
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

return UIPlayers