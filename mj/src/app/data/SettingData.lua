local SettingData = class("SettingData")

local SettingKey = {
    userId = "user_id",
    userAccount = "user_account",
    userPwd = "user_pwd",
    resVersion = "res_version",
    musicOn = "music_on",
    voiceOn = "voice_on",
}

function SettingData:ctor()
    self.m_userId = cc.UserDefault:getInstance():getIntegerForKey(SettingKey.userId,0)
	self.m_userAccout = cc.UserDefault:getInstance():getStringForKey(SettingKey.userAccout,"")
    self.m_userPwd = cc.UserDefault:getInstance():getStringForKey(SettingKey.userPwd,"")
    self.m_resVersion = cc.UserDefault:getInstance():getStringForKey(SettingKey.resVersion,"")
	self.m_musicOn = cc.UserDefault:getInstance():getBoolForKey(SettingKey.musicOn,true)
	self.m_voiceOn = cc.UserDefault:getInstance():getBoolForKey(SettingKey.voiceOn,true)
end

function SettingData:setResVersion()
    
end


function SettingData:setVoiceOn(isOn)
	self.m_voiceOn = isOn
	cc.UserDefault:getInstance():setBoolForKey(SettingKey.voiceOn,self.m_voiceOn)
	cc.UserDefault:getInstance():flush()
end

function SettingData:isVoiceOn()
	self.m_voiceOn = cc.UserDefault:getInstance():getBoolForKey(SettingKey.voiceOn,true)
	return self.m_voiceOn
end

function SettingData:setMusicOn(isOn)
	self.m_musicOn = isOn
	cc.UserDefault:getInstance():setBoolForKey(SettingKey.musicOn,self.m_musicOn)
	cc.UserDefault:getInstance():flush()
end

function SettingData:isMusicOn()
	self.m_musicOn = cc.UserDefault:getInstance():getBoolForKey(SettingKey.musicOn,true)
	return self.m_musicOn
end

function SettingData:setUserId(id)
	self.m_userId = id
	cc.UserDefault:getInstance():setIntegerForKey(SettingKey.userId,self.m_userId)
	cc.UserDefault:getInstance():flush()
end

function SettingData:getUserId()
	self.m_userId = cc.UserDefault:getInstance():getIntegerForKey(SettingKey.userId,0);
	return self.m_userId;
end

function SettingData:setResVersion(version)
	self.m_resVersion = version
    cc.UserDefault:getInstance():setStringForKey(SettingKey.resVersion,self.m_resVersion)
	cc.UserDefault:getInstance():flush()
end

function SettingData:getResVersion()
	self.m_resVersion = cc.UserDefault:getInstance():getStringForKey(SettingKey.resVersion,"")
	return self.m_resVersion;
end


-- function AudioMgr:isEffectEnabled()
--     return Game:getSettingData():isEffectOn()
-- end

-- function AudioMgr:isMusicEnabled()
--     return Game:getSettingData():isMusicOn()
-- end


return SettingData