-- Polestar.ProfessionTrainers: which of a profession's trainers can teach a rank and accept the
-- character's skill (#3784). Data: Codex.Profession(line) (forge data codex, from professions.json's
-- rank trainer lists and trainerSkill). No record (secondary professions, an older pack): nil, callers
-- choose as before.
--
--   ProfessionTrainers.NextRank(line, skill, maxRank) -> rank | nil
--       the rank (index) the character trains next: the first whose cap is above maxRank (nil maxRank:
--       not learned, Apprentice), once skill reaches its minSkill. nil: top rank, below the threshold,
--       no data.
--   ProfessionTrainers.RankFor(line, skill) -> rank, cap | nil
--       the rank a recipe needing `skill` is made at (first cap reaching it) and that rank's cap.
--   ProfessionTrainers.Accepts(line, code, skill, rank) -> fn(npcId) -> bool | nil
--       the trainers that may be chosen (code "A" | "H" | nil: either side's list). rank nil: any
--       trainer of the line. A trainer's trainerSkill must be at most the skill, or the rank's minSkill
--       when that is higher (the rank is trained once the skill reaches it).
local ADDON, ns = ...

local P = {}
ns.ProfessionTrainers = P

local function record(line)
	local X = ns.Codex
	local rec = X and X.Profession and X.Profession(line)
	if rec and rec.ranks and rec.ranks[1] then return rec end
end

function P.NextRank(line, skill, maxRank)
	local rec = record(line)
	if not rec then return nil end
	for i, r in ipairs(rec.ranks) do
		if r.max > (maxRank or 0) then
			if (skill or 0) >= r.minSkill then return i end
			return nil
		end
	end
end

function P.RankFor(line, skill)
	local rec = record(line)
	if not rec then return nil end
	local n = #rec.ranks
	for i, r in ipairs(rec.ranks) do
		if (skill or 1) <= r.max then return i, r.max end
	end
	return n, rec.ranks[n].max
end

function P.Accepts(line, code, skill, rank)
	local rec = record(line)
	if not rec then return nil end
	local allow
	local floorSkill = skill or 0
	local r = rank and rec.ranks[rank]
	if r then
		allow = {}
		for _, side in ipairs(code and { code } or { "A", "H" }) do
			for _, id in ipairs(r[side] or {}) do allow[id] = true end
		end
		if r.minSkill > floorSkill then floorSkill = r.minSkill end
	end
	local gates = rec.trainerSkill or {}
	return function(id)
		return (not allow or allow[id] == true) and (gates[id] or 0) <= floorSkill
	end
end
