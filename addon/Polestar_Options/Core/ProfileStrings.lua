-- Profile strings: a profile as one line of text to share, and a pasted one
-- read back as a preview before anything changes (P.Export, P.Import,
-- P.Changes, P.Apply, P.Undo and their helpers; the string's format is in
-- the header of Polestar/Core/Profiles.lua), each by categories a player
-- names ("just the skin": P.CATEGORIES, below). Part of the settings'
-- addon, loaded with the settings window or the first time a string is
-- asked for (core's P.Export and the others load it, then this takes their
-- place): nothing of it is in memory at login.

local ns = Polestar
local L = ns.L
local P = ns.Profiles
-- Without core's profiles (a part of Polestar loaded alone) there is no
-- string to make or read.
if not (P and P.Parts) then return end

local type, pairs, ipairs, next, tostring, tonumber, pcall = type, pairs, ipairs, next, tostring, tonumber, pcall
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

-- The position settings and their shapes (more with P.RegisterPosition).
local positions = {
	["ui.pos"] = SHAPES.xy, ["ui.launcherPos"] = SHAPES.xy, ["nav.arrowPos"] = SHAPES.anchor,
	["rares.toastPoint"] = SHAPES.pxy, ["maps.timerPos"] = SHAPES.pxy, ["maps.trackerPos"] = SHAPES.pxy, ["party.panelPos"] = SHAPES.pxy,
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

---------------------------------------------------------------------------
-- Categories: the parts of a profile a string carries and an import takes,
-- each on its own. A setting's category follows where it lives: its home
-- on the settings pages (the first page in the sidebar's order that shows
-- it), by its page, else its tab or section as PAGES says, so a setting
-- added to a page falls in with the rest of it. A few belong with another
-- part than the section they sit in (OWN, by key or the start of one), a
-- position is always Window positions, and a setting no page shows goes by
-- the start of its key (HIDDEN). Key bindings are the game's, and a
-- profile's own key is the account's, so no category holds one.
-- docs/ARCHITECTURE.md, "Profiles", has the table.
---------------------------------------------------------------------------

P.CATEGORIES = {
	{ id = "skin", label = L["Skin & colours"], help = L["The skin and its variant, the accent, the backgrounds, the colours of names, the frames and motion (Theme: Colour, Names, Frames)."] },
	{ id = "fonts", label = L["Fonts & text size"], help = L["The fonts, text sizes, outline, shadow and text colours (Theme: Text)."] },
	{ id = "window", label = L["Guide window"], help = L["The guide window's layout, size, parts and behaviour, compact mode and what it shows, the floating and minimap buttons, the guide menu and the gamepad."] },
	{ id = "arrow", label = L["Arrow & map pins"], help = L["The arrow's look and text, the map pins and icons, and what the world map and minimap show."] },
	{ id = "routes", label = L["Route lines & travel"], help = L["The route lines, travel routes, flights and hearth, the transport alert, the flight timer and the journey."] },
	{ id = "quests", label = L["Quests & automation"], help = L["Quest automation, Dynamic Questing, how guides go on, the quest log and tooltips, group, party chat and invitations."] },
	{ id = "hud", label = L["Buttons, alerts & trackers"], help = L["The quest and target buttons, rares and their alert, the heads-up cards, the experience and instance trackers and the party panel."] },
	{ id = "gear", label = L["Gear & rewards"], help = L["Quest rewards, gear advice, talents, merchants, bags and trainers."] },
	{ id = "dungeons", label = L["Dungeons & lookup"], help = L["Dungeons in your route, group quests, the dungeon journal, Lookup and your characters."] },
	{ id = "positions", label = L["Window positions"], help = L["Where you dragged the guide window, the arrow, the buttons, the alerts and the trackers, and Move frames' grid. Another screen may need them moved again."] },
}
local CATEGORY = {}
for i, c in ipairs(P.CATEGORIES) do CATEGORY[c.id] = i end

-- By page key: a category, or { category, tabs = { [tab] = category },
-- sections = { [section] = category } } (a section's over its tab's, a
-- tab's over its page's), the names as the pages register them.
local PAGES = {
	guide = { "window", tabs = { [L["Arrow & routes"]] = "routes", [L["Automation"]] = "quests" },
		sections = { [L["Dynamic Questing"]] = "quests", [L["Arrow"]] = "arrow", [L["Other waypoints"]] = "arrow" } },
	theme = { "skin", tabs = { [L["Text"]] = "fonts" } },
	guidewindow = "window",
	arrow = "arrow",
	mappins = "arrow",
	routelines = "routes",
	buttons = { "hud", tabs = { [L["Launcher & minimap"]] = "window" } },
	alerts = { "hud", tabs = { [L["Transport alert"]] = "routes" } },
	trackers = { "hud", tabs = { [L["Travel"]] = "routes" } },
	map = "arrow",
	questing = { "quests", tabs = { [L["Rewards & gear"]] = "gear", [L["Talents"]] = "gear", [L["Buttons"]] = "hud" } },
	discovery = { "dungeons", tabs = { [L["Rares"]] = "hud" } },
	qualityoflife = { "quests", tabs = { [L["Travel"]] = "routes", [L["Vendors"]] = "gear", [L["Trackers & map"]] = "hud" } },
	-- A section per addon Polestar works with.
	integrations = { "quests", sections = { EllesmereUI = "skin", TomTom = "arrow", ["Shortest Path Forever"] = "routes" } },
	gamepad = "window",
}

-- Settings that go with another part than the section they sit in.
local OWN = {
	movers = "positions", dungeons = "dungeons", ["behavior.dungeons"] = "dungeons", ["behavior.groupQuests"] = "dungeons",
	["ui.matchFont"] = "fonts",
}

-- Settings no page shows (state kept as the player uses a window).
local HIDDEN = {
	["ui.skinVariants"] = "skin", ["ui.optionsSize"] = "positions", ["maps.minimapButtonAngle"] = "positions", ["nav.openmapDots"] = "arrow",
	ui = "window", guideWindow = "window", pause = "window", update = "window", gamepad = "window",
	nav = "routes", maps = "arrow", buttons = "hud", toasts = "hud", trackers = "hud", rares = "hud",
	behavior = "quests", qol = "quests", party = "quests", routePlan = "quests",
	gear = "gear", talents = "gear", dungeons = "dungeons", alts = "dungeons", lookup = "dungeons", movers = "positions",
}

-- t[path], else t[path less its last part], and so on.
local function nearest(t, path)
	local p = path
	while p do
		local v = t[p]
		if v ~= nil then return v end
		p = p:match("^(.+)%.[^.]+$")
	end
	return nil
end

local function pageRule(page, tab, section)
	local r = page and PAGES[page]
	if type(r) ~= "table" then return r end
	return section and r.sections and r.sections[section] or tab and r.tabs and r.tabs[tab] or r[1]
end

-- The controls on the Options pages: key -> its control (its home), and
-- key -> its home's category. The pages are the settings window's addon
-- (Polestar_Options), loaded here when they are not yet (not in combat:
-- then the registrations as they came). Kept until a page registers more
-- (a module's page, a dungeon's rows at login).
local built
local function index()
	if built then return built end
	if ns.UI and ns.UI.LoadOptions then ns.UI.LoadOptions() end
	local control, home = {}, {}
	local function add(c, page, tab, section)
		if type(c) ~= "table" or type(c.key) ~= "string" or c.kind == "button" or c.kind == "binding" or control[c.key] ~= nil then return end
		control[c.key] = c
		home[c.key] = pageRule(page, tab, section)
	end
	local O = ns.UI and ns.UI.Options
	local ok, list = false, nil
	if O and type(O.AllControls) == "function" then ok, list = pcall(O.AllControls) end
	if ok and type(list) == "table" then
		-- Every home in the sidebar's order, each knowing its page, tab and section.
		for _, c in ipairs(list) do
			if type(c) == "table" and type(c.page) == "table" then add(c, c.page.key, c.tab, c.section) end
		end
	else
		local registry = ns.Widgets and ns.Widgets.OptionsRegistry or {}
		local keyOf = {}
		for _, spec in ipairs(registry) do
			if type(spec) == "table" and type(spec.page) == "string" and type(spec.key) == "string" and not keyOf[spec.page] then keyOf[spec.page] = spec.key end
		end
		for _, spec in ipairs(registry) do
			if type(spec) == "table" and type(spec.page) == "string" and type(spec.controls) == "table" then
				local page = keyOf[spec.page] or gsub(lower(spec.page), "[^%w]+", "")
				if spec.toggle then add(spec.toggle, page, spec.tab, spec.section) end
				for _, c in ipairs(spec.controls) do add(c, page, spec.tab, spec.section) end
			end
		end
	end
	built = { control = control, home = home }
	return built
end
if ns.Widgets and ns.Widgets.OnOptionsRegistered then ns.Widgets.OnOptionsRegistered(function() built = nil end) end

-- -> the category's id and how it was found ("position" | "own" | "page" |
-- "hidden": no page shows it), or nil when nothing says.
local function categoryOf(path, ix)
	if positions[path] then return "positions", "position" end
	local id = nearest(OWN, path)
	if id then return id, "own" end
	id = ix.home[path]
	if id then return id, "page" end
	id = nearest(HIDDEN, path)
	if id then return id, "hidden" end
	return nil
