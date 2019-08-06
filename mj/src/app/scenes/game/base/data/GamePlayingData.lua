AllCardDatas = {
    0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,       --1-9万
    0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,       --1-9万
    0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,       --1-9万
    0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,       --1-9万
    
    0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,       --1-9条
    0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,       --1-9条
    0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,       --1-9条
    0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,       --1-9条
    
    0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,       --1-9筒
    0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,       --1-9筒
    0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,       --1-9筒
    0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,       --1-9筒
    
    0x31,0x32,0x33,0x34,0x35,0x36,0x37,                 --东南西北中发白
    0x31,0x32,0x33,0x34,0x35,0x36,0x37,                 --东南西北中发白
    0x31,0x32,0x33,0x34,0x35,0x36,0x37,                 --东南西北中发白
    0x31,0x32,0x33,0x34,0x35,0x36,0x37,                 --东南西北中发白
    
    0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,            --春夏秋冬梅兰竹菊
}

--出的牌数据
ClsOutCardData = {
    cardData = 0,       --牌数据
    opCode = 0,         --操作标识
}

--组合牌数据
ClsStandCardData = {
    opType = 0,         --组合牌操作类型
    byCardDatas = {0, 0, 0, 0},--组合扑克
    byProvideViewId = 0,
}

--胡的牌数据
ClsHuCardData = {
    cardData = 0,       --胡的牌
    remainNum = 0,      --剩余几张
}

--听胡牌数据
ClsTingHuCardData = {
    isHuYJ = false,     --是否胡游金
    outCardData = 0,    --要打出的牌    
    huCardDatas = {}    --可胡的牌
}

local GamePlayingData = class("GamePlayingData")

function GamePlayingData:ctor()
    
end

function GamePlayingData:setPresenter(presenter)
    self.m_presenter = presenter
end

function GamePlayingData:getPresenter()
    return self.m_presenter
end

function GamePlayingData:clearBase()
    --各种状态
    self.m_playerCardDisplayMode = {0,0,0,0}                --玩家手牌显示模式
    self.m_playerHaveMoCard = {false, false, false, false}  --玩家是否有摸牌
    self.m_isCurOutCardStatus = 0                           --当签玩家可出牌状态
    self.m_isPlayerOpStart = false                          --是否有玩家操作过
    self.m_curOpStandData = {}                              --当前剩余操作时间

    --用户标识
    self.m_curViewId = 0                                    --当前动作玩家
    self.m_provideViewId = 0                                --供应玩家
    self.m_isDeskOutCardOp = false                          --桌上牌是否被操作

    --
    self.m_dicePoint = {0, 0}                               --骰子点数
    --
    self.m_userScore = {0, 0, 0, 0}                         --玩家积分

    --麻将牌信息
    self.m_byMaxCardCount = 118                             --所有麻将牌数量
    self.m_byLeftCardCount = 0                              --牌堆剩余麻将数
    self.m_byHandCardData = {{}, {}, {}, {}}                --玩家手牌数据
    self.m_byProvideCardData = 0                            --供应牌
    self.m_byGoldCardData = 0                               --金牌
    self.m_byGoldActionCardData = {}                        --
    self.m_byUnKnowCardData = clone(AllCardDatas)           --剩余未知麻将牌数据
    self.m_byDeskOutCardData = {{}, {}, {}, {}}             --玩家出牌记录

    self.m_StandGroupData = {{}, {}, {}, {}}                --组合牌
    self.m_BuHuaCardData = {{}, {}, {}, {}}                 --补花牌数据

    self.m_myCanOutCardData = {}
    self.m_myCanOpInfoTable = {}
    self.m_myChiCardData = {}
    self.m_myGangCardData = {}
    self.m_myCanHuType = 0
    
    --
    self.m_myTingHuData = {}
    self.m_myTingCardData = {}

    self.m_HuPaiViewId = 0
    self.m_FangPaoViewId = 0

    --结算信息
    self.m_GameSingleResult = {}
    self.m_GameTotalResult = {}

    self.m_isLastTurn = false
end

function GamePlayingData:getRoomData()
    return self:getPresenter():getRoomData()
end

function GamePlayingData:getMyViewId()
    return self:getRoomData():getMyViewId()
end

function GamePlayingData:getMyChairId()
    return self:getRoomData():getMyChairId()
end

function GamePlayingData:getViewIdByChairId(chairId)
    return self:getRoomData():getViewIdByChairId(chairId)
end

function GamePlayingData:getPlayersNum()
    return self:getRoomData():getPlayersNum()
end

--table赋值
function GamePlayingData:cloneTables(tableDest, tableSrc, num)
    for i=1,num do
        if tableSrc[i] then
            tableDest[i] = clone(tableSrc[i])
        end
    end
end

--初始化手牌数据
function GamePlayingData:initHandCardDatas(viewId, cardDatas, cardNum)
    self.m_byHandCardData[viewId] = {}
    for i=1,cardNum do
        if cardDatas[i] then
            self.m_byHandCardData[viewId][i] = cardDatas[i]
        end
    end
