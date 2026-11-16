-- env: world stub_party.lua
-- The Trackers page's Party panel tab (Polestar_Options/UI/Looks/Trackers.lua; UI/Trackers.lua, UI/PartyPanel.lua)
-- on the whole addon in a party with Ana, who runs Polestar (party.rs): a guide at its kobold step with Ana at 3/10
-- of Kobold Camp Cleanup; the live party panel with her row, read as drawn: its size, ground, border and type, and
-- whether it stays in a fight or inside a dungeon.
local w
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function size(fs) return (select(2, fs:GetFont())) end
local function flags(fs) return select(3, fs:GetFont()) or "" end
local function panel() return PolestarPartyPanel end
local function row() return PolestarPartyPanel.rows[1] end
local function ground(f) return { f.psBgAlpha or false, rgba(f.psSkin.bg) } end
local function border(f)
	local e = f.psBorder
	return { e ~= nil and e[1]:IsShown(), e ~= nil and rgba(e[1]) or false, e ~= nil and e[1]:GetHeight() or false }
end
local function shown() return PolestarPartyPanel ~= nil and PolestarPartyPanel:IsShown() end
return {
	setup = function()
		w = stub.world
		local p = stub.party
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 48.5, 42.5)
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/party", pack = "test", title = "Party", minLevel = 1, maxLevel = 10, steps = {
			{ title = "Kobolds", goals = {
				{ t = "kill", quest = 7, oi = 1, target = "Kobold Vermin", count = 10, map = 1429, x = 47, y = 35 },
			} },
		} })
		w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
		Polestar.Engine.SetGuide("test/party")
		stub.advance(0.5)
		p.join("Ana")
		p.onQuest.Ana = { [7] = true }
		p.receive("Ana-TestRealm", "1Y|0.3.5")
		stub.advance(1)
		p.receive("Ana-TestRealm", "1|7:3/10")
		stub.advance(6)
	end,
	settle = 0.3,
	probes = {
		["party.panel"] = shown,
		["trackers.party.scale"] = function() return panel():GetScale() end,
		["trackers.party.width"] = function() return panel():GetWidth() end,
		["trackers.party.alpha"] = function() return panel():GetAlpha() end,
		["trackers.party.bgAlpha"] = function() return ground(panel()) end,
		["trackers.party.bg"] = function() return ground(panel()) end,
		["trackers.party.borderSize"] = function() return border(panel()) end,
		["trackers.party.border"] = function() return border(panel()) end,
		["trackers.party.titleSize"] = function() return { size(panel().Title), size(row().Name) } end,
		["trackers.party.outline"] = function() return flags(row().Name) end,
		["trackers.party.bodySize"] = function() return size(row().Step) end,
		-- In a fight: as the guide window (which stays), or gone.
		["trackers.party.combat"] = { value = "hide",
			prepare = function() stub.inCombat = true; stub.fire("PLAYER_REGEN_DISABLED"); stub.advance(0.3) end, probe = shown,
			cleanup = function() stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(0.3) end },
		-- Inside a dungeon, with the guide window kept there: the panel too, or not.
		["trackers.party.instance"] = { with = { ["ui.instance"] = "show" },
			prepare = function() w.inInstance = true; stub.fire("PLAYER_ENTERING_WORLD", false, false); stub.advance(0.3) end, probe = shown,
			cleanup = function() w.inInstance = false; stub.fire("PLAYER_ENTERING_WORLD", false, false); stub.advance(0.3) end },
	},
}
