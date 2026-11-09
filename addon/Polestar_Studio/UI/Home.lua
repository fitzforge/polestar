-- Home (spec 4.1, 4.5): the welcome, the author handle, Start a guide (type,
-- template, name, faction, races, classes, levels), Open (my drafts,
-- imported guides that carry their source, a pasted string), Fork (a new id
-- under the author's handle, credits and licence carried on, -ND refused),
-- and the 60-second tour.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local P = _G.Polestar
local Theme, W = UI.Theme, UI.W
local format, floor, max, ipairs, pairs, type, tostring, tonumber, concat =
	string.format, math.floor, math.max, ipairs, pairs, type, tostring, tonumber, table.concat

local Home = {}
UI.Home = Home

local DOT = "  \194\183  "
local CATEGORIES = { "Leveling", "Dungeon", "Profession", "Collectible", "Chain", "Farm", "Reputation" }

-- Each type's starting steps (the template); "Empty" starts with none.
local TEMPLATES = {
	Leveling = { "Arrive in the zone", "First quests", "Turn in and move on" },
	Dungeon = { "Pick up the dungeon's quests", "Way to the entrance", "Inside: first boss", "Turn in" },
	Profession = { "Train Apprentice", "Skill to 50", "Train Journeyman", "Skill to 125" },
	Collectible = { "What you need", "Get it" },
	Chain = { "Start the chain" },
	Farm = { "Go to the farm", "Farm loop", "Sell" },
	Reputation = { "Reach Friendly", "Reach Honored" },
}

local root, scroll, c
local form = { category = "Leveling", faction = "Both", template = true, races = {}, classes = {} }
local pasted -- { entry, reason }
local draftRows, importRows

local function slug(s)
	s = (s or ""):lower():gsub("[^a-z0-9]+", "-"):gsub("^-+", ""):gsub("-+$", "")
	return s ~= "" and s:sub(1, 40) or "guide"
end

local function isND(license)
	return type(license) == "string" and license:upper():find("%-ND") ~= nil
end

-- Open or fork an import payload ({ format, license, guide, source }).
function Home.OpenPayload(entry, fork)
	if type(entry) ~= "table" or type(entry.source) ~= "table" then
		UI.Say(L["Read only: ask the author for a Studio string."], "warning")
		return
	end
	local doc
	if fork then
		if isND(entry.license) then
			UI.Say(format(L["This guide's licence (%s) allows no derivatives: it cannot be forked."], tostring(entry.license)), "danger")
			return
		end
		local handle = UI.Handle()
		if not handle then
			UI.Say(L["Pick your author handle first: it starts your guide ids."], "warning")
			if root then root.Handle:SetFocus() end
			return
		end
		doc = S.Model.Fork(entry, handle)
	else
		doc = S.Model.Open(entry)
	end
	if doc then
		if doc.header and doc.header.id then S.Model.SetCurrent(doc.header.id) end
		UI.ShowHome(false)
		UI.Say(fork and format(L["Forked as %s."], tostring(doc.header.id)) or format(L["Opened %s."], tostring(doc.header.title or doc.header.id)), "success")
	else
		UI.Say(L["This guide could not be opened."], "danger")
	end
end

local function importEntry(id)
	local I = P.Import
	if I and I.Entry then
		local ok, e = pcall(I.Entry, id)
		if ok and e then return e end
	end
	local db = _G.PolestarDB
	return db and db.imports and db.imports[id]
end

local function create()
	local handle = UI.Handle()
	if not handle then
		UI.Say(L["Pick your author handle first: it starts your guide ids."], "warning")
		root.Handle:SetFocus()
		return
	end
	local title = root.Name:GetText() or ""
	if title == "" then
		UI.Say(L["Give the guide a name."], "warning")
		root.Name:SetFocus()
		return
	end
	local lo, hi = tonumber(root.Min:GetText()), tonumber(root.Max:GetText())
	local header = {
		id = handle .. "/" .. slug(title), title = title, faction = form.faction,
		races = UI.Copy(form.races), classes = UI.Copy(form.classes), minLevel = lo, maxLevel = hi or lo,
		category = form.category, zone = root.Zone:GetText() ~= "" and root.Zone:GetText() or nil,
		author = handle, version = 1, license = "CC-BY-4.0", credits = {},
	}
	local doc = S.Model.New(header)
	if not doc then
		UI.Say(L["The guide could not be created."], "danger")
		return
	end
	if doc.header and doc.header.id then S.Model.SetCurrent(doc.header.id) end
	if form.template then
		for _, t in ipairs(TEMPLATES[form.category] or {}) do S.Model.AddStep(L[t]) end
	end
	if #S.Model.Current().steps > 0 then S.Model.Select(1, nil) end
	root.Name:SetText("")
	UI.ShowHome(false)
	UI.Say(format(L["Started %s."], header.id), "success")
end

---------------------------------------------------------------------------
-- Building
---------------------------------------------------------------------------

local function label(parent, text)
	local fs = W.Text(parent, "small", "textMuted")
	fs:SetText(text)
	return fs
end

local function listRow(parent)
	local row = UI.Row(parent, 46)
	row.Title = W.Text(row, "body", "text")
	row.Title:SetPoint("TOPLEFT", row, "TOPLEFT", 10, -7)
	row.Sub = W.Text(row, "small", "textMuted")
	row.Sub:SetPoint("TOPLEFT", row.Title, "BOTTOMLEFT", 0, -4)
	row.B1 = W.Button(row, "", nil, { height = 24 })
	row.B1:SetPoint("RIGHT", row, "RIGHT", -8, 0)
	row.B2 = W.Button(row, "", nil, { ghost = true, height = 24 })
	row.B2:SetPoint("RIGHT", row.B1, "LEFT", -6, 0)
	row.B2.psSetText = W.SetButtonText
	row.Title:SetPoint("RIGHT", row.B2, "LEFT", -8, 0)
	row.Sub:SetPoint("RIGHT", row.B2, "LEFT", -8, 0)
	return row
end

local function setButton(b, text, fn, confirm)
	if not text then b:Hide() return end
	b:Show()
	W.SetButtonText(b, text)
	if confirm then
		W.Confirm(b, text, fn)
	else
		b:SetScript("OnClick", fn)
	end
end

function Home.Build(parent)
	root = parent
	scroll = W.Scroll(parent)
	scroll:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -2)
	scroll:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -2, 2)
	c = scroll.Child

	root.Emblem = W.Tex(c, "ARTWORK", "emblem", "accent")
	root.Emblem:SetSize(36, 36)
	root.Emblem:SetPoint("TOPLEFT", c, "TOPLEFT", 28, -22)
	root.Hero = W.Text(c, "hero", "text")
	root.Hero:SetPoint("LEFT", root.Emblem, "RIGHT", 12, 0)
	root.Hero:SetText(L["Polestar Studio"])
	root.Intro = UI.Text(c, "note", "textDim", true)
	root.Intro:SetPoint("TOPLEFT", c, "TOPLEFT", 32, -70)
	root.Intro:SetPoint("RIGHT", c, "RIGHT", -32, 0)
	root.Intro:SetText(L["Build a guide as you play it: every tool adds one goal from what the game shows you (your target, your position, the quest log), and Polestar plays the draft while you edit it."])
	root.TourBtn = W.Button(c, L["Take the 60-second tour"], function() UI.Tour() end, { ghost = true, icon = Theme.Media("star") })
	root.TourBtn:SetPoint("TOPRIGHT", c, "TOPRIGHT", -24, -26)

	root.HandleLabel = label(c, L["Your author handle (starts your guide ids, like yendi/elwynn)"])
	root.HandleLabel:SetPoint("TOPLEFT", c, "TOPLEFT", 32, -118)
	root.Handle = UI.Edit(c, { placeholder = L["handle"], onCommit = function(text)
		UI.SetHandle(text)
		UI.SetEdit(root.Handle, UI.Handle() or "")
		Home.Refresh()
	end })
	root.Handle:SetPoint("TOPLEFT", root.HandleLabel, "BOTTOMLEFT", 0, -6)
	root.Handle:SetWidth(220)
	-- First run: the handle comes first; New and Open show once it is set.
	root.HandleFirst = UI.Text(c, "note", "accent", true)
	root.HandleFirst:SetPoint("LEFT", root.Handle, "RIGHT", 16, 0)
	root.HandleFirst:SetPoint("RIGHT", c, "RIGHT", -32, 0)
	root.HandleFirst:SetText(L["First, pick your author handle and press Enter: every guide you start or fork is filed under it. Then start a guide or open one."])

	-- Start a guide (left column).
	local left = CreateFrame("Frame", nil, c)
	left:SetPoint("TOPLEFT", c, "TOPLEFT", 24, -180)
	left:SetSize(440, 420)
	Theme.Skin(left, "tile")
	root.Left = left
	root.NewHead = W.SectionHeader(left)
	root.NewHead:SetPoint("TOPLEFT", left, "TOPLEFT", 16, -6)
	root.NewHead:SetPoint("TOPRIGHT", left, "TOPRIGHT", -16, -6)
	W.SetSection(root.NewHead, L["Start a guide"])
	local y = -56
	local function at(region, dy, x)
		region:SetPoint("TOPLEFT", left, "TOPLEFT", x or 16, y)
		y = y - (dy or 0)
	end
	at(label(left, L["Name"]), 18)
	root.Name = UI.Edit(left, { placeholder = L["Elwynn Forest 1-10"] })
	at(root.Name, 36)
	root.Name:SetPoint("RIGHT", left, "RIGHT", -16, 0)
	at(label(left, L["Type and template"]), 18)
	root.Type = W.Button(left, "", function(self)
		local items = {}
		for _, v in ipairs(CATEGORIES) do
			items[#items + 1] = { text = L[v], checked = form.category == v, onClick = function() form.category = v; Home.Refresh() end }
		end
		UI.Menu(self, items)
	end, { height = 26, width = 190 })
	at(root.Type, 0)
	root.Template = W.Button(left, "", function()
		form.template = not form.template
		Home.Refresh()
	end, { height = 26, width = 200, ghost = true })
	root.Template:SetPoint("LEFT", root.Type, "RIGHT", 8, 0)
	y = y - 36
	at(label(left, L["Faction"]), 0)
	label(left, L["Levels"]):SetPoint("TOPLEFT", left, "TOPLEFT", 224, y)
	y = y - 18
	root.Faction = W.Button(left, "", function(self)
		local items = {}
		for _, v in ipairs({ "Alliance", "Horde", "Both" }) do
			items[#items + 1] = { text = L[v], checked = form.faction == v, onClick = function() form.faction = v; Home.Refresh() end }
		end
		UI.Menu(self, items)
	end, { height = 26, width = 190 })
	at(root.Faction, 0)
	root.Min = UI.Edit(left, { numeric = true, placeholder = L["from"] })
	root.Min:SetWidth(60)
	root.Min:SetPoint("TOPLEFT", left, "TOPLEFT", 224, y)
	root.Max = UI.Edit(left, { numeric = true, placeholder = L["to"] })
	root.Max:SetWidth(60)
	root.Max:SetPoint("LEFT", root.Min, "RIGHT", 8, 0)
	y = y - 36
	at(label(left, L["Races and classes (none: everyone)"]), 18)
	root.Races = W.Button(left, "", function(self)
		local items = {}
		for _, v in ipairs(UI.RACES) do
			local on = false
			for _, r in ipairs(form.races) do if r == v then on = true end end
			items[#items + 1] = { text = L[v], checked = on, onClick = function()
				local t = UI.ToggleOnly({ races = form.races }, "races", v)
				form.races = t and t.races or {}
				Home.Refresh()
			end }
		end
		UI.Menu(self, items)
	end, { height = 26, width = 190 })
	at(root.Races, 0)
	root.Classes = W.Button(left, "", function(self)
		local items = {}
		for _, v in ipairs(UI.CLASSES) do
			local on = false
			for _, r in ipairs(form.classes) do if r == v then on = true end end
			items[#items + 1] = { text = L[v], checked = on, onClick = function()
				local t = UI.ToggleOnly({ classes = form.classes }, "classes", v)
				form.classes = t and t.classes or {}
				Home.Refresh()
			end }
		end
		UI.Menu(self, items)
	end, { height = 26, width = 200 })
	root.Classes:SetPoint("LEFT", root.Races, "RIGHT", 8, 0)
	y = y - 36
	at(label(left, L["Zone (optional)"]), 18)
	root.Zone = UI.Edit(left, { placeholder = L["Elwynn Forest"] })
	at(root.Zone, 46)
	root.Zone:SetPoint("RIGHT", left, "RIGHT", -16, 0)
	root.Here = W.Button(left, L["Use where I stand"], function()
		local here = UI.Here()
		local zone = here and (here.zoneName or UI.MapName(here.map))
		if zone then root.Zone:SetText(zone) end
		local lvl = UnitLevel and UnitLevel("player")
		if lvl and root.Min:GetText() == "" then root.Min:SetText(tostring(lvl)) end
		local fac = UnitFactionGroup and UnitFactionGroup("player")
		if fac and form.faction == "Both" then form.faction = fac; Home.Refresh() end
	end, { ghost = true, height = 26 })
	at(root.Here, 0)
	root.Create = W.Button(left, L["Start the guide"], create, { primary = true })
	root.Create:SetPoint("BOTTOMRIGHT", left, "BOTTOMRIGHT", -16, 16)

	-- Open (right column).
	local right = CreateFrame("Frame", nil, c)
	right:SetPoint("TOPLEFT", left, "TOPRIGHT", 16, 0)
	right:SetPoint("RIGHT", c, "RIGHT", -24, 0)
	right:SetHeight(420)
	root.Right = right
	root.DraftHead = W.SectionHeader(right)
	root.DraftHead:SetPoint("TOPLEFT", right, "TOPLEFT", 0, -6)
	root.DraftHead:SetPoint("TOPRIGHT", right, "TOPRIGHT", 0, -6)
	root.DraftEmpty = UI.Text(right, "note", "textMuted", true)
	root.DraftEmpty:SetText(L["No drafts yet."])
	draftRows = UI.Pool(right, listRow)
	root.ImportHead = W.SectionHeader(right)
	root.ImportEmpty = UI.Text(right, "note", "textMuted", true)
	root.ImportEmpty:SetText(L["No imported guides. Guides imported from a Studio string (v2) can be opened and forked here."])
	importRows = UI.Pool(right, listRow)
	root.PasteHead = W.SectionHeader(right)
	W.SetSection(root.PasteHead, L["Paste a string"])
	root.Paste = UI.Edit(right, { placeholder = L["Paste a Polestar string here (Ctrl+V)"], onChange = function(text)
		pasted = nil
		local trimmed = (text or ""):gsub("%s+", "")
		if trimmed ~= "" then
			local I = P.Import
			if I and I.Decode then
				local entry, reason = I.Decode(trimmed)
				pasted = { entry = entry, reason = reason }
			elseif S.Import then
				local doc, reason = S.Import(trimmed)
				pasted = { doc = doc, reason = reason }
			end
		end
		root.Paste:SetText("")
		Home.Refresh()
	end })
	root.PasteInfo = UI.Text(right, "note", "textDim", true)
	root.PasteOpen = W.Button(right, L["Open"], function()
		if pasted and pasted.entry then Home.OpenPayload(pasted.entry, false)
		elseif pasted and pasted.doc then S.Model.SetCurrent(pasted.doc.header.id); UI.ShowHome(false) end
		pasted = nil
	end, { primary = true, height = 24 })
	root.PasteFork = W.Button(right, L["Fork"], function()
		if pasted and pasted.entry then Home.OpenPayload(pasted.entry, true) end
		pasted = nil
	end, { height = 24 })
end

local function layoutList(rows, list, top, empty, fill)
	local y = top
	for k, item in ipairs(list) do
		local row = rows:Get(k)
		row:ClearAllPoints()
		row:SetPoint("TOPLEFT", root.Right, "TOPLEFT", 0, -y)
		row:SetPoint("TOPRIGHT", root.Right, "TOPRIGHT", 0, -y)
		fill(row, item)
		y = y + 46
	end
	rows:HideFrom(#list + 1)
	empty:ClearAllPoints()
	empty:SetPoint("TOPLEFT", root.Right, "TOPLEFT", 4, -y - 4)
	empty:SetPoint("RIGHT", root.Right, "RIGHT", -4, 0)
	empty:SetShown(#list == 0)
	if #list == 0 then y = y + 34 end
	return y
end

function Home.Refresh()
	if not root then return end
	c:SetWidth(scroll:GetWidth())
	UI.SetEdit(root.Handle, UI.Handle() or "")
	local ready = UI.Handle() ~= nil
	root.HandleFirst:SetShown(not ready)
	root.Left:SetShown(ready)
	root.Right:SetShown(ready)
	if not ready then
		W.SetScrollContent(scroll, 200)
		return
	end
	W.SetButtonText(root.Type, format(L["Type: %s"], L[form.category]))
	W.SetButtonText(root.Template, form.template and format(L["Template: %d steps"], #(TEMPLATES[form.category] or {})) or L["Template: empty"])
	W.SetButtonText(root.Faction, L[form.faction])
	W.SetButtonText(root.Races, #form.races > 0 and concat(form.races, ", ") or L["All races"])
	W.SetButtonText(root.Classes, #form.classes > 0 and concat(form.classes, ", ") or L["All classes"])

	local drafts = S.Model.List and S.Model.List() or {}
	W.SetSection(root.DraftHead, L["My drafts"], #drafts)
	local y = layoutList(draftRows, drafts, 46, root.DraftEmpty, function(row, d)
		row.Title:SetText(d.title or d.id)
		local when = d.updated and date and date("%Y-%m-%d %H:%M", d.updated) or ""
		row.Sub:SetText(concat({ tostring(d.id), format(L["%d steps"], d.steps or 0), when }, DOT))
		setButton(row.B1, L["Open"], function()
			S.Model.SetCurrent(d.id)
			UI.ShowHome(false)
		end)
		setButton(row.B2, L["Delete"], function()
			S.Model.Delete(d.id)
			Home.Refresh()
		end, true)
	end)

	local imports = {}
	local I = P.Import
	if I and I.List then
		local ok, list = pcall(I.List)
		if ok and type(list) == "table" then imports = list end
	end
	root.ImportHead:ClearAllPoints()
	root.ImportHead:SetPoint("TOPLEFT", root.Right, "TOPLEFT", 0, -y - 6)
	root.ImportHead:SetPoint("TOPRIGHT", root.Right, "TOPRIGHT", 0, -y - 6)
	W.SetSection(root.ImportHead, L["Imported guides"], #imports)
	y = layoutList(importRows, imports, y + 52, root.ImportEmpty, function(row, g)
		local entry = importEntry(g.id)
		local hasSource = type(entry) == "table" and type(entry.source) == "table"
		row.Title:SetText(g.title or g.id)
		local sub = { g.author and format(L["by %s"], g.author) or g.id, g.version and ("v" .. g.version) or nil, g.license }
		local parts = {}
		for _, s in pairs(sub) do parts[#parts + 1] = s end
		if not hasSource then parts[#parts + 1] = L["Read only: ask the author for a Studio string"] end
		row.Sub:SetText(concat(parts, DOT))
		W.Color(row.Sub, hasSource and "textMuted" or "warning")
		if hasSource then
			setButton(row.B1, L["Fork"], function() Home.OpenPayload(entry, true) end)
			if isND(entry.license) then
				row.B1:SetScript("OnClick", function() Home.OpenPayload(entry, true) end)
				row.B1.psTip = L["This licence allows no derivatives."]
			end
			setButton(row.B2, L["Open"], function() Home.OpenPayload(entry, false) end)
		else
			setButton(row.B1, nil)
			setButton(row.B2, nil)
		end
	end)

	root.PasteHead:ClearAllPoints()
	root.PasteHead:SetPoint("TOPLEFT", root.Right, "TOPLEFT", 0, -y - 6)
	root.PasteHead:SetPoint("TOPRIGHT", root.Right, "TOPRIGHT", 0, -y - 6)
	root.Paste:ClearAllPoints()
	root.Paste:SetPoint("TOPLEFT", root.Right, "TOPLEFT", 0, -y - 52)
	root.Paste:SetPoint("TOPRIGHT", root.Right, "TOPRIGHT", 0, -y - 52)
	root.PasteInfo:ClearAllPoints()
	root.PasteInfo:SetPoint("TOPLEFT", root.Paste, "BOTTOMLEFT", 0, -8)
	root.PasteInfo:SetPoint("RIGHT", root.Right, "RIGHT", 0, 0)
	local info, canOpen, canFork = nil, false, false
	if pasted then
		local e = pasted.entry
		if e and type(e.guide) == "table" then
			local g = e.guide
			info = concat({ tostring(g.title or g.id), g.author and format(L["by %s"], g.author) or "", format(L["%d steps"], #(g.steps or {})), tostring(e.license or "") }, DOT)
			if type(e.source) ~= "table" then
				info = info .. "\n" .. L["Read only: ask the author for a Studio string."]
			else
				canOpen, canFork = true, not isND(e.license)
				if not canFork then info = info .. "\n" .. L["This licence allows no derivatives: open only, no fork."] end
			end
		elseif pasted.doc then
			info, canOpen = tostring(pasted.doc.header.title or pasted.doc.header.id), true
		else
			info = tostring(pasted.reason or L["This is not a Polestar string."])
		end
	end
	root.PasteInfo:SetText(info or L["A string from Export (yours or another author's) opens here; Fork makes it yours with credit kept."])
	W.Color(root.PasteInfo, (pasted and not (canOpen)) and "warning" or "textDim")
	root.PasteOpen:SetShown(canOpen)
	root.PasteFork:SetShown(canOpen)
	if canFork then root.PasteFork:Enable() else root.PasteFork:Disable() end
	root.PasteOpen:ClearAllPoints()
	root.PasteOpen:SetPoint("TOPLEFT", root.PasteInfo, "BOTTOMLEFT", 0, -10)
	root.PasteFork:ClearAllPoints()
	root.PasteFork:SetPoint("LEFT", root.PasteOpen, "RIGHT", 8, 0)
	local rightH = y + 52 + 30 + 8 + 40 + 40
	root.Right:SetHeight(rightH)
	W.SetScrollContent(scroll, max(180 + 420, 180 + rightH) + 30)
end

---------------------------------------------------------------------------
-- The tour: a callout pointing at each part in turn.
---------------------------------------------------------------------------

local tour, tourIndex

local STOPS = {
	{ L["New / Open: start a guide or open one. Your handle starts every guide id."], function(p) return p.HomeButton end },
	{ L["The toolbar: each glyph adds one goal to the selected step, from your target, position or quest log. Every tool has a key binding."], function(p) return p.Strip end },
	{ L["The toolkit for this guide's type: dungeons, professions, collectibles, chains, farms and reputation each have their own tools."], function(p) return p.Strip.Kit end },
	{ L["Live sync plays the draft in Polestar as you edit; Play starts it from the selected step."], function(p) return p.Strip.Sync end },
	{ L["Your steps. Drag to reorder, Ctrl-click to select several, right-click for more."], function(p) return p.Outline end },
	{ L["The selected step: title, tip, who the step is for, and its goals. Each goal shows its place and quest objective."], function(p) return p.Editor end },
	{ L["The tabs: Details of what you selected, then the target card, quest log, position, nearby, checks, session and Export."], function(p) return p.Dock end },
	{ L["The status line: problems found in game (click to see them) and what was saved."], function(p) return p.Status end },
}

local function showStop()
	local p = UI.Panel()
	local stop = STOPS[tourIndex]
	if not stop then
		tour:Hide()
		tour.Ring:Hide()
		return
	end
	local target = stop[2](p)
	if not (target and target:IsVisible()) then
		tourIndex = tourIndex + 1
		return showStop()
	end
	tour.Text:SetText(stop[1])
	tour.Count:SetText(format("%d / %d", tourIndex, #STOPS))
	tour:SetHeight(max(110, floor(tour.Text:GetStringHeight() + 74)))
	tour:ClearAllPoints()
	local cx = target:GetCenter()
	local ux = UIParent:GetWidth() / 2
	if cx and cx > ux then
		tour:SetPoint("TOPRIGHT", target, "BOTTOMLEFT", -4, -4)
	else
		tour:SetPoint("TOPLEFT", target, "BOTTOMRIGHT", 4, -4)
	end
	tour.Ring:ClearAllPoints()
	tour.Ring:SetPoint("TOPLEFT", target, "TOPLEFT", -3, 3)
	tour.Ring:SetPoint("BOTTOMRIGHT", target, "BOTTOMRIGHT", 3, -3)
	tour.Ring:Show()
	tour:Show()
end

function UI.Tour()
	local p = UI.Panel()
	UI.Show()
	if S.Model.Current() then UI.ShowHome(false) end
	if not tour then
		tour = CreateFrame("Frame", nil, UIParent)
		tour:SetFrameStrata("TOOLTIP")
		tour:SetWidth(300)
		Theme.Skin(tour, "panel")
		tour.Count = W.Text(tour, "caption", "accent")
		tour.Count:SetPoint("TOPLEFT", tour, "TOPLEFT", 14, -12)
		tour.Text = UI.Text(tour, "note", "text", true)
		tour.Text:SetPoint("TOPLEFT", tour, "TOPLEFT", 14, -32)
		tour.Text:SetPoint("TOPRIGHT", tour, "TOPRIGHT", -14, -32)
		tour.Next = W.Button(tour, L["Next"], function()
			tourIndex = tourIndex + 1
			showStop()
		end, { primary = true, height = 24 })
		tour.Next:SetPoint("BOTTOMRIGHT", tour, "BOTTOMRIGHT", -12, 10)
		tour.Skip = W.Button(tour, L["Close"], function()
			tour:Hide()
			tour.Ring:Hide()
		end, { ghost = true, height = 24 })
		tour.Skip:SetPoint("RIGHT", tour.Next, "LEFT", -6, 0)
		tour.Ring = CreateFrame("Frame", nil, UIParent)
		tour.Ring:SetFrameStrata("TOOLTIP")
		W.Painter(tour.Ring, function(r)
			local cr, cg, cb = Theme.Accent()
			Theme.Border(r, cr, cg, cb, 1, nil, 2)
		end)
		p:HookScript("OnHide", function() tour:Hide(); tour.Ring:Hide() end)
	end
	tourIndex = 1
	showStop()
end
