-- Chinese (traditional) (zhTW): the guide forever/alliance/skyborne/01-zephras-isle (forever/alliance/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Grove
	-- {area:16622} Thendal Grove · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker · {npc:251368} Elatrell Featherlight
	["You wake in {area:16622}. {npc:251362} stands beside you; {npc:251361} is a few steps west, {npc:251368} by the south edge of the grove."] = "你在{area:16622}醒來。{npc:251362}站在你身旁；{npc:251361}在西邊幾步遠，{npc:251368}在林地南緣。",

	-- Step 2: Vuldren and Cirrusflies
	["Vuldren and Cirrusflies"] = "弗德飛狐與捲雲蜂",
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} and Pesky Cirrusflies roam the meadow just south-east of the grove."] = "{npc:250873}和討厭的捲雲蜂在林地東南方的草地上遊蕩。",

	-- Step 3: Back to Thendal Grove
	-- {area:16622} Thendal Grove
	["Back to {area:16622}"] = "返回{area:16622}",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}：{item:4100}",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}，在瞭望塔裡",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}：來自你訓練師的字條",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}：閱讀{item:9547}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}，在瞭望塔裡",
	-- {npc:251379} Dorii Brightwhisper · {item:282416} Glowing Recall Crystal
	["{npc:251379}, the mage trainer: read the {item:282416} first"] = "{npc:251379}，法師訓練師：先閱讀{item:282416}",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}，德魯伊訓練師，在{npc:251361}身後那棵樹的一樓",
	["The class trainers stand together in the grove"] = "職業訓練師都站在林地裡",
	-- {npc:257554} Halaan Hawk-Eye
	["Listen to {npc:257554}"] = "聆聽{npc:257554}的話",
	-- {spell:1259416} Walk on Air
	["Use {spell:1259416}"] = "使用{spell:1259416}",

	-- Step 4: Raw Windstones and the Cirrusfly Queen
	-- {npc:251404} Cirrusfly Queen
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones and the {npc:251404}"] = "原始風石與{npc:251404}",
	-- {quest:92463} The Cirrusfly Queen · {npc:249363} Yala Windwatcher
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones glitter on the ground just south of the grove. {quest:92463} hovers over the meadow further east, on the way to {npc:249363}."] = "原始風石在林地南邊的地上閃閃發光。{quest:92463}在更東邊的草地上空盤旋，就在前往{npc:249363}的路上。",

	-- Step 5: Yala Windwatcher
	-- {npc:249363} Yala Windwatcher · {npc:251143} Roiling Winds · {object:460002} Ley Line (no name in this language: may be words) · {spell:1259705} Read Leyline
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your {spell:1259705} racial ability at it."] = "{npc:249363}在林地東邊守望。{npc:251143}和奧拉凱斯皈依者聚集在她北邊；{object:460002}在更北邊升起：對它施放你的種族技能{spell:1259705}。",
	-- {spell:1259705} Read Leyline · {object:460002} Ley Line (no name in this language: may be words)
	["Cast {spell:1259705} at the {object:460002}"] = "對{object:460002}施放{spell:1259705}",

	-- Step 6: Thendal Grove turn-ins
	-- {area:16622} Thendal Grove
	["{area:16622} turn-ins"] = "{area:16622}繳交任務",
	["Level 4 spells"] = "4級法術",

	-- Step 7: Scrawny Ursera and Urs'anah
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	["{npc:250926} and {npc:251115}"] = "{npc:250926}與{npc:251115}",
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	-- plural, as words: Ursera Scavengers = {npc:250937} Ursera Scavenger
	["{npc:250926} prowl the woods just west of the grove; the Ursera Scavengers den further west, with {npc:251115}, the matriarch, at the back of the den."] = "{npc:250926}在林地西邊的樹林裡徘徊；熊獸食腐者的巢穴在更西邊，族母{npc:251115}在巢穴深處。",

	-- Step 8: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {npc:256935} Malduko Cloudcrush
	["{npc:252095} camps south of the Ursera den. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle."] = "{npc:252095}在熊獸巢穴南邊紮營。奧拉凱斯暴徒佔據她西南方的營地；{npc:256935}站在營地中央。",

	-- Step 9: Aetheen of the Gales
	["Level 6 spells"] = "6級法術",

	-- Step 10: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:263664} Raan Wildwind · {npc:251523} Constable Aonda · {npc:251903} Rathiril Sunlance
	["Follow the road south to {area:16624}. {npc:263664} camps by the fire west of the village; {npc:251523} and {npc:251903} stand in its middle."] = "沿著道路向南前往{area:16624}。{npc:263664}在村子西邊的火堆旁紮營；{npc:251523}和{npc:251903}站在村子中央。",
	-- {npc:251903} Rathiril Sunlance · {npc:254089} Coriella Calmbreeze
	["Speak with {npc:251903} and {npc:254089}, north-west of the village"] = "與村子西北方的{npc:251903}和{npc:254089}交談",

	-- Step 11: Raan Wildwind
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "在{npc:263664}的營火旁 /sit，直到獲得{spell:1229451}",

	-- Step 12: Village quests
	["Village quests"] = "村莊任務",
	["The bounty board"] = "懸賞告示板",

	-- Step 13: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "群爪與逐風者",
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders roam the grasslands south of the village. Galestriders drop both the eggs and the meat."] = "群爪和逐風者在村子南邊的草原上遊蕩。逐風者會掉落蛋和肉。",

	-- Step 14: Back to Shen'dar
	["Back to Shen'dar"] = "返回申德村",

	-- Step 15: The Highlands bandits
	["The Highlands bandits"] = "高地強盜",
	-- plural, as words: Highlands Bandits = {npc:251918} Highlands Bandit
	["The Highlands Bandits camp north-east of the village. \"Badwind\" Bennic waits at the far north end of their camp."] = "高地強盜在村子東北方紮營。『惡風』班尼克在營地最北端等著。",

	-- Step 16: Shen'dar turn-ins
	["Shen'dar turn-ins"] = "申德村繳交任務",

	-- Step 17: Falaath Village
	-- {npc:257065} Missionary Jasaan · {quest:92529} Falaath Village · {spell:1254832} Mark of Akir
	["{npc:257065} waits at the entrance to {quest:92529}, south of Shen'dar. The {spell:1254832} lets you walk in among the faithful."] = "{npc:257065}在申德村南邊的{quest:92529}入口等候。{spell:1254832}讓你能走進信徒之間。",
	["Search the wardrobe"] = "搜查衣櫃",

	-- Step 19: Havoc in Falaath
	["Havoc in Falaath"] = "法拉斯村的混亂",
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	["Back in {quest:92529}: Stormcallers and {npc:251662} fill the village, the Stormcallers carry the stolen supplies, and {npc:251966} stands at its south end."] = "回到{quest:92529}：奧拉凱斯風暴召喚者和{npc:251662}遍布村中，風暴召喚者身上帶著被偷的補給品，{npc:251966}站在村子南端。",

	-- Step 20: The Western Watch
	-- {npc:252155} Peacekeeper Vaaniel · {npc:256966} Skypriest Aanders
	["{npc:252155} holds the western watch, south-west of Falaath. {npc:256966} and the fallen guards lie just south of her."] = "{npc:252155}駐守在法拉斯村西南方的西部守望。{npc:256966}和倒下的守衛就躺在她南邊。",
	-- {item:254871} Bloody Note
	["The {item:254871}"] = "{item:254871}",

	-- Step 21: The hippogryph roost
	["The hippogryph roost"] = "角鷹獸棲地",
	-- {item:263493} Hippogryph Down
	["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them."] = "向西北前往西面懸崖上的角鷹獸巢。{item:263493}散落在巢穴周圍；角鷹獸族母在巢穴之間巡邏。",

	-- Step 22: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	["{npc:254589} lurks in the hills south-west of the village, on the way back. {npc:254589} is elite: grouping up is advised."] = "{npc:254589}潛伏在村子西南方的山丘上，就在回程路上。{npc:254589}是精英：建議組隊。",

	-- Step 23: Windshaper Novice Seers
	-- plural, as words: Windshaper Novice Seers = {npc:257532} Windshaper Novice Seer
	["Windshaper Novice Seers"] = "塑風者見習先知",
	["The Novice Seers practise in the clearing west of Shen'dar."] = "見習先知在申德村西邊的空地上練習。",

	-- Step 24: Shen'dar Village again
	-- {area:16624} Shen'dar Village
	["{area:16624} again"] = "再回{area:16624}",

	-- Step 25: The road to Valanaar
	-- {area:16638} Valanaar
	["The road to {area:16638}"] = "前往{area:16638}的路",
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield · {area:16638} Valanaar
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Take the road south-east. {npc:257006} and {npc:252448} stand by the road west of {area:16638}; Windsong Crawlers line the shore further west, around 51,70."] = "沿著道路向東南走。{npc:257006}和{npc:252448}站在{area:16638}西邊的路旁；風歌蟹遍布更西邊的海岸，約在51,70附近。",

	-- Step 26: Valanaar
	-- {npc:252383} Valennia Stormfist · {npc:252476} Talaanis Shadowsong · {area:16638} Valanaar · {npc:252475} Elaadrin Evengale · {npc:253204} Dondallion Whisperwind
	["{npc:252383} and {npc:252476} stand at the north end of {area:16638}, {npc:252475} and {npc:253204} at the south end."] = "{npc:252383}和{npc:252476}站在{area:16638}北端，{npc:252475}和{npc:253204}在南端。",

	-- Step 27: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "空躍者",
	-- {area:16638} Valanaar
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers swarm the fields west of {area:16638}."] = "空躍者成群出沒於{area:16638}西邊的田野。",

	-- Step 28: The missing scholar
	["The missing scholar"] = "失蹤的學者",
	-- {object:581822} Bloodstained Satchel · {area:16638} Valanaar
	-- plural, as words: Shriekling Matriarchs = {npc:253283} Shriekling Matriarch
	["The {object:581822} lies by the path west of {area:16638}; Fillion's camp is north-west of it, and the Shriekling Matriarchs nest just west of the camp."] = "{object:581822}在{area:16638}西邊的小路旁；菲利安的營地在它西北方，始祖鳥族母就在營地西邊築巢。",
	-- {object:581822} Bloodstained Satchel
	["The {object:581822}"] = "{object:581822}",
	["Find Fillion and his bedroll"] = "找到菲利安和他的鋪蓋",

	-- Step 29: Aamelia Windfield
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} runs the farm in the south-west lowlands."] = "{npc:252800}在西南低地經營農場。",

	-- Step 30: The Windfield farm
	["The Windfield farm"] = "荒原農場",
	-- {quest:92683} Flutterfly Dust · {npc:250929} Malfunctioning Cyclone Construct
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple · Hungry Bandits = {npc:252802} Hungry Bandit · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Ripe Stormapples and Hungry Bandits are in the orchard by the farm, {quest:92683} in the fields north-east of it, Ornery Galestriders all around. The {npc:250929} stands in the field north-east of the farm."] = "熟透的風暴蘋果和飢餓的強盜在農場旁的果園裡，{quest:92683}在農場東北方的田野中，暴躁的逐風者則到處都是。{npc:250929}站在農場東北方的田野裡。",

	-- Step 31: Aamelia Windfield again
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} again"] = "再找{npc:252800}",

	-- Step 32: Bandit Highwaymen
	["Bandit Highwaymen"] = "強盜路霸",
	["The Bandit Highwaymen hold the hills north of the farm."] = "強盜路霸佔據農場北邊的山丘。",

	-- Step 33: Standing our ground
	["Standing our ground"] = "堅守陣地",
	-- {npc:252800} Aamelia Windfield · {npc:252863} Ferauu the Bludgeon
	["Stand with {npc:252800} against {npc:252863}"] = "與{npc:252800}一起對抗{npc:252863}",

	-- Step 34: Valanaar turn-ins
	-- {area:16638} Valanaar
	["{area:16638} turn-ins"] = "{area:16638}繳交任務",
	-- {npc:252377} Seena Skybreaker · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["{npc:252377}: {npc:257196} waits at the {area:16629}"] = "{npc:252377}：{npc:257196}在{area:16629}等候",
	-- {npc:252373} Anathamaas Aetherwind
	["{npc:252373}, the mage trainer"] = "{npc:252373}，法師訓練師",

	-- Step 35: Taming the Beast
	-- {item:15908} Taming Rod · {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {npc:254411} Quel'dora Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler · Vuldren Alphas = {npc:250874} Vuldren Alpha · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Each of Quel'ana's quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her in {area:16638}. Windsong Crawlers line the shore west of town; Vuldren Alphas and Ornery Galestriders roam the {area:16626} around the Windfield farm. Her sister {npc:254411} stands beside her."] = "奎爾安娜的每個任務都會給你一根{item:15908}：對她指定的野獸使用，然後把馴獸棒帶回{area:16638}交給她。風歌蟹遍布城鎮西邊的海岸；弗德飛狐首領和暴躁的逐風者在荒原農場周圍的{area:16626}遊蕩。她的妹妹{npc:254411}站在她身旁。",
	-- {npc:254588} Windsong Crawler · {item:15908} Taming Rod
	["{npc:254588}: tame it with the {item:15908}"] = "{npc:254588}：用{item:15908}馴服牠",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "用{item:15908}馴服牠",

	-- Step 36: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "風石岩層",
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations stand on the rise west of Fillion's camp."] = "風石岩層位於菲利安營地西邊的高地上。",
	-- {item:262668} Wind-Infused Bough · {quest:92529} Falaath Village
	["{item:262668}: by the wind shrine south of {quest:92529}"] = "{item:262668}：在{quest:92529}南邊的風之神殿旁",

	-- Step 38: The eastern watchtower
	["The eastern watchtower"] = "東部瞭望塔",
	-- {npc:252378} Yorana Windyreed · {area:16638} Valanaar · {npc:252666} Commander Belguilos
	["{npc:252378} holds the watchtower north of {area:16638}. The Al'Aketh camp is just west of the tower, its healers around 65,68 and 65,65; {npc:252666} stands at its north end. The Al'Aketh there drop Windstone Charms."] = "{npc:252378}駐守在{area:16638}北邊的瞭望塔。奧拉凱斯營地就在塔的西邊，治療者在65,68和65,65附近；{npc:252666}站在營地北端。那裡的奧拉凱斯敵人會掉落奧拉凱斯風石符咒。",

	-- Step 39: Valanaar, the turncoat
	-- {area:16638} Valanaar
	["{area:16638}, the turncoat"] = "{area:16638}，叛徒",

	-- Step 40: Urs'endris
	-- {npc:255853} Urs'endris · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands
	["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623} west of {area:16638}, by the road you take next."] = "{npc:255853}在{area:16638}東北方的瀑布旁等候。{npc:258443}在{area:16638}西邊的{area:16623}徘徊，就在你接下來要走的路旁。",

	-- Step 41: The dead cultist
	["The dead cultist"] = "死去的教徒",
	-- {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["North-west of Valanaar along the road: {npc:273017} watches the {quest:98512}; the dead cultist lies just north of him."] = "沿著道路前往瓦拉納爾西北方：{npc:273017}監視著{quest:98512}；死去的教徒就躺在他北邊。",
	["Search the dead cultist"] = "搜查死去的教徒",
	-- {npc:258443} Ur'endra
	["{npc:258443}, in the highlands south-west of the cultist"] = "{npc:258443}，在教徒西南方的高地上",

	-- Step 42: Desperate times
	["Desperate times"] = "危急時刻",
	-- {npc:251968} Ayessa Dawnsinger · {npc:252475} Elaadrin Evengale
	["Rally Valennia, {npc:251968} (west of town) and {npc:252475}"] = "召集維菈妮雅、{npc:251968}（城鎮西邊）和{npc:252475}",
	["Meet Valennia at the gate"] = "在大門與維菈妮雅會合",

	-- Step 43: Strength and Mercy
	-- {npc:255853} Urs'endris · {area:16638} Valanaar
	["Back to {npc:255853} by the falls north-east of {area:16638}, on the way north to the shrine."] = "回到{area:16638}東北方瀑布旁的{npc:255853}處，就在向北前往聖殿的路上。",

	-- Step 44: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {npc:253576} Hyusaa Quickbreeze · {npc:253590} Valennia Stormfist
	["Fight north to the {area:16629}. Guardians, Spiritcallers and Blademasters hold the approach; {npc:253576} waits at the shrine's door, {npc:253590} inside the inner sanctum."] = "一路向北殺到{area:16629}。奧拉凱斯守護者、招魂師和大劍師守著通道；{npc:253576}在聖殿門口等候，{npc:253590}在內殿裡。",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, in the sanctum"] = "{npc:253590}，在內殿裡",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}: {npc:257196}, west of the shrine's approach"] = "{item:263993}：{npc:257196}，在聖殿通道西邊",

	-- Step 45: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}. {npc:257944} camps in its east."] = "向北進入{area:16631}。{npc:257944}在森林東部紮營。",

	-- Step 46: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Stormchasers = {npc:252664} Al'Aketh Stormchaser
	["Al'Aketh Stormchasers and Footsoldiers camp just north of {npc:257944} and drop the heirloom; the Shrieklings west of her drop the feathers and talons; the {item:265105} grows along the stream west of her."] = "奧拉凱斯追風者和步行兵就在{npc:257944}北邊紮營，會掉落傳家寶；她西邊的始祖鳥會掉落羽毛和利爪；{item:265105}沿著她西邊的溪流生長。",

	-- Step 47: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "再找{npc:257944}",

	-- Step 48: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive
	["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}."] = "{npc:254151}、{npc:258130}和{npc:258134}在{npc:257944}東北方；{npc:253622}站在他們東邊。哈利安也會掉落{quest:94490}。",
	-- {npc:258130} Jorel Windsinger
	["Heal 7 druids in the Nightfang Den, then find {npc:258130}"] = "在巢穴中治療7名德魯伊，然後找到{npc:258130}",

	-- Step 49: Elegael Thornpaw, the missive
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the missive"] = "{npc:257944}，信件",

	-- Step 50: The Strange Hermit
	-- {quest:93159} The Strange Hermit · {npc:257944} Elegael Thornpaw
	-- plural, as words: Zephyrseed Cones = {object:613238} Zephyrseed Cone
	["{quest:93159} lives west of {npc:257944}. The Zephyrseed Cones lie in the woods between his hut and {npc:257944}."] = "{quest:93159}住在{npc:257944}西邊。和風之種錐果散落在他的小屋與{npc:257944}之間的樹林裡。",

	-- Step 51: The refugees' camp
	["The refugees' camp"] = "難民營地",
	-- {item:266433} Abandoned Belongings · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["North of the cones: the Wind Hollows drift around the refugees' camp, the {item:266433} lie between the tents, and {npc:259013} lies at its north end."] = "錐果的北邊：風之空靈在難民營地周圍飄蕩，{item:266433}散落在帳篷之間，{npc:259013}躺在營地北端。",

	-- Step 52: Back to the Hermit
	["Back to the Hermit"] = "返回隱士處",

	-- Step 53: High Priestess Lorthuna
	-- {area:16629} Shrine of Akir
	["Lorthuna waits on the eastern shore of the isle, east of the {area:16629}."] = "洛舒娜在島嶼東岸、{area:16629}東邊等候。",

	-- Step 54: Valanaar, the fate of Zephras
	-- {area:16638} Valanaar
	["{area:16638}, the fate of Zephras"] = "{area:16638}，微風島的命運",
	-- {npc:252475} Elaadrin Evengale · {npc:259084} Denaaris Stargale
	["{npc:252475}: {npc:259084} waits by the Skyborne portal"] = "{npc:252475}：{npc:259084}在天裔精靈傳送門旁等候",

	-- Step 55: The skycutter
	["The skycutter"] = "天空快艇",
	-- {area:16638} Valanaar · {area:279} Dalaran
	["The skycutter docks at the tower south of {area:16638}. It lands by the Kirin Tor camp on the lake shore west of {area:279}."] = "天空快艇停靠在{area:16638}南邊的塔上。它會降落在{area:279}西邊湖岸的祈倫托營地旁。",
	-- {area:279} Dalaran
	["Skycutter to {area:279}"] = "搭天空快艇前往{area:279}",

	-- Step 56: Denaaris Stargale
	-- {npc:259084} Denaaris Stargale · {zone:1453} Stormwind
	["{npc:259084} stands beside the Skyborne Portal where the zeppelin lands. The portal takes you to {zone:1453}."] = "{npc:259084}站在飛艇降落處的天裔精靈傳送門旁。傳送門會帶你前往{zone:1453}。",
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind
	["{npc:270459}, beside {npc:259084}: for {npc:5504} in {zone:1453}"] = "{npc:270459}，在{npc:259084}旁邊：交給{zone:1453}的{npc:5504}",

	-- Step 57: Stormwind Keep
	-- {object:2117} Stormwind Keep · {zone:1436} Westfall
	["Bolvar Fordragon stands in the throne room of {object:2117}, at the north end of the city. Then leave by the main gate for {zone:1436}."] = "伯瓦爾·弗塔根公爵站在城市北端{object:2117}的王座廳裡。然後從正門離開，前往{zone:1436}。",
	-- {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["For {npc:234} at {area:108}"] = "交給{area:108}的{npc:234}",

	-- Step 58: Sheldras Moontree
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form · {zone:1439} Darkshore
	["{npc:5504}, {zone:1453}'s druid trainer, teaches you {spell:18960}. {npc:11802}'s welcome waits for your {spell:499} trip at the end of {zone:1439}."] = "{npc:5504}是{zone:1453}的德魯伊訓練師，會教你{spell:18960}。{npc:11802}的歡迎任務在你{spell:499}任務旅程的終點{zone:1439}等著你。",

	-- Step 59: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497}站在{object:2101}的法師塔裡；她會給你一個裝{quest:1861}瀑布水的瓶子。",

	-- Step 60: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "從正門離開{zone:1453}。{quest:1861}瀑布在城門西南方，位於向西前往{zone:1436}的路上：在瀑布底下裝滿{item:7207}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Read Ley Line at the {object:460002}"] = "對{object:460002}施放你的種族技能",
	-- ["Rorian: {quest:92485}"] = "羅里安：{quest:92485}",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read Ley Line racial ability at it."] = "{npc:249363}在林地東邊守望。{npc:251143}和奧拉凱斯皈依者聚集在她北邊；{object:460002}在更北邊升起：對它施放你的種族技能。",
}
