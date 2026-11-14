-- The game's Options search and its Discord sign-in row, as far as taint
-- goes, for the key bindings' search tags (#1996, #1997, #2207). Shaped on
-- the 1.60.1 interface code (builds 70888 and 70938):
--
--   * Blizzard_SettingsDefinitions_Frame/Keybindings.lua, CreateSearchableSettings:
--     after login the Keybindings registrant builds a hidden category of
--     every key binding for the search. A binding's name comes through
--     securecallfunction(GetBindingName, action), clean even from an addon's
--     BINDING_NAME_ global, but its extra tags come through
--     C_KeyBindings.GetSearchTagsForAction(action) with no securecallfunction:
--     each token of the binding's Bindings.xml searchTags is that global's
--     value, and a global an addon wrote carries the addon's taint (the last
--     writer's). From that read on the build runs tainted, and what it writes
--     after it (the later rows' tags, the hidden category's redirectCategory)
--     carries the taint.
--   * Blizzard_Settings_Shared/Blizzard_SettingsPanel.lua,
--     FindInitializersMatchingSearchText: every keystroke in the search box
--     reads each category's redirectCategory, unguarded, so the whole search
--     runs with that taint.
--   * Blizzard_SettingsDefinitions_Frame/Social.lua: a search the Discord
--     sign-in row matches (or the display name row under it) builds that row,
--     whose button text asks C_Discord.IsUserOAuthed(), a function with
--     restrictions (Blizzard_APIDocumentationGenerated/DiscordDocumentation.lua):
--     from tainted code the game blocks it and fires ADDON_ACTION_FORBIDDEN
--     naming the addon.
--
--   local S = stub.optionsSearch
--   S.watch(bindings)  before the addons load: the bindings as the Bindings.xml
--                      files declare them, { { action =, tags = { token, ... } } };
--                      the globals their tokens name are watched, so
--                      S.writers[token] is the addon whose code last wrote it
--   S.build()          the registrant after login -> the addon whose taint
--                      the hidden category's redirectCategory carries, or nil
--   S.search()         a keystroke whose results show the Discord sign-in row
--                      -> the addon blamed for its IsUserOAuthed(), or nil

local S = { bindings = {}, byAction = {}, writers = {}, values = {}, taint = nil }
stub.optionsSearch = S

-- The addon whose code is the caller of the metamethod at `level`.
local function writerAt(level)
	local info = debug.getinfo(level + 1, "S")
	return info and stub.addonSources[info.source] or nil
end

function S.watch(bindings)
	S.bindings = bindings
	local watched = {}
	for _, b in ipairs(bindings) do
		S.byAction[b.action] = b
		for _, token in ipairs(b.tags or {}) do watched[token] = true end
	end
	-- Kept out of _G's own slots, so every write (a second addon's too) comes here.
	for token in pairs(watched) do
		S.values[token] = rawget(_G, token)
		rawset(_G, token, nil)
	end
	local mt = getmetatable(_G) or {}
	local index, newindex = mt.__index, mt.__newindex
	mt.__index = function(t, k)
		if watched[k] then return S.values[k] end
		if type(index) == "function" then return index(t, k) end
		if type(index) == "table" then return index[k] end
		return nil
	end
	mt.__newindex = function(t, k, v)
		if watched[k] then
			S.values[k], S.writers[k] = v, writerAt(2)
			return
		end
		if newindex then return newindex(t, k, v) end
		rawset(t, k, v)
	end
	setmetatable(_G, mt)
end

-- The client's C_KeyBindings.GetSearchTagsForAction: the binding's tokens as
-- their globals' strings. A read of an addon's global taints the build.
C_KeyBindings = C_KeyBindings or {}
function C_KeyBindings.GetSearchTagsForAction(action)
	local b = S.byAction[action]
	if not (b and b.tags and #b.tags > 0) then return nil end
	local tags = {}
	for _, token in ipairs(b.tags) do
		local v = _G[token]
		if type(v) == "string" then
			tags[#tags + 1] = v
			if S.writers[token] then S.taint = S.writers[token] end
		end
	end
	return tags
end

-- CreateSearchableSettings: every binding's tags, then the hidden category's
-- redirectCategory, written last with the build's taint.
function S.build()
	S.taint = nil
	for _, b in ipairs(S.bindings) do C_KeyBindings.GetSearchTagsForAction(b.action) end
	S.redirectTaint = S.taint
	return S.redirectTaint
end

-- One keystroke: the search reads the redirectCategory, then builds the
-- Discord sign-in row, whose IsUserOAuthed() the game blocks when tainted.
function S.search()
	local taint = S.redirectTaint
	if taint then stub.fire("ADDON_ACTION_FORBIDDEN", taint, "IsUserOAuthed()") end
	return taint
end
