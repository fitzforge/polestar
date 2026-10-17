-- The Guide packs page of the options window (Options.lua registers it at
-- order 70; `/polestar packs` opens it): one row per pack the core found
-- (Guides.Packs: ours first, then by title) with its credits, its website
-- (a link opening the copy window), its source and its state: a switch while
-- it can be shown or hidden, otherwise why it is not running, and its
-- problems with a report to copy for the author. Below: where suggestions
-- come from (behavior.suggestFrom), what guide packs are, and a link to
-- read more (guidePacksURL).
--
-- While any pack has problems the page's navigation entry carries a dot
-- (P.HasProblems); nothing goes to chat.

local ADDON, ns = ...
local UI, W = ns.UI, ns.Widgets
local L = ns.L
local floor, max, min, ipairs, tostring = math.floor, math.max, math.min, ipairs, tostring

local SH = W.SHELL
local PAD = 12 -- a row's inner inset, as a settings row's
local SEP = "  \194\183  "
local LINE1 = 40 -- the title line

-- An address as a link's text: without its scheme, cut to maxW.
local function setLink(b, url, maxW)
	b.Label:SetWidth(0)
	W.SetLinkText(b, (url:gsub("^%a+://", "")))
	if b:GetWidth() > maxW then
		b.Label:SetWidth(maxW)
		b:SetWidth(maxW)
	end
end

local P = {}
UI.Packs = P

local function registry() return ns.Guides end

local function packs()
	local G = registry()
	return G and G.Packs and G.Packs() or {}
end

-- Does any listed pack have problems? (the navigation dot)
function P.HasProblems()
	local G = registry()
	return G and G.ProblemCount and G.ProblemCount() > 0 or false
end

-- Is any installed pack switched off on this page? (the empty states then
-- point here rather than to the AddOns list)
function P.AnySwitchedOff()
	for _, r in ipairs(packs()) do
		if r.status == "off" then return true end
	end
	return false
end

local function count(n, one, many)
	return n == 1 and one or many:format(n)
end

-- docs/GUIDE_PACKS.md online (what packs are, for players and authors): the
-- address ns.DocsURL gives for the pack handbook, on the page beside it. nil
-- without the TOC's X-Website.
local function guidePacksURL()
	local url = ns.DocsURL and ns.DocsURL()
	return url and (url:gsub("/PACKS%.md$", "/GUIDE_PACKS.md")) or nil
end

