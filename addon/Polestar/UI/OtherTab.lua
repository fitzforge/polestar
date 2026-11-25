-- The other-tab card (#2783): while another open tab's live step is close
-- by, the guide window says so above the step, in a look of its own so it is
-- never read as a step of the guide on screen: a sky stripe and border on a
-- light sky wash, "Other tab · 25 yd", that tab's icon and guide title, its
-- step. A click switches to that tab (Engine.SelectTab). It shows once the
-- step is within SHOW yards and stays until it is past HIDE, so walking about
-- the spot never blinks it. Checked every EVERY seconds while two tabs or
-- more are open (Engine.OtherTabPlaces), never per frame.
-- guideWindow.otherTabNear (on by default; Settings > Guide window > Bars,
-- by Tabs) turns it off.
--
-- The window places it under the alerts, over the class quest card and the
-- step (UI/GuideFrameLayout.lua), unless a layout takes it (guidePlace
-- "otherTab", as Atlas stacks it above the window). A layout that dresses
-- it its own way sets F.psPlain: no wash, stripe or border of the card's.
--
--   UI.OtherTabCard.Check(), .Layout(width, y) -> height, .Frame(),
--   .Shown() -> the entry shown or nil, .Dismiss(), .SHOW, .HIDE

local ADDON, ns = ...
local UI, Theme, W, L = ns.UI, ns.Theme, ns.Widgets, ns.L

local O = {}
UI.OtherTabCard = O

O.SHOW, O.HIDE = 30, 300
local EVERY = 1
local INSET, STRIPE, ICON = 8, 3, 14
local DIST = { round = 5 }

ns.RegisterDefaults("guideWindow", { otherTabNear = true })

local F, ticker
local near -- { e = Engine.OtherTabPlaces entry, key, yards } shown, else nil
local dismissed -- the key put away by a layout's ×, until it is out of range

local paint -- (): the card's colours; defined with SKY
local function GF() return UI.GuideFrame end
local function on() return ns.Get("guideWindow.otherTabNear") ~= false end
local function keyOf(e) return e.guideId .. ":" .. e.step end

local function relayout()
	local G = GF()
	if G and G.Layout and G.frame then G.Layout() end
end

local function text(parent, role, color)
	local G = GF()
	if G and G.Text then return G.Text(parent, role, color) end
	return W.Text(parent, role, color)
end

local function build()
	local G = GF()
	local card = G and G.parts and G.parts.card
	if F or not card then return F end
	F = CreateFrame("Button", nil, card)
	F:Hide()
	F:RegisterForClicks("LeftButtonUp")
	F.Wash = F:CreateTexture(nil, "BACKGROUND", nil, 1)
	F.Wash:SetTexture(Theme.Media("white"))
	F.Wash:SetAllPoints(F)
	F.Stripe = F:CreateTexture(nil, "BORDER", nil, 2)
	F.Stripe:SetTexture(Theme.Media("white"))
	F.Stripe:SetWidth(STRIPE)
	F.Stripe:SetPoint("TOPLEFT", F, "TOPLEFT", 0, 0)
	F.Stripe:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 0, 0)
	F.Head = text(F, "caption", "textMuted")
	F.Head:SetWordWrap(false)
	F.Icon = F:CreateTexture(nil, "ARTWORK")
	F.Icon:SetSize(ICON, ICON)
	F.Title = text(F, "label", "text")
	F.Title:SetWordWrap(true)
	F.Go = F:CreateTexture(nil, "ARTWORK")
	F.Go:SetTexture(Theme.Media("chevron-right"))
	F.Go:SetSize(12, 12)
	F.Go:SetPoint("RIGHT", F, "RIGHT", -10, 0)
	F:SetScript("OnClick", function()
		local E = ns.Engine
		if near and E and E.SelectTab then E.SelectTab(near.e.index) end
	end)
	-- Hover deepens the wash through its vertex colour, never SetAlpha: in
	-- the client a texture's alpha IS its vertex colour's alpha, so
	-- SetAlpha(1.6) drew it solid sky, and the stripe, icon and chevron, the
	-- same sky, vanished into it (#1684 was the same for the text shades).
	F:SetScript("OnEnter", function(self) self.psHover = true; paint() end)
	F:SetScript("OnLeave", function(self) self.psHover = nil; paint() end)
	return F
end

-- The card's own sky blue, not the accent the guide's own parts wear (the
-- house look's link blue): the same in every look, since a look's own blue is
-- its ground ("sky" is the dark header band) or its gold (a game look's
-- link). A look may give its own as the palette's `otherTab`.
local SKY = { 0x8C / 255, 0xCB / 255, 1 }
local WASH, WASH_HOVER = 0.12, 0.2
function paint()
	local pal = Theme.Palette and Theme.Palette()
	local c = type(pal) == "table" and rawget(pal, "otherTab") or SKY
	local r, g, b = c[1], c[2], c[3]
	F.Wash:SetVertexColor(r, g, b, F.psHover and WASH_HOVER or WASH)
	F.Stripe:SetVertexColor(r, g, b, 1)
	F.Wash:SetShown(not F.psPlain)
	F.Stripe:SetShown(not F.psPlain)
	F.Icon:SetVertexColor(r, g, b, 1)
	F.Go:SetVertexColor(r, g, b, 1)
	F.Head:SetTextColor(r, g, b, 1)
	local e = Theme.Border(F, r, g, b, 0.6)
	if F.psPlain and e then for i = 1, 4 do e[i]:Hide() end end
end

local function headText()
	return L["Other tab"] .. "  \194\183  " .. ns.FormatDistance(near.yards, DIST)
end

local function fill()
	if not build() then return end
	local e = near.e
	paint()
	local G = GF()
	F.Icon:SetTexture(Theme.Media(G and G.TabIcon and G.TabIcon(e, e) or "icon-level"))
	F.Head:SetText(headText())
	F.Title:SetText(string.format(L["%s: step %s is close. Click to switch to it."], e.title or e.guideId, tostring(e.stepNumber or e.step)))
	F:Show()
end

-- Look again where the other tabs' steps are. Shows, keeps or hides the card,
-- laying the window out again only when what it shows changes.
function O.Check()
	local E, C = ns.Engine, ns.Compat
	local pick, yards
	if on() and E and E.OtherTabPlaces and C and C.GetPlayerWorldPosition and not ns.Hidden() then
		local c, px, py = C.GetPlayerWorldPosition()
		local inRange = {}
		if c then
			for _, e in ipairs(E.OtherTabPlaces()) do
				local gc, gx, gy = C.MapToWorld(e.map, e.x, e.y, e.f)
				if gc == c then
					local d = math.sqrt((gx - px) ^ 2 + (gy - py) ^ 2)
					local k = keyOf(e)
					if d <= O.HIDE then inRange[k] = true end
					local limit = (near and near.key == k) and O.HIDE or O.SHOW
					if d <= limit and k ~= dismissed and (not yards or d < yards) then pick, yards = e, d end
				end
			end
		end
		if dismissed and not inRange[dismissed] then dismissed = nil end
	end
	local was = near and near.key
	if pick then
		near = { e = pick, key = keyOf(pick), yards = yards }
		if was ~= near.key or near.e.index ~= (F and F.psIndex) then
			fill()
			if F then F.psIndex = pick.index end
			relayout()
		elseif F then
			F.Head:SetText(headText())
		end
	elseif near then
		near = nil
		if F then F:Hide() end
		relayout()
	end
end

-- The tick runs while two tabs or more are open and the card is on.
local function watch(n)
	local want = on() and (n or 0) >= 2
	if want and not ticker and C_Timer and C_Timer.NewTicker then
		ticker = ns.NewTicker(EVERY, O.Check)
	elseif not want and ticker then
		ticker:Cancel()
		ticker = nil
	end
	O.Check()
end

function O.Shown() return near and near.e or nil end
function O.Frame() return F end
-- A layout's × on the card: away until that step is out of range.
function O.Dismiss()
	if near then dismissed = near.key end
	O.Check()
end

-- Place the card `y` down the guide window's card, `width` wide. -> its
-- height with its margins (0 while hidden).
function O.Layout(width, y)
	if not (F and near and F:IsShown()) then return 0 end
	-- Its own look until a layout takes it again (guidePlace "otherTab"),
	-- which may give its strings other faces.
	F.psPlain = nil
	Theme.Font(F.Head, "caption")
	Theme.Font(F.Title, "label")
	-- Again on each layout: a look's repaint gives the strings back their
	-- theme colours (the head's textMuted) and leaves the wash in the old look's.
	paint()
	local w = width - INSET * 2
	local x = STRIPE + 10
	F.Head:ClearAllPoints()
	F.Head:SetPoint("TOPLEFT", F, "TOPLEFT", x, -7)
	F.Head:SetWidth(math.max(40, w - x - 28))
	F.Icon:ClearAllPoints()
	F.Icon:SetPoint("TOPLEFT", F.Head, "BOTTOMLEFT", 0, -5)
	F.Title:ClearAllPoints()
	F.Title:SetPoint("TOPLEFT", F.Icon, "TOPRIGHT", 6, 1)
	F.Title:SetWidth(math.max(40, w - x - ICON - 6 - 28))
	local h = math.floor(7 + F.Head:GetStringHeight() + 5 + math.max(ICON, F.Title:GetStringHeight()) + 8 + 0.5)
	F:SetSize(w, h)
	F:ClearAllPoints()
	-- On the guide window's card (its home), though a layout held it last time.
	F:SetPoint("TOPLEFT", F.psHome or F:GetParent(), "TOPLEFT", INSET, -((y or 0) + INSET))
	return h + INSET
end

ns.On("TABS_CHANGED", function(list) watch(type(list) == "table" and #list or 0) end)
ns.On("SETTING_CHANGED", function(path)
	if path == "guideWindow.otherTabNear" then
		local E = ns.Engine
		local ids, n = E and E.TabIds and E.TabIds() or {}, 0
		for _ in pairs(ids) do n = n + 1 end
		watch(n)
	end
end)
