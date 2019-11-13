local CardRoomData = import("app.scenes.game.cardGame.base.data.CardRoomData")

local XTMJRoomData = class("XTMJRoomData", CardRoomData)

function XTMJRoomData:ctor()
    XTMJRoomData.super.ctor(self)
end

-- "sub_game_rule" = "{"gameAreaRule":0,"xgRule":{"piao_prize":1,"fengding":-1,"hu_laizinum":1}}"

function XTMJRoomData:setSubGameRule(sub_game_rule)
    local rule = json.decode(sub_game_rule)
    dump(rule)
    self:setGameAreaRule(rule.gameAreaRule)
    self:setPiaoPrize(rule.xgRule.piao_prize)
    self:setFengding(rule.xgRule.fengding)
    self:setHuLaizinum(rule.xgRule.hu_laizinum)
end

function XTMJRoomData:setGameAreaRule(gameAreaRule)
    self.m_gameAreaRule = gameAreaRule
end

function XTMJRoomData:getGameAreaRule()
    return self.m_gameAreaRule
end

function XTMJRoomData:setPiaoPrize(piao_prize)
    self.m_piao_prize = piao_prize
end

function XTMJRoomData:setPiaoPrize()
    return self.m_piao_prize
end

function XTMJRoomData:setFengding(fengding)
    self.m_fengding = fengding
end

function XTMJRoomData:getFengding()
    return self.m_fengding
end

function XTMJRoomData:setHuLaizinum(hu_laizinum)
    self.m_hu_laizinum = hu_laizinum
end

function XTMJRoomData:getHuLaizinum()
    return self.m_hu_laizinum
end

return XTMJRoomData