-- Chinese (simplified) (zhCN): the guide forever/alliance/nightelf/01-teldrassil (forever/alliance/nightelf/01-teldrassil.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aldrassil
	-- {area:256} Aldrassil · {area:188} Shadowglen
	["You start at the foot of {area:256}, the great tree of {area:188}."] = "你从{area:188}的巨树{area:256}脚下开始。",
	-- {npc:2077} Melithar Staghelm
	["{npc:2077}, by the path"] = "{npc:2077}，在小路旁",
	-- {npc:1992} Tarindrella
	["{npc:1992}, south of the tree"] = "{npc:1992}，在巨树南边",

	-- Step 2: Shadowglen: kill these as you meet them
	-- {area:188} Shadowglen
	["{area:188}: kill these as you meet them"] = "{area:188}：沿途击杀以下目标",
	-- {area:256} Aldrassil · {item:3297} Fel Moss
	-- plural, as words: Young Nightsabers = {npc:2031} Young Nightsaber · Young Thistle Boars = {npc:1984} Young Thistle Boar · Gnarlpine Totems = {item:279082} Gnarlpine Totem
	["Young Nightsabers and Young Thistle Boars roam around {area:256}. Grells carry {item:3297} in the woods west of the tree, where the Gnarlpine Totems stand."] = "夜刃豹幼崽和草刺野猪幼崽在{area:256}周围游荡。小劣魔在巨树西边的树林里携带{item:3297}，瘤背图腾就立在那里。",

	-- Step 3: Back at Aldrassil
	-- {area:256} Aldrassil
	["Back at {area:256}"] = "回到{area:256}",
	-- {npc:2079} Conservator Ilthalaine · {npc:3596} Ayanna Everstride
	["{npc:2079}: a sigil for {npc:3596}"] = "{npc:2079}：给{npc:3596}的印记",
	-- {npc:2082} Gilshalan Windwalker
	["{npc:2082}, on the tree's ramp"] = "{npc:2082}，在巨树的坡道上",
	-- {npc:3595} Shanda
	["{npc:3595}: in at the tree's front entrance and up the ramp; upstairs"] = "{npc:3595}在楼上：从大树正门进入，沿坡道向上",
	-- {quest:97979} The Goddess Provides · {spell:1259799} Elune's Light · {npc:3595} Shanda
	["{quest:97979}: cast {spell:1259799} and Shadowmeld, then hand it back to {npc:3595}"] = "{quest:97979}：施放{spell:1259799}和影遁，然后交还给{npc:3595}",
	-- {npc:8583} Dirania Silvershine
	["{npc:8583}, east of the tree"] = "{npc:8583}，在巨树东边",

	-- Step 4: North to Shadowthread Cave
	-- {area:257} Shadowthread Cave
	["North to {area:257}"] = "向北前往{area:257}",
	-- {area:256} Aldrassil · {npc:1994} Githyiss the Vile · {npc:8584} Iverron
	-- plural, as words: Mangy Nightsabers = {npc:2032} Mangy Nightsaber · Thistle Boars = {npc:1985} Thistle Boar
	["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:1994} sits deep inside. {npc:8584} waits in the trees west of the cave mouth."] = "癞皮夜刃豹和草刺野猪在{area:256}北边、通往洞穴的路上游荡。{npc:1994}在洞穴深处。{npc:8584}在洞口西边的树林里等候。",
	-- plural, as words: Webwood Spiders = {npc:1986} Webwood Spider
	["Webwood Spiders; below ground"] = "洞穴内的树林蜘蛛",

	-- Step 5: Aldrassil
	-- {area:256} Aldrassil · {npc:3593} Alyissia · {npc:3594} Frahun Shadewhisper · {npc:3595} Shanda · {npc:3596} Ayanna Everstride · {npc:3597} Mardant Strongoak
	["The trainers stand upstairs inside {area:256}, along the ramp that winds up the tree: {npc:3593} and {npc:3594} on the first level, {npc:3595} above them, {npc:3596} and {npc:3597} at the top. The arrow cannot tell the levels apart."] = "训练师们在{area:256}内的楼上，沿着绕树而上的坡道分布：{npc:3593}和{npc:3594}在第一层，{npc:3595}在他们上面，{npc:3596}和{npc:3597}在顶层。箭头无法区分楼层。",
	-- {npc:3593} Alyissia
	["{npc:3593}, the warrior trainer; inside"] = "战士训练师{npc:3593}，位于屋内",
	-- {npc:3596} Ayanna Everstride
	["{npc:3596}, the hunter trainer"] = "{npc:3596}，猎人训练师",
	-- {npc:3594} Frahun Shadewhisper
	["{npc:3594}, the rogue trainer"] = "{npc:3594}，潜行者训练师",
	-- {npc:3595} Shanda
	["{npc:3595}, the priest trainer: in at the tree's front entrance and up the ramp"] = "{npc:3595}是牧师训练师：从树的正面入口进去，沿斜坡上楼",
	-- {npc:3597} Mardant Strongoak · {area:256} Aldrassil
	["{npc:3597}, the druid trainer at {area:256}"] = "{npc:3597}，{area:256}的德鲁伊训练师",

	-- Step 6: Webwood Egg and the antidote
	-- {quest:917} Webwood Egg
	["{quest:917} and the antidote"] = "{quest:917}和解药",
	-- {object:4406} Webwood Eggs · {area:257} Shadowthread Cave · {area:256} Aldrassil
	-- plural, as words: Hyacinth Mushrooms = {item:10639} Hyacinth Mushroom
	["The {object:4406} lie at the back of {area:257}: take the central path, then left where it splits, up to the high ledge. Hyacinth Mushrooms drop from Grells, Moonpetal Lilies grow by the ponds north of {area:256}."] = "{object:4406}在{area:257}深处：走中间的路，分岔处向左，一直上到高处的岩架。紫蓝色蘑菇由小劣魔掉落，月牙百合花长在{area:256}北边的池塘旁。",
	["Grells"] = "小劣魔",

	-- Step 8: Shadowglen
	["Below ground"] = "在地下",
	-- {quest:97236} Fang of Githyiss
	["{quest:97236}; below ground"] = "{quest:97236}：在地下",

	-- Step 9: Aldrassil
	-- {npc:3514} Tenaron Stormgrip
	["{npc:3514}, at the top of the tree"] = "{npc:3514}，在巨树顶端",

	-- Step 10: The moonwell and Iverron
	-- {npc:8584} Iverron
	["The moonwell and {npc:8584}"] = "月亮井和{npc:8584}",
	-- {area:256} Aldrassil
	["The moonwell sits north of {area:256}."] = "月亮井位于{area:256}北侧。",
	-- {item:5185} Crystal Phial
	["Use the {item:5185} at the moonwell"] = "在月亮井使用{item:5185}",

	-- Step 11: Tenaron Stormgrip
	-- {area:256} Aldrassil · {object:654846} Lost Journal (no name in this language: may be words)
	["Back to the top of {area:256}. The {object:654846} lies beside him."] = "回到{area:256}顶端。{object:654846}就在他旁边。",
	["Upstairs"] = "在楼上",
	-- {object:654846} Lost Journal (no name in this language: may be words)
	["{object:654846}, upstairs"] = "{object:654846}：在楼上",

	-- Step 12: Iverron's Antidote
	-- {npc:8583} Dirania Silvershine · {area:256} Aldrassil · {npc:8584} Iverron
	["Take the antidote from {npc:8583} at the foot of {area:256} only now, on the way down: it lasts five minutes. {npc:8584} waits north-west, by the cave: go straight on to him."] = "",

	-- Step 13: Porthannius
	-- {area:188} Shadowglen · {area:256} Aldrassil · {npc:6780} Porthannius · {area:186} Dolanaar
	["Leave {area:188} by the path south-east of {area:256}: {npc:6780} stands beside it, where it goes down towards the road to {area:186}."] = "从{area:256}东南方的小路离开{area:188}：{npc:6780}站在路旁，在小路下坡通往{area:186}道路的地方。",

	-- Step 14: Zenn Foulhoof
	-- {area:188} Shadowglen · {npc:2150} Zenn Foulhoof · {area:186} Dolanaar
	["Follow the road south-west out of {area:188}. {npc:2150} sits beside it just east of {area:186}."] = "沿道路向西南离开{area:188}。{npc:2150}就坐在路旁，在{area:186}东边不远处。",

	-- Step 15: Dolanaar
	-- {npc:265811} Lyreena Duskblade
	["{npc:265811}, by the campfire"] = "{npc:265811}，在篝火旁",

	-- Step 16: The Great Outdoors
	-- {npc:265811} Lyreena Duskblade · {spell:1229451} Boosted Rest
	["/sit by {npc:265811}'s campfire until you get {spell:1229451}"] = "在{npc:265811}的篝火旁 /sit，直到获得{spell:1229451}",
	-- {npc:6286} Zarrin
	["{npc:6286}, south of the inn: Camping 101 asks you to learn it"] = "{npc:6286}位于旅店南侧，露营 101 要求你学习这项技能",

	-- Step 17: Dolanaar
	-- {npc:3515} Corithras Moonrage
	["{npc:3515}, south of the inn"] = "{npc:3515}，在旅店南边",
	-- {npc:3608} Aldia
	["{npc:3608}, upstairs"] = "{npc:3608}：在楼上",
	-- {npc:3567} Tallonkai Swiftroot
	["{npc:3567}, upstairs"] = "{npc:3567}：在楼上",
	-- {npc:3600} Laurna Morninglight
	["{npc:3600}, inside"] = "{npc:3600}：在屋内",

	-- Step 18: Dolanaar
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151}在村子西边的道路上巡逻：如果她不在箭头处，沿着道路走直到遇见她。",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151}, on the road west of the village"] = "{npc:2151}，在村子西边的路上",

	-- Step 19: Teldrassil: kill these as you meet them
	-- {quest:940} Teldrassil
	["{quest:940}: kill these as you meet them"] = "{quest:940}：沿途击杀以下目标",
	-- {area:186} Dolanaar · {area:260} Starbreeze Village
	-- plural, as words: Strigid Owls = {npc:1995} Strigid Owl · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east; the lurkers also drop the recipe's spider legs. The moonwell is at the west edge of {area:260}."] = "夜刃豹、巨翼枭和树林潜伏者在{area:186}周围及东侧道路旁活动；潜伏者还掉落配方所需的蜘蛛腿。月亮井位于{area:260}西缘。",
	["Nightsabers"] = "夜刃豹",
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers"] = "树林潜伏者",

	-- Step 20: Zenn Foulhoof
	-- {npc:2150} Zenn Foulhoof · {area:186} Dolanaar · {area:260} Starbreeze Village
	["{npc:2150} sits by the road just east of {area:186}, between {area:186} and {area:260}."] = "{npc:2150} 坐在 {area:186} 正东的路边，位于 {area:186} 与 {area:260} 之间。",

	-- Step 21: Starbreeze Village
	-- {npc:2107} Gaerolas Talvethren · {object:126158} Tallonkai's Dresser
	["{npc:2107} stands upstairs in a house in the village, east of the moonwell: go up inside, the arrow cannot tell the floors apart. {object:126158} is in the house on the hill at the east end of the village."] = "{npc:2107}在村里月亮井东边一座房子的楼上：从里面上楼，箭头无法区分楼层。{object:126158}在村子东端山丘上的房子里。",
	-- {item:5619} Jade Phial
	["Use the {item:5619} at the moonwell"] = "在月亮井使用{item:5619}",
	-- {object:126158} Tallonkai's Dresser
	["{object:126158}; inside"] = "{object:126158}：在屋内",

	-- Step 22: Lake Al'Ameth
	-- {npc:2150} Zenn Foulhoof · {npc:2080} Denalan · {quest:919} Timberling Sprouts
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-west of Starbreeze, south of {npc:2150}. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "位于星风村西南、{npc:2150} 南边。{npc:2080} 在岸边照料树苗；鞭笞者幼苗 和林精在他周围游荡，{quest:919} 就长在它们之间。",
	-- {npc:2080} Denalan · {quest:922} Rellian Greenspyre · {zone:1457} Darnassus
	["{npc:2080}: {quest:922} in {zone:1457} takes it"] = "{npc:2080}：交给{zone:1457}的{quest:922}",

	-- Step 24: Fel Rock's mouth
	-- {area:258} Fel Rock
	["{area:258}'s mouth"] = "{area:258}的洞口",

	-- Step 25: Fel Rock
	-- {npc:2038} Lord Melenas
	["{npc:2038} waits inside the cave, at the bottom or up on the ledge; keep to the right."] = "{npc:2038}在洞内等候，在底部或上方的岩架上；靠右走。",
	-- {npc:2038} Lord Melenas
	["{npc:2038}; below ground"] = "{npc:2038}：在地下",

	-- Step 26: The road to Darnassus
	-- {zone:1457} Darnassus
	["The road to {zone:1457}"] = "通往{zone:1457}的路",
	-- {area:258} Fel Rock
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["Gnarlpine Ambushers hide along the road west of {area:258}."] = "瘤背伏击者埋伏在{area:258}西边的道路沿途。",

	-- Step 27: Sentinel Shayla Nightbreeze
	-- {area:261} Gnarlpine Hold
	["West along the road to the city gate: Shayla stands beside it. Every Gnarlpine furbolg drops fangs: the ambushers on this road, the barrow's and {area:261}'s all count."] = "沿路向西前往城门，哨兵莎依拉·夜风就站在门旁。所有瘤背熊怪都会掉落牙齿，这条路上的伏击者、兽穴里的熊怪和{area:261}的熊怪都算。",

	-- Step 28: Darnassus
	-- {quest:922} Rellian Greenspyre · {area:1658} Cenarion Enclave · {npc:7316} Sister Aquinne · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade · {item:279378} Lunar Pendant
	["Into the city through the gate. {quest:922} is just south of the {area:1658} at the north end, {npc:7316} in the west, {npc:7313} and {npc:8396} in the Temple of the Moon at the south end. On the way back out, use Dalia's {item:279378} at the bank and at the city gate; the other two owls wait for your last visit."] = "穿过城门进城。{quest:922}在城北端{area:1658}以南不远处，{npc:7316}在城西，{npc:7313}和{npc:8396}在城南端的月神殿。出城时，在银行和城门处使用哨兵达莉亚·炎刃的{item:279378}；另外两只猫头鹰留到最后一次来时再找。",
	-- {npc:7313} Priestess A'moora
	["{npc:7313}, in the Temple of the Moon"] = "{npc:7313}，在月神殿",
	-- {npc:8396} Sentinel Dalia Sunblade
	["{npc:8396}, beside her"] = "{npc:8396}，在她旁边",
	-- {item:279378} Lunar Pendant
	["{item:279378}: the bank, on the way out"] = "{item:279378}：出城途中的银行",
	["the city gate"] = "城门",

	-- Step 29: Ban'ethil Barrow Den's entrance
	-- {area:262} Ban'ethil Barrow Den
	["{area:262}'s entrance"] = "",

	-- Step 30: Ban'ethil Barrow Den
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:7317} Oben Rageclaw
	["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms. Its furbolgs drop Shayla's fangs."] = "兽穴在路南。{npc:275744}被关在里面，{npc:7317}沉睡在深处，四个圣物箱在下层房间。里面的熊怪会掉落哨兵莎依拉·夜风需要的牙齿。",
	-- {item:5220} Gnarlpine Fang
	["{item:5220}: any Gnarlpine furbolg"] = "{item:5220}：任意瘤背熊怪",
	-- {npc:7317} Oben Rageclaw
	["{npc:7317}, below ground"] = "{npc:7317}：在地下",
	-- plural, as words: Gnarlpine Shamans = {npc:2009} Gnarlpine Shaman
	["Gnarlpine Shamans"] = "瘤背萨满祭司",
	-- {npc:7318} Rageclaw · {area:736} Ban'ethil Hollow
	["{npc:7318}, in the den; walks around {area:736}: look inside the circle on the map"] = "{npc:7318}在兽穴内的{area:736}附近巡逻，请在地图标示的圆圈内寻找",

	-- Step 31: Escaping Ban'ethil
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:2081} Sentinel Kyra Starsong · {area:186} Dolanaar
	["Escort {npc:275744} out of the barrow; {npc:2081} in {area:186} takes the report."] = "护送{npc:275744}离开兽穴；{area:186}的{npc:2081}接收报告。",
	["Walk Lynessa out and keep her alive"] = "带哨兵莱妮莎·暮花走出去，保证她存活",
	-- {area:736} Ban'ethil Hollow
	["{area:736}, outside the barrow"] = "{area:736}，在兽穴外",

	-- Step 32: The Pools of Arlithrien
	-- {area:478} Pools of Arlithrien
	["The {area:478}"] = "{area:478}",
	["South-west of the barrow. The moonwell sits by the pools."] = "在兽穴西南方。月亮井就在水池旁。",
	-- {item:5621} Tourmaline Phial
	["Use the {item:5621} at the moonwell"] = "在月亮井使用{item:5621}",

	-- Step 33: Gnarlpine Hold
	-- {object:6751} Strange Fruited Plant
	["South of the pools. The {object:6751} grows by the Hold; the furbolgs around it drop the rest of the fangs."] = "水池南边。{object:6751}长在据点旁，击杀周围的熊怪，收齐剩余牙齿。",

	-- Step 35: Seek Redemption!
	-- {area:186} Dolanaar · {npc:2150} Zenn Foulhoof · {npc:7234} Ferocitas the Dream Eater
	-- plural, as words: Fel Cones = {object:1673} Fel Cone
	["Fel Cones lie under the trees all around {area:186} and {npc:2150}: pick them up on the road east and hand them to {npc:2150} on the way to {npc:7234}."] = "{area:186}和{npc:2150}周围的树下都有魔锥果：沿路向东时捡起，前往{npc:7234}途中交给{npc:2150}。",

	-- Step 36: Ferocitas the Dream Eater
	-- {npc:7234} Ferocitas the Dream Eater · {area:260} Starbreeze Village · {item:8049} Gnarlpine Necklace
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["Gnarlpine Mystics and {npc:7234} camp north-east of {area:260}. {npc:7234} drops the {item:8049}: open it for the jewel.\nCareful: {npc:7234} waits near the camp fire with mystics around him, so pulling him without adds is hard."] = "瘤背秘法师和 {npc:7234} 扎营在 {area:260} 的东北方。{npc:7234} 会掉落 {item:8049}：打开它即可获得宝石。\n注意：{npc:7234} 在营火旁等候，周围有秘法师，很难单独引出他而不惊动其他敌人。",
	-- {item:8049} Gnarlpine Necklace · {npc:7234} Ferocitas the Dream Eater
	["{item:8049}, from {npc:7234}"] = "{item:8049}，由{npc:7234}掉落",

	-- Step 37: Dolanaar
	-- {area:264} Oracle Glade · {area:186} Dolanaar · {npc:3567} Tallonkai Swiftroot
	["The road west to the {area:264} runs through {area:186}: hand {npc:3567} the jewel on the way."] = "向西前往{area:264}的道路经过{area:186}：顺路把珠宝交给{npc:3567}。",

	-- Step 38: Sentinel Shayla Nightbreeze
	-- {area:186} Dolanaar
	["West along the road from {area:186}: Shayla still stands beside it, before the turn north to the glade."] = "从{area:186}沿路向西，哨兵莎依拉·夜风仍站在路旁，就在向北转往林地的岔路之前。",

	-- Step 39: The Wellspring River
	-- {area:265} Wellspring River
	["The {area:265}"] = "{area:265}",
	-- {area:265} Wellspring River
	-- plural, as words: Mossy Tumors = {item:5170} Mossy Tumor
	["North from the road the path to the glade crosses the {area:265}: the timberlings along it drop the Mossy Tumors."] = "从大路往北，通往林地的小径会跨过{area:265}；河边的林精会掉落青苔之瘤。",
	-- {item:5170} Mossy Tumor
	["{item:5170}: timberlings"] = "{item:5170}：林精",

	-- Step 40: Oracle Glade
	-- {object:6752} Strange Fronded Plant
	["The moonwell is in the middle of the glade. The {object:6752} grows at its north end."] = "月亮井在林地中央。{object:6752}长在林地北端。",
	-- {npc:3519} Sentinel Arynia Cloudsbreak
	["{npc:3519}, by the moonwell"] = "{npc:3519}，在月亮井旁",
	-- {item:18152} Amethyst Phial
	["Use the {item:18152} at the moonwell"] = "在月亮井旁使用{item:18152}",

	-- Step 41: Bloodfeather harpies
	["Bloodfeather harpies"] = "血羽鹰身人",
	-- {quest:938} Mist
	["The Bloodfeather harpies nest on the slopes west and north of the glade. {quest:938}, an injured sabercat, lies by the glade's west wall among them: lead her back to Sentinel Arynia at the moonwell before her time runs out.\nCareful: The harpies stand packed together, so extra ones often join a fight. Casters are mixed in among them."] = "血羽鹰身人在林地西边和北边的山坡筑巢。受伤的夜刃豹{quest:938}躺在林地西侧岩壁旁，就在鹰身人之间；在时限内把她带回月亮井旁的哨兵阿瑞尼亚·碎云处。\n小心：鹰身人分布密集，经常会有其他怪物加入战斗，其中还混有施法者。",
	-- {quest:938} Mist
	["{quest:938}, by the west wall"] = "{quest:938}，在西侧岩壁旁",
	-- {quest:938} Mist
	["Lead {quest:938} to the moonwell"] = "带{quest:938}前往月亮井",

	-- Step 42: Sentinel Arynia Cloudsbreak
	["Back to the moonwell."] = "回到月亮井。",

	-- Step 43: The named harpies
	["The named harpies"] = "有名字的鹰身人",
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress · {npc:272046} Witchmother Arysa
	["{npc:272034} and {npc:272044} fly just west of the moonwell, {npc:272046} further north."] = "{npc:272034}和{npc:272044}在月亮井西边不远处飞行，{npc:272046}在更北边。",

	-- Step 44: Lady Sathrah
	-- {object:6752} Strange Fronded Plant · {npc:272046} Witchmother Arysa · {area:266} Wellspring Lake · {npc:7319} Lady Sathrah
	["The {object:6752} grows at the glade's north end, on the way: then north of {npc:272046}, along the island's northern edge by {area:266}, {npc:7319}, a level 12 spider, lurks."] = "{object:6752}长在林地北端，途中会经过。接着去{npc:272046}北边，沿岛屿北缘前往{area:266}附近；12级蜘蛛{npc:7319}潜伏在那里。",

	-- Step 45: Sentinel Arynia again
	["Sentinel Arynia again"] = "再次找哨兵阿瑞尼亚",
	-- {object:673378} Oracle Tree Bark (no name in this language: may be words)
	["{object:673378}, just west of the moonwell"] = "{object:673378}，在月亮井西边不远处",
	-- {object:673378} Oracle Tree Bark (no name in this language: may be words) · {zone:1457} Darnassus
	["the same {object:673378}: Fandral in {zone:1457} takes it"] = "同一个{object:673378}：交给{zone:1457}的范达尔·鹿盔",

	-- Step 46: Ursal the Mauler
	-- {area:478} Pools of Arlithrien
	["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}.\nCareful: Gnarlpine of roughly level 9-12 crowd the camp and sit close together, so it is easy to pull several at once. Take them on singly before you engage Ursal."] = "沿岛屿西侧向南步行。大槌乌萨尔在最南端、{area:478}下方活动。\n注意：营地中有许多约 9–12 级的瘤背熊怪，站位密集，容易一次引到多只。挑战大槌乌萨尔前，先逐个清理它们。",

	-- Step 47: Dolanaar
	-- {area:186} Dolanaar
	["North-east from Ursal's den, back to {area:186}."] = "从乌萨尔的巢穴向东北返回{area:186}。",
	-- {npc:6094} Byancie
	["{npc:6094}, inside"] = "{npc:6094}：在屋内",
	-- {item:3371} Empty Vial · {npc:3614} Narret Shadowgrove · {npc:6094} Byancie
	["{item:3371} from {npc:3614}, beside {npc:6094}"] = "从{npc:6094}旁边的{npc:3614}处获得{item:3371}",
	-- {npc:3600} Laurna Morninglight · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:3600}: {npc:11401} in {zone:1457} takes it"] = "{npc:3600}：交给{zone:1457}的{npc:11401}",
	-- {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr · {npc:6094} Byancie
	["{item:159} from {npc:6736}, for {npc:6094}"] = "从{npc:6736}处获得{item:159}，交给{npc:6094}",
	-- {zone:1457} Darnassus
	["Fandral in {zone:1457} takes it"] = "交给{zone:1457}的范达尔",
	-- {npc:3602} Kal · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:3602}: {npc:4217} in {zone:1457} takes it"] = "{npc:3602}：交给{zone:1457}的{npc:4217}",
	-- {npc:3598} Kyra Windblade · {quest:1684} Elanaria · {zone:1457} Darnassus
	["{npc:3598}, the warrior trainer: {quest:1684} in {zone:1457} takes it"] = "战士训练师{npc:3598}：交给{zone:1457}的{quest:1684}",

	-- Step 48: Lake Al'Ameth
	-- {npc:2080} Denalan
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-east of Dolanaar, to {npc:2080}. Lasher Sproutlings wander around him on the shore."] = "前往多兰纳尔东南方的{npc:2080}处。{npc:275703}在湖岸上围着他游荡。",
	-- {object:7510} Sprouted Frond
	["{object:7510}, beside him"] = "{object:7510}，在他旁边",

	-- Step 49: Dolanaar again
	-- {area:186} Dolanaar
	["{area:186} again"] = "再次回到{area:186}",
	-- {npc:6094} Byancie · {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr
	["{npc:6094} takes a {item:159} with the fronds and the vial: if you drank yours, buy another from {npc:6736} in this inn before you hand in."] = "除树叶和药瓶外，{npc:6094}还需要一个{item:159}。如果之前喝掉了，请在交任务前向本旅店的{npc:6736}再买一个。",

	-- Step 50: Taming the Beast
	-- {item:15908} Taming Rod · {area:186} Dolanaar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker · Nightsaber Stalkers = {npc:2043} Nightsaber Stalker · Strigid Screechers = {npc:1996} Strigid Screecher
	["Each of Dazalar's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "达扎拉的每个任务都会给你一根{item:15908}：对他指定的野兽使用，然后把驯兽棒带回{area:186}交给他。{npc:1998}在村子周围爬行，{npc:2043}和{npc:1996}在村子南边的树林里游荡。",
	-- {npc:1998} Webwood Lurker · {item:15908} Taming Rod
	["{npc:1998}: tame it with the {item:15908}"] = "{npc:1998}：用{item:15908}驯服它",
	-- {npc:2043} Nightsaber Stalker · {item:15908} Taming Rod
	["{npc:2043}: tame it with the {item:15908}"] = "{npc:2043}：用{item:15908}驯服它",
	-- {npc:1996} Strigid Screecher · {item:15908} Taming Rod
	["{npc:1996}: tame it with the {item:15908}"] = "{npc:1996}：用{item:15908}驯服它",
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457} takes it"] = "交给{zone:1457}的{npc:4146}",

	-- Step 51: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {zone:1457} Darnassus
	["Take the road north-west from {area:186} again; she still lies beside it, on the way to {zone:1457}."] = "再次从{area:186}沿道路向西北走；她仍躺在路旁，在去{zone:1457}的路上。",

	-- Step 52: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "进入{zone:1457}",
	-- {npc:4241} Mydrannul · {area:1659} Craftsmen's Terrace
	["{npc:4241}, on the {area:1659} just inside the city"] = "{npc:4241}，在刚进城的{area:1659}上",

	-- Step 54: Elanaria
	-- {quest:1684} Elanaria · {area:1660} Warrior's Terrace
	["{quest:1684} stands on the {area:1660}, just inside the city."] = "{quest:1684}站在{area:1660}，刚进城就能看到。",

	-- Step 55: Vorlus Vilehoof
	-- {quest:1683} Vorlus Vilehoof · {area:736} Ban'ethil Hollow · {quest:1684} Elanaria
	["Back out of the city gate and east along the road: {quest:1683} stands south of it, by {area:736}. Bring his horn back to {quest:1684}."] = "出城后沿路向东，{quest:1683}站在道路南侧的{area:736}附近。拿到角后返回交给{quest:1684}。",

	-- Step 57: Darnassus
	-- {zone:1457} Darnassus · {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace · {area:3425} Cenarion Hold · {npc:4241} Mydrannul · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:922} Rellian Greenspyre · {npc:4092} Lariia · {npc:7999} Tyrande Whisperwind · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade
	["Follow the road west into {zone:1457} and use the {item:279378} at the inn on the {area:1659} and at the tunnel mouth below {area:3425} for the last two owls. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092}, {npc:7999}, {npc:7313} and {npc:8396} are in the Temple of the Moon at the south end."] = "沿路向西进入{zone:1457}，在{area:1659}的旅店和{area:3425}下方的隧道口使用{item:279378}，找到最后两只猫头鹰。{npc:4241}站在刚进城的{area:1659}。{npc:3516}在城北端的{area:1658}，{quest:922}就在其南边不远；{npc:4092}、{npc:7999}、{npc:7313}和{npc:8396}都在城南端的月神殿。",
	-- {npc:4088} Elanaria · {area:1660} Warrior's Terrace · {spell:71} Defensive Stance
	["{npc:4088}, on the {area:1660}: {spell:71}"] = "{npc:4088}，位于{area:1660}：{spell:71}",
	-- {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace
	["{item:279378}: the inn on the {area:1659}"] = "{item:279378}：{area:1659}的旅店",

	-- Step 59: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, in the {area:1658}"] = "{npc:3516}，在{area:1658}",

	-- Step 60: Cenarion Enclave
	-- {npc:4146} Jocaste · {area:1658} Cenarion Enclave · {spell:5149} Beast Training
	["{npc:4146}, in the {area:1658}: {spell:5149}"] = "{npc:4146}，在{area:1658}：{spell:5149}",

	-- Step 62: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217}, in the {area:1658}"] = "{npc:4217}，在{area:1658}",
	-- {area:3425} Cenarion Hold
	["the tunnel mouth below {area:3425}, on the way south"] = "{area:3425}下方的隧道口，向南途中会经过",
	-- {npc:4092} Lariia
	["{npc:4092}, in the Temple of the Moon"] = "{npc:4092}，在月神殿",
	-- {npc:7999} Tyrande Whisperwind · {npc:4092} Lariia
	["{npc:7999}, above {npc:4092}"] = "{npc:7999}，在{npc:4092}上方",
	-- {quest:2520} Sathrah's Sacrifice
	["{quest:2520}, standing in the temple's central fountain"] = "{quest:2520}，站在神殿中央的喷泉里完成",
	-- {npc:11401} Priestess Alathea
	["{npc:11401}, in the Temple of the Moon: Starshards"] = "{npc:11401}，在月神殿：星辰碎片",

	-- Step 63: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "顺路提示：向{npc:11866}学习法杖（{area:1660}，10 银）；猎人的近战武器主要用于提供属性，双手武器的属性通常更多。",

	-- Step 64: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "顺路提示：向{npc:11866}学习法杖（{area:1660}，10 银）；升级时法杖提供的法术属性通常比单手武器更多。",

	-- Step 65: Portal to Teldrassil
	-- {quest:940} Teldrassil
	["Portal to {quest:940}"] = "传送至{quest:940}",

	-- Step 66: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:10118} Nessa Shadowsong · {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine · {area:442} Auberdine · {npc:4200} Laird
	["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs. Once you have {quest:6342}, talk to {npc:3838} again and choose the flight to {area:442}: it is free and lands beside {npc:4200}. If the flight map opens instead, close it and talk to him again holding Shift."] = "通过传送门下到{area:702}。{npc:10118}站在码头上，{npc:3838}在角鹰兽旁。接到{quest:6342}后，再次与{npc:3838}交谈，选择飞往{area:442}：这趟免费，落地就在{npc:4200}旁边。如果打开的是飞行地图，先关闭，再按住 Shift 与他交谈。",
	-- {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine
	["talk to {npc:3838} again: free with {quest:6342}"] = "再次与{npc:3838}交谈：持有{quest:6342}时免费",

	-- Step 67: Auberdine
	-- {npc:3841} Caylais Moonfeather · {npc:4200} Laird
	["Learn the flight path from {npc:3841} where you land. {npc:4200}'s fish stall is just north of her, by the docks.\nThe boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "降落后向{npc:3841}学习飞行路线。{npc:4200}的鱼摊就在她北侧、码头旁。\n船在村庄西侧停靠，飞行管理员位于旅店南侧山丘，任务 NPC 分布在主街沿线。",
	["The WANTED poster outside the inn"] = "旅店外的通缉布告",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart"] = "",

	-- Step 68: Return to Nessa
	-- {area:702} Rut'theran Village · {npc:3841} Caylais Moonfeather · {item:16263} Laird's Response · {npc:10118} Nessa Shadowsong · {area:442} Auberdine
	["Fly back to {area:702} from {npc:3841}, hand {item:16263} to {npc:10118} on the dock, then fly back to {area:442}."] = "从{npc:3841}处飞回{area:702}，把{item:16263}交给码头上的{npc:10118}，然后飞回{area:442}。",

	-- Step 69: The Long Wash
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "{npc:2232}在村子下方的岸边爬行；{quest:983}立在码头南边的海滩上。{npc:2185}在浅水中游动。{object:175207}躺在村子南边的岸上。",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "",

	-- Step 70: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}，在村子北端",

	-- Step 71: Gubber Blump
	-- {npc:10216} Gubber Blump · {item:12238} Darkshore Grouper
	["Fishers only: {npc:10216} stands on the pier. His {item:12238} is fished from the pier itself."] = "仅限钓鱼者：{npc:10216}站在栈桥上。他需要的{item:12238}就在栈桥处钓。",
	-- {npc:10216} Gubber Blump
	["{npc:10216}, on the pier"] = "{npc:10216}，在码头上",

	-- Step 72: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}, no flight path needed. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "施放{spell:18960}。{npc:11802}在{area:2361}；{quest:5929}在西北方的树林里。然后{area:2361}的{npc:11800}会直接送德鲁伊飞往{area:702}，无需飞行路线。{npc:11802}在他所在建筑的楼上：从里面上楼，箭头无法区分楼层。",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "与{quest:5929}交谈",

	-- Step 73: Back to Darnassus
	-- {npc:10118} Nessa Shadowsong · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:10118} stands on the Rut'theran dock where you land. Then take the portal up to {npc:4217} in the {area:1658}."] = "落地后，{npc:10118}就在鲁瑟兰村码头上。随后通过传送门上去，到{area:1658}找{npc:4217}。",

	-- Step 76: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Go back down to {area:702} and fly to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "回到{area:702}，飞往{area:442}。{object:177525}立在村子东边的山丘上：在那里使用{item:15208}，击败月爪枭兽，然后与{npc:12144}交谈。",

	-- Step 77: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine
	["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442}."] = "再次飞往{area:702}，乘传送门上去找{npc:4217}，然后飞回{area:442}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {zone:1453}"] = "乘船前往{zone:1453}",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "施放{spell:18960}。{npc:11802}在{area:2361}；{quest:5929}所需的目标位于西北边的树林里。在{area:2361}学习{area:493}的飞行路线，然后经{area:442}飞到{area:702}。",
	-- ["Defensive Stance"] = "防御姿态",
	-- ["Each of {npc:3601}'s quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "{npc:3601}的每个任务都会给你一根{item:15908}：对他指定的野兽使用，然后把棍子带回{area:186}交给他。树林潜伏者在村子周围爬行，夜刃捕食者和巨翼恶枭在村子南边的树林里游荡。",
	-- ["East to {area:260}"] = "向东前往{area:260}",
	-- ["Fel Cones lie under the trees all around {area:186} and {npc:2150}. Nightsabers and Webwood Lurkers keep roaming the road east. {object:126158} is in the house on the hill at the east end of the village."] = "魔锥果散落在{area:186}和{npc:2150}周围的树下。夜刃豹和树林潜伏者在向东的道路上游荡。{object:126158}在村子东端山丘上的房子里。",
	-- ["Fly back to {area:702} from {npc:3841}, hand {item:16263} to {npc:10118} on the dock, then fly back to {area:442} for the boat."] = "从{npc:3841}处飞回{area:702}，把{item:16263}交给码头上的{npc:10118}，然后飞回{area:442}乘船。",
	-- ["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442} for the boat."] = "再次飞往{area:702}，乘传送门上去找{npc:4217}，然后飞回{area:442}乘船。",
	-- ["Follow the road south-west out of {area:188} to {area:186}."] = "沿道路向西南离开{area:188}前往{area:186}。",
	-- ["Follow the road west into {zone:1457}. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092} and {npc:7999} are in the Temple of the Moon at the south end. {npc:7316} is in the west of the city, on the way to the pink portal down to Rut'theran."] = "沿道路向西进入{zone:1457}。{npc:4241}站在一进城的{area:1659}上。{npc:3516}在城市北端的{area:1658}，{quest:922}就在其南边；{npc:4092}和{npc:7999}在南端的月神殿。{npc:7316}在城市西部，在通往鲁瑟兰村的粉色传送门的路上。",
	-- ["From the harbour walk into {object:2100}. {npc:5480} trains warriors there; {npc:6089} and {npc:6090} stand together by the {object:2152}. {npc:6090} fights you for his mug."] = "从港口步行进入{object:2100}。{npc:5480}在那里训练战士；{npc:6089}和{npc:6090}一起站在{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。",
	-- ["From {area:17203}, ride through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "从{area:17203}穿过城门进入{zone:1429}，沿道路向西前往{zone:1436}。",
	-- ["Gnarlpine Mystics and Ferocitas camp north-east of {area:260}. Ferocitas drops the {item:8049}: open it for the jewel."] = "瘤背秘法师和菲罗斯塔在{area:260}东北方扎营。菲罗斯塔掉落{item:8049}：打开它获得珠宝。",
	-- ["Hearth to {area:186}"] = "用炉石返回{area:186}",
	-- ["Learn the flight path from {npc:3841} where you land. {npc:4200}'s fish stall is just north of her, by the docks."] = "落地后向{npc:3841}学习飞行路线。{npc:4200}的鱼摊就在她北边不远处，靠近码头。",
	-- ["Learn the {area:442} flight path on the hill south of the inn, then cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "在旅店南边的山丘上学习{area:442}的飞行路线，然后施放{spell:18960}。{npc:11802}在{area:2361}；{quest:5929}在西北方的树林里。在{area:2361}学习{area:493}的飞行路线，然后飞往{area:702}（途经{area:442}）。",
	-- ["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:8584} waits in the trees west of the cave mouth; {npc:1994} sits deep inside."] = "癞皮夜刃豹和草刺野猪在{area:256}北边、通往洞穴的路上游荡。{npc:8584}在洞口西边的树林里等候；{npc:1994}在洞穴深处。",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers live along the road east. The moonwell is at the west edge of {area:260}."] = "夜刃豹、巨翼枭和树林潜伏者生活在向东的道路沿途。月亮井在{area:260}的西缘。",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east. The moonwell is at the west edge of {area:260}."] = "夜刃豹、巨翼枭和树林潜伏者在{area:186}四周和向东的道路沿途游荡。月亮井在{area:260}的西缘。",
	-- ["South of Zenn. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "在赛恩南边。{npc:2080}在湖岸照料他的树苗；Lasher Sproutling和林精在他周围游荡，{quest:919}长在它们中间。",
	-- ["South of the pools. The {object:6751} grows by the Hold."] = "在水池南边。{object:6751}长在脊骨堡旁。",
	-- ["Speak with {npc:6286}, south of the inn"] = "与旅店南边的{npc:6286}交谈",
	-- ["Take the boat to {zone:1453} from {area:442}'s docks."] = "从{area:442}码头乘船前往{zone:1453}。",
	-- ["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs."] = "乘传送门下到{area:702}。{npc:10118}站在码头上，{npc:3838}在角鹰兽旁边。",
	-- ["Take the portal up from {area:702} to {npc:4217} in the {area:1658}."] = "从{area:702}乘传送门上到{area:1658}找{npc:4217}。",
	-- ["Take the road north-west from {area:186} towards the {area:264}; she lies hurt beside it."] = "从{area:186}沿道路向西北前往{area:264}；她受伤躺在路旁。",
	-- ["Tame Beast"] = "驯服野兽",
	-- ["The Bloodfeather harpies nest on the slopes west and north of the glade."] = "血羽鹰身人在林地西边和北边的山坡上筑巢。",
	-- ["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms."] = "兽穴在道路南边。{npc:275744}被关在里面，{npc:7317}在深处沉睡，四个圣物箱在下层房间里。",
	-- ["The moonwell sits north of {area:256}; {npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "月亮井在{area:256}北边；{npc:8584}在稍远的西北方。{quest:3522}只有五分钟：装满药瓶后直接去找他。",
	-- ["The {area:264}"] = "{area:264}",
	-- ["Tide Crawlers scuttle along the shore below the village; {object:17182} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "潮行蟹在村庄下方海岸活动，{object:17182}位于码头南侧海滩。黑海岸蛇颈龙在浅水区游动，{object:175207}位于村庄南侧海岸。",
	-- ["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}."] = "沿岛屿西侧向南走。乌萨尔在最南端、{area:478}下方徘徊。",
	-- ["Webwood Spiders"] = "树林蜘蛛",
	-- ["{area:186} quests"] = "{area:186}的任务",
	-- ["{npc:11401}, in the Temple of the Moon: {spell:10797}"] = "{npc:11401}，在月神殿：{spell:10797}",
	-- ["{npc:2150} sits by the road just east of {area:186}, on the way to {area:260}."] = "{npc:2150}坐在{area:186}东边不远的路旁，在去{area:260}的路上。",
	-- ["{npc:2150}, on the way back"] = "{npc:2150}，在回程路上",
	-- ["{npc:3567}, back in {area:186}"] = "{npc:3567}，回到{area:186}",
	-- ["{npc:3593}, the warrior trainer"] = "{npc:3593}，战士训练师",
	-- ["{npc:3595}, inside the tree"] = "{npc:3595}，在巨树内",
	-- ["{npc:3595}, the priest trainer, inside the tree"] = "{npc:3595}，牧师训练师，在巨树内",
	-- ["{npc:3595}: in at the tree's front entrance and up the ramp"] = "{npc:3595}：从树的正面入口进去，沿斜坡上楼",
	-- ["{npc:4200}'s fish stall is by the docks. Then take the boat to {zone:1453}."] = "{npc:4200}的鱼摊在码头旁。然后乘船前往{zone:1453}。",
	-- ["{npc:4217}: Bear Form"] = "{npc:4217}：熊形态",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089}：防御姿态",
	-- ["{npc:7318}, in the den"] = "{npc:7318}，在兽穴内",
	-- ["{npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "{npc:8584}位于稍西北侧。{quest:3522}限时五分钟，装满药瓶后立即去找他。",
	-- ["{quest:488} and the Starbreeze moonwell"] = "{quest:488}和星风村的月亮井",
	-- ["{quest:97979}: cast {spell:1259799} and {spell:20580}, then hand it back to {npc:3595}"] = "{quest:97979}：施放{spell:1259799}和{spell:20580}，然后交还给{npc:3595}",
}
