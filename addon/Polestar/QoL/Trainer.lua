-- Class trainer: learn every spell the trainer offers now, when it opens
-- (qol.trainAll, default off; Shift skips). One purchase at a time: buying
-- brings the list back from the server (TRAINER_UPDATE) with its indexes
-- moved, so it is read again before each purchase, and a spell already bought
-- this visit is never bought again. The next purchase waits until the last
-- one has landed (its service is no longer "available"), whatever else
-- updates the list; one that has not landed after LAND_WAIT seconds was
-- refused, and ends the run. Closing the window, or stopping the run (the
-- setting off, Shift), counts a purchase still on its way: it was sent while
-- available and affordable, and is paid for whether or not the list has caught
-- up. Only "available" services you can afford
-- are bought, and only from a class trainer of your class that
-- Core/ClassTrainers.lua knows (Engine.IsClassTrainer): riding, weapon, pet
-- and profession trainers are left alone. Prints what was learned, and what
-- the rest would cost when the money ran out.
--
-- Client: IsTradeskillTrainer, GetNumTrainerServices, GetTrainerServiceInfo,
-- GetTrainerServiceCost, BuyTrainerService (Forever Blizzard_TrainerUI);
-- TRAINER_SHOW, TRAINER_UPDATE, TRAINER_CLOSED (TrainerDocumentation).

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local Client = QoL.Client

local format = string.format

local Trainer = {}
QoL.Trainer = Trainer

local LAND_WAIT = 2

local active = false
local auto = false
local bought = {}         -- "name\0rank" of the spells bought this visit
local pending, pendingCost -- the purchase that has not landed yet
local learned, spent = 0, 0
local purchases = 0       -- which purchase a LAND_WAIT timer belongs to
local trainerButton
local updateTrainerButton

local function keyOf(name, rank) return name and (name .. "\0" .. (rank or "")) end

-- Whether the service `key` is still listed as available.
local function stillAvailable(key)
	for i = 1, GetNumTrainerServices() do
		local name, kind, _, _, rank = GetTrainerServiceInfo(i)
		if kind == "available" and keyOf(name, rank) == key then return true end
	end
	return false
end

local function isClassTrainer()
	if not (GetNumTrainerServices and GetTrainerServiceInfo and GetTrainerServiceCost and BuyTrainerService) then return false end
	if IsTradeskillTrainer and IsTradeskillTrainer() then return false end
	if ClassTrainerFrame and ClassTrainerFrame.trainingPoints and ClassTrainerFrame.trainingPoints:IsShown() then return false end
	local E = ns.Engine
	return not not (E and E.IsClassTrainer and E.IsClassTrainer(ns.Compat.GetNpcID("npc")))
end

-- The first service that can be learned now and that `money` covers:
-- index, key, cost; then how many more could be learned and what they cost.
function Trainer.Next(money)
	local index, key, cost
	local short, shortCost = 0, 0
	for i = 1, GetNumTrainerServices() do
		local name, kind, _, _, rank = GetTrainerServiceInfo(i)
		local k = keyOf(name, rank)
		if kind == "available" and k and not bought[k] then
			local c = GetTrainerServiceCost(i) or 0
			if not index and c <= money then
				index, key, cost = i, k, c
			else
				short, shortCost = short + 1, shortCost + c
			end
		end
	end
	return index, key, cost, short, shortCost
end

local function finish(short, shortCost)
	if not active then return end
	active = false
	auto = false
	if learned > 0 then
		ns.Print(format(learned == 1 and L["Learned %d spell for %s."] or L["Learned %d spells for %s."], learned, QoL.Money(spent)))
	end
	if short and short > 0 then
		ns.Print(format(L["Not enough money for %d more (%s)."], short, QoL.Money(shortCost)))
	end
	if updateTrainerButton then updateTrainerButton() end
end

local function cancel()
	purchases = purchases + 1
	-- A purchase on its way was sent while available and affordable: it
	-- lands and is paid for, so it counts in the summary (as on close).
	if active and pending then
		learned, spent = learned + 1, spent + pendingCost
	end
	pending = nil
	finish()
end

