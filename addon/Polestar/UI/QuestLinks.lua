-- Quest menus open the guide search without changing the active guide.
-- Forever's MENU_QUEST_MAP_LOG_TITLE owns questID; the tracker menu owns
-- a container, so resolve its block before the menu takes the mouse focus.
local ADDON, ns = ...
local UI, L = ns.UI, ns.L
local readable = ns.Compat.Readable

local function questID(value)
	value = readable(value)
	if type(value) == "number" and value > 0 and value < math.huge and value % 1 == 0 then return value end
end

local function trackerQuest()
	if not GetMouseFoci then return end
	for _, focus in ipairs(GetMouseFoci()) do
		local frame = focus
		while frame do
			if frame.IsForbidden and frame:IsForbidden() then break end
			local module = frame.parentModule
			if module and (module == QuestObjectiveTracker or module == CampaignQuestObjectiveTracker) then
				local id = questID(frame.id)
				if id and module.GetExistingBlock and module:GetExistingBlock(id) == frame then return id end
			end
			frame = frame.GetParent and frame:GetParent()
		end
	end
end

-- No Polestar entry while Polestar is hidden.
local function add(root, id)
	if not id or ns.Hidden() then return end
	root:QueueDivider()
	root:CreateButton(L["Polestar"] .. ": " .. L["Show in Guides"], function()
		UI.Picker.ShowQuest(id)
	end)
end

local function setupDetails()
	local details = QuestMapFrame and QuestMapFrame.DetailsFrame
	if not details or not QuestMapFrame_ShowQuestDetails or not MenuUtil or not MenuUtil.CreateContextMenu then return end
	local header = details.BackFrame or details
	local icon = "Interface\\AddOns\\" .. ADDON .. "\\Media\\UI\\logo"
	local spoken = _G.Spoken
	local button = spoken and spoken.CreateRoundButton and spoken:CreateRoundButton(header, "icon", nil, icon)
	if not button then
		button = CreateFrame("Button", nil, header)
		button:SetSize(26, 26)
		local image = button:CreateTexture(nil, "ARTWORK")
		image:SetPoint("CENTER")
		image:SetSize(20, 20)
		image:SetTexture(icon)
		local mask = button:CreateMaskTexture()
		mask:SetAllPoints(image)
		mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
		image:AddMaskTexture(mask)
		button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
	end
	button:HookScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:SetText(L["Polestar"])
		GameTooltip:Show()
	end)
	button:HookScript("OnLeave", function() GameTooltip:Hide() end)
	button:SetFrameLevel(header:GetFrameLevel() + 3)
	local function selectedQuest()
		return questID(details.questID) or questID(C_QuestLog and C_QuestLog.GetSelectedQuest and C_QuestLog.GetSelectedQuest())
	end
	local function refresh()
		local spoken = _G.VoiceOver
		local compendium = spoken and spoken.QuestsTab and spoken.QuestsTab.mapButton
		local overlay = spoken and spoken.QuestOverlayUI
		local beside = compendium and compendium:IsShown() and compendium
		if not beside and overlay then
			for _, key in ipairs({ "detailsPlayButton", "detailsContributeButton", "detailsReportButton" }) do
				if overlay[key] and overlay[key]:IsShown() then
					beside = overlay[key]
					break
				end
			end
		end
		beside = beside or header.BackButton
		button:ClearAllPoints()
		if beside then
			button:SetPoint("RIGHT", beside, "LEFT", -4, 0)
		else
			button:SetPoint("TOPRIGHT", header, "TOPRIGHT", -12, -2)
		end
		button:SetShown(details:IsShown() and selectedQuest() ~= nil and not ns.Hidden())
	end
	button:SetScript("OnClick", function(self)
		local id = selectedQuest()
		if not id or ns.Hidden() then return end
		MenuUtil.CreateContextMenu(self, function(_, root)
			add(root, id)
		end)
	end)
	hooksecurefunc("QuestMapFrame_ShowQuestDetails", function()
		C_Timer.After(0, refresh)
	end)
	refresh()
end

ns.OnLogin(function()
	if ns.GamepadUI() or not (Menu and Menu.ModifyMenu) then return end
	Menu.ModifyMenu("MENU_QUEST_MAP_LOG_TITLE", function(owner, root)
		add(root, questID(owner and owner.questID))
	end)
	Menu.ModifyMenu("MENU_QUEST_OBJECTIVE_TRACKER", function(_, root)
		add(root, trackerQuest())
	end)
	setupDetails()
end)
