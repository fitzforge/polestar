-- Polestar.Hooks: the one owner of the client's tooltip and item-click hooks,
-- so modules add lines and handle clicks instead of each hooking the client.
-- Contract: docs/ARCHITECTURE.md, "Core services: Data, Hooks, Search" and
-- "Lookup".
--
--   Hooks.ItemLines(owner, fn(tooltip, link, itemID))   -- item tooltips (GameTooltip, ItemRefTooltip)
--   Hooks.UnitLines(owner, fn(tooltip, unit))           -- unit tooltips (GameTooltip)
--   Hooks.ObjectLines(owner, fn(tooltip, objectID, name)) -- game object tooltips (GameTooltip);
--       objectID and name may each be nil (never both)
--   Hooks.ItemClick(owner, fn(link, itemID))            -- modified clicks on item links, bag and loot items
--   Hooks.AddLine(tooltip, left, right?, r, g, b, rr, rg, rb)
--
-- One entry per owner (registering again replaces it in place, nil removes
-- it); callbacks run in registration order, each in its own pcall so one
-- module's error never costs another its lines. A client hook is installed
-- only when the first callback of its kind registers.
--
-- Client mechanisms (verified against .ref/wow-ui-source-forever):
--   * Tooltips: TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item /
--     .Unit / .Object, fn(tooltip, tooltipData)) (Blizzard_SharedXMLGame/Tooltip/
--     TooltipDataHandler.lua: post-calls run after the lines, then the tooltip
--     is shown, so no Show() here; Object = 4 in TooltipInfoSharedDocumentation.lua).
--     tooltipData.id is the item ID and tooltipData.guid the unit GUID
--     (TooltipUtil.lua GetDisplayedItem / GetDisplayedUnit); an object's ID is
--     tooltipData.id or the id field of its GameObject GUID, its name the
--     first line's leftText. Clients without TooltipDataProcessor fall back to
--     OnTooltipSetItem / OnTooltipSetUnit (objects have no such script).
--   * Item clicks: bag buttons (Blizzard_UIPanels_Game/Mainline/ContainerFrame.lua,
--     ContainerFrameItemButtonMixin:OnModifiedClick), loot buttons (LootFrame.lua)
--     and chat links (ItemRef.lua SetItemRef: the item link handler in
--     Shared/ItemRefHandlersShared.lua only takes Shift-clicks, everything else
--     with a modifier falls through) all call the global HandleModifiedItemClick
--     (Blizzard_ItemButton/Mainline/ItemButtonTemplate.lua). It is post-hooked
--     with hooksecurefunc, which never taints the caller.
--   * Forbidden tooltips (IsForbidden, SimpleFrameScriptObjectAPIDocumentation.lua)
--     and secret values (issecretvalue, FrameScriptDocumentation.lua) are skipped.

local ADDON, ns = ...

local Hooks = {}
ns.Hooks = Hooks

local type, pcall, tonumber, ipairs = type, pcall, tonumber, ipairs

local secret = ns.Compat.IsSecret

local function report(err)
	ns.NoteError(err)
	local handler = geterrorhandler and geterrorhandler()
	if handler then pcall(handler, err) end
end

-- owner -> fn lists, in registration order: { { owner = ..., fn = ... }, ... }
local lists = { item = {}, unit = {}, object = {}, click = {} }

local installers = {}

