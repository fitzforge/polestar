-- Export (spec 4.4, 9.4), a tab of the Studio window's dock: the version
-- (Studio suggests a bump when steps changed since the last export), the
-- string in a box that clears and selects itself, a chat link, and the
-- whole draft as a backup string.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local P = _G.Polestar
local W = UI.W
local format, pcall, type, tostring, concat = string.format, pcall, type, tostring, table.concat

local X = {}
UI.Export = X

local f

local function doc() return S.Model.Current() end

local function stepIds(d)
	local ids = {}
	for _, st in ipairs(d.steps) do ids[#ids + 1] = st.id or "" end
	return concat(ids, ",")
end

-- What this guide was at its last export (step ids, version), per guide id.
local function memory(d)
	local s = UI.State("Export")
	s.docs = s.docs or {}
	local m = s.docs[d.header.id or "?"]
	if not m then
		m = {}
		s.docs[d.header.id or "?"] = m
	end
	return m
end

-- What changed since the last export -> suggestion text, bump wanted.
local function suggestion(d)
	local m = memory(d)
	if not m.ids then return L["First export of this guide."], false end
	if (d.header.version or 1) > (m.version or 1) then return L["Version already raised since the last export."], false end
	if m.ids ~= stepIds(d) then return L["Steps were added, removed or moved since the last export: raise the version so players get the update."], true end
	return L["Only text changed since the last export (or nothing): a new version is optional."], false
end

local function exportString(d)
	if not S.Export then return nil, L["Export is not available."] end
	local ok, text, reason = pcall(S.Export, d)
	if not ok then return nil, tostring(text) end
	return text, reason
end

local function fillBox(text)
	f.Box:SetText("")
	W.SetCopyText(f.Box, text or "")
	if text and text ~= "" then
		f.Box:SetFocus()
		f.Box:HighlightText()
	end
end

local function refresh()
	if not (f and f:IsVisible()) then return end
	local d = doc()
	f.Part:SetShown(d ~= nil)
	if not d then
		f.Info:SetText(L["Start or open a guide first."])
		W.Color(f.Info, "textDim")
		fillBox("")
		return
	end
	local text, reason = exportString(d)
	if text then
		local m = memory(d)
		m.ids, m.version = stepIds(d), d.header.version or 1
		f.Info:SetText(format(L["%s  \194\183  version %d  \194\183  %d steps  \194\183  %d characters. Copy it with Ctrl+C."],
			tostring(d.header.id), d.header.version or 1, #d.steps, #text))
		W.Color(f.Info, "textDim")
	else
		f.Info:SetText(format(L["The guide cannot be exported yet: %s"], tostring(reason or "?")))
		W.Color(f.Info, "danger")
	end
	fillBox(text)
	local msg, bump = suggestion(d)
	f.Version:SetText(format(L["Version %d"], d.header.version or 1))
	f.Suggest:SetText(msg)
	W.Color(f.Suggest, bump and "warning" or "textMuted")
	f.Link:SetShown(P.Share and P.Share.Link and true or false)
end

-- The chat link: Polestar's Share of the draft it plays (the live sync's).
local function chatLink()
	local d = doc()
	local Share, PS = P.Share, P.Studio
	if not (d and Share and Share.Link and PS and PS.DraftId) then return end
	if S.Sync and S.Sync.Now then S.Sync.Now() end
	local ok, linked = pcall(Share.Link, PS.DraftId(d.header.id))
	if ok and linked then
		UI.Say(L["Link put in your chat box."], "success")
	else
		UI.Say(ok and L["This guide cannot be linked in chat yet: turn on live sync, or share the string."] or tostring(linked), "warning")
	end
end

-- Build the tab's page (Panel.lua's dock).
function X.Build(page)
	f = page
	f.Info = UI.Text(page, "small", "textDim", true)
	f.Info:SetPoint("TOPLEFT", page, "TOPLEFT", 14, -10)
	f.Info:SetPoint("TOPRIGHT", page, "TOPRIGHT", -14, -10)
	f.Box = W.CopyBox(page, { lines = 4 })
	f.Box:SetPoint("TOPLEFT", page, "TOPLEFT", 14, -40)
	f.Box:SetPoint("TOPRIGHT", page, "TOPRIGHT", -14, -40)
	f.Box:SetMaxLetters(0)
	local e = CreateFrame("Frame", nil, page)
	e:SetPoint("TOPLEFT", f.Box, "BOTTOMLEFT", 0, -10)
	e:SetPoint("BOTTOMRIGHT", page, "BOTTOMRIGHT", -14, 10)
	f.Part = e
	f.Version = W.Text(e, "heading", "text")
	f.Version:SetPoint("TOPLEFT", e, "TOPLEFT", 0, -4)
	f.Bump = W.Button(e, L["Raise the version"], function()
		local d = doc()
		if not d then return end
		S.Model.SetHeader("version", (d.header.version or 1) + 1)
		refresh()
	end, { height = 24 })
	f.Bump:SetPoint("TOPRIGHT", e, "TOPRIGHT", 0, 0)
	f.Suggest = UI.Text(e, "small", "textMuted", true)
	f.Suggest:SetPoint("TOPLEFT", e, "TOPLEFT", 0, -30)
	f.Suggest:SetPoint("TOPRIGHT", e, "TOPRIGHT", 0, -30)
	f.Again = W.Button(e, L["Export again"], refresh, { primary = true })
	f.Again:SetPoint("BOTTOMRIGHT", e, "BOTTOMRIGHT", 0, 0)
	f.Link = W.Button(e, L["Chat link"], chatLink)
	f.Link:SetPoint("RIGHT", f.Again, "LEFT", -8, 0)
	f.Backup = W.Button(e, L["Export backup"], function()
		if S.Backup and S.Backup.ExportString then
			local ok, text = pcall(S.Backup.ExportString)
			if ok and text then
				fillBox(text)
				f.Info:SetText(L["The whole draft, as a backup string. Keep it somewhere safe."])
			else
				UI.Say(tostring(text or L["No backup to export."]), "warning")
			end
		end
	end, { ghost = true })
	f.Backup:SetPoint("BOTTOMLEFT", e, "BOTTOMLEFT", 0, 0)
	-- Made on show only (and Export again): a refresh takes the keyboard's focus.
	f:HookScript("OnShow", refresh)
end

-- Open the Studio window on the Export tab.
function X.Show()
	UI.SelectTab("Export")
end
