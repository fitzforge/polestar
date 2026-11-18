-- The Ground trail page of Polestar's settings window (Guiding, after Map;
-- key "groundtrail"; docs/ARCHITECTURE.md, "Maps"): the optional in-world
-- trail's switch and every setting of its look (Nav/WorldTrail.lua), in the
-- same searchable rows as every other page. /polestar trail opens it
-- (UI.ShowOptions("groundtrail")). Its look never changes the map sparkles.
-- A plain page, not one of the Look group's: those are each a live preview
-- band with every setting lit on it, which the trail does not have.
--
-- One tab, Trail: Ground trail (on/off in the header; indoors, Fit to view),
-- Trail shape, Sparkles, Looks.

local ns = Polestar
-- Without the trail's settings (Nav/WorldTrail.lua) there is nothing to set.
if not (ns.WorldTrail and ns.RegisterOptions) then return end

local L = ns.L

local PAGE, KEY, ORDER, ICON = L["Ground trail"], "groundtrail", 35, "icon-goto"
local TAB = L["Trail"]
local SUBTITLE = L["Beta. Optional sparkles on the ground ahead of you, along the current route."]

local function register(section, controls, extra)
	local spec = { page = PAGE, key = KEY, icon = ICON, order = ORDER, subtitle = SUBTITLE,
		tab = TAB, section = section, controls = controls }
	for k, v in pairs(extra or {}) do spec[k] = v end
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

local function ready() return ns.WorldTrail ~= nil end
local function off() return not (ready() and ns.WorldTrail.Settings().enabled) end
-- The trail may not set the game's waypoint: nothing reads the camera's angle for it.
local function blind() return ready() and not ns.Get("nav.worldTrailWaypoint") end
local function percent(v) return math.floor(v * 100 + 0.5) .. "%" end
local function distance(v) return ns.FormatDistance(v, { decimals = 1 }) end
local function length(v) return ns.FormatDistance(v) end
local function px(v) return L["%d px"]:format(math.floor(v + 0.5)) end
local function noLook()
	local look = ns.Get("nav.worldTrailCustomLook")
	return not (ready() and type(look) == "table" and next(look) ~= nil)
end

