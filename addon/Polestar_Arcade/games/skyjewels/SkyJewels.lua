-- Sky Jewels by RikyZ90, a match-three game in Polestar's Arcade (Polestar_Arcade/games/skyjewels).
-- GPL-3.0-only, as Polestar: see CREDITS.md in this folder and LICENSE in the Polestar folder.
-- The window and its play; Maps/Arcade.lua opens it (the flight card, /polestar jewels, the guide
-- menu), puts it away before a landing and in a fight on a flight, and keeps one game open at a time.
local ADDON, game = ...
local ns = Polestar
local Board, L = game.SkyJewelsBoard, ns.L
local SkyJewels = { title = L["Sky Jewels"], command = "/polestar jewels" }

local CELL, SIDE, SIDEBAR_X = 46, 134, 354
local media = "Interface\\AddOns\\" .. ADDON .. "\\games\\skyjewels\\Media\\"
local zones = {
	{ name = L["Nightbloom Glade"], art = "zone-nightbloom" },
	{ name = L["Sunstone Canyon"], art = "zone-sunstone" },
	{ name = L["Frostglass Peaks"], art = "zone-frostglass" },
	{ name = L["Emberforge"], art = "zone-emberforge" },
	{ name = L["Stormspire Isles"], art = "zone-stormspire" },
	{ name = L["Astral Sanctum"], art = "zone-astral" },
}
local icons = {}
for i = 1, 6 do icons[i] = media .. "jewel-" .. i .. ".tga" end
local bonusName = { [Board.row] = L["Row sweep"], [Board.column] = L["Column sweep"], [Board.burst] = L["Burst"] }
local frame, state, selected, soundHandle
local slots, motion
local ticker, wasOnTaxi
local readout, render

local function stopSound()
	if soundHandle and StopSound then StopSound(soundHandle) end
	soundHandle = nil
end

local function sound(name)
	if ns.CharState().skyJewelsMuted then return end
	stopSound()
	local ok, handle = ns.PlaySoundFile(media .. name .. ".ogg", "SFX")
	if ok then soundHandle = handle end
end

local function place(slot, x, y, alpha, size)
	slot.Icon:SetPoint("CENTER", slot, "CENTER", x, y)
	slot.Icon:SetSize(size, size)
	slot.Icon:SetAlpha(alpha)
	slot.Badge:SetAlpha(alpha)
end

local function showBonus(badge, kind)
	badge:SetShown(kind > 0)
	if kind == 0 then return end
	badge.Horizontal:SetShown(kind ~= Board.column)
	badge.Vertical:SetShown(kind ~= Board.row)
end

local function paint(slot, piece)
	slot.Icon:SetTexture(icons[Board.Jewel(piece)])
	showBonus(slot.Badge, Board.Bonus(piece))
end

local function selectTile(index)
	if selected then slots[selected].Selected:Hide() end
	selected = index
	if selected then slots[selected].Selected:Show() end
end

local function status(text)
	frame.Status:SetText(text or "")
end

function render(tiles)
	for i, slot in ipairs(slots) do
		paint(slot, tiles[i])
		place(slot, 0, 0, 1, CELL - 2)
		slot.Flash:SetAlpha(0)
	end
end

local function save()
	ns.CharState().skyJewels = state
end

local function start(level)
	state = Board.Start(level)
	save()
	selectTile(nil)
	render(state.tiles)
	readout()
	status()
end

