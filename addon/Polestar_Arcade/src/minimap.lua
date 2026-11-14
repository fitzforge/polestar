-- Minimap button (no libraries): left-click opens/closes the game, drag to move it
-- around the minimap edge. Also hooks the retail addon compartment if present.
local D = FreedoomArcade
local MM = {}
D.Minimap = MM

local ICON = D.ADDON_PATH .. "tex\\icon"
local button, db
local menu

local function updatePosition()
	if not button then return end
	local angle = math.rad(db.minimapPos or 220)
	local x, y = math.cos(angle), math.sin(angle)
	local shape = GetMinimapShape and GetMinimapShape() or "ROUND"
	if shape == "SQUARE" then
		-- push out to the square's edge
		x = math.max(-1, math.min(1, x * 1.42))
		y = math.max(-1, math.min(1, y * 1.42))
	end
	local w = Minimap:GetWidth() / 2 + 5
	local h = Minimap:GetHeight() / 2 + 5
	button:ClearAllPoints()
	button:SetPoint("CENTER", Minimap, "CENTER", x * w, y * h)
end

local function onDragUpdate()
	local mx, my = Minimap:GetCenter()
	local px, py = GetCursorPosition()
	local scale = Minimap:GetEffectiveScale()
	px, py = px / scale, py / scale
	local atan2 = math.atan2 or math.atan
	db.minimapPos = math.deg(atan2(py - my, px - mx)) % 360
	updatePosition()
end

