-- Placing on the world map: while a placement tool is armed, a left click on
-- the world map's canvas is the tool's point (WorldMapFrame's canvas click
-- handlers run before the map's own zoom; returning true takes the click).
-- A small bar under the map shows what is being placed, how many points, and
-- Undo / Finish / Cancel. Right-click on the map undoes the last point.
--
--   S.UI.Arm({ label, single = true, min = 1, onPoint(map, x, y), onFinish(points), onCancel })
--       points = { { map, x, y }, ... } (x, y 0-100, the live map frame)
--   S.UI.Disarm()  S.UI.Armed() -> spec | nil

local ADDON, S = ...
local L = S.L
local UI = S.UI
local Theme, W = UI.Theme, UI.W
local format = string.format

local armed, points = nil, {}
local bar, hooked

local function refreshBar()
	if not bar then return end
	if not armed then bar:Hide() return end
	bar.Text:SetText(armed.single and armed.label
		or format(L["%s: %d points. Click the map to add, right-click to undo."], armed.label, #points))
	bar.Undo:SetShown(not armed.single)
	bar.Finish:SetShown(not armed.single)
	if not armed.single then
		local ok = #points >= (armed.min or 1)
		if ok then bar.Finish:Enable() else bar.Finish:Disable() end
		bar.Finish:SetAlpha(ok and 1 or 0.45)
	end
	bar:Show()
end

local function finish()
	local spec, pts = armed, points
	armed, points = nil, {}
	refreshBar()
	if spec and spec.onFinish then spec.onFinish(pts) end
end

function UI.Disarm(silent)
	local spec = armed
	armed, points = nil, {}
	refreshBar()
	if spec and spec.onCancel and not silent then spec.onCancel() end
end

local function undo()
	if #points > 0 then
		points[#points] = nil
		refreshBar()
	end
end

local function onCanvasClick(canvas, button)
	if not armed then return false end
	if button == "RightButton" then
		if armed.single then UI.Disarm() else undo() end
		return true
	end
	if button ~= "LeftButton" then return false end
	local map = canvas:GetMapID()
	local x, y = canvas:GetNormalizedCursorPosition()
	if not (map and x and y) or x < 0 or x > 1 or y < 0 or y > 1 then return false end
	x, y = x * 100, y * 100
	if armed.onPoint then armed.onPoint(map, x, y) end
	if armed.single then
		points = { { map = map, x = x, y = y } }
		finish()
	else
		if points[1] and points[1].map ~= map then
			UI.Say(L["Every point of one path or area is on one map."], "warning")
			return true
		end
		points[#points + 1] = { map = map, x = x, y = y }
		refreshBar()
	end
	return true
end

local function buildBar()
	local map = WorldMapFrame
	local host = map.ScrollContainer or map
	bar = CreateFrame("Frame", nil, map)
	bar:SetHeight(34)
	bar:SetPoint("TOPLEFT", host, "TOPLEFT", 8, -8)
	bar:SetPoint("TOPRIGHT", host, "TOPRIGHT", -8, -8)
	bar:SetFrameStrata("DIALOG")
	Theme.Skin(bar, "panel")
	bar.Glyph = W.Tex(bar, "ARTWORK", "flag", "accent")
	bar.Glyph:SetSize(14, 14)
	bar.Glyph:SetPoint("LEFT", bar, "LEFT", 10, 0)
	bar.Cancel = W.Button(bar, L["Cancel"], function() UI.Disarm() end, { ghost = true, height = 24 })
	bar.Cancel:SetPoint("RIGHT", bar, "RIGHT", -6, 0)
	bar.Finish = W.Button(bar, L["Finish"], finish, { primary = true, height = 24 })
	bar.Finish:SetPoint("RIGHT", bar.Cancel, "LEFT", -6, 0)
	bar.Undo = W.Button(bar, L["Undo point"], undo, { height = 24 })
	bar.Undo:SetPoint("RIGHT", bar.Finish, "LEFT", -6, 0)
	bar.Text = W.Text(bar, "label", "text")
	bar.Text:SetPoint("LEFT", bar.Glyph, "RIGHT", 8, 0)
	bar.Text:SetPoint("RIGHT", bar.Undo, "LEFT", -8, 0)
	bar:Hide()
	map:HookScript("OnHide", function() if armed then UI.Disarm() end end)
end

local function hook()
	local map = WorldMapFrame
	if hooked or not (map and map.AddCanvasClickHandler and map.GetNormalizedCursorPosition) then return hooked end
	map:AddCanvasClickHandler(onCanvasClick)
	buildBar()
	hooked = true
	return true
end

function UI.Arm(spec)
	if not hook() then
		UI.Say(L["The world map is not available."], "danger")
		return
	end
	UI.Disarm(true)
	armed, points = spec, {}
	if not WorldMapFrame:IsShown() then
		if ToggleWorldMap then ToggleWorldMap() else WorldMapFrame:Show() end
	end
	refreshBar()
end

function UI.Armed() return armed end

-- Open the world map on a goal's point (the "show on map" button). Polestar
-- draws the guide's own pins there; this only opens the right map.
function UI.ShowOnMap(out)
	local map = out and out.map
	if not map then
		UI.Say(L["This goal has no place on a map."], "warning")
		return
	end
	if not WorldMapFrame:IsShown() then
		if ToggleWorldMap then ToggleWorldMap() else WorldMapFrame:Show() end
	end
	if WorldMapFrame.SetMapID then WorldMapFrame:SetMapID(map) end
	local x, y = out.x, out.y
	if not x and out.pts and out.pts[1] then x, y = out.pts[1].x, out.pts[1].y end
	if x and y and C_Map and C_Map.SetUserWaypoint and UiMapPoint and UiMapPoint.CreateFromCoordinates then
		pcall(C_Map.SetUserWaypoint, UiMapPoint.CreateFromCoordinates(map, x / 100, y / 100))
	end
end
