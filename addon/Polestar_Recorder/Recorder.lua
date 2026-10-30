-- Polestar Recorder: writes what the player does while leveling into
-- PolestarRecorderDB as compact records, in schema 2 of docs/RECORDING.md
-- (the contract with the uploader, the ingest server and forge). Off until
-- the player turns it on (/psrec on, or Options > Recorder): while off
-- nothing is written.
--
-- This file: SavedVariables, the chunk writer, positions and maps, the
-- session record, and the lifecycle. Quests.lua, World.lua, Finds.lua,
-- Progress.lua, Route.lua and Trail.lua add the collectors, Commands.lua
-- the /psrec command, on the shared namespace.
--
-- A record is one line of tab-separated fields: kind, dt (tenths of a second
-- since the chunk's epoch), then the kind's fields in the contract's order.
-- ns.Rec(kind, ...) writes one; nil is an empty field, true/false are 1/0,
-- and the position fields are one argument (ns.P()).
-- Nothing here keeps a session table of events: records go straight into the
-- open chunk's line buffer.
--
-- Forever beta can restore SavedVariables as nil after a cold client restart.
-- Nothing here trusts a cached PolestarRecorderDB: DB() puts the live state
-- (install id, seq, the chunk table) back into whatever table the global
-- holds, so a lost table never loses what is being recorded.

local ADDON, ns = ...

-- ns.L[key]: the key is the English text, a missing key returns itself.
-- Locales/<locale>.lua (after this file in the TOC) fill it on that client,
-- as Polestar's do (docs/TRANSLATING.md; `node tools/polestar.js i18n`).
ns.L = setmetatable({}, { __index = function(_, key) return key end })
local L = ns.L

local type, pairs, pcall, floor, tostring, select, concat = type, pairs, pcall, math.floor, tostring, select, table.concat
local byte, sub, gsub, format, random = string.byte, string.sub, string.gsub, string.format, math.random
local GetTime = GetTime

ns.SCHEMA = 2

local CHUNK_SECONDS = 300 -- a chunk closes after 5 minutes ...
local CHUNK_BYTES = 16 * 1024 -- ... or 16 KiB
local STORE_BYTES = 4 * 1024 * 1024 -- the oldest chunks go beyond 4 MiB
local REFRESH_SECONDS = 60 -- the open chunk is written into chunks[seq] this often (out of combat)
local MAINTAIN_TICK = 5 -- seconds between chunk age / refresh checks
local MAX_TEXT = 4000 -- bytes per text field
ns.CHUNK_BYTES, ns.STORE_BYTES = CHUNK_BYTES, STORE_BYTES

---------------------------------------------------------------------------
-- Chat output
---------------------------------------------------------------------------

local PREFIX = "|cff4fd1c5Polestar Recorder|r: "

function ns.Print(...)
	local n = select("#", ...)
	local parts = {}
	for i = 1, n do parts[i] = tostring((select(i, ...))) end
	DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. concat(parts, " "))
end

---------------------------------------------------------------------------
-- Game events, through one hidden frame
---------------------------------------------------------------------------

local eventFrame = CreateFrame("Frame")
local handlers = {} -- event -> { fn, ... }

-- Returns false for an event this client does not know (RegisterEvent
-- throws on unknown names).
function ns.On(event, fn)
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
		if not ok then geterrorhandler()(err) end
	end
end)

---------------------------------------------------------------------------
-- Small helpers
---------------------------------------------------------------------------

-- Values the client marks secret (restricted contexts: combat, instances)
-- are unusable.
local function usable(v)
	if v == nil then return false end
	if issecretvalue and issecretvalue(v) then return false end
	return true
end
ns.Usable = usable

-- v when usable, else nil.
function ns.Value(v)
	if usable(v) then return v end
	return nil
end

-- A usable number, else nil.
function ns.Num(v)
	if usable(v) and type(v) == "number" then return v end
	return nil
end

-- A usable non-empty string, else nil.
function ns.Str(v)
	if usable(v) and type(v) == "string" and v ~= "" then return v end
	return nil
end

