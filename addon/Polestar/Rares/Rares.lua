-- Polestar.Rares: rare NPCs and treasures. Contract: docs/ARCHITECTURE.md,
-- "Rares".
--
-- This file holds the module's settings, the "last seen" history, and the
-- decision every sighting goes through; Detect.lua feeds it sightings from
-- the client, Toast.lua shows the alert, Pins.lua the map pins, View.lua the
-- hub section. The Codex (Polestar_Codex) is only read once something else
-- loaded it or a feature that needs it is used (Codex.Load never runs in
-- combat).
--
--   Rares.Decide(s, ctx) -> action, reason          pure
--     s   = { source = "vignette"|"nameplate"|"target"|"mouseover", kind = "rare"|"treasure",
--             id, name, classification, dead, player, level }
--     ctx = { get = fn(key) -> setting (key without "rares."), now = epoch seconds,
--             history = { [key] = entry }, inCombat, inInstance, known = fn(kind, id) -> bool }
--     action: "alert" | "hold" (alert once combat ends) | "record" (remember, no alert) | "skip"
--   Rares.Key(kind, id, name) -> "rare:61" | "treasure:2843" | "name:<name>"
--   Rares.Sighting(s, where) -> action, reason        the live path: decide, record, alert
--   Rares.History() -> { [key] = entry }              this realm's; entry = { kind, id, name, level,
--       t (last seen, epoch), first, n, map, x, y, src, alerted (epoch) }
--   Rares.Info(kind, id) -> { kind, id, name, level, levelMax, elite, spawns, loot } | nil  (Codex loaded only)
--   Rares.Codex(load) -> Codex | nil                  load = true loads it (out of combat)
--   Rares.Nearest(spawns, point) -> spawn, yards      nearest spawn on the player's continent
--   Rares.Show(kind, id)                              open the hub section at it (SHOW_RARES)
--   Rares.Nearby() -> { name, ... }                   rares in range now, newest sighting first (reused list)
-- Messages: RARE_SPOTTED(alert) when an alert fires; RARES_HISTORY(key) when
-- the history changes; RARE_NEARBY when the rares in range change.

local ADDON, ns = ...
local L = ns.L

local Rares = {}
ns.Rares = Rares

local serverTime, mapName = ns.Compat.Now, ns.Compat.MapName

local wipe = wipe or function(t) for k in pairs(t) do t[k] = nil end return t end
local type, pairs, tostring,tonumber, floor, sqrt, format = type, pairs, tostring, tonumber, math.floor, math.sqrt, string.format

ns.RegisterDefaults("rares", {
	enabled = true,
	-- Detection paths (Detect.lua).
	vignettes = true,
	nameplates = true,
	target = true,
	mouseover = true,
	-- Alerts.
	alerts = true,
	treasureAlerts = true,
	sound = true,
	soundKit = "raid",
	cooldown = 10, -- minutes per rare
	toastSeconds = 20,
	combatAlerts = false,
	toastPoint = false, -- { point, x, y } once dragged
	ignored = false, -- { [key] = true }
	-- Pins (Pins.lua).
	worldRares = false,
	worldTreasures = false,
	minimapRares = false,
	minimapTreasures = false,
	hideGrey = false,
})

local HISTORY_MAX = 400
local CLASS_RARE = { rare = true, rareelite = true }

-- Sounds the alert may play: SOUNDKIT names in Blizzard_SharedXML/Mainline/
-- SoundKitConstants.lua (Forever 1.60.1), with their ids as the fallback.
Rares.SOUNDS = {
	{ value = "raid", label = L["Raid warning"], kit = "RAID_WARNING", id = 8959 },
	{ value = "ready", label = L["Ready check"], kit = "READY_CHECK", id = 8960 },
	{ value = "whisper", label = L["Boss whisper"], kit = "UI_RAID_BOSS_WHISPER_WARNING", id = 37666 },
}

local function get(key) return ns.Get("rares." .. key) end
Rares.Get = get

---------------------------------------------------------------------------
-- Keys and the decision
---------------------------------------------------------------------------

