-- The steps after the live one on the map (nav.upcomingPins, off by
-- default): one small numbered pin per step, at its first open goal that has
-- a place, fading with how far ahead the step is. As many steps as
-- nav.upcomingCount, else as the guide window's Up next shows (ui.upcoming),
-- else UPCOMING_DEFAULT. Steps whose places lie together share one pin, its
-- number the first, its tooltip all of them. Through Polestar.Pins, layer
-- "nav.upcoming".
--
-- Their look is the player's (Options > Map pins, Nav/PinsOptions.lua;
-- Upcoming.Look, which the options' preview draws with too):
--   nav.upcomingMinimap   on the minimap too (on)
--   nav.upcomingCount     how many steps ahead (0: as many as Up next)
--   nav.stepPinSize       the pins' size (1: SIZE), their cap on screen with it
--   nav.stepNumbers       the step's number on its pin (on)
--   nav.stepNumberSize    the number's size (1: 0.6 of the pin)
--   nav.stepNumberColor   the number's colour (false: white)
--   nav.stepNumberOutline "OUTLINE" (the default), "THICKOUTLINE" or "NONE"
--   nav.stepColorMode     "accent" (the default), "steps" (a colour for each step
--                         ahead, Upcoming.PALETTE) or "own" (nav.stepColor)
--   nav.stepRingColor     the pins' rim (false: nav.medalColor, else white)
--   nav.stepAlpha         the next step's opacity (1)
--   nav.stepFadeTo        the farthest step's opacity (FADE_TO)
--   nav.stepMinimapSize   on the minimap, against their world map size (1: the same)

local ADDON, ns = ...
local Nav = ns.Nav
local L = ns.L

local Upcoming = {}
Nav.upcoming = Upcoming

local LAYER = "nav.upcoming"
local UPCOMING_DEFAULT = 5
local SIZE = 15
local NEAR = 0.6         -- map percent: places this close share a pin
local FADE_TO = 0.35     -- the last step's alpha

Upcoming.SIZE, Upcoming.FADE_TO = SIZE, FADE_TO
-- "steps": the n-th step ahead in the n-th of these Theme colours (round again past the last).
Upcoming.PALETTE = { "quest", "npc", "item", "skill", "spell", "faction", "place", "dungeon", "achievement", "rare" }

ns.RegisterDefaults("nav", {
	upcomingPins = false, upcomingMinimap = true, upcomingCount = 0,
	stepPinSize = 1, stepNumbers = true, stepNumberSize = 1, stepNumberColor = false, stepNumberOutline = "OUTLINE",
	stepColorMode = "accent", stepColor = false, stepRingColor = false, stepAlpha = 1, stepFadeTo = FADE_TO, stepMinimapSize = 1,
})

-- The settings a rebuild follows.
Upcoming.KEYS = {
	["nav.upcomingPins"] = true, ["nav.upcomingMinimap"] = true, ["nav.upcomingCount"] = true, ["ui.upcoming"] = true,
	["nav.stepPinSize"] = true, ["nav.stepNumbers"] = true, ["nav.stepNumberSize"] = true, ["nav.stepNumberColor"] = true,
	["nav.stepNumberOutline"] = true,
	["nav.stepColorMode"] = true, ["nav.stepColor"] = true, ["nav.stepRingColor"] = true, ["nav.stepAlpha"] = true,
	["nav.stepFadeTo"] = true, ["nav.stepMinimapSize"] = true,
}

local function accent()
	local T = ns.Theme
	if T and T.Accent then return T.Accent() end
	return 0.31, 0.82, 0.77
end

local function colorSetting(key)
	local c = ns.Get(key)
	if type(c) == "table" and type(c[1]) == "number" then return c end
	return nil
end

-- How many steps ahead get a pin.
function Upcoming.Count()
	local want = tonumber(ns.Get("nav.upcomingCount")) or 0
	if want <= 0 then want = tonumber(ns.Get("ui.upcoming")) or 0 end
	if want <= 0 then want = UPCOMING_DEFAULT end
	return want
end

