-- The class spell heads-ups on the guide window's card (UI/ClassToast.lua),
-- from QoL/Spells.lua:
--
-- LEVELUP_SPELLS: "LEVEL 12 · PRIEST", "3 new spells to train", a row of
-- their icons (the game's tooltip on each), what they cost together in the
-- success colour when the character can pay it, the warning colour when not,
-- and the nearest class trainer; "Show me" points the arrow there (Nearby's
-- class trainer trip). Quiet (no chime) and gone by itself after HIDE_AFTER
-- seconds. "Turn these off" sets qol.levelUpSpells off.
--
-- OLD_RANKS: "2 spells on your bars are an old rank", their icons and
-- "Renew 2 → 3 · Fireball 4 → 5"; "Upgrade" puts the highest rank in those
-- slots (Spells.Upgrade); a right-click on an icon keeps that spell at its
-- rank ("Keep this rank", said in its tooltip). "Turn these off" sets
-- qol.oldRanks off.
--
-- Another heads-up on the card goes first: these wait for it to be dismissed
-- (HEADS_UP_HIDDEN), the newest of each kind kept.

local ADDON, ns = ...
local UI, Theme = ns.UI, ns.Theme
local L = ns.L
local format, ipairs, concat = string.format, ipairs, table.concat

local SC = {}
UI.SpellCards = SC

SC.HIDE_AFTER = 30

local function CT() return UI.ClassToast end
local function Q() return ns.QoL end

local function money(c)
	local q = Q()
	return q and q.Money and q.Money(c) or tostring(c)
end

local waiting = {} -- kind -> notice

-- "Show me": the arrow to the nearest class trainer.
function SC.ShowTrainer()
	local N = ns.Nav and ns.Nav.nearby
	local ok = N and N.Go and N.Go("class")
	if ok then CT().Hide() end
	return ok
end

function SC.LevelModel(n)
	local p = ns.Compat.GetPlayerInfo() or {}
	local count = #n.spells
	local m = { kind = "levelUp", class = p.class, quiet = true, hideAfter = SC.HIDE_AFTER, icon = Theme.Media("icon-train") }
	m.head = format(L["LEVEL %d · %s"], n.level, (UI.ClassName and p.class and UI.ClassName(p.class) or ""):upper())
	m.title = count == 1 and L["1 new spell to train"] or format(L["%d new spells to train"], count)
	m.titleColor = "text"
	local spells = {}
	for i, s in ipairs(n.spells) do
		spells[i] = { id = s.id, rank = s.rank, cost = s.cost }
	end
	m.spells = spells
	m.icon = ns.Compat.SpellIcon(spells[1].id) or m.icon
	local can = (n.money or 0) >= (n.cost or 0)
	local line = can and format(L["Cost %s: you can pay for all of them."], money(n.cost))
		or format(L["Cost %s: you have %s."], money(n.cost), money(n.money or 0))
	m.giver = "|c" .. Theme.Hex(can and "success" or "warning") .. line .. "|r"
	m.affordable = can
	local t = n.trainer
	if t and t.npcName then
		local zone = t.map and ns.Compat.GetMapName and ns.Compat.GetMapName(t.map)
		m.route = zone and format(L["Nearest class trainer: %s, %s."], t.npcName, zone) or format(L["Nearest class trainer: %s."], t.npcName)
		m.act = { label = L["Show me"], run = SC.ShowTrainer }
	end
	m.spellTip = function(tip, s)
		if s.cost and s.cost > 0 then tip:AddLine(format(L["Training cost: %s"], money(s.cost)), 1, 1, 1) end
	end
	m.off = { label = L["Turn these off"], run = function()
		ns.Set("qol.levelUpSpells", false)
		ns.Print(L["Level-up spell cards are off. Turn them back on under Options > Quality of Life > Vendors > Trainers."])
	end }
	return m
end

local ARROW = " \226\134\146 "

function SC.RanksModel(n)
	local S = Q() and Q().Spells
	local count = #n.spells
	local m = { kind = "oldRanks", quiet = true, icon = Theme.Media("icon-train") }
	m.head = L["ACTION BARS"]
	m.title = count == 1 and L["1 spell on your bars is an old rank"] or format(L["%d spells on your bars are an old rank"], count)
	m.titleColor = "text"
	local spells, names = {}, {}
	for i, e in ipairs(n.spells) do
		spells[i] = { id = e.id, bestId = e.bestId }
		names[#names + 1] = (e.name or "?") .. " " .. e.have .. ARROW .. e.best
	end
	m.spells = spells
	m.icon = ns.Compat.SpellIcon(spells[1].id) or m.icon
	m.giver = concat(names, "  \194\183  ")
	if n.slots > count then m.route = format(L["%d action buttons in all."], n.slots) end
	m.act = { label = L["Upgrade"], run = function()
		if S then S.Upgrade() end
		return true
	end }
	m.spellTip = function(tip)
		tip:AddLine(" ")
		tip:AddLine(L["Right-click: keep this rank on your bars"], 0.6, 0.8, 1)
	end
	-- Kept: it leaves the list (Options, "Forget kept ranks", lists it again).
	m.spellRight = function(s)
		if not S then return end
		S.Keep(s.id)
		if GameTooltip then GameTooltip:Hide() end
		S.CheckRanks(true)
	end
	m.off = { label = L["Turn these off"], run = function()
		ns.Set("qol.oldRanks", false)
		ns.Print(L["Old rank cards are off. Turn them back on under Options > Quality of Life > Vendors > Trainers."])
	end }
	return m
end

local MODELS = { levelUp = SC.LevelModel, oldRanks = SC.RanksModel }

-- Show notice n of `kind` now, or once the card is free. -> true when on screen
function SC.Show(kind, n)
	local T = CT()
	if not (T and T.ShowCard) then return false end
	local cur = T.current
	if cur and cur.kind ~= kind then
		waiting[kind] = n
		return false
	end
	waiting[kind] = nil
	return T.ShowCard(MODELS[kind](n))
end

ns.On("LEVELUP_SPELLS", function(n)
	if type(n) == "table" and n.spells and #n.spells > 0 then SC.Show("levelUp", n) end
end)

-- nil: nothing left to tell; the card goes if it is showing them.
ns.On("OLD_RANKS", function(n)
	local T = CT()
	if type(n) == "table" and n.spells and #n.spells > 0 then
		SC.Show("oldRanks", n)
		return
	end
	waiting.oldRanks = nil
	if T and T.current and T.current.kind == "oldRanks" then T.Hide() end
end)

ns.On("HEADS_UP_HIDDEN", function()
	ns.After(0.5, function()
		local T = CT()
		if T and T.current then return end
		for _, kind in ipairs({ "levelUp", "oldRanks" }) do
			local n = waiting[kind]
			if n then
				SC.Show(kind, n)
				return
			end
		end
	end)
end)
