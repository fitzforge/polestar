-- Chinese (simplified) (zhCN): the guide forever/class/warrior/fire-hardened-armor (forever/class/warrior/fire-hardened-armor.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Fire Hardened Armor"] = "淬火护甲",
	["Starts now at 20 with a shield; a hauberk at 28, then a coif, leggings and gauntlets from three smiths."] = "",

	-- Step 1: Yorus Barleybrew (Stormwind)
	-- {npc:5479} Wu Shen · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5479}, beside {npc:5480} in the warrior trainers' building of {object:2100}, sends you to {quest:1698} in Redridge."] = "达到 20 级后，{object:2100} 战士训练师建筑内、{npc:5480} 旁的 {npc:5479} 会让你前往赤脊山处理 {quest:1698}。",

	-- Step 2: Yorus Barleybrew (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {quest:1698} in Redridge."] = "20级时，{zone:1455}的战士训练师{npc:5113}会让你去赤脊山找{quest:1698}。",

	-- Step 3: Yorus Barleybrew (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {quest:1698} Yorus Barleybrew
	["At 20, {npc:7315}, the warrior trainer of {zone:1457}, sends you to {quest:1698} in Redridge."] = "20级时，{zone:1457}的战士训练师{npc:7315}会让你去赤脊山找{quest:1698}。",

	-- Step 4: Yorus Barleybrew
	-- {quest:1698} Yorus Barleybrew · {area:69} Lakeshire · {area:98} Rethban Caverns
	["{quest:1698} sits in the inn at {area:69}. His test is timed: before you take it, clear the Redridge gnolls on the path to the {area:98} in the hills north-west of {area:69}, including the two on the rock by the cave mouth (climb it from its right side)."] = "{quest:1698} 坐在 {area:69} 的旅店内。他的测试有时间限制：接任务前，先清掉通往 {area:69} 西北山中 {area:98} 的小路上的赤脊山豺狼人，包括洞口旁石头上的两只（从石头右侧爬上去）。",

	-- Step 5: The Rethban Gauntlet
	-- {npc:6166} Yorus Barleybrew · {spell:8553} Barleybrew Scalder · {area:98} Rethban Caverns · {area:69} Lakeshire
	["You have one hour, and {npc:6166}'s {spell:8553} leaves you drunk for 8-10 minutes. Run north-west into the {area:98}, keeping close to the cliff wall to miss most gnoll packs, and go in as far as the first fork; then come back to {npc:6166} (from the ridge you can jump down into {area:69}). Dying and releasing your spirit fails the quest: abandon it and {npc:6166} gives it again."] = "你有一小时，且{npc:6166}的{spell:8553}会让你醉上8-10分钟。向西北跑进{area:98}，紧贴崖壁避开大部分豺狼人群，深入至第一个岔路口即可；然后回到{npc:6166}处（可从山脊跳下到{area:69}）。死亡后释放灵魂会使任务失败：放弃任务，{npc:6166}会再次提供。",
	-- {area:98} Rethban Caverns
	["Enter the {area:98} and come back"] = "进入{area:98}后返回",

	-- Step 6: The Shieldsmith
	-- {npc:5413} Furen Longbeard · {item:6843} Cask of Scalder · {npc:6166} Yorus Barleybrew · {item:6970} Furen's Favor · {quest:1701} Fire Hardened Mail · {item:6842} Furen's Instructions
	["{npc:5413} works in the Dwarven District of Stormwind. He takes the {item:6843} (lost it? abandon the quest and {npc:6166} gives a new one) and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest, with {item:6842} listing what it needs."] = "{npc:5413}在暴风城矮人区工作。他会收下{item:6843}（弄丢了？放弃任务，{npc:6166}会再给一个），并给你盾牌{item:6970}；{quest:1701}是28级任务，所需材料列在{item:6842}上。",

	-- Step 7: Scorched Spider Fangs
	-- plural, as words: Scorched Spider Fangs = {item:6838} Scorched Spider Fang
	["Scorched Spider Fangs"] = "{item:6838}",
	-- {zone:1437} Wetlands · {area:836} Dun Algaz
	-- plural, as words: Leech Stalkers = {npc:1111} Leech Stalker · Cave Stalkers = {npc:4040} Cave Stalker
	["You need 50 fangs. The Leech Stalkers and Cave Stalkers (level 21-22) crawl in the middle of the {zone:1437}, north of {area:836}; every one drops a fang. They poison; back in 5 minutes."] = "需要50颗毒牙。吸血捕猎者和洞穴捕猎者（21-22级）在{zone:1437}中部、{area:836}以北爬行；每只必掉一颗毒牙。它们会施毒；五分钟后刷新。",

	-- Step 8: Charred and Galvanized Horns
	-- plural, as words: Galvanized Horns = {item:6840} Galvanized Horn
	["Charred and Galvanized Horns"] = "烧焦的奇美拉角和{item:6840}",
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch · {spell:3396} Corrosive Poison · {spell:403} Lightning Bolt · {area:467} Stonetalon Peak
	-- plural, as words: Charred Horns = {item:6839} Charred Horn · Young Chimaeras = {npc:4032} Young Chimaera
	["The chimaeras live south-west of {area:460} in the {area:465}: you need 12 Charred Horns from the Fledgling (level 25-27) and Young Chimaeras (23-25), four kills in five, and the {item:6840} from the {npc:6167} (28, the big one), also four in five. Only three Fledglings, two Young and one Matriarch live there, each back in 5 minutes, so expect to wait. Fledglings and the Matriarch spit {spell:3396}, the Young cast {spell:403}. Alliance: fly to {area:467} and head south."] = "奇美拉生活在{area:460}西南方的{area:465}：你需要从奇美拉雏兽（25-27级）和奇美拉幼崽（23-25级）身上取得12个烧焦的奇美拉角，掉率为五只出四个；还需要从{npc:6167}（28级，体型最大的那只）身上取得{item:6840}，掉率同样为五只出四个。那里只有三只奇美拉雏兽、两只幼崽和一只雌兽，每只五分钟刷新，因此要做好等待的准备。奇美拉雏兽和雌兽会喷吐{spell:3396}，幼崽会施放{spell:403}。联盟：飞往{area:467}后向南走。",
	-- {item:6839} Charred Horn
	["{item:6839}, from the young chimaeras"] = "{item:6839}，由奇美拉幼崽掉落",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840}, from the {npc:6167}"] = "{item:6840}，来自{npc:6167}",

	-- Step 9: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "{area:1717}中的鲁古格",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {spell:403} Lightning Bolt
	["Roogug is an elite quilboar (level 28) inside {area:1717}, the dungeon at the south end of the {zone:1413}; a five-player dungeon: needs a group of five, and his guards come with him. Inside take the left path at the first fork, cross the root bridge, go past the big empty cauldron: he is in a dead end on the right, with about ten elites on the way. He casts {spell:403} and calls Earth Rumblers. The vial always drops."] = "鲁古格是一只精英野猪人（28级），在{zone:1413}最南端的地下城{area:1717}里；这是五人地下城：需要五人小队，他的守卫也会一起参战。进去后在第一个岔路口向左，过树根桥，经过空的大锅：他就在右侧尽头，沿途大约有十只精英。他会施放{spell:403}并召唤地行者。必定掉落药瓶。",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}，来自鲁古格",

	-- Step 10: Furen's Armor
	-- {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Back to {npc:5413} in the {object:28027} for the hauberk. He then sends you to the smith of your race; the other two smiths' pieces are open to you as well: talk to them directly."] = "返回{object:28027}的{npc:5413}处领取锁甲。他接着会让你去找自己种族的铁匠；另外两位铁匠提供的装备部件也可以取得：直接与他们交谈即可。",

	-- Step 11: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {object:28027} Dwarven District · {npc:5413} Furen Longbeard · {quest:1705} Burning Blood · {item:6845} Burning Rock
	["{npc:1416} keeps the weapon shop in the north-west of the {object:28027}, a short walk from {npc:5413}. He wants 20 {quest:1705} and the {item:6845}."] = "{npc:1416}在{object:28027}西北部经营武器店，离{npc:5413}只有几步路。他需要20个{quest:1705}和{item:6845}。",

	-- Step 12: Burning Blood
	-- {zone:1431} Duskwood · {area:42} Darkshire · {quest:1705} Burning Blood · {npc:6170} Gutspill · {item:6845} Burning Rock · {area:2161} Roland's Doom · {spell:3427} Infected Wound
	["The Nightbane worgen of {zone:1431} (Dark Runners, Vile Fangs, Shadow Weavers, Worgen and Tainted Ones, level 26-31) south and west of {area:42} drop the {quest:1705} four kills in five. {npc:6170} (level 32, not elite) carries the {item:6845} (also four in five): he walks between the inside and the mouth of the {area:2161} mine south-east of {area:42}, so wait at the entrance and pull him outside. {npc:6170} and the Tainted Ones poison and howl; Vile Fangs cause {spell:3427}."] = "{zone:1431} 的 {area:42} 南边和西边分布着夜行狼人（黑暗奔跑者、邪齿狼人、暗影编织者、狼人和堕落狼人，26-31 级），约每五次击杀有四次掉落 {quest:1705}。{npc:6170}（32 级，非精英）携带 {item:6845}（掉率同样约五分之四）：他在 {area:42} 东南的 {area:2161} 矿洞内与洞口之间巡逻，可在入口等候，把他引到外面。{npc:6170} 和堕落狼人会下毒和嚎叫；邪齿狼人会造成 {spell:3427}。",
	-- {quest:1705} Burning Blood
	["{quest:1705}, from the Nightbane worgen"] = "从夜行狼人处获取 {quest:1705}。",
	-- {item:6845} Burning Rock · {npc:6170} Gutspill
	["{item:6845}, from {npc:6170}"] = "{item:6845}，由{npc:6170}掉落",

	-- Step 14: Mathiel
	-- {quest:1703} Mathiel · {area:1660} Warrior's Terrace · {zone:1457} Darnassus · {quest:1710} Sunscorched Shells
	["{quest:1703} works on the south side of the {area:1660} in {zone:1457}. He wants 20 {quest:1710}."] = "{quest:1703} 在 {zone:1457} 的 {area:1660} 南侧工作。他需要20份 {quest:1710}。",

	-- Step 15: Sunscorched Shells
	-- {area:482} Highperch · {zone:1441} Thousand Needles
	-- plural, as words: Highperch Wyverns = {npc:4107} Highperch Wyvern
	["The shells lie on the ground under the wyvern nests at {area:482} in western {zone:1441}, deeper into the gorge. Only nine exist and each returns 3 minutes after you pick it, so you will wait; some shell-like things there cannot be looted. Highperch Wyverns (level 28-31) guard them and sometimes come several at once."] = "蛋壳散落在 {zone:1441} 西部 {area:482} 的双足飞龙巢穴下方地面，位置在峡谷更深处。总共只有九个，每个拾取后三分钟刷新，因此需要等待；那里一些看起来像蛋壳的东西无法拾取。风巢双足飞龙（28—31级）守护着蛋壳，有时会同时引来好几只。",

	-- Step 17: Klockmort Spannerspan
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1455} Ironforge · {quest:1704} Klockmort Spannerspan · {object:171524} Tinker Town · {item:6848} Searing Coral
	["Ride the {area:2257} from {zone:1453} to {zone:1455}. {quest:1704}, a gnome smith, works in {object:171524} near the engineering trainers. He wants 20 {item:6848}."] = "搭乘{area:2257}从{zone:1453}前往{zone:1455}。侏儒铁匠{quest:1704}在{object:171524}工作，靠近工程学训练师。他需要20个{item:6848}。",

	-- Step 18: Iron Coral
	-- {quest:1708} Iron Coral · {area:150} Menethil Harbor · {item:5996} Draught of Water Breathing
	["The {quest:1708} grows on the sea floor just south of {area:150}, by the murloc huts and a wrecked boat: eight there and two south-east of the harbor, each back in 3 minutes, so you will wait for respawns to reach 20. The murlocs can net you underwater: watch your breath, and a {item:5996} removes the risk."] = "",
	-- {item:6848} Searing Coral · {quest:1708} Iron Coral
	["{item:6848}, from {quest:1708}"] = "{item:6848}，来自{quest:1708}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A hauberk at 28, a coif, leggings and gauntlets from three smiths, and a shield on the way."] = "28级的锁甲，三位铁匠分别给出罩帽、护腿和护手，途中还有一面盾牌。",
	-- ["A hauberk at 28, a coif, leggings or gauntlets by race, and a shield on the way."] = "28级的锁甲，按种族还有罩帽、护腿或护手，途中还有一面盾牌。",
	-- ["At 20, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {quest:1698} in Redridge."] = "20级时，{object:2100}酒馆旁的{npc:5479}会让你去赤脊山找{quest:1698}。",
	-- ["Back to {npc:5413} in the {object:28027}. He sends you on to a smith of your own race."] = "回到{object:28027}找{npc:5413}。他会让你去找你自己种族的铁匠。",
	-- ["Ride the {area:2257} from {zone:1453} to {zone:1455}."] = "从{zone:1453}乘{area:2257}前往{zone:1455}。",
	-- ["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "鲁古格是{area:1717}里的精英野猪人，这个地下城位于{zone:1413}南端；他掉落{item:6841}。{area:1717}是地下城：建议组队。",
	-- ["The Fledgling and Young Chimaeras roam the south-west of Stonetalon, with the {npc:6167} among them: the young ones drop the {item:6839}, the Matriarch the {item:6840}."] = "奇美拉雏兽和{npc:4032}在石爪山脉西南部游荡，{npc:6167}也在其中：幼年奇美拉掉落{item:6839}，奇美拉主母掉落{item:6840}。",
	-- ["The Leech Stalkers and Cave Stalkers crawl around 46,61 in the middle of the {zone:1437}; they drop the {item:6838}."] = "{npc:1111}和{npc:4040}在{zone:1437}中部46,61附近爬行；它们掉落{item:6838}。",
	-- ["The Nightbane worgen of {zone:1431} drop the {quest:1705}. {npc:6170} walks in the far south-east of {zone:1431} and carries the {item:6845}."] = "{zone:1431}的夜行狼人掉落{quest:1705}。{npc:6170}在{zone:1431}的最东南端游荡，身上带着{item:6845}。",
	-- ["The {quest:1708} grows along the {zone:1437}' west coast, south of {area:150}."] = "{quest:1708}生长在{zone:1437}西海岸、{area:150}南边。",
	-- ["The {quest:1708} grows on the sea floor just south of {area:150}, by the murloc huts and a wrecked boat: eight there and two south-east of the harbor, each back in 3 minutes, so you will wait for respawns to reach 20. The murlocs can net you underwater: watch your breath, and an Elixir of Water Breathing removes the risk."] = "{quest:1708}生长在{area:150}正南方的海底，靠近鱼人小屋和一艘破船：那里有八株，港口东南方另有两株，每株3分钟刷新，因此凑齐20个需要等刷新。鱼人会在水下用网困住你：留意呼吸，使用水下呼吸饮剂可以消除溺水风险。",
	-- ["The {quest:1710} lie along the western edge of {zone:1441}."] = "{quest:1710}散布在{zone:1441}的西部边缘。",
	-- ["{item:6839} from the young chimaeras"] = "{item:6839}，来自幼年奇美拉",
	-- ["{item:6840} from the {npc:6167}"] = "{item:6840}，来自{npc:6167}",
	-- ["{item:6845} from {npc:6170}"] = "{item:6845}，来自{npc:6170}",
	-- ["{npc:1416} is in {zone:1453}, a short walk from {npc:5413}."] = "{npc:1416}在{zone:1453}，离{npc:5413}不远。",
	-- ["{npc:5413} works in the Dwarven District of Stormwind. He keeps the {item:6843} and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest."] = "{npc:5413}在暴风城的矮人区工作。他保管着{item:6843}，并给你一面盾牌{item:6970}；{quest:1701}是28级任务。",
	-- ["{quest:1698} is in {area:69}, at the inn. His test is timed: run north-west into the {area:98}, reach the first fork and come back to him before the timer runs out. Do not die and release your spirit."] = "{quest:1698}在{area:69}的旅店里。他的测试有时间限制：向西北跑进{area:98}，到达第一个岔路口后在时间用完前回到他身边。不要死亡并释放灵魂。",
	-- ["{quest:1703} is a smith in {zone:1457}."] = "{quest:1703}是{zone:1457}的一名铁匠。",
	-- ["{quest:1705} from the Nightbane worgen"] = "{quest:1705}，来自夜行狼人",
}
