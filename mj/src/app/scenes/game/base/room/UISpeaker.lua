local UIParent = import("app.scenes.game.base.UIParent")

local UISpeaker = class("UISpeaker", function ()
    return UIParent.new()
end)

function UISpeaker:ctor(presenter, order, tag, roomType)
    self.m_presenter = presenter
    self.m_roomType = roomType
    self.m_speakerQueue = {}

    self:initView()

    self:addTo(presenter, order, tag)
end

function UISpeaker:onEnter()
    UIParent.onEnter(self)
end

function UISpeaker:onExit()
    UIParent.onExit(self)
end

function UISpeaker:initView()
    local bg = display.newScale9Sprite(filename, x, y, size, capInsets)

end



return UISpeaker
