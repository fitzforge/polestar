-- Profile strings: a profile as one line of text to share, and a pasted one
-- read back as a preview before anything changes (P.Export, P.Import,
-- P.Apply and their helpers; the string's format is in the header of
-- Polestar/Core/Profiles.lua). Part of the settings' addon, loaded with the
-- settings window or the first time a string is asked for (core's P.Export
-- and the others load it, then this takes their place): nothing of it is
-- in memory at login.

local ns = Polestar
local L = ns.L
local P = ns.Profiles
-- Without core's profiles (a part of Polestar loaded alone) there is no
-- string to make or read.
if not (P and P.Parts) then return end

local type, pairs, ipairs, next, tostring, tonumber, pcall, select = type, pairs, ipairs, next, tostring, tonumber, pcall, select
local format, sub, gsub, find, lower = string.format, string.sub, string.gsub, string.find, string.lower
local concat, sort, floor, huge, abs = table.concat, table.sort, math.floor, math.huge, math.abs

-- Core's parts this builds on (P.Parts).
local Q = P.Parts
local LIMITS, PREFIX, FORMAT, NOT_SHARED = P.LIMITS, Q.PREFIX, Q.FORMAT, Q.NOT_SHARED
local store, data, deepCopy, missing, cleanName = Q.store, Q.data, Q.deepCopy, Q.missing, P.CleanName
local migrations, migrationOrder = Q.migrations, Q.migrationOrder

local function finite(v) return type(v) == "number" and v == v and v ~= huge and v ~= -huge end

---------------------------------------------------------------------------
-- What a setting may hold
---------------------------------------------------------------------------

local ANCHORS = { TOPLEFT = true, TOP = true, TOPRIGHT = true, LEFT = true, CENTER = true, RIGHT = true, BOTTOMLEFT = true, BOTTOM = true, BOTTOMRIGHT = true }
local COORD = 20000

local function coord(v) return finite(v) and v >= -COORD and v <= COORD end

-- Exactly n entries, all of them 1..n.
local function isList(t, n)
	local c = 0
	for _ in pairs(t) do c = c + 1 end
	if c ~= n then return false end
	for i = 1, n do
		if t[i] == nil then return false end
	end
	return true
end

-- Position shapes -> a fresh copy, or nil.
local SHAPES = {
	-- { x, y } (the guide window, the floating button)
	xy = function(v) if isList(v, 2) and coord(v[1]) and coord(v[2]) then return { v[1], v[2] } end end,
	-- { point, x, y } (the rare alert, the flight timer, the party panel)
	pxy = function(v) if isList(v, 3) and ANCHORS[v[1]] and coord(v[2]) and coord(v[3]) then return { v[1], v[2], v[3] } end end,
	-- { point, relPoint, x, y }
	ppxy = function(v)
		if isList(v, 4) and ANCHORS[v[1]] and ANCHORS[v[2]] and coord(v[3]) and coord(v[4]) then return { v[1], v[2], v[3], v[4] } end
	end,
	-- { point =, relPoint =, x =, y = } (the arrow)
	anchor = function(v)
		for k in pairs(v) do
			if k ~= "point" and k ~= "relPoint" and k ~= "x" and k ~= "y" then return nil end
		end
		if not (ANCHORS[v.point] and (v.relPoint == nil or ANCHORS[v.relPoint]) and coord(v.x) and coord(v.y)) then return nil end
		return { point = v.point, relPoint = v.relPoint, x = v.x, y = v.y }
	end,
}

-- The position settings and their shapes (more with P.RegisterPosition):
-- every frame Move frames places by a setting (UI/Movers.lua), the alerts'
-- line and the heads-up card's own spot included.
local positions = {
	["ui.pos"] = SHAPES.xy, ["ui.launcherPos"] = SHAPES.xy, ["nav.arrowPos"] = SHAPES.anchor,
	["rares.toastPoint"] = SHAPES.pxy, ["maps.timerPos"] = SHAPES.pxy, ["maps.trackerPos"] = SHAPES.pxy, ["party.panelPos"] = SHAPES.pxy,
	["toasts.transport.point"] = SHAPES.pxy, ["toasts.whilehere.point"] = SHAPES.pxy, ["toasts.headsup.pos"] = SHAPES.pxy,
	["toasts.stackPoint"] = SHAPES.ppxy,
}

