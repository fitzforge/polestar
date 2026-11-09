-- Nearby (spec 4.3): NPCs and objects (herbs and ore are objects) the Codex
-- places near the author, nearest first, filterable, one click to add a
-- `talk`, `interact` or `goto`. The map's spawn index is built once per map
-- over several frames (spec 9.5: under 8 ms of work a frame).

local ADDON, S = ...
local L = S.L
local UI = S.UI
local P = _G.Polestar
local Theme, W = UI.Theme, UI.W
local format, ipairs, sqrt, floor, min, huge = string.format, ipairs, math.sqrt, math.floor, math.min, math.huge

local BUDGET_MS = 6
local SHOW = 40
local ROW = 30

local index = {}    -- map -> { { kind, id, name, x, y, f, roles } }
local building = {} -- map -> true while its coroutine runs
local widget, filter, search = nil, "all", ""

local function now() return debugprofilestop and debugprofilestop() or (GetTime() * 1000) end

local function build(map, done)
	if index[map] or building[map] then return end
	local C = P.Codex
	if not (C and C.Load and C.Load() and C.Each) then return end
	building[map] = true
	local list = {}
	local co = coroutine.create(function()
		local start = now()
		local function tick()
			if now() - start > BUDGET_MS then
				coroutine.yield()
				start = now()
			end
		end
		for _, kind in ipairs({ "npc", "object" }) do
			C.Each(kind, function(id)
				local rec = kind == "npc" and C.Npc(id) or C.Object(id)
				for _, s in ipairs(rec and rec.spawns or {}) do
					if s.map == map then
						list[#list + 1] = { kind = kind, id = id, name = rec.name, x = s.x, y = s.y, f = s.f, roles = rec.roles, level = rec.level }
					end
				end
				tick()
			end)
		end
	end)
	local runner = CreateFrame("Frame")
	runner:SetScript("OnUpdate", function(self)
		local ok, err = coroutine.resume(co)
		if not ok then
			self:SetScript("OnUpdate", nil)
			building[map] = nil
			UI.Say(tostring(err), "danger")
		elseif coroutine.status(co) == "dead" then
			self:SetScript("OnUpdate", nil)
			building[map] = nil
			index[map] = list
			if done then done() end
		end
	end)
end

local function yards(map, ax, ay, af, bx, by)
	local Cp = P.Compat
	if Cp and Cp.MapToWorld then
		local c1, y1, x1 = Cp.MapToWorld(map, ax, ay, af)
		local c2, y2, x2 = Cp.MapToWorld(map, bx, by)
		if c1 and c2 and c1 == c2 then return sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2) end
	end
	return nil
end

