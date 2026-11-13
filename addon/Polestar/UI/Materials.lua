-- Gather, buy or mix: how a profession guide gets its materials, asked once and changed any time
-- (Core/Materials.lua; docs/GUIDE_FORMAT.md, "Materials"; docs/DESIGN.md, "Materials").
--
-- * The card. The first time a guide with a material to choose a way for (Materials.Choosable: one it both
--   gathers and buys) is the running guide of a character that never answered for it (Materials.Asks: Options'
--   default for new guides, professions.materials, is "ask"; never a Self-Found character), with something still
--   to get from the character's skill on, the heads-up card (UI/ClassToast.lua) asks how to get them: what the
--   rest of the guide takes, what Mix gathers and buys for this character, and what buying it all costs when the
--   prices are known. Mix (the default; the window opens to change any of it), Gather, Buy; Later or the close
--   button keep the default and the guide asks no more (Materials.Dismiss). START_DELAY seconds after the guide
--   opens; while another heads-up is up it waits (HEADS_UP_HIDDEN).
-- * The window (PolestarMaterials): Gather all, Buy all or Mix; every material of the sections still ahead (or of
--   this one) with what the section still needs, what the character holds toward it and its way, Gather or Buy,
--   and why (the player's pick, or Mix's reason). A pick sets the guide to Mix with it (Materials.SetWay); a
--   right-click on a row takes the material back to its automatic way. Under it, what buying costs (prices from
--   the player's searches, else Auctionator's; they decide nothing) and the list for Auctionator (its shopping
--   list, while it is installed) or the copy window. Opened from the card's Mix, the guide window's menu and
--   /polestar materials.
-- * The guide window's menu (UI/GuideFrameMenu.lua): "Gather materials", "Buy materials" and "Mix: choose per
--   material" (the window), the guide's way checked, for a guide with a material to choose for.
--
-- Colours are Theme tokens; the window is skinned for every look (Theme.Skin).
--
--   UI.Materials.Show() / .Hide() / .Layout()
--   UI.Materials.MenuItems() -> menu rows | nil
--   UI.Materials.CardModel(guide, sections) -> model | nil   (sections: Engine.MaterialRows("rest"))
--   UI.Materials.Check(id) -> true when the card shows

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local format, ipairs, concat, min, max, floor = string.format, ipairs, table.concat, math.min, math.max, math.floor

local MA = {}
UI.Materials = MA

MA.START_DELAY = 4 -- seconds after a guide opens: past its catch-up (2.5 s at most)
MA.NAMES = 3 -- materials a line names, then "and N more"

local WIDTH = 500
local PAD = 24
local HEAD_H = 56
local ROW_H = 40
local SEC_H = 26
local ICON = 24
local BODY_MAX = 420
local DOT = "  \194\183  "

local F

local function M() return ns.Materials end
local function CT() return UI.ClassToast end
local function running()
	local E = ns.Engine
	return E and E.GetGuide and E.GetGuide() or nil
end

local function thousands(n)
	local s = tostring(floor(n + 0.5))
	local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return (out:gsub("^,", ""))
end

-- "Wool Cloth, Silk Cloth and Mageweave Cloth", or past MA.NAMES "Wool Cloth, Silk Cloth, Mageweave Cloth and 3 more".
local function names(list)
	local n = #list
	if n > MA.NAMES then
		local shown = {}
		for i = 1, MA.NAMES do shown[i] = list[i] end
		return format(L["%s and %d more"], concat(shown, ", "), n - MA.NAMES)
	end
	if n < 2 then return list[1] or "" end
	return format(L["%s and %s"], concat(list, ", ", 1, n - 1), list[n])
end

-- The profession a gather way takes ("Skinning"), from its skill line.
local function professionOf(w)
	local C = ns.Compat
	return (w.skillLine and C.GetSkillLineName and C.GetSkillLineName(w.skillLine)) or w.skill or ""
end

