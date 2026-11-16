-- env: world
-- The Guide page's Dynamic Questing > Sell and repair reminders (Core/Engine.lua, Own.hereVendor*; Nav/Nearby.lua's
-- places) on the whole addon, as engine-sell-repair.rs plays it: in Goldshire, the route's live step out at the farm
-- 690 yd off, Brog Hamfist selling 30 yd east and Corina Steele repairing 15 yd west. Each probe sets the bags (a
-- 16-slot backpack) and the gear's wear it reads with, comes into town from 500 yd out (a new visit: a reminder
-- shows once per visit) and reads the window's While you're here panel.
local w, GF, H
local free, worn = 16, 100
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
local function at(x, y) w.moveTo(1429, x, y); stub.advance(0.6) end
-- The panel's first line in town with `slots` free and the gear at `pct`, or nothing.
local function panel(slots, pct)
	free, worn = slots, pct
	stub.fire("BAG_UPDATE_DELAYED")
	stub.fire("UPDATE_INVENTORY_DURABILITY")
	at(42, 90)
	at(42, 65)
	local row = H.Rows and H.Rows[1]
	local out = H:IsShown() and row and plain(row.Text:GetText()) or false
	at(42, 90)
	return out
end
return {
	setup = function()
		w, GF = stub.world, Polestar.UI.GuideFrame
		H = GF.parts.here
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.setLevel(10)
		w.setZone("Elwynn Forest", "Goldshire")
		w.resting = true
		w.moveTo(1429, 42, 65)
		C_Container = C_Container or {}
		C_Container.GetContainerNumSlots = function(bag) return bag == 0 and 16 or 0 end
		C_Container.GetContainerNumFreeSlots = function(bag) return bag == 0 and free or 0, 0 end
		GetInventoryItemDurability = function(slot) if slot == 5 then return worn, 100 end end
		local npcs = {
			[101] = { id = 101, name = "Corina Steele", subName = "Weaponsmith", faction = "A", spawns = { { map = 1429, x = 41.5, y = 65 } } },
			[102] = { id = 102, name = "Brog Hamfist", subName = "General Supplies", faction = "A", spawns = { { map = 1429, x = 43, y = 65 } } },
		}
		local roles = { repair = { 101 }, vendor = { 102 } }
		Polestar.Codex = {
			IsLoaded = function() return true end,
			Load = function() return true end,
			WithRole = function(r) return roles[r] or {} end,
			Npc = function(id) return npcs[id] end,
		}
		Polestar.MapFrames.era[1429] = { c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/sell", pack = "test", title = "Sell", minLevel = 1, maxLevel = 20, steps = {
			{ title = "The farm", goals = { { t = "goto", map = 1429, x = 60, y = 40 } } },
		} })
		Polestar.Engine.SetGuide("test/sell")
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.6)
	end,
	settle = 0.3,
	probes = {
		-- 2 slots free: Brog's line.
		["behavior.whileHereVendors"] = function() return panel(2, 100) end,
		-- 6 free and the gear at 20%: Corina's line, which says selling too once 16 slots are wanted.
		["behavior.whileHereSellSlots"] = function() return panel(6, 20) end,
		-- The gear at 40%, the bags with room: Corina's line once the setting is over 40%.
		["behavior.whileHereRepairPercent"] = function() return panel(16, 40) end,
	},
}
