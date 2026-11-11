-- The Quality of Life settings (docs/ARCHITECTURE.md, "Options registry"):
-- the questing helpers on the Questing page, the rest on Quality of Life, and
-- the conveniences among the questing helpers on both (C below). Both pages
-- and their tabs and sections are declared in UI/Options.lua.

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
local function targetOff() return not QoL.On("targetButton") end
local function flightMarkOff() return not QoL.On("flightHighlight") end

-- The eight raid icons, by the client's names, then a new one each press.
local function markChoices()
	local list = {}
	for i = 1, 8 do
		list[i] = { value = tostring(i), label = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_" .. i .. ":0|t " .. (_G["RAID_TARGET_" .. i] or i) }
	end
	list[9] = { value = "cycle", label = L["A new one each press"] }
	return list
end

-- Controls shown on two pages: on their home page and on Quality of Life,
-- where players look for conveniences (Fitz, 2026-11-05). One setting, two
-- places: both read and write the same key. Each call makes fresh tables, as
-- the registry keeps per-control state (rows, caches).
local C = {}
function C.autoAccept()
	return { kind = "toggle", key = "behavior.autoAccept", label = L["Accept guide quests"], help = L["Only quests in the next steps of your open guides. Hold Shift to skip."],
		search = "auto accept, auto quest, accept quests automatically, autoaccept, pick up quests" }
end
function C.autoTurnin()
	return { kind = "toggle", key = "behavior.autoTurnin", label = L["Turn in guide quests"], help = L["Never picks between rewards. Hold Shift to skip."],
		search = "auto turn in, auto complete, hand in quests automatically, turnin, autoturnin, complete quests" }
end
function C.instantQuestText()
	return { kind = "toggle", key = "qol.instantQuestText", label = L["Instant quest text"],
		help = L["Shows quest text at once instead of fading it in (Forever's own option)."], search = "quest text speed, fast text, scroll, fade, dialog",
		disabled = function() return not (QoL.Toggles and QoL.Toggles.InstantTextSupported()) end }
end
function C.skipGossip()
	return { kind = "toggle", key = "qol.skipGossip", label = L["Skip single-option gossip"],
		help = help("skipGossip", L["Picks the only option of NPCs without quests. Hold Shift to read it. Off, the game still skips some itself, Pick what the step asks for still picks the step's option, and flight masters follow Open the flight map."]),
		search = "gossip, dialog, dialogue, chat options, skip talk, npc talk, auto gossip" }
end
function C.fastLoot()
	return { kind = "toggle", key = "qol.fastLoot", label = L["Faster auto-loot"],
		help = help("fastLoot", L["Takes the whole corpse at once when auto-loot is on."]), search = "autoloot, fast loot, quick loot, instant loot, looting" }
end
function C.hideErrors()
	return { kind = "toggle", key = "qol.hideErrors", label = L["Hide combat errors"],
		help = help("hideErrors", L["Hides \"Not enough rage\", \"Out of range\" and cooldown messages. Other errors still show."]),
		search = "error messages, red text, ui errors, spam, mana, energy, rage, range" }
end
function C.rewardAutoPick()
	return { kind = "toggle", key = "qol.rewardAutoPick", label = L["Take the best reward"],
		help = L["Chooses that reward for you when you complete the quest. Hold Shift to choose yourself."], search = "auto pick reward, choose reward, quest reward, best item" }
end
function C.rewardEquip()
	return { kind = "toggle", key = "qol.rewardEquip", label = L["Wear reward upgrades"],
		help = L["Puts on what a turn-in gives when it is an upgrade for your spec (with Gear advice on), once it reaches your bags and you are out of combat. Hold Shift at the turn-in to skip."],
		search = "auto equip, equip upgrades, wear gear, put on" }
end
function C.hideQuestTracker()
	return { kind = "toggle", key = "qol.hideQuestTracker", label = L["Hide the game's quest tracker"],
		help = L["Hides the game's tracker on the right of the screen, with its quests, achievements and professions, as Questie can. Not with the gamepad interface."],
		search = "tracker, objectives, objective tracker, quest watch, watch frame" }
end
function C.itemButton()
	return { kind = "toggle", key = "qol.itemButton", label = L["Quest item button"],
		help = L["A button for the current step's quest item, with count, cooldown and range. Bind it under Key Bindings > AddOns."],
		search = "use item, quest item, keybind, hotkey, item bar" }
end
local function itemButtonOff() return not QoL.On("itemButton") end
function C.questLoot()
	return { kind = "toggle", key = "qol.questLoot", label = L["Show quest-starting loot"], disabled = itemButtonOff, child = true,
		help = L["When you loot an item that starts a quest you can take, it goes on the quest item button with a glow until you click it or take the quest. The step's own item comes first; several wait their turn, oldest first."],
		search = "quest starter, starts a quest, loot, quest item, glow" }
end
function C.instanceTrack()
	return { kind = "toggle", key = "qol.instanceTrack", label = L["Track only dungeon quests in dungeons"],
		help = L["Inside a dungeon or raid, the game's quest tracker and Polestar's quest markers show only that instance's quests. The quests you were tracking come back when you leave, even after a reload inside."],
		search = "dungeon, instance, tracker, objectives, quest watch, raid" }
end
function C.stepInteract()
	return { kind = "toggle", key = "qol.stepInteract", label = L["Step key talks and loots"],
		help = L["Once the step key has targeted the step's NPC, the next press talks to it; on the corpse of the step's mob, it loots; in the step's quest window, it accepts or completes. Only out of combat, and only on the step the guide is at."],
		search = "interact, interact key, talk, loot, one button, keybind, hotkey" }
end
function C.hearthButton()
	return { kind = "toggle", key = "qol.hearthButton", label = L["Hearthstone button"],
		help = L["Shows your Hearthstone while the guide says to hearth. Bindable."], search = "hearth, hearthstone, keybind, hotkey" }
end

register(QUESTING, L["Buttons"], L["Action buttons"], {
	C.itemButton(),
	C.questLoot(),
	{ kind = "toggle", key = "qol.bagGlow", label = L["Highlight the step's item in your bags"],
		help = L["The item the current step uses, or a quest item it collects, glows in your bags (and in Baganator). An item a later step needs gets a lock, so you don't sell it."],
		search = "bags, glow, quest item, inventory" },
	{ kind = "toggle", key = "qol.targetButton", label = L["Target button"],
		help = L["Targets the current step's mobs by name, or the NPCs it sends you to when it has no mob; each click moves to the next name. Bindable."], search = "target macro, find mob, keybind, hotkey" },
	{ kind = "toggle", key = "qol.targetPlate", label = L["Show who it targets"], disabled = targetOff, child = true,
		help = L["The target button's icon shows what you do next: talk, accept, turn in, kill or loot, a skull for an elite, rare or boss, or their face once you have seen them. Their name sits beside it, green for a friendly NPC, red for a mob, gold for an elite or rare, with small icons for the names after it."],
		search = "target icon, target name, portrait, npc name, elite, boss" },
	{ kind = "toggle", key = "qol.targetAnnounce", label = L["Name new targets in chat"], disabled = targetOff, child = true,
		help = L["When the target button's names change, one line in chat lists them (\"Targeting: ...\"). Only you see it."],
		search = "target chat, announce target, targeting" },
	{ kind = "toggle", key = "qol.guideNameTarget", label = L["Click objectives to target"],
		help = L["Clicking an objective row or NPC heading also targets its NPC outside combat, using the same marking settings as the Target button. This replaces your current target; a failed search clears it."] },
	{ kind = "toggle", key = "qol.rareButton", label = L["Rare button"],
		help = L["Shows a button that targets a rare Polestar spotted nearby, until it dies or is out of sight. Bindable."], search = "rare elite, target rare, keybind" },
	C.hearthButton(),
	{ kind = "toggle", key = "qol.markTarget", label = L["Mark what they target"],
		help = L["The target button and the step key put a raid icon on the mob and the NPC they target; out of combat, a press that finds neither clears your target. Pressing again never takes an icon off. In a party you don't lead, only a unit with no icon gets one; in a raid, only when you lead or assist."],
		search = "raid marker, raid icon, skull, star, mark target" },
	{ kind = "toggle", key = "qol.pingTarget", label = L["Ping what they target"],
		help = L["The target button and the step key ping the mob they target, so your group sees it behind rocks and buildings. Never in a raid unless you lead or assist. The rare buttons always ping."],
		search = "ping, ping target, group ping" },
	{ kind = "dropdown", key = "qol.markMob", label = L["Icon on mobs"], choices = markChoices, disabled = markOff,
		help = L["A new one each press skips the NPCs' icon and leaves a mob that has one as it is."], search = "raid marker, raid icon, skull" },
	{ kind = "dropdown", key = "qol.markNpc", label = L["Icon on NPCs"], choices = markChoices, disabled = markOff,
		help = L["A new one each press, so the last few NPCs keep theirs. Every press counts, even one that marks nothing."], search = "raid marker, raid icon, star" },
	C.stepInteract(),
	-- How they look (size, layout, text, opacity...) is the Buttons page's (QoL/ButtonsOptions.lua).
	{ kind = "button", icon = "palette", button = L["Open"], label = L["Button look"], new = "0.3.8",
		help = L["Size, spacing, layout, backing, text, opacity and glow of these buttons, with a live preview, on the Buttons page."],
		search = "button size, scale, bigger, smaller, look, style, opacity, layout, name position",
		onClick = function() ns.UI.ShowOptions("buttons") end },
	{ kind = "button", icon = "reset", button = L["Reset"], label = L["Reset button positions"], help = L["Put the buttons back in their default spot."],
		search = "move buttons, button position", onClick = function() if QoL.Buttons then QoL.Buttons.ResetPositions() end end },
})

register(QUESTING, L["Rewards & gear"], L["Quest rewards"], {
	{ kind = "toggle", key = "qol.rewardHighlight", label = L["Mark quest rewards"],
		help = L["On the reward choices, a green arrow marks each upgrade for your spec (with Gear advice on), a thin frame in your accent colour the one to take, and a coin the one that sells for most."],
		search = "highlight reward, best reward, vendor price, upgrade" },
	C.rewardAutoPick(),
	C.rewardEquip(),
})

register(QUESTING, L["Rewards & gear"], L["Loot and merchants"], {
	{ kind = "toggle", key = "qol.wearOffer", label = L["Offer gear upgrades"],
		help = L["When gear from a kill, a chest or a merchant is an upgrade for your spec (with Gear advice on), the guide window offers to put it on. Nothing goes on until you press Wear it; Not this one stops it asking about that item."],
		search = "equip upgrades, loot upgrade, wear gear" },
})

register(QUESTING, L["Quests"], L["Faster questing"], {
	-- Accepting and turning in the guide's quests (behavior.*, Core/Engine.lua): here with the other questing helpers.
	C.autoAccept(),
	C.autoTurnin(),
	C.instantQuestText(),
	C.skipGossip(),
	{ kind = "toggle", key = "qol.stepGossip", label = L["Pick what the step asks for"],
		help = L["At the step's NPC, picks the chat option the guide names, or opens the goods or training the step needs. Only on the step the guide is at. Hold Shift to choose yourself."],
		search = "gossip, dialog, chat option, auto talk" },
	C.fastLoot(),
	C.hideErrors(),
})

register(QUESTING, L["Quests"], L["Tooltips and quest log"], {
	C.hideQuestTracker(),
	C.instanceTrack(),
	{ kind = "button", button = L["Show"], label = L["Clean up quest log"],
		help = L["Lists the quests in your log the route doesn't need: those it never hands in, and grey ones that give no XP any more. Each has an Abandon button that asks first. The guide window's menu has it too while there are any."],
		onClick = function() ns.Fire("SHOW_QUEST_ROOM") end },
})

register(QOL, L["Quests"], L["Faster questing"], { C.autoAccept(), C.autoTurnin(), C.instantQuestText(), C.skipGossip(), C.fastLoot(), C.hideErrors() })
register(QOL, L["Quests"], L["Quest rewards"], { C.rewardAutoPick(), C.rewardEquip() })
register(QOL, L["Quests"], L["Action buttons"], { C.itemButton(), C.questLoot(), C.stepInteract() })
register(QOL, L["Quests"], L["Tooltips and quest log"], { C.hideQuestTracker(), C.instanceTrack() })

register(QOL, L["Travel"], L["Flight masters"], {
	{ kind = "toggle", key = "qol.flightAutoOpen", label = L["Open the flight map"],
		help = L["Talking to a flight master opens the map directly. Hold Shift for the gossip."], search = "flight, taxi, flight path, gryphon, wind rider, fly" },
	{ kind = "toggle", key = "qol.flightHighlight", label = L["Mark the route's destination"],
		help = L["Marks where the travel route flies next on the flight map. You still choose the flight."], search = "flight, taxi, flight path, highlight destination" },
	{ kind = "toggle", key = "qol.flightAutoTake", label = L["Take the marked flight"], disabled = flightMarkOff, child = true,
		help = L["When the flight map opens, flies to the marked destination. Hold Shift at the flight master to choose yourself."], search = "flight, taxi, flight path, auto fly, take flight" },
})

register(QOL, L["Travel"], L["Hearthstone"], {
	{ kind = "toggle", key = "qol.autoBind", label = L["Set your home at the guide's inn"],
		help = L["When the step sets your home and you talk to its innkeeper, binds your Hearthstone there. Never at another inn. Hold Shift to skip."],
		search = "hearth, hearthstone, bind, inn, innkeeper, home" },
	C.hearthButton(),
})

register(QOL, L["Travel"], L["Death"], {
	{ kind = "toggle", key = "qol.deathHelper", label = L["Corpse or Spirit Healer"],
		help = L["As a ghost, points the arrow at the faster way back: your corpse or the nearest Spirit Healer."], search = "death, die, dead, ghost, corpse run, graveyard, spirit healer" },
	{ kind = "toggle", key = "qol.breathWarning", label = L["Warn when out of breath"],
		help = L["Under water, a red edge round the screen, a sound and a taskbar flash with 10 seconds of breath left, and again at 4."], search = "breath, drowning, underwater, swim" },
	{ kind = "toggle", key = "qol.autoReleasePvP", label = L["Release in battlegrounds"],
		help = L["Releases your spirit at once when you die in a battleground, unless you can resurrect yourself or someone offers to. Hold Shift to stay."], search = "auto release, pvp, battleground, bg, release spirit" },
})

register(QOL, L["Social"], L["Requests"], {
	{ kind = "toggle", key = "qol.acceptSummon", label = L["Accept summons"],
		help = L["Takes a summon at once, unless you are in combat. Hold Shift to decide yourself."], search = "summon, auto accept summon, warlock, meeting stone" },
	{ kind = "toggle", key = "qol.acceptResurrect", label = L["Accept resurrections"],
		help = L["Takes a resurrection as soon as it can, unless the caster is in combat. Never in Hardcore. Hold Shift to decide yourself."], search = "rez, res, resurrect, revive, auto accept" },
	{ kind = "toggle", key = "qol.acceptPartyFriends", label = L["Join friends' parties"],
		help = help("acceptPartyFriends", L["Accepts party invitations from friends, Battle.net friends and your guild, unless joining would leave a queue. Hold Shift to decide yourself."]),
		search = "invite, group, party, auto join, auto accept invite" },
})

register(QOL, L["Social"], L["Blocking"], {
	{ kind = "toggle", key = "qol.declinePartyStrangers", label = L["Decline other party invitations"],
		help = L["Declines party invitations from anyone who is not a friend or in your guild."], search = "invite, group, party, block, spam, auto decline" },
	{ kind = "toggle", key = "qol.declineGuildInvites", label = L["Decline guild invitations"],
		help = L["Declines guild invitations, except from friends."], search = "guild invite, block, spam, auto decline" },
	{ kind = "toggle", key = "qol.declineDuels", label = L["Decline duels"],
		help = L["Declines duel requests, except from friends and your guild."], search = "duel, block, spam, auto decline" },
})

register(QOL, L["Vendors"], L["Merchants"], {
	{ kind = "toggle", key = "qol.sellJunk", label = L["Sell grey items"],
		help = help("sellJunk", L["Sells Poor-quality items, and anything you marked as junk, when a merchant opens and prints the total. Never an item marked to keep or one a later step needs."]),
		search = "bags, junk, sell grey, sell junk, autosell, vendor trash, poor items, vendor" },
	{ kind = "toggle", key = "qol.autoRepair", label = L["Repair"],
		help = help("autoRepair", L["Repairs all gear at merchants who can, when you can afford it. Hold Shift to skip."]),
		search = "repair, auto repair, autorepair, durability, broken gear, vendor" },
	{ kind = "toggle", key = "qol.repairGuild", label = L["Guild bank first"], disabled = repairOff, child = true,
		help = help("repairGuild", L["When your guild rank may, the guild bank pays for repairs and your money covers the rest."]), search = "guild repair, repair" },
	{ kind = "toggle", key = "qol.buyGoals", label = L["Buy for the guide"],
		help = L["When the step asks you to buy something and the merchant sells it, buys what you still need after selling and repairing. Optional buys and anything over 50g are left to you. Hold Shift to skip."],
		search = "auto buy, purchase, shopping, vendor" },
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
			help = L["At a merchant that sells what you are short of, a Restock button under its window buys up to the amounts below (this character's). Nothing is bought until you press it. Other items, such as reagents: /polestar restock <item> <amount>."],
			search = "restock, food, water, drink, ammo, arrows, bullets, reagents, auto buy, vendor" },
		restockSlider("drink", L["Drinks"], 5, L["Keeps this many drinks in your bags. The merchant's best one for your level is bought."]),
		restockSlider("food", L["Food"], 5, L["Keeps this much food in your bags. The merchant's best one for your level is bought."]),
		restockSlider("ammo", L["Ammunition"], 100, L["Keeps this many arrows or shot for the bow, crossbow or gun you wear."]),
	})
