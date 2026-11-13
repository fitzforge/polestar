-- Auction house buys on screen (qol.auctionBuys; which items, and why:
-- Quests/AuctionBuys.lua):
--
-- * The guide's card. When a guide opens, or the window switches to it, the
--   heads-up card (UI/ClassToast.lua) says "Auction house buys for this
--   guide": one line per item, "15 Silk Cloth for Caught!" (CARD_LINES, then
--   "+N more"), their icons with the game's tooltips and counts (Shift-click
--   links one in chat), and why they are listed. "See the list" opens the
--   list; Got it and the close button dismiss it; "Turn these off" sets
--   qol.auctionBuys off. Once per guide per character, once shown
--   (CharState().auctionGuides); START_DELAY seconds after the guide opens, so
--   its catch-up has placed the live step and drawn it. The guide window's menu offers
--   "Auction house buys (N)" while there are any: the list again.
-- * The reminder. In a town with an auction house (Nav.nearby.Near: an
--   auctioneer of the character's side in its zone, from the Codex's
--   auctioneer role as Nearby services finds them, within REACH yards while
--   the character rests in the town, else within NEAR), the card lists
--   what the quests ahead in the guide and in the log still need, with "Show
--   me the auctioneer" (the arrow to the nearest one, Nearby.Go). Once per
--   visit (CharState().auctionVisit holds the town's map until the character
--   is seen out of every auctioneer's reach). Never in combat (it waits for
--   the fight to end), in an instance, while the step's escort runs, while
--   Polestar or the guide window is hidden. The Codex is loaded for it only in
--   a rest area (a town or an inn) with something to buy.
-- * The list window (PolestarAuctionBuys): each item with its icon (the game's
--   tooltip, Shift-click links it), the count still needed, the quests it is
--   for, why it is listed and what the bags and the bank hold, and "Show me
--   the auction house". Under them, the running profession guide's materials
--   to buy (Materials.BuyRows: their way is Buy, still to get after the bags,
--   bank and mail), each with its range and price. Opened from the cards, the
--   guide window's menu and /polestar ah; at the Auction House it opens
--   beside the game's window while either group has something to buy and goes
--   with it, and each row's Search opens the item in the game's own buy view
--   with the count filled in (Materials.Search; the player presses Buy).
--
-- Another heads-up on the card goes first: these wait for it to be dismissed
-- (HEADS_UP_HIDDEN), the newest of each kind kept. Colours are Theme tokens.
--
--   UI.AuctionBuys.Show() / .Hide() / .Layout()      the list window
--   UI.AuctionBuys.CardModel(kind, list, town) -> model   kind "guide" | "town"
--   UI.AuctionBuys.CheckGuide(id) / .CheckTown() -> true when a card shows
--   UI.AuctionBuys.MenuItem() -> the guide menu's entry | nil

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local format, ipairs, concat = string.format, ipairs, table.concat

local AU = {}
UI.AuctionBuys = AU

AU.CARD_LINES = 4 -- items a card lists by name, then "+N more"
AU.REACH = 450 -- yards from an auctioneer in the character's zone, resting there: in that town
AU.NEAR = 100 -- yards from one, resting or not: at its auction house
AU.START_DELAY = 4 -- seconds after a guide opens: past its catch-up (2.5 s at most)
AU.ICON = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Map\\icon-auction"

local WIDTH = 380
local PAD = 24
local HEAD_H = 56
local ROW_H = 40
local ICON = 28
local DOT = "  \194\183  "

local function AB() return ns.AuctionBuys end
local function CT() return UI.ClassToast end
local function on() local A = AB(); return A and A.On() or false end

---------------------------------------------------------------------------
-- Words
---------------------------------------------------------------------------

local function questNames(e)
	local names = {}
	for i, q in ipairs(e.quests) do names[i] = q.title end
	return concat(names, ", ")
end

-- Why an item is on the list, in a few words.
function AU.Why(e)
	if e.why == "farm" then return format(L["About %d kills to farm"], e.kills or 0) end
	if e.why == "gather" then
		local N = ns.Nav and ns.Nav.nearby
		local skill = N and N.ProfessionName and N.ProfessionName(e.skill) or tostring(e.skill)
		return format(L["Needs %s to gather"], skill)
	end
	if e.why == "made" then return L["Crafted: nothing drops it"] end
	return L["The guide sends you to the auction house for it"]
end

-- "15 Silk Cloth for Caught!"
function AU.Line(e)
	return format(L["%d %s for %s"], e.need, e.name, questNames(e))
