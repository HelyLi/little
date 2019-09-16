local SceneMgr = class("SceneMgr")

function SceneMgr:ctor()
    
end

function SceneMgr:gotoScene(scenename)
    self.m_mainScene = require(scenename).new()
    display.replaceScene(self.m_mainScene)
end

function SceneMgr:goLoginScene()
    self:gotoScene("app.scenes.login.LoginScene")
end

function SceneMgr:goLobbyScene()
    self:gotoScene("app.scenes.lobby.LobbyScene") 
end

local CardGameScene = {
    [XTMJ_CARD_GAME_ID] = "app.scenes.game.cardGame.xtmj.XTMJScene"
}

function SceneMgr:goCardGameScene(game)
    -- local gameId = game.gameId
    self:gotoScene(CardGameScene[XTMJ_CARD_GAME_ID])
end

return SceneMgr