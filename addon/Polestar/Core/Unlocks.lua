-- What doing a quest opens up: the quests that need it done first, its
-- follow-ups, so a player deciding to skip a quest sees what goes with it.
-- The guide window's quest tooltips read it (UI/GuideFrame.lua). Contract:
-- docs/ARCHITECTURE.md, "Engine" (What a quest unlocks).
--
--   Unlocks.For(q) -> { next = { entry, ... }, last = entry | nil } | nil
--     next: q's follow-ups for this character, the chain's next part first,
--       then the guides', then the quest database's; nil when there is none
--     last: the end of q's chain, when that is further than its next part
--       (see Chain below)
--     entry = { id, title, giver (a name: only when someone other than q's
--       ender gives it) | nil, part, of (its place in the chain) | nil,
--       rewards (last only: { choices, items, xp, money } as a turn-in's) | nil }
--
-- Sources, as in Closes: the `pre`/`preAll` of the accepts of every shown
-- guide (indexed once, rebuilt on GUIDES_REGISTERED and PACKS_CHANGED), and
-- the quest database's (QuestDB.FollowUps) when it is loaded, for quests no
-- guide takes. Left out: follow-ups done or in the log, and ones this
-- character can never take (the guide's faction, race and class, the
-- accept's `only`, the database's faction, race and class).
--
-- Chain: from q, back while its one prerequisite carries on to q, and on
-- while the quest q carries on to has q as its one prerequisite. A quest
-- carries on to its one follow-up, or at a branch to the one follow-up with
-- its own title (a series' next part, the side quests branching off it:
-- The Defias Brotherhood part 6 opens part 7 and Red Silk Bandanas).
-- Numbered ("part 2 of 7") only when that walk finds both ends, a first
-- quest that needs nothing and a last one that opens nothing, and holds at
-- least three quests: a count never stops at a branch it cannot follow.
-- The last quest's rewards: a guide's turn-in of it, else the Codex's when
-- Lookup has it loaded (never loaded for a tooltip).

local ADDON, ns = ...

local Unlocks = {}
ns.Unlocks = Unlocks

local type, ipairs = type, ipairs

local NONE = {}
local MAX_CHAIN = 30

-- { follow = { [q] = { e, ... } }, accepts = { [q] = { e, ... } },
--   turnins = { [q] = { e, ... } } }, e = { goal, step, guide }: the guide
-- accepts that need q, and every accept and turn-in of q.
local index

local function push(map, q, e)
	local list = map[q]
	if not list then
		list = {}
		map[q] = list
	end
	list[#list + 1] = e
end

local function guideIndex()
	if index then return index end
	local follow, accepts, turnins = {}, {}, {}
	local Guides = ns.Guides
	for _, h in ipairs(Guides.List()) do
		local g = Guides.Get(h.id)
		for _, step in ipairs(g and g.steps or NONE) do
			for _, goal in ipairs(step.goals) do
				local q = goal.quest
				if q and goal.t == "accept" then
					local e = { goal = goal, step = step, guide = g }
					push(accepts, q, e)
					for _, p in ipairs(type(goal.pre) == "table" and goal.pre or NONE) do push(follow, p, e) end
					for _, p in ipairs(type(goal.preAll) == "table" and goal.preAll or NONE) do push(follow, p, e) end
				elseif q and goal.t == "turnin" then
					push(turnins, q, { goal = goal, step = step, guide = g })
				end
			end
		end
	end
	index = { follow = follow, accepts = accepts, turnins = turnins }
	return index
end

ns.On("GUIDES_REGISTERED", function() index = nil end)
ns.On("PACKS_CHANGED", function() index = nil end)

-- One ask's context: the character, the guide index and, when loaded, the
-- quest database with this character's context.
local function context()
	local C = ns.Compat
	local player = C.GetPlayerInfo()
	local Q = ns.QuestDB
	local db = Q and Q.IsLoaded and Q.IsLoaded() and Q or nil
	return { C = C, player = player, idx = guideIndex(), Q = db, ctx = db and db.PlayerContext(player) or nil }
end

local function mine(s, e)
	local G, p = ns.Guides, s.player
	return G.GuideMatches(e.guide, p) and G.Matches(e.step.only, p) and G.Matches(e.goal.only, p)
end

-- A quest the database knows this character can never take.
local function notForMe(s, q)
	local r = s.Q and s.Q.QuestRecord(q)
	return r ~= nil and not s.Q.IsEligible(r, s.ctx)
end

-- q's follow-ups for this character (done or not), the guides' first.
local function nextOf(s, q)
	local out, seen = {}, {}
	for _, e in ipairs(s.idx.follow[q] or NONE) do
		local f = e.goal.quest
		if not seen[f] and mine(s, e) then
			seen[f] = true
			out[#out + 1] = f
		end
	end
	if s.Q then
		for _, f in ipairs(s.Q.FollowUps(q) or NONE) do
			if not seen[f] and not notForMe(s, f) then
				seen[f] = true
				out[#out + 1] = f
			end
		end
	end
	return out
end

-- q's prerequisites for this character: the guides' accepts' and the
-- database's, both kinds (one of, every one) together.
local function prevOf(s, q)
	local out, seen = {}, {}
	local function add(p)
		if not seen[p] and not notForMe(s, p) then
			seen[p] = true
			out[#out + 1] = p
		end
	end
	for _, e in ipairs(s.idx.accepts[q] or NONE) do
		if mine(s, e) then
			for _, p in ipairs(type(e.goal.pre) == "table" and e.goal.pre or NONE) do add(p) end
			for _, p in ipairs(type(e.goal.preAll) == "table" and e.goal.preAll or NONE) do add(p) end
		end
	end
	local r = s.Q and s.Q.QuestRecord(q)
	if r then
		local F = s.Q.F
		for _, p in s.Q.Each(r[F.PRE]) do add(p) end
		for _, p in s.Q.Each(r[F.PRE_ALL]) do add(p) end
	end
	return out
end

local function titleOf(s, q)
	local N = ns.Names
	local t = N and N.Quest(q)
	if t then return t end
	for _, e in ipairs(s.idx.accepts[q] or NONE) do
		if e.goal.title then return e.goal.title end
	end
	return s.Q and s.Q.GetQuestTitle(q) or ("#" .. q)
end

-- The quest of `list` (from's follow-ups) the chain carries on to: the only
-- one, or the only one with from's title; nil when there is none.
local function onward(s, list, from)
	if #list == 1 then return list[1] end
	local title, found = titleOf(s, from), nil
	for _, f in ipairs(list) do
		if titleOf(s, f) == title then
			if found then return nil end
			found = f
		end
	end
	return found
end

-- q's chain (Chain, above): { pos (q's part), n, last, next (the follow-up
-- it carries on to) } or nil.
local function chainOf(s, q)
	local seen, cur, before, first = { [q] = true }, q, 0, false
	for _ = 1, MAX_CHAIN do
		local p = prevOf(s, cur)
		if #p == 0 then
			first = true
			break
		end
		if #p > 1 or seen[p[1]] or onward(s, nextOf(s, p[1]), p[1]) ~= cur then break end
		cur = p[1]
		seen[cur] = true
		before = before + 1
	end
	if not first then return nil end
	cur = q
	local after, last, nextId = 0, false, nil
	for _ = 1, MAX_CHAIN do
		local list = nextOf(s, cur)
		if #list == 0 then
			last = true
			break
		end
		local f = onward(s, list, cur)
		if not f or seen[f] then break end
		local p = prevOf(s, f)
		if #p ~= 1 or p[1] ~= cur then break end
		if cur == q then nextId = f end
		cur = f
		seen[cur] = true
		after = after + 1
	end
	local n = before + 1 + after
	if not last or n < 3 or not nextId then return nil end
	return { pos = before + 1, n = n, last = cur, next = nextId }
end

-- Who a guide goal is with: key ("n<id>" or "o<id>"), name.
local function goalWho(goal)
	local N = ns.Names
	if goal.npc then return "n" .. goal.npc, N.Npc(goal.npc) or goal.npcName end
	if goal.object then return "o" .. goal.object, N.Object(goal.object) or goal.objName end
	return nil
end

-- The first of a database quest's `START` or `FINISH` references (an NPC
-- > 0, an object < 0): key, name.
local function dbWho(s, q, field)
	local r = s.Q and s.Q.QuestRecord(q)
	if not r then return nil end
	for _, ref in s.Q.Each(r[s.Q.F[field]]) do
		return (ref > 0 and "n" .. ref or "o" .. -ref), s.Q.EntityName(ref)
	end
	return nil
end

-- Who gives quest f (key, name), and who takes q in (key).
local function giverOf(s, f)
	for _, e in ipairs(s.idx.accepts[f] or NONE) do
		if mine(s, e) then
			local key, name = goalWho(e.goal)
			if key then return key, name end
		end
	end
	return dbWho(s, f, "START")
end

local function enderOf(s, q)
	for _, e in ipairs(s.idx.turnins[q] or NONE) do
		if mine(s, e) then
			local key = goalWho(e.goal)
			if key then return key end
		end
	end
	return (dbWho(s, q, "FINISH"))
end

-- A turn-in's rewards for q: a guide's, else a loaded Codex's.
local function rewardsOf(s, q)
	for _, e in ipairs(s.idx.turnins[q] or NONE) do
		if mine(s, e) and type(e.goal.rewards) == "table" then return e.goal.rewards end
	end
	local Cx = ns.Codex
	local rec = Cx and Cx.IsLoaded and Cx.IsLoaded() and Cx.Quest(q)
	if not rec then return nil end
	local function items(ids)
		local out = {}
		for i, id in ipairs(ids or NONE) do out[i] = { item = id, itemName = Cx.Name("item", id) } end
		return out
	end
	local r = { choices = items(rec.choices), items = items(rec.rewards), xp = rec.xp }
	if #r.choices == 0 and #r.items == 0 and not r.xp then return nil end
	return r
end

function Unlocks.For(q)
	if type(q) ~= "number" or q <= 0 then return nil end
	local s = context()
	local direct = nextOf(s, q)
	if #direct == 0 then return nil end
	local C = s.C
	local chain = chainOf(s, q)
	local ender = enderOf(s, q)
	local out = {}
	for _, f in ipairs(direct) do
		if not (C.IsOnQuest(f) or C.IsQuestCompleted(f)) then
			local key, name = giverOf(s, f)
			local e = { id = f, title = titleOf(s, f), giver = key and key ~= ender and name or nil }
			-- The chain's next part leads the list.
			if chain and f == chain.next then
				e.part, e.of = chain.pos + 1, chain.n
				table.insert(out, 1, e)
			else
				out[#out + 1] = e
			end
		end
	end
	if #out == 0 then return nil end
	local last
	if chain and chain.last ~= chain.next then
		last = { id = chain.last, title = titleOf(s, chain.last), part = chain.n, of = chain.n, rewards = rewardsOf(s, chain.last) }
	end
	return { next = out, last = last }
end