end

local function turnOff()
	ns.Set("qol.auctionBuys", false)
	ns.Print(L["Auction house buys are off. Turn them back on under Options > Questing > Quests."])
end

-- The heads-up card for `list` (AuctionBuys.List): kind "guide" (the guide's
-- card) or "town" (the reminder in `town`).
function AU.CardModel(kind, list, town)
	local n = #list
	local m = { kind = kind == "town" and "auctionTown" or "auctionGuide", town = town, icon = AU.ICON, iconColor = "accent", titleColor = "text" }
	m.head = L["AUCTION HOUSE"]
	if kind == "town" then
		m.title = n == 1 and format(L["1 quest item to buy in %s"], town or "") or format(L["%d quest items to buy in %s"], n, town or "")
	else
		m.title = L["Auction house buys for this guide"]
	end
	local lines, row = {}, {}
	for i, e in ipairs(list) do
		if i <= AU.CARD_LINES then lines[i] = AU.Line(e) end
		row[i] = { item = e.item, count = e.need }
	end
	if n > AU.CARD_LINES then lines[#lines + 1] = format(L["+%d more"], n - AU.CARD_LINES) end
	m.giver = concat(lines, "\n")
	m.route = L["No vendor sells these, and farming them is slow or not possible."]
	m.spells = row
	local function list_()
		AU.Show()
		CT().Hide()
		return true
	end
	if kind == "town" then
		m.act = { label = L["Show me the auctioneer"], run = function()
			local N = ns.Nav and ns.Nav.nearby
			if N and N.Go and N.Go("auction") then CT().Hide() end
			return true
		end }
		m.more = { label = L["See the list"], run = list_ }
	else
		m.act = { label = L["See the list"], run = list_ }
		m.later = { label = L["Got it"] }
	end
	m.off = { label = L["Turn these off"], run = turnOff }
	return m
end

---------------------------------------------------------------------------
-- The cards
---------------------------------------------------------------------------

local waiting = {} -- model kind -> function showing it once the card is free

-- Show model m now, or once the heads-up on the card is dismissed. -> true when shown
local function showCard(m, retry)
	local T = CT()
	if not (T and T.ShowCard) then return false end
	local cur = T.current
	if cur and cur.kind ~= m.kind then
		waiting[m.kind] = retry
		return false
	end
	waiting[m.kind] = nil
	return T.ShowCard(m)
end

local function windowShown()
	local w = UI.GuideFrame and UI.GuideFrame.frame
	return w ~= nil and w:IsShown()
end

local function told()
	local st = ns.CharState()
	if type(st.auctionGuides) ~= "table" then st.auctionGuides = {} end
	return st.auctionGuides
end

-- The guide's card for guide `id`, if it is still the running guide, has
-- items to buy and was never shown on this character. -> true when shown
function AU.CheckGuide(id)
	local E = ns.Engine
	local g = E and E.GetGuide and E.GetGuide()
	if not (on() and g and g.id == id) or told()[id] or ns.Hidden() then return false end
	if ns.Compat.InCombat() then
		AU.startDue = id
		return false
	end
	local list, pending = AB().List("guide")
	if #list == 0 then
		-- An item the client is still loading may join it: asked again when it comes.
		AU.startDue = pending and id or nil
		return false
	end
	AU.startDue = nil
	local m = AU.CardModel("guide", list)
	m.forGuide = id
	-- Shown, or kept on the card for the guide window to show when it opens.
	if showCard(m, function() return AU.CheckGuide(id) end) or CT().current == m then
		told()[id] = true
		return true
	end
	return false
end

-- The auctioneer of the town the character is in, or nil: one in its zone
-- within REACH yards while it rests there (the town's rest area), else
-- within NEAR yards. Loads the Codex only when `load`.
local function auctioneerHere(load)
	local X = ns.Codex
	local N = ns.Nav and ns.Nav.nearby
	if not (X and X.IsLoaded and N and N.Near) then return nil end
	if not X.IsLoaded() and not load then return nil end
	local place, yards = N.Near("auction", AU.REACH)
	if not place or (yards > AU.NEAR and not (IsResting and IsResting())) then return nil end
	return place
end

-- The reminder, in a town with an auction house. -> true when shown
function AU.CheckTown()
	if not on() or ns.Hidden() then return false end
	local C = ns.Compat
	if C.IsInInstance() then return false end
	local st = ns.CharState()
	local X = ns.Codex
	local loaded = X and X.IsLoaded and X.IsLoaded()
	local place
	if loaded then
		place = auctioneerHere(false)
		-- Out of every auctioneer's reach: the visit is over.
		if not place then
			st.auctionVisit = nil
			return false
		end
		if st.auctionVisit == place.map then return false end
	elseif not (IsResting and IsResting()) then
		return false
	end
	if C.InCombat() then
		AU.townDue = true
		return false
	end
	local E = ns.Engine
	if (E and E.EscortRunning and E.EscortRunning()) or not windowShown() then return false end
	local list = AB().List("all")
	if #list == 0 then return false end
	place = place or auctioneerHere(true)
	if not place or st.auctionVisit == place.map then return false end
	local town = C.GetMapName(place.map) or (GetRealZoneText and GetRealZoneText()) or ""
	if showCard(AU.CardModel("town", list, town), AU.CheckTown) then
		st.auctionVisit = place.map
		return true
	end
	return false
end

local scheduled = false
local function checkTownSoon()
	if scheduled then return end
	scheduled = true
	ns.After(0.5, function()
		scheduled = false
		AU.CheckTown()
	end)
end

---------------------------------------------------------------------------
-- The list window
---------------------------------------------------------------------------

local F

local function build()
	F = CreateFrame("Frame", "PolestarAuctionBuys", ns.UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(WIDTH)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 120)
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
	F.Title:SetText(L["Auction house buys"])

	F.Hint = W.Text(F, "note", "textDim")
	F.Hint:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -(HEAD_H + 12))
	F.Hint:SetWidth(WIDTH - PAD * 2)
	F.Hint:SetJustifyH("LEFT")
	F.Hint:SetWordWrap(true)

	F.Go = W.Button(F, L["Show me the auction house"], function()
		local N = ns.Nav and ns.Nav.nearby
		if N and N.Go and N.Go("auction") then F:Hide() end
	end, { primary = true, height = 28 })

	-- The running profession guide's materials to buy (Materials.BuyRows), under the quest items.
	F.MatHead = W.Text(F, "caption", "textDim")
	F.MatHead:SetJustifyH("LEFT")
	F.MatHead:SetWordWrap(false)

	F.rows, F.mrows = {}, {}
	F:SetScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.FAST, "out") end)
	ns.CloseOnEscape("PolestarAuctionBuys")
	if ns.Gamepad and ns.Gamepad.Register then ns.Gamepad.Register(F, {}) end
