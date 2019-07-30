local AppConfig = class("AppConfig")

local HostInfo = {
    --release
    {
        login_host = "47.94.233.203",
        login_port = "8000",
        lobby_host = "",
        lobby_port = "",
        update_url = ""
    },
    --beta
    {
        login_host = "",
        login_port = "",
        lobby_host = "",
        lobby_port = "",
        update_url = ""
    },
    --alpha
    {
        login_host = "127.0.0.1",
        login_port = "7981",
        lobby_host = "",
        lobby_port = "",
        update_url = ""
    }
}

function AppConfig:ctor()
    self.m_config = self:parseJson("channel_config.json")

    self.m_host = HostInfo[self.m_config.release or 3]
end

function AppConfig:getLoginHost()
    return self.m_host.login_host
end

function AppConfig:getLoginPort()
    return self.m_host.login_port
end

function AppConfig:getLobbyHost()
    return self.m_host.lobby_host
end

function AppConfig:getLobbyPort()
    return self.m_host.lobby_port
end

function AppConfig:getUpdateUrl()
    return self.m_host.update_url
end

function AppConfig:parseJson(file)
    local data = cc.FileUtils:getInstance():getDataFromFile(file)
	local config = json.decode(data)
	if not config then
		print("==Fail to parse json from file:", file)
		return {}
    end
    return config
end

function AppConfig:getChannelId()
    return self.m_config.channel or 2
end

function AppConfig:getPlatformId()
    return self.m_config.platform
end

return AppConfig