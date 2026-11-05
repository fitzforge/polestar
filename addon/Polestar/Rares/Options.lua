-- The rares settings on the Discovery options page's Rares tab
-- (docs/ARCHITECTURE.md, "Options registry"): alerts, the detection paths
-- the Forever client offers and the history; the spawn pins sit with every
-- other map icon on the Map page. rares.enabled switches the whole module
-- off: no events, no pins, no alerts.

local ADDON, ns = ...
local Rares = ns.Rares
local L = ns.L

if not ns.RegisterOptions then return end

local function off() return not Rares.Get("enabled") end
local function alertsOff() return off() or not Rares.Get("alerts") end
local function soundOff() return alertsOff() or not Rares.Get("sound") end

local function sounds()
	local out = {}
	for i, s in ipairs(Rares.SOUNDS) do out[i] = { value = s.value, label = s.label } end
	return out
end

local function minutes(v)
	v = math.floor(v + 0.5)
	return v == 1 and L["1 minute"] or string.format(L["%d minutes"], v)
end

local function seconds(v)
	return string.format(L["%d s"], math.floor(v + 0.5))
end

local function register(spec)
	if spec.page ~= L["Map"] then spec.page, spec.tab = L["Discovery"], L["Rares"] end
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

register({
	section = L["When a rare shows up"],
	controls = {
		{ kind = "toggle", key = "rares.enabled", label = L["Rares"],
			help = L["Watch for rare NPCs and treasures and keep when you last met them (/pole rares). Their map pins are under Map, off by default."] },
		{ kind = "toggle", key = "rares.alerts", label = L["Alert for rares"], disabled = off,
			help = L["A card with its name, level and distance, and a waypoint to it."] },
		{ kind = "toggle", key = "rares.treasureAlerts", label = L["Alert for treasures"], disabled = alertsOff, child = true,
			help = L["Treasures the client marks on the minimap."] },
		{ kind = "slider", key = "rares.cooldown", label = L["Once per rare every"], min = 1, max = 60, step = 1, format = minutes,
			disabled = alertsOff, child = true, help = L["The same rare stays quiet this long after an alert."] },
		{ kind = "slider", key = "rares.toastSeconds", label = L["Alert stays for"], min = 5, max = 60, step = 1, format = seconds,
			disabled = alertsOff, child = true, help = L["Hovering the alert holds it."] },
		{ kind = "toggle", key = "rares.combatAlerts", label = L["Alert during combat"], disabled = alertsOff, child = true,
			help = L["Off: an alert waits for the fight to end, if the rare was seen in the last minute."] },
		{ kind = "toggle", key = "rares.sound", label = L["Play a sound"], disabled = alertsOff, child = true,
			help = L["One sound with each alert."] },
		{ kind = "dropdown", key = "rares.soundKit", label = L["Sound"], choices = sounds, disabled = soundOff, child = true,
			help = L["Played through the Master channel."] },
		{ kind = "button", button = L["Show"], label = L["Show a sample alert"], disabled = off,
			help = L["See where the alert sits; drag it to move it."],
			onClick = function() Rares.ShowSample() end },
	},
})

register({
	section = L["How rares are noticed"],
	controls = {
		{ kind = "toggle", key = "rares.vignettes", label = L["Minimap markers"], disabled = off,
			help = L["Rares and treasures the client marks on the minimap (vignettes), with their exact distance."] },
		{ kind = "toggle", key = "rares.nameplates", label = L["Nameplates"], disabled = off,
			help = L["A rare's nameplate coming into view. Needs enemy nameplates on."] },
		{ kind = "toggle", key = "rares.target", label = L["Your target"], disabled = off,
			help = L["Targeting a rare."] },
		{ kind = "toggle", key = "rares.mouseover", label = L["Under the cursor"], disabled = off,
			help = L["Pointing at a rare in the world."] },
	},
})

register({
	page = L["Map"], tab = L["Rares & travel"], section = L["Rares and treasures"],
	controls = {
		{ kind = "toggle", key = "rares.worldRares", label = L["Rares on the world map"], disabled = off,
			help = L["Every known spawn point. Click one to see it in Rares; Shift-click for a waypoint."] },
		{ kind = "toggle", key = "rares.worldTreasures", label = L["Treasures on the world map"], disabled = off,
			help = L["Every known treasure spot."] },
		{ kind = "toggle", key = "rares.minimapRares", label = L["Rares on the minimap"], disabled = off,
			help = L["Loads the Codex at login."] },
		{ kind = "toggle", key = "rares.minimapTreasures", label = L["Treasures on the minimap"], disabled = off,
			help = L["Loads the Codex at login."] },
		{ kind = "toggle", key = "rares.hideGrey", label = L["Hide rares below your level"], disabled = off,
			help = L["Rares too low to give experience leave the map."] },
	},
})

register({
	section = L["History"],
	controls = {
		{ kind = "button", button = L["Forget"], label = L["Forget rares met on this realm"], disabled = off,
			help = L["Clears the Seen list, alert cooldowns and the glow on recently seen pins."],
			onClick = function() Rares.ClearHistory() end },
	},
})
