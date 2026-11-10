-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/weevil-k-neevil (forever/collectibles/pets/weevil-k-neevil.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: My Little Friends
	-- {npc:217412} Amaryllis Webb · {zone:1435} Swamp of Sorrows · {zone:1417} Arathi Highlands · {zone:1443} Desolace
	["{npc:217412}, a Forsaken bug collector, keeps her menagerie in western {zone:1435}. She hands you an Entomology Starter Kit: open it for the tools that catch the three bugs. The bugs are far apart (northern Stranglethorn, {zone:1417} and {zone:1443}), so do them while you pass. If you lose the kit, she sells another for 50s."] = "{npc:217412} 是一名被遗忘者昆虫收集者，她的虫舍位于 {zone:1435} 西部。她会给你一个昆虫学入门工具包：打开后取得捕捉三只虫子的工具。三只虫子相距很远（荆棘谷北部、{zone:1417} 和 {zone:1443}），因此经过时顺手完成即可。如果丢了工具包，她出售的补发包价格是 50 银币。",

	-- Step 2: Arbor Tarantula in Stranglethorn Vale
	-- {npc:217588} Arbor Tarantula · {zone:1434} Stranglethorn Vale
	["{npc:217588} in {zone:1434}"] = "{zone:1434}的{npc:217588}",
	-- plural, as words: Arbor Tarantulas = {npc:217588} Arbor Tarantula
	["The Arbor Tarantulas sit in northern Stranglethorn. Use the kit's tool on one to catch it."] = "树栖狼蛛在荆棘谷北部。对其中一只使用套装里的工具即可捕捉。",

	-- Step 3: Hay Weevil in Arathi Highlands
	-- {npc:217589} Hay Weevil · {zone:1417} Arathi Highlands
	["{npc:217589} in {zone:1417}"] = "{zone:1417}的{npc:217589}",
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["The Hay Weevils crawl in the north-west of {zone:1417}. Use the kit's tool on one."] = "干草象鼻虫在{zone:1417}西北部爬行。对其中一只使用工具包中的工具。",

	-- Step 4: Flesh Picker in Desolace
	-- {npc:217590} Flesh Picker · {zone:1443} Desolace
	["{npc:217590} in {zone:1443}"] = "{zone:1443}的{npc:217590}",
	-- {area:596} Kodo Graveyard · {zone:1443} Desolace
	-- plural, as words: Flesh Pickers = {npc:217590} Flesh Picker
	["The Flesh Pickers feed in the {area:596} in the middle of southern {zone:1443}. Use the kit's tool on one."] = "剔肉蝎在 {zone:1443} 南部中央的 {area:596} 觅食。对其中一只使用工具包中的工具。",

	-- Step 5: Back to Amaryllis Webb
	-- {npc:217412} Amaryllis Webb
	["Back to {npc:217412}"] = "返回{npc:217412}处",
	-- {npc:217412} Amaryllis Webb · {item:280456} Weevil K. Neevil
	["Hand {npc:217412} the three specimens: she gives you {item:280456} and 35s."] = "把三份标本交给 {npc:217412}：她会给你 {item:280456} 和 35 银币。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:217412} gives you an Entomology Starter Kit: use its items to catch an {npc:217588}, a Hay Weevil Specimen and a {npc:217590}. This quest is named as the weevil's source but gives only money as its reward; the pet may come from the {npc:217589} you catch. If you lose the kit, she sells another."] = "{npc:217412}会给你一套昆虫学入门工具：用其中的物品捕捉一只{npc:217588}、一只干草象鼻虫标本和一只{npc:217590}。这个任务被标为象鼻虫的来源，但奖励只有金钱；宠物可能来自你捕捉的{npc:217589}。如果弄丢了工具，她会再卖给你一套。",
}
