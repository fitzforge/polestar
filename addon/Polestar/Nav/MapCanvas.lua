-- Polestar.MapCanvas: Polestar's drawings on Blizzard's map frames (the
-- world map, the battlefield map), on frames of its own, without writing
-- into the map. Contract: docs/ARCHITECTURE.md, "MapCanvas".
--
-- The map is Lua (Blizzard_MapCanvas, Blizzard_WorldMap), and Forever's
-- gamepad interface reads it from secure code as the map opens and closes
-- (MapCanvasMixin:OnHide walks the pins its gamepad cursor hovered,
-- FrameControlsManager refreshes its focus, then
-- Blizzard_GamepadActionBars calls the protected
-- SetPreferredGamepadInteractTarget). A value an addon wrote into the map's
-- tables (a data provider, a pin pool, a pin AcquirePin handed out, any
-- field a Blizzard method sets when an addon calls it) taints that code and
-- the game blocks the call: "An action was blocked because of taint from
-- Polestar". So Polestar adds no data provider, acquires no pin and calls
-- no map method that writes. Its frames are children of the map's canvas
-- (parenting is the client's, in C: the scroll frame clips them and they
-- show and hide with the map), each made with no parent, then set under the
-- canvas (Polestar.CreateFrameUnder, Core/Init.lua): the gamepad interface
-- hooks CreateFrame and, for a parent on the open map, rebuilds the map's
-- buttons in the caller's code. The map is only read, through
--   map:GetMapID(), map:GetCanvas(), map:GetCanvasScale(),
--   map:HasZoomLevels(), map:GetCanvasZoomPercent(), map:GetGlobalPinScale(),
--   map:GetGlobalAlpha(), map:GetPinFrameLevelsManager():GetValidFrameLevel(t)
-- (each returns a field or works one out, writing nothing) and the canvas's
-- size and place (GetWidth, GetHeight; GetLeft, GetTop, GetEffectiveScale
-- for the gamepad's map cursor, Nav/Pins.lua; with the canvas's parent's
-- GetLeft, GetTop, GetRight, GetBottom and GetEffectiveScale, the view on
-- OpenMap's stitched map, Nav/Pins.lua). Frames on the canvas carry
-- no field the client's code reads on the frames it finds there (owningMap
-- on the mouse focus, smartNavigation* and the other SmartNavigation keys
-- on the buttons it scans): such a field would be Polestar's value in that
-- code.
--
-- One view per map frame, shared by every module: a frame of Polestar's on
-- the canvas whose OnUpdate runs only while the map is shown (the client
-- does not update a hidden frame's children). Each frame it compares the
-- map ID, the canvas size, scale and zoom, the pin scale and the alpha, a
-- handful of reads, and tells its listeners only what changed. None of the
-- frames on the canvas is a button to the gamepad's navigation (a Button, or
-- a frame with an OnMouseDown or OnMouseUp script): it reads such a script
-- back as it scans the map (Nav/Pins.lua says how pins take clicks).
--
--   MapCanvas.Watch(map, fn) -> view | nil    fn(view, what, elapsed), what:
--       "show"   the map opened (the view's values are fresh): draw everything
--       "map"    another map is shown: draw everything
--       "size"   the canvas was resized (positions in canvas units changed)
--       "scale"  the canvas scale, the zoom or the pin scale changed
--       "alpha"  the map's global alpha changed (the battlefield map's opacity)
--       "hide"   the map closed
--       "tick"   every frame while the map is shown, after the above
--   view.map, view.canvas, view.shown, view.mapID, view.width, view.height,
--   view.scale, view.zoom (0..1), view.pinScale, view.alpha
--   view:Level(levelType) -> the frame level the map gives pins of that level type
--   view:PinScale(startScale, endScale) -> the scale MapCanvasPinMixin gives a
--       pin with SetScalingLimits(1, startScale, endScale): constant on screen
--       at startScale zoomed out, endScale zoomed in

local ADDON, ns = ...

local MapCanvas = {}
ns.MapCanvas = MapCanvas

local views = {} -- map frame -> view

local View = {}
View.__index = View

-- A listener that errors is reported once and left out until the map is
-- next opened: the view fires every frame, and an error a frame is a stream
-- of error popups that can stall the client.
local function fire(view, what, elapsed)
	local list, muted = view.listeners, view.muted
	if what == "show" then wipe(muted) end
	for i = 1, #list do
		local fn = list[i]
		if not muted[fn] then
			local ok, err = pcall(fn, view, what, elapsed)
			if not ok then
				muted[fn] = true
				ns.NoteError(err)
				geterrorhandler()(err)
			end
		end
	end
end

-- What the map shows now; every call a read.
local function read(view)
	local map, canvas = view.map, view.canvas
	local id = map:GetMapID()
	local w, h = canvas:GetWidth() or 0, canvas:GetHeight() or 0
	local s = map.GetCanvasScale and map:GetCanvasScale() or 1
	if not s or s <= 0 then s = 1 end
	local z = 0
	if map.GetCanvasZoomPercent and (not map.HasZoomLevels or map:HasZoomLevels()) then
		z = map:GetCanvasZoomPercent() or 0
		if z < 0 then z = 0 elseif z > 1 then z = 1 end
	end
	local ps = map.GetGlobalPinScale and map:GetGlobalPinScale() or 1
	local a = map.GetGlobalAlpha and map:GetGlobalAlpha() or 1
	return id, w, h, s, z, ps, a
end

local function update(view, elapsed)
	local id, w, h, s, z, ps, a = read(view)
	local first = not view.shown
	local mapChanged = id ~= view.mapID
	local sized = w ~= view.width or h ~= view.height
	local scaled = s ~= view.scale or z ~= view.zoom or ps ~= view.pinScale
	local faded = a ~= view.alpha
	view.mapID, view.width, view.height, view.scale, view.zoom, view.pinScale, view.alpha = id, w, h, s, z, ps, a
	if first then
		view.shown = true
		fire(view, "show")
	elseif mapChanged then
		fire(view, "map")
	else
		if sized then fire(view, "size") end
		if scaled then fire(view, "scale") end
		if faded then fire(view, "alpha") end
	end
	if elapsed then fire(view, "tick", elapsed) end
end

function View:Level(levelType)
	local map = self.map
	local levels = map.GetPinFrameLevelsManager and map:GetPinFrameLevelsManager()
	local level = levels and levels.GetValidFrameLevel and levels:GetValidFrameLevel(levelType)
	return level or self.canvas:GetFrameLevel() + 1
end

function View:PinScale(startScale, endScale)
	return (startScale + (endScale - startScale) * (self.zoom or 0)) * (self.pinScale or 1) / (self.scale or 1)
end

function MapCanvas.Watch(map, fn)
	local view = views[map]
	if not view then
		if not (type(map) == "table" and map.GetMapID and map.GetCanvas) then return nil end
		local canvas = map:GetCanvas()
		if not canvas then return nil end
		view = setmetatable({ map = map, canvas = canvas, shown = false, listeners = {}, muted = {} }, View)
		local f = ns.CreateFrameUnder("Frame", nil, canvas)
		f:SetScript("OnUpdate", function(_, elapsed) update(view, elapsed or 0) end)
		f:SetScript("OnHide", function()
			if not view.shown then return end
			view.shown = false
			fire(view, "hide")
		end)
		views[map] = view
	end
	if fn then view.listeners[#view.listeners + 1] = fn end
	return view
end

-- The view of a map frame, when a module watches it.
function MapCanvas.Get(map)
	return views[map]
end
