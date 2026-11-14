-- Trackers: how Polestar's small always-there panels look and when they
-- show. The options page and its previews are in the settings window's
-- addon (Polestar_Options, UI/Looks/Trackers.lua: Options > Look > Trackers).
--
-- The trackers: the flight timer (Maps/FlightTimer.lua), the instance
-- tracker (Maps/Instances.lua), the party panel (UI/PartyPanel.lua) and the
-- guide's level mark on the game's XP bar (QoL/XPMark.lua). Each builds its
-- frame and hands it here (TR.Attach) with its strings and progress bar;
-- from then on its scale, width, opacity, type sizes and outline, bar and
-- ground follow trackers.<kind>.* live. TR.Allowed says whether it may show
-- now (trackers.<kind>.combat: show, fade or hide in a fight;
-- trackers.<kind>.instance: show or hide inside an instance); a fight
-- starting or ending, or entering or leaving an instance, asks each again
-- (its `refresh`). The flight timer has neither: it shows only on a flight
-- path, never in a fight or inside an instance. The XP mark reads its own
-- settings (QoL/XPMark.lua).
--
--   UI.Trackers.Get(kind, prop)
--   UI.Trackers.Attach(kind, frame, { titles, bodies, bar, relayout(frame), refresh(), sandbox })
--   UI.Trackers.AddText(frame, titles, bodies)   strings made later (the party panel's rows)
--   UI.Trackers.ApplyLook(frame[, relayout])
--   UI.Trackers.Allowed(kind) -> true | "fade" | false
--   UI.Trackers.FADED                the opacity share of a tracker set to fade in a fight

local _, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim

local floor, max, min, type, ipairs, pairs, tonumber = math.floor, math.max, math.min, type, ipairs, pairs, tonumber

local TR = {}
UI.Trackers = TR

local FADED = 0.35 -- a tracker set to fade in a fight
TR.FADED = FADED

local function panel(width, extra)
	local t = { scale = 1, alpha = 1, width = width, titleSize = 1, bodySize = 1, outline = false,
		bgAlpha = 1, bg = false, border = false, borderSize = 0 }
	for k, v in pairs(extra or {}) do t[k] = v end
	return t
end

local DEFAULTS = {
	flight = panel(220, { barHeight = 2, barColor = false, bar = true, format = "left" }),
	instances = panel(230, { combat = "show", instance = "show" }),
	-- combat "guide": as the guide window does in a fight (ui.combat).
	party = panel(260, { combat = "guide", instance = "show" }),
	xp = { tickWidth = 2, tickColor = false, label = true, labelSize = 1, outline = true },
	-- The guide window's journey (UI/JourneyPanel.lua): how many legs it lists, their numbers.
	journey = { rows = 8, numbers = true },
}
ns.RegisterDefaults("trackers", DEFAULTS)

function TR.Get(kind, prop)
	local v = ns.Get("trackers." .. kind .. "." .. prop)
	if v == nil then
		local d = DEFAULTS[kind]
		v = d and d[prop]
	end
	return v
end

local function num(kind, prop, lo, hi)
	local v = tonumber(TR.Get(kind, prop)) or tonumber(DEFAULTS[kind][prop]) or 1
	return min(hi, max(lo, v))
end
-- A number setting within lo..hi (the previews' too).
TR.Num = num

local function rgba(v)
	if type(v) == "table" and tonumber(v[1]) then return v[1], v[2] or 0, v[3] or 0, tonumber(v[4]) or 1 end
	return nil
end

---------------------------------------------------------------------------
-- When a tracker may show
---------------------------------------------------------------------------

local fighting = false
local function inInstance()
	local C = ns.Compat
	return C and C.IsInInstance and C.IsInInstance() and true or false
end

function TR.Allowed(kind)
	if TR.Get(kind, "instance") == "hide" and inInstance() then return false end
	local rule = TR.Get(kind, "combat")
	if fighting and rule == "hide" then return false end
	if fighting and rule == "fade" then return "fade" end
	return true
end

---------------------------------------------------------------------------
-- The look on a tracker
---------------------------------------------------------------------------

local attached = setmetatable({}, { __mode = "k" }) -- frame -> kind
local dirty = setmetatable({}, { __mode = "k" })

function TR.ApplyLook(frame, relayout)
	local t = frame and frame.psTracker
	if not t then return end
	local kind = t.kind
	local tk, bk = num(kind, "titleSize", 0.6, 2), num(kind, "bodySize", 0.6, 2)
	frame.psTextK = max(tk, bk)
	local outline = TR.Get(kind, "outline") and true or false
	for _, list in ipairs({ { t.titles, tk }, { t.bodies, bk } }) do
		for _, fs in ipairs(list[1]) do
			if Theme.SetFontScale then Theme.SetFontScale(fs, list[2]) end
			if Theme.SetOutline then Theme.SetOutline(fs, outline) end
		end
	end
	-- A sandbox copy a settings preview places keeps the scale it gave it
	-- (psBandScale): a repaint (a new UI scale) leaves it where it stands.
	frame:SetScale(frame.psBandScale or num(kind, "scale", 0.4, 2.5) * (frame.psFit or 1))
	local width = floor(num(kind, "width", 120, 600) + 0.5)
	frame.psWidth = width
	frame:SetWidth(width)
	local bar = t.bar
	if bar then
		local h = floor(num(kind, "barHeight", 1, 12) + 0.5)
		bar:SetHeight(h)
		bar:SetShown(TR.Get(kind, "bar") ~= false)
		local r, g, b = rgba(TR.Get(kind, "barColor"))
		if r then
			W.Uncolor(bar.Fill)
			bar.Fill:SetVertexColor(r, g, b, 1)
		else
			W.Color(bar.Fill, "accent")
		end
		-- The fill's width follows the frame's.
		if W.SetProgress and bar.psFrac then W.SetProgress(bar, bar.psFrac, width - 2) end
	end
	local TS = UI.Toasts
	if TS and TS.PaintGround then TS.PaintGround(frame, function(prop) return TR.Get(kind, prop) end) end
	local a = num(kind, "alpha", 0.1, 1)
	if not t.sandbox and TR.Allowed(kind) == "fade" then a = a * FADED end
	frame:SetAlpha(a)
	if relayout and t.relayout then t.relayout(frame) end
end

local function refresh(frame, relayout)
	if frame.psTracker.sandbox and not frame:IsVisible() then
		dirty[frame] = true
		return
	end
	TR.ApplyLook(frame, relayout)
end

function TR.Attach(kind, frame, opts)
	opts = opts or {}
	frame.psTracker = {
		kind = kind, titles = opts.titles or {}, bodies = opts.bodies or {}, bar = opts.bar,
		relayout = opts.relayout, refresh = opts.refresh, sandbox = opts.sandbox and true or false,
	}
	attached[frame] = kind
	if opts.sandbox then
		frame:HookScript("OnShow", function(self)
			if dirty[self] then
				dirty[self] = nil
				TR.ApplyLook(self, true)
			end
		end)
	end
	-- Laid out for the saved sizes from the first (the flight timer grows to
	-- hold larger type), not only once a setting changes.
	TR.ApplyLook(frame, true)
end

-- Strings a tracker makes later (a new row): they take its type sizes.
function TR.AddText(frame, titles, bodies)
	local t = frame and frame.psTracker
	if not t then return end
	local tk, bk = num(t.kind, "titleSize", 0.6, 2), num(t.kind, "bodySize", 0.6, 2)
	local outline = TR.Get(t.kind, "outline") and true or false
	for _, pair in ipairs({ { titles, t.titles, tk }, { bodies, t.bodies, bk } }) do
		for _, fs in ipairs(pair[1] or {}) do
			pair[2][#pair[2] + 1] = fs
			if Theme.SetFontScale then Theme.SetFontScale(fs, pair[3]) end
			if Theme.SetOutline then Theme.SetOutline(fs, outline) end
		end
	end
end

-- The live trackers asked again whether they show, and their opacity.
local function wake()
	for frame in pairs(attached) do
		local t = frame.psTracker
		if not t.sandbox then
			if t.refresh then t.refresh() end
			TR.ApplyLook(frame)
		end
	end
end

ns.On("SETTING_CHANGED", function(path)
	if path ~= "" and path ~= "trackers" and path:sub(1, 9) ~= "trackers." then return end
	local kind = path:match("^trackers%.([^.]+)")
	local prop = path:match("^trackers%.[^.]+%.(.+)$")
	for frame, k in pairs(attached) do
		if not kind or k == kind then
			refresh(frame, true)
			local t = frame.psTracker
			if (prop == "combat" or prop == "instance" or not kind) and not t.sandbox and t.refresh then t.refresh() end
		end
	end
end)

ns.RegisterEvent("PLAYER_REGEN_DISABLED", function()
	fighting = true
	wake()
end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	fighting = false
	wake()
end)
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	local C = ns.Compat
	fighting = C and C.InCombat and C.InCombat() and true or false
	wake()
end)
ns.RegisterEvent("ZONE_CHANGED_NEW_AREA", wake)

Theme.OnChanged(function()
	for frame in pairs(attached) do refresh(frame, false) end
end)
