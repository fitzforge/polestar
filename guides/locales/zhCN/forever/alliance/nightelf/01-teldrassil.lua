-- Chinese (simplified) (zhCN): the guide forever/alliance/nightelf/01-teldrassil (forever/alliance/nightelf/01-teldrassil.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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

	-- Step 2: The Balance of Nature
	-- {area:256} Aldrassil · {item:3297} Fel Moss
	-- plural, as words: Young Nightsabers = {npc:2031} Young Nightsaber · Young Thistle Boars = {npc:1984} Young Thistle Boar · Grells = {npc:1988} Grell · Gnarlpine Totems = {item:279082} Gnarlpine Totem
	["Young Nightsabers and Young Thistle Boars roam around {area:256}. Grells carry {item:3297} in the woods west of the tree, where the Gnarlpine Totems stand."] = "夜刃豹幼崽和草刺野猪幼崽在{area:256}周围游荡。小劣魔在巨树西边的树林里携带{item:3297}，瘤背图腾就立在那里。",

	-- Step 3: Back at Aldrassil
	-- {area:256} Aldrassil
	["Back at {area:256}"] = "回到{area:256}",
	-- {npc:2079} Conservator Ilthalaine · {npc:3596} Ayanna Everstride
	["{npc:2079}: a sigil for {npc:3596}"] = "{npc:2079}：给{npc:3596}的印记",
	-- {npc:2082} Gilshalan Windwalker
	["{npc:2082}, on the tree's ramp"] = "{npc:2082}，在巨树的坡道上",
	-- {npc:3595} Shanda
	["{npc:3595}: in at the tree's front entrance and up the ramp"] = "",
	-- {quest:97979} The Goddess Provides · {spell:1259799} Elune's Light · {npc:3595} Shanda
	["{quest:97979}: cast {spell:1259799} and Shadowmeld, then hand it back to {npc:3595}"] = "{quest:97979}：施放{spell:1259799}和影遁，然后交还给{npc:3595}",
	-- {npc:8583} Dirania Silvershine
	["{npc:8583}, east of the tree"] = "{npc:8583}，在巨树东边",

	-- Step 4: North to Shadowthread Cave
	-- {area:257} Shadowthread Cave
	["North to {area:257}"] = "向北前往{area:257}",
	-- {area:256} Aldrassil · {npc:8584} Iverron · {npc:1994} Githyiss the Vile
	-- plural, as words: Mangy Nightsabers = {npc:2032} Mangy Nightsaber · Thistle Boars = {npc:1985} Thistle Boar
	["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:8584} waits in the trees west of the cave mouth; {npc:1994} sits deep inside."] = "癞皮夜刃豹和草刺野猪在{area:256}北边、通往洞穴的路上游荡。{npc:8584}在洞口西边的树林里等候；{npc:1994}在洞穴深处。",
	-- plural, as words: Webwood Spiders = {npc:1986} Webwood Spider
	["Webwood Spiders"] = "树林蜘蛛",

	-- Step 5: Aldrassil
	-- {npc:3593} Alyissia
	["{npc:3593}, the warrior trainer"] = "{npc:3593}，战士训练师",
	-- {npc:3596} Ayanna Everstride
	["{npc:3596}, the hunter trainer"] = "{npc:3596}，猎人训练师",
	-- {npc:3594} Frahun Shadewhisper
	["{npc:3594}, the rogue trainer"] = "{npc:3594}，潜行者训练师",
	-- {npc:3595} Shanda
	["{npc:3595}, the priest trainer: in at the tree's front entrance and up the ramp"] = "",
	-- {npc:3597} Mardant Strongoak · {area:256} Aldrassil
	["{npc:3597}, the druid trainer at {area:256}"] = "{npc:3597}，{area:256}的德鲁伊训练师",

	-- Step 7: Webwood Egg and the antidote
	-- {quest:917} Webwood Egg
	["{quest:917} and the antidote"] = "{quest:917}和解药",
	-- {object:4406} Webwood Eggs · {area:257} Shadowthread Cave · {area:256} Aldrassil
	-- plural, as words: Hyacinth Mushrooms = {item:10639} Hyacinth Mushroom · Grells = {npc:1988} Grell
	["The {object:4406} lie at the back of {area:257}: take the central path, then left where it splits, up to the high ledge. Hyacinth Mushrooms drop from Grells, Moonpetal Lilies grow by the ponds north of {area:256}."] = "{object:4406}在{area:257}深处：走中间的路，分岔处向左，一直上到高处的岩架。紫蓝色蘑菇由小劣魔掉落，月牙百合花长在{area:256}北边的池塘旁。",

	-- Step 8: Aldrassil
	-- {npc:3514} Tenaron Stormgrip
	["{npc:3514}, at the top of the tree"] = "{npc:3514}，在巨树顶端",

	-- Step 9: The moonwell and Iverron
	-- {npc:8584} Iverron
	["The moonwell and {npc:8584}"] = "月亮井和{npc:8584}",
	-- {area:256} Aldrassil · {npc:8584} Iverron · {quest:3522} Iverron's Antidote
	["The moonwell sits north of {area:256}; {npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "月亮井在{area:256}北边；{npc:8584}在稍远的西北方。{quest:3522}只有五分钟：装满药瓶后直接去找他。",
	-- {item:5185} Crystal Phial
	["Use the {item:5185} at the moonwell"] = "在月亮井使用{item:5185}",

	-- Step 10: Tenaron Stormgrip
	-- {area:256} Aldrassil · {object:654846} Lost Journal (no name in this language: may be words)
	["Back to the top of {area:256}. The {object:654846} lies beside him."] = "回到{area:256}顶端。{object:654846}就在他旁边。",

	-- Step 11: Porthannius
	-- {area:188} Shadowglen · {area:256} Aldrassil · {npc:6780} Porthannius · {area:186} Dolanaar
	["Leave {area:188} by the path south-east of {area:256}: {npc:6780} stands beside it, where it goes down towards the road to {area:186}."] = "从{area:256}东南方的小路离开{area:188}：{npc:6780}站在路旁，在小路下坡通往{area:186}道路的地方。",

	-- Step 12: Zenn Foulhoof
	-- {area:188} Shadowglen · {npc:2150} Zenn Foulhoof · {area:186} Dolanaar
	["Follow the road south-west out of {area:188}. {npc:2150} sits beside it just east of {area:186}."] = "沿道路向西南离开{area:188}。{npc:2150}就坐在路旁，在{area:186}东边不远处。",

	-- Step 13: Dolanaar
	-- {npc:265811} Lyreena Duskblade
	["{npc:265811}, by the campfire"] = "{npc:265811}，在篝火旁",
	-- {npc:3515} Corithras Moonrage
	["{npc:3515}, south of the inn"] = "{npc:3515}，在旅店南边",

	-- Step 14: Zenn's Bidding and the Starbreeze moonwell
	-- {quest:488} Zenn's Bidding
	["{quest:488} and the Starbreeze moonwell"] = "{quest:488}和星风村的月亮井",
	-- {area:186} Dolanaar · {area:260} Starbreeze Village
	-- plural, as words: Strigid Owls = {npc:1995} Strigid Owl · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east. The moonwell is at the west edge of {area:260}."] = "夜刃豹、巨翼枭和树林潜伏者在{area:186}四周和向东的道路沿途游荡。月亮井在{area:260}的西缘。",
	-- {item:5619} Jade Phial
	["Use the {item:5619} at the moonwell"] = "在月亮井使用{item:5619}",
	-- {npc:2150} Zenn Foulhoof
	["{npc:2150}, on the way back"] = "{npc:2150}，在回程路上",

	-- Step 15: Dolanaar quests
	-- {area:186} Dolanaar
	["{area:186} quests"] = "{area:186}的任务",

	-- Step 16: The Great Outdoors
	-- {npc:265811} Lyreena Duskblade · {spell:1229451} Boosted Rest
	["/sit by {npc:265811}'s campfire until you get {spell:1229451}"] = "在{npc:265811}的篝火旁 /sit，直到获得{spell:1229451}",
	-- {npc:6286} Zarrin
	["Speak with {npc:6286}, south of the inn"] = "与旅店南边的{npc:6286}交谈",

	-- Step 17: East to Starbreeze Village
	-- {area:260} Starbreeze Village
	["East to {area:260}"] = "向东前往{area:260}",
	-- {area:186} Dolanaar · {npc:2150} Zenn Foulhoof · {object:126158} Tallonkai's Dresser
	-- plural, as words: Fel Cones = {object:1673} Fel Cone · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Fel Cones lie under the trees all around {area:186} and {npc:2150}. Nightsabers and Webwood Lurkers keep roaming the road east. {object:126158} is in the house on the hill at the east end of the village."] = "魔锥果散落在{area:186}和{npc:2150}周围的树下。夜刃豹和树林潜伏者在向东的道路上游荡。{object:126158}在村子东端山丘上的房子里。",
	["Nightsabers"] = "夜刃豹",
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers"] = "树林潜伏者",

	-- Step 19: Lake Al'Ameth
	-- {npc:2080} Denalan · {quest:919} Timberling Sprouts
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South of Zenn. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "在赛恩南边。{npc:2080}在湖岸照料他的树苗；Lasher Sproutling和林精在他周围游荡，{quest:919}长在它们中间。",

	-- Step 20: Dolanaar
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151}在村子西边的道路上巡逻：如果她不在箭头处，沿着道路走直到遇见她。",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151}, on the road west of the village"] = "{npc:2151}，在村子西边的路上",

	-- Step 21: Fel Rock's mouth
	-- {area:258} Fel Rock
	["{area:258}'s mouth"] = "{area:258}的洞口",

	-- Step 22: Fel Rock
	-- {npc:2038} Lord Melenas
	["{npc:2038} waits inside the cave, at the bottom or up on the ledge; keep to the right."] = "{npc:2038}在洞内等候，在底部或上方的岩架上；靠右走。",

	-- Step 23: The road to Darnassus
	-- {zone:1457} Darnassus
	["The road to {zone:1457}"] = "通往{zone:1457}的路",
	-- {area:258} Fel Rock
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["Gnarlpine Ambushers hide along the road west of {area:258}."] = "瘤背伏击者埋伏在{area:258}西边的道路沿途。",

	-- Step 24: Ban'ethil Barrow Den
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:7317} Oben Rageclaw
	["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms."] = "兽穴在道路南边。{npc:275744}被关在里面，{npc:7317}在深处沉睡，四个圣物箱在下层房间里。",
	-- plural, as words: Gnarlpine Shamans = {npc:2009} Gnarlpine Shaman
	["Gnarlpine Shamans"] = "瘤背萨满祭司",
	-- {npc:7318} Rageclaw
	["{npc:7318}, in the den"] = "{npc:7318}，在兽穴内",

	-- Step 25: Escaping Ban'ethil
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:2081} Sentinel Kyra Starsong · {area:186} Dolanaar
	["Escort {npc:275744} out of the barrow; {npc:2081} in {area:186} takes the report."] = "护送{npc:275744}离开兽穴；{area:186}的{npc:2081}接收报告。",
	["Walk Lynessa out and keep her alive"] = "带Lynessa走出去，保证她存活",
	-- {area:736} Ban'ethil Hollow
	["{area:736}, outside the barrow"] = "{area:736}，在兽穴外",

	-- Step 26: The Pools of Arlithrien
	-- {area:478} Pools of Arlithrien
	["The {area:478}"] = "{area:478}",
	["South-west of the barrow. The moonwell sits by the pools."] = "在兽穴西南方。月亮井就在水池旁。",
	-- {item:5621} Tourmaline Phial
	["Use the {item:5621} at the moonwell"] = "在月亮井使用{item:5621}",

	-- Step 27: Gnarlpine Hold
	-- {object:6751} Strange Fruited Plant
	["South of the pools. The {object:6751} grows by the Hold."] = "在水池南边。{object:6751}长在脊骨堡旁。",

	-- Step 28: Hearth to Dolanaar
	-- {area:186} Dolanaar
	["Hearth to {area:186}"] = "用炉石返回{area:186}",

	-- Step 29: Ferocitas the Dream Eater
	-- {area:260} Starbreeze Village · {item:8049} Gnarlpine Necklace
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["Gnarlpine Mystics and Ferocitas camp north-east of {area:260}. Ferocitas drops the {item:8049}: open it for the jewel."] = "瘤背秘法师和菲罗斯塔在{area:260}东北方扎营。菲罗斯塔掉落{item:8049}：打开它获得珠宝。",
	-- {npc:3567} Tallonkai Swiftroot · {area:186} Dolanaar
	["{npc:3567}, back in {area:186}"] = "{npc:3567}，回到{area:186}",

	-- Step 30: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {area:264} Oracle Glade
	["Take the road north-west from {area:186} towards the {area:264}; she lies hurt beside it."] = "从{area:186}沿道路向西北前往{area:264}；她受伤躺在路旁。",

	-- Step 31: Oracle Glade
	-- {object:6752} Strange Fronded Plant
	["The moonwell is in the middle of the glade. The {object:6752} grows at its north end."] = "月亮井在林地中央。{object:6752}长在林地北端。",
	-- {item:5623} Amethyst Phial
	["Use the {item:5623} at the moonwell"] = "在月亮井使用{item:5623}",
	-- {npc:3519} Sentinel Arynia Cloudsbreak
	["{npc:3519}, by the moonwell"] = "{npc:3519}，在月亮井旁",

	-- Step 32: Bloodfeather harpies
	["Bloodfeather harpies"] = "血羽鹰身人",
	["The Bloodfeather harpies nest on the slopes west and north of the glade."] = "血羽鹰身人在林地西边和北边的山坡上筑巢。",

	-- Step 33: Sentinel Arynia Cloudsbreak
	["Back to the moonwell."] = "回到月亮井。",

	-- Step 34: The named harpies
	["The named harpies"] = "有名字的鹰身人",
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress · {npc:272046} Witchmother Arysa
	["{npc:272034} and {npc:272044} fly just west of the moonwell, {npc:272046} further north."] = "{npc:272034}和{npc:272044}在月亮井西边不远处飞行，{npc:272046}在更北边。",

	-- Step 35: Sentinel Arynia again
	["Sentinel Arynia again"] = "再次找哨兵阿瑞尼亚",
	-- {object:673378} Oracle Tree Bark (no name in this language: may be words)
	["{object:673378}, just west of the moonwell"] = "{object:673378}，在月亮井西边不远处",

	-- Step 36: Ursal the Mauler
	-- {area:478} Pools of Arlithrien
	["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}."] = "沿岛屿西侧向南走。乌萨尔在最南端、{area:478}下方徘徊。",

	-- Step 37: Dolanaar
	-- {area:186} Dolanaar
	["North-east from Ursal's den, back to {area:186}."] = "从乌萨尔的巢穴向东北返回{area:186}。",
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

	-- Step 38: Lake Al'Ameth
	-- {npc:2080} Denalan
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-east of Dolanaar, to {npc:2080}. Lasher Sproutlings wander around him on the shore."] = "前往多兰纳尔东南方的{npc:2080}处。{npc:275703}在湖岸上围着他游荡。",
	-- {npc:2080} Denalan · {quest:922} Rellian Greenspyre · {zone:1457} Darnassus
	["{npc:2080}: {quest:922} in {zone:1457} takes it"] = "{npc:2080}：交给{zone:1457}的{quest:922}",
	-- {object:7510} Sprouted Frond
	["{object:7510}, beside him"] = "{object:7510}，在他旁边",

	-- Step 39: Dolanaar again
	-- {area:186} Dolanaar
	["{area:186} again"] = "再次回到{area:186}",

	-- Step 40: Taming the Beast
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

	-- Step 41: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {zone:1457} Darnassus
	["Take the road north-west from {area:186} again; she still lies beside it, on the way to {zone:1457}."] = "再次从{area:186}沿道路向西北走；她仍躺在路旁，在去{zone:1457}的路上。",

	-- Step 42: Darnassus
	-- {zone:1457} Darnassus · {npc:4241} Mydrannul · {area:1659} Craftsmen's Terrace · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:922} Rellian Greenspyre · {npc:4092} Lariia · {npc:7999} Tyrande Whisperwind · {npc:7316} Sister Aquinne
	["Follow the road west into {zone:1457}. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092} and {npc:7999} are in the Temple of the Moon at the south end. {npc:7316} is in the west of the city, on the way to the pink portal down to Rut'theran."] = "沿道路向西进入{zone:1457}。{npc:4241}站在一进城的{area:1659}上。{npc:3516}在城市北端的{area:1658}，{quest:922}就在其南边；{npc:4092}和{npc:7999}在南端的月神殿。{npc:7316}在城市西部，在通往鲁瑟兰村的粉色传送门的路上。",
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, in the {area:1658}"] = "{npc:3516}，在{area:1658}",
	-- {npc:4146} Jocaste · {area:1658} Cenarion Enclave · {spell:5149} Beast Training
	["{npc:4146}, in the {area:1658}: {spell:5149}"] = "{npc:4146}，在{area:1658}：{spell:5149}",
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217}, in the {area:1658}"] = "{npc:4217}，在{area:1658}",
	-- {npc:4092} Lariia
	["{npc:4092}, in the Temple of the Moon"] = "{npc:4092}，在月神殿",
	-- {npc:7999} Tyrande Whisperwind · {npc:4092} Lariia
	["{npc:7999}, above {npc:4092}"] = "{npc:7999}，在{npc:4092}上方",
	-- {npc:11401} Priestess Alathea
	["{npc:11401}, in the Temple of the Moon: Starshards"] = "{npc:11401}，在月神殿：星辰碎片",

	-- Step 43: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:10118} Nessa Shadowsong · {npc:3838} Vesprystus
	["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs."] = "乘传送门下到{area:702}。{npc:10118}站在码头上，{npc:3838}在角鹰兽旁边。",

	-- Step 45: Moonglade
	-- {area:442} Auberdine · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {area:493} Moonglade · {area:702} Rut'theran Village
	["Learn the {area:442} flight path on the hill south of the inn, then cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "在旅店南边的山丘上学习{area:442}的飞行路线，然后施放{spell:18960}。{npc:11802}在{area:2361}；{quest:5929}在西北方的树林里。在{area:2361}学习{area:493}的飞行路线，然后飞往{area:702}（途经{area:442}）。",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "与{quest:5929}交谈",

	-- Step 46: Back to Darnassus
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up from {area:702} to {npc:4217} in the {area:1658}."] = "从{area:702}乘传送门上到{area:1658}找{npc:4217}。",

	-- Step 47: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Go back down to {area:702} and fly to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "回到{area:702}，飞往{area:442}。{object:177525}立在村子东边的山丘上：在那里使用{item:15208}，击败月爪枭兽，然后与{npc:12144}交谈。",

	-- Step 48: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine
	["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442} for the boat."] = "再次飞往{area:702}，乘传送门上去找{npc:4217}，然后飞回{area:442}乘船。",

	-- Step 49: Auberdine
	-- {npc:4200} Laird · {zone:1453} Stormwind
	["{npc:4200}'s fish stall is by the docks. Then take the boat to {zone:1453}."] = "{npc:4200}的鱼摊在码头旁。然后乘船前往{zone:1453}。",
	-- {zone:1453} Stormwind
	["Boat to {zone:1453}"] = "乘船前往{zone:1453}",
	-- {area:17203} Stormwind Harbor · {zone:1429} Elwynn Forest · {zone:1436} Westfall
	["From {area:17203}, ride through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "从{area:17203}穿过城门进入{zone:1429}，沿道路向西前往{zone:1436}。",

	-- Step 50: Defensive Stance
	-- {object:2100} Old Town · {npc:5480} Ilsa Corbin · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["From the harbour walk into {object:2100}. {npc:5480} trains warriors there; {npc:6089} and {npc:6090} stand together by the {object:2152}. {npc:6090} fights you for his mug."] = "从港口步行进入{object:2100}。{npc:5480}在那里训练战士；{npc:6089}和{npc:6090}一起站在{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Defensive Stance"] = "防御姿态",
	-- ["Each of {npc:3601}'s quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "{npc:3601}的每个任务都会给你一根{item:15908}：对他指定的野兽使用，然后把棍子带回{area:186}交给他。树林潜伏者在村子周围爬行，夜刃捕食者和巨翼恶枭在村子南边的树林里游荡。",
	-- ["Follow the road south-west out of {area:188} to {area:186}."] = "沿道路向西南离开{area:188}前往{area:186}。",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers live along the road east. The moonwell is at the west edge of {area:260}."] = "夜刃豹、巨翼枭和树林潜伏者生活在向东的道路沿途。月亮井在{area:260}的西缘。",
	-- ["Tame Beast"] = "驯服野兽",
	-- ["The {area:264}"] = "{area:264}",
	-- ["{npc:11401}, in the Temple of the Moon: {spell:10797}"] = "{npc:11401}，在月神殿：{spell:10797}",
	-- ["{npc:2150} sits by the road just east of {area:186}, on the way to {area:260}."] = "{npc:2150}坐在{area:186}东边不远的路旁，在去{area:260}的路上。",
	-- ["{npc:3595}, inside the tree"] = "{npc:3595}，在巨树内",
	-- ["{npc:3595}, the priest trainer, inside the tree"] = "{npc:3595}，牧师训练师，在巨树内",
	-- ["{npc:4217}: Bear Form"] = "{npc:4217}：熊形态",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089}：防御姿态",
	-- ["{quest:97979}: cast {spell:1259799} and {spell:20580}, then hand it back to {npc:3595}"] = "{quest:97979}：施放{spell:1259799}和{spell:20580}，然后交还给{npc:3595}",
}
