-- The guide window's "Play next" card on a finished guide's complete page
-- (UI/GuideFrame.lua, setEmpty): the next guide's zone art, its name and
-- levels, why it is next, its steps and one Start button (Engine.StartNext),
-- with a quiet "Other guides" link under it that opens the guide menu. The
-- page paints it with GF.PlayNext.Paint(nextGuide, fromId) and clears it with
-- GF.PlayNext.Hide(); the layout asks GF.PlayNext.Layout(width) for its height.

local ADDON, ns = ...
ns.UI.GuideFrame.Part(function(GF)
	local UI, Theme, W, L = ns.UI, ns.Theme, ns.Widgets, ns.L
	local max, floor = math.max, math.floor

	local ART_W, CARD_H, INSET, START_W, START_H = 96, 104, 12, 72, 22 -- art near square, not a tall strip
	local PN = {}
	GF.PlayNext = PN

	local empty
	local card, other, skips
	GF.Bind(function(p)
		empty = p.empty
		if card or not empty then return end
		card = CreateFrame("Frame", nil, empty)
		card:SetHeight(CARD_H)
		Theme.Skin(card, "panel")
		-- Its zone art is made on the first Paint: a window that never ends a
		-- guide (a settings preview's copy) carries no zone painting.
		-- The transparent style's ground (PN.Style): a light scrim over the world.
		card.Scrim = card:CreateTexture(nil, "BACKGROUND")
		card.Scrim:SetTexture(Theme.Media("white"))
		card.Scrim:SetAllPoints(card)
		card.Scrim:Hide()
		-- Strings from GF.Text: outlined while the window is transparent.
		local T = GF.Text or W.Text
		card.Eyebrow = T(card, "label", "accent")
		card.Eyebrow:SetText(L["Play next"])
		card.Title = T(card, "heading", "text")
		card.Why = T(card, "note", "textDim")
		card.Why:SetWordWrap(true)
		if card.Why.SetMaxLines then card.Why:SetMaxLines(2) end
		card.Steps = T(card, "small", "textMuted")
		card.Start = W.Button(card, L["Start"], function(b) if b.psAction then b.psAction() end end, { primary = true, width = START_W, height = START_H })
		card.Start:SetWidth(START_W)
		card.Start.psDefault = true -- a gamepad starts here (UI/GamepadGuide.lua)
		card:Hide()
		other = W.Link(empty, L["Other guides"], function(b) if b.psAction then b.psAction() end end, { role = "note" })
		other.psTip = L["Open the guide menu"]
		other.psAction = function() UI.ShowPicker() end
		other:Hide()
		-- Over it, while the guide holds the player's skips: the step list,
		-- where each one has its Unskip (UI/StepList.lua).
		skips = W.Link(empty, "", function() if UI.StepList then UI.StepList.Toggle(true) end end, { role = "note" })
		skips.psTip = L["Bring it back"]
		skips:Hide()
	end)

	-- The window's style: transparent drops the panel for a light scrim (the
	-- Here panel's, GF.PaintHerePanel) and outlines the link. Run on each Paint
	-- and on a style change (GF.ApplyStyle).
	function PN.Style()
		if not card then return end
		local clear = GF.Transparent and GF.Transparent() or false
		card.psBare = clear or nil
		Theme.Repaint(card)
		card.Scrim:SetShown(clear)
		if clear then
			local r, g, b = Theme.Color("scrim")
			card.Scrim:SetVertexColor(r, g, b, Theme.House("clearShade") or 0.35)
		end
		for _, l in ipairs({ other, skips }) do
			if l and l.Label then Theme.SetOutline(l.Label, clear and GF.Outline and GF.Outline() or nil) end
		end
	end

	function PN.card() return card end
	function PN.other() return other end
	function PN.skips() return skips end

	function PN.Hide()
		if card then card:Hide() end
		if other then other:Hide() end
		if skips then skips:Hide() end
	end

	-- The skips link: "Review N skipped", hidden with none.
	local function paintSkips()
		local n = UI.StepList and UI.StepList.Skips and UI.StepList.Skips() or 0
		if n > 0 then W.SetLinkText(skips, string.format(L["Review %d skipped"], n)) end
		skips:SetShown(n > 0)
	end

	-- nextGuide: the guide to offer (nil: only the link); fromId: the guide
	-- that ended.
	function PN.Paint(nextGuide, fromId)
		if not card then return end
		other:Show()
		paintSkips()
		PN.Style()
		if not nextGuide then card:Hide() return end
		if not rawget(card, "Art") then
			card.Art = UI.ZoneArt.Create(card, ART_W - 1, CARD_H - 2)
			card.Art:SetPoint("TOPLEFT", card, "TOPLEFT", 1, -1)
			card.Art.Fade:Hide()
			card.Art.Top:Hide()
		end
		local E = ns.Engine
		local fx, fy
		if E and E.GuideFocus then fx, fy = E.GuideFocus(nextGuide.id) end
		card.psArt = UI.ZoneArt.Paint(card.Art, nextGuide.zone, fx, fy, 1)
		local lv = UI.GuideLevels(nextGuide)
		card.Title:SetText((nextGuide.title or nextGuide.id) .. (lv and (" |c" .. Theme.Hex("textMuted") .. "(" .. lv .. ")|r") or ""))
		local level = UnitLevel and UnitLevel("player")
		card.Why:SetText(level and level > 0 and string.format(L["Next in your route · your level %d"], level) or L["Next in your route"])
		local n = E and E.StepTotalOf and E.StepTotalOf(nextGuide) or 0
		if n == 0 then n = nextGuide.stepCount or 0 end
		card.Steps:SetText(n == 1 and L["1 step"] or n > 1 and string.format(L["%d steps"], n) or "")
		card.Start.psAction = function() if E and E.StartNext then E.StartNext(fromId) end end
		card:Show()
	end

	-- The card placed by the caller; sizes it to `width` -> its height.
	function PN.Layout(width)
		if not (card and card:IsShown()) then return 0 end
		card:SetWidth(width)
		local tw = max(40, width - ART_W - INSET * 2)
		local x = ART_W + INSET
		card.Eyebrow:ClearAllPoints()
		card.Eyebrow:SetPoint("TOPLEFT", card, "TOPLEFT", x, -10)
		card.Eyebrow:SetWidth(tw)
		card.Title:ClearAllPoints()
		card.Title:SetPoint("TOPLEFT", card, "TOPLEFT", x, -26)
		card.Title:SetWidth(tw)
		card.Why:ClearAllPoints()
		card.Why:SetPoint("TOPLEFT", card, "TOPLEFT", x, -44)
		card.Why:SetWidth(tw)
		card.Start:ClearAllPoints()
		card.Start:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -INSET, 9)
		card.Steps:ClearAllPoints()
		card.Steps:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", x, 9 + floor((START_H - 12) / 2))
		card.Steps:SetWidth(max(20, tw - START_W - 8))
		return CARD_H
	end
end)
