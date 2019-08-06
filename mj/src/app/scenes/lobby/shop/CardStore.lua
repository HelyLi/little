local BaseView = import("app.view.BaseView")

TAG = {
    TABLE_VIEW = 1
}

local CardStore = class("CardStore",function()
    return BaseView.new()
end)

function CardStore:ctor()
    self:init()

end

function CardStore:onEnter()
    BaseView.onEnter(self)
end

function CardStore:onExit()
     BaseView.onExit(self)
end

function CardStore:init()
    BaseView.initBase(self)

end

function CardStore:initTableView()
    
    self.m_tabelView = ccui.ListView:create()
    
end


return CardStore