local function refresh()
	local f = widget
	if not (f and f:IsShown()) then return end
	local here = UI.Here()
	local c = f.Scroll.Child
	c:SetWidth(f.Scroll:GetWidth())
	if not here then
		f.Status:SetText(L["No position here."])
		f.Rows:HideFrom(1)
		return
	end
	local list = index[here.map]
	if not list then
		f.Status:SetText(L["Reading the Codex for this map…"])
		f.Rows:HideFrom(1)
		build(here.map, refresh)
		return
	end
	-- Nearest spawn per thing, by map percent first (cheap), then yards for the shown ones.
	local best = {}
	local q = search:lower()
	for _, e in ipairs(list) do
		if (filter == "all" or filter == e.kind) and (q == "" or (e.name or ""):lower():find(q, 1, true)) then
			local key = e.kind .. e.id
			local d = (e.x - here.x) ^ 2 + (e.y - here.y) ^ 2
			local b = best[key]
			if not b or d < b.d then best[key] = { e = e, d = d } end
		end
	end
	local sorted = {}
	for _, b in pairs(best) do sorted[#sorted + 1] = b end
	table.sort(sorted, function(a, b) return a.d < b.d end)
	local n = min(SHOW, #sorted)
	for k = 1, n do
		local e = sorted[k].e
		local row = f.Rows:Get(k)
		row:ClearAllPoints()
		row:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -(k - 1) * ROW)
		row:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, -(k - 1) * ROW)
		row.psE = e
		row.Name:SetText(e.name or tostring(e.id))
		W.Color(row.Name, e.kind == "npc" and "npc" or "object")
		local yd = yards(here.map, e.x, e.y, e.f, here.x, here.y)
		local role = e.roles and e.roles[1]
		row.Sub:SetText(format("%s%s", yd and format(L["%d yd"], floor(yd + 0.5)) or format("%.1f, %.1f", e.x, e.y), role and ("  \194\183  " .. role) or ""))
		W.SetButtonText(row.Act, e.kind == "npc" and L["Talk"] or L["Click"])
	end
	f.Rows:HideFrom(n + 1)
	f.Status:SetText(format(L["%d nearest of %d on this map"], n, #sorted))
	W.SetScrollContent(f.Scroll, n * ROW)
end

local function makeRow(parent)
	local row = UI.Row(parent, ROW)
	row.Name = W.Text(row, "label", "npc")
	row.Name:SetPoint("TOPLEFT", row, "TOPLEFT", 10, -3)
	row.Sub = W.Text(row, "small", "textMuted")
	row.Sub:SetPoint("TOPLEFT", row.Name, "BOTTOMLEFT", 0, -1)
	row.Goto = W.Button(row, L["Go to"], function(self)
		local e = self:GetParent().psE
		local map = UI.Here() and UI.Here().map
		local src, out = UI.GotoAt(map, e.x, e.y, e.name)
		if e.f == "e" then
			UI.SetMod(src, "frame", { "era" })
			out.f = "e"
		end
		UI.Add(src, out)
	end, { height = 22, ghost = true })
	row.Goto:SetPoint("RIGHT", row, "RIGHT", -6, 0)
	row.Act = W.Button(row, "", function(self)
		local e = self:GetParent().psE
		if e.kind == "npc" then UI.Resolve("Talk", e.id) else UI.Resolve("Interact", e.id) end
	end, { height = 22 })
	row.Act:SetPoint("RIGHT", row.Goto, "LEFT", -4, 0)
	row.Name:SetPoint("RIGHT", row.Act, "LEFT", -6, 0)
	row.Sub:SetPoint("RIGHT", row.Act, "LEFT", -6, 0)
	return row
end

UI.Widget("Nearby", "Nearby", 340, 380, function(f)
	widget = f
	local b = f.Body
	f.Search = W.SearchBox(b, L["Filter by name"], function(text)
		search = text or ""
		refresh()
	end)
	f.Search:SetPoint("TOPLEFT", b, "TOPLEFT", 10, -8)
	f.Search:SetPoint("TOPRIGHT", b, "TOPRIGHT", -96, -8)
	f.Kind = W.Button(b, L["All"], function(self)
		UI.Menu(self, {
			{ text = L["All"], checked = filter == "all", onClick = function() filter = "all"; W.SetButtonText(self, L["All"]); refresh() end },
			{ text = L["NPCs"], checked = filter == "npc", onClick = function() filter = "npc"; W.SetButtonText(self, L["NPCs"]); refresh() end },
			{ text = L["Objects, herbs, ore"], checked = filter == "object", onClick = function() filter = "object"; W.SetButtonText(self, L["Objects"]); refresh() end },
		})
	end, { height = 28, width = 80 })
	f.Kind:SetPoint("TOPRIGHT", b, "TOPRIGHT", -10, -9)
	f.Status = W.Text(b, "small", "textMuted")
	f.Status:SetPoint("TOPLEFT", f.Search, "BOTTOMLEFT", 2, -6)
	f.Scroll = W.Scroll(b)
	f.Scroll:SetPoint("TOPLEFT", b, "TOPLEFT", 0, -64)
	f.Scroll:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -2, 4)
	f.Rows = UI.Pool(f.Scroll.Child, makeRow)
	f.Refresh = refresh
	f:HookScript("OnShow", refresh)
	local t = 0
	f:SetScript("OnUpdate", function(_, dt)
		t = t + dt
		if t < 3 then return end
		t = 0
		refresh()
	end)
	S.RegisterEvent("ZONE_CHANGED_NEW_AREA", refresh)
end, { point = { "RIGHT", "RIGHT", -60, -200 }, resizable = true, minW = 300, minH = 220 })