local function showTooltip(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:AddLine("Freedoom Arcade")
	GameTooltip:AddLine("|cffffffffLeft-click|r to open or close", 0.8, 0.8, 0.8)
	GameTooltip:AddLine("|cffffffffRight-click|r for save / load", 0.8, 0.8, 0.8)
	GameTooltip:AddLine("|cffffffffDrag|r to move this button", 0.8, 0.8, 0.8)
	GameTooltip:AddLine("/doom minimap hides it", 0.6, 0.6, 0.6)
	GameTooltip:Show()
end

local function create()
	button = CreateFrame("Button", "FreedoomArcadeMinimapButton", Minimap)
	button:SetSize(31, 31)
	button:SetFrameStrata("MEDIUM")
	button:SetFrameLevel(8)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:RegisterForDrag("LeftButton")
	button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

	local overlay = button:CreateTexture(nil, "OVERLAY")
	overlay:SetSize(53, 53)
	overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	overlay:SetPoint("TOPLEFT")

	local background = button:CreateTexture(nil, "BACKGROUND")
	background:SetSize(20, 20)
	background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
	background:SetPoint("TOPLEFT", 7, -5)

	local icon = button:CreateTexture(nil, "ARTWORK")
	icon:SetSize(18, 18)
	icon:SetTexture(ICON)
	icon:SetPoint("TOPLEFT", 6.5, -5.5)
	button.icon = icon

	button:SetScript("OnClick", function(_, mouse)
		if mouse == "RightButton" then
			GameTooltip:Hide()
			MM.ToggleMenu()
		else
			if menu then menu:Hide() end
			D.UI.Toggle()
		end
	end)
	button:SetScript("OnDragStart", function(self)
		self:LockHighlight()
		self:SetScript("OnUpdate", onDragUpdate)
		GameTooltip:Hide()
	end)
	button:SetScript("OnDragStop", function(self)
		self:SetScript("OnUpdate", nil)
		self:UnlockHighlight()
	end)
	button:SetScript("OnEnter", showTooltip)
	button:SetScript("OnLeave", function() GameTooltip:Hide() end)
	-- press feedback like the stock minimap buttons
	button:SetScript("OnMouseDown", function() icon:SetTexCoord(0.05, 0.95, 0.05, 0.95) end)
	button:SetScript("OnMouseUp", function() icon:SetTexCoord(0, 1, 0, 1) end)
	updatePosition()
end

function MM.Init(savedDB)
	db = savedDB
	if not Minimap then return end
	if not button then create() end
	if db.minimapHidden then button:Hide() else button:Show() end
end

function MM.Toggle()
	db.minimapHidden = not db.minimapHidden
	MM.Init(db)
	D.Print("minimap button " .. (db.minimapHidden and "hidden" or "shown"))
end

------------------------------------------------------------------------ right-click menu
local ROW_H, MENU_W = 16, 230

local function addRow(rows, kind, text, onClick, enabled)
	rows[#rows + 1] = { kind = kind, text = text, onClick = onClick, enabled = enabled ~= false }
end

local function buildRows()
	local UI = D.UI
	local rows = {}
	local open = FreedoomArcadeFrame and FreedoomArcadeFrame:IsShown()
	local canSave = UI.CanSave()
	addRow(rows, "title", "Freedoom Arcade")
	addRow(rows, "item", open and "Close game" or "Open game", function() UI.Toggle() end)
	addRow(rows, "item", "Quick save  |cff888888(F6)|r", function() UI.SaveSlot("quick") end, canSave)
	local qi = UI.SaveInfo("quick")
	addRow(rows, "item", "Quick load  |cff888888" .. (qi or "(empty)") .. "|r", function() UI.LoadSlot("quick") end, qi ~= nil)
	addRow(rows, "header", "Save to slot")
	for n = 1, UI.NUM_SLOTS do
		local info = UI.SaveInfo(n)
		addRow(rows, "item", n .. ".  " .. (info and ("|cffffffff" .. info .. "|r  |cffff8080(overwrite)|r") or "|cff888888empty|r"),
			function() UI.SaveSlot(n) end, canSave)
	end
	addRow(rows, "header", "Load slot")
	for n = 1, UI.NUM_SLOTS do
		local info = UI.SaveInfo(n)
		addRow(rows, "item", n .. ".  " .. (info or "|cff888888empty|r"), function() UI.LoadSlot(n) end, info ~= nil)
	end
	if not canSave then
		addRow(rows, "note", "|cff888888Saving needs a game in progress|r")
	end
	return rows
end

local function createMenu()
	menu = CreateFrame("Frame", "FreedoomArcadeMinimapMenu", UIParent)
	menu:SetFrameStrata("FULLSCREEN_DIALOG")
	menu:SetClampedToScreen(true)
	menu:EnableMouse(true)
	menu:Hide()
	local edge = menu:CreateTexture(nil, "BACKGROUND")
	edge:SetPoint("TOPLEFT", -1, 1)
	edge:SetPoint("BOTTOMRIGHT", 1, -1)
	edge:SetColorTexture(0.6, 0.1, 0.1, 1)
	local bg = menu:CreateTexture(nil, "BORDER")
	bg:SetAllPoints(menu)
	bg:SetColorTexture(0.08, 0.02, 0.02, 0.97)
	menu.rows = {}
	-- Escape closes it
	if UISpecialFrames then table.insert(UISpecialFrames, "FreedoomArcadeMinimapMenu") end
	-- clicking anywhere else closes it
	pcall(menu.RegisterEvent, menu, "GLOBAL_MOUSE_DOWN")
	menu:SetScript("OnEvent", function(self)
		if self:IsShown() and not self:IsMouseOver() and not (button and button:IsMouseOver()) then
			self:Hide()
		end
	end)
end

local function rowWidget(i)
	local r = menu.rows[i]
	if r then return r end
	r = CreateFrame("Button", nil, menu)
	r:SetHeight(ROW_H)
	r:SetPoint("TOPLEFT", menu, "TOPLEFT", 6, -6 - (i - 1) * ROW_H)
	r:SetPoint("RIGHT", menu, "RIGHT", -6, 0)
	local hl = r:CreateTexture(nil, "HIGHLIGHT")
	hl:SetAllPoints(r)
	hl:SetColorTexture(1, 0.3, 0.2, 0.25)
	r.text = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	r.text:SetPoint("LEFT", r, "LEFT", 4, 0)
	r.text:SetJustifyH("LEFT")
	r:SetScript("OnClick", function(self)
		if self.row and self.row.enabled and self.row.onClick then
			menu:Hide()
			self.row.onClick()
		end
	end)
	menu.rows[i] = r
	return r
end

function MM.ShowMenu()
	if not menu then createMenu() end
	local rows = buildRows()
	MM.menuRows = rows
	for i, row in ipairs(rows) do
		local w = rowWidget(i)
		w.row = row
		local fs = w.text
		if row.kind == "title" then
			fs:SetFontObject("GameFontNormal")
			fs:SetText(row.text)
			w:EnableMouse(false)
		elseif row.kind == "header" then
			fs:SetFontObject("GameFontNormalSmall")
			fs:SetText(row.text)
			w:EnableMouse(false)
		elseif row.kind == "note" then
			fs:SetFontObject("GameFontHighlightSmall")
			fs:SetText(row.text)
			w:EnableMouse(false)
		else
			fs:SetFontObject(row.enabled and "GameFontHighlightSmall" or "GameFontDisableSmall")
			fs:SetText("   " .. row.text)
			w:EnableMouse(row.enabled)
		end
		w:Show()
	end
	for i = #rows + 1, #menu.rows do menu.rows[i]:Hide() end
	menu:SetSize(MENU_W, #rows * ROW_H + 12)
	menu:ClearAllPoints()
	menu:SetPoint("TOPRIGHT", button, "BOTTOMLEFT", 8, 8)
	menu:Show()
end

function MM.ToggleMenu()
	if menu and menu:IsShown() then menu:Hide() else MM.ShowMenu() end
end

-- click a menu row by its visible label (used by tests)
function MM._ClickRow(match)
	for i, row in ipairs(MM.menuRows or {}) do
		if row.text:find(match, 1, true) then
			menu.rows[i]:GetScript("OnClick")(menu.rows[i])
			return row.enabled
		end
	end
end

-- retail addon compartment (## AddonCompartmentFunc in the toc)
function FreedoomArcade_OnAddonCompartmentClick()
	D.UI.Toggle()
end
