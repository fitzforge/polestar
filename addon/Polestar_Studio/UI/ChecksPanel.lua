-- Checks (spec 4.3, 9.3), a tab of the Studio window: the in-game problems,
-- grouped by step; a click opens the step and the goal.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local Theme, W = UI.Theme, UI.W
local format, ipairs, tostring = string.format, ipairs, tostring

local widget
local HEAD_ROW, ROW = 26, 24

local function makeRow(parent)
	local row = UI.Row(parent, ROW)
	row.Glyph = W.Tex(row, "ARTWORK", "info", "warning")
	row.Glyph:SetSize(12, 12)
	row.Glyph:SetPoint("LEFT", row, "LEFT", 10, 0)
	row.Text = W.Text(row, "small", "text")
	row.Text:SetPoint("LEFT", row.Glyph, "RIGHT", 6, 0)
	row.Text:SetPoint("RIGHT", row, "RIGHT", -8, 0)
	row:SetScript("OnClick", function(self)
		if self.psStep then UI.JumpTo(self.psStep, self.psGoal)
		else
			UI.Show()
			S.Model.Select(nil, nil)
		end
	end)
	return row
end

local function refresh()
	local f = widget
	if not (f and f:IsShown()) then return end
	local d = S.Model.Current()
	local c = f.Scroll.Child
	c:SetWidth(f.Scroll:GetWidth())
	local problems = UI.AllProblems()
	-- Group: the guide's own, then by step in order.
	table.sort(problems, function(a, b)
		local sa, sb = a.step or 0, b.step or 0
		if sa ~= sb then return sa < sb end
		return (a.goal or 0) < (b.goal or 0)
	end)
	local y, nr, nh, last = 0, 0, 0, -1
	for _, p in ipairs(problems) do
		local step = p.step or 0
		if step ~= last then
			last = step
			nh = nh + 1
			local h = f.Heads:Get(nh)
			h:ClearAllPoints()
			h:SetPoint("TOPLEFT", c, "TOPLEFT", 10, -y - 6)
			h:SetPoint("RIGHT", c, "RIGHT", -10, 0)
			local st = d and p.step and d.steps[p.step]
			h:SetText(st and format(L["Step %d: %s"], p.step, st.title ~= "" and st.title or L["(untitled step)"]) or L["The guide"])
			y = y + HEAD_ROW
		end
		nr = nr + 1
		local row = f.Rows:Get(nr)
		row:ClearAllPoints()
		row:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
		row:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, -y)
		row.psStep, row.psGoal = p.step, p.goal
		row.Text:SetText((p.goal and format("%d.%d  ", p.step, p.goal) or "") .. tostring(p.message))
		W.Color(row.Glyph, p.severity == "error" and "danger" or "warning")
		y = y + ROW
	end
	f.Rows:HideFrom(nr + 1)
	f.Heads:HideFrom(nh + 1)
	f.Empty:SetShown(nr == 0)
	f.Empty:SetText(d and L["No problems found."] or L["Open a guide to check it."])
	W.SetScrollContent(f.Scroll, y)
end

UI.Widget("Checks", "Checks", 360, 300, function(f)
	widget = f
	local b = f.Body
	f.Run = W.Button(b, L["Check again"], function()
		if S.Checks and S.Checks.Refresh then S.Checks.Refresh() else UI.RunChecks() end
		refresh()
	end, { height = 24 })
	f.Run:SetPoint("TOPRIGHT", b, "TOPRIGHT", -8, -6)
	f.Scroll = W.Scroll(b)
	f.Scroll:SetPoint("TOPLEFT", b, "TOPLEFT", 0, -36)
	f.Scroll:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -2, 4)
	f.Rows = UI.Pool(f.Scroll.Child, makeRow)
	f.Heads = UI.Pool(f.Scroll.Child, function(parent) return W.Text(parent, "caption", "textMuted") end)
	f.Empty = UI.Text(b, "note", "textMuted", true)
	f.Empty:SetPoint("TOPLEFT", b, "TOPLEFT", 14, -46)
	f.Empty:SetPoint("RIGHT", b, "RIGHT", -14, 0)
	f.Refresh = refresh
	f:HookScript("OnShow", function()
		if #UI.AllProblems() == 0 and S.Model.Current() then UI.RunChecks() end
		refresh()
	end)
	S.On("STUDIO_UI_CHECKS", refresh)
	S.On("STUDIO_CHANGED", function(kind) if kind == "doc" then refresh() end end)
end)
