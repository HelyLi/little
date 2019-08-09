--[[--
桌上打出去的牌, 从该viewId的视角看，横的为一行, 竖的为一列
]]

local UIDeskOutCard = class("UIDeskOutCard", function ()
    return display.newSprite()
end)

--[[
paramas.container = nil,
paramas.viewId = 1,
paramas.maxPlayers = 4,
paramas.line = 1,           --从viewId的视角看，横的为一行
paramas.arange = 1,        --从viewId的视角看，竖的为一列
paramas.cardData = 0x11,
paramas.point = cc.p(0,0),
paramas.scale = 1,
]]
function UIDeskOutCard:ctor(paramas)
    self.m_presenter = paramas.presenter
    self.m_viewId = paramas.viewId
    self:setCardData(paramas.cardData)

    if paramas.maxPlayers == 2 then
        self:initForTwo()
    else
        self:initForFour()
    end

    self:addGoldCardFlag()
    self:setFinalPoint(paramas.point)
    self:setFinalScale(paramas.scale or 1)
end

function UIDeskOutCard:getPresenter()
    return self.m_presenter
end

function UIDeskOutCard:setCardData(cardData)
    
end

-- row 行
-- column 列
function GamePlayingData:initForFour(viewId, row, column, cardData)
    row = row - 1
    column = column - 1
    
end

return UIDeskOutCard