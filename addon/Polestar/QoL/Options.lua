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
	{ kind = "toggle", key = "qol.bagGlow", label = L["Highlight the step's item in your bags"],
		help = L["The item the current step uses, or a quest item it collects, glows in your bags (and in Baganator). An item a later step needs gets a lock, so you don't sell it."] },
	{ kind = "toggle", key = "qol.targetButton", label = L["Target button"],
		help = L["Targets the current step's mobs by name; each click moves to the next name. Bindable."] },
	{ kind = "toggle", key = "qol.rareButton", label = L["Rare button"],
		help = L["Shows a button that targets a rare Polestar spotted nearby, until it dies or is out of sight. Bindable."] },
	{ kind = "toggle", key = "qol.hearthButton", label = L["Hearthstone button"],
		help = L["Shows your Hearthstone while the guide says to hearth. Bindable."] },
	{ kind = "toggle", key = "qol.markTarget", label = L["Mark what they target"],
		help = L["The target button and the step key put a raid icon on the mob and the NPC they target; out of combat, a press that finds neither clears your target. Your party sees the icons; in a raid only the leader and assistants can set them."] },
	{ kind = "dropdown", key = "qol.markMob", label = L["Icon on mobs"], choices = markChoices, disabled = markOff,
		help = L["A new one each press skips the NPCs' icon and leaves a mob that has one as it is."] },
	{ kind = "dropdown", key = "qol.markNpc", label = L["Icon on NPCs"], choices = markChoices, disabled = markOff,
		help = L["A new one each press, so the last few NPCs keep theirs. Every press counts, even one that marks nothing."] },
	{ kind = "toggle", key = "qol.stepInteract", label = L["Step key talks and loots"],
		help = L["Once the step key has targeted the step's NPC, the next press talks to it; on the corpse of the step's mob, it loots; in the step's quest window, it accepts or completes. Only out of combat, and only on the step the guide is at."] },
	{ kind = "slider", key = "qol.buttonScale", label = L["Button size"], min = 0.6, max = 1.6, step = 0.05, format = function(v) return math.floor(v * 100 + 0.5) .. "%" end,
		help = L["Scale of the quest item, Hearthstone, target and rare buttons. Drag one to move them all."] },
	{ kind = "dropdown", key = "qol.buttonTextSide", label = L["Target name position"], help = L["Where the target's name shows around the target button: right, left, above or below."],
		choices = { { value = "right", label = L["Right"] }, { value = "left", label = L["Left"] }, { value = "above", label = L["Above"] }, { value = "below", label = L["Below"] } } },
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

register(QUESTING, L["Rewards & gear"], L["Loot and merchants"], {
	{ kind = "toggle", key = "qol.wearOffer", label = L["Offer gear upgrades"],
		help = L["When gear from a kill, a chest or a merchant is an upgrade for your spec (with Gear advice on), the guide window offers to put it on. Nothing goes on until you press Wear it; Not this one stops it asking about that item."] },
})

register(QUESTING, L["Quests"], L["Faster questing"], {
	{ kind = "toggle", key = "qol.instantQuestText", label = L["Instant quest text"],
		help = L["Shows quest text at once instead of fading it in (Forever's own option)."],
		disabled = function() return not (QoL.Toggles and QoL.Toggles.InstantTextSupported()) end },
	{ kind = "toggle", key = "qol.skipGossip", label = L["Skip single-option gossip"],
		help = help("skipGossip", L["Picks the only option of NPCs without quests. Hold Shift to read it."]) },
	{ kind = "toggle", key = "qol.stepGossip", label = L["Pick what the step asks for"],
		help = L["At the step's NPC, picks the chat option the guide names, or opens the goods or training the step needs. Only on the step the guide is at. Hold Shift to choose yourself."] },
	{ kind = "toggle", key = "qol.fastLoot", label = L["Faster auto-loot"],
		help = help("fastLoot", L["Takes the whole corpse at once when auto-loot is on."]) },
	{ kind = "toggle", key = "qol.hideErrors", label = L["Hide combat errors"],
		help = help("hideErrors", L["Hides \"Not enough rage\", \"Out of range\" and cooldown messages. Other errors still show."]) },
})

register(QUESTING, L["Quests"], L["Tooltips and quest log"], {
	{ kind = "toggle", key = "qol.hideQuestTracker", label = L["Hide the game's quest tracker"],
		help = L["Hides the game's tracker on the right of the screen, with its quests, achievements and professions, as Questie can. Not with the gamepad interface."] },
})

register(QOL, L["Travel"], L["Flight masters"], {
	{ kind = "toggle", key = "qol.flightAutoOpen", label = L["Open the flight map"],
		help = L["Talking to a flight master opens the map directly. Hold Shift for the gossip."] },
	{ kind = "toggle", key = "qol.flightHighlight", label = L["Mark the route's destination"],
		help = L["Marks where the travel route flies next on the flight map. You still choose the flight."] },
})

register(QOL, L["Travel"], L["Hearthstone"], {
	{ kind = "toggle", key = "qol.autoBind", label = L["Set your home at the guide's inn"],
		help = L["When the step sets your home and you talk to its innkeeper, binds your Hearthstone there. Never at another inn. Hold Shift to skip."] },
})

