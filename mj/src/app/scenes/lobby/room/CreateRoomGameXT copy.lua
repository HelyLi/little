local CreateRoomGameBase = import(".CreateRoomGameBase")
local CreateRoomOption = import(".CreateRoomOption")

-- difen = {},
--             difen_default = 1,
--             --封顶
--             fengding = {},
--             fengding_default = 1,
--             --飘赖子有奖
--             piao_laizi_prize = {},
--             piao_laizi_prize_default = 1,
--             --赖子几张胡牌
--             hu_laizi_num = {},
--             hu_laizi_num_default = 

local TAG = {
    JU_BASE = 100,
    JU_MAX = 105,
    PEOPLE_BASE = 110,
    PEOPLE_MAX = 115,
    DIFEN_BASE = 120,
    DIFEN_MAX = 125,
    FENGDING_BASE = 130,
    FENGDING_MAX = 135,
    --飘赖有奖
    PIAO_LAIZI_PRIZE = 140,
    --胡赖子数
    HU_LAIZI_NUM = 141
}

local CreateRoomGameXT = class("CreateRoomGameXT", function ()
    return CreateRoomGameBase.new()
end)

function CreateRoomGameXT:ctor()
    self:init()
end

function CreateRoomGameXT:init()
    self.m_roomInfo = Game:getGameData():getCardRoomInfo(XTMJ_CARD_GAME_ID)
    self:initView()
end

function CreateRoomGameXT:initView()
    self.m_startOptionX = 0
    self.m_startOptionY = 0
    self.m_optionOffsetX = 430
    self.m_optionOffsetY = 100
end

-- "playerJuInfos" = {
--              1 = {
--                  "aapay_ju16"    = 2
--                  "aapay_ju8"     = 1
--                  "ownerpay_ju16" = 4
--                  "ownerpay_ju8"  = 2
--                  "playernum"     = 2
--              }
--              2 = {
--                  "aapay_ju16"    = 2
--                  "aapay_ju8"     = 1
--                  "ownerpay_ju16" = 6
--                  "ownerpay_ju8"  = 3
--                  "playernum"     = 3
--              }
--              3 = {
--                  "aapay_ju16"    = 2
--                  "aapay_ju8"     = 1
--                  "ownerpay_ju16" = 8
--                  "ownerpay_ju8"  = 4
--                  "playernum"     = 4
--              }
--          }

function CreateRoomGameXT:initOptionJu()
    self:removeChild(TAG.JU_BASE, TAG.JU_MAX)


end

function CreateRoomGameXT:initOptionPeople(startx, starty)
    self:removeChild(TAG.PEOPLE_BASE, TAG.PEOPLE_MAX)

    local peopleInfo = self.m_roomInfo.playerJuInfos
    for i,info in ipairs(peopleInfo) do
        local params = {}
        params.str = string.format("%d人", info.playernum)
        local option = CreateRoomOption.new(function() self:menuOptionSelect(TAG.PEOPLE_BASE + i) end):align(display.CENTER, startx + self.m_optionOffsetX * (i - 1), starty):addTo(self, 0, TAG.PEOPLE_BASE + i)
        option:initWithString(params)
        option:setSelect(CALC_3(self.m_roomInfo.playerJuInfos_default == i, true, false))
    end
end

-- "difen" = {
--     [LUA-print] -             1 = "1"
--     [LUA-print] -             2 = "2"
--     [LUA-print] -             3 = "5"
--     [LUA-print] -         }
function CreateRoomGameXT:initOptionDifen(startx, starty)
    self:removeChild(TAG.DIFEN_BASE, TAG.DIFEN_MAX)

    local difen = self.m_roomInfo.difen
    for i,v in ipairs(difen) do
        local params = {}
        params.str = string.format("%d底分", v)
        local option = CreateRoomOption.new(function() self:menuOptionSelect(TAG.DIFEN_BASE + i) end):align(display.CENTER, startx + self.m_optionOffsetX * (i - 1), starty):addTo(self, 0, TAG.DIFEN_BASE + i)
        option:initWithString(params)
        option:setSelect(CALC_3(self.m_roomInfo.difen_default == i, true, false))
    end
end
-- "fengding" = {
--     [LUA-print] -             1 = "100"
--     [LUA-print] -             2 = "200"
--     [LUA-print] -         }
--     [LUA-print] -         "fengding_default"         = 1
function CreateRoomGameXT:initOptionFengding()
    self:removeChild(TAG.FENGDING_BASE, TAG.FENGDING_MAX)

    local fengding = self.m_roomInfo.fengding
    for i,v in ipairs(fengding) do
        local params = {}
        params.str = string.format("%d封顶", v)
        local option = CreateRoomOption.new(function() self:menuOptionSelect(TAG.FENGDING_BASE + i) end):align(display.CENTER, startx + self.m_optionOffsetX * (i - 1), starty):addTo(self, 0, TAG.FENGDING_BASE + i)
        option:initWithString(params)
        option:setSelect(CALC_3(self.m_roomInfo.fengding_default == i, true, false))
    end
end

-- "piao_laizi_prize" = {
--     [LUA-print] -             1 = "1"
--     [LUA-print] -             2 = "2"
--     [LUA-print] -         }
--     [LUA-print] -         "piao_laizi_prize_default" = 1
-- "hu_laizi_num" = {
--     [LUA-print] -             1 = "1"
--     [LUA-print] -             2 = "2"
--     [LUA-print] -         }
--     [LUA-print] -         "hu_laizi_num_default"     = 1

function CreateRoomGameXT:initOptionTese(startx, starty)
    self:removeChild(TAG.PIAO_LAIZI_PRIZE, TAG.HU_LAIZI_NUM)

    local pdefault = self.m_roomInfo.piao_laizi_prize_default
    local option = CreateRoomOption.new(function ()
        self:menuOptionSelect(TAG.PIAO_LAIZI_PRIZE)
    end):align(display.CENTER, startx + self.m_optionOffsetX * (i - 1), starty):addTo(self, 0, TAG.PIAO_LAIZI_PRIZE)
    option:initWithTickString({
        str = "漂赖有奖",
    })
    option:setSelect(CALC_3(pdefault == 1, true, false))

    local hdefault = self.m_roomInfo.hu_laizi_num_default
    local option = CreateRoomOption.new(function ()
        self:menuOptionSelect(TAG.HU_LAIZI_NUM)
    end):align(display.CENTER, startx + self.m_optionOffsetX * (i - 1), starty):addTo(self, 0, TAG.HU_LAIZI_NUM)
    option:initWithTickString({
        str = "一个赖子胡",
    })
    option:setSelect(CALC_3(hdefault == 1, true, false))
end

function CreateRoomGameXT:removeChild(starttag, endtag)
    for tag=starttag, endtag do
        self:removeChildByTag(tag)
    end
end

function CreateRoomGameXT:menuOptionSelect(tag)
    if tag >= TAG.JU_BASE and tag <= TAG.JU_MAX then

    elseif tag >= TAG.PEOPLE_BASE and tag <= TAG.PEOPLE_MAX then

    elseif tag >= TAG.DIFEN_BASE and tag <= TAG.DIFEN_MAX then

    elseif tag >= TAG.FENGDING_BASE and tag <= TAG.FENGDING_MAX then

    elseif tag == TAG.PIAO_LAIZI_PRIZE then

    elseif tag == TAG.HU_LAIZI_NUM then
        
    end
end

return CreateRoomGameXT