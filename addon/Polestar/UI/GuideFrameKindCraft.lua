-- The profession and reputation kinds' regions in the guide window (docs/DESIGN.md, "The Guide Window"; the
-- contract in docs/ARCHITECTURE.md, "Guide kind regions"; the models in Core/KindCraft.lua).
--
-- Profession: steps a first-timer follows, drawn as the leveling view's goal rows (GF.NewGoalRow). The slim skill
-- line on top ("Blacksmithing 12 / 75", "Not learned yet"); then the step: a train, learn, buy or go-to step is
-- the step's own rows (UI/GuideFrameRegions.lua, "step"); a get step is "Get 200 Rough Stone 64/200" with a row
-- per way its goals allow, picked like an option (a radio mark), each with one button ("Guide me"; the Auction
-- House's "Buy list" at an open Auction House, else "Guide me" too, the arrow to the nearest auctioneer of the
-- character's side: a longer label cut the way's own words) and
-- a short line ("Wool Cloth from Blackrock Grunt  ·  about 25 min for the rest", "136 more, about 14s at your last
-- search"). A way that gathers in areas (Mine it, Gather it, Kill and skin it), taken, lists up to three of them under
-- it, best first and marked: the area's name, "~12 veins  ·  safe from 8  ·  4 min away" and Guide me (the player's
-- pick, kept by the Engine); with none safe yet "Safe Copper Ore area from level 6"; with the pick mined out "Try
-- Bael'dun Digsite next" first. A gathering step that levels the skill ("areas") shows its skill goal's row and the
-- same rows under its way;
-- a craft step is "Craft Rough Sharpening Stone until 35" with the recipe's icon, the client's skill-up arrow,
-- "about 42 to go" and Open <Profession> (the window's one secure button). Under it one folded row, the shopping
-- list: the section's materials, have / need, and "Buy the whole list". Reputation: the standing meter, the turn-in
-- card, More reputation.
--
-- Compact mode: the skill line, the step's rows without the ways' rows, no shopping list. Every colour is a Theme
-- token; the rows are the goals area's own, so each look paints them its own way; the shopping list's rows go to
-- the skin's guideKindRow hook and the meter to guideMeter. Nothing here builds a string while the window is being
-- resized: `paint` writes the text on a render, `layout` measures and anchors.

local ADDON, ns = ...
ns.UI.GuideFrame.Part(function(GF)
	local UI, Theme, W, L = ns.UI, ns.Theme, ns.Widgets, ns.L
	local ceil, floor, max, min, format = math.ceil, math.floor, math.max, math.min, string.format
	local DOT = "  \194\183  "
	local PAD, TEXT_X = 14, 38
	GF.Bind(function(_, m) PAD, TEXT_X = m.PAD, m.TEXT_X end)

	local function E() return GF.Engine() end
	local function M() return ns.Materials end
	local function KC() return ns.KindCraft end
	local function C() return ns.Compat end
	local function hexed(token, text) return "|c" .. Theme.Hex(token) .. tostring(text) .. "|r" end
	local function itemHex(item, text)
		local q = C().GetItemQuality and C().GetItemQuality(item)
		local hx = q and q >= 2 and C().ItemQualityHex and C().ItemQualityHex(q) or Theme.Hex("item")
		return "|c" .. hx .. tostring(text) .. "|r"
	end
	local function guideId()
		local e = E()
		local g = e and e.GetGuide and e.GetGuide()
		return g and g.id
	end
	local function narrow(width) return width < 300 end
	local function stepShown()
		local e = E()
		return e and e.GetStepIndex and e.GetStepIndex()
	end

	local function glyph(parent, verb, size, color)
		local t = parent:CreateTexture(nil, "ARTWORK")
		t:SetTexture(Theme.VerbIcon(verb))
		t:SetSize(size or 14, size or 14)
		W.Color(t, color or "textDim")
		return t
	end

	-- An item tile: its icon in a 1px edge of its quality (textMuted below Uncommon); the game's tooltip,
	-- Shift-click links it.
	local function tile(parent, size)
		local b = CreateFrame("Button", nil, parent)
		b:SetSize(size, size)
		-- Not a gamepad stop: its row is.
		b.psPadSkip = true
		b.Edge = b:CreateTexture(nil, "BORDER")
		b.Edge:SetTexture(Theme.Media("white"))
		b.Edge:SetAllPoints(b)
		b.Icon = b:CreateTexture(nil, "ARTWORK")
		b.Icon:SetPoint("TOPLEFT", b, "TOPLEFT", 1, -1)
		b.Icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -1, 1)
		b.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		b:SetScript("OnEnter", function(self) if self.psItem then W.ItemTip(self, self.psItem) end end)
		b:SetScript("OnLeave", function(self) W.TipHide(self) end)
		b:SetScript("OnClick", function(self) if self.psItem and IsModifiedClick and IsModifiedClick("CHATLINK") then W.ItemClick(self.psItem) end end)
		return b
	end
	local function setTile(b, item, verb)
		b.psItem = item
		local icon = item and C().ItemIcon and C().ItemIcon(item)
		if icon then
			b.Icon:SetTexture(icon)
			b.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			b.Icon:SetVertexColor(1, 1, 1, 1)
			W.Uncolor(b.Icon)
		else
			b.Icon:SetTexture(Theme.VerbIcon(verb or "craft"))
			b.Icon:SetTexCoord(0, 1, 0, 1)
			W.Color(b.Icon, "textDim")
		end
		local q = item and C().GetItemQuality and C().GetItemQuality(item)
		if q and q >= 2 and ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[q] then
			local t = ITEM_QUALITY_COLORS[q]
			W.Uncolor(b.Edge)
			b.Edge:SetVertexColor(t.r, t.g, t.b, 0.9)
		else
			W.Color(b.Edge, "border")
		end
	end

	-- In the transparent window the cards draw no ground, as the window draws none.
	local function bareIn(frame)
		-- So does a card a layout set on a card of its own (psHosted: GF.LayoutRegions), never a card in a card.
		local host = frame:GetParent()
		local want = (GF.Transparent() or (host and host.psHosted)) and true or nil
		if frame.psBare ~= want then
			frame.psBare = want
			Theme.Repaint(frame)
		end
	end

	-- The 2px accent bar of the card the step works on.
	local function accentBar(parent)
		local t = parent:CreateTexture(nil, "ARTWORK", nil, 2)
		t:SetTexture(Theme.Media("white"))
		t:SetWidth(2)
		t:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 0)
		t:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 0, 0)
		W.Color(t, "accent")
		return t
	end

	-- A meter's bar: the track, the stretch still to go lit at 30 % of the accent, the fill.
	local function meterBar(parent, h)
		local bar = CreateFrame("Frame", nil, parent)
		bar:SetHeight(h)
		bar.Track = bar:CreateTexture(nil, "BACKGROUND")
		bar.Track:SetTexture(Theme.Media("white"))
		bar.Track:SetAllPoints(bar)
		W.Painter(bar.Track, function(t) t:SetVertexColor(Theme.Wash("progress")) end)
		bar.Seg = bar:CreateTexture(nil, "BORDER")
		bar.Seg:SetTexture(Theme.Media("white"))
		W.Color(bar.Seg, "accent", 0.3)
		bar.Fill = bar:CreateTexture(nil, "ARTWORK")
		bar.Fill:SetTexture(Theme.Media("white"))
		W.Color(bar.Fill, "accent")
		return bar
	end
	local function placeBar(bar, w, frac, seg, done)
		bar:SetWidth(max(1, w))
		local fw = max(0.01, w * min(1, max(0, frac or 0)))
		bar.Fill:ClearAllPoints()
		bar.Fill:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
		bar.Fill:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", 0, 0)
		bar.Fill:SetWidth(fw)
		bar.Fill:SetShown((frac or 0) > 0)
		W.Color(bar.Fill, done and "success" or "accent")
		local a, b = seg and seg[1] or 0, seg and seg[2] or 0
		bar.Seg:ClearAllPoints()
		if b > a then
			bar.Seg:SetPoint("TOPLEFT", bar, "TOPLEFT", floor(w * a + 0.5), 0)
			bar.Seg:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", floor(w * a + 0.5), 0)
			bar.Seg:SetWidth(max(0.01, w * (b - a)))
			bar.Seg:Show()
		else
			bar.Seg:Hide()
		end
	end

	-- Leads the arrow to a goal of step s (index gi): the step is looked at first when it is not the one shown.
	local function guideTo(s, gi)
		local e = E()
		if not (e and s) then return end
		if e.GetStepIndex and e.GetStepIndex() ~= s and e.Goto then e.Goto(s) end
		if gi and e.AimGoal then e.AimGoal(s, gi) end
		if ns.Nav and ns.Nav.ReleaseTarget then ns.Nav.ReleaseTarget() end
		if GF.UpdateTargets then GF.UpdateTargets() end
	end

	-- A goal row of a region (GF.NewGoalRow). Its first few units take no mouse: side tabs stand over the window's
	-- left edge (UI/TabStyles), and a step's rows here sit high in the window, beside them.
	local EDGE = 4
	local function regionRow(f)
		local r = GF.NewGoalRow(f)
		r:SetHitRectInsets(EDGE, 0, 0, 0)
		return r
	end

	-- A region's button at a goal row's right edge, in the middle of the row, with room above and below it (a look's
	-- button may take the mouse a little past its edges); the row's text wraps clear of it.
	local function rowButton(row, b, width)
		b:ClearAllPoints()
		b:SetPoint("RIGHT", row, "RIGHT", -PAD, 0)
		local shown = b:IsShown()
		row.psRightMin = PAD + (shown and b:GetWidth() + 8 or 0)
		local h = GF.MeasureRow(row, width)
		return shown and max(h, floor(b:GetHeight() + 16 + 0.5)) or h
	end

	---------------------------------------------------------------------------
	-- Meter: the skill (one slim line) or the standing
	---------------------------------------------------------------------------

	-- A meter line's name: its whole width (unbounded, rounded up: a width a hair under the text cuts its last
	-- letter), beside a bar of BAR_MIN or more when the line has room for both; else the bar gives way, and the
	-- name keeps whole up to `room` (what is left of the line before the numbers). -> the name's width, the bar's
	-- (0: none)
	local BAR_MIN = 24
	local function nameAndBar(fs, shared, room)
		local full = ceil(fs:GetUnboundedStringWidth())
		if full + BAR_MIN <= shared then return full, shared - full end
		return min(full, max(40, room)), 0
	end

	GF.RegisterRegion("meter", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Glyph = glyph(f, "skill", 14)
			f.Name = W.Text(f, "name", "skill")
			f.Value = W.Text(f, "title", "text")
			f.Max = W.Text(f, "label", "textDim")
			f.Rank = W.Text(f, "label", "textDim")
			f.Bar = meterBar(f, 3)
			f.Line = W.Text(f, "small", "textDim")
			return f
		end,
		model = function(view, kind)
			local e = E()
			return e and e.KindModel and e.KindModel("meter", view, kind)
		end,
		paint = function(f, m, mode)
			f.psModel = m
			-- A skill wears its profession's own icon (UI.ProfessionIcon: Mining's pickaxe), a standing the glyph.
			local art = m.kind == "skill" and UI.ProfessionIcon(m.skillLine) or nil
			UI.SetArtOrGlyph(f.Glyph, art, m.kind == "rep" and "icon-rep" or "icon-skill", m.done and "success" or "textDim")
			W.Color(f.Name, m.nameKind or "skill")
			if m.kind == "skill" and m.learned == false then
				f.Name:SetText(m.name or "")
				f.Value:SetText("")
				f.Max:SetText(L["Not learned yet"])
			elseif m.kind == "rep" then
				f.Name:SetText((mode == "compact" and m.known and m.rank) or m.name or "")
				f.Value:SetText(m.known and ns.Thousands(m.value) or tostring(m.value or ""))
				f.Max:SetText(m.known and ("/ " .. ns.Thousands(m.max)) or "")
			else
				f.Name:SetText(m.name or "")
				f.Value:SetText(tostring(m.value))
				f.Max:SetText("/ " .. tostring(m.max))
			end
			f.Rank:SetText(m.kind == "rep" and m.rank or "")
			local ln = m.line or {}
			local text = ""
			if m.kind == "rep" and m.known then
				if m.done and m.rank then
					text = format(L["%s reached"], m.rank)
				elseif ln.reached and ln.target then
					text = format(L["%s reached"], ln.target)
				elseif ln.next and ln.turnins then
					text = format(L["%s to %s  \194\183  about %d turn-ins"], ns.Thousands(ln.toNext), ln.next, ln.turnins)
				elseif ln.next then
					text = format(L["%s to %s"], ns.Thousands(ln.toNext), ln.next)
				end
			end
			f.Line:SetText(text)
			f.Line:SetShown(mode ~= "compact" and text ~= "")
			GF.Hook("guideMeter", f, { kind = m.kind, frac = m.frac, seg = m.seg, bar = f.Bar })
		end,
		layout = function(f, m, width, mode)
			local x = PAD
			f.Glyph:ClearAllPoints()
			f.Name:ClearAllPoints()
			f.Value:ClearAllPoints()
			f.Max:ClearAllPoints()
			f.Rank:ClearAllPoints()
			f.Bar:ClearAllPoints()
			local maxW = f.Max:GetStringWidth()
			local valW = f.Value:GetStringWidth()
			local rankW = (f.Rank:GetText() or "") ~= "" and f.Rank:GetStringWidth() + 6 or 0
			local textX = x + 22
			local done = m.done or (m.line and m.line.reached)
			-- The skill is one slim line in every mode: its name, a bar, the value and the cap.
			if mode == "compact" or m.kind == "skill" then
				local h = 26
				f.Glyph:SetPoint("LEFT", f, "TOPLEFT", x, -h / 2)
				f.Name:SetPoint("LEFT", f, "TOPLEFT", textX, -h / 2)
				f.Max:SetPoint("RIGHT", f, "TOPRIGHT", -PAD, -h / 2 - 1)
				f.Value:SetPoint("RIGHT", f.Max, "LEFT", -3, 1)
				-- The name and the bar share what the numbers leave (a gap of 10 after each).
				local shared = width - PAD - maxW - valW - 3 - 10 - textX - 10
				local nameW, bw = nameAndBar(f.Name, shared, shared + 12)
				f.Name:SetWidth(nameW)
				f.Max:Show()
				f.Rank:Hide()
				local bx = textX + nameW + 10
				f.Bar:SetPoint("LEFT", f, "TOPLEFT", bx, -h / 2)
				f.Bar:SetShown(bw > 0 and m.learned ~= false)
				placeBar(f.Bar, bw, m.frac, m.seg, done)
				f.Line:Hide()
				return h
			end
			f.Glyph:SetPoint("TOPLEFT", f, "TOPLEFT", x, -12)
			f.Name:SetPoint("TOPLEFT", f, "TOPLEFT", textX, -9)
			f.Max:SetPoint("TOPRIGHT", f, "TOPRIGHT", -PAD, -12)
			-- The name keeps whole: where the rank and the numbers leave it too little room, the cap ("/ 3,000")
			-- gives way first (the line under the bar says what is left to the next rank), then the rank.
			local full = ceil(f.Name:GetUnboundedStringWidth())
			local room = width - textX - PAD - maxW - valW - rankW - 12
			local showMax, showRank = true, rankW > 0
			if full > room then showMax, room = false, room + maxW + 3 end
			if full > room and showRank then showRank, room = false, room + rankW end
			f.Max:SetShown(showMax)
			f.Value:SetPoint("BOTTOMRIGHT", f.Max, showMax and "BOTTOMLEFT" or "BOTTOMRIGHT", showMax and -3 or 0, 0)
			f.Rank:SetPoint("BOTTOMRIGHT", f.Value, "BOTTOMLEFT", -6, 0)
			f.Rank:SetShown(showRank)
			f.Name:SetWidth(max(40, min(full, room)))
			local bw = width - textX - PAD
			f.Bar:SetPoint("TOPLEFT", f, "TOPLEFT", textX, -31)
			f.Bar:Show()
			placeBar(f.Bar, bw, m.frac, m.seg, done)
			local h = 31 + 3
			if f.Line:IsShown() then
				f.Line:ClearAllPoints()
				f.Line:SetPoint("TOPLEFT", f, "TOPLEFT", textX, -(h + 6))
				f.Line:SetWidth(bw)
				h = h + 6 + f.Line:GetStringHeight()
			end
			return floor(h + 8 + 0.5)
		end,
	})

	---------------------------------------------------------------------------
	-- The craft step's row
	---------------------------------------------------------------------------

	-- The recipe's colour as the client's own profession window marks it: its skill-up arrows (Blizzard_Professions'
	-- recipe list: Professions-Icon-Skill-High for orange, -Medium for yellow, -Low for green; none for grey). Where
	-- the client has no such art, our chevron in the colour's token. The arrows are 13 x 15, their size in the client's
	-- atlas table (UiTextureAtlasMember), as its recipe list draws them, inline after the recipe's name.
	local COLOUR_TOKEN = { orange = "craftOrange", yellow = "craftYellow", green = "craftGreen", grey = "craftGrey" }
	local SKILL_UP = { orange = "Professions-Icon-Skill-High", yellow = "Professions-Icon-Skill-Medium", green = "Professions-Icon-Skill-Low" }
	local SKILL_UP_W, SKILL_UP_H = 13, 15
	local function skillUpAtlas(colour)
		local atlas = SKILL_UP[colour]
		return atlas and C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(atlas) and atlas or nil
	end
	-- "" for grey / no colour.
	local function skillUpMarkup(colour)
		if not SKILL_UP[colour] then return "" end
		local atlas = skillUpAtlas(colour)
		if atlas then return format("|A:%s:%d:%d|a", atlas, SKILL_UP_H, SKILL_UP_W) end
		local r, g, b = Theme.Color(COLOUR_TOKEN[colour])
		return format("|T%s:12:12:0:0:64:64:0:64:0:64:%d:%d:%d|t", Theme.Media("chevron-up"), floor(r * 255 + 0.5), floor(g * 255 + 0.5), floor(b * 255 + 0.5))
	end
	GF.KindSkillUp = skillUpMarkup

	-- Open <Profession>. What shows on the row is an ordinary button (`row.psOpen`, painted and laid out with the
	-- row); the click is a secure spell button's (the window's only one) that lives outside the window's frame tree,
	-- as the name targets' do (UI/NameTargets.lua): under a holder the client hides in combat, placed over the row's
	-- button in UIParent's own coordinates out of combat, so the window moves, hides and repaints freely in a fight.
	-- The live window's alone; a copy's button does nothing.
	local secure, holder
	local function locked() return InCombatLockdown and InCombatLockdown() end
	local function secureButton()
		if secure or not GF.live or locked() then return secure end
		holder = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
		holder:SetSize(1, 1)
		if RegisterStateDriver then RegisterStateDriver(holder, "visibility", "[combat] hide; show") end
		secure = CreateFrame("Button", "PolestarOpenProfession", holder, "SecureActionButtonTemplate")
		secure:RegisterForClicks("AnyUp", "AnyDown")
		secure:SetAttribute("type", "spell")
		secure:Hide()
		-- Its look is the row's button under it: the hover lights that one.
		-- Without its words (the narrow and compact window) the icon says what it opens.
		secure:SetScript("OnEnter", function(self)
			local v = self.psSlot
			if not v then return end
			v.psLit = true
			W.Color(v.Label, "text")
			if v.psIconOnly and v.psSpell then W.Tooltip(self, GF.TooltipAnchor and GF.TooltipAnchor() or "ANCHOR_RIGHT", format(L["Open %s"], v.psSpell)) end
		end)
		secure:SetScript("OnLeave", function(self)
			local v = self.psSlot
			if v then v.psLit = nil; W.Color(v.Label, "buttonText") end
			W.HideTooltip(self)
		end)
		return secure
	end
	-- The secure button over the row's (`slot`), or hidden. Out of combat only.
	local function placeSecure(slot)
		if locked() then return end
		local b = secureButton()
		if not b then return end
		if not (slot and slot:IsVisible() and slot.psSpell) or (slot.GetEffectiveAlpha and slot:GetEffectiveAlpha() <= 0) then
			b:Hide()
			return
		end
		if b:GetAttribute("spell") ~= slot.psSpell then b:SetAttribute("spell", slot.psSpell) end
		b.psSlot = slot
		local left, top = slot:GetLeft(), slot:GetTop()
		if not (left and top) then b:Hide(); return end
		local scale = slot:GetEffectiveScale() / UIParent:GetEffectiveScale()
		local width, height = slot:GetWidth() * scale, slot:GetHeight() * scale
		left, top = left * scale, top * scale
		if b.psLeft ~= left or b.psTop ~= top or b.psWidth ~= width or b.psHeight ~= height then
			b:ClearAllPoints()
			b:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
			b:SetSize(width, height)
			b.psLeft, b.psTop, b.psWidth, b.psHeight = left, top, width, height
		end
		local strata, level = slot:GetFrameStrata(), slot:GetFrameLevel() + 2
		if b:GetFrameStrata() ~= strata then b:SetFrameStrata(strata) end
		if b:GetFrameLevel() ~= level then b:SetFrameLevel(level) end
		if not b:IsShown() then b:Show() end
	end
	-- The row's button: built with the row; its text, its spell, shown or not.
	local function openSlot(parent)
		local b = CreateFrame("Button", nil, parent)
		b:SetHeight(22)
		b.Label = W.Text(b, "label", "buttonText")
		b.Label:SetPoint("CENTER", b, "CENTER", 0, 0)
		b.Icon = b:CreateTexture(nil, "ARTWORK")
		b.Icon:SetSize(16, 16)
		b.Icon:SetPoint("CENTER", b, "CENTER", 0, 0)
		b.psTextButton = true
		Theme.Skin(b, "button")
		-- A click is the secure button's over it; with the gamepad, A clicks that one through an override
		-- binding (UI/GamepadGuide.lua), never from code.
		b:SetScript("OnClick", function() end)
		-- The mouse goes to the secure button over it, never to this one.
		b:EnableMouse(false)
		b.psPadRedirect = GF.live and "PolestarOpenProfession" or nil
		-- It follows the window as it moves (a few times a second while it shows), out of combat.
		b:SetScript("OnUpdate", function(self, elapsed)
			self.psWait = (self.psWait or 0) - elapsed
			if self.psWait > 0 then return end
			self.psWait = 0.2
			if GF.live then placeSecure(self) end
		end)
		b:SetScript("OnHide", function(self) if GF.live and secure and secure.psSlot == self then placeSecure(nil) end end)
		return b
	end
	local function setOpen(b, spell, show, iconOnly)
		if show and spell then
			b.psSpell = spell
			b.Label:SetText(format(L["Open %s"], spell))
			b.Label:SetShown(not iconOnly)
			b.psIconOnly = iconOnly and true or nil
			-- The profession's own icon (its spell's, once learned); our anvil only where the client gives none.
			local icon = iconOnly and C().SpellIcon and C().SpellIcon(spell)
			if icon then
				b.Icon:SetTexture(icon)
				b.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
				W.Uncolor(b.Icon)
				b.Icon:SetVertexColor(1, 1, 1, 1)
			else
				b.Icon:SetTexture(Theme.VerbIcon("craft"))
				b.Icon:SetTexCoord(0, 1, 0, 1)
				W.Color(b.Icon, "buttonText")
			end
			b.Icon:SetShown(iconOnly)
			b:SetWidth(iconOnly and 30 or floor(b.Label:GetStringWidth() + 2 * Theme.Metric("buttonPad", 16) + 0.5))
			b:Show()
		else
			b.psSpell = nil
			b:Hide()
		end
	end

	GF.RegisterRegion("stretch", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Row = regionRow(f)
			f.Row.psOpen = openSlot(f.Row)
			f.Row.psGoal = {}
			return f
		end,
		model = function(view, kind)
			local e = E()
			return e and e.KindModel and e.KindModel("stretch", view, kind)
		end,
		paint = function(f, m)
			f.psModel = m
			local r = f.Row
			-- A skill-only step's row (KindCraft's skillRow): the skill goal's own, "Raise Mining to 65  1/65", wearing
			-- the profession's icon (GF.GoalIcon); no Open button.
			if m.skill then
				GF.PaintGoalRow(r, m.skill, true)
				r.psOpenOn = false
				return
			end
			-- The craft's own goal view, never the skill goal's the row may have shown before.
			local g = r.psCraft or {}
			r.psCraft = g
			g.t, g.index, g.status = "craft", m.goalIndex, m.done and "done" or "active"
			g.subject, g.subjectKind, g.item, g.spell = m.name, m.item and "item" or "spell", m.item, m.recipe
			local mark = not m.done and skillUpMarkup(m.colour) or ""
			g.text = format(L["Craft %s until %d"], m.name, m.moveOn) .. (mark ~= "" and "  " .. mark or "")
			-- The row wears the recipe's icon (its item's, else its spell's) and hovers as it: GF.GoalIcon, GF.RecipeSpell.
			GF.PaintGoalRow(r, g, not m.done)
			-- About how many crafts the skill still takes to the move-on (whatever made its points so far), then
			-- "M made" once the recipe's casts were counted; before the skill is learned, that it comes first.
			local sub
			if m.learned == false and m.spell then
				sub = format(L["Learn %s first"], m.spell)
			elseif not m.done then
				local left = m.left and m.left > 0 and format(L["about %d to go"], m.left) or nil
				local made = m.made and m.made > 0 and format(L["%d made"], m.made) or nil
				sub = left and made and (left .. DOT .. made) or left or made
			end
			UI.SetCounted(r.Sub, sub or "")
			r.Sub:SetShown(sub ~= nil)
			r.psOpenOn = m.learned ~= false and not m.done
		end,
		layout = function(f, m, width, mode)
			local r = f.Row
			setOpen(r.psOpen, m.spell, r.psOpenOn, mode == "compact" or narrow(width))
			local h = rowButton(r, r.psOpen, width)
			r:SetHeight(h)
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
			r:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
			r:Show()
			return h
		end,
	})

	---------------------------------------------------------------------------
	-- A get step: "Get 200 Rough Stone" and its ways
	---------------------------------------------------------------------------

	-- Sets a material's way (Materials.SetWay): "buy" | "gather".
	local function setWay(item, way)
		local Mt, id = M(), guideId()
		if Mt and id then Mt.SetWay(id, item, way) end
	end

	-- Whether an open Auction House can take a search (Materials.CanSearch: the game's own window or Auctionator's):
	-- the Auction House way's button then reads Buy list and starts it.
	local function searchable()
		local Mt = M()
		return Mt and Mt.CanSearch and Mt.CanSearch() and Mt.Search and true or false
	end

	-- Puts `count` of item on the buy list: the game's search at an open Auction House, Auctionator's list when it
	-- is installed, and Polestar's own list at the Auction House (UI/AuctionBuys.lua). -> true when it searched.
	local function buyList(list)
		local Mt = M()
		if not (Mt and list[1]) then return false end
		if searchable() then
			Mt.Search(list[1].item, list[1].count)
			return true
		end
		if Mt.AuctionatorLoaded and Mt.AuctionatorLoaded() and Mt.ToAuctionator then
			local e = E()
			local g = e and e.GetGuide and e.GetGuide()
			Mt.ToAuctionator(g and g.title or "Polestar", list)
		end
		if UI.AuctionBuys and UI.AuctionBuys.CheckGuide then UI.AuctionBuys.CheckGuide(guideId()) end
		return false
	end

	-- A way's words, a literal key each (the translations' check finds only those).
	local function wayText(w)
		if w.way == "buy" then return L["Buy it at the Auction House"] end
		if w.way == "vendor" then return w.npc and format(L["Buy it from %s"], hexed("npc", w.npc)) or L["Buy it from a vendor"] end
		local v = w.verb
		if v == "mine" then return L["Mine it"] end
		if v == "herb" then return L["Gather it"] end
		if v == "skin" then return L["Kill and skin it"] end
		if v == "fish" then return L["Fish it"] end
		if v == "disenchant" then return L["Disenchant green armour"] end
		if v == "make" then return L["Make it"] end
		return L["Farm it"]
	end

	-- Gathering areas (Core/KindCraft.lua KC.Areas; docs/GUIDE_FORMAT.md "Gathering areas"). An area's line: about how
	-- many nodes are up at once (beasts: and their levels), the level it is safe from, how far it is ("4 min away",
	-- "you're here"). A literal key each.
	local function areaCount(verb, a)
		local n = tonumber(a.count)
		if not n then return nil end
		if verb == "skin" then
			local lv = a.levels
			if lv and lv.min and lv.max and lv.max > lv.min then return format(L["~%d beasts (level %d-%d)"], n, lv.min, lv.max) end
			if lv and lv.min then return format(L["~%d beasts (level %d)"], n, lv.min) end
			return format(L["~%d beasts"], n)
		end
		if verb == "herb" then return format(L["~%d herbs"], n) end
		return format(L["~%d veins"], n)
	end
	local function areaSub(verb, a)
		local parts = {}
		parts[#parts + 1] = areaCount(verb, a)
		if a.safeFrom and a.safeFrom > 1 then parts[#parts + 1] = format(L["safe from %d"], a.safeFrom) end
		if a.here then
			parts[#parts + 1] = L["you're here"]
		elseif a.minutes then
			parts[#parts + 1] = a.minutes < 1 and L["under a minute away"] or format(L["%d min away"], floor(a.minutes + 0.5))
		end
		return parts[1] and table.concat(parts, DOT) or nil
	end
	-- No area safe at the character's level yet: from which level the first one is.
	local function areaSafeText(areas)
		if areas.what then return format(L["Safe %s area from level %d"], areas.what, areas.safeFrom) end
		if areas.verb == "herb" then return format(L["Safe herb area from level %d"], areas.safeFrom) end
		if areas.verb == "skin" then return format(L["Safe skinning area from level %d"], areas.safeFrom) end
		return format(L["Safe mining area from level %d"], areas.safeFrom)
	end
	-- The area the pick left mined out: "Ox Hill is mined out for now".
	local function areaOutText(areas)
		local out = areas.out
		-- Open ground: "Near Razor Hill, Durotar, is mined out for now".
		local place, zone, near = KC().AreaParts(out.fromC)
		if near then
			if areas.verb == "herb" then return format(L["Near %s, %s, is picked clean for now"], place, zone) end
			if areas.verb == "skin" then return format(L["Near %s, %s, is hunted out for now"], place, zone) end
			return format(L["Near %s, %s, is mined out for now"], place, zone)
		end
		if areas.verb == "herb" then return format(L["%s is picked clean for now"], out.name) end
		if areas.verb == "skin" then return format(L["%s is hunted out for now"], out.name) end
		return format(L["%s is mined out for now"], out.name)
	end

	-- A way's short line: where and how long (a farm), what is left and its price (the Auction House, counting the
	-- bank and the mail), where (a vendor). A gathering area way: with no area safe yet, from which level one is
	-- ("Safe Copper Ore area from level 6"); not the way taken, its best area and how far (taken, its rows say it).
	-- `toGet`: what the bags still lack.
	local function waySub(w, toGet)
		local areas = w.areas
		if areas then
			if areas.safeFrom then return areaSafeText(areas) end
			local best = not w.current and areas.list[1]
			if not best then return nil end
			local where = areaSub(nil, { here = best.here, minutes = best.minutes })
			return where and (best.name .. DOT .. where) or best.name
		end
		local parts = {}
		if w.way == "buy" then
			local n = w.toGet or toGet
			if n > 0 then
				parts[1] = w.copper and format(L["%s more, about %s at your last search"], ns.Thousands(n), ns.MoneyText(w.copper))
					or format(L["%s more"], ns.Thousands(n))
			end
		else
			if w.levels then parts[#parts + 1] = format(L["Requires Level %d-%d"], w.levels[1], w.levels[2]) end
			local zone = w.map and UI.MapName(w.map)
			if w.way == "gather" and w.npc then parts[#parts + 1] = hexed("npc", w.npc) end
			if zone then parts[#parts + 1] = zone end
			if w.minutes and toGet > 0 then
				parts[#parts + 1] = w.minutes <= 90 and format(L["about %d min for the rest"], w.minutes) or (w.rate and format(L["about %d an hour"], w.rate)) or nil
			end
		end
		return parts[1] and table.concat(parts, DOT) or nil
	end

	-- A way row's radio mark: a ring, a dot in it while it is the way taken; the others' rings step back.
	local function radio(r, on)
		local dot = r.psDot
		if not dot then
			dot = r:CreateTexture(nil, "OVERLAY")
			dot:SetTexture(Theme.Media("circle"))
			dot:SetSize(6, 6)
			dot:SetPoint("CENTER", r.Icon, "CENTER", 0, 0)
			r.psDot = dot
		end
		r.Icon:SetTexture(Theme.Media("ring"))
		W.Color(r.Icon, on and "accent" or "textMuted")
		W.Color(dot, "accent")
		dot:SetShown(on)
	end
	local function noRadio(r) if r.psDot then r.psDot:Hide() end end
	-- An area row's mark: the guide's location pin (a place, not an option), filled in the accent for the area the
	-- arrow leads to (the player's pick), its outline stepped back for the others and for the next to try. Every look
	-- paints it through its own tokens.
	local function pin(r, on)
		noRadio(r)
		r.Icon:SetTexture(Theme.Media(on and "icon-goto" or "icon-goto-open"))
		r.Icon:SetTexCoord(0, 1, 0, 1)
		W.Color(r.Icon, on and "accent" or "textMuted")
	end

	-- The ways' and areas' tooltips (GF.NewGoalRow's psTipFn): what the row's short line says, whole, with what it is
	-- for and what a click does. A way: its words, the item, the vendor, where, and its line (what is left and the
	-- price at the Auction House, the farm's time, the best area and how far); an area: its name, what its nodes give,
	-- about how many are up (beasts: their levels), the level it is safe from and how far it is (or the area left
	-- mined out, for the next to try).
	local function tipAnchor() return GF.TooltipAnchor and GF.TooltipAnchor() or "ANCHOR_RIGHT" end
	-- The Auction House's own mark, the auctioneer's coins as the minimap shows them.
	local AUCTION_ART = "Interface\\Minimap\\Tracking\\Auctioneer"
	local function wayTip(r)
		local w, e = r.psWay, r.psItem
		if not w then return end
		local lines = {}
		if e and e.item then lines[#lines + 1] = { left = L["Item"], right = itemHex(e.item, e.name or "") } end
		if w.way == "vendor" and w.npc then lines[#lines + 1] = { left = L["NPC"], right = hexed("npc", w.npc) } end
		local zone = not w.areas and w.map and UI.MapName(w.map)
		if zone then lines[#lines + 1] = { left = L["Location"], right = zone } end
		local sub = waySub(w, e and max(0, (e.need or 0) - (e.have or 0)) or 0)
		if sub then lines[#lines + 1] = { sub, Theme.Color("textDim") } end
		if w.way ~= "buy" or not searchable() then lines[#lines + 1] = { L["Click to point the arrow here"], Theme.Accent() } end
		W.Tooltip(r, tipAnchor(), wayText(w), lines)
	end
	local function areaTip(r)
		local areas, a = r.psAreas, r.psAreaEntry
		if not (areas and a) then return end
		local lines = {}
		if areas.what then lines[#lines + 1] = { left = L["Item"], right = hexed("item", areas.what) } end
		local sub = a.out and areaOutText(areas) or areaSub(areas.verb, a)
		if sub then lines[#lines + 1] = { sub, Theme.Color("textDim") } end
		if r.psArea then lines[#lines + 1] = { L["Click to point the arrow here"], Theme.Accent() } end
		W.Tooltip(r, tipAnchor(), r.psAreaName or a.name or "", lines)
	end

	-- A way picked: the item takes it (Materials' pick), and the arrow leads to its goal.
	local function pick(r)
		local w, e = r.psWay, r.psItem
		if not (w and e) then return end
		if (w.way == "gather" or w.way == "buy") and not w.current then setWay(e.item, w.way) end
		local s = stepShown()
		if s then guideTo(s, w.goalIndex) end
	end

	-- An area picked (its row or Guide me; the mined-out line's next): the Engine keeps the pick for the character's
	-- guide step (Engine.PickArea), the item takes the gathering way in a get step, and the arrow leads there.
	local function pickArea(r)
		local areas, i = r.psAreas, r.psArea
		if not (areas and i) then return end
		local e = E()
		if e and e.PickArea then e.PickArea(areas.step, areas.goalIndex, i) end
		local w, it = r.psWay, r.psItem
		if w and it and w.way == "gather" and not w.current then setWay(it.item, "gather") end
		guideTo(areas.step, areas.goalIndex)
	end
	local function areaRow(f, i)
		local r = f.Areas[i]
		if r then return r end
		r = regionRow(f)
		r:SetScript("OnClick", pickArea)
		r.psPadLabel = L["Guide me"]
		r.psTipFn = areaTip
		r.psButton = W.Button(r, L["Guide me"], function() pickArea(r) end, { height = 22 })
		f.Areas[i] = r
		return r
	end
	-- The rows of a gathering area goal's choices onto f.List, from f.Areas[n + 1], indented `x`: the mined-out line
	-- first ("Try Bael'dun Digsite next", its Guide me the pick of that one), then up to three areas, best first and
	-- marked, each with the location pin (the arrow's own filled); `only`: just the arrow's area (compact). `way`,
	-- `item`: a get step's way. -> n
	local function paintAreas(f, n, areas, x, only, way, item)
		local list, t = f.List, way and "collect" or "skill"
		-- `entry`: the area the row stands for (its tooltip), `name` its name without the Best mark.
		local function row(text, sub, i, entry, name)
			n = n + 1
			local r = areaRow(f, n)
			local g = r.psGoal
			if type(g) ~= "table" or g.psKind ~= "area" then g = { psKind = "area" } end
			g.t, g.index, g.status, g.text = t, areas.goalIndex, "active", text
			GF.PaintGoalRow(r, g, false)
			UI.SetCounted(r.Sub, sub or "")
			r.Sub:SetShown(sub ~= nil)
			r.psAreas, r.psArea, r.psWay, r.psItem, r.psIndent = areas, i, way, item, x
			r.psAreaEntry, r.psAreaName = entry, name
			W.SetButtonText(r.psButton, L["Guide me"])
			r.psButton:SetShown(i ~= nil)
			list[#list + 1] = r
			return r
		end
		local out = areas.out
		if out and out.next then
			-- Open ground mid-sentence: "Try near Razor Hill, Durotar, next"; a named subzone as it is.
			local place, zone, near = KC().AreaParts(out.nextC)
			local text = near and format(L["Try near %s, %s, next"], place, zone) or format(L["Try %s next"], out.next)
			local r = row(text, areaOutText(areas), out.i, { out = true }, text)
			pin(r, false)
			W.Color(r.Text, "text")
		end
		local marked = #areas.list > 1
		for _, a in ipairs(areas.list) do
			if not only or a.current then
				local text = a.name or ""
				if a.best and marked then text = text .. "  " .. hexed("accent", L["Best"]) end
				local r = row(text, areaSub(areas.verb, a), a.i, a, a.name)
				pin(r, a.current and true or false)
				W.Color(r.Text, a.current and "text" or "textDim")
			end
		end
		return n
	end
	-- A region's rows, each under the one before, indented by its psIndent; a row with a button wraps clear of it.
	local function layoutList(f, width)
		local y = 0
		for _, r in ipairs(f.List) do
			local x = r.psIndent or 0
			local h = r.psButton and rowButton(r, r.psButton, width - x) or GF.MeasureRow(r, width - x)
			r:SetHeight(h)
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", f, "TOPLEFT", x, -y)
			r:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -y)
			r:Show()
			y = y + h
		end
		return floor(y + 0.5)
	end

	-- The item's row: a goal row as the step's own (a click leads the arrow to the goal that applies).
	local function itemRow(f, i)
		f.Items[i] = f.Items[i] or regionRow(f)
		return f.Items[i]
	end
	-- A way's row: a click picks it; its button leads the arrow there ("Guide me") or puts it on the buy list: the
	-- search at an open Auction House, else ("Guide me") the arrow to the nearest auctioneer.
	local function wayRow(f, i)
		local r = f.Ways[i]
		if r then return r end
		r = regionRow(f)
		r:SetScript("OnClick", pick)
		r.psPadLabel = L["Guide me"]
		r.psTipFn = wayTip
		r.psButton = W.Button(r, "", function()
			local w, e = r.psWay, r.psItem
			if not (w and e) then return end
			if w.way == "buy" then
				setWay(e.item, "buy")
				if not buyList({ { item = e.item, name = e.name, count = w.toGet or max(0, e.need - e.have) } }) then pick(r) end
			else
				pick(r)
			end
		end, { height = 22 })
		f.Ways[i] = r
		return r
	end

	GF.RegisterRegion("get", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Items, f.Ways, f.Areas, f.List = {}, {}, {}, {}
			return f
		end,
		model = function(view, kind)
			local e = E()
			return e and e.KindModel and e.KindModel("get", view, kind)
		end,
		paint = function(f, m, mode)
			local list = f.List
			for i = #list, 1, -1 do list[i] = nil end
			local ni, nw, na = 0, 0, 0
			local compact = mode == "compact"
			for _, e in ipairs(m.items) do
				-- The item's row: what to get, the count once.
				ni = ni + 1
				local r = itemRow(f, ni)
				local g = r.psGoal
				if type(g) ~= "table" or g.psKind ~= "get" then g = { psKind = "get" } end
				g.t, g.index, g.status = "collect", e.goalIndex, e.done and "done" or "active"
				g.text = format(L["Get %d %s"], e.need, e.name)
				g.subject, g.subjectKind, g.item = e.name, "item", e.item
				g.progress = { cur = e.have, max = e.need, kind = "count" }
				GF.PaintGoalRow(r, g, not e.done)
				local choices = not compact and not e.done and #e.ways > 1
				UI.SetCounted(r.Sub, choices and L["Pick one way:"] or "")
				r.Sub:SetShown(choices and true or false)
				r.psIndent = 0
				list[#list + 1] = r
				-- A row per way, picked like an option (a radio mark while there is more than one; a lone way wears its
				-- profession's own icon); each leads the arrow there.
				if not compact and not e.done then
					for _, w in ipairs(e.ways) do
						nw = nw + 1
						local wr = wayRow(f, nw)
						local wg = wr.psGoal
						if type(wg) ~= "table" or wg.psKind ~= "way" then wg = { psKind = "way" } end
						-- A farm is a kill (its glyph the kill's); a lone way wears the game's art: a gathering
						-- profession's icon, the Auction House the auctioneer's coins (the minimap's mark).
						wg.t, wg.index, wg.status = w.way == "gather" and (w.verb == "farm" and "kill" or "collect") or "buy", w.goalIndex, "active"
						wg.text = wayText(w)
						wg.art = not choices and (w.way == "gather" and KC().GatherIcon(w.verb) or w.way == "buy" and AUCTION_ART) or nil
						GF.PaintGoalRow(wr, wg, false)
						if choices then radio(wr, w.current) else noRadio(wr) end
						W.Color(wr.Text, w.current and "text" or "textDim")
						local sub = waySub(w, max(0, e.need - e.have))
						UI.SetCounted(wr.Sub, sub or "")
						wr.Sub:SetShown(sub ~= nil)
						wr.psWay, wr.psItem, wr.psIndent = w, e, 16
						-- The way taken to gather in areas lists them under it, and they carry the Guide me buttons.
						local listed = w.areas and w.current and not w.areas.safeFrom
						W.SetButtonText(wr.psButton, w.way == "buy" and searchable() and L["Buy list"] or L["Guide me"])
						wr.psButton:SetShown((w.way == "buy" or w.map ~= nil) and not listed)
						list[#list + 1] = wr
						if listed then na = paintAreas(f, na, w.areas, 32, false, w, e) end
					end
				end
			end
			for i = ni + 1, #f.Items do f.Items[i]:Hide() end
			for i = nw + 1, #f.Ways do f.Ways[i]:Hide() end
			for i = na + 1, #f.Areas do f.Areas[i]:Hide() end
		end,
		layout = function(f, _, width) return layoutList(f, width) end,
	})

	-- A gathering step that levels the skill in areas (KindCraft's `areas`): the skill goal's own row, then the
	-- gathering way's row ('Mine it', 'Gather it', 'Kill and skin it'; a click leads to the area the arrow takes; the
	-- areas under it carry the Guide me buttons) and the areas, or from which level one is safe. Compact: the goal's
	-- row and the arrow's area.
	GF.RegisterRegion("areas", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Goal = regionRow(f)
			f.Way = regionRow(f)
			f.Way:SetScript("OnClick", function() local m = f.psModel; if m then guideTo(m.step, m.goalIndex) end end)
			f.Way.psTipFn = wayTip
			f.Areas, f.List = {}, {}
			return f
		end,
		model = function(view, kind)
			local e = E()
			return e and e.KindModel and e.KindModel("areas", view, kind)
		end,
		paint = function(f, m, mode)
			f.psModel = m
			local list, areas = f.List, m.areas
			for i = #list, 1, -1 do list[i] = nil end
			local compact = mode == "compact"
			local r = f.Goal
			-- The skill goal wears the profession's own icon ("Raise Mining to 50": the pickaxe), as its way does.
			local art = KC().GatherIcon(m.verb)
			GF.PaintGoalRow(r, art and setmetatable({ art = art }, { __index = m.goal }) or m.goal, true)
			r.psIndent = 0
			list[1] = r
			local na = 0
			if not compact then
				local wr = f.Way
				local wg = wr.psGoal
				if type(wg) ~= "table" or wg.psKind ~= "way" then wg = { psKind = "way" } end
				wg.t, wg.index, wg.status = "skill", m.goalIndex, "active"
				wg.text = wayText({ way = "gather", verb = m.verb })
				wg.art = art
				GF.PaintGoalRow(wr, wg, false)
				noRadio(wr)
				local sub = areas.safeFrom and areaSafeText(areas) or nil
				UI.SetCounted(wr.Sub, sub or "")
				wr.Sub:SetShown(sub ~= nil)
				wr.psIndent = 16
				-- Its tooltip: the way's words, the best area and how far (or from which level one is safe).
				local tw = wr.psWay or {}
				tw.way, tw.verb, tw.areas = "gather", m.verb, areas
				wr.psWay, wr.psItem = tw, nil
				list[2] = wr
				na = paintAreas(f, na, areas, 32, false)
			else
				f.Way:Hide()
				-- Compact: none safe yet says so under the goal's row; else the arrow's area.
				if areas.safeFrom then
					local sub = areaSafeText(areas)
					UI.SetCounted(r.Sub, sub)
					r.Sub:Show()
				end
				na = paintAreas(f, na, areas, 16, true)
			end
			for i = na + 1, #f.Areas do f.Areas[i]:Hide() end
		end,
		layout = function(f, _, width) return layoutList(f, width) end,
	})

	---------------------------------------------------------------------------
	-- The shopping list: one folded row
	---------------------------------------------------------------------------

	-- Opened per guide while the session lasts; folded at first.
	local openOf = {}

	-- A material's row: the whole row hovers as its item (the game's tooltip, what the bags, bank and mail hold of
	-- what the section asks under it); Shift-click links it.
	local function shopEnter(self)
		if not self.psItem then return end
		W.ItemTip(self, self.psItem, function(tip)
			if self.psCount and W.TooltipLines then
				tip:AddLine(" ")
				W.TooltipLines(tip, { { left = L["Progress"], right = self.psCount } })
			end
		end, GF.TooltipAnchor and GF.TooltipAnchor() or nil)
	end
	local function shopRow(f, i)
		local row = f.Rows[i]
		if row then return row end
		row = CreateFrame("Button", nil, f)
		row:SetHitRectInsets(EDGE, 0, 0, 0)
		W.Hover(row, 0.6)
		row.Tile = tile(row, 18)
		row.Name = W.Text(row, "label", "item")
		row.Count = W.Text(row, "number", "text")
		row:SetScript("OnEnter", shopEnter)
		row:SetScript("OnLeave", function(self) W.TipHide(self) end)
		row:SetScript("OnClick", function(self) if self.psItem and IsModifiedClick and IsModifiedClick("CHATLINK") then W.ItemClick(self.psItem) end end)
		f.Rows[i] = row
		return row
	end

	GF.RegisterRegion("shopping", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Rule = W.Divider(f)
			f.Head = CreateFrame("Button", nil, f)
			f.Head:SetHitRectInsets(EDGE, 0, 0, 0)
			W.Hover(f.Head, 0.6)
			f.Head.Chev = f.Head:CreateTexture(nil, "ARTWORK")
			f.Head.Chev:SetSize(10, 10)
			W.Color(f.Head.Chev, "textDim")
			f.Head.Text = W.Text(f.Head, "label", "textDim")
			f.Head.Text:SetText(L["Shopping list"])
			f.Head.Right = W.Text(f.Head, "small", "textDim")
			-- Folded or opened: the rows are written on a render (paint), so the card is filled again, not only laid out.
			f.Head:SetScript("OnClick", function()
				local id = guideId() or ""
				openOf[id] = not openOf[id] or nil
				if GF.Refill then GF.Refill() end
			end)
			f.Rows = {}
			f.Buy = W.Button(f, L["Buy the whole list"], function()
				local m = f.psModel
				if not m then return end
				for _, b in ipairs(m.buy) do setWay(b.item, "buy") end
				buyList(m.buy)
				if UI.AuctionBuys and UI.AuctionBuys.Show then UI.AuctionBuys.Show() end
			end, { height = 22 })
			return f
		end,
		-- None in compact, nor for a guide that levels one gathering profession (GuideKinds: its tools are steps).
		model = function(view, kind)
			if GF.Compact() or not GF.KindHas("shoppingList") then return nil end
			local e = E()
			local m = e and e.KindModel and e.KindModel("shopping", view, kind)
			-- A section with nothing to get shows no list at all, never "0 / 0".
			return m and m.rows[1] and m or nil
		end,
		paint = function(f, m)
			f.psModel = m
			local open = openOf[guideId() or ""] and true or false
			f.psOpen = open
			f.Head.Text:SetText(L["Shopping list"])
			f.Head.Right:SetText(format("%d / %d", m.met, #m.rows))
			-- Everything got: the count in the success colour, as each met row's count.
			W.Color(f.Head.Right, m.met >= #m.rows and "success" or "textDim")
			f.Head.Chev:SetTexture(Theme.Media(open and "chevron-up" or "chevron-down"))
			local n = 0
			if open then
				for _, r in ipairs(m.rows) do
					n = n + 1
					local row = shopRow(f, n)
					setTile(row.Tile, r.item, r.way == "buy" and "buy" or "collect")
					local met = r.have >= r.need
					-- A met row steps back: its name out of its item colour into textMuted, its count in success.
					row.Name:SetText(met and r.name or itemHex(r.item, r.name))
					W.Color(row.Name, met and "textMuted" or "item")
					row.Count:SetText(format("%s / %s", ns.Thousands(r.have), ns.Thousands(r.need)))
					W.Color(row.Count, met and "success" or "text")
					row.psItem, row.psCount = r.item, row.Count:GetText()
					GF.Hook("guideKindRow", row, r.item, { kind = "supply", done = met, current = false, way = r.way })
				end
			end
			for i = n + 1, #f.Rows do f.Rows[i]:Hide() end
			f.psN = n
			f.Buy:SetShown(open and m.buy[1] ~= nil)
		end,
		layout = function(f, _, width)
			local y = 6
			f.Rule:ClearAllPoints()
			f.Rule:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -y)
			f.Rule:SetPoint("TOPRIGHT", f, "TOPRIGHT", -PAD, -y)
			y = y + 2
			local hh = 26
			local h = f.Head
			h:ClearAllPoints()
			h:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -y)
			h:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -y)
			h:SetHeight(hh)
			h.Chev:ClearAllPoints()
			h.Chev:SetPoint("LEFT", h, "LEFT", PAD + 2, 0)
			h.Right:ClearAllPoints()
			h.Right:SetPoint("RIGHT", h, "RIGHT", -PAD, 0)
			h.Text:ClearAllPoints()
			h.Text:SetPoint("LEFT", h, "LEFT", TEXT_X, 0)
			h.Text:SetWidth(max(40, width - TEXT_X - PAD - h.Right:GetStringWidth() - 8))
			y = y + hh
			local rh = 24
			for i = 1, f.psN or 0 do
				local row = f.Rows[i]
				row:ClearAllPoints()
				row:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -y)
				row:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -y)
				row:SetHeight(rh)
				row.Tile:ClearAllPoints()
				row.Tile:SetPoint("LEFT", row, "LEFT", TEXT_X - 24, 0)
				row.Count:ClearAllPoints()
				row.Count:SetPoint("RIGHT", row, "RIGHT", -PAD, 0)
				row.Name:ClearAllPoints()
				row.Name:SetPoint("LEFT", row, "LEFT", TEXT_X, 0)
				row.Name:SetWidth(max(40, width - TEXT_X - PAD - row.Count:GetStringWidth() - 8))
				row:Show()
				y = y + rh
			end
			if f.Buy:IsShown() then
				f.Buy:ClearAllPoints()
				f.Buy:SetPoint("TOPLEFT", f, "TOPLEFT", TEXT_X, -(y + 4))
				y = y + 4 + f.Buy:GetHeight() + 4
			end
			return floor(y + 4 + 0.5)
		end,
	})

	---------------------------------------------------------------------------
	-- Reputation: the turn-in card and More reputation
	---------------------------------------------------------------------------

	GF.RegisterRegion("turnin", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Card = CreateFrame("Frame", nil, f)
			f.Card.psCard = true
			Theme.Skin(f.Card, "button")
			f.Bar = accentBar(f.Card)
			f.Glyph = glyph(f.Card, "turnin", 16, "accent")
			f.Name = W.Text(f.Card, "goal", "quest")
			f.Chip = W.Chip(f.Card)
			f.What = W.Text(f.Card, "small", "textDim")
			f.Who = W.Text(f.Card, "small", "textDim")
			f.Rule = W.Divider(f.Card)
			f.Ready = W.Text(f.Card, "label", "success")
			f.Check = glyph(f.Card, "complete", 13, "success")
			f.Check:SetTexture(Theme.Media("check"))
			f.Go = W.Button(f.Card, L["Guide me"], function()
				local m = f.psModel
				if m then guideTo(m.step, m.goalIndex) end
			end, { height = 24, primary = true })
			-- Compact
			f.Line = W.Text(f, "goal", "quest")
			f.LineGlyph = glyph(f, "turnin", 14, "accent")
			f.LineRight = W.Text(f, "number", "success")
			return f
		end,
		model = function(view, kind)
			local e = E()
			return e and e.KindModel and e.KindModel("turnin", view, kind)
		end,
		paint = function(f, m)
			f.psModel = m
			bareIn(f.Card)
			f.Name:SetText(m.title)
			if m.repeatable then W.SetChip(f.Chip, L["Repeatable"]) else f.Chip:Hide() end
			local parts = {}
			for _, it in ipairs(m.items) do parts[#parts + 1] = format(L["%d %s"], it.count, itemHex(it.item, it.name)) end
			local what = format(L["%s a turn-in"], table.concat(parts, " + "))
			if m.rep then what = what .. DOT .. format(L["+%d reputation"], m.rep) end
			f.What:SetText(what)
			local where = m.map and UI.MapName(m.map)
			f.Who:SetText((m.npc and hexed("npc", m.npc) or "") .. (m.npc and where and DOT or "") .. (where or ""))
			if m.ready > 0 then
				f.Ready:SetText(format(L["Turn in %d now"], m.ready))
				W.Color(f.Ready, "success")
				f.Check:Show()
				f.Go:Show()
			else
				local sh = m.short
				f.Ready:SetText(sh and format(L["Next turn-in: %d more %s"], sh.count, itemHex(sh.item, sh.name)) or "")
				W.Color(f.Ready, "textDim")
				f.Check:Hide()
				f.Go:Hide()
			end
			f.Line:SetText(m.title)
			-- Compact: what the line is for at its right, how many are ready or how many items more.
			if m.ready > 0 then
				f.LineRight:SetText(format(L["%d ready"], m.ready))
				W.Color(f.LineRight, "success")
			else
				f.LineRight:SetText(m.short and format(L["%d more"], m.short.count) or "")
				W.Color(f.LineRight, "textDim")
			end
		end,
		layout = function(f, m, width, mode)
			local compact = mode == "compact"
			f.Card:SetShown(not compact)
			for _, r in ipairs({ f.Line, f.LineGlyph, f.LineRight }) do r:SetShown(compact) end
			if compact then
				local h = 24
				f.LineGlyph:ClearAllPoints()
				f.LineGlyph:SetPoint("LEFT", f, "TOPLEFT", PAD, -h / 2)
				f.LineRight:ClearAllPoints()
				f.LineRight:SetPoint("RIGHT", f, "TOPRIGHT", -PAD, -h / 2)
				f.Line:ClearAllPoints()
				f.Line:SetPoint("LEFT", f, "TOPLEFT", PAD + 22, -h / 2)
				f.Line:SetWidth(max(40, width - PAD * 2 - 22 - f.LineRight:GetStringWidth() - 8))
				return h
			end
			local cx, cw, inner = PAD - 4, width - (PAD - 4) * 2, 12
			f.Card:ClearAllPoints()
			f.Card:SetPoint("TOPLEFT", f, "TOPLEFT", cx, -4)
			f.Card:SetWidth(cw)
			f.Glyph:ClearAllPoints()
			f.Glyph:SetPoint("TOPLEFT", f.Card, "TOPLEFT", inner, -12)
			local tx = inner + 26
			local chipW = f.Chip:IsShown() and f.Chip:GetWidth() + 8 or 0
			f.Chip:ClearAllPoints()
			f.Chip:SetPoint("TOPRIGHT", f.Card, "TOPRIGHT", -inner, -10)
			f.Name:ClearAllPoints()
			f.Name:SetPoint("TOPLEFT", f.Card, "TOPLEFT", tx, -10)
			f.Name:SetWidth(max(40, cw - tx - inner - chipW))
			f.What:ClearAllPoints()
			f.What:SetPoint("TOPLEFT", f.Name, "BOTTOMLEFT", 0, -4)
			f.What:SetWidth(max(40, cw - tx - inner))
			f.Who:ClearAllPoints()
			f.Who:SetPoint("TOPLEFT", f.What, "BOTTOMLEFT", 0, -3)
			f.Who:SetWidth(max(40, cw - tx - inner))
			local y = 10 + f.Name:GetStringHeight() + 4 + f.What:GetStringHeight() + 3 + f.Who:GetStringHeight() + 10
			local shown = (f.Ready:GetText() or "") ~= ""
			f.Rule:SetShown(shown)
			f.Ready:SetShown(shown)
			if shown then
				f.Rule:ClearAllPoints()
				f.Rule:SetPoint("TOPLEFT", f.Card, "TOPLEFT", inner, -y)
				f.Rule:SetPoint("TOPRIGHT", f.Card, "TOPRIGHT", -inner, -y)
				local mid = y + 16
				f.Check:ClearAllPoints()
				f.Check:SetPoint("LEFT", f.Card, "TOPLEFT", inner, -mid)
				f.Ready:ClearAllPoints()
				f.Ready:SetPoint("LEFT", f.Card, "TOPLEFT", f.Check:IsShown() and inner + 20 or inner, -mid)
				local bw = 0
				if f.Go:IsShown() then
					f.Go:ClearAllPoints()
					f.Go:SetPoint("RIGHT", f.Card, "TOPRIGHT", -inner, -mid)
					bw = f.Go:GetWidth() + 8
				end
				f.Ready:SetWidth(max(40, cw - inner * 2 - bw - (f.Check:IsShown() and 20 or 0)))
				y = y + 32 + 4
			end
			f.Card:SetHeight(y)
			return floor(y + 12 + 0.5)
		end,
	})

	GF.RegisterRegion("more", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Head = W.Text(f, "heading", "text")
			f.Head:SetText(L["More reputation"])
			f.Rows = {}
			return f
		end,
		model = function(view, kind)
			local e = E()
			local m = e and e.KindModel and e.KindModel("more", view, kind)
			-- Compact lists none of it, but the goals its rows stand for still leave the card.
			if m and GF.Compact() then
				if not (m.covers and m.covers[1]) then return nil end
				return { covers = m.covers }
			end
			return m
		end,
		paint = function(f, m)
			f.Head:SetText(L["More reputation"])
			for i, q in ipairs(m) do
				local row = f.Rows[i]
				if not row then
					row = CreateFrame("Button", nil, f)
					row.Glyph = glyph(row, "accept", 12)
					row.Name = W.Text(row, "label", "quest")
					row.Right = W.Text(row, "small", "textDim")
					row:SetScript("OnClick", function(self) if self.psStep then guideTo(self.psStep, self.psGoal) end end)
					f.Rows[i] = row
				end
				row.psStep, row.psGoal = q.step, q.goalIndex
				row.Name:SetText(q.title)
				local right
				if q.from then
					right = format(L["from %s"], q.from)
				else
					local bits = { q.rep and format(q.once and L["+%d once"] or L["+%d each"], q.rep) or (q.once and L["once"] or L["repeats"]) }
					if q.progress and q.progress.max then bits[#bits + 1] = format(L["%d / %d"], q.progress.cur or 0, q.progress.max) end
					right = table.concat(bits, DOT)
				end
				row.Right:SetText(right)
				W.Color(row.Name, q.from and "textDim" or "quest")
				W.Color(row.Glyph, q.current and "accent" or "textDim")
				GF.Hook("guideKindRow", row, q.quest, { kind = "more", done = false, current = q.current and true or false })
				row:Show()
			end
			for i = #m + 1, #f.Rows do f.Rows[i]:Hide() end
			f.psN = #m
		end,
		layout = function(f, _, width, mode)
			if mode == "compact" then return 0 end
			local y = 6
			f.Head:ClearAllPoints()
			f.Head:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -y)
			y = y + f.Head:GetStringHeight() + 6
			local rh = 22
			for i = 1, f.psN or 0 do
				local row = f.Rows[i]
				row:ClearAllPoints()
				row:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -y)
				row:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -y)
				row:SetHeight(rh)
				row.Glyph:ClearAllPoints()
				row.Glyph:SetPoint("LEFT", row, "LEFT", PAD + 1, 0)
				row.Right:ClearAllPoints()
				row.Right:SetPoint("RIGHT", row, "RIGHT", -PAD, 0)
				row.Name:ClearAllPoints()
				row.Name:SetPoint("LEFT", row, "LEFT", PAD + 22, 0)
				row.Name:SetWidth(max(40, width - PAD * 2 - 22 - row.Right:GetStringWidth() - 8))
				y = y + rh
			end
			return floor(y + 6 + 0.5)
		end,
	})

	-- Repaint on what changes the models without a step change: the ways, prices, crafts made, bags.
	if GF.live then
		local function again() if GF.Render then GF.Render() end end
		ns.On("MATERIALS_CHANGED", again)
		ns.On("MATERIALS_PRICES", again)
		ns.On("KIND_CRAFT_MADE", again)
		-- The areas: their ranking, the arrow's area, the mined-out line (Engine's AREA_CHANGED).
		ns.On("AREA_CHANGED", function() if GF.RegionShown("get") or GF.RegionShown("areas") then again() end end)
		-- Open <Profession> (secure) shows or hides only out of combat: once the fight ends.
		ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
			if secure and secure.psSlot then placeSecure(secure.psSlot) end
			if GF.RegionShown("stretch") then again() end
		end)
		-- The Auction House way's button: Buy list while an Auction House is open, else Guide me
		-- (a frame later: the game's window shows or hides on the same event).
		local function auction() if GF.RegionShown("get") then ns.After(0, again) end end
		ns.RegisterEvent("AUCTION_HOUSE_SHOW", auction)
		ns.RegisterEvent("AUCTION_HOUSE_CLOSED", auction)
	end
end)
