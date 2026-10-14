-- A stand-in for the WoW: Forever client, generic enough for every module's
-- tests: frames, scripts, events, timers, fonts, animation groups, slash
-- commands, settings panels and a fake EllesmereUI. Quest, map and unit APIs
-- are NOT here; each module adds the world it needs in tests/lua/stub_<module>.lua.
--
-- Frames are plain tables. A capitalized method that is not implemented below
-- resolves to a no-op returning nil, so the long tail of Set* calls is accepted.
--
--   stub.fire(event, ...)    deliver a game event to every frame registered for it
--   stub.advance(seconds)    move the clock: OnUpdate scripts, due timers, tickers
--   stub.runTimers()         run timers due now (C_Timer.After(0, ...))
--   stub.addonLoaded(name)   fire ADDON_LOADED(name)
--   stub.login()             PLAYER_LOGIN then PLAYER_ENTERING_WORLD(true, false)
--   stub.messages            every chat line the addon printed
--   stub.frame(name)         look up a named frame
--   stub.withEllesmere()     install a fake EllesmereUI matching SKINNING_API.md
--   stub.json(value)         encode a value for emit()
--
-- Animation groups finish synchronously: Play() runs OnPlay then OnFinished.
-- WoW's global trig helpers (sin, cos, atan2, ...) take and return degrees, as
-- in the client; use math.* for radians.

stub = {
	frames = {},
	strings = {},
	timers = {},
	tickers = {},
	now = 0,
	epoch = 1791000000,
	messages = {},
	cvars = {},
	keys = { shift = false, ctrl = false, alt = false },
	bindings = {}, -- key -> command (SetBinding)
	bindingSaves = 0, -- SaveBindings calls
	sounds = {},
	popups = {},
	addonsLoaded = {},
	addonMeta = {},
	addons = {}, -- the AddOns list: { name, title, loaded, reason ("DISABLED", "INTERFACE_VERSION"...), enabled }
	enabledAddOns = {}, -- names passed to C_AddOns.EnableAddOn
	inCombat = false,
	cursor = { 960, 540 },
}

local function noop() end

---------------------------------------------------------------------------
-- Objects
---------------------------------------------------------------------------

local Methods = {}
stub.Methods = Methods

local ObjectMT = {
	__index = function(_, key)
		local m = Methods[key]
		if m then return m end
		if type(key) == "string" and key:match("^%u") then return noop end
		return nil
	end,
}

local function NewObject(kind, name, parent)
	local o = setmetatable({
		kind = kind,
		name = name,
		parent = parent,
		scripts = {},
		hooks = {},
		events = {},
		points = {},
		children = {},
		regions = {},
		shown = true,
		alpha = 1,
		enabled = true,
	}, ObjectMT)
	if parent and parent.children then
		if kind == "Texture" or kind == "FontString" or kind == "MaskTexture" then
			table.insert(parent.regions, o)
		else
			table.insert(parent.children, o)
		end
	end
	if name then _G[name] = o end
	return o
end
stub.NewObject = NewObject

local function RunScript(self, name, ...)
	local fn = self.scripts[name]
	if fn then fn(self, ...) end
	local hooks = self.hooks[name]
	if hooks then
		for i = 1, #hooks do hooks[i](self, ...) end
	end
end
stub.RunScript = RunScript

function Methods.GetObjectType(self) return self.kind end
function Methods.IsObjectType(self, kind) return self.kind == kind end
function Methods.GetName(self) return self.name end
function Methods.GetDebugName(self) return self.name or tostring(self) end
function Methods.GetParent(self) return self.parent end
function Methods.SetParent(self, p)
	self.parent = p
	if p and p.children then table.insert(p.children, self) end
end
function Methods.GetChildren(self) return unpack(self.children) end
function Methods.GetNumChildren(self) return #self.children end
function Methods.GetRegions(self) return unpack(self.regions) end

-- Scripts
function Methods.SetScript(self, name, fn) self.scripts[name] = fn end
function Methods.GetScript(self, name) return self.scripts[name] end
function Methods.HasScript() return true end
function Methods.HookScript(self, name, fn)
	self.hooks[name] = self.hooks[name] or {}
	table.insert(self.hooks[name], fn)
end

-- Events
function Methods.RegisterEvent(self, ev) self.events[ev] = true end
function Methods.RegisterUnitEvent(self, ev) self.events[ev] = true end
function Methods.UnregisterEvent(self, ev) self.events[ev] = nil end
function Methods.UnregisterAllEvents(self) self.events = {} end
function Methods.IsEventRegistered(self, ev) return self.events[ev] == true end

-- Visibility
function Methods.Show(self)
	local was = self.shown
	self.shown = true
	if not was then RunScript(self, "OnShow") end
end
function Methods.Hide(self)
	local was = self.shown
	self.shown = false
	if was then RunScript(self, "OnHide") end
end
function Methods.SetShown(self, v) if v then self:Show() else self:Hide() end end
function Methods.IsShown(self) return self.shown end
function Methods.IsVisible(self)
	local f = self
	while f do
		if not f.shown then return false end
		f = f.parent
	end
	return true
