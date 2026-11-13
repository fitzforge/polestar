-- env: world stub_gear.lua
-- The Questing page's gear advice (Gear/*.lua, UI/GearPick.lua, UI/GearScales.lua) and the step item's glow in
-- the bags (QoL/BagGlow.lua) on the whole addon against stub_gear.lua's items, bags and tooltips, as gear.rs,
-- gear-bags.rs, gear-upgrades.rs and qol-bagglow.rs play them: a level 22 Troll Warrior in the 9001 helm with a
-- better helm, a cloth cap, a plate helm for later, a cloak and better helms in the bags, a guide step
-- handing in a quest whose rewards include a helm, then one using an item in the bags.
local w, g, G, GF
local function arrow(button)
	for _, r in ipairs(button.regions or {}) do
		if type(r.texture) == "string" and r.texture:find("qol%-upgrade$") and r:IsShown() then return r end
	end
end
-- The bag slots with an upgrade arrow, the bag opened.
local function arrows()
	g.openBag(0)
	stub.advance(0.3)
	local out = {}
	for slot = 1, 16 do if arrow(g.bagButton(0, slot)) then out[#out + 1] = slot end end
	return table.concat(out, ",")
end
local function tip(link)
	for _, l in ipairs(g.showTooltip(GameTooltip, link)) do if l:find("^Polestar") or l:find("pick") then return l end end
	return false
end
local function wear(slot, link) g.equip(slot, link); G.Invalidate("equipment"); stub.advance(0.3) end
-- The guide window's reward pick under the hand-in.
local function pick()
	Polestar.Fire("STEP_UPDATED")
	stub.advance(0.3)
	for _, r in ipairs(GF.rows) do
		local f = r:IsShown() and r.psGearPick
		if f and f:IsShown() then return f.Text:GetText() end
	end
	return false
end
-- The bag slots glowing (the action button border), the bag opened.
local function glowing()
	g.openBag(0)
	stub.advance(0.2)
	local out = {}
	for slot = 1, 16 do
		for _, r in ipairs(g.bagButton(0, slot).regions or {}) do
			if r.texture == "Interface\\Buttons\\UI-ActionButton-Border" and r:IsShown() then out[#out + 1] = slot end
		end
	end
	return table.concat(out, ",")
end
return {
	setup = function()
		w, g, G, GF = stub.world, stub.gear, Polestar.Gear, Polestar.UI.GuideFrame
		w.race, w.raceName, w.raceID, w.faction = "Troll", "Troll", 8, "Horde"
		w.setLevel(22)
		Polestar.ItemDB.Register({ schema = 1, build = "test" }, {
			[9001] = "1 20 15 2 4 3 str5 sta3 armor150",
			[9002] = "1 25 20 2 4 3 str10 sta4 armor170",
			[9004] = "1 20 15 2 4 1 int10 spi5 armor30",
			[9005] = "1 35 30 2 4 4 str8 sta8 armor300",
			[9006] = "1 25 20 2 4 3 str10 sta4 armor170 crit1",
			[9007] = "1 25 20 2 4 3 str10 sta5 armor170",
			[9040] = "16 20 15 2 4 1 sta3",
			[9101] = "1 25 20 2 4 3 str10 sta6 armor180",
			[9102] = "1 25 20 2 4 1 int10 spi6 armor40",
			[9103] = "1 25 20 2 4 3 str10 sta6 armor180",
			[9106] = "13 25 20 2 2 4 str5 dmin20 dmax30 speed2000",
			[9110] = "17 25 20 2 2 1 str12 dmin50 dmax70 speed3300",
			[9111] = "14 25 20 2 4 6 sta4 armor600",
		})
		Polestar.ItemDB.RegisterLeveling({ source = "test" }, {
			names = { [9101] = "Militia Helm", [9102] = "Scholar Cap", [9103] = "Twin Helm" },
			src = { [9101] = "q5001", [9102] = "q5001", [9103] = "q5001" },
			quests = { [5001] = "20 15 1 12 0 0 0|9101,9102,9103||Alliance Choice" },
			npcs = {}, zones = { [12] = "Elwynn Forest" },
		})
		G.RefreshPlayer()
		wear(1, "item:9001")
		g.bag(0, 1, "item:9002"); g.bag(0, 2, "item:9004"); g.bag(0, 3, "item:9005"); g.bag(0, 4, "item:9040"); g.bag(0, 6, "item:9006")
		g.bag(0, 7, "item:10338")
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 48, 42)
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/gear", pack = "test", title = "Gear", minLevel = 1, maxLevel = 30, steps = {
			{ goals = { { t = "turnin", quest = 5001, title = "Alliance Choice", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
			{ goals = { { t = "use", item = 10338, itemName = "Fresh Zhevra Carcass", quest = 882, oi = 1, map = 1429, x = 50, y = 50 } } },
		} })
		w.onQuest(5001, { { required = 1, fulfilled = 1 } })
		w.onQuest(882, { { required = 1 } })
		Polestar.Engine.SetGuide("test/gear")
		stub.advance(0.5)
	end,
	settle = 0.3,
	probes = {
		["gear.enabled"] = arrows,
		["gear.bagArrows"] = arrows,
		["gear.hideForPawn"] = { prepare = function() stub.addonsLoaded.Pawn = true end, probe = arrows,
			cleanup = function() stub.addonsLoaded.Pawn = nil end },
		-- The better helm's tooltip: how much better than the worn one.
		["gear.tooltip"] = function() return tip("item:9002") end,
		["gear.spec.WARRIOR"] = { value = "protection", probe = function() return tip("item:9002") end },
		["Questing:Manage custom weights"] = { press = true,
			prepare = function() local f = Polestar.UI.ScalesView.frame; if f then f:Hide() end end,
			probe = function() local f = Polestar.UI.ScalesView.frame; return f ~= nil and f:IsShown() and true or false end,
			cleanup = function() local f = Polestar.UI.ScalesView.frame; if f then f:Hide() end end },
		["gear.rewards"] = function() return pick() end,
		-- A reward choice's tooltip, the Scholar Cap worn: the pick to take.
		["gear.pickTooltip"] = { prepare = function() wear(1, "item:9102") end, cleanup = function() wear(1, "item:9001") end, probe = function()
			local lines = g.showTooltip(GameTooltip, "item:9101")
			for _, l in ipairs(lines) do if l:find("pick") then return l end end
			return false
		end },
		-- The better helm worn: one a little better still (one stamina) is called an upgrade, or not under the threshold.
		["gear.minUpgrade"] = { prepare = function() wear(1, "item:9002"); g.bag(0, 9, "item:9007") end,
			cleanup = function() wear(1, "item:9001"); g.bag(0, 9, nil) end, probe = arrows },
		-- A two-hander worn: a one-hander's tooltip, paired with the shield in the bags or not.
		["gear.useBags"] = { prepare = function() wear(16, "item:9110"); g.bag(0, 8, "item:9111") end,
			cleanup = function() g.equip(16, nil); g.bag(0, 8, nil); G.Invalidate("equipment") end,
			probe = function() G.Invalidate("bags"); return tip("item:9106") end },
		-- The use step's item in the bags glows.
		["qol.bagGlow"] = { prepare = function() Polestar.Engine.Goto(2); stub.advance(0.3) end,
			cleanup = function() Polestar.Engine.Goto(1); stub.advance(0.3) end, probe = glowing },
	},
}
