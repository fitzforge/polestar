-- Chinese (simplified) (zhCN): the guide forever/alliance/skyborne/01-zephras-isle (forever/alliance/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Grove
	-- {area:16622} Thendal Grove · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker · {npc:251368} Elatrell Featherlight
	["You wake in {area:16622}. {npc:251362} stands beside you; {npc:251361} is a few steps west, {npc:251368} by the south edge of the grove."] = "你在{area:16622}醒来。{npc:251362}站在你身旁；{npc:251361}在西边几步远，{npc:251368}在林地南缘。",

	-- Step 2: Vuldren and Cirrusflies
	["Vuldren and Cirrusflies"] = "幼年瓦尔德伦和卷云蝇",
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} and Pesky Cirrusflies roam the meadow just south-east of the grove."] = "{npc:250873}和烦人的卷云蝇在林地东南方的草地上游荡。",

	-- Step 3: Back to Thendal Grove
	-- {area:16622} Thendal Grove
	["Back to {area:16622}"] = "回到{area:16622}",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}：{item:4100}",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}，在瞭望塔里",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}：训练师的便条",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}：阅读{item:9547}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}，在瞭望塔里",
	-- {npc:251379} Dorii Brightwhisper · {item:282416} Glowing Recall Crystal
	["{npc:251379}, the mage trainer: read the {item:282416} first"] = "{npc:251379}，法师训练师：先阅读{item:282416}",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}，德鲁伊训练师，在{npc:251361}身后那棵树的底层",
	["The class trainers stand together in the grove"] = "职业训练师都聚在林地里",
	-- {npc:257554} Halaan Hawk-Eye
	["Listen to {npc:257554}"] = "聆听{npc:257554}",
	-- {spell:1259416} Walk on Air
	["Use {spell:1259416}"] = "使用{spell:1259416}",

	-- Step 4: Raw Windstones and the Cirrusfly Queen
	-- {npc:251404} Cirrusfly Queen
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones and the {npc:251404}"] = "原始风石和{npc:251404}",
	-- {quest:92463} The Cirrusfly Queen · {npc:249363} Yala Windwatcher
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones glitter on the ground just south of the grove. {quest:92463} hovers over the meadow further east, on the way to {npc:249363}."] = "原始风石在林地南边的地面上闪闪发光。{quest:92463}在更东边的草地上空盘旋，就在前往{npc:249363}的路上。",

	-- Step 5: Yala Windwatcher
	-- {npc:249363} Yala Windwatcher · {npc:251143} Roiling Winds · {object:460002} Ley Line (no name in this language: may be words) · {spell:1259705} Read Leyline
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your {spell:1259705} racial ability at it."] = "{npc:249363}在林地东边守望。{npc:251143}和{npc:251160}聚集在她北边不远处；{object:460002}在更北边升起：对它施放你的种族技能{spell:1259705}。",
	-- {spell:1259705} Read Leyline · {object:460002} Ley Line (no name in this language: may be words)
	["Cast {spell:1259705} at the {object:460002}"] = "对{object:460002}施放{spell:1259705}",

	-- Step 6: Thendal Grove turn-ins
	-- {area:16622} Thendal Grove
	["{area:16622} turn-ins"] = "{area:16622}交还任务",
	["Level 4 spells"] = "4级法术",

	-- Step 7: Scrawny Ursera and Urs'anah
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	["{npc:250926} and {npc:251115}"] = "{npc:250926}和{npc:251115}",
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	-- plural, as words: Ursera Scavengers = {npc:250937} Ursera Scavenger
	["{npc:250926} prowl the woods just west of the grove; the Ursera Scavengers den further west, with {npc:251115}, the matriarch, at the back of the den."] = "{npc:250926}在林地西边不远的树林里游荡；乌萨拉食腐者的巢穴在更西边，族母{npc:251115}在巢穴深处。",

	-- Step 8: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {npc:256935} Malduko Cloudcrush
	["{npc:252095} camps south of the Ursera den. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle."] = "{npc:252095}在乌萨拉巢穴南边扎营。奥拉凯斯暴徒占据了她西南边的营地；{npc:256935}站在营地中央。",

	-- Step 9: Aetheen of the Gales
	["Level 6 spells"] = "6级法术",

	-- Step 10: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:263664} Raan Wildwind · {npc:251523} Constable Aonda · {npc:251903} Rathiril Sunlance
	["Follow the road south to {area:16624}. {npc:263664} camps by the fire west of the village; {npc:251523} and {npc:251903} stand in its middle."] = "沿道路向南前往{area:16624}。{npc:263664}在村子西边的篝火旁扎营；{npc:251523}和{npc:251903}站在村子中央。",
	-- {npc:251903} Rathiril Sunlance · {npc:254089} Coriella Calmbreeze
	["Speak with {npc:251903} and {npc:254089}, north-west of the village"] = "与村子西北边的{npc:251903}和{npc:254089}交谈",

	-- Step 11: Raan Wildwind
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "在{npc:263664}的篝火旁/sit，直到获得{spell:1229451}",

	-- Step 12: Village quests
	["Village quests"] = "村庄任务",
	["The bounty board"] = "悬赏布告板",

	-- Step 13: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "傲爪和疾风陆行鸟",
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders roam the grasslands south of the village. Galestriders drop both the eggs and the meat."] = "傲爪和疾风陆行鸟在村子南边的草原上游荡。疾风陆行鸟会掉落蛋和肉。",

	-- Step 14: Back to Shen'dar
	["Back to Shen'dar"] = "回到申达尔",

	-- Step 15: The Highlands bandits
	["The Highlands bandits"] = "高地强盗",
	-- plural, as words: Highlands Bandits = {npc:251918} Highlands Bandit
	["The Highlands Bandits camp north-east of the village. \"Badwind\" Bennic waits at the far north end of their camp."] = "高地强盗在村子东北边扎营。“恶风”本尼克在他们营地的最北端等着。",

	-- Step 16: Shen'dar turn-ins
	["Shen'dar turn-ins"] = "申达尔交还任务",

	-- Step 17: Falaath Village
	-- {npc:257065} Missionary Jasaan · {quest:92529} Falaath Village · {spell:1254832} Mark of Akir
	["{npc:257065} waits at the entrance to {quest:92529}, south of Shen'dar. The {spell:1254832} lets you walk in among the faithful."] = "{npc:257065}在{quest:92529}入口等候，位于申达尔村南边。{spell:1254832}让你能混入信徒之中。",
	["Search the wardrobe"] = "搜查衣柜",

	-- Step 19: Havoc in Falaath
	["Havoc in Falaath"] = "法拉斯的混乱",
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	["Back in {quest:92529}: Stormcallers and {npc:251662} fill the village, the Stormcallers carry the stolen supplies, and {npc:251966} stands at its south end."] = "回到{quest:92529}：奥拉凯斯唤暴者和{npc:251662}遍布村中，唤暴者携带着失窃的补给品，{npc:251966}站在村子南端。",

	-- Step 20: The Western Watch
	-- {npc:252155} Peacekeeper Vaaniel · {npc:256966} Skypriest Aanders
	["{npc:252155} holds the western watch, south-west of Falaath. {npc:256966} and the fallen guards lie just south of her."] = "{npc:252155}驻守西部哨所，在法拉斯西南边。{npc:256966}和阵亡的卫兵躺在她南边不远处。",
	-- {item:254871} Bloody Note
	["The {item:254871}"] = "{item:254871}",

	-- Step 21: The hippogryph roost
	["The hippogryph roost"] = "角鹰兽栖息地",
	-- {item:263493} Hippogryph Down
	["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them."] = "向西北前往西部悬崖上的角鹰兽巢穴。{item:263493}散落在巢穴周围；角鹰兽雌兽在其间巡逻。",

	-- Step 22: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	["{npc:254589} lurks in the hills south-west of the village, on the way back. {npc:254589} is elite: grouping up is advised."] = "{npc:254589}潜伏在村子西南边的山丘中，就在回去的路上。{npc:254589}是精英：建议组队。",

	-- Step 23: Windshaper Novice Seers
	-- plural, as words: Windshaper Novice Seers = {npc:257532} Windshaper Novice Seer
	["Windshaper Novice Seers"] = "塑风者见习先知",
	["The Novice Seers practise in the clearing west of Shen'dar."] = "见习先知在申达尔西边的空地上修炼。",

	-- Step 24: Shen'dar Village again
	-- {area:16624} Shen'dar Village
	["{area:16624} again"] = "再次前往{area:16624}",

	-- Step 25: The road to Valanaar
	-- {area:16638} Valanaar
	["The road to {area:16638}"] = "前往{area:16638}的路",
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield · {area:16638} Valanaar
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Take the road south-east. {npc:257006} and {npc:252448} stand by the road west of {area:16638}; Windsong Crawlers line the shore further west, around 51,70."] = "沿道路向东南走。{npc:257006}和{npc:252448}站在{area:16638}西边的路旁；风歌爬行者分布在更西边的岸边，约在51,70。",

	-- Step 26: Valanaar
	-- {npc:252383} Valennia Stormfist · {npc:252476} Talaanis Shadowsong · {area:16638} Valanaar · {npc:252475} Elaadrin Evengale · {npc:253204} Dondallion Whisperwind
	["{npc:252383} and {npc:252476} stand at the north end of {area:16638}, {npc:252475} and {npc:253204} at the south end."] = "{npc:252383}和{npc:252476}站在{area:16638}北端，{npc:252475}和{npc:253204}在南端。",

	-- Step 27: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "天空跳跃者",
	-- {area:16638} Valanaar
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers swarm the fields west of {area:16638}."] = "天空跳跃者成群出没于{area:16638}西边的田野。",

	-- Step 28: The missing scholar
	["The missing scholar"] = "失踪的学者",
	-- {object:581822} Bloodstained Satchel · {area:16638} Valanaar
	-- plural, as words: Shriekling Matriarchs = {npc:253283} Shriekling Matriarch
	["The {object:581822} lies by the path west of {area:16638}; Fillion's camp is north-west of it, and the Shriekling Matriarchs nest just west of the camp."] = "{object:581822}在{area:16638}西边的小路旁；Fillion的营地在它西北边，尖啸幼兽主母在营地西边不远处筑巢。",
	-- {object:581822} Bloodstained Satchel
	["The {object:581822}"] = "{object:581822}",
	["Find Fillion and his bedroll"] = "找到Fillion和他的铺盖",

	-- Step 29: Aamelia Windfield
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} runs the farm in the south-west lowlands."] = "{npc:252800}经营着西南低地的农场。",

	-- Step 30: The Windfield farm
	["The Windfield farm"] = "风野农场",
	-- {quest:92683} Flutterfly Dust · {npc:250929} Malfunctioning Cyclone Construct
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple · Hungry Bandits = {npc:252802} Hungry Bandit · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Ripe Stormapples and Hungry Bandits are in the orchard by the farm, {quest:92683} in the fields north-east of it, Ornery Galestriders all around. The {npc:250929} stands in the field north-east of the farm."] = "成熟的风暴苹果和饥饿的强盗在农场旁的果园里，{quest:92683}在其东北边的田野里，暴躁的疾风陆行鸟到处都是。{npc:250929}站在农场东北边的田里。",

	-- Step 31: Aamelia Windfield again
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} again"] = "再次找{npc:252800}",

	-- Step 32: Bandit Highwaymen
	["Bandit Highwaymen"] = "强盗路霸",
	["The Bandit Highwaymen hold the hills north of the farm."] = "强盗路霸占据了农场北边的山丘。",

	-- Step 33: Standing our ground
	["Standing our ground"] = "坚守阵地",
	-- {npc:252800} Aamelia Windfield · {npc:252863} Ferauu the Bludgeon
	["Stand with {npc:252800} against {npc:252863}"] = "与{npc:252800}一起对抗{npc:252863}",

	-- Step 34: Valanaar turn-ins
	-- {area:16638} Valanaar
	["{area:16638} turn-ins"] = "{area:16638}交还任务",
	-- {npc:252377} Seena Skybreaker · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["{npc:252377}: {npc:257196} waits at the {area:16629}"] = "{npc:252377}：{npc:257196}在{area:16629}等候",
	-- {npc:252373} Anathamaas Aetherwind
	["{npc:252373}, the mage trainer"] = "{npc:252373}，法师训练师",

	-- Step 35: Taming the Beast
	-- {item:15908} Taming Rod · {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {npc:254411} Quel'dora Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler · Vuldren Alphas = {npc:250874} Vuldren Alpha · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Each of Quel'ana's quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her in {area:16638}. Windsong Crawlers line the shore west of town; Vuldren Alphas and Ornery Galestriders roam the {area:16626} around the Windfield farm. Her sister {npc:254411} stands beside her."] = "奎尔阿娜的每个任务都会给你一根{item:15908}：对她指定的野兽使用，然后把魔棒带回{area:16638}交给她。风歌爬行者分布在城镇西边的岸边；瓦尔德伦头狼和暴躁的疾风陆行鸟在风野农场周围的{area:16626}游荡。她的妹妹{npc:254411}站在她身旁。",
	-- {npc:254588} Windsong Crawler · {item:15908} Taming Rod
	["{npc:254588}: tame it with the {item:15908}"] = "{npc:254588}：用{item:15908}驯服它",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "用{item:15908}驯服它",

	-- Step 36: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "Windstone Formation",
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations stand on the rise west of Fillion's camp."] = "Windstone Formation矗立在Fillion营地西边的高地上。",
	-- {item:262668} Wind-Infused Bough · {quest:92529} Falaath Village
	["{item:262668}: by the wind shrine south of {quest:92529}"] = "{item:262668}：在{quest:92529}南边的风之圣坛旁",

	-- Step 38: The eastern watchtower
	["The eastern watchtower"] = "东部瞭望塔",
	-- {npc:252378} Yorana Windyreed · {area:16638} Valanaar · {npc:252666} Commander Belguilos
	["{npc:252378} holds the watchtower north of {area:16638}. The Al'Aketh camp is just west of the tower, its healers around 65,68 and 65,65; {npc:252666} stands at its north end. The Al'Aketh there drop Windstone Charms."] = "{npc:252378}驻守{area:16638}北边的瞭望塔。奥拉凯斯营地就在塔的西边，其治疗者在65,68和65,65附近；{npc:252666}站在营地北端。那里的奥拉凯斯成员会掉落Windstone Charm。",

	-- Step 39: Valanaar, the turncoat
	-- {area:16638} Valanaar
	["{area:16638}, the turncoat"] = "{area:16638}，叛徒",

	-- Step 40: Urs'endris
	-- {npc:255853} Urs'endris · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands
	["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623} west of {area:16638}, by the road you take next."] = "{npc:255853}在{area:16638}东北边的瀑布旁等候。{npc:258443}在{area:16638}西边的{area:16623}游荡，就在你接下来要走的路旁。",

	-- Step 41: The dead cultist
	["The dead cultist"] = "死去的邪教徒",
	-- {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["North-west of Valanaar along the road: {npc:273017} watches the {quest:98512}; the dead cultist lies just north of him."] = "沿道路前往瓦拉纳尔西北：{npc:273017}监视着{quest:98512}；死去的邪教徒就躺在他北边不远处。",
	["Search the dead cultist"] = "搜查死去的邪教徒",
	-- {npc:258443} Ur'endra
	["{npc:258443}, in the highlands south-west of the cultist"] = "{npc:258443}，在邪教徒西南边的高地",

	-- Step 42: Desperate times
	["Desperate times"] = "危急时刻",
	-- {npc:251968} Ayessa Dawnsinger · {npc:252475} Elaadrin Evengale
	["Rally Valennia, {npc:251968} (west of town) and {npc:252475}"] = "召集瓦伦妮亚、{npc:251968}（在城镇西边）和{npc:252475}",
	["Meet Valennia at the gate"] = "在大门与瓦伦妮亚会合",

	-- Step 43: Strength and Mercy
	-- {npc:255853} Urs'endris · {area:16638} Valanaar
	["Back to {npc:255853} by the falls north-east of {area:16638}, on the way north to the shrine."] = "回到{area:16638}东北边瀑布旁的{npc:255853}那里，就在北上前往圣坛的路上。",

	-- Step 44: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {npc:253576} Hyusaa Quickbreeze · {npc:253590} Valennia Stormfist
	["Fight north to the {area:16629}. Guardians, Spiritcallers and Blademasters hold the approach; {npc:253576} waits at the shrine's door, {npc:253590} inside the inner sanctum."] = "向北一路杀到{area:16629}。奥拉凯斯守护者、唤灵者和剑圣把守着通道；{npc:253576}在圣坛门口等候，{npc:253590}在内殿里。",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, in the sanctum"] = "{npc:253590}，在内殿",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}: {npc:257196}, west of the shrine's approach"] = "{item:263993}：{npc:257196}，在圣坛通道西边",

	-- Step 45: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}. {npc:257944} camps in its east."] = "向北进入{area:16631}。{npc:257944}在其东部扎营。",

	-- Step 46: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Stormchasers = {npc:252664} Al'Aketh Stormchaser
	["Al'Aketh Stormchasers and Footsoldiers camp just north of {npc:257944} and drop the heirloom; the Shrieklings west of her drop the feathers and talons; the {item:265105} grows along the stream west of her."] = "奥拉凯斯Stormchaser和Footsoldier在{npc:257944}北边不远处扎营，会掉落传家宝；她西边的尖啸幼兽掉落羽毛和利爪；{item:265105}生长在她西边的溪流旁。",

	-- Step 47: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "再次找{npc:257944}",

	-- Step 48: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive
	["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}."] = "{npc:254151}、{npc:258130}和{npc:258134}在{npc:257944}东北边；{npc:253622}站在他们东边。哈利恩还会掉落一个{quest:94490}。",
	-- {npc:258130} Jorel Windsinger
	["Heal 7 druids in the Nightfang Den, then find {npc:258130}"] = "治疗Nightfang Den中的7名德鲁伊，然后找到{npc:258130}",

	-- Step 49: Elegael Thornpaw, the missive
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the missive"] = "{npc:257944}，密信",

	-- Step 50: The Strange Hermit
	-- {quest:93159} The Strange Hermit · {npc:257944} Elegael Thornpaw
	-- plural, as words: Zephyrseed Cones = {object:613238} Zephyrseed Cone
	["{quest:93159} lives west of {npc:257944}. The Zephyrseed Cones lie in the woods between his hut and {npc:257944}."] = "{quest:93159}住在{npc:257944} Thornpaw西边。{object:613238}散落在他的小屋和{npc:257944} Thornpaw之间的树林里。",

	-- Step 51: The refugees' camp
	["The refugees' camp"] = "难民营地",
	-- {item:266433} Abandoned Belongings · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["North of the cones: the Wind Hollows drift around the refugees' camp, the {item:266433} lie between the tents, and {npc:259013} lies at its north end."] = "球果北边：Wind Hollow在难民营地周围飘荡，{item:266433}在帐篷之间，{npc:259013}躺在营地北端。",

	-- Step 52: Back to the Hermit
	["Back to the Hermit"] = "回到隐士那里",

	-- Step 53: High Priestess Lorthuna
	-- {area:16629} Shrine of Akir
	["Lorthuna waits on the eastern shore of the isle, east of the {area:16629}."] = "洛苏娜在岛屿东岸等候，位于{area:16629}东边。",

	-- Step 54: Valanaar, the fate of Zephras
	-- {area:16638} Valanaar
	["{area:16638}, the fate of Zephras"] = "{area:16638}，泽风岛的命运",
	-- {npc:252475} Elaadrin Evengale · {npc:259084} Denaaris Stargale
	["{npc:252475}: {npc:259084} waits by the Skyborne portal"] = "{npc:252475}：{npc:259084}在天裔传送门旁等候",

	-- Step 55: The skycutter
	["The skycutter"] = "天空快船",
	-- {area:16638} Valanaar · {area:279} Dalaran
	["The skycutter docks at the tower south of {area:16638}. It lands by the Kirin Tor camp on the lake shore west of {area:279}."] = "天空快船停靠在{area:16638}南边的塔上。它降落在{area:279}西边湖岸上的肯瑞托营地旁。",
	-- {area:279} Dalaran
	["Skycutter to {area:279}"] = "乘天空快船前往{area:279}",

	-- Step 56: Denaaris Stargale
	-- {npc:259084} Denaaris Stargale · {zone:1453} Stormwind
	["{npc:259084} stands beside the Skyborne Portal where the zeppelin lands. The portal takes you to {zone:1453}."] = "{npc:259084}站在飞艇降落处的天裔传送门旁。传送门会把你送到{zone:1453}。",
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind
	["{npc:270459}, beside {npc:259084}: for {npc:5504} in {zone:1453}"] = "{npc:270459}，在{npc:259084}身旁：前往{zone:1453}找{npc:5504}",

	-- Step 57: Stormwind Keep
	-- {object:2117} Stormwind Keep · {zone:1436} Westfall
	["Bolvar Fordragon stands in the throne room of {object:2117}, at the north end of the city. Then leave by the main gate for {zone:1436}."] = "伯瓦尔·弗塔根公爵站在城市北端{object:2117}的王座大厅里。然后从正门离开，前往{zone:1436}。",
	-- {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["For {npc:234} at {area:108}"] = "前往{area:108}找{npc:234}",

	-- Step 58: Sheldras Moontree
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form · {zone:1439} Darkshore
	["{npc:5504}, {zone:1453}'s druid trainer, teaches you {spell:18960}. {npc:11802}'s welcome waits for your {spell:499} trip at the end of {zone:1439}."] = "{zone:1453}的德鲁伊训练师{npc:5504}会教你{spell:18960}。{npc:11802}的问候要等到{zone:1439}结尾的{spell:499}之旅时再去。",

	-- Step 59: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497}站在{object:2101}的塔楼巫师圣殿里；她会给你一个瓶子，用于{quest:1861}的瀑布。",

	-- Step 60: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "从正门离开{zone:1453}。{quest:1861}瀑布在城门西南边，就在西去{zone:1436}的路上：在瀑布底部装满{item:7207}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Read Ley Line at the {object:460002}"] = "对{object:460002}施放Read Ley Line",
	-- ["Cast Read {object:460002} at the {object:460002}"] = "对{object:460002}施放Read {object:460002}",
	-- ["Rorian: {quest:92485}"] = "罗里安：{quest:92485}",
	-- ["Tame Beast"] = "驯服野兽",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read Ley Line racial ability at it."] = "{npc:249363}在林地东边守望。{npc:251143}和{npc:251160}聚集在她北边不远处；{object:460002}在更北边升起：对它施放你的种族技能Read Ley Line。",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read {object:460002} racial ability at it."] = "{npc:249363}在林地东边守望。{npc:251143}和奥拉凯斯信徒聚集在她北边不远处；{object:460002}在更北边升起：对它施放你的种族技能Read {object:460002}。",
	-- ["{npc:252377}: Defensive Stance"] = "{npc:252377}：防御姿态",
	-- ["{npc:254411}: Beast Training"] = "{npc:254411}：训练野兽",
	-- ["{npc:255853}: Bear Form"] = "{npc:255853}：熊形态",
	-- ["{npc:5504}, {zone:1453}'s druid trainer, teaches you Teleport: {quest:94914}. {npc:11802}'s welcome waits for your Cat Form trip at the end of {zone:1439}."] = "{npc:5504}，{zone:1453}的德鲁伊训练师，教你传送：{quest:94914}。{npc:11802}的欢迎任务会在{zone:1439}尽头等着你的猎豹形态之旅。",
	-- ["{quest:93159} lives west of Elegael. The {item:257128} Cones lie in the woods between his hut and Elegael."] = "{quest:93159}住在Elegael西边。{item:257128}球果散落在他的小屋和Elegael之间的树林里。",
}