end
function Methods.SetAlpha(self, a) self.alpha = a end
function Methods.GetAlpha(self) return self.alpha end
function Methods.GetEffectiveAlpha(self) return self.alpha end

-- Geometry
function Methods.SetSize(self, w, h) self.width, self.height = w, h end
function Methods.SetWidth(self, w) self.width = w end
function Methods.SetHeight(self, h) self.height = h end
function Methods.GetWidth(self) return self.width or 0 end
function Methods.GetHeight(self) return self.height or 0 end
function Methods.GetSize(self) return self:GetWidth(), self:GetHeight() end
function Methods.GetRect(self) return self.x or 0, self.y or 0, self:GetWidth(), self:GetHeight() end
function Methods.GetLeft(self) return self.x or 0 end
function Methods.GetBottom(self) return self.y or 0 end
function Methods.GetTop(self) return (self.y or 0) + self:GetHeight() end
function Methods.GetRight(self) return (self.x or 0) + self:GetWidth() end
function Methods.GetCenter(self) return (self.x or 0) + self:GetWidth() / 2, (self.y or 0) + self:GetHeight() / 2 end
function Methods.SetPoint(self, point, rel, relPoint, x, y)
	if type(rel) == "number" then rel, relPoint, x, y = nil, nil, rel, relPoint end
	if type(rel) == "string" then rel = _G[rel] end
	if rel ~= nil and type(relPoint) ~= "string" then relPoint, x, y = point, relPoint, x end
	table.insert(self.points, { point = point, rel = rel, relPoint = relPoint or point, x = x or 0, y = y or 0 })
end
function Methods.SetAllPoints(self, other)
	other = other or self.parent
	self:SetPoint("TOPLEFT", other, "TOPLEFT", 0, 0)
	self:SetPoint("BOTTOMRIGHT", other, "BOTTOMRIGHT", 0, 0)
end
function Methods.ClearAllPoints(self) self.points = {} end
function Methods.GetNumPoints(self) return #self.points end
function Methods.GetPoint(self, i)
	local p = self.points[i or 1]
	if not p then return nil end
	return p.point, p.rel, p.relPoint, p.x, p.y
end
function Methods.SetScale(self, s) self.scale = s end
function Methods.GetScale(self) return self.scale or 1 end
function Methods.GetEffectiveScale(self)
	local s, f = 1, self
	while f do s = s * (f.scale or 1); f = f.parent end
	return s
end
function Methods.SetFrameStrata(self, s) self.strata = s end
function Methods.GetFrameStrata(self) return self.strata or "MEDIUM" end
function Methods.SetFrameLevel(self, l) self.level = l end
function Methods.GetFrameLevel(self) return self.level or 1 end
function Methods.SetDrawLayer(self, layer, sub) self.layer, self.sublayer = layer, sub end
function Methods.GetDrawLayer(self) return self.layer or "ARTWORK", self.sublayer or 0 end

-- Mouse / movement
function Methods.EnableMouse(self, v) self.mouse = v and true or false end
function Methods.IsMouseEnabled(self) return self.mouse == true end
function Methods.EnableMouseWheel(self, v) self.mouseWheel = v and true or false end
function Methods.SetMovable(self, v) self.movable = v and true or false end
function Methods.IsMovable(self) return self.movable == true end
function Methods.SetResizable(self, v) self.resizable = v and true or false end
function Methods.IsResizable(self) return self.resizable == true end
function Methods.StartMoving(self) self.moving = true end
function Methods.StartSizing(self) self.sizing = true end
function Methods.StopMovingOrSizing(self) self.moving, self.sizing = false, false end
function Methods.IsMouseOver() return false end
function Methods.Click(self, button) RunScript(self, "OnClick", button or "LeftButton", false) end

-- Text
function Methods.SetText(self, t) self.text = t == nil and nil or tostring(t) end
function Methods.GetText(self) return self.text end
function Methods.SetFormattedText(self, fmt, ...) self.text = string.format(fmt, ...) end
function Methods.SetFont(self, path, size, flags) self.font = { path, size, flags }; return true end
function Methods.GetFont(self)
	local f = self.font or { "Fonts\\FRIZQT__.TTF", 12, "" }
	return f[1], f[2], f[3]
end
function Methods.SetFontObject(self, obj)
	self.fontObject = obj
	if type(obj) == "table" and obj.font then self.font = { obj.font[1], obj.font[2], obj.font[3] } end
end
function Methods.GetFontObject(self) return self.fontObject end
function Methods.SetTextColor(self, r, g, b, a) self.textColor = { r, g, b, a or 1 } end
function Methods.GetTextColor(self)
	local c = self.textColor or { 1, 1, 1, 1 }
	return c[1], c[2], c[3], c[4]
end
function Methods.SetShadowColor(self, r, g, b, a) self.shadowColor = { r, g, b, a or 1 } end
function Methods.GetShadowColor(self)
	local c = self.shadowColor or { 0, 0, 0, 0 }
	return c[1], c[2], c[3], c[4]
