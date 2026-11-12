-- Update notices (docs/ARCHITECTURE.md, "Update notices"): what Polestar
-- knows of a newer release, and when to say so. Many reports come from
-- players a release or two behind, so it says so at every login until they
-- update; the card and the guide window's line are UI/UpdateCard.lua.
--
-- Where the newest release comes from, most trusted first:
--   1. Polestar Client: it writes PolestarClientInfo into the Polestar
--      folder's ClientInfo.lua (docs/RECORDING.md, "Client info") from the
--      release list it checks for its own addon updates: { latest, released,
--      checked, releases = { newest first } }. The release zip ships the file
--      empty. A check newer than a peer's sighting overrules that peer.
--   2. Other players: a release version a party member's Polestar sends
--      (Quests/Party.lua: the hello, "1P|"), a guild member's (the guild
--      hello below) or a stranger's (the version probe below: one hidden
--      addon whisper to a player of your faction you target, mouse over or
--      see). It counts when it parses as x.y.z, is newer than ours and at
--      most one minor version ahead (a garbled or made-up "9.9.9" is
--      dropped); it is kept PEER_DAYS days.
--   3. Nothing knows: a build first run more than OLD_DAYS days ago says it
--      may be old (no card).
-- Dev builds ("dev") and pre-releases ("0.3.7-rc1") from peers never count;
-- our own dev build hears nothing at all.
--
-- How far behind: the Client's list counts the releases newer than ours;
-- without it, the version numbers say (0.3.5 -> 0.3.7: 2; a new minor
-- version: its patch number + 1).
--
-- The guild hello: once a login (at most every HELLO_GAP), "1H|<version>"
-- on the guild's hidden addon channel, Party's message on Party's prefix
-- (Party reads only the party channel, so older Polestars ignore it). A
-- guild member on a newer release answers "1Y|<version>" after a random
-- moment, unless someone else answered with that version or newer first,
-- and at most once per REPLY_GAP. Only the version goes out, and only while
-- party sharing (party.share) is on: a player who turned that off sends
-- nothing here either, probes included. Addon messages are listened to in a
-- guild or while sharing; solo with sharing off, not at all.
--
--   Polestar.Update.Parse(v), .Compare(a, b), .Release(v)
--   Polestar.Update.Latest()      -> version, behind, source ("client" | "peer") | nil
--   Polestar.Update.Notice()      -> { kind = "behind", latest, behind, mine } | { kind = "old", weeks } | nil
--   Polestar.Update.NotePeer(v)   a peer's version (true when it counts)
--   Polestar.Update.Probe(unit), .ProbeTarget(unit), .Listen(), .Probing()  the version probe
--   Polestar.Update.Covers(v)     the card says it, so a peer's chat line need not
--   Polestar.Update.ReportNote(), .Outdated()  for the report window

local ADDON, ns = ...
local floor, max, type, tonumber, tostring, ipairs = math.floor, math.max, type, tonumber, tostring, ipairs

local U = {}
ns.Update = U

local DAY = 86400
U.PEER_DAYS = 7 -- a peer's version is kept this long
U.OLD_DAYS = 21 -- with nothing known, a build first run this long ago says it may be old
U.CLIENT_FRESH = 7 * DAY -- the Client's check this recent says we are current
U.HELLO_GAP = 1800 -- seconds between two guild hellos (a /reload sends none)
U.HELLO_DELAY = 20 -- seconds after login
U.REPLY_GAP = 300 -- seconds between two guild answers
U.PREFIX = "Polestar" -- Party.PREFIX

ns.RegisterDefaults("update", { card = true, probe = true })

---------------------------------------------------------------------------
-- Versions
---------------------------------------------------------------------------

