local SocketWrapper = import(".SocketWrapper")
local SocketMgr = class("SocketMgr")

function SocketMgr:ctor()

    self.m_loginsocket = SocketWrapper.new({
        name = "login",
        host = Game:getAppConfig():getLoginHost(),
        port = Game:getAppConfig():getLoginPort()
    })

    self.m_lobbysocket = SocketWrapper.new({
        name = "lobby",
        host = Game:getAppConfig():getLobbyHost(),
        port = Game:getAppConfig():getLobbyPort()
    })
end

------Login------
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

function SocketMgr:loginSocketSend(data, msgId)
    if self.m_loginsocket then
        self.m_loginsocket:send(data, msgId)
    end
end

function SocketMgr:loginSocketClose()
    if self.m_loginsocket then
        self.m_loginsocket:close()
    end
end

------Lobby------
function SocketMgr:getLobbySocket()
    return self.m_lobbysocket
end

function SocketMgr:setLobbyListener(listener)
    if self.m_lobbysocket then
        print("setLobbyListener")
        self.m_lobbysocket:setListener(listener)
    end
end

function SocketMgr:lobbySocketConnect()
    if self.m_lobbysocket then
        self.m_lobbysocket:connect()
    end
end

function SocketMgr:lobbySocketSend(data, msgId)
    if self.m_lobbysocket then
        self.m_lobbysocket:send(data, msgId)
    end
end

function SocketMgr:lobbySocketClose()
    if self.m_lobbysocket then
        self.m_lobbysocket:close()
    end
end
------Game------
function SocketMgr:getCardSocket()
    return self.m_cardsocket
end

function SocketMgr:cardSocketConnect()
    if self.m_cardsocket then
        self.m_cardsocket:connect()
    end
end

return SocketMgr

