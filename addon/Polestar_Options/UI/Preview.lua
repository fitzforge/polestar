-- The settings window's live previews: one component every page's preview
-- goes through (UI.Preview, Polestar_Options: loaded with the window).
--
-- The pinned preview. A page tab's `preview(host)` -> frame f with
-- f:Layout(width) -> height is built the first time the tab shows, into its
-- own host in the shell's preview slot, and laid out across the main column
-- (P.Place). It is never cut off: past its room (at most MAX of the body's
-- height) it is shown whole at the scale that fits, laid out for the width
-- that scale gives, its caption saying how much it shrank. Over it the
-- slot's chrome: "Preview" and the frame's caption (f.caption: a string or a
-- function) at the top left, the Live mark and the backdrop's chip at the
-- top right, and the hotspots' one-time hint in a foot of its own.
--
-- The stage (P.Stage(parent, opts) -> s): the ground every preview draws on.
--   opts.height    its height (s.psHeight); s:Layout(width) returns it unless
--                  the page's own Layout says otherwise
--   opts.backdrop  the page's backdrop when the player has not picked one:
--                  "world"  the zone you stand in (else your faction's first
--                           zone), painted from your own client's world map
--                           art (UI/ZoneArt.lua: Polestar ships none of it),
--                           dimmed, with a soft dark edge; the night sky where
--                           the client has no art for it
--                  "sky"    Polestar's night band and its stars over the
--                           deepest ground, a lift of the sky colour
--                  "ground" the window's deepest ground alone
--                  The chip at the top right cycles them for every preview
--                  (PolestarDB.optionsBackdrop: not a setting, it moves
--                  nothing in the game).
--   opts.watch     setting path prefixes ("nav.", "toasts.rare."; "" every
--                  setting): a change of one repaints the stage at once while
--                  it shows (s:Paint(), the page's own), on its next show else;
--                  a theme change too
--   s:Fit(frame, w, h, k)  frame (w x h in its own units, at its own scale
--                  k) as large as the stage holds below the chrome, never
--                  larger than k, centred on a whole pixel; it says so in the
--                  caption when it had to shrink it. -> the scale it got
--   s:Snap(v)      v on a whole physical pixel of the stage
--   s:Hot(region, key)  a click on region finds setting `key`'s row
--   s:Animate(fn)  fn(elapsed) every frame while the stage shows, until it
--                  returns false
--   s.Content      the frame the page's parts go on (above the backdrop)
--
-- Preview hotspots: a part of a preview that a click takes to its setting.
--   P.Hotspot(frame, region, key) (O.PreviewHotspot, host:Hotspot or
--   s:Hot while it is built): under the cursor a 1px accent outline goes
--   round the part and the tooltip names the setting; a click opens its row
--   (O.Jump) and lights it. The first preview with hotspots says so once
--   ("Click a part of the preview to find its settings", under its band)
--   until the first click (PolestarDB.optionsPreviewHint).

local ns = Polestar
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local type, pairs, ipairs, pcall, floor, max, min = type, pairs, ipairs, pcall, math.floor, math.max, math.min

local P = {}
UI.Preview = P

local MAX, HINT_FOOT, CHROME = 0.45, 24, 30
P.MAX, P.CHROME = MAX, CHROME

local function report(err)
	if geterrorhandler then geterrorhandler()(err) end
end

---------------------------------------------------------------------------
-- The backdrops
---------------------------------------------------------------------------

local BACKDROPS = { "world", "sky", "ground" }
local BACKDROP_LABEL = { world = L["World"], sky = L["Night sky"], ground = L["Plain"] }
-- A faction's first zone, where it has no zone of its own to show.
local HOME = { Alliance = 1429, Horde = 1411 }
local DIM = { 0.58, 0.58, 0.62 } -- the painting under a preview: dimmed, a little cool

local stages = setmetatable({}, { __mode = "k" })

local function picked()
	local v = ns.DB().optionsBackdrop
	for _, b in ipairs(BACKDROPS) do if v == b then return v end end
	return nil
end

-- The backdrop a stage shows: the player's pick, else its page's (a stage
-- whose scene is a painting of its own keeps its page's: opts.fixed).
local function backdropOf(s) return (not s.psFixed and picked()) or s.psBackdrop end
P.BackdropOf = backdropOf

-- The zone the world backdrop paints, and where in it: where you stand, else
-- your faction's first zone, its middle.
local function where()
	local C = ns.Compat
	if C and C.GetPlayerMapPosition then
		local ok, map, x, y = pcall(C.GetPlayerMapPosition)
		if ok and map then return map, x, y end
	end
	local faction = C and C.GetPlayerFaction and C.GetPlayerFaction()
	return HOME[faction or "Alliance"] or HOME.Alliance, 50, 45
end

-- The world backdrop's painting, made on first use: below the stage's own
-- level (the page's parts go above it), its card fade and rule left out.
local function worldArt(s)
	local a = rawget(s, "Art")
	if a then return a end
	local ZA = UI.ZoneArt
	if not (ZA and ZA.Create) then return nil end
	a = ZA.Create(s.Back, max(1, s.psWidth), s.psHeight, "scrim")
	a.psTint, a.psZoom = DIM, 1.35
	a.Fade:Hide()
	a.Top:Hide()
	a.Rule:Hide()
	-- Between the ground (s.Back) and the dark edges (s.Edges).
	local level = s.Back:GetFrameLevel() + 1
	a:SetFrameLevel(level)
	a.Canvas:SetFrameLevel(level)
	a.Over:SetFrameLevel(level)
	a:ClearAllPoints()
	a:SetPoint("TOPLEFT", s, "TOPLEFT", 0, 0)
	s.Art = a
	return a
end

-- Paints the stage's backdrop for its size (on a layout, a pick, a theme
-- change); again only when its kind, size or zone changed (force: anyway).
local function paintBackdrop(s, force)
	local kind = backdropOf(s)
	local w, h = max(1, floor((s.psWidth or 600) + 0.5)), s.psHeight
	local world = kind == "world"
	local map, x, y
	if world then map, x, y = where() end
	local sig = kind .. w .. "x" .. h .. ":" .. tostring(map) .. ":" .. floor(x or 0) .. ":" .. floor(y or 0)
	if sig == s.psBackdropSig and not force then return end
	s.psBackdropSig = sig
	local art = world and worldArt(s) or rawget(s, "Art")
	local painted = false
	if art then
		art:SetShown(world)
		if world then
			art:SetSize(w, h)
			art.psW, art.psH, art.psFocusY = w, h, h / 2
			local ok, done = pcall(UI.ZoneArt.Paint, art, map, x, y, 1)
			painted = ok and done or false
			if not ok then report(done) end
		end
	end
	-- The night sky: the band across the top, a lift of the sky colour
	-- behind the middle; under a painting that could not be drawn too.
	local sky = kind == "sky" or (world and not painted)
	s.Band:SetShown(sky and not (world and art))
	s.Lift:SetShown(sky)
	if sky then
		s.Band:SetHeight(min(h, Theme.BAND_H))
		s.Band:SetTexCoord(Theme.BandCoords(w, min(h, Theme.BAND_H)))
		s.Lift:ClearAllPoints()
		s.Lift:SetSize(w * 0.7, h * 1.6)
		s.Lift:SetPoint("CENTER", s, "TOPLEFT", w * 0.45, -h * 0.4)
	end
	-- The soft dark edge over a painting, so the parts read.
	s.EdgeTop:SetShown(world)
	s.EdgeBottom:SetShown(world)
	s.EdgeTop:SetHeight(floor(h * 0.42))
	s.EdgeBottom:SetHeight(floor(h * 0.42))
	s.psPainted = painted
end

local function paintEdges(s)
	local r, g, b = Theme.Color("scrim")
	for _, t in ipairs({ s.EdgeTop, s.EdgeBottom }) do
		if t.SetGradient and CreateColor then
			local top = t == s.EdgeTop
			t:SetGradient("VERTICAL", CreateColor(r, g, b, top and 0 or 0.7), CreateColor(r, g, b, top and 0.7 or 0))
		else
			t:SetVertexColor(r, g, b, 0.35)
		end
	end
	local sr, sg, sb = Theme.Color("sky")
	s.Lift:SetVertexColor(sr, sg, sb, 0.75)
	Theme.Border(s, Theme.Wash("divider"))
end

-- Every stage's backdrop again (the chip, a theme change).
local function repaintBackdrops()
	for s in pairs(stages) do
		if s:IsVisible() then paintBackdrop(s, true) else s.psBackdropDirty = true end
	end
end
P.RepaintBackdrops = repaintBackdrops

-- The player's next backdrop, for every preview.
function P.NextBackdrop()
	local cur = picked() or "world"
	local at = 1
	for i, b in ipairs(BACKDROPS) do if b == cur then at = i end end
	ns.DB().optionsBackdrop = BACKDROPS[at % #BACKDROPS + 1]
	repaintBackdrops()
	ns.Fire("OPTIONS_PREVIEW_BACKDROP")
	return ns.DB().optionsBackdrop
end

---------------------------------------------------------------------------
-- The stage
---------------------------------------------------------------------------

local function prefixMatch(watch, path)
	if type(path) ~= "string" or path == "" then return true end
	for _, p in ipairs(watch) do
		if p == "" or path == p or path:sub(1, #p) == p then return true end
		-- A whole section reset ("nav") reaches its prefix ("nav.").
		if p:sub(-1) == "." and path == p:sub(1, -2) then return true end
	end
	return false
end

local function repaint(s)
	s.psDirty = nil
	if type(s.Paint) == "function" then
		local ok, err = pcall(s.Paint, s)
		if not ok then report(err) end
	end
end

function P.Stage(parent, opts)
	opts = opts or {}
	local s = CreateFrame("Frame", nil, parent)
	s.psHeight = opts.height or 168
	s.psWidth = 600
	s.psBackdrop, s.psFixed = opts.backdrop or "world", opts.fixed and true or nil
	s:SetHeight(s.psHeight)
	if s.SetClipsChildren then s:SetClipsChildren(true) end
	-- The backdrop sits below the stage's own level, the parts above it.
	s:SetFrameLevel(parent:GetFrameLevel() + 4)
	s.Back = CreateFrame("Frame", nil, s)
	s.Back:SetAllPoints(s)
	s.Back:SetFrameLevel(max(0, s:GetFrameLevel() - 3))
	W.Fill(s.Back, "scrim", "BACKGROUND", -8)
	s.Lift = W.Tex(s.Back, "BACKGROUND", "glow", nil, -7)
	s.Band = Theme.Band(s.Back, "BACKGROUND", -6)
	s.Band:SetPoint("TOPLEFT", s, "TOPLEFT", 0, 0)
	s.Band:SetPoint("TOPRIGHT", s, "TOPRIGHT", 0, 0)
	s.Band:SetHeight(Theme.BAND_H)
	s.Edges = CreateFrame("Frame", nil, s)
	s.Edges:SetAllPoints(s)
	s.Edges:SetFrameLevel(max(0, s:GetFrameLevel() - 1))
	s.EdgeTop = s.Edges:CreateTexture(nil, "ARTWORK")
	s.EdgeTop:SetTexture(Theme.Media("white"))
	s.EdgeTop:SetPoint("TOPLEFT", s, "TOPLEFT", 0, 0)
	s.EdgeTop:SetPoint("TOPRIGHT", s, "TOPRIGHT", 0, 0)
	s.EdgeBottom = s.Edges:CreateTexture(nil, "ARTWORK")
	s.EdgeBottom:SetTexture(Theme.Media("white"))
	s.EdgeBottom:SetPoint("BOTTOMLEFT", s, "BOTTOMLEFT", 0, 0)
	s.EdgeBottom:SetPoint("BOTTOMRIGHT", s, "BOTTOMRIGHT", 0, 0)
	W.Painter(s, paintEdges)
	-- The page's parts.
	s.Content = CreateFrame("Frame", nil, s)
	s.Content:SetAllPoints(s)
	s.Content:SetFrameLevel(s:GetFrameLevel() + 1)
	s.caption = function() return s.psNote end
	s.psWatch = opts.watch
	stages[s] = true
	s:SetScript("OnShow", function(self)
		if self.psBackdropDirty then
			self.psBackdropDirty = nil
			paintBackdrop(self, true)
		end
		if self.psDirty then repaint(self) end
		if self.psAnimate then self:SetScript("OnUpdate", self.psTick) end
	end)
	s:SetScript("OnHide", function(self) self:SetScript("OnUpdate", nil) end)
	-- The page's own layout over the stage's; the stage keeps the backdrop
	-- across the width it is given.
	function s:Layout(width)
		self:SetWidth(width)
		self.psWidth = width
		paintBackdrop(self)
		local h = self.psHeight
		if type(self.Arrange) == "function" then
			local ok, got = pcall(self.Arrange, self, width)
			if not ok then report(got) elseif tonumber(got) then h = tonumber(got) end
		end
		if self.psDirty then repaint(self) end
		return h
	end
	paintBackdrop(s)
	return s
end

-- The settings and theme changes a stage repaints on (its opts.watch).
ns.On("SETTING_CHANGED", function(path)
	for s in pairs(stages) do
		local watch = s.psWatch
		if watch and prefixMatch(watch, path) then
			if s:IsVisible() then repaint(s) else s.psDirty = true end
		end
	end
end)
Theme.OnChanged(function()
	for s in pairs(stages) do
		if s:IsVisible() then
			paintBackdrop(s, true)
			if s.psWatch then repaint(s) end
		else
			s.psBackdropDirty = true
			if s.psWatch then s.psDirty = true end
		end
	end
end)

-- v on a whole physical pixel of frame f (the stage).
function P.Snap(f, v)
	local px = Theme.Pixel(f)
	if not (px and px > 0) then return v end
	return floor(v / px + 0.5) * px
end

-- frame (w x h in its own units, at scale k) as large as the stage holds
-- below the chrome, never larger than k, centred on a whole pixel. opts:
-- pad (each side, 32), bottom (room kept under it, 12: a Play button's
-- more), anchor (fn(frame, point, rel, relPoint, x, y), as Anim.Anchor, so
-- an entrance slides from its place). -> the scale it got
function P.Fit(s, frame, w, h, k, opts)
	opts = opts or {}
	local pad, bottom = opts.pad or 32, opts.bottom or 12
	k = k or 1
	local sw = s.psWidth or 600
	local availW, availH = sw - 2 * pad, s.psHeight - CHROME - bottom - 8
	local fit = min(1, availW / max(1, w * k), availH / max(1, h * k))
	local scale = k * fit
	frame.psFit = fit
	frame:SetScale(scale)
	-- Its top-left on a whole pixel at its scale, centred in the room.
	local cx, cy = sw / 2, -(CHROME + (s.psHeight - CHROME - bottom) / 2)
	local ox = P.Snap(frame, cx / scale - w / 2)
	local oy = P.Snap(frame, cy / scale + h / 2)
	if opts.anchor then
		opts.anchor(frame, "TOPLEFT", s, "TOPLEFT", ox, oy)
	else
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", s, "TOPLEFT", ox, oy)
	end
	s.psNote = fit < 0.995 and string.format(L["Shown at %d%% to fit"], floor(fit * 100 + 0.5)) or ""
	return scale
end

function P.Animate(s, fn)
	s.psAnimate = fn
	s.psTick = function(self, elapsed)
		local ok, more = pcall(fn, elapsed)
		if not ok then report(more) end
		if not ok or more == false then
			self.psAnimate = nil
			self:SetScript("OnUpdate", nil)
		end
	end
	if s:IsVisible() then s:SetScript("OnUpdate", s.psTick) end
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

local function hotspotEdge(b, on)
	local r, g, bb = Theme.Accent()
	Theme.Border(b, r, g, bb, on and 1 or 0)
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
			for h in pairs(hosts) do
				h.Hint:Hide()
				h.Foot:Hide()
			end
		end
		local c = controlFor(self.psKey)
		if c then UI.Options.Jump(c) end
	end)
	local host = hostOf(frame)
	if host then host.psHotspots = (host.psHotspots or 0) + 1 end
	return b
end

-- A stage's hotspot, kept on it by key (s.Hots).
function P.Hot(s, region, key)
	if not region then return nil end
	local b = P.Hotspot(s, region, key)
	local hots = rawget(s, "Hots")
	if not hots then
		hots = {}
		s.Hots = hots
	end
	hots[key] = b
	return b
end

---------------------------------------------------------------------------
-- The pinned preview
---------------------------------------------------------------------------

local function backdropText()
	return BACKDROP_LABEL[picked() or "world"] or ""
end

local function paintChip(host)
	host.Backdrop.Label:SetText(backdropText())
	host.Backdrop:SetWidth(math.ceil(W.TextWidth(host.Backdrop.Label)) + 12 + 14)
end

-- The tab's host in the shell's slot, its preview built in it, and the
-- chrome over it. -> host (host.Frame: the preview, nil when it failed)
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
		if f.Hotspot == nil then f.Hotspot = function(self, region, key) return P.Hotspot(self, region, key) end end
	end
	-- The chrome, over the preview.
	local chrome = CreateFrame("Frame", nil, host)
	chrome:SetAllPoints(host)
	chrome:SetFrameLevel(host:GetFrameLevel() + 30)
	host.Label = W.Text(chrome, "caption", "text")
	host.Label:SetText(L["Preview"])
	host.Label:SetPoint("TOPLEFT", chrome, "TOPLEFT", 16, -12)
	host.Caption = W.Text(chrome, "small", "textDim")
	host.Caption:SetPoint("LEFT", host.Label, "RIGHT", 8, 0)
	-- The backdrop's chip: the ground every preview draws on, a click the next one.
	local chip = CreateFrame("Button", nil, chrome)
	chip:SetHeight(18)
	chip:SetPoint("TOPRIGHT", chrome, "TOPRIGHT", -12, -9)
	W.Fill(chip, "panel", "BACKGROUND", -6)
	W.Painter(chip, function(self) Theme.Border(self, Theme.Wash("border")) end)
	chip.Icon = W.Tex(chip, "ARTWORK", "layers", "textDim")
	chip.Icon:SetSize(10, 10)
	chip.Icon:SetPoint("LEFT", chip, "LEFT", 6, 0)
	chip.Label = W.Text(chip, "small", "textDim")
	chip.Label:SetPoint("LEFT", chip.Icon, "RIGHT", 4, 0)
	chip:SetScript("OnClick", function(self)
		P.NextBackdrop()
		for h in pairs(hosts) do paintChip(h) end
		self:GetScript("OnEnter")(self)
	end)
	chip:SetScript("OnEnter", function(self)
		W.Tooltip(self, "ANCHOR_TOP", L["Backdrop"], { string.format(L["Previews are drawn over %s. Click for the next backdrop."], backdropText()) })
	end)
	chip:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	host.Backdrop = chip
	paintChip(host)
	host.Live = W.Text(chrome, "small", "textMuted")
	host.Live:SetText(L["Live"])
	host.Live:SetPoint("RIGHT", chip, "LEFT", -12, 0)
	local dot = W.Tex(chrome, "ARTWORK", "circle", "success")
	dot:SetSize(6, 6)
	dot:SetPoint("RIGHT", host.Live, "LEFT", -6, 0)
	-- The hotspots' one-time hint: a foot row of its own under the preview,
	-- on the band's ground, clear of the preview's content.
	host.Foot = W.Tex(chrome, "BACKGROUND", nil, "bg")
	host.Foot:SetPoint("BOTTOMLEFT", chrome, "BOTTOMLEFT", 0, 0)
	host.Foot:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", 0, 0)
	host.Foot:SetHeight(HINT_FOOT)
	host.Hint = W.Text(chrome, "small", "textMuted")
	host.Hint:SetText(L["Click a part of the preview to find its settings."])
	host.Hint:SetPoint("LEFT", host.Foot, "LEFT", 16, 0)
	host.Hint:Hide()
	host.Foot:Hide()
	host:Hide()
	return host
end
P.HostFor = hostFor

-- Lay tab t's preview out across the main column (width) and pin it, at most
-- `room` tall: past that it is shown whole at the scale that fits.
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
	local function layout(w)
		local ok, h = pcall(f.Layout, f, w)
		if not ok then
			report(h)
			h = 0
		end
		-- A stage whose page lays it out itself still has its backdrop
		-- across the width it was given.
		if stages[f] then
			f.psWidth = w
			paintBackdrop(f)
		end
		return tonumber(h) or 0
	end
	f:SetScale(1)
	local h = layout(width)
	local maxH = max(1, floor(room * MAX))
	local scale = 1
	if h > maxH then
		-- Whole, smaller: laid out again for the width that scale gives, so
		-- its parts keep their own proportions.
		scale = maxH / h
		h = layout(width / scale)
		scale = min(scale, maxH / max(1, h))
	end
	f:SetScale(scale)
	f:SetWidth(width / scale)
	f:Show()
	paintChip(host)
	local cap = f.caption
	if type(cap) == "function" then cap = cap() end
	if scale < 0.995 then
		local shrunk = string.format(L["Shown at %d%% to fit"], floor(scale * 100 + 0.5))
		cap = (cap and cap ~= "") and (cap .. "  \194\183  " .. shrunk) or shrunk
	end
	host.Caption:SetText(cap or "")
	local hint = (host.psHotspots or 0) > 0 and not hintDismissed()
	host.Hint:SetShown(hint)
	host.Foot:SetShown(hint)
	W.ShellPreview(win, host, P.Snap(host, h * scale) + (hint and HINT_FOOT or 0))
end

-- The pointer on a row: the preview on screen may show the part that setting
-- draws (its frame's optional f:Focus(key)).
function P.Focus(view, key)
	local host = view and rawget(view, "PreviewHost")
	local f = host and host:IsShown() and host.Frame
	if not (key and f and type(f.Focus) == "function") then return end
	local ok, err = pcall(f.Focus, f, key)
	if not ok then report(err) end
end
