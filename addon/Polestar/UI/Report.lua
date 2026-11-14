-- Report a problem: the window behind the guide window's bug button (in the
-- navigator, beside Skip and the menu), its menu entry and /polestar report.
-- The player says what went wrong; the report sets that above everything a
-- fix needs, taken when the window opens: the guide and the step on screen
-- with every goal's state, ids and position, the arrow, where the player
-- stands, the versions, other packs and addons, the settings the player
-- changed from their defaults and the errors Polestar caught. On an old
-- Polestar (Core/Update.lua knows a newer release) a line
-- at the top asks to update first, and the version says "(outdated: latest
-- 0.3.7)". "Mark the right spot" adds where the step should have sent the
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

-- A Discord message holds 2000 characters. The detail lines and the
-- number of goals and errors are capped; the description, up to DESC_MAX
-- letters, is always kept whole. When the report is still longer, R.Text
-- gives up details in a fixed order (cutOrder) and says so on the
-- block's last line.
R.DESC_MAX = 1000
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

-- Characters as Discord counts them, like JavaScript: one each, two past
-- U+FFFF. Not bytes: a Chinese report of 1200 characters is 2500 bytes.
local function length(s)
	local _, chars = s:gsub("[^\128-\191]", "")
	local _, astral = s:gsub("[\240-\247]", "")
	return chars + astral
end

-- A position as a guide writes it: the map, then `@x,y`, marked `live`
-- unless it is in the Era frame (typed coordinates are read in it).
local function where(map, x, y, f)
	if not (map and x and y) then return nil end
	return ("map %d @%.2f,%.2f%s"):format(map, x, y, f == "e" and "" or " live")
end

