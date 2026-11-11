-- Chinese (simplified) (zhCN): the guide forever/class/warrior/haggards-weapons (forever/class/warrior/haggards-weapons.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a Weapon (Alliance)"] = "{spell:71}和一把武器（联盟）",
	-- {spell:71} Defensive Stance · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1457} Darnassus
	["{spell:71} at 10 and a one-hand weapon of your choice from {zone:1453}, {zone:1455} or {zone:1457}."] = "10级获得{spell:71}，并从{zone:1453}、{zone:1455}或{zone:1457}获得一把自选的单手武器。",

	-- Step 1: Seena Skybreaker in Valanaar
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} in {area:16638}"] = "{area:16638}的{npc:252377}",
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["At 10, {npc:252377} stands with the trainers by {area:16638}'s west gate. A cultist, {npc:257196}, holds her family's shield at the {area:16629}."] = "10级时，{npc:252377}与训练师们站在{area:16638}西门旁。教徒{npc:257196}在{area:16629}持有她家的盾牌。",

	-- Step 2: Zaal Stormshield
	-- {area:16638} Valanaar · {area:16629} Shrine of Akir · {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["Head north-west from {area:16638} to the {area:16629}. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "从 {area:16638} 向西北前往 {area:16629}。{npc:257196} 站在神殿入口通路的西侧，周围是教团的守护者、唤灵者和剑圣：先逐个拉出来清掉，再对付他。他会掉落 {item:263993}。",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}, from {npc:257196}"] = "{item:263993}，由{npc:257196}掉落",

	-- Step 3: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {spell:71} Defensive Stance · {item:275290} Stormforged Protector · {npc:6090} Bartleby · {zone:1453} Stormwind
	["Back to {npc:252377} in {area:16638}. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:6090}'s road below still gives a weapon, once you reach {zone:1453}."] = "返回 {area:16638} 的 {npc:252377} 处。她会教你 {spell:71}，并给你一面配套使用的盾牌 {item:275290}。等你抵达 {zone:1453} 后，下方 {npc:6090} 的任务路线仍可让你获取一把武器。",

	-- Step 4: Muren Stormpike
	-- {npc:1229} Granis Swiftaxe · {area:131} Kharanos · {quest:1679} Muren Stormpike · {zone:1455} Ironforge · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {quest:1638} A Warrior's Training
	["At 10, {npc:1229}, the warrior trainer in {area:131}, sends you to {quest:1679} in {zone:1455}. Any Alliance warrior may take one of the three roads, never two: in {zone:1453} at 10 anyway? {npc:5480}'s {quest:1638} is the quickest stance (one fight in a tavern), with a Haggard's weapon after it."] = "10 级时，{area:131} 的战士训练师 {npc:1229} 会让你去 {zone:1455} 找 {quest:1679}。任何联盟战士都可以选择三条路线中的一条，但不能同时选两条：如果 10 级时本来就在 {zone:1453}，{npc:5480} 的 {quest:1638} 能最快学会姿态（在酒馆打一架），之后还能拿到一件哈迦德难民的武器。",

	-- Step 5: Muren Stormpike in Ironforge
	-- {quest:1679} Muren Stormpike · {zone:1455} Ironforge
	["{quest:1679} in {zone:1455}"] = "{zone:1455} 的 {quest:1679}",
	-- {quest:1679} Muren Stormpike · {object:32390} Hall of Arms · {object:32359} Military Ward
	["{quest:1679} stands in the {object:32390} in the {object:32359}."] = "{quest:1679} 位于 {object:32359} 的 {object:32390} 内。",

	-- Step 6: Vejrek
	-- {quest:1678} Vejrek · {area:135} Frostmane Hold · {spell:71} Defensive Stance · {spell:6343} Thunder Clap
	["{quest:1678} (level 11, a lone troll) waits at his hut on a hill south of {area:135}, near the mountains at the top of a short ramp, with no other trolls around; the hut at the front of {area:135} is the wrong one. He fights in {spell:71} and sunders your armor; {spell:6343} slows him. His head always drops; he returns about 8 minutes after dying."] = "{quest:1678}（11级，独自一人的巨魔）在{area:135}南方山丘上的小屋等候，小屋靠近山脉，位于一段短坡的顶端，周围没有其他巨魔；{area:135}前方那间小屋不是。他使用{spell:71}作战，还会破甲；{spell:6343}能减慢他的攻击速度。他的头颅必定掉落；死后约八分钟刷新。",

	-- Step 7: Tormus Deepforge
	-- {npc:6114} Muren Stormpike · {spell:71} Defensive Stance · {quest:1680} Tormus Deepforge · {object:32372} Great Forge · {zone:1455} Ironforge
	["Back to {npc:6114} for {spell:71}, then to {quest:1680} at the {object:32372} in the middle of {zone:1455}."] = "返回{npc:6114}处学习{spell:71}，然后去{zone:1455}中央的{object:32372}找{quest:1680}。",

	-- Step 8: Ironband's Compound
	-- {quest:1681} Ironband's Compound · {zone:1426} Dun Morogh · {area:212} Helm's Bed Lake · {object:85562} Ironband's Strongbox · {npc:6124} Captain Beld
	["{quest:1681} lies in eastern {zone:1426}, below {area:212} on its south side. Dark Iron Spies (level 8-10) stand along the way, far enough apart to pull one at a time. {object:85562} is in the basement of the southernmost house; {npc:6124} (level 11) stands by it and charges on sight. The box always holds the ore and refills 15 minutes after opening."] = "{quest:1681} 位于 {zone:1426} 东部、{area:212} 南侧下方。沿途有黑铁间谍（8-10 级），间距足够逐个引来击杀。{object:85562} 在最南边房子的地下室里；{npc:6124}（11 级）站在旁边，看到你就会冲过来。箱子里必定有矿石，打开后 15 分钟重新补满。",
	-- {item:6800} Umbral Ore · {object:85562} Ironband's Strongbox
	["{item:6800}, from {object:85562}"] = "{item:6800}，来自 {object:85562}",

	-- Step 10: Elanaria
	-- {npc:3598} Kyra Windblade · {area:186} Dolanaar · {npc:2151} Moon Priestess Amara · {quest:1684} Elanaria · {area:1660} Warrior's Terrace · {zone:1457} Darnassus · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {quest:1638} A Warrior's Training
	["At 10, {npc:3598}, the warrior trainer in {area:186}, or {npc:2151}, who patrols the road west of {area:186}, sends you to {quest:1684} on the {area:1660} in {zone:1457}. Any Alliance warrior may take one of the three roads, never two: in {zone:1453} at 10 anyway? {npc:5480}'s {quest:1638} teaches the same stance after one fight in a tavern."] = "10 级时，{area:186} 的战士训练师 {npc:3598}，或在 {area:186} 西边道路巡逻的 {npc:2151}，会让你去 {zone:1457} 的 {area:1660} 找 {quest:1684}。任何联盟战士都可以选择三条路线中的一条，但不能同时选两条：如果 10 级时本来就在 {zone:1453}，做 {npc:5480} 的 {quest:1638}，在酒馆打一架就能学会相同的姿态。",

	-- Step 11: Elanaria in Darnassus
	-- {quest:1684} Elanaria · {zone:1457} Darnassus
	["{quest:1684} in {zone:1457}"] = "{zone:1457} 的 {quest:1684}",
	-- {quest:1684} Elanaria · {area:1660} Warrior's Terrace
	["{quest:1684} stands on the {area:1660}."] = "{quest:1684} 站在 {area:1660}。",

	-- Step 12: Vorlus Vilehoof
	-- {quest:1683} Vorlus Vilehoof · {area:186} Dolanaar
	["{quest:1683} (level 10, a satyr) stands at a hidden moonwell up a hillside west of {area:186}. The trail is hard to spot: it starts behind a Gnarlpine camp and climbs in switchbacks lined with lamp posts. The furbolgs below can come in groups. His horn always drops; he returns 5 minutes after dying."] = "{quest:1683}（10级，萨特）站在{area:186}西边山坡上一处隐蔽的月亮井旁。小路很难发现：起点在一个瘤背熊怪营地后方，沿着有灯柱的之字形山路向上。下面的熊怪可能成群出现。他的角必定掉落；死后五分钟刷新。",

	-- Step 14: Elunite under Auberdine
	-- {area:442} Auberdine
	["Elunite under {area:442}"] = "{area:442}水下的月神矿石",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {npc:6133} Shade of Elura
	["Take the boat from {area:702} to {area:442}. The wreck lies underwater just south of {area:442}'s southern pier, where the Menethil boat docks. Open Crates of Elunite on the sea floor around the wreck, by a huge sunken turtle, toward the beach and under the pier until you have eight; every crate holds ore and comes back in 3-5 minutes. The grey {npc:6133} (level 11) drifts around the middle of the wreck and always drops the medallion: target it when you see it, so you can find it after surfacing for air. Watch your breath; Threshers can join in."] = "从{area:702}乘船前往{area:442}。沉船在{area:442}南侧码头正南方的水下，米奈希尔来的船就停靠在这个码头。打开沉船周围海底、巨大沉没海龟旁、靠海滩方向及码头下的月神矿石箱，直到收集8块；每箱都有矿石，3-5分钟刷新。灰色的{npc:6133}（11级）在沉船中部附近漂浮，必定掉落勋章：看见时就选中它，方便上浮换气后再找到。留意呼吸时间；蛇颈龙可能加入战斗。",
	-- {item:6808} Elunite Ore
	["{item:6808}, from Crates of Elunite"] = "{item:6808}，从艾鲁尼特矿石箱中获得",
	-- {item:6809} Elura's Medallion · {npc:6133} Shade of Elura
	["{item:6809}, from the {npc:6133}"] = "{item:6809}，来自{npc:6133}",

	-- Step 15: Smith Mathiel
	-- {area:1660} Warrior's Terrace · {npc:4088} Elanaria · {item:6812} Case of Elunite · {npc:6142} Mathiel
	["Back on the {area:1660}: {npc:4088} hands you the {item:6812}; {npc:6142} works on the far, south side of the same terrace, easy to miss."] = "回到{area:1660}：{npc:4088}会给你{item:6812}；{npc:6142}在同一平台另一头的南侧工作，很容易错过。",

	-- Step 16: A Warrior's Training
	-- {npc:913} Lyria Du Lac · {area:87} Goldshire · {npc:6089} Harry Burlguard · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town
	["At 10, {npc:913}, the warrior trainer by the inn in {area:87}, sends you to {npc:6089} in {zone:1453}; {npc:5480}, the warrior trainer in {zone:1453}'s {object:2100}, offers it too."] = "10级时，{area:87}旅店旁的战士训练师{npc:913}会让你去找{zone:1453}的{npc:6089}；{zone:1453}的{object:2100}里的战士训练师{npc:5480}也提供此任务。",

	-- Step 17: Bartleby
	-- {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2100} Old Town · {quest:1638} A Warrior's Training · {npc:5480} Ilsa Corbin · {zone:1453} Stormwind
	["{npc:6089} and {npc:6090} are in the Pig and Whistle tavern in {object:2100}; {npc:6090} is the drunk at the far end of the bar. {npc:6090} (level 10) hits harder than his level, so start at full health; he gives up at low health instead of dying. If he wins, he disappears for about three minutes: keep the quest and talk to him again when he is back. A Dwarf, Gnome or Night Elf who took {quest:1638} from {npc:5480} instead of their home road is led through {zone:1453} from here."] = "{npc:6089} 和 {npc:6090} 都在 {object:2100} 的猪与哨声旅店中；{npc:6090} 是吧台最里端的酒鬼。{npc:6090}（10 级）的伤害高于同级怪物，因此要满血开战；他在生命值低时会认输，不会死亡。若他打赢了，会消失约三分钟：保留任务，等他回来后再交谈。若矮人、侏儒或暗夜精灵从 {npc:5480} 处接受了 {quest:1638}，而非走本族任务路线，从这里起会被引导经过 {zone:1453}。",

	-- Step 18: Marshal Haggard
	-- {npc:294} Marshal Haggard · {area:88} Eastvale Logging Camp
	["{npc:294}'s manor stands at the south-east edge of the {area:88} in eastern Elwynn, at the end of a short road that does not join the main one."] = "{npc:294} 的庄园位于艾尔文森林东部 {area:88} 的东南边缘，在一条不与主路相连的短路尽头。",

	-- Step 19: Dead-tooth Jack
	-- {npc:6093} Dead-Tooth Jack · {item:6783} Dead-tooth's Key · {object:85563} Dead-tooth's Strongbox · {item:6782} Marshal Haggard's Badge
	["{npc:6093} (level 11) camps in the far south-east of Elwynn. A guard stands beside him and Defias and wolves are spread around the camp (now and then a rarer guard too): clear them one at a time, then kill Jack. He always drops {item:6783}; open {object:85563} in the crates by him for {item:6782}. Jack returns 3 minutes after dying, the box 1 minute after opening."] = "{npc:6093}（11级）在艾尔文森林最东南方扎营。他身边有一名守卫，营地周围散布着迪菲亚成员和狼（偶尔还有一名较稀有的守卫）：逐个清理，再击杀杰克。他必定掉落 {item:6783}；打开他身旁货箱中的 {object:85563}，取得 {item:6782}。杰克死亡3分钟后刷新，箱子开启1分钟后刷新。",
	-- {npc:6093} Dead-Tooth Jack
	["from {npc:6093}"] = "由 {npc:6093} 掉落",
	-- {item:6782} Marshal Haggard's Badge · {object:85563} Dead-tooth's Strongbox
	["{item:6782}, from {object:85563}"] = "{item:6782}，来自 {object:85563}",

	-- Step 20: Back to Marshal Haggard
	-- {npc:294} Marshal Haggard
	["Back to {npc:294}"] = "回到{npc:294}处",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Haggard's Weapons"] = "哈迦德的武器",
	-- ["{npc:294}'s house is in eastern {zone:1429}, south of the road from {zone:1453} to Redridge."] = "{npc:294}的房子在{zone:1429}东部，位于{zone:1453}通往赤脊山的道路以南。",
	-- ["{npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为他的杯子和你打一架。",
	-- ["{npc:6093} camps in the far south-east of {zone:1429}, south-east of {npc:294}. He carries the key to the strongbox in his camp."] = "{npc:6093}在{zone:1429}最东南端扎营，位于{npc:294}东南。他带着营地里保险箱的钥匙。",
	-- ["{npc:6093}: his key opens the strongbox"] = "{npc:6093}：他的钥匙能打开保险箱",
	-- ["{spell:71} and a one-hand weapon of your choice at 10."] = "10级获得{spell:71}和一把自选的单手武器。",
}
