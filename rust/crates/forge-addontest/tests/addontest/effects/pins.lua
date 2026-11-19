-- env: nav
-- The Map pins page (Polestar_Options/Nav/PinsOptions.lua; Nav/Pins.lua, Upcoming.lua, Layers.lua): every setting
-- on the live pins of the world map and the minimap: the target in its area 40 yd out, three numbered steps ahead,
-- marks (one a group with a count badge) and the trail toward the target.
local N, Pins, nav, scroll
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function r3(v) return math.floor((v or 0) * 1000 + 0.5) / 1000 end
local function at(wx, wy, extra)
	local m, x, y = nav.mapPoint(wx, wy)
	local p = { map = m, x = x, y = y }
	for k, v in pairs(extra or {}) do p[k] = v end
	return p
end
-- The world map's pins of a layer (or with a tooltip), after a map frame.
local function world(layer)
	stub.advance(0.05)
	stub.runMapFrame(WorldMapFrame, 0)
	local out = {}
	for _, f in ipairs(nav.pins()) do
		if f.data.layer.name == layer or (f.data.pin and f.data.pin.tooltip == layer) then out[#out + 1] = f end
	end
	table.sort(out, function(a, b) return (a.data.x or 0) < (b.data.x or 0) end)
	return out
end
local function minimap(layer) stub.advance(0.3); return Pins.GetMinimapFrames(layer) end
-- The numbered pins as drawn; a number's own look only while it shows (a hidden one keeps whatever font it had).
local function numbered()
	local out = {}
	for _, f in ipairs(world("nav.upcoming")) do
		local _, size, outline = f.text:GetFont()
		local tr, tg, tb = f.text:GetTextColor()
		local on = f.text:IsShown()
		out[#out + 1] = { w = r3(f.width), size = on and r3(size) or false, outline = on and outline or false, text = on and f.text:GetText() or false,
			number = on and { r3(tr), r3(tg), r3(tb) } or false, fill = rgba(f.fill), ring = rgba(f.ring) }
	end
	return out
end
local function steps(n)
	local views = { [3] = { status = "current", goals = {} } }
	for s = 4, 3 + n do views[s] = { title = "S" .. s, status = "upcoming", goals = { { map = 9000, x = 10 * s, y = 50, status = "pending" } } } end
	Polestar.Engine = { GetLiveStep = function() return 3 end, GetStepCount = function() return 3 + n end, GetStepView = function(i) return views[i] end }
end
local function mark(tip)
	local f = world(tip)[1]
	return f and { medal = r3(f.medal.width * f.scale * (scroll.currentScale or 1)), alpha = r3(f:GetAlpha() or 1), tex = f.medal:GetTexture(),
		tint = rgba(f.medal), badge = f.badge.text:IsShown() and r3(select(2, f.badge.text:GetFont())) or false } or false
end
local function mmMark(tip)
	for _, f in ipairs(minimap("marks")) do
		if f.pin.tooltip == tip then return { w = r3(f:GetWidth()), alpha = r3(f:GetAlpha() or 1) } end
	end
	return false
end
local function target()
	local f = world("nav.target")[1]
	return f and { w = r3(f.width), glow = f.glow:IsShown(), pulsing = f.pulsing or false, pace = f.pulseSeconds or false } or false
end
local function trail()
	local dots = Pins.GetTrailFrames("minimap")
	local d = dots[1]
	return { n = #dots, w = d and r3(d:GetWidth()) or false, a = d and r3(rgba(d)[4]) or false }
end
-- The numbered pins are off by default: the checks that read them turn them on first.
local NP = { ["nav.upcomingPins"] = true }
local function onNumbered(probe, extra)
	local with = { ["nav.upcomingPins"] = true }
	for k, v in pairs(extra or {}) do with[k] = v end
	return { with = with, probe = probe }
end
return {
	setup = function()
		N, Pins, nav, scroll = Polestar.Nav, Polestar.Pins, stub.nav, WorldMapFrame.ScrollContainer
		nav.viewRadius = 200
		nav.place(0, 0)
		steps(3)
		Polestar.Set("ui.upcoming", 3)
		local m, x, y = nav.mapPoint(40, 0)
		N.SetTarget(m, x, y, "Goal")
		Pins.SetLayer("marks", {
			at(20, 20, { icon = "map:kill", size = 16, minimapSize = 14, tooltip = "Kill" }),
			at(-20, 20, { icon = "map:inn", size = 16, tooltip = "Group", badge = 3 }),
			at(0, 0, { icon = "map:quest-turnin", minimapSize = 14, tooltip = "Centre" }),
			-- A rare's or a death's mark: a plain icon on its dark disc.
			at(-40, -20, { icon = "Interface\\Icons\\INV_Misc_Bone_HumanSkull_01", size = 16, backdrop = true, tooltip = "Backed" }),
			at(60, 60, { area = 60, areaOnly = true, color = { 1, 0.5, 0.5, 1 } }),
		})
		nav.showWorldMap(9000)
	end,
	probes = {
		["nav.targetPinSize"] = function() return target() end,
		["nav.targetGlow"] = function() return target() end,
		["nav.targetPulse"] = function() return target() end,
		["nav.pulseSeconds"] = { with = { ["nav.targetPulse"] = true }, probe = function() return target() end },
		["nav.worldPins"] = function() return #world("nav.target") end,
		["nav.minimapPins"] = function() return #minimap("nav.target") end,
		["nav.areaAlpha"] = function() local a = nav.pins("areas")[1]; return a and rgba(a.tex) or false end,
		["nav.areaColor"] = function() local a = nav.pins("areas")[1]; return a and rgba(a.tex) or false end,
		["nav.trailDots"] = function() return trail().n end,
		["nav.trailDotSize"] = function() return trail().w end,
		["nav.trailDotAlpha"] = function() return trail().a end,
		["nav.upcomingPins"] = function() return #numbered() end,
		["nav.stepPinSize"] = onNumbered(numbered),
		["nav.stepRingColor"] = onNumbered(numbered),
		["nav.stepColorMode"] = onNumbered(numbered),
		["nav.stepColor"] = onNumbered(numbered, { ["nav.stepColorMode"] = "own" }),
		["nav.stepNumberSize"] = onNumbered(numbered),
		["nav.stepNumbers"] = onNumbered(numbered),
		["nav.stepNumberColor"] = onNumbered(numbered),
		["nav.stepNumberOutline"] = onNumbered(numbered),
		["nav.upcomingCount"] = { with = NP, value = 2, probe = function() return #numbered() end },
		["nav.stepAlpha"] = onNumbered(numbered),
		["nav.stepFadeTo"] = onNumbered(numbered),
		["nav.upcomingMinimap"] = onNumbered(function() return #minimap("nav.upcoming") end),
		["nav.stepMinimapSize"] = onNumbered(function() local f = minimap("nav.upcoming")[1]; return f and r3(f:GetWidth()) or false end),
		["nav.worldIconSize"] = function() return mark("Kill") end,
		["nav.worldPinAlpha"] = function() return mark("Kill") end,
		["nav.minimapIconSize"] = function() return mmMark("Kill") end,
		["nav.minimapPinAlpha"] = function() return mmMark("Kill") end,
		["nav.minimapArrowFade"] = function() return mmMark("Centre") end,
		["nav.badgeSize"] = function() return mark("Group") end,
		["nav.mapIcons"] = { value = "halo", probe = function() return mark("Kill") end },
		["nav.medalColor"] = function() return mark("Kill") end,
		["nav.pinBacking"] = function() local f = world("Backed")[1]; return f and { f.back:IsShown(), rgba(f.back) } or false end,
	},
}
