local CreateRoomGameBase = import(".CreateRoomGameBase")
local CreateRoomOption = import(".CreateRoomOption")

local TAG = {
    JU_BASE = 100,
    JU_MAX = 105,
    PEOPLE_BASE = 110,
    PEOPLE_MAX = 115,
    DIFEN_BASE = 120,
    DIFEN_MAX = 125,
    FENGDING_BASE = 130,
    FENGDING_MAX = 135,
    COST_BASE = 140,
    COST_MAX = 142,
    --飘赖有奖
    PIAO_LAIZI_PRIZE = 150,
    --胡赖子数
    HU_LAIZI_NUM = 151
}

local CreateRoomGameXT = class("CreateRoomGameXT", function ()
    return CreateRoomGameBase.new()
end)

function CreateRoomGameXT:ctor()
    self:init()
end

function CreateRoomGameXT:init()
    self.m_roomInfo = Game:getGameData():getCreateRoomInfo():getCardRoomInfo(XTMJ_CARD_GAME_ID)
    self:initView()
end

function CreateRoomGameXT:initView()
    self.m_startOptionX = 150
    self.m_startOptionY = 0
    self.m_optionPaddingX = 210
    self.m_optionPaddingY = 75

    local optionNameX = 40

    local lineHeight = 20

    self.m_juY = H(self)
    --局数
    display.newSprite("#create_room_txt_jushu.png"):align(display.CENTER_LEFT, optionNameX, self.m_juY):addTo(self)
    self:initOptionJu(self.m_startOptionX, self.m_juY)

    local peopleY = self.m_juY - self.m_optionPaddingY - lineHeight
    --人数
    display.newSprite("#create_room_txt_people.png"):align(display.CENTER_LEFT, optionNameX, peopleY):addTo(self)
    self:initOptionPeople(self.m_startOptionX, peopleY)

    local difenY = peopleY - self.m_optionPaddingY - lineHeight
    display.newSprite("#create_room_txt_difen.png"):align(display.CENTER_LEFT, optionNameX, difenY):addTo(self)
    self:initOptionDifen(self.m_startOptionX, difenY)

    local fengdingY = difenY - self.m_optionPaddingY - lineHeight
    display.newSprite("#create_room_txt_wanfa.png"):align(display.CENTER_LEFT, optionNameX, fengdingY):addTo(self)
    self:initOptionFengding(self.m_startOptionX, fengdingY)

    local costY = fengdingY - self.m_optionPaddingY - lineHeight
    display.newSprite("#create_room_txt_wanfa.png"):align(display.CENTER_LEFT, optionNameX, costY):addTo(self)
    self:initOptionCost(self.m_startOptionX, costY)

    local wanfaY = costY - self.m_optionPaddingY - lineHeight
    display.newSprite("#create_room_txt_wanfa.png"):align(display.CENTER_LEFT, optionNameX, wanfaY):addTo(self)
    self:initOptionTese(self.m_startOptionX, wanfaY)

end

function CreateRoomGameXT:initOptionJu(startx, starty)
    for i=1,5 do
        self:removeChildByTag(TAG.JU_BASE + i)
    end

    local people_def = self.m_roomInfo.playernum_default
    local juInfo = self.m_roomInfo.playerJuInfos[people_def]

    --选择局数
    for i,v in ipairs(juInfo) do
        local optionJu = CreateRoomOption.new(function()
            self:menuOptionSelect(TAG.JU_BASE + i)
        end):align(display.CENTER_LEFT, startx + self.m_optionPaddingX*3/2*(i - 1), starty)
        
        optionJu:initWithPointTick(string.format("%d局", v[1]), v[2])
        
        if v[1] == self.m_roomInfo.jushu_default then
            optionJu:setSelect(true)
        else
            optionJu:setSelect(false)
        end
        optionJu:addTo(self, 0, TAG.JU_BASE + i)
    end
end

