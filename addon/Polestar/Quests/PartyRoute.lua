-- Party route: the party leader's route choices, for the party to take the
-- same route: the answers at group quests (`when group`: Engine.GroupAnswer,
-- "do" or "skip"; a quest the leader has not answered is left out) and the
-- dungeons turned on for leveling guides (Engine.DungeonChosen, by the
-- instance's Map id). The leader sends them with party.routeShare on (off
-- until turned on); a member running Polestar gets a banner in the guide
-- window ("Ana leads the party with 3 group quests and Shadowfang Keep. Take
-- the same route?"), follows them at once, or ignores them
-- (party.routeFollow: "ask" | "follow" | "off").
--
-- Rules as Party.lua's: hidden addon messages to the party only (never chat,
-- never a raid), sent when a choice changes and when asked, never on a timer.
--
-- Messages (prefix Party.PREFIX, PARTY), each at most Party.MAX_BYTES:
--   "R2|7|2|33,36"       a route: its serial (1-999), how many answer parts
--                        follow, the dungeons chosen (comma-separated, may be empty)
--   "R2A|7|1|783d,91752s" answer part 1 of route 7: quest id + d (do) or s (skip)
--   "R2Q|"               asks the leader for theirs (a member after joining,
--                        a login or reload, or a new leader)
-- A route counts once every part of its serial has arrived. Party.Decode
-- refuses all three, so quest progress never reads them.
--
--   PartyRoute.Encode(route, serial) -> { texts } ; PartyRoute.Mine() -> route
--   PartyRoute.Take(route)  set this character's answers and dungeons to route's
-- A route: { answers = { [quest] = "do" | "skip" }, maps = { sorted Map ids } }.

local ADDON, ns = ...
local L = ns.L
local Party = ns.Party
if not Party then return end

local PartyRoute = {}
ns.PartyRoute = PartyRoute

local VERSION = "R2"
PartyRoute.ASK = VERSION .. "Q|"
local MAX_MAPS, MAX_PARTS, MAX_ANSWERS = 20, 10, 300
local CODE = { ["do"] = "d", skip = "s" }
local ANSWER = { d = "do", s = "skip" }

ns.RegisterDefaults("party", { routeShare = false, routeFollow = "ask" })

---------------------------------------------------------------------------
-- The message format
---------------------------------------------------------------------------

