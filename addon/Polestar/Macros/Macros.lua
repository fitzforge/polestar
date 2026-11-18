-- Class macros: ready-made macros for the player's class, by spec and PvE or
-- PvP (Data.lua), put on the game's macro list in one click from the hub's
-- Macros section (View.lua).
--
-- A macro's text carries markers the client fills in its own language:
-- {s<id>} a spell's name, {i<id>} an item's, {r} the word "Rank" of
-- "Spell(Rank 1)". A name the client has not cached yet falls back to the
-- English one in M.NAMES (an item is asked for, once).
--
-- Create writes a macro with CreateMacro, out of combat only, in the
-- character's macros or the account's while one is free (MAX_CHARACTER_MACROS,
-- MAX_ACCOUNT_MACROS: 18 and 120), 255 characters at most. Polestar remembers
-- the macros it made per character (PolestarCharDB.macros.made[id] = { name,
-- body, perChar }) to tell whether one is current, changed since (a later
-- release, or another client language), edited by hand or deleted, and to
-- update it (EditMacro).
--
--   M.Register(data)            -- Data.lua: { class, url, specs, macros }; keeps the player's class only
--   M.Data() -> data | nil      -- the player's class
--   M.List(filter) -> macros    -- filter { pvp = bool, spec = key | "class" | nil, origin = "classic" | "adapted" | "forever" | nil }
--   M.Counts(pvp) -> { pve, pvp, class, [spec key] = n }  -- the spec counts for that side
--   M.Spec() -> key | nil       -- the player's spec, as Gear reads it
--   M.Body(m) -> text, missing  -- the macro in the client's names; missing: the names left in English
--   M.Spells(m) -> { spellID }  -- the spells it casts, in order
--   M.Known(m) -> true | false, spellID   -- false names the first spell not learned
--   M.Slots() -> account used, account max, character used, character max
--   M.Status(m) -> "new" | "deleted" | "ok" | "outdated" | "edited"
--   M.Enabled() -> bool        -- macros.enabled (Options > Discovery > Lookup): off, nothing is written
--   M.CanWrite(m, perChar, update) -> true | false, "off" | "combat" | "full" | "long" | "noapi"
--   M.Create(m, perChar) / M.Update(m) -> true | false, why ("failed", "missing" too)
--   M.GameName(m) -> the name it gets in the macro list ("PS " and the start of its title)
--
-- MACROS_UPDATED fires after Create and Update, when the game's macros change
-- (UPDATE_MACROS) and when combat starts or ends. Client calls go through
-- M.Client so the tests can stand in for the game.

local ADDON, ns = ...
local L = ns.L
local type, ipairs, pairs, pcall, tonumber, select = type, ipairs, pairs, pcall, tonumber, select

local M = {}
ns.Macros = M

M.MAX_BODY = 255
M.NAME_LEN = 16
M.PREFIX = "PS "
M.ICON = "INV_Misc_QuestionMark" -- with #showtooltip the game shows the spell's own icon
M.NAMES = {}

ns.RegisterDefaults("macros", {
	enabled = true,
	tab = "pve", -- "pve" | "pvp"
	origin = "all", -- "all" | "classic" | "adapted" | "forever"
	where = "char", -- "char" | "account": where Create puts a macro
})

---------------------------------------------------------------------------
-- The client
---------------------------------------------------------------------------

local Client = {}
M.Client = Client

local function call(fn, ...)
	if type(fn) ~= "function" then return nil end
	local ok, a, b, c = pcall(fn, ...)
	if ok then return a, b, c end
end

local function plain(v)
	v = ns.Compat.Readable and ns.Compat.Readable(v) or v
	if type(v) == "string" and v ~= "" then return v end
	return nil
end

function Client.SpellName(id)
	return plain(C_Spell and call(C_Spell.GetSpellName, id)) or plain(call(GetSpellInfo, id))
end

function Client.ItemName(id)
	local n = ns.Compat.GetItemName(id)
	if n then return n end
	ns.Compat.RequestItem(id)
	return nil
end

