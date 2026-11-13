-- The settings window's live previews: one component every page's preview
-- goes through (UI.Preview, Polestar_Options: loaded with the window).
--
-- The pinned preview. A page tab's `preview(host)` -> frame f is built the
-- first time the tab shows, into its own host in the shell's preview slot,
-- laid out across the main column and pinned there, the rows scrolling under
-- it (P.Place): at most MAX of the body's height, never cut off.
--
-- The band (P.Band(parent, opts) -> f): every Look tab's preview. The
-- element the tab sets and nothing else, at its real size (f:TrueScale()),
-- centred on the element on the window's plain ground, the band only as tall
-- as it: BAND_PAD over and under, [the picker], the element, [its states'
-- labels], [one hint line]. No chrome.
--   f:Content(width) -> w, h, place(left, top, k)[, labels]  the page's: the
--                  element's natural size, what puts it at (left, top) at
--                  scale k, and its labels ({ fontstring, x } at their
--                  centres, in its units)
--   f:Label(text)  a state's label (a 12px Label in textMuted, centred)
--   opts.picker    { choices, get, set }: a centred dropdown over the element
--                  (a tab that sets several elements: the one shown)
--   opts.play      fn: a small Play button beside the element's foot
--   opts.watch     setting path prefixes ("nav.", "toasts.rare."; "" every
--                  setting): a change of one lays the band out again at once
--                  while it shows, on its next show else; a theme change too
--   An element too wide or too tall for the band is placed at the k that
--   fits, every part alike, never over 1; its hint line says so ("Shown at
--   86% to fit"), else it is the hotspots' one-time hint, else there is none.
--   P.MapHero(f[, scene, mapLabel])  a sharp 1:1 crop of a zone's world map
--                  (P.SharpArt, P.InnerShade) and the game's minimap, side
--                  by side; P.HERO_SCENE the map pins' scene (Elwynn) in the
--                  map's pixels, P.HeroWorld(x, y) to world yards
--
-- A registered page's own frame (RegisterOptions' preview, f:Layout(width)
-- -> height) is laid out across the column, shown whole and smaller past
-- MAX (laid out again for the width that scale gives), and one 12px line
-- under it: its f.caption (a string or a function), the fit note added when
-- it shrank; without a caption the fit note, else the hotspots' one-time
-- hint while it stands.
--
-- Preview hotspots: a part of a preview that a click takes to its setting.
--   P.Hotspot(frame, region, key) (O.PreviewHotspot, host:Hotspot, or a
--   band's f:Hot): under the cursor a 1px accent outline goes round the part
--   and the tooltip names the setting; a click opens its row (O.Jump) and
--   lights it. The first preview with hotspots says so once ("Click a part
--   of the preview to find its settings", its hint line) until the first
--   click (PolestarDB.optionsPreviewHint).
-- The other way round: the pointer on a setting's row (its extras, its cog)
-- lights every hotspot of that setting and every region a page lights for it,
-- the accent outline and a soft accent wash, until it leaves (P.Focus ->
-- P.LightUp(owner, key)). On a band: f:Light(key, region, ...) lights
-- regions with key's row, no click; f:LightEdge an outline alone (a big
-- part, or one outside the band: the settings window's own sidebar or
-- header); f:LightRing an outline standing off a part drawn in the accent
-- itself; f:LightEach(key, fn[, ring]): fn() -> the parts to outline, found
-- as the row is hovered (the window's own, which come and go).
--
-- P.Snap(f, v): v on a whole physical pixel. P.TrueScale(f): the scale that
-- draws a part at its true size on screen (the game's UI scale), whatever
-- the settings window's Menu scale.

local ns = Polestar
local Theme, W = ns.Theme, ns.Widgets
local L = ns.L
local type, pairs, ipairs, pcall, floor, max, min = type, pairs, ipairs, pcall, math.floor, math.max, math.min

-- Core's UI table (Polestar/UI/UI.lua); a test that loads a page alone, with
-- the module it draws but not core's UI, gets one here.
local UI = ns.UI or {}
ns.UI = UI

local P = {}
UI.Preview = P

-- A pinned preview takes at most MAX of the body's height.
local MAX = 0.55
P.MAX = MAX

local function report(err)
	if geterrorhandler then geterrorhandler()(err) end
end

-- The old stage's backdrop pick (PolestarDB.optionsBackdrop) went with it:
-- cleared the first time the window opens, so no stale value lingers.
if type(PolestarDB) == "table" then PolestarDB.optionsBackdrop = nil end

---------------------------------------------------------------------------
-- Pixels and scale
---------------------------------------------------------------------------

-- Whether a setting's path is one of `watch`'s prefixes ("" every setting).
local function prefixMatch(watch, path)
	if type(path) ~= "string" or path == "" then return true end
	for _, p in ipairs(watch) do
		if p == "" or path == p or path:sub(1, #p) == p then return true end
		-- A whole section reset ("nav") reaches its prefix ("nav.").
		if p:sub(-1) == "." and path == p:sub(1, -2) then return true end
	end
	return false
end

-- v on a whole physical pixel of frame f.
function P.Snap(f, v)
	local px = Theme.Pixel(f)
	if not (px and px > 0) then return v end
	return floor(v / px + 0.5) * px
end

-- The scale that draws a part of preview f at its true size on screen (the
-- game's UI scale, whatever the settings window's Menu scale): against f's
-- parent, so a fit's own scale (a band's k, a shrunk frame's) still applies.
function P.TrueScale(f)
	local parent = f:GetParent()
	local u = UIParent and UIParent.GetEffectiveScale and UIParent:GetEffectiveScale() or 1
	local e = parent and parent.GetEffectiveScale and parent:GetEffectiveScale() or u
	if not (u and e and e > 0 and u > 0) then return 1 end
	return u / e
end

---------------------------------------------------------------------------
-- Hotspots
---------------------------------------------------------------------------

local hosts = setmetatable({}, { __mode = "k" })

local function hintDismissed() return ns.DB().optionsPreviewHint == true end

local function hostOf(f)
	while f do
		if rawget(f, "psIsHost") then return f end
		f = f:GetParent()
	end
end

-- A hotspot's or a light's outline: on under the cursor, or lit while the
-- pointer is on its setting's row (P.Focus), with a soft wash of the accent
-- (none on a light of a part outside the band: f:LightEdge).
local function hotspotEdge(b, on)
	local r, g, bb = Theme.Accent()
	local lit = rawget(b, "psLit")
	Theme.Border(b, r, g, bb, (on or lit) and 1 or 0)
	if rawget(b, "psEdgeOnly") then return end
	local wash = rawget(b, "Wash")
	if lit and not wash then
		wash = b:CreateTexture(nil, "BACKGROUND")
		wash:SetTexture(Theme.Media("white"))
		wash:SetAllPoints(b)
		b.Wash = wash
	end
	if wash then
		wash:SetVertexColor(r, g, bb, 0.16)
		wash:SetShown(lit and true or false)
	end
end

-- The host's lit parts by setting (P.Focus): every hotspot of a key and every
-- region a page lights for it (f:Light).
local function byKey(host, key)
	local map = rawget(host, "psByKey")
	if not map then
		map = {}
		host.psByKey = map
	end
	local list = map[key]
	if not list then
		list = {}
		map[key] = list
	end
	return list
end

local function controlFor(key)
	local O = UI.Options
	return O and O.ControlByKey and O.ControlByKey(key)
end

function P.Hotspot(frame, region, key)
	local b = CreateFrame("Button", nil, frame)
	b:SetAllPoints(region)
	b:SetFrameLevel(frame:GetFrameLevel() + 20)
	b.psKey, b.psPadSkip = key, true
	hotspotEdge(b, false)
	b:SetScript("OnEnter", function(self)
		hotspotEdge(self, true)
		local c = controlFor(self.psKey)
		local O = UI.Options
		if c then W.Tooltip(self, "ANCHOR_TOP", O.LabelOf(c), { L["Click to find its settings."] }) end
	end)
	b:SetScript("OnLeave", function(self)
		hotspotEdge(self, false)
		W.HideTooltip(self)
	end)
	b:SetScript("OnClick", function(self)
		if not hintDismissed() then
			ns.DB().optionsPreviewHint = true
			P.HintGone()
		end
		local c = controlFor(self.psKey)
		if c then UI.Options.Jump(c) end
	end)
	local host = hostOf(frame)
	if host then host.psHotspots = (host.psHotspots or 0) + 1 end
	local list = byKey(host or frame, key)
	list[#list + 1] = b
	return b
end

-- A band's hotspot, kept on it by key (f.Hots).
function P.Hot(f, region, key)
	if not region then return nil end
	local b = P.Hotspot(f, region, key)
	local hots = rawget(f, "Hots")
	if not hots then
		hots = {}
		f.Hots = hots
	end
	hots[key] = b
	return b
end

-- Whether region is a part of preview f.
local function within(region, f)
	local p = region.GetParent and region:GetParent()
	while p do
		if p == f then return true end
		p = p:GetParent()
	end
	return false
end

-- A light's frame, made the first time it lights: over its region, above
-- the preview's parts; for a part outside the preview (the settings window's
-- own: its sidebar, its header's band), above that part, an outline only.
-- A ring (rec.psOut) stands that far off the part all round.
local function lightFrame(rec)
	local region, owner = rec.psRegion, rec.psOwner
	local parent = owner
	if not within(region, owner) then
		parent = (region.IsObjectType and region:IsObjectType("Frame")) and region or region:GetParent()
	end
	local l = CreateFrame("Frame", nil, parent)
	local o = rec.psOut or 0
	l:SetPoint("TOPLEFT", region, "TOPLEFT", -o, o)
	l:SetPoint("BOTTOMRIGHT", region, "BOTTOMRIGHT", o, -o)
	-- Over the preview's parts; over a window part's children (its rows).
	l:SetFrameLevel(parent:GetFrameLevel() + (parent == owner and 18 or 60))
	l:EnableMouse(false)
	l.psKey, l.psEdgeOnly = rec.psKey, (rec.psEdgeOnly or parent ~= owner) or nil
	return l
end

-- Parts of a preview a setting changes, lit (outline and accent wash) while
-- the pointer is on that setting's row, without being a click target of
-- their own: f:Light(key, region, ...); f:LightEdge for an outline alone (a
-- big part, or one outside the preview); f:LightRing for a part drawn in the
-- accent itself, where an outline on it would not show: an outline RING px
-- off it all round. Each light's frame is made the first time it lights
-- (rec.Frame). -> the lights
local RING = 3
local function addLights(f, key, edge, out, ...)
	local list = byKey(hostOf(f) or f, key)
	local made = {}
	for i = 1, select("#", ...) do
		local region = select(i, ...)
		if region then
			local rec = { psRegion = region, psOwner = f, psKey = key, psEdgeOnly = edge or nil, psOut = out }
			list[#list + 1] = rec
			made[#made + 1] = rec
		end
	end
	return made
end
function P.Light(f, key, ...) return addLights(f, key, false, nil, ...) end
function P.LightEdge(f, key, ...) return addLights(f, key, true, nil, ...) end
function P.LightRing(f, key, ...) return addLights(f, key, true, RING, ...) end

-- Parts found as the row is hovered, each outlined alone: what comes and
-- goes with the page or tab on screen (the settings window's own controls
-- in the accent). f:LightEach(key, fn[, ring]): fn() -> a list of regions;
-- each one's light is made the first time it lights, a ring off it with
-- `ring` (as f:LightRing). -> the record
function P.LightEach(f, key, fn, ring)
	local list = byKey(hostOf(f) or f, key)
	local rec = { psEach = fn, psOwner = f, psKey = key, psOut = ring and RING or nil, psMade = setmetatable({}, { __mode = "k" }) }
	list[#list + 1] = rec
	return rec
end

-- Shown, and not faded out (a part a crop left out has its alpha at 0).
local function showing(region)
	if region.IsVisible and not region:IsVisible() then return false end
	local f = region
	while f do
		if f.GetAlpha and f:GetAlpha() <= 0.001 then return false end
		f = f.GetParent and f:GetParent()
	end
	return true
end

-- The frame that shows a hotspot or a light (a light's made now if need be).
local function shownBy(b, make)
	if not rawget(b, "psRegion") then return b end
	local l = rawget(b, "Frame")
	if not l and make then
		l = lightFrame(b)
		b.Frame = l
	end
	return l
end

-- Lights setting `key`'s parts on the preview `owner` holds (its host, or the
-- band itself), and puts out the ones lit before; nil puts them all out. A
-- light whose part is not showing (a surface a narrow page leaves out, a
-- tab's underline while another tab is open) stays dark. -> how many it lit
function P.LightUp(owner, key)
	if not owner then return 0 end
	for _, l in ipairs(rawget(owner, "psLitList") or {}) do
		l.psLit = nil
		hotspotEdge(l, false)
	end
	owner.psLitList = nil
	local list = key and rawget(owner, "psByKey") and owner.psByKey[key]
	if not list then return 0 end
	local lit = {}
	for _, b in ipairs(list) do
		local each = rawget(b, "psEach")
		if each then
			local ok, parts = pcall(each)
			if not ok then report(parts) end
			for _, region in ipairs(ok and type(parts) == "table" and parts or {}) do
				if showing(region) then
					local l = b.psMade[region]
					if not l then
						l = lightFrame({ psRegion = region, psOwner = b.psOwner, psKey = key, psEdgeOnly = true, psOut = b.psOut })
						b.psMade[region] = l
					end
					lit[#lit + 1] = l
				end
			end
		elseif not rawget(b, "psRegion") or showing(b.psRegion) then
			lit[#lit + 1] = shownBy(b, true)
		end
	end
	for _, l in ipairs(lit) do
		l.psLit = true
		hotspotEdge(l, false)
	end
	owner.psLitList = lit
	return #lit
end

---------------------------------------------------------------------------
-- The band
---------------------------------------------------------------------------

-- The band's geometry (UI units at scale 1): the room over and under its
-- content, the dropdown and its gap to the element, a label's or the hint's
-- gap and line, the gap between two states, the room kept each side of the
-- element before it is shrunk, Play's gap to the element (beside it, or
-- under it on a band too narrow) and its height.
local BAND_PAD, PICKER_W, PICKER_H, PICKER_GAP = 20, 220, 28, 14
local LINE_GAP, LINE_H, STATE_GAP, BAND_SIDE = 10, 15, 40, 24
local PLAY_GAP, PLAY_UNDER, PLAY_H = 16, 8, 22
P.BAND_PAD, P.PICKER_H, P.PICKER_GAP, P.LINE_GAP, P.LINE_H, P.STATE_GAP = BAND_PAD, PICKER_H, PICKER_GAP, LINE_GAP, LINE_H, STATE_GAP
P.PLAY_UNDER, P.PLAY_H = PLAY_UNDER, PLAY_H

local bands = setmetatable({}, { __mode = "k" })

-- The band laid out again where it is, the settings window's slot taking
-- its new height while it holds it; while hidden, on its next show (P.Again:
-- a page whose band shows another element now, its dropdown's pick changed
-- by a hovered row).
local function bandAgain(f)
	if not f:IsVisible() then
		f.psDirty = true
		return
	end
	if not f.psWidth then return end
	local h = f:Layout(f.psWidth, f.psRoom)
	local host, O = hostOf(f), UI.Options
	if host and O and O.frame then W.ShellPreview(O.frame, host, P.Snap(host, tonumber(h) or 0)) end
end
P.Again = bandAgain

-- Its dropdown: the window's dropdown box, centred, its menu the shared
-- popup menu. pick = { choices = { { value, label }, ... } or fn, get, set }
local function choicesOf(pick)
	local list = pick.choices
	if type(list) == "function" then list = list() end
	return list or {}
end

local function pickerLabel(f)
	local pick, cur = f.psPick, f.psPick.get()
	for _, c in ipairs(choicesOf(pick)) do
		if c.value == cur then return c.label end
	end
	return ""
end

local function newPicker(f)
	local b = CreateFrame("Button", nil, f)
	b:SetSize(PICKER_W, PICKER_H)
	Theme.Skin(b, "dropdown")
	b.Label = W.Text(b, "label", "text")
	b.Label:SetPoint("LEFT", b, "LEFT", 10, 0)
	b.Label:SetPoint("RIGHT", b, "RIGHT", -26, 0)
	b.Arrow = W.Tex(b, "ARTWORK", "chevron-down", "textDim")
	b.Arrow:SetSize(12, 12)
	b.Arrow:SetPoint("RIGHT", b, "RIGHT", -9, 0)
	b:SetScript("OnClick", function(self)
		if W.MenuShown(self) then return W.HideMenu() end
		local pick, items = f.psPick, {}
		local cur = pick.get()
		for i, c in ipairs(choicesOf(pick)) do
			items[i] = { text = c.label, checked = c.value == cur, onClick = function()
				pick.set(c.value)
				bandAgain(f)
			end }
		end
		W.ShowMenu(self, items, { minWidth = PICKER_W, point = "TOP", relPoint = "BOTTOM" })
	end)
	return b
end

-- The tab's preview as a band: the element the
-- tab sets, alone, at its real size (1:1 on the game's UI scale), centred on
-- the window's plain ground, the band only as tall as it. opts:
--   picker  { choices, get, set }: a centred dropdown over the element (a
--           tab that sets several elements: the one shown)
--   play    fn: a small Play button hanging right of the element, its foot
--           on the element's (under its right end on a band too narrow);
--           playLabel: its label when it plays something else ("In a fight")
--   watch   setting path prefixes ("toasts.", "nav."): a change repaints the
--           band at once while it shows, on its next show else; a theme
--           change too
-- The page sets f:Content(width) -> w, h, place(left, top, k), labels: its
-- element's natural size (band units at k = 1), what puts it there at scale
-- k (every part alike), and its states' labels ({ { fontString, centreX },
-- ... } at k = 1, or nil). Nothing to show (its module is not loaded): nil.
-- An element wider than the band (less BAND_SIDE a side) or taller than the
-- room the window gives it is placed at the k that fits, never over 1, and
-- the one hint line says so; else that line is the hotspots' one-time hint
-- while it stands, else there is none. f:Label(text): a state's label.
-- f:Layout(width, room) -> its height.
function P.Band(parent, opts)
	opts = opts or {}
	local f = CreateFrame("Frame", nil, parent)
	bands[f] = true
	f.Ground = W.Fill(f, "bg", "BACKGROUND", -8)
	if opts.picker then
		f.psPick = opts.picker
		f.Picker = newPicker(f)
	end
	f.Hint = W.Text(f, "label", "textMuted")
	f.Hint:SetJustifyH("CENTER")
	f.Hint:Hide()
	if opts.play then
		f.Play = W.Button(f, opts.playLabel or L["Play"], opts.play, { height = PLAY_H })
		f.Play:SetWidth(math.ceil(W.TextWidth(f.Play.Label)) + 32)
		f.Play:SetFrameLevel(f:GetFrameLevel() + 30)
	end
	f.psWatch = opts.watch
	function f:Hot(region, key) return P.Hot(self, region, key) end
	function f:Light(key, ...) return P.Light(self, key, ...) end
	function f:LightEdge(key, ...) return P.LightEdge(self, key, ...) end
	function f:LightRing(key, ...) return P.LightRing(self, key, ...) end
	function f:LightEach(key, fn, ring) return P.LightEach(self, key, fn, ring) end
	function f:TrueScale() return P.TrueScale(self) end
	function f:Label(text)
		local fs = W.Text(self, "label", "textMuted")
		fs:SetJustifyH("CENTER")
		fs:SetText(text)
		return fs
	end
	f:SetScript("OnShow", function(self)
		if self.psDirty and self.psWidth then self:Layout(self.psWidth, self.psRoom) end
	end)
	W.Painter(f.Ground, function()
		if f:IsVisible() and f.psWidth then f:Layout(f.psWidth, f.psRoom) else f.psDirty = true end
	end)

	function f:Layout(width, room)
		self.psDirty = nil
		self:SetWidth(width)
		self.psWidth, self.psRoom = width, room
		local pick, play = rawget(self, "Picker"), rawget(self, "Play")
		if pick then pick.Label:SetText(pickerLabel(self)) end
		local w, h, place, labels
		if type(self.Content) == "function" then
			local ok, a, b, c, d = pcall(self.Content, self, width)
			if ok then w, h, place, labels = a, b, c, d else report(a) end
		end
		local y = BAND_PAD
		if pick then
			pick:ClearAllPoints()
			pick:SetPoint("TOP", self, "TOPLEFT", P.Snap(self, width / 2), -y)
			y = y + PICKER_H + PICKER_GAP
		end
		local hint
		if not (w and h and place) then
			-- Its module is not loaded: the band says so.
			if play then play:Hide() end
			hint = L["Not loaded"]
		else
			-- The scale that fits: the band's width less its sides, the room
			-- the window gives it less the parts over and under the element
			-- (the hint line too, as it then says so).
			local below = (labels and (LINE_GAP + LINE_H) or 0) + BAND_PAD
			local k = min(1, (width - 2 * BAND_SIDE) / max(1, w))
			if room then k = min(k, (room - y - below) / max(1, h)) end
			if k < 0.995 and room then k = min(k, (room - y - below - LINE_GAP - LINE_H) / max(1, h)) end
			k = max(0.05, k)
			if k >= 0.995 then k = 1 end
			self.psFit = k
			local left = floor((width - w * k) / 2 + 0.5)
			place(left, y, k)
			local foot = y + h * k
			if play then
				-- Right of the element, its foot on the element's; on a band
				-- too narrow, under the element's right end.
				play:Show()
				play:ClearAllPoints()
				local pw = play:GetWidth()
				if left + w * k + PLAY_GAP + pw <= width - 16 then
					play:SetPoint("BOTTOMLEFT", self, "TOPLEFT", P.Snap(self, left + w * k + PLAY_GAP), -P.Snap(self, foot))
				else
					play:SetPoint("TOPRIGHT", self, "TOPLEFT", P.Snap(self, left + w * k), -P.Snap(self, foot + PLAY_UNDER))
					foot = foot + PLAY_UNDER + PLAY_H
				end
			end
			y = foot
			if labels then
				for _, l in ipairs(labels) do
					l[1]:ClearAllPoints()
					l[1]:SetPoint("TOP", self, "TOPLEFT", P.Snap(self, left + l[2] * k), -P.Snap(self, y + LINE_GAP))
				end
				y = y + LINE_GAP + LINE_H
			end
			if k < 1 then
				hint = string.format(L["Shown at %d%% to fit"], floor(k * 100 + 0.5))
			else
				local host = hostOf(self)
				if host and (host.psHotspots or 0) > 0 and not hintDismissed() then hint = L["Click a part of the preview to find its settings."] end
			end
		end
		self.Hint:SetShown(hint ~= nil)
		if hint then
			self.Hint:SetText(hint)
			self.Hint:ClearAllPoints()
			self.Hint:SetPoint("TOP", self, "TOPLEFT", P.Snap(self, width / 2), -P.Snap(self, y + LINE_GAP))
			y = y + LINE_GAP + LINE_H
		end
		y = y + BAND_PAD
		self.psHeight = y
		self:SetHeight(y)
		return y
	end
	return f
end

-- Whether frame f is a band (P.Band made it).
function P.IsBand(f) return f ~= nil and bands[f] == true end

-- The settings a band lays itself out again on (its opts.watch).
ns.On("SETTING_CHANGED", function(path)
	for f in pairs(bands) do
		local watch = f.psWatch
		if watch and prefixMatch(watch, path) then
			if f:IsVisible() and f.psWidth then f:Layout(f.psWidth, f.psRoom) else f.psDirty = true end
		end
	end
end)

-- The hotspots' hint gone for good: every band's hint line with it, and a
-- registered frame's line (the window lays the preview on screen out again).
function P.HintGone()
	for f in pairs(bands) do
		if not f:IsVisible() then
			f.psDirty = true
		elseif not hostOf(f) and f.psWidth then
			f:Layout(f.psWidth, f.psRoom)
		end
	end
	local O = UI.Options
	if O and O.Relayout then O.Relayout() end
end

---------------------------------------------------------------------------
-- The map hero (Map pins, Route lines)
---------------------------------------------------------------------------

-- One small scene on a real world map and a real minimap, side by side in a
-- band, each at its real size: the world map a 1:1 crop of the zone's own
-- map tiles (UI.ZoneArt: never upscaled; the client's art, none shipped), a
-- hairline round it and a soft inner shade so the marks come forward; the
-- minimap the game's own: its ring over the client's minimap tiles (by file
-- id, as ZoneArt ships only file ids) under a round mask, the player's arrow
-- in the middle. A scene, in its zone's map pixels (every zone map is
-- 1002 x 668): zone (its uiMap), frame (its map's edges in world yards,
-- data/forever/map-frames.json), crop { x, y, w, h }, player and ahead (the
-- way they face) { x, y }, tiles { { col, row, file id } } (its continent's
-- minimap tiles round the player, from the continent's WDT; placed from the
-- player's grid point, an ADT tile 533.33 yards). P.HERO_SCENE: Elwynn
-- Forest, the player on the road east of Goldshire (Map pins).
local MAP_W, MAP_H, ADT = 1002, 668, 1600 / 3
local HERO_SCENE = {
	zone = 1429, frame = { left = 1535.417, right = -1935.417, top = -7939.583, bottom = -10254.166 },
	crop = { 382, 377, 488, 186 }, -- whole map labels only: Goldshire at the left, Eastvale Logging Camp at the right
	player = { 530, 469 }, ahead = { 548, 471 },
	-- Azeroth's minimap tiles (its WDT, builds 70374 and 70425).
	tiles = { { 32, 49, 204494 }, { 32, 50, 204495 }, { 33, 49, 204534 }, { 33, 50, 204535 } },
	walk = { { 512, 468 }, { 548, 471 }, { 560, 492 }, { 565, 503 } },
	target = { 565, 503 }, area = 56,
	steps = { { 600, 466 }, { 656, 446 }, { 672, 500 } },
	card = { 605, 480 }, -- the preset cards' view, centred here
}
P.HERO_SCENE = HERO_SCENE
-- The minimap: 140 px, 466.67 yd across at its widest zoom (the default),
-- so a 533.33 yd tile is 160 px.
local MM, MM_YARDS, MM_BLOCK, MAP_GAP, SHADE = 140, 466.6667, 150, 48, 26
local MM_TILE = 160
local RING, RING_CX, RING_CY, RING_TOP = "Interface\\Minimap\\UI-Minimap-Border", 168.5, 106.5, 30
local MASK = "Interface\\CharacterFrame\\TempPortraitAlphaMask"
P.MM, P.MM_YARDS = MM, MM_YARDS

-- (mx, my) on the scene's zone map (HERO_SCENE's by default) -> its world
-- yards (x north, y west).
function P.HeroWorld(mx, my, scene)
	local Z = (scene or HERO_SCENE).frame
	return Z.top + my / MAP_H * (Z.bottom - Z.top), Z.left + mx / MAP_W * (Z.right - Z.left)
end

-- A gradient from alpha a0 at the texture's start to a1 at its end ("VERTICAL":
-- bottom to top, "HORIZONTAL": left to right).
local function gradient(t, dir, r, g, b, a0, a1)
	if t.SetGradient and CreateColor then
		t:SetGradient(dir, CreateColor(r, g, b, a0), CreateColor(r, g, b, a1))
	else
		t:SetVertexColor(r, g, b, (a0 + a1) / 2)
	end
end

-- A soft shade inside frame's four edges, `reach` px in, so marks near an
-- edge read. -> its frame
function P.InnerShade(frame, reach, strength)
	local over = CreateFrame("Frame", nil, frame)
	over:SetAllPoints(frame)
	local sides = {}
	for _, s in ipairs({ { "TOPLEFT", "TOPRIGHT", "h" }, { "BOTTOMLEFT", "BOTTOMRIGHT", "h" }, { "TOPLEFT", "BOTTOMLEFT", "w" }, { "TOPRIGHT", "BOTTOMRIGHT", "w" } }) do
		local t = over:CreateTexture(nil, "ARTWORK")
		t:SetTexture(Theme.Media("white"))
		t:SetPoint(s[1], over, s[1], 0, 0)
		t:SetPoint(s[2], over, s[2], 0, 0)
		if s[3] == "h" then t:SetHeight(reach) else t:SetWidth(reach) end
		sides[#sides + 1] = t
	end
	W.Painter(over, function()
		local r, g, b = Theme.Color("scrim")
		gradient(sides[1], "VERTICAL", r, g, b, 0, strength)
		gradient(sides[2], "VERTICAL", r, g, b, strength, 0)
		gradient(sides[3], "HORIZONTAL", r, g, b, strength, 0)
		gradient(sides[4], "HORIZONTAL", r, g, b, 0, strength)
	end)
	return over
end

-- A painting of a zone (HERO_SCENE's by default), w x h at its tiles' own
-- size (1:1), centred on (cx, cy) of its map, into parent; nil without
-- ZoneArt. ground: the token under it where the client has no art.
function P.SharpArt(parent, w, h, cx, cy, ground, zone)
	local ZA = UI.ZoneArt
	if not (ZA and ZA.Create) then return nil end
	local art = ZA.Create(parent, w, h, ground or "scrim")
	art:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 0)
	for _, k in ipairs({ "Fade", "Top", "Rule" }) do
		local r = rawget(art, k)
		if r then r:Hide() end
	end
	art.psZoom = 1 / max(w / MAP_W, h / MAP_H)
	art.psDesat, art.psFocusY, art.psW, art.psH = 0.1, h / 2, w, h
	local ok, err = pcall(ZA.Paint, art, zone or HERO_SCENE.zone, cx / MAP_W * 100, cy / MAP_H * 100, 1)
	if not ok then report(err) end
	return art
end

-- The hero of `scene` (HERO_SCENE by default) on band f: h.box (the two,
-- laid out at scale k by h.Place), h.Map (the world map, crop-sized) with
-- h.World (a route canvas, when RouteLines is loaded) and h.Layer (the
-- marks) over its art; h.Minimap (MM across) with h.MmCanvas and h.MmLayer;
-- h.Me, h.MmArrow (the player's arrows). mapLabel: what stands under the
-- world map instead of its label "World map" (Route lines: its rides'
-- legend). -> h; h.Size() -> w, h, labels (k = 1); h.Place(left, top, k).
function P.MapHero(f, scene, mapLabel)
	scene = scene or HERO_SCENE
	local h = {}
	local cx0, cy0, cw, ch = unpack(scene.crop)
	local box = CreateFrame("Frame", nil, f)
	box:SetSize(cw + MAP_GAP + MM_BLOCK, ch)
	h.box = box
	-- The world map.
	local map = CreateFrame("Frame", nil, box)
	map:SetSize(cw, ch)
	map:SetPoint("TOPLEFT", box, "TOPLEFT", 0, 0)
	if map.SetClipsChildren then map:SetClipsChildren(true) end
	h.Art = P.SharpArt(map, cw, ch, cx0 + cw / 2, cy0 + ch / 2, nil, scene.zone)
	if not h.Art then W.Fill(map, "panel", "BACKGROUND", -6) end
	local base = h.Art and h.Art.Over and h.Art.Over:GetFrameLevel() or map:GetFrameLevel() + 3
	P.InnerShade(map, SHADE, 0.6):SetFrameLevel(base + 1)
	local R = ns.RouteLines
	if R and R.NewCanvas then
		h.World = R.NewCanvas(CreateFrame("Frame", nil, map))
		h.World:SetAllPoints(map)
		h.World:SetFrameLevel(base + 2)
	end
	h.Layer = CreateFrame("Frame", nil, map)
	h.Layer:SetAllPoints(map)
	h.Layer:SetFrameLevel(base + 4)
	h.Me = h.Layer:CreateTexture(nil, "OVERLAY")
	h.Me:SetTexture("Interface\\WorldMap\\WorldMapArrow")
	local edge = CreateFrame("Frame", nil, map)
	edge:SetAllPoints(map)
	edge:SetFrameLevel(base + 8)
	W.Painter(edge, function(self)
		local r, g, b, a = Theme.Wash("border")
		Theme.Border(self, r, g, b, min(1, (a or 0.1) * 1.8))
	end)
	h.Map = map
	-- The minimap.
	local mm = CreateFrame("Frame", nil, box)
	mm:SetSize(MM, MM)
	mm:SetPoint("CENTER", box, "TOPLEFT", cw + MAP_GAP + MM_BLOCK / 2, -ch / 2)
	if mm.CreateMaskTexture then
		local mask = mm:CreateMaskTexture()
		mask:SetTexture(MASK, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
		mask:SetAllPoints(mm)
		h.Tiles = {}
		-- The player's grid point: a tile's column and row run west and south from the world's middle.
		local wx, wy = P.HeroWorld(scene.player[1], scene.player[2], scene)
		local gx, gy = 32 - wy / ADT, 32 - wx / ADT
		for i, t in ipairs(scene.tiles) do
			local tex = mm:CreateTexture(nil, "BACKGROUND")
			tex:SetTexture(t[3])
			tex:SetSize(MM_TILE, MM_TILE)
			tex:SetPoint("TOPLEFT", mm, "CENTER", (t[1] - gx) * MM_TILE, -(t[2] - gy) * MM_TILE)
			tex:AddMaskTexture(mask)
			h.Tiles[i] = tex
		end
		h.Mask = mask
	end
	h.MmArrow = mm:CreateTexture(nil, "ARTWORK")
	h.MmArrow:SetTexture("Interface\\Minimap\\MinimapArrow")
	h.MmArrow:SetSize(32, 32)
	h.MmArrow:SetPoint("CENTER", mm, "CENTER", 0, 0)
	if R and R.NewCanvas then
		h.MmCanvas = R.NewCanvas(CreateFrame("Frame", nil, mm))
		h.MmCanvas:SetAllPoints(mm)
		h.MmCanvas:SetFrameLevel(mm:GetFrameLevel() + 2)
	end
	h.MmLayer = CreateFrame("Frame", nil, mm)
	h.MmLayer:SetAllPoints(mm)
	h.MmLayer:SetFrameLevel(mm:GetFrameLevel() + 4)
	local ringFrame = CreateFrame("Frame", nil, mm)
	ringFrame:SetFrameLevel(mm:GetFrameLevel() + 8)
	ringFrame:SetAllPoints(mm)
	-- The game's ring, its zone-name bar (the texture's top) left out.
	h.Ring = ringFrame:CreateTexture(nil, "OVERLAY")
	h.Ring:SetTexture(RING)
	h.Ring:SetTexCoord(0, 1, RING_TOP / 256, 1)
	h.Ring:SetSize(256, 256 - RING_TOP)
	h.Ring:SetPoint("TOPLEFT", mm, "CENTER", -RING_CX, RING_CY - RING_TOP)
	h.Minimap = mm
	local labels = { mapLabel or f:Label(L["World map"]), f:Label(L["Minimap"]) }
	local facing = math.atan2(-(scene.ahead[1] - scene.player[1]), -(scene.ahead[2] - scene.player[2]))
	h.Facing = facing
	function h.Size()
		local t = f:TrueScale()
		h.Me:SetSize(32 * t, 32 * t)
		h.Me:ClearAllPoints()
		h.Me:SetPoint("CENTER", h.Layer, "TOPLEFT", scene.player[1] - cx0, -(scene.player[2] - cy0))
		if h.Me.SetRotation then h.Me:SetRotation(facing) end
		if h.MmArrow.SetRotation then h.MmArrow:SetRotation(facing) end
		return cw + MAP_GAP + MM_BLOCK, ch, { { labels[1], cw / 2 }, { labels[2], cw + MAP_GAP + MM_BLOCK / 2 } }
	end
	function h.Place(left, top, k)
		box:SetScale(k)
		box:ClearAllPoints()
		box:SetPoint("TOPLEFT", f, "TOPLEFT", P.Snap(f, left) / k, -P.Snap(f, top) / k)
	end
	return h
end

---------------------------------------------------------------------------
-- The pinned preview
---------------------------------------------------------------------------

-- A registered frame's one line: the gap over it, its height, the gap under.
local LINE_ROOM = LINE_GAP + LINE_H + LINE_GAP

-- The tab's host in the shell's slot, its preview built in it. -> host
-- (host.Frame: the preview, nil when it failed)
local function hostFor(win, view, t)
	local host = rawget(view, "PreviewHost")
	if host then return host end
	host = CreateFrame("Frame", nil, W.ShellPreviewSlot(win))
	if host.SetClipsChildren then host:SetClipsChildren(true) end
	host.psIsHost = true
	host.Hotspot = function(self, region, key) return P.Hotspot(self, region, key) end
	view.PreviewHost = host
	hosts[host] = true
	local ok, f = pcall(t.preview, host)
	if not ok then
		report(f)
		f = nil
	end
	host.Frame = f
	if f then
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", host, "TOPLEFT", 0, 0)
		-- A frame's own Hotspot method (a stub's frame answers every name).
		if rawget(f, "Hotspot") == nil then f.Hotspot = function(self, region, key) return P.Hotspot(self, region, key) end end
	end
	-- A registered frame's one line under it (a band has its own hint line).
	host.Line = W.Text(host, "label", "textMuted")
	host.Line:SetJustifyH("CENTER")
	host.Line:Hide()
	host:Hide()
	return host
end

-- Lay tab t's preview out across the main column (width) and pin it, at
-- most MAX of the body (`room`): a band as tall as its element and its
-- parts, the element fitted to that room; a registered page's frame laid out
-- for the width, shown whole at the scale that fits past it, its line under.
function P.Place(win, view, t, width, room)
	if not (t and t.preview) or view.empty then
		W.ShellPreview(win, nil)
		return
	end
	local host = hostFor(win, view, t)
	local f = host.Frame
	if not f then
		W.ShellPreview(win, nil)
		return
	end
	local maxH = max(1, floor(room * MAX))
	f:SetScale(1)
	if bands[f] then
		host.Line:Hide()
		local ok, h = pcall(f.Layout, f, width, maxH)
		if not ok then
			report(h)
			h = 0
		end
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", host, "TOPLEFT", 0, 0)
		f:Show()
		W.ShellPreview(win, host, P.Snap(host, tonumber(h) or 0))
		return
	end
	local function layout(w)
		local ok, h = pcall(f.Layout, f, w)
		if not ok then
			report(h)
			h = 0
		end
		return tonumber(h) or 0
	end
	local cap = f.caption
	if type(cap) == "function" then cap = cap() end
	if cap == "" then cap = nil end
	local hint = (host.psHotspots or 0) > 0 and not hintDismissed()
	local line = (cap or hint) and LINE_ROOM or 0
	local h, scale = layout(width), 1
	if h > maxH - line then
		-- Whole, smaller: laid out again for the width that scale gives, so
		-- its parts keep their own proportions; its line says by how much.
		line = LINE_ROOM
		scale = (maxH - line) / h
		h = layout(width / scale)
		scale = min(scale, (maxH - line) / max(1, h))
	end
	f:SetScale(scale)
	f:SetWidth(width / scale)
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", host, "TOPLEFT", 0, 0)
	f:Show()
	local shown = h * scale
	local text = cap
	if scale < 0.995 then
		local fit = string.format(L["Shown at %d%% to fit"], floor(scale * 100 + 0.5))
		text = cap and (cap .. "  \194\183  " .. fit) or fit
	elseif not cap and hint then
		text = L["Click a part of the preview to find its settings."]
	end
	host.Line:SetShown(text ~= nil)
	if text then
		host.Line:SetText(text)
		host.Line:ClearAllPoints()
		host.Line:SetPoint("TOP", host, "TOPLEFT", P.Snap(host, width / 2), -P.Snap(host, shown + LINE_GAP))
	end
	W.ShellPreview(win, host, P.Snap(host, shown + (text and LINE_ROOM or 0)))
end

-- The pointer on a row (key), or off it (nil): the preview on screen lights
-- the parts that setting changes (its hotspots and lights, P.LightUp) and
-- may show the part it draws (its frame's optional f:Focus(key)).
function P.Focus(view, key)
	local host = view and rawget(view, "PreviewHost")
	if not host then return end
	P.LightUp(host, host:IsShown() and key or nil)
	local f = host:IsShown() and host.Frame
	if not (key and f and type(f.Focus) == "function") then return end
	local ok, err = pcall(f.Focus, f, key)
	if not ok then report(err) end
end
