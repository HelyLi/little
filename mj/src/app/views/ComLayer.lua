local BaseView = import(".BaseView")

local ComLayer = class("ComLayer", function()
    return BaseView.new()
end)

local ORDER = {

}

local TAG = {

}

function ComLayer:ctor(params)
    -- local bg2_size = params.size or cc.size(0, 0)
    -- local bg_size = 
    print("ComLayer.ctor")

end

function ComLayer:onEnter()
    print("ComLayer.onEnter")
end

function ComLayer:onExit()
    print("ComLayer.onExit")
end

return ComLayer