-- "Creature-0-1465-0-2105-448-000043F59F" -> "Creature", 448. Forever
-- obfuscates the spawn parts of creature GUIDs; the id (6th part) is kept.
function ns.ParseGUID(guid)
	if not usable(guid) or type(guid) ~= "string" then return nil end
	local kind, id = guid:match("^(%a+)%-[^-]*%-[^-]*%-[^-]*%-[^-]*%-(%d+)")
	if not kind then kind = guid:match("^(%a+)%-") end
	return kind, tonumber(id)
end

-- The record's npcKind letter of a GUID kind.
local NPC_KIND = { Creature = "c", Vehicle = "c", GameObject = "o", Item = "i", Player = "p" }
ns.NPC_KIND = NPC_KIND

-- npcKind, npcId of a unit token ("npc", "target", ...): c/o with the id, p
-- without one (players are never stored beyond the kind), nil when unknown.
-- Game objects (wanted posters, quest boxes) are not units, so
-- UnitExists("npc") is false for them while UnitGUID("npc") is their
-- GameObject GUID: go by the GUID.
function ns.Ref(unit)
	local kind, id = ns.ParseGUID(UnitGUID and UnitGUID(unit))
	local k = kind and NPC_KIND[kind]
	if not k then return nil, nil end
	if k == "p" then return "p", nil end
	return k, id
end

-- npcKind, npcId of a GUID.
function ns.RefOfGUID(guid)
	local kind, id = ns.ParseGUID(guid)
	local k = kind and NPC_KIND[kind]
	if not k then return nil, nil end
	if k == "p" or k == "i" then return k, nil end
	return k, id
end

-- The record classification letter of UnitClassification.
local CLS = { normal = "n", trivial = "n", minus = "n", elite = "e", rare = "r", rareelite = "R", worldboss = "b" }
function ns.Cls(classification)
	if not usable(classification) then return nil end
	return CLS[classification]
end

local function spellName(id)
	if id and C_Spell and C_Spell.GetSpellName then return C_Spell.GetSpellName(id) end
	return nil
end
ns.SpellName = spellName

---------------------------------------------------------------------------
-- Field encoding (docs/RECORDING.md "Field encoding")
---------------------------------------------------------------------------

-- At most MAX_TEXT bytes, cut at a UTF-8 character boundary.
local function capText(s)
	if #s <= MAX_TEXT then return s end
	local i = MAX_TEXT
	while i > 0 do
		local b = byte(s, i + 1)
		if not (b and b >= 0x80 and b < 0xC0) then break end
		i = i - 1
	end
	return sub(s, 1, i)
end

-- A free text field: no tabs or newlines.
function ns.Text(s)
	if not (usable(s) and type(s) == "string") then return nil end
	return capText((gsub(s, "[\t\r\n]", " ")))
end

-- A text part of a list item: no tabs, newlines, `;` or `:`.
function ns.ListText(s)
	if not (usable(s) and type(s) == "string") then return "" end
	return (gsub(s, "[\t\r\n;:]", " "))
end

-- Quest ids (or any whole numbers) as a list field.
function ns.Ids(list, n)
	n = n or #list
	if n == 0 then return nil end
	local out = {}
	for i = 1, n do out[i] = format("%d", list[i]) end
	return concat(out, ";")
end

local function field(v)
	local t = type(v)
	if v == nil then return "" end
	if t == "table" then return v[1] end -- ns.P(): three fields already encoded
	if not usable(v) then return "" end
	if t == "number" then
		if v ~= v or v == math.huge or v == -math.huge then return "" end
		if v == floor(v) then return format("%d", v) end
		local s = format("%.1f", v)
		return (gsub(s, "%.0$", ""))
	elseif t == "string" then
		return capText((gsub(v, "[\t\r\n]", " ")))
	elseif t == "boolean" then
		return v and "1" or "0"
	end
	return ""
end

---------------------------------------------------------------------------
-- SavedVariables
---------------------------------------------------------------------------

-- Recording is opt-in: nothing is written until the player turns it on, with
-- /psrec on or by sharing in Polestar Client (PolestarRecorderShare in
-- Ack.lua). The choice lives in the DB and here, so a DB table lost
-- mid-session keeps recording on.
local enabled = false
-- /psrec off was typed (and not undone by /psrec on): it wins over the
-- client's share flag.
local optout = false

