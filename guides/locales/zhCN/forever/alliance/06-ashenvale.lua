-- Chinese (simplified) (zhCN): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kerlonian Evershade
	-- {area:442} Auberdine · {area:448} Grove of the Ancients · {npc:11218} Kerlonian Evershade · {item:13536} Horn of Awakening · {zone:1439} Darkshore · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Back north from the glaive (Druids: south along the road from {area:442}) to the {area:448}, where {npc:11218} sleeps beside Arbal. Take his quest, open his chest for the {item:13536}, use it to wake him and lead him south along the road to his bag at the southern edge of {zone:1439}; blow the horn again whenever he falls asleep. Then go on to {npc:11219} at {area:413}.\nCareful: Scripted ambushes of three mobs each attack along the road."] = "",
	-- {object:176634} Kerlonian's Chest
	["{object:176634}, beside him"] = "他旁边的{object:176634}",
	-- {npc:11218} Kerlonian Evershade · {zone:1439} Darkshore · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Escort {npc:11218} south along the road to his bag at the southern edge of {zone:1439}, then go on to {npc:11219} at {area:413}."] = "",

	-- Step 4: Bathran's Haunt: kill these as you meet them
	-- {area:411} Bathran's Haunt
	["{area:411}: kill these as you meet them"] = "{area:411}：沿途击杀以下目标",
	-- {area:411} Bathran's Haunt · {item:5366} Glowing Soul Gem
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "在迈斯特拉岗哨以北，{area:411}的废墟周围散落着植物束。暗滩教徒占据着其南边的废墟：任何一个都可能掉落{item:5366}。",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}，来自植物束",

	-- Step 6: Astranaar
	-- {area:413} Maestra's Post · {npc:3845} Shindrell Swiftfire · {npc:4079} Sentinel Thenysil · {npc:3691} Raene Wolfrunner · {npc:3894} Pelturas Whitemoon
	["The road from {area:413} comes in by the flight master: {npc:3845} and {npc:4079} stand there, {npc:3691} in the inn, {npc:3894} inside the building beyond it."] = "从{area:413}过来的道路通向飞行管理员旁：{npc:3845}和{npc:4079}站在那里，{npc:3691}在旅店，{npc:3894}在旅店后方的建筑内。",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}，在旅店里",
	-- {npc:3691} Raene Wolfrunner · {quest:990} Trek to Ashenvale · {area:442} Auberdine
	["{npc:3691}: {quest:990}, from {area:442}"] = "",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}：在屋内",

	-- Step 7: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Head west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "向西前往{area:441}岸边。泰洛尼斯躺在盐沫鱼人之间，任意鱼人均有几率掉落{item:5463}。",

	-- Step 8: Shrine of Aessina
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["South of the murlocs, {npc:3585} waits at the {area:416}."] = "在鱼人南边，{npc:3585}在{area:416}等候。",

	-- Step 9: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "泪滴在{area:415}东边的小岛上发光。",

	-- Step 11: Stonetalon Mountains
	-- {area:421} Mystral Lake · {area:1276} Talondeep Path · {area:461} Windshear Crag · {area:2160} Windshear Mine
	["Head south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}, north of the {area:2160}."] = "",

	-- Step 12: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276}'s defence is hard alone at this level: grouping up is encouraged, look for people to do it with. Skip it if you are alone.\n{npc:4276} mines at the bottom of the {area:2160} at the east end of the crag, past its kobolds (levels 19-23). Talk to him, then keep him alive for five minutes while he mines: a dozen or more kobolds come at him in waves, melee fighters first, then casters, and the mine's own kobolds respawn into the fight. If he dies, the quest fails."] = "",
	["Below ground"] = "在地下",
	-- {npc:4276} Piznik
	["Keep {npc:4276} alive while he mines, below ground"] = "",

	-- Step 13: Windshear Crag
	-- {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle · {area:1076} Webwinder Path
	["{npc:4080} and {npc:4077} camp on the {area:1076}, south-west of the mine."] = "{npc:4080}和{npc:4077}的营地位于矿洞西南方的{area:1076}。",

	-- Step 14: Ziz Fizziks: Gerenzo's Orders
	-- {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle
	["His hut stands just north of {npc:4080} and {npc:4077}."] = "他的小屋就在{npc:4080}和{npc:4077}北边不远处。",
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "{npc:4201}：在屋内",

	-- Step 16: Windshear Crag: kill these as you meet them
	-- {area:461} Windshear Crag
	["{area:461}: kill these as you meet them"] = "{area:461}：沿途击杀以下目标",
	-- {area:461} Windshear Crag
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "风险投资公司正在砍伐{area:461}的森林。风险投资公司樵夫和风险投资公司砍树工遍布各处；风险投资公司操作员驾驶伐木机，其中一个带着蓝图。",

	-- Step 17: Webwinder Path
	["Inside"] = "在里面",

	-- Step 18: The Ruins of Stardust
	-- {area:1276} Talondeep Path · {area:421} Mystral Lake
	["Back north through the {area:1276}: west of {area:421}, the stardust bushes grow among the ruins."] = "向北穿过{area:1276}返回：星尘灌木长在{area:421}西边的废墟里。",

	-- Step 19: Alonso
	-- {npc:210995} Alonso · {area:1276} Talondeep Path
	["{npc:210995} may not offer these to every class; if he doesn't, carry on.; walks around {area:1276}: the map marks where to look"] = "{npc:210995}可能不会向所有职业提供这些任务；没有任务就继续路线。他在{area:1276}附近巡逻，地图标出了寻找范围。",

	-- Step 20: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885}站在{area:421}东岸的{area:420}；{npc:210995}在湖的西岸扎营。{npc:3917}在两者之间的湖里涉水。",
	["Underwater"] = "在水下",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "击杀元素获得5个{item:12220}，然后使用{item:5456}",

	-- Step 21: The Foulweald
	["The Foulweald"] = "污林",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "污林熊怪住在道路南边、{area:415}东南方的树林里。污林卫兵和污林巨熊怪守卫着洞穴。",

	-- Step 22: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "沿道路向东到{area:419}；{npc:3916}站在月亮井旁。",

	-- Step 23: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur furbolgs at the camp north of {area:415}. Clear his guards first, one at a time.\nCareful: The furbolgs near him usually join in when he is pulled. Killing the ones along his path first lets you fight him alone."] = "25 级的{npc:3987}带领蓟皮熊怪驻扎在{area:415}北侧营地。先逐个清理守卫。\n注意：拉首领时，附近熊怪通常也会参战。先清掉他巡逻路线上的熊怪，便可单独与他战斗。",

	-- Step 24: Ilkrud Magthrull
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar · {area:412} Ruins of Ordil'Aran · {npc:3664} Ilkrud Magthrull
	["From {npc:3987}'s camp head south-west past {area:415} (its hand-ins wait for the way back) to the {area:412} south of the shrine: {npc:3664} and his voidwalkers hold them. Pull his guards first."] = "从{npc:3987}的营地向西南，经过{area:415}（任务等返程时再交），前往神殿南边的{area:412}，那里由{npc:3664}和他的虚空行者占据。先引出他的守卫。",

	-- Step 25: The Zoram Strand
	-- {area:414} Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "沿海岸向北到{area:414}。{npc:3846}在海滩上扎营；岸边满是怒尾纳迦。",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}，在岸边的废墟里",
	-- {item:5490} Wrathtail Head
	["{item:5490}: any Wrathtail naga on the strand"] = "{item:5490}：海滩上的任意怒尾纳迦",

	-- Step 27: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009}带着怒尾卫兵在{area:414}北端巡逻。",

	-- Step 29: Maestra's Post
	-- {npc:3663} Delgren the Purifier · {zone:1440} Ashenvale
	["{npc:3663}: its circles are for your next {zone:1440} visit, at about 28"] = "{npc:3663}：法阵留到下次来{zone:1440}时处理，约28级",

	-- Step 30: Astranaar
	-- {area:413} Maestra's Post · {area:415} Astranaar · {npc:3845} Shindrell Swiftfire · {npc:3691} Raene Wolfrunner · {npc:3894} Pelturas Whitemoon
	["Follow the road south-east from {area:413} back to {area:415}: {npc:3845} by the flight master, {npc:3691} in the inn, {npc:3894} inside."] = "从{area:413}沿路向东南返回{area:415}：{npc:3845}在飞行管理员旁，{npc:3691}在旅店，{npc:3894}在建筑里。",

	-- Step 31: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "飞往{area:442}",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "{area:415}的飞行管理员",

	-- Step 32: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "乘船前往{area:150}",

	-- Step 33: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "前往{area:150}",

	-- Step 34: Menethil Harbor
	-- {npc:1242} Karl Boran · {npc:2094} James Halloran · {npc:2086} Valstag Ironjaw · {npc:1239} First Mate Fitzsimmons · {npc:1480} Caitlin Grassman · {npc:2111} Sida · {npc:2096} Tarrel Rockweaver
	["Off the boat, walk up the pier: {npc:1242} on the pier, {npc:2094} by the docks to the north, {npc:2086} in the keep, the inn ({npc:1239}) east of it with {npc:1480} and {npc:2111} beside it, {npc:2096} by the north gate on the way out east."] = "下船后沿栈桥往里走：{npc:1242}在栈桥上，{npc:2094}在北边码头旁，{npc:2086}在城堡里；旅店（{npc:1239}）位于城堡东边，{npc:1480}和{npc:2111}在旅店旁。向东出城时会经过北门旁的{npc:2096}。",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}，在旅店北边的码头上",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep; inside"] = "{npc:2086}，位于城堡内",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}，在旅店里",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}: he won't offer 305 while you carry it"] = "{npc:2096}：任务 305 已在日志中时，他不会再次提供",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}，在北门旁",

	-- Step 35: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "木材堆和铁堆散落在城堡周围和港口城墙沿线。",

	-- Step 36: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "沿海岸向北离开米奈希尔港。沼泽里满是{npc:1024}；{npc:1259}带着一群鱼人在沼泽中间游荡。",

	-- Step 37: Young crocolisks
	["Young crocolisks"] = "幼年鳄鱼",
	-- {zone:1437} Wetlands
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["From the marsh head east across the {zone:1437}. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "从沼泽向东穿过{zone:1437}。湿地鳄鱼幼崽潜伏在挖掘场北边的水潭里。",

	-- Step 38: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "挖掘场位于道路南边的山丘上。",
	-- {npc:1076} Merrin Rockweaver
	["{npc:1076}, below ground"] = "{npc:1076}：在地下",

	-- Step 39: The raptor hills
	["The raptor hills"] = "迅猛龙山丘",
	-- {npc:1021} Mottled Screecher
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor · Mottled Screechers = {npc:1021} Mottled Screecher
	["Mottled Raptors and Screechers roam the hills west of the excavation site.\nCareful: Once a {npc:1021} drops to 30% health, it calls for help from creatures within 20 yd. Mottled Screechers frequently come in packs of three, and raptors summoned by their calls for help may also join the fight."] = "杂斑迅猛龙和杂斑尖啸龙在挖掘场西侧的山丘活动。\n注意：{npc:1021}生命值降到 30% 时，会召唤 20 码内的生物协助。杂斑尖啸龙经常三只一组，其他迅猛龙也可能响应呼救加入战斗。",

	-- Step 40: Ormer Ironbraid
	-- {npc:1078} Ormer Ironbraid · {zone:1437} Wetlands
	["{npc:1078}: the bigger raptors in the valley west of the dig are for your next {zone:1437} visit, at about 27"] = "{npc:1078}：挖掘场西边山谷里的较大迅猛龙，留到下次来{zone:1437}时击杀，约27级",

	-- Step 41: The Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093}在路边扎营；{npc:1244}站在更东边的河旁。",

	-- Step 42: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "{area:1021}是挖掘场东南方的洞穴，里面满是{npc:4040}和{npc:1111}。",

	-- Step 43: The Mosshide gnolls
	["The Mosshide gnolls"] = "藓皮豺狼人",
	-- {area:1025} The Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "{npc:1007}和混血藓皮豺狼人占据着{area:1025}东南方的山丘。",

	-- Step 44: Rethiel the Greenwarden
	-- {area:309} Ironbeard's Tomb · {npc:1244} Rethiel the Greenwarden · {zone:1437} Wetlands
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Its flint comes from the Mosshide Fenrunners on the way to {area:309}; {npc:1244} takes it on your next {zone:1437} visit"] = "所需打火石由去{area:309}途中的藓皮沼泽行者掉落，下次来{zone:1437}时交给{npc:1244}",

	-- Step 45: Ironbeard's Tomb
	-- {npc:1244} Rethiel the Greenwarden · {area:309} Ironbeard's Tomb · {area:205} Dun Modr · {npc:2111} Sida
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner · Monstrous Oozes = {npc:1033} Monstrous Ooze
	["North-west from {npc:1244}: Mosshide Fenrunners and Mistweavers roam the riverbanks on the way, and almost every one drops flint. Black, Crimson and Monstrous Oozes fill {area:309}, just west of the road to {area:205} and north of Einar's camp. Any ooze there may hold {npc:2111}'s bag."] = "从{npc:1244}处向西北。途中河岸上有藓皮沼泽行者和藓皮织雾者，几乎每只都会掉落打火石。黑色软泥怪、红色软泥怪和残忍的软泥怪遍布{area:309}，就在通往{area:205}的道路西边、埃纳尔·石钳营地的北边。那里的任意软泥怪都有可能掉落{npc:2111}的背包。",
	-- {item:2611} Crude Flint
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["{item:2611}: Mosshide Fenrunners and Mistweavers"] = "{item:2611}：藓皮沼泽行者和藓皮织雾者",

	-- Step 46: Menethil
	["Menethil"] = "米奈希尔港",
	-- {npc:2096} Tarrel Rockweaver · {npc:2111} Sida · {npc:1480} Caitlin Grassman · {npc:2086} Valstag Ironjaw · {npc:2094} James Halloran · {npc:1242} Karl Boran
	["Back west along the road into Menethil: {npc:2096} by the road in, {npc:2111} and {npc:1480} at the inn, {npc:2086} in the keep, {npc:2094} on the west side by the docks, {npc:1242} on the pier north of the inn."] = "沿路向西返回米奈希尔港：{npc:2096}在进城的路旁，{npc:2111}和{npc:1480}在旅店，{npc:2086}在城堡里，{npc:2094}在西侧码头旁，{npc:1242}在旅店北边的栈桥上。",
	-- {npc:1480} Caitlin Grassman
	["{npc:1480}, inside"] = "{npc:1480}：在屋内",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, in the keep"] = "{npc:2086}，在城堡里",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier"] = "{npc:1242}，在栈桥上",

	-- Step 47: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飞往{area:1537}",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn: you have both flight paths since your first trip east."] = "{npc:1571}是米奈希尔港旅店旁的飞行管理员；第一次东行时，你就已经开通了这两处飞行点。",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "{area:150}的飞行管理员",

	-- Step 48: Ironforge
	-- {object:32372} Great Forge · {npc:4081} Lomac Gearstrip · {object:171524} Tinker Town · {area:2257} Deeprun Tram
	["The gryphons land in the {object:32372}. {npc:4081} stands in {object:171524}, east of it, by the {area:2257}."] = "狮鹫降落在{object:32372}。{npc:4081}站在其东边的{object:171524}，就在{area:2257}旁。",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "仅当有来自{zone:1439}的{item:5352}：{npc:2786}，{object:32383}",

	-- Step 49: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "顺路提示：向{npc:11865}学习{spell:197}（{object:32359}，10 银）；战士使用双手武器升级最快。",

	-- Step 50: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "顺路提示：向{npc:11865}学习{spell:199}（{object:32359}，10 银）；战士使用双手武器升级最快。",

	-- Step 51: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "顺路提示：向{npc:11865}学习{spell:197}（{object:32359}，10 银）；圣骑士使用双手武器升级最快。",

	-- Step 52: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "乘地铁前往{zone:1453}",

	-- Step 53: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston
	["The tram comes in at the {object:28027}; walk west to the {object:2098}: {npc:1646} stands at its east side. (The route hands his letter in at the end of 03-loch-modan; this is for a character still carrying it.)"] = "",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}：来自{area:442}的桑迪斯的信",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649}, back in {area:442} (06-wetlands)"] = "",

	-- Step 54: Cathedral Square
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:376} High Priestess Laurena
	["The tram comes in at the {object:28027}; walk west to the {object:2098}. {npc:376} is in the Cathedral of Light."] = "",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}：之后交给{zone:1455}的{npc:11406}",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}：之后交给{zone:1455}的{npc:258785}",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}：之后交给{zone:1457}的{npc:11401}",

	-- Step 55: Master Mathias Shaw
	-- {object:2100} Old Town
	["Mathias Shaw is at SI:7 in {object:2100}, south of the Keep."] = "马迪亚斯·肖尔在要塞南边{object:2100}的军情7处。",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}'s second loop"] = "{npc:332}：交给{zone:1436}的{npc:7024}，{zone:1431}第二轮路线结束时会去",

	-- Step 56: Collin Mauren
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6122} Gakin the Darkbinder
	["{object:2164} is in the {object:2101}. Warlocks: {npc:6122} is in its cellar."] = "{object:2164}位于{object:2101}。术士：{npc:6122}在其地下室。",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}：之后交给{zone:1413}的{npc:6244}",

	-- Step 57: Trade District
	-- {zone:1453} Stormwind · {zone:1431} Duskwood
	["Next: training in {zone:1453}, then the road east through Elwynn and south to {zone:1431}."] = "接下来：在{zone:1453}学习技能，沿路向东穿过艾尔文森林，再向南前往{zone:1431}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back north from the glaive (Druids: south along the road from {area:442}) to the {area:448}, where {npc:11218} sleeps beside Arbal. Take his quest, open his chest for the {item:13536}, use it to wake him and lead him south along the road into {area:331} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep.\nCareful: Scripted ambushes of three mobs each attack along the road: furbolgs on the {zone:1439} stretch and undead nearer {area:413}."] = "从巨刃处向北返回（德鲁伊：从{area:442}沿路向南），前往{area:448}，{npc:11218}睡在Arbal旁边。接下他的任务，打开他的箱子取得{item:13536}，用它唤醒他，沿路向南带他进入{area:331}，前往{area:413}的{npc:11219}处。每当他睡着时，就再吹一次号角。\n小心：途中会触发伏击，每波三只怪物；{zone:1439}路段是熊怪，靠近{area:413}时则是亡灵。",
	-- ["Back to the Cathedral of Light: {npc:928} stands inside."] = "回到光明大教堂：{npc:928}站在里面。",
	-- ["Black Oozes"] = "{npc:1032}",
	-- ["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "{npc:1032}在{area:1025}道路北边、{npc:2093}营地西边的沼泽里蠕动。任何软泥怪都可能带着{npc:2111}的包。",
	-- ["Cathedral of Light"] = "光明大教堂",
	-- ["Dragonmaw camp"] = "龙喉营地",
	-- ["Escort Kerlonian to {area:413} in {zone:1440}."] = "护送克罗尼亚·恒影到{zone:1440}的{area:413}。",
	-- ["Escort {npc:11218} to {area:413} in {area:331}."] = "护送{npc:11218}到{area:331}的{area:413}。",
	-- ["Fen Creepers"] = "{npc:1040}",
	-- ["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "{npc:1040}躲在{area:1025}西北方的沼泽水塘里。",
	-- ["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "沿道路向东。{npc:1417}潜伏在挖掘场北边的水塘里。",
	-- ["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "沿道路向北到{area:881}脚下的{area:205}。{npc:1071}站在矮人营地里。",
	-- ["Follow the road south-east to {area:415}, on the island in the lake."] = "沿道路向东南到湖心岛上的{area:415}。",
	-- ["For Bolvar Fordragon in {object:2117}: keep it"] = "交给{object:2117}的伯瓦尔·弗塔根公爵：先留着",
	-- ["For the giant crocolisks of the north coast, on your next visit"] = "留给北部海岸的巨型湿地鳄鱼，下次来时完成",
	-- ["For {npc:2228} in {area:271}: keep it"] = "交给{area:271}的{npc:2228}：先留着",
	-- ["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "从{area:17203}乘船前往{area:442}；{npc:3649}站在村子北端。然后沿道路向南骑行穿过{zone:1439}。",
	-- ["Head south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}, by the {area:2160}."] = "向南经过{area:421}，进入{area:1276}隧道；出口在石爪山的{area:461}，就在{area:2160}旁。",
	-- ["Hearth to Menethil"] = "用炉石返回米奈希尔港",
	-- ["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "炉石在冷却？向北骑行穿过{area:1276}返回。",
	-- ["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "克罗尼亚·恒影睡在{zone:1439}南部的{area:448}。使用{item:13536}唤醒他，带他沿道路向南进入{zone:1440}，到{area:413}找{npc:11219}；他每次睡着时都再吹一次号角。",
	-- ["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "{npc:1010}和藓皮织雾者在{npc:1244}西边和南边的河岸游荡；几乎每个都会掉落燧石。",
	-- ["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "{npc:1020}和杂斑尖啸龙在挖掘场西边的山丘上游荡。",
	-- ["Next: fly to {area:42}."] = "下一步：飞往{area:42}。",
	-- ["Only if you looted {quest:337} in {zone:1431}"] = "仅当你在{zone:1431}拾取了{quest:337}",
	-- ["Only once {quest:97914} is handed in: for {npc:3649}, back in {area:442} (06-wetlands)"] = "须先交{quest:97914}：之后回{area:442}交给{npc:3649}（06-wetlands）",
	-- ["Raptor valley"] = "迅猛龙山谷",
	-- ["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "沿{zone:1437}的道路向东骑行，向南穿过{area:836}进入{zone:1432}，再向西穿过隧道进入{zone:1426}，到达{area:1537}。",
	-- ["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "向南骑过{area:421}，进入{area:1276}隧道；出口在石爪山脉的{area:461}。{npc:4080}和{npc:4077}在峭壁西南方的{area:1076}扎营。",
	-- ["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "向西骑到{area:441}岸边。泰洛尼斯的尸体躺在盐沫鱼人中间；任何鱼人都可能掉落{item:5463}。",
	-- ["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "从{area:17203}乘船前往{area:442}，再飞往{area:702}；{npc:11401}在月神殿。然后飞回{area:442}。",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "从{area:17203}乘船前往{area:442}。把两块吊坠碎片合成{item:15885}，然后施放{spell:18960}：{npc:11802}在{area:2361}。之后飞往{area:702}（途经{area:442}）。",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "从{area:17203}乘船前往{area:442}。把两块吊坠碎片合成{item:15885}，然后施放{spell:18960}：{npc:11802}在{area:2361}。之后{area:2361}的{npc:11800}可以把德鲁伊直接送到{area:702}。{npc:11802}站在他所在建筑的楼上：从里面上楼，箭头无法区分楼层。",
	-- ["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "乘传送门上到{area:1658}，然后飞回{area:442}。",
	-- ["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "从{object:171524}乘{area:2257}前往{zone:1453}的{object:28027}，然后步行到{object:2098}。",
	-- ["The Bluegill hovels"] = "蓝腮鱼人小屋",
	-- ["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "龙喉营地在道路南边、{area:1025}西边不远处：龙喉袭击者、龙喉沼泽行者和龙喉白骨守卫。{npc:2092}在{zone:1426}的任务需要28级。",
	-- ["The bigger raptors hunt in the valley just west of the dig."] = "更大的迅猛龙在挖掘场西边的山谷里捕猎。",
	-- ["The excavation site sits on the hill south of the road."] = "挖掘场位于道路南边的山丘上。",
	-- ["The raptor hills"] = "迅猛龙山丘",
	-- ["The tram comes in at the {object:28027}; walk west to the {object:2098}. {npc:1646} stands at its east side, {npc:376} in the Cathedral of Light."] = "地铁在{object:28027}停靠，向西走到{object:2098}。{npc:1646}站在广场东侧，{npc:376}在圣光大教堂里。",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "鱼人小屋里的三个容器，从南到北：{object:261}，然后是{object:142151}，最后是北端的{object:259}。",
	-- ["Venture Co. loggers"] = "风险投资公司伐木者",
	-- ["West of Mystral Lake, the stardust bushes grow among the ruins."] = "在密斯特拉湖以西，星尘覆盖的草丛生长在废墟中。",
	-- ["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "在{zone:1437}的龙喉营地刷{npc:1034}和龙喉沼泽行者",
	-- ["{item:15885}: join the two halves"] = "{item:15885}：合并两块碎片",
	-- ["{npc:11218} sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {area:331} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep.\nCareful: Scripted ambushes of three mobs each attack along the road: furbolgs on the {zone:1439} stretch and undead nearer {area:413}."] = "{npc:11218}睡在{zone:1439}南部的{area:448}。使用{item:13536}唤醒他，带他沿道路向南进入{area:331}，到{area:413}找{npc:11219}；他每次睡着时都再吹一次号角。\n小心：沿途会有预设的伏击，每次三个怪：{zone:1439}路段是熊怪，靠近{area:413}时是亡灵。",
	-- ["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406}和{npc:258785}在{object:32362}的{object:32386}。",
	-- ["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}：交给城堡里的{npc:2104}",
	-- ["{npc:1242}: offered once {quest:286} (286) is handed in; for {npc:2104} in the keep"] = "{npc:1242}：交还{quest:286}（286）后提供；交给城堡里的{npc:2104}",
	-- ["{npc:1440}, in the Royal Library"] = "{npc:1440}，在皇家图书馆",
	-- ["{npc:1444}, in the {object:2098}"] = "{npc:1444}，在{object:2098}",
	-- ["{npc:1573}, in the {object:32372}"] = "{npc:1573}，在{object:32372}",
	-- ["{npc:2086}, by the keep"] = "{npc:2086}，在城堡旁",
	-- ["{npc:2094}, by the north gate"] = "{npc:2094}，在北门旁",
	-- ["{npc:2097}, by the north gate"] = "{npc:2097}，在北门旁",
	-- ["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104}站在{area:2103}，离{npc:1242}不远。",
	-- ["{npc:2104}, on the top floor of the keep"] = "{npc:2104}，在城堡顶层",
	-- ["{npc:210995} may not offer these to every class; if he doesn't, carry on."] = "{npc:210995}可能不会向所有职业提供这些任务；如果没有，就继续路线。",
	-- ["{npc:3649}: Alexston's reply"] = "{npc:3649}：巴隆斯·阿历克斯顿的回信",
	-- ["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664}和他的虚空行者占据着神殿南边的{area:412}。先拉他的卫兵。",
	-- ["{npc:3691}: {quest:990}, from {area:442} (others take it on the next {area:331} visit)"] = "{npc:3691}：交{area:442}接到的{quest:990}（其他人在下次来{area:331}时接）",
	-- ["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987}（25级）率领{area:415}北边营地的蓟皮豺狼人。先清理他的卫兵，一次一个。",
	-- ["{npc:4201}, in the hut north of them"] = "{npc:4201}，在他们北边的小屋里",
	-- ["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276}在峭壁东端的{area:2160}采矿。和他交谈，在他采矿时击退风险投资公司的袭击者。",
	-- ["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines.\nCareful: The kobolds arrive in waves. The first wave is melee fighters, and the second adds casters to the mix. Regular mobs in the mine respawn quickly and can join the fight while the waves are coming. A group is recommended."] = "{npc:4276}在峭壁东端的{area:2160}内采矿。与他交谈，并在他采矿期间击退风险投资公司的袭击者。\n注意：狗头人会分波次出现，第一波是近战敌人，第二波开始加入施法者。矿洞内普通怪刷新很快，可能在伏击期间加入战斗。建议组队。",
	-- ["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}，在{object:2096}的奶酪店",
	-- ["{npc:4959} and {npc:482}"] = "{npc:4959}和{npc:482}",
	-- ["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}，在光明大教堂",
	-- ["{npc:5082}, Mikhail and Tapoke Jahn are all at Menethil's inn; Tapoke fights you when you talk to Mikhail, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn.\n{npc:2104} stands on the top floor of {area:2103}."] = "{npc:5082}、米克海尔和塔波克·贾恩都在米奈希尔的旅店里；和米克海尔交谈时塔波克会攻击你，被打败后就会认输。{npc:1480}站在旅店东北方不远处。\n{npc:2104}站在{area:2103}的顶层。",
	-- ["{object:2164} is in the {object:2101}."] = "{object:2164}在{object:2101}。",
	-- ["{zone:1455} priests"] = "{zone:1455}的牧师",
}
