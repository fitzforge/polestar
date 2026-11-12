-- Presets: a Look page's named looks, the first row of its Essentials tab,
-- as picture cards. A preset is a set of settings ({ [key] = value }); the
-- page's preset keys are every key any of its presets names. Picking a card
-- puts each of those keys back to its default and writes the preset's values
-- (only what changes is written, so each change paints once); keys no preset
-- names stay as they are. A card is lit while the settings are exactly its
-- values, none while the look is the player's own. The first preset is the
-- defaults ({}), so it also undoes the others.
--
--   O.PresetCards{ label?, help?, search?, presets = { { value, label, set = { [key] = value },
--     draw = fn(art, preset)?, note? }, ... } }
--     -> a cards control for RegisterOptions (no key of its own: get/set over the presets)
--   O.PresetOf(list) -> value | nil      the preset the settings match
--   O.ApplyPreset(list, value)           pick one (nil: the first)
--   O.PresetSummary(preset) -> text      "Pin size 150%, Numbers 120%" (its card's tooltip)
--   O.WithSettings(values, fn, ...)      fn(...) while ns.Get answers `values` for their keys
--                                        (a card's art drawn by the element's own look code)
--
-- A widget that shows several settings (a control with `watch = { [key] =
-- true }`) refreshes when one of them changes (UI/Options.lua).

local ns = Polestar
local UI, W = ns.UI, ns.Widgets
local L = ns.L
local O = UI.Options
local abs, type, pairs, ipairs = math.abs, type, pairs, ipairs

local function same(a, b)
	if type(a) == "number" and type(b) == "number" then return abs(a - b) < 1e-6 end
	if type(a) ~= "table" or type(b) ~= "table" then return a == b end
	for k, v in pairs(a) do if not same(v, b[k]) then return false end end
	for k in pairs(b) do if a[k] == nil then return false end end
	return true
end
O.Same = same

local function copy(v)
	if type(v) ~= "table" then return v end
	local t = {}
	for k, x in pairs(v) do t[k] = copy(x) end
	return t
end

-- The keys any preset of the list names, sorted. -> set, list
local function unionOf(list)
	local set, keys = {}, {}
	for _, p in ipairs(list) do
		for k in pairs(p.set or {}) do
			if not set[k] then set[k], keys[#keys + 1] = true, k end
		end
	end
	table.sort(keys)
	return set, keys
end

-- What preset p makes key k: its value, else the default.
local function target(p, k)
	local v = p.set and p.set[k]
	if v == nil then return ns.GetDefault(k) end
	return v
end

function O.PresetOf(list)
	local _, keys = unionOf(list)
	for _, p in ipairs(list) do
		local match = true
		for _, k in ipairs(keys) do
			if ns.GetDefault(k) ~= nil and not same(ns.Get(k), target(p, k)) then
				match = false
				break
			end
		end
		if match then return p.value end
	end
	return nil
end

function O.ApplyPreset(list, value)
	local p = list[1]
	for _, x in ipairs(list) do
		if x.value == value then p = x end
	end
	if not p then return end
	local _, keys = unionOf(list)
	for _, k in ipairs(keys) do
		local def = ns.GetDefault(k)
		if def ~= nil then
			local want = p.set and p.set[k]
			if want == nil then
				if not same(ns.Get(k), def) then ns.Set(k, nil) end
			elseif not same(ns.Get(k), want) then
				ns.Set(k, copy(want))
			end
		end
	end
end

-- A value as its control shows it: a slider's format, a choice's label,
-- On / Off, a colour's hex.
local function valueText(c, v)
	if c.kind == "slider" then
		local f = c.format
		if type(f) == "function" then
			local ok, s = pcall(f, v)
			if ok and s then return tostring(s) end
		elseif type(f) == "string" then
			local ok, s = pcall(string.format, f, v)
			if ok then return s end
		end
		return tostring(v)
	elseif c.kind == "dropdown" or c.kind == "cards" or c.kind == "font" then
		local list = c.choices
		if type(list) == "function" then
			local ok, l = pcall(list)
			list = ok and l or nil
		end
		for _, ch in ipairs(list or {}) do
			if ch.value == v then return ch.text or ch.label or tostring(v) end
		end
		return tostring(v)
	elseif c.kind == "toggle" then
		return v and L["On"] or L["Off"]
	elseif c.kind == "color" and type(v) == "table" then
		return W.ColorHex and W.ColorHex(v[1] or 1, v[2] or 1, v[3] or 1) or ""
	end
	return tostring(v)
end

-- The home control of a setting (its row on a deep tab). -> spec | nil
local function homeControl(key)
	for _, c in ipairs(O.AllControls()) do
		if c.key == key then return c end
	end
end

function O.PresetSummary(p)
	if not (p.set and next(p.set)) then return p.help or L["Every setting here at its default."] end
	local parts = {}
	for _, k in ipairs(select(2, unionOf({ p }))) do
		local c = homeControl(k)
		local label = c and (type(c.label) == "function" and c.label() or c.label)
		if label then parts[#parts + 1] = label .. " " .. valueText(c, p.set[k]) end
	end
	local text = table.concat(parts, ", ")
	if p.help then text = p.help .. "\n" .. text end
	return text
end

-- ns.Get answering `values` (and every other key it is asked through
-- `defaults`) while fn runs: a preset's card drawn with its own values by
-- the look code the element itself uses. Restored however fn ends.
function O.WithSettings(values, fn, ...)
	local get = ns.Get
	ns.Get = function(path)
		local v = values[path]
		if v ~= nil then return v end
		return get(path)
	end
	local ok, a, b, c = pcall(fn, ...)
	ns.Get = get
	if not ok then
		if geterrorhandler then geterrorhandler()(a) end
		return nil
	end
	return a, b, c
end

-- What a preset's card is drawn with: its values over the defaults of every
-- other key of its row.
function O.PresetValues(list, p)
	local _, keys = unionOf(list)
	local out = {}
	for _, k in ipairs(keys) do out[k] = target(p, k) end
	return out
end

-- The cards drawn so far (art -> its draw): each is drawn again after every
-- setting or theme change while it shows, after the elements' own repaints
-- (this file registers after them), so a sandbox element a module repaints
-- from the live settings goes back to its preset's values.
local arts = setmetatable({}, { __mode = "k" })
local function redrawShown()
	for art, draw in pairs(arts) do
		if art:IsVisible() then draw() end
	end
end
ns.On("SETTING_CHANGED", redrawShown)
if ns.Theme and ns.Theme.OnChanged then ns.Theme.OnChanged(redrawShown) end

function O.PresetCards(opts)
	local list = opts.presets
	local set = unionOf(list)
	return {
		kind = "cards", label = opts.label or L["Presets"], wide = true, presets = list, watch = set,
		help = opts.help or L["A look in one click: it sets the settings it names and puts the others of these looks back to their defaults. Right-click goes back to the defaults."],
		search = opts.search or "preset, presets, look, style, quick, one click, recommended",
		get = function() return O.PresetOf(list) end,
		set = function(v) O.ApplyPreset(list, v) end,
		choices = function()
			local out = {}
			for i, p in ipairs(list) do
				local draw
				if p.draw then
					draw = function(art)
						local function go() p.draw(art, p, O.PresetValues(list, p)) end
						arts[art] = go
						go()
					end
				end
				out[i] = { value = p.value, label = p.label, note = p.note, draw = draw, tip = O.PresetSummary(p) }
			end
			return out
		end,
	}
end
