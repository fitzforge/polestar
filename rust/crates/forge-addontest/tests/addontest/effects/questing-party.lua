-- env: world stub_party.lua
-- The Questing page's Group settings (Quests/Party.lua, PartyChat.lua; UI/PartyLoot.lua) on the whole addon in a
-- party with Ana, who runs Polestar (party.rs, party-chat.rs, party-group.rs): a guide at its kobold step with Kobold
-- Camp Cleanup done for you and Ana at 3/10, Wolves Across the Border's livers done for you and Ana at 3/5; what
-- goes to the party, what the guide window and the loot window say, and the party chat lines and filters.
local w, p, P, E
local n = 0
local function sent(prefix)
	local k = 0
	for _, m in ipairs(p.sent) do if m.text:sub(1, #prefix) == prefix then k = k + 1 end end
	return k
end
-- A quest of its own with one objective, finished: the party chat lines it makes (after the quiet time that
-- follows turning the lines on).
local function finish()
	stub.advance(6)
	n = n + 1
	local q = 5000 + n
	local before = #p.chat
	w.accept(q, { { text = "Thing: 0/1", required = 1 } }, "Errand " .. n)
	stub.advance(1)
	w.progress(q, 1, 1)
	stub.advance(5)
	local said = #p.chat - before
	w.abandon(q)
	stub.advance(1)
	return said
end
-- What Ana's Polestar sends: her progress on both quests.
local function heard()
	p.receive("Ana-TestRealm", "1|7:3/10;33:3/5")
	stub.advance(1)
end
local MINE = "{rt1} Polestar: |cffffff00|Hquest:33:0|h[Wolves Across the Border]|h|r is ready to turn in"
local SHOW = { ["party.show"] = true }
return {
	setup = function()
		w, p, P, E = stub.world, stub.party, Polestar.Party, Polestar.Engine
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 48.5, 42.5)
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/party", pack = "test", title = "Party", minLevel = 1, maxLevel = 10, steps = {
			{ goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
			{ goals = {
				{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
				{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
			} },
			{ title = "Kobolds", goals = {
				{ t = "kill", quest = 7, oi = 1, target = "Kobold Vermin", count = 10, map = 1429, x = 47, y = 35 },
				{ t = "collect", quest = 33, oi = 1, item = 723, itemName = "Goretusk Liver", count = 5, map = 1429, x = 47, y = 36 },
			} },
			{ goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		} })
		w.complete({ 783 })
		w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
		w.accept(33, { { text = "Goretusk Liver: 0/5", required = 5 } }, "Wolves Across the Border")
		w.onQuest(18, { 8 })
		Polestar.Engine.SetGuide("test/party")
		stub.advance(0.5)
		p.join("Ana")
		p.onQuest.Ana = { [7] = true, [33] = true }
		p.receive("Ana-TestRealm", "1Y|0.3.5")
		stub.advance(1)
		p.receive("Ana-TestRealm", "1|7:3/10;33:3/5")
		w.progress(7, 1, 10)
		w.progress(33, 1, 5)
		-- Past the quiet time after joining.
		stub.advance(6)
	end,
	settle = 0.5,
	probes = {
		-- Your progress on Gathering Wood moves: sent to the party.
		["party.share"] = function()
			n = n + 1
			local before = sent("1|") + sent("1R|")
			w.progress(18, 1, n % 8)
			stub.advance(6)
			return sent("1|") + sent("1R|") - before
		end,
		-- Ana's progress comes in: the kobold goal's party line in the guide window says where she is.
		["party.show"] = function()
			heard()
			return P.Line({ t = "kill", quest = 7, oi = 1, status = "done", subject = "Kobold Vermin" }) or false
		end,
		-- Done with the kobolds while Ana is not: the step waits for her.
		["party.waitForGroup"] = { with = SHOW, probe = function()
			heard()
			local _, holding = P.StepLine()
			return { holding = holding or false, live = E.GetLiveStep() }
		end },
		-- The loot window with a liver in it: who still needs one.
		["party.lootNeeds"] = { with = SHOW, probe = function()
			heard()
			local LIVER = "|cffffffff|Hitem:723::::::::|h[Goretusk Liver]|h|r"
			GetNumLootItems = function() return 1 end
			GetLootSlotLink = function() return LIVER end
			stub.fire("LOOT_OPENED")
			stub.advance(0.1)
			local lines = Polestar.UI.PartyLoot.Lines()
			local out = table.concat(lines, " / ")
			stub.fire("LOOT_CLOSED")
			return out
		end },
		["party.chat"] = finish,
		["party.chatOnlyNeeded"] = finish,
		-- Looting an item that starts a quest (the database's word): said in party chat.
		["party.chatLoot"] = function()
			n = n + 1
			local Q = Polestar.QuestDB
			local startedBy = Q.StartedBy
			Q.StartedBy = function(id) if id == 9000 + n then return { 7700 + n } end end
			w.titles[7700 + n] = "The Dark Iron War " .. n
			local before = #p.chat
			p.loot(9000 + n, "Mysterious Letter " .. n)
			stub.advance(5)
			Q.StartedBy = startedBy
			return #p.chat - before
		end,
		-- Your own line in the party chat frame, and Ana's.
		["party.chatEcho"] = function() return p.show("CHAT_MSG_PARTY", MINE, "Testchar") or "dropped" end,
		["party.chatHideOthers"] = function() return p.show("CHAT_MSG_PARTY", "{rt1} Polestar: x", "Ana-TestRealm") or "dropped" end,
	},
}
