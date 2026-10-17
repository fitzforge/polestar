-- A contract-faithful stand-in for the Engine, the guide registry, Nav and
-- Compat (docs/ARCHITECTURE.md), plus sample guides, for the UI's tests and
-- for `node tools/polestar.js preview`. Load after wow_stub.lua; call
-- uistub.install() once the addon has loaded (it replaces Polestar.Engine,
-- .Guides, .Nav and .Compat), then stub.login().
--
--   uistub.calls              every Engine/Nav call the UI made: { fn, args... }
--   uistub.setGuide(id, i)    show a guide at step i in the active tab (fires GUIDE_CHANGED)
--   uistub.openTabs(list, a)  open { { id, step }, ... } as tabs, tab `a` active
--   uistub.setStep(i), uistub.complete()
--   uistub.goal(s, g)         the mutable goal table behind step s, goal g (active tab)
--   uistub.update()           fire STEP_UPDATED for the current step
--   uistub.guides             the sample guides, by id
--   uistub.install({ noNav = true, noTabs = true })  leave Nav / the tabs API out

uistub = { calls = {}, guides = {}, order = {} }

local function record(name, ...)
	table.insert(uistub.calls, { name, ... })
end

---------------------------------------------------------------------------
-- Sample guides, under the shipped guides' ids, titles, levels and zones
-- (guides/forever); steps are samples. Quest, NPC and map IDs are Classic
-- Era's (facts, not copied guide text); statuses are set per goal for the
-- scenario at hand.
---------------------------------------------------------------------------

local ELWYNN = 1429

local function G(t, fields)
	fields.t = t
	return fields
end

-- The Human start, its first quests in Northshire.
local elwynn = {
	id = "forever/alliance/human/01-elwynn-forest", pack = "guides",
	title = "Elwynn Forest", faction = "Alliance", races = { "Human" },
	minLevel = 1, maxLevel = 13, category = "Leveling", zone = ELWYNN, zoneName = "Elwynn Forest",
	next = "forever/alliance/02-westfall", author = "Polestar", version = 1,
	steps = {
		{ title = "Deputy Willem", goals = {
			G("accept", { verb = "Accept", subject = "A Threat Within", subjectKind = "quest", quest = 783, npc = 823, npcName = "Deputy Willem", map = ELWYNN, x = 48.2, y = 42.0, status = "done" }),
		} },
		{ title = "Marshal McBride", goals = {
			G("turnin", { verb = "Turn in", subject = "A Threat Within", subjectKind = "quest", quest = 783, npc = 197, npcName = "Marshal McBride", map = ELWYNN, x = 48.9, y = 41.6, status = "done" }),
			G("accept", { verb = "Accept", subject = "Kobold Camp Cleanup", subjectKind = "quest", quest = 7, npc = 197, npcName = "Marshal McBride", map = ELWYNN, x = 48.9, y = 41.6, status = "done" }),
		} },
		{ title = "Kobold Camp", note = "Kobolds wander the mine entrance. Pull them one at a time; the vermin hit softly but come in pairs.", goals = {
			G("accept", { verb = "Accept", subject = "Wolves Across the Border", subjectKind = "quest", quest = 33, npc = 196, npcName = "Eagan Peltskinner", map = ELWYNN, x = 48.2, y = 40.0, status = "done" }),
			G("goto", { verb = "Go to", subject = "the Kobold Camp", subjectKind = "place", map = ELWYNN, x = 47.6, y = 35.1, status = "done" }),
			G("kill", { verb = "Kill", subject = "Kobold Vermin", subjectKind = "npc", npc = 6, quest = 7, detail = "for Kobold Camp Cleanup", progress = { cur = 7, max = 10 }, map = ELWYNN, x = 47.6, y = 35.1, status = "active" }),
			G("collect", { verb = "Collect", subject = "Tough Wolf Meat", subjectKind = "item", item = 750, quest = 33, text = "Kill Young Wolf for Tough Wolf Meat",
				source = { name = "Young Wolf", kind = "npc", enemy = true, inText = true }, detail = "for Wolves Across the Border", progress = { cur = 3, max = 8 }, map = ELWYNN, x = 46.0, y = 38.5, status = "active" }),
		} },
		-- A hub: three people, walked one at a time.
		{ title = "Back to the Abbey", goals = {
			G("turnin", { verb = "Turn in", subject = "Kobold Camp Cleanup", subjectKind = "quest", quest = 7, npc = 197, npcName = "Marshal McBride", map = ELWYNN, x = 48.9, y = 41.6, status = "active" }),
			G("accept", { verb = "Accept", subject = "Investigate Echo Ridge", subjectKind = "quest", quest = 15, npc = 197, npcName = "Marshal McBride", map = ELWYNN, x = 48.9, y = 41.6, status = "pending" }),
			G("turnin", { verb = "Turn in", subject = "Wolves Across the Border", subjectKind = "quest", quest = 33, npc = 196, npcName = "Eagan Peltskinner", map = ELWYNN, x = 48.2, y = 40.0, status = "active" }),
			G("talk", { verb = "Talk to", subject = "Brother Neals", subjectKind = "npc", npc = 952, detail = "in the abbey bell tower", manual = true, map = ELWYNN, x = 49.6, y = 40.4, status = "pending" }),
		} },
		{ title = "Goldshire", goals = {
			G("goto", { verb = "Go to", subject = "Goldshire", subjectKind = "place", map = ELWYNN, x = 42.1, y = 65.9, status = "pending" }),
		} },
		{ title = "Fargodeep Mine", only = { classes = { "MAGE" } }, goals = {
			G("train", { verb = "Train", subject = "new spells", subjectKind = "text", manual = true, status = "na" }),
		} },
		{ title = "Echo Ridge Mine", goals = {
			G("kill", { verb = "Kill", subject = "Kobold Workers", subjectKind = "npc", npc = 257, quest = 15, progress = { cur = 0, max = 10 }, status = "pending" }),
		} },
		{ title = "Hearth to Goldshire", goals = {
			G("sethome", { verb = "Set your hearthstone to", subject = "Goldshire", subjectKind = "place", status = "pending" }),
			G("level", { verb = "Reach level", subject = "6", subjectKind = "level", status = "pending" }),
		} },
	},
}

