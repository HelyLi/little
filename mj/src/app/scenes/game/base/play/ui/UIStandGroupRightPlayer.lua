--[[
    右边玩家组合牌
]]

local UIStandGroupItem = import(".UIStandGroupItem")
local UIStandGroup = import(".UIStandGroup")

local UIStandGroupRightPlayer = class("UIStandGroupRightPlayer", function ()
    return UIStandGroup.new()
end)

function UIStandGroupRightPlayer:ctor()
    
end



return UIStandGroupRightPlayer