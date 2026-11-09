-- Polestar Studio: build, test and share Polestar guides in game.
--
-- This file: the namespace (S, global PolestarStudio for debugging), S.L,
-- the addon's own message bus (S.On / S.Fire), WoW events through one frame
-- (S.RegisterEvent), SavedVariables (PolestarStudioDB), shared helpers, the
-- /studio command and the page in Polestar's Options.
--
-- Forever can restore SavedVariables as nil after a cold restart: nothing
-- here trusts a cached PolestarStudioDB; S.DB() recreates what is missing.
--
-- Messages fired on the bus:
--   STUDIO_LOADED                    PolestarStudioDB is ready (ADDON_LOADED)
--   STUDIO_CHANGED(kind)             Model: "header"|"step"|"goal"|"select"|"doc"
--   STUDIO_SYNCED(ok, problems)      Sync: a draft was handed to Polestar
--   STUDIO_CHECKS(problems)          Checks: a fresh run of the in-game checks
--   STUDIO_SAVED(time)               Backup: a save point was written
--   STUDIO_CAPTURED(i, j)            Capture: a goal was added from play

local ADDON, S = ...

PolestarStudio = S

-- S.L[key]: the key is the English text, a missing key returns itself
-- (Polestar_Recorder's way; Locales/<locale>.lua files may fill it).
S.L = setmetatable({}, { __index = function(_, key) return key end })
local L = S.L

local type, pairs, ipairs, pcall, tostring, tonumber, select = type, pairs, ipairs, pcall, tostring, tonumber, select
local format, gsub, floor = string.format, string.gsub, math.floor

-- The Polestar namespace (its public API), or nil when Polestar is missing.
function S.P()
	local P = _G.Polestar
	return type(P) == "table" and P or nil
end

---------------------------------------------------------------------------
-- Message bus
---------------------------------------------------------------------------

local listeners = {} -- message -> { fn, ... }

local function report(err)
	if geterrorhandler then geterrorhandler()(err) end
end

function S.On(message, fn)
	local list = listeners[message]
	if not list then
		list = {}
		listeners[message] = list
	end
	list[#list + 1] = fn
	return fn
end

function S.Off(message, fn)
	local list = listeners[message]
	if not list then return end
	for i = #list, 1, -1 do
		if list[i] == fn then table.remove(list, i) end
	end
end

function S.Fire(message, ...)
	local list = listeners[message]
	if not list then return end
	for i = 1, #list do
		local ok, err = pcall(list[i], ...)
		if not ok then report(err) end
	end
end

---------------------------------------------------------------------------
-- WoW events: one frame, handlers called as fn(event, ...)
---------------------------------------------------------------------------

local eventFrame = CreateFrame("Frame")
local handlers = {} -- event -> { fn, ... }

function S.RegisterEvent(event, fn)
	local list = handlers[event]
	if not list then
		local ok = pcall(eventFrame.RegisterEvent, eventFrame, event)
		if not ok then return false end
		list = {}
		handlers[event] = list
	end
	list[#list + 1] = fn
	return true
end

eventFrame:SetScript("OnEvent", function(_, event, ...)
	local list = handlers[event]
	if not list then return end
	for i = 1, #list do
		local ok, err = pcall(list[i], event, ...)
		if not ok then report(err) end
	end
end)

---------------------------------------------------------------------------
-- SavedVariables
---------------------------------------------------------------------------

local DB_VERSION = 1

-- PolestarStudioDB, made whole: every table the modules read exists.
function S.DB()
	local db = PolestarStudioDB
	if type(db) ~= "table" then
		db = {}
		PolestarStudioDB = db
	end
	if type(db.docs) ~= "table" then db.docs = {} end
	if type(db.ui) ~= "table" then db.ui = {} end
	if db.sync == nil then db.sync = true end
	if db.capture == nil then db.capture = false end
	if type(db.saved) ~= "number" then db.saved = 0 end
	db.version = DB_VERSION
	return db
end

-- Whether PolestarStudioDB came back from the client at load (false: it was
-- nil, as after Forever's cold-restart loss, or this is the first run).
S.loadedDB = false

---------------------------------------------------------------------------
-- Helpers shared by every module
---------------------------------------------------------------------------

function S.Copy(v)
	if type(v) ~= "table" then return v end
	local out = {}
	for k, x in pairs(v) do out[k] = S.Copy(x) end
	return out
end

function S.Now()
	if GetServerTime then return GetServerTime() end
	return time and time() or 0
end

-- n rounded to two decimals, as the compiler rounds coordinates.
function S.Round2(n)
	return floor(n * 100 + 0.5) / 100
end

-- A number as a guide token: integers bare, others with at most two decimals.
function S.Num(n)
	n = S.Round2(n)
	if n == floor(n) then return format("%d", n) end
	local s = format("%.2f", n)
	s = gsub(s, "0+$", "")
	return s
end

-- "x,y" as a guide writes coordinates.
function S.XY(x, y)
	return S.Num(x) .. "," .. S.Num(y)
end

-- One line of text: control characters (line breaks too) become spaces.
function S.OneLine(s)
	s = gsub(tostring(s or ""), "%c", " ")
	s = gsub(s, "^%s+", "")
	s = gsub(s, "%s+$", "")
	return s
end

-- A quoted guide token: `"` and `\` escaped, as the guide lexer reads them.
function S.Quote(s)
	s = S.OneLine(s)
	s = gsub(s, "\\", "\\\\")
	s = gsub(s, '"', '\\"')
	return '"' .. s .. '"'
end

-- A quoted token's text (the inverse of S.Quote), or the token as it is.
function S.Unquote(tok)
	if type(tok) ~= "string" then return tok end
	local inner = tok:match('^"(.*)"$')
	if not inner then return tok end
	return (gsub(inner, "\\(.)", "%1"))
end

-- A readable value of a unit API (Forever can return secret values).
function S.Readable(v)
	local P = S.P()
	local C = P and P.Compat
	if C and C.Readable then return C.Readable(v) end
	return v
end

function S.Print(msg)
	if DEFAULT_CHAT_FRAME then DEFAULT_CHAT_FRAME:AddMessage(L["Polestar Studio"] .. ": " .. tostring(msg)) end
end

function S.InCombat()
	local P = S.P()
	if P and P.Compat and P.Compat.InCombat then return P.Compat.InCombat() end
	return InCombatLockdown and InCombatLockdown() or false
end

-- Named one-shot timers: Debounce(name, secs, fn) runs fn once, secs after
-- the last call with that name.
local timers = {}
function S.Debounce(name, secs, fn)
	local t = timers[name]
	if t then t:Cancel() end
	timers[name] = C_Timer.NewTimer(secs, function()
		timers[name] = nil
		fn()
	end)
end

function S.CancelDebounce(name)
	local t = timers[name]
	if t then
		t:Cancel()
		timers[name] = nil
	end
end

-- The author's handle, as a guide id's first part: lower-case letters,
-- digits and dashes (nil when none is set).
function S.Slug(s)
	s = tostring(s or ""):lower()
	s = gsub(s, "[^a-z0-9]+", "-")
	s = gsub(s, "^%-+", "")
	s = gsub(s, "%-+$", "")
	if #s > 32 then s = s:sub(1, 32):gsub("%-+$", "") end
	return s
end

function S.Handle()
	local h = S.Slug(S.DB().handle)
	if #h >= 2 then return h end
	return nil
end

function S.SetHandle(h)
	S.DB().handle = S.Slug(h)
end

---------------------------------------------------------------------------
-- Loading, slash command, Options page
---------------------------------------------------------------------------

S.RegisterEvent("ADDON_LOADED", function(_, name)
	if name ~= ADDON then return end
	S.loadedDB = type(PolestarStudioDB) == "table"
	S.DB()
	S.Fire("STUDIO_LOADED")
end)

local function toggle()
	if S.UI and S.UI.Toggle then
		S.UI.Toggle()
	else
		S.Print(L["The Studio window is not available."])
	end
end
S.TogglePanel = toggle

local function onOff(word)
	word = (word or ""):lower()
	if word == "on" then return true end
	if word == "off" then return false end
	return nil
end

SLASH_POLESTARSTUDIO1 = "/studio"
SlashCmdList.POLESTARSTUDIO = function(msg)
	local cmd, rest = (msg or ""):match("^%s*(%S*)%s*(.-)%s*$")
	cmd = (cmd or ""):lower()
	if cmd == "sync" and S.Sync then
		local on = onOff(rest)
		if on == nil then on = not S.Sync.Enabled() end
		S.Sync.SetEnabled(on)
		S.Print(on and L["Live sync on."] or L["Live sync off."])
	elseif cmd == "capture" and S.Capture then
		local on = onOff(rest)
		if on == nil then on = not S.Capture.Enabled() end
		S.Capture.SetEnabled(on)
		S.Print(on and L["Auto-capture on."] or L["Auto-capture off."])
	elseif cmd == "restore" and S.Backup then
		S.Backup.Offer(true)
	elseif cmd == "handle" and rest ~= "" then
		S.SetHandle(rest)
		S.Print((L["Your handle: %s"]):format(S.Handle() or "-"))
	else
		toggle()
	end
end

-- Polestar's Options: a Studio page (spec 4.1).
local function registerOptions()
	local P = S.P()
	if not (P and P.RegisterOptions) then return end
	local ok, err = P.RegisterOptions({
		page = L["Studio"],
		key = "studio",
		section = L["Polestar Studio"],
		controls = {
			{ kind = "button", label = L["Open Studio"], help = L["Build, test and share guides in game (/studio)."],
				onClick = toggle },
			{ kind = "toggle", label = L["Live sync"],
				help = L["Your draft plays in Polestar's guide window as you build it."],
				get = function() return S.Sync and S.Sync.Enabled() or false end,
				set = function(v) if S.Sync then S.Sync.SetEnabled(v) end end },
			{ kind = "toggle", label = L["Auto-capture"],
				help = L["Accepts, turn-ins, flight paths, hearth binds, trainer visits and quest kills add goals to the selected step as you play."],
				get = function() return S.Capture and S.Capture.Enabled() or false end,
				set = function(v) if S.Capture then S.Capture.SetEnabled(v) end end },
			{ kind = "toggle", label = L["Hide widgets in combat"],
				help = L["The Studio widgets hide while you fight and come back after."],
				get = function() return S.DB().ui.hideInCombat and true or false end,
				set = function(v) S.DB().ui.hideInCombat = v and true or false end },
		},
	})
	if not ok then report(err) end
end
registerOptions()
