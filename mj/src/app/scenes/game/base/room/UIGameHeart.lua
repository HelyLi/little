local UIParent = import("app.scenes.game.base.UIParent")

local HEART_STEP_TIME = 20
local HEART_BREAK_TIME = 70

local UIGameHeart = class("UIGameHeart", function()
    return UIParent.new()
end)

function UIGameHeart:ctor(container)
    self.m_container = container
    self.b_started = false

    self:addTo(self.m_container)
end

function UIGameHeart:sendHeart()
    --发送心跳
end

--开始心跳
function UIGameHeart:start()
    self:sendHeart()

    self.m_heartStepTime = HEART_STEP_TIME
    self.m_heartBreakTime = HEART_BREAK_TIME

    if self.b_started == false then
        self.b_started = true
        self:startTimer()
    end
end

function UIGameHeart:startTimer()
    self:stopTimer()
    self.m_clockTimer = self:schedule(handler(self, self.clockRun), 1.0)
end

function UIGameHeart:clockRun()
    --心跳时间
    if self.m_heartStepTime > 0 then
        self.m_heartStepTime = self.m_heartStepTime - 1
    else
        self.m_heartStepTime = HEART_STEP_TIME
        self:sendHeart()
    end

    if self.m_heartBreakTime > 0 then
        self.m_heartBreakTime = self.m_heartBreakTime - 1
    else
        --掉线
        self:stop()
        if self:getContainer():getRoomData():isTotalEnd() == false then

        end
    end
end

function UIGameHeart:stopTimer()
    if self.m_clockTimer then
        self:removeAction(self.m_clockTimer)
        self.m_clockTimer = nil
    end
end

function UIGameHeart:stop()
    self.b_started = false
    self:stopTimer()
end

function UIGameHeart:receiveHeart()
    self.m_heartBreakTime = HEART_BREAK_TIME
end

return UIGameHeart