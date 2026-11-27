-- Polestar Group Finder: the main panel.
--
-- The panel: Find a group (and Stop during a search), Announce under it,
-- their waits draining their accent fill; Leave the group while in a party;
-- the players found, each with Whisper and Invite (only ever on your
-- click). The quests searched are not listed: Polestar's guide window shows
-- the step. While the finder is off, only a line saying so and Turn on. The
-- cog in the title bar opens the finder's quick settings, a popover as the
-- guide window's (UI.QuickSettings.New), with All settings… (its page).
-- The panel is as tall as what it shows.
-- It sits against the guide window's right edge (left edge when the right
-- one has no room) and hides with it (Dock.lua); with the guide window
-- hidden, it is a movable window of its own.

local _, ns = ...
local L = ns.L
local W = ns.Widgets

local UI = {}
ns.UI = UI

local WIDTH, PAD = W.WIDTH, W.PAD
local MIN_W, MAX_W = 300, 600 -- the widths its grip allows
local ROWS = 6
-- The cog's quick settings: the few changed mid-play, then All settings….
local QUICK = {
	{ kind = "toggle", key = "groupFinder.autoGroup", label = L["Group automatically (same quest)"], help = L["After your search, with a player who shares a quest with you; both need it on."] },
	{ kind = "toggle", key = "groupFinder.autoReply", label = L["Let others find me"], help = L["Answers other players' searches for your quests with a hidden whisper."] },
	{ kind = "toggle", key = "groupFinder.autoRetry", label = L["Keep searching"], help = L["Asks the search again every 10 s while nobody is found, for up to 5 minutes."] },
	{ kind = "toggle", key = "groupFinder.openNear", label = L["Open near my quest"], help = L["Opens this panel near an objective of a quest worth a group."] },
	{ kind = "toggle", key = "groupFinder.partyBox", label = L["Messages"], help = L["The messages said for you, each only on your click or key, and the hello and goodbye box."] },
}
local listOpen = false -- the players list, unfolded by hand while it folds in a group

local panel
local rows = {}
local widgets = {}
local host            -- the guide window to sit against, or nil
local dockable = {}   -- the frames that take the panel's place

---------------------------------------------------------------------------
-- Refresh
---------------------------------------------------------------------------

local function at(frame, y, x, point)
	frame:ClearAllPoints()
	frame:SetPoint(point or "TOPLEFT", panel, point or "TOPLEFT", x or PAD, -y)
end

-- The second line of a row: the first shared quest, their progress on it
-- (small, dim) and how many more.
local function playerInfo(e)
	local first = e.quests[1]
	local left = W.PeerProgress(e, first)
	local progress = left ~= "" and ("  " .. W.Dim() .. left .. "|r") or ""
	local more = #e.quests > 1 and ("  " .. W.Dim() .. "+" .. (#e.quests - 1) .. "|r") or ""
	return W.Soft() .. ns.Quests.Title(first) .. "|r" .. progress .. more
end

-- The players to list.
local function playersFound()
	local list = ns.Matcher.List()
	return list
end

