-- Chinese (simplified) (zhCN): the guide forever/class/mage/teleports-alliance (forever/class/mage/teleports-alliance.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Teleports and Portals (Alliance)"] = "传送术与传送门（联盟）",
	["Your city teleports at 20 and 30 and the group portals at 40 and 50, from each city's portal trainer."] = "20级和30级学习主城传送术，40级和50级学习小队传送门，均可在各主城的传送门训练师处学习。",

	-- Step 1: Teleport: Stormwind
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:2485} Larimaine Purdue · {spell:3561} Teleport: Stormwind · {item:17031} Rune of Teleportation · {npc:1308} Owen Vaughn
	["At 20 go to the Wizard's Sanctum, the violet tower of {zone:1453}'s {object:2101}. {npc:2485}, the portal trainer, stands at the very top: climb the spiral ramp and take the portal near the top. She teaches {spell:3561} for 20 silver. Every teleport burns one {item:17031} (10 silver at any reagent vendor; {npc:1308} sells them at the foot of the tower), so carry a few."] = "20 级时前往{zone:1453}的{object:2101}紫色高塔巫师圣殿。传送门训练师{npc:2485}位于最顶层，沿螺旋坡道上行，通过接近顶部的传送门即可。花费 20 银学习{spell:3561}。每次传送消耗一个{item:17031}，任意施法材料商人以 10 银出售，塔底的{npc:1308}也卖，记得随身备几个。",
	-- {item:17031} Rune of Teleportation
	["{item:17031}, 10s each"] = "{item:17031}，每个 10 银",

	-- Step 2: Teleport: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:2489} Milstaff Stormeye · {object:32362} Mystic Ward · {spell:3562} Teleport: Ironforge
	["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455}. {npc:2489}, the portal trainer, stands with the mage trainers in the {object:32362} at the back of the city: {spell:3562}, 20 silver."] = "从{zone:1453}的{object:28027}乘{area:2257}前往{zone:1455}。传送门训练师{npc:2489}与法师训练师一同站在城内深处的{object:32362}，花费 20 银学习{spell:3562}。",

	-- Step 3: Teleport: Darnassus
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1439} Darkshore · {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:4165} Elissa Dumas · {spell:3565} Teleport: Darnassus
	["At 30. Take the boat from {area:17203} to {area:442} in {zone:1439}, then the boat to {area:702} and the pink portal up into {zone:1457}. {npc:4165}, the portal trainer, teaches {spell:3565} for 80 silver."] = "30 级时，从{area:17203}乘船前往{zone:1439}的{area:442}，再乘船去{area:702}，通过粉色传送门到达上方的{zone:1457}。向传送门训练师{npc:4165}花费 80 银学习{spell:3565}。",

	-- Step 4: Portals to Stormwind and Ironforge
	-- {zone:1453} Stormwind · {zone:1455} Ironforge
	["Portals to {zone:1453} and {zone:1455}"] = "前往{zone:1453}和{zone:1455}的传送门",
	-- {item:17032} Rune of Portals · {npc:2485} Larimaine Purdue · {spell:10059} Portal: Stormwind · {npc:2489} Milstaff Stormeye · {zone:1455} Ironforge · {object:32362} Mystic Ward · {spell:11416} Portal: Ironforge
	["At 40 the portal trainers teach the portals: a gateway your whole group can step through, for 1 gold 50 silver each. Each portal burns one {item:17032} (20 silver at any reagent vendor). {npc:2485} has {spell:10059} at the top of the Wizard's Sanctum; then the tram to {npc:2489} in {zone:1455}'s {object:32362} for {spell:11416}."] = "40 级时，可向训练师学习供全队穿过的传送门，每项技能 1 金 50 银。每次施放消耗一个{item:17032}，任意施法材料商人以 20 银出售。先到巫师圣殿顶部找{npc:2485}学习{spell:10059}，再乘地铁到{zone:1455}的{object:32362}，向{npc:2489}学习{spell:11416}。",
	-- {item:17032} Rune of Portals
	["{item:17032}, 20s each"] = "{item:17032}，每个 20 银",

	-- Step 5: Portal: Darnassus
	-- {npc:4165} Elissa Dumas · {zone:1457} Darnassus · {spell:11419} Portal: Darnassus · {spell:3565} Teleport: Darnassus
	["At 50 {npc:4165} in {zone:1457} teaches the last one, {spell:11419}, for 3 gold 20 silver. Use your {spell:3565} to get there."] = "50 级时，{zone:1457}的{npc:4165}教授最后一项{spell:11419}，费用 3 金 20 银。使用{spell:3565}即可前往。",
}
