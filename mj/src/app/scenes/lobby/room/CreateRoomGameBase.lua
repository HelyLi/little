local BaseView = import("app.views.BaseView")

local CreateRoomGameW = 1028
local CreateRoomGameH = 642

local CreateRoomGameBase = class("CreateRoomGameBase", function ()
    return BaseView.new()
end)

function CreateRoomGameBase:ctor()
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
            if select then
                item:setSelect(true)
                item:selectAnima()
            else
                item:setSelect(false)
            end
        end
    end
end

return CreateRoomGameBase