local AudioMgr = class("AudioMgr")

AUDIO_GAME_MUSIC = {
    LOBBY_MUSIC = "audio/music/lobby_music.ogg",
    GAME_MUSIC = "audio/music/game_music.ogg"
}

AUDIO_GAME_EFFECT = {
    SITDOWN               ="com/play/game_p_sitdown",
    DISCARD               ="com/play/game_p_discard",
    SELECT_CARD           ="com/play/game_p_select_card",
    TANPAI                ="com/play/game_p_tanpai",
    DICE                  ="com/play/game_p_dice",
    TIME_NON              ="com/play/game_p_time_non",
    MOVE                  ="com/play/game_p_move",
    ZJ                    ="com/play/game_p_zj_status",
    GOLD_ACTION           ="com/play/game_p_gold_action",
    DIAN                  ="com/play/game_p_dian",
}

local AUDIO_MUSIC_PATH  = "audio/music/%s"

--key
local MUSIC_VOLUME_KEY   	= "game_music_volume"
local EFFECT_VOLUME_KEY     = "game_effect_volume"

function AudioMgr:ctor()
    self.m_isInitiallized = false
    self.m_isMusicPlaying = true
    self.m_musicVol= cc.UserDefault:getInstance():getFloatForKey(MUSIC_VOLUME_KEY, 0.95)
	self.m_effectVol= cc.UserDefault:getInstance():getFloatForKey(EFFECT_VOLUME_KEY, 0.95)

    self.m_effectFullPath = "audio/effect/%s.ogg"--AUDIO_EFFECT_FULL_PATH[device.platform]

    self:preloadfile()
end

function AudioMgr:preloadfile()
    local callback = function (path, ok)
        print(string.format("path:%s,ok:%s", path, ok))
    end
    for _,filepath in pairs(AUDIO_GAME_MUSIC) do
        audio.loadFile(filepath, callback)
    end
    for _,filename in pairs(AUDIO_GAME_EFFECT) do
        local path = string.format(self.m_effectFullPath, filename)
        audio.loadFile(path, callback)
    end
end

function AudioMgr:isEffectEnabled()
    return Game:getSettingData():isEffectOn()
end

function AudioMgr:isMusicEnabled()
    return Game:getSettingData():isMusicOn()
end

function AudioMgr:toBackground(volume)
    if self:isMusicEnabled() then
        audio.setBGMVolume(volume)
    end
    if self:isEffectEnabled() then
        audio.setEffectVolume(volume)
    end
end

function AudioMgr:playEffect(filename, isLoop)
    if (self:isEffectEnabled() == false) or (filename == nil) then
        return 0
    end
    if type(filename) == "table" then
        return self:playEffectRand(fileName, isLoop)
    end
    local path = string.format(self.m_effectFullPath, filename)
    return audio.playEffect(path, isLoop)
end

function AudioMgr:playEffectRand(filelist, isLoop)
    if filelist == nil then
        return 0
    end
    local randIndx = math.random(1,#filelist)
	return self:playEffect(filelist[randIndx], isLoop) 
end

function AudioMgr:stopEffect(source)
    source:stop()
end

return AudioMgr