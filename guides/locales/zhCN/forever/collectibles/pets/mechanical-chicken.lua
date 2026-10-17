-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: OOX-22/FE Distress Beacon in Feralas
	-- {item:8705} OOX-22/FE Distress Beacon · {zone:1444} Feralas
	["{item:8705} in {zone:1444}"] = "{zone:1444}的{item:8705}",
	-- {zone:1444} Feralas
	["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "每个机器人都从一个定位器开始，由所在地区的怪物掉落（我们的数据显示每次击杀约1-2.5%）。从{zone:1444}开始。",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "营救自动导航机器人OOX-22/FE",
	-- {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "把定位器带到{area:1105}附近一个洞穴里的自动导航机器人OOX-22/FE处，然后护送它到{area:1108}的码头。它的任务在{area:35}交还；先留着。",
	["Escort OOX-22/FE"] = "护送自动导航机器人OOX-22/FE",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{zone:1446}的{item:8623}",
	-- {zone:1446} Tanaris
	["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "{zone:1446}的大多数怪物都可能掉落OOX-17/TN定位器（我们的数据显示每次击杀约0.5-3%）。",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "营救自动导航机器人OOX-17/TN",
	-- {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "把定位器带到{zone:1446}的自动导航机器人OOX-17/TN处，然后护送它到{area:977}。它的任务也在{area:35}交还。",
	["Escort OOX-17/TN"] = "护送自动导航机器人OOX-17/TN",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{zone:1425}的{item:8704}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "{zone:1425}的大多数怪物都可能掉落OOX-09/HL定位器（我们的数据显示每次击杀约1-2.5%）。",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "营救自动导航机器人OOX-09/HL",
	-- {area:351} Skulk Rock
	["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "把定位器带到{area:351}附近河流源头的自动导航机器人OOX-09/HL处，然后护送它到望海崖另一边的岸边。",
	["Escort OOX-09/HL"] = "护送自动导航机器人OOX-09/HL",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay
	["{npc:7406} in {area:35}"] = "{area:35}的{npc:7406}",
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406}在{area:35}。三个机器人都回家后，他会提供{quest:3721}，奖励是{item:10398}；需要45级。",
}
