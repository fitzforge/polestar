-- Instance tracker: dungeon and raid entries against the instance caps,
-- time and experience per run, and saved raid lockouts.
--
-- The cap is Classic's: 5 new instances per hour per account, and Classic
-- Era's 30 per 24 hours. Forever may differ; both numbers are settings.
-- Entering a new instance counts once; going back into the same, unreset
-- instance (a corpse run, a reload, a hearth back in) continues the run and
-- does not count. "Same" means: same instance map, entered again within
-- RESUME seconds of leaving, and no "<name> has been reset." in between. When
-- a creature GUID inside reveals a different instance copy than the run
-- remembered (another group's instance), the run is split and counted.
--
-- Account-wide entries: PolestarDB.instances.entries = { { t, name, char }, ... }
-- (pruned to 24 hours). Per character: CharState().instanceRuns = { run, ... }
-- (last RUNS_KEPT), run = { id, name, kind, entered, since, left, time, xp,
-- level, zone, reset }. Times are server epoch seconds, so runs survive
-- reloads and logouts.

local ADDON, ns = ...
local Maps = ns.Maps
local Client = Maps.Client
local readable = ns.Compat.Readable
local serverTime = ns.Compat.Now
local L = ns.L

local type, ipairs, tonumber, floor, max, format = type, ipairs, tonumber, math.floor, math.max, string.format
local tremove, sort = table.remove, table.sort

local HOUR, DAY = 3600, 86400
local RESUME = HOUR       -- an instance left longer than this has reset on its own
local RUNS_KEPT = 30
local TRACKED = { party = true, raid = true }

---------------------------------------------------------------------------
-- The window (pure)
---------------------------------------------------------------------------

local scratch = {}
local function byTime(a, b) return a < b end

-- entries: { { t = epoch }, ... }; perDay 0 = no daily cap.
-- -> inHour, inDay, wait (seconds until a new instance may be entered; 0 = now),
--    clears (seconds until the oldest entry of the hour drops out; nil = none)
function Maps.InstanceWindow(entries, now, perHour, perDay)
	local n = 0
	local inDay = 0
	for i = 1, #(entries or {}) do
		local t = entries[i].t
		if type(t) == "number" and t <= now then
			if t > now - DAY then inDay = inDay + 1 end
			if t > now - HOUR then
				n = n + 1
				scratch[n] = t
			end
		end
	end
	for i = #scratch, n + 1, -1 do scratch[i] = nil end
	sort(scratch, byTime)
	local wait = 0
	if perHour and perHour > 0 and n >= perHour then
		wait = scratch[n - perHour + 1] + HOUR - now
	end
	if perDay and perDay > 0 and inDay >= perDay then
		local days = {}
		for i = 1, #entries do
			local t = entries[i].t
			if type(t) == "number" and t <= now and t > now - DAY then days[#days + 1] = t end
		end
		sort(days, byTime)
		wait = max(wait, days[inDay - perDay + 1] + DAY - now)
	end
	local clears = n > 0 and (scratch[1] + HOUR - now) or nil
	return n, inDay, wait, clears
end

---------------------------------------------------------------------------
-- State
---------------------------------------------------------------------------

local active          -- the run we are inside, or nil
local visitChecked    -- this visit's instance copy has been read from a GUID
local lastLevel, lastXP, lastMax
local lockouts, lockoutsAt = {}, 0

local function entries()
	local acc = Maps.AccountTable("instances")
	if type(acc.entries) ~= "table" then acc.entries = {} end
	return acc.entries
end

local function runs()
	return Maps.CharTable("instanceRuns")
end

local function charName()
	local C = ns.Compat
	local info = C and C.GetPlayerInfo and C.GetPlayerInfo()
	if not info then return nil end
	return info.realm and (info.name .. "-" .. info.realm) or info.name
end

local function prune(now)
	local list = entries()
	for i = #list, 1, -1 do
		local t = list[i].t
		if type(t) ~= "number" or t <= now - DAY then tremove(list, i) end
	end
	local r = runs()
	while #r > RUNS_KEPT do tremove(r, 1) end
end

local function count(name, now)
	local list = entries()
	list[#list + 1] = { t = now, name = name, char = charName() }
end

local function close(run, now)
	if not run or run.left then return end
	run.time = (run.time or 0) + max(0, now - (run.since or now))
	run.left = now
	run.since = nil
end

local function newRun(name, kind, id, now)
	local level = Client.GetXP()
	local run = { id = id, name = name, kind = kind, entered = now, since = now, time = 0, xp = 0, level = level }
	local r = runs()
	r[#r + 1] = run
	count(name, now)
	prune(now)
	return run
end

local refreshDisplay -- forward

-- Arrived in a tracked instance (or reloaded inside one).
local function enter(name, kind, id)
	local now = serverTime()
	local r = runs()
	local last = r[#r]
	visitChecked = false
	if last and not last.left and last.id ~= id then close(last, now) end
	if last and last.id == id and not last.reset and (not last.left or now - last.left <= RESUME) then
		if last.left then
			last.resumed = last.left
			last.left = nil
		end
		last.since = last.since or now
		active = last
	else
		active = newRun(name, kind, id, now)
	end
	refreshDisplay()
end

local function leave()
	if not active then return end
	close(active, serverTime())
	active = nil
	refreshDisplay()
end

local function situation()
	if not ns.Get("maps.instances") then
		leave()
		return
	end
	local name, kind, _, id = Client.GetInstance()
	if name and TRACKED[kind] then
		if not (active and active.id == id and not active.left) then enter(name, kind, id) end
	elseif active then
		leave()
	end
end

-- A creature GUID inside names the instance copy:
-- "Creature-0-<server>-<instanceMap>-<zoneUID>-<npcID>-<spawnUID>".
local function observe(unit)
	if not active or visitChecked then return end
	local guid = readable(UnitGUID and UnitGUID(unit))
	if type(guid) ~= "string" then return end
	local kind, zone = guid:match("^(%a+)%-0%-%d+%-%d+%-(%d+)%-")
	if kind ~= "Creature" and kind ~= "Vehicle" then return end
	visitChecked = true
	if not active.zone then
		active.zone = zone
	elseif active.zone ~= zone then
		-- Another copy of this instance: the run we resumed ended when we
		-- left it; this visit is a new instance and counts.
		local now = serverTime()
		local visit = active.since or now
		if active.resumed then
			active.left, active.since, active.resumed = active.resumed, nil, nil
		else
			close(active, now)
		end
		active = newRun(active.name, active.kind, active.id, now)
		active.entered, active.since, active.zone = visit, visit, zone
		refreshDisplay()
	end
end

local function trackXP()
	local level, xp, xpMax = Client.GetXP()
	if not (level and xp and xpMax) then return end
	if active and lastLevel then
		local gain = 0
		if level == lastLevel then
			gain = xp - lastXP
		elseif level > lastLevel then
			gain = (lastMax - lastXP) + xp
		end
		if gain > 0 then active.xp = (active.xp or 0) + gain end
	end
	lastLevel, lastXP, lastMax = level, xp, xpMax
end

-- "%s has been reset." (INSTANCE_RESET_SUCCESS) -> a Lua pattern.
local RESET_PATTERN
do
	local fmt = type(INSTANCE_RESET_SUCCESS) == "string" and INSTANCE_RESET_SUCCESS or "%s has been reset."
	RESET_PATTERN = "^" .. fmt:gsub("[%(%)%.%+%-%*%?%[%]%^%$]", "%%%0"):gsub("%%s", "(.+)") .. "$"
end

local function onSystem(_, msg)
	msg = readable(msg)
	if type(msg) ~= "string" then return end
	local name = msg:match(RESET_PATTERN)
	if not name then return end
	local r = runs()
	for i = #r, 1, -1 do
		if r[i].name == name then
			if r[i] ~= active then r[i].reset = true end
			break
		end
	end
end

local function readLockouts()
	lockouts = Client.GetSavedInstances()
	lockoutsAt = serverTime()
end

---------------------------------------------------------------------------
-- Public
---------------------------------------------------------------------------

-- { inHour, inDay, perHour, perDay, wait, clears, run } for displays and commands.
function Maps.GetInstanceStatus()
	local now = serverTime()
	local perHour, perDay = tonumber(ns.Get("maps.perHour")) or 5, tonumber(ns.Get("maps.perDay")) or 0
	local h, d, wait, clears = Maps.InstanceWindow(entries(), now, perHour, perDay)
	return {
		inHour = h, inDay = d, perHour = perHour, perDay = perDay, wait = wait, clears = clears,
		run = active, now = now,
	}
end

-- Seconds the active run has lasted so far (or a finished run's total).
function Maps.RunSeconds(run, now)
	if not run then return 0 end
	local t = run.time or 0
	if run.since and not run.left then t = t + max(0, (now or serverTime()) - run.since) end
	return t
end

-- Saved instances with seconds until reset, as of now.
function Maps.GetSavedLockouts()
	local out = {}
	local elapsed = serverTime() - lockoutsAt
	for _, l in ipairs(lockouts) do
		if l.locked or l.extended then
			out[#out + 1] = {
				name = l.name, difficultyName = l.difficultyName, isRaid = l.isRaid,
				resetIn = max(0, (l.reset or 0) - elapsed), done = l.done, total = l.total, extended = l.extended,
			}
		end
	end
	return out
end

function Maps.ClearInstances()
	Maps.AccountTable("instances").entries = {}
	ns.CharState().instanceRuns = {}
	active = nil
	situation()
	refreshDisplay()
	ns.Print(L["Instance history cleared."])
end

---------------------------------------------------------------------------
-- Compact display
---------------------------------------------------------------------------

local frame, ticker

local function digits(n)
	local s = tostring(floor(n or 0))
	local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return (out:gsub("^,", ""))
end
Maps.FormatNumber = digits

-- 3725 -> "1h 02m", 95 -> "2m", 200000 -> "2d 7h".
local function span(s)
	s = floor(s or 0)
	if s >= DAY then return format("%dd %dh", floor(s / DAY), floor(s % DAY / HOUR)) end
	if s >= HOUR then return format("%dh %02dm", floor(s / HOUR), floor(s % HOUR / 60)) end
	return format("%dm", max(1, floor(s / 60 + 0.5)))
end
Maps.FormatSpan = span

local function paint()
	local st = Maps.GetInstanceStatus()
	frame.Count:SetText(format(L["%d/%d this hour"], st.inHour, st.perHour))
	local W = ns.Widgets
	if st.wait > 0 then
		frame.Wait:SetText(format(L["next in %s"], Maps.FormatTime(st.wait)))
		if W then W.Color(frame.Wait, "warning") end
	elseif st.clears then
		frame.Wait:SetText(format(L["oldest clears in %s"], Maps.FormatTime(st.clears)))
		if W then W.Color(frame.Wait, "textMuted") end
	else
		frame.Wait:SetText("")
	end
	if st.run then
		frame.Run:SetText(st.run.name)
		frame.RunInfo:SetText(format("%s · %s %s", Maps.FormatTime(Maps.RunSeconds(st.run, st.now)), digits(st.run.xp), L["XP"]))
		frame.Run:Show()
		frame.RunInfo:Show()
		frame:SetHeight(52)
	else
		frame.Run:Hide()
		frame.RunInfo:Hide()
		frame:SetHeight(30)
	end
	return st
end

local function wanted()
	if not (ns.Get("maps.instances") and ns.Get("maps.instanceDisplay")) then return false end
	if active then return true end
	local h = Maps.InstanceWindow(entries(), serverTime(), 1, 0)
	return h > 0
end

local function stopTicker()
	if ticker then
		ticker:Cancel()
		ticker = nil
	end
end

function refreshDisplay()
	if not frame then return end
	if not wanted() then
		stopTicker()
		frame:Hide()
		return
	end
	paint()
	frame:Show()
	if not ticker and C_Timer and C_Timer.NewTicker then
		ticker = ns.NewTicker(1, function()
			if wanted() then paint() else refreshDisplay() end
		end)
	end
end

local function buildFrame()
	if frame or not ns.Widgets then return end
	local W = ns.Widgets
	frame = Maps.CompactFrame("PolestarInstanceTracker", "maps.trackerPos", "TOPRIGHT", -220, -220)
	frame:SetSize(230, 30)
	local icon = W.Tex(frame, "ARTWORK", "lock", "accent")
	icon:SetSize(14, 14)
	icon:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -8)
	frame.Count = W.Text(frame, "number", "text")
	frame.Count:SetPoint("LEFT", icon, "RIGHT", 7, 0)
	frame.Wait = W.Text(frame, "small", "textMuted")
	frame.Wait:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -10, -9)
	frame.Wait:SetJustifyH("RIGHT")
	frame.Run = W.Text(frame, "small", "textDim")
	frame.Run:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -30)
	frame.RunInfo = W.Text(frame, "small", "text")
	frame.RunInfo:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -10, -30)
	frame.RunInfo:SetJustifyH("RIGHT")
	frame.Run:SetPoint("RIGHT", frame.RunInfo, "LEFT", -8, 0)
	frame:SetScript("OnEnter", function(self)
		W.Tooltip(self, "ANCHOR_BOTTOMLEFT", L["Instances"], {
			L["New instances you entered on this account in the last hour. Re-entering an instance you have not reset does not count."],
			L["/pole instances for runs and raid lockouts."],
		})
	end)
	frame:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	frame:SetScript("OnHide", stopTicker)
end

---------------------------------------------------------------------------
-- Slash command: /pole instances [clear]
---------------------------------------------------------------------------

local function report()
	local st = Maps.GetInstanceStatus()
	local line = format(L["Instances this hour: %d/%d"], st.inHour, st.perHour)
	if st.wait > 0 then
		line = line .. " · " .. format(L["next free slot in %s"], Maps.FormatTime(st.wait))
	elseif st.clears then
		line = line .. " · " .. format(L["oldest clears in %s"], Maps.FormatTime(st.clears))
	end
	ns.Print(line)
	if st.perDay > 0 then ns.Print(format(L["Last 24 hours: %d/%d"], st.inDay, st.perDay)) end
	for _, e in ipairs(entries()) do
		if e.t > st.now - HOUR then
			ns.Print(format("  %s%s, %s", e.name or "?", e.char and (" (" .. e.char .. ")") or "", format(L["%s ago"], span(st.now - e.t))))
		end
	end
	local r = runs()
	if #r > 0 then ns.Print(L["Recent runs:"]) end
	for i = #r, max(1, #r - 4), -1 do
		local run = r[i]
		local when = run == active and L["now"] or format(L["%s ago"], span(st.now - (run.left or run.entered or st.now)))
		ns.Print(format("  %s  %s  %s %s  (%s)", run.name or "?", Maps.FormatTime(Maps.RunSeconds(run, st.now)), digits(run.xp), L["XP"], when))
	end
	local locks = Maps.GetSavedLockouts()
	if #locks > 0 then ns.Print(L["Saved lockouts:"]) end
	for _, l in ipairs(locks) do
		local bosses = (l.total and l.total > 0) and format(", %d/%d", l.done or 0, l.total) or ""
		ns.Print(format("  %s%s: %s%s", l.name, l.difficultyName and (" (" .. l.difficultyName .. ")") or "",
			format(L["resets in %s"], span(l.resetIn)), bosses))
	end
	ns.Print("|cff8a8f98" .. L["Classic limits; Forever may differ (set them under Quality of Life, Trackers)."] .. "|r")
end

ns.RegisterCommand("instances", function(rest)
	if rest == "clear" then
		Maps.ClearInstances()
	else
		Client.RequestRaidInfo()
		report()
	end
end, L["Instance limits, runs and lockouts (instances clear: forget them)"])

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

local function onWorld()
	trackXP()
	situation()
end

ns.RegisterEvent("PLAYER_ENTERING_WORLD", onWorld)
ns.RegisterEvent("ZONE_CHANGED_NEW_AREA", onWorld)
ns.RegisterEvent("PLAYER_LEAVING_WORLD", leave)
ns.RegisterEvent("PLAYER_XP_UPDATE", trackXP)
ns.RegisterEvent("PLAYER_LEVEL_UP", trackXP)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", trackXP)
ns.RegisterEvent("PLAYER_TARGET_CHANGED", function() observe("target") end)
ns.RegisterEvent("UPDATE_MOUSEOVER_UNIT", function() observe("mouseover") end)
ns.RegisterEvent("CHAT_MSG_SYSTEM", onSystem)
ns.RegisterEvent("UPDATE_INSTANCE_INFO", readLockouts)

ns.On("SETTING_CHANGED", function(path)
	if path == "maps.instances" or path == "" or path == "maps" then situation() end
	if path == "maps.trackerPos" and frame then frame.Place() end
	refreshDisplay()
end)

ns.OnLogin(function()
	buildFrame()
	prune(serverTime())
	Client.RequestRaidInfo()
	trackXP()
	situation()
	refreshDisplay()
end)