-- The live state, mirrored into PolestarRecorderDB by DB().
local live -- the table PolestarRecorderDB was at the last DB()
local state = { install = nil, seq = 0, acked = 0, chunks = {}, maps = {} }
local schemaNote = false -- schema 1 data was found and removed at load
local shareNote = false -- the client's share flag turned recording on at load

local BASE36 = "0123456789abcdefghijklmnopqrstuvwxyz"
local function randomId(n)
	local out = {}
	for i = 1, n do
		local k = random(1, 36)
		out[i] = sub(BASE36, k, k)
	end
	return concat(out)
end

local function validId(s, n)
	return type(s) == "string" and #s == n and not s:find("[^0-9a-z]")
end

local function DB()
	local db = PolestarRecorderDB
	if db ~= live or type(db) ~= "table" then
		if type(db) ~= "table" then
			db = {}
			PolestarRecorderDB = db
		end
		live = db
		db.schema = ns.SCHEMA
		db.install, db.seq, db.acked = state.install, state.seq, state.acked
		db.chunks, db.maps = state.chunks, state.maps
		db.enabled = enabled
		db.optout = optout or nil
	end
	return db
end
ns.DB = DB

-- PolestarRecorderCharDB: { id = <10 base-36 characters>, textSeen = { [q] = true } }.
local charState = { id = nil, textSeen = {} }
local charLive
local function CharDB()
	local c = PolestarRecorderCharDB
	if c ~= charLive or type(c) ~= "table" then
		if type(c) ~= "table" then
			c = {}
			PolestarRecorderCharDB = c
		end
		charLive = c
		c.id, c.textSeen = charState.id, charState.textSeen
	end
	return c
end
ns.CharDB = CharDB

function ns.CharId() return charState.id end
function ns.TextSeen() return CharDB().textSeen end

-- Adopts the SavedVariables at ADDON_LOADED: schema 1 data is removed (its
-- sessions carried names and nothing reads it now); only the opt-in and the
-- Recorder window's own settings (position, ticked spots) stay. Then the
-- client's share flag (Ack.lua, loaded before the SavedVariables): true turns
-- recording on unless the player typed /psrec off, false turns it off, nil
-- (no Polestar Client) leaves the player's own choice.
local function adopt()
	local db = PolestarRecorderDB
	if type(db) ~= "table" then db = {} end
	if db.schema ~= ns.SCHEMA and (db.schema ~= nil or db.sessions ~= nil) then
		db = { enabled = db.enabled == true, optout = db.optout, panel = db.panel, spots = db.spots }
		schemaNote = true
	end
	enabled = db.enabled == true
	optout = db.optout == true
	local share = PolestarRecorderShare
	if share == true and not optout and not enabled then
		enabled, shareNote = true, true
	elseif share == false then
		enabled = false
	end
	db.enabled = enabled
	state.install = validId(db.install, 12) and db.install or randomId(12)
	state.seq = type(db.seq) == "number" and db.seq >= 0 and floor(db.seq) or 0
	state.acked = type(db.acked) == "number" and db.acked >= 0 and floor(db.acked) or 0
	state.chunks = type(db.chunks) == "table" and db.chunks or {}
	state.maps = type(db.maps) == "table" and db.maps or {}
	for seq, text in pairs(state.chunks) do
		if type(seq) ~= "number" or type(text) ~= "string" then state.chunks[seq] = nil end
		if type(seq) == "number" and seq > state.seq then state.seq = seq end
	end
	PolestarRecorderDB = db
	live = nil
	DB()

	local c = PolestarRecorderCharDB
	if type(c) ~= "table" then c = {} end
	charState.id = validId(c.id, 10) and c.id or randomId(10)
	charState.textSeen = type(c.textSeen) == "table" and c.textSeen or {}
	PolestarRecorderCharDB = c
	charLive = nil
	CharDB()
end

-- Deletes the chunks the uploader acknowledged (Ack.lua, loaded before the
-- SavedVariables): { ["<install>"] = upto }, one entry per WoW account, since
-- the accounts of one game share its AddOns folder.
local function pruneAcked()
	local ack = PolestarRecorderAck
	if type(ack) ~= "table" then return end
	local upto = ack[state.install]
	if type(upto) ~= "number" then return end
	upto = floor(upto)
	for seq in pairs(state.chunks) do
		if seq <= upto then state.chunks[seq] = nil end
	end
	if upto > state.acked then state.acked = upto end
	DB().acked = state.acked