-- A profession guide mid-way: crafting until a rank, a counted craft, a
-- skill target. Progress shapes follow the Engine's step view.
local STORMWIND = 1453
local tailoring = {
	id = "forever/professions/tailoring", pack = "guides",
	title = "Tailoring 1-300", faction = nil, minLevel = 5, maxLevel = 60, category = "Professions",
	zone = 947, zoneName = "Azeroth", author = "Polestar", version = 1,
	steps = {
		{ title = "Apprentice Tailoring", goals = {
			G("train", { verb = "Train at", subject = "Georgio Bolero", subjectKind = "npc", npc = 1346, map = STORMWIND, x = 53.2, y = 81.6, status = "done",
				alternatives = 2, candidates = {
					{ npc = 1346, npcName = "Georgio Bolero", map = STORMWIND, x = 53.2, y = 81.6 },
					{ npc = 1103, npcName = "Eldrin", map = ELWYNN, x = 79.2, y = 68.4 },
					{ npc = 4159, npcName = "Me'lynn", map = 1426, x = 58.2, y = 51.6 },
				} }),
		} },
		{ title = "Bolts of Linen", note = "Linen drops from humanoids all over Elwynn and Westfall. Keep about 60 cloth for this and the next step.", goals = {
			G("learn", { verb = "Learn", subject = "Brown Linen Vest", subjectKind = "spell", spell = 2385, status = "done" }),
			G("craft", { verb = "Craft", subject = "Bolt of Linen Cloth", subjectKind = "spell", spell = 2963, detail = "2 Linen Cloth each",
				progress = { cur = 38, max = 50, label = "Tailoring", kind = "skill" }, skillLine = 197, status = "active" }),
			G("craft", { verb = "Craft", subject = "Linen Bag", subjectKind = "spell", spell = 3755, detail = "3 Bolt of Linen Cloth, 3 Coarse Thread",
				progress = { cur = 1, max = 3, kind = "count" }, status = "active" }),
			G("buy", { verb = "Buy", subject = "Coarse Thread", subjectKind = "item", item = 2320, detail = "from Rachel",
				progress = { cur = 4, max = 10, kind = "count" }, status = "active" }),
			G("skill", { verb = "Reach", subject = "Tailoring 75", subjectKind = "skill", skillLine = 197,
				progress = { cur = 38, max = 75, label = "Tailoring", kind = "skill" }, status = "pending" }),
		} },
		{ title = "Woolen Boots", goals = {
			G("craft", { verb = "Craft", subject = "Woolen Boots", subjectKind = "spell", spell = 2401, status = "pending" }),
		} },
		{ title = "Journeyman Tailoring", goals = {
			G("learn", { verb = "Learn", subject = "Journeyman Tailoring", subjectKind = "spell", spell = 3912, status = "pending" }),
		} },
	},
}

