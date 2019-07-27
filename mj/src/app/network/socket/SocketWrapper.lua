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
        print("onSocketEvent.listener")
        self.m_listener(event, data)
        
    end
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

function SocketWrapper:send(data)
    if self.m_socket then
        self.m_socket:send(data)
    end
end

return SocketWrapper