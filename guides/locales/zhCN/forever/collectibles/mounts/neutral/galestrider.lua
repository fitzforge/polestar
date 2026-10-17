-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/neutral/galestrider (forever/collectibles/mounts/neutral/galestrider.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Galestrider"] = "疾风陆行鸟",

	-- Step 1: Learn to ride
	["Learn to ride"] = "学习骑术",
	-- {skill:762} Riding · {spell:1285849} Galestrider Riding
	["Galestriders need level 40 and {skill:762} ({spell:1285849} comes with it in the Forever client). Any riding trainer of your faction teaches it; see the Level 40 mount guides for where."] = "疾风陆行鸟需要40级和{skill:762}（Forever 客户端中{spell:1285849}随之获得）。你阵营的任何骑术训练师都能教授；地点见40级坐骑指南。",

	-- Step 2: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "从{area:279}乘天空飞船",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}是天裔的起始岛屿；任何人都可以前往。大约每五分钟有一艘天空飞船从{area:279}北侧出发（另一艘从{zone:1456}北边起飞；两个阵营都可以乘坐任意一艘）。如果你已经在岛上，跳过此步。",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "乘天空飞船前往{zone:2521}",

	-- Step 3: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "从{zone:1456}乘天空飞船",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}是天裔的起始岛屿；任何人都可以前往。大约每五分钟有一艘天空飞船从{zone:1456}北边、{area:17045}南侧的悬崖出发（另一艘从{area:279}起飞；两个阵营都可以乘坐任意一艘）。如果你已经在岛上，跳过此步。",

	-- Step 4: Genn Fairweather
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["{npc:265756} is in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Galestrider at 20g; choose one."] = "{npc:265756}在岛上的港口小镇{area:16638}，靠近天空飞船码头。Forever 客户端中每只疾风陆行鸟售价20金；任选一只。",
	["20g"] = "20金",
}
