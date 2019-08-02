require "app.base.Game"
local UpdateLayer = import(".UpdateLayer")

local UpdateScene = class("UpdateScene", function()
    return display.newScene("UpdateScene")
end)

function UpdateScene:ctor()
    Game:init()
    self:loadSpriteFrames()
    local layer = UpdateLayer.new()
    layer:align(display.CENTER, display.cx, display.cy)
    layer:addTo(self)
end

function UpdateScene:onEnter()
    
end

function UpdateScene:onExit()
end

local AsyncRes = {
    "LoginRes"
}

function UpdateScene:loadSpriteFrames()
    cc.Director:getInstance():purgeCachedData()
    for i,res in ipairs(AsyncRes) do
        display.addSpriteFrames(res..".plist",res..".pvr.ccz")
    end
end

function UpdateScene:reloadSpriteFrames()
    for i,res in ipairs(AsyncRes) do
        cc.Director:getInstance():getTextureCache():reloadTexture(res .. '.pvr.ccz')
    end
    cc.Director:getInstance():purgeCachedData()
end

return UpdateScene
