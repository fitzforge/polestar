-- Atlas's dungeon parts (docs/DESIGN.md, "The Guide Window" and "The Dungeon
-- Tracker"; Polestar/UI/GuideFrameKindDungeon.lua, Polestar/UI/DungeonTracker.lua):
-- a dungeon guide's quests to pick up as a card above the window, and the
-- floating dungeon tracker's loot, quests and bosses as three stacked cards,
-- with no head of the tracker's over them (their headings say what it would;
-- the tracker's frame shrinks to the cards' anchor and the cards move it).
-- Loaded before Atlas.lua, which hands each part in
-- S.atlasParts its hook registry, its leave list and its Core.

local _, S = ...
S.atlasParts = S.atlasParts or {}

S.atlasParts[#S.atlasParts + 1] = function(on, onLeave, Core)
	local P = Polestar
	local Theme = P and P.Theme
	if not (Theme and Core.regionCard and Core.capsLabel and Core.cardDress) then return end
	local tr = Core.tr

	---------------------------------------------------------------------------
	-- The quests to pick up: a card above the window
	---------------------------------------------------------------------------

	local styled = setmetatable({}, { __mode = "k" }) -- region frame -> true while dressed as a card

	local CARD_PAD = 14
	on("guidePlace", function(name, part, width, height)
		if name ~= "pickups" then return nil end
		local head = rawget(part, "Head")
		if head then
			-- Its head line is the card's caps heading: "QUESTS TO PICK UP", the count at the right.
			head.Text:SetText(Core.upper(tr(rawget(part, "psCardHead") or "")))
			Core.capsLabel(head.Text)
			head.Text:ClearAllPoints()
			head.Text:SetPoint("LEFT", head, "TOPLEFT", CARD_PAD, -12)
			head.Icon:Hide()
			head.Bar:Hide()
			styled[part] = true
		end
		return Core.regionCard(name, part, width, height)
	end)

	---------------------------------------------------------------------------
	-- The floating tracker: three cards under its head
	---------------------------------------------------------------------------

	local holders = setmetatable({}, { __mode = "k" }) -- tracker frame -> { holder, cards = { name -> card } }
	local flat = setmetatable({}, { __mode = "k" }) -- the tracker's own amber cards, flattened into their Atlas card
	local HEAD_H = 24
	local GAP = 6
	local ORDER = { loot = 1, quests = 2, bosses = 3 }

	local function holderOf(tracker)
		local h = holders[tracker]
		if h then return h end
		h = { cards = {}, placed = {}, tracker = tracker }
		h.frame = CreateFrame("Frame", tracker:GetName() == "PolestarDungeonTracker" and "PolestarAtlasDungeonCards" or nil, tracker)
		h.frame:SetHeight(1)
		holders[tracker] = h
		return h
	end

	-- The cards start at the frame's top where the quests stand on one (the tracker has no head then), else
	-- under its head.
	local function anchorHolder(h)
		local t = h.tracker
		local up = h.placed.quests and h.placed.quests:IsShown()
		h.frame:ClearAllPoints()
		if up then
			h.frame:SetPoint("TOPLEFT", t, "TOPLEFT", 0, 0)
			h.frame:SetPoint("TOPRIGHT", t, "TOPRIGHT", 0, 0)
		else
			h.frame:SetPoint("TOPLEFT", t, "BOTTOMLEFT", 0, -GAP)
			h.frame:SetPoint("TOPRIGHT", t, "BOTTOMRIGHT", 0, -GAP)
		end
	end

	local function cardOf(h, name, tracker)
		local c = h.cards[name]
		if not c then
			c = CreateFrame("Frame", nil, h.frame)
			Core.cardDress(c, tracker)
			c.Head = c:CreateFontString(nil, "OVERLAY")
			Theme.Font(c.Head, "caption")
			c.Head:SetPoint("TOPLEFT", c, "TOPLEFT", 12, -8)
			c.Right = c:CreateFontString(nil, "OVERLAY")
			Theme.Font(c.Right, "small")
			c.Right:SetPoint("TOPRIGHT", c, "TOPRIGHT", -12, -9)
			-- The cards move the tracker as its frame does (the frame itself is a line without its head).
			if tracker.psDrag and P.DragWindow then P.DragWindow(c, tracker, tracker.psDrag) end
			h.cards[name] = c
		end
		Core.cardDress(c, tracker)
		return c
	end

	-- The tracker's own frame for a section (its parent's parent chain): the floating one only.
	local function trackerOf(part)
		local p = part:GetParent()
		if p and p.GetName and p:GetName() == "PolestarDungeonTracker" then return p end
		return nil
	end

	-- The room a section keeps over its rows for its own heading (UI/DungeonTracker.lua's
	-- layout): the card's heading stands there instead.
	local OWN_HEAD = { loot = 0, quests = 24, bosses = 28 }

	-- Lays the cards out in order, each the height its section asked.
	local function stackCards(h)
		anchorHolder(h)
		local y = 0
		for _, name in ipairs({ "loot", "quests", "bosses" }) do
			local c, part = h.cards[name], h.placed[name]
			if c and part and part:IsShown() then
				local up = HEAD_H - OWN_HEAD[name]
				local ch = up + (part.psCardH or 0)
				c:ClearAllPoints()
				c:SetPoint("TOPLEFT", h.frame, "TOPLEFT", 0, -y)
				c:SetPoint("TOPRIGHT", h.frame, "TOPRIGHT", 0, -y)
				c:SetHeight(ch)
				c:Show()
				part:ClearAllPoints()
				part:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -up)
				part:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, -up)
				part:SetFrameLevel(c:GetFrameLevel() + 2)
				y = y + ch + GAP
			elseif c then
				c:Hide()
			end
		end
		h.frame:SetHeight(math.max(1, y))
		h.frame:Show()
	end

	-- The reminder's own amber card, flat on the Atlas card: its ground, wash and bar go (a card in a card);
	-- the Atlas card carries the 2px warning bar, and the entries stand where the other cards' rows do.
	local function flatten(c, part)
		if not c.psWarnBar then
			c.psWarnBar = P.Widgets.Tex(c, "ARTWORK", nil, "warning")
			c.psWarnBar:SetWidth(2)
			c.psWarnBar:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
			c.psWarnBar:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", 0, 0)
		end
		c.psWarnBar:Show()
		local y = 0
		for _, ic in ipairs(rawget(part, "Cards") or {}) do
			if ic:IsShown() then
				flat[ic] = true
				ic.Face:Hide()
				ic.Face:SetAlpha(0) -- and clear: the skin's repaints must not bring its pieces back
				ic:ClearAllPoints()
				ic:SetPoint("TOPLEFT", part, "TOPLEFT", 0, -y)
				ic:SetPoint("TOPRIGHT", part, "TOPRIGHT", 0, -y)
				y = y + ic:GetHeight() + 4
			end
		end
	end

	on("trackerPlace", function(name, part, width, height)
		if not ORDER[name] then return nil end
		local tracker = trackerOf(part)
		if not tracker then return nil end
		local h = holderOf(tracker)
		local c = cardOf(h, name, tracker)
		local DT = P.UI and P.UI.DungeonTracker
		local m = DT and DT.Model and DT.Model() or {}
		local HEADS = DT and DT.CARD_HEADS or {}
		-- The section's own heading gives way to the card's.
		local label, right, rule = rawget(part, "Label"), rawget(part, "Right"), rawget(part, "Rule")
		if name == "quests" then
			c.Head:SetText(Core.upper(string.format(tr(HEADS.quests or "%s"), m.name or "")))
			c.Right:SetText(right and right:GetText() or "")
		elseif name == "bosses" then
			c.Head:SetText(Core.upper(tr(HEADS.bosses or "")))
			c.Right:SetText(string.format("%d / %d", m.bossesDone or 0, m.bossesTotal or 0) .. (m.elapsed and P.Maps and (" \194\183 " .. P.Maps.FormatTime(m.elapsed)) or ""))
		else
			c.Head:SetText(Core.upper(tr(HEADS.loot or "")))
			c.Right:SetText("")
			flatten(c, part)
		end
		for _, r in ipairs({ label, right, rule }) do r:Hide() end
		Core.capsLabel(c.Head)
		if name == "loot" then c.Head:SetTextColor(Theme.Color("warning")) end
		c.Right:SetTextColor(Theme.Color("textDim"))
		part.psCardH = height
		h.placed[name] = part
		stackCards(h)
		return true
	end)

	onLeave(function()
		for tracker, h in pairs(holders) do
			h.frame:Hide()
			h.placed = {}
			local loot = h.cards.loot
			if loot and loot.psWarnBar then loot.psWarnBar:Hide() end
		end
		for ic in pairs(flat) do
			ic.Face:Show()
			ic.Face:SetAlpha(1)
			flat[ic] = nil
		end
		for part in pairs(styled) do
			local head = rawget(part, "Head")
			if head then
				Theme.Font(head.Text, "goal")
				if P.Widgets then P.Widgets.Color(head.Text, "text") end
				head.Icon:Show()
			end
			styled[part] = nil
		end
		local DT = P.UI and P.UI.DungeonTracker
		if DT and DT.Refresh then DT.Refresh() end
	end)
end
