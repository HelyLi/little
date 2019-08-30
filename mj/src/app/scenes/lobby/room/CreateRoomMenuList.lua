local BaseView = import("app.views.BaseView")
local TableView = import("app.utils.TableView")
local CreateRoomName = import(".CreateRoomName")

local TABLE_WIDTH       = 260
local TABLE_HIGHT       = 560
local TABLE_CELL_WIDTH  = 252
local TABLE_CELL_HIGHT  = 102

local TAG = {
    CREATE_ROOM_NODE = 0x01
}

local CreateRoomMenuList = class("CreateRoomMenuList", function()
    return BaseView.new()
end)

function CreateRoomMenuList:ctor()
    self.m_listdata = {}
    self.m_callback = function() end
    self:init()
end

function CreateRoomMenuList:setSelectedEvent(callback)
    self.m_callback = callback
end

function CreateRoomMenuList:init()
    self:setContentSize(cc.size(TABLE_WIDTH, TABLE_HIGHT))
    self:initTableView()
end

function CreateRoomMenuList:initTableView()
    print("initTableView")
    self.m_tabelView = ccui.ListView:create()
    self.m_tabelView:setContentSize(cc.size(TABLE_WIDTH, TABLE_HIGHT))
    self.m_tabelView:setPosition(0,0)
    self.m_tabelView:setDirection(ccui.ListViewDirection.vertical)
    self.m_tabelView:addTo(self)

    TableView.attachTo(self.m_tabelView, handler(self, self.sizeSource), handler(self, self.loadSource), handler(self, self.unloadSource))
end

function CreateRoomMenuList:refreshListView(listdata)
    self.m_listdata = listdata or {}
    dump(self.m_listdata, "self.m_listdata")
    self.m_tabelView:initDefaultItems(#self.m_listdata)
end

function CreateRoomMenuList:sizeSource(index)
    print("sizeSource.index:", index)
    return cc.size(TABLE_CELL_WIDTH, TABLE_CELL_HIGHT)
end

function CreateRoomMenuList:loadSource(index)
    local itemInfo = self.m_listdata[index]
    local function callback()

        if self.m_tabelView then
            print("index:", index)
            local items = self.m_tabelView:getItems()
            for i,item in ipairs(items) do
                local indx = self.m_tabelView:getIndex(item)
                print("indx:", indx)
                local roomNode = item:getChildByTag(TAG.CREATE_ROOM_NODE)
                if indx + 1 == index then
                    roomNode:setSelect(true)
                else
                    roomNode:setSelect(false)
                end
            end
        end

        self.m_callback(index)
    end
    local itemParams = {
        gameName = itemInfo.name,
        isFree = 0,
        callback = callback,
        newFlag = itemInfo.new_flag or 0
    }
    return CreateRoomName.new(itemParams):setTag(TAG.CREATE_ROOM_NODE)
end

function CreateRoomMenuList:unloadSource(index)
    print("You can unload texture of index here")
end

return CreateRoomMenuList