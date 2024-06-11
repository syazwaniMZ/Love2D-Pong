local Sound = {active = {}, source = {}}


function Sound:init(id, source, soundType)
    assert(self.source[id] == nil, "Sound with that ID already exists!")

    if source == nil then
        print("Source is nil")
    elseif type(source) == "table" then
        self.source[id] = {}
        for i = 1, #source do
            self.source[id][i] = love.audio.newSource(source[i], soundType)
        end
    else
        self.source[id] = love.audio.newSource(source, soundType)
    end
end

-- Assign sound to specific channel or else assign to default channel
function Sound:play(id, channel, volume, pitch, loop)
    local source
    if type(Sound.source[id]) == "table" then
        source = Source.source[id][math.random(1, #Sound.source[id])]
    else
        source = Sound.source[id]
    end

    local channel = channel or "default"
    local clone = source:clone() -- To avoid breaking when the sound is already playing and avoid memory leak
    clone:setVolume(volume or 1)
    clone:setPitch(pitch or 1)
    clone:setLooping(loop or false)
    clone:play()

    if Sound.active[channel] == nil then
        Sound.active[channel] = {}
    end

    table.insert(Sound.active[channel], clone)

    return clone
end

function Sound:setVolume(channel, volume)
    assert(Sound.active[channel] ~= nil, "Channel does not exist!")
    for k, channel in pairs(Sound.active[channel]) do
        clone:setVolume(volume)
    end 
end

function Sound:setPitch(channel, pitch)
    assert(Sound.active[channel] ~= nil, "Channel does not exist!")
    for k, channel in pairs(Sound.active[channel]) do
        clone:setPitch(pitch)
    end 
end

function Sound:stop(channel)
    assert(Sound.active[channel] ~= nil, "Channel does not exist!")
    for k, channel in pairs(Sound.active[channel]) do
        sound:stop()
    end
end

function Sound:update()
    for k, channel in pairs(Sound.active) do
        -- print(#channel)
        if channel[1] ~= nil and not channel[1]:isPlaying() then
            table.remove(channel, 1)
        end
    end
end

function Sound:clean(id)
    self.source[id] = nil
end

return Sound