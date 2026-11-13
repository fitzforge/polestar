-- env: world
-- The Guide page's Dynamic Questing > Gathering spots (Core/Engine.lua, Own.hereGather*; Core/Gather.lua) on the whole
-- addon, as engine-gather-spots.rs plays it: a herbalist on a guide whose one step is far away, and a spot at 40,50
-- where Peacebloom can grow (Core/Gather.lua's data: x, then y, two base-60 digits each in 3599ths of the map).
local w, GF, H
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
local function at(x, y) w.moveTo(1429, x, y); stub.advance(0.6) end
-- The window's While you're here panel, standing (x, y): its line, or nothing.
local function panel(x, y)
	at(x, y)
	local row = H.Rows and H.Rows[1]
	local out = H:IsShown() and row and plain(row.Text:GetText()) or false
	at(70, 80)
	return out
end
return {
	setup = function()
		w, GF = stub.world, Polestar.UI.GuideFrame
		H = GF.parts.here
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.setLevel(5)
		w.setZone("Elwynn Forest", "")
		w.moveTo(1429, 70, 80)
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/gather", pack = "test", title = "Gather", minLevel = 1, maxLevel = 10, steps = {
			{ title = "Far away", goals = { { t = "goto", map = 1429, x = 90, y = 90 } } },
		} })
		Polestar.Engine.SetGuide("test/gather")
		Polestar.MapFrames.era[1429] = { c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }
		w.learnSkill(182, "Herbalism", 1, 75)
		Polestar.Gather.Register({ kinds = { { "Peacebloom", 182, 1, 1618 } }, maps = { [1429] = "e;1:O0U0" } })
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.6)
	end,
	settle = 0.3,
	probes = {
		-- 6 yd from the Peacebloom spot: its line.
		["behavior.whileHereGather"] = function() return panel(40.2, 50) end,
	},
}
