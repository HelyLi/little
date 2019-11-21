local SubLayer = import(".SubLayer")
local MenuSprite = import(".MenuSprite")

local ComDialog = class("ComDialog", function()
    return SubLayer.new()
end)

function ComDialog:ctor(params)
    self.m_params = params
    if params.canClose == nil then
        params.canClose = true
    end
    self:initSub({size = cc.size(800, 480), close = params.canClose})
    self.v_bg2 = self:addBg2()
    self.v_menuBg = self:addMenuBg()
    self:addTitle(self.m_params.title or "com_tips_title.png")
    self:initView()
end

function ComDialog:initView()

end

function ComDialog:initComDialogText()
	local bgHeight = COM_DIALOG_BG_H_MIN
	local contentHeight = COM_DIALOG_CONTENT_H_MAX

    local text = self._params.text or self._params.strTxt or ""
	local contentLabel = cc.ui.UILabel.new({
		text = text,
		font = "TTFFonts/mini_font.TTF",
		size = 40,
		color = cc.c3b(106, 55, 30),
		align = cc.ui.TEXT_ALIGN_CENTER})

	if W(contentLabel) > COM_DIALOG_CONTENT_W_MAX then
		contentLabel:setDimensions(COM_DIALOG_CONTENT_W_MAX,0)
	end

	if H(contentLabel) > COM_DIALOG_CONTENT_H_MAX then
		contentHeight = H(contentLabel)
        bgHeight = H(contentLabel) + COM_DIALOG_CONTENT_H_OFFSET
	end

    self:resetBgSize(cc.size(COM_DIALOG_BG_W_MIN, bgHeight))
    local txtPosy = (bgHeight - COM_DIALOG_CONTENT_H_OFFSET) / 2 + COM_DIALOG_CONTENT_H_OFFSET
	contentLabel:align(display.CENTER, COM_DIALOG_BG_W_MIN/2, txtPosy):addTo(self._whiteBg, LOBBY_ZODER_LEVEL_1,COM_DIALOG_CONTENT_TAG)
end

function ComDialog:setDialogTwoBtn(callback1,callback2,btnFrame1,btnFrame2)
    if self.v_bg2 == nil then
        return
    end
    local cb1 = nil
    local cb2 = nil

    if callback1 == nil then
    	cb1 = function() self:dismiss() end
    else
    	cb1 = function()
            callback1()
            if self._canClose1 == true or self._canClose1 == nil then
                self:dismiss()
            end
        end
    end

    if callback2 == nil then
    	cb2 = function() self:dismiss() end
    else
    	cb2 = function()
            callback2() 
            if self._canClose2 == true or self._canClose2 == nil then
                self:dismiss()
            end
        end
    end

    if btnFrame1 == nil then
    	btnFrame1 = "#com_txt_cancel.png"
    end

    if btnFrame2 == nil then
    	btnFrame2 = "#com_txt_confirm.png"
    end

    local normal = display.newSprite("#com_orange_btn.png")
    display.newSprite(btnFrame1):align(display.CENTER, W2(normal), H2(normal)):addTo(normal)
    local selected = display.newSprite("#com_orange_btn.png"):setOpacity(180)
    display.newSprite(btnFrame1):align(display.CENTER, W2(selected), H2(selected)):addTo(selected)
    
    local noMenu = MenuSprite.new({
        normal = normal,
        selected = selected,
        parent = self.v_menuBg,
        position = cc.p(W2(self.v_menuBg) - 195, H2(self.v_menuBg)),
        callfunc = cb1
    })

    local normal = display.newSprite("#com_green_btn.png")
    display.newSprite(btnFrame2):align(display.CENTER, W2(normal), H2(normal)):addTo(normal)
    local selected = display.newSprite("#com_green_btn.png"):setOpacity(180)
    display.newSprite(btnFrame2):align(display.CENTER, W2(selected), H2(selected)):addTo(selected)

    local yesMenu = MenuSprite.new({
        normal = normal,
        selected = selected,
        parent = self.v_menuBg,
        position = cc.p(W2(self.v_menuBg) + 195, H2(self.v_menuBg)),
        callfunc = cb2
    })

end

function ComDialog:setDialogOneBtn(callback,btnFrame)
    if self.v_bg2 == nil then
        return
    end

    local callback1 = nil

	if callback == nil then
		callback1 = function() self:dismiss() end
	else
		callback1 = function()
            callback() 
            if self._canClose1 == true or self._canClose1 == nil then
                self:dismiss()
            end
		end
    end
    
    if btnFrame == nil then
    	btnFrame = "#com_txt_confirm.png"
    end

    local normal = display.newSprite("#com_green_btn.png")
    display.newSprite(btnFrame2):align(display.CENTER, W2(normal), H2(normal)):addTo(normal)
    local selected = display.newSprite("#com_green_btn.png"):setOpacity(180)
    display.newSprite(btnFrame2):align(display.CENTER, W2(selected), H2(selected)):addTo(selected)

    local yesMenu = MenuSprite.new({
        normal = normal,
        selected = selected,
        parent = self.v_menuBg,
        position = cc.p(W2(self.v_menuBg), H2(self.v_menuBg)),
        callfunc = cb2
    })

end

return ComDialog
