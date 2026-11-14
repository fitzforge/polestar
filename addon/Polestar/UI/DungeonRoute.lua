-- Dungeons on your way: a small popover from the guide window's menu and from
-- its notice after dungeons are turned on (UI/GuideFrameBanner.lua), so a
-- player sets the dungeons of their route where they are, without the
-- settings window. "Every dungeon" ("Dungeons in my route", behavior.dungeons:
-- Skip them, Ask me, Run them) and while they aren't skipped "Dungeon quests"
-- (behavior.dungeonQuests: Every quest, Only quests on my way), then the next
-- dungeons on this character's route
-- (Engine.DungeonsAhead: from the live step through the guides that follow),
-- each with about the level its run comes at, how many quests the route
-- picks up for it and where, and a switch: on runs it, off skips it (that
-- dungeon's own answer, Engine.ChooseDungeon, the one the settings'
-- Discovery, Dungeons rows set). A dungeon run takes every one of its quests
-- (Fitz, 2026-11-14); where some are off the way, a second switch under it,
-- "Only quests on my way", leaves those out and says what that saves (the
-- run's guide's `dungeonAll`: minutes, and the XP given up;
-- Engine.ChooseDungeonWayOnly). "All dungeons…" opens the settings' rows.
-- Core and small like Quick settings (UI/QuickSettings.lua): built on first
-- open, its rows filled again at each opening and after each answer. Escape,
-- a click outside it or the menu button again closes it; with the gamepad it
-- takes the focus like any Polestar window (B closes).
--
--   UI.DungeonRoute.Show(anchor) ; .Hide() ; .Shown() ; .Toggle(anchor)
--   UI.DungeonRoute.Rows() -> the dungeon rows shown, in order (tests): each with .psMap, .psOn,
--       .Name and .Sub (its two lines), .Switch, and .Way (its Only quests on my way row, shown or not:
--       .Label, .Note, .Switch, .psOn)

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, ipairs = math.floor, ipairs

local DR = {}
UI.DungeonRoute = DR

local WIDTH, ROW_H, DUNGEON_H, WAY_H, FOOT_H, PAD, INDENT = 340, 32, 46, 40, 48, 16, 32
local LIMIT = 5 -- dungeons listed
local DOT = "  \194\183  "

local pop, rows, shown = nil, {}, 0

local function Engine() return ns.Engine end

-- Every dungeon quest warns once per account (PolestarDB.dungeonQuestsWarned;
-- Fitz, 2026-11-14): more travelling, the dungeons' quests being scattered
-- across the world. -> whether it was shown before.
local function accountDB() return ns.DB and ns.DB() or PolestarDB end
local function warned()
	local db = accountDB()
	local was = type(db) == "table" and db.dungeonQuestsWarned == true
	if type(db) == "table" then db.dungeonQuestsWarned = true end
	return was
end

-- The warning, before Every dungeon quest applies: `apply` on Every quest,
-- `instead` (if any) on Only quests on my way or Escape. Shown before: apply.
function DR.ConfirmEveryQuest(apply, instead)
	if warned() then return apply() end
	W.Modal({ title = L["Every dungeon quest"], icon = "icon-dungeon",
		text = L["Be ready for more travelling. Dungeon quests are scattered across the world, so the route takes extra trips to pick them up and hand them in."],
		action = L["Every quest"], cancel = L["Only quests on my way"],
		onAccept = apply, onCancel = instead })
end

-- "23,100" for XP amounts.
local function thousands(n)
	local s = tostring(floor(n + 0.5))
	local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return (out:gsub("^,", ""))
end