register(QOL, L["Travel"], L["Death"], {
	{ kind = "toggle", key = "qol.deathHelper", label = L["Corpse or Spirit Healer"],
		help = L["As a ghost, points the arrow at the faster way back: your corpse or the nearest Spirit Healer."] },
	{ kind = "toggle", key = "qol.breathWarning", label = L["Warn when out of breath"],
		help = L["Under water, a red edge round the screen, a sound and a taskbar flash with 10 seconds of breath left, and again at 4."] },
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
		help = help("sellJunk", L["Sells Poor-quality items, and anything you marked as junk, when a merchant opens and prints the total. Never an item marked to keep or one a later step needs."]) },
	{ kind = "toggle", key = "qol.autoRepair", label = L["Repair"],
		help = help("autoRepair", L["Repairs all gear at merchants who can, when you can afford it. Hold Shift to skip."]) },
	{ kind = "toggle", key = "qol.repairGuild", label = L["Guild bank first"], disabled = repairOff,
		help = help("repairGuild", L["When your guild rank may, the guild bank pays for repairs and your money covers the rest."]) },
	{ kind = "toggle", key = "qol.buyGoals", label = L["Buy for the guide"],
		help = L["When the step asks you to buy something and the merchant sells it, buys what you still need after selling and repairing. Optional buys and anything over 50g are left to you. Hold Shift to skip."] },
})

local function restockSlider(kind, label, step, help)
	local R = QoL.Restock
	return { kind = "slider", label = label, min = 0, max = R.LIMITS[kind], step = step,
		format = function(v) return v > 0 and tostring(math.floor(v + 0.5)) or L["Off"] end,
		get = function() return R.Get(kind) end, set = function(v) R.Set(kind, v) end,
		disabled = function() return not QoL.On("restock") end, help = help }
end

-- Only with QoL/Restock.lua loaded: its limits and amounts are its own.
if QoL.Restock then
	register(QOL, L["Vendors"], L["Restock"], {
		{ kind = "toggle", key = "qol.restock", label = L["Restock button"],
			help = L["At a merchant that sells what you are short of, a Restock button under its window buys up to the amounts below (this character's). Nothing is bought until you press it. Other items, such as reagents: /polestar restock <item> <amount>."] },
		restockSlider("drink", L["Drinks"], 5, L["Keeps this many drinks in your bags. The merchant's best one for your level is bought."]),
		restockSlider("food", L["Food"], 5, L["Keeps this much food in your bags. The merchant's best one for your level is bought."]),
		restockSlider("ammo", L["Ammunition"], 100, L["Keeps this many arrows or shot for the bow, crossbow or gun you wear."]),
	})
end

register(QOL, L["Vendors"], L["Bags"], {
	{ kind = "toggle", key = "qol.bagSpace", label = L["Bag space"],
		help = L["When your bags are nearly full, a button shows the free slots and the cheapest junk in them, and while the step collects something the guide window says so too. Press twice to delete that junk: grey items, or common ones you marked as junk. Bindable."] },
	{ kind = "slider", key = "qol.bagsLow", label = L["Nearly full at"], min = 0, max = 10, step = 1, disabled = function() return not QoL.On("bagSpace") end,
		format = function(v) return string.format(v == 1 and L["%d slot"] or L["%d slots"], math.floor(v + 0.5)) end,
		help = L["How many free slots or fewer count as nearly full."] },
	{ kind = "toggle", key = "qol.itemMarks", label = L["Junk and keep marks"],
		help = L["Ctrl+Alt-click an item in your bags to mark it as junk, again to keep it, and again to clear it. Junk is sold with the grey items; a kept item is never sold or deleted."] },
})

register(QOL, L["Vendors"], L["Trainers"], {
	{ kind = "toggle", key = "qol.trainAll", label = L["Learn new spells"],
		help = L["Learns every spell a class trainer offers that you can afford, and prints the total. Profession trainers are left alone. Hold Shift to skip."] },
	{ kind = "toggle", key = "qol.ridingReminder", label = L["Riding reminder"],
		help = L["At level 40 and 60, if you have not learned riding yet, says the cost in chat (with any Honored discount) and points the arrow at your race's riding trainer when you can afford it. Warlocks and Alliance Paladins are sent to their free-mount quest NPC instead. Once per tier per character."] },
})

register(QOL, L["Trackers"], L["Experience"], {
	{ kind = "toggle", key = "qol.xpTracker", label = L["XP tracker"],
		help = L["XP per hour, time, kills and quests to level, and level splits (/pole xp)."] },
	{ kind = "toggle", key = "qol.xpTargetMark", label = L["Guide level on the XP bar"],
		help = L["A mark at the end of the game's XP bar with the level the guide wants you to reach before it moves on, and how many levels away that is when it is more than one."] },
	{ kind = "button", label = L["Reset session"], help = L["Start this session's XP per hour from zero."],
		onClick = function() if QoL.XP then QoL.XP.ResetSession() end end },
})
