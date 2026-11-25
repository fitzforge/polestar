local _, Free = ...
local ps = Polestar
local QoL = ps.QoL
local Buttons = QoL and QoL.Buttons
local Targets = {}
Free.Targets = Targets

local CAP = 8
local NPC_VERB = { talk = true, turnin = true, interact = true }

local function campSources(g, index)
	if not (g.t == "collect" and index and type(g.fromNpcsAt) == "string" and type(g.fromNpcs) == "table") then return end
	local at = 0
	for group in (g.fromNpcsAt .. ";"):gmatch("([^;]*);") do
		at = at + 1
		if at == index then
			if group == "" then return end
			local list = {}
			for slot in group:gmatch("%d+") do list[#list + 1] = g.fromNpcs[tonumber(slot)] end
			return list
		end
	end
end

local function goalNames(sources, entry)
	local g = entry.goal
	local out, seen = {}, {}
	local names = sources.Names
	local verb = g.t == "interact" and "talk" or g.t
	local item = g.t == "collect" and g.item and
		((names and names.Item and names.Item(g.item)) or sources.Codex.Name("item", g.item) or g.itemName)
	local line = entry.line
	local progress = line and (line.numRequired or 0) > 0 and { cur = line.numFulfilled or 0, max = line.numRequired } or nil
	local function add(id, fallback, chance)
		if #out >= CAP then return end
		local name = (names and id and names.Npc(id)) or (id and sources.Codex.Name("npc", id)) or fallback
		if Buttons.MacroSafeName(name) and not sources.Compat.Placeholder(name) and not seen[name] then
			local elite = type(g.group) == "table" and g.group.kind == "elite"
				or id and g.fromId == id and (tonumber(g.fromRank) or 0) > 0 or nil
			out[#out + 1] = { verb = verb, id = id, name = name, elite = elite, item = item or nil, progress = progress, chance = chance }
			seen[name] = true
		end
	end

	local camp = campSources(g, entry.spotIndex)
	local named = camp or g.fromNpcs
	for _, source in ipairs(named or {}) do add(source.npc, source.npcName) end
	if camp then return out end

	local fallback = (g.t == "kill" and not g.logLine and g.target) or (NPC_VERB[g.t] and not g.logLine and g.npcName)
	if g.npc or fallback then add(g.npc, fallback) end
	if g.t == "collect" and g.fromKind == "npc" then
		if g.fromId or g.from then add(g.fromId, g.from) end
		if g.fromAlsoId or g.fromAlso then add(g.fromAlsoId, g.fromAlso) end
	end
	if g.t == "collect" and #out == 0 and not g.npc and not named and g.fromKind ~= "object" and g.item then
		local qdb = sources.QuestDB
		local drops = qdb and qdb.IsLoaded and qdb.IsLoaded() and qdb.GetItemDroppers and qdb.GetItemDroppers(g.item)
		for _, drop in ipairs(drops or {}) do add(drop.id, drop.name, drop.chance) end
		if not drops and sources.Codex.Item then
			local item = sources.Codex.Item(g.item)
			for _, drop in ipairs(item and item.sources or {}) do
				if drop.type == "drop" and drop.npc then add(drop.npc, nil, drop.chance) end
			end
		end
	end
	return out
end

-- Include one name per objective before adding each objective's other sources.
function Targets.Collect(sources, goals)
	local out, seen, groups = {}, {}, {}
	if not Buttons then return out end
	for _, entry in ipairs(goals) do
		if not entry.goal.object then
			local list = goalNames(sources, entry)
			if #list > 0 then groups[#groups + 1] = list end
		end
	end
	for i = 1, CAP do
		for _, group in ipairs(groups) do
			local target = group[i]
			if target and not seen[target.name] then
				out[#out + 1] = target
				seen[target.name] = true
				if #out == CAP then return out end
			end
		end
	end
	return out
end

function Targets.Available()
	return Buttons and type(Buttons.SetTargetSource) == "function"
end

function Targets.Publish(entries)
	if Targets.Available() then Buttons.SetTargetSource(Targets, entries) end
end
