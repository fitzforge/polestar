-- Contributor-only addon. Consult the same client tooltip as a creature hyperlink.
local active

local function message(text)
	print("Polestar NPC name capture: " .. text)
end

local function lookup(id, english)
	local info = C_TooltipInfo.GetHyperlink(("unit:Creature-0-0-0-0-%d-0000000000"):format(id))
	local line = info and info.lines and info.lines[1]
	local name = line and line.leftText
	if type(name) ~= "string" or (issecretvalue and issecretvalue(name)) then return end
	if name == "" or name == english or name == UNKNOWNOBJECT or name == RETRIEVING_DATA then return end
	if name:find("[%c|]") or name:match("^%s") or name:match("%s$") then return end
	return name
end

local function tick(run)
	if active ~= run then return end
	-- Query at most two tooltips per second. Retry unresolved entries twice.
	local last = math.min(run.next + 1, #run.jobs)
	for index = run.next, last do
		local job = run.jobs[index]
		local id = job[1]
		local ok, name = pcall(lookup, id, job[2])
		if ok and name then
			run.names[id] = name
			run.found = run.found + 1
		elseif run.pass < 3 then
			run.retry[#run.retry + 1] = job
		end
	end
	run.next = last + 1
	if run.next <= #run.jobs then
		C_Timer.After(1, function() tick(run) end)
	elseif #run.retry > 0 then
		run.jobs, run.retry, run.next, run.pass = run.retry, {}, 1, run.pass + 1
		C_Timer.After(5, function() tick(run) end)
	else
		active = nil
		message(("finished: %d/%d new names. /reload saves the results."):format(run.found, run.count))
	end
end

local function start()
	if active then message("already running. Use status or stop."); return end
	local targets = PolestarNpcNameCaptureTargets
	if not targets then message("generate and install Targets.lua first."); return end
	local locale = GetLocale()
	if locale ~= targets.locale then
		message(("this list is for %s; the client is %s."):format(targets.locale, locale))
		return
	end
	if not (C_TooltipInfo and C_TooltipInfo.GetHyperlink) then
		message("the client does not provide creature tooltips by hyperlink.")
		return
	end
	local version, build = GetBuildInfo()
	local buildID = version .. "." .. build
	local db = PolestarNpcNameCaptureDB
	if not db or db.locale ~= locale or db.build ~= buildID then
		db = { locale = locale, build = buildID, names = {} }
		PolestarNpcNameCaptureDB = db
	end
	local jobs = {}
	for _, job in ipairs(targets.npcs) do
		if not db.names[job[1]] then jobs[#jobs + 1] = job end
	end
	active = { jobs = jobs, names = db.names, count = #jobs, found = 0, next = 1, pass = 1, retry = {} }
	message(("started %d NPC lookups for %s."):format(#jobs, locale))
	tick(active)
end

SLASH_POLESTARNPCNAMECAPTURE1 = "/psnpcname"
SlashCmdList.POLESTARNPCNAMECAPTURE = function(text)
	local command = text:match("^%s*(%S+)%s*$")
	if command == "start" then
		start()
	elseif command == "status" and active then
		message(("pass %d/3, %d/%d checked, %d/%d new names."):format(
			active.pass, active.next - 1, #active.jobs, active.found, active.count))
	elseif command == "stop" and active then
		active = nil
		message("stopped. /reload saves the results so far.")
	elseif command == "status" or command == "stop" then
		message("no capture is running.")
	else
		message("use /psnpcname start, /psnpcname status, or /psnpcname stop.")
	end
end;
