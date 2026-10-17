-- Report a problem: the window behind the guide window's bug button (in the
-- navigator, beside Skip and the menu), its menu entry and /polestar report.
-- The player says what went wrong; the window sets that above everything a
-- fix needs, taken when the window opens: the guide and the step on screen
-- with every goal's state, ids and position, the arrow, where the player
-- stands, the versions, other packs and the errors Polestar caught. One
-- report, selected for copying, sized to stay inside one Discord message,
-- and under it where to paste it: the Polestar Discord, with "Get the
-- invite" for a player not in it yet. UI.ShowDiscord: the invite alone
-- (ns.DiscordURL), in the copy window with Discord's mark (that button, the
-- sidebars' Discord mark, /polestar discord).
--
-- The game gives addons no clipboard and opens no links (LaunchURL is
-- Blizzard's alone): everything to take away sits in a read-only copy box,
-- selected for Ctrl+C, and a member copies only the report.
-- Built on first use; colours are Theme tokens only.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, ipairs, tostring, type, pcall = math.floor, math.max, ipairs, tostring, type, pcall

local R = {}
UI.Report = R

-- A Discord message holds 2000 characters. The description, every detail
-- line and the number of goals and errors are capped so that the whole
-- report, at its longest, stays under it (in bytes, which count no fewer).
R.DESC_MAX = 250
local LINE_MAX = 100
local GOALS_MAX = 6
local ERRORS_MAX = 3
local SEP = " \194\183 "
local UI_SEP = "  \194\183  "

---------------------------------------------------------------------------
-- The report
---------------------------------------------------------------------------

-- Text as it reads: the client's colour and texture codes out, escaped
-- pipes kept.
local function plain(s)
	s = tostring(s or ""):gsub("||", "\1")
	s = s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|T.-|t", "")
	return (s:gsub("\1", "||"))
end

-- s cut to n bytes, never inside a character.
local function cut(s, n)
	n = n or LINE_MAX
	if #s <= n then return s end
	return (s:sub(1, n - 3):gsub("[\192-\255][\128-\191]*$", "")) .. "..."
end

-- A position as a guide writes it: the map, then `@x,y`, marked `live`
-- unless it is in the Era frame (typed coordinates are read in it).
local function where(map, x, y, f)
	if not (map and x and y) then return nil end
	return ("map %d @%.2f,%.2f%s"):format(map, x, y, f == "e" and "" or " live")
end

local MARK = { done = "[x]", skipped = "[-]", na = "[n/a]" }

-- One goal: its state ([>] the arrow's, [x] done, [-] skipped, [n/a] not for
-- this character, [ ] open), its line and count, its ids and position.
local function goalLine(gv, raw, isCurrent, wp)
	local text = gv.text
	if type(text) ~= "string" or text == "" then text = (gv.verb or "") .. " " .. tostring(gv.subject or "") end
	local head = (isCurrent and "[>]" or MARK[gv.status] or "[ ]") .. " " .. plain(text):match("^%s*(.-)%s*$")
	local p = gv.progress
	if p and p.cur and p.max then head = head .. (" %s/%s"):format(tostring(p.cur), tostring(p.max)) end
	local parts = { head }
	if gv.quest then parts[#parts + 1] = "quest " .. tostring(gv.quest) end
	if gv.npc then parts[#parts + 1] = "npc " .. tostring(gv.npc) end
	if gv.item then parts[#parts + 1] = "item " .. tostring(gv.item) end
	if raw and raw.object then parts[#parts + 1] = "object " .. tostring(raw.object) end
	parts[#parts + 1] = where(gv.map, gv.x, gv.y, gv.f)
	if wp and wp.goalIndex == gv.index and type(wp.spots) == "table" and wp.spot then
		parts[#parts + 1] = ("spot %d of %d"):format(wp.spot, #wp.spots)
	end
	if gv.unavailableText then parts[#parts + 1] = plain(gv.unavailableText) end
	return cut(table.concat(parts, SEP))
end

local function versions()
	local v, build = "?", "?"
	if GetBuildInfo then
		local a, b = GetBuildInfo()
		v, build = tostring(a or "?"), tostring(b or "?")
	end
	local polestar = tostring(ns.version or "dev") .. (ns.stage and (" " .. ns.stage) or "")
	return cut((L["Polestar %s"]):format(polestar) .. SEP .. (L["client %s (%s)"]):format(v, build) .. SEP .. (GetLocale and GetLocale() or "?"))
end

local function character()
	local C = ns.Compat
	local p = C and C.GetPlayerInfo and C.GetPlayerInfo()
	if type(p) ~= "table" then return nil end
	local class = type(p.class) == "string" and (p.class:sub(1, 1) .. p.class:sub(2):lower()) or "?"
	local level = (L["level %d"]):format(p.level or 0)
	if (p.xpMax or 0) > 0 then level = level .. (" (%d%%)"):format(floor((p.xp or 0) / p.xpMax * 100)) end
	return cut(table.concat({ tostring(p.race or "?") .. " " .. class, level, tostring(p.faction or "?") }, SEP))
end

local function guideLines(out)
	local E = ns.Engine
	local guide = E and E.GetGuide and E.GetGuide()
	if not guide then
		out[#out + 1] = L["Guide: none open"]
		return
	end
	local G = ns.Guides
	local pack = guide.pack and G and G.Pack and G.Pack(guide.pack)
	local line = (L["Guide: %s (%s)"]):format(plain(guide.title or guide.id), tostring(guide.id))
	if pack then line = line .. SEP .. (L["pack %s"]):format(plain(pack.title or pack.id) .. (pack.version and (" " .. plain(pack.version)) or "")) end
	out[#out + 1] = cut(line)
	local index = E.GetStepIndex and E.GetStepIndex()
	local view = index and E.GetStepView and E.GetStepView(index)
	if not view then
		out[#out + 1] = L["Step: none, the guide is complete"]
		return
	end
	local count = E.GetStepCount and E.GetStepCount() or 0
	local step = (L["Step %d of %d: %s"]):format(index, count, plain(view.title or ""))
	if view.skipped then step = step .. SEP .. L["skipped"] end
	local live = E.GetLiveStep and E.GetLiveStep()
	if live and live ~= index then
		step = step .. SEP .. (L["the guide is at step %d"]):format(live)
	elseif E.GetLiveStep and not live then
		step = step .. SEP .. L["the guide is complete"]
	end
	out[#out + 1] = cut(step)
	local wp = E.GetWaypoint and E.GetWaypoint()
	local raws = guide.steps and guide.steps[index] and guide.steps[index].goals or {}
	for g, gv in ipairs(view.goals or {}) do
		if g > GOALS_MAX then
			out[#out + 1] = (L["... %d more goals"]):format(#view.goals - GOALS_MAX)
			break
		end
		out[#out + 1] = goalLine(gv, raws[g], view.current == g, wp)
	end
end

local function arrowLine()
	local N = ns.Nav
	local t = N and N.GetTarget and N.GetTarget()
	if not t then return L["Arrow: none"] end
	local line = (L["Arrow: %s"]):format(plain(t.label or "?"))
	local d = N.GetDistance and N.GetDistance()
	-- Always yards, whatever nav.distanceUnit says: the report is read by
	-- whoever fixes the bug, in the game's own unit.
	if d then line = line .. SEP .. ("%d yd"):format(floor(d + 0.5)) end
	if N.IsOverride and N.IsOverride() then
		line = line .. SEP .. L["your own waypoint"]
		local pos = where(t.map, t.x, t.y, t.f)
		if pos then line = line .. " " .. pos end
	end
	return cut(line)
end

local function playerLine()
	local C = ns.Compat
	local zone, sub
	if C and C.GetZoneText then zone, sub = C.GetZoneText() end
	local place = tostring(zone or "?") .. ((sub and sub ~= "") and (", " .. sub) or "")
	local map, x, y
	if C and C.GetPlayerMapPosition then map, x, y = C.GetPlayerMapPosition() end
	return cut((L["Where: %s"]):format(place) .. SEP .. (where(map, x, y) or L["no position"]))
end

-- Other guide packs that are on, with their versions.
local function packsLine()
	local G = ns.Guides
	if not (G and G.Packs) then return nil end
	local list = {}
	for _, r in ipairs(G.Packs()) do
		if not r.official and r.status == "on" then list[#list + 1] = plain(r.title or r.id) .. (r.version and (" " .. plain(r.version)) or "") end
	end
	if #list == 0 then return nil end
	return cut((L["Packs: %s"]):format(table.concat(list, ", ")))
end

-- The errors Polestar caught (ns.Errors), then with !BugGrabber installed the
-- ones it grabbed this session in Polestar's files, and the protected calls
-- the game blocked from Polestar (ns.Blocked; taint is no Lua error): the
-- newest few of them all, each with how often it came, an error by its path
-- from the AddOns folder, a blocked call by the Polestar addon blamed and
-- when it last came. Polestar's own say which came last (seq); !BugGrabber's,
-- whose order against them is unknown, count as the newest.
local function errorLines(out)
	local list, seen = {}, {}
	local function add(msg, count, seq)
		msg = tostring(msg):match("^[^\n]*"):gsub("^Interface[/\\]AddOns[/\\]", "")
		if seen[msg] then return end
		seen[msg] = true
		list[#list + 1] = { text = msg, count = count or 1, seq = seq or math.huge }
	end
	for _, e in ipairs(ns.Errors and ns.Errors() or {}) do add(e.msg, e.count, e.seq) end
	for _, b in ipairs(ns.Blocked and ns.Blocked() or {}) do
		list[#list + 1] = { text = L["blocked in %s: %s (%s)"]:format(b.addon, plain(b.fn), b.at), count = b.count, seq = b.seq }
	end
	local BG = BugGrabber
	if type(BG) == "table" and type(BG.GetDB) == "function" then
		local ok, db = pcall(BG.GetDB, BG)
		local session = type(BG.GetSessionId) == "function" and BG:GetSessionId() or nil
		if ok and type(db) == "table" then
			for _, e in ipairs(db) do
				if type(e) == "table" and type(e.message) == "string" and e.message:find("AddOns[/\\]Polestar")
					and (session == nil or e.session == session) then
					add(e.message, e.counter)
				end
			end
		end
	end
	if #list == 0 then
		out[#out + 1] = L["Errors: none"]
		return
	end
	-- Sorted by seq; !BugGrabber's (no seq) keep the order they were added in.
	for i = 1, #list do list[i].i = i end
	table.sort(list, function(a, b)
		if a.seq ~= b.seq then return a.seq < b.seq end
		return a.i < b.i
	end)
	out[#out + 1] = L["Errors:"]
	for i = max(1, #list - ERRORS_MAX + 1), #list do
		out[#out + 1] = cut(("  %dx %s"):format(list[i].count, list[i].text))
	end
end

-- The report's details, one line each, as they stand now.
function R.Details()
	local out = { versions(), character() }
	guideLines(out)
	out[#out + 1] = arrowLine()
	out[#out + 1] = playerLine()
	out[#out + 1] = packsLine()
	errorLines(out)
	local lines = {}
	for i = 1, #out do
		if out[i] then lines[#lines + 1] = out[i] end
	end
	return lines
end

-- The report to paste: what went wrong, in the player's words, then the
-- details as a code block (Discord keeps their lines and spacing). The bug
-- bot reads this layout back (tools/discord-bot/lib/report.js): the first
-- line's shape, the guide line's "(id)", the order of the lines.
function R.Text(description, details)
	local desc = tostring(description or ""):match("^%s*(.-)%s*$")
	if desc == "" then desc = L["(not described)"] end
	local out = { "**" .. L["What went wrong:"] .. "** " .. desc, "```" }
	for _, line in ipairs(details or R.Details()) do out[#out + 1] = line end
	out[#out + 1] = "```"
	return table.concat(out, "\n")
end

---------------------------------------------------------------------------
-- The window
---------------------------------------------------------------------------

local WIDTH = 440
local PAD = 24
local HEAD_H = 56
local BOX_W = WIDTH - PAD * 2
local DESC_LINES = 3
local LOGO = 32
local TEXT_X = PAD + LOGO + 12 -- the Discord block's text column

local F

local function put(obj, x, y)
	obj:ClearAllPoints()
	obj:SetPoint("TOPLEFT", F, "TOPLEFT", x, -y)
end

local function layout()
	local y = HEAD_H + 12
	put(F.Context, PAD, y)
	y = y + F.Context:GetStringHeight() + 16
	put(F.DescLabel, PAD, y)
	y = y + F.DescLabel:GetStringHeight() + 6
	put(F.Desc, PAD, y)
	y = y + F.Desc:GetHeight() + 16
	-- "Your report" and Select report share a row, the label on its middle.
	put(F.Select, WIDTH - PAD - F.Select:GetWidth(), y)
	F.BoxLabel:ClearAllPoints()
	F.BoxLabel:SetPoint("LEFT", F, "TOPLEFT", PAD, -(y + 14))
	y = y + 28 + 8
	put(F.Box, PAD, y)
	y = y + F.Box:GetHeight() + 16
	put(F.Rule, PAD, y)
	y = y + 1 + 16
	-- The mark's ink starts 2px into its texture and 5px down.
	put(F.Logo, PAD - 2, y - 4)
	put(F.DiscordTitle, TEXT_X, y)
	y = y + F.DiscordTitle:GetStringHeight() + 4
	put(F.DiscordNote, TEXT_X, y)
	y = y + F.DiscordNote:GetStringHeight() + 10
	put(F.Invite, TEXT_X, y)
	y = y + F.Invite:GetHeight()
	F:SetHeight(floor(y + PAD + 0.5))
end

-- The report box is as tall as its text, so it is read whole and copied
-- whole: measured in its own font at its inner width.
local function compose()
	local text = R.Text(F.Desc:GetText(), F.details)
	W.SetCopyText(F.Box, text)
	F.Measure:SetText(text)
	F.Box:SetHeight(floor(F.Measure:GetStringHeight() + 16 + 0.5))
	layout()
end

local function selectReport()
	F.Box:SetFocus()
	F.Box:HighlightText()
end

-- "Step 3 of 8 · Kobold Camp · Elwynn Forest": what the report is about.
local function context()
	local E = ns.Engine
	local guide = E and E.GetGuide and E.GetGuide()
	if not guide then return L["No guide open"] end
	local index = E.GetStepIndex and E.GetStepIndex()
	local view = index and E.GetStepView and E.GetStepView(index)
	local parts = {}
	if view then
		parts[#parts + 1] = (L["Step %d of %d"]):format(index, E.GetStepCount and E.GetStepCount() or 0)
		if view.title and view.title ~= "" then parts[#parts + 1] = plain(view.title) end
	end
	parts[#parts + 1] = plain(guide.title or guide.id)
	return table.concat(parts, UI_SEP)
end

local function stepKey()
	local E = ns.Engine
	local guide = E and E.GetGuide and E.GetGuide()
	return tostring(guide and guide.id) .. ":" .. tostring(E and E.GetStepIndex and E.GetStepIndex())
end

-- The description: the copy box's well and border, editable, its
-- placeholder in textMuted until the player types.
local function textArea()
	local e = CreateFrame("EditBox", nil, F)
	e:SetAutoFocus(false)
	e:SetMultiLine(true)
	e:SetMaxLetters(R.DESC_MAX)
	Theme.Font(e, "label")
	W.Color(e, "text")
	e:SetWidth(BOX_W)
	e:SetHeight(DESC_LINES * 16 + 16)
	e:SetTextInsets(10, 10, 8, 8)
	Theme.Skin(e, "editbox")
	e.Placeholder = W.Text(e, "label", "textMuted")
	e.Placeholder:SetPoint("TOPLEFT", e, "TOPLEFT", 10, -8)
	e.Placeholder:SetWidth(BOX_W - 20)
	e.Placeholder:SetJustifyH("LEFT")
	e.Placeholder:SetWordWrap(true)
	e.Placeholder:SetText(L["What the guide said, and what you found in the game."])
	e:SetScript("OnEditFocusGained", function(self) Theme.SetFocused(self, true) end)
	e:SetScript("OnEditFocusLost", function(self) Theme.SetFocused(self, false) end)
	e:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	e:SetScript("OnTabPressed", selectReport)
	e:SetScript("OnTextChanged", function(self)
		self.Placeholder:SetShown((self:GetText() or "") == "")
		if F.details then compose() end
	end)
	return e
end

local function build()
	F = CreateFrame("Frame", "PolestarReport", UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(WIDTH)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
	F:Hide()
	Theme.Skin(F, "window")

	local head = CreateFrame("Frame", nil, F)
	head:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	head:SetHeight(HEAD_H)
	head:EnableMouse(true)
	head:RegisterForDrag("LeftButton")
	head:SetScript("OnDragStart", function() F:StartMoving() end)
	head:SetScript("OnDragStop", function() F:StopMovingOrSizing() end)
	F.Band = Theme.Band(head, "BACKGROUND", -5)
	F.Band:SetAllPoints(head)
	F.Band:SetTexCoord(Theme.BandCoords(WIDTH - 2, HEAD_H))
	F.Close = W.IconButton(head, "close", 28, L["Close"], function() F:Hide() end, 14)
	F.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -14)
	F.Title = W.Text(head, "title", "text")
	F.Title:SetPoint("LEFT", head, "LEFT", PAD, 0)
	F.Title:SetPoint("RIGHT", F.Close, "LEFT", -8, 0)
	F.Title:SetJustifyH("LEFT")
	F.Title:SetWordWrap(false)
	F.Title:SetText(L["Report a problem"])

	F.Context = W.Text(F, "note", "textDim")
	F.Context:SetWidth(BOX_W)
	F.Context:SetJustifyH("LEFT")
	F.Context:SetWordWrap(false)

	F.DescLabel = W.Text(F, "label", "text")
	F.DescLabel:SetText(L["What went wrong?"])
	F.Desc = textArea()

	F.BoxLabel = W.Text(F, "label", "text")
	F.BoxLabel:SetText(L["Your report"])
	F.Select = W.Button(F, L["Select report"], selectReport, { primary = true })
	F.Box = W.CopyBox(F, { lines = 2 })
	Theme.Font(F.Box, "small")
	F.Box:SetWidth(BOX_W)
	F.Box:SetScript("OnTabPressed", function() F.Desc:SetFocus() end)
	-- The report's text in the box's font at its inner width, never seen:
	-- what the box's height is measured on.
	F.Measure = W.Text(F, "small", "text")
	F.Measure:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, 0)
	F.Measure:SetWidth(BOX_W - 20)
	F.Measure:SetJustifyH("LEFT")
	F.Measure:SetWordWrap(true)
	F.Measure:SetNonSpaceWrap(true)
	F.Measure:SetAlpha(0)

	F.Rule = W.Divider(F)
	F.Rule:SetWidth(BOX_W)
	F.Logo = W.Tex(F, "ARTWORK", "discord", "discord")
	F.Logo:SetSize(LOGO, LOGO)
	F.DiscordTitle = W.Text(F, "heading", "text")
	F.DiscordTitle:SetText(L["Polestar on Discord"])
	F.DiscordNote = W.Text(F, "note", "textDim")
	F.DiscordNote:SetWidth(WIDTH - TEXT_X - PAD)
	F.DiscordNote:SetJustifyH("LEFT")
	F.DiscordNote:SetWordWrap(true)
	F.DiscordNote:SetText(L["Copy your report with Ctrl+C (Cmd+C on a Mac), switch to Discord and paste it in the Polestar server. Not in it yet? Get the invite once and open it in your browser."])
	-- The game opens no links, so the invite is one more copy: only for a
	-- player who has not joined yet, in the copy window, never here beside
	-- the report.
	F.Invite = W.Button(F, L["Get the invite"], function() UI.ShowDiscord() end)

	F:SetScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.FAST, "out") end)
	ns.CloseOnEscape("PolestarReport")
	-- A gamepad (UI/Gamepad.lua) starts on "Select report".
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(F, {
			initial = function(rows)
				for i, w in ipairs(rows) do if w == F.Select then return i end end
			end,
		})
	end
end

-- Opens the window on the step on screen. The details are taken now; what
-- the player typed stays while it is the same step.
function UI.ShowReport()
	if not F then build() end
	local key = stepKey()
	F.details = R.Details()
	if key ~= F.key then F.Desc:SetText("") end
	F.key = key
	F.Desc.Placeholder:SetShown((F.Desc:GetText() or "") == "")
	F.Context:SetText(context())
	compose()
	F:Show()
	F:Raise()
	F.Desc:SetFocus()
end

-- The Polestar Discord's invite, in the copy window with Discord's mark.
function UI.ShowDiscord()
	UI.ShowCopy(L["Polestar on Discord"], ns.DiscordURL, {
		icon = "discord", iconColor = "discord",
		hint = L["Report problems, ask for help and hear about new guides first. The invite is selected for you: copy it with Ctrl+C (Cmd+C on a Mac) and open it in your browser."],
	})
end

-- The Polestar Discord at the foot of a shell's sidebar (the hub, the
-- options window): Discord's mark in its own colour at the end of the
-- version line, the invite on a click. Built once per shell.
function R.SidebarLink(f)
	if rawget(f, "Discord") or not rawget(f, "Sidebar") then return end
	local b = W.IconButton(f.Sidebar, "discord", 28, nil, function() UI.ShowDiscord() end, 20)
	W.Color(b.Icon, "discord")
	b:SetScript("OnEnter", function(self)
		W.Tooltip(self, "ANCHOR_RIGHT", L["Polestar on Discord"], { L["Report problems, ask for help and hear about new guides first."] })
	end)
	b:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	-- The mark's ink on the sidebar's 24 edge, centred on the version line.
	b:SetPoint("RIGHT", f.Sidebar, "BOTTOMRIGHT", -(W.SHELL.side - 6), W.SHELL.foot + 7)
	f.Discord = b
end

ns.On("SHOW_REPORT", function() UI.ShowReport() end)
ns.On("SHOW_DISCORD", function() UI.ShowDiscord() end)
