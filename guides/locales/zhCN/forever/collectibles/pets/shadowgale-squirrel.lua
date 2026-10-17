-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/shadowgale-squirrel (forever/collectibles/pets/shadowgale-squirrel.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "从{area:279}乘天空飞船",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}是天裔的起始岛屿；任何人都可以前往。大约每五分钟有一艘天空飞船从{area:279}北侧出发（另一艘从{zone:1456}北边起飞；两个阵营都可以乘坐任意一艘）。如果你已经在岛上，跳过此步。",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "乘天空飞船前往{zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "从{zone:1456}乘天空飞船",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}是天裔的起始岛屿；任何人都可以前往。大约每五分钟有一艘天空飞船从{zone:1456}北边、{area:17045}南侧的悬崖出发（另一艘从{area:279}起飞；两个阵营都可以乘坐任意一艘）。如果你已经在岛上，跳过此步。",

	-- Step 3: Revered with the Nightclaw Druids
	-- {faction:2758} Nightclaw Druids
	["Revered with the {faction:2758}"] = "{faction:2758}崇敬",
	-- {npc:254151} Vayn Moongaze · {faction:2758} Nightclaw Druids
	["{npc:254151} sells the squirrel (50s) once you are Revered with the {faction:2758}."] = "当你在{faction:2758}达到崇敬后，{npc:254151}会出售松鼠（50银）。",
	["50s"] = "50银",
}
