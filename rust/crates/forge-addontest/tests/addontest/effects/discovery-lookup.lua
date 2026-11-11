-- env: world stub_lookup_runtime.lua
-- codex: lookup.json
-- The Discovery page's Lookup tab (Lookup/Options.lua, Spotter.lua, Guide.lua): a level 20 human warrior in the
-- Lookup fixture's Amber Vale (lookup.rs) hovers an item and a mounted player and Alt-clicks an item link; what
-- the tooltips say and whether a guide opens.
local w
local function link(id) return "|cffffffff|Hitem:" .. id .. "::::::::20:::::|h[x]|h|r" end
-- The item tooltip's lines for the Amber Strider (a mount a vendor sells).
local function itemTip()
	GameTooltip:SetOwner(UIParent)
	lookuprt.showItem(GameTooltip, 8000, link(8000))
	return table.concat(GameTooltip.lines, " / ")
end
local function tabOf(id)
	for i, t in ipairs(Polestar.Engine.GetTabs()) do if t.guideId == id then return i end end
end
return {
	setup = function()
		w = stub.world
		w.addMap(9001, { name = "Amber Vale", c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 })
		w.addMap(9002, { name = "Ember Hollow", c = 0, left = -1000, right = -3000, top = 1000, bottom = -1000 })
		w.addMap(9003, { name = "Frost Isle", c = 1, left = 1000, right = -1000, top = 1000, bottom = -1000 })
		w.setLevel(20)
		w.moveTo(9001, 50, 50)
		-- A player on the Amber Strider, targeted.
		lookuprt.units.target = { guid = "Player-1-0000BEEF", player = true }
		lookuprt.auras.target = { { spellId = 1243, name = "Fortitude" }, { spellId = 9500, name = "Amber Strider", icon = 132226 } }
	end,
	probes = {
		["lookup.enabled"] = itemTip,
		["lookup.tooltip"] = itemTip,
		-- Alt-click an item link: a guide that gets it opens in a tab (closed again after).
		["lookup.altClick"] = function()
			stub.keys.alt = true
			lookuprt.clickItem(link(8004))
			stub.keys.alt = false
			stub.advance(0.1)
			local i = tabOf("lookup/item/8004")
			if i then Polestar.Engine.CloseTab(i, true) end
			return i ~= nil
		end,
		-- Hovering the mounted player: the mount and where it comes from.
		["lookup.mounts"] = function()
			GameTooltip:SetOwner(UIParent)
			lookuprt.showUnit(GameTooltip, "target")
			return table.concat(GameTooltip.lines, " / ")
		end,
	},
}
