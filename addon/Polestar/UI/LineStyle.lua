-- The route lines' style: a small window the gear beside Options > Guide >
-- Arrow & routes > "Route lines" opens. The style (nav.lineStyle: a solid
-- line, Polestar's dots, or sparkles drifting toward the goal,
-- Maps/RouteSparkle.lua), the line's thickness (nav.lineWidth), the line's
-- and dots' colour (nav.dotColor), the sparkles' own settings, and the
-- minimap line's opacity (nav.minimapRouteAlpha) and the minimap size of the
-- style chosen (its own setting, RouteLines.SIZE_KEYS: the slider follows the
-- style), made by the options window's own controls
-- (Options.Control) in one column, with three sparkle presets. Every change
-- shows on the maps at once. The ✕ and Escape close it. Never taller than
-- the screen less MARGIN: the rows scroll under the header.
-- UI.ShowLineStyle(), or SHOW_LINE_STYLE.
--
-- Built on first use; colours are Theme tokens only.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, min, max = math.floor, math.min, math.max

local WIDTH = 420
local PAD = 24
local HEAD_H = 56

local function percent(v) return floor(v * 100 + 0.5) .. "%" end
local function px(v) return string.format(L["%d px"], floor(v + 0.5)) end
local function plain() return ns.Get("nav.lineStyle") ~= "sparkle" end
local function sparkles() return not plain() end
local function notLine() return ns.Get("nav.lineStyle") ~= "line" end
-- The minimap size setting of the style chosen.
local function sizeKey()
	local keys = ns.RouteLines and ns.RouteLines.SIZE_KEYS or {}
	return "nav." .. (keys[ns.Get("nav.lineStyle")] or keys.dots or "minimapDotsSize")
end

local SECTIONS = {
	{ name = L["Style"], controls = {
		{ kind = "dropdown", key = "nav.lineStyle", label = L["Line style"],
			help = L["How the route lines are drawn: one solid line, Polestar's dots, or sparkles that drift along the way to the goal (dots while Reduce motion is on)."],
			choices = ns.RouteLines and ns.RouteLines.STYLE_CHOICES or {} },
		{ kind = "slider", key = "nav.lineWidth", label = L["Line thickness"], min = 2, max = 8, step = 1, format = px, disabled = notLine,
			help = L["How thick the solid line is on the world map; the minimap's follows its size. Right-click to reset."] },
		{ kind = "dropdown", key = "nav.dotColor", label = L["Route colour"], disabled = sparkles,
			help = L["Route colours tint each leg by how you travel it. Cyan, magenta and white stand apart from the minimap's yellow herb and ore dots and its gold quest marks. Right-click to reset."],
			choices = {
				{ value = "route", label = L["Route colours"] }, { value = "cyan", label = L["Cyan"] },
				{ value = "magenta", label = L["Magenta"] }, { value = "white", label = L["White"] },
			} },
		{ kind = "slider", key = "nav.minimapRouteAlpha", label = L["Minimap opacity"], min = 0.2, max = 1, step = 0.05, format = percent,
			help = L["How strongly the route shows on the minimap, line, dots or sparkles; the world map keeps its own. Right-click to reset."] },
		{ kind = "slider", key = "nav.minimapRouteSize", label = L["Minimap size"], min = 0.5, max = 1.5, step = 0.05, format = percent,
			get = function() return ns.Get(sizeKey()) end, set = function(v) ns.Set(sizeKey(), v) end,
			help = L["The route's line, dots or sparkles on the minimap, each style its own size; the world map keeps its own. Right-click to reset."] },
	} },
	{ name = L["Sparkle"], presets = true, controls = {
		{ kind = "slider", key = "nav.sparkleIntensity", label = L["Intensity"], min = 0, max = 1, step = 0.05, format = percent,
			help = L["How bright each sparkle and its glow are."], disabled = plain },
		{ kind = "slider", key = "nav.sparkleDensity", label = L["Density"], min = 1, max = 10, step = 1, format = "%d",
			help = L["How close together the sparkles sit, the same at any zoom."], disabled = plain },
		{ kind = "slider", key = "nav.sparkleSubtlety", label = L["Subtlety"], min = 0, max = 1, step = 0.05, format = percent,
			help = L["Smaller, dimmer, calmer twinkles that drift less; no glow at 100%."], disabled = plain },
		{ kind = "slider", key = "nav.sparkleSize", label = L["Sparkle size"], min = 6, max = 28, step = 1, format = px,
			help = L["Each sparkle's size before subtlety."], disabled = plain },
		{ kind = "slider", key = "nav.sparkleFlow", label = L["Flow toward goal"], min = 0, max = 1, step = 0.05, format = percent,
			help = L["How fast the sparkles drift toward the goal; 0 holds them still."], disabled = plain },
		{ kind = "slider", key = "nav.sparkleMax", label = L["Most sparkles shown"], min = 10, max = 400, step = 10, format = "%d",
			help = L["A ceiling on each map, whatever the density."], disabled = plain },
		{ kind = "dropdown", key = "nav.sparkleColor", label = L["Sparkle colour"], disabled = plain,
			help = L["Loot gold is the colour of the game's own loot sparkle. Route colours tint each leg as the dots are."],
			choices = {
				{ value = "gold", label = L["Loot gold"] }, { value = "arcane", label = L["Arcane blue"] },
				{ value = "fel", label = L["Fel green"] }, { value = "rose", label = L["Rose"] },
				{ value = "white", label = L["Starlight"] }, { value = "route", label = L["Route colours"] },
			} },
		{ kind = "toggle", key = "nav.sparkleLater", label = L["Whole route"], disabled = plain,
			help = L["Sparkle the legs after this one too, fainter. Off: only the leg you are on."] },
	} },
}

