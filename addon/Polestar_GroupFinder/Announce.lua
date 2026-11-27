-- Polestar Group Finder: announcing your search in public chat, for the
-- players who do not run the finder.
--
-- One short line such as "LFG Thandol Span, whisper me!" said in the zone's
-- General channel (the default), the looking-for-group channel, /say or
-- /yell. It only ever goes out from a click, a key press or a slash command:
-- the game requires a hardware event to speak in a channel, and the finder
-- never speaks for you on its own. The line is the "announce" message
-- (Messages.lua: English by default, edited in the Messages window), its
-- {quests} the client's own quest links when it gives them (each reader
-- sees them in their language), else the titles.

local _, ns = ...
local L = ns.L

local Announce = {}
ns.Announce = Announce

local GAP = 60        -- seconds between two announces
local MAX_QUESTS = 3  -- quests named in one line

-- Where the line goes. CHANNEL targets are found by name among the joined
-- channels (names differ by client language).
Announce.TARGETS = { "GENERAL", "LFG", "SAY", "YELL" }
local CHANNEL_NAMES = {
	GENERAL = { "general", "général", "allgemein", "generale", "geral", "общий", "일반", "综合", "綜合" },
	LFG = { "lookingforgroup", "recherchedegroupe", "suchenachgruppe", "buscargrupo", "cercagruppo",
		"procurargrupo", "поискспутников", "파티찾기", "寻求组队", "尋求組隊" },
}

local last = -math.huge

function Announce.Target()
	local t = ns.Get("announceTo")
	for _, v in ipairs(Announce.TARGETS) do if v == t then return t end end
	return "GENERAL"
end

Announce.GAP = GAP
function Announce.Cooldown()
	return math.max(0, GAP - (ns.Now() - last))
end

local function normalize(name)
	-- "General - Elwynn Forest" -> "general"; "Looking For Group" -> "lookingforgroup"
	name = tostring(name):gsub("%s+%-%s+.*$", "")
	return (name:lower():gsub("%s+", ""))
end

-- The id of a joined channel whose name is one of `names`, or nil.
local function findChannel(names)
	if not GetChannelList then return nil end
	local list = { GetChannelList() }
	for i = 1, #list - 1 do
		local id, name = list[i], list[i + 1]
		if type(id) == "number" and type(name) == "string" then
			local n = normalize(name)
			for _, want in ipairs(names) do
				if n == want then return id end
			end
		end
	end
	return nil
end

-- chatType, channel id for `target`; nil plus why when it cannot be used.
function Announce.Resolve(target)
	if target == "SAY" or target == "YELL" then return target end
	local id = findChannel(CHANNEL_NAMES[target] or {})
	if not id and target == "GENERAL" and GetChannelName then
		-- General is the first channel the game joins.
		local first = ns.Readable(GetChannelName(1))
		if type(first) == "number" and first > 0 then id = first end
	end
	if not id then return nil, target == "LFG" and L["The looking-for-group channel is not joined (join it in the chat options)."] or L["The General channel is not joined here."] end
	return "CHANNEL", id
end

-- The quests to name: those of the search in progress, else the relevant
-- ones of the log; `id` names one quest only (the quest panel).
function Announce.Quests(id)
	if id then return { tonumber(id) } end
	local out = {}
	local list = ns.Session.Active() and ns.Session.List() or ns.Quests.Relevant()
	for i = 1, math.min(#list, MAX_QUESTS) do out[i] = list[i].id end
	return out
end

-- The line for `ids`; nil when there is no quest or the message is off.
function Announce.Text(ids)
	if not ids or #ids == 0 or not ns.Messages.On("announce") then return nil end
	return ns.Messages.Expand("announce", ids)
end

-- From a click, a key press or a slash command only. `id`: one quest.
function Announce.Send(id)
	if not ns.Get("enabled") then ns.Print(L["The group finder is off. Turn it on in its panel or in Polestar's settings."]) return false end
	if IsInInstance and IsInInstance() then ns.Print(L["Searching is off inside an instance."]) return false end
	local wait = Announce.Cooldown()
	if wait > 0 then ns.Debug(L["Wait %d s before announcing again."], math.ceil(wait)) return false end
	if not ns.Messages.On("announce") then ns.Print(L["The announce message is turned off or empty: see Messages."]) return false end
	local text = Announce.Text(Announce.Quests(id))
	if not text then ns.Print(L["No quest to search for: kill, named, loot or group quests in progress."]) return false end
	local chatType, target = Announce.Resolve(Announce.Target())
	if not chatType then ns.Print(target) return false end
	if not ns.SendChat(text, chatType, target) then return false end
	last = ns.Now()
	ns.Fire("ANNOUNCED", text, chatType)
	return true
end

local TARGET_NAMES = { GENERAL = L["General (zone)"], LFG = L["Looking for group"], SAY = L["Say"], YELL = L["Yell"] }
function Announce.TargetName(target)
	return TARGET_NAMES[target] or target
end
