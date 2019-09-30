local BaseView = import("app.views.BaseView")
local LobbyPresenter = import(".LobbyPresenter")

--UI
local LobbyMainMenu = import("app.scenes.lobby.room.LobbyMainMenu")
local CreateRoomLayer = import("app.scenes.lobby.room.CreateRoomLayer")
local AddRoomLayer = import("app.scenes.lobby.room.AddRoomLayer")
local UserInfoLayer = import("app.scenes.lobby.subLayer.UserInfoLayer")
local SettingLayer = import("app.scenes.lobby.subLayer.SettingLayer")

local LobbyLayer = class("LobbyLayer",function()
    return BaseView.new()
end)

function LobbyLayer:ctor()
    self.m_presenter = LobbyPresenter.new(self)
    self.m_keyPadLayerList = {}
    self:initView()
    self:regMsgHandler()
    self:regBackEvent()
end

function LobbyLayer:initView()
    self.v_bg = display.newSprite("BigBg/lob_bg_skin.png"):align(display.CENTER, display.cx, display.cy):addTo(self)

    self.v_userInfo = UserInfoLayer.new():addTo(self)
    self.v_mainMenu = LobbyMainMenu.new():addTo(self)
    
    

end

function LobbyLayer:regMsgHandler()
    self:addMsgListener(AppGlobal.EventMsg.GAME_ROOM_CREATE, function ()
        local layer = CreateRoomLayer.new()
        self:addChild(layer, ZODER_LEVEL_0)
        self:addToKeyPadList(layer)
    end)
    self:addMsgListener(AppGlobal.EventMsg.GAME_ROOM_ADD, function ()
        local layer = AddRoomLayer.new()
        self:addChild(layer, ZODER_LEVEL_0)
        self:addToKeyPadList(layer)
    end)
    self:addMsgListener(AppGlobal.EventMsg.DIALOG_EXIT_GAME, function ()
        
    end)
    self:addMsgListener(AppGlobal.EventMsg.SERVICE_TEST, function ()
        if self.m_presenter then
            self.m_presenter:serviceTest()
        end
    end)
end

function LobbyLayer:regBackEvent()
    if device.platform == "android" then
        self:addNodeEventListener(cc.KEYPAD_EVENT,function(event)
            if event.key == "back" then
            	local kpSize = self:getKeyPadListSize()
            	if kpSize > 0 then
            		self:popFromKeyPadList()
            	else
                    Game:getEventDispatcher().pushEvent(AppGlobal.EventMsg.DIALOG_EXIT_GAME)
            	end
            end
        end)
        self:setKeypadEnabled(true)
    end
    self:addMsgListener(APP_ENTER_BACKGROUND_EVENT, handler(self, self.backgroundEvent))
    self:addMsgListener(APP_ENTER_FOREGROUND_EVENT, handler(self, self.foregroundEvent))
end

function LobbyLayer:addToKeyPadList(_node)
	print("addToKeyPadList")
	if _node ~= nil then
		table.insert(self.m_keyPadLayerList,_node)
	end
end

function LobbyLayer:getKeyPadListSize()
	return #(self.m_keyPadLayerList or {})
end

function LobbyLayer:popFromKeyPadList()
	local size = #self.m_keyPadLayerList
	for i=1,size do
		local removeLayer = self.m_keyPadLayerList[i]
		if removeLayer then
			if removeLayer.dismiss ~= nil then
				removeLayer:dismiss()
			end
		end
    end
    if comui.isWaiting() then
        comui.removeWaitingLayer()
    end
	self.m_keyPadLayerList = {}
end

function LobbyLayer:backgroundEvent()
    print("backgroundEvent")
end

function LobbyLayer:foregroundEvent()
    print("foregroundEvent")
end

return LobbyLayer