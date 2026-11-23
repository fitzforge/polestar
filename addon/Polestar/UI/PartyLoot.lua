-- Loot a party member still needs: on a loot window or a loot roll holding
-- a quest item a member's counts are short of while you need none
-- (Quests/Party.lua, Party.ItemNeeds), a short line under it: "Boar Ribs:
-- For Ana: she still needs 2". Only words on screen: nothing is passed,
-- rolled or said in chat for you. Listens only while party sync does
-- (PARTY_LIVE) and party.lootNeeds is on.

local ADDON, ns = ...
local UI, W = ns.UI, ns.Widgets
local L = ns.L

local PL = {}
UI.PartyLoot = PL

local PAD = 8
local DOT = "  \194\183  "

local F
local looted = {} -- the open loot window's lines
local rolls = {} -- roll id -> its lines

local function itemOf(link)
	if type(link) ~= "string" then return nil end
	return tonumber(link:match("item:(%d+)")), link:match("%[(.-)%]")
end

-- The lines for one item link: "<name>: For Ana: she still needs 2", one per
-- member who needs it.
function PL.LinesFor(link)
	local id, name = itemOf(link)
	local P = ns.Party
	if not (id and P and P.ItemNeeds) then return {} end
	local out = {}
	for _, e in ipairs(P.ItemNeeds(id)) do
		local text = P.NeedText(e)
		out[#out + 1] = name and (name .. DOT .. text) or text
	end
	return out
end

-- Every line shown now: the loot window's, then each roll's.
function PL.Lines()
	local out = {}
	for _, line in ipairs(looted) do out[#out + 1] = line end
	local ids = {}
	for id in pairs(rolls) do ids[#ids + 1] = id end
	table.sort(ids)
	for _, id in ipairs(ids) do
		for _, line in ipairs(rolls[id]) do out[#out + 1] = line end
	end
	return out
end

local function anchor()
	local loot = LootFrame and LootFrame.IsShown and LootFrame:IsShown() and LootFrame
	local roll = GroupLootContainer and GroupLootContainer.IsShown and GroupLootContainer:IsShown() and GroupLootContainer
	local at = (#looted > 0 and loot) or (next(rolls) and roll) or loot or roll
	F:ClearAllPoints()
	if at then
		F:SetPoint("TOPLEFT", at, "BOTTOMLEFT", 0, -4)
	else
		F:SetPoint("TOP", UIParent, "TOP", 0, -160)
	end
end

local function paint()
	local lines = PL.Lines()
	if #lines == 0 then
		if F then F:Hide() end
		return
	end
	if not F then
		F = CreateFrame("Frame", "PolestarLootNeeds", ns.UIParent)
		F:SetFrameStrata("HIGH")
		F:SetClampedToScreen(true)
		if ns.Theme and ns.Theme.Skin then ns.Theme.Skin(F, "panel") end
		F.Text = W.Text(F, "small", "text")
		F.Text:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -PAD)
		F.Text:SetJustifyH("LEFT")
	end
	F.Text:SetText(table.concat(lines, "\n"))
	F:SetSize(math.floor(F.Text:GetStringWidth() + PAD * 2 + 0.5), math.floor(F.Text:GetStringHeight() + PAD * 2 + 0.5))
	anchor()
	F:Show()
end

function PL.Frame() return F end

local function onLoot()
	looted = {}
	local n = GetNumLootItems and GetNumLootItems() or 0
	for slot = 1, n do
		for _, line in ipairs(PL.LinesFor(GetLootSlotLink and GetLootSlotLink(slot))) do looted[#looted + 1] = line end
	end
	paint()
end

local function onLootClosed()
	looted = {}
	paint()
end

local function onRoll(_, rollID, rollTime)
	if not rollID then return end
	local lines = PL.LinesFor(GetLootRollItemLink and GetLootRollItemLink(rollID))
	rolls[rollID] = #lines > 0 and lines or nil
	paint()
	-- The roll ends by itself when its time runs out (milliseconds).
	if rolls[rollID] and C_Timer then
		ns.After((tonumber(rollTime) or 60000) / 1000 + 1, function()
			if rolls[rollID] then
				rolls[rollID] = nil
				paint()
			end
		end)
	end
end

local function onRollGone(_, rollID)
	if rollID and rolls[rollID] then
		rolls[rollID] = nil
		paint()
	end
end

local function want(event, on, fn)
	if on then ns.RegisterEvent(event, fn) else ns.UnregisterEvent(event, fn) end
end

-- Listen only while party sync does and the setting is on.
function PL.Sync()
	local P = ns.Party
	local on = P and P.IsLive and P.IsLive() and ns.Get("party.show") and ns.Get("party.lootNeeds") and true or false
	want("LOOT_OPENED", on, onLoot)
	want("LOOT_CLOSED", on, onLootClosed)
	want("START_LOOT_ROLL", on, onRoll)
	want("CANCEL_LOOT_ROLL", on, onRollGone)
	if not on then
		looted, rolls = {}, {}
		paint()
	end
end

ns.On("PARTY_LIVE", PL.Sync)
ns.On("SETTING_CHANGED", function(path)
	if path == "" or path == "party" or path == "party.lootNeeds" or path == "party.show" then PL.Sync() end
end)