-- A reputation guide: a standing to reach, a turn-in loop, an area to
-- discover and an achievement criterion.
local stormwindRep = {
	id = "forever/reputation/stormwind", pack = "guides",
	title = "Stormwind Reputation", faction = "Alliance", minLevel = 12, maxLevel = 60, category = "Reputation",
	zone = STORMWIND, zoneName = "Stormwind City", author = "Polestar", version = 1,
	steps = {
		{ title = "Into the City", goals = {
			G("goto", { verb = "Go to", subject = "the Trade District", subjectKind = "place", map = STORMWIND, x = 62.0, y = 70.0, status = "done" }),
		} },
		{ title = "Cloth for the Kingdom", note = "Wool turns in by the stack of 20. Each stack is worth a little under Honored pace; keep going until the bar fills.", goals = {
			G("rep", { verb = "Reach Honored with", subject = "Stormwind", subjectKind = "faction", faction = 72, standing = 6, standingName = "Honored",
				progress = { cur = 2150, max = 6000, label = "Friendly", kind = "rep" }, status = "active" }),
			G("collect", { verb = "Collect", subject = "Wool Cloth", subjectKind = "item", item = 2592,
				progress = { cur = 40, max = 60, kind = "count" }, status = "active" }),
			G("explore", { verb = "Discover", subject = "the Dwarven District", subjectKind = "area", map = STORMWIND, x = 63.5, y = 37.8, status = "done" }),
			G("achieve", { verb = "Complete", subject = "Friend of the Crown", subjectKind = "achievement", achievement = 9001, criteria = 2,
				detail = "Donations to the cloth drive", progress = { cur = 3, max = 5, kind = "count" }, status = "active" }),
		} },
	},
}

-- The zone's uiMapID, as the guide compiler resolves it from `zone`; 0 for
-- a zone the samples do not place.
local ZONE_MAP = {
	["Elwynn Forest"] = ELWYNN, ["Dun Morogh"] = 1426, ["Westfall"] = 1436, ["Durotar"] = 1411,
	["Stormwind City"] = 1453, ["Orgrimmar"] = 1454, ["Teldrassil"] = 1438, ["Tirisfal Glades"] = 1420,
	["Ironforge"] = 1455, ["Darkshore"] = 1439, ["The Barrens"] = 1413, ["Zephras Isle"] = 2521,
	["Eastern Kingdoms"] = 1415, ["Burning Steppes"] = 1428,
}

-- n steps of one note each; extra: more header fields (next, folder, keywords).
local function simple(id, title, faction, lo, hi, zoneName, category, races, n, extra)
	local steps = {}
	for i = 1, n do
		steps[i] = { title = title .. " " .. i, goals = { G("note", { text = "Step " .. i, status = "pending" }) } }
	end
	local g = {
		id = id, pack = "guides", title = title, faction = faction, races = races,
		minLevel = lo, maxLevel = hi, category = category, zone = ZONE_MAP[zoneName] or 0, zoneName = zoneName, author = "Polestar", version = 1,
		steps = steps,
	}
	for k, v in pairs(extra or {}) do g[k] = v end
	return g
end

local WESTFALL = { next = "forever/alliance/02-westfall" }
local SAMPLES = {
	elwynn,
	simple("forever/alliance/dwarf-gnome/01-dun-morogh", "Dun Morogh", "Alliance", 1, 13, "Dun Morogh", "Leveling", { "Dwarf", "Gnome" }, 59, WESTFALL),
	simple("forever/alliance/02-westfall", "Westfall", "Alliance", 12, 17, "Westfall", "Leveling", nil, 17, { next = "forever/alliance/03-darkshore" }),
	simple("forever/alliance/03-darkshore", "Darkshore", "Alliance", 16, 21, "Darkshore", "Leveling", nil, 33, { next = "forever/alliance/04-redridge-mountains" }),
	simple("forever/alliance/skyborne/01-zephras-isle", "Zephras Isle", "Alliance", 1, 15, "Zephras Isle", "Leveling", { "Skyborne" }, 52, WESTFALL),
	simple("forever/horde/orc-troll/01-durotar", "Durotar", "Horde", 1, 12, "Durotar", "Leveling", { "Orc", "Troll" }, 55, { next = "forever/horde/orc-troll/02-the-barrens" }),
	simple("forever/horde/02-the-barrens", "The Barrens", "Horde", 12, 17, "The Barrens", "Leveling", nil, 41, { next = "forever/horde/03-silverpine-forest" }),
	simple("forever/professions/cooking", "Cooking 1-300", nil, 5, 60, "Ironforge", "Professions", nil, 74),
	tailoring,
	stormwindRep,
	simple("forever/reputation/orgrimmar", "Orgrimmar Reputation", "Horde", 12, 60, "Orgrimmar", "Reputation", nil, 12),
	simple("forever/legacy/legacy-challenges", "Legacy Challenges", nil, 1, 60, "Burning Steppes", "Legacy", nil, 24),
	simple("forever/exploration/eastern-kingdoms-1-30", "Exploration: Eastern Kingdoms 1-30", nil, 1, 30, "Eastern Kingdoms", "Exploration", nil, 44,
		{ next = "forever/exploration/eastern-kingdoms-30-45" }),
	simple("forever/collectibles/mounts/alliance/horse", "Horse", "Alliance", 40, 60, "Elwynn Forest", "Collectibles", nil, 2,
		{ folder = "Mounts \194\183 Level 40", keywords = { "Pinto Bridle", "Chestnut Mare Bridle", "Brown Horse Bridle", "Stallion", "Human", "Katie Hunter", "Riding" } }),
	simple("forever/alliance/nightelf/01-teldrassil", "Teldrassil", "Alliance", 1, 11, "Teldrassil", "Leveling", { "NightElf" }, 35, WESTFALL),
	simple("forever/horde/undead/01-tirisfal-glades", "Tirisfal Glades", "Horde", 1, 13, "Tirisfal Glades", "Leveling", { "Scourge" }, 61, { next = "forever/horde/02-the-barrens" }),
	simple("forever/professions/first-aid", "First Aid 1-300", nil, 5, 60, "Ironforge", "Professions", nil, 28),
}

