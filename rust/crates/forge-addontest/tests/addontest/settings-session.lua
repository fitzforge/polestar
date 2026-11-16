-- settings-session.rs's session: every action a player takes in the settings window, timed (addon ms) or,
-- with tests/lua/stub_alloc.lua loaded, counted (the addon's KiB); per action the median and worst of rounds 2
-- on; per round what two full collects keep and the frames, textures and font strings it made. ROUNDS rounds,
-- PER_KIND controls of each kind on each of the five tabs.
local P, A, gc = stub.profile, stub.alloc, collectgarbage
local ALLOC = A ~= nil
local function full() gc("collect"); gc("collect"); return gc("count") end
stub.advance(1)
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
assert(Polestar.RegisterGuide({ id = "test/perf", pack = "test", title = "Perf", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Marshal McBride", goals = {
		{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		{ t = "accept", quest = 33, title = "Wolves Across the Border", npc = 196, npcName = "Eagan Peltskinner", map = 1429, x = 48.1, y = 42.6 },
	} },
	{ title = "Kobolds", goals = { { t = "kill", quest = 7, obj = 1, target = "Kobold Vermin", npc = 6, map = 1429, x = 47, y = 35 } } },
} }))
Polestar.Engine.SetGuide("test/perf")
stub.fire("QUEST_LOG_UPDATE")
stub.advance(3)
if PolestarWelcome and PolestarWelcome:IsShown() then PolestarWelcome:Hide() end
local UI, W, T = Polestar.UI, Polestar.Widgets, Polestar.Theme
if ALLOC then
	for _, name in ipairs({ "SetOwner", "ClearLines", "AddLine", "AddDoubleLine", "SetText" }) do
		local fn = GameTooltip[name]
		GameTooltip[name] = function(...)
			local c = gc("count")
			fn(...)
			A.stub = A.stub + gc("count") - c
		end
	end
end
local login = full()

-- perf.test.js's reference (as settings-perf.rs): 500 events to a plain handler doing addon-like work.
local reference = ALLOC and 0 or math.huge
do
	local refFrame = CreateFrame("Frame")
	refFrame:RegisterEvent("POLESTAR_TEST_REFERENCE")
	local refText = { "Kobold Vermin slain: 3/10", "Gold Dust: 1/5", "Tough Wolf Meat: 4/8", "Plainstrider Beak: 0/7",
		"Bring the meat to Grull Hawkwind", "Speak with Thrall in Orgrimmar", "Zhevra Hooves: 2/4", "Explore the Crossroads" }
	refFrame:SetScript("OnEvent", function(_, _, i)
		local rows = {}
		for k = 1, #refText do
			local text = refText[k]
			local name, have, need = text:match("^(.-): (%d+)/(%d+)$")
			rows[k] = { name = name or text, done = have ~= nil and tonumber(have) >= tonumber(need), key = (text:lower():gsub("%W", "")) }
		end
		table.sort(rows, function(a, b) return a.key < b.key end)
		local dx, dy = i % 100 - 50, i % 37 - 18
		return string.format("%s (%s) %.1f yd", rows[1].name, rows[1].done and "done" or "open", math.sqrt(dx * dx + dy * dy))
	end)
	if not ALLOC then
		for _ = 1, 3 do
			gc("collect")
			local t = P.total()
			for i = 1, 5000 do stub.fire("POLESTAR_TEST_REFERENCE", i) end
			reference = math.min(reference, (P.total() - t) / 10)
		end
	end
end

-- An action's cost: its own calls (P.measure: every handler they run too) and the handlers of the frame after
-- it (P.total; the stub's own loop over its frames is not the addon's), less an idle frame's handlers.
local FRAME = 0.016
local idleMs, idleKib = 0, 0
local function frame() stub.advance(FRAME) end
local cur
local function curAndFrame() cur(); frame() end
local function measure(fn)
	cur = fn
	gc("collect")
	if ALLOC then
		local _, own = A.measure(curAndFrame)
		return own - idleKib
	end
	local t0 = P.total()
	local m = P.measure(fn)
	frame()
	return m + P.total() - t0 - idleMs
end
do
	local n = 30
	for _ = 1, n do
		if ALLOC then
			local _, own = A.measure(frame)
			idleKib = idleKib + own / n
		else
			local t0 = P.total()
			frame()
			idleMs = idleMs + (P.total() - t0) / n
		end
	end
end

