local UIParent = import("app.scenes.game.base.UIParent")

local UISpeaker = class("UISpeaker", function ()
    return UIParent.new()
end)

function UISpeaker:ctor(presenter, order, tag, roomType)
    self.m_presenter = presenter
    self.m_roomType = roomType
    self.m_isRuning = false
    self.m_flowQueue = Queue.new(10)

    self:initView()

    self:addTo(presenter, order, tag)
end

function UISpeaker:onEnter()
    UIParent.onEnter(self)
end

function UISpeaker:onExit()
    self.m_flowQueue:clear()
    UIParent.onExit(self)
end

function UISpeaker:initView()
    local bg = display.newScale9Sprite(filename, x, y, size, capInsets)

end

function UISpeaker:addFlow(flow)
    self.m_flowQueue:enQueue(flow)
end

-- {
--     process = 0,
--     data = data,
--     time = time
-- }
--下一通知
function UISpeaker:runNextSpeaker()
    --
    self.m_isRuning = false
    if self.m_flowQueue:size() > 0 then
        local flow = self.m_flowQueue:deQueue()
        if flow then
            self.m_isRuning = true
            self:displaySpeaker(flow)
        end
    end
end

function UISpeaker:displaySpeaker(flow)



    self:delayRunNextSpeaker(8)
end

--延时下一流程
function UISpeaker:delayRunNextSpeaker(time)
    self:stopAllActions()
    self:performWithDelay(handler(self, self.runNextSpeaker), time)
end


--添加一个流程
function UISpeaker:addOneSpeaker(flow)
    self:addFlow(flow)
    if self.m_isRuning == false then
        self:runNextSpeaker()
    end
end

--添加多个流程
function UISpeaker:addMoreSpeakers(flows)
    for i,flow in ipairs(flows) do
        self:addFlow(flow)
    end

    if self.m_isRuning == false then
        self:runNextSpeaker()
    end
end

function UISpeaker:popUpCallback(data)
    print("UISpeaker:popUpCallback")
end

return UISpeaker
