-- The dungeon kind's regions in the guide window (UI/GuideFrameRegions.lua;
-- docs/DESIGN.md, "The Guide Window"), outside the dungeon: getting ready and
-- getting there. Their models: Core/KindDungeon.lua.
--
--   brief     the dungeon's picture (its loading screen, Dungeons.Art; else the
--             entrance's zone painting) with its name, then the range chip
--             ("17–24 · your level"), "Group of 5" and the zone
--   ready     the level against the floor and the best level, the group
--   (step)    the step's own header and goal rows, as the leveling view shows
--             them (GF.REGIONS' "step"): a prerequisite's accept and kills, a
--             page quest's work out in the world (Dungeons.OutsideWork)
--   pickups   one row, "Quests for the run 1 / 4" and the Journey row's chevron, folded: the quests of the whole
--             run are the overview, and the step above shows only the stop's own. A
--             click (the gamepad's A) opens it (Dungeons.PickupsOpen: kept for the
--             character and the dungeon until the run ends, as the Journey row keeps
--             its own): one entry per quest not in the log, each the leveling view's
--             goal row (GF.NewGoalRow, its tick box: a quest the step took stays,
--             ticked, until the step moves on), the giver and where under it (on your
--             way, N min off the route, or the prerequisite it waits on: "After
--             “Rear Guard Patrol” · Chain: 1 of 2"); a click points the arrow at the
--             giver as a goal row's does. Open, they stand for the step's accepts. Pick
--             them up (the dungeon's pick-up guide in a tab) and Skip the far one
--             (Dungeons.SkipFar: over Dungeons.PICKUP_DETOUR minutes off the way) are
--             in the open list
--   entrance  the way in: its zone, the travel time, the instances this hour, a
--             key or attunement still missing; Guide me to the entrance once
--             nothing is left before the door (no pick-up, no work out in the world)
-- Compact: one line each (the pick-ups' row alone, no fold). The regions' own rows
-- are goal-like (24px) and painted as goal rows; a skin's guideKindRow hook
-- dresses each (info.kind "ready" | "pickup"), its guideRow hook the entries.
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
	local function row(parent, button)
		local r = CreateFrame(button and "Button" or "Frame", nil, parent)
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
	-- Lays r out `width` wide from y, one line or two, `extra` room kept at its right edge (a
	-- fold row's chevron). -> its height
	local function place(r, parent, y, width, twoLines, extra)
		extra = extra or 0
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -y)
		r:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, -y)
		r.Icon:SetSize(ICON, ICON)
		r.Icon:ClearAllPoints()
		r.Icon:SetPoint("CENTER", r, "TOPLEFT", PAD + ICON / 2, -ROW / 2)
		r.Right:ClearAllPoints()
		r.Right:SetPoint("RIGHT", r, "TOPRIGHT", -(PAD + extra), -ROW / 2)
		local rw = r.Right:GetText() and r.Right:GetText() ~= "" and floor(r.Right:GetStringWidth() + 0.5) + 8 or 0
		r.Text:ClearAllPoints()
		r.Text:SetPoint("LEFT", r, "TOPLEFT", TEXT_X, -ROW / 2)
		r.Text:SetWidth(max(20, width - TEXT_X - PAD - extra - rw))
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
			-- The picture sits back so the chip and the primary button lead: 60% desaturated (ZoneArt's own
			-- 20% leaves a loading screen loud) and a deep fade under the name.
			f.Art = ZA.Create(f, 300, ART_H, "bg", 0.9)
			f.Art.psDesat = 0.6
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

	-- A pick-up entry's sub-line round its place: what comes before the name, the name (the part that is
	-- cut to fit), what follows it ("on your way", the minutes off the route, the prerequisite it waits
	-- on: never cut), and the line without the name for a window too narrow for any of it.
	local function whereParts(q)
		if q.after then
			-- "After “Rear Guard Patrol” · Chain: 1 of 2": the title gives way, the chain's count stays.
			local a = q.after
			local chain = (a.of or 0) > 1 and format(L["Chain: %d of %d"], a.n, a.of) or nil
			local pre, post = format(L["After %s"], "\1"):match("^(.-)\1(.*)$")
			return pre or "", ns.Quoted(a.title) or a.title, (post or "") .. (chain and (DOT .. chain) or ""), chain
		elseif q.onWay then
			if not q.where then return "", nil, L["on your way"] end
			local a, b = format(L["%s, on your way"], "\1"):match("^(.-)\1(.*)$")
			return a or "", q.where, b or "", L["on your way"]
		elseif q.minutesOff then
			local tail = format(L["%s off route"], minutes(q.minutesOff))
			if q.where then return "", q.where, DOT .. tail, tail end
			return "", nil, tail
		end
		return "", q.where, ""
	end
	local function composeSub(r, place, bare)
		local s = bare or (r.psPre .. (place or "") .. r.psPost)
		if s == "" then return r.psNpc or "" end
		s = col("textMuted", s)
		return r.psNpc and (r.psNpc .. DOT .. s) or s
	end
	-- One line: the place gives way with "..." where the row is narrow (to four letters at least, else it
	-- goes), the minutes stay.
	local MIN_PLACE = 4
	local function fitSub(r, avail)
		r.Sub:SetText(composeSub(r, r.psPlace))
		if not r.psPlace or W.TextWidth(r.Sub) <= avail then return end
		local chars = {}
		for ch in r.psPlace:gmatch("[%z\1-\127\194-\244][\128-\191]*") do chars[#chars + 1] = ch end
		for n = #chars - 1, MIN_PLACE, -1 do
			r.Sub:SetText(composeSub(r, concat(chars, "", 1, n) .. "..."))
			if W.TextWidth(r.Sub) <= avail then return end
		end
		r.Sub:SetText(composeSub(r, nil, r.psBare))
	end

	-- An entry's goal view: the step's own accept of it (the pick-up guide's stop), else one in the
	-- same fields (the Engine's words, quest name quoted), ticked once the quest is in the log, its
	-- place the one a click points the arrow at. Its tick box shows the state; a click on it does nothing
	-- (no goal of the step to tick).
	local function entryGoal(q)
		if q.gv then return q.gv, false end
		local p = q.point
		return { t = "accept", quest = q.quest, title = q.title, text = L["Accept"] .. " " .. (ns.Quoted(q.title) or q.title or ""),
			verb = L["Accept"], subject = q.title, subjectKind = "quest", status = q.held and "done" or "pending", tickable = true,
			map = p and p.map, x = p and p.x, y = p and p.y, f = p and p.f, z = p and p.z }, true
	end

	-- The Journey row's chevron: 12px, up while open.
	local CHEVRON = 12
	-- Opens or folds the list (the row's click, the gamepad's A): kept for the dungeon, per character.
	local function toggle(f)
		local m = f.psModel
		local Dg = D()
		if not (m and Dg and f.psFold) then return end
		Dg.SetPickupsOpen(m.plan.dungeon.key, not m.open)
		GF.Update()
	end

	GF.RegisterRegion("pickups", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			-- The fold row: the Journey row's expander (UI/JourneyPanel.lua): a hover wash, the chevron
			-- at the right, its tooltip "Click to expand" / "Click to collapse".
			local h = row(f, true)
			f.Head = h
			W.Hover(h, 0.7)
			h.Chevron = W.Tex(h, "ARTWORK", nil, "textMuted")
			h.Chevron:SetSize(CHEVRON, CHEVRON)
			h.Chevron:SetPoint("RIGHT", h, "TOPRIGHT", -PAD, -ROW / 2)
			h:SetScript("OnClick", function() toggle(f) end)
			h:SetScript("OnEnter", function(self)
				if not f.psFold then return end
				W.Color(self.Chevron, "text")
				local m = f.psModel
				W.Tooltip(self, GF.TooltipAnchor and GF.TooltipAnchor() or "ANCHOR_RIGHT", L["Quests for the run"],
					{ m and m.open and L["Click to collapse"] or L["Click to expand"] })
				if GF.HoverIn then GF.HoverIn() end
			end)
			h:SetScript("OnLeave", function(self)
				W.Color(self.Chevron, "textMuted")
				W.HideTooltip(self)
			end)
			f.Rows = {}
			f.Pick = W.Button(f, L["Pick them up"], function() local m = f.psModel; if m then openPickup(m.plan.dungeon.key) end end, { height = 24 })
			f.Skip = plainLink(f, L["Skip the far one"], function() skipFar(f) end)
			f.Back = plainLink(f, "", function() unskip(f) end)
			-- Its heading where a layout puts it on a card (guidePlace "pickups"; Atlas).
			f.psCardHead = L["Quests for the run"]
			return f
		end,
		-- Compact folds it: the step keeps its own rows under the one line.
		model = function(view, kind)
			local m = model("pickups")(view, kind)
			if m and GF.Compact() then m.open, m.covers = false, {} end
			return m
		end,
		paint = function(f, m, mode)
			f.psModel = m
			local left = m.total - m.held
			local h = f.Head
			-- "Quests for the run 1 / 4": the one row, folded until it is opened; compact has the line
			-- alone. No quest to take: a plain line, nothing to open.
			f.psFold = m.total > 0 and mode ~= "compact"
			if m.total > 0 then
				glyph(h, left > 0 and "icon-accept" or "check", left > 0 and "quest" or "success")
				h.Text:SetText(L["Quests for the run"])
			else
				glyph(h, "icon-accept", "textMuted")
				h.Text:SetText(m.waiting > 0 and format(L["Quests open at a later level: %d"], m.waiting) or L["No quests to pick up"])
			end
			h.Right:SetText(m.total > 0 and format("%d / %d", m.held, m.total) or "")
			h:SetEnabled(f.psFold)
			h:EnableMouse(f.psFold)
			h.Chevron:SetShown(f.psFold)
			if f.psFold then h.Chevron:SetTexture(Theme.Media(m.open and "chevron-up" or "chevron-down")) end
			-- Open, the list stands for the step's accepts: the step works on this region while quests are left.
			h.Bar:SetShown(m.open and left > 0)
			hook(h, m, { kind = "pickup", current = m.open and left > 0, done = left == 0 and m.total > 0 })
			-- The entries are the leveling view's goal rows (GF.NewGoalRow): the ones the step took,
			-- ticked, then those still to pick up; the step's first open accept is the arrow's.
			-- Only while the row is open.
			local list = {}
			if m.open and mode ~= "compact" then
				for _, q in ipairs(m.taken or {}) do list[#list + 1] = q end
				for _, q in ipairs(m.missing) do list[#list + 1] = q end
			end
			local lit = false
			for i, q in ipairs(list) do
				local r = f.Rows[i]
				if not r then
					r = GF.NewGoalRow(f)
					-- The giver and where: one line (the place is cut for the minutes, fitSub).
					r.Sub:SetWordWrap(false)
					f.Rows[i] = r
				end
				local goal, own = entryGoal(q)
				local current = not lit and q.gv ~= nil and goal.status ~= "done" and goal.status ~= "skipped"
				if current then lit = true end
				GF.PaintGoalRow(r, goal, current)
				if own then r.Check:Disable() end
				if not q.held then
					local pre, place, post, bare = whereParts(q)
					r.psNpc, r.psPre, r.psPlace, r.psPost, r.psBare = q.npc and col("npc", q.npc) or nil, pre, place, post, bare
					r.Sub:SetText(composeSub(r, place))
					r.Sub:SetShown(true)
				end
				r.psEntry = not q.held
			end
			f.psRows = #list
			for i = f.psRows + 1, #f.Rows do f.Rows[i]:Hide() end
			W.SetLinkText(f.Back, m.skipped > 0 and format(L["Bring back the far ones (%d)"], m.skipped) or "")
		end,
		layout = function(f, m, width, mode)
			local y = place(f.Head, f, 0, width, false, f.psFold and (CHEVRON + 8) or 0)
			local compact = mode == "compact"
			for i = 1, f.psRows or 0 do
				local r = f.Rows[i]
				local h = GF.MeasureRow(r, width)
				if r.psEntry then
					fitSub(r, r.Sub:GetWidth())
					h = GF.MeasureRow(r, width)
				end
				r:SetHeight(h)
				r:ClearAllPoints()
				r:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -y)
				r:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -y)
				r:Show()
				y = y + h
			end
			local open = m.open and not compact
			local pick = open and not m.inGuide and #m.missing > 0
			local skip = open and m.far > 0
			local back = open and m.skipped > 0 and not skip
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
				local apart = false
				if link then
					link:ClearAllPoints()
					-- Beside the button; under it, right-aligned, where the two would touch (a narrow window).
					apart = pick and TEXT_X + f.Pick:GetWidth() + 12 + link:GetWidth() > width - PAD
					link:SetPoint("RIGHT", f, "TOPRIGHT", -PAD, -(y + (apart and 24 + 4 + 9 or 12)))
				end
				y = y + 24 + 6 + (apart and 22 or 0)
			elseif (f.psRows or 0) > 0 then
				-- The last entry's sub-line stands clear of the way in's hairline.
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
				-- The brief's zone chip names it already.
				m.briefZone = b and b.zone
			end
			return m
		end,
		paint = function(f, m, mode)
			f.psModel = m
			glyph(f.Way, "icon-dungeon", "dungeon")
			-- "Entrance", with its zone only where that is not the one the brief above names.
			local zone = m.zone ~= nil and m.zone ~= m.briefZone and m.zone or nil
			f.Way.Text:SetText(zone and (L["Entrance"] .. DOT .. col("place", zone)) or L["Entrance"])
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
