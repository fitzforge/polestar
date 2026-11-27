-- The profession and reputation kinds' regions in the guide window (docs/DESIGN.md, "The Guide Window"; the
-- contract in docs/ARCHITECTURE.md, "Guide kind regions"; the models in Core/KindCraft.lua).
--
-- Profession: the skill meter (the skill, the stretch still to go lit to its move-on, ticks at the move-on and the
-- next trainer rank), the trainer line, the stretch card (the recipe now, its colour chip, "6 of about 32 made",
-- "You can make 3 now" with Open <Profession>, the window's one secure button), the materials (a row each, have /
-- need, the Buy | Farm toggle; the split under the row in focus: a verdict line over a Buy and a Farm column, the
-- way it takes lit), the buy list line. Reputation: the standing meter, the turn-in card, its items (the same rows
-- and split), More reputation.
--
-- Compact mode: one line per thing (the skill, the recipe, each material still short); the trainer line only when
-- due; no split (a material row opens the Materials window). Every colour is a Theme token, every ground a kit
-- painter (`button` for the cards, `inset` for the split's well, `tab` for the segments), so each look paints
-- them its own way; the rows go to the skin's guideKindRow hook and the meters to guideMeter. Nothing here builds a
-- string while the window is being resized: `paint` writes the text on a render, `layout` measures and anchors.

local ADDON, ns = ...
ns.UI.GuideFrame.Part(function(GF)
	local UI, Theme, W, L = ns.UI, ns.Theme, ns.Widgets, ns.L
	local floor, ceil, max, min, format = math.floor, math.ceil, math.max, math.min, string.format
	local DOT = "  \194\183  "
	local PAD, TEXT_X = 14, 38
	GF.Bind(function(_, m) PAD, TEXT_X = m.PAD, m.TEXT_X end)

	local function E() return GF.Engine() end
	local function M() return ns.Materials end
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

	-- Minutes as the window writes them: "25 min", "4 h", "4 h 20 min".
	local function timeText(m)
		m = floor(m + 0.5)
		if m < 60 then return format(L["%d min"], m) end
		if m % 60 == 0 then return format(L["%d h"], m / 60) end
		return format(L["%d h %d min"], floor(m / 60), m % 60)
	end
	GF.KindTime = timeText

	-- A price's age: "seen 2 h ago", "seen 3 days ago".
	local function ageText(sec)
		if type(sec) ~= "number" then return nil end
		local m = floor(sec / 60)
		if m < 60 then return format(L["seen %d min ago"], max(1, m)) end
		local h = floor(m / 60)
		if h < 48 then return format(L["seen %d h ago"], h) end
		return format(L["seen %d days ago"], floor(h / 24))
	end

	-- The time in a verdict: exact to two hours, past that whole hours ("5 h": the exact time stays in the Farm
	-- column), its words never apart (a no-break space), the warning colour past two hours.
	local NBSP = "\194\160"
	local function verdictTime(mins)
		if not mins then return nil end
		local long = mins > 120
		local t = (timeText(long and floor(mins / 60 + 0.5) * 60 or mins):gsub(" ", NBSP))
		return long and hexed("warning", t) or t
	end

	-- The chosen way's segment (the row's Buy | Farm, the head's Buy | Farm | Mix): the game's looks draw their
	-- tab art, not an underline, so a segment of ours marks its choice with the accent underline there; the
	-- others' own tab paint draws theirs.
	local function segMark(b, on)
		b.psMarked = on and true or false
		local u = b.psUnder
		if not u then
			u = b:CreateTexture(nil, "OVERLAY")
			u:SetTexture(Theme.Media("white"))
			u:SetHeight(2)
			u:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 6, 0)
			u:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -6, 0)
			b.psUnder = u
			W.Painter(u, function(t)
				t:SetVertexColor(Theme.Color("accent"))
				t:SetShown(b.psMarked and Theme.GameSkin() and true or false)
			end)
		else
			u:SetShown(b.psMarked and Theme.GameSkin() and true or false)
		end
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
		-- Not a gamepad stop: its row or card is.
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

	-- In the transparent window the cards and the split's well draw no ground, as the window draws none.
	local function bareIn(frame)
		-- So does a card a layout set on a card of its own (psHosted: GF.LayoutRegions), never a card in a card.
		local host = frame:GetParent()
		local want = (GF.Transparent() or (host and host.psHosted)) and true or nil
		if frame.psBare ~= want then
			frame.psBare = want
			Theme.Repaint(frame)
		end
	end

	-- The 2px accent bar of the row the step works on.
	local function accentBar(parent)
		local t = parent:CreateTexture(nil, "ARTWORK", nil, 2)
		t:SetTexture(Theme.Media("white"))
		t:SetWidth(2)
		t:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 0)
		t:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 0, 0)
		W.Color(t, "accent")
		return t
	end

	-- A meter's bar: the track, the stretch still to go lit at 30 % of the accent, the fill, 1px ticks.
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
		bar.Ticks = {}
		return bar
	end
	local function placeBar(bar, w, frac, seg, ticks, maxv, done)
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
		for i, tk in ipairs(ticks or {}) do
			local t = bar.Ticks[i]
			if not t then
				t = bar:CreateTexture(nil, "OVERLAY")
				t:SetTexture(Theme.Media("white"))
				W.Color(t, "textMuted")
				bar.Ticks[i] = t
			end
			t:ClearAllPoints()
			t:SetWidth(Theme.Pixel(bar))
			t:SetPoint("TOP", bar, "TOPLEFT", floor(w * tk.at / max(1, maxv) + 0.5), 3)
			t:SetPoint("BOTTOM", bar, "BOTTOMLEFT", floor(w * tk.at / max(1, maxv) + 0.5), -3)
			t:Show()
		end
		for i = #(ticks or {}) + 1, #bar.Ticks do bar.Ticks[i]:Hide() end
	end

	---------------------------------------------------------------------------
	-- Meter: the skill or the standing
	---------------------------------------------------------------------------

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
			f:EnableMouse(true)
			f:SetScript("OnEnter", function(self)
				local m = self.psModel
				if not m then return end
				local lines = {}
				for _, tk in ipairs(m.ticks or {}) do
					lines[#lines + 1] = tk.what == "train" and format(L["%d: the trainer's next rank"], tk.at) or format(L["%d: move on to the next recipe"], tk.at)
				end
				W.Tip(self, m.name, lines)
			end)
			f:SetScript("OnLeave", function(self) W.TipHide(self) end)
			return f
		end,
		model = function(view, kind)
			local e = E()
			return e and e.KindModel and e.KindModel("meter", view, kind)
		end,
		paint = function(f, m, mode)
			f.psModel = m
			f.Glyph:SetTexture(Theme.VerbIcon(m.kind == "rep" and "rep" or "skill"))
			W.Color(f.Glyph, m.done and "success" or "textDim")
			W.Color(f.Name, m.nameKind or "skill")
			if m.kind == "skill" and m.learned == false then
				f.Name:SetText(format(L["Learn %s"], m.name or ""))
				f.Value:SetText("")
				f.Max:SetText("")
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
			if m.kind == "skill" and ln[1] then
				local a = itemHex(ln[1].item, ln[1].name)
				text = ln[2] and format(L["%s to %d, then %s to %d"], a, ln[1].to, itemHex(ln[2].item, ln[2].name), ln[2].to)
					or format(L["%s to %d"], a, ln[1].to)
			elseif m.kind == "rep" and m.known then
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
			GF.Hook("guideMeter", f, { kind = m.kind, frac = m.frac, seg = m.seg, ticks = m.ticks, bar = f.Bar })
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
			local rankW = f.Rank:GetText() ~= "" and f.Rank:GetStringWidth() + 6 or 0
			local textX = x + 22
			local done = m.done or (m.line and m.line.reached)
			if mode == "compact" then
				local h = 24
				f.Glyph:SetPoint("LEFT", f, "TOPLEFT", x, -h / 2)
				f.Name:SetPoint("LEFT", f, "TOPLEFT", textX, -h / 2)
				f.Max:SetPoint("RIGHT", f, "TOPRIGHT", -PAD, -h / 2 - 1)
				f.Value:SetPoint("RIGHT", f.Max, "LEFT", -3, 1)
				local nameW = min(f.Name:GetStringWidth(), max(40, (width - textX - PAD) * 0.4))
				f.Name:SetWidth(nameW)
				f.Rank:Hide()
				local bx = textX + nameW + 10
				local bw = width - PAD - maxW - valW - 3 - 10 - bx
				f.Bar:SetPoint("LEFT", f, "TOPLEFT", bx, -h / 2)
				f.Bar:SetShown(bw > 20)
				placeBar(f.Bar, bw, m.frac, m.seg, m.ticks, m.max, done)
				f.Line:Hide()
				return h
			end
			f.Glyph:SetPoint("TOPLEFT", f, "TOPLEFT", x, -12)
			f.Name:SetPoint("TOPLEFT", f, "TOPLEFT", textX, -9)
			f.Max:SetPoint("TOPRIGHT", f, "TOPRIGHT", -PAD, -12)
			f.Value:SetPoint("BOTTOMRIGHT", f.Max, "BOTTOMLEFT", -3, 0)
			f.Rank:SetPoint("BOTTOMRIGHT", f.Value, "BOTTOMLEFT", -6, 0)
			f.Rank:SetShown(rankW > 0)
			f.Name:SetWidth(max(40, width - textX - PAD - maxW - valW - rankW - 12))
			local bw = width - textX - PAD
			f.Bar:SetPoint("TOPLEFT", f, "TOPLEFT", textX, -31)
			f.Bar:Show()
			placeBar(f.Bar, bw, m.frac, m.seg, m.ticks, m.max, done)
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
	-- Trainer
	---------------------------------------------------------------------------

	-- Leads the arrow to a goal of step s (index gi): the step is looked at first when it is not the one shown.
	local function guideTo(s, gi)
		local e = E()
		if not (e and s) then return end
		if e.GetStepIndex and e.GetStepIndex() ~= s and e.Goto then e.Goto(s) end
		if gi and e.AimGoal then e.AimGoal(s, gi) end
		if ns.Nav and ns.Nav.ReleaseTarget then ns.Nav.ReleaseTarget() end
		if GF.UpdateTargets then GF.UpdateTargets() end
	end
	GF.KindGuideTo = guideTo

	GF.RegisterRegion("trainer", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Glyph = glyph(f, "train", 13)
			f.Text = W.Text(f, "body", "text")
			f.Right = W.Text(f, "small", "textMuted")
			f.Go = W.Link(f, L["Guide me"], function(self)
				local m = f.psModel
				if m then guideTo(m.step, m.goalIndex) end
			end)
			f.Go.psTip = nil
			return f
		end,
		model = function(view, kind)
			local e = E()
			local m = e and e.KindModel and e.KindModel("trainer", view, kind)
			if m and not m.due and not GF.Shows("trainer", not GF.Compact()) then return nil end
			return m
		end,
		paint = function(f, m)
			f.psModel = m
			W.Color(f.Glyph, m.due and "accent" or "textDim")
			f.Glyph:SetTexture(Theme.VerbIcon(m.learn and "learn" or "train"))
			local who = m.npc and hexed("npc", m.npc) or nil
			local where = m.map and UI.MapName(m.map)
			if who and where then who = who .. ", " .. where end
			local text
			if m.learn then
				text = format(L["Learn %s"], hexed("spell", m.title))
			elseif m.due then
				text = format(L["Train %s now"], m.title)
			else
				text = format(L["%s at %d"], m.title, m.level)
			end
			if m.needsLevel then text = text .. hexed("textMuted", DOT .. format(L["needs level %d"], m.needsLevel)) end
			if who then text = text .. DOT .. who end
			f.Text:SetText(text)
			f.Right:SetText(not m.due and format(L["%d to go"], m.toGo) or "")
			f.Go:SetShown(m.due and m.step ~= nil)
		end,
		layout = function(f, m, width)
			local h = 24
			f.Glyph:ClearAllPoints()
			f.Glyph:SetPoint("LEFT", f, "TOPLEFT", PAD + 1, -h / 2)
			f.Text:ClearAllPoints()
			f.Text:SetPoint("LEFT", f, "TOPLEFT", PAD + 22, -h / 2)
			local right = f.Go:IsShown() and f.Go or f.Right
			right:ClearAllPoints()
			right:SetPoint("RIGHT", f, "TOPRIGHT", -PAD, -h / 2)
			local rw = right == f.Go and f.Go:GetWidth() or f.Right:GetStringWidth()
			f.Text:SetWidth(max(40, width - PAD * 2 - 22 - rw - 8))
			return h
		end,
	})

	---------------------------------------------------------------------------
	-- Stretch card
	---------------------------------------------------------------------------

	local COLOUR_TOKEN = { orange = "craftOrange", yellow = "craftYellow", green = "craftGreen", grey = "craftGrey" }
	-- The colour's word, a literal key each (the translations' check finds only those).
	local function colourWord(colour)
		if colour == "orange" then return L["Orange"] end
		if colour == "yellow" then return L["Yellow"] end
		if colour == "green" then return L["Green"] end
		return L["Grey"]
	end

	local function colourChip(c, colour)
		local tok = COLOUR_TOKEN[colour]
		W.SetChip(c, colourWord(colour))
		if tok then
			local r, g, b = Theme.Color(tok)
			c.Bg:SetColor(r, g, b, 0.16)
			W.Color(c.Text, tok)
		end
	end

	-- Open <Profession>. What shows in the card is an ordinary button (`f.psOpen`, painted and laid out with the
	-- card); the click is a secure spell button's (the window's only one) that lives outside the window's frame
	-- tree, as the name targets' do (UI/NameTargets.lua): under a holder the client hides in combat, placed over
	-- the card's button in UIParent's own coordinates out of combat, so the window moves, hides and repaints
	-- freely in a fight. The live window's alone; a copy's button does nothing.
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
		-- Its look is the card's button under it: the hover lights that one.
		secure:SetScript("OnEnter", function(self) local v = self.psSlot; if v then v.psLit = true; W.Color(v.Label, "text") end end)
		secure:SetScript("OnLeave", function(self) local v = self.psSlot; if v then v.psLit = nil; W.Color(v.Label, "buttonText") end end)
		return secure
	end
	-- The secure button over the card's (`slot`), or hidden. Out of combat only.
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
	-- The card's button: built with the card; its text, its spell, shown or not.
	local function openSlot(f)
		local b = CreateFrame("Button", nil, f.Card)
		b:SetHeight(24)
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
	local function setOpen(f, spell, show, iconOnly)
		local b = f.psOpen
		if show and spell then
			b.psSpell = spell
			b.Label:SetText(format(L["Open %s"], spell))
			b.Label:SetShown(not iconOnly)
			b.Icon:SetTexture(Theme.VerbIcon("craft"))
			W.Color(b.Icon, "buttonText")
			b.Icon:SetShown(iconOnly)
			b:SetWidth(iconOnly and 32 or floor(b.Label:GetStringWidth() + 2 * Theme.Metric("buttonPad", 16) + 0.5))
			b:Show()
		else
			b.psSpell = nil
			b:Hide()
		end
	end

	GF.RegisterRegion("stretch", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Card = CreateFrame("Frame", nil, f)
			f.Card.psCard = true
			Theme.Skin(f.Card, "button")
			f.Bar = accentBar(f.Card)
			f.Tile = tile(f.Card, 32)
			f.Name = W.Text(f.Card, "goal", "item")
			f.Chip = W.Chip(f.Card)
			f.Chip:EnableMouse(true)
			f.Chip:SetScript("OnEnter", function(self)
				local m = f.psModel
				if m and m.yellow then
					W.Tip(self, colourWord(m.colour), { format(L["Orange: every craft is a point. Yellow from %d, green from %d, grey at %d."], m.yellow, m.green, m.grey) })
				end
			end)
			f.Chip:SetScript("OnLeave", function(self) W.TipHide(self) end)
			f.Uses = W.Text(f.Card, "small", "textDim")
			f.Progress = W.ProgressLine(f.Card, 2)
			f.Count = W.Text(f.Card, "label", "text")
			f.MoveOn = W.Text(f.Card, "small", "textMuted")
			f.Rule = W.Divider(f.Card)
			f.Check = glyph(f.Card, "complete", 13, "success")
			f.Check:SetTexture(Theme.Media("check"))
			f.Make = W.Text(f.Card, "label", "success")
			f.psOpen = openSlot(f)
			-- The compact form: one line.
			f.Line = W.Text(f, "goal", "text")
			f.LineGlyph = glyph(f, "craft", 14, "accent")
			f.LineRight = W.Text(f, "number", "text")
			return f
		end,
		model = function(view, kind)
			local e = E()
			return e and e.KindModel and e.KindModel("stretch", view, kind)
		end,
		paint = function(f, m, mode)
			f.psModel = m
			bareIn(f.Card)
			setTile(f.Tile, m.item, "craft")
			f.Name:SetText(m.item and itemHex(m.item, m.name) or m.name)
			if m.colour then colourChip(f.Chip, m.colour) else f.Chip:Hide() end
			local parts = {}
			for _, r in ipairs(m.reagents or {}) do parts[#parts + 1] = format(L["%d %s"], r.count, itemHex(r.item, r.name)) end
			f.Uses:SetText(table.concat(parts, " + "))
			local exp = m.expected
			-- Under 300 wide the count's short form (layout picks): numbers never cut.
			f.psCountLong = exp and format(L["%s of about %d made"], hexed("text", m.made), exp) or format(L["%d made"], m.made)
			f.psCountShort = exp and format("%d / ~%d", m.made, exp) or f.psCountLong
			if m.colour == "grey" then
				f.MoveOn:SetText(L["Grey now: move on"])
				W.Color(f.MoveOn, "warning")
			else
				f.MoveOn:SetText(format(L["move on at %d"], m.moveOn))
				W.Color(f.MoveOn, "textMuted")
			end
			local canAll = false
			if m.canMake and m.canMake > 0 then
				local left = exp and max(0, exp - m.made) or nil
				canAll = left and m.canMake >= left and left > 0
				f.Make:SetText(canAll and format(L["You can make all %d now"], left) or format(L["You can make %d now"], m.canMake))
				W.Color(f.Make, "success")
				f.Check:Show()
			elseif m.makeFirst then
				f.Make:SetText(format(L["Make %d %s first"], m.makeFirst.count, itemHex(m.makeFirst.item, m.makeFirst.name)))
				W.Color(f.Make, "textDim")
				f.Check:Hide()
			else
				f.Make:SetText("")
				f.Check:Hide()
			end
			f.psCan = m.canMake and m.canMake > 0
			-- Compact
			local word = m.colour and hexed(COLOUR_TOKEN[m.colour], string.lower(colourWord(m.colour))) or nil
			f.Line:SetText((m.item and itemHex(m.item, m.name) or m.name) .. (word and hexed("textMuted", DOT) .. word or ""))
			f.LineRight:SetText(format(L["%d / %s  \194\183  to %d"], m.made, exp and ("~" .. exp) or "?", m.moveOn))
		end,
		layout = function(f, m, width, mode)
			local compact = mode == "compact"
			for _, r in ipairs({ f.Line, f.LineGlyph, f.LineRight }) do r:SetShown(compact) end
			f.Card:SetShown(not compact)
			if compact then
				setOpen(f, nil, false)
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
			local cx, cw = PAD - 4, width - (PAD - 4) * 2
			local inner = 12
			f.Card:ClearAllPoints()
			f.Card:SetPoint("TOPLEFT", f, "TOPLEFT", cx, -4)
			f.Card:SetWidth(cw)
			f.Tile:ClearAllPoints()
			f.Tile:SetPoint("TOPLEFT", f.Card, "TOPLEFT", inner, -12)
			local tx = inner + 32 + 10
			local chipW = f.Chip:IsShown() and f.Chip:GetWidth() + 8 or 0
			f.Chip:ClearAllPoints()
			f.Chip:SetPoint("TOPRIGHT", f.Card, "TOPRIGHT", -inner, -10)
			f.Name:ClearAllPoints()
			f.Name:SetPoint("TOPLEFT", f.Card, "TOPLEFT", tx, -10)
			f.Name:SetWidth(max(40, cw - tx - inner - chipW))
			f.Uses:ClearAllPoints()
			f.Uses:SetPoint("TOPLEFT", f.Name, "BOTTOMLEFT", 0, -3)
			f.Uses:SetWidth(max(40, cw - tx - inner))
			local y = 10 + f.Name:GetStringHeight() + 3 + f.Uses:GetStringHeight() + 10
			y = max(y, 12 + 32 + 8)
			f.Progress:ClearAllPoints()
			f.Progress:SetPoint("TOPLEFT", f.Card, "TOPLEFT", tx, -y)
			f.Progress:SetWidth(cw - tx - inner)
			W.SetProgress(f.Progress, m.expected and m.expected > 0 and m.made / m.expected or 0, cw - tx - inner)
			y = y + 2 + 6
			local countText = narrow(width) and f.psCountShort or f.psCountLong
			if f.Count:GetText() ~= countText then f.Count:SetText(countText) end
			f.Count:ClearAllPoints()
			f.Count:SetPoint("TOPLEFT", f.Card, "TOPLEFT", tx, -y)
			f.MoveOn:ClearAllPoints()
			f.MoveOn:SetPoint("TOPRIGHT", f.Card, "TOPRIGHT", -inner, -y - 1)
			f.Count:SetWidth(max(40, cw - tx - inner - f.MoveOn:GetStringWidth() - 8))
			y = y + f.Count:GetStringHeight() + 10
			local makeShown = f.Make:GetText() ~= ""
			f.Rule:SetShown(makeShown)
			f.Make:SetShown(makeShown)
			local iconOnly = narrow(width)
			setOpen(f, m.spell, f.psCan, iconOnly)
			if makeShown then
				f.Rule:ClearAllPoints()
				f.Rule:SetPoint("TOPLEFT", f.Card, "TOPLEFT", inner, -y)
				f.Rule:SetPoint("TOPRIGHT", f.Card, "TOPRIGHT", -inner, -y)
				local rowH = 32
				local mid = y + rowH / 2
				f.Check:ClearAllPoints()
				f.Check:SetPoint("LEFT", f.Card, "TOPLEFT", inner, -mid)
				f.Make:ClearAllPoints()
				f.Make:SetPoint("LEFT", f.Card, "TOPLEFT", f.Check:IsShown() and inner + 20 or inner, -mid)
				local bw = 0
				local ob = f.psOpen
				if ob and ob:IsShown() then
					ob:ClearAllPoints()
					ob:SetPoint("RIGHT", f.Card, "TOPRIGHT", -inner, -mid)
					bw = ob:GetWidth() + 8
				end
				f.Make:SetWidth(max(40, cw - inner * 2 - 20 - bw))
				y = y + rowH + 4
			end
			f.Card:SetHeight(y)
			return floor(y + 4 + 8 + 0.5)
		end,
	})

	---------------------------------------------------------------------------
	-- Materials: head, rows, the split
	---------------------------------------------------------------------------

	-- The material in focus per guide (a click, a gamepad focus): its split shows; nil the first unmet choosable.
	local focusOf = {}
	local function focusItem(m)
		local id = guideId()
		local want = id and focusOf[id]
		local first
		for i, r in ipairs(m.rows or {}) do
			local open = r.split and r.toGet > 0
			if open and r.item == want then return r, i end
			if open and not first and r.choosable then first = i end
		end
		if first then return m.rows[first], first end
		return nil
	end

	-- A material's way, a literal key each.
	local function wayWord(way)
		if way == "buy" then return L["Buy"] end
		if way == "vendor" then return L["Vendor"] end
		if way == "make" then return L["Make"] end
		return L["Farm"]
	end
	local WAY_VERB = { buy = "buy", gather = "collect", vendor = "vendor", make = "craft" }

	-- The verdict over a material's split: one sentence, the time in warning past two hours.
	local function verdictText(r, short)
		local s = r.split
		if not s then return "" end
		local farm, buy = s.farm, s.buy
		local mins = farm and farm.minutes
		local timeT = verdictTime(mins)
		local cost = buy and buy.copper and ns.MoneyText(buy.copper)
		local text
		if s.verdict == "selfFound" then
			text = (timeT and farm and farm.count) and format(L["About %s for %d at your level."], timeT, farm.count) or L["Self-Found: you farm all of it."]
		elseif s.verdict == "pick" then
			if r.way == "buy" then
				text = cost and format(L["Your pick: buy. About %s."], cost) or L["Your pick: buy."]
			else
				text = timeT and format(L["Your pick: farm. About %s for %d."], timeT, farm.count) or L["Your pick: farm."]
			end
		elseif r.way == "buy" then
			if s.long and timeT then
				text = short and format(L["Mix buys: farming \226\137\136 %s"], timeT) or format(L["Mix buys this: farming takes about %s at your level."], timeT)
			elseif r.reason == "low" then
				text = L["Mix buys this: its mobs are above your level."]
			elseif r.reason == "skill" then
				text = L["Mix buys this: gathering it needs a profession you don't have."]
			elseif r.reason == "past" then
				text = L["Mix buys this: you're past its levels."]
			elseif r.reason == "mode" then
				text = L["Buy all: you buy this."]
			else
				text = L["Bought at the Auction House."]
			end
		else
			if r.reason == "mode" then
				text = L["Gather all: you farm this."]
			elseif timeT and cost then
				text = format(L["Mix farms this: about %s here. Buying costs about %s."], timeT, cost)
			elseif timeT then
				text = format(L["Mix farms this: about %s here."], timeT)
			else
				text = L["Mix farms this."]
			end
		end
		if r.routeCloth then text = text .. " " .. (short and L["Route cloth still counts."] or L["Cloth from your route still counts."]) end
		return text
	end
	GF.KindVerdict = verdictText

	-- Sets a material's way (Materials.SetWay): "buy" | "gather", nil back to automatic.
	local function setWay(item, way)
		local Mt, id = M(), guideId()
		if Mt and id then Mt.SetWay(id, item, way) end
	end

	local function addToBuyList(r)
		local Mt = M()
		if not (Mt and r) then return end
		setWay(r.item, "buy")
		if Mt.AuctionOpen and Mt.AuctionOpen() and Mt.Search then
			Mt.Search(r.item, r.toGet)
			return
		end
		if Mt.AuctionatorLoaded and Mt.AuctionatorLoaded() and Mt.ToAuctionator then
			local e = E()
			local g = e and e.GetGuide and e.GetGuide()
			Mt.ToAuctionator(g and g.title or "Polestar", { { item = r.item, name = r.name, count = r.toGet } })
		end
		if UI.AuctionBuys and UI.AuctionBuys.CheckGuide then UI.AuctionBuys.CheckGuide(guideId()) end
	end

	local function guideMeFarm(r)
		setWay(r.item, "gather")
		local f = r.split and r.split.farm
		if f and f.step then guideTo(f.step, f.index) end
	end

	-- A split column: glyph, title, the big number, two small lines, a button. `withLevel`: the place line's
	-- level is a text of its own after the zone, so a long zone is cut and the level never.
	local function column(parent, verb, withLevel)
		-- A frame the mouse clicks (OnMouseUp), so the gamepad stops on its button, not on it.
		local c = CreateFrame("Frame", nil, parent)
		c:EnableMouse(true)
		c.Lit = c:CreateTexture(nil, "BACKGROUND", nil, 2)
		c.Lit:SetTexture(Theme.Media("white"))
		c.Lit:SetAllPoints(c)
		c.Top = c:CreateTexture(nil, "ARTWORK")
		c.Top:SetTexture(Theme.Media("white"))
		c.Top:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
		c.Top:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, 0)
		c.Top:SetHeight(1.5)
		W.Color(c.Top, "accent")
		c.Glyph = glyph(c, verb, 13)
		c.Title = W.Text(c, "label", "text")
		c.Big = W.Text(c, "heading", "text")
		c.Small1 = W.Text(c, "small", "textMuted")
		c.Small2 = W.Text(c, "small", "textDim")
		if withLevel then
			c.psLevel = W.Text(c, "small", "textDim")
			c.psLevel:SetWordWrap(false)
		end
		-- Names and places wrap at a narrow column; a word never runs off it.
		for _, fs in ipairs({ c.Big, c.Small1, c.Small2 }) do
			fs:SetWordWrap(true)
			fs:SetJustifyV("TOP")
		end
		c.Button = W.Button(c, "", nil, { height = 24 })
		return c
	end
	local function paintColumn(c, lit)
		c.psLit = lit
		local r, g, b, a = Theme.Wash("selected")
		-- The chosen column is the well a shade lighter (the house selection wash at 60 %), not a slab.
		c.Lit:SetVertexColor(r, g, b, (a or 0.08) * 0.6)
		c.Lit:SetShown(lit and not GF.Transparent())
		c.Top:SetShown(lit)
		W.Color(c.Glyph, lit and "accent" or "textDim")
		c.Button.psPrimary = lit or nil
		W.RepaintButton(c.Button)
	end
	-- Everything in a column is centred in it: the glyph and title as one line, the lines under them (wrapped lines
	-- centred each), the button at its own width.
	local function layoutColumn(c, x, w, top, h)
		c:ClearAllPoints()
		c:SetPoint("TOPLEFT", c:GetParent(), "TOPLEFT", x, -top)
		c:SetSize(w, h)
		local ix = 10
		local room = max(20, w - ix * 2)
		c.Title:SetWidth(max(20, room - 19))
		local tw = min(room - 19, c.Title:GetUnboundedStringWidth())
		c.Title:SetWidth(max(1, tw))
		local gx = floor((w - (19 + tw)) / 2 + 0.5)
		c.Glyph:ClearAllPoints()
		c.Glyph:SetPoint("TOPLEFT", c, "TOPLEFT", max(ix, gx), -11)
		c.Title:ClearAllPoints()
		c.Title:SetPoint("TOPLEFT", c, "TOPLEFT", max(ix, gx) + 19, -10)
		local y = 10 + c.Title:GetStringHeight() + 5
		for _, fs in ipairs({ c.Big, c.Small1, c.Small2 }) do
			fs:ClearAllPoints()
			fs:SetJustifyH("CENTER")
			local text = fs:GetText() or ""
			local lv = fs == c.Small2 and c.psLevel
			local both, only = c.psLevelBoth or "", c.psLevelOnly or ""
			local extra = 0
			if lv then
				-- The place line: the zone, then "· lvl 19–23" after it, the two centred as one; where both do not fit
				-- the column's width the level takes the line under it, centred too. The zone is cut at its end only
				-- when it alone is too long; the level never is.
				fs:SetWordWrap(false)
				local zw = text ~= "" and fs:GetUnboundedStringWidth() or 0
				local shown = text ~= "" and both or only
				lv:SetText(shown)
				local under = text ~= "" and only ~= "" and zw + lv:GetUnboundedStringWidth() + 2 > room
				if under then
					lv:SetText(only)
					extra = lv:GetStringHeight() + 2
				end
				local fw = max(20, min(zw, room))
				fs:SetWidth(fw)
				local lw = lv:GetUnboundedStringWidth()
				lv:ClearAllPoints()
				if text == "" then
					lv:SetPoint("TOP", c, "TOP", 0, -y)
				elseif under then
					fs:SetPoint("TOP", c, "TOP", 0, -y)
					lv:SetPoint("TOP", fs, "BOTTOM", 0, -2)
				else
					fs:SetPoint("TOPLEFT", c, "TOPLEFT", max(ix, floor((w - fw - (shown ~= "" and lw or 0)) / 2 + 0.5)), -y)
					lv:SetPoint("TOPLEFT", fs, "TOPRIGHT", 0, 0)
				end
				lv:SetShown(shown ~= "")
			else
				fs:SetWidth(room)
				fs:SetPoint("TOP", c, "TOP", 0, -y)
			end
			if text ~= "" or (lv and only ~= "") then
				fs:SetShown(text ~= "")
				local h = text ~= "" and fs:GetStringHeight() or lv:GetStringHeight()
				y = y + h + extra + (fs == c.Big and 4 or 2)
			else
				fs:Hide()
			end
		end
		y = y + 8
		if c.Button:IsShown() then
			-- Its own width (W.SetButtonText's), never wider than the column.
			local bw = c.Button.psOwnWidth or c.Button:GetWidth()
			c.Button:SetWidth(min(bw, room))
			c.Button:ClearAllPoints()
			c.Button:SetPoint("TOP", c, "TOP", 0, -y)
			y = y + 24
		end
		return y + 10
	end

	local function paintSplit(f, r, width)
		local s = r.split
		-- Both forms now; the layout shows the one its width takes.
		f.psVerdictLong, f.psVerdictShort = verdictText(r, false), verdictText(r, true)
		f.Verdict:SetText(f.psVerdictLong)
		local buy, farm = s.buy, s.farm
		local B, Fm = f.Buy, f.Farm
		-- Buy
		B.Title:SetText(buy and format(L["Buy %d"], r.toGet) or L["Buy"])
		W.Color(B.Title, buy and "text" or "textMuted")
		if not buy then
			B.Big:SetText(L["Not for Self-Found characters"])
			W.Color(B.Big, "textMuted")
			B.Small1:SetText("")
			B.Small2:SetText("")
			B.Button:Hide()
		elseif buy.copper then
			B.Big:SetText("\226\137\136 " .. ns.MoneyText(buy.copper))
			W.Color(B.Big, "coin")
			local bits = {}
			if buy.each then bits[#bits + 1] = format(L["%s each"], ns.MoneyText(buy.each)) end
			local age = ageText(buy.age)
			if age then bits[#bits + 1] = age end
			B.Small1:SetText(table.concat(bits, DOT))
			B.Small2:SetText(buy.short and format(L["only %d listed"], r.toGet - buy.short) or L["Auction House"])
			B.Button:Show()
		else
			B.Big:SetText(L["No price yet"])
			W.Color(B.Big, "textDim")
			B.Small1:SetText(L["Search it once at the Auction House to see the cost."])
			B.Small2:SetText("")
			B.Button:Show()
		end
		local atAH = M() and M().AuctionOpen and M().AuctionOpen()
		W.SetButtonText(B.Button, atAH and L["Search"] or L["Add to buy list"])
		B.Button.psOwnWidth = B.Button:GetWidth()
		-- Farm
		Fm.Title:SetText(format(L["Farm %d"], r.toGet))
		if not farm then
			Fm.Big:SetText(L["No farm spot in this guide"])
			W.Color(Fm.Big, "textMuted")
			Fm.Small1:SetText("")
			Fm.Small2:SetText("")
			Fm.psLevelBoth, Fm.psLevelOnly = "", ""
			Fm.Button:Hide()
		else
			if farm.above and farm.above >= 2 then
				Fm.Big:SetText(format(L["No farm at your level: %d levels above you"], farm.above))
				W.Color(Fm.Big, "warning")
			elseif farm.minutes then
				Fm.Big:SetText("\226\137\136 " .. timeText(farm.minutes))
				W.Color(Fm.Big, farm.minutes > 120 and "warning" or "text")
			else
				Fm.Big:SetText(L["Time not known yet"])
				W.Color(Fm.Big, "textDim")
			end
			Fm.Small1:SetText(farm.npc and hexed("npc", farm.npc) or "")
			local where = farm.map and UI.MapName(farm.map)
			local lvl = farm.lvl
			if type(lvl) == "table" then lvl = UI.LevelRange(lvl.min or lvl[1], lvl.max or lvl[2]) end
			-- "lvl 19–23" never breaks inside.
			local lv = lvl and (format(L["lvl %s"], tostring(lvl)):gsub(" ", NBSP)) or nil
			-- The zone first, in its colour, then the level.
			Fm.Small2:SetText(where and hexed("place", where) or "")
			Fm.psLevelBoth, Fm.psLevelOnly = lv and ((where and DOT or "") .. lv) or "", lv or ""
			Fm.Button:SetShown(farm.step ~= nil)
			W.SetButtonText(Fm.Button, L["Guide me"])
			Fm.Button.psOwnWidth = Fm.Button:GetWidth()
		end
		paintColumn(B, r.way == "buy" and buy ~= false)
		paintColumn(Fm, r.way ~= "buy")
		if not buy then W.Color(B.Glyph, "textMuted") end
	end

	local function rowOf(f, i)
		local row = f.Rows[i]
		if row then return row end
		row = CreateFrame("Button", nil, f)
		row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		row.Bar = accentBar(row)
		row.Hover = row:CreateTexture(nil, "BACKGROUND")
		row.Hover:SetTexture(Theme.Media("white"))
		row.Hover:SetAllPoints(row)
		W.Painter(row.Hover, function(t) t:SetVertexColor(Theme.Wash("hover")) end)
		row.Hover:Hide()
		row.Tile = tile(row, 24)
		row.Name = W.Text(row, "label", "item")
		row.Src = W.Text(row, "small", "textMuted")
		-- The counts go to a second line, whole, before one is cut: a count is never lost (the layout packs them).
		row.Src:SetWordWrap(true)
		row.Src:SetMaxLines(3)
		row.Src:SetJustifyV("TOP")
		row.Count = W.Text(row, "number", "text")
		row.Way = W.Text(row, "small", "textDim")
		row.WayGlyph = glyph(row, "buy", 11)
		row.Check = glyph(row, "complete", 12, "success")
		row.Check:SetTexture(Theme.Media("check"))
		-- The Buy | Farm toggle.
		row.Seg = {}
		for k, way in ipairs({ "buy", "gather" }) do
			local b = CreateFrame("Button", nil, row)
			b:SetHeight(18)
			b.Label = W.Text(b, "small", "textDim")
			b.Label:SetPoint("CENTER", b, "CENTER", 0, 0)
			b.Label:SetText(wayWord(way))
			b:SetWidth(floor(b.Label:GetStringWidth() + 16 + 0.5))
			Theme.Skin(b, "tab")
			b.psWay = way
			b:SetScript("OnClick", function(self)
				local r = row.psRow
				if r then
					focusOf[guideId() or ""] = r.item
					setWay(r.item, self.psWay)
				end
			end)
			row.Seg[k] = b
		end
		-- The gamepad: A opens the row's split, X flips its way (UI/GamepadGuide.lua).
		row.psPadLabel = function(self)
			local r = self.psRow
			return r and r.split and r.toGet > 0 and not GF.Compact() and L["Show Buy and Farm"] or nil
		end
		row.psPadFlipLabel = function(self)
			local r = self.psRow
			if not (r and r.choosable and r.toGet > 0) or self.psSelfFound then return nil end
			return r.way == "buy" and L["Farm instead"] or L["Buy instead"]
		end
		row.psPadFlip = function(self)
			local r = self.psRow
			if not (r and r.choosable and r.toGet > 0) or self.psSelfFound then return false end
			focusOf[guideId() or ""] = r.item
			setWay(r.item, r.way == "buy" and "gather" or "buy")
			return true
		end
		row:SetScript("OnEnter", function(self)
			self.Hover:Show()
			-- What the made counts are, by name (the row's line says "2 made").
			if self.psMade and self.psRow then W.Tip(self, self.psRow.name, { self.psMade }) end
		end)
		row:SetScript("OnLeave", function(self)
			self.Hover:Hide()
			W.TipHide(self)
		end)
		row:SetScript("OnClick", function(self, button)
			local r = self.psRow
			if not r then return end
			if button == "RightButton" then
				if r.choosable then setWay(r.item, nil) end
				return
			end
			if GF.Compact() then
				if UI.Materials and UI.Materials.Show then UI.Materials.Show() end
				return
			end
			focusOf[guideId() or ""] = r.item
			GF.Render()
		end)
		f.Rows[i] = row
		return row
	end

	local function paintRow(row, r, current, mode, selfFound)
		row.psRow = r
		setTile(row.Tile, r.item, WAY_VERB[r.way] or "collect")
		row.Name:SetText(r.name)
		W.Color(row.Name, "item")
		local met = r.have >= r.need
		local p = r.parts or {}
		local bits = {}
		if (p.bags or 0) > 0 then bits[#bits + 1] = format(L["bags %d"], p.bags) end
		if (p.bank or 0) > 0 then bits[#bits + 1] = format(L["bank %d"], p.bank) end
		if (p.mail or 0) + (p.coming or 0) > 0 then bits[#bits + 1] = format(L["mail %d"], p.mail + p.coming) end
		if r.madeCount and r.madeCount > 0 then bits[#bits + 1] = format(L["%d made"], r.madeCount) end
		if #bits == 0 then bits[1] = L["none yet"] end
		-- The layout packs the counts into lines at their dots, so a count is never cut.
		row.psBits = bits
		row.Src:SetText(table.concat(bits, DOT))
		row.psMade = r.madeCount and r.madeCount > 0 and format(L["%d %s already made"], r.madeCount, r.madeName or "") or nil
		row.psSelfFound = selfFound and true or nil
		if mode == "compact" then
			row.Count:SetText(format(L["%d / %d"], r.have, r.need) .. hexed("textMuted", DOT .. string.lower(wayWord(r.way))))
		else
			row.Count:SetText(format(L["%d / %d"], r.have, r.need))
		end
		W.Color(row.Count, met and "success" or "text")
		row.Check:SetShown(met and mode ~= "compact")
		-- Self-Found farms all of it: one way, no toggle.
		local toggle = r.choosable and not met and not selfFound and mode ~= "compact"
		for _, b in ipairs(row.Seg) do
			b:SetShown(toggle)
			Theme.SetTabSelected(b, r.way == b.psWay)
			segMark(b, r.way == b.psWay)
			W.Color(b.Label, r.way == b.psWay and "text" or "textDim")
		end
		local fixed = not toggle and not met and mode ~= "compact"
		row.Way:SetShown(fixed)
		row.WayGlyph:SetShown(fixed)
		if fixed then
			row.Way:SetText(wayWord(r.way))
			row.WayGlyph:SetTexture(Theme.VerbIcon(WAY_VERB[r.way] or "collect"))
		end
		if met then
			W.Color(row.Name, "textMuted")
		end
		row.Bar:SetShown(current)
		GF.Hook("guideKindRow", row, r.item, { kind = "supply", done = met, current = current, way = r.way })
		row:Show()
	end

	local function layoutRow(row, width, h, mode)
		row:SetHeight(h)
		local x = PAD
		row.Tile:ClearAllPoints()
		if mode == "compact" then
			row.Tile:SetSize(16, 16)
			row.Tile:SetPoint("LEFT", row, "LEFT", x, 0)
			row.Src:Hide()
			row.Count:ClearAllPoints()
			row.Count:SetPoint("RIGHT", row, "RIGHT", -PAD, 0)
			row.Name:ClearAllPoints()
			row.Name:SetPoint("LEFT", row, "LEFT", x + 22, 0)
			row.Name:SetWidth(max(40, width - x - 22 - PAD - row.Count:GetStringWidth() - 8))
			return h
		end
		row.Tile:SetSize(24, 24)
		row.Tile:SetPoint("TOPLEFT", row, "TOPLEFT", x, -11)
		row.Src:Show()
		local rx = width - PAD
		row.Count:ClearAllPoints()
		row.Count:SetPoint("TOPRIGHT", row, "TOPRIGHT", -PAD, -8)
		local segW = 0
		if row.Seg[1]:IsShown() then
			row.Seg[2]:ClearAllPoints()
			row.Seg[2]:SetPoint("TOPRIGHT", row, "TOPRIGHT", -PAD, -25)
			row.Seg[1]:ClearAllPoints()
			row.Seg[1]:SetPoint("RIGHT", row.Seg[2], "LEFT", -2, 0)
			segW = row.Seg[1]:GetWidth() + row.Seg[2]:GetWidth() + 2
		elseif row.Way:IsShown() then
			row.Way:ClearAllPoints()
			row.Way:SetPoint("TOPRIGHT", row, "TOPRIGHT", -PAD, -27)
			row.WayGlyph:ClearAllPoints()
			row.WayGlyph:SetPoint("RIGHT", row.Way, "LEFT", -4, 0)
			segW = row.Way:GetStringWidth() + 15
		end
		row.Check:ClearAllPoints()
		row.Check:SetPoint("TOPRIGHT", row, "TOPRIGHT", -PAD, -27)
		local tx = x + 24 + 10
		local rightW = max(row.Count:GetStringWidth(), segW) + 10
		row.Name:ClearAllPoints()
		row.Name:SetPoint("TOPLEFT", row, "TOPLEFT", tx, -8)
		row.Name:SetWidth(max(40, rx - tx - rightW))
		row.Src:ClearAllPoints()
		row.Src:SetPoint("TOPLEFT", row, "TOPLEFT", tx, -26)
		local room = max(40, rx - tx - rightW)
		row.Src:SetWidth(room)
		-- Whole counts per line, joined by dots; one that does not fit goes to the next line.
		local bits = row.psBits
		if bits and #bits > 1 then
			local lines, cur = {}, nil
			for _, b in ipairs(bits) do
				local try = cur and (cur .. DOT .. b) or b
				row.Src:SetText(try)
				if cur and row.Src:GetUnboundedStringWidth() > room then
					lines[#lines + 1] = cur
					cur = b
				else
					cur = try
				end
			end
			lines[#lines + 1] = cur
			row.Src:SetText(table.concat(lines, "\n"))
		end
		-- A count that goes to a second line takes a line more of the row.
		local need = max(h, 26 + row.Src:GetStringHeight() + 9)
		row:SetHeight(need)
		return need
	end

	local function wayLabel(way)
		return way == "gather" and L["Farm"] or way == "buy" and L["Buy"] or L["Mix"]
	end

	GF.RegisterRegion("supplies", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Head = W.Text(f, "heading", "text")
			f.HeadRule = W.Divider(f)
			f.Modes = {}
			for k, mode in ipairs({ "buy", "gather", "mix" }) do
				local b = CreateFrame("Button", nil, f)
				b:SetHeight(22)
				b.Label = W.Text(b, "label", "textDim")
				b.Label:SetPoint("CENTER", b, "CENTER", 0, 0)
				b.psMode = mode
				Theme.Skin(b, "tab")
				b:SetScript("OnClick", function(self)
					local Mt, id = M(), guideId()
					if Mt and id then Mt.SetMode(id, self.psMode) end
				end)
				f.Modes[k] = b
			end
			-- Under 300 wide: the way and a chevron, a menu of the three.
			f.ModeDrop = CreateFrame("Button", nil, f)
			f.ModeDrop:SetHeight(22)
			f.ModeDrop.Label = W.Text(f.ModeDrop, "label", "text")
			f.ModeDrop.Label:SetPoint("LEFT", f.ModeDrop, "LEFT", 8, 0)
			f.ModeDrop.Chev = f.ModeDrop:CreateTexture(nil, "ARTWORK")
			f.ModeDrop.Chev:SetTexture(Theme.Media("chevron-down"))
			f.ModeDrop.Chev:SetSize(10, 10)
			f.ModeDrop.Chev:SetPoint("RIGHT", f.ModeDrop, "RIGHT", -6, 0)
			W.Color(f.ModeDrop.Chev, "textDim")
			Theme.Skin(f.ModeDrop, "tab")
			f.ModeDrop:SetScript("OnClick", function(self)
				local items = {}
				for _, mode in ipairs({ "buy", "gather", "mix" }) do
					items[#items + 1] = { text = wayLabel(mode), func = function()
						local Mt, id = M(), guideId()
						if Mt and id then Mt.SetMode(id, mode) end
					end }
				end
				W.ShowMenu(self, items)
			end)
			f.Rows = {}
			-- The split's well.
			f.Well = CreateFrame("Frame", nil, f)
			Theme.Skin(f.Well, "inset")
			f.Info = f.Well:CreateTexture(nil, "ARTWORK")
			f.Info:SetTexture(Theme.Media("info"))
			f.Info:SetSize(13, 13)
			W.Color(f.Info, "textDim")
			f.Verdict = W.Text(f.Well, "label", "text")
			f.Verdict:SetWordWrap(true)
			f.Verdict:SetJustifyV("TOP")
			-- The advice is two lines at most; the time in it is rounded so it fits.
			f.Verdict:SetMaxLines(2)
			f.Buy = column(f.Well, "buy")
			f.Farm = column(f.Well, "collect", true)
			f.ColRule = W.Divider(f.Well, true)
			f.SplitRule = W.Divider(f.Well)
			f.Buy:SetScript("OnMouseUp", function() if f.psSplitRow and f.psSplitRow.split.buy then setWay(f.psSplitRow.item, "buy") end end)
			f.Farm:SetScript("OnMouseUp", function() if f.psSplitRow then setWay(f.psSplitRow.item, "gather") end end)
			f.Buy.Button:SetScript("OnClick", function() addToBuyList(f.psSplitRow) end)
			f.Farm.Button:SetScript("OnClick", function() if f.psSplitRow then guideMeFarm(f.psSplitRow) end end)
			f.Farm:SetScript("OnEnter", function(self)
				local r = f.psSplitRow
				local fm = r and r.split and r.split.farm
				if not fm then return end
				local lines = {}
				if fm.kills then lines[#lines + 1] = format(L["about %d kills"], fm.kills) end
				local sc = fm.second
				if type(sc) == "table" and sc.npcName then
					local zone = sc.map and UI.MapName(sc.map)
					lines[#lines + 1] = zone and format(L["or %s (%s)"], sc.npcName, zone) or format(L["or %s"], sc.npcName)
				end
				lines[#lines + 1] = L["The arrow takes you to the best farm for your level."]
				W.Tip(self, format(L["Farm %d"], r.toGet), lines)
			end)
			f.Farm:SetScript("OnLeave", function(self) W.TipHide(self) end)
			return f
		end,
		model = function(view, kind)
			local e = E()
			return e and e.KindModel and e.KindModel("supplies", view, kind)
		end,
		paint = function(f, m, mode)
			f.psModel = m
			local title
			if m.titleKind == "skill" and m.title then
				title = format(L["Materials to %d"], m.title)
			elseif m.titleKind == "standing" and m.title and m.items and m.items[1] then
				title = format(L["%s for %s"], m.items[1].name, m.title)
			else
				title = L["Materials"]
			end
			f.Head:SetText(title)
			for _, b in ipairs(f.Modes) do
				b.Label:SetText(wayLabel(b.psMode))
				b:SetWidth(floor(b.Label:GetStringWidth() + 18 + 0.5))
				local on = m.way == b.psMode
				Theme.SetTabSelected(b, on)
				segMark(b, on)
				W.Color(b.Label, on and "text" or "textDim")
				b:SetShown(m.choosable and not m.selfFound and mode ~= "compact")
			end
			f.ModeDrop.Label:SetText(wayLabel(m.way))
			f.ModeDrop:SetWidth(floor(f.ModeDrop.Label:GetStringWidth() + 30 + 0.5))
			local splitOn = GF.Shows("split", mode ~= "compact")
			local fr, fi = focusItem(m)
			f.psSplitRow = splitOn and fr or nil
			f.psSplitAt = splitOn and fi or nil
			local n = 0
			for i, r in ipairs(m.rows) do
				if mode ~= "compact" or r.have < r.need then
					n = n + 1
					paintRow(rowOf(f, n), r, fi == i, mode, m.selfFound)
					f.Rows[n].psAt = i
				end
			end
			for i = n + 1, #f.Rows do f.Rows[i]:Hide() end
			f.psN = n
			f.Well:SetShown(f.psSplitRow ~= nil)
			bareIn(f.Well)
			if f.psSplitRow then paintSplit(f, f.psSplitRow, f:GetWidth() > 1 and f:GetWidth() or 340) end
		end,
		layout = function(f, m, width, mode)
			local y = 0
			local compact = mode == "compact"
			f.Head:SetShown(not compact)
			f.HeadRule:SetShown(not compact)
			f.ModeDrop:Hide()
			if not compact then
				local headH = 32
				f.Head:ClearAllPoints()
				f.Head:SetPoint("LEFT", f, "TOPLEFT", PAD, -(y + headH / 2 + 2))
				local segShown = f.Modes[1]:IsShown()
				local segW = 0
				if segShown and narrow(width) then
					for _, b in ipairs(f.Modes) do b:Hide() end
					f.ModeDrop:Show()
					f.ModeDrop:ClearAllPoints()
					f.ModeDrop:SetPoint("RIGHT", f, "TOPRIGHT", -PAD, -(y + headH / 2 + 2))
					segW = f.ModeDrop:GetWidth()
				elseif segShown then
					local prev
					for k = #f.Modes, 1, -1 do
						local b = f.Modes[k]
						b:ClearAllPoints()
						if prev then b:SetPoint("RIGHT", prev, "LEFT", -2, 0) else b:SetPoint("RIGHT", f, "TOPRIGHT", -PAD, -(y + headH / 2 + 2)) end
						segW = segW + b:GetWidth() + 2
						prev = b
					end
				end
				f.Head:SetWidth(max(40, width - PAD * 2 - segW - 8))
				y = y + headH + 4
				f.HeadRule:ClearAllPoints()
				f.HeadRule:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -y)
				f.HeadRule:SetPoint("TOPRIGHT", f, "TOPRIGHT", -PAD, -y)
			end
			local rowH = compact and 24 or GF.Space("supplyRow", 46)
			local gap = GF.Space("splitGap", 8)
			for i = 1, f.psN or 0 do
				local row = f.Rows[i]
				row:ClearAllPoints()
				row:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -y)
				row:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -y)
				local used = layoutRow(row, width, rowH, mode) or rowH
				y = y + used
				if f.psSplitRow and row.psAt == f.psSplitAt then
					local well = f.Well
					local wx = PAD - 4
					local ww = width - wx * 2
					well:ClearAllPoints()
					well:SetPoint("TOPLEFT", f, "TOPLEFT", wx, -y)
					well:SetWidth(ww)
					f.Info:ClearAllPoints()
					f.Info:SetPoint("TOPLEFT", well, "TOPLEFT", 10, -11)
					f.Verdict:ClearAllPoints()
					f.Verdict:SetPoint("TOPLEFT", well, "TOPLEFT", 30, -10)
					f.Verdict:SetWidth(ww - 30 - 10)
					local vt = narrow(width) and f.psVerdictShort or f.psVerdictLong
					if vt and f.Verdict:GetText() ~= vt then f.Verdict:SetText(vt) end
					local vh = f.Verdict:GetStringHeight()
					local top = 10 + vh + 10
					f.SplitRule:ClearAllPoints()
					f.SplitRule:SetPoint("TOPLEFT", well, "TOPLEFT", 0, -top)
					f.SplitRule:SetPoint("TOPRIGHT", well, "TOPRIGHT", 0, -top)
					local half = floor(ww / 2)
					local hb = layoutColumn(f.Buy, 0, half, top, 200)
					local hf = layoutColumn(f.Farm, half, ww - half, top, 200)
					local ch = max(hb, hf)
					f.Buy:SetHeight(ch)
					f.Farm:SetHeight(ch)
					f.ColRule:ClearAllPoints()
					f.ColRule:SetPoint("TOPLEFT", well, "TOPLEFT", half, -top)
					f.ColRule:SetHeight(ch)
					well:SetHeight(top + ch)
					y = y + top + ch + gap
				end
			end
			return floor(y + (compact and 0 or 4) + 0.5)
		end,
	})

	---------------------------------------------------------------------------
	-- Buy list line
	---------------------------------------------------------------------------

	GF.RegisterRegion("buyList", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Text = W.Text(f, "small", "textDim")
			f.Open = W.Link(f, L["Open list"], function()
				if UI.AuctionBuys and UI.AuctionBuys.Show then UI.AuctionBuys.Show() end
			end)
			f.Open.psTip = nil
			return f
		end,
		model = function(view, kind)
			if GF.Compact() then return nil end
			local e = E()
			return e and e.KindModel and e.KindModel("buyList", view, kind)
		end,
		paint = function(f, m)
			local s = GF.RegionModel and GF.RegionModel("supplies")
			local what
			for _, r in ipairs(s and s.rows or {}) do
				if r.way == "buy" and r.toGet > 0 then
					what = what and (what .. ", " .. itemHex(r.item, r.name)) or (format(L["%d %s"], r.toGet, itemHex(r.item, r.name)))
				end
			end
			local text = format(L["Buy list: %s"], what or tostring(m.count))
			if m.copper then text = text .. DOT .. "\226\137\136 " .. ns.MoneyText(m.copper) .. (m.partial and "+" or "") end
			f.Text:SetText(text)
		end,
		layout = function(f, _, width)
			local h = 26
			f.Open:ClearAllPoints()
			f.Open:SetPoint("RIGHT", f, "TOPRIGHT", -PAD, -h / 2)
			f.Text:ClearAllPoints()
			f.Text:SetPoint("LEFT", f, "TOPLEFT", PAD, -h / 2)
			f.Text:SetWidth(max(40, width - PAD * 2 - f.Open:GetWidth() - 8))
			return h
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
			local shown = f.Ready:GetText() ~= ""
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
		-- Open <Profession> (secure) shows or hides only out of combat: once the fight ends.
		ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
			if secure and secure.psSlot then placeSecure(secure.psSlot) end
			if GF.RegionShown("stretch") then again() end
		end)
	end
end)