function CreateRoomGameXT:initOptionPeople(startx, starty)
    local people = self.m_roomInfo.playernum

    --选择人数
    local rbs = {}
    local selectIndex = 0
    for i,v in ipairs(people) do
        
        local strPeople = string.format("%d 人", v)
        
        table.insert(rbs, {
            on = "#create_room_option_dxt_on.png",
            off = "#create_room_option_dxt_off.png",
            txt = {
                text = strPeople,
                color = cc.c3b(147,44,17),
                color2 = cc.c3b(0,136,0),
                size = 36
            }
        })

        if self.m_roomInfo.playernum_default == v then
            selectIndex = i + TAG.PEOPLE_BASE
        end
    end
    
    local rg = comui.createRadioGroup({
        rbs = rbs,
        padding = self.m_optionPaddingX,
        tagBase = TAG.PEOPLE_BASE,
        posType = 1,
        callback = handler(self, self.menuOptionSelect)
    })
    if rg then
        rg:align(display.CENTER_LEFT, startx, starty):addTo(self, 0, TAG.PEOPLE_BASE)
        rg:setSelectIndex(selectIndex)
    end
end

function CreateRoomGameXT:initOptionDifen(startx, starty)
    local difen = self.m_roomInfo.difen
    --选择人数
    local rbs = {}
    local selectIndex = 0
    for i,v in ipairs(difen) do
        
        local str = string.format("%d底分", v)
        
        table.insert(rbs, {
            on = "#create_room_option_dxt_on.png",
            off = "#create_room_option_dxt_off.png",
            txt = {
                text = str,
                color = cc.c3b(147,44,17),
                color2 = cc.c3b(0,136,0),
                size = 36
            }
        })

        if self.m_roomInfo.difen_default == i then
            selectIndex = i + TAG.DIFEN_BASE
        end
    end
    
    local rg = comui.createRadioGroup({
        rbs = rbs,
        padding = self.m_optionPaddingX,
        tagBase = TAG.DIFEN_BASE,
        posType = 1,
        callback = handler(self, self.menuOptionSelect)
    })
    if rg then
        rg:align(display.CENTER_LEFT, startx, starty):addTo(self, 0, TAG.DIFEN_BASE)
        rg:setSelectIndex(selectIndex)
    end
end

function CreateRoomGameXT:initOptionFengding(startx, starty)
    local fengding = self.m_roomInfo.fengding
    --选择人数
    local rbs = {}
    local selectIndex = 0
    for i,v in ipairs(fengding) do
        
        local str = string.format("%d封顶", v)
        if v == -1 then
            str = "不封顶"
        end
        table.insert(rbs, {
            on = "#create_room_option_dxt_on.png",
            off = "#create_room_option_dxt_off.png",
            txt = {
                text = str,
                color = cc.c3b(147,44,17),
                color2 = cc.c3b(0,136,0),
                size = 36
            }
        })

        if self.m_roomInfo.fengding_default == v then
            selectIndex = i + TAG.FENGDING_BASE
        end
    end
    
    local rg = comui.createRadioGroup({
        rbs = rbs,
        padding = self.m_optionPaddingX,
        tagBase = TAG.FENGDING_BASE,
        posType = 1,
        callback = handler(self, self.menuOptionSelect)
    })
    if rg then
        rg:align(display.CENTER_LEFT, startx, starty):addTo(self, 0, TAG.FENGDING_BASE)
        rg:setSelectIndex(selectIndex)
    end
end

function CreateRoomGameXT:initOptionTese(startx, starty)
    -- "payment_default"          = 1
    -- "piao_laizi_prize" = {
    --     1 = 1
    --     2 = 2
    -- }
    local pdefault = self.m_roomInfo.piao_laizi_prize_default
    local option = CreateRoomOption.new(function()
        self:menuOptionSelect(TAG.PIAO_LAIZI_PRIZE)
    end):align(display.CENTER_LEFT, startx, starty):addTo(self, 0, TAG.PIAO_LAIZI_PRIZE)
    option:initWithTickString({
        str = "漂赖有奖",
        style = AppGlobal.RoomOptonStyle.SMALL
    })
    option:setSelect(CALC_3(pdefault == 1, true, false))

    -- "hu_laizi_num" = {
    --     1 = 1
    --     2 = 2
    -- }
    -- "hu_laizi_num_default"     = 1
    local hdefault = self.m_roomInfo.hu_laizi_num_default
    local option = CreateRoomOption.new(function()
        self:menuOptionSelect(TAG.HU_LAIZI_NUM)
    end):align(display.CENTER_LEFT, startx + self.m_optionPaddingX*3/2, starty):addTo(self, 0, TAG.HU_LAIZI_NUM)
    option:initWithTickString({
        str = "一赖到底",
        style = AppGlobal.RoomOptonStyle.SMALL
    })
    option:setSelect(CALC_3(hdefault == 1, true, false))
