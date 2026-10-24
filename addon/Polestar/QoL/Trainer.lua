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
local bought = {}         -- "name\0rank" of the spells bought this visit
local pending, pendingCost -- the purchase that has not landed yet
local learned, spent = 0, 0
local purchases = 0       -- which purchase a LAND_WAIT timer belongs to

local function keyOf(name, rank) return name and (name .. "\0" .. (rank or "")) end

-- Whether the service `key` is still listed as available.
local function stillAvailable(key)
	for i = 1, GetNumTrainerServices() do
		local name, kind, _, _, rank = GetTrainerServiceInfo(i)
		if kind == "available" and keyOf(name, rank) == key then return true end
	end
	return false
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
	if learned > 0 then
		ns.Print(format(learned == 1 and L["Learned %d spell for %s."] or L["Learned %d spells for %s."], learned, QoL.Money(spent)))
	end
	if short and short > 0 then
		ns.Print(format(L["Not enough money for %d more (%s)."], short, QoL.Money(shortCost)))
	end
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
	if not QoL.On("trainAll") or QoL.Shift() then cancel(); return end
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
		C_Timer.After(LAND_WAIT, function()
			if active and pending and purchases == this then
				pending = nil
				finish()
			end
		end)
	end
end

function Trainer.OnShow()
	active, learned, spent, pending = false, 0, 0, nil
	wipe(bought)
	if QoL.Shift() or not QoL.On("trainAll") then return end
	if not (GetNumTrainerServices and GetTrainerServiceInfo and GetTrainerServiceCost and BuyTrainerService) then return end
	if IsTradeskillTrainer and IsTradeskillTrainer() then return end
	local E = ns.Engine
	if not (E and E.IsClassTrainer and E.IsClassTrainer(ns.Compat.GetNpcID("npc"))) then return end
	active = true
	buyNext()
end

function Trainer.OnClosed()
	if active and pending then
		learned, spent = learned + 1, spent + pendingCost
		pending = nil
	end
	finish()
end

ns.RegisterEvent("TRAINER_SHOW", Trainer.OnShow)
ns.RegisterEvent("TRAINER_UPDATE", buyNext)
ns.RegisterEvent("TRAINER_CLOSED", Trainer.OnClosed)
ns.RegisterEvent("PLAYER_LOGOUT", cancel)
ns.On("SETTING_CHANGED", function(path)
	if (path == "qol.trainAll" or path == "qol" or path == "") and not QoL.On("trainAll") then cancel() end
end)
