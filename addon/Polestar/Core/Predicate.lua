-- Core/Predicate.lua: the closed, declarative condition language a format-2
-- guide uses in `when` lines. Predicates are plain Lua tables in prefix form
-- (never code); Validate rejects anything outside the whitelist and Eval
-- answers them against the live character through ns.Compat.
-- Contract: docs/ARCHITECTURE.md, "Predicate".

local ADDON, ns = ...

local P = {}
ns.Predicate = P

local type, pcall, tostring, math = type, pcall, tostring, math

local function Compat() return ns.Compat end

---------------------------------------------------------------------------
-- The whitelist: node names, the exact length each well-formed node has
-- (name + arguments), and the comparison operators.
---------------------------------------------------------------------------

local OPS = { [">="] = true, [">"] = true, ["<="] = true, ["<"] = true, ["=="] = true, ["~="] = true }

-- Combinators take any number of children (zero is fine), so they carry no
-- fixed length; everything else is fixed-length. Nesting is capped so a guide
-- cannot build a runaway tree.
local ARITY = {
	["all"] = 0, ["any"] = 0,
	onquest = 2, ready = 2, turnedin = 2,
	item = 4, level = 3, skill = 4, rep = 4,
	class = 2, race = 2, faction = 2, zone = 2,
	done = 2,
	["not"] = 2,
}

local MAX_DEPTH = 16

local function positiveInt(v)
	return type(v) == "number" and math.floor(v) == v and v > 0
end

local function nonNegativeInt(v)
	return type(v) == "number" and math.floor(v) == v and v >= 0
end

local function isOp(op)
	return type(op) == "string" and OPS[op] == true
end

local function isStringList(v)
	if type(v) ~= "table" or #v == 0 then return false end
	for i = 1, #v do
		if type(v[i]) ~= "string" then return false end
	end
	return true
end

local function compare(op, a, b)
	if op == ">=" then return a >= b end
	if op == ">" then return a > b end
	if op == "<=" then return a <= b end
	if op == "<" then return a < b end
	if op == "==" then return a == b end
	return a ~= b
end

function P.Validate(node, depth)
	depth = depth or 1
	if depth > MAX_DEPTH then return false, "nesting is deeper than 16 levels" end
	if type(node) ~= "table" then return false, "predicate must be a table" end
	local kind = node[1]
	if type(kind) ~= "string" or ARITY[kind] == nil then
		return false, "unknown predicate '" .. tostring(kind) .. "'"
	end
	if kind == "all" or kind == "any" then
		for i = 2, #node do
			local ok, err = P.Validate(node[i], depth + 1)
			if not ok then return false, err end
		end
		return true
	end
	if #node ~= ARITY[kind] then
		return false, ("predicate '%s' takes exactly %d argument(s)"):format(kind, ARITY[kind] - 1)
	end
	if kind == "not" then
		return P.Validate(node[2], depth + 1)
	elseif kind == "onquest" or kind == "ready" or kind == "turnedin" then
		if not positiveInt(node[2]) then return false, kind .. " needs a positive integer quest ID" end
	elseif kind == "item" then
		if not positiveInt(node[2]) then return false, "item needs a positive integer item ID" end
		if not isOp(node[3]) then return false, "item needs a comparison operator" end
		if not nonNegativeInt(node[4]) then return false, "item count must be a non-negative integer" end
	elseif kind == "level" then
		if not isOp(node[2]) then return false, "level needs a comparison operator" end
		if not nonNegativeInt(node[3]) then return false, "level must be a non-negative integer" end
	elseif kind == "skill" then
		if not positiveInt(node[2]) then return false, "skill needs a positive integer skill line ID" end
		if not isOp(node[3]) then return false, "skill needs a comparison operator" end
		if not nonNegativeInt(node[4]) then return false, "skill rank must be a non-negative integer" end
	elseif kind == "rep" then
		if not positiveInt(node[2]) then return false, "rep needs a positive integer faction ID" end
		if not isOp(node[3]) then return false, "rep needs a comparison operator" end
		if not (nonNegativeInt(node[4]) and node[4] >= 1 and node[4] <= 8) then
			return false, "rep standing must be an integer from 1 (Hated) to 8 (Exalted)"
		end
	elseif kind == "class" or kind == "race" then
		if not isStringList(node[2]) then return false, kind .. " needs a non-empty list of names" end
	elseif kind == "faction" then
		if node[2] ~= "Alliance" and node[2] ~= "Horde" then return false, "faction must be 'Alliance' or 'Horde'" end
	elseif kind == "zone" then
		if type(node[2]) ~= "string" or node[2] == "" then return false, "zone must be a non-empty string" end
	elseif kind == "done" then
		if type(node[2]) ~= "string" or node[2] == "" then return false, "done needs a step label" end
	end
	return true
