-- The addon's own guide checks as an oracle for tests/fuzz_guide.rs (lua5.1).
-- Loads addon/Polestar/Core/Guides.lua with a bare namespace, then reads Guides.lua chunks the Rust
-- compiler emitted from stdin, each as "<byte length>\n<chunk>", and runs them the way the client does:
-- the chunk must load and run, and each Polestar.RegisterGuide(def) is checked by ns.Guides.OwnsId
-- ("guides", the pack the harness compiles for) and ns.Guides.Validate; a deferred guide (race part)
-- also has its stepsSrc loaded and its steps validated, as Guides.Steps does on first read.
-- Answers one line per chunk: "ok <guides>" or "refuse <reason>".
--   lua5.1 oracle.lua <path to addon/Polestar/Core/Guides.lua>

local guidesFile = assert(arg[1], "usage: oracle.lua <Guides.lua>")
local noop = function() end
local ns = {
	L = setmetatable({}, { __index = function(_, k) return k end }),
	EscapeText = function(s) return s end,
	On = noop,
	RegisterEvent = noop,
	OnLogin = noop,
	Debug = noop,
	GuideTexts = {},
}
assert(loadfile(guidesFile))("Polestar", ns)
local Guides = ns.Guides

local function check(def)
	if type(def) ~= "table" or type(def.id) ~= "string" or def.id == "" then return "missing id" end
	if not Guides.OwnsId("guides", def.id) then return "id outside pack guides: " .. def.id end
	local err = Guides.Validate(def)
	if err then return err end
	if rawget(def, "steps") == nil and type(def.stepsSrc) == "string" then
		local fn, perr = loadstring(def.stepsSrc, "=stepsSrc")
		if not fn then return "stepsSrc does not load: " .. tostring(perr) end
		setfenv(fn, {})
		local ok, list = pcall(fn)
		if not (ok and type(list) == "table") then return "bad steps" end
		local copy = {}
		for k, v in pairs(def) do copy[k] = v end
		copy.stepsSrc, copy.stepCount, copy.steps = nil, nil, list
		return Guides.Validate(copy)
	end
	return nil
end

local function answer(chunk)
	local defs = {}
	Polestar = {
		RegisterGuide = function(def) defs[#defs + 1] = def; return true end,
		PartWants = function() return true end,
	}
	local fn, perr = loadstring(chunk, "=Guides.lua")
	if not fn then return "refuse Guides.lua does not load: " .. tostring(perr) end
	local ok, rerr = pcall(fn)
	if not ok then return "refuse Guides.lua errors: " .. tostring(rerr) end
	for i = 1, #defs do
		local ok2, err = pcall(check, defs[i])
		if not ok2 then return "refuse validator error: " .. tostring(err) end
		if err then return "refuse " .. tostring(defs[i].id) .. ": " .. err end
	end
	return "ok " .. #defs
end

while true do
	local n = io.read("*n")
	if not n then break end
	io.read("*l")
	local chunk = n > 0 and io.read(n) or ""
	local line = answer(chunk):gsub("[\r\n]", " ")
	io.write(line, "\n")
	io.flush()
end
