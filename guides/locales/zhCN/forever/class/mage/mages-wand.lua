-- Chinese (simplified) (zhCN): the guide forever/class/mage/mages-wand (forever/class/mage/mages-wand.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["{npc:5497} at the top of the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}在{zone:1453}的{object:2101}、巫师圣殿顶部，会让你前往{npc:6546}处；{zone:1455}的彬克也提供同一任务。",

	-- Step 2: Journey to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers in {object:173161}, sends you to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}是{zone:1454}的法师训练师之一，位于{object:173161}，会让你前往{npc:6546}处；{zone:1458}的{npc:4568}和{zone:1456}的{npc:3048}也提供同一任务。",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins · {zone:1413} Barrens
	["{npc:6546}, a hermit, lives in a cottage deep in the marsh west of Theramore, just north of the {area:508}. Level 38-41 elites roam the east side of her farm, and swimming in passes level 42 Muckshells: come in from the west along the road from the {zone:1413}. Her cottage is no refuge: mobs follow you inside. Take both her quests."] = "隐士{npc:6546}住在塞拉摩以西的沼泽深处、{area:508}北侧小屋。农场东侧有 38–41 级精英巡逻，游泳进入还会经过 42 级泥壳蟹；请沿{zone:1413}过来的西侧道路进入。小屋并非安全区，怪物会追进去。接取她的两个任务。",

	-- Step 4: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:439} Shimmering Flats · {zone:1441} Thousand Needles
	["{npc:6548} spends his days at the race track in the {area:439}, south-east {zone:1441}."] = "{npc:6548}整天待在{zone:1441}东南部{area:439}的赛道旁。",

	-- Step 5: "Plucky" Johnson
	["\"Plucky\" Johnson"] = "胆大的约翰森",
	["Tirth's apprentice is \"Plucky\" Johnson, a small grey chicken pecking around the foot of the race track's lookout tower; at night type /target plucky. Target him and type /beckon (not /chicken or /wave): he turns human for a moment. Talk to him and ask for the phrase. Do not attack him. If he is gone, he is back within 5 minutes."] = "大法师提尔斯的学徒是胆大的约翰森，一只在赛道瞭望塔底部啄食的小灰鸡。夜间可输入 /target 胆大的约翰森寻找。选中后输入 /beckon，不要用 /chicken 或 /wave，他会短暂变回人类，立即与他交谈并询问口令。不要攻击。如果他不在，最多五分钟就会刷新。",

	-- Step 6: Witherbark trolls and the Bolt Charged Bramble
	-- {item:7272} Bolt Charged Bramble
	["Witherbark trolls and the {item:7272}"] = "枯木巨魔与{item:7272}",
	-- {area:321} Hammerfall · {item:7273} Witherbark Totem Stick · {area:336} Circle of Outer Binding · {item:7272} Bolt Charged Bramble
	["The Witherbark trolls (level 30-36) hold the villages in south-eastern Arathi and south of {area:321}; every kind of them drops a {item:7273} about two times in five: you need ten. Then go to the {area:336} (the outer one, not the Inner circle). Three elementals (level 33-39) stand around its middle stone: pull them one at a time and clear them first. Stand at the middle stone and use a totem stick; about ten seconds later the {item:7272} forms on the stone: click it. If you die before you pick it up, the bramble and the sticks are lost and you need ten more."] = "30–36 级枯木巨魔占据阿拉希东南部及{area:321}以南的村庄。所有种类约有五分之二几率掉落{item:7273}，需要十个。随后前往{area:336}，注意是外侧而非内侧法阵。中心石周围有三只 33–39 级元素生物，先逐个拉出并清理。站在中心石旁使用图腾棒，约十秒后，{item:7272}会出现在石头上，点击拾取。如果拾取前死亡，荆棘和图腾棒都会消失，需要重新收集十个。",
	-- {area:336} Circle of Outer Binding
	["at the middle stone of the {area:336}"] = "在{area:336}的中心石处",

	-- Step 7: Jade
	-- {npc:6546} Tabetha · {item:1529} Jade · {area:271} Southshore
	-- plural, as words: Torn Fin Coastrunners = {npc:2375} Torn Fin Coastrunner
	["{npc:6546} also wants one {item:1529}, a green gem. Miners sometimes find one in ore veins; the Auction House sells it; the Torn Fin Coastrunners on the coast south-west of {area:271} drop one about every fifth kill. Do not sell it to a vendor by mistake."] = "{npc:6546}还需要一颗绿色宝石{item:1529}。采矿时有几率从矿脉获得，也可在拍卖行购买；{area:271}西南海岸的碎鳍滩行鱼人约每五只掉落一颗。不要误卖给商人。",

	-- Step 8: Rituals of Power
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades · {npc:6487} Arcanist Doan · {item:5535} Compendium of the Fallen
	["Tirth sold the book to the Scarlet Crusade. The {area:796} stands in north-eastern {zone:1420}; take the Library wing with a group of five. The book is in the last long hallway, the one that ends in {npc:6487}'s round room: on the left-hand shelf as you face his room, next to the {item:5535}. Take the thick, highlighted blue book sticking out of the shelf; a magnifying-glass cursor means a book you can only read."] = "大法师提尔斯已把书卖给血色十字军。{area:796}位于{zone:1420}东北部，五人组队进入图书馆区。书在通往{npc:6487}圆形房间的最后一条长走廊内，面向首领房间时，位于左侧书架、{item:5535}旁。要拾取书架上突出、被高亮标出的厚蓝书；放大镜光标表示只能阅读的书。",
	-- {quest:1951} Rituals of Power
	["{quest:1951}: Scarlet Monastery Library"] = "{quest:1951}：血色修道院图书馆",

	-- Step 9: Tabetha's ritual
	-- {npc:6546} Tabetha
	["{npc:6546}'s ritual"] = "{npc:6546}的仪式",
	-- {npc:6546} Tabetha
	["Back to {npc:6546}. With both quests handed in she starts the ritual: wait a few seconds, then talk to her again and pick your wand: Icefury (frost), Nether Force (arcane) or Ragefire (fire)."] = "返回{npc:6546}处，交付两个任务后她会开始仪式。稍等几秒再交谈，选择魔杖：冰怒（冰霜）、虚空灵力（奥术）或怒火（火焰）。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6546}"] = "回到{npc:6546}那里",
	-- ["The Witherbark trolls hold south-eastern {zone:1417}; every one of them can drop a {item:7273}. Then take the ten sticks north-west to the binding circle where they become the {item:7272}. {npc:6546} also wants a {item:1529}: buy one at an Auction House on the way; miners sometimes find one in Tin Veins."] = "枯木巨魔占据了{zone:1417}东南部；他们每个都可能掉落{item:7273}。然后把十根图腾棒带到西北边的束缚法阵，它们会变成{item:7272}。{npc:6546}还需要一块{item:1529}：路上在拍卖行买一块；矿工有时会在锡矿中找到。",
	-- ["Tirth sold the book to the Scarlet Brotherhood. The {area:796} stands in north-eastern {zone:1420}; take the Library wing. The book juts out of the wall on the left as you enter the Athenaeum, before {npc:6487}."] = "提尔斯把书卖给了血色十字军。{area:796}位于{zone:1420}东北部；进入图书馆区。进入图书馆大厅时，书从左侧墙上突出来，在{npc:6487}之前。",
	-- ["Tirth's apprentice is \"Plucky\" Johnson, a small grey chicken by the race track. Target him and type /beckon: he turns human for a moment, long enough to talk to him."] = "提尔斯的学徒是胆大的约翰森，一只在赛道旁的灰色小鸡。选中他并输入/beckon：他会短暂变回人形，足够你和他交谈。",
	-- ["Witherbark trolls"] = "枯木巨魔",
	-- ["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{zone:1453}{object:2101}巫师圣殿里的{npc:5497}会让你去找{npc:6546}；{zone:1455}的彬克也提供同样的任务。",
	-- ["{npc:5885}, one of {zone:1454}'s mage trainers, sends you to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{zone:1454}的法师训练师之一{npc:5885}会让你去找{npc:6546}；{zone:1458}的{npc:4568}和{zone:1456}的{npc:3048}也提供同样的任务。",
	-- ["{npc:6546}, a hermit, lives in a cottage deep in the marsh west of Theramore, just north of the {area:508}."] = "隐士{npc:6546}住在塞拉摩岛西边沼泽深处的一间小屋里，就在{area:508}北边。",
}
