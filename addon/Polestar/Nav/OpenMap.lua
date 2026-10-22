-- Polestar.OpenMap: everything Polestar does with OpenMap, an optional world
-- map addon (its OpenMapAPI: docs/api.md in its repository). OpenMap stitches
-- every zone into one map inside Blizzard's world map: while it does, the map
-- frame's own map is only the zone, continent or world (947) under the
-- view's centre (the host map), and the art around it is OpenMap's. Polestar's
-- drawings (Nav/Pins.lua's pins and trail, Maps/RouteLines.lua's lines) go on
-- across all of it through this file: world yards on a continent -> percent of
-- the host map, as OpenMap places that continent's maps on its world; clipped
-- to what the view shows rather than to the host map. Contract:
-- docs/ARCHITECTURE.md, "OpenMap".
--
-- Only OpenMap's table is called (read-only, plus Polestar's own switches in
-- its menu and a section on its dungeon card); the map frame is read as
-- everywhere else (Nav/MapCanvas.lua). Without OpenMap, or with its map
-- switched to Blizzard's own, every function here answers nil and the
-- drawings stay on the host map as before.
--
--   OpenMap.API() -> OpenMapAPI | nil         loaded, major version 1
--   OpenMap.Stitched() -> OpenMapAPI | nil    and its stitched map shows
--   OpenMap.Fit(host, c) -> fit | nil         world yards on continent c -> host percent:
--       x = fit.ub * wy + fit.uc, y = fit.va * wx + fit.vc (measured once per host and continent)
--   OpenMap.ViewRect(view) -> x0, y0, x1, y1  what the map's scroll frame shows, host percent
--   OpenMap.ViewMoved(view, rect) -> bool     the view left rect = { x0, y0, x1, y1 } (a pan or a zoom)
--   OpenMap.Level(level) -> level             at least one above OpenMap's art
--   OpenMap.Show(c, wx, wy, zoom) -> bool     glide the stitched view to a world point
--   OpenMap.OnChange(fn)                      fn() when the stitched map comes or goes, or OpenMap loads
--   OpenMap.Toggle(spec)                      a switch in OpenMap's menu, Polestar's section:
--       { id, label, setting (a settings path), icon, tab }
--   OpenMap.DungeonSection(fn)                fn(info) -> title, lines on OpenMap's dungeon card

local ADDON, ns = ...

local type, pairs, ipairs, pcall, abs = type, pairs, ipairs, pcall, math.abs

local OpenMap = {}
ns.OpenMap = OpenMap

local WORLD_MAP = 947
local SECTION = "Polestar"

local hooked = false    -- the callbacks, switches and section handed to OpenMap
local listeners = {}    -- OnChange fns
local toggles = {}      -- specs, in the order given (handed over once OpenMap is there)
local section           -- the dungeon card's fn
local refs = {}         -- host map -> { [continent] = { map, c, left, top, kx, ky } }, measured once
local fits = {}         -- host map -> { [continent] = fit | false }

local function changed()
	for i = 1, #listeners do ns.SafeCall(listeners[i]) end
end

local function register(O, spec)
	if type(O.RegisterMenuToggle) ~= "function" then return end
	pcall(O.RegisterMenuToggle, ADDON, {
		id = spec.id,
		label = spec.label,
		section = SECTION,
		icon = spec.icon,
		tab = spec.tab,
		get = function() return ns.Get(spec.setting) and true or false end,
		set = function(on) ns.Set(spec.setting, on and true or false) end,
	})
end

local function hook(O)
	if hooked then return end
	hooked = true
	if type(O.RegisterCallback) == "function" then
		pcall(O.RegisterCallback, OpenMap, "OpenMap_StitchedChanged", function()
			fits = {}
			changed()
		end)
	end
	for _, spec in ipairs(toggles) do register(O, spec) end
	if section and type(O.RegisterDungeonSection) == "function" then pcall(O.RegisterDungeonSection, ADDON, section) end
end

function OpenMap.API()
	local O = _G.OpenMapAPI
	if type(O) ~= "table" or O.major ~= 1 or type(O.IsStitched) ~= "function"
		or type(O.WorldFromMap) ~= "function" or type(O.MapFromWorld) ~= "function" then
		return nil
	end
	hook(O)
	return O
end

function OpenMap.Stitched()
	local O = OpenMap.API()
	if not O then return nil end
	local ok, on = pcall(O.IsStitched)
	return ok and on and O or nil
end

-- A map's continent and its world yards -> percent, or nil.
local function frameOf(C, mapID)
	local c1, top, left = C.MapToWorld(mapID, 0, 0)
	local c2, bottom, right = C.MapToWorld(mapID, 100, 100)
	if not (c1 and c1 == c2 and top ~= bottom and left ~= right) then return nil end
	return { map = mapID, c = c1, left = left, top = top, kx = 100 / (right - left), ky = 100 / (bottom - top) }
end

-- The maps that tell each continent's world yards on the host map: the
-- host itself on one continent, else (the world map) its children.
local function refsFor(C, host)
	local r = refs[host]
	if r then return r end
	r = {}
	local own = frameOf(C, host)
	if own then
		r[own.c] = own
	elseif C_Map and C_Map.GetMapChildrenInfo then
		local ok, kids = pcall(C_Map.GetMapChildrenInfo, host)
		if ok and type(kids) == "table" then
			for _, kid in ipairs(kids) do
				local f = kid and kid.mapID and frameOf(C, kid.mapID)
				if f and not r[f.c] then r[f.c] = f end
			end
		end
	end
	refs[host] = r
	return r
