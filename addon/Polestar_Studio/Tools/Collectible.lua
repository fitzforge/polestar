-- Collectible toolkit (spec 5.2): pick a mount, pet, toy or item, see where
-- it comes from (Polestar.Codex item sources) and lay that out: a vendor's
-- buy, a dropper's kill and the collect, a quest's accept and turn-in, a
-- container or object to open, a recipe to craft.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local ipairs, tostring, tonumber, format = ipairs, tostring, tonumber, string.format

local KINDS = { "mount", "pet", "item", "recipe", "tabard" }

local function itemItems(q)
	local out, seen = {}, {}
	for _, kind in ipairs(KINDS) do
		for _, r in ipairs(UI.SearchCodex(kind, q, 30)) do
			if not seen[r.id] then
				seen[r.id] = true
				out[#out + 1] = { text = r.name, sub = L[kind], value = r.id }
			end
		end
	end
	return out
end

local function name(kind, id)
	local X = S.Resolve.Codex()
	return X and X.Name and X.Name(kind, id) or tostring(id)
end

local function sourceText(s)
	if s.type == "vendor" then return format(L["Sold by %s"], name("npc", s.npc)) end
	if s.type == "drop" then return format(L["Drops from %s"], s.npc and name("npc", s.npc) or s.instance or "?") end
	if s.type == "object" then return format(L["Found in %s"], name("object", s.object)) end
	if s.type == "quest" then return format(L["Reward of %s"], name("quest", s.quest)) end
	if s.type == "gift" then return format(L["Given by %s"], name("npc", s.npc)) end
	if s.type == "craft" then return format(L["Crafted (%s)"], s.profession or "?") end
	if s.type == "rep" then return format(L["Reputation with %s"], name("faction", s.faction)) end
	if s.type == "container" then return format(L["Inside %s"], name("item", s.item)) end
	return L[s.type or "?"]
end

-- Each source as the goals that get it, in the selected step.
local function layout(item, s)
	if s.type == "vendor" then
		UI.Resolve("Buy", item, 1)
	elseif s.type == "drop" and s.npc then
		UI.Resolve("Kill", s.npc)
		UI.Resolve("Collect", item, 1, nil, nil, true)
	elseif s.type == "gift" and s.npc then
		UI.Resolve("Talk", s.npc)
		UI.Resolve("Collect", item, 1, nil, nil, true)
	elseif s.type == "object" and s.object then
		UI.Resolve("Interact", s.object)
		UI.Resolve("Collect", item, 1, nil, nil, true)
	elseif s.type == "quest" and s.quest then
		UI.Resolve("Accept", s.quest, true)
		UI.Resolve("Turnin", s.quest, s.choice and item or nil, true)
	elseif s.type == "container" and s.item then
		UI.Resolve("Use", s.item)
		UI.Resolve("Collect", item, 1, nil, nil, true)
	elseif s.type == "craft" and s.spell then
		local X = S.Resolve.Codex()
		local rec = X and X.Spell and X.Spell(s.spell)
		local spellName = rec and rec.name
		if not spellName then
			UI.Say(L["Polestar does not know that recipe's name."], "warning")
			return
		end
		UI.Add({ verb = "craft", args = { tostring(s.spell) }, mods = {} }, { t = "craft", spell = s.spell, spellName = spellName, item = item, skillLine = s.skillLine })
	elseif s.type == "rep" and s.faction then
		local fname = name("faction", s.faction)
		local standing = tonumber(s.standing) or 6
		UI.Add({ verb = "rep", args = { tostring(s.faction), UI.STANDINGS[standing] or tostring(standing) }, mods = {} },
			{ t = "rep", faction = s.faction, factionName = fname, standing = standing })
		if s.npc then UI.Resolve("Buy", item, 1) end
	else
		UI.Resolve("Collect", item, 1)
	end
end

local function pickSource(item)
	local X = S.Resolve.Codex()
	local rec = X and X.Item and X.Item(item)
	local items = {}
	for _, s in ipairs(rec and rec.sources or {}) do
		local sub = s.chance and format("%s%%", tostring(s.chance)) or (s.cost and tostring(s.cost)) or ""
		items[#items + 1] = { text = sourceText(s), sub = sub, value = s }
	end
	items[#items + 1] = { text = L["Just collect it"], value = false }
	UI.Pick({ title = rec and rec.name or tostring(item), hint = L["Where it comes from, as Polestar knows it."], items = items, onPick = function(it)
		if it.value then layout(item, it.value) else UI.Resolve("Collect", item, 1) end
	end })
end

S.Tools.Register({
	key = "sources", label = "Item and its sources", icon = "icon-collect", kit = "collectible",
	tip = "Pick a mount, pet or item: Studio lays out how to get it.",
	run = function()
		if not UI.Ready() then return end
		UI.Pick({ title = L["Which collectible?"], hint = L["Type part of its name."], items = itemItems, onPick = function(it)
			pickSource(it.value)
		end })
	end,
})

S.Tools.Register({
	key = "dropfarm", label = "Farm it from the target", icon = "icon-kill", kit = "collectible", belt = false,
	tip = "Kill the target until the item drops.",
	run = function()
		if not UI.Ready() then return end
		local kind, npc = S.Resolve.Entity("target")
		if kind ~= "npc" then
			UI.Say(L["Target a creature first."], "warning")
			return
		end
		local X = S.Resolve.Codex()
		local rec = X and X.Npc and X.Npc(npc)
		local items = {}
		for _, id in ipairs(rec and rec.loot or {}) do items[#items + 1] = { text = name("item", id), sub = tostring(id), value = id } end
		if #items == 0 then
			UI.Say(L["Polestar knows nothing it drops."], "warning")
			return
		end
		UI.Pick({ title = L["Which drop?"], items = items, onPick = function(it)
			UI.Resolve("Kill", "target")
			UI.Resolve("Collect", it.value, 1)
		end })
	end,
})