end

register(QOL, L["Vendors"], L["Bags"], {
	{ kind = "toggle", key = "qol.bagSpace", label = L["Bag space"],
		help = L["When your bags are nearly full, a button shows the free slots and the cheapest junk in them, and while the step collects something the guide window says so too. Press twice to delete that junk: grey items, or common ones you marked as junk. Bindable."],
		search = "bags, full bags, free slots, inventory, delete junk, destroy" },
	{ kind = "slider", key = "qol.bagsLow", label = L["Nearly full at"], min = 0, max = 10, step = 1, disabled = function() return not QoL.On("bagSpace") end,
		format = function(v) return string.format(v == 1 and L["%d slot"] or L["%d slots"], math.floor(v + 0.5)) end,
		help = L["How many free slots or fewer count as nearly full."] },
	{ kind = "toggle", key = "qol.itemMarks", label = L["Junk and keep marks"],
		help = L["Ctrl+Alt-click an item in your bags to mark it as junk, again to keep it, and again to clear it. Junk is sold with the grey items; a kept item is never sold or deleted."],
		search = "bags, junk, mark junk, keep item, protect item, sell list" },
})

register(QOL, L["Vendors"], L["Trainers"], {
	{ kind = "toggle", key = "qol.trainAllButton", label = L["Train all button"],
		help = L["Adds a Train All button to the trainer window to learn all available skills."],
		search = "train all, trainer, button, learn all, skills" },
	{ kind = "toggle", key = "qol.trainAll", label = L["Auto-learn new spells"],
		help = L["Automatically learns every spell a class trainer offers that you can afford, and prints the total. Profession trainers are left alone. Hold Shift to skip."],
		search = "train, trainer, auto train, auto learn, learn spells, skills, abilities, ranks" },
	{ kind = "toggle", key = "qol.ridingReminder", label = L["Riding reminder"],
		help = L["At level 40 and 60, if you have not learned riding yet, says the cost in chat (with any Honored discount) and points the arrow at your race's riding trainer when you can afford it. Warlocks and Alliance Paladins are sent to their free-mount quest NPC instead. Once per tier per character."],
		search = "mount, riding, horse, epic mount, level 40, level 60" },
	{ kind = "toggle", key = "qol.levelUpSpells", label = L["New spells at level-up"],
		help = L["When you level up, a card on the guide window shows the class spells you can now train, what they cost together and the nearest class trainer, with a button for the arrow. Not in combat or instances, and not on levels with nothing new."],
		search = "level up, ding, new spells, trainer, train, ranks, abilities, cost" },
	{ kind = "toggle", key = "qol.oldRanks", label = L["Old ranks on your bars"],
		help = L["After training and at login, says which spells on your action bars are a lower rank than the one in your spellbook, with a button that puts the highest rank in the same buttons (out of combat). Macros and items are never touched. Right-click a spell on the card to keep it at its rank; a lower rank you put on a bar yourself is kept too."],
		search = "rank, old rank, downrank, action bar, upgrade spells, highest rank, buttons" },
	{ kind = "button", icon = "reset", button = L["Forget"], label = L["Forget kept ranks"],
		help = L["Lists the spells you kept at a lower rank again."], search = "rank, downrank, keep rank, action bar",
		disabled = function() return not QoL.On("oldRanks") end,
		onClick = function() if QoL.Spells then QoL.Spells.ForgetKept(); QoL.Spells.CheckRanks(true) end end },
})

register(QOL, L["Trackers"], L["Experience"], {
	{ kind = "toggle", key = "qol.xpTracker", label = L["XP tracker"],
		help = L["XP per hour, time, kills and quests to level, and level splits (/pole xp)."], search = "experience, xp per hour, exp, leveling speed, time to level" },
	{ kind = "toggle", key = "qol.xpTargetMark", label = L["Guide level on the XP bar"],
		help = L["A mark at the end of the game's XP bar with the level the guide wants you to reach before it moves on, and how many levels away that is when it is more than one."],
		search = "experience bar, exp bar, target level" },
	{ kind = "toggle", key = "qol.boostedRest", label = L["Boosted Rest status"],
		help = L["How long the campfire's Boosted Rest lasts and the Cozy Sleeping Bag's cooldown, under the guide window's XP line; your party's Boosted Rest in the party panel."],
		search = "boosted rest, campfire, sit, rested, sleeping bag, camp, cozy sleeping bag" },
	{ kind = "button", icon = "reset", button = L["Reset"], label = L["Reset session"], help = L["Start this session's XP per hour from zero."], search = "xp, experience",
		onClick = function() if QoL.XP then QoL.XP.ResetSession() end end },
})