end

function ns.IsEnabled() return enabled end

---------------------------------------------------------------------------
-- The chunk writer
---------------------------------------------------------------------------

local open -- { seq, epoch, t0, lines = {}, n, bytes, dirty }
local storedBytes = 0 -- bytes of the closed chunks in chunks[]
local pendingDropped = 0 -- chunks dropped for size, not yet recorded
local lastRefresh = 0
local recordHooks = {}

local function countStored()
	local n = 0
	for seq, text in pairs(state.chunks) do
		if not (open and seq == open.seq) then n = n + #text end
	end
	storedBytes = n
end

-- The chunk's text: its lines joined by "\n".
local function chunkText(c) return concat(c.lines, "\n", 1, c.n) end

-- Writes the open chunk into chunks[seq] (a refresh or its close).
local function flush()
	local c = open
	if not c or not c.dirty then return end
	DB().chunks[c.seq] = chunkText(c)
	c.dirty = false
	lastRefresh = GetTime()
end

-- Drops the oldest stored chunks while everything is over STORE_BYTES.
local function enforceCap()
	local openBytes = open and open.bytes or 0
	local dropped = 0
	while storedBytes + openBytes > STORE_BYTES do
		local oldest
		for seq in pairs(state.chunks) do
			if not (open and seq == open.seq) and (not oldest or seq < oldest) then oldest = seq end
		end
		if not oldest then break end
		storedBytes = storedBytes - #state.chunks[oldest]
		state.chunks[oldest] = nil
		dropped = dropped + 1
	end
	pendingDropped = pendingDropped + dropped
	return dropped
end

local buf = {} -- one record's fields, reused

-- Appends one line to the open chunk.
local function append(line)
	local c = open
	c.n = c.n + 1
	c.lines[c.n] = line
	c.bytes = c.bytes + #line + 1
	c.dirty = true
end

local roll -- forward

-- Writes one record at GetTime() time `t` (nil: now). Returns true when it
-- was written (recording on and a chunk open).
local function write(t, kind, ...)
	local c = open
	if not c or not enabled then return false end
	local now = GetTime()
	if c.bytes >= CHUNK_BYTES then
		roll()
		c = open
		if not c then return false end
	end
	local dt = floor(((t or now) - c.t0) * 10 + 0.5)
	if dt < 0 then dt = 0 end
	local n = select("#", ...)
	buf[1], buf[2] = kind, format("%d", dt)
	for i = 1, n do buf[i + 2] = field((select(i, ...))) end
	append(concat(buf, "\t", 1, n + 2))
	for i = 1, #recordHooks do recordHooks[i](kind) end
	return true
end

function ns.Rec(kind, ...) return write(nil, kind, ...) end

-- A record that happened at GetTime() time t (a kill written once its XP
-- and quest progress are known).
function ns.RecAt(t, kind, ...) return write(t, kind, ...) end

