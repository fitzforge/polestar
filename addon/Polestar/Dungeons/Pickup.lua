-- Polestar.Dungeons, picking up a dungeon's quests: which of a page's quests
-- this character can take before the run, what comes before each one, and a
-- guide that collects them on a travel route and ends at the entrance. The
-- guide is a Lookup planner kind ("pickup", Lookup/Guide.lua): registered as
-- "lookup/pickup/<key>", opened in a new tab, rebuilt after /reload.
--
--   Dungeons.PickupPlan(key, offer) -> plan | nil, reason
--       offer: the heads-up's rule (UI/DungeonToast.lua: whether a dungeon
--       is due): a quest more than one level above the character
--       (Dungeons.OFFER_MARGIN) waits for its level less one, as `later`;
--       without it (the pick-up guide, however it is opened) every quest the
--       game gives now or by the dungeon's lowest level.
--       plan = { dungeon, take = { { quest, rec, giver, pre = { rec, ... } } }, carried = { quest, ... },
--         done = n, later = n, waiting = { { quest, level, needs = rec | nil } }, closedBy = { [questId] = { questId } },
--         breadcrumbs = { { id, targets = { questId }, detour = seconds | nil, far, sea, taken } } | nil }
--       take: quests that apply (faction, race, class), not done, not in the log,
--       not closed for good (one of the page's `closedBy` done or in the log:
--       a breadcrumb whose quest is taken, as Klockmort's Essentials once
--       Essential Artificials is; counted in `done`), not one handed in at one
--       talk and never in the log (the page's `direct`: Pozzik's Indurium Ore,
--       #2241; the hand-in guide hands it in),
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
--       Deadmines, before Bazil Thredd), one with no placed giver or
--       turn-in (Finkle Einhorn inside Blackrock Spire), or one whose
--       objective only an instance gives (insideOnly: Scholomance's Kirtonos
--       the Herald before Stratholme's Menethil's Gift); pre: the open
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
--       Ironforge); `breadcrumbs` says how each was judged. A breadcrumb
--       the plan takes, or one in the log, turned in where another quest the
--       plan takes is given is done on that quest's way, handed in right
--       before its accept (the last of its `pre`): the game holds a quest back
--       while its breadcrumb is in the log (Gnogaine while The Day After is,
--       #2046).
--       carried: the page's quests already in the log. giver: a point
--       { kind, id, name, map, x, y, f }, or a drop point (kind "drop",
--       Dungeons.DropPoint): the step collects the item there, then takes
--       the quest from it. Each accept carries the page's `closedBy`, so the
--       Engine passes it once taken on the way.
--   Dungeons.OfferLevel(pq, rec) -> level   -- the level the heads-up offers page quest pq from
--   Dungeons.PreDone(rec) -> bool   -- every prerequisite of Codex quest rec done (all of `pre`, one of `preAny`)
--   Dungeons.PickupGuide(key) -> def | nil, reason   -- "nothing" when there is nothing to take;
--       every quest the game gives now: a player who opens it chose the run, so
--       a quest two levels up comes along (Fitz, #3063: Corruption of Earth and
--       Seed at 49, which the heads-up's rule held back to 50)
--   Dungeons.PickUp(key) -> guideId | nil, reason    -- builds, registers and opens it in a new tab
--   Dungeons.PickupLabel(plan) -> text   -- the button: "Pick up the quests", with the quests that
--       wait "(3 now · 2 at level 16)", none open now "Pick up the quests from level 16"
--   Dungeons.WaitingLines(plan) -> { text }   -- one per waiting quest: why it waits (its level,
--       the prerequisite it needs first)
--   Dungeons.OpensNote(quests, breadcrumb, note) -> text | note
--       a prerequisite's line: "Needed for “A”, “B”." (a breadcrumb:
--       "Leads to “A”."), the quests ({ title }, ...) it comes before, then
--       `note`; `note` unchanged when there are none.
--   Dungeons.MarkOpens(step, quest, opens, breadcrumb)
--       puts OpensNote's line on the step's accept of `quest` (else its first
--       goal) as that goal's note, before the goal's own: the guide window
--       shows it under the goal, compact mode too, where the step's note (its
--       tip) is folded away. The pick-up and attunement guides mark every
--       quest they add to reach one of theirs (Fitz, 0.3.7-rc1: nothing on
--       A Recipe For Death's steps said they were there for the Ruins of
--       Lordaeron's The New Plague).
--   The pick-up guide's first goal also says how many of its steps are such
--   prerequisites and about how long they take: "5 of this guide's 10 steps
--   are prerequisite quests (about 1 h 15 min)." (Dungeons.PrereqTime of
--   Dungeons.PrereqSeconds summed; rounded to 5 minutes). It once read
--   "Prerequisite quests: 7 of 10 steps", which players took for their
--   progress through the guide (#2709).
--   Dungeons.PrereqSeconds(step, rec, pos) -> seconds   -- a prerequisite step's rough time:
--       the travel from `pos` through the step's goal points in order (its
--       giver, the places of its objectives, its turn-in: LK().Travel) times
--       TRAVEL_FACTOR, plus STEP_SECONDS, plus its quest's objectives
--       (Dungeons.ObjectiveSeconds); calibrated on players' recordings (below)
--   Dungeons.ObjectiveSeconds(o) -> seconds   -- a Codex quest objective's rough time:
--       KILL_SECONDS a kill, and for an item NPCs drop the kills its best drop
--       chance takes (6 Lake Skulker Moss at 60%: 10 kills); USE_SECONDS
--       anything else (an object, a talk, an item no NPC drops), per count
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
-- prerequisite quests (each after the quests it requires; after one,
-- the player stands at its turn-in) and the givers (one stop per giver with
-- every quest whose prerequisites are behind; a giver comes up again for a
-- quest still waiting), to the entrance (Dungeons.PlanStops: the stops at
-- hand first, then exact up to 12 stops, else the cheaper of nearest-next
-- and cheapest insertion, each improved by moving runs of up to three
-- stops). The carried quests are named in one line, the entrance
-- step's note, with a note on the hand-in guide for
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
-- The heads-up offers a quest from this many levels below its quest level.
Dungeons.OFFER_MARGIN = 1

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
			local d = { kind = kind, id = sid, name = r.name, chance = src.chance, spawns = r.spawns, faction = r.faction,
				requiresQuests = src.requiresQuests }
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
	local blocked
	for _, s in ipairs(d.outside) do
		if (s.chance and s.chance >= MIN_DROP) or (only and s.kind == "npc" and not s.faction) then
			local p = spawnOn(s.spawns, from, zone)
			if p then
				local point = { kind = "drop", source = s.kind, id = s.id, name = s.name, map = p.map, x = p.x, y = p.y, f = p.f, z = p.z,
					item = d.item, itemName = d.itemName, chance = s.chance, requiresQuests = s.requiresQuests }
				if (ns.Compat.GetItemCount(d.item, true) or 0) > 0 then return point end
				local steps, why, q = LK().DropQuestSteps(s, LK().PlayerInfo(), from)
				if steps then point.dropSteps = steps; return point end
				point.dropBlocked, point.dropQuest = why, q
				blocked = blocked or point
			end
		end
	end
	return blocked
end

local function hasClass(list, class)
	if type(list) ~= "table" or #list == 0 or not class then return true end
	for _, c in ipairs(list) do
		if c == class then return true end
	end
	return false
end

