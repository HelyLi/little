require("app.pb.LobbyMessage_pb")
local Rx = require 'app.utils.rx'
local ByteArray = import("app.utils.ByteArray")
local Presenter = import("app.network.Presenter")


local LobbyPresenter = class("LobbyPresenter",function()
    return Presenter.new()
end)

function LobbyPresenter:ctor(view)
    Presenter.init(self, view)
    self:initLobbySocket()
end

function LobbyPresenter:initLobbySocket()
    Game:getSocketMgr():setLobbyListener(self)
    Game:getSocketMgr():lobbySocketConnect()
end

function LobbyPresenter:onConnected()
    
end

function LobbyPresenter:onClosed()
    
end

function LobbyPresenter:onReveived(byteArray)

end

function LoginPresenter:initHandlerMsg()
    self.m_handlerTable = {}


end

return LobbyPresenter