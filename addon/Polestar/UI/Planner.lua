-- The Guide Planner: the selected guide as a timeline in the guide menu's
-- middle pane, in place of the guide list, with its details still beside it.
-- Opened by the details' "Guide Planner" button (UI/Picker.lua); the same
-- button, the back arrow, a category, a tab or a search go back to the list.
--
--   ‹  ▂▂▂▂▂▂▂█▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂            the steps, one cell each: a click jumps
--   ────────────────────────────────────────
--   ✓  Steps 1-6   6 done                Show    finished steps, folded
--   ◉  You are here · Step 7 ─────────────
--   ⑦  Sen'jin Village                 Durotar
--        [x] Accept "A Solvent Spirit"           a quest's tick: in your route
--        [ ] Accept "Practical Prey"    Hidden   left out by you
--            Turn in "Report to Sen'jin"
--   ⑧  Echo Isles
--            Accept "Zalazane"    Needs "Practical Prey"
--   ★  Durotar                                   the end, and the guide after it
--
-- A spine runs down the left with a node per step (its number; a check once
-- done; the accent on the live step) and the marker where the character
-- stands: "You are here" in an open guide, "You start here" in one that is
-- not (Engine.PlanOf reads it as if loaded now). Under a step, a line per
-- goal, worded as the step card words it (UI.GoalLine), notes left out.
--
-- Planning: a quest's first line (its accept, else where the guide first
-- has it) carries a tick. Clearing it hides the quest for this character
-- (Engine.SkipQuest, the guide window's "Skip this quest": the same saved
-- state, in every guide), and the route follows: the quest's other lines go,
-- the quests that need it go with it, each keeping one muted line that says
-- which quest it needs, and a step with nothing left goes whole. Setting the
-- tick brings it all back. The route's order is Forge's and stays as it is:
-- a walk made only for a hidden quest stays.
--
-- The list is virtual: PL.Model lays every row out (fixed heights) and only
-- the rows in view get frames (paintVisible, on scroll).

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, ipairs, pairs, type = math.floor, math.max, math.min, ipairs, pairs, type

local PL = { open = false, expanded = {}, pool = {}, cells = {} }
UI.Planner = PL

local SH = W.SHELL
local DOT = "  \194\183  "
local NODE = 22 -- a node on the spine
local NODE_GAP = 12 -- from a node to its text and cards
local RIGHT = 22 -- from a card's right edge to the pane's
local TOP = 14 -- above the first row
local FOLD_H, HERE_H, STEP_H, GOAL_H, END_H = 40, 46, 34, 28, 60
local CARD_H = GOAL_H - 2
local STEP_GAP = 8 -- under a step's last line
local CHECK, GLYPH = 18, 13
local STRIP_H, STRIP_LIVE = 6, 14 -- a cell of the strip; the live step's

---------------------------------------------------------------------------
-- The model
---------------------------------------------------------------------------

-- How a goal reads in the plan: "done"; "hidden" (its quest left out by the
-- player); "out" (left out with a hidden quest it needs); "off" (skipped
-- or closed some other way); else "open".
local function classOf(gv)
	if gv.status == "done" then return "done" end
	if gv.unavailable == "skipped" then return "hidden" end
	if gv.status == "skipped" then return gv.skippedWith and "out" or "off" end
	return "open"
end

local function listed(gv)
	return gv.status ~= "na" and not gv.folded and gv.t ~= "note"
end

-- The guide after this one, "Title (lo-hi)", or nil.
local function nextTitle(id)
	local G = ns.Guides
	local g = G and G.Get and G.Get(id)
	local n = g and type(g.next) == "string" and G.Get(g.next)
	if not n then return nil end
	local lv = UI.LevelRange(n.minLevel, n.maxLevel)
	return (n.title or n.id) .. (lv and (" (" .. lv .. ")") or "")
end

