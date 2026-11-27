-- Polestar Group Finder: the players found, and in which order to show them.
--
-- A player counts once they share a quest with you: they searched for it
-- ("asking") or answered your search ("reply"). Best first: more quests in
-- common, Polestar's live step among them, nearer (yards on the same
-- continent, else the same zone), not already grouped, heard from lately.
-- Entries go after MAX_AGE seconds, and when they join your group.

local _, ns = ...

local Matcher = {}
ns.Matcher = Matcher

local MAX_AGE = { reply = 600, asking = 300 } -- seconds before an entry is dropped
local peers = {} -- sender -> entry

local function stepQuests()
	local set = {}
	for _, id in ipairs(ns.PolestarStepQuests and ns.PolestarStepQuests() or {}) do set[id] = true end
	return set
end

-- Copies what a message says about its sender into entry `e`.
local function fill(e, m, source)
	e.level, e.class, e.size = m.level, m.class, m.size or 0
	e.map, e.x, e.y = m.map, m.x, m.y
	e.source = source
	e.sid = m.sid
	e.flags = m.flags or ""
	e.autoGroup = e.flags:find("g", 1, true) ~= nil
	e.faction = e.flags:match("[AH]")
	e.langs = m.langs
	e.langTag = ns.Lang.Summary(m.langs)
	e.at = ns.Now()
	return e
end

-- Nearer first, then not already grouped (a full group last), then the
-- freshest. `here` is { map, x, y }; sets e.yards and e.sameZone.
local function placeScore(e, here, now)
	e.yards = ns.Quests.Yards(here[1], here[2], here[3], e.map, e.x, e.y)
	e.sameZone = here[1] ~= nil and here[1] == e.map
	local score = 0
	if e.yards then score = score + math.max(0, 300 - e.yards / 5)
	elseif e.sameZone then score = score + 120 end
	if (e.size or 0) >= 5 then score = score - 500 elseif (e.size or 0) > 0 then score = score - 20 end
	return score - (now - e.at) / 10
end

function Matcher.Add(sender, m, common, source)
	local e = fill(peers[sender] or { name = sender }, m, source)
	e.quests = common
	local kinds, counts = {}, {}
	for _, q in ipairs(m.quests or {}) do
		if q.kind then kinds[q.id] = q.kind end
		if q.counts then counts[q.id] = q.counts end
	end
	e.kinds, e.counts = kinds, counts
	local isNew = not peers[sender]
	peers[sender] = e
	if isNew then
		ns.Debug(ns.L["%s is on %s (%s)."], ns.ShortName(sender), ns.Quests.Title(common[1]),
			source == "asking" and ns.L["is looking too"] or "")
	end
	ns.Fire("PEERS")
	if isNew then ns.Fire("PEER_NEW", e) end
	if ns.Group then ns.Group.Consider(e) end
end

function Matcher.Get(sender) return peers[sender] end

function Matcher.Remove(sender)
	if peers[sender] then
		peers[sender] = nil
		ns.Fire("PEERS")
	end
end

-- The names of the players found, for an update whispered to them.
function Matcher.Names()
	local out = {}
	for name in pairs(peers) do out[#out + 1] = name end
	return out
end

function Matcher.Clear()
	wipe(peers)
	ns.Fire("PEERS")
end

-- Is `name` in your group? By the roster's names (UnitName's first return:
-- Forever gives a surname, not a realm, as its second), realm dropped.
local function inMyGroup(name)
	if type(name) ~= "string" then return false end
	local want = ns.NameKey(name)
	local raid = IsInRaid and IsInRaid()
	for i = 1, raid and 40 or 4 do
		local unit = (raid and "raid" or "party") .. i
		local n = UnitExists(unit) and ns.Readable((UnitName(unit)))
		if type(n) == "string" and ns.NameKey(n) == want then return true end
	end
	return false
end
Matcher.InGroup = function(name) local ok, r = pcall(inMyGroup, name) return ok and r end

-- What counts as "my" quests: those of the active search, else any with an
-- open objective in the log.
function Matcher.Mine(id)
	if ns.Session and ns.Session.Active() then return ns.Session.Has(id) end
	return ns.Quests.Pending(id)
end

-- The list to show: entries with `yards` (or nil), `sameZone` and `score`.
function Matcher.List()
	local now = ns.Now()
	local here = { ns.Quests.Position() }
	local step = stepQuests()
	local list = {}
	for name, e in pairs(peers) do
		local ok, grouped = pcall(inMyGroup, name)
		if now - e.at > (MAX_AGE[e.source] or 300) or (ok and grouped) or not ns.Lang.Compatible(e.langs) then
			peers[name] = nil
		else
			-- Quests that left our log since no longer count.
			local still = {}
			for _, id in ipairs(e.quests) do if Matcher.Mine(id) then still[#still + 1] = id end end
			if #still > 0 then
				e.quests = still
				-- More quests in common first, Polestar's live step above all.
				local score = #still * 100
				for _, id in ipairs(still) do if step[id] then score = score + 150 end end
				e.score = score + placeScore(e, here, now)
				list[#list + 1] = e
			else
				peers[name] = nil -- nothing in common any more
			end
		end
	end
	table.sort(list, function(a, b) return a.score > b.score end)
	return list
end

-- Every quest id this player is known to share with you.
function Matcher.QuestsOf(sender)
	local out = {}
	local e = peers[sender]
	for _, id in ipairs(e and e.quests or {}) do out[#out + 1] = id end
	return out
end

ns.RegisterEvent("GROUP_ROSTER_UPDATE", function() ns.Fire("PEERS") end)
ns.On("SESSION", function() ns.Fire("PEERS") end)
ns.On("ENABLED", function(on) if not on then Matcher.Clear() end end)
