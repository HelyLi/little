local BaseView = import("app.views.BaseView")
local LoginPresenter = import(".LoginPresenter")
local Speaker = import("app.scenes.lobby.subLayer.Speaker")

local LoginLayer = class("LobbyLayer",function()
    return BaseView.new()
end)

function LoginLayer:ctor()
    BaseView.initBase(self)
    self.m_presenter = LoginPresenter.new(self)
    self:initView()
end

function LoginLayer:initView()
    self.m_bg = display.newSprite("BigBg/login_bg_skin.png"):align(display.CENTER, display.cx, display.cy):addTo(self)

    comui.Button({
        normal = "login_btn_yk_skin.png",
        pos = cc.p(display.cx, display.cy-135),
        callfunc = handler(self.m_presenter, self.m_presenter.toLogin),
        parent = self
    })

    local speaker = Speaker.new(self, 0, 0, "card")

end

-- function LoginLayer:initLoginSocket()
   
-- end

-- function LoginLayer:socketOnReceive(event, data)
--     if event == SimpleTCP.EVENT_CONNECTED then
--         self:onConnected()
--     elseif event == SimpleTCP.EVENT_CLOSED then
--         self:onClosed()
--     elseif event == SimpleTCP.EVENT_DATA then
--         self:onReveived(data)
--     end
-- end

-- function LoginLayer:onConnected()
--     print("onConnected")
    
-- end

-- function LoginLayer:onClosed()
--     print("onClosed")
-- end

function LoginLayer:onReveived(data)
    print("LoginLayer:onReveived")
    print(self:hex(data))
    print("data:", data)
    local pos , value = string.unpack(data, ">H")
    print("pos:", pos, ",value:", value)
    -- pos , value = string.unpack(data, ">A", pos)
    -- print("pos:", pos, ",value:", value)

    print("type:", type(data))
    local datas = string.sub(data, pos, pos + value)
    print(self:hex(datas))

    local reader = LobbyMessage_pb.MSG_C2M_PLAYER_LOGIN_SYN()
	reader:ParseFromString(datas)

	print("reder.messageID", reader.messageID)
	print("reder.openid", reader.openid)
	print("reder.accesstoken", reader.accesstoken)
    print("reder.nickname", reader.nickname)
    print("reder.sex", reader.sex)

end

-- function LoginLayer:onReveived(data)
--     print("LoginLayer:onReveived")
--     print(self:hex(data))
--     print("data:", data)
--     local pos , value = string.unpack(data, ">H")
--     print("pos:", pos, ",value:", value)
--     -- pos , value = string.unpack(data, ">A", pos)
--     -- print("pos:", pos, ",value:", value)

--     -- print("type:", type(data))
--     -- local datas = string.sub(data, pos, pos + value)
--     print(value)

--     local reader = LobbyMessage_pb.MSG_M2C_PLAYER_LOGIN_ACK()
-- 	reader:ParseFromString(value)

-- 	print("reder.messageID", reader.messageID)
-- 	print("reder.errorcode", reader.errorcode)
-- 	print("reder.clienttoken", reader.clienttoken)


-- end



function LoginLayer:Login()
    print("LoginLayer:Login")
    local msg = LobbyMessage_pb.MSG_C2M_PLAYER_LOGIN_SYN()
    msg.messageID = 10005
    msg.openid = "1234567890"
    msg.accesstoken = "1234567890"
    msg.nickname= "test"
    msg.sex = 0
    
    local data = msg:SerializeToString()
    print(self:hex(data))

    local data = string.pack(">IA", string.len(data), data)  
    -- [34 4 116 101 115 116 40 0 18 10 49 50 51 52 53 54 55 56 57 48 168 241 4 149 78 26 10 49 50 51 52 53 54 55 56 57 48]
    -- 2204746573742800120A31323334353637383930A8F104954E1A0A31323334353637383930	37
    print(self:hex(data))

    Game:getSocketMgr():loginSocketSend(data)
end

return LoginLayer