end

function OpenMap.Fit(host, c)
	local O = OpenMap.Stitched()
	local C = ns.Compat
	if not (O and host and c and C and C.MapToWorld) then return nil end
	local byC = fits[host]
	if not byC then
		byC = {}
		fits[host] = byC
	end
	local fit = byC[c]
	if fit ~= nil then return fit or nil end
	local ref = refsFor(C, host)[c]
	if not ref then
		byC[c] = false
		return nil
	end
	local ok, u0, v0 = pcall(O.WorldFromMap, ref.map, 0, 0)
	local ok1, u1, v1 = pcall(O.WorldFromMap, ref.map, 1, 1)
	if not (ok and ok1 and u0 and u1) then return nil end -- (not built yet: asked again next draw)
	local okA, hx0, hy0 = pcall(O.MapFromWorld, host, u0, v0)
	local okB, hx1, hy1 = pcall(O.MapFromWorld, host, u1, v1)
	if not (okA and okB and hx0 and hx1) or hx0 == hx1 or hy0 == hy1 then return nil end
	-- reference percent: x = (wy - left) * kx, y = (wx - top) * ky; host percent = 100 * h0 + ref * (h1 - h0)
	local ub, va = ref.kx * (hx1 - hx0), ref.ky * (hy1 - hy0)
	fit = { ub = ub, uc = 100 * hx0 - ref.left * ub, va = va, vc = 100 * hy0 - ref.top * va }
	byC[c] = fit
	return fit
end

-- What the map's scroll frame shows of the canvas, in percent of the host
-- map (reads only: the canvas's and its parent's place).
function OpenMap.ViewRect(view)
	local canvas = view and view.canvas
	local frame = canvas and canvas.GetParent and canvas:GetParent()
	local w, h = view and view.width or 0, view and view.height or 0
	if not frame or w <= 0 or h <= 0 then return 0, 0, 100, 100 end
	local cl, ct, cs = canvas:GetLeft(), canvas:GetTop(), canvas:GetEffectiveScale()
	local fl, ft, fr, fb, fs = frame:GetLeft(), frame:GetTop(), frame:GetRight(), frame:GetBottom(), frame:GetEffectiveScale()
	if not (cl and ct and fl and ft and fr and fb and cs and fs and cs > 0) then return 0, 0, 100, 100 end
	local kx, ky = 100 / (w * cs), 100 / (h * cs)
	return (fl * fs - cl * cs) * kx, (ct * cs - ft * fs) * ky, (fr * fs - cl * cs) * kx, (ct * cs - fb * fs) * ky
end

-- Whether the view has moved off rect by more than a 500th of its width.
function OpenMap.ViewMoved(view, rect)
	local x0, y0, x1, y1 = OpenMap.ViewRect(view)
	local eps = (rect[3] - rect[1]) * 0.002
	return abs(x0 - rect[1]) > eps or abs(y0 - rect[2]) > eps or abs(x1 - rect[3]) > eps or abs(y1 - rect[4]) > eps
end

function OpenMap.Level(level)
	local O = OpenMap.Stitched()
	if O and type(O.ArtTopLevel) == "function" then
		local ok, top = pcall(O.ArtTopLevel)
		if ok and type(top) == "number" and top + 1 > level then return top + 1 end
	end
	return level
end

-- A world point as OpenMap's u, v, through the world map's child on its continent.
local function worldUV(O, c, wx, wy)
	local C = ns.Compat
	if not (C and C.MapToWorld) then return nil end
	local ref = refsFor(C, WORLD_MAP)[c]
	if not ref then return nil end
	local x, y = (wy - ref.left) * ref.kx / 100, (wx - ref.top) * ref.ky / 100
	local ok, u, v = pcall(O.WorldFromMap, ref.map, x, y)
	if ok and type(u) == "number" and type(v) == "number" then return u, v end
end

function OpenMap.Show(c, wx, wy, zoom)
	local O = OpenMap.Stitched()
	if not (O and type(O.ShowWorld) == "function" and c and wx and wy) then return false end
	local u, v = worldUV(O, c, wx, wy)
	if not u then return false end
	local ok, done = pcall(O.ShowWorld, u, v, zoom)
	return ok and done and true or false
end

function OpenMap.OnChange(fn)
	listeners[#listeners + 1] = fn
end

function OpenMap.Toggle(spec)
	toggles[#toggles + 1] = spec
	local O = hooked and _G.OpenMapAPI
	if O then register(O, spec) end
end

function OpenMap.DungeonSection(fn)
	section = fn
	local O = hooked and _G.OpenMapAPI
	if O and type(O.RegisterDungeonSection) == "function" then pcall(O.RegisterDungeonSection, ADDON, fn) end
end

-- OpenMap is an optional dependency, loaded before Polestar when present; a
-- late load (LoadAddOn) hooks in as it arrives.
local function arrive()
	if OpenMap.API() then changed() end
end
ns.OnLogin(arrive)
ns.RegisterEvent("ADDON_LOADED", function(_, name)
	if name == "OpenMap" and ns.IsLoggedIn() then arrive() end
end)
