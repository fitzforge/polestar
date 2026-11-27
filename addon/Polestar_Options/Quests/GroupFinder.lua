-- The Group Finder page (docs/ARCHITECTURE.md, "Group Finder"; Polestar/Quests/GroupFinder.lua and the folder
-- Polestar_GroupFinder): Essentials (the finder on or off, grouping, the search languages, its keys) and
-- Messages (the message box and its style, then each message: its switch, its key, its text). It never loads
-- the finder's folder: the languages come from the door, the message box's pictures are drawn here, and a
-- message's tooltip says it with your quests only when the folder is loaded. Part of the settings' addon:
-- nothing of it is in memory before the settings open.

local ns = Polestar
local L = ns.L
local GF = ns.GroupFinder

if not (GF and ns.RegisterOptions) then return end

local PAGE, KEY = L["Group Finder"], "groupfinder"
local ESSENTIALS, MESSAGES = L["Essentials"], L["Messages"]
local function key(k) return "groupFinder." .. k end

local function register(spec)
	spec.page, spec.key, spec.icon = PAGE, KEY, "icon-group"
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

local function toggle(k, label, help, extra)
	local c = { kind = "toggle", key = key(k), label = label, help = help, search = "group finder, lfg, party, players, quests" }
	for f, v in pairs(extra or {}) do c[f] = v end
	return c
end

local function boxOff() return ns.Get(key("partyBox")) == false end

---------------------------------------------------------------------------
-- Essentials
---------------------------------------------------------------------------

-- The finder's switch heads its card; the card folds while it is off.
register({ group = "guiding", order = 51, tab = ESSENTIALS, section = L["Group Finder"],
	toggle = { kind = "toggle", key = key("enabled"), label = L["Enable the group finder"], search = "group finder, lfg, party, players, quests",
		help = L["The group finder: players on your quests who run Polestar, found and grouped with by a click.\n\nOn: you can search, and the finder joins its hidden channel.\nOff: it sends nothing and answers no one.\n\nDefault: off.\n\nCommands: /polestar finder (the panel), search, stop, announce, test (checks the channel), debug."] },
	controls = {
		toggle("autoGroup", L["Group automatically (same quest)"], L["After your search, with a player who shares a quest with you. Both players need it on.\n\nOn: the finder invites them, or accepts their invitation, without a click.\nOff: you choose in the list (Whisper, Invite).\n\nDefault: off."]),
		toggle("autoReply", L["Let others find me when they search"], L["When another player searches for a quest you also have.\n\nOn: the finder answers them with a hidden whisper, without a click, so you appear on their list.\nOff: you only meet the players who search at the same time as you.\n\nDefault: off."]),
		toggle("shareCoords", L["Show others my distance"], L["Your position on the map, sent with your searches and answers.\n\nOn: the others see how far you are (e.g. 32 yd).\nOff: they only see whether you are in the same zone.\n\nDefault: on."]),
		toggle("openNear", L["Open the finder near my quest"], L["When Polestar's arrow brings you close to an objective of a kill, named, loot or group quest.\n\nOn: the panel opens (once per step), so Find a group is one click away. Nothing is sent.\nOff: you open the panel yourself.\n\nDefault: off."]),
		toggle("autoRetry", L["Keep searching until someone is found"], L["After your click on Find a group, while nobody is found.\n\nOn: the search is asked again every 10 s, for up to 5 minutes, until someone is found. Stop ends it.\nOff: it is asked once; with nobody found after 10 s, the search is over.\n\nDefault: off."], { wide = true }),
		{ kind = "binding", action = "POLESTAR_GF_SEARCH", label = L["Find a group"], help = L["Starts the search for your quests."] },
		{ kind = "binding", action = "POLESTAR_GF_PANEL", label = L["Group Finder panel"], help = L["Opens or closes the group finder's panel."] },
	},
})

-- The languages played in the game's region and your own (the door's LanguagesOffered); "All languages" greys
-- them.
local langs = {
	{ kind = "toggle", key = key("acceptAll"), label = L["All languages"], wide = true, search = "language, languages",
		help = L["Which players you see, by the language of their game.\n\nOn: everyone, whatever is ticked below.\nOff: only the languages ticked below (your own by default).\n\nDefault: off."] },
}
for _, row in ipairs(GF.LanguagesOffered()) do
	langs[#langs + 1] = { kind = "toggle", key = key("langs." .. row.code), label = row.name, search = "language, languages",
		help = string.format(L["On: include players whose game is set to %s.\nOff: leave them out."], row.name),
		disabled = function() return ns.Get(key("acceptAll")) and true or false end }
