local UserData = class("UserData")

function UserData:ctor()
    
end

function UserData:getUserId()
    return self.m_userId
end

function UserData:setUserId(userId)
    self.m_userId = userId
end

function UserData:getNickname()
    return self.m_nickname
end

function UserData:setNickname(nickname)
    self.m_nickname = nickname
end

--钻石
function UserData:getDiamond()
    return self.m_diamond
end

function UserData:setDiamond(diamond)
    self.m_diamond = diamond
end

--金币
function UserData:getGold()
    return self.m_gold
end

function UserData:setGold(gold)
    self.m_gold = gold
end

return UserData