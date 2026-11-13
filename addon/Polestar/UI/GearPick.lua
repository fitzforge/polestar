-- The reward pick under a turn-in goal in the guide window: which of the
-- quest's reward choices to take, from Polestar.Gear.
--
--   ^ Thornroot Club  +12%        an upgrade: the chevron and gain in success
--   Take Thornroot Club           no choice is an upgrade: the best of them, muted
--   Reward: Thornroot Club +12% · at turn-in
--                                 on an accept goal, when the pick is an upgrade: muted
--
-- The item name is in its quality colour. Hover shows the item's tooltip
-- (with Gear's upgrade lines and the weights they were scored with) and
-- what a click does; a click opens Stat weights (Settings > Questing >
-- Rewards & gear, #2035), a modified click links the item (the client's
-- HandleModifiedItemClick: chat link, dressing room).
--
-- GuideFrame calls the two hooks for every goal row (agreed with the UI owner):
--   UI.GearPick.Paint(row, goal)                -- after the row's subline is set
--   UI.GearPick.Measure(row, width, h, above)   -- -> h, above (unchanged when hidden)
-- Shown for open turn-in goals whose quest has gear choices this character
-- can use (Gear.QuestPick), and for open accept goals whose pick is an
-- upgrade; hidden otherwise or with gear advice off (then nothing is looked up).

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local type, floor, max = type, math.floor, math.max

local GP = {}
UI.GearPick = GP

local LINE_H = 16
local GAP = 3
local CHEVRON = 10

local function pickFor(goal)
	local Gear = ns.Gear
	if not (Gear and Gear.QuestPick and Gear.IsEnabled() and ns.Get("gear.rewards")) then return nil end
	if (goal.t ~= "turnin" and goal.t ~= "accept") or not goal.quest then return nil end
	if goal.status == "done" or goal.status == "skipped" then return nil end
	local pick = Gear.QuestPick(goal.quest)
	if goal.t == "accept" and not (pick and pick.upgrade) then return nil end
	return pick
end
GP.PickFor = pickFor

local function qualityHex(quality)
	local r, g, b
	if C_Item and C_Item.GetItemQualityColor and quality then
		local ok, cr, cg, cb = pcall(C_Item.GetItemQualityColor, quality)
		if ok and type(cr) == "number" then r, g, b = cr, cg, cb end
	end
	if not r then return Theme.Hex("item") end
	return ("ff%02x%02x%02x"):format(floor(r * 255 + 0.5), floor(g * 255 + 0.5), floor(b * 255 + 0.5))
end

local function itemName(id)
	local DB = ns.ItemDB
	local name = DB and DB.ItemName and DB.ItemName(id)
	if not name and C_Item and C_Item.GetItemNameByID then
		local ok, n = pcall(C_Item.GetItemNameByID, id)
		if ok and type(n) == "string" then name = n end
	end
	return name or (L["Item"] .. " " .. id)
end

local function itemQuality(id)
	local DB = ns.ItemDB
	local rec = DB and DB.Get and DB.Get(id)
	return rec and rec.quality or nil
end

-- Under the item's lines: what a click does.
-- The pick's gain: Forever Leveling BiS's in its score points ("+6.1 (+8%)")
-- while its scores decide, else the percent; "new" for an empty slot.
local function gainText(e)
	local G = ns.Gear
	if e.flbis and e.delta and not e.empty then return (G.PointsText(e.delta, e.pct)) end
	return e.pct and (G.GainText(e.pct)) or L["new"]
end

local function clickHint(tip)
	local r, g, b = Theme.Color("textMuted")
	tip:AddLine(L["Click: choose the stat weights"], r, g, b)
end

local function onEnter(self)
	local e = self.psEntry
	if not e then return end
	W.ItemTip(self, e.id, clickHint)
	if UI.GuideFrame and UI.GuideFrame.HoverIn then UI.GuideFrame.HoverIn() end
end

local function onLeave(self)
	if GameTooltip and GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end

local function onClick(self)
	local e = self.psEntry
	if not e or W.ItemClick(e.id) then return end
	local Gear = ns.Gear
	if Gear and Gear.ShowWeightsSetting then Gear.ShowWeightsSetting() end
end

local function frameOf(row)
	local f = row.psGearPick
	if f then return f end
	f = CreateFrame("Button", nil, row)
	f:SetHeight(LINE_H)
	f.Chevron = f:CreateTexture(nil, "ARTWORK")
	f.Chevron:SetTexture(Theme.Media("chevron-up"))
	f.Chevron:SetSize(CHEVRON, CHEVRON)
	f.Chevron:SetPoint("LEFT", f, "LEFT", 0, 0)
	W.Color(f.Chevron, "success")
	f.Text = W.Text(f, "small", "textDim")
	f.Gain = W.Text(f, "small", "success")
	f:SetScript("OnEnter", onEnter)
	f:SetScript("OnLeave", onLeave)
	f:SetScript("OnClick", onClick)
	f:Hide()
	row.psGearPick = f
	return f
end

function GP.Paint(row, goal)
	local pick = pickFor(goal)
	if not pick then
		if row.psGearPick then
			row.psGearPick.psEntry = nil
			row.psGearPick:Hide()
		end
		return
	end
	local f = frameOf(row)
	local e = pick.entry
	f.psEntry = e
	local name = "|c" .. qualityHex(itemQuality(e.id)) .. itemName(e.id) .. "|r"
	f.Text:ClearAllPoints()
	if goal.t == "accept" then
		f.Chevron:Hide()
		f.Gain:Hide()
		f.Text:SetPoint("LEFT", f, "LEFT", 0, 0)
		f.Text:SetText(L["Reward"] .. ": " .. name .. " " .. gainText(e) .. " · " .. L["at turn-in"])
	elseif pick.upgrade then
		f.Chevron:Show()
		f.Text:SetPoint("LEFT", f.Chevron, "RIGHT", 4, 0)
		f.Text:SetText(name)
		f.Gain:SetText(gainText(e))
		f.Gain:Show()
	else
		f.Chevron:Hide()
		f.Text:SetPoint("LEFT", f, "LEFT", 0, 0)
		f.Text:SetText(L["Take"] .. " " .. name)
		f.Gain:Hide()
	end
	f:Show()
end

function GP.Measure(row, width, h, above)
	local f = row.psGearPick
	if not (f and f:IsShown() and f.psEntry) then return h, above end
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, -GAP)
	f:SetWidth(width)
	local x = f.Chevron:IsShown() and (CHEVRON + 4) or 0
	local gainW = f.Gain:IsShown() and (f.Gain:GetStringWidth() + 8) or 0
	f.Text:SetWidth(max(20, width - x - gainW))
	local textW = math.min(f.Text:GetStringWidth(), width - x - gainW)
	f.Gain:ClearAllPoints()
	f.Gain:SetPoint("LEFT", f, "LEFT", x + textW + 8, 0)
	return h + GAP + LINE_H, f
end