end
register({ tab = ESSENTIALS, section = L["Search languages"], controls = langs })

---------------------------------------------------------------------------
-- Messages
---------------------------------------------------------------------------

-- The box's switch heads its card, its style below: picture cards of the box itself at its real size (it is
-- small), with an example quest.
local EXAMPLE_QUEST, EXAMPLE_LEFT = "Red Linen Goods", "0/6 Red Linen Bandana"

local function example(text)
	local q = "[" .. EXAMPLE_QUEST .. "]"
	return (tostring(text or ""):gsub("{progress}", function() return q .. " " .. EXAMPLE_LEFT end):gsub("{quests}", function() return q end))
end

-- The cards' boxes, dimmed while the page's switch is off (a disabled cards row greys its label alone).
local drawn = {}
local function dim()
	for _, m in ipairs(drawn) do m:SetAlpha(boxOff() and 0.35 or 1) end
end
ns.On("SETTING_CHANGED", function(path)
	if path == "" or path == key("partyBox") then dim() end
end)

local function drawBox(art, style)
	local W, T = ns.Widgets, ns.Theme
	local m = CreateFrame("Frame", nil, art)
	m:SetAllPoints(art)
	drawn[#drawn + 1] = m
	m.Ground = CreateFrame("Frame", nil, m)
	m.Ground:SetAllPoints(m)
	m.Ground.psGuide = true
	T.Skin(m.Ground, "window")
	local top = CreateFrame("Frame", nil, m)
	top:SetAllPoints(m)
	top:SetFrameLevel(m.Ground:GetFrameLevel() + 2)
	local function put(text, role, color, y, x, wrap)
		local fs = W.Text(top, role, color)
		fs:SetPoint("TOPLEFT", top, "TOPLEFT", x or 10, -y)
		fs:SetPoint("RIGHT", top, "RIGHT", -10, 0)
		fs:SetJustifyH("LEFT")
		fs:SetWordWrap(wrap and true or false)
		fs:SetText(text)
		return fs
	end
	local icon = W.Tex(top, "ARTWORK", "icon-group", "icon")
	icon:SetSize(16, 16)
	icon:SetPoint("TOPLEFT", top, "TOPLEFT", 10, -10)
	put(L["Group formed"], "title", "text", 9, 32)
	local y = 34
	if style ~= "compact" then
		put(EXAMPLE_QUEST, "small", "accent", y)
		put(EXAMPLE_LEFT, "small", "textDim", y + 14, 22)
		y = y + 32
	end
	local said = ns.Get(key("helloMsg"))
	put("\226\128\156" .. example(said) .. "\226\128\157", "small", "textMuted", y, nil, style ~= "compact")
	local main = W.Button(top, L["Say hello"], nil, { height = 22 })
	main:SetPoint("BOTTOMLEFT", top, "BOTTOMLEFT", 10, 10)
	main:SetWidth(150)
	local fill = W.Tex(main, "ARTWORK", "white", "accent", -8)
	fill:SetAlpha(0.45)
	fill:SetPoint("TOPLEFT", main, "TOPLEFT", 1, -1)
	fill:SetPoint("BOTTOMLEFT", main, "BOTTOMLEFT", 1, 1)
	fill:SetWidth(84)
	local other = W.Button(top, L["Not now"], nil, { height = 22 })
	other:SetPoint("LEFT", main, "RIGHT", 6, 0)
	other:SetPoint("RIGHT", top, "RIGHT", -10, 0)
	main:EnableMouse(false)
	other:EnableMouse(false)
	dim()
end

register({ tab = MESSAGES, section = L["Message box"],
	toggle = { kind = "toggle", key = key("partyBox"), label = L["Messages and the message box"], search = "message box, messages, hello, goodbye, announce, invite",
		help = L["The messages the finder says for you, each only on your click or key, and the box that offers hello and goodbye.\n\nOn: the messages below are said as each one's switch says; when a group formed through the finder gets together, the box offers to say hello for 5 s, then to say goodbye and leave for 30 s once its quests are done.\nOff: no message is said and no box shows; Announce's button goes, Invite invites without a whisper, Leave leaves without a word.\n\nDefault: on."] },
	controls = {
		{ kind = "cards", key = key("partyBoxStyle"), label = L["Style"], disabled = boxOff, search = "style, compact, preview",
			help = L["Polestar: the group's quests and the objectives left, then the message.\nCompact: only the message and the buttons."],
			art = { 260, 134 },
			choices = {
				{ value = "polestar", label = L["Polestar"], draw = function(art) drawBox(art, "polestar") end },
				{ value = "compact", label = L["Compact"], draw = function(art) drawBox(art, "compact") end },
			} },
	},
})

-- A message's text tooltip: the variables, then the line as it would be said now (with your quests, else an
-- example quest).
local VARS = L["{quests}: the quest links.\n{progress}: the quest links with what is left, e.g. [The Defias Brotherhood] 4/12 Defias Pillager slain.\nEmpty: never sent."]
local function preview(text)
	local live = GF.loaded and GF.PreviewText and GF.HasSampleQuests()
	local said = live and GF.PreviewText(text) or example(text)
	return { " ", live and L["Will say, with your quests:"] or L["Will say, for example:"], said ~= "" and said or L["(not sent)"] }
