-- Chinese (simplified) (zhCN): the guide forever/class/warlock/orb-of-soranruk (forever/class/warlock/orb-of-soranruk.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A rare off-hand orb or staff for your late 20s, for fragments from two dungeons."] = "一件适合20多级后段的稀有副手宝珠或法杖，用两个地下城的碎片换取。",

	-- Step 1: Doan Karhan
	-- {npc:6247} Doan Karhan · {zone:1413} Barrens · {area:378} Camp Taurajo
	["{npc:6247} camps in the southern {zone:1413}, east of the road north-east of {area:378}."] = "{npc:6247}在{zone:1413}南部扎营，位于{area:378}东北方道路的东侧。",

	-- Step 2: Blackfathom Deeps
	-- {area:2797} Blackfathom Deeps · {item:6914} Soran'ruk Fragment · {zone:1440} Ashenvale
	-- plural, as words: Twilight Acolytes = {npc:4809} Twilight Acolyte
	["The Twilight Acolytes inside {area:2797}, a level 24-32 dungeon, each drop a {item:6914}: bring a group. The entrance is in the ruins on the north-west coast of {zone:1440}."] = "{area:2797}（24-32级地下城）内的暮光侍僧各掉落一个{item:6914}：带上小队。入口在{zone:1440}西北海岸的废墟中。",
	-- {item:6914} Soran'ruk Fragment
	-- plural, as words: Twilight Acolytes = {npc:4809} Twilight Acolyte
	["{item:6914}, from the Twilight Acolytes"] = "{item:6914}，来自暮光侍僧",

	-- Step 3: Shadowfang Keep
	-- {area:236} Shadowfang Keep · {area:228} Sepulcher
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["The Shadowfang Darksouls inside {area:236}, a level 20-30 dungeon, drop the Large Fragment about one time in five: bring a group. The keep stands south of the {area:228}."] = "{area:236}（20-30级地下城）内的影牙魔魂狼人约五分之一几率掉落大碎片：带上小队。城堡位于{area:228}南边。",
	-- {item:6915} Large Soran'ruk Fragment
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{item:6915}, from the Shadowfang Darksouls"] = "{item:6915}，来自影牙魔魂狼人",

	-- Step 4: Back to Doan Karhan
	-- {npc:6247} Doan Karhan
	["Back to {npc:6247}"] = "回到{npc:6247}处",
}
