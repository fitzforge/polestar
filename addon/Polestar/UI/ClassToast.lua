-- The class quest heads-up (PolestarClassToast): a card that lives on the
-- guide window. When the character reaches the level of one of its class's
-- quest chains it slides up from behind the window's top edge and sits on
-- it, as wide as the window, in the window's own panel, fonts and buttons;
-- the class colour marks only its stripe, its icon ring and its small header
-- ("LEVEL 10 · WARLOCK"); in the house look, no stripe, and the facts
-- ("Level 10 · Warlock") under the title instead. It says what is ready ("Voidwalker ready", the
-- name in the NPC colour), who gives it for the character's
-- race ("Get it from Ophek, Durotar.") and, when the loaded guide has a step
-- for the chain ahead, "Your route takes you there at <step>.". It always
-- offers a way to act: "Open in a new tab" (the chain's Class guide, at the
-- chain's step) or, without one, "Show me" (the arrow to the giver); "Later"
-- and the close button dismiss it. It follows the window when moved, flips
-- below it when there is no room above, and hides while the window is
-- hidden. Under ui.reduceMotion it fades in instead of sliding. Its size
-- (over the window's), opacity, type, entrance and whether it goes by itself
-- are the player's (Options > Alerts & toasts, UI/Looks/Toasts.lua), and so
-- is where it goes (toasts.headsup.place: "above" the window, the default;
-- "below" it, flipping above when the screen has no room below; or "free",
-- a spot of its own, toasts.headsup.pos, moved with Move frames) and its
-- compact style (toasts.headsup.compact, off by default: one line, its icon,
-- its title and its action, the rest in a tooltip and a menu). The class
-- quest card is one of the heads-ups this card carries (CT.ShowCard): the
-- dungeons' (UI/DungeonToast.lua) and the others' place and style are the
-- same.
--
-- When it shows (CT.Candidates): a chain of the character's class whose
-- start has a giver for its race and side (ClassRewards `starts`, `r`), not
-- a level-1 chain (learned at the start), opening at the new level
-- (PLAYER_LEVEL_UP) or within the last two levels (login), its reward not
-- known or owned (IsPlayerSpell / IsSpellKnown; GetItemCount with the bank),
-- no quest of its chain done or in the log, once per chain per character
-- (CharState().classToastSeen). The chime follows ui.classCardSound.
--
--   UI.ClassToast.Candidates(level, mode)  mode "levelup" | "login" | "any"
--   UI.ClassToast.Check(level, mode)       show the best candidate
--   UI.ClassToast.Show(quest), .Hide(), .Open(), .ShowMe(), .Place()
--   UI.ClassToast.frame, .current
--   UI.ClassToast.NewCard(parent), .FillCard(card, model, width)  a sandbox card (the options' preview)
--   /polestar classtoast [quest]           show it again (the best due one, or `quest`)

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, min, format, type, ipairs, pairs = math.floor, math.max, math.min, string.format, type, ipairs, pairs

local CT = {}
UI.ClassToast = CT

local PAD = 14
local RING = 40
-- In the ring: a picture (another heads-up's art) fills it inside a 2px rim,
-- an icon sits on the disc, a glyph sits small in its middle.
local ART, ICON, GLYPH = RING - 4, RING - 8, 20
-- The class colour's stripe down the card's edge. The house look draws none
-- (Theme.House "cardFacts"): its title leads, the facts under it in sentence
-- case (m.facts) carry the colour with the ring.
local STRIPE = 4
local SLIDE = 0.25
-- Another heads-up's row of spell icons (UI/SpellCards.lua): this many at most, then "+N more".
local SPELL, SPELLS_MAX = 26, 8
local LOGIN_LEVELS = 2 -- on login, chains opened within this many levels
local CLASS_BIT = { WARRIOR = 1, PALADIN = 2, HUNTER = 4, ROGUE = 8, PRIEST = 16, SHAMAN = 64, MAGE = 128, WARLOCK = 256, DRUID = 1024 }
local SIDE = { Alliance = "A", Horde = "H" }

local f

local function CC() return UI.ClassCard end
local function data() return ns.ClassRewards end
local function window() return UI.GuideFrame and UI.GuideFrame.frame end

local function hasBit(mask, b)
	return type(mask) == "number" and type(b) == "number" and b > 0 and floor(mask / b) % 2 == 1
end

local function seen()
	local st = ns.CharState()
	st.classToastSeen = st.classToastSeen or {}
	return st.classToastSeen
end

local function questTaken(q)
	local C = ns.Compat
	if not C then return false end
	local ok1, done = pcall(C.IsQuestCompleted, q)
	local ok2, inLog = pcall(C.IsOnQuest, q)
	return (ok1 and done) or (ok2 and inLog) or false
end

-- The quests of each chain (ClassRewards `quests`), built once.
local members
local function chainQuests(chain)
	if not members then
		members = {}
		for q, e in pairs(data().quests) do
			local list = members[e[2]]
			if not list then
				list = {}
				members[e[2]] = list
			end
			list[#list + 1] = q
		end
	end
	return members[chain] or {}
end

-- Whether any quest of q's chain is done or in the log.
function CT.ChainTaken(q)
	local e = data().quests[q]
	if questTaken(q) then return true end
	for _, o in ipairs(e and chainQuests(e[2]) or {}) do
		if questTaken(o) then return true end
	end
	return false
end

-- The reward's spell known: by its id, else by its name in the spellbook
-- (Compat.KnowsSpellNamed): a chain of another race teaches the same ability
-- under another id, and the card came back for a Highborne hunter who knew
-- Tame Beast (#3020) and a Skyborne druid with Bear Form (#1935).
local function spellKnown(id, english)
	if IsPlayerSpell and IsPlayerSpell(id) then return true end
	if IsSpellKnown and IsSpellKnown(id) then return true end
	local C = ns.Compat
	if not (C and C.KnowsSpellNamed) then return false end
	local name = C_Spell and C_Spell.GetSpellName and C_Spell.GetSpellName(id)
	if type(name) ~= "string" or name == "" then name = english end
	return C.KnowsSpellNamed(name) and true or false
end

local function itemOwned(id)
	local n
	if C_Item and C_Item.GetItemCount then n = C_Item.GetItemCount(id, true) end
	if not n and GetItemCount then n = GetItemCount(id, true) end
	return (tonumber(n) or 0) > 0
end

-- Whether the character already has the reward: the spell (a pet's summon
-- too) known, or one of the items in the bags, the bank or worn.
function CT.RewardKnown(reward)
	if not reward then return false end
	if reward.spell and spellKnown(reward.spell, reward.spellName) then return true end
	for _, id in ipairs(reward.items or {}) do
		if itemOwned(id) then return true end
	end
	return false
end

-- The start's giver for the character's race and side. -> { name, map, x, y } | nil
local function giverFor(s, p)
	local i = s and s.r and p and s.r[(p.race or "") .. ":" .. (SIDE[p.faction] or "")]
	return i and s.g[i] or nil
end

-- How far starter `rec` (a Codex NPC or object) stands from the giver's
-- point: its nearest spawn on the giver's map, squared; 0 for a giver with no
-- point. -> distance, that spawn's height | nil (no spawn there)
local function giverDistance(rec, giver)
	if not giver[2] then return 0 end
	local best, z
	for _, s in ipairs(rec and rec.spawns or {}) do
		if s.map == giver[2] then
			local dx, dy = s.x - giver[3], s.y - giver[4]
			local d = dx * dx + dy * dy
			if not best or d < best then best, z = d, s.z end
		end
	end
	return best, z
end

-- The giver's height (#1639): the Codex spawn of quest q's start nearest its
-- point, within a map percent or two; nil when unknown. A giver in a stacked
-- town (the Undercity's Royal Quarter, Orgrimmar's Cleft of Shadow) is then
-- sought on its own floor. Never loads the Codex in combat.
local NEAR_GIVER = 4 -- squared map percent
local function giverHeight(q, giver)
	local X = ns.Codex
	if not (X and X.Quest and giver[2]) then return nil end
	if not (X.IsLoaded and X.IsLoaded()) and InCombatLockdown and InCombatLockdown() then return nil end
	local rec = X.Quest(q)
	local start = rec and rec.start
	if not start then return nil end
	local bestD, bestZ
	for _, id in ipairs(start.npc or {}) do
		local d, z = giverDistance(X.Npc(id), giver)
		if d and (not bestD or d < bestD) then bestD, bestZ = d, z end
	end
	for _, id in ipairs(start.object or {}) do
		local d, z = giverDistance(X.Object(id), giver)
		if d and (not bestD or d < bestD) then bestD, bestZ = d, z end
	end
	if bestD and bestD <= NEAR_GIVER and type(bestZ) == "number" then return bestZ end
	return nil
end

-- The giver's name in the client's words: the start of quest q (Codex) that
-- stands nearest its point, named by Polestar.Names; else ClassRewards' own
-- (the data's English) name.
local function giverName(q, giver)
	local N, X = ns.Names, ns.Codex
	local rec = N and N.Localised() and X and X.Quest and X.Quest(q)
	local start = rec and rec.start
	if not start then return giver[1] end
	local bestId, bestNpc, bestD
	for _, id in ipairs(start.npc or {}) do
		local d = giverDistance(X.Npc(id), giver)
		if d and (not bestD or d < bestD) then bestId, bestNpc, bestD = id, true, d end
	end
	for _, id in ipairs(start.object or {}) do
		local d = giverDistance(X.Object(id), giver)
		if d and (not bestD or d < bestD) then bestId, bestNpc, bestD = id, false, d end
	end
	if not bestId then return giver[1] end
	local name
	if bestNpc then name = N.Npc(bestId) else name = N.Object(bestId) end
	return name or giver[1]
end

local routeStep -- below, before Model

-- Whether goal `goal` of guide step `step` is of quest q's chain.
local function ofChain(goal, q, chain)
	local C = CC()
	return goal.quest ~= nil and (goal.quest == q or (C.Entry(goal.quest) ~= nil and C.ChainOf(goal.quest) == chain))
end

-- The loaded guide's step for the chain from the live step on. -> step index, title | nil
function routeStep(q, chain, p)
	local E, C = ns.Engine, CC()
	local g = E and E.GetGuide and E.GetGuide()
	if not (g and g.steps and g.category ~= "Class") then return nil end
	local from = (E.GetLiveStep and E.GetLiveStep()) or (E.GetStepIndex and E.GetStepIndex()) or 1
	for s = from, #g.steps do
		local step = g.steps[s]
		if C.Matches(step.only, p) then
			for _, goal in ipairs(step.goals or {}) do
				if ofChain(goal, q, chain) and C.Matches(goal.only, p) then
					local title = step.title
					if type(title) ~= "string" or title == "" then title = format(L["Step %d"], UI.StepNo(s)) end
					return s, title
				end
			end
		end
	end
	return nil
end

-- The chain's own Class guide for this character: one that takes quest q,
-- else one that takes another quest of its chain. -> guide id | nil
-- A side-shelf guide's steps are read in for the search and given back
-- (Guides.Peek).
function CT.ClassGuide(q)
	local G, C = ns.Guides, CC()
	local p = C and C.Player()
	if not (G and G.List and G.Get and p) then return nil end
	local chain, other = C.ChainOf(q), nil
	for _, h in ipairs(G.List()) do
		if h.category == "Class" and (not G.GuideMatches or G.GuideMatches(h, p)) then
			local steps, fresh = G.Peek(h.id)
			local takes = false
			for _, step in ipairs(steps or {}) do
				for _, goal in ipairs(step.goals or {}) do
					if goal.quest == q then takes = true end
					if not other and ofChain(goal, q, chain) then other = h.id end
				end
			end
			G.Unpeek(h.id, fresh)
			if takes then return h.id end
		end
	end
	return other
end

-- Where the class guide's tab lands for quest q: the first step that
-- accepts q while it is open, else the first with an open goal of its chain.
-- -> step index | nil
function CT.LandingStep(id, q)
	local G, C = ns.Guides, CC()
	local g = G and G.Get and G.Get(id)
	local p = C and C.Player()
	if not (g and p) then return nil end
	local chain = C.ChainOf(q)
	if not questTaken(q) then
		for s, step in ipairs(g.steps or {}) do
			if C.Matches(step.only, p) then
				for _, goal in ipairs(step.goals or {}) do
					if goal.t == "accept" and goal.quest == q and C.Matches(goal.only, p) then return s end
				end
			end
		end
	end
	local Cx = ns.Compat
	for s, step in ipairs(g.steps or {}) do
		if C.Matches(step.only, p) then
			for _, goal in ipairs(step.goals or {}) do
				if ofChain(goal, q, chain) and C.Matches(goal.only, p) then
					local ok, done = pcall(Cx.IsQuestCompleted, goal.quest)
					if not (ok and done) then return s end
				end
			end
		end
	end
	return nil
end

-- The card's short title: a summon spell by what it summons ("Summon
-- Voidwalker" -> "Voidwalker"), through the translated "Summon %s".
function CT.ShortName(name)
	local pat = L["Summon %s"]:gsub("([%^%$%(%)%.%[%]%*%+%-%?%%])", "%%%1"):gsub("%%%%s", "(.+)")
	return name:match("^" .. pat .. "$") or name
end

-- What the card says for quest q, or nil when it has nothing to offer (no
-- giver for the character's race, or neither a class guide nor a place).
function CT.Model(q)
	local d, C = data(), CC()
	local s, e = d and d.starts and d.starts[q], d and d.quests and d.quests[q]
	local p = C and C.Player()
	if not (s and e and p and p.class) then return nil end
	local giver = giverFor(s, p)
	if not giver then return nil end
	local reward = e[3] > 0 and d.rewards[e[3]] or nil
	local name = C.RewardName(reward)
	local m = { quest = q, reward = reward, class = p.class, level = s[1] }
	m.head = format(L["LEVEL %d · %s"], s[1], ns.Upper(UI.ClassName(p.class)))
	m.facts = format(L["Level %d · %s"], s[1], UI.ClassName(p.class))
	m.title = name and format(L["%s ready"], CT.ShortName(name)) or UI.ClassName(p.class)
	local where, who = giver[2] and UI.MapName(giver[2]), giverName(q, giver)
	m.giver = where and format(L["Get it from %s, %s."], who, where) or format(L["Get it from %s."], who)
	m.map, m.x, m.y, m.who = giver[2], giver[3], giver[4], who
	local step, title = routeStep(q, C.ChainOf(q), p)
	if step then
		m.step = step
		m.route = format(L["Your route takes you there at %s."], title)
	end
	m.guideId = CT.ClassGuide(q)
	if not m.guideId and not (m.map and m.x and m.y) then return nil end
	m.badge = C.BadgeText(reward)
	m.icon = C.Icon(reward, p.class)
	return m
end

-- The chain starts to tell the character about now, best first: the highest
-- level, then one the loaded guide takes, then the lowest quest id. mode
-- "levelup": opening at `level`; "login": opened within the last
-- LOGIN_LEVELS levels; "any": any reached, seen ones too. -> { quest, ... }
function CT.Candidates(level, mode)
	local d, C = data(), CC()
	local p = C and C.Player()
	if not (d and d.starts and p and p.class) then return {} end
	level = level or p.level or 1
	local cbit = CLASS_BIT[p.class]
	local done, out, onRoute = seen(), {}, {}
	for q, s in pairs(d.starts) do
		local e = d.quests[q]
		local at = s[1]
		local due = (mode == "levelup" and at == level) or (mode == "login" and at <= level and at >= level - LOGIN_LEVELS)
			or (mode == "any" and at <= level)
		if due and at > 1 and e and e[3] > 0 and hasBit(e[1], cbit) and giverFor(s, p) and (mode == "any" or not done[q])
			and not CT.RewardKnown(d.rewards[e[3]]) and not CT.ChainTaken(q) and CT.Model(q) then
			out[#out + 1] = q
			onRoute[q] = routeStep(q, C.ChainOf(q), p) ~= nil
		end
	end
	table.sort(out, function(a, b)
		local la, lb = d.starts[a][1], d.starts[b][1]
		if la ~= lb then return la > lb end
		if onRoute[a] ~= onRoute[b] then return onRoute[a] end
		return a < b
	end)
	return out
end

---------------------------------------------------------------------------
-- The card, on the guide window
---------------------------------------------------------------------------

local function text(parent, role, color)
	local G = UI.GuideFrame
	local fs = G and G.Text and G.Text(parent, role, color) or W.Text(parent, role, color)
	fs:SetWordWrap(true)
	return fs
end

local layout

-- The look's settings (UI/Looks/Toasts.lua), when that file is loaded.
local function looks() return UI.Toasts end

-- The card, drawn into `parent`: the live heads-up (build) or a sandbox one
-- for the options' preview (CT.NewCard): its buttons do nothing and it
-- follows no window.
local function newCard(parent, name, sandbox)
	local f = CreateFrame("Frame", name, parent)
	f:SetSize(340, 120)
	f:EnableMouse(true)
	-- The guide window's own panel, border and corners.
	f.psGuide = true
	Theme.Skin(f, "window")

	f.Stripe = f:CreateTexture(nil, "BORDER", nil, 2)
	f.Stripe:SetTexture(Theme.Media("white"))
	f.Stripe:SetWidth(STRIPE)
	f.Stripe:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
	f.Stripe:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)

	f.Ring = f:CreateTexture(nil, "ARTWORK", nil, 0)
	f.Ring:SetTexture(Theme.Media("circle"))
	f.Ring:SetSize(RING, RING)
	f.Disc = f:CreateTexture(nil, "ARTWORK", nil, 1)
	f.Disc:SetTexture(Theme.Media("circle"))
	f.Disc:SetSize(RING - 4, RING - 4)
	f.Disc:SetPoint("CENTER", f.Ring, "CENTER", 0, 0)
	W.Color(f.Disc, "panelAlt")
	f.Icon = f:CreateTexture(nil, "ARTWORK", nil, 2)
	f.Icon:SetSize(ICON, ICON)
	f.Icon:SetPoint("CENTER", f.Ring, "CENTER", 0, 0)
	-- A dark picture's lift: the same picture added over it at its art.lift
	-- (colour + colour * lift), since a vertex colour can't go above 1.
	f.Lift = f:CreateTexture(nil, "ARTWORK", nil, 3)
	f.Lift:SetPoint("CENTER", f.Ring, "CENTER", 0, 0)
	f.Lift:SetBlendMode("ADD")
	f.Lift:Hide()
	-- The round crop: as large as the icon or the picture, never smaller
	-- than an icon, so a glyph keeps its corners.
	if f.CreateMaskTexture and f.Icon.AddMaskTexture then
		f.Mask = f:CreateMaskTexture()
		f.Mask:SetTexture(Theme.Media("circle"), "CLAMPTOBLACKADDITIONAL", "CLAMPTOBLACKADDITIONAL")
		f.Mask:SetPoint("CENTER", f.Ring, "CENTER", 0, 0)
		f.Mask:SetSize(ICON, ICON)
		f.Icon:AddMaskTexture(f.Mask)
		f.Lift:AddMaskTexture(f.Mask)
	end

	-- The window's type: the small header (the house look's facts line), the
	-- name in the NPC colour, muted lines.
	f.Head = text(f, "small", "text")
	f.Title = text(f, "name", "personName")
	f.Giver = text(f, "small", "textDim")
	f.Route = text(f, "small", "textMuted")
	-- Another heads-up's spells, a row of icons with the game's tooltips (CT.SpellButton).
	f.SpellRow = {}
	f.SpellMore = text(f, "small", "textMuted")
	f.SpellMore:SetWordWrap(false)
	f.SpellMore:Hide()

	-- What it brings, in the window's accent chip.
	f.Badge = CreateFrame("Frame", nil, f)
	f.Badge.Fill = W.Fill(f.Badge, "chipAccent", "BACKGROUND")
	f.Badge.Text = W.Text(f.Badge, "caption", "accent")
	f.Badge.Text:SetPoint("CENTER", f.Badge, "CENTER", 0, 0)

	f.Rule = W.Divider(f)

	-- The window's icon button and its buttons: the gold primary ("Choose a
	-- guide") and the quiet one beside it.
	local function act(fn) return sandbox and function() end or fn end
	f.Close = W.IconButton(f, "close", 24, L["Dismiss"], act(function() CT.Hide() end))
	f.Open = W.Button(f, L["Open in a new tab"], act(function() CT.Open() end), { primary = true })
	f.ShowMe = W.Button(f, L["Show me"], act(function() CT.ShowMe() end), { primary = true })
	f.Later = W.Button(f, L["Later"], act(function() CT.Later() end), { ghost = true })
	-- Another heads-up's own action, its second button and its "stop these"
	-- (UI/DungeonToast.lua).
	f.Act = W.Button(f, "", act(function() CT.Act() end), { primary = true })
	f.More = W.Button(f, "", act(function() CT.More() end), { ghost = true })
	f.Off = W.Button(f, "", act(function() CT.Off() end), { ghost = true })
	-- The compact card's other actions (its second button, its "stop these"),
	-- in a menu.
	f.Extra = W.IconButton(f, "menu", 24, L["More"], act(function(self) CT.ExtraMenu(self) end))
	f.Extra:Hide()
	-- Compact, the lines it leaves out are in a tooltip.
	f:SetScript("OnEnter", function(self) CT.CompactTip(self) end)
	f:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	local TS = looks()
	if TS then
		-- The guide window's scale stays its own: the card is CT.Place's to scale.
		TS.Attach("headsup", f, { titles = { f.Title }, bodies = { f.Head, f.Giver, f.Route }, sandbox = sandbox, noScale = true,
			relayout = function(self)
				if self == CT.frame then
					if self:IsShown() then CT.Place(false) end
				elseif self.psModel then
					layout(self, self:GetWidth())
				end
			end })
	end
	return f
end

local function build()
	f = newCard(ns.UIParent, "PolestarClassToast")
	f:Hide()
	CT.frame = f

	local w = window()
	if w then
		-- The window closed: the card goes with it. Polestar hiding (its
		-- layer, with the window still open) hides both and keeps the card.
		w:HookScript("OnHide", function(self) if f and not self:IsShown() then f:Hide() end end)
		w:HookScript("OnShow", function() if CT.current then CT.Place(true) end end)
		w:HookScript("OnSizeChanged", function() if f:IsShown() then CT.Place(false) end end)
	end
	-- The gamepad (UI/Gamepad.lua): a card shows on its own, so it waits for
	-- the focus binding before it takes the gamepad; then the D-pad walks its
	-- buttons and icons, A presses one, B is Later.
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(f, { unasked = function() return true end, back = function() CT.Later() end })
	end
end

-- The quest buttons or the target list moved, grew, came or went
-- (QoL/Buttons.lua): the card takes its side again, clear of them (#2629).
-- Only when what they cover is not what the card's last placing read
-- (placedCovers): most of these leave every button where it was, and a
-- placing measures the window, its look's reach and the screen. On its own
-- spot (free) the card never minds them.
local placedCovers -- Buttons.Covers() as CT.Place last read it (nil: it read none)
-- The room the card took above or below the edge it sits on, gap included,
-- in the edge's units, as CT.Place last placed it (0: free or beside it).
local placedRoom = 0
local function sameCovers(a, b)
	if #a ~= #b then return false end
	for i = 1, #a do
		local x, y = a[i], b[i]
		if x[1] ~= y[1] or x[2] ~= y[2] or x[3] ~= y[3] or x[4] ~= y[4] then return false end
	end
	return true
end
ns.On("QUEST_BUTTONS_PLACED", function()
	if not (f and f:IsShown()) then return end
	if CT.side == "free" and CT.PlaceSetting() == "free" then return end
	local B = ns.QoL and ns.QoL.Buttons
	if placedCovers and B and B.Covers and sameCovers(B.Covers(), placedCovers) then return end
	CT.Place(false)
end)

-- class: the class colour's stripe, ring and header (or facts); nil (another heads-up)
-- the accent's.
local function paint(f, class)
	local r, g, b = Theme.ClassColor(class)
	if not r then r, g, b = Theme.Accent() end
	local tr, tg, tb
	if class then
		tr, tg, tb = CC().TextColor(class)
	else
		tr, tg, tb = Theme.Color("accent")
	end
	f.Stripe:SetVertexColor(r, g, b, 1)
	f.Ring:SetVertexColor(r, g, b, 1)
	f.Head:SetTextColor(tr, tg, tb, 1)
	-- The icon buttons at the window's sizes (GuideFrame.ApplySkin).
	local iw, ih, ig = Theme.Metric("guideIconBtnW", 24), Theme.Metric("guideIconBtnH", 24), Theme.Metric("guideIcon", 14)
	f.Close:SetSize(iw, ih)
	f.Close.Icon:SetSize(ig, ig)
	W.SetFramed(f.Close, "icon")
end

-- The ring and what sits in it, at `s` times their full size (the compact
-- card's is smaller). The icon's own size is fillCard's (c.psIconSize).
local function sizeRing(f, s)
	f.Ring:SetSize(RING * s, RING * s)
	f.Disc:SetSize((RING - 4) * s, (RING - 4) * s)
	local size = (f.psIconSize or ICON) * s
	f.Icon:SetSize(size, size)
	f.Lift:SetSize(size, size)
	if f.Mask then f.Mask:SetSize(max(size, ICON * s), max(size, ICON * s)) end
end

-- Which parts the full card shows for model m (the compact one leaves some out).
local function showParts(f, m)
	f.Head:Show()
	f.Rule:Show()
	f.Later:Show()
	f.Extra:Hide()
	f.Title:SetWordWrap(true)
	f.Giver:SetShown(m.giver ~= nil)
	f.Route:SetShown(m.route ~= nil)
	f.Badge:SetShown(m.badge ~= nil)
	f.Act:SetShown(m.act ~= nil)
	f.More:SetShown(m.more ~= nil)
	f.Off:SetShown(m.off ~= nil)
	f.Open:SetShown(m.act == nil and not m.noAct and m.guideId ~= nil)
	f.ShowMe:SetShown(m.act == nil and not m.noAct and m.guideId == nil)
end

-- toasts.headsup.compact: one line.
local function compactOn()
	local TS = looks()
	return TS and TS.Get("headsup", "compact") and true or false
end
CT.Compact = compactOn

-- The facts line the card shows for model m: the house look's sentence-case
-- facts under the title (m.facts, when the model has them), else the header.
local function factsOf(m)
	return Theme.House("cardFacts") and m.facts or m.head
end

-- Keep the whole action readable inside the card. Measure afresh on each
-- layout so a wider window or a shorter label restores the normal button.
local function fitButton(b, width)
	local label = b.Label
	label:SetWidth(0)
	label:SetWordWrap(false)
	W.SetButtonText(b, label:GetText())
	local height = Theme.Metric("buttonH", 28)
	if b:GetWidth() > width then
		local lineHeight = label:GetStringHeight()
		b:SetWidth(width)
		label:SetWidth(max(1, width - 2 * Theme.Metric("buttonPad", 16)))
		label:SetWordWrap(true)
		label:SetNonSpaceWrap(true)
		height = height + label:GetStringHeight() - lineHeight
	end
	b:SetHeight(height)
end

-- The compact card: the ring, the title on one line and the action, then
-- the card's menu when it has more to offer (its second button, its "stop
-- these") and the close button; its other lines are the tooltip's
-- (CT.CompactTip). Later is the close button's.
local CPAD, CRING = 8, 24
local function compactLayout(f, width)
	local m = f.psModel or {}
	local stripe = Theme.House("cardFacts") and 0 or STRIPE
	f:SetWidth(width)
	sizeRing(f, CRING / RING)
	f.Stripe:SetShown(stripe > 0)
	for _, p in ipairs({ f.Head, f.Giver, f.Route, f.Badge, f.Rule, f.Later, f.More, f.Off, f.SpellMore }) do p:Hide() end
	-- The row of icons is the full card's: its spells and items are in the tooltip's lines.
	for _, b in ipairs(f.SpellRow) do b:Hide() end
	local act = (m.act and f.Act) or (m.guideId and f.Open) or f.ShowMe
	for _, b in ipairs({ f.Act, f.Open, f.ShowMe }) do b:SetShown(b == act) end
	-- The full card may have wrapped this button taller: back to one line.
	fitButton(act, math.huge)
	f.Extra:SetShown(m.more ~= nil or m.off ~= nil)
	local h = max(CRING, act:GetHeight(), f.Close:GetHeight())
	local mid = -(CPAD + h / 2)
	f.Ring:ClearAllPoints()
	f.Ring:SetPoint("LEFT", f, "TOPLEFT", CPAD + stripe, mid)
	f.Close:ClearAllPoints()
	f.Close:SetPoint("RIGHT", f, "TOPRIGHT", -6, mid)
	local right = f.Close
	if f.Extra:IsShown() then
		f.Extra:SetSize(f.Close:GetWidth(), f.Close:GetHeight())
		f.Extra:ClearAllPoints()
		f.Extra:SetPoint("RIGHT", f.Close, "LEFT", -2, 0)
		right = f.Extra
	end
	act:ClearAllPoints()
	act:SetPoint("RIGHT", right, "LEFT", -6, 0)
	f.Title:SetWordWrap(false)
	f.Title:ClearAllPoints()
	f.Title:SetPoint("LEFT", f, "TOPLEFT", CPAD + stripe + CRING + 8, mid)
	f.Title:SetPoint("RIGHT", act, "LEFT", -8, 0)
	f:SetHeight(floor(CPAD * 2 + h + 0.5))
end

function layout(f, width)
	if compactOn() then return compactLayout(f, width) end
	if f.psModel then showParts(f, f.psModel) end
	-- The icons back from the compact card: those holding a spell or an item.
	for _, b in ipairs(f.SpellRow) do b:SetShown(b.spell ~= nil) end
	local spells = f.psModel and f.psModel.spells
	f.SpellMore:SetShown(spells ~= nil and #spells > SPELLS_MAX)
	sizeRing(f, 1)
	f:SetWidth(width)
	-- The house look: the title first, then the facts with the chip, no stripe.
	local under = Theme.House("cardFacts")
	local stripe = under and 0 or STRIPE
	f.Stripe:SetShown(stripe > 0)
	local x = PAD + stripe + RING + 12
	-- The close button inside the frame: the game looks' frames are thicker
	-- than the house edge, so their close box sits further in.
	local inset = Theme.Kit() and 10 or 6
	local closeW = f.Close:GetWidth() + inset
	f.Ring:ClearAllPoints()
	f.Ring:SetPoint("TOPLEFT", f, "TOPLEFT", PAD + stripe, -PAD)
	f.Close:ClearAllPoints()
	f.Close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inset, -inset)
	-- The chip sits beside the header; on a window too narrow for both on
	-- one line ("LEVEL 19 · DUNGEON" and "+1.1 LEVELS"), under it. In the
	-- house look it rides the facts line under the title, or takes a line of
	-- its own under it when the two don't fit side by side.
	local headW = width - x - closeW - 4
	local tw = max(60, width - x - PAD)
	local badgeW, beside = 0, true
	if f.Badge:IsShown() then
		badgeW = floor(W.TextWidth(f.Badge.Text) + 14 + 0.5)
		f.Badge:SetSize(badgeW, 18)
		f.Badge:ClearAllPoints()
		if under then
			beside = W.TextWidth(f.Head) + 8 + badgeW <= tw
		else
			beside = W.TextWidth(f.Head) <= headW - badgeW - 8
		end
		if beside and not under then
			-- A look that draws its own close box (the game's looks, Hearth):
			-- level with it, its middle on the box's. Polestar's own look keeps
			-- 0.3.7's place.
			local own = Theme.Kit() or Theme.SkinKey() == "hearth"
			local y = own and -(inset + floor((f.Close:GetHeight() - 18) / 2 + 0.5)) or -PAD + 2
			f.Badge:SetPoint("TOPRIGHT", f, "TOPRIGHT", -(closeW + 4), y)
			headW = headW - badgeW - 8
		end
	end
	f.Head:SetWidth(max(40, under and tw or headW))
	f.Title:SetWidth(max(60, width - x - closeW))
	f.Giver:SetWidth(tw)
	f.Route:SetWidth(tw)
	local y = PAD
	f.Head:ClearAllPoints()
	f.Title:ClearAllPoints()
	if under then
		f.Title:SetPoint("TOPLEFT", f, "TOPLEFT", x, -y)
		y = y + f.Title:GetStringHeight() + 3
		if f.Badge:IsShown() and beside then
			-- The facts on the chip's middle, the chip after them.
			f.Badge:SetPoint("TOPLEFT", f, "TOPLEFT", x + floor(W.TextWidth(f.Head) + 8 + 0.5), -y)
			f.Head:SetPoint("LEFT", f, "TOPLEFT", x, -(y + f.Badge:GetHeight() / 2))
			y = y + max(f.Head:GetStringHeight(), f.Badge:GetHeight()) + 4
		else
			f.Head:SetPoint("TOPLEFT", f, "TOPLEFT", x, -y)
			y = y + f.Head:GetStringHeight() + 4
			if f.Badge:IsShown() then
				f.Badge:SetPoint("TOPLEFT", f, "TOPLEFT", x, -y)
				y = y + f.Badge:GetHeight() + 4
			end
		end
	else
		f.Head:SetPoint("TOPLEFT", f, "TOPLEFT", x, -y)
		y = y + f.Head:GetStringHeight() + 4
		if not beside then
			f.Badge:SetPoint("TOPLEFT", f, "TOPLEFT", x, -y)
			y = y + f.Badge:GetHeight() + 4
		end
		f.Title:SetPoint("TOPLEFT", f, "TOPLEFT", x, -y)
		y = y + f.Title:GetStringHeight() + 4
	end
	for _, fs in ipairs({ f.Giver, f.Route }) do
		if fs:IsShown() then
			fs:ClearAllPoints()
			fs:SetPoint("TOPLEFT", f, "TOPLEFT", x, -y)
			y = y + fs:GetStringHeight() + 3
		end
	end
	local model = rawget(f, "psModel")
	local spells = model and model.spells
	if spells and #spells > 0 then
		local bx = x
		for i = 1, min(#spells, SPELLS_MAX) do
			local b = f.SpellRow[i]
			b:ClearAllPoints()
			b:SetPoint("TOPLEFT", f, "TOPLEFT", bx, -y)
			bx = bx + SPELL + 4
		end
		if f.SpellMore:IsShown() then
			f.SpellMore:ClearAllPoints()
			f.SpellMore:SetPoint("LEFT", f, "TOPLEFT", bx + 2, -(y + SPELL / 2))
		end
		y = y + SPELL + 4
	end
	y = max(y, PAD + RING) + 10
	f.Rule:ClearAllPoints()
	f.Rule:SetPoint("TOPLEFT", f, "TOPLEFT", PAD + stripe, -y)
	f.Rule:SetPoint("TOPRIGHT", f, "TOPRIGHT", -PAD, -y)
	y = y + 10
	-- The buttons in one row: the action, another heads-up's second button
	-- ("Open in Dungeons"), Later and its "stop these". When they don't all
	-- fit in the card's width, Later and the rest start a row of their own,
	-- and a button that still doesn't fit starts the next row. A heads-up
	-- with nothing to do (m.noAct) starts with Later. A question with three
	-- answers (m.answers: UI/Materials.lua's Mix, Gather and Buy) keeps its
	-- third one (`off`) beside the others, before Later.
	local act = (f.Act:IsShown() and f.Act) or (f.Open:IsShown() and f.Open) or (f.ShowMe:IsShown() and f.ShowMe) or nil
	local row = { act }
	local avail = width - 2 * PAD - stripe
	if act then fitButton(act, avail) end
	local total = act and act:GetWidth() or 0
	local m = f.psModel
	for _, b in ipairs(m and m.answers and { f.More, f.Off, f.Later } or { f.More, f.Later, f.Off }) do
		if b:IsShown() then
			fitButton(b, avail)
			if #row > 0 then total = total + (row[#row] == act and 8 or 4) end
			total = total + b:GetWidth()
			row[#row + 1] = b
		end
	end
	local left, used, prev = PAD + stripe, 0, nil
	for _, b in ipairs(row) do
		b:ClearAllPoints()
		local gap = prev == act and 8 or 4
		if prev and used + gap + b:GetWidth() <= avail and not (b == f.Later and total > avail) then
			b:SetPoint("LEFT", prev, "RIGHT", gap, 0)
			used = used + gap + b:GetWidth()
		else
			if prev then y = y + prev:GetHeight() + 4 end
			b:SetPoint("TOPLEFT", f, "TOPLEFT", left, -y)
			used = b:GetWidth()
		end
		prev = b
	end
	y = y + prev:GetHeight() + PAD
	f:SetHeight(floor(y + 0.5))
end

-- Where the card goes when its place is "free" and it was never moved: the
-- screen's top middle, under the alerts.
CT.FREE_AT = { "TOP", 0, -200 }

-- toasts.headsup.place: "above" (the default), "below" or "free".
function CT.PlaceSetting()
	local TS = looks()
	local v = TS and TS.Get("headsup", "place")
	return (v == "below" or v == "free") and v or "above"
end

-- How far a frame's own drawing reaches past each of its edges, in its
-- units: a soft shadow (the house look's, 12 over the top and 20 under the
-- bottom), a skin's border, glow or corner marks, a part hung outside it.
-- Read off the anchors that tie its regions and its children to it (up to
-- REACH_ANCHORED: Umbra's deep shadow reaches 58 under the window), and off
-- where they and their children's regions stand (up to REACH_SEEN, past
-- which what stands there is content hung away from the frame, not its
-- drawing).
local REACH_ANCHORED, REACH_SEEN = 128, 48
local function reach(o)
	local r = { top = 0, bottom = 0, left = 0, right = 0 }
	local function grow(side, d, most)
		if d > r[side] and d <= (most or REACH_SEEN) then r[side] = d end
	end
	local function byPoints(x)
		for i = 1, (x.GetNumPoints and x:GetNumPoints() or 0) do
			local p, rel, rp, dx, dy = x:GetPoint(i)
			if rel == o and type(p) == "string" and type(rp) == "string" then
				dx, dy = tonumber(dx) or 0, tonumber(dy) or 0
				local xh, xw = x:GetHeight() or 0, x:GetWidth() or 0
				-- An edge past the frame's own (a shadow's), or a part standing on its far side.
				if rp:find("TOP") then grow("top", p:find("TOP") and dy or p:find("BOTTOM") and dy + xh or 0, REACH_ANCHORED) end
				if rp:find("BOTTOM") then grow("bottom", p:find("BOTTOM") and -dy or p:find("TOP") and xh - dy or 0, REACH_ANCHORED) end
				if rp:find("LEFT") then grow("left", p:find("LEFT") and -dx or p:find("RIGHT") and xw - dx or 0, REACH_ANCHORED) end
				if rp:find("RIGHT") then grow("right", p:find("RIGHT") and dx or p:find("LEFT") and dx + xw or 0, REACH_ANCHORED) end
			end
		end
	end
	local ol, ob, orr, ot = o:GetLeft(), o:GetBottom(), o:GetRight(), o:GetTop()
	local oe = o:GetEffectiveScale() or 1
	-- x's rectangle in o's units (e: the scale x's coordinates are in).
	local function byRect(x, e)
		if not (ol and ob and orr and ot) then return end
		local l, b, rr, t = x:GetLeft(), x:GetBottom(), x:GetRight(), x:GetTop()
		if not (l and b and rr and t) then return end
		local q = (e or oe) / oe
		l, b, rr, t = l * q, b * q, rr * q, t * q
		if rr <= l or t <= b then return end
		if rr > ol and l < orr then
			grow("top", t - ot)
			grow("bottom", ob - b)
		end
		if t > ob and b < ot then
			grow("left", ol - l)
			grow("right", rr - orr)
		end
	end
	local function shown(x) return x.IsShown == nil or x:IsShown() end
	for _, x in ipairs({ o:GetRegions() }) do
		if shown(x) then
			byPoints(x)
			byRect(x, oe)
		end
	end
	for _, c in ipairs({ o:GetChildren() }) do
		if shown(c) then
			byPoints(c)
			local ce = c:GetEffectiveScale() or oe
			byRect(c, ce)
			for _, x in ipairs({ c:GetRegions() }) do
				if shown(x) then byRect(x, ce) end
			end
		end
	end
	return r
end
CT.Reach = reach

-- The room between the card and the window's drawing.
local GAP = 4

-- Put the card on the window: above its top edge, or under its bottom one
-- when the screen has no room above (toasts.headsup.place "below": under it,
-- over it when there is no room below), beside it where neither has room
-- (the side facing the middle of the screen when both do), or on its own
-- spot ("free": toasts.headsup.pos, Move frames). Clear of the window and
-- of what its look draws past its edges (CT.Reach): touching it, the card
-- sat under a shadow, border or corner marks drawn over it. A side where the
-- card would cover the quest buttons or the target list (QoL/Buttons.lua,
-- Buttons.Covers) counts as having no room while another side has it
-- (#2629: the list was drawn over the card and its buttons). animate: slide
-- out from behind the edge it sits on, or in from above beside the window
-- and on its own spot (a fade under ui.reduceMotion).
function CT.Place(animate)
	local w = window()
	if not (f and w and CT.current) then return end
	if not w:IsShown() then
		f:Hide()
		return
	end
	local TS = looks()
	local k = TS and TS.Scale("headsup") or 1
	local place = CT.PlaceSetting()
	f:SetScale((w:GetScale() or 1) * k)
	f:SetFrameStrata(w:GetFrameStrata())
	if place == "free" then
		f:SetFrameLevel(w:GetFrameLevel())
	else
		-- Behind the window, so it slides out from under its edge.
		if w:GetFrameLevel() < 2 then w:SetFrameLevel(2) end
		f:SetFrameLevel(w:GetFrameLevel() - 1)
	end
	-- As wide as the window, whatever the card's own scale.
	layout(f, w:GetWidth() / k)
	local h = f:GetHeight()
	local dy
	if place == "free" then
		local p = ns.Get("toasts.headsup.pos")
		if type(p) ~= "table" or type(p[1]) ~= "string" then p = CT.FREE_AT end
		CT.side, placedCovers, placedRoom = "free", nil, 0
		f:SetClampedToScreen(true)
		Anim.Anchor(f, p[1], UIParent, p[1], tonumber(p[2]) or 0, tonumber(p[3]) or 0)
		dy = 18
	else
		f:SetClampedToScreen(false)
		-- A skin's own frame around the window (its cards above it: Skin API 2,
		-- hooks.guideAnchor) is the edge the card sits on instead; under the
		-- window it is always the window's own foot. Under the skin's cards
		-- the card lay on the window, behind it, its buttons out of reach
		-- (#4212: Atlas's stack, the window near the screen's top).
		local ran, own = Theme.SkinHookValue("guideAnchor")
		local edge = ran and type(own) == "table" and own.GetTop and own or w
		-- The gaps in the edge's units; the card's anchors take them in its own (k).
		local r = reach(edge)
		local rw = edge == w and r or reach(w)
		-- The window's own parts past its edges (the edge tab style's tabs).
		if edge == w then
			r.top = math.max(r.top, tonumber(w.psTopReach) or 0)
		end
		local under = math.max(rw.bottom, tonumber(w.psBottomReach) or 0)
		local gap = { above = r.top + GAP, below = under + GAP, left = r.left + GAP, right = r.right + GAP }
		local top, bottom, left, right = edge:GetTop(), w:GetBottom(), edge:GetLeft(), edge:GetRight()
		local s, us = w:GetEffectiveScale() or 1, UIParent:GetEffectiveScale() or 1
		local sw, sh = UIParent:GetRight(), UIParent:GetTop()
		local cw = f:GetWidth() * k
		local fits = {
			above = not (top and sh) or (top + gap.above + h * k) * s <= sh * us,
			below = not bottom or (bottom - gap.below - h * k) * s >= 0,
			left = left ~= nil and (left - gap.left - cw) * s >= 0,
			right = right ~= nil and sw ~= nil and (right + gap.right + cw) * s <= sw * us,
		}
		-- Each side's box in screen pixels (the edge's units times s), and
		-- whether it keeps clear of the quest buttons and the target list.
		local hk = h * k
		local box = top and bottom and left and right and {
			above = { left, top + gap.above, left + cw, top + gap.above + hk },
			below = { left, bottom - gap.below - hk, left + cw, bottom - gap.below },
			left = { left - gap.left - cw, top - hk, left - gap.left, top },
			right = { right + gap.right, top - hk, right + gap.right + cw, top },
		}
		local B = ns.QoL and ns.QoL.Buttons
		local covers = box and B and B.Covers and B.Covers() or {}
		placedCovers = box and covers or nil
		local function clear(o)
			local x = box and box[o]
			if not x then return true end
			local l, b, rr, t = x[1] * s, x[2] * s, x[3] * s, x[4] * s
			for _, c in ipairs(covers) do
				if l < c[3] and c[1] < rr and b < c[4] and c[2] < t then return false end
			end
			return true
		end
		local cx, mid = edge:GetCenter(), UIParent:GetCenter()
		local towardLeft = cx and mid and cx * s > mid * us
		local order = place == "below" and { "below", "above" } or { "above", "below" }
		order[3], order[4] = towardLeft and "left" or "right", towardLeft and "right" or "left"
		-- The first side with room that keeps clear of the buttons, else the first with room.
		local function pick(ok)
			for _, o in ipairs(order) do
				if fits[o] and ok(o) then return o end
			end
		end
		local side = pick(clear) or pick(function() return true end) or "below"
		CT.side = side
		placedRoom = (side == "above" or side == "below") and hk + gap[side] or 0
		-- Beside the window, nothing of it is under the card however the screen
		-- moves it, so the screen keeps the card whole (a window reaching past
		-- the screen's top would take a top-aligned card with it).
		f:SetClampedToScreen(side == "left" or side == "right")
		local g = gap[side] / k
		if side == "above" then
			Anim.Anchor(f, "BOTTOMLEFT", edge, "TOPLEFT", 0, g)
			dy = -(h + g)
		elseif side == "below" then
			Anim.Anchor(f, "TOPLEFT", w, "BOTTOMLEFT", 0, -g)
			dy = h + g
		elseif side == "left" then
			Anim.Anchor(f, "TOPRIGHT", edge, "TOPLEFT", -g, 0)
			dy = 18
		else
			Anim.Anchor(f, "TOPLEFT", edge, "TOPRIGHT", g, 0)
			dy = 18
		end
	end
	local wasShown = f:IsShown()
	f:Show()
	if animate and not wasShown then
		-- From behind the edge it sits on; the entrance, speed and opacity are the player's (Alerts & toasts).
		if TS then
			TS.Enter("headsup", f, dy, SLIDE)
		else
			Anim.To(f, "offset", dy, 0, SLIDE, "out")
			Anim.To(f, "alpha", 0, 1, SLIDE, "out")
		end
	end
end

-- The height the card takes above or below the window while it shows there,
-- gap included (the edge's reach and GAP, as CT.Place placed it), in the
-- window's units. The guide window keeps window and card within ui.maxHeight
-- together (GuideFrameLayout); free or beside it, none.
function CT.Reserved()
	if not (f and CT.current and f:IsShown()) then return 0 end
	if CT.side ~= "above" and CT.side ~= "below" then return 0 end
	return placedRoom
end

-- The window makes room for the card, or takes it back: only when the room
-- the card takes changed and the window is held by its cap or would be with
-- the card (a layout redraws the whole window; a card beside it, free, or
-- over a window with room to spare changes nothing).
local laidRoom = 0
local function relayout()
	local room = CT.Reserved()
	if room == laidRoom then return end
	laidRoom = room
	local G = UI.GuideFrame
	if not (G and G.Layout and G.frame) then return end
	local goals = G.parts and G.parts.goals
	local capped = goals and goals.psOver
	if not capped and G.CapHeight and G.frame:GetHeight() + room <= G.CapHeight() + 0.5 then return end
	G.Layout()
end

-- The compact card's tooltip: what its one line leaves out.
function CT.CompactTip(c)
	local m = c.psModel
	if not (m and compactOn()) then return end
	local lines = {}
	local facts = factsOf(m)
	if facts then lines[#lines + 1] = facts end
	if m.badge then lines[#lines + 1] = { m.badge, Theme.Accent() } end
	if m.giver then lines[#lines + 1] = m.giver end
	if m.route then lines[#lines + 1] = m.route end
	W.Tooltip(c, CT.side == "below" and "ANCHOR_BOTTOM" or "ANCHOR_TOP", m.title or "", lines)
end

-- The compact card's menu: its second button and its "stop these".
function CT.ExtraMenu(button)
	local m = CT.current
	if not m then return end
	if W.MenuShown(button) then return W.HideMenu() end
	local items = {}
	if m.more then items[#items + 1] = { text = m.more.label, onClick = function() CT.More() end } end
	if m.off then items[#items + 1] = { text = m.off.label, onClick = function() CT.Off() end } end
	if #items > 0 then W.ShowMenu(button, items) end
end

-- Show the card for quest q (marks its reward told). -> true when shown
function CT.Show(q)
	local m = CT.Model(q)
	if not (m and window()) then return false end
	if not f then build() end
	local d = data()
	local done, rw = seen(), d.quests[q][3]
	done[q] = true
	-- The same reward from another giver: told once.
	for o in pairs(d.starts) do
		if d.quests[o] and d.quests[o][3] == rw then done[o] = true end
	end
	-- The guide window's class guide banner (QoL/ClassQuests.lua) says no
	-- more about the guide this offers.
	if m.guideId then
		local flags = ns.CharState().flags
		if type(flags) == "table" then
			flags.classOffered = type(flags.classOffered) == "table" and flags.classOffered or {}
			flags.classOffered[m.guideId] = true
		end
	end
	CT.ShowCard(m)
	return true
end

-- Paint card c for model m (without placing it).
local function fillCard(c, m)
	c.psModel = m
	paint(c, m.class)
	local art = m.art
	local size = art and ART or (m.iconColor and GLYPH) or ICON
	-- Sized with the ring by the layout (full or compact, sizeRing).
	c.psIconSize = size
	if art then
		c.Icon:SetTexture(art.file)
		c.Icon:SetTexCoord(art.l, art.r, art.t, art.b)
	else
		c.Icon:SetTexture(m.icon)
		c.Icon:SetTexCoord(0, 1, 0, 1)
	end
	local lift = art and art.lift
	if lift then
		c.Lift:SetTexture(art.file)
		c.Lift:SetTexCoord(art.l, art.r, art.t, art.b)
		c.Lift:SetAlpha(lift)
	end
	c.Lift:SetShown(lift ~= nil)
	if m.iconColor and not art then
		W.Color(c.Icon, m.iconColor)
	else
		W.Uncolor(c.Icon)
		c.Icon:SetVertexColor(1, 1, 1, 1)
	end
	c.Head:SetText(factsOf(m))
	W.Color(c.Title, m.titleColor or "personName")
	c.Title:SetText(m.title)
	c.Giver:SetText(m.giver or "")
	c.Giver:SetShown(m.giver ~= nil)
	c.Route:SetText(m.route or "")
	c.Route:SetShown(m.route ~= nil)
	CT.SetSpells(m.spells, c)
	c.Badge.Text:SetText(m.badge or "")
	c.Badge:SetShown(m.badge ~= nil)
	c.Act:SetShown(m.act ~= nil)
	if m.act then W.SetButtonText(c.Act, m.act.label) end
	c.More:SetShown(m.more ~= nil)
	if m.more then W.SetButtonText(c.More, m.more.label) end
	c.Off:SetShown(m.off ~= nil)
	if m.off then W.SetButtonText(c.Off, m.off.label) end
	W.SetButtonText(c.Later, m.later and m.later.label or L["Later"])
	c.Open:SetShown(m.act == nil and not m.noAct and m.guideId ~= nil)
	c.ShowMe:SetShown(m.act == nil and not m.noAct and m.guideId == nil)
end

-- A sandbox card for the options' preview, painted for model m at `width`.
function CT.NewCard(parent) return newCard(parent, nil, true) end
function CT.FillCard(c, m, width)
	fillCard(c, m)
	layout(c, width or 340)
end

-- Paint and place the card for model m: a class quest's (CT.Model) or
-- another heads-up's, which carries its own action instead of a quest:
-- { head, facts (the house look's line under the title, sentence case),
-- title, giver, route, badge, icon, class (nil: the accent),
-- titleColor, iconColor, art, act = { label, run }, more = { label, run },
-- off = { label, run }, later = { label, run }, spells, spellTip, spellRight,
-- hideAfter, quiet }. later: the Later button's own words and what it does
-- before the card hides (UI/UpdateCard.lua's "Got it").
-- art = { file, l, r, t, b, lift }: a picture
-- cropped to those texture coordinates, filling the ring, lifted by lift
-- (0-1) when dark; without it an icon tinted iconColor is a glyph, drawn
-- small on the disc, and an untinted one a full-colour icon. spells = { { id,
-- icon? } | { item, count? } }: a row of icons under the lines (SPELLS_MAX,
-- then "+N more"), each with the game's spell or item tooltip, spellTip(tooltip,
-- spell) adding lines to a spell's, spellRight(spell) run on a right-click; an
-- item's shows its count over its corner when above 1, and a modified click is
-- the bags' (W.ItemClick: Shift links it).
-- hideAfter: seconds on screen before it hides itself (not while the
-- pointer is on it); quiet: no chime; noAct: no action button (Later
-- leads the row). Without hideAfter, toasts.headsup.seconds (Alerts &
-- toasts), when set, is how long an unanswered card stays.
-- -> true when shown
function CT.ShowCard(m)
	if not (m and window()) then return false end
	if not f then build() end
	local wasShown = f:IsShown() and CT.current ~= nil
	CT.current = m
	fillCard(f, m)
	CT.Place(not wasShown)
	relayout()
	if not wasShown and f:IsShown() and not m.quiet then
		local C = CC()
		if ns.Get("ui.classCardSound") and C.GameSoundOn() then
			pcall(ns.PlaySound, (SOUNDKIT and SOUNDKIT.IG_QUEST_LIST_COMPLETE) or 878, "SFX")
		end
	end
	local TS = looks()
	local secs = m.hideAfter or (TS and tonumber(TS.Get("headsup", "seconds"))) or 0
	if secs > 0 then
		local function expire()
			if CT.current ~= m then return end
			-- Held while the cursor is on it.
			if f:IsShown() and f.IsMouseOver and f:IsMouseOver() then
				ns.After(5, expire)
				return
			end
			CT.Hide()
		end
		ns.After(secs, expire)
	end
	return f:IsShown()
end

-- Spell icon i of card c's row (the live card's by default), made on first
-- use. A sandbox card's icons show their tooltips and do nothing on a click.
function CT.SpellButton(i, c)
	c = c or f
	local b = c.SpellRow[i]
	if b then return b end
	b = CreateFrame("Button", nil, c)
	b:SetSize(SPELL, SPELL)
	b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	b.Icon = b:CreateTexture(nil, "ARTWORK")
	b.Icon:SetAllPoints(b)
	b.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	b:SetScript("OnEnter", function(self)
		local m, s = c.psModel, self.spell
		if not (m and s) then return end
		local place = function(tip) CT.PlaceTip(tip, c) end
		if s.item then return W.ItemTip(self, s.item, nil, place) end
		W.SpellTip(self, s.id, m.spellTip and function(tip) m.spellTip(tip, s) end or nil, place)
	end)
	b:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	b:SetScript("OnClick", function(self, button)
		local m, s = c.psModel, self.spell
		if c ~= f or not (m and s) then return end
		if s.item then
			W.ItemClick(s.item)
		elseif button == "RightButton" then
			if m.spellRight then m.spellRight(s) end
		else
			W.SpellClick(s.id)
		end
	end)
	-- An item's count, over its corner in white as on a bag slot: it sits on
	-- the game's icon art, whatever the look's own colours.
	b.Count = b:CreateFontString(nil, "OVERLAY")
	Theme.Font(b.Count, "number")
	b.Count:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 1, 0)
	b.Count:SetJustifyH("RIGHT")
	b.Count:SetTextColor(1, 1, 1, 1)
	b.Count:SetShadowColor(0, 0, 0, 1)
	b.Count:SetShadowOffset(1, -1)
	c.SpellRow[i] = b
	return b
end

-- A spell icon's tooltip beside card c (the live card's by default), never
-- over its lines: on the side of the card facing the middle of the screen,
-- top edges level.
function CT.PlaceTip(tip, c)
	c = c or f
	local cx = c:GetCenter()
	local mid = UIParent:GetCenter()
	local fs, us = c:GetEffectiveScale() or 1, UIParent:GetEffectiveScale() or 1
	if cx and mid and cx * fs > mid * us then
		tip:SetPoint("TOPRIGHT", c, "TOPLEFT", -4, 0)
		CT.tipSide = "left"
	else
		tip:SetPoint("TOPLEFT", c, "TOPRIGHT", 4, 0)
		CT.tipSide = "right"
	end
end

-- Card c's row of spell icons (the live card's by default) for list (nil:
-- none).
function CT.SetSpells(list, c)
	c = c or f
	local n = list and #list or 0
	local shown = min(n, SPELLS_MAX)
	for i = 1, shown do
		local b, s = CT.SpellButton(i, c), list[i]
		b.spell = s
		local C = ns.Compat
		if s.item then
			b.Icon:SetTexture(C.ItemIcon(s.item) or 134400)
		else
			b.Icon:SetTexture(s.icon or C.SpellIcon(s.id) or 134400)
		end
		b.Count:SetText(s.item and (s.count or 1) > 1 and tostring(s.count) or "")
		b:Show()
	end
	for i = shown + 1, #c.SpellRow do
		c.SpellRow[i].spell = nil
		c.SpellRow[i]:Hide()
	end
	if n > SPELLS_MAX then
		c.SpellMore:SetText(format(L["+%d more"], n - SPELLS_MAX))
		c.SpellMore:Show()
	else
		c.SpellMore:Hide()
	end
end

-- Dismissing a card lets a heads-up that waited for it show
-- (HEADS_UP_HIDDEN, with the model dismissed).
function CT.Hide()
	local was = CT.current
	CT.current = nil
	if f then f:Hide() end
	relayout()
	if was and ns.Fire then ns.Fire("HEADS_UP_HIDDEN", was) end
end

-- Another heads-up's action, its second button and its "stop these": the
-- model's own.
function CT.Act()
	local m = CT.current
	if m and m.act and m.act.run then return m.act.run(m) end
	return false
end

function CT.More()
	local m = CT.current
	if m and m.more and m.more.run then return m.more.run(m) end
	return false
end

function CT.Off()
	local m = CT.current
	if m and m.off and m.off.run then m.off.run(m) end
	CT.Hide()
end

-- Later, or the model's own words for it (m.later): its action, then the
-- card hides.
function CT.Later()
	local m = CT.current
	if m and m.later and m.later.run then m.later.run(m) end
	CT.Hide()
end

-- "Open in a new tab": the chain's Class guide in a new tab (the guide
-- menu's path, UI/Picker.lua), at the chain's step; the tab it came from is
-- remembered so the finished guide offers to go back (GuideFrame).
function CT.Open()
	local m, E = CT.current, ns.Engine
	if not (m and m.guideId and E and E.OpenTab) then return false end
	local from = E.GetGuide and E.GetGuide()
	if not E.OpenTab(m.guideId) then
		ns.Print(L["Six tabs is the limit. Close one to open another."])
		return false
	end
	if from and from.id ~= m.guideId then
		local st = ns.CharState()
		st.classReturn = st.classReturn or {}
		st.classReturn[m.guideId] = from.id
	end
	local step = CT.LandingStep(m.guideId, m.quest)
	if step and E.Goto then E.Goto(step) end
	ns.Set("ui.shown", true)
	CT.Hide()
	return true
end

-- "Show me": a trip to the giver for the character's race (Nav.StartTrip:
-- it ends there, and the guide window offers the way back on the way).
function CT.ShowMe()
	local m, N = CT.current, ns.Nav
	if not (m and m.map and m.x and m.y) then return false end
	if N and N.SetTarget then N.StartTrip(N.SetTarget(m.map, m.x, m.y, m.who, "e", nil, giverHeight(m.quest, { nil, m.map, m.x, m.y })), nil, L["Quest giver"]) end
	CT.Hide()
	return true
end

-- Show the best candidate. -> true when shown
function CT.Check(level, mode)
	local q = CT.Candidates(level, mode or "levelup")[1]
	return q ~= nil and CT.Show(q) or false
end

---------------------------------------------------------------------------
-- Events and the command
---------------------------------------------------------------------------

-- The new level arrives with the event (UnitLevel may still read the old one).
ns.RegisterEvent("PLAYER_LEVEL_UP", function(_, level)
	local n = tonumber(level)
	if n then ns.SafeCall(CT.Check, n, "levelup") end
end)

-- On login, a chain opened in the last levels and not taken; before the
-- guide window's class guide banner (QoL/ClassQuests.lua, after 3 seconds).
local loggedIn = false
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	if loggedIn then return end
	loggedIn = true
	ns.After(2, function() CT.Check(nil, "login") end)
end)

-- A reward item the client had not cached showed as "#20083" (#3727): once
-- it arrives, the card on screen names it.
ns.RegisterEvent("GET_ITEM_INFO_RECEIVED", function(_, itemID)
	local m = CT.current
	local items = m and m.reward and m.reward.items
	if not (items and f and f:IsShown() and f.psModel == m) then return end
	for _, id in ipairs(items) do
		if id == itemID then
			local name = CC().RewardName(m.reward)
			if name then
				m.title = format(L["%s ready"], CT.ShortName(name))
				f.Title:SetText(m.title)
			end
			return
		end
	end
end)

ns.RegisterCommand("classtoast", function(rest)
	local q = tonumber(rest and rest:match("%d+"))
	if not q then q = CT.Candidates(nil, "any")[1] end
	if not (q and CT.Show(q)) then ns.Print(L["No class quest is due for this character."]) end
end, L["Show the class quest heads-up again (the next one due, or a quest id)"])
