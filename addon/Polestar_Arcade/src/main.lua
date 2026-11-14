-- WoW integration: window, keyboard/mouse input, 35Hz game loop, slash commands.
local D = FreedoomArcade
local G, R, Draw = D.G, D.R, D.Draw
local floor = math.floor

local UI = {}
D.UI = UI

local defaults = { width = 800, detail = "high", alwaysRun = true, mouseSens = 1.0, sound = true, showFPS = false, aggroPause = true }
local db

local frame, view, title, fpsText
local accumulator = 0
local running = false
local looking = false
local lastCursorX

------------------------------------------------------------------------ quick save / load
UI.NUM_SLOTS = 5

-- slot is "quick" or 1..NUM_SLOTS
local function slotTable(slot)
	if slot == "quick" then return db.quicksave end
	db.saves = db.saves or {}
	return db.saves[slot]
end

local function slotName(slot)
	return slot == "quick" and "quicksave" or ("slot " .. slot)
end

function UI.SaveInfo(slot)
	local s = db and slotTable(slot)
	if not s then return nil end
	return string.format("E%dM%d  %s", s.episode, s.map, s.time or "")
end

function UI.CanSave()
	return G.state == "level" and G.player.mo ~= nil and G.player.playerstate == "live"
end

function UI.SaveSlot(slot, silent)
	local save, err = G.SaveGame()
	if not save then
		if not silent then
			if G.state == "level" then G.player.message = err end
			D.Print("can't save: " .. err)
		end
		return false
	end
	if slot == "quick" then
		db.quicksave = save
	else
		db.saves = db.saves or {}
		db.saves[slot] = save
	end
	if not silent then
		G.player.message = slot == "quick" and "Game saved." or ("Game saved to slot " .. slot .. ".")
		if not (frame and frame:IsShown()) then D.Print("saved to " .. slotName(slot)) end
	end
	return true
end

function UI.LoadSlot(slot)
	local s = slotTable(slot)
	if not s then
		D.Print(slot == "quick" and "no quicksave yet (F6 saves)" or ("save slot " .. slot .. " is empty"))
		return false
	end
	UI.Open()
	local ok, err = G.LoadGame(s)
	if not ok then
		D.Print("can't load: " .. tostring(err))
		return false
	end
	G.paused = false
	G.keepPaused = false
	G.player.message = slot == "quick" and "Game loaded." or ("Loaded slot " .. slot .. ".")
	return true
end

function UI.QuickSave(silent) return UI.SaveSlot("quick", silent) end
function UI.QuickLoad() return UI.LoadSlot("quick") end

------------------------------------------------------------------------ input
local inp = G.input
local held = {}

local bindings = {
	W = "forward", UP = "forward",
	S = "back", DOWN = "back",
	A = "strafeleft", D = "straferight",
	LEFT = "left", RIGHT = "right", Q = "left", E = "right",
	LCTRL = "fire", RCTRL = "fire",
	SPACE = "use", F = "use",
	LSHIFT = "run", RSHIFT = "run",
	LALT = "strafe", RALT = "strafe",
}

local function setAction(action, down)
	inp[action] = down
end

