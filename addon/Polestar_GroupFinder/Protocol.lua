-- Polestar Group Finder: the messages players exchange, encoded and
-- decoded. No sending here (Channels.lua, Comm.lua).
--
-- Addon prefix "PSGF". Fields are split by "|", a message is at most 255
-- bytes. The player messages share one header:
--   <kind>|<sid>|<map>|<x>|<y>|<level>|<class>|<group size>|<flags>|<lang>|<list>
-- and differ by kind and list:
--   S  a search, broadcast from a click or a key press, sent again with the
--      quests left whenever an objective is done. <list>: <quest>:<kind><counts>,...
--   R  the answer to S, whispered to the searcher, naming only the quests
--      both have. <list>: <quest><counts>,...
--   Q  "who has quest <quest>?", broadcast from a click on a quest's button,
--      any zone. <list>: <quest>
--   A  the answer to Q, whispered to the asker by whoever has the quest in
--      the log. <list>: <quest>:<percent><counts> (0-100, 100: done or ready
--      to hand in)
-- <counts> is the sender's progress on the quest's objectives, numbers only:
-- "@4/12;0/1" (have/need per objective, in the log's order, at most four),
-- empty when unknown. The reader names them from its own log (same quest,
-- same objectives).
-- and three short ones:
--   X|<sid>             the search is over: the players who listed us drop us
--   G|<sid>|<quest>,... auto-group: "you should invite me" (Group.lua)
--   T|<sid>|<nonce>     a channel probe: nobody answers, we listen for our echo
--
-- <sid> is a random id for this session: a message carrying ours is our own
-- echo. <x>, <y> are 0-1000, empty when the player does not share them.
-- <flags>: "g" auto-group on, "A" / "H" the faction. <lang>: the client's
-- language as one letter (Lang.lua). Quest kinds: g group, n named, k kill,
-- l loot (Quests.lua).

local _, ns = ...

local Protocol = {}
ns.Protocol = Protocol

Protocol.PREFIX = "PSGF"
Protocol.MAX = 255
Protocol.sid = string.format("%06x", math.random(0, 0xffffff))

local sid = Protocol.sid

local function coords(v)
	if not (v and ns.Get("shareCoords")) then return "" end
	return tostring(math.floor(v * 1000 + 0.5))
end

-- "g" when auto-group is on, then "A" or "H" for the faction.
function Protocol.Flags()
	local f = ns.Get("autoGroup") and "g" or ""
	local faction = UnitFactionGroup and select(1, UnitFactionGroup("player"))
	if faction == "Alliance" then f = f .. "A" elseif faction == "Horde" then f = f .. "H" end
	return f
end

-- The shared header of S, R, Q and A, ending with "|".
local function header(kind)
	local map, x, y = ns.Quests.Position()
	local level = UnitLevel and UnitLevel("player") or 0
	local class = UnitClass and select(2, UnitClass("player")) or ""
	local size = (GetNumGroupMembers and GetNumGroupMembers()) or 0
	return table.concat({ kind, sid, tostring(map or 0), coords(x), coords(y), tostring(level or 0),
		class or "", tostring(size), Protocol.Flags(), ns.Lang.Encode() }, "|") .. "|"
end

-- `head` followed by as many of `entries` as fit; returns the text and how
-- many entries went in.
local function fit(head, entries)
	local parts, len = {}, #head
	for _, entry in ipairs(entries) do
		local add = #entry + (#parts > 0 and 1 or 0)
		if len + add > Protocol.MAX then break end
		parts[#parts + 1] = entry
		len = len + add
	end
	return head .. table.concat(parts, ","), #parts
end

local function ids(list)
	local out = {}
	for i, id in ipairs(list) do out[i] = tostring(id) end
	return out
end

local MAX_COUNTS = 4

-- "@4/12;0/1": our progress on quest `id`'s objectives; "" when unknown.
function Protocol.Counts(id)
	local q = ns.Quests.Log()[id]
	local parts = {}
	for i, o in ipairs(q and q.objectives or {}) do
		if i > MAX_COUNTS then break end
		local have, need = tonumber(o.have), tonumber(o.need)
		if not (have and need and need > 0) then have, need = o.done and 1 or 0, 1 end
		parts[#parts + 1] = math.min(have, need) .. "/" .. need
	end
	return #parts > 0 and ("@" .. table.concat(parts, ";")) or ""
end

-- `quests`: { { id, kind } }.
function Protocol.Search(quests)
	local entries = {}
	for i, q in ipairs(quests) do entries[i] = q.id .. ":" .. q.kind .. Protocol.Counts(q.id) end
	return fit(header("S"), entries)
end

function Protocol.Reply(questIDs)
	local entries = {}
	for i, id in ipairs(questIDs) do entries[i] = id .. Protocol.Counts(id) end
	return (fit(header("R"), entries))
end

function Protocol.QuestSearch(id)
	return header("Q") .. tostring(id)
end

function Protocol.QuestReply(id, pct)
	pct = math.max(0, math.min(100, math.floor(tonumber(pct) or 0)))
	return header("A") .. id .. ":" .. pct .. Protocol.Counts(id)
end

function Protocol.GroupRequest(questIDs)
	return (fit("G|" .. sid .. "|", ids(questIDs)))
end

function Protocol.Stop()
	return "X|" .. sid
end

function Protocol.Probe(nonce)
	return "T|" .. sid .. "|" .. nonce
end

-- { { have, need }, ... } from "4/12;0/1", nil for none.
function Protocol.DecodeCounts(text)
	if type(text) ~= "string" or text == "" then return nil end
	local out = {}
	for h, n in text:gmatch("(%d+)/(%d+)") do
		if #out >= MAX_COUNTS then break end
		out[#out + 1] = { tonumber(h), tonumber(n) }
	end
	return #out > 0 and out or nil
end

-- A table for a well-formed message, nil for anything else.
function Protocol.Decode(text)
	if type(text) ~= "string" or #text > Protocol.MAX then return nil end
	local kind, msid, map, x, y, lvl, class, size, fl, lang, list =
		text:match("^([SRQA])|(%x+)|(%d+)|(%d*)|(%d*)|(%d+)|(%u*)|(%d+)|([gAH]*)|([a-z]?)|(.*)$")
	if not kind then
		local tsid, nonce = text:match("^T|(%x+)|(%w+)$")
		if tsid then return { kind = "T", sid = tsid, nonce = nonce } end
		local xsid = text:match("^X|(%x+)$")
		if xsid then return { kind = "X", sid = xsid } end
		local gsid, gids = text:match("^G|(%x+)|([%d,]*)$")
		if gsid then
			local m = { kind = "G", sid = gsid, quests = {} }
			for id in gids:gmatch("%d+") do m.quests[#m.quests + 1] = { id = tonumber(id) } end
			return m
		end
		return nil
	end
	local m = { kind = kind, sid = msid, map = tonumber(map), level = tonumber(lvl), class = class,
		size = tonumber(size), flags = fl, langs = ns.Lang.Decode(lang), quests = {} }
	if m.map == 0 then m.map = nil end
	if x ~= "" and y ~= "" then m.x, m.y = tonumber(x) / 1000, tonumber(y) / 1000 end
	for entry in list:gmatch("[^,]+") do
		local id, k, pct, counts = entry:match("^(%d+):?([gnkl]?)(%d*)@?([%d/;]*)$")
		id = tonumber(id)
		if id then
			m.quests[#m.quests + 1] = { id = id, kind = k ~= "" and k or nil, pct = tonumber(pct), counts = Protocol.DecodeCounts(counts) }
		end
	end
	return m
end
