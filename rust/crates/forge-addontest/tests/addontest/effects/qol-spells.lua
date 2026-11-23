-- env: qol
-- The Quality of Life page's class spells rows (QoL/Spells.lua: the spells a level opens, the old ranks on the
-- action bars) on the real QoL against stub_qol.lua's client, as qol-spells.rs plays them: a Human Priest whose
-- class trainer has three new spells at 10, Renew 1-3 in the spellbook and rank 2 on bar 1 slot 5. Each check reads
-- what the module tells the cards (LEVELUP_SPELLS, OLD_RANKS) and what it lists.
local q, S, C
local cards, ranks = 0, 0
local NAMES, RANKS = {}, {}
local function spell(id, name, rank) NAMES[id] = name; RANKS[id] = rank end
return {
	setup = function()
		q, S, C = stub.qol, Polestar.QoL.Spells, Polestar.Compat
		Polestar.QoL.SetClassSpells({ PRIEST = "6=591:100:2:585;10=139:300:2:136,586:300:1,594:300:2:589" })
		local known = { [589] = true, [136] = true, [585] = true }
		C.IsSpellKnown = function(id) return known[id] == true end
		IsPlayerSpell = function(id) return known[id] == true end
		C.GetPlayerInfo = function() return { name = "T", level = q.level, race = "Human", class = "PRIEST", faction = "Alliance" } end
		UnitRace = function() return "Human", "Human", 1 end
		C_Spell.GetSpellName = function(id) return NAMES[id] end
		C_Spell.GetSpellSubtext = function(id) return RANKS[id] and ("Rank " .. RANKS[id]) or "" end
		local book = { 136, 139, 6074 }
		spell(136, "Renew", 1); spell(139, "Renew", 2); spell(6074, "Renew", 3)
		C_SpellBook = {
			GetNumSpellBookSkillLines = function() return 1 end,
			GetSpellBookSkillLineInfo = function() return { itemIndexOffset = 0, numSpellBookItems = #book } end,
			GetSpellBookItemInfo = function(i) return book[i] and { spellID = book[i], itemType = 1, name = NAMES[book[i]] } or nil end,
		}
		local actions = { [5] = { "spell", 139 } }
		HasAction = function(s) return actions[s] ~= nil end
		GetActionInfo = function(s) local a = actions[s]; if a then return a[1], a[2] end end
		GetCursorInfo = function() end
		Polestar.On("LEVELUP_SPELLS", function() cards = cards + 1 end)
		Polestar.On("OLD_RANKS", function(n) if n then ranks = ranks + 1 end end)
		q.money = 1000
		-- Past the login's snapshot of the bars.
		stub.advance(7)
	end,
	probes = {
		-- A ding at 10, where the trainer has three new spells: the level-up card told.
		["qol.levelUpSpells"] = function()
			local before = cards
			q.level = 10
			stub.fire("PLAYER_LEVEL_UP", 10, 0, 0, 0, 0, 0, 0, 0, 0)
			stub.advance(3)
			q.level = 9
			return cards - before
		end,
		-- The check the spellbook and the trainer run: Renew 2 on slot 5 with rank 3 known, told.
		["qol.oldRanks"] = function()
			local before = ranks
			S.CheckRanks(true)
			return ranks - before
		end,
		-- Renew 2 kept at its rank (right-click on the card), then Forget: listed again.
		["Quality of Life:Forget kept ranks"] = { press = true, prepare = function() S.Keep(139) end, cleanup = function() S.ForgetKept() end,
			probe = function() return #S.OldRanks() end },
	},
}