function Rares.Key(kind, id, name)
	if id then return (kind == "treasure" and "treasure:" or "rare:") .. tostring(id) end
	if type(name) == "string" and name ~= "" then return "name:" .. name end
	return nil
end

function Rares.Decide(s, ctx)
	if type(s) ~= "table" then return "skip", "invalid" end
	local cfg = ctx.get
	if not cfg("enabled") then return "skip", "off" end
	if ctx.inInstance then return "skip", "instance" end
	local source = s.source
	local path = source == "vignette" and "vignettes" or source == "nameplate" and "nameplates" or source
	if path and cfg(path) == false then return "skip", "source" end
	if s.player then return "skip", "player" end
	local kind = s.kind == "treasure" and "treasure" or "rare"
	if kind == "rare" then
		-- A vignette on a creature is a rare by the client's own word; a unit
		-- must say so itself or be one the Codex knows.
		local known = s.id and ctx.known and ctx.known("rare", s.id)
		if source ~= "vignette" and not CLASS_RARE[s.classification or ""] and not known then return "skip", "notRare" end
	end
	local key = Rares.Key(kind, s.id, s.name)
	if not key then return "skip", "unknown" end
	local ignored = cfg("ignored")
	if type(ignored) == "table" and ignored[key] then return "skip", "ignored" end
	if s.dead then return "record", "dead" end
	if not cfg("alerts") then return "record", "alertsOff" end
	if kind == "treasure" and not cfg("treasureAlerts") then return "record", "treasuresOff" end
	local entry = ctx.history and ctx.history[key]
	local cooldown = (tonumber(cfg("cooldown")) or 0) * 60
	if entry and entry.alerted and ctx.now - entry.alerted < cooldown then return "record", "cooldown" end
	if ctx.inCombat and not cfg("combatAlerts") then return "hold", "combat" end
	return "alert", nil
end

---------------------------------------------------------------------------
-- History (account-wide, per realm: PolestarDB.rares.history[realm])
---------------------------------------------------------------------------

local function realm()
	local r = GetRealmName and GetRealmName()
	if type(r) ~= "string" or r == "" or (issecretvalue and issecretvalue(r)) then return "?" end
	return r
end

function Rares.History()
	local db = ns.DB()
	local root = db.rares
	if type(root) ~= "table" then
		root = {}
		db.rares = root
	end
	if type(root.history) ~= "table" then root.history = {} end
	local r = realm()
	local h = root.history[r]
	if type(h) ~= "table" then
		h = {}
		root.history[r] = h
	end
	return h
end

local function prune(h)
	local n, oldestKey, oldest = 0, nil, nil
	for k, e in pairs(h) do
		n = n + 1
		local t = type(e) == "table" and e.t or 0
		if not oldest or t < oldest then oldestKey, oldest = k, t end
	end
	if n > HISTORY_MAX and oldestKey then h[oldestKey] = nil end
end

-- where = { map, x, y } (0-100, live frame) | nil
function Rares.Record(s, where, now, alerted)
	local kind = s.kind == "treasure" and "treasure" or "rare"
	local key = Rares.Key(kind, s.id, s.name)
	if not key then return nil end
	local h = Rares.History()
	local e = h[key]
	if type(e) ~= "table" then
		e = { kind = kind, id = s.id, first = now, n = 0 }
		h[key] = e
		prune(h)
	end
	e.name = s.name or e.name
	if s.level and s.level > 0 then e.level = s.level end
	e.t, e.n, e.src = now, (e.n or 0) + 1, s.source
	if s.dead then e.dead = now end
	if where and where.map then e.map, e.x, e.y = where.map, where.x, where.y end
	if alerted then e.alerted = now end
	ns.Fire("RARES_HISTORY", key)
	return e
end

function Rares.Ignore(key, on)
	local cur = get("ignored")
	local t = {}
	if type(cur) == "table" then for k, v in pairs(cur) do t[k] = v end end
	t[key] = on and true or nil
	ns.Set("rares.ignored", next(t) and t or false)
end

function Rares.IsIgnored(key)
	local t = get("ignored")
	return type(t) == "table" and t[key] == true
