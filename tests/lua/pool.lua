-- A long-lived lua5.1 that runs test programs (tests/helpers/lua.js
-- buildProgram) one after another, for tools/lib/luapool.js: each line on
-- stdin is a program file; its output goes to stdout as runAddon's would,
-- then a line "@@END ok" or "@@END err <message, newlines as \n>".
--
-- Each program runs in an environment of its own: a fresh copy of the base
-- globals (the standard library tables copied too, so a stub adding to
-- `table` or `string` changes only its own), with `_G` itself, and
-- `dofile`/`loadfile` reading through a cache of compiled chunks. A file is
-- parsed once per process (the addon's files, a pack's Guides.lua: most of
-- a play's time); each run executes it afresh, so nothing from one program
-- is left for the next. math.random restarts from the seed a new process has.
-- The cache holds for the pool's life: files must not change under it.

local base = {}
for k, v in pairs(_G) do base[k] = v end
local LIBS = { "string", "table", "math", "os", "io", "coroutine", "debug" }

local chunks = {}
local function cached(path)
	local f = chunks[path]
	if f == nil then
		local err
		f, err = loadfile(path)
		if not f then return nil, err end
		chunks[path] = f
	end
	return f
end

local function newEnv()
	local env = {}
	for k, v in pairs(base) do env[k] = v end
	for _, lib in ipairs(LIBS) do
		local copy = {}
		for k, v in pairs(base[lib]) do copy[k] = v end
		env[lib] = copy
	end
	env._G = env
	env.package = base.package
	env.loadfile = function(path)
		local f, err = cached(path)
		if not f then return nil, err end
		setfenv(f, env)
		return f
	end
	env.dofile = function(path)
		local f, err = cached(path)
		if not f then error(err, 2) end
		setfenv(f, env)
		return f()
	end
	return env
end

local out = io.stdout
for line in io.stdin:lines() do
	local prog, err = loadfile(line)
	local ok
	if prog then
		math.randomseed(1) -- a new process's sequence (srand(1))
		setfenv(prog, newEnv())
		ok, err = xpcall(prog, function(e) return debug.traceback(tostring(e), 2) end)
	end
	out:write(prog and ok and "\n@@END ok\n" or ("\n@@END err " .. tostring(err):gsub("\\", "\\\\"):gsub("\n", "\\n") .. "\n"))
	out:flush()
	collectgarbage("collect")
end
