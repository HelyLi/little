require("app.pb.LobbyMessage_pb")
local Rx = require 'app.utils.rx'
local ByteArray = import("app.utils.ByteArray")
local Presenter = import("app.network.Presenter")

local AsyncRes = {

}

local LoginPresenter = class("LoginPresenter",function()
    return Presenter.new()
end)

function LoginPresenter:ctor(view)
    Presenter.init(self, view)
    self:initLoginSocket()
end

function LoginPresenter:initLoginSocket()
    Game:getSocketMgr():setLoginListener(self)
    Game:getSocketMgr():loginSocketConnect()
end

function LoginPresenter:onConnected()
    
end

function LoginPresenter:onClosed()
    
end

function LoginPresenter:onReveived(byteArray)
    -- 0000001A
    -- 00002716
    -- 00000000
    -- 00000000
    -- 08964E10FEFFFFFFFFFFFFFFFF01
    local bufferSize = byteArray:readUInt()
    local msgId = byteArray:readUInt()
    local token = byteArray:readLong()

    print(bufferSize, msgId, token)

    -- print("type:", type(byteArray))
    -- dump(byteArray, "byteArray", 8)
    -- local size = byteArray:readUShort()
    -- 08
    -- 96
    -- 4E
    -- 10
    -- FE
    -- FF
    -- FF
    -- FF
    -- FF
    -- FF
    -- FF
    -- FF
    -- FF
    -- 01
    -- print("size:", size)

    local msg = byteArray:readStringBytes(bufferSize - 12)

    local reader = LobbyMessage_pb.MSG_M2C_PLAYER_LOGIN_ACK()
	reader:ParseFromString(msg)

	print("reder.messageID", reader.messageID)
	print("reder.errorcode", reader.errorcode)
	print("reder.clienttoken", reader.clienttoken)
    -- local reader = LobbyMessage_pb.MSG_C2M_PLAYER_LOGIN_SYN()
	-- reader:ParseFromString(msg)

	-- print("reder.messageID", reader.messageID)
	-- print("reder.openid", reader.openid)
	-- print("reder.accesstoken", reader.accesstoken)
    -- print("reder.nickname", reader.nickname)
    -- print("reder.sex", reader.sex)
    -- print(msgdata)
end

-- 1	thread: 0x24d8a1b0
-- [LUA-print] 3	thread: 0x24d8a430
-- [LUA-print] 2!
-- [LUA-print] 3	thread: 0x24d8a430
-- [LUA-print] 4!
-- [LUA-print] 3	thread: 0x24d8a430
-- [LUA-print] 6!
-- [LUA-print] 3	thread: 0x24d8a430
-- [LUA-print] 8!
-- [LUA-print] 2	thread: 0x24d8a1b0
-- [LUA-print] 3	thread: 0x24d8a430

function LoginPresenter:audio()
    local source = Game:getAudioMgr():playEffect(AUDIO_GAME_EFFECT.SITDOWN)
    -- source:stop()
    -- assert(iskindof(source, "Rapid2D_CAudio"), "Need a Rapid2D_CAudio instance!")
    -- playEffect
end

function LoginPresenter:rxlua()
    
    local scheduler = Rx.CooperativeScheduler.create()

    -- Cheer someone on using functional reactive programming
    print("main", coroutine.running()) 
    local observable = Rx.Observable.fromCoroutine(function()
        print("1", coroutine.running()) 
    for i = 2, 8, 2 do
        coroutine.yield(i)
    end
    print("2",coroutine.running()) 
    return 'who do we appreciate'
    end, scheduler)

    observable
    :map(function(value) 
        print("3",coroutine.running()) 
        return value .. '!' end)
    :subscribe(print)

    repeat
    scheduler:update()
    until scheduler:isEmpty()
end

function LoginPresenter:toLogin()
    print("LoginPresenter:toLogin")
    local msg = LobbyMessage_pb.MSG_C2M_PLAYER_LOGIN_SYN()
    msg.messageID = 10005
    msg.openid = "1111111111111111111"
    msg.accesstoken = "22222222222222222222"
    msg.nickname= "test"
    msg.sex = 0
    
    local data = msg:SerializeToString()

    local byteArray = ByteArray.new(ByteArray.ENDIAN_BIG):writeUInt(string.len(data) + 12):writeUInt(10005):writeUInt(0):writeUInt(0):writeString(data):getPack()
    print(self:hex(byteArray))

    -- print(self:hex())
    


    -- local data = string.pack(">IA", string.len(data), data)  
    -- [34 4 116 101 115 116 40 0 18 10 49 50 51 52 53 54 55 56 57 48 168 241 4 149 78 26 10 49 50 51 52 53 54 55 56 57 48]
    -- 2204746573742800120A31323334353637383930A8F104954E1A0A31323334353637383930	37
    -- print(self:hex(data))

    Game:getSocketMgr():loginSocketSend(byteArray)
end

 
-- 二进制转int
function LoginPresenter:bufToInt32(num1, num2, num3, num4)
    local num = 0;
    num = num + self:leftShift(num1, 24);
    num = num + self:leftShift(num2, 16);
    num = num + self:leftShift(num3, 8);
    num = num + num4;
    return num;
end
 
-- int转二进制
function LoginPresenter:int32ToBufStr(num)
    local str = "";
    str = str .. self:numToAscii(self:rightShift(num, 24));
    str = str .. self:numToAscii(self:rightShift(num, 16));
    str = str .. self:numToAscii(self:rightShift(num, 8));
    str = str .. self:numToAscii(num);
    return str;
end
 
-- 二进制转shot
function LoginPresenter:bufToInt16(num1, num2)
    local num = 0;
    num = num + self:leftShift(num1, 8);
    num = num + num2;
    return num;