end

-- Each message: its switch and key binding on one line, then its text (and for Announce, where it speaks).
local MESSAGES_LIST = {
	{ section = L["Hello"], on = "helloOn", text = "helloMsg", binding = "POLESTAR_GF_HELLO", box = true,
		label = L["Offer to say hello"], textLabel = L["Hello message"], bindingLabel = L["Say hello to the group"],
		help = L["On: when a group forms through the finder, the message box offers to say the message in /p (only on your click).\nOff: no hello.\n\nDefault: on."] },
	{ section = L["Goodbye"], on = "goodbyeOn", text = "leaveMsg", binding = "POLESTAR_GF_GOODBYE",
		label = L["Say goodbye when I leave"], textLabel = L["Goodbye message"], bindingLabel = L["Goodbye and leave"],
		help = L["On: leaving a finder group (from the box, the panel or the key) says the message in /p first.\nOff: you leave without a word.\n\nDefault: on."] },
	{ section = L["Announce"], on = "announceOn", text = "announceMsg", binding = "POLESTAR_GF_ANNOUNCE", announce = true,
		label = L["Show Announce"], textLabel = L["Announce message"], bindingLabel = L["Announce my search"],
		help = L["On: the Announce button shows; a click says the message in the chosen channel.\nOff: no Announce button.\n\nDefault: on."] },
	{ section = L["Invite"], on = "inviteOn", text = "inviteMsg",
		label = L["Whisper when I invite"], textLabel = L["Invite message"],
		help = L["On: clicking Invite also whispers the message to the player.\nOff: the invitation goes without a whisper.\n\nDefault: on."] },
	{ section = L["Ask to join"], on = "askOn", text = "askMsg",
		label = L["Whisper when I ask to join"], textLabel = L["Ask to join message"],
		help = L["On: clicking Ask whispers the message to a player already in a group, asking them to invite you.\nOff: Ask sends nothing.\n\nDefault: on."] },
}

for _, m in ipairs(MESSAGES_LIST) do
	-- The page's switch (the messages and the box) greys every message.
	local grey = boxOff
	local controls = { toggle(m.on, m.label, m.help, { disabled = grey, wide = m.binding == nil }) }
	if m.binding then
		controls[#controls + 1] = { kind = "binding", action = m.binding, label = m.bindingLabel, help = m.help }
	end
	if m.announce then
		controls[#controls + 1] = { kind = "dropdown", key = key("announceTo"), label = L["Announce in"], wide = true, search = "announce, channel, general",
			help = L["The channel the line goes to."],
			choices = { { value = "GENERAL", label = L["General (zone)"] }, { value = "LFG", label = L["Looking for group"] }, { value = "SAY", label = L["Say"] }, { value = "YELL", label = L["Yell"] } } }
	end
	controls[#controls + 1] = { kind = "text", key = key(m.text), label = m.textLabel, help = VARS, tip = preview, disabled = grey, search = "message, text" }
	register({ tab = MESSAGES, section = m.section, controls = controls })
end
