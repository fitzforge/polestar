-- Chinese (traditional) (zhTW): the guide forever/alliance/nightelf/01-teldrassil (forever/alliance/nightelf/01-teldrassil.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aldrassil
	-- {area:256} Aldrassil · {area:188} Shadowglen
	["You start at the foot of {area:256}, the great tree of {area:188}."] = "你從{area:188}的巨樹{area:256}底下開始。",
	-- {npc:2077} Melithar Staghelm
	["{npc:2077}, by the path"] = "{npc:2077}，在小路旁",
	-- {npc:1992} Tarindrella
	["{npc:1992}, south of the tree"] = "{npc:1992}，在樹的南邊",

	-- Step 2: Shadowglen: kill these as you meet them
	-- {area:188} Shadowglen
	["{area:188}: kill these as you meet them"] = "{area:188}：遇到就殺",
	-- {area:256} Aldrassil
	-- plural, as words: Young Nightsabers = {npc:2031} Young Nightsaber · Young Thistle Boars = {npc:1984} Young Thistle Boar · Gnarlpine Totems = {item:279082} Gnarlpine Totem · Grells = {npc:1988} Grell
	["Young Nightsabers and Young Thistle Boars (level 1-2) roam around {area:256}: start with them. The Gnarlpine Totems stand in the woods west of the tree, where the Grells (2-3) roam: take them once the beasts are done."] = "小夜刃豹和小草刺野豬（1-2級）在{area:256}周圍遊蕩：先打牠們。瘤背圖騰矗立在樹西邊的樹林裡，小劣魔（2-3級）在那裡遊蕩：野獸打完後再去處理。",

	-- Step 3: The grells west of the tree
	["The grells west of the tree"] = "樹西邊的小劣魔",
	-- {item:3297} Fel Moss · {npc:1989} Grellkin
	-- plural, as words: Grells = {npc:1988} Grell
	["Grells (level 2-3) carry {item:3297} in the woods west of the tree, by the totems. The {npc:1989} further north are level 3-4: the Grells by the totems are enough."] = "小劣魔（2-3級）帶著{item:3297}，在樹西邊圖騰旁的樹林裡。更北邊的{npc:1989}是3-4級：圖騰旁的小劣魔就夠了。",

	-- Step 4: Back at Aldrassil
	-- {area:256} Aldrassil
	["Back at {area:256}"] = "回到{area:256}",
	-- {npc:2079} Conservator Ilthalaine · {npc:3596} Ayanna Everstride
	["{npc:2079}: a sigil for {npc:3596}"] = "{npc:2079}：給{npc:3596}的印記",
	-- {npc:2082} Gilshalan Windwalker
	["{npc:2082}, on the tree's ramp"] = "{npc:2082}，在樹的坡道上",
	-- {npc:3595} Shanda
	["{npc:3595}: in at the tree's front entrance and up the ramp; upstairs"] = "{npc:3595}：從樹的前門進入，沿坡道上行；樓上",
	-- {quest:97979} The Goddess Provides · {spell:1259799} Elune's Light · {npc:3595} Shanda
	["{quest:97979}: cast {spell:1259799} and Shadowmeld, then hand it back to {npc:3595}"] = "{quest:97979}：施放{spell:1259799}和影遁，然後交回給{npc:3595}",
	-- {npc:8583} Dirania Silvershine
	["{npc:8583}, east of the tree"] = "{npc:8583}，在樹的東邊",

	-- Step 5: North to Shadowthread Cave
	-- {area:257} Shadowthread Cave
	["North to {area:257}"] = "向北前往{area:257}",
	-- {area:256} Aldrassil · {npc:1994} Githyiss the Vile · {npc:8584} Iverron
	-- plural, as words: Mangy Nightsabers = {npc:2032} Mangy Nightsaber · Thistle Boars = {npc:1985} Thistle Boar
	["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:1994} sits deep inside. {npc:8584} waits in the trees west of the cave mouth."] = "癩皮夜刃豹和草刺野豬在{area:256}北邊、前往洞穴的路上遊蕩。{npc:1994}在洞穴深處。{npc:8584}在洞口西邊的樹林裡等候。",
	-- plural, as words: Webwood Spiders = {npc:1986} Webwood Spider
	["Webwood Spiders; below ground"] = "蛛網蜘蛛；地下",

	-- Step 6: Aldrassil
	-- {area:256} Aldrassil · {npc:3593} Alyissia · {npc:3594} Frahun Shadewhisper · {npc:3595} Shanda · {npc:3596} Ayanna Everstride · {npc:3597} Mardant Strongoak
	["The trainers stand upstairs inside {area:256}, along the ramp that winds up the tree: {npc:3593} and {npc:3594} on the first level, {npc:3595} above them, {npc:3596} and {npc:3597} at the top. The arrow cannot tell the levels apart."] = "訓練師們站在{area:256}內的樓上，沿繞著樹幹盤旋而上的坡道分佈：{npc:3593}和{npc:3594}在第一層，{npc:3595}在他們上方，{npc:3596}和{npc:3597}在頂層。箭頭分不清樓層。",
	-- {npc:3593} Alyissia
	["{npc:3593}, the warrior trainer; inside"] = "{npc:3593}，戰士訓練師；在裡面",
	-- {npc:3596} Ayanna Everstride
	["{npc:3596}, the hunter trainer"] = "{npc:3596}，獵人訓練師",
	-- {npc:3594} Frahun Shadewhisper
	["{npc:3594}, the rogue trainer"] = "{npc:3594}，盜賊訓練師",
	-- {npc:3595} Shanda
	["{npc:3595}, the priest trainer: in at the tree's front entrance and up the ramp"] = "{npc:3595}，牧師訓練師：從樹的正門進去，沿坡道往上",
	-- {npc:3597} Mardant Strongoak · {area:256} Aldrassil
	["{npc:3597}, the druid trainer at {area:256}"] = "{npc:3597}，{area:256}的德魯伊訓練師",

	-- Step 7: Webwood Egg and the antidote
	-- {quest:917} Webwood Egg
	["{quest:917} and the antidote"] = "{quest:917}與解毒劑",
	-- {object:4406} Webwood Eggs · {area:257} Shadowthread Cave · {area:256} Aldrassil
	-- plural, as words: Hyacinth Mushrooms = {item:10639} Hyacinth Mushroom · Grells = {npc:1988} Grell
	["The {object:4406} lie at the back of {area:257}: take the central path, then left where it splits, up to the high ledge. Hyacinth Mushrooms drop from Grells, Moonpetal Lilies grow by the ponds north of {area:256}."] = "{object:4406}在{area:257}深處：走中間的路，分岔處往左，一路上到高處的岩架。紫藍色蘑菇由小劣魔掉落，月牙百合花生長在{area:256}北邊的池塘旁。",
	-- plural, as words: Grells = {npc:1988} Grell
	["Grells"] = "小劣魔",

	-- Step 9: Shadowglen
	["Below ground"] = "地下",
	-- {quest:97236} Fang of Githyiss
	["{quest:97236}; below ground"] = "{quest:97236}；地下",

	-- Step 10: Aldrassil
	-- {npc:3514} Tenaron Stormgrip
	["{npc:3514}, at the top of the tree"] = "{npc:3514}，在樹頂",

	-- Step 11: The moonwell
	["The moonwell"] = "月井",
	-- {area:256} Aldrassil
	["The moonwell sits north of {area:256}."] = "月亮井位於{area:256}以北。",
	-- {item:5185} Crystal Phial
	["Use the {item:5185} at the moonwell"] = "在月井使用{item:5185}",

	-- Step 12: Tenaron Stormgrip
	-- {area:256} Aldrassil · {object:654846} Lost Journal (no name in this language: may be words)
	["Back to the top of {area:256}. The {object:654846} lies beside him."] = "回到{area:256}頂端。{object:654846}就在他旁邊。",
	["Upstairs"] = "樓上",
	-- {object:654846} Lost Journal (no name in this language: may be words)
	["{object:654846}, upstairs"] = "{object:654846}，樓上",
	-- {npc:3595} Shanda · {area:256} Aldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar
	["{npc:3595}, the priest trainer, on the second level of {area:256} on the way down: {npc:3600} in {area:186} takes it"] = "{npc:3595}，牧師訓練師，在下樓途中{area:256}的第二層：由{area:186}的{npc:3600}接收",

	-- Step 13: Iverron's Antidote
	-- {npc:8583} Dirania Silvershine · {area:256} Aldrassil · {npc:8584} Iverron
	["Take the antidote from {npc:8583} at the foot of {area:256} only now, on the way down: it lasts five minutes. {npc:8584} waits north-west, by the cave: go straight on to him."] = "現在才在下來時到{area:256}腳下找{npc:8583}拿解藥：它只能維持五分鐘。{npc:8584}在西北邊的洞穴旁等著：直接去找他。",

	-- Step 14: Porthannius
	-- {area:188} Shadowglen · {area:256} Aldrassil · {npc:6780} Porthannius · {area:186} Dolanaar
	["Leave {area:188} by the path south-east of {area:256}: {npc:6780} stands beside it, where it goes down towards the road to {area:186}."] = "從{area:256}東南方的小路離開{area:188}：{npc:6780}站在路旁，就在小路往下通往{area:186}道路的地方。",

	-- Step 15: Zenn Foulhoof
	-- {area:188} Shadowglen · {npc:2150} Zenn Foulhoof · {area:186} Dolanaar
	["Follow the road south-west out of {area:188}. {npc:2150} sits beside it just east of {area:186}."] = "沿著道路向西南離開{area:188}。{npc:2150}就坐在路旁，在{area:186}東邊不遠處。",

	-- Step 16: Dolanaar
	-- {npc:265811} Lyreena Duskblade
	["{npc:265811}, by the campfire"] = "{npc:265811}，在營火旁",

	-- Step 17: The Great Outdoors
	-- {npc:265811} Lyreena Duskblade · {npc:6286} Zarrin · {skill:129} First Aid · {npc:6094} Byancie
	["With a profession learned, {npc:265811} also offers its Camping 101, which its trainer takes: alchemy and herbalism beside {npc:6286}, {skill:129} with {npc:6094} in the inn, skinning and leatherworking at the Maneweavers' camp on the road west."] = "學會一項專業技能後，{npc:265811}還會提供該專業的露營入門，由該專業的訓練師接收：煉金術和草藥學在{npc:6286}旁邊，{skill:129}找旅店裡的{npc:6094}，剝皮和製皮在往西道路上的鬃紡家族營地。",
	-- {npc:265811} Lyreena Duskblade · {spell:1229451} Boosted Rest
	["/sit by {npc:265811}'s campfire until you get {spell:1229451}"] = "在{npc:265811}的營火旁/sit，直到獲得{spell:1229451}",

	-- Step 18: Camping 101: Alchemy
	-- {npc:3603} Cyndra Kindwhisper · {skill:171} Alchemy
	["{npc:3603} takes it once your {skill:171} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "你的{skill:171}技能達到20後，{npc:3603}就會接收它：在那之前先採集或製作，指南會同時繼續進行。",
	-- {npc:265811} Lyreena Duskblade · {npc:3603} Cyndra Kindwhisper · {npc:6286} Zarrin
	["{npc:265811}: for {npc:3603}, beside {npc:6286}"] = "{npc:265811}：交給{npc:3603}，在{npc:6286}旁邊",

	-- Step 19: Camping 101: Herbalism
	-- {npc:3604} Malorne Bladeleaf · {skill:182} Herbalism
	["{npc:3604} takes it once your {skill:182} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "你的{skill:182}技能達到20後，{npc:3604}就會接收它：在那之前先採集或製作，指南會同時繼續進行。",
	-- {npc:265811} Lyreena Duskblade · {npc:3604} Malorne Bladeleaf · {npc:6286} Zarrin
	["{npc:265811}: for {npc:3604}, beside {npc:6286}"] = "{npc:265811}：交給{npc:3604}，在{npc:6286}旁邊",

	-- Step 20: Camping 101: First Aid
	-- {npc:6094} Byancie · {skill:129} First Aid
	["{npc:6094} takes it once your {skill:129} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "你的{skill:129}技能達到20後，{npc:6094}就會接收它：在那之前先採集或製作，指南會同時繼續進行。",
	-- {npc:265811} Lyreena Duskblade · {npc:6094} Byancie
	["{npc:265811}: for {npc:6094} in the inn"] = "{npc:265811}：交給旅店裡的{npc:6094}",

	-- Step 21: Camping 101: Skinning
	-- {npc:6287} Radnaal Maneweaver · {skill:393} Skinning
	["{npc:6287} takes it once your {skill:393} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "你的{skill:393}技能達到20後，{npc:6287}就會接收它：在那之前先採集或製作，指南會同時繼續進行。",
	-- {npc:265811} Lyreena Duskblade · {npc:6287} Radnaal Maneweaver
	["{npc:265811}: for {npc:6287}, by the road west"] = "{npc:265811}：交給{npc:6287}，在往西的路旁",

	-- Step 22: Camping 101: Leatherworking
	-- {npc:3605} Nadyia Maneweaver · {skill:165} Leatherworking
	["{npc:3605} takes it once your {skill:165} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "你的{skill:165}技能達到20後，{npc:3605}就會接收它：在那之前先採集或製作，指南會同時繼續進行。",
	-- {npc:265811} Lyreena Duskblade · {npc:3605} Nadyia Maneweaver
	["{npc:265811}: for {npc:3605}, by the road west"] = "{npc:265811}：交給{npc:3605}，在往西的路旁",

	-- Step 23: Zarrin
	-- {npc:6286} Zarrin
	["{npc:6286}, south of the inn: Camping 101 asks you to learn it"] = "",

	-- Step 24: Cyndra Kindwhisper
	["talk to the trainer"] = "與訓練師交談",
	-- {npc:3603} Cyndra Kindwhisper · {npc:6286} Zarrin
	["{npc:3603}, beside {npc:6286}"] = "{npc:3603}，在{npc:6286}旁邊",

	-- Step 25: Malorne Bladeleaf
	-- {npc:3604} Malorne Bladeleaf · {npc:6286} Zarrin
	["{npc:3604}, beside {npc:6286}"] = "{npc:3604}，在{npc:6286}旁邊",

	-- Step 26: Byancie
	-- {npc:6094} Byancie
	["{npc:6094}, in the inn"] = "{npc:6094}，在旅店裡",

	-- Step 27: Dolanaar
	-- {npc:3515} Corithras Moonrage
	["{npc:3515}, south of the inn"] = "{npc:3515}，在旅店南邊",
	-- {npc:3608} Aldia
	["{npc:3608}, upstairs"] = "{npc:3608}，樓上",
	-- {npc:3567} Tallonkai Swiftroot
	["{npc:3567}, upstairs"] = "{npc:3567}，樓上",
	-- {npc:3600} Laurna Morninglight
	["{npc:3600}, inside"] = "{npc:3600}，室內",
	-- {npc:3600} Laurna Morninglight · {npc:12429} Sentinel Shaya · {area:259} Lake Al'Ameth
	["{npc:3600}: heal {npc:12429} by {area:259}"] = "{npc:3600}：在{area:259}旁治療{npc:12429}",

	-- Step 28: Dolanaar
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151}在村莊西邊的道路上巡邏：如果她不在箭頭處，沿著道路走直到遇見她。",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151}, on the road west of the village"] = "{npc:2151}，在村莊西邊的路上",

	-- Step 29: Teldrassil: kill these as you meet them
	-- {quest:940} Teldrassil
	["{quest:940}: kill these as you meet them"] = "{quest:940}：遇到就殺",
	-- {area:186} Dolanaar · {area:260} Starbreeze Village · {npc:3567} Tallonkai Swiftroot
	-- plural, as words: Strigid Owls = {npc:1995} Strigid Owl · Webwood Lurkers = {npc:1998} Webwood Lurker · Befouled Webwoods = {npc:272096} Befouled Webwood
	["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east; the lurkers also drop the recipe's spider legs. The moonwell is at the west edge of {area:260}.\nCareful: the Befouled Webwoods (10-11) in the woods north-west of {area:186}, around 47-52,34-56, are over you now: take the silk from the Webwood Lurkers and leave the webwoods for {npc:3567}'s quest later. Duskstalker (9, a rare nightsaber) and Oakenscowl (9, elite) roam the woods south of {area:186}, around 54-62,73-77: leave them be."] = "",
	["Nightsabers"] = "夜刃豹",
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers"] = "樹林潛伏者",

	-- Step 30: Zenn Foulhoof
	-- {npc:2150} Zenn Foulhoof · {area:186} Dolanaar · {area:260} Starbreeze Village
	["{npc:2150} sits by the road just east of {area:186}, between {area:186} and {area:260}."] = "{npc:2150}坐在{area:186}東邊的路旁，在{area:186}和{area:260}之間。",

	-- Step 31: Starbreeze Village
	-- {npc:2107} Gaerolas Talvethren · {object:126158} Tallonkai's Dresser
	["{npc:2107} stands upstairs in a house in the village, east of the moonwell: go up inside, the arrow cannot tell the floors apart. {object:126158} is in the house on the hill at the east end of the village."] = "{npc:2107}在村裡月亮井東邊一座房子的樓上：從裡面上樓，箭頭無法區分樓層。{object:126158}在村子東端山丘上的房子裡。",
	-- {item:5619} Jade Phial
	["Use the {item:5619} at the moonwell"] = "在月井使用{item:5619}",
	-- {object:126158} Tallonkai's Dresser
	["{object:126158}; inside"] = "{object:126158}；室內",

	-- Step 32: Lake Al'Ameth
	-- {npc:2150} Zenn Foulhoof · {npc:2080} Denalan · {quest:919} Timberling Sprouts
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-west of Starbreeze, south of {npc:2150}. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "在星風村西南方，{npc:2150}南邊。{npc:2080}在岸邊照料他的樹苗；鞭笞者幼苗和林精在他周圍遊蕩，{quest:919}就生長在牠們之間。",
	-- {npc:2080} Denalan · {quest:922} Rellian Greenspyre · {zone:1457} Darnassus
	["{npc:2080}: {quest:922} in {zone:1457} takes it"] = "{npc:2080}：由{zone:1457}的{quest:922}接收",

	-- Step 33: Sentinel Shaya
	-- {npc:12429} Sentinel Shaya · {area:259} Lake Al'Ameth · {area:186} Dolanaar · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12429} kneels wounded on the rocks at the north edge of {area:259}, on the walk back to {area:186}, with no quest mark over her. Cast {spell:613} (Rank 2) on her, then {spell:1243}: Rank 1 of {spell:613} does not count. She runs off once both land and is back in about 5 minutes."] = "{npc:12429}受傷跪在{area:259}北緣的岩石上，就在走回{area:186}的路上，她頭上沒有任務標記。對她施放{spell:613}（等級2），然後施放{spell:1243}：等級1的{spell:613}不算數。兩個法術都生效後她就會跑開，約5分鐘後回來。",
	-- {npc:12429} Sentinel Shaya
	["Heal and fortify {npc:12429}"] = "治療{npc:12429}並施放耐力",

	-- Step 35: Fel Rock's mouth
	-- {area:258} Fel Rock
	["{area:258}'s mouth"] = "{area:258}入口",

	-- Step 36: Fel Rock
	-- {npc:2038} Lord Melenas
	["{npc:2038} waits inside the cave, at the bottom or up on the ledge; keep to the right."] = "{npc:2038}在洞穴裡等候，在底部或上方的岩架上；靠右走。",
	-- {npc:2038} Lord Melenas
	["{npc:2038}; below ground"] = "{npc:2038}；地下",

	-- Step 37: The road to Darnassus
	-- {zone:1457} Darnassus
	["The road to {zone:1457}"] = "前往{zone:1457}的道路",
	-- {area:258} Fel Rock
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["Gnarlpine Ambushers hide along the road west of {area:258}."] = "瘤背伏擊者埋伏在{area:258}西邊的道路沿線。",

	-- Step 38: Radnaal Maneweaver
	-- {npc:6287} Radnaal Maneweaver
	["{npc:6287}, camped beside the road before Shayla"] = "{npc:6287}，在夏伊拉之前的路旁紮營",

	-- Step 39: Nadyia Maneweaver
	-- {npc:3605} Nadyia Maneweaver · {npc:6287} Radnaal Maneweaver
	["{npc:3605}, beside {npc:6287}"] = "{npc:3605}，在{npc:6287}旁邊",

	-- Step 40: Sentinel Shayla Nightbreeze
	-- {area:261} Gnarlpine Hold
	["West along the road toward the city. Shayla walks this stretch of road, from the arrow south-west to the bend at about 38,54 and back: if she isn't at the arrow, follow the road south-west. Every Gnarlpine furbolg drops fangs: the ambushers on this road, the barrow's and {area:261}'s all count."] = "沿著道路向西朝城市前進。夏伊拉在這段路上來回巡邏，從箭頭處往西南走到約38,54的彎道再折返：如果她不在箭頭處，沿著道路往西南走。每個瘤背熊怪都會掉落牙齒：這條路上的伏擊者、古墓裡的以及{area:261}的都算數。",

	-- Step 41: Darnassus
	-- {quest:922} Rellian Greenspyre · {area:1658} Cenarion Enclave · {npc:7316} Sister Aquinne · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade · {item:279378} Lunar Pendant
	["Into the city through the gate. {quest:922} is just south of the {area:1658} at the north end, {npc:7316} in the west, {npc:7313} and {npc:8396} in the Temple of the Moon at the south end. On the way back out, use Dalia's {item:279378} at the bank and at the city gate; the other two owls wait for your last visit."] = "穿過大門進城。{quest:922}就在北端{area:1658}的南邊，{npc:7316}在西部，{npc:7313}和{npc:8396}在南端的月神殿。往回走的時候，在銀行和城門使用達莉婭的{item:279378}；另外兩隻貓頭鷹留到你最後一次來時再找。",
	-- {npc:7313} Priestess A'moora
	["{npc:7313}, in the Temple of the Moon"] = "{npc:7313}，在月神殿",
	-- {npc:8396} Sentinel Dalia Sunblade
	["{npc:8396}, beside her"] = "{npc:8396}，在她旁邊",
	-- {item:279378} Lunar Pendant
	["{item:279378}: the bank, on the way out"] = "{item:279378}：銀行，出去時順路",
	["the city gate"] = "城門",

	-- Step 42: Ban'ethil Barrow Den's entrance
	-- {area:262} Ban'ethil Barrow Den
	["{area:262}'s entrance"] = "{area:262}的入口",

	-- Step 43: Ban'ethil Barrow Den
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:7317} Oben Rageclaw
	-- plural, as words: Gnarlpine Defenders = {npc:2010} Gnarlpine Defender
	["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms. Its furbolgs drop Shayla's fangs.\nCareful: the barrow's Gnarlpine Defenders, Augurs and Shamans (7-9) stand in threes in the narrow tunnels: pull each group back toward the entrance before you go deeper."] = "古墓在道路南邊。{npc:275744}被關在裡面，{npc:7317}在深處沉睡，四個聖物箱在下層的房間裡。裡面的熊怪會掉落夏伊拉要的牙。\n小心：古墓裡的瘤背防禦者、預言者和薩滿（7-9級）三個一組站在狹窄的隧道裡：深入之前，先把每一組拉回入口方向。",
	-- {item:5220} Gnarlpine Fang
	["{item:5220}: any Gnarlpine furbolg"] = "{item:5220}：任意一隻瘤背熊怪",
	-- {npc:7317} Oben Rageclaw
	["{npc:7317}, below ground"] = "{npc:7317}，地下",
	-- plural, as words: Gnarlpine Shamans = {npc:2009} Gnarlpine Shaman
	["Gnarlpine Shamans"] = "瘤背薩滿",

	-- Step 44: Rageclaw
	-- {npc:7318} Rageclaw · {npc:7317} Oben Rageclaw · {area:736} Ban'ethil Hollow · {item:8149} Voodoo Charm
	["{npc:7318} (level 10), {npc:7317}'s soulless body, walks around {area:736} in the den: kill him, then use {npc:7317}'s {item:8149}."] = "{npc:7318}（10級）是{npc:7317}失去靈魂的軀體，在巢穴裡的{area:736}四處走動：殺掉他，然後使用{npc:7317}的{item:8149}。",
	-- {npc:7318} Rageclaw · {area:736} Ban'ethil Hollow
	["{npc:7318}, in the den; walks around {area:736}: look inside the circle on the map"] = "{npc:7318}，在洞穴裡；在{area:736}一帶走動：看地圖上的圓圈內",

	-- Step 45: Escaping Ban'ethil
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:2081} Sentinel Kyra Starsong · {area:186} Dolanaar
	["Escort {npc:275744} out of the barrow; {npc:2081} in {area:186} takes the report."] = "護送{npc:275744}離開古墓；由{area:186}的{npc:2081}接收報告。",
	["Walk Lynessa out and keep her alive"] = "護送哨兵離開，並保住她的性命",
	-- {area:736} Ban'ethil Hollow
	["{area:736}, outside the barrow"] = "{area:736}，在古墓外",

	-- Step 46: The Pools of Arlithrien
	-- {area:478} Pools of Arlithrien
	["The {area:478}"] = "{area:478}",
	["South-west of the barrow. The moonwell sits by the pools."] = "在古墓西南方。月井就在池塘旁。",
	-- {item:5621} Tourmaline Phial
	["Use the {item:5621} at the moonwell"] = "在月井使用{item:5621}",

	-- Step 47: Gnarlpine Hold
	-- {object:6751} Strange Fruited Plant
	-- plural, as words: Gnarlpine Avengers = {npc:2013} Gnarlpine Avenger
	["South of the pools. The {object:6751} grows by the Hold; the furbolgs around it drop the rest of the fangs.\nCareful: the Gnarlpine Avengers (9-10) and Augurs here stand close together and many players died at the Hold: pull them one at a time."] = "在池塘南邊。{object:6751}生長在脊骨堡旁；周圍的熊怪會掉落其餘的牙。\n小心：這裡的瘤背復仇者（9-10級）和先知站得很近，很多玩家都死在脊骨堡：一次拉一隻。",

	-- Step 49: Seek Redemption!
	-- {area:186} Dolanaar · {npc:2150} Zenn Foulhoof · {npc:7234} Ferocitas the Dream Eater
	-- plural, as words: Fel Cones = {object:1673} Fel Cone
	["Fel Cones lie under the trees all around {area:186} and {npc:2150}: pick them up on the road east and hand them to {npc:2150} on the way to {npc:7234}."] = "魔錐果散落在{area:186}和{npc:2150}周圍的樹下：在往東的路上撿起來，並在前往{npc:7234}的路上交給{npc:2150}。",

	-- Step 50: Ferocitas the Dream Eater
	-- {npc:7234} Ferocitas the Dream Eater · {area:260} Starbreeze Village · {item:8049} Gnarlpine Necklace
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["Gnarlpine Mystics and {npc:7234} camp north-east of {area:260}. {npc:7234} drops the {item:8049}: open it for the jewel.\nCareful: {npc:7234} waits near the camp fire with mystics around him, so pulling him without adds is hard."] = "瘤背秘法師和{npc:7234}在{area:260}東北方紮營。{npc:7234}會掉落{item:8049}：打開它取得寶石。\n小心：{npc:7234}在營火旁等著，周圍有秘法師，很難單獨把他拉出來。",
	-- {item:8049} Gnarlpine Necklace · {npc:7234} Ferocitas the Dream Eater
	["{item:8049}, from {npc:7234}"] = "{item:8049}，來自{npc:7234}",

	-- Step 51: Dolanaar
	-- {area:264} Oracle Glade · {area:186} Dolanaar · {npc:3567} Tallonkai Swiftroot
	["The road west to the {area:264} runs through {area:186}: hand {npc:3567} the jewel on the way."] = "往西去{area:264}的路穿過{area:186}：順路把寶石交給{npc:3567}。",

	-- Step 52: Tallonkai Swiftroot
	-- {npc:3567} Tallonkai Swiftroot · {quest:932} Twisted Hatred · {npc:272116} Xethorr the Wicked · {area:264} Oracle Glade
	-- plural, as words: Befouled Webwoods = {npc:272096} Befouled Webwood
	["{npc:3567}: {quest:932}'s Befouled Webwoods and the elite {npc:272116}'s moss, on the walk to the {area:264}"] = "{npc:3567}：{quest:932}的被污染的樹林蜘蛛，以及精英怪{npc:272116}的苔蘚，在前往{area:264}的路上完成",

	-- Step 53: Befouled Webwoods
	-- plural, as words: Befouled Webwoods = {npc:272096} Befouled Webwood
	["Befouled Webwoods"] = "被污染的樹林蜘蛛",
	-- {area:264} Oracle Glade · {npc:272116} Xethorr the Wicked · {item:281023} Mature Fel Moss
	-- plural, as words: Befouled Webwoods = {npc:272096} Befouled Webwood
	["North-west of Dolanaar, on the way to the {area:264}, Befouled Webwoods creep through the woods; {npc:272116} prowls at their east edge and carries the {item:281023}.\n{npc:272116} is elite (level 12): grouping up is advised. Clear the webwoods around him first and pull him on his own."] = "在多蘭納爾西北方、前往{area:264}的路上，被污染的樹林蜘蛛在樹林裡爬行；{npc:272116}在牠們的東緣徘徊，身上帶著{item:281023}。\n{npc:272116}是精英怪（12級）：建議組隊。先清掉他周圍的蜘蛛，再單獨把他拉出來。",

	-- Step 54: The Wellspring River
	-- {area:265} Wellspring River
	["The {area:265}"] = "{area:265}",
	-- {area:265} Wellspring River · {npc:272116} Xethorr the Wicked · {area:186} Dolanaar
	-- plural, as words: Mossy Tumors = {item:5170} Mossy Tumor · Befouled Webwoods = {npc:272096} Befouled Webwood
	["West from the webwoods to the {area:265}, then north along it to the glade: the timberlings along its banks drop the Mossy Tumors.\nCareful: {npc:272116}, a level 12 elite, prowls the east edge of the Befouled Webwoods north-west of {area:186}: if you are alone, keep clear of the webwoods and go round him."] = "從蜘蛛所在的樹林往西到{area:265}，再沿著河往北到林地：河岸邊的樹人會掉落青苔之瘤。\n小心：12級精英{npc:272116}在{area:186}西北方被污染的樹林蜘蛛的東緣徘徊：如果你是單人，就遠離那些蜘蛛，繞過他。",
	-- {item:5170} Mossy Tumor
	["{item:5170}: timberlings"] = "{item:5170}：樹精",

	-- Step 55: Oracle Glade
	-- {object:6752} Strange Fronded Plant
	["The moonwell is in the middle of the glade. The {object:6752} grows at its north end."] = "月井在林地中央。{object:6752}生長在林地北端。",
	-- {npc:3519} Sentinel Arynia Cloudsbreak
	["{npc:3519}, by the moonwell"] = "{npc:3519}，在月井旁",
	-- {item:18152} Amethyst Phial
	["Use the {item:18152} at the moonwell"] = "在月井使用{item:18152}",

	-- Step 56: Bloodfeather harpies
	["Bloodfeather harpies"] = "血羽鷹身人",
	-- {quest:938} Mist
	["The Bloodfeather harpies nest on the slopes west and north of the glade. {quest:938}, an injured sabercat, lies by the glade's west wall among them: lead her back to Sentinel Arynia at the moonwell before her time runs out.\nCareful: The harpies stand packed together, so extra ones often join a fight. Casters are mixed in among them."] = "血羽鷹身人在林間空地以西和以北的山坡築巢。{quest:938}是一隻受傷的刃豹，躺在它們中間、林間空地的西牆旁：趕在時間耗盡前把她帶回月井旁的哨兵艾瑞尼婭那裡。\n注意：鷹身人站得很密集，所以常會有額外的加入戰鬥。施法者混在它們中間。",
	-- {quest:938} Mist
	["{quest:938}, by the west wall"] = "{quest:938}，在西牆旁",
	-- {quest:938} Mist
	["Lead {quest:938} to the moonwell"] = "把{quest:938}引到月井",

	-- Step 57: Sentinel Arynia Cloudsbreak
	["Back to the moonwell."] = "回到月井。",

	-- Step 58: Hatescreech and Windmistress Gaedress
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress
	["{npc:272034} and {npc:272044}"] = "{npc:272034}和{npc:272044}",
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress · {npc:272046} Witchmother Arysa · {npc:7319} Lady Sathrah
	["{npc:272034} and {npc:272044} (level 10) fly just west of the moonwell. {npc:272046} (12) waits further north for the walk back from {npc:7319}."] = "{npc:272034}和{npc:272044}（10級）在月井西邊飛行。{npc:272046}（12級）在更北邊，留到從{npc:7319}那裡回來的路上再打。",

	-- Step 59: Lady Sathrah
	-- {object:6752} Strange Fronded Plant · {area:266} Wellspring Lake · {npc:7319} Lady Sathrah
	["The {object:6752} grows at the glade's north end, on the way: then north along the island's northern edge by {area:266}, {npc:7319}, a level 12 spider, lurks."] = "{object:6752}生長在林地北端，順路採：然後沿著島的北緣往北到{area:266}旁，12級蜘蛛{npc:7319}潛伏在那裡。",

	-- Step 60: Witchmother Arysa
	-- {npc:272046} Witchmother Arysa
	-- plural, as words: Bloodfeather Matriarchs = {npc:2021} Bloodfeather Matriarch
	["On the way back south to the glade: {npc:272046} (level 12) flies on the slopes north-west of the moonwell, among Bloodfeather Matriarchs (11). Pull the harpies around her first."] = "往南回林地的路上：{npc:272046}（12級）在月井西北方的山坡上飛行，周圍有血羽女王（11級）。先把她周圍的鳥身女妖拉掉。",

	-- Step 61: Sentinel Arynia again
	["Sentinel Arynia again"] = "再次找哨兵阿瑞尼亞",
	-- {object:673378} Oracle Tree Bark (no name in this language: may be words)
	["{object:673378}, just west of the moonwell"] = "{object:673378}，就在月井西邊",
	-- {object:673378} Oracle Tree Bark (no name in this language: may be words) · {zone:1457} Darnassus
	["the same {object:673378}: Fandral in {zone:1457} takes it"] = "同一個{object:673378}：{zone:1457}的範達爾會收下它",

	-- Step 62: Sentinel Shayla Nightbreeze
	-- {area:186} Dolanaar
	["South from the glade to the road: Shayla walks the road west of {area:186}, from where the path down from the glade meets it south-west to the bend at about 38,54 and back."] = "從林地向南走到道路：夏伊拉在{area:186}西邊的道路上來回巡邏，從林地下來的小路與道路交會處往西南走到約38,54的彎道再折返。",

	-- Step 63: Dolanaar
	-- {area:186} Dolanaar
	["East along the road to {area:186}."] = "沿著道路向東前往{area:186}。",
	-- {npc:6094} Byancie
	["{npc:6094}, inside"] = "{npc:6094}，室內",
	-- {item:3371} Empty Vial · {npc:3614} Narret Shadowgrove · {npc:6094} Byancie
	["{item:3371} from {npc:3614}, beside {npc:6094}"] = "向{npc:6094}旁邊的{npc:3614}購買{item:3371}",
	-- {npc:3600} Laurna Morninglight · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:3600}: {npc:11401} in {zone:1457} takes it"] = "{npc:3600}：由{zone:1457}的{npc:11401}接收",
	-- {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr · {npc:6094} Byancie
	["{item:159} from {npc:6736}, for {npc:6094}"] = "向{npc:6736}購買{item:159}，給{npc:6094}",
	-- {zone:1457} Darnassus
	["Fandral in {zone:1457} takes it"] = "由{zone:1457}的范達爾接收",
	-- {npc:3602} Kal · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:3602}: {npc:4217} in {zone:1457} takes it"] = "{npc:3602}：由{zone:1457}的{npc:4217}接收",
	-- {npc:3598} Kyra Windblade · {quest:1684} Elanaria · {zone:1457} Darnassus
	["{npc:3598}, the warrior trainer: {quest:1684} in {zone:1457} takes it"] = "{npc:3598}，戰士訓練師：{zone:1457}的{quest:1684}會收下它",

	-- Step 64: Tallonkai Swiftroot
	-- {npc:3567} Tallonkai Swiftroot · {npc:272116} Xethorr the Wicked
	["Back upstairs to {npc:3567} with the webwoods done and {npc:272116}'s moss."] = "完成蜘蛛任務並帶著{npc:272116}的苔蘚，回到樓上找{npc:3567}。",

	-- Step 65: Lake Al'Ameth
	-- {npc:2080} Denalan
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-east of Dolanaar, to {npc:2080}. Lasher Sproutlings wander around him on the shore."] = "從多蘭納爾向東南前往{npc:2080}那裡。鞭笞者幼苗在岸邊他的周圍遊蕩。",

	-- Step 66: Ursal the Mauler
	-- {area:259} Lake Al'Ameth · {area:478} Pools of Arlithrien
	["South-west from {area:259}, past the {area:478}: Ursal prowls the far south of the island.\nCareful: Gnarlpine of roughly level 9-11 crowd the camp and sit close together, so it is easy to pull several at once. Take them on singly before you engage Ursal."] = "從{area:259}往西南走，經過{area:478}：烏薩爾在島的最南端徘徊。\n小心：營地裡擠滿了約9-11級的瘤背熊怪，而且站得很近，很容易一次引來好幾隻。先逐一解決牠們，再去打烏薩爾。",

	-- Step 67: Dolanaar again
	-- {area:186} Dolanaar
	["{area:186} again"] = "再次回到{area:186}",
	-- {area:186} Dolanaar · {npc:6094} Byancie · {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr
	["North-east from Ursal's den, back to {area:186}. {npc:6094} takes a {item:159} with the fronds and the vial: if you drank yours, buy another from {npc:6736} in this inn before you hand in."] = "從烏薩爾的巢穴往東北回到{area:186}。{npc:6094}要收一瓶{item:159}，連同葉子和小瓶：如果你把自己的喝掉了，繳交前先在這間旅店向{npc:6736}再買一瓶。",

	-- Step 68: Taming the Beast
	-- {item:15908} Taming Rod · {area:186} Dolanaar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker · Nightsaber Stalkers = {npc:2043} Nightsaber Stalker · Strigid Screechers = {npc:1996} Strigid Screecher
	["Each of Dazalar's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "達札拉的每個任務都會給你一根{item:15908}：對他指定的野獸使用，然後把馴獸棒帶回{area:186}給他。樹林潛伏者在村莊周圍潛行，夜刃捕食者和巨翼惡梟在村莊南邊的樹林遊蕩。",
	-- {npc:1998} Webwood Lurker · {item:15908} Taming Rod
	["{npc:1998}: tame it with the {item:15908}"] = "{npc:1998}：用{item:15908}馴服牠",
	-- {npc:2043} Nightsaber Stalker · {item:15908} Taming Rod
	["{npc:2043}: tame it with the {item:15908}"] = "{npc:2043}：用{item:15908}馴服牠",
	-- {npc:1996} Strigid Screecher · {item:15908} Taming Rod
	["{npc:1996}: tame it with the {item:15908}"] = "{npc:1996}：用{item:15908}馴服牠",
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457} takes it"] = "由{zone:1457}的{npc:4146}接收",

	-- Step 69: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {zone:1457} Darnassus
	["Take the road north-west from {area:186} again; she still lies beside it, on the way to {zone:1457}."] = "再次沿著道路從{area:186}向西北走；她仍躺在路旁，在前往{zone:1457}的路上。",

	-- Step 70: Into Darnassus
	-- {area:1657} Darnassus
	-- was: ["Into {zone:1457}"] = "進入{zone:1457}"
	["Into {area:1657}"] = "",
	-- {npc:4241} Mydrannul · {area:1659} Craftsmen's Terrace
	["{npc:4241}, on the {area:1659} just inside the city"] = "{npc:4241}，在剛進城處的{area:1659}上",

	-- Step 72: Elanaria
	-- {quest:1684} Elanaria · {area:1660} Warrior's Terrace
	["{quest:1684} stands on the {area:1660}, just inside the city."] = "{quest:1684}站在{area:1660}上，就在城內。",

	-- Step 73: Vorlus Vilehoof
	-- {quest:1683} Vorlus Vilehoof · {area:736} Ban'ethil Hollow · {quest:1684} Elanaria
	["Back out of the city gate and east along the road: {quest:1683} stands south of it, by {area:736}. Bring his horn back to {quest:1684}."] = "出城門後沿路向東：{quest:1683}站在路南、{area:736}旁。把他的號角帶回去交給{quest:1684}。",
	-- {area:736} Ban'ethil Hollow
	["East from the city gate to {area:736}"] = "",

	-- Step 75: Darnassus
	-- {area:1657} Darnassus · {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace · {area:3425} Cenarion Hold · {npc:4241} Mydrannul · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:922} Rellian Greenspyre · {npc:4092} Lariia · {npc:7999} Tyrande Whisperwind · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade
	-- was: ["Follow the road west into {zone:1457} and use the {item:279378} at the inn on the {area:1659} and at the tunnel mouth below {area:3425} for the last two owls. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092}, {npc:7999}, {npc:7313} and {npc:8396} are in the Temple of the Moon at the south end."] = "沿著道路向西進入{zone:1457}，在{area:1659}的旅店和{area:3425}下方的隧道口使用{item:279378}，完成最後兩隻貓頭鷹。{npc:4241}站在一進城的{area:1659}上。{npc:3516}在城市北端的{area:1658}，{quest:922}就在其南邊；{npc:4092}、{npc:7999}、{npc:7313}和{npc:8396}在城市南端的月神殿裡。"
	["Follow the road west into {area:1657} and use the {item:279378} at the inn on the {area:1659} and at the tunnel mouth below {area:3425} for the last two owls. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092}, {npc:7999}, {npc:7313} and {npc:8396} are in the Temple of the Moon at the south end."] = "",
	-- {npc:4088} Elanaria · {area:1660} Warrior's Terrace · {spell:71} Defensive Stance
	["{npc:4088}, on the {area:1660}: {spell:71}"] = "{npc:4088}，在{area:1660}上：{spell:71}",
	-- {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace
	["{item:279378}: the inn on the {area:1659}"] = "{item:279378}：{area:1659}上的旅店",

	-- Step 76: Warrior trainer
	["Warrior trainer"] = "戰士訓練師",
	-- {area:1660} Warrior's Terrace · {quest:1684} Elanaria
	["Level 12 spells while you're on the {area:1660}: the warrior trainers stand beside {quest:1684}."] = "趁你在{area:1660}時學習12級法術：戰士訓練師站在{quest:1684}旁邊。",

	-- Step 78: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, in the {area:1658}"] = "{npc:3516}，在{area:1658}",

	-- Step 79: Cenarion Enclave
	-- {npc:4146} Jocaste · {area:1658} Cenarion Enclave · {spell:5149} Beast Training
	["{npc:4146}, in the {area:1658}: {spell:5149}"] = "{npc:4146}，在{area:1658}：{spell:5149}",

	-- Step 80: Cenarion Enclave trainers
	-- {area:1658} Cenarion Enclave
	["{area:1658} trainers"] = "{area:1658}訓練師",
	-- {area:1658} Cenarion Enclave
	["Level 12 spells while you're in the {area:1658}: the hunter, rogue and druid trainers all stand in it."] = "趁你在{area:1658}時學習12級法術：獵人、盜賊和德魯伊訓練師都在裡面。",

	-- Step 82: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217}, in the {area:1658}"] = "{npc:4217}，在{area:1658}",
	-- {area:3425} Cenarion Hold
	["the tunnel mouth below {area:3425}, on the way south"] = "{area:3425}下方的隧道口，在南下的路上",
	-- {npc:4092} Lariia
	["{npc:4092}, in the Temple of the Moon"] = "{npc:4092}，在月神殿裡",
	-- {npc:7999} Tyrande Whisperwind · {npc:4092} Lariia
	["{npc:7999}, above {npc:4092}"] = "{npc:7999}，在{npc:4092}上方",
	-- {quest:2520} Sathrah's Sacrifice
	["{quest:2520}, standing in the temple's central fountain"] = "{quest:2520}，站在月神殿中央的噴泉裡",
	-- {npc:11401} Priestess Alathea
	["{npc:11401}, in the Temple of the Moon: Starshards"] = "{npc:11401}，在月神殿裡：星辰碎片",

	-- Step 83: Priest trainer
	["Priest trainer"] = "牧師訓練師",
	-- {npc:11401} Priestess Alathea
	["Level 12 spells while you're in the Temple of the Moon: the priest trainers stand beside {npc:11401}."] = "趁你在月神殿時學習12級法術：牧師訓練師站在{npc:11401}旁邊。",

	-- Step 84: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "順路：向{npc:11866}（{area:1660}，10銀）學習法杖；獵人的近戰武器主要看屬性，雙手武器提供的屬性最多。",

	-- Step 85: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "順路：向{npc:11866}（{area:1660}，10銀）學習法杖；升級期間法杖提供的法術屬性比單手武器多。",

	-- Step 86: Portal to Teldrassil
	-- {quest:940} Teldrassil
	["Portal to {quest:940}"] = "通往{quest:940}的傳送門",

	-- Step 87: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:10118} Nessa Shadowsong · {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine · {area:442} Auberdine · {npc:4200} Laird
	["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs. Once you have {quest:6342}, talk to {npc:3838} again and choose the flight to {area:442}: it is free and lands beside {npc:4200}. If the flight map opens instead, close it and talk to him again holding Shift."] = "透過傳送門下到{area:702}。{npc:10118}站在碼頭上，{npc:3838}在角鷹獸旁。接到{quest:6342}後，再次與{npc:3838}交談，選擇飛往{area:442}：這趟免費，落地就在{npc:4200}旁邊。如果開啟的是飛行地圖，先關閉，再按住 Shift 與他交談。",
	-- {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine
	["talk to {npc:3838} again: free with {quest:6342}"] = "再次與{npc:3838}交談：持有{quest:6342}時免費",

	-- Step 88: Auberdine
	-- {npc:3841} Caylais Moonfeather · {npc:4200} Laird
	["Learn the flight path from {npc:3841} where you land. {npc:4200}'s fish stall is just north of her, by the docks.\nThe boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "降落後先找{npc:3841}學習飛行路線。{npc:4200}的魚攤就在她北邊、碼頭旁。\n船停在村子西邊。飛行管理員站在旅店南邊的山丘上；任務釋出者分散在主街上。",
	["The WANTED poster outside the inn"] = "旅店外的通緝海報",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart"] = "{npc:3666}，在旅店樓上：從裡面走樓梯，箭頭分不清樓層",

	-- Step 89: Return to Nessa
	-- {area:702} Rut'theran Village · {npc:3841} Caylais Moonfeather · {item:16263} Laird's Response · {npc:10118} Nessa Shadowsong · {area:442} Auberdine
	["Fly back to {area:702} from {npc:3841}, hand {item:16263} to {npc:10118} on the dock, then fly back to {area:442}."] = "從{npc:3841}處飛回{area:702}，把{item:16263}交給碼頭上的{npc:10118}，然後飛回{area:442}。",

	-- Step 90: The Long Wash
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "潮行蟹在村子下方的海岸爬行；{quest:983}站在碼頭南邊不遠的海灘上。黑海岸蛇頸龍在淺水中游動。{object:175207}在村子南邊不遠的岸上。",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "爬行者的腿：潮汐爬行者",
	-- {quest:983} Buzzbox 827 · {zone:1439} Darkshore
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["{quest:983}: Thresher Eyes, on the {zone:1439} guide's first beach stop"] = "",

	-- Step 91: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}，在村子北端",

	-- Step 92: Gubber Blump
	-- {npc:10216} Gubber Blump · {item:12238} Darkshore Grouper
	["Fishers only: {npc:10216} stands on the pier. His {item:12238} is fished from the pier itself."] = "僅限釣魚者：{npc:10216}站在碼頭上。他的{item:12238}就在碼頭上釣得到。",
	-- {npc:10216} Gubber Blump
	["{npc:10216}, on the pier"] = "{npc:10216}，在碼頭上",

	-- Step 93: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {area:493} Moonglade · {npc:10897} Sindrayl · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn {area:493}'s flight path from {npc:10897}, south of the lake, for later trips. Then {npc:11800} in {area:2361} flies Druids straight to {area:702} from her gossip: hers is no flight path to learn. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "施放{spell:18960}。{npc:11802}在{area:2361}；{quest:5929}在西北方的樹林裡。順便向湖南邊的{npc:10897}學會{area:493}的飛行路線，方便以後往返。然後{area:2361}的{npc:11800}可透過對話直接把德魯伊送到{area:702}：她那裡沒有可學的飛行路線。{npc:11802}站在他建築的樓上：從裡面上樓，箭頭分不出樓層。",
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "施放{spell:18960}",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "與{quest:5929}交談",

	-- Step 94: Back to Darnassus
	-- {npc:10118} Nessa Shadowsong · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:10118} stands on the Rut'theran dock where you land. Then take the portal up to {npc:4217} in the {area:1658}."] = "落地後，{npc:10118}就在魯瑟蘭村碼頭上。隨後透過傳送門上去，到{area:1658}找{npc:4217}。",

	-- Step 97: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702}飛行管理員",
	-- {zone:1457} Darnassus
	["Take the portal down from {zone:1457} to the hippogryphs."] = "",

	-- Step 98: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Go back down to {area:702} and fly to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "回到{area:702}，飛往{area:442}。{object:177525}在村莊東邊的山丘上：在那裡使用{item:15208}，擊敗月爪梟獸，然後與{npc:12144}交談。",

	-- Step 99: Auberdine flight master
	-- {area:442} Auberdine
	["{area:442} flight master"] = "{area:442}飛行管理員",

	-- Step 100: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine
	["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442}."] = "再飛往{area:702}一次，搭傳送門上去找{npc:4217}，然後飛回{area:442}。",

	-- Step 101: Back to Auberdine
	-- {area:442} Auberdine
	["Back to {area:442}"] = "",
	-- {area:702} Rut'theran Village
	["Take the portal down to the hippogryphs at {area:702}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {zone:1453}"] = "搭船前往{zone:1453}",
	-- ["Each of {npc:3601}'s quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "{npc:3601}的每個任務都會給你一根{item:15908}：對他指定的野獸使用，然後把馴獸棒帶回{area:186}給他。樹林潛伏者在村莊周圍潛行，夜刃捕食者和巨翼惡梟在村莊南邊的樹林遊蕩。",
	-- ["East to {area:260}"] = "向東前往{area:260}",
	-- ["Follow the road south-west out of {area:188} to {area:186}."] = "沿著道路向西南離開{area:188}，前往{area:186}。",
	-- ["Follow the road west into {zone:1457} and use the {item:279378} at the inn on the {area:1659} and at the tunnel mouth below {area:3425} for the last two owls. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092}, {npc:7999}, {npc:7313} and {npc:8396} are in the Temple of the Moon at the south end."] = "沿著道路向西進入{zone:1457}，在{area:1659}的旅店和{area:3425}下方的隧道口使用{item:279378}，完成最後兩隻貓頭鷹。{npc:4241}站在一進城的{area:1659}上。{npc:3516}在城市北端的{area:1658}，{quest:922}就在其南邊；{npc:4092}、{npc:7999}、{npc:7313}和{npc:8396}在城市南端的月神殿裡。",
	-- ["From the harbour walk into {object:2100}. {npc:5480} trains warriors there; {npc:6089} and {npc:6090} stand together by the {object:2152}. {npc:6090} fights you for his mug."] = "從港口走進{object:2100}。{npc:5480}在那裡訓練戰士；{npc:6089}和{npc:6090}一起站在{object:2152}旁。{npc:6090}會為了他的杯子和你決鬥。",
	-- ["From {area:17203}, ride through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "從{area:17203}騎馬穿過城門進入{zone:1429}，沿著道路向西前往{zone:1436}。",
	-- ["Hearth to {area:186}"] = "用爐石回{area:186}",
	-- ["Into {zone:1457}"] = "進入{zone:1457}",
	-- ["Learn the {area:442} flight path on the hill south of the inn, then cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "在旅店南邊的山丘上學習{area:442}的飛行路線，然後施放{spell:18960}。{npc:11802}在{area:2361}；{quest:5929}在西北方的樹林裡。在{area:2361}學習{area:493}的飛行路線，然後飛往{area:702}（途經{area:442}）。",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers live along the road east. The moonwell is at the west edge of {area:260}."] = "夜刃豹、巨翼梟和樹林潛伏者分布在往東的道路沿線。月井在{area:260}的西緣。",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east; the lurkers also drop the recipe's spider legs. The moonwell is at the west edge of {area:260}."] = "夜刃豹、巨翼梟和樹林潛伏者在{area:186}四周和往東的道路沿線遊蕩；潛伏者也會掉落配方要的蜘蛛腿。月井在{area:260}的西緣。",
	-- ["North-east from Ursal's den, back to {area:186}."] = "從大槌烏薩爾的巢穴向東北走，回到{area:186}。",
	-- ["South from the glade toward Ursal: Shayla walks the road west of {area:186}, from where the path down from the glade meets it south-west to the bend at about 38,54 and back."] = "從林地向南朝大槌烏薩爾前進：夏伊拉在{area:186}西邊的道路上來回巡邏，從林地下來的小路與道路交會處往西南走到約38,54的彎道再折返。",
	-- ["South of the pools. The {object:6751} grows by the Hold; the furbolgs around it drop the rest of the fangs."] = "在池塘南邊。{object:6751}生長在脊骨堡旁；周圍的熊怪會掉落其餘的牙。",
	-- ["Speak with {npc:6286}, south of the inn"] = "與旅店南邊的{npc:6286}交談",
	-- ["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs."] = "搭傳送門下到{area:702}。{npc:10118}站在碼頭上，{npc:3838}在角鷹獸旁。",
	-- ["Take the portal up from {area:702} to {npc:4217} in the {area:1658}."] = "從{area:702}搭傳送門上去，到{area:1658}找{npc:4217}。",
	-- ["Take the road north-west from {area:186} towards the {area:264}; she lies hurt beside it."] = "沿著道路從{area:186}向西北前往{area:264}；她受傷躺在路旁。",
	-- ["The Bloodfeather harpies nest on the slopes west and north of the glade."] = "血羽鷹身人在林地西邊和北邊的山坡上築巢。",
	-- ["The moonwell and {npc:8584}"] = "月井與{npc:8584}",
	-- ["The moonwell sits north of {area:256}; {npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "月井在{area:256}北邊；{npc:8584}在更西北一點。{quest:3522}只有五分鐘：裝滿藥瓶後直接去找他。",
	-- ["The named harpies"] = "有名字的鷹身人",
	-- ["The {area:264}"] = "{area:264}",
	-- ["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}."] = "沿著島的西側向南走。大槌烏薩爾在最南邊、{area:478}下方徘徊。",
	-- ["Webwood Spiders"] = "樹林蜘蛛",
	-- ["West along the road from {area:186}, before the turn north to the glade: Shayla walks the road from the arrow south-west to the bend at about 38,54 and back."] = "從{area:186}沿著道路向西走，在轉向北邊前往林地之前：夏伊拉在這段路上來回巡邏，從箭頭處往西南走到約38,54的彎道再折返。",
	-- ["West from the webwoods to the {area:265}, then north along it to the glade: the timberlings along its banks drop the Mossy Tumors."] = "從蜘蛛所在的樹林向西前往{area:265}，然後沿著河向北走到林地：河岸邊的林精會掉落苔蘚腫瘤。",
	-- ["Young Nightsabers and Young Thistle Boars roam around {area:256}. Grells carry {item:3297} in the woods west of the tree, where the Gnarlpine Totems stand."] = "小夜刃豹和小草刺野豬在{area:256}周圍遊蕩。小劣魔帶著{item:3297}，在樹西邊瘤背圖騰矗立的樹林裡。",
	-- ["{area:186} quests"] = "{area:186}任務",
	-- ["{npc:11401}, in the Temple of the Moon: {spell:10797}"] = "{npc:11401}，在月神殿裡：{spell:10797}",
	-- ["{npc:2150}, on the way back"] = "{npc:2150}，在回程路上",
	-- ["{npc:265811}, alchemists: for {npc:3603}"] = "{npc:265811}，煉金術師：交給{npc:3603}",
	-- ["{npc:265811}, herbalists: for {npc:3604}"] = "{npc:265811}，草藥師：交給{npc:3604}",
	-- ["{npc:265811}, leatherworkers: for {npc:3605}"] = "{npc:265811}，製皮師：交給{npc:3605}",
	-- ["{npc:265811}, skinners: for {npc:6287}"] = "{npc:265811}，剝皮師：交給{npc:6287}",
	-- ["{npc:265811}, {skill:129}: for {npc:6094}"] = "{npc:265811}，{skill:129}：交給{npc:6094}",
	-- ["{npc:272034} and {npc:272044} fly just west of the moonwell, {npc:272046} further north."] = "{npc:272034}和{npc:272044}在月井西邊飛行，{npc:272046}在更北邊。",
	-- ["{npc:3567}, back in {area:186}"] = "{npc:3567}，回到{area:186}",
	-- ["{npc:3595}, inside the tree"] = "{npc:3595}，在樹裡",
	-- ["{npc:3595}, the priest trainer, on the ramp on the way down: {npc:3600} in {area:186} takes it"] = "{npc:3595}，牧師訓練師，在下樓途中的坡道上：由{area:186}的{npc:3600}接收",
	-- ["{npc:3603}, beside {npc:6286}: Camping 101, alchemists"] = "{npc:3603}，在{npc:6286}旁邊：露營入門，煉金術師",
	-- ["{npc:3604}, beside {npc:6286}: Camping 101, herbalists"] = "{npc:3604}，在{npc:6286}旁邊：露營入門，草藥師",
	-- ["{npc:3605}, beside him: Camping 101, leatherworkers"] = "{npc:3605}，在他旁邊：露營入門，製皮師",
	-- ["{npc:4200}'s fish stall is by the docks. Then take the boat to {zone:1453}."] = "{npc:4200}的魚攤在碼頭旁。然後搭船前往{zone:1453}。",
	-- ["{npc:6094}, in the inn: Camping 101, {skill:129}"] = "{npc:6094}，在旅店裡：露營入門，{skill:129}",
	-- ["{npc:6287}, camped beside the road before Shayla: Camping 101, skinners"] = "{npc:6287}，在夏伊拉之前的路旁紮營：露營入門，剝皮師",
	-- ["{npc:7318}, in the den"] = "{npc:7318}，在巢穴裡",
	-- ["{object:7510}, beside him"] = "{object:7510}，在他旁邊",
	-- ["{quest:488} and the Starbreeze moonwell"] = "{quest:488}與星風村月井",
	-- ["{quest:97979}: cast {spell:1259799} and {spell:20580}, then hand it back to {npc:3595}"] = "{quest:97979}：施放{spell:1259799}和{spell:20580}，然後交回給{npc:3595}",
}
