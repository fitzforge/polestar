-- The dungeon heads-up (#836): the class quest heads-up's card (UI/ClassToast.lua)
-- for a dungeon whose quests have opened to this character. "LEVEL 18 ·
-- DUNGEON", "Ragefire Chasm is open to you", how many quests there are to
-- pick up and where, and what they are worth ("+1.4 LEVELS", Dungeons.QuestXP),
-- in its ring the dungeon's own picture (Dungeons/Art.lua: its loading
-- screen), or the dungeon glyph for one without;
-- "Pick up the quests" opens the dungeon's pickup guide in a new tab
-- (Dungeons.PickUp), so the leveling guide keeps its own; for a dungeon the
-- leveling route can still take (Engine.DungeonsAhead) "Add to my route"
-- leads instead (Engine.ChooseDungeon: the route picks its quests up on the
-- way and runs it), and once the route runs it the card says so; "Open in
-- Dungeons" opens the dungeon's page in the hub's Dungeons section
-- (Dungeons.Open); "Later" and the close button dismiss it; "Turn these off"
-- sets dungeons.headsUp off (also under Options > Discovery > Lookup).
-- The dungeon counts as told once the card is on screen or dismissed: a
-- card waiting for a hidden guide window shows when the window does. One
-- dismissed with Later below the dungeon's best-at level (a card the command
-- showed, or one told at the range's start before cards waited for best-at)
-- comes back once at best-at, then is told for good.
--
-- When it shows (DT.Candidates): a dungeon, not a raid, the character's level
-- at or past the level it suits best (Dungeons.BestAt; the Dungeons window
-- still picks its quests up from the range's start) and inside its range,
-- with quests for the character's faction, not told before
-- (CharState().dungeonToastSeen: key -> true, told for good, or "later",
-- back once at best-at), whose
-- pickup plan by the offer rule (Dungeons.PickupPlan(key, true): a quest is
-- offered from one level below its quest level, Fitz 2026-11-10, not 3-5
-- levels early as the game allows) has a quest to take now and either none
-- left for later levels or at least MIN_OPEN to take, and whose quests to
-- take now are worth MIN_WORTH of a level or more to the character
-- (Levels.Run; not judged when one's XP is unknown). Its "Pick up the
-- quests" opens the guide by the same rule; the dungeon's page still picks
-- up everything the game gives. At a level-up, after
-- DELAY seconds so the class quest heads-up goes first; at login, only for a
-- dungeon that came due (its best-at level and its first quest's offer level
-- were reached) within LOGIN_LEVELS levels, after the class
-- quest heads-up and the class guide banner; after a quest of a dungeon's
-- page is handed in (a prerequisite: its follow-ups there may open), only for
-- that dungeon, after DELAY seconds so the completed flag has caught up.
-- Only a level-up loads the Codex (the dungeons' pages and levels): the login
-- check waits until something loads it (CODEX_LOADED), and a hand-in before
-- then is told at the next level-up instead. Never in combat (the Codex may
-- have to load): it waits for combat to end, and while another heads-up is
-- on the card it waits for that one to be dismissed (HEADS_UP_HIDDEN). Of
-- several, the one that came due last.
--
--   UI.DungeonToast.Candidates(level, mode, questId)
--       mode "levelup" | "login" | "turnin" (questId handed in) | "any"
--   UI.DungeonToast.Check(level, mode, questId)  show the first candidate
--   UI.DungeonToast.Show(candidate), .Model(candidate), .PickUp(key, all), .SeePage(key)
--   /polestar dungeontoast [dungeon]         show it again

local ADDON, ns = ...
local UI, Theme = ns.UI, ns.Theme
local L = ns.L
local format, ipairs, pairs, sort, type = string.format, ipairs, pairs, table.sort, type

local DT = {}
UI.DungeonToast = DT

local LOGIN_LEVELS = 2 -- on login, dungeons that came due within this many levels
local MIN_OPEN = 3 -- with quests still to open at later levels, this many open now
local MIN_WORTH = 0.1 -- the quests to take now are worth at least this share of a level
local DELAY = 1.5 -- after a level-up, so the class quest heads-up has the card first
local SIDE = { Alliance = "A", Horde = "H" }

local function D() return ns.Dungeons end
local function CT() return UI.ClassToast end

local function seen()
	local st = ns.CharState()
	st.dungeonToastSeen = st.dungeonToastSeen or {}
	return st.dungeonToastSeen
end

-- Dungeons told before cards waited for best-at (at the range's start) and
-- whose best-at the character hasn't reached: back once at best-at, as after
-- Later. Once per character, with the dungeons' levels known.
local function upgradeSeen(level)
	local st = ns.CharState()
	if st.dungeonToastBestAt then return end
	st.dungeonToastBestAt = true
	local Dg = D()
	for key, v in pairs(st.dungeonToastSeen or {}) do
		local best = v == true and Dg.BestAt(key)
		if best and level < best then st.dungeonToastSeen[key] = "later" end
	end
end

-- The character (Levels.Player: Compat.GetPlayerInfo), or an empty table.
local function player()
	local Lv = ns.Levels
	return Lv and Lv.Player and Lv.Player() or {}
end

-- Whether quest id is one of the dungeon's page quests.
local function onPage(key, id)
	for _, q in ipairs(D().Quests(key)) do
		if q.id == id then return true end
	end
	return false
end

local function on()
	local Dg = D()
	return Dg and Dg.IsEnabled and Dg.IsEnabled() and ns.Get("dungeons.headsUp") and true or false
end

-- At login, before any plan is made: whether dungeon d can have come due
-- within LOGIN_LEVELS levels (its best-at level `best` reached, or one of its
-- page quests' offer level past that, that recently).
local function recent(d, level, best)
	if level - best <= LOGIN_LEVELS then return true end
	local Dg = D()
	for _, q in ipairs(Dg.Quests(d.key)) do
		local at = Dg.OfferLevel(q)
		if at <= level and level - at <= LOGIN_LEVELS then return true end
	end
	return false
end

-- Whether plan's quests to take now are worth less than MIN_WORTH of a level
-- to the character at `level` (Levels.Run, as the card's badge sums the
-- page's quests); never when one's XP is unknown.
local function tooLittle(plan, p, level)
	if p.level ~= level then p = { level = level, xp = 0, class = p.class, race = p.race, faction = p.faction } end
	local quests = {}
	for i, t in ipairs(plan.take) do
		local q = t.quest or {}
		quests[i] = { id = q.id, level = q.level, xp = q.rewards and q.rewards.xp, classes = q.classes }
	end
	local s = ns.Levels.Run(quests, p)
	return s.unknown == 0 and (s.levels or 0) < MIN_WORTH
end

-- The dungeons to tell this character about at `level` (the character's when
-- nil), the one that came due last first ("any": told ones too, for the
-- command; "turnin": only dungeons whose page has questId): { key, name,
-- zoneName, minLevel, maxLevel, best, take, level, due }. due: the level it
-- came due at (its best-at level, or its first offered quest's offer level).
function DT.Candidates(level, mode, questId)
	local Dg = D()
	if not (on() and Dg.List and Dg.PickupPlan and Dg.Quests and Dg.BestAt) then return {} end
	local p = player()
	level = level or p.level
	local side = SIDE[p.faction or ""]
	if type(level) ~= "number" or not side then return {} end
	local list = Dg.List()
	if #list > 0 then upgradeSeen(level) end
	local told, out = seen(), {}
	for _, d in ipairs(list) do
		-- From the dungeon's floor (Dungeons.List), as the hub's "For your level": never the card for a
		-- dungeon the route would still hold back (Fitz, 2026-11-13).
		local min, max, from = d.minLevel, d.maxLevel, d.floor or d.minLevel
		local best = d.kind == "dungeon" and (mode == "any" or told[d.key] ~= true) and from and level >= from and (not max or level <= max)
			and (d.quests[side] or 0) > 0 and (mode ~= "turnin" or onPage(d.key, questId)) and math.max(Dg.BestAt(d.key) or from, from)
		if best and level >= best and (mode ~= "login" or recent(d, level, best)) then
			local plan = Dg.PickupPlan(d.key, true)
			local take = plan and #plan.take or 0
			if take > 0 and (plan.later == 0 or take >= MIN_OPEN) and not tooLittle(plan, p, level) then
				local due
				for _, t in ipairs(plan.take) do
					local at = Dg.OfferLevel(t.quest, t.rec)
					if not due or at < due then due = at end
				end
				due = math.max(best, due or best)
				if mode ~= "login" or level - due <= LOGIN_LEVELS then
					out[#out + 1] = { key = d.key, name = d.name, zoneName = d.zoneName, minLevel = min, maxLevel = max, best = best, take = take, level = level,
						due = due, pickLabel = Dg.PickupLabel and Dg.PickupLabel(plan) or nil }
				end
			end
		end
	end
	sort(out, function(a, b)
		if a.due ~= b.due then return a.due > b.due end
		return a.key < b.key
	end)
	return out
end

-- What the card says for candidate c. Its ring wears the dungeon's own
-- picture (Dungeons.Art: its loading screen), else the dungeon glyph.
function DT.Model(c)
	local Dg = D()
	local m = { dungeon = c.key, art = Dg.Art and Dg.Art(c.key), icon = Theme.Media("icon-dungeon"), iconColor = "dungeon", titleColor = "text" }
	m.head = format(L["LEVEL %d · DUNGEON"], c.level)
	m.facts = format(L["Level %d · Dungeon"], c.level)
	m.title = format(L["%s is open to you"], c.name)
	local quests = c.take == 1 and L["1 quest to pick up"] or format(L["%d quests to pick up"], c.take)
	local range = UI.LevelRange and UI.LevelRange(c.minLevel, c.maxLevel)
	local where = { quests }
	if range then where[#where + 1] = format(L["Levels %s"], range) end
	if c.zoneName then where[#where + 1] = c.zoneName end
	m.giver = table.concat(where, "  \194\183  ")
	-- A way in through the other faction's land (Dungeons.EnemyEntrance): it
	-- says so in the warning colour and leads with the dungeon's page, where the
	-- player decides; the pick-up guide is the second button.
	local enemy = Dg.EnemyEntrance and Dg.EnemyEntrance(c.key, SIDE[player().faction or ""])
	if enemy then m.giver = m.giver .. "\n|c" .. Theme.Hex("warning") .. enemy .. "|r" end
	-- What its quests are worth, as on the dungeon's page (Dungeons.QuestXP).
	local LT = UI.LevelTip
	local xs = Dg.QuestXP and Dg.QuestXP(c.key)
	if xs and not xs.maxed and (xs.levels or 0) > 0 and LT and LT.Text then m.badge = LT.Text(xs.levels):upper() end
	local pick = { label = c.pickLabel or L["Pick up the quests"], run = function() return DT.PickUp(c.key, c.all) end }
	local page = { label = L["Open in Dungeons"], run = function() return DT.SeePage(c.key) end }
	if enemy then m.act, m.more = page, pick else m.act, m.more = pick, page end
	-- A dungeon this character's leveling route can still take (DT.RouteEntry):
	-- not run yet, Add to my route leads (the guide then picks its quests up on
	-- the way and runs it; the guide window says what changes) and its page
	-- follows; already run, the card says so and leads with the page instead
	-- of a second pick-up guide.
	local route = DT.RouteEntry(c.key)
	if route and route.answer ~= true then
		m.act, m.more = { label = L["Add to my route"], run = function() return DT.AddToRoute(route.map) end }, page
	elseif route then
		m.giver = m.giver .. "\n" .. L["On your route: the guide picks its quests up on your way."]
		m.act, m.more = page, nil
	end
	m.off = { label = L["Turn these off"], run = DT.TurnOff }
	-- Later below the dungeon's best-at level: back once at best-at.
	local best = c.best or (Dg.BestAt and Dg.BestAt(c.key))
	m.later = { label = L["Later"], run = function(shown) if best and c.level < best then shown.backAtBest = true end end }
	return m
end

-- The route's entry for dungeon `key` (Engine.DungeonsAhead: its run still
-- ahead and takeable on this character's route), or nil.
function DT.RouteEntry(key)
	local Dg, E = D(), ns.Engine
	local d = Dg and Dg.Get and Dg.Get(key)
	if not (d and type(d.map) == "number" and E and E.DungeonsAhead) then return nil end
	for _, r in ipairs(E.DungeonsAhead(8)) do
		if r.map == d.map then return r end
	end
	return nil
end

-- "Add to my route": this dungeon runs in the leveling route (its own answer,
-- Engine.ChooseDungeon; "Dungeons in my route" stays as it is).
function DT.AddToRoute(map)
	local E = ns.Engine
	if not (E and E.ChooseDungeon) then return false end
	E.ChooseDungeon(map, true)
	CT().Hide()
	return true
end

-- A card that waits for the hidden guide window (UI.ClassToast keeps it as
-- .current and shows it with the window) counts as told once it is on
-- screen.
local hooked = false
local function toldWhenShown()
	local w = UI.GuideFrame and UI.GuideFrame.frame
	if hooked or not w then return end
	hooked = true
	w:HookScript("OnShow", function()
		local T = CT()
		local m = T and T.current
		if m and m.dungeon and T.frame and T.frame:IsShown() then seen()[m.dungeon] = true end
	end)
end

-- Show the card for candidate c. -> true when on screen (the dungeon is told)
function DT.Show(c)
	local T = CT()
	if not (c and T and T.ShowCard) then return false end
	local shown = T.ShowCard(DT.Model(c))
	if shown then
		seen()[c.key] = true
	elseif T.current and T.current.dungeon == c.key then
		toldWhenShown()
	end
	return shown
end

-- A dungeon card dismissed (Later, the close button, one of its buttons)
-- counts as told; with Later below best-at, only until best-at ("later").
ns.On("HEADS_UP_HIDDEN", function(m)
	if type(m) == "table" and m.dungeon then seen()[m.dungeon] = m.backAtBest and "later" or true end
end)

-- "Open in Dungeons": the dungeon's page in the hub, where its quests,
-- bosses and entrance are.
function DT.SeePage(key)
	local Dg = D()
	if not (Dg and Dg.Open and Dg.Open(key)) then return false end
	CT().Hide()
	return true
end

-- "Pick up the quests": the dungeon's pickup guide in a new tab, as its page's
-- button does, by the offer rule unless `all` (Dungeons.PickUp).
function DT.PickUp(key, all)
	local Dg = D()
	local gid, reason = Dg.PickUp(key, not all)
	if gid then
		ns.Set("ui.shown", true)
		CT().Hide()
		return gid
	end
	if reason == "tabs" then
		ns.Print(L["Six tabs is the limit. Close one to open another."])
	elseif reason == "nothing" then
		ns.Print(L["Nothing to pick up"])
	else
		ns.Print(format(L["No guide could be made for this (%s)."], tostring(reason)))
	end
	return nil, reason
end

function DT.TurnOff()
	ns.Set("dungeons.headsUp", false)
	ns.Print(L["Dungeon heads-ups are off. Turn them back on under Options > Discovery > Lookup."])
end

-- The checks that have to wait (combat, another heads-up on the card), in
-- order, each once: a level-up and a turn-in while a card is shown both stay.
local pending = {}

-- Modes that never load the Codex (DT.Check): its 7 MB load at every login
-- or at the first hand-in would cost every character, whatever its level.
local NO_LOAD = { login = true, turnin = true }

local function codexLoaded()
	local X = ns.Codex
	return X and X.IsLoaded and X.IsLoaded() and true or false
end

function DT.Check(level, mode, questId)
	if not on() then return false end
	if NO_LOAD[mode] and not codexLoaded() then return false end
	local C, T = ns.Compat, CT()
	if (C.InCombat and C.InCombat()) or (T and T.current) then
		for _, p in ipairs(pending) do
			if p[1] == level and p[2] == mode and p[3] == questId then return false end
		end
		pending[#pending + 1] = { level, mode, questId }
		return false
	end
	local c = DT.Candidates(level, mode, questId)[1]
	return c ~= nil and DT.Show(c) or false
end

-- Runs the waiting checks until one shows a card (the rest are dropped, as
-- at a level-up only one dungeon is told); one still blocked waits again.
local function retry()
	if #pending == 0 then return end
	local waiting = pending
	ns.After(0.5, function()
		if pending ~= waiting then return end
		pending = {}
		for _, p in ipairs(waiting) do
			if DT.Check(p[1], p[2], p[3]) then return end
		end
	end)
end

---------------------------------------------------------------------------
-- Events and the command
---------------------------------------------------------------------------

-- After the class quest heads-up (2 s) and the class guide banner (3 s);
-- without the Codex loaded, once something loads it.
local loggedIn, loginDue = false, false
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	if loggedIn then return end
	loggedIn = true
	ns.After(4, function()
		if codexLoaded() then
			DT.Check(nil, "login")
		else
			loginDue = true
		end
	end)
end)

ns.On("CODEX_LOADED", function()
	if not loginDue then return end
	loginDue = false
	ns.After(DELAY, function() DT.Check(nil, "login") end)
end)

-- A level-up's check covers a login check still due.
ns.RegisterEvent("PLAYER_LEVEL_UP", function(_, level)
	local n = tonumber(level)
	if not n then return end
	loginDue = false
	ns.After(DELAY, function() DT.Check(n, "levelup") end)
end)

-- A quest of a dungeon's page handed in may open its follow-ups there.
ns.RegisterEvent("QUEST_TURNED_IN", function(_, questID)
	local id = tonumber(questID)
	if id then ns.After(DELAY, function() DT.Check(nil, "turnin", id) end) end
end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", retry)
ns.On("HEADS_UP_HIDDEN", retry)

ns.RegisterCommand("dungeontoast", function(rest)
	local Dg = D()
	local key = rest and rest ~= "" and Dg and Dg.Find and Dg.Find(rest) or nil
	local c
	for _, x in ipairs(DT.Candidates(nil, "any")) do
		if not key or x.key == key then c = x break end
	end
	if not c and key and Dg.Get(key) then
		local d, plan = Dg.Get(key), Dg.PickupPlan(key)
		local take, level = plan and #plan.take or 0, player().level
		if take == 0 then return ns.Print(L["Nothing to pick up"]) end
		if type(level) == "number" then
			c = { key = key, name = d.name, zoneName = d.zoneName, minLevel = d.minLevel, maxLevel = d.maxLevel, take = take, level = level, all = true }
		end
	end
	if not (c and DT.Show(c)) then ns.Print(L["No dungeon has opened up for this character."]) end
end, L["Show the dungeon heads-up again (the next one due, or a dungeon)"])
