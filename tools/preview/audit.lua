-- The skin audit's Lua side (tools/preview/audit.js): loaded after the
-- preview stub and the playground driver (tools/play/driver.lua: geometry
-- from the anchors, scripts that raise reported, not fatal), before any
-- addon. It adds to each dumped object what the audit reads that the
-- preview's dump leaves out, and dumps the surface.
--
--   audit.dump(surface, scale)   two emits: { objects, extra }, at login and
--                                after a repaint

audit = {}

-- The driver speaks its own protocol and silences emit(): the audit's dumps
-- go out as the test helper reads them (wow_stub.lua's emit).
function emit(v) io.write("@@JSON ", stub.json(v), "\n") end

local kitKeys = {} -- object -> the kit key it is kept under (closeN, metal, drag, ...)
local BIG = { frame = true, metal = true, crown = true, dialog = true, dialogArt = true, dialogTile = true, streaks = true, drag = true }

-- Every painted frame's kit pieces, by the key they are kept under.
local function collectKits()
	kitKeys = {}
	for _, f in ipairs(stub.frames) do
		local d = rawget(f, "psSkin")
		local kit = type(d) == "table" and d.kit
		if type(kit) == "table" then
			for key, v in pairs(kit) do
				if type(v) == "table" then
					if v.kind then
						kitKeys[v] = key
					else
						for _, t in pairs(v) do
							if type(t) == "table" and t.kind then kitKeys[t] = key end
						end
					end
				end
			end
		end
	end
end

preview.entryExtra = function(o, e)
	local key = kitKeys[o]
	if key then e.kitKey = key end
	if o.kind == "Texture" or o.kind == "FontString" or o.kind == "MaskTexture" or o.kind == "Line" then return end
	local m = rawget(o, "mouse")
	if m ~= nil then e.mouse = m end
	if rawget(o, "hitInsets") then e.hitInsets = o.hitInsets end
	if rawget(o, "enabled") == false then e.disabled = true end
	local icon = rawget(o, "psIconName")
	if type(icon) == "string" then e.icon = icon end
	if rawget(o, "psTabClose") then e.tabClose = true end
	if rawget(o, "psGuide") then e.guide = true end
	if rawget(o, "psLight") then e.light = true end
	-- Names for a control without a label of its own: its tooltip, or what it is.
	local tip = rawget(o, "psTip")
	if type(tip) == "string" then e.tip = tip end
	if rawget(o, "psScroll") and rawget(o, "psThumb") then e.role = "scroll bar" end
	-- A shell's sidebar row (Theme/Widgets.lua navRow: psShell and psItem).
	if rawget(o, "psShell") and rawget(o, "psItem") then e.navRow = true end
	-- A settings preview's hotspot (Polestar_Options/UI/Preview.lua P.Hotspot:
	-- psKey with psPadSkip): click to find a part's settings, the smaller
	-- parts' over the whole by design.
	if rawget(o, "psKey") ~= nil and rawget(o, "psPadSkip") then e.hotspot = true end
	-- A settings preview's copy of a card, toast or tracker: its buttons do
	-- nothing (a sandbox card's actions are no-ops), so none is checked for
	-- clicks; what it draws is checked as any surface's.
	local toast, tracker = rawget(o, "psToast"), rawget(o, "psTracker")
	if rawget(o, "psSandbox") or (type(toast) == "table" and toast.sandbox) or (type(tracker) == "table" and tracker.sandbox) then e.sandbox = true end
end

-- The client's atlases (the game's looks name their art by atlas): where the
-- stub has none, a stand-in of the atlas's name, so every piece a look draws
-- is on screen with the size the look gives it (the art itself is not drawn).
do
	C_Texture = C_Texture or {}
	local real = C_Texture.GetAtlasInfo
	C_Texture.GetAtlasInfo = function(name)
		local info = real and real(name)
		if info then return info end
		if type(name) ~= "string" or name == "" then return nil end
		return { file = "atlas:" .. name, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0, bottomTexCoord = 1, width = 32, height = 32 }
	end
end

-- What the look in use is: its id, the kit (a game look's closes), the sizes
-- the guide window gives its icon buttons.
local function lookInfo()
	local T = Polestar.Theme
	local kit = T.Kit and T.Kit()
	return {
		skin = T.SkinId and T.SkinId() or T.SkinKey(),
		base = T.SkinKey(),
		kit = kit and { ink = kit.closeInk or 1, bare = kit.bareIcons and true or false } or false,
		iconBtn = T.Metric("guideIconBtnW", 24),
		guideIcon = T.Metric("guideIcon", 14),
	}
end

-- The big window's pieces shown on a frame painted as the guide window or a
-- toast (#1802: they lay over the card above the window).
local function bigOnGuide()
	local out = {}
	for _, f in ipairs(stub.frames) do
		local d = rawget(f, "psSkin")
		local kit = type(d) == "table" and d.kit
		if (rawget(f, "psGuide") or rawget(f, "psLight")) and type(kit) == "table" and f:IsVisible() then
			local keys = {}
			for key in pairs(BIG) do
				local v = kit[key]
				local on = type(v) == "table" and ((v.IsVisible and v:IsVisible()) or (not v.IsVisible and v[1] and v[1].IsVisible and v[1]:IsVisible()))
				if on then keys[#keys + 1] = key end
			end
			if #keys > 0 then
				table.sort(keys)
				out[#out + 1] = (f:GetName() or (f:GetParent() and f:GetParent():GetName() and (f:GetParent():GetName() .. ">" .. f:GetObjectType())) or f:GetObjectType()) .. ": " .. table.concat(keys, ", ")
			end
		end
	end
	table.sort(out)
	return out
end

local function errors()
	local out = {}
	for _, e in ipairs(play.errors or {}) do out[#out + 1] = tostring(e.msg) end
	return out
end

-- The surface as built at the UI scale set before login (UIParent's scale is
-- the game's UI scale), then after a repaint, as a change of UI scale or of
-- a look's setting makes: what a first paint leaves behind (#1802) and what
-- only a repaint draws both show.
function audit.dump(surface, scale)
	local function one(state)
		collectKits()
		emit({ objects = preview.dump({ visibleOnly = true }), extra = { surface = surface, scale = scale, state = state, look = lookInfo(), big = bigOnGuide(), errors = errors() } })
	end
	one("login")
	stub.fire("UI_SCALE_CHANGED")
	stub.advance(0.5)
	one("repaint")
end
