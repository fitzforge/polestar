local _, ns = ...
local Skin = ns.UI.TrackerDock

local function Number(value)
	if issecretvalue and issecretvalue(value) then return nil end
	if type(value) == "number" and value == value and math.abs(value) < math.huge then return value end
end
local function Read(frame, method)
	if not frame or not frame[method] then return nil end
	local ok, value = pcall(frame[method], frame)
	if ok then return Number(value) end
end
local function Scale(frame)
	local scale = Read(frame, "GetEffectiveScale")
	return scale and scale > 0 and scale or 1
end

-- The usable tracker height, in holder coordinates.
function Skin.DockAvailableHeight(holder, tracker, customTracker)
	-- Normalize rects to the UIParent-owned holder's units before subtracting.
	-- The guide itself has an additional scale to fit the dock's width.
	local holderScale = Scale(holder)
	local top = Read(holder, "GetTop")
	local bottom
	if tracker == _G.Questie_BaseFrame then
		local profile = _G.Questie and Questie.db and Questie.db.profile
		local limit = profile and Number(profile.TrackerHeight)
		if profile and (not limit or limit <= 0) then
			local screenHeight = GetScreenHeight and Number(GetScreenHeight()) or Read(UIParent, "GetHeight")
			limit = screenHeight and screenHeight * (Number(profile.trackerHeightRatio) or 0.5)
		end
		local trackerTop = Read(tracker, "GetTop")
		if trackerTop and limit and limit > 0 then
			bottom = (trackerTop - limit) * Scale(tracker) / holderScale
		end
	end
	if customTracker then
		local eqt = _G.EllesmereUIQuestTracker
		local cfg = eqt and eqt.DB and eqt.DB()
		local maxHeight = cfg and Number(cfg.customMaxHeight)
		local trackerTop = Read(tracker, "GetTop")
		if trackerTop and maxHeight and maxHeight > 0 then
			-- The custom frame shrinks to its quests, so GetBottom would cap
			-- the guide at today's short quest list instead of the configured limit.
			bottom = (trackerTop - maxHeight) * Scale(tracker) / holderScale
		end
	end
	if not bottom then
		-- Blizzard's container height is the Edit Mode maximum, unlike its
		-- content-sized skin/background. This is the boundary MidnightChores uses.
		local container = tracker == _G.Questie_BaseFrame and tracker or _G.ObjectiveTrackerFrame or tracker
		local rawBottom = Read(container, "GetBottom")
		if rawBottom then bottom = rawBottom * Scale(container) / holderScale end
	end
	local available
	if top and bottom then available = top - bottom - 4 end
	-- Never grow beyond the visible screen, including a dock placed near its foot.
	if top then
		local screenRoom = top - 4 * Scale(UIParent) / holderScale
		if screenRoom > 0 then available = available and math.min(available, screenRoom) or screenRoom end
	end
	return available
end
