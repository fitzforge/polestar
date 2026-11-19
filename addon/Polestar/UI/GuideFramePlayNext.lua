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
	local card, other
	GF.Bind(function(p)
		empty = p.empty
		if card or not empty then return end
		card = CreateFrame("Frame", nil, empty)
		card:SetHeight(CARD_H)
		Theme.Skin(card, "panel")
		card.Art = UI.ZoneArt.Create(card, ART_W - 1, CARD_H - 2)
		card.Art:SetPoint("TOPLEFT", card, "TOPLEFT", 1, -1)
		card.Art.Fade:Hide()
		card.Art.Top:Hide()
		card.Eyebrow = W.Text(card, "label", "accent")
		card.Eyebrow:SetText(L["Play next"])
		card.Title = W.Text(card, "heading", "text")
		card.Why = W.Text(card, "note", "textDim")
		card.Why:SetWordWrap(true)
		if card.Why.SetMaxLines then card.Why:SetMaxLines(2) end
		card.Steps = W.Text(card, "small", "textMuted")
		card.Start = W.Button(card, L["Start"], function(b) if b.psAction then b.psAction() end end, { primary = true, width = START_W, height = START_H })
		card.Start:SetWidth(START_W)
		card.Start.psDefault = true -- a gamepad starts here (UI/GamepadGuide.lua)
		card:Hide()
		other = W.Link(empty, L["Other guides"], function(b) if b.psAction then b.psAction() end end, { role = "note" })
		other.psTip = L["Open the guide menu"]
		other.psAction = function() UI.ShowPicker() end
		other:Hide()
	end)

	function PN.card() return card end
	function PN.other() return other end

	function PN.Hide()
		if card then card:Hide() end
		if other then other:Hide() end
	end

	-- nextGuide: the guide to offer (nil: only the link); fromId: the guide
	-- that ended.
	function PN.Paint(nextGuide, fromId)
		if not card then return end
		other:Show()
		if not nextGuide then card:Hide() return end
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