local MARK = { done = "[x]", skipped = "[-]", na = "[n/a]" }
-- The window's current goal, and the goal the arrow leads to when the player
-- picked another one (a row click, the waypoint keys: #1385).
local CURRENT, ARROW = "[>]", "[\226\134\146]"

-- One goal: its state (`mark`: CURRENT the window's current goal, ARROW the
-- arrow's when it is another; else [x] done, [-] skipped, [n/a] not for this
-- character, [ ] open), its line and count, its ids and position.
local function goalLine(gv, raw, mark, wp)
	local text = gv.text
	if type(text) ~= "string" or text == "" then text = (gv.verb or "") .. " " .. tostring(gv.subject or "") end
	local head = (mark or MARK[gv.status] or "[ ]") .. " " .. plain(text):match("^%s*(.-)%s*$")
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
	if gv.noticeText then parts[#parts + 1] = plain(gv.noticeText) end
	return cut(table.concat(parts, SEP))
end

-- The version, its stage, and " (outdated: latest 0.3.7)" when a newer
-- release is known (Core/Update.lua), so triage sees it.
local function polestarVersion()
	local U = ns.Update
	return tostring(ns.version or "dev") .. (ns.stage and (" " .. ns.stage) or "") .. (U and U.Outdated() or "")
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
-- on screen: its index and its view, nil past the last step; `number` and
-- `total` as the player counts them (UI.StepNo, #942).
local function onScreen()
	local E = ns.Engine
	local guide = E and E.GetGuide and E.GetGuide()
	if not guide then return {} end
	local index = E.GetStepIndex and E.GetStepIndex()
	return { guide = guide, title = plain(guide.title or guide.id), index = index,
		view = index and E.GetStepView and E.GetStepView(index), count = E.GetStepCount and E.GetStepCount() or 0,
		number = index and UI.StepNo(index), total = UI.StepTotal() }
end

-- "Step 3 of 8 · Kobold Camp · Elwynn Forest": what the report is about.
local function context(on)
	if not on.guide then return L["No guide open"] end
	local parts = {}
	if on.view then
		parts[#parts + 1] = (L["Step %d of %d"]):format(on.number, on.total)
		if on.view.title and on.view.title ~= "" then parts[#parts + 1] = plain(on.view.title) end
	end
	parts[#parts + 1] = on.title
	return table.concat(parts, UI_SEP)
end

-- The line `line` of kind `kind` (what cutOrder trims by) at the end of
-- the details; nothing for nil.
local function add(d, kind, line)
	if not line then return end
	local n = #d.lines + 1
	d.lines[n], d.kinds[n] = line, kind
end

local function guideLines(d, on)
	local out, E, guide, index, view = d.lines, ns.Engine, on.guide, on.index, on.view
	if not guide then
		add(d, "guide", L["Guide: none open"])
		return
	end
	local G = ns.Guides
	local pack = guide.pack and G and G.Pack and G.Pack(guide.pack)
	local line = (L["Guide: %s (%s)"]):format(on.title, plain(tostring(guide.id)))
	if pack then line = line .. SEP .. (L["pack %s"]):format(plain(pack.title or pack.id) .. (pack.version and (" " .. plain(pack.version)) or "")) end
	add(d, "guide", cut(line))
	-- The steps the Engine planned for the character (#1353), for triage only:
	-- the guide window shows none of this.
	if guide.fromBase then
		add(d, "planned", cut("[planned: " .. (guide.feeders or 0) .. " feeder steps, ~" .. floor((guide.feedCost or 0) / 60 + 0.5) .. " min]"))
		local hidden = {}
		for q, h in pairs(guide.hidden or {}) do hidden[#hidden + 1] = { q = q, h = h } end
		table.sort(hidden, function(a, b) return a.q < b.q end)
		for i, e in ipairs(hidden) do
			if i > 8 then
				add(d, "planned", "[hidden: " .. (#hidden - 8) .. " more]")
				break
			end
			local h = e.h
			add(d, "planned", (plain(h.title or ("#" .. e.q)) .. " [hidden: needs " .. plain(h.needTitle or ("#" .. tostring(h.need))) .. " from " .. plain(h.from or "?") .. "]"))
		end
	end
	if not view then
		add(d, "step", L["Step: none, the guide is complete"])
		return
	end
	-- The guide's own step index too, which maintainers find the step by.
	local step = (L["Step %d of %d (guide step %d): %s"]):format(on.number, on.total, index, plain(view.title or ""))
	if view.skipped then step = step .. SEP .. L["skipped"] end
	-- A feeder step the Engine put in (#1353): where it comes from, for triage only.
	local raw = guide.steps and guide.steps[index]
	if raw and raw.feeder then
		step = step .. SEP .. "[feeder from " .. plain(tostring(raw.feeder)) .. " step " .. tostring(raw.feederStep) .. "]"
	end
	local live = E.GetLiveStep and E.GetLiveStep()
	if live and live ~= index then
		step = step .. SEP .. (L["the guide is at step %d"]):format(UI.StepNo(live))
	elseif E.GetLiveStep and not live then
		step = step .. SEP .. L["the guide is complete"]
	end
	add(d, "step", cut(step))
	local wp = E.GetWaypoint and E.GetWaypoint()
	-- The arrow's goal on this step, when the player picked one other than
	-- the window's current goal.
	local picked = wp and wp.stepIndex == index and wp.goalIndex ~= view.current and wp.goalIndex or nil
	local raws = guide.steps and guide.steps[index] and guide.steps[index].goals or {}
	local goals = view.goals or {}
	local shown = min(#goals, GOALS_MAX)
	d.goals = { first = #out + 1, last = #out + shown, more = #goals - shown }
	for g = 1, shown do
		if view.current == g then d.goals.current = #out + 1 end
		if picked == g then d.goals.arrow = #out + 1 end
		local mark = (view.current == g and CURRENT) or (picked == g and ARROW) or nil
		add(d, "goal", goalLine(goals[g], raws[g], mark, wp))
	end
	if d.goals.more > 0 then add(d, "more", (L["... %d more goals"]):format(d.goals.more)) end
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
	local own = N.IsOverride and N.IsOverride()
	-- Held (the way back to your corpse or a Spirit Healer, Nav.Hold): its label says whose it is.
	if own or (N.IsHeld and N.IsHeld()) then
		if own then line = line .. SEP .. L["your own waypoint"] end
		local pos = where(t.map, t.x, t.y, t.f)
		if pos then line = line .. (own and " " or SEP) .. pos end
	end
	return cut(line)
end

-- Where the player is, and the height of the floor Polestar takes them to stand on (Nav/Walk.lua Walk.Floor: the
-- client gives no height on Forever; the floor Walk follows while the arrow walks), "z 16": a walk searched from
-- another floor than the player's goes round (#2215: beside an NPC on his upper floor, the route out of the building
-- and back up).
local function playerLine()
	local C = ns.Compat
	local zone, sub
	if C and C.GetZoneText then zone, sub = C.GetZoneText() end
	local place = tostring(zone or "?") .. ((sub and sub ~= "") and (", " .. sub) or "")
	local map, x, y
	if C and C.GetPlayerMapPosition then map, x, y = C.GetPlayerMapPosition() end
	local line = (L["Where: %s"]):format(place) .. SEP .. (where(map, x, y) or L["no position"])
	local W = ns.Nav and ns.Nav.walk
	local pc, px, py
	if W and W.Floor and C and C.GetPlayerWorldPosition then pc, px, py = C.GetPlayerWorldPosition() end
	local z = pc and W.Floor(pc, px, py)
	if type(z) == "number" then line = line .. SEP .. ("z %d"):format(floor(z + 0.5)) end
	return cut(line)
end

-- How the arrow is set to route, so a pathing report says which router and
-- style it came from: the route style (nav.routeStyle) as its setting's own
-- word, then only the settings that differ from the defaults (walking maps
-- off, the travel planner off, guiding handed to Shortest Path Forever,
-- paused, "armed" or "inside"). The words stay English, like "yd":
-- whoever fixes the bug reads them. After the Where line, so the bug bot
-- still finds Arrow and Where by position.
local function routesLine()
	local style = ns.Get("nav.routeStyle")
	local parts = { (style == "fastest" or style == "roads") and style or "balanced" }
	if ns.Get("nav.navRouting") == false then parts[#parts + 1] = "real paths off" end
	if ns.Get("nav.travel") == false then parts[#parts + 1] = "travel planner off" end
	local N = ns.Nav
	if N and N.HandedOff and N.HandedOff() then parts[#parts + 1] = "handed to Shortest Path Forever" end
	-- Paused (Core/Init.lua): the arrow drops the guide's waypoint meanwhile.
	local paused = ns.Paused and ns.Paused()
	if paused then parts[#parts + 1] = "paused " .. paused end
	return cut((L["Routes: %s"]):format(table.concat(parts, SEP)))
end

-- The travel plan from the current leg on (Nav.GetRoute): each leg's caption
-- and time, "(maybe)" on a flight to a flight master the character may not
-- have (#1795: the first flight map there settles it); no line without a plan
-- (the arrow leads straight). The words stay English like Routes; after
-- Routes, so Arrow, Where and Routes keep their places for the bug bot.
-- Longer than the other lines (LINE_MAX): a plan of several legs reads whole.
local function travelLine()
	local N = ns.Nav
	local legs, ci
	if N and N.GetRoute then legs, ci = N.GetRoute() end
	if not legs then return nil end
	local parts = {}
	for i = ci or 1, #legs do
		local leg = legs[i]
		local s = floor((leg.seconds or 0) + 0.5)
		parts[#parts + 1] = ("%s %d:%02d%s"):format(plain(leg.label or leg.kind or "?"), floor(s / 60), s % 60, leg.maybe and " (maybe)" or "")
	end
	return cut((L["Travel: %s"]):format(table.concat(parts, SEP)), 300)
end

-- The "While you're here" line (Engine.WhileHereState): the lines shown
-- (each: what, quest, step, distance; "; " between them) or "none", the
-- radius, a hand-in's seconds out of the way and how many candidates there
-- are, and without a line the nearest candidate (a hand-in: its detour) and
-- why it does not show. The words stay English like Routes;
-- after Routes, so Arrow, Where and Routes keep their places for the bug bot.
local function whileHereLine()
	local E = ns.Engine
	local st = E and E.WhileHereState and E.WhileHereState()
	if not st then return nil end
	local function step(s)
		if type(s) == "number" and s < 1 then return "flight path" end -- the Engine's FLY_STEP: a "Learn the flight path" line
		return ("step %s (guide %d)"):format(tostring((E.StepNumber(s))), s)
	end
	if not st.on then return cut((L["While here: %s"]):format("off")) end
	local parts = {}
	if st.shown then
		local lines = {}
		for i, v in ipairs(st.shown) do
			lines[i] = table.concat({ plain(v.text or "?"), ("quest %s"):format(tostring(v.quest)), step(v.step), ("%d yd"):format(v.yards or 0) }, SEP)
		end
		parts[1] = table.concat(lines, "; ")
	else
		parts[1] = "none"
	end
	parts[#parts + 1] = ("radius %d yd"):format(st.radius)
	parts[#parts + 1] = st.turnins and ("hand-ins %d s"):format(st.turnins) or "hand-ins off"
	parts[#parts + 1] = ("%d candidates"):format(st.candidates)
	if not st.shown then
		local n = st.nearest
		local why = st.why or "?"
		parts[#parts + 1] = n and ("nearest quest %s, %s, %d yd%s%s: %s"):format(tostring(n.quest), step(n.step), n.yards,
			n.detour and (", %d s out of the way"):format(n.detour) or "", n.seen and ", its mob in sight" or "", why) or why
	end
	-- Longer than the other lines (LINE_MAX): what shows and why all count.
	return cut((L["While here: %s"]):format(table.concat(parts, SEP)), 400)
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

-- Polestar folders from different versions (Core/Data.lua): a mixed install
-- explains reports a clean reinstall fixes. Nil when every folder matches.
local function installLine()
	local D = ns.Data
	local line = D and D.InstallLine and D.InstallLine()
	return line and cut((L["Install: %s"]):format(line)) or nil
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
local function errorLines(d)
	local list, seen = {}, {}
	local function caught(msg, count, seq)
		msg = tostring(msg):match("^[^\n]*"):gsub("^Interface[/\\]AddOns[/\\]", "")
		if seen[msg] then return end
		seen[msg] = true
		list[#list + 1] = { text = msg, count = count or 1, seq = seq or math.huge }
	end
	for _, e in ipairs(ns.Errors and ns.Errors() or {}) do caught(e.msg, e.count, e.seq) end
	for _, b in ipairs(ns.Blocked and ns.Blocked() or {}) do
		local fn = plain(b.fn) .. (b.where and (" " .. b.where) or "")
		list[#list + 1] = { text = L["blocked in %s: %s (%s)"]:format(b.addon, fn, b.at), count = b.count, seq = b.seq }
	end
	local BG = BugGrabber
	if type(BG) == "table" and type(BG.GetDB) == "function" then
		local ok, db = pcall(BG.GetDB, BG)
		local session = type(BG.GetSessionId) == "function" and BG:GetSessionId() or nil
		if ok and type(db) == "table" then
			for _, e in ipairs(db) do
				if type(e) == "table" and type(e.message) == "string" and e.message:find("AddOns[/\\]Polestar")
					and (session == nil or e.session == session) then
					caught(e.message, e.counter)
				end
			end
		end
	end
	if #list == 0 then
		add(d, "errors", L["Errors: none"])
		return
	end
	-- Sorted by seq; !BugGrabber's (no seq) keep the order they were added in.
	for i = 1, #list do list[i].i = i end
	table.sort(list, function(a, b)
		if a.seq ~= b.seq then return a.seq < b.seq end
		return a.i < b.i
	end)
	add(d, "errors", L["Errors:"])
	for i = max(1, #list - ERRORS_MAX + 1), #list do
		add(d, "error", cut(("  %dx %s"):format(list[i].count, list[i].text)))
	end
end

-- The quest log, compact: "Quest log 12/40: 783 1/3, 7 0/1, ..." (each
-- quest's id, then its objectives done out of all; "done" when ready to hand
-- in), cut to two lines' worth; nil with an empty log.
local function questLogLine()
	local C = ns.Compat
	local ids = C.GetLogQuests and C.GetLogQuests() or {}
	local parts = {}
	for i, q in ipairs(ids) do
		if C.IsQuestReadyForTurnIn(q) then
			parts[i] = q .. " done"
		else
			local objs, met = C.GetQuestObjectives(q) or {}, 0
			for _, o in ipairs(objs) do if o.finished then met = met + 1 end end
			parts[i] = q .. " " .. met .. "/" .. #objs
		end
	end
	local cap = C.GetLogCap and C.GetLogCap() or 40
	if #ids == 0 then return nil end
	return cut(L["Quest log %d/%d: %s"]:format(#ids, cap, table.concat(parts, ", ")), LINE_MAX * 2)
end

---------------------------------------------------------------------------
-- Settings: what the player changed, so a report tells a setting they
-- turned from a bug of ours. The profile in use (Core/Profiles.lua) and
-- whose choice it is (the character's own, its class's or the account's),
-- then each setting off its default, by its key, never its label:
--
--   Settings: profile Default (account) · 23 changed
--   behavior.autoAccept=off behavior.whileHereRadius=180->400 nav.routeStyle=balanced->fastest
--   gear.minUpgrade=1->5 qol.sellJunk=off
--   looks: skin=hearth scheme=night · 12 positions moved · 4 other looks
--   +9 more #3fa2c1d0
--   !PSR1!3fa2c1d0!eJxL...
--
-- A switch reads on or off (its default is the other one); anything else
-- reads its default, "->" and its value: a number to two places, a
-- choice's id, a place's numbers, a colour as #rrggbb. What most often
-- changes what Polestar does comes first (the guide and its automation,
-- navigation, quests and dungeons, targeting and the quest buttons, gear,
-- quality of life, then the rest); pure looks (where frames sit, sizes,
-- colours, fonts, the skin's picks) make the one looks line. Past
-- R.SETTINGS_MAX characters the list keeps the settings that rank first
-- and ends with how many more there are and the Adler-32 of them all (the
-- list's order, then the looks, one a line); the packed line then carries
-- the rest (the settings the list left out, then every look), each as the
-- list writes it, a line each, in Core/Import.lua's envelope under
-- R.SETTINGS_PREFIX: with the list it is every setting, which the Discord
-- bot unfolds on the issue. "all defaults" when nothing changed.
-- Settings only: no character's name, chat, account or realm (a profile
-- named after a character or realm on the account reads "custom"). The
-- words stay English, like Routes, under the client's label.
---------------------------------------------------------------------------

R.SETTINGS_MAX = 600
R.SETTINGS_PREFIX = "!PSR1!"
-- Between a setting's default and its value: ASCII, as the game's fonts and
-- Open Sans have no arrow, and no value holds a ">".
local TO = "->"

-- Rank in the list: 1 the guide and its automation, 2 navigation and
-- travel, 3 quests and dungeons, 4 targeting and the quest buttons, 5 gear,
-- 6 quality of life, 7 the rest. By key, else by section.
local RANK_SECTION = { behavior = 1, routePlan = 1, nav = 2, dungeons = 3, party = 3, gear = 5, qol = 6 }
local RANK_KEY = {}
for rank, keys in ipairs({
	{ "qol.stepGossip", "qol.skipGossip", "qol.stepInteract", "qol.autoBind", "qol.flightAutoOpen", "qol.flightAutoTake",
		"qol.buyGoals", "qol.restock", "qol.rewardAutoPick", "qol.rewardEquip", "qol.instantQuestText" },
	{},
	{ "qol.questDB", "qol.availableQuests", "qol.lowLevelQuests", "qol.questLevelWindow", "qol.turnInMarkers",
		"qol.mapObjectives", "qol.minimapObjectives", "qol.objectiveSpots", "qol.questTooltips", "qol.questSellWarning",
		"qol.questBagMarks", "qol.questLevels", "qol.questTimerAlerts", "qol.instanceTrack", "qol.hideQuestTracker",
		"qol.guideHighlight", "qol.guideDim", "qol.nameplateIcons", "ui.newInForever" },
	{ "qol.targetButton", "qol.targetPlate", "qol.targetAnnounce", "qol.guideNameTarget", "qol.markTarget", "qol.pingTarget",
		"qol.markMob", "qol.markNpc", "qol.itemButton", "qol.questLoot", "qol.bagGlow", "qol.rareButton", "qol.hearthButton" },
	{ "qol.wearOffer", "qol.rewardHighlight" },
}) do
	for _, k in ipairs(keys) do RANK_KEY[k] = rank end
end

local function rankOf(path)
	return RANK_KEY[path] or RANK_SECTION[path:match("^[^.]+")] or 7
end

-- Pure looks, in the looks line and never the list: the sections of the
-- Look pages' own settings, a setting whose name ends in a place, a colour,
-- a size, an opacity, a font, an outline or shadow, a backing or an icon
-- (LOOK_ENDS, on the name in lower case), LOOK_KEYS and the settings under
-- LOOK_UNDER. A switch that turns something off or on is no look unless it
-- is named here: it can be why something seems broken.
local LOOK_SECTIONS = { guideWindow = true, toasts = true, trackers = true, buttons = true, movers = true }
local LOOK_ENDS = { "pos$", "point$", "colou?r$", "size$", "scale$", "width$", "height$", "spacing$", "padding$",
	"alpha$", "opacity$", "strength$", "font$", "outline$", "shadow$", "backing$", "icon$" }
local LOOK_UNDER = { "^ui%.colors%.", "^ui%.skinVariants%.", "^nav%.sparkle" }
local LOOK_KEYS = {}
for _, k in ipairs({ "ui.skin", "ui.scheme", "ui.style", "ui.accent", "ui.brightness", "ui.band", "ui.haze", "ui.rim",
	"ui.border", "ui.borderAccent", "ui.matchAccent", "ui.classAccent", "ui.matchFont", "ui.animSpeed", "ui.reduceMotion",
	"ui.compact", "ui.growUp", "ui.barsBottom", "ui.barShown", "ui.launcherBack", "ui.notesOpen", "ui.upcomingOpen",
	"ui.pickerCollapsed", "nav.arrowStyle", "nav.lineStyle", "nav.mapIcons", "nav.arrowTurn", "nav.arrowNoTarget",
	"nav.arrowLabelLines", "nav.arrowNearRange", "nav.arrowGlow", "nav.arrowPulse", "nav.targetGlow", "nav.targetPulse",
	"nav.pulseSeconds", "nav.stepFadeTo", "nav.stepColorMode", "nav.routeChevrons", "nav.flightDash", "nav.drawIn",
	"nav.walkedFade", "nav.minimapArrowFade", "nav.journeyOpen", "maps.minimapButtonAngle", "qol.buttonTextSide",
	"qol.nameplateIconSide" }) do
	LOOK_KEYS[k] = true
end

local function lastName(path) return (path:match("([^.]+)$") or path):lower() end

local function isLook(path)
	if LOOK_KEYS[path] or LOOK_SECTIONS[path:match("^[^.]+")] then return true end
	for _, p in ipairs(LOOK_UNDER) do
		if path:find(p) then return true end
	end
	local name = lastName(path)
	for _, e in ipairs(LOOK_ENDS) do
		if name:find(e) then return true end
	end
	return false
end

-- A look that says where a frame was dragged to.
local function isPlace(path, v)
	local name = lastName(path)
	return type(v) == "table" and (name:find("pos$") or name:find("point$")) ~= nil
end

-- { r, g, b[, a] } in 0-1.
local function isColour(v)
	if type(v) ~= "table" then return false end
	local n, count = #v, 0
	for _ in pairs(v) do count = count + 1 end
	if (n ~= 3 and n ~= 4) or count ~= n then return false end
	for i = 1, n do
		if type(v[i]) ~= "number" or v[i] < 0 or v[i] > 1 then return false end
	end
	return true
end

local function same(a, b)
	if type(a) == "table" and type(b) == "table" then
		for k, v in pairs(a) do
			if not same(v, b[k]) then return false end
		end
		for k in pairs(b) do
			if a[k] == nil then return false end
		end
		return true
	end
	return a == b
end

local function number(v)
	if v ~= v or v == math.huge or v == -math.huge then return "?" end
	if v == floor(v) and v > -1e9 and v < 1e9 then return ("%d"):format(v) end
	local s = ("%.2f"):format(v):gsub("0+$", ""):gsub("%.$", "")
	return s == "-0" and "0" or s
end

-- A value as the list writes it: on/off, a number to two places, a choice's
-- id (letters, digits and . _ - + / # : , kept, anything else as _), a
-- colour as #rrggbb[aa], a list or a place as its parts joined by commas,
-- any other table as {n} (its entries), nothing as "none".
local function valueText(v, inner)
	local t = type(v)
	if t == "boolean" then return v and "on" or "off" end
	if t == "number" then return number(v) end
	if t == "string" then return cut((v:gsub("[^%w%._%-%+/#:,]", "_")), 24) end
	if t ~= "table" then return "none" end
	if isColour(v) then
		local s = ("#%02x%02x%02x"):format(floor(v[1] * 255 + 0.5), floor(v[2] * 255 + 0.5), floor(v[3] * 255 + 0.5))
		if v[4] and v[4] < 1 then s = s .. ("%02x"):format(floor(v[4] * 255 + 0.5)) end
		return s
	end
	local parts = {}
	if not inner then
		if v[1] ~= nil then
			for i = 1, #v do parts[i] = valueText(v[i], true) end
		elseif v.x ~= nil and v.y ~= nil then
			for _, k in ipairs({ "point", "relPoint", "x", "y" }) do
				if v[k] ~= nil then parts[#parts + 1] = valueText(v[k], true) end
			end
		end
	end
	if #parts > 0 then return table.concat(parts, ",") end
	local n = 0
	for _ in pairs(v) do n = n + 1 end
	return "{" .. n .. "}"
end

-- One setting as the list writes it: "key=off", or "key=default->value".
local function settingText(e)
	local key = e.path:gsub("[^%w%._%-]", "_")
	if type(e.v) == "boolean" and type(e.d) == "boolean" then return key .. "=" .. valueText(e.v) end
	return key .. "=" .. valueText(e.d) .. TO .. valueText(e.v)
end

-- Every setting of the profile in use off its default: { path, v, d }. A
-- table default that is no colour (a record such as maps.serviceFilters)
-- is walked into; a colour or a place is one value. A setting with no
-- default is left out (one this Polestar no longer reads, or a window's own
-- state) unless it is a look.
local function changedSettings()
	local out = {}
	local function walk(prefix, t, depth)
		for k, v in pairs(t) do
			if type(k) == "string" or type(k) == "number" then
				local path = prefix .. "." .. tostring(k)
				local d = ns.GetDefault(path)
				if type(v) == "table" and type(d) == "table" and not isColour(d) and depth < 4 then
					walk(path, v, depth + 1)
				elseif not same(v, d) and (d ~= nil or isLook(path)) then
					out[#out + 1] = { path = path, v = v, d = d }
				end
			end
		end
	end
	local db = ns.DB and ns.DB()
	local settings = type(db) == "table" and db.settings
	if type(settings) == "table" then
		for section, t in pairs(settings) do
			if type(section) == "string" and type(t) == "table" then walk(section, t, 1) end
		end
	end
	return out
end

-- The profile in use by its name ("Default"), unless the name holds this
-- character's name or realm, or another character's on the account (the
-- Characters page's list, Alts/Snapshot.lua): then "custom".
local function profileName(P)
	local name = P.Active()
	if name == P.DEFAULT then return "Default" end
	local low, names = name:lower(), {}
	if UnitName then names[#names + 1] = UnitName("player") end
	if GetRealmName then names[#names + 1] = GetRealmName() end
	local db = ns.DB()
	local alts = type(db.alts) == "table" and type(db.alts.chars) == "table" and db.alts.chars or {}
	for key, e in pairs(alts) do
		if type(key) == "string" then
			for part in key:gmatch("[^%-]+") do names[#names + 1] = part end
		end
		if type(e) == "table" then
			names[#names + 1] = e.name
			names[#names + 1] = e.realm
		end
	end
	for _, n in ipairs(names) do
		if type(n) == "string" and #n >= 2 and low:find(n:lower(), 1, true) then return "custom" end
	end
	return cut(oneLine(plain(name)):gsub(SEP, " "), 24)
end

-- "Settings: profile Raid (character) · 23 changed"; nothing changed on
-- the account's Default profile is just "Settings: all defaults".
local function settingsHead(n)
	local P, parts = ns.Profiles, {}
	if P and P.Active and P.Source and (n > 0 or P.Active() ~= P.DEFAULT or P.Source() ~= "account") then
		parts[1] = ("profile %s (%s)"):format(profileName(P), P.Source())
	end
	parts[#parts + 1] = n == 0 and "all defaults" or ("%d changed"):format(n)
	return L["Settings: %s"]:format(table.concat(parts, SEP))
end

-- The looks in one line: the skin's picks by name, then how many frames
-- were moved and how many other looks changed.
local PICKS = { { "ui.skin", "skin" }, { "ui.scheme", "scheme" }, { "ui.style", "style" }, { "ui.font", "font" }, { "ui.scale", "scale" } }

local function looksLine(looks)
	local by, picked, named, places, other = {}, {}, {}, 0, 0
	for _, e in ipairs(looks) do by[e.path] = e end
	for _, p in ipairs(PICKS) do
		local e = by[p[1]]
		if e then
			picked[#picked + 1] = p[2] .. "=" .. valueText(e.v)
			named[p[1]] = true
		end
	end
	for _, e in ipairs(looks) do
		if isPlace(e.path, e.v) then
			places = places + 1
		elseif not named[e.path] then
			other = other + 1
		end
	end
	local parts = {}
	if #picked > 0 then parts[1] = table.concat(picked, " ") end
	if places > 0 then parts[#parts + 1] = ("%d position%s moved"):format(places, places == 1 and "" or "s") end
	if other > 0 then parts[#parts + 1] = ("%d other look%s"):format(other, other == 1 and "" or "s") end
	return "looks: " .. table.concat(parts, SEP)
end

-- The section's lines at the end of the details, and d.settings for
-- keptLines and cutOrder (R.Details).
local function settingsSection(d)
	local list, looks = {}, {}
	for _, e in ipairs(changedSettings()) do
		e.text = settingText(e)
		if isLook(e.path) then
			looks[#looks + 1] = e
		else
			e.rank = rankOf(e.path)
			list[#list + 1] = e
		end
	end
	table.sort(list, function(a, b)
		if a.rank ~= b.rank then return a.rank < b.rank end
		return a.path < b.path
	end)
	table.sort(looks, function(a, b) return a.path < b.path end)
	local head = settingsHead(#list + #looks)
	add(d, "settings", head)
	local s = { head = #d.lines, at = #d.lines, counts = {}, more = 0 }
	d.settings = s
	if #list + #looks == 0 then return end
	-- Every setting, the list's order then the looks: what the hash is of.
	local all = {}
	for i, e in ipairs(list) do all[i] = e.text end
	for _, e in ipairs(looks) do all[#all + 1] = e.text end
	local Import = ns.Import
	s.hash = Import and Import.Adler32 and Import.Adler32(table.concat(all, "\n")) or "?"
	local look = #looks > 0 and looksLine(looks) or nil
	local fixed = length(head) + 1 + (look and length(look) + 1 or 0)
	local function more(n) return ("+%d more #%s"):format(n, s.hash) end
	-- Each setting takes its characters and a space or a line break.
	local total = fixed
	for _, e in ipairs(list) do total = total + length(e.text) + 1 end
	local shown = #list
	if total > R.SETTINGS_MAX then
		local room, used = R.SETTINGS_MAX - fixed - length(more(#list)) - 1, 0
		shown = 0
		for i, e in ipairs(list) do
			used = used + length(e.text) + 1
			if used > room then break end
			shown = i
		end
	end
	s.more = #list - shown
	local line, count = nil, 0
	local function flush()
		if not line then return end
		add(d, "settinglist", line)
		s.counts[#d.lines] = count
	end
	for i = 1, shown do
		local t = list[i].text
		if line and length(line) + 1 + length(t) <= LINE_MAX then
			line, count = line .. " " .. t, count + 1
		else
			flush()
			line, count = t, 1
		end
	end
	flush()
	if look then add(d, "settinglooks", look) end
	s.at = #d.lines
	if s.more > 0 then
		add(d, "settingmore", more(s.more))
		-- The packed line: what the list leaves out (its last settings, then
		-- every look), so with the list it holds them all.
		if Import and Import.Envelope then
			add(d, "settingcode", Import.Envelope(R.SETTINGS_PREFIX, table.concat(all, "\n", shown + 1)))
		end
	end
end

-- The rolling debug log's last lines (ns.DebugLog), each cut to a line.
local LOG_LINES = 5
local function logTail()
	local out = {}
	for i, line in ipairs(ns.DebugLog and ns.DebugLog(LOG_LINES) or {}) do out[i] = cut(line) end
	return out
end

-- The report's details, taken once when the window opens: the issue link
-- and the report for Discord are made from them alone, so they say the
-- same whatever the guide does while the window is open.
--   lines     one fact each, in the order the Discord bot reads them
--   kinds     each line's kind, by its index: what cutOrder trims by
--   key       the guide and the step, to tell a report on another step
--   context   the line under the window's title
--   goals     where the step's goal lines sit in `lines`: first, last, the
--             window's current goal (current), the arrow's when it is
--             another (arrow), and how many more were not listed
--   names     the other addons' names, for the report's Addons line
--   addons    the other addons with their versions, for the issue's field
--   issue     on a step, the facts a "Wrong step" issue names: the guide's
--             title, the step's index and title, the character
--   settings  the Settings section (settingsSection): its first line (head),
--             the line "+N more" comes after (at), the list's lines -> the
--             settings on each (counts), the settings left out of the list
--             (more) and the Adler-32 of them all (hash)
function R.Details()
	local on = onScreen()
	local who = character()
	local d = { lines = {}, kinds = {}, context = context(on), names = otherAddons(), addons = otherAddons(true),
		key = tostring(on.guide and on.guide.id) .. ":" .. tostring(on.index) }
	add(d, "versions", versions())
	add(d, "character", who)
	guideLines(d, on)
	add(d, "arrow", arrowLine())
	add(d, "where", playerLine())
	add(d, "routes", routesLine())
	add(d, "travel", travelLine())
	add(d, "whilehere", whileHereLine())
	add(d, "packs", packsLine())
	add(d, "install", installLine())
	errorLines(d)
	add(d, "questlog", questLogLine())
	settingsSection(d)
	d.tail = logTail()
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
-- line's shape, the guide line's "(id)", the order of the lines. The
-- rolling log's tail (`tail`) follows, under "Log:"; `note`, when given,
-- closes the block (what was left out to fit).
local function text(description, lines, spot, names, tail, note)
	local out = { bold(L["What went wrong:"], described(description)) }
	if spot then out[#out + 1] = bold(L["Right spot:"], cut(table.concat(spot, SEP))) end
	if names then out[#out + 1] = bold(L["Addons:"], names) end
	out[#out + 1] = "```"
	for _, line in ipairs(lines) do out[#out + 1] = line end
	if tail and #tail > 0 then
		out[#out + 1] = L["Log:"]
		for _, line in ipairs(tail) do out[#out + 1] = "> " .. line end
	end
	if note then out[#out + 1] = note end
	out[#out + 1] = "```"
	return table.concat(out, "\n")
end

-- The detail lines a report too long for its place gives up, by index, in
-- the order they go: the packed settings, the goals other than the
-- window's current one, the two after it and the arrow's (the furthest
-- after it first, then the ones before it), the looks line, the settings
-- list (its last line first), the Packs line, the quest log, the errors but
-- the newest; then, so even the longest description fits, the planned and
-- hidden lines, While here, Travel, Install, Routes, the Settings line and
-- the newest error. Never the versions, the character, the guide and the
-- step, the current goal, Arrow, Where or the Errors header: the lines the
-- Discord bot finds the rest by and a fix starts from.
local function cutOrder(details)
	local kinds, order = details.kinds, {}
	local function all(kind, from, to, step)
		local list = {}
		for i = 1, #details.lines do if kinds[i] == kind then list[#list + 1] = i end end
		from, to = from or 1, to or #list
		if from < 0 then from = #list + from + 1 end
		if to < 0 then to = #list + to + 1 end
		for j = from, to, step or 1 do order[#order + 1] = list[j] end
	end
	all("settingcode")
	local g = details.goals
	if g and g.last >= g.first then
		local live = g.current or g.first
		local keep = { [live] = true, [live + 1] = true, [live + 2] = true }
		if g.arrow then keep[g.arrow] = true end
		for i = g.last, live + 1, -1 do if not keep[i] then order[#order + 1] = i end end
		for i = g.first, live - 1 do if not keep[i] then order[#order + 1] = i end end
	end
	all("settinglooks")
	all("settinglist", -1, 1, -1)
	all("packs")
	all("questlog")
	all("error", 1, -2)
	all("planned", -1, 1, -1)
	all("whilehere")
	all("travel")
	all("install")
	all("routes")
	all("settings")
	all("error", -1, -1)
	return order
end

-- The detail lines without the ones in `gone`; goals left out are counted
-- on one line after the goals, with the ones never listed, and settings
-- left out of the list with the ones never listed in "+N more #hash" (its
-- own line follows the section's last kept line, while its first stays).
local function keptLines(details, gone)
	local g, s, out, goals, more = details.goals, details.settings, {}, 0, 0
	if g then
		for i = g.first, g.last do if gone[i] then goals = goals + 1 end end
	end
	if s then
		more = s.more
		for i, n in pairs(s.counts) do if gone[i] then more = more + n end end
	end
	for i, line in ipairs(details.lines) do
		local kind = details.kinds[i]
		if not gone[i] and kind ~= "settingmore" and not (goals > 0 and kind == "more") then out[#out + 1] = line end
		if goals > 0 and i == g.last then out[#out + 1] = (L["... %d more goals"]):format(goals + g.more) end
		if s and i == s.at and more > 0 and not gone[s.head] then out[#out + 1] = ("+%d more #%s"):format(more, s.hash) end
	end
	return out
end

-- Fits the report in `fits`: gives up the log's oldest lines (`tail`,
-- when given), then shortens the Addons line (`names`, when given), then
-- gives up the detail lines in cutOrder's order, adding `note` as the
-- block's last line once anything went. The description is never cut.
local function fitted(description, details, spot, names, tail, note, fits)
	local lines, n, cutAny = details.lines, names and #names or 0, false
	local function build()
		return text(description, lines, spot, n > 0 and cut(names, n) or nil, tail, cutAny and note or nil)
	end
	local report = build()
	while not fits(report) and tail and #tail > 0 do
		table.remove(tail, 1)
		cutAny = true
		report = build()
	end
	while not fits(report) and n > 0 do
		n = n - (length(report) - R.TEXT_MAX)
		-- Shorter than 20 bytes it names hardly an addon: the line goes.
		if n < 20 then n = 0 end
		cutAny = true
		report = build()
	end
	local order, gone = cutOrder(details), {}
	for k = 1, #order do
		if fits(report) then break end
		gone[order[k]] = true
		cutAny = true
		lines = keptLines(details, gone)
		report = build()
	end
	return report
end

-- With no other addons there is no Addons line. The report fits one
-- Discord message (R.TEXT_MAX): past it the log's oldest lines go first,
-- then the Addons line is shortened, then the details go in cutOrder's
-- order, and the block's last line says the report was trimmed.
function R.Text(description, details, spot)
	local names = #details.names > 0 and table.concat(details.names, ", ") or nil
	local tail = {}
	for i, line in ipairs(details.tail or {}) do tail[i] = line end
	return fitted(description, details, spot, names, tail, L["(trimmed to fit Discord)"],
		function(report) return length(report) <= R.TEXT_MAX end)
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

-- The report for the issue's own field, encoded, in `room` characters of
-- the link. A CJK report encodes to three times the characters of an
-- English one, so the details go as in the report for Discord (cutOrder);
-- when even that is too long, the report is cut from its end with its
-- code block still closed: the details' last lines go, the description
-- only when it alone is longer than the link holds (a long one in a
-- non-Latin script, whose every letter encodes to 6 or 9 characters).
-- The addons have their own field: in the body they would only take room.
local function bodyField(description, details, spot, room)
	local report = fitted(description, details, spot, nil, nil, "(trimmed to fit the link)",
		function(r) return #encode(r) <= room end)
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
-- The description's well: as tall as its text, from DESC_LINES lines up to
-- DESC_LINES_MAX; past that the text scrolls in it.
local DESC_LINES, DESC_LINES_MAX, LINE_H = 3, 7, 16
-- The window stays inside a 720-unit screen (UIParent is 768 high at UI
-- scale 1): the report box under Copy report is a view of at most what is
-- left, never under BOX_VIEW_MIN, and the report scrolls in it (#1753).
local WINDOW_MAX, BOX_VIEW_MIN = 720, 96
local LOGO = 32
local TEXT_X = PAD + LOGO + 12 -- the Discord block's text column

local F

local function put(obj, x, y)
	obj:ClearAllPoints()
	obj:SetPoint("TOPLEFT", F, "TOPLEFT", x, -y)
end

-- The report box and its well, shown or hidden together; the note on the
-- report's settings stands in their place while they are hidden.
local function showBox(on)
	F.BoxWell:SetShown(on)
	F.Box:SetShown(on)
	F.CopyHint:SetShown(on)
	F.SettingsNote:SetShown(not on)
end

-- The well as tall as the text, between its least and most lines, and the
-- box in it as tall as the whole text, for the well to scroll through.
local function sizeDesc()
	local e = F.Desc
	-- A last empty line, after a typed newline, counts too.
	F.DescMeasure:SetText(((e:GetText() or ""):gsub("\n$", "\n ")))
	local textH = F.DescMeasure:GetStringHeight()
	local view = min(max(textH, DESC_LINES * LINE_H), DESC_LINES_MAX * LINE_H) + 16
	local content = max(view, floor(textH + 16 + 0.5))
	F.DescWell:SetHeight(view)
	e:SetHeight(content)
	W.SetScrollContent(F.DescScroll, content, view)
end

local function layout()
	local y = HEAD_H + 12
	if F.Outdated:IsShown() then
		put(F.Outdated, PAD, y)
		y = y + F.Outdated:GetStringHeight() + 12
	end
	put(F.Context, PAD, y)
	y = y + F.Context:GetStringHeight() + 16
	put(F.DescLabel, PAD, y)
	y = y + F.DescLabel:GetStringHeight() + 6
	put(F.DescWell, PAD, y)
	y = y + F.DescWell:GetHeight() + 12
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
	-- What goes under the box: its gap, the GitHub rule and row, the edge.
	local bw = F.GitHub:GetWidth()
	F.GitHubNote:SetWidth(BOX_W - bw - 12)
	local nh, bh = F.GitHubNote:GetStringHeight(), F.GitHub:GetHeight()
	local row = max(nh, bh)
	if F.BoxWell:IsShown() then
		y = y + 12
		put(F.CopyHint, PAD, y)
		y = y + F.CopyHint:GetStringHeight() + 6
		put(F.BoxWell, PAD, y)
		local content = F.Box:GetHeight()
		local room = WINDOW_MAX - y - (16 + 1 + 12 + row + PAD)
		local view = min(content, max(BOX_VIEW_MIN, floor(room)))
		F.BoxWell:SetHeight(view)
		W.SetScrollContent(F.BoxScroll, content, view)
		y = y + view
	else
		y = y + 10
		put(F.SettingsNote, TEXT_X, y)
		y = y + F.SettingsNote:GetStringHeight()
	end
	y = y + 16
	put(F.GitHubRule, PAD, y)
	y = y + 1 + 12
	-- One row: the note beside its button, centred on each other.
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
	if not ok then showBox(false) end
	return ok
end

-- The report box is as tall as its text, measured in its own font at its
-- inner width (never under a line per line of the report), so it is copied
-- whole; it scrolls in its well (layout). The box, its height and its
-- scroll are touched only when the report changed: a compose for anything
-- else (the description's box, the spot) leaves a selection in it alone.
local function compose()
	showSpot()
	gate()
	local report = R.Text(F.Desc:GetText(), F.details, F.spot)
	if W.SetCopyText(F.Box, report) then
		F.Measure:SetText(report)
		local _, breaks = report:gsub("\n", "")
		F.Box:SetHeight(floor(max(F.Measure:GetStringHeight(), (breaks + 1) * 12) + 16 + 0.5))
		W.ScrollTo(F.BoxScroll, 0)
	end
	layout()
end

-- The report for Discord, shown under its buttons only when asked for.
local function copyReport()
	if not gate() then return end
	showBox(true)
	layout()
	W.SelectCopy(F.Box)
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
	M = CreateFrame("Frame", "PolestarMark", ns.UIParent)
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
	W.Rim(M, { width = MARK_W * 0.7 })
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

-- The description: the copy box's well and border (F.DescWell), editable,
-- its placeholder in textMuted until the player types. The well grows with
-- the text from DESC_LINES to DESC_LINES_MAX lines; a longer text scrolls
-- in it (F.DescScroll), following the cursor, so all DESC_MAX letters can
-- be typed and read back without the window outgrowing the screen.
local function textArea()
	local well = CreateFrame("Frame", nil, F)
	well:SetWidth(BOX_W)
	well:SetHeight(DESC_LINES * LINE_H + 16)
	Theme.Skin(well, "editbox")
	F.DescWell = well
	local sf = W.Scroll(well)
	sf:SetAllPoints(well)
	F.DescScroll = sf
	-- The box is the view's scroll child, as the report box (W.ScrollChild);
	-- a click anywhere on the well puts the cursor in it.
	local e = W.ScrollChild(sf, CreateFrame("EditBox", nil, sf))
	well:EnableMouse(true)
	well:SetScript("OnMouseUp", function() e:SetFocus() end)
	e:SetAutoFocus(false)
	e:SetMultiLine(true)
	e:SetMaxLetters(R.DESC_MAX)
	Theme.Font(e, "label")
	W.Color(e, "text")
	e:SetWidth(BOX_W)
	e:SetHeight(DESC_LINES * LINE_H + 16)
	e:SetTextInsets(10, 10, 8, 8)
	-- The text in the box's font at its inner width: what the well's height
	-- is measured on. Hidden, never alpha 0 (F.Measure, #1753).
	F.DescMeasure = W.Text(F, "label", "text")
	F.DescMeasure:SetWidth(BOX_W - 20)
	F.DescMeasure:SetJustifyH("LEFT")
	F.DescMeasure:SetWordWrap(true)
	F.DescMeasure:SetNonSpaceWrap(true)
	F.DescMeasure:Hide()
	e.Placeholder = W.Text(e, "label", "textMuted")
	e.Placeholder:SetPoint("TOPLEFT", e, "TOPLEFT", 10, -8)
	e.Placeholder:SetWidth(BOX_W - 20)
	e.Placeholder:SetJustifyH("LEFT")
	e.Placeholder:SetWordWrap(true)
	e.Placeholder:SetText(L["What the guide said, and what you found in the game."])
	e:SetScript("OnEditFocusGained", function() Theme.SetFocused(well, true) end)
	e:SetScript("OnEditFocusLost", function() Theme.SetFocused(well, false) end)
	e:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	-- The line being typed stays in view: y is the cursor's offset down
	-- from the box's top, h its height.
	e:SetScript("OnCursorChanged", function(_, _, y, _, h)
		local view, at = well:GetHeight(), sf:GetVerticalScroll()
		local top, bottom = -(y or 0), -(y or 0) + (h or LINE_H) + 8
		if top < at then
			W.ScrollTo(sf, top)
		elseif bottom > at + view then
			W.ScrollTo(sf, bottom - view)
		end
	end)
	e:SetScript("OnTextChanged", function(self)
		self.Placeholder:SetShown((self:GetText() or "") == "")
		sizeDesc()
		if F.details then compose() end
	end)
	return e
end

local function build()
	F = CreateFrame("Frame", "PolestarReport", ns.UIParent)
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
	-- The house window's light: the gold rim over a faint haze in the band.
	W.Haze(head, { width = WIDTH * 0.9, height = HEAD_H })
	W.Rim(F, { width = WIDTH * 0.7 })
	F.Close = W.IconButton(head, "close", 28, L["Close"], function() F:Hide() end, 14)
	F.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -14)
	W.FrameClose(F, F.Close)
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
	-- An old Polestar: update first, the problem may be fixed already.
	F.Outdated = W.Text(F, "note", "warning")
	F.Outdated:SetWidth(BOX_W)
	F.Outdated:SetJustifyH("LEFT")
	F.Outdated:SetWordWrap(true)
	F.Outdated:Hide()

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

	-- The report for Discord: its well, a view the report scrolls in (#1753:
	-- a long report drawn past its box, over the form), and the box itself,
	-- the view's scroll child. A click anywhere on the well selects it all.
	F.BoxWell = CreateFrame("Frame", nil, F)
	F.BoxWell:SetWidth(BOX_W)
	F.BoxScroll = W.Scroll(F.BoxWell)
	F.BoxScroll:SetAllPoints(F.BoxWell)
	F.Box = W.ScrollChild(F.BoxScroll, W.CopyBox(F.BoxScroll, { lines = 2, well = F.BoxWell }))
	Theme.Font(F.Box, "small")
	F.Box:SetWidth(BOX_W)
	F.Box:SetScript("OnTabPressed", function() F.Desc:SetFocus() end)
	F.BoxWell:EnableMouse(true)
	F.BoxWell:SetScript("OnMouseUp", function() W.SelectCopy(F.Box) end)
	-- Over the box while it shows (Copy report shows it selected): how to
	-- copy it, as the game gives addons no clipboard (#1826).
	F.CopyHint = W.Text(F, "note", "success")
	F.CopyHint:SetWidth(BOX_W)
	F.CopyHint:SetJustifyH("LEFT")
	F.CopyHint:SetWordWrap(true)
	F.CopyHint:SetText(W.CopyHintText())
	-- Under the buttons while the report is hidden: what its Settings lines
	-- hold (settingsSection), settings alone. The copy hint and the box
	-- take its place once the report shows.
	F.SettingsNote = W.Text(F, "note", "textDim")
	F.SettingsNote:SetWidth(WIDTH - TEXT_X - PAD)
	F.SettingsNote:SetJustifyH("LEFT")
	F.SettingsNote:SetWordWrap(true)
	F.SettingsNote:SetText(L["The report lists the settings you changed and your profile's name: no character names, chat, account or realm."])
	showBox(false)
	-- The report's text in the box's font at its inner width: what the box's
	-- height is measured on. Hidden, never alpha 0: a theme repaint gives a
	-- string its colour's alpha back, and this one then drew the whole report
	-- over the window (#1753).
	F.Measure = W.Text(F, "small", "text")
	F.Measure:SetWidth(BOX_W - 20)
	F.Measure:SetJustifyH("LEFT")
	F.Measure:SetWordWrap(true)
	F.Measure:SetNonSpaceWrap(true)
	F.Measure:Hide()

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
	local note = ns.Update and ns.Update.ReportNote()
	F.Outdated:SetText(note or "")
	F.Outdated:SetShown(note ~= nil)
	showBox(false)
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
