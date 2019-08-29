
local RadioButton = class("RadioButton", function (  )
    return display.newNode()
end)

local Tags = {
    ON = 1,
    OFF = 2, 
    TXT = 3,
    TXT2 = 4,
}

function RadioButton:ctor( params )
    self:init(params)
end

function RadioButton:init( params )
    local on, off, txtParams = params.on, params.off, params.txt
    local colorNormal = txtParams.color or display.COLOR_BLACK
    local colorPress = txtParams.color2 or colorNormal

    local onSprite = display.newSprite(on)
    local offSprite = display.newSprite(off)

    local txtNormal = display.newTTFLabel({
        text = txtParams.text or "",
        font = txtParams.font or display.DEFAULT_TTF_FONT,
        size = txtParams.size or 30,
        color = colorNormal
    })
    local txtPress = display.newTTFLabel({
        text = txtParams.text or "",
        font = txtParams.font or display.DEFAULT_TTF_FONT,
        size = txtParams.size or 30,
        color = colorPress
    })

    local spWidth = math.max(W(onSprite), W(offSprite))
    local width = spWidth + 5 + W(txtNormal)
    local height = math.max(H(onSprite), H(offSprite))

    self:setContentSize(cc.size(width,height))

    onSprite:align(display.CENTER, spWidth/2, height/2):addTo(self, 1, Tags.ON)
    offSprite:align(display.CENTER, spWidth/2, height/2):addTo(self, 1, Tags.OFF)

    txtNormal:align(display.CENTER_LEFT, spWidth + 5, height/2):addTo(self, 1, Tags.TXT)
    txtPress:align(display.CENTER_LEFT, spWidth + 5, height/2):addTo(self, 1, Tags.TXT2)

    local selected = params.selected or false
    if selected then
        onSprite:setVisible(true)
        offSprite:setVisible(false)
        txtPress:setVisible(true)
        txtNormal:setVisible(false)
    else
        offSprite:setVisible(true)
        onSprite:setVisible(false)
        txtNormal:setVisible(true)
        txtPress:setVisible(false)
    end
    self._isSelected = selected
end

function RadioButton:setClickCallback(callback)
    self:addOnClick(function ()
        print("self:getTag():", self:getTag())
        callback(self:getTag())
    end)
    self:setNodeEventEnabled(true)
end

function RadioButton:setSelect( state )
    self._isSelected = state
    local onSprite = self:getChildByTag(Tags.ON)
    local offSprite = self:getChildByTag(Tags.OFF)
    local txtNormal = self:getChildByTag(Tags.TXT)
    local txtPress = self:getChildByTag(Tags.TXT2)
    if onSprite and offSprite then
        if state then
            onSprite:setVisible(true)
            offSprite:setVisible(false)
            txtPress:setVisible(true)
            txtNormal:setVisible(false)
        else
            offSprite:setVisible(true)
            onSprite:setVisible(false)
            txtNormal:setVisible(true)
            txtPress:setVisible(false)
        end
    end
end

function RadioButton:isSelect(  )
    return self._isSelected
end

return RadioButton