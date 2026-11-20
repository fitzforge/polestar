-- Chinese (simplified) (zhCN): the guide forever/horde/30-40/01-hillsbrad-foothills (forever/horde/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:527} Battle of Hillsbrad · {area:272} Tarren Mill
	["For characters of 29 to 31: the {quest:527}, {area:272}'s errands and the gnolls of the foothills, all at or under your level."] = "适合29到31级的角色：{quest:527}、{area:272}的跑腿任务和丘陵上的豺狼人，全都不高于你的等级。",

	-- Step 1: Freewind Post flight master
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "{area:484}的飞行管理员",

	-- Step 2: Thunder Bluff
	-- {area:484} Freewind Post · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from {area:484} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to the Crossroads from there."] = "从 {area:484} 飞往 {area:1638}，到 {area:1639} 找 {npc:3033} 学习技能；再从那里飞往十字路口。",

	-- Step 3: Ratchet
	-- {area:484} Freewind Post · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly from {area:484} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to the Crossroads from {area:392}."] = "从 {area:484} 飞往 {area:392}。{npc:5901} 在镇子南边不远的海岸扎营；随后从 {area:392} 飞往十字路口。",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}, for the brazier"] = "{npc:5901}：用于火盆的{item:6637}",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "飞往十字路口",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飞行管理员",

	-- Step 5: Fly to the Crossroads
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}的飞行管理员",

	-- Step 7: Korran
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows · {zone:1454} Orgrimmar
	["{npc:3428} stands beside the Crossroads flight master. {quest:1145} is offered from level 29; below it, the next guide's {zone:1454} stop takes it."] = "{npc:3428}站在十字路口飞行管理员旁边。{quest:1145}29级起可接；不到29级的话，下一个指南在{zone:1454}停留时会接。",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "{npc:3428}：交给 {zone:1454} 的 {npc:4485}",

	-- Step 8: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",
	["Crossroads flight master"] = "十字路口飞行管理员",

	-- Step 9: Thrall
	-- {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:4949} 在 {object:172957} 的格罗玛什要塞等候。",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}，在格罗玛什要塞，如果你带着它",

	-- Step 10: Train
	["Train"] = "训练",
	["Train your new spells."] = "训练你的新法术。",

	-- Step 11: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}, on the way out to the main gate."] = "{npc:4485} 站在 {object:172958}，位于出城前往正门的路上。",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, next guide"] = "交给 {area:439} 的 {npc:4483}，见下一篇指南",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "乘飞艇前往{zone:1458}",

	-- Step 13: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "{npc:260093}在{zone:1458}训练圣骑士。",

	-- Step 14: Undercity flight master
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "{zone:1458}飞行管理员",

	-- Step 15: Brazier of Everfount
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "飞往 {area:228}。{object:113791} 位于其西南侧的山坡上：击败旁边的堕落的水之魂，将其护腕放入火盆，与 {npc:5895} 交谈，并保留 {item:7813}，之后交给 {npc:5901}。再从 {area:228} 飞往 {area:272}。",
	-- {item:6637} Water Sapta
	["{item:6637}: drink it by the standing stone to see the elemental"] = "{item:6637}：在立石旁喝下，即可看见元素",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, next guide"] = "交给 {npc:5901}，见下一篇指南",

	-- Step 16: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "飞往{area:272}",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "{area:228}的飞行管理员",

	-- Step 18: Tarren Mill
	-- {quest:567} Dangerous! · {npc:2216} Apothecary Lydon · {npc:2393} Christoph Jeffcoat
	["The {quest:567} poster hangs by the inn; {npc:2216} stands inside it. {npc:2393}, the cook by the inn, wants turtle meat and sells the spices for it."] = "{quest:567}的告示贴在旅店旁；{npc:2216}在旅店里。旅店旁的厨师{npc:2393}要海龟肉，并出售所需的香料。",
	-- {quest:567} Dangerous!
	["{quest:567}, the poster by the inn"] = "{quest:567}，旅店旁的告示",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "{npc:2216}：在屋内",
	-- {npc:2393} Christoph Jeffcoat · {quest:7321} Soothing Turtle Bisque
	["{npc:2393}: {quest:7321}, the Snapjaws of the river south of town"] = "{npc:2393}：{quest:7321}，镇子南边河里的钳嘴龟",
	-- {item:3713} Soothing Spices · {npc:2393} Christoph Jeffcoat
	["{item:3713}, from {npc:2393}"] = "{item:3713}，从{npc:2393}处购买",

	-- Step 19: High Executor Darthalia
	-- {area:287} Hillsbrad · {quest:527} Battle of Hillsbrad
	["You missed Darthalia's first errands, from the 22-25 {area:287} guide: they come first now. They are a few levels below you and quick, and they open the rest of the {quest:527} in this guide."] = "你错过了22-25级{area:287}指南中达萨利亚最早的几个差事：现在先做这些。它们比你低几级，很快就能完成，还会开启本指南中{quest:527}的后续任务。",

	-- Step 20: Krusk
	-- {npc:2229} Krusk · {area:275} Durnholde Keep
	["{npc:2229} wants his two scouts freed from {area:275}."] = "{npc:2229}要你把他的两名斥候从{area:275}救出来。",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}：在屋内",

	-- Step 21: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz
	-- plural, as words: Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["West past the hills to the farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere.\nCareful: Kirin Tor Guards (55) patrol {area:287}'s fields and roads and attack the Horde: keep an eye out for them and stay out of their way."] = "向西越过山丘，前往{area:287}镇东边的农场。{npc:232}在北边农舍旁的田里干活，{npc:2403}在更东南边的那片田里；雇农和农夫到处都是。\n小心：肯瑞托卫兵（55级）在{area:287}的田地和道路上巡逻，会攻击部落：留意它们，别挡它们的路。",

	-- Step 22: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east to {area:272}."] = "向东回到{area:272}。",

	-- Step 23: Hillsbrad Peasants
	-- plural, as words: Hillsbrad Peasants = {npc:2267} Hillsbrad Peasant
	["Hillsbrad Peasants"] = "希尔斯布莱德农民",
	["Back to the fields: the Peasants work south of the farmhouses. Careful: A fleeing peasant that reaches the town hall can bring back adds; snares or roots keep them from escaping."] = "回到农田：农民在农舍南边干活。小心：逃跑的农民如果跑到镇公所，可能会带回更多敌人；用减速或定身可以阻止他们逃跑。",

	-- Step 26: Durnholde Keep
	-- {npc:2238} Tog'thar · {npc:2427} Jailor Eston · {item:3467} Dull Iron Key · {npc:2428} Jailor Marlgen · {item:3499} Burnished Gold Key
	["South-east of Tarren Mill. Drull and {npc:2238} are chained in the keep's courtyard buildings, and each lock needs its key: {npc:2427} carries the {item:3467} for Drull's, {npc:2428} the {item:3499} for {npc:2238}'s, both in the keep. Kill them first, then open both locks."] = "",
	-- {item:3467} Dull Iron Key · {npc:2427} Jailor Eston
	["{item:3467}, from {npc:2427}"] = "",
	-- {item:3499} Burnished Gold Key · {npc:2428} Jailor Marlgen
	["{item:3499}, from {npc:2428}"] = "",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "{npc:2238}的镣铐",
	["Drull's ball and chain"] = "德鲁尔的镣铐",

	-- Step 27: Krusk
	-- {area:272} Tarren Mill
	["Back to {area:272}."] = "返回{area:272}。",

	-- Step 28: The river south of Tarren Mill: kill these as you meet them
	-- {area:272} Tarren Mill
	["The river south of {area:272}: kill these as you meet them"] = "{area:272}南边的河：遇到就杀",
	-- {area:272} Tarren Mill · {area:271} Southshore · {item:3712} Turtle Meat
	["South from {area:272} along the river: Snapjaws (29) sun themselves on its banks all the way down to the hills above {area:271}. Some of them carry {item:3712}."] = "从{area:272}沿河向南：钳嘴龟（29级）一路在河岸上晒太阳，直到{area:271}上方的山丘。其中一些身上有{item:3712}。",
	-- {item:3712} Turtle Meat
	["{item:3712}, from the Snapjaws"] = "{item:3712}，从钳嘴龟身上获取",

	-- Step 29: Mudsnout Blossoms
	-- {area:290} Dun Garok
	["South of the river's bend, the Mudsnout gnolls (26-28) camp in the hills above {area:290}; the blossoms grow among their tents. The Shamans heal and call their friends: pull them first."] = "在河湾南边，泥鼻豺狼人（26-28级）在{area:290}上方的山丘扎营；花就长在他们的帐篷之间。萨满会治疗并呼叫同伴：先拉他们。",

	-- Step 30: North of Southshore
	["North of Southshore"] = "南海镇北边",
	-- {area:287} Hillsbrad · {area:271} Southshore
	["From the blossoms, back north along the river and then west to {area:287} town, well north of {area:271} (its guards are 55)."] = "采完花后，沿河返回北边，再向西前往{area:287}镇，在{area:271}北边很远处（那里的卫兵是55级）。",

	-- Step 31: The smithy
	["The smithy"] = "铁匠铺",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes · {npc:2451} Farmer Kalaba
	-- was: ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "向西穿过丘陵前往{area:287}镇：铁匠铺就在镇中央。{npc:2404}和他的学徒在熔炉旁工作；{object:1736}堆在旁边。{npc:2449}在铁匠铺附近走动；{npc:2451}在镇子东南边的田里干活。"
	["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the west side of the town; {npc:2451} works the field south-east of the town."] = "",
	["Inside"] = "在里面",
	-- {npc:2449} Citizen Wilkes
	["{npc:2449}, on the west side of the town"] = "",

	-- Step 32: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["for {npc:2055}, on the {zone:1458} stop at the end of this guide"] = "交给{npc:2055}，在本指南结尾的{zone:1458}站交还",
	-- {npc:2429} Novice Thaivand · {item:3708} Helcular's Rod
	["{npc:2429}, in the town: {item:3708}, from the yetis on the way to the town hall"] = "镇里的{npc:2429}：{item:3708}，在前往市政厅路上的雪人身上获得",

	-- Step 33: Helcular's Rod
	-- {area:277} Foothill Caverns
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti · Giant Yetis = {npc:2251} Giant Yeti
	["West of Tarren Mill, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but they hit hard and come in pairs."] = "在塔伦米尔以西，洞穴雪人和凶恶的雪人（30-32级）遍布山中的{area:277}；约每十六只中有一只携带魔棒。待在这片洞穴里：更北边那个洞穴的山岭雪人和巨型雪人（32-34级）也带着魔棒，但它们打人很痛，而且成对出现。",

	-- Step 34: Town hall
	["Town hall"] = "市政厅",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["On to {area:287} town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "继续前往雪人洞穴西南边的{area:287}镇。市政厅在镇子西侧：{npc:2335}（30级）和{npc:2448}在里面，旁边是城镇登记簿；公告就贴在它旁边。议员们在镇上走动。",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "{object:1761}，在里面",

	-- Step 35: Tarren Mill
	-- {area:271} Southshore
	-- plural, as words: Giant Yetis = {npc:2251} Giant Yeti
	["Thaivand's next errand, the flames, sends you among the Mountain and Giant Yetis (32-34) and to Helcular's grave inside {area:271}: leave it."] = "塞万德的下一个差事（火焰）要你深入山岭雪人和巨型雪人（32-34级）之中，还要去{area:271}里的赫尔库拉之墓：先不要做。",

	-- Step 36: Melisara
	-- {npc:2278} Melisara · {area:272} Tarren Mill · {npc:2410} Magus Wordeen Voidglare
	["For your City of Dalaran run, later in this guide: {npc:2278} stands in {area:272}, a short walk east of {npc:2410}."] = "为本指南稍后的达拉然城之行做准备：{npc:2278}站在{area:272}，在{npc:2410}东边不远处。",

	-- Step 37: City of Dalaran
	["City of Dalaran"] = "达拉然城",
	-- {item:277507} Dalaran Sewer Key · {npc:247126} Atrexis the Grave Knight · {npc:2278} Melisara · {npc:268743} Rexxie Copperclutch
	["The City of Dalaran is a dungeon for a group of five, about levels 28 to 33, under the violet dome. Without the {item:277507}, go in through the sewer pipe north-west of the crater: the arrow leads there.\nInside: {npc:247126} is {npc:2278}'s. {npc:268743}, in the sewer, gives Opportunistic Education and takes it back there."] = "达拉然城是适合28-33级左右五人小队的地下城，位于紫罗兰穹顶之下。没有{item:277507}的话，就从弹坑西北的下水管道进去：箭头会指引你。\n副本内：{npc:247126}是{npc:2278}要的。下水道里的{npc:268743}会给你“投机教育”，并在原处交还。",
	-- {quest:96986} The Grave Knight · {npc:247126} Atrexis the Grave Knight
	["{quest:96986}: {npc:247126}, inside"] = "{quest:96986}：{npc:247126}，在副本内",

	-- Step 39: Azurelode Mine
	-- {area:287} Hillsbrad · {area:288} Azurelode Mine · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["Head south-west past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "向西南穿过{area:287}镇，前往{area:288}。矿工在隧道内作业；{npc:2305}（30级）和{npc:2450}（29级）在深处。",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "在{area:288}里面",

	-- Step 40: Level 30
	["Level 30"] = "30 级",
	-- {npc:2410} Magus Wordeen Voidglare · {area:272} Tarren Mill · {zone:1454} Orgrimmar · {area:288} Azurelode Mine · {zone:1437} Wetlands
	-- plural, as words: Torn Fin Muckdwellers = {npc:2374} Torn Fin Muckdweller
	["{npc:2410}'s quests on the next {area:272} stop and Alliance Relations in {zone:1454}, the next guide's first stop, are offered from level 30. Short of 30? The Torn Fin Muckdwellers and Coastrunners (28-30) crowd the coast south of the {area:288}, a short walk: kill them until level 30. Their Oracles (30-31) cast from the shore further east. Or, with a group, run the Excavation Site dungeon (in the {zone:1437}) instead."] = "下次到{area:272}时{npc:2410}的任务，以及下一篇指南第一站{zone:1454}的“联盟关系”，都要30级才能接。不到30级？碎鳍泥浆鱼人和滩行鱼人（28-30级）挤满了{area:288}南边的海岸，走几步就到：杀到30级为止。它们的先知（30-31级）在更东边的岸上施法。或者组队去打发掘场地下城（在{zone:1437}）。",
	["Torn Fin murlocs"] = "碎鳍鱼人",
	-- {npc:2375} Torn Fin Coastrunner
	["grind on {npc:2375}"] = "击杀{npc:2375}刷经验",

	-- Step 41: Finish the Turtle Meat
	-- {item:3712} Turtle Meat
	["Finish the {item:3712}"] = "收集完{item:3712}",
	-- {item:3712} Turtle Meat · {area:272} Tarren Mill
	["Still short of ten {item:3712}? The Snapjaws line the river east of {area:272}, on your way back from the mine."] = "还没凑够十块{item:3712}？{area:272}东边的河边有很多钳嘴龟，就在你从矿洞回来的路上。",

	-- Step 42: Tarren Mill
	-- {area:272} Tarren Mill · {area:271} Southshore
	["North-east back to {area:272}, passing well north of {area:271} (its guards are 55)."] = "向东北返回{area:272}，从{area:271}北边远远绕过（那里的卫兵是55级）。",
	-- {npc:2215} High Executor Darthalia · {quest:539} Battle of Hillsbrad · {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2215}: her next {quest:539}, and {npc:2419}'s sword, are elite group quests at {area:290}: take them only with a group"] = "{npc:2215}：她的下一个任务{quest:539}，以及{npc:2419}的剑，都是在{area:290}的精英组队任务：只有组队时才接",
	-- {npc:2229} Krusk
	["{npc:2229}, inside: Infiltration, worked on the 38-39 visit (its Syndicate are 32-35)"] = "屋内的{npc:2229}：“渗透”，在38-39级时完成（辛迪加成员32-35级）",
	-- {area:272} Tarren Mill
	["Keep Infiltration in your log: its Syndicate (32-35) are over you now, and the 38-39 guide (Alterac and Arathi) works it on its first {area:272} loop."] = "把“渗透”留在任务日志里：辛迪加成员（32-35级）现在比你高，38-39级指南（奥特兰克和阿拉希）第一次到{area:272}时会完成它。",

	-- Step 43: Voidglare, Bel'varil and Tallow
	-- {npc:2770} Tallow
	["Voidglare, Bel'varil and {npc:2770}"] = "伍德格莱尔、贝瓦里尔和{npc:2770}",
	-- {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow · {area:272} Tarren Mill
	["{npc:2410} and {npc:2437} are inside the inn, {npc:2770} just outside it. Their quests are offered from level 30; below it, the 38-39 guide's first {area:272} stop takes them."] = "{npc:2410}和{npc:2437}在旅店里，{npc:2770}就在旅店外。他们的任务30级才能接；不到30级的话，38-39级指南第一次到{area:272}时再接。",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:544} Prison Break In · {area:279} Dalaran
	["{npc:2410}, inside: {quest:544}, for the 38-39 visit (the {area:279} crater's traitors are 33-35)"] = "屋内的{npc:2410}：{quest:544}，留到38-39级时完成（{area:279}弹坑的叛徒33-35级）",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {quest:544} Prison Break In
	["{npc:2410}: {quest:93680}, with {quest:544} on the 38-39 visit"] = "{npc:2410}：{quest:93680}，38-39级时与{quest:544}一起完成",
	-- {npc:2437} Keeper Bel'varil · {quest:556} Stone Tokens
	["{npc:2437}, inside: {quest:556}, with the crater on the 38-39 visit"] = "屋内的{npc:2437}：{quest:556}，38-39级时去弹坑一起完成",
	-- {npc:2770} Tallow
	["{npc:2770}, outside the inn: the Boulderfist ogres (32-34) on the 38-39 Arathi visit"] = "旅店外的{npc:2770}：石拳食人魔（32-34级），38-39级去阿拉希时完成",
	-- {area:272} Tarren Mill · {area:321} Hammerfall
	["Keep these in your log: their camps are two to four levels over you now, and the 38-39 guide works them on its first {area:272} loop and in {area:321}."] = "把这些任务留在任务日志里：它们的营地现在比你高二到四级，38-39级指南第一次到{area:272}时以及在{area:321}会完成它们。",

	-- Step 44: Melisara
	-- {quest:96986} The Grave Knight · {npc:2278} Melisara · {npc:2410} Magus Wordeen Voidglare
	["{quest:96986} from your City of Dalaran run: {npc:2278}, a short walk east of {npc:2410}."] = "达拉然城之行得到的{quest:96986}：{npc:2278}，在{npc:2410}东边不远处。",

	-- Step 45: Battle of Hillsbrad with a group
	-- {quest:539} Battle of Hillsbrad
	["{quest:539} with a group"] = "组队完成 {quest:539}",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["Darthalia's last battle is at {area:290}, the dwarven keep south-east of {area:271}: every dwarf there is elite (28-32), {npc:2304} too. Great XP if you have a group for it."] = "达萨利亚的最后一战在 {area:290}，即 {area:271} 东南侧的矮人要塞：那里所有矮人都是精英（28-32 级），{npc:2304} 也是。有队伍的话，经验很丰厚。",

	-- Step 46: Humbert's Sword with a group
	-- {quest:547} Humbert's Sword
	["{quest:547} with a group"] = "组队完成 {quest:547}",
	-- {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2419}'s sword drops from the same {area:290} dwarves (about one in twelve)."] = "{npc:2419} 的剑也由 {area:290} 的这些矮人掉落（约十二分之一）。",

	-- Step 47: Dun Garok
	-- {area:290} Dun Garok
	["Clear {area:290} from the gate in; the dwarves run for help at 30% health."] = "从大门开始向内清理 {area:290}；矮人会在生命值降到 30% 时逃跑求援。",

	-- Step 48: Tarren Mill
	-- {npc:2425} Varimathras · {zone:1458} Undercity
	["for {npc:2425} in the {zone:1458}, at the end of this guide"] = "交给 {zone:1458} 的 {npc:2425}，在本篇指南结尾完成",

	-- Step 50: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "飞往{area:1497}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "{area:272}的飞行管理员",

	-- Step 51: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell · {object:36126} Royal Quarter
	["{npc:2055} stands in the Apothecarium, in the {object:36126}."] = "{npc:2055}站在{object:36126}的炼金房里。",
	-- {quest:513} Elixir of Agony · {item:3388} Lesser Troll's Blood Elixir · {skill:171} Alchemy · {area:287} Hillsbrad
	["Faranell's next {quest:513} needs a {item:3388} ({skill:171}) and the {area:287} coast: leave it."] = "法拉尼尔的下一个任务{quest:513}需要一瓶{item:3388}（{skill:171}），还要去{area:287}海岸：先不要做。",

	-- Step 52: Varimathras
	-- {npc:2425} Varimathras · {object:36126} Royal Quarter
	["{npc:2425} stands beside Sylvanas in the {object:36126}."] = "{npc:2425} 站在 {object:36126}，就在希尔瓦娜斯旁边。",
	-- {npc:2425} Varimathras
	["{npc:2425}: Darthalia's commendation"] = "{npc:2425}：达萨利亚的表彰",

	-- Step 53: Calder Gray
	-- {npc:270038} Calder Gray · {quest:97985} Thundering Hearts · {area:484} Freewind Post · {area:439} Shimmering Flats
	["{npc:270038} stands in the Apothecarium. His {quest:97985} is for Stormheart, a level 30 elite who walks the canyon east of {area:484}, on the next guide's way to the {area:439}."] = "{npc:270038}站在炼金房里。他的{quest:97985}的目标是Stormheart，一个30级精英，在{area:484}东边的峡谷里走动，就在下一份指南前往{area:439}的路上。",
	-- {npc:270038} Calder Gray · {zone:1458} Undercity
	["{npc:270038}: back to him on the next {zone:1458} stop, at about 38"] = "{npc:270038}：下次到{zone:1458}时（约38级）再回来找他",

	-- Step 54: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "{zone:1458}的训练师",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "趁在{zone:1458}时训练：训练师在{object:36070}、{object:36073}和{object:36082}（圣骑士：{npc:260093}）。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into the yeti caves west of {area:272} with the {item:3710}. The path splits just inside: the {object:1768} burns on the upper level to the right, the {object:1769} on the lower level to the left, past more yetis."] = "带上 {item:3710}，回到 {area:272} 西侧的雪人洞穴。刚进洞就有岔路：{object:1768} 在右侧上层，{object:1769} 在左侧下层，需穿过更多雪人。",
	-- ["Back north to {area:321}."] = "向北返回 {area:321}。",
	-- ["Back to {area:272}"] = "返回{area:272}",
	-- ["Below ground"] = "在地下",
	-- ["Boulderfist camp"] = "石拳营地",
	-- ["Daggerspine naga"] = "刺脊纳迦",
	-- ["Daggerspine shore"] = "刺脊海岸",
	-- ["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "沿道路向北离开{area:272}，进入奥特兰克山麓。{quest:535}在辛迪加营地旁等候；把南海镇烈酒交给他。",
	-- ["For characters of 29 to 33, but most quests here are level 32-34, a few up to 36: on purpose, for their experience. The Syndicate, {area:279}'s guards and the Boulderfist ogres are 31-35, so pull them one at a time."] = "适合29到33级的角色，但这里的大多数任务是32-34级，少数高达36级：这是有意安排的，为了它们的经验值。辛迪加、{area:279}的守卫和石拳食人魔为31-35级，所以一次拉一只。",
	-- ["From {area:271} head north past {area:272} and follow the road on into the Alterac foothills. {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "从{area:271}向北经过{area:272}，沿道路一直走进奥特兰克山麓。{quest:535}在辛迪加营地旁等着。只有你身上带着{npc:2229}的“秘密潜入”时，他才会给出差事：立刻把酒交给他，他的奖励就是克鲁斯克要的辛迪加信件。从这里的辛迪加身上拿到的信件也一样：背包里有一封，指南就会跳过{quest:535}。",
	-- ["Head back north to {area:272}, east of {area:271}."] = "向北返回 {area:272}，位于 {area:271} 东侧。",
	-- ["Head back north to {area:272}."] = "向北返回{area:272}。",
	-- ["Head back south down the road to {area:272}."] = "沿道路向南返回{area:272}。",
	-- ["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "从{area:272}向东出发，穿过{area:1057}后沿路继续向东。石拳食人魔和石拳执行者（32-34级）的营地在路南、{area:313}以南；石拳执行者待在那里的洞穴中。",
	-- ["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "从 {area:272} 向东出发，穿过 {area:1057}，沿路继续向东。石拳食人魔和石拳执行者（32-34 级）的营地在路南，位于 {area:313} 东南侧。",
	-- ["Head east to {area:271}'s graveyard, on the north-east edge of the town: Helcular's grave lies among the others. Come at it from the north, down the slope above the town. Southshore Guards (55) stand at the graveyard's north-west corner and south-east of the grave: walk in between them, hand the quest in and leave the way you came."] = "向东前往 {area:271} 东北边缘的墓地：赫尔库拉的坟墓就在其中。从北侧、顺着镇子上方的山坡下来接近。南海镇卫兵（55级）站在墓地西北角和坟墓东南边：从他们中间走进去，交还任务后原路离开。",
	-- ["Head south past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "向南穿过 {area:287} 镇，前往 {area:288}。矿工在隧道内作业；{npc:2305}（30 级）和 {npc:2450}（29 级）在深处。",
	-- ["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens.\nCareful: Many guards stand in linked pairs and others patrol alone around the camp."] = "沿山脚向西前往 {area:279} 的紫色穹顶。{npc:2411}、{npc:2412} 和 {npc:2413}（33—34级）聚在坑内东侧边缘，{npc:2414}（35级）在他们稍西侧；每人携带一件血石物品。周围的 达拉然持盾守卫 和 达拉然法师（31—32级）会掉落用旧的石雕。\n小心：很多守卫两人联动，也有其他守卫在营地周围独自巡逻。",
	-- ["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens. Careful: Many guards stand in linked pairs and others patrol alone around the camp. Arcane Sentries (55, elite) and Kirin Tor Guards (55) stand around the violet dome itself: keep to the camp below the rim."] = "沿山脚向西前往{area:279}的紫色穹顶。{npc:2411}、{npc:2412}和{npc:2413}（33-34级）聚在坑内东侧边缘，{npc:2414}（35级）在他们稍西侧；每人携带一件血石物品。周围的达拉然持盾守卫和达拉然法师（31-33级）会掉落用旧的石雕。注意：很多守卫两人联动，也有其他守卫在营地周围独自巡逻。奥术哨兵（55级，精英）和肯瑞托卫兵（55级）就站在紫色穹顶周围：待在坑沿下方的营地里。",
	-- ["Highland raptors and Plains Creepers"] = "高地迅猛龙和平原狼蛛",
	-- ["Level 31"] = "31 级",
	-- ["Lydon's next errand is a keg of Shindigger Stout from the cellar of {area:290}, the elite dwarven keep south-east of {area:271}: take it only if you go there with a group."] = "药剂师林度恩的下一个任务需要从{area:290}的地窖取一桶矿工烈酒。那里是{area:271}东南侧的精英矮人要塞；只有组队前往时才接取。",
	-- ["North of Southshore's graveyard"] = "南海镇墓地北边",
	-- ["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "向北返回的路上，高地阔步龙在 {area:321} 周围的山间游荡，会掉落眼球；南侧的平原狼蛛（32-33 级）在草地间结网，会掉落蛛丝。",
	-- ["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one. Careful: at 31-32 they are still above you and stand close together, with Wizards (34-35) among them: pull one at a time from the camp's edge."] = "只有在没拿到{quest:535}的信件时才做：道路西边营地周围的辛迪加劫匪和窃贼（32-34级）也带着信件，约每三只掉一封。小心：31-32级时它们仍比你高，而且站得很近，其中还有巫师（34-35级）：从营地边缘一次拉一只。",
	-- ["Place the {object:1729} on the {object:1728} beside the inn; upstairs"] = "将 {object:1729} 放到旅店旁楼上的 {object:1728} 上。",
	-- ["Shindigger keg"] = "矿工烈酒酒桶",
	-- ["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "落锤镇南边，枯木巨魔占据山中的村庄。枯木掷斧者守在外围小屋，枯木巫医和枯木猎头者守在村庄深处。小心：这三种巨魔都会在生命值降到15%时逃跑求援，可能引来附近营地的更多巨魔。",
	-- ["South-east of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village.\nCareful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "落锤镇东南侧，枯木巨魔占据山中的村庄。枯木掷斧者守在外围小屋，枯木巫医和枯木猎头者守在村庄深处。\n小心：这三种巨魔都会在生命值降到 15% 时逃跑求援，可能引来附近营地的更多巨魔。",
	-- ["South-east of Tarren Mill. Drull and {npc:2238} are chained in the keep's courtyard buildings: {npc:2427} carries the {item:3467} and {npc:2428} the {item:3499}, both in the keep. Kill them, then open both locks."] = "在塔伦米尔东南方。德鲁尔和{npc:2238}被锁在城堡庭院的建筑里：{npc:2427}携带{item:3467}，{npc:2428}携带{item:3499}，两人都在城堡里。杀死他们，然后打开两把锁。",
	-- ["South-west, the Cave and Ferocious Yetis (30-31) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod."] = "向西南走，洞穴雪人和凶恶的雪人（30-31 级）遍布 {area:272} 西侧山中的 {area:277}；约每十六只中有一只携带魔棒。",
	-- ["South-west, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but at 29-30 they hit hard and come in pairs."] = "向西南走，洞穴雪人和凶恶的雪人（30-32 级）遍布 {area:272} 西侧山中的 {area:277}；约每十六只中有一只携带魔棒。待在这片洞穴里：更北边那个洞穴的山岭雪人和巨型雪人（32-34 级）也带着魔棒，但 29-30 级时它们打人很痛，而且成对出现。",
	-- ["Strong Troll's Blood Potion: auction house or an alchemist, for {quest:515}."] = "Strong Troll's Blood Potion：从拍卖行购买或找炼金师制作，用于 {quest:515}。",
	-- ["Syndicate missives"] = "辛迪加信件",
	-- ["The Daggerspine naga line the shore south-east of the town."] = "刺脊纳迦分布在镇子东南侧的海岸上。",
	-- ["The Kegs of Shindigger Stout stand in the cellar of {area:290}, the dwarven keep south-east of {area:271}, beside {npc:2304} (32); every dwarf there is elite (28-32)."] = "装有矿工烈酒的酒桶放在{area:290}的地窖里，就在{npc:2304}（32级）旁边。这座矮人要塞位于{area:271}东南边，里面的矮人全是精英（28-32级）。",
	-- ["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "道路西边营地周围的辛迪加劫匪和辛迪加窃贼（32-33级）携带信件；大约三分之一会掉落。",
	-- ["The Torn Fin murlocs camp on the beaches south-west of {area:271}'s bay, below the mine."] = "碎鳍鱼人在 {area:271} 海湾西南侧、矿洞下方的沙滩扎营。",
	-- ["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "酒桶和另外几个酒桶一起放在{area:287}东南海岸的辛迪加营地里。",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "道路东端的兽人要塞。双足飞龙管理员{npc:2851}站在大门旁。",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "道路东端的兽人要塞。双足飞龙管理员 {npc:2851} 站在大门旁。\n只有你在 污染者（{zone:1461}）的声望达到友善，{npc:15126} 才会提供 {quest:8263}：若他没有提供，就跳过。",
	-- ["The third flame burns in the smaller cave up in the hills north of the caverns."] = "第三处火焰在这些洞穴北侧山上的一个小洞穴里。",
	-- ["The third flame burns in the smaller cave up in the hills north of the caverns.\nCareful: Giant and Mountain Yetis (32-34) stand around the flame, often in pairs, and Frostmaw, a rare yeti (37), roams nearby. At 30-31 they are over your level: pull the yetis one at a time from the cave mouth before you use the Rod, and watch for Frostmaw before you go in."] = "第三团火焰在洞穴群北边山上的小洞穴里燃烧。\n小心：巨型雪人和山岭雪人（32-34级）站在火焰周围，常常成对出现，稀有雪人霜喉雪人（37级）在附近游荡。30-31级时它们比你等级高：使用魔棒前，先从洞口一次拉一只雪人，进去前留意霜喉雪人。",
	-- ["The {area:279} crater"] = "{area:279} 巨坑",
	-- ["The {area:279} crater's eastern rim"] = "{area:279} 巨坑的东侧边缘",
	-- ["Torn Fin beach"] = "碎鳍海滩",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it."] = "向西穿过丘陵前往{area:287}镇：铁匠铺就在镇中央。{npc:2404}和他的学徒在熔炉旁工作；{object:1736}堆在旁边。",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "向西穿过丘陵前往{area:287}镇：铁匠铺就在镇中央。{npc:2404}和他的学徒在熔炉旁工作；{object:1736}堆在旁边。{npc:2449}在铁匠铺附近走动；{npc:2451}在镇子东南边的田里干活。",
	-- ["With a {item:3388} in your bags, {npc:2055} offers {quest:513} in the Apothecarium; {npc:2216} takes the elixir in {area:272}."] = "背包里有{item:3388}时，{npc:2055}会在炼金房提供{quest:513}；{npc:2216}在{area:272}接收药剂。",
	-- ["grind on {npc:2248}"] = "击杀 {npc:2248} 刷经验",
	-- ["grind on {npc:2562}"] = "击杀 {npc:2562} 刷经验",
	-- ["{area:272}'s {quest:544}, {quest:556} and {quest:676} are offered from level 30. Below it? Keep killing the yetis in these caves until level 30. Or, with a group, run the City of Dalaran dungeon instead."] = "{area:272} 的 {quest:544}、{quest:556} 和 {quest:676} 从 30 级起可接。还没到？继续击杀这些洞穴里的雪人，直到 30 级。也可组队前往达拉然城地下城。",
	-- ["{area:321} flight master"] = "{area:321}的飞行管理员",
	-- ["{area:321}'s quests are 32-36. Below 31? Keep killing the Boulderfist Ogres and Enforcers at this camp until level 31. Or, with a group, run the City of Dalaran dungeon instead."] = "{area:321} 的任务为 32-36 级。还没到 31 级？继续击杀这处营地里的石拳食人魔和石拳执行者，直到 31 级。也可组队前往达拉然城地下城。",
	-- ["{item:278225}, from Plains Creepers"] = "{item:278225}，由平原狼蛛掉落",
	-- ["{item:279469}: an object to loot, by the traitors"] = "{item:279469}：在叛徒旁边的可拾取物体中",
	-- ["{item:3388}: auction house or an alchemist, for {quest:513}."] = "{item:3388}：拍卖行或炼金术士，用于{quest:513}。",
	-- ["{item:3703}, for {npc:2333}"] = "{item:3703}，交给{npc:2333}",
	-- ["{npc:12920}, at the south gate"] = "{npc:12920}，在南门处",
	-- ["{npc:2229} now offers {npc:2316} (level 36), Bel'varil Bracers of Binding and Voidglare Dalaran Patrols: leave them for the 38-39 visit, which takes them on its first {area:272} stop."] = "{npc:2229} 现在会提供 {npc:2316}（36 级）、“Bel'varil Bracers of Binding”和“Voidglare Dalaran Patrols”：留到 38-39 级再来时完成，那一趟会在第一次到 {area:272} 时接取它们。",
	-- ["{npc:2229} wants his two scouts freed from {area:275} before he trusts you with Infiltration."] = "{npc:2229}要你先把他的两名斥候从{area:275}救出来，然后才会把“秘密潜入”交给你。",
	-- ["{npc:2410}, inside"] = "{npc:2410}：在屋内",
	-- ["{npc:2410}, inside: offered from level 30"] = "{npc:2410}，在屋内：30 级起可接",
	-- ["{npc:2410}: for the 38-39 visit to Alterac"] = "{npc:2410}：留到 38-39 级前往奥特兰克时完成",
	-- ["{npc:2410}: he offers {quest:545} after it"] = "{npc:2410}：之后他会提供{quest:545}",
	-- ["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "{npc:2410}：{quest:93680}，{item:279469}在叛徒附近",
	-- ["{npc:2437}, inside"] = "{npc:2437}：在屋内",
	-- ["{npc:2437}, inside: offered from level 30"] = "{npc:2437}，在屋内：30 级起可接",
	-- ["{npc:2437}: for the 38-39 visit to Alterac"] = "{npc:2437}：留到 38-39 级前往奥特兰克时完成",
	-- ["{npc:2706}'s Guile of the Raptor, {npc:2771}'s next {quest:677} and the doctor's Ward Restocking wait for the 38-39 visit."] = "{npc:2706} 的迅猛龙的狡诈、{npc:2771} 后续的 {quest:677} 和医生的病房补给，都留到 38-39 级再来时完成。",
	-- ["{npc:2706}: its Syndicate are by the road in from {area:272}, on the 38-39 visit"] = "{npc:2706}：所需的辛迪加成员在从 {area:272} 过来的路旁，留到 38-39 级再来时完成",
	-- ["{npc:2770}: for {npc:2771} in {area:321}, later in this guide (from level 30)"] = "{npc:2770}：交给 {area:321} 的 {npc:2771}，在本篇指南后续步骤完成（30 级起可接）",
	-- ["{npc:2792}, by the gate"] = "{npc:2792}，在大门旁",
	-- ["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428} 就站在十字路口的飞行管理员旁。",
	-- ["{quest:513} needs a {item:3388}, an {skill:171} item: buy one at the auction house if you can (or ask an alchemist). The quest text says Strong, but it takes a {item:3388}. No elixir: skip the Elixir steps in {area:287}."] = "{quest:513} 需要一瓶 {item:3388}，这是 {skill:171} 制作的物品：尽量从拍卖行购买（或找炼金师制作）。任务文本虽然写着“Strong”（强力），实际需要的是 {item:3388}。没有药剂就跳过 {area:287} 的苦楚药剂系列步骤。",
	-- ["{quest:515} needs a Strong Troll's Blood Potion, an {skill:171} item: buy one at the auction house if you can (or ask an alchemist). No potion: skip the Elixir steps in {area:287}."] = "{quest:515} 需要一瓶 Strong Troll's Blood Potion，这是 {skill:171} 制作的物品：尽量从拍卖行购买（或找炼金师制作）。没有药剂就跳过 {area:287} 的苦楚药剂系列步骤。",
	-- ["{quest:515} with a group"] = "组队完成{quest:515}",
}
