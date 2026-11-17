-- /polestar atlas test: every Atlas card at once, on fake data, to check the
-- look in game. The guide window reads a stand-in content provider
-- (GF.UseContent) that adds the fake rows to the Engine's answers; the cards
-- fed by other modules (the carried row, bags, Journey, Training due, a
-- skipped quest, the class quest) are patched until the test is turned off.
-- The window's banner shows one notice at a time, so the command steps
-- through them: Training due, then Bags full, then a skipped quest, then
-- off. Nothing is saved and the guide does not move. A step change or
-- /reload turns it off too. Mirrors the playground's card previews
-- (tools/play/driver.lua, previewCards).

local _, A = ...
local P = Polestar
if not (P and P.RegisterCommand and P.UI and P.UI.GuideFrame) then return end

local active = nil -- { restores = { fn, ... }, banner = i } while on
local BANNERS = { "Training due", "Bags full", "Bags full, junk", "Skipped quest" }

local function patch(restores, t, key, fn)
	if type(t) ~= "table" then return end
	local old = t[key]
	restores[#restores + 1] = function() t[key] = old end
	t[key] = fn
end

-- The Engine's answers, plus the derived lines the live window works out
-- itself (GF.CONTENT's last five), with the fake rows added.
local function provider()
	local E = P.Engine
	local derived = {
		StepHint = function(i) local Lv = P.Levels; return Lv and Lv.StepHint and Lv.StepHint(i) or nil end,
		Pace = function() local Lv = P.Levels; return Lv and Lv.Pace and Lv.Pace() or nil end,
		RestParts = function() local Q = P.QoL; return Q and Q.Rest and Q.Rest.Parts and Q.Rest.Parts() or nil end,
		Target = function()
			local nav = P.Nav
			if nav and nav.GetTarget then return nav.GetTarget() end
			return E.GetWaypoint and E.GetWaypoint() or nil
		end,
	}
	local c = setmetatable({}, { __index = function(_, k) return derived[k] or E[k] end })
	function c.GetStepView(index, ...)
		local view = E.GetStepView(index, ...)
		if not view or view.index ~= E.GetStepIndex() then return view end
		local copy = {}
		for k, v in pairs(view) do copy[k] = v end
		copy.note, copy.image = "Check the path near the bridge before heading up the hill.", nil
		copy.goals = { unpack(view.goals or {}) }
		-- Every kind of count: a lone 0/1, a part-done count, a done count,
		-- and a long goal that wraps to its second line.
		local fake = {
			{ status = "active", t = "kill", text = "Kill the camp leader for the leader's head", progress = { cur = 0, max = 1 } },
			{ status = "active", t = "kill", text = "Kill Bandits", progress = { cur = 3, max = 10 } },
			{ status = "done", t = "collect", text = "Collect Wolf Meat", progress = { cur = 8, max = 8 } },
			{ status = "active", t = "kill", text = "Kill the raiders along the road from the farm to the old mill", progress = { cur = 2, max = 12 } },
			{ optional = true, status = "active", t = "talk", text = "Talk to the nearby scout" },
		}
		-- In the focus group (the window lists its goals), else the last
		-- goal's: copies, so the Engine's own groups stay as they are.
		local last = copy.goals[#copy.goals]
		local gk = (view.groups and view.groups[view.focus] and view.focus) or (last and last.group)
		copy.groups = {}
		for k, grp in pairs(view.groups or {}) do
			local gc = {}
			for f, x in pairs(grp) do gc[f] = x end
			if k == gk then gc.goals = { unpack(grp.goals or {}) } end
			copy.groups[k] = gc
		end
		local into = gk and copy.groups[gk]
		for _, g in ipairs(fake) do
			local i = #copy.goals + 1
			g.index, g.previewOnly, g.group = i, true, gk
			copy.goals[i] = g
			if into and not g.optional then into.goals[#into.goals + 1] = i end
		end
		return copy
	end
	function c.GetWhileHereList()
		local s = E.GetStepIndex() or 1
		return { { step = s + 2, index = 1, here = "turnin", t = "turnin", quest = 0,
			hereText = "Turn in \"A Delivery On The Way\" to the next giver", yards = 160 } }
	end
	function c.GetBehind()
		return { { quest = 0, title = "Lost Supplies", step = 1, zone = "Elwynn Forest", yards = 640 } }
	end
	function c.XPStats()
		return { rate = 14200, timeToLevel = 1860, xp = 4100, max = 8800, level = 20 }
	end
	return c
end

local function refresh()
	local GF = P.UI.GuideFrame
	if GF.Render then pcall(GF.Render) end
	if GF.Layout then pcall(GF.Layout) end
	if GF.UpdateXP then pcall(GF.UpdateXP) end
	local JP = P.UI.JourneyPanel
	if JP and JP.Refresh then pcall(JP.Refresh, true) end
end

local function stop()
	if not active then return end
	local GF, CT = P.UI.GuideFrame, P.UI.ClassToast
	for i = #active.restores, 1, -1 do active.restores[i]() end
	active = nil
	if GF.UseContent then GF.UseContent(nil) end
	if CT and CT.Hide then pcall(CT.Hide) end
	refresh()
	P.Print("Atlas test off.")
end

local function start()
	local GF, UI = P.UI.GuideFrame, P.UI
	if not GF.UseContent then return P.Print("Atlas test: this Polestar has no GF.UseContent.") end
	if not (P.Engine.GetGuide and P.Engine.GetGuide()) then return P.Print("Atlas test: load a guide first.") end
	local r = {}
	active = { restores = r }
	-- Cards closed with their × on this step come back for the test.
	if A and A.closedOn then wipe(A.closedOn) end
	GF.UseContent(provider())
	patch(r, P.RoutePlan, "Carried", function()
		return { { quest = 0, title = "The Absent Minded Prospector", status = "missed", xp = 410 },
			{ quest = 0, title = "Brother Paxton", status = "skipped", xp = 0, grey = true } }
	end)
	patch(r, P.QoL and P.QoL.Space, "Banner", function()
		if active and BANNERS[active.banner] == "Bags full, junk" then
			return { free = 0, junk = { id = 0, link = "Ruined Pelt", count = 1, value = 4 } }
		end
		return { free = 0 }
	end)
	-- Its Delete it would arm the real cheapest junk: in the test, a line in chat.
	patch(r, P.QoL and P.QoL.Space, "Press", function() P.Print("Atlas test: Delete it (nothing deleted).") end)
	-- A fake journey of every kind of row: a walk with a hostile town under
	-- it, a flight, a lift and a ferry. One table for the whole test, so the
	-- panel keeps it and the current leg counts down.
	local legs = {
		{ kind = "walk", label = "Walk to the flight master", yards = 420, seconds = 56,
			hubs = { { name = "The next town" } }, to = { name = "The flight master" } },
		{ kind = "fly", yards = 2400, seconds = 95, to = { name = "The harbour town" } },
		{ kind = "lift", yards = 60, seconds = 20, to = { name = "The docks" } },
		{ kind = "boat", label = "Take the ferry", yards = 900, seconds = 90, to = { name = "The next stop" } },
	}
	patch(r, UI.JourneyPanel, "Route", function() return legs, 1 end)
	local notices = GF.notices
	if notices then
		local train, skip = notices.train, notices.questSkip
		r[#r + 1] = function() notices.train, notices.questSkip = train, skip end
	end
	active.banner = 0
	local CT = UI.ClassToast
	if CT and CT.ShowCard then
		pcall(CT.ShowCard, { head = "CLASS QUEST", title = "Visit your class trainer",
			giver = "Your trainer has a class quest for you", icon = P.Theme.Media("icon-train"),
			iconColor = "accent", quiet = true, act = { label = "Got it", run = CT.Hide } })
	end
end

-- The next banner notice (BANNERS); past the last, off.
local function nextBanner()
	active.banner = active.banner + 1
	local which = BANNERS[active.banner]
	if not which then return stop() end
	local notices = P.UI.GuideFrame.notices
	if notices then
		notices.train = which == "Training due" and { level = UnitLevel and UnitLevel("player") or 20, trainer = { npcName = "Your class trainer" } } or nil
		notices.questSkip = which == "Skipped quest" and { title = "Beached Sea Turtle" } or nil
	end
	refresh()
	P.Print(("Atlas test: %s banner (%d/%d). /polestar atlas test again for the next one."):format(which, active.banner, #BANNERS))
end

P.RegisterCommand("atlas", function(rest)
	rest = (rest or ""):lower()
	if rest == "test off" then return stop() end
	if rest ~= "test" then return P.Print("Usage: /polestar atlas test (again for the next banner), /polestar atlas test off") end
	if not active then start() end
	if active then nextBanner() end
end, "test: every Atlas card at once on fake data; test off ends it")

-- A step change brings the real content back.
if P.On then P.On("STEP_CHANGED", function() if active then stop() end end) end
