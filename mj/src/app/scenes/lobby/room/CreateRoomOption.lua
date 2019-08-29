--ORDER
local OPTION_ORDER_BASE = 6

--TAG
local OPTION_TAG_SELECT_ITEM = 6
local OPTION_TAG_UNSELECT_ITEM = 8

local function createMenuItem()
    local menuItem = cc.MenuItemSprite:create(display.newSprite(),display.newSprite())
    return menuItem
end

local CreateRoomOption = class("CreateRoomOption",function()
    return createMenuItem()
end)

function CreateRoomOption:ctor(small)
    self._small = small
end

--游金倍数
function CreateRoomOption:initWithYJBeiShu(bs,callback, scale)
    local sprBeiShu = self:getOptionYJBeiShu(bs, false, scale)
    local sprBeiShuSelect = self:getOptionYJBeiShu(bs, true, scale)
    self:initSelectItem(sprBeiShu, sprBeiShuSelect, callback)
end

--局数/1课
function CreateRoomOption:initWithJuShu(js,card,callback, scale)
    local sprJuShu = self:getOptionJuShu(js, card, false, scale)
    local sprJuShuSelect = self:getOptionJuShu(js, card, true, scale)
    self:initSelectItem(sprJuShu,sprJuShuSelect,callback)
end

--局数/圈
function CreateRoomOption:initWithJuShuQuan(js,card,callback, scale)
    local sprJuShu = self:getOptionJuShuQuan(js, card, false, scale)
    local sprJuShuSelect = self:getOptionJuShuQuan(js, card, true, scale)
    self:initSelectItem(sprJuShu,sprJuShuSelect,callback)
end

function CreateRoomOption:initWithJuShuPan(js,card,callback, scale)
    local sprJuShu = self:getOptionJuShuPan(js, card, false, scale)
    local sprJuShuSelect = self:getOptionJuShuPan(js, card, true, scale)
    self:initSelectItem(sprJuShu,sprJuShuSelect,callback)
end

--局数/1课
function CreateRoomOption:initWithJuShuFen(js,fen, card,callback, scale)
    local sprJuShu = self:getOptionJuShuFen(js,fen, card, false, scale)
    local sprJuShuSelect = self:getOptionJuShuFen(js,fen, card, true, scale)
    self:initSelectItem(sprJuShu,sprJuShuSelect,callback)
end

--比金/
function CreateRoomOption:initWithJuShuBijin(js,card,callback)
    local sprBiJin = self:getOptionJuShuBiJin(js, card, false)
    local sprBiJinSelect = self:getOptionJuShuBiJin(js, card, true)
    
    self:initSelectItem(sprBiJin, sprBiJinSelect, callback)
end

--6金
function CreateRoomOption:initWithSixGold(js, card, callback)
    local sprSixGold = self:getOptionSixGold(js, card, false)
    local sprSixGoldSelect = self:getOptionSixGold(js, card, true)
    
    self:initSelectItem(sprSixGold, sprSixGoldSelect, callback)
end


--纯文字选项
function CreateRoomOption:initWithString(str, callback, scale)
    local sprStrItem = self:getOptionString(str, false, scale)
    local sprStrItemSelect = self:getOptionString(str, true, scale)
    
    self:initSelectItem(sprStrItem, sprStrItemSelect, callback)
end

--☑️文字选项勾选
function CreateRoomOption:initWithTickString(str, callback,baseW)
    local sprItemOff = self:getTickString(str, false,baseW)
    local sprItemOn = self:getTickString(str, true,baseW)
    
    self:initSelectItem(sprItemOff, sprItemOn, callback)
end


--选项
function CreateRoomOption:initSelectItem(unSelectSprite, selectSprite, callback)
    self:onClicked(callback)
    unSelectSprite:align(display.BOTTOM_LEFT,0,0):addTo(self,OPTION_ORDER_BASE,OPTION_TAG_UNSELECT_ITEM)
    selectSprite:align(display.BOTTOM_LEFT,0,0):addTo(self,OPTION_ORDER_BASE,OPTION_TAG_SELECT_ITEM):setVisible(false)
    self:setContentSize(SIZE(unSelectSprite))
end


