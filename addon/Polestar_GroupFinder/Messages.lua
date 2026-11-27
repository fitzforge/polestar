-- Polestar Group Finder: the messages the finder can say for you, each
-- with its own switch (on by default) and an editable text; an empty text
-- is never sent either.
--
--   announce said in public chat (General by default) on the Announce click
--   invite   whispered when you click Invite on a player (solo)
--   ask      whispered when you click Ask on a player already in a group
--            (you cannot invite them: you ask them to invite you)
--   hello    said in the party from the party box's Say hello button (or its
--            key binding), offered for a few seconds when a group formed
--            through the finder gets together
--   goodbye  said in the party just before leaving a group formed through
--            the finder: the party box's Goodbye & leave, the panel's Leave
--            button, the key binding
-- The defaults are in English for every client (the other players may read
-- any language); the player edits them freely. In a text:
--   {quests}   the quests concerned, as the client's quest links when they
--              name the right quest, else their titles
--   {progress} the same quests, each followed by what is left of it, as
--              counts: "[The Defias Brotherhood] 4/12 Defias Pillager slain",
--              "(done)" once nothing is left
-- Texts are kept without escape sequences; an empty text ("") turns the
-- message off. They are settings (groupFinder.helloMsg, ...): Options'
-- Group Finder page edits them, a reset puts the default back.

local _, ns = ...
local L = ns.L

local Messages = {}
ns.Messages = Messages

local MAX_LEN = 255
local MAX_QUESTS = 3

