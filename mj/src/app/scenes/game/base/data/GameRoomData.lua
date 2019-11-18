local GameRoomData = class("GameRoomData")

function GameRoomData:ctor()
    
end

function GameRoomData:clearBase()
    self.m_myBaseInfo = {}
    self.m_roomPlayerTable = {}

    self:setLoginFinish(false)
    self:setPlayersNum(4)
    self:setRoomStatus(status)
end

function GameRoomData:setLoginFinish(finish)
    self.m_isLoginFinished = finish
end

function GameRoomData:isLoginFinish()
    return self.m_isLoginFinished
end

function GameRoomData:setRoomStatus(status)
    self.m_roomStatus = status
end

function GameRoomData:getRoomStatus()
    return self.m_roomStatus
end

function GameRoomData:setMyBaseInfo(data)
    self.m_myBaseInfo = {}
    self.m_myBaseInfo.userId = data.userId
    self.m_myBaseInfo.nickname = data.name
    self.m_myBaseInfo.gender = data.gender
    self.m_myBaseInfo.card = data.Card
    self.m_myBaseInfo.gold = data.Gold
    self.m_myBaseInfo.chairId = -1
    self.m_myBaseInfo.viewId = 1
end

function GameRoomData:getMyViewId()
    return 1
end

function GameRoomData:getMyBaseInfo()
    return self.m_myBaseInfo
end

function GameRoomData:setMyChairId(chairId)
    self.m_myBaseInfo.chairId = chairId
end

function GameRoomData:getMyChairId()
    return self.m_myBaseInfo.chairId
end

function GameRoomData:setPlayersNum(num)
    self.m_playersNum = num
end

function GameRoomData:getPlayersNum()
    return self.m_playersNum
end

function GameRoomData:setRoomId(roomId)
    self.m_roomId = roomId
end

function GameRoomData:getRoomId()
    return self.m_roomId
end

function GameRoomData:setRoomType(type)
    self.m_roomType = type
end

function GameRoomData:getRoomType()
    return self.m_roomType
end

--庄家
function GameRoomData:setBankerViewId(viewId)
    self.m_bankerViewId = viewId
end

function GameRoomData:getBankerViewId()
    return self.m_bankerViewId
end

function GameRoomData:getBankerLZNum(num)
    self.m_bankerLZNum = num
end

function GameRoomData:addRoomPlayer(playerInfo)
    if self.m_roomPlayerTable == nil then
        self.m_roomPlayerTable = {}
    end
    self:removeRoomPlayer(playerInfo.userId)

    if playerInfo.userId == self:getMyBaseInfo().userId then
        playerInfo.viewId = self:getMyViewId()
        self:setMyChairId(playerInfo.chairId)
    else
        playerInfo.viewId = self:getViewIdByChairId(playerInfo.chairId)
    end
    table.insert(self.m_roomPlayerTable, playerInfo)
end

function GameRoomData:removeRoomPlayer(userId)
    for i, playerInfo in ipairs(self.m_roomPlayerTable) do
        if playerInfo.userId == userId then
            table.remove(self.m_roomPlayerTable, i)
            return
        end
    end
end

function GameRoomData:getPlayerTable()
    if self.m_roomPlayerTable == nil then
        self.m_roomPlayerTable = {}
    end
    return self.m_roomPlayerTable
end

function GameRoomData:getPlayerInfoByViewId(viewId)
    for i, v in ipairs(self.m_roomPlayerTable) do
        if v.viewId == viewId then
            return v
        end
    end
    return nil
end

function GameRoomData:getPlayerInfoByUserId(userId)
    for i, v in ipairs(self.m_roomPlayerTable) do
        if v.userId == userId then
            return v
        end
    end
    return nil
end

function GameRoomData:getPlayerInfoByChairId(chairId)
    for i, v in ipairs(self.m_roomPlayerTable) do
        if v.chairId == chairId then
            return v
        end
    end
    return nil
end

function GameRoomData:getViewIdByUserId(userId)
    for i, v in ipairs(self.m_roomPlayerTable) do
        if v.userId == userId then
            return v.viewId
        end
    end
    return 0
end

function GameRoomData:getViewIdByChairId(chairId)
    if self:getMyChairId() == chairId then
        return self:getMyViewId()
    end
    if self:getPlayersNum() == 2 then
        return 3
    elseif self:getPlayersNum() == 3 then
        local viewId = chairId
        if chairId > 2 then
            return 2 + 1
        end
        local gamePlayer = 4
        local offset = chairId - self:getMyChairId()
        if offset > 0 then
            viewId = (CALC_3(offset == 2, 3, offset) % gamePlayer)
        else
            viewId = (CALC_3((gamePlayer + offset) == 2, 1, (gamePlayer + offset)) % gamePlayer)
        end
        return viewId + 1
    elseif self:getPlayersNum() == 4 then
        local viewId = (chairId + self:getPlayersNum() - self:getMyChairId() + self:getMyViewId()) % self:getPlayersNum()
        if viewId == 0 then
            viewId = self:getPlayersNum()
        end
        return viewId
    end
end

return GameRoomData