-- The Look row: every look by name, the saved one once there is one, and
-- "Custom" while the values match none of them (it is what the row then
-- shows; picking it changes nothing). It has no setting of its own: it reads
-- which look the values make, and a right-click (set(nil)) puts the default
-- look back.
local function lookChoices()
	local out = {}
	if not ready() then return out end
	local T = ns.WorldTrail
	for i, name in ipairs(T.LOOKS) do out[i] = { value = name, label = T.LOOK_INFO[name].label } end
	if not noLook() then out[#out + 1] = { value = "mine", label = L["Your saved look"] } end
	if T.CurrentLook() == "custom" then out[#out + 1] = { value = "custom", label = L["Custom"] } end
	return out
end

register(L["Ground trail"], {
	{ kind = "toggle", key = "nav.worldTrailWaypoint", label = L["Use the game's waypoint for the trail"], disabled = off, wide = true,
		search = "map pin, waypoint, camera, tilt, angle, marker, beta",
		help = L["The game does not tell an addon how the camera is tilted, so Polestar sets the game's waypoint where the route leads and reads the angle from its marker. While the trail is on, that marker takes the place of the game's quest marker and of a map pin of your own, and quests you accept are not tracked by the game. Switched off, the trail is drawn short once you have moved the camera. On by default."] },
	{ kind = "dropdown", label = L["Look"], disabled = off, choices = lookChoices,
		get = function() return ns.WorldTrail.CurrentLook() end,
		set = function(name) ns.WorldTrail.ApplyPreset(name or ns.WorldTrail.LOOKS[1]) end,
		search = "preset, style, theme, stardust, breadcrumbs, whisper, ribbon, lantern, witcher, fairy, fel",
		help = L["A ready-made look in one click. It sets the shape and sparkles below, which stay yours to tune, and never turns the trail on. Right-click for the default look."] },
	{ kind = "toggle", key = "nav.worldTrailIndoors", label = L["Show indoors"], disabled = off,
		help = L["Also draw inside buildings. Camera collision and stacked floors can make placement less accurate."] },
	{ kind = "toggle", key = "nav.worldTrailSight", label = L["Fit to view"], disabled = off,
		help = L["Use the walking maps to shorten and grow the trail smoothly near walls and turns. This is an estimate, not true occlusion; unknown terrain keeps the current reach."] },
}, { toggle = { kind = "toggle", key = "nav.worldTrail", label = L["Ground trail"],
	help = L["An optional sparkle trail ahead of you, following the current route. Beta: camera and terrain placement are estimates, not a guarantee that every surface or wall is exact, and while it is on Polestar sets the game's waypoint to read the camera's angle from. Off by default."] } })

-- The warning, in the page and not in a window: while the trail's waypoint is switched off.
register(L["The trail cannot read the camera"], {
	{ kind = "button", button = L["Turn on"], wide = true,
		label = L["The trail's waypoint is off. The trail reads the camera's angle from it, and without it the trail is drawn short once you have moved the camera."],
		needs = ready, onClick = function() ns.Set("nav.worldTrailWaypoint", true) end,
		help = L["Turns on \"Use the game's waypoint for the trail\", above."] },
}, { shown = blind })

register(L["Trail shape"], {
	{ kind = "slider", key = "nav.worldTrailLength", label = L["Maximum length"], min = 10, max = 200, step = 5, format = length, disabled = off,
		help = L["The farthest the ground trail reaches. Fit to view may make it shorter."] },
	{ kind = "slider", key = "nav.worldTrailGap", label = L["Sparkle spacing"], min = 0.3, max = 8, step = 0.1, format = distance, disabled = off,
		help = L["Distance between ground sparkles. Lower is denser; map trail density is separate."] },
	{ kind = "slider", key = "nav.worldTrailWidth", label = L["Width at your feet"], min = 0, max = 3, step = 0.1, format = distance, disabled = off,
		help = L["How far sparkles spread to either side near you, narrowing into the route."] },
	{ kind = "slider", key = "nav.worldTrailAhead", label = L["Starts ahead of you"], min = 0, max = 10, step = 0.1, format = distance, disabled = off,
		help = L["Leave this much space before the trail starts, so it does not cover your character."] },
	{ kind = "slider", key = "nav.worldTrailFade", label = L["Fades away"], min = 0, max = 1, step = 0.05, format = percent, disabled = off,
		help = L["How much the trail fades toward its far end. At 100% it is brightest close to you."] },
	{ kind = "slider", key = "nav.worldTrailLift", label = L["Height offset"], min = -3, max = 3, step = 0.1, format = distance, disabled = off,
		help = L["Raise or lower the camera-estimated trail when it floats above or sinks below the ground."] },
})

register(L["Sparkles"], {
	{ kind = "slider", key = "nav.worldTrailIntensity", label = L["Brightness"], min = 0, max = 1, step = 0.05, format = percent, disabled = off,
		help = L["How bright each ground sparkle and its glow are. This does not change map sparkles."] },
	{ kind = "slider", key = "nav.worldTrailSubtlety", label = L["Sparkle subtlety"], min = 0, max = 1, step = 0.05, format = percent, disabled = off,
		help = L["Smaller, dimmer, calmer twinkles that drift less; no glow at 100%."] },
	{ kind = "slider", key = "nav.worldTrailSize", label = L["Sparkle size"], min = 6, max = 28, step = 1, format = px, disabled = off,
		help = L["Ground sparkle size before subtlety and perspective scaling."] },
	{ kind = "slider", key = "nav.worldTrailFlow", label = L["Flow toward goal"], min = 0, max = 1, step = 0.05, format = percent, disabled = off,
		help = L["How fast the sparkles drift toward the goal; 0 holds them still."] },
	{ kind = "slider", key = "nav.worldTrailMax", label = L["Most sparkles shown"], min = 10, max = 400, step = 10, format = "%d", disabled = off,
		help = L["A ceiling for the ground trail, whatever the spacing. The map trails have their own ceiling."] },
	{ kind = "dropdown", key = "nav.worldTrailColor", label = L["Sparkle colour"], disabled = off,
		choices = {
			{ value = "gold", label = L["Loot gold"] }, { value = "arcane", label = L["Arcane blue"] },
			{ value = "fel", label = L["Fel green"] }, { value = "rose", label = L["Rose"] }, { value = "white", label = L["Starlight"] },
		} },
})

register(L["Looks"], {
	{ kind = "button", button = L["Save"], label = L["Save custom look"], needs = ready, onClick = function() ns.WorldTrail.SaveLook() end,
		help = L["Save the current sparkle appearance and trail shape as your own look; Look then lists it as Your saved look. Enable, indoor visibility, Fit to view and the sprite ceiling stay independent."] },
	{ kind = "button", button = L["Reset"], label = L["Reset ground trail"], icon = "reset", needs = ready, confirm = true,
		onClick = function() ns.WorldTrail.Reset() end,
		help = L["Reset only ground-trail settings and the saved custom look. Turns the ground trail off; map trails and other Polestar settings are unchanged."] },
})

-- The Look row shows a value worked out from the others, so it is repainted
-- when any of them changes (a slider moved, a look saved, a reset).
ns.On("SETTING_CHANGED", function(path)
	if not (ready() and ns.UI and ns.UI.Options and ns.UI.Options.Controls) then return end
	if not (path == nil or path == "" or path == "nav" or path:find("nav.worldTrail", 1, true) == 1) then return end
	local row = ns.UI.Options.Controls(KEY, TAB)[L["Look"]]
	if row and row.Refresh then row:Refresh() end
end)