-- Profession: a quest for a profession the character has not learned (The
-- Demon Forge, Sweet Serenity: blacksmiths; The Spectral Chalice: miners)
-- is offered only to one who has it (Lookup.QuestBlock, as #2118's follow-ups).
local NOT_YOURS = { faction = true, race = true, class = true, profession = true }

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

-- Whether one of chain quest r's objectives can only be done inside an
-- instance, so not on a pick-up guide's way: a kill or talk of an NPC, or an
-- object to use, the Codex places in an instance and nowhere outside (Upper
-- Blackrock Spire's Rookery Eggs before Scholomance's Dawn's Gambit), or an item whose sources
-- the Codex knows are all mobs or objects of an instance or with no place
-- at all, one of them in an instance (no vendor, craft or placed mob or
-- object outside). Stratholme's pick-up guide sent Horde players through
-- Scholomance for Menethil's Gift (Kirtonos the Herald, Doctor Theolen
-- Krastinov) and after dungeon armour for Just Compensation (Bracers of
-- Valor): over five hours of "picking up" on the route planner's estimate.
-- An objective the Codex knows nothing of is not one.
local function insideOnly(r)
	local C = ns.Codex
	local function inside(x) return x and x.instance and not (x.spawns and #x.spawns > 0) end
	for _, o in ipairs(r.objectives or {}) do
		if (o.type == "kill" or o.type == "talk") and o.id then
			if inside(C.Npc(o.id)) then return true end
		elseif o.type == "object" and o.id then
			if inside(C.Object(o.id)) then return true end
		elseif o.type == "item" and o.id then
			local it = C.Item(o.id)
			local sources = it and it.sources or {}
			local within, outside = false, false
			for _, src in ipairs(sources) do
				local x = (src.type == "drop" and src.npc and C.Npc(src.npc)) or (src.type == "object" and src.object and C.Object(src.object)) or nil
				if (src.type == "drop" or src.type == "object") and src.instance then
					within = true -- the Codex names its instance, even for an object it holds no record of (#2883)
				elseif not x then
					outside = true -- a vendor, a craft, a source the Codex does not hold
				elseif x.instance then
					within = true
				elseif x.spawns and #x.spawns > 0 then
					outside = true
				end
			end
			if within and not outside then return true end
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

-- Why a page quest is not for this character (faction, race, class, profession) | nil.
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
-- `preAny`). Dungeons.PreDone: the hand-in guide's direct hand-ins ask it too.
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
Dungeons.PreDone = preDone

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
-- (another giver, a chain quest's giver or turn-in), breadcrumbs left out
-- (one with a prerequisite of its own in the plan: from that one's turn-in
-- or the entrance only; a delivery across the sea without one: from where
-- the player stands only, when located):
-- min over A of T(A, giver) + T(giver, target) - T(A, target). It is left out
-- when its giver is on a continent none of those anchors is on, when the
-- detour is over DETOUR seconds, or when it is a delivery across the sea
-- (its giver on another continent than every one of its targets) and the
-- detour is over NEAR seconds. Kept: one on the way (Tinkmaster Overspark
-- in Stormwind for a player there, The Greenwarden in Menethil Harbor,
-- #1226), one across the sea from a giver beside the player (Tabetha's Task
-- at a city's mage trainer), and any the plan cannot place.
-- DETOUR: over every dungeon page, both sides, the breadcrumbs players take
-- on the way cost at most 185 s (Speak with Ruga from Orgrimmar, A Troubled
-- Spirit), the real detours at least 479 s (Tran'rek in Stranglethorn for
-- Zul'Farrak's Scarab Shells in Tanaris); 300 s (about one zone crossed and
-- back) leaves a clear margin on both sides, and is many times what a
-- breadcrumb's few hundred XP takes to earn at these levels.
-- NEAR: a breadcrumb that crosses the sea is worth its few hundred XP only
-- when its giver is in the town the player is in (#1402, Geekmandem: from
-- Stonetalon Peak, Castpipe's Task at Windshear Crag cost 200 s of the
-- route, a walk of 394 s, for 230 XP and a quest Ironforge gives anyway;
-- #2795: at Nijel's Point for Scarlet Monastery, Brother Anton from Brother
-- Crowley in Stormwind is judged from where the player stands rather than
-- from other Eastern Kingdoms stops on the route).
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
	-- A breadcrumb with a prerequisite of its own in the plan opens only once
	-- that one is turned in: its detour is measured from there (and from the
	-- entrance), never from a stop the route passes before it. Blackrock
	-- Spire's Tinkee Steamboil, Felnok Steelspring's in Winterspring, opens
	-- after Return to Tinkee is handed in at Flame Crest; measured from
	-- Felnok's own earlier visit it looked free, and the Horde guide flew
	-- back to Winterspring and to the Badlands for it (over half an hour).
	local function afterOwn(r)
		local list
		for _, k in ipairs({ "pre", "preAny" }) do
			for _, pid in ipairs(r[k] or {}) do
				if recs[pid] then
					local e = Lk.QuestEnd(recs[pid]["end"], at[pid] or from, p)
					if e and located(e.spawn) then
						list = list or {}
						list[#list + 1] = e.spawn
					end
				end
			end
		end
		if list and located(plan.dungeon.entrance) then list[#list + 1] = plan.dungeon.entrance end
		return list
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
			local own = afterOwn(recs[id])
			local anchors = own or (sea and located(from) and { from }) or stops
			for _, a in ipairs(anchors) do near = near or continentOf(a) == c end
			local best
			for _, a in ipairs(anchors) do
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

-- A breadcrumb holds the quest it leads to back while it is in the log: in
-- players' recordings, The Forgotten Pools was refused to 12 people while The
-- Barrens Oases was in their log and offered to 30 who never had it, and the
-- Gnomeregan guide took The Day After and then asked Ozzie Togglevolt for
-- Gnogaine (#2046). A take, or a quest in the log, with no objectives of its
-- own and nothing before it, turned in where another take is given (its
-- target, as dropDetours reads breadcrumbs), goes on its target's way: the
-- last of the target's `pre`, so the guide takes it if need be and hands it
-- in right before the target's accept; its accept keeps the quests that close
-- it (`closedBy`). Neither a take of its own nor carried then.
-- plan, key -> plan
local function crumbsFirst(plan, key)
	local C = ns.Codex
	local function recOf(t) return t.rec or C.Quest(t.quest.id) end
	local function crumb(r)
		return r and #(r.objectives or {}) == 0 and not startsAt(r, r["end"])
	end
	local function onWay(id, r)
		for _, t in ipairs(plan.take) do
			local tr = recOf(t)
			if t.quest.id ~= id and not t.crumbOf and tr and startsAt(tr, r["end"]) then
				for _, q in ipairs(t.pre) do
					if q.id == id then return true end
				end
				t.pre[#t.pre + 1] = r
				local pq = Dungeons.Quest(key, id)
				plan.closedBy[id] = (pq and type(pq.closedBy) == "table" and pq.closedBy) or { t.quest.id }
				return true
			end
		end
		return false
	end
	local take = {}
	for _, t in ipairs(plan.take) do
		local r = recOf(t)
		if #t.pre == 0 and crumb(r) and onWay(t.quest.id, r) then
			t.crumbOf = true
		else
			take[#take + 1] = t
		end
	end
	plan.take = take
	local carried = {}
	for _, pq in ipairs(plan.carried) do
		local r = C.Quest(pq.id)
		if not (crumb(r) and onWay(pq.id, r)) then carried[#carried + 1] = pq end
	end
	plan.carried = carried
	return plan
end

-- The level from which the heads-up offers page quest pq (rec: its Codex
-- quest): one below its quest level (Fitz, 2026-11-10: the game offers many
-- 3-5 levels early, and the dungeon cards stacked up there), never below the
-- level the game takes it at.
function Dungeons.OfferLevel(pq, rec)
	local qlvl = (rec and tonumber(rec.level)) or tonumber(pq.level) or 0
	return max(qlvl - Dungeons.OFFER_MARGIN, (rec and rec.minLevel) or pq.minLevel or 1)
end

-- A page quest whose only reward is money, with no experience and no item:
-- a repeatable hand-in such as Indurium Ore's six silver, which the Uldaman
-- pick-up guide reached through seven quests before it (#2092). The page's
-- rewards (Dungeons.Quest: rewards = { items, xp, money }) and the Codex
-- record's say so; a quest whose rewards the data does not know (no money
-- either: a Forever quest without a reward row) is not one.
local function moneyOnly(pq, rec)
	local r = type(pq.rewards) == "table" and pq.rewards or nil
	local money = r and tonumber(r.money)
	if not (money and money > 0) then return false end
	if tonumber(r.xp) or (rec and tonumber(rec.xp)) then return false end
	if type(r.items) == "table" and #r.items > 0 then return false end
	if rec and ((type(rec.rewards) == "table" and #rec.rewards > 0) or (type(rec.choices) == "table" and #rec.choices > 0)) then return false end
	return true
end

function Dungeons.PickupPlan(key, offer)
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
			elseif moneyOnly(pq, rec) then
				-- Nothing to gain but a few silver: never a pick-up of its
				-- own, nor a trip through its prerequisites (#2092).
			elseif pq.direct then
				-- Handed in at one talk and never in the log (Pozzik's
				-- Indurium Ore, #2241): nothing to pick up; the hand-in
				-- guide hands it in once the bags hold what it asks.
			elseif ((rec and rec.minLevel) or pq.minLevel or 1) > reach then
				-- One that starts inside (no giver out here, no drop outside)
				-- never comes to the pick-up guide: it does not wait for it.
				if Dungeons.Giver(pq, from, rec) or Dungeons.DropPoint(key, pq, from, rec) then wait(pq, (rec and rec.minLevel) or pq.minLevel) end
			elseif offer and Dungeons.OfferLevel(pq, rec) > (p.level or 1) then
				-- By the heads-up's rule: one more than a level above the
				-- character waits for its level less one.
				if Dungeons.Giver(pq, from, rec) or Dungeons.DropPoint(key, pq, from, rec) then wait(pq, Dungeons.OfferLevel(pq, rec)) end
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
						-- One done inside an instance (another dungeon's boss, its
						-- drops) is no pick-up: Kirtonos the Herald before
						-- Menethil's Gift.
						if not inLog(r.id) and insideOnly(r) then ok = false end
						pre[#pre + 1] = r
					end
				end
				-- Loot requirements are accepts, not ordinary completed-quest
				-- prerequisites. A source whose pickup cannot be planned must
				-- not turn into an unconditional farm stop (#1923).
				local function checkDrop(drop)
					if not (drop and drop.dropBlocked) then return end
					local q = drop.dropQuest
					if drop.dropBlocked == "level" and q then
						if not waitOn or (q.minLevel or 1) > (waitOn.minLevel or 1) then waitOn = q end
					else ok = false end
				end
				checkDrop(giver)
				for _, r in ipairs(pre) do
					if not inLog(r.id) then checkDrop(Dungeons.DropPoint(key, r, from, r)) end
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
	return crumbsFirst(dropDetours(plan, from, p), key)
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
	if g.kind == "quest" then return goal end -- held quest, no giver in this data pack
	goal.map, goal.x, goal.y, goal.f = g.map, g.x, g.y, g.f == "e" and "e" or nil
	if g.kind == "object" then
		goal.object, goal.objName = g.id, g.name
	else
		goal.npc, goal.npcName = g.id, g.name
		-- A quest several NPCs give: each of the character's side, the nearest picked live (#3368).
		goal.candidates = rec and LK().GiverCandidates(rec.start, g) or nil
	end
	goal.z = LK().SpawnZ(g.kind == "object" and "object" or "npc", g.id, g)
	-- One of a set its giver offers one at a time (the Codex's rotation, #3601: Pix Xizzix's weekly In Demand
	-- quests): optional, so the guide never waits on one not offered this week, and its goal says so.
	if rec and rec.rotation then
		goal.optional = true
		local text = format(L["%s offers one of these a week: take it if it is this week's."], g.name or L["Quest giver"])
		goal.note = goal.note and (text .. " " .. goal.note) or text
	end
	-- A giver only the dead see: optional, and its goal says so (Lookup.GhostOnly, #558).
	return LK().GhostOnly(goal)
end

-- Collect the item that starts a quest at drop point d (Dungeons.DropPoint):
-- the mob or object nearest the player that gives it. A mob is named as the
-- one to kill, as compiled goals' `from` does (#3718: "Collect Damp Note"
-- left the Blackfathom Tide Priestesses unsaid).
local function collectGoal(d)
	local goal = { t = "collect", item = d.item, itemName = d.itemName, count = 1, map = d.map, x = d.x, y = d.y, f = d.f == "e" and "e" or nil }
	if d.source == "object" then
		goal.object, goal.objName = d.id, d.name
	else
		goal.npc, goal.npcName = d.id, d.name
		goal.z = LK().SpawnZ("npc", d.id, d)
		goal.from, goal.fromId, goal.fromKind = d.name, d.id, "npc"
		local r = ns.Codex and ns.Codex.Npc(d.id)
		if r then
			goal.fromRank = (r.boss and 3) or (r.rare and r.elite and 2) or (r.elite and 1) or (r.rare and 4) or nil
			if r.faction == "A" or r.faction == "H" or r.faction == "AH" then goal.fromFaction = r.faction end
		end
	end
	return goal
end

-- The items quest record `rec` asks for that an object at giver point g
-- gives (Lookup.QuestStep's collect goals from an object, within AT_GIVER
-- yards of the giver): Blueleaf Tubers' crate, owner's manual and command
-- stick at Mebok Mizzyrix's feet in Ratchet (#2439), taken with the quest,
-- before the run. -> { goal, ... }
local AT_GIVER = 25 -- yards
local function yards(a, b)
	local W = ns.Compat.MapToWorld
	local c1, x1, y1 = W(a.map, a.x, a.y, a.f)
	local c2, x2, y2 = W(b.map, b.x, b.y, b.f)
	if not (c1 and c2) or c1 ~= c2 then return nil end
	return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end
local function atGiver(rec, g)
	local out = {}
	if not (rec and g.kind ~= "drop" and located(g)) then return out end
	local step = LK().QuestStep(rec, g)
	for _, goal in ipairs(step and step.goals or {}) do
		local d = goal.t == "collect" and goal.fromKind == "object" and located(goal) and yards(goal, g)
		if d and d <= AT_GIVER then out[#out + 1] = goal end
	end
	return out
end

---------------------------------------------------------------------------
-- Stop order: the cheapest path from where the player stands through every
-- stop to the entrance, a path with a fixed end (a greedy nearest-next walk
-- that only appends the entrance would leave a city and come back to it).
---------------------------------------------------------------------------

local EXACT = 12 -- stops searched exactly; more: two first orders, then improved
local AT_HAND = 15 -- seconds of travel from the player: such a stop comes first (#1593)

-- stops = { { inP, outP, deps = { stopIndex, ... }, log }, ... }: inP where the
-- stop starts, outP where the player stands after it, deps the stops that
-- must come before it, log the quests it adds to the log (an accept: 1, a
-- giver: its accepts) or takes off (a turn-in: -1). from: the player's point;
-- finish: the entrance (nil: the path ends at its last stop). travel(a, b) ->
-- seconds | nil (nil and unknown points cost FAR). opts: { cap, seeds }:
-- cap, the most quests the route may add to the log at any time (nil: no
-- limit); seeds, orders of every stop to improve on besides the planner's own
-- (the pick-up guide's one-quest-at-a-time route). -> order (stop indices),
-- cost. The stops at hand (AT_HAND) come first; ties keep the authored order.
function Dungeons.PlanStops(stops, from, finish, travel, opts)
	local n = #stops
	local cap = opts and opts.cap
	-- Travel memoised by place: a quest's accept and the giver stop beside it,
	-- or its turn-in and the next quest's accept, are separate points at one
	-- spot, and each estimate plans a route.
	local memoT, placeKey = {}, {}
	local function pk(p)
		local k = placeKey[p]
		if not k then
			k = type(p) == "table" and p.map and (p.map .. ":" .. tostring(p.x) .. ":" .. tostring(p.y) .. ":" .. tostring(p.f)) or p
			placeKey[p] = k
		end
		return k
	end
	local function T(a, b)
		if a == nil or b == nil then return FAR end
		if a == b then return 0 end
		local ka, kb = pk(a), pk(b)
		if ka == kb then return 0 end
		local row = memoT[ka]
		if not row then
			row = {}
			memoT[ka] = row
		end
		local t = row[kb]
		if t == nil then
			t = travel(a, b) or FAR
			row[kb] = t
		end
		return t
	end
	local function outOf(i) return i == 0 and from or stops[i].outP end
	local function tail(i) return finish and T(outOf(i), finish) or 0 end
	local function delta(i) return stops[i].log or 0 end
	-- Bits as powers of two (Lua 5.1 has no bit operators).
	local pow = {}
	for i = 1, n do pow[i] = 2 ^ (i - 1) end
	local function has(mask, i) return math.floor(mask / pow[i]) % 2 == 1 end
	-- The quests the stops of `mask` added to the log, kept per mask.
	local openMemo = {}
	local function openOf(mask)
		local v = openMemo[mask]
		if v then return v end
		v = 0
		for i = 1, n do
			if has(mask, i) then v = v + delta(i) end
		end
		openMemo[mask] = v
		return v
	end
	local function ready(mask, i)
		if has(mask, i) then return false end
		for _, d in ipairs(stops[i].deps) do
			if not has(mask, d) then return false end
		end
		if cap and delta(i) > 0 and openOf(mask) + delta(i) > cap then return false end
		return true
	end
	local order = {}
	if n == 0 then return order, tail(0) end
	-- Stops at hand first (#1593): a stop no more than AT_HAND seconds from
	-- where the player stands is done before the route leaves, nearest-next
	-- among those. Coming out of Ragefire Chasm beside Neeru Fireblade, the
	-- hand-in guide led to Thunder Bluff first and back for Neeru later. A
	-- stop at hand costs at most twice AT_HAND more than the cheapest path.
	local mask0, last0, cost0 = 0, 0, 0
	while true do
		local here, bc, bi = outOf(last0), math.huge, nil
		for i = 1, n do
			if ready(mask0, i) and T(from, stops[i].inP) <= AT_HAND then
				local v = T(here, stops[i].inP)
				if v < bc then bc, bi = v, i end
			end
		end
		if not bi then break end
		order[#order + 1] = bi
		mask0, last0, cost0 = mask0 + pow[bi], bi, cost0 + bc
	end
	local fixed = #order
	local function prefix()
		local o = {}
		for k = 1, fixed do o[k] = order[k] end
		return o
	end
	if fixed == n then return order, cost0 + tail(last0) end
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
		local total = cost0 + best(mask0, last0)
		local mask, last = mask0, last0
		while mask ~= full do
			local i = nextOf[mask * (n + 1) + last]
			if not i then break end -- a dependency cycle or a full log: the rest cannot be placed
			order[#order + 1] = i
			mask, last = mask + pow[i], i
		end
		if #order == n then return order, total end
		order = prefix()
	end
	-- Many stops: first orders, each every stop after its dependencies and
	-- within the log's room (the stops at hand stay first)...
	local deps = {}
	for i = 1, n do
		local set = {}
		for _, d in ipairs(stops[i].deps) do set[d] = true end
		deps[i] = set
	end
	local function capOk(o)
		if not cap then return true end
		local open = 0
		for _, i in ipairs(o) do
			open = open + delta(i)
			if open > cap then return false end
		end
		return true
	end
	local function valid(o)
		if #o ~= n then return false end
		local pos = {}
		for p, i in ipairs(o) do pos[i] = p end
		for p, i in ipairs(o) do
			if not pos[i] then return false end
			for d in pairs(deps[i]) do
				if not pos[d] or pos[d] > p then return false end
			end
		end
		return capOk(o)
	end
	local candidates = {}
	-- ...nearest-next...
	local near = prefix()
	local mask, last = mask0, last0
	for _ = fixed + 1, n do
		local bc, bi = math.huge, nil
		for i = 1, n do
			if ready(mask, i) then
				local v = T(outOf(last), stops[i].inP)
				if v < bc then bc, bi = v, i end
			end
		end
		if not bi then break end
		near[#near + 1] = bi
		mask, last = mask + pow[bi], bi
	end
	candidates[#candidates + 1] = near
	-- ...cheapest insertion: each stop, once its dependencies are in, where
	-- it adds the least, never before one of them nor where the log is full...
	local ins = prefix()
	local placed = {}
	for k = 1, fixed do placed[ins[k]] = true end
	for _ = fixed + 1, n do
		local bi
		for i = 1, n do
			if not placed[i] then
				local ok = true
				for d in pairs(deps[i]) do ok = ok and placed[d] end
				if ok then
					bi = i
					break
				end
			end
		end
		if not bi then break end
		local lo = fixed
		for p = fixed + 1, #ins do
			if deps[bi][ins[p]] then lo = p end
		end
		-- The most the log holds from each position on, for an accept's room.
		local peak = {}
		if cap and delta(bi) > 0 then
			local open, at = 0, {}
			for p, i in ipairs(ins) do
				open = open + delta(i)
				at[p] = open
			end
			at[0] = 0
			local m = -math.huge
			for p = #ins, 0, -1 do
				m = math.max(m, at[p])
				peak[p] = m
			end
		end
		local bc, bp = math.huge, nil
		for p = lo, #ins do
			if not (peak[p] and peak[p] + delta(bi) > cap) then
				local a = p == 0 and 0 or ins[p]
				local nx = ins[p + 1]
				local v = T(outOf(a), stops[bi].inP) + (nx and (T(stops[bi].outP, stops[nx].inP) - T(outOf(a), stops[nx].inP)) or (tail(bi) - tail(a)))
				if v < bc then bc, bp = v, p end
			end
		end
		if not bp then break end
		table.insert(ins, bp + 1, bi)
		placed[bi] = true
	end
	candidates[#candidates + 1] = ins
	-- ...and the seeds, with the stops at hand moved first.
	for _, seed in ipairs(opts and opts.seeds or {}) do
		local o, first = prefix(), {}
		for k = 1, fixed do first[o[k]] = true end
		for _, i in ipairs(seed) do
			if not first[i] then o[#o + 1] = i end
		end
		candidates[#candidates + 1] = o
	end
	local function cost(o)
		local c, prev = 0, 0
		for _, i in ipairs(o) do
			c = c + T(outOf(prev), stops[i].inP)
			prev = i
		end
		return c + tail(prev)
	end
	-- Then each improved by moving runs of one to three stops elsewhere while
	-- that shortens the path, keeps every stop after its dependencies and the
	-- log within its room. A chain's links move together: Sunken Temple's
	-- Alliance guide went from Stormwind to the Plaguelands for four quests in
	-- a row and back to Stormwind before In Search of the Temple, which starts
	-- there.
	local function improve(o)
		local m = #o
		local function outAt(k) return k <= 0 and from or stops[o[k]].outP end
		local function inAt(k) return stops[o[k]].inP end
		local function tailAt(k) return tail(k <= 0 and 0 or o[k]) end
		-- The cost of the edge leaving position k (k = 0: the player), to the next stop or the entrance.
		local function edge(k) return k < m and T(outAt(k), inAt(k + 1)) or tailAt(k) end
		local function movable(a, L, b)
			if b < a then
				for q = b + 1, a - 1 do
					for s = a, a + L - 1 do
						if deps[o[s]][o[q]] then return false end
					end
				end
			else
				for q = a + L, b do
					for s = a, a + L - 1 do
						if deps[o[q]][o[s]] then return false end
					end
				end
			end
			return true
		end
		local function moved(a, L, b)
			local x, run = {}, {}
			for k, v in ipairs(o) do
				if k >= a and k < a + L then run[#run + 1] = v end
			end
			for k = 0, m do
				if k > 0 and (k < a or k >= a + L) then x[#x + 1] = o[k] end
				if k == b then
					for _, v in ipairs(run) do x[#x + 1] = v end
				end
			end
			return x
		end
		local rounds, improved = 0, true
		while improved and rounds < 50 do
			improved, rounds = false, rounds + 1
			for L = 1, 3 do
				for a = fixed + 1, m - L + 1 do
					local z = a + L - 1
					-- Out: the edges into and out of the run give way to one across it.
					local out = (z < m and T(outAt(a - 1), inAt(z + 1)) or tailAt(a - 1)) - T(outAt(a - 1), inAt(a)) - edge(z)
					for b = fixed, m do
						if b < a - 1 or b > z then
							local into = T(outAt(b), inAt(a)) + (b < m and T(outAt(z), inAt(b + 1)) or tail(o[z])) - edge(b)
							if out + into < -0.5 and movable(a, L, b) then
								local x = moved(a, L, b)
								if capOk(x) then
									o = x
									improved = true
									break
								end
							end
						end
					end
					if improved then break end
				end
				if improved then break end
			end
		end
		return o
	end
	local bestO, bestC
	for _, o in ipairs(candidates) do
		if valid(o) then
			o = improve(o)
			local c = cost(o)
			if not bestC or c < bestC then bestO, bestC = o, c end
		end
	end
	if bestO then return bestO, bestC end
	-- Nothing fits the log's room: the route without it.
	if cap then return Dungeons.PlanStops(stops, from, finish, travel, { seeds = opts.seeds }) end
	return near, cost(near)
end

-- plan -> stops: each open prerequisite quest once (after the quests it
-- requires; it starts at its giver nearest the player and leaves the
-- player at its turn-in; `opens`: the page quests it comes before, each
-- once) and each giver once per set of prerequisites its quests wait on (a
-- giver comes up again for a quest still waiting).
-- A prerequisite waits only on what it needs: the quests its own `pre` and
-- `preAny` name among the stops, the breadcrumb spliced in right before it
-- (turned in where it is given, plan.closedBy), and, for one an item starts
-- (no giver: the item drops, or a quest before it gives it), the quest
-- before it. A page quest's other prerequisites are free of each other:
-- Ramstein's six (Nathanos Blightcaller, Stratholme) in the list's order sent
-- a Horde player from the Plaguelands to the Undercity and back for The
-- Champion of the Banshee Queen, the Undercity passed on the way there.
local function stopsOf(plan, from)
	local Lk = LK()
	local stops, byKey = {}, {}
	local function add(s)
		stops[#stops + 1] = s
		byKey[s.key] = #stops
		return s
	end
	local function depend(s, index)
		if not index or byKey[s.key] == index then return end
		for _, d in ipairs(s.deps) do if d == index then return end end
		s.deps[#s.deps + 1] = index
	end
	local function giverStop(g, deps, take)
		table.sort(deps)
		local gk = "g" .. g.kind .. g.id
		local k = #deps > 0 and (gk .. "<" .. table.concat(deps, ",")) or gk
		local s = stops[byKey[k] or 0]
		if not s then
			local idx = {}
			for i, dk in ipairs(deps) do idx[i] = byKey[dk] end
			s = add({ key = k, giverKey = gk, giver = g, inP = g, outP = g, deps = idx, accepts = {} })
		end
		for _, t in ipairs(s.accepts) do if t.quest.id == take.quest.id then return k end end
		s.accepts[#s.accepts + 1] = take
		local held = true
		for _, t in ipairs(s.accepts) do if not inLog(t.quest.id) then held = false; break end end
		s.inP, s.outP = held and from or g, held and from or g
		return k
	end
	-- The source's enabling quests are accepted at their givers. Their
	-- ordinary prerequisites still use full quest stops. Share the same
	-- stop keys with page quests so the route does not repeat those visits.
	local function dropStops(drop, opens)
		local deps = {}
		for _, step in ipairs(drop and drop.dropSteps or {}) do
			local first, last = step.goals[1], step.goals[#step.goals]
			local r = ns.Codex.Quest(first.quest) or { id = first.quest, title = first.title }
			local k
			if last.t == "turnin" then
				k = "q" .. r.id
				local s = stops[byKey[k] or 0] or add({ key = k, rec = r, inP = first, outP = last, deps = {}, opens = {} })
				for _, dep in ipairs(deps) do depend(s, byKey[dep]) end
				if s.opens[#s.opens] ~= opens then s.opens[#s.opens + 1] = opens end
			else
				local g = { kind = first.npc and "npc" or first.object and "object" or "quest", id = first.npc or first.object or first.quest,
					name = first.npcName or first.objName, map = first.map, x = first.x, y = first.y, f = first.f }
				k = giverStop(g, deps, { quest = r, rec = r })
			end
			deps = { k }
		end
		return deps[1]
	end
	for _, t in ipairs(plan.take) do
		local prev
		local deps = {}
		for _, r in ipairs(t.pre) do
			local k = "q" .. r.id
			if not byKey[k] then
				-- A quest an item starts begins where the item drops (#1380).
				local start = endPoint(Lk.QuestEnd(r.start, from))
				local drop = not start and not inLog(r.id) and Dungeons.DropPoint(plan.dungeon.key, r, from, r) or nil
				local finish = endPoint(Lk.QuestEnd(r["end"], start or drop or from))
				add({ key = k, rec = r, inP = start or drop, outP = finish or start or drop, deps = {}, drop = drop, opens = {}, item = start == nil })
			end
			local s = stops[byKey[k]]
			-- The drop's own required quests first (#1923), then 0.4.0's: what
			-- its `pre`/`preAny` name, and the stop before it only for an item
			-- start or a breadcrumb spliced in before it.
			local dropKey = dropStops(s.drop, t.quest)
			if dropKey then depend(s, byKey[dropKey]) end
			local opens = s.opens
			if opens[#opens] ~= t.quest then opens[#opens + 1] = t.quest end
			for _, id in ipairs(r.pre or {}) do depend(s, byKey["q" .. id]) end
			for _, id in ipairs(r.preAny or {}) do depend(s, byKey["q" .. id]) end
			if prev and (s.item or (plan.closedBy and plan.closedBy[stops[prev].rec.id])) then depend(s, prev) end
			prev = byKey[k]
			deps[#deps + 1] = k
		end
		local g = t.giver
		local dropKey = dropStops(g, t.quest)
		if dropKey then deps[#deps + 1] = dropKey end
		giverStop(g, deps, t)
	end
	return stops
end

-- stops (each with a unique `key`) -> order. With the player's position
-- (`from`) the cheapest path (PlanStops, ending at `finish` when given, with
-- `opts`: its log room and seeds), kept for the character as
-- CharState()[field][key]; without one (a rebuild after /reload) the kept
-- order, then the authored one, each stop after its dependencies.
function Dungeons.OrderStops(stops, from, finish, field, key, opts)
	local order
	if from then
		order = Dungeons.PlanStops(stops, from, finish, opts and opts.travel or LK().Travel, opts)
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

function Dungeons.OpensNote(quests, breadcrumb, note)
	local titles = {}
	for _, q in ipairs(type(quests) == "table" and quests or {}) do
		local t = ns.Quoted(q.title)
		if t and t ~= "" then titles[#titles + 1] = t end
	end
	if #titles == 0 then return note end
	local text = format(breadcrumb and L["Leads to %s."] or L["Needed for %s."], table.concat(titles, ", "))
	return note and (text .. " " .. note) or text
end

function Dungeons.MarkOpens(step, quest, opens, breadcrumb)
	local goals = step and step.goals
	if type(goals) ~= "table" then return end
	local target = goals[1]
	for _, g in ipairs(goals) do
		if g.t == "accept" and g.quest == quest then
			target = g
			break
		end
	end
	if target then target.note = Dungeons.OpensNote(opens, breadcrumb, target.note) end
end

-- A quest's mob: the kill and the walk to the next one. Anything else (an
-- object to use or loot, a talk, an event) per count.
local KILL_SECONDS = 40
local USE_SECONDS = 30
local MIN_CHANCE = 2 -- percent: a rarer drop counts as this (no hour-long farms)
-- Calibrated (0.3.8) on players' recordings of the pick-up guides'
-- prerequisite quests: 46 quests with three or more people who did one
-- alone (accept to hand-in with no other quest taken, handed in or worked
-- in between; one run per person). Summed, the low quarters come to 371
-- minutes and the medians to 445; the estimate, 429 (travel as the route
-- planner has it, 465 without these two). Per quest it stays rough: drops
-- that run dry (A Recipe For Death) take longer, errands on a flight
-- shorter.
local TRAVEL_FACTOR = 0.7 -- players' ways are shorter than the planner's estimate
local STEP_SECONDS = 75 -- each quest's own talks, loot and turn-in

function Dungeons.ObjectiveSeconds(o)
	local n = math.max(1, tonumber(o and o.count) or 1)
	if o.type == "kill" then return n * KILL_SECONDS end
	if o.type == "item" then
		local C = ns.Codex
		local it = C and C.Item and C.Item(o.id)
		local best
		for _, src in ipairs(it and it.sources or {}) do
			local c = src.type == "drop" and src.npc and tonumber(src.chance)
			if c and c > 0 and (not best or c > best) then best = c end
		end
		if best then return n * KILL_SECONDS * 100 / math.max(MIN_CHANCE, math.min(100, best)) end
	end
	return n * USE_SECONDS
end

function Dungeons.PrereqSeconds(step, rec, pos)
	local Lk = LK()
	local travel = Lk and Lk.Travel
	local t, at = 0, pos
	for _, g in ipairs(step and step.goals or {}) do
		if g.map and g.x and g.y then
			local p = { map = g.map, x = g.x, y = g.y, f = g.f }
			if travel and at then t = t + (travel(at, p) or 0) end
			at = p
		end
	end
	t = t * TRAVEL_FACTOR + STEP_SECONDS
	for _, o in ipairs(rec and rec.objectives or {}) do t = t + Dungeons.ObjectiveSeconds(o) end
	return t
end

-- Seconds as "about" minutes: to 5 minutes, at least 5; whole hours alone ("1 h"). -> text
function Dungeons.PrereqTime(seconds)
	local m = math.max(5, math.floor(((tonumber(seconds) or 0) / 60 + 2.5) / 5) * 5)
	if m >= 60 and m % 60 == 0 then return format(L["%d h"], m / 60) end
	if m >= 60 then return format(L["%d h %d min"], math.floor(m / 60), m % 60) end
	return format(L["%d min"], m)
end

-- Carrying several prerequisites at once: each prerequisite quest is up to
-- three stops, its accept (at its giver, or where the item that starts it
-- drops), its objectives (from the first placed one to the last) and its
-- turn-in, so the route can take two quests in one town and hand them in
-- together, or do two quests' objectives in one zone before going back
-- (the dungeon sweep, 0.4.0: Uldaman's Alliance guide went Loch Modan, the
-- Badlands, Loch Modan and the Badlands again for Badlands Reagent Run and
-- Murdaloc, both handed in at Thelsamar). A quest stays one stop when it is
-- timed (QuestDB.TimeLimit), has an event or escort objective, or its step
-- is no quest of its own ("First do the quest"). The log's room bounds how
-- many the route carries: the log's size less LOG_FREE and the quests in it.
local LOG_FREE = 5

local function pointOf(g) return { map = g.map, x = g.x, y = g.y, f = g.f } end

local function timed(id)
	local Q = ns.QuestDB
	return Q and Q.IsLoaded and Q.IsLoaded() and Q.TimeLimit and Q.TimeLimit(id) ~= nil or false
end

-- An accept or turn-in goal's NPC or object, as the giver stops key theirs.
local function npcKeyOf(g)
	if g and g.npc then return "gnpc" .. g.npc end
	if g and g.object then return "gobject" .. g.object end
	return nil
end

-- whole (stopsOf's stops: one per prerequisite quest and per giver) ->
-- stops (kind "giver", "whole", "a", "o", "t"), parts (whole index -> its
-- stops' indices, in order). A stop's `log`: the quests it adds to the log
-- (an accept 1, a giver its accepts) or takes off (a turn-in -1).
local function splitStops(whole, from)
	local Lk = LK()
	local out, parts = {}, {}
	local function add(s)
		out[#out + 1] = s
		return #out
	end
	for i, s in ipairs(whole) do
		local list = {}
		if s.giver then
			list[1] = add({ key = s.key, kind = "giver", giverKey = s.giverKey, giver = s.giver, inP = s.inP, outP = s.outP,
				accepts = s.accepts, log = #s.accepts, deps = {} })
		else
			local r = s.rec
			local step = Lk.QuestStep(r, s.inP or from)
			local goals = step and step.goals or {}
			local acc, turn = goals[1], goals[#goals]
			local split = #goals >= 2 and acc.t == "accept" and turn.t == "turnin" and located(turn) and not timed(r.id)
			local objs, placed = {}, {}
			for k = 2, #goals - 1 do
				local g = goals[k]
				if g.t == "complete" then split = false end
				objs[#objs + 1] = g
				if located(g) then placed[#placed + 1] = g end
			end
			local base = { rec = r, drop = s.drop, opens = s.opens, step = step }
			local function part(t)
				for k, v in pairs(base) do t[k] = v end
				t.deps = {}
				return add(t)
			end
			if not split then
				list[1] = part({ key = s.key, kind = "whole", inP = s.inP, outP = s.outP, log = 0, first = true })
			else
				local aGoals = { acc }
				if #placed == 0 then
					for _, g in ipairs(objs) do aGoals[#aGoals + 1] = g end
					objs = {}
				end
				-- One in the log already needs no trip to its giver: its accept
				-- (done) rides with its objectives, else its turn-in (#1256).
				local own = inLog(r.id)
				if not own then
					list[1] = part({ key = "a" .. r.id, kind = "a", inP = s.inP, outP = s.inP, goals = aGoals, npcKey = npcKeyOf(acc), log = 1, hasObj = #objs > 0 })
				end
				if #objs > 0 then
					local goals = objs
					if own then
						goals = aGoals
						for _, g in ipairs(objs) do goals[#goals + 1] = g end
					end
					list[#list + 1] = part({ key = "o" .. r.id, kind = "o", inP = pointOf(placed[1]), outP = pointOf(placed[#placed]), goals = goals, log = 0 })
				end
				local tp = pointOf(turn)
				local tGoals = { turn }
				if own and #list == 0 then
					tGoals = aGoals
					tGoals[#tGoals + 1] = turn
				end
				list[#list + 1] = part({ key = "t" .. r.id, kind = "t", inP = tp, outP = tp, goals = tGoals, npcKey = npcKeyOf(turn), log = -1 })
				out[list[1]].first = true
				for k = 2, #list do out[list[k]].deps[1] = list[k - 1] end
			end
		end
		parts[i] = list
	end
	-- What came before a whole stop comes before its first part, and its last
	-- part (the turn-in) is what comes before what waits on it.
	for i, s in ipairs(whole) do
		local first = out[parts[i][1]]
		for _, d in ipairs(s.deps) do
			local l = parts[d]
			first.deps[#first.deps + 1] = l[#l]
		end
	end
	return out, parts
end

-- The quests the route may add to the log: its room (the log's size less
-- LOG_FREE and the quests in it), never less than the givers' accepts and
-- one prerequisite, as the one-quest-at-a-time route needs.
local function logRoom(stops)
	local C = ns.Compat
	local room = (C.GetLogCap and C.GetLogCap() or 20) - LOG_FREE - #(C.GetLogQuests and C.GetLogQuests() or {})
	local need = 1
	for _, s in ipairs(stops) do
		if s.kind == "giver" then need = need + s.log end
	end
	return math.max(room, need)
end

-- plan -> steps (the givers and prerequisites in route order): the
-- cheapest path to the entrance, or the order kept for the character;
-- and the prerequisites among them: { n, seconds }. The path is planned
-- over the split stops (splitStops), seeded with the one-quest-at-a-time
-- route (each prerequisite a stop of its own, as before), so it is never
-- longer than that one. Steps: a quest's parts in a row are one step, titled
-- with the quest (as before); an accept or a turn-in on its own is a step at
-- its NPC, one with the givers' accepts and other such stops at that NPC in
-- a row.
local function route(key, plan)
	local from = ns.PlayerPoint()
	local whole = stopsOf(plan, from)
	local e = plan.dungeon.entrance
	local finish = located(e) and { map = e.map, x = e.x, y = e.y, f = e.f == "e" and "e" or nil } or nil
	local stops, parts = splitStops(whole, from)
	local opts
	if from then
		-- One travel cache for both plans (the seed's and the split one), by place.
		local cache, travel = {}, LK().Travel
		local function cached(a, b)
			local k = a.map .. ":" .. tostring(a.x) .. ":" .. tostring(a.y) .. ":" .. tostring(a.f) .. ">" .. b.map .. ":" .. tostring(b.x) .. ":" .. tostring(b.y) .. ":" .. tostring(b.f)
			local t = cache[k]
			if t == nil then
				t = travel(a, b) or false
				cache[k] = t
			end
			return t or nil
		end
		local seed = {}
		for _, i in ipairs((Dungeons.PlanStops(whole, from, finish, cached))) do
			for _, j in ipairs(parts[i]) do seed[#seed + 1] = j end
		end
		opts = { cap = logRoom(stops), seeds = { seed }, travel = cached }
	end
	local order = Dungeons.OrderStops(stops, from, finish, "dungeonPickup", key, opts)
	-- Units: a quest's parts in a row, or a stop at an NPC on its own.
	local units, pos, prereq = {}, from, {}
	local pre = { n = 0, seconds = 0 }
	local last
	local NEXT = { a = { o = true, t = true }, o = { t = true } }
	for _, i in ipairs(order) do
		local s = stops[i]
		if s.kind == "giver" then
			local u = { npcKey = s.giverKey, lone = true, title = s.giver.name or L["Quest giver"], goals = {} }
			if s.giver.kind == "drop" then u.goals[#u.goals + 1] = collectGoal(s.giver) end
			for _, t in ipairs(s.accepts) do
				local a = acceptGoal(t.quest, t.rec, s.giver)
				u.goals[#u.goals + 1] = a
				for _, g in ipairs(atGiver(t.rec, s.giver)) do u.goals[#u.goals + 1] = g end
				-- One quest several NPCs give: the step is named after it, not after
				-- the giver the Engine may pick another over (#3368).
				if a.candidates and #s.accepts == 1 then u.title = t.quest.title or (t.rec and t.rec.title) or u.title end
			end
			units[#units + 1] = u
			last = nil
		else
			local r = s.rec
			prereq[r.id] = true
			local goals = {}
			for _, g in ipairs(s.kind == "whole" and (s.step and s.step.goals or {}) or s.goals) do goals[#goals + 1] = g end
			local first = s.first
			if first then
				-- One an item starts collects the item first, where it drops.
				if s.drop and goals[1] and goals[1].t == "accept" then table.insert(goals, 1, collectGoal(s.drop)) end
				pre.seconds = pre.seconds + Dungeons.PrereqSeconds(s.step, r, pos)
			end
			local u
			if last and last.quest == r.id and NEXT[last.kind] and NEXT[last.kind][s.kind] then
				u = last
				u.lone = false
			else
				u = { quest = r.id, title = (s.step and s.step.title) or r.title, goals = {}, npcKey = s.npcKey,
					lone = s.kind == "a" or s.kind == "t" }
				units[#units + 1] = u
			end
			u.kind = s.kind
			for _, g in ipairs(goals) do u.goals[#u.goals + 1] = g end
			-- The step's note (what is inside where, talks, made items) goes with the objectives.
			if s.step and s.step.note and (s.kind == "whole" or s.kind == "o" or (s.kind == "a" and not s.hasObj) or (s.kind == "t" and s.first)) then u.note = s.step.note end
			if first then
				-- A breadcrumb's accept knows the quest that closes it.
				local by = plan.closedBy and plan.closedBy[r.id]
				if by then
					for _, g in ipairs(goals) do
						if g.t == "accept" and g.quest == r.id then g.closedBy = by end
					end
				end
				-- Why the step is in a dungeon's guide: the page quests it opens (a
				-- breadcrumb: leads to), so a quest out in the world is not a mystery
				-- (Rear Guard Patrol before the Ruins of Lordaeron's The Wrath of Rath'mael).
				Dungeons.MarkOpens({ goals = goals }, r.id, s.opens, by ~= nil)
			end
			last = s.kind ~= "whole" and u or nil
		end
		pos = s.outP or pos
	end
	-- Steps: lone stops at the same NPC in a row are one step.
	local steps = {}
	local prev
	for _, u in ipairs(units) do
		local name
		if u.lone and u.quest then
			local g = u.goals[#u.goals]
			-- An accept the Engine may take from another of its givers (#3368) keeps the quest's title.
			name = g and not g.candidates and (g.npcName or g.objName) or nil
		end
		if u.lone and prev and prev.lone and prev.npcKey and prev.npcKey == u.npcKey then
			for _, g in ipairs(u.goals) do prev.step.goals[#prev.step.goals + 1] = g end
			if u.note then prev.step.note = prev.step.note and (prev.step.note .. " " .. u.note) or u.note end
		else
			local step = { title = (u.lone and u.quest and name) or u.title, goals = u.goals, note = u.note }
			steps[#steps + 1] = step
			u.step = step
			prev = u
		end
	end
	for _, step in ipairs(steps) do
		for _, g in ipairs(step.goals) do
			if g.quest and prereq[g.quest] then
				pre.n = pre.n + 1
				break
			end
		end
	end
	return steps, pre
end

function Dungeons.PickupGuide(key)
	local plan, err = Dungeons.PickupPlan(key)
	if not plan then return nil, err end
	if #plan.take == 0 then return nil, "nothing" end
	local d = plan.dungeon
	local steps, pre = route(key, plan)
	if #steps == 0 then return nil, "nothing" end
	local last = { title = d.name, goals = {} }
	-- The quests already in the log: one line in the step's note, not a row
	-- each above the way in (#1591: four rows before "Enter Ragefire Chasm").
	local notes, carried = {}, {}
	for i, pq in ipairs(plan.carried) do carried[i] = ns.Quoted(pq.title) or "" end
	if #carried > 0 then notes[1] = format(L["In your log already: %s"], table.concat(carried, ", ")) end
	-- The quests that wait for a level, in the accent: they come back then
	-- (a chat line and a map pin say so, below). The colour is the goal's
	-- `accent` (the guide window paints it in the look's accent): guide text
	-- prints literally, so a colour code in it showed as "|cff...|r" (#1993).
	local watched = {}
	for _, w in ipairs(plan.waiting) do
		local text = format(L["Comes back at level %d: %s"], w.level, ns.Quoted(w.quest.title) or "")
		last.goals[#last.goals + 1] = { t = "note", text = text, accent = true }
		watched[#watched + 1] = { id = w.quest.id, title = w.quest.title, level = w.level }
	end
	Dungeons.watch[key] = watched
	-- What the run uses that no quest gives (#2338: the Mallet of Zul'Farrak,
	-- which calls Gahz'rilla): each of the page's `item` entries for this
	-- character's side that is not in the bags, with its note on how to get it.
	for _, a in ipairs(Dungeons.Attunements(key, LK().PlayerInfo().code)) do
		if a.kind == "item" and a.note and not Dungeons.AttunementState(a).done then
			last.goals[#last.goals + 1] = { t = "note", text = format(L["%s: %s"], a.item and a.item.name or a.name, L[a.note]) }
		end
	end
	local e = d.entrance
	if located(e) then
		-- A way in through the other faction's land says so on the step.
		local enemy = Dungeons.EnemyEntrance and Dungeons.EnemyEntrance(key)
		if enemy then table.insert(notes, 1, enemy) end
		last.goals[#last.goals + 1] = { t = "goto", text = d.name, map = e.map, x = e.x, y = e.y, f = e.f == "e" and "e" or nil, entrance = true }
	end
	if #notes > 0 then last.note = table.concat(notes, " ") end
	-- The hand-in half (Dungeons/Handin.lua) is built after the run, from the
	-- quests then finished; this guide's own end offers it (UI/GuideFrame), and
	-- so does the dungeon's page.
	last.goals[#last.goals + 1] = { t = "note", text = L["After the run: choose Hand in the quests at the end of this guide or on the dungeon's page."] }
	steps[#steps + 1] = last
	-- How much of the way is prerequisites, and about how long they take: on
	-- the first goal, the first thing the window says.
	local first = steps[1] and steps[1].goals and steps[1].goals[1]
	if pre.n > 0 and first then
		local head = format(L["%d of this guide's %d steps are prerequisite quests (about %s)."], pre.n, #steps, Dungeons.PrereqTime(pre.seconds))
		first.note = first.note and (head .. " " .. first.note) or head
	end
	return { title = format(L["%s: pick up the quests"], d.name), steps = steps, dungeon = key }
end

function Dungeons.PickUp(key)
	if not Dungeons.IsEnabled() then return nil, "off" end
	local Lk = LK()
	if not (Lk and Lk.Guide) then return nil, "missing" end
	-- Retired with the heads-up's own pick-up rule (#3063): which guides it had opened.
	ns.CharState().pickupOffer = nil
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
			ns.Notice(format(L["Level %d: you can take %s now. Its giver is marked on your map; pick up the quests again to add it to the guide."], level, ns.Quoted(w.title) or ""))
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

local function dropTarget(drop)
	if drop.dropBlocked then return nil, nil, nil, true end
	local first
	for _, step in ipairs(drop.dropSteps or {}) do
		if #step.goals > 1 or not inLog(step.goals[1].quest) then first = step; break end
	end
	if not first then return drop, false end
	local goal = first.goals[1]
	local turnIn = goal.quest and inLog(goal.quest)
	if turnIn then goal = first.goals[#first.goals] end
	if not located(goal) then return nil end
	return { kind = goal.npc and "npc" or "object", id = goal.npc or goal.object,
		name = goal.npcName or goal.objName, map = goal.map, x = goal.x, y = goal.y, f = goal.f }, turnIn, first.title
end

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
	local pageStart
	if cq then
		local g = Dungeons.Giver(cq, from, rec)
		if g then return g, false end
		local s = cq.start
		if located(s) and not s.inside and (s.kind == "item" or cq.startItem) then pageStart = s end
	end
	local d = (cq or rec) and Dungeons.DropPoint(key, cq or rec, from, rec)
	if d then
		local pt, turnIn, required, blocked = dropTarget(d)
		-- A page's item location is usable only after any drop prerequisite.
		if pt == d and pageStart then return pageStart, false end
		return pt, turnIn, required, blocked
	end
	if pageStart then return pageStart, false end
	local e = rec and Lk.QuestEnd(rec.start, from)
	return e and not e.hostile and endPoint(e) or nil, false
end

-- The fifth result marks an unavailable drop prerequisite. Callers must not
-- replace that missing target with the quest's own giver or item location.
function Dungeons.GiverTarget(key, questId)
	local pq = Dungeons.Quest(key, questId)
	if not pq then return nil end
	if not (done(questId) or inLog(questId)) then
		local Lk, C = LK(), ns.Codex
		local rec = Lk and Lk.QuestChain and C and C.Quest(questId)
		if rec then
			local first = Lk.QuestChain(questId, Lk.PlayerInfo())[1]
			if first and first.id ~= questId then
				local pt, turnIn, required, blocked = chainPoint(key, first.id, first, ns.PlayerPoint())
				if blocked then return nil, nil, nil, nil, true end
				if pt then return pt, pt.name, required or first.title, turnIn end
			end
		else
			for _, cid in ipairs(pq.chain or {}) do
				if not done(cid) then
					local cq = Dungeons.Quest(key, cid)
					local pt, turnIn, required, blocked = chainPoint(key, cid, nil, nil)
					if blocked then return nil, nil, nil, nil, true end
					if pt then return pt, pt.name, required or (cq and cq.title), turnIn end
					break
				end
			end
		end
	end
	local g = Dungeons.Giver(pq, ns.PlayerPoint())
	if g then return g, g.name end
	local d = Dungeons.DropPoint(key, pq, ns.PlayerPoint())
	if d then
		local pt, turnIn, required, blocked = dropTarget(d)
		return pt, pt and pt.name, required, turnIn, blocked
	end
	local s = pq.start
	if located(s) and (s.inside or s.kind == "item" or pq.startItem) then return s, s.name end
	return nil
end
