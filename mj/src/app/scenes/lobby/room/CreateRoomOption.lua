local BaseNode = import("app.views.BaseNode")

local TAG = {
    OPTION_SELECT_ITEM = 10,
    OPTION_UNSELECT_ITEM = 11
}

local CreateRoomOption = class("CreateRoomOption",function()
    return BaseNode.new()
end)

function CreateRoomOption:ctor(callback)
    self:addOnClick(callback)
    self:setTouchEnabled(true)
end

-- difen = {},
-- difen_default = 1,
-- --封顶
-- fengding = {},
-- fengding_default = 1,
-- --飘赖子有奖
-- piao_laizi_prize = {},
-- piao_laizi_prize_default = 1,
-- --赖子几张胡牌
-- hu_laizi_num = {},
-- hu_laizi_num_default = 1

--[[
    js,card,callback, scale
]]
--局数/1课
function CreateRoomOption:initWithJuShu(params)

    local sprJuShu = self:getOptionJuShu(params.js, params.card, false, params.style)
    local sprJuShuSelect = self:getOptionJuShu(params.js, params.card, true, params.style)
    self:initSelectItem(sprJuShu,sprJuShuSelect)
end

--[[
  {
      str = "",
      style = 1,
      callback = function
  }  
]]
--纯文字选项
function CreateRoomOption:initWithString(params)

    local sprStrItem = self:getOptionString(params.str, false, params.style)
    local sprStrItemSelect = self:getOptionString(params.str, true, params.style)
    self:initSelectItem(sprStrItem, sprStrItemSelect)
end

--[[
    {
        str = "",
        style = 1,
        callback
    }
]]
--☑️文字选项勾选
function CreateRoomOption:initWithTickString(params)
    local sprItemOff = self:getTickString(params.str, false, params.style)
    local sprItemOn = self:getTickString(params.str, true, params.style)
    
    self:initSelectItem(sprItemOff, sprItemOn)
end

--选项
function CreateRoomOption:initSelectItem(unSelectSprite, selectSprite)
    unSelectSprite:align(display.BOTTOM_LEFT,0,0):addTo(self,0,TAG.OPTION_UNSELECT_ITEM)
    selectSprite:align(display.BOTTOM_LEFT,0,0):addTo(self,0,TAG.OPTION_SELECT_ITEM):setVisible(false)
    self:setContentSize(SIZE(unSelectSprite))
end

--局数/1课
function CreateRoomOption:getOptionJuShu(js,card,isSelect,scale)
    local strBgFile = ""
    local strCardFile = ""
    local txtColor = nil
    local txtSize = 42
    local jsX, divX, fkX, numX, freeX = 58, 118, 145,240,132
    if self._small then
        txtSize = 36
        jsX, divX, fkX, numX, freeX = 50, 94, 106,208,100
    end

    if isSelect == false then
        strBgFile = "create_room_option_bg_qz_skin.png"
        if self._small then
            strBgFile = "create_room_option_bg_s_skin.png"
        end
        strCardFile = AppConfig:getDiamondImg("create_room_option_card")
        txtColor = cc.c3b(113, 63, 50)
    else
        strBgFile = "create_room_option_select_qz_skin.png"
        if self._small then
            strBgFile = "create_room_option_s_select_skin.png"
        end
        strCardFile = AppConfig:getDiamondImg("create_room_option_card_select")
        txtColor = cc.c3b(16, 69, 141)
    end

    local sprOptionBase = cc.ui.UIImage.new("#"..strBgFile)
    
    --局数
    local strJuShu = ""

    if js == 1 then
        strJuShu = "1 课"
    else
        strJuShu = string.format("%d 局", js)
    end

    display.newTTFLabel({
        text = strJuShu,
        size = txtSize,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER, jsX, H2(sprOptionBase)):addTo(sprOptionBase)

    --分割
    cc.ui.UIImage.new("#create_room_option_line_skin.png"):align(display.CENTER, divX, H2(sprOptionBase)):addTo(sprOptionBase)
    --房卡
    cc.ui.UIImage.new("#"..strCardFile):align(display.CENTER_LEFT, fkX, H2(sprOptionBase)):addTo(sprOptionBase)
    --x几
    display.newTTFLabel({
        text = string.format("x%d", card),
        size = 35,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER, numX, H2(sprOptionBase)):addTo(sprOptionBase)
    
    if card == 0 then
        --Free
        cc.ui.UIImage.new("#create_room_option_free_skin.png"):align(display.CENTER_LEFT, freeX, H2(sprOptionBase)):addTo(sprOptionBase, 1)
    end
    
    return sprOptionBase
end

--文字选项
function CreateRoomOption:getOptionString(str,isSelect, scale)
    local strBgFile = ""
    local txtColor = nil
    local txtSize = 42
    if self._small then
        txtSize = 36
    end

    if isSelect == false then
        --strBgFile = scale == true and "create_room_option_bg_qz_skin.png" or "create_room_option_bg_skin.png"
        strBgFile = "create_room_option_bg_qz_skin.png"
        if self._small then
            strBgFile = "create_room_option_bg_s_skin.png"
        end
        txtColor = cc.c3b(113, 63, 50)
    else
        --strBgFile = scale == true and "create_room_option_select_qz_skin.png" or "create_room_option_select_skin.png"
        strBgFile = "create_room_option_select_qz_skin.png"
        if self._small then
            strBgFile = "create_room_option_s_select_skin.png"
        end
        txtColor = cc.c3b(16, 69, 141)
    end

    local sprOptionBase = cc.ui.UIImage.new("#"..strBgFile)
    
    display.newTTFLabel({
        text = str,
        size = txtSize,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER, W2(sprOptionBase), H2(sprOptionBase)):addTo(sprOptionBase)
    
    return sprOptionBase
end

--勾选文字选项
function CreateRoomOption:getTickString(str, isSelect, baseW)
    local strTickFile = ""
    local txtColor = nil

    if isSelect == false then
        strTickFile = "#create_room_option_m_off_skin.png"
        txtColor = cc.c3b(113, 63, 50)
    else
        strTickFile = "#create_room_option_m_on_skin.png"
        txtColor = cc.c3b(16, 69, 141)
    end

    local sprOptionBase = display.newNode()
    
    --勾
    local sp = display.newSprite(strTickFile)
    
    --文字
    local txt = display.newTTFLabel({
        text = str,
        size = 42,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    })
    local baseWidth = (W(sp) + 10 + W(txt)) 
    dump(baseWidth,"11111baseWbaseWbaseWbaseWbaseW")
    if baseWidth < 302 then
        baseWidth = 302
    end
    baseWidth = baseW or baseWidth
    dump(baseWidth,"22222baseWbaseWbaseWbaseWbaseW")
    sprOptionBase:setContentSize(cc.size(baseWidth, math.max(H(txt), H(sp))))

    sp:align(display.CENTER_LEFT, 0, H2(sprOptionBase)):addTo(sprOptionBase)
    txt:align(display.CENTER_LEFT, W(sp) + 10, H2(sprOptionBase)):addTo(sprOptionBase)
    
    return sprOptionBase
end

--选中
function CreateRoomOption:setSelect(bSelect)
    local unSelectSprite = self:getChildByTag(TAG.OPTION_UNSELECT_ITEM)
    local selectSprite = self:getChildByTag(TAG.OPTION_SELECT_ITEM)
    
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

--选中
function CreateRoomOption:selectAnima()
    self:stopAllActions()
    self:setScale(1.06)
    self:runAction(cc.ScaleTo:create(0.06, 1))
end

return CreateRoomOption
