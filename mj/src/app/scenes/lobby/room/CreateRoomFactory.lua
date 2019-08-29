local BaseView = import("app.views.BaseView")

local CreateRoomFactory = class("CreateRoomFactory", function()
    return BaseView.new()
end)

function CreateRoomFactory:ctor()
    self:init()
end

function CreateRoomFactory:init()
    self:initView()
end

function CreateRoomFactory:initView()
    
end

return CreateRoomFactory