--[[
    活动中心
]]

local WIDTH = 1276
local HEIGHT = 656

local RIGHT_CONTENT_WIDTH = 1006
local RIGHT_CONTENT_HIGHT = 614

local Order = {
    ZZLayer = 0,
    BG = 10,
    WebContent = 20,
    Menu = 30,
    Dialog = 100,
}

local Tag = {
    MenuListButton = 10,
    Local = 100,
    WebView = 101,
    Dialog = 102,
    MenuClose = 103
}
local ActivityContentFactory = import(".ActivityContentFactory")
local ActivityMenuList = import(".ActivityMenuList")

-- local ComSubLayer = require("app.scenes.comViews.ComSubLayer")
local ActivityCenterLayer = class("ActivityCenterLayer", function (  )
	return BaseView.new()--ComSubLayer.new(cc.size(WIDTH, HEIGHT),ComSubLayer.Type_Common, true)
end)

function ActivityCenterLayer:ctor()
    
    self:initView()
end

function ActivityCenterLayer:onExit()
    MyGame:getEventDispatch():dispatchEvent(gEventMsg.UPDATE_ACTIVITY)
    BaseView.onExit(self)
    if comui.isWaiting() then
        comui.removeWaitingLayer()
    end
end

function ActivityCenterLayer:initView()
    BaseView.init(self)
    -- self:setTitleSpriteName("com_activity_title.png")
    display.newColorLayer(cc.c4b(0, 0, 0, 150)):addTo(self, Order.zz, Tag.zz):setContentSize(display.width, display.height)
    self._bg = display.newSprite("#lob_activity_bg_skin.png"):align(display.CENTER, display.cx, display.cy):addTo(self)

    self._webView = nil
    -- 本地活动工厂
    self._activityFactory = ActivityContentFactory.new({container = self}):addTo(self)
    self._getActivityListRsp = MyGame:getUserData():getAcitvityListData() or {}
    dump(MyGame:getUserData():getAcitvityListData(), "ActivityDataCache", 5)

    self:initMenuList()
    self:initWebView()
    self:initLocalView()

    -- 消除红点
    if MyGame:getUserData():getInitSession() then
        MyGame:getUserData():getInitSession().activity = 0
    end
    
    --更新活动列表
    if self._getActivityListRsp.list and #self._getActivityListRsp.list > 0 then
        self:updateMenuList()
    else
        if not self._hide then
            comui.addWaitingLayer()
        end
    end

    -- 更新活动列表
    MyGame:getUserData():getLobbySocket():sendActivityListReq(self,function(target,data)
        comui.removeWaitingLayer()
        self:onGetActivityListRsp(data)
    end)

    --
    comui.createMenu({
        normal = "com_close_btn_skin.png",
        position = cc.p(W(self._bg) - 50, H(self._bg) - 56),
        anchor = display.CENTER,
        tag = Tag.MenuClose,
        parent = self._bg,
        callback = function(tag)
            self:dismiss()
        end
    })
end

function ActivityCenterLayer:onGetActivityListRsp(data)
    dump(data, "onGetActivityListRsp", 8)
    if data and data.list and AppConfig:isProjectIdDiamond() then
        for i=#data.list,1,-1 do
            if data.list[i].id == 3 or data.list[i].id == 11 then
                table.remove(data.list, i)
            end
        end
    end
    MyGame:getUserData():setActivityListData(clone(data))
    if data.succ == 0 then
        local sameData = self:checkActivityData(data)
        printInfo("sameData=%s", tostring(sameData))
        if not sameData then
            self._getActivityListRsp = clone(data)
            self:updateMenuList()
        end
    else
        comui.addToastLayer(data.emsg)
    end
    self._getActivityListRsp = clone(data)
end

function ActivityCenterLayer:checkActivityData( newData )
    if self._getActivityListRsp then
        if self._getActivityListRsp.succ ~= newData.succ then
            return false
        end
        if self._getActivityListRsp.list and newData.list then
            if #self._getActivityListRsp.list == #newData.list then
                local listSize = #newData.list
                for i = 1, listSize do
                    local item = newData.list[i]
                    local item2 = self._getActivityListRsp.list[i]
                    for k, v in pairs(item) do
                        if k ~= "whitelist" then
                            if v ~= item2[k] then
                                return false
                            end
                        end
                    end
                end
                return true
            end
        end
    end
end

function ActivityCenterLayer:initMenuList()
    local Bg = self:getContextSprite()

    self._menuList = ActivityMenuList.new():addTo(Bg, Order.MENU)
    self._menuList:setSelectedEvent(function(index)
        if not index or index < 1 or index > #self._getActivityListRsp.list then
            return
        end 
        
        local itemData = self._getActivityListRsp.list[index]
        if itemData.type and (itemData.type == "local" or itemData.type == "local2") then
            self:showLocalContent(itemData)
        else
            self:showWebContent(itemData.url)
        end
    end)
end

function ActivityCenterLayer:updateMenuList()
    if( self._menuList )then
        self._menuList:refreshListView(self._getActivityListRsp.list, self._getActivityListRsp.default_index)
    end
end

function ActivityCenterLayer:initWebView()
    local Bg = self:getContextSprite()

    self._webView = ccexp.WebView:create()
    self._webView:align(display.BOTTOM_LEFT, 292, 50):addTo(Bg, 1, Tag.WebView)
    self._webView:setContentSize(cc.size(RIGHT_CONTENT_WIDTH, RIGHT_CONTENT_HIGHT))
    self._webView:setScalesPageToFit(true)
    self._webView:setOnShouldStartLoading(function (sender,eventType)
            return true
        end
    )
    self._webView:setOnDidFinishLoading(function (sender,eventType)
        if not self._localView:isVisible() then
                self._webView:setVisible(true)
                self._localView:setVisible(false)
            end
        end
    )
    self._webView:setOnDidFailLoading(function (sender,eventType)
        end
    )
end

-- 显示网页活动
function ActivityCenterLayer:showWebContent(url)
    if string.find(url,"?") ~= 0 then
        url = string.format("%s?sid=%s",url,MyGame:getUserData():getUserSession())
    else
        url = string.format("%s&sid=%s",url,MyGame:getUserData():getUserSession())
    end
    self._localView:setVisible(false)
    self._webView:loadURL(url)
    self._webView:setVisible(true)
end

function ActivityCenterLayer:getContextSprite()
    return self._bg
end

function ActivityCenterLayer:initLocalView(  )
    local Bg = self:getContextSprite()
    self._localView = display.newNode()
    self._localView:setVisible(false)
    self._localView:align(display.BOTTOM_LEFT, 292, 50):addTo(Bg, 2, Tag.Local)
    self._localView:setContentSize(cc.size(RIGHT_CONTENT_WIDTH, RIGHT_CONTENT_HIGHT))
end

-- 显示本地活动
function ActivityCenterLayer:showLocalContent( data )
    self._webView:setVisible(false)
    self._localView:setVisible(true)
    -- 本地代理活动
    self._localView:removeAllChildren()  
    if not self._activityFactory then
        print("ActivityCenterLayer:showLocalContent")
        return
    end
    local agentView = self._activityFactory:createActivity({contentData = data})  
    if agentView then
        agentView:align(display.CENTER, W2(self._localView), H2(self._localView)):addTo(self._localView)
    end
    comui.removeWaitingLayer()
end

return  ActivityCenterLayer