local function OnKeyDown(self, key)
	if held[key] then return end
	held[key] = true
	if G.state == "level" and not G.paused then
		local action = bindings[key]
		if action then
			setAction(action, true)
			return
		end
		local n = tonumber(key)
		if n and n >= 1 and n <= 7 then
			inp.weapon = n - 1
			return
		end
		if key == "F6" then
			UI.QuickSave()
		elseif key == "F9" then
			UI.QuickLoad()
		elseif key == "TAB" or key == "M" then
			D.AM.Toggle()
		elseif D.AM.active and (key == "=" or key == "+" or key == "EQUALS" or key == "NUMPADPLUS") then
			D.AM.Zoom(1)
		elseif D.AM.active and (key == "-" or key == "MINUS" or key == "NUMPADMINUS") then
			D.AM.Zoom(-1)
		elseif key == "ESCAPE" then
			G.OpenMenu()
		elseif key == "P" or key == "PAUSE" then
			G.paused = not G.paused
		end
		return
	end
	if G.state == "level" and G.paused then
		if key == "P" or key == "PAUSE" or key == "ESCAPE" then
			G.paused = false
			G.keepPaused = false
		elseif key == "F9" then
			UI.QuickLoad()
		end
		return
	end
	if key == "F9" and (G.state == "menu" or G.state == "title") then
		if UI.QuickLoad() then return end
	end
	if G.state == "menu" then
		if key == "UP" or key == "W" then G.MenuKey("up")
		elseif key == "DOWN" or key == "S" then G.MenuKey("down")
		elseif key == "ENTER" or key == "SPACE" or key == "LCTRL" then G.MenuKey("enter")
		elseif key == "ESCAPE" or key == "BACKSPACE" then
			if G.menu.page == "main" and G.menuReturn ~= "level" then
				UI.Close()
			else
				G.MenuKey("back")
			end
		end
		return
	end
	if G.state == "title" then
		if key == "ESCAPE" then UI.Close() else G.Continue() end
		return
	end
	-- intermission / finale
	if key == "ESCAPE" and G.state == "finale" then
		G.state = "title"
	elseif bindings[key] == "use" or bindings[key] == "fire" or key == "ENTER" then
		G.Continue()
	end
end

local function OnKeyUp(self, key)
	held[key] = nil
	local action = bindings[key]
	if action then setAction(action, false) end
end

local function clearInput()
	for k in pairs(held) do held[k] = nil end
	for _, action in pairs(bindings) do inp[action] = false end
	inp.mousex = 0
	looking = false
end

------------------------------------------------------------------------ loop
local fpsFrames, fpsTime = 0, 0

local function OnUpdate(self, elapsed)
	if not running then return end
	if elapsed > 0.25 then elapsed = 0.25 end
	accumulator = accumulator + elapsed
	if looking then
		local x = GetCursorPosition()
		if lastCursorX then
			inp.mousex = inp.mousex + (x - lastCursorX) * db.mouseSens
		end
		lastCursorX = x
	end
	local tics = floor(accumulator * 35)
	if tics > 0 then
		if tics > 4 then tics = 4; accumulator = 0 else accumulator = accumulator - tics / 35 end
		for _ = 1, tics do G.Ticker() end
		local ok, err = pcall(G.Display)
		if not ok then
			running = false
			D.Print("render error: " .. tostring(err))
		end
	end
	if db.showFPS then
		fpsFrames = fpsFrames + 1
		fpsTime = fpsTime + elapsed
		if fpsTime >= 1 then
			fpsText:SetText(string.format("%d fps  %d quads", fpsFrames / fpsTime, Draw.stats.quads))
			fpsFrames, fpsTime = 0, 0
		end
	end
end

------------------------------------------------------------------------ window
local function applySize()
	local w = db.width
	local h = floor(w * 0.75 + 0.5)
	frame:SetSize(w + 8, h + 28)
	view:SetSize(w, h)
	Draw.SetScale(w, h)
end

local function applyDetail()
	R.SetViewSize(db.detail == "low" and 160 or 320, 168)
end