end

--设置手牌数据为0
function GamePlayingData:initHandCardDatas0(viewId, cardNum)
    self.m_byHandCardData[viewId] = {}
    for i=1,cardNum do
        self.m_byHandCardData[viewId][i] = 0
    end
end

--手牌数据排序
function GamePlayingData:sortPlayerHandCardDatas(viewId)
    if self.m_playerCardDisplayMode[viewid] == GameConstants.HANDCARD_MODE.DISPLAY then
        table.sort(self.m_byHandCardData[viewId], function(card1, card2)
            return self:handCardCompare(card1, card2)            
        end)
    end
end

--无数据的牌删掉，返回有数据的牌张数
function GamePlayingData:sortCardList(byCardDatas)
    for i=#byCardDatas,1,-1 do
        if byCardDatas[i] <= 0 then
            table.remove(byCardDatas, i)
        end
    end

    return #byCardDatas
end

function GamePlayingData:anddHandCardData(viewId, cardData)
    local curHandCardNum = #self.m_byHandCardData[viewId]
    if curHandCardNum >= GameConstants.CARD_NUM.MAX_HAND then
        return
    end

    if viewId == self:getMyViewId() then
        --自己手牌
        if cardData > 0 then
            self.m_byHandCardData[viewId][curHandCardNum + 1] = cardData
        else
            --其他玩家
            if GameConstants.HANDCARD_MODE.DISPLAY == self.m_playerCardDisplayMode[viewId] then
                --对方明牌
                if cardData > 0 then
                    self.m_byHandCardData[viewId][curHandCardNum + 1] = cardData
                end
            else
                --暗牌模式
                self.m_byHandCardData[viewId][curHandCardNum+1] = cardData
            end
        end
    end
end

