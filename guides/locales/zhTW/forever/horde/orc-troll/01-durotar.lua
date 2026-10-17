-- Chinese (traditional) (zhTW): the guide forever/horde/orc-troll/01-durotar (forever/horde/orc-troll/01-durotar.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}，在你的出生點",

	-- Step 2: Gornek
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143}在大獸穴裡等候，就是{npc:10176}西邊的那棟建築。",

	-- Step 3: Training weapons and boars
	["Training weapons and boars"] = "訓練武器與野豬",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "武器散落在大獸穴和訓練場周圍；雜斑野豬在整個谷底遊蕩。",

	-- Step 4: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143}就站在洞口內；{npc:3159}在他身後的洞穴深處。",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave"] = "{npc:3159}，在洞穴深處",
	-- {npc:3156} Nartok
	["{npc:3156}, the warlock trainer at the back of the cave"] = "{npc:3156}，洞穴深處的術士訓練師",
	-- {npc:3155} Rwag
	["{npc:3155}, the rogue trainer in the Den"] = "{npc:3155}，大獸穴裡的盜賊訓練師",
	-- {npc:3153} Frang
	["{npc:3153}, the warrior trainer beside the Den"] = "{npc:3153}，大獸穴旁的戰士訓練師",
	-- {npc:3154} Jen'shan
	["{npc:3154}, the hunter trainer beside the Den"] = "{npc:3154}，大獸穴旁的獵人訓練師",
	-- {npc:3707} Ken'jai
	["{npc:3707}, the priest trainer at the Den"] = "{npc:3707}，大獸穴的牧師訓練師",
	-- {npc:3157} Shikrik
	["{npc:3157}, the shaman trainer beside the Den"] = "{npc:3157}，大獸穴旁的薩滿訓練師",
	-- {npc:5884} Mai'ah
	["{npc:5884}, the mage trainer, at the entrance to the Den"] = "{npc:5884}，法師訓練師，在大獸穴入口",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}，在烹飪火堆旁",

	-- Step 5: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287}受傷躺在大獸穴西北方的山腳下。",

	-- Step 6: Sarkoth
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["{quest:790}, a large scorpid, prowls the slope south of {npc:3287} among the Scorpid Workers; pick the Cactus Apples by the cactuses on the way."] = "{quest:790}是一隻大蠍子，在{npc:3287}南邊的山坡上與工蠍一起徘徊；沿途在仙人掌旁採集仙人掌果。",

	-- Step 8: Back to the Den
	["Back to the Den"] = "回到大獸穴",

	-- Step 9: Foreman Thazz'ril
	["The foreman stands at the lumber pile east of the Den."] = "工頭站在大獸穴東邊的木材堆旁。",

	-- Step 10: Lazy Peons
	-- {item:16114} Foreman's Blackjack
	["Hit the sleeping peons north of the Den with the {item:16114}."] = "用{item:16114}敲打大獸穴北邊睡著的苦工。",
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "用{item:16114}叫醒{quest:5441}",

	-- Step 12: North end of the valley
	["North end of the valley"] = "山谷北端",
	-- {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	["The {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "{quest:792}聚集在{area:365}下方的山坡上，那是山谷北側的洞穴。",

	-- Step 13: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "進入洞穴後，在第一個岔路直走，然後往右，沿著左手邊的溪流走到瀑布：鎬在水邊發光，在一根石柱後面。",

	-- Step 14: Back at the Den
	["Back at the Den"] = "回到大獸穴",

	-- Step 15: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller
	["{npc:5887} stands just outside the Den."] = "{npc:5887}就站在大獸穴外。",

	-- Step 17: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "進入洞穴後，一路沿著右側牆壁繞行，越過溪流：{npc:3183}在盡頭等著。",

	-- Step 18: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "{npc:3102}的蹄子",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "地獄捕獵者在洞穴下方的山坡上遊蕩，位於山谷北側。",

	-- Step 19: Zureetha Fargaze
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "她旁邊地上的{object:654925}",

	-- Step 20: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887}站在大獸穴外。{area:639}就是它南邊的山丘：在那裡喝下{item:6635}以看見{npc:5891}，然後把{item:6656}帶回給{npc:5887}。",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}，在{area:639}上",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}：{npc:5873}和你的{item:5175}",

	-- Step 21: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786}站在山谷東側出口的道路上。",

	-- Step 22: Sen'jin Village
	-- {area:367} Sen'jin Village
	["Follow the road east out of the valley to {area:367} on the coast."] = "沿著道路向東離開山谷，前往海岸邊的{area:367}。",

	-- Step 23: Ridgeshade spiders
	["Ridgeshade spiders"] = "脊影蜘蛛",
	-- {area:362} Razor Hill
	["The spiders lurk in the hills along the road north toward {area:362}."] = "蜘蛛潛伏在往北通往{area:362}的道路沿線山丘中。",

	-- Step 24: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "{npc:265809}的營火",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears."] = "{npc:265809}在{area:362}南邊紮營。在他的營火旁坐下（/sit），直到出現{spell:1229451}增益效果。",

	-- Step 25: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town"] = "{npc:266940}，在城鎮東側",
	-- {npc:3191} Cook Torka
	["Talk to {npc:3191}"] = "與{npc:3191}交談",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}，在瞭望塔裡",

	-- Step 26: Prickly pears
	["Prickly pears"] = "仙人掌果",
	["The prickly pears grow among the quilboar huts just west of town."] = "仙人掌果生長在城鎮西邊的野豬人小屋之間。",

	-- Step 28: Razormane Grounds
	["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "鋼鬃野豬人和鋼鬃斥候佔據城鎮西邊的小屋；鋼鬃傳令兵和鋼鬃衛兵佔據更西邊的營地。",

	-- Step 30: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps · {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "城堡位於{area:362}東南方的海岸上。襲擊者的斧頭、弓和盾牌在城堡外圍。庫爾提拉斯水手和水兵會掉落{item:4870}。{npc:3192}在城堡頂端等候；他的鑰匙可以打開他旁邊的箱子，裡面有{item:4881}。",

	-- Step 32: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Follow the road north toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "沿著道路向北往{zone:1454}走。{npc:3293}在路旁紮營；被偷的袋子散落在他南邊的道路沿線。",

	-- Step 33: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}."] = "塵風暴徒和塵風雷巫在{npc:3293}東邊的{area:370}築巢。塵風雷巫會掉落{item:277661}。",

	-- Step 35: Thunder lizards
	["Thunder lizards"] = "雷霆蜥蜴",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}."] = "雷霆蜥蜴和閃電蜥蜴在{npc:3293}西邊和西南方的{area:369}吃草。",

	-- Step 37: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "米莎的小屋在蜥蜴的南邊。西邊{area:814}沿岸的鱷魚身上帶著{item:4891}。",

	-- Step 38: The wreckage
	["The wreckage"] = "殘骸",
	-- {area:362} Razor Hill
	["The gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin."] = "地精工具箱散落在{area:362}東邊和東南方海岸的殘骸中。沿著海岸向南走到森金村。",

	-- Step 39: Sen'jin Village
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}：僅限附魔師，殘渣要從妖術墜飾分解取得",

	-- Step 40: Makrura and crawlers
	["Makrura and crawlers"] = "龍蝦人與海浪蟹",
	["Makrura and surf crawlers line the beaches north-east of Sen'jin."] = "龍蝦人和海浪蟹分布在森金村東北方的海灘。",

	-- Step 41: Bloodtalon Matriarch
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there."] = "涉水到北邊的回音群島。族母在那裡的迅猛龍之間徘徊。",

	-- Step 42: Echo Isles
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle."] = "向南穿過群島。洛阿神像遍布南部島嶼；巫毒食人妖和被施妖術的食人妖守著它們，並掉落妖術墜飾。{quest:826}和明希納的囚籠在最南端的島上。",

	-- Step 43: South-east shore
	["South-east shore"] = "東南海岸",
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade back west to the shore south of Sen'jin. Durotar Tigers roam it and the Taillasher eggs sit in nests along the beach."] = "涉水向西回到森金村南邊的海岸。杜洛塔猛虎在那裡遊蕩，鞭尾龍的蛋在海灘沿線的巢裡。",

	-- Step 45: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "{area:366}在森金村西邊。三份進攻計畫放在半人馬帳篷之間的地上。{npc:275811}也被關在峭壁那裡。",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "釋放{npc:275811}，並護送她安全離開峭壁",

	-- Step 47: Razor Hill
	-- {area:362} Razor Hill
	["Follow the road north to {area:362}."] = "沿著道路向北前往{area:362}。",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}，在旅店旁",
	-- {npc:3706} Tai'jin · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["{npc:3706}, for {npc:6018} in {zone:1454}: keep it"] = "{npc:3706}，交給{zone:1454}的{npc:6018}：保留此任務",

	-- Step 48: Fizzle Darkstorm
	-- {area:369} Thunder Ridge · {area:362} Razor Hill · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	["Fizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way."] = "費索佔據{area:362}西北方{area:369}上的燃刃氏族營地。獵人：沿途用{item:15908}馴服一隻{npc:3099}。",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "用{item:15908}馴服牠",

	-- Step 50: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657}站在{area:362}東邊的岸上。三叉戟、旗幟和匕首散落在他周圍的海灘上。",

	-- Step 51: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828}在納迦海灘西邊的山丘上紮營，位於{quest:827}南邊。",

	-- Step 52: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "{zone:1454}的正門就在{area:817}西邊。{npc:5875}站在{object:172960}，就是{object:172982}下方的峽谷。",

	-- Step 53: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "{area:817}入口",

	-- Step 54: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}."] = "燃刃氏族的教徒佔據{quest:827}的洞穴；他們都會掉落{item:4871}。{npc:3204}是14級的術士，站在深處，會掉落{item:4903}。",

	-- Step 55: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "{object:58595}在{area:817}裡，就在你剛才打過的教徒之間。",

	-- Step 56: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:7464} Glyphs of Summoning
	["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "回到{object:172960}找{npc:5875}。在那裡的召喚法陣使用{item:7464}，擊敗虛空行者以束縛它。",

	-- Step 58: Razor Hill
	-- {area:362} Razor Hill
	["Back south to {area:362}."] = "向南回到{area:362}。",

	-- Step 59: Spitelash naga
	["Spitelash naga"] = "惡鞭納迦",
	-- {npc:275657} Heglan Shadeeye · {area:370} Drygulch Ravine · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["Back east to the shore north of {npc:275657}. Spitelash Scouts and Attendants hold the beach below {area:370}. Hunters: tame a {npc:3107} on the beach."] = "向東回到{npc:275657}北邊的海岸。{npc:275662}和其他惡鞭納迦佔據{area:370}下方的海灘。獵人：在海灘上馴服一隻{npc:3107}。",

	-- Step 60: Razor Hill
	-- {area:362} Razor Hill
	["Back to {area:362}."] = "回到{area:362}。",
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}：{npc:275666}，一個精英海巨人",

	-- Step 61: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "{npc:275666}是一個年輕的海巨人，在{zone:1411}北岸、納迦海灘的北邊走動。{npc:275666}是精英：建議組隊。",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}，回到{area:362}",

	-- Step 62: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "硬甲蠍在{area:362}西邊的平原上爬行。馴服一隻，然後回到{npc:3171}那裡。",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "{npc:3171}：{zone:1454}的{npc:3352}教授{spell:5149}",

	-- Step 63: Ormak Grimshot
	-- {area:362} Razor Hill · {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor
	["Follow the road north from {area:362} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "沿著道路從{area:362}向北前往{zone:1454}的正門，就在{area:817}西邊。{npc:3352}和獵人訓練師們站在{object:172958}。",

	-- Step 64: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {area:379} Far Watch Post · {zone:1413} Barrens
	["Follow the road west from {area:362} over the {area:814} bridge; {area:379} sits just above it on the {zone:1413} side."] = "沿著道路從{area:362}向西過{area:814}的橋；{area:379}就在橋上方的{zone:1413}那一側。",

	-- Step 65: Thunder lizards across the river
	["Thunder lizards across the river"] = "河對岸的雷霆蜥蜴",
	-- {area:369} Thunder Ridge · {item:6486} Singed Scale
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "雷霆蜥蜴和閃電蜥蜴在橋對面的{area:369}吃草；牠們都可能掉落{item:6486}。",

	-- Step 67: The Crossroads
	-- {area:379} Far Watch Post · {area:380} The Crossroads · {zone:1413} Barrens
	["Follow the road south-west from {area:379} to the {area:380}. {zone:1413} guide starts here."] = "沿著道路從{area:379}向西南前往{area:380}。{zone:1413}指南從這裡開始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road south-west from {area:379} to the {area:380}. {zone:1413} guide starts here."] = "沿著道路從{area:379}向西南前往{area:380}。{zone:1413}指南從這裡開始。",
	-- ["{area:364}'s cave mouth"] = "{area:364}洞口",
}
