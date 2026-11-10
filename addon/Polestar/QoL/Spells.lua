-- Class spells: what the class trainer has for the character at a new level
-- (qol.levelUpSpells) and the spells on the action bars that are an old rank
-- (qol.oldRanks). Both on by default, under Options > Quality of Life >
-- Vendors > Trainers; UI/SpellCards.lua shows them on the heads-up card.
--
-- New at a level (Spells.NewAt): the spells QoL/ClassSpells.lua (generated
-- by `forge data classspells` from the class trainers' sniffed lists) lists
-- for the character's class at exactly that level, for its race (the race
-- mask), not known yet, and, for a higher rank, only when the rank below is
-- known or trainable by then (a talent's higher ranks need the talent).
-- PLAYER_LEVEL_UP fires LEVELUP_SPELLS(notice) when there is any: { level,
-- spells = { { id, rank, cost } }, cost (total), money } (where to train is
-- the card's: Engine.TrainingAdvice). Nothing in an instance; in combat it
-- waits for the fight to end.
--
-- Old ranks (Spells.OldRanks): in this client a bar keeps the exact rank put
-- on it, so a slot holding a spell whose higher rank is in the spellbook
-- (same name, a higher "Rank N") is listed. Every action slot is read
-- (1-180: the main pages, the stance and form bars, the side bars, and the
-- bar addons that use the game's action slots); macros, items and anything
-- not a spell are never touched, nor a spell without a rank. Left alone:
--   * a spell the player keeps at its rank (Spells.Keep, the card's
--     right-click): QoL.State().keptRanks[spell id]
--   * a slot the player filled with a lower rank while knowing a higher one
--     (ACTIONBAR_SLOT_CHANGED to a spell other than the one seen there, and
--     not one just moved from another slot):
--     QoL.State().keptSlots[slot] = spell id. A higher rank learned later
--     does not change that.
-- OLD_RANKS(notice) fires after training (LEARNED_SPELL_IN_TAB,
-- SPELLS_CHANGED, settled for a second) and at login when there is any:
-- { spells = { { id, bestId, name, have, best, slots } }, slots = n }.
-- The same list again is not told twice in a session.
--
-- Spells.Upgrade(): out of combat, each listed slot gets the highest rank
-- (PickupSpell, PlaceAction, ClearCursor, the slot read back); in combat it
-- waits for PLAYER_REGEN_ENABLED (QoL.Secure). Never with something on the
-- cursor. -> slots upgraded (nil when it waits)
--
-- Client: GetActionInfo, PlaceAction, HasAction / C_ActionBar.HasAction,
-- C_Spell.PickupSpell / PickupSpell, ClearCursor, GetCursorInfo,
-- C_Spell.GetSpellSubtext / GetSpellSubtext, C_Spell.GetSpellName,
-- C_SpellBook (GetNumSpellBookSkillLines, GetSpellBookSkillLineInfo,
-- GetSpellBookItemInfo) or the older GetNumSpellTabs / GetSpellTabInfo /
-- GetSpellBookItemInfo, UnitRace; ACTIONBAR_SLOT_CHANGED,
-- LEARNED_SPELL_IN_TAB, SPELLS_CHANGED (Forever's FrameXML and API docs).

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local Client = QoL.Client

local floor, tonumber, type, pairs, ipairs = math.floor, tonumber, type, pairs, ipairs
local sort, concat = table.sort, table.concat

local Spells = {}
QoL.Spells = Spells

ns.RegisterDefaults("qol", { levelUpSpells = true, oldRanks = true })

Spells.SLOTS = 180       -- action slots read
Spells.SETTLE = 1        -- seconds after the last spellbook change
Spells.LOGIN_DELAY = 6   -- seconds after login, after the other heads-ups

---------------------------------------------------------------------------
-- Class spell data (QoL/ClassSpells.lua), unpacked for one class at a time
---------------------------------------------------------------------------

local raw = {}
local unpacked = {} -- class -> { byLevel = { [lvl] = { entry } }, byId = { [id] = entry } }

function QoL.SetClassSpells(t)
	if type(t) == "table" then
		raw = t
		unpacked = {}
	end
end

-- entry: { id, cost, rank, prev, races, level }
function Spells.Data(class)
	local d = unpacked[class]
	if d then return d end
	d = { byLevel = {}, byId = {} }
	unpacked[class] = d
	local s = raw[class]
	if type(s) ~= "string" then return d end
	for lvl, list in s:gmatch("(%d+)=([^;]*)") do
		local level = tonumber(lvl)
		local out = {}
		for e in list:gmatch("[^,]+") do
			local id, cost, rank, prev, races = e:match("^(%d+):(%d+):(%d+):?(%d*):?(%d*)$")
			if id then
				local entry = { id = tonumber(id), cost = tonumber(cost), rank = tonumber(rank), prev = tonumber(prev) or 0, races = tonumber(races) or 0, level = level }
				out[#out + 1] = entry
				d.byId[entry.id] = entry
			end
		end
		d.byLevel[level] = out
	end
	return d
end

---------------------------------------------------------------------------
-- The character's spells
---------------------------------------------------------------------------

local function known(id)
	local C = ns.Compat
	if C.IsSpellKnown(id) then return true end
	return IsPlayerSpell and IsPlayerSpell(id) and true or false
end

local function spellName(id) return Client.SpellName(id) end

-- "Rank 3" (in any language: its number) -> 3; nil without a rank.
function Spells.RankOf(id)
	local fn = (C_Spell and C_Spell.GetSpellSubtext) or GetSpellSubtext
	local text = fn and fn(id)
	if type(text) ~= "string" then return nil end
	return tonumber(text:match("(%d+)"))
end

-- Each spell of the player's spellbook (not the pet's): fn(spellID).
local function eachBookSpell(fn)
	local SB = C_SpellBook
	if SB and SB.GetNumSpellBookSkillLines and SB.GetSpellBookSkillLineInfo and SB.GetSpellBookItemInfo then
		local bank = Enum and Enum.SpellBookSpellBank and Enum.SpellBookSpellBank.Player or 0
		local spellType = Enum and Enum.SpellBookItemType and Enum.SpellBookItemType.Spell or 1
		for i = 1, SB.GetNumSpellBookSkillLines() or 0 do
			local line = SB.GetSpellBookSkillLineInfo(i)
			if line then
				local off = line.itemIndexOffset or 0
				for k = off + 1, off + (line.numSpellBookItems or 0) do
					local info = SB.GetSpellBookItemInfo(k, bank)
					if info and info.spellID and info.itemType == spellType then fn(info.spellID) end
				end
			end
		end
	elseif GetNumSpellTabs and GetSpellTabInfo and GetSpellBookItemInfo then
		for i = 1, GetNumSpellTabs() or 0 do
			local _, _, off, n = GetSpellTabInfo(i)
			for k = (off or 0) + 1, (off or 0) + (n or 0) do
				local kind, id = GetSpellBookItemInfo(k, "spell")
				if kind == "SPELL" and id then fn(id) end
			end
		end
	end
end

-- name -> { rank, id } of the highest rank in the spellbook.
function Spells.BookBest()
	local best = {}
	eachBookSpell(function(id)
		local name, rank = spellName(id), Spells.RankOf(id)
		if name and rank then
			local b = best[name]
			if not b or rank > b.rank then best[name] = { rank = rank, id = id } end
		end
	end)
	return best
end

local function player()
	local ok, p = pcall(ns.Compat.GetPlayerInfo)
	return ok and type(p) == "table" and p or {}
end

local function raceBit()
	local id = UnitRace and select(3, UnitRace("player"))
	return tonumber(id)
end

local function raceOk(entry, rid)
	if entry.races == 0 then return true end
	if not rid then return true end
	return floor(entry.races / 2 ^ (rid - 1)) % 2 == 1
end

---------------------------------------------------------------------------
-- New at a level
---------------------------------------------------------------------------

-- The spells the class trainer has for the character at exactly `level`:
-- { { id, rank, cost } }, by spell id.
function Spells.NewAt(level, class)
	class = class or player().class
	if not (class and level) then return {} end
	local d = Spells.Data(class)
	local rid = raceBit()
	local book
	local out = {}
	for _, e in ipairs(d.byLevel[level] or {}) do
		if raceOk(e, rid) and not known(e.id) then
			local ok = true
			if e.rank > 1 then
				local p = e.prev ~= 0 and d.byId[e.prev]
				if e.prev ~= 0 then
					ok = known(e.prev) or (p and p.level <= level and raceOk(p, rid)) or false
				else
					book = book or Spells.BookBest()
					local name = spellName(e.id)
					ok = name ~= nil and book[name] ~= nil
				end
			end
			if ok then out[#out + 1] = { id = e.id, rank = e.rank, cost = e.cost } end
		end
	end
	return out
end

local waiting -- a level-up told once combat ends

function Spells.CheckLevel(level)
	if not QoL.On("levelUpSpells") or not level then return false end
	local C = ns.Compat
	if C.IsInInstance() then return false end
	if C.InCombat() then
		waiting = level
		return false
	end
	waiting = nil
	local list = Spells.NewAt(level)
	if #list == 0 then return false end
	local total = 0
	for _, s in ipairs(list) do total = total + (s.cost or 0) end
	ns.Fire("LEVELUP_SPELLS", { level = level, spells = list, cost = total, money = Client.Money() })
	return true
end

---------------------------------------------------------------------------
-- Old ranks on the action bars
---------------------------------------------------------------------------

local function hasAction(slot)
	local fn = (C_ActionBar and C_ActionBar.HasAction) or HasAction
	return fn and fn(slot) and true or false
end

-- The spell id in action slot `slot`, nil for anything else (macro, item, empty).
local function slotSpell(slot)
	if not (GetActionInfo and hasAction(slot)) then return nil end
	local kind, id = GetActionInfo(slot)
	if kind == "spell" and type(id) == "number" then return id end
	return nil
end
Spells.SlotSpell = slotSpell

local function state(key)
	local s = QoL.State()
	if type(s[key]) ~= "table" then s[key] = {} end
	return s[key]
end

function Spells.Kept(id) return state("keptRanks")[id] == true end

-- Keep spell `id` at its rank on the bars (on = false: list it again).
function Spells.Keep(id, on)
	state("keptRanks")[id] = (on ~= false) or nil
end

function Spells.ForgetKept()
	local s = QoL.State()
	s.keptRanks, s.keptSlots = nil, nil
end

-- A higher rank of spell id in the spellbook: its { rank, id }, and id's rank.
local function better(id, book)
	local rank = Spells.RankOf(id)
	local name = spellName(id)
	local b = name and book[name]
	if rank and b and b.rank > rank and b.id ~= id then return b, rank, name end
	return nil
end

-- The old ranks on the bars: { { id, bestId, name, have, best, slots = { slot, ... } } }, and
-- the number of slots.
function Spells.OldRanks()
	local book = Spells.BookBest()
	local keptSlots, byId, list, n = state("keptSlots"), {}, {}, 0
	for slot = 1, Spells.SLOTS do
		local id = slotSpell(slot)
		if id and keptSlots[slot] ~= id and not Spells.Kept(id) then
			local b, have, name = better(id, book)
			if b then
				local e = byId[id]
				if not e then
					e = { id = id, bestId = b.id, name = name, have = have, best = b.rank, slots = {} }
					byId[id] = e
					list[#list + 1] = e
				end
				e.slots[#e.slots + 1] = slot
				n = n + 1
			end
		end
	end
	sort(list, function(a, b) return a.slots[1] < b.slots[1] end)
	return list, n
end

-- What each slot held when last read: a change to another spell is the
-- player's, unless that spell was just picked up off another slot (a move).
local seen
local upgrading = false
local lifted = {} -- spell id -> GetTime() it left a slot
local LIFT_WINDOW = 30

local function snapshot()
	seen = {}
	for slot = 1, Spells.SLOTS do seen[slot] = slotSpell(slot) or false end
end

function Spells.OnSlotChanged(slot)
	slot = tonumber(slot)
	if not (seen and slot and slot >= 1 and slot <= Spells.SLOTS) then return end
	local id = slotSpell(slot)
	local was = seen[slot]
	seen[slot] = id or false
	if upgrading then return end
	-- Picked up off a slot (on the cursor, to be put down elsewhere).
	if was and was ~= id then lifted[was] = GetTime and GetTime() or 0 end
	if not id or id == was then return end
	-- Dragged from another slot (a move or a swap): it was on the bars already.
	local at = lifted[id]
	lifted[id] = nil
	if at and (not GetTime or GetTime() - at <= LIFT_WINDOW) then return end
	for s, other in pairs(seen) do
		if s ~= slot and other == id then return end
	end
	if better(id, Spells.BookBest()) then state("keptSlots")[slot] = id end
end

local told -- the last list told this session, as a string

local function key(list)
	local parts = {}
	for _, e in ipairs(list) do parts[#parts + 1] = e.id .. ">" .. e.bestId .. "@" .. concat(e.slots, ".") end
	return concat(parts, ",")
end

-- Tell the old ranks (OLD_RANKS) when there are any not told yet. -> told
function Spells.CheckRanks(force)
	if not QoL.On("oldRanks") then return false end
	local C = ns.Compat
	if C.InCombat() then return false end
	local list, n = Spells.OldRanks()
	if #list == 0 then
		told = nil
		ns.Fire("OLD_RANKS", nil)
		return false
	end
	local k = key(list)
	if k == told and not force then return false end
	told = k
	ns.Fire("OLD_RANKS", { spells = list, slots = n })
	return true
end

local function cursorFree()
	return not (GetCursorInfo and GetCursorInfo())
end

local function pickup(id)
	local fn = (C_Spell and C_Spell.PickupSpell) or PickupSpell
	if fn then fn(id) end
end

local function upgradeNow()
	if not (PlaceAction and cursorFree()) then
		ns.Print(L["Empty the cursor first, then press Upgrade again."])
		return 0
	end
	local list = Spells.OldRanks()
	local done = 0
	upgrading = true
	for _, e in ipairs(list) do
		for _, slot in ipairs(e.slots) do
			if slotSpell(slot) == e.id then
				pickup(e.bestId)
				PlaceAction(slot)
				-- The old rank comes back on the cursor.
				if ClearCursor then ClearCursor() end
				if slotSpell(slot) == e.bestId then done = done + 1 end
				if seen then seen[slot] = slotSpell(slot) or false end
			end
		end
	end
	upgrading = false
	if done > 0 then
		ns.Print(string.format(done == 1 and L["Upgraded %d action button to the highest rank."] or L["Upgraded %d action buttons to the highest rank."], done))
	end
	told = nil
	Spells.CheckRanks()
	return done
end

-- -> slots upgraded, or nil when it waits for combat to end.
function Spells.Upgrade()
	local result
	local now = QoL.Secure("oldRanks", function() result = upgradeNow() end)
	if not now then
		ns.Print(L["Upgrading your action buttons after combat."])
		return nil
	end
	return result
end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

ns.RegisterEvent("PLAYER_LEVEL_UP", function(_, level)
	local n = tonumber(level)
	if n then ns.After(2, function() ns.SafeCall(Spells.CheckLevel, n) end) end
end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if waiting then
		local n = waiting
		ns.After(1, function() if waiting == n then ns.SafeCall(Spells.CheckLevel, n) end end)
	end
end)

-- Spellbook changes come in bursts at a trainer: one check a second after the last.
local changes = 0
local function spellbookChanged()
	if not seen then return end
	changes = changes + 1
	local this = changes
	ns.After(Spells.SETTLE, function()
		if this == changes then ns.SafeCall(Spells.CheckRanks) end
	end)
end
ns.RegisterEvent("LEARNED_SPELL_IN_TAB", spellbookChanged)
ns.RegisterEvent("SPELLS_CHANGED", spellbookChanged)

ns.RegisterEvent("ACTIONBAR_SLOT_CHANGED", function(_, slot) ns.SafeCall(Spells.OnSlotChanged, slot) end)

local loggedIn = false
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	if loggedIn then return end
	loggedIn = true
	ns.After(Spells.LOGIN_DELAY, function()
		snapshot()
		ns.SafeCall(Spells.CheckRanks)
	end)
end)

ns.On("SETTING_CHANGED", function(path)
	if path == "qol.oldRanks" and not QoL.On("oldRanks") then ns.Fire("OLD_RANKS", nil) end
end)
