-- The dungeon kind's regions in the guide window (UI/GuideFrameRegions.lua;
-- docs/DESIGN.md, "The Guide Window"), outside the dungeon: getting there. Their
-- models: Core/KindDungeon.lua. What the Dungeons hub already says (the level range,
-- the group, the best level) and what the step list holds (every pick-up step) is not
-- repeated here.
--
--   brief     the dungeon's picture (its loading screen, Dungeons.Art; else the
--             entrance's zone painting) with its name
--   ready     one line, only while the character is under the dungeon's floor:
--             "Level 15: come back at 18"
--   (step)    the step's own header and goal rows, as the leveling view shows
--             them (GF.REGIONS' "step"): a prerequisite's accept and kills, a
--             page quest's work out in the world (Dungeons.OutsideWork)
--   entrance  the way in: its zone, the travel time, the instances this hour, a
--             key or attunement still missing; Guide me to the entrance once
--             nothing is left before the door (no pick-up, no work out in the world)
-- Compact: one line each. The regions' own rows are goal-like (24px) and painted
-- as goal rows; a skin's guideKindRow hook dresses each (info.kind "ready").
-- Every control is a button, so the gamepad's focus reaches it.

local ADDON, ns = ...
ns.UI.GuideFrame.Part(function(GF)
	local Theme, W, L = ns.Theme, ns.Widgets, ns.L
	local floor, max, format, concat = math.floor, math.max, string.format, table.concat
	local DOT = " \194\183 "
	local ROW = 24
	local ART_H = 86

	local PAD, ICON, TEXT_X = 14, 15, 39
	GF.Bind(function(_, m) PAD, ICON, TEXT_X = m.PAD, m.ICON, m.TEXT_X end)

	local function D() return ns.Dungeons end
	local function E() return GF.Engine() end
	local function model(id) return function(view, kind) local En = E(); return En and En.KindModel and En.KindModel(id, view, kind) or nil end end
	local function col(token, text) return "|c" .. Theme.Hex(token) .. tostring(text) .. "|r" end
	local function hook(row, item, info) if GF.Hook then GF.Hook("guideKindRow", row, item, info) end end

	-- A goal-like row: glyph, text, a right-hand figure, the 2px accent bar
	-- of the row the step works on, and a second line under the text.
	local function row(parent)
		local r = CreateFrame("Frame", nil, parent)
		r:SetHeight(ROW)
		r.Icon = W.Tex(r, "ARTWORK")
		r.Text = W.Text(r, "goal", "text")
		r.Right = W.Text(r, "number", "text")
		r.Right:SetJustifyH("RIGHT")
		r.Sub = W.Text(r, "small", "textMuted")
		r.Bar = W.Tex(r, "ARTWORK", nil, "accent")
		r.Bar:SetWidth(2)
		r.Bar:Hide()
		return r
	end
	-- Lays r out `width` wide from y, one line or two. -> its height
	local function place(r, parent, y, width, twoLines)
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
		local h = ROW
		r.Sub:SetShown(twoLines and true or false)
		if twoLines then
			r.Sub:ClearAllPoints()
			r.Sub:SetPoint("TOPLEFT", r, "TOPLEFT", TEXT_X, -(ROW - 4))
			r.Sub:SetWidth(max(20, width - TEXT_X - PAD))
			h = ROW - 4 + floor(r.Sub:GetStringHeight() + 0.5) + 4
		end
		r:SetHeight(h)
		r.Bar:ClearAllPoints()
		r.Bar:SetPoint("TOPLEFT", r, "TOPLEFT", 0, 0)
		r.Bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0)
		r:Show()
		return h
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
			-- The picture sits back so the name and the primary button lead: 60% desaturated (ZoneArt's own
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
	-- entrance
	---------------------------------------------------------------------------

	GF.RegisterRegion("entrance", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Needs = row(f)
			-- The way in reads as its own part: a hairline over it.
			f.Rule = W.Divider(f)
			f.Way = row(f)
			f.Go = W.Button(f, L["Guide me to the entrance"], function()
				local m = f.psModel
				local Dg = D()
				if m and Dg then Dg.GuideTo(m.key) end
			end, { primary = true, icon = "icon-goto" })
			return f
		end,
		model = function(view, kind)
			local En = E()
			local m = En and En.KindModel and En.KindModel("entrance", view, kind)
			if m then
				local b = En.KindModel("brief", view, kind)
				m.key = b and b.key
			end
			return m
		end,
		paint = function(f, m, mode)
			f.psModel = m
			glyph(f.Way, "icon-dungeon", "dungeon")
			-- "Entrance · Ashenvale": the picture above names the dungeon, not where its door is.
			f.Way.Text:SetText(m.zone and (L["Entrance"] .. DOT .. col("place", m.zone)) or L["Entrance"])
			f.Way.Right:SetText(m.eta and ns.Maps.FormatTime(m.eta) or "")
			local facts = {}
			-- The line above names the zone: here its map coordinates alone.
			if m.x and m.y then facts[1] = format("%d, %d", floor(m.x + 0.5), floor(m.y + 0.5)) end
			if m.cap then facts[#facts + 1] = format(L["instances this hour: %d of %d"], m.cap.used, m.cap.max) end
			f.Way.Sub:SetText(concat(facts, DOT))
			hook(f.Way, m, { kind = "ready", way = "entrance" })
			if m.needs then
				glyph(f.Needs, "key", "warning")
				f.Needs.Text:SetText(col("warning", format(L["Needs %s"], m.needs)))
				f.Needs.Right:SetText("")
				hook(f.Needs, m, { kind = "ready", way = "needs" })
			end
		end,
		layout = function(f, m, width, mode)
			local compact = mode == "compact"
			f.Rule:SetShown(not compact)
			local y = compact and 0 or 7
			if not compact then
				f.Rule:ClearAllPoints()
				f.Rule:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -3)
				f.Rule:SetPoint("TOPRIGHT", f, "TOPRIGHT", -PAD, -3)
			end
			f.Needs:SetShown(m.needs ~= nil and not compact)
			if m.needs and not compact then y = y + place(f.Needs, f, y, width) end
			if mode == "compact" then
				f.Go:Hide()
				return y + place(f.Way, f, y, width)
			end
			y = y + place(f.Way, f, y, width, f.Way.Sub:GetText() ~= "")
			-- Information only while quests or work out in the world are left before the door.
			if not m.go then
				f.Go:Hide()
				return y + 6
			end
			f.Go:Show()
			f.Go:ClearAllPoints()
			f.Go:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -(y + 4))
			f.Go:SetPoint("TOPRIGHT", f, "TOPRIGHT", -PAD, -(y + 4))
			return y + 4 + f.Go:GetHeight() + 8
		end,
	})
end)
