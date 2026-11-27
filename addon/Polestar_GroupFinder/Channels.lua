-- Polestar Group Finder: which channels carry our messages, and sending
-- on them.
--
-- Searches go on CHANNEL only: the hidden PSGroupFinder channel that every
-- player running the finder joins. WHISPER carries the answers and the
-- updates to the players found. No SAY or YELL (Forever's client refuses
-- addon messages there) and no GUILD (the finder talks to the players who
-- run it, wherever their guild). Channels.status says what the channel did:
-- "ok" (our message came back), "sent" (the client took it, no echo yet),
-- "fail" (refused, with the code) or "skip" (not joined yet). Nothing is sent to test them unless the player asks
-- (Channels.Test: the Test button, /polestar finder test); the first search tells too.

local _, ns = ...
local L = ns.L
local Throttle = ns.Throttle
local Protocol = ns.Protocol

local Channels = {}
ns.Channels = Channels

Channels.NAME = "PSGroupFinder"
Channels.ORDER = { "CHANNEL" }
Channels.status = {} -- chatType -> { state, code, at }

local PROBE_WAIT = 4   -- seconds to wait for a probe's echo
local JOIN_DELAY = 6   -- seconds after login before joining (keeps /1, /2 for the game's)
local MAX_WHISPERS = 8 -- players told by whisper when a search changes
local prefixReady = false

function Channels.SetStatus(chatType, state, code)
	local old = Channels.status[chatType]
	-- An echo is proof: a later "sent" does not take it back.
	if old and old.state == "ok" and state == "sent" then return end
	Channels.status[chatType] = { state = state, code = code, at = ns.Now() }
	ns.Fire("CHANNELS")
end

function Channels.RegisterPrefix()
	if prefixReady or not (C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix) then return end
	prefixReady = pcall(C_ChatInfo.RegisterAddonMessagePrefix, Protocol.PREFIX)
end

---------------------------------------------------------------------------
-- The hidden channel
---------------------------------------------------------------------------

function Channels.ChannelId()
	if not GetChannelName then return nil end
	local id = ns.Readable(GetChannelName(Channels.NAME))
	return (type(id) == "number" and id > 0) and id or nil
end

local function hideChannel()
	if not ChatFrame_RemoveChannel then return end
	for i = 1, (NUM_CHAT_WINDOWS or 10) do
		local f = _G["ChatFrame" .. i]
		if f then pcall(ChatFrame_RemoveChannel, f, Channels.NAME) end
	end
end

function Channels.Join()
	if Channels.ChannelId() then hideChannel() return end
	local join = JoinTemporaryChannel or JoinChannelByName
	if join then pcall(join, Channels.NAME) end
	ns.After(1, hideChannel)
end

function Channels.Leave()
	if Channels.ChannelId() and LeaveChannelByName then pcall(LeaveChannelByName, Channels.NAME) end
end

---------------------------------------------------------------------------
-- Sending
---------------------------------------------------------------------------

-- The target argument for a chat type, or nil plus why it cannot be used.
local function targetFor(chatType)
	if chatType == "CHANNEL" then
		local id = Channels.ChannelId()
		if not id then return nil, L["channel not joined"] end
		return id
	end
	return false
end

local function trySend(chatType, text)
	local target, why = targetFor(chatType)
	if target == nil then
		Channels.SetStatus(chatType, "skip", why)
		return false
	end
	local ok, code = Throttle.SendNow(Protocol.PREFIX, text, chatType, target or nil)
	if ok then Channels.SetStatus(chatType, "sent") else Channels.SetStatus(chatType, "fail", Throttle.ResultName(code)) end
	ns.Debug("-> %s on %s: %s", text:sub(1, 1), chatType, ok and "ok" or Throttle.ResultName(code))
	return ok
end

-- The channel searches go out on, unless the client refused it.
function Channels.Best()
	local s = Channels.status.CHANNEL
	if s and s.state == "fail" then return nil end
	return "CHANNEL"
end

-- A search or a quest search, on the finder's channel. Returns the chat
-- types it went out on (empty when it could not).
function Channels.SendPublic(text)
	Channels.RegisterPrefix()
	return trySend("CHANNEL", text) and { "CHANNEL" } or {}
end

-- An update of your own search (a quest left it, or it ended): on the
-- channel, and by whisper to each player found.
function Channels.SendQuiet(text)
	Channels.RegisterPrefix()
	local sent = trySend("CHANNEL", text)
	local names = ns.Matcher.Names()
	for i = 1, math.min(#names, MAX_WHISPERS) do
		Channels.Whisper(text, names[i])
		sent = true
	end
	return sent
end

-- Through the queue: answers, group requests, updates.
function Channels.Whisper(text, name)
	Channels.RegisterPrefix()
	ns.Debug("-> %s whispered to %s", text:sub(1, 1), name)
	if ns.ChatFilter then ns.ChatFilter.NoteWhisper(name) end
	return Throttle.Send(Protocol.PREFIX, text, "WHISPER", name)
end

---------------------------------------------------------------------------
-- Channel test
---------------------------------------------------------------------------

-- Only when the player asks: the Test button or /polestar finder test.
local probing = false
function Channels.Test()
	if probing then return end
	if not ns.Get("enabled") then ns.Print(L["The group finder is off. Turn it on in its panel or in Polestar's settings."]) return end
	Channels.RegisterPrefix()
	probing = true
	local text = Protocol.Probe(string.format("%x", math.random(0, 0xfffff)))
	ns.Print(L["Testing the channels, results in %d s..."], PROBE_WAIT)
	for _, ct in ipairs(Channels.ORDER) do
		local s = Channels.status[ct]
		if s and s.state == "ok" then s.state = "sent" end -- prove it again
		trySend(ct, text)
	end
	ns.After(PROBE_WAIT, function()
		probing = false
		Channels.Report(true)
	end)
end

-- `verbose`: one chat line per channel and the one in use; otherwise only in
-- debug mode. The panel shows the colours either way.
function Channels.Report(verbose)
	local say = verbose and ns.Print or ns.Debug
	local any = false
	for _, ct in ipairs(Channels.ORDER) do
		local s = Channels.status[ct]
		if s then
			if s.state == "ok" then any = true end
			if s.state == "ok" then say(L["%s: works (message came back)."], ct)
			elseif s.state == "sent" then say(L["%s: accepted, no echo (unsure)."], ct)
			elseif s.state == "fail" then say(L["%s: refused (%s)."], ct, tostring(s.code))
			else say(L["%s: not available (%s)."], ct, tostring(s.code)) end
		end
	end
	local best = Channels.Best()
	if best then say(L["Search channel in use: %s."], best) elseif not any then say(L["No channel answered. Only whisper replies will work."]) end
	ns.Fire("CHANNELS")
end

ns.On("ENABLED", function(on)
	if on then
		Channels.RegisterPrefix()
		ns.After(JOIN_DELAY, function()
			if ns.Get("enabled") then Channels.Join() end
		end)
	else
		Channels.Leave()
		wipe(Channels.status)
		ns.Fire("CHANNELS")
	end
end)
