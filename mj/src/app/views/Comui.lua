local RemoteSprite = import(".RemoteSprite")
local WaitingLayer = import(".WaitingLayer")
local RadioButton = import(".RadioButton")
local RadioGroup = import(".RadioGroup")
local ComDialog = import(".Dialog")

comui = {}

local TAG = {
    COM_VIEW_WAITTING = 100
}

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
    if params.fontColor then
        button:setTitleColor(params.fontColor)
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
    if params.parent then
        button:align(params.anchor or display.CENTER, params.pos.x, params.pos.y):addTo(params.parent, params.order or 0, params.tag or 0)
    end
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

--[[
        options.stringValue,
        options.charMapFile,
        options.itemWidth,
        options.itemHeight,
        options.startCharMap
]]
function comui.createLabelAtlas(options)
    local labelAtlas = cc.LabelAtlas:_create(
        options.stringValue,
        options.charMapFile,
        options.itemWidth,
        options.itemHeight,
        string.byte(options.startCharMap))
    return labelAtlas
end

--[[
    time = 0,               显示时间(秒)，为0则一直显示
    touchProhibit = false,  是否禁止触摸，true则不能点击
]]
function comui.addWaitingLayer(options)
    local parent = display.getRunningScene()

    local waitingLayer = parent:getChildByTag(TAG.COM_VIEW_WAITTING)

    if waitingLayer then
        waitingLayer:removeFromParent()
    end

    waitingLayer = WaitingLayer.new()

    if options ~= nil then
        if options.time ~= nil and options.time > 0  then
            waitingLayer:setDisplayTime(options.time)
        end

        if options.touchProhibit ~= nil then
            waitingLayer:setTouchProhibit(options.touchProhibit)
        end
    end

    waitingLayer:addTo(parent,ZODER_LEVEL_MAX,TAG.COM_VIEW_WAITTING)
end

function comui.isWaiting()
    local parent = display.getRunningScene()

    local waitingLayer = parent:getChildByTag(TAG.COM_VIEW_WAITTING)
    if waitingLayer then
        return true
    else
        return false
    end
end

function comui.removeWaitingLayer()
    local parent = display.getRunningScene()
    local waitingLayer = parent:getChildByTag(TAG.COM_VIEW_WAITTING)

    if waitingLayer ~= nil then
        waitingLayer:dismiss()
    end
end

--[[
        options.rbs,
        options.padding,
]]
function comui.createRadioGroup( options )
    local rbParams = options.rbs
    if rbParams then
        local rbOptions = {}
        for i, v in ipairs(rbParams) do
            table.insert(rbOptions, RadioButton.new(v))
        end
        local rg = RadioGroup.new({
            padding = options.padding, 
            callback = options.callback, 
            tagBase = options.tagBase, 
            posType = options.posType
        })
        rg:addOptions(rbOptions)
        return rg
    end
    return nil
end


--[[--
comui.showDialog({
    parent = nil,
    tag = 0,
    text = "",
    callback1 = nil,
    callback2 = nil,
    btnFrame1 = nil
    btnFrame2 = nil})
]]
function comui.showDialog(params)
    local dialog = ComDialog.new()
    if params.parent == nil then
        params.parent = display.getRunningScene()
    end
    if params.tag ~= nil then
        params.parent:removeChildByTag(params.tag)
    end
    params.tag = params.tag or 8888

    dialog:addTo(params.parent,1000, params.tag):display(params.text)

    if params.callback1 ~= nil and params.callback2 == nil then
        dialog:setDialogOneBtn(params.callback1)
    elseif params.callback1 ~= nil and params.callback2 ~= nil then
        dialog:setDialogTwoBtn(params.callback1, params.callback2, params.btnFrame1, params.btnFrame2)
    end

    if params.canClose == nil then
        params.canClose = true
    end
    dialog:setCanClose(params.canClose)
    return dialog
end

return comui