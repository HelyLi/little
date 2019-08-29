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

return GameData