local BaseView = import("app.views.BaseView")

local GameLayer = class("LobbyLayer",function()
    return BaseView.new()
end)

function GameLayer:ctor()
    
    self:init()
end

function GameLayer:init()
    self:initBg()
    self:regBackEvent()
end

function GameLayer:initBg()
    self.v_bg = display.newSprite(self:getBgImg()):align(display.CENTER, display.cx, display.cy):addTo(self)
end

function GameLayer:getBgImg()
    return "BigRes/game_four_bg.png"
end

----------------房间状态标志-------------
--观看录像
function GameLayer:isGameReplay()
    return self.b_gameReplay
end

function GameLayer:setGameReplay(replay)
    self.b_gameReplay = replay
end

--正在退出
function GameLayer:isExit()
    return self.b_exit
end

function GameLayer:setExit(exit)
    self.b_exit = exit
end

--后台更新
function GameLayer:isGameBackGround()
    return self.b_gameBackGround
end

function GameLayer:setGameBackGround(background)
    self.b_gameBackGround = background
end

----------------房间组件-------------
--房间数据
function GameLayer:getRoomData()
    return self.m_gameRoomData
end

--游戏语音
function GameLayer:getGameVoice()
    return self.m_gameVoice
end

--房间常驻UI控件
function GameLayer:getUIRoomPart(key)
    return self.m_UIRoomParts[key]
end

----------------房间基本组件-------------
--游戏逻辑基础数据
function GameLayer:getPlayingData()
    return self.m_gamePlayingData
end

--游戏常驻UI控件
function GameLayer:getUIPlayPart(key)
    return self.m_UIPlayParts[key]
end

--玩家麻将区
function GameLayer:getPlayingCardsByViewId(viewId)
    if viewId == GameConstants.VIEW_ID.My then
        return self:getUIPlayPart(GameConstants.GAME_UI.MyPlayingCards)
    elseif viewId == GameConstants.VIEW_ID.PlayerA then
        return self:getUIPlayPart(GameConstants.GAME_UI.PlayingCardsA)
    elseif viewId == GameConstants.VIEW_ID.PlayerB then
        return self:getUIPlayPart(GameConstants.GAME_UI.PlayingCardsB)
    elseif viewId == GameConstants.VIEW_ID.PlayerC then
        return self:getUIPlayPart(GameConstants.GAME_UI.PlayingCardsC)
    end
end

--游戏组件清空数据
function GameLayer:UIPlayPartsClear()
    for k,v in pairs(self.m_UIPlayParts) do
        if v.clear then
            v:clear()
        end
    end
end

function GameLayer:UIPlayPartsUpdateAll()
    for k,v in pairs(self.m_UIPlayParts) do
        if v.updateAll then
            v:updateAll()
        end
    end
end

function GameLayer:regBackEvent()
    -- if device.platform == "android" then
    --     self:addNodeEventListener(cc.KEYPAD_EVENT,function(event)
    --         if event.key == "back" then
    --         	local kpSize = self:getKeyPadListSize()
    --         	if kpSize > 0 then
    --         		self:popFromKeyPadList()
    --         	else
    --                 --Game:getEventDispatcher().pushEvent(AppGlobal.EventMsg.DIALOG_EXIT_GAME)
    --         	end
    --         end
    --     end)
    --     self:setKeypadEnabled(true)
    -- end
    self:addMsgListener(APP_ENTER_BACKGROUND_EVENT, handler(self, self.backgroundEvent))
    self:addMsgListener(APP_ENTER_FOREGROUND_EVENT, handler(self, self.foregroundEvent))
end

function GameLayer:backgroundEvent()
    
end

function GameLayer:foregroundEvent()
    
end

return GameLayer