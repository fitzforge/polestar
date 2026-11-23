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

ns.OnLogin(function()
	if ns.GamepadUI() or not (Menu and Menu.ModifyMenu) then return end
	Menu.ModifyMenu("MENU_QUEST_MAP_LOG_TITLE", function(owner, root)
		add(root, questID(owner and owner.questID))
	end)
	Menu.ModifyMenu("MENU_QUEST_OBJECTIVE_TRACKER", function(_, root)
		add(root, trackerQuest())
	end)
end)