end
P.CategoryOf = function(path) return categoryOf(path, index()) end

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
	if d == nil then return nil end
	local td = type(d)
	if td == "boolean" then
		if type(v) == "boolean" then
			if v and not d and ((c and c.kind == "color") or slotName(path)) then return nil end
			return v
		end
		if d == false and type(v) == "table" then return colour(v) end
		return nil
	elseif td == "table" then
		if isColour(d) then return colour(v) end
		return nil
	end
	if type(v) ~= td then return nil end
	if td == "number" then
		if not finite(v) or abs(v) > 1e9 then return nil end
		if c and c.kind == "slider" and type(c.min) == "number" and type(c.max) == "number" then
			-- In range, not snapped: some defaults sit between steps.
			if v < c.min - 1e-9 or v > c.max + 1e-9 then return nil end
		end
	elseif td == "string" then
		if #v > LIMITS.text or find(v, "[%z\1-\31]") then return nil end
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

-- The settings of profile `name` (the one in use when nil) that a string
-- carries: path -> value, only those off their default and valid, in the
-- categories opts.categories names ({ id = true, ... }; every one when
-- nil). -> settings, count
function P.Portable(name, opts)
	name = name or P.Active()
	local src = data(name)
	if not src then return nil, missing(name) end
	local ix = index()
	local only = opts and opts.categories
	local out, n = {}, 0
	for path, v in pairs(leaves(src)) do
		local id = categoryOf(path, ix)
		if id and (not only or only[id]) then
			local fitted = fit(path, v, ix.control[path])
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

