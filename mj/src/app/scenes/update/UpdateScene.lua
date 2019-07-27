-- src/app/network/socket/SocketMgr.lua
import("app.config.App")
local SocketMgr = import("app.network.socket.SocketMgr")
require("app.pb.LobbyMessage_pb")
require("app.pb.AddressBook_pb")
require("app.pb.ResultInfo_pb")
require("app.pb.RoomInfo_pb")
require("app.pb.GetRoom_pb")

local UpdateScene = class("UpdateScene", function()
    return display.newScene("UpdateScene")
end)

function UpdateScene:ctor()
    
end

function UpdateScene:onEnter()
end

function UpdateScene:onExit()
end

return UpdateScene
