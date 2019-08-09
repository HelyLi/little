local UIPlayersItem = class("UIPlayersItem", function ()
    return display.newNode()
end)

function UIPlayersItem:ctor(parent, viewId, roomType)
    --Info
    self.m_userId = 0
    self.m_chairId = -1
    self.m_viewId = viewId
    self.m_name = ""
    self.m_roomType = roomType
    self.m_score = 0

    self:initBaseInfo()
    self:addTo(parent)
    self:setVisible(false)
end

function UIPlayersItem:initBaseInfo()
    
end

function UIPlayersItem:getViewId()
    return self.m_viewId
end

function UIPlayersItem:getChairId()
    return self.m_chairId
end

function UIPlayersItem:getUserId()
    return self.m_userId
end


return UIPlayersItem