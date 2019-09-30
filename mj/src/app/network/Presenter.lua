
local Presenter = class("Presenter")

function Presenter:ctor()
    self.m_handlerTable = {}
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
    -- local bufferSize = byteArray:readUInt()--4
    local msgId = byteArray:readUInt()--4
    local token = byteArray:readULong()--8
    -- byteArray:readUInt()
    -- print(msgId, token)

    -- print("len:", byteArray:getLen())

    print("msgId:", msgId)

    local msg = byteArray:readStringBytes(byteArray:getLen() - 12)

    local handlerFun = self.m_handlerTable[msgId]
    if type(handlerFun) == "function" then
        handlerFun(msg)
    end
end

return Presenter