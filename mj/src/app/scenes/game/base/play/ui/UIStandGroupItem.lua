--[[
    吃碰杠组合牌
]]
local UIParent = import("app.scenes.game.base.UIParent")
local CardDisplay = import("..CardDisplay")

local CARD_TAG_BASE = 10

local UIStandGroupItem = class("UIStandGroupItem", function ()
    return UIParent.new()
end)

function UIStandGroupItem:ctor(params)
    self.m_blueZZIndx = 0
    self.m_cardDatas = {}

    self.m_viewId = params.viewId
    self.m_standItemIndx = params.standIndx
    self:setStandItemData(params.itemData)
    self:initCard()

    self:align(params.anchor, params.point.x, params.point.y)

    if params.scale then
        self:setScale(params.scale, params.scale)
    end
end

function UIStandGroupItem:setStandItemData(itemData)
    if itemData.opType == GameConstants.OP_TYPE.CHI_LEFT then
        --左吃
        self.m_standType = GameConstants.STAND_CARD_TYPE.SHUIZI
        self.m_curCardNum = 3
        self.m_blueZZIndx = 1
    elseif itemData.opType == GameConstants.OP_TYPE.CHI_CENTER then
        --中吃
        self.m_standType = GameConstants.STAND_CARD_TYPE.SHUIZI
        self.m_curCardNum = 3
        self.m_blueZZIndx = 2
    elseif itemData.opType == GameConstants.OP_TYPE.CHI_RIGHT then
        --中吃
        self.m_standType = GameConstants.STAND_CARD_TYPE.SHUIZI
        self.m_curCardNum = 3
        self.m_blueZZIndx = 3
    elseif itemData.opType == GameConstants.OP_TYPE.PENG then
        --碰
        self.m_standType = GameConstants.STAND_CARD_TYPE.KEZI
        self.m_curCardNum = 3
    elseif itemData.opType == GameConstants.OP_TYPE.GANG_MING then
        --明杠
        self.m_standType = GameConstants.STAND_CARD_TYPE.GANG_MING
        self.m_curCardNum = 4
    elseif itemData.opType == GameConstants.OP_TYPE.GANG_AN then
        --暗杠
        self.m_standType = GameConstants.STAND_CARD_TYPE.GANG_AN
        self.m_curCardNum = 4
    elseif itemData.opType == GameConstants.OP_TYPE.GANG_JIA then
        --加杠
        self.m_standType = GameConstants.STAND_CARD_TYPE.GANG_JIA
        self.m_curCardNum = 4
    end

    for i=1,self.m_curCardNum do
        self.m_cardDatas[i] = itemData.byCardDatas[i]
    end
end

--组合牌类型（顺子，刻子，碰...）
function UIStandGroupItem:getStandType()
    return self.m_standType
end

--基础牌
function UIStandGroupItem:getBaseCardData()
    if self.m_standType >= GameConstants.STAND_CARD_TYPE.GANG_MING then
        return self.m_cardDatas[4]
    else
        return self.m_cardDatas[1]
    end
end

--初始化牌
function UIStandGroupItem:initCard()
    if self.m_viewId == 1 then
        self:initMyStandCard()
    elseif self.m_viewId == 2 then
        self:initRightPlayerStandCard()
    elseif self.m_viewId == 3 then
        self:initOppositePlayerStandCard()
    elseif self.m_viewId == 4 then
        self:initLeftPlayerStandCard()
    end

    if self.m_curCardNum == 4 then
        self:addGandCard()
    end
end

--加杠
function UIStandGroupItem:standJiaGang()
    self.m_standType = GameConstants.STAND_CARD_TYPE.GANG_JIA
    self.m_cardDatas[4] = self.m_cardDatas[1]
    self.m_curCardNum = 4

    self:addGangCard()
end

--是否为杠的组合牌
function UIStandGroupItem:isGangStand()
    if self.m_standType >= GameConstants.STAND_CARD_TYPE.GANG_MING then
        return true
    end
    return false
end

--自己
function UIStandGroupItem:initMyStandCard()
    local cardWidth = 0
    for i=1,3 do
        local cardOrder = 0
        if self.m_standItemIndx <= 3 then
            cardWidth = 52
            cardOrder = i
        else
            cardWidth = 51
            cardOrder = 3 - i
        end

        local pCard = nil
        if self.m_standType == GameConstants.STAND_CARD_TYPE.GANG_AN then
            pCard = CardDisplay.getMyStandCard(self.m_standItemIndx, i, 0)
        else
            pCard = CardDisplay.getMyStandCard(self.m_standItemIndx, i, self.m_cardDatas[i])
        end

        pCard:align(display.BOTTOM_LEFT, (i - 1)*cardWidth, 0):addTo(self, cardOrder, CARD_TAG_BASE + i)
        
        if self.m_blueZZIndx == i then
            --蓝色遮罩

        end

        --橙色遮罩

    end
end

--加杠
function UIStandGroupItem:addGangCard()
    if self.m_viewId == 1 then
        self:addMyGangCard()
    elseif self.m_viewId == 2 then
        self:addRightPlayerGangCard()
    elseif self.m_viewId == 3 then
        self:addOppositePlayerGangCard()
    elseif self.m_viewId == 4 then
        self:addLeftPlayerGangCard()
    end
end

--橙色遮罩


--特定牌亮橙色
function UIStandGroupItem:displaySameCardLight(cardData, visible)
    for i=1,self.m_curCardNum do
        local pCard = self:getChildByTag(CARD_TAG_BASE + i)
        if pCard then
            local pCardZZ = pCard:getChildByTag(GameConstants.CARD_TAG.ZZ_ORANGE)
            if pCardZZ then
                if visible == true and cardData == self.m_cardDatas[i] then
                    pCardZZ:setVisible(true)
                else
                    pCardZZ:setVisible(false)
                end
            end
        end
    end
end

--组合牌中间位置
function UIStandGroupItem:getMidPoint()
    if self.m_viewId == 1 then
        return cc.p(self:getPositionX() + W2(self), self:getPositionY() + H2(self))
    elseif self.m_viewId == 2 then
        return cc.p(self:getPositionX() + self:getScale()*W2(self), self:getPositionY() + self:getScale()*H2(self))
    elseif self.m_viewId == 3 then
        return cc.p(self:getPositionX() - W2(self), self:getPositionY() + H2(self))
    elseif self.m_viewId == 4 then
        return cc.p(self:getPositionX() - self:getScale()*W2(self), self:getPositionY() + self:getScale()*H2(self))
    end
end

return UIStandGroupItem