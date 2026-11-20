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
	-- Whether Polestar sets the game's waypoint for the trail to read the camera's angle from (Nav/Bridges.lua).
	waypoint = "worldTrailWaypoint",
}
-- The look a trail first turned on has: short and wide near the feet, starting
-- well ahead of the character so it never covers them, half faded at its far
-- end and drifting briskly toward the goal.
W.DEFAULTS = {
	enabled = false, intensity = 0.75, subtlety = 0.35, size = 14, speed = 0.7,
	maxSparkles = 200, color = "gold", groundLength = 20, groundFade = 0.5,
	groundIndoors = false, groundLift = 0, groundGap = 1.4, groundWidth = 2.6,
	groundAhead = 6.5, groundSight = true, waypoint = true,
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
-- LOOKS in the order the Look row lists them, the default look first; QUICK
-- are the few the introduction offers as cards (UI/WorldTrailIntro.lua).
W.LOOKS = { "stardust", "breadcrumbs", "whisper", "ribbon", "lantern", "witcher", "fairy", "fel" }
W.QUICK = { "stardust", "breadcrumbs", "whisper", "ribbon" }
W.LOOK_KEYS = { "intensity", "subtlety", "size", "speed", "groundFade", "groundLength",
	"groundWidth", "groundGap", "groundAhead", "color" }
W.PRESETS = {
	stardust = {}, -- the default look: W.DEFAULTS' own values, filled in below
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
for _, key in ipairs(W.LOOK_KEYS) do W.PRESETS.stardust[key] = W.DEFAULTS[key] end
-- Each look's name and what it is like, for the Look row and the cards.
W.LOOK_INFO = {
	stardust = { label = ns.L["Stardust"], note = ns.L["A short, wide drift of gold that starts a few steps ahead of you. The default."] },
	breadcrumbs = { label = ns.L["Breadcrumbs"], note = ns.L["Still, sparse gold glints along the way."] },
	whisper = { label = ns.L["Whisper"], note = ns.L["A faint, short thread."] },
	ribbon = { label = ns.L["Ribbon"], note = ns.L["A long, flowing arcane-blue trail."] },
	lantern = { label = ns.L["Lantern"], note = ns.L["Bright gold, wide near your feet, fading over a short trail."] },
	witcher = { label = ns.L["Witcher"], note = ns.L["A broad pale scatter close in, fading fast."] },
	fairy = { label = ns.L["Fairy"], note = ns.L["Lively rose sparkles that dance toward the goal."] },
	fel = { label = ns.L["Fel"], note = ns.L["Green sparkles with a short, fading trail."] },
}

local function same(a, b)
	if type(a) == "number" and type(b) == "number" then return math.abs(a - b) < 1e-6 end
	return a == b
end

-- The look the trail has now: a look's name while every value it sets still
-- holds, "mine" for the saved look, "custom" once any of them has been tuned.
function W.CurrentLook()
	local db = W.Settings()
	local function is(look)
		for _, key in ipairs(W.LOOK_KEYS) do
			if not same(sanitize(key, look[key]), db[key]) then return false end
		end
		return true
	end
	for _, name in ipairs(W.LOOKS) do
		if is(W.PRESETS[name]) then return name end
	end
	local mine = ns.Get("nav.worldTrailCustomLook")
	if type(mine) == "table" and next(mine) ~= nil and is(mine) then return "mine" end
	return "custom"
end

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
	if action == "probe" then
		-- What the camera estimate is working from this moment, for a bug report.
		-- Diagnostic values, not prose: left untranslated like debug output.
		local p = W.Render and W.Render.Probe and W.Render.Probe() or {}
		local function n(v) return type(v) == "number" and ("%.2f"):format(v) or tostring(v) end
		local rate = type(p.mouseTilt) == "number" and ("%.5f from %s"):format(p.mouseTilt, tostring(p.mouseFrom))
			or p.cursor and ("not learnt yet (cursor went %s while the character turned %s)"):format(n(p.cursorTravel), n(p.cursorTurned))
			or "no cursor travel here"
		local anchor = p.anchor and ("%s, followed %s since"):format(p.anchor, n(p.strayed or 0)) or "nothing yet"
		local feet = p.air and ("%s, %s up"):format(p.air, n(p.airHeight)) or "on the ground"
		local route = not p.noWay and "" or p.clear and ("; no way found to the goal, its line walkable for %s yd"):format(n(p.clear))
			or "; no way found to the goal, nothing against walking its line"
		-- How the game pins a marker whose place is not far off is not recorded: the two readings settle it.
		local pins = (p.pinReads or p.pinReadsBack) and (", the pinned marker reads %s by its bearing from the character and %s from the camera%s"):format(
			p.pinReads and n(p.pinReads) or "nothing", p.pinReadsBack and n(p.pinReadsBack) or "nothing", p.pinNear and " (too near to go by)" or "") or ""
		ns.Print(("trail probe: mode %s (the trail's waypoint %s), trail %s; tilt %s, pitch %s, yaw %s, facing %s, from %s; tracking %s, marker %s, %s%s, bearing %s, lift %s, height %s, flat %s; mouse tilt %s; pitch fixed by %s; feet %s (jump key %s); smart pivot %s; saved pitch %s; pinning rule %s%s; zoom %s, fov %s, scale %s%s, heights %s%s; %s"):format(
			tostring(p.mode), W.Settings().waypoint and "on" or "off", tostring(p.trail), tostring(p.tilt), n(p.pitch), n(p.yaw), n(p.facing), tostring(p.source), tostring(p.tracking), n(p.markerX), n(p.markerY),
			p.offScreen and " (off screen)" or "", n(p.markerBearing), n(p.lift), n(p.height), n(p.flat), rate, anchor, feet,
			p.jumpKeys and "readable" or "not readable", p.smartPivot and "on" or "off", tostring(p.savedPitch),
			tostring(p.pinRule), pins, n(p.zoom), n(p.fov), n(p.scaleUsed), p.scale and (" (%s by the pin's marker)"):format(n(p.scale)) or "",
			tostring(p.heightSource), route, p.why and "not drawn: " .. tostring(p.why) or "drawn"))
		return
	end
	if action == "record" then
		-- A timed recording of the game's waypoint marker, for a bug report (Maps/WorldTrailRender.lua).
		if W.Render and W.Render.Record then W.Render.Record() end
		return
	end
	if action == "intro" then
		-- The trail's introduction again (UI/WorldTrailIntro.lua).
		ns.Fire("SHOW_TRAIL_INTRO")
		return
	end
	if action == "on" or action == "off" then
		ns.Set("nav.worldTrail", action == "on")
	elseif action ~= "status" then
		ns.Print(L["Usage: /polestar trail [on|off|status|intro|probe]"])
		return
	end
	ns.Print((L["World trail: %s"]):format(W.Settings().enabled and L["on"] or L["off"]))
end, L["Open world-trail settings, or turn the trail on or off"])