local stats, errors, round = {}, {}, 0
local function act(name, fn)
	local ok, v = pcall(measure, fn)
	if not ok then
		errors[#errors + 1] = round .. " " .. name .. ": " .. tostring(v)
		return
	end
	local s = stats[name]
	if not s then s = {}; stats[name] = s end
	local r = s[round]
	if not r then r = {}; s[round] = r end
	r[#r + 1] = v
end

local O
local function open()
	act("open", function() Polestar.Fire("SHOW_OPTIONS") end)
	O = UI.Options
end
local function close() act("close", function() PolestarOptions:Hide() end); stub.advance(0.3) end

local function pagesAndTabs(fn)
	for _, p in ipairs(O.Pages()) do
		for _, t in ipairs(#p.tabs > 0 and p.tabs or { false }) do fn(p, t or nil) end
	end
end

local function selectAll()
	pagesAndTabs(function(p, t)
		act(round == 1 and "select (first)" or "select", function() O.Select(p.key, t) end)
		local scroll = O.frame.Scroll
		if scroll and W.ScrollTo then
			act("scroll", function() W.ScrollTo(scroll, 400) end)
			act("scroll", function() W.ScrollTo(scroll, 0) end)
		end
	end)
end

local function search()
	O.Select("theme", "Colour"); frame()
	for _, q in ipairs({ "t", "tr", "tra", "tran", "trans" }) do act("search type", function() O.SetQuery(q) end) end
	act("search clear", function() O.SetQuery("") end)
	for _, q in ipairs({ "a", "ar", "arr", "arro", "arrow" }) do act("search type", function() O.SetQuery(q) end) end
	act("search clear", function() O.SetQuery("") end)
end

-- Clicks on the rows of five tabs (PER_KIND of each kind): a switch twice (on and back), a dropdown opened and a
-- choice picked then put back, sliders dragged and released, colour picked live and closed.
local TABS = { { "theme", "Colour" }, { "theme", "Frames" }, { "guide", "Window" }, { "qualityoflife", "Quests" }, { "trackers", "Essentials" } }
local function kindOf(row)
	if rawget(row, "Slider") then return "slider" end
	if rawget(row, "Track") and rawget(row, "Knob") then return "toggle" end
	if rawget(row, "Chip") then return "color" end
	if rawget(row, "psCardBy") then return "cards" end
	if rawget(row, "psBinding") then return "binding" end
	if rawget(row, "Button") and rawget(row, "psChoices") ~= nil then return "dropdown" end
	return nil
end
local function click(row) stub.RunScript(row, "OnClick", "LeftButton") end
local function menuShown() return PolestarMenu and PolestarMenu:IsShown() end
local function menuItems()
	local out = {}
	if not menuShown() then return out end
	for _, f in ipairs(rawget(PolestarMenu, "rows") or {}) do if f:IsShown() then out[#out + 1] = f end end
	if #out == 0 then
		local function walk(fr)
			for _, c in ipairs(fr.children or {}) do
				if c:IsShown() and c.scripts.OnClick and rawget(c, "Text") then out[#out + 1] = c end
				walk(c)
			end
		end
		walk(PolestarMenu)
	end
	return out
end
local function controls()
	for _, at in ipairs(TABS) do
		O.Select(at[1], at[2]); stub.advance(0.1)
		local list = {}
		for key, row in pairs(O.Controls(at[1], at[2])) do
			if type(key) == "string" and row:IsVisible() and W.Enabled(row) then list[#list + 1] = { key, row } end
		end
		table.sort(list, function(a, b) return a[1] < b[1] end)
		local done = {}
		for _, kr in ipairs(list) do
			local key, row = kr[1], kr[2]
			local kind = kindOf(row)
			if kind then done[kind] = (done[kind] or 0) + 1 end
			if kind and done[kind] > PER_KIND then kind = nil end
			if kind == "toggle" and key ~= "ui.reduceMotion" then
				act("toggle", function() click(row) end)
				act("toggle", function() click(row) end)
			elseif kind == "slider" then
				local s = row.Slider
				local lo, hi = s:GetMinMaxValues()
				local was = s:GetValue()
				stub.RunScript(s, "OnMouseDown", "LeftButton")
				for k = 1, 6 do
					local v = lo + (hi - lo) * (k % 5) / 5
					act("slider step", function() s.value = v; s:GetScript("OnValueChanged")(s, v, true) end)
				end
				act("slider release", function() stub.RunScript(s, "OnMouseUp", "LeftButton") end)
				stub.advance(0.3)
				s.value = was; s:GetScript("OnValueChanged")(s, was, true)
				stub.advance(0.3)
			elseif kind == "color" then
				act("colour open", function() click(row) end)
				local info = ColorPickerFrame.info
				if info and info.swatchFunc then
					local get = ColorPickerFrame.GetColorRGB
					for k = 1, 6 do
						ColorPickerFrame.GetColorRGB = function() return 0.1 * k, 0.5, 1 - 0.1 * k end
						act("colour drag", function() info.swatchFunc() end)
					end
					ColorPickerFrame.GetColorRGB = get
					if info.cancelFunc then info.cancelFunc() end
				end
				act("colour close", function() ColorPickerFrame:Hide() end)
				stub.advance(0.3)
			elseif kind == "dropdown" then
				act("dropdown open", function() click(row) end)
				local items = menuItems()
				if #items >= 2 then
					act("dropdown pick", function() stub.RunScript(items[2], "OnClick", "LeftButton") end)
					stub.advance(0.1)
					if row.psPath then W.ResetSetting(row.psPath) end
					stub.advance(0.1)
				end
				if menuShown() then act("dropdown close", function() W.HideMenu() end) end
			end
		end
	end
end

local function binding()
	O.Select("gamepad", "Key bindings"); stub.advance(0.1)
	for _, row in pairs(O.Controls("gamepad", "Key bindings")) do
		if rawget(row, "psBinding") and row:IsVisible() then
			act("keybind capture", function() click(row) end)
			act("keybind cancel", function() if Polestar.Gamepad and Polestar.Gamepad.StopCapture then Polestar.Gamepad.StopCapture(nil) end end)
			break
		end
	end
end

local function resetPage()
	local c = O.ControlByKey("ui.border")
	O.Select(c.page.key, c.tab); stub.advance(0.1)
	-- Three of the page's settings off their defaults, as a player resets them.
	Polestar.Set("ui.border", false); Polestar.Set("ui.borderSize", 3); Polestar.Set("ui.shadowStrength", 0.4)
	stub.advance(0.1)
	act("reset page", function() O.ResetPage(c.page) end)
	act("undo", function() O.Undo() end)
end

local function profiles()
	local Pr = Polestar.Profiles
	if not Pr.Exists("Sweep") then Pr.New("Sweep", Pr.Active()) end
	local was = Pr.Active()
	act("profile switch", function() Pr.Switch("Sweep") end)
	act("profile switch", function() Pr.Switch(was) end)
end

local function install()
	if PolestarOptions and PolestarOptions:IsShown() then PolestarOptions:Hide() end
	for _, key in ipairs({ "welcome", "questing", "targeting", "groups", "route", "look", "finish" }) do
		act(round == 1 and "install page (first)" or "install page", function() UI.Welcome.Show(key) end)
	end
	act("install close", function() UI.Welcome.Hide() end)
	stub.advance(0.3)
end

local CHOICE = { from = "badlands", fromTitle = "Badlands", recommended = "stv", options = {
	{ id = "stv", title = "Stranglethorn Vale", zoneName = "Stranglethorn Vale", minLevel = 39, maxLevel = 43, recommended = true,
		seconds = 720, quests = 41, pitch = "Nesingwary's hunts.", pros = { "Quick to reach" }, cons = { "Busy" } },
	{ id = "riverglades", title = "Riverglades", zoneName = "Riverglades", minLevel = 37, maxLevel = 43, seconds = 540, quests = 69,
		experimental = true, newInForever = true, pitch = "A new Forever zone.", pros = { "All in one zone" }, cons = { "New guide" } },
} }
local function routeChoice()
	local E = Polestar.Engine
	local get, pend = E.GetRouteChoice, E.PendingRouteChoice
	E.GetRouteChoice = function() return CHOICE end
	E.PendingRouteChoice = function() return "badlands" end
	act(round == 1 and "path open (first)" or "path open", function() UI.RouteChoice.Show("badlands") end)
	act("path close", function() UI.RouteChoice.Hide() end)
	E.GetRouteChoice, E.PendingRouteChoice = get, pend
	stub.advance(0.3)
end

local rounds = {}
local made0 = ALLOC and { frames = A.made.frames, textures = A.made.textures, strings = A.made.strings } or nil
for r = 1, ROUNDS do
	round = r
	open(); stub.advance(0.3)
	for _ = 1, 3 do act("idle frame (just opened)", function() end) end
	selectAll()
	for _ = 1, 3 do act("idle frame (open)", function() end) end
	search()
	controls()
	binding()
	resetPage()
	profiles()
	close()
	for _ = 1, 3 do act("idle frame (closed)", function() end) end
	install()
	routeChoice()
	local row = { kept = full() }
	if ALLOC then
		row.frames, row.textures, row.strings = A.made.frames - made0.frames, A.made.textures - made0.textures, A.made.strings - made0.strings
		made0 = { frames = A.made.frames, textures = A.made.textures, strings = A.made.strings }
	end
	rounds[r] = row
end

-- Per action: rounds 2.. pooled (round 1 apart for first-time builds), median and worst.
local out = {}
for name, s in pairs(stats) do
	local pooled = {}
	for r = 2, ROUNDS do for _, v in ipairs(s[r] or {}) do pooled[#pooled + 1] = v end end
	if #pooled == 0 then pooled = s[1] or {} end
	table.sort(pooled)
	local first = s[1] or {}
	local f = 0
	for _, v in ipairs(first) do f = math.max(f, v) end
	out[name] = { n = #pooled, median = pooled[math.ceil(#pooled / 2)] or 0, worst = pooled[#pooled] or 0, round1Worst = f }
end
emit({ actions = out, rounds = rounds, login = login, errors = errors, idleMs = idleMs, idleKib = idleKib, reference = reference })
