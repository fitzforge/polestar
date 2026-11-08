-- The class-quest card: above the goals of a step whose accept is one of
-- the character's class quests: the quest data limits the quest to a few
-- classes, the character's among them (UI/ClassRewards.lua). A step or goal
-- `only <Class>` is a route choice, not a class quest (Mulgore's Druid trip
-- to Thunder Bluff), and a Class guide carries open errands too.
-- In the class colour: a border, a 4 px stripe on the left and a soft glow
-- from it; the chain's reward icon in a ring (the spell it teaches, else the
-- item it gives, else the class icon); "<CLASS> · LEVEL <n>", the quest's
-- name, "Learn <spell>" / "Earn <item>", a badge for what it brings (a new
-- ability, pet, mount, weapon or armour), the trip (the zones the chain's
-- remaining steps go through and how many steps) and "Only you see this ...
-- Part of your route: just follow the guide." The step's accept folds into
-- the card with its tick box. Once that accept is done, the card shrinks to
-- one slim line in the class colour ("Mage quest taken: hand it in to
-- Marryk Nurribit"), so the step's person keeps the focus; it goes once the
-- quest is handed in or its reward known.
-- The step's quest names take the class colour too (GuideFrame fillCard).
--
-- The first time a chain's card shows on a character it shines once (a soft
-- flash under ui.reduceMotion) and, with ui.classCardSound on, plays a short
-- chime on the game's sound effects channel.
--
-- What each chain gives comes from UI/ClassRewards.lua (classrewards build).
-- GuideFrame calls Fill on every render and Layout in its card layout; the
-- card is built on first use, under the guide window's card.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, format, type, ipairs = math.floor, math.max, string.format, type, ipairs

local CC = {}
UI.ClassCard = CC

local CLASS_BIT = { WARRIOR = 1, PALADIN = 2, HUNTER = 4, ROGUE = 8, PRIEST = 16, SHAMAN = 64, MAGE = 128, WARLOCK = 256, DRUID = 1024 }
local BADGE = { ability = L["NEW ABILITY"], pet = L["NEW PET"], mount = L["NEW MOUNT"], weapon = L["NEW WEAPON"], armor = L["NEW ARMOR"] }
-- "›", not "→": the game's font has no arrow glyph and drew a box between the route's places.
local ARROW = "  \226\128\186  "
local DOT = "  \194\183  "
local INSET = 8   -- the card's margin in the window
local RING = 40
local RING_COMPACT = 28
local STRIPE = 4
local SHINE_W = 70
local SHINE_SECONDS = 0.7

local F -- the card frame
local shown -- what the card shows: { key, reward, class, quest }

local function GF() return UI.GuideFrame end

local function text(parent, role, color)
	local G = GF()
	if G and G.Text then return G.Text(parent, role, color) end
	return W.Text(parent, role, color)
end

local function compact() return ns.Get("ui.compact") and true or false end

---------------------------------------------------------------------------
-- Which quests are class quests, and what their chain gives
---------------------------------------------------------------------------

local function hasBit(mask, b)
	return type(mask) == "number" and b ~= nil and floor(mask / b) % 2 == 1
end

local function lists(list, value)
	if type(list) ~= "table" then return false end
	for _, v in ipairs(list) do if v == value then return true end end
	return false
end

local function entry(quest)
	local d = ns.ClassRewards
	return quest and d and d.quests and d.quests[quest] or nil
end

local function player()
	local C = ns.Compat
	if not (C and C.GetPlayerInfo) then return nil end
	local ok, p = pcall(C.GetPlayerInfo)
	return ok and type(p) == "table" and p or nil
end

local function matches(only, p)
	if type(only) ~= "table" then return true end
	local G = ns.Guides
	if G and G.Matches then
		local ok, yes = pcall(G.Matches, only, p)
		if ok then return yes end
	end
	return (only.classes == nil or lists(only.classes, p.class)) and (only.factions == nil or lists(only.factions, p.faction))
