-- Chinese (simplified) (zhCN): the guide forever/class/warlock/orb-of-soranruk (forever/class/warlock/orb-of-soranruk.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A rare off-hand orb or staff for your 20s, for fragments from two dungeons."] = "一件适合20多级的稀有副手宝珠或法杖，用两个地下城的碎片换取。",

	-- Step 1: Doan Karhan
	-- {npc:6247} Doan Karhan · {npc:6244} Takar the Seer · {area:378} Camp Taurajo · {zone:1413} Barrens · {area:392} Ratchet · {area:2797} Blackfathom Deeps · {area:236} Shadowfang Keep
	["{npc:6247} camps beside {npc:6244}, at a tent just north-east of {area:378} in the southern {zone:1413}. Alliance warlocks reach him from {area:392} or Theramore; Horde ones head south from the Crossroads. He wants fragments from two dungeons: take the quest before your {area:2797} and {area:236} runs."] = "{npc:6247}和{npc:6244}在一起，营地位于{zone:1413}南部、{area:378}东北不远的一顶帐篷旁。联盟术士可从{area:392}或塞拉摩前往；部落术士从十字路口向南走。他需要两个副本的碎片：在去{area:2797}和{area:236}前先接任务。",

	-- Step 2: Blackfathom Deeps
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {area:414} Zoram Strand · {npc:4832} Twilight Lord Kelris · {npc:4829} Aku'mai
	-- plural, as words: Twilight Acolytes = {npc:4809} Twilight Acolyte
	["{area:2797} (level 24-32, a group of five) opens in the ruins on the north-west coast of {zone:1440}, under the water at {area:414}. The Twilight Acolytes (level 24-25, elite, healers) stand in the last halls, around {npc:4832} and the altar before {npc:4829}; each one drops a fragment, but only three spawn in a run and they do not come back for two hours, so one run covers one warlock: kill them first, before they heal the rest."] = "{area:2797} 是24—32级的五人地下城，入口在 {zone:1440} 西北海岸废墟中、{area:414} 的水下。暮光侍僧（24—25级精英，会治疗）位于最后几间大厅里，分布在 {npc:4832} 周围及 {npc:4829} 前方的祭坛旁；每名都掉落一块碎片，但每次副本只有三名，且两小时内不会刷新，因此一趟只能满足一名术士的需求：先杀掉他们，免得他们治疗其他敌人。",
	-- plural, as words: Soran'ruk Fragments = {item:6914} Soran'ruk Fragment · Twilight Acolytes = {npc:4809} Twilight Acolyte
	["Soran'ruk Fragments, from the Twilight Acolytes inside"] = "索兰鲁克宝珠的碎片，由里面的暮光侍僧掉落",

	-- Step 3: Shadowfang Keep
	-- {area:236} Shadowfang Keep · {area:228} Sepulcher
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{area:236} (level 22-30, a group of five) stands on the hill south of the {area:228}. Free the prisoner in the cells right of the entrance and he opens the way into the courtyard. The Shadowfang Darksouls (level 20-21, elite) are not in the courtyard: they walk the halls past it, up the ramp that curves left and in the building after. About twelve stand in a run and one in five drops the Large Fragment, so clear every Darksoul and run it again if it does not drop."] = "{area:236}（22-30 级，五人小队）位于 {area:228} 南侧山丘上。释放入口右侧牢房中的囚犯，他会打开通往庭院的路。影牙魔魂狼人（20-21 级，精英）不在庭院中：它们在庭院之后的走廊、向左弯曲的坡道上，以及后面的建筑中活动。每次副本约有十二只，每只掉落 索兰鲁克宝珠的大碎片 的概率为五分之一，因此要清掉所有魔魂狼人，若没掉就再刷一次。",
	-- {item:6915} Large Soran'ruk Fragment
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{item:6915}, from the Shadowfang Darksouls inside"] = "{item:6915}，由内部的影牙魔魂狼人掉落",

	-- Step 4: Back to Doan Karhan
	-- {npc:6247} Doan Karhan
	["Back to {npc:6247}"] = "回到{npc:6247}处",
	-- {item:6898} Orb of Soran'ruk · {item:15109} Staff of Soran'ruk
	["Choose the off-hand {item:6898} or the two-handed {item:15109}."] = "选择副手物品 {item:6898} 或双手武器 {item:15109}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A rare off-hand orb or staff for your late 20s, for fragments from two dungeons."] = "一件适合20多级后段的稀有副手宝珠或法杖，用两个地下城的碎片换取。",
	-- ["The Shadowfang Darksouls inside {area:236}, a level 20-30 dungeon, drop the Large Fragment about one time in five: bring a group. The keep stands south of the {area:228}."] = "{area:236}（20-30级地下城）内的影牙魔魂狼人约五分之一几率掉落大碎片：带上小队。城堡位于{area:228}南边。",
	-- ["The Twilight Acolytes inside {area:2797}, a level 24-32 dungeon, each drop a {item:6914}: bring a group. The entrance is in the ruins on the north-west coast of {zone:1440}."] = "{area:2797}（24-32级地下城）内的暮光侍僧各掉落一个{item:6914}：带上小队。入口在{zone:1440}西北海岸的废墟中。",
	-- ["{item:6914}, from the Twilight Acolytes"] = "{item:6914}，来自暮光侍僧",
	-- ["{item:6915}, from the Shadowfang Darksouls"] = "{item:6915}，来自影牙魔魂狼人",
	-- ["{npc:6247} camps in the southern {zone:1413}, east of the road north-east of {area:378}."] = "{npc:6247}在{zone:1413}南部扎营，位于{area:378}东北方道路的东侧。",
}