end
 
-- shot转二进制
function LoginPresenter:int16ToBufStr(num)
    local str = "";
    str = str .. self:numToAscii(self:rightShift(num, 8));
    str = str .. self:numToAscii(num);
    return str;
end

 
-- 左移
function LoginPresenter:leftShift(num, shift)
    return math.floor(num * (2 ^ shift));
end
 
-- 右移
function LoginPresenter:rightShift(num, shift)
    return math.floor(num / (2 ^ shift));
end
 
-- 转成Ascii
function LoginPresenter:numToAscii(num)
    num = num % 256;
    return string.char(num);
end

function LoginPresenter:luabinding()
    -- if my.System.unZip(fileName) == true then

    -- print(game.system.unZip("/ddd/file.zip") == false)

end

function LoginPresenter:hex(s)
    return string.gsub(s,"(.)",function (x) return string.format("%02X",string.byte(x)) end)
end

function LoginPresenter:preloadRes()
    
    local resNum = #AsyncRes
    local curNum = 0
    
    --异步回调
    local callback = function ()
        curCom =  curCom + 1
        print("加载"..AsyncRes[curCom]..".pvr.ccz")
        display.addSpriteFrames(AsyncRes[curCom]..".plist",AsyncRes[curCom]..".pvr.ccz")
        if curCom == resNum and (not tolua.isnull(self)) then
            print("异步图片加载完成")
            self:beginLoginGame()
        end
    end
    if #AsyncRes > 0 then
        self:startLoadResTimeout()
    end

    for i,v in ipairs(AsyncRes) do
        display.addImageAsync(v..".pvr.ccz",callback)
    end
end


function LoginPresenter:initHandlerMsg()
    self.m_handlerTable = {}


end

function LoginPresenter:LoginAck()
    
end

-- function CardRoomMsg:initHandleFuns()
-- 	self.handleTable = {}

-- 	--公共消息
-- 	self.handleTable[SUB_CLIENT_HEARTMSG] = handler(self, self.gameHeartMsg)
-- 	self.handleTable[SUB_ERROR_CODE_MSG] = handler(self, self.gameConnectError)
-- 	self.handleTable[SUB_USERMORELOGINHINTMSG] = handler(self, self.loginOtherPlace)
-- 	self.handleTable[SUB_USERONLINEOTHERGAME] = handler(self, self.userInOtherGame)

-- 	--登录消息
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_LOGIN_SUCCESS] = handler(self, self.loginSuccess)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_LOGIN_FAILED] = handler(self, self.loginFailed)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_LOGIN_FINISH] = handler(self, self.loginFinish)

-- 	--配置
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_GAMEROOMOTHERCFG] = handler(self, self.gameRoomConfig)

-- 	--房间创建
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_CREATEROOM_SUC] = handler(self, self.createRoomSuc)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_CREATEROOM_FAIL] = handler(self, self.createRoomFail)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_ENTERROOMDATA] = handler(self, self.enterRoomData)

-- 	--用户消息
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_USER_SIT_FAIL] = handler(self, self.userSitFaild)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_USER_ENTER_DESK] = handler(self, self.userEnterDesk)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_USER_STATUS_BROADCAST] = handler(self, self.userStatusChange)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_USER_GOLD_BROADCAST] = handler(self, self.userGoldChange)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_LEFT_SUC] = handler(self, self.userLeftSuc)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_LINERANGE] = handler(self, self.userDistance)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_CHANGECHAIR] = handler(self, self.userChangeChairId)

-- 	--桌子消息
--     self.handleTable[CMD_GameMsg.SUB_GAME_GC_DESKINFO] = handler(self, self.gameDeskInfoMsg)
--     --游戏信息
--     self.handleTable[CMD_GameMsg.SUB_GAME_CGS_GAME_MSG] = handler(self, self.gamePlayingMsg)

--     --相同IP
--     self.handleTable[CMD_GameMsg.SUB_GAME_GC_SAME_IP] = handler(self, self.userSameIP)

--     --表情 常用语
--     self.handleTable[CMD_GameMsg.SUB_GAME_CGS_USER_CHAT] = handler(self, self.userCommonChatMsg)
--     --手动输入聊天
--     self.handleTable[CMD_GameMsg.SUB_GAME_CGS_ROOMSAYMSG] = handler(self, self.userInputChatMsg)
--     --云娃语音
--     self.handleTable[CMD_GameMsg.SUB_GAME_CSG_ROOMVOICEEXMSG] = handler(self, self.gameYVMsg)

--     --解散房间
--     self.handleTable[CMD_GameMsg.SUB_GAME_GC_JS_HINIT] = handler(self, self.roomJieSanStartTip)
--     self.handleTable[CMD_GameMsg.SUB_GAME_GC_RTN_JS_RESPOND] = handler(self, self.roomJieSanUserResp)
--     self.handleTable[CMD_GameMsg.SUB_GAME_GC_ROOM_JS] = handler(self, self.roomJieSanOverTip)
--     self.handleTable[CMD_GameMsg.SUB_GAME_GC_JS_SCENE] = handler(self, self.roomJieSanScene)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_GC_HINIT_JS_MSG] = handler(self, self.roomJieSanLastTip)
	
-- 	-- 提前开局
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_INFORMCHANGEPEOPLE] = handler(self, self.roomInformChangePeople)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_RESPPEOPLE] = handler(self, self.roomRespPeople)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_INFORMRESPPEOPLE] = handler(self, self.roomInformRespPeople)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_CHANGEPEOPLESUC] = handler(self, self.roomChangePeopleSucc)
-- 	self.handleTable[CMD_GameMsg.SUB_GAME_CP_SCENE] = handler(self, self.roomCPScene)
-- end

return LoginPresenter