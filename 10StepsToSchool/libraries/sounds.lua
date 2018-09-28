local _M = {}

_M.isSoundOn = true
_M.isMusicOn = true

local sounds = {
    onClick = 'audio/button_press.wav',
    onComplete = 'audio/routine_complete.wav'
}

local audioChannel, otherAudioChannel, currentStreamSound = 1, 2
function _M.playStream(sound, force)
    if not _M.isMusicOn then return end
    if not sounds[sound] then
        print('sounds: no such sound: ' .. tostring(sound))
        return
    end
    sound = sounds[sound]
    if currentStreamSound == sound and not force then return end
    audio.fadeOut({channel = audioChannel, time = 1000})
    audioChannel, otherAudioChannel = otherAudioChannel, audioChannel
    audio.setVolume(0.5, {channel = audioChannel})
    audio.play(audio.loadStream(sound), {channel = audioChannel, loops = -1, fadein = 1000})
    currentStreamSound = sound
end
audio.reserveChannels(2)

local loadedSounds = {}
local function loadSound(sound)
    if not loadedSounds[sound] then
        loadedSounds[sound] = audio.loadSound(sounds[sound])
    end
    return loadedSounds[sound]
end

function _M.play(sound, params)
    if not _M.isSoundOn then return end
    if not sounds[sound] then
        print('sounds: no such sound: ' .. tostring(sound))
        return
    end
    return audio.play(loadSound(sound), params)
end

function _M.stop()
    currentStreamSound = nil
    audio.stop()
end

return _M