end

-- The game's own buy view of a row's item at the open Auction House, the count filled in (Materials.Search).
local function search(self)
	local r, M = self:GetParent(), ns.Materials
	if r.psItem and M and M.Search then M.Search(r.psItem, r.psCount) end
end

local function row(i, pool)
	pool = pool or F.rows
	local r = pool[i]
	if r then return r end
	r = CreateFrame("Frame", nil, F)
	r:SetHeight(ROW_H)
	-- The item: the game's tooltip, and a modified click as on a bag slot.
	r.Item = CreateFrame("Button", nil, r)
	r.Item:SetSize(ICON, ICON)
	r.Item:SetPoint("LEFT", r, "LEFT", 0, 0)
	r.Item.Icon = r.Item:CreateTexture(nil, "ARTWORK")
	r.Item.Icon:SetAllPoints(r.Item)
	r.Item.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	r.Item:SetScript("OnEnter", function(self) if self.psItem then W.ItemTip(self, self.psItem) end end)
	r.Item:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	r.Item:SetScript("OnClick", function(self) if self.psItem then W.ItemClick(self.psItem) end end)
	r.Search = W.Button(r, L["Search"], search, { height = 24 })
	r.Search:SetPoint("RIGHT", r, "RIGHT", 0, 0)
	r.Title = W.Text(r, "label", "text")
	r.Title:SetPoint("TOPLEFT", r.Item, "TOPRIGHT", 10, 1)
	r.Title:SetJustifyH("LEFT")
	r.Title:SetWordWrap(false)
	r.Why = W.Text(r, "note", "textDim")
	r.Why:SetPoint("TOPLEFT", r.Title, "BOTTOMLEFT", 0, -3)
	r.Why:SetJustifyH("LEFT")
	r.Why:SetWordWrap(false)
	pool[i] = r
	return r
end