end

---------------------------------------------------------------------------
-- Evaluation. One env memoises each distinct lookup for one pass, so a guide
-- that asks the same question in several `when` lines asks the client once.
-- Values are wrapped ({ v = ... }) so a cached nil is still a cache hit; the
-- key is the lookup kind plus its id, e.g. "onquest:7".
---------------------------------------------------------------------------

function P.NewEnv()
	return {}
end

-- One env per Engine evaluation pass: every `when` asked during a pass
-- sees the same answers, and the client is asked once per question.
local passEnv = nil
function P.NewPass() passEnv = P.NewEnv() return passEnv end
function P.PassEnv() if not passEnv then passEnv = P.NewEnv() end return passEnv end

local function lookup(env, key, fn)
	local hit = env[key]
	if hit ~= nil then return hit.v end
	local v = fn()
	env[key] = { v = v }
	return v
end

local doneResolver = nil
-- The Engine answers "is the step labelled X done?" for `done` atoms.
function P.SetDoneResolver(fn) doneResolver = fn end

local function player(env)
	return lookup(env, "player", function() return Compat().GetPlayerInfo() end)
end

local function inList(list, value)
	for i = 1, #list do
		if list[i] == value then return true end
	end
	return false
end

local function evalNode(node, env)
	if type(node) ~= "table" then return false end
	local kind = node[1]
	if kind == "all" then
		for i = 2, #node do
			if not evalNode(node[i], env) then return false end
		end
		return true
	elseif kind == "any" then
		for i = 2, #node do
			if evalNode(node[i], env) then return true end
		end
		return false
	elseif kind == "not" then
		return not evalNode(node[2], env)
	elseif kind == "onquest" then
		local q = node[2]
		return lookup(env, "onquest:" .. q, function() return Compat().IsOnQuest(q) end) and true or false
	elseif kind == "ready" then
		local q = node[2]
		return lookup(env, "ready:" .. q, function() return Compat().IsQuestReadyForTurnIn(q) end) and true or false
	elseif kind == "turnedin" then
		local q = node[2]
		return lookup(env, "turnedin:" .. q, function() return Compat().IsQuestCompleted(q) end) and true or false
	elseif kind == "item" then
		local id = node[2]
		local count = lookup(env, "item:" .. id, function() return Compat().GetItemCount(id) end) or 0
		return compare(node[3], count, node[4])
	elseif kind == "level" then
		local info = player(env)
		return compare(node[2], (info and info.level) or 0, node[3])
	elseif kind == "class" then
		local info = player(env)
		return info and inList(node[2], info.class) and true or false
	elseif kind == "race" then
		local info = player(env)
		return info and inList(node[2], info.race) and true or false
	elseif kind == "faction" then
		local info = player(env)
		return info and info.faction == node[2] and true or false
	elseif kind == "zone" then
		if type(node[2]) ~= "string" then return false end
		local zone = lookup(env, "zone", function() return Compat().GetZoneText() end)
		if type(zone) ~= "string" then return false end
		return zone:lower() == node[2]:lower()
	elseif kind == "skill" then
		local id = node[2]
		local rank = lookup(env, "skill:" .. id, function() return Compat().GetSkillRank(id) or 0 end) or 0
		return compare(node[3], rank, node[4])
	elseif kind == "done" then
		local label = node[2]
		if not doneResolver then return false end
		return lookup(env, "done:" .. label, function()
			local ok, v = pcall(doneResolver, label)
			return ok and v and true or false
		end)
	elseif kind == "rep" then
		local id = node[2]
		local standing = lookup(env, "rep:" .. id, function() return Compat().GetFactionStanding(id) end)
		if not standing then return false end
		return compare(node[3], standing, node[4])
	end
	return false
end

-- Never raises: a malformed or unknown node, or a Compat call that throws,
-- answers false. The result is always a strict boolean.
function P.Eval(node, env)
	if not env then env = P.NewEnv() end
	local ok, result = pcall(evalNode, node, env)
	if not ok then return false end
	return result and true or false
end
