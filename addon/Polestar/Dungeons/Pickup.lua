-- Polestar.Dungeons, picking up a dungeon's quests: which of a page's quests
-- this character can take before the run, what comes before each one, and a
-- guide that collects them on a travel route and ends at the entrance. The
-- guide is a Lookup planner kind ("pickup", Lookup/Guide.lua): registered as
-- "lookup/pickup/<key>", opened in a new tab, rebuilt after /reload.
--
--   Dungeons.PickupPlan(key) -> plan | nil, reason
--       plan = { dungeon, take = { { quest, rec, giver, pre = { rec, ... } } }, carried = { quest, ... },
--         done = n, later = n, waiting = { { quest, level, needs = rec | nil } }, closedBy = { [questId] = { questId } },
--         breadcrumbs = { { id, targets = { questId }, detour = seconds | nil, far, sea, taken } } | nil }
--       take: quests that apply (faction, race, class), not done, not in the log,
--       not closed for good (one of the page's `closedBy` done or in the log:
--       a breadcrumb whose quest is taken, as Klockmort's Essentials once
--       Essential Artificials is; counted in `done`),
--       open now or by the dungeon's lowest level (its prerequisites too:
--       one above that level puts it off as `later`, #1076; `waiting` lists
--       those, with the level each opens at and the prerequisite it waits on),
--       picked up outside from a
--       giver (not inside), or from an item that drops outside from a mob or
--       object with a known place, at MIN_DROP percent or more (any chance
--       when nothing in the dungeon drops it: the Dark Iron Map from Dun
--       Morogh's Dark Iron Spies, #1478), once the
--       item's quest's own prerequisites are done (Dungeons.DropPoint: the
--       Damp Note from Blackfathom Deeps' tunnel naga, #1380), not a follow-up
--       of another quest of this page -- unless the quests before it here are
--       errands (no objectives, any standing they name held, given (not by an
--       item, unless the item drops outside as above) and turned in outside by
--       an NPC or object this character may use: Hamuul Runetotem and Nara
--       Wildmane before Leaders of the Fang; the Damp Note's Allegiance to
--       the Old Gods before the one that sends the player after Lorgus Jett),
--       which are then done on the way as its prerequisites; one with a
--       prerequisite the guide cannot start out here waits until that one is
--       in the log or done (neither taken nor `later`): one an item starts
--       that is not in the bags, nor given by a quest before it, nor dropped
--       outside as above (The Unsent Letter, Edwin VanCleef's drop in the
--       Deadmines, before Bazil Thredd), or one with no placed giver or
--       turn-in (Finkle Einhorn inside Blackrock Spire); pre: the open
--       prerequisites, in the order they are done
--       (all of `pre`, one of `preAny`: Lookup.QuestChain), with the open
--       breadcrumbs of the page's chain each before the quest it leads to
--       (an errand turned in at that quest's giver, which nothing requires:
--       The Greenwarden before Tramping Paws, #1226; closedBy: the quest
--       that closes each). A quest done on the way to another is neither a
--       take of its own nor carried. A breadcrumb to a quest the plan takes
--       anyway (no objectives, required by none of the plan's quests) is left
--       out, from `take` and from `pre`, when it is a detour: its giver on a
--       continent no other stop is on, or over 300 seconds out of the way
--       (Castpipe's Task in Stonetalon for Gnomeregan's Data Rescue in
--       Ironforge); `breadcrumbs` says how each was judged.
--       carried: the page's quests already in the log. giver: a point
--       { kind, id, name, map, x, y, f }, or a drop point (kind "drop",
--       Dungeons.DropPoint): the step collects the item there, then takes
--       the quest from it. Each accept carries the page's `closedBy`, so the
--       Engine passes it once taken on the way.
--   Dungeons.PickupGuide(key) -> def | nil, reason   -- "nothing" when there is nothing to take
--   Dungeons.PickUp(key) -> guideId | nil, reason    -- builds, registers and opens it in a new tab
--   Dungeons.PickupLabel(plan) -> text   -- the button: "Pick up the quests", with the quests that
--       wait "(3 now · 2 at level 16)", none open now "Pick up the quests from level 16"
--   Dungeons.WaitingLines(plan) -> { text }   -- one per waiting quest: why it waits (its level,
--       the prerequisite it needs first)
--   The guide lists the waiting quests at the entrance, "Comes back at level N" in the accent. When
--   the character reaches one's level while that pick-up guide is the open tab, a chat line says
--   so and its giver (the first open prerequisite's) gets a pin on the map and minimap; the arrow
--   is left alone. The pins go when the tab changes or the quest is taken.
--   Dungeons.GiverTarget(key, questId) -> point, label, firstTitle, turnIn | nil
--       where to go for the quest: the giver of its first open prerequisite
--       (its turn-in, turnIn true, when that one is in the log), firstTitle
--       its title; else the quest's own giver; for a quest an item starts,
--       the nearest place of a mob or object that drops it outside
--       (Dungeons.DropPoint)
--   Dungeons.Giver(pq, from, rec?) -> point | nil
--       a page quest's giver for this character: nil when an item starts it
--       or it starts inside. The page keeps one giver; a quest several NPCs
--       give (Tabetha's Task: the mage trainers of both sides) goes to the
--       one of the character's side nearest `from` (Lookup.QuestEnd), never
--       to one of the other side; the page's place when it is the only one.
--       rec: the Codex quest (default: read now)
--   Dungeons.Ender(pq, from, rec?) -> point | nil
--       a page quest's turn-in for this character: the page's own place
--       when the character may talk to it, else the Codex ender of the
--       character's side nearest `from` (Lookup.QuestEnd). The page keeps
--       one ender: Storm, Earth, and Fire's is the Horde's Rau Cliffrunner,
--       and Alliance characters hand it in to Veyric Thunderhame. One of the
--       other side only when no ender is the character's.
--   Dungeons.StartDrops(key, pq, rec?) -> drops | nil
--       where the item that starts a page quest comes from, by the Codex's
--       item sources: drops = { item, itemName, inside = { src, ... },
--       outside = { src, ... } }, each list best chance first; src =
--       { kind = "npc"|"object", id, name, chance, spawns }. inside: an NPC
--       of this dungeon (its Codex `instance`); outside: one with a place
--       (spawns) outside it (the Damp Note's Blackfathom Tide Priestesses, in
--       the tunnels before the portal). nil when no item starts it, or the
--       Codex does not know the item.
--   Dungeons.DropPoint(key, pq, from, rec?) -> point | nil
--       the nearest place (from `from`) of the best outside source of the
--       item that starts the quest, one that gives it MIN_DROP percent of
--       the time or more, or, when no source inside the dungeon drops it (the
--       run cannot), the best one outside whatever its chance (known or not):
--       { kind = "drop", source = "npc"|"object", id, name,
--       map, x, y, f, z, item, itemName, chance }
--
-- Route: the cheapest path from where the player stands, through the
-- prerequisite quests (each after the one before it in its chain; after one,
-- the player stands at its turn-in) and the givers (one stop per giver with
-- every quest whose prerequisites are behind; a giver comes up again for a
-- quest still waiting), to the entrance (Dungeons.PlanStops: exact up to 12
-- stops, else nearest-next improved by moving stops). The carried quests are
-- listed as notes at the entrance, with a note on the hand-in guide for
-- after the run (Dungeons/Handin.lua). Travel: ns.TravelCost. The order is
-- kept per character, so a guide rebuilt without a position (after /reload)
-- keeps its route.
--
--   Dungeons.PlanStops(stops, from, finish, travel) -> order, cost
--       stops = { { inP, outP, deps = { index, ... } }, ... }
--   Dungeons.OrderStops(stops, from, finish, field, key) -> order
--       PlanStops from where the player stands, the stop keys kept as
--       CharState()[field][key]; without a position the kept order

local ADDON, ns = ...
local L = ns.L
local Dungeons = ns.Dungeons

local type, ipairs, pairs, format, sort = type, ipairs, pairs, string.format, table.sort
local max = math.max

local KIND = "pickup"
local FAR = 1e9
local MIN_DROP = 25 -- percent: a rarer drop (or one of no known chance) is left for the run, when the run can drop it; the Damp Note drops one in three
local SAME_SPOT = 10 -- seconds of travel: closer than this, a spawn on the entrance's zone is the one

local function LK() return ns.Lookup end

local function done(id) return ns.Compat.IsQuestCompleted(id) and true or false end
local function inLog(id) return ns.Compat.IsOnQuest(id) and true or false end

-- Whether a page quest is closed for good: a quest its `closedBy` names (the
-- one a breadcrumb leads to, one of its exclusive group) is done or in the log.
local function closed(pq)
	for _, by in ipairs(type(pq.closedBy) == "table" and pq.closedBy or {}) do
		if done(by) or inLog(by) then return true end
	end
	return false
end

local function located(p)
	return type(p) == "table" and p.map ~= nil and p.x ~= nil and p.y ~= nil
end

-- Lookup.QuestEnd's { npc|object, name, spawn } -> a point.
local function endPoint(e)
	if not (e and e.spawn) then return nil end
	local s = e.spawn
	return { kind = e.npc and "npc" or "object", id = e.npc or e.object, name = e.name, map = s.map, x = s.x, y = s.y, f = s.f }
end

-- Whether an NPC point is one the character may talk to (Lookup.SideOK on
-- the Codex NPC's faction; objects and unknown NPCs are).
local function sideOK(pt, p)
	if pt.kind ~= "npc" then return true end
	local npc = ns.Codex and ns.Codex.Npc(pt.id)
	return not npc or LK().SideOK(npc.faction, p)
end

function Dungeons.Giver(pq, from, rec)
	local s = pq.start
	if pq.startItem or pq.inside or (s and (s.kind == "item" or s.inside)) then return nil end
	local Lk = LK()
	rec = rec or (ns.Codex and ns.Codex.Quest(pq.id))
	local st = rec and rec.start
	if st and st.item and st.item[1] then return nil end
	local p = Lk.PlayerInfo()
	local page = s and (s.kind == "npc" or s.kind == "object") and s.id and located(s) and sideOK(s, p)
		and { kind = s.kind, id = s.id, name = s.name, map = s.map, x = s.x, y = s.y, f = s.f } or nil
	local givers = st and (#(st.npc or {}) + #(st.object or {})) or 0
	if page and givers <= 1 then return page end
	if givers > 0 then
		local e = Lk.QuestEnd(st, from, p)
		if e and e.hostile then return nil end
		if e then return endPoint(e) end
	end
	return page
end

function Dungeons.Ender(pq, from, rec)
	local f = pq.finish
	local page = f and (f.kind == "npc" or f.kind == "object") and f.id and located(f)
		and { kind = f.kind, id = f.id, name = f.name, map = f.map, x = f.x, y = f.y, f = f.f } or nil
	local Lk = LK()
	local p = Lk.PlayerInfo()
	if page and sideOK(page, p) then return page end
	rec = rec or (ns.Codex and ns.Codex.Quest(pq.id))
	local e = rec and Lk.QuestEnd(rec["end"], from, p)
	if e and not e.hostile then return endPoint(e) end
	return page or endPoint(e)
end

-- The item that starts a page quest -> item id | nil.
local function startItemOf(pq, rec)
	if type(pq.startItem) == "table" and pq.startItem.id then return pq.startItem.id end
	local s = pq.start
	if s and s.kind == "item" and s.id then return s.id end
	local st = rec and rec.start
	return st and st.item and st.item[1] or nil
end

local function byChance(a, b) return (a.chance or 0) > (b.chance or 0) end

function Dungeons.StartDrops(key, pq, rec)
	local C = ns.Codex
	if not C then return nil end
	rec = rec or C.Quest(pq.id)
	local id = startItemOf(pq, rec)
	local item = id and C.Item(id)
	if not item then return nil end
	local out = { item = id, itemName = item.name, inside = {}, outside = {} }
	for _, src in ipairs(item.sources or {}) do
		local kind, sid, r
		if src.type == "drop" and src.npc then
			kind, sid, r = "npc", src.npc, C.Npc(src.npc)
		elseif src.type == "object" and src.object then
			kind, sid, r = "object", src.object, C.Object(src.object)
		end
		if r then
			local d = { kind = kind, id = sid, name = r.name, chance = src.chance, spawns = r.spawns, faction = r.faction }
			if (src.instance or r.instance) == key then
				out.inside[#out.inside + 1] = d
			elseif not (src.instance or r.instance) and r.spawns and #r.spawns > 0 then
				out.outside[#out.outside + 1] = d
			end
		end
	end
	sort(out.inside, byChance)
	sort(out.outside, byChance)
	return out
end

-- The spawn of `spawns` to send the player to: the nearest (Lookup.Nearest),
-- or the nearest on map `zone` when that is no more than SAME_SPOT seconds
-- farther. The same spot is often listed on two maps (Blackfathom Deeps'
-- Tide Priestesses on Ashenvale and Darkshore, yards apart), and the guide
-- step should name the entrance's zone.
local function spawnOn(spawns, from, zone)
	local Lk = LK()
	local best, t = Lk.Nearest(spawns, from)
	if not (best and zone) or best.map == zone then return best end
	local own = {}
	for _, s in ipairs(spawns) do if s.map == zone then own[#own + 1] = s end end
	local o, ot = Lk.Nearest(own, from)
	if o and (not t or not ot or ot <= t + SAME_SPOT) then return o end
	return best
end

function Dungeons.DropPoint(key, pq, from, rec)
	local d = Dungeons.StartDrops(key, pq, rec)
	if not d then return nil end
	local dg = Dungeons.Get(key)
	local zone = dg and dg.entrance and dg.entrance.map
	-- Nothing inside drops it: the run is no second chance, so the outside
	-- sources are the only way, rare or of unknown chance (#1478: the Hall of
	-- Thanes' Underground Map starts from the Dark Iron Map, which only Dun
	-- Morogh's Dark Iron Spies drop, one kill in ten in players' recordings).
	-- Only a mob of no faction (one killed for it): a friendly NPC listed as
	-- the source hands the item over for something else first (Highlord
	-- Demitrian's Vessel of Rebirth, after the Bindings).
	local only = #d.inside == 0
	for _, s in ipairs(d.outside) do
		if (s.chance and s.chance >= MIN_DROP) or (only and s.kind == "npc" and not s.faction) then
			local p = spawnOn(s.spawns, from, zone)
			if p then
				return { kind = "drop", source = s.kind, id = s.id, name = s.name, map = p.map, x = p.x, y = p.y, f = p.f, z = p.z,
					item = d.item, itemName = d.itemName, chance = s.chance }
			end
		end
	end
	return nil
end

local function hasClass(list, class)
	if type(list) ~= "table" or #list == 0 or not class then return true end
	for _, c in ipairs(list) do
		if c == class then return true end
	end
	return false
end

local NOT_YOURS = { faction = true, race = true, class = true }

-- Whether a chain quest is an errand: nothing to do but talk (no
-- objectives, and any standing it names already held), given (not by an
-- item) and turned in outside by an NPC or object this character may use
-- (Wailing Caverns' Hamuul Runetotem and Nara Wildmane, Thunder Bluff before
-- Leaders of the Fang). Such a quest does not block the one after it even
-- when it is also on this page; it is done on the way instead. One an item
-- starts (Nefarian's head, a note that drops inside) is not one.
local function errand(r, from, p)
	if #(r.objectives or {}) > 0 then return false end
	if r.repFaction and r.repStanding
		and (tonumber((ns.Compat.GetFactionStanding(r.repFaction))) or 4) < r.repStanding then
		return false
	end
	local st = r.start
	if not st or (st.item and st.item[1]) then return false end
	local Lk = LK()
	local g = Lk.QuestEnd(st, from, p)
	if not (g and g.spawn and not g.hostile) then return false end
	local e = Lk.QuestEnd(r["end"], g.spawn, p)
	return (e and e.spawn and not e.hostile) and true or false
end

-- Whether the pick-up guide can start chain quest r out here, as its step
-- (Lookup.QuestStep) would: a turn-in with a place, and a giver with one or
-- the item that starts it, in the bags or given by a quest before it in the
-- chain (`before`, records). One that is only a "First do the quest" note, or
-- an accept from an item the character lacks (Edwin VanCleef's An Unsent
-- Letter, inside the Deadmines), is not.
local function startable(r, before, from, p)
	local Lk = LK()
	local st = r.start
	local g = Lk.QuestEnd(st, from, p)
	local e = Lk.QuestEnd(r["end"], g and g.spawn or from, p)
	if not (e and e.spawn) then return false end
	if g and g.spawn then return true end
	local item = st and st.item and st.item[1]
	if not item then return false end
	if (tonumber(ns.Compat.GetItemCount(item, true)) or 0) > 0 then return true end
	for _, b in ipairs(before) do
		for _, list in ipairs({ b.rewards or {}, b.choices or {} }) do
			for _, id in ipairs(list) do
				if id == item then return true end
			end
		end
	end
	return false
end

-- A page quest's side when neither the Codex nor the quest database knows
-- it: that of the quests of this page it leads to (its `closedBy`, the page
-- quests whose chain names it) when they are all one side's. In Search of
-- Thaelrid leads only to the Alliance's Blackfathom Villainy (#1026).
local function ledSide(key, pq)
	local Lk, C = LK(), ns.Codex
	local side
	local function by(id)
		local q = Dungeons.Quest(key, id)
		local r = C.Quest(id)
		local s = (r and Lk.QuestSide(r)) or (q and q.faction)
		if s == "AH" or (side and s and s ~= side) then side = false end
		if side ~= false and s then side = s end
	end
	for _, id in ipairs(type(pq.closedBy) == "table" and pq.closedBy or {}) do by(id) end
	for _, q in ipairs(Dungeons.Quests(key)) do
		for _, id in ipairs(q.chain or {}) do
			if id == pq.id then by(q.id) end
		end
	end
	return side or nil
end

-- Why a page quest is not for this character (faction, race, class) | nil.
-- The character's own faction decides, never the page's filter.
local function notYours(key, pq, rec, p)
	local Lk = LK()
	if rec then
		local why = Lk.QuestBlock(rec, p)
		if NOT_YOURS[why] then return why end
	end
	local side = (rec and Lk.QuestSide(rec)) or pq.faction or ledSide(key, pq)
	if not Lk.SideOK(side, p) then return "faction" end
	if not hasClass(pq.classes, p.class) then return "class" end
	return nil
end

-- Whether quest record r starts at an NPC or object of `ends` (a record's
-- start/end lists).
local function startsAt(r, ends)
	local st = r.start
	if not (st and type(ends) == "table") then return false end
	for _, kind in ipairs({ "npc", "object" }) do
		for _, a in ipairs(st[kind] or {}) do
			for _, b in ipairs(ends[kind] or {}) do
				if a == b then return true end
			end
		end
	end
	return false
end

-- Whether every prerequisite of record r is done (all of `pre`, one of
-- `preAny`).
local function preDone(r)
	for _, id in ipairs(r.pre or {}) do
		if not done(id) then return false end
	end
	local any = r.preAny or {}
	if #any == 0 then return true end
	for _, id in ipairs(any) do
		if done(id) then return true end
	end
	return false
end

-- Whether a chain quest is a delivery an item starts that drops outside
-- (Dungeons.DropPoint), turned in outside by an NPC or object this
-- character may use, with its own prerequisites done: Blackfathom Deeps'
-- Allegiance to the Old Gods, the Damp Note from the tunnel naga to Je'neu
-- Sancrea, who then gives the quest for Lorgus Jett (#1380). Done on the
-- way like an errand. One whose own prerequisites are still open is not, so
-- no trip is added for them (Trouble in the Deeps, from Stonetalon).
local function dropErrand(key, r, from, p)
	if #(r.objectives or {}) > 0 or not preDone(r) then return false end
	local d = Dungeons.DropPoint(key, r, from, r)
	if not d then return false end
	local e = LK().QuestEnd(r["end"], d, p)
	return (e and e.spawn and not e.hostile) and true or false
end

-- pre (a page quest's open prerequisites, in order) with the open
-- breadcrumbs of its chain spliced in (#1226: Wetlands' The Greenwarden from
-- Menethil Harbor before Tramping Paws, on the way to Rethiel). A breadcrumb
-- is a quest the page's chain lists that no quest of the chain names as a
-- prerequisite (the game does not require it), an errand this character can
-- take now that is turned in at the giver of one of the open prerequisites
-- still to take: it goes right before that one, and `closedBy[id]` names
-- the quest that closes it, so the Engine passes it once that is taken.
-- -> pre (a new list when one is spliced in)
local function withBreadcrumbs(pq, rec, pre, onPage, from, p, closedBy)
	local ids = type(pq.chain) == "table" and pq.chain or nil
	if not ids or #pre == 0 then return pre end
	local C, Lk = ns.Codex, LK()
	local named = { [pq.id] = true }
	local function name(r)
		for _, id in ipairs(r.pre or {}) do named[id] = true end
		for _, id in ipairs(r.preAny or {}) do named[id] = true end
	end
	name(rec)
	for _, r in ipairs(pre) do
		named[r.id] = true
		name(r)
	end
	local before = {}
	for _, id in ipairs(ids) do
		local b = not (named[id] or onPage[id] or done(id) or inLog(id)) and C.Quest(id) or nil
		-- A grey breadcrumb is left out: the game hides it from the giver's
		-- window unless low-level quests are shown (The Barrens Oases, a
		-- level 10 quest Arch Druid Hamuul never showed anyone from 16, #1436).
		if b and b.level and ns.Compat.IsQuestTrivial(b.level, p.level) then b = nil end
		if b and not Lk.QuestBlock(b, p) and preDone(b) and errand(b, from, p) then
			for _, r in ipairs(pre) do
				if not inLog(r.id) and startsAt(r, b["end"]) then
					local list = before[r.id] or {}
					before[r.id] = list
					list[#list + 1] = b
					closedBy[id] = { r.id }
					break
				end
			end
		end
	end
	if not next(before) then return pre end
	local out = {}
	for _, r in ipairs(pre) do
		for _, b in ipairs(before[r.id] or {}) do out[#out + 1] = b end
		out[#out + 1] = r
	end
	return out
end

-- A breadcrumb the plan would take on a long detour (the dungeon sweep,
-- 2026-11-08: Gnomeregan's Alliance guide sent a Stormwind player to
-- Stonetalon for Castpipe's Task and to Darnassus for Klockmort's Essentials,
-- both leading to Ironforge quests it took anyway). A breadcrumb here is a
-- quest the plan accepts that has no objectives, that no quest of the plan
-- names as a prerequisite (the game does not require it), and that is turned
-- in where another quest the plan accepts is given (its target). Its detour
-- is the cheapest insertion of its giver on the way to its target's giver,
-- from where the player stands, the entrance, or any other stop of the plan
-- (another giver, a chain quest's giver or turn-in), breadcrumbs left out:
-- min over A of T(A, giver) + T(giver, target) - T(A, target). It is left out
-- when its giver is on a continent no other stop is on, when the detour is
-- over DETOUR seconds, or when it is a delivery across the sea (its giver on
-- another continent than every one of its targets) and the detour is over
-- NEAR seconds. Kept: one on the way (Tinkmaster Overspark in Stormwind for
-- a player there, The Greenwarden in Menethil Harbor, #1226), one across the
-- sea from a giver beside the player (Tabetha's Task at a city's mage
-- trainer), and any the plan cannot place.
-- DETOUR: over every dungeon page, both sides, the breadcrumbs players take
-- on the way cost at most 185 s (Speak with Ruga from Orgrimmar, A Troubled
-- Spirit), the real detours at least 479 s (Tran'rek in Stranglethorn for
-- Zul'Farrak's Scarab Shells in Tanaris); 300 s (about one zone crossed and
-- back) leaves a clear margin on both sides, and is many times what a
-- breadcrumb's few hundred XP takes to earn at these levels.
-- NEAR: a breadcrumb that crosses the sea is worth its few hundred XP only
-- when its giver is in the town the player is in (#1402, Geekmandem: from
-- Stonetalon Peak, Castpipe's Task at Windshear Crag cost 200 s of the
-- route, a walk of 394 s, for 230 XP and a quest Ironforge gives anyway).
-- Kept: Tabetha's Task at the Undercity's mage trainer for a player in the
-- Undercity (100 s), at Stormwind's (4 s). Left out
-- besides Castpipe's Task: A Troubled Spirit (Orgrimmar to Stonard, 185 s),
-- Tran'rek from the Undercity (Booty Bay to Gadgetzan, 243 s). 150 s sits
-- between.
local DETOUR = 300
local NEAR = 150

local function continentOf(pt)
	return pt and pt.map and (ns.Compat.MapToWorld(pt.map, pt.x, pt.y, pt.f)) or nil
end

-- plan, from -> plan without its detours; plan.breadcrumbs lists every
-- breadcrumb it judged, by id: { id, targets = { ids }, detour = seconds |
-- nil, far = another continent, sea = a delivery across the sea, taken }.
local function dropDetours(plan, from, p)
	local Lk, C = LK(), ns.Codex
	local T = Lk.Travel
	local recs, at, named, ids = {}, {}, {}, {}
	local stops = {}
	local function stop(pt) if located(pt) then stops[#stops + 1] = pt end end
	local function add(id, r, pt)
		if recs[id] or not r then return end
		recs[id], at[id] = r, pt
		ids[#ids + 1] = id
	end
	for _, t in ipairs(plan.take) do
		add(t.quest.id, t.rec or C.Quest(t.quest.id), t.giver)
		for _, q in ipairs(t.pre) do
			local g = Lk.QuestEnd(q.start, from, p)
			add(q.id, q, g and g.spawn)
		end
	end
	table.sort(ids)
	for _, r in pairs(recs) do
		for _, id in ipairs(r.pre or {}) do named[id] = true end
		for _, id in ipairs(r.preAny or {}) do named[id] = true end
	end
	-- breadcrumb id -> the quests it leads to (a delivery: turned in to
	-- someone other than its giver, who gives a quest of the plan)
	local crumbs = {}
	for _, id in ipairs(ids) do
		local r = recs[id]
		if not named[id] and not inLog(id) and #(r.objectives or {}) == 0 and located(at[id]) and not startsAt(r, r["end"]) then
			for _, tid in ipairs(ids) do
				if tid ~= id and located(at[tid]) and startsAt(recs[tid], r["end"]) then
					crumbs[id] = crumbs[id] or {}
					crumbs[id][#crumbs[id] + 1] = tid
				end
			end
		end
	end
	if not next(crumbs) then return plan end
	-- The other stops: where the player stands, the entrance, every other
	-- giver and chain turn-in.
	stop(from)
	stop(plan.dungeon.entrance)
	for _, id in ipairs(ids) do
		if not crumbs[id] then
			stop(at[id])
			local e = Lk.QuestEnd(recs[id]["end"], at[id] or from, p)
			stop(e and e.spawn)
		end
	end
	local drop = {}
	plan.breadcrumbs = {}
	for _, id in ipairs(ids) do
		local targets = crumbs[id]
		if targets then
			local g = at[id]
			local c, near = continentOf(g), false
			-- A delivery across the sea: no target given on its giver's continent.
			local sea = c ~= nil
			for _, tid in ipairs(targets) do
				local tc = continentOf(at[tid])
				if tc == nil or tc == c then sea = false end
			end
			local best
			for _, a in ipairs(stops) do
				near = near or continentOf(a) == c
				for _, tid in ipairs(targets) do
					local x, y, z = T(a, g), T(g, at[tid]), T(a, at[tid])
					if x and y and z and (not best or x + y - z < best) then best = x + y - z end
				end
			end
			local far = c ~= nil and not near
			drop[id] = far or (best ~= nil and (best > DETOUR or (sea and best > NEAR)))
			plan.breadcrumbs[#plan.breadcrumbs + 1] = { id = id, targets = targets, detour = best, far = far, sea = sea, taken = not drop[id] }
		end
	end
	if not next(drop) then return plan end
	local take = {}
	for _, t in ipairs(plan.take) do
		if not drop[t.quest.id] then
			local pre = {}
			for _, q in ipairs(t.pre) do
				if not drop[q.id] then pre[#pre + 1] = q end
			end
			t.pre = pre
			take[#take + 1] = t
		end
	end
	plan.take = take
	return plan
end

function Dungeons.PickupPlan(key)
	local d = Dungeons.Get(key)
	if not d then return nil, "unknown" end
	local Lk, C = LK(), ns.Codex
	if not (Lk and Lk.QuestChain and C) then return nil, "missing" end
	-- The quest database knows the sides a Codex built before a correction
	-- lacks (Lookup.QuestSide); it loads only while a quest feature wants it.
	local Q = ns.QuestDB
	if Q and Q.Load and not Q.IsLoaded() then Q.Load() end
	local p = Lk.PlayerInfo()
	local from = ns.PlayerPoint()
	local reach = max(p.level or 1, d.minLevel or 1)
	local quests = Dungeons.Quests(key)
	local onPage = {}
	for _, q in ipairs(quests) do onPage[q.id] = true end
	local plan = { dungeon = d, take = {}, carried = {}, done = 0, later = 0, waiting = {}, closedBy = {} }
	local function wait(pq, level, needs)
		plan.later = plan.later + 1
		plan.waiting[#plan.waiting + 1] = { quest = pq, level = level, needs = needs }
	end
	-- One alternative per exclusive group: a quest of this page or its chains
	-- clashes with one the plan already takes (or the log holds) when each
	-- closes the other (Ahn'Qiraj's The Path of the Protector, Invoker and
	-- Conqueror; Scholomance's left and right Valthalak amulet pieces). A
	-- breadcrumb is closed by the quest it leads to but does not close it,
	-- so it never clashes.
	local chosen = {}
	local function closes(a, b)
		local q = Dungeons.Quest(key, a)
		for _, by in ipairs(q and type(q.closedBy) == "table" and q.closedBy or {}) do
			if by == b then return true end
		end
		return false
	end
	local function clashes(id)
		local q = Dungeons.Quest(key, id)
		for _, by in ipairs(q and type(q.closedBy) == "table" and q.closedBy or {}) do
			if (chosen[by] or inLog(by)) and closes(by, id) then return true end
		end
		return false
	end
	for _, pq in ipairs(quests) do
		local rec = C.Quest(pq.id)
		if not notYours(key, pq, rec, p) then
			if done(pq.id) then
				plan.done = plan.done + 1
			elseif inLog(pq.id) then
				plan.carried[#plan.carried + 1] = pq
			elseif closed(pq) then
				plan.done = plan.done + 1
			elseif ((rec and rec.minLevel) or pq.minLevel or 1) > reach then
				-- One that starts inside (no giver out here, no drop outside)
				-- never comes to the pick-up guide: it does not wait for it.
				if Dungeons.Giver(pq, from, rec) or Dungeons.DropPoint(key, pq, from, rec) then wait(pq, (rec and rec.minLevel) or pq.minLevel) end
			else
				-- No giver: an item that drops outside starts it, once its
				-- own prerequisites are done (no trip for those, #1380).
				local giver = Dungeons.Giver(pq, from, rec) or (rec and preDone(rec) and Dungeons.DropPoint(key, pq, from, rec)) or nil
				local pre, ok, waitOn = {}, giver ~= nil, nil
				if ok and rec then
					local chain = Lk.QuestChain(pq.id, p, clashes)
					for i = 1, #chain - 1 do
						local r = chain[i]
						-- A follow-up of another quest here is taken after the
						-- run, unless it is an errand (or a delivery of an item
						-- that drops outside) done on the way; a prerequisite
						-- this character can never take blocks it.
						if (onPage[r.id] and not (errand(r, from, p) or dropErrand(key, r, from, p))) or NOT_YOURS[Lk.QuestBlock(r, p)] then ok = false end
						-- One it is too low for, now and by the dungeon's
						-- lowest level, puts it off as its own level would: Fury
						-- in the Depths (22) waits on The Dark Iron War (25), #1076.
						if (r.minLevel or 1) > reach and (not waitOn or r.minLevel > waitOn.minLevel) then waitOn = r end
						-- One the guide cannot start out here (an item the
						-- character lacks that drops nowhere outside, no placed
						-- giver or turn-in) leaves it for after that one: Bazil
						-- Thredd waits on The Unsent Letter, which drops in the
						-- Deadmines; the Damp Note drops outside (#1380).
						if not inLog(r.id) and not startable(r, pre, from, p)
							and not (preDone(r) and Dungeons.DropPoint(key, r, from, r)) then ok = false end
						pre[#pre + 1] = r
					end
				end
				-- A chain through an alternative the plan already ruled out
				-- (no other way in): this quest is closed by that choice.
				if ok and clashes(pq.id) then ok = false end
				for _, r in ipairs(ok and pre or {}) do
					if clashes(r.id) then ok = false; break end
				end
				if ok and waitOn then
					wait(pq, max(waitOn.minLevel, (rec and rec.minLevel) or pq.minLevel or 1), waitOn)
				elseif ok then
					pre = withBreadcrumbs(pq, rec, pre, onPage, from, p, plan.closedBy)
					plan.take[#plan.take + 1] = { quest = pq, rec = rec, giver = giver, pre = pre }
					chosen[pq.id] = true
					for _, r in ipairs(pre) do chosen[r.id] = true end
				end
			end
		end
	end
	-- A quest done on the way to a later one (its prerequisite, an errand
	-- of this page) is neither a take of its own nor carried.
	local onTheWay = {}
	for _, t in ipairs(plan.take) do
		for _, r in ipairs(t.pre) do onTheWay[r.id] = true end
	end
	if next(onTheWay) then
		local take = {}
		for _, t in ipairs(plan.take) do
			if not onTheWay[t.quest.id] then take[#take + 1] = t end
		end
		plan.take = take
		local carried = {}
		for _, pq in ipairs(plan.carried) do
			if not onTheWay[pq.id] then carried[#carried + 1] = pq end
		end
		plan.carried = carried
	end
	return dropDetours(plan, from, p)
end

-- The lowest level a waiting quest opens at; same: all open at that level.
local function firstLevel(plan)
	local lo, same = nil, true
	for _, w in ipairs(plan and plan.waiting or {}) do
		if type(w.level) == "number" then
			if lo and w.level ~= lo then same = false end
			if not lo or w.level < lo then lo = w.level end
		end
	end
	return lo, same
end

function Dungeons.PickupLabel(plan)
	local take, n = plan and #plan.take or 0, plan and #plan.waiting or 0
	local lo, same = firstLevel(plan)
	if n == 0 or not lo then return L["Pick up the quests"] end
	if take == 0 then return format(L["Pick up the quests from level %d"], lo) end
	return format(same and L["Pick up the quests (%d now · %d at level %d)"] or L["Pick up the quests (%d now · %d from level %d)"], take, n, lo)
end

function Dungeons.WaitingLines(plan)
	local out = {}
	for _, w in ipairs(plan and plan.waiting or {}) do
		local title = ns.Quoted(w.quest.title) or ""
		if w.needs then
			out[#out + 1] = format(L["%s: level %d, needs %s first"], title, w.level, ns.Quoted(w.needs.title) or "")
		else
			out[#out + 1] = format(L["%s: level %d"], title, w.level)
		end
	end
	return out
end

---------------------------------------------------------------------------
-- The route
---------------------------------------------------------------------------

-- The stop keys of the order kept for the character: CharState()[field][key].
local function savedOrder(field, key)
	local s = ns.CharState()
	local all = type(s[field]) == "table" and s[field] or nil
	return all and type(all[key]) == "table" and all[key] or nil
end

local function saveOrder(field, key, order)
	local s = ns.CharState()
	if type(s[field]) ~= "table" then s[field] = {} end
	s[field][key] = order
end

-- An accept goal at giver point g, with the height of the giver's spawn
-- there (Lookup.SpawnZ: the arrow walks to its floor, #1024). At a drop
-- point (Dungeons.DropPoint) the quest is taken from the item, as a guide's
-- "accept from item" (collectGoal comes first). It carries the quest's
-- prerequisites (Lookup.AcceptPre): when the step that does one is skipped
-- (The Defias Traitor's escort, before Gryan Stoutmantle's The Defias
-- Brotherhood), the accept says "Requires ... first" instead of sending the
-- player to a giver who does not offer it, #1406.
local function acceptGoal(pq, rec, g)
	local goal = { t = "accept", quest = pq.id, title = pq.title or (rec and rec.title),
		minLevel = (rec and rec.minLevel) or pq.minLevel, closedBy = type(pq.closedBy) == "table" and pq.closedBy or nil }
	if rec then LK().AcceptPre(goal, rec) end
	if g.kind == "drop" then
		goal.item, goal.itemName = g.item, g.itemName
		return goal
	end
	goal.map, goal.x, goal.y, goal.f = g.map, g.x, g.y, g.f == "e" and "e" or nil
	if g.kind == "object" then
		goal.object, goal.objName = g.id, g.name
	else
		goal.npc, goal.npcName = g.id, g.name
	end
	goal.z = LK().SpawnZ(g.kind == "object" and "object" or "npc", g.id, g)
	return goal
end

-- Collect the item that starts a quest at drop point d (Dungeons.DropPoint):
-- the mob or object nearest the player that gives it.
local function collectGoal(d)
	local goal = { t = "collect", item = d.item, itemName = d.itemName, count = 1, map = d.map, x = d.x, y = d.y, f = d.f == "e" and "e" or nil }
	if d.source == "object" then
		goal.object, goal.objName = d.id, d.name
	else
		goal.npc, goal.npcName = d.id, d.name
		goal.z = LK().SpawnZ("npc", d.id, d)
	end
	return goal
end

---------------------------------------------------------------------------
-- Stop order: the cheapest path from where the player stands through every
-- stop to the entrance, a path with a fixed end (a greedy nearest-next walk
-- that only appends the entrance would leave a city and come back to it).
---------------------------------------------------------------------------

local EXACT = 12 -- stops searched exactly; more: nearest-next, then improved

-- stops = { { inP, outP, deps = { stopIndex, ... } }, ... }: inP where the
-- stop starts, outP where the player stands after it, deps the stops that
-- must come before it. from: the player's point; finish: the entrance (nil:
-- the path ends at its last stop). travel(a, b) -> seconds | nil (nil and
-- unknown points cost FAR). -> order (stop indices), cost. Ties keep the
-- authored order.
function Dungeons.PlanStops(stops, from, finish, travel)
	local n = #stops
	local memoT = {}
	local function T(a, b)
		if a == nil or b == nil then return FAR end
		if a == b then return 0 end
		local row = memoT[a]
		if not row then
			row = {}
			memoT[a] = row
		end
		local t = row[b]
		if t == nil then
			t = travel(a, b) or FAR
			row[b] = t
		end
		return t
	end
	local function outOf(i) return i == 0 and from or stops[i].outP end
	local function tail(i) return finish and T(outOf(i), finish) or 0 end
	-- Bits as powers of two (Lua 5.1 has no bit operators).
	local pow = {}
	for i = 1, n do pow[i] = 2 ^ (i - 1) end
	local function has(mask, i) return math.floor(mask / pow[i]) % 2 == 1 end
	local function ready(mask, i)
		if has(mask, i) then return false end
		for _, d in ipairs(stops[i].deps) do
			if not has(mask, d) then return false end
		end
		return true
	end
	local order = {}
	if n == 0 then return order, tail(0) end
	if n <= EXACT then
		-- Best cost to finish from (mask of stops done, last stop), memoised.
		local full, memo, nextOf = 2 ^ n - 1, {}, {}
		local function best(mask, last)
			if mask == full then return tail(last) end
			local id = mask * (n + 1) + last
			local c = memo[id]
			if c then return c end
			local here = outOf(last)
			local bc, bi = math.huge, nil
			for i = 1, n do
				if ready(mask, i) then
					local v = T(here, stops[i].inP) + best(mask + pow[i], i)
					if v < bc then bc, bi = v, i end
				end
			end
			memo[id], nextOf[id] = bc, bi
			return bc
		end
		local total = best(0, 0)
		local mask, last = 0, 0
		while mask ~= full do
			local i = nextOf[mask * (n + 1) + last]
			if not i then break end -- a dependency cycle: the rest cannot be placed
			order[#order + 1] = i
			mask, last = mask + pow[i], i
		end
		if #order == n then return order, total end
		order = {}
	end
	-- Many stops: nearest-next first...
	local mask, last = 0, 0
	for _ = 1, n do
		local bc, bi = math.huge, nil
		for i = 1, n do
			if ready(mask, i) then
				local v = T(outOf(last), stops[i].inP)
				if v < bc then bc, bi = v, i end
			end
		end
		if not bi then break end
		order[#order + 1] = bi
		mask, last = mask + pow[bi], bi
	end
	-- ...then moved one stop at a time while that shortens the path and keeps
	-- every stop after its dependencies.
	local function cost(o)
		local c, prev = 0, 0
		for _, i in ipairs(o) do
			c = c + T(outOf(prev), stops[i].inP)
			prev = i
		end
		return c + tail(prev)
	end
	local function valid(o)
		local pos = {}
		for p, i in ipairs(o) do pos[i] = p end
		for p, i in ipairs(o) do
			for _, d in ipairs(stops[i].deps) do
				if not pos[d] or pos[d] > p then return false end
			end
		end
		return true
	end
	local c = cost(order)
	local improved, rounds = true, 0
	while improved and rounds < 50 do
		improved, rounds = false, rounds + 1
		for a = 1, #order do
			for b = 1, #order do
				if a ~= b then
					local o = {}
					for k, v in ipairs(order) do o[k] = v end
					local moved = table.remove(o, a)
					table.insert(o, b, moved)
					if valid(o) then
						local oc = cost(o)
						if oc < c then order, c, improved = o, oc, true end
					end
				end
			end
		end
	end
	return order, c
end

-- plan -> stops: each open prerequisite quest once (after the one before it
-- in its chain; it starts at its giver nearest the player and leaves the
-- player at its turn-in) and each giver once per set of prerequisites its
-- quests wait on (a giver comes up again for a quest still waiting).
local function stopsOf(plan, from)
	local Lk = LK()
	local stops, byKey = {}, {}
	local function add(s)
		stops[#stops + 1] = s
		byKey[s.key] = #stops
		return s
	end
	for _, t in ipairs(plan.take) do
		local prev
		local deps = {}
		for _, r in ipairs(t.pre) do
			local k = "q" .. r.id
			if not byKey[k] then
				-- A quest an item starts begins where the item drops (#1380).
				local start = endPoint(Lk.QuestEnd(r.start, from))
				local drop = not start and Dungeons.DropPoint(plan.dungeon.key, r, from, r) or nil
				local finish = endPoint(Lk.QuestEnd(r["end"], start or drop or from))
				add({ key = k, rec = r, inP = start or drop, outP = finish or start or drop, deps = {}, drop = drop })
			end
			local s = stops[byKey[k]]
			if prev and prev ~= byKey[k] then
				local dup = false
				for _, d in ipairs(s.deps) do dup = dup or d == prev end
				if not dup then s.deps[#s.deps + 1] = prev end
			end
			prev = byKey[k]
			deps[#deps + 1] = k
		end
		table.sort(deps)
		local g = t.giver
		local gk = "g" .. g.kind .. g.id
		local k = #deps > 0 and (gk .. "<" .. table.concat(deps, ",")) or gk
		local s = stops[byKey[k] or 0]
		if not s then
			local idx = {}
			for i, dk in ipairs(deps) do idx[i] = byKey[dk] end
			s = add({ key = k, giverKey = gk, giver = g, inP = g, outP = g, deps = idx, accepts = {} })
		end
		s.accepts[#s.accepts + 1] = t
	end
	return stops
end

-- stops (each with a unique `key`) -> order. With the player's position
-- (`from`) the cheapest path (PlanStops, ending at `finish` when given),
-- kept for the character as CharState()[field][key]; without one (a rebuild
-- after /reload) the kept order, then the authored one, each stop after its
-- dependencies.
function Dungeons.OrderStops(stops, from, finish, field, key)
	local order
	if from then
		order = Dungeons.PlanStops(stops, from, finish, LK().Travel)
		local keys = {}
		for i, s in ipairs(order) do keys[i] = stops[s].key end
		saveOrder(field, key, keys)
		return order
	end
	local rank = {}
	for i, k in ipairs(savedOrder(field, key) or {}) do rank[k] = i end
	local placed = {}
	order = {}
	for _ = 1, #stops do
		local bi, br
		for i, s in ipairs(stops) do
			local ok = not placed[i]
			for _, d in ipairs(s.deps) do ok = ok and placed[d] end
			local r = rank[s.key] or (1000 + i)
			if ok and (not br or r < br) then bi, br = i, r end
		end
		if not bi then break end
		placed[bi] = true
		order[#order + 1] = bi
	end
	return order
end

-- plan -> steps (the givers and prerequisites in route order): the
-- cheapest path to the entrance, or the order kept for the character.
local function route(key, plan)
	local Lk = LK()
	local from = ns.PlayerPoint()
	local stops = stopsOf(plan, from)
	local e = plan.dungeon.entrance
	local finish = located(e) and { map = e.map, x = e.x, y = e.y, f = e.f == "e" and "e" or nil } or nil
	local order = Dungeons.OrderStops(stops, from, finish, "dungeonPickup", key)
	local steps, pos, lastGiver = {}, from, nil
	for _, i in ipairs(order) do
		local s = stops[i]
		if s.giver then
			-- Stops at the same giver in a row are one step.
			local step = lastGiver == s.giverKey and steps[#steps] or nil
			if not step then
				step = { title = s.giver.name or L["Quest giver"], goals = {} }
				steps[#steps + 1] = step
			end
			if s.giver.kind == "drop" then step.goals[#step.goals + 1] = collectGoal(s.giver) end
			for _, t in ipairs(s.accepts) do step.goals[#step.goals + 1] = acceptGoal(t.quest, t.rec, s.giver) end
			lastGiver = s.giverKey
		else
			local step = Lk.QuestStep(s.rec, s.inP or pos)
			-- One an item starts collects the item first, where it drops.
			if s.drop and step and step.goals and step.goals[1] and step.goals[1].t == "accept" then
				table.insert(step.goals, 1, collectGoal(s.drop))
			end
			-- A breadcrumb's accept knows the quest that closes it.
			local by = plan.closedBy and plan.closedBy[s.rec.id]
			if by and step then
				for _, g in ipairs(step.goals or {}) do
					if g.t == "accept" and g.quest == s.rec.id then g.closedBy = by end
				end
			end
			steps[#steps + 1] = step
			lastGiver = nil
		end
		pos = s.outP or pos
	end
	return steps
end

function Dungeons.PickupGuide(key)
	local plan, err = Dungeons.PickupPlan(key)
	if not plan then return nil, err end
	if #plan.take == 0 then return nil, "nothing" end
	local d = plan.dungeon
	local steps = route(key, plan)
	if #steps == 0 then return nil, "nothing" end
	local last = { title = d.name, goals = {} }
	for _, pq in ipairs(plan.carried) do
		last.goals[#last.goals + 1] = { t = "note", text = format(L["In your log already: %s"], ns.Quoted(pq.title) or "") }
	end
	-- The quests that wait for a level, in the accent: they come back then
	-- (a chat line and a map pin say so, below).
	local Theme = ns.Theme
	local accent = Theme and Theme.Hex and Theme.Hex("accent")
	local watched = {}
	for _, w in ipairs(plan.waiting) do
		local text = format(L["Comes back at level %d: %s"], w.level, ns.Quoted(w.quest.title) or "")
		last.goals[#last.goals + 1] = { t = "note", text = accent and ("|c" .. accent .. text .. "|r") or text }
		watched[#watched + 1] = { id = w.quest.id, title = w.quest.title, level = w.level }
	end
	Dungeons.watch[key] = watched
	local e = d.entrance
	if located(e) then
		-- A way in through the other faction's land says so on the step.
		local enemy = Dungeons.EnemyEntrance and Dungeons.EnemyEntrance(key)
		if enemy then last.note = enemy end
		last.goals[#last.goals + 1] = { t = "goto", text = L["Enter"] .. " " .. d.name, map = e.map, x = e.x, y = e.y, f = e.f == "e" and "e" or nil }
	end
	-- The hand-in half (Dungeons/Handin.lua) is built after the run, from the
	-- quests then finished; this guide's own end offers it too (UI/GuideFrame).
	last.goals[#last.goals + 1] = { t = "note", text = format(L["After the run: open this dungeon's page (/polestar dungeons %s) and choose Hand in the quests."], d.name) }
	steps[#steps + 1] = last
	return { title = format(L["%s: pick up the quests"], d.name), steps = steps, dungeon = key }
end

function Dungeons.PickUp(key)
	if not Dungeons.IsEnabled() then return nil, "off" end
	local Lk = LK()
	if not (Lk and Lk.Guide) then return nil, "missing" end
	return Lk.Guide(KIND, key)
end

---------------------------------------------------------------------------
-- The waiting quests at their level
---------------------------------------------------------------------------

-- [key] = { { id, title, level, told } }: the open pick-up guides' waiting
-- quests (PickupGuide fills it; a rebuild after /reload too).
Dungeons.watch = {}
local PINS = "dungeonPickupLater"
local marked = {} -- quest id -> pin

-- The key of the pick-up guide in the active tab, or nil.
local function openKey()
	local E = ns.Engine
	local g = E and E.GetGuide and E.GetGuide()
	local id = g and g.id
	return type(id) == "string" and id:match("^lookup/" .. KIND .. "/(.+)$") or nil
end

local function showPins()
	local P = ns.Pins
	if not (P and P.SetLayer) then return end
	local pins = {}
	for id, pin in pairs(marked) do
		if inLog(id) or done(id) then marked[id] = nil else pins[#pins + 1] = pin end
	end
	if #pins > 0 then P.SetLayer(PINS, pins, { world = true, minimap = true }) else P.ClearLayer(PINS) end
end

function Dungeons.LevelReached(level)
	local key = openKey()
	local list = key and Dungeons.watch[key]
	if type(level) ~= "number" or not list then return end
	local Theme, changed = ns.Theme, false
	for _, w in ipairs(list) do
		if not w.told and w.level <= level and not done(w.id) and not inLog(w.id) then
			w.told = true
			ns.Print(format(L["Level %d: you can take %s now. Its giver is marked on your map; pick up the quests again to add it to the guide."], level, ns.Quoted(w.title) or ""))
			local pt = Dungeons.GiverTarget(key, w.id)
			if pt and located(pt) then
				local r, g, b = 1, 0.82, 0
				if Theme and Theme.Accent then r, g, b = Theme.Accent() end
				marked[w.id] = { map = pt.map, x = pt.x, y = pt.y, f = pt.f == "e" and "e" or nil, icon = "map:quest-available", size = 22,
					color = { r, g, b, 1 }, ring = { r, g, b, 1 }, tooltip = w.title }
				changed = true
			end
		end
	end
	if changed then showPins() end
end

ns.RegisterEvent("PLAYER_LEVEL_UP", function(_, level) Dungeons.LevelReached(level) end)
ns.RegisterEvent("QUEST_ACCEPTED", function() if next(marked) then showPins() end end)
ns.On("GUIDE_CHANGED", function()
	if next(marked) and not openKey() then
		marked = {}
		showPins()
	end
end)

-- The pickup kind builds only while Dungeons is on.
if ns.Lookup and ns.Lookup.RegisterPlanner then
	ns.Lookup.RegisterPlanner(KIND, function(key)
		if not Dungeons.IsEnabled() then return nil, "off" end
		local ok, reason = Dungeons.Load()
		if not ok then return nil, reason end
		return Dungeons.PickupGuide(key)
	end)
end

---------------------------------------------------------------------------
-- One quest's giver
---------------------------------------------------------------------------

-- A quest of the chain -> where to go for it, turnIn: its turn-in when it is
-- in the log, else its giver (Dungeons.Giver for a page quest; an item that
-- starts it where the page places one, else where it drops outside).
local function chainPoint(key, id, rec, from)
	local Lk = LK()
	local cq = Dungeons.Quest(key, id)
	if inLog(id) then
		local e = rec and endPoint(Lk.QuestEnd(rec["end"], from))
		if e then return e, true end
		if cq and located(cq.finish) then return cq.finish, true end
		return nil
	end
	if cq then
		local g = Dungeons.Giver(cq, from, rec)
		if g then return g, false end
		local s = cq.start
		if located(s) and not s.inside and (s.kind == "item" or cq.startItem) then return s, false end
	end
	local d = (cq or rec) and Dungeons.DropPoint(key, cq or rec, from, rec)
	if d then return d, false end
	local e = rec and Lk.QuestEnd(rec.start, from)
	return e and not e.hostile and endPoint(e) or nil, false
end

function Dungeons.GiverTarget(key, questId)
	local pq = Dungeons.Quest(key, questId)
	if not pq then return nil end
	if not (done(questId) or inLog(questId)) then
		local Lk, C = LK(), ns.Codex
		local rec = Lk and Lk.QuestChain and C and C.Quest(questId)
		if rec then
			local first = Lk.QuestChain(questId, Lk.PlayerInfo())[1]
			if first and first.id ~= questId then
				local pt, turnIn = chainPoint(key, first.id, first, ns.PlayerPoint())
				if pt then return pt, pt.name, first.title, turnIn end
			end
		else
			for _, cid in ipairs(pq.chain or {}) do
				if not done(cid) then
					local cq = Dungeons.Quest(key, cid)
					local pt, turnIn = chainPoint(key, cid, nil, nil)
					if pt then return pt, pt.name, cq and cq.title, turnIn end
					break
				end
			end
		end
	end
	local g = Dungeons.Giver(pq, ns.PlayerPoint())
	if g then return g, g.name end
	local d = Dungeons.DropPoint(key, pq, ns.PlayerPoint())
	if d then return d, d.name end
	local s = pq.start
	if located(s) and (s.inside or s.kind == "item" or pq.startItem) then return s, s.name end
	return nil
end
