--弹框
local BaseView = import(".BaseView")

local SubLayer = class("SubLayer", function() return BaseView.new() end)

-- SubLayer.TYPE_COMMON = 1    --包含关闭按钮
-- SubLayer.TYPE_MINI = 2      --不包含关闭按钮

local ORDER = {
    bg = 0,
    bg2 = 1,
    menu_bg = 2,
    close_btn = 3
}

local TAG = {
    bg = 100,
    bg2 = 101,
    menu_bg = 102,
    title = 103
}

function SubLayer:ctor()
    print("SubLayer.ctor")
end

function SubLayer:initSub(params)
    self.m_size = params.size or cc.size(696, 386)
    self.m_black = params.black or true
    self.m_close = params.close or true
    self:initSubView()
end

function SubLayer:initSubView()
    if self.m_black then
        --背景颜色 60%
        display.newColorLayer(cc.c4b(0, 0, 0, 153)):addTo(self):setContentSize(display.width, display.height)
    end
    self.v_bg = display.newScale9Sprite("#com_dialog_bg.png", 0, 0, self.m_size, cc.rect(64, 30, 30, 60)):align(
        display.CENTER_BOTTOM,
        display.cx,
        (display.height - self.m_size.height - 68)/2
    ):addTo(self, ORDER.bg, TAG.bg)
    if self.m_close then
        comui.Button({
            normal = "com_close_btn.png",
            pos = cc.p(self.m_size.width - 12, self.m_size.height - 12),
            callfunc = handler(self, self.dismiss),
            order = ORDER.close_btn,
            parent = self.v_bg
        })
    end
end

function SubLayer:getBg()
    return self.v_bg
end

function SubLayer:addBg2()
    local bg2 = self.v_bg:getChildByTag(TAG.bg2)
    if bg2 == nil then
        local bg2_size = cc.size(self.m_size.width - 26, self.m_size.height - 24)
        bg2 = display.newScale9Sprite("#com_dialog_bg_1.png", 0, 0, bg2_size, cc.rect(30,25,60,50))
        bg2:align(display.CENTER_BOTTOM, W2(self.v_bg), 12):addTo(self.v_bg, 0, TAG.bg2)
    end
    return bg2
end

function SubLayer:addMenuBg()
    local bg2 = self.v_bg:getChildByTag(TAG.bg2)
    if bg2 then
        local menu_bg = bg2:getChildByTag(TAG.menu_bg)
        if menu_bg == nil then
            menu_bg = display.newScale9Sprite("#com_dialog_bg_2.png", 0, 0, cc.size(W(bg2) -4, 122), cc.rect(18,0,80,30))
            menu_bg:align(display.CENTER_BOTTOM, W2(bg2), 12):addTo(bg2)
        end
        return menu_bg
    end
end

function SubLayer:addTitle(filename)
    self.v_bg:removeChildByTag(TAG.title)
    local titleBg = display.newSprite("#com_dialog_title_bg.png"):align(display.CENTER_BOTTOM,W2(self.v_bg),H(self.v_bg)-3):addTo(self.v_bg,0,TAG.title)
    display.newSprite("#"..filename):align(display.CENTER,W2(titleBg),31):addTo(titleBg)
end

function SubLayer:onEnter()
    print("SubLayer.onEnter")
end

function SubLayer:onExit()
    print("SubLayer.onExit")
end

return SubLayer