for _, g in ipairs(SAMPLES) do
	uistub.guides[g.id] = g
	table.insert(uistub.order, g.id)
end

uistub.elwynn = elwynn.id
uistub.tailoring = tailoring.id
uistub.stormwindRep = stormwindRep.id
uistub.suggest = elwynn.id
uistub.player = { name = "Testchar", realm = "Test Realm", level = 4, race = "Human", class = "WARRIOR", faction = "Alliance" }

---------------------------------------------------------------------------
-- Engine
---------------------------------------------------------------------------

local guide, current -- guide table, current step index (nil = complete)
uistub.target = nil  -- Nav override

local function header(g)
	local h = {}
	for k, v in pairs(g) do if k ~= "steps" then h[k] = v end end
	h.stepCount = #g.steps
	return h
end

local function stepStatus(i)
	local step = guide.steps[i]
	local applies = false
	for _, goal in ipairs(step.goals) do if goal.status ~= "na" then applies = true end end
	if not applies then return "na" end
	if current == nil or i < current then return "done" end
	if i == current then return "current" end
	return "upcoming"
end

-- Focus groups, per docs/ARCHITECTURE.md "Focus: one person at a time":
-- consecutive goals with the same "who" form a group; goals that do not
-- apply join the group around them; the focus is the first open group.
local WHO = { accept = true, turnin = true, talk = true, train = true, vendor = true, sethome = true,
	getfp = true, learn = true, buy = true, interact = true }
local function whoOf(goal)
	if WHO[goal.t] and goal.npc then return "npc:" .. goal.npc, "npc", goal.npcName or (goal.subjectKind == "npc" and goal.subject) or nil end
	-- A quest interact is field work, not a visit (Engine whoOf).
	if WHO[goal.t] and goal.object and not (goal.t == "interact" and goal.quest) then
		return "object:" .. goal.object, "object", goal.objectName
	end
	return "here", "here", nil
