-- From the repo root: lua tools/sky-jewels.lua > addon/Polestar_SkyJewels/SkyJewelsLevels.lua
-- Use --verify to test the installed level table without regenerating it.
local root = assert(arg[0]:match("^(.*)tools[/\\]sky%-jewels%.lua$"), "Run using the path to tools/sky-jewels.lua")
local addon = root .. "addon/Polestar_SkyJewels/"
local ns, verify = {}, arg[1] == "--verify"
if verify then assert(loadfile(addon .. "SkyJewelsLevels.lua"))("Polestar_SkyJewels", ns) end
assert(loadfile(addon .. "SkyJewelsBoard.lua"))("Polestar_SkyJewels", ns)
local Board = ns.SkyJewelsBoard
local FIRST, LAST, BAND_SIZE, POLICIES = 9, 60, 7, 20
local modes = { "score", "collect", "bonus", "collect", "sprint", "bonus", "both" }
local passBands = { { 14, 18 }, { 12, 14 }, { 10, 12 }, { 8, 10 }, { 6, 8 }, { 3, 5 }, { 3, 5 }, { 2, 4 } }

local function pattern(level)
	local offset = level - FIRST
	local mode = modes[offset % BAND_SIZE + 1]
	local tier = math.min(2, math.floor(offset / 14))
	local rules = { colors = 6, moves = 16 - tier, goal = 810 + offset * 22 }
	if mode == "collect" or mode == "both" then
		rules.jewel = (offset * 5 + math.floor(offset / BAND_SIZE)) % rules.colors + 1
		rules.count = 13 + math.floor(offset / BAND_SIZE)
	end
	if mode == "bonus" or mode == "both" then
		rules.bonuses = (mode == "both" and 2 or 3) + tier
	end
	if mode == "sprint" then rules.moves = rules.moves - 2 end
	if mode == "score" or mode == "sprint" then rules.goal = rules.goal + 140 end
	return rules, passBands[math.floor(offset / BAND_SIZE) + 1]
end

local pairsToTry = {}
for a = 1, Board.count do
	for _, b in ipairs({ a + 1, a + Board.size }) do
		if b <= Board.count and Board.Adjacent(a, b) then pairsToTry[#pairsToTry + 1] = { a, b } end
	end
end

local function copy(state)
	local trial = {}
	for key, value in pairs(state) do trial[key] = value end
	trial.tiles = Board.Copy(state.tiles)
	return trial
end

-- Rank only the effects visible before any new relics fall.
local function value(state, rules, first, a, b, policy)
	local points = math.min(first.points, math.max(rules.goal - state.score, 0)) + 0.08 * first.points
	if rules.jewel and state.collected < rules.count then
		local gems = 0
		for i in pairs(first.cleared) do
			local source = i == a and b or (i == b and a or i)
			if Board.Jewel(state.tiles[source]) == rules.jewel then gems = gems + 1 end
		end
		points = points + math.min(rules.count - state.collected, gems) * (22 + policy % 5 * 7)
	end
	local creation = 15 + policy % 7 * 6
	if rules.bonuses and state.bonuses < rules.bonuses then
		creation = creation + 22
		points = points + math.min(rules.bonuses - state.bonuses, first.fired) * (42 + policy % 6 * 8)
	end
	for _ in pairs(first.created) do points = points + creation end
	local noise = (((a * 803 + b * 1831) * (policy * 809 + 971) + state.moves * 9667 + state.level * 3737) % 4327) / 4327
	return points + noise * (12 + policy % 4 * 8)
end

local function play(level, policy)
	local state = Board.Start(level)
	local rules, path = Board.levels[level], {}
	local openings
	while state.moves > 0 and not Board.Won(state) do
		local best, bestValue, bestSwap, legal = nil, -math.huge, nil, 0
		for _, pair in ipairs(pairsToTry) do
			local a, b = pair[1], pair[2]
			local trial = copy(state)
			local waves = Board.Move(trial, a, b)
			if waves then
				legal = legal + 1
				local utility = value(state, rules, waves[1], a, b, policy)
				if utility > bestValue then
					best, bestValue, bestSwap = trial, utility, pair
				end
			end
		end
		assert(best, "The board ran out of legal swaps")
		openings = openings or legal
		state = best
		path[#path + 1] = bestSwap
	end
	if Board.Won(state) then return path, openings end
	return nil, openings
end

local function evaluate(level, from, to)
	local won, route, openings = 0, nil, nil
	for policy = from, to do
		local path, legal = play(level, policy)
		openings = legal
		if path then
			won = won + 1
			if not route or #path < #route then route = path end
		end
	end
	return won, route, openings
end

local function replay(level, path)
	local state = Board.Start(level)
	assert(Board.Valid(state))
	for _, pair in ipairs(path) do
		assert(Board.Move(state, pair[1], pair[2]), "The winning route could not be replayed")
		state = copy(state)
		assert(Board.Valid(state))
	end
	assert(Board.Won(state), "The replay did not win")
end

local function generate(level, rules, band)
	Board.levels[level] = rules
	for attempt = 1, 96 do
		rules.seed = 162633554 + level * 104729 + attempt * 13007
		local won, path, openings = evaluate(level, 1, POLICIES)
		if openings >= 3 and won >= band[1] and won <= band[2] then return won, path, openings end
	end
	error(("Level %d did not meet the difficulty band across 96 seeds"):format(level))
end

local function formatRules(rules)
	local fields = { ("seed = %d, moves = %d, goal = %d, colors = %d"):format(rules.seed, rules.moves, rules.goal, rules.colors) }
	if rules.jewel then fields[#fields + 1] = ("jewel = %d, count = %d"):format(rules.jewel, rules.count) end
	if rules.bonuses then fields[#fields + 1] = ("bonuses = %d"):format(rules.bonuses) end
	return table.concat(fields, ", ")
end

local output, sample = {}, 0
if verify then assert(#Board.levels == LAST, "Unexpected campaign size") end
for level = FIRST, LAST do
	local rules, band = pattern(level)
	local won, path, openings
	if verify then
		rules = Board.levels[level]
		won, path, openings = evaluate(level, 1, POLICIES)
		assert(openings >= 3 and won >= band[1] and won <= band[2], ("Level %d is outside its difficulty band"):format(level))
		sample = sample + evaluate(level, POLICIES + 1, POLICIES * 2)
	else
		won, path, openings = generate(level, rules, band)
		output[#output + 1] = ("\t{ %s }, -- %d"):format(formatRules(rules), level)
	end
	replay(level, path)
	io.stderr:write(("Level %d: %d/%d wins, %d opening moves, solved in %d/%d moves\n"):format(level, won, POLICIES, openings, #path, rules.moves))
	local bandLength = (level - FIRST) % BAND_SIZE + 1
	if verify and (bandLength == BAND_SIZE or level == LAST) then
		io.stderr:write(("Levels %d-%d, separate sample: %d/%d wins\n"):format(level - bandLength + 1, level, sample, bandLength * POLICIES))
		sample = 0
	end
end

if not verify then
	print("-- Generated by tools/sky-jewels.lua. The first eight levels are defined in SkyJewelsBoard.lua.")
	print("local _, ns = ...")
	print("ns.SkyJewelsLevels = {")
	print(table.concat(output, "\n"))
	print("}")
end