-- The colour of the n-th step ahead (nav.stepColorMode): the player's own,
-- the step palette's, else the skin's pin fill (its pinFill token, Skin API
-- 2) or the accent.
function Upcoming.Color(n)
	local mode = ns.Get("nav.stepColorMode")
	local T = ns.Theme
	if mode == "own" then
		local c = colorSetting("nav.stepColor")
		if c then return c[1], c[2] or 1, c[3] or 1 end
	elseif mode == "steps" then
		local P = Upcoming.PALETTE
		if T and T.Color then
			local ok, r, g, b = pcall(T.Color, P[(n - 1) % #P + 1])
			if ok and type(r) == "number" then return r, g, b end
		end
	end
	if T and T.SkinToken then
		local r, g, b = T.SkinToken("pinFill")
		if r then return r, g, b end
	end
	return accent()
end

-- The pin fields for the n-th step ahead of `want` in the player's look:
-- color (alpha falling from nav.stepAlpha to nav.stepFadeTo), size, grow,
-- minimapSize, minimapGrow, textScale, textColor, rimColor; showNumber says
-- whether it carries its number. k: a pin size instead of nav.stepPinSize
-- (the options' size comparison). Shared with the options' preview.
function Upcoming.Look(n, want, k)
	local near = tonumber(ns.Get("nav.stepAlpha")) or 1
	local far = tonumber(ns.Get("nav.stepFadeTo")) or FADE_TO
	local a = want > 1 and near - (near - far) * (n - 1) / (want - 1) or near
	k = k or tonumber(ns.Get("nav.stepPinSize")) or 1
	local mk = k * (tonumber(ns.Get("nav.stepMinimapSize")) or 1)
	local r, g, b = Upcoming.Color(n)
	local outline = ns.Get("nav.stepNumberOutline")
	return {
		color = { r, g, b, a }, size = SIZE * k, grow = k, minimapSize = SIZE * mk, minimapGrow = mk,
		textScale = tonumber(ns.Get("nav.stepNumberSize")) or 1,
		textOutline = outline == "NONE" and "" or outline == "THICKOUTLINE" and outline or "OUTLINE",
		textColor = colorSetting("nav.stepNumberColor"), rimColor = colorSetting("nav.stepRingColor"),
	}, ns.Get("nav.stepNumbers") ~= false
end

-- The pins for the steps after the live one (pure on the Engine's views):
-- { { map, x, y, f, text, tooltip, color, size, grow, textScale, textColor, rimColor, priority, steps = { i, ... } }, ... }.
function Upcoming.Build()
	local E = ns.Engine
	local live = E and E.GetLiveStep and E.GetLiveStep()
	if not live then return {} end
	local want = Upcoming.Count()
	local count, pins, n = E.GetStepCount(), {}, 0
	for s = live + 1, count do
		if n >= want then break end
		local v = E.GetStepView(s, true)
		-- Numbered as the player counts the steps; one not theirs never shows (#942).
		local no, hidden = s, false
		if E.StepNumber then no, hidden = E.StepNumber(s) end
		if v and not hidden and v.status ~= "na" and v.status ~= "done" and v.status ~= "skipped" then
			n = n + 1
			for _, gv in ipairs(v.goals or {}) do
				if gv.map and gv.x and gv.y and (gv.status == "active" or gv.status == "pending") then
					local title = (v.title and v.title ~= "") and v.title or L["Step %d"]:format(no)
					local line = L["Step %d"]:format(no) .. ": " .. title
					local shared
					for _, p in ipairs(pins) do
						if p.map == gv.map and math.abs(p.x - gv.x) < NEAR and math.abs(p.y - gv.y) < NEAR then shared = p break end
					end
					if shared then
						shared.steps[#shared.steps + 1] = s
						shared.lines[#shared.lines + 1] = line
					else
						local p, numbered = Upcoming.Look(n, want)
						p.map, p.x, p.y, p.f = gv.map, gv.x, gv.y, gv.f
						p.text = numbered and tostring(no) or nil
						p.priority, p.steps, p.lines = 1, { s }, { line }
						pins[#pins + 1] = p
					end
					break
				end
			end
		end
	end
	for _, p in ipairs(pins) do
		local lines = p.lines
		p.tooltip = table.concat(lines, "\n")
		if #p.steps > 1 and p.text then p.text = p.text .. "+" end
	end
	return pins
end

function Upcoming.Refresh()
	local P = ns.Pins
	if not (P and P.SetLayer) then return end
	local pins = ns.Get("nav.upcomingPins") and Upcoming.Build() or nil
	if pins and #pins > 0 then
		P.SetLayer(LAYER, pins, { world = true, minimap = ns.Get("nav.upcomingMinimap") ~= false })
	else
		P.ClearLayer(LAYER)
	end
end

local scheduled = false
local function soon()
	if scheduled then return end
	scheduled = true
	ns.After(0, function()
		scheduled = false
		Upcoming.Refresh()
	end)
end

for _, msg in ipairs({ "STEP_CHANGED", "STEP_UPDATED", "GUIDE_CHANGED", "TABS_CHANGED" }) do ns.On(msg, soon) end
ns.On("SETTING_CHANGED", function(path)
	if Upcoming.KEYS[path] or path == "nav" or path == "ui" or path == "" then soon() end
end)
-- The accent (and the palette) follow the theme.
if type(ns.Theme) == "table" and type(ns.Theme.OnChanged) == "function" then
	ns.Theme.OnChanged(function()
		if ns.Get("nav.upcomingPins") then soon() end
	end)
end
ns.OnLogin(soon)
