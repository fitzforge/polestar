-- Report a problem: the window behind the guide window's bug button (in the
-- navigator, beside Skip and the menu), its menu entry and /polestar report.
-- The player says what went wrong; the report sets that above everything a
-- fix needs, taken when the window opens: the guide and the step on screen
-- with every goal's state, ids and position, the arrow, where the player
-- stands, the versions, other packs and addons and the errors Polestar
-- caught. "Mark the right spot" adds where the step should have sent the
-- player, marked from a bar while the window steps aside. Then the way to
-- send it, the Polestar Discord's #bugs, whose bot files each post as a
-- GitHub issue: "Copy report" shows the report, selected, sized to stay
-- inside one Discord message, and "Get the invite" is for a player not in it
-- yet. Last, for a player with a GitHub account, "Open on GitHub" gives a
-- link that opens a new issue with the report, its title, the version and
-- the addons filled in (R.IssueURL). UI.ShowDiscord: the invite alone
-- (ns.DiscordURL), in the copy window with Discord's mark (that button, the
-- sidebars' Discord mark, /polestar discord).
--
-- The game gives addons no clipboard and opens no links (LaunchURL is
-- Blizzard's alone): everything to take away sits in a read-only copy box,
-- selected for Ctrl+C: the issue link, or the report for Discord.
-- Built on first use; colours are Theme tokens only.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, min, ipairs, pairs, tostring, type, pcall = math.floor, math.max, math.min, ipairs, pairs, tostring, type, pcall

local R = {}
UI.Report = R

-- A Discord message holds 2000 characters. The description, the detail
-- lines and the number of goals and errors are capped; when the report is
-- still longer, R.Text shortens its Addons line, which the Discord bot
-- quotes but does not read.
R.DESC_MAX = 250
-- Fewer letters than this say nothing a fix can go on: the report waits.
R.DESC_MIN = 5
R.TEXT_MAX = 2000
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

-- s on one line, for a field GitHub shows as one.
local function oneLine(s)
	return (s:gsub("%s+", " "))
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

local function polestarVersion()
	return tostring(ns.version or "dev") .. (ns.stage and (" " .. ns.stage) or "")
end

local function versions()
	local v, build = "?", "?"
	if GetBuildInfo then
		local a, b = GetBuildInfo()
		v, build = tostring(a or "?"), tostring(b or "?")
	end
	return cut((L["Polestar %s"]):format(polestarVersion()) .. SEP .. (L["client %s (%s)"]):format(v, build) .. SEP .. (GetLocale and GetLocale() or "?"))
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

-- The guide on screen, its title as it reads, its step count and the step
-- on screen: its index and its view, nil past the last step.
local function onScreen()
	local E = ns.Engine
	local guide = E and E.GetGuide and E.GetGuide()
	if not guide then return {} end
	local index = E.GetStepIndex and E.GetStepIndex()
	return { guide = guide, title = plain(guide.title or guide.id), index = index,
		view = index and E.GetStepView and E.GetStepView(index), count = E.GetStepCount and E.GetStepCount() or 0 }
end

-- "Step 3 of 8 · Kobold Camp · Elwynn Forest": what the report is about.
local function context(on)
	if not on.guide then return L["No guide open"] end
	local parts = {}
	if on.view then
		parts[#parts + 1] = (L["Step %d of %d"]):format(on.index, on.count)
		if on.view.title and on.view.title ~= "" then parts[#parts + 1] = plain(on.view.title) end
	end
	parts[#parts + 1] = on.title
	return table.concat(parts, UI_SEP)
end

local function guideLines(d, on)
	local out, E, guide, index, view = d.lines, ns.Engine, on.guide, on.index, on.view
	if not guide then
		out[#out + 1] = L["Guide: none open"]
		return
	end
	local G = ns.Guides
	local pack = guide.pack and G and G.Pack and G.Pack(guide.pack)
	local line = (L["Guide: %s (%s)"]):format(on.title, tostring(guide.id))
	if pack then line = line .. SEP .. (L["pack %s"]):format(plain(pack.title or pack.id) .. (pack.version and (" " .. plain(pack.version)) or "")) end
	out[#out + 1] = cut(line)
	if not view then
		out[#out + 1] = L["Step: none, the guide is complete"]
		return
	end
	local step = (L["Step %d of %d: %s"]):format(index, on.count, plain(view.title or ""))
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
	local goals = view.goals or {}
	local shown = min(#goals, GOALS_MAX)
	d.goals = { first = #out + 1, last = #out + shown, more = #goals - shown }
	for g = 1, shown do
		if view.current == g then d.goals.current = #out + 1 end
		out[#out + 1] = goalLine(goals[g], raws[g], view.current == g, wp)
	end
	if d.goals.more > 0 then out[#out + 1] = (L["... %d more goals"]):format(d.goals.more) end
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

-- How the arrow is set to route, so a pathing report says which router and
-- style it came from: the route style (nav.routeStyle) as its setting's own
-- word, then only the settings that differ from the defaults (walking maps
-- off, the travel planner off, guiding handed to Shortest Path Forever). The
-- words stay English, like "yd": whoever fixes the bug reads them. After the
-- Where line, so the bug bot still finds Arrow and Where by position.
local function routesLine()
	local style = ns.Get("nav.routeStyle")
	local parts = { (style == "fastest" or style == "roads") and style or "balanced" }
	if ns.Get("nav.navRouting") == false then parts[#parts + 1] = "real paths off" end
	if ns.Get("nav.travel") == false then parts[#parts + 1] = "travel planner off" end
	local N = ns.Nav
	if N and N.HandedOff and N.HandedOff() then parts[#parts + 1] = "handed to Shortest Path Forever" end
	return cut((L["Routes: %s"]):format(table.concat(parts, SEP)))
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

-- Words in an addon's folder name that mark one whose arrows, quest lines or
-- map pins can look like Polestar's (Questie, TomTom, other guides).
local SUSPECT = { "quest", "guide", "map", "tomtom", "arrow", "waypoint", "nav", "route" }

local function suspect(name)
	local n = name:lower()
	for _, w in ipairs(SUSPECT) do
		if n:find(w, 1, true) then return true end
	end
	return false
end

-- The other addons that are loaded, "name version" each (`withVersions`)
-- or names only: quest, map and guide addons first, then A to Z, so a list
-- cut short keeps the ones most likely to be the cause.
local function otherAddons(withVersions)
	local A = C_AddOns or {}
	local count = A.GetNumAddOns or GetNumAddOns
	local info = A.GetAddOnInfo or GetAddOnInfo
	local loaded = A.IsAddOnLoaded or IsAddOnLoaded
	local meta = A.GetAddOnMetadata or GetAddOnMetadata
	local list = {}
	if not (count and info and loaded) then return list end
	for i = 1, count() do
		local name = info(i)
		if type(name) == "string" and not name:find("^Polestar") and loaded(name) then
			local v = withVersions and meta and meta(name, "Version")
			list[#list + 1] = { name = name, first = suspect(name),
				text = (type(v) == "string" and v ~= "") and (name .. " " .. plain(v)) or name }
		end
	end
	table.sort(list, function(a, b)
		if a.first ~= b.first then return a.first end
		return a.name:lower() < b.name:lower()
	end)
	for i, a in ipairs(list) do list[i] = a.text end
	return list
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

-- The report's details, taken once when the window opens: the issue link
-- and the report for Discord are made from them alone, so they say the
-- same whatever the guide does while the window is open.
--   lines     one fact each, in the order the Discord bot reads them
--   key       the guide and the step, to tell a report on another step
--   context   the line under the window's title
--   goals     where the step's goal lines sit in `lines`: first, last, the
--             arrow's (current), and how many more were not listed
--   names     the other addons' names, for the report's Addons line
--   addons    the other addons with their versions, for the issue's field
--   issue     on a step, the facts a "Wrong step" issue names: the guide's
--             title, the step's index and title, the character
function R.Details()
	local on = onScreen()
	local who = character()
	local d = { lines = { versions(), who }, context = context(on), names = otherAddons(), addons = otherAddons(true),
		key = tostring(on.guide and on.guide.id) .. ":" .. tostring(on.index) }
	local out = d.lines
	guideLines(d, on)
	out[#out + 1] = arrowLine()
	out[#out + 1] = playerLine()
	out[#out + 1] = routesLine()
	out[#out + 1] = packsLine()
	errorLines(out)
	if on.view then
		d.issue = { guide = oneLine(on.title), index = on.index, step = oneLine(plain(on.view.title or "")), character = who }
	end
	return d
end

-- What the player typed, trimmed, or "(not described)".
-- s without the spaces around it: ASCII ones, and the no-break space and the
-- ideographic space (U+3000) a Chinese, Japanese or Korean input method types.
local function trimmed(s)
	local prev
	s = tostring(s or "")
	repeat
		prev = s
		s = s:gsub("^%s+", ""):gsub("%s+$", "")
		s = s:gsub("^\194\160", ""):gsub("\194\160$", "")
		s = s:gsub("^\227\128\128", ""):gsub("\227\128\128$", "")
	until s == prev
	return s
end

local function described(description)
	local desc = trimmed(description)
	return desc ~= "" and desc or L["(not described)"]
end

local function bold(label, s)
	return "**" .. label .. "** " .. s
end

-- The report to paste: what went wrong, in the player's words, the right
-- spot when the player marked one and the other addons (`names`, when
-- given) as bold lines a reader sees at once, then the details as a code
-- block (Discord keeps their lines and spacing). The bug bot reads this
-- layout back (tools/discord-bot/lib/report.js): everything above the code
-- block is the description it quotes in the issue; in the block, the first
-- line's shape, the guide line's "(id)", the order of the lines.
local function text(description, lines, spot, names)
	local out = { bold(L["What went wrong:"], described(description)) }
	if spot then out[#out + 1] = bold(L["Right spot:"], cut(table.concat(spot, SEP))) end
	if names then out[#out + 1] = bold(L["Addons:"], names) end
	out[#out + 1] = "```"
	for _, line in ipairs(lines) do out[#out + 1] = line end
	out[#out + 1] = "```"
	return table.concat(out, "\n")
end

-- Characters as Discord counts them, like JavaScript: one each, two past
-- U+FFFF. Not bytes: a Chinese report of 1200 characters is 2500 bytes.
local function length(s)
	local _, chars = s:gsub("[^\128-\191]", "")
	local _, astral = s:gsub("[\240-\247]", "")
	return chars + astral
end

-- With no other addons there is no Addons line.
function R.Text(description, details, spot)
	local names = #details.names > 0 and cut(table.concat(details.names, ", ")) or nil
	local report = text(description, details.lines, spot, names)
	local n = names and #names or 0
	while length(report) > R.TEXT_MAX and n > 0 do
		n = n - (length(report) - R.TEXT_MAX)
		-- Shorter than 20 bytes it names hardly an addon: the line goes.
		if n < 20 then n = 0 end
		report = text(description, details.lines, spot, n > 0 and cut(names, n) or nil)
	end
	return report
end

local function encode(s)
	return (tostring(s):gsub("[^%w%-%._~]", function(c) return ("%%%02X"):format(c:byte()) end))
end

-- GitHub answers a longer link with an error: measured on 2026-10-16, a
-- link of 6400 characters opened the form (signed out too, through the
-- sign-in page) and one of 6700 did not.
R.LINK_MAX = 6000

local function addonsHead(n)
	return ("The player has %d other addons on. The ones that fit in the link, quest, map and guide addons first:"):format(n)
end

-- The addons field: every addon when they fit in `room` characters of the
-- link, else a line that counts them and as many as fit, in their order.
local function addonsField(list, room)
	local all = table.concat(list, "\n")
	if #encode(all) <= room then return all end
	local head = addonsHead(#list)
	local used = #encode(head)
	if used > room then return nil end
	local lines = { head }
	for _, a in ipairs(list) do
		used = used + #encode("\n" .. a)
		if used > room then break end
		lines[#lines + 1] = a
	end
	return table.concat(lines, "\n")
end

-- The longest start of s whose encoding fits in `room` characters, never
-- cut inside a character.
local function fitEncoded(s, room)
	local used, n = 0, 0
	for i = 1, #s do
		used = used + (s:sub(i, i):find("^[%w%-%._~]$") and 1 or 3)
		if used > room then break end
		n = i
	end
	if n == #s then return s end
	return (s:sub(1, n):gsub("[\192-\255][\128-\191]*$", ""))
end

-- The details without the last n goals other than the arrow's, and one line
-- that counts every goal not listed.
local function withoutGoals(details, n)
	local g, out, gone, left = details.goals, {}, {}, n
	for i = g.last, g.first, -1 do
		if left == 0 then break end
		if i ~= g.current then gone[i], left = true, left - 1 end
	end
	local moreAt = g.more > 0 and g.last + 1
	for i, line in ipairs(details.lines) do
		if not gone[i] and i ~= moreAt then out[#out + 1] = line end
		if i == g.last then out[#out + 1] = ("... %d goals left out to fit the link"):format(n + g.more) end
	end
	return out
end

-- The report for the issue's own field, encoded, in `room` characters of
-- the link. A CJK report encodes to three times the characters of an
-- English one, so goals after the arrow's go first, then the report is cut
-- with its code block still closed.
-- The addons have their own field: in the body they would only take room.
local function bodyField(description, details, spot, room)
	local report = text(description, details.lines, spot)
	local g = details.goals
	local droppable = g and (g.last - g.first + 1 - (g.current and 1 or 0)) or 0
	for n = 1, droppable do
		if #encode(report) <= room then break end
		report = text(description, withoutGoals(details, n), spot)
	end
	if #encode(report) > room then
		local close = "...\n```"
		report = fitEncoded(report:sub(1, -5), room - #encode(close)) .. close
	end
	return encode(report)
end

-- A link that opens a new issue on Polestar's GitHub with the report in
-- it: GitHub fills the title and the issue form's fields (by their ids in
-- .github/ISSUE_TEMPLATE) from the link's query. A "Wrong step" issue when
-- the player marked the right spot on a step (`spot`, ns.WhereLines, for
-- that form's own field), a "Bug report" otherwise: only the fields the
-- form has are sent.
-- The short fields come first, each bounded; the report gets the room they
-- leave, less the addons field's count line, and the addons what is left.
function R.IssueURL(description, details, spot)
	local issue = spot and details.issue
	local title
	if issue then
		title = ("Wrong step: %s, step %d"):format(cut(issue.guide, 80), issue.index)
	else
		title = "Bug: " .. cut(oneLine(described(description):match("^[^\n]*")), 80)
	end
	local fields = {
		{ "template", issue and "wrong-step.yml" or "bug-report.yml" },
		{ "title", title },
		{ "version", polestarVersion() },
	}
	local body, bodySpot = "steps", spot
	if issue then
		body, bodySpot = "wrong", nil
		fields[#fields + 1] = { "guide", cut(issue.guide) }
		fields[#fields + 1] = { "step", cut(issue.index .. ": " .. issue.step) }
		fields[#fields + 1] = { "character", issue.character }
		fields[#fields + 1] = { "where", table.concat(spot, "\n") }
	end
	local query = {}
	for _, f in ipairs(fields) do
		if f[2] and f[2] ~= "" then query[#query + 1] = f[1] .. "=" .. encode(f[2]) end
	end
	local url = ns.IssueURL .. "?" .. table.concat(query, "&")
	local list = details.addons
	local reserve = #list > 0 and #"&addons=" + #encode(addonsHead(#list)) or 0
	url = url .. "&" .. body .. "=" .. bodyField(description, details, bodySpot, R.LINK_MAX - #url - #body - 2 - reserve)
	local addons = addonsField(list, R.LINK_MAX - #url - #"&addons=")
	if addons and addons ~= "" then url = url .. "&addons=" .. encode(addons) end
	return url
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
	y = y + F.Desc:GetHeight() + 12
	put(F.SpotNote, PAD, y)
	y = y + F.SpotNote:GetStringHeight() + 8
	put(F.Mark, PAD, y)
	F.Clear:ClearAllPoints()
	F.Clear:SetPoint("LEFT", F.Mark, "RIGHT", 8, 0)
	y = y + F.Mark:GetHeight() + 16
	put(F.Rule, PAD, y)
	y = y + 1 + 16
	-- The mark's ink starts 2px into its texture and 5px down.
	put(F.Logo, PAD - 2, y - 4)
	put(F.DiscordTitle, TEXT_X, y)
	y = y + F.DiscordTitle:GetStringHeight() + 4
	put(F.DiscordNote, TEXT_X, y)
	y = y + F.DiscordNote:GetStringHeight() + 10
	put(F.Copy, TEXT_X, y)
	F.Invite:ClearAllPoints()
	F.Invite:SetPoint("LEFT", F.Copy, "RIGHT", 8, 0)
	y = y + F.Copy:GetHeight()
	if F.Box:IsShown() then
		y = y + 12
		put(F.Box, PAD, y)
		y = y + F.Box:GetHeight()
	end
	y = y + 16
	put(F.GitHubRule, PAD, y)
	y = y + 1 + 12
	-- One row: the note beside its button, centred on each other.
	local bw = F.GitHub:GetWidth()
	F.GitHubNote:SetWidth(BOX_W - bw - 12)
	local nh, bh = F.GitHubNote:GetStringHeight(), F.GitHub:GetHeight()
	local row = max(nh, bh)
	put(F.GitHubNote, PAD, y + floor((row - nh) / 2 + 0.5))
	put(F.GitHub, WIDTH - PAD - bw, y + floor((row - bh) / 2 + 0.5))
	y = y + row
	F:SetHeight(floor(y + PAD + 0.5))
end

local function showSpot()
	if F.spot then
		F.SpotNote:SetText((L["Right spot marked: %s"]):format(table.concat(F.spot, SEP)))
		W.SetButtonText(F.Mark, L["Mark again"])
		F.Clear:Show()
	else
		F.Clear:Hide()
		F.SpotNote:SetText(L["Optional: is the step sending you to the wrong place? Mark the right spot and it goes in your report."])
		W.SetButtonText(F.Mark, L["Mark the right spot"])
	end
end

-- Whether the player said what went wrong: Copy report and Open on GitHub
-- wait for it, so no report goes out "(not described)". Characters, one
-- each: not Discord's count, where an emoji is two.
local function saidEnough()
	local _, chars = trimmed(F.Desc:GetText()):gsub("[^\128-\191]", "")
	return chars >= R.DESC_MIN
end

local function gate()
	local ok = saidEnough()
	for _, b in ipairs({ F.Copy, F.GitHub }) do
		b:SetEnabled(ok)
		b:SetAlpha(ok and 1 or 0.5)
		b.psTip = not ok and L["Say what went wrong first."] or nil
		if ok then W.HideTooltip(b) end
	end
	if not ok then F.Box:Hide() end
	return ok
end

-- The report box is as tall as its text, so it is read whole and copied
-- whole: measured in its own font at its inner width.
local function compose()
	showSpot()
	gate()
	local report = R.Text(F.Desc:GetText(), F.details, F.spot)
	W.SetCopyText(F.Box, report)
	F.Measure:SetText(report)
	F.Box:SetHeight(floor(F.Measure:GetStringHeight() + 16 + 0.5))
	layout()
end

-- The report for Discord, shown under its buttons only when asked for.
local function copyReport()
	if not gate() then return end
	F.Box:Show()
	layout()
	F.Box:SetFocus()
	F.Box:HighlightText()
end

local function openGitHub()
	if not gate() then return end
	UI.ShowCopy(L["Open on GitHub"], R.IssueURL(F.Desc:GetText(), F.details, F.spot), {
		hint = L["The link is selected for you: copy it with Ctrl+C (Cmd+C on a Mac), paste it in your browser's address bar, check the form and press Create."],
	})
end

---------------------------------------------------------------------------
-- Marking the right spot: the window steps aside for a bar while the player
-- walks there; the report it took when it opened is kept, so walking about
-- changes nothing in it.
---------------------------------------------------------------------------

local MARK_W = 360
local M

local function backToReport()
	M:Hide()
	compose()
	F:Show()
	F:Raise()
end

local function markHere()
	local lines = ns.WhereLines()
	if not lines then
		M.Note:SetText(L["No position here: the game gives none in instances and on some maps."])
		return
	end
	F.spot = lines
	backToReport()
end

local function buildMark()
	M = CreateFrame("Frame", "PolestarMark", UIParent)
	M:SetFrameStrata("DIALOG")
	M:SetToplevel(true)
	M:SetClampedToScreen(true)
	M:EnableMouse(true)
	M:SetMovable(true)
	M:RegisterForDrag("LeftButton")
	M:SetScript("OnDragStart", M.StartMoving)
	M:SetScript("OnDragStop", M.StopMovingOrSizing)
	M:SetWidth(MARK_W)
	M:SetPoint("TOP", UIParent, "TOP", 0, -120)
	M:Hide()
	Theme.Skin(M, "window")
	M.Title = W.Text(M, "heading", "text")
	M.Title:SetPoint("TOPLEFT", M, "TOPLEFT", PAD, -PAD)
	M.Title:SetText(L["Mark the right spot"])
	M.Note = W.Text(M, "note", "textDim")
	M.Note:SetPoint("TOPLEFT", M.Title, "BOTTOMLEFT", 0, -6)
	M.Note:SetWidth(MARK_W - PAD * 2)
	M.Note:SetJustifyH("LEFT")
	M.Note:SetWordWrap(true)
	M.Here = W.Button(M, L["Mark here"], markHere, { primary = true })
	M.Here:SetPoint("TOPLEFT", M.Note, "BOTTOMLEFT", 0, -12)
	M.Cancel = W.Button(M, L["Cancel"], backToReport)
	M.Cancel:SetPoint("LEFT", M.Here, "RIGHT", 8, 0)
	if ns.Gamepad and ns.Gamepad.Register then ns.Gamepad.Register(M, { back = backToReport }) end
end

local function startMark()
	if not M then buildMark() end
	M.Note:SetText(L["Walk to where the step should have sent you: the NPC, the object or the mobs as you found them. Then press Mark here. Your report is kept while you walk."])
	M:SetHeight(floor(PAD + M.Title:GetStringHeight() + 6 + M.Note:GetStringHeight() + 12 + M.Here:GetHeight() + PAD + 0.5))
	F:Hide()
	M:Show()
	M:Raise()
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
	F.SpotNote = W.Text(F, "note", "textDim")
	F.SpotNote:SetWidth(BOX_W)
	F.SpotNote:SetJustifyH("LEFT")
	F.SpotNote:SetWordWrap(true)
	F.Mark = W.Button(F, L["Mark the right spot"], startMark)
	F.Clear = W.Button(F, L["Clear mark"], function()
		F.spot = nil
		compose()
	end)
	F.Clear:Hide()

	F.Box = W.CopyBox(F, { lines = 2 })
	F.Box:Hide()
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
	F.DiscordTitle:SetText(L["Report it on Discord"])
	F.DiscordNote = W.Text(F, "note", "textDim")
	F.DiscordNote:SetWidth(WIDTH - TEXT_X - PAD)
	F.DiscordNote:SetJustifyH("LEFT")
	F.DiscordNote:SetWordWrap(true)
	F.DiscordNote:SetText(L["1. Press Copy report, then Ctrl+C (Cmd+C on a Mac).\n2. In the Polestar Discord, open #bugs and press New Post. Not in it yet? Get the invite.\n3. Paste the report, give it a short title and post it. A bot files it for the developers and tells you in your thread when it's fixed."])
	F.Copy = W.Button(F, L["Copy report"], copyReport, { primary = true })
	-- The game opens no links, so the invite is one more copy: only for a
	-- player who has not joined yet, in the copy window, never here beside
	-- the report.
	F.Invite = W.Button(F, L["Get the invite"], function() UI.ShowDiscord() end)

	-- GitHub, for a player who has an account: the same report in a filled-in
	-- issue (R.IssueURL).
	F.GitHubRule = W.Divider(F)
	F.GitHubRule:SetWidth(BOX_W)
	F.GitHubNote = W.Text(F, "note", "textDim")
	F.GitHubNote:SetJustifyH("LEFT")
	F.GitHubNote:SetWordWrap(true)
	F.GitHubNote:SetText(L["Have a GitHub account? Open the issue there with everything filled in."])
	F.GitHub = W.Button(F, L["Open on GitHub"], openGitHub)
	-- Their tooltip says why they wait, so it shows while they are disabled.
	for _, b in ipairs({ F.Copy, F.GitHub }) do
		if b.SetMotionScriptsWhileDisabled then b:SetMotionScriptsWhileDisabled(true) end
	end

	F:SetScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.FAST, "out") end)
	ns.CloseOnEscape("PolestarReport")
	-- A gamepad (UI/Gamepad.lua) starts on "Copy report".
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(F, {
			initial = function(rows)
				-- Copy report while it waits is left out of the rows: then Mark,
				-- never the first row, the ✕.
				for _, want in ipairs({ F.Copy, F.Mark }) do
					for i, w in ipairs(rows) do if w == want then return i end end
				end
			end,
		})
	end
end

-- Opens the window on the step on screen. The details are taken now; what
-- the player typed stays while it is the same step.
function UI.ShowReport()
	-- Opened again while the player walks to mark the right spot (the bug
	-- button, the menu, /polestar report): back to the report they started,
	-- not a new one about wherever the guide is now.
	if M and M:IsShown() then
		backToReport()
		F.Desc:SetFocus()
		return
	end
	if not F then build() end
	F.details = R.Details()
	if F.details.key ~= F.key then
		F.Desc:SetText("")
		F.spot = nil
	end
	if M then M:Hide() end
	F.key = F.details.key
	F.Desc.Placeholder:SetShown((F.Desc:GetText() or "") == "")
	F.Context:SetText(F.details.context)
	F.Box:Hide()
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
