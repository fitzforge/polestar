-- env: world stub_maps.lua
-- The Trackers page's Instances & XP tab (Polestar_Options/UI/Looks/Trackers.lua; UI/Trackers.lua,
-- Maps/Instances.lua, QoL/XPMark.lua) on the whole addon, as maps.rs and qol.rs play them: each check walks into The
-- Deadmines (stub_maps.lua's loading screens) and reads the live instance tracker, then walks out; a level 10
-- character whose guide wants level 12 has the guide's mark on the game's XP bar (Blizzard_StatusTrackingBar's
-- frames, made here for the client as stub_qol.lua's q.xpBar makes them).
local m
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function size(fs) return (select(2, fs:GetFont())) end
local function flags(fs) return select(3, fs:GetFont()) or "" end
local function ground(f) return { f.psBgAlpha or false, rgba(f.psSkin.bg) } end
local function border(f)
	local e = f.psBorder
	return { e ~= nil and e[1]:IsShown(), e ~= nil and rgba(e[1]) or false, e ~= nil and e[1]:GetHeight() or false }
end
-- Inside The Deadmines (the same copy each time: the run goes on): read(the tracker), then out again.
local function inside(read, fight)
	m.enter("The Deadmines", 36, "party")
	stub.advance(0.5)
	if fight then
		stub.inCombat = true
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.advance(0.2)
	end
	local out = read(PolestarInstanceTracker)
	if fight then
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.advance(0.2)
	end
	m.leave()
	stub.advance(0.5)
	return out
end
-- The tracker is opt-in: the checks that read it turn it on.
local function shown(read) return { with = { ["maps.instanceDisplay"] = true }, probe = function() return inside(read) end } end
local function mark() return Polestar.QoL.XPMark.frame end
-- The game's XP bar (Blizzard_StatusTrackingBar): two containers of bars under StatusTrackingBarManager, the
-- experience bar shown in the main one.
local function xpBar()
	StatusTrackingBarInfo = { BarsEnum = { None = -1, Reputation = 1, Honor = 2, Artifact = 3, Experience = 4, Azerite = 5, HouseFavor = 6 } }
	local manager = CreateFrame("Frame", "StatusTrackingBarManager", UIParent)
	manager.barContainers = {}
	for i, name in ipairs({ "MainStatusTrackingBarContainer", "SecondaryStatusTrackingBarContainer" }) do
		local c = CreateFrame("Frame", name, manager)
		c:SetSize(571, 17)
		c.bars = {}
		for index = 1, 6 do
			local bar = CreateFrame("Frame", nil, c)
			bar:SetSize(565, 11)
			bar.StatusBar = CreateFrame("StatusBar", nil, bar)
			bar.StatusBar:SetAllPoints(bar)
			bar.OverlayFrame = CreateFrame("Frame", nil, bar)
			bar.OverlayFrame:SetFrameLevel(4)
			bar:SetShown(i == 1 and index == 4)
			c.bars[index] = bar
		end
		manager.barContainers[i] = c
	end
end
return {
	setup = function()
		m = stub.maps
		m.useWorld()
		m.place(0, 800)
		stub.world.setLevel(10)
		xpBar()
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/xp", pack = "test", title = "Level", minLevel = 1, maxLevel = 12, steps = {
			{ goals = { { t = "level", level = 12 } } },
		} })
		Polestar.Engine.SetGuide("test/xp")
		stub.advance(0.5)
	end,
	settle = 0.2,
	probes = {
		-- In the dungeon: the tracker with its run, or nothing.
		["maps.instances"] = shown(function(f) return f:IsShown() end),
		["maps.instanceDisplay"] = function() return inside(function(f) return f:IsShown() end) end,
		["trackers.instances.scale"] = shown(function(f) return f:GetScale() end),
		["trackers.instances.width"] = shown(function(f) return f:GetWidth() end),
		["trackers.instances.alpha"] = shown(function(f) return f:GetAlpha() end),
		["trackers.instances.bgAlpha"] = shown(ground),
		["trackers.instances.bg"] = shown(ground),
		["trackers.instances.borderSize"] = shown(border),
		["trackers.instances.border"] = shown(border),
		["trackers.instances.titleSize"] = shown(function(f) return { size(f.Count), f:GetHeight() } end),
		["trackers.instances.outline"] = shown(function(f) return flags(f.Count) end),
		["trackers.instances.bodySize"] = shown(function(f) return size(f.RunInfo) end),
		["trackers.instances.instance"] = shown(function(f) return f:IsShown() end),
		-- A fight in the dungeon: the tracker as it was, faded or gone.
		["trackers.instances.combat"] = { with = { ["maps.instanceDisplay"] = true }, probe = function()
			return inside(function(f) return { f:IsShown(), f:GetAlpha() } end, true)
		end },
		-- The guide's mark on the XP bar: "Guide: 12 (2 levels)".
		["qol.xpTargetMark"] = function() local f = mark(); return f ~= nil and f:IsShown() and f.Label:GetText() or false end,
		["trackers.xp.tickWidth"] = function() return mark().Tick:GetWidth() end,
		["trackers.xp.tickColor"] = function() return rgba(mark().Tick) end,
		["trackers.xp.label"] = function() return mark().Label:IsShown() end,
		["trackers.xp.labelSize"] = function() return size(mark().Label) end,
		["trackers.xp.outline"] = function() return flags(mark().Label) end,
	},
}
