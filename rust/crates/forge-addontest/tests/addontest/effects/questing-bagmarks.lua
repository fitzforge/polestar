-- env: world stub_quests.lua stub_gear.lua
-- questdb: fixture
-- The Questing page's quest marks on bag items (Quests/BagMarks.lua) on the fixture database: Kobold Candles in the
-- log, eight Large Candles in the first bag, the client's bags opened (stub_gear.lua's container frames).
local g
return {
	setup = function()
		local w = stub.world
		g = stub.gear
		-- The client's item id of a bag slot (C_Container.GetContainerItemID), from the stub's own bag contents.
		C_Container.GetContainerItemID = function(bag, slot)
			local link = C_Container.GetContainerItemLink(bag, slot)
			return link and tonumber(link:match("item:(%d+)")) or nil
		end
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 48, 40)
		w.complete({ 783 })
		w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
		g.bag(0, 2, "item:772")
		stub.advance(0.3)
	end,
	probes = {
		["qol.questBagMarks"] = function()
			g.openBag(0)
			stub.advance(0.2)
			for _, r in ipairs(g.bagButton(0, 2).regions or {}) do
				if type(r.texture) == "string" and r.texture:find("ActiveQuestIcon") and r:IsShown() then return true end
			end
			return false
		end,
	},
}
