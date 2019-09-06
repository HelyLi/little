local ByteArray = import("app.utils.ByteArray")
local SocketWrapper = class("SocketWrapper")

function SocketWrapper:ctor(params)
    self.m_name = params.name
    self.m_host = params.host
    self.m_port = params.port
    self.m_socket = nil
    self.m_listener = nil
end

function SocketWrapper:onSocketEvent(event, data)
    print(self.m_name, "onSocketEvent.event:", event)

    if self.m_listener then
        if event == SimpleTCP.EVENT_CONNECTED then
            self.m_listener:onConnected()
        elseif event == SimpleTCP.EVENT_CLOSED then
            self.m_listener:onClosed()
        elseif event == SimpleTCP.EVENT_DATA then
            print(self:hex(data))
            self.m_listener:onReveived(ByteArray.new(ByteArray.ENDIAN_BIG):writeString(data):setPos(1))
        end
    end
end

function SocketWrapper:hex(s)
    local s = string.gsub(s,"(.)",function (x) return string.format("%02X",string.byte(x)) end)
    return s
end

function SocketWrapper:connect()
    self.m_socket = SimpleTCP.new(self.m_host, self.m_port, handler(self, self.onSocketEvent))
    self.m_socket:connect()
end

function SocketWrapper:setListener(listener)
    print("SocketWrapper:setListener")
    self.m_listener = listener
end

function SocketWrapper:removeListener()
    self.m_listener = nil
end

function SocketWrapper:send(data, msgId)
    -- print(self:hex(data)
    print("msgId:", msgId)

    local token = Game:getUserData():getToken()
    print(string.format("token:%d", token))

    local byteArray = ByteArray.new(ByteArray.ENDIAN_BIG):writeUInt(string.len(data) + 12):writeUInt(msgId):writeULong(token):writeString(data):getPack()
    print(self:hex(byteArray))
    print("---------")
    if self.m_socket then
        self.m_socket:send(byteArray)
    end
end

function SocketWrapper:close()
    if self.m_socket then
        self.m_socket:close()
    end
end

return SocketWrapper