local function register(kind, owner, fn)
	if owner == nil then return false end
	local list = lists[kind]
	for i = 1, #list do
		if list[i].owner == owner then
			if fn == nil then
				table.remove(list, i)
			else
				list[i].fn = fn
			end
			return true
		end
	end
	if type(fn) ~= "function" then return false end
	list[#list + 1] = { owner = owner, fn = fn }
	if installers[kind] then
		local install = installers[kind]
		installers[kind] = nil
		install()
	end
	return true
end

function Hooks.ItemLines(owner, fn) return register("item", owner, fn) end
function Hooks.UnitLines(owner, fn) return register("unit", owner, fn) end
function Hooks.ObjectLines(owner, fn) return register("object", owner, fn) end
function Hooks.ItemClick(owner, fn) return register("click", owner, fn) end

-- Runs every callback of a kind; returns how many ran without error.
local function run(kind, ...)
	local list = lists[kind]
	local n = #list
	if n == 0 then return 0 end
	-- A snapshot, so a callback that registers or removes one cannot skip another.
	local fns = {}
	for i = 1, n do fns[i] = list[i].fn end
	local ok = 0
	for i = 1, n do
		local done, err = pcall(fns[i], ...)
		if done then ok = ok + 1 else report(err) end
	end
	return ok
end

function Hooks.AddLine(tooltip, left, right, r, g, b, rr, rg, rb)
	if not tooltip or left == nil then return end
	if right ~= nil and tooltip.AddDoubleLine then
		tooltip:AddDoubleLine(left, right, r, g, b, rr, rg, rb)
	elseif tooltip.AddLine then
		tooltip:AddLine(left, r, g, b)
	end
end

---------------------------------------------------------------------------
-- Tooltips
---------------------------------------------------------------------------

local function forbidden(tooltip)
	if not (tooltip and tooltip.IsForbidden) then return false end
	local ok, f = pcall(tooltip.IsForbidden, tooltip)
	if not ok or secret(f) then return true end
	return f and true or false
end

local function numLines(tooltip)
	if not tooltip.NumLines then return nil end
	local ok, n = pcall(tooltip.NumLines, tooltip)
	if ok and type(n) == "number" and not secret(n) then return n end
	return nil
end

-- What each tooltip last got lines for: { kind, key, lines }. Until cleared,
-- repeated or appended callbacks for the same subject keep those lines.
-- A rebuild may have more client lines, so its count alone cannot detect a
-- clear. Keep the hook's lifetime separate from the decoration cache.
local added = setmetatable({}, { __mode = "k" })
local clearChecked = setmetatable({}, { __mode = "k" })

local function clearAdded(tooltip)
	added[tooltip] = nil
end

local function decorate(kind, tooltip, key, ...)
	if not clearChecked[tooltip] then
		-- Check once, including failures: repeated post-calls must not retry.
		-- Missing APIs or explicit lack of support keep the line-count fallback.
		-- A thrown error has an unknown cause; retain it in the session report.
		clearChecked[tooltip] = true
		if tooltip.HookScript then
			local ok, supported = true, true
			if tooltip.HasScript then ok, supported = pcall(tooltip.HasScript, tooltip, "OnTooltipCleared") end
			if not ok then
				ns.NoteError(supported)
			elseif supported ~= false then
				local installed, err = pcall(tooltip.HookScript, tooltip, "OnTooltipCleared", clearAdded)
				if not installed then ns.NoteError(err) end
			end
		end
	end
	local before = numLines(tooltip)
	local last = added[tooltip]
	if last and last.key == key and last.kind == kind and before and before >= last.lines then return 0 end
	run(kind, tooltip, ...)
	local after = numLines(tooltip)
	if after and before and after > before then
		added[tooltip] = { kind = kind, key = key, lines = after }
		return after - before
	end
	added[tooltip] = nil
	return 0
end

local function linkOf(tooltip)
	local link
	if TooltipUtil and TooltipUtil.GetDisplayedItem then
		local ok, _, l = pcall(TooltipUtil.GetDisplayedItem, tooltip)
		if ok then link = l end
	end
	if link == nil and tooltip.GetItem then
		local ok, _, l = pcall(tooltip.GetItem, tooltip)
		if ok then link = l end
	end
	if type(link) ~= "string" or secret(link) then return nil end
	return link
end

local function idOfLink(link)
	return type(link) == "string" and tonumber(link:match("item:(%d+)")) or nil
end

local function itemTooltip(tooltip, data)
	if tooltip ~= GameTooltip and tooltip ~= ItemRefTooltip then return 0 end
	if forbidden(tooltip) or #lists.item == 0 then return 0 end
	local id = data and data.id
	if secret(id) or type(id) ~= "number" then id = nil end
	local link = linkOf(tooltip)
	if not id then id = idOfLink(link) end
	if not id then return 0 end
	return decorate("item", tooltip, link or id, link, id)
end
Hooks.OnItemTooltip = itemTooltip

local function unitOf(tooltip, data)
	local guid = data and data.guid
	if guid ~= nil and not secret(guid) and UnitTokenFromGUID then
		local ok, unit = pcall(UnitTokenFromGUID, guid)
		if ok and type(unit) == "string" and not secret(unit) then return unit end
	end
	if tooltip.GetUnit then
		local ok, _, unit = pcall(tooltip.GetUnit, tooltip)
		if ok and type(unit) == "string" and not secret(unit) then return unit end
	end
	return nil
end

local function unitTooltip(tooltip, data)
	if tooltip ~= GameTooltip or forbidden(tooltip) or #lists.unit == 0 then return 0 end
	local unit = unitOf(tooltip, data)
	if not unit then return 0 end
	local guid = UnitGUID and UnitGUID(unit)
	if secret(guid) then guid = nil end
	return decorate("unit", tooltip, guid or unit, unit)
end
Hooks.OnUnitTooltip = unitTooltip

-- "GameObject-0-4372-0-17-2843-0000123456" -> 2843
local function objectIdOfGUID(guid)
	if type(guid) ~= "string" or secret(guid) then return nil end
	local kind, id = guid:match("^(%a+)%-%d+%-%d+%-%d+%-%d+%-(%d+)%-")
	if kind ~= "GameObject" then return nil end
	return tonumber(id)
end

local function objectTooltip(tooltip, data)
	if tooltip ~= GameTooltip or forbidden(tooltip) or #lists.object == 0 or type(data) ~= "table" then return 0 end
	local id = data.id
	if secret(id) or type(id) ~= "number" then id = objectIdOfGUID(data.guid) end
	local name
	local lines = data.lines
	if type(lines) == "table" and not secret(lines) then
		local first = lines[1]
		if type(first) == "table" and not secret(first) then
			local text = first.leftText
			if type(text) == "string" and not secret(text) and text ~= "" then name = text end
		end
	end
	if not (id or name) then return 0 end
	return decorate("object", tooltip, id or name, id, name)
end
Hooks.OnObjectTooltip = objectTooltip

local function postCalls()
	local P = TooltipDataProcessor
	local T = Enum and Enum.TooltipDataType
	if P and P.AddTooltipPostCall and T then return P, T end
	return nil
end

-- The fallback scripts fire before the tooltip is sized; Show() resizes it.
local function showIfAdded(tooltip, n)
	if n > 0 and tooltip.Show then tooltip:Show() end
end

installers.item = function()
	local P, T = postCalls()
	if P and T.Item then
		P.AddTooltipPostCall(T.Item, function(tooltip, data) itemTooltip(tooltip, data) end)
		return
	end
	for _, tooltip in ipairs({ GameTooltip, ItemRefTooltip }) do
		if tooltip and tooltip.HookScript then
			tooltip:HookScript("OnTooltipSetItem", function(tt) showIfAdded(tt, itemTooltip(tt, nil)) end)
		end
	end
end

installers.unit = function()
	local P, T = postCalls()
	if P and T.Unit then
		P.AddTooltipPostCall(T.Unit, function(tooltip, data) unitTooltip(tooltip, data) end)
		return
	end
	if GameTooltip and GameTooltip.HookScript then
		GameTooltip:HookScript("OnTooltipSetUnit", function(tt) showIfAdded(tt, unitTooltip(tt, nil)) end)
	end
end

installers.object = function()
	local P, T = postCalls()
	if P and T.Object then
		P.AddTooltipPostCall(T.Object, function(tooltip, data) objectTooltip(tooltip, data) end)
	end
end

---------------------------------------------------------------------------
-- Modified clicks on items
---------------------------------------------------------------------------

local function itemClick(link)
	if type(link) ~= "string" or secret(link) then return end
	local id = idOfLink(link)
	if not id then return end
	run("click", link, id)
end
Hooks.OnItemClick = itemClick

installers.click = function()
	if type(HandleModifiedItemClick) == "function" and hooksecurefunc then
		hooksecurefunc("HandleModifiedItemClick", itemClick)
	end
end
