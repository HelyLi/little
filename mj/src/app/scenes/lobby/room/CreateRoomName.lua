local BaseNode = import("app.views.BaseNode")
--ORDER
local ORDER_BASE = 6

--TAG
local Tag = {
    SELECT_ITEM = 6,
    UNSELECT_ITEM = 8
}

local CreateRoomName = class("CreateRoomName",function()
    return BaseNode.new()
end)

--[[
gameName = "",
isFree = 0,
callback = function() end
]]
function CreateRoomName:ctor(options)
    print("CreateRoomName:ctor")
    self:setSwallowTouches(true)
    self.m_newFlag = options.newFlag or 0
    local sprNameUnSelect = self:getNameSprite(options.gameName, false, options.isFree, options.gameId)
    local sprNameSelect = self:getNameSprite(options.gameName, true, options.isFree, options.gameId)
    self:initSelectItem(sprNameUnSelect, sprNameSelect)
    self.m_callback = options.callback or function () end
end

function CreateRoomName:getNameSprite(strGameName, isSelect, isFree, gameId)
    local strBgFile = ""
    local txtColor = nil
    local txtSize = 0

    if isSelect == false then
        strBgFile = "create_room_name_bg_skin.png"
        txtColor = cc.c3b(234, 191, 174)
        txtSize = 38
    else
        strBgFile = "create_room_name_bg_select.png"
        txtColor = cc.c3b(255, 255, 255)
        txtSize = 42
    end

    local sprNameBase = display.newSprite("#"..strBgFile)

    local x = W2(sprNameBase)
    if isSelect then
        x = x - 8
    end
    
    display.newTTFLabel({
        text = strGameName,
        size = txtSize,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER, x, H2(sprNameBase)):addTo(sprNameBase)

    if isFree > 0 then
        local sprFree = display.newSprite("#lob_room_aa_free_flag_skin.png")
        sprFree:align(display.TOP_LEFT, -8, H(sprNameBase)+3):addTo(sprNameBase)
    end
    
    --“最新”标签
    if self.m_newFlag > 0 then
        local conSize = sprNameBase:getContentSize()
        display.newSprite("#activity_name_item_new_flag.png"):align(display.LEFT_TOP, -3, conSize.height+5):addTo(sprNameBase)
    end

    return sprNameBase
end

function CreateRoomName:initSelectItem(unSelectSprite,selectSprite,callback)
    unSelectSprite:align(display.TOP_LEFT,0,H(unSelectSprite)):addTo(self, ORDER_BASE, Tag.UNSELECT_ITEM)
    selectSprite:align(display.TOP_LEFT,0,H(selectSprite)):addTo(self, ORDER_BASE, Tag.SELECT_ITEM):setVisible(false)
    self:setContentSize(SIZE(unSelectSprite))
end

function CreateRoomName:onTouchEnded(touch)
    print("CreateRoomName.onTouchEnded")
    self.m_callback()
end

--选中
function CreateRoomName:setSelect(bSelect)
    local unSelectSprite = self:getChildByTag(Tag.UNSELECT_ITEM)
    local selectSprite = self:getChildByTag(Tag.SELECT_ITEM)
    
    if unSelectSprite and selectSprite then
        if bSelect == true then
            unSelectSprite:setVisible(false)
            selectSprite:setVisible(true)
        else
            unSelectSprite:setVisible(true)
            selectSprite:setVisible(false)
        end
    end
end

return CreateRoomName