-- fn(kind) after every record written.
function ns.OnRecord(fn) recordHooks[#recordHooks + 1] = fn end

-- Whether records are being written now.
function ns.Recording() return open ~= nil and enabled end

---------------------------------------------------------------------------
-- Positions and maps
---------------------------------------------------------------------------

-- uiMapID, x, y (0-100, unrounded) | uiMapID | nil
function ns.Position()
	if not (C_Map and C_Map.GetBestMapForUnit) then return nil end
	local map = C_Map.GetBestMapForUnit("player")
	if not (usable(map) and type(map) == "number") then return nil end
	local v = C_Map.GetPlayerMapPosition and C_Map.GetPlayerMapPosition(map, "player")
	if not v then return map end
	local x, y = v.x, v.y
	if not (usable(x) and usable(y) and type(x) == "number" and type(y) == "number") then return map end
	return map, x * 100, y * 100
end

local function coord(v)
	v = floor(v * 100 + 0.5)
	if v < 0 then return 0 end
	if v > 10000 then return 10000 end
	return v
end

local noteMap -- forward

-- The P fields (map, x, y in hundredths of a percent) of a position in
-- percent, as ONE argument for ns.Rec (a Lua call in the middle of an
-- argument list gives one value): { "map\tx\ty" }, or the three fields
-- empty without a position (instances). Also ns.PAt(nil) for "unknown".
local NO_P = { "\t\t" }
ns.NO_P = NO_P
function ns.PAt(map, x, y)
	if not (map and x and y) then return NO_P end
	noteMap(map)
	return { format("%d\t%d\t%d", map, coord(x), coord(y)) }
end

-- The player's P fields.
function ns.P()
	return ns.PAt(ns.Position())
end

local function worldPos(map, x, y)
	local ok, c, pos = pcall(C_Map.GetWorldPosFromMapPos, map, CreateVector2D(x, y))
	if ok and c and pos and pos.x and pos.y then return c, pos.x, pos.y end
end

-- A `map` record's fields after its id: type, parent, continent, top, left,
-- bottom, right. World bounds follow the Era-frame convention in
-- ARCHITECTURE "Map frames": wx = top + (bottom - top) * y/100,
-- wy = left + (right - left) * x/100; continent is the world instance.
local function mapFields(map)
	if not (C_Map and C_Map.GetMapInfo) then return nil end
	local info = C_Map.GetMapInfo(map)
	if not info then return nil end
	local c, top, left, bottom, right
	if C_Map.GetWorldPosFromMapPos and CreateVector2D then
		local c0, t, l = worldPos(map, 0, 0)
		local c1, b, r = worldPos(map, 1, 1)
		if c0 and c0 == c1 and (t ~= b or l ~= r) then
			c, top, left, bottom, right = c0, floor(t * 10 + 0.5) / 10, floor(l * 10 + 0.5) / 10, floor(b * 10 + 0.5) / 10, floor(r * 10 + 0.5) / 10
		end
	end
	local out = { map, info.mapType, info.parentMapID, c, top, left, bottom, right }
	for i = 1, 8 do out[i] = field(out[i]) end
	return concat(out, "\t")
end

-- Records a map's bounds once per install (`map` record, kept in maps).
noteMap = function(map)
	if not open or state.maps[map] then return end
	local fields = mapFields(map)
	if not fields then return end
	state.maps[map] = fields
	DB().maps[map] = fields
	local c = open
	local dt = floor((GetTime() - c.t0) * 10 + 0.5)
	append("map\t" .. format("%d", dt < 0 and 0 or dt) .. "\t" .. fields)
end
ns.NoteMap = noteMap

-- Yards per 100% of map width and height (nil when unknown).
local sizeW, sizeH = {}, {}
function ns.MapSize(map)
	local w = sizeW[map]
	if w == nil then
		w, sizeH[map] = false, false
		if C_Map and C_Map.GetMapWorldSize then
			local mw, mh = C_Map.GetMapWorldSize(map)
			if mw and mh and mw > 0 and mh > 0 then w, sizeH[map] = mw, mh end
		end
		sizeW[map] = w
	end
	if not w then return nil end
	return w, sizeH[map]
end

-- Distance in yards between two points (0-100) on one map; percent units
-- scaled by 30 yd/% when the map size is unknown.
function ns.Yards(map, dx, dy)
	local w, h = ns.MapSize(map)
	if w then
		dx, dy = dx * w / 100, dy * h / 100
	else
		dx, dy = dx * 30, dy * 30
	end
	return (dx * dx + dy * dy) ^ 0.5
end

---------------------------------------------------------------------------
-- Text the player's own name, race or class appears in
---------------------------------------------------------------------------

local function plain(s) return (gsub(s, "[%%%^%$%(%)%.%[%]%*%+%-%?]", "%%%0")) end

-- Quest and gossip text with the player's name, race and class put back as
-- the client's $N, $R, $C (lowercase $r, $c where the client wrote them
-- lowercase).
function ns.Scrub(text)
	if not (usable(text) and type(text) == "string") or text == "" then return text end
	local name = UnitName and UnitName("player")
	if usable(name) and type(name) == "string" and #name > 1 then text = gsub(text, plain(name), "$N") end
	local race = UnitRace and UnitRace("player")
	if usable(race) and type(race) == "string" and #race > 1 then
		text = gsub(text, plain(race), "$R")
		local lower = race:lower()
		if lower ~= race then text = gsub(text, plain(lower), "$r") end
	end
	local class = UnitClass and UnitClass("player")
	if usable(class) and type(class) == "string" and #class > 1 then
		text = gsub(text, plain(class), "$C")
		local lower = class:lower()
		if lower ~= class then text = gsub(text, plain(lower), "$c") end
	end
	return text