end

---------------------------------------------------------------------------
-- The Codex
---------------------------------------------------------------------------

function Rares.Codex(load)
	local C = ns.Codex
	if not C then return nil end
	if C.IsLoaded() then return C end
	if not load or ns.Compat.InCombat() then return nil end
	if C.Load() then return C end
	return nil
end

local function known(kind, id)
	local C = ns.Codex
	if not (C and C.IsLoaded() and id) then return false end
	return C.Name(kind, id) ~= nil
end
Rares.Known = known

-- A Codex rare or treasure in one shape (Codex loaded only).
function Rares.Info(kind, id)
	local C = Rares.Codex(false)
	id = tonumber(id)
	if not (C and id) then return nil end
	if kind == "treasure" then
		local o = C.Object(id)
		if not o then return nil end
		return { kind = "treasure", id = id, name = o.name, spawns = o.spawns or {}, loot = C.Loot and C.Loot("treasure", id) or o.loot or {} }
	end
	local n = C.Npc(id)
	if not n then return nil end
	return {
		kind = "rare", id = id, name = n.name, level = n.level, levelMax = n.levelMax, elite = n.elite, boss = n.boss,
		instance = n.instance, spawns = n.spawns or {}, loot = C.Loot and C.Loot("rare", id) or n.loot or {},
	}
end

---------------------------------------------------------------------------
-- Places and distance
---------------------------------------------------------------------------

local function world(p)
	if not p then return nil end
	return ns.Compat.MapToWorld(p.map, p.x, p.y, p.f)
end

-- Yards between two points { map, x, y, f } on one continent, else nil.
function Rares.Yards(a, b)
	local c1, x1, y1 = world(a)
	local c2, x2, y2 = world(b)
	if not (c1 and c2) or c1 ~= c2 then return nil end
	local dx, dy = x2 - x1, y2 - y1
	return sqrt(dx * dx + dy * dy)
end

-- The spawn nearest to point (same continent), else the first spawn.
function Rares.Nearest(spawns, point)
	if type(spawns) ~= "table" or #spawns == 0 then return nil end
	if not point then return spawns[1], nil end
	local best, bestD
	for i = 1, #spawns do
		local d = Rares.Yards(point, spawns[i])
		if d and (not bestD or d < bestD) then best, bestD = spawns[i], d end
	end
	if best then return best, bestD end
	return spawns[1], nil
end

---------------------------------------------------------------------------
-- Text
---------------------------------------------------------------------------

-- The palette name for a kind: Theme's rare token, treasures the object colour.
function Rares.ColorName(kind)
	return kind == "treasure" and "object" or "rare"
end

-- "Rare" | "Rare Elite" | "Treasure"
function Rares.KindText(kind, elite)
	if kind == "treasure" then return L["Treasure"] end
	return elite and L["Rare Elite"] or L["Rare"]
end

function Rares.LevelText(lo, hi)
	if lo == -1 then return "??" end
	if not lo then return nil end
	if hi and hi ~= lo then return lo .. "\226\128\147" .. hi end
	return tostring(lo)
end

function Rares.YardsText(yd)
	if not yd then return nil end
	return ns.FormatDistance(yd, { round = 5, compact = true })
end

-- "just now", "12 min ago", "3 h ago", "2 days ago"
function Rares.AgoText(t, now)
	if not t then return nil end
	local d = (now or serverTime()) - t
	if d < 60 then return L["just now"] end
	if d < 3600 then return format(L["%d min ago"], floor(d / 60)) end
	if d < 86400 then return format(L["%d h ago"], floor(d / 3600)) end
	local days = floor(d / 86400)
	return days == 1 and L["yesterday"] or format(L["%d days ago"], days)
end

---------------------------------------------------------------------------
-- The live path
---------------------------------------------------------------------------

local held -- the alert waiting for combat to end
local HOLD_FOR = 60

local function context()
	return {
		get = get, now = serverTime(), history = Rares.History(),
		inCombat = ns.Compat.InCombat(), inInstance = ns.Compat.IsInInstance(), known = known,
	}