function readout()
	local W, rules = ns.Widgets, Board.levels[state.level]
	local won = Board.Won(state)
	local last = state.level == #Board.levels
	local zone = zones[math.ceil(state.level / 10)]
	if frame.zone ~= zone then
		frame.zone = zone
		frame.Zone:SetText(zone.name)
		frame.ZoneArt:SetTexture(media .. zone.art .. ".tga")
	end
	frame.Level:SetText(L["Level %d / %d"]:format(state.level, #Board.levels))
	frame.Moves:SetText(won and L["Objectives complete"] or L["Moves left: %d"]:format(state.moves))
	frame.Score:SetText(("%d / %d"):format(state.score, rules.goal))
	frame.Fill:SetWidth(math.max(1, SIDE * math.min(1, state.score / rules.goal)))
	frame.Fill:SetShown(state.score > 0)
	frame.Goal:SetShown(rules.jewel ~= nil)
	frame.GoalIcon:SetShown(rules.jewel ~= nil)
	if rules.jewel then
		frame.GoalIcon:SetTexture(icons[rules.jewel])
		frame.Goal:SetText(L["Collect %d / %d"]:format(state.collected, rules.count))
	end
	frame.BonusGoal:SetShown(rules.bonuses ~= nil)
	if rules.bonuses then
		frame.BonusGoal:SetPoint("TOPLEFT", frame, "TOPLEFT", SIDEBAR_X, rules.jewel and -225 or -196)
		frame.BonusGoal:SetText(L["Bonuses fired: %d / %d"]:format(state.bonuses, rules.bonuses))
	end
	local finished = won or state.moves == 0
	if finished then
		local message = L["Out of moves"]
		if won then
			message = last and L["Congratulations!\nAll %d levels complete!\nThanks for playing!"]:format(#Board.levels)
				or L["Level %d complete!"]:format(state.level)
		end
		frame.Result.Title:SetText(message)
		W.SetButtonText(frame.Next, won and (last and L["Play again"] or L["Next level"]) or L["Retry level"])
		status()
	end
	frame.Result.Credit:SetShown(won and last)
	frame.Result:SetShown(finished)
	frame.Hint:SetShown(not finished)
end

local function finishMotion()
	local summary = motion.summary
	motion = nil
	frame:SetScript("OnUpdate", nil)
	render(state.tiles)
	readout()
	if Board.Won(state) then
		sound("win")
	elseif state.moves == 0 then
		sound("miss")
	elseif summary then
		status(summary)
	end
end

local function advance()
	motion.index = motion.index + 1
	motion.elapsed = 0
	local step = motion.steps[motion.index]
	if not step then finishMotion(); return end
	if step.begin then step.begin() end
	step.draw(0)
end

local function animate(steps)
	motion = { steps = steps, index = 0 }
	advance()
	frame:SetScript("OnUpdate", function(_, dt)
		local step = motion.steps[motion.index]
		motion.elapsed = motion.elapsed + dt
		local progress = math.min(motion.elapsed / step.duration, 1)
		step.draw(progress)
		if progress == 1 then advance() end
	end)
end

local function swapRelics(a, b)
	local before = Board.Copy(state.tiles)
	local waves = Board.Move(state, a, b)
	-- Save the resolved board before playing any animation a close can interrupt.
	if waves then save() end
	local ax, ay = Board.Position(a)
	local bx, by = Board.Position(b)
	local dx, dy = (bx - ax) * CELL, (ay - by) * CELL
	local function slide(progress)
		place(slots[a], dx * progress, dy * progress, 1, CELL - 2)
		place(slots[b], -dx * progress, -dy * progress, 1, CELL - 2)
	end
	status()
	local steps = { { duration = 0.12, draw = slide } }
	if not waves then
		steps[2] = { duration = 0.14, draw = function(t) slide(1 - t) end, begin = function()
			status(L["Line up at least three matching relics."])
			sound("miss")
		end }
		animate(steps)
		return
	end

	before[a], before[b] = before[b], before[a]
	for depth, wave in ipairs(waves) do
		local prior, stage, chain = before, wave, depth
		local _, created = next(stage.created)
		local power = stage.triggered or created
		steps[#steps + 1] = { duration = power and 0.30 or 0.19, begin = function()
			render(prior)
			sound(power and "bonus" or "match")
			if power then
				local message = stage.triggered and L["%s activated!"] or L["%s created. Swap the marked relic to activate it."]
				motion.summary = message:format(bonusName[power])
				status(motion.summary)
			elseif chain > 1 then
				status(L["Cascade x%d   +%d"]:format(math.min(chain, 5), stage.points))
			else
				status(("+%d"):format(stage.points))
			end
		end, draw = function(t)
			for pos in pairs(stage.cleared) do
				local slot = slots[pos]
				place(slot, 0, 0, 1 - t, CELL - 2 - t * 14)
				slot.Flash:SetAlpha(math.sin(t * math.pi) * (stage.triggered and 0.95 or 0.65))
			end
			for pos, kind in pairs(stage.created) do
				local slot = slots[pos]
				showBonus(slot.Badge, kind)
				slot.Flash:SetAlpha(math.sin(t * math.pi) * 0.9)
			end
		end }
		steps[#steps + 1] = { duration = 0.22, begin = function()
			render(stage.tiles)
		end, draw = function(t)
			for pos, rows in pairs(stage.drops) do
				place(slots[pos], 0, rows * CELL * (1 - t * t), 1, CELL - 2)
			end
		end }
		before = wave.tiles
	end
	if waves.shuffled then
		steps[#steps + 1] = { duration = 0.32, begin = function()
			render(state.tiles)
			status(L["No moves left on the board. Relics reshuffled."])
		end, draw = function(t)
			for _, slot in ipairs(slots) do slot.Icon:SetAlpha(t) end
		end }
	end
	animate(steps)
end

local function click(i)
	if motion or state.moves == 0 or Board.Won(state) then return end
	if selected == i then
		selectTile(nil)
	elseif selected and Board.Adjacent(selected, i) then
		local first = selected
		selectTile(nil)
		swapRelics(first, i)
	else
		selectTile(i)
	end
end

-- A fight with the window open (on the ground as on a flight): saved and put away.
local function onCombat()
	if SkyJewels.Close() then
		ns.Print(L["Sky Jewels paused for combat. Type %s to continue."]:format(SkyJewels.command))
	end
end

local function build()
	local W, Theme = ns.Widgets, ns.Theme
	local f = CreateFrame("Frame", "PolestarSkyJewels", ns.UIParent)
	f:SetSize(504, 426)
	f:SetPoint("CENTER", UIParent, "CENTER", 0, 30)
	f:SetFrameStrata("DIALOG")
	f:SetToplevel(true)
	f:SetClampedToScreen(true)
	f:SetMovable(true)
	f:EnableMouse(true)
	f:Hide()
	f.psBgAlpha = 1
	Theme.Skin(f, "window")
	f.ZoneArt = f:CreateTexture(nil, "BACKGROUND", nil, 4)
	f.ZoneArt:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -4)
	f.ZoneArt:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -4, 4)
	f.ZoneArt:SetAlpha(0.32)
	ns.CloseOnEscape("PolestarSkyJewels")
	f:SetScript("OnHide", function(self)
		ns.UnregisterEvent("PLAYER_REGEN_DISABLED", onCombat)
		motion = nil
		self:SetScript("OnUpdate", nil)
		selectTile(nil)
		stopSound()
	end)
	f:SetScript("OnShow", function()
		if ns.Compat.InCombat() then onCombat(); return end
		ns.RegisterEvent("PLAYER_REGEN_DISABLED", onCombat)
		status()
		render(state.tiles)
		readout()
	end)

	local function label(role, color, x, y, text)
		local t = W.Text(f, role, color)
		t:SetPoint("TOPLEFT", f, "TOPLEFT", x, -y)
		t:SetJustifyH("LEFT")
		if text then t:SetText(text) end
		return t
	end

	local header = CreateFrame("Frame", nil, f)
	header:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
	header:SetPoint("TOPRIGHT", f, "TOPRIGHT", -120, -2)
	header:SetHeight(62)
	ns.DragWindow(header, f)
	label("title", "title", 16, 12, SkyJewels.title)
	f.Zone = label("note", "text", SIDEBAR_X, 37)
	f.Zone:SetWidth(SIDE)
	f.Zone:SetWordWrap(false)
	local instructions = label("note", "textDim", 16, 37, L["Swap adjacent relics to line up three."])
	instructions:SetPoint("TOPRIGHT", f.Zone, "TOPLEFT", -8, 0)
	instructions:SetWordWrap(false)
	local close = W.IconButton(f, "close", 24, L["Close"], function() SkyJewels.Close() end)
	close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -12, -9)
	local mute = W.Button(f, "", function(self)
		local s = ns.CharState()
		s.skyJewelsMuted = not s.skyJewelsMuted
		W.SetButtonText(self, s.skyJewelsMuted and L["Sound off"] or L["Sound on"])
		stopSound()
	end, { height = 23 })
	mute:SetPoint("RIGHT", close, "LEFT", -6, 0)
	f.Mute = mute

	local board = CreateFrame("Frame", nil, f)
	board:SetSize(Board.size * CELL, Board.size * CELL)
	board:SetPoint("TOPLEFT", f, "TOPLEFT", 16, -65)
	if board.SetClipsChildren then board:SetClipsChildren(true) end
	W.Color(W.Fill(board, "shade"), "shade", 0.40)
	local pieces = CreateFrame("Frame", nil, board)
	pieces:SetAllPoints(board)
	pieces:SetFrameLevel(board:GetFrameLevel() + 2)
	slots = {}
	for i = 1, Board.count do
		local x, y = Board.Position(i)
		local slot = CreateFrame("Button", nil, board)
		slot:SetPoint("TOPLEFT", board, "TOPLEFT", (x - 1) * CELL, -(y - 1) * CELL)
		slot:SetSize(CELL, CELL)
		local cell = W.Tex(slot, "BACKGROUND")
		W.Color(cell, (x + y) % 2 == 0 and "panel" or "panelAlt", 0.50)
		cell:SetPoint("TOPLEFT", slot, "TOPLEFT", 1, -1)
		cell:SetPoint("BOTTOMRIGHT", slot, "BOTTOMRIGHT", -1, 1)
		local hover = W.Tex(slot, "HIGHLIGHT", nil, "hover")
		hover:SetAllPoints(cell)
		slot.Selected = W.Tex(slot, "ARTWORK", nil, "accentLine")
		slot.Selected:SetAllPoints(cell)
		slot.Selected:Hide()
		slot.Flash = W.Tex(slot, "OVERLAY")
		slot.Flash:SetAllPoints(cell)
		slot.Flash:SetAlpha(0)
		W.Painter(slot.Flash, function(tex)
			local r, g, b = Theme.Color("accent")
			tex:SetVertexColor(r, g, b, tex:GetAlpha())
		end)
		slot.Icon = pieces:CreateTexture(nil, "ARTWORK")
		local badge = CreateFrame("Frame", nil, pieces)
		badge:SetSize(16, 16)
		badge:SetPoint("BOTTOMRIGHT", slot.Icon, "BOTTOMRIGHT", -2, 2)
		W.Fill(badge, "accent")
		local inset = W.Tex(badge, "BORDER", nil, "onAccent")
		inset:SetPoint("TOPLEFT", badge, "TOPLEFT", 1, -1)
		inset:SetPoint("BOTTOMRIGHT", badge, "BOTTOMRIGHT", -1, 1)
		badge.Horizontal = W.Tex(badge, "ARTWORK", nil, "accent")
		badge.Horizontal:SetSize(10, 2)
		badge.Horizontal:SetPoint("CENTER")
		badge.Vertical = W.Tex(badge, "ARTWORK", nil, "accent")
		badge.Vertical:SetSize(2, 10)
		badge.Vertical:SetPoint("CENTER")
		slot.Badge = badge
		local square = i
		slot:SetScript("OnClick", function() click(square) end)
		slots[i] = slot
	end

	local x = SIDEBAR_X
	f.Level = label("heading", "accent", x, 69)
	f.Moves = label("body", "text", x, 94)
	label("note", "textDim", x, 128, L["Score"])
	f.Score = label("title", "text", x, 145)
	local progress = W.Tex(f, "ARTWORK", nil, "track")
	progress:SetPoint("TOPLEFT", f, "TOPLEFT", x, -171)
	progress:SetSize(SIDE, 5)
	f.Fill = W.Tex(f, "OVERLAY", nil, "accent")
	f.Fill:SetPoint("TOPLEFT", progress, "TOPLEFT")
	f.Fill:SetHeight(5)
	f.GoalIcon = f:CreateTexture(nil, "ARTWORK")
	f.GoalIcon:SetPoint("TOPLEFT", f, "TOPLEFT", x - 2, -188)
	f.GoalIcon:SetSize(29, 29)
	f.Goal = label("body", "text", x + 31, 196)
	f.BonusGoal = label("note", "text", x, 225)

	f.Hint = label("note", "textDim", x, 253, L["4 in a line: sweep\n5, T or L: burst\nSwap a bonus to fire it."])
	f.Hint:SetWidth(SIDE)
	f.Hint:SetWordWrap(true)
	local result = CreateFrame("Frame", nil, board)
	result:SetAllPoints(board)
	result:SetFrameLevel(pieces:GetFrameLevel() + 3)
	result:EnableMouse(true)
	result:Hide()
	W.Color(W.Fill(result, "panel"), "panel", 0.96)
	result.Title = W.Text(result, "display", "title")
	result.Title:SetWidth(Board.size * CELL - 32)
	result.Title:SetJustifyH("CENTER")
	result.Title:SetWordWrap(true)
	result.Title:SetPoint("BOTTOM", result, "CENTER", 0, 10)
	f.Result = result
	f.Next = W.Button(result, "", function()
		local level = state.level
		if Board.Won(state) then level = level % #Board.levels + 1 end
		start(level)
	end, { primary = true, height = 32 })
	f.Next:SetPoint("TOP", result, "CENTER", 0, -3)
	result.Credit = W.Text(result, "note", "textDim")
	result.Credit:SetPoint("TOP", f.Next, "BOTTOM", 0, -12)
	result.Credit:SetJustifyH("CENTER")
	result.Credit:SetText(L["by %s"]:format("RikyZ90"))
	f.Status = label("note", "textDim", 16, 397)
	f.Status:SetPoint("RIGHT", f, "RIGHT", -16, 0)
	f.Status:SetWordWrap(false)
	return f
end

function SkyJewels.IsOpen() return frame and frame:IsShown() or false end

function SkyJewels.Open()
	if ns.Compat.InCombat() then return false end
	if SkyJewels.IsOpen() then return true end
	if not frame then frame = build() end
	local player = ns.CharState()
	state = player.skyJewels
	if not Board.Valid(state) then
		local level = type(state) == "table" and state.level
		start(type(level) == "number" and Board.levels[level] and level or 1)
	end
	ns.Widgets.SetButtonText(frame.Mute, player.skyJewelsMuted and L["Sound off"] or L["Sound on"])
	frame:Show()
	return SkyJewels.IsOpen()
end

-- saveAndPause: every move is saved as it settles, so closing is all there is to it.
function SkyJewels.Close()
	if not SkyJewels.IsOpen() then return false end
	frame:Hide()
	return true
end

ns.Arcade.Register("skyjewels", SkyJewels)