-- true, false, or nil when the client cannot tell.
function Client.Known(id)
	local known = ns.Compat.IsPlayerSpell(id)
	if known == nil and (C_SpellBook or IsSpellKnown) then known = ns.Compat.IsSpellKnown(id) end
	return known
end
function Client.InCombat() return ns.Compat.InCombat() end
function Client.HasAPI() return type(CreateMacro) == "function" and type(GetNumMacros) == "function" end

function Client.Counts()
	local acc, char = call(GetNumMacros)
	return tonumber(acc) or 0, tonumber(char) or 0
end

function Client.Max() return tonumber(MAX_ACCOUNT_MACROS) or 120, tonumber(MAX_CHARACTER_MACROS) or 18 end
function Client.Index(name) return tonumber((call(GetMacroIndexByName, name))) or 0 end
function Client.Body(index) return (select(3, call(GetMacroInfo, index))) end

function Client.Create(name, icon, body, perChar)
	local ok, index = pcall(CreateMacro, name, icon, body, perChar and true or nil)
	return ok and tonumber(index) or 0
end

function Client.Edit(index, name, body)
	if type(EditMacro) ~= "function" then return false end
	return (pcall(EditMacro, index, name, nil, body))
end

---------------------------------------------------------------------------
-- The data
---------------------------------------------------------------------------

local data -- the player's class

local function playerClass()
	return UnitClass and select(2, UnitClass("player")) or nil
end

-- Keeps the player's class only: the other eight are dropped unread.
function M.Register(d)
	if type(d) ~= "table" or d.class ~= playerClass() then return false end
	local byKey = {}
	for _, s in ipairs(d.specs or {}) do byKey[s.key] = s end
	d.specByKey = byKey
	data = d
	return true
end

function M.Data() return data end

