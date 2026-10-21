-- Add back: what the player turned down earlier, to put on the route again
-- from the guide window's "+" button (UI/GuideFrame.lua) at any time, for
-- example when someone asks for an elite quest or a dungeon in chat:
--   group   a group quest answered "Skip it" (Engine.GroupAnswer), not yet
--           turned in; + answers "do", so its `when group` steps come back
--   dungeon a dungeon (Dungeons.List, kind "dungeon") in the character's
--           levels, not on for leveling guides; + turns it on
--           (Engine.ChooseDungeon) and opens its pick-up guide (Dungeons.PickUp)
--   class   a Class guide that is open for the character but was dismissed or
--           put off ("Later") at its banner, not started; + opens it in a tab
-- A step the route has passed keeps its outcome (Engine, Own.latchWhen), so
-- adding a quest back changes the steps still ahead.
--
-- The button shows while a guide is loaded and ui.addBackButton is on
-- (Options, Guide, Window, What it shows: "Add back button").
--
--   AddBack.Items() -> { { kind, id, title, sub }, ... }  group, then dungeon, then class
--   AddBack.Add(item)

local ADDON, ns = ...

local AddBack = {}
ns.AddBack = AddBack

ns.RegisterDefaults("ui", { addBackButton = true })

local function level()
	local ok, player = pcall(ns.Compat.GetPlayerInfo)
	return ok and type(player) == "table" and player.level or 1
end

function AddBack.Items()
	local out = {}
	local E, C = ns.Engine, ns.Compat
	if E and E.GroupQuests and E.GroupAnswer then
		for _, g in ipairs(E.GroupQuests()) do
			if E.GroupAnswer(g.quest) == "skip" and not (C.IsQuestCompleted and C.IsQuestCompleted(g.quest)) then
				out[#out + 1] = { kind = "group", id = g.quest, title = g.title or tostring(g.quest) }
			end
		end
	end
	local D = ns.Dungeons
	if D and D.IsEnabled and D.IsEnabled() and D.List and E and E.DungeonChosen then
		local lvl = level()
		for _, d in ipairs(D.List()) do
			if d.kind == "dungeon" and d.map and d.minLevel and lvl >= d.minLevel and lvl <= (d.maxLevel or 60)
				and not E.DungeonChosen(d.map) then
				out[#out + 1] = { kind = "dungeon", id = d.key, map = d.map, title = d.name or d.key, minLevel = d.minLevel, maxLevel = d.maxLevel }
			end
		end
	end
	local CQ = ns.QoL and ns.QoL.ClassQuests
	if CQ and CQ.Passed then
		for _, g in ipairs(CQ.Passed()) do
			out[#out + 1] = { kind = "class", id = g.id, title = g.title or g.id }
		end
	end
	return out
end

function AddBack.Add(item)
	local E = ns.Engine
	if not (item and E) then return end
	if item.kind == "group" then
		if E.AnswerGroup then E.AnswerGroup(item.id, "do") end
	elseif item.kind == "dungeon" then
		if E.ChooseDungeon then E.ChooseDungeon(item.map, true) end
		local D = ns.Dungeons
		if D and D.PickUp then D.PickUp(item.id) end
	elseif item.kind == "class" then
		if E.OpenTab then E.OpenTab(item.id) end
	end
end
