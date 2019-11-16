
local Presenter = class("Presenter")
require("app.pb.Message_ID")
-- G2M_CONN_CLOSE = 1;
-- M2G_PLAYER_KICK = 2;
-- G2C_PLAYER_KICK = 3;
-- REGISTER_SERVER = 4;
function Presenter:ctor()
    self.m_handlerTable = {}
    self.m_handlerTable[G2M_CONN_CLOSE] = handler(self, self.G2M_CONN_CLOSE)
    self.m_handlerTable[M2G_PLAYER_KICK] = handler(self, self.M2G_PLAYER_KICK)
    self.m_handlerTable[G2C_PLAYER_KICK] = handler(self, self.G2C_PLAYER_KICK)
    self.m_handlerTable[REGISTER_SERVER] = handler(self, self.REGISTER_SERVER)
end

function Presenter:init(view)
    self.m_view = view
end

function Presenter:onConnected()
    print("onConnected")
end

function Presenter:onClosed()
    print("onClosed")
end

function Presenter:onReveived(byteArray)
    local msgId = byteArray:readUInt()--4
    local token = byteArray:readULong()--8

    print(">>>-------------Reveived:msgId:", msgId)

    local msg = byteArray:readStringBytes(byteArray:getLen() - 12)

    local handlerFun = self.m_handlerTable[msgId]
    if type(handlerFun) == "function" then
        handlerFun(msg)
    end
end

function Presenter:G2M_CONN_CLOSE(msgData)
    local data = Message_Def:G2M_CONN_CLOSE(msgData)
    dump(data, "--->>> ") 
end

function Presenter:M2G_PLAYER_KICK(msgData)
    local data = Message_Def:M2G_PLAYER_KICK(msgData)
    dump(data, "--->>> ") 
end

function Presenter:G2C_PLAYER_KICK(msgData)
    local data = Message_Def:G2C_PLAYER_KICK(msgData)
    dump(data, "--->>> ")  
end

function Presenter:REGISTER_SERVER(msgData)
    local data = Message_Def:REGISTER_SERVER(msgData)
    dump(data, "--->>> ")  
end

return Presenter