-- A row's texts run up to its Search button while the Auction House is open, else to its edge.
local function fill(r, item, count, title, why, open)
	r.psItem, r.psCount, r.Item.psItem = item, count, item
	r.Item.Icon:SetTexture(ns.Compat.ItemIcon(item) or 134400)
	r.Title:SetText(title)
	r.Why:SetText(why)
	r.Search:SetShown(open)
	local right = open and r.Search or r
	local point = open and "LEFT" or "RIGHT"
	r.Title:SetPoint("RIGHT", right, point, open and -8 or 0, 0)
	r.Why:SetPoint("RIGHT", right, point, open and -8 or 0, 0)
end

-- What the running profession guide still buys (Materials.BuyRows), or none.
local function materials()
	local M = ns.Materials
	return M and M.BuyRows and M.BuyRows() or {}
end

local function auctionOpen()
	local M = ns.Materials
	return M and M.AuctionOpen and M.AuctionOpen() or false
end

-- Fill the list from what the quests and the profession guide need now.
function AU.Layout()
	if not (F and F:IsShown()) then return end
	local list = on() and AB().List("all") or {}
	local mats = materials()
	local open = auctionOpen()
	local hint
	if #list == 0 and #mats > 0 then
		hint = L["Your profession guide buys these at the Auction House: what is still to get after your bags, bank and mail."]
	elseif not on() then
		hint = L["Auction house buys are off. Turn them back on under Options > Questing > Quests."]
	elseif #list == 0 then
		hint = L["Nothing to buy at the auction house: the quests ahead get what they need on the way."]
	else
		hint = L["The quests ahead in your guide and in your quest log need these. No vendor sells them, and farming them is slow or not possible: the auction house usually has them."]
	end
	if open and (#list + #mats) > 0 then hint = hint .. " " .. L["Search opens one in the Auction House with the count filled in; buying is your click."] end
	F.Hint:SetText(hint)
	local y = HEAD_H + 12 + F.Hint:GetStringHeight() + 12
	for i, e in ipairs(list) do
		local r = row(i)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -y)
		r:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD, -y)
		local parts = { format(L["For %s"], questNames(e)), AU.Why(e) }
		if e.have > 0 then parts[#parts + 1] = format(L["%d in your bags and bank"], e.have) end
		-- Its price for that many, once a search showed it (the materials' prices: Materials.Price).
		local M = ns.Materials
		local price = M and M.Price and M.Price(e.item, e.need)
		if price then parts[#parts + 1] = format(L["≈ %s"], ns.MoneyText(price)) end
		fill(r, e.item, e.need, format(L["%d %s"], e.need, e.name), concat(parts, DOT), open)
		r:Show()
		y = y + ROW_H + 6
	end
	for i = #list + 1, #F.rows do F.rows[i]:Hide() end
	-- The profession guide's materials, under a heading naming the guide.
	F.MatHead:SetShown(#mats > 0)
	if #mats > 0 then
		if #list > 0 then y = y + 6 end
		F.MatHead:ClearAllPoints()
		F.MatHead:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -y)
		F.MatHead:SetText(format(L["MATERIALS FOR %s"], (mats[1].guideTitle or ""):upper()))
		y = y + 20
	end
	for i, e in ipairs(mats) do
		local r = row(i, F.mrows)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -y)
		r:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD, -y)
		local parts = { e.section }
		if e.price then parts[#parts + 1] = format(L["≈ %s"], ns.MoneyText(e.price)) end
		if e.have > 0 then parts[#parts + 1] = format(L["%s held"], e.have) end
		fill(r, e.item, e.toBuy, format(L["%d %s"], e.toBuy, ns.Compat.GetItemName(e.item) or e.name), concat(parts, DOT), open)
		r:Show()
		y = y + ROW_H + 6
	end
	for i = #mats + 1, #F.mrows do F.mrows[i]:Hide() end
	-- At the Auction House already, nothing to point the arrow at.
	local go = (#list + #mats) > 0 and not open
	F.Go:ClearAllPoints()
	F.Go:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD, -y)
	F.Go:SetShown(go)
	if go then y = y + 28 + 6 end
	F:SetHeight(y + PAD - 6)
end

function AU.Show()
	if not F then build() end
	F:Show()
	AU.Layout()
end

function AU.Hide()
	if F then F:Hide() end
end
UI.ShowAuctionBuys = AU.Show

-- The guide window's menu: "Auction house buys (N)" while there are any.
function AU.MenuItem()
	if not on() then return nil end
	local n = #AB().List("all")
	if n == 0 then return nil end
	return { text = format(L["Auction house buys (%d)"], n), icon = "icon-buy", onClick = AU.Show }
end

---------------------------------------------------------------------------
-- Events and the command
---------------------------------------------------------------------------

-- A guide opened, or the window switched to it: its card, once its catch-up
-- has placed the live step.
ns.On("GUIDE_CHANGED", function(id)
	if not (id and on()) or told()[id] then return end
	ns.After(AU.START_DELAY, function() AU.CheckGuide(id) end)
end)

for _, event in ipairs({ "ZONE_CHANGED_NEW_AREA", "ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "PLAYER_ENTERING_WORLD" }) do
	ns.RegisterEvent(event, checkTownSoon)
end

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if AU.startDue then
		local id = AU.startDue
		ns.After(0.5, function() AU.CheckGuide(id) end)
	end
	if AU.townDue then
		AU.townDue = nil
		checkTownSoon()
	end
end)

-- One of these cards on screen follows its list: what was bought, an item
-- the client loaded late; with nothing left to buy it goes.
local function refreshCard()
	local T = CT()
	local m = T and T.current
	if not (m and (m.kind == "auctionGuide" or m.kind == "auctionTown")) then return end
	local kind = m.kind == "auctionTown" and "town" or "guide"
	local E = ns.Engine
	local g = E and E.GetGuide and E.GetGuide()
	-- The guide's card is about its guide: another one running, it goes.
	if kind == "guide" and not (g and g.id == m.forGuide) then return T.Hide() end
	local list = AB().List(kind == "town" and "all" or "guide")
	if #list == 0 then return T.Hide() end
	local fresh = AU.CardModel(kind, list, m.town)
	fresh.forGuide = m.forGuide
	T.ShowCard(fresh)
end

-- The lists changed (the bags, the log, the guide's step, an item the client
-- loaded): the window, a card on screen or waiting, and the reminder follow.
ns.On("AUCTION_BUYS_CHANGED", function()
	AU.Layout()
	refreshCard()
	if AU.startDue then AU.CheckGuide(AU.startDue) end
	checkTownSoon()
end)

-- A heads-up dismissed: one of these that waited for the card shows.
ns.On("HEADS_UP_HIDDEN", function()
	ns.After(0.5, function()
		local T = CT()
		if T and T.current then return end
		for _, kind in ipairs({ "auctionGuide", "auctionTown" }) do
			local retry = waiting[kind]
			if retry then
				waiting[kind] = nil
				retry()
				return
			end
		end
	end)
end)

-- Turned off: the card goes, the list says so.
ns.On("SETTING_CHANGED", function(path)
	if not (path == "" or path == "qol" or path == "qol.auctionBuys") then return end
	if on() then return end
	local T = CT()
	local cur = T and T.current
	if cur and (cur.kind == "auctionGuide" or cur.kind == "auctionTown") then T.Hide() end
	waiting = {}
	AU.Layout()
end)

-- At the Auction House: the list opens beside the game's window while either group has something to buy, and goes
-- with it; its rows' Search buttons come and go with the window.
ns.RegisterEvent("AUCTION_HOUSE_SHOW", function()
	ns.After(0, function()
		local AHF = AuctionHouseFrame
		if not (AHF and AHF.IsShown and AHF:IsShown()) or ns.Hidden() then return end
		if (on() and #AB().List("all") or 0) + #materials() == 0 then
			AU.Layout()
			return
		end
		if not F then build() end
		F.psDocked = true
		F:ClearAllPoints()
		F:SetPoint("TOPLEFT", AHF, "TOPRIGHT", 8, 0)
		AU.Show()
	end)
end)
ns.RegisterEvent("AUCTION_HOUSE_CLOSED", function()
	if F and F.psDocked then
		F.psDocked = nil
		F:Hide()
		F:ClearAllPoints()
		F:SetPoint("CENTER", UIParent, "CENTER", 0, 120)
	end
	AU.Layout()
end)

-- The profession guide's ways, counts and prices changed: the window follows, once the burst is over.
local due = false
local function relayout()
	if due or not (F and F:IsShown()) then return end
	due = true
	ns.After(0.2, function()
		due = false
		AU.Layout()
	end)
end
for _, msg in ipairs({ "MATERIALS_CHANGED", "MATERIALS_COUNTS", "MATERIALS_PRICES", "STEP_CHANGED", "GUIDE_CHANGED" }) do ns.On(msg, relayout) end

ns.RegisterCommand("ah", function() AU.Show() end, L["Show the quest items to buy at the auction house"])