end

--房费
function CreateRoomGameXT:initOptionCost(startx, starty)

    local rbs = {}
    for i = 1, 2 do
        local strTxt = ""
        if i == 1 then
            strTxt = "房费平摊"
        elseif i == 2 then
            strTxt = "房主付费"
        end

        table.insert(rbs, {
            on = "#create_room_option_dxt_on.png",
            off = "#create_room_option_dxt_off.png",
            txt = {
                text = strTxt,
                color = cc.c3b(147,44,17),
                color2 = cc.c3b(0,136,0),
                size = 36
            }
        })
    end

    local rg = comui.createRadioGroup({
        rbs = rbs,
        padding = self.m_optionPaddingX,
        tagBase = TAG.COST_BASE,
        posType = 1,
        callback = handler(self, self.menuOptionSelect)
    })
    if rg then
        rg:align(display.CENTER_LEFT, startx, starty):addTo(self)
        if self.m_roomInfo.payment_default == 2 then
            rg:setSelectIndex(1 + TAG.COST_BASE)
        else
            rg:setSelectIndex(2 + TAG.COST_BASE)
        end
    end
end

function CreateRoomGameXT:menuOptionSelect(tag)
    print("menuOptionSelect:", tag)
    if tag >= TAG.JU_BASE and tag <= TAG.JU_MAX then
        local selectIndx = tag - TAG.JU_BASE
        local people_def = self.m_roomInfo.playernum_default
        local juInfo = self.m_roomInfo.playerJuInfos[people_def]
        self.m_roomInfo.jushu_default = juInfo[selectIndx][1]
        
        self:refreshOptionItem(self, TAG.JU_BASE, TAG.JU_MAX, selectIndx)
    elseif tag >= TAG.PEOPLE_BASE and tag <= TAG.PEOPLE_MAX then
        local selectIndx = tag - TAG.PEOPLE_BASE
        self.m_roomInfo.playernum_default = self.m_roomInfo.playernum[selectIndx]
        self:initOptionJu(self.m_startOptionX, self.m_juY)

    elseif tag >= TAG.DIFEN_BASE and tag <= TAG.DIFEN_MAX then
        local selectIndx = tag - TAG.DIFEN_BASE
        self.m_roomInfo.difen_default = self.m_roomInfo.difen[selectIndx]

    elseif tag >= TAG.FENGDING_BASE and tag <= TAG.FENGDING_MAX then
        local selectIndx = tag - TAG.FENGDING_BASE
        self.m_roomInfo.fengding_default = self.m_roomInfo.fengding[selectIndx]

    elseif tag >= TAG.COST_BASE and tag <= TAG.COST_MAX then
        local selectIndx = tag - TAG.COST_BASE
        -- self.m_roomInfo.payment_default = self.m_roomInfo.payment[selectIndx]
        local pdefault = self.m_roomInfo.payment_default
        if pdefault == 1 then
            pdefault = 2
        else
            pdefault = 1
        end
        self.m_roomInfo.payment_default = pdefault

    elseif tag == TAG.PIAO_LAIZI_PRIZE then
        local pdefault = self.m_roomInfo.piao_laizi_prize_default
        if pdefault == 1 then
            pdefault = 2
        else
            pdefault = 1
        end
        self.m_roomInfo.piao_laizi_prize_default = pdefault
        self:refreshOneOptionItem(self, TAG.PIAO_LAIZI_PRIZE, pdefault == 1)
    elseif tag == TAG.HU_LAIZI_NUM then
        local hdefault = self.m_roomInfo.hu_laizi_num_default
        if hdefault == 1 then
            hdefault = 2
        else
            hdefault = 1
        end
        self.m_roomInfo.hu_laizi_num_default = hdefault
        self:refreshOneOptionItem(self, TAG.HU_LAIZI_NUM, hdefault == 1)
    end
end

return CreateRoomGameXT