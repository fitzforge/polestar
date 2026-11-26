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
-- the canvas (view.frame) whose OnUpdate runs only while the map is shown
-- (the client does not update a hidden frame's children). Each frame it
-- compares the map ID, the canvas size, scale and zoom, the pin scale and
-- the alpha, a handful of reads, and tells its listeners only what changed.
-- Every module's frames on that map are made under view.frame, not the
-- canvas: while Polestar is hidden (ns.Hidden) the view frame hides, which
-- takes them all off the map and stops the ticks ("hide"), and showing it
-- again draws everything afresh ("show" on the open map's next frame). None
-- of the frames on the canvas is a button to the gamepad's navigation (a
-- Button, or a frame with an OnMouseDown or OnMouseUp script): it reads such
-- a script back as it scans the map (Nav/Pins.lua says how pins take clicks).
--
--   MapCanvas.Watch(map, fn) -> view | nil    fn(view, what, elapsed), what:
--       "show"   the map opened, or Polestar came back on the open map (the
--                view's values are fresh): draw everything
--       "map"    another map is shown: draw everything
--       "size"   the canvas was resized (positions in canvas units changed)
--       "scale"  the canvas scale, the zoom or the pin scale changed
--       "alpha"  the map's global alpha changed (the battlefield map's opacity)
--       "hide"   the map closed, or Polestar was hidden
--       "tick"   every frame while the map is shown, after the above
--   view.map, view.canvas, view.frame, view.shown, view.mapID, view.width,
--   view.height, view.scale, view.zoom (0..1), view.pinScale, view.alpha,
--   view.clip (the frame the canvas shows through, when it isn't the canvas's
--   parent: OpenMap's view, below), view.covered (the world map's view while
--   OpenMap's own view covers the map: what is drawn on it doesn't show, and
--   takes no gamepad cursor)
--   view:Level(levelType) -> the frame level the map gives pins of that level type
--   view:PinScale(startScale, endScale) -> the scale MapCanvasPinMixin gives a
--       pin with SetScalingLimits(1, startScale, endScale): constant on screen
--       at startScale zoomed out, endScale zoomed in
--
--   MapCanvas.Add(map)   another addon's map canvas (a MapCanvasMixin frame,
--       e.g. Polestar: UI's PolestarUIWorldMapCanvas): every module that draws
--       on the world map draws on it too, with frames of its own. Call it once,
--       after the frame is made; it is only read, as the world map is.
--   MapCanvas.Add(map, true)   a map that stands in for the world map over
--       another addon's art (OpenMap's views, below): only the modules that
--       asked for such maps draw on it (route lines, pins), not the ones that
--       belong to Blizzard's art (unexplored areas, zone levels, the info bar).
--   MapCanvas.OnAdd(fn, covers)  fn(map) for every map added, now and later
--       (modules); with covers, for the stand-in maps too

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
		f:SetScript("OnUpdate", ns.Safe(function(_, elapsed) update(view, elapsed or 0) end))
		f:SetScript("OnHide", function()
			if not view.shown then return end
			view.shown = false
			fire(view, "hide")
		end)
		f:SetShown(not ns.Hidden())
		view.frame = f
		views[map] = view
	end
	if fn then view.listeners[#view.listeners + 1] = fn end
	return view
end

-- Hiding Polestar takes its drawings off every map at once.
ns.On("POLESTAR_HIDDEN", function(hidden)
	for _, view in pairs(views) do view.frame:SetShown(not hidden) end
end)

local added, onAdd = {}, {} -- { map, covers } each; { fn, covers } each

function MapCanvas.Add(map, covers)
	if not (type(map) == "table" and map.GetMapID and map.GetCanvas) or map == WorldMapFrame then return end
	for i = 1, #added do if added[i].map == map then return end end
	covers = covers and true or false
	added[#added + 1] = { map = map, covers = covers }
	for i = 1, #onAdd do
		local h = onAdd[i]
		if h.covers or not covers then ns.SafeCall(h.fn, map) end
	end
end

function MapCanvas.OnAdd(fn, covers)
	local h = { fn = fn, covers = covers and true or false }
	onAdd[#onAdd + 1] = h
	for i = 1, #added do
		local a = added[i]
		if h.covers or not a.covers then ns.SafeCall(fn, a.map) end
	end
end

-- The view of a map frame, when a module watches it.
function MapCanvas.Get(map)
	return views[map]
end

---------------------------------------------------------------------------
-- OpenMap's own views (OpenMap, an optional world map addon; its
-- OpenMapAPI). Two of them draw OpenMap's map on frames of its own over the
-- world map and make the map's canvas see-through (its alpha 0), so what
-- Polestar draws on that canvas doesn't show there (#4206):
--   "pad"    its controller view (with the game's Gamepad UI on and its
--            "OpenMap's map with the Gamepad UI" switch): a frame on the
--            world map over its scroll frame, whose canvas, anchored by its
--            top left on that frame's centre, is OpenMap's whole stitched
--            world (OpenMapAPI's u, v times the canvas's size) at the view's
--            zoom (its scale). OpenMapAPI.IsStitched says false.
--   "fight"  its view while its own map is open in a fight: a frame on the
--            scroll frame, whose canvas, anchored by its top left on that
--            frame's top left, is laid out as the map's canvas (its size).
-- OpenMapAPI has nothing for these views, so each is recognised by that
-- shape, only read (the frames' children, points, size and scale). On its
-- canvas Polestar puts a frame of its own, `host`, over the map the view
-- shows, in that map's place, and adds `cover` with MapCanvas.Add(cover,
-- true): a map whose canvas is `host`, so the route lines and pins draw
-- there as on the world map, in percent of that map. The controller view's
-- map is the one at its centre (OpenMapAPI.MapAt), or the zone or
-- continent holding it, the first that spans FILL of the view across or
-- down, placed through OpenMapAPI.WorldFromMap; in a fight, the world map's
-- own. Nothing of OpenMap's is written or hooked: `host` is made with no
-- parent and then set under its canvas, as Polestar's frames on the map are.
-- Meanwhile the world map's view is `covered`.
---------------------------------------------------------------------------

local WORLD = 947             -- Azeroth: OpenMap's stitched world, above every continent
local ART_LEVELS = 82         -- the levels over OpenMap's canvas its art takes (its 80, from the canvas's + 2)
local FILL = 0.5              -- the controller view's map spans this share of the view (across or down)
local ZOOM_SPAN = math.log(4) -- zoom percent 1 at four times the view that fits the map
local OM_PIN_LEVELS = { PIN_FRAME_LEVEL_QUEST_BLOB = 1 } -- over `host`'s level; every other kind 2

local om = { zoom = 0 }       -- the view up: frame, canvas, kind, map; zoom (0..1); the place host is set for
local host                    -- Polestar's frame on OpenMap's canvas, over the map shown
local worldView               -- the world map's view, watched for OpenMap's

-- The stand-in map: what MapCanvas and the modules read of a map, answered
-- from OpenMap's view (only read) and `host`.
local cover = {}
local coverLevels = {}
function coverLevels:GetValidFrameLevel(levelType) return host:GetFrameLevel() + (OM_PIN_LEVELS[levelType] or 2) end
function cover:GetMapID() return om.map end
function cover:GetCanvas() return host end
function cover:GetCanvasScale() return om.canvas and om.canvas:GetScale() or 1 end
function cover:HasZoomLevels() return true end
function cover:GetCanvasZoomPercent() return om.zoom end
function cover:GetGlobalPinScale() return WorldMapFrame.GetGlobalPinScale and WorldMapFrame:GetGlobalPinScale() or 1 end
function cover:GetGlobalAlpha() return 1 end
function cover:GetPinFrameLevelsManager() return coverLevels end

local function api()
	local O = _G.OpenMapAPI
	if type(O) == "table" and O.major == 1 and type(O.IsStitched) == "function" and type(O.WorldFromMap) == "function" then return O end
end

-- OpenMap's frame on the scroll frame `sc` among `parent`'s children (not
-- the map's canvas), and its canvas: its first child, anchored by its top
-- left on the frame's `relPoint` alone (with sameSize: the map canvas's size).
local function findView(parent, sc, canvas, relPoint, sameSize)
	local kids = { parent:GetChildren() }
	for i = 1, #kids do
		local f = kids[i]
		if f ~= sc and f ~= canvas and f:IsShown() and f:GetNumPoints() > 0 and select(2, f:GetPoint(1)) == sc then
			local c = f:GetChildren()
			if c and c:GetNumPoints() == 1 then
				local point, rel, relPoint2 = c:GetPoint(1)
				if point == "TOPLEFT" and rel == f and relPoint2 == relPoint
					and (not sameSize or (c:GetWidth() == canvas:GetWidth() and c:GetHeight() == canvas:GetHeight())) then
					return f, c
				end
			end
		end
	end
end

-- A map's rectangle on OpenMap's stitched world (u, v: 0..1), or nil.
local function worldRect(O, mapID)
	if not mapID then return nil end
	local ok, l, t = pcall(O.WorldFromMap, mapID, 0, 0)
	local ok2, r, b = pcall(O.WorldFromMap, mapID, 1, 1)
	if ok and ok2 and type(l) == "number" and type(t) == "number" and type(r) == "number" and type(b) == "number"
		and r > l and b > t then
		return l, t, r, b
	end
end

-- The controller view's map: at its centre, widened to the first that spans
-- FILL of it (W, H: the canvas's size, the stitched world's; px its scale).
local function padMap(O, f, c, W, H, px)
	if type(O.MapAt) ~= "function" then return om.map end
	local _, _, _, x, y = c:GetPoint(1)
	if type(x) ~= "number" or type(y) ~= "number" then return om.map end
	local ok, m = pcall(O.MapAt, -x / W, y / H)
	if not (ok and type(m) == "number") then return om.map end
	local spanU, spanV = FILL * f:GetWidth() / (W * px), FILL * f:GetHeight() / (H * px)
	local pick
	for _ = 1, 8 do
		local l, t, r, b = worldRect(O, m)
		if l then
			pick = m
			if r - l >= spanU or b - t >= spanV then break end
		end
		local info = C_Map.GetMapInfo(m)
		local parent = info and info.parentMapID
		if not parent or parent == 0 or parent == WORLD then break end
		m = parent
	end
	return pick or om.map
end

local function drop()
	if not om.frame then return end
	om.frame, om.canvas, om.kind = nil, nil, nil
	if worldView then worldView.covered = false end
	if host then host:Hide() end
end

-- Each frame of the open world map: OpenMap's view, if one covers it, and
-- `host` where its map is.
local function followOpenMap(view, what)
	if what == "hide" then return drop() end
	if what ~= "tick" then return end
	local O, canvas = api(), view.canvas
	if not O or canvas:GetAlpha() > 0 then return drop() end
	local okS, stitched = pcall(O.IsStitched)
	local kind = okS and stitched and "fight" or "pad"
	local f, c = om.frame, om.canvas
	if not (f and om.kind == kind and f:IsShown()) then
		local sc = canvas:GetParent()
		if kind == "pad" then
			f, c = findView(view.map, sc, canvas, "CENTER")
		else
			-- (its canvas laid out as the map's: the same size)
			f, c = findView(sc, sc, canvas, "TOPLEFT", true)
		end
		if not f then return drop() end
	end
	local W, H, px = c:GetWidth(), c:GetHeight(), c:GetScale()
	if not (W and H and px and W > 0 and H > 0 and px > 0) then return drop() end
	local mapID, l, t, r, b
	if kind == "pad" then
		mapID = padMap(O, f, c, W, H, px) or view.mapID
		l, t, r, b = worldRect(O, mapID)
		if not l then return drop() end
	else
		mapID, l, t, r, b = view.mapID, 0, 0, 1, 1
	end
	if not host then
		host = ns.CreateFrameUnder("Frame", nil, c)
		host:SetSize(1, 1)
		MapCanvas.Add(cover, true)
	end
	if om.placed ~= c or om.map ~= mapID or om.l ~= l or om.t ~= t or om.r ~= r or om.b ~= b or om.w ~= W or om.h ~= H then
		if host:GetParent() ~= c then host:SetParent(c) end
		host:ClearAllPoints()
		host:SetPoint("TOPLEFT", c, "TOPLEFT", l * W, -t * H)
		host:SetSize((r - l) * W, (b - t) * H)
		local level = c:GetFrameLevel() + ART_LEVELS
		if type(O.ArtTopLevel) == "function" then
			local ok, top = pcall(O.ArtTopLevel)
			if ok and type(top) == "number" and top + 1 > level then level = top + 1 end
		end
		host:SetFrameLevel(level)
		om.placed, om.l, om.t, om.r, om.b, om.w, om.h = c, l, t, r, b, W, H
	end
	local fit = math.min(f:GetWidth() / ((r - l) * W), f:GetHeight() / ((b - t) * H))
	local zoom = fit > 0 and math.log(px / fit) / ZOOM_SPAN or 0
	om.zoom = zoom < 0 and 0 or zoom > 1 and 1 or zoom
	om.frame, om.canvas, om.kind, om.map = f, c, kind, mapID
	view.covered = true
	if not host:IsShown() then host:Show() end
	local v = views[cover]
	if v then v.clip = f end
end

-- Only with OpenMap loaded (an optional dependency: before Polestar).
ns.OnLogin(function()
	if not api() then return end
	local function install()
		if worldView or not WorldMapFrame then return worldView ~= nil end
		worldView = MapCanvas.Watch(WorldMapFrame, followOpenMap)
		return worldView ~= nil
	end
	if install() then return end
	local function onLoaded(_, name)
		if name == "Blizzard_WorldMap" and install() then ns.UnregisterEvent("ADDON_LOADED", onLoaded) end
	end
	ns.RegisterEvent("ADDON_LOADED", onLoaded)
end)
