-- The steps after the live one on the map (nav.upcomingPins, off by
-- default): one small numbered pin per step, at its first open goal that has
-- a place, fading with how far ahead the step is. As many steps as the guide
-- window's Up next shows (ui.upcoming), else UPCOMING_DEFAULT. Steps whose
-- places lie together share one pin, its number the first, its tooltip all
-- of them. Through Polestar.Pins, layer "nav.upcoming".

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

ns.RegisterDefaults("nav", { upcomingPins = false })

local function accent()
	local T = ns.Theme
	if T and T.Accent then return T.Accent() end
	return 0.31, 0.82, 0.77
end

-- The pins for the steps after the live one (pure on the Engine's views):
-- { { map, x, y, f, text, tooltip, color, size, priority, steps = { i, ... } }, ... }.
function Upcoming.Build()
	local E = ns.Engine
	local live = E and E.GetLiveStep and E.GetLiveStep()
	if not live then return {} end
	local want = tonumber(ns.Get("ui.upcoming")) or 0
	if want <= 0 then want = UPCOMING_DEFAULT end
	local count, pins, n = E.GetStepCount(), {}, 0
	local r, g, b = accent()
	for s = live + 1, count do
		if n >= want then break end
		local v = E.GetStepView(s)
		if v and v.status ~= "na" and v.status ~= "done" and v.status ~= "skipped" then
			n = n + 1
			for _, gv in ipairs(v.goals or {}) do
				if gv.map and gv.x and gv.y and (gv.status == "active" or gv.status == "pending") then
					local title = (v.title and v.title ~= "") and v.title or L["Step %d"]:format(s)
					local line = L["Step %d"]:format(s) .. ": " .. title
					local shared
					for _, p in ipairs(pins) do
						if p.map == gv.map and math.abs(p.x - gv.x) < NEAR and math.abs(p.y - gv.y) < NEAR then shared = p break end
					end
					if shared then
						shared.steps[#shared.steps + 1] = s
						shared.lines[#shared.lines + 1] = line
					else
						local a = want > 1 and 1 - (1 - FADE_TO) * (n - 1) / (want - 1) or 1
						pins[#pins + 1] = { map = gv.map, x = gv.x, y = gv.y, f = gv.f, text = tostring(s), size = SIZE,
							color = { r, g, b, a }, priority = 1, steps = { s }, lines = { line } }
					end
					break
				end
			end
		end
	end
	for _, p in ipairs(pins) do
		local lines = p.lines
		p.tooltip = table.concat(lines, "\n")
		if #p.steps > 1 then p.text = p.text .. "+" end
	end
	return pins
end

function Upcoming.Refresh()
	local P = ns.Pins
	if not (P and P.SetLayer) then return end
	local pins = ns.Get("nav.upcomingPins") and Upcoming.Build() or nil
	if pins and #pins > 0 then
		P.SetLayer(LAYER, pins, { world = true, minimap = true })
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
	if path == "nav.upcomingPins" or path == "ui.upcoming" or path == "nav" or path == "ui" or path == "" then soon() end
end)
ns.OnLogin(soon)
