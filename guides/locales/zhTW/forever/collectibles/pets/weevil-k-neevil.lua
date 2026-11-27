-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/weevil-k-neevil (forever/collectibles/pets/weevil-k-neevil.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: My Little Friends
	-- {npc:217412} Amaryllis Webb · {zone:1435} Swamp of Sorrows · {item:213565} Entomology Starter Kit · {zone:1417} Arathi Highlands · {zone:1443} Desolace
	["{npc:217412}, a Forsaken bug collector, keeps her menagerie in western {zone:1435}. She hands you an {item:213565}: open it for the tools that catch the three bugs. The bugs are far apart (northern Stranglethorn, {zone:1417} and {zone:1443}), so do them while you pass. If you lose the kit, she sells another for 50s."] = "{npc:217412} 是一名被遺忘者昆蟲收集者，她的蟲舍位於 {zone:1435} 西部。她會給你一個{item:213565}：開啟後取得捕捉三隻蟲子的工具。三隻蟲子相距很遠（荊棘谷北部、{zone:1417} 和 {zone:1443}），因此經過時順手完成即可。如果丟了工具包，她出售的補發包價格是 50 銀幣。",

	-- Step 2: Arbor Tarantula in Stranglethorn Vale
	-- {npc:217588} Arbor Tarantula · {zone:1434} Stranglethorn Vale
	["{npc:217588} in {zone:1434}"] = "{npc:217588}在{zone:1434}",
	-- {item:213565} Entomology Starter Kit · {item:213562} Bug Catching Net
	-- plural, as words: Arbor Tarantulas = {npc:217588} Arbor Tarantula
	["The Arbor Tarantulas sit in northern Stranglethorn. Open the {item:213565} and use its {item:213562} on one to catch it: don't kill it."] = "喬木狼蛛（{npc:217588}）在荊棘谷北部。打開{item:213565}，對其中一隻使用裡面的{item:213562}來抓住牠：不要殺死牠。",
	-- {item:213562} Bug Catching Net · {npc:217588} Arbor Tarantula
	["{item:213562}, on an {npc:217588}"] = "{item:213562}，用在{npc:217588}上",

	-- Step 3: Hay Weevil in Arathi Highlands
	-- {npc:217589} Hay Weevil · {zone:1417} Arathi Highlands
	["{npc:217589} in {zone:1417}"] = "{npc:217589}在{zone:1417}",
	-- {zone:1417} Arathi Highlands · {item:213562} Bug Catching Net
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["The Hay Weevils crawl in the north-west of {zone:1417}. Use the {item:213562} on one."] = "乾草象鼻蟲（{npc:217589}）在{zone:1417}西北部爬行。對其中一隻使用{item:213562}。",
	-- {item:213562} Bug Catching Net · {npc:217589} Hay Weevil
	["{item:213562}, on a {npc:217589}"] = "{item:213562}，用在{npc:217589}上",

	-- Step 4: Flesh Picker in Desolace
	-- {npc:217590} Flesh Picker · {zone:1443} Desolace
	["{npc:217590} in {zone:1443}"] = "{npc:217590}在{zone:1443}",
	-- {area:596} Kodo Graveyard · {zone:1443} Desolace · {item:213562} Bug Catching Net
	-- plural, as words: Flesh Pickers = {npc:217590} Flesh Picker
	["The Flesh Pickers feed in the {area:596} in the middle of southern {zone:1443}. Use the {item:213562} on one."] = "食腐者（{npc:217590}）在{zone:1443}南部中央的{area:596}覓食。對其中一隻使用{item:213562}。",
	-- {item:213562} Bug Catching Net · {npc:217590} Flesh Picker
	["{item:213562}, on a {npc:217590}"] = "{item:213562}，用在{npc:217590}上",

	-- Step 5: Back to Amaryllis Webb
	-- {npc:217412} Amaryllis Webb
	["Back to {npc:217412}"] = "返回{npc:217412}",
	-- {npc:217412} Amaryllis Webb · {item:280456} Weevil K. Neevil
	["Hand {npc:217412} the three specimens: she gives you {item:280456} and 35s."] = "把三隻標本交給{npc:217412}：她會給你{item:280456}和35銀。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Arbor Tarantulas sit in northern Stranglethorn. Use the kit's tool on one to catch it."] = "林木狼蛛棲息在荊棘谷北部。用工具包裡的工具對一隻使用，即可捕捉。",
	-- ["The Flesh Pickers feed in the {area:596} in the middle of southern {zone:1443}. Use the kit's tool on one."] = "食肉蟲在{zone:1443}南部中段的{area:596}覓食。用工具包裡的工具對一隻使用。",
	-- ["The Hay Weevils crawl in the north-west of {zone:1417}. Use the kit's tool on one."] = "乾草象鼻蟲在{zone:1417}西北部爬行。用工具包裡的工具對一隻使用。",
	-- ["{npc:217412} gives you an Entomology Starter Kit: use its items to catch an {npc:217588}, a Hay Weevil Specimen and a {npc:217590}. This quest is named as the weevil's source but gives only money as its reward; the pet may come from the {npc:217589} you catch. If you lose the kit, she sells another."] = "{npc:217412}會給你一個昆蟲學入門套件：用裡面的物品捕捉一隻{npc:217588}、一隻象鼻蟲標本和一隻{npc:217590}。這個任務被列為這隻象鼻蟲的來源，但獎勵只有金錢；寵物可能來自你捕捉的{npc:217589}。如果你弄丟了套件，她會再賣你一個。",
}
