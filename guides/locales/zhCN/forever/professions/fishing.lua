-- Chinese (simplified) (zhCN): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "学习{skill:356}",
	-- {skill:356} Fishing · {item:6256} Fishing Pole
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "本阵营任何{skill:356}训练师都能传授初级{skill:356}（角色等级5）；箭头会指向最近的一位。从商品商人或钓鱼商人处购买一根{item:6256}并装备。",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "在这里钓鱼直到技能50。鱼漂溅起水花时点击它；每次钓到东西都可能提升技能。",

	-- Step 4: Fishing: Darkshore (1-50)
	-- {area:442} Auberdine
	["{area:442} shore"] = "{area:442}岸边",

	-- Step 5: Fishing: Durotar (1-50)
	-- {zone:1411} Durotar
	["{zone:1411} coast"] = "{zone:1411}海岸",

	-- Step 6: Fishing: The Barrens (1-50)
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "{zone:1413}绿洲",

	-- Step 7: Fishing: Tirisfal Glades (1-50)
	["Vile Fin shore"] = "邪鳍鱼人的岸边",

	-- Step 8: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "中级{skill:356}",
	-- {skill:356} Fishing
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "中级{skill:356}将上限提升到150；需要技能50和角色等级10。箭头会指向本阵营最近的{skill:356}训练师。",

	-- Step 9: Fishing: Westfall (50-125)
	["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "在这里的鱼群和开阔水域钓鱼直到技能125。鱼群（漂浮的残骸、鱼群）还会给额外战利品。",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "{zone:1436}海岸",

	-- Step 11: Fishing: Darkshore (50-125)
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "{zone:1439}海岸",

	-- Step 14: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "高级{skill:356}",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "高级{skill:356}（上限225）是一本书，不是训练师等级：{zone:1434}南端{area:35}的{npc:2626}向两个阵营出售{item:16083}。购买并阅读；需要技能125和20级。",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "购买并阅读{item:16083}（高级{skill:356}）",

	-- Step 15: Fishing: Wetlands (125-225)
	["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "在这里的鱼群钓鱼直到技能225。如果鱼总是跑掉，就先去容易些的水域钓，等技能跟上。",
	-- {zone:1437} Wetlands
	["{zone:1437} coast"] = "{zone:1437}海岸",

	-- Step 16: Fishing: Ashenvale (125-225)
	-- {zone:1440} Ashenvale
	["{zone:1440} waters"] = "{zone:1440}水域",

	-- Step 18: Fishing: Hillsbrad Foothills (125-225)
	-- {area:287} Hillsbrad
	["{area:287} coast"] = "{area:287}海岸",

	-- Step 19: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "专家级{skill:356}（上限300）由{zone:1445}的{npc:12919}传授。{zone:1455}的钓鱼训练师会让你去找他；任务需要技能225和35级。",

	-- Step 20: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "专家级{skill:356}（上限300）由{zone:1445}的{npc:12919}传授。{zone:1454}的钓鱼训练师会让你去找他；任务需要技能225和35级。",

	-- Step 21: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919}在塞拉摩岛以南、东海岸外一座小岛的岸边钓鱼。",

	-- Step 22: Sar'theris Striker
	-- {area:598} Sar'theris Strand · {zone:1443} Desolace · {item:16968} Sar'theris Striker
	["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "在{zone:1443}西北海岸的{area:598}（滑刃纳迦所在的海岸）钓鱼，直到钓到{item:16968}；它只在那里上钩。",

	-- Step 23: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {item:16967} Feralas Ahi
	["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "在{zone:1444}的{area:2521}钓鱼，直到钓到{item:16967}；它只在那里上钩。",

	-- Step 24: Savage Coast Blue Sailfin
	-- {area:301} Savage Coast · {zone:1434} Stranglethorn Vale · {item:16969} Savage Coast Blue Sailfin
	["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "在{zone:1434}西北岸的{area:301}钓鱼，直到钓到{item:16969}；它只在那里上钩。",

	-- Step 25: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "在{zone:1435}东南岸的{area:300}钓鱼，直到钓到{item:16970}；它只在那里上钩。",

	-- Step 26: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "专家级{skill:356}",

	-- Step 27: Fishing: Stranglethorn Vale (225-300)
	-- {area:35} Booty Bay · {item:6530} Nightcrawlers
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "在这里沿海岸的鱼群（鳗鱼、鲷鱼、残骸）钓鱼直到技能300。{area:35}出售鱼饵和{item:6530}，可略微提升钓鱼技能。",
	-- {area:35} Booty Bay
	["{area:35} coast"] = "{area:35}海岸",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{zone:1413} oasis"] = "{zone:1413}绿洲",
}