-- Why a material takes its way, in a few words (Materials.Way's reason).
function MA.Why(row)
	local w = row.gatherGoal and type(row.gatherGoal.gather) == "table" and row.gatherGoal.gather or nil
	local r = row.reason
	if r == "picked" then return L["Your choice"] end
	if r == "selfFound" then return L["No Auction House for self-found characters"] end
	if r == "noGather" then return L["Only from the Auction House"] end
	if r == "noBuy" then return L["Not sold at the Auction House"] end
	if r == "skill" and w and w.rank then return format(L["Needs %s %d"], professionOf(w), w.rank) end
	if r == "low" and w and w.min then return format(L["Drops from level %d"], w.min) end
	if r == "past" then return L["You're past its levels"] end
	if r == "mode" then return row.way == "buy" and L["Buy all"] or L["Gather all"] end
	-- Mix gathers it: what that takes.
	if w and (w.skillLine or w.skill) and w.rank then return format(L["%s %d"], professionOf(w), w.rank) end
	if w and w.min and w.max then return format(L["Mobs of level %d-%d"], w.min, w.max) end
	return L["You gather it"]
end

---------------------------------------------------------------------------
-- The card
---------------------------------------------------------------------------

local waiting -- a guide id whose card waits for another heads-up to go

local function answer(id, mode, window)
	local Mt = M()
	if Mt then Mt.SetMode(id, mode) end
	if window then MA.Show() end
end

-- The card's model for guide g from its sections ahead, or nil with nothing still to get.
function MA.CardModel(g, sections)
	local Mt = M()
	local totals, order = {}, {}
	for _, sec in ipairs(sections or {}) do
		for _, row in ipairs(sec.items) do
			if row.toGet > 0 then
				local t = totals[row.item]
				if not t then
					t = { item = row.item, name = row.name, n = 0, way = row.way, buy = row.buy }
					totals[row.item] = t
					order[#order + 1] = t
				end
				t.n = t.n + row.toGet
			end
		end
	end
	if #order == 0 then return nil end
	local all, gathered, bought = {}, {}, {}
	local cost, priced = 0, 0
	for i, t in ipairs(order) do
		all[i] = format("%s %s", thousands(t.n), t.name)
		if t.way == "buy" then bought[#bought + 1] = t.name else gathered[#gathered + 1] = t.name end
		if t.buy and Mt then
			local price = Mt.Price(t.item, t.n)
			if price then cost, priced = cost + price, priced + 1 end
		end
	end
	local route
	if #bought == 0 then
		route = L["Mix gathers them all: your level and professions can."]
	elseif #gathered == 0 then
		route = L["Mix buys them all: your level and professions gather none of them yet."]
	else
		route = format(L["Mix gathers %s and buys %s."], names(gathered), names(bought))
	end
	local buyable = 0
	for _, t in ipairs(order) do if t.buy then buyable = buyable + 1 end end
	if buyable > 0 and priced == buyable then route = route .. " " .. format(L["Buying it all: about %s."], ns.MoneyText(cost)) end
	local id = g.id
	return {
		kind = "materials", forGuide = id, answers = true,
		head = format("%s%s%s", L["MATERIALS"], DOT, (g.title or ""):upper()),
		title = L["How do you want to get them?"], titleColor = "text",
		giver = format(L["The rest of the guide takes %s."], names(all)),
		route = route,
		icon = Theme.Media("icon-collect"), iconColor = "accent",
		act = { label = L["Mix"], run = function()
			answer(id, "mix", true)
			CT().Hide()
			return true
		end },
		more = { label = L["Gather"], run = function()
			answer(id, "gather")
			CT().Hide()
			return true
		end },
		off = { label = L["Buy"], run = function() answer(id, "buy") end },
		later = { label = L["Later"], run = function()
			local Mt2 = M()
			if Mt2 then Mt2.Dismiss(id) end
		end },
	}
end

-- The card for guide `id`, if it is still the running guide and asks. -> true when shown
function MA.Check(id)
	local Mt, E, T = M(), ns.Engine, CT()
	local g = running()
	if not (Mt and T and g and g.id == id and Mt.Asks(id) and Mt.Choosable(g)) or ns.Hidden() then return false end
	if ns.Compat.InCombat() then
		waiting = id
		return false
	end
	local m = MA.CardModel(g, E.MaterialRows("rest"))
	if not m then return false end
	local cur = T.current
	if cur and cur.kind ~= "materials" then
		waiting = id
		return false
	end
	waiting = nil
	-- Shown, or kept on the card for the guide window to show when it opens.
	return T.ShowCard(m) or T.current == m
end

-- Another guide running: its card goes, unanswered, and asks again when that guide runs.
ns.On("GUIDE_CHANGED", function(id)
	local T = CT()
	local cur = T and T.current
	if cur and cur.kind == "materials" and cur.forGuide ~= id then
		cur.switched = true
		T.Hide()
	end
	if id then ns.After(MA.START_DELAY, function() MA.Check(id) end) end
end)

-- A heads-up gone: the card unanswered by a guide switch asks again later; any other way it went (Later, the
-- close button, its time up) it asks no more. Then a card that waited shows.
ns.On("HEADS_UP_HIDDEN", function(m)
	if type(m) == "table" and m.kind == "materials" and not m.switched then
		local Mt = M()
		if Mt and m.forGuide then Mt.Dismiss(m.forGuide) end
	end
	if waiting then
		local id = waiting
		ns.After(0.5, function()
			local T = CT()
			if not (T and T.current) then MA.Check(id) end
		end)
	end
end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if waiting then
		local id = waiting
		ns.After(0.5, function() MA.Check(id) end)
	end
end)

---------------------------------------------------------------------------
-- The guide window's menu
---------------------------------------------------------------------------

function MA.MenuItems()
	local Mt, g = M(), running()
	if not (Mt and g and g.id and Mt.Choosable(g)) or Mt.SelfFound() then return nil end
	local id = g.id
	local mode = Mt.Mode(id)
	return {
		{ text = L["Gather materials"], icon = "icon-collect", checked = mode == "gather", onClick = function() answer(id, "gather") end },
		{ text = L["Buy materials"], icon = "icon-buy", checked = mode == "buy", onClick = function() answer(id, "buy") end },
		{ text = L["Mix: choose per material"], icon = "icon-craft", checked = mode == "mix", onClick = function() answer(id, "mix", true) end },
		{ separator = true },
	}
end

---------------------------------------------------------------------------
-- The window
---------------------------------------------------------------------------

-- A two-way choice drawn as buttons, the chosen one in the accent.
local function choose(b, on)
	if (b.psPrimary and true or false) == on then return end
	b.psPrimary = on or nil
	Theme.Repaint(b)
	W.RepaintButton(b)
end

local function setWay(item, way)
	local Mt, g = M(), running()
	if Mt and g and g.id and item then Mt.SetWay(g.id, item, way) end
end

local MODES = { "gather", "buy", "mix" }

local function build()
	F = CreateFrame("Frame", "PolestarMaterials", ns.UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(WIDTH)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 80)
	F:Hide()
	Theme.Skin(F, "window")

	local head = CreateFrame("Frame", nil, F)
	head:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	head:SetHeight(HEAD_H)
	head:EnableMouse(true)
	head:RegisterForDrag("LeftButton")
	head:SetScript("OnDragStart", function() F:StartMoving() end)
	head:SetScript("OnDragStop", function() F:StopMovingOrSizing() end)
	F.Band = Theme.Band(head, "BACKGROUND", -5)
	F.Band:SetAllPoints(head)
	F.Band:SetTexCoord(Theme.BandCoords(WIDTH - 2, HEAD_H))
	F.Close = W.IconButton(head, "close", 28, L["Close"], function() F:Hide() end, 14)
	F.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -14)
	F.Title = W.Text(head, "title", "text")
	F.Title:SetPoint("LEFT", head, "LEFT", PAD, 0)
	F.Title:SetPoint("RIGHT", F.Close, "LEFT", -8, 0)
	F.Title:SetJustifyH("LEFT")
	F.Title:SetWordWrap(false)

	-- Gather all, Buy all, Mix; the scope beside them.
	F.Modes = {}
	local labels = { gather = L["Gather all"], buy = L["Buy all"], mix = L["Mix"] }
	local prev
	for _, mode in ipairs(MODES) do
		local b = W.Button(F, labels[mode], function()
			local Mt, g = M(), running()
			if Mt and g and g.id then Mt.SetMode(g.id, mode) end
		end, { height = 26 })
		if prev then
			b:SetPoint("LEFT", prev, "RIGHT", 6, 0)
		else
			b:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -(HEAD_H + 12))
		end
		F.Modes[mode] = b
		prev = b
	end
	F.Scope = W.Button(F, "", function()
		F.psScope = F.psScope == "section" and "rest" or "section"
		MA.Layout()
	end, { ghost = true, height = 26 })
	F.Scope:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD + 8, -(HEAD_H + 12))

	F.Hint = W.Text(F, "note", "textDim")
	F.Hint:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -(HEAD_H + 12 + 26 + 10))
	F.Hint:SetWidth(WIDTH - PAD * 2)
	F.Hint:SetJustifyH("LEFT")
	F.Hint:SetWordWrap(true)

	F.Scroll = W.Scroll(F)
	F.Body = F.Scroll.Child
	F.Body:SetWidth(WIDTH - PAD * 2)

	F.Rule = W.Divider(F)
	F.Total = W.Text(F, "note", "text")
	F.Total:SetJustifyH("LEFT")
	F.Total:SetWordWrap(true)
	F.Note = W.Text(F, "note", "textDim")
	F.Note:SetJustifyH("LEFT")
	F.Note:SetWordWrap(true)
	F.Note:SetText(L["Vendor goods (thread, dyes, vials) stay vendor steps in every mode."])
	F.Export = W.Button(F, "", function() MA.Export() end, { height = 26 })

	F.rows, F.heads = {}, {}
	F.psScope = "rest"
	F:SetScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.FAST, "out") end)
	ns.CloseOnEscape("PolestarMaterials")
	if ns.Gamepad and ns.Gamepad.Register then ns.Gamepad.Register(F, {}) end
