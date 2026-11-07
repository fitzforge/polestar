-- Native world-trail settings. Map trails remain owned by Nav/Pins.
local ADDON, ns = ...
local W = {}
ns.WorldTrail = W

-- Standalone runtime field -> native nav setting (no external saved table).
W.SETTINGS = {
	enabled = "worldTrail", intensity = "worldTrailIntensity", subtlety = "worldTrailSubtlety",
	size = "worldTrailSize", speed = "worldTrailFlow", maxSparkles = "worldTrailMax",
	color = "worldTrailColor", groundLength = "worldTrailLength", groundFade = "worldTrailFade",
	groundIndoors = "worldTrailIndoors", groundLift = "worldTrailLift", groundGap = "worldTrailGap",
	groundWidth = "worldTrailWidth", groundAhead = "worldTrailAhead", groundSight = "worldTrailSight",
}
W.DEFAULTS = {
	enabled = false, intensity = 0.75, subtlety = 0.35, size = 14, speed = 0.5,
	maxSparkles = 200, color = "gold", groundLength = 30, groundFade = 1,
	groundIndoors = false, groundLift = 0, groundGap = 1.7, groundWidth = 1,
	groundAhead = 3, groundSight = true,
}
local defaults = { worldTrailCustomLook = {} }
for key, setting in pairs(W.SETTINGS) do defaults[setting] = W.DEFAULTS[key] end
ns.RegisterDefaults("nav", defaults)

W.LIMITS = {
	intensity = { 0, 1 }, subtlety = { 0, 1 }, size = { 6, 28 }, speed = { 0, 1 },
	maxSparkles = { 10, 400 }, groundLength = { 10, 200 }, groundFade = { 0, 1 },
	groundLift = { -3, 3 }, groundGap = { 0.3, 8 }, groundWidth = { 0, 3 }, groundAhead = { 0, 10 },
}
W.COLORS = {
	{ key = "gold", label = ns.L["Loot gold"], rgb = { 1, 0.84, 0.38 } },
	{ key = "arcane", label = ns.L["Arcane blue"], rgb = { 0.55, 0.75, 1 } },
	{ key = "fel", label = ns.L["Fel green"], rgb = { 0.55, 1, 0.45 } },
	{ key = "rose", label = ns.L["Rose"], rgb = { 1, 0.55, 0.75 } },
	{ key = "white", label = ns.L["Starlight"], rgb = { 1, 1, 1 } },
}

function W.Clamp(v, lo, hi)
	if type(v) ~= "number" or v ~= v then return lo end
	if v < lo then return lo elseif v > hi then return hi end
	return v
end

function W.ColorOf(key)
	for _, color in ipairs(W.COLORS) do
		if color.key == key then return color end
	end
	return W.COLORS[1]
end

local function sanitize(key, value)
	local default = W.DEFAULTS[key]
	if type(value) ~= type(default) then return default end
	if type(value) == "number" then
		if value ~= value or value == math.huge or value == -math.huge then return default end
		local range = W.LIMITS[key]
		value = W.Clamp(value, range[1], range[2])
		if key == "maxSparkles" then value = math.floor(value + 0.5) end
	elseif key == "color" then
		value = W.ColorOf(value).key
	end
	return value
end

function W.Settings()
	local db = {
		density = 5, ground = true, groundMode = "camera", groundStart = 0.4,
		minimap = false, worldmap = false, wholeRoute = false,
	}
	for key, setting in pairs(W.SETTINGS) do
		db[key] = sanitize(key, ns.Get("nav." .. setting))
	end
	return db
end

-- Appearance only: never enable, change visibility policy, or touch map trails.
W.LOOKS = { "lantern", "whisper", "witcher", "breadcrumbs", "ribbon", "fairy", "fel" }
W.LOOK_KEYS = { "intensity", "subtlety", "size", "speed", "groundFade", "groundLength",
	"groundWidth", "groundGap", "groundAhead", "color" }