-- "0.3.7" -> { 0, 3, 7 }; "0.3.7-rc1" -> { 0, 3, 7, pre = "rc1" }; nil for
-- anything else ("dev", "999.0", a nil).
function U.Parse(v)
	if type(v) ~= "string" or #v > 32 then return nil end
	local nums, pre = v:match("^(%d+%.%d+%.%d+[%.%d]*)%-?([%w%.]*)$")
	if not nums or nums:find("%.%.") or nums:sub(-1) == "." then return nil end
	local out = {}
	for n in nums:gmatch("%d+") do out[#out + 1] = tonumber(n) end
	if pre ~= "" then out.pre = pre end
	return out
end

-- A release's version: x.y.z, no pre-release part.
function U.Release(v)
	local p = U.Parse(v)
	return p ~= nil and p.pre == nil
end

-- -1, 0 or 1 as a is older than, the same as or newer than b; nil when
-- either does not parse. A pre-release comes before its release.
function U.Compare(a, b)
	local pa, pb = U.Parse(a), U.Parse(b)
	if not (pa and pb) then return nil end
	for i = 1, max(#pa, #pb) do
		local x, y = pa[i] or 0, pb[i] or 0
		if x ~= y then return x > y and 1 or -1 end
	end
	if pa.pre == pb.pre then return 0 end
	if not pa.pre then return 1 end
	if not pb.pre then return -1 end
	return pa.pre > pb.pre and 1 or -1
end

local function newer(a, b)
	local c = U.Compare(a, b)
	return c ~= nil and c > 0
end

-- How many releases a is ahead of b (a newer), from the numbers alone.
function U.Estimate(a, b)
	local pa, pb = U.Parse(a), U.Parse(b)
	if not (pa and pb) then return 1 end
	if pa[1] == pb[1] and pa[2] == pb[2] then return max(1, (pa[3] or 0) - (pb[3] or 0)) end
	return max(1, (pa[3] or 0) + 1)
end

-- Our own version, when it is one (a dev build's "dev" is not).
local function mine()
	local v = tostring(ns.version or "")
	return U.Parse(v) and v or nil
end

-- A peer's version we believe: a release, newer than ours, at most one minor
-- version ahead (or the next major's x.0).
local function plausible(v)
	local p, m = U.Parse(v), U.Parse(mine())
	if not (p and m) then return false end
	return (p[1] == m[1] and p[2] <= m[2] + 1) or (p[1] == m[1] + 1 and p[2] == 0)
end

---------------------------------------------------------------------------
-- What is known
---------------------------------------------------------------------------

local function now() return time and time() or 0 end

-- Per account: PolestarDB.update = { firstRun, since = { version, at },
-- peer, peerAt, snooze, shown, shownAt, helloAt, replyAt }.
function U.State()
	local db = ns.DB()
	local s = db.update
	if type(s) ~= "table" then
		s = {}
		db.update = s
	end
	return s
end
local state = U.State

-- When this version was first run on this account (a lower bound on its age).
local function since()
	local s = state()
	local v = tostring(ns.version or "")
	if type(s.since) ~= "table" or s.since.version ~= v then s.since = { version = v, at = now() } end
	return s.since
end

-- PolestarClientInfo (ClientInfo.lua, written by Polestar Client), checked:
-- { latest, released, checked, releases } with release versions only; nil
-- without the Client.
function U.ClientInfo()
	local c = PolestarClientInfo
	if type(c) ~= "table" then return nil end
	local list = {}
	if type(c.releases) == "table" then
		for _, v in ipairs(c.releases) do
			if U.Release(v) then list[#list + 1] = v end
		end
	end
	return {
		latest = U.Release(c.latest) and c.latest or nil,
		released = tonumber(c.released),
		checked = tonumber(c.checked),
		releases = list,
	}
end

-- The newest release known that is newer than ours, how many releases we
-- are behind it, and where it came from. nil when none is known.
function U.Latest()
	local m = mine()
	if not m then return nil end
	local best, behind, from
	local c = U.ClientInfo()
	if c and c.latest and newer(c.latest, m) then
		best, from, behind = c.latest, "client", 0
		for _, v in ipairs(c.releases) do
			if newer(v, m) then behind = behind + 1 end
		end
		if behind == 0 then behind = U.Estimate(c.latest, m) end
	end
	local s = state()
	local p, at = s.peer, tonumber(s.peerAt) or 0
	if p and newer(p, m) and plausible(p) and now() - at < U.PEER_DAYS * DAY then
		-- The Client looked after that player was heard: its answer stands.
		local overruled = c and c.latest and c.checked and c.checked > at and newer(p, c.latest)
		if not overruled and (not best or newer(p, best)) then
			behind = best and (behind + U.Estimate(p, best)) or U.Estimate(p, m)
			best, from = p, "peer"
		end
	end
	if not best then return nil end
	return best, max(1, behind), from
end

-- The Client checked lately and found nothing newer than ours.
function U.Confirmed()
	local c, m = U.ClientInfo(), mine()
	return c ~= nil and m ~= nil and c.latest ~= nil and c.checked ~= nil and now() - c.checked < U.CLIENT_FRESH
		and not newer(c.latest, m)
end

-- Whether Polestar Client is installed (it wrote ClientInfo.lua).
function U.HasClient()
	return U.ClientInfo() ~= nil
end

-- What there is to say: a newer release ({ kind = "behind", latest, behind,
-- mine, from }), or with nothing known and nothing confirmed, a build first
-- run OLD_DAYS or more ago ({ kind = "old", weeks }); nil otherwise.
function U.Notice()
	local m = mine()
	if not m then return nil end
	local latest, behind, from = U.Latest()
	if latest then return { kind = "behind", latest = latest, behind = behind, mine = m, from = from } end
	if U.Confirmed() then return nil end
	local days = (now() - since().at) / DAY
	if days >= U.OLD_DAYS then return { kind = "old", weeks = floor(days / 7) } end
	return nil
end

-- A peer's Polestar version. -> true when it counts (UPDATE_KNOWN fires
-- when it is newer than what was known).
function U.NotePeer(v)
	local m = mine()
	if not (m and U.Release(v) and newer(v, m) and plausible(v)) then return false end
	local before = U.Latest()
	local s = state()
	local t = now()
	local fresh = s.peer and t - (tonumber(s.peerAt) or 0) < U.PEER_DAYS * DAY
	if not fresh or newer(v, s.peer) then
		s.peer, s.peerAt = v, t
	elseif U.Compare(v, s.peer) == 0 then
		s.peerAt = t
	end
	local after = U.Latest()
	if after and (not before or newer(after, before)) and ns.Fire then ns.Fire("UPDATE_KNOWN", after) end
	return true
end

---------------------------------------------------------------------------
-- What the card has said
---------------------------------------------------------------------------

-- The card has shown for version v (or a newer one) on this account.
function U.Told(v)
	local s = state()
	return s.shown ~= nil and U.Compare(s.shown, v) ~= nil and U.Compare(s.shown, v) >= 0
end

-- Whether the card says (or has said) that version v is out, so a party
-- member's chat line need not: told already, or due to show this session.
-- Without the card (no guide window) it is false.
function U.Covers(v)
	if not newer(v, mine()) then return false end
	if U.Told(v) then return true end
	local UC = ns.UI and ns.UI.UpdateCard
	local latest = U.Latest()
	return UC ~= nil and UC.Wanted ~= nil and latest ~= nil and not newer(v, latest) and UC.Wanted() or false
end

-- "Got it": the card waits SNOOZE seconds.
U.SNOOZE = DAY
function U.Snooze()
	state().snooze = now() + U.SNOOZE
end

function U.Snoozed()
	return (tonumber(state().snooze) or 0) > now()
end

-- The card went on screen for version v.
function U.MarkShown(v)
	local s = state()
	s.shown, s.shownAt = v, now()
end

-- Seconds since the card last showed (huge when never).
function U.SinceShown()
	local at = tonumber(state().shownAt)
	return at and now() - at or math.huge
end

-- Seconds since this account first ran Polestar (huge for an account from
-- before this was kept).
function U.SinceFirstRun()
	return now() - (tonumber(state().firstRun) or 0)
end

---------------------------------------------------------------------------
-- The report window (UI/Report.lua)
---------------------------------------------------------------------------

-- " (outdated: latest 0.3.7)" after the version, or "".
function U.Outdated()
	local latest = U.Latest()
	return latest and (" " .. ns.L["(outdated: latest %s)"]:format(latest)) or ""
end

-- The line at the top of the report window when a newer release is known.
function U.ReportNote()
	if not U.Latest() then return nil end
	return ns.L["You're on an old Polestar (%s): please update first, your problem may already be fixed."]:format(mine())
end

-- The release notes' page for version v (nil: the newest release's).
function U.ReleaseURL(v)
	local base = "https://github.com/fitzforge/polestar/releases"
	return v and (base .. "/tag/v" .. v) or (base .. "/latest")
end

---------------------------------------------------------------------------
-- The guild hello and the version probe
---------------------------------------------------------------------------

-- Both send only while party sharing is on, from a release build.
local function sendingOn()
	local v = mine()
	return v ~= nil and U.Release(v) and ns.Get("party.share") and C_ChatInfo ~= nil and C_ChatInfo.SendAddonMessage ~= nil and true or false
end

local function guildOn()
	return sendingOn() and IsInGuild and IsInGuild() and true or false
end

local function lockdown()
	local C = C_ChatInfo
	if not (C and C.InChatMessagingLockdown) then return false end
	local ok, locked = pcall(C.InChatMessagingLockdown)
	return ok and locked == true
end

-- Our prefix, registered once (Quests/Party.lua registers it in a group).
local function prefix()
	local C = C_ChatInfo
	if C and C.IsAddonMessagePrefixRegistered and not C.IsAddonMessagePrefixRegistered(U.PREFIX) and C.RegisterAddonMessagePrefix then
		C.RegisterAddonMessagePrefix(U.PREFIX)
	end
end

-- Sends text; a refusal (a throttle, a lockdown, a trial account, an
-- offline target: any result but Success) is skipped quietly.
local function sendTo(text, chatType, target)
	prefix()
	local ok, r = pcall(C_ChatInfo.SendAddonMessage, U.PREFIX, text, chatType, target)
	local success = Enum and Enum.SendAddonMessageResult and Enum.SendAddonMessageResult.Success or 0
	return ok and (r == nil or r == true or r == success)
end

local function sendGuild(text)
	return sendTo(text, "GUILD")
end

-- One hello a login, a release's version only.
function U.Hello()
	U.Listen()
	local v = mine()
	if not (v and U.Release(v) and guildOn()) then return false end
	local s = state()
	if now() - (tonumber(s.helloAt) or 0) < U.HELLO_GAP then return false end
	s.helloAt = now()
	sendGuild("1H|" .. v)
	return true
end

-- The answer waiting to go out (a table, so a newer one replaces it).
local pending
function U.ReplyDelay() return 2 + math.random() * 10 end

local function answer(theirs)
	local v = mine()
	if pending or not (v and U.Release(v) and newer(v, theirs) and guildOn()) then return end
	local s = state()
	if now() - (tonumber(s.replyAt) or 0) < U.REPLY_GAP then return end
	local me = {}
	pending = me
	ns.After(U.ReplyDelay(), function()
		if pending ~= me then return end
		pending = nil
		if not guildOn() then return end
		state().replyAt = now()
		sendGuild("1Y|" .. v)
	end)
end

-- The version probe: Polestar can't tell that a player it sees runs
-- Polestar without asking, so it asks a few: a player of your faction you
-- target or mouse over (never from nameplates, which flood in crowds), not
-- in your group or guild (those hear the party sync and the guild hello),
-- while you are out of combat, outside instances, outside cities, inns and
-- other rest areas (IsResting) and outside the game's messaging lockdown,
-- gets one hidden addon whisper, "PSV1?<version>", to the unit's own name
-- as the game's Whisper writes it (Compat.UnitFullName: "Ana Smith" with the
-- client's surname separator). The client's whisper check
-- (RequestCanLocalWhisperTarget) answers first where it exists: only a
-- player it says can be whispered gets it, so no "not found" line shows.
-- Their Polestar answers "PSV1=<version>" over a whisper, after a moment,
-- once per sender per ANSWER_GAP and ANSWER_SESSION a session, never to its
-- own echo; a "=" is never answered. An answer counts only over a whisper
-- from a player probed in the last ASK_WAIT seconds (by Compat.SenderName),
-- once: one answer per probe. Older Polestars don't answer whispers, so
-- silence means nothing.
-- Messages are read only as ^PSV1([?=])x.y.z$, at most PROBE_BYTES bytes,
-- major <= 99, minor and patch <= 999; anything else is dropped. A newer
-- release heard only this way needs two different players' answers before
-- it counts (Update.NoteWhisper; at most HEARD_KEEP players kept): the
-- second-highest of their versions is the one passed on (NotePeer).
-- Limits: one probe per player per PROBE_AGAIN (PolestarDB.update.probed,
-- at most PROBE_KEEP players), one per PROBE_GAP seconds, PROBE_SESSION a
-- session. Once the session's probes are spent or a newer release is known,
-- the unit events are unregistered (until the next login); while they are
-- registered, a mouseover inside PROBE_GAP returns at the first comparison.
-- Off, no probes and no answers: party sharing off, update.probe off, or
-- the kill switch PolestarClientInfo.probe = false (Polestar Client writes
-- it when the newest release's notes carry "<!-- polestar: probe off -->").
U.PROBE_GAP = 30
U.PROBE_SESSION = 10
U.PROBE_AGAIN = 7 * DAY
U.PROBE_KEEP = 300
U.PROBE_BYTES = 24
U.ASK_WAIT = 60 -- seconds an answer to a probe is accepted
U.ANSWER_GAP = 60 -- seconds between two answers to one sender
U.ANSWER_SESSION = 20 -- answers a session at most
U.HEARD_KEEP = 50
U.CHECK_WAIT = 30 -- seconds a whisper check's answer is waited for
local TAG = "PSV1"
local probe = { sent = 0, at = -math.huge, waiting = {}, asked = {}, answered = {}, answers = 0 }

-- Probes and their answers may go out: sharing on, from a release build,
-- update.probe on, and no kill switch from Polestar Client.
local function probeOn()
	local c = PolestarClientInfo
	return sendingOn() and ns.Get("update.probe") and not (type(c) == "table" and c.probe == false) and true or false
end

-- "PSV1?0.3.7" -> "?", "0.3.7"; nil for anything else.
function U.ParseProbe(text)
	if type(text) ~= "string" or #text > U.PROBE_BYTES then return nil end
	local kind, a, b, c = text:match("^PSV1([%?=])(%d+)%.(%d+)%.(%d+)$")
	if not kind then return nil end
	a, b, c = tonumber(a), tonumber(b), tonumber(c)
	if a > 99 or b > 999 or c > 999 then return nil end
	return kind, a .. "." .. b .. "." .. c
end

-- Drops entries of `list` (key -> time, or { at = time }) older than `ttl`,
-- then the oldest while more than `keep` are left.
local function prune(list, t, ttl, keep)
	local n = 0
	for k, e in pairs(list) do
		local at = type(e) == "table" and e.at or e
		if t - (tonumber(at) or 0) >= ttl then list[k] = nil else n = n + 1 end
	end
	while n > keep do
		local oldest, oldestAt = nil, math.huge
		for k, e in pairs(list) do
			local at = tonumber(type(e) == "table" and e.at or e) or 0
			if at < oldestAt then oldest, oldestAt = k, at end
		end
		list[oldest] = nil
		n = n - 1
	end
end

-- Whether a probe may go out now. The unit events are registered only while
-- probing is on and a probe is left (U.Listen), so this checks the moment:
-- the gap first, one comparison, as the mouseover event fires often.
local function probeDue()
	if GetTime() - probe.at < U.PROBE_GAP or probe.sent >= U.PROBE_SESSION then return false end
	local C = ns.Compat
	return not (C.InCombat() or C.IsInInstance() or lockdown() or (IsResting and IsResting()))
end

local function readable(v)
	if ns.Compat.IsSecret(v) then return nil end
	return v
end

-- A player to probe at `unit`: their whisper name and GUID, or nil.
function U.ProbeTarget(unit)
	if type(unit) ~= "string" or not (UnitIsPlayer and UnitFactionGroup) then return nil end
	if readable(UnitIsPlayer(unit)) ~= true then return nil end
	if UnitIsUnit and readable(UnitIsUnit(unit, "player")) ~= false then return nil end
	local theirs, ours = readable(UnitFactionGroup(unit)), readable(UnitFactionGroup("player"))
	if type(theirs) ~= "string" or theirs ~= ours then return nil end
	-- In your group (UnitInRaid gives an index) or guild: those hear the rest.
	for _, fn in ipairs({ UnitInParty or false, UnitInRaid or false, UnitIsInMyGuild or false }) do
		if fn then
			local v = fn(unit)
			if ns.Compat.IsSecret(v) or v then return nil end
		end
	end
	local name = ns.Compat.UnitFullName(unit)
	if type(name) ~= "string" then return nil end
	local guid = UnitGUID and readable(UnitGUID(unit))
	return name, type(guid) == "string" and guid or nil
end

-- The players probed: name -> when; the oldest go past PROBE_KEEP.
local function probed()
	local s = state()
	if type(s.probed) ~= "table" then s.probed = {} end
	return s.probed
end

local function remember(name)
	local list = probed()
	list[name] = now()
	prune(list, now(), U.PROBE_AGAIN, U.PROBE_KEEP)
end

-- A newer release a player answered a probe with: kept per player
-- (PolestarDB.update.heard, HEARD_KEEP at most, PEER_DAYS long); once two
-- players have answered with newer releases, the lower of the two highest is
-- told as a peer's version. -> true when it counts
function U.NoteWhisper(name, v)
	local m = mine()
	if not (m and type(name) == "string" and U.Release(v) and newer(v, m) and plausible(v)) then return false end
	local s = state()
	if type(s.heard) ~= "table" then s.heard = {} end
	s.heard[name] = { v = v, at = now() }
	prune(s.heard, now(), U.PEER_DAYS * DAY, U.HEARD_KEEP)
	local list = {}
	for _, e in pairs(s.heard) do
		if type(e) == "table" and U.Release(e.v) and newer(e.v, m) and plausible(e.v) then list[#list + 1] = e.v end
	end
	if #list < 2 then return false end
	table.sort(list, function(a, b) return newer(a, b) end)
	return U.NotePeer(list[2])
end

local function whisperProbe(target)
	if not probeOn() or lockdown() then return false end
	local key = ns.Compat.SenderName(target)
	if key then
		probe.asked[key] = GetTime()
		prune(probe.asked, GetTime(), U.ASK_WAIT, U.HEARD_KEEP)
	end
	return sendTo(TAG .. "?" .. mine(), "WHISPER", target)
end

-- Probe the player at `unit` when everything allows. -> true when asked
function U.Probe(unit)
	if not probeDue() then return false end
	local target, guid = U.ProbeTarget(unit)
	if not target then return false end
	if now() - (tonumber(probed()[target]) or 0) < U.PROBE_AGAIN then return false end
	remember(target)
	probe.sent, probe.at = probe.sent + 1, GetTime()
	local C = C_ChatInfo
	if guid and C.RequestCanLocalWhisperTarget then
		probe.waiting[guid] = { target = target, at = GetTime() }
		pcall(C.RequestCanLocalWhisperTarget, guid)
	else
		whisperProbe(target)
	end
	if probe.sent >= U.PROBE_SESSION then U.Listen() end
	return true
end

local function onWhisperCheck(_, guid, status)
	local w = type(guid) == "string" and probe.waiting[guid]
	if not w then return end
	probe.waiting[guid] = nil
	local can = Enum and Enum.ChatWhisperTargetStatus and Enum.ChatWhisperTargetStatus.CanWhisper or 0
	if status == can and GetTime() - w.at <= U.CHECK_WAIT then whisperProbe(w.target) end
end

-- Answers a probe after a moment, to the sender as it came.
function U.AnswerDelay() return 0.5 + math.random() * 2 end

local function answerProbe(sender, key)
	if probe.answers >= U.ANSWER_SESSION or not probeOn() then return end
	if GetTime() - (probe.answered[key] or -math.huge) < U.ANSWER_GAP then return end
	probe.answered[key] = GetTime()
	probe.answers = probe.answers + 1
	prune(probe.answered, GetTime(), U.ANSWER_GAP, U.HEARD_KEEP)
	ns.After(U.AnswerDelay(), function()
		if probeOn() and not lockdown() then sendTo(TAG .. "=" .. mine(), "WHISPER", sender) end
	end)
end

-- Whispers on our prefix: probes and their answers only (Party.lua reads
-- the party channel alone).
local function onWhisper(_, prefixIn, text, channel, sender)
	local C = ns.Compat
	if C.IsSecret(prefixIn) or C.IsSecret(channel) or C.IsSecret(text) or C.IsSecret(sender) then return end
	if prefixIn ~= U.PREFIX or channel ~= "WHISPER" or type(sender) ~= "string" then return end
	local kind, v = U.ParseProbe(text)
	if not kind or C.SenderIsMe(sender) then return end
	local key = C.SenderName(sender)
	if not key then return end
	if kind == "?" then
		answerProbe(sender, key)
	else
		local at = probe.asked[key]
		if not at or GetTime() - at > U.ASK_WAIT then return end
		probe.asked[key] = nil
		U.NoteWhisper(key, v)
	end
end

-- The guild hello and its answers.
local function onGuild(_, prefixIn, text, channel, sender)
	local C = ns.Compat
	if C.IsSecret(prefixIn) or C.IsSecret(channel) or C.IsSecret(text) or C.IsSecret(sender) then return end
	if prefixIn ~= U.PREFIX or channel ~= "GUILD" or type(text) ~= "string" or type(sender) ~= "string" then return end
	if C.SenderIsMe(sender) then return end
	local mark, v = text:match("^1([HY])|([^|]*)$")
	if not mark then return end
	U.NotePeer(v)
	if mark == "H" then
		answer(v)
	elseif pending and U.Compare(v, mine()) ~= nil and U.Compare(v, mine()) >= 0 then
		-- Someone answered with ours or newer: ours would say nothing more.
		pending = nil
	end
end

local function probeTarget() U.Probe("target") end
local function probeMouseover() U.Probe("mouseover") end

-- What Polestar listens to, checked at login, at the hello, when the guild,
-- party sharing, update.probe or what is known changes, and as the
-- session's probes run out: the guild channel in a guild; whispers while
-- probing is on (probes and their answers); our prefix with either; the
-- target and mouseover while probing is on, a probe is left and no newer
-- release is known. Solo with sharing off, nothing.
local inGuild, whispers, probing = false, false, false
function U.Listen()
	local guild = IsInGuild and IsInGuild() and true or false
	if guild ~= inGuild then
		inGuild = guild
		local set = guild and ns.RegisterEvent or ns.UnregisterEvent
		set("CHAT_MSG_ADDON", onGuild)
	end
	local on = probeOn()
	if on ~= whispers then
		whispers = on
		local set = on and ns.RegisterEvent or ns.UnregisterEvent
		set("CHAT_MSG_ADDON", onWhisper)
	end
	if guild or on then prefix() end
	local wantProbe = on and probe.sent < U.PROBE_SESSION and U.Latest() == nil
	if wantProbe ~= probing then
		probing = wantProbe
		local set = wantProbe and ns.RegisterEvent or ns.UnregisterEvent
		set("PLAYER_TARGET_CHANGED", probeTarget)
		set("UPDATE_MOUSEOVER_UNIT", probeMouseover)
	end
end

-- Whether the target and mouseover events are registered (tests).
function U.Probing() return probing end

---------------------------------------------------------------------------
-- Lifecycle
---------------------------------------------------------------------------

ns.OnInit(function()
	local s = state()
	-- A fresh install starts its two quiet minutes now; an account from
	-- before this was kept has had Polestar long enough.
	if s.firstRun == nil then s.firstRun = ns.IsNewAccount() and now() or 0 end
	since()
end)

ns.OnLogin(function()
	U.Listen()
	ns.After(U.HELLO_DELAY, U.Hello)
end)

ns.RegisterEvent("PLAYER_GUILD_UPDATE", function() U.Listen() end)
ns.On("SETTING_CHANGED", function(path)
	if path == "party.share" or path == "party" or path == "update.probe" or path == "update" then U.Listen() end
end)
ns.On("UPDATE_KNOWN", function() U.Listen() end)
-- The whisper check asked for the session's last probe still answers after
-- the unit events stop.
ns.RegisterEvent("CAN_LOCAL_WHISPER_TARGET_RESPONSE", onWhisperCheck)

ns.RegisterCommand("update", function()
	local UC = ns.UI and ns.UI.UpdateCard
	if UC and UC.Show(true) then return end
	local L = ns.L
	if U.Confirmed() then
		ns.Print(L["Polestar %s is the newest release."]:format(tostring(ns.version)))
	else
		ns.Print(L["No newer Polestar is known. Polestar Client, the CurseForge app or the releases page say for sure."])
	end
end, ns.L["Show the update card when a newer Polestar is out"])
