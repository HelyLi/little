local CreateRoomInfo = class("CreateRoomInfo")

function CreateRoomInfo:ctor()
    self:clear()
end

function CreateRoomInfo:clear()
    self._CardGameRoomInfo = {
		[XTMJ_CARD_GAME_ID] = {
			name = "泉州麻将",
			dwGameId = XTMJ_CARD_GAME_ID,
			isEnable = false,
			isHaveFree = 0,
			isCardAA = 0,
			-- 排序
			dwOrder = 0,
            
            playerJuInfos = {},
            playerJuInfos_default = 1,

            difen = {},
            difen_default = 1,
            --封顶
            fengding = {},
            fengding_default = 1,
            --飘赖子有奖
            piao_laizi_prize = {},
            piao_laizi_prize_default = 1,
            --赖子几张胡牌
            hu_laizi_num = {},
            hu_laizi_num_default = 1
        },
        [QJMJ_CARD_GAME_ID] = {
			name = "泉州麻将",
			dwGameId = XTMJ_CARD_GAME_ID,
			isEnable = false,
			isHaveFree = 0,
			isCardAA = 0,
			-- 排序
			dwOrder = 0,
            
            playerJuInfos = {},
            playerJuInfos_default = 1,

            difen = {},
            difen_default = 1,
            --封顶
            fengding = {},
            fengding_default = 1,
            --飘赖子有奖
            piao_laizi_prize = {},
            piao_laizi_prize_default = 1,
            --赖子几张胡牌
            hu_laizi_num = {},
            hu_laizi_num_default = 1
        },
    }
end

--房卡房间信息
function CreateRoomInfo:getCardRoomInfo(gameId)
	return self._CardGameRoomInfo[gameId]
end

--房卡房间信息
function CreateRoomInfo:getAllCardRoomInfo()
	return self._CardGameRoomInfo
end

function CreateRoomInfo:decodeCardRoomInfo(data)
    self:clear()

    if data == nil then
		print("CreateRoomInfo, decode object nil !!!")
		return
    end
    
    for i,room in ipairs(data.room_config) do
        local gameId = room.kindid
        local roomInfo = self:getCardRoomInfo(gameId)
        -- roomInfo.name = room.name

        local config = json.decode(room.config)
        roomInfo.isEnable = true
        roomInfo.dwOrder = i

--         dump(config, "config", 8)

-- --         "difen"            = "1,2,5,-1"
-- -- [LUA-print] -     "fengding"         = "100,200,-1"
-- -- [LUA-print] -     "hu_laizi_num"     = "1,2"
-- -- [LUA-print] -     "piao_laizi_prize" = "1,2"

        local difen = string.split(config.difen, ",")
        for i,v in ipairs(difen) do
            if v ~= "-1" then
                table.insert(roomInfo.difen, v)
            end
        end
        local fengding = string.split(config.fengding, ",")
        for i,v in ipairs(fengding) do
            if v ~= "-1" then
                table.insert(roomInfo.fengding, v)
            end
        end
        local hu_laizi_num = string.split(config.hu_laizi_num, ",")
        for i,v in ipairs(hu_laizi_num) do
            if v ~= "-1" then
                table.insert(roomInfo.hu_laizi_num, v)
            end
        end
        local piao_laizi_prize = string.split(config.piao_laizi_prize, ",")
        for i,v in ipairs(piao_laizi_prize) do
            if v ~= "-1" then
                table.insert(roomInfo.piao_laizi_prize, v)
            end
        end

        roomInfo.playerJuInfos = config.diamond

        dump(roomInfo, "roomInfo")
    end
end

return CreateRoomInfo