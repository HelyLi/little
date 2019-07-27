-- src/app/network/socket/SocketMgr.lua
import("app.config.App")
local SocketMgr = import("app.network.socket.SocketMgr")
require("app.pb.LobbyMessage_pb")
require("app.pb.AddressBook_pb")
require("app.pb.ResultInfo_pb")
require("app.pb.RoomInfo_pb")
require("app.pb.GetRoom_pb")

local UpdateScene = class("UpdateScene", function()
    return display.newScene("UpdateScene")
end)

function UpdateScene:ctor()
    display.newTTFLabel({text = "Hello, Socket", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)
    -- self.m_socketMgr = SocketMgr.new()
    -- print("=====================1")
    -- self.m_socketMgr:setLoginListener(handler(self, self.loginSocketOnReceive))
    -- print("=====================2")
    -- self.m_socketMgr:loginSocketConnect()
    -- print("=====================3")
    -- local socket = SimpleTCP.new("127.0.0.1", "7981", handler(self, self.socketCallback))
    -- socket:connect()


    self:testPb()
    
end

function UpdateScene:loginSocketOnReceive(event, data)
    
    if event == SimpleTCP.EVENT_CONNECTED then
        self:onConnected()
    elseif event == SimpleTCP.EVENT_CLOSED then
        self:onClosed()
    elseif event == SimpleTCP.EVENT_DATA then
        self:onReveived(data)
    end
end

function UpdateScene:onConnected()
    print("onConnected")

    local writer = LobbyMessage_pb.MSG_C2M_PLAYER_LOGIN_SYN() --#pbTips

    dump(writer, "writer", 8)

	-- for _, v in ipairs(roomIdList) do
	-- 	getRoomRequestWriter.roomId:append(v) -- 向数组添加元素，不能直接赋值
	-- end
    -- print("== Serialize to GetRoomRequest")
    -- data.roomId:append(v)
    writer.messageID = 1
    writer.openid = "openid"
    writer.accesstoken = "accesstoken"
    writer.nickname= "nickname"
    writer.sex = 5

    -- messageID,openid,accesstoken,nickname,sex

--     message MSG_C2M_PLAYER_LOGIN_SYN
-- {
-- 	required int32 messageID = 1;
-- 	required string openid = 2;
-- 	required string accesstoken = 3;
-- 	required string nickname = 4;
-- 	required int32 sex = 5;
-- }

    local data = writer:SerializeToString()
    



    -- local msg_c2m_player_login_syn =  LobbyMessage_pb.MSG_C2M_PLAYER_LOGIN_SYN()
    -- msg_c2m_player_login_syn:ParseFromString(data)

    self.m_socketMgr:loginSocketSend(data)

end

function UpdateScene:onClosed()
    print("onClosed")

end

function UpdateScene:onReveived(data)
    print("onReveived:", data)

end

function UpdateScene:onEnter()
end

function UpdateScene:onExit()
end

function UpdateScene:socketCallback(event)
    -- print("socket.event:", event)
end

function UpdateScene:testPb()
    self:testRoom()
    self:testPerson()
end

function UpdateScene:testRoom()
	-- 序列化 GetRoomRequest
	local roomIdList = {10,20,30}
	local getRoomRequestWriter = GetRoom_pb.GetRoomRequest() --#pbTips

	for _, v in ipairs(roomIdList) do
		getRoomRequestWriter.roomId:append(v) -- 向数组添加元素，不能直接赋值
	end
	print("== Serialize to GetRoomRequest")
	local data = getRoomRequestWriter:SerializeToString()
    dump( data, "room.data", 8)
	-- 反序列化 GetRoomRequest
	local getRoomRequestReader = GetRoom_pb.GetRoomRequest() --#pbTips
	print("== Parse From GetRoomRequest")
	getRoomRequestReader:ParseFromString(data)
	-- 使用 ipairs 可正确获取到数据，paris 会有多余数据打印出来
	for _, v in ipairs(getRoomRequestReader.roomId) do
		print(v)
	end

	-- 序列化 GetRoomResponse
	local getRoomResponseWriter = GetRoom_pb.GetRoomResponse()
	getRoomResponseWriter.result = ResultInfo_pb.SUCCESS

	for i=1,2 do
		local room = getRoomResponseWriter.room:add() -- 数组中的元素是对象，用add来添加
		room.id = "1000" .. i
		room.name = "小黑屋-" .. i
		room.taskType = RoomInfo_pb.MAINLINE
	end
	print("== Serialize to GetRoomResponse")
	local data = getRoomResponseWriter:SerializeToString()

	-- 反序列化 GetRoomResponse
	local getRoomResponseReader = GetRoom_pb.GetRoomResponse()
	print("== Parse From GetRoomResponse")
	getRoomResponseReader:ParseFromString(data)
	print("result:" .. getRoomResponseReader.result)
	print("message:" .. getRoomResponseReader.message) -- default value test
	for _, v in ipairs(getRoomResponseReader.room) do
		print(v.id)
		print(v.name)
		print(v.taskType)
		print(v.needHp) -- default value test
	end
end

function UpdateScene:testPerson()
	print("========= test AddressBook ====")

	-- 序列化
	local addressBookWriter = AddressBook_pb.AddressBook()
	for i = 1, 5 do
		local person = addressBookWriter.person:add()
		person.name = "my " .. i
		person.id = i

		local phone = person.phone:add()
		phone.number = "123456789"
		if i % 2 == 0 then
			phone.type = AddressBook_pb.Person.WORK
		end
	end
	local data = addressBookWriter:SerializeToString()

	-- write to file for compare test with python pb
	local path = cc.FileUtils:getInstance():getWritablePath() .. "testpb.bin"
	io.writefile(path, data, "wb")

	-- 反序列化
	local addressBookReader = AddressBook_pb.AddressBook()
	addressBookReader:ParseFromString(data)
	for _, person in ipairs(addressBookReader.person) do
		print(person.name)
		print(person.id)
		for _, phone in ipairs(person.phone) do
			print(phone.number)
			if (phone.type == AddressBook_pb.Person.MOBILE) then
				print("MOBILE")
			elseif (phone.type == AddressBook_pb.Person.HOME) then
				print("HOME")
			else
				print("WORK")
			end
		end
	end
end

return UpdateScene
