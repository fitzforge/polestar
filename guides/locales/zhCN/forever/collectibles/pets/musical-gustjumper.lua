-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/musical-gustjumper (forever/collectibles/pets/musical-gustjumper.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Skyboat from Dalaran
	["Skyboat from Dalaran"] = "",
	-- {zone:2521} Zephras Isle · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; by beta reports anyone may visit. A skyboat leaves the north side of Dalaran about every five minutes (another flies from north of {zone:1456}; either faction may take either)."] = "",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "乘天空飞船前往{zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "从{zone:1456}乘天空飞船",
	-- {zone:2521} Zephras Isle · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; by beta reports anyone may visit. A skyboat leaves the cliffs south of Skywatcher Plateau, north of {zone:1456}, about every five minutes (another flies from Dalaran; either faction may take either)."] = "",

	-- Step 3: Sing to the frogs
	["Sing to the frogs"] = "对青蛙唱歌",
	-- {item:268109} Musical Gustjumper
	["From Thendal Village follow the road south, then cut across the field to the top of the waterfall: five frogs sit together on a rock there, by a log. Mobs patrol nearby, so a level 1 character should watch its back. Stand by the rock, target a frog and type /sing. The frogs sing back, the group disappears and one frog hops onto the log beside you: click it to take the {item:268109}, then use it to learn the pet. The item is not bound until you use it, so a friend on the island can sing again and trade you one."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Skyboat from {area:279}"] = "从{area:279}乘天空飞船",
	-- ["Target one of the frogs here and type /sing; a {item:268109} appears. Interact with it to get the pet."] = "选中这里的一只青蛙并输入/sing；会出现一个{item:268109}。与它互动即可获得宠物。",
	-- ["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}是天裔的起始岛屿；任何人都可以前往。大约每五分钟有一艘天空飞船从{zone:1456}北边、{area:17045}南侧的悬崖出发（另一艘从{area:279}起飞；两个阵营都可以乘坐任意一艘）。如果你已经在岛上，跳过此步。",
	-- ["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}是天裔的起始岛屿；任何人都可以前往。大约每五分钟有一艘天空飞船从{area:279}北侧出发（另一艘从{zone:1456}北边起飞；两个阵营都可以乘坐任意一艘）。如果你已经在岛上，跳过此步。",
}
