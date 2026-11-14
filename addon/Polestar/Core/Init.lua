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
ns.DiscordURL = "https://discord.gg/polestar"
-- A new issue on Polestar's GitHub: the report window fills one in (UI/Report.lua).
ns.IssueURL = "https://github.com/fitzforge/polestar/issues/new"

local pcall, type, pairs, select, tostring = pcall, type, pairs, select, tostring

-- Translations: a key is the English text, and a missing key renders as
-- itself. The client's language folder fills L when Core/Locale.lua loads
-- it, so nothing in this file (nor any before Locale.lua) reads L at load:
-- the commands with their help lines register in Commands.lua.
local L = setmetatable({}, { __index = function(_, key) return key end })
ns.L = L

-- A word with more than one meaning ("Chest": a dungeon boss that is a loot
-- chest, or a gear slot) gets a key per meaning, so each can be translated on
-- its own: ns.LC("boss", "Chest") is the translation of "boss: Chest", and
-- "Chest" while there is none.
function ns.LC(context, text)
	return rawget(L, context .. ": " .. text) or text
end

-- A quest's name in running text, in the client's own quote marks ("Turn in
-- “Your Place in the World”", Havi's suggestion): the translation of
-- "quote marks: “%s”" (deDE „…“, frFR « … », ruRU «…», zhTW 「…」, ...).
-- A name that already holds double quotes, guillemets or corner brackets
-- keeps its own; nil and "" come back as they are.
local OWN_QUOTES = { '"', "\226\128\156", "\226\128\157", "\226\128\158", "\194\171", "\194\187", "\227\128\140", "\227\128\141", "\227\128\142", "\227\128\143" }
function ns.Quoted(name)
	if type(name) ~= "string" or name == "" then return name end
	for _, q in ipairs(OWN_QUOTES) do
		if name:find(q, 1, true) then return name end
	end
	return ns.LC("quote marks", "\226\128\156%s\226\128\157"):format(name)
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
-- opts.compact = true writes yards from 1000 as "1.2k yd".
local YARD_METRES = 0.9144
function ns.FormatDistance(yards, opts)
	local round = opts and opts.round or 1
	if ns.Get("nav.distanceUnit") == "metres" then
		local m = yards * YARD_METRES
		local n = math.floor(m / round + 0.5) * round
		if n >= 1000 then return L["%.1f km"]:format(m / 1000) end
		return L["%d m"]:format(n)
	end
	if opts and opts.compact and yards >= 1000 then return L["%.1fk yd"]:format(yards / 1000) end
	return L["%d yd"]:format(math.floor(yards / round + 0.5) * round)
end

-- The rolling debug log: the last DEBUG_LINES lines Polestar noted (ns.Debug,
-- caught errors, blocked calls), kept whether or not debug output is on, so
-- a report carries what led up to a problem (UI/Report.lua). A ring: one
-- string per line, nothing else kept.
local DEBUG_LINES = 200
local debugLog, debugNext, debugCount = {}, 1, 0
function ns.Log(text)
	debugLog[debugNext] = date("%H:%M:%S ") .. tostring(text)
	debugNext = debugNext % DEBUG_LINES + 1
	if debugCount < DEBUG_LINES then debugCount = debugCount + 1 end
end
-- The last n lines (all kept by default), oldest first.
function ns.DebugLog(n)
	n = math.min(n or debugCount, debugCount)
	local out = {}
	for i = n, 1, -1 do
		out[#out + 1] = debugLog[(debugNext - i - 1) % DEBUG_LINES + 1]
	end
	return out
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
	ns.Log("error: " .. msg)
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
-- last came. Only our own addons count: another author's "Polestar_..."
-- folder (Polestar_Mob_Markers, #1123) is not ours. `where` is the first line
-- of our code under the blocked call (the event fires inside it), since the
-- game names a namespaced or anonymous frame's function only "UNKNOWN()".
-- With none of ours under it, the game's own code made the call, tainted by
-- ours earlier: `where` is then "via <function> <the game's file:line>", the
-- blocked function and the line of the game's code that called it.
local MAX_BLOCKED = 5
local blocked = {}
local function ownAddon(addon)
	if addon == ADDON then return true end
	if not addon:find("^Polestar_") then return false end
	local get = C_AddOns and C_AddOns.GetAddOnMetadata
	local author = get and get(addon, "Author")
	return type(author) == "string" and (author == "Polestar" or author:find("^Polestar;") ~= nil)
end
local function blockedSite()
	if type(debugstack) ~= "function" then return nil end
	local stack = debugstack(2, 40, 0) or ""
	for path, line in stack:gmatch("AddOns[/\\](Polestar[%w_]*[/\\][^:\"%]\n]-%.lua)\"?%]?:(%d+)") do
		local rel = path:gsub("\\", "/")
		-- This handler and the event dispatch in this file.
		if rel ~= ADDON .. "/Core/Init.lua" then return rel .. ":" .. line end
	end
	-- The C function nearest above the game's first line is the blocked one.
	local fn
	for l in stack:gmatch("[^\n]+") do
		fn = l:match("^%[C%]: in function [`']([^`']+)'") or fn
		local path, line = l:match("Interface[/\\]([^:\"%]\n]-%.lua)\"?%]?:(%d+)")
		if path then
			path = path:gsub("\\", "/"):gsub("^AddOns/", "")
			if not path:find("^Polestar") then return "via " .. (fn and (fn .. " ") or "") .. path .. ":" .. line end
		end
	end
	return nil
end
function ns.NoteBlocked(addon, fn)
	if type(addon) ~= "string" or not ownAddon(addon) then return end
	fn = tostring(fn or "?")
	local where = blockedSite()
	local at = date("%H:%M:%S")
	ns.Log("blocked: " .. addon .. " " .. fn .. (where and (" at " .. where) or ""))
	seq = seq + 1
	for i = 1, #blocked do
		local e = blocked[i]
		if e.addon == addon and e.fn == fn and e.where == where then
			table.remove(blocked, i)
			e.count, e.at, e.seq = e.count + 1, at, seq
			blocked[#blocked + 1] = e
			return
		end
	end
	if #blocked >= MAX_BLOCKED then table.remove(blocked, 1) end
	blocked[#blocked + 1] = { addon = addon, fn = fn, where = where, count = 1, at = at, seq = seq }
end
function ns.Blocked() return blocked end

-- An error passed on to the game's handler (BugGrabber, the error frame): the
-- same message at most once every REPEAT_SECONDS, so a loop that keeps
-- failing (an OnUpdate, a ticker) does not flood it. Every one is still noted.
local REPEAT_SECONDS = 30
local raisedAt = {}
local function raise(err)
	local msg = tostring(err):match("^[^\n]*")
	local now = GetTime and GetTime() or 0
	local at = raisedAt[msg]
	if at and now - at < REPEAT_SECONDS then return end
	raisedAt[msg] = now
	geterrorhandler()(err)
end

-- Moments: one more for each timer, script or game event Polestar handles
-- (ns.Safe, the event frame), each message it sends (ns.Fire) and each
-- change the Engine is asked to weigh (Engine.RequestUpdate). Between two
-- reads of ns.Moment() that give the same number in the same frame, nothing
-- Polestar knows of has changed: Engine.GetStepView(i, true) shares one view
-- among the readers of such a moment.
local serial = 0
function ns.Moment() return serial end
function ns.NewMoment() serial = serial + 1 end

-- Run a callback; report its error without stopping the caller's loop.
local function call(fn, ...)
	local ok, err = pcall(fn, ...)
	if not ok then
		ns.NoteError(err)
		raise(err)
	end
end
ns.SafeCall = call

-- fn wrapped so its errors are caught, noted and passed on like an event
-- handler's (nil stays nil): for OnUpdate scripts and timer callbacks, which
-- the client would otherwise run bare.
function ns.Safe(fn)
	if fn == nil then return nil end
	return function(...)
		serial = serial + 1
		call(fn, ...)
	end
end

-- C_Timer's After, NewTicker and NewTimer with the callback through ns.Safe.
function ns.After(seconds, fn) return C_Timer.After(seconds, ns.Safe(fn)) end
function ns.NewTicker(seconds, fn, n) return C_Timer.NewTicker(seconds, ns.Safe(fn), n) end
function ns.NewTimer(seconds, fn) return C_Timer.NewTimer(seconds, ns.Safe(fn)) end

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

---------------------------------------------------------------------------
-- Hiding Polestar (docs/ARCHITECTURE.md, "Hiding Polestar"): one switch per
-- character (the minimap button's click, the addon compartment, the
-- POLESTAR_HIDE binding, /polestar hide), kept through a /reload in
-- PolestarCharDB.hidden. While it holds nothing of Polestar shows and its
-- sounds are silent; the engine, party sync and the Recorder run on. With
-- "Keep the arrow when hidden" (PolestarCharDB.hideKeepsArrow) the arrow,
-- its travel button and its arrival chime stay (Polestar.ArrowHidden).
--
-- Polestar's frames on UIParent hang off one layer of its own,
-- Polestar.UIParent (PolestarUIParent: the screen's size, at UIParent's
-- frame level), made with it as their parent and anchored to UIParent as
-- before. Hiding is the layer's Hide(): each window, card and toast keeps
-- its own shown state and comes back as it was, and their OnUpdate scripts
-- stop. Not under it: the secure buttons (a protected child would make the
-- layer protected in a fight; each goes with ns.GuideShown, changed out of
-- combat), the arrow (hiding may keep it), and the ways back (the minimap
-- and floating buttons, the menu they open). The maps' frames hide with
-- their view (Nav/MapCanvas.lua); the minimap's drawings, the marks on the
-- game's frames and the tooltip lines ask Polestar.Hidden() and redraw on
-- POLESTAR_HIDDEN.
---------------------------------------------------------------------------

local layer = CreateFrame("Frame", "PolestarUIParent", UIParent)
layer:SetAllPoints(UIParent)
layer:SetFrameLevel(UIParent:GetFrameLevel())
ns.UIParent = layer

local hidden, keepArrow = false, false

function ns.Hidden() return hidden end
function ns.HideKeepsArrow() return keepArrow end
-- Whether hiding takes the arrow now (its travel button and arrival chime with it).
function ns.ArrowHidden() return hidden and not keepArrow end

local function underLayer(f)
	while f do
		if f == layer then return true end
		f = f.GetParent and f:GetParent()
	end
	return false
end

-- A Polestar window that Escape closes: listed in UISpecialFrames, which
-- the gamepad interface's menus also read and close, so not with it on
-- (the window's own close button, and B where it takes the gamepad). While
-- Polestar is hidden, the windows under its layer leave the list: the
-- client's CloseSpecialWindows hides a listed window that IsShown, seen or
-- not, so Escape would close one out of sight instead of opening the menu.
local escapes, escapeOut = {}, {}
function ns.CloseOnEscape(name)
	if gamepadUI or not (UISpecialFrames and name) then return end
	escapes[name] = true
	if hidden and underLayer(_G[name]) then
		escapeOut[name] = true
		return
	end
	tinsert(UISpecialFrames, name)
end

local function applyLayer()
	layer:SetShown(not hidden)
	local list = not gamepadUI and UISpecialFrames
	if not list then return end
	if hidden then
		for i = #list, 1, -1 do
			local name = list[i]
			if escapes[name] and underLayer(_G[name]) then
				table.remove(list, i)
				escapeOut[name] = true
			end
		end
	else
		for name in pairs(escapeOut) do
			tinsert(list, name)
			escapeOut[name] = nil
		end
	end
end

-- Hide (true) or show everything Polestar shows. POLESTAR_HIDDEN(hidden)
-- says it changed, GUIDE_SHOWN what goes with the guide (ns.GuideShown).
function ns.SetHidden(on)
	on = on and true or false
	if on == hidden then return end
	local guide = ns.GuideShown()
	hidden = on
	ns.CharState().hidden = on or nil
	applyLayer()
	ns.Fire("POLESTAR_HIDDEN", on)
	if ns.GuideShown() ~= guide then ns.Fire("GUIDE_SHOWN", not guide) end
end

function ns.ToggleHidden() ns.SetHidden(not hidden) end

-- "Keep the arrow when hidden": while hidden, takes effect at once.
function ns.SetHideKeepsArrow(on)
	on = on and true or false
	if on == keepArrow then return end
	keepArrow = on
	ns.CharState().hideKeepsArrow = on or nil
	if hidden then ns.Fire("POLESTAR_HIDDEN", true) end
end

-- The character's saved state, as the addon loads (ADDON_LOADED).
local function loadHidden()
	local s = ns.CharState()
	hidden, keepArrow = s.hidden == true, s.hideKeepsArrow == true
	if hidden then applyLayer() end
end

-- Polestar's sounds, each tied to something it shows, go through these:
-- silent while Polestar is hidden, an `arrow` sound (the arrival chime)
-- while hiding takes the arrow. -> the client's answer, false when silent
function ns.PlaySound(kit, channel, arrow)
	if not PlaySound or (arrow and ns.ArrowHidden()) or (not arrow and hidden) then return false end
	return PlaySound(kit, channel)
end

function ns.PlaySoundFile(file, channel, arrow)
	if not PlaySoundFile or (arrow and ns.ArrowHidden()) or (not arrow and hidden) then return false end
	return PlaySoundFile(file, channel)
end

---------------------------------------------------------------------------
-- Pause (docs/ARCHITECTURE.md, "Pause"): one switch per character, apart
-- from hiding, that makes the guide step aside on the way to a dungeon and
-- inside it, and resumes by itself once the player is back out alive. It
-- pauses what Polestar shows and steers with, not the Engine, which keeps
-- following the quest log. While paused, the arrow drops the Engine's own
-- waypoint (Nav.lua's apply; a hold and points the player picks still
-- show), the guide window and what goes with it (ns.GuideShown) go, and so
-- do the window's nudges (the while-here toast and chime). With pause.map
-- the step's map pins go too, with pause.automation the quest automation
-- waits. It never writes ui.shown, nav.arrow, hidden or a behavior.*
-- setting, so resuming restores everything by itself, and it leaves hiding
-- as it is (and hiding leaves it).
--
-- PolestarCharDB.pause = { state = "armed" | "inside", at, map }: "armed"
-- paused outside (at: ns.Now() then), "inside" in a dungeon, raid,
-- battleground or arena (map: its instance map id, when the client gives
-- it); nil not paused. Core/Pause.lua watches the way in and out and
-- resumes, and ends an armed pause two hours after `at` wherever the player
-- is (a timer); POLESTAR_PAUSED(state | nil, why) says it changed.
---------------------------------------------------------------------------

-- Instances that count, as the guide window's instance rule has them.
local DUNGEON_KINDS = { party = true, raid = true, pvp = true, arena = true }
local pauseState -- the saved table while paused, else nil

function ns.Paused() return pauseState and pauseState.state or nil end

-- Whether the pause takes `part` now: "arrow" (the Engine's waypoint and
-- everything keyed off it), "window" (the guide window and ns.GuideShown),
-- "nagging" (the while-here toast and chime) while paused; "map" (the
-- step's pins) and "automation" (quest accept and turn-in) only with their
-- setting on as well.
function ns.PauseHides(part)
	if not pauseState then return false end
	if part == "arrow" or part == "window" or part == "nagging" then return true end
	if part == "map" or part == "automation" then return ns.Get("pause." .. part) and true or false end
	return false
end

-- -> true, instance map id (or nil) inside an instance that counts; false outside.
function ns.PauseInside()
	local C = ns.Compat
	if not (C and C.IsInInstance) then return false end
	local ok, inside, kind = pcall(C.IsInInstance)
	if not (ok and inside and DUNGEON_KINDS[kind]) then return false end
	local map
	if C.GetInstanceMapID then
		local okMap, id = pcall(C.GetInstanceMapID)
		if okMap and type(id) == "number" then map = id end
	end
	return true, map
end

-- The pause's clock, for Core/Pause.lua too: Compat.Now() (server seconds),
-- time() when the Compat in place has no Now (the test harnesses' stand-ins).
function ns.Now()
	local C = ns.Compat
	local n = C and C.Now and C.Now()
	if type(n) ~= "number" then n = time and time() or 0 end
	return n
end

-- Pause (true) or resume. Paused inside an instance that counts it is
-- "inside" there, elsewhere "armed" (an armed pause keeps the time it was
-- armed). Paused again as it is, nothing changes; "armed" to "inside", or into another
-- instance, fires POLESTAR_PAUSED again. `why`: what paused or resumed it
-- ("hand", "entered", "left", "expired", "window"), passed on with
-- POLESTAR_PAUSED for Core/Pause.lua's chat lines.
function ns.SetPaused(on, why)
	local new
	if on then
		local inside, map = ns.PauseInside()
		if inside then
			new = { state = "inside", map = map, at = pauseState and pauseState.at or ns.Now() }
		elseif pauseState then
			new = pauseState -- outside while paused: as it is ("inside" ends only through the watcher, by `on` false)
		else
			new = { state = "armed", at = ns.Now() }
		end
		if pauseState and new.state == pauseState.state and new.map == pauseState.map then return end
	else
		if not pauseState then return end
	end
	local guide = ns.GuideShown()
	pauseState = new
	ns.CharState().pause = new
	ns.Fire("POLESTAR_PAUSED", new and new.state or nil, why)
	if ns.GuideShown() ~= guide then ns.Fire("GUIDE_SHOWN", not guide) end
end

function ns.TogglePaused(why) ns.SetPaused(not pauseState, why or "hand") end

-- The character's saved state, as the addon loads (ADDON_LOADED). It fires
-- no POLESTAR_PAUSED: Core/Pause.lua times a loaded armed pause from ns.OnInit.
local function loadPause()
	local s = ns.CharState().pause
	if type(s) == "table" and (s.state == "armed" or s.state == "inside") then
		if type(s.at) ~= "number" then s.at = ns.Now() end
		pauseState = s
	else
		pauseState = nil
		ns.CharState().pause = nil
	end
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
	serial = serial + 1
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

-- Whether a message is being handed out now (one of its handlers runs):
-- Polestar.API refuses calls made from there (docs/API.md).
function ns.Dispatching() return busDepth > 0 end

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
	serial = serial + 1
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

-- The table DB() made when there was none: before the saved variables load
-- (a file reading a setting as it loads), the client replaces it with the
-- saved one if there is one, so still holding it at ADDON_LOADED means a
-- fresh install.
local madeDB

local function DB()
	local db = PolestarDB
	if type(db) ~= "table" then
		db = { schema = 1 }
		PolestarDB = db
		madeDB = db
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

-- The value a setting holds itself, nil while it is at its default (what
-- Set(path, value) puts back exactly: undo, a frame's place before a move).
function ns.GetStored(path)
	return lookup(DB().settings, keysOf(path))
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

-- The guide window's on/off (ui.shown): the action buttons, the party panel
-- and the rare and transport alerts go with it, the arrow only with
-- nav.hideArrowWithGuide on (Nav.HiddenWithGuide). An instance hide
-- (ui.instance "hide") takes them too; a combat hide leaves them. Hiding
-- Polestar takes them all, and so does the pause (ns.PauseHides).
local awayInside = false
function ns.GuideShown()
	return not hidden and not ns.PauseHides("window") and ns.GuideWindowOn()
end

-- The window's own on/off and instance wait, Polestar hidden or not: what
-- "Hide the arrow with the guide" and the travel button follow (hiding
-- Polestar takes those only with the arrow, ns.ArrowHidden).
function ns.GuideWindowOn()
	return ns.Get("ui.shown") ~= false and not awayInside
end

-- UI/GuideFrame.lua: whether the window is waiting out an instance. A change
-- fires GUIDE_SHOWN, for what goes and comes back with the guide.
function ns.SetGuideAwayInside(away)
	away = away and true or false
	if away == awayInside then return end
	awayInside = away
	ns.Fire("GUIDE_SHOWN", ns.GuideShown())
end

---------------------------------------------------------------------------
-- Out of sight. Some UI addons follow the guide's steps in their own quest
-- tracker and route, and keep one arrow on screen by turning Polestar's
-- guide window and arrow down to nothing (a scale far below a pixel, alpha
-- 0) instead of hiding them. Both still read as shown here, so the window's
-- toggle would turn off a window nobody sees, and the action buttons with
-- it. Told by the scale alone: Polestar never sets its own that low (the
-- window's scale is 0.6 at least, the arrow's 0.5), while the player's own
-- fades take the window and the arrow to alpha 0 in combat or 0.03 at rest.
---------------------------------------------------------------------------

local SIGHT_SCALE = 0.2
local sight = { pending = false } -- .window, .arrow: the frames ns.WatchSight watches

-- Shown, but kept out of sight by another addon.
function ns.OutOfSight(frame)
	return frame ~= nil and frame:IsShown() and frame:GetScale() < SIGHT_SCALE or false
end

-- Says which of the window and the arrow another addon keeps out of sight
-- and how to get them back. -> true when it said so.
function ns.SayOutOfSight()
	local window, arrow = ns.OutOfSight(sight.window), ns.OutOfSight(sight.arrow)
	if not (window or arrow) then return false end
	DB().sightTold = true
	if window and arrow then
		ns.Print(L["Another addon is keeping the guide window and the arrow out of sight. Some UI addons show the guide's steps in their own quest tracker and route instead: turn that off in that addon to get Polestar's back."])
	elseif window then
		ns.Print(L["Another addon is keeping the guide window out of sight. Some UI addons show the guide's steps in their own quest tracker instead: turn that off in that addon to get it back."])
	else
		ns.Print(L["Another addon is keeping the arrow out of sight. Some UI addons lead the way with their own arrow or route instead: turn that off in that addon to get it back."])
	end
	return true
end

-- The first time on this account: a notice at the top of the screen for 12
-- seconds and the chat line. The window's toggle and the arrow's commands
-- say it again whenever they are used on what is out of sight.
function sight.check()
	sight.pending = false
	if DB().sightTold or hidden then return end
	if not (ns.OutOfSight(sight.window) or ns.OutOfSight(sight.arrow)) then return end
	local alerts = ns.Nav and ns.Nav.alerts
	if alerts and alerts.ShowNotice then
		alerts.ShowNotice(L["Polestar is out of sight"], L["Another addon is hiding the guide window or the arrow. The chat says how to get it back."], 12)
	end
	ns.SayOutOfSight()
end
function sight.soon()
	if sight.pending then return end
	sight.pending = true
	ns.After(0, sight.check)
end
function sight.scale(_, s) if type(s) == "number" and s < SIGHT_SCALE then sight.soon() end end
function sight.show(self) if ns.OutOfSight(self) then sight.soon() end end

-- One of Polestar's frames another addon may take out of sight (role
-- "window" or "arrow"): a post-hook on its SetScale and its OnShow notice the
-- moment it happens, looked at a frame later. Called once the frame's own
-- OnShow is set: the client's SetScript drops a hooked script.
function ns.WatchSight(frame, role)
	sight[role] = frame
	hooksecurefunc(frame, "SetScale", sight.scale)
	frame:HookScript("OnShow", sight.show)
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
	-- Map id -> true (run it) | false (skip it): the player's answer for a dungeon in leveling guides (`when dungeon`; Engine.ChooseDungeon); none: behavior.dungeons answers ("Dungeons in my route").
	if type(s.dungeons) ~= "table" then s.dungeons = {} end
	-- Quest id -> "do" | "skip": the player's answer at a group quest in leveling guides (`when group`; Engine.AnswerGroup).
	if type(s.groupQuests) ~= "table" then s.groupQuests = {} end
	if type(s.flags) ~= "table" then s.flags = {} end
	-- Quest id -> true: the quests the player pinned as along the way (#644; Engine.PinQuest).
	if type(s.pinnedQuests) ~= "table" then s.pinnedQuests = {} end
	-- Guide id -> true: the leveling guides whose end the player reached (Engine.lua, Own.noteEnd), told once; it stands only while that end holds, and is forgotten by a reset or when a pack update changes the guide's steps (checkShape).
	-- Those saved before 0.3.6 (guideEndsV unset) are dropped once: 0.3.5 reused guide ids for other parts of the route, and ended guides by where the player stood (the Undercity at the start of Hillsbrad), so any of them can be false; one without a live step shows nothing either way.
	if type(s.guideEnds) ~= "table" or s.guideEndsV ~= 2 then
		s.guideEnds, s.guideEndsV = {}, 2
	end
	-- Guide id -> true: the guides the player finished, every step done (Engine.lua, the completion in
	-- evaluateLoaded), kept over a reload or relog for the guide list's check (Engine.GetGuideState); a
	-- reset forgets it, and so does a pack update that changes the guide's steps (checkShape).
	if type(s.guideDone) ~= "table" then s.guideDone = {} end
	return s
end

-- A character Polestar had never seen: no saved PolestarCharDB when the addon
-- loaded. A /reload loads the saved table again, so it reads false after one.
local newCharacter = false
-- An account the same way: no saved PolestarDB (a fresh install), or only
-- the table DB() made while the files loaded.
local newAccount = false

function ns.IsNewCharacter()
	return newCharacter
end

function ns.IsNewAccount()
	return newAccount
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
	newAccount = type(PolestarDB) ~= "table" or PolestarDB == madeDB
	DB()
	newCharacter = type(PolestarCharDB) ~= "table"
	ns.CharState()
	-- The character's settings profile into PolestarDB.settings and the
	-- settings migrations, before anything reads a setting (Core/Profiles.lua).
	if ns.Profiles and ns.Profiles.Load then call(ns.Profiles.Load) end
	loadHidden()
	loadPause()
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
-- A debug line: always into the rolling log (ns.Log), to chat while
-- /polestar debug is on.
function ns.Debug(...)
	local n = select("#", ...)
	local parts = {}
	for i = 1, n do parts[i] = tostring((select(i, ...))) end
	ns.Log(table.concat(parts, " "))
	if ns.debug then ns.Print("|cff8a8f98[debug]|r", ...) end
end

---------------------------------------------------------------------------
-- Slash commands: /polestar and /pole. Not with the gamepad interface: the
-- chat box calls a command's function and then closes itself in that
-- function's taint, which blocks the gamepad's actions (ns.GamepadUI).
-- The minimap button and the key bindings open Polestar then.
---------------------------------------------------------------------------

local commands, commandOrder = {}, {}

-- quiet: a command that only prints or sets (status, the arrow's commands);
-- any other, typed while Polestar is hidden, brings Polestar back first, as
-- it is asking to see something.
function ns.RegisterCommand(name, fn, help, quiet)
	name = name:lower()
	if not commands[name] then commandOrder[#commandOrder + 1] = name end
	commands[name] = { fn = fn, help = help, quiet = quiet and true or nil }
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
	if hidden and not c.quiet then ns.SetHidden(false) end
	call(c.fn, rest)
end
if not gamepadUI then
	SLASH_POLESTAR1 = "/polestar"
	SLASH_POLESTAR2 = "/pole"
	SLASH_POLESTAR3 = "/ps"
	SlashCmdList.POLESTAR = ns.RunCommand
end
if not gamepadUI and not SLASH_POLESTAR_RL1 then
	SLASH_POLESTAR_RL1 = "/rl"
	SlashCmdList.POLESTAR_RL = function()
		if C_UI and C_UI.Reload then
			C_UI.Reload()
		elseif ReloadUI then
			ReloadUI()
		end
	end
end