-- shape: "xy" | "pxy" | "ppxy" | "anchor", or fn(value) -> a fresh copy or nil.
function P.RegisterPosition(path, shape)
	local fn = type(shape) == "function" and shape or SHAPES[shape]
	if type(path) ~= "string" or not fn then return false end
	positions[path] = fn
	return true
end

local function colour(v)
	if type(v) ~= "table" then return nil end
	local n = #v
	if (n ~= 3 and n ~= 4) or not isList(v, n) then return nil end
	local out = {}
	for i = 1, n do
		if not finite(v[i]) or v[i] < 0 or v[i] > 1 then return nil end
		out[i] = v[i]
	end
	return out
end

local function isColour(d) return type(d) == "table" and colour(d) ~= nil end

local function same(a, b)
	if type(a) == "table" and type(b) == "table" then
		for k, v in pairs(a) do if not same(v, b[k]) then return false end end
		for k in pairs(b) do if a[k] == nil then return false end end
		return true
	end
	return a == b
end
P.Same = same

-- The controls on the Options pages: key -> control, and the keys on the
-- Look pages (a page's `group = "look"`, or its order 20-29). The Look pages
-- and the built-in ones are the settings window's addon (Polestar_Options):
-- loaded here when it is not yet (not in combat: then the core modules'
-- registrations alone).
local function controls()
	local index, look = {}, {}
	if ns.UI and ns.UI.LoadOptions then ns.UI.LoadOptions() end
	local W = ns.Widgets
	local registry = W and W.OptionsRegistry or {}
	local group = {}
	for _, spec in ipairs(registry) do
		if type(spec) == "table" and spec.page and group[spec.page] == nil then
			if spec.group then
				group[spec.page] = spec.group
			elseif type(spec.order) == "number" then
				group[spec.page] = (spec.order >= 20 and spec.order < 30) and "look" or "other"
			end
		end
	end
	local function add(c, isLook)
		if type(c) ~= "table" or type(c.key) ~= "string" or c.kind == "button" or c.kind == "binding" then return end
		if index[c.key] == nil then index[c.key] = c end
		if isLook then look[c.key] = true end
	end
	for _, spec in ipairs(registry) do
		if type(spec) == "table" and type(spec.controls) == "table" then
			local isLook = group[spec.page] == "look"
			for _, c in ipairs(spec.controls) do add(c, isLook) end
		end
	end
	local O = ns.UI and ns.UI.Options
	if O and type(O.AllControls) == "function" then
		local ok, list = pcall(O.AllControls)
		if ok and type(list) == "table" then
			-- Built-in pages too; each control knows its page (its group, or its order).
			for _, c in ipairs(list) do
				local pg = type(c) == "table" and type(c.page) == "table" and c.page or nil
				local isLook = pg ~= nil and (pg.group == "look"
					or (pg.group == nil and type(pg.order) == "number" and pg.order >= 20 and pg.order < 30))
				add(c, isLook)
			end
		end
	end
	return index, look
end

local function choicesOf(c)
	local list = c.choices
	if type(list) == "function" then
		local ok, r = pcall(list)
		list = ok and r or nil
	end
	return type(list) == "table" and list or nil
end

-- A key that holds a table when it is set (a colour, a place): never `true`.
local function slotName(path)
	local key = path:match("([^.]+)$") or path
	return key:find("Pos$") or key:find("Point$") or key:find("Colou?r$") or key == "accent"
end

-- The settings that hold one value per name the player picks for, with an
-- empty default: the skin variant picked for each skin (skin id -> variant
-- id), each a short text.
local NAMED = { ["ui.skinVariants"] = true }

local function text(v)
	if type(v) ~= "string" or #v > LIMITS.text or find(v, "[%z\1-\31]") then return nil end
	return v
end

-- A number a control may hold: finite, and within its slider's range (not
-- snapped: some defaults sit between steps).
local function number(v, c)
	if not finite(v) or abs(v) > 1e9 then return nil end
	if c and c.kind == "slider" and type(c.min) == "number" and type(c.max) == "number" then
		if v < c.min - 1e-9 or v > c.max + 1e-9 then return nil end
	end
	return v
