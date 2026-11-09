-- Kill (spec 5.1): `kill <npc> xN quest Q.O` from the target and the quest
-- log's objectives (several objectives: pick one).

local ADDON, S = ...
local L = S.L
local UI = S.UI
local format, ipairs = string.format, ipairs

S.Tools.Register({
	key = "kill", label = "Kill the target", icon = "icon-kill", kit = "core",
	tip = "A kill goal for your target, linked to the quest objective it serves.",
	run = function()
		if not UI.Ready() then return end
		if not UnitExists("target") then
			UI.Say(L["Target a creature first."], "warning")
			return
		end
		local _, id, name
		if S.Resolve.Entity then _, id, name = S.Resolve.Entity("target") end
		local kills = {}
		for _, o in ipairs(id and UI.ObjectivesFor(id, name) or {}) do
			if o.kind == "kill" then kills[#kills + 1] = o end
		end
		if #kills <= 1 then
			local o = kills[1]
			if o then UI.Resolve("Kill", "target", o.count, o.quest, o.oi) else UI.Resolve("Kill", "target") end
			return
		end
		local items = {}
		for _, o in ipairs(kills) do
			items[#items + 1] = { text = o.text ~= "" and o.text or (o.title or "?"), sub = format("quest %d.%d", o.quest, o.oi), value = o }
		end
		items[#items + 1] = { text = L["No quest: just kill it"], value = false }
		UI.Pick({ title = L["Which objective?"], items = items, onPick = function(it)
			local o = it.value
			if o then UI.Resolve("Kill", "target", o.count, o.quest, o.oi) else UI.Resolve("Kill", "target") end
		end })
	end,
})
