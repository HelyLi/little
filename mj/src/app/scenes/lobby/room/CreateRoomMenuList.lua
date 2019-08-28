local BaseView = import("app.views.BaseView")
local TableView = import("app.utils.TableView")

local TABLE_WIDTH       = 260
local TABLE_HIGHT       = 540
local TABLE_CELL_WIDTH  = 252
local TABLE_CELL_HIGHT  = 102

local CreateRoomMenuList = class("CreateRoomMenuList", function()
    return BaseView.new()
end)

function CreateRoomMenuList:ctor()
    self:init()
end

function CreateRoomMenuList:init()
    BaseView.initBase(self)
    self:setContentSize(cc.size(TABLE_WIDTH, TABLE_HIGHT))
    self:initView()
end

function CreateRoomMenuList:initView()
    
end

return CreateRoomMenuList