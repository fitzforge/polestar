-- env: eui
-- The Integrations page (Polestar_Options/UI/Options.lua: EllesmereUI, Spoken; Nav/Journey.lua: TomTom;
-- Nav/Handoff.lua: Shortest Path Forever; UI/QuestieTurnIns.lua: Questie), each with the addon it works with:
-- EllesmereUI installed before Polestar loads (theme.rs), Spoken Quests loaded, TomTom, Shortest Path Forever and
-- Questie's tracker faked from the APIs Polestar calls (nav-journey.rs, nav-handoff.rs, route-plan.rs), and a
-- guide loaded at an accept step with a quest ready to hand in.
local w, T, N, GF
local body, row, spf
local function rgb(t) local r, g, b = t:GetVertexColor(); return { r, g, b } end
-- Shortest Path Forever's API v1 (its docs/api.md), as nav-handoff.rs fakes it: the journey it guides.
local function fakeSpf()
	spf = { owner = nil }
	local A = { version = 1, minor = 1 }
	function A.NavigateRoute(owner, stops)
		if InCombatLockdown() or type(owner) ~= "string" or type(stops) ~= "table" or #stops < 1 then return false end
		spf.owner, spf.stops = owner, stops
		return true
	end
	function A.Navigate(owner, map, x, y, title, kind) return A.NavigateRoute(owner, { { map = map, x = x, y = y, title = title, kind = kind } }) end
	function A.CurrentStop(owner) return spf.owner == owner and 1 or nil end
	function A.Cancel(owner)
		if spf.owner ~= owner then return false end
		spf.owner = nil
		return true
	end
	function A.Active() return spf.owner ~= nil end
	function A.Ended() return nil end
	function A.Estimate() return 60 end
	ShortestPathForever = { API = A }
end
-- Questie's tracker with one row: a quest ready to hand in (route-plan.rs).
local function fakeQuestie()
	row = CreateFrame("Button")
	row.label = row:CreateFontString()
	row.label:SetFont("font", 12); row.label:SetHeight(12); row.label:SetWidth(250)
	local pool = { AddQuestLine = function() end, UpdateQuestTitleLines = function(fn) if row.mode == "quest" then fn(row) end end,
		GetCurrentLine = function() return row end, GetQuestTitleLine = function(q) row.mode = "quest"; row.Quest = q; return row end }
	local tracker = { Update = function()
		local line = pool.GetQuestTitleLine({ Id = 3 })
		line.label:SetHeight(12); line.label:SetText("Ready quest"); line.label:SetWidth(250); line:SetHeight(line.label:GetHeight() + 4)
	end }
	QuestieLoader = { ImportModule = function(_, name) if name == "TrackerLinePool" then return pool else return tracker end end }
	-- It hooks Questie's rows only while on: on for the hook, then back to the default.
	Polestar.Set("routePlan.questie", true)
	assert(Polestar.QuestieTurnIns.Connect())
	tracker:Update()
	Polestar.Set("routePlan.questie", nil)
end
return {
	setup = function()
		w, T, N, GF = stub.world, Polestar.Theme, Polestar.Nav, Polestar.UI.GuideFrame
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 40, 50)
		w.onQuest(3, { { required = 1, fulfilled = 1 } })
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/integrations", pack = "test", title = "Integrations", minLevel = 1, maxLevel = 10, steps = {
			{ goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
			{ goals = { { t = "turnin", quest = 3, title = "Quest 3", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		} })
		Polestar.Engine.SetGuide("test/integrations")
		body = Polestar.Widgets.Text(UIParent, "body", "text")
		body:SetText("Hello")
		stub.addonsLoaded.Spoken_Quests = true
		fakeSpf()
		fakeQuestie()
	end,
	settle = 0.3,
	probes = {
		-- EllesmereUI's accent (0.05, 0.82, 0.62) on Polestar's accent-coloured elements: the progress line.
		["ui.matchAccent"] = function() return { accent = { T.Accent() }, fill = rgb(GF.parts.line.Fill) } end,
		["ui.matchFont"] = function() return { body:GetFont() } end,
		-- A quest window the guide wants: accepted at once, or after Spoken Quests has read it (the accept is
		-- counted, not made, so the guide stays where it is).
		["behavior.spokenDelay"] = function()
			local accept, n = AcceptQuest, 0
			AcceptQuest = function() n = n + 1 end
			w.questDetail(823, 783)
			local atOnce = n
			stub.advance(0.5)
			w.close()
			AcceptQuest = accept
			return { atOnce = atOnce, afterTheWait = n - atOnce }
		end,
		-- Another addon sets a waypoint through TomTom's API: Polestar's arrow takes it.
		["nav.answerTomTom"] = function()
			local tt = rawget(_G, "TomTom")
			local uid = type(tt) == "table" and tt:AddWaypoint(1429, 0.3, 0.6, { title = "Another addon's" }) or nil
			local t = N.GetTarget()
			local out = { uid = uid ~= nil, arrow = t and t.label or false }
			if uid then tt:RemoveWaypoint(uid) end
			return out
		end,
		-- TomTom installed, its arrow pointed somewhere: Polestar's arrow goes there too.
		["nav.followTomTom"] = {
			prepare = function()
				TomTom = { SetCrazyArrow = function() end, RemoveWaypoint = function() end, ClearWaypoint = function() end }
				N.journey.RefreshTomTomFollow()
			end,
			probe = function()
				local uid = { 1429, 0.3, 0.6, title = "TomTom's" }
				TomTom:SetCrazyArrow(uid)
				local t = N.GetTarget()
				local label = t and t.label or false
				TomTom:RemoveWaypoint(uid)
				return label
			end,
			cleanup = function() TomTom = nil end,
		},
		-- The guide's target handed to Shortest Path Forever: Polestar's arrow steps aside.
		["nav.spfHandoff"] = function()
			stub.advance(0.3)
			return { handed = N.HandedOff(), journey = spf.owner or false, arrow = N.arrow.frame and N.arrow.frame:IsShown() or false }
		end,
		["routePlan.questie"] = function() return row.label:GetText() end,
	},
}
