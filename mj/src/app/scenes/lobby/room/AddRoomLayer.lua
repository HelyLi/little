local BaseView = import("app.views.BaseView")
local AddRoomLayer = class("AddRoomLayer", function()
    return BaseView.new()
end)

local TAG = {
    KEY_BOARD_NUM_BASE = 199,
    KEY_BOARD_NUM_1 = 200,
    KEY_BOARD_NUM_2 = 201, 
    KEY_BOARD_NUM_3 = 202,
    KEY_BOARD_NUM_4 = 203,
    KEY_BOARD_NUM_5 = 204,
    KEY_BOARD_NUM_6 = 205,
    KEY_BOARD_NUM_7 = 206,
    KEY_BOARD_NUM_8 = 207,
    KEY_BOARD_NUM_9 = 208,
    KEY_BOARD_NUM_redo = 209,
    KEY_BOARD_NUM_0 = 210,
    KEY_BOARD_NUM_delete = 211
}

local InputBtnTxt = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '重输', '0', '删除'}

function AddRoomLayer:ctor()
    self:setSwallowTouches(true)
    self:init()
end

function AddRoomLayer:init()
    self:initView()
end

function AddRoomLayer:initView()
    --zz
    local zzLayer = display.newColorLayer(cc.c4b(0, 0, 0, 200)):addTo(self,ADD_ROOM_ORDER_GREY)
    :setContentSize(display.width,display.height)

    local bg = display.newSprite("#add_room_bg_skin.png"):align(display.CENTER_TOP,display.cx,display.height):addTo(self)
    
    display.newSprite("#add_room_title_skin.png"):align(display.CENTER, W2(bg), H(bg) - 66):addTo(bg)

    local input_bg = display.newScale9Sprite('#input_num_bg_skin.png', 0, 0, cc.size(580, 110), cc.rect(30, 50, 10, 10))
    input_bg:align(display.CENTER, W2(bg), H(bg) - 185):addTo(bg)

    self._numT = {}
    --房间id数字
    for i=1,6 do
        local labNum = comui.createLabelAtlas({
            stringValue = "",
            charMapFile = "NumFonts/inout_num_id_num_skin.png",
            itemWidth = 45,
            itemHeight = 66,
            startCharMap = '0'
        })
        labNum:align(display.CENTER,W(input_bg)/12 + (i-1)*W(input_bg)/6, H2(input_bg)):addTo(input_bg, 0, i)
        table.insert( self._numT, i, labNum)
        --input line
        if i ~= 6 then
            display.newSprite("#input_num_line_skin.png"):align(display.CENTER, W(input_bg)*i/6, H2(input_bg)):addTo(input_bg)
        end
    end

    local startPos = cc.p(display.cx-295, display.cy + 120 - 94)
    for i=1,12 do
        local rowIndx = math.ceil(i/3)
        local columnIndx = i%3
        if columnIndx == 0 then
            columnIndx = 3
        end
        local start_x = startPos.x+205*(columnIndx-1)
        local start_y = startPos.y-105*(rowIndx-1)

        local btn = comui.Button({
            normal = "input_num_btn_skin.png",
            text = InputBtnTxt[i],
            fontSize = 45,
            fontColor = cc.c3b(120, 120, 120),
            tag = i,
            callfunc = handler(self, self.menuCallback),
        })
        btn:align(display.CENTER, start_x + W2(btn), start_y + H2(btn)):addTo(self, 1)
    end

    comui.Button({
        normal = "com_close_btn_special.png",
        pos = cc.p(W(bg) - 50, H(bg) - 100),
        anchor = display.CENTER_TOP,
        parent = bg,
        callfunc = handler(self, self.dismiss)
    })
    self:cleanKeyBoard()
end

function AddRoomLayer:menuCallback(keyIndx)
    local keyTag = TAG.KEY_BOARD_NUM_BASE + keyIndx
    if keyTag >= TAG.KEY_BOARD_NUM_1 and keyTag <= TAG.KEY_BOARD_NUM_9 then
        if self:getCurInputNumIndx() <= 5 then
            self:setRoomIdNum(self:getCurInputNumIndx()+1, string.format("%d",keyIndx))
        else
            return
        end
        
        if self:getCurInputNumIndx() < 6 then
            self.m_curInputNumIndex = self.m_curInputNumIndex+1
        end
        
    elseif keyTag == TAG.KEY_BOARD_NUM_0 then
        if self:getCurInputNumIndx() <= 5 then
            self:setRoomIdNum(self:getCurInputNumIndx()+1,"0")
        else
            return
        end
        
        if self:getCurInputNumIndx() < 6 then
            self.m_curInputNumIndex = self.m_curInputNumIndex+1
        end
        
    elseif keyTag == TAG.KEY_BOARD_NUM_redo then
        self:clearRoomIdNum()
        self:setCurInputNumIndx(0)
    elseif keyTag == TAG.KEY_BOARD_NUM_delete then
        if self:getCurInputNumIndx() <= 5 and self:getCurInputNumIndx() > 0 then
            self:setRoomIdNum(self:getCurInputNumIndx(), "")
            self.m_curInputNumIndex = self.m_curInputNumIndex-1
        else
            self:setCurInputNumIndx(0)
        end
    end
    
    if self:getCurInputNumIndx() == 6 then
        -- comui.addWaitingLayer({touchProhibit = true})
        -- self:performWithDelay(function() self:roomExistConnect() end, 0.3)
    end
end

function AddRoomLayer:setRoomIdNum(index,num)
    local text = self._numT[index]--self:getChildByTag(KEY_SCREEN_LABEL_1 + index)
    if text ~= nil then
        text:setString(num)
    end
end

function AddRoomLayer:clearRoomIdNum()
    for i=1,6 do
        self:setRoomIdNum(i, "")
    end
end

function AddRoomLayer:setCurInputNumIndx(index)
    self.m_curInputNumIndex = index
end

function AddRoomLayer:getCurInputNumIndx()
    return self.m_curInputNumIndex or 0
end

function AddRoomLayer:dismiss()
    if comui.isWaiting() then
        comui.removeWaitingLayer()
        self:cleanKeyBoard()
        return
    end
    BaseView.dismiss(self)
end

function AddRoomLayer:cleanKeyBoard()
    self:setCurInputNumIndx(0)
    self:clearRoomIdNum()
end

return AddRoomLayer