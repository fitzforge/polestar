-- Position HUD (spec 4.3): the live map, x/y, zone and subzone (area id),
-- and the path recorder: while recording, a point every 8 yards walked, the
-- point count and the distance, undo last point, loop, finish (a `path`
-- goal) or discard.
--
--   S.UI.Recorder.Start(cycle) / Finish() / Discard() / Undo() / Active()

local ADDON, S = ...
local L = S.L
local UI = S.UI
local P = _G.Polestar
local Theme, W = UI.Theme, UI.W
local format, sqrt, floor = string.format, math.sqrt, math.floor

local STEP_YARDS = 8
local MAX_POINTS = 200

local R = { points = {}, yards = 0, cycle = false }
UI.Recorder = R
local hud

local function world(map, x, y)
	local C = P.Compat
	if not (C and C.MapToWorld) then return nil end
	return C.MapToWorld(map, x, y)
end

local function dist(a, b)
	local c1, y1, x1 = world(a.map, a.x, a.y)
	local c2, y2, x2 = world(b.map, b.x, b.y)
	if not (c1 and c2 and c1 == c2) then return nil end
	return sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
end

function R.Active() return R.on and true or false end

local sampler = CreateFrame("Frame")
local elapsed = 0
local function sample(_, dt)
	elapsed = elapsed + dt
	if elapsed < 0.25 then return end
	elapsed = 0
	local here = UI.Here()
	if not here then return end
	local pts = R.points
	local last = pts[#pts]
	if last and last.map ~= here.map then
		if not R.warned then
			UI.Say(L["You left the path's map: finish this path and start another."], "warning")
			R.warned = true
		end
		return
	end
	local p = { map = here.map, x = here.x, y = here.y }
	if not last then
		pts[1] = p
	else
		local d = dist(last, p)
		if d and d >= STEP_YARDS then
			if #pts >= MAX_POINTS then
				UI.Say(format(L["A path takes at most %d points: finish this one."], MAX_POINTS), "warning")
				return
			end
			pts[#pts + 1] = p
			R.yards = R.yards + d
		end
	end
	if hud and hud:IsShown() then hud:Refresh() end
end

function R.Start(cycle)
	if not UI.Ready() then return end
	if not UI.Here() then
		UI.Say(L["The game gives no position here (inside an instance?)."], "warning")
		return
	end
	R.points, R.yards, R.cycle, R.on, R.warned = {}, 0, cycle and true or false, true, nil
	elapsed = 1
	sampler:SetScript("OnUpdate", sample)
	UI.ShowWidget("PositionHUD", true)
	UI.Say(L["Recording a path: walk it, then Finish on the position HUD."], "success")
	S.Fire("STUDIO_RECORDING", true)
end

local function stop()
	R.on = false
	sampler:SetScript("OnUpdate", nil)
	S.Fire("STUDIO_RECORDING", false)
	if hud then hud:Refresh() end
end

function R.Finish()
	if not R.on then return end
	local pts = R.points
	stop()
	if #pts < 2 then
		UI.Say(L["A path needs at least 2 points: walk a little further."], "warning")
		return
	end
	UI.Resolve("Path", pts, R.cycle)
	R.points = {}
end

function R.Discard()
	stop()
	R.points = {}
end

function R.Undo()
	local pts = R.points
	if #pts > 1 then
		local d = dist(pts[#pts - 1], pts[#pts])
		R.yards = math.max(0, R.yards - (d or 0))
	end
	pts[#pts] = nil
	if hud then hud:Refresh() end
end

function R.Toggle(cycle)
	if R.on then R.Finish() else R.Start(cycle) end
end

local function refresh(f)
	local here = S.Resolve.Here and S.Resolve.Here()
	if here and here.map then
		f.Map:SetText(format("%s  (map %d)", UI.MapName(here.map) or "?", here.map))
		f.XY:SetText(format("%.2f, %.2f", here.x, here.y))
	elseif here and here.instance then
		f.Map:SetText(format(L["Instance %d: no map position here"], here.instance))
		f.XY:SetText("")
	else
		f.Map:SetText(L["No position"])
		f.XY:SetText("")
	end
	local sub = here and here.areaName
	f.Area:SetText(format("%s%s%s", here and here.zoneName or "", sub and sub ~= "" and ("  \194\183  " .. sub) or "",
		here and here.area and format("  (area %d)", here.area) or ""))
	f.Rec:SetShown(R.on)
	f.RecInfo:SetShown(R.on)
	if R.on then
		f.RecInfo:SetText(format(L["Recording: %d points, %d yards%s"], #R.points, floor(R.yards + 0.5), R.cycle and L[", loop"] or ""))
		W.SetButtonText(f.Record, L["Finish path"])
		W.SetIconState(f.Loop, R.cycle, true)
	else
		W.SetButtonText(f.Record, L["Record path"])
		W.SetIconState(f.Loop, R.cycle, true)
	end
	f.Undo:SetShown(R.on)
	f.Discard:SetShown(R.on)
end

UI.Widget("PositionHUD", "Position", 300, 170, function(f)
	hud = f
	local b = f.Body
	f.Map = W.Text(b, "body", "place")
	f.Map:SetPoint("TOPLEFT", b, "TOPLEFT", 12, -10)
	f.Map:SetPoint("RIGHT", b, "RIGHT", -12, 0)
	f.XY = W.Text(b, "display", "text")
	f.XY:SetPoint("TOPLEFT", f.Map, "BOTTOMLEFT", 0, -4)
	f.Area = W.Text(b, "small", "area")
	f.Area:SetPoint("TOPLEFT", f.XY, "BOTTOMLEFT", 0, -4)
	f.Area:SetPoint("RIGHT", b, "RIGHT", -12, 0)
	f.Rec = W.Tex(b, "ARTWORK", "record", "danger")
	f.Rec:SetSize(12, 12)
	f.Rec:SetPoint("TOPLEFT", f.Area, "BOTTOMLEFT", 0, -8)
	f.RecInfo = W.Text(b, "small", "text")
	f.RecInfo:SetPoint("LEFT", f.Rec, "RIGHT", 6, 0)
	f.Waypoint = W.Button(b, L["Waypoint here"], function() S.Tools.Run("waypoint") end, { height = 24 })
	f.Waypoint:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 10, 10)
	f.Record = W.Button(b, L["Record path"], function() R.Toggle(R.cycle) end, { height = 24, primary = true })
	f.Record:SetPoint("LEFT", f.Waypoint, "RIGHT", 6, 0)
	f.Loop = UI.Icon(b, "reload", L["Loop: the path starts over after its last point (a farm loop)"], function()
		R.cycle = not R.cycle
		refresh(f)
	end, 24)
	f.Loop:SetPoint("LEFT", f.Record, "RIGHT", 4, 0)
	f.Undo = UI.Icon(b, "chevron-left", L["Undo the last point"], function() R.Undo() end, 24)
	f.Undo:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -34, 10)
	f.Discard = UI.Icon(b, "close", L["Discard the recording"], function() R.Discard() end, 24)
	f.Discard:SetPoint("LEFT", f.Undo, "RIGHT", 4, 0)
	f.Refresh = refresh
	local t = 0
	f:SetScript("OnUpdate", function(self, dt)
		t = t + dt
		if t < 0.5 then return end
		t = 0
		refresh(self)
	end)
end, { point = { "TOP", "TOP", 0, -120 } })
