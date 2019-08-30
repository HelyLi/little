
local BaseNode = import(".BaseNode")
local RadioGroup = class("RadioGroup", function (  )
    return BaseNode.new()
end)

RadioGroup.Horizontal = 1
RadioGroup.Vertical = 2

function RadioGroup:ctor( params )
    self._options = {}
    self._curX = 0
    self._curSelectedIndex = params.selectIndex
    self._padding = params.padding or 10
    self._orientation = params.orientation or RadioGroup.Horizontal
    self._callback = params.callback
    self._tagBase = params.tagBase or 0 -- tag
    self._posType = params.posType or 0 -- 0:相对坐标偏移量   1:绝对坐标偏移量
end

function RadioGroup:addOption( option )
    
end

function RadioGroup:addOptions( options )
    self:removeAllChildren()
    self._options = {}
    -- self._menuBase = cc.Menu:create():align(display.BOTTOM_LEFT, 0, 0):addTo(self)
    local curX, curY = 0, 0
    local width, height = 0, 0
    local itemWidth, itemHeight = 0, 0
    local optionLen = #options
    local v = nil
    for i = 1, optionLen do
        v = options[i]
        v:align(display.BOTTOM_LEFT, curX, curY):addTo(self, 1, i + self._tagBase)
        v:setClickCallback(handler(self, self.setSelectIndex))
        -- comui.createRectMenuItem({
        --     size = cc.size(W(v),H(v)),
        --     position = cc.p(curX,curY),
        --     anchor = display.BOTTOM_LEFT,
        --     tag = i + self._tagBase,
        --     callback = handler(self, self.menuCb)
        -- }):addTo(self._menuBase)
        itemWidth = W(v)
        itemHeight = H(v)
        if self._orientation == RadioGroup.Horizontal then
            if self._posType == 0 then
                curX = curX + W(v) + self._padding
                width = width + itemWidth
                if i < optionLen then
                    width = width + self._padding
                end
            elseif self._posType == 1 then
                curX = curX + self._padding
                width = (i - 1) * self._padding
                if i == optionLen then
                    width = width + itemWidth
                end
            end
            height = math.max(itemHeight, height)
        else
            if self._posType == 0 then
                curY = curY + H(v) + self._padding
                height = height + itemHeight
                if i < optionLen then
                    height = height + self._padding
                end
            elseif self._posType == 1 then
                curY = curY + self._padding
                height = (i - 1) * self._padding
                if i == optionLen then
                    height = height + itemHeight
                end
            end
            width = math.max(itemWidth, width)
        end
        table.insert(self._options, v)
    end
    self:setContentSize(cc.size(width,height))
end

function RadioGroup:setSelectIndex( tag )
    if tag > 0 then
        if tag == self._curSelectedIndex then
            return 
        end
        self._curSelectedIndex = tag
        for i, v in ipairs(self._options) do
            if v:getTag() == tag then
                v:setSelect(true)
            else
                v:setSelect(false)
            end
        end

        if self._callback then
            self._callback(tag)
        end
    end
end

-- function RadioGroup:menuCb( tag )
--     self:setSelectIndex(tag)
-- end

function RadioGroup:clear(  )
    self._options = nil
end


return RadioGroup