local PRESETS = {
	{ key = "subtle", label = L["Subtle"] },
	{ key = "default", label = L["Default"] },
	{ key = "dazzling", label = L["Dazzling"] },
}

local F

-- The window is never taller than the screen less MARGIN: its rows scroll
-- under the header (a 768-high UI with the sparkle settings is 748 tall).
local MARGIN = 80

local function layout()
	local inner = WIDTH - PAD * 2
	local body = F.Body.Child
	local y = 4
	for _, s in ipairs(F.sections) do
		s.header:ClearAllPoints()
		s.header:SetPoint("TOPLEFT", body, "TOPLEFT", PAD, -y)
		s.header:SetWidth(inner)
		y = y + 44
		for _, w in ipairs(s.rows) do
			w:ClearAllPoints()
			w:SetPoint("TOPLEFT", body, "TOPLEFT", PAD, -y)
			y = y + W.LayoutRow(w, inner)
		end
		if s.presets then
			y = y + 12
			local bw = (inner - 16) / #s.presets
			for i, b in ipairs(s.presets) do
				b:ClearAllPoints()
				b:SetPoint("TOPLEFT", body, "TOPLEFT", PAD + (i - 1) * (bw + 8), -y)
				b:SetWidth(bw)
			end
			y = y + s.presets[1]:GetHeight()
		end
		y = y + 8
	end
	local content = y + PAD
	local room = max(200, (UIParent:GetHeight() or 768) - MARGIN - HEAD_H - 1)
	local view = min(content, room)
	body:SetWidth(WIDTH - 2)
	F:SetHeight(HEAD_H + 1 + view)
	W.SetScrollContent(F.Body, content, view)
end

local function refreshPresets()
	local off = plain()
	for _, s in ipairs(F.sections) do
		for _, b in ipairs(s.presets or {}) do
			b:SetAlpha(off and 0.45 or 1)
			if off then b:Disable() else b:Enable() end
		end
	end
end

local function build()
	F = CreateFrame("Frame", "PolestarLineStyle", ns.UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(WIDTH)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
	F:Hide()
	Theme.Skin(F, "window")

	local head = CreateFrame("Frame", nil, F)
	head:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	head:SetHeight(HEAD_H)
	head:EnableMouse(true)
	head:RegisterForDrag("LeftButton")
	head:SetScript("OnDragStart", function() F:StartMoving() end)
	head:SetScript("OnDragStop", function() F:StopMovingOrSizing() end)
	F.Head = head
	F.Band = Theme.Band(head, "BACKGROUND", -5)
	F.Band:SetAllPoints(head)
	F.Band:SetTexCoord(Theme.BandCoords(WIDTH - 2, HEAD_H))
	F.Close = W.IconButton(head, "close", 28, L["Close"], function() F:Hide() end, 14)
	F.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -14)
	F.Title = W.Text(head, "title", "text")
	F.Title:SetPoint("LEFT", head, "LEFT", PAD, 0)
	F.Title:SetPoint("RIGHT", F.Close, "LEFT", -8, 0)
	F.Title:SetJustifyH("LEFT")
	F.Title:SetWordWrap(false)
	F.Title:SetText(L["Route line style"])

	F.Body = W.Scroll(F)
	F.Body:SetPoint("TOPLEFT", head, "BOTTOMLEFT", 0, 0)
	F.Body:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -1, 1)
	local body = F.Body.Child

	F.sections, F.controls = {}, {}
	for _, spec in ipairs(SECTIONS) do
		local s = { header = W.SectionHeader(body), rows = {} }
		W.SetSection(s.header, spec.name)
		for _, c in ipairs(spec.controls) do
			if ns.GetDefault(c.key) ~= nil then
				local w = UI.Options.Control(body, c)
				s.rows[#s.rows + 1] = w
				F.controls[c.key] = w
			end
		end
		if spec.presets and ns.RouteLines and ns.RouteLines.ApplySparklePreset then
			s.presets = {}
			for i, p in ipairs(PRESETS) do
				s.presets[i] = W.Button(body, p.label, function() ns.RouteLines.ApplySparklePreset(p.key) end)
			end
		end
		F.sections[#F.sections + 1] = s
	end
	layout()
	refreshPresets()

	F:SetScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.FAST, "out") end)
	ns.CloseOnEscape("PolestarLineStyle")
	if ns.Gamepad and ns.Gamepad.Register then ns.Gamepad.Register(F, {}) end
end

-- Opens (or closes) the window; nothing without the route lines (no Nav).
function UI.ShowLineStyle()
	if ns.GetDefault("nav.lineStyle") == nil then return end
	if not F then build() end
	if F:IsShown() then
		F:Hide()
		return
	end
	layout()
	F:Show()
	F:Raise()
end

-- The window's widgets by settings key (tests): nil before it is built.
function UI.LineStyleControls()
	return F and F.controls
end

ns.On("SHOW_LINE_STYLE", function() UI.ShowLineStyle() end)
ns.On("SETTING_CHANGED", function(path)
	if F and (path == "nav.lineStyle" or path == "nav" or path == "" or path == nil) then
		refreshPresets()
		-- The size slider shows the chosen style's own size.
		local size = F.controls["nav.minimapRouteSize"]
		if size and size.Refresh then size:Refresh() end
	end
end)
W.OnFontChanged(function()
	if F and F:IsShown() then layout() end
end)
