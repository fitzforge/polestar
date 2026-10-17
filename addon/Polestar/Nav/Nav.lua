-- Polestar navigation core: which point we are guiding to, and where it is
-- relative to the player. The arrow, the map pins and the TomTom/Blizzard
-- bridges all read from here. Contract: docs/ARCHITECTURE.md, "Nav".
--
-- All geometry is done in world yards from Polestar.Compat: wx grows north,
-- wy grows west, facing 0 is north and grows counter-clockwise. A target is
-- converted to world space once (honouring its map frame, so Era-frame guide
-- coordinates land in the right place on reworked Forever maps) and every
-- distance and bearing after that is plain vector maths.
--
-- Colours: Nav.RGB(name) and Nav.Wash(role) read Polestar.Theme's tokens
-- (accent, success, the arrow's arrow/arrowNear and their legible *Text
-- forms, text, textDim, place, ink, shade; the ink washes), with a
-- fallback palette only for when Theme is not loaded.

local ADDON, ns = ...
local L = ns.L

local type, tonumber, pcall, error = type, tonumber, pcall, error
local sqrt, atan2, pi, max = math.sqrt, math.atan2, math.pi, math.max
local TWO_PI = 2 * pi

local Nav = {}
ns.Nav = Nav

Nav.MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Nav\\"
Nav.DEFAULT_RADIUS = 8 -- yards, matches the guide format's goto default

