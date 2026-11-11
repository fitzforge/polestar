-- env: qol
-- The Questing page's QoL settings (QoL/Options.lua; Gossip.lua, Toggles.lua, Rewards.lua, Equip.lua, Wear.lua,
-- Buttons.lua): the real QoL against stub_qol.lua's client, as qol.rs and qol-items.rs play it: an NPC's gossip,
-- a corpse to loot, the quest reward panel, gear looted, the target button's and step key's macros on a step
-- killing two mobs, and what the addon did or drew. The gear verdicts come from a Gear module faked as those tests
-- fake it.
local q, QoL, B
local function calls(name) local n = 0 for _, c in ipairs(q.calls) do if c[1] == name then n = n + 1 end end return n end
local function picked(npc, opts)
	q.calls = {}
	stub.fire("GOSSIP_CLOSED")
	q.openGossip(npc, opts)
	stub.runTimers()
	local out = false
	for _, c in ipairs(q.calls) do if c[1] == "SelectOption" or c[1] == "SelectOptionByIndex" then out = c[1] .. " " .. tostring(c[2]) end end
	stub.fire("GOSSIP_CLOSED")
	return out
end
local ONE = { { gossipOptionID = 5, name = "I want to browse your goods.", icon = 132060, orderIndex = 0, status = 0 } }
local CHAT = { gossipOptionID = 4021, name = "Tell me more.", icon = 132053, orderIndex = 0 }
local GOODS = { gossipOptionID = 91, name = "Let me browse your goods.", icon = 132060, orderIndex = 1 }
-- The reward panel's marks (qol.rs's marks()): per button, its arrow, coin and frame.
local function marks()
	local out = {}
	for _, b in ipairs(QuestInfoRewardsFrame.RewardButtons) do
		if b:IsShown() then
			local seen = { coin = false, best = false }
			for _, c in ipairs(b.children) do
				if c.Badge and c:IsShown() then seen.coin = c.Coin:IsShown(); seen.best = c.Ring[1]:IsShown() end
			end
			out[b:GetID()] = seen
		end
	end
	return out
end
local function panel()
	q.choices = { { id = 11 }, { id = 12 } }
	q.calls = {}
	q.questComplete()
	stub.runTimers()
