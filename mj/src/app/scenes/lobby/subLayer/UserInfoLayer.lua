local BaseView = import("app.views.BaseView")
local UserInfoLayer = class("UserInfoLayer", function()
    return BaseView.new()
end)

function UserInfoLayer:ctor()
    self:init()
end

function UserInfoLayer:init()
    BaseView.initBase(self)
    self:regMsgHandler()
    self:initView()
end

function UserInfoLayer:regMsgHandler()
    
end

function UserInfoLayer:initView()
    
end

return UserInfoLayer