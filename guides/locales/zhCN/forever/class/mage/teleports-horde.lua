-- Chinese (simplified) (zhCN): the guide forever/class/mage/teleports-horde (forever/class/mage/teleports-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Teleports and Portals (Horde)"] = "传送与传送门（部落）",
	["Your city teleports at 20 and 30 and the group portals at 40 and 50, from each city's portal trainer."] = "20级和30级学习主城传送，40级和50级学习小队传送门，均由各主城的传送门训练师教授。",

	-- Step 1: Teleport: Orgrimmar
	-- {object:173161} Darkbriar Lodge (no name in this language: may be words) · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits · {npc:5958} Thuul · {spell:3567} Teleport: Orgrimmar · {item:17031} Rune of Teleportation
	["At 20 go to {object:173161} in {zone:1454}'s {object:172961}, where the mage trainers live. {npc:5958}, the portal trainer, stands on the upper floor and teaches {spell:3567} for 20 silver. Every teleport burns one {item:17031} (10 silver at any reagent vendor), so carry a few."] = "20 级时，前往{zone:1454}的{object:172961}，进入法师训练师所在的{object:173161}。传送门训练师{npc:5958}在上层，花费 20 银教授{spell:3567}。每次传送消耗一个{item:17031}，任意施法材料商人以 10 银出售，记得随身备几个。",
	-- {item:17031} Rune of Teleportation
	["{item:17031}, 10s each"] = "{item:17031}，每个 10 银",

	-- Step 2: Teleport: Undercity
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {npc:2492} Lexington Mortaim · {object:36082} Magic Quarter · {spell:3563} Teleport: Undercity · {npc:4575} Hannah Akeley
	["Take the zeppelin from the tower outside {zone:1454}'s gate to {zone:1420} and walk into the {zone:1458}. {npc:2492}, the portal trainer, stands in the {object:36082} with the mage trainers: {spell:3563}, 20 silver. {npc:4575} beside him sells the runes."] = "从{zone:1454}城门外高塔乘飞艇前往{zone:1420}，再步行进入{zone:1458}。传送门训练师{npc:2492}与法师训练师一起站在{object:36082}，花费 20 银学习{spell:3563}。旁边的{npc:4575}出售传送符文。",

	-- Step 3: Teleport: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {zone:1412} Mulgore · {zone:1454} Orgrimmar · {npc:5957} Birgitte Cranston · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {spell:3566} Teleport: Thunder Bluff
	["At 30. {zone:1456} is in {zone:1412}: fly there from {zone:1454} or the Crossroads. {npc:5957}, the portal trainer, stands with the mage trainers in the {area:2197}, the cave under {area:1640}: go down inside, the arrow cannot tell the floors apart. She teaches {spell:3566} for 80 silver."] = "30级时。{zone:1456}位于{zone:1412}，可从{zone:1454}或十字路口飞去。传送门训练师{npc:5957}与法师训练师们一起待在{area:2197}，那是{area:1640}下方的洞穴；要走进洞穴下层，箭头无法区分楼层。她收取80银币，教授{spell:3566}。",

	-- Step 4: Portals to Orgrimmar and the Undercity
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Portals to {zone:1454} and the {zone:1458}"] = "前往{zone:1454}和{zone:1458}的传送门",
	-- {item:17032} Rune of Portals · {npc:5958} Thuul · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {spell:11417} Portal: Orgrimmar · {zone:1458} Undercity · {npc:2492} Lexington Mortaim · {spell:11418} Portal: Undercity
	["At 40 the portal trainers teach the portals: a gateway your whole group can step through, for 1 gold 50 silver each. Each portal burns one {item:17032} (20 silver at any reagent vendor). {npc:5958} in {object:173161} has {spell:11417}; teleport to the {zone:1458} for {npc:2492}'s {spell:11418}."] = "40 级时，可向训练师学习供全队穿过的传送门，每项技能 1 金 50 银。每次施放消耗一个{item:17032}，任意施法材料商人以 20 银出售。找{object:173161}的{npc:5958}学习{spell:11417}，再传送到{zone:1458}，向{npc:2492}学习{spell:11418}。",
	-- {item:17032} Rune of Portals
	["{item:17032}, 20s each"] = "{item:17032}，每个 20 银",

	-- Step 5: Portal: Thunder Bluff
	-- {npc:5957} Birgitte Cranston · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {spell:11420} Portal: Thunder Bluff · {spell:3566} Teleport: Thunder Bluff
	["At 50 {npc:5957}, down in the {area:2197} under {area:1640} in {zone:1456}, teaches the last one, {spell:11420}, for 3 gold 20 silver. Use your {spell:3566} to get there."] = "50级时，{zone:1456}{area:1640}下方{area:2197}里的{npc:5957}教授最后一个法术{spell:11420}，花费3金20银。用你的{spell:3566}过去。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30. {zone:1456} is in {zone:1412}: fly there from {zone:1454} or the {area:380}. {npc:5957}, the portal trainer, stands with the mage trainers in the {area:2197}, the cave under {area:1640}: go down inside, the arrow cannot tell the floors apart. She teaches {spell:3566} for 80 silver."] = "30级时学习。{zone:1456}位于{zone:1412}：从{zone:1454}或{area:380}飞过去。传送门训练师{npc:5957}和法师训练师一起站在{area:2197}，也就是{area:1640}下方的洞穴里：要进到下面去，箭头分不清楼层。她教授{spell:3566}，花费80银币。",
}
