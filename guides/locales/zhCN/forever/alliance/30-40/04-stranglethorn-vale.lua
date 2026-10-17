-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ironforge
	-- {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:150} to {area:1537} and train."] = "从{area:150}飞往{area:1537}并训练。",

	-- Step 2: Druid training
	["Druid training"] = "德鲁伊训练",
	-- {area:1537} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {npc:5504} Sheldras Moontree
	["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537}没有德鲁伊训练师：从{object:171524}乘{area:2257}前往{zone:1453}，找{npc:5504}训练。",

	-- Step 3: Darkshire
	-- {area:42} Darkshire · {npc:1573} Gryth Thurden · {area:1537} Ironforge · {object:32372} Great Forge · {npc:352} Dungar Longdrink · {zone:1453} Stormwind · {object:2096} Trade District
	["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "飞往{area:42}：{area:1537}{object:32372}的{npc:1573}，或{zone:1453}{object:2096}的{npc:352}。",

	-- Step 4: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "从{zone:1431}沿道路向南进入荆棘谷；猎人的帐篷就在经过{area:99}岔路后道路的西边。",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}，来自{zone:1441}",

	-- Step 5: Young tigers and panthers
	["Young tigers and panthers"] = "荆棘谷猛虎幼崽和猎豹幼崽",
	["Both roam the grass around the camp and along the road north."] = "两者都在营地周围的草地和向北的道路沿途游荡。",

	-- Step 7: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "荆棘谷猛虎",
	["The adult tigers prowl the hills just south and west of the camp."] = "成年猛虎在营地南边和西边的山丘上徘徊。",

	-- Step 8: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "老年猛虎稍后再打，在从{area:99}返回的路上",

	-- Step 9: Rebel Camp
	-- {npc:738} Private Thorsen
	["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "沿道路向北；{npc:738}站在路上，营地在西边的山丘中。",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}，在小屋里",

	-- Step 10: Kurzen's Compound
	-- {area:99} Rebel Camp
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "库尔森叛军占据{area:99}东边的营地；在外围活动，那里有库尔森丛林战士和库尔森药草师，并拾取帐篷旁的补给箱。",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}，来自{object:263}箱子",

	-- Step 11: Bookie Herod
	["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "赫罗德的档案在营地西侧的一间小屋里；他的保险箱在更东边的洞口旁。",

	-- Step 13: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "猎豹、迅猛龙和老年猛虎",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "向南返回经过奈辛瓦里：黑豹和荆棘谷迅猛龙在营地西边通往海岸的空地上奔跑；老年荆棘谷猛虎占据西南方的山丘。",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "戈鲁格尔是营地西边海岸的一只稀有鱼人，掉落{item:4614}：遇到就拿",

	-- Step 15: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729}和鞭尾迅猛龙",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "大老虎{npc:729}的巢穴在营地西南方的山顶；鞭尾迅猛龙在其南边、通往{area:35}的路上奔跑。",

	-- Step 16: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "南下{area:35}",
	-- {object:3202} Grom'gol · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "沿主路向南穿过整片丛林，经过{object:3202}岔路，到达南部海角的{area:35}。",
	["Gyll, on the top floor by the docks"] = "盖尔，在码头旁的顶楼",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}"] = "{npc:2832}，在{object:56910}",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank"] = "{npc:2495}，在银行旁",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern"] = "{npc:773}，在旅店里",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}，在旅店里",

	-- Step 17: Crystalvein Mine
	-- {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "向北走回去；{area:310}在丛林中部道路的西边。那里的晶背蜥蜴掉落碎片。",

	-- Step 18: Bloodscalp trolls
	["Bloodscalp trolls"] = "血顶巨魔",
	["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "血顶巨魔占据奈辛瓦里营地西边海岸上的废墟。",

	-- Step 19: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}：在猎人营地四处看看即可",

	-- Step 20: Private Thorsen
	-- {area:99} Rebel Camp
	["Thorsen patrols the road north of camp, toward the {area:99}."] = "索森在营地北边、通往{area:99}的道路上巡逻。",

	-- Step 21: River crocolisks
	["River crocolisks"] = "淡水鳄",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "淡水鳄在{area:99}旁的河中游动。",

	-- Step 23: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "钳嘴鳄鱼",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "钳嘴鳄鱼趴在{area:35}北边沿海的岸边和岛上。",

	-- Step 24: Booty Bay
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}，在旅店楼上",

	-- Step 25: The haunted island
	["The haunted island"] = "闹鬼的小岛",
	["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "沿西海岸向北；闹鬼的小岛在奈辛瓦里营地西边的近海。到达即可。",

	-- Step 26: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716}收集{item:2755}：丛林中几乎所有人型怪都会掉落书页。边走边把书页合成章节。",

	-- Step 28: Kurzen's Compound
	["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "库尔森精神医师在营地深处；库尔森特种兵潜行在营地周围和洞穴中。掉落的荆棘谷的青山书页顺手拾取。",

	-- Step 29: The jungle ruins
	["The jungle ruins"] = "丛林废墟",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "绕行北部和中部的巨魔废墟：每处都有一块记载巨魔传说的石板。深喉猎豹潜行在周围的丛林中；{area:37}的风险投资公司营地携带打磨过的水晶。",
	-- {quest:207} Kurzen's Mystery
	["{quest:207}: four troll legends"] = "{quest:207}：四个巨魔传说",

	-- Step 30: Rebel Camp
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}：交给{area:35}的{npc:773}",

	-- Step 32: Skullsplitter trolls
	["Skullsplitter trolls"] = "劈颅巨魔",
	-- {object:3202} Grom'gol
	["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "劈颅巨魔占据奈辛瓦里和{object:3202}之间道路东边的废墟。",

	-- Step 34: Booty Bay
	-- {zone:1417} Arathi Highlands
	["The ore drops from Drywhisker kobolds in {zone:1417}"] = "矿石由{zone:1417}的枯须狗头人掉落",

	-- Step 36: Baron Revilgaz
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "交给{zone:1416}的大法师安斯雷姆",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}，在{object:56910}",
}
