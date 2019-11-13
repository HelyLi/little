local GameRoomData = import("app.scenes.game.base.data.GameRoomData")

local CardRoomData = class("CardRoomData", GameRoomData)

function CardRoomData:ctor()
    self:clear()
end

function CardRoomData:clear()
    self:clearBase()

end

function CardRoomData:setTotalEnd(bEnd)
    self.m_isTotalEnd = bEnd
end

function CardRoomData:isTotalEnd()
    return self.m_isTotalEnd
end

-- "--->>> 桌子的基本信息" = {
--      "messageID"     = 22004
--      "room_baseinfo" = {
--          "areaid"        = 2
--          "difen"         = 1
--          "ju_num"        = 8
--          "kindid"        = 255
--          "paytype"       = 2
--          "playernum"     = 4
--          "sub_game_rule" = "{"gameAreaRule":0,"xgRule":{"piao_prize":1,"fengding":-1,"hu_laizinum":1}}"
--      }
--      "roomid"        = 280839
--      "roomstate"     = 2
--  }
function CardRoomData:enterRoomData(data)
    self:setRoomId(data.roomid)

    self:setAreaId(data.room_baseinfo.areaid)
    self:setDifen(data.room_baseinfo.difen)
    self:setTotalJuNum(data.room_baseinfo.ju_num)
    self:setGameId(data.room_baseinfo.kindid)
    self:setPaytype(data.room_baseinfo.paytype)
    self:setPlayersNum(data.room_baseinfo.playernum)
    self:setSubGameRule(data.room_baseinfo.sub_game_rule)
end

function CardRoomData:setAreaId(areaid)
    self.m_areaid = areaid
end

function CardRoomData:getAreaId()
    return self.m_areaid
end

function CardRoomData:setDifen(difen)
    self.m_difen = difen
end

function CardRoomData:getDifen()
    return self.m_difen
end

function CardRoomData:setTotalJuNum(ju_num)
    self.m_total_ju_num = ju_num
end

function CardRoomData:getTotalJuNum()
    return self.m_total_ju_num
end

function CardRoomData:setGameId(kindid)
    self.m_gameId = kindid
end

function CardRoomData:getGameId()
    return self.m_gameId
end

function CardRoomData:setPaytype(paytype)
    self.m_paytype = paytype
end

function CardRoomData:getPaytype()
    return self.m_paytype
end



return CardRoomData