-- The macro client for the class macros' tests (after wow_stub.lua and stub_world.lua): the game's macro
-- list (account macros first, then the character's, as GetMacroInfo numbers them) and spell names.
--
--   local MS = stub.macros
--   MS.list                                   -- { { name, icon, body, perChar } }, account ones first
--   MS.accountMax, MS.charMax                 -- MAX_ACCOUNT_MACROS, MAX_CHARACTER_MACROS (120, 18)
--   MS.spellNames[id] = "..."                 -- C_Spell.GetSpellName; nil: not cached
--   MS.refuse = true                          -- CreateMacro returns 0
--   MS.add(name, body, perChar)               -- a macro the player made
--   stub.inCombat = true                      -- InCombatLockdown (wow_stub.lua)

local MS = { list = {}, accountMax = 120, charMax = 18, spellNames = {}, refuse = false }
stub.macros = MS

local function counts()
	local acc, char = 0, 0
	for _, m in ipairs(MS.list) do
		if m.perChar then char = char + 1 else acc = acc + 1 end
	end
	return acc, char
end

-- Account macros are 1..120, the character's 121..138, as the client numbers them.
local function ordered()
	local out = {}
	for _, m in ipairs(MS.list) do if not m.perChar then out[#out + 1] = m end end
	local acc = #out
	local i = 0
	for _, m in ipairs(MS.list) do
		if m.perChar then
			i = i + 1
			out[MS.accountMax + i] = m
		end
	end
	return out, acc
end

function MS.add(name, body, perChar)
	MS.list[#MS.list + 1] = { name = name, icon = "INV_Misc_QuestionMark", body = body, perChar = perChar and true or false }
end

function MS.byName(name)
	for _, m in ipairs(MS.list) do if m.name == name then return m end end
end

MAX_ACCOUNT_MACROS, MAX_CHARACTER_MACROS = MS.accountMax, MS.charMax

function GetNumMacros() return counts() end

function GetMacroIndexByName(name)
	local o = ordered()
	for i, m in pairs(o) do if m.name == name then return i end end
	return 0
end

function GetMacroInfo(index)
	local m = ordered()[index]
	if m then return m.name, m.icon, m.body end
end

function CreateMacro(name, icon, body, perChar)
	if InCombatLockdown() then error("CreateMacro in combat") end
	if MS.refuse then return 0 end
	local acc, char = counts()
	if perChar and char >= MS.charMax then error("too many character macros") end
	if not perChar and acc >= MS.accountMax then error("too many account macros") end
	MS.add(name, body, perChar)
	stub.fire("UPDATE_MACROS")
	return GetMacroIndexByName(name)
end

function EditMacro(index, name, icon, body)
	if InCombatLockdown() then error("EditMacro in combat") end
	local m = ordered()[index]
	if not m then error("no macro " .. tostring(index)) end
	m.name = name or m.name
	if icon then m.icon = icon end
	m.body = body or m.body
	stub.fire("UPDATE_MACROS")
	return index
end

C_Spell = C_Spell or {}
function C_Spell.GetSpellName(id) return MS.spellNames[id] end