-- plan (Engine.PlanOf) as rows top to bottom, each { kind, y, h, ... }:
--   fold  { key, from, to, done, skipped }       a run of finished steps
--   here  { number, started }                    where the character stands
--   step  { view, state, zone }                  state: past | current | upcoming | removed
--   goal  { view, goal, class, quest, toggle, state, tag }
--   end   { next }
-- `expanded`: { [fold key] = true } for the folds opened. Also the strip's
-- cells ({ index, number, title, state, row }), the quest counts ({ quests,
-- hidden, out, list = the hidden quests }) and the content height.
function PL.Model(plan, expanded)
	expanded = expanded or {}
	-- Each quest's line that carries its tick, and whether work of it is left;
	-- the turn-ins still to come, each quest once, `gone` for one left out.
	-- The tick is on the quest's accept, else on its first line, and ahead
	-- of the character when it can be: a quest taken some steps ago is
	-- hidden from its next line, not from a step folded away behind.
	-- `left`: "hidden" or "out" for a quest that is not in the route (a quest
	-- in the log keeps its accept "done" when hidden: its other goals say so).
	local first, accept, open, left = {}, {}, {}, {}
	local firstAhead, acceptAhead = {}, {}
	local turnins, handed = {}, {}
	for _, v in ipairs(plan.steps) do
		local ahead = v.status ~= "done" and v.status ~= "skipped"
		for _, gv in ipairs(v.goals) do
			if listed(gv) then
				local r = UI.ReadingGoal(v, gv)
				local q = r.quest
				if q then
					first[q] = first[q] or gv
					if r.t == "accept" then accept[q] = accept[q] or gv end
					if ahead then
						firstAhead[q] = firstAhead[q] or gv
						if r.t == "accept" then acceptAhead[q] = acceptAhead[q] or gv end
					end
					if gv.status ~= "done" then open[q] = true end
					local c = classOf(gv)
					if c == "hidden" or (c == "out" and not left[q]) then left[q] = c end
					if r.t == "turnin" and gv.status ~= "done" and not handed[q] then
						handed[q] = true
						turnins[#turnins + 1] = { quest = q, gone = c == "hidden" or c == "out" }
					end
				end
			end
		end
	end
	local counts = { quests = 0, hidden = 0, out = 0, list = {} }
	local anchor = {}
	for q, gv in pairs(first) do
		anchor[q] = acceptAhead[q] or firstAhead[q] or accept[q] or gv
		local c = left[q]
		if c == "hidden" then
			counts.hidden = counts.hidden + 1
			counts.list[#counts.list + 1] = q
		elseif c == "out" then
			counts.out = counts.out + 1
		else
			counts.quests = counts.quests + 1
		end
	end
	table.sort(counts.list)

	-- The steps with what is left of each.
	local blocks = {}
	for _, v in ipairs(plan.steps) do
		local lines, live, removed, zone = {}, 0, 0, nil
		for _, gv in ipairs(v.goals) do
			if listed(gv) then
				local r = UI.ReadingGoal(v, gv)
				local q = r.quest
				-- A quest that is left out has one line, which says so.
				local gone = q ~= nil and left[q] ~= nil
				local c = gone and left[q] or classOf(gv)
				zone = zone or gv.map
				if not gone or anchor[q] == gv then
					local mine = q ~= nil and anchor[q] == gv
					lines[#lines + 1] = {
						kind = "goal", view = v, goal = r, class = c, quest = q,
						toggle = mine and open[q] == true and (c == "open" or c == "done" or c == "hidden"),
						-- The quest's own line, when its wording does not name it.
						names = mine and open[q] == true and r.t ~= "accept" and r.t ~= "turnin" and gv.questTitle or nil,
					}
					if gone then removed = removed + 1 else live = live + 1 end
				end
			end
		end
		if #lines > 0 then
			local past = v.status == "done" or v.status == "skipped"
			local state = (v.status == "current" and "current") or (past and "past") or (live == 0 and "removed") or "upcoming"
			blocks[#blocks + 1] = { view = v, lines = lines, state = state, zone = zone, fold = past and removed == 0 }
		end
	end

	local rows, cells, y = {}, {}, TOP
	local function push(row, h)
		row.y, row.h = y, h
		rows[#rows + 1] = row
		y = y + h
		return row
	end
	local here, lastZone
	local function block(b)
		local v = b.view
		if b.state == "current" then
			here = push({ kind = "here", number = v.number, started = plan.tab ~= nil }, HERE_H)
		end
		local zone = b.zone and UI.MapName(b.zone) or nil
		local head = push({ kind = "step", view = v, state = b.state, zone = zone ~= lastZone and zone or nil }, STEP_H)
		lastZone = zone or lastZone
		for _, line in ipairs(b.lines) do
			line.state = b.state
			push(line, GOAL_H)
		end
		y = y + STEP_GAP
		cells[#cells + 1] = { index = v.index, number = v.number, title = v.title, state = b.state, row = head }
	end
	local i, n = 1, #blocks
	while i <= n do
		local j = i
		while j <= n and blocks[j].fold do j = j + 1 end
		local key = blocks[i].view.index
		if j - i >= 2 and not expanded[key] then
			local fold = { kind = "fold", key = key, from = blocks[i].view.number, to = blocks[j - 1].view.number, done = 0, skipped = 0 }
			for k = i, j - 1 do
				local v = blocks[k].view
				if v.status == "done" then fold.done = fold.done + 1 else fold.skipped = fold.skipped + 1 end
				cells[#cells + 1] = { index = v.index, number = v.number, title = v.title, state = "past", row = fold, fold = key }
			end
			push(fold, FOLD_H)
			lastZone = nil
			i = j
		else
			block(blocks[i])
			i = i + 1
		end
	end
	push({ kind = "end", next = nextTitle(plan.id), complete = plan.at == nil }, END_H)
	return { rows = rows, cells = cells, counts = counts, turnins = turnins, height = y + 8, here = here }
end

-- What the quests left out of model m are worth to this character, in
-- levels of quest XP: the guide's turn-ins still to come with and without
-- them (Levels.Run, as the guide menu's levels chip sums them). nil without
-- the Codex, or when it comes to less than a twentieth of a level.
function PL.LevelsOut(g, m)
	local Lv, Cx = ns.Levels, ns.Codex
	if not (Lv and Lv.Run and Lv.Player and Cx and Cx.Quest and Cx.IsLoaded and Cx.IsLoaded()) then return nil end
	local all, kept, any = {}, {}, false
	for _, t in ipairs(m.turnins) do
		local rec = Cx.Quest(t.quest)
		local e = { id = t.quest, level = rec and rec.level, xp = rec and rec.xp }
		all[#all + 1] = e
		if t.gone then any = true else kept[#kept + 1] = e end
	end
	if not any then return nil end
	local p = Lv.Player()
	local lost = Lv.Run(all, p, g.minLevel).levels - Lv.Run(kept, p, g.minLevel).levels
	return lost >= 0.05 and lost or nil
end

---------------------------------------------------------------------------
-- State
---------------------------------------------------------------------------

function PL.IsOpen() return PL.open end

local function render()
	local P = UI.Picker
	if P and P.Render then P.Render() end
end

function PL.Open(id)
	if not id then return end
	if PL.guide ~= id then PL.expanded = {} end
	PL.open, PL.guide, PL.fresh = true, id, true
	render()
end

-- Back to the guide list. `quiet`: the caller draws the menu itself.
function PL.Close(quiet)
	if not PL.open then return end
	PL.open = false
	if PL.frame then PL.frame:Hide() end
	if not quiet then render() end
end

function PL.Toggle(id)
	if PL.open then PL.Close() else PL.Open(id) end
end

---------------------------------------------------------------------------
-- Rows
---------------------------------------------------------------------------

local function ink(tex, name, alpha)
	local r, g, b, a = Theme.Color(name)
	tex:SetVertexColor(r, g, b, (a or 1) * (alpha or 1))
end

local function wash(tex, name, scale)
	local r, g, b, a = Theme.Wash(name)
	tex:SetVertexColor(r, g, b, a * (scale or 1))
end

-- The window's ground, opaque: a node hides the spine behind it.
local function ground(tex)
	local r, g, b = Theme.Color("bg")
	tex:SetVertexColor(r, g, b, 1)
end

-- The quest of row r hidden or brought back; the view stays on that line.
local function toggle(r)
	local row = r.psRow
	local E = ns.Engine
	if not (row and row.toggle and row.quest and E and E.SkipQuest) then return end
	PL.keep = { quest = row.quest, offset = row.y - PL.scroll:GetVerticalScroll() }
	E.SkipQuest(row.quest, row.class ~= "hidden", true)
	PL.Refresh()
end

local function rowClick(r)
	local row = r.psRow
	if not row then return end
	if row.kind == "fold" then
		PL.expanded[row.key] = true
		PL.keep = { fold = row.key, offset = row.y - PL.scroll:GetVerticalScroll() }
		PL.Refresh()
	elseif row.kind == "goal" then
		toggle(r)
	end
end

local function rowEnter(r)
	local row = r.psRow
	if not row then return end
	if row.kind == "fold" then
		W.Tooltip(r, "ANCHOR_TOP", L["Show these steps"])
	elseif row.kind == "goal" then
		local g = row.goal
		local lines = {}
		if row.class == "out" and g.unavailableText then lines[#lines + 1] = g.unavailableText end
		if row.class == "off" and g.unavailableText then lines[#lines + 1] = g.unavailableText end
		if row.toggle then
			lines[#lines + 1] = { row.class == "hidden" and L["Click to put this quest back in your route."]
				or L["Click to leave this quest out of your route. The quests that need it go with it."], Theme.Accent() }
		end
		W.Tooltip(r, "ANCHOR_TOP", row.names and ns.Quoted(row.names) or UI.PlainGoalText(g), lines)
	end
end

local function makeRow(parent)
	local r = CreateFrame("Button", nil, parent)
	r:RegisterForClicks("LeftButtonUp")
	-- The node: a ring on the spine, its ground, and a number or a glyph.
	r.Glow = W.Tex(r, "BORDER", "glow")
	r.Glow:SetSize(NODE * 2.4, NODE * 2.4)
	r.Ring = W.Tex(r, "ARTWORK", "circle", nil, 1)
	r.Ring:SetSize(NODE, NODE)
	r.Glow:SetPoint("CENTER", r.Ring, "CENTER", 0, 0)
	r.Dot = W.Tex(r, "ARTWORK", "circle", nil, 2)
	r.Dot:SetSize(NODE - 4, NODE - 4)
	r.Dot:SetPoint("CENTER", r.Ring, "CENTER", 0, 0)
	r.Mark = W.Tex(r, "OVERLAY", "check")
	r.Mark:SetSize(10, 10)
	r.Mark:SetPoint("CENTER", r.Ring, "CENTER", 0, 0)
	r.No = W.Text(r, "caption", "textMuted")
	r.No:SetPoint("CENTER", r.Ring, "CENTER", 0, 0)
	r.No:SetJustifyH("CENTER")
	-- A step's title, with its zone at the right; the marker's rule.
	r.Title = W.Text(r, "heading", "textDim")
	r.Side = W.Text(r, "small", "textMuted")
	r.Side:SetJustifyH("RIGHT")
	r.Rule = W.Tex(r, "ARTWORK")
	-- A goal's card: its ground, the live step's bar, the quest's tick, the
	-- verb glyph, the line and a tag at the right.
	r.Card = W.Tex(r, "BACKGROUND")
	r.Hi = r:CreateTexture(nil, "HIGHLIGHT")
	r.Hi:SetTexture(Theme.Media("white"))
	r.Hi:SetAllPoints(r.Card)
	r.Bar = W.Tex(r, "ARTWORK", nil, "accent")
	r.Bar:SetWidth(2)
	r.Bar:SetPoint("TOPLEFT", r.Card, "TOPLEFT", 0, 0)
	r.Bar:SetPoint("BOTTOMLEFT", r.Card, "BOTTOMLEFT", 0, 0)
	r.Check = W.Checkbox(r, function(self) toggle(self:GetParent()) end)
	r.Check:SetPoint("LEFT", r.Card, "LEFT", 8, 0)
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(GLYPH, GLYPH)
	r.Icon:SetPoint("LEFT", r.Card, "LEFT", 8 + CHECK + 8, 0)
	r.Text = W.Text(r, "body", "text")
	r.Text:SetPoint("LEFT", r.Icon, "RIGHT", 8, 0)
	r.Small = W.Text(r, "small", "textMuted")
	r.Tag = W.Chip(r)
	r.Tag:SetPoint("RIGHT", r.Card, "RIGHT", -8, 0)
	r:SetScript("OnClick", rowClick)
	r:SetScript("OnEnter", rowEnter)
	r:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	return r
end

-- The node of row r: "number" (a step still to do), "live", "done",
-- "faint" (a step with nothing left), "here", "fold", "end", or nil for none.
local function node(r, style, y, text)
	local on = style ~= nil
	r.Ring:SetShown(on)
	r.Dot:SetShown(on)
	r.Glow:SetShown(style == "here")
	r.Mark:SetShown(style == "done" or style == "fold" or style == "end")
	r.No:SetShown(style == "number" or style == "live" or style == "faint")
	if not on then return end
	r.Ring:ClearAllPoints()
	r.Ring:SetPoint("TOPLEFT", r, "TOPLEFT", SH.pad, -y)
	r.Dot:SetSize(NODE - 4, NODE - 4)
	if style == "live" or style == "here" then
		r.Ring:SetVertexColor(Theme.Accent())
		r.Dot:SetVertexColor(Theme.Accent())
		if style == "here" then
			-- The marker: an accent disc in its own light, the ground at its heart.
			local ar, ag, ab = Theme.Accent()
			r.Glow:SetVertexColor(ar, ag, ab, 0.35)
			r.Dot:SetSize(NODE - 14, NODE - 14)
			ground(r.Dot)
		end
		W.Color(r.No, "onAccent")
	elseif style == "done" or style == "fold" then
		ink(r.Ring, "success", 0.9)
		ink(r.Dot, "success", 0.9)
		r.Mark:SetTexture(Theme.Media("check"))
		ground(r.Mark)
	elseif style == "end" then
		r.Ring:SetVertexColor(Theme.Accent())
		ground(r.Dot)
		r.Mark:SetTexture(Theme.Media("star"))
		r.Mark:SetVertexColor(Theme.Accent())
	else
		-- A ring in the spine's ink around the ground.
		wash(r.Ring, "box", style == "faint" and 0.6 or 1.4)
		ground(r.Dot)
		W.Color(r.No, "textMuted", style == "faint" and 0.6 or 1)
	end
	r.No:SetText(text or "")
end

local function hideCard(r)
	for _, k in ipairs({ "Card", "Bar", "Check", "Icon", "Text", "Tag", "Small" }) do r[k]:Hide() end
	r.Hi:SetVertexColor(0, 0, 0, 0)
end

-- Paint row frame r as `row`, `width` wide.
local function paint(r, row, width)
	r.psRow = row
	local kind = row.kind
	local x = SH.pad + NODE + NODE_GAP -- where text and cards start
	local cardW = width - x - RIGHT
	r.Title:Hide()
	r.Side:Hide()
	r.Rule:Hide()
	hideCard(r)
	r:EnableMouse(kind == "fold" or kind == "goal")
	r.Card:ClearAllPoints()
	r.Card:SetPoint("TOPLEFT", r, "TOPLEFT", x, 0)
	r.Card:SetSize(cardW, CARD_H)

	if kind == "step" then
		local v, state = row.view, row.state
		node(r, (state == "current" and "live") or (state == "past" and v.status == "done" and "done") or ((state == "removed" or state == "past") and "faint") or "number",
			STEP_H - NODE - 4, tostring(v.number))
		r.Title:SetText((v.title and v.title ~= "") and v.title or string.format(L["Step %d"], v.number))
		W.Color(r.Title, (state == "current" and "accent") or (state == "upcoming" and "text") or "textMuted")
		r.Title:ClearAllPoints()
		r.Title:SetPoint("LEFT", r.Ring, "RIGHT", NODE_GAP, 0)
		r.Title:Show()
		local side = row.zone or ""
		r.Side:SetText(side)
		r.Side:ClearAllPoints()
		r.Side:SetPoint("RIGHT", r, "TOPLEFT", width - RIGHT, -(STEP_H - NODE - 4 + NODE / 2))
		r.Side:SetShown(side ~= "")
		r.Title:SetWidth(max(40, cardW - (side ~= "" and (r.Side:GetStringWidth() + 12) or 0)))
	elseif kind == "goal" then
		node(r, nil)
		local g, class, state = row.goal, row.class, row.state
		local off = class ~= "open" or state == "past" or state == "removed"
		r.Card:Show()
		if class == "open" and state == "current" then
			wash(r.Card, "selected", 1)
		elseif class == "open" and state ~= "past" then
			wash(r.Card, "chip", 1)
		else
			r.Card:SetVertexColor(0, 0, 0, 0)
		end
		r.Bar:SetShown(class == "open" and state == "current")
		if row.toggle then wash(r.Hi, "hover", 1) end
		r.Check:SetShown(row.toggle and true or false)
		r.Check:SetChecked(class ~= "hidden")
		r.Icon:SetTexture(class == "done" and Theme.Media("check") or Theme.VerbIcon(g.t))
		ink(r.Icon, class == "done" and "success" or (off and "textMuted" or "textDim"), (class == "done" and state == "past") and 0.6 or 1)
		r.Icon:Show()
		-- The tag: what took the line out of the route, or group content.
		local tag, tagKind
		if class == "hidden" then
			tag = L["Hidden"]
		elseif class == "out" then
			tag, tagKind = g.skippedWith and string.format(L["Needs %s"], ns.Quoted(g.skippedWith)) or L["Left out"], "warning"
		elseif class == "open" and g.party then
			tag, tagKind = L["Group"], "dungeon"
		end
		local tagW = 0
		if tag then
			tagW = W.SetChip(r.Tag, tag, tagKind)
			-- A tag that would crowd the line out says it in the tooltip.
			if tagW > cardW * 0.5 then
				r.Tag:Hide()
				tagW = 0
			end
		end
		local text = off and UI.PlainGoalText(g) or UI.GoalLine(g)
		if row.names then text = text .. "  |c" .. Theme.Hex("textMuted") .. ns.Quoted(row.names) .. "|r" end
		r.Text:SetText(text)
		W.Color(r.Text, off and "textMuted" or "text")
		r.Text:SetWidth(max(40, cardW - (8 + CHECK + 8 + GLYPH + 8) - 8 - (tagW > 0 and (tagW + 8) or 0)))
		r.Text:Show()
	elseif kind == "fold" then
		node(r, row.skipped > 0 and row.done == 0 and "faint" or "fold", (FOLD_H - 8 - NODE) / 2, "\226\128\166")
		r.Card:SetSize(cardW, FOLD_H - 8)
		r.Card:Show()
		wash(r.Card, "chip", 0.6)
		wash(r.Hi, "hover", 1)
		local text = string.format(L["Steps %d\226\128\147%d"], row.from, row.to)
		if row.done > 0 then text = text .. "   |c" .. Theme.Hex("success") .. string.format(L["%d done"], row.done) .. "|r" end
		if row.skipped > 0 then text = text .. "   |c" .. Theme.Hex("textMuted") .. string.format(L["%d skipped"], row.skipped) .. "|r" end
		r.Title:SetText(text)
		W.Color(r.Title, "textDim")
		r.Title:ClearAllPoints()
		r.Title:SetPoint("LEFT", r.Card, "LEFT", 12, 0)
		r.Title:SetWidth(cardW - 80)
		r.Title:Show()
		r.Side:SetText(L["Show"])
		r.Side:ClearAllPoints()
		r.Side:SetPoint("RIGHT", r.Card, "RIGHT", -12, 0)
		r.Side:Show()
	elseif kind == "here" then
		node(r, "here", (HERE_H - NODE) / 2)
		r.Title:SetText((row.started and L["You are here"] or L["You start here"]) .. DOT .. string.format(L["Step %d"], row.number))
		W.Color(r.Title, "accent")
		r.Title:ClearAllPoints()
		r.Title:SetPoint("LEFT", r.Ring, "RIGHT", NODE_GAP, 0)
		r.Title:SetWidth(0)
		r.Title:Show()
		local tw = min(cardW - 24, floor(r.Title:GetStringWidth() + 0.5))
		r.Rule:ClearAllPoints()
		r.Rule:SetPoint("LEFT", r.Ring, "RIGHT", NODE_GAP + tw + 12, 0)
		r.Rule:SetSize(max(1, cardW - tw - 12), Theme.Pixel(r))
		local ar, ag, ab = Theme.Accent()
		r.Rule:SetVertexColor(ar, ag, ab, 0.45)
		r.Rule:Show()
	elseif kind == "end" then
		node(r, "end", 6)
		r.Title:SetText(row.complete and L["Guide complete"] or L["End of the guide"])
		W.Color(r.Title, "accent")
		r.Title:ClearAllPoints()
		r.Title:SetPoint("LEFT", r.Ring, "RIGHT", NODE_GAP, row.next and 7 or 0)
		r.Title:SetWidth(cardW)
		r.Title:Show()
		if row.next then
			r.Small:SetText(string.format(L["Next: %s"], row.next))
			r.Small:ClearAllPoints()
			r.Small:SetPoint("TOPLEFT", r.Title, "BOTTOMLEFT", 0, -3)
			r.Small:SetWidth(cardW)
			r.Small:Show()
		end
	end
end

-- Frames for the rows in view, and no others.
local function paintVisible()
	local m, sf = PL.model, PL.scroll
	if not (m and sf) then return end
	local top = sf:GetVerticalScroll()
	local bottom = top + (PL.viewH or 0)
	local n = 0
	for _, row in ipairs(m.rows) do
		if row.y >= bottom then break end
		if row.y + row.h > top then
			n = n + 1
			local r = PL.pool[n]
			if not r then
				r = makeRow(sf.Child)
				PL.pool[n] = r
			end
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", sf.Child, "TOPLEFT", 0, -row.y)
			r:SetSize(PL.width, row.h)
			paint(r, row, PL.width)
			r:Show()
		end
	end
	for i = n + 1, #PL.pool do
		PL.pool[i].psRow = nil
		PL.pool[i]:Hide()
	end
	PL.shown = n
end
PL.PaintVisible = paintVisible

---------------------------------------------------------------------------
-- The strip: one cell per step, a click jumps there
---------------------------------------------------------------------------

local function rowOfStep(index)
	for _, c in ipairs(PL.model and PL.model.cells or {}) do
		if c.index == index then return c end
	end
	return nil
end

local function scrollTo(y)
	local sf, m = PL.scroll, PL.model
	local range = max(0, m.height - (PL.viewH or 0))
	W.ScrollTo(sf, min(range, max(0, y)))
	paintVisible()
end

-- Bring step `index` (of the guide) to the top, opening the fold it is in.
function PL.JumpTo(index)
	local c = rowOfStep(index)
	if not c then return end
	if c.fold then
		PL.expanded[c.fold] = true
		PL.Refresh()
		c = rowOfStep(index)
		if not c then return end
	end
	scrollTo(c.row.y)
end

local function cell(i)
	local c = PL.cells[i]
	if c then return c end
	c = CreateFrame("Button", nil, PL.strip)
	c.Bar = W.Tex(c, "ARTWORK")
	c.Bar:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", 0, 0)
	c.Bar:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", 0, 0)
	c:SetScript("OnClick", function(self) PL.JumpTo(self.psIndex) end)
	c:SetScript("OnEnter", function(self)
		self.Bar:SetVertexColor(Theme.Accent())
		W.Tooltip(self, "ANCHOR_TOP", self.psTip or "")
	end)
	c:SetScript("OnLeave", function(self)
		W.HideTooltip(self)
		if self.psPaint then self.psPaint(self) end
	end)
	PL.cells[i] = c
	return c
end

local CELL_PAINT = {
	past = function(c) ink(c.Bar, "success", 0.6) end,
	current = function(c) c.Bar:SetVertexColor(Theme.Accent()) end,
	upcoming = function(c) wash(c.Bar, "box", 1.2) end,
	removed = function(c) wash(c.Bar, "box", 0.45) end,
}

local function paintStrip(width)
	local list = PL.model.cells
	local n = #list
	for i, item in ipairs(list) do
		local c = cell(i)
		local x0, x1 = floor((i - 1) * width / n), floor(i * width / n)
		local gap = (x1 - x0) >= 4 and 1 or 0
		c:ClearAllPoints()
		c:SetPoint("BOTTOMLEFT", PL.strip, "BOTTOMLEFT", x0, 0)
		c:SetSize(max(1, x1 - x0 - gap), STRIP_LIVE)
		c.Bar:SetHeight(item.state == "current" and STRIP_LIVE or STRIP_H)
		c.psIndex = item.index
		c.psTip = string.format(L["Step %d"], item.number) .. ((item.title and item.title ~= "") and (DOT .. item.title) or "")
		c.psPaint = CELL_PAINT[item.state] or CELL_PAINT.upcoming
		c.psPaint(c)
		c:Show()
	end
	for i = n + 1, #PL.cells do PL.cells[i]:Hide() end
end

---------------------------------------------------------------------------
-- The pane
---------------------------------------------------------------------------

local function build(win)
	local f = CreateFrame("Frame", nil, win.Main)
	f:SetFrameLevel(win.Content:GetFrameLevel() + 4)
	f:EnableMouse(true)
	f:Hide()
	PL.frame = f
	-- The band where the list has its tabs: back, the strip, "Show all".
	local band = CreateFrame("Frame", nil, f)
	band:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
	band:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
	PL.band = band
	local rule = W.Divider(band)
	rule:SetPoint("BOTTOMLEFT", band, "BOTTOMLEFT", 0, 0)
	rule:SetPoint("BOTTOMRIGHT", band, "BOTTOMRIGHT", 0, 0)
	PL.back = W.IconButton(band, "chevron-left", 24, L["Back to the guides"], function() PL.Close() end, 12)
	PL.back:SetPoint("LEFT", band, "LEFT", SH.pad - 6, 0)
	PL.all = W.Button(band, L["Show all"], function()
		local E = ns.Engine
		for _, q in ipairs(PL.model and PL.model.counts.list or {}) do E.SkipQuest(q, false, true) end
		PL.Refresh()
	end, { ghost = true, height = 24 })
	PL.all.psTight = true
	PL.all.psTip = L["Put every quest you hid back in this guide's route."]
	PL.all:SetPoint("RIGHT", band, "RIGHT", -RIGHT, 0)
	PL.strip = CreateFrame("Frame", nil, band)
	PL.strip:SetHeight(STRIP_LIVE)

	PL.scroll = W.Scroll(f)
	PL.scroll:SetPoint("TOPLEFT", band, "BOTTOMLEFT", 0, 0)
	PL.scroll:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -4, 4)
	PL.scroll:HookScript("OnVerticalScroll", function() paintVisible() end)
	-- The spine, behind every node.
	PL.spine = W.Tex(PL.scroll.Child, "BACKGROUND")
	PL.spine:SetWidth(2)
	W.Painter(PL.spine, function(t) wash(t, "box", 1) end)
	PL.empty = W.Text(f, "note", "textMuted")
	PL.empty:SetPoint("TOPLEFT", band, "BOTTOMLEFT", SH.pad, -24)
	PL.empty:SetText(L["This guide has no steps for your character."])
	PL.empty:Hide()

	win:HookScript("OnHide", function() PL.open = false end)
	Theme.OnChanged(function() if PL.frame:IsShown() then PL.Refresh() end end)
end

-- "Durotar (1-12)  ·  38 quests in your route  ·  2 hidden  ·  3 left out
-- with them  ·  about 0.6 levels less quest XP"
local function summary(g, m)
	local counts = m.counts
	local lv = UI.LevelRange(g.minLevel, g.maxLevel)
	local parts = { (g.title or g.id) .. (lv and (" (" .. lv .. ")") or "") }
	parts[#parts + 1] = counts.quests == 1 and L["1 quest in your route"] or string.format(L["%d quests in your route"], counts.quests)
	if counts.hidden > 0 then parts[#parts + 1] = string.format(L["%d hidden"], counts.hidden) end
	if counts.out > 0 then parts[#parts + 1] = string.format(L["%d left out with them"], counts.out) end
	local lost = PL.LevelsOut(g, m)
	if lost then parts[#parts + 1] = string.format(L["about %.1f levels less quest XP"], lost) end
	return table.concat(parts, DOT)
end

-- Read the plan again and draw it. The view stays where it was: on the line
-- just clicked (PL.keep), else at the same offset; a plan just opened starts
-- at the marker.
function PL.Refresh()
	local win, E, G = PL.win, ns.Engine, ns.Guides
	if not (PL.open and win and PL.frame and PL.frame:IsShown()) then return end
	local g = G and G.Get and G.Get(PL.guide)
	local plan = g and E and E.PlanOf and E.PlanOf(PL.guide)
	local sf = PL.scroll
	if not plan or #plan.steps == 0 then
		PL.model = nil
		for _, r in ipairs(PL.pool) do r:Hide() end
		for _, c in ipairs(PL.cells) do c:Hide() end
		PL.spine:Hide()
		PL.all:Hide()
		PL.empty:Show()
		W.SetScrollContent(sf, 1, PL.viewH)
		W.ShellTitle(win, L["Guide Planner"], g and (g.title or g.id) or nil)
		return
	end
	PL.empty:Hide()
	local m = PL.Model(plan, PL.expanded)
	PL.model, PL.plan = m, plan
	W.ShellTitle(win, L["Guide Planner"], summary(g, m))

	-- The band: back, the strip up to "Show all" when quests are hidden.
	PL.all:SetShown(m.counts.hidden > 0)
	local left = SH.pad + NODE + NODE_GAP
	local right = RIGHT + (m.counts.hidden > 0 and (PL.all:GetWidth() + 12) or 0)
	PL.strip:ClearAllPoints()
	PL.strip:SetPoint("LEFT", PL.band, "LEFT", left, 0)
	PL.strip:SetWidth(max(1, PL.width - left - right))
	paintStrip(max(1, PL.width - left - right))

	sf.Child:SetWidth(PL.width)
	W.SetScrollContent(sf, m.height, PL.viewH)
	local first, last = m.rows[1], m.rows[#m.rows]
	PL.spine:ClearAllPoints()
	PL.spine:SetPoint("TOPLEFT", sf.Child, "TOPLEFT", SH.pad + NODE / 2 - 1, -(first.y + 4))
	PL.spine:SetHeight(max(1, last.y + 6 + NODE / 2 - first.y - 4))
	PL.spine:Show()

	local to = sf:GetVerticalScroll()
	local keep = PL.keep
	PL.keep = nil
	if PL.fresh then
		PL.fresh = false
		-- The marker near the top, what is just behind it still in view.
		to = m.here and (m.here.y - TOP - FOLD_H) or 0
	elseif keep then
		for _, row in ipairs(m.rows) do
			if (keep.quest and row.kind == "goal" and row.quest == keep.quest and row.toggle)
				or (keep.fold and row.kind == "step" and row.view.index == keep.fold) then
				to = row.y - keep.offset
				break
			end
		end
	end
	scrollTo(to)
end

-- Called as the guide menu draws its guide list (P.Render): the planner in
-- the middle pane (`width` wide) while it is open on the selected guide.
function PL.Place(win, width)
	local P = UI.Picker
	local id = P and P.Selected and P.Selected()
	if PL.open and not id then PL.open = false end
	if not PL.open then
		if PL.frame then PL.frame:Hide() end
		return false
	end
	if not PL.frame then build(win) end
	if PL.guide ~= id then
		PL.guide, PL.expanded, PL.fresh = id, {}, true
	end
	PL.win, PL.width = win, width
	local f = PL.frame
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", win.Header, "BOTTOMLEFT", 0, 0)
	f:SetPoint("BOTTOMLEFT", win.Main, "BOTTOMLEFT", 0, 0)
	f:SetWidth(width)
	PL.band:SetHeight(SH.tabs)
	PL.viewH = max(1, win:GetHeight() - SH.header - SH.tabs - 6)
	-- The list and its tabs give the pane up.
	win.TabRow:Hide()
	win.Content:Hide()
	f:Show()
	PL.Refresh()
	return true
end

-- The live step moved: the plan follows. (A guide or a tab changing draws
-- the guide menu again, and with it this pane: PL.Place.)
ns.On("STEP_CHANGED", function()
	if PL.open and PL.frame and PL.frame:IsShown() then PL.Refresh() end
end)