end

---------------------------------------------------------------------------
-- The session record
---------------------------------------------------------------------------

local function meta(addon, key)
	local get = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
	if not get then return nil end
	local ok, v = pcall(get, addon, key)
	if ok and type(v) == "string" and v ~= "" then return (gsub(v, "%s", "")) end
	return nil
end

local function loaded(addon)
	local f = (C_AddOns and C_AddOns.IsAddOnLoaded) or IsAddOnLoaded
	return f and f(addon) and true or false
end

-- `id:version;...` of the Polestar guide packs that run, plus
-- `guide:<id>` of the active guide (Polestar's public API: Guides.Packs,
-- Engine.GetGuide), when Polestar is loaded.
local function packs()
	local P = Polestar
	if type(P) ~= "table" then return nil end
	local out = {}
	local G = P.Guides
	if type(G) == "table" and type(G.Packs) == "function" then
		local ok, list = pcall(G.Packs)
		if ok and type(list) == "table" then
			for _, r in ipairs(list) do
				if type(r) == "table" and r.status == "on" and type(r.id) == "string" then
					out[#out + 1] = ns.ListText(r.id) .. ":" .. ns.ListText(type(r.version) == "string" and r.version or "")
				end
			end
		end
	end
	local E = P.Engine
	if type(E) == "table" and type(E.GetGuide) == "function" then
		local ok, g = pcall(E.GetGuide)
		if ok and type(g) == "table" and type(g.id) == "string" then out[#out + 1] = "guide:" .. ns.ListText(g.id) end
	end
	return #out > 0 and concat(out, ";") or nil
end

-- h hardcore, p PvP (War Mode) joined. The client has no API for an RP
-- realm, so `r` is never written.
local function ruleset()
	local flags = ""
	if C_GameRules and C_GameRules.IsHardcoreActive then
		local ok, v = pcall(C_GameRules.IsHardcoreActive)
		if ok and usable(v) and v then flags = flags .. "h" end
	end
	if C_PvP and C_PvP.IsWarModeActive then
		local ok, v = pcall(C_PvP.IsWarModeActive)
		if ok and usable(v) and v then flags = flags .. "p" end
	end
	return flags
end

local function sessionRecord()
	local _, race = UnitRace("player")
	local _, class = UnitClass("player")
	local faction = UnitFactionGroup("player")
	local build, interface
	if GetBuildInfo then
		local _, b, _, i = GetBuildInfo()
		build, interface = tonumber(b), tonumber(i)
	end
	local region = GetCurrentRegion and GetCurrentRegion() or nil
	ns.Rec("session", charState.id, race, class, faction, UnitSex and UnitSex("player") or nil, UnitLevel("player"),
		GetLocale and GetLocale() or nil, build, interface, region, ruleset(), meta(ADDON, "Version"),
		loaded("Polestar") and meta("Polestar", "Version") or nil, packs())
end

---------------------------------------------------------------------------
-- Opening and closing chunks
---------------------------------------------------------------------------

local function openChunk()
	local db = DB()
	state.seq = state.seq + 1
	db.seq = state.seq
	open = { seq = state.seq, epoch = GetServerTime(), t0 = GetTime(), lines = {}, n = 0, bytes = 0, dirty = true }
	append(format("chunk\t0\t%d\t%d\t%s", open.seq, open.epoch, charState.id))
	sessionRecord()
	if pendingDropped > 0 then
		local n = pendingDropped
		pendingDropped = 0
		ns.Rec("dropped", n)
	end
	flush()
end

local function closeChunk()
	local c = open
	if not c then return end
	flush()
	open = nil
	storedBytes = storedBytes + c.bytes - 1
	enforceCap()
end

-- Closes the open chunk and opens the next one (age, size).
roll = function()
	closeChunk()
	if enabled then openChunk() end
end

-- Age, refresh and size checks.
local function maintain()
	local c = open
	if not c then return end
	-- The checks run every MAINTAIN_TICK; half a tick of slack keeps a check
	-- that lands a hair early from waiting for the next one.
	local now = GetTime() + MAINTAIN_TICK / 2
	if now - c.t0 >= CHUNK_SECONDS then
		roll()
		return
	end
	if c.dirty and now - lastRefresh >= REFRESH_SECONDS and not (InCombatLockdown and InCombatLockdown())
		and not (UnitAffectingCombat and UnitAffectingCombat("player") == true) then
		flush()
		if storedBytes + c.bytes > STORE_BYTES and enforceCap() > 0 then
			local n = pendingDropped
			pendingDropped = 0
			ns.Rec("dropped", n)
		end
	end
end
C_Timer.NewTicker(MAINTAIN_TICK, maintain)

-- Writes the open chunk now (Save now, /reload).
ns.Flush = flush

---------------------------------------------------------------------------
-- Sessions: a login, a reload, or recording turned on. Collectors reset
-- their per-session state (dedupe sets) through ns.OnSession.
---------------------------------------------------------------------------

local sessionCallbacks, logoutCallbacks = {}, {}
local inWorld = false

-- fn(isReload) at every session start.
function ns.OnSession(fn) sessionCallbacks[#sessionCallbacks + 1] = fn end

-- fn() at logout or reload, before the chunk closes.
function ns.OnLogout(fn) logoutCallbacks[#logoutCallbacks + 1] = fn end

local function startSession(isReload)
	closeChunk()
	openChunk()
	for i = 1, #sessionCallbacks do
		local ok, err = pcall(sessionCallbacks[i], isReload)
		if not ok then geterrorhandler()(err) end
	end
end
ns.StartSession = startSession

-- The player's own choice (/psrec on|off, the Recorder window): off is kept
-- as an opt-out that the client's share flag does not undo; on clears it.
-- Turning recording on in play starts a session at once; off closes the
-- chunk.
function ns.SetEnabled(on)
	if not on and ns.TrailStop then ns.TrailStop("recording off") end
	if not on then closeChunk() end
	enabled = on and true or false
	optout = not enabled
	local db = DB()
	db.enabled, db.optout = enabled, optout or nil
	if enabled and not open and inWorld then startSession(false) end
end

-- Deletes every chunk and map (the seq keeps counting, so the server never
-- takes a new chunk for an old one), then starts a fresh session.
function ns.ClearAll()
	if ns.TrailStop then ns.TrailStop("cleared") end
	open = nil
	local db = DB()
	state.chunks, state.maps = {}, {}
	db.chunks, db.maps = state.chunks, state.maps
	storedBytes, pendingDropped = 0, 0
	if enabled and inWorld then startSession(false) end
end

-- What /psrec status and the Options page show.
function ns.Stats()
	local n, bytes = 0, 0
	for seq, text in pairs(state.chunks) do
		n = n + 1
		bytes = bytes + ((open and seq == open.seq) and open.bytes or #text)
	end
	return { chunks = n, bytes = bytes, seq = state.seq, acked = state.acked, install = state.install, open = open and open.seq or nil, openBytes = open and open.bytes or 0 }
end

---------------------------------------------------------------------------
-- Lifecycle
---------------------------------------------------------------------------

ns.On("ADDON_LOADED", function(_, name)
	if name ~= ADDON then return end
	adopt()
	pruneAcked()
	countStored()
	enforceCap()
end)

ns.On("PLAYER_LOGIN", function()
	if schemaNote then
		schemaNote = false
		ns.Print(L["recordings from the previous Recorder (schema 1) were removed; recording now uses schema 2"])
	end
	if shareNote then
		shareNote = false
		ns.Print(L["on, because sharing is on in Polestar Client. /psrec off to stop."])
	end
end)

ns.On("PLAYER_ENTERING_WORLD", function(_, isInitialLogin, isReloadingUi)
	inWorld = true
	if not enabled then return end
	if not open or isInitialLogin or isReloadingUi then startSession(isReloadingUi and true or false) end
end)

ns.On("PLAYER_LOGOUT", function()
	for i = 1, #logoutCallbacks do
		local ok, err = pcall(logoutCallbacks[i])
		if not ok then geterrorhandler()(err) end
	end
	closeChunk()
end)
