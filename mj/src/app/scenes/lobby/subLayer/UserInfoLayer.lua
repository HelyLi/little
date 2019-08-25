local BaseView = import("app.views.BaseView")
local UserInfoLayer = class("UserInfoLayer", function()
    return BaseView.new()
end)

function UserInfoLayer:ctor()
    
end

return UserInfoLayer