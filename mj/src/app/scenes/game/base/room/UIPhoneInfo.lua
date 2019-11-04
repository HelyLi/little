local UIParent = import("app.scenes.game.base.UIParent")

local UIPhoneInfo = class("UIPhoneInfo", function ()
    return UIParent.new()
end)

local Left_X = {
    card = 20,
    gold = 110
}

function UIPhoneInfo:ctor(container, order, tag, roomType)
    self.m_container = container
    self.m_roomType = roomType
    -- self:initView()
    self:addTo(container, order, tag)
end

function UIPhoneInfo:onEnter()
    self:schedule(handler(self, self.refreshView), 10)
end

function UIPhoneInfo:onExit()
    self:stopAllActions()
end

function UIPhoneInfo:initView()
    --背景
    local pBG = display.newNode()--display.newScale9Sprite("#".."mj_user_head_bg.png", 0,0, cc.size(200,45), cc.rect(12,12,20,20))
    pBG:setContentSize(cc.size(200, 45))
    pBG:align(display.LEFT_CENTER, Left_X[self.m_roomType] +UIAdapter.paddingL , display.height - 34.5):addTo(self)
    --时间
    self._pTimeNum = cc.LabelAtlas:_create(os.date("%H/%M"), "ImgFont/mj_game_room_num.png", 17, 26, string.byte("/"))
    self._pTimeNum:align(display.CENTER_LEFT, 9, H2(pBG)):addTo(pBG)
    
    --信号
    self._pNetImg = display.newSprite("#mj_desk_info_sim.png")
    self._pNetImg:align(display.CENTER_LEFT, 102, H2(pBG)):addTo(pBG)
    
    --电量
    local batteryLevel = System.getBatteryValue()
    local pBatteryBox = display.newSprite("#mj_desk_info_batt.png")
    pBatteryBox:align(display.CENTER_LEFT, 151, H2(pBG)):addTo(pBG)
    
    self._pBatteryContent = display.newSprite("#mj_desk_info_batt1.png")
    self._pBatteryContent:align(display.BOTTOM_LEFT, 7, 9.7):addTo(pBatteryBox)
end

--手机信息
function UIPhoneInfo:refreshView()
    --时间
    if self._pTimeNum ~= nil then
        self._pTimeNum:setString(os.date("%H/%M"))
    end
    
    --信号
    if self._pNetImg ~= nil then
        local netType,netLevel = System.getNetInfo()
        if netType > 0 then
            local strNetFile = ""
            if netType == 1 then
                --wifi
                if netLevel >= 2 then
                    strNetFile = "mj_desk_info_wifi.png"
                else
                    strNetFile = "mj_desk_info_wifi_0.png"
                end
            else
                --手机信号
                if netLevel >= 2 then
                    strNetFile = "mj_desk_info_sim.png"
                else
                    strNetFile = "mj_desk_info_sim_0.png"
                end
            end
            self._pNetImg:setSpriteFrame(strNetFile)
        end
    end
    
    --电量
    if self._pBatteryContent ~= nil then
        self._pBatteryContent:setScale(System.getBatteryValue()/100, 1)
    end
end

return UIPhoneInfo

