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
            isFree = 0,
            areaId = 0,--地区
			-- 排序
            order = 0,
            difen = {},
            fengding = {},
            hu_laizi_num = {},
            jushu = {},
            piao_laizi_prize = {},

            playerJuInfos = {},
            playernum = {},
			playernum_default = 0
        },
        [QJMJ_CARD_GAME_ID] = {
			name = "泉州麻将",
			dwGameId = QJMJ_CARD_GAME_ID,
			isEnable = false,
			isFree = 0,
			-- 排序
            order = 0,
            difen = {},
            fengding = {},
            hu_laizi_num = {},
            jushu = {},
            piao_laizi_prize = {},

            playerJuInfos = {},
            playernum = {},
			playernum_default = 0
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
        roomInfo.name = room.name
        roomInfo.isFree = room.free
        roomInfo.areaId = room.areaid

        local config = json.decode(room.config)
        roomInfo.isEnable = true
        roomInfo.order = i

        local default_rule = config.default_rule
        roomInfo.difen_default = default_rule.difen
        roomInfo.fengding_default = default_rule.fengding
        roomInfo.hu_laizi_num_default = default_rule.hu_laizi_num
        roomInfo.jushu_default = default_rule.jushu
        roomInfo.payment_default = default_rule.payment
        roomInfo.piao_laizi_prize_default = default_rule.piao_laizi_prize
        roomInfo.playernum_default = default_rule.playernum

        for k,v in pairs(config.difen) do
            roomInfo.difen[tonumber(k)] = v
        end
        for k,v in pairs(config.fengding) do
            roomInfo.fengding[tonumber(k)] = v
        end
        for k,v in pairs(config.hu_laizi_num) do
            roomInfo.hu_laizi_num[tonumber(k)] = v
        end
        for k,v in pairs(config.jushu) do
            roomInfo.jushu[tonumber(k)] = v
        end
        for k,v in pairs(config.piao_laizi_prize) do
            roomInfo.piao_laizi_prize[tonumber(k)] = v
        end

        for i,v in ipairs(config.diamond) do
            local people = v.playernum
            roomInfo.playerJuInfos[people] = {}

            for k,v in pairs(v.ju_diamond) do
                local t = {}
                table.insert(t, tonumber(k))
                table.insert(t, tonumber(v))
                table.insert(roomInfo.playerJuInfos[people], t)
            end

            table.insert(roomInfo.playernum, i, people)
        end

        dump(roomInfo, "roomInfo")
    end
end

function CreateRoomInfo:encodeLastConfig(gameId)
    
end

return CreateRoomInfo