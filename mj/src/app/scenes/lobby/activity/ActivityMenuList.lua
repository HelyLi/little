--[[
    菜单列表
]]

local TABLE_WIDTH       = 252
local TABLE_HIGHT       = 602
local TABLE_CELL_WIDTH  = 252
local TABLE_CELL_HIGHT  = 108

local Order = {    
    LIST_BG     = 1,
    TABLE_VIEW  = 2,
}

local Tag = {
    TABLE_VIEW  = 2,
    MENU_ITEM   = 20
}

local CreateRoomName = require("app.scenes.room.CreateRoomName")
local ActivityMenuList = class("ActivityMenuList", BaseView)

function ActivityMenuList:ctor(listData)
    self._listData = listData
    self._defaultIdx = 0
    self._callback = function () end
    self:init()
end

function ActivityMenuList:setSelectedEvent(callback)
    self._callback = callback
end

function ActivityMenuList:init()
    self:setContentSize(cc.size(TABLE_WIDTH, TABLE_HIGHT))
    local basePos = cc.p(42, 60)
     --list bg
    --  local listBg = display.newScale9Sprite("#com_activity_list_bg.png", 0,0, cc.size(226, 624), cc.rect(20, 20, 30, 30))
    --  listBg:align(display.BOTTOM_LEFT, basePos.x, basePos.y):addTo(self, Order.LIST_BG)
 
    local tableView = cc.TableView:create(cc.size(TABLE_WIDTH, TABLE_HIGHT))
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:align(display.BOTTOM_LEFT, basePos.x , basePos.y)
    tableView:addTo(self, Order.TABLE_VIEW, Tag.TABLE_VIEW)

    local function tableCellTouched(view, cell)
        self:tableCellTouched(view, cell)
    end

    local function cellSizeForTable(view, idx)
        return TABLE_CELL_HIGHT, TABLE_CELL_WIDTH
    end

    local function tableCellAtIndex(view, idx)
        return self:tableCellAtIndex(view, idx)
    end

    local function numberOfCellsInTableView(view)
        return self:numberOfCellsInTableView(view)
    end

    tableView:registerScriptHandler(tableCellTouched, cc.TABLECELL_TOUCHED)
    tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
    tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
    tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
    tableView:reloadData()

    self._tableView = tableView
    return tableView
end

function ActivityMenuList:refreshListView(listData, defaultIndex)
    self._listData = listData
    local defaultIndex = defaultIndex or 0
    if self._listData ~=nil and #self._listData > 0 and self._tableView then
        self._tableView:reloadData()
        local cell = self._tableView:cellAtIndex(defaultIndex)
        if cell ~= nil then
            cell:setIdx(defaultIndex)
            self:tableCellTouched(self._tableView, cell)
        end
    end
end

function ActivityMenuList:tableCellTouched(view, cell)
    local selectListIndx = cell:getIdx()+1

    for i=1,#self._listData do
        local cellItem = view:cellAtIndex(i-1)
        if cellItem ~= nil then
            local botton = cellItem:getChildByTag(Tag.MENU_ITEM)
            if botton ~= nil then
                if selectListIndx == i then
                    botton:setSelect(true)
                else
                    botton:setSelect(false)
                end
            end
        end
    end

    if self._callback then
        self._callback(selectListIndx)
    end
end

function ActivityMenuList:tableCellAtIndex(view, idx)
    local cell = view:dequeueCell()
    if not cell then
        cell = cc.TableViewCell:new()
        cell:setAnchorPoint(cc.p(0,0))
    else
        cell:removeAllChildren(true)
    end
    
    local itemInfo = self._listData[idx+1]
    local itemParams = {
        activity = 1,
        gameName = itemInfo.name,
        isFree = 0,
        callback = function()  end,
        newFlag = itemInfo.new_flag or 0
    }
    CreateRoomName.new(itemParams):align(display.BOTTOM_LEFT, 3, -5):addTo(cell, 0, Tag.MENU_ITEM)

    return cell
end

function ActivityMenuList:numberOfCellsInTableView(view)
    return #(self._listData or {})
end

return ActivityMenuList
