-- Sound effects through PlaySoundFile. WoW can't set per-sound volume, so distant
-- sounds are culled instead of attenuated (Doom's clipping distance is 1200 units).
local D = FreedoomArcade
local Sound = {}
D.Sound = Sound

local path = D.ADDON_PATH .. "snd\\"
local CLIPPING_DIST = 1200
local MAX_CHANNELS = 8
local links = { chgun = "pistol" }

local playing = {} -- origin -> handle
local order = {}   -- recent handles for channel limiting
Sound.enabled = true
Sound.channel = "SFX"

local function stopOrigin(origin)
	local h = playing[origin]
	if h then
		if StopSound then StopSound(h) end
		playing[origin] = nil
	end
end

function Sound.Start(origin, sfx)
	if not Sound.enabled or not sfx or sfx == 0 then return end
	local name = D.sfxnames[sfx]
	if not name then return end
	if not D.SOUNDFILES[name] then
		name = links[name]
		if not name or not D.SOUNDFILES[name] then return end
	end
	local player = D.G.player
	local listener = player and player.mo
	if origin and listener and origin ~= listener then
		local dist = D.AproxDistance(origin.x - listener.x, origin.y - listener.y)
		if dist > CLIPPING_DIST then return end
	end
	if origin then stopOrigin(origin) end
	local ok, handle = PlaySoundFile(path .. name .. ".ogg", Sound.channel)
	if ok and handle then
		if origin then playing[origin] = handle end
		order[#order + 1] = handle
		if #order > MAX_CHANNELS then
			local old = table.remove(order, 1)
			if StopSound then StopSound(old) end
		end
	end
end

function Sound.Stop(origin)
	stopOrigin(origin)
end

function Sound.LevelStart()
	for k in pairs(playing) do playing[k] = nil end
	for i = #order, 1, -1 do order[i] = nil end
end

D.S_StartSound = Sound.Start
D.S_StopSound = Sound.Stop
