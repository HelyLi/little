local BaseView = import("app.views.BaseView")
local UserInfoLayer = class("UserInfoLayer", function()
    return BaseView.new()
end)

local TAG = {
    HEAD = 0x01,
    CARD = 0x02,
    GOLD = 0x03,
    CARD_L = 0x04,
    GOLD_L = 0x05,
    NICK_LABEL = 0x06,
    ID_LABEL = 0x07
}

function UserInfoLayer:ctor()
    self.m_baseX = UIAdapter.padding
    self:init()
end

function UserInfoLayer:init()
    self:regMsgHandler()
    self:initView()
end

function UserInfoLayer:regMsgHandler()
    
end

function UserInfoLayer:initView()
    --头像
    comui.displayHead({
        userId = Game:getUserData():getUserId(),
        size = cc.size(84, 84),
        gender = comui.MALE,
        showSex = false
    }):align(display.CENTER, self.m_baseX + 55,display.top - 55):addTo(self, 0, TAG.HEAD)

    --房卡
    local cardL = display.newBMFontLabel({
        text = string.format("%d", Game:getUserData():getDiamond() or 100),
        font = "BMFonts/lob_room_card_num.fnt"
    })
    local cardBg = comui.Button({
        normal = "lob_room_icon_bg_skin.png",
        size = cc.size(100 + W(cardL), 42),
        capInsets = cc.rect(40, 15, 19, 12),
        tag = TAG.CARD,
        anchor = display.CENTER_LEFT,
        pos = cc.p(112 + self.m_baseX, display.top - 70),
        callfunc = handler(self, self.menuCallback),
        parent = self
    })
    display.newSprite("#lob_room_card_icon_skin.png"):align(display.CENTER, 26, H2(cardBg) - 2):addTo(cardBg)
    cardL:align(display.CENTER_LEFT, 70 , H2(cardBg)):addTo(cardBg)

    --金币
    local goldL = display.newBMFontLabel({
        text = string.format("%d", Game:getUserData():getGold() or 100),
        font = "BMFonts/lob_room_card_num.fnt"
    })
    local goldBg = comui.Button({
        normal = "lob_room_icon_bg_skin.png",
        size = cc.size(100 + W(goldL), 42),
        capInsets = cc.rect(40, 15, 19, 12),
        tag = TAG.GOLD,
        anchor = display.CENTER_LEFT,
        pos = cc.p(X(cardBg) + W(cardBg) + 20, display.top - 70),
        callfunc = handler(self, self.menuCallback),
        parent = self
    })
    display.newSprite("#lob_room_gold_icon_skin.png"):align(display.CENTER, 26, H2(goldBg) - 2):addTo(goldBg)
    goldL:align(display.CENTER_LEFT, 70 , H2(goldBg)):addTo(goldBg)

    self:initUserInfo()
end

function UserInfoLayer:initUserInfo()
    local nick = Game:getUserData():getNickname()

    --昵称
    local nickLabel = self:getChildByTag(TAG.NICK_LABEL)
    if nickLabel == nil then
        nickLabel = display.newTTFLabel({
            text = nick,
            size = 28,
            color = cc.c3b(254, 248, 201),
            align = cc.TEXT_ALIGNMENT_LEFT,
        }):align(display.CENTER_LEFT,self.m_baseX + 112,display.top - 30):addTo(self,0,TAG.NICK_LABEL)

        if nickLabel:getContentSize().width > 148 then
            nickLabel:setDimensions(148, nickLabel:getContentSize().height)
        end
    else
        nickLabel:setPositionX(self.m_baseX + 112)
        nickLabel:setString(nick)
    end

    --ID
    local idString = string.format("ID:%d",Game:getUserData():getUserId())
    local idLabel = self:getChildByTag(TAG.ID_LABEL)
    if idLabel == nil then
        display.newTTFLabel({
            text = idString,
            size = 28,
            color = cc.c3b(254, 248, 201),
            align = cc.TEXT_ALIGNMENT_LEFT,
        }):align(display.CENTER_LEFT, X(nickLabel) + 5 + W(nickLabel),display.top - 30):addTo(self,0,TAG.ID_LABEL)
    else
        idLabel:setString(idString)
        idLabel:setPositionX(X(nickLabel) + 5 + W(nickLabel))
    end

end

function UserInfoLayer:menuCallback(tag)
    print("tag:", tag)
end

return UserInfoLayer