local BaseNode = import("app.views.BaseNode")

local Speaker = class("Speaker", function ()
    return BaseNode.new()
end)

function Speaker:ctor()
    self.m_isRuning = false
    self.m_flowQueue = Queue.new(10)
    self:initView()
    self:addMsgListener(AppGlobal.EventMsg.SPEAKER_POP_UP, handler(self, self.popUpCallback))
end

function Speaker:initView()

end

function Speaker:onEnter()
    BaseNode.onEnter(self)
end

function Speaker:onExit()
    self.m_flowQueue:clear()
    BaseNode.onExit(self)
end


function Speaker:addFlow(flow)
    self.m_flowQueue:enQueue(flow)
end

-- {
--     process = 0,
--     data = data,
--     time = time
-- }
--下一通知
function Speaker:runNextSpeaker()
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

function Speaker:displaySpeaker(flow)



    self:delayRunNextSpeaker(8)
end

--延时下一流程
function Speaker:delayRunNextSpeaker(time)
    self:stopAllActions()
    self:performWithDelay(handler(self, self.runNextSpeaker), time)
end


--添加一个流程
function Speaker:addOneSpeaker(flow)
    self:addFlow(flow)
    if self.m_isRuning == false then
        self:runNextSpeaker()
    end
end

--添加多个流程
function Speaker:addMoreSpeakers(flows)
    for i,flow in ipairs(flows) do
        self:addFlow(flow)
    end

    if self.m_isRuning == false then
        self:runNextSpeaker()
    end
end

function Speaker:popUpCallback(data)
    print("Speaker:popUpCallback")
end

return Speaker