local _, Free = ...
local ps = Polestar
local Guide = ps and ps.UI and ps.UI.GuideFrame
if not Guide then return end

local Theme, W = ps.Theme, ps.Widgets
local Appearance = { Guide = Guide }
Free.Appearance = Appearance

local function ground(frame)
	frame.psBare = Guide.Transparent()
	frame.psNoBorder = not Guide.On("border") or nil
	local r, g, b = Guide.Rgb("bgColor")
	frame.psBgColor = r and { r, g, b } or nil
	frame.psBgAlpha = tonumber(ps.Get("guideWindow.bgOpacity"))
end

function Appearance.Attach(frame, header)
	frame.psGuide = true
	frame.psGuideWindow = header and true or nil
	frame.lookTexts = {}
	frame.lookHeader = header
	if header then
		frame.lookBand = Theme.Band(header)
		frame.lookBand:SetAllPoints(header)
	end
	ground(frame)
	Theme.Skin(frame, "window")
end

function Appearance.Text(frame, parent, role, color, sizeKey)
	local fs = W.Text(parent, role, color)
	frame.lookTexts[fs] = sizeKey or false
	Theme.SetFontScale(fs, sizeKey and Guide.Num(sizeKey))
	Theme.SetOutline(fs, frame.psBare and Guide.Outline())
	return fs
end

function Appearance.SetText(fs, value)
	if fs:GetText() == value then return end
	fs:SetText(value)
	Guide.ShadeText(fs, Guide.SoftShade())
end

function Appearance.ButtonText(button, value)
	W.SetButtonText(button, value)
	Guide.ShadeText(button.Label, Guide.SoftShade())
end

function Appearance.Apply(frame)
	ground(frame)
	Theme.Repaint(frame)
	if frame.lookBand then
		frame.lookBand:SetShown(not frame.psBare and Theme.SkinKey() == "polestar")
		if Theme.KitHeader then Theme.KitHeader(frame.lookHeader, not frame.psBare) end
	end
	local veil = Guide.Backing()
	if veil and not frame.lookVeil then
		frame.lookVeil = Theme.Scrim(frame, Guide.VEIL_FEATHER)
		frame.lookVeil:SetAllPoints(frame)
	end
	if frame.lookVeil then
		frame.lookVeil:SetShown(veil ~= nil)
		if veil then Theme.PaintScrim(frame.lookVeil, veil) end
	end
	local outline, soft = frame.psBare and Guide.Outline(), Guide.SoftShade()
	for fs, sizeKey in pairs(frame.lookTexts) do
		Theme.SetFontScale(fs, sizeKey and Guide.Num(sizeKey))
		Theme.SetOutline(fs, outline)
		Guide.ShadeText(fs, soft)
	end
end

function Appearance.Watch(update)
	Theme.OnChanged(update, true)
	ps.On("SETTING_CHANGED", function(path)
		if path == "" or path == "ui" or path == "ui.style" or path == "ui.backing"
			or path == "ui.scale" or path == "ui.bgOpacity" or path == "guideWindow" or path:sub(1, 12) == "guideWindow." then
			-- Polestar coalesces live palette sliders. Apply guide-specific
			-- colors when its setter fires, too.
			update()
		end
	end)
end
