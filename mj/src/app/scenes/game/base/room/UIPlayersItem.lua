local BaseNode = import("app.views.BaseNode")
local PLAYER_SIZE_WIDTH = 70
local PLAYER_SIZE_HEIGHT = 112

local TAG = {
    Head = 1,
    Name = 2,
    Score = 3
}

local UIPlayersItem = class("UIPlayersItem", function()
    return BaseNode.new()
end)

function UIPlayersItem:ctor(parent, viewId, roomType)
    --Info
    self.m_userId = 0
    self.m_chairId = -1
    self.m_viewId = viewId
    self.m_name = ""
    self.m_roomType = roomType
    self.m_score = 0
    self.m_gender = comui.MALE

    self:initBaseInfo()
    self:addTo(parent)
    self:setVisible(false)
    self:setTouchEnabled(true)
end

function UIPlayersItem:setClickCallback(callback)
    if callback then
        self:addOnClick(callback)
    end
end

function UIPlayersItem:initBaseInfo()
    local bgSize = cc.size(PLAYER_SIZE_WIDTH, PLAYER_SIZE_HEIGHT)
    self:setContentSize(bgSize)

    display.newTTFLabel({
        text = "",
        size = 20,
        color = cc.c3b(107, 194, 146),
        align = cc.TEXT_ALIGNMENT_CENTER
    }):align(display.CENTER, W2(self), 28):addTo(self, 0, TAG.Name)

    local scoreBg = display.newSprite(""):align(display.CENTER_BOTTOM, W2(self), 0):addTo(self)
    if self.m_roomType == GameConstants.ROOM_TYPE.GOLD then
        display.newSprite("#com_gold_icon.png"):align(display.CENTER_LEFT, 0, H2(scoreBg)):addTo(scoreBg)
    end
    display.newTTFLabel({
        text = "0",
        size = 20,
        color = cc.c3b(254, 227, 76),
        align = cc.TEXT_ALIGNMENT_CENTER
    }):align(display.CENTER, W2(self), H2(scoreBg)):addTo(self, 0, TAG.Score)
end

function UIPlayersItem:setViewId(viewId)
    self.m_viewId = viewId
end

function UIPlayersItem:getViewId()
    return self.m_viewId
end

function UIPlayersItem:setChairId(chairId)
    self.m_chairId = chairId
end

function UIPlayersItem:getChairId()
    return self.m_chairId
end

function UIPlayersItem:setUserId(userId)
    self.m_userId = userId
end

function UIPlayersItem:getUserId()
    return self.m_userId
end

function UIPlayersItem:setUserName(name)
    self.m_name = name
end

function UIPlayersItem:getUserName()
    return self.m_name or ""
end

function UIPlayersItem:setUserScore(score)
    self.m_score = score 
end

function UIPlayersItem:getUserScore()
    return self.m_score 
end

function UIPlayersItem:playerEnter(playerInfo)
    self:setUserId(playerInfo.userId)
    self:setChairId(playerInfo.chairId)
    self:setUserName(playerInfo.name)
    self:setUserScore(playerInfo.score)
    self:setViewId(playerInfo.viewId)
    self.m_gender = playerInfo.gender
    self.m_deskStatus = playerInfo.status

    self:updatePlayerInfo()
    self:setVisible(true)
end

function UIPlayersItem:updatePlayerInfo()
    local name = self:getChildByTag(TAG.Head)
    if name then
        name:setString(self:getUserName())
    end
    local score = self:getChildByTag(TAG.Score)
    if score then
        local num = self.m_score
        local str = ""
        if num < 10000 then
            str = string.format("%d", num)
        elseif num < 10000000 then
            str = string.format("%02f万", num/10000)
        end
        score:setString(str)
    end
end

--显示头像
function UIPlayersItem:addUserHead()
    self:removeChildByTag(TAG.Head)

    local headNode = comui.displayHead({
        size = cc.size(PLAYER_SIZE_WIDTH, PLAYER_SIZE_WIDTH),
        gender = self.m_gender,

    })

end

return UIPlayersItem