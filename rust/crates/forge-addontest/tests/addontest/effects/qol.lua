-- env: qol
-- The Quality of Life page (QoL/*.lua): the real QoL against tests/lua/stub_qol.lua's client (merchants, trainers,
-- gossip, the flight map, deaths, requests from other players; fake Engine, Nav and Pins), as qol.rs and
-- qol-items.rs run it. Each check plays the moment the setting acts on (a merchant opens, a duel is asked, the
-- player dies as a ghost, ...) and reads what the addon did: the client calls it made, the arrow, its buttons.
local q, QoL, s
local function calls(name) local n = 0 for _, c in ipairs(q.calls) do if c[1] == name then n = n + 1 end end return n end
local function bagsChanged() stub.fire("BAG_UPDATE_DELAYED"); stub.advance(0.1) end
local function emptyBags() for bag = 0, 5 do q.bags[bag].slots = {} end bagsChanged() end
-- Bag 0 (16 slots) with `free` of them free: a grey fang (junk) and cloth.
local function fill(free)
	q.bags[0].slots = {}
	q.addItem(0, 1, 1, 2)
	for slot = 2, 16 - free do q.addItem(0, slot, 3, 1) end
	bagsChanged()
end
local function merchant(read)
	q.calls = {}
	q.openMerchant()
	stub.advance(2)
	local out = read()
	q.closeMerchant()
	stub.advance(0.1)
	return out
end
-- The Restock button under the merchant window: what a press buys.
local function restock()
	return merchant(function()
		for _, f in ipairs((MerchantFrame or UIParent).children or {}) do
			if f.psTipLines and f:IsShown() then return table.concat(f.psTipLines, ", ") end
		end
		return false
	end)
end
local TAXI = { gossipOptionID = 77, name = "Show me where I can fly.", icon = 132057, orderIndex = 0 }
local TALK = { gossipOptionID = 78, name = "Tell me about the gryphons.", icon = 132053, orderIndex = 1 }
local BIND = { gossipOptionID = 90, name = "Make this inn your home.", icon = 132052, orderIndex = 0 }
local SHOP = { gossipOptionID = 91, name = "Let me browse your goods.", icon = 132060, orderIndex = 1 }
local function gossip(npc, options)
	q.calls = {}
	q.openGossip(npc, { options = options })
	stub.runTimers()
	local picked = 0
	for _, c in ipairs(q.calls) do if c[1] == "SelectOption" then picked = c[2] end end
	stub.fire("GOSSIP_CLOSED")
	return picked
end
local function invite(name, guid)
	q.calls = {}
	q.showPopup("PARTY_INVITE")
	stub.fire("PARTY_INVITE_REQUEST", name, false, false, false, true, false, guid, false)
	stub.runTimers()
	return { accept = calls("AcceptGroup"), decline = calls("DeclineGroup") }
end
local SPELLS = {
	{ name = "Fireball", rank = "Rank 1", kind = "used", cost = 0 },
	{ name = "Fireball", rank = "Rank 2", kind = "available", cost = 100 },
	{ name = "Frost Armor", rank = "Rank 1", kind = "available", cost = 200 },
}
local breath, flashes = 30000, 0
local ridings = 0
return {
	setup = function()
		q, QoL = stub.qol, Polestar.QoL
		s = q.social
		s.friends["Player-1-F"] = true
		QoL.SetData({ spiritHealers = { { 0, 20, 0, 9000, 50, 49 } }, flightMasters = {} })
		q.level = 20
		q.money = 100000
		q.items[1] = { name = "Broken Fang", quality = 0, price = 7 }
		q.items[3] = { name = "Linen Cloth", quality = 1, price = 13 }
		q.items[20] = { name = "Soothing Spices", quality = 1, price = 10 }
		q.items[30] = { name = "Refreshing Spring Water", quality = 1, classID = 0, spell = 430, spellName = "Drink", minLevel = 1 }
		q.items[33] = { name = "Tough Hunk of Bread", quality = 1, classID = 0, spell = 433, spellName = "Food", minLevel = 1 }
		q.items[34] = { name = "Light Shot", quality = 1, classID = 6, subclassID = 3 }
		q.items[36] = { name = "Old Blunderbuss", quality = 1, classID = 2, subclassID = 3 }
		q.worn[18] = 36
		q.goods = {
			{ id = 30, price = 25, stackCount = 5 },
			{ id = 33, price = 25, stackCount = 5 },
			{ id = 34, price = 10, stackCount = 200, maxStack = 200 },
			{ id = 20, price = 40 },
		}
		GetMirrorTimerProgress = function(t) if t == "BREATH" then return breath end end
		FlashClientIcon = function() flashes = flashes + 1 end
		Polestar.On("RIDING_DUE", function() ridings = ridings + 1 end)
	end,
	probes = {
		-- A flight master's gossip (a taxi option among others): the flight map opened.
		["qol.flightAutoOpen"] = function() return gossip(1, { TALK, TAXI }) end,
		-- The flight map on a step flying to Lakeshire: its node marked.
		["qol.flightHighlight"] = function()
			q.step({ { t = "fly", location = "Lakeshire" } })
			q.openTaxi({ "Stormwind, Elwynn", "Lakeshire, Redridge", "Sentinel Hill, Westfall" })
			local node = QoL.Flight.node or false
			stub.fire("TAXIMAP_CLOSED")
			TaxiFrame:Hide()
			return node
		end,
		-- The step's innkeeper on a sethome step: the bind option picked.
		["qol.autoBind"] = function()
			q.step({ { t = "sethome", location = "Goldshire", npc = 295 } })
			return gossip(295, { SHOP, BIND })
		end,
		-- Dead, a ghost: the arrow held on the corpse or the Spirit Healer.
		["qol.deathHelper"] = function()
			q.level = 8
			q.ghost = true
			stub.fire("PLAYER_ALIVE")
			stub.advance(0.2)
			local t = q.nav.target
			local out = { label = t and t.label or false, held = t ~= nil and q.nav.held == t }
			q.ghost = false
			stub.fire("PLAYER_UNGHOST")
			stub.advance(0.2)
			q.level = 20
			return out
		end,
		-- Breath running down to nine seconds: a warning (the client's icon flashes).
		["qol.breathWarning"] = function()
			local before = flashes
			breath = 30000
			stub.fire("MIRROR_TIMER_START", "BREATH", 30000, 30000, -1, false, "Breath")
			breath = 9000
			stub.advance(0.5)
			stub.fire("MIRROR_TIMER_STOP", "BREATH")
			stub.advance(0.1)
			return flashes - before
		end,
		["qol.autoReleasePvP"] = function()
			q.calls = {}
			s.battleground = true
			stub.fire("PLAYER_DEAD")
			stub.runTimers()
			s.battleground = false
			return calls("RepopMe")
		end,
		["qol.acceptSummon"] = function()
			q.calls = {}
			q.showPopup("CONFIRM_SUMMON")
			stub.fire("CONFIRM_SUMMON", 0, false)
			stub.runTimers()
			return calls("ConfirmSummon")
		end,
		["qol.acceptResurrect"] = function()
			q.calls = {}
			s.offerer = "Priest"
			stub.fire("RESURRECT_REQUEST", "Priest")
			stub.runTimers()
			s.offerer = nil
			return calls("AcceptResurrect")
		end,
		["qol.acceptPartyFriends"] = function() return invite("Fay", "Player-1-F") end,
		["qol.declinePartyStrangers"] = function() return invite("Rando", "Player-1-Z") end,
		["qol.declineGuildInvites"] = function()
			q.calls = {}
			GuildInviteFrame:Show()
			stub.fire("GUILD_INVITE_REQUEST", "Rando", "Spam Guild", 0, nil, false)
			stub.runTimers()
			local out = { declined = calls("DeclineGuild"), window = GuildInviteFrame:IsShown() }
			GuildInviteFrame:Hide()
			return out
		end,
		["qol.declineDuels"] = function()
			q.calls = {}
			stub.fire("DUEL_REQUESTED", "Rando")
			stub.runTimers()
			return calls("CancelDuel")
		end,
		-- A merchant with three grey fangs in the bags: sold.
		["qol.sellJunk"] = function()
			q.addItem(0, 1, 1, 3)
			local sold = #(q.sold or {})
			local out = merchant(function() return #(q.sold or {}) - sold end)
			emptyBags()
			return out
		end,
		-- A merchant that repairs, 50c owed: repaired (from the guild bank when it may).
		["qol.autoRepair"] = function()
			q.repair = { can = true, cost = 50 }
			return merchant(function() return calls("RepairAllItems") end)
		end,
		["qol.repairGuild"] = function()
			q.repair = { can = true, cost = 50, guild = true }
			return merchant(function()
				for _, c in ipairs(q.calls) do if c[1] == "RepairAllItems" then return c[2] end end
				return false
			end)
		end,
		-- A step buying three Soothing Spices at a merchant selling them: bought.
		["qol.buyGoals"] = function()
			q.step({ { t = "buy", item = 20, count = 3, itemName = "Soothing Spices" } })
			local out = merchant(function() return calls("BuyMerchantItem") end)
			emptyBags()
			return out
		end,
		["qol.restock"] = { prepare = function() QoL.Restock.Set("drink", 20) end, probe = restock,
			cleanup = function() QoL.Restock.Set("drink", nil) end },
		["Quality of Life:Drinks"] = restock,
		["Quality of Life:Food"] = restock,
		["Quality of Life:Ammunition"] = restock,
		-- Two free slots, then three: the bag button (free slots and the cheapest junk).
		["qol.bagSpace"] = { prepare = function() fill(2) end, probe = function() return QoL.Buttons.bag:IsShown() and true or false end, cleanup = emptyBags },
		["qol.bagsLow"] = { prepare = function() fill(3) end, probe = function() return QoL.Buttons.bag:IsShown() and true or false end, cleanup = emptyBags },
		-- Ctrl-Alt-click an item link: marked as junk (the mark taken off again).
		["qol.itemMarks"] = function()
			local M = QoL.Marks
			stub.keys.ctrl, stub.keys.alt = true, true
			Polestar.Hooks.OnItemClick("|Hitem:3|h[Linen Cloth]|h")
			stub.keys.ctrl, stub.keys.alt = false, false
			local mark = M.Get(3) or false
			M.Set(3, nil)
			return mark
		end,
		-- The flight map on a step flying to Lakeshire: its node marked.
		["qol.flightHighlight"] = function()
			q.step({ { t = "fly", location = "Lakeshire" } })
			q.openTaxi({ "Stormwind, Elwynn", "Lakeshire, Redridge", "Sentinel Hill, Westfall" })
			local node = QoL.Flight.node or false
			stub.fire("TAXIMAP_CLOSED")
			TaxiFrame:Hide()
			return node
		end,
		-- The step's innkeeper on a sethome step: the bind option picked.
		["qol.autoBind"] = function()
			q.step({ { t = "sethome", location = "Goldshire", npc = 295 } })
			return gossip(295, { SHOP, BIND })
		end,
		-- Dead, a ghost: the arrow held on the corpse or the Spirit Healer.
		["qol.deathHelper"] = function()
			q.level = 8
			q.ghost = true
			stub.fire("PLAYER_ALIVE")
			stub.advance(0.2)
			local t = q.nav.target
			local out = { label = t and t.label or false, held = t ~= nil and q.nav.held == t }
			q.ghost = false
			stub.fire("PLAYER_UNGHOST")
			stub.advance(0.2)
			q.level = 20
			return out
		end,
		-- Breath running down to nine seconds: a warning (the client's icon flashes).
		["qol.breathWarning"] = function()
			local before = flashes
			breath = 30000
			stub.fire("MIRROR_TIMER_START", "BREATH", 30000, 30000, -1, false, "Breath")
			breath = 9000
			stub.advance(0.5)
			stub.fire("MIRROR_TIMER_STOP", "BREATH")
			stub.advance(0.1)
			return flashes - before
		end,
		["qol.autoReleasePvP"] = function()
			q.calls = {}
			s.battleground = true
			stub.fire("PLAYER_DEAD")
			stub.runTimers()
			s.battleground = false
			return calls("RepopMe")
		end,
		["qol.acceptSummon"] = function()
			q.calls = {}
			q.showPopup("CONFIRM_SUMMON")
			stub.fire("CONFIRM_SUMMON", 0, false)
			stub.runTimers()
			return calls("ConfirmSummon")
		end,
		["qol.acceptResurrect"] = function()
			q.calls = {}
			s.offerer = "Priest"
			stub.fire("RESURRECT_REQUEST", "Priest")
			stub.runTimers()
			s.offerer = nil
			return calls("AcceptResurrect")
		end,
		["qol.acceptPartyFriends"] = function() return invite("Fay", "Player-1-F") end,
		["qol.declinePartyStrangers"] = function() return invite("Rando", "Player-1-Z") end,
		["qol.declineGuildInvites"] = function()
			q.calls = {}
			GuildInviteFrame:Show()
			stub.fire("GUILD_INVITE_REQUEST", "Rando", "Spam Guild", 0, nil, false)
			stub.runTimers()
			local out = { declined = calls("DeclineGuild"), window = GuildInviteFrame:IsShown() }
			GuildInviteFrame:Hide()
			return out
		end,
		["qol.declineDuels"] = function()
			q.calls = {}
			stub.fire("DUEL_REQUESTED", "Rando")
			stub.runTimers()
			return calls("CancelDuel")
		end,
		-- A merchant with three grey fangs in the bags: sold.
		["qol.sellJunk"] = function()
			q.addItem(0, 1, 1, 3)
			local sold = #(q.sold or {})
			local out = merchant(function() return #(q.sold or {}) - sold end)
			emptyBags()
			return out
		end,
		-- A merchant that repairs, 50c owed: repaired (from the guild bank when it may).
		["qol.autoRepair"] = function()
			q.repair = { can = true, cost = 50 }
			return merchant(function() return calls("RepairAllItems") end)
		end,
		["qol.repairGuild"] = function()
			q.repair = { can = true, cost = 50, guild = true }
			return merchant(function()
				for _, c in ipairs(q.calls) do if c[1] == "RepairAllItems" then return c[2] end end
				return false
			end)
		end,
		-- A step buying three Soothing Spices at a merchant selling them: bought.
		["qol.buyGoals"] = function()
			q.step({ { t = "buy", item = 20, count = 3, itemName = "Soothing Spices" } })
			local out = merchant(function() return calls("BuyMerchantItem") end)
			emptyBags()
			return out
		end,
		["qol.restock"] = { prepare = function() QoL.Restock.Set("drink", 20) end, probe = restock,
			cleanup = function() QoL.Restock.Set("drink", nil) end },
		["Quality of Life:Drinks"] = restock,
		["Quality of Life:Food"] = restock,
		["Quality of Life:Ammunition"] = restock,
		-- Two free slots, then three: the bag button (free slots and the cheapest junk).
		["qol.bagSpace"] = { prepare = function() fill(2) end, probe = function() return QoL.Buttons.bag:IsShown() and true or false end, cleanup = emptyBags },
		["qol.bagsLow"] = { prepare = function() fill(3) end, probe = function() return QoL.Buttons.bag:IsShown() and true or false end, cleanup = emptyBags },
		-- Ctrl-Alt-click an item link: marked as junk (the mark taken off again).
		["qol.itemMarks"] = function()
			local M = QoL.Marks
			stub.keys.ctrl, stub.keys.alt = true, true
			Polestar.Hooks.OnItemClick("|Hitem:3|h[Linen Cloth]|h")
			stub.keys.ctrl, stub.keys.alt = false, false
			local mark = M.Get(3) or false
			M.Set(3, nil)
			return mark
		end,
		-- The same click with Ctrl+Alt-click cycles off: no mark (#2125).
		["qol.itemMarksClick"] = function()
			local M = QoL.Marks
			stub.keys.ctrl, stub.keys.alt = true, true
			Polestar.Hooks.OnItemClick("|Hitem:3|h[Linen Cloth]|h")
			stub.keys.ctrl, stub.keys.alt = false, false
			local mark = M.Get(3) or false
			M.Set(3, nil)
			return mark
		end,
		-- The flight map on a step flying to Lakeshire, its node marked: the flight taken.
		["qol.flightAutoTake"] = function()
			q.step({ { t = "fly", location = "Lakeshire" } })
			q.calls = {}
			q.openTaxi({ "Stormwind, Elwynn", "Lakeshire, Redridge", "Sentinel Hill, Westfall" })
			stub.runTimers()
			local out = calls("TakeTaxiNode")
			stub.fire("TAXIMAP_CLOSED")
			TaxiFrame:Hide()
			return out
		end,
		-- The campfire's Boosted Rest on the player (42 minutes left): its line under the guide window's XP line.
		["qol.boostedRest"] = function()
			q.auras[1229451] = { spellId = 1229451, duration = 3600, expirationTime = GetTime() + 2520 }
			stub.fire("UNIT_AURA", "player")
			stub.runTimers()
			local out = table.concat(QoL.Rest.Parts(), " | ")
			q.auras[1229451] = nil
			stub.fire("UNIT_AURA", "player")
			stub.runTimers()
			return out
		end,
		-- Level 40 without riding: the reminder (once per character: its flag cleared again).
		["qol.ridingReminder"] = function()
			local before = ridings
			q.level = 40
			stub.fire("PLAYER_LEVEL_UP", 40, 0, 0, 0, 0, 0, 0, 0, 0)
			stub.runTimers()
			q.level = 20
			Polestar.CharState().flags.ridingReminder40 = nil
			return ridings - before
		end,
		-- XP coming in, then /pole xp: the session's pace (level, time, kills, quests), or that the tracker is off.
		["qol.xpTracker"] = function()
			q.gainXP(50)
			stub.advance(0.5)
			SlashCmdList.POLESTAR("xp")
			local said = stub.messages[#stub.messages] or ""
			if said:find("tracker is off", 1, true) then return "the tracker is off" end
			return said:find("Level %d+: ") and "the session's pace" or said
		end,
		["Quality of Life:Reset session"] = { press = true, prepare = function() q.gainXP(50); stub.advance(0.2) end,
			probe = function() local st = QoL.GetXPStats(); return st and st.sessionXP or false end },
		-- The game's own setting (no Polestar key): the client's CVar as the row leaves it; put back as it was (a
		-- reset does not touch it).
		["Quality of Life:Increase game image quality"] = { restore = true, probe = function() return GetCVar("ResampleAlwaysSharpen") end },
	},
}
