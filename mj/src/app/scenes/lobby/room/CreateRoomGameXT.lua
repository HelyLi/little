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

end




return CreateRoomGameXT