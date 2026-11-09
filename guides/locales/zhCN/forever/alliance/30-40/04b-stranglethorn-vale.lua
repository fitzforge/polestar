-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/04b-stranglethorn-vale (forever/alliance/30-40/04b-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Collin Mauren
	-- {object:2164} Slaughtered Lamb
	["In the {object:2164}, if you still carry it"] = "",

	-- Step 2: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飞往{area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453}飞行管理员",

	-- Step 3: Stranglethorn Vale
	-- {zone:1434} Stranglethorn Vale
	["Into {zone:1434}"] = "进入{zone:1434}",

	-- Step 4: Rebel Camp
	-- {zone:1431} Duskwood
	["From {zone:1431} take the road south; the camp sits in the hills west of the road."] = "从{zone:1431}沿路向南；营地在道路西边的山丘中。",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}：交给{area:35}的{npc:773}",

	-- Step 5: Bookie Herod
	-- {area:101} Kurzen's Compound · {area:99} Rebel Camp
	["Herod's records lie in a hut on the west side of {area:101}, east of the {area:99}."] = "赫罗德的档案在{area:101}西侧的一间小屋中，位于{area:99}以东。",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "{object:287}：在楼上",

	-- Step 6: Kurzen's Compound
	-- {spell:7964} Smoke Bomb
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}."] = "库尔森精神医师在营地深处；库尔森特种兵潜行在营地周围及洞内，赫罗德的保险箱在洞口旁。掉落Green Hills书页时记得拾取。\n小心：库尔森特种兵为34-35级，非精英，出现时经常处于潜行状态；濒死时会使用{spell:7964}。",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "{npc:941}：在地下",
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "{object:288}：在地下",

	-- Step 7: Rebel Camp
	-- {npc:733} Sergeant Yohwa
	["{npc:733}: the Commandos and Headshrinkers fell in the compound"] = "{npc:733}：特种兵和精神医师已经在营地击杀",

	-- Step 8: Nesingwary's Expedition
	["South along the road: the hunters' tents stand just west of it."] = "沿路向南：猎人的帐篷就在道路西侧。",

	-- Step 9: The jungle ruins
	["The jungle ruins"] = "丛林废墟",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "绕行北部和中部的巨魔废墟：每处都有一块记载巨魔传说的石板。深喉猎豹潜行在周围的丛林中；{area:37}的风险投资公司营地携带打磨过的水晶。",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "{item:2006}：在水下的{object:58}中寻找",

	-- Step 10: Water Elementals
	-- plural, as words: Lesser Water Elementals = {npc:691} Lesser Water Elemental
	["Follow the west coast north to the haunted island off the shore west of Nesingwary's camp: the Lesser Water Elementals rise from the water around it."] = "沿西海岸向北，前往赫米特·奈辛瓦里营地以西近海的闹鬼岛屿，次级水元素在周围水中出现。",

	-- Step 11: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434}：沿途击杀以下目标",

	-- Step 15: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "钳嘴鳄鱼",
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to the Skullsplitter ruins."] = "钳嘴鳄鱼在丛林中央河流两侧晒太阳，向南前往劈颅废墟时会经过。",

	-- Step 16: Level 36
	["Level 36"] = "等级 36",
	-- {quest:205} Troll Witchery · {area:796} Scarlet Monastery · {area:1316} Razorfen Downs
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{quest:205}'s Skullsplitter trolls are 39-42. Below 36? Keep killing the Snapjaw Crocolisks along the river until level 36. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "{quest:205}所需的劈颅巨魔为39-42级。还没到36级？继续沿河刷钳嘴鳄鱼，直到36级。也可以组队去{area:796}副本（军械库）或{area:1316}副本。",
	-- {npc:1152} Snapjaw Crocolisk
	["grind on {npc:1152}"] = "刷{npc:1152}升级",

	-- Step 17: Skullsplitter trolls
	["Skullsplitter trolls"] = "劈颅巨魔",
	-- {object:3202} Grom'gol
	["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "劈颅巨魔占据奈辛瓦里和{object:3202}之间道路东边的废墟。",

	-- Step 18: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}：在屋内",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}，在旅店楼上",
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "交给{zone:1416}的大法师安斯雷姆",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}：在楼上",
	-- {npc:773} Krazek · {zone:1417} Arathi Highlands
	["{npc:773}: the ore drops from Drywhisker kobolds in {zone:1417}, next"] = "{npc:773}：矿石由接下来{zone:1417}的枯须狗头人掉落",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}：在屋内",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "“海狼”马克基雷，位于最顶层",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Mauren, from Stonetalon"] = "Mauren，从石爪山脉来的任务",
}