-- A dungeon's second line: about the level its run comes at, how many quests
-- the route picks up for it and where (or that they are in the log), and that
-- the guide asks there while Ask me answers it.
local function subline(d)
	local parts = {}
	if d.level then parts[1] = string.format(L["About level %d"], floor(d.level + 0.5)) end
	local GF = UI.GuideFrame
	local zones = (d.picks or 0) > 0 and GF and GF.ZoneList and GF.ZoneList(d.pickMaps or {})
	if (d.picks or 0) > 0 then
		local quests = d.picks == 1 and L["1 quest"] or string.format(L["%d quests"], d.picks)
		parts[#parts + 1] = zones and string.format(L["%s in %s"], quests, zones) or quests
	elseif (d.inLog or 0) > 0 then
		parts[#parts + 1] = L["quests in your log"]
	end
	if d.answer == nil then parts[#parts + 1] = L["the guide asks"] end
	return table.concat(parts, DOT)
end

-- What Only quests on my way saves: "Saves about 14 min, 23,100 XP less".
local function saves(all)
	local m = floor((tonumber(all.minutes) or 0) + 0.5)
	if tonumber(all.xp) and all.xp > 0 then return string.format(L["Saves about %d min, %s XP less"], m, thousands(all.xp)) end
	return string.format(L["Saves about %d min"], m)
end

local function row(i)
	local r = rows[i]
	if r then return r end
	r = CreateFrame("Frame", nil, pop)
	r:SetSize(WIDTH, DUNGEON_H)
	r.Name = W.Text(r, "body", "text")
	r.Name:SetPoint("TOPLEFT", r, "TOPLEFT", PAD, -6)
	r.Sub = W.Text(r, "small", "textDim")
	r.Sub:SetPoint("TOPLEFT", r.Name, "BOTTOMLEFT", 0, -3)
	r.Switch = W.Switch(r, function() return r.psOn end, function(on)
		local E = Engine()
		if not (E and E.ChooseDungeon and r.psMap) then return end
		E.ChooseDungeon(r.psMap, on and true or false)
		DR.Fill()
	end, L["On: the guide picks up its quests and runs it. Off: the solo route."])
	r.Switch:SetPoint("TOPRIGHT", r, "TOPRIGHT", -8, -11)
	local textW = WIDTH - PAD - r.Switch:GetWidth() - 16
	r.Name:SetWidth(textW)
	r.Sub:SetWidth(textW)
	-- Only quests on my way, under it while it runs and has quests off the way.
	local way = CreateFrame("Frame", nil, r)
	way:SetSize(WIDTH - INDENT, WAY_H)
	way:SetPoint("TOPLEFT", r, "TOPLEFT", INDENT, -DUNGEON_H + 6)
	way.Label = W.Text(way, "label", "text")
	way.Label:SetPoint("TOPLEFT", way, "TOPLEFT", 0, -4)
	way.Label:SetText(L["Only quests on my way"])
	way.Note = W.Text(way, "small", "textDim")
	way.Note:SetPoint("TOPLEFT", way.Label, "BOTTOMLEFT", 0, -3)
	way.Switch = W.Switch(way, function() return way.psOn end, function(on)
		local E, map = Engine(), r.psMap
		if not (E and E.ChooseDungeonWayOnly and map) then return end
		local function choose(only)
			E.ChooseDungeonWayOnly(map, only)
			DR.Fill()
		end
		if on then return choose(true) end
		DR.ConfirmEveryQuest(function() choose(false) end, function() DR.Fill() end)
	end, L["On: the guide takes only this dungeon's quests on your way and leaves out the rest. Off: every quest of it."])
	way.Switch:SetPoint("TOPRIGHT", way, "TOPRIGHT", -8, -5)
	local wayW = WIDTH - INDENT - way.Switch:GetWidth() - 16
	way.Label:SetWidth(wayW)
	way.Note:SetWidth(wayW)
	r.Way = way
	r.Rule = W.Divider(r)
	r.Rule:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", PAD, 0)
	r.Rule:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", -PAD, 0)
	rows[i] = r
	return r
end

-- The dungeon rows and the popover's height, from the route as it is now:
-- as many of the next dungeons as fit on the screen at this UI scale (one at
-- least).
function DR.Fill()
	if not pop then return end
	local E = Engine()
	local list = E and E.DungeonsAhead and E.DungeonsAhead(LIMIT) or {}
	local room = UIParent:GetHeight() - 2 * PAD -- in the popover's units: Polestar's layer is the screen's size
	local y = pop.top
	local style = ns.Get("behavior.dungeons") ~= "skip"
	pop.Quests:SetShown(style)
	if style then
		pop.Quests:ClearAllPoints()
		pop.Quests:SetPoint("TOPLEFT", pop, "TOPLEFT", 0, -y)
		pop.Quests:Refresh()
		y = y + pop.questsH
	end
	pop.Head:ClearAllPoints()
	pop.Head:SetPoint("TOPLEFT", pop, "TOPLEFT", PAD, -(y + 12))
	y = y + 30
	shown = 0
	for i, d in ipairs(list) do
		local wayShown = d.allQuests ~= nil and d.answer ~= false
		local h = DUNGEON_H + (wayShown and WAY_H or 0)
		if i > 1 and y + h + FOOT_H > room then break end
		local r = row(i)
		r.psMap, r.psOn = d.map, d.answer == true
		r.Name:SetText(d.name or "")
		r.Sub:SetText(subline(d))
		r.Switch:Refresh()
		local way = r.Way
		way.psOn = d.wayOnly and true or false
		if wayShown then
			way.Note:SetText(saves(d.allQuests))
			way.Switch:Refresh()
		end
		way:SetShown(wayShown)
		r:SetHeight(h)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", pop, "TOPLEFT", 0, -y)
		r:Show()
		y = y + h
		shown = i
	end
	for i = 1, shown do rows[i].Rule:SetShown(i < shown) end
	for i = shown + 1, #rows do rows[i]:Hide() end
	pop.Empty:SetShown(#list == 0)
	if #list == 0 then
		pop.Empty:ClearAllPoints()
		pop.Empty:SetPoint("TOPLEFT", pop, "TOPLEFT", PAD, -(y + 4))
		y = y + floor(pop.Empty:GetStringHeight() + 12 + 0.5)
	end
	pop.All:ClearAllPoints()
	pop.All:SetPoint("TOP", pop, "TOPLEFT", WIDTH / 2, -(y + 8))
	pop:SetHeight(y + FOOT_H)
end

local function build()
	pop = CreateFrame("Frame", "PolestarDungeonRoute", ns.UIParent)
	pop:SetFrameStrata("DIALOG")
	pop:SetFrameLevel(20)
	pop:SetClampedToScreen(true)
	pop:EnableMouse(true)
	pop:SetWidth(WIDTH)
	-- A popup over other frames: its ground never see-through (Theme's menuBg).
	pop.psMenu = true
	Theme.Skin(pop, "panel")
	pop.Title = W.Text(pop, "heading", "text")
	pop.Title:SetText(L["Dungeons on your way"])
	pop.Title:SetPoint("TOPLEFT", pop, "TOPLEFT", PAD, -12)
	pop.Rule = W.Divider(pop)
	pop.Rule:SetPoint("TOPLEFT", pop, "TOPLEFT", 1, -W.CARD_HEADER)
	pop.Rule:SetPoint("TOPRIGHT", pop, "TOPRIGHT", -1, -W.CARD_HEADER)
	local y = W.CARD_HEADER + 1
	-- "Dungeons in my route" (the settings' name for it), here "Every dungeon": the answer for every dungeon not
	-- answered one by one, above the dungeons' own switches.
	local all = W.Dropdown(pop, L["Every dungeon"], "behavior.dungeons", {
		{ value = "skip", text = L["Skip them"] }, { value = "ask", text = L["Ask me"] }, { value = "run", text = L["Run them"] },
	}, L["For every dungeon you have not set on its own: skip them (the solo route), the guide asks at each, or run them all."])
	W.CompactRow(all, { height = ROW_H })
	all:SetPoint("TOPLEFT", pop, "TOPLEFT", 0, -y)
	y = y + W.LayoutRow(all, WIDTH)
	pop.AllDungeons = all
	pop.top = y
	-- "Dungeon quests" (behavior.dungeonQuests), while dungeons aren't skipped: every quest of a dungeon that runs,
	-- or only the ones on the way; a dungeon's own switch below wins.
	local quests = W.Dropdown(pop, L["Dungeon quests"], "behavior.dungeonQuests", {
		{ value = "all", text = L["Every quest"] }, { value = "way", text = L["Only quests on my way"] },
	}, L["Every dungeon quest: be ready for more travelling. Dungeon quests are scattered across the world, so the route takes extra trips to pick them up and hand them in. Only quests on my way: the ones on stops the route makes anyway."])
	W.CompactRow(quests, { height = ROW_H })
	pop.questsH = W.LayoutRow(quests, WIDTH)
	pop.Quests = quests
	pop.Head = W.Text(pop, "small", "textDim")
	pop.Head:SetText(L["Next on your route"])
	pop.Empty = W.Text(pop, "note", "textDim")
	pop.Empty:SetWordWrap(true)
	pop.Empty:SetWidth(WIDTH - PAD * 2)
	pop.Empty:SetText(L["No dungeon is left on your route."])
	-- All dungeons…: the settings' rows for every dungeon of this character's guides.
	pop.All = W.Button(pop, L["All dungeons\226\128\166"], function()
		DR.Hide()
		if UI.ShowOptions then UI.ShowOptions("dungeons") end
	end, { width = WIDTH - 32 })
	-- A click anywhere else closes it.
	local catcher = CreateFrame("Button", nil, ns.UIParent)
	catcher:SetAllPoints(UIParent)
	catcher:SetFrameStrata("DIALOG")
	catcher:SetFrameLevel(1)
	catcher:RegisterForClicks("AnyUp")
	catcher:SetScript("OnClick", function() DR.Hide() end)
	catcher:Hide()
	pop.Catcher = catcher
	pop:SetScript("OnHide", function() catcher:Hide() end)
	pop:Hide()
	ns.CloseOnEscape("PolestarDungeonRoute")
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(pop, { back = function() DR.Hide() end })
	end
	-- "Dungeons in my route" changed here or elsewhere: the switches follow.
	ns.On("SETTING_CHANGED", function(path)
		if pop:IsShown() and (path == "behavior.dungeons" or path == "behavior.dungeonQuests" or path == "behavior" or path == "") then DR.Fill() end
	end)
	ns.On("DUNGEON_ANSWERED", function() if pop:IsShown() then DR.Fill() end end)
end

-- The warning comes before Every dungeon quest applies, from wherever it is
-- chosen (the settings, this popover, the install): the choice waits as Only
-- quests on my way until the player takes it. Turned on with Every dungeon
-- quest already chosen (the default), it asks then, the route not walked
-- yet. Once per account; never over the install, whose card says it.
do
	local holding = false
	local function installing() return UI.Welcome and UI.Welcome.IsShown and UI.Welcome.IsShown() end
	ns.On("SETTING_CHANGED", function(path, value)
		if holding or not ns.IsLoggedIn() then return end
		local dq = path == "behavior.dungeonQuests" and value == "all"
		local on = path == "behavior.dungeons" and value ~= "skip" and ns.Get("behavior.dungeonQuests") == "all"
		local db = accountDB()
		if not (dq or on) or (type(db) == "table" and db.dungeonQuestsWarned) then return end
		if installing() then warned(); return end
		if dq then
			holding = true
			ns.Set("behavior.dungeonQuests", "way")
			holding = false
		end
		DR.ConfirmEveryQuest(function()
			holding = true
			ns.Set("behavior.dungeonQuests", "all")
			holding = false
		end, function()
			holding = true
			ns.Set("behavior.dungeonQuests", "way")
			holding = false
		end)
	end)
end

-- Open by `anchor` (the guide window's menu button), its right edges lined
-- up under it.
function DR.Show(anchor)
	if not pop then build() end
	W.HideMenu()
	if UI.QuickSettings and UI.QuickSettings.Hide then UI.QuickSettings.Hide() end
	pop:ClearAllPoints()
	if anchor then
		pop:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", 0, -4)
	else
		pop:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
	pop.AllDungeons:Refresh()
	DR.Fill()
	pop.Catcher:Show()
	pop:Show()
	pop:Raise()
	Anim.To(pop, "alpha", 0, 1, Anim.FAST, "out")
	return pop
end

function DR.Hide()
	if pop then pop:Hide() end
end

function DR.Shown() return pop ~= nil and pop:IsShown() end

-- Open, or close it when it is open.
function DR.Toggle(anchor)
	if DR.Shown() then return DR.Hide() end
	return DR.Show(anchor)
end

function DR.Rows()
	local out = {}
	for i = 1, shown do out[i] = rows[i] end
	return out
end
