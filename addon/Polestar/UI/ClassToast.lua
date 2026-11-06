-- The class quest heads-up (PolestarClassToast): a card that lives on the
-- guide window. When the character reaches the level of one of its class's
-- quest chains it slides up from behind the window's top edge and sits on
-- it, as wide as the window, in the window's own panel, fonts and buttons;
-- the class colour marks only its stripe, its icon ring and its small header
-- ("LEVEL 10 · WARLOCK"). It says what is ready ("Voidwalker ready", the
-- name in the NPC colour), who gives it for the character's
-- race ("Get it from Ophek, Durotar.") and, when the loaded guide has a step
-- for the chain ahead, "Your route takes you there at <step>.". It always
-- offers a way to act: "Open in a new tab" (the chain's Class guide, at the
-- chain's step) or, without one, "Show me" (the arrow to the giver); "Later"
-- and the close button dismiss it. It follows the window when moved, flips
-- below it when there is no room above, and hides while the window is
-- hidden. Under ui.reduceMotion it fades in instead of sliding.
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
--   /polestar classtoast [quest]           show it again (the best due one, or `quest`)

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, min, format, type, ipairs, pairs = math.floor, math.max, math.min, string.format, type, ipairs, pairs

local CT = {}
UI.ClassToast = CT

local PAD = 14
local RING = 40
local STRIPE = 4
local SLIDE = 0.25
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

local function spellKnown(id)
	if IsPlayerSpell and IsPlayerSpell(id) then return true end
	if IsSpellKnown and IsSpellKnown(id) then return true end
	return false
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
	if reward.spell and spellKnown(reward.spell) then return true end
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
					if type(title) ~= "string" or title == "" then title = format(L["Step %d"], (E.StepNumber and E.StepNumber(s)) or s) end
					return s, title
				end
			end
		end
	end
	return nil
end

-- The chain's own Class guide for this character: one that takes quest q,
-- else one that takes another quest of its chain. -> guide id | nil
function CT.ClassGuide(q)
	local G, C = ns.Guides, CC()
	local p = C and C.Player()
	if not (G and G.List and G.Get and p) then return nil end
	local chain, other = C.ChainOf(q), nil
	for _, h in ipairs(G.List()) do
		if h.category == "Class" and (not G.GuideMatches or G.GuideMatches(h, p)) then
			local g = G.Get(h.id)
			for _, step in ipairs(g and g.steps or {}) do
				for _, goal in ipairs(step.goals or {}) do
					if goal.quest == q then return h.id end
					if not other and ofChain(goal, q, chain) then other = h.id end
				end
			end
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
	m.head = format(L["LEVEL %d · %s"], s[1], UI.ClassName(p.class):upper())
	m.title = name and format(L["%s ready"], CT.ShortName(name)) or UI.ClassName(p.class)
	local where = giver[2] and UI.MapName(giver[2])
	m.giver = where and format(L["Get it from %s, %s."], giver[1], where) or format(L["Get it from %s."], giver[1])
	m.map, m.x, m.y, m.who = giver[2], giver[3], giver[4], giver[1]
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

local function build()
	f = CreateFrame("Frame", "PolestarClassToast", UIParent)
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
	f.Icon:SetSize(RING - 8, RING - 8)
	f.Icon:SetPoint("CENTER", f.Ring, "CENTER", 0, 0)
	if f.CreateMaskTexture and f.Icon.AddMaskTexture then
		f.Mask = f:CreateMaskTexture()
		f.Mask:SetTexture(Theme.Media("circle"), "CLAMPTOBLACKADDITIONAL", "CLAMPTOBLACKADDITIONAL")
		f.Mask:SetAllPoints(f.Icon)
		f.Icon:AddMaskTexture(f.Mask)
	end

	-- The window's type: the small header, the name in the NPC colour, muted lines.
	f.Head = text(f, "small", "text")
	f.Title = text(f, "name", "personName")
	f.Giver = text(f, "small", "textDim")
	f.Route = text(f, "small", "textMuted")

	-- What it brings, in the window's accent chip.
	f.Badge = CreateFrame("Frame", nil, f)
	f.Badge.Fill = W.Fill(f.Badge, "chipAccent", "BACKGROUND")
	f.Badge.Text = W.Text(f.Badge, "caption", "accent")
	f.Badge.Text:SetPoint("CENTER", f.Badge, "CENTER", 0, 0)

	f.Rule = W.Divider(f)

	-- The window's icon button and its buttons: the gold primary ("Choose a
	-- guide") and the quiet one beside it.
	f.Close = W.IconButton(f, "close", 24, L["Dismiss"], function() CT.Hide() end)
	f.Open = W.Button(f, L["Open in a new tab"], function() CT.Open() end, { primary = true })
	f.ShowMe = W.Button(f, L["Show me"], function() CT.ShowMe() end, { primary = true })
	f.Later = W.Button(f, L["Later"], function() CT.Hide() end, { ghost = true })
	f:Hide()
	CT.frame = f

	local w = window()
	if w then
		w:HookScript("OnHide", function() if f then f:Hide() end end)
		w:HookScript("OnShow", function() if CT.current then CT.Place(true) end end)
		w:HookScript("OnSizeChanged", function() if f:IsShown() then CT.Place(false) end end)
	end
end

local function paint(class)
	local r, g, b = Theme.ClassColor(class)
	if not r then r, g, b = Theme.Accent() end
	local tr, tg, tb = CC().TextColor(class)
	f.Stripe:SetVertexColor(r, g, b, 1)
	f.Ring:SetVertexColor(r, g, b, 1)
	f.Head:SetTextColor(tr, tg, tb, 1)
	-- The icon buttons at the window's sizes (GuideFrame.ApplySkin).
	local iw, ih, ig = Theme.Metric("guideIconBtnW", 24), Theme.Metric("guideIconBtnH", 24), Theme.Metric("guideIcon", 14)
	f.Close:SetSize(iw, ih)
	f.Close.Icon:SetSize(ig, ig)
	W.SetFramed(f.Close, "icon")
end

function layout(width)
	f:SetWidth(width)
	local x = PAD + STRIPE + RING + 12
	local closeW = f.Close:GetWidth() + 6
	f.Ring:ClearAllPoints()
	f.Ring:SetPoint("TOPLEFT", f, "TOPLEFT", PAD + STRIPE, -PAD)
	f.Close:ClearAllPoints()
	f.Close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -6, -6)
	local badgeW = 0
	if f.Badge:IsShown() then
		badgeW = floor(W.TextWidth(f.Badge.Text) + 14 + 0.5)
		f.Badge:SetSize(badgeW, 18)
		f.Badge:ClearAllPoints()
		f.Badge:SetPoint("TOPRIGHT", f, "TOPRIGHT", -(closeW + 4), -PAD + 2)
		badgeW = badgeW + 8
	end
	local tw = max(60, width - x - PAD)
	f.Head:SetWidth(max(40, width - x - closeW - badgeW - 4))
	f.Title:SetWidth(max(60, width - x - closeW))
	f.Giver:SetWidth(tw)
	f.Route:SetWidth(tw)
	local y = PAD
	f.Head:ClearAllPoints()
	f.Head:SetPoint("TOPLEFT", f, "TOPLEFT", x, -y)
	y = y + f.Head:GetStringHeight() + 4
	f.Title:ClearAllPoints()
	f.Title:SetPoint("TOPLEFT", f, "TOPLEFT", x, -y)
	y = y + f.Title:GetStringHeight() + 4
	for _, fs in ipairs({ f.Giver, f.Route }) do
		if fs:IsShown() then
			fs:ClearAllPoints()
			fs:SetPoint("TOPLEFT", f, "TOPLEFT", x, -y)
			y = y + fs:GetStringHeight() + 3
		end
	end
	y = max(y, PAD + RING) + 10
	f.Rule:ClearAllPoints()
	f.Rule:SetPoint("TOPLEFT", f, "TOPLEFT", PAD + STRIPE, -y)
	f.Rule:SetPoint("TOPRIGHT", f, "TOPRIGHT", -PAD, -y)
	y = y + 10
	local act = f.Open:IsShown() and f.Open or f.ShowMe
	act:ClearAllPoints()
	act:SetPoint("TOPLEFT", f, "TOPLEFT", PAD + STRIPE, -y)
	f.Later:ClearAllPoints()
	f.Later:SetPoint("LEFT", act, "RIGHT", 8, 0)
	y = y + act:GetHeight() + PAD
	f:SetHeight(floor(y + 0.5))
