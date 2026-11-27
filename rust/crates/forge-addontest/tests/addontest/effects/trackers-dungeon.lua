-- env: world
-- The Trackers page's Dungeon tracker tab (Polestar_Options/UI/Looks/Trackers.lua; UI/Trackers.lua,
-- UI/DungeonTracker.lua, Dungeons/Run.lua) on the whole addon: inside a Wailing Caverns of our own with Leaders
-- of the Fang in the log, the guide window waiting out the dungeon; the live tracker read as drawn: its size,
-- ground, border and type, its list, whether it stays in a fight or inside, and whether it shows with no quest held.
local w
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function size(fs) return (select(2, fs:GetFont())) end
local function flags(fs) return select(3, fs:GetFont()) or "" end
local function tracker() return PolestarDungeonTracker end
local function ground(f) return { f.psBgAlpha or false, rgba(f.psSkin.bg) } end
local function border(f)
	local e = f.psBorder
	return { e ~= nil and e[1]:IsShown(), e ~= nil and rgba(e[1]) or false, e ~= nil and e[1]:GetHeight() or false }
end
local function shown() return PolestarDungeonTracker ~= nil and PolestarDungeonTracker:IsShown() end
local GEMS = { { text = "Gem of Cobrahn: 0/1", type = "item", required = 1 }, { text = "Gem of Anacondra: 0/1", type = "item", required = 1 } }
local function refresh() stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.3) end
return {
	setup = function()
		w = stub.world
		w.addMap(1413, { name = "The Barrens", c = 1, left = 1000, right = -1000, top = 1000, bottom = -1000 })
		w.moveTo(1413, 46, 36)
		local PAGE = { key = "wailing-caverns", name = "Wailing Caverns", map = 43, minLevel = 17, maxLevel = 24, players = 5,
			quests = { { id = 914, title = "Leaders of the Fang", objectives = { { k = "item", id = 9738, n = 1, name = "Gem of Cobrahn" },
				{ k = "item", id = 9739, n = 1, name = "Gem of Anacondra" } } } } }
		local BOSSES = {
			{ order = 1, name = "Lady Anacondra", npc = 3671, encounter = 585, quests = { { id = 914, how = "item", item = 9739 } } },
			{ order = 2, name = "Lord Cobrahn", npc = 3669, encounter = 586, quests = { { id = 914, how = "item", item = 9738 } } },
			{ order = 3, name = "Kresh", npc = 3653, encounter = 587 },
		}
		local D = Polestar.Dungeons
		D.Load = function() return true end
		D.Get = function(key) return key == PAGE.key and PAGE or nil end
		D.ForMap = function(map) return map == 43 and PAGE.key or nil end
		D.Quests = function(key) return key == PAGE.key and PAGE.quests or {} end
		D.Quest = function(key, id) return key == PAGE.key and id == 914 and PAGE.quests[1] or nil end
		D.Bosses = function(key) return key == PAGE.key and BOSSES or {} end
		Polestar.Compat.GetInstanceMapID = function() return w.inInstance and 43 or nil end
		w.onQuest(914, GEMS, "Leaders of the Fang")
		Polestar.Set("ui.shown", true)
		Polestar.Set("ui.instance", "hide")
		w.inInstance = true
		stub.fire("PLAYER_ENTERING_WORLD", false, false)
		stub.advance(0.5)
	end,
	settle = 0.3,
	probes = {
		["trackers.dungeon.enabled"] = shown,
		["trackers.dungeon.scale"] = function() return tracker():GetScale() end,
		["trackers.dungeon.width"] = function() return tracker():GetWidth() end,
		["trackers.dungeon.alpha"] = function() return tracker():GetAlpha() end,
		["trackers.dungeon.bgAlpha"] = function() return ground(tracker()) end,
		["trackers.dungeon.bg"] = function() return ground(tracker()) end,
		["trackers.dungeon.borderSize"] = function() return border(tracker()) end,
		["trackers.dungeon.border"] = function() return border(tracker()) end,
		["trackers.dungeon.titleSize"] = function() return size(tracker().psTracker.titles[1]) end,
		["trackers.dungeon.outline"] = function() return flags(tracker().psTracker.titles[1]) end,
		["trackers.dungeon.bodySize"] = function() return size(tracker().psTracker.bodies[1]) end,
		-- Only what is left: the list shorter.
		["trackers.dungeon.compact"] = function() return tracker():GetHeight() end,
		-- In a fight: kept, faded or gone.
		["trackers.dungeon.combat"] = { value = "hide",
			prepare = function() stub.inCombat = true; stub.fire("PLAYER_REGEN_DISABLED"); stub.advance(0.3) end, probe = shown,
			cleanup = function() stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(0.3) end },
		-- Inside (where it always is): kept or not.
		["trackers.dungeon.instance"] = shown,
		-- No quest held for the dungeon: its bosses alone, or nothing.
		["trackers.dungeon.bossesAlone"] = {
			prepare = function() w.abandon(914); refresh() end, probe = shown,
			cleanup = function() w.onQuest(914, GEMS, "Leaders of the Fang"); refresh() end },
	},
}
