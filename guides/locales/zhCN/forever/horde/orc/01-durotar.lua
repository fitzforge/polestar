-- Chinese (simplified) (zhCN): the guide forever/horde/orc/01-durotar (forever/horde/orc/01-durotar.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143}在{npc:10176}西边的建筑——试炼谷洞穴里等候。",
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}，你的出发点",
	["Inside"] = "",

	-- Step 2: Training weapons and boars
	["Training weapons and boars"] = "训练武器和野猪",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "被遗弃的训练武器散落在洞穴和训练场周围；{npc:3098}在整个山谷谷底游荡。",

	-- Step 3: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143}站在洞口内侧；{npc:3159}在他身后的洞穴深处。",
	-- {npc:3143} Gornek
	["{npc:3143}, inside"] = "",
	-- {npc:3156} Nartok
	["{npc:3156}, the warlock trainer at the back of the cave"] = "{npc:3156}，洞穴深处的术士训练师",
	-- {npc:3155} Rwag
	["{npc:3155}, the rogue trainer in the Den"] = "{npc:3155}，洞穴里的潜行者训练师",
	-- {npc:3153} Frang
	["{npc:3153}, the warrior trainer beside the Den"] = "{npc:3153}，洞穴旁的战士训练师",
	-- {npc:3154} Jen'shan
	["{npc:3154}, the hunter trainer beside the Den"] = "{npc:3154}，洞穴旁的猎人训练师",
	-- {npc:3157} Shikrik
	["{npc:3157}, the shaman trainer beside the Den"] = "{npc:3157}，洞穴旁的萨满祭司训练师",
	-- {npc:5884} Mai'ah
	["{npc:5884}, the mage trainer, at the entrance to the Den"] = "{npc:5884}，法师训练师，在洞穴入口",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave; below ground"] = "",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}，在烹饪火堆旁",
	-- {npc:11378} Foreman Thazz'ril
	["{npc:11378}, at the lumber pile east of the Den"] = "",

	-- Step 4: Scorpid Worker Tail on the way
	-- {item:4862} Scorpid Worker Tail
	["{item:4862} on the way"] = "",

	-- Step 5: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287}受伤躺在洞穴西北方的山脚下。",

	-- Step 6: Valley of Trials: kill these as you meet them
	-- {area:363} Valley of Trials
	["{area:363}: kill these as you meet them"] = "",
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua · {item:16114} Foreman's Blackjack · {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["{quest:790}, a large scorpid, prowls the slope south of {npc:3287} among the Scorpid Workers; pick the Cactus Apples by the cactuses on the way, and hit the sleeping peons across the valley with the {item:16114}.\nThe {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "",
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "用{item:16114}叫醒{quest:5441}",

	-- Step 7: Class trainer
	["Class trainer"] = "",

	-- Step 8: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:363} Valley of Trials
	["{npc:246344} in {zone:1456}; {area:363} has no paladin trainer"] = "",

	-- Step 9: Druid trainer
	["Druid trainer"] = "",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:363} Valley of Trials
	["{npc:3034} in {zone:1412}; {area:363} has no druid trainer"] = "",

	-- Step 10: Back to the Den
	["Back to the Den"] = "返回洞穴",

	-- Step 12: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "进入洞穴后，在第一个岔口直走，然后右转，沿左手边的溪流走到瀑布：镐在水边、一根石柱后面发光。",

	-- Step 13: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "进入洞穴后，一直沿右侧洞壁绕行，越过溪流：{npc:3183}在尽头等候。",
	["Below ground"] = "",

	-- Step 14: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "{npc:3102}的蹄子",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "地狱捕猎者在山谷北侧、洞穴下方的山坡上游荡。",

	-- Step 16: Back to the Den
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "她身旁地上的{object:654925}",

	-- Step 17: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887}站在洞穴外。{area:639}是洞穴南边的小山：在那里喝下{item:6635}以看到{npc:5891}，然后把{item:6656}带回给{npc:5887}。",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}，在{area:639}",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}：{npc:5873}和你的{item:5175}",

	-- Step 18: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786}站在山谷东侧出口的路上。",

	-- Step 19: Sen'jin Village
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}：仅限附魔师，残渣通过分解{item:275724}获得",
	-- {npc:5880} Un'Thuwa
	["{npc:5880}, the mage trainer in Sen'jin"] = "",

	-- Step 20: On the way
	["On the way"] = "",
	-- {npc:266850} Ridgeshade Creeper · {area:362} Razor Hill
	["{npc:266850} along the way to {area:362}"] = "",
	-- {npc:266849} Ridgeshade Lurker · {area:362} Razor Hill
	["{npc:266849} along the way to {area:362}"] = "",

	-- Step 21: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "{npc:265809}的营火",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears."] = "",

	-- Step 22: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town; inside"] = "",

	-- Step 23: Taillasher Egg on the way
	-- {item:4890} Taillasher Egg
	["{item:4890} on the way"] = "",

	-- Step 24: Razor Hill
	-- {npc:3191} Cook Torka
	["{npc:3191}: Camping 101 asks you to learn it"] = "",
	-- {npc:6928} Innkeeper Grosk
	["{npc:6928}, inside"] = "",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}，在瞭望塔里",

	-- Step 25: Prickly pears
	["Prickly pears"] = "仙人掌果",
	["The prickly pears grow among the quilboar huts just west of town."] = "仙人掌果生长在镇子西边的野猪人小屋之间。",

	-- Step 27: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps · {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "城堡位于{area:362}东南方的海岸上。袭击者的斧头、弓和盾牌在城堡外围。库尔提拉斯水手和库尔提拉斯水兵掉落{item:4870}。{npc:3192}在城堡顶层等候；他的钥匙能打开他旁边的箱子，里面有{item:4881}。",
	["Upstairs"] = "",

	-- Step 28: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, inside"] = "",

	-- Step 31: Scuttle Coast: kill these as you meet them
	-- {area:373} Scuttle Coast
	["{area:373}: kill these as you meet them"] = "",
	-- {area:362} Razor Hill
	["Makrura and surf crawlers line the beaches north-east of Sen'jin.\nThe gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin."] = "",
	["Underwater"] = "",

	-- Step 32: Durotar Tiger Fur on the way
	-- {item:4892} Durotar Tiger Fur
	["{item:4892} on the way"] = "",
	-- {item:4892} Durotar Tiger Fur · {area:367} Sen'jin Village
	["{item:4892} along the way to {area:367}"] = "",

	-- Step 33: Echo Isles: kill these as you meet them
	-- {area:368} Echo Isles
	["{area:368}: kill these as you meet them"] = "",
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there.\nWade back west to the shore south of Sen'jin. Durotar Tigers roam it and the Taillasher eggs sit in nests along the beach."] = "",

	-- Step 34: Echo Isles: kill these as you meet them
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle."] = "向南穿过群岛。被遗忘的洛阿神像散落在南部各岛；巫毒巨魔和{npc:3207}守着它们，并掉落{item:275724}。{quest:826}和明希纳的笼子在最南边的岛上。",

	-- Step 35: Deathskip to Sen'jin Village
	-- {area:367} Sen'jin Village
	["Deathskip to {area:367}"] = "",
	-- {npc:3206} Voodoo Troll · {npc:6491} Spirit Healer
	["Die to the mobs at 66.9,87.2 ({npc:3206}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "",

	-- Step 37: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "{area:366}在森金村西边。三份进攻计划在半人马帐篷之间的地上。{npc:275811}也被关押在峭壁。",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "救出{npc:275811}，护送她安全离开峭壁",

	-- Step 40: Hearth to Razor Hill
	-- {area:362} Razor Hill
	["Hearth to {area:362}"] = "",

	-- Step 43: Level 10
	["Level 10"] = "",
	-- {quest:840} Conscript of the Horde · {area:362} Razor Hill
	["Top up here to level 10: {quest:840}, at {area:362}, needs level 10."] = "",
	-- {npc:3111} Razormane Quilboar
	["grind on {npc:3111}"] = "",

	-- Step 44: Razor Hill
	-- {npc:3169} Tarshaw Jaggedscar
	["{npc:3169}, inside"] = "",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}，在旅店旁",

	-- Step 46: Kranal Fiss
	-- {area:814} Southfury River · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge, past {area:379} and on along the ridge: {npc:5907} stands alone above the Razormane camp."] = "",

	-- Step 47: Razormane Grounds
	["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "钢鬃野猪人和钢鬃斥候占据着镇子西边的小屋；钢鬃传令兵和钢鬃卫兵占据着更西边的营地。",

	-- Step 48: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Head north-east to the road toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "",

	-- Step 49: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb · {area:371} Dustwind Cave · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}. Shamans: the Burning Blade Cultists by {area:371}, at the ravine's south end, drop the {item:6652}."] = "",

	-- Step 50: Deathskip to Northern Durotar
	["Deathskip to Northern Durotar"] = "",
	-- {npc:3118} Dustwind Storm Witch · {npc:6491} Spirit Healer
	["Die to the mobs at 52.0,21.4 ({npc:3118}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "",

	-- Step 52: Thunder Ridge: kill these as you meet them
	-- {area:369} Thunder Ridge
	["{area:369}: kill these as you meet them"] = "",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}.\nFizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way.\nCareful: Burning Blade cultists surround Fizzle, some linked so they aggro in pairs, and they respawn quickly."] = "",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "用{item:15908}驯服它",

	-- Step 53: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "米莎·托克伦的小屋在蜥蜴南边。西边{area:814}沿岸的鳄鱼带着{item:4891}。",

	-- Step 55: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657}站在{area:362}东边的岸上。三叉戟、旗帜和匕首在他周围的海滩上。",

	-- Step 57: Paladin trainer
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:362} Razor Hill
	["{npc:246344} in {zone:1456}; {area:362} has no paladin trainer"] = "",

	-- Step 58: Mage trainer
	["Mage trainer"] = "",
	-- {npc:5884} Mai'ah · {area:14} Durotar · {area:362} Razor Hill
	["{npc:5884} in {area:14}; {area:362} has no mage trainer"] = "",

	-- Step 59: Druid trainer
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:362} Razor Hill
	["{npc:3034} in {zone:1412}; {area:362} has no druid trainer"] = "",

	-- Step 60: Razor Hill
	-- {area:362} Razor Hill
	["Back south to {area:362}."] = "向南返回{area:362}。",

	-- Step 61: Spitelash naga
	["Spitelash naga"] = "恶鞭纳迦",
	-- {npc:275657} Heglan Shadeeye · {area:370} Drygulch Ravine · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["Back east to the shore north of {npc:275657}. Spitelash Scouts and Attendants hold the beach below {area:370}. Hunters: tame a {npc:3107} on the beach."] = "向东回到{npc:275657}北边的海岸。{npc:275662}和其他恶鞭纳迦占据着{area:370}下方的海滩。猎人：在海滩上驯服一只{npc:3107}。",

	-- Step 62: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828}在纳迦海滩西边、{quest:827}南边的山丘上扎营。",

	-- Step 64: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "{zone:1454}的正门就在{area:817}西边。{npc:5875}站在{object:172982}下方的峡谷{object:172960}里。",

	-- Step 65: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 66: Back to Durotar
	-- {area:14} Durotar
	["Back to {area:14}"] = "",

	-- Step 67: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "{area:817}的入口",

	-- Step 68: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}."] = "火刃氏族祭司占据着{quest:827}的洞穴；任何一个都会掉落{item:4871}。{npc:3204}是14级术士，站在洞穴深处，掉落{item:4903}。",

	-- Step 69: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "{object:58595}在{area:817}，就在你刚才对付的祭司中间。",

	-- Step 70: Into Orgrimmar
	-- {zone:1454} Orgrimmar
	["Into {zone:1454}"] = "",

	-- Step 72: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:7464} Glyphs of Summoning
	["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "回到{object:172960}找{npc:5875}。在那里的召唤法阵上使用{item:7464}，击败虚空行者以束缚它。",

	-- Step 75: Razor Hill
	-- {area:362} Razor Hill
	["Back to {area:362}."] = "返回{area:362}。",

	-- Step 76: Razor Hill
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}：{npc:275666}，一个精英海巨人",

	-- Step 77: Aggor the Young
	-- {npc:275666} Aggor the Young · {area:14} Durotar
	["{npc:275666}, a young sea giant, walks {area:14}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}，回到{area:362}",

	-- Step 78: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "{npc:3126}在{area:362}西边的平原上爬行。驯服一只，然后返回{npc:3171}处。",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "",

	-- Step 80: Ormak Grimshot
	-- {area:362} Razor Hill · {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor
	["Follow the road north from {area:362} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "沿道路从{area:362}向北到{zone:1454}的正门，就在{area:817}西边。{npc:3352}和猎人训练师一起站在{object:172958}。",

	-- Step 81: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 83: Uzzek
	-- {area:362} Razor Hill · {area:814} Southfury River · {npc:5810} Uzzek · {area:379} Far Watch Post · {area:17} The Barrens
	["Follow the road west from {area:362} over the {area:814} bridge; {npc:5810} stands at {area:379}, just above it on the {area:17} side."] = "",

	-- Step 84: Thunder lizards across the river
	["Thunder lizards across the river"] = "河对岸的雷霆蜥蜴",
	-- {area:369} Thunder Ridge · {item:6486} Singed Scale
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "{npc:3130}和{npc:3131}在桥对面的{area:369}上吃草；任何一只都可能掉落{item:6486}。",

	-- Step 87: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {area:379} Far Watch Post · {area:17} The Barrens
	["Follow the road west from {area:362} over the {area:814} bridge; {area:379} sits just above it on the {area:17} side."] = "",
}
