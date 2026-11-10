-- Settings strings (#1031): a player's Polestar settings as one line of text
-- to share, and the same line read back on the Import page (UI/Import.lua).
--
--   !PSS1!<adler32>!<base64 of zlib of the JSON payload>
--   { "format": 1, "settings": { "ui.scale": 0.9, "nav.arrivalSound": false } }
--
-- The envelope is the guide import string's (docs/PACK_FORMAT.md, "Import
-- strings"; Import.Unpack) under its own prefix. What a string may hold is
-- what the Options pages show: every toggle, slider, dropdown and colour on
-- them (UI.Options.AllControls: the built-in pages and every module's
-- ns.RegisterOptions) with a settings key and a default and no storage of
-- its own (no `set`). An export holds those whose value
-- differs from the default, so window and arrow positions, per-character
-- state, imported guides and the characters list never leave. A string is
-- data only: Import.ParseJSON builds plain tables and nothing in it is run.
-- Reading it checks each value against its control (a toggle's boolean, a
-- slider's range, a dropdown's choices, a colour's three numbers); a key
-- this Polestar has no control for, or a value that does not fit, is skipped
-- and named. A colour source the string turns on turns its rivals off
-- (Theme.SourceRivals: your own accent turns off Class colour), so those are
-- listed as changes too. Applying goes through ns.Set, so every listener
-- reacts as to a change by hand, and keeps the old value of every shared
-- setting that changed, the ones a listener changed included, for Undo
-- (PolestarDB.settingsUndo, one level; Reset all settings drops it, and
-- resetting one section drops that section's).
--
--   SettingsString.Export()       -> string, the number of settings in it
--   SettingsString.Pack(json)     -> a payload in the envelope (tests)
--   SettingsString.Read(text)     -> info | nil, why
--     info = { changes = { { key, label, old, new, oldText, newText } },
--              unchanged = n, skipped = { key, ... } }
--   SettingsString.IsOne(text)    -> whether text is a settings string
--   SettingsString.Apply(info)    -> the number of settings changed
--   SettingsString.CanUndo(), .Undo() -> the number put back

local ADDON, ns = ...
local L = ns.L
local format, byte, char, floor, concat, sort, type, pairs, ipairs, tostring, pcall =
	string.format, string.byte, string.char, math.floor, table.concat, table.sort, type, pairs, ipairs, tostring, pcall

local SS = {}
ns.SettingsString = SS

local PREFIX = "!PSS1!"
local FORMAT = 1
local LIMITS = { length = 20000, payload = 32768, settings = 500 }
SS.PREFIX, SS.FORMAT, SS.LIMITS = PREFIX, FORMAT, LIMITS

local KINDS = { toggle = true, slider = true, dropdown = true, color = true }
-- On the Options pages but no preference to share: whether the guide window is shown.
local NOT_SHARED = { ["ui.shown"] = true }

---------------------------------------------------------------------------
-- What a string may hold
---------------------------------------------------------------------------

-- Every control on the Options pages.
local function controls()
	local O = ns.UI and ns.UI.Options
	if O and O.AllControls then return O.AllControls() end
	return {}
end

-- key -> control: the Options controls a settings string carries.
function SS.Portable()
	local out = {}
	for _, c in ipairs(controls()) do
		local key = type(c) == "table" and c.key
		if KINDS[c.kind] and type(key) == "string" and not NOT_SHARED[key] and c.set == nil and out[key] == nil and ns.GetDefault(key) ~= nil then
			out[key] = c
		end
	end
	return out
end

local function labelOf(c)
	local l = c.label
	if type(l) == "function" then
		local ok, s = pcall(l)
		l = ok and s or nil
	end
	return type(l) == "string" and l or c.key
end

local function choicesOf(c)
	local list = c.choices
	if type(list) == "function" then
		local ok, r = pcall(list)
		list = ok and r or nil
	end
	return type(list) == "table" and list or {}
end

local function finite(v) return type(v) == "number" and v == v and v ~= math.huge and v ~= -math.huge end

-- v as control c holds it, or nil when it does not fit.
local function fit(c, v)
	if c.kind == "toggle" then
		if type(v) == "boolean" then return v end
	elseif c.kind == "slider" then
		if not finite(v) then return nil end
		-- In range; not snapped to the step, as some defaults sit between steps (0.94).
		local lo, hi = c.min or 0, c.max or 1
		if v < lo - 1e-9 or v > hi + 1e-9 then return nil end
		return v
	elseif c.kind == "dropdown" then
		if type(v) ~= "string" and not finite(v) then return nil end
		for _, ch in ipairs(choicesOf(c)) do
			if type(ch) == "table" and ch.value == v then return v end
		end
	elseif c.kind == "color" then
		-- false: no colour of its own (the theme's, the class's).
		if v == false then return false end
		if type(v) ~= "table" or #v < 3 or #v > 4 then return nil end
		local out = {}
		for i = 1, #v do
			if not finite(v[i]) or v[i] < 0 or v[i] > 1 then return nil end
			out[i] = v[i]
		end
		return out
	end
	return nil
end

local function same(a, b)
	if type(a) == "table" and type(b) == "table" then
		if #a ~= #b then return false end
		for i = 1, #a do
			if a[i] ~= b[i] then return false end
		end
		return true
	end
	return a == b
end

-- A value as the Options page shows it.
local function shown(c, v)
	if c.kind == "toggle" then return v and L["On"] or L["Off"] end
	if c.kind == "slider" then
		local f = c.format
		if type(f) == "function" then
			local ok, s = pcall(f, v)
			if ok and s then return tostring(s) end
		elseif type(f) == "string" then
			local ok, s = pcall(format, f, v)
			if ok then return s end
		end
		return tostring(v)
	end
	if c.kind == "dropdown" then
		for _, ch in ipairs(choicesOf(c)) do
			if type(ch) == "table" and ch.value == v then return tostring(ch.text or ch.label or v) end
		end
		return tostring(v)
	end
	if c.kind == "color" and v == false then return L["Default"] end
	if c.kind == "color" and type(v) == "table" then
		local hex = format("%02X%02X%02X", floor(v[1] * 255 + 0.5), floor(v[2] * 255 + 0.5), floor(v[3] * 255 + 0.5))
		return "|cff" .. hex .. "#" .. hex .. "|r"
	end
	return tostring(v)
end

---------------------------------------------------------------------------
-- Writing a string: JSON, a stored (uncompressed) zlib stream and base64,
-- in plain Lua, so it needs no encoder from the client. A settings payload
-- is a few hundred bytes; any zlib reader takes stored blocks.
---------------------------------------------------------------------------

local ESC = { ['"'] = '\\"', ["\\"] = "\\\\", ["\n"] = "\\n", ["\r"] = "\\r", ["\t"] = "\\t" }

local function jstr(s)
	return '"' .. s:gsub('[%c"\\]', function(ch) return ESC[ch] or format("\\u%04x", byte(ch)) end) .. '"'
end

local function jnum(v)
	if v == floor(v) and v > -1e15 and v < 1e15 then return format("%d", v) end
	return format("%.10g", v)
end

local function jvalue(v)
	if type(v) == "boolean" then return v and "true" or "false" end
	if type(v) == "number" then return jnum(v) end
	if type(v) == "string" then return jstr(v) end
	local out = {}
	for i = 1, #v do out[i] = jnum(v[i]) end
	return "[" .. concat(out, ",") .. "]"
end

local function zlibStored(s)
	local out = { "\120\1" }
	local n, at = #s, 1
	repeat
		local len = n - at + 1
		if len > 65535 then len = 65535 end
		local last = at + len > n
		local nlen = 65535 - len
		out[#out + 1] = char(last and 1 or 0, len % 256, floor(len / 256), nlen % 256, floor(nlen / 256))
		out[#out + 1] = s:sub(at, at + len - 1)
		at = at + len
	until at > n
	local sum = ns.Import.Adler32(s)
	for i = 1, 8, 2 do out[#out + 1] = char(tonumber(sum:sub(i, i + 1), 16)) end
	return concat(out)
end

local B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function base64(s)
	local out = {}
	for i = 1, #s, 3 do
		local a, b, c = byte(s, i, i + 2)
		local v = a * 65536 + (b or 0) * 256 + (c or 0)
		local q = {}
		for j = 4, 1, -1 do
			q[j] = v % 64 + 1
			v = floor(v / 64)
		end
		out[#out + 1] = B64:sub(q[1], q[1]) .. B64:sub(q[2], q[2])
			.. (b and B64:sub(q[3], q[3]) or "=") .. (c and B64:sub(q[4], q[4]) or "=")
	end
	return concat(out)
end

-- A JSON payload in the settings string envelope.
function SS.Pack(json)
	return PREFIX .. ns.Import.Adler32(json) .. "!" .. base64(zlibStored(json))
end

-- The changed settings as a string. -> string, count
function SS.Export()
	local portable, keys = SS.Portable(), {}
	for key, c in pairs(portable) do
		local v = fit(c, ns.Get(key))
		if v ~= nil and not same(v, ns.GetDefault(key)) then keys[#keys + 1] = key end
	end
	sort(keys)
	local parts = {}
	for i, key in ipairs(keys) do parts[i] = jstr(key) .. ":" .. jvalue(fit(portable[key], ns.Get(key))) end
	return SS.Pack(format('{"format":%d,"settings":{%s}}', FORMAT, concat(parts, ","))), #keys
end

---------------------------------------------------------------------------
-- Reading a string
---------------------------------------------------------------------------

function SS.IsOne(text)
	return type(text) == "string" and text:gsub("%s+", ""):match("^!PSS%d+!") ~= nil
end

function SS.Read(text)
	local I = ns.Import
	if type(text) ~= "string" then return nil, L["Paste an import string."] end
	local s = text:gsub("%s+", "")
	if #s > LIMITS.length then return nil, (L["This settings string is too long: Polestar reads up to %d characters."]):format(LIMITS.length) end
	local version = s:match("^!PSS(%d+)!")
	if not version then return nil, L["This is not a Polestar import string."] end
	if version ~= "1" then return nil, L["This settings string needs a newer Polestar."] end
	local raw, why = I.Unpack(s, PREFIX, LIMITS.payload)
	if raw == false then return nil, I.Damaged() end
	if not raw then return nil, why end
	local tree = I.ParseJSON(raw)
	if type(tree) ~= "table" or type(tree.format) ~= "number" or type(tree.settings) ~= "table" then return nil, I.Damaged() end
	if tree.format > FORMAT then return nil, L["This settings string needs a newer Polestar."] end
	local portable = SS.Portable()
	local info = { changes = {}, unchanged = 0, skipped = {} }
	local inString = {}
	local n = 0
	for key, value in pairs(tree.settings) do
		n = n + 1
		if n > LIMITS.settings then return nil, I.Damaged() end
		-- `or nil`: a number key (a JSON array) is skipped like any other.
		local c = type(key) == "string" and portable[key] or nil
		local v = c and fit(c, value)
		if v == nil then
			info.skipped[#info.skipped + 1] = tostring(key)
		else
			inString[key] = true
			local old = ns.Get(key)
			if same(old, v) then
				info.unchanged = info.unchanged + 1
			else
				info.changes[#info.changes + 1] = { key = key, label = labelOf(c), old = old, new = v, oldText = shown(c, old), newText = shown(c, v) }
			end
		end
	end
	-- The colour sources Apply turns off as it turns one on: shown before they change.
	local T = ns.Theme
	if T and T.SourceRivals then
		local turned = {}
		for i = 1, #info.changes do
			local ch = info.changes[i]
			for _, rival in ipairs(T.SourceRivals(ch.key, ch.new) or {}) do
				local c = portable[rival]
				local old = ns.Get(rival)
				if c and not inString[rival] and not turned[rival] and T.SourceOn(rival, old) then
					turned[rival] = true
					local new = T.SourceOff(rival)
					info.changes[#info.changes + 1] = { key = rival, label = labelOf(c), old = old, new = new, oldText = shown(c, old), newText = shown(c, new) }
				end
			end
		end
	end
	sort(info.changes, function(a, b)
		if a.label ~= b.label then return a.label < b.label end
		return a.key < b.key
	end)
	sort(info.skipped)
	return info
end

---------------------------------------------------------------------------
-- Applying and Undo
---------------------------------------------------------------------------

local function copy(v)
	if type(v) ~= "table" then return v end
	local out = {}
	for i = 1, #v do out[i] = v[i] end
	return out
end

-- ns.Set of v, passing the default itself when v equals it, so the setting
-- is cleared (back to following its default) rather than stored.
local function set(key, v)
	local d = ns.GetDefault(key)
	ns.Set(key, same(v, d) and d or copy(v))
end

-- Every shared setting's value now (copies).
local function snapshot(portable)
	local out = {}
	for key in pairs(portable) do out[key] = copy(ns.Get(key)) end
	return out
end

function SS.Apply(info)
	if type(info) ~= "table" or type(info.changes) ~= "table" or #info.changes == 0 then return 0 end
	local portable = SS.Portable()
	local before = snapshot(portable)
	for _, ch in ipairs(info.changes) do set(ch.key, ch.new) end
	-- Undo keeps every setting that changed, not only the string's: a listener
	-- may have changed others (a colour source turning its rivals off).
	local undo = {}
	for key, old in pairs(before) do
		if not same(old, ns.Get(key)) then undo[key] = old end
	end
	ns.DB().settingsUndo = undo
	return #info.changes
end

function SS.CanUndo()
	local u = ns.DB().settingsUndo
	return type(u) == "table" and next(u) ~= nil
end

-- Puts back what the last Apply replaced (each value still checked against
-- its control). -> the number put back
function SS.Undo()
	local db = ns.DB()
	local u = db.settingsUndo
	db.settingsUndo = nil
	if type(u) ~= "table" then return 0 end
	local portable, n = SS.Portable(), 0
	for key, value in pairs(u) do
		local c = portable[key]
		local v = c and fit(c, value)
		if v ~= nil then
			set(key, v)
			n = n + 1
		end
	end
	return n
end

-- Reset all settings drops Undo; resetting one section drops that section's
-- keys (ns.ResetSettings fires "" or the section's name).
if ns.On then
	ns.On("SETTING_CHANGED", function(path)
		if type(path) ~= "string" or path:find(".", 1, true) then return end
		local db = ns.DB()
		local u = db.settingsUndo
		if type(u) ~= "table" then return end
		if path == "" then
			db.settingsUndo = nil
			return
		end
		for key in pairs(u) do
			if key:sub(1, #path + 1) == path .. "." then u[key] = nil end
		end
		if next(u) == nil then db.settingsUndo = nil end
	end)
end
