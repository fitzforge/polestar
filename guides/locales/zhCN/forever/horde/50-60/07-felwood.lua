-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 2: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}."] = "在{object:172961}。",
	-- {item:14047} Runecloth
	["sixty {item:14047}"] = "六十块{item:14047}",

	-- Step 4: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "飞往{area:431}",

	-- Step 5: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 6: The Emerald Sanctuary
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "飞往{area:431}，沿道路向西北离开{zone:1440}进入{zone:1448}。{area:2479}是刚过边界的德鲁伊营地。",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}：在屋内",
	-- {quest:4084} Silver Heart · {item:11172} Silvery Claws · {item:11173} Irontree Heart · {area:1767} Irontree Woods · {npc:9116} Eridan Bluewind
	["{quest:4084}'s {item:11172} and {item:11173} come from {area:1767} on this guide's ride north; {npc:9116} takes them at the end of the guide, back here."] = "做{quest:4084}需要的{item:11172}和{item:11173}，在跟随本指南向北骑行时去{area:1767}收集。到本指南末尾再回这里交给{npc:9116}。",

	-- Step 7: Rakaiah
	-- {npc:11019} Jessir Moonbow · {npc:9518} Rakaiah · {item:13140} Blood Red Key · {area:1763} Jaedenar · {area:1770} Shadow Hold
	["Only if {npc:11019} sent you after {npc:9518} (the {item:13140}'s chain): on the ride north, turn west into {area:1763} and go into {area:1770}, the cave at the back of the camp. {npc:9518} (56) and the remains of Trey Lightforge are inside: kill her first, then the remains take her quest and give the next, which goes back to {npc:11019} at the end of this guide."] = "只有{npc:11019}派你去找{npc:9518}时才做，这是{item:13140}的任务链。向北骑行途中，往西拐进{area:1763}，再进入营地后方的洞穴{area:1770}。{npc:9518}（56级）和特雷·莱弗治的残骸都在里面。先击杀她，再到残骸处交任务并接后续。到本指南末尾回去找{npc:11019}交后续任务。",

	-- Step 9: Trull Failbane
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "沿道路向北骑行，经过{area:1763}，前往{area:1997}。",

	-- Step 10: Bloodvenom Post
	-- {npc:10306} Trull Failbane · {quest:4721} Wild Guardians · {area:2255} Everlook · {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{npc:10306}'s last {quest:4721} are the Berserk Owlbeasts north of {area:2255}, on this guide's {zone:1452} loop; he takes them at the end of the guide, back here."] = "{npc:10306}的最后一步{quest:4721}要击杀狂暴枭兽。它们在{area:2255}北边，本指南的{zone:1452}环线会经过那里。到本指南末尾再回这里找他交任务。",

	-- Step 11: Toxic Horrors
	-- {zone:1448} Felwood · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors · {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {item:11172} Silvery Claws · {npc:14524} Vartrus the Ancient
	-- plural, as words: Irontree Wanderers = {npc:7138} Irontree Wanderer · Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet. The Irontree Wanderers and Stompers (52-53) there carry {npc:9116}'s {item:11173}, the Angerclaw bears and Felpaw wolves his {item:11172}.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "沿{zone:1448}的道路向北骑到{area:1767}。{quest:5086}的软泥怪在树间蠕动，多数会掉落一份液滴。这里的铁木游荡者和铁木践踏者（52-53级）携带{npc:9116}要的{item:11173}，怒爪熊和魔爪狼携带他要的{item:11172}。\n小心59级精英 远古铁木漫步者，它们在{quest:5086}的任务怪之间走动。{npc:14524}（63级精英）也在林中游荡。到{area:1767}最北端打软泥怪，一次只打一只。",

	-- Step 13: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "穿过木喉隧道前往{zone:1450}。{npc:11939}在{area:2361}的一座房子里读书。",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939}在{area:2361}巡逻，请在地图标示的圆圈内寻找",

	-- Step 15: Class trainer
	["Class trainer"] = "职业训练师",

	-- Step 16: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "{npc:11801}的魔藤碎片需要{area:2577}。跳过它。",

	-- Step 19: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "回到木喉隧道，走{zone:1452}出口；{npc:9298}就在出口外的温泉旁扎营。",
	["From Krakle in Un'Goro, if you didn't bring it to her earlier"] = "任务来自安戈洛环形山的克拉兰克。如果之前没交给多诺瓦，现在交。",

	-- Step 20: Winterfall Runners
	-- {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {spell:5384} Feign Death
	["The runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "信使以小队形式沿路从{area:1769}前往{area:2244}；在{npc:9298}附近的路边等候，经过时击杀。每名都携带一个箱子。\n小心：交还任务后会出现三四名56-57级冬泉伏兵攻击你；可以骑乘、潜行或使用{spell:5384}逃脱。之后它们会聚集在湖边，就能接下一个任务。",

	-- Step 21: Salfa
	-- {quest:8464} Winterfall Activity · {area:2255} Everlook · {area:2256} Darkwhisper Gorge
	["{quest:8464}'s village is north-east of {area:2255}, on this guide's way back from {area:2256}."] = "{quest:8464}的村庄在{area:2255}东北，就在本指南从{area:2256}返回的路上。",

	-- Step 22: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["With 30 {quest:6031} in your bags: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "背包里带着30块{quest:6031}：沿道路向北前往{area:1769}；{npc:11557}就在入口内侧交易。",
	["Below ground"] = "在地下",

	-- Step 23: Kernda
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if you are Neutral with the Timbermaw now (the {area:1769} reputation guide gets you there): {npc:11558} waits at the tunnel mouth of {area:1769}."] = "从{area:1762}拿到的死木仪祭图腾，等木喉要塞声望达到中立再交（按{area:1769}声望指南即可达到）。{npc:11558}在{area:1769}隧道口等候。",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558}在附近巡逻，请在地图标示的圆圈内寻找",

	-- Step 24: Witch Doctor Mau'ari
	-- {area:2255} Everlook · {npc:11755} Harlo Wigglesworth · {npc:10307} Witch Doctor Mau'ari · {area:2249} Frostwhisper Gorge
	["Ride east along the road to {area:2255}: {npc:11755} sends you to {npc:10307}, who stands in the town, on the way to {area:2249}."] = "沿道路向东骑往{area:2255}。{npc:11755}会让你找镇上的{npc:10307}，去{area:2249}的路上顺路过去。",

	-- Step 26: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59-60: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "向东骑行，再沿{area:2249}向南下行。那里的霜槌巨人是59-60级精英，走中间，一直往前。奇怪的源头在南端{area:2256}的入口处。",

	-- Step 27: Frostmaul Shards
	-- {area:2249} Frostwhisper Gorge · {npc:10198} Kashoch the Reaver
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant
	["The shards lie on the ground along the west side of {area:2249}, among the Frostmaul Giants and Preservers. Careful: the giants are elites of 59-60: pick up the shards that lie clear of them, wait for a patrol to pass, and leave {npc:10198} (60, east side) alone."] = "碎片散落在{area:2249}西侧的地上，周围有霜槌巨人和霜槌保卫者。小心，这些巨人是59-60级精英。等巡逻怪走过，捡离它们较远的碎片，避开{npc:10198}（60级，在东侧）。",

	-- Step 28: Level 59.7
	["Level 59.7"] = "升到59.7级",
	-- {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {npc:11556} Salfa · {npc:10306} Trull Failbane · {npc:9116} Eridan Bluewind · {area:2249} Frostwhisper Gorge · {area:1769} Timbermaw Hold · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["Top up here to about level 59.7 before the last hand-ins: Umi, Vizzie, Mau'ari, {area:2244}, {npc:9298}, {npc:11556}, {npc:10306} and {npc:9116} take you the rest of the way to 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "在这里把经验补到约59.7级，再去交最后几站的任务。在乌米、维兹奇、玛艾里、{area:2244}、{npc:9298}、{npc:11556}、{npc:10306}和{npc:9116}这几站交完就能到60级。{area:2249}里，奇怪的源头北边不远处有疯狂的碎齿熊（59级），它们给的经验比{area:1769}旁的熊怪多得多。组队的话，也可以改打{area:2057}或{area:2279}副本。",
	-- {npc:7446} Rabid Shardtooth
	["grind on {npc:7446}"] = "击杀{npc:7446}刷经验",

	-- Step 29: Ice Thistle yetis
	["Ice Thistle yetis"] = "冰蓟雪人",
	-- {area:2255} Everlook · {item:258323} Missing Mail
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["On the ride north to {area:2255}, the Ice Thistle Yetis (55-56) in the hills south-east of the town carry Vizzie's {item:258323}: four pieces."] = "向北骑往{area:2255}的路上，到镇东南的山丘打冰蓟雪人（55-56级），收集四封维兹奇要的{item:258323}。",

	-- Step 30: Are We There, Yeti?
	-- {area:2255} Everlook
	["Ride north to {area:2255}."] = "向北骑往{area:2255}。",
	-- {npc:10978} Legacki · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10978} with {npc:10980}"] = "用{npc:10980}吓唬{npc:10978}",

	-- Step 31: Everlook
	-- {npc:11118} Innkeeper Vizzie · {quest:93406} Unfrozen Deliveries
	["{npc:11118}, in the inn: {quest:93406}"] = "在旅店找{npc:11118}交{quest:93406}",

	-- Step 33: Winterfall Village
	-- {area:2255} Everlook · {quest:5121} High Chief Winterfall
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {quest:5121} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "熊怪村庄坐落在{area:2255}东北的山谷里。先打冬泉萨满祭司，他们会治疗。{quest:5121}（59级精英）和沙迪维尔斯（62级）在村子后方的洞里，别进洞。",

	-- Step 34: Berserk Owlbeasts
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Berserk Owlbeasts"] = "狂暴枭兽",
	-- {area:2241} Frostsaber Rock · {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["The Berserk Owlbeasts (58-59) roam the slopes of {area:2241}, north of {area:2255} and west of the furbolg valley. Now and then an owlbeast drops a {item:12558}: use it to start {quest:4882}."] = "狂暴枭兽（58-59级）在{area:2241}的山坡上游荡，位置在{area:2255}以北、熊怪山谷以西。枭兽偶尔会掉落{item:12558}，使用它可开启{quest:4882}。",

	-- Step 35: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west along the road to {area:2246}."] = "沿道路向西骑回{area:2246}。",

	-- Step 36: High Chief Winterfall
	-- {npc:9298} Donova Snowden · {quest:5121} High Chief Winterfall · {area:2244} Winterfall Village · {area:2255} Everlook · {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["A group choice: {npc:9298} sends you after {quest:5121} (59, elite, with his guards) in the cave at the back of {area:2244}, back east past {area:2255}; Xandivious (62) shares the cave: leave him. The High Chief carries a log for {npc:9298}, and her next errand goes to {npc:10920} at the {area:2479}, this guide's last stop."] = "组队可做。{npc:9298}让你击杀{quest:5121}（59级精英，身边有守卫）。他在{area:2244}后方的洞穴里，往东折返，经过{area:2255}就能到。沙迪维尔斯（62级）也在洞里，别打他。酋长身上有一本日志，带回给{npc:9298}。她给的后续任务要找{npc:10920}，他在本指南的最后一站{area:2479}。",
	-- {quest:5121} High Chief Winterfall
	["{quest:5121}, in the cave"] = "{quest:5121}在洞里",
	["the log he carries"] = "他携带的日志",
	-- {npc:9298} Donova Snowden
	["{npc:9298}, back west at the hot springs"] = "向西返回温泉找{npc:9298}",
	-- {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["for {npc:10920} at the {area:2479}"] = "交给{npc:10920}，他在{area:2479}",

	-- Step 37: Salfa
	-- {zone:1452} Winterspring
	["North of Donova, at the tunnel's {zone:1452} exit."] = "在多诺瓦北边，隧道的{zone:1452}出口处。",

	-- Step 38: Beads for Salfa
	-- {npc:11556} Salfa · {quest:8464} Winterfall Activity
	["{npc:11556} takes the beads only once {quest:8464} is handed in: any Winterfall furbolg can carry them, and the camps just south of {npc:11556} are the closest."] = "交还{quest:8464}后{npc:11556}才收珠串：任何冬泉熊怪都可能携带，{npc:11556}正南的营地最近。",
	["Frostfire Winterfall camp"] = "冰火温泉的冬泉熊怪营地",

	-- Step 40: Trull Failbane
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post
	["Back through the Timbermaw tunnel and south down the {zone:1448} road to {area:1997}."] = "穿过木喉隧道返回，沿{zone:1448}的道路向南到{area:1997}。",

	-- Step 41: Trull Failbane
	-- {quest:4882} Guarding Secrets · {item:12558} Blue-feathered Necklace
	["{quest:4882}, from the {item:12558}"] = "{quest:4882}由{item:12558}开启",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["{quest:4882} goes on to {npc:5770} in {zone:1456}, off this route: leave it."] = "{quest:4882}的后续要去找{npc:5770}，地点在{zone:1456}。这趟要绕路，跳过。",

	-- Step 42: Jessir Moonbow
	-- {area:2479} Emerald Sanctuary · {npc:11019} Jessir Moonbow
	["South along the road to the {area:2479}: {npc:11019}, at its east side, takes Trey Lightforge's remains."] = "沿道路向南前往{area:2479}，把特雷·莱弗治的残骸交给东侧的{npc:11019}。",

	-- Step 43: Kelek Skykeeper
	-- {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["{npc:10920}, at the {area:2479}, takes the High Chief's words."] = "{npc:10920}在{area:2479}，把熊怪酋长的话转告给他。",

	-- Step 44: Eridan Bluewind
	-- {area:2479} Emerald Sanctuary
	["South along the road to the {area:2479}."] = "沿道路向南前往{area:2479}。",
	-- {npc:9116} Eridan Bluewind · {zone:1446} Tanaris
	["{npc:9116}'s Aquementas leads on to {zone:1446} and Un'Goro: leave it."] = "{npc:9116}的任务《亚奎门塔斯》要去{zone:1446}和安戈洛环形山，跳过。",
	-- {zone:1454} Orgrimmar · {area:431} Splintertree Post
	["In {zone:1454}: fly from {area:431}"] = "从{area:431}飞往{zone:1454}",
	-- {zone:1456} Thunder Bluff
	["In {zone:1456}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "掉落了一把{item:13140}：暗影堡的加德纳尔执行者、织暗者、术士和军团士兵偶尔会携带。使用它接取任务，离开时顺便把{npc:11018}从洞穴南端的笼子里救出来。",
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "任何冬泉熊怪都可能携带冬泉灵魂珠串；{npc:11556}正南的营地最近。",
	-- ["Back into the Timbermaw tunnel and take the {area:618} exit; {npc:9298} camps by the hot springs just outside."] = "回到木喉隧道，走{area:618}出口；{npc:9298}就在出口外的温泉旁扎营。",
	-- ["Back south to the Sanctuary, a short ride."] = "向南回到翡翠圣地，路程很短。",
	-- ["Corrupted Soul Shards from the cultists, {quest:5887}"] = "从信徒身上收集腐化的灵魂碎片，{quest:5887}",
	-- ["Dungeon instead of grinding"] = "用地下城代替刷怪",
	-- ["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {area:361}. The {area:2479} is the druids' camp just past the border."] = "飞往{area:431}，沿道路向西北离开{zone:1440}进入{area:361}。{area:2479}是刚过边界的德鲁伊营地。",
	-- ["From Krakle in Un'Goro"] = "来自安戈洛的克拉兰克",
	-- ["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "在{zone:1458}城外的塔上乘飞艇前往{zone:1454}。",
	-- ["Grind to 60"] = "刷到60级",
	-- ["In {zone:1454}: fly from {area:2255}"] = "在{zone:1454}：从{area:2255}飞过去",
	-- ["In {zone:1456}: fly from {area:2255}"] = "在{zone:1456}：从{area:2255}飞过去",
	-- ["Level 59.9"] = "等级 59.9",
	-- ["On the way back south to Greta, {npc:9529} takes the shards on the west side of the Sanctuary."] = "在向南返回格雷塔处的路上，在翡翠圣地西侧把碎片交给{npc:9529}。",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "仅当你有{quest:5087}时：信使们成小群地沿着从{area:1769}到{area:2244}的道路行走；在{npc:9298}附近的路边等候，在他们经过时杀死他们。每个都带着一个箱子。",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "仅在接有 {quest:5087} 时进行：信使以小队形式沿道路从 {area:1769} 前往 {area:2244}；在 {npc:9298} 附近路边等待，经过时击杀。每名都携带一个箱子。\n小心：交还任务后会出现三四名56—57级冬泉伏兵攻击你；可以骑乘、潜行或使用 {spell:5384} 逃脱。之后它们会聚集在湖边，你就能接下一个任务。",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {area:361} road to {area:1767}; the {quest:5086} ooze between the trees."] = "仅当{npc:9298}给了你{quest:5086}时：沿{area:361}的道路向北骑往{area:1767}；{quest:5086}在树木之间蠕动。",
	-- ["Only with 30 {quest:6031}, and only at Neutral with the Timbermaw: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "仅当你有30块{quest:6031}，且木喉要塞声望达到中立时：沿道路向北前往{area:1769}；{npc:11557}就在入口里面交易。",
	-- ["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "可选。和队伍一起刷{area:2279}、{area:2057}、黑石塔下层或{area:1584}，代替刷怪能更快到达。",
	-- ["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "可选：有队伍时，用一个55-60级的地下城代替下面的刷怪。",
	-- ["Ride back west to {area:2246}."] = "向西骑回{area:2246}。",
	-- ["Ride east along the road to {area:2255}."] = "沿道路向东骑往{area:2255}。",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "向东骑行，然后向南下到{area:2249}。那里的霜槌巨人是59级精英：走在中间，保持移动。奇怪的源头在南端{area:2256}的入口处。",
	-- ["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "沿{zone:1448}的道路向北骑往{area:1767}；{quest:5086}在树木之间蠕动，大多数都会掉落一份液滴。\n小心：59级精英远古铁木行者在{quest:5086}之间走动，{npc:14524}（63级，精英）在树林中游荡：在{area:1767}的最北端一次打一只。",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "向西北骑往{area:1763}。四个火盆立在暗影议会的建筑之间；对每一个使用净化后的水。",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "骑行向西北前往 {area:1763}。四座火盆位于暗影议会的建筑之间；对每一座使用净化过的水。\n小心：洞穴中遍布 53-55 级的暗影议会怪物，它们经常以多只联动的大群出现，其中许多会昏迷技能。建议 2-3 名玩家组队。",
	-- ["South to the Sanctuary once more."] = "再次向南前往翡翠圣地。",
	-- ["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then: she waits at the tunnel mouth of {area:1769} and speaks to you from Neutral with the Timbermaw, which the Deadwood furbolgs of {zone:1448} brought you to."] = "{area:1762}取得的死木仪祭图腾，如果当时{npc:11558}没有收下，就在这里交给她。她在{area:1769}隧道口等候，木喉要塞声望达到中立即可与她交谈；此前击杀{zone:1448}的死木熊怪已将声望提升到中立。",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "熊怪村庄占满了{area:2255}东北的山谷。先杀萨满，他们会治疗。{npc:10738}（59级，精英）和山迪维斯（62级）在后面的洞里：别进去。",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {area:618}, south of the road from {area:2255}."] = "任务到这里就没了。疯狂的碎齿熊在{area:618}南部的{area:2249}潜行，位于从{area:2255}出发的道路南边。",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "任务到这里就没了。疯狂的碎齿熊在{zone:1452}南部的{area:2249}潜行，位于从{area:2255}出发的道路南边。",
	-- ["The zeppelin towers"] = "飞艇塔",
	-- ["Through the Timbermaw tunnel to {area:493}. {npc:11939} reads in a house in {area:2361}."] = "穿过木喉隧道前往{area:493}。{npc:11939}在{area:2361}的一座房子里读书。",
	-- ["Top up here to level 59.9 before the hand-ins at {area:618}: they take you to level 60. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "先在这里补到59.9级，再去{area:618}交任务，这些任务会让你升到60级。也可组队挑战{area:2057}或{area:2279}副本。",
	-- ["Top up here to level 59.9 before the hand-ins at {zone:1452}: they take you to level 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "先在这里练到59.9级，再去{zone:1452}交任务，交完即可升到60级。{area:2249}的疯狂的碎齿熊（59级）就在奇怪的源头以北，提供的经验远多于{area:1769}旁的熊怪。也可组队挑战{area:2057}或{area:2279}副本。",
	-- ["Trey Lightforge's remains lie at the edge of the {area:1763} camp, west of the road: they go back to {npc:11019} at the end of this guide."] = "特雷·莱特弗格的遗骸在{area:1763}营地边缘、道路以西：它们会在本指南结束时回到{npc:11019}那里。",
	-- ["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",
	-- ["grind on {npc:7441}"] = "击杀{npc:7441}刷经验",
	-- ["grind on {npc:7446} at {area:2249}, {area:618}"] = "在{area:618}的{area:2249}刷{npc:7446}",
	-- ["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "在{zone:1452}的{area:2249}刷{npc:7446}",
	-- ["only if still carried: the {zone:1423} guide hands it in on its way through"] = "仅在仍带着时：{zone:1423}指南路过时会交还",
	-- ["sixty {item:14047}, if you carry them"] = "六十块 {item:14047}，如果你带着的话。",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {area:618}. Skip it."] = "{npc:10306}的下一个任务{quest:4741}会让你从{area:618}跑回这里。跳过它。",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "{npc:10306}的下一个任务{quest:4741}会让你从{zone:1452}跑回这里。跳过它。",
	-- ["{npc:11016}, below ground"] = "{npc:11016}：在地下",
	-- ["{npc:11558}, at the tunnel mouth; walks around here: look inside the circle on the map"] = "{npc:11558} 在隧道口附近走动：在地图上圆圈标出的范围内寻找",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {area:361} and a ride back here. Skip it."] = "{npc:9116}的银色之心需要{area:361}北部的一个{item:11173}，还要再骑回这里。跳过它。",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "{npc:9116}的银色之心需要{zone:1448}北部的一个{item:11173}，还要再骑回这里。跳过它。",
	-- ["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "{npc:9298}接下来让你去对付{npc:10738}，他是洞穴里的精英。跳过它。",
	-- ["{npc:9529} stands on the west side of the Sanctuary, the way out to {area:1763}. With {quest:4102} done, her {quest:5887} asks for six Corrupted Soul Shards: the Shadow Council cultists in {area:1763} and {area:1770} drop them about one kill in three, and you fight dozens of them for {npc:10922}."] = "{npc:9529}站在翡翠圣地的西侧，也就是通往{area:1763}的出口处。完成{quest:4102}后，她的{quest:5887}要求你收集六块腐化的灵魂碎片：{area:1763}和{area:1770}的暗影议会信徒大约每击杀三个会掉落一块，而你为{npc:10922}要击杀几十个这样的信徒。",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}、{npc:9860}和{npc:9517}在{area:1763}北部的洞穴{area:1770}深处等候。一路清理隧道。",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "{npc:9861}、{npc:9860} 和 {npc:9517} 在 {area:1770} 深处等着，那是 {area:1763} 北边的洞穴。边走边清理通道。\n小心：三名首领会一起战斗。先清掉周围的小怪，避免额外引怪。",
}
