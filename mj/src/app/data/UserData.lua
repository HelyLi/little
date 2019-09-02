local UserData = class("UserData")

function UserData:ctor()
    
end
-- "playerInfo" = {
--     [LUA-print] -         "accountId"    = "1"
--     [LUA-print] -         "diamond"      = 100
--     [LUA-print] -         "goldCoin"     = 1000
--     [LUA-print] -         "level"        = 1
--     [LUA-print] -         "name"         = "test1"
--     [LUA-print] -         "password"     = "123456"
--     [LUA-print] -         "player_id"    = 10001
--     [LUA-print] -         "registerDate" = 1565272816
--     [LUA-print] -     }
function UserData:setPlayerInfo(info)
    self.m_userId = info.player_id
    self.m_nickname = info.name
    self.m_diamond = info.diamond
    self.m_gold = info.goldCoin
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

--微信unionid
function UserData:setWXUnionId(unionid)
    self.m_unionid = unionid
end



return UserData