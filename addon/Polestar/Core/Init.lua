-- Polestar core: the namespace every other file hangs off, and the plumbing
-- they share: lifecycle, message bus, game events, settings, slash commands.
-- Contract: docs/ARCHITECTURE.md, "Core".
--
-- SavedVariables can come back nil after a cold client restart on Forever
-- beta builds, so nothing here keeps a reference to PolestarDB or
-- PolestarCharDB: every access goes through DB()/CharState(), which recreate
-- them on demand.

local ADDON, ns = ...
Polestar = ns

ns.name = ADDON
ns.version = (C_AddOns and C_AddOns.GetAddOnMetadata and C_AddOns.GetAddOnMetadata(ADDON, "Version")) or "dev"
-- The release stage, the one place it is set: shown as a chip beside the
-- version (the shell sidebar, About). nil once Polestar is released.
ns.stage = "Beta"
-- The leveling routes are planned and played in the simulator but not yet
-- followed through the live game: the welcome (UI/Welcome.lua) says so on
-- its own page while this is true. The owner turns it off once they have
-- been.
ns.routesBeta = true

-- The pack docs online: the TOC's X-Website (the public repository, added at
-- publication) plus the path of docs/PACKS.md. nil without that field.
function ns.DocsURL()
	local site = C_AddOns and C_AddOns.GetAddOnMetadata and C_AddOns.GetAddOnMetadata(ADDON, "X-Website")
	site = type(site) == "string" and site:gsub("/+$", "") or ""
	if site == "" then return nil end
	return site .. "/blob/HEAD/docs/PACKS.md"
end

-- The Polestar Discord's invite: where players report problems (UI/Report.lua).
ns.DiscordURL = "https://discord.gg/vMbee6F2e9"
-- A new issue on Polestar's GitHub: the report window fills one in (UI/Report.lua).
ns.IssueURL = "https://github.com/fitzforge/polestar/issues/new"

local pcall, type, pairs, select, tostring = pcall, type, pairs, select, tostring

-- Translations: a key is the English text, and a missing key renders as
-- itself. A locale file loaded right after this one fills L for its client,
-- so nothing in this file reads L at load: the commands with their help
-- lines register in Commands.lua.
local L = setmetatable({}, { __index = function(_, key) return key end })
ns.L = L

-- A word with more than one meaning ("Chest": a dungeon boss that is a loot
-- chest, or a gear slot) gets a key per meaning, so each can be translated on
-- its own: ns.LC("boss", "Chest") is the translation of "boss: Chest", and
-- "Chest" while there is none.
function ns.LC(context, text)
	return rawget(L, context .. ": " .. text) or text
end

