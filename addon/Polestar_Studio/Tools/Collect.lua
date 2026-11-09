-- Collect (spec 5.1): `collect <item> xN quest Q.O`, the item picked from
-- the quest log's item objectives, the target's drops or the bags.
--
--   S.UI.BagItems() -> { { id, name, count } }

local ADDON, S = ...
local L = S.L
local UI = S.UI
local P = _G.Polestar
local format, ipairs, pairs, tostring = string.format, ipairs, pairs, tostring

function UI.BagItems()
	local out, seen = {}, {}
	local Cn = C_Container
	local numSlots = (Cn and Cn.GetContainerNumSlots) or GetContainerNumSlots
	local itemID = (Cn and Cn.GetContainerItemID) or GetContainerItemID
	if not (numSlots and itemID) then return out end
	for bag = 0, 4 do
		for slot = 1, numSlots(bag) or 0 do
			local id = itemID(bag, slot)
			if id and not seen[id] then
				seen[id] = true
				local name = GetItemInfo and GetItemInfo(id)
				out[#out + 1] = { id = id, name = name or tostring(id), count = GetItemCount and GetItemCount(id) or 1 }
			end
		end
	end
	table.sort(out, function(a, b) return a.name < b.name end)
	return out
end

local function itemName(id)
	local C = P.Codex
	return (GetItemInfo and GetItemInfo(id)) or (C and C.Name and C.Name("item", id)) or tostring(id)
end

-- Every item objective of the quests in the log.
function UI.ItemObjectives()
	local out = {}
	local C = P.Codex
	if C and C.Load then C.Load() end
	for _, q in ipairs(S.Resolve.QuestLog and S.Resolve.QuestLog() or {}) do
		local rec = C and C.Quest and C.Quest(q)
		for o, obj in ipairs(rec and rec.objectives or {}) do
			if obj.type == "item" and obj.id then
				out[#out + 1] = { id = obj.id, count = obj.count, quest = q, oi = o, title = rec.title }
			end
		end
	end
	return out
end

function UI.PickItem(title, onPick, opts)
	opts = opts or {}
	local items = {}
	if not opts.noQuests then
		for _, o in ipairs(UI.ItemObjectives()) do
			items[#items + 1] = { text = itemName(o.id), sub = format("quest %d.%d", o.quest, o.oi), value = o, icon = GetItemIcon and GetItemIcon(o.id), iconTint = false }
		end
	end
	if UnitExists("target") and S.Resolve.Entity then
		local kind, id = S.Resolve.Entity("target")
		local loot = kind and P.Codex and P.Codex.Loot and P.Codex.Loot(kind == "npc" and "npc" or "object", id) or {}
		for _, it in ipairs(loot) do
			items[#items + 1] = { text = itemName(it), sub = L["target drops"], value = { id = it }, icon = GetItemIcon and GetItemIcon(it), iconTint = false }
		end
	end
	for _, it in ipairs(UI.BagItems()) do
		items[#items + 1] = { text = it.name, sub = format(L["in bags x%d"], it.count), value = { id = it.id }, icon = GetItemIcon and GetItemIcon(it.id), iconTint = false }
	end
	UI.Pick({ title = title, items = function(q)
		local out = {}
		for _, it in ipairs(items) do
			if q == "" or it.text:lower():find(q, 1, true) then out[#out + 1] = it end
		end
		-- Any other item, from the Codex index.
		if #q >= 3 then
			for _, hit in ipairs(UI.SearchCodex("item", q, 30)) do
				out[#out + 1] = { text = hit.name, sub = tostring(hit.id), value = { id = hit.id } }
			end
		end
		return out
	end, hint = L["Quest items first, then the target's drops, your bags, and any item by name."], onPick = function(it) onPick(it.value) end })
end

S.Tools.Register({
	key = "collect", label = "Collect an item", icon = "icon-collect", kit = "core",
	tip = "Pick the item: a quest objective, the target's drop, or one in your bags.",
	run = function()
		if not UI.Ready() then return end
		UI.PickItem(L["Collect"], function(o)
			if o.quest then
				UI.Resolve("Collect", o.id, o.count, o.quest, o.oi)
			else
				UI.Prompt({ title = L["Collect"], label = L["How many? (blank: one)"], onAccept = function(text)
					UI.Resolve("Collect", o.id, tonumber(text))
				end })
			end
		end)
	end,
})