local function createFrame()
	frame = CreateFrame("Frame", "FreedoomArcadeFrame", UIParent)
	frame:SetFrameStrata("DIALOG")
	frame:SetToplevel(true)
	frame:SetPoint("CENTER")
	frame:SetMovable(true)
	frame:SetClampedToScreen(true)
	frame:EnableMouse(true)
	frame:Hide()

	local bg = frame:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints(frame)
	bg:SetColorTexture(0.12, 0.02, 0.02, 0.95)

	local bar = CreateFrame("Frame", nil, frame)
	bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
	bar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
	bar:SetHeight(22)
	bar:EnableMouse(true)
	bar:RegisterForDrag("LeftButton")
	bar:SetScript("OnDragStart", function() frame:StartMoving() end)
	bar:SetScript("OnDragStop", function() frame:StopMovingOrSizing() end)

	title = bar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	title:SetPoint("LEFT", bar, "LEFT", 8, 0)
	title:SetText("Freedoom Arcade  |cff999999(Esc: menu, Tab: map, F6/F9: quick save/load, P: pause)|r")

	fpsText = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	fpsText:SetPoint("RIGHT", bar, "RIGHT", -28, 0)

	local close = CreateFrame("Button", nil, bar, "UIPanelCloseButton")
	close:SetPoint("RIGHT", bar, "RIGHT", 2, 0)
	close:SetScript("OnClick", function() UI.Close() end)

	view = CreateFrame("Frame", nil, frame)
	view:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -24)
	if view.SetClipsChildren then view:SetClipsChildren(true) end
	local vbg = view:CreateTexture(nil, "BACKGROUND")
	vbg:SetAllPoints(view)
	vbg:SetColorTexture(0, 0, 0, 1)
	view:EnableMouse(true)
	view:SetScript("OnMouseDown", function(_, button)
		if button == "LeftButton" then
			if G.state == "level" then inp.fire = true else G.Continue() end
		elseif button == "RightButton" then
			looking = true
			lastCursorX = GetCursorPosition()
		end
	end)
	view:EnableMouseWheel(true)
	view:SetScript("OnMouseWheel", function(_, delta)
		if G.state == "level" and D.AM.active then D.AM.Zoom(delta) end
	end)
	view:SetScript("OnMouseUp", function(_, button)
		if button == "LeftButton" then
			inp.fire = false
		elseif button == "RightButton" then
			looking = false
		end
	end)

	frame:EnableKeyboard(true)
	frame:SetScript("OnKeyDown", OnKeyDown)
	frame:SetScript("OnKeyUp", OnKeyUp)
	frame:SetScript("OnUpdate", OnUpdate)
	frame:SetScript("OnHide", function()
		running = false
		clearInput()
		if G.state == "level" then G.paused = true end
	end)

	Draw.Init(view)
	applySize()
	applyDetail()
	R.Init()
end

function UI.Open()
	if not frame then createFrame() end
	frame:Show()
	running = true
	accumulator = 0
	if G.state == "level" and not G.keepPaused then G.paused = false end
end

function UI.Close()
	if frame then frame:Hide() end
end

function UI.Toggle()
	if frame and frame:IsShown() then UI.Close() else UI.Open() end
end

------------------------------------------------------------------------ slash commands
local function help()
	D.Print("/doom - open or close the game window")
	D.Print("/doom size <400-1600> - window width")
	D.Print("/doom detail high|low - 320 or 160 render columns")
	D.Print("/doom run - toggle always-run")
	D.Print("/doom sens <0.1-5> - mouse turn sensitivity")
	D.Print("/doom sound - toggle sound effects")
	D.Print("/doom fps - toggle fps counter")
	D.Print("/doom warp <E1M1> [skill 1-5] - jump to a map")
	D.Print("/doom save | load - quick save / load (F6 / F9 in game)")
	D.Print("/doom save <1-5> | load <1-5> - save slots (also on the minimap button's right-click menu)")
	D.Print("/doom aggro - toggle auto save + pause when you enter combat")
	D.Print("/doom minimap - show or hide the minimap button")
end

