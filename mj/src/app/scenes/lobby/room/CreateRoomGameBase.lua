local BaseView = import("app.views.BaseView")

local CreateRoomGameW = 960
local CreateRoomGameH = 510

local CreateRoomGameBase = class("CreateRoomGameBase", function ()
    return BaseView.new()
end)

function CreateRoomGameBase:ctor()
    -- display.newColorLayer(cc.c4b(255, 0, 0, 255)):setContentSize(cc.size(CreateRoomGameW, CreateRoomGameH)):align(display.BOTTOM_LEFT, 0, 0):addTo(self)
    self:setContentSize(cc.size(CreateRoomGameW, CreateRoomGameH))
end

function CreateRoomGameBase:refreshOptionItem(menu, tagstart, tagend, selectIndx)
    if menu then
        local num = tagend - tagstart
        for i=1,num do
            local item = menu:getChildByTag(tagstart + i)
            if item then
                if i == selectIndx then
                    item:setSelect(true)
                    item:selectAnima()
                else
                    item:setSelect(false)
                end
            end
        end
    end
end

function CreateRoomGameBase:refreshOneOptionItem(menu, tag, select)
    if menu then
        local item = menu:getChildByTag(tag)
        if item then
            print("refreshOneOptionItem:select", tag, select)
            if select then
                item:setSelect(true)
                item:selectAnima()
            else
                item:setSelect(false)
            end
        end
    end
end

--创建房间需要多少张房卡
function CreateRoomGameBase:getNeedFCard()
    return 0
end

--选房间完成，创建房间
function CreateRoomGameBase:createGameFinish()
    Game:getGameData():getCreateRoomInfo():encodeLastConfig(self.m_roomInfo.dwGameId)
    Game:getSceneMgr():goCardGameScene({
        gameId = self.m_roomInfo.dwGameId,
        fromScene = {type = AppGlobal.SceneType.LOBBY}
    })
    return true
end

return CreateRoomGameBase