-- Chinese (simplified) (zhCN): the guide forever/class/mage/mages-wand (forever/class/mage/mages-wand.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A wand of your school for the 30s: frost, arcane or fire."] = "一根适合你30多级使用的本系魔杖：冰霜、奥术或火焰。",

	-- Step 1: Journey to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{zone:1453}{object:2101}巫师圣殿里的{npc:5497}会让你去找{npc:6546}；{zone:1455}的彬克也提供同样的任务。",

	-- Step 2: Journey to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers, sends you to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{zone:1454}的法师训练师之一{npc:5885}会让你去找{npc:6546}；{zone:1458}的{npc:4568}和{zone:1456}的{npc:3048}也提供同样的任务。",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}, a hermit, lives in a cottage deep in the marsh west of Theramore, just north of the {area:508}."] = "隐士{npc:6546}住在塞拉摩岛西边沼泽深处的一间小屋里，就在{area:508}北边。",

	-- Step 4: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:439} Shimmering Flats · {zone:1441} Thousand Needles
	["{npc:6548} spends his days at the race track in the {area:439}, south-east {zone:1441}."] = "{npc:6548}整天待在{zone:1441}东南部{area:439}的赛道旁。",

	-- Step 5: "Plucky" Johnson
	["\"Plucky\" Johnson"] = "胆大的约翰森",
	["Tirth's apprentice is \"Plucky\" Johnson, a small grey chicken by the race track. Target him and type /beckon: he turns human for a moment, long enough to talk to him."] = "提尔斯的学徒是胆大的约翰森，一只在赛道旁的灰色小鸡。选中他并输入/beckon：他会短暂变回人形，足够你和他交谈。",

	-- Step 6: Rituals of Power
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades · {npc:6487} Arcanist Doan
	["Tirth sold the book to the Scarlet Brotherhood. The {area:796} stands in north-eastern {zone:1420}; take the Library wing. The book juts out of the wall on the left as you enter the Athenaeum, before {npc:6487}."] = "提尔斯把书卖给了血色十字军。{area:796}位于{zone:1420}东北部；进入图书馆区。进入图书馆大厅时，书从左侧墙上突出来，在{npc:6487}之前。",
	-- {quest:1951} Rituals of Power
	["{quest:1951}: Scarlet Monastery Library"] = "{quest:1951}：血色修道院图书馆",

	-- Step 7: Back to Tabetha
	-- {npc:6546} Tabetha
	["Back to {npc:6546}"] = "回到{npc:6546}那里",

	-- Step 8: Witherbark trolls
	["Witherbark trolls"] = "枯木巨魔",
	-- {zone:1417} Arathi Highlands · {item:7273} Witherbark Totem Stick · {item:7272} Bolt Charged Bramble · {npc:6546} Tabetha · {item:1529} Jade
	-- plural, as words: Tin Veins = {object:1732} Tin Vein
	["The Witherbark trolls hold south-eastern {zone:1417}; every one of them can drop a {item:7273}. Then take the ten sticks north-west to the binding circle where they become the {item:7272}. {npc:6546} also wants a {item:1529}: buy one at an Auction House on the way; miners sometimes find one in Tin Veins."] = "枯木巨魔占据了{zone:1417}东南部；他们每个都可能掉落{item:7273}。然后把十根图腾棒带到西北边的束缚法阵，它们会变成{item:7272}。{npc:6546}还需要一块{item:1529}：路上在拍卖行买一块；矿工有时会在锡矿中找到。",

	-- Step 9: Tabetha's ritual
	-- {npc:6546} Tabetha
	["{npc:6546}'s ritual"] = "{npc:6546}的仪式",
}
