-- local HttpCtrl = import("app.network.http.HttpCtrl")
WeChat = {}

local AUTHORIZATION_CODE_URL = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code"
local REFRESH_TOKEN_URL = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%s&grant_type=refresh_token&refresh_token=%s"

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

-- - "doLogin" = {
-- 	    "code" = 200
-- 	    "data" = {
-- 	        "access_token"  = "25_mIl8vMZCeyiGMzgaeuRcyUWx7QfcSHE38iFjxaFZYpS2BOTlI5JxwzLu9kU7yqg8P3bteBaYG2n52FRrjDWJmgYyzSvbLzsgL47lzkEx5UA"
-- 	        "expires_in"    = 7200
-- 	        "openid"        = "oW32R5wujuQH5j85H7RZOwXd7jXc"
-- 	        "refresh_token" = "25_BWVxa6EGTl5KhGUZeZXg6LeGlT1ryIjDCaA2g0YOvdcMkBdP6tF5vkQwo2cWj8r7TdOGKcuLe9Rts9jEZ6lVEfL5IHaAP9-gi8ExJDhFH1I"
-- 	        "scope"         = "snsapi_userinfo"
-- 	        "unionid"       = "o5mwzwHnZCSZ99Yqy7-Ff82nNPGk"
-- 	    }
-- 	}

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
	ComFunc.flush()
end

function WeChat.doLoginOut()
    cc.UserDefault:getInstance():setStringForKey(WeChat.AccountKey, json.encode(account))
    ComFunc.flush()
end

function WeChat.doLogin(regcallback)
	if type(regcallback) ~= "function" then
		regcallback = function() end
	end
    local channelId = Game:getAppConfig():getChannelId()
	local appId = AND_APPID
	local secret = AND_SECRET
    if AppGlobal.ChannelId.IOS == channelId then
		appId = IOS_APPID
		secret = IOS_SECRET
    end
	print("doLogin.1")
    if not WeChat.isInstalled(appId) then
        regcallback({})
        return
	end
	print("doLogin.2")

	local listener = function (status, code)
		print("doLogin.3", status)
		if device.platform == "android" then
			if string.find(status,"{") then
                status = checktable(json.decode(status))
            end
            code = status.code
			status = status.status
		end
		if status == 0 and string.len(code) > 0 then
			HttpCtrl.http({
				url = string.format(AUTHORIZATION_CODE_URL, appId, secret, code),
				callback = function(data)
					dump(data, "doLogin")
				end
			})
		end
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
		methodName = "doLoginReq",
		ocParams = ocParams,
		javaParams = javaParams,
		javaMethodSig = javaMethodSig
	})
end

function WeChat.doAutoLogin(regcallback)
	if type(regcallback) ~= "function" then
		regcallback = function() end
	end
	local channelId = Game:getAppConfig():getChannelId()
	local appId = AND_APPID
	local secret = AND_SECRET
    if AppGlobal.ChannelId.IOS == channelId then
		appId = IOS_APPID
		secret = IOS_SECRET
	end
	local token = ComFunc.getStringForKey(key, "")
	HttpCtrl.http({
		url = string.format(REFRESH_TOKEN_URL, appId, token),
		callback = function(data)
			if data.access_token ~= nil and data.openid ~= nil then
				WeChat.saveLoginData(data)
				regcallback(data)
			elseif data.errcode ~= nil then
				WeChat.doLogin(regcallback)
			elseif data.err ~= nil then
				regcallback(nil, "微信登录失败，请重新登录")
			end
		end
	})

end

--
function WeChat.doShare(params)
	local appId = AND_APPID
    if AppGlobal.ChannelId.IOS == channelId then
		appId = IOS_APPID
    end

	local callback = function(data, isCircle)
		
	end

	local ocParams = {
		appId=appId,
		title=params.title,
		des=params.des,
		url=params.url,
		path=params.path,
		isCircle=params.isCircle,
		isImg=params.isImg,
		isTxt=params.isTxt,
		listener=callback
	}

	local javaParams = {
		appId,
		params.title,
		params.des,
		params.url,
		params.path,
		params.isCircle,
		params.isImg,
		params.isTxt,
		callback
	}

	local javaMethodSig="(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IIII)V"
	NativeApi.callStaticMethod({
		className = "WeChat",
		methodName = "doShare",
		ocParams = ocParams,
		javaParams = javaParams,
		javaMethodSig = javaMethodSig
	})
end


return WeChat