W.PRESETS = {
	lantern = { intensity = 1, subtlety = 0.35, size = 14, speed = 0.5, groundFade = 1, groundLength = 30,
		groundWidth = 2, groundGap = 0.5, groundAhead = 5, color = "gold" },
	whisper = { intensity = 0.55, subtlety = 0.75, size = 11, speed = 0.3, groundFade = 1, groundLength = 18,
		groundWidth = 0.8, groundGap = 1.2, groundAhead = 4, color = "gold" },
	witcher = { intensity = 0.9, subtlety = 0.5, size = 13, speed = 0.35, groundFade = 1, groundLength = 22,
		groundWidth = 2.6, groundGap = 0.4, groundAhead = 3.5, color = "white" },
	breadcrumbs = { intensity = 1, subtlety = 0.2, size = 16, speed = 0, groundFade = 0.7, groundLength = 35,
		groundWidth = 0, groundGap = 3, groundAhead = 4, color = "gold" },
	ribbon = { intensity = 0.85, subtlety = 0.45, size = 12, speed = 0.7, groundFade = 0.9, groundLength = 45,
		groundWidth = 0.5, groundGap = 0.3, groundAhead = 4, color = "arcane" },
	fairy = { intensity = 1, subtlety = 0, size = 17, speed = 0.9, groundFade = 1, groundLength = 28,
		groundWidth = 1.6, groundGap = 0.6, groundAhead = 4, color = "rose" },
	fel = { intensity = 1, subtlety = 0.25, size = 14, speed = 0.6, groundFade = 1, groundLength = 30,
		groundWidth = 1.4, groundGap = 0.7, groundAhead = 4, color = "fel" },
}

local updating = false
function W.ApplyPreset(name)
	if type(name) ~= "string" then return false end
	local look = name == "mine" and ns.Get("nav.worldTrailCustomLook") or W.PRESETS[name]
	if type(look) ~= "table" then return false end
	local present = false
	for _, key in ipairs(W.LOOK_KEYS) do
		if look[key] ~= nil then present = true end
	end
	if not present then return false end
	updating = true
	for _, key in ipairs(W.LOOK_KEYS) do
		ns.Set("nav." .. W.SETTINGS[key], sanitize(key, look[key]))
	end
	updating = false
	W.Refresh()
	return true
end

function W.SaveLook()
	local db, look, copy = W.Settings(), {}, {}
	for _, key in ipairs(W.LOOK_KEYS) do look[key], copy[key] = db[key], db[key] end
	ns.Set("nav.worldTrailCustomLook", look)
	return copy
end

function W.Reset()
	updating = true
	for _, setting in pairs(W.SETTINGS) do ns.Set("nav." .. setting, nil) end
	ns.Set("nav.worldTrailCustomLook", nil)
	updating = false
	W.Refresh()
end

function W.Refresh()
	W.db = W.Settings()
	-- Rebuild also clears an existing trail when disabled; it must not create
	-- rendering work before login or while disabled (the runtime owns that).
	if W.Render and W.Render.Rebuild then W.Render.Rebuild() end
end
ns.OnInit(W.Refresh)

local paths = {}
for _, setting in pairs(W.SETTINGS) do paths["nav." .. setting] = true end
ns.On("SETTING_CHANGED", function(path)
	if not updating and (path == "" or path == "nav" or paths[path]) then W.Refresh() end
end)

local L = ns.L
ns.RegisterCommand("trail", function(rest)
	local action = rest:lower()
	if action == "" then
		ns.Fire("SHOW_OPTIONS", "groundtrail")
		return
	end
	if action == "on" or action == "off" then
		ns.Set("nav.worldTrail", action == "on")
	elseif action ~= "status" then
		ns.Print(L["Usage: /polestar trail [on|off|status]"])
		return
	end
	ns.Print((L["World trail: %s"]):format(W.Settings().enabled and L["on"] or L["off"]))
end, L["Open world-trail settings, or turn the trail on or off"])
