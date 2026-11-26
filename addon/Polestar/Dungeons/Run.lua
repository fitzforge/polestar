-- The in-dungeon quest tracker. The offer belongs to the visit, and the
-- generated tab belongs to the quest log. Both can survive a reload.
local ADDON, ns = ...
local D, Lookup, C, E, L = ns.Dungeons, ns.Lookup, ns.Compat, ns.Engine, ns.L
if not (Lookup and Lookup.RegisterPlanner and E) then return end

local KIND, SETTING = "run", "dungeons.runOffer"
local PAD, BTN_H = 12, 24

local function visit()
	local saved = ns.CharState().dungeonRun
	return type(saved) == "table" and saved or nil
end

local function heldQuests(key)
	local quests, ids = {}, {}
	for _, q in ipairs(D.Quests(key)) do
		if q.id and C.IsOnQuest(q.id) then
			quests[#quests + 1], ids[#ids + 1] = q, q.id
		end
	end
	return quests, table.concat(ids, ",")
end

local function build(key)
	if not D.IsEnabled() then return nil, "off" end
	-- The saved visit lets Lookup restore its tab at ADDON_LOADED, when the
	-- client may still be loading the instance and its quest log.
	local saved = visit()
	if not (saved and saved.key == key) then
		local _, current = D.CurrentInstance("party")
		if current ~= key then return nil, "outside" end
	end
	local d = D.Get(key)
	if not d then return nil, "unknown" end

	local quests, signature = heldQuests(key)
	local steps = {}
	local unplaced = {}
	local function inside() return unplaced end
	for i, q in ipairs(quests) do
		local rec = ns.Codex.Quest(q.id) or { id = q.id, title = q.title }
		-- The same journal endpoint used by HandinPlan. Its `inside` list
		-- only includes quests ready to turn in, while these are still in progress.
		steps[i] = Lookup.QuestStep(rec, nil, {
			dungeon = key, inside = inside, turnin = q.finish and q.finish.inside and q.finish,
		})
	end
	if #steps == 0 then
		steps[1] = { goals = { { t = "note", text = L["None of this dungeon's quests is in your log."] } } }
	end
	return { title = d.name, category = "Dungeons", steps = steps, runQuests = signature }
end

Lookup.RegisterPlanner(KIND, build)

local card, pendingOffer

local function closeRun(saved)
	local id = Lookup.GuideId(KIND, saved.key)
	for i, tab in ipairs(E.GetTabs()) do
		if tab.guideId == id then
			E.CloseTab(i, true)
			if saved.previous then
				for j, other in ipairs(E.GetTabs()) do
					if other.guideId == saved.previous then E.SelectTab(j); break end
				end
			end
			break
		end
	end
end

local function answer(open)
	local saved = pendingOffer
	pendingOffer = nil
	card:Hide()
	local _, current = D.CurrentInstance("party")
	if not saved or current ~= saved.key or C.InCombat() then return end
	if card.Never:GetChecked() then ns.Set(SETTING, false) end
	if not open then return end
	local previous = E.GetGuide()
	local id, reason = Lookup.Guide(KIND, saved.key)
	if id then
		saved.previous = previous and previous.id or nil
		-- The same show action as /polestar show, including the guide
		-- window's manual reopen override for the Hide setting.
		ns.Fire("SHOW_FRAME")
	elseif reason == "tabs" then
		ns.Print(L["Six tabs is the limit. Close one to open another."])
	end
end

local function makeCard()
	local W, Theme = ns.Widgets, ns.Theme
	local f = CreateFrame("Frame", "PolestarDungeonRunOffer", ns.UIParent)
	f:SetPoint("TOP", ns.UIParent, "TOP", 0, -120)
	f:SetFrameStrata("HIGH")
	f:SetClampedToScreen(true)
	f:EnableMouse(true)
	f.psLight = true
	Theme.Skin(f, "window")
	f:Hide()

	f.Title = W.Text(f, "body", "text")
	f.Title:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -PAD)
	f.Title:SetJustifyH("LEFT")
	f.Title:SetWordWrap(true)
	f.Open = W.Button(f, L["Open"], function() answer(true) end, { primary = true, height = BTN_H })
	f.Later, f.Never, f.NeverText = W.OfferFooter(f, function() answer(false) end, PAD, BTN_H, f.Open)
	function f:Layout()
		W.SetButtonText(self.Open, L["Open"])
		W.SetButtonText(self.Later, L["Not now"])
		local foot = self.Never:GetWidth() + 6 + self.NeverText:GetStringWidth() + 8 + self.Open:GetWidth() + 6 + self.Later:GetWidth()
		local w = math.ceil(math.max(360, 2 * PAD + foot))
		self:SetWidth(w)
		self.Title:SetWidth(w - 2 * PAD)
		self:SetHeight(math.ceil(self.Title:GetStringHeight() + 3 * PAD + math.max(self.Open:GetHeight(), self.Later:GetHeight())))
	end
	Theme.OnChanged(function() if f:IsShown() then f:Layout() end end)
	return f
end

local function update()
	if not ns.IsLoggedIn() then return end
	local kind, key, map = D.CurrentInstance("party")
	local state, saved = ns.CharState(), visit()
	local dead = C.Readable(UnitIsDeadOrGhost and UnitIsDeadOrGhost("player"))
		or C.Readable(UnitIsGhost and UnitIsGhost("player"))
	if saved and ((not kind and not dead) or (map and map ~= saved.map)) then
		closeRun(saved)
		state.dungeonRun, saved, pendingOffer = nil, nil, nil
		if card then card:Hide() end
	end
	if saved and not D.IsEnabled() then
		closeRun(saved)
		pendingOffer = nil
	end
	local enabled = ns.Get(SETTING)
	if not enabled or dead then pendingOffer = nil end
	if not key or dead then
		if card then card:Hide() end
		return
	end

	local quests, signature = heldQuests(key)
	local id = Lookup.GuideId(KIND, key)
	local tabs, active = E.GetTabs()
	for i, tab in ipairs(tabs) do
		if tab.guideId == id then
			local guide = ns.Guides.Get(id)
			if guide and guide.runQuests ~= signature then Lookup.Guide(KIND, key, nil, i == active) end
			break
		end
	end
	if #quests == 0 then pendingOffer = nil end
	if #quests == 0 or not enabled or C.InCombat() then
		if card then card:Hide() end
		return
	end
	if not saved then
		local d = D.Get(key)
		if not d then return end
		card = card or makeCard()
		card.Title:SetText(L["You've entered %s. Open the step tracker for your quests here?"]:format(d.name))
		card.Never:SetChecked(false)
		saved = { key = key, map = map }
		state.dungeonRun, pendingOffer = saved, saved
	end
	if pendingOffer == saved and not card:IsShown() then
		card:Layout()
		card:Show()
	end
end

local queued = false
local function soon()
	if queued then return end
	queued = true
	ns.After(0, function()
		queued = false
		update()
	end)
end

for _, event in ipairs({ "PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA", "PLAYER_DEAD", "PLAYER_ALIVE", "PLAYER_UNGHOST", "PLAYER_REGEN_ENABLED", "QUEST_LOG_UPDATE" }) do
	ns.RegisterEvent(event, soon)
end
ns.RegisterEvent("PLAYER_REGEN_DISABLED", function() if card then card:Hide() end end)
ns.On("CODEX_LOADED", soon)
ns.On("SETTING_CHANGED", function(path)
	if path == SETTING or path == "dungeons.enabled" or path == "dungeons" or path == "" then soon() end
end)
