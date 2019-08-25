comui = {}

-- {
--     normal = "",
--     pressed = "",
--     disabled = "",
--     text = "",
--     fontSize = 12,
--      pos = cc.p()
--      parent = 
--      callfunc,
--      anchor = 
-- }

function comui.Button(params)
    local button = ccui.Button:create(params.normal, params.pressed, params.disabled, ccui.TextureResType.plistType)
    button:setScale9Enabled(true)
    if params.text then
        button:setTitleText(params.text)
    end
    if params.fontSize then
        button:setTitleFontSize(params.fontSize)
    end 
    local callfunc = params.callfunc
    if type(callfunc) ~= "function" then
        callfunc = function() end
    end
	button:addTouchEventListener(function(sender, eventType)
        if ccui.TouchEventType.ended == eventType then
            callfunc(params.tag)
        end
    end)
    button:align(params.anchor or display.CENTER, params.pos.x, params.pos.y):addTo(params.parent)
    return button
end

comui.VERTICAL = 1
comui.HORIZONTAL = 2

function comui.serialize( params )
    local orientation = params.orientation or comui.HORIZONTAL
    local nodes = params.nodes
    local anchor = params.anchor
    if anchor == nil then
        if orientation == comui.HORIZONTAL then
            anchor = display.CENTER_LEFT
        else
            anchor = display.CENTER_BOTTOM
        end
    end
    local width,height = 0,0
    local maxWidth, maxHeight = params.maxWidth or 0, params.maxHeight or 0
    local retNode = display.newSprite()
    for i, v in ipairs(nodes) do
        v.offset = v.offset or 0
        if orientation == comui.HORIZONTAL then
            width = width + v.offset
            if anchor == display.LEFT_BOTTOM then
                v.node:align(anchor, width, 0)
            else
                v.node:align(anchor, width, maxHeight/2)
            end
        else
            height = height + v.offset
            if anchor == display.LEFT_BOTTOM then
                v.node:align(anchor, 0, height)
            else
                v.node:align(anchor, maxWidth/2, height)
            end
        end
        v.node:addTo(retNode)
        if orientation == comui.HORIZONTAL then
            width = width + BW(v.node)
        else
            height = height + BH(v.node)
        end
    end
    width = math.max(width, maxWidth)
    height = math.max(height, maxHeight)

    retNode:setContentSize(cc.size(width, height))

    return retNode
end


return comui