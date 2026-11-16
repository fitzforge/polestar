-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: OOX-22/FE Distress Beacon in Feralas
	-- {item:8705} OOX-22/FE Distress Beacon · {zone:1444} Feralas
	["{item:8705} in {zone:1444}"] = "{zone:1444}的{item:8705}",
	-- {zone:1444} Feralas · {area:1108} Forgotten Coast
	-- plural, as words: Coast Crawl Snapclaws = {npc:5327} Coast Crawl Snapclaw · Sprite Dragons = {npc:5276} Sprite Dragon
	["Each robot starts with a distress beacon that mobs in its zone drop, about one kill in 40 to 100 in Classic's data. In {zone:1444} the best are the Coast Crawl Snapclaws and Deepseers (levels 43-45) on the {area:1108} and the Sprite Dragons (47-48), about 2.5%; ogres, harpies, naga and Grimtotems drop it about 1%. You can loot it from level 40."] = "每個機器人一開始都要靠其所在地區的怪物掉落遇難信標，按經典舊世的資料約40到100殺掉一個。在{zone:1444}，最好的是{area:1108}的海岸爬行鉗爪者和深海先知（43-45級）以及精靈龍（47-48級），約2.5%；食人魔、鷹身人、納迦和恐怖圖騰約1%。40級起就能拾取。",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "拯救OOX-22/FE",
	-- {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Right-click the beacon. OOX-22/FE sits in a cave near {area:1105}, among yetis and apes. Its escort runs west along the road to the dock on the {area:1108} with three ambushes: three yetis, then three gorillas, then four or five gnolls with a caster. Bring a friend if you are under 47. The robot keeps walking unless it is hit, so stay close; if it will not move, another player has it: wait for it to come back. Its turn-in is in {area:35}; keep the quest for later."] = "右鍵點選信標。OOX-22/FE坐在{area:1105}附近的洞穴裡，周圍是雪人和猩猩。護送它沿路向西到{area:1108}的碼頭，途中三撥伏擊：三隻雪人，然後三隻猩猩，然後四五隻帶施法者的豺狼人。不到47級就帶個同伴。機器人除非被打中否則會一直走，所以要跟緊；若它不肯動，說明另一名玩家接走了：等它回來。它的交付點在{area:35}；把任務留到以後。",
	["Escort OOX-22/FE"] = "護送OOX-22/FE",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{zone:1446}的{item:8623}",
	-- {zone:1446} Tanaris
	-- plural, as words: Treasure Hunting Pirates = {npc:7899} Treasure Hunting Pirate · Ground Pounders = {npc:9396} Ground Pounder
	["{zone:1446} mobs drop OOX-17/TN's beacon about one kill in 50 to 150. Best: the Treasure Hunting Pirates and Buccaneers on the south shore (44-45) and the Ground Pounders in the north (41-43), about 2%. You can loot it from level 43."] = "{zone:1446}的怪物約50到150殺掉一次OOX-17/TN的信標。最好的是南岸的尋寶海盜和劫掠者（44-45級）以及北部的重擊者（41-43級），約2%。43級起就能拾取。",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "拯救OOX-17/TN",
	-- {area:981} Gaping Chasm · {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:35} Booty Bay
	["OOX-17/TN stands in the hills near the {area:981} in south-east {zone:1446}. Its escort to {area:977} has two ambushes: three scorpids near the start, three Wastewander bandits near the end. The robot has about 3,000 health and stops to fight what you attack, so it can tank for a moment while you recover. Its turn-in is in {area:35} too."] = "OOX-17/TN站在{zone:1446}東南{area:981}附近的丘陵裡。護送它到{area:977}會遭遇兩撥伏擊：起點附近三隻蠍子，終點附近三名廢土強盜。機器人約3,000生命，會停下來打你攻擊的目標，所以能暫時替你抗一會兒，讓你恢復。它的交付點也在{area:35}。",
	["Escort OOX-17/TN"] = "護送OOX-17/TN",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{zone:1425}的{item:8704}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs drop OOX-09/HL's beacon about once in 100 kills: Silvermane wolves, owlbeasts, Highvale elves, Witherbark and Vilebranch trolls. You can loot it from level 43."] = "{zone:1425}的大多數怪物約100殺掉一次OOX-09/HL的信標：銀鬃狼、貓頭鷹獸、高谷精靈、枯木和邪枝食人妖。43級起就能拾取。",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "拯救OOX-09/HL",
	-- {area:351} Skulk Rock
	-- plural, as words: Marauding Owlbeasts = {npc:7808} Marauding Owlbeast · Vilebranch Ambushers = {npc:7809} Vilebranch Ambusher
	["OOX-09/HL waits on the largest island of the lake west of {area:351}. Its escort to the shore beyond Overlook Cliff has two ambushes of three: Marauding Owlbeasts, then Vilebranch Ambushers; the robot warns you just before each."] = "OOX-09/HL在{area:351}以西湖中最大的島上等待。護送它到眺望崖另一側的岸邊會遭遇兩撥各三隻的伏擊：先是遊蕩的貓頭鷹獸，然後是邪枝伏擊者；每次伏擊前機器人都會警告你。",
	["Escort OOX-09/HL"] = "護送OOX-09/HL",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay
	["{npc:7406} in {area:35}"] = "{area:35}的{npc:7406}",
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {npc:2490} First Mate Crazz · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {area:35}, upstairs in the building north of the inn, above {npc:2490}. Hand in all three rescues; at level 45 he then offers {quest:3721}, which you turn straight back in for the {item:10398}."] = "{npc:7406}在{area:35}，旅店以北那棟建築的樓上，{npc:2490}上方。交掉三次救援；45級時他會提供{quest:3721}，接完立刻交回，換取{item:10398}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "每個機器人都從一個定位器開始，由所在地區的怪物掉落（依我們的資料，每次擊殺約1-2.5%）。從{zone:1444}開始。",
	-- ["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "大多數{zone:1425}的怪物都可能掉落OOX-09/HL的定位器（依我們的資料，每次擊殺約1-2.5%）。",
	-- ["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "大多數{zone:1446}的怪物都可能掉落OOX-17/TN的定位器（依我們的資料，每次擊殺約0.5-3%）。",
	-- ["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "把定位器帶到{area:351}附近河流源頭的OOX-09/HL，然後護送它到望海崖另一頭的岸邊。",
	-- ["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "把定位器帶到{zone:1446}的OOX-17/TN，然後護送它到{area:977}。它的繳交處也在{area:35}。",
	-- ["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "把定位器帶到{area:1105}附近洞穴裡的OOX-22/FE，然後護送它到{area:1108}的碼頭。它的繳交處在{area:35}；保留到稍後。",
	-- ["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406}在{area:35}。三個機器人都回家後，他會提供{quest:3721}，獎勵是{item:10398}；需要45級。",
}