--删除一张手牌
function GamePlayingData:deleteHandCardByData(viewId, cardData)
    if viewId == self:getMyViewId() then
        --自己手牌
        for i,v in ipairs(self.m_byHandCardData[viewId]) do
            if v == cardData then
                table.remove(self.m_byHandCardData[viewId], i)
                break
            end
        end
    else
        --对方手牌
        if GameConstants.HANDCARD_MODE.DISPLAY == self.m_playerCardDisplayMode[viewId] then
            --对方明牌
            for i,v in ipairs(self.m_byHandCardData[viewId]) do
                if v == cardData then
                    table.remove(self.m_byHandCardData[viewId], i)
                    break
                end
            end
        else
            --暗牌模式
            if #self.m_byHandCardData[viewId] > 0 then
            	table.remove(self.m_byHandCardData[viewId], #self.m_byHandCardData[viewId])
            end
        end
    end
end

function GamePlayingData:deleteHandCardByOpResult(viewId, standItemData)
    if standItemData.opType == GameConstants.OP_TYPE.CHI_LEFT then
        --左吃
        self:deleteHandCardByData(viewId, standItemData.byCardData[2])
        self:deleteHandCardByData(viewId, standItemData.byCardData[3])
    elseif standItemData.opType == GameConstants.OP_TYPE.CHI_CENTER then
        --中吃
        self:deleteHandCardByData(viewId, standItemData.byCardData[1])
        self:deleteHandCardByData(viewId, standItemData.byCardData[3])
    elseif standItemData.opType == GameConstants.OP_TYPE.CHI_RIGHT then
        --右吃
        self:deleteHandCardByData(viewId, standItemData.byCardData[1])
        self:deleteHandCardByData(viewId, standItemData.byCardData[2])
    elseif standItemData.opType == GameConstants.OP_TYPE.PENG then
        --碰
        self:deleteHandCardByData(viewId, standItemData.byCardData[1])
        self:deleteHandCardByData(viewId, standItemData.byCardData[2])
    elseif standItemData.opType == GameConstants.OP_TYPE.GANG_MING then
        --明杠
        self:deleteHandCardByData(viewId, standItemData.byCardData[1])
        self:deleteHandCardByData(viewId, standItemData.byCardData[2])
        self:deleteHandCardByData(viewId, standItemData.byCardData[3])
    elseif standItemData.opType == GameConstants.OP_TYPE.GANG_AN then
        --明杠
        self:deleteHandCardByData(viewId, standItemData.byCardData[1])
        self:deleteHandCardByData(viewId, standItemData.byCardData[2])
        self:deleteHandCardByData(viewId, standItemData.byCardData[3])
        self:deleteHandCardByData(viewId, standItemData.byCardData[4])
    elseif standItemData.opType == GameConstants.OP_TYPE.GANG_JIA then
        --加杠
        self:deleteHandCardByData(viewId, standItemData.byCardDatas[1])
    end
end

--添加组合牌到玩家
function GamePlayingData:addStandItemToViewId(viewId, standItemData)
    if standItemData.opType == GameConstants.OP_TYPE.GANG_JIA then
        --加杠
        local cardData = standItemData.byCardDatas[1]
        for i,v in ipairs(self.m_StandGroupData[viewId]) do
            if (v.opType == GameConstants.OP_TYPE.PENG and v.byCardDatas[1] == cardData) then
                v.opType = GameConstants.OP_TYPE.GANG_JIA
                v.byCardDatas[4] = cardData
            end
        end
    elseif standItemData.opType >= GameConstants.OP_TYPE.CHI_LEFT and standItemData.opType <= GameConstants.OP_TYPE.GANG_AN then
        local standNum = #self.m_StandGroupData[viewId]
        if standNum < GameConstants.CARD_NUM.MAX_STAND then
            standNum = standNum + 1
            self.m_StandGroupData[viewId][standNum] = clone(standItemData)
        end
    end
end

function GamePlayingData:addDeskOutCardToViewId(viewId, cardData)
    local cardNum = #self.m_byDeskOutCardData[viewId] + 1
    self.m_byDeskOutCardData[viewId][cardNum] = cardData
end

--桌面打出的牌被操作
function GamePlayingData:setDeskOutCardBeOp(viewId, standItemData)
    local findCardData = 0
    if standItemData.opType == GameConstants.OP_TYPE.CHI_LEFT then
        --左吃
        findCardData = standItemData.byCardDatas[1]
    elseif standItemData.opType == GameConstants.OP_TYPE.CHI_CENTER then
        --中吃
        findCardData = standItemData.byCardDatas[2]
    elseif standItemData.opType == GameConstants.OP_TYPE.CHI_RIGHT then
        --右吃
        findCardData = standItemData.byCardDatas[3]
    elseif standItemData.opType == GameConstants.OP_TYPE.PENG then
        findCardData = standItemData.byCardDatas[1]
    elseif standItemData.opType == GameConstants.OP_TYPE.GANG_MING then
        findCardData = standItemData.byCardDatas[1]
    elseif standItemData.opType == GameConstants.OP_TYPE.CHI_HU then
        --被吃胡
        findCardData = standItemData.byCardDatas[1]
    end

    if findCardData > 0 then
        --桌上牌被操作状态
        self.m_isDeskOutCardOp = true
        --检测最后一张出的牌
        local lastOutCardIndx = #self.m_byDeskOutCardData[viewId]
        if (lastOutCardIndx > 0) and self.m_byDeskOutCardData[viewId][lastOutCardIndx] == findCardData then
            self.m_byDeskOutCardData[viewId][lastOutCardIndx] = nil
        end
    end
end


function GamePlayingData:deleteUnknowCardData(cardData)
    if cardData > 0 then
        for i,v in ipairs(self.m_byUnKnowCardData) do
            if v == cardData then
                table.remove(self.m_byUnKnowCardData, i)
                break
            end
        end
    end
end

function GamePlayingData:deleteUnknowCardInStandItem(standItemData)
    local deleteCardData = {}
    if standItemData.opType == GameConstants.OP_TYPE.CHI_LEFT then
        table.insert(deleteCardData, standItemData.byCardDatas[2])
        table.insert(deleteCardData, standItemData.byCardDatas[3])
    elseif standItemData.opType == GameConstants.OP_TYPE.CHI_CENTER then
        table.insert(deleteCardData, standItemData.byCardDatas[1])
        table.insert(deleteCardData, standItemData.byCardDatas[3])
    elseif standItemData.opType == GameConstants.OP_TYPE.CHI_RIGHT then
        table.insert(deleteCardData, standItemData.byCardDatas[1])
        table.insert(deleteCardData, standItemData.byCardDatas[2])
    elseif standItemData.opType == GameConstants.OP_TYPE.PENG then
        table.insert(deleteCardData, standItemData.byCardDatas[1])
        table.insert(deleteCardData, standItemData.byCardDatas[2])
    elseif standItemData.opType == GameConstants.OP_TYPE.GANG_MING then
        table.insert(deleteCardData, standItemData.byCardDatas[1])
        table.insert(deleteCardData, standItemData.byCardDatas[2])
        table.insert(deleteCardData, standItemData.byCardDatas[3])
    elseif standItemData.opType == GameConstants.OP_TYPE.GANG_AN then
        table.insert(deleteCardData, standItemData.byCardDatas[1])
        table.insert(deleteCardData, standItemData.byCardDatas[2])
        table.insert(deleteCardData, standItemData.byCardDatas[3])
        table.insert(deleteCardData, standItemData.byCardDatas[4])
    elseif standItemData.opType == GameConstants.OP_TYPE.GANG_JIA then
        table.insert(deleteCardData, standItemData.byCardDatas[1])
    end

    if #deleteCardData > 0 then
        for i,v in ipairs(deleteCardData) do
            self:deleteUnknowCardData(v)
        end
    end
end

function GamePlayingData:replayDeleteUnKnowCardInStandItem(standItemData)
    local deleteCardData = {}
    if standItemData then
        --todo
    end
end

return GamePlayingData