end

-- v as setting `path` may hold it (a fresh copy for a table), or nil.
local function fit(path, v, c)
	if NOT_SHARED[path] then return nil end
	local shape = positions[path]
	local d = ns.GetDefault(path)
	if shape then
		if v == false and d == false then return false end
		if type(v) == "table" then return shape(v) end
		return nil
	end
	if d == nil then
		local parent = path:match("^(.+)%.[^.]+$")
		if parent and NAMED[parent] then return text(v) end
		return nil
	end
	local td = type(d)
	if td == "boolean" then
		if type(v) == "boolean" then
			if v and not d and ((c and c.kind == "color") or slotName(path)) then return nil end
			return v
		end
		if d == false and type(v) == "table" then return colour(v) end
		-- Unset until its slider is moved (it follows another setting meanwhile:
		-- the guide window's own background opacity), then the slider's number.
		if d == false and type(v) == "number" and c and c.kind == "slider" then return number(v, c) end
		return nil
	elseif td == "table" then
		if isColour(d) then return colour(v) end
		return nil
	end
	if type(v) ~= td then return nil end
	if td == "number" then
		if number(v, c) == nil then return nil end
	elseif td == "string" then
		if text(v) == nil then return nil end
	else
		return nil
	end
	local choices = c and (c.kind == "dropdown" or c.kind == "cards" or c.kind == "font") and choicesOf(c)
	if choices and #choices > 0 then
		for _, ch in ipairs(choices) do
			if type(ch) == "table" and ch.value == v then return v end
		end
		return nil
	end
	return v
end

-- Every leaf of a profile's settings: path -> value. A record default
-- ({ inn = true, bank = true }) is walked into; a colour or a position is
-- one value.
local function leaves(settings, out)
	out = out or {}
	local function walk(prefix, t, depth)
		for k, v in pairs(t) do
			if type(k) == "string" or type(k) == "number" then
				local path = prefix and (prefix .. "." .. k) or tostring(k)
				if not prefix then
					if type(v) == "table" then walk(path, v, depth + 1) end
				else
					local d = ns.GetDefault(path)
					if type(v) == "table" and type(d) == "table" and not isColour(d) and not positions[path] and depth < 4 then
						walk(path, v, depth + 1)
					else
						out[path] = v
					end
				end
			end
		end
	end
	walk(nil, settings, 0)
	return out
end

---------------------------------------------------------------------------
-- Writing a string: JSON in the envelope (Core/Import.lua, Import.Envelope:
-- zlib and base64 by the client's encoder, or plain Lua where it has none).
---------------------------------------------------------------------------

local ESC = { ['"'] = '\\"', ["\\"] = "\\\\", ["\n"] = "\\n", ["\t"] = "\\t" }

local function jstr(s)
	-- Other control characters: the reader refuses them, so they are left out.
	return '"' .. gsub(s, '[%c"\\]', function(ch) return ESC[ch] or "" end) .. '"'
end

local function jnum(v)
	if v == floor(v) and v > -1e15 and v < 1e15 then return format("%d", v) end
	return format("%.17g", v)
end

local function jvalue(v)
	local t = type(v)
	if t == "boolean" then return v and "true" or "false" end
	if t == "number" then return jnum(v) end
	if t == "string" then return jstr(v) end
	local n = #v
	if n > 0 and isList(v, n) then
		local out = {}
		for i = 1, n do out[i] = jvalue(v[i]) end
		return "[" .. concat(out, ",") .. "]"
	end
	local keys = {}
	for k in pairs(v) do keys[#keys + 1] = tostring(k) end
	sort(keys)
	local out = {}
	for i, k in ipairs(keys) do out[i] = jstr(k) .. ":" .. jvalue(v[k]) end
	return "{" .. concat(out, ",") .. "}"
end

local function zlibMethod()
	return Enum and Enum.CompressionMethod and Enum.CompressionMethod.Zlib
end

-- A JSON payload in the envelope.
function P.Pack(json)
	return ns.Import.Envelope(PREFIX, json)
end

local function migrationIds()
	local ids = {}
	local done = ns.DB().migrations
	for _, id in ipairs(migrationOrder) do
		if type(done) == "table" and done[id] then ids[#ids + 1] = id end
	end
	sort(ids)
	return ids
end

-- The parts of a profile a string may carry on its own: "look" (the
-- settings on the Look pages), "positions" (where things were dragged to),
-- "guiding" (everything else: what Polestar does and shows).
P.AREAS = { "look", "guiding", "positions" }

local function areaOf(path, look)
	if positions[path] then return "positions" end
	if look[path] then return "look" end
	-- The skin's variant (Theme > Colour > Variant: a row with no key of its own).
	if path:find("^ui%.skinVariants%.") then return "look" end
	return "guiding"
end
P.AreaOf = function(path) return areaOf(path, select(2, controls())) end

-- opts.areas = { look = true, ... } (every area when nil); opts.look: the look alone.
local function areasOf(opts)
	if opts and opts.look then return { look = true } end
	return opts and opts.areas or nil
end

-- The settings of profile `name` (the one in use when nil) that a string
-- carries: path -> value, only those off their default and valid. -> settings, count
function P.Portable(name, opts)
	name = name or P.Active()
	local src = data(name)
	if not src then return nil, missing(name) end
	local index, look = controls()
	local areas = areasOf(opts)
	local out, n = {}, 0
	for path, v in pairs(leaves(src)) do
		if not areas or areas[areaOf(path, look)] then
			local fitted = fit(path, v, index[path])
			if fitted ~= nil and not same(fitted, ns.GetDefault(path)) then
				out[path] = fitted
				n = n + 1
			end
		end
	end
	return out, n
end

-- The screen positions are measured on: its pixels and the UI's scale.
local function screen()
	local w, h = 0, 0
	if GetPhysicalScreenSize then w, h = GetPhysicalScreenSize() end
	local scale = UIParent and UIParent.GetEffectiveScale and UIParent:GetEffectiveScale() or 1
	return { w = tonumber(w) or 0, h = tonumber(h) or 0, scale = floor((tonumber(scale) or 1) * 1000 + 0.5) / 1000 }
end

-- -> string, the number of settings in it | nil, why
function P.Export(name, opts)
	name = name or P.Active()
	local settings, n = P.Portable(name, opts)
	if not settings then return nil, n end
	local keys = {}
	for path in pairs(settings) do keys[#keys + 1] = path end
	sort(keys)
	local parts = {}
	for i, path in ipairs(keys) do parts[i] = jstr(path) .. ":" .. jvalue(settings[path]) end
	local ids = {}
	for i, id in ipairs(migrationIds()) do ids[i] = jstr(id) end
	local areas = areasOf(opts)
	local list = {}
	for _, a in ipairs(P.AREAS) do
		if not areas or areas[a] then list[#list + 1] = jstr(a) end
	end
	local only = areas and areas.look and not areas.guiding and not areas.positions
	local json = format('{"format":%d,"name":%s,%s"areas":[%s],"screen":%s,"migrations":[%s],"settings":{%s}}', FORMAT, jstr(name),
		only and '"scope":"look",' or "", concat(list, ","), jvalue(screen()), concat(ids, ","), concat(parts, ","))
	return P.Pack(json), n
end

---------------------------------------------------------------------------
-- Reading a string
---------------------------------------------------------------------------

local function damaged() return L["This profile string is damaged or incomplete. Copy the whole string again."] end

-- The JSON in a string. -> text | nil, why
local function unpack(s)
	local sum, body = s:match("^!PSS1!(%x%x%x%x%x%x%x%x)!([A-Za-z0-9+/]+=?=?)$")
	if not sum or #body % 4 ~= 0 then return nil, damaged() end
	local enc = C_EncodingUtil
	if not (type(enc) == "table" and type(enc.DecodeBase64) == "function" and type(enc.DecompressString) == "function") then
		return nil, L["This game client cannot read import strings."]
	end
	local ok, packed = pcall(enc.DecodeBase64, body)
	if not ok or type(packed) ~= "string" then return nil, damaged() end
	local raw
	ok, raw = pcall(enc.DecompressString, packed, zlibMethod())
	if not ok or type(raw) ~= "string" then return nil, damaged() end
	if #raw > LIMITS.payload then return nil, L["This profile string holds too much to be a Polestar profile."] end
	if ns.Import.Adler32(raw) ~= lower(sum) then return nil, damaged() end
	return raw
end

-- A setting's label on the Options pages, else its path.
local function labelOf(path, c)
	local l = c and c.label
	if type(l) == "function" then
		local ok, s = pcall(l)
		l = ok and s or nil
	end
	return type(l) == "string" and l or path
end

-- Text pasted on the Profiles page. -> preview | nil, why
--   preview = { name, look, count, settings = { path -> value }, keys = { path, ... },
--               labels = { path -> label }, changes = { path, ... } (differ from the profile in use),
--               dropped = { path, ... } }
function P.Import(text)
	if type(text) ~= "string" then return nil, L["Paste a profile string."] end
	local s = gsub(text, "%s+", "")
	if s == "" then return nil, L["Paste a profile string."] end
	if #s > LIMITS.length then return nil, L["This profile string holds too much to be a Polestar profile."] end
	local version = s:match("^!PSS(%d+)!")
	if not version then
		if s:match("^!PS%d+!") then return nil, L["This is a guide import string: paste it on the Import page."] end
		return nil, L["This is not a Polestar profile string."]
	end
	if version ~= "1" then return nil, L["This profile string needs a newer Polestar."] end
	local raw, why = unpack(s)
	if not raw then return nil, why end
	local tree = ns.Import.ParseJSON(raw)
	if type(tree) ~= "table" or not finite(tree.format) or type(tree.settings) ~= "table" then return nil, damaged() end
	if tree.format > FORMAT then return nil, L["This profile string needs a newer Polestar."] end
	-- The settings as a profile table, so the migrations the string is from
	-- before can run over it first.
	local nested, n, dropped = {}, 0, {}
	for path, v in pairs(tree.settings) do
		n = n + 1
		if n > LIMITS.settings then return nil, L["This profile string holds too much to be a Polestar profile."] end
		local ok = type(path) == "string" and #path <= LIMITS.path and find(path, "^[%w_]+%.[%w_]+") ~= nil
			and not find(path, "%.%.") and not find(path, "%.$")
		local keys = {}
		if ok then
			for k in path:gmatch("[^.]+") do keys[#keys + 1] = k end
			ok = #keys <= 4
		end
		local node = nested
		for i = 1, ok and #keys - 1 or 0 do
			local k = keys[i]
			if node[k] == nil then node[k] = {} end
			if type(node[k]) ~= "table" then
				ok = false
				break
			end
			node = node[k]
		end
		if ok and node[keys[#keys]] == nil then
			node[keys[#keys]] = v
		else
			dropped[#dropped + 1] = ns.EscapeText(tostring(path))
		end
	end
	local applied = {}
	if type(tree.migrations) == "table" then
		for i, id in ipairs(tree.migrations) do
			if i > LIMITS.migrations then break end
			if type(id) == "string" then applied[id] = true end
		end
	end
	for _, id in ipairs(migrationOrder) do
		if not applied[id] then ns.SafeCall(migrations[id], nested) end
	end
	local index, look = controls()
	local preview = { settings = {}, keys = {}, labels = {}, area = {}, areas = { look = 0, guiding = 0, positions = 0 },
		changes = {}, dropped = dropped, look = tree.scope == "look" }
	for path, v in pairs(leaves(nested)) do
		local fitted = fit(path, v, index[path])
		if fitted == nil then
			dropped[#dropped + 1] = ns.EscapeText(path)
		else
			local area = areaOf(path, look)
			preview.settings[path] = fitted
			preview.keys[#preview.keys + 1] = path
			preview.labels[path] = labelOf(path, index[path])
			preview.area[path] = area
			preview.areas[area] = preview.areas[area] + 1
			if not same(fitted, ns.Get(path)) then preview.changes[#preview.changes + 1] = path end
		end
	end
	preview.count = #preview.keys
	local byLabel = function(a, b)
		local la, lb = preview.labels[a], preview.labels[b]
		if la ~= lb then return la < lb end
		return a < b
	end
	sort(preview.keys, byLabel)
	sort(preview.changes, byLabel)
	sort(dropped)
	preview.name = type(tree.name) == "string" and cleanName(tree.name) or nil
	-- Positions made on another screen or at another UI scale may sit off.
	local from, here = tree.screen, screen()
	if preview.areas.positions > 0 and type(from) == "table" and finite(from.w) and finite(from.h) and finite(from.scale) then
		preview.otherScreen = from.w ~= here.w or from.h ~= here.h or abs(from.scale - here.scale) > 0.01
	end
	return preview
end

-- A name for an imported profile that is not taken: the string's, else
-- "Imported", with " 2", " 3", ... after it.
function P.FreeName(base)
	base = base and cleanName(base) or L["Imported"]
	if not P.Exists(base) then return base end
	for i = 2, LIMITS.profiles + 1 do
		local suffix = " " .. i
		local name = sub(base, 1, LIMITS.name - #suffix) .. suffix
		if not P.Exists(name) then return name end
	end
	return nil
end

-- The preview's settings into the profile in use (name = P.Active(): each
-- through ns.Set, the rest kept) or as the new profile `name` (every other
-- setting at its default). areas: { look = true, ... } to take only those
-- (all when nil). -> true | nil, why
function P.Apply(preview, name, areas)
	if type(preview) ~= "table" or type(preview.settings) ~= "table" or type(preview.keys) ~= "table" then return nil, damaged() end
	local keys = {}
	for _, path in ipairs(preview.keys) do
		if not areas or areas[preview.area and preview.area[path] or "guiding"] then keys[#keys + 1] = path end
	end
	if #keys == 0 then return nil, L["Nothing to apply: every part of the string is unticked."] end
	if name == nil or name == P.Active() then
		for _, path in ipairs(keys) do ns.Set(path, deepCopy(preview.settings[path])) end
		ns.Fire("PROFILES_CHANGED")
		return true
	end
	local made, why = P.New(name)
	if not made then return nil, why end
	local t = store()[made]
	for _, path in ipairs(keys) do
		local v = preview.settings[path]
		if not same(v, ns.GetDefault(path)) then
			local node = t
			local keys = {}
			for k in path:gmatch("[^.]+") do keys[#keys + 1] = k end
			for i = 1, #keys - 1 do
				if type(node[keys[i]]) ~= "table" then node[keys[i]] = {} end
				node = node[keys[i]]
			end
			node[keys[#keys]] = deepCopy(v)
		end
	end
	return true
end

-- Position shapes given to core before this loaded.
local pendingPositions = P.pendingPositions
P.pendingPositions = nil
for _, r in ipairs(pendingPositions or {}) do P.RegisterPosition(r[1], r[2]) end

