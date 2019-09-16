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

--
function CardRoomData:setRoomId()
    
end

function CardRoomData:getRoomId()
    
end



return CardRoomData