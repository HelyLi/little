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
    self:gotoScene("app.scene.lobby.LobbyScene") 
end

local CardGameScene = {
}

function SceneMgr:goCardGameScene(gameId)
    self:gotoScene(CardGameScene[gameId])
end

return SceneMgr