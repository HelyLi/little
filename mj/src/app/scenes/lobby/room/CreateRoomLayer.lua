local BaseView = import("app.views.BaseView")
local CreateRoomMenuList = import(".CreateRoomMenuList")
local CreateRoomFactory = import(".CreateRoomFactory")

local CreateRoomLayer = class("CreateRoomLayer", function()
    return BaseView.new()
end)

function CreateRoomLayer:ctor()
    self:init()
end

function CreateRoomLayer:init()
    BaseView.initBase(self)
    self:initView()
end

function CreateRoomLayer:initView()
    
end

return CreateRoomLayer