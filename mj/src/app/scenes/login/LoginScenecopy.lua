-- src/app/network/socket/SocketMgr.lua
-- import("app.config.App")
-- local SocketMgr = import("app.network.socket.SocketMgr")
-- require("app.pb.LobbyMessage_pb")
-- -- require("app.pb.AddressBook_pb")
require("app.pb.ResultInfo_pb")
require("app.pb.RoomInfo_pb")
require("app.pb.GetRoom_pb")
-- local core = require "sproto.core"
-- local Rx = require 'app.utils.rx'
-- require("pack")
-- local pack = require"pack"
-- local bpack = string.pack
-- local bunpack = string.unpack

local UpdateScene = class("UpdateScene", function()
    return display.newScene("UpdateScene")
end)

function UpdateScene:ctor()
    display.newTTFLabel({text = "Hello, Socket--", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)
    -- self.m_socketMgr = SocketMgr.new()
    -- print("=====================1")
    -- self.m_socketMgr:setLoginListener(handler(self, self.loginSocketOnReceive))
    -- print("=====================2")
    -- self.m_socketMgr:loginSocketConnect()
    -- print("=====================4")
    -- local socket = SimpleTCP.new("127.0.0.1", "7981", handler(self, self.socketCallback))
    -- socket:connect()

	-- ccui.PageView.create()
    self:testPb()
	-- ccui.ImageView:create()
	-- ccui.Button:create()
	-- ccui.ImageView:create()
	-- display.newSprite(filename, x, y, params)	
	-- ccui.menuItem
	-- local menuBase = cc.Menu:create():align(display.BOTTOM_LEFT,0,0):addTo(self)
	-- local botton = ccui.Button:create("com_red_btn_1_skin.png", "com_sure_btn_skin.png", "com_red_btn_1_skin.png")
	-- botton:align(display.CENTER, display.cx, display.cy):addTo(self)
	-- botton:addTouchEventListener(function(sender, eventType)
	-- 	if 2 == eventType then
	-- 		-- self:onConnected()
	-- 		-- self:pack()
	-- 		self:Rx()
	-- 	end
	-- end)
	-- ccui
    --right btn
    -- local normalImg = display.newSprite("com_red_btn_1_skin.png")--cc.ui.UIImage.new("#three_next_left_btn.png")
    -- local selectedImg = display.newSprite("com_red_btn_1_skin.png")--cc.ui.UIImage.new("#three_next_left_btn.png"):setOpacity(120)
    -- self:createMenuSpriteItem(
    --     {
    --         normalImg = normalImg,
    --         selectedImg = selectedImg,
    --         anchor = display.CENTER,
    --         position = cc.p(display.cx, display.cy/2),
    --         callback = function() self.onConnected() end--handler(self._bg, self.nextPage)
    --     }
    -- ):addTo(menuBase)

end

--[[
    params.normalImg = nil
    params.selectedImg = nil
    params.enableImg = nil
    params.position = cc.p(0,0)
    params.anchor = display.CENTER
    params.tag = 0
    params.callback = nil
]]
-- function UpdateScene.createMenuSpriteItem(params)
--     local menuItem = nil
--     menuItem = cc.MenuItemSprite:create(
--         params.normalImg,
--         params.selectedImg,
--         params.enableImg)
--         :align(params.anchor,params.position.x,params.position.y)

--     if params.tag ~= nil then
--         menuItem:setTag(params.tag)
--     end

--     if params.callback ~= nil then
--         menuItem:onClicked(function()
--             params.callback(params.tag)
--         end)
--     end
--     return menuItem
-- end

function UpdateScene:loginSocketOnReceive(event, data)
    
    if event == SimpleTCP.EVENT_CONNECTED then
        -- self:onConnected()
    elseif event == SimpleTCP.EVENT_CLOSED then
        self:onClosed()
    elseif event == SimpleTCP.EVENT_DATA then
        self:onReveived(data)
    end
end

function UpdateScene:Rx()
	

-- local first = Rx.Observable.fromRange(3)
-- local second = Rx.Observable.fromRange(4, 6)
-- local third = Rx.Observable.fromRange(7, 11, 2)

-- first:concat(second, third):dump('concat')

-- print('Equivalent to:')

-- Rx.Observable.concat(first, second, third):dump('concat')
	local onNext = function ()
		print("onNext")
	end
	local onError = function ()
		print("onError")
	end
	local onComplete = function ()
		print("onComplete")
	end

	local Observer = Rx.Observer.create(onNext, onError, onComplete)
	local Observable  = Rx.Observable.create(Observer):subscribe()

	-- Observable.onNext()

end

function UpdateScene:pack()
	
-- 	require("pack")
-- local pack=string.pack---将接口插入到string空间中
-- local unpack=string.unpack
-- string.unpack() 

-- local str=core.pack(">i>i>i",100,200,300) ---I表示按int类型即4个字节打包，>表示字节序
-- print(#str,type(str))    ---输出12 string,3个int等于12字节,打包生成string类型
-- -- print(str)               ---但是这样不能输出，没查到原因

-- print(unpack(str,">i", 1))  ---输出 5 100 ，5表示下一个未读字节的位置，100是因为默认从位置0开始读，">I"表示只读取一个
-- print(unpack(str,">i>i",5))---输出13 200 300，从位置5开始读两个，下一个未读位置是13

	-- lpack()
	-- lunpack()

	
--
	local function hex(s)
		local s=string.gsub(s,"(.)",function (x) return string.format("%02X",string.byte(x)) end)
		return s
	end
	--

	

	local str=bpack(">i>i>i",100,200,300) ---I表示按int类型即4个字节打包，>表示字节序
	print(#str,type(str))    ---输出12 string,3个int等于12字节,打包生成string类型
	-- print(str)               ---但是这样不能输出，没查到原因

	print(bunpack(str,">i", 1))  ---输出 5 100 ，5表示下一个未读字节的位置，100是因为默认从位置0开始读，">I"表示只读取一个
	print(bunpack(str,">i>i",5))---输出13 200 300，从位置5开始读两个，下一个未读位置是13



	-- local a = bpack("Ab8","\027Lua",5*16+1,0,1,4,4,4,8,0)
	-- print(hex(a),string.len(a))
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
    writer.messageID = 10005
    writer.openid = "1234567890"
    writer.accesstoken = "1234567890"
    writer.nickname= "test"
    writer.sex = 0

    -- messageID,openid,accesstoken,nickname,sex

--     message MSG_C2M_PLAYER_LOGIN_SYN
-- {
-- 	required int32 messageID = 1;
-- 	required string openid = 2;
-- 	required string accesstoken = 3;
-- 	required string nickname = 4;
-- 	required int32 sex = 5;
-- }

local function hex(s)
	local s=string.gsub(s,"(.)",function (x) 
		return string.format("%02X",string.byte(x))
	end)
	return s
end

-- Encodes a string into its escaped hexadecimal representation
-- Input
--   s: binary string to be encoded
-- Returns
--   escaped representation of string binary
-----------------------------------------------------------------------------
function unescape(s)
    return string.gsub(s, "%%(%x%x)", function(hex)
        return string.char(base.tonumber(hex, 16))
    end)
end

	local data = writer:SerializeToString()

	print("data.len:", string.len(data))

	print(hex(data))

	local wdata = bpack("A", data)
	
	print("wdata.len:", string.len(wdata))
	print("-----------")
	print(hex(wdata))
	-- print(bunpack(wdata,">I"))  ---输出 5 100 ，5表示下一个未读字节的位置，100是因为默认从位置0开始读，">I"表示只读取一个
	-- print(bunpack(wdata,">p",5))

	-- local pos, value = bunpack(wdata, ">I")
	-- print(pos, value)
	local pos, value = bunpack(wdata, "A")
	-- print("pos:",pos, ",value:", value)
	print("-----------")
	print(hex(value))

	-- print(self:unescape(data))
	local reader = LobbyMessage_pb.MSG_C2M_PLAYER_LOGIN_SYN()
	reader:ParseFromString(wdata)
	

	print("reader.messageID:", reader.messageID)
	print("reader.openid:", reader.openid)
	print("reader.accesstoken:", reader.accesstoken)
	print("reader.nickname:", reader.nickname)
	print("reader.sex:", reader.sex)

    -- local msg_c2m_player_login_syn =  LobbyMessage_pb.MSG_C2M_PLAYER_LOGIN_SYN()
    -- msg_c2m_player_login_syn:ParseFromString(data)

    -- self.m_socketMgr:loginSocketSend(data)

end

function UpdateScene:unescape(s)
    return string.gsub(s, "%%(%x%x)", function(hex)
        return string.char(base.tonumber(hex, 16))
    end)
end

function UpdateScene:onClosed()
    print("onClosed")

end
-- message MSG_M2C_PLAYER_LOGIN_ACK
-- {
-- 	required int32 messageID = 1;
-- 	required int32 errorcode = 2;
-- 	required uint64 clienttoken = 3;
-- }
function UpdateScene:onReveived(data)
    print("onReveived:", data)

	local reader = LobbyMessage_pb.MSG_M2C_PLAYER_LOGIN_ACK()
	reader:ParseFromString(data)

	print("reder.messageID", reader.messageID)
	print("reder.errorcode", reader.errorcode)
	print("reder.clienttoken", reader.clienttoken)


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
    -- self:testPerson()
end

function UpdateScene:testRoom()
	-- 序列化 GetRoomRequest
	local roomIdList = {10,20,30}
	local getRoomRequestWriter = GetRoom_pb.GetRoomRequest() --#pbTips

	for _, v in ipairs(roomIdList) do
		getRoomRequestWriter.enum_uint32:append(v) -- 向数组添加元素，不能直接赋值
	end

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

	for _, v in ipairs(getRoomRequestReader.enum_uint32) do
		print("enum_uint32:", v)
	end

	-- 序列化 GetRoomResponse
	-- local getRoomResponseWriter = GetRoom_pb.GetRoomResponse()
	-- getRoomResponseWriter.result = ResultInfo_pb.SUCCESS

	-- for i=1,2 do
	-- 	local room = getRoomResponseWriter.room:add() -- 数组中的元素是对象，用add来添加
	-- 	room.id = "1000" .. i
	-- 	room.name = "小黑屋-" .. i
	-- 	room.taskType = RoomInfo_pb.MAINLINE
	-- end
	-- print("== Serialize to GetRoomResponse")
	-- local data = getRoomResponseWriter:SerializeToString()

	-- -- 反序列化 GetRoomResponse
	-- local getRoomResponseReader = GetRoom_pb.GetRoomResponse()
	-- print("== Parse From GetRoomResponse")
	-- getRoomResponseReader:ParseFromString(data)
	-- print("result:" .. getRoomResponseReader.result)
	-- print("message:" .. getRoomResponseReader.message) -- default value test
	-- for _, v in ipairs(getRoomResponseReader.room) do
	-- 	print(v.id)
	-- 	print(v.name)
	-- 	print(v.taskType)
	-- 	print(v.needHp) -- default value test
	-- end
end

-- data.len:	37
-- [LUA-print] 120A313233343536373839301A0A313233343536373839302204746573742800A8F104954E
-- [LUA-print] wdata.len:	37
-- [LUA-print] -----------
-- [LUA-print] 120A313233343536373839301A0A313233343536373839302204746573742800A8F104954E

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