end
-- As in the client: GetStringWidth ignores word wrap but includes
-- truncation (a single-line string, SetWordWrap(false), is cut at its set
-- width); GetUnboundedStringWidth is the whole text's width.
function Methods.SetWordWrap(self, on) self.wordWrap = not not on end
function Methods.GetWordWrap(self) return self.wordWrap ~= false end
function Methods.GetUnboundedStringWidth(self)
	local size = (self.font and self.font[2]) or 12
	return #tostring(self.text or "") * size * 0.5
end
function Methods.GetStringWidth(self)
	local full = self:GetUnboundedStringWidth()
	local w = self.width or 0
	if self.wordWrap == false and w > 0 and full > w then return w end
	return full
end
-- Each line of the text (split at "\n") wraps on its own at the set width.
function Methods.GetStringHeight(self)
	local size = (self.font and self.font[2]) or 12
	local w = self.width or 0
	if w <= 0 then return size end
	local lines = 0
	for line in (tostring(self.text or "") .. "\n"):gmatch("([^\n]*)\n") do
		lines = lines + math.max(1, math.ceil(#line * size * 0.5 / w))
	end
	return lines * size
end
function Methods.GetLineHeight(self) return (self.font and self.font[2]) or 12 end
function Methods.GetNumLines(self) return math.max(1, math.floor(self:GetStringHeight() / self:GetLineHeight())) end
function Methods.IsTruncated() return false end

-- Textures
function Methods.CreateTexture(self, name, layer, _template, sub)
	local t = NewObject("Texture", name, self)
	t.layer, t.sublayer = layer or "ARTWORK", sub or 0
	return t
end
function Methods.CreateMaskTexture(self, name, layer)
	local t = NewObject("MaskTexture", name, self)
	t.layer = layer or "ARTWORK"
	return t
end
function Methods.CreateFontString(self, name, layer, inherits)
	local fs = NewObject("FontString", name, self)
	fs.layer = layer or "ARTWORK"
	if type(inherits) == "table" then fs:SetFontObject(inherits) end
	table.insert(stub.strings, fs)
	return fs
end
function Methods.SetTexture(self, path) self.texture = path; self.color = nil; return true end
function Methods.GetTexture(self) return self.texture end
function Methods.SetAtlas(self, atlas) self.atlas = atlas; return true end
function Methods.GetAtlas(self) return self.atlas end
function Methods.SetColorTexture(self, r, g, b, a) self.color = { r, g, b, a or 1 }; self.texture = nil end
function Methods.SetVertexColor(self, r, g, b, a) self.vertexColor = { r, g, b, a or 1 } end
function Methods.GetVertexColor(self)
	local c = self.vertexColor or { 1, 1, 1, 1 }
	return c[1], c[2], c[3], c[4]
end
function Methods.SetTexCoord(self, ...) self.texCoord = { ... } end
function Methods.SetRotation(self, r) self.rotation = r end
function Methods.GetRotation(self) return self.rotation or 0 end
function Methods.SetDesaturated(self, v) self.desaturated = v and true or false end
function Methods.SetBlendMode(self, m) self.blend = m end
function Methods.AddMaskTexture(self, m) self.mask = m end

-- Backdrop (BackdropTemplate)
function Methods.SetBackdrop(self, t)
	assert(type(t) == "table" or t == nil, "SetBackdrop called with " .. tostring(t))
	self.backdrop = t
end
function Methods.SetBackdropColor(self, r, g, b, a) self.backdropColor = { r, g, b, a or 1 } end
function Methods.SetBackdropBorderColor(self, r, g, b, a) self.borderColor = { r, g, b, a or 1 } end

-- Buttons, checks, sliders, bars, edit boxes, scroll frames
function Methods.Enable(self) self.enabled = true end
function Methods.Disable(self) self.enabled = false end
function Methods.SetEnabled(self, v) self.enabled = v and true or false end
function Methods.IsEnabled(self) return self.enabled ~= false end
function Methods.SetChecked(self, v) self.checked = v and true or false end
function Methods.GetChecked(self) return self.checked == true end
function Methods.SetValue(self, v)
	self.value = v
	RunScript(self, "OnValueChanged", v, false)
end
function Methods.GetValue(self) return self.value or 0 end
function Methods.SetMinMaxValues(self, lo, hi) self.minValue, self.maxValue = lo, hi end
function Methods.GetMinMaxValues(self) return self.minValue or 0, self.maxValue or 1 end
function Methods.SetValueStep(self, s) self.valueStep = s end
function Methods.SetStatusBarTexture(self, t)
	self.barTexture = self.barTexture or NewObject("Texture", nil, self)
	self.barTexture.texture = t
end
function Methods.GetStatusBarTexture(self)
	self.barTexture = self.barTexture or NewObject("Texture", nil, self)
	return self.barTexture
end
function Methods.SetStatusBarColor(self, r, g, b, a) self.barColor = { r, g, b, a or 1 } end
function Methods.SetFocus(self) stub.focus = self end
function Methods.ClearFocus(self) if stub.focus == self then stub.focus = nil end end
function Methods.HasFocus(self) return stub.focus == self end
function Methods.Insert(self, t) self.text = (self.text or "") .. tostring(t) end
function Methods.SetVerticalScroll(self, v) self.scroll = v end
function Methods.GetVerticalScroll(self) return self.scroll or 0 end
function Methods.GetVerticalScrollRange(self) return self.scrollRange or 0 end
function Methods.SetScrollChild(self, c) self.scrollChild = c end
function Methods.GetScrollChild(self) return self.scrollChild end
function Methods.SetID(self, id) self.id = id end
function Methods.GetID(self) return self.id or 0 end
function Methods.SetAttribute(self, k, v) self.attributes = self.attributes or {}; self.attributes[k] = v end
function Methods.GetAttribute(self, k) return self.attributes and self.attributes[k] end

local function ButtonRegion(field)
	return function(self, tex)
		if type(tex) == "table" then
			self[field] = tex
		else
			self[field] = self[field] or NewObject("Texture", nil, self)
			self[field].texture = tex
		end
	end
end
Methods.SetNormalTexture = ButtonRegion("normalTexture")
Methods.SetPushedTexture = ButtonRegion("pushedTexture")
Methods.SetHighlightTexture = ButtonRegion("highlightTexture")
Methods.SetDisabledTexture = ButtonRegion("disabledTexture")
Methods.SetCheckedTexture = ButtonRegion("checkedTexture")
function Methods.GetNormalTexture(self) return self.normalTexture end
function Methods.GetHighlightTexture(self) return self.highlightTexture end
function Methods.GetPushedTexture(self) return self.pushedTexture end
function Methods.SetFontString(self, fs) self.fontString = fs end
function Methods.GetFontString(self)
	if not self.fontString then self.fontString = Methods.CreateFontString(self) end
	return self.fontString
end

-- Animation groups
local AnimMethods = {}
local AnimMT = {
	__index = function(_, key)
		local m = AnimMethods[key]
		if m then return m end
		if type(key) == "string" and key:match("^%u") then return noop end
	end,
}
function AnimMethods.SetScript(self, name, fn) self.scripts[name] = fn end
function AnimMethods.GetScript(self, name) return self.scripts[name] end
function AnimMethods.HookScript(self, name, fn) self.hooks[name] = self.hooks[name] or {}; table.insert(self.hooks[name], fn) end
function AnimMethods.CreateAnimation(self, kind, name)
	local a = setmetatable({ kind = kind, name = name, group = self, scripts = {}, hooks = {} }, AnimMT)
	table.insert(self.animations, a)
	return a
end
function AnimMethods.GetAnimations(self) return unpack(self.animations) end
function AnimMethods.Play(self)
	self.plays = (self.plays or 0) + 1
	RunScript(self, "OnPlay")
	self.playing = false
	RunScript(self, "OnFinished", false)
end
function AnimMethods.Restart(self) AnimMethods.Play(self) end
function AnimMethods.Stop(self)
	if self.playing then RunScript(self, "OnStop") end
	self.playing = false
end
function AnimMethods.IsPlaying(self) return self.playing == true end
function AnimMethods.GetParent(self) return self.owner end
function AnimMethods.GetRegionParent(self) return self.owner end
function Methods.CreateAnimationGroup(self, name)
	local g = setmetatable({ name = name, owner = self, animations = {}, scripts = {}, hooks = {} }, AnimMT)
	self.animGroups = self.animGroups or {}
	table.insert(self.animGroups, g)
	return g
end

---------------------------------------------------------------------------
-- CreateFrame and the event/timer loop
---------------------------------------------------------------------------

function CreateFrame(kind, name, parent, template, id)
	local f = NewObject(kind or "Frame", name, parent)
	f.template = template
	f.id = id
	if kind == "StatusBar" or kind == "Slider" then f.minValue, f.maxValue, f.value = 0, 1, 0 end
	table.insert(stub.frames, f)
	return f
end

function stub.frame(name)
	for _, f in ipairs(stub.frames) do
		if f.name == name then return f end
	end
end

function stub.fire(ev, ...)
	local list = {}
	for _, f in ipairs(stub.frames) do
		if f.events[ev] then list[#list + 1] = f end
	end
	for _, f in ipairs(list) do RunScript(f, "OnEvent", ev, ...) end
end

function stub.addonLoaded(name)
	stub.addonsLoaded[name] = true
	stub.fire("ADDON_LOADED", name)
end

function stub.login()
	stub.loggedIn = true
	stub.fire("PLAYER_LOGIN")
	stub.fire("PLAYER_ENTERING_WORLD", true, false)
	stub.runTimers()
end

local function runDue()
	local ran = true
	while ran do
		ran = false
		table.sort(stub.timers, function(a, b) return a.at < b.at end)
		local t = stub.timers[1]
		if t and t.at <= stub.now + 1e-9 then
			table.remove(stub.timers, 1)
			if not t.cancelled then t.fn(t.handle) end
			ran = true
		end
	end
end

function stub.runTimers() runDue() end

function stub.advance(seconds)
	local step = 0.05
	local remaining = seconds or 0
	repeat
		local dt = math.min(step, remaining)
		stub.now = stub.now + dt
		remaining = remaining - dt
		for _, f in ipairs(stub.frames) do
			if f.scripts.OnUpdate and Methods.IsVisible(f) then RunScript(f, "OnUpdate", dt) end
		end
		runDue()
	until remaining <= 1e-9
end

C_Timer = {}
function C_Timer.After(seconds, fn)
	table.insert(stub.timers, { at = stub.now + (seconds or 0), fn = function() fn() end })
end
function C_Timer.NewTimer(seconds, fn)
	local handle = { cancelled = false }
	local entry = { at = stub.now + (seconds or 0), handle = handle }
	entry.fn = function() fn(handle) end
	function handle:Cancel() self.cancelled = true; entry.cancelled = true end
	function handle:IsCancelled() return self.cancelled end
	table.insert(stub.timers, entry)
	return handle
end
function C_Timer.NewTicker(seconds, fn, iterations)
	local handle = { cancelled = false, remaining = iterations }
	local function schedule()
		local entry = { at = stub.now + seconds, handle = handle }
		entry.fn = function()
			if handle.cancelled then return end
			fn(handle)
			if handle.remaining then
				handle.remaining = handle.remaining - 1
				if handle.remaining <= 0 then return end
			end
			schedule()
		end
		handle.entry = entry
		table.insert(stub.timers, entry)
	end
	function handle:Cancel() self.cancelled = true; if self.entry then self.entry.cancelled = true end end
	function handle:IsCancelled() return self.cancelled end
	schedule()
	return handle
end

---------------------------------------------------------------------------
-- Client globals
---------------------------------------------------------------------------

local function FontObject(path, size, flags)
	local o = NewObject("Font", nil, nil)
	o.font = { path, size, flags or "" }
	return o
end

UIParent = CreateFrame("Frame", "UIParent")
UIParent.width, UIParent.height = 1920, 1080
WorldFrame = CreateFrame("Frame", "WorldFrame")
Minimap = CreateFrame("Minimap", "Minimap", UIParent)
Minimap.width, Minimap.height = 140, 140
function Minimap.GetZoom() return stub.minimapZoom or 0 end
function Minimap.GetZoomLevels() return 6 end
WorldMapFrame = CreateFrame("Frame", "WorldMapFrame", UIParent)
WorldMapFrame.shown = false
WorldMapFrame.dataProviders = {}
function WorldMapFrame.AddDataProvider(self, p) self.dataProviders[p] = true; if p.OnAdded then p:OnAdded(self) end end
function WorldMapFrame.RemoveDataProvider(self, p) self.dataProviders[p] = nil end
function WorldMapFrame.GetMapID() return stub.worldMapID end
WorldMapFrame.ScrollContainer = CreateFrame("Frame", nil, WorldMapFrame)
UIErrorsFrame = CreateFrame("Frame", "UIErrorsFrame", UIParent)
GameTooltip = CreateFrame("GameTooltip", "GameTooltip", UIParent)
GameTooltip.lines = {}
function GameTooltip.SetOwner(self, owner, anchor) self.owner, self.anchor = owner, anchor; self.lines = {} end
function GameTooltip.ClearLines(self) self.lines = {} end
function GameTooltip.AddLine(self, text) table.insert(self.lines, tostring(text)) end
function GameTooltip.AddDoubleLine(self, l, r) table.insert(self.lines, tostring(l) .. " | " .. tostring(r)) end
function GameTooltip.SetText(self, text) self.lines = { tostring(text) } end
DEFAULT_CHAT_FRAME = CreateFrame("Frame", "ChatFrame1", UIParent)
function DEFAULT_CHAT_FRAME.AddMessage(_, msg) table.insert(stub.messages, tostring(msg)) end
ColorPickerFrame = CreateFrame("Frame", "ColorPickerFrame", UIParent)
function ColorPickerFrame.SetupColorPickerAndShow(self, info) self.info = info; self:Show() end
function ColorPickerFrame.GetColorRGB() return 1, 1, 1 end

STANDARD_TEXT_FONT = "Fonts\\FRIZQT__.TTF"
UNIT_NAME_FONT = "Fonts\\FRIZQT__.TTF"
DAMAGE_TEXT_FONT = "Fonts\\FRIZQT__.TTF"
GameFontNormal = FontObject(STANDARD_TEXT_FONT, 12)
GameFontHighlight = FontObject(STANDARD_TEXT_FONT, 12)
GameFontNormalSmall = FontObject(STANDARD_TEXT_FONT, 10)
GameFontHighlightSmall = FontObject(STANDARD_TEXT_FONT, 10)
GameFontNormalLarge = FontObject(STANDARD_TEXT_FONT, 16)
GameFontDisable = FontObject(STANDARD_TEXT_FONT, 12)
ChatFontNormal = FontObject(STANDARD_TEXT_FONT, 14)
NumberFontNormal = FontObject(STANDARD_TEXT_FONT, 12, "OUTLINE")
function CreateFont(name)
	local o = FontObject(STANDARD_TEXT_FONT, 12)
	o.name = name
	if name then _G[name] = o end
	return o
end

SlashCmdList = {}
hash_SlashCmdList = {}
UISpecialFrames = {}
StaticPopupDialogs = {}
function StaticPopup_Show(which, ...) table.insert(stub.popups, { which = which, args = { ... } }) end
function StaticPopup_Hide() end
SOUNDKIT = setmetatable({}, { __index = function() return 1 end })
Enum = setmetatable({}, { __index = function(t, k) local v = {}; rawset(t, k, v); return v end })

RAID_CLASS_COLORS = {
	WARRIOR = { r = 0.78, g = 0.61, b = 0.43 }, PALADIN = { r = 0.96, g = 0.55, b = 0.73 },
	HUNTER = { r = 0.67, g = 0.83, b = 0.45 }, ROGUE = { r = 1.0, g = 0.96, b = 0.41 },
	PRIEST = { r = 1.0, g = 1.0, b = 1.0 }, SHAMAN = { r = 0.0, g = 0.44, b = 0.87 },
	MAGE = { r = 0.25, g = 0.78, b = 0.92 }, WARLOCK = { r = 0.53, g = 0.53, b = 0.93 },
	DRUID = { r = 1.0, g = 0.49, b = 0.04 },
}

Settings = {
	categories = {},
	RegisterCanvasLayoutCategory = function(frame, name)
		local c = { frame = frame, name = name, ID = name }
		function c.GetID() return name end
		table.insert(Settings.categories, c)
		return c
	end,
	RegisterAddOnCategory = function() end,
	OpenToCategory = function(id) stub.openedCategory = id end,
}

-- String, table and math helpers the client exposes as globals.
tinsert = table.insert
tremove = table.remove
sort = table.sort
function wipe(t) for k in pairs(t) do t[k] = nil end return t end
function tContains(t, v) for _, x in ipairs(t) do if x == v then return true end end return false end
function CopyTable(t)
	local c = {}
	for k, v in pairs(t) do c[k] = type(v) == "table" and CopyTable(v) or v end
	return c
end
format = string.format
strfind, strmatch, strsub, gsub = string.find, string.match, string.sub, string.gsub
strlower, strupper, strlen, strrep, strbyte, strchar = string.lower, string.upper, string.len, string.rep, string.byte, string.char
function strtrim(s, chars)
	chars = chars or " \t\r\n"
	local class = "[" .. chars:gsub("[%]%^%-]", "%%%0") .. "]"
	return (s:gsub("^" .. class .. "+", ""):gsub(class .. "+$", ""))
end
function strsplit(sep, s, limit)
	local out, from = {}, 1
	while true do
		if limit and #out == limit - 1 then break end
		local a, b = string.find(s, sep, from, true)
		if not a then break end
		table.insert(out, string.sub(s, from, a - 1))
		from = b + 1
	end
	table.insert(out, string.sub(s, from))
	return unpack(out)
end
function strjoin(sep, ...) return table.concat({ ... }, sep) end
floor, ceil, abs, min, max, sqrt = math.floor, math.ceil, math.abs, math.min, math.max, math.sqrt
random, fmod, exp, log = math.random, math.fmod, math.exp, math.log
local DEG = 180 / math.pi
function sin(d) return math.sin(d / DEG) end
function cos(d) return math.cos(d / DEG) end
function tan(d) return math.tan(d / DEG) end
function asin(v) return math.asin(v) * DEG end
function acos(v) return math.acos(v) * DEG end
function atan(v) return math.atan(v) * DEG end
function atan2(y, x) return math.atan2(y, x) * DEG end
function Clamp(v, lo, hi) if v < lo then return lo elseif v > hi then return hi end return v end
function Lerp(a, b, t) return a + (b - a) * t end

-- A 32-bit `bit` library (the client ships one in C; plain lua5.1 does not).
-- Four bits at a time through 16x16 tables, so the harness does not charge
-- addon code for a slow stand-in.
if not bit then
	local function tobits(n) n = n % 4294967296; return n end
	local function table16(f)
		local t = {}
		for x = 0, 15 do
			for y = 0, 15 do
				local r, p, a, b = 0, 1, x, y
				for _ = 1, 4 do
					local i, j = a % 2, b % 2
					if f(i, j) then r = r + p end
					a, b, p = (a - i) / 2, (b - j) / 2, p * 2
				end
				t[x * 16 + y] = r
			end
		end
		return t
	end
	local function op(t)
		return function(a, b)
			a, b = tobits(a), tobits(b)
			local r, p = 0, 1
			for _ = 1, 8 do
				local x, y = a % 16, b % 16
				r = r + t[x * 16 + y] * p
				a, b, p = (a - x) / 16, (b - y) / 16, p * 16
			end
			return r
		end
	end
	bit = {
		band = op(table16(function(x, y) return x == 1 and y == 1 end)),
		bor = op(table16(function(x, y) return x == 1 or y == 1 end)),
		bxor = op(table16(function(x, y) return x ~= y end)),
		bnot = function(a) return 4294967295 - tobits(a) end,
		lshift = function(a, n) return tobits(a * 2 ^ n) end,
		rshift = function(a, n) return math.floor(tobits(a) / 2 ^ n) end,
	}
end

function Mixin(obj, ...)
	for i = 1, select("#", ...) do
		for k, v in pairs((select(i, ...))) do obj[k] = v end
	end
	return obj
end
function CreateFromMixins(...) return Mixin({}, ...) end
BackdropTemplateMixin = {}
function CreateVector2D(x, y)
	local v = { x = x, y = y }
	function v.GetXY(self) return self.x, self.y end
	return v
end
function CreateColor(r, g, b, a)
	local c = { r = r, g = g, b = b, a = a or 1 }
	function c.GetRGB(self) return self.r, self.g, self.b end
	function c.GetRGBA(self) return self.r, self.g, self.b, self.a end
	return c
end

function hooksecurefunc(a, b, c)
	local tbl, name, fn = a, b, c
	if type(a) == "string" then tbl, name, fn = _G, a, b end
	local orig = tbl[name]
	tbl[name] = function(...)
		local r = { orig(...) }
		fn(...)
		return unpack(r)
	end
end
function securecall(fn, ...) if type(fn) == "string" then fn = _G[fn] end return fn(...) end
function geterrorhandler() return function(err) error(err, 0) end end
function seterrorhandler() end

function InCombatLockdown() return stub.inCombat end
function IsShiftKeyDown() return stub.keys.shift end
function IsControlKeyDown() return stub.keys.ctrl end
function IsAltKeyDown() return stub.keys.alt end
function IsModifierKeyDown() return stub.keys.shift or stub.keys.ctrl or stub.keys.alt end
-- Key bindings: a key holds one command; a command's keys come back sorted.
function SetBinding(key, command)
	stub.bindings[key] = command
	return true
end
function GetBindingAction(key) return stub.bindings[key] or "" end
function GetBindingKey(command)
	local keys = {}
	for k, c in pairs(stub.bindings) do if c == command then keys[#keys + 1] = k end end
	table.sort(keys)
	return unpack(keys)
end
function GetBindingText(key) return key end
function GetCurrentBindingSet() return 2 end
function SaveBindings() stub.bindingSaves = stub.bindingSaves + 1 end
function GetTime() return stub.now end
function GetServerTime() return stub.epoch + math.floor(stub.now) end
function time() return stub.epoch + math.floor(stub.now) end
-- The client's date([fmt [, time]]), in UTC rather than the machine's time
-- zone, so dates come out the same everywhere.
function date(fmt, t)
	fmt = fmt or "%c"
	if fmt:sub(1, 1) ~= "!" then fmt = "!" .. fmt end
	return os.date(fmt, t or (stub.epoch + math.floor(stub.now)))
end
function debugprofilestop() return stub.now * 1000 end
function GetFramerate() return 60 end
function GetBuildInfo() return "1.60.1", "70338", "Oct  1 2026", 16001 end
function GetLocale() return "enUS" end
function GetRealmName() return "Test Realm" end
function GetNormalizedRealmName() return "TestRealm" end
function UnitName(unit) if unit == "player" then return "Testchar" end end
function GetScreenWidth() return UIParent.width end
function GetScreenHeight() return UIParent.height end
function GetPhysicalScreenSize() return 1920, 1080 end
function GetCursorPosition() return stub.cursor[1], stub.cursor[2] end
function GetMouseFocus() return nil end
function GetMouseFoci() return {} end
function GetCVar(k) return stub.cvars[k] end
function GetCVarBool(k) local v = stub.cvars[k]; return v == "1" or v == true end
function SetCVar(k, v) stub.cvars[k] = tostring(v) end
function PlaySound(id) table.insert(stub.sounds, id) end
function PlaySoundFile(path) table.insert(stub.sounds, path); return true end
function StopSound() end
function ReloadUI() stub.reloaded = true end

C_AddOns = {}
-- stub.addons entry by index or name.
local function addonEntry(key)
	if type(key) == "number" then return stub.addons[key] end
	for _, a in ipairs(stub.addons) do
		if a.name == key then return a end
	end
end
function C_AddOns.IsAddOnLoaded(name)
	local a = addonEntry(name)
	return stub.addonsLoaded[name] == true or (a ~= nil and a.loaded == true)
end
function C_AddOns.LoadAddOn(name) return stub.addonsLoaded[name] == true, stub.addonsLoaded[name] and nil or "MISSING" end
function C_AddOns.GetAddOnMetadata(name, field)
	if type(name) == "number" then name = stub.addons[name] and stub.addons[name].name end
	local meta = stub.addonMeta[name]
	if meta and meta[field] ~= nil then return meta[field] end
	if field == "Version" then return "0.1.0-test" end
	local a = addonEntry(name)
	if field == "Title" and a then return a.title end
end
function C_AddOns.GetNumAddOns() return #stub.addons end
-- -> name, title, notes, loadable, reason, security, updateAvailable
function C_AddOns.GetAddOnInfo(key)
	local a = addonEntry(key)
	if not a then return nil, nil, nil, false, "MISSING", nil, false end
	return a.name, a.title or a.name, a.notes, a.reason == nil, a.reason, "INSECURE", false
end
function C_AddOns.GetAddOnEnableState(name)
	local a = addonEntry(name)
	if not a or a.enabled == false or a.reason == "DISABLED" then return 0 end
	return 2
end
function C_AddOns.EnableAddOn(name)
	table.insert(stub.enabledAddOns, name)
	local a = addonEntry(name)
	if a then
		a.enabled = true
		if a.reason == "DISABLED" then a.reason = nil end
	end
end
IsAddOnLoaded = C_AddOns.IsAddOnLoaded
GetAddOnMetadata = C_AddOns.GetAddOnMetadata

---------------------------------------------------------------------------
-- A fake EllesmereUI, matching its SKINNING_API.md (apiVersion 3)
---------------------------------------------------------------------------

function stub.withEllesmere()
	stub.skinned = {}
	stub.looksHandlers = {}
	stub.accent = stub.accent or { 0.05, 0.82, 0.62 }
	local S = { apiVersion = 3 }
	local function prim(kind)
		return function(frame, opts)
			if type(frame) ~= "table" then return end
			frame.euiSkin = kind
			frame.euiOpts = opts
			table.insert(stub.skinned, { frame = frame, kind = kind })
		end
	end
	for _, kind in ipairs({ "Shell", "Panel", "Inset", "FadeRegions", "FadeNineSlice", "Button", "WhiteButtonLabel",
		"StateButtonLabel", "EditBox", "Checkbox", "Dropdown", "ScrollBar", "Tab", "CloseButton", "PageButton",
		"SquareIcon", "SortHeaderBar", "ApplyBarFill" }) do
		S[kind] = prim(kind)
	end
	function S.SetTabSelection(tab, selected) tab.euiSelected = selected end
	function S.Font(fs, r, g, b) fs.font = { "Interface\\AddOns\\EllesmereUI\\media\\fonts\\Expressway.ttf", (fs.font and fs.font[2]) or 12, "" }; if r then fs.textColor = { r, g, b, 1 } end end
	function S.White(fs, r, g, b) fs.textColor = { r or 1, g or 1, b or 1, 1 } end
	function S.IsEnabled() return true end
	function S.GetStyle() return "eui" end
	function S.GetAccentColor() return stub.accent[1], stub.accent[2], stub.accent[3] end
	function S.GetPanelColor() return 0.07, 0.07, 0.08, 0.95 end
	function S.GetFont() return "Interface\\AddOns\\EllesmereUI\\media\\fonts\\Expressway.ttf", "" end
	function S.OnLooksChanged(fn) table.insert(stub.looksHandlers, fn) end
	EllesmereUI = {
		RegisterSkin = function(name, fn)
			stub.skinRegistered = name
			stub.skinCallback = fn
			if stub.loggedIn then fn(S) end
			return true
		end,
	}
	stub.addonsLoaded.EllesmereUI = true
	stub.euiS = S
	-- The real registry drains at PLAYER_LOGIN.
	local drain = CreateFrame("Frame")
	drain:RegisterEvent("PLAYER_LOGIN")
	drain:SetScript("OnEvent", function()
		if stub.skinCallback then stub.skinCallback(S) end
	end)
	return EllesmereUI
end

function stub.setAccent(r, g, b)
	stub.accent = { r, g, b }
	for _, fn in ipairs(stub.looksHandlers or {}) do fn() end
end

---------------------------------------------------------------------------
-- JSON for emit()
---------------------------------------------------------------------------

local escapes = { ['"'] = '\\"', ['\\'] = '\\\\', ['\b'] = '\\b', ['\f'] = '\\f', ['\n'] = '\\n', ['\r'] = '\\r', ['\t'] = '\\t' }
local function encode(v, seen, out)
	local t = type(v)
	if t == "nil" then out[#out + 1] = "null"
	elseif t == "boolean" then out[#out + 1] = v and "true" or "false"
	elseif t == "number" then
		if v ~= v or v == math.huge or v == -math.huge then out[#out + 1] = "null"
		elseif v == math.floor(v) and math.abs(v) < 2 ^ 53 then out[#out + 1] = string.format("%d", v)
		else out[#out + 1] = string.format("%.14g", v) end
	elseif t == "string" then
		out[#out + 1] = '"' .. v:gsub('[%z\1-\31"\\]', function(c) return escapes[c] or string.format("\\u%04x", c:byte()) end) .. '"'
	elseif t == "table" then
		if seen[v] then out[#out + 1] = '"<cycle>"'; return end
		seen[v] = true
		local n, count = #v, 0
		for _ in pairs(v) do count = count + 1 end
		if count > 0 and n == count then
			out[#out + 1] = "["
			for i = 1, n do
				if i > 1 then out[#out + 1] = "," end
				encode(v[i], seen, out)
			end
			out[#out + 1] = "]"
		else
			local keys = {}
			for k in pairs(v) do
				if type(k) == "string" or type(k) == "number" then keys[#keys + 1] = k end
			end
			table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
			out[#out + 1] = "{"
			for i, k in ipairs(keys) do
				if i > 1 then out[#out + 1] = "," end
				encode(type(k) == "number" and string.format("%.14g", k) or k, seen, out)
				out[#out + 1] = ":"
				encode(v[k], seen, out)
			end
			out[#out + 1] = "}"
		end
		seen[v] = nil
	else
		out[#out + 1] = '"<' .. t .. '>"'
	end
end

function stub.json(v)
	local out = {}
	encode(v, {}, out)
	return table.concat(out)
end

function emit(v) io.write("@@JSON ", stub.json(v), "\n") end

return stub