end

-- Whether `goal` (a guide step's goal) is a quest of class `class`: its data
-- names the class among a few (ClassRewards keeps no mask for a quest open
-- to every class, or to every class but one, #812).
local function classQuest(goal, class)
	local e = goal.quest and entry(goal.quest)
	return e ~= nil and hasBit(e[1], CLASS_BIT[class])
end
CC.ClassQuest = classQuest

-- Whether the chain of class quest `quest` gives what the character already
-- knows or owns (CT.RewardKnown): a Skyborne Druid who learned Bear Form on
-- Zephras Isle is not told to learn it at Child of Nature.
local function rewardKnown(quest)
	local e, d, CT = entry(quest), ns.ClassRewards, UI.ClassToast
	local reward = e and e[3] and e[3] > 0 and d and d.rewards and d.rewards[e[3]] or nil
	return reward ~= nil and CT ~= nil and CT.RewardKnown ~= nil and CT.RewardKnown(reward) or false
end

-- Whether the class quest of accept goal `goal` is handed in: the game says
-- so, or the step's own turn-in of it is done.
local function handedIn(step, view, goal)
	local C = ns.Compat
	local ok, done = false, false
	if C and C.IsQuestCompleted then ok, done = pcall(C.IsQuestCompleted, goal.quest) end
	if ok and done then return true end
	for gi, g in ipairs(step.goals) do
		local v = view.goals[gi]
		if g.t == "turnin" and g.quest == goal.quest and v and v.status == "done" then return true end
	end
	return false
end

-- The step's class quest the card is for: its first accept of one that
-- applies, else its first such turn-in. A turn-in of a class quest still in
-- the log comes before an accept of another one (the chain's next part,
-- given once it is handed in): the card's open tick box for that accept
-- read as though the quest in the log were not taken, every part of a chain
-- like Call of Water bearing the same name (#1372). None for a chain whose
-- reward the character already knows or owns, nor once the accept is done
-- and its quest handed in: the card is gone then, and the accept reads as a
-- row like any other. -> goal index | nil
local function cardGoal(step, view, p)
	local turnin, held, accept
	local C = ns.Compat
	for gi, goal in ipairs(step.goals) do
		local v = view.goals[gi]
		if (goal.t == "accept" or goal.t == "turnin") and v and v.status ~= "na" and matches(goal.only, p) and classQuest(goal, p.class) and not rewardKnown(goal.quest) then
			if goal.t == "accept" then
				accept = accept or gi
			else
				turnin = turnin or gi
				if not held and v.status ~= "done" and v.status ~= "skipped" and C and C.IsOnQuest and C.IsOnQuest(goal.quest) then held = gi end
			end
		end
	end
	if accept then
		local goal, v = step.goals[accept], view.goals[accept]
		if v.status ~= "done" and held and step.goals[held].quest ~= goal.quest then return held end
		if v.status == "done" and handedIn(step, view, goal) then return nil end
		return accept
	end
	return turnin
end

-- The chain a quest belongs to: its data's, else the quest itself.
local function chainOf(quest)
	local e = entry(quest)
	return e and e[2] or quest
end

-- The steps from `index` on that carry a quest of the chain: their count and
-- the zones they go through, in order, each once in a row.
local function trip(guide, index, chain, quest, p)
	local zones, n, last = {}, 0, nil
	for s = index, #guide.steps do
		local step = guide.steps[s]
		if matches(step.only, p) then
			local mine, map = false, nil
			for _, goal in ipairs(step.goals) do
				if matches(goal.only, p) then
					if goal.quest and (goal.quest == quest or (entry(goal.quest) and chainOf(goal.quest) == chain)) then mine = true end
					map = map or goal.map
				end
			end
			if mine then
				n = n + 1
				local name = map and UI.MapName(map)
				if name and name ~= last then
					zones[#zones + 1] = name
					last = name
				end
			end
		end
	end
	return zones, n
end

local function npcOf(goal, gv)
	return (gv and gv.npcName) or goal.npcName or goal.objName
end

-- Who the class quest goes to after its accept at step `index`: the step's
-- own turn-in of it, else the first later step that carries the chain (its
-- turn-in of the quest, else its first goal of the chain).
-- -> name | nil, whether it is a later step
local function handIn(guide, index, view, quest, chain, p)
	local step = guide.steps[index]
	for gi, goal in ipairs(step.goals) do
		local v = view.goals[gi]
		if goal.t == "turnin" and goal.quest == quest and v and v.status ~= "na" and matches(goal.only, p) then
			return npcOf(goal, v), false
		end
	end
	for s = index + 1, #guide.steps do
		local st = guide.steps[s]
		if matches(st.only, p) then
			local first
			for _, goal in ipairs(st.goals) do
				if goal.quest and matches(goal.only, p) then
					if goal.t == "turnin" and goal.quest == quest then return npcOf(goal), true end
					if not first and (goal.quest == quest or (entry(goal.quest) and chainOf(goal.quest) == chain)) then first = goal end
				end
			end
			if first then return npcOf(first), true end
		end
	end
	return nil, false
end

---------------------------------------------------------------------------
-- The reward's names and icon
---------------------------------------------------------------------------

local function spellName(id, fallback)
	local n
	if C_Spell and C_Spell.GetSpellName then n = C_Spell.GetSpellName(id) end
	if not n and GetSpellInfo then n = GetSpellInfo(id) end
	return (type(n) == "string" and n ~= "") and n or fallback
end

local function itemName(id, fallback)
	local n
	if C_Item and C_Item.GetItemNameByID then n = C_Item.GetItemNameByID(id) end
	if not n and GetItemInfo then n = GetItemInfo(id) end
	return (type(n) == "string" and n ~= "") and n or fallback
end

local function spellIcon(id)
	local t
	if C_Spell and C_Spell.GetSpellTexture then t = C_Spell.GetSpellTexture(id) end
	if not t and GetSpellTexture then t = GetSpellTexture(id) end
	return t
end

local function itemIcon(id)
	local t
	if C_Item and C_Item.GetItemIconByID then t = C_Item.GetItemIconByID(id) end
	if not t and GetItemIcon then t = GetItemIcon(id) end
	return t
end

local function classIcon(class)
	return "Interface\\Icons\\ClassIcon_" .. class:sub(1, 1) .. class:sub(2):lower()
end

-- The reward's icon: its spell's, else its (first) item's, else the class's.
function CC.Icon(reward, class)
	local t
	if reward and reward.show == "spell" and reward.spell then t = spellIcon(reward.spell) end
	if not t and reward and reward.items then t = itemIcon(reward.items[1]) end
	if not t and reward and reward.spell then t = spellIcon(reward.spell) end
	if not t and reward and reward.icon then t = reward.icon end
	return t or classIcon(class)
end

local function split(s)
	local out = {}
	for w in s:gmatch("%S+") do out[#out + 1] = w end
	return out
end

-- "Whirlwind Axe, Sword or Warhammer": a choice's names, the words they all
-- start with said once.
local function choiceText(names)
	if #names == 1 then return names[1] end
	local words = {}
	for i, n in ipairs(names) do words[i] = split(n) end
	local k = 0
	while true do
		local w = words[1][k + 1]
		local all = w ~= nil
		for i = 1, #words do
			if words[i][k + 1] ~= w or #words[i] <= k + 1 then all = false end
		end
		if not all then break end
		k = k + 1
	end
	local parts = { names[1] }
	for i = 2, #names do
		parts[i] = k > 0 and table.concat(words[i], " ", k + 1) or names[i]
	end
	local out = parts[1]
	for i = 2, #parts - 1 do out = format(L["%s, %s"], out, parts[i]) end
	return format(L["%s or %s"], out, parts[#parts])
end

local function hexOf(r, g, b)
	return format("ff%02x%02x%02x", floor(r * 255 + 0.5), floor(g * 255 + 0.5), floor(b * 255 + 0.5))
end

-- The class colour for text: lifted until it reads on the window.
local function textColor(class)
	local r, g, b = Theme.ClassColor(class)
	if not r then return Theme.Accent() end
	return Theme.Legible(r, g, b)
end

-- The reward's name in the client's language: its spell's, else its item's
-- (a choice's names together); and whether it is a spell to learn. -> name, learns | nil
function CC.RewardName(reward)
	if not reward then return nil end
	if reward.spell and (reward.show == "spell" or reward.kind == "ability") and reward.show ~= "item" then
		return spellName(reward.spell, reward.spellName or ("#" .. reward.spell)), true
	end
	if reward.items then
		local names = {}
		for i, id in ipairs(reward.items) do names[i] = itemName(id, reward.itemNames and reward.itemNames[i] or ("#" .. id)) end
		return reward.choice and #names > 1 and choiceText(names) or names[1], false
	end
	if reward.spell then return spellName(reward.spell, reward.spellName or ("#" .. reward.spell)), true end
	return nil
end

-- Exposed for the level-up heads-up (UI/ClassToast.lua).
CC.Entry, CC.ChainOf, CC.Player, CC.Matches, CC.TextColor = entry, chainOf, player, matches, textColor

-- The reward line: "Learn Cat Form", "Earn the Whirlwind Axe, Sword or
-- Warhammer", "Earn Verigan's Fist"; nil without a reward.
function CC.RewardLine(reward, hex)
	if not reward then return nil end
	local paint = function(s) return hex and ("|c" .. hex .. s .. "|r") or s end
	if reward.spell and (reward.show == "spell" or reward.kind == "ability") then
		return format(L["Learn %s"], paint(spellName(reward.spell, reward.spellName or ("#" .. reward.spell))))
	end
	if reward.items then
		local names = {}
		for i, id in ipairs(reward.items) do
			names[i] = itemName(id, reward.itemNames and reward.itemNames[i] or ("#" .. id))
		end
		if reward.choice and #names > 1 then return format(L["Earn the %s"], paint(choiceText(names))) end
		return format(L["Earn %s"], paint(names[1]))
	end
	return nil
end

function CC.BadgeText(reward)
	return reward and BADGE[reward.kind] or nil
end

---------------------------------------------------------------------------
-- The frame
---------------------------------------------------------------------------

local function build()
	local G = GF()
	local card = G and G.parts and G.parts.card
	if F or not card then return F end
	F = CreateFrame("Frame", nil, card)
	F:Hide()
	CC.frame = F
	F.Glow = F:CreateTexture(nil, "BACKGROUND", nil, 1)
	F.Glow:SetTexture(Theme.Media("white"))
	F.Glow:SetAllPoints(F)
	F.Stripe = F:CreateTexture(nil, "BORDER", nil, 2)
	F.Stripe:SetTexture(Theme.Media("white"))
	F.Stripe:SetWidth(STRIPE)
	F.Stripe:SetPoint("TOPLEFT", F, "TOPLEFT", 0, 0)
	F.Stripe:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 0, 0)

	-- The ring: a class-colour disc, a dark one inside it, the icon on top.
	F.Ring = F:CreateTexture(nil, "ARTWORK", nil, 0)
	F.Ring:SetTexture(Theme.Media("circle"))
	F.Disc = F:CreateTexture(nil, "ARTWORK", nil, 1)
	F.Disc:SetTexture(Theme.Media("circle"))
	F.Disc:SetPoint("CENTER", F.Ring, "CENTER", 0, 0)
	F.Icon = F:CreateTexture(nil, "ARTWORK", nil, 2)
	F.Icon:SetPoint("CENTER", F.Ring, "CENTER", 0, 0)
	if F.CreateMaskTexture and F.Icon.AddMaskTexture then
		F.Mask = F:CreateMaskTexture()
		F.Mask:SetTexture(Theme.Media("circle"), "CLAMPTOBLACKADDITIONAL", "CLAMPTOBLACKADDITIONAL")
		F.Mask:SetAllPoints(F.Icon)
		F.Icon:AddMaskTexture(F.Mask)
	end

	F.Head = text(F, "small", "text")
	F.Title = text(F, "title", "text")
	F.Title:SetWordWrap(true)
	F.Learn = text(F, "label", "text")
	F.Learn:SetWordWrap(true)
	F.Trip = text(F, "small", "textDim")
	F.Trip:SetWordWrap(true)
	F.Only = text(F, "small", "textMuted")
	F.Only:SetWordWrap(true)
	-- The guide carries the class quest: the player just follows it.
	F.Only:SetText(L["Only you see this: it's your class's quest."] .. " " .. L["Part of your route: just follow the guide."])

	-- The folded accept: its line and the step's tick box at the right.
	F.Accept = CreateFrame("Frame", nil, F)
	F.Accept.Text = text(F.Accept, "small", "textDim")
	F.Accept.Text:SetPoint("LEFT", F.Accept, "LEFT", 0, 0)
	F.Accept.Text:SetWordWrap(true)
	F.Accept.Check = W.Checkbox(F.Accept, function(c)
		-- The Engine's view is the truth: put the box back, STEP_UPDATED repaints it.
		c:SetChecked(c.psChecked)
		local E, gv = ns.Engine, F.Accept.psGoal
		if E and E.ToggleGoal and gv and gv.tickable and F.psStep and F.psFold then E.ToggleGoal(F.psStep, F.psFold) end
	end)
	F.Accept.Check:SetPoint("RIGHT", F.Accept, "RIGHT", 0, 0)
	F.Accept.Check:SetSize(18, 18)
	F.Accept:Hide()

	F.Badge = CreateFrame("Frame", nil, F)
	F.Badge.Fill = F.Badge:CreateTexture(nil, "BACKGROUND")
	F.Badge.Fill:SetTexture(Theme.Media("white"))
	F.Badge.Fill:SetAllPoints(F.Badge)
	F.Badge.Text = text(F.Badge, "caption", "text")
	F.Badge.Text:SetPoint("CENTER", F.Badge, "CENTER", 0, 0)

	-- The shine: a soft band of the class colour that crosses the card once.
	F.Shine = F:CreateTexture(nil, "OVERLAY")
	F.Shine:SetTexture(Theme.Media("white"))
	F.Shine:SetWidth(SHINE_W)
	F.Shine:Hide()
	return F
end

-- Colour every part in the class colour (raw for the fills, legible for text).
local function paint(class)
	local r, g, b = Theme.ClassColor(class)
	if not r then r, g, b = Theme.Accent() end
	local tr, tg, tb = textColor(class)
	Theme.Border(F, r, g, b, 0.75)
	F.Stripe:SetVertexColor(r, g, b, 1)
	if F.Glow.SetGradient and CreateColor then
		F.Glow:SetVertexColor(1, 1, 1, 1)
		F.Glow:SetGradient("HORIZONTAL", CreateColor(r, g, b, 0.22), CreateColor(r, g, b, 0.03))
	else
		F.Glow:SetVertexColor(r, g, b, 0.12)
	end
	F.Disc:SetVertexColor(r * 0.2, g * 0.2, b * 0.2, 0.95)
	F.Ring:SetVertexColor(r, g, b, 1)
	F.Head:SetTextColor(tr, tg, tb, 1)
	F.Badge.Fill:SetVertexColor(r, g, b, 0.18)
	Theme.Border(F.Badge, r, g, b, 1)
	F.Badge.Text:SetTextColor(tr, tg, tb, 1)
	F.Shine:SetVertexColor(r, g, b, 0.35)
	W.Color(F.Title, "text")
	W.Color(F.Learn, "text")
	W.Color(F.Trip, "textDim")
	W.Color(F.Only, "textMuted")
	return hexOf(tr, tg, tb)
end

---------------------------------------------------------------------------
-- Fill, layout, the first-time shine
---------------------------------------------------------------------------

-- Fill the card for step `index` of `guide` as `view` shows it. -> the
-- class colour's hex for the step's quest names, or nil when no card shows.
function CC.Fill(guide, index, view)
	shown = nil
	CC.shown = nil
	local step = guide and index and guide.steps and guide.steps[index]
	local p = player()
	local gi = step and view and p and p.class and cardGoal(step, view, p)
	if not gi then
		if F then F:Hide() end
		return nil
	end
	if not build() then return nil end
	local goal, gv = step.goals[gi], view.goals[gi]
	local e = entry(goal.quest)
	local d = ns.ClassRewards
	local reward = e and e[3] and e[3] > 0 and d.rewards[e[3]] or nil
	local hex = paint(p.class)
	local className = UI.ClassName(p.class)
	local level = goal.minLevel or goal.qlvl
	F.Head:SetText(level and format(L["%s · LEVEL %d"], className:upper(), level) or className:upper())
	F.Title:SetText((gv and gv.subject) or goal.title or "")
	local learn = CC.RewardLine(reward, hex)
	F.Learn:SetText(learn or "")
	F.Learn:SetShown(learn ~= nil)
	local badge = CC.BadgeText(reward)
	F.Badge.Text:SetText(badge or "")
	F.Badge:SetShown(badge ~= nil)
	F.Icon:SetTexture(CC.Icon(reward, p.class))
	local chain = chainOf(goal.quest)
	local zones, n = trip(guide, index, chain, goal.quest, p)
	local count = n == 1 and L["1 step"] or format(L["%d steps"], n)
	F.Trip:SetText(#zones > 0 and (table.concat(zones, ARROW) .. DOT .. count) or count)
	F.psCompact = compact()
	-- The step's accept, folded into the card: "Accept from <giver>, <zone>"
	-- with its tick box; GuideFrame lists no row of its own for it.
	local fold = CC.Fold(guide, view)
	F.psFold, F.psStep = fold, index
	-- Once taken, the card folds to one slim line in the class colour that
	-- says who gets the quest; the step's person keeps the focus.
	local slim = fold ~= nil and gv.status == "done"
	F.psSlim = slim
	F.Glow:SetShown(not slim)
	if slim and F.psBorder then for i = 1, 4 do F.psBorder[i]:Hide() end end
	for _, part in ipairs({ F.Ring, F.Disc, F.Icon, F.Head, F.Title }) do part:SetShown(not slim) end
	if slim then F.Learn:Hide(); F.Badge:Hide() end
	F.Trip:SetShown(not (F.psCompact or slim))
	F.Only:SetShown(not (F.psCompact or slim))
	F.Accept:SetShown(fold ~= nil)
	if fold then
		local line
		if slim then
			local who, later = handIn(guide, index, view, goal.quest, chain, p)
			if who then
				line = format(later and L["%s quest taken: hand it in to %s, later in this guide"] or L["%s quest taken: hand it in to %s"], className, who)
			else
				line = format(L["%s quest taken"], className)
			end
		elseif gv.noticeText then
			-- Ticked by hand while the quest is not in the log (the tick
			-- never stands for the quest), or not listed by its giver: the
			-- game's word, as the accept's own row would say it.
			line = gv.noticeText
		else
			local where = goal.map and UI.MapName(goal.map)
			local N = ns.Names
			local who = (N and N.Npc(goal.npc)) or goal.npcName or (N and N.Object(goal.object)) or goal.objName or (gv and gv.npcName)
			line = who and (where and format(L["Accept from %s, %s"], who, where) or format(L["Accept from %s"], who)) or L["Accept the quest"]
		end
		local done = gv.status == "done"
		F.Accept.Text:SetText(line)
		if slim then
			F.Accept.Text:SetTextColor(textColor(p.class))
		else
			W.Color(F.Accept.Text, "textDim")
		end
		F.Accept.psGoal = gv
		-- The box ticks the accept only. Taken, it stays just for a hand tick
		-- to undo: the quest log already says the quest is taken. A hand tick
		-- shows ticked, so it can be seen and undone, though the accept stays
		-- open until the quest is in the log.
		F.Accept.Check:SetShown(gv.tickable and (not slim or gv.ticked) and true or false)
		local on = done or gv.ticked and true or false
		F.Accept.Check.psChecked = on
		F.Accept.Check:SetChecked(on)
		local locked = done and not gv.ticked
		if locked then F.Accept.Check:Disable() else F.Accept.Check:Enable() end
		F.Accept.Check:SetAlpha(locked and 0.45 or 1)
	end
	F:Show()
	shown = { key = guide.id .. ":" .. chain, class = p.class, quest = goal.quest, reward = reward, slim = slim }
	CC.shown = shown
	return hex
end

-- The goal the card stands for, when it is an accept to fold into it (open,
-- or done, not skipped or out of reach): its index in the step. nil when no
-- card shows or the card is for a turn-in.
function CC.Fold(guide, view)
	local step = guide and view and guide.steps and guide.steps[view.index]
	local p = step and player()
	local gi = p and p.class and cardGoal(step, view, p)
	local goal, gv = gi and step.goals[gi], gi and view.goals[gi]
	if not (goal and goal.t == "accept" and gv) then return nil end
	if gv.status == "skipped" or gv.unavailable or gv.folded then return nil end
	return gi
end

-- Whether quest goal `goal` takes the card's colour.
function CC.Colours(goal)
	if not (shown and goal) then return false end
	return classQuest(goal, shown.class)
end

-- Place the card at the top of the guide window's card, `width` wide. -> its height (0 hidden)
function CC.Layout(width)
	if not (F and F:IsShown()) then return 0 end
	local w = width - INSET * 2
	if F.psSlim then
		-- One line by the class stripe, no ring, no frame.
		local x = STRIPE + 8
		local checkW = F.Accept.Check:IsShown() and 18 + 6 or 0
		F.Accept.Text:SetWidth(max(30, w - x - 6 - checkW))
		local ah = max(18, F.Accept.Text:GetStringHeight())
		F.Accept:SetHeight(ah)
		F.Accept:ClearAllPoints()
		F.Accept:SetPoint("TOPLEFT", F, "TOPLEFT", x, -3)
		F.Accept:SetPoint("RIGHT", F, "RIGHT", -6, 0)
		local h = floor(ah + 6 + 0.5)
		F:SetSize(w, h)
		F:ClearAllPoints()
		F:SetPoint("TOPLEFT", F:GetParent(), "TOPLEFT", INSET, -INSET)
		return h + INSET + 4
	end
	local ring = F.psCompact and RING_COMPACT or RING
	F.Ring:SetSize(ring, ring)
	F.Disc:SetSize(ring - 4, ring - 4)
	F.Icon:SetSize(ring - 8, ring - 8)
	F.Ring:ClearAllPoints()
	F.Ring:SetPoint("TOPLEFT", F, "TOPLEFT", 16, -(F.psCompact and 10 or 16))
	local x = 16 + ring + 12
	local badgeW = 0
	if F.Badge:IsShown() then
		badgeW = floor(F.Badge.Text:GetStringWidth() + 20 + 0.5)
		F.Badge:SetSize(badgeW, 20)
		F.Badge:ClearAllPoints()
		F.Badge:SetPoint("TOPRIGHT", F, "TOPRIGHT", -10, -10)
		badgeW = badgeW + 8
	end
	local tw = max(40, w - x - 10)
	F.Head:SetWidth(max(30, tw - badgeW))
	F.Title:SetWidth(tw)
	F.Learn:SetWidth(tw)
	local y = F.psCompact and 8 or 12
	F.Head:ClearAllPoints()
	F.Head:SetPoint("TOPLEFT", F, "TOPLEFT", x, -y)
	y = y + F.Head:GetStringHeight() + 4
	-- The badge (top right, 20 high from 10 down) sits beside the class line;
	-- the title starts below it with a gap, never in its shadow.
	if F.Badge:IsShown() then y = max(y, 10 + 20 + 6) end
	F.Title:ClearAllPoints()
	F.Title:SetPoint("TOPLEFT", F, "TOPLEFT", x, -y)
	y = y + F.Title:GetStringHeight()
	if F.Learn:IsShown() then
		y = y + 4
		F.Learn:ClearAllPoints()
		F.Learn:SetPoint("TOPLEFT", F, "TOPLEFT", x, -y)
		y = y + F.Learn:GetStringHeight()
	end
	if F.Accept:IsShown() then
		y = y + 6
		local checkW = F.Accept.Check:IsShown() and 18 + 6 or 0
		F.Accept.Text:SetWidth(max(30, w - x - 10 - checkW))
		local ah = max(18, F.Accept.Text:GetStringHeight())
		F.Accept:SetHeight(ah)
		F.Accept:ClearAllPoints()
		F.Accept:SetPoint("TOPLEFT", F, "TOPLEFT", x, -y)
		F.Accept:SetPoint("RIGHT", F, "RIGHT", -10, 0)
		y = y + ah
	end
	local ringBottom = (F.psCompact and 10 or 16) + ring
	y = max(y, ringBottom) + (F.psCompact and 8 or 12)
	if F.Trip:IsShown() then
		F.Trip:SetWidth(w - 28)
		F.Trip:ClearAllPoints()
		F.Trip:SetPoint("TOPLEFT", F, "TOPLEFT", 14, -y)
		y = y + F.Trip:GetStringHeight() + 6
		F.Only:SetWidth(w - 28)
		F.Only:ClearAllPoints()
		F.Only:SetPoint("TOPLEFT", F, "TOPLEFT", 14, -y)
		y = y + F.Only:GetStringHeight() + 10
	end
	local h = floor(y + 0.5)
	F:SetSize(w, h)
	F:ClearAllPoints()
	F:SetPoint("TOPLEFT", F:GetParent(), "TOPLEFT", INSET, -INSET)
	return h + INSET + 4
end

-- Whether the game plays sound effects (Sound_EnableAllSound and
-- Sound_EnableSFX; an unset value counts as on).
function CC.GameSoundOn()
	if not GetCVar then return true end
	return GetCVar("Sound_EnableAllSound") ~= "0" and GetCVar("Sound_EnableSFX") ~= "0"
end

-- The shine and the chime, once per chain per character, when the card
-- shows in a visible window. -> true when it played
function CC.Celebrate()
	if not (F and F:IsVisible() and shown) or shown.slim then return false end
	local st = ns.CharState()
	st.classCardSeen = st.classCardSeen or {}
	if st.classCardSeen[shown.key] then return false end
	st.classCardSeen[shown.key] = true
	if ns.Get("ui.classCardSound") and CC.GameSoundOn() and PlaySound then
		local id = (SOUNDKIT and SOUNDKIT.IG_QUEST_LIST_COMPLETE) or 878
		pcall(PlaySound, id, "SFX")
	end
	local w = F:GetWidth()
	if Anim.Reduced() then
		-- No movement: the glow brightens and settles.
		Anim.To(F.Glow, "alpha", 0.4, 1, Anim.SLOW * 2, "out")
		return true
	end
	F.Shine:SetAlpha(1)
	F.Shine:Show()
	Anim.Anchor(F.Shine, "LEFT", F, "LEFT", -SHINE_W, 0)
	F.Shine:SetHeight(F:GetHeight())
	Anim.To(F.Shine, "offsetX", 0, w + SHINE_W, SHINE_SECONDS, "inout", function(t) t:Hide() end)
	return true
end
