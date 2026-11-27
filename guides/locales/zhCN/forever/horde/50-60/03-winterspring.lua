-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1452} Winterspring · {zone:1448} Felwood · {zone:1444} Feralas · {zone:1456} Thunder Bluff
	["{zone:1452} and {zone:1448}, then {zone:1444} and {zone:1456}."] = "{zone:1452}和{zone:1448}，然后是{zone:1444}和{zone:1456}。",

	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "进入{zone:1452}",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556}就站在{area:1769}隧道的{zone:1452}出口处，也就是你出来的地方。",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "从隧道向南骑行：{npc:9298}在山谷西部{area:2246}热气腾腾的水池间扎营。",
	-- {quest:980} The New Springs
	["{quest:980}, from Krakle in Un'Goro"] = "{quest:980}，来自安戈洛环形山的克拉兰克",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas · {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide. {npc:9298}'s next errand, Strange Sources, is at the mouth of {area:2256} among level 59-60 elites: it waits for the last guide's {zone:1452} loop."] = "{quest:3909}稍后会在本指南中拿到，找{npc:7775}，他在{zone:1444}。{npc:9298}的后续任务《奇怪的源头》在{area:2256}入口，那里有59-60级精英。留到最后一份指南跑{zone:1452}环线时再做。",

	-- Step 4: Winterspring
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {npc:9298} Donova Snowden
	["Ride east along the road past {area:2251} to {area:2255} first: its yeti and chimaera errands bring you about a quarter of a level, which the Frostfire furbolg camps want; {npc:9298}'s camps come on the ride back west."] = "沿路向东经过{area:2251}，先到{area:2255}。那里的雪人和奇美拉任务能补约四分之一级经验，再去冰火温泉的熊怪营地就合适了。向西返回时再去{npc:9298}的营地。",

	-- Step 5: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "{area:2255}是山谷东侧、枭兽山丘另一边的地精城镇。",
	["Gregor's quests lead to other zones: keep them."] = "格雷戈的任务会把你带到其他地区：留着它们。",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "{npc:10431}：在屋内",

	-- Step 6: Ice Thistle yetis
	["Ice Thistle yetis"] = "冰蓟雪人",
	-- {area:2255} Everlook
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur. Careful: the Ice Thistle Yetis are 55-56: take the 55s one at a time, and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "从{area:2255}向东南走不远就是雪人出没的丘陵。所有雪人都会掉毛皮。小心，冰蓟雪人是55-56级，每次只引一只55级的。冰蓟雪人女王和冰蓟雪人王（56-58级）留到下次来收集角时再打。",

	-- Step 7: Chillwind chimaeras
	["Chillwind chimaeras"] = "冰风奇美拉",
	-- {area:2255} Everlook · {area:2251} Lake Kel'Theril · {area:2245} Mazthoril
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["The chimaeras roam the snowfields south and west of {area:2255}. Careful: Chillwind Chimaeras are 55-57: take only the 55s, and the Fledgling Chillwinds (53-55) by {area:2251}, which carry the horns too. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "奇美拉在{area:2255}南边和西边的雪原上游荡。小心，冰风奇美拉是55-57级，只打55级的。{area:2251}旁的冰风奇美拉幼兽（53-55级）也会掉角，也可以打。绕开{area:2245}的洞穴，里面的蓝龙族都是精英。",

	-- Step 8: Everlook
	-- {zone:1423} Eastern Plaguelands · {area:2255} Everlook
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 56"] = "乌米：先留着任务，约56级按{zone:1423}指南到{area:2255}时再收集完美的雪人角",
	["The Matriarchs and Patriarchs that carry Umi's horns are 56-58: leave them for that later stop."] = "携带乌米所需雪人角的冰蓟雪人女王和冰蓟雪人王有56-58级：留到之后那一站再打。",

	-- Step 9: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "狂暴的枭兽",
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {area:2246} Frostfire Hot Springs
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Ride back west: Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2255} and {area:2246}. Careful: the biggest are level 56: pull them one at a time."] = "向西返回。狂怒的枭兽在{area:2251}北边的丘陵游荡，靠近{area:2255}和{area:2246}之间的道路。小心，最高有56级，一次只引一只。",

	-- Step 10: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}：沿途击杀以下目标",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers are 55-56: pull the 55s, one at a time, and keep clear of the camps' totems."] = "冬泉探路者、冬泉巢穴守卫和冬泉图腾师都在温泉附近的熊怪营地。蓬毛枭兽在营地之间的山坡上游荡。先杀冬泉图腾师。捡到的{item:14047}全都留给梅罗什。\n小心，冬泉巢穴守卫是55-56级，一次只引一只55级的，避开营地里的图腾。",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "{item:12771}：冬泉熊怪约每十只掉一个，继续击杀直到掉落",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}，冬泉熊怪的稀有掉落",

	-- Step 11: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084}要在{zone:1448}的{object:176091}交还，留到之后那一趟。",

	-- Step 12: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "飞往{area:431}",
	-- {zone:1448} Felwood · {area:2255} Everlook · {area:431} Splintertree Post · {area:1237} Valormok
	["{zone:1448}'s southern hand-ins are next: ride back east to {area:2255}'s flight master, fly to {area:431} (by way of {area:1237}) and ride north into {zone:1448}, so the forest is ridden once, south to north."] = "接下来去{zone:1448}南部交任务。向东返回{area:2255}找飞行管理员，飞往{area:431}（途经{area:1237}），再向北进入{zone:1448}。这样只需从南到北穿过森林一次。",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "{area:2255}的飞行管理员",

	-- Step 13: Overlord Ror
	-- {zone:1448} Felwood · {area:1761} Deadwood Village
	["Ride north-west along the road into {zone:1448}. Ror stands at the far south end of {area:1761}, just inside the border."] = "沿路向西北进入{zone:1448}。洛尔在{area:1761}最南端，刚过边界就能找到。",

	-- Step 14: Taronn Redfeather
	["North to the druids' camp."] = "向北前往德鲁伊营地。",

	-- Step 16: Maybess Riverbreeze
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}，在翡翠圣地西侧",

	-- Step 18: Emerald Sanctuary
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {area:392} Ratchet
	["Keep {quest:5158}: {npc:5901} is by {area:392}, on the next guide."] = "留着{quest:5158}。{npc:5901}在{area:392}旁，按下一份指南再去找。",

	-- Step 19: The Jadefire moonwell
	["The Jadefire moonwell"] = "碧火月亮井",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride north-west past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "向西北经过{area:1763}，前往碧火萨特的腐化月亮井，把{npc:9996}的小瓶装满。",

	-- Step 20: Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["North up the road to {area:1997}."] = "沿路向北前往{area:1997}。",
	-- {npc:9996} Winna Hazzard · {quest:86612} Stag Lord's Bauble
	["{npc:9996}: the {quest:86612}"] = "{npc:9996}：{quest:86612}",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring · {zone:1423} Eastern Plaguelands
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{npc:10306}'s Moontouched Owlbeasts are 57-58, in {zone:1452}: keep it for the {zone:1423} guide's {zone:1452} stop."] = "{npc:10306}要你打的月光枭兽是57-58级，在{zone:1452}。留着任务，按{zone:1423}指南到{zone:1452}时再做。",

	-- Step 21: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "{npc:9996}的小猫",
	-- {item:12565} Winna's Kitten Carrier · {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten back to the Jadefire moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "把小猫带回碧火月亮井，用{item:12565}放出。等它变成{npc:10042}，把它带回{npc:9996}身边，再点击它交任务。",
	-- {item:12565} Winna's Kitten Carrier
	["{item:12565}, at the Jadefire moonwell"] = "{item:12565}，在碧火月亮井",
	-- {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard · {area:1997} Bloodvenom Post
	["Bring the {npc:10042} to {npc:9996} at {area:1997} and click on it to hand it over."] = "把{npc:10042}带到{area:1997}的{npc:9996}那里，点击它来交给她。",

	-- Step 23: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "飞往{area:1099}",
	-- {area:1997} Bloodvenom Post
	["{area:1997} flight master"] = "{area:1997}飞行管理员",

	-- Step 25: Evoroot
	-- {item:11242} Evoroot · {npc:7775} Gregan Brewspewer · {area:1114} Ruins of Ravenwind · {npc:9467} Miblon Snarltooth
	["The {item:11242} grows inside a ruined building north of {npc:7775}'s camp, east of the harpies' {area:1114}: climb in through the broken part of its wall.\nOr the front door: {npc:9467} guards it, and the Bait Gregan sells draws him off when you use it beside him. Half the players in our recordings went in that way, half through the wall."] = "{item:11242}长在{npc:7775}营地以北的一栋破屋里，位于鹰身人盘踞的{area:1114}东边。从墙上的缺口爬进去。\n也可以走正门，那里由{npc:9467}把守。在他身旁使用格雷甘卖的诱饵，就能把他引开。我们的录像里，一半玩家走正门，一半从墙上的缺口进去。",

	-- Step 26: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:976} Gadgetzan
	["Back south to {npc:7775}. Keep the elixir and don't drink it yet: it kills you, and that is how you meet Gaeriyan by {area:976} later."] = "向南回到{npc:7775}那里。留着药剂，先别喝：它会杀死你，而你之后正是这样在{area:976}旁见到盖瑞恩。",
	-- {item:11243} Videre Elixir · {npc:7775} Gregan Brewspewer
	["{item:11243}, {npc:7775}'s reward"] = "{item:11243}，{npc:7775}的奖励",

	-- Step 28: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飞往{area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408}的飞行管理员",

	-- Step 29: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on the central rise, not on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "到中央高地找{npc:10881}和{npc:14728}，别往{area:1641}找。拉姆斯塔格的每项捐献都需要背包里有60块对应的布料（毛料、丝绸或魔纹布）。有够数的就交，缺的跳过。",

	-- Step 30: Ghede
	-- {npc:9076} Ghede · {area:1639} Elder Rise
	["{npc:9076} stands on {area:1639}."] = "{npc:9076}站在{area:1639}。",

	-- Step 31: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{area:1639}的{npc:3033}；{npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123}在{zone:1450}等候：留到之后。",

	-- Step 32: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11103} Seed Voucher · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {item:11040} Morrowgrain
	["Hand {npc:9087} the {item:11103} for her packets of Tharlendris Seeds. {quest:3782} gives you the {item:11020}: use it with a seed packet and two {quest:3761} in your bags to grow a random herb, sometimes {item:11040}, once every ten minutes. She wants ten, so the quest is optional: take it if you have spare {quest:3761} and want to keep growing it over the next guides."] = "找{npc:9087}交{item:11103}，换取萨伦迪斯种子。{quest:3782}会给你{item:11020}。背包里有一包种子和两份{quest:3761}时，使用它可以随机种出一种草药，有时会出{item:11040}。每10分钟可以用一次。她要10份，所以这项任务可选。有多余的{quest:3761}、也愿意在接下来的几份指南里继续种，再接这个任务。",

	-- Step 34: Magatha Grimtotem
	-- {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise
	["{npc:4046} stands on {area:1639}."] = "{npc:4046}就在{area:1639}。",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["Delivery to {npc:4046}, from Jediga in {zone:1447}"] = "交给{npc:4046}，任务来自{zone:1447}的杰迪加",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["{npc:4046}'s payment goes back to Jediga in {zone:1447}, which the route doesn't pass again: leave it."] = "{npc:4046}的报酬要送回去给{zone:1447}的杰迪加。后续路线不会再经过那里，跳过。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "任何冬泉熊怪都可能携带冬泉灵魂珠串；{npc:11556}正南的营地最近。",
	-- ["Back at {area:1099}."] = "回到{area:1099}。",
	-- ["Back to {area:2255}"] = "返回{area:2255}",
	-- ["Below ground"] = "在地下",
	-- ["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "两项 {item:14047} 捐献都安排在路线后面交还：如果打算完成，每项各留六十块 {item:14047}。",
	-- ["Chillwind chimaeras"] = "冰风奇美拉",
	-- ["Fly to {area:1637}"] = "飞往{area:1637}",
	-- ["From Krakle in Un'Goro"] = "来自安戈洛的克拉兰克",
	-- ["Frostfire Winterfall camp"] = "冰火温泉的冬泉熊怪营地",
	-- ["Frostfire Winterfall camps"] = "冰火温泉的冬泉熊怪营地",
	-- ["Gregor's and Harlo's quests lead to other zones: keep them."] = "格雷戈和哈鲁的任务会把你带到其他地区：留着它们。",
	-- ["Grind to 55"] = "刷到55级",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "他站在{area:1641}。每次捐献都需要你背包里的布料；有了布料再交，在路线后面。",
	-- ["In the {object:172958}."] = "在{object:172958}。",
	-- ["In the {object:172961}."] = "在{object:172961}。",
	-- ["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "在 {object:172961} 内。每次捐赠会收取背包中的六十块毛料、丝绸或魔纹布：交还随身带的，其余跳过。",
	-- ["Level 55.04"] = "等级 55.04",
	-- ["Linken's letter"] = "林克的信",
	-- ["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "冰蓟雪人女王和冰蓟雪人王攻击很重：一次引一只。",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "冬泉探路者、冬泉巢穴守卫和冬泉图腾师共处于温泉周围的熊怪营地；蓬毛枭兽在营地之间的山坡上游荡。先杀冬泉图腾师。把拾取到的每一块{item:14047}都留给梅罗什。",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "冬泉探路者、冬泉巢穴守卫和冬泉图腾师共处于温泉周围的熊怪营地；蓬毛枭兽在营地之间的山坡上游荡。先杀冬泉图腾师。把拾取到的每一块{item:14047}都留给梅罗什。\n小心：冬泉巢穴守卫最高56级：一次引一只，并远离营地的图腾。",
	-- ["Pristine Yeti Horns"] = "完美的雪人角",
	-- ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}."] = "狂怒的枭兽出没于{area:2251}北面的山丘，就在{area:2246}与{area:2255}之间的路旁。",
	-- ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "狂怒的枭兽出没于{area:2251}北面的山丘，就在{area:2246}与{area:2255}之间的路旁。小心：最强的有56级：一次引一只。",
	-- ["Ride back west to {area:2246}."] = "向西骑回{area:2246}。",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "向东骑行，然后向南下到{area:2249}。那里的霜槌巨人是59级精英：走在中间，保持移动。奇怪的源头在南端{area:2256}的入口处。",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "沿道路向西经过{area:2251}；狂暴的枭兽在它北边的山丘上游荡。",
	-- ["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "奇美拉在{area:2255}南边和西边的雪原上游荡。远离{area:2245}的洞穴：里面的蓝龙龙人都是精英。",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "熊怪村庄占满了{area:2255}东北的山谷。先杀冬泉萨满祭司；他们会治疗。后面洞穴里的{npc:10738}是精英：别进去。",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur: work the Ice Thistle Yetis (55-56) and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "雪人的山丘就在{area:2255}东南不远处开始。每个雪人都会掉落毛皮：专打冰蓟雪人（55-56级），别碰冰蓟雪人女王和冰蓟雪人王（56-58级），它们的角留到以后再来时收集。",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "雪人的山丘就在{area:2255}东南不远处开始。每个雪人都会掉落毛皮；只有冰蓟雪人女王和冰蓟雪人王掉落角，所以交还后再去打它们。",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7775}'s camp, east of the harpies' {area:1114}: climb in through the broken part of its wall."] = "{item:11242}长在{npc:7775}营地北边、鹰身人的{area:1114}东边的一座废墟建筑里：从墙上破损的地方爬进去。",
	-- ["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. The Ice Thistle Yetis (55-56) are the lowest here; the Matriarchs and Patriarchs (56-58) hit harder. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "在这里补到55.04级，再去{area:2255}交任务，交完会升到56级。冰蓟雪人（55-56级）是这里等级最低的；冰蓟雪人女王和冰蓟雪人王（56-58级）打得更重。也可以组队去{area:1584}副本或{area:1583}副本（下层）。",
	-- ["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "乌米的第三个恶作剧针对的是{area:976}和安戈洛环形山的地精：留到之后。",
	-- ["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "乌米：先留着，完美的雪人角安排在{zone:1423}指南约57级时的{area:2255}一站",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "在{zone:1452}的{area:2244}刷{npc:7440}",
	-- ["grind on {npc:7458}"] = "击杀{npc:7458}刷经验",
	-- ["{area:2255} is the goblin town on the east side of the valley."] = "{area:2255}是山谷东侧的地精城镇。",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}，冬泉熊怪的稀有掉落",
	-- ["{npc:10307}, beside him"] = "{npc:10307}，在他旁边",
	-- ["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "{npc:10881}和{npc:14728}站在{area:1641}。拉姆斯塔格的每项捐献都需要背包中六十份毛料、丝绸或魔纹布：带了什么就交什么，其余跳过。",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
	-- ["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556}站在{area:1769}隧道的{zone:1452}出口旁，在温泉北边。",
	-- ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754}在{area:2255}巡逻，请在地图标示的圆圈内寻找",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}. He brews the {item:11243} only from an {item:11242} you bring him."] = "矮人{npc:7775}在{area:1099}西北的{area:1137}扎营。他只用你带来的{item:11242}调制{item:11243}。",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "矮人{npc:7775}在{area:1099}西北的{area:1137}扎营；他有药剂。",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087}收购用你的{quest:3761}种出来的{item:11040}。",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "{npc:9087}收购用{quest:3761}种出的{item:11040}。{quest:3782}需要十份，而{item:11020}每十分钟只能尝试一次：已有足够晨光麦再接。",
	-- ["{npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "{npc:9298}在山谷西部{area:2246}的热气腾腾的水池间扎营。",
	-- ["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909}来自{zone:1444}的{npc:7775}，在本指南稍后。",
	-- ["{zone:1456} flight master"] = "{zone:1456}飞行管理员",
}
