local GameConstants = import("..data.GameConstants")
local UIParent = import("app.scenes.game.base.UIParent")

local GameFlow = class("GameFlow", function ()
    return UIParent.new()
end)

function GameFlow:ctor(container)
    self.m_container = container
    self.m_flowQueue = Queue.new(10)
    self.m_curProcess = GameConstants.PROCESS.NONE
    self.m_processOver = {}

    self:initFlowFunc()
    self:addTo(container)
end
-- GameConstants.PROCESS = {
--     NONE                = 0,
--     GAME_START          = 1,    --开局
--     SHOW_BANKER         = 2,    --定庄家
--     ROCK_DICE           = 3,    --摇骰子
--     START_SEND_CARD     = 4,    --开局
--     OPEN_GOLD_CARD      = 5,    --翻金牌
--     SORT_HANDCARD       = 6,    --刷新手牌
--     GAME_END_LIUJU      = 7,    --流局
--     GAME_END_HU         = 8,    --胡牌
--     GAME_END_RESULT     = 9,    --结算
-- }
function GameFlow:initFlowFunc()
    self.m_flowFunc = {}
    self.m_flowFunc[GameConstants.PROCESS.GAME_START] = handler(self, self.gameStart)
    self.m_flowFunc[GameConstants.PROCESS.SHOW_BANKER] = handler(self, self.showBanker)
    self.m_flowFunc[GameConstants.PROCESS.ROCK_DICE] = handler(self, self.rockDice)
    self.m_flowFunc[GameConstants.PROCESS.START_SEND_CARD] = handler(self, self.startSendCard)
    self.m_flowFunc[GameConstants.PROCESS.OPEN_GOLD_CARD] = handler(self, self.openGoldCard)
    self.m_flowFunc[GameConstants.PROCESS.SORT_HANDCARD] = handler(self, self.sortHandcard)
    self.m_flowFunc[GameConstants.PROCESS.GAME_END_LIUJU] = handler(self, self.gameEndLiuJu)
    self.m_flowFunc[GameConstants.PROCESS.GAME_END_HU] = handler(self, self.gameEndHu)
    self.m_flowFunc[GameConstants.PROCESS.GAME_END_RESULT] = handler(self, self.gameEndResult)
end

function GameFlow:setCurProcess(curProcess)
    self.m_curProcess = curProcess
end

function GameFlow:getCurProcess()
    return self.m_curProcess
end

function GameFlow:addFlow(flow)
    self.m_flowQueue:enQueue(flow)
end

-- {
--     process = 0,
--     data = data,
--     time = time
-- }
--下一流程
function GameFlow:runNextProcess()
    --已经完成的流程
    table.insert(self.m_processOver, 1, self:getCurProcess())
    self:setCurProcess(GameConstants.PROCESS.NONE)
    --
    if self.m_flowQueue:size() > 0 then
        local flow = self.m_flowQueue:deQueue()
        if flow then
            self:setCurProcess(flow.process)
            if type(self.m_flowFunc[flow.process]) == "function" then
                self.m_flowFunc[flow.process](flow.data or {}, flow.time or 0.001)
            end
        end
    end
end

--延时下一流程
function GameFlow:delayRunNextProcess(time)
    self:stopAllActions()
    self:performWithDelay(handler(self, self.runNextProcess), time)
end

function GameFlow:clear()
    self:stopAllActions()
    self:setCurProcess(GameConstants.PROCESS.NONE)
    self.m_flowQueue:clear()
    self.m_processOver = {}
end

--判断流程是否已经完成
function GameFlow:isProcessOver(process)
    for i,v in ipairs(self.m_processOver) do
        if v == process then
            return true
        end
    end
    return false
end

--添加一个流程
function GameFlow:addOneProcess(flow)
    self:addFlow(flow)
    if self:getCurProcess() == GameConstants.PROCESS.NONE then
        self:runNextProcess()
    end
end

--添加多个流程
function GameFlow:addMoreProcess(flows)
    for i,flow in ipairs(flows) do
        self:addFlow(flow)
    end

    if self:getCurProcess() == GameConstants.PROCESS.NONE then
        self:runNextProcess()
    end
end

----- 添加流程回调 -----
function GameFlow:gameStart(data, time)
    
    self:delayRunNextProcess(time)
end

function GameFlow:showBanker(data, time)
    
    self:delayRunNextProcess(time)
end

function GameFlow:rockDice(data, time)
    
    self:delayRunNextProcess(time)
end

function GameFlow:startSendCard(data, time)
    
    self:delayRunNextProcess(time)
end

function GameFlow:openGoldCard(data, time)
    
    self:delayRunNextProcess(time)
end

function GameFlow:sortHandcard(data, time)
    
    self:delayRunNextProcess(time)
end

function GameFlow:gameEndLiuJu(data, time)
    
    self:delayRunNextProcess(time)
end

function GameFlow:gameEndHu(data, time)
    
    self:delayRunNextProcess(time)
end

function GameFlow:gameEndResult(data, time)
    
    self:delayRunNextProcess(time)
end

----- 
--添加开局流程
function GameFlow:addGameStartFlow()
    if not self:isProcessOver(GameConstants.PROCESS.GAME_START) then
        self:addFlow({ process = GameConstants.PROCESS.GAME_START })
    end

    
end

return GameFlow


