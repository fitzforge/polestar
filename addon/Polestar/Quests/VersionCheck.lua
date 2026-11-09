-- Version check: Polestar says its version to the guild and the raid in a
-- hidden addon message, and when a guildmate or group member runs a newer
-- release, one quiet chat line a session says so (setting version.notice,
-- on by default; Questing > Quests > Group).
--
-- Messages: Party.lua's hello under its prefix ("Polestar"). "1H|<version>"
-- announces it, sent ANNOUNCE_DELAY s after login (once the guild is known)
-- and JOIN_DELAY s after joining a guild or a raid; "1Y|<version>" answers an
-- announce from an older release. The version is all that goes out. In a
-- party, Party.lua's own hello, its answer and its "1P|" position carry the
-- version already: they feed the same notice (VersionCheck.Heard), and
-- nothing more goes to the party. Party.lua reads the PARTY channel only,
-- so older clients drop these on the guild and raid channels.
--
-- Only release versions count, "<major>.<minor>.<patch>" with at most 4
-- digits each (VersionCheck.IsRelease): a dev ("dev"), test ("0.2.5-test.1")
-- or candidate ("0.3.0-rc.1") build announces nothing, answers nothing and
-- is never told; a message that is not a release version is dropped.
--
-- Rate: one announce per channel until the player leaves it (a refused one
-- is tried again RETRY s later, up to TRIES times). An answer, only to an
-- announce older than ours, waits a random REPLY_DELAY_MIN-MAX s and is
-- skipped when another player's message on that channel carried our version
-- or a newer one meanwhile; at most one per REPLY_EVERY s a channel. No raid
-- messages in a battleground or arena. Nothing goes to chat but the notice.

local _, ns = ...

local VersionCheck = {}
ns.VersionCheck = VersionCheck

local P = ns.Party
local L = ns.L

ns.RegisterDefaults("version", { notice = true })

local ANNOUNCE_DELAY = 15 -- s after login: the guild's chat channel is up by then
local JOIN_DELAY = 5 -- s after joining a guild or a raid
local RETRY, TRIES = 30, 3
local REPLY_EVERY = 300 -- s: at most one answer a channel this often
local REPLY_DELAY_MIN, REPLY_DELAY_MAX = 2, 12
VersionCheck.REPLY_EVERY = REPLY_EVERY -- tests

local told = false -- the notice was said this session
local state = {} -- chat type -> "pending" (an announce on its way) | "sent" (until the channel is left)
local pending = {} -- chat type -> true (an answer waits) | "covered" (someone else answered)
local lastReply = {} -- chat type -> GetTime() of our last answer

-- Whether v is a release version: "0.3.7", never "dev", "0.3.0-rc.1" or "1.0".
function VersionCheck.IsRelease(v)
	if type(v) ~= "string" or #v > 14 then return false end
	local a, b, c = v:match("^(%d+)%.(%d+)%.(%d+)$")
	return a ~= nil and #a <= 4 and #b <= 4 and #c <= 4
end

local function mine()
	local v = ns.version
	return VersionCheck.IsRelease(v) and v or nil
end

-- A player runs Polestar `v`: when it is a release newer than ours, the
-- notice, once a session (with version.notice on). -> true when said.
function VersionCheck.Heard(v)
	local own = mine()
	if told or not own or not VersionCheck.IsRelease(v) or not P.Newer(v, own) or not ns.Get("version.notice") then return false end
	told = true
	ns.Print(L["A newer Polestar (%s) is out: update with the Polestar Client, the CurseForge app or the zip."]:format(v))
	return true
end

local function inPvp()
	if not IsInInstance then return false end
	local inside, kind = IsInInstance()
	return inside and (kind == "pvp" or kind == "arena") or false
end

local function open(chatType)
	if chatType == "GUILD" then return IsInGuild and IsInGuild() and true or false end
	if chatType == "RAID" then return IsInRaid and IsInRaid() and not inPvp() and true or false end
	return false
end

