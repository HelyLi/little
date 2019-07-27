local SocketWrapper = import(".SocketWrapper")
local SocketMgr = class("SocketMgr")

-- local loginsocket = SocketWrapper.new({
--     name = "login",
--     host = "47.94.233.203",
--     port = "8000"
-- })

function SocketMgr:ctor()

    self.m_loginsocket = SocketWrapper.new({
        name = "login",
        host = "47.94.233.203",
        port = "8000"
    })
end

function SocketMgr:getLoginSocket()
    return self.m_loginsocket
end

function SocketMgr:loginSocketConnect()
    if self.m_loginsocket then
        self.m_loginsocket:connect()
    end
end

function SocketMgr:setLoginListener(listener)
    if self.m_loginsocket then
        print("setLoginListener")
        self.m_loginsocket:setListener(listener)
    end
end

function SocketMgr:loginSocketSend(data)
    if self.m_loginsocket then
        self.m_loginsocket:send(data)
    end
end

function SocketMgr:getLobbySocket()
    return self.m_lobbysocket
end

function SocketMgr:lobbySocketConnect()
    if self.m_lobbysocket then
        self.m_lobbysocket:connect()
    end
end



function SocketMgr:getCardSocket()
    return self.m_cardsocket
end

function SocketMgr:cardSocketConnect()
    if self.m_cardsocket then
        self.m_cardsocket:connect()
    end
end

-- function SocketMgr:loginReceiveCallback(event, data)
--     if event == SimpleTCP.EVENT_CONNECTING then
--     elseif event == SimpleTCP.EVENT_FAILED then
--     elseif event == SimpleTCP.EVENT_CONNECTED then
--     elseif event == SimpleTCP.EVENT_CLOSED then
--     elseif event == SimpleTCP.EVENT_DATA then
--     end
-- end

-- function SocketMgr:lobbyReceiveCallback(event, data)
    
-- end

-- function SocketMgr:cardReceiveCallback(event, data)
    
-- end

return SocketMgr

