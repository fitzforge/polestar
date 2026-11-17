-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "乘船前往{area:35}",
	-- {area:392} Ratchet · {area:35} Booty Bay
	["The boat from {area:392}'s dock crosses to {area:35}, on Stranglethorn's southern cape."] = "",

	-- Step 2: Booty Bay
	["Bind your hearthstone at the inn: it is your way back here from the north of the jungle at the end of the loop."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank; inside"] = "{npc:2495}，位于银行旁的屋内",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}：在屋内",
	-- {npc:6807} Innkeeper Skindle · {object:56910} The Salty Sailor Tavern
	["{npc:6807}, {object:56910}; upstairs"] = "{npc:6807}，位于{object:56910}楼上",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}; upstairs"] = "{npc:2832}，位于{object:56910}楼上",
	-- {npc:773} Krazek · {npc:738} Private Thorsen · {area:99} Rebel Camp
	["{npc:773}, in the tavern; upstairs: {npc:738} is at the {area:99}, on the way"] = "",
	-- {npc:773} Krazek
	["{npc:773}: Nesingwary's camp, on the way"] = "",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}，在旅店里",
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["{npc:737}: the Tumbled Crystals, on the northern loop"] = "{npc:737}：打磨过的水晶，北部路线会去收集",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}，在旅店楼上",

	-- Step 3: North to Nesingwary's Expedition
	-- {area:100} Nesingwary's Expedition
	["North to {area:100}"] = "",
	-- {object:3202} Grom'gol
	["Follow the main road north the length of the jungle, past the {object:3202} turn-off, to the hunters' camp just west of the road."] = "",

	-- Step 4: Nesingwary's Expedition
	-- {npc:773} Krazek · {quest:201} Investigate the Camp
	["The hunters' tents stand just west of the road. {npc:773}'s {quest:201} only asks you to look around it."] = "",
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}：在猎人营地四处看看即可",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}，来自{zone:1441}",

	-- Step 5: Young tigers and panthers
	["Young tigers and panthers"] = "荆棘谷猛虎幼崽和猎豹幼崽",
	["Both roam the grass around the camp and along the road north."] = "两者都在营地周围的草地和向北的道路沿途游荡。",

	-- Step 6: River crocolisks
	["River crocolisks"] = "淡水鳄",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks (30-31) swim the river right beside Nesingwary's camp and up toward the {area:99}."] = "",

	-- Step 10: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "荆棘谷猛虎",
	["The adult tigers prowl the hills just south and west of the camp."] = "成年猛虎在营地南边和西边的山丘上徘徊。",

	-- Step 11: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "老年猛虎稍后再打，在从{area:99}返回的路上",

	-- Step 12: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "猎豹、迅猛龙和老年猛虎",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "向南返回经过奈辛瓦里：黑豹和荆棘谷迅猛龙在营地西边通往海岸的空地上奔跑；老年荆棘谷猛虎占据西南方的山丘。",
	-- {item:4614} Pendant of Myzrael
	["Gluggle (37, rare) on the coast west of camp drops the {item:4614}: four levels over you, leave him unless you are grouped"] = "戈鲁格尔（37级，稀有）在营地西边海岸，掉落{item:4614}：比你高四级，除非组队否则别惹他",
	-- {object:661516} Thoroughly Scavenged Supplies (no name in this language: may be words)
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["{object:661516}, a looted crate west of Nesingwary's camp: the Stolen Shipments lie in the Bloodscalp ruins on the coast, for the second Stranglethorn loop"] = "{object:661516}，奈辛瓦里营地西边一个被洗劫过的箱子：被盗的货物在海岸边的血顶废墟中，第二轮荆棘谷路线再去",

	-- Step 13: Sir S. J. Erlgadin
	-- {area:99} Rebel Camp
	["Back east to Nesingwary's camp on the way north to the {area:99}."] = "向东返回奈辛瓦里的营地，再向北前往{area:99}。",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["keep it: the Shadowmaw Panthers (37-38) wait for the 40-50 Stranglethorn guide"] = "保留任务：深喉猎豹（37-38级）留到40-50级荆棘谷指南",

	-- Step 14: Rebel Camp
	-- {npc:738} Private Thorsen · {quest:215} Jungle Secrets · {quest:200} Bookie Herod · {area:99} Rebel Camp
	-- plural, as words: Kurzen's Agents = {npc:775} Kurzen's Agent
	["Take the road north; the camp sits in the hills to the west.\n{npc:738} offers {quest:215} only while he is out of the camp: about every half hour he walks down the path to the road, where two Kurzen's Agents ambush him. Help him kill them and take the quest at once, before he walks back up. He isn't there? Leave it: the guide passes {quest:200}, which follows from it, as well.\n{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "",
	-- {npc:738} Private Thorsen
	["{npc:738}, at the foot of the path"] = "{npc:738}，在小路下端",
	-- {npc:738} Private Thorsen
	["{npc:738}: at the top of the path by the huts, or on his walk down it"] = "",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}，在小屋里",
	-- {npc:469} Lieutenant Doren · {quest:200} Bookie Herod · {area:101} Kurzen's Compound
	["{npc:469}: {quest:200}'s records lie at the edge of {area:101}, next"] = "{npc:469}：{quest:200}的记录在{area:101}边缘，下一步就去",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}, later in this guide"] = "{npc:770}：带给{area:35}的{npc:773}，本指南稍后会到那里",

	-- Step 15: Kurzen's Compound: kill these as you meet them
	-- {area:101} Kurzen's Compound
	["{area:101}: kill these as you meet them"] = "{area:101}：沿途击杀以下目标",
	-- {area:99} Rebel Camp · {quest:200} Bookie Herod
	-- plural, as words: Kurzen Elites = {npc:939} Kurzen Elite
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents. {quest:200}'s records lie in a hut on the compound's west side. Careful: Kurzen Elites and Witch Doctors (36) hold the compound's eastern half, by the cave: stay on its west side."] = "库尔森叛军占据{area:99}东边的营地；在外围击杀库尔森丛林战士和库尔森药草师，并拾取帐篷旁的补给箱。{quest:200}所需的记录在营地西侧的小屋内。小心：库尔森精英和库尔森巫医（36级）占据营地东半部、洞穴旁边：待在营地西侧。",
	-- {object:287} Bookie Herod's Records
	["{object:287}, in the hut"] = "{object:287}，在小屋里",
	["The strongbox is deeper in, by the cave: on the northern loop (04b)"] = "保险箱在更深处的洞穴旁，北部环线（04b）会去取",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}，来自{object:263}箱子",

	-- Step 16: Level 33.2
	["Level 33.2"] = "33.2级",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Kurzen Jungle Fighters = {npc:937} Kurzen Jungle Fighter
	["The elder tigers next are 34-35: short of 33.2? Keep on the Kurzen Jungle Fighters and Medicine Men around the compound's outer edge until level 33.2. Or, with a group, run the {area:796} dungeon (Library) instead."] = "接下来的老年猛虎为34-35级：还没到33.2级？继续击杀营地外围的库尔森丛林战士和库尔森药草师，直到33.2级。也可组队挑战{area:796}地下城（图书馆）。",
	-- {npc:937} Kurzen Jungle Fighter
	["grind on {npc:937}"] = "击杀{npc:937}刷经验",

	-- Step 18: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434}：沿途击杀以下目标",
	["Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "注意：老虎活动区域附近有巨魔营地，拉怪不慎可能引来巨魔。\n注意：迅猛龙巢穴中的幼龙会在成年迅猛龙遭攻击时加入战斗。",

	-- Step 19: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716}收集{item:2755}：丛林中几乎所有人型怪都会掉落书页。边走边把书页合成章节。",
	-- {npc:729} Sin'Dall
	["keep it: {npc:729} (37) comes in the 40-50 Stranglethorn guide, at about 41"] = "保留任务：{npc:729}（37级）在40-50级荆棘谷指南中处理，约41级时",
	-- {npc:729} Sin'Dall
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["keep it: the Lashtail Raptors come on the second loop (04b), around {npc:729}'s hill"] = "保留任务：鞭尾迅猛龙在第二轮路线（04b）中处理，位于{npc:729}所在的山丘周围",

	-- Step 20: The Savage Coast
	-- {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk · Lesser Water Elementals = {npc:691} Lesser Water Elemental
	-- was: ["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach its edge. Careful: its Lesser Water Elementals are 36-37: don't stay. The Bloodscalp ruins of Zul'Kunda to the north wait for the second Stranglethorn loop."] = "从{area:108}向南离开{zone:1436}，进入荆棘谷西北部，前往海岸附近的{area:310}；周围的晶背蜥蜴会掉落碎片。\n闹鬼的岛屿就在矿洞西南边的近海，只需抵达其边缘即可。注意：岛上的次级水元素为36-37级：不要逗留。北边的血顶巨魔废墟祖昆达留到第二轮荆棘谷路线。"
	["From Nesingwary's camp head west to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach its edge. Careful: its Lesser Water Elementals are 36-37: don't stay. The Bloodscalp ruins of Zul'Kunda to the north wait for the second Stranglethorn loop."] = "",
	["The haunted island"] = "闹鬼的小岛",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay
	["Hearth back to {area:35}."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}：在屋内",
	-- {npc:2495} Drizzlik
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{npc:2495}: the Snapjaw Crocolisks, on the northern loop"] = "{npc:2495}：钳嘴鳄鱼，北部路线会去击杀",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}：在楼上",
	-- {npc:773} Krazek · {npc:770} Corporal Kaleb
	["{npc:773}, from {npc:770}"] = "{npc:773}：{npc:770}交代的任务",
	-- {npc:737} Kebok
	["{npc:737}'s Bloodscalp ears wait for the second Stranglethorn loop: keep the quest."] = "{npc:737}的血顶耳朵留到第二轮荆棘谷路线：保留任务。",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}: the water elementals rise around the haunted island, on the northern loop"] = "{npc:2496}：水元素出没于闹鬼岛屿周围，北部路线会去",

	-- Step 22: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飞往{zone:1453}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35}的飞行管理员",

	-- Step 24: Collin Mauren
	-- {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:4078} is in the {object:2164}, in the {object:2101}."] = "{npc:4078}在{object:2101}的{object:2164}里。",

	-- Step 25: Class training
	["Class training"] = "职业训练",
	-- {object:2096} Trade District · {object:2100} Old Town · {object:2101} Mage Quarter · {npc:5504} Sheldras Moontree · {zone:1455} Ironforge
	["Your level 34 ranks: the class trainers stand around the {object:2096}, {object:2100}, the Cathedral and the {object:2101}; {npc:5504}, the druid trainer, stands north-west of the {object:2101}. Shamans train in {zone:1455}, later in 30-40."] = "学习34级技能：职业训练师分布在{object:2096}、{object:2100}、大教堂和{object:2101}周围；德鲁伊训练师{npc:5504}在{object:2101}西北边。萨满祭司在{zone:1455}训练，在30-40级后段。",

	-- Step 27: Fly to Stonetalon Peak
	-- {area:467} Stonetalon Peak
	["Fly to {area:467}"] = "飞往{area:467}",
	-- {area:467} Stonetalon Peak · {zone:1443} Desolace · {area:415} Astranaar · {area:465} Charred Vale
	["You know the {area:467} flight: it lands closer to {zone:1443} than {area:415} does. From the peak, follow the road south through the mountains to the {area:465}."] = "你已有{area:467}的飞行路线：它比{area:415}离{zone:1443}更近。从山峰沿道路向南穿过群山，前往{area:465}。",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "{area:442}的飞行管理员",

	-- Step 28: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "飞往{area:415}",

	-- Step 29: Fly to Astranaar
	-- {area:415} Astranaar · {quest:1738} Heartswood
	["Warlocks fly to {area:415} for the {quest:1738}, on the way west."] = "术士在西行途中飞往{area:415}完成{quest:1738}。",

	-- Step 30: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["From {area:415} head north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then take the road west to Stonetalon."] = "从{area:415}向西北进入丘陵：{quest:1738}是一棵发光的树，位于通往{area:413}的道路北边。如果接了{quest:65602}，{item:190309}就在{area:413}北边林间的一间房子里（26.6,22.0）。然后沿路向西前往石爪山。",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}，在{area:413}北边",

	-- Step 31: Stonetalon Mountains
	-- {area:608} Nijel's Point
	["The road to {area:608}"] = "通往{area:608}的道路",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bloodscalp trolls"] = "血顶巨魔",
	-- ["Down to {area:35}"] = "南下{area:35}",
	-- ["East of Zul'Kunda"] = "祖昆达以东",
	-- ["Fly from {area:150} to {area:1537} and train."] = "从{area:150}飞往{area:1537}并训练。",
	-- ["Fly to {area:108}"] = "飞往{area:108}",
	-- ["Fly to {area:42}"] = "飞往{area:42}",
	-- ["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "飞往{area:42}：{area:1537}{object:32372}的{npc:1573}，或{zone:1453}{object:2096}的{npc:352}。",
	-- ["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "沿主路向南穿过整片丛林，经过{object:3202}岔路，到达南部海角的{area:35}。",
	-- ["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape. Bind your hearthstone at the inn: it is your way back here from Nesingwary's camp at the end of the jungle loop."] = "沿主路向南穿过整片丛林，经过{object:3202}岔路，到达南部海角的{area:35}。在旅店绑定炉石：丛林路线结束时，你要从奈辛瓦里营地用它回到这里。",
	-- ["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "沿西海岸向北；闹鬼的小岛在奈辛瓦里营地西边的近海。到达即可。",
	-- ["For Archmage Ansirem in {zone:1416}"] = "交给{zone:1416}的大法师安斯雷姆",
	-- ["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach it. The Bloodscalp trolls hold the ruins on the coast to the north."] = "从{area:108}向南离开{zone:1436}，进入荆棘谷西北部，前往海岸附近的{area:310}；周围的晶背蜥蜴会掉落碎片。\n闹鬼的岛屿就在矿洞西南边的近海，只需抵达即可。血顶巨魔占据了北边海岸上的废墟。",
	-- ["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach its edge. Careful: its Lesser Water Elementals are 36-37: don't stay. The Bloodscalp ruins of Zul'Kunda to the north wait for the second Stranglethorn loop."] = "从{area:108}向南离开{zone:1436}，进入荆棘谷西北部，前往海岸附近的{area:310}；周围的晶背蜥蜴会掉落碎片。\n闹鬼的岛屿就在矿洞西南边的近海，只需抵达其边缘即可。注意：岛上的次级水元素为36-37级：不要逗留。北边的血顶巨魔废墟祖昆达留到第二轮荆棘谷路线。",
	-- ["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "从{zone:1431}沿道路向南进入荆棘谷；猎人的帐篷就在经过{area:99}岔路后道路的西边。",
	-- ["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "戈鲁格尔是营地西边海岸的一只稀有鱼人，掉落{item:4614}：遇到就拿",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "库尔森精神医师在营地深处；库尔森特种兵潜行在营地周围和洞穴中。掉落的荆棘谷的青山书页顺手拾取。",
	-- ["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "赫罗德的档案在营地西侧的一间小屋里；他的保险箱在更东边的洞口旁。",
	-- ["Level 33.6"] = "33.6级",
	-- ["Level 34"] = "34级",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "绕行北部和中部的巨魔废墟：每处都有一块记载巨魔传说的石板。深喉猎豹潜行在周围的丛林中；{area:37}的风险投资公司营地携带打磨过的水晶。",
	-- ["River Crocolisks swim the river by the {area:99}."] = "淡水鳄在{area:99}旁的河中游动。",
	-- ["Short of 33.6? Keep on the Kurzen Jungle Fighters and Medicine Men around the compound's outer edge until level 33.6. Or, with a group, run the {area:796} dungeon (Library) instead."] = "还没到33.6级？继续击杀营地外围的库尔森丛林战士和库尔森药草师，直到33.6级。也可组队挑战{area:796}副本（图书馆）。",
	-- ["Skullsplitter trolls"] = "劈颅巨魔",
	-- ["Snapjaw Crocolisks"] = "钳嘴鳄鱼",
	-- ["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "钳嘴鳄鱼趴在{area:35}北边沿海的岸边和岛上。",
	-- ["Take the road north; the camp sits in the hills to the west.\n{npc:738} offers {quest:215} only while he is out of the camp: about every half hour he walks down the path to the road, where two Kurzen's Agents ambush him. Help him kill them and take the quest at once, before he walks back up. He isn't there? Leave it: the guide passes {quest:200}, which follows from it, as well."] = "沿道路向北；营地在西边的山丘中。\n{npc:738}只有在营地外时才会提供{quest:215}：他大约每半小时沿小路走到大路上，两名库尔森的密探会在那里伏击他。帮他杀掉他们，并在他走回去之前立刻接下任务。他不在？那就算了：指南也会跳过由此引出的{quest:200}。",
	-- ["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "沿道路向北；{npc:738}在路上巡逻，营地在西边的山丘中。",
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "沿道路向北；{npc:738}站在路上，营地在西边的山丘中。",
	-- ["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "血顶巨魔占据奈辛瓦里营地西边海岸上的废墟。",
	-- ["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "库尔森叛军占据{area:99}东边的营地；在外围活动，那里有库尔森丛林战士和库尔森药草师，并拾取帐篷旁的补给箱。",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "劈颅巨魔占据奈辛瓦里和{object:3202}之间道路东边的废墟。",
	-- ["The jungle ruins"] = "丛林废墟",
	-- ["The jungle's quests climb to 37 from here: short of 33.2? Keep on the Stranglethorn Tigers in the hills just south and west of the camp until level 33.2. Or, with a group, run the {area:796} dungeon (Library) instead."] = "从这里起，丛林里的任务等级逐渐升至37级：还没到33.2级？继续击杀营地正南方和西侧山丘上的荆棘谷猛虎，直到33.2级。也可组队挑战{area:796}副本的图书馆。",
	-- ["The ore drops from Drywhisker kobolds in {zone:1417}"] = "矿石由{zone:1417}的枯须狗头人掉落",
	-- ["The quests from here on are 37: if you are short of 34, keep on the elder tigers in the hills south-west of Nesingwary's camp until level 34. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "接下来的任务为37级；如果还没到34级，就继续击杀奈辛瓦里营地西南丘陵中的老年猛虎，直到34级。也可组队挑战{area:796}副本（图书馆或武器库）。",
	-- ["Thorsen patrols the road north of camp, toward the {area:99}."] = "索森在营地北边、通往{area:99}的道路上巡逻。",
	-- ["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "向北走回去；{area:310}在丛林中部道路的西边。那里的晶背蜥蜴掉落碎片。",
	-- ["grind on {npc:1085}"] = "刷{npc:1085}升级",
	-- ["grind on {npc:682}"] = "击杀{npc:682}刷经验",
	-- ["{area:150} flight master"] = "{area:150}的飞行管理员",
	-- ["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537}没有德鲁伊训练师：从{object:171524}乘{area:2257}前往{zone:1453}，找{npc:5504}训练。",
	-- ["{area:301}: kill these as you meet them"] = "{area:301}：沿途击杀以下目标",
	-- ["{area:33}: kill these as you meet them"] = "{area:33}：沿途击杀以下目标",
	-- ["{npc:2495}, by the bank"] = "{npc:2495}，在银行旁",
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}，在{object:56910}",
	-- ["{npc:2859}, on the top floor by the docks"] = "{npc:2859}，在码头旁的顶楼",
	-- ["{npc:469}: {quest:200}'s records, on the northern loop (04b)"] = "{npc:469}：{quest:200}的记录，北部路线会去取（04b）",
	-- ["{npc:729} and the Lashtail raptors"] = "{npc:729}和鞭尾迅猛龙",
	-- ["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "大老虎{npc:729}的巢穴在营地西南方的山顶；鞭尾迅猛龙在其南边、通往{area:35}的路上奔跑。",
	-- ["{npc:737}, upstairs"] = "{npc:737}：在楼上",
	-- ["{npc:737}: the Tumbled Crystals, on the northern loop"] = "{npc:737}：打磨过的水晶，北部路线会去收集",
	-- ["{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "{npc:738}大部分时间在{area:99}坡道顶端的小屋旁，偶尔会沿坡道走到大路上再返回（约八分钟）。箭头处找不到他时，沿这条坡道寻找。",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}：交给{area:35}的{npc:773}",
	-- ["{npc:773}, in the tavern"] = "{npc:773}，在旅店里",
	-- ["{npc:773}, in the tavern; upstairs"] = "{npc:773}，位于旅店楼上",
	-- ["{quest:207}: four troll legends"] = "{quest:207}：四个巨魔传说",
}