end

local function heading(i)
	local h = F.heads[i]
	if h then return h end
	h = W.Text(F.Body, "caption", "textDim")
	h:SetJustifyH("LEFT")
	h:SetWordWrap(false)
	F.heads[i] = h
	return h
end

local function row(i)
	local r = F.rows[i]
	if r then return r end
	r = CreateFrame("Button", nil, F.Body)
	r:SetHeight(ROW_H)
	r:RegisterForClicks("RightButtonUp")
	-- A right-click: back to the automatic way.
	r:SetScript("OnClick", function(self, button) if button == "RightButton" then setWay(self.psItem, nil) end end)
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(ICON, ICON)
	r.Icon:SetPoint("LEFT", r, "LEFT", 0, 0)
	-- The item's own tooltip; Shift-click links it in chat.
	r.Hit = CreateFrame("Button", nil, r)
	r.Hit:SetAllPoints(r.Icon)
	r.Hit:SetScript("OnEnter", function(self) W.ItemTip(self, self:GetParent().psItem) end)
	r.Hit:SetScript("OnLeave", function() W.HideTooltip() end)
	r.Hit:SetScript("OnClick", function(self) W.ItemClick(self:GetParent().psItem) end)
	r.Buy = W.Button(r, L["Buy"], function(self) setWay(self:GetParent().psItem, "buy") end, { height = 22 })
	r.Buy:SetPoint("RIGHT", r, "RIGHT", 0, 0)
	r.Gather = W.Button(r, L["Gather"], function(self) setWay(self:GetParent().psItem, "gather") end, { height = 22 })
	r.Gather:SetPoint("RIGHT", r.Buy, "LEFT", -4, 0)
	r.Name = W.Text(r, "label", "text")
	r.Name:SetPoint("TOPLEFT", r.Icon, "TOPRIGHT", 8, 2)
	r.Name:SetPoint("RIGHT", r.Gather, "LEFT", -8, 0)
	r.Name:SetJustifyH("LEFT")
	r.Name:SetWordWrap(false)
	r.Sub = W.Text(r, "note", "textDim")
	r.Sub:SetPoint("TOPLEFT", r.Name, "BOTTOMLEFT", 0, -2)
	r.Sub:SetPoint("RIGHT", r.Gather, "LEFT", -8, 0)
	r.Sub:SetJustifyH("LEFT")
	r.Sub:SetWordWrap(false)
	F.rows[i] = r
	return r
