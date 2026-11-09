-- Pickers and prompts: Studio picks ids from lists, never from free text
-- (spec 4.2). One searchable list window and one question window, both in
-- Polestar's look.
--
--   S.UI.Pick({ title, items = list | fn(query) -> list, onPick(item), hint })
--       item = { text, sub, value, icon (path), iconTint = false }
--   S.UI.Prompt({ title, label, default, onAccept(text), multi })
--   S.UI.Menu(anchor, items)       -- Polestar's own popup menu (W.ShowMenu)
--   S.UI.SearchCodex(kind, query, limit) -> { { id, name } }
--   S.UI.IconPicker(anchor, onPick(n))   -- the eight raid icons

local ADDON, S = ...
local L = S.L
local UI = S.UI
local P = _G.Polestar
local Theme, W = UI.Theme, UI.W
local format, floor, min, ipairs, type, tostring, tonumber = string.format, math.floor, math.min, ipairs, type, tostring, tonumber

local ROW = 30
local VISIBLE = 12

---------------------------------------------------------------------------
-- Pick
---------------------------------------------------------------------------

local picker, pickSpec, pickItems = nil, nil, {}

local function fillPicker()
	local q = (picker.Search:GetText() or ""):lower()
	local items = pickSpec.items
	if type(items) == "function" then
		items = items(q) or {}
	else
		local out = {}
		for _, it in ipairs(items or {}) do
			if q == "" or tostring(it.text):lower():find(q, 1, true) or (it.sub and tostring(it.sub):lower():find(q, 1, true)) then
				out[#out + 1] = it
			end
		end
		items = out
	end
	pickItems = items
	local child = picker.Scroll.Child
	child:SetWidth(picker.Scroll:GetWidth())
	for k, it in ipairs(items) do
		local row = picker.Rows:Get(k)
		row:ClearAllPoints()
		row:SetPoint("TOPLEFT", child, "TOPLEFT", 0, -(k - 1) * ROW)
		row:SetPoint("TOPRIGHT", child, "TOPRIGHT", 0, -(k - 1) * ROW)
		row.Text:SetText(it.text or "")
		row.Sub:SetText(it.sub or "")
		if it.icon then
			row.Icon:SetTexture(it.icon)
			if it.iconTint == false then W.Uncolor(row.Icon); row.Icon:SetVertexColor(1, 1, 1, 1) else W.Color(row.Icon, it.iconTint or "accent") end
			row.Icon:Show()
		else
			row.Icon:Hide()
		end
		row.psItem = it
	end
	picker.Rows:HideFrom(#items + 1)
	W.SetScrollContent(picker.Scroll, #items * ROW)
	W.ScrollTo(picker.Scroll, 0)
	picker.Empty:SetShown(#items == 0)
end

local function buildPicker()
	local f = UI.Window("Pick", "", 420, 92 + ROW * VISIBLE, { strata = "DIALOG" })
	f.Search = W.SearchBox(f.Body, L["Search"], function()
		if f.psTimer then f.psTimer:Cancel() end
		f.psTimer = C_Timer.NewTimer(0.15, fillPicker)
	end)
	f.Search:SetPoint("TOPLEFT", f.Body, "TOPLEFT", 12, -10)
	f.Search:SetPoint("TOPRIGHT", f.Body, "TOPRIGHT", -12, -10)
	f.Search:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
		local it = pickItems[1]
		if it then
			f:Hide()
			pickSpec.onPick(it)
		end
	end)
	f.Hint = UI.Text(f.Body, "small", "textMuted")
	f.Hint:SetPoint("TOPLEFT", f.Search, "BOTTOMLEFT", 0, -6)
	f.Hint:SetPoint("RIGHT", f.Body, "RIGHT", -12, 0)
	f.Scroll = W.Scroll(f.Body)
	f.Scroll:SetPoint("TOPLEFT", f.Body, "TOPLEFT", 4, -64)
	f.Scroll:SetPoint("BOTTOMRIGHT", f.Body, "BOTTOMRIGHT", -4, 8)
	f.Empty = UI.Text(f.Body, "note", "textMuted")
	f.Empty:SetPoint("TOP", f.Scroll, "TOP", 0, -24)
	f.Empty:SetText(L["Nothing matches."])
	f.Rows = UI.Pool(f.Scroll.Child, function(parent)
		local row = UI.Row(parent, ROW)
		row.Icon = row:CreateTexture(nil, "ARTWORK")
		row.Icon:SetSize(16, 16)
		row.Icon:SetPoint("LEFT", row, "LEFT", 10, 0)
		row.Text = W.Text(row, "body", "text")
		row.Text:SetPoint("LEFT", row, "LEFT", 34, 0)
		row.Text:SetPoint("RIGHT", row, "RIGHT", -120, 0)
		row.Sub = W.Text(row, "small", "textMuted")
		row.Sub:SetJustifyH("RIGHT")
		row.Sub:SetPoint("RIGHT", row, "RIGHT", -12, 0)
		row.Sub:SetWidth(110)
		row:SetScript("OnClick", function(self)
			f:Hide()
			if self.psItem then pickSpec.onPick(self.psItem) end
		end)
		return row
	end)
	return f
end

function UI.Pick(spec)
	picker = picker or buildPicker()
	pickSpec = spec
	picker.Title:SetText(spec.title or L["Pick"])
	picker.Hint:SetText(spec.hint or "")
	picker.Search:SetText(spec.query or "")
	picker:Show()
	picker:Raise()
	fillPicker()
	picker.Search:SetFocus()
end

---------------------------------------------------------------------------
-- Prompt
---------------------------------------------------------------------------

local prompt, promptSpec

local function accept()
	local text = prompt.Box:GetText() or ""
	prompt:Hide()
	if promptSpec and promptSpec.onAccept then promptSpec.onAccept(text) end
end

local function buildPrompt()
	local f = UI.Window("Prompt", "", 380, 170, { strata = "DIALOG" })
	f.Label = UI.Text(f.Body, "note", "textDim", true)
	f.Label:SetPoint("TOPLEFT", f.Body, "TOPLEFT", 14, -12)
	f.Label:SetPoint("TOPRIGHT", f.Body, "TOPRIGHT", -14, -12)
	f.Box = UI.Edit(f.Body, {})
	f.Box:SetScript("OnEnterPressed", function(self)
		if not self:IsMultiLine() or IsControlKeyDown() then accept() end
	end)
	f.OK = W.Button(f.Body, L["OK"], accept, { primary = true })
	f.OK:SetPoint("BOTTOMRIGHT", f.Body, "BOTTOMRIGHT", -14, 12)
	f.Cancel = W.Button(f.Body, L["Cancel"], function() f:Hide() end, { ghost = true })
	f.Cancel:SetPoint("RIGHT", f.OK, "LEFT", -8, 0)
	return f
end

function UI.Prompt(spec)
	prompt = prompt or buildPrompt()
	promptSpec = spec
	prompt.Title:SetText(spec.title or "")
	prompt.Label:SetText(spec.label or "")
	local box = prompt.Box
	box:SetMultiLine(spec.multi and true or false)
	box:ClearAllPoints()
	box:SetPoint("TOPLEFT", prompt.Label, "BOTTOMLEFT", 0, -10)
	box:SetPoint("RIGHT", prompt.Body, "RIGHT", -14, 0)
	box:SetHeight(spec.multi and 70 or 26)
	prompt:SetHeight(spec.multi and 214 or 170)
	box.Hint:SetText(spec.placeholder or "")
	box:SetText(spec.default and tostring(spec.default) or "")
	box.Hint:SetShown(box:GetText() == "")
	prompt:Show()
	prompt:Raise()
	box:SetFocus()
	box:HighlightText()
end

---------------------------------------------------------------------------
-- Menus and searches
---------------------------------------------------------------------------

-- items as W.ShowMenu takes them: { text, icon, checked, disabled, onClick, tip }
function UI.Menu(anchor, items, opts)
	W.ShowMenu(anchor, items, opts or { point = "TOPLEFT", relPoint = "BOTTOMLEFT", x = 0, y = -4 })
end

-- Codex search over its index (never loads more than the index): ids whose
-- folded name holds the query, at most `limit`. kind: item mount pet recipe
-- tabard npc rare quest zone instance treasure.
function UI.SearchCodex(kind, query, limit)
	local C = P.Codex
	if C and C.Load then C.Load() end
	local blob = C and C.Index and C.Index(kind)
	local out = {}
	if not blob then return out end
	query = (query or ""):lower()
	if #query < 2 then return out end
	limit = limit or 60
	local qid = tonumber(query)
	for folded, id in blob:gmatch("\2([^\1]*)\1([^,]*),") do
		if (qid and id == query) or folded:find(query, 1, true) then
			local n = tonumber(id) or id
			out[#out + 1] = { id = n, name = (C.Name and C.Name(kind == "rare" and "npc" or (kind == "mount" or kind == "pet" or kind == "recipe" or kind == "tabard") and "item" or kind, n)) or folded }
			if #out >= limit then break end
		end
	end
	return out
end

-- Every faction with a name, for the reputation picker.
function UI.Factions(query)
	local C = P.Codex
	local out = {}
	if not (C and C.Each) then return out end
	query = (query or ""):lower()
	C.Each("faction", function(id, name)
		if query == "" or (name or ""):lower():find(query, 1, true) then
			local rec = C.Faction and C.Faction(id)
			out[#out + 1] = { text = rec and rec.name or name, value = id, sub = tostring(id) }
		end
		return #out < 80
	end)
	return out
end

function UI.IconPicker(anchor, onPick)
	local items = {}
	for n = 1, 8 do
		items[#items + 1] = { text = L[UI.ICONS[n]:gsub("^%l", string.upper)], icon = UI.RaidIcon(n), onClick = function() onPick(n) end }
	end
	UI.Menu(anchor, items)
end

-- A list of class / race / faction choices for `only` pickers.
UI.CLASSES = { "Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Shaman", "Mage", "Warlock", "Druid" }
UI.RACES = { "Human", "Dwarf", "NightElf", "Gnome", "Orc", "Undead", "Tauren", "Troll" }
UI.FACTIONS = { "Alliance", "Horde" }