-- opts.categories = { id = true, ... }: the categories to put in (every one
-- when nil); the string names them, so what it leaves out of one is at its
-- default there. -> string, the number of settings in it | nil, why
function P.Export(name, opts)
	name = name or P.Active()
	local only = opts and opts.categories
	local list = {}
	for _, c in ipairs(P.CATEGORIES) do
		if not only or only[c.id] then list[#list + 1] = jstr(c.id) end
	end
	if #list == 0 then return nil, L["Tick at least one part to put in the string."] end
	local settings, n = P.Portable(name, opts)
	if not settings then return nil, n end
	local keys = {}
	for path in pairs(settings) do keys[#keys + 1] = path end
	sort(keys)
	local parts = {}
	for i, path in ipairs(keys) do parts[i] = jstr(path) .. ":" .. jvalue(settings[path]) end
	local ids = {}
	for i, id in ipairs(migrationIds()) do ids[i] = jstr(id) end
	local json = format('{"format":%d,"name":%s,"categories":[%s],"screen":%s,"migrations":[%s],"settings":{%s}}', FORMAT, jstr(name),
		concat(list, ","), jvalue(screen()), concat(ids, ","), concat(parts, ","))
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

-- A skin's variant setting (ui.skinVariants.<skin>): the skin's id.
local function variantSkin(path) return path:match("^ui%.skinVariants%.([%w_%-]+)$") end

-- A setting's label on the Options pages; a frame's place, the frame's name
-- (Move frames'); a skin's variant, "Variant (the skin)"; else its path.
local function labelOf(path, c)
	local l = c and c.label
	if type(l) == "function" then
		local ok, s = pcall(l)
		l = ok and s or nil
	end
	if type(l) == "string" then return l end
	local M = ns.Movers
	l = positions[path] and M and M.KeyLabel and M.KeyLabel(path)
	if type(l) == "string" then return l end
	local skin = variantSkin(path)
	if skin then
		local info = ns.Theme and ns.Theme.SkinInfo and ns.Theme.SkinInfo(skin)
		return (L["%s (%s)"]):format(L["Variant"], info and info.name or skin)
	end
	return path
end

-- A setting's label and where it sits, what tells two "Scale" rows apart:
-- its section, or its tab where the section is a card's own. -> label, place | nil
function P.LabelOf(path)
	local c = index().control[path]
	local place = c and (c.section ~= L["Card"] and c.section or c.tab) or nil
	return labelOf(path, c), type(place) == "string" and place ~= "" and place or nil
end

-- A position's numbers, the way its shape holds them.
local function placeText(v)
	local x, y = v.x, v.y
	if x == nil then
		local n = #v
		x, y = v[n - 1], v[n]
	end
	if not (finite(x) and finite(y)) then return L["Moved"] end
	return format("%d, %d", floor(x + 0.5), floor(y + 0.5))
end

-- A value as the Options pages show it: On or Off, a choice's name, a
-- slider's text, a colour's hex; a position's numbers, or Not moved.
function P.ValueText(path, v)
	local c = index().control[path]
	if positions[path] then return type(v) == "table" and placeText(v) or L["Not moved"] end
	local skin = type(v) == "string" and variantSkin(path)
	for _, var in ipairs(skin and ns.Theme and ns.Theme.SkinVariants and ns.Theme.SkinVariants(skin) or {}) do
		if var.id == v and type(var.name) == "string" then return var.name end
	end
	local t = type(v)
	if t == "boolean" then
		if not v and ((c and c.kind == "color") or slotName(path)) then return L["From the look"] end
		return v and L["On"] or L["Off"]
	end
	if t == "table" then
		local col = colour(v)
		if not col then return "?" end
		local hex = format("#%02X%02X%02X", floor(col[1] * 255 + 0.5), floor(col[2] * 255 + 0.5), floor(col[3] * 255 + 0.5))
		if col[4] and col[4] < 1 then hex = format("%s %d%%", hex, floor(col[4] * 100 + 0.5)) end
		return hex
	end
	local choices = c and (c.kind == "dropdown" or c.kind == "cards" or c.kind == "font") and choicesOf(c)
	for _, ch in ipairs(choices or {}) do
		local l = type(ch) == "table" and ch.value == v and (ch.label or ch.text)
		if type(l) == "string" then return l end
	end
	if t == "number" then
		local fmt = c and c.kind == "slider" and c.format
		local ok, s = false, nil
		if type(fmt) == "function" then
			ok, s = pcall(fmt, v)
		elseif type(fmt) == "string" then
			ok, s = pcall(format, fmt, v)
		end
		if ok and type(s) == "string" then return s end
		return (gsub(format("%.2f", v), "%.?0+$", ""))
	end
	return ns.EscapeText(tostring(v))
end

-- Text pasted on the Profiles page. -> preview | nil, why
--   preview = { name, count, settings = { path -> value }, keys = { path, ... } (by label),
--               labels = { path -> label }, category = { path -> id }, held = { id -> its settings },
--               holds = { id -> true }, order = { id, ... } (the categories it holds, in order),
--               exact (it names its categories: what it leaves out of one is at its default there),
--               changes = { path, ... } (what differs from the profile in use), dropped = { path, ... },
--               otherScreen }
-- Nothing changes; P.Changes(preview) says what applying it would now.
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
	local ix = index()
	local preview = { settings = {}, keys = {}, labels = {}, category = {}, held = {}, holds = {}, order = {}, dropped = dropped }
	for path, v in pairs(leaves(nested)) do
		local c = ix.control[path]
		local fitted = fit(path, v, c)
		local id = fitted ~= nil and categoryOf(path, ix) or nil
		if id == nil then
			dropped[#dropped + 1] = ns.EscapeText(path)
		else
			preview.settings[path] = fitted
			preview.keys[#preview.keys + 1] = path
			preview.labels[path] = labelOf(path, c)
			preview.category[path] = id
			preview.held[id] = (preview.held[id] or 0) + 1
			preview.holds[id] = true
		end
	end
	-- A string from 0.4.0 on names the categories it holds, settings in
	-- them or not; an older one holds those its settings are in.
	if type(tree.categories) == "table" then
		preview.exact = true
		for i, id in ipairs(tree.categories) do
			if i > LIMITS.migrations then break end
			if type(id) == "string" and CATEGORY[id] then preview.holds[id] = true end
		end
	end
	for _, c in ipairs(P.CATEGORIES) do
		if preview.holds[c.id] then preview.order[#preview.order + 1] = c.id end
	end
	preview.count = #preview.keys
	sort(preview.keys, function(a, b)
		local la, lb = preview.labels[a], preview.labels[b]
		if la ~= lb then return la < lb end
		return a < b
	end)
	sort(dropped)
	preview.changes = {}
	for i, ch in ipairs(P.Changes(preview)) do preview.changes[i] = ch.path end
	preview.name = type(tree.name) == "string" and cleanName(tree.name) or nil
	-- Positions made on another screen or at another UI scale may sit off.
	local from, here = tree.screen, screen()
	if (preview.held.positions or 0) > 0 and type(from) == "table" and finite(from.w) and finite(from.h) and finite(from.scale) then
		preview.otherScreen = from.w ~= here.w or from.h ~= here.h or abs(from.scale - here.scale) > 0.01
	end
	return preview
end

-- What applying `preview` into the profile in use would change, in the
-- categories `pick` names ({ id = true, ... }; every one it holds when
-- nil): each setting it carries that differs from yours and, a string
-- that names its categories, each of yours off its default it leaves out
-- of one it holds, back to the default.
-- -> { { path, category, label, theirs, reset }, ... } in the categories' order, then by label
function P.Changes(preview, pick)
	local out = {}
	if type(preview) ~= "table" or type(preview.settings) ~= "table" or type(preview.holds) ~= "table" then return out end
	local function wanted(id) return id ~= nil and preview.holds[id] and (not pick or pick[id]) end
	for path, v in pairs(preview.settings) do
		local id = preview.category[path]
		if wanted(id) and not same(v, ns.Get(path)) then
			out[#out + 1] = { path = path, category = id, label = preview.labels[path] or path, theirs = v }
		end
	end
	if preview.exact then
		local ix = index()
		for path, v in pairs(leaves(ns.DB().settings)) do
			if preview.settings[path] == nil then
				local c = ix.control[path]
				local id = categoryOf(path, ix)
				if wanted(id) and fit(path, v, c) ~= nil and not same(v, ns.GetDefault(path)) then
					out[#out + 1] = { path = path, category = id, label = labelOf(path, c), theirs = ns.GetDefault(path), reset = true }
				end
			end
		end
	end
	sort(out, function(a, b)
		if a.category ~= b.category then return CATEGORY[a.category] < CATEGORY[b.category] end
		if a.label ~= b.label then return a.label < b.label end
		return a.path < b.path
	end)
	return out
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

-- Settings written together: the look repaints once, at the end.
local function batch(fn)
	local I = ns.ThemeInternal
	if not (I and I.batch) then return fn() end
	local ok, err = I.batch(fn)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

-- value at `path` in a profile's settings table (nil: the default).
local function setPath(t, path, value)
	local keys = {}
	for k in path:gmatch("[^.]+") do keys[#keys + 1] = k end
	local node = t
	for i = 1, #keys - 1 do
		if type(node[keys[i]]) ~= "table" then
			if value == nil then return end
			node[keys[i]] = {}
		end
		node = node[keys[i]]
	end
	node[keys[#keys]] = value
end

-- The preview into the profile in use (name = P.Active(): what P.Changes
-- says, each through ns.Set) or as the new profile `name` (its settings in
-- the categories picked, every other setting at its default). pick =
-- { id = true, ... }: the categories to take (every one it holds when
-- nil). -> true, undo (for P.Undo; .count: the settings taken) | nil, why
function P.Apply(preview, name, pick)
	if type(preview) ~= "table" or type(preview.settings) ~= "table" or type(preview.keys) ~= "table" or type(preview.holds) ~= "table" then
		return nil, damaged()
	end
	local any = false
	for id in pairs(preview.holds) do
		if not pick or pick[id] then any = true end
	end
	if not any then return nil, L["Nothing to apply: every part of the string is unticked."] end
	if name == nil or name == P.Active() then
		local list = P.Changes(preview, pick)
		if #list == 0 then return nil, L["Nothing to apply: the parts ticked are the same as yours."] end
		-- Every setting the profile held, so the Undo also takes back what
		-- the settings written changed in turn (picking one accent source
		-- turns the others off).
		local before = leaves(deepCopy(ns.DB().settings))
		batch(function()
			for _, ch in ipairs(list) do
				if ch.reset then ns.Set(ch.path, nil) else ns.Set(ch.path, deepCopy(ch.theirs)) end
			end
		end)
		local after, was = leaves(ns.DB().settings), {}
		for path, v in pairs(before) do
			if not same(v, after[path]) then was[#was + 1] = { path = path, value = v } end
		end
		for path in pairs(after) do
			if before[path] == nil then was[#was + 1] = { path = path } end
		end
		ns.Fire("PROFILES_CHANGED")
		return true, { profile = P.Active(), was = was, count = #list }
	end
	local from = P.Active()
	local made, why = P.New(name)
	if not made then return nil, why end
	local t = store()[made]
	for _, path in ipairs(preview.keys) do
		local v = preview.settings[path]
		if (not pick or pick[preview.category[path]]) and not same(v, ns.GetDefault(path)) then setPath(t, path, deepCopy(v)) end
	end
	return true, { made = made, from = from }
end

-- Takes back what P.Apply did (its undo): every setting of the profile it
-- changed as it was (through ns.Set while the profile is in use, a second
-- round for what a setting changed in turn; else in its own table), or the
-- profile it made gone and the one in use before it back. -> true | nil, why
function P.Undo(u)
	if type(u) ~= "table" then return nil, damaged() end
	if u.made then
		if not P.Exists(u.made) then return nil, missing(u.made) end
		if P.Active() == u.made then
			local ok, why = P.Switch(P.Exists(u.from) and u.from or P.DEFAULT)
			if not ok then return nil, why end
		end
		return P.Delete(u.made)
	end
	if type(u.was) ~= "table" then return nil, damaged() end
	if not P.Exists(u.profile) then return nil, missing(u.profile) end
	if u.profile == P.Active() then
		batch(function()
			for _ = 1, 2 do
				for _, w in ipairs(u.was) do
					if not same(ns.GetStored(w.path), w.value) then ns.Set(w.path, deepCopy(w.value)) end
				end
			end
		end)
	else
		local t = data(u.profile)
		for _, w in ipairs(u.was) do setPath(t, w.path, deepCopy(w.value)) end
	end
	ns.Fire("PROFILES_CHANGED")
	return true
end

-- Position shapes given to core before this loaded.
local pendingPositions = P.pendingPositions
P.pendingPositions = nil
for _, r in ipairs(pendingPositions or {}) do P.RegisterPosition(r[1], r[2]) end

