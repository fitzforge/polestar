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
	-- {npc:6247} Doan Karhan · {npc:6244} Takar the Seer · {zone:1413} Barrens · {object:1680} Shadowfang Keep (no name in this language: may be words)
	["{npc:6247} camps beside {npc:6244}, at a tent just north-east of Camp Taurajo in the southern {zone:1413}. Alliance warlocks reach him from Ratchet or Theramore; Horde ones head south from the Crossroads. He wants fragments from two dungeons: take the quest before your Blackfathom Deeps and {object:1680} runs."] = "",

	-- Step 2: Blackfathom Deeps
	["Blackfathom Deeps"] = "",
	-- {zone:1440} Ashenvale · {npc:4832} Twilight Lord Kelris · {npc:4829} Aku'mai
	-- plural, as words: Twilight Acolytes = {npc:4809} Twilight Acolyte
	["Blackfathom Deeps (level 24-32, a group of five) opens in the ruins on the north-west coast of {zone:1440}, under the water at Zoram Strand. The Twilight Acolytes (level 24-25, elite, healers) stand in the last halls, around {npc:4832} and the altar before {npc:4829}; each one drops a fragment, but only three spawn in a run and they do not come back for two hours, so one run covers one warlock: kill them first, before they heal the rest."] = "",
	-- plural, as words: Soran'ruk Fragments = {item:6914} Soran'ruk Fragment · Twilight Acolytes = {npc:4809} Twilight Acolyte
	["Soran'ruk Fragments, from the Twilight Acolytes inside"] = "",

	-- Step 3: Shadowfang Keep
	-- {object:1680} Shadowfang Keep (no name in this language: may be words)
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{object:1680} (level 22-30, a group of five) stands on the hill south of the Sepulcher. Free the prisoner in the cells right of the entrance and he opens the way into the courtyard. The Shadowfang Darksouls (level 20-21, elite) are not in the courtyard: they walk the halls past it, up the ramp that curves left and in the building after. About twelve stand in a run and one in five drops the Large Fragment, so clear every Darksoul and run it again if it does not drop."] = "",
	-- {item:6915} Large Soran'ruk Fragment
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{item:6915}, from the Shadowfang Darksouls inside"] = "",

	-- Step 4: Back to Doan Karhan
	-- {npc:6247} Doan Karhan
	["Back to {npc:6247}"] = "回到{npc:6247}处",
	-- {item:6898} Orb of Soran'ruk · {item:15109} Staff of Soran'ruk
	["Choose the off-hand {item:6898} or the two-handed {item:15109}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A rare off-hand orb or staff for your late 20s, for fragments from two dungeons."] = "一件适合20多级后段的稀有副手宝珠或法杖，用两个地下城的碎片换取。",
	-- ["The Shadowfang Darksouls inside {area:236}, a level 20-30 dungeon, drop the Large Fragment about one time in five: bring a group. The keep stands south of the {area:228}."] = "{area:236}（20-30级地下城）内的影牙魔魂狼人约五分之一几率掉落大碎片：带上小队。城堡位于{area:228}南边。",
	-- ["The Twilight Acolytes inside {area:2797}, a level 24-32 dungeon, each drop a {item:6914}: bring a group. The entrance is in the ruins on the north-west coast of {zone:1440}."] = "{area:2797}（24-32级地下城）内的暮光侍僧各掉落一个{item:6914}：带上小队。入口在{zone:1440}西北海岸的废墟中。",
	-- ["{item:6914}, from the Twilight Acolytes"] = "{item:6914}，来自暮光侍僧",
	-- ["{item:6915}, from the Shadowfang Darksouls"] = "{item:6915}，来自影牙魔魂狼人",
	-- ["{npc:6247} camps in the southern {zone:1413}, east of the road north-east of {area:378}."] = "{npc:6247}在{zone:1413}南部扎营，位于{area:378}东北方道路的东侧。",
}
