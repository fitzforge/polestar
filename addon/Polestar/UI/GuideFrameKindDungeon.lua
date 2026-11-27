-- The dungeon kind's regions in the guide window (UI/GuideFrameRegions.lua;
-- docs/DESIGN.md, "The Guide Window"), outside the dungeon. Their models:
-- Core/KindDungeon.lua. What the Dungeons hub already says (the level range, the
-- group, the best level) and what the step list holds (every pick-up step, a missing
-- key, the way in with the instance count) is not repeated here.
--
--   brief     the dungeon's picture (its loading screen, Dungeons.Art; else the
--             entrance's zone painting) with its name
--   ready     one line, only while the character is under the dungeon's floor:
--             "Level 15: come back at 18"
--   skipped   one line, only while the plan leaves out a quest the player skipped (or whose
--             chain's start they skipped): "2 of this dungeon's quests are left out because you
--             skipped them", Review opening the list, each quest with its Unskip it
--   (step)    the step's own header and goal rows, as the leveling view shows
--             them (GF.REGIONS' "step"): a prerequisite's accept and kills, a
--             page quest's work out in the world (Dungeons.OutsideWork), the key
--             or attunement still missing, the way in
-- Compact: one line each. The regions' own rows are goal-like (24px) and painted
-- as goal rows; a skin's guideKindRow hook dresses each (info.kind "ready" | "skipped").

local ADDON, ns = ...
ns.UI.GuideFrame.Part(function(GF)
	local Theme, W, L = ns.Theme, ns.Widgets, ns.L
	local floor, max, format = math.floor, math.max, string.format
	local ROW = 24
	local ART_H = 86

	local PAD, ICON, TEXT_X = 14, 15, 39
	GF.Bind(function(_, m) PAD, ICON, TEXT_X = m.PAD, m.ICON, m.TEXT_X end)

	local function D() return ns.Dungeons end
	local function E() return GF.Engine() end
	local function model(id) return function(view, kind) local En = E(); return En and En.KindModel and En.KindModel(id, view, kind) or nil end end
	local function col(token, text) return "|c" .. Theme.Hex(token) .. tostring(text) .. "|r" end
	local function hook(row, item, info) if GF.Hook then GF.Hook("guideKindRow", row, item, info) end end

	-- A goal-like row: glyph, text, a right-hand figure and the 2px accent bar of the row the step works on.
	local function row(parent)
		local r = CreateFrame("Frame", nil, parent)
		r:SetHeight(ROW)
		r.Icon = W.Tex(r, "ARTWORK")
		r.Text = W.Text(r, "goal", "text")
		r.Right = W.Text(r, "number", "text")
		r.Right:SetJustifyH("RIGHT")
		r.Bar = W.Tex(r, "ARTWORK", nil, "accent")
		r.Bar:SetWidth(2)
		r.Bar:Hide()
		return r
	end
	-- Lays r out `width` wide from y, one line. -> its height
	local function place(r, parent, y, width)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -y)
		r:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, -y)
		r.Icon:SetSize(ICON, ICON)
		r.Icon:ClearAllPoints()
		r.Icon:SetPoint("CENTER", r, "TOPLEFT", PAD + ICON / 2, -ROW / 2)
		r.Right:ClearAllPoints()
		r.Right:SetPoint("RIGHT", r, "TOPRIGHT", -PAD, -ROW / 2)
		local rw = r.Right:GetText() and r.Right:GetText() ~= "" and floor(r.Right:GetStringWidth() + 0.5) + 8 or 0
		r.Text:ClearAllPoints()
		r.Text:SetPoint("LEFT", r, "TOPLEFT", TEXT_X, -ROW / 2)
		r.Text:SetWidth(max(20, width - TEXT_X - PAD - rw))
		r:SetHeight(ROW)
		r.Bar:ClearAllPoints()
		r.Bar:SetPoint("TOPLEFT", r, "TOPLEFT", 0, 0)
		r.Bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0)
		r:Show()
		return ROW
	end
	local function glyph(r, media, token)
		r.Icon:SetTexture(Theme.Media(media))
		W.Color(r.Icon, token)
	end

	---------------------------------------------------------------------------
	-- brief
	---------------------------------------------------------------------------

	GF.RegisterRegion("brief", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			local ZA = ns.UI.ZoneArt
			-- The picture sits back so the name and the step lead: 60% desaturated (ZoneArt's own
			-- 20% leaves a loading screen loud) and a deep fade under the name.
			f.Art = ZA.Create(f, 300, ART_H, "bg", 0.9)
			f.Art.psDesat = 0.6
			f.Art:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
			f.Name = W.Text(f.Art.Over, "display", "text")
			Theme.SetShadow(f.Name, true)
			-- Compact: one line.
			f.Line = row(f)
			return f
		end,
		model = model("brief"),
		paint = function(f, m, mode)
			f.Name:SetText(m.name)
			if mode == "compact" then
				glyph(f.Line, "icon-dungeon", "dungeon")
				f.Line.Text:SetText(m.name)
				f.Line.Right:SetText("")
				hook(f.Line, m, { kind = "ready", current = false })
			end
			-- The picture once per dungeon (a width change redraws its crop in layout).
			if f.psKey ~= m.key then
				f.psKey = m.key
				f.psPic = m.art
				f.psW = nil
			end
		end,
		layout = function(f, m, width, mode)
			local compact = mode == "compact"
			f.Art:SetShown(not compact)
			if compact then return place(f.Line, f, 0, width) end
			f.Line:Hide()
			local a = f.Art
			if f.psW ~= width then
				f.psW = width
				a:SetSize(width, ART_H)
				a.psW, a.psH = width, ART_H
				local ZA = ns.UI.ZoneArt
				local d = D().Get(m.key)
				local e = d and d.entrance
				if not (f.psPic and ZA.Picture(a, f.psPic)) then ZA.Paint(a, e and e.map or (d and d.zone), e and e.x, e and e.y, 1) end
			end
			f.Name:ClearAllPoints()
			f.Name:SetPoint("BOTTOMLEFT", a, "BOTTOMLEFT", PAD, 12)
			f.Name:SetWidth(width - 2 * PAD)
			return ART_H + 8
		end,
	})

	---------------------------------------------------------------------------
	-- ready
	---------------------------------------------------------------------------

	-- The model is there only under the dungeon's floor.
	GF.RegisterRegion("ready", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Level = row(f)
			return f
		end,
		model = model("ready"),
		paint = function(f, m)
			glyph(f.Level, "icon-level", "warning")
			f.Level.Text:SetText(col("warning", format(L["Level %d: come back at %d"], m.level, m.floor)))
			f.Level.Right:SetText("")
			hook(f.Level, m, { kind = "ready", done = false })
		end,
		layout = function(f, m, width)
			return place(f.Level, f, 0, width)
		end,
	})

	---------------------------------------------------------------------------
	-- skipped
	---------------------------------------------------------------------------

	local function plural(n, one, many) return n == 1 and one or format(many, n) end

	-- Brings a quest back (Engine.SkipQuest off: the quest itself, or the skipped start of its chain), and
	-- builds the dungeon's pick-up guide again where it is the open one: the quest's steps are in it.
	local function unskip(r)
		local En = E()
		if not (r.psBy and En and En.SkipQuest) then return end
		En.SkipQuest(r.psBy, false)
		local g = En.GetGuide and En.GetGuide()
		local Dg = D()
		if Dg and Dg.PickUp and r.psKey and g and g.id == "lookup/pickup/" .. r.psKey then Dg.PickUp(r.psKey) end
		GF.Update()
	end

	-- One line while the plan leaves out a quest the player skipped: "2 of this dungeon's quests are left out
	-- because you skipped them" and Review, which opens the list (kept by the window, folded on a new dungeon):
	-- each quest, what it comes after when its chain's start is the skip, and Unskip it.
	GF.RegisterRegion("skipped", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			local h = CreateFrame("Button", nil, f)
			f.Head = h
			h.Icon = W.Tex(h, "ARTWORK")
			h.Text = W.Text(h, "goal", "text")
			h.Text:SetWordWrap(true)
			h.Right = W.Text(h, "label", "accent")
			h.Chevron = W.Tex(h, "ARTWORK", nil, "textMuted")
			W.Hover(h, 0.7)
			h:SetScript("OnClick", function() f.psOpen = not f.psOpen; GF.Update() end)
			f.Rows = {}
			return f
		end,
		model = model("skipped"),
		paint = function(f, m, mode)
			if f.psKey ~= m.key then f.psKey, f.psOpen = m.key, false end
			local h = f.Head
			glyph(h, "skip", "textMuted")
			h.Text:SetText(plural(m.count, L["1 of this dungeon's quests is left out because you skipped it"], L["%d of this dungeon's quests are left out because you skipped them"]))
			h.Right:SetText(L["Review"])
			h.Chevron:SetTexture(Theme.Media(f.psOpen and "chevron-up" or "chevron-down"))
			hook(h, m, { kind = "skipped", current = false })
			for i, it in ipairs(m.items) do
				local r = f.Rows[i]
				if not r then
					r = row(f)
					r.Sub = W.Text(r, "small", "textMuted")
					r.Link = W.Link(r, L["Unskip it"], function() unskip(r) end)
					r.Link.psTip = nil
					f.Rows[i] = r
				end
				r.psBy, r.psKey = it.by, m.key
				glyph(r, "skip", "textMuted")
				r.Text:SetText(col("quest", ns.Quoted(it.title) or it.title or ""))
				r.Sub:SetText(it.byTitle and col("textMuted", format(L["After %s"], ns.Quoted(it.byTitle) or it.byTitle)) or "")
				r.psTwo = it.byTitle ~= nil
				W.SetLinkText(r.Link, L["Unskip it"])
				hook(r, it, { kind = "skipped", current = false })
			end
			f.psRows = #m.items
			for i = f.psRows + 1, #f.Rows do f.Rows[i]:Hide() end
		end,
		layout = function(f, m, width)
			local h = f.Head
			h:ClearAllPoints()
			h:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
			h:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
			h.Icon:SetSize(ICON, ICON)
			h.Icon:ClearAllPoints()
			h.Icon:SetPoint("TOPLEFT", h, "TOPLEFT", PAD, -(ROW - ICON) / 2)
			h.Chevron:SetSize(12, 12)
			h.Chevron:ClearAllPoints()
			h.Chevron:SetPoint("TOPRIGHT", h, "TOPRIGHT", -PAD, -(ROW - 12) / 2)
			h.Right:ClearAllPoints()
			h.Right:SetPoint("RIGHT", h.Chevron, "LEFT", -6, 0)
			local rw = floor(h.Right:GetStringWidth() + 0.5)
			h.Text:ClearAllPoints()
			h.Text:SetPoint("TOPLEFT", h, "TOPLEFT", TEXT_X, -5)
			h.Text:SetWidth(max(20, width - TEXT_X - PAD - 12 - 6 - rw - 8))
			local hh = max(ROW, floor(h.Text:GetStringHeight() + 0.5) + 10)
			h:SetHeight(hh)
			h:Show()
			local y = hh
			for i = 1, f.psRows or 0 do
				local r = f.Rows[i]
				r:SetShown(f.psOpen and true or false)
				if f.psOpen then
					r:ClearAllPoints()
					r:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -y)
					r:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -y)
					r.Icon:SetSize(ICON, ICON)
					r.Icon:ClearAllPoints()
					r.Icon:SetPoint("CENTER", r, "TOPLEFT", PAD + ICON / 2, -ROW / 2)
					r.Link:ClearAllPoints()
					r.Link:SetPoint("RIGHT", r, "TOPRIGHT", -PAD, -ROW / 2)
					r.Text:ClearAllPoints()
					r.Text:SetPoint("LEFT", r, "TOPLEFT", TEXT_X, -ROW / 2)
					r.Text:SetWidth(max(20, width - TEXT_X - PAD - r.Link:GetWidth() - 8))
					local rh = ROW
					r.Sub:SetShown(r.psTwo and true or false)
					if r.psTwo then
						r.Sub:ClearAllPoints()
						r.Sub:SetPoint("TOPLEFT", r, "TOPLEFT", TEXT_X, -(ROW - 4))
						r.Sub:SetWidth(max(20, width - TEXT_X - PAD))
						rh = ROW - 4 + floor(r.Sub:GetStringHeight() + 0.5) + 4
					end
					r:SetHeight(rh)
					y = y + rh
				end
			end
			return y
		end,
	})
end)
