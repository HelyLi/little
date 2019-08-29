local BaseView = import("app.views.BaseView")
local CreateRoomMenuList = import(".CreateRoomMenuList")
local CreateRoomFactory = import(".CreateRoomFactory")

local Order = {
    zzLayer     = 0,
    Bg          = 1,
    content     = 2,
}

local Tag = {
    Bg = 1,
    MenuListButton = 2
}

local CreateRoomLayer = class("CreateRoomLayer", function()
    return BaseView.new()
end)

function CreateRoomLayer:ctor()
    self:init()
end

function CreateRoomLayer:init()
    self.m_roomInfoListData = {}
    local roomConfigs = Game:getGameData():getCreateRoomInfo():getAllCardRoomInfo()
    for _,config in pairs(roomConfigs) do
        if config.isEnable then
            table.insert(self.m_roomInfoListData, config.dwOrder, config)
        end
    end

    dump(self.m_roomInfoListData, "self.m_roomInfoListData")

    self:initView()
    self:addMenu()
end

function CreateRoomLayer:initView()
    self:initBG()

    local Bg = self:getChildByTag(Tag.Bg)
    self.v_menuList = CreateRoomMenuList.new()
    self.v_menuList:align(display.BOTTOM_LEFT, 60, 65):addTo(Bg)
    self.v_menuList:setSelectedEvent(function(index)
        print("setSelectedEvent")
        if not index or index < 1 or index > #self.m_roomInfoListData then
            return
        end
        
        print("index:", index)
    end)
    self.v_menuList:refreshListView(self.m_roomInfoListData)
end

--背景
function CreateRoomLayer:initBG()
    --灰色
    local zzLayer = display.newColorLayer(cc.c4b(0,0,0,200)):addTo(self, Order.zzLayer):setContentSize(display.width,display.height)
    
    local spBG = display.newScale9Sprite('#create_room_dialog_bg_skin.png', 0, 0, cc.size(1334, 750), cc.rect(355, 350, 10, 10))
    spBG:align(display.CENTER, display.cx, display.cy):addTo(self, Order.Bg, Tag.Bg)
    
    display.newSprite("#com_btn_line_left_skin.png"):align(display.CENTER_RIGHT, display.cx + 161 - 12, display.cy - 200):addTo(self, Order.Bg)
    display.newSprite('#com_btn_line_left_skin.png'):align(display.CENTER_LEFT, display.cx + 161 + 12, display.cy - 200):addTo(self, Order.Bg):setFlippedX(true)
end

function CreateRoomLayer:addMenu()
    local Bg = self:getChildByTag(Tag.Bg)
    comui.Button({
            normal = "com_close_btn_special.png",
            pos = cc.p(W(Bg), H(Bg)),
            anchor = display.TOP_RIGHT,
            callfunc = handler(self, self.dismiss),
            parent = Bg
    })

    
end

return CreateRoomLayer