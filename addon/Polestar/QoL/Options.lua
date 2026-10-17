-- The Quality of Life settings (docs/ARCHITECTURE.md, "Options registry"):
-- the questing helpers on the Questing page, the rest on Quality of Life.
-- Both pages and their tabs and sections are declared in UI/Options.lua.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL

if not ns.RegisterOptions then return end

local QUESTING, QOL = L["Questing"], L["Quality of Life"]

local function register(page, tab, section, controls)
	local ok, err = ns.RegisterOptions({ page = page, tab = tab, section = section, controls = controls })
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

-- Help for a toggle EllesmereUI may cover: says why it starts off.
local function help(key, text)
	local by = QoL.CoveredBy(key)
	if not by then return text end
	return text .. " " .. string.format(L["Off by default: %s does this too."], (by:gsub("^EllesmereUI", "EllesmereUI ")))
end

local function repairOff() return not QoL.On("autoRepair") end
local function markOff() return not QoL.On("markTarget") end

-- The eight raid icons, by the client's names, then a new one each press.
local function markChoices()
	local list = {}
	for i = 1, 8 do
		list[i] = { value = tostring(i), label = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_" .. i .. ":0|t " .. (_G["RAID_TARGET_" .. i] or i) }
	end
	list[9] = { value = "cycle", label = L["A new one each press"] }
	return list
end

register(QUESTING, L["Buttons"], L["Action buttons"], {
	{ kind = "toggle", key = "qol.itemButton", label = L["Quest item button"],
		help = L["A button for the current step's quest item, with count, cooldown and range. Bind it under Key Bindings > AddOns."] },
	{ kind = "toggle", key = "qol.targetButton", label = L["Target button"],
		help = L["Targets the current step's mobs by name; each click moves to the next name. Bindable."] },
	{ kind = "toggle", key = "qol.hearthButton", label = L["Hearthstone button"],
		help = L["Shows your Hearthstone while the guide says to hearth. Bindable."] },
	{ kind = "toggle", key = "qol.markTarget", label = L["Mark what they target"],
		help = L["The target button and the step key put a raid icon on the mob and the NPC they target; out of combat, a press that finds neither clears your target. Your party sees the icons; in a raid only the leader and assistants can set them."] },
	{ kind = "dropdown", key = "qol.markMob", label = L["Icon on mobs"], choices = markChoices, disabled = markOff,
		help = L["A new one each press skips the NPCs' icon and leaves a mob that has one as it is."] },
	{ kind = "dropdown", key = "qol.markNpc", label = L["Icon on NPCs"], choices = markChoices, disabled = markOff,
		help = L["A new one each press, so the last few NPCs keep theirs. Every press counts, even one that marks nothing."] },
	{ kind = "slider", key = "qol.buttonScale", label = L["Button size"], min = 0.6, max = 1.6, step = 0.05, format = function(v) return math.floor(v * 100 + 0.5) .. "%" end,
		help = L["Scale of the quest item, Hearthstone and target buttons. Drag one to move them all."] },
	{ kind = "button", label = L["Reset button positions"], help = L["Put the buttons back in their default spot."],
		onClick = function() if QoL.Buttons then QoL.Buttons.ResetPositions() end end },
})

register(QUESTING, L["Rewards & gear"], L["Quest rewards"], {
	{ kind = "toggle", key = "qol.rewardHighlight", label = L["Mark quest rewards"],
		help = L["On the reward choices, a green arrow marks each upgrade for your spec (with Gear advice on), a thin frame in your accent colour the one to take, and a coin the one that sells for most."] },
	{ kind = "toggle", key = "qol.rewardAutoPick", label = L["Take the best reward"],
		help = L["Chooses that reward for you when you complete the quest. Hold Shift to choose yourself."] },
	{ kind = "toggle", key = "qol.rewardEquip", label = L["Wear reward upgrades"],
		help = L["Puts on what a turn-in gives when it is an upgrade for your spec (with Gear advice on), once it reaches your bags and you are out of combat. Hold Shift at the turn-in to skip."] },
})

register(QUESTING, L["Quests"], L["Faster questing"], {
	{ kind = "toggle", key = "qol.instantQuestText", label = L["Instant quest text"],
		help = L["Shows quest text at once instead of fading it in (Forever's own option)."],
		disabled = function() return not (QoL.Toggles and QoL.Toggles.InstantTextSupported()) end },
	{ kind = "toggle", key = "qol.skipGossip", label = L["Skip single-option gossip"],
		help = help("skipGossip", L["Picks the only option of NPCs without quests. Hold Shift to read it."]) },
	{ kind = "toggle", key = "qol.fastLoot", label = L["Faster auto-loot"],
		help = help("fastLoot", L["Takes the whole corpse at once when auto-loot is on."]) },
	{ kind = "toggle", key = "qol.hideErrors", label = L["Hide combat errors"],
		help = help("hideErrors", L["Hides \"Not enough rage\", \"Out of range\" and cooldown messages. Other errors still show."]) },
})

register(QOL, L["Travel"], L["Flight masters"], {
	{ kind = "toggle", key = "qol.flightAutoOpen", label = L["Open the flight map"],
		help = L["Talking to a flight master opens the map directly. Hold Shift for the gossip."] },
	{ kind = "toggle", key = "qol.flightHighlight", label = L["Mark the route's destination"],
		help = L["Marks where the travel route flies next on the flight map. You still choose the flight."] },
})

register(QOL, L["Travel"], L["Death"], {
	{ kind = "toggle", key = "qol.deathHelper", label = L["Corpse or Spirit Healer"],
		help = L["As a ghost, points the arrow at the faster way back: your corpse or the nearest Spirit Healer."] },
	{ kind = "toggle", key = "qol.autoReleasePvP", label = L["Release in battlegrounds"],
		help = L["Releases your spirit at once when you die in a battleground, unless you can resurrect yourself or someone offers to. Hold Shift to stay."] },
})

register(QOL, L["Social"], L["Requests"], {
	{ kind = "toggle", key = "qol.acceptSummon", label = L["Accept summons"],
		help = L["Takes a summon at once, unless you are in combat. Hold Shift to decide yourself."] },
	{ kind = "toggle", key = "qol.acceptResurrect", label = L["Accept resurrections"],
		help = L["Takes a resurrection as soon as it can, unless the caster is in combat. Never in Hardcore. Hold Shift to decide yourself."] },
	{ kind = "toggle", key = "qol.acceptPartyFriends", label = L["Join friends' parties"],
		help = help("acceptPartyFriends", L["Accepts party invitations from friends, Battle.net friends and your guild, unless joining would leave a queue. Hold Shift to decide yourself."]) },
})

register(QOL, L["Social"], L["Blocking"], {
	{ kind = "toggle", key = "qol.declinePartyStrangers", label = L["Decline other party invitations"],
		help = L["Declines party invitations from anyone who is not a friend or in your guild."] },
	{ kind = "toggle", key = "qol.declineGuildInvites", label = L["Decline guild invitations"],
		help = L["Declines guild invitations, except from friends."] },
	{ kind = "toggle", key = "qol.declineDuels", label = L["Decline duels"],
		help = L["Declines duel requests, except from friends and your guild."] },
})

register(QOL, L["Vendors"], L["Merchants"], {
	{ kind = "toggle", key = "qol.sellJunk", label = L["Sell grey items"],
		help = help("sellJunk", L["Sells Poor-quality items when a merchant opens and prints the total. Never sells anything else."]) },
	{ kind = "toggle", key = "qol.autoRepair", label = L["Repair"],
		help = help("autoRepair", L["Repairs all gear at merchants who can, when you can afford it. Hold Shift to skip."]) },
	{ kind = "toggle", key = "qol.repairGuild", label = L["Guild bank first"], disabled = repairOff,
		help = help("repairGuild", L["When your guild rank may, the guild bank pays for repairs and your money covers the rest."]) },
	{ kind = "toggle", key = "qol.buyGoals", label = L["Buy for the guide"],
		help = L["When the step asks you to buy something and the merchant sells it, buys what you still need after selling and repairing. Optional buys and anything over 50g are left to you. Hold Shift to skip."] },
})

register(QOL, L["Vendors"], L["Trainers"], {
	{ kind = "toggle", key = "qol.trainAll", label = L["Learn new spells"],
		help = L["Learns every spell a class trainer offers that you can afford, and prints the total. Profession trainers are left alone. Hold Shift to skip."] },
})

register(QOL, L["Trackers"], L["Experience"], {
	{ kind = "toggle", key = "qol.xpTracker", label = L["XP tracker"],
		help = L["XP per hour, time, kills and quests to level, and level splits (/pole xp)."] },
	{ kind = "button", label = L["Reset session"], help = L["Start this session's XP per hour from zero."],
		onClick = function() if QoL.XP then QoL.XP.ResetSession() end end },
})