-- True when the client took it.
local function send(text, chatType)
	local fn = C_ChatInfo and C_ChatInfo.SendAddonMessage
	if not fn then return false end
	local ok, r = pcall(fn, P.PREFIX, text, chatType)
	local results = Enum and Enum.SendAddonMessageResult
	return ok and r ~= false and not (type(r) == "number" and r ~= (results and results.Success or 0))
end

local function announce(chatType, tries)
	if not (open(chatType) and mine()) then
		state[chatType] = nil
	elseif send(P.EncodeHello(false), chatType) or tries >= TRIES or not C_Timer then
		state[chatType] = "sent"
	else
		ns.After(RETRY, function() announce(chatType, tries + 1) end)
	end
end

local function schedule(chatType, delay)
	if state[chatType] or not mine() or not C_Timer then return end
	state[chatType] = "pending"
	ns.After(delay, function() announce(chatType, 1) end)
end

-- Joined: announce; left: announce again on the next join.
local function changed(chatType)
	if open(chatType) then
		schedule(chatType, JOIN_DELAY)
	elseif state[chatType] == "sent" then
		state[chatType] = nil
	end
end

local function reply(chatType)
	local p = pending[chatType]
	pending[chatType] = nil
	if p ~= true or not (open(chatType) and mine()) then return end
	if send(P.EncodeHello(true), chatType) then lastReply[chatType] = GetTime() end
end

local ACCEPTED = { GUILD = true, RAID = true, PARTY = true }

local function onAddonMessage(_, prefix, text, chatType, sender)
	local C = ns.Compat
	if C.IsSecret(prefix) or C.IsSecret(chatType) or C.IsSecret(text) or C.IsSecret(sender) then return end
	if prefix ~= P.PREFIX or not ACCEPTED[chatType] or type(sender) ~= "string" or C.SenderIsMe(sender) then return end
	local mark, v = P.DecodeHello(text)
	if not mark or not VersionCheck.IsRelease(v) then return end
	VersionCheck.Heard(v)
	-- The party's hello is Party.lua's to answer.
	local own = mine()
	if chatType == "PARTY" or not own then return end
	local behind = P.Newer(own, v)
	if pending[chatType] then
		if not behind then pending[chatType] = "covered" end
	elseif mark == "H" and behind and open(chatType) and GetTime() - (lastReply[chatType] or -math.huge) >= REPLY_EVERY then
		pending[chatType] = true
		if C_Timer then
			ns.After(REPLY_DELAY_MIN + math.random() * (REPLY_DELAY_MAX - REPLY_DELAY_MIN), function() reply(chatType) end)
		else
			reply(chatType)
		end
	end
end

ns.RegisterEvent("CHAT_MSG_ADDON", onAddonMessage)
ns.RegisterEvent("PLAYER_GUILD_UPDATE", function() changed("GUILD") end)
ns.RegisterEvent("GROUP_ROSTER_UPDATE", function() changed("RAID") end)

ns.OnLogin(function()
	local C = C_ChatInfo
	if C and C.RegisterAddonMessagePrefix and not (C.IsAddonMessagePrefixRegistered and C.IsAddonMessagePrefixRegistered(P.PREFIX)) then
		pcall(C.RegisterAddonMessagePrefix, P.PREFIX)
	end
	-- At login the client may not know the guild yet: the announce looks
	-- when it is due, and PLAYER_GUILD_UPDATE catches a later answer.
	schedule("GUILD", ANNOUNCE_DELAY)
	schedule("RAID", ANNOUNCE_DELAY)
end)

---------------------------------------------------------------------------
-- Options
---------------------------------------------------------------------------

local registered = false
local function register()
	if registered or not ns.RegisterOptions then return end
	registered = true
	ns.RegisterOptions({
		page = L["Questing"], tab = L["Quests"], section = L["Group"],
		controls = {
			{ kind = "toggle", key = "version.notice", label = L["Tell me when a newer Polestar is out"],
				search = "group, guild, party, raid, version, update, newer",
				help = L["Polestar tells your guild and your group which version you run, and nothing else. When one of them runs a newer release, one line in chat says so, once a session."] },
		},
	})
end
ns.OnInit(register)
ns.OnLogin(register)
