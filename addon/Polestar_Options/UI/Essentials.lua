-- Essentials on the new settings page (UI/Grouped.lua, while it is on):
-- Guide, Questing, Quality of Life, Guide window and Alerts & toasts open on
-- an Essentials tab, first in the tab band with the star, holding the
-- settings players reach for first (docs/superpowers/specs/
-- 2026-11-17-settings-ia-review.md, section 5). Each row is a reference to
-- its home row (O.Ref): the same setting, changed in either place; search,
-- the counts, the Changed view and the resets see the home alone, as the tab
-- is none of the page's registered tabs. Each row names its home's tab in a
-- muted link after its label, which opens the home row (O.JumpTo).
--
-- On Guide window and Alerts & toasts, whose own Essentials tab leads with
-- Presets, this tab takes that one's place on the new page: its Presets
-- first, its live preview kept, and any section of it that is a setting's
-- home (Alerts & toasts' All alerts), then these settings. The current page
-- keeps its own tabs as they are.

local ns = Polestar
local UI, W = ns.UI, ns.Widgets
local L = ns.L
local O = UI.Options
local K = O.Kit
local G = O.Grouped
local ipairs = ipairs

local SEP = " \226\128\186 "

-- Each page's picks, by its key, in the order they show.
G.ESSENTIALS = {
	guide = {
		"behavior.whileHere",
		"nav.arrow", "nav.travel", "nav.routeLines", "nav.routeStyle",
		"behavior.autoSelectGuide", "behavior.guideEnd", "behavior.routeChoice",
		"behavior.skipGrey", "behavior.dungeons",
	},
	questing = {
		"behavior.autoAccept", "behavior.autoTurnin", "qol.skipGossip",
		"qol.rewardHighlight", "qol.rewardAutoPick", "qol.rewardEquip",
		"qol.itemButton", "qol.targetButton",
		"qol.questTooltips", "party.show",
	},
	qualityoflife = {
		"qol.sellJunk", "qol.autoRepair", "qol.bagSpace",
		"maps.flightTimer", "qol.flightAutoOpen",
		"qol.xpTracker", "qol.deathHelper", "qol.acceptSummon", "qol.declineDuels",
	},
	guidewindow = {
		"ui.scale", "ui.width", "guideWindow.bgOpacity", "ui.combat", "ui.instance",
		"ui.upcoming", "ui.showNotes", "ui.guideTextSize", "ui.compact", "ui.locked",
	},
	alerts = {
		"rares.alerts", "rares.treasureAlerts", "nav.alerts", "nav.alertBanner", "dungeons.headsUp",
		"toasts.stack", "toasts.headsup.place",
		"rares.soundKit", "nav.alertSound", "ui.classCardSound",
	},
}

-- The tabs built, by page key; built again after a registration.
local built = {}
local invalidate = G.Invalidate
function G.Invalidate()
	built = {}
	return invalidate()
end

-- Whether a section holds a row that is no reference (picture cards, a
-- setting's home).
local function ownRows(s)
	for _, c in ipairs(s.controls) do
		if not rawget(c, "ref") then return true end
	end
	return false
end

-- Page p's Essentials tab while the new page is on, else nil: the page's
-- own Presets (and preview) and its other sections of rows of their own,
-- then one section of references to the picks registered. -> t | nil
function G.EssentialsTab(p)
	if not (p and G.On()) then return nil end
	local keys = G.ESSENTIALS[p.key]
	if not keys then
		-- A page's own Essentials tab wears the same star (the emblem's).
		for _, own in ipairs(p.tabs) do
			if own.name == L["Essentials"] then own.icon = "emblem" end
		end
		return nil
	end
	local t = built[p.key]
	if t then return t end
	local name = L["Essentials"]
	t = { name = name, icon = "emblem", sections = {}, psEssentials = true }
	for _, own in ipairs(p.tabs) do
		if own.name == name then
			t.preview = own.preview
			for _, s in ipairs(own.sections) do
				if s.name == L["Presets"] or ownRows(s) then t.sections[#t.sections + 1] = s end
			end
		end
	end
	local s = { name = L["Most used"], controls = {}, psTab = t }
	for _, key in ipairs(keys) do
		local home = O.HomeControl(key)
		if home then
			local c = O.Ref(home.kind, key, { essentials = true })
			c.page, c.tab, c.section, c.psSection = p, name, s.name, s
			s.controls[#s.controls + 1] = c
		end
	end
	t.sections[#t.sections + 1] = s
	built[p.key] = t
	return t
end

-- The link's text: the home's tab ("Page › Tab" for a home on another
-- page; the section where the tab has no name). -> text, its tooltip
local function homeText(c)
	local home = O.HomeOf(c)
	local hp = home and rawget(home, "page")
	if not hp then return "", nil end
	local tab = home.tab or ""
	if tab == "" then tab = home.section or "" end
	local text = tab
	if hp ~= rawget(c, "page") then
		text = (tab ~= "" and #K.shownTabs(hp) > 1) and (hp.name .. SEP .. tab) or hp.name
	end
	return text, G.PathOf(c)
end

-- The links of tab t's rows in view, before its layout: each row's
-- row.psAfter, laid out after its label (W.LayoutCompact).
function G.EssentialsLinks(view, t)
	for _, s in ipairs(t.sections) do
		for _, c in ipairs(s.controls) do
			if rawget(c, "essentials") and K.available(c) then
				local row = K.rowOf(view, c)
				local text, tip = homeText(c)
				local link = rawget(row, "psAfter")
				if not link then
					local key = c.key
					link = W.Link(row, text, function() O.JumpTo(key) end, { role = "note" })
					W.Color(link.Label, "textMuted")
					link:HookScript("OnLeave", function(self) W.Color(self.Label, "textMuted") end)
					row.psAfter = link
				end
				W.SetLinkText(link, text)
				link.psTip = tip
			end
		end
	end
end
