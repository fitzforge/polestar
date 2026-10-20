-- The mini talent tree on the Talents page (#496): the class's three spec
-- columns side by side, as the talent frame lays them out (Builds.lua's
-- row and column per talent, its arrows), with a plan drawn on it pick by
-- pick. A stepper above the tree walks the plan: each step forward adds the
-- next pick to the tree, each step back takes it off, so the build takes
-- shape in the order the plan spends its points.
--
--   local t = T.Tree.Create(parent)
--   T.Tree.Set(t, { data, build, valid, state, cursor, mine, onStep })
--   t:GetHeight()                -- the block's height, for the page's writer
--
-- The talent with the cursor's pick is ringed and numbered. Ranks spent
-- outside the plan (the followed plan only: state.offPlan) carry the same
-- flag as on the talent frame. On the followed plan, a rank the game has not
-- learned yet is drawn muted (ahead). Hover a talent for its spell and its picks;
-- click it to step to its last pick. The mouse wheel over the tree steps too.
-- Points can come sooner than one a level, so the level beside a pick is
-- shown as approximate, as the plan's notes are.

local ADDON, ns = ...
local Theme, W = ns.Theme, ns.Widgets
local T, L = ns.Talents, ns.L
local max, min, floor, ipairs, pairs, format = math.max, math.min, math.floor, ipairs, pairs, string.format

if not (Theme and W and T) then return end

local CELL_MIN, CELL_MAX = 20, 30 -- a talent's square, fitted to the page's width
local GAP = 10       -- between talents in a spec column
local COL_GAP = 14   -- between spec columns
local COLS = 4       -- talents across a spec column
local HEAD_H = 26    -- a spec column's name and points
local STEP_H = 34    -- the stepper pill
local STEP_W = 168
local CAPTION_H = 22 -- the cursor's pick under the stepper
local PAD = 12       -- inside a spec column's ground

local MT = {}
T.Tree = MT

-- Ranks of each talent after the plan's first n picks: node -> rank.
function MT.RanksAt(build, n)
	local ranks = {}
	for i = 1, min(n or 0, #build.picks) do
		local p = build.picks[i]
		ranks[p.node] = max(ranks[p.node] or 0, p.rank)
	end
	return ranks
end

-- The level a pick roughly lands at, one point a level from the first.
function MT.ApproxLevel(order) return order + T.FIRST_LEVEL - 1 end

-- The cursor a plan opens at: on the followed plan, its next pick (the whole
-- plan once complete); on another, the whole plan.
function MT.DefaultCursor(build, state)
	local total = #build.picks
	if not state then return total end
	if state.next then return state.next.order end
	return total
end

-- A line in a palette colour (W.Color colours textures and text only).
local function paintLine(line, color, alpha)
	line.psColor, line.psAlpha = color, alpha
	local r, g, b, a = Theme.Color(color)
	line:SetColorTexture(r, g, b, (a or 1) * (alpha or 1))
end

local function cellTip(c)
	local t = c:GetParent():GetParent()
	local n = c.psNode
	if not n then return end
	local orders = {}
	for _, p in ipairs(t.psBuild.picks) do
		if p.node == n.id then orders[#orders + 1] = p.order end
	end
	local extra
	if #orders == 1 then
		extra = format(L["Pick %d of this plan."], orders[1])
	elseif #orders > 1 then
		extra = format(L["Picks %s of this plan."], table.concat(orders, ", "))
	else
		extra = L["Not in this plan."]
	end
	if n.spell then W.SpellTip(c, n.spell, extra) else W.Tooltip(c, "ANCHOR_RIGHT", c.psName, { extra }) end
end

local function cell(t, i)
	local c = t.cells[i]
	if c then return c end
	c = CreateFrame("Button", nil, t.Grid)
	c:SetSize(t.psCell, t.psCell)
	c:SetFrameLevel(t.Grid:GetFrameLevel() + 3)
	-- The ring: the cursor's talent, past the cell's edge.
	c.Ring = c:CreateTexture(nil, "BACKGROUND", nil, -2)
	c.Ring:SetTexture(Theme.Media("white"))
	c.Ring:SetPoint("TOPLEFT", c, "TOPLEFT", -4, 4)
	c.Ring:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", 4, -4)
	c.Edge = c:CreateTexture(nil, "BACKGROUND", nil, 0)
	c.Edge:SetTexture(Theme.Media("white"))
	c.Edge:SetAllPoints(c)
	c.Well = c:CreateTexture(nil, "BORDER")
	c.Well:SetTexture(Theme.Media("white"))
	c.Well:SetPoint("TOPLEFT", c, "TOPLEFT", 2, -2)
	c.Well:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", -2, 2)
	c.Icon = c:CreateTexture(nil, "ARTWORK")
	c.Icon:SetPoint("TOPLEFT", c, "TOPLEFT", 2, -2)
	c.Icon:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", -2, 2)
	c.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	-- Rank: a small plate over the bottom-right corner.
	c.RankBack = c:CreateTexture(nil, "OVERLAY", nil, 0)
	c.RankBack:SetTexture(Theme.Media("white"))
	c.Rank = W.Text(c, "caption", "text")
	c.Rank:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", 6, -6)
	c.RankBack:SetPoint("TOPLEFT", c.Rank, "TOPLEFT", -2, 1)
	c.RankBack:SetPoint("BOTTOMRIGHT", c.Rank, "BOTTOMRIGHT", 2, -1)
	-- The cursor's pick number, over the top-left corner.
	c.Badge = c:CreateTexture(nil, "OVERLAY", nil, 0)
	c.Badge:SetTexture(Theme.Media("white"))
	c.Order = W.Text(c, "caption", "onAccent")
	c.Order:SetPoint("TOPLEFT", c, "TOPLEFT", -5, 6)
	c.Badge:SetPoint("TOPLEFT", c.Order, "TOPLEFT", -3, 1)
	c.Badge:SetPoint("BOTTOMRIGHT", c.Order, "BOTTOMRIGHT", 3, -1)
	-- Points spent outside the plan: the talent frame's flag.
	c.Flag = c:CreateTexture(nil, "OVERLAY", nil, 1)
	c.Flag:SetTexture(Theme.Media("flag"))
	c.Flag:SetSize(12, 12)
	c.Flag:SetPoint("TOPRIGHT", c, "TOPRIGHT", 5, 5)
	W.Color(c.Flag, "warning")
	c:SetScript("OnEnter", cellTip)
	c:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	c:SetScript("OnClick", function(self)
		local tt = self:GetParent():GetParent()
		local last
		for _, p in ipairs(tt.psBuild.picks) do
			if p.node == self.psNode.id then last = p.order end
		end
		if last then MT.Step(tt, last - tt.psCursor) end
	end)
	t.cells[i] = c
	return c
end

local function line(t, i)
	local l = t.lines[i]
	if l then return l end
	l = t.Wires:CreateLine(nil, "ARTWORK")
	l:SetThickness(2)
	t.lines[i] = l
	return l
end

local function specHead(t, i)
	local h = t.heads[i]
	if h then return h end
	h = CreateFrame("Frame", nil, t.Grid)
	h:SetFrameLevel(t.Grid:GetFrameLevel() + 1)
	h.Ground = W.Fill(h, "panelAlt", "BACKGROUND", -4)
	h.Name = W.Text(h, "label", "textDim")
	h.Name:SetPoint("TOPLEFT", h, "TOPLEFT", PAD, -8)
	h.Points = W.Text(h, "number", "textMuted")
	h.Points:SetJustifyH("RIGHT")
	h.Points:SetPoint("TOPRIGHT", h, "TOPRIGHT", -PAD, -8)
	h.Bar = W.Tex(h, "ARTWORK", nil, "accent")
	h.Bar:SetHeight(2)
	h.Bar:SetPoint("TOPLEFT", h, "TOPLEFT", 0, 0)
	h.Bar:SetPoint("TOPRIGHT", h, "TOPRIGHT", 0, 0)
	t.heads[i] = h
	return h
end

function MT.Create(parent)
	local t = CreateFrame("Frame", nil, parent)
	t.cells, t.lines, t.heads = {}, {}, {}
	-- The stepper: a pill with the pick count between two chevrons.
	t.Pill = CreateFrame("Frame", nil, t)
	t.Pill:SetSize(STEP_W, STEP_H)
	t.Pill:SetPoint("TOP", t, "TOP", 0, 0)
	t.Pill.Ground = W.Fill(t.Pill, "panelAlt", "BACKGROUND", -4)
	t.Pill.Edge = W.Divider(t.Pill)
	t.Pill.Edge:SetPoint("BOTTOMLEFT", t.Pill, "BOTTOMLEFT", 0, 0)
	t.Pill.Edge:SetPoint("BOTTOMRIGHT", t.Pill, "BOTTOMRIGHT", 0, 0)
	t.Prev = W.IconButton(t.Pill, "chevron-left", STEP_H - 6, L["Previous pick"], function() MT.Step(t, -1) end)
	t.Prev:SetPoint("LEFT", t.Pill, "LEFT", 3, 0)
	t.Next = W.IconButton(t.Pill, "chevron-right", STEP_H - 6, L["Next pick"], function() MT.Step(t, 1) end)
	t.Next:SetPoint("RIGHT", t.Pill, "RIGHT", -3, 0)
	t.Count = W.Text(t.Pill, "title", "text")
	t.Count:SetJustifyH("CENTER")
	t.Count:SetPoint("CENTER", t.Pill, "CENTER", 0, 0)
	t.Caption = W.Text(t, "small", "textDim")
	t.Caption:SetJustifyH("CENTER")
	t.Caption:SetPoint("TOP", t.Pill, "BOTTOM", 0, -7)
	t.Grid = CreateFrame("Frame", nil, t)
	t.Grid:SetPoint("TOP", t, "TOP", 0, -(STEP_H + CAPTION_H + 6))
	-- The arrows: over the spec columns' ground, under the talents.
	t.Wires = CreateFrame("Frame", nil, t.Grid)
	t.Wires:SetAllPoints(t.Grid)
	t.Wires:SetFrameLevel(t.Grid:GetFrameLevel() + 2)
	t:EnableMouseWheel(true)
	t:SetScript("OnMouseWheel", function(self, delta) MT.Step(self, delta > 0 and -1 or 1) end)
	return t
end

-- Move the cursor by delta picks (clamped to 0..#picks) and tell the page,
-- which redraws the tree; without a page to tell, redraw it here.
function MT.Step(t, delta)
	local b = t.psBuild
	if not b then return end
	local n = max(0, min(#b.picks, (t.psCursor or 0) + delta))
	if n == t.psCursor then return end
	t.psCursor = n
	if t.psOnStep then t.psOnStep(n) else MT.Draw(t) end
end

function MT.Set(t, o)
	t.psData, t.psBuild, t.psValid, t.psState, t.psMine, t.psOnStep = o.data, o.build, o.valid, o.state, o.mine, o.onStep
	t.psCursor = max(0, min(#o.build.picks, o.cursor or MT.DefaultCursor(o.build, o.mine and o.state or nil)))
	-- The tree's shape: its rows, from every talent in the class's tree.
	local rows = 1
	for _, n in pairs(o.data.nodes) do rows = max(rows, n.row) end
	t.psRows = rows
	local specs = #o.data.specs
	local avail = t:GetWidth() > 0 and t:GetWidth() or 400
	local cellW = floor((avail - (specs - 1) * COL_GAP - specs * (PAD * 2 + (COLS - 1) * GAP)) / (specs * COLS))
	t.psCell = max(CELL_MIN, min(CELL_MAX, cellW))
	t.psSpecW = COLS * t.psCell + (COLS - 1) * GAP
	for _, c in ipairs(t.cells) do c:SetSize(t.psCell, t.psCell) end
	local gridW = specs * (t.psSpecW + PAD * 2) + (specs - 1) * COL_GAP
	local gridH = HEAD_H + rows * t.psCell + (rows - 1) * GAP + PAD
	t.Grid:SetSize(gridW, gridH)
	t:SetHeight(STEP_H + CAPTION_H + 6 + gridH)
	t.psGridW = gridW
	MT.Draw(t)
end

-- A talent's centre on the grid, from its spec column, row and column.
local function centre(t, n)
	local cell = t.psCell
	local x = (n.spec - 1) * (t.psSpecW + PAD * 2 + COL_GAP) + PAD + (n.col - 1) * (cell + GAP) + cell / 2
	local y = HEAD_H + (n.row - 1) * (cell + GAP) + cell / 2
	return x, -y
end

function MT.Draw(t)
	local data, build, cursor = t.psData, t.psBuild, t.psCursor
	local ranks = MT.RanksAt(build, cursor)
	local pick = build.picks[cursor]
	local off = t.psMine and t.psState and t.psState.offPlan or {}
	-- The followed plan's learned ranks: a higher rank at the cursor is ahead.
	local learned = t.psMine and t.psState and t.psState.ranks
	local total = #build.picks

	t.Count:SetText(format("%d / %d", cursor, total))
	t.Prev:SetEnabled(cursor > 0)
	t.Next:SetEnabled(cursor < total)
	W.Color(t.Prev.Icon, cursor > 0 and "icon" or "textMuted", cursor > 0 and 1 or 0.4)
	W.Color(t.Next.Icon, cursor < total and "icon" or "textMuted", cursor < total and 1 or 0.4)
	if pick then
		t.Caption:SetText(format(L["%s  \194\183  around level %d"], T.PickText(data, pick, t.psValid), MT.ApproxLevel(pick.order)))
	else
		t.Caption:SetText(L["Before the first pick: step forward to spend points."])
	end

	-- Spec columns: ground, name and the points in it at the cursor.
	local points = {}
	for id, r in pairs(ranks) do
		local n = data.nodes[id]
		points[n.spec] = (points[n.spec] or 0) + r
	end
	for s, name in ipairs(data.specs) do
		local h = specHead(t, s)
		h:ClearAllPoints()
		h:SetPoint("TOPLEFT", t.Grid, "TOPLEFT", (s - 1) * (t.psSpecW + PAD * 2 + COL_GAP), 0)
		h:SetSize(t.psSpecW + PAD * 2, t.Grid:GetHeight())
		h.Name:SetText(name)
		h.Points:SetText(tostring(points[s] or 0))
		local mine = s == build.spec
		W.Color(h.Name, mine and "text" or "textDim")
		W.Color(h.Points, (points[s] or 0) > 0 and "accent" or "textMuted")
		h.Bar:SetShown(mine)
		h:Show()
	end
	for i = #data.specs + 1, #t.heads do t.heads[i]:Hide() end

	-- Arrows: dim until their target is picked; an elbow when the talents
	-- sit on different rows and columns.
	local nl = 0
	for _, e in ipairs(data.edges or {}) do
		local a, b = data.nodes[e[1]], data.nodes[e[2]]
		if a and b then
			local ax, ay = centre(t, a)
			local bx, by = centre(t, b)
			local lit = (ranks[b.id] or 0) > 0
			local color, alpha = lit and "accent" or "ink", lit and 1 or 0.3
			local legs = (ax == bx or ay == by) and { { ax, ay, bx, by } } or { { ax, ay, bx, ay }, { bx, ay, bx, by } }
			for _, g in ipairs(legs) do
				nl = nl + 1
				local l = line(t, nl)
				l:SetStartPoint("TOPLEFT", t.Grid, g[1], g[2])
				l:SetEndPoint("TOPLEFT", t.Grid, g[3], g[4])
				paintLine(l, color, alpha)
				l:Show()
			end
		end
	end
	for i = nl + 1, #t.lines do t.lines[i]:Hide() end

	-- Talents, in a stable order.
	local ids = {}
	for id in pairs(data.nodes) do ids[#ids + 1] = id end
	table.sort(ids)
	local nc, na = 0, 0
	for _, id in ipairs(ids) do
		local n = data.nodes[id]
		nc = nc + 1
		local c = cell(t, nc)
		c.psNode = n
		c.psName = T.NodeName(data, id, t.psValid)
		local x, y = centre(t, n)
		c:ClearAllPoints()
		c:SetPoint("CENTER", t.Grid, "TOPLEFT", x, y)
		local r = ranks[id] or 0
		local ahead = learned and r > (learned[id] or 0) or false
		c.psAhead = ahead
		if ahead then na = na + 1 end
		local isCursor = pick and pick.node == id
		local icon = ns.Compat and ns.Compat.SpellIcon and ns.Compat.SpellIcon(n.spell)
		c.Icon:SetTexture(icon or Theme.Media("white"))
		if not icon then W.Color(c.Icon, "ink", 0.06) else W.Uncolor(c.Icon); c.Icon:SetVertexColor(1, 1, 1, 1) end
		c.Icon:SetDesaturated(r == 0)
		c.Icon:SetAlpha(r > 0 and (ahead and 0.6 or 1) or 0.35)
		W.Color(c.Well, "shade", 0.6)
		-- The edge: ahead muted, full ranks gold, part ranks green, none a faint hairline.
		if ahead then W.Color(c.Edge, "textMuted")
		elseif r >= n.max then W.Color(c.Edge, "accent")
		elseif r > 0 then W.Color(c.Edge, "success")
		else W.Color(c.Edge, "ink", 0.14) end
		c.Ring:SetShown(isCursor or false)
		if isCursor then W.Color(c.Ring, "accent", 0.55) end
		c.Rank:SetShown(r > 0)
		c.RankBack:SetShown(r > 0)
		if r > 0 then
			c.Rank:SetText(format("%d/%d", r, n.max))
			W.Color(c.Rank, ahead and "textMuted" or (r >= n.max and "accent" or "success"))
			W.Color(c.RankBack, "shade", 0.85)
		end
		c.Order:SetShown(isCursor or false)
		c.Badge:SetShown(isCursor or false)
		if isCursor then
			c.Order:SetText(tostring(pick.order))
			W.Color(c.Badge, "accent")
		end
		c.Flag:SetShown((off[id] or 0) > 0)
		c:Show()
	end
	for i = nc + 1, #t.cells do t.cells[i]:Hide() end
	t.psShown = { cursor = cursor, total = total, picked = MT.Count(ranks), lines = nl, cells = nc, points = points, ahead = na }
end

function MT.Count(ranks)
	local n = 0
	for _, r in pairs(ranks) do n = n + r end
	return n
end