end
local function groupsOf(goals)
	local groups, cur, key = {}, nil, nil
	for gi, goal in ipairs(goals) do
		if goal.status == "na" and cur then
			cur.goals[#cur.goals + 1] = gi
		else
			local k, kind, name = whoOf(goal)
			if not cur or (goal.status ~= "na" and k ~= key) then
				cur = { kind = kind, name = name, npc = kind == "npc" and goal.npc or nil, object = goal.object, goals = {}, done = true, pending = 0 }
				groups[#groups + 1] = cur
				key = k
			end
			cur.goals[#cur.goals + 1] = gi
		end
		goal.group = #groups
		if goal.status ~= "na" and goal.status ~= "done" and goal.status ~= "skipped" and not goal.optional then
			cur.done = false
			cur.pending = cur.pending + 1
		end
		if goal.map and goal.x and not cur.map and goal.status ~= "na" then cur.map, cur.x, cur.y, cur.f = goal.map, goal.x, goal.y, goal.f end
	end
	local focus
	for gi, g in ipairs(groups) do if not g.done then focus = gi break end end
	return groups, focus
end

-- The goal the window marks current, as the Engine picks it: in the focus,
-- the first open blocking goal that is not the header, else the first open
-- optional one, else the header.
local function currentOf(out)
	if out.status ~= "current" or not out.focus then return nil end
	local opt, header
	for _, gi in ipairs(out.groups[out.focus].goals) do
		local v = out.goals[gi]
		if v.status == "active" and v.t ~= "note" and not v.folded then
			if v.header then
				header = header or gi
			elseif not v.optional then
				return gi
			else
				opt = opt or gi
			end
		end
	end
	return opt or header
end

uistub.skipped = {} -- step index -> true: the step view says `skipped`

local function view(i)
	local step = guide.steps[i]
	local goals = {}
	for g, goal in ipairs(step.goals) do
		local v = {}
		for k, val in pairs(goal) do v[k] = val end
		v.index = g
		v.text = goal.text or ((goal.verb or "") .. " " .. (goal.subject or ""))
		v.manual = goal.manual and true or false
		v.optional = goal.optional and true or false
		-- Every goal but a note ticks (Engine.ToggleGoal).
		v.tickable = goal.t ~= "note" and goal.status ~= "na" and goal.tickable ~= false
		v.ticked = goal.ticked and true or false
		if goal.progress then
			local p = {}
			for k, val in pairs(goal.progress) do p[k] = val end
			v.progress = p
		end
		goals[g] = v
	end
	local out = { index = i, title = step.title, note = step.note, status = stepStatus(i), goals = goals, skipped = uistub.skipped[i] or false }
	out.groups, out.focus = groupsOf(goals)
	out.current = currentOf(out)
	return out
end

-- Tabs (docs/ARCHITECTURE.md, Engine -> Tabs): several guides open at
-- once, each with its own step; every single-guide call acts on the active
-- tab. `guide`/`current` always mirror the active tab.
local tabs, activeTab = {}, nil
uistub.started = {} -- guide id -> true: GetGuideState reports "started"

local function saveTab()
	if activeTab and tabs[activeTab] then tabs[activeTab].step = current end
end

local function loadTab(i)
	activeTab = i
	local t = i and tabs[i]
	guide = t and uistub.guides[t.id] or nil
	current = t and t.step or nil
end

local Engine = {}

local function tabProgress(t)
	local g = uistub.guides[t.id]
	local done, total = 0, 0
	for i = 1, #g.steps do
		local applies = false
		for _, goal in ipairs(g.steps[i].goals) do if goal.status ~= "na" then applies = true end end
		if applies then
			total = total + 1
			if t.step == nil or i < t.step then done = done + 1 end
		end
	end
	return done, total
end

local function tabsChanged()
	local list, a = Engine.GetTabs()
	Polestar.Fire("TABS_CHANGED", list, a)
end

local function activated()
	Polestar.Fire("GUIDE_CHANGED", guide and guide.id or nil)
	Polestar.Fire("STEP_CHANGED", current)
	Polestar.Fire("WAYPOINT_CHANGED", nil)
end

function Engine.GetTabs()
	saveTab()
	local out = {}
	for i, t in ipairs(tabs) do
		local g = uistub.guides[t.id]
		local done, total = tabProgress(t)
		out[i] = { guideId = t.id, title = g.title, category = g.category, stepIndex = t.step, stepCount = #g.steps,
			done = done, total = total, complete = t.step == nil }
	end
	return out, activeTab
end

function Engine.OpenTab(id, activate)
	record("OpenTab", id, activate)
	if not uistub.guides[id] then return nil end
	for i, t in ipairs(tabs) do
		if t.id == id then
			if activate ~= false then Engine.SelectTab(i) end
			return i
		end
	end
	if #tabs >= 6 then return nil end
	saveTab()
	tabs[#tabs + 1] = { id = id, step = 1 }
	uistub.started[id] = true
	if activate ~= false or not activeTab then
		loadTab(#tabs)
		activated()
	end
	tabsChanged()
	return #tabs
end

function Engine.CloseTab(i)
	record("CloseTab", i)
	if not tabs[i] then return end
	saveTab()
	table.remove(tabs, i)
	if activeTab == i then
		loadTab(#tabs > 0 and math.min(i, #tabs) or nil)
		activated()
	elseif activeTab and activeTab > i then
		activeTab = activeTab - 1
	end
	tabsChanged()
end

function Engine.SelectTab(i)
	record("SelectTab", i)
	if not tabs[i] or i == activeTab then return end
	saveTab()
	loadTab(i)
	activated()
	tabsChanged()
end

function Engine.MoveTab(from, to)
	record("MoveTab", from, to)
	if not tabs[from] or not tabs[to] then return end
	saveTab()
	local t = table.remove(tabs, from)
	table.insert(tabs, to, t)
	if activeTab == from then activeTab = to
	elseif activeTab and from < activeTab and to >= activeTab then activeTab = activeTab - 1
	elseif activeTab and from > activeTab and to <= activeTab then activeTab = activeTab + 1 end
	tabsChanged()
end

function Engine.GetGuideState(id)
	for _, t in ipairs(tabs) do
		if t.id == id then
			saveTab()
			local done, total = tabProgress(t)
			return t.step == nil and "done" or "started", done, total
		end
	end
	return uistub.started[id] and "started" or "new", nil, nil
end

function Engine.GetGuide() return guide end
function Engine.SetGuide(id)
	record("SetGuide", id)
	if id ~= nil and not uistub.guides[id] then return false end
	if id == nil then
		tabs, activeTab = {}, nil
		loadTab(nil)
		activated()
		tabsChanged()
		return true
	end
	for i, t in ipairs(tabs) do
		if t.id == id then
			Engine.SelectTab(i)
			return true
		end
	end
	if not activeTab then
		tabs[1] = { id = id, step = 1 }
		activeTab = 1
	else
		tabs[activeTab] = { id = id, step = 1 }
	end
	uistub.started[id] = true
	loadTab(activeTab)
	activated()
	tabsChanged()
	return true
end
function Engine.GetStepIndex() return current end
function Engine.GetStepCount() return guide and #guide.steps or 0 end
function Engine.GetStepView(i)
	if not guide or not guide.steps[i] then return nil end
	return view(i)
end
local function move(i)
	current = i
	uistub.aim = nil
	saveTab()
	Polestar.Fire("STEP_CHANGED", i)
	tabsChanged()
end
function Engine.Next() record("Next"); if guide and current then move(current < #guide.steps and current + 1 or nil) end end
-- Skip marks the step skipped, moves on and fires PLAYER_SKIPPED_STEP;
-- returns the skipped step.
function Engine.Skip()
	record("Skip")
	local s = current
	if s then uistub.skipped[s] = true end
	Engine.Next()
	if s then Polestar.Fire("PLAYER_SKIPPED_STEP", guide.id, s) end
	return s
end
function Engine.Unskip(i)
	record("Unskip", i)
	if not uistub.skipped[i] then return false end
	uistub.skipped[i] = nil
	move(i)
	return true
end
-- uistub.live: the live step when a test looks at another one (default: the step shown).
function Engine.GetLiveStep() return uistub.live or current end
function Engine.Prev() record("Prev"); if guide and current and current > 1 then move(current - 1) end end
function Engine.Goto(i) record("Goto", i); if guide and guide.steps[i] then move(i) end end
-- Any goal but a note ticks done and back.
function Engine.ToggleGoal(s, g)
	record("ToggleGoal", s, g)
	local goal = guide and guide.steps[s] and guide.steps[s].goals[g]
	if not goal or goal.t == "note" then return false end
	goal.ticked = not goal.ticked
	goal.status = goal.ticked and "done" or "active"
	Polestar.Fire("STEP_UPDATED", s)
	return true
end
-- Optional goals skip and come back.
function Engine.SkipGoal(s, g)
	record("SkipGoal", s, g)
	local goal = guide and guide.steps[s] and guide.steps[s].goals[g]
	if not (goal and goal.optional) then return false end
	goal.dismissed = not goal.dismissed or nil
	goal.status = goal.dismissed and "skipped" or "active"
	Polestar.Fire("STEP_UPDATED", s)
	return true
end
-- A goal of the step shown with a place: the arrow is aimed there
-- (uistub.aim), until the step changes.
function Engine.AimGoal(s, g)
	record("AimGoal", s, g)
	local goal = guide and guide.steps[s] and guide.steps[s].goals[g]
	if not (s == current and goal and goal.x) then return false end
	uistub.aim = { s, g }
	Polestar.Fire("WAYPOINT_CHANGED", Engine.GetWaypoint())
	return true
end
local function waypointOf(g, goal)
	return { map = goal.map, x = goal.x, y = goal.y, f = goal.f, label = goal.verb .. " " .. goal.subject, stepIndex = current, goalIndex = g, kind = goal.t, r = 8 }
end
function Engine.GetWaypoint()
	if not (guide and current) then return nil end
	local aim = uistub.aim
	if aim and aim[1] == current then
		local goal = guide.steps[current].goals[aim[2]]
		if goal and goal.x then return waypointOf(aim[2], goal) end
	end
	for g, goal in ipairs(guide.steps[current].goals) do
		if goal.x and (goal.status == "active" or goal.status == "pending") then return waypointOf(g, goal) end
	end
end
function Engine.GetProgress()
	if not guide then return 0, 0 end
	local done, total = 0, 0
	for i = 1, #guide.steps do
		local s = stepStatus(i)
		if s ~= "na" then
			total = total + 1
			if s == "done" then done = done + 1 end
		end
	end
	return done, total
end
function Engine.ResetProgress() record("ResetProgress") end
-- Candidate goals: the next-best trainer/vendor/inn.
function Engine.CycleCandidate(s, g)
	record("CycleCandidate", s, g)
	local goal = guide and guide.steps[s] and guide.steps[s].goals[g]
	if not (goal and goal.candidates) then return end
	goal.pick = (goal.pick or 1) % #goal.candidates + 1
	local c = goal.candidates[goal.pick]
	if goal.t == "collect" then
		-- A farm spot: the item stays; the mobs, their levels and the place change.
		goal.npcName, goal.lvl, goal.map, goal.x, goal.y = c.npcName, c.lvl, c.map, c.x, c.y
	else
		goal.subject, goal.npc, goal.map, goal.x, goal.y = c.npcName, c.npc, c.map, c.x, c.y
	end
	Polestar.Fire("STEP_UPDATED", s)
end
-- Goals with spawn areas: the next spot (recorded only).
function Engine.CycleSpot(s, g, index) record("CycleSpot", s, g, index) end

---------------------------------------------------------------------------
-- Registry, Nav, Compat
---------------------------------------------------------------------------

local Guides = {}
function Guides.Get(id) return id and uistub.guides[id] or nil end
function Guides.List()
	local out = {}
	for _, id in ipairs(uistub.order) do out[#out + 1] = header(uistub.guides[id]) end
	return out
end
-- uistub.suggest: the guide for the player's level; uistub.suggestions: the
-- whole ranked list when a test needs more than one.
function Guides.Suggestions() return uistub.suggestions or { uistub.suggest } end
function Guides.Suggest() return Guides.Suggestions()[1] end
-- The scenes' guides are all ours.
function Guides.SuggestSource() return "guides" end
-- Whether a character can follow a guide: the real registry's rule.
function Guides.GuideMatches(g, player) return uistub.realGuides.GuideMatches(g, player) end

local Nav = {}
function Nav.SetTarget(map, x, y, label, f, stop, z)
	record("SetTarget", map, x, y, label, f)
	-- `stop` and `z` sit after a nil `f` for most callers, so they are kept here, not in the call record.
	uistub.target = { map = map, x = x, y = y, label = label, f = f, stop = stop, z = z }
	Polestar.Fire("WAYPOINT_CHANGED", uistub.target)
end
function Nav.ClearTarget() record("ClearTarget"); uistub.target = nil end
-- Drops a point picked by hand: the Engine's waypoint is the target again.
function Nav.ReleaseTarget()
	record("ReleaseTarget")
	uistub.target = nil
	Polestar.Fire("WAYPOINT_CHANGED", Engine.GetWaypoint())
end
function Nav.GetTarget() return uistub.target or Engine.GetWaypoint() end
function Nav.GetDistance() return 42 end
function Nav.ResetArrowPosition() record("ResetArrowPosition") end
-- Nearby services (Nav/Nearby.lua): the guide window's list, and Go.
Nav.nearby = {
	MenuItems = function()
		return { { key = "vendor", label = "Vendor", icon = "icon-vendor" }, { key = "innkeeper", label = "Innkeeper", icon = "icon-sethome" },
			{ key = "trainer", line = 186, label = "Mining trainer", icon = "icon-skill" },
			{ key = "weapon", label = "Weapon master", icon = "icon-train", weapons = {
				{ key = "weapon", line = 43, label = "Swords" },
				{ key = "weapon", line = 173, label = "Daggers", known = true },
				{ key = "weapon", line = 229, label = "Polearms", level = 20 },
			} },
			{ separator = true }, { key = "bank", label = "Bank" } }
	end,
	Go = function(key, line) record("NearbyGo", key, line); return true end,
	-- uistub.trip: the trip under way ({ name, label }), set by the scenes.
	Trip = function() return uistub.trip end,
	EndTrip = function()
		record("NearbyEndTrip")
		local was = uistub.trip ~= nil
		uistub.trip = nil
		Polestar.Fire("NEARBY_TRIP", nil)
		return was
	end,
}

local MAPS = {
	[ELWYNN] = "Elwynn Forest", [1453] = "Stormwind City", [1426] = "Dun Morogh", [1436] = "Westfall",
	[1411] = "Durotar", [1412] = "Mulgore", [1413] = "The Barrens", [1454] = "Orgrimmar", [1456] = "Thunder Bluff",
	[1420] = "Tirisfal Glades", [1421] = "Silverpine Forest", [1424] = "Hillsbrad Foothills", [1442] = "Stonetalon Mountains",
	[1440] = "Ashenvale", [1441] = "Thousand Needles",
}
-- Anything the real Core asks that the UI scenes do not model answers nil
-- (no position, no quest state), the way an unknown client value would.
local Compat = setmetatable({}, { __index = function() return function() return nil end end })
function Compat.GetItemCount() return 0 end
function Compat.IsQuestCompleted() return false end
function Compat.IsOnQuest() return false end
function Compat.IsQuestReadyForTurnIn() return false end
function Compat.GetZoneText() return "Elwynn Forest", "" end
function Compat.IsOnTaxi() return false end
function Compat.IsInInstance() return false end
function Compat.GetPlayerInfo() return uistub.player end
function Compat.GetMapName(id) return MAPS[id] end
function Compat.GetQuestTitle() return nil end
function Compat.InCombat() return stub.inCombat end
-- The world map opener: a scene's global OpenWorldMap stands in for the client's.
function Compat.CanOpenWorldMap() return OpenWorldMap ~= nil end
function Compat.OpenWorldMap(map)
	if not OpenWorldMap or stub.inCombat then return false end
	OpenWorldMap(map)
	return true
end

-- opts: noNav (no Nav module), noTabs (an Engine without the tabs API).
function uistub.install(opts)
	opts = opts or {}
	if opts.noTabs then
		for _, k in ipairs({ "GetTabs", "OpenTab", "CloseTab", "SelectTab", "MoveTab", "GetGuideState" }) do Engine[k] = nil end
	end
	Polestar.Engine = Engine
	-- The real registry stays reachable for pages that show its records
	-- (the Community guides page): Polestar.Guides = uistub.realGuides.
	if Polestar.Guides ~= Guides then uistub.realGuides = Polestar.Guides end
	Polestar.Guides = Guides
	if not opts.noNav then Polestar.Nav = Nav end
	-- Whether another addon is there: the real check, over the C_AddOns stub.
	if Polestar.Compat ~= Compat then Compat.AddOnPresent = Polestar.Compat.AddOnPresent end
	Polestar.Compat = Compat
	-- The real modules register these; the fakes stand in for them.
	if not opts.noNav and Polestar.GetDefault("nav.arrow") == nil then
		Polestar.RegisterDefaults("nav", { arrow = true, arrowStyle = "3d", arrowScale = 1, arrowAlpha = 1, arrowEta = true,
			worldPins = true, minimapPins = true, trailDots = true, tomtom = true, useTomTomArrow = false, blizzardWaypoint = false, arrivalSound = true, travel = true,
			arrowColor = false, arrowNearColor = false })
	end
	if Polestar.GetDefault("behavior.autoAccept") == nil then
		Polestar.RegisterDefaults("behavior", { autoAccept = true, autoTurnin = true, autoNextGuide = true, autoSelectGuide = true, skipGrey = false })
	end
	-- An account and a character that have seen the welcome, so it never
	-- opens over windows under test; tests/ui-welcome.test.js restores the
	-- saved values.
	Polestar.DB().welcomeSeen = 1
	Polestar.CharState().welcomeSeen = 1
end

-- Show guide `id` at step `step` in the active tab (opening a first tab).
function uistub.setGuide(id, step)
	saveTab()
	if id == nil then
		tabs = {}
		loadTab(nil)
	else
		local found
		for i, t in ipairs(tabs) do if t.id == id then found = i end end
		if found then
			tabs[found].step = step or 1
			loadTab(found)
		elseif activeTab then
			tabs[activeTab] = { id = id, step = step or 1 }
			loadTab(activeTab)
		else
			tabs[1] = { id = id, step = step or 1 }
			loadTab(1)
		end
		uistub.started[id] = true
	end
	Polestar.Fire("GUIDE_CHANGED", id)
	if Engine.GetTabs then tabsChanged() end
end

-- Open several guides as tabs ({ { id, step }, ... }) and activate one.
function uistub.openTabs(list, active)
	tabs = {}
	for i, e in ipairs(list) do
		tabs[i] = { id = e[1], step = e[2] }
		uistub.started[e[1]] = true
	end
	loadTab(active or 1)
	Polestar.Fire("GUIDE_CHANGED", guide and guide.id)
	tabsChanged()
end

function uistub.setStep(i)
	current = i
	saveTab()
	Polestar.Fire("STEP_CHANGED", i)
end

function uistub.complete()
	current = nil
	saveTab()
	Polestar.Fire("GUIDE_COMPLETED", guide.id)
	Polestar.Fire("STEP_CHANGED", nil)
end

function uistub.goal(s, g) return guide.steps[s].goals[g] end
function uistub.update() Polestar.Fire("STEP_UPDATED", current) end

-- Frames the UI created so far.
function uistub.frameCount() return #stub.frames end

-- Find a visible font string under `root` whose text contains `needle`.
function uistub.findText(root, needle)
	local function walk(f)
		for _, r in ipairs(f.regions or {}) do
			if r.kind == "FontString" and r.text and r.text:find(needle, 1, true) and stub.Methods.IsVisible(r) then return r end
		end
		for _, c in ipairs(f.children or {}) do
			local hit = walk(c)
			if hit then return hit end
		end
	end
	return walk(root)
end