end
Rares.Context = context

function Rares.PlaySound()
	if not get("sound") or not PlaySound then return end
	local choice = get("soundKit")
	for _, s in ipairs(Rares.SOUNDS) do
		if s.value == choice then
			local id = (SOUNDKIT and SOUNDKIT[s.kit]) or s.id
			pcall(PlaySound, id, "Master")
			return
		end
	end
end

-- The alert for a sighting: what the toast shows, and where its waypoint goes.
--   * A vignette with a position: the thing's own position, at its distance.
--   * A unit seen by nameplate, target or mouseover: in sight, so the waypoint
--     is where it was seen (the player's spot then), not one of its spawns,
--     which can be across the zone from a rare that walks.
--   * A vignette without a position: its nearest known spawn, flagged
--     (spawnYards) so the toast says it is a spawn; no waypoint when no spawn
--     is on the player's continent. The toast asks the vignette again when
--     the waypoint is set (a.vignette).
local function alertOf(s, where, exact)
	local kind = s.kind == "treasure" and "treasure" or "rare"
	local info = s.id and Rares.Info(kind, s.id)
	local unitLevel = s.level and s.level ~= 0 and s.level or nil
	local a = {
		kind = kind, id = s.id, key = Rares.Key(kind, s.id, s.name), source = s.source,
		name = s.name or (info and info.name) or L["Unknown rare"],
		level = unitLevel or (info and info.level), levelMax = not unitLevel and info and info.levelMax or nil,
		elite = s.classification == "rareelite" or (info and info.elite) or false,
		loot = info and #info.loot or nil,
		vignette = s.vignette,
	}
	local me = ns.PlayerPoint()
	if exact and where and where.map then
		a.map, a.x, a.y = where.map, where.x, where.y
		a.yards = me and Rares.Yards(me, where)
	elseif s.source == "nameplate" or s.source == "target" or s.source == "mouseover" then
		a.inSight = true
		local seen = where or me
		if seen and seen.map then a.map, a.x, a.y = seen.map, seen.x, seen.y end
	else
		local spawn, d = nil, nil
		if info then spawn, d = Rares.Nearest(info.spawns, me) end
		if spawn and d then
			a.map, a.x, a.y, a.f = spawn.map, spawn.x, spawn.y, spawn.f
			a.spawnYards = d
		end
	end
	a.zone = mapName((me and me.map) or a.map)
	return a
end
Rares.AlertOf = alertOf

local function fire(a)
	Rares.PlaySound()
	ns.Fire("RARE_SPOTTED", a)
end

-- Rares in range of the player now, for the rare button (QoL/Buttons.lua).
-- A sighting keeps its rare here for NEAR_FOR seconds; after that it stays
-- only while the client still shows it (its vignette, or its unit as target,
-- mouseover or a nameplate). A dead one goes at once.
local NEAR_FOR = 45
local nearby, nearbyList, nearbyTimer = {}, {}, false

local function clock() return GetTime and GetTime() or 0 end

local function unitIs(unit, guid)
	local readable = ns.Compat.Readable
	if not (UnitExists and readable(UnitExists(unit))) then return false end
	if readable(UnitGUID(unit)) ~= guid then return false end
	return not readable(UnitIsDead and UnitIsDead(unit))
end

local function stillShown(e)
	local V = C_VignetteInfo
	if e.vignette and V and V.GetVignetteInfo then
		local ok, info = pcall(V.GetVignetteInfo, e.vignette)
		if ok and type(info) == "table" and not ns.Compat.Readable(info.isDead) then return true end
	end
	if not e.guid then return false end
	if unitIs("target", e.guid) or unitIs("mouseover", e.guid) then return true end
	for i = 1, 40 do
		if unitIs("nameplate" .. i, e.guid) then return true end
	end
	return false
end

-- Names of the rares in range, newest sighting first (a reused list).
function Rares.Nearby()
	local now = clock()
	local list = {}
	for key, e in pairs(nearby) do
		if now - e.at >= NEAR_FOR then
			if stillShown(e) then e.at = now else nearby[key] = nil end
		end
		if nearby[key] then list[#list + 1] = e end
	end
	table.sort(list, function(a, b) return a.at > b.at end)
	wipe(nearbyList)
	for i = 1, #list do nearbyList[i] = list[i].name end
	if #list > 0 and not nearbyTimer and C_Timer and C_Timer.After then
		nearbyTimer = true
		C_Timer.After(NEAR_FOR, function()
			nearbyTimer = false
			ns.Fire("RARE_NEARBY")
		end)
	end
	return nearbyList
end

local function track(s)
	if s.kind == "treasure" or type(s.name) ~= "string" or s.name == "" then return end
	local key = Rares.Key("rare", s.id, s.name)
	if not key then return end
	if s.dead then
		if nearby[key] then
			nearby[key] = nil
			ns.Fire("RARE_NEARBY")
		end
		return
	end
	local e = nearby[key]
	if not e then
		e = {}
		nearby[key] = e
	end
	e.name, e.guid, e.at = s.name, s.guid, clock()
	e.vignette = s.vignette or e.vignette
	ns.Fire("RARE_NEARBY")
end

-- where = { map, x, y } (0-100, live frame): the thing's own position (a
-- vignette's); without it a unit sighting is recorded where the player stands.
function Rares.Sighting(s, where)
	local ctx = context()
	local action, reason = Rares.Decide(s, ctx)
	if action == "skip" then return action, reason end
	track(s)
	local now = ctx.now
	local exact = where ~= nil
	if not where and (s.source == "nameplate" or s.source == "target" or s.source == "mouseover") then
		where = ns.PlayerPoint()
	end
	Rares.Record(s, where, now, action == "alert")
	if action == "alert" then
		fire(alertOf(s, where, exact))
	elseif action == "hold" then
		held = { s = s, where = where, exact = exact, at = now }
	end
	return action, reason
end

-- Combat ended: the held alert, if it is still fresh and still due.
function Rares.Release()
	local h = held
	held = nil
	if not h or serverTime() - h.at > HOLD_FOR then return false end
	local key = Rares.Key(h.s.kind, h.s.id, h.s.name)
	local entry = key and Rares.History()[key]
	if entry then entry.alerted = serverTime() end
	fire(alertOf(h.s, h.where, h.exact))
	return true
end

function Rares.Held() return held end

function Rares.Show(kind, id)
	ns.Fire("SHOW_RARES", kind, id)
end

-- A sample alert (Options, /pole rares test): the nearest rare the Codex
-- knows when it is loaded, else a stand-in at the player's level. It plays
-- the sound and leaves the history alone.
function Rares.ShowSample()
	local me = ns.PlayerPoint()
	local best, bestD
	local list = Rares.ListOf and Rares.ListOf("rare")
	for _, rec in ipairs(list or {}) do
		local spawn, d = Rares.Nearest(rec.spawns, me)
		if spawn and d and (not bestD or d < bestD) then best, bestD = { rec = rec, spawn = spawn }, d end
	end
	if best then
		local rec, s = best.rec, best.spawn
		fire({ kind = "rare", id = rec.id, key = Rares.Key("rare", rec.id), name = rec.name, level = rec.level, levelMax = rec.levelMax,
			elite = rec.elite, yards = bestD, zone = mapName(s.map), map = s.map, x = s.x, y = s.y, f = s.f, source = "sample" })
		return
	end
	local info = ns.Compat.GetPlayerInfo()
	fire({ kind = "rare", name = L["A rare"], level = info.level, elite = false, inSight = true,
		zone = mapName(me and me.map), source = "sample" })
end

function Rares.ClearHistory()
	local db = ns.DB()
	if type(db.rares) == "table" and type(db.rares.history) == "table" then db.rares.history[realm()] = nil end
	held = nil
	ns.Fire("RARES_HISTORY", nil)
end

ns.RegisterCommand("rares", function(arg)
	arg = (arg or ""):lower()
	if arg == "test" then
		Rares.ShowSample()
		return
	end
	Rares.Show()
end, L["rares [test]: open Rares, or show a sample alert"])