--游金倍数
function CreateRoomOption:getOptionYJBeiShu(bs,isSelect,scale)
    local strBgFile = ""
    local txtColor = nil

    if isSelect == false then
        --strBgFile = scale == true and "create_room_option_bg_qz_skin.png" or "create_room_option_bg_skin.png"
        strBgFile = "create_room_option_bg_qz_skin.png"
        txtColor = cc.c3b(113, 63, 50)
    else
        --strBgFile = scale == true and "create_room_option_select_qz_skin.png" or "create_room_option_select_skin.png"
        strBgFile = "create_room_option_select_qz_skin.png"
        txtColor = cc.c3b(16, 69, 141)
    end

    local sprOptionBase = cc.ui.UIImage.new("#"..strBgFile)

    display.newTTFLabel({
        text = string.format("游金 x %d", bs),
        size = 42,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER, W2(sprOptionBase), H2(sprOptionBase)):addTo(sprOptionBase)

    return sprOptionBase
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
        --strBgFile = scale == true and "create_room_option_bg_qz_skin.png" or "create_room_option_bg_skin.png"
        strBgFile = "create_room_option_bg_qz_skin.png"
        if self._small then
            strBgFile = "create_room_option_bg_s_skin.png"
        end
        strCardFile = AppConfig:getDiamondImg("create_room_option_card")
        txtColor = cc.c3b(113, 63, 50)
    else
        --strBgFile = scale == true and "create_room_option_select_qz_skin.png" or "create_room_option_select_skin.png"
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

--局数/圈
function CreateRoomOption:getOptionJuShuQuan(js,card,isSelect, scale)
    local strBgFile = ""
    local strCardFile = ""
    local txtColor = nil

    if isSelect == false then
        --strBgFile = scale == true and "create_room_option_bg_qz_skin.png" or "create_room_option_bg_skin.png"
        strBgFile = "create_room_option_bg_qz_skin.png"
        -- strCardFile = "create_room_option_card.png"
        strCardFile = AppConfig:getDiamondImg("create_room_option_card")
        txtColor = cc.c3b(113, 63, 50)
    else
        --strBgFile = scale == true and "create_room_option_select_qz_skin.png" or "create_room_option_select_skin.png"
        strBgFile = "create_room_option_select_qz_skin.png"
        -- strCardFile = "create_room_option_card_select.png"
        strCardFile = AppConfig:getDiamondImg("create_room_option_card_select")
        txtColor = cc.c3b(16, 69, 141)
    end

    local sprOptionBase = cc.ui.UIImage.new("#"..strBgFile)
    
    --圈数
    local strJuShu = string.format("%d 圈", js)
    
    display.newTTFLabel({
        text = strJuShu,
        size = 42,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER, 58, H2(sprOptionBase)):addTo(sprOptionBase)

    --分割
    cc.ui.UIImage.new("#create_room_option_line_skin.png"):align(display.CENTER, 118, H2(sprOptionBase)):addTo(sprOptionBase)
    --房卡
    cc.ui.UIImage.new("#"..strCardFile):align(display.CENTER_LEFT, 145, H2(sprOptionBase)):addTo(sprOptionBase)
    --x几
    display.newTTFLabel({
        text = string.format("x%d", card),
        size = 35,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER, 240, H2(sprOptionBase)):addTo(sprOptionBase)
    
    if card == 0 then
        --Free
        cc.ui.UIImage.new("#create_room_option_free_skin.png"):align(display.CENTER_LEFT, 132, H2(sprOptionBase)):addTo(sprOptionBase, 1)
    end
    
    return sprOptionBase
end

function CreateRoomOption:getOptionJuShuPan(js,card,isSelect,scale)
    local strBgFile = ""
    local strCardFile = ""
    local txtColor = nil
    local txtSize = 36
    local jsX, divX, fkX, numX, freeX = 58, 165, 175,270,162
    if self._small then
        txtSize = 36
        jsX, divX, fkX, numX, freeX = 58, 168, 175,270,162
    end

    if isSelect == false then
        --strBgFile = scale == true and "create_room_option_bg_qz_skin.png" or "create_room_option_bg_skin.png"
        strBgFile = "create_room_option_bg_qz_skin.png"
        if self._small then
            strBgFile = "create_room_option_bg_s_skin.png"
        end
        strCardFile = AppConfig:getDiamondImg("create_room_option_card")
        txtColor = cc.c3b(113, 63, 50)
    else
        --strBgFile = scale == true and "create_room_option_select_qz_skin.png" or "create_room_option_select_skin.png"
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

    -- if js == 1 then
    --     strJuShu = "1 课"
    -- elseif js == 50 or js == 100 then
    --     -- "1课"
    --     strJuShu = 
    -- else
    --     strJuShu = string.format("%d 局", js)
    -- end

    local node = display.newNode()
    local nodeW = 0
    local nodeH = H(sprOptionBase)

    local txt1 = display.newTTFLabel({
        text = "1课",
        size = txtSize,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER_LEFT, nodeW, H2(sprOptionBase)):addTo(node)
    nodeW = W(txt1)

    local txt2 = display.newTTFLabel({
        text = "·",
        size = txtSize,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER_LEFT, nodeW - 15, H2(sprOptionBase)):addTo(node)
    nodeW = nodeW + W(txt2) - 30

    local txt3 = display.newTTFLabel({
        text = string.format("%d盘", js),
        size = txtSize,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER_LEFT, nodeW, H2(sprOptionBase)):addTo(node)
    nodeW = nodeW + W(txt3) 

    node:setContentSize(cc.size(nodeW, nodeH))
    node:align(display.CENTER_LEFT, 15, H2(sprOptionBase)):addTo(sprOptionBase)
    
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

--局数/1课
function CreateRoomOption:getOptionJuShuFen(js,fen,card,isSelect,scale)
    local strBgFile = ""
    local strCardFile = ""
    local txtColor = nil
    local txtSize = 36
    local jsX, divX, fkX, numX, freeX = 58, 158, 165,260,152
    if self._small then
        txtSize = 36
        jsX, divX, fkX, numX, freeX = 50, 94, 106,208,100
    end

    if isSelect == false then
        --strBgFile = scale == true and "create_room_option_bg_qz_skin.png" or "create_room_option_bg_skin.png"
        strBgFile = "create_room_option_bg_qz_skin.png"
        if self._small then
            strBgFile = "create_room_option_bg_s_skin.png"
        end
        strCardFile = AppConfig:getDiamondImg("create_room_option_card")
        txtColor = cc.c3b(113, 63, 50)
    else
        --strBgFile = scale == true and "create_room_option_select_qz_skin.png" or "create_room_option_select_skin.png"
        strBgFile = "create_room_option_select_qz_skin.png"
        if self._small then
            strBgFile = "create_room_option_s_select_skin.png"
        end
        strCardFile = AppConfig:getDiamondImg("create_room_option_card_select")
        txtColor = cc.c3b(16, 69, 141)
    end

    local sprOptionBase = cc.ui.UIImage.new("#"..strBgFile)
    
    -- --局数
    -- local strJuShu = ""

    -- if js == 1 then
    --     strJuShu = string.format("1课·%d分", fen)
    -- else
    --     strJuShu = string.format("%d 局", js)
    -- end

    local node = display.newNode()
    local nodeW = 0
    local nodeH = H(sprOptionBase)

    local txt1 = display.newTTFLabel({
        text = "1课",
        size = txtSize,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER_LEFT, nodeW, H2(sprOptionBase)):addTo(node)
    nodeW = W(txt1)

    local txt2 = display.newTTFLabel({
        text = "·",
        size = txtSize,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER_LEFT, nodeW - 15, H2(sprOptionBase)):addTo(node)
    nodeW = nodeW + W(txt2) - 30

    local txt3 = display.newTTFLabel({
        text = string.format("%d分", fen),
        size = txtSize,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER_LEFT, nodeW, H2(sprOptionBase)):addTo(node)
    nodeW = nodeW + W(txt3) 

    node:setContentSize(cc.size(nodeW, nodeH))
    node:align(display.CENTER_LEFT, 15, H2(sprOptionBase)):addTo(sprOptionBase)

    -- display.newTTFLabel({
    --     text = strJuShu,
    --     size = txtSize,
    --     color = txtColor,
    --     align = cc.TEXT_ALIGNMENT_CENTER,
    -- }):align(display.CENTER_LEFT, 15, H2(sprOptionBase)):addTo(sprOptionBase)

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

--局数/比金
function CreateRoomOption:getOptionJuShuBiJin(js,card,isSelect)
    local strBgFile = ""
    local strCardFile = ""
    local txtColor = nil

    if isSelect == false then
        strBgFile = "create_room_option_bg_qz_skin.png"
        -- strCardFile = "create_room_option_card.png"
        strCardFile = AppConfig:getDiamondImg("create_room_option_card")
        txtColor = cc.c3b(113, 63, 50)
    else
        strBgFile = "create_room_option_select_qz_skin.png"
        -- strCardFile = "create_room_option_card_select.png"
        strCardFile = AppConfig:getDiamondImg("create_room_option_card_select")
        txtColor = cc.c3b(16, 69, 141)
    end
    local sprOptionBase = cc.ui.UIImage.new("#"..strBgFile)
    
    --局数
    local strJuShu = ""
    strJuShu = string.format("%d局", js)
    
    --x局·比金
    display.newTTFLabel({
        text = strJuShu,
        size = 38,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_RIGHT,
    }):align(display.CENTER_RIGHT, 76, H2(sprOptionBase)):addTo(sprOptionBase)

    display.newTTFLabel({
        text = "·比金",
        size = 26,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_LEFT,
    }):align(display.CENTER_LEFT, 76, H2(sprOptionBase)):addTo(sprOptionBase)
    
    --分割
    cc.ui.UIImage.new("#".."create_room_option_line_skin.png"):align(display.CENTER, 160, H2(sprOptionBase)):addTo(sprOptionBase)
    --房卡
    cc.ui.UIImage.new("#"..strCardFile):align(display.CENTER_LEFT, 170, H2(sprOptionBase)):addTo(sprOptionBase)
    --x几
    display.newTTFLabel({
        text = string.format("x%d", card),
        size = 35,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER, 268, H2(sprOptionBase)):addTo(sprOptionBase)
    
    if card == 0 then
        --Free
        cc.ui.UIImage.new("#".."create_room_option_free_skin.png"):align(display.CENTER_LEFT, 164, H2(sprOptionBase)):addTo(sprOptionBase, 1)
    end

    return sprOptionBase
end

--6金
function CreateRoomOption:getOptionSixGold(js, card, isSelect)
    local strBgFile = ""
    local strCardFile = ""
    local txtColor = nil

    if isSelect == false then
        strBgFile = "create_room_option_bg_qz_skin.png"
        -- strCardFile = "create_room_option_card.png"
        strCardFile = AppConfig:getDiamondImg("create_room_option_card")
        txtColor = cc.c3b(113, 63, 50)
    else
        strBgFile = "create_room_option_select_qz_skin.png"
        -- strCardFile = "create_room_option_card_select.png"
        strCardFile = AppConfig:getDiamondImg("create_room_option_card_select")
        txtColor = cc.c3b(16, 69, 141)
    end
    local sprOptionBase = cc.ui.UIImage.new("#"..strBgFile)
        
    --6金玩法
    display.newTTFLabel({
        text = "6金玩法",
        size = 38,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER, 80, H2(sprOptionBase)):addTo(sprOptionBase)
    
    --分割
    cc.ui.UIImage.new("#".."create_room_option_line_skin.png"):align(display.CENTER, 156, H2(sprOptionBase)):addTo(sprOptionBase)
    --房卡
    cc.ui.UIImage.new("#"..strCardFile):align(display.CENTER_LEFT, 168, H2(sprOptionBase)):addTo(sprOptionBase)
    --x几
    display.newTTFLabel({
        text = string.format("x%d", card),
        size = 35,
        color = txtColor,
        align = cc.TEXT_ALIGNMENT_CENTER,
    }):align(display.CENTER, 262, H2(sprOptionBase)):addTo(sprOptionBase)
    
    if card == 0 then
        --Free
        cc.ui.UIImage.new("#".."create_room_option_free_skin.png"):align(display.CENTER_LEFT, 162, H2(sprOptionBase)):addTo(sprOptionBase, 1)
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
    local unSelectSprite = self:getChildByTag(OPTION_TAG_UNSELECT_ITEM)
    local selectSprite = self:getChildByTag(OPTION_TAG_SELECT_ITEM)
    
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
