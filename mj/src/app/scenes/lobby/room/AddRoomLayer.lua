local BaseView = import("app.views.BaseView")
local AddRoomLayer = class("AddRoomLayer", function()
    return BaseView.new()
end)

function AddRoomLayer:ctor()
    self:init()
end

function AddRoomLayer:init()
    BaseView.initBase(self)
    self:initView()
end

function AddRoomLayer:initView()
    
end

return AddRoomLayer