local function sortedQuests(answers)
	local qs = {}
	for q in pairs(answers) do qs[#qs + 1] = q end
	table.sort(qs)
	return qs
end

-- The messages for a route, in order: the header, then its answer parts.
function PartyRoute.Encode(route, serial)
	local parts, cur = {}, {}
	local head = VERSION .. "A|" .. serial .. "|" .. MAX_PARTS .. "|"
	local size = #head
	for _, q in ipairs(sortedQuests(route.answers)) do
		local item = q .. CODE[route.answers[q]]
		if #cur > 0 and size + 1 + #item > Party.MAX_BYTES then
			parts[#parts + 1] = cur
			cur, size = {}, #head
		end
		cur[#cur + 1] = item
		size = size + #item + (#cur > 1 and 1 or 0)
	end
	if #cur > 0 then parts[#parts + 1] = cur end
	local texts = { VERSION .. "|" .. serial .. "|" .. #parts .. "|" .. table.concat(route.maps, ",") }
	for i, p in ipairs(parts) do
		texts[#texts + 1] = VERSION .. "A|" .. serial .. "|" .. i .. "|" .. table.concat(p, ",")
	end
	return texts
end

-- One message: "route", serial, parts, maps | "answers", serial, index,
-- answers | nil for anything malformed, a request, or another version.
function PartyRoute.Decode(text)
	if type(text) ~= "string" then return nil end
	local serial, n, list = text:match("^" .. VERSION .. "|(%d+)|(%d+)|([%d,]*)$")
	if serial then
		n = tonumber(n)
		if n > MAX_PARTS then return nil end
		local maps = {}
		for id in list:gmatch("[^,]+") do
			local m = tonumber(id)
			if not m or m <= 0 or #maps >= MAX_MAPS then return nil end
			maps[#maps + 1] = m
		end
		table.sort(maps)
		return "route", tonumber(serial), n, maps
	end
	local i
	serial, i, list = text:match("^" .. VERSION .. "A|(%d+)|(%d+)|([%dds,]+)$")
	if not serial then return nil end
	local answers = {}
	for item in list:gmatch("[^,]+") do
		local q, c = item:match("^(%d+)([ds])$")
		q = tonumber(q)
		if not q or q <= 0 then return nil end
		answers[q] = ANSWER[c]
	end
	return "answers", tonumber(serial), tonumber(i), answers
end

---------------------------------------------------------------------------
-- This character's choices
---------------------------------------------------------------------------

-- The answer at every group quest this character has one for: its own
-- answers, and with an answer for all (behavior.groupQuests "do" or "skip")
-- every group quest of its guides; plus the dungeons chosen.
function PartyRoute.Mine()
	local answers, maps = {}, {}
	local E = ns.Engine
	for q in pairs(ns.CharState().groupQuests or {}) do
		local a = E and E.GroupAnswer and E.GroupAnswer(q)
		if a then answers[q] = a end
	end
	local all = ns.Get("behavior.groupQuests")
	if (all == "do" or all == "skip") and E and E.GroupQuests then
		for _, g in ipairs(E.GroupQuests()) do
			if not answers[g.quest] then answers[g.quest] = all end
		end
	end
	for map, on in pairs(ns.CharState().dungeons or {}) do
		if on == true and type(map) == "number" then maps[#maps + 1] = map end
	end
	table.sort(maps)
	return { answers = answers, maps = maps }
end

local function sameMaps(a, b)
	if #a ~= #b then return false end
	for i = 1, #a do if a[i] ~= b[i] then return false end end
	return true
end

-- Does `route` change anything for this character? Its answers are taken
-- one by one; a quest the leader has not answered keeps this character's.
local function differs(route)
	local E = ns.Engine
	if not sameMaps(PartyRoute.Mine().maps, route.maps) then return true end
	for q, a in pairs(route.answers) do
		if not (E and E.GroupAnswer and E.GroupAnswer(q) == a) then return true end
	end
	return false
end
PartyRoute.Differs = differs

-- Every answer the route has, and every dungeon as the route has it: on when
-- listed, off when not.
function PartyRoute.Take(route)
	local E = ns.Engine
	if not (E and E.AnswerGroup and E.ChooseDungeon) then return end
	for q, a in pairs(route.answers) do
		if E.GroupAnswer(q) ~= a then E.AnswerGroup(q, a) end
	end
	local keep = {}
	for _, map in ipairs(route.maps) do keep[map] = true end
	for _, map in ipairs(PartyRoute.Mine().maps) do if not keep[map] then E.ChooseDungeon(map, false) end end
	for _, map in ipairs(route.maps) do E.ChooseDungeon(map, true) end
end

---------------------------------------------------------------------------
-- Sending (the leader)
---------------------------------------------------------------------------

local function grouped()
	return IsInGroup and IsInGroup() and not (IsInRaid and IsInRaid()) or false
end

local function leading()
	return grouped() and UnitIsGroupLeader and UnitIsGroupLeader("player") or false
end

local function send(text)
	local fn = C_ChatInfo and C_ChatInfo.SendAddonMessage
	if fn then fn(Party.PREFIX, text, "PARTY") end
end

local serial = 0
local sendPending = false
local function shareSoon()
	if sendPending or not (ns.Get("party.routeShare") and leading()) then return end
	sendPending = true
	C_Timer.After(1, function()
		sendPending = false
		if not (ns.Get("party.routeShare") and leading()) then return end
		serial = serial % 999 + 1
		for _, text in ipairs(PartyRoute.Encode(PartyRoute.Mine(), serial)) do send(text) end
	end)
end

---------------------------------------------------------------------------
-- Receiving (a member)
---------------------------------------------------------------------------

-- The party unit and short name a sender's messages arrive under, or nil.
local function unitOf(sender)
	local key = Ambiguate and Ambiguate(sender, "none") or sender
	local n = GetNumSubgroupMembers and GetNumSubgroupMembers() or 0
	for i = 1, n do
		local unit = "party" .. i
		local name, realm = UnitName(unit)
		if not (ns.Compat.IsSecret(name) or ns.Compat.IsSecret(realm)) and name then
			local full = (realm and realm ~= "") and (name .. "-" .. realm:gsub("[%s%-]", "")) or name
			if full == key then return unit, name end
		end
	end
	return nil
end

local asked -- the last route offered (leader, answers, dungeons), so it is offered once
local incoming -- the route being received: { leader, serial, parts, got, seen, answers, maps }

local function signature(route)
	local items = {}
	for _, q in ipairs(sortedQuests(route.answers)) do items[#items + 1] = q .. CODE[route.answers[q]] end
	return route.leader .. "|" .. table.concat(items, ",") .. "|" .. table.concat(route.maps, ",")
end

local function onRoute(route)
	local mode = ns.Get("party.routeFollow")
	if mode == "off" or not differs(route) then return end
	if mode == "follow" then return PartyRoute.Take(route) end
	local sig = signature(route)
	if asked == sig then return end
	asked = sig
	ns.Fire("PARTY_ROUTE", route)
end

local function finish(r)
	if r.got < r.parts then return end
	incoming = nil
	local count = 0
	for _ in pairs(r.answers) do count = count + 1 end
	if count > MAX_ANSWERS then return end
	onRoute({ leader = r.leader, answers = r.answers, maps = r.maps })
end

local function onAddonMessage(_, prefix, text, channel, sender)
	if prefix ~= Party.PREFIX or channel ~= "PARTY" or type(sender) ~= "string" or type(text) ~= "string" then return end
	if text:sub(1, #VERSION) ~= VERSION then return end
	if text == PartyRoute.ASK then
		if unitOf(sender) then shareSoon() end
		return
	end
	local unit, name = unitOf(sender)
	if not (unit and UnitIsGroupLeader and UnitIsGroupLeader(unit)) then return end
	local kind, n, a, b = PartyRoute.Decode(text)
	if kind == "route" then
		incoming = { leader = name, serial = n, parts = a, got = 0, seen = {}, answers = {}, maps = b }
		finish(incoming)
	elseif kind == "answers" then
		local r = incoming
		if not (r and r.leader == name and r.serial == n) or a > r.parts or r.seen[a] then return end
		r.seen[a] = true
		r.got = r.got + 1
		for q, answer in pairs(b) do r.answers[q] = answer end
		finish(r)
	end
end

-- A member asks the leader for the route: after joining, a login or reload
-- in a party, or a new leader.
local wasGrouped = false
local function ask()
	if grouped() and not leading() and ns.Get("party.routeFollow") ~= "off" then send(PartyRoute.ASK) end
end

local function onRoster()
	local now = grouped()
	if now and not wasGrouped then C_Timer.After(3, ask) end
	if not now then asked, incoming = nil, nil end
	wasGrouped = now
	-- Someone joined our party: the leader's next send reaches them too.
	shareSoon()
end

---------------------------------------------------------------------------
-- Wiring
---------------------------------------------------------------------------

ns.OnLogin(function()
	if C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then C_ChatInfo.RegisterAddonMessagePrefix(Party.PREFIX) end
	ns.RegisterEvent("CHAT_MSG_ADDON", onAddonMessage)
	ns.RegisterEvent("GROUP_ROSTER_UPDATE", onRoster)
	ns.RegisterEvent("PARTY_LEADER_CHANGED", function() incoming = nil; C_Timer.After(1, ask) end)
	wasGrouped = grouped()
	if wasGrouped then C_Timer.After(3, ask) end
end)

ns.On("GROUP_ANSWERED", shareSoon)
ns.On("DUNGEONS_CHOSEN", shareSoon)
ns.On("SETTING_CHANGED", function(path)
	if (path == "party.routeShare" or path == "behavior.groupQuests") and ns.IsLoggedIn() then shareSoon() end
end)

-- The settings, in Party's section (Questing, Quests, Party), registered with it.
local controls = Party.OPTIONS and Party.OPTIONS.controls
if controls then
	controls[#controls + 1] = { kind = "toggle", key = "party.routeShare", label = L["Share my route choices when I lead"],
		help = L["Party members who run Polestar are offered your answers at group quests and your dungeons, so the party takes one route."] }
	controls[#controls + 1] = { kind = "dropdown", key = "party.routeFollow", label = L["The party leader's route"],
		help = L["What happens when the leader's answers at group quests or dungeons differ from yours."],
		choices = { { value = "ask", label = L["Ask me"] }, { value = "follow", label = L["Take it"] }, { value = "off", label = L["Ignore it"] } } }
end
