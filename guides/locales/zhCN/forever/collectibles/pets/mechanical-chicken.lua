-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: OOX-22/FE Distress Beacon in Feralas
	-- {item:8705} OOX-22/FE Distress Beacon · {zone:1444} Feralas
	["{item:8705} in {zone:1444}"] = "{zone:1444}的{item:8705}",
	-- {zone:1444} Feralas · {area:1108} Forgotten Coast
	-- plural, as words: Coast Crawl Snapclaws = {npc:5327} Coast Crawl Snapclaw · Sprite Dragons = {npc:5276} Sprite Dragon
	["Each robot starts with a distress beacon that mobs in its zone drop, about one kill in 40 to 100 in Classic's data. In {zone:1444} the best are the Coast Crawl Snapclaws and Deepseers (levels 43-45) on the {area:1108} and the Sprite Dragons (47-48), about 2.5%; ogres, harpies, naga and Grimtotems drop it about 1%. You can loot it from level 40."] = "每个机器人的任务都始于一枚求救信号器，由所在地区的怪物掉落，经典版数据中的概率约为40到100只出一个。{zone:1444}最适合刷的是{area:1108}的海滩利爪龙虾人和海滩龙虾人先知（43-45级），以及精龙（47-48级），掉率约2.5%；食人魔、鹰身人、纳迦和恐怖图腾的掉率约为1%。40级起就能拾取。",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "营救自动导航机器人OOX-22/FE",
	-- {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Right-click the beacon. OOX-22/FE sits in a cave near {area:1105}, among yetis and apes. Its escort runs west along the road to the dock on the {area:1108} with three ambushes: three yetis, then three gorillas, then four or five gnolls with a caster. Bring a friend if you are under 47. The robot keeps walking unless it is hit, so stay close; if it will not move, another player has it: wait for it to come back. Its turn-in is in {area:35}; keep the quest for later."] = "右键点击定位器。OOX-22/FE 在 {area:1105} 附近的洞穴中，周围是雪人和猿。护送路线沿道路向西，到 {area:1108} 的码头，途中有三次伏击：先是三只雪人，再是三只大猩猩，最后是四五只豺狼人，其中有施法者。低于 47 级就带位朋友。机器人只要没被攻击就会一直走，注意跟紧；如果它不肯动，说明其他玩家正在护送，等它回来。任务在 {area:35} 交还，先留着以后再交。",
	["Escort OOX-22/FE"] = "护送自动导航机器人OOX-22/FE",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{zone:1446}的{item:8623}",
	-- {zone:1446} Tanaris
	-- plural, as words: Treasure Hunting Pirates = {npc:7899} Treasure Hunting Pirate · Ground Pounders = {npc:9396} Ground Pounder
	["{zone:1446} mobs drop OOX-17/TN's beacon about one kill in 50 to 150. Best: the Treasure Hunting Pirates and Buccaneers on the south shore (44-45) and the Ground Pounders in the north (41-43), about 2%. You can loot it from level 43."] = "{zone:1446} 的怪物掉落 OOX-17/TN 定位器的概率约为每 50 至 150 次击杀一次。最佳目标：南岸的寻宝海盗和海盗（44-45 级），以及北部的震地者（41-43 级），掉率约 2%。43 级起可拾取。",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "营救自动导航机器人OOX-17/TN",
	-- {area:981} Gaping Chasm · {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:35} Booty Bay
	["OOX-17/TN stands in the hills near the {area:981} in south-east {zone:1446}. Its escort to {area:977} has two ambushes: three scorpids near the start, three Wastewander bandits near the end. The robot has about 3,000 health and stops to fight what you attack, so it can tank for a moment while you recover. Its turn-in is in {area:35} too."] = "OOX-17/TN 位于 {zone:1446} 东南、{area:981} 附近的山中。护送到 {area:977} 的途中有两次伏击：开始不久遇到三只蝎子，快到终点时遇到三名废土强盗。机器人约有 3,000 生命值，会停下与你攻击的敌人交战，所以你恢复时它能暂时扛一下。这个任务同样在 {area:35} 交还。",
	["Escort OOX-17/TN"] = "护送自动导航机器人OOX-17/TN",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{zone:1425}的{item:8704}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs drop OOX-09/HL's beacon about once in 100 kills: Silvermane wolves, owlbeasts, Highvale elves, Witherbark and Vilebranch trolls. You can loot it from level 43."] = "{zone:1425} 的大多数怪物约每击杀100只掉落一次 OOX-09/HL 的定位器，包括银鬃狼、枭兽、高原 精灵、枯木巨魔和邪枝巨魔。43级起可拾取。",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "营救自动导航机器人OOX-09/HL",
	-- {area:351} Skulk Rock
	-- plural, as words: Marauding Owlbeasts = {npc:7808} Marauding Owlbeast · Vilebranch Ambushers = {npc:7809} Vilebranch Ambusher
	["OOX-09/HL waits on the largest island of the lake west of {area:351}. Its escort to the shore beyond Overlook Cliff has two ambushes of three: Marauding Owlbeasts, then Vilebranch Ambushers; the robot warns you just before each."] = "OOX-09/HL 在 {area:351} 西边湖中最大的岛上等候。护送它到望海崖另一侧的岸边时，会遭遇两次伏击，每次三只：先是狂暴的枭兽，再是邪枝伏击者；每次伏击前机器人都会提醒你。",
	["Escort OOX-09/HL"] = "护送自动导航机器人OOX-09/HL",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay
	["{npc:7406} in {area:35}"] = "{area:35}的{npc:7406}",
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {npc:2490} First Mate Crazz · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {area:35}, upstairs in the building north of the inn, above {npc:2490}. Hand in all three rescues; at level 45 he then offers {quest:3721}, which you turn straight back in for the {item:10398}."] = "{npc:7406} 在 {area:35}，旅店北面建筑的楼上，位于 {npc:2490} 上方。交还全部三次营救任务后，到45级时他会提供 {quest:3721}，接到后立即交还即可获得 {item:10398}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "每个机器人都从一个定位器开始，由所在地区的怪物掉落（我们的数据显示每次击杀约1-2.5%）。从{zone:1444}开始。",
	-- ["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "{zone:1425}的大多数怪物都可能掉落OOX-09/HL定位器（我们的数据显示每次击杀约1-2.5%）。",
	-- ["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "{zone:1446}的大多数怪物都可能掉落OOX-17/TN定位器（我们的数据显示每次击杀约0.5-3%）。",
	-- ["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "把定位器带到{area:351}附近河流源头的自动导航机器人OOX-09/HL处，然后护送它到望海崖另一边的岸边。",
	-- ["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "把定位器带到{zone:1446}的自动导航机器人OOX-17/TN处，然后护送它到{area:977}。它的任务也在{area:35}交还。",
	-- ["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "把定位器带到{area:1105}附近一个洞穴里的自动导航机器人OOX-22/FE处，然后护送它到{area:1108}的码头。它的任务在{area:35}交还；先留着。",
	-- ["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406}在{area:35}。三个机器人都回家后，他会提供{quest:3721}，奖励是{item:10398}；需要45级。",
}
