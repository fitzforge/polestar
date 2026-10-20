-- The Import page, a section of the hub at the rail's foot above Options
-- (UI.RegisterSection with `foot`; `/polestar import` and SHOW_IMPORT open
-- it). It sets the two ways to bring someone else's guides into Polestar
-- side by side (an import string for one small guide, a community addon for
-- a route or a set), then:
--
--   Paste a string: a box; what is pasted is read at once (Core/Import.lua,
--     Import.Preview) and shown before anything is saved, "Title · by
--     Author · 14 steps · levels 30–40 · Alliance and Horde · CC-BY-4.0",
--     with Import (Update when an older version is imported) and Cancel, or
--     why the string is refused. Nothing is saved until Import.
--   Your imported guides: title, author, version and licence, Delete on each
--     (a second click within three seconds confirms).
--   Want more than one guide?: community addons in three steps, and a link to
--     docs/GUIDE_PACKS.md.

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local SH = W.SHELL
local format, floor, max, min, ipairs = string.format, math.floor, math.max, math.min, ipairs

local IV = {}
UI.Import = IV

local DOT = "  \194\183  "
local KEY = "Import"

local root, scroll, content, hub
local parts = {}
local rows = {}
-- What the page shows now: the preview (Import.Preview's info) or why the
-- pasted text was refused, and the line left by the last import.
local preview, refusal, done

local function Import() return ns.Import end

local function mainWidth()
	local w = hub and (hub:GetWidth() - (hub.psRail or 0) - (hub.psSidebar or SH.sidebar) - 2) or 0
	if w <= 0 then w = 878 end
	return w - SH.pad * 2
end

local function text(parent, role, color)
	local fs = W.Text(parent, role, color)
	fs:SetWordWrap(true)
	fs:SetJustifyH("LEFT")
	fs:SetJustifyV("TOP")
	return fs
end

local function oneLine(fs)
	fs:SetWordWrap(false)
	fs:SetJustifyH("LEFT")
	return fs
end

-- docs/GUIDE_PACKS.md online, beside the handbook ns.DocsURL names; nil
-- without the TOC's X-Website (as the Community guides page).
local function guidePacksURL()
	local url = ns.DocsURL and ns.DocsURL()
	return url and (url:gsub("/PACKS%.md$", "/GUIDE_PACKS.md")) or nil
end

local function count(n, one, many) return n == 1 and one or many:format(n) end

-- "Title · by Author · 14 steps · levels 30–40 · Alliance and Horde · CC-BY-4.0"
function IV.PreviewText(info)
	local out = { info.title }
	if info.author then out[#out + 1] = format(L["by %s"], info.author) end
	out[#out + 1] = count(info.steps, L["1 step"], L["%d steps"])
	if info.minLevel and info.maxLevel then
		out[#out + 1] = info.minLevel == info.maxLevel and format(L["level %d"], info.minLevel) or format(L["levels %d\226\128\147%d"], info.minLevel, info.maxLevel)
	end
	out[#out + 1] = info.faction and ns.FactionName(info.faction) or L["Alliance and Horde"]
	out[#out + 1] = info.license
	return table.concat(out, DOT)
end

-- What the pasted guide is to the player: new, a newer version of one
-- imported, the same, or older. -> the line under the preview, or nil
local function stateNote(info)
	if info.state == "update" then
		local note = format(L["You have version %s of this guide. Update replaces it and keeps your progress where its steps are unchanged."], tostring(info.have))
		if info.authorChanged then note = note .. " " .. L["The author differs from the stored guide's."] end
		if info.licenseChanged then note = note .. " " .. L["The licence differs from the stored guide's."] end
		return note
	elseif info.state == "same" then
		return L["This guide is already imported, at this version."]
	elseif info.state == "older" then
		return format(L["You have a newer version (%s) of this guide imported."], tostring(info.have))
	end
	return nil
end

local relayout

function IV.Check(value)
	done = nil
	local I = Import()
	local trimmed = value and value:gsub("%s+", "") or ""
	if not I or trimmed == "" then
		preview, refusal = nil, nil
	else
		preview, refusal = I.Preview(value)
	end
	relayout()
end

function IV.Clear()
	preview, refusal = nil, nil
	if parts.Box then parts.Box:SetText("") end
	relayout()
end

-- Import or Update what the preview shows.
function IV.Apply()
	local I = Import()
	if not (I and preview and (preview.state == "new" or preview.state == "update")) then return end
	local info = preview
	local ok, why = I.Save(info.entry)
	if ok then
		done = format(info.state == "update" and L["Updated %s."] or L["Imported %s. Find it in the guide menu under Community guides, Imported."], info.title)
		preview, refusal = nil, nil
		if parts.Box then parts.Box:SetText("") end
	else
		preview, refusal = nil, why
	end
	relayout()
end

function IV.Delete(id)
	local I = Import()
	if I then I.Delete(id) end
	relayout()
end

---------------------------------------------------------------------------
-- Building
---------------------------------------------------------------------------

-- An edit box lays out its whole text, which freezes the game for a string of
-- hundreds of kilobytes. The box holds little; a paste's characters come one
-- by one in the same frame (OnChar) and are joined on the next.
local PASTE_BOX_BYTES = 2500
local PASTE_MIN = 20

local function pasteBox(parent)
	local e = CreateFrame("EditBox", nil, parent)
	e:SetAutoFocus(false)
	e:SetMaxLetters(0)
	e:SetMaxBytes(PASTE_BOX_BYTES)
	local parts, count, at = {}, 0, nil
	e:SetScript("OnChar", function(self, c)
		local now = GetTime()
		if now ~= at then
			at, parts, count = now, {}, 0
			self:SetScript("OnUpdate", function(box)
				box:SetScript("OnUpdate", nil)
				if count < PASTE_MIN then
					IV.Check(box:GetText())
					return
				end
				local pasted = table.concat(parts, "", 1, count)
				parts, count = {}, 0
				box:SetText(format("%s\226\128\166 (%d KB)", pasted:gsub("%s", ""):sub(1, 40), math.ceil(#pasted / 1024)))
				box:ClearFocus()
				IV.Check(pasted)
			end)
		end
		count = count + 1
		parts[count] = c
	end)
	Theme.Font(e, "label")
	W.Color(e, "text")
	e:SetHeight(30)
	e:SetTextInsets(10, 10, 0, 0)
	Theme.Skin(e, "editbox")
	e.Hint = oneLine(W.Text(e, "label", "textMuted"))
	e.Hint:SetPoint("LEFT", e, "LEFT", 10, 0)
	e.Hint:SetPoint("RIGHT", e, "RIGHT", -10, 0)
	e.Hint:SetText(L["Paste an import string here (Ctrl+V)"])
	e:SetScript("OnEditFocusGained", function(self) Theme.SetFocused(self, true) end)
	e:SetScript("OnEditFocusLost", function(self) Theme.SetFocused(self, false) end)
	e:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	e:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
		IV.Apply()
	end)
	e:SetScript("OnTextChanged", function(self, userInput)
		self.Hint:SetShown(self:GetText() == "")
		if userInput and at ~= GetTime() then IV.Check(self:GetText()) end
	end)
	return e
end

local function newRow(parent)
	local row = CreateFrame("Frame", nil, parent)
	row.Rule = W.Divider(row, false, 0.6)
	row.Rule:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 0)
	row.Rule:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
	row.Title = oneLine(W.Text(row, "body", "text"))
	row.Title:SetPoint("TOPLEFT", row, "TOPLEFT", 12, -12)
	row.Credits = oneLine(W.Text(row, "small", "textDim"))
	row.Credits:SetPoint("TOPLEFT", row, "TOPLEFT", 12, -34)
	row.Problem = text(row, "small", "warning")
	row.Problem:SetPoint("TOPLEFT", row, "TOPLEFT", 12, -54)
	row.Delete = W.Button(row, L["Delete"], nil, { ghost = true, height = 24 })
	row.Delete.psSetText = W.SetButtonText
	W.Confirm(row.Delete, L["Delete"], function() if row.psId then IV.Delete(row.psId) end end)
	row.Delete:SetPoint("TOPRIGHT", row, "TOPRIGHT", -12, -16)
	return row
end

function IV.Build(parent, shell)
	if root then return root end
	hub = shell
	root = CreateFrame("Frame", nil, parent)
	root:SetAllPoints(parent)
	scroll = W.Scroll(root)
	scroll:SetPoint("TOPLEFT", root, "TOPLEFT", 0, -4)
	scroll:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", 0, 8)
	content = scroll.Child

	parts.Intro = text(content, "note", "textDim")
	parts.Intro:SetText(L["Two ways to bring someone else's guides into Polestar. Pick the one that fits."])
	-- The two ways, side by side.
	parts.Ways = {}
	local ways = {
		{ L["Import string"], {
			L["One small guide: a quest chain, an item, a mount, an errand."],
			L["Its author shares it as text, anywhere. Paste it below."],
			L["Updates: paste the newer string, then Update."],
			(L["One guide of up to %d steps."]):format(ns.Import and ns.Import.LIMITS.steps or 60),
		} },
		{ L["Community addon"], {
			L["A whole route or a set of guides: a leveling route, every profession."],
			L["Install it like any addon, then restart the game."],
			L["Updates: your addon app updates it."],
			L["No size limit."],
		} },
	}
	for i, way in ipairs(ways) do
		local head = oneLine(W.Text(content, "label", "text"))
		head:SetText(way[1])
		local body = text(content, "note", "textDim")
		body:SetSpacing(3)
		local lines = {}
		for j, l in ipairs(way[2]) do lines[j] = "\226\128\162 " .. l end
		body:SetText(table.concat(lines, "\n"))
		parts.Ways[i] = { head = head, body = body }
	end

	parts.PasteH = W.SectionHeader(content)
	W.SetSection(parts.PasteH, L["Paste a string"])
	parts.Box = pasteBox(content)
	parts.Preview = text(content, "body", "text")
	parts.Note = text(content, "note", "textDim")
	parts.Refusal = text(content, "note", "warning")
	parts.Done = text(content, "note", "success")
	parts.Apply = W.Button(content, L["Import"], function() IV.Apply() end, { primary = true, height = 28 })
	parts.Cancel = W.Button(content, L["Cancel"], function() IV.Clear() end, { height = 28 })

	parts.ListH = W.SectionHeader(content)
	parts.None = text(content, "note", "textMuted")
	parts.None:SetText(L["No imported guides yet."])

	parts.MoreH = W.SectionHeader(content)
	W.SetSection(parts.MoreH, L["Want more than one guide?"])
	parts.More = text(content, "note", "textDim")
	parts.More:SetSpacing(3)
	parts.More:SetText(table.concat({
		L["A set of guides, or one too big for a string, comes as a community addon:"],
		"1. " .. L["Get it from wherever its author publishes it."],
		"2. " .. L["Install it like any addon, then restart the game."],
		"3. " .. L["Its guides appear in the guide menu under Community guides, with the author's name. Options, Community guides turns it on or off."],
	}, "\n"))
	parts.DocsLabel = oneLine(W.Text(content, "note", "text"))
	parts.Docs = W.Link(content, "", function()
		local url = guidePacksURL()
		if url then UI.ShowCopy(L["Community guides, explained"], url) end
	end, { role = "note" })
	parts.Docs.Label:SetWordWrap(false)
	return root
end

---------------------------------------------------------------------------
-- Layout
---------------------------------------------------------------------------

local function place(region, x, y)
	region:ClearAllPoints()
	region:SetPoint("TOPLEFT", content, "TOPLEFT", x, -y)
end

local function block(fs, s, width, x, y)
	fs:SetShown(s ~= nil)
	if not s then return y end
	fs:SetText(s)
	fs:SetWidth(width)
	place(fs, x, y)
	return y + fs:GetStringHeight() + 10
end

local function layout()
	if not root then return 0 end
	local width = mainWidth()
	local x = SH.pad
	local y = 8
	content:SetWidth(width + SH.pad * 2)
	y = block(parts.Intro, parts.Intro:GetText(), width, x, y) + 4

	-- The two ways in two columns.
	local gap = 24
	local colW = floor((width - gap) / 2)
	local tallest = 0
	for i, way in ipairs(parts.Ways) do
		local cx = x + (i - 1) * (colW + gap)
		way.head:SetWidth(colW)
		place(way.head, cx, y)
		way.body:SetWidth(colW)
		place(way.body, cx, y + 22)
		tallest = max(tallest, 22 + way.body:GetStringHeight())
	end
	y = y + tallest + 12

	place(parts.PasteH, x, y)
	parts.PasteH:SetWidth(width)
	y = y + 44 + 4
	parts.Box:SetWidth(width)
	place(parts.Box, x, y)
	y = y + 30 + 12

	local shown = preview and IV.PreviewText(preview) or nil
	y = block(parts.Preview, shown, width, x, y)
	y = block(parts.Note, preview and stateNote(preview) or nil, width, x, y)
	y = block(parts.Refusal, refusal, width, x, y)
	y = block(parts.Done, done, width, x, y)
	local actionable = preview and (preview.state == "new" or preview.state == "update")
	parts.Apply:SetShown(actionable or false)
	parts.Cancel:SetShown(preview ~= nil or refusal ~= nil)
	if actionable then W.SetButtonText(parts.Apply, preview.state == "update" and L["Update"] or L["Import"]) end
	if parts.Apply:IsShown() or parts.Cancel:IsShown() then
		local bx = x
		if parts.Apply:IsShown() then
			place(parts.Apply, bx, y)
			bx = bx + parts.Apply:GetWidth() + 8
		end
		place(parts.Cancel, bx, y)
		y = y + 28 + 12
	end
	y = y + 8

	-- Your imported guides.
	local I = Import()
	local list = I and I.List() or {}
	W.SetSection(parts.ListH, L["Your imported guides"], #list)
	parts.ListH:SetWidth(width)
	place(parts.ListH, x, y)
	y = y + 44
	parts.None:SetShown(#list == 0)
	if #list == 0 then
		y = block(parts.None, parts.None:GetText(), width, x, y) + 6
	end
	for i, item in ipairs(list) do
		local row = rows[i] or newRow(content)
		rows[i] = row
		row.psId = item.id
		row:SetWidth(width)
		row.Title:SetWidth(width - 24 - 100)
		row.Title:SetText(item.title)
		local credits = {}
		if item.author then credits[#credits + 1] = format(L["By %s"], item.author) end
		if item.version then credits[#credits + 1] = format(L["version %s"], tostring(item.version)) end
		if item.license then credits[#credits + 1] = item.license end
		row.Credits:SetWidth(width - 24 - 100)
		row.Credits:SetText(table.concat(credits, DOT))
		local h = 58
		row.Problem:SetShown(item.problem ~= nil)
		if item.problem then
			row.Problem:SetWidth(width - 24)
			row.Problem:SetText(item.problem)
			h = h + row.Problem:GetStringHeight() + 8
		end
		row:SetHeight(h)
		place(row, x, y)
		row:Show()
		y = y + h
	end
	for i = #list + 1, #rows do rows[i]:Hide() end
	y = y + 16

	-- Want more than one guide?
	parts.MoreH:SetWidth(width)
	place(parts.MoreH, x, y)
	y = y + 44 + 4
	y = block(parts.More, parts.More:GetText(), width, x, y) + 4
	local url = guidePacksURL()
	place(parts.DocsLabel, x, y + 3)
	if url then
		parts.DocsLabel:SetText(L["Read more:"])
		parts.DocsLabel:SetWidth(0)
		local lw = min(floor(width / 3), parts.DocsLabel:GetStringWidth() + 2)
		parts.DocsLabel:SetWidth(lw)
		parts.Docs.Label:SetWidth(0)
		W.SetLinkText(parts.Docs, (url:gsub("^%a+://", "")))
		place(parts.Docs, x + lw + 8, y)
		parts.Docs:Show()
	else
		parts.DocsLabel:SetText(L["Read more: docs/GUIDE_PACKS.md in Polestar's source"])
		parts.DocsLabel:SetWidth(width)
		parts.Docs:Hide()
	end
	return y + 24 + 24
end

function relayout()
	if not (root and root:IsVisible()) then return end
	local h = layout()
	W.SetScrollContent(scroll, h)
end

function IV.Render()
	if not root then return end
	if hub then W.ShellTitle(hub, L["Import"], L["Guides someone shared with you, as an import string or a community addon."]) end
	W.SetScrollContent(scroll, layout())
end

-- What the page shows, for the tests.
function IV.Shown()
	local list = {}
	for i, row in ipairs(rows) do
		if row:IsShown() then list[#list + 1] = { id = row.psId, title = row.Title:GetText(), credits = row.Credits:GetText(), problem = row.Problem:IsShown() and row.Problem:GetText() or nil } end
	end
	return {
		preview = parts.Preview and parts.Preview:IsShown() and parts.Preview:GetText() or nil,
		note = parts.Note and parts.Note:IsShown() and parts.Note:GetText() or nil,
		refusal = parts.Refusal and parts.Refusal:IsShown() and parts.Refusal:GetText() or nil,
		done = parts.Done and parts.Done:IsShown() and parts.Done:GetText() or nil,
		button = parts.Apply and parts.Apply:IsShown() and parts.Apply.Label:GetText() or nil,
		list = list,
	}
end
IV.parts = parts
IV.rows = rows

function IV.Show()
	if UI.ShowPicker then UI.ShowPicker() end
	local P = UI.Picker
	if P and P.ShowSection then P.ShowSection(KEY) end
end

ns.On("SHOW_IMPORT", IV.Show)
ns.On("PACKS_CHANGED", function() relayout() end)

if UI.RegisterSection then
	UI.RegisterSection({
		key = KEY, label = L["Import"], icon = "plus", order = 90, foot = true,
		build = IV.Build, render = IV.Render,
	})
end