ns.RegisterDefaults("nav", {
	arrow = true,
	arrowScale = 1,
	arrowAlpha = 1,
	arrowEta = true,
	worldPins = true,
	minimapPins = true,
	trailDots = true,
	tomtom = true,
	useTomTomArrow = false,
	blizzardWaypoint = false,
	arrivalSound = true,
	-- How distances read: "yards" (the game's unit) or "metres" (ns.FormatDistance).
	distanceUnit = "yards",
	-- The arrow's colours (Theme tokens "arrow" and "arrowNear"): false = the
	-- accent far away and success near; { r, g, b } = your own.
	arrowColor = false,
	arrowNearColor = false,
	-- arrowPos: { point, relPoint, x, y } once the arrow has been dragged; nil = default spot
})

-- Wrap an angle into (-pi, pi].
local function wrap(a)
	a = a % TWO_PI
	if a > pi then a = a - TWO_PI end
	return a
end
Nav.WrapAngle = wrap

---------------------------------------------------------------------------
-- Colours and fonts, from Polestar.Theme when it offers them. FALLBACK is
-- only read when Theme is absent (Nav loaded on its own, as in the nav
-- tests) or its call fails; with Theme, every name below comes from the
-- active scheme and refreshes on Theme.OnChanged.
---------------------------------------------------------------------------

local FALLBACK = {
	accent = { 0.902, 0.729, 0.4 }, -- Dusk gold, #e6ba66
	success = { 0.42, 0.85, 0.6 },
	-- The arrow's own colours (far, near; their legible text forms), which
	-- follow accent and success unless the player picked their own.
	arrow = { 0.902, 0.729, 0.4 },
	arrowNear = { 0.42, 0.85, 0.6 },
	arrowText = { 0.902, 0.729, 0.4 },
	arrowNearText = { 0.42, 0.85, 0.6 },
	text = { 0.969, 0.973, 0.992 },
	textDim = { 0.765, 0.793, 0.868 },
	place = { 0.96, 0.68, 0.52 },
	ink = { 1, 1, 1 },    -- hairlines and washes
	shade = { 0, 0, 0 },  -- text shadows
}
-- Wash alphas by role, as Theme.WASH has them.
local FALLBACK_WASH = { mover = 0.06, border = 0.08 }
local palette = {}
for name, c in pairs(FALLBACK) do palette[name] = { c[1], c[2], c[3] } end

local function themeColor(name)
	local T = ns.Theme
	if type(T) ~= "table" then return nil end
	local ok, r, g, b
	if name == "accent" and type(T.Accent) == "function" then
		ok, r, g, b = pcall(T.Accent)
	elseif type(T.Color) == "function" then
		ok, r, g, b = pcall(T.Color, name)
	end
	if ok and type(r) == "number" and type(g) == "number" and type(b) == "number" then return r, g, b end
end

local function refreshPalette()
	for name, fb in pairs(FALLBACK) do
		local r, g, b = themeColor(name)
		local c = palette[name]
		c[1], c[2], c[3] = r or fb[1], g or fb[2], b or fb[3]
	end
end

function Nav.RGB(name)
	local c = palette[name] or palette.text
	return c[1], c[2], c[3]
end

-- An ink wash at one of the house alphas (Theme.Wash): r, g, b, a.
function Nav.Wash(role)
	local T = ns.Theme
	local a = type(T) == "table" and type(T.WASH) == "table" and T.WASH[role] or nil
	if type(a) ~= "number" then a = FALLBACK_WASH[role] or FALLBACK_WASH.border end
	local c = palette.ink
	return c[1], c[2], c[3], a
end

-- HUD text: the theme's typeface at a size chosen for reading over the 3D
-- world, outlined so it survives bright terrain; the shadow stays dark (shade).
function Nav.SetHudFont(fs, role, size)
	local path
	local T = ns.Theme
	if type(T) == "table" and type(T.FontSpec) == "function" then
		local ok, p = pcall(T.FontSpec, role)
		if ok and type(p) == "string" then path = p end
	end
	if not (path and fs:SetFont(path, size, "OUTLINE")) then
		fs:SetFont(STANDARD_TEXT_FONT, size, "OUTLINE")
	end
	local c = palette.shade
	fs:SetShadowColor(c[1], c[2], c[3], 0.8)
	fs:SetShadowOffset(1, -1)
end

---------------------------------------------------------------------------
-- Modules (arrow, pins, bridges) register here and are told about changes.
--   module:OnTarget(target)   the target changed (may be nil)
--   module:Refresh()          situation may have changed (zone, taxi, ticker)
--   module:OnSettings()       a nav.* setting changed
--   module:OnTheme()          colours/fonts changed
---------------------------------------------------------------------------

local modules = {}

local function notify(method, ...)
	for i = 1, #modules do
		local m = modules[i]
		if m[method] then ns.SafeCall(m[method], m, ...) end
	end
end

function Nav.RegisterModule(m)
	modules[#modules + 1] = m
end

function Nav.Refresh()
	notify("Refresh")
end

---------------------------------------------------------------------------
-- Target model
---------------------------------------------------------------------------

local engineWp    -- last waypoint announced by the Engine
local override    -- point picked with Nav.SetTarget, kept until the step changes
local dismissed   -- engine waypoint hidden by ClearTarget until the Engine moves on
local target      -- what we guide to: override, else engine waypoint
local tC, tX, tY  -- target in world space (nil until resolvable)
local tZ         -- its height: the target's `z` (a guide goal, candidate or spawn area at an NPC or object), else nil
local arrived = false
local firing = false
local ticker

local function resolve()
	tC, tX, tY, tZ = nil, nil, nil, nil
	local C = ns.Compat
	if target and C and C.MapToWorld then
		tC, tX, tY = C.MapToWorld(target.map, target.x, target.y, target.f)
		if tC and type(target.z) == "number" then tZ = target.z end
	end
end

local function samePoint(a, b)
	return a ~= nil and b ~= nil and a.map == b.map and a.x == b.x and a.y == b.y
		and a.stepIndex == b.stepIndex and a.goalIndex == b.goalIndex
end

-- While a target exists, re-check the situation once a second: hidden
-- frames run no OnUpdate, so this is what brings them back after a taxi
-- ride, a boat to another continent or leaving an instance.
local function updateTicker()
	if target and not ticker and C_Timer and C_Timer.NewTicker then
		ticker = C_Timer.NewTicker(1, Nav.Refresh)
	elseif not target and ticker then
		ticker:Cancel()
		ticker = nil
	end
end

local function announce()
	firing = true
	local ok, err = pcall(ns.Fire, "WAYPOINT_CHANGED", target)
	firing = false
	if not ok then error(err, 0) end
end

local function apply(shouldAnnounce)
	local new = override or (not dismissed and engineWp) or nil
	target = new
	arrived = false
	resolve()
	updateTicker()
	-- Plan before the arrow and pins hear about the new target.
	local T = Nav.travel
	if T and T.Replan then T.Replan() end
	notify("OnTarget", target)
	if shouldAnnounce then announce() end
end

-- `stop`: what stands there, as Shortest Path Forever's stop kinds name it
-- ("dungeon", "trainer", "innkeeper", "flightmaster"; Nav/Handoff.lua), optional.
-- `z`: the height of the NPC or object there (a guide goal's or candidate's
-- compiled `z`), optional, so the walk ends on its floor.
function Nav.SetTarget(map, x, y, label, f, stop, z)
	map, x, y = tonumber(map), tonumber(x), tonumber(y)
	if not (map and x and y) then return false end
	local Engine = ns.Engine
	override = {
		map = map, x = x, y = y, f = f,
		z = type(z) == "number" and z or nil,
		label = (label and label ~= "") and label or L["Waypoint"],
		kind = "manual",
		stop = type(stop) == "string" and stop or nil,
		r = Nav.DEFAULT_RADIUS,
		stepIndex = Engine and Engine.GetStepIndex and Engine.GetStepIndex() or nil,
	}
	apply(true)
	return true
end

-- Drops the override; the engine's waypoint stays dismissed until the Engine
-- announces a different one or the step changes.
function Nav.ClearTarget()
	override = nil
	dismissed = engineWp ~= nil
	apply(true)
end

-- Drops the override only: the engine's waypoint (if any) is guided to again.
-- No-op without an override.
function Nav.ReleaseTarget()
	if not override then return end
	override = nil
	apply(true)
end

function Nav.GetTarget()
	return target
end

function Nav.IsOverride()
	return override ~= nil and target == override
end

-- World position of the target: continentID, wx, wy, then its height when
-- it has one (an Engine waypoint's `z`; a hand-set target has none). nil if unresolved.
function Nav.GetTargetWorld()
	if target and not tC then resolve() end
	return tC, tX, tY, tZ
end

-- The hand-off to Shortest Path Forever began or ended (Nav/Handoff.lua): the
-- route is planned again and every module hears the same target anew, so its
-- arrow, lines and bridges show or step aside. Nothing is announced: the
-- target itself did not change.
function Nav.Reapply()
	local T = Nav.travel
	if T and T.Replan then T.Replan() end
	notify("OnTarget", target)
end

-- A point's coordinates in the live (Forever) frame of its own map, for
-- APIs that take map percent: TomTom and Blizzard's user waypoint.
function Nav.LiveCoords(point)
	if not point then return nil end
	if not point.f then return point.map, point.x, point.y end
	local C = ns.Compat
	if not (C and C.MapToWorld and C.WorldToMap) then return nil end
	local c, wx, wy = C.MapToWorld(point.map, point.x, point.y, point.f)
	if not c then return nil end
	local x, y = C.WorldToMap(c, wx, wy, point.map)
	if not x then return nil end
	return point.map, x, y
end

---------------------------------------------------------------------------
-- Situation sampling. Allocation-free: called from throttled OnUpdates.
--
-- Nav.Sample() -> state, distance, relAngle, dNorth, dWest, measured
--   state: "none" | "instance" | "taxi" | "unknown" | "far" | "travel" | "arrived"
--          | "instruction" (a route leg to act on here: fly, ride, hearth)
--          | "search" (reached a spot of an area objective: look around here)
--          | "nopos" (the client gives no player position here: the Deeprun
--            Tram, a map of its own without a world map)
--   distance/relAngle/dNorth/dWest are toward what the arrow points at: the
--   current route leg's end while a travel route is active, else the target;
--   on a walk the walking engine has a path for (Nav/Walk.lua), the angle is
--   toward the path's next point and the distance is what is left of the path
--   (measured = true: the distance is along a path, not a straight line).
--   An area target (`area`, yards: a spawn area) is reached anywhere inside
--   it plus its arrival radius `r`, and its distance is to the area's edge;
--   with `search` set (an area objective) reaching it is "search", never "arrived".
--   relAngle: radians relative to facing, counter-clockwise positive (nil
--   when facing is unknown)
---------------------------------------------------------------------------

local function playArrival()
	if not ns.Get("nav.arrivalSound") or (Nav.HandedOff and Nav.HandedOff()) then return end
	local id = (SOUNDKIT and SOUNDKIT.MAP_PING) or 3175
	if PlaySound then PlaySound(id, "SFX") end
end

local function toward(C, px, py, ax, ay)
	local dn, dw = ax - px, ay - py
	local angle
	local facing = C.GetPlayerFacing and C.GetPlayerFacing()
	if facing then angle = wrap(atan2(dw, dn) - facing) end
	return sqrt(dn * dn + dw * dw), angle, dn, dw
end

function Nav.Sample()
	if not target then return "none" end
	local C = ns.Compat
	if not C then return "unknown" end
	if C.IsInInstance and C.IsInInstance() then return "instance" end
	if C.IsOnTaxi and C.IsOnTaxi() then return "taxi" end
	if not tC then
		resolve()
		if not tC then return "unknown" end
	end
	local pc, px, py
	if C.GetPlayerWorldPosition then pc, px, py = C.GetPlayerWorldPosition() end
	if not pc then
		-- No position, nothing to measure. A ride, flight or hearth on the
		-- route is still what to do (the tram ride itself); else say so.
		local T = Nav.travel
		local leg = T and T.Active and T.Active() and T.CurrentLeg()
		if leg and leg.kind ~= "walk" then return "instruction" end
		return "nopos"
	end

	local T = Nav.travel
	if T and T.Active and T.Active() then
		local mode, ac, ax, ay, left = T.Aim(pc, px, py)
		if mode == "instruction" then
			if ac == pc then return "instruction", toward(C, px, py, ax, ay) end
			return "instruction"
		elseif mode == "walk" then
			if ac ~= pc then return "far" end
			local dist, angle, dn, dw = toward(C, px, py, ax, ay)
			return "travel", left or dist, angle, dn, dw, left ~= nil
		end
		-- nil: the last leg, straight to the target
	end

	if pc ~= tC then return "far" end
	local dist, angle, dn, dw = toward(C, px, py, tX, tY)
	local area = tonumber(target.area)
	if area and area > 0 then dist = dist > area and dist - area or 0 end
	local r = target.r or Nav.DEFAULT_RADIUS
	if arrived then
		if dist > r + max(5, r * 0.5) then arrived = false end
	elseif dist <= r then
		arrived = true
		playArrival()
		-- NAV_ARRIVED(target): once per arrival (Nav/Nearby.lua ends its trip).
		pcall(ns.Fire, "NAV_ARRIVED", target)
	end
	if arrived and target.search then return "search", dist, angle, dn, dw end
	if arrived then return "arrived", dist, angle, dn, dw end
	-- Along the walking engine's path when it has one (Nav/Walk.lua); the
	-- distance is then what is left of it (an area target: to its edge, straight).
	local W = Nav.walk
	if W then
		local leg = T and T.CurrentLeg and T.CurrentLeg()
		local wc, wx, wy, left = W.Aim(pc, px, py, tC, tX, tY, (leg and leg.handmade) or W.FollowsGoto(target))
		if wc then
			local _, a2, dn2, dw2 = toward(C, px, py, wx, wy)
			if area and area > 0 then return "travel", dist, a2, dn2, dw2 end
			return "travel", left, a2, dn2, dw2, true
		end
	end
	return "travel", dist, angle, dn, dw
end

-- States in which nothing is drawn at all.
function Nav.IsHiddenState(state)
	return state == "none" or state == "instance" or state == "taxi" or state == "unknown"
end

-- The target relative to the player: dNorth, dWest in yards (same continent
-- only, nil otherwise). Allocation-free.
function Nav.TargetOffset()
	if not target then return nil end
	local C = ns.Compat
	if not (C and C.GetPlayerWorldPosition) then return nil end
	if not tC then
		resolve()
		if not tC then return nil end
	end
	local pc, px, py = C.GetPlayerWorldPosition()
	if pc ~= tC then return nil end
	return tX - px, tY - py
end

-- Straight-line yards to the target (not along a travel route); to an area
-- target's edge, 0 inside it.
function Nav.GetDistance()
	local state = Nav.Sample()
	if Nav.IsHiddenState(state) then return nil end
	local dn, dw = Nav.TargetOffset()
	if not dn then return nil end
	local d, area = sqrt(dn * dn + dw * dw), tonumber(target.area)
	if area and area > 0 then d = d > area and d - area or 0 end
	return d
end

-- An area objective's target (the Engine's waypoint with `spots`): move it on
-- to the next spot, or to spot `index`. True if the Engine took it.
function Nav.NextSpot(index)
	local t, E = target, ns.Engine
	if not (t and t.spots and t == engineWp and E and E.CycleSpot) then return false end
	return E.CycleSpot(t.stepIndex, t.goalIndex, index) ~= nil
end

-- Display name of the target's zone (shown when it is on another continent).
function Nav.GetTargetZoneName()
	if not target then return nil end
	local C = ns.Compat
	local name = C and C.GetMapName and C.GetMapName(target.map)
	return name or target.zoneName
end

---------------------------------------------------------------------------
-- Wiring
---------------------------------------------------------------------------

-- STEP_CHANGED / GUIDE_CHANGED drop an override or dismissal. The Engine
-- fires them before it stores the new step's waypoint (WAYPOINT_CHANGED
-- follows, and only when the waypoint differs), so the new target is taken
-- from that WAYPOINT_CHANGED, or after the dispatch when none comes. Without
-- an override nothing happens here: re-applying the old waypoint would reset
-- arrival (a second chime) and churn TomTom and the Blizzard waypoint.
local pendingStep = false

local function settleStep()
	if not pendingStep then return end
	pendingStep = false
	local Engine = ns.Engine
	if Engine and Engine.GetWaypoint then engineWp = Engine.GetWaypoint() end
	apply(true)
end

ns.On("WAYPOINT_CHANGED", function(wp)
	if firing then return end -- our own announcement
	if dismissed and not samePoint(wp, engineWp) then dismissed = false end
	engineWp = wp
	if override then return end
	pendingStep = false
	apply(false)
end)

local function stepMoved()
	if override == nil and not dismissed then return end
	override, dismissed = nil, false
	if pendingStep then return end
	pendingStep = true
	if C_Timer and C_Timer.After then
		C_Timer.After(0, settleStep)
	else
		settleStep()
	end
end
ns.On("STEP_CHANGED", stepMoved)
ns.On("GUIDE_CHANGED", stepMoved)

ns.On("SETTING_CHANGED", function(path)
	if path == "" or path == "nav" or (type(path) == "string" and path:sub(1, 4) == "nav.") then
		notify("OnSettings")
	end
end)

local function situationChanged()
	if target and not tC then resolve() end
	Nav.Refresh()
end
for _, event in ipairs({
	"PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA", "ZONE_CHANGED", "ZONE_CHANGED_INDOORS",
	"PLAYER_CONTROL_LOST", "PLAYER_CONTROL_GAINED",
}) do
	ns.RegisterEvent(event, situationChanged)
end

ns.OnInit(function()
	refreshPalette()
	local T = ns.Theme
	if type(T) == "table" and type(T.OnChanged) == "function" then
		T.OnChanged(function()
			refreshPalette()
			notify("OnTheme")
		end)
	end
	notify("OnTheme")
	notify("OnSettings")
end)

ns.OnLogin(function()
	local Engine = ns.Engine
	if Engine and Engine.GetWaypoint then engineWp = Engine.GetWaypoint() end
	apply(false)
end)

---------------------------------------------------------------------------
-- Commands
---------------------------------------------------------------------------

-- While Shortest Path Forever guides (Nav/Handoff.lua: handed off, or a
-- journey of its own runs), a command that would show Polestar's own arrow
-- or route says so in one line instead. True if it did.
function Nav.SayHandedOff()
	if not (Nav.HandedOff and Nav.HandedOff()) then return false end
	local H = Nav.handoff
	if H and H.Yielding and H.Yielding() then
		ns.Print(L["Shortest Path Forever is guiding a journey of its own. Polestar's arrow comes back when it ends."])
	else
		ns.Print(L["Shortest Path Forever is guiding. Turn off \"Hand guiding to Shortest Path Forever\" (Options, Integrations) to use Polestar's arrow."])
	end
	return true
end

-- An option with no effect while Shortest Path Forever guides: greyed out
-- then (with any `disabled` it had), its help saying why. Returns `c`.
function Nav.HandoffOption(c)
	local was = c.disabled
	c.disabled = function()
		if Nav.HandedOff and Nav.HandedOff() then return true end
		return was ~= nil and was() or false
	end
	local why = L["Greyed out while Shortest Path Forever guides: it does this itself."]
	c.help = c.help and (c.help .. " " .. why) or why
	return c
end

ns.RegisterCommand("arrow", function(rest)
	local arg = (rest or ""):lower()
	if arg == "reset" then
		ns.Set("nav.arrowPos", nil)
	elseif arg == "show" or arg == "hide" then
		if arg == "show" and Nav.SayHandedOff() then return end
		ns.Set("nav.arrow", arg == "show")
	else
		if not ns.Get("nav.arrow") and Nav.SayHandedOff() then return end
		ns.Set("nav.arrow", not ns.Get("nav.arrow"))
	end
end, L["Waypoint arrow: show, hide, reset"])

-- Two whitespace-separated coordinates take decimal points ("45.5 30.2") or a
-- decimal comma in both ("45,5 30,2"); otherwise a comma separates x and y
-- ("45,30", "45, 30 Camp"). A decimal comma in only one ("45,5 30", "45 30,2")
-- is refused: it reads just as well as x,y with a numeric label ("45,30 50"),
-- and either guess can point the arrow at a plausible wrong spot.
local function parseWay(s)
	local x, y, label = s:match("^%s*(%d+[,%.]?%d*)%s+(%d+[,%.]?%d*)(.*)$")
	if x and (label == "" or label:match("^%s")) then
		if (x:find("%d,%d") ~= nil) ~= (y:find("%d,%d") ~= nil) then return end
		x, y = x:gsub(",", "."), y:gsub(",", ".")
	else
		x, y, label = s:match("^%s*([%d%.]+)[%s,]+([%d%.]+)(.*)$")
	end
	return tonumber(x), tonumber(y), label and label:match("^%s*(.-)%s*$")
end

ns.RegisterCommand("way", function(rest)
	local x, y, label = parseWay(rest or "")
	if x and y and (x > 100 or y > 100) then x = nil end
	if not (x and y) then
		if (rest or ""):match("^%s*$") then
			Nav.ClearTarget()
		else
			ns.Print(L["Usage: /polestar way <x> <y> [label]"])
		end
		return
	end
	local C = ns.Compat
	local map = C and C.GetPlayerMapPosition and C.GetPlayerMapPosition()
	if not map then
		ns.Print(L["No position here: the game gives none in instances and on some maps."])
		return
	end
	Nav.SetTarget(map, x, y, label ~= "" and label or nil)
end, L["Point the arrow at x y on your current map (no argument clears it)"])
