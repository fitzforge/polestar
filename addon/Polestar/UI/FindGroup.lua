-- "Find a group": the guide window's link that opens the game's Group Finder
-- before a chosen dungeon's run (UI/GuideFrameBanner.lua, the start-looking
-- line). The Group Finder must be opened by the game's own code: opened or
-- set to a dungeon from an addon, its searches are refused for the rest of
-- the session. So a secure button (SecureActionButtonTemplate, type "click")
-- lies over the link and presses the game's own Group Finder micro button,
-- as a click on that button does; the player picks the dungeon there. Out of
-- combat only: it is let go before a fight's lockdown (PLAYER_REGEN_DISABLED)
-- so the guide window can still move and close in a fight, and laid again
-- after it (the window's next layout), as the rare card's Target button
-- (Rares/Toast.lua). In a fight, or without the micro button, the link's own
-- click says which key opens the Group Finder.
--
--   UI.FindGroup.Micro() -> the game's Group Finder micro button | nil
--   UI.FindGroup.Arm(link) -> true when the secure button lies over `link`
--   UI.FindGroup.Disarm()   let it go (out of combat)
--   UI.FindGroup.Armed() -> the link it lies over | nil
--   UI.FindGroup.Hint() -> "Press I for the group finder." (or without a key)

local ADDON, ns = ...
local UI, L = ns.UI, ns.L

local FG = {}
UI.FindGroup = FG

local NAME = "PolestarFindGroup"
local secure, armedOn

local function lockdown() return InCombatLockdown and InCombatLockdown() and true or false end

-- The Group Finder's micro button: the vanilla-style window's (Forever, Classic) or the newer one's.
function FG.Micro()
	local b = _G.LFGMicroButton or _G.LFDMicroButton
	if type(b) == "table" and b.Click then return b end
	return nil
end

-- What the link says when it cannot press the button itself: the player's key
-- for the Group Finder (TOGGLEGROUPFINDER), named as the client names it.
function FG.Hint()
	local key = GetBindingKey and GetBindingKey("TOGGLEGROUPFINDER")
	if key == "" then key = nil end
	local named = key and GetBindingText and GetBindingText(key)
	if type(named) == "string" and named ~= "" then key = named end
	return key and string.format(L["Press %s for the group finder."], key) or L["Open the group finder from the game's menu bar."]
end

local function build()
	local s = CreateFrame("Button", NAME, UIParent, "SecureActionButtonTemplate")
	-- As the rare card's: both press and release registered and useOnKeyDown
	-- false, so it acts once, on the release, whatever ActionButtonUseKeyDown says.
	s:RegisterForClicks("AnyUp", "AnyDown")
	s:SetAttribute("useOnKeyDown", false)
	s:SetAttribute("type", "click")
	-- The link draws it: hover reaches the link from here.
	s:SetScript("OnEnter", function()
		local link = armedOn
		if not link then return end
		if link.LockHighlight then link:LockHighlight() end
		local h = link:GetScript("OnEnter")
		if h then h(link) end
	end)
	s:SetScript("OnLeave", function()
		local link = armedOn
		if not link then return end
		if link.UnlockHighlight then link:UnlockHighlight() end
		local h = link:GetScript("OnLeave")
		if h then h(link) end
	end)
	s:Hide()
	secure = s
end

-- Lay the secure button over `link`, pressing the micro button. Out of combat
-- only; false (the link's own click then says the key) without the micro
-- button, or in a fight: then the window's layout lays it once the fight ends.
function FG.Arm(link)
	local micro = FG.Micro()
	if not (link and micro) then return false end
	if lockdown() then
		FG.waiting = true
		return false
	end
	if not secure then build() end
	-- The link hidden (another notice, the window closed): nothing to press there any more.
	if not link.psFindGroupHook then
		link.psFindGroupHook = true
		link:HookScript("OnHide", function(self) if armedOn == self then FG.Disarm() end end)
	end
	secure:SetAttribute("clickbutton", micro)
	secure:ClearAllPoints()
	secure:SetAllPoints(link)
	secure:SetFrameStrata(link:GetFrameStrata())
	secure:SetFrameLevel(link:GetFrameLevel() + 2)
	secure:Show()
	armedOn, FG.waiting = link, nil
	return true
end

function FG.Disarm()
	FG.waiting = nil
	if not secure or lockdown() then return end
	secure:Hide()
	secure:ClearAllPoints()
	armedOn = nil
end

function FG.Armed() return armedOn end

-- A fight starts: before the lockdown, let go of it. It ends: the guide window
-- lays it again while its link is still there.
ns.RegisterEvent("PLAYER_REGEN_DISABLED", function()
	local was = armedOn
	FG.Disarm()
	if was then FG.waiting = true end
end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if not FG.waiting then return end
	FG.waiting = nil
	local GF = UI.GuideFrame
	if GF and GF.Layout and GF.frame and GF.frame:IsShown() and ns.IsLoggedIn() then GF.Layout() end
end)