-- An amount of copper as the guide window writes it: "1g 50s", "7s", "25c"
-- (parts that are zero left out; "0c" for none).
function ns.MoneyText(copper)
	copper = math.floor(copper or 0)
	local g, s, c = math.floor(copper / 10000), math.floor(copper / 100) % 100, copper % 100
	local parts = {}
	if g > 0 then parts[#parts + 1] = g .. "g" end
	if s > 0 then parts[#parts + 1] = s .. "s" end
	if c > 0 then parts[#parts + 1] = c .. "c" end
	return #parts > 0 and table.concat(parts, " ") or "0c"
end

-- The interface's translations made with AI (tools/lib/i18n/locales.js,
-- status "ai"; tests/i18n.test.js keeps the two lists equal).
ns.AI_LOCALES = { koKR = true, ptBR = true, ruRU = true, zhCN = true, zhTW = true }

-- True when this client reads an AI-made translation: its locale is one of
-- AI_LOCALES and its file filled L. Options' About then says so.
function ns.AITranslation()
	return (GetLocale and ns.AI_LOCALES[GetLocale()] == true and next(L) ~= nil) or false
end

-- Game terms in the client's own words, so they read as the game writes them
-- in every language (docs/ARCHITECTURE.md, "Localisation"); nil where the
-- client has none. A reputation standing, 1 (Hated) to 8 (Exalted), in the
-- character's gender where the language has one.
function ns.StandingName(n)
	if type(n) ~= "number" then return nil end
	local tag = "FACTION_STANDING_LABEL" .. n
	if type(_G[tag]) ~= "string" then return nil end
	return GetText and GetText(tag, UnitSex and UnitSex("player")) or _G[tag]
end

-- An item quality, 0 (Poor) to 6 (Artifact).
function ns.QualityName(q)
	if type(q) ~= "number" then return nil end
	local s = _G["ITEM_QUALITY" .. q .. "_DESC"]
	if type(s) == "string" and s ~= "" then return s end
	return nil
end

-- A faction: "Alliance" or "A", "Horde" or "H".
local FACTION_TAG = { Alliance = "FACTION_ALLIANCE", A = "FACTION_ALLIANCE", Horde = "FACTION_HORDE", H = "FACTION_HORDE" }
function ns.FactionName(f)
	local tag = FACTION_TAG[f]
	local s = tag and _G[tag]
	if type(s) == "string" and s ~= "" then return s end
	return nil
end

-- Text that prints literally in a FontString: every `|` (the client's escape
-- character) doubled. Packs' strings go through this once, at registration.
function ns.EscapeText(s)
	if type(s) ~= "string" then s = tostring(s) end
	if not s:find("|", 1, true) then return s end
	return (s:gsub("|", "||"))
end

-- A distance in yards (the game's unit) as the player reads it, in the unit
-- of the nav.distanceUnit setting: "120 yd", or "110 m" and "1.2 km" from
-- 1000 m. opts.round = 5 rounds to the nearest 5 (the rares' toasts);
-- opts.compact = true writes yards from 1000 as "1.2k yd"; opts.decimals = 1
-- keeps tenths for controls such as ground-trail spacing and height.
local YARD_METRES = 0.9144
function ns.FormatDistance(yards, opts)
	local decimal = opts and opts.decimals == 1
	local round = opts and opts.round or (decimal and 0.1 or 1)
	if ns.Get("nav.distanceUnit") == "metres" then
		local m = yards * YARD_METRES
		local n = math.floor(m / round + 0.5) * round
		if n >= 1000 then return L["%.1f km"]:format(m / 1000) end
		return (decimal and L["%.1f m"] or L["%d m"]):format(n)
	end
	if opts and opts.compact and yards >= 1000 then return L["%.1fk yd"]:format(yards / 1000) end
	return (decimal and L["%.1f yd"] or L["%d yd"]):format(math.floor(yards / round + 0.5) * round)
end

-- The errors Polestar caught this session, for the report a player copies
-- (UI/Report.lua): each message's first line with how often it came, oldest
-- first, the last few kept. seq, shared with the blocked calls below, says
-- which came last, so the report lists the newest few of both.
local MAX_ERRORS = 5
local errors = {}
local seq = 0
function ns.NoteError(err)
	local msg = tostring(err):match("^[^\n]*")
	seq = seq + 1
	for i = 1, #errors do
		if errors[i].msg == msg then
			errors[i].count, errors[i].seq = errors[i].count + 1, seq
			return
		end
	end
	if #errors >= MAX_ERRORS then table.remove(errors, 1) end
	errors[#errors + 1] = { msg = msg, count = 1, seq = seq }
end
function ns.Errors() return errors end

-- The protected calls the game blocked from Polestar this session
-- (ADDON_ACTION_BLOCKED, ADDON_ACTION_FORBIDDEN: the addon blamed, then the
-- function), for the report: taint is no Lua error, so without these a
-- report on a broken gamepad or button reads "Errors: none". The last few,
-- oldest first, each with the Polestar addon blamed, how often and when it
-- last came.
local MAX_BLOCKED = 5
local blocked = {}
function ns.NoteBlocked(addon, fn)
	if type(addon) ~= "string" or not (addon == ADDON or addon:find("^Polestar_")) then return end
	fn = tostring(fn or "?")
	local at = date("%H:%M:%S")
	seq = seq + 1
	for i = 1, #blocked do
		local e = blocked[i]
		if e.addon == addon and e.fn == fn then
			table.remove(blocked, i)
			e.count, e.at, e.seq = e.count + 1, at, seq
			blocked[#blocked + 1] = e
			return
		end
	end
	if #blocked >= MAX_BLOCKED then table.remove(blocked, 1) end
	blocked[#blocked + 1] = { addon = addon, fn = fn, count = 1, at = at, seq = seq }
end
function ns.Blocked() return blocked end

-- Run a callback; report its error without stopping the caller's loop.
local function call(fn, ...)
	local ok, err = pcall(fn, ...)
	if not ok then
		ns.NoteError(err)
		geterrorhandler()(err)
	end
end
ns.SafeCall = call

-- A frame of Polestar's that goes under the game's own UI (the world map's
-- canvas, the minimap, a quest reward or talent button): made with no parent,
-- then set under it. The gamepad interface hooks CreateFrame and, when the
-- parent is inside one of its open panels (the world map, the quest frame,
-- the talents...), rebuilds that panel's button list inside the caller's
-- code: called from Polestar, the panel is left tainted and the next gamepad
-- action there is blocked. SetParent is not hooked. Every Polestar frame
-- whose parent is a game frame, or is under one, is made through this.
function ns.CreateFrameUnder(kind, name, parent, template)
	local f = CreateFrame(kind, name, nil, template)
	if parent then f:SetParent(parent) end
	return f
end

-- Forever's Gamepad interface style (Options, Gamepad, Enable Gamepad UI).
-- Its navigation (Blizzard_GamepadSmartNavigation, FrameControlsManager)
-- opens, closes and focuses the game's windows, popups, menus and chat box
-- from Blizzard's code, and in the same execution makes protected calls
-- (SetPreferredGamepadInteractTarget, RunBinding). When addon code runs in
-- that flow (a slash command the chat box calls before it closes, a menu or
-- popup shown, a window closed, a hook on a button it focuses), the calls
-- are blocked, and the "AddOn blocked" popup's own gamepad handling blocks
-- the next one, until the client freezes. With it on, Polestar keeps to its
-- own windows: every reach into the game's UI asks ns.GamepadUI() first
-- (the list: docs/ARCHITECTURE.md, "Gamepad interface"; the test:
-- tests/gamepad-ui.test.js). The style is read once, as the addon loads:
-- the client reloads the UI when it changes, and the slash commands are
-- registered then. C_InputInterfaceStyle is the answer: the CVar
-- InputDeviceInterfaceStyle can stay "1" (Gamepad) on a client playing with
-- the keyboard and mouse, so it is read only on a client without the API.
local function readGamepadUI()
	local E = Enum and Enum.InputDeviceInterfaceType
	if not (E and E.Gamepad) then return false end
	local S = C_InputInterfaceStyle
	if S and S.GetCurrentStyle then return S.GetCurrentStyle() == E.Gamepad end
	local get = (C_CVar and C_CVar.GetCVar) or GetCVar
	return get and tonumber(get("InputDeviceInterfaceStyle")) == E.Gamepad or false
end
local gamepadUI = readGamepadUI()
function ns.GamepadUI() return gamepadUI end

-- A Polestar window that Escape closes: listed in UISpecialFrames, which
-- the gamepad interface's menus also read and close, so not with it on
-- (the window's own close button, and B where it takes the gamepad).
function ns.CloseOnEscape(name)
	if gamepadUI or not (UISpecialFrames and name) then return end
	tinsert(UISpecialFrames, name)
end

local function compact(list)
	local j = 0
	for i = 1, #list do
		local h = list[i]
		if h.live then
			j = j + 1
			list[j] = h
		end
	end
	for i = #list, j + 1, -1 do list[i] = nil end
end

---------------------------------------------------------------------------
-- Message bus. Handlers removed mid-dispatch are only marked, then
-- compacted once the outermost dispatch returns, so iteration never skips.
---------------------------------------------------------------------------

local listeners = {} -- msg -> { { msg, fn, live }, ... }
local busDepth, busDirty = 0, false

function ns.On(msg, fn)
	local list = listeners[msg]
	if not list then
		list = {}
		listeners[msg] = list
	end
	local h = { msg = msg, fn = fn, live = true }
	list[#list + 1] = h
	return h
end

function ns.Off(h)
	if type(h) ~= "table" or not h.live then return end
	h.live = false
	if busDepth > 0 then
		busDirty = true
	else
		compact(listeners[h.msg])
	end
end

function ns.Fire(msg, ...)
	local list = listeners[msg]
	if not list then return end
	busDepth = busDepth + 1
	for i = 1, #list do
		local h = list[i]
		if h.live then call(h.fn, ...) end
	end
	busDepth = busDepth - 1
	if busDepth == 0 and busDirty then
		busDirty = false
		for _, l in pairs(listeners) do compact(l) end
	end
end

---------------------------------------------------------------------------
-- Game events, all through one hidden frame.
---------------------------------------------------------------------------

local eventFrame = CreateFrame("Frame")
local gameHandlers = {} -- event -> { { fn, live }, ... }
local eventDepth, eventsDirty = 0, false

local function settle(event)
	local list = gameHandlers[event]
	if not list then return end
	compact(list)
	if #list == 0 then
		gameHandlers[event] = nil
		eventFrame:UnregisterEvent(event)
	end
end

-- Returns false for an event this client does not know (modern clients throw
-- on RegisterEvent for unknown names; Forever is not Era or Retail).
function ns.RegisterEvent(event, fn)
	local list = gameHandlers[event]
	if not list then
		if not pcall(eventFrame.RegisterEvent, eventFrame, event) then
			if ns.Debug then ns.Debug("unknown event", event) end
			return false
		end
		list = {}
		gameHandlers[event] = list
	end
	for i = 1, #list do
		if list[i].fn == fn and list[i].live then return true end
	end
	list[#list + 1] = { fn = fn, live = true }
	return true
end

function ns.UnregisterEvent(event, fn)
	local list = gameHandlers[event]
	if not list then return end
	for i = 1, #list do
		if list[i].fn == fn then list[i].live = false end
	end
	if eventDepth > 0 then
		eventsDirty = true
	else
		settle(event)
	end
end

eventFrame:SetScript("OnEvent", function(_, event, ...)
	local list = gameHandlers[event]
	if not list then return end
	eventDepth = eventDepth + 1
	for i = 1, #list do
		local h = list[i]
		if h.live then call(h.fn, event, ...) end
	end
	eventDepth = eventDepth - 1
	if eventDepth == 0 and eventsDirty then
		eventsDirty = false
		local events = {}
		for ev in pairs(gameHandlers) do events[#events + 1] = ev end
		for i = 1, #events do settle(events[i]) end
	end
end)

---------------------------------------------------------------------------
-- Settings. Values equal to their default are not stored, so a changed
-- default reaches every user and the SavedVariables file stays small.
---------------------------------------------------------------------------

local defaults = {}
local pathKeys = {} -- "ui.scale" -> { "ui", "scale" }

local function keysOf(path)
	local keys = pathKeys[path]
	if not keys then
		keys = {}
		for key in path:gmatch("[^.]+") do keys[#keys + 1] = key end
		pathKeys[path] = keys
	end
	return keys
end

local function lookup(root, keys)
	local node = root
	for i = 1, #keys do
		if type(node) ~= "table" then return nil end
		node = node[keys[i]]
	end
	return node
end

local function DB()
	local db = PolestarDB
	if type(db) ~= "table" then
		db = { schema = 1 }
		PolestarDB = db
	end
	if type(db.settings) ~= "table" then db.settings = {} end
	return db
end
ns.DB = DB

function ns.RegisterDefaults(section, tbl)
	local d = defaults[section]
	if not d then
		d = {}
		defaults[section] = d
	end
	for k, v in pairs(tbl) do d[k] = v end
end

-- Values are shared, not copied: treat returned tables as read-only and Set a
-- new table to change one.
function ns.Get(path)
	local keys = keysOf(path)
	local v = lookup(DB().settings, keys)
	if v == nil then v = lookup(defaults, keys) end
	return v
end

function ns.GetDefault(path)
	return lookup(defaults, keysOf(path))
end

function ns.Set(path, value)
	local keys = keysOf(path)
	local node = DB().settings
	for i = 1, #keys - 1 do
		local k = keys[i]
		if type(node[k]) ~= "table" then node[k] = {} end
		node = node[k]
	end
	if value == lookup(defaults, keys) then value = nil end
	node[keys[#keys]] = value
	ns.Fire("SETTING_CHANGED", path, ns.Get(path))
end

-- The arrow, the action buttons and the timers: with ui.lockHud on, a drag
-- moves them only while Shift is held, so a stray drag does nothing.
function ns.DragLocked()
	return ns.Get("ui.lockHud") and not ns.Compat.IsShiftKeyDown() and true or false
end

-- Forget stored values for one section (or all), back to defaults.
function ns.ResetSettings(section)
	local settings = DB().settings
	if section then
		settings[section] = nil
	else
		for k in pairs(settings) do settings[k] = nil end
	end
	ns.Fire("SETTING_CHANGED", section or "", nil)
end

function ns.CharState()
	local s = PolestarCharDB
	if type(s) ~= "table" then
		s = {}
		PolestarCharDB = s
	end
	if s.schema == nil then s.schema = 1 end
	if type(s.manual) ~= "table" then s.manual = {} end
	if type(s.skipped) ~= "table" then s.skipped = {} end
	-- Per guide, per step: true when its `when` held as the route passed it, or it was unskipped (Engine.lua, Own.latchWhen, Own.keep; a failed one is stored in `skipped`); an unskipped step's `skipto` takes no jump.
	if type(s.when) ~= "table" then s.when = {} end
	-- Map id -> true: the dungeons the player chose to run in leveling guides (`when dungeon`; Engine.ChooseDungeon).
	if type(s.dungeons) ~= "table" then s.dungeons = {} end
	-- Quest id -> "do" | "skip": the player's answer at a group quest in leveling guides (`when group`; Engine.AnswerGroup).
	if type(s.groupQuests) ~= "table" then s.groupQuests = {} end
	if type(s.flags) ~= "table" then s.flags = {} end
	return s
end

-- A character Polestar had never seen: no saved PolestarCharDB when the addon
-- loaded. A /reload loads the saved table again, so it reads false after one.
local newCharacter = false

function ns.IsNewCharacter()
	return newCharacter
end

---------------------------------------------------------------------------
-- Lifecycle
---------------------------------------------------------------------------

local initQueue, loginQueue = {}, {}
local initialized, loggedIn = false, false

function ns.OnInit(fn)
	if initialized then call(fn) else initQueue[#initQueue + 1] = fn end
end

function ns.OnLogin(fn)
	if loggedIn then call(fn) else loginQueue[#loginQueue + 1] = fn end
end

function ns.IsLoggedIn() return loggedIn end

local function onAddonLoaded(_, name)
	if name ~= ADDON then return end
	ns.UnregisterEvent("ADDON_LOADED", onAddonLoaded)
	DB()
	newCharacter = type(PolestarCharDB) ~= "table"
	ns.CharState()
	initialized = true
	local queue = initQueue
	initQueue = nil
	for i = 1, #queue do call(queue[i]) end
end

local function onLogin()
	ns.UnregisterEvent("PLAYER_LOGIN", onLogin)
	loggedIn = true
	local queue = loginQueue
	loginQueue = nil
	for i = 1, #queue do call(queue[i]) end
end

ns.RegisterEvent("ADDON_LOADED", onAddonLoaded)
local function onBlocked(_, addon, fn) ns.NoteBlocked(addon, fn) end
ns.RegisterEvent("ADDON_ACTION_BLOCKED", onBlocked)
ns.RegisterEvent("ADDON_ACTION_FORBIDDEN", onBlocked)
ns.RegisterEvent("PLAYER_LOGIN", onLogin)

---------------------------------------------------------------------------
-- Chat output
---------------------------------------------------------------------------

local PREFIX = "|cff4fd1c5Polestar|r: "

function ns.Print(...)
	local n = select("#", ...)
	local parts = {}
	for i = 1, n do parts[i] = tostring((select(i, ...))) end
	DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. table.concat(parts, " "))
end

ns.debug = false
function ns.Debug(...)
	if ns.debug then ns.Print("|cff8a8f98[debug]|r", ...) end
end

---------------------------------------------------------------------------
-- Slash commands: /polestar and /pole. Not with the gamepad interface: the
-- chat box calls a command's function and then closes itself in that
-- function's taint, which blocks the gamepad's actions (ns.GamepadUI).
-- The minimap button and the key bindings open Polestar then.
---------------------------------------------------------------------------

local commands, commandOrder = {}, {}

function ns.RegisterCommand(name, fn, help)
	name = name:lower()
	if not commands[name] then commandOrder[#commandOrder + 1] = name end
	commands[name] = { fn = fn, help = help }
end

local function showHelp()
	ns.Print(L["Commands"])
	for i = 1, #commandOrder do
		local name = commandOrder[i]
		DEFAULT_CHAT_FRAME:AddMessage(("  /polestar %s  |cff8a8f98%s|r"):format(name, commands[name].help or ""))
	end
end

function ns.RunCommand(msg)
	local name, rest = (msg or ""):match("^%s*(%S*)%s*(.-)%s*$")
	if name == "" then
		ns.Fire("TOGGLE_FRAME")
		return
	end
	name = name:lower()
	if name == "help" then
		showHelp()
		return
	end
	local c = commands[name]
	if not c then
		ns.Print((L["Unknown command '%s'."]):format(name))
		showHelp()
		return
	end
	call(c.fn, rest)
end
if not gamepadUI then
	SLASH_POLESTAR1 = "/polestar"
	SLASH_POLESTAR2 = "/pole"
	SlashCmdList.POLESTAR = ns.RunCommand
end
