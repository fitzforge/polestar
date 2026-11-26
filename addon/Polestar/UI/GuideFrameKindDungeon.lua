-- The dungeon kind's regions in the guide window (UI/GuideFrameRegions.lua;
-- docs/DESIGN.md, "The Guide Window"), outside the dungeon: getting ready and
-- getting there. Their models: Core/KindDungeon.lua.
--
--   brief     the dungeon's picture (its loading screen, Dungeons.Art; else the
--             entrance's zone painting) with its name, then the range chip
--             ("17–24 · your level"), "Group of 5" and the zone
--   ready     the level against the floor and the best level, the group
--   pickups   "Pick up 2 more quests 4 / 6", one entry per quest not in the log
--             (on your way, or N min off the route), Pick them up (the
--             dungeon's pick-up guide in a tab) and Skip the far one
--             (Dungeons.SkipFar: over Dungeons.PICKUP_DETOUR minutes off the way)
--   entrance  the way in: its zone, the travel time, the instances this hour, a
--             key or attunement still missing, Guide me to the entrance
-- Compact: one line each. Rows are goal-like (24px) and painted as goal rows;
-- a skin's guideKindRow hook dresses each (info.kind "ready" | "pickup").
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
	local function minutes(m) return format(L["%d min"], m) end

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
			f.Art = ZA.Create(f, 300, ART_H, "bg", 0.7)
			f.Art.psDesat = 0.2
			f.Art:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
			f.Name = W.Text(f.Art.Over, "display", "text")
			Theme.SetShadow(f.Name, true)
			f.Range = W.Chip(f)
			f.Facts = W.Text(f, "label", "textDim")
			-- Compact: one line.
			f.Line = row(f)
			return f
		end,
		model = model("brief"),
		paint = function(f, m, mode)
			local lv = ns.UI.LevelRange(m.lo, m.hi) or ""
			local level = ns.Lookup and ns.Lookup.PlayerInfo().level or 0
			local yours = m.lo and m.hi and level >= m.lo and level <= m.hi
			f.psYours, f.psRangeText = yours, lv
			local facts = { col("dungeon", format(L["Group of %d"], m.players or 5)) }
			if m.zone then facts[#facts + 1] = col("place", m.zone) end
			f.Facts:SetText(concat(facts, DOT))
			f.Name:SetText(m.name)
			if mode == "compact" then
				glyph(f.Line, "icon-dungeon", "dungeon")
				f.Line.Text:SetText(m.name)
				f.Line.Right:SetText(col(yours and "accent" or "textDim", lv))
				hook(f.Line, m, { kind = "ready", current = false })
			else
				W.SetChip(f.Range, yours and format(L["%s · your level"], lv) or lv, yours and "accent" or nil)
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
			f.Range:SetShown(not compact)
			f.Facts:SetShown(not compact)
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
			local y = ART_H + 8
			f.Range:ClearAllPoints()
			f.Range:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -y)
			f.Facts:ClearAllPoints()
			f.Facts:SetPoint("LEFT", f.Range, "RIGHT", 8, 0)
			f.Facts:SetWidth(max(20, width - 2 * PAD - f.Range:GetWidth() - 8))
			return y + W.CHIP_H + 6
		end,
	})

	---------------------------------------------------------------------------
	-- ready
	---------------------------------------------------------------------------

	GF.RegisterRegion("ready", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Level, f.Group = row(f), row(f)
			return f
		end,
		model = model("ready"),
		paint = function(f, m, mode)
			local g = m.group
			local alone = not g or g.n == 0
			if mode == "compact" then
				glyph(f.Group, "icon-group", "textDim")
				local grp = alone and L["Group: none yet"] or format(L["Group %d/%d"], g.n, g.max)
				f.Group.Text:SetText(grp .. DOT .. format(L["level %d"], m.level))
				f.Group.Right:SetText(m.under and col("warning", format(L["from %d"], m.floor)) or (m.best and col("textDim", format(L["best %d"], m.best)) or ""))
				hook(f.Group, m, { kind = "ready" })
				return
			end
			if m.under then
				glyph(f.Level, "icon-level", "warning")
				f.Level.Text:SetText(col("warning", format(L["Level %d: come back at %d"], m.level, m.floor)))
			else
				glyph(f.Level, "check", "success")
				f.Level.Text:SetText(m.best and format(L["Level %d · best at %d"], m.level, m.best) or format(L["Level %d"], m.level))
			end
			f.Level.Right:SetText("")
			hook(f.Level, m, { kind = "ready", done = not m.under })
			glyph(f.Group, "icon-group", "textDim")
			f.Group.Text:SetText(alone and L["Group: none yet"] or format(L["Group %d of %d"], g.n, g.max))
			f.Group.Right:SetText(col("textMuted", concat(g and g.names or {}, ", ")))
			-- Short of a full group: where to find one, as the way in's row says it (UI.FinderLine).
			local finder = ns.UI.FinderLine and ns.UI.FinderLine({ entrance = true }) or nil
			f.Group.Sub:SetText(finder or "")
			f.psFinder = finder ~= nil
			hook(f.Group, m, { kind = "ready", done = not alone and g.n >= g.max })
		end,
		layout = function(f, m, width, mode)
			if mode == "compact" then
				f.Level:Hide()
				return place(f.Group, f, 0, width)
			end
			local y = place(f.Level, f, 0, width)
			return y + place(f.Group, f, y, width, f.psFinder)
		end,
	})

	---------------------------------------------------------------------------
	-- pickups
	---------------------------------------------------------------------------

	local function openPickup(key)
		local Dg = D()
		if Dg and Dg.PickUp then Dg.PickUp(key) end
	end
	local function skipFar(f)
		local m = f.psModel
		local Dg = D()
		if not (m and Dg) then return end
		if Dg.SkipFar(m.plan) > 0 and m.inGuide then openPickup(m.plan.dungeon.key) end
	end
	local function unskip(f)
		local m = f.psModel
		local Dg = D()
		if not (m and Dg) then return end
		Dg.Unskip(m.plan.dungeon.key)
		if m.inGuide then openPickup(m.plan.dungeon.key) end
	end
	local function plainLink(parent, text, fn)
		local b = W.Link(parent, text, fn)
		b.psTip = nil
		return b
	end

	GF.RegisterRegion("pickups", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.Head = row(f)
			f.Rows = {}
			f.Pick = W.Button(f, L["Pick them up"], function() local m = f.psModel; if m then openPickup(m.plan.dungeon.key) end end, { height = 24 })
			f.Skip = plainLink(f, L["Skip the far one"], function() skipFar(f) end)
			f.Back = plainLink(f, "", function() unskip(f) end)
			-- Its heading where a layout puts it on a card (guidePlace "pickups"; Atlas).
			f.psCardHead = L["Quests to pick up"]
			return f
		end,
		model = model("pickups"),
		paint = function(f, m, mode)
			f.psModel = m
			local left = m.total - m.held
			local h = f.Head
			if left > 0 then
				glyph(h, "icon-accept", "quest")
				h.Text:SetText(left == 1 and L["Pick up 1 more quest"] or format(L["Pick up %d more quests"], left))
			elseif m.total > 0 then
				glyph(h, "check", "success")
				h.Text:SetText(m.total == 1 and L["Its quest is in your log"] or format(L["All %d quests are in your log"], m.total))
			else
				glyph(h, "icon-accept", "textMuted")
				h.Text:SetText(m.waiting > 0 and format(L["Quests open at a later level: %d"], m.waiting) or L["No quests to pick up"])
			end
			h.Right:SetText(m.total > 0 and format("%d / %d", m.held, m.total) or "")
			-- The step works on this region while quests are left (the pick-up guide's accepts).
			h.Bar:SetShown(left > 0)
			hook(h, m, { kind = "pickup", current = left > 0, done = left == 0 and m.total > 0 })
			-- Compact lists no entries: the head line says it.
			local list = mode ~= "compact" and m.missing or {}
			for i, q in ipairs(list) do
				local r = f.Rows[i]
				if not r then
					r = row(f)
					r.Icon:Hide()
					-- The giver and how far off the way: a second line where a language needs it, never cut.
					r.Sub:SetWordWrap(true)
					f.Rows[i] = r
				end
				Theme.Font(r.Text, "body")
				r.Text:SetText(col("quest", q.title or ""))
				local where
				if q.onWay then
					where = q.where and format(L["%s, on your way"], q.where) or L["on your way"]
				elseif q.minutesOff then
					where = (q.where and (q.where .. DOT) or "") .. format(L["%s off route"], minutes(q.minutesOff))
				else
					where = q.where
				end
				local parts = {}
				if q.npc then parts[1] = col("npc", q.npc) end
				if where then parts[#parts + 1] = col("textMuted", where) end
				r.Sub:SetText(concat(parts, DOT))
				r.Bar:SetShown(q.current and true or false)
				hook(r, q, { kind = "pickup", current = q.current, way = q.onWay and "onWay" or (q.far and "far") or nil })
			end
			f.psRows = #list
			for i = f.psRows + 1, #f.Rows do f.Rows[i]:Hide() end
			W.SetLinkText(f.Back, m.skipped > 0 and format(L["Bring back the far ones (%d)"], m.skipped) or "")
		end,
		layout = function(f, m, width, mode)
			local y = place(f.Head, f, 0, width)
			local compact = mode == "compact"
			for i = 1, f.psRows or 0 do
				local r = f.Rows[i]
				-- The quest's own line as the row's first, the giver and where under it.
				y = y + place(r, f, y, width, true) - 2
			end
			local pick = not compact and not m.inGuide and #m.missing > 0
			local skip = not compact and m.far > 0
			local back = not compact and m.skipped > 0 and not skip
			f.Pick:SetShown(pick)
			f.Skip:SetShown(skip)
			f.Back:SetShown(back)
			if pick or skip or back then
				y = y + 4
				if pick then
					f.Pick:ClearAllPoints()
					f.Pick:SetPoint("TOPLEFT", f, "TOPLEFT", TEXT_X, -y)
				end
				local link = skip and f.Skip or (back and f.Back) or nil
				if link then
					link:ClearAllPoints()
					link:SetPoint("RIGHT", f, "TOPRIGHT", -PAD, -(y + 12))
				end
				y = y + 24 + 6
			elseif (f.psRows or 0) > 0 then
				-- The last entry's second line stands clear of the way in's hairline.
				y = y + 6
			end
			return y
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
			f.Go:Show()
			f.Go:ClearAllPoints()
			f.Go:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -(y + 4))
			f.Go:SetPoint("TOPRIGHT", f, "TOPRIGHT", -PAD, -(y + 4))
			return y + 4 + f.Go:GetHeight() + 8
		end,
	})
end)
