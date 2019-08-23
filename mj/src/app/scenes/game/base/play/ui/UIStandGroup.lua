local UIParent = import("app.scenes.game.base.UIParent")
--[[
    组合牌集合
]]

local UIStandGroup = class("UIStandGroup", function ()
    return UIParent.new()
end)

local STAND_ORDER = {
    EFFECT = 10,
    CARD = 20
}

function UIStandGroup:ctor()
    
end

function UIStandGroup:setViewId(viewId)
    self.m_viewId = viewId
end

function UIStandGroup:getViewId()
    return self.m_viewId
end

function UIStandGroup:updateAll()
    local gamePlayingData = self:getPresenter():getGamePlayingData()
    local standGroupData = gamePlayingData.m_StandGroupData

    --清除旧数据
    self:clear()

    --添加组合牌
    for i,standItemData in ipairs(standGroupData) do
        self:addCard(standItemData, false)
    end
end

function UIStandGroup:clear()
    self.m_standItemsTable = {}
    self:removeAllChildren()
end

function UIStandGroup:addCard(standItemData, bEffect)
    
end

--添加组合牌
function UIStandGroup:addStandItem(pStandItem, bEffect, orderOffset)
    self:addChild(pStandItem, STAND_ORDER.CARD + (orderOffset or 0))
    table.insert(self.m_standItemsTable, pStandItem)

    if bEffect == true then

    end
end

--加杠
function UIStandGroup:standJiaGang(cardData, bEffect)
    for i,standItem in ipairs(self.m_standItemsTable) do

    end
end

return UIStandGroup