-- The optional world trail uses the same searchable, scrolling controls as
-- every other Polestar option. Its appearance never changes map sparkles.
local ADDON, ns = ...
local L = ns.L

local function ready() return ns.WorldTrail ~= nil end
local function off() return not (ready() and ns.WorldTrail.Settings().enabled) end
local function percent(v) return math.floor(v * 100 + 0.5) .. "%" end
local function distance(v) return ns.FormatDistance(v, { decimals = 1 }) end
local function length(v) return ns.FormatDistance(v) end
local function px(v) return L["%d px"]:format(math.floor(v + 0.5)) end
local function preset(name) return function() ns.WorldTrail.ApplyPreset(name) end end
local function noLook()
	local look = ns.Get("nav.worldTrailCustomLook")
	return not (ready() and type(look) == "table" and next(look) ~= nil)
end

ns.RegisterOptions({ page = L["Appearance"], tab = L["Ground trail"], section = L["In the world"], controls = {
	{ kind = "toggle", key = "nav.worldTrail", label = L["Ground trail"],
		help = L["An optional sparkle trail ahead of you, following the current route. Camera and terrain placement are estimates, not a guarantee that every surface or wall is exact. Off by default."] },
	{ kind = "toggle", key = "nav.worldTrailIndoors", label = L["Show indoors"], disabled = off,
		help = L["Also draw inside buildings. Camera collision and stacked floors can make placement less accurate."] },
	{ kind = "toggle", key = "nav.worldTrailSight", label = L["Fit to view"], disabled = off,
		help = L["Use the walking maps to shorten and grow the trail smoothly near walls and turns. This is an estimate, not true occlusion; unknown terrain keeps the current reach."] },
} })

ns.RegisterOptions({ page = L["Appearance"], tab = L["Ground trail"], section = L["Trail shape"], controls = {
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
} })

ns.RegisterOptions({ page = L["Appearance"], tab = L["Ground trail"], section = L["Sparkles"], controls = {
	{ kind = "slider", key = "nav.worldTrailIntensity", label = L["Brightness"], min = 0, max = 1, step = 0.05, format = percent, disabled = off,
		help = L["How bright each ground sparkle and its glow are. This does not change map sparkles."] },
	{ kind = "slider", key = "nav.worldTrailSubtlety", label = L["Subtlety"], min = 0, max = 1, step = 0.05, format = percent, disabled = off,
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
} })

ns.RegisterOptions({ page = L["Appearance"], tab = L["Ground trail"], section = L["Looks"], controls = {
	{ kind = "button", label = L["Lantern"], needs = ready, onClick = preset("lantern"),
		help = L["Bright gold, wide near your feet, fading over a short trail. A look never turns the trail on or changes indoor visibility."] },
	{ kind = "button", label = L["Whisper"], needs = ready, onClick = preset("whisper"), help = L["A faint, short thread."] },
	{ kind = "button", label = L["Witcher"], needs = ready, onClick = preset("witcher"), help = L["A broad pale scatter close in, fading fast."] },
	{ kind = "button", label = L["Breadcrumbs"], needs = ready, onClick = preset("breadcrumbs"), help = L["Still, sparse gold glints along the way."] },
	{ kind = "button", label = L["Ribbon"], needs = ready, onClick = preset("ribbon"), help = L["A long, flowing arcane-blue trail."] },
	{ kind = "button", label = L["Fairy"], needs = ready, onClick = preset("fairy"), help = L["Lively rose sparkles that dance toward the goal."] },
	{ kind = "button", label = L["Fel"], needs = ready, onClick = preset("fel"), help = L["Green sparkles with a short, fading trail."] },
	{ kind = "button", label = L["Save custom look"], needs = ready, onClick = function() ns.WorldTrail.SaveLook() end,
		help = L["Save the current sparkle appearance and trail shape. Enable, indoor visibility, Fit to view and the sprite ceiling stay independent."] },
	{ kind = "button", label = L["Use custom look"], needs = ready, disabled = noLook, onClick = preset("mine"),
		help = L["Restore the appearance and shape saved with Save custom look, without turning the trail on."] },
	{ kind = "button", label = L["Reset ground trail"], icon = "reset", needs = ready, confirm = true,
		onClick = function() ns.WorldTrail.Reset() end,
		help = L["Reset only ground-trail settings and the saved custom look. Turns the ground trail off; map trails and other Polestar settings are unchanged."] },
} })
