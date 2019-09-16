local CreateRoomInfo = import(".CreateRoomInfo")

local GameData = class("GameData")

function GameData:ctor()
    self:initCreateRoomInfo()
end

--创建房间信息
function GameData:initCreateRoomInfo()
	self.m_createRoomInfo = CreateRoomInfo.new()
end

function GameData:getCreateRoomInfo()
	return self.m_createRoomInfo
end

function GameData:setCreateRoomAck(ack)
	self.m_createRoomAck = ack
end

function GameData:getCreateRoomAck()
	return self.m_createRoomAck
end

-- function GameData:getCreateOneRoomInfo()
-- 	return self.m_createOneRoomInfo
-- end

-- function GameData:setCreateOneRoomInfo(info)
-- 	self.m_createOneRoomInfo = info
-- end

-- - "L2C_PLAYER_CREATE_ROOM_ACK" = {
--         "gameip"    = "47.94.233.203"
--         "gameport"  = 9000
--         "messageID" = 11004
--         "ownerid"   = 10001
--         "roomid"    = 756608
--     }


return GameData