-- The main view, from the top; returns its height.
local function layoutMain(on)
	local y = 34
	widgets.offText:SetShown(not on)
	widgets.turnOn:SetShown(not on)
	for _, w in ipairs({ widgets.search, widgets.stop, widgets.announce, widgets.leaveGroup, widgets.leaveQuiet, widgets.warn }) do w:SetShown(on) end
	if not on then widgets.groupNote:Hide() widgets.fold:Hide() widgets.forQuest:Hide() end
	if not on then
		widgets.empty:Hide()
		for _, r in ipairs(rows) do r.entry = nil r:Hide() end
		at(widgets.offText, y)
		at(widgets.turnOn, y + 38)
		return y + 38 + 26 + PAD
	end
	-- Find a group (Stop at its right during a search), Announce under it.
	-- Their wait drains their accent fill (W.Drain), no number to read.
	-- A search shows as running (Stop) while it asks, or once it found
	-- someone. Asked out with nobody found, it looks over (Find a group
	-- again), though it keeps telling the players who listed you what is
	-- left of your quests until they are done.
	local found = playersFound()
	local cd = ns.Comm.SearchCooldown()
	local asking = ns.Comm.Searching()
	local active = asking or (ns.Session.Active() and #found > 0)
	widgets.search:SetEnabled(cd == 0 and not asking)
	widgets.search:SetText((asking or cd > 0) and L["Searching…"] or (active and L["Search again"] or L["Find a group"]))
	local inner = panel:GetWidth() - 2 * PAD
	for _, w in ipairs({ widgets.announce, widgets.fold }) do w:SetWidth(inner) end
	for _, fs in ipairs({ widgets.offText, widgets.warn, widgets.groupNote, widgets.empty }) do fs:SetWidth(inner - 4) end
	widgets.search:SetWidth(inner - (active and 76 or 0))
	at(widgets.search, y)
	widgets.stop:SetShown(active)
	y = y + 28
	-- A search for one quest (a goal row's button, a quest menu) names it, while it runs.
	local only = ns.searchOnly
	local named = active and only and ns.Session.Has(only)
	widgets.forQuest:SetShown(named and true or false)
	if named then
		widgets.forQuest:SetWidth(inner - 4)
		widgets.forQuest:SetText(W.Dim() .. string.format(L["Searching for %s"], "|cffffd100" .. ns.Quests.Title(only) .. "|r") .. "|r")
		at(widgets.forQuest, y - 2, PAD + 2)
		y = y + 18
	end
	local ann = ns.Messages.Enabled("announce")
	widgets.announce:SetShown(ann)
	if ann then
		widgets.announce:SetEnabled(ns.Announce.Cooldown() == 0)
		at(widgets.announce, y)
		y = y + 28
	end
	local inParty = ns.InGroup()
	-- Leaving: with the goodbye message on (a finder group), two choices,
	-- Say goodbye & leave or just Leave; else one Leave the group.
	local speaks = inParty and ns.Leave.Speaks()
	widgets.leaveGroup:SetShown(inParty)
	widgets.leaveQuiet:SetShown(speaks and true or false)
	if inParty then
		widgets.leaveGroup:SetText(speaks and L["Goodbye & leave"] or L["Leave the group"])
		widgets.leaveGroup:SetWidth(inner - (speaks and 106 or 0))
		at(widgets.leaveGroup, y)
		y = y + 28
	end
	-- The channel, only when it does not work.
	local broken = ns.Channels.Best() == nil
	widgets.warn:SetShown(broken)
	if broken then
		at(widgets.warn, y + 2)
		y = y + 20
	end
	-- In a group: a line says what you can do. Leader with room: the list
	-- stays (invite more). Otherwise it folds to one button that opens it.
	local grouped = ns.InGroup()
	local canAdd = not grouped or ns.Group.CanAdd()
	widgets.groupNote:SetShown(grouped)
	if grouped then
		local size = ns.Group.PartySize()
		widgets.groupNote:SetText(W.Dim() .. (canAdd and string.format(L["You lead the group (%d/%d): you can invite more players."], size, ns.Group.MAX_PARTY)
			or (size >= ns.Group.MAX_PARTY and L["Your group is full."] or L["In a group: only its leader can invite."])) .. "|r")
		at(widgets.groupNote, y + 2, PAD + 2)
		y = y + 20
	end
	local foldable = grouped and not canAdd and #found > 0
	widgets.fold:SetShown(foldable)
	if foldable then
		widgets.fold:SetText(string.format(listOpen and L["Hide the players found (%d)"] or L["Show the players found (%d)"], #found))
		at(widgets.fold, y)
		y = y + 26
		if not listOpen then
			widgets.empty:Hide()
			for _, r in ipairs(rows) do r.entry = nil r:Hide() end
			return y + PAD - 2
		end
	end
	widgets.empty:SetShown(#found == 0)
	if #found == 0 then
		local recent = ns.Session.Active() or (ns.searchedAt and ns.Now() - ns.searchedAt < 300)
		local searching = ns.Get("autoRetry") and L["Searching… asked again every 10 s until someone is found, for up to 5 minutes."] or L["Searching…"]
		widgets.empty:SetText(active and ((asking or cd > 0) and searching or L["No one found yet. Players who search for your quests later show up here."]) or (recent and L["No one found yet. Players who search for your quests later show up here."] or L["No one yet. Press Find a group."]))
		at(widgets.empty, y + 4, PAD + 2)
		y = y + 34
	end
	y = W.LayoutRows(panel, rows, found, y + 2, playerInfo)
	return y + PAD - 2
end

function UI.Refresh()
	if not (panel and panel:IsShown()) then return end
	panel:SetHeight(layoutMain(ns.Get("enabled") and true or false))
end

-- The cog: the quick settings.
local quick
function UI.ToggleSettings()
	quick = quick or ns.P.UI.QuickSettings.New({ name = "PolestarGroupFinderQuick", title = L["Group Finder"], rows = QUICK,
		all = function() ns.P.UI.ShowOptions("groupfinder") end, noReset = true })
	quick.Toggle(widgets.gear)
end
function UI.SettingsShown() return quick ~= nil and quick.Shown() end

---------------------------------------------------------------------------
-- Placement
---------------------------------------------------------------------------

-- A frame's rectangle in screen pixels: left, right, top, bottom.
local function screenRect(fr)
	local l, r, t, b = fr:GetLeft(), fr:GetRight(), fr:GetTop(), fr:GetBottom()
	if not (l and r and t and b) then return nil end
	local s = fr:GetEffectiveScale()
	return l * s, r * s, t * s, b * s
end

local function overlaps(a, b)
	local al, ar, at, ab = screenRect(a)
	local bl, br, bt, bb = screenRect(b)
	if not (al and bl) then return false end
	return al < br and bl < ar and ab < bt and bb < at
end

-- Where the panel stands: where the player left it (panelPos), unless the
-- guide window stands there now; else beside the guide window, on the side
-- the screen has room for (worked out in screen pixels: right, else left,
-- else under it), then let go of it, so the guide window moving later never
-- drags it over itself; else the screen's middle. A window of its own:
-- dragged anywhere, its width set by its corner grip, held on the screen.
local function placeFrame(f)
	f:ClearAllPoints()
	local pos = ns.Get("panelPos")
	local beside = host and host:IsShown() and host:GetRight()
	if type(pos) == "table" then
		f:SetPoint(pos[1] or "CENTER", UIParent, pos[1] or "CENTER", pos[2] or 0, pos[3] or 0)
		if not (beside and overlaps(f, host)) then return end
		f:ClearAllPoints()
	end
	if beside then
		local hs, us, fs = host:GetEffectiveScale(), UIParent:GetEffectiveScale(), f:GetEffectiveScale()
		local need = (f:GetWidth() + 10) * fs
		if UIParent:GetRight() * us - host:GetRight() * hs >= need then
			f:SetPoint("TOPLEFT", host, "TOPRIGHT", 6, 0)
		elseif host:GetLeft() * hs >= need then
			f:SetPoint("TOPRIGHT", host, "TOPLEFT", -6, 0)
		else
			f:SetPoint("TOPLEFT", host, "BOTTOMLEFT", 0, -6)
		end
		local left, top = f:GetLeft(), f:GetTop()
		if left and top then
			f:ClearAllPoints()
			f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
		end
		return
	end
	f:SetPoint("CENTER", UIParent, "CENTER", 260, 60)
end

function UI.Place()
	for _, f in ipairs(dockable) do placeFrame(f) end
end

-- QuestPanel.lua: a frame that takes the panel's place.
function UI.Dockable(f)
	dockable[#dockable + 1] = f
	placeFrame(f)
end

-- Saves where a standalone panel was dragged.
function UI.SavePosition(f)
	local point, _, _, x, y = f:GetPoint(1)
	ns.Set("panelPos", { point, x, y })
end

-- Polestar.lua: the guide window to sit against (nil: stand alone).
function UI.SetHost(frame)
	host = frame
	UI.Place()
end

-- Dock.lua: the guide window was shown or hidden. The panel is part
-- of the window: it goes and comes back with it.
function UI.HostShown(shown)
	if shown then UI.Place() end
	for _, f in ipairs(dockable) do
		if shown then
			if f.psDockHidden then f.psDockHidden = nil f:Show() end
		elseif f:IsShown() then
			f.psDockHidden = true
			f:Hide()
		end
	end
end

---------------------------------------------------------------------------
-- Announce (Announce.lua): the choices and the preview
---------------------------------------------------------------------------

-- The tooltip shows the exact line that would go out. `self.questID`: one quest.
function UI.AnnounceTip(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:SetText(L["Announce"], 1, 1, 1)
	local text = ns.Announce.Text(ns.Announce.Quests(self.questID))
	if text then
		GameTooltip:AddLine(string.format(L["Says this line in %s (at most once a minute, only on your click):"], ns.Announce.TargetName(ns.Announce.Target())), nil, nil, nil, true)
		GameTooltip:AddLine(text, 1, 1, 1, true)
	else
		GameTooltip:AddLine(L["No quest to announce."], nil, nil, nil, true)
	end
	GameTooltip:Show()
end

---------------------------------------------------------------------------
-- Build
---------------------------------------------------------------------------

local function text(role, fallback, justify)
	local fs = W.Text(panel, role, fallback)
	if justify then fs:SetJustifyH(justify) end
	return fs
end


local function build()
	local width = tonumber(ns.Get("panelWidth"))
	panel = W.Window("PSGroupFinderPanel", { width = width and math.max(MIN_W, math.min(MAX_W, width)) or WIDTH, height = 300, movable = true, onMoved = UI.SavePosition })
	-- The corner grip sets the width (the height follows what it shows).
	panel:SetResizable(true)
	if panel.SetResizeBounds then panel:SetResizeBounds(MIN_W, 100, MAX_W, 2000) end
	local grip = ns.P.Widgets.IconButton(panel, "resize", 16, L["Drag to resize"], nil, 12)
	grip:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -2, 2)
	grip:SetFrameLevel(panel:GetFrameLevel() + 40)
	grip:SetScript("OnMouseDown", function(_, button)
		if button ~= "LeftButton" then return end
		panel.psSizing = true
		panel:StartSizing("RIGHT")
	end)
	grip:SetScript("OnMouseUp", function(_, button)
		if button ~= "LeftButton" or not panel.psSizing then return end
		panel.psSizing = nil
		panel:StopMovingOrSizing()
		ns.Set("panelWidth", math.floor(panel:GetWidth() + 0.5))
		UI.SavePosition(panel)
		UI.Refresh()
	end)
	panel:HookScript("OnSizeChanged", function(self) if self.psSizing then UI.Refresh() end end)
	widgets.grip = grip
	widgets.title = W.Title(panel, L["Group Finder"])
	W.CloseButton(panel)
	-- The cog, left of the close button.
	-- The cog, left of the close button: Polestar's own glyph button, no frame.
	widgets.gear = ns.P.Widgets.IconButton(panel, "gear", 20, L["Quick settings"], UI.ToggleSettings, 13)
	widgets.gear:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -34, -8)

	widgets.offText = (text("small", GameFontHighlightSmall, "LEFT"))
	widgets.offText:SetWidth(WIDTH - 2 * PAD)
	widgets.offText:SetText(W.Dim() .. L["The finder is off: it sends nothing and listens to nothing."] .. "|r")
	widgets.turnOn = (W.Button(panel, L["Turn on"], 120, function() ns.SetEnabled(true) end))
	widgets.search = (W.Button(panel, L["Find a group"], WIDTH - 2 * PAD, function() ns.Search() UI.Refresh() end))
	-- While it asks again on its own, the fill drains to the next try.
	W.Drain(widgets.search, function()
		if ns.Comm.Searching() then return ns.Comm.RetryLeft() / ns.Comm.RETRY_EVERY end
		return ns.Comm.SearchCooldown() / ns.Comm.SEARCH_GAP
	end)
	widgets.stop = (W.Button(panel, L["Stop"], 70, function() ns.Comm.StopSearch() UI.Refresh() end))
	widgets.stop:SetPoint("LEFT", widgets.search, "RIGHT", 6, 0)
	widgets.announce = (W.Button(panel, L["Announce"], WIDTH - 2 * PAD, function() ns.Announce.Send() UI.Refresh() end))
	W.Drain(widgets.announce, function() return ns.Announce.Cooldown() / ns.Announce.GAP end)
	widgets.announce:SetScript("OnEnter", UI.AnnounceTip)
	widgets.announce:SetScript("OnLeave", function() GameTooltip:Hide() end)
	widgets.leaveGroup = (W.Button(panel, L["Leave the group"], WIDTH - 2 * PAD, function() ns.Leave.Do() end))
	W.Tip(widgets.leaveGroup, L["Leave the group"], L["Leaves the group. For a group formed through the finder, with the goodbye message on, says it first."])
	widgets.leaveQuiet = (W.Button(panel, L["Leave"], 100, function() ns.Leave.Do(true) end))
	widgets.leaveQuiet:SetPoint("LEFT", widgets.leaveGroup, "RIGHT", 6, 0)
	W.Tip(widgets.leaveQuiet, L["Leave"], L["Leaves the group without a word."])
	widgets.warn = (text("small", GameFontHighlightSmall, "LEFT"))
	widgets.warn:SetWidth(WIDTH - 2 * PAD)
	widgets.warn:SetText(W.Hex("warning", "fffabf4d") .. L["The finder's channel is not working: type /polestar finder test to check it."] .. "|r")
	widgets.forQuest = text("small", GameFontHighlightSmall, "LEFT")
	widgets.forQuest:SetWordWrap(false)
	widgets.groupNote = (text("small", GameFontHighlightSmall, "LEFT"))
	widgets.groupNote:SetWidth(WIDTH - 2 * PAD - 4)
	widgets.fold = (W.Button(panel, L["Show the players found (%d)"], WIDTH - 2 * PAD, function() listOpen = not listOpen UI.Refresh() end))
	widgets.empty = (text("note", GameFontDisableSmall, "LEFT"))
	widgets.empty:SetWidth(WIDTH - 2 * PAD - 4)
	for i = 1, ROWS do rows[i] = W.PlayerRow(panel) end

	W.EverySecond(panel, UI.Refresh)
	panel:SetScript("OnShow", function() UI.Place() UI.Refresh() end)
	panel:Hide()
	local T = W.Theme()
	if T and T.OnChanged then pcall(T.OnChanged, UI.Refresh) end
	UI.Dockable(panel)
end

function UI.Show()
	if not panel then build() end
	UI.Place()
	panel:Show()
	panel:Raise()
	UI.Refresh()
end

function UI.Hide()
	if panel then panel:Hide() panel.psDockHidden = nil end
end

function UI.Toggle()
	if panel and panel:IsShown() then panel:Hide() else UI.Show() end
end

function UI.IsShown() return panel and panel:IsShown() or false end

-- Tests.
function UI.FoldButton() return widgets.fold end
function UI.StopShown() return widgets.stop and widgets.stop:IsShown() or false end
function UI.AnnounceButton() return widgets.announce end
function UI.SearchButton() return widgets.search end
function UI.ForQuest() return widgets.forQuest end

ns.TogglePanel = UI.Toggle
ns.RegisterEvent("GROUP_ROSTER_UPDATE", function() listOpen = false end)

for _, msg in ipairs({ "PEERS", "CHANNELS", "SETTING", "ENABLED", "SEARCHED", "SEARCH_RETRY", "SESSION", "ANNOUNCED" }) do
	ns.On(msg, UI.Refresh)
end

-- Someone new found within OPEN_AFTER seconds of your own search, while the
-- panel is closed: open it. Never on other players' searches alone.
local OPEN_AFTER = 120
ns.On("PEER_NEW", function()
	if ns.Get("enabled") and not UI.IsShown() and ns.searchedAt and ns.Now() - ns.searchedAt < OPEN_AFTER then UI.Show() end
end)
