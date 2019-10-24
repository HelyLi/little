local WeChat = {}

local AND_APPID = "wx1bd866e6fe0bf5b2"
local AND_SECRET = "3a754900196d9f76400454583250d657"
local IOS_APPID = ""
local IOS_SECRET = ""


WeChat.AccountKey = ""

--
function WeChat.isInstalled(appId)
    local ocParams = {
        appId = appId
    }
    local javaParams = {
        appId
    }

    local javaMethodSig="(Ljava/lang/String;)I"

	local ret = NativeApi.callStaticMethod({
		className = "WeChat",
		methodName = "isInstalled",
		ocParams = ocParams,
		javaParams = javaParams,
		javaMethodSig = javaMethodSig
	})
	if ret == nil or ret == 0 or ret == false then
		return false
	else
		return true
	end
end

--启动微信
function WeChat.openApp()
    local ocParams = {
		appID=URL_APPID
	}

    local javaParams = {
		URL_APPID
	}

	local javaMethodSig="(Ljava/lang/String;)V"
	NativeApi.callStaticMethod({
		className = "WeChat",
		methodName = "openApp",
		ocParams = ocParams,
		javaParams = javaParams,
		javaMethodSig = javaMethodSig
	})
end

--保存最后的登录token和时间
function WeChat.saveLoginData(data)
	local access_token = data.access_token
	local openid = data.openid
	local unionid = data.unionid
	local refresh_token = data.refresh_token
	if openid and unionid then
		local account = {
			openid = openid,
			unionid = unionid
		}
		Game:getUserData():setWXUnionId(unionid)
		cc.UserDefault:getInstance():setStringForKey(WeChat.AccountKey, json.encode(account))
	end
	-- MyGame:getUserData():setWXOpenId(openid)
	-- cc.UserDefault:getInstance():setStringForKey(TOKEN_KEY,refresh_token or "")
	-- cc.UserDefault:getInstance():setDoubleForKey(LOGIN_TIMER_NKEY,os.time())
	
	-- cc.UserDefault:getInstance():setStringForKey(WeChat.AccessTokenKey, access_token)
	cc.UserDefault:getInstance():flush()
end

function WeChat.doLoginOut()
    cc.UserDefault:getInstance():setStringForKey(WeChat.AccountKey, json.encode(account))
    cc.UserDefault:getInstance():flush()
end

function WeChat.doLogin(regcallback)
    local channelId = Game:getAppConfig():getChannelId()
    local appId = AND_APPID
    if AppGlobal.ChannelId.IOS == channelId then
        appId = IOS_APPID
    end

    if not self:isInstalled(appId) then
        regcallback({})
        return
    end

    local listener = function (status, code)
        
    end

    local ocParams = {
        appId=appId,
        listener=listener
	}

    local javaParams = {
        appId,
        listener
	}

    local javaMethodSig="(Ljava/lang/String;I)V"
	NativeApi.callStaticMethod({
		className = "WeChat",
		methodName = "sendAutoReq",
		ocParams = ocParams,
		javaParams = javaParams,
		javaMethodSig = javaMethodSig
	})
end



return WeChat