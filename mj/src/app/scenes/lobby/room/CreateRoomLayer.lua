local BaseView = import("app.views.BaseView")
local CreateRoomMenuList = import(".CreateRoomMenuList")
local CreateRoomFactory = import(".CreateRoomFactory")

local Order = {
    zzLayer     = 0,
    Bg          = 1,
    GameRoom    = 2,
    MenuList    = 3,
    MenuCreate  = 4,
    Close       = 4
}

local Tag = {
    Bg = 1,
}

local RIGHT_CONTENT_WIDTH = 960
local RIGHT_CONTENT_HIGHT = 510

local CreateRoomLayer = class("CreateRoomLayer", function()
    return BaseView.new()
end)

function CreateRoomLayer:ctor()
    self:setSwallowTouches(true)
    self:init()
end

function CreateRoomLayer:init()
    self.m_roomInfoListData = {}
    local roomConfigs = Game:getGameData():getCreateRoomInfo():getAllCardRoomInfo()
    for _,config in pairs(roomConfigs) do
        --isEnable 开放
        if config.isEnable then
            table.insert(self.m_roomInfoListData, config.dwOrder, config)
        end
    end
    --排序
    table.sort(self.m_roomInfoListData, function (a, b)
        return a.dwOrder > b.dwOrder
    end)
    


    dump(self.m_roomInfoListData, "self.m_roomInfoListData")

    self:initView()
    self:initMenu()
    self:initGameRoomView()
    
end

function CreateRoomLayer:initView()
    self:initBG()

    local Bg = self:getChildByTag(Tag.Bg)
    self.v_menuList = CreateRoomMenuList.new()
    self.v_menuList:align(display.BOTTOM_LEFT, 60, 65):addTo(Bg, Order.MenuList)
    self.v_menuList:setSelectedEvent(function(index)
        if not index or index < 1 or index > #self.m_roomInfoListData then
            return
        end
        local gameId = self.m_roomInfoListData[index].dwGameId
        self:displayGameRoom(gameId)
    end)
    self.v_menuList:refreshListView(self.m_roomInfoListData)
end

function CreateRoomLayer:initGameRoomView()
    self.v_createRoomFactory = CreateRoomFactory.new()

    local Bg = self:getChildByTag(Tag.Bg)

    self.v_gameRoomView = display.newNode()
    self.v_gameRoomView:setVisible(true)
    self.v_gameRoomView:align(display.BOTTOM_LEFT, 300, 150):addTo(Bg, 0, Tag.GameRoom)
    self.v_gameRoomView:setContentSize(cc.size(RIGHT_CONTENT_WIDTH, RIGHT_CONTENT_HIGHT))
    -- self:displayGameRoom(1)
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

function CreateRoomLayer:initMenu()
    local Bg = self:getChildByTag(Tag.Bg)
    comui.Button({
            normal = "com_close_btn_special.png",
            pos = cc.p(W(Bg), H(Bg)),
            anchor = display.TOP_RIGHT,
            callfunc = handler(self, self.dismiss),
            parent = Bg,
            order = Order.Close
    })

    -- 95,32,01
    self.v_createRoomMenu = comui.Button({
        normal = "create_room_bt_skin.png",
        text = "创建房间",
        fontSize = 50,
        fontColor = cc.c3b(149, 50, 1),
        pos = cc.p(W2(Bg), 100),
        callfunc = handler(self, self.menuCreateRoom),
        parent = Bg,
        order = Order.MenuCreate
    })
    
    self.v_createRoomMenu_free = comui.Button({
        normal = "create_room_bt_skin.png",
        text = "免费开房",
        fontSize = 50,
        fontColor = cc.c3b(149, 50, 1),
        pos = cc.p(W2(Bg), 100),
        callfunc = handler(self, self.menuCreateRoom),
        parent = Bg,
        order = Order.MenuCreate
    }):setVisible(false)
    
end

function CreateRoomLayer:displayGameRoom(gameId)
    self.v_gameRoomView:removeAllChildren()
    -- local gameId = 

    local gameRoom = self.v_createRoomFactory:createRoomLayer(gameId)
    gameRoom:align(display.CENTER, W2(self.v_gameRoomView), H2(self.v_gameRoomView)):addTo(self.v_gameRoomView)
end

function CreateRoomLayer:menuCreateRoom()
    
end


return CreateRoomLayer