-- kind -> { setting holding the text, its switch } (groupFinder.<key>; the
-- default texts are the door's, Polestar/Quests/GroupFinder.lua)
Messages.KINDS = {
	announce = { text = "announceMsg", on = "announceOn" },
	invite = { text = "inviteMsg", on = "inviteOn" },
	ask = { text = "askMsg", on = "askOn" },
	hello = { text = "helloMsg", on = "helloOn" },
	goodbye = { text = "leaveMsg", on = "goodbyeOn" },
}
Messages.ORDER = { "announce", "invite", "ask", "hello", "goodbye" }

function Messages.Default(kind)
	return ns.P.GetDefault(ns.SECTION .. "." .. Messages.KINDS[kind].text)
end

-- The text to use: the player's own ("" when turned off), else the default.
function Messages.Template(kind)
	local m = ns.Get(Messages.KINDS[kind].text)
	if type(m) == "string" then return m end
	return Messages.Default(kind)
end

function Messages.Save(kind, text)
	text = tostring(text or ""):gsub("|", ""):gsub("^%s+", ""):gsub("%s+$", "")
	ns.Set(Messages.KINDS[kind].text, text)
end

-- The message's switch (on unless turned off), under the Messages page's
-- own (groupFinder.partyBox: the messages and the message box).
function Messages.Enabled(kind)
	return ns.Get("partyBox") ~= false and ns.Get(Messages.KINDS[kind].on) ~= false
end

function Messages.SetEnabled(kind, on)
	ns.Set(Messages.KINDS[kind].on, on and true or false)
end

-- Said at all: switched on, with a text.
function Messages.On(kind)
	return Messages.Enabled(kind) and Messages.Template(kind) ~= ""
end

-- A quest as written in chat: the client's link when it names this quest
-- (some clients take a log index, not an id), else the title.
function Messages.QuestText(id)
	if GetQuestLink then
		local ok, link = pcall(GetQuestLink, id)
		link = ok and ns.Readable(link)
		if type(link) == "string" and link:find("|Hquest:" .. id .. ":", 1, true) then return link end
	end
	return ns.Quests.Title(id)
end

-- "4/12 Defias Pillager slain" from an objective, whichever way the client
-- writes it ("Defias Pillager slain: 4/12" or "4/12 Defias Pillager slain");
-- the text as it is when it has no count.
-- An objective's words without its count: "Defias Pillager slain".
function Messages.ObjectiveLabel(o)
	local text = tostring(o and o.text or "")
	return (text:gsub("^%s*%d+%s*/%s*%d+%s*", ""):gsub("%s*:?%s*%d+%s*/%s*%d+%s*$", ""))
end

function Messages.ObjectiveText(o)
	local text = tostring(o.text or "")
	local label = Messages.ObjectiveLabel(o)
	local have, need = tonumber(o.have), tonumber(o.need)
	if not (have and need) then
		local h, n = text:match("(%d+)%s*/%s*(%d+)")
		have, need = tonumber(h), tonumber(n)
	end
	if have and need and need > 0 then
		return label ~= "" and (have .. "/" .. need .. " " .. label) or (have .. "/" .. need)
	end
	return text
end

-- What is left of quest `id`: its open objectives as "4/12 Defias Pillager
-- slain", joined by ", "; "(done)" once nothing is left; "" when unknown.
function Messages.Progress(id)
	local q = ns.Quests.Log()[id]
	if not q then return "" end
	if not ns.Quests.Pending(id) then return "(done)" end
	local parts = {}
	for _, o in ipairs(q.objectives or {}) do
		if not o.done then parts[#parts + 1] = Messages.ObjectiveText(o) end
	end
	return table.concat(parts, ", ")
end

-- The list for {quests} (", " between quests) or {progress} (each quest
-- followed by what is left of it, " / " between quests), at most `count`.
local function list(ids, count, withProgress)
	local names = {}
	for i = 1, math.min(#(ids or {}), count) do
		local name = Messages.QuestText(ids[i])
		if withProgress then
			local left = Messages.Progress(ids[i])
			if left ~= "" then name = name .. " " .. left end
		end
		names[i] = name
	end
	if #names == 0 then return L["this quest"] end
	return table.concat(names, withProgress and " / " or ", ")
end

-- `kind`'s text with {quests} and {progress} filled from `ids`, at most 255
-- bytes (quests dropped from the end until it fits). "" when the message is
-- turned off.
function Messages.Expand(kind, ids)
	return Messages.Fill(Messages.Template(kind), ids)
end

-- Any text `tpl` with {quests} and {progress} filled (the live preview).
function Messages.Fill(tpl, ids)
	tpl = tostring(tpl or ""):gsub("|", "")
	if tpl == "" then return "" end
	for count = math.min(#(ids or {}), MAX_QUESTS), 0, -1 do
		local text = tpl:gsub("{quests}", function() return list(ids, math.max(count, 1), false) end)
		text = text:gsub("{progress}", function() return list(ids, math.max(count, 1), true) end)
		if #text <= MAX_LEN or count <= 1 then return text:sub(1, MAX_LEN) end
	end
	return tpl:sub(1, MAX_LEN)
end

-- The quest a preview names when the log has none worth a group.
Messages.EXAMPLE = { quest = "Red Linen Goods", left = "0/6 Red Linen Bandana" }

-- The quests a preview uses: the group's, else your relevant ones.
function Messages.SampleIds()
	local ids = ns.Leave and ns.Leave.Quests() or {}
	if #ids > 0 then return ids end
	ids = {}
	for i, q in ipairs(ns.Quests.Relevant()) do
		if i > MAX_QUESTS then break end
		ids[#ids + 1] = q.id
	end
	return ids
end

-- Text `tpl` as it would be said now: with your quests, else with the
-- example quest. "" when the text is empty.
function Messages.Preview(tpl)
	local ids = Messages.SampleIds()
	if #ids > 0 then return Messages.Fill(tpl, ids) end
	tpl = tostring(tpl or ""):gsub("|", "")
	local q = "[" .. Messages.EXAMPLE.quest .. "]"
	return (tpl:gsub("{progress}", function() return q .. " " .. Messages.EXAMPLE.left end):gsub("{quests}", function() return q end))
end

-- PARTY, or INSTANCE_CHAT in an instance group.
function Messages.PartyChat()
	local instance = IsInGroup and LE_PARTY_CATEGORY_INSTANCE and IsInGroup(LE_PARTY_CATEGORY_INSTANCE)
	return instance and "INSTANCE_CHAT" or "PARTY"
end

local function send(text, chatType, target)
	return ns.SendChat(text, chatType, target)
end

function Messages.Whisper(kind, name, ids)
	if not Messages.On(kind) then return false end
	return send(Messages.Expand(kind, ids), "WHISPER", name)
end

function Messages.SayParty(kind, ids)
	if not ns.InGroup() or not Messages.On(kind) then return false end
	return send(Messages.Expand(kind, ids), Messages.PartyChat())
end
