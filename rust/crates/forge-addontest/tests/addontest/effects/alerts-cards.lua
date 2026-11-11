-- env: world
-- The Alerts & toasts page's Transport alert, While you're here and Heads-up card tabs (Polestar_Options/UI/Looks/
-- Toasts.lua; UI/Toasts.lua, Nav/Alerts.lua, UI/WhileHere.lua, UI/ClassToast.lua) on the whole addon, as
-- ui-look-toasts.rs plays them: the transport banner for a boat 20 s out (3 s, for how long it stays after the
-- arrival), the While you're here toast for the kobolds, and the heads-up card for a dungeon on the guide window,
-- each shown afresh and read as drawn: how long it stays, its place, its size, ground, border, type, accent and
-- entrance.
local A, H, CT, M
local HERE = { t = "kill", hereText = "Kill Kobold Vermin  8/10", yards = 50, step = 2, index = 1 }
local CARD = { head = "LEVEL 18 \194\183 DUNGEON", title = "The Deadmines is open to you", giver = "Gryan Stoutmantle, Sentinel Hill", route = "Westfall",
	icon = "x", iconColor = "dungeon", act = { label = "Pick up the quests", run = function() end } }
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function size(fs) return (select(2, fs:GetFont())) end
local function hideAll()
	if PolestarAlert then PolestarAlert:Hide() end
	if PolestarWhileHereToast then PolestarWhileHereToast:Hide() end
	CT.Hide()
end
local function ground(f) return { f.psBgAlpha or false, rgba(f.psSkin.bg) } end
local function border(f)
	local e = f.psBorder
	return { e ~= nil and e[1]:IsShown(), e ~= nil and rgba(e[1]) or false, e ~= nil and e[1]:GetHeight() or false }
end
local function entrance(f) return { Polestar.Anim.IsRunning(f, "offset"), Polestar.Anim.IsRunning(f, "alpha") } end
local function pace(f) local t = f.psTweens and f.psTweens.alpha; return t and t.running and t.dur or false end
-- Each card shown afresh, `after` seconds on (0: as it shows): read(card).
local function shown(show, frame)
	return function(read, after)
		hideAll()
		show()
		local f = _G[frame]
		if after ~= 0 then stub.advance(after or 1) end
		local out = read(f)
		hideAll()
		return out
	end
end
local banner = shown(function() A.ShowBanner("Boat to Menethil Harbor", "Arrives in %s", 20) end, "PolestarAlert")
local toast = shown(function() H.Show(HERE) end, "PolestarWhileHereToast")
local card = shown(function() CT.ShowCard(CARD) end, "PolestarClassToast")
-- The probes every card has, on `kind`'s card: its title's and its other lines' strings.
local function look(probes, kind, at, title, body)
	local k = "toasts." .. kind .. "."
	probes[k .. "scale"] = function() return at(function(f) return f:GetScale() end) end
	probes[k .. "alpha"] = function() return at(function(f) return f:GetAlpha() end) end
	probes[k .. "bgAlpha"] = function() return at(ground) end
	probes[k .. "bg"] = function() return at(ground) end
	probes[k .. "borderSize"] = function() return at(border) end
	probes[k .. "border"] = function() return at(border) end
	probes[k .. "titleSize"] = function() return at(function(f) return size(f[title]) end) end
	probes[k .. "bodySize"] = function() return at(function(f) return size(f[body]) end) end
	probes[k .. "enter"] = function() return at(entrance, 0) end
	probes[k .. "speed"] = function() return at(pace, 0) end
end
local function lock() if M.IsUnlocked() then M.Lock() end end
local probes = {
	-- The banner for a boat 3 s out: still there 13 s on.
	["toasts.transport.linger"] = function()
		hideAll()
		A.ShowBanner("Boat to Menethil Harbor", "Arrives in %s", 3)
		stub.advance(13)
		local out = PolestarAlert:IsShown()
		hideAll()
		return out
	end,
	-- The toast still there 10 s on; its heading in the accent (its edge and glyph take it too in the client: the
	-- stub's textures answer SetTextColor, so there the toast's code colours them as text).
	["toasts.whilehere.seconds"] = function() return toast(function(f) return f:IsShown() end, 10) end,
	["toasts.whilehere.accent"] = function() return toast(function(f) return { f.Head:GetTextColor() } end) end,
	-- The heads-up card still there 6 s on; where it sits on the window (the window in the middle of the screen: its
	-- rectangle, which the stub does not work out from its anchors); one line or the whole card.
	["toasts.headsup.seconds"] = { value = 5, probe = function() return card(function(f) return f:IsShown() end, 6) end },
	["toasts.headsup.place"] = { prepare = function() PolestarGuideFrame.y = 300 end, cleanup = function() PolestarGuideFrame.y = nil end,
		probe = function() return card(function(f) local p, _, rp = f:GetPoint(1); return { p, rp } end) end },
	["toasts.headsup.compact"] = function() return card(function(f) return { f:GetHeight(), f.Giver:IsShown() } end) end,
	-- Move: unlock mode, the card's own box picked.
	["Alerts & toasts:Its spot"] = { press = true, with = { ["toasts.headsup.place"] = "free" }, prepare = lock, cleanup = lock, probe = function()
		return { M.IsUnlocked() and true or false, M.Selected() or false }
	end },
}
look(probes, "transport", banner, "Title", "When")
look(probes, "whilehere", toast, "Head", "Text")
look(probes, "headsup", card, "Title", "Head")
return {
	setup = function()
		A, H, CT, M = Polestar.Nav.alerts, Polestar.UI.WhileHereToast, Polestar.UI.ClassToast, Polestar.Movers
		-- The guide window up: the heads-up card sits on it.
		Polestar.Set("ui.shown", true)
		Polestar.UI.GuideFrame.frame:Show()
		-- The cards built once, and unlock mode (the settings' addon's).
		A.ShowBanner("Boat to Menethil Harbor", "Arrives in %s", 20)
		H.Show(HERE)
		CT.ShowCard(CARD)
		stub.advance(1)
		hideAll()
		M.Unlock()
		lock()
	end,
	cleanup = function() hideAll() end,
	probes = probes,
}
