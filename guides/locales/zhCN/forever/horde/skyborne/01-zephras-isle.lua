-- Chinese (simplified) (zhCN): the guide forever/horde/skyborne/01-zephras-isle (forever/horde/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Village
	-- {area:16635} Thendal Village · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker
	["You wake in {area:16635}, in the north of the isle. {npc:251362} stands by the path, {npc:251361} at the village centre."] = "你在岛屿北部的{area:16635}醒来。{npc:251362}站在小路旁，{npc:251361}在村子中央。",

	-- Step 2: Thendal Grove
	-- {npc:250873} Juvenile Vuldren
	["Pesky Cirrusflies and {npc:250873} roam the grove just south-east of the village."] = "烦人的卷云蝇和{npc:250873}在村子东南方的林地里游荡。",

	-- Step 3: Back to Thendal Village
	-- {area:16635} Thendal Village
	["Back to {area:16635}"] = "返回{area:16635}",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}：{item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}：训练师给你的便条",
	-- {npc:251361} Rorian the Dayseeker · {item:282418} Humming Recall Crystal
	["{npc:251361}: examine the {item:282418}"] = "{npc:251361}：查看{item:282418}",
	-- {npc:257554} Halaan Hawk-Eye
	["talk to {npc:257554}"] = "与{npc:257554}交谈",

	-- Step 4: The watchtower
	["The watchtower"] = "瞭望塔",
	-- {spell:1259416} Walk on Air
	["Climb the watchtower in the village, jump off the top and use {spell:1259416} to float down."] = "爬上村里的瞭望塔，从塔顶跳下，使用{spell:1259416}缓缓飘落。",

	-- Step 5: Rorian the Dayseeker's errands
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}'s errands"] = "{npc:251361}的差事",

	-- Step 6: Raw Windstones
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones"] = "原始风石",
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones are blue crystals on the slopes around the village."] = "原始风石是村子周围山坡上的蓝色水晶。",

	-- Step 8: The standing stones
	["The standing stones"] = "立石",
	-- {npc:249363} Yala Windwatcher · {area:17678} Thendal Standing Stones · {npc:251143} Roiling Winds · {object:460001} Elemental Convergence (no name in this language: may be words) · {spell:1259686} Skysight
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} stands at the {area:17678}, east of the village. {npc:251143} and Al'Aketh Converts gather just north of her. The {object:460001} is just north-east of her: cast your {spell:1259686} racial ability next to it."] = "{npc:249363}站在村子东边的{area:17678}。{npc:251143}和{npc:251160}聚集在她北边不远处。{object:460001}就在她东北方：在它旁边施放你的种族技能{spell:1259686}。",
	-- {spell:1259686} Skysight · {object:460001} Elemental Convergence (no name in this language: may be words)
	["Cast {spell:1259686} near the {object:460001}"] = "在{object:460001}附近施放{spell:1259686}",

	-- Step 9: The Cirrusfly Queen
	["The queen hovers at the south-east end of the grove, on your way back from the stones."] = "卷云蝇后在林地东南端盘旋，就在你从立石返回的路上。",

	-- Step 10: Thendal Village turn-ins
	-- {area:16635} Thendal Village
	["{area:16635} turn-ins"] = "{area:16635}交任务",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}：阅读{item:9547}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}，在瞭望塔里",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}，在瞭望塔里",
	-- {npc:251374} Windshaper Boro
	["{npc:251374}, at the village centre"] = "{npc:251374}，在村子中央",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}，德鲁伊训练师，在{npc:251361}身后那棵树的底层",

	-- Step 11: Windshaper Boro
	-- {npc:251374} Windshaper Boro
	["{npc:251374} stands in the village."] = "{npc:251374}站在村子里。",

	-- Step 12: Scrawny Ursera
	-- {npc:250926} Scrawny Ursera · {npc:252095} Hanaa Nightwind
	["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}."] = "{npc:250926}在村子西南方的山坡上潜行，就在去找{npc:252095}的路上。",

	-- Step 13: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {area:16622} Thendal Grove · {npc:256935} Malduko Cloudcrush
	["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it."] = "{npc:252095}在村子西南方的{area:16622}等候。奥拉凯斯营地就在她身后；{npc:256935}是营地首领。",

	-- Step 14: Signet of Akir
	-- {npc:252095} Hanaa Nightwind
	["The Al'Aketh cultists in the camp beyond {npc:252095} carry the signet."] = "{npc:252095}身后营地里的奥拉凯斯教徒带着徽记。",

	-- Step 15: Urs'anah
	-- {npc:251115} Urs'anah
	["The Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "乌萨拉巢穴在村子西边。它们的族母{npc:251115}坐在巢穴尽头。",

	-- Step 16: Leaving Thendal Village
	-- {area:16635} Thendal Village
	["Leaving {area:16635}"] = "离开{area:16635}",

	-- Step 17: Call of Earth
	-- {npc:251374} Windshaper Boro · {area:16988} Rise of Spirits · {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:251374} sends you to the {area:16988}, just east of the village: drink the {item:6635} there to see the {npc:251166}, then take the {item:6656} back to him."] = "{npc:251374}让你去村子东边不远处的{area:16988}：在那里喝下{item:6635}以看到{npc:251166}，然后把{item:6656}带回给他。",
	-- {npc:251374} Windshaper Boro · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {npc:5873} and your {item:5175}"] = "{npc:251374}：{npc:5873}和你的{item:5175}",

	-- Step 18: Shen'dar Village
	-- {area:16624} Shen'dar Village
	["Follow the road south to {area:16624}, in the middle of the isle."] = "沿道路向南到岛屿中部的{area:16624}。",
	-- {npc:251902} Illaya Amberwind
	["talk to {npc:251902}"] = "与{npc:251902}交谈",

	-- Step 19: Raan Wildwind's campfire
	-- {npc:263664} Raan Wildwind
	["{npc:263664}'s campfire"] = "{npc:263664}的营火",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest · {npc:251905} Zerril Softbreeze
	["Sit by {npc:263664}'s campfire (type /sit) until you get the {spell:1229451} buff, then find {npc:251905} at the cook fire."] = "坐在{npc:263664}的营火旁（输入/sit），直到获得{spell:1229451}增益效果，然后到烹饪火堆旁找{npc:251905}。",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "在{npc:263664}的营火旁/sit，直到获得{spell:1229451}",
	-- {npc:251905} Zerril Softbreeze
	["talk to {npc:251905}"] = "与{npc:251905}交谈",

	-- Step 20: Welcome to Shen'dar Village
	-- {npc:251902} Illaya Amberwind
	["Talk to {npc:251902}"] = "与{npc:251902}交谈",
	-- {npc:254089} Coriella Calmbreeze
	["Talk to {npc:254089}"] = "与{npc:254089}交谈",
	["the bounty board"] = "悬赏布告板",

	-- Step 21: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "傲爪和疾风陆行鸟",
	-- {item:5469} Strider Meat · {npc:251905} Zerril Softbreeze
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders share the meadows south of the village. Keep the {item:5469} for {npc:251905}; the eggs come later from the hippogryphs."] = "傲爪和疾风陆行鸟分布在村子南边的草地上。把{item:5469}留给{npc:251905}；蛋稍后从角鹰兽身上获得。",

	-- Step 22: High Order Apprentices
	-- plural, as words: High Order Apprentices = {npc:257521} High Order Apprentice
	["High Order Apprentices"] = "{npc:257521}",
	["The apprentices practise north-east of the village."] = "学徒们在村子东北方练习。",

	-- Step 23: The highland bandits
	["The highland bandits"] = "高地强盗",
	["The bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "强盗营地在村子东北方；“恶风”本尼克占据着最高处的营地。强盗们带着被偷走的风石。",

	-- Step 24: Shen'dar Village turn-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} turn-ins"] = "{area:16624}交任务",

	-- Step 25: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["{npc:254589} lurks south of the village, among the Prideclaws. {npc:254589} is elite: grouping up is advised."] = "{npc:254589}潜伏在村子南边的傲爪之间。{npc:254589}是精英：建议组队。",

	-- Step 26: Falaath Village
	-- {quest:92529} Falaath Village · {npc:257065} Missionary Jasaan
	["{quest:92529} lies south of Shen'dar. {npc:257065} meets you at its edge; search the wardrobe in the house behind him."] = "{quest:92529}在申达尔村南边。{npc:257065}在村边与你会合；搜查他身后房子里的衣柜。",
	["search the wardrobe"] = "搜查衣柜",

	-- Step 27: Constable Aonda
	-- {area:16624} Shen'dar Village
	["Back to {area:16624} with what you found."] = "带着你找到的东西返回{area:16624}。",

	-- Step 28: Havoc in the Highlands
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	-- plural, as words: Supply Caches = {object:576179} Supply Cache
	["Back at {quest:92529}: Stormcallers and {npc:251662} fill the village, the Supply Caches stand among the houses and {npc:251966} waits at its south-east end."] = "回到{quest:92529}：村里满是奥拉凯斯唤暴者和{npc:251662}，{object:576179}在房屋之间，{npc:251966}在村子东南端等候。",

	-- Step 29: The West Pylon Watchtower
	-- {area:17674} West Pylon Watchtower
	["The {area:17674}"] = "{area:17674}",
	-- {area:17674} West Pylon Watchtower · {npc:252155} Peacekeeper Vaaniel · {item:254871} Bloody Note
	["Head south-west to the {area:17674}. {npc:252155} is at the top; the {item:254871} lies beside him."] = "向西南前往{area:17674}。{npc:252155}在塔顶；{item:254871}在他旁边。",
	-- {npc:252155} Peacekeeper Vaaniel
	["talk to {npc:252155}"] = "与{npc:252155}交谈",

	-- Step 30: Skypriest Aanders
	["Aanders and the fallen guards are just south-west of the tower. Take Raani's feather and the Shadowsong signet from the bodies."] = "天空祭司安德斯和阵亡的卫兵就在塔的西南方。从尸体上取得拉尼的幸运羽毛和影歌家族徽记。",

	-- Step 31: Hippogryph nests
	["Hippogryph nests"] = "角鹰兽巢穴",
	-- {quest:92529} Falaath Village · {item:263493} Hippogryph Down
	-- plural, as words: Small Eggs = {item:6889} Small Egg
	["The hippogryph nests are north-west of the tower, west of {quest:92529}; the Matriarch sits at the western end. {item:263493} lies on the ground around them, and the hippogryphs drop the Small Eggs."] = "角鹰兽巢穴在塔的西北方、{quest:92529}西边；角鹰兽雌兽在最西端。{item:263493}散落在巢穴周围的地上，角鹰兽会掉落{item:6889}。",

	-- Step 32: Shen'dar Village, last time
	-- {area:16624} Shen'dar Village
	["{area:16624}, last time"] = "最后一次回到{area:16624}",
	-- {area:16624} Shen'dar Village · {item:5469} Strider Meat
	["Walk north to {area:16624}; finish the {item:5469} on the Galestriders along the way if you are short."] = "向北走到{area:16624}；如果{item:5469}还不够，就沿途从疾风陆行鸟身上收集完。",

	-- Step 33: To Valanaar
	-- {area:16638} Valanaar · {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield
	["Take the road south-east to {area:16638}, the Skyborne town on the south coast. {npc:257006} and {npc:252448} stand at its western edge."] = "沿道路向东南到南部海岸的天裔城镇{area:16638}。{npc:257006}和{npc:252448}站在城镇西缘。",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "听{npc:252448}讲述他的故事",

	-- Step 34: Windsong Crawlers
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers"] = "{npc:254588}",
	["The crawlers scuttle along the shore south-west of town."] = "这些爬行者在城镇西南方的海岸上爬行。",

	-- Step 36: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "{npc:251727}",
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers hop about the fields just west of Valennia."] = "{npc:251727}在瓦伦妮亚·风暴之拳西边的田野里蹦跳。",

	-- Step 37: Ayessa Dawnsinger
	-- {npc:251968} Ayessa Dawnsinger
	["talk to {npc:251968}"] = "与{npc:251968}交谈",

	-- Step 38: Riaani Nightwind
	-- {npc:256083} Riaani Nightwind · {area:16626} Gustberry Lowlands
	["{npc:256083} stands in the {area:16626} just north-west of town."] = "{npc:256083}站在城镇西北方的{area:16626}。",
	-- {npc:256083} Riaani Nightwind
	["Listen to {npc:256083}"] = "听{npc:256083}说话",

	-- Step 39: Wind Hollows and Construct Parts
	-- {object:616467} Construct Parts
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows and {object:616467}"] = "{npc:251676}和{object:616467}",
	-- {area:16638} Valanaar · {object:616467} Construct Parts
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616467} lie west of the orchard road."] = "{npc:251676}在{area:16638}周围的低地上空飘荡。第一批{object:616467}在果园道路的西边。",

	-- Step 41: Windfield Orchard
	-- {area:16663} Windfield Orchard · {area:16638} Valanaar
	["{area:16663} is west of {area:16638} along the coast road."] = "{area:16663}在{area:16638}西边，沿海岸道路前往。",
	-- {npc:252800} Aamelia Windfield
	["Talk to {npc:252800}"] = "与{npc:252800}交谈",

	-- Step 42: The orchard
	["The orchard"] = "果园",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Stormapples and flutterfly dust lie all over the orchard; Hungry Bandits raid it. Galestriders graze in the fields east of it. The broken construct floats at the orchard's north edge."] = "成熟的风暴苹果和扑翼蝶鳞粉散落在果园各处；{npc:252802}在果园里抢劫。疾风陆行鸟在果园东边的田野里吃草。损坏的构造体漂浮在果园北缘。",

	-- Step 44: Bandit Highwaymen
	["Bandit Highwaymen"] = "强盗路霸",
	-- {object:616468} Construct Parts · {area:16638} Valanaar
	["The highwaymen hold the hills north-east of the orchard. More {object:616468} lie near the road to {area:16638}."] = "强盗路霸占据着果园东北方的山丘。更多{object:616468}在通往{area:16638}的道路附近。",

	-- Step 45: Standing Our Ground
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "告诉{npc:252800}你已准备就绪",

	-- Step 46: Alvarion Windfield and Riaani Nightwind
	-- {npc:252448} Alvarion Windfield · {npc:256083} Riaani Nightwind
	["{npc:252448} and {npc:256083}"] = "{npc:252448}和{npc:256083}",

	-- Step 47: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {item:15908} Taming Rod · {npc:254588} Windsong Crawler · {npc:251707} Ornery Galestrider · {npc:250874} Vuldren Alpha · {area:16663} Windfield Orchard · {npc:254411} Quel'dora Quickgale
	["{npc:252389} in {area:16638} hands you a {item:15908} three times: tame a {npc:254588} by the lakes north-west of town, an {npc:251707} in the fields west of town and a {npc:250874} at {area:16663}, returning to her after each. {npc:254411} stands beside her."] = "{area:16638}的{npc:252389}会三次交给你{item:15908}：在城镇西北方的湖边驯服一只{npc:254588}，在城镇西边的田野驯服一只{npc:251707}，在{area:16663}驯服一只{npc:250874}，每次驯服后都回到她那里。{npc:254411}站在她旁边。",

	-- Step 48: Belathaan Brightwish
	-- {npc:256247} Belathaan Brightwish · {area:16638} Valanaar · {area:16629} Shrine of Akir
	["{npc:256247} waits on the road north of {area:16638}, towards the {area:16629}."] = "{npc:256247} Brightwish在{area:16638}北边、通往{area:16629}的路上等候。",

	-- Step 50: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands on {area:16638}'s east side."] = "{npc:252359}站在{area:16638}东侧。",

	-- Step 51: The East Pylon Watchtower
	-- {area:17675} East Pylon Watchtower
	["The {area:17675}"] = "{area:17675}",
	-- {area:17675} East Pylon Watchtower · {npc:252666} Commander Belguilos
	["Ride north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "向东北骑到{area:17675}。奥拉凯斯营地就在它西边，{npc:252666}在营地北端。每个教徒都可能掉落风石护符。",

	-- Step 52: Urs'endris
	-- {npc:255853} Urs'endris
	["{npc:255853} waits by the falls just north of the watchtower."] = "{npc:255853}在瞭望塔北边不远处的瀑布旁等候。",

	-- Step 53: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "返回{area:16638}",

	-- Step 54: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} stands in the middle of {area:16638}."] = "{npc:252377}站在{area:16638}中央。",

	-- Step 55: Sessaria Skystride
	-- {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["{npc:252382} stands on {area:16638}'s west side."] = "{npc:252382}站在{area:16638}西侧。",

	-- Step 56: The turncoat
	["The turncoat"] = "叛徒",
	-- {area:16626} Gustberry Lowlands · {area:16638} Valanaar · {npc:273017} Fendaal Windstone
	["The turncoat's house is in the {area:16626} north-west of {area:16638}. {npc:273017} waits nearby; his assassins lurk around the house."] = "叛徒的房子在{area:16638}西北方的{area:16626}。{npc:273017}在附近等候；他的刺客潜伏在房子周围。",
	["search the dead cultist in the house"] = "搜查房子里死去的教徒",

	-- Step 57: Ur'endra
	-- {npc:258443} Ur'endra
	["{npc:258443} roams the slopes just south of the turncoat's house."] = "{npc:258443}在叛徒房子南边不远处的山坡上游荡。",

	-- Step 58: Olariaan Swiftburn
	-- {npc:268592} Olariaan Swiftburn · {area:16638} Valanaar · {area:16626} Gustberry Lowlands
	["Take the Torch of Dormant Flame to {npc:268592} at the Shrine of Flames, south-west of {area:16638} in the {area:16626}."] = "把Torch of Dormant Flame带给{area:16626}中、{area:16638}西南方Shrine of Flames的{npc:268592}。",

	-- Step 59: Skypriest Faladiel
	-- {area:16638} Valanaar
	["Faladiel stands on the hill west of the falls, north of {area:16638}."] = "Skypriest Faladiel站在{area:16638}北边、瀑布西边的山丘上。",

	-- Step 60: Kuramaa
	-- {npc:268592} Olariaan Swiftburn · {area:16623} Shen'dar Highlands · {npc:268605} Kuramaa
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Back to {npc:268592}, then west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "回到{npc:268592} Swiftburn处，然后向西进入{area:16623}：{npc:268605}的家在{npc:254588}所在湖泊南边的山丘里。",

	-- Step 61: The Eternal Flame
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Wait for him to light the {npc:268762}, then carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638} before the timer runs out."] = "回到{npc:268592} Swiftburn处。等他点燃{npc:268762}，然后在计时结束前把火焰直接带到{area:16638}{npc:252382}旁边的{npc:268679}。",
	-- {npc:252382} Sessaria Skystride · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:252382}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 62: Unfortunate News
	-- {npc:252476} Talaanis Shadowsong
	["talk to {npc:252476}"] = "与{npc:252476}交谈",

	-- Step 63: Desperate Times
	-- {npc:252383} Valennia Stormfist
	["Talk to {npc:252383}"] = "与{npc:252383}交谈",
	-- {npc:251968} Ayessa Dawnsinger
	["Talk to {npc:251968}"] = "与{npc:251968}交谈",
	-- {npc:252383} Valennia Stormfist
	["talk to {npc:252383}"] = "与{npc:252383}交谈",

	-- Step 64: Strength and Mercy
	-- {npc:255853} Urs'endris
	["On the way north, back to {npc:255853} by the falls."] = "向北的路上，回到瀑布旁找{npc:255853}。",

	-- Step 65: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:253576} Hyusaa Quickbreeze
	["The {area:16629} is north of {area:16638}. Fight through the guards up to {npc:253576} at its east side."] = "{area:16629}在{area:16638}北边。一路击败卫兵，到其东侧找{npc:253576}。",
	-- {npc:253576} Hyusaa Quickbreeze
	["Talk to {npc:253576}"] = "与{npc:253576}交谈",

	-- Step 66: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["{npc:257196} holds the {item:263993} on the west side of the shrine."] = "{npc:257196}在神殿西侧守着{item:263993}。",

	-- Step 67: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}; {npc:257944} camps at its southern edge."] = "向北进入{area:16631}；{npc:257944} Thornpaw在森林南缘扎营。",

	-- Step 68: Shadowgale Forest
	-- {item:265105} Lady's Tear Moss · {npc:257944} Elegael Thornpaw · {item:265141} Bloody Heirloom
	["{item:265105} grows around {npc:257944}'s camp and Shriekings fly over it. The Al'Aketh camp east of her holds the {item:265141}."] = "{item:265105}生长在{npc:257944} Thornpaw的营地周围，Shrieking在上空飞行。她东边的奥拉凯斯营地里有{item:265141}。",

	-- Step 69: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "再次找{npc:257944} Thornpaw",

	-- Step 70: The Al'Aketh camp
	["The Al'Aketh camp"] = "奥拉凯斯营地",
	-- {npc:253622} Commander Haalien · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:254151} Vayn Moongaze · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:253622}, {npc:258130} and {npc:258134} are in the cult camp east of {npc:257944}. {npc:254151} stands at its edge. Haalien also drops a {quest:94490}: read it to start the next quest. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:253622}、{npc:258130}和{npc:258134}在{npc:257944} Thornpaw东边的教派营地里。{npc:254151}站在营地边缘。Haalien还会掉落{quest:94490}：阅读它开始下一个任务。完成{quest:94489}：进入Nightfang Den，治疗7名受伤的德鲁伊并找到{npc:258130}。",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "找到{npc:258130}",
	["Heal the injured druids in the Nightfang Den"] = "治疗Nightfang Den里受伤的德鲁伊",

	-- Step 71: Elegael Thornpaw, last time
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, last time"] = "最后一次找{npc:257944}",

	-- Step 72: Windsong Lake
	-- {area:16625} Windsong Lake · {npc:259013} Resaan Nimbuswalker
	["The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "难民的物品散落在{area:16625}北岸；{npc:259013}在湖的西北端。",

	-- Step 73: The Strange Hermit
	-- {area:16625} Windsong Lake · {item:257128} Zephyrseed
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["The hermit lives at {area:16625}'s west shore. {item:257128} cones grow south of him; the Wind Hollows drift east of the lake."] = "隐士住在{area:16625}西岸。{item:257128}的球果生长在他南边；{npc:251676}在湖的东边飘荡。",
	-- {npc:251684} Strange Hermit
	["talk to {npc:251684}"] = "与{npc:251684}交谈",

	-- Step 74: Confront Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {npc:251968} Ayessa Dawnsinger
	["Take the portal up to the {area:16630} and join {npc:252475} and {npc:251968} against the High Priestess."] = "乘传送门上到{area:16630}，与{npc:252475}和{npc:251968}一起对抗高阶女祭司洛苏娜。",

	-- Step 77: The airship
	["The airship"] = "飞艇",
	-- {area:16638} Valanaar · {zone:1412} Mulgore
	["The Horde airship docks at the south-west edge of {area:16638}. Ride it to Kalimdor; it lands in northern {zone:1412}."] = "部落飞艇停靠在{area:16638}西南边缘。乘它前往卡利姆多；它会降落在{zone:1412}北部。",
	["Horde airship"] = "部落飞艇",

	-- Step 78: Northern Mulgore
	-- {zone:1412} Mulgore
	["Northern {zone:1412}"] = "{zone:1412}北部",
	-- {npc:259119} Alaana Stormwalker
	["You leave the isle for good. {npc:259119} waits where the airship lands."] = "你将永远离开这座岛。{npc:259119}在飞艇降落处等候。",
	-- {npc:259119} Alaana Stormwalker · {zone:1454} Orgrimmar
	["{npc:259119}: keep it, Thrall in {zone:1454} comes two guides later"] = "{npc:259119}：先留着，两份指南后到{zone:1454}交给萨尔",
	-- {npc:259118} Muln Earthfury · {npc:3033} Turak Runetotem · {zone:1456} Thunder Bluff
	["{npc:259118}, by the landing: for {npc:3033} in {zone:1456}"] = "{npc:259118}，在降落处旁：交给{zone:1456}的{npc:3033}",

	-- Step 79: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:2995} Tal
	["{area:1638} is beside the landing: ride up a lift and learn the flight path from {npc:2995}, the wind rider master."] = "{area:1638}就在降落处旁：乘升降梯上去，向双足飞龙管理员{npc:2995}学习飞行路线。",

	-- Step 80: Traditions of the Bluff
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

	-- Step 81: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "在{area:1641}朝南的悬崖上，于仪式垫和香炉处使用{item:278078}。",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "在{area:1641}散播{item:278078}",

	-- Step 83: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 23 (forever/horde/04-the-barrens)."] = "{npc:3033}在{area:1639}训练德鲁伊。他会教你{spell:18960}；{npc:11802}的问候要等到你约23级的{spell:499}之旅时再去（forever/horde/04-the-barrens）。",

	-- Step 84: The Crossroads
	-- {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {zone:1413} Barrens · {area:458} Gold Road · {area:380} The Crossroads
	["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "乘升降梯离开{zone:1456}，沿道路向南经过{area:222}，穿过东边的山口进入{zone:1413}；从山口沿{area:458}向北到{area:380}，即{zone:1413}中部的部落城镇。",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}，双足飞龙管理员",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Kuramaa"] = "Kuramaa",
	-- ["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "乘升降梯离开{zone:1456}，沿道路向南经过{area:222}，穿过东边的山口进入{zone:1413}；从山口沿{area:458}向北到{area:380}，即{zone:1413}中部的部落城镇。",
	-- ["Rorian: {quest:92485}"] = "逐日者罗里安：{quest:92485}",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616466} lie near the road to {area:16638}."] = "强盗路霸占据着果园东北方的山丘。更多{object:616466}在通往{area:16638}的道路附近。",
	-- ["Wind Hollows and {object:616466}"] = "{npc:251676}和{object:616466}",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616466} lie west of the orchard road."] = "{npc:251676}在{area:16638}周围的低地上空飘荡。第一批{object:616466}在果园道路的西边。",
}