function M.List(filter)
	filter = filter or {}
	local out = {}
	for _, m in ipairs(data and data.macros or {}) do
		local ok = filter.pvp == nil or (m.pvp and true or false) == filter.pvp
		if ok and filter.spec == "class" then ok = m.spec == nil
		elseif ok and filter.spec then ok = m.spec == filter.spec end
		if ok and filter.origin then ok = m.origin == filter.origin end
		if ok then out[#out + 1] = m end
	end
	return out
end

function M.Counts(pvp)
	local c = { pve = 0, pvp = 0, class = 0 }
	for _, s in ipairs(data and data.specs or {}) do c[s.key] = 0 end
	for _, m in ipairs(data and data.macros or {}) do
		if m.pvp then c.pvp = c.pvp + 1 else c.pve = c.pve + 1 end
		if (m.pvp and true or false) == (pvp and true or false) then
			local k = m.spec or "class"
			c[k] = (c[k] or 0) + 1
		end
	end
	return c
end

function M.Spec()
	local Gear = ns.Gear
	local key = Gear and Gear.GetSpec and (Gear.GetSpec())
	if key and data and data.specByKey[key] then return key end
	return nil
end

---------------------------------------------------------------------------
-- The text, in the client's names
---------------------------------------------------------------------------

local function nameOf(kind, id)
	if kind == "s" then return Client.SpellName(id) end
	return Client.ItemName(id)
end

function M.RankWord() return ns.LC("spell rank", "Rank") end

function M.Body(m)
	local missing = {}
	local body = m.code:gsub("{([si])(%d+)}", function(kind, id)
		id = tonumber(id)
		local n = nameOf(kind, id)
		if not n then
			n = M.NAMES[kind .. id] or ("#" .. id)
			missing[#missing + 1] = n
		end
		return n
	end)
	body = body:gsub("{r}", M.RankWord())
	return body, missing
end

-- The text as shown on the card: "|" doubled (a macro's "||" stays as typed),
-- spells and items coloured by kind (colour codes "ffrrggbb").
function M.Highlight(m, spellHex, itemHex)
	local s = m.code:gsub("|", "||")
	s = s:gsub("{([si])(%d+)}", function(kind, id)
		id = tonumber(id)
		local n = nameOf(kind, id) or M.NAMES[kind .. id] or ("#" .. id)
		return "|c" .. (kind == "s" and spellHex or itemHex) .. n .. "|r"
	end)
	return (s:gsub("{r}", M.RankWord()))
end

function M.Spells(m)
	local out, seen = {}, {}
	for id in m.code:gmatch("{s(%d+)}") do
		id = tonumber(id)
		if not seen[id] then
			seen[id] = true
			out[#out + 1] = id
		end
	end
	return out
end

function M.SpellName(id) return id and (Client.SpellName(id) or M.NAMES["s" .. id]) or nil end

-- A spell the client cannot tell about counts as known.
function M.Known(m)
	for _, id in ipairs(M.Spells(m)) do
		if Client.Known(id) == false then return false, id end
	end
	return true
end

-- The first n characters of a UTF-8 text, trailing spaces dropped.
local function utf8Cut(s, n)
	local out, count = {}, 0
	for ch in s:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
		if count >= n then break end
		out[#out + 1] = ch
		count = count + 1
	end
	return (table.concat(out):gsub("%s+$", ""))
end
M.Utf8Cut = utf8Cut

function M.GameName(m)
	return M.PREFIX .. utf8Cut(m.title or m.id, M.NAME_LEN - #M.PREFIX)
end

---------------------------------------------------------------------------
-- The game's macros
---------------------------------------------------------------------------

local function made()
	local s = ns.CharState()
	if type(s.macros) ~= "table" then s.macros = {} end
	if type(s.macros.made) ~= "table" then s.macros.made = {} end
	return s.macros.made
end
M.Made = made

function M.Slots()
	local acc, char = Client.Counts()
	local accMax, charMax = Client.Max()
	return acc, accMax, char, charMax
end

function M.Status(m)
	local rec = made()[m.id]
	if not rec then return "new" end
	local index = Client.Index(rec.name)
	if index == 0 then return "deleted" end
	local body = Client.Body(index) or ""
	if body == M.Body(m) then return "ok" end
	if body == rec.body then return "outdated" end
	return "edited"
end

function M.Enabled() return ns.Get("macros.enabled") ~= false end

local function canWrite(body, perChar, update)
	if not M.Enabled() then return false, "off" end
	if not Client.HasAPI() then return false, "noapi" end
	if Client.InCombat() then return false, "combat" end
	if #body > M.MAX_BODY then return false, "long" end
	if not update then
		local acc, accMax, char, charMax = M.Slots()
		if perChar and char >= charMax then return false, "full" end
		if not perChar and acc >= accMax then return false, "full" end
	end
	return true
end

function M.CanWrite(m, perChar, update)
	return canWrite((M.Body(m)), perChar, update)
end

-- The game name, or the same with " 2" ... " 9" when another macro has it.
local function freeName(base)
	if Client.Index(base) == 0 then return base end
	for i = 2, 9 do
		local n = utf8Cut(base, M.NAME_LEN - 2) .. " " .. i
		if Client.Index(n) == 0 then return n end
	end
	return base
end

function M.Create(m, perChar)
	local ok, why = M.CanWrite(m, perChar, false)
	if not ok then return false, why end
	local body = M.Body(m)
	local name = freeName(M.GameName(m))
	if Client.Create(name, M.ICON, body, perChar) == 0 then return false, "failed" end
	made()[m.id] = { name = name, body = body, perChar = perChar and true or false }
	ns.Fire("MACROS_UPDATED")
	return true
end

-- Writes the current text over a macro Polestar made (made again when it was deleted).
function M.Update(m)
	local rec = made()[m.id]
	if not rec then return false, "missing" end
	local index = Client.Index(rec.name)
	if index == 0 then return M.Create(m, rec.perChar) end
	local ok, why = M.CanWrite(m, rec.perChar, true)
	if not ok then return false, why end
	local body = M.Body(m)
	if not Client.Edit(index, rec.name, body) then return false, "failed" end
	rec.body = body
	ns.Fire("MACROS_UPDATED")
	return true
end

local function changed() ns.Fire("MACROS_UPDATED") end
ns.RegisterEvent("UPDATE_MACROS", changed)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", changed)
ns.RegisterEvent("PLAYER_REGEN_DISABLED", changed)