local function buyNext()
	if not active then return end
	if QoL.Shift() then cancel(); return end
	if pending then
		if stillAvailable(pending) then return end
		learned, spent = learned + 1, spent + pendingCost
		pending = nil
	end
	local index, key, cost, short, shortCost = Trainer.Next(Client.Money())
	if not index then return finish(short, shortCost) end
	bought[key] = true
	pending, pendingCost = key, cost
	purchases = purchases + 1
	local this = purchases
	BuyTrainerService(index)
	if C_Timer and C_Timer.After then
		ns.After(LAND_WAIT, function()
			if active and pending and purchases == this then
				pending = nil
				finish()
			end
		end)
	end
end

function Trainer.Start(fromAuto)
	if active then return end
	if not isClassTrainer() then return end
	active = true
	auto = not not fromAuto
	if updateTrainerButton then updateTrainerButton() end
	buyNext()
end

-- The Train All button on the trainer window; not while Polestar is hidden
-- (POLESTAR_HIDDEN puts it back).
updateTrainerButton = function()
	if not trainerButton or not ClassTrainerFrame then return end
	if not QoL.On("trainAllButton") or not isClassTrainer() or ns.Hidden() then
		trainerButton:Hide()
		return
	end
	trainerButton:Show()
	local availableCount = 0
	for i = 1, (GetNumTrainerServices and GetNumTrainerServices() or 0) do
		local _, kind = GetTrainerServiceInfo(i)
		if kind == "available" then
			availableCount = availableCount + 1
		end
	end
	trainerButton:SetEnabled(availableCount > 0 and not active)
end

local function initTrainerButton()
	if not ClassTrainerFrame or trainerButton then return end
	local btn = ns.CreateFrameUnder("Button", "PolestarTrainAllButton", ClassTrainerFrame, "UIPanelButtonTemplate")
	btn:SetSize(80, 22)
	if ClassTrainerTrainButton then
		btn:SetPoint("RIGHT", ClassTrainerTrainButton, "LEFT", -2, 0)
	else
		btn:SetPoint("BOTTOMRIGHT", ClassTrainerFrame, "BOTTOMRIGHT", -120, 54)
	end
	btn:SetText(L["Train All"])

	btn:SetScript("OnEnter", function(self)
		local count, cost = 0, 0
		for i = 1, (GetNumTrainerServices and GetNumTrainerServices() or 0) do
			local _, kind = GetTrainerServiceInfo(i)
			if kind == "available" then
				count = count + 1
				cost = cost + (GetTrainerServiceCost(i) or 0)
			end
		end
		if count > 0 then
			GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 4)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(format(count == 1 and L["Train %d skill for %s"] or L["Train %d skills for %s"], count, QoL.Money(cost)))
			GameTooltip:Show()
		end
	end)

	btn:SetScript("OnLeave", function()
		if GameTooltip then GameTooltip:Hide() end
	end)

	btn:SetScript("OnClick", function()
		if not active then
			Trainer.Start()
		end
	end)

	if hooksecurefunc and ClassTrainerFrame_Update then
		hooksecurefunc("ClassTrainerFrame_Update", updateTrainerButton)
	end

	trainerButton = btn
	updateTrainerButton()
end

function Trainer.OnShow()
	initTrainerButton()
	updateTrainerButton()
	active, learned, spent, pending, auto = false, 0, 0, nil, false
	wipe(bought)
	if QoL.Shift() or not QoL.On("trainAll") then return end
	Trainer.Start(true)
end

function Trainer.OnClosed()
	if active and pending then
		learned, spent = learned + 1, spent + pendingCost
		pending = nil
	end
	finish()
	if trainerButton then trainerButton:Hide() end
end

ns.RegisterEvent("ADDON_LOADED", function(_, name)
	if name == "Blizzard_TrainerUI" then
		initTrainerButton()
	end
end)
ns.RegisterEvent("TRAINER_SHOW", Trainer.OnShow)
ns.RegisterEvent("TRAINER_UPDATE", function()
	updateTrainerButton()
	buyNext()
end)
ns.RegisterEvent("TRAINER_CLOSED", Trainer.OnClosed)
ns.RegisterEvent("PLAYER_LOGOUT", cancel)
ns.On("SETTING_CHANGED", function(path)
	if (path == "qol.trainAll" or path == "qol" or path == "") and not QoL.On("trainAll") and auto then cancel() end
	if path == "qol.trainAllButton" or path == "qol" or path == "" then updateTrainerButton() end
end)
ns.On("POLESTAR_HIDDEN", function() updateTrainerButton() end)

initTrainerButton()
