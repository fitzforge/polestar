-- env: world
-- The Discovery page's Dungeons tab (Dungeons/Dungeons.lua; UI/Dungeons.lua, UI/DungeonToast.lua): the hub's
-- Dungeons section opened, and a level-up into a dungeon's range. The Dungeons pack's data (built from the
-- client and the Codex, not in this world) is one dungeon's summary and pick-up plan in its place.
local w, UI
local level = 13
return {
	setup = function()
		w, UI = stub.world, Polestar.UI
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 45, 50)
		w.setLevel(level)
		local Dg = Polestar.Dungeons
		Dg.List = function()
			return { { key = "rfc", name = "Ragefire Chasm", zoneName = "Orgrimmar", kind = "dungeon", minLevel = 13, maxLevel = 22, quests = { A = 3, H = 3 } } }
		end
		Dg.PickupPlan = function() return { take = { {}, {}, {} }, later = 0, waiting = {} } end
	end,
	probes = {
		-- The hub's Dungeons section, as it opens.
		["dungeons.enabled"] = function()
			local DS = UI.DungeonsSection
			DS.Show(nil)
			DS.Render()
			local _, home = DS.Frames()
			local out = home and home:IsVisible() and home.EmptyTitle:GetText() or false
			if PolestarPicker then PolestarPicker:Hide() end
			return out
		end,
		-- A level-up into the dungeon's range: its heads-up card ("Ragefire Chasm is open to you").
		["dungeons.headsUp"] = function()
			local CT = UI.ClassToast
			Polestar.CharState().dungeonToastSeen = {}
			level = level + 1
			w.setLevel(level)
			stub.advance(2)
			local out = CT.current and CT.frame and CT.frame:IsShown() and CT.frame.Title:GetText() or false
			CT.Hide()
			stub.advance(0.1)
			return out
		end,
	},
}
