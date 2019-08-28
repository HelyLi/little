local RemoteSprite = import(".RemoteSprite")
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
    if params.capInsets then
        button:setCapInsets(params.capInsets)
    end
    if params.size then
        button:setContentSize(params.size)
    end
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

--[[
    options
    userId = 123456,
    sex = 0,
    faceId = 0,
    showSex = true,
    size = cc.size(0,0),
    isSystem = true,
    showRect = false
]]
-- function comui.displayUserHead(options)
--     local size = options.size or cc.size(104,104)
--     local headBg = display.newSprite()
--     headBg:setContentSize(size)

--     local deaultHead, userHead, sex = nil, nil, options.sex or 0
--     local argList = nil

--     if options.showRect == nil then
--         options.showRect = true
--     end

--     if options.isSystem == true then
--         deaultHead = cc.ui.UIImage.new("#com_men_0.png")
--     else
--         if sex == 0 then
--             deaultHead = NetSprite.new("com_men_0.png", options.userId, size, argList)
--         else
--             deaultHead = NetSprite.new("com_women_0.png", options.userId, size, argList)
--         end
--     end

--     local defaultScale = 1

--     if W(deaultHead) < H(deaultHead) then
--         defaultScale = W(headBg)/W(deaultHead)
--     else
--         defaultScale = H(headBg)/H(deaultHead)
--     end
--     deaultHead:setScale(defaultScale)
--     -- deaultHead:setScaleX(W(headBg)/W(deaultHead))
--     -- deaultHead:setScaleY(H(headBg)/H(deaultHead))

--     local zzHead = display.newSprite("#lob_head_rect_1.png")
--     zzHead:setScaleX(W(headBg)/W(zzHead))
--     zzHead:setScaleY(H(headBg)/H(zzHead))

--     comui.addCliperSprite(deaultHead,zzHead):align(display.CENTER,W2(headBg),H2(headBg)):addTo(headBg,1,100)

--     if options.showRect then
--         local kuang = cc.ui.UIImage.new("#lob_head_rect.png"):align(display.CENTER,W2(headBg),H2(headBg)):addTo(headBg,2)
--         kuang:setScaleX( (W(headBg) + 2)/W(kuang))
--         kuang:setScaleY( (H(headBg) + 2)/H(kuang))
--     end

--     if options.showSex == true then
--         local sexFile = "#com_boy_icon.png"
--         if sex == 1 then
--             sexFile = "#com_girl_icon.png"
--         end
--         cc.ui.UIImage.new(sexFile):align(display.CENTER,12,10):addTo(headBg,LOBBY_ZODER_LEVEL_2):setScale(0.8)
--     end

--     return headBg
-- end

--头像

comui.MALE = 1
comui.FEMALE = 2

function comui.displayHead(options)
    local size = options.size or cc.size(104, 104)
    local gender = options.gender or comui.MALE

    local head = display.newNode()
    head:setContentSize(size)

    local deaultHead = RemoteSprite.new({
        defaultImg = string.format("com_head_%d.png", gender),
        size = size,
        userId = options.userId
    }):align(display.CENTER, size.width/2, size.height/2)

    -- local callfunc = options.callfunc
    -- if type(callfunc) ~= "function" then
    --     callfunc = function() end
    -- end
    -- deaultHead:addTouchEventListener(function(sender, eventType)
    --     if ccui.TouchEventType.ended == eventType then
    --         callfunc(options.tag)
    --     end
    -- end)

    -- local stencil = display.newScale9Sprite("lob_head_rect_1.png", size.width/2, size.height/2, size, cc.rect(50, 50, 4, 4))
    local stencil = display.newSprite("#lob_head_rect_1.png", size.width/2, size.height/2)
    stencil:setScale(size.width/W(stencil), size.height/H(stencil))
    local clip = cc.ClippingNode:create(stencil)
    clip:setAlphaThreshold(0.5)
    clip:addChild(deaultHead)
    clip:align(display.BOTTOM_LEFT, 0, 0):addTo(head)

    if options.showSex then
        display.newSprite(string.format("#com_sex_icon_%d.png", gender)):align(display.CENTER, W(head), H(head)):addTo(head):setScale(size.width/W(stencil), size.height/H(stencil))
    end

    return head
end

--[[ {
    defaultImg 
    size = cc.size()
    userId,
}]]

return comui