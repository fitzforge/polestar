-- Sky Jewels by RikyZ90, a match-three game in Polestar's Arcade (Polestar_Arcade/games/skyjewels).
-- GPL-3.0-only, as Polestar: see CREDITS.md in this folder and LICENSE in the Polestar folder.
-- The board: swaps, matches, bonuses, gravity and the first eight levels; no frames.
local _, ns = ...

local SIZE, COUNT = 7, 49
local STEPS = { 1, SIZE }
local SWEEP_ROW, SWEEP_COL, BURST = 1, 2, 3
local RNG_LIMIT = 2147483647
local levels = {
	{ moves = 12, goal = 360, colors = 5 },
	{ moves = 12, goal = 460, colors = 5 },
	{ moves = 13, goal = 460, colors = 5, jewel = 2, count = 9 },
	{ moves = 14, goal = 500, colors = 6, jewel = 4, count = 9 },
	{ moves = 14, goal = 560, colors = 6, jewel = 3, count = 11 },
	{ moves = 15, goal = 630, colors = 6, jewel = 1, count = 12 },
	{ moves = 15, goal = 700, colors = 6, jewel = 5, count = 13 },
	{ moves = 16, goal = 800, colors = 6, jewel = 6, count = 14 },
}

for _, rules in ipairs(ns.SkyJewelsLevels or {}) do levels[#levels + 1] = rules end

local Board = { size = SIZE, count = COUNT, levels = levels, row = SWEEP_ROW, column = SWEEP_COL, burst = BURST }
ns.SkyJewelsBoard = Board

-- A tile stores its jewel in the units digit and its bonus in the tens digit.
function Board.Jewel(piece) return piece % 10 end
function Board.Bonus(piece) return math.floor(piece / 10) end

local jewel, bonus = Board.Jewel, Board.Bonus

function Board.Position(i)
	return (i - 1) % SIZE + 1, math.floor((i - 1) / SIZE) + 1
end

local function index(x, y) return (y - 1) * SIZE + x end

function Board.Adjacent(a, b)
	local x, y = Board.Position(a)
	local bx, by = Board.Position(b)
	return math.abs(x - bx) + math.abs(y - by) == 1
end

function Board.Copy(tiles)
	local copy = {}
	for i = 1, COUNT do copy[i] = tiles[i] end
	return copy
end

local function swap(tiles, a, b) tiles[a], tiles[b] = tiles[b], tiles[a] end

local function scan(tiles)
	local matched, crosses, runs = {}, {}, {}
	for _, step in ipairs(STEPS) do
		for line = 1, SIZE do
			local first = step == 1 and index(1, line) or index(line, 1)
			local start = 0
			for offset = 1, SIZE do
				local i = first + offset * step
				if offset == SIZE or jewel(tiles[i]) ~= jewel(tiles[i - step]) then
					local length = offset - start
					if length >= 3 then
						for k = start, offset - 1 do
							local pos = first + k * step
							if matched[pos] then crosses[pos] = true end
							matched[pos] = true
						end
						if length >= 4 then
							runs[#runs + 1] = { first + start * step, i - step, step, length }
						end
					end
					start = offset
				end
			end
		end
	end
	return matched, crosses, runs
end

local function makesMatch(tiles, i)
	local x, y = Board.Position(i)
	local c = jewel(tiles[i])
	for _, step in ipairs(STEPS) do
		local line = step == 1 and x or y
		local n = 1
		for distance = 1, line - 1 do
			if jewel(tiles[i - distance * step]) ~= c then break end
			n = n + 1
		end
		for distance = 1, SIZE - line do
			if jewel(tiles[i + distance * step]) ~= c then break end
			n = n + 1
		end
		if n >= 3 then return true end
	end
	return false
end

local function playable(tiles)
	for i = 1, COUNT do
		if bonus(tiles[i]) > 0 then return true end
	end
	for i = 1, COUNT do
		local x, y = Board.Position(i)
		for _, step in ipairs(STEPS) do
			local line = step == 1 and x or y
			local j = i + step
			if line < SIZE and tiles[i] ~= tiles[j] then
				swap(tiles, i, j)
				local matched = makesMatch(tiles, i) or makesMatch(tiles, j)
				swap(tiles, i, j)
				if matched then return true end
			end
		end
	end
	return false
end

local function draw(state, colors)
	if not levels[state.level].seed then return math.random(colors) end
	state.rng = (state.rng * 48271) % RNG_LIMIT
	return state.rng % colors + 1
end

local function fill(state, colors)
	local tiles = {}
	repeat
		for i = 1, COUNT do
			local x, y = Board.Position(i)
			local c
			repeat
				c = draw(state, colors)
			until not (x > 2 and tiles[i - 1] == c and tiles[i - 2] == c)
				and not (y > 2 and tiles[i - SIZE] == c and tiles[i - 2 * SIZE] == c)
			tiles[i] = c
		end
	until playable(tiles)
	return tiles
end

function Board.Start(level)
	local rules = levels[level]
	local state = { version = 1, level = level, moves = rules.moves, score = 0, collected = 0, rng = rules.seed }
	if rules.bonuses then state.bonuses = 0 end
	state.tiles = fill(state, rules.colors)
	return state
end

local function integer(value, min, max)
	return type(value) == "number" and value >= min and value <= max and value < math.huge and value == math.floor(value)
end

function Board.Valid(state)
	if type(state) ~= "table" or state.version ~= 1 or not integer(state.level, 1, #levels) then return false end
	local rules = levels[state.level]
	if not integer(state.moves, 0, rules.moves) or not integer(state.score, 0, math.huge)
		or not integer(state.collected, 0, rules.count or 0) or type(state.tiles) ~= "table" then return false end
	if rules.seed and not integer(state.rng, 1, RNG_LIMIT - 1) then return false end
	if rules.bonuses and not integer(state.bonuses, 0, rules.bonuses) then return false end
	for i = 1, COUNT do
		local tile = state.tiles[i]
		if not integer(tile, 1, BURST * 10 + rules.colors) or not integer(jewel(tile), 1, rules.colors) then return false end
	end
	local matched = scan(state.tiles)
	return not next(matched) and playable(state.tiles)
end

function Board.Won(state)
	local rules = levels[state.level]
	return state.score >= rules.goal and state.collected >= (rules.count or 0)
		and (not rules.bonuses or state.bonuses >= rules.bonuses)
end

local function makeBonuses(tiles, crosses, runs, a, b)
	local created = {}
	for i = 1, COUNT do
		if crosses[i] and bonus(tiles[i]) == 0 then created[i] = BURST end
	end
	for _, run in ipairs(runs) do
		local first, last, step, length = run[1], run[2], run[3], run[4]
		local spot, hasBurst
		for i = first, last, step do
			if created[i] == BURST then hasBurst = true end
			if bonus(tiles[i]) == 0 and (not spot or i == b or (spot ~= b and i == a)) then spot = i end
		end
		if spot and not hasBurst then
			created[spot] = length >= 5 and BURST or (step == 1 and SWEEP_ROW or SWEEP_COL)
		end
	end
	return created
end

local function expandBonuses(tiles, cleared)
	local queue, triggered = {}, nil
	for i = 1, COUNT do
		if cleared[i] and bonus(tiles[i]) > 0 then queue[#queue + 1] = i end
	end
	local function mark(x, y)
		local i = index(x, y)
		if cleared[i] then return end
		cleared[i] = true
		if bonus(tiles[i]) > 0 then queue[#queue + 1] = i end
	end
	local cursor = 1
	while queue[cursor] do
		local i = queue[cursor]
		local kind = bonus(tiles[i])
		local x, y = Board.Position(i)
		triggered = math.max(triggered or 0, kind)
		if kind == SWEEP_ROW then
			for col = 1, SIZE do mark(col, y) end
		elseif kind == SWEEP_COL then
			for row = 1, SIZE do mark(x, row) end
		else
			for row = math.max(1, y - 1), math.min(SIZE, y + 1) do
				for col = math.max(1, x - 1), math.min(SIZE, x + 1) do mark(col, row) end
			end
		end
		cursor = cursor + 1
	end
	return triggered, #queue
end

local function drop(state, cleared, colors)
	local tiles = state.tiles
	local distances = {}
	for x = 1, SIZE do
		local dest = SIZE
		for y = SIZE, 1, -1 do
			local from, to = index(x, y), index(x, dest)
			if not cleared[from] then
				tiles[to] = tiles[from]
				if dest > y then distances[to] = dest - y end
				dest = dest - 1
			end
		end
		for y = 1, dest do
			local i = index(x, y)
			tiles[i] = draw(state, colors)
			distances[i] = dest
		end
	end
	return distances
end

-- Resolve a whole move before animating it, so closing during a cascade saves a stable board.
function Board.Move(state, a, b)
	if state.moves <= 0 or Board.Won(state) or not Board.Adjacent(a, b) then return nil end
	local tiles = state.tiles
	swap(tiles, a, b)
	local cleared, crosses, runs = scan(tiles)
	if bonus(tiles[a]) > 0 then cleared[a] = true end
	if bonus(tiles[b]) > 0 then cleared[b] = true end
	if not next(cleared) then
		swap(tiles, a, b)
		return nil
	end
	state.moves = state.moves - 1
	local rules, waves = levels[state.level], {}
	repeat
		local created = makeBonuses(tiles, crosses, runs, a, b)
		local triggered, fired = expandBonuses(tiles, cleared)
		if rules.bonuses then state.bonuses = math.min(state.bonuses + fired, rules.bonuses) end
		local removed = 0
		for i = 1, COUNT do
			if created[i] then
				tiles[i] = jewel(tiles[i]) + created[i] * 10
				cleared[i] = nil
			elseif cleared[i] then
				removed = removed + 1
				if rules.jewel == jewel(tiles[i]) then
					state.collected = math.min(state.collected + 1, rules.count)
				end
			end
		end
		local points = removed * 10 * math.min(#waves + 1, 5)
		state.score = state.score + points
		local drops = drop(state, cleared, rules.colors)
		waves[#waves + 1] = {
			cleared = cleared, created = created, triggered = triggered, fired = fired,
			drops = drops, tiles = Board.Copy(tiles), points = points,
		}
		a, b = nil, nil
		cleared, crosses, runs = scan(tiles)
	until not next(cleared)
	if not playable(tiles) then
		state.tiles = fill(state, rules.colors)
		waves.shuffled = true
	end
	return waves
end