-- "Author · version · licence", from what the pack gives.
function P.Credits(r)
	local parts = {}
	for _, key in ipairs({ "author", "version", "license" }) do
		if type(r[key]) == "string" and r[key] ~= "" then parts[#parts + 1] = r[key] end
	end
	return table.concat(parts, SEP)
end

-- Why a pack that cannot be switched is not running; nil for one that can.
function P.StatusText(r)
	local s = r.status
	if s == "disabled" then return L["turned off in the AddOns list"] end
	if s == "not-loaded" then
		return r.reason and (L["not loaded: %s"]):format(r.reason) or L["not loaded"]
	end
	if s == "too-new" then
		return r.needs and (L["needs Polestar %s or newer"]):format(r.needs) or L["needs a newer Polestar"]
	end
	if s == "broken" then return L["broken: registered no guides"] end
	if s == "refused" then return (L["refused: %s"]):format(r.reason or "?") end
	return nil
end

local function switchable(r) return r.status == "on" or r.status == "off" end

-- The report a player copies for the pack's author: the pack, its version,
-- Polestar's, the client build, then every problem, one per line. A refused
-- pack's id and addon are kept as given, so they are escaped here.
function P.Report(r)
	local version, build = "?", "?"
	if GetBuildInfo then
		local v, b = GetBuildInfo()
		version, build = tostring(v or "?"), tostring(b or "?")
	end
	local esc = ns.EscapeText
	local lines = {
		(L["Pack: %s (%s)"]):format(esc(r.id), esc(r.addon or "?")),
		(L["Pack version: %s"]):format(r.version or "?"),
		(L["Polestar version: %s"]):format(tostring(ns.version or "dev")),
		(L["Client build: %s (%s)"]):format(version, build),
		L["Problems:"],
	}
	for _, p in ipairs(r.problems or {}) do
		local guide = p.guide and esc(p.guide)
		local where = guide and not tostring(p.message):find(guide, 1, true) and (guide .. ": ") or ""
		lines[#lines + 1] = "- " .. where .. tostring(p.message)
	end
	return table.concat(lines, "\n")
end

-- Polestar, then every pack suggestions can come from (Guides.SuggestSources:
-- on, with leveling guides).
function P.SourceChoices()
	local G = registry()
	local out = {}
	for _, id in ipairs(G and G.SuggestSources and G.SuggestSources() or { "guides" }) do
		if id == "guides" then
			out[#out + 1] = { value = id, text = L["Polestar"] }
		else
			local r = G.Pack(id)
			out[#out + 1] = { value = id, text = r and r.title or id }
		end
	end
	return out
end

---------------------------------------------------------------------------
-- A pack's row
---------------------------------------------------------------------------

-- Open problem lists and reports, by pack (id and addon: two addons may
-- claim one id).
local listed, reported = {}, {}
local function keyOf(r) return tostring(r.id) .. "\0" .. tostring(r.addon) end

local function oneLine(fs)
	fs:SetWordWrap(false)
	fs:SetJustifyH("LEFT")
	return fs
end

local relayout

local function newRow(view)
	local row = CreateFrame("Frame", nil, view)
	row.Rule = W.Divider(row, false, 0.6)
	row.Rule:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 0)
	row.Rule:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
	row.Title = oneLine(W.Text(row, "body", "text"))
	row.Credits = oneLine(W.Text(row, "small", "textDim"))
	row.Count = W.Text(row, "number", "textMuted")
	row.Count:SetJustifyH("RIGHT")
	row.Switch = W.Switch(row, function() return row.psRecord and row.psRecord.status == "on" end, function(on)
		local G = registry()
		if row.psRecord and G and G.SetPackShown then G.SetPackShown(row.psRecord.id, on) end
	end, L["Show this pack's guides"])
	row.Enable = W.Button(row, L["Enable and reload"], function()
		local r = row.psRecord
		if not (r and r.addon and C_AddOns and C_AddOns.EnableAddOn) then return end
		C_AddOns.EnableAddOn(r.addon)
		if ReloadUI then ReloadUI() end
	end, { height = 24 })
	-- The website: a link opening the copy window.
	row.Website = W.Link(row, "", function()
		local r = row.psRecord
		if r and r.website then UI.ShowCopy((L["%s website"]):format(r.title or ns.EscapeText(r.id)), r.website) end
	end)
	row.Website.Label:SetWordWrap(false)
	row.Source = W.Text(row, "note", "textDim")
	row.Source:SetWordWrap(true)
	row.Source:SetJustifyV("TOP")
	row.Status = W.Text(row, "small", "warning")
	row.Status:SetWordWrap(true)
	row.Status:SetJustifyH("LEFT")
	row.Problems = W.Chip(row)
	-- Show opens the problem list; Hide closes the list and the report.
	row.ShowList = W.Button(row, L["Show"], function()
		local k = keyOf(row.psRecord)
		if listed[k] or reported[k] then
			listed[k], reported[k] = nil, nil
		else
			listed[k] = true
		end
		relayout(view)
	end, { ghost = true, height = 24 })
	-- Copy report opens the report (it stays open) and selects its text.
	row.CopyReport = W.Button(row, L["Copy report"], function()
		reported[keyOf(row.psRecord)] = true
		relayout(view)
		row.Report:SetFocus()
		row.Report:HighlightText()
	end, { ghost = true, height = 24 })
	row.List = W.Text(row, "note", "textDim")
	row.List:SetWordWrap(true)
	row.List:SetSpacing(3)
	row.List:SetJustifyH("LEFT")
	row.List:SetJustifyV("TOP")
	row.Report = W.CopyBox(row, { lines = 6 })
	-- Measures the report wrapped at the box's text width (its insets are 10).
	row.ReportMeasure = W.Text(row, "label", "text")
	row.ReportMeasure:SetWordWrap(true)
	row.ReportMeasure:SetJustifyH("LEFT")
	row.ReportMeasure:Hide()
	-- Escape closes it.
	row.Report:HookScript("OnEscapePressed", function()
		if not row.psRecord then return end
		reported[keyOf(row.psRecord)] = nil
		relayout(view)
	end)
	return row
end

-- Lay a row out for record r at `width`. -> its height
local function layoutRow(row, r, width)
	row.psRecord = r
	row:SetWidth(width)
	local titleW = min(220, floor(width * 0.32))
	local col = PAD + titleW + 16
	local avail = width - col - PAD
	-- A refused pack keeps its id as given: escaped for display.
	row.Title:SetText(r.title or ns.EscapeText(r.id))
	row.Title:ClearAllPoints()
	row.Title:SetPoint("TOPLEFT", row, "TOPLEFT", PAD, -13)
	row.Title:SetWidth(titleW)

	-- Line 1, right: the switch and the guide count, or Enable and reload.
	local right
	row.Switch:Hide(); row.Enable:Hide(); row.Count:Hide()
	if switchable(r) then
		row.Switch:ClearAllPoints()
		row.Switch:SetPoint("TOPRIGHT", row, "TOPRIGHT", -PAD + 4, -8)
		row.Switch:Show()
		row.Switch:Refresh()
		row.Count:SetText(count(r.guideCount or 0, L["1 guide"], L["%d guides"]))
		row.Count:ClearAllPoints()
		row.Count:SetPoint("RIGHT", row.Switch, "LEFT", -10, 0)
		row.Count:Show()
		right = row.Count
	elseif r.status == "disabled" and r.addon then
		row.Enable:ClearAllPoints()
		row.Enable:SetPoint("TOPRIGHT", row, "TOPRIGHT", -PAD, -8)
		row.Enable:Show()
		right = row.Enable
	end
	row.Credits:SetText(P.Credits(r))
	row.Credits:ClearAllPoints()
	row.Credits:SetPoint("TOPLEFT", row, "TOPLEFT", col, -15)
	if right then
		row.Credits:SetPoint("RIGHT", right, "LEFT", -12, 0)
	else
		row.Credits:SetWidth(avail)
	end
	local y = LINE1

	-- The website link, then the source on its own line, wrapped.
	local site = type(r.website) == "string" and r.website ~= "" and r.website or nil
	local source = type(r.source) == "string" and r.source ~= "" and r.source or nil
	row.Website:SetShown(site ~= nil)
	row.Source:SetShown(source ~= nil)
	if site then
		setLink(row.Website, site, avail)
		row.Website:ClearAllPoints()
		row.Website:SetPoint("TOPLEFT", row, "TOPLEFT", col, -y)
		y = y + row.Website:GetHeight() + 6
	end
	if source then
		row.Source:SetText("\226\128\156" .. source .. "\226\128\157")
		row.Source:SetWidth(avail)
		row.Source:ClearAllPoints()
		row.Source:SetPoint("TOPLEFT", row, "TOPLEFT", col, -y)
		y = y + row.Source:GetStringHeight() + 10
	end

	-- Why it is not running.
	local status = P.StatusText(r)
	row.Status:SetShown(status ~= nil)
	if status then
		row.Status:SetText(status)
		row.Status:SetWidth(avail)
		row.Status:ClearAllPoints()
		row.Status:SetPoint("TOPLEFT", row, "TOPLEFT", col, -y)
		y = y + row.Status:GetStringHeight() + 10
	end

	-- Problems: the count, Show (the list) and Copy report.
	local n = #(r.problems or {})
	local k = keyOf(r)
	local shown = n > 0
	row.Problems:SetShown(shown)
	row.ShowList:SetShown(shown)
	row.CopyReport:SetShown(shown)
	row.List:SetShown(shown and listed[k] or false)
	row.Report:SetShown(shown and reported[k] or false)
	if shown then
		W.SetChip(row.Problems, count(n, L["1 problem"], L["%d problems"]), "warning")
		row.Problems:ClearAllPoints()
		row.Problems:SetPoint("TOPLEFT", row, "TOPLEFT", col, -(y + 2))
		W.SetButtonText(row.ShowList, (listed[k] or reported[k]) and L["Hide"] or L["Show"])
		row.ShowList:ClearAllPoints()
		row.ShowList:SetPoint("LEFT", row.Problems, "RIGHT", 8, 0)
		row.CopyReport:ClearAllPoints()
		row.CopyReport:SetPoint("LEFT", row.ShowList, "RIGHT", 4, 0)
		y = y + 32
		if listed[k] then
			local lines = {}
			for i, p in ipairs(r.problems) do lines[i] = "\226\128\162 " .. tostring(p.message) end
			row.List:SetText(table.concat(lines, "\n"))
			row.List:SetWidth(avail)
			row.List:ClearAllPoints()
			row.List:SetPoint("TOPLEFT", row, "TOPLEFT", col, -y)
			y = y + row.List:GetStringHeight() + 10
		end
		if reported[k] then
			local text = P.Report(r)
			local _, lines = text:gsub("\n", "")
			row.ReportMeasure:SetWidth(avail - 20)
			row.ReportMeasure:SetText(text)
			W.SetCopyText(row.Report, text)
			row.Report:SetWidth(avail)
			row.Report:SetHeight(max((lines + 1) * 16, row.ReportMeasure:GetStringHeight()) + 16)
			row.Report:ClearAllPoints()
			row.Report:SetPoint("TOPLEFT", row, "TOPLEFT", col, -y)
			y = y + row.Report:GetHeight() + 10
		end
	end
	local h = max(LINE1 + 4, y + 4)
	row:SetHeight(h)
	row:Show()
	return h
end

---------------------------------------------------------------------------
-- The page
---------------------------------------------------------------------------

local function bodyWidth()
	local win = UI.Options and UI.Options.frame
	return win and win.BodyWidth or 640
end

-- Lay the page out again where it stands (a list opened, a pack switched).
function relayout(view)
	if not view.Refresh then return end
	local h = view.Refresh()
	view:SetHeight(h)
	local win = UI.Options and UI.Options.frame
	if win and view:IsShown() then W.ShellBody(win, h) end
end

-- Options.lua's custom page builder.
function P.Build(view)
	P.view = view
	view.rows = {}
	local installed = W.SectionHeader(view)
	local none = W.Text(view, "note", "textMuted")
	none:SetWordWrap(true)
	none:SetText(L["No guide packs installed."])
	local suggestH = W.SectionHeader(view)
	W.SetSection(suggestH, L["Suggestions"])
	local source = W.Dropdown(view, L["Suggest guides from"], "behavior.suggestFrom", P.SourceChoices,
		L["Where the guide for your level is suggested from. Polestar's guides fill in where a pack has none for you."], nil,
		{ get = function()
			local G = registry()
			return G and G.SuggestSource and G.SuggestSource() or "guides"
		end })
	view.Source = source
	local aboutH = W.SectionHeader(view)
	W.SetSection(aboutH, L["About guide packs"])
	local about = W.Text(view, "note", "textDim")
	about:SetWordWrap(true)
	about:SetSpacing(3)
	about:SetJustifyH("LEFT")
	about:SetJustifyV("TOP")
	about:SetText(table.concat({
		L["A guide pack is a separate addon with someone else's guides for Polestar. It is not part of Polestar, and its guides are not Polestar's own routes."],
		L["Get a pack from wherever its author publishes it and install it like any addon, then restart the game. Its guides appear in the guide menu under Guide packs, with the author's name. The switch on its row above turns it on or off."],
		L["Each pack is made and supported by its author: report its problems to them, not to Polestar. A pack is an addon like any other, so install packs from authors you trust."],
		L["Anyone can write a pack with Polestar's own tools."],
	}, "\n\n"))
	local docsLabel = oneLine(W.Text(view, "note", "text"))
	-- The page on guide packs: a link opening the copy window.
	local docs = W.Link(view, "", function()
		local url = guidePacksURL()
		if url then UI.ShowCopy(L["Guide packs, explained"], url) end
	end, { role = "note" })
	docs.Label:SetWordWrap(false)
	view.Docs, view.DocsLabel = docs, docsLabel

	view.Refresh = function()
		local width = bodyWidth()
		local list = packs()
		local y = 8
		installed:ClearAllPoints()
		installed:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		installed:SetWidth(width)
		W.SetSection(installed, L["Installed"], #list)
		y = y + 44
		none:SetShown(#list == 0)
		if #list == 0 then
			none:SetWidth(width)
			none:ClearAllPoints()
			none:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
			y = y + none:GetStringHeight() + 16
		end
		for i, r in ipairs(list) do
			local row = view.rows[i]
			if not row then
				row = newRow(view)
				view.rows[i] = row
			end
			row:ClearAllPoints()
			row:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
			y = y + layoutRow(row, r, width)
		end
		for i = #list + 1, #view.rows do view.rows[i]:Hide() end
		y = y + 16

		suggestH:ClearAllPoints()
		suggestH:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		suggestH:SetWidth(width)
		y = y + 44
		source:ClearAllPoints()
		source:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		source:Refresh()
		y = y + W.LayoutRow(source, width) + 16

		aboutH:ClearAllPoints()
		aboutH:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		aboutH:SetWidth(width)
		y = y + 44 + 4
		about:SetWidth(width)
		about:ClearAllPoints()
		about:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		y = y + about:GetStringHeight() + 14
		local url = guidePacksURL()
		docsLabel:ClearAllPoints()
		docsLabel:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -(y + 3))
		if url then
			docsLabel:SetText(L["Read more:"])
			docsLabel:SetWidth(0)
			local lw = min(floor(width / 3), docsLabel:GetStringWidth() + 2)
			docsLabel:SetWidth(lw)
			setLink(docs, url, width - lw - 8)
			docs:ClearAllPoints()
			docs:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad + lw + 8, -y)
			docs:Show()
		else
			docsLabel:SetText(L["Read more: docs/GUIDE_PACKS.md in Polestar's source"])
			docsLabel:SetWidth(width)
			docs:Hide()
		end
		return y + 20 + 24
	end
end

-- A pack switched, or the scan at login: the page and the dot follow.
ns.On("PACKS_CHANGED", function()
	local view = P.view
	if view and view:IsVisible() then relayout(view) end
	local O = UI.Options
	if O and O.RefreshNav then O.RefreshNav() end
end)
