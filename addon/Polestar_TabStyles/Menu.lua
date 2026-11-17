-- Polestar_TabStyles: the menu rows the switcher's list of open guides draws
-- (W.ShowMenu's W.MenuRows): item.heading (a title row, not a choice),
-- item.sub (a dimmer note after the text), item.right (a note at the row's
-- right), item.marked (the accent bar at the row's left: the one in use) and
-- item.onRemove (a close glyph, with item.removeTip).

local ns = Polestar
local W, Theme, floor = ns.Widgets, ns.Theme, math.floor

-- A row's close glyph: the menu closes, then the item's onRemove runs (the
-- caller may open the menu again on what is left).
local function remove(row)
	local item = row.psItem
	if not (item and item.onRemove) then return end
	W.HideMenu()
	item.onRemove(item)
end

-- The extras, made on a row's first use of them. -> the width they add
local function extras(row, item, textX)
	local sub, right, mark, x = rawget(row, "Sub"), rawget(row, "Right"), rawget(row, "Mark"), rawget(row, "Remove")
	if item.sub and not sub then
		sub = W.Text(row, "small", "textMuted")
		row.Sub = sub
	end
	if item.right and not right then
		right = W.Text(row, "small", "textMuted")
		right:SetJustifyH("RIGHT")
		right:SetPoint("RIGHT", row, "RIGHT", -10, 0)
		row.Right = right
	end
	if item.marked and not mark then
		mark = row:CreateTexture(nil, "OVERLAY")
		mark:SetTexture(Theme.Media("white"))
		mark:SetWidth(2)
		mark:SetPoint("TOPLEFT", row, "TOPLEFT", 1, -6)
		mark:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 1, 6)
		W.Color(mark, "accent")
		row.Mark = mark
	end
	if item.onRemove and not x then
		x = W.IconButton(row, "close", 18, nil, function(self) remove(self:GetParent()) end, 9)
		x:SetPoint("RIGHT", row, "RIGHT", -6, 0)
		x.psOnLeave = function(self) W.PaintMenuRow(self:GetParent(), self:GetParent():IsMouseOver()) end
		row.Remove = x
	end
	if x then x.psTip = item.removeTip end
	local extra = 0
	if sub then
		sub:SetShown(item.sub ~= nil)
		sub:SetText(item.sub or "")
		sub:ClearAllPoints()
		sub:SetPoint("LEFT", row, "LEFT", textX + floor(row.Text:GetStringWidth() + 1) + 6, 0)
		if item.sub then extra = extra + floor(sub:GetStringWidth() + 1) + 6 end
	end
	if right then
		right:SetText(item.right or "")
		if item.right then extra = extra + floor(right:GetStringWidth() + 1) + 12 end
	end
	if item.onRemove and not item.right then extra = extra + 22 end
	if mark then mark:SetShown(item.marked and true or false) end
	return extra
end

W.MenuRows = {
	place = function(row, item, textX)
		if item.heading then textX = 10 end
		row.Text:SetPoint("LEFT", row, "LEFT", textX, 0)
		Theme.Font(row.Text, item.heading and "small" or "label")
		row:EnableMouse(not item.heading)
		return textX, extras(row, item, textX)
	end,
	-- After the row's own colours: a heading in textMuted, the marked one lit.
	paint = function(row, item, lit)
		if item.heading then return W.Color(row.Text, "textMuted") end
		local off = item.disabled and 0.45 or 1
		if item.marked then
			W.Color(row.Text, item.color or "text", off)
			local face = rawget(row, "Face")
			if face then W.Color(face, item.color or "text", off) end
			if item.icon then W.Color(row.Icon, item.color or "accent", off) end
		end
		local x, right = rawget(row, "Remove"), rawget(row, "Right")
		if x then
			local shown = item.onRemove and (lit or x:IsMouseOver()) and true or false
			x:SetShown(shown)
			if right then right:SetShown(item.right ~= nil and not shown) end
		end
	end,
}
