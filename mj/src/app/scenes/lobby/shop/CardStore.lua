local BaseView = import("app.views.BaseView")
local TableView = import("app.utils.TableView")

TAG = {
    TABLE_VIEW = 1
}

local CardStore = class("CardStore",function()
    return BaseView.new()
end)

function CardStore:ctor()
    self:init()
    
    -- display.newColorLayer(cc.c4b(255, 125, 125, 125)):addTo(self)

end

function CardStore:onEnter()
    BaseView.onEnter(self)
end

function CardStore:onExit()
     BaseView.onExit(self)
end

function CardStore:init()
    self:initView()
end

function CardStore:initView()

    self:initTableView()

end

--[[ convert a ccui.ListView -> TableView
listview, is a instance of ccui.ListView
sizeSource = function(self, index)
	return cc.size(100, 50)
end
loadSource = function(self, index)
	return display.newNode() -- which size is equal to sizeSource(index)
end
unloadSource = function(self, index)
	print("You can unload texture of index here")
end

note: listview:addScrollViewEventListener() MUST call after TableView.attachTo()
]]--

function CardStore:initTableView()
    print("initTableView")
    self.m_tabelView = ccui.ListView:create()
    self.m_tabelView:setContentSize(cc.size(display.cx, display.height))
    self.m_tabelView:setPosition(0,0)
    self.m_tabelView:setDirection(ccui.ListViewDirection.vertical)
    self.m_tabelView:addTo(self)
    -- self.m_tabelView:align(display.LEFT_BOTTOM, 0, 0):addTo(self)

    -- local function sizeSource(self, index)

    --     return cc.size(322, 110*index)
    -- end
    -- local function loadSource(self, index)
    --     dump(self, "self", 8)
    --     -- local container = ccui.Layout:create()
    --     -- container:setTouchEnabled(true)
    --     -- container:setContentSize(display.cx, 100)
    --     print("index", index, index/2)
    --     if index/2 == 0 then
    --         return display.newSprite("#login_btn_yk_skin.png")
    --     else
    --         return display.newSprite("#login_btn_skin.png")
    --     end 

    --     -- return display.newSprite("#login_btn_yk_skin.png")--:addTo(container)

    --     -- return container
    --     -- return display.newSprite("#login_btn_yk_skin.png")--display.newNode() -- which size is equal to sizeSource(index)
    -- end
    -- local function unloadSource(self, index)
    --     print("You can unload texture of index here")
    -- end

    dump(sizeSource, "sizeSource")

    TableView.attachTo(self.m_tabelView, self.sizeSource, self.loadSource, self.unloadSource)
    self.m_tabelView:initDefaultItems(10)

    self:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()

        -- for i=1,10 do
            self.m_tabelView:jumpTo(1)
        -- end

    end)))
    self:runAction(cc.Sequence:create(cc.DelayTime:create(4), cc.CallFunc:create(function()

        -- for i=1,10 do
            self.m_tabelView:jumpTo(2)
        -- end

    end)))

    

    -- for i=1,10 do
    --     print(i)
    --     self.m_tabelView:insertRow(i)
    -- end

    -- for i,v in ipairs(self.samples) do
    -- for i=1,10 do
	-- 	local cb = function (sender)
	-- 		-- self:openDemoWithPath(v.path)
	-- 	end
	-- 	-- local image = cc.player.quickRootPath .. "quick/" .. v.path .. "/logo.png"
    --     local item = self:loadSource()--self:_createItem(image, v.title, v.description, cb)
    --     self.m_tabelView:pushBackCustomItem(item)
    -- end
end

function CardStore:sizeSource(index)
    -- return cc.size(display.cx, 100)
    print("sizeSource.index:", index)
    return cc.size(322, 110)
end

function CardStore:loadSource(index)
    print("loadSource.index:", index)
    if index/2 == 0 then
        return display.newSprite("#login_btn_yk_skin.png")
    else
        return display.newSprite("#login_btn_skin.png")
    end 

    -- local container = ccui.Layout:create()
	-- container:setTouchEnabled(true)
    -- container:setContentSize(display.cx, 100)
    -- if index == 2 then
    --     display.newSprite("#login_btn_yk_skin.png"):addTo(container)
    -- else
    --     display.newSprite("#login_btn_skin.png"):addTo(container)
    -- end 

    -- return container
end

function CardStore:unloadSource(index)
    print("unloadSource.index:", index)
    print("You can unload texture of index here")
end

return CardStore