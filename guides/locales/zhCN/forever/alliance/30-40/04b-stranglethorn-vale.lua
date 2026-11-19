-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/04b-stranglethorn-vale (forever/alliance/30-40/04b-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 35 to 36, but several quests here are level 37-38: on purpose, for their experience. The water elementals are 36-37: pull them one at a time."] = "适合35到36级的角色，但这里有几个任务是37-38级：这是有意安排的，为了它们的经验值。水元素为36-37级：一次拉一只。",

	-- Step 1: Collin Mauren
	-- {object:2164} Slaughtered Lamb
	["In the {object:2164}, if you still carry it"] = "在{object:2164}里，如果还带着它",

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
	["{npc:770}, if 30-40/04 didn't give it: for {npc:773} in {area:35}"] = "{npc:770}，若30-40/04中未接取：交给{area:35}的{npc:773}",

	-- Step 5: Nesingwary's Expedition
	-- {npc:717} Ajeck Rouack
	["South along the road: the hunters' tents stand just west of it. {npc:717} and Hemet gave you these on the first loop: take them now only if you didn't."] = "沿道路向南：猎人的帐篷就在道路西边。{npc:717}和赫米特在第一轮已给过这些任务：只有当时没接才现在接取。",
	-- {npc:717} Ajeck Rouack · {npc:729} Sin'Dall
	["{npc:717}. Keep it for the later visit if you skip {npc:729} on the raptor hill."] = "",
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:715}, if 30-40/04 didn't give it: the Lashtail Raptors, after the jungle ruins"] = "{npc:715}，若30-40/04中未接取：鞭尾迅猛龙，在丛林废墟之后处理",

	-- Step 6: Bookie Herod
	-- {area:101} Kurzen's Compound
	["East to {area:101}: Herod's records lie in a hut on its west side."] = "向东前往{area:101}：赫罗德的档案在其西侧的一间小屋中。",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "{object:287}：在楼上",

	-- Step 7: Kurzen's Compound
	-- {npc:218230} Wendel Mathers · {spell:7964} Smoke Bomb · {npc:813} Colonel Kurzen
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["{npc:218230}, a cook, is caged at the compound's western edge: take his quest now and keep it, his cage key and the fighter's uniform come on the 40-50 Stranglethorn guide, when the Subchiefs and Elites are your level. Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}. {npc:813}, an elite of 39-40, stands at the compound's north end: leave him be."] = "{npc:218230}是个厨师，被关在营地西边缘的笼子里：现在就接受他的任务并保留，他的笼子钥匙和斗士制服要等到40-50级荆棘谷指南、副酋长和精英与你等级相当时再做。库尔森精神医师在营地深处；库尔森特种兵潜行在营地周围及洞内，赫罗德的保险箱在洞口旁。掉落《荆棘谷的青山》书页时记得拾取。\n小心：库尔森特种兵为34-35级，非精英，出现时经常处于潜行状态；濒死时会使用{spell:7964}。{npc:813}是39-40级精英，站在营地北端：别去惹他。",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, in his cage"] = "{npc:218230}，在他的笼子里",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "{npc:941}：在地下",
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "{object:288}：在地下",

	-- Step 8: The jungle ruins
	["The jungle ruins"] = "丛林废墟",
	["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west.\nCareful: the Saltscale murlocs on the shore near the second tablet are elite (35-37): swim to the tablet from the water and keep clear of them."] = "向西穿过丛林前往巨魔废墟：每处都有一块记载巨魔传说的石板，前两块在奈辛瓦里营地西南的废墟中，后两块在西北的山丘上。\n小心：第二块石板附近岸边的盐鳞鱼人是精英（35-37级）：从水中游到石板处，远离它们。",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "{item:2006}：在水下的{object:58}中寻找",

	-- Step 9: Water Elementals
	-- plural, as words: Lesser Water Elementals = {npc:691} Lesser Water Elemental
	["The haunted island lies just off the shore west of the second tablet: the Lesser Water Elementals rise from the water around it."] = "闹鬼岛屿就在第二块石板以西的近海：次级水元素在周围水中出现。",

	-- Step 10: The Ruins of Zul'Kunda
	-- {area:102} Ruins of Zul'Kunda
	["The {area:102}"] = "{area:102}",
	-- {npc:268992} Zimmix Sputterspark · {item:277957} Primitive Key
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment · Bloodscalp Berserkers = {npc:597} Bloodscalp Berserker
	["North along the coast to the ruins on the hill: the last two tablets lie there. {npc:268992}, a goblin, is caged beside the third tablet: any Bloodscalp can drop his {item:277957}, then lead him out of the ruins. The Stolen Shipments lie at the ruins' east edge. Pick up Green Hills pages as they drop.\nCareful: the Bloodscalp Berserkers, Headhunters and Witch Doctors (36-37) hold the ruins' core: pull them one at a time."] = "沿海岸向北前往山丘上的废墟：最后两块石板在那里。地精{npc:268992}被关在第三块石板旁的笼子里：任何血顶巨魔都可能掉落他的{item:277957}，之后护送他离开废墟。被盗的货物在废墟东边缘。掉落《荆棘谷的青山》书页时记得拾取。\n小心：血顶狂战士、猎头者和巫医（36-37级）占据废墟中心：一次拉一个。",
	-- {npc:268992} Zimmix Sputterspark
	["{npc:268992}, in his cage beside the third tablet"] = "{npc:268992}，在第三块石板旁的笼子里",
	-- {item:277957} Primitive Key
	["{item:277957}, from the Bloodscalp trolls"] = "{item:277957}：血顶巨魔掉落",
	-- {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["For {npc:4631} in {area:35}, at the end of this loop"] = "交给{area:35}的{npc:4631}，在这一圈结束时",

	-- Step 11: Sin'Dall on the raptor hill
	-- {npc:729} Sin'Dall
	["{npc:729} on the raptor hill"] = "",
	-- {npc:729} Sin'Dall
	["{npc:729} (37) prowls the hilltop."] = "",

	-- Step 12: The Lashtail raptors
	["The Lashtail raptors"] = "鞭尾迅猛龙",
	-- {quest:187} Tiger Mastery · {npc:729} Sin'Dall
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["East from the ruins, hunt Lashtail Raptors around the hill south-west of Nesingwary's camp. If you have {quest:187}, are at least 36 and see {npc:729} (37) alone, you can take her paw here or leave the hunt for your next visit."] = "",

	-- Step 13: Ajeck Rouack
	-- {npc:717} Ajeck Rouack
	["Hand the paw to {npc:717} beside Hemet."] = "",

	-- Step 14: Nesingwary's Expedition
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["{npc:715}: the Jungle Stalkers come in 40-50"] = "{npc:715}：丛林捕猎者留到40-50级",

	-- Step 15: Rebel Camp
	-- {area:99} Rebel Camp
	["North-east up the road to the {area:99}, then back south through the jungle."] = "沿路向东北前往{area:99}，然后穿过丛林返回南边。",
	-- {npc:733} Sergeant Yohwa
	["{npc:733}: the Commandos and Headshrinkers fell in the compound"] = "{npc:733}：特种兵和精神医师已经在营地击杀",
	-- plural, as words: Skullsplitter Witch Doctors = {npc:670} Skullsplitter Witch Doctor
	["keep it: the Skullsplitter Witch Doctors (41-42) wait for the 40-50 Stranglethorn guide"] = "保留它：劈颅巫医（41-42级）留给40-50级荆棘谷指南",

	-- Step 16: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "钳嘴鳄鱼",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to {area:35}."] = "钳嘴鳄鱼在丛林中央河流两侧晒太阳，向南前往{area:35}时会经过。",

	-- Step 17: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}：在屋内",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}，在旅店楼上",
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "交给{zone:1416}的大法师安斯雷姆",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}：在楼上",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}：在楼上",
	-- {npc:773} Krazek · {item:4278} Lesser Bloodstone Ore · {zone:1417} Arathi Highlands · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["{npc:773}, upstairs: this optional quest needs four {item:4278}. Mine Lesser Bloodstone Deposits in {zone:1417} with {skill:186} 75, or buy the ore at the Auction House or ask a miner friend. The kobolds do not drop it; skip this quest if you cannot get the ore."] = "{npc:773}在楼上：这个可选任务需要四块{item:4278}。在{zone:1417}用{skill:186} 75开采次级血石矿脉，或在拍卖行购买矿石，或请会采矿的朋友帮忙。狗头人不会掉落它；拿不到矿石就跳过这个任务。",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}：在屋内",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "“海狼”马克基雷，位于最顶层",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks"] = "{npc:4631}，在码头上",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East from the ruins to the hilltop south-west of Nesingwary's camp: the Lashtail Raptors run in the jungle around it. Leave {npc:729}, the great tiger (37) on the hilltop, to the 40-50 Stranglethorn guide: you're about 35 here. Then on to the hunters' tents."] = "从废墟向东前往奈辛瓦里营地西南的山顶：鞭尾迅猛龙在周围丛林中游荡。山顶上的大老虎{npc:729}（37级）留给40-50级荆棘谷指南：你现在大约35级。然后前往猎人的帐篷。",
	-- ["East to the {area:99}, on the way back to Nesingwary's camp."] = "向东前往{area:99}，顺路返回奈辛瓦里营地。",
	-- ["Follow the west coast north to the haunted island off the shore west of Nesingwary's camp: the Lesser Water Elementals rise from the water around it."] = "沿西海岸向北，前往赫米特·奈辛瓦里营地以西近海的闹鬼岛屿，次级水元素在周围水中出现。",
	-- ["For characters of 35 to 36, but several quests here are level 37-41: on purpose, for their experience. {quest:205}'s Skullsplitter trolls are 39-42, so pull them one at a time."] = "适合35到36级的角色，但这里有几个任务是37-41级：这是有意安排的，为了它们的经验值。{quest:205}的劈颅巨魔为39-42级，所以一次拉一只。",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}."] = "库尔森精神医师在营地深处；库尔森特种兵潜行在营地周围及洞内，赫罗德的保险箱在洞口旁。掉落《荆棘谷的青山》书页时记得拾取。\n小心：库尔森特种兵为34-35级，非精英，出现时经常处于潜行状态；濒死时会使用{spell:7964}。",
	-- ["Herod's records lie in a hut on the west side of {area:101}, east of the {area:99}."] = "赫罗德的档案在{area:101}西侧的一间小屋中，位于{area:99}以东。",
	-- ["Level 36"] = "等级 36",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "绕行北部和中部的巨魔废墟：每处都有一块记载巨魔传说的石板。深喉猎豹潜行在周围的丛林中；{area:37}的风险投资公司营地携带打磨过的水晶。",
	-- ["Mauren, from Stonetalon"] = "Mauren，从石爪山脉来的任务",
	-- ["North along the coast to the ruins on the hill: the last two tablets lie there. Pick up Green Hills pages as they drop."] = "沿海岸向北前往山丘上的废墟：最后两块石板就在那里。掉落《荆棘谷的青山》书页时记得拾取。",
	-- ["Skullsplitter trolls"] = "劈颅巨魔",
	-- ["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to the Skullsplitter ruins."] = "钳嘴鳄鱼在丛林中央河流两侧晒太阳，向南前往劈颅废墟时会经过。",
	-- ["South along the road: the hunters' tents stand just west of it."] = "沿路向南：猎人的帐篷就在道路西侧。",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals, and the Shadowmaw Panthers prowl stealthed in the jungle south and east of it."] = "从营地向南前往{area:37}：湖岸营地中的风险投资公司地质学家携带打磨过的水晶，深喉猎豹潜行在湖南边和东边的丛林中。",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals. Careful: Venture Co. Agents (39) walk among them: take the Geologists on the camps' edges, one at a time. Shadowmaw Panthers (37-38) prowl stealthed in the jungle south and east of the lake: keep to the shore camps."] = "从营地向南前往{area:37}：湖岸营地中的风险投资公司地质学家携带打磨过的水晶。小心：风险投资公司特工（39级）在他们中间走动：一次只打营地边缘的一个地质学家。深喉猎豹（37-38级）潜行在湖南边和东边的丛林中：沿湖岸营地行动。",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "劈颅巨魔占据奈辛瓦里和{object:3202}之间道路东边的废墟。",
	-- ["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west."] = "向西穿过丛林前往巨魔废墟：每处都有一块记载巨魔传说的石板，前两块在奈辛瓦里营地西南的废墟中，后两块在西北的山丘上。",
	-- ["grind on {npc:1152}"] = "刷{npc:1152}升级",
	-- ["{npc:717}, if 30-40/04 didn't give it: {npc:729}, in the 40-50 Stranglethorn guide"] = "{npc:717}，若30-40/04中未接取：{npc:729}，在40-50级荆棘谷指南中处理",
	-- ["{npc:718}: the Shadowmaw Panthers prowl around {area:37}, after {area:101}"] = "{npc:718}：完成{area:101}之后，深喉猎豹在{area:37}周围游荡",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}：交给{area:35}的{npc:773}",
	-- ["{npc:773}: the ore drops from Drywhisker kobolds in {zone:1417}, next"] = "{npc:773}：矿石由接下来{zone:1417}的枯须狗头人掉落",
	-- ["{quest:205}'s Skullsplitter trolls are 39-42. Below 36? Keep killing the Snapjaw Crocolisks along the river until level 36. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "{quest:205}所需的劈颅巨魔为39-42级。还没到36级？继续沿河刷钳嘴鳄鱼，直到36级。也可以组队去{area:796}副本（军械库）或{area:1316}副本。",
	-- ["{zone:1434}: kill these as you meet them"] = "{zone:1434}：沿途击杀以下目标",
}
