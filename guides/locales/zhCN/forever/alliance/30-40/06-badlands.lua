-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "进入{zone:1418}",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Head back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "向西回到道路，再沿路向南离开{zone:1432}，穿过山口进入{zone:1418}。{npc:2910}和{npc:2860}在挖掘场并排扎营。",

	-- Step 4: Hammertoe's Digsite: kill these as you meet them
	-- {area:346} Hammertoe's Digsite
	["{area:346}: kill these as you meet them"] = "{area:346}：沿途击杀以下目标",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "暗炉矮人在挖掘场北边不远处扎营；弄皱的地图在他们的帐篷之间。暗炉隧道工和暗炉巫师带着勘察员雷杜尔的镐。{npc:2727}在周围的山坡上游荡。",

	-- Step 5: The excavation crate
	["The excavation crate"] = "挖掘补给箱",
	["Head north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "向东北前往废弃挖掘场，补给箱就在火烟食人魔之间。",

	-- Step 6: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "勘察员雷杜尔的下一个差事要进入{area:1517}：跳过。",

	-- Step 7: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618}和{npc:2817}一起在{zone:1418}中部的{area:1877}扎营。",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "蚌壳在荆棘谷西北海岸，在下一份指南里：先留着",

	-- Step 8: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "破损的骷髅就在食人魔东边、石窟穴居人营地边缘；周围的石窟断骨者和石窟萨满祭司掉落碎片。迷失者塞尔杜林坐在更南边的废弃营地旁。",

	-- Step 9: Agmond's End: kill these as you meet them
	-- {area:345} Agmond's End
	["{area:345}: kill these as you meet them"] = "{area:345}：沿途击杀以下目标",
	-- {quest:739} Murdaloc · {spell:5242} Battle Shout · {spell:1160} Demoralizing Shout · {area:340} Kargath
	-- plural, as words: Dustbelcher Lords = {npc:2719} Dustbelcher Lord
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east.\nThe battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers.\nCareful: Dustbelcher Lords are level 44-45. They use {spell:5242} and {spell:1160}, and below 50% health they call for help from allies within 15 yd. Seven of them stand about 750 yd south of {area:340}."] = "火烟食人魔在山谷南边不远处扎营；任何一个都会掉落废料。秃鹫在东边的平原上空盘旋。\n破损的骷髅在石窟穴居人营地边缘；杀死阿格蒙德的凶手{quest:739}在石窟断骨者之间游荡。\n小心：火烟领主为44-45级。它们会使用{spell:5242}和{spell:1160}，生命值低于50%时会向15码内的同伴求援。有七个站在{area:340}以南约750码处。",
	-- {quest:739} Murdaloc · {zone:1418} Badlands
	["{quest:739} himself (42) walks among the Bonesnappers: leave him for the later {zone:1418} guide at 43, and kill the Bonesnappers for this quest now."] = "{quest:739}本人（42级）在Bonesnappers之间走动：留到43级、后面的{zone:1418}指南再打他，现在先杀Bonesnappers完成此任务。",

	-- Step 10: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Head west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "向西进入{area:1878}；{npc:2921}在中央的机器旁工作。",

	-- Step 11: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "次级石元素",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus · {npc:1470} Ghak Healtouch
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}; every rock elemental can drop {npc:1470}'s Rock Elemental Shards."] = "小型岩石元素在{npc:2921}西边的{area:1878}游荡；所有岩石元素都可能掉落{npc:1470}要的岩石元素碎片。",

	-- Step 13: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {zone:1418} Badlands · {npc:2745} Ambassador Infernus
	["Head north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "向东北前往{zone:1418}北侧的矮人废墟，箱子在暗炉矮人之间。附近的{npc:2745}是精英，注意避开。",
	-- {item:4631} Tablet of Ryun'eh
	["{item:4631}; below ground"] = "{item:4631}：在地下",

	-- Step 14: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {area:345} Agmond's End
	["Head south down the road: {npc:4618} and {npc:2817} camp in the {area:1877}, on the way to {area:345}."] = "沿道路向南：{npc:4618} 和 {npc:2817} 驻扎在前往 {area:345} 途中经过的 {area:1877}。",
	-- {npc:4454} Fizzle Brassbolts · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["For {npc:4454} at the {area:2240}: the {zone:1446} guide passes him at 45, keep it"] = "交给{area:2240}的{npc:4454}：{zone:1446}指南在45级时会经过，先留着",

	-- Step 15: Theldurin the Lost
	-- {area:345} Agmond's End
	["Head south to {area:345}."] = "向南前往{area:345}。",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "交给{zone:1455}的{npc:2786}：先留着",

	-- Step 16: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "{npc:92}",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "{npc:92}在{npc:2921}东南方游荡；{npc:2831}和{npc:2729}分布在它们西边的平原上。",

	-- Step 17: Lotwil Veriatus
	-- {npc:2921} Lotwil Veriatus · {item:4628} Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s last test is optional: five {item:4628}, which only the Greater Rock Elementals (42-44) in the south-western gulches drop, about one kill in five, well above your level. Take it only if you can handle them one at a time; otherwise hand in the slabs and move on."] = "{npc:2921}的最后一项试验可选：需要五个{item:4628}，只有西南沟壑的巨型石元素（42-44级）掉落，约杀五只掉一个，等级远高于你。只有能一次对付一只时才接；否则交完石片就继续赶路。",

	-- Step 18: Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["South-west into the gulches: only the Greater Rock Elementals there drop the bracers."] = "",

	-- Step 20: Lucien Tosselwrench
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus · {item:2868} Patterned Bronze Bracers
	["{npc:2920}, beside {npc:2921}, trades for {item:2868}, a blacksmith's craft: this step shows only when you carry a pair."] = "",
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}，在{npc:2921}旁边",

	-- Step 21: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "前往{area:2101}",

	-- Step 22: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn; below ground"] = "{npc:1470}，位于旅店地下室",

	-- Step 23: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飞往{area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144}的飞行管理员",

	-- Step 25: Theramore flight master
	["Theramore flight master"] = "塞拉摩飞行管理员",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "下船后沿码头前往{area:514}大门旁的飞行管理员Baldruc。",

	-- Step 26: Nijel's Point
	-- {npc:5638} Kreldig Ungor
	["{npc:5638}: the wreck is on the north-west coast, at the end of the loop"] = "{npc:5638}：沉船在西北海岸，路线绕行到最后时再去",

	-- Step 27: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "沿道路向南到{area:2407}。",

	-- Step 28: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones · {npc:217590} Flesh Picker
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019}站在{area:2407}西南方的{area:596}边缘；{object:176751}散落在骨架之间。一只{npc:217590}在墓地里爬行：用昆虫学入门工具包抓住一只，然后勾选完成。",
	-- {npc:217590} Flesh Picker
	["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}：抓住它，用于我的小朋友们",

	-- Step 29: Maraudine centaurs
	["Maraudine centaurs"] = "玛洛迪半人马",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "玛洛迪半人马占据着墓地西边的{area:607}；每种都会掉落图腾。",

	-- Step 30: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} 被关在墓地西边的半人马营地中。救出她，并在离开营地的路上保护她活下来；她会在墓地旁停下。\n注意：护送途中触发的敌群会一起加入战斗，而且仅在护送时出现，因此无法提前清除，也无法逐个引出。不过，开始前先清除沿途的普通半人马会有所帮助。",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "护送{npc:12277}回到墓地",

	-- Step 31: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "恶魔聚集在{zone:1443}南部的{area:602}：坑周围有地狱犬（噬法魔犬、法师猎手和灵能猎犬）、地狱魔女、虚空姐妹以及末日看守队长。\n注意：这里多数怪物会巡逻，容易额外引怪。",

	-- Step 32: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "{npc:11561}在玛格拉姆村南边、集会所东边的骨原上游荡；在最东南端使用{item:15848}引出{npc:11560}。",

	-- Step 35: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "沿道路向西穿过{zone:1443}北部，到{area:2405}的废墟。{npc:11863}的塔就在那里的山丘上，在去残骸的路上。",

	-- Step 36: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "失事船只的箱子在{npc:11863}的塔西边不远的岸上。",

	-- Step 37: Claim Rackmore's Treasure!
	["Underwater"] = "在水下",

	-- Step 38: Nijel's Point
	-- {area:608} Nijel's Point
	["Follow the road north to {area:608}."] = "沿道路向北到{area:608}。",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "交给{zone:1455}的{npc:5637}：先留着",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "交给{area:271}的{npc:3980}：先留着",

	-- Step 39: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598}：沿途击杀以下目标",
	-- {npc:12369} Lord Kragaru · {npc:11863} Azore Aldamort
	["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}是一个半人马首领，在{npc:11863}的塔北边的西北海岸扎营。",

	-- Step 44: Fly to Theramore
	["Fly to Theramore"] = "飞往塞拉摩岛",
	["The next guide starts in Theramore."] = "下一份指南从塞拉摩岛开始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "沿道路向西穿过{zone:1443}北部，到{area:2405}的废墟；失事船只的箱子在废墟西边的岸上。",
	-- ["Greater Rock Elementals"] = "{npc:2736}",
	-- ["Lesser Rock Elementals"] = "{npc:2735}",
	-- ["Ogres and buzzards"] = "食人魔和秃鹫",
	-- ["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "向西骑回道路，沿路向南离开{zone:1432}，穿过山口进入{zone:1418}。{npc:2910}和{npc:2860}在挖掘场并排扎营。",
	-- ["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "向东北骑到废弃的挖掘场；补给箱在那里的火烟食人魔之间。",
	-- ["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "向东北骑到{zone:1418}北部的矮人废墟；箱子在暗炉矮人之间。附近的{npc:2745}是精英：离他远点。",
	-- ["Ride south to {area:345}."] = "向南骑到{area:345}。",
	-- ["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "向西骑进{area:1878}；{npc:2921}在中间的机器旁工作。",
	-- ["Shadowforge camp"] = "暗炉营地",
	-- ["Take the boat to Theramore from the far pier."] = "从最远的码头乘船前往塞拉摩岛。",
	-- ["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "火烟食人魔在山谷南边不远处扎营；任何一个都会掉落废料。秃鹫在东边的平原上空盘旋。",
	-- ["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "{npc:2736}（42级）在{area:342}下方的西南角巡逻；一次拉一个。{area:342}的{npc:2716}和火烟虐待者也会掉落废料。",
	-- ["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "{npc:2735}在{npc:2921}西边的{area:1878}游荡。",
	-- ["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "破损的骷髅就在食人魔东边、石窟穴居人营地边缘；周围的石窟断骨者和石窟萨满祭司掉落碎片。迷失者塞尔杜林坐在更南边的废弃营地旁。",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "恶魔聚集在{zone:1443}南部的{area:602}：地狱犬（{npc:4678}、法师猎手和{npc:4685}）、{npc:4679}和地狱修女，以及坑周围的{npc:4680}。",
	-- ["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "飞行管理员站在{area:514}大门旁；{npc:5083}和{npc:4964}在城堡里。",
	-- ["The next guide starts in Theramore."] = "下一份指南从塞拉摩岛开始。",
	-- ["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "骷髅的下一个任务“莫达洛克”留到之后43级的{zone:1418}指南。",
	-- ["Theramore"] = "塞拉摩岛",
	-- ["for the Dustwallow loop in the next guide"] = "留给下一份指南的尘泥沼泽环线",
	-- ["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "交给{area:439}的{npc:4454}：{zone:1446}指南会在45级经过那里，先留着",
	-- ["only if you carry {item:2868} (a blacksmith's craft)"] = "仅当你带着{item:2868}（铁匠制品）",
	-- ["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "{npc:11626}的车队停在{area:606}东边的路上。接下任务，跟着科多兽经过{area:602}，击杀袭击它们的恶魔；之后到{area:596}东边的营地与{npc:11596}交谈。",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "{npc:11863}的塔在残骸东边的山丘上。",
	-- ["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277}被关在墓地西边的半人马营地里。救出她，在出去的路上保护她；她会在墓地旁停下。",
	-- ["{npc:1470}, in the inn"] = "{npc:1470}，在旅店里",
	-- ["{npc:2920}, beside {npc:2921}, wants {item:2868}, a blacksmith's craft: skip him unless you carry a pair."] = "{npc:2920}在{npc:2921}旁，需要锻造制作的{item:2868}：身上没有一副就跳过。",
	-- ["{npc:2921}'s next test needs crafted gear: skip it."] = "{npc:2921}的下一个测试需要制作的装备：跳过。",
	-- ["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {area:3}."] = "{npc:4618}和{npc:2817}一起在{area:3}中部的{area:1877}扎营。",
	-- ["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "{npc:5638}的下一个任务{item:6245}是远处海岸的掉落物：跳过。",
}
