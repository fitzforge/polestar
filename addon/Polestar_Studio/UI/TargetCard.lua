-- Target card (spec 4.3): the current target (or, without one, the
-- mouseover): name, NPC id, level, elite/rare, faction, the quest objectives
-- it serves (quest log and Codex), what it drops (Codex), and buttons that
-- add Kill, Mark, Collect from this, Talk, Boss and Area goals.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local P = _G.Polestar
local Theme, W = UI.Theme, UI.W
local format, ipairs, pairs, tostring, concat = string.format, ipairs, pairs, tostring, table.concat

local DOT = "  \194\183  "
local card

local function unitShown()
	if UnitExists("target") then return "target" end
	if UnitExists("mouseover") then return "mouseover" end
	return nil
end

local function codex()
	local C = P.Codex
	if C and C.Load then C.Load() end
	return C
end

-- The quest objectives in the log this NPC serves: { { quest, oi, text, kind } }
function UI.ObjectivesFor(npcId, name)
	local out = {}
	local C = codex()
	local rec = npcId and C and C.Npc and C.Npc(npcId)
	local drops = {}
	for _, it in ipairs(rec and rec.loot or {}) do drops[it] = true end
	local Compat = P.Compat
	for _, q in ipairs(S.Resolve.QuestLog and S.Resolve.QuestLog() or {}) do
		local qrec = C and C.Quest and C.Quest(q)
		local live = Compat and Compat.GetQuestObjectives and Compat.GetQuestObjectives(q)
		for o, obj in ipairs(qrec and qrec.objectives or {}) do
			if (obj.type == "kill" and obj.id == npcId) or (obj.type == "item" and drops[obj.id]) then
				local text = live and live[o] and live[o].text or obj.text or ""
				out[#out + 1] = { quest = q, oi = o, text = text, kind = obj.type, id = obj.id, count = obj.count, title = qrec.title }
			end
		end
		if not qrec and live and name then
			for o, obj in ipairs(live) do
				if obj.text and obj.text:find(name, 1, true) then
					out[#out + 1] = { quest = q, oi = o, text = obj.text, kind = obj.type == "item" and "item" or "kill", count = obj.numRequired }
				end
			end
		end
	end
	return out
end

local function refresh()
	local f = card
	if not f or not f:IsShown() then return end
	local unit = unitShown()
	f.psUnit = unit
	local kind, id, name
	if unit and S.Resolve.Entity then kind, id, name = S.Resolve.Entity(unit) end
	if not unit or not kind then
		f.Name:SetText(L["No target"])
		f.Info:SetText(L["Target or point at a creature to see what it is for."])
		f.Quests:SetText("")
		f.Drops:SetText("")
		for _, b in ipairs(f.Actions) do b:Disable() end
		return
	end
	for _, b in ipairs(f.Actions) do b:Enable() end
	local C = codex()
	local rec = kind == "npc" and C and C.Npc and C.Npc(id) or (kind == "object" and C and C.Object and C.Object(id)) or nil
	f.psKind, f.psId, f.psName, f.psRec = kind, id, name, rec
	f.Name:SetText(name or (rec and rec.name) or "?")
	W.Color(f.Name, kind == "npc" and "npc" or "object")
	local parts = { format("%s %d", kind == "npc" and L["NPC"] or L["Object"], id) }
	local lvl = UnitLevel and UnitLevel(unit)
	if lvl and lvl > 0 then parts[#parts + 1] = format(L["level %d"], lvl)
	elseif rec and rec.level then parts[#parts + 1] = format(L["level %d"], rec.level) end
	local class = UnitClassification and UnitClassification(unit)
	if class == "elite" or class == "worldboss" or (rec and rec.elite) then parts[#parts + 1] = L["Elite"] end
	if class == "rare" or class == "rareelite" or (rec and rec.rare) then parts[#parts + 1] = L["Rare"] end
	if rec and rec.boss then parts[#parts + 1] = L["Boss"] end
	if UnitIsEnemy and UnitIsEnemy("player", unit) then parts[#parts + 1] = L["Hostile"]
	elseif UnitIsFriend and UnitIsFriend("player", unit) then parts[#parts + 1] = L["Friendly"] end
	if rec and rec.faction then parts[#parts + 1] = rec.faction end
	f.Info:SetText(concat(parts, DOT))
	local objs = kind == "npc" and UI.ObjectivesFor(id, name) or {}
	f.psObjs = objs
	if #objs > 0 then
		local lines = {}
		for _, o in ipairs(objs) do lines[#lines + 1] = format("%s  (%d.%d)", o.text ~= "" and o.text or (o.title or ""), o.quest, o.oi) end
		f.Quests:SetText(L["Quests: "] .. concat(lines, "; "))
	else
		f.Quests:SetText(L["Serves no quest in your log."])
	end
	local loot = rec and rec.loot or {}
	if #loot > 0 then
		local names = {}
		for k = 1, math.min(6, #loot) do names[#names + 1] = (C.Name and C.Name("item", loot[k])) or tostring(loot[k]) end
		f.Drops:SetText(L["Drops: "] .. concat(names, ", ") .. (#loot > 6 and format(L[" and %d more"], #loot - 6) or ""))
	else
		f.Drops:SetText(L["Drops: nothing Polestar knows."])
	end
	f.Boss:SetShown(rec and rec.boss and true or false)
end

local function collectFrom(anchor)
	local f = card
	local C = codex()
	local items = {}
	for _, o in ipairs(f.psObjs or {}) do
		if o.kind == "item" and o.id then
			items[#items + 1] = { text = (C.Name and C.Name("item", o.id)) or tostring(o.id), sub = format("quest %d.%d", o.quest, o.oi), value = o }
		end
	end
	for _, it in ipairs(f.psRec and f.psRec.loot or {}) do
		items[#items + 1] = { text = (C.Name and C.Name("item", it)) or tostring(it), sub = tostring(it), value = { id = it } }
	end
	if #items == 0 then
		UI.Say(L["Polestar knows nothing it drops."], "warning")
		return
	end
	UI.Pick({ title = L["Collect from this"], items = items, onPick = function(it)
		local o = it.value
		UI.Resolve("Collect", o.id, o.count, o.quest, o.oi)
	end })
end

UI.Widget("TargetCard", "Target card", 320, 214, function(f)
	card = f
	local b = f.Body
	f.Name = W.Text(b, "name", "npc")
	f.Name:SetPoint("TOPLEFT", b, "TOPLEFT", 12, -10)
	f.Name:SetPoint("RIGHT", b, "RIGHT", -12, 0)
	f.Info = UI.Text(b, "small", "textDim", true)
	f.Info:SetPoint("TOPLEFT", f.Name, "BOTTOMLEFT", 0, -4)
	f.Info:SetPoint("RIGHT", b, "RIGHT", -12, 0)
	f.Quests = UI.Text(b, "small", "quest", true)
	f.Quests:SetPoint("TOPLEFT", f.Info, "BOTTOMLEFT", 0, -6)
	f.Quests:SetPoint("RIGHT", b, "RIGHT", -12, 0)
	f.Quests:SetHeight(28)
	f.Drops = UI.Text(b, "small", "item", true)
	f.Drops:SetPoint("TOPLEFT", f.Quests, "BOTTOMLEFT", 0, -4)
	f.Drops:SetPoint("RIGHT", b, "RIGHT", -12, 0)
	f.Drops:SetHeight(28)
	local function unit() return f.psUnit or "target" end
	local function kill()
		local o
		for _, x in ipairs(f.psObjs or {}) do if x.kind == "kill" then o = x break end end
		if o then UI.Resolve("Kill", unit(), o.count, o.quest, o.oi) else UI.Resolve("Kill", unit()) end
	end
	f.Actions = {}
	local defs = {
		{ L["Kill goal"], kill },
		{ L["Mark"], function(self) UI.IconPicker(self, function(n)
			UI.Prompt({ title = L["Mark"], label = L["A note on the mark (optional), such as \"pull first\"."], onAccept = function(text)
				UI.Resolve("Mark", unit(), n, text ~= "" and text or nil)
			end })
		end) end },
		{ L["Collect from this"], function(self) collectFrom(self) end },
		{ L["Talk"], function() if f.psKind == "object" then UI.Resolve("Interact", f.psId) else UI.Resolve("Talk", unit()) end end },
		{ L["Area"], function() UI.Resolve("Area", f.psId) end },
	}
	local x, y = 12, -110
	for k, d in ipairs(defs) do
		local btn = W.Button(b, d[1], d[2], { height = 24 })
		btn:SetPoint("TOPLEFT", b, "TOPLEFT", x, y)
		x = x + btn:GetWidth() + 6
		if x > 230 then x, y = 12, y - 30 end
		f.Actions[k] = btn
	end
	f.Boss = W.Button(b, L["Boss goal"], function() UI.Resolve("Boss", unit()) end, { height = 24, primary = true })
	f.Boss:SetPoint("TOPLEFT", b, "TOPLEFT", x, y)
	f.Actions[#f.Actions + 1] = f.Boss
	f.Refresh = refresh
	f:HookScript("OnShow", refresh)
	S.RegisterEvent("PLAYER_TARGET_CHANGED", refresh)
	S.RegisterEvent("UPDATE_MOUSEOVER_UNIT", function() if not UnitExists("target") then refresh() end end)
	S.RegisterEvent("QUEST_LOG_UPDATE", refresh)
end, { point = { "LEFT", "LEFT", 40, 120 } })