SLASH_FREEDOOMARCADE1 = "/arcade"
SLASH_FREEDOOMARCADE2 = "/freedoom"
SLASH_FREEDOOMARCADE3 = "/doom"
SlashCmdList.FREEDOOMARCADE = function(msg)
	msg = (msg or ""):lower()
	local cmd, arg = msg:match("^(%S*)%s*(.-)$")
	if cmd == "" then
		UI.Toggle()
	elseif cmd == "size" then
		local w = tonumber(arg)
		if w then
			db.width = math.max(400, math.min(1600, floor(w)))
			if frame then applySize() end
		end
	elseif cmd == "detail" then
		db.detail = arg == "low" and "low" or "high"
		if frame then applyDetail() end
		D.Print("detail: " .. db.detail)
	elseif cmd == "run" then
		db.alwaysRun = not db.alwaysRun
		G.alwaysRun = db.alwaysRun
		D.Print("always run: " .. tostring(db.alwaysRun))
	elseif cmd == "sens" then
		db.mouseSens = tonumber(arg) or db.mouseSens
	elseif cmd == "sound" then
		db.sound = not db.sound
		D.Sound.enabled = db.sound
		D.Print("sound: " .. tostring(db.sound))
	elseif cmd == "fps" then
		db.showFPS = not db.showFPS
		if fpsText then fpsText:SetText("") end
	elseif cmd == "save" or cmd == "load" then
		local n = tonumber(arg)
		local slot = (n and n >= 1 and n <= UI.NUM_SLOTS) and floor(n) or "quick"
		if cmd == "save" then UI.SaveSlot(slot) else UI.LoadSlot(slot) end
	elseif cmd == "minimap" then
		D.Minimap.Toggle()
	elseif cmd == "aggro" then
		db.aggroPause = not db.aggroPause
		D.Print("pause on aggro: " .. (db.aggroPause and "on" or "off"))
	elseif cmd == "warp" then
		local e, m = arg:match("e(%d)m(%d)")
		local skill = tonumber(arg:match("%s(%d)$") or "3")
		if e and m then
			UI.Open()
			G.InitNew(math.max(0, math.min(4, skill - 1)), tonumber(e), tonumber(m))
		end
	else
		help()
	end
end

------------------------------------------------------------------------ init
-- entering combat: save, pause and hand the keyboard back to the character
function UI.OnAggro()
	if not db or not db.aggroPause then return end
	if not frame or not frame:IsShown() then return end
	local saved = false
	if G.state == "level" then
		saved = UI.QuickSave(true)
		G.paused = true
		G.keepPaused = true
	end
	UI.Close()
	if PlaySound and SOUNDKIT and SOUNDKIT.RAID_WARNING then PlaySound(SOUNDKIT.RAID_WARNING, "Master") end
	if RaidNotice_AddMessage and RaidWarningFrame then
		RaidNotice_AddMessage(RaidWarningFrame, "Freedoom Arcade paused - you have aggro!", ChatTypeInfo and ChatTypeInfo["RAID_WARNING"] or { r = 1, g = 0.2, b = 0.2 })
	end
	D.Print("you're in combat! Game " .. (saved and "saved and " or "") .. "paused. Type /doom to come back, P to resume.")
end

function UI.OnCombatEnd()
	if db and db.aggroPause and G.keepPaused and frame and not frame:IsShown() then
		D.Print("combat over. Type /doom to get back to Doom.")
	end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:RegisterEvent("PLAYER_REGEN_DISABLED")
loader:RegisterEvent("PLAYER_REGEN_ENABLED")
loader:SetScript("OnEvent", function(self, event, name)
	if event == "PLAYER_REGEN_DISABLED" then return UI.OnAggro() end
	if event == "PLAYER_REGEN_ENABLED" then return UI.OnCombatEnd() end
	if name ~= "FreedoomArcade" then return end
	FreedoomArcadeDB = FreedoomArcadeDB or {}
	db = FreedoomArcadeDB
	for k, v in pairs(defaults) do
		if db[k] == nil then db[k] = v end
	end
	G.alwaysRun = db.alwaysRun
	D.Sound.enabled = db.sound
	if D.Minimap then D.Minimap.Init(db) end
	self:UnregisterEvent("ADDON_LOADED")
end)

-- expose for testing
UI._OnKeyDown, UI._OnKeyUp, UI._OnUpdate = OnKeyDown, OnKeyUp, OnUpdate
function UI._SetDB(t) db = t end
