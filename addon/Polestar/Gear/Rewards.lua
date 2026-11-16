-- Ranking quest reward choices for the guide's reward picks (Gear/Picks.lua:
-- the turn-in goal's pick and reward-item tooltips). The marks on the
-- client's reward panel belong to QoL (QoL/Rewards.lua), which reads
-- Gear.IsUpgrade per choice.
--
--   Gear.RankChoices(links) -> list, pick, bestUpgrade, pending
--       list[i] = { index, link, id, usable, upgrade, delta, pct, score, minLevel, pending,
--                   flbis, empty } (flbis: Forever Leveling BiS's numbers, delta in its points)
--       pick = the index to take: the upgrade with the largest gain; with no
--       upgrade, the highest-scoring choice this character can use; nil when
--       none is usable. bestUpgrade = pick when it is an upgrade, else nil.
--       Deterministic: ties go to the higher score, then the lower item ID,
--       then the earlier choice. pending: a choice's answer waits on loading
--       item data (Forever Leveling BiS's, Gear.CompareToEquipped); no pick
--       until every choice is told.

local ADDON, ns = ...

local Gear = ns.Gear
local ipairs = ipairs

-- a ranks before b?
local function better(a, b)
	if a.upgrade ~= b.upgrade then return a.upgrade end
	local da, db = a.upgrade and a.delta or a.score or 0, b.upgrade and b.delta or b.score or 0
	if da ~= db then return da > db end
	if (a.score or 0) ~= (b.score or 0) then return (a.score or 0) > (b.score or 0) end
	if (a.id or 0) ~= (b.id or 0) then return (a.id or 0) < (b.id or 0) end
	return a.index < b.index
end

function Gear.RankChoices(links)
	local list, pick, pending = {}, nil, false
	for i, link in ipairs(links) do
		local e = { index = i, link = link, id = link and Gear.ItemID(link), usable = false, upgrade = false }
		local r = link and Gear.CompareToEquipped(link)
		if r and r.pending then
			e.pending, pending = true, true
		elseif r and r.usable then
			e.usable, e.score, e.minLevel, e.flbis, e.empty = true, r.score, r.minLevel, r.flbis, r.empty
			e.upgrade, e.delta, e.pct = Gear.IsUpgrade(link)
		end
		list[i] = e
		-- Forever Leveling BiS may give a gain without a score: the gain ranks it.
		if e.usable and (e.score or e.delta) and (not pick or better(e, list[pick])) then pick = i end
	end
	if pending then return list, nil, nil, true end
	return list, pick, (pick and list[pick].upgrade) and pick or nil, false
end
