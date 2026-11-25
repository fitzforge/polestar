-- The guide window's menu and its Nearby services button (UI/GuideFrame.lua).

local ADDON, ns = ...
ns.UI.GuideFrame.Part(function(GF)
	local UI, W, L = ns.UI, ns.Widgets, ns.L
	local Engine, compact, transparent, tabsOf = GF.Engine, GF.Compact, GF.Transparent, GF.TabsOf
	-- The pin glyph the menu's pin rows wear (Media/UI has none of its own).
	local PIN_ICON = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Map\\icon-pin-small"

	-- Is the header's button `key` (nav.Skip, nav.Report, nav.Lookup) on
	-- screen? Its menu row then goes: the header already offers it.
	local function inHeader(key)
		local nav = GF.menuButton and GF.menuButton:GetParent()
		local b = nav and nav[key]
		return b ~= nil and b:IsVisible() and true or false
	end

	-- The window's toggles as the menu's top bar (W.ShowMenu's bar): Compact,
	-- Transparent, Lock and Pause. No Hide: a window hidden from its own menu
	-- left no way back but a slash command. Its caption names the toggle under
	-- the pointer, else it is blank, or says Polestar is paused while it is.
	local function windowBar(clear)
		local paused = ns.Paused() ~= nil
		return { caption = paused and L["Polestar is paused"] or nil, captionColor = paused and "warning" or nil, bar = {
			{ text = L["Compact mode"], icon = "compact", checked = compact(), onClick = function() ns.Set("ui.compact", not compact()) end },
			{ text = L["Transparent"], icon = "layers", checked = clear, onClick = function() ns.Set("ui.style", clear and "standard" or "transparent") end },
			{ text = L["Lock window"], icon = "lock", checked = ns.Get("ui.locked") and true or false, onClick = function() ns.Set("ui.locked", not ns.Get("ui.locked")) end },
			-- Pause (Core/Init.lua): the arrow, this window and its nudges step aside until you are back out of a dungeon alive.
			{ text = L["Pause"], icon = "icon-dungeon", checked = paused, onClick = function() ns.TogglePaused() end },
		} }
	end

	---------------------------------------------------------------------------
	-- Menu
	---------------------------------------------------------------------------

	local openMenu

	-- The open tabs' page of the menu (GF.TabListItems): every guide open, the
	-- one in view checked, New tab and Reopen closed tab. Back returns to the
	-- menu.
	local function openTabsPage(button)
		local items = {
			{ text = L["Back"], icon = "chevron-left", onClick = function() openMenu(button) end },
			{ separator = true },
		}
		for _, it in ipairs(GF.TabListItems()) do items[#items + 1] = it end
		W.ShowMenu(button, items, { current = true })
	end

	function openMenu(button)
		if W.MenuShown(button) then return W.HideMenu() end
		local E = Engine()
		local hasGuide = E and E.GetGuide and E.GetGuide()
		local clear = transparent()
		-- With two guides or more open, their list takes New tab's place, and
		-- New tab and Reopen closed tab go in it: the strip can be hidden
		-- (compact mode, Options), and the menu still lists and switches them.
		local open = tabsOf(E)
		local several = open and #open >= 2
		-- The window's toggles on top, then groups, each after a separator: the
		-- guide and its tabs; this step; the quest log; settings and tools; the
		-- guide reset last. A row the header shows as a button is left out.
		local items = {
			windowBar(clear),
			{ separator = true },
			{ text = L["Choose guide"], icon = "search", onClick = function() UI.ShowPicker() end },
			several and { text = string.format(L["Open tabs (%d)"], #open) .. "  \226\128\186", icon = "guides", onClick = function() openTabsPage(button) end }
				or { text = L["Open in new tab"], icon = "plus", disabled = not (E and E.OpenTab), onClick = function() UI.ShowPicker({ newTab = true }) end },
		}
		local function add(it) items[#items + 1] = it end
		local function group() if #items > 0 and not items[#items].separator then add({ separator = true }) end end
		local reopen = not several and GF.ReopenItem()
		if reopen then add(reopen) end
		-- A header with no Lookup (a skin's layout hid it) has it here.
		if not inHeader("Lookup") then
			add({ text = L["Lookup"], icon = "search", onClick = function() UI.ShowLookup() end })
		end
		group()
		-- No step on screen (a finished guide): nothing to skip, as with the navigator's Skip.
		if not inHeader("Skip") then
			add({ text = L["Skip this step"], icon = "skip", disabled = not (hasGuide and E.GetStepIndex and E.GetStepIndex()), onClick = function() GF.SkipStep() end })
		end
		group()
		-- Pin the shown step's quests in the log as along the way, or unpin them (#644).
		for _, it in ipairs(GF.PinItems(GF.View())) do add(it) end
		-- The finished quests no open route hands in (RoutePlan.Carried): one
		-- click opens their hand-in guide (UI.GuideCarried). Both rows are
		-- always here: with none, or while the plan cannot say (nil, as with
		-- no guide or a guide not loaded), disabled. None listed while some
		-- wait on a route choice ahead (Carried's second value): it says so.
		local carried, waiting
		if ns.RoutePlan then carried, waiting = ns.RoutePlan.Carried() end
		if carried and #carried > 0 then
			add({ text = L["Hand in finished quests (%d)"]:format(#carried), icon = "icon-turnin", onClick = function() UI.GuideCarried() end })
		elseif carried and (waiting or 0) > 0 then
			add({ text = L["Turn-in plan depends on your next route choice"], icon = "icon-turnin", disabled = true })
		else
			add({ text = L["None to hand in"], icon = "icon-turnin", disabled = true })
		end
		-- The quest log cleanup (UI/QuestRoom.lua), over the quests it can list.
		local unneeded = ns.RoutePlan and ns.RoutePlan.Unneeded() or nil
		if unneeded and #unneeded > 0 then
			add({ text = L["Clean up quest log (%d)"]:format(#unneeded), icon = "cross", onClick = function() UI.ShowQuestRoom() end })
		else
			add({ text = L["Quest log is clean"], icon = "cross", disabled = true })
		end
		-- The quest items to buy at the auction house (UI/AuctionBuys.lua), while there are any.
		local ah = UI.AuctionBuys and UI.AuctionBuys.MenuItem()
		if ah then add(ah) end
		-- Gather, buy or mix, for a guide with a material to choose a way for (UI/Materials.lua).
		local mats = UI.Materials and UI.Materials.MenuItems()
		for _, it in ipairs(mats or {}) do add(it) end
		group()
		-- The few settings changed mid-play (UI/QuickSettings.lua), by the button, just before Settings.
		if UI.QuickSettings then
			add({ text = L["Quick settings"], icon = "sliders", onClick = function() UI.QuickSettings.Show(button) end })
		end
		add({ text = L["Settings"], icon = "gear", onClick = function() UI.ShowOptions() end })
		-- Width, scale and height cap back to their defaults (GF.ResetSize).
		add({ text = L["Reset window size"], icon = "reset", disabled = not GF.SizeChanged(), onClick = function() GF.ResetSize() end })
		if not inHeader("Report") then
			add({ text = L["Report a problem"], icon = "bug", onClick = function() UI.ShowReport() end })
		end
		-- The flight games (Maps/Arcade.lua): the chosen one, else the first there.
		local game = ns.Arcade and ns.Arcade.MenuGame()
		if game then
			add({ text = game.play, icon = "gamepad", onClick = function() ns.Arcade.Open(game.id) end })
		end
		-- The Recorder's window, while the Recorder addon is loaded.
		if type(PolestarRecorder_Command) == "function" then
			add({ text = L["Recorder window"], icon = "record", onClick = function() PolestarRecorder_Command("ui") end })
		end
		group()
		add({ text = L["Reset guide progress"], icon = "reset", color = "danger", confirm = true, disabled = not hasGuide, tip = L["Clears your manual check-offs and skipped steps in this guide from your last quest progress on. The guide stays where your quests put you."],
			onClick = function() if E and E.ResetProgress then E.ResetProgress() end end })
		-- A skin's own entries (Skin API 2, hooks.guideMenu(items, button)): it
		-- may add, remove or reorder them; the list is made anew at each opening.
		GF.Hook("guideMenu", items, button)
		-- No separator left last (a skin may take the rows after it).
		if items[#items] and items[#items].separator then items[#items] = nil end
		-- Every entry in view, its groups apart: not a list to filter.
		W.ShowMenu(button, items, { short = true })
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
				out[#out + 1] = { text = string.format(pinned and L["Unpin %s"] or L["Pin %s as along the way"], title), icon = PIN_ICON,
					checked = pinned, onClick = function() E.PinQuest(q, not pinned) end }
			end
		end
		return out
	end

	-- The quest log's menu on a quest (right-click its title): pin it as along
	-- the way, or unpin it (#644). Not with the gamepad interface (ns.GamepadUI),
	-- as Nav/Nearby.lua's map menus, nor while Polestar is hidden.
	if GF.live then
		ns.OnLogin(function()
			if ns.GamepadUI() or not (Menu and Menu.ModifyMenu) then return end
			Menu.ModifyMenu("MENU_QUEST_MAP_LOG_TITLE", function(owner, root)
				local q = owner and owner.questID
				local E = Engine()
				if ns.Hidden() or type(q) ~= "number" or not (E and E.PinQuest) then return end
				local pinned = E.IsPinned(q)
				root:CreateDivider()
				root:CreateButton(pinned and L["Unpin from along the way"] or L["Pin as along the way"], function() E.PinQuest(q, not pinned) end)
			end)
		end)
	end

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
		if ns.Nav.Trip() then
			items[1] = { text = L["Back to the guide"], icon = "chevron-left", onClick = function() ns.Nav.EndTrip() end }
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
end)
