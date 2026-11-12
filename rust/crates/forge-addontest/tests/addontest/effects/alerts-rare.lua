-- env: world stub_rares.lua
-- The Alerts & toasts page's Rare alert tab, its alert line and its presets (Polestar_Options/UI/Looks/Toasts.lua;
-- UI/Toasts.lua, Rares/Rares.lua, Detect.lua, Toast.lua, Nav/Alerts.lua, UI/WhileHere.lua) on the whole addon, as
-- rares.rs and ui-look-toasts.rs play them: a level 10 character in Elwynn meets a new rare by its nameplate (or a
-- treasure on the minimap), or the rare alert shows by itself, and the live card is read as drawn: whether it comes
-- and its sound, how long it stays, its size, ground, border, type and entrance; lined up, the transport banner and
-- While you're here hang under it. The client's sound kits for the alert's three sounds (the stub answers 1 for
-- every kit).
local w, U, T, A, H, M
local n = 0
local RARE = { kind = "rare", id = 61, name = "Thuros Lightfingers", level = 11, zone = "Elwynn Forest", yards = 70, map = 1429, x = 50, y = 50, source = "test" }
local HERE = { t = "kill", hereText = "Kill Kobold Vermin  8/10", yards = 50, step = 2, index = 1 }
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function size(fs) return (select(2, fs:GetFont())) end
local function pt(f) local p, rel, rp, x, y = f:GetPoint(1); return { p, rel and rel:GetName() or false, rp, x, y } end
local function hideAll()
	T.Hide()
	if PolestarAlert then PolestarAlert:Hide() end
	if PolestarWhileHereToast then PolestarWhileHereToast:Hide() end
end
-- A new rare comes into view by its nameplate (a treasure on the minimap): whether the card shows it, whether it
-- slides in, and the sounds it played.
local function spot(kind)
	n = n + 1
	local name = (kind == "treasure" and "Chest " or "Rare ") .. n
	hideAll()
	local sounds = #stub.sounds
	if kind == "treasure" then
		local v = "Vignette-" .. n
		U.vignette(v, { object = 7000 + n, name = name, map = 1429, x = 45, y = 52 })
		stub.fire("VIGNETTE_MINIMAP_UPDATED", v, true)
		U.vignetteGone(v)
	else
		U.unit("nameplate1", { npc = 9000 + n, name = name, level = 10, class = "rare" })
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		U.clear("nameplate1")
	end
	local f = PolestarRareToast
	local out = { shown = f ~= nil and f:IsShown() and f.Name:GetText() == name, sliding = f ~= nil and Polestar.Anim.IsRunning(f, "offset"),
		sounds = #stub.sounds - sounds, sound = #stub.sounds > sounds and stub.sounds[#stub.sounds] or false }
	stub.advance(0.5)
	hideAll()
	return out
end
local function one(key, kind) return function() return spot(kind)[key] end end
-- The rare alert shown by itself, `after` seconds on: read(card).
local function card(read, after)
	hideAll()
	T.Show(RARE)
	local f = PolestarRareToast
	if after ~= 0 then stub.advance(after or 1) end
	local out = read(f)
	hideAll()
	return out
end
local function ground(f) return { f.psBgAlpha or false, rgba(f.psSkin.bg) } end
local function border(f)
	local e = f.psBorder
	return { e ~= nil and e[1]:IsShown(), e ~= nil and rgba(e[1]) or false, e ~= nil and e[1]:GetHeight() or false }
end
local function entrance(f) return { Polestar.Anim.IsRunning(f, "offset"), Polestar.Anim.IsRunning(f, "alpha") } end
local function pace(f) local t = f.psTweens and f.psTweens.alpha; return t and t.running and t.dur or false end
-- The three alerts that may line up, shown one after the other.
local function lined(read)
	hideAll()
	T.Show(RARE)
	A.ShowBanner("Boat to Menethil Harbor", "Arrives in %s", 20)
	H.Show(HERE)
	stub.advance(1)
	local out = read()
	hideAll()
	return out
end
local STACK = { ["toasts.stack"] = true }
local function lock() if M.IsUnlocked() then M.Lock() end end
return {
	setup = function()
		w, U, T, A, H, M = stub.world, stub.rares, Polestar.Rares.Toast, Polestar.Nav.alerts, Polestar.UI.WhileHereToast, Polestar.Movers
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 45, 50)
		w.setLevel(10)
		SOUNDKIT = setmetatable({ RAID_WARNING = 8959, READY_CHECK = 8960, UI_RAID_BOSS_WHISPER_WARNING = 37666 }, { __index = function() return 1 end })
		-- The cards built once, and unlock mode (the settings' addon's).
		T.Show(RARE)
		A.ShowBanner("Boat to Menethil Harbor", "Arrives in %s", 20)
		H.Show(HERE)
		stub.advance(1)
		hideAll()
		M.Unlock()
		lock()
	end,
	cleanup = function() hideAll() end,
	probes = {
		-- Whether the card comes, and what it plays.
		["rares.alerts"] = one("shown"),
		["rares.treasureAlerts"] = one("shown", "treasure"),
		["rares.sound"] = one("sounds"),
		["rares.soundKit"] = one("sound"),
		-- In a fight: the card now, or after the fight.
		["rares.combatAlerts"] = { prepare = function() stub.inCombat = true; stub.fire("PLAYER_REGEN_DISABLED") end, probe = one("shown"),
			cleanup = function() stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(0.2) end },
		-- Still there 6 s on.
		["rares.toastSeconds"] = { value = 5, probe = function() return card(function(f) return f:IsShown() end, 6) end },
		["toasts.rare.scale"] = function() return card(function(f) return f:GetScale() end) end,
		["toasts.rare.alpha"] = function() return card(function(f) return f:GetAlpha() end) end,
		["toasts.rare.bgAlpha"] = function() return card(ground) end,
		["toasts.rare.bg"] = function() return card(ground) end,
		["toasts.rare.borderSize"] = function() return card(border) end,
		["toasts.rare.border"] = function() return card(border) end,
		["toasts.rare.titleSize"] = function() return card(function(f) return size(f.Name) end) end,
		["toasts.rare.bodySize"] = function() return card(function(f) return size(f.Facts) end) end,
		["toasts.rare.enter"] = function() return card(entrance, 0) end,
		["toasts.rare.speed"] = function() return card(pace, 0) end,
		-- Lined up: the banner under the rare alert (or at its own place), the line's direction, its gap, how many.
		["toasts.stack"] = function() return lined(function() return pt(PolestarAlert) end) end,
		["toasts.growth"] = { with = STACK, probe = function() return lined(function() return { pt(PolestarRareToast), pt(PolestarAlert) } end) end },
		["toasts.spacing"] = { with = STACK, probe = function() return lined(function() return pt(PolestarAlert) end) end },
		["toasts.max"] = { with = STACK, probe = function()
			return lined(function() return { PolestarRareToast:IsShown(), PolestarAlert:IsShown(), PolestarWhileHereToast:IsShown() } end)
		end },
		-- Move: unlock mode, with the rare alert's box.
		["Alerts & toasts:Placement"] = { press = true, prepare = lock, cleanup = lock, probe = function()
			local b = M.Box("rareAlert")
			return { M.IsUnlocked() and true or false, b ~= nil and b:IsVisible() or false }
		end },
		-- A preset card (Quiet): the next rare's card fades in, without a sound.
		["Alerts & toasts:Presets"] = function() local s = spot(); return { s.shown, s.sliding, s.sounds } end,
	},
}