end
local GEAR = {
	IsEnabled = function() return true end,
	IsUpgrade = function(link)
		if link:find("item:11|", 1, true) or link:find("item:14|", 1, true) or link:find("item:15|", 1, true) or link:find("item:17|", 1, true) then return true, 6, 12.5 end
		return false, -1
	end,
	CompareToEquipped = function(link)
		local id = tonumber(link:match("item:(%d+)"))
		return { slot = ({ [11] = 8, [14] = 1, [15] = 15, [17] = 9 })[id] or 6 }
	end,
	Client = { InventoryLink = function() return nil end },
	GetItemInfo = function() end,
	GainText = function(pct) return "+" .. math.floor(pct + 0.5) .. "%" end,
}
local function withGear() Polestar.Gear = GEAR end
local function noGear() Polestar.Gear = nil end
local looted, LOOT = 0, { 14, 15, 17 }
local announced = 0
local function macro(b) return b:GetAttribute("macrotext") or "" end
local function killStep() q.step({ { t = "kill", target = "Kobold Vermin", quest = 7, oi = 1 } }) end
local function npcStep() q.step({ { t = "turnin", quest = 9, npc = 240, npcName = "Marshal Dughan" } }) end
return {
	setup = function()
		q, QoL = stub.qol, Polestar.QoL
		B = QoL.Buttons
		q.items[11] = { name = "Cloak", price = 120, quality = 2, equipLoc = "INVTYPE_FEET" }
		q.items[12] = { name = "Potion", price = 400 }
		q.items[14] = { name = "Ridge Helm", quality = 2, equipLoc = "INVTYPE_HEAD" }
		q.items[15] = { name = "Dusty Cloak", quality = 2, equipLoc = "INVTYPE_CLOAK" }
		q.items[17] = { name = "Watcher's Bracers", quality = 2, equipLoc = "INVTYPE_WRIST" }
		q.bindings["CLICK PolestarStepButton:LeftButton"] = { "F" }
		-- The player's own instant quest text (off), which the setting turns on.
		stub.cvars.instantQuestText = "0"
		Polestar.Set("qol.instantQuestText", false)
		Polestar.Set("qol.instantQuestText", nil)
		-- The game's objective tracker (qol.rs's TRACKER).
		local f = CreateFrame("Frame", "ObjectiveTrackerFrame", UIParent)
		f.updates, f.hasContents, f.protected = 0, true, false
		function f:Update() self.updates = self.updates + 1; if self.hasContents then self:Show() else self:Hide() end end
		function f:IsProtected() return self.protected end
		SLASH_PING1 = "/ping"
		killStep()
	end,
	settle = 0.2,
	probes = {
		["qol.instantQuestText"] = function() return stub.cvars.instantQuestText end,
		-- An NPC with one gossip option and no quests: picked.
		["qol.skipGossip"] = function() return picked(9, { options = ONE }) end,
		-- A step talking to Magistrate Solomon through his "Tell me more." option.
		["qol.stepGossip"] = function()
			q.step({ { t = "talk", npc = 344, npcName = "Magistrate Solomon", gossip = 4021 } })
			local out = picked(344, { options = { CHAT, GOODS } })
			killStep()
			return out
		end,
		-- A corpse with three slots, auto-loot on.
		["qol.fastLoot"] = function()
			stub.advance(1)
			q.calls = {}
			q.loot = 3
			stub.fire("LOOT_READY", true)
			stub.fire("LOOT_CLOSED")
			return calls("LootSlot")
		end,
		["qol.hideErrors"] = function() return BLACK_LISTED_MESSAGE_TYPES[LE_GAME_ERR_OUT_OF_RAGE] or false end,
		["qol.hideQuestTracker"] = function() return ObjectiveTrackerFrame:IsShown() and true or false end,
		-- The reward panel: a cloak and five potions (worth more).
		["qol.rewardHighlight"] = function() panel(); local m = marks(); stub.fire("QUEST_FINISHED"); return m end,
		["qol.rewardAutoPick"] = function() panel(); local n = calls("GetQuestReward"); stub.fire("QUEST_FINISHED"); return n end,
		-- A turn-in giving the boots, an upgrade: worn once they reach the bags.
		["qol.rewardEquip"] = { prepare = withGear, cleanup = noGear, probe = function()
			q.landRewards = true
			q.choices, q.rewards = { { id = 11 }, { id = 12 } }, {}
			q.calls = {}
			q.questComplete()
			stub.runTimers()
			GetQuestReward(1)
			stub.advance(1)
			stub.fire("QUEST_FINISHED")
			return calls("EquipItemByName")
		end },
		-- Gear looted, an upgrade: offered (the guide window's banner). The bags are looked at first: turned on,
		-- it offers nothing that came while it was off.
		["qol.wearOffer"] = { prepare = withGear, cleanup = noGear, probe = function()
			looted = looted % #LOOT + 1
			stub.fire("BAG_UPDATE_DELAYED")
			stub.advance(0.1)
			q.addItem(0, 10 + looted, LOOT[looted], 1)
			stub.fire("BAG_UPDATE_DELAYED")
			stub.advance(0.1)
			local o = QoL.Wear.Offer()
			q.bags[0].slots[10 + looted] = nil
			stub.fire("BAG_UPDATE_DELAYED")
			stub.advance(0.1)
			return o ~= nil and o.slot ~= nil
		end },
		-- A new set of mobs to target: named in chat.
		["qol.targetAnnounce"] = function()
			announced = announced + 1
			local before = 0
			for _, m in ipairs(stub.messages) do if m:find("Targeting: ", 1, true) then before = before + 1 end end
			q.step({ { t = "kill", target = "Kobold Vermin" }, { t = "kill", target = "Kobold " .. announced } })
			stub.runTimers()
			local after = 0
			for _, m in ipairs(stub.messages) do if m:find("Targeting: ", 1, true) then after = after + 1 end end
			killStep()
			return after - before
		end,
		["qol.markTarget"] = function() return { macro(PolestarTargetButton), macro(PolestarStepButton) } end,
		["qol.pingTarget"] = function() return macro(PolestarTargetButton) end,
		["qol.markMob"] = { with = { ["qol.markTarget"] = true }, probe = function() return macro(PolestarTargetButton) end },
		["qol.markNpc"] = { with = { ["qol.markTarget"] = true }, probe = function()
			npcStep()
			stub.runTimers()
			local out = macro(PolestarStepButton)
			killStep()
			return out
		end },
		-- The step's giver targeted: the step key talks to it.
		["qol.stepInteract"] = function()
			q.step({ { t = "accept", quest = 7, npc = 197, npcName = "Marshal McBride" } })
			q.target = { name = "Marshal McBride", npc = 197 }
			stub.fire("PLAYER_TARGET_CHANGED")
			stub.runTimers()
			local key = q.overrides.F or "the step's own action"
			q.target = false
			stub.fire("PLAYER_TARGET_CHANGED")
			killStep()
			return key
		end,
		["Questing:Reset button positions"] = { press = true,
			prepare = function() QoL.State().buttonPos = { "CENTER", "CENTER", 0, 0 }; Polestar.Fire("SETTING_CHANGED", "buttons") end,
			probe = function() local p, _, rp, x, y = B.Holder():GetPoint(1); return { p, rp, x, y } end },
	},
}