end

-- A row's second line: what the section still needs, what the character holds toward it, and why its way.
function MA.RowText(row)
	local parts = {}
	if row.toGet > 0 then
		parts[#parts + 1] = format(L["%s still to get"], thousands(row.toGet))
	else
		parts[#parts + 1] = L["You have them all"]
	end
	if row.held > 0 and row.toGet > 0 then parts[#parts + 1] = format(L["%s held"], thousands(row.held)) end
	if row.way == "buy" and row.price then parts[#parts + 1] = format(L["≈ %s"], ns.MoneyText(row.price)) end
	parts[#parts + 1] = MA.Why(row)
	return concat(parts, DOT)
end

-- The materials to buy in the window's scope: { { item, name, count } }.
local function toBuy(sections)
	local out = {}
	for _, sec in ipairs(sections) do
		for _, r in ipairs(sec.items) do
			if r.way == "buy" and r.toGet > 0 then out[#out + 1] = { item = r.item, name = r.name, count = r.toGet, price = r.price } end
		end
	end
	return out
end

-- The list to buy for Auctionator, while it is installed, else in the copy window ("567 Wool Cloth" a line).
function MA.Export()
	local Mt, E, g = M(), ns.Engine, running()
	if not (Mt and g and E and E.MaterialRows) then return end
	local list = toBuy(E.MaterialRows(F and F.psScope or "rest"))
	if #list == 0 then return end
	local title = format(L["Polestar: %s"], g.title or "")
	if Mt.ToAuctionator(title, list) then
		ns.Print(format(L["Auctionator has the shopping list \"%s\"."], title))
		return
	end
	local lines = {}
	for i, e in ipairs(list) do lines[i] = format("%d %s", e.count, ns.Compat.GetItemName(e.item) or e.name) end
	if UI.ShowCopy then UI.ShowCopy(title, concat(lines, "\n")) end
end

local HINT = {
	gather = L["You gather every material you can. One that takes a profession you don't have is bought."],
	buy = L["You buy every material the Auction House sells. The shopping list opens beside the Auction House."],
	mix = L["Mix gathers what your level and professions allow and buys the rest. Pick a way for any material; right-click it to go back to Mix's."],
}

function MA.Layout()
	if not (F and F:IsShown()) then return end
	local Mt, E, g = M(), ns.Engine, running()
	if not (Mt and E and E.MaterialRows) then
		F:Hide()
		return
	end
	-- A guide with no material to choose a way for (none running, a leveling guide): the window says so.
	local choosable = g and g.id and Mt.Choosable(g)
	F.Title:SetText(g and format(L["Materials: %s"], g.title or "") or L["Materials"])
	local mode = choosable and Mt.Mode(g.id) or nil
	local solo = Mt.SelfFound()
	for _, m in ipairs(MODES) do
		local b = F.Modes[m]
		choose(b, m == mode)
		if not choosable or (solo and m ~= "gather") then b:Disable() else b:Enable() end
	end
	W.SetButtonText(F.Scope, F.psScope == "section" and L["This range"] or L["Rest of the guide"])
	if not choosable then
		F.Hint:SetText(L["Open a profession guide to choose how it gets its materials: gather them, buy them or mix."])
	else
		F.Hint:SetText(solo and L["No Auction House for self-found characters: you gather every material."] or HINT[mode])
	end
	local top = HEAD_H + 12 + 26 + 10 + F.Hint:GetStringHeight() + 12
	local sections = choosable and E.MaterialRows(F.psScope) or {}
	local y, nr, nh = 0, 0, 0
	for _, sec in ipairs(sections) do
		nh = nh + 1
		local h = heading(nh)
		h:ClearAllPoints()
		h:SetPoint("TOPLEFT", F.Body, "TOPLEFT", 0, -(y + 6))
		h:SetText(format("%s%s%s", sec.title:upper(), DOT, format(L["your skill %d"], sec.rank)))
		h:Show()
		y = y + SEC_H
		for _, r in ipairs(sec.items) do
			nr = nr + 1
			local f = row(nr)
			f.psItem = r.item
			f:ClearAllPoints()
			f:SetPoint("TOPLEFT", F.Body, "TOPLEFT", 0, -y)
			f:SetPoint("TOPRIGHT", F.Body, "TOPRIGHT", 0, -y)
			f.Icon:SetTexture(ns.Compat.ItemIcon(r.item))
			f.Name:SetText(ns.Compat.GetItemName(r.item) or r.name)
			W.Color(f.Name, r.toGet > 0 and "text" or "textDim")
			f.Sub:SetText(MA.RowText(r))
			choose(f.Gather, r.way == "gather")
			choose(f.Buy, r.way == "buy")
			-- A way the character cannot take is off: no gather step, a profession it lacks; nothing buys it, or Self-Found.
			if r.gatherGoal and r.gatherWhy ~= "skill" then f.Gather:Enable() else f.Gather:Disable() end
			if r.buy and not solo then f.Buy:Enable() else f.Buy:Disable() end
			f:Show()
			y = y + ROW_H + 4
		end
	end
	for i = nr + 1, #F.rows do F.rows[i]:Hide() end
	for i = nh + 1, #F.heads do F.heads[i]:Hide() end
	if nr == 0 then
		nh = nh + 1
		local h = heading(nh)
		h:ClearAllPoints()
		h:SetPoint("TOPLEFT", F.Body, "TOPLEFT", 0, -6)
		h:SetText(choosable and L["Nothing left to get from your skill on."] or "")
		h:Show()
		y = SEC_H
	end
	local view = min(y, BODY_MAX)
	F.Scroll:ClearAllPoints()
	F.Scroll:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -top)
	F.Scroll:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD, -top)
	F.Scroll:SetHeight(view)
	W.SetScrollContent(F.Scroll, y, view)
	-- What buying costs: the materials whose way is Buy, priced for the count still to buy.
	local list = toBuy(sections)
	local cost, unpriced = 0, 0
	for _, e in ipairs(list) do
		if e.price then cost = cost + e.price else unpriced = unpriced + 1 end
	end
	local total
	if #list == 0 then
		total = L["Nothing to buy."]
	elseif unpriced == #list then
		total = L["No prices yet: a search at the Auction House prices what it finds."]
	else
		total = format(L["Buying: about %s"], ns.MoneyText(cost))
		if unpriced > 0 then total = total .. " " .. format(L["(%d without a price yet)"], unpriced) end
	end
	total = total .. DOT .. format(L["You have %s"], ns.MoneyText(ns.Compat.GetMoney() or 0))
	local fy = top + view + 12
	F.Rule:ClearAllPoints()
	F.Rule:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -fy)
	F.Rule:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD, -fy)
	fy = fy + 10
	W.SetButtonText(F.Export, Mt.AuctionatorLoaded() and L["Send to Auctionator"] or L["Copy list"])
	F.Export:ClearAllPoints()
	F.Export:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD, -fy)
	if #list > 0 then F.Export:Enable() else F.Export:Disable() end
	F.Total:ClearAllPoints()
	F.Total:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -fy)
	F.Total:SetPoint("RIGHT", F.Export, "LEFT", -12, 0)
	F.Total:SetText(total)
	fy = fy + max(26, F.Total:GetStringHeight()) + 8
	F.Note:ClearAllPoints()
	F.Note:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -fy)
	F.Note:SetWidth(WIDTH - PAD * 2)
	fy = fy + F.Note:GetStringHeight()
	F:SetHeight(floor(fy + PAD + 0.5))
end

function MA.Show()
	if not F then build() end
	F:Show()
	MA.Layout()
end

function MA.Hide()
	if F then F:Hide() end
end

-- The window follows the ways, the counts, the prices, the guide and the skill.
local due = false
local function relayout()
	if due or not (F and F:IsShown()) then return end
	due = true
	ns.After(0.1, function()
		due = false
		MA.Layout()
	end)
end
for _, msg in ipairs({ "MATERIALS_CHANGED", "MATERIALS_COUNTS", "MATERIALS_PRICES", "GUIDE_CHANGED", "STEP_CHANGED" }) do ns.On(msg, relayout) end
for _, event in ipairs({ "BAG_UPDATE_DELAYED", "SKILL_LINES_CHANGED", "PLAYER_MONEY" }) do ns.RegisterEvent(event, relayout) end

ns.RegisterCommand("materials", function() MA.Show() end, L["Show how the profession guide gets its materials"])
