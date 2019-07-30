require("app.pb.LobbyMessage_pb")
local Presenter = import("app.network.Presenter")

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

    -- print("type:", type(byteArray))
    -- dump(byteArray, "byteArray", 8)
    -- local size = byteArray:readUShort()

    -- print("size:", size)

    local msg = byteArray:readStringUShort()

    local reader = LobbyMessage_pb.MSG_C2M_PLAYER_LOGIN_SYN()
	reader:ParseFromString(msg)

	print("reder.messageID", reader.messageID)
	print("reder.openid", reader.openid)
	print("reder.accesstoken", reader.accesstoken)
    print("reder.nickname", reader.nickname)
    print("reder.sex", reader.sex)
    -- print(msgdata)
end

function LoginPresenter:toLogin()
    print("LoginPresenter:toLogin")
    local msg = LobbyMessage_pb.MSG_C2M_PLAYER_LOGIN_SYN()
    msg.messageID = 10005
    msg.openid = "1234567890"
    msg.accesstoken = "1234567890"
    msg.nickname= "test"
    msg.sex = 0
    
    local data = msg:SerializeToString()
    -- print(self:hex(data))

    local data = string.pack(">IA", string.len(data), data)  
    -- [34 4 116 101 115 116 40 0 18 10 49 50 51 52 53 54 55 56 57 48 168 241 4 149 78 26 10 49 50 51 52 53 54 55 56 57 48]
    -- 2204746573742800120A31323334353637383930A8F104954E1A0A31323334353637383930	37
    -- print(self:hex(data))

    Game:getSocketMgr():loginSocketSend(data)
end


return LoginPresenter