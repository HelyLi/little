
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
    local bufferSize = byteArray:readUInt()
    local msgId = byteArray:readUInt()
    local token = byteArray:readLong()

    print(msgId, bufferSize, token)

    local msg = byteArray:readStringBytes(bufferSize - 12)

    local handlerFun = self.m_handlerTable[msgId]
    if type(handlerFun) == "function" then
        handlerFun(msg)
    end
end

return Presenter