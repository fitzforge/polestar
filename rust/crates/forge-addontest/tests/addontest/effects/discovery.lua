-- env: world stub_rares.lua
-- The Discovery page's Rares and Characters tabs (Rares/Options.lua, Detect.lua, Rares.lua, Toast.lua;
-- Alts/Options.lua, Snapshot.lua): a fresh rare (or the founder) comes into view by each path the client offers
-- (rares.rs), and the alert card says so or not; the character's saved entry follows its money or not.
local w, R, U, T
local n = 0 -- rares seen so far: each check meets a new one
local function card() return PolestarRareToast ~= nil and PolestarRareToast:IsShown() and PolestarRareToast.Name:GetText() or false end
-- A new rare comes into view by `path`; -> whether the alert card shows it.
local EVENT = { nameplate = "NAME_PLATE_UNIT_ADDED", target = "PLAYER_TARGET_CHANGED", mouseover = "UPDATE_MOUSEOVER_UNIT" }
local function spot(path)
	n = n + 1
	local npc, name = 9000 + n, "Rare " .. n
	T.Hide()
	if path == "vignette" then
		local v = "Vignette-" .. n
		U.vignette(v, { npc = npc, name = name, map = 1429, x = 45, y = 52 })
		stub.fire("VIGNETTE_MINIMAP_UPDATED", v, true)
		U.vignetteGone(v)
	else
		local token = path == "nameplate" and "nameplate1" or path
		U.unit(token, { npc = npc, name = name, level = 10, class = "rare" })
		stub.fire(EVENT[path], token)
		U.clear(token)
	end
	stub.advance(0.1)
	local shown = card() == name
	T.Hide()
	return shown
end
local function history() local k = 0 for _ in pairs(R.History()) do k = k + 1 end return k end
local money = 0
return {
	setup = function()
		w, R, U = stub.world, Polestar.Rares, stub.rares
		T = R.Toast
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 45, 50)
		w.setLevel(10)
		-- A Forever character (a surname), as the founder's checks have it.
		U.me = { "Ana", "Smith" }
	end,
	probes = {
		["rares.enabled"] = function() return spot("nameplate") end,
		["rares.nameplates"] = function() return spot("nameplate") end,
		["rares.target"] = function() return spot("target") end,
		["rares.mouseover"] = function() return spot("mouseover") end,
		["rares.vignettes"] = function() return spot("vignette") end,
		-- The same rare again five minutes later (a new unit of it): alerted again only past the cooldown.
		["rares.cooldown"] = { value = 1, probe = function()
			n = n + 1
			local npc, name = 9000 + n, "Rare " .. n
			local function see(k)
				T.Hide()
				U.unit("nameplate2", { guid = ("Creature-0-1-0-1-%d-00000%04d"):format(npc, k), name = name, level = 10, class = "rare" })
				stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate2")
				U.clear("nameplate2")
				stub.advance(0.1)
				return card() == name
			end
			see(1)
			stub.epoch = stub.epoch + 5 * 60
			local again = see(2)
			T.Hide()
			return again
		end },
		-- The founder comes into view: his card; then he leaves and the half hour between his alerts passes.
		["rares.founder"] = function()
			n = n + 1
			T.Hide()
			U.unit("nameplate3", { guid = ("Player-1-0000F%03d"):format(n), name = "Fitz", surname = "Polestar", player = true, faction = "Alliance", level = 13 })
			stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate3")
			stub.advance(0.1)
			local shown = card()
			U.clear("nameplate3")
			T.Hide()
			stub.now = stub.now + 31 * 60
			stub.advance(0.2)
			return shown
		end,
		["Discovery:Show a sample alert"] = { press = true, prepare = function() T.Hide() end,
			probe = function() local a = T.Current(); return a and card() and a.source or false end,
			cleanup = function() T.Hide() end },
		["Discovery:Forget rares met on this realm"] = { press = true, prepare = function() spot("nameplate") end, probe = history },
		-- The character's saved entry (the Characters page) follows its money.
		["alts.enabled"] = function()
			money = money + 1000
			w.setMoney(money)
			stub.advance(11)
			local me = Polestar.Alts.List()[1]
			return me ~= nil and me.money == money
		end,
	},
}
