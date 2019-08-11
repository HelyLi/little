--[[
    活动界面右边面板, 本地界面
]]

local Tag = {
    CONTENT_BG  = 1,
    MENU        = 2,
}

local RIGHT_CONTENT_WIDTH = 1006
local RIGHT_CONTENT_HIGHT = 614

local SubActivityBase = class("SubActivityBase", BaseView)

function SubActivityBase:ctor(params)
    self._contentBg = nil
    self._menuBase = nil
    self._subType = 0
    self._activity = params.container
    self._contentData = params.contentData

    self:setContentSize(params.size or cc.size(RIGHT_CONTENT_WIDTH, RIGHT_CONTENT_HIGHT))
    self:initView()    
end

function SubActivityBase:initContentView()
    
end

function SubActivityBase:getActivityLayer()
    return self._activity
end

function SubActivityBase:initView()
    
end

function SubActivityBase:checkContentData()
    if (self._contentData == nil) or (next(self._contentData) == nil) then        
        return false
    end
    return true
end

function SubActivityBase:getBg()
    return self._contentBg
end

function SubActivityBase:getMenu()
    if not self._menuBase then
        self._menuBase = cc.Menu:create():align(display.BOTTOM_LEFT,0,0):addTo(self, 1, Tag.MENU)
    end
    return self._menuBase
end

function SubActivityBase:initBgWithImgName(imgName)
    local ret = 0
    if not imgName or #imgName == 0 then 
        print("SubActivityBase initBgWithImgName imgName error ")
        ret = -1 
    end
    if not cc.FileUtils:getInstance():isFileExist(imgName) then
        ret = -2 
    else
        self._contentBg = display.newSprite(imgName)
        if not self._contentBg then
            print(string.format("SubActivityBase initBgWithImgName not find %s", imgName))
            ret = -3
        else
            self._contentBg:align(display.BOTTOM_LEFT,0,0):addTo(self, 1, Tag.CONTENT_BG)
        end
    end    

    if ret ~= 0 then
        self._contentBg = display.newLayer():ignoreAnchorPointForPosition(false)
        :setContentSize(self:getContentSize())
        :align(display.BOTTOM_LEFT,0,0):addTo(self, 1, Tag.CONTENT_BG)
    end

    return self._contentBg
end

function SubActivityBase:addMenuItem(menuItem, zorder, tag)
    if not self._menuBase then
        self._menuBase = cc.Menu:create():align(display.BOTTOM_LEFT,0,0):addTo(self, 1, Tag.MENU)
    end
    if menuItem then
        self._menuBase:addChild(menuItem, menuItem:getLoaclZorder() or zorder, menuItem:getTag() or tag)
    end
end

function SubActivityBase:exitActivity()
    self:getActivityLayer():dismiss()
end

return SubActivityBase