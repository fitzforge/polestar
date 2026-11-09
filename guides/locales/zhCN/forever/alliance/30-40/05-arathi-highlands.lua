-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飞往{area:42}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35}的飞行管理员",

	-- Step 3: Watcher Biggs
	-- {npc:5476} Watcher Biggs · {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him.\n{npc:217412} may not be here on Forever: if {npc:217412} doesn't offer {quest:93176}, skip it."] = "",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}：在阿拉希、{zone:1443}和荆棘谷各捕捉一只小动物",

	-- Step 4: The western swamp
	["The western swamp"] = "西部沼泽",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "道路周围的沼泽里游荡着小鳄鱼、沼泽纺丝蛛和沼泽虎。",

	-- Step 6: The Harborage
	-- {area:657} The Harborage
	["Follow the road north to the draenei of the {area:657}."] = "沿道路向北前往{area:657}的德莱尼人处。",

	-- Step 7: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {npc:256028} The Lost One
	["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "沿道路向东前往{area:76}。{npc:256028}怪物掉落水晶；木棒诺博鲁在废墟中游走，会掉落他的木棒。",

	-- Step 8: The Lost Caravan
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["The wrecked caravan's chest lies at the north end of the {area:76}, beside {npc:5391}'s cage.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "被毁货车的箱子在{area:76}北端，{npc:5391}的笼子旁。\n小心：营地里到处是38级左右的迷失者。他们2-3个一组相互关联，很多是施法者，而且刷新很快。",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391}被关在避难所北端的笼子里。救出他，并在护送他出去时保护他存活；之后他的保险箱就在路边。",

	-- Step 10: The Harborage
	-- {npc:5391} Galen Goodward · {area:657} The Harborage
	["West along the road from {npc:5391}'s strongbox to the {area:657}."] = "",
	-- {npc:1776} Magtoor
	["{npc:1776}: Noboru's cudgel"] = "",

	-- Step 11: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["South down the road to {npc:5476}, on the way west out of the swamp."] = "",

	-- Step 13: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飞往{zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "向西穿过{zone:1430}回到{area:42}。",

	-- Step 14: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}，{area:17203}的路上",

	-- Step 15: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122}在{object:2101}{object:2164}的地下室等候。在那里的召唤法阵使用{item:6913}，击败召来的魅魔。如果你接了{quest:65602}，也把{item:190309}交给他，放在同一个法阵上，然后击败梦魇。",
	-- {npc:5677} Summoned Succubus
	["{npc:5677}, at the summoning circle"] = "",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}，如果你接了",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}，在同一个法阵",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122}会将梦魇与你绑定",

	-- Step 16: Stormwind
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}，光明大教堂",

	-- Step 18: Stormwind
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}，城堡里的皇家图书馆",

	-- Step 19: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "乘地铁前往{zone:1455}",

	-- Step 20: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飞往{area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飞行管理员",

	-- Step 22: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore
	["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "一名{npc:2434}隐身潜伏在{area:271}边缘；杀死他并阅读他携带的合同。",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "{npc:2276}：在屋内",

	-- Step 25: Refuge Pointe
	-- {area:287} Hillsbrad · {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "沿道路向东离开{area:287}，越过{area:1057}前往{area:320}。",
	-- {npc:2700} Captain Nials · {npc:1075} Rhag Garmason
	["{npc:2700}: {npc:1075}'s plea, from 01-hillsbrad-foothills"] = "{npc:2700}：交01-hillsbrad-foothills中{npc:1075}的求援任务",

	-- Step 26: Northfold Manor
	-- {area:320} Refuge Pointe
	["The Syndicate hold the farm north-west of {area:320}.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "",

	-- Step 27: Hay Weevil
	-- {quest:681} Northfold Manor · {npc:217412} Amaryllis Webb
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["Hay Weevils crawl about the north end of {quest:681}'s farm: catch one with the tool from {npc:217412}'s Entomology Starter Kit."] = "",

	-- Step 28: Witherbark Village
	-- {area:314} Go'Shek Farm
	["A few Witherbark trolls camp south of Northfold, on the way; the main village lies in the hills south of {area:314} in the south-east, where the Witch Doctors stand and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "",
	-- {item:5040} Shadow Hunter Knife
	["{item:5040}; below ground"] = "{item:5040}：在地下",

	-- Step 29: Shards of Myzrael
	-- {area:314} Go'Shek Farm · {area:333} Circle of East Binding
	["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "向北经过{area:314}；碎片在{area:333}旁的山丘上闪闪发光。",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "仅当格鲁高在荆棘谷给了你坠饰时",

	-- Step 30: Drywhisker Gorge: kill these as you meet them
	-- {area:318} Drywhisker Gorge
	["{area:318}: kill these as you meet them"] = "{area:318}：沿途击杀以下目标",
	-- {area:321} Hammerfall
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "枯须狗头人在部落城镇{area:321}以东峡谷采掘，从城镇北侧绕过。它们会掉落微粒和克拉兹克所需的矿石。\n注意：各种狗头人低血量时都会逃跑求援：普通狗头人于 30%，勘测员和掘地工于 15% 生命值逃跑，可能引来更多敌人。",
	-- {item:4435} Mote of Myzrael · {npc:2572} Drywhisker Kobold · {npc:2573} Drywhisker Surveyor · {npc:2574} Drywhisker Digger
	["{item:4435} from {npc:2572}, {npc:2573} and {npc:2574}, by this stop"] = "从这一站附近的{npc:2572}、{npc:2573}和{npc:2574}身上获取{item:4435}",

	-- Step 31: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "碎片在{area:318}的尽头。",
	["Below ground"] = "在地下",

	-- Step 32: Stones of Binding
	-- {area:320} Refuge Pointe · {object:2702} Stone of Inner Binding
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "三把钥匙分别位于高地上的三个禁锢法阵，位置在碎片区以东、{area:320}附近和高地西侧。{object:2702}位于{area:320}以西。\n注意：各法阵的中心石周围约有三只 39 级元素生物，未清理就点击石头，会一起攻击你：西侧为烈焰流放者，外侧为雷霆流放者，东侧为水浪流放者。",

	-- Step 33: Quae
	-- {area:320} Refuge Pointe · {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Head back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "向东北返回，经过{area:320}；{npc:2712}和{npc:2713}在{area:314}北侧山丘扎营。",

	-- Step 34: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "被遗忘者信使带着两名卫兵在{area:314}以西的路上行走；把他们引离道路。",

	-- Step 36: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712}和{npc:2713}",

	-- Step 37: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "{npc:2713}的差事",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way.\nCareful: Orcs that drop to low health run away. {npc:2713} follows them and can pull more mobs, so kill or slow runners fast."] = "跟随{npc:2713}潜入{area:314}并返回，途中会有部落兽人伏击。\n注意：兽人低血量时会逃跑，{npc:2713}会追击，可能引来更多怪。及时击杀或减速逃跑者。",

	-- Step 38: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "交给{area:271}的{npc:2711}",

	-- Step 39: Refuge Pointe
	-- {area:320} Refuge Pointe · {object:2689} Stone of West Binding
	["West along the road to {area:320}, on the way to the {object:2689}."] = "",
	-- {npc:2789} Skuerto · {npc:2793} Kor'gresh Coldrage · {area:327} Faldir's Cove
	["{npc:2789}: {npc:2793}'s cave comes after {area:327}"] = "",

	-- Step 41: Faldir's Cove
	["South along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "沿西海岸向南，前往地精的海湾；哨兵鲁鲁在海湾上方的岩石上放哨。",

	-- Step 42: Phizzlethorpe
	["Phizzlethorpe"] = "菲兹索普教授",
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "护送教授上山，前往海湾上方的洞穴，并在他工作时保护他。那里会有两只40级水元素伏击，它们免疫冰霜。在洞口拦住它们，远离教授；如果在洞内战斗，教授会停下工作参战，水元素也会不断出现。",

	-- Step 44: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}：沿途击杀以下目标",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "两艘沉船在海湾以西的海湾里。海图和航海日志在船里；宝石在周围的海底。整个海湾都有刺脊纳迦游动。",
	-- {npc:2595} Daggerspine Raider
	["{npc:2595}, underwater"] = "{npc:2595}：在水下",
	-- {item:4492} Elven Gem
	["{item:4492}; underwater"] = "{item:4492}：在水下",
	-- {npc:2596} Daggerspine Sorceress
	["{npc:2596}, underwater"] = "{npc:2596}：在水下",
	-- {object:2709} Maiden's Folly Log
	["{object:2709}; underwater"] = "{object:2709}：在水下",
	-- {object:2707} Maiden's Folly Charts
	["{object:2707}; underwater"] = "{object:2707}：在水下",
	-- {object:2710} Spirit of Silverpine Log
	["{object:2710}; underwater"] = "{object:2710}：在水下",
	-- {object:2708} Spirit of Silverpine Charts
	["{object:2708}; underwater"] = "{object:2708}：在水下",

	-- Step 45: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "交给{area:35}的{npc:2487}：保留它",

	-- Step 46: Kor'gresh Coldrage
	-- {area:327} Faldir's Cove · {npc:2793} Kor'gresh Coldrage
	["East from {area:327} through the southern hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "",
	-- {item:4525} Trelane's Wand of Invocation
	["{item:4525}; below ground"] = "{item:4525}：在地下",

	-- Step 47: Foggy MacKreel
	-- {npc:2793} Kor'gresh Coldrage · {area:880} Thandol Span · {npc:2696} Foggy MacKreel · {quest:647} MacKreel's Moonshine · {npc:2705} Brewmeister Bilger · {area:271} Southshore · {area:320} Refuge Pointe
	["South-west from {npc:2793}'s cave to the {area:880}: {npc:2696} stands on a broken section of the bridge; jump down to him from its north end. {quest:647} must reach {npc:2705} in {area:271} within 15 minutes: go straight back to {area:320} and fly to {area:271}."] = "",

	-- Step 49: Fly to Southshore
	-- {area:320} Refuge Pointe
	["{area:320} flight master"] = "{area:320}的飞行管理员",

	-- Step 50: Brewmeister Bilger
	-- {area:271} Southshore
	["Off the flight, straight to the {area:271} inn."] = "",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "{npc:2705}，在地下",

	-- Step 52: Gavin's Naze
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "沿道路向北离开{area:271}进入山区。山地狮在山坡上游荡；{area:280}的辛迪加成员戴着图章戒指，{npc:2306}在镇子北边的庄园里走动。",

	-- Step 53: Ruins of Alterac: kill these as you meet them
	-- {area:281} Ruins of Alterac
	["{area:281}: kill these as you meet them"] = "{area:281}：沿途击杀以下目标",
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage · Crushridge Warmongers = {npc:2287} Crushridge Warmonger · Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and carry the tomes too: pull one at a time, or group up."] = "",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658}：破碎岭食人魔",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase
	["{item:3659}: the {object:1760}; inside"] = "{item:3659}：在{object:1760}内寻找",

	-- Step 54: Ruins of Alterac: kill these as you meet them
	-- {npc:2417} Grel'borg the Miser
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:2417}是 40 级精英，多数职业到 42 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- Step 55: Strahnbrad: kill these as you meet them
	-- {area:280} Strahnbrad
	["{area:280}: kill these as you meet them"] = "{area:280}：沿途击杀以下目标",
	-- {npc:2320} Nagaz
	["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: About three stealthed Syndicate mobs are inside {npc:2320}'s house. {npc:2320} does not join when they are pulled, and a ranged attack through the doorway brings him out by himself."] = "注意：辛迪加间谍和刺客可能处于潜行状态，刺客还会施毒。\n注意：{npc:2320}的房屋内约有三名潜行辛迪加成员。拉出这些守卫时，{npc:2320}不会参战；清理后可从门外远程攻击，将他单独拉出。",

	-- Step 56: Crushridge ogres
	["Crushridge ogres"] = "破碎岭食人魔",
	-- {area:280} Strahnbrad · {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	-- plural, as words: Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "",
	["Inside"] = "在里面",

	-- Step 58: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "向西南前往{area:279}以西湖岸的肯瑞托营地，刚越过边界进入{zone:1421}：{npc:269127}站在那里。大法师安斯雷姆·鲁因维沃尔站在其东南的穹顶旁。",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "交给{area:35}的{npc:2542}：保留它",

	-- Step 60: Southshore
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "交给{zone:1453}的{npc:1440}：保留它",
	-- {npc:2277} Loremaster Dibbs
	["{npc:2277}: the parchment"] = "",

	-- Step 61: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance · {item:2321} Fine Thread
	["{npc:2438} stands between the flight master and the inn; {npc:2381} beside him sells {item:2321} if you have none."] = "",
	-- {item:2321} Fine Thread · {npc:2381} Micha Yance
	["{item:2321}, from {npc:2381}"] = "",

	-- Step 64: Ironforge
	-- {npc:1356} Prospector Stormpike · {object:32356} Hall of Explorers · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}, {object:32356}: for {npc:1344} in {zone:1432}, next"] = "{npc:1356}，在{object:32356}：交给{zone:1432}的{npc:1344}，接下来会去",

	-- Step 65: To Thelsamar
	-- {area:144} Thelsamar
	["To {area:144}"] = "",

	-- Step 66: Thelsamar
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "从{zone:1455}出发，穿过{zone:1426}向东的隧道进入{zone:1432}，沿道路前往{area:144}。",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}：在地下",

	-- Step 67: Prospector Ironband
	["South-east along the loch to the dig site."] = "沿湖向东南前往挖掘场（铁环挖掘场）。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "每把钥匙都在高地的一处石圈：碎片以东、{area:320}附近和西部。{object:2702}在{area:320}以西。",
	-- ["East to the Witherbark trolls in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley. Every troll here can drop a tusk."] = "向东前往{area:314}以南山丘中的枯木巨魔处；枯木巫医在村子里，枯木暗影猎手守在山谷尽头。这里的每个巨魔都可能掉落獠牙。",
	-- ["Ebenezer Rustlocke"] = "伊贝尼瑟的尸体",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "护送教授到海湾北边的海滩，在他工作时保护他；纳迦会一波波来袭。",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "沿道路向南过桥，到达{zone:1437}一端的{area:205}，{npc:1075}在那里等候。",
	-- ["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "从{area:42}沿道路向东穿过{zone:1430}进入{zone:1435}；卫兵比格斯守在刚进入的岔路口。{npc:217412}站在他北边不远处。",
	-- ["From {zone:1455} take the tunnel east through {zone:1426} into {area:38} and follow the road to {area:144}."] = "从{zone:1455}出发，穿过{zone:1426}向东的隧道进入{area:38}，沿道路前往{area:144}。",
	-- ["Gyll, {area:35}"] = "盖尔，{area:35}",
	-- ["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "向东北骑回，经过{area:320}；{npc:2712}和{npc:2713}在{area:314}以北的山丘扎营。",
	-- ["Shaman training"] = "萨满祭司训练",
	-- ["South-east from Northfold to the Witherbark trolls in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley. Every troll here can drop a tusk."] = "从诺斯弗德农场向东南，前往{area:314}南边丘陵中的枯木巨魔处；巫医在村里，暗影猎手守着山谷深处。这里的所有巨魔都有可能掉落獠牙。",
	-- ["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {area:130}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "向西南前往{area:279}以西湖岸的肯瑞托营地，刚越过边界进入{area:130}：{npc:269127}站在那里。大法师安斯雷姆·鲁因维沃尔站在其东南的穹顶旁。",
	-- ["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "跟着{npc:2713}潜入{area:314}再回来；途中部落兽人会突袭你。",
	-- ["Subdue the succubus"] = "制服魅魔",
	-- ["Summon Succubus"] = "召唤魅魔",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "破碎岭食人魔占据着{area:280}以北的山丘。再往北，一个破旧的木箱里装着{item:3706}；{quest:537}的{npc:2320}就站在旁边。",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "枯须狗头人在{area:321}（部落）以东的峡谷里挖掘；从北边绕过镇子。它们会掉落微粒和克拉兹克要的矿石。",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "辛迪加占据着{area:320}西北的农场。一只{npc:217589}在农场里爬来爬去：用{npc:217412}的昆虫学入门套装捕捉一只，然后勾掉此项。",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "辛迪加占据{area:320}西北侧农场。{npc:217589}在农场内爬行，用{npc:217412}的昆虫学入门工具包捕捉一只，再勾选完成。\n注意：辛迪加路霸为 30–31 级，非战斗状态下能施放潜行，常常很难发现。",
	-- ["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "枯木巨魔住在{area:314}以南的山丘；枯木巫医在村子里，枯木暗影猎手守在山谷尽头。",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "书卷在{area:280}以西的废弃城堡（奥特兰克废墟）中；暗影大法师占据着废墟。",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health."] = "书籍位于{area:280}以西的城堡废墟内，由暗影大法师占据。\n注意：破碎岭好战者生命值低于一半时，会召唤 15 码内的盟友支援。",
	-- ["The wrecked caravan lies off the road near Biggs."] = "被毁的货车在比格斯附近的路边。",
	-- ["The wrecks"] = "沉船",
	-- ["Walk back onto the span: Ebenezer lies under its Arathi end."] = "走回桥上：伊贝尼瑟的尸体在桥的阿拉希一端下方。",
	-- ["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "沿海岸向西前往地精的海湾（法迪尔海湾）；哨兵鲁鲁在上方的岩石上放哨。",
	-- ["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{npc:2438}的披风需要{item:2321}，如果没有就从{npc:2381}处购买",
	-- ["{item:3659}: the {object:1760}"] = "{item:3659}：{object:1760}",
	-- ["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}：捕捉它，用于{quest:93176}",
	-- ["{npc:2438}, if you took his cloak quest"] = "{npc:2438}，如果你接了他的披风任务",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}，在达拉然城中",
	-- ["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "食人魔法师{npc:2793}占据着枯木巨魔山谷南端的洞穴。",
	-- ["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him."] = "{npc:5476}守在沼泽西侧的道路交汇处，{npc:217412}就在他北侧不远处。",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453}没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，在{npc:258098}处学习。{object:32372}的{npc:1573}也能飞往{area:271}。",
}