end

-- Put the card on the window: above its top edge, or under its bottom one
-- when the screen has no room above. animate: slide out from behind it (a
-- fade under ui.reduceMotion).
function CT.Place(animate)
	local w = window()
	if not (f and w and CT.current) then return end
	if not w:IsShown() then
		f:Hide()
		return
	end
	f:SetScale(w:GetScale() or 1)
	f:SetFrameStrata(w:GetFrameStrata())
	-- Behind the window, so it slides out from under its edge.
	if w:GetFrameLevel() < 2 then w:SetFrameLevel(2) end
	f:SetFrameLevel(w:GetFrameLevel() - 1)
	layout(w:GetWidth())
	local h = f:GetHeight()
	local top, room = w:GetTop(), UIParent:GetTop()
	local s, us = w:GetEffectiveScale() or 1, UIParent:GetEffectiveScale() or 1
	local above = not (top and room) or (top + h) * s <= room * us
	CT.side = above and "above" or "below"
	if above then
		Anim.Anchor(f, "BOTTOMLEFT", w, "TOPLEFT", 0, -1)
	else
		Anim.Anchor(f, "TOPLEFT", w, "BOTTOMLEFT", 0, 1)
	end
	local wasShown = f:IsShown()
	f:Show()
	if animate and not wasShown then
		Anim.To(f, "offset", above and -h or h, 0, SLIDE, "out")
		Anim.To(f, "alpha", 0, 1, SLIDE, "out")
	end
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
	local wasShown = f:IsShown() and CT.current ~= nil
	CT.current = m
	paint(m.class)
	f.Icon:SetTexture(m.icon)
	f.Head:SetText(m.head)
	f.Title:SetText(m.title)
	f.Giver:SetText(m.giver or "")
	f.Giver:SetShown(m.giver ~= nil)
	f.Route:SetText(m.route or "")
	f.Route:SetShown(m.route ~= nil)
	f.Badge.Text:SetText(m.badge or "")
	f.Badge:SetShown(m.badge ~= nil)
	f.Open:SetShown(m.guideId ~= nil)
	f.ShowMe:SetShown(m.guideId == nil)
	CT.Place(not wasShown)
	if not wasShown and f:IsShown() then
		local C = CC()
		if ns.Get("ui.classCardSound") and C.GameSoundOn() and PlaySound then
			pcall(PlaySound, (SOUNDKIT and SOUNDKIT.IG_QUEST_LIST_COMPLETE) or 878, "SFX")
		end
	end
	return true
end

function CT.Hide()
	CT.current = nil
	if f then f:Hide() end
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

-- "Show me": the arrow to the giver for the character's race.
function CT.ShowMe()
	local m, N = CT.current, ns.Nav
	if not (m and m.map and m.x and m.y) then return false end
	if N and N.SetTarget then N.SetTarget(m.map, m.x, m.y, m.who, "e") end
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

ns.RegisterCommand("classtoast", function(rest)
	local q = tonumber(rest and rest:match("%d+"))
	if not q then q = CT.Candidates(nil, "any")[1] end
	if not (q and CT.Show(q)) then ns.Print(L["No class quest is due for this character."]) end
end, L["Show the class quest heads-up again (the next one due, or a quest id)"])
