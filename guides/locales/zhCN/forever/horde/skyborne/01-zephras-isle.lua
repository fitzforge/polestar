-- Chinese (simplified) (zhCN): the guide forever/horde/skyborne/01-zephras-isle (forever/horde/skyborne/01-zephras-isle.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Village
	-- {area:16635} Thendal Village · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker
	["You wake in {area:16635}, in the north of the isle. {npc:251362} stands by the path, {npc:251361} at the village centre."] = "你在岛屿北部的{area:16635}醒来。{npc:251362}站在小路旁，{npc:251361}在村子中央。",

	-- Step 2: Thendal Grove: kill these as you meet them
	-- {area:16622} Thendal Grove
	["{area:16622}: kill these as you meet them"] = "{area:16622}：沿途击杀以下目标",
	-- {npc:250873} Juvenile Vuldren
	["Pesky Cirrusflies and {npc:250873} roam the grove just south-east of the village."] = "烦人的卷云蝇和{npc:250873}在村子东南方的林地里游荡。",

	-- Step 3: Back to Thendal Village
	-- {area:16635} Thendal Village
	["Back to {area:16635}"] = "返回{area:16635}",
	-- {npc:257554} Halaan Hawk-Eye · {npc:263113} Myriaal Mistwake · {npc:251368} Elatrell Featherlight
	["{npc:257554} and {npc:263113} stand at the top of the watchtower, a few steps north-east of {npc:251368}."] = "{npc:257554}和{npc:263113}站在瞭望塔顶层，就在{npc:251368}东北边几步远处。",
	-- {npc:257554} Halaan Hawk-Eye
	["talk to {npc:257554}"] = "与{npc:257554}交谈",

	-- Step 4: Rorian the Dayseeker's errands
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}'s errands"] = "{npc:251361}的差事",
	-- {spell:1259416} Walk on Air · {npc:251361} Rorian the Dayseeker
	["Jump off the top of the watchtower and use {spell:1259416} to float down to {npc:251361}, west of the tower."] = "从瞭望塔顶跳下，使用{spell:1259416}缓缓落到塔西边的{npc:251361}身旁。",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}：{item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}：训练师给你的便条",
	-- {npc:251361} Rorian the Dayseeker · {item:282418} Humming Recall Crystal
	["{npc:251361}: examine the {item:282418}"] = "{npc:251361}：查看{item:282418}",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}：阅读{item:9547}",
	-- {npc:251374} Windshaper Boro · {npc:251361} Rorian the Dayseeker
	["{npc:251374}, beside {npc:251361}"] = "{npc:251374}，在{npc:251361}旁边",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}，德鲁伊训练师，在{npc:251361}身后那棵树的底层",
	-- {npc:251373} Xyton Silverwind
	["Boro and {npc:251373}, while you stand beside them"] = "站在波罗和{npc:251373}身旁时进行",

	-- Step 5: Raw Windstones
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones"] = "原始风石",
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones are blue crystals on the slopes around the village."] = "原始风石是村子周围山坡上的蓝色水晶。",

	-- Step 7: The standing stones
	["The standing stones"] = "立石",
	-- {npc:249363} Yala Windwatcher · {area:17678} Thendal Standing Stones · {npc:251143} Roiling Winds · {object:460001} Elemental Convergence (no name in this language: may be words) · {spell:1259686} Skysight
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} stands at the {area:17678}, east of the village. {npc:251143} and Al'Aketh Converts gather just north of her. The {object:460001} is just north-east of her: cast your {spell:1259686} racial ability next to it."] = "{npc:249363}站在村子东边的{area:17678}。{npc:251143}和{npc:251160}聚集在她北边不远处。{object:460001}就在她东北方：在它旁边施放你的种族技能{spell:1259686}。",
	-- {spell:1259686} Skysight · {object:460001} Elemental Convergence (no name in this language: may be words)
	["Cast {spell:1259686} near the {object:460001}"] = "在{object:460001}附近施放{spell:1259686}",

	-- Step 8: The Cirrusfly Queen
	["The queen hovers at the south-east end of the grove, on your way back from the stones."] = "卷云蝇后在林地东南端盘旋，就在你从立石返回的路上。",

	-- Step 9: Thendal Village turn-ins
	-- {area:16635} Thendal Village
	["{area:16635} turn-ins"] = "{area:16635}交任务",
	-- {npc:251376} Tai'ree Farsight · {npc:251361} Rorian the Dayseeker
	["{npc:251376}, beside {npc:251361}"] = "{npc:251376}，在{npc:251361}旁边",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}，在瞭望塔里",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}，在瞭望塔里",

	-- Step 10: Thendal Grove: kill these as you meet them
	-- {npc:250926} Scrawny Ursera · {npc:252095} Hanaa Nightwind · {npc:251115} Urs'anah
	["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}.\nThe Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "{npc:250926}在村子西南面的山坡游荡，前往{npc:252095}途中会经过。\n乌萨拉食腐者巢穴位于村子西面。它们的族母{npc:251115}待在巢穴最深处。",
	["Below ground"] = "在地下",

	-- Step 11: Back to Thendal Village
	-- {npc:257551} Valreaa Valewind · {npc:251366} Aetheen of the Gales · {npc:252095} Hanaa Nightwind
	["Back up from the den to {npc:257551} and {npc:251366} in the village before heading south-west to {npc:252095}: the road from her camp leads on south to Shen'dar."] = "从巢穴返回村里找{npc:257551}和{npc:251366}，然后向西南去找{npc:252095}：从她的营地出发的道路向南通往申达尔。",

	-- Step 12: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {area:16622} Thendal Grove · {npc:256935} Malduko Cloudcrush
	["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it.\nCareful: {npc:256935} casts shocks; drag him clear of the other cultists before fighting so they don't join in."] = "{npc:252095} 在村庄西南面的 {area:16622} 等候。奥拉凯斯营地就在她后方不远，由 {npc:256935} 领导。\n小心：{npc:256935} 会施放震击；开战前把他拉离其他教徒，免得它们加入战斗。",
	-- {item:251924} Signet of Akir · {npc:252095} Hanaa Nightwind
	["{item:251924}: the Al'Aketh in {npc:252095}'s camp carry it"] = "{item:251924}：{npc:252095}营地的奥拉凯斯携带此物",

	-- Step 13: Windshaper Boro
	-- {area:16635} Thendal Village
	["Back to Boro in {area:16635} with the Signet."] = "带着徽记返回{area:16635}找塑风者波罗。",
	-- {item:6635} Earth Sapta · {area:16988} Rise of Spirits · {npc:251166} Minor Manifestation of Earth
	["drink the {item:6635} at the {area:16988}, just east of the village, to see the {npc:251166}"] = "在村庄东侧的{area:16988}喝下{item:6635}，即可看见{npc:251166}",
	-- {npc:251374} Windshaper Boro · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {npc:5873} and your {item:5175}"] = "{npc:251374}：{npc:5873}和你的{item:5175}",

	-- Step 14: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:251523} Constable Aonda · {npc:251902} Illaya Amberwind · {npc:254089} Coriella Calmbreeze · {npc:263664} Raan Wildwind
	["Follow the road south to {area:16624}, in the middle of the isle. {npc:251523} stands on its east side, {npc:251902} in the middle, {npc:254089} just north-west of her, {npc:263664} by the campfire on the west side."] = "沿道路向南到岛屿中部的{area:16624}。{npc:251523}站在村子东侧，{npc:251902}在中央，{npc:254089}在她西北边不远处，{npc:263664}在西侧的营火旁。",
	-- {npc:251902} Illaya Amberwind
	["talk to {npc:251902}"] = "与{npc:251902}交谈",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "在{npc:263664}的营火旁/sit，直到获得{spell:1229451}",
	-- {npc:251905} Zerril Softbreeze
	["{npc:251905}: Camping 101 asks you to learn it"] = "{npc:251905}：露营 101 要求你学习这项技能",

	-- Step 15: Shen'dar Village: kill these as you meet them
	-- {area:16624} Shen'dar Village
	["{area:16624}: kill these as you meet them"] = "{area:16624}：沿途击杀以下目标",
	-- {area:16624} Shen'dar Village · {item:5469} Strider Meat · {npc:251905} Zerril Softbreeze
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw · Small Eggs = {item:6889} Small Egg
	["Prideclaws and Galestriders share the meadows around {area:16624}; the Galestriders graze thickest just west of it. They drop both the Small Eggs and the {item:5469} for {npc:251905}."] = "",

	-- Step 16: Shen'dar Village hand-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} hand-ins"] = "在{area:16624}交任务",
	-- {npc:251905} Zerril Softbreeze · {npc:251906} Teeri Wellwind · {npc:251991} Taleen Shimmerthread · {npc:252172} Danarii Bellowveil · {npc:251523} Constable Aonda · {area:16624} Shen'dar Village · {item:5469} Strider Meat
	["{npc:251905}, {npc:251906}, {npc:251991}, {npc:252172} and {npc:251523} all stand in {area:16624}. If you are still short of {item:5469}, the Galestriders graze just south of the village."] = "{npc:251905}、{npc:251906}、{npc:251991}、{npc:252172} 和 {npc:251523} 都在 {area:16624}。如果 {item:5469} 还不够，疾风陆行鸟就在村子正南边吃草。",

	-- Step 17: Shen'dar Highlands: kill these as you meet them
	-- {area:16623} Shen'dar Highlands
	["{area:16623}: kill these as you meet them"] = "{area:16623}：沿途击杀以下目标",
	["The apprentices practise north-east of the village.\nThe bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "学徒在村庄东北侧练习。\n强盗营地也在村庄东北侧，“恶风”本尼克占据最高处的营地，强盗携带被盗的风石。",

	-- Step 18: Shen'dar bounty board
	["Shen'dar bounty board"] = "申达尔悬赏布告板",
	["the bounty board"] = "悬赏布告板",

	-- Step 19: Shen'dar Village turn-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} turn-ins"] = "{area:16624}交任务",

	-- Step 20: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["{npc:254589} lurks south of the village, among the Prideclaws. {npc:254589} is elite: grouping up is advised."] = "{npc:254589}潜伏在村子南边的傲爪之间。{npc:254589}是精英：建议组队。",

	-- Step 21: Falaath Village
	-- {quest:92529} Falaath Village · {npc:257065} Missionary Jasaan
	["{quest:92529} lies south of Shen'dar. {npc:257065} meets you at its edge; search the wardrobe in the house behind him."] = "{quest:92529}在申达尔村南边。{npc:257065}在村边与你会合；搜查他身后房子里的衣柜。",
	["search the wardrobe"] = "搜查衣柜",

	-- Step 22: Constable Aonda
	-- {npc:251523} Constable Aonda · {area:16624} Shen'dar Village
	["{npc:251523} waits in {area:16624} for what you found in the wardrobe."] = "{npc:251523}在{area:16624}等你带回衣柜里找到的东西。",

	-- Step 23: Shen'dar Highlands: kill these as you meet them
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	-- plural, as words: Supply Caches = {object:576179} Supply Cache
	["Back at {quest:92529}: Stormcallers and {npc:251662} fill the village, the Supply Caches stand among the houses and {npc:251966} waits at its south-east end."] = "回到{quest:92529}：村里满是奥拉凯斯唤暴者和{npc:251662}，{object:576179}在房屋之间，{npc:251966}在村子东南端等候。",

	-- Step 25: The West Pylon Watchtower
	-- {area:17674} West Pylon Watchtower
	["The {area:17674}"] = "{area:17674}",
	-- {area:17674} West Pylon Watchtower · {npc:252155} Peacekeeper Vaaniel · {item:254871} Bloody Note
	["Head south-west to the {area:17674}. {npc:252155} is at the top; the {item:254871} lies beside him."] = "向西南前往{area:17674}。{npc:252155}在塔顶；{item:254871}在他旁边。",
	-- {npc:252155} Peacekeeper Vaaniel
	["talk to {npc:252155}"] = "与{npc:252155}交谈",

	-- Step 26: Skypriest Aanders
	["Aanders and the fallen guards are just south-west of the tower. Take Raani's feather and the Shadowsong signet from the bodies."] = "天空祭司安德斯和阵亡的卫兵就在塔的西南方。从尸体上取得拉尼的幸运羽毛和影歌家族徽记。",

	-- Step 27: Shen'dar Highlands: kill these as you meet them
	-- {area:17674} West Pylon Watchtower · {quest:92529} Falaath Village · {item:263493} Hippogryph Down
	["The hippogryph nests are north-west of the {area:17674}, west of {quest:92529}. The Matriarch sits at their western end; {item:263493} lies on the ground around the nests."] = "角鹰兽巢位于{area:17674}西北侧、{quest:92529}以西。雌兽首领在巢穴西端，{item:263493}散落在巢穴周围地面上。",

	-- Step 29: Fendaal Windstone
	-- {area:16638} Valanaar · {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["On the road south-east to {area:16638}, {npc:273017} watches the {quest:98512} just north of him."] = "在向东南前往{area:16638}的路上，{npc:273017}监视着他北边不远处的{quest:98512}。",

	-- Step 30: Valanaar
	-- {npc:252476} Talaanis Shadowsong
	["{npc:252476}, upstairs"] = "{npc:252476}：在楼上",
	-- {npc:252383} Valennia Stormfist
	["{npc:252383}, upstairs"] = "{npc:252383}：在楼上",

	-- Step 31: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "返回{area:16638}",

	-- Step 32: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "{npc:251727}",
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers hop about the fields just west of Valennia."] = "{npc:251727}在瓦伦妮亚·风暴之拳西边的田野里蹦跳。",

	-- Step 33: Ayessa Dawnsinger
	-- {npc:260628} Valennia Stormfist
	["{npc:260628}, upstairs"] = "{npc:260628}，在楼上",
	-- {npc:251968} Ayessa Dawnsinger
	["talk to {npc:251968}"] = "与{npc:251968}交谈",
	-- {npc:252382} Sessaria Skystride · {npc:251968} Ayessa Dawnsinger · {quest:97243} Call of Fire
	["{npc:252382}, beside {npc:251968}: {quest:97243}"] = "{npc:252382}，在 {npc:251968} 身边：{quest:97243}",

	-- Step 34: Nyalah Brightfire and Alvarion Windfield
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield
	["{npc:257006} and {npc:252448}"] = "{npc:257006}和{npc:252448}",
	-- {npc:257006} Nyalah Brightfire · {area:16638} Valanaar · {npc:252448} Alvarion Windfield
	["{npc:257006} waits inside a house on {area:16638}'s western edge; {npc:252448} is close by."] = "{npc:257006}在{area:16638}西缘的房屋内等候，{npc:252448}就在附近。",
	-- {npc:255940} Donaal Downbreeze
	["Innkeeper {npc:255940}, by the west gate"] = "旅店老板{npc:255940}，位于西门旁",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "听{npc:252448}讲述他的故事",
	-- {npc:252389} Quel'ana Quickgale · {npc:257006} Nyalah Brightfire · {quest:94978} Taming the Beast
	["{npc:252389}, a few steps west of {npc:257006}: {quest:94978}, the first rod"] = "{npc:252389}，在 {npc:257006} 西侧几步处：{quest:94978}，第一根驯兽棒。",
	-- {npc:257006} Nyalah Brightfire
	["{npc:257006}, inside"] = "{npc:257006}：在屋内",

	-- Step 35: Riaani Nightwind
	-- {npc:256083} Riaani Nightwind · {area:16626} Gustberry Lowlands
	["{npc:256083} stands in the {area:16626} just north-west of town."] = "{npc:256083}站在城镇西北方的{area:16626}。",
	-- {npc:256083} Riaani Nightwind
	["Listen to {npc:256083}"] = "听{npc:256083}说话",
	-- {npc:252377} Seena Skybreaker · {npc:256083} Riaani Nightwind · {quest:94003} The Skybreaker Bulwark
	["{npc:252377}, beside {npc:256083}: {quest:94003}"] = "{npc:252377}，在 {npc:256083} 身边：{quest:94003}",

	-- Step 36: Windfield Orchard
	-- {area:16663} Windfield Orchard · {area:16638} Valanaar
	["{area:16663} is west of {area:16638} along the coast road."] = "{area:16663}在{area:16638}西边，沿海岸道路前往。",

	-- Step 37: The orchard
	["The orchard"] = "果园",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Stormapples and flutterfly dust lie all over the orchard; Hungry Bandits raid it. Galestriders graze in the fields east of it. The broken construct floats at the orchard's north edge."] = "成熟的风暴苹果和扑翼蝶鳞粉散落在果园各处；{npc:252802}在果园里抢劫。疾风陆行鸟在果园东边的田野里吃草。损坏的构造体漂浮在果园北缘。",
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple
	["Ripe Stormapples"] = "成熟的风暴苹果",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Hungry Bandits"] = "饥饿的强盗",
	-- {npc:268592} Olariaan Swiftburn
	["{npc:268592}, at the Shrine of Flames just south-east of the orchard"] = "{npc:268592}，位于果园东南侧的火焰神殿",

	-- Step 39: Gustberry Lowlands: kill these as you meet them
	-- {area:16626} Gustberry Lowlands
	["{area:16626}: kill these as you meet them"] = "{area:16626}：沿途击杀以下目标",
	-- {area:16663} Windfield Orchard
	-- plural, as words: Blood-Stained Bandit Masks = {item:253596} Blood-Stained Bandit Mask
	["The Highwayman Bandits hold the hills north of {area:16663}; they drop the Blood-Stained Bandit Masks."] = "强盗路霸占据{area:16663}北侧山丘，会掉落淬锋的强盗面罩。",

	-- Step 40: Standing Our Ground
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "告诉{npc:252800}你已准备就绪",

	-- Step 41: Shen'dar Highlands: kill these as you meet them
	-- {item:260881} Crystallized Lightning · {npc:256083} Riaani Nightwind
	["The {item:260881} lies in a cave in the hills north-west of {npc:256083}."] = "{item:260881} 位于 {npc:256083} 西北山地的一个洞穴内。",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["tame one with {npc:252389}'s first {item:15908} while you are among them"] = "在它们中间时，用{npc:252389}提供的第一根{item:15908}驯服一只",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "驯服{npc:254588}",

	-- Step 42: Enchanted Gyrozephyr
	-- {area:16624} Shen'dar Village · {area:16625} Windsong Lake
	-- plural, as words: Enchanted Gyrozephyrs = {item:260883} Enchanted Gyrozephyr
	["The Enchanted Gyrozephyrs lie under water far to the north, east of {area:16624} and south-west of {area:16625}."] = "附魔的旋转微风位于很远的北侧水下，即{area:16624}以东、{area:16625}西南侧。",
	["Underwater"] = "在水下",

	-- Step 43: Alvarion Windfield and Riaani Nightwind
	-- {npc:252448} Alvarion Windfield · {npc:256083} Riaani Nightwind
	["{npc:252448} and {npc:256083}"] = "{npc:252448}和{npc:256083}",

	-- Step 44: Class trainer
	["Class trainer"] = "职业训练师",

	-- Step 45: Warlock trainer
	["Warlock trainer"] = "术士训练师",
	-- {npc:2127} Rupert Boch · {zone:1420} Tirisfal Glades · {area:16638} Valanaar
	["{npc:2127} in {zone:1420}; {area:16638} has no warlock trainer"] = "前往{zone:1420}找{npc:2127}；{area:16638}没有术士训练师",

	-- Step 47: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod · {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider · Vuldren Alphas = {npc:250874} Vuldren Alpha
	["{npc:252389} takes back the first {item:15908} and hands you two more, one at a time: Ornery Galestriders and Vuldren Alphas roam the fields just north of her. Tame each with its rod and bring the rod back to her. {npc:254411}, beside her, teaches {spell:5149}."] = "{npc:252389}会收回第一根{item:15908}，再依次给你另外两根。暴躁的疾风陆行鸟和瓦尔德伦头狼在她北侧田野活动，用对应驯服棒分别驯服，再将棒交还给她。她身旁的{npc:254411}教授{spell:5149}。",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "驯服{npc:251707}",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "驯服{npc:250874}",

	-- Step 48: Ayessa Dawnsinger
	-- {npc:256247} Belathaan Brightwish · {area:16638} Valanaar · {area:16629} Shrine of Akir
	["{npc:256247} waits on the road north of {area:16638}, towards the {area:16629}."] = "{npc:256247}在{area:16638}北边、通往{area:16629}的路上等候。",

	-- Step 49: Valennia Stormfist
	["Upstairs"] = "在楼上",

	-- Step 50: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar · {npc:255853} Urs'endris · {area:17675} East Pylon Watchtower · {spell:1259416} Walk on Air
	["{npc:252359} stands on {area:16638}'s east side. {npc:255853} waits by the falls just north of the {area:17675}: leave town to the north, climb the ridge east of the road and glide down to him with {spell:1259416}."] = "{npc:252359} 站在 {area:16638} 东侧。{npc:255853} 在 {area:17675} 正北的瀑布旁等着：从北边离城，爬上道路东边的山脊，再用 {spell:1259416} 滑翔下去找他。",

	-- Step 51: The East Pylon Watchtower
	-- {area:17675} East Pylon Watchtower
	["The {area:17675}"] = "{area:17675}",
	-- {area:17675} East Pylon Watchtower · {npc:252666} Commander Belguilos
	["Head north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "向东北前往{area:17675}，奥拉凯斯营地就在它西侧，{npc:252666}位于营地北端。所有信徒均有几率掉落风石护符。",
	-- {npc:268602} Skypriest Faladiel
	["{npc:268602}, on the hill west of the falls just north of the watchtower"] = "{npc:268602}，位于瞭望塔北侧瀑布以西的山丘",

	-- Step 53: The turncoat
	["The turncoat"] = "叛徒",
	-- {area:16626} Gustberry Lowlands · {area:16638} Valanaar · {npc:273017} Fendaal Windstone
	["The turncoat's house is in the {area:16626} north-west of {area:16638}, just north of {npc:273017}."] = "叛徒的房子在{area:16638}西北方的{area:16626}，就在{npc:273017}北边。",
	["search the dead cultist in the house"] = "搜查房子里死去的教徒",
	-- {npc:253372} Dead Cultist
	["{npc:253372}, inside"] = "{npc:253372}：在屋内",

	-- Step 54: Ur'endra
	-- {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands · {area:16626} Gustberry Lowlands
	["{npc:258443} has her lair in a cave in the bluffs just south of the turncoat's house, where the {area:16623} meet the {area:16626}."] = "{npc:258443}的巢穴在叛徒房屋南侧崖壁的洞穴里，位于{area:16623}与{area:16626}交界处。",

	-- Step 56: Olariaan Swiftburn
	-- {item:277267} Faladiel's Heart · {npc:268592} Olariaan Swiftburn · {area:16638} Valanaar · {area:16623} Shen'dar Highlands · {npc:268605} Kuramaa
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Take {item:277267} to {npc:268592} at the Shrine of Flames, south-west of {area:16638}, then head west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "把 {item:277267} 带给 {area:16638} 西南方火焰神殿的 {npc:268592}，然后向西进入 {area:16623}：{npc:268605} 的家位于风歌爬行者所在湖泊以南的山丘中。",

	-- Step 57: Zephras Isle
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",

	-- Step 58: The Eternal Flame
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Wait for him to light the {npc:268762}, then carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638} before the timer runs out."] = "回到{npc:268592}处。等他点燃{npc:268762}，然后在计时结束前把火焰直接带到{area:16638}{npc:252382}旁边的{npc:268679}。",
	-- {npc:252382} Sessaria Skystride · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:252382}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 59: Unfortunate News
	-- {npc:252476} Talaanis Shadowsong
	["talk to {npc:252476}"] = "与{npc:252476}交谈",

	-- Step 62: Desperate Times
	-- {npc:253844} Valennia Stormfist
	["talk to {npc:253844}"] = "与{npc:253844}交谈",

	-- Step 63: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["{npc:257196} holds the {item:263993} on the west side of the shrine."] = "{npc:257196}在神殿西侧守着{item:263993}。",

	-- Step 64: Strength and Mercy
	-- {npc:255853} Urs'endris · {area:17675} East Pylon Watchtower · {spell:1259416} Walk on Air
	["On your way north from Valennia, {npc:255853} waits by the falls north-east of you, just north of the {area:17675}: from the ridge above them, glide down with {spell:1259416}."] = "从瓦伦妮亚·风暴之拳处向北时，{npc:255853}在你东北侧、{area:17675}北侧的瀑布旁等候。从瀑布上方山脊使用{spell:1259416}滑翔下去。",

	-- Step 65: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}; {npc:257944} camps at its southern edge."] = "向北进入{area:16631}；{npc:257944}在森林南缘扎营。",

	-- Step 66: Shadowgale Forest: kill these as you meet them
	-- {area:16631} Shadowgale Forest
	["{area:16631}: kill these as you meet them"] = "{area:16631}：沿途击杀以下目标",
	-- {item:265105} Lady's Tear Moss · {npc:257944} Elegael Thornpaw · {item:265141} Bloody Heirloom
	["{item:265105} grows around {npc:257944}'s camp and Shriekings fly over it. The Al'Aketh camp east of her holds the {item:265141}."] = "{item:265105}生长在{npc:257944}的营地周围，尖啸幼兽在上空飞行。她东边的奥拉凯斯营地里有{item:265141}。",

	-- Step 67: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "再次找{npc:257944}",

	-- Step 68: The Al'Aketh camp
	["The Al'Aketh camp"] = "奥拉凯斯营地",
	-- {npc:253622} Commander Haalien · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:254151} Vayn Moongaze · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:253622}, {npc:258130} and {npc:258134} are in the cult camp east of {npc:257944}. {npc:254151} stands at its edge. Haalien also drops a {quest:94490}: read it to start the next quest. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:253622}、{npc:258130}和{npc:258134}在{npc:257944}东边的教派营地里。{npc:254151}站在营地边缘。指挥官哈利恩还会掉落{quest:94490}：阅读它开始下一个任务。完成{quest:94489}：进入夜牙兽穴，治疗7名受伤的德鲁伊并找到{npc:258130}。",
	["Heal the injured druids in the Nightfang Den"] = "治疗夜牙兽穴里受伤的德鲁伊",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "找到{npc:258130}",

	-- Step 69: Elegael Thornpaw, last time
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, last time"] = "最后一次找{npc:257944}",

	-- Step 70: The Strange Hermit
	-- {area:16625} Windsong Lake
	["The hermit lives at {area:16625}'s west shore."] = "隐士住在{area:16625}西岸。",
	-- {npc:251684} Strange Hermit
	["talk to {npc:251684}"] = "与{npc:251684}交谈",

	-- Step 71: Windsong Lake
	-- {item:257128} Zephyrseed · {npc:254344} Endaria Mistgaze · {quest:93736} Unwelcome Spirits · {area:16625} Windsong Lake · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow · Wind Hollow Essences = {item:262357} Wind Hollow Essence
	["{item:257128} cones grow south of the hermit; the Wind Hollows drift east of the lake and also drop the Wind Hollow Essences for {npc:254344}'s {quest:93736}. The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "{item:257128}的球果生长在隐士南边；风之空灵在湖的东边飘荡，它们也会掉落{npc:254344}的{quest:93736}所需的风之空灵精华。难民的财物散落在{area:16625}北岸；{npc:259013}在北岸西北端。",

	-- Step 73: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:253576} Hyusaa Quickbreeze
	["The {area:16629} is north of {area:16638}. Fight through the guards up to {npc:253576} at its east side."] = "{area:16629}在{area:16638}北边。一路击败卫兵，到其东侧找{npc:253576}。",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, upstairs"] = "{npc:253590}：在楼上",

	-- Step 74: Portal to Rohashi Spires
	-- {area:16630} Rohashi Spires
	["Portal to {area:16630}"] = "传送至{area:16630}",

	-- Step 75: Confront Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {object:617084} Portal to Valanaar (no name in this language: may be words)
	["Take the Portal to {area:16630} in the shrine up to the heights. Fight east along the ledge to the Peacekeepers at its end, ride the wind current up to the upper terrace and tell {npc:252475} you are ready. Leave the {object:617084} up there alone until Rohash has withdrawn; then it takes you straight back to town."] = "通过神殿内通往 {area:16630} 的传送门上到高处。沿平台向东战斗，抵达尽头的维和者处，再乘气流上到上层平台，告诉 {npc:252475} 你准备好了。等罗哈什撤退后再使用上面的 {object:617084}；它会将你直接送回镇上。",

	-- Step 76: The Fate of Zephras
	-- {npc:254344} Endaria Mistgaze · {npc:251968} Ayessa Dawnsinger
	["{npc:254344}, beside {npc:251968}"] = "{npc:254344}，在{npc:251968}旁边",

	-- Step 77: Seena Skybreaker
	-- {npc:252377} Seena Skybreaker · {npc:256083} Riaani Nightwind · {area:16638} Valanaar
	["{npc:252377} stands beside {npc:256083}, just north-west of {area:16638}."] = "{npc:252377}站在{npc:256083}旁，就在{area:16638}西北方不远。",

	-- Step 78: Valanaar
	-- {npc:251968} Ayessa Dawnsinger · {area:16638} Valanaar · {zone:1412} Mulgore · {npc:259119} Alaana Stormwalker
	["{npc:251968} sends you on to Kalimdor. Once you have trained, board the skycutter at the dock on {area:16638}'s south-west edge: it flies to northern {zone:1412}, where {npc:259119} waits."] = "{npc:251968} 会让你继续前往卡利姆多。学好技能后，到 {area:16638} 西南边缘的码头登上空艇：它会飞往 {zone:1412} 北部，{npc:259119} 在那里等候。",

	-- Step 81: Leave Zephras Isle to Mulgore
	-- {zone:2521} Zephras Isle · {zone:1412} Mulgore
	["Leave {zone:2521} to {zone:1412}"] = "离开{zone:2521}，前往{zone:1412}",

	-- Step 82: Northern Mulgore
	-- {zone:1412} Mulgore
	["Northern {zone:1412}"] = "{zone:1412}北部",
	-- {npc:259119} Alaana Stormwalker
	["You leave the isle for good. {npc:259119} waits where the airship lands."] = "你将永远离开这座岛。{npc:259119}在飞艇降落处等候。",
	-- {npc:259119} Alaana Stormwalker · {zone:1454} Orgrimmar
	["{npc:259119}: keep it: Thrall in {zone:1454}, at the start of the next guide"] = "{npc:259119}：保留任务，下篇指南开始时交给{zone:1454}的萨尔",
	-- {npc:259118} Muln Earthfury · {npc:3033} Turak Runetotem · {zone:1456} Thunder Bluff
	["{npc:259118}, by the landing: for {npc:3033} in {zone:1456}"] = "{npc:259118}，在降落处旁：交给{zone:1456}的{npc:3033}",

	-- Step 83: Clarice Foster
	-- {npc:5543} Clarice Foster · {area:2197} Pools of Vision · {area:1640} Spirit Rise
	["{npc:5543} stands in the {area:2197}, the cave under {area:1640}: go down inside, the arrow cannot tell the floors apart."] = "{npc:5543}站在{area:1640}下方的洞穴{area:2197}里：要进入洞内往下走，箭头无法区分楼层。",

	-- Step 85: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068}想要牛头人熏香：从草药商{npc:3014}、附魔供应商{npc:3012}、制皮供应商{npc:3005}和烹饪供应商{npc:3027}处购买四种材料，然后合成{item:278078}。",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}，来自{npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}，来自{npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}，来自{npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}，来自{npc:3027}",

	-- Step 86: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 21 (forever/horde/02-the-barrens)."] = "{npc:3033}在{area:1639}训练德鲁伊。他会教你{spell:18960}；{npc:11802}的迎接任务留到约21级、为{spell:499}出行时再做（forever/horde/02-the-barrens）。",

	-- Step 87: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "在{area:1641}朝南的悬崖上，于仪式垫和香炉处使用{item:278078}。",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "在{area:1641}散播{item:278078}",

	-- Step 89: Ansekhwa
	-- {spell:199} Two-Handed Maces · {npc:11869} Ansekhwa
	["While you're here: learn {spell:199} from {npc:11869} (10 silver); two-handers level a Warrior fastest."] = "顺路提示：向{npc:11869}学习{spell:199}（10 银）；战士使用双手武器升级最快。",

	-- Step 90: Ansekhwa
	-- {npc:11869} Ansekhwa
	["While you're here: learn Staves from {npc:11869} (10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "顺路提示：向{npc:11869}学习法杖（10 银）；猎人的近战武器主要用于提供属性，双手武器的属性通常更多。",

	-- Step 91: Into Mulgore
	-- {zone:1412} Mulgore
	["Into {zone:1412}"] = "进入{zone:1412}",

	-- Step 92: Into The Barrens
	-- {zone:1413} The Barrens
	["Into {zone:1413}"] = "进入{zone:1413}",

	-- Step 94: The Crossroads
	-- {npc:3615} Devrak · {area:380} The Crossroads · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Learn the flight path from {npc:3615} on the tower platform. {area:380}' own quests come after {zone:1421}, in the {zone:1413} guide."] = "在高塔平台上向{npc:3615}开通飞行点。{area:380}本地的任务留到{zone:1421}之后，在{zone:1413}指南中再做。",

	-- Step 95: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "前往{zone:1454}",
	-- {area:379} Far Watch Post · {area:815} Southfury River · {zone:1411} Durotar · {zone:1454} Orgrimmar · {quest:95350} Welcome to Azeroth · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	["From the Crossroads follow the road north-east to {area:379}, cross the {area:815} into {zone:1411} and keep north to {zone:1454}'s main gate. The next guide starts in {zone:1454}: Thrall takes {quest:95350}, and the zeppelin leaves for {zone:1420} and {zone:1421}."] = "从十字路口沿路向东北到{area:379}，跨过{area:815}进入{zone:1411}，继续向北到{zone:1454}正门。下篇指南从{zone:1454}开始：把{quest:95350}交给萨尔，然后乘飞艇前往{zone:1420}和{zone:1421}。",
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:16624} with what you found."] = "带着你找到的东西返回{area:16624}。",
	-- ["Back to {npc:268592}, then west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "回到{npc:268592} Swiftburn处，然后向西进入{area:16623}：{npc:268605}的家在{npc:254588}所在湖泊南边的山丘里。",
	-- ["Bandit Highwaymen"] = "强盗路霸",
	-- ["Climb the watchtower in the village, jump off the top and use {spell:1259416} to float down."] = "爬上村里的瞭望塔，从塔顶跳下，使用{spell:1259416}缓缓飘落。",
	-- ["Faladiel stands on the hill west of the falls, north of {area:16638}."] = "Skypriest Faladiel站在{area:16638}北边、瀑布西边的山丘上。",
	-- ["Follow the road south to {area:16624}, in the middle of the isle."] = "沿道路向南到岛屿中部的{area:16624}。",
	-- ["High Order Apprentices"] = "{npc:257521}",
	-- ["Hippogryph nests"] = "角鹰兽巢穴",
	-- ["Horde airship"] = "部落飞艇",
	-- ["Into {area:17}"] = "进入{area:17}",
	-- ["Kuramaa"] = "Kuramaa",
	-- ["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "乘升降梯离开{zone:1456}，沿道路向南经过{area:222}，穿过东边的山口进入{zone:1413}；从山口沿{area:458}向北到{area:380}，即{zone:1413}中部的部落城镇。",
	-- ["Leaving {area:16635}"] = "离开{area:16635}",
	-- ["On the way north, back to {npc:255853} by the falls."] = "向北的路上，回到瀑布旁找{npc:255853}。",
	-- ["Prideclaws and Galestriders"] = "傲爪和疾风陆行鸟",
	-- ["Prideclaws and Galestriders share the meadows south of the village. Keep the {item:5469} for {npc:251905}; the eggs come later from the hippogryphs."] = "傲爪和疾风陆行鸟分布在村子南边的草地上。把{item:5469}留给{npc:251905}；蛋稍后从角鹰兽身上获得。",
	-- ["Prideclaws and Galestriders share the meadows south of {area:16624}. The Galestriders drop both the Small Eggs and the {item:5469} for {npc:251905}."] = "傲爪和疾风陆行鸟一同栖息在 {area:16624} 南边的草地。疾风陆行鸟会同时掉落小蛋和 {npc:251905} 需要的 {item:5469}。",
	-- ["Ride north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "向东北骑到{area:17675}。奥拉凯斯营地就在它西边，{npc:252666}在营地北端。每个教徒都可能掉落风石护符。",
	-- ["Rorian: {quest:92485}"] = "逐日者罗里安：{quest:92485}",
	-- ["Sit by {npc:263664}'s campfire (type /sit) until you get the {spell:1229451} buff, then find {npc:251905} at the cook fire."] = "坐在{npc:263664}的营火旁（输入/sit），直到获得{spell:1229451}增益效果，然后到烹饪火堆旁找{npc:251905}。",
	-- ["Take the Torch of Dormant Flame to {npc:268592} at the Shrine of Flames, south-west of {area:16638} in the {area:16626}."] = "把Torch of Dormant Flame带给{area:16626}中、{area:16638}西南方Shrine of Flames的{npc:268592}。",
	-- ["Take the portal up to the {area:16630} and join {npc:252475} and {npc:251968} against the High Priestess."] = "乘传送门上到{area:16630}，与{npc:252475}和{npc:251968}一起对抗高阶女祭司洛苏娜。",
	-- ["Take the road south-east to {area:16638}, the Skyborne town on the south coast. {npc:257006} and {npc:252448} stand at its western edge."] = "沿道路向东南到南部海岸的天裔城镇{area:16638}。{npc:257006}和{npc:252448}站在城镇西缘。",
	-- ["Talk to {npc:251902}"] = "与{npc:251902}交谈",
	-- ["Talk to {npc:251968}"] = "与{npc:251968}交谈",
	-- ["Talk to {npc:252383}"] = "与{npc:252383}交谈",
	-- ["Talk to {npc:252800}"] = "与{npc:252800}交谈",
	-- ["Talk to {npc:253576}"] = "与{npc:253576}交谈",
	-- ["Talk to {npc:254089}"] = "与{npc:254089}交谈",
	-- ["The Al'Aketh cultists in the camp beyond {npc:252095} carry the signet."] = "{npc:252095}身后营地里的奥拉凯斯教徒带着徽记。",
	-- ["The Horde airship docks at the south-west edge of {area:16638}. Ride it to Kalimdor; it lands in northern {zone:1412}."] = "部落飞艇停靠在{area:16638}西南边缘。乘它前往卡利姆多；它会降落在{zone:1412}北部。",
	-- ["The Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "乌萨拉巢穴在村子西边。它们的族母{npc:251115}坐在巢穴尽头。",
	-- ["The airship"] = "飞艇",
	-- ["The apprentices practise north-east of the village."] = "学徒们在村子东北方练习。",
	-- ["The bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "强盗营地在村子东北方；“恶风”本尼克占据着最高处的营地。强盗们带着被偷走的风石。",
	-- ["The crawlers scuttle along the shore south-west of town."] = "这些爬行者在城镇西南方的海岸上爬行。",
	-- ["The hermit lives at {area:16625}'s west shore. {item:257128} cones grow south of him; the Wind Hollows drift east of the lake."] = "隐士住在{area:16625}西岸。{item:257128}的球果生长在他南边；{npc:251676}在湖的东边飘荡。",
	-- ["The highland bandits"] = "高地强盗",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616466} lie near the road to {area:16638}."] = "强盗路霸占据着果园东北方的山丘。更多{object:616466}在通往{area:16638}的道路附近。",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616468} lie near the road to {area:16638}."] = "强盗路霸占据着果园东北方的山丘。更多{object:616468}在通往{area:16638}的道路附近。",
	-- ["The hippogryph nests are north-west of the tower, west of {quest:92529}; the Matriarch sits at the western end. {item:263493} lies on the ground around them, and the hippogryphs drop the Small Eggs."] = "角鹰兽巢穴在塔的西北方、{quest:92529}西边；角鹰兽雌兽在最西端。{item:263493}散落在巢穴周围的地上，角鹰兽会掉落{item:6889}。",
	-- ["The last {object:616466}, the Enchanted Gyrozephyrs, lie far to the north, east of {area:16624} and south-west of {area:16625}. Then head back south-west to {npc:252800} at the orchard."] = "最后一批{object:616466}，也就是{item:260883}，在很远的北边，位于{area:16624}以东、{area:16625}西南。收集后向西南返回果园找{npc:252800}。",
	-- ["The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "难民的物品散落在{area:16625}北岸；{npc:259013}在湖的西北端。",
	-- ["The turncoat's house is in the {area:16626} north-west of {area:16638}. {npc:273017} waits nearby; his assassins lurk around the house."] = "叛徒的房子在{area:16638}西北方的{area:16626}。{npc:273017}在附近等候；他的刺客潜伏在房子周围。",
	-- ["The watchtower"] = "瞭望塔",
	-- ["Walk north to {area:16624}; finish the {item:5469} on the Galestriders along the way if you are short."] = "向北走到{area:16624}；如果{item:5469}还不够，就沿途从疾风陆行鸟身上收集完。",
	-- ["Wind Hollows and {object:616466}"] = "{npc:251676}和{object:616466}",
	-- ["Wind Hollows and {object:616467}"] = "{npc:251676}和{object:616467}",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616466} lie west of the orchard road."] = "{npc:251676}在{area:16638}周围的低地上空飘荡。第一批{object:616466}在果园道路的西边。",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616467} lie west of the orchard road."] = "{npc:251676}在{area:16638}周围的低地上空飘荡。第一批{object:616467}在果园道路的西边。",
	-- ["Windsong Crawlers"] = "{npc:254588}",
	-- ["talk to {npc:251905}"] = "与{npc:251905}交谈",
	-- ["{area:1638} is beside the landing: ride up a lift and learn the flight path from {npc:2995}, the wind rider master."] = "{area:1638}就在降落处旁：乘升降梯上去，向双足飞龙管理员{npc:2995}学习飞行路线。",
	-- ["{area:16624}, last time"] = "最后一次回到{area:16624}",
	-- ["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}."] = "{npc:250926}在村子西南方的山坡上潜行，就在去找{npc:252095}的路上。",
	-- ["{npc:251374} sends you to the {area:16988}, just east of the village: drink the {item:6635} there to see the {npc:251166}, then take the {item:6656} back to him."] = "{npc:251374}让你去村子东边不远处的{area:16988}：在那里喝下{item:6635}以看到{npc:251166}，然后把{item:6656}带回给他。",
	-- ["{npc:251374} stands in the village."] = "{npc:251374}站在村子里。",
	-- ["{npc:251374}, at the village centre"] = "{npc:251374}，在村子中央",
	-- ["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it."] = "{npc:252095}在村子西南方的{area:16622}等候。奥拉凯斯营地就在她身后；{npc:256935}是营地首领。",
	-- ["{npc:252359} stands on {area:16638}'s east side."] = "{npc:252359}站在{area:16638}东侧。",
	-- ["{npc:252377} stands in the middle of {area:16638}."] = "{npc:252377}站在{area:16638}中央。",
	-- ["{npc:252377}: Defensive Stance"] = "{npc:252377}：防御姿态",
	-- ["{npc:252382} stands on {area:16638}'s west side."] = "{npc:252382}站在{area:16638}西侧。",
	-- ["{npc:252389} in {area:16638} hands you a {item:15908} three times: tame a {npc:254588} by the lakes north-west of town, an {npc:251707} in the fields west of town and a {npc:250874} at {area:16663}, returning to her after each. {npc:254411} stands beside her."] = "{area:16638}的{npc:252389}会三次交给你{item:15908}：在城镇西北方的湖边驯服一只{npc:254588}，在城镇西边的田野驯服一只{npc:251707}，在{area:16663}驯服一只{npc:250874}，每次驯服后都回到她那里。{npc:254411}站在她旁边。",
	-- ["{npc:254411}: Beast Training"] = "{npc:254411}：训练野兽",
	-- ["{npc:255853} waits by the falls just north of the watchtower."] = "{npc:255853}在瞭望塔北边不远处的瀑布旁等候。",
	-- ["{npc:255853}: Bear Form"] = "{npc:255853}：熊形态",
	-- ["{npc:258443} roams the slopes just south of the turncoat's house."] = "{npc:258443}在叛徒房子南边不远处的山坡上游荡。",
	-- ["{npc:259119}: keep it, Thrall in {zone:1454} comes two guides later"] = "{npc:259119}：先留着，两份指南后到{zone:1454}交给萨尔",
	-- ["{npc:263664}'s campfire"] = "{npc:263664}的营火",
	-- ["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 23 (forever/horde/04-the-barrens)."] = "{npc:3033}在{area:1639}训练德鲁伊。他会教你{spell:18960}；{npc:11802}的问候要等到你约23级的{spell:499}之旅时再去（forever/horde/04-the-barrens）。",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}，双足飞龙管理员",
}
