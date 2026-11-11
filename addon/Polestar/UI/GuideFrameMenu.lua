-- The guide window's menu and its Nearby services button (UI/GuideFrame.lua).

local ADDON, ns = ...
local UI, W, L = ns.UI, ns.Widgets, ns.L
local GF = UI.GuideFrame
local Engine, compact, transparent, tabsOf = GF.Engine, GF.Compact, GF.Transparent, GF.TabsOf

---------------------------------------------------------------------------
-- Menu
---------------------------------------------------------------------------

local function openMenu(button)
	if W.MenuShown(button) then return W.HideMenu() end
	local E = Engine()
	local hasGuide = E and E.GetGuide and E.GetGuide()
	local clear = transparent()
	local items = {
		{ text = L["Choose guide"], icon = "search", onClick = function() UI.ShowPicker() end },
		{ text = L["Open in new tab"], icon = "plus", disabled = not (E and E.OpenTab), onClick = function() UI.ShowPicker({ newTab = true }) end },
		-- No step on screen (a finished guide): nothing to skip, as with the navigator's Skip.
		{ text = L["Skip this step"], icon = "skip", disabled = not (hasGuide and E.GetStepIndex and E.GetStepIndex()), onClick = function() GF.SkipStep() end },
		{ text = L["Report a problem"], icon = "bug", onClick = function() UI.ShowReport() end },
		{ separator = true },
	}
	-- Pin the shown step's quests in the log as along the way, or unpin them (#644).
	local pins = GF.PinItems(GF.View())
	for _, it in ipairs(pins) do items[#items + 1] = it end
	if #pins > 0 then items[#items + 1] = { separator = true } end
	-- The quest log cleanup (UI/QuestRoom.lua), while it has quests to list.
	local unneeded = ns.RoutePlan and ns.RoutePlan.Unneeded() or nil
	if unneeded and #unneeded > 0 then
		table.insert(items, 5, { text = L["Clean up quest log (%d)"]:format(#unneeded), icon = "cross", onClick = function() UI.ShowQuestRoom() end })
	end
	for _, it in ipairs({
		{ text = L["Compact mode"], icon = "compact", checked = compact(), onClick = function() ns.Set("ui.compact", not compact()) end },
		{ text = L["Transparent"], icon = "layers", checked = clear, onClick = function() ns.Set("ui.style", clear and "standard" or "transparent") end },
		{ text = L["Lock window"], icon = "lock", checked = ns.Get("ui.locked") and true or false, onClick = function() ns.Set("ui.locked", not ns.Get("ui.locked")) end },
		{ separator = true },
		{ text = L["Reset guide progress"], icon = "reset", confirm = true, disabled = not hasGuide, tip = L["Clears your manual check-offs and skipped steps for this guide."],
			onClick = function() if E and E.ResetProgress then E.ResetProgress() end end },
		{ text = L["Options"], icon = "gear", onClick = function() UI.ShowOptions() end },
		{ text = L["Hide window"], icon = "close", onClick = function()
			ns.Set("ui.shown", false)
			ns.Print(L["Guide window hidden. Type /polestar to bring it back."])
		end },
	}) do items[#items + 1] = it end
	-- The Recorder's window, while the Recorder addon is loaded.
	if type(PolestarRecorder_Command) == "function" then
		table.insert(items, 5, { text = L["Recorder window"], icon = "record", onClick = function() PolestarRecorder_Command("ui") end })
	end
	local reopen = GF.ReopenItem()
	if reopen then table.insert(items, 3, reopen) end
	-- The few settings changed mid-play (UI/QuickSettings.lua), by the button, just before Options.
	if UI.QuickSettings then
		for i, it in ipairs(items) do
			if it.icon == "gear" then
				table.insert(items, i, { text = L["Quick settings"], icon = "sliders", onClick = function() UI.QuickSettings.Show(button) end })
				break
			end
		end
	end
	W.ShowMenu(button, items)
end

-- "Reopen closed tab", the last tab closed (Engine.ClosedTabs) back as it
-- was, for the window's menu and the tab strip's: nil with none closed.
function GF.ReopenItem()
	local E = Engine()
	local list = E and E.ClosedTabs and E.ClosedTabs()
	local last = list and list[1]
	if not last then return nil end
	local tabs = tabsOf(E) or {}
	return { text = L["Reopen closed tab"], icon = "reset", tip = last.title, disabled = #tabs >= (E.MAX_TABS or 6),
		onClick = function() E.ReopenClosedTab() end }
end

-- Menu entries pinning the quests of step view `v` that are in the log with
-- objectives open as along the way, or unpinning those pinned (#644).
function GF.PinItems(v)
	local E, C, out, seen = Engine(), ns.Compat, {}, {}
	if not (v and v.goals and E and E.PinQuest) then return out end
	for _, gv in ipairs(v.goals) do
		local q = gv.quest
		if q and not seen[q] and C.IsOnQuest(q) and (E.IsPinned(q) or not C.IsQuestReadyForTurnIn(q)) then
			seen[q] = true
			local title = ns.Quoted(C.GetQuestTitle(q) or (L["Quest"] .. " " .. q))
			local pinned = E.IsPinned(q)
			out[#out + 1] = { text = string.format(pinned and L["Unpin %s"] or L["Pin %s as along the way"], title), icon = "pin",
				checked = pinned, onClick = function() E.PinQuest(q, not pinned) end }
		end
	end
	return out
end

-- The quest log's menu on a quest (right-click its title): pin it as along
-- the way, or unpin it (#644). Not with the gamepad interface (ns.GamepadUI),
-- as Nav/Nearby.lua's map menus.
ns.OnLogin(function()
	if ns.GamepadUI() or not (Menu and Menu.ModifyMenu) then return end
	Menu.ModifyMenu("MENU_QUEST_MAP_LOG_TITLE", function(owner, root)
		local q = owner and owner.questID
		local E = Engine()
		if type(q) ~= "number" or not (E and E.PinQuest) then return end
		local pinned = E.IsPinned(q)
		root:CreateDivider()
		root:CreateButton(pinned and L["Unpin from along the way"] or L["Pin as along the way"], function() E.PinQuest(q, not pinned) end)
	end)
end)

-- Nearby services (Nav/Nearby.lua): the nearest vendor, repair, inn, flight
-- master or trainer, as the arrow's target. Looked up after combat only.
local openNearby

-- The weapon master's page of the menu: the weapons to learn, each to the
-- nearest master who teaches it; a weapon already known, or not yet at this
-- level, says so and is off. Back returns to the services.
local function openWeapons(button, entry)
	local Nearby = ns.Nav.nearby
	local fight = InCombatLockdown and InCombatLockdown()
	local items = {
		{ text = L["Back"], icon = "chevron-left", onClick = function() openNearby(button) end },
		{ separator = true },
	}
	for _, w in ipairs(entry.weapons) do
		local text, off = w.label, fight
		if w.known then
			text, off = string.format(L["%s (known)"], w.label), true
		elseif w.level then
			text, off = string.format(L["%s (from level %d)"], w.label, w.level), true
		end
		local line = w.line
		items[#items + 1] = { text = text, disabled = off, onClick = function() Nearby.Go("weapon", line) end }
	end
	W.ShowMenu(button, items)
end

-- The vendor's page: the nearest vendor, or one that sells food and drink,
-- arrows, bullets, bows and guns (Nearby.VendorPage). Back returns to the
-- services.
local function openPage(button, entry)
	local Nearby = ns.Nav.nearby
	local fight = InCombatLockdown and InCombatLockdown()
	local items = {
		{ text = L["Back"], icon = "chevron-left", onClick = function() openNearby(button) end },
		{ separator = true },
	}
	for _, p in ipairs(entry.page) do
		local key = p.key
		items[#items + 1] = { text = p.label, disabled = fight, onClick = function() Nearby.Go(key) end }
	end
	W.ShowMenu(button, items)
end

function openNearby(button)
	if W.MenuShown(button) then return W.HideMenu() end
	local Nearby = ns.Nav and ns.Nav.nearby
	if not (Nearby and Nearby.MenuItems) then return end
	local fight = InCombatLockdown and InCombatLockdown()
	local items = {}
	if Nearby.Trip and Nearby.Trip() then
		items[1] = { text = L["Back to the guide"], icon = "chevron-left", onClick = function() Nearby.EndTrip() end }
		items[2] = { separator = true }
	end
	for _, e in ipairs(Nearby.MenuItems()) do
		if e.separator then
			items[#items + 1] = e
		elseif e.page then
			-- A page of its own: what to buy.
			items[#items + 1] = { text = e.label .. "  \226\128\186", icon = e.icon, disabled = fight,
				onClick = function() openPage(button, e) end }
		elseif e.weapons then
			-- A page of its own: which weapon to learn.
			items[#items + 1] = { text = e.label .. "  \226\128\186", icon = e.icon, disabled = fight,
				onClick = function() openWeapons(button, e) end }
		else
			local key, line = e.key, e.line
			items[#items + 1] = { text = e.label, icon = e.icon, disabled = fight,
				onClick = function() Nearby.Go(key, line) end }
		end
	end
	W.ShowMenu(button, items)
end

GF.OpenMenu, GF.OpenNearby = openMenu, openNearby
