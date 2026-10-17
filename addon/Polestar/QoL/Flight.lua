-- Flight masters: open the flight map straight from the gossip (Shift
-- suppresses; never when the NPC offers quests to pick up or hand in), and
-- on the open map mark the node the travel route flies to next (else the
-- current step's `fly` location) and, on TaxiFrame, draw the route's hops
-- to it in the accent. The flight is only ever taken by the player's own
-- click: nothing here calls TakeTaxiNode.
--
-- Recognising the taxi option without its localized text: the taxi gossip
-- icon (fileID 132057, Interface\GossipFrame\TaxiGossipIcon), or a flight
-- master's NPC ID (Data.lua) with a single option. Taxi maps: TaxiFrame's
-- TaxiButton<i> (Enum.UIMapSystem.Taxi) or FlightMapFrame's flight point
-- pins (Shared TaxiFrame.lua, Blizzard_FlightMap).
--
-- The route's flight and its node by ID, and the hop lines laid between the
-- displayed buttons' anchors, are adapted from Shortest Path Forever by
-- Cillian Berragan (GPL-3.0-or-later, used with permission),
-- Transport/Taxi.lua: the flight that belongs on this map is the current
-- leg, or the one right after its approach walk; its node is found by
-- nodeID through the flight master's own slot (C_TaxiMap), names only when
-- the client gives no IDs.
-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL

local type, lower, format = type, string.lower, string.format

local Flight = {}
QoL.Flight = Flight

local TAXI_ICON = 132057
Flight.TAXI_ICON = TAXI_ICON

---------------------------------------------------------------------------
-- Gossip
---------------------------------------------------------------------------

local function hasQuestBusiness(G)
	if (G.GetNumAvailableQuests and G.GetNumAvailableQuests() or 0) > 0 then return true end
	if G.GetActiveQuests then
		local active = G.GetActiveQuests() or {}
		for i = 1, #active do
			if active[i].isComplete then return true end
		end
	end
	return false
end

-- The taxi option of the open gossip, or nil.
function Flight.TaxiOption(options)
	for i = 1, #options do
		local o = options[i]
		if o.icon == TAXI_ICON or o.overrideIconID == TAXI_ICON then return o end
	end
	local npc = ns.Compat and ns.Compat.GetNpcID and ns.Compat.GetNpcID("npc")
	if npc and QoL.data.flightMasters[npc] and #options == 1 then return options[1] end
	return nil
end

-- Returns true when it opened the flight map (the gossip is then gone).
function Flight.OnGossip()
	if not QoL.On("flightAutoOpen") or QoL.Shift() then return false end
	local G = C_GossipInfo
	if not (G and G.GetOptions) then return false end
	if hasQuestBusiness(G) then return false end
	local opt = Flight.TaxiOption(G.GetOptions() or {})
	if not opt then return false end
	if opt.gossipOptionID and G.SelectOption then
		G.SelectOption(opt.gossipOptionID)
	elseif G.SelectOptionByIndex then
		G.SelectOptionByIndex(opt.orderIndex)
	else
		return false
	end
	return true
end

---------------------------------------------------------------------------
-- Destination
---------------------------------------------------------------------------

local function short(name)
	return lower(name:match("^([^,]+),") or name)
end

-- The route's flight for this map: the current leg, or the one right after
-- its approach walk; else the route's next flight further on.
function Flight.RouteFlight()
	local Nav = ns.Nav
	if not (Nav and Nav.GetRoute) then return nil end
	local legs, ci = Nav.GetRoute()
	if type(legs) ~= "table" then return nil end
	ci = ci or 1
	local leg = legs[ci]
	if leg and leg.kind == "walk" then leg = legs[ci + 1] end
	if leg and leg.kind == "fly" and leg.to then return leg end
	for i = ci, #legs do
		leg = legs[i]
		if leg.kind == "fly" and leg.to then return leg end
	end
	return nil
end

-- Where the guide wants to fly: the route's flight, else the step's fly goal.
-- Returns the name and, for a route flight, its destination's nodeID.
function Flight.Destination()
	local leg = Flight.RouteFlight()
	if leg and (leg.to.name or leg.to.id) then return leg.to.name, tonumber(leg.to.id) end
	local view, raw = QoL.CurrentStep()
	if view then
		local goals = view.goals or {}
		for g = 1, #goals do
			local gv = goals[g]
			local rg = raw and raw[g]
			if gv.t == "fly" and QoL.Open(gv) then
				local loc = (rg and rg.location) or gv.subject
				if type(loc) == "string" and loc ~= "" then return loc end
			end
		end
	end
	return nil
end

-- The open flight master's slot for a nodeID it can fly to (C_TaxiMap), or
-- nil: unknown there, unreachable, or the node you stand at. The second
-- value says the client listed this map's nodes (no name fallback then).
function Flight.SlotOf(nodeID)
	if not (nodeID and GetTaxiMapID and C_TaxiMap and C_TaxiMap.GetAllTaxiNodes) then return nil, false end
	local map = GetTaxiMapID()
	local nodes = map and C_TaxiMap.GetAllTaxiNodes(map)
	if type(nodes) ~= "table" or #nodes == 0 then return nil, false end
	local count = NumTaxiNodes and NumTaxiNodes() or 0
	for i = 1, #nodes do
		local n = nodes[i]
		local slot = n.slotIndex
		if n.nodeID == nodeID and slot and slot >= 1 and slot <= count and slot % 1 == 0 then
			local kind = TaxiNodeGetType and TaxiNodeGetType(slot)
			if kind == nil or kind == "REACHABLE" then return slot, true end
			return nil, true
		end
	end
	return nil, true
end

-- Taxi node index whose name matches `dest` (full name, or the part before the comma).
function Flight.FindNode(dest)
	if not (dest and NumTaxiNodes and TaxiNodeName) then return nil end
	local want, wantShort = lower(dest), short(dest)
	local fallback
	for i = 1, NumTaxiNodes() do
		local name = TaxiNodeName(i)
		if type(name) == "string" then
			if lower(name) == want then return i end
			if not fallback and short(name) == wantShort then fallback = i end
		end
	end
	return fallback
end

---------------------------------------------------------------------------
-- The mark on the flight map: the node's name over an arrow that bobs above
-- it, pointing down, and a ring on the node that sends out a slow ripple.
-- All in the accent, the name outlined to read on the parchment. Both loops
-- are the client's own animation groups (no OnUpdate of ours); with
-- ui.reduceMotion they do not play and the mark stands still.
---------------------------------------------------------------------------

local BOB = 5              -- the arrow's travel, pixels
local BOB_TIME = 0.55      -- one way
local RIPPLE_TIME = 1.6    -- one ripple, from the ring outwards
local RIPPLE_SCALE = 2.4

local mark

local function reduceMotion()
	return ns.Get and ns.Get("ui.reduceMotion") and true or false
end

local function markFrame()
	if mark then return mark end
	local T = ns.Theme
	local media = function(name) return T and T.Media and T.Media(name) or nil end
	mark = CreateFrame("Frame", nil, UIParent)
	mark:SetSize(40, 40)
	mark:Hide()
	-- A soft dark halo, not a glow: the taxi map is light parchment.
	local halo = mark:CreateTexture(nil, "BACKGROUND")
	halo:SetAllPoints(mark)
	halo:SetTexture(media("glow"))
	halo:SetVertexColor(0, 0, 0, 0.3)
	local ripple = mark:CreateTexture(nil, "BORDER")
	ripple:SetSize(30, 30)
	ripple:SetPoint("CENTER", mark, "CENTER", 0, 0)
	ripple:SetTexture(media("qol-fly-ring"))
	local ring = mark:CreateTexture(nil, "OVERLAY")
	ring:SetSize(30, 30)
	ring:SetPoint("CENTER", mark, "CENTER", 0, 0)
	ring:SetTexture(media("qol-fly-ring"))
	local arrow = mark:CreateTexture(nil, "OVERLAY")
	arrow:SetSize(26, 26)
	arrow:SetPoint("BOTTOM", mark, "CENTER", 0, 14)
	arrow:SetTexture(media("qol-fly-arrow"))
	local label = mark:CreateFontString(nil, "OVERLAY")
	if T and T.Font then T.Font(label, "body") end
	if T and T.SetOutline then T.SetOutline(label, true) end
	label:SetPoint("BOTTOM", arrow, "TOP", 0, BOB + 1)
	mark.Label, mark.Arrow, mark.Ripple = label, arrow, ripple

	local bob = arrow:CreateAnimationGroup()
	bob:SetLooping("BOUNCE")
	local move = bob:CreateAnimation("Translation")
	move:SetOffset(0, BOB)
	move:SetDuration(BOB_TIME)
	move:SetSmoothing("IN_OUT")
	mark.Bob = bob

	local wave = ripple:CreateAnimationGroup()
	wave:SetLooping("REPEAT")
	local grow = wave:CreateAnimation("Scale")
	if grow.SetScaleFrom then
		grow:SetScaleFrom(1, 1)
		grow:SetScaleTo(RIPPLE_SCALE, RIPPLE_SCALE)
	else
		grow:SetScale(RIPPLE_SCALE, RIPPLE_SCALE)
	end
	grow:SetDuration(RIPPLE_TIME)
	grow:SetSmoothing("OUT")
	local fade = wave:CreateAnimation("Alpha")
	fade:SetFromAlpha(0.9)
	fade:SetToAlpha(0)
	fade:SetDuration(RIPPLE_TIME)
	fade:SetSmoothing("OUT")
	mark.Wave = wave

	local function paint()
		if not (T and T.Accent) then return end
		local r, g, b = T.Accent()
		ripple:SetVertexColor(r, g, b, 1)
		ring:SetVertexColor(r, g, b, 1)
		arrow:SetVertexColor(r, g, b, 1)
		label:SetTextColor(r, g, b, 1)
	end
	paint()
	if T and T.OnChanged then T.OnChanged(paint) end
	return mark
end

-- Plays the mark's loops, or holds it still under ui.reduceMotion.
local function animate(m)
	if reduceMotion() then
		m.Bob:Stop()
		m.Wave:Stop()
		m.Ripple:Hide()
	else
		m.Ripple:Show()
		if not m.Bob:IsPlaying() then m.Bob:Play() end
		if not m.Wave:IsPlaying() then m.Wave:Play() end
	end
end

-- The node's name as the map shows it, without its zone ("Thelsamar").
local function nodeLabel(index, dest)
	local name = (TaxiNodeName and TaxiNodeName(index)) or dest or ""
	return name:match("^([^,]+),") or name
end

local function nodeFrame(index)
	if TaxiFrame and TaxiFrame.IsShown and TaxiFrame:IsShown() then
		local b = _G["TaxiButton" .. index]
		if b and b:IsShown() then return b end
	end
	local fm = FlightMapFrame
	if fm and fm.IsShown and fm:IsShown() and fm.EnumeratePinsByTemplate then
		for pin in fm:EnumeratePinsByTemplate("FlightMap_FlightPointPinTemplate") do
			if pin.taxiNodeData and pin.taxiNodeData.slotIndex == index then return pin end
		end
	end
	return nil
end

---------------------------------------------------------------------------
-- The route's hops on TaxiFrame: the game's own line art, tinted in the
-- accent, in our own texture pool laid between the displayed buttons'
-- anchors (TaxiFrame_OnShow moves overlapping nodes, then anchors their
-- centres to TaxiRouteMap's BOTTOMLEFT). The stock route lines and click
-- handler stay untouched; hovering another node hides ours while the game
-- draws that one.
---------------------------------------------------------------------------

local lines = {}
local hooked = {}
local drawnSlot

local function hideLines()
	for i = 1, #lines do lines[i]:Hide() end
end

local function anchorOf(slot)
	local b = slot and _G["TaxiButton" .. slot]
	if not b then return nil end
	local point, _, relPoint, x, y = b:GetPoint(1)
	if point == "CENTER" and relPoint == "BOTTOMLEFT" then return x, y end
	return nil
end

-- Draws the hops to slot; returns how many (0: none drawn).
-- Not with the gamepad interface (ns.GamepadUI): the route needs the
-- hooks below on the game's node buttons, whose OnEnter the gamepad's
-- navigation runs from its own code as it moves over them. The node keeps
-- its mark.
function Flight.DrawRoute(slot)
	hideLines()
	drawnSlot = nil
	local map = TaxiRouteMap
	if ns.GamepadUI() or not (slot and map and TaxiFrame and TaxiFrame:IsShown() and GetNumRoutes and TaxiGetNodeSlot and DrawLine) then return 0 end
	local hops = GetNumRoutes(slot) or 0
	local previous
	for hop = 1, hops do
		local from, to = TaxiGetNodeSlot(slot, hop, true), TaxiGetNodeSlot(slot, hop, false)
		local sx, sy = anchorOf(from)
		local dx, dy = anchorOf(to)
		if not (sx and dx) or (previous and from ~= previous) then
			hideLines()
			return 0
		end
		previous = to
		local line = lines[hop]
		if not line then
			line = map:CreateTexture(nil, "ARTWORK")
			line:SetTexture("Interface\\TaxiFrame\\UI-Taxi-Line")
			lines[hop] = line
		end
		local T = ns.Theme
		if T and T.Accent then
			local r, g, b = T.Accent()
			line:SetVertexColor(r, g, b, 1)
		end
		DrawLine(line, "TaxiRouteMap", sx, sy, dx, dy, 32, TAXIROUTE_LINEFACTOR)
		line:Show()
	end
	if previous ~= slot then
		hideLines()
		return 0
	end
	drawnSlot = slot
	return hops
end

-- Hovering another node: the game draws its route; ours comes back after.
local function hookButtons()
	if ns.GamepadUI() then return end
	for i = 1, NumTaxiNodes and NumTaxiNodes() or 0 do
		local b = _G["TaxiButton" .. i]
		if b and not hooked[b] then
			hooked[b] = true
			b:HookScript("OnEnter", function(self)
				if Flight.node and self:GetID() ~= Flight.node then hideLines() end
			end)
			b:HookScript("OnLeave", function()
				if Flight.node and TaxiFrame and TaxiFrame:IsShown() then Flight.DrawRoute(Flight.node) end
			end)
		end
	end
end

Flight.destination, Flight.node = nil, nil
-- The chat fallback (no button to mark) is said once per flight map open,
-- not again on every replan while it stays open.
local told = false

function Flight.Highlight()
	Flight.destination, Flight.node = nil, nil
	if mark then mark:Hide() end
	hideLines()
	if not QoL.On("flightHighlight") then return end
	local dest, nodeID = Flight.Destination()
	local index, listed
	if nodeID then index, listed = Flight.SlotOf(nodeID) end
	if not index and not listed then index = Flight.FindNode(dest) end
	if not index then return end
	Flight.destination, Flight.node = dest or (TaxiNodeName and TaxiNodeName(index)), index
	local anchor = nodeFrame(index)
	if anchor then
		local m = markFrame()
		m:SetParent(anchor)
		m:ClearAllPoints()
		m:SetPoint("CENTER", anchor, "CENTER", 0, 0)
		m:SetFrameLevel((anchor:GetFrameLevel() or 1) + 5)
		m.Label:SetText(nodeLabel(index, dest))
		m:Show()
		animate(m)
		hookButtons()
		Flight.DrawRoute(index)
	elseif not told then
		told = true
		ns.Print(format(L["Route: fly to %s."], TaxiNodeName(index) or dest))
	end
end

function Flight.Drawn() return drawnSlot end

ns.RegisterEvent("TAXIMAP_OPENED", function()
	told = false
	-- The map lays out its nodes in the same event; mark them after it.
	if C_Timer and C_Timer.After then C_Timer.After(0, Flight.Highlight) else Flight.Highlight() end
end)
ns.RegisterEvent("TAXIMAP_CLOSED", function()
	Flight.destination, Flight.node = nil, nil
	if mark then mark:Hide() end
	hideLines()
	drawnSlot = nil
	told = false
end)
-- A route planned while the map is open (a flight path just learned).
ns.On("ROUTE_CHANGED", function()
	if TaxiFrame and TaxiFrame:IsShown() then Flight.Highlight() end
end)
-- ui.reduceMotion stops or restarts the mark's loops at once.
ns.On("SETTING_CHANGED", function(path)
	if path ~= "" and path ~= "ui" and path ~= "ui.reduceMotion" then return end
	if mark and mark:IsShown() then animate(mark) end
end)
