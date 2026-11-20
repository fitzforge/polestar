-- Chinese (traditional) (zhTW): the guide forever/horde/orc/01-durotar (forever/horde/orc/01-durotar.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143}在大獸穴裡等候，就是{npc:10176}西邊的那棟建築。",
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}，在你的出生點",
	["Inside"] = "在裡面",

	-- Step 2: Training weapons and boars
	["Training weapons and boars"] = "訓練武器與野豬",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "武器散落在大獸穴和訓練場周圍；雜斑野豬在整個谷底遊蕩。",

	-- Step 3: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143}就站在洞口內；{npc:3159}在他身後的洞穴深處。",
	-- {npc:3143} Gornek
	["{npc:3143}, inside"] = "{npc:3143}，在裡面",
	-- {npc:3156} Nartok
	["{npc:3156}, the warlock trainer at the back of the cave"] = "{npc:3156}，洞穴深處的術士訓練師",
	-- {npc:3155} Rwag
	["{npc:3155}, the rogue trainer in the Den"] = "{npc:3155}，大獸穴裡的盜賊訓練師",
	-- {npc:3153} Frang
	["{npc:3153}, the warrior trainer beside the Den"] = "{npc:3153}，大獸穴旁的戰士訓練師",
	-- {npc:3154} Jen'shan
	["{npc:3154}, the hunter trainer beside the Den"] = "{npc:3154}，大獸穴旁的獵人訓練師",
	-- {npc:3157} Shikrik
	["{npc:3157}, the shaman trainer beside the Den"] = "{npc:3157}，大獸穴旁的薩滿訓練師",
	-- {npc:5884} Mai'ah
	["{npc:5884}, the mage trainer, at the entrance to the Den"] = "{npc:5884}，法師訓練師，在大獸穴入口",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave; below ground"] = "{npc:3159}，在洞穴深處；地下",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}，在烹飪火堆旁",

	-- Step 4: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287}受傷躺在大獸穴西北方的山腳下。",

	-- Step 5: Valley of Trials: kill these as you meet them
	-- {area:363} Valley of Trials
	["{area:363}: kill these as you meet them"] = "{area:363}：遇到就殺",
	-- {npc:3287} Hana'zua · {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["The Scorpid Workers roam the slope south of {npc:3287}; pick the Cactus Apples by the cactuses on the way.\nThe {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "工蠍在{npc:3287}南邊的山坡上遊蕩；沿途在仙人掌旁採集仙人掌果。\n{quest:792}聚集在{area:365}下方的山坡上，那是山谷北側的洞穴。",

	-- Step 6: Class trainer
	["Class trainer"] = "職業訓練師",

	-- Step 7: Paladin trainer
	["Paladin trainer"] = "聖騎士訓練師",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:363} Valley of Trials
	["{npc:246344} in {zone:1456}; {area:363} has no paladin trainer"] = "{npc:246344}在{zone:1456}；{area:363}沒有聖騎士訓練師",

	-- Step 8: Druid trainer
	["Druid trainer"] = "德魯伊訓練師",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:363} Valley of Trials
	["{npc:3034} in {zone:1412}; {area:363} has no druid trainer"] = "{npc:3034}在{zone:1412}；{area:363}沒有德魯伊訓練師",

	-- Step 9: Back to the Den
	["Back to the Den"] = "回到大獸穴",
	-- {npc:11378} Foreman Thazz'ril
	["{npc:11378}, at the lumber pile east of the Den"] = "{npc:11378}，在巢穴以東的木料堆處",

	-- Step 10: Lazy Peons
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "用{item:16114}叫醒{quest:5441}",

	-- Step 12: Sarkoth
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua · {area:365} Burning Blade Coven
	["{quest:790}, a large scorpid (level 4), prowls the slope just west of the Den, below {npc:3287}, on the way north to the {area:365}."] = "{quest:790}是一隻大型蠍子（4級），在巢穴西邊、{npc:3287}下方的山坡上徘徊，就在往北前往{area:365}的路上。",

	-- Step 13: Canaga Earthcaller
	-- {npc:3143} Gornek · {quest:804} Sarkoth · {npc:5887} Canaga Earthcaller · {quest:1516} Call of Earth
	["Back to the Den: {npc:3143} takes {quest:804}'s claw and {npc:5887}, just outside, has {quest:1516} now that you are level 4."] = "回到巢穴：{npc:3143}接收{quest:804}的爪子，而門外的{npc:5887}在你4級後會提供{quest:1516}。",

	-- Step 15: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "進入洞穴後，在第一個岔路直走，然後往右，沿著左手邊的溪流走到瀑布：鎬在水邊發光，在一根石柱後面。",

	-- Step 16: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "進入洞穴後，一路沿著右側牆壁繞行，越過溪流：{npc:3183}在盡頭等著。",
	["Below ground"] = "地下",

	-- Step 17: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "{npc:3102}的蹄子",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "地獄捕獵者在洞穴下方的山坡上遊蕩，位於山谷北側。",

	-- Step 18: Back to the Den
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "她旁邊地上的{object:654925}",

	-- Step 19: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887}站在大獸穴外。{area:639}就是它南邊的山丘：在那裡喝下{item:6635}以看見{npc:5891}，然後把{item:6656}帶回給{npc:5887}。",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}，在{area:639}上",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}：{npc:5873}和你的{item:5175}",

	-- Step 20: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786}站在山谷東側出口的道路上。",

	-- Step 21: Sen'jin Village
	-- {area:362} Razor Hill
	["Careful: Ukorsbane (8) is elite and walks among the Ridgeshade spiders in the camp south of {area:362}: pull the spiders away from him."] = "小心：Ukorsbane（8級）是精英，在{area:362}南邊營地的Ridgeshade蜘蛛之間走動：把蜘蛛從他身邊拉開。",
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}：僅限附魔師，殘渣要從妖術墜飾分解取得",
	-- {npc:5880} Un'Thuwa
	["{npc:5880}, the mage trainer in Sen'jin"] = "{npc:5880}，森金的法師訓練師",

	-- Step 22: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "{npc:265809}的營火",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest · {zone:1454} Orgrimmar
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears. With a profession learned, {npc:265809} also offers its Camping 101, which its trainer takes: in {area:362} or in {zone:1454} at the start of the next guide."] = "{npc:265809}在{area:362}南邊紮營。坐在他的營火旁（/sit），直到出現{spell:1229451}增益效果。學會專業技能後，{npc:265809}也會提供他的露營入門，交給該專業的訓練師：在{area:362}，或在下一份指南開頭的{zone:1454}。",

	-- Step 23: Camping 101: Mining
	-- {npc:3175} Krunn · {skill:186} Mining
	["{npc:3175} takes it once your {skill:186} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "你的{skill:186}技能達到20後，{npc:3175}就會接收它：在那之前先採集或製作，指南會同時繼續進行。",
	-- {npc:265809} Brakk · {npc:3175} Krunn
	["{npc:265809}: for {npc:3175}"] = "{npc:265809}：交給{npc:3175}",

	-- Step 24: Camping 101: Engineering
	-- {npc:11025} Mukdrak · {skill:202} Engineering
	["{npc:11025} takes it once your {skill:202} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "你的{skill:202}技能達到20後，{npc:11025}就會接收它：在那之前先採集或製作，指南會同時繼續進行。",
	-- {npc:265809} Brakk · {npc:11025} Mukdrak
	["{npc:265809}: for {npc:11025}"] = "{npc:265809}：交給{npc:11025}",

	-- Step 25: Camping 101: First Aid
	-- {npc:5943} Rawrk · {skill:129} First Aid
	["{npc:5943} takes it once your {skill:129} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "你的{skill:129}技能達到20後，{npc:5943}就會接收它：在那之前先採集或製作，指南會同時繼續進行。",
	-- {npc:265809} Brakk · {npc:5943} Rawrk
	["{npc:265809}: for {npc:5943}"] = "{npc:265809}：交給{npc:5943}",

	-- Step 26: Camping 101: Skinning
	-- {npc:265809} Brakk
	["{npc:265809}: for Thuwd"] = "{npc:265809}：交給圖烏德",

	-- Step 27: Camping 101: Leatherworking
	-- {npc:265809} Brakk
	["{npc:265809}: for Karolek"] = "{npc:265809}：交給卡洛雷克",

	-- Step 28: Camping 101: Herbalism
	-- {npc:265809} Brakk
	["{npc:265809}: for Jandi"] = "{npc:265809}：交給詹蒂",

	-- Step 29: Camping 101: Enchanting
	-- {npc:265809} Brakk
	["{npc:265809}: for Jhag"] = "{npc:265809}：交給加格",

	-- Step 30: Camping 101: Alchemy
	-- {npc:265809} Brakk
	["{npc:265809}: for Whuut"] = "{npc:265809}：交給胡特",

	-- Step 31: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town; inside"] = "{npc:266940}，在鎮東側；裡面",

	-- Step 32: Razor Hill
	-- {npc:3191} Cook Torka
	["{npc:3191}: Camping 101 asks you to learn it"] = "",
	-- {npc:6928} Innkeeper Grosk
	["{npc:6928}, inside"] = "{npc:6928}，在裡面",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}，在瞭望塔裡",

	-- Step 36: Camping 101: Tailoring
	-- {npc:265809} Brakk
	["{npc:265809}: for Snang"] = "{npc:265809}：交給斯納恩",

	-- Step 37: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}."] = "城堡位於{area:362}東南方的海岸上。襲擊者的斧頭、弓和盾牌在城堡外圍。庫爾提拉斯水手和水兵會掉落{item:4870}。",

	-- Step 38: Level 7
	["Level 7"] = "等級7",
	-- {npc:3192} Lieutenant Benedict
	["Top up here to level 7 before {npc:3192} (8) and the marines at the top of the keep."] = "在挑戰城堡頂端的{npc:3192}（8級）和水兵之前，先在這裡練到7級。",
	-- {npc:3128} Kul Tiras Sailor
	["grind on {npc:3128}"] = "擊殺{npc:3128}練級",

	-- Step 39: Lieutenant Benedict
	-- {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["{npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "{npc:3192}在城堡頂端等候；他的鑰匙可以打開他旁邊的箱子，裡面有{item:4881}。",
	["Upstairs"] = "樓上",

	-- Step 40: Razor Hill
	-- {area:362} Razor Hill · {npc:3139} Gar'Thok · {npc:3147} Furl Scornbrow · {npc:3142} Orgnil Soulscar · {npc:266940} Turroc
	["Back north-west to {area:362}: {npc:3139} first, then {npc:3147} in the watchtower, then {npc:3142} and {npc:266940} on the way out east to the shore."] = "往西北回到{area:362}：先找{npc:3139}，再到瞭望塔裡的{npc:3147}，然後是往東去海岸路上的{npc:3142}和{npc:266940}。",
	-- {npc:266940} Turroc
	["{npc:266940}, inside"] = "{npc:266940}，在裡面",

	-- Step 41: Scuttle Coast: kill these as you meet them
	-- {area:373} Scuttle Coast
	["{area:373}: kill these as you meet them"] = "{area:373}：遇到就殺",
	-- {area:362} Razor Hill
	["The gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin.\nMakrura and surf crawlers line the beaches north-east of Sen'jin."] = "地精工具箱在{area:362}以東和東南沿岸的殘骸裡。沿海岸向南到森金村。\n龍蝦人和衝浪蟹分佈在森金村東北的海灘上。",
	["Underwater"] = "在水下",

	-- Step 42: Sen'jin Village
	-- {area:366} Kolkar Crag · {npc:3304} Master Vornal
	["Through Sen'jin on the way west to {area:366}: {npc:3304} takes the eyes and mucus now."] = "往西前往{area:366}的途中經過森金村：現在把眼睛和黏液交給{npc:3304}。",

	-- Step 43: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "{area:366}在森金村西邊。三份進攻計畫放在半人馬帳篷之間的地上。{npc:275811}也被關在峭壁那裡。",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "釋放{npc:275811}，並護送她安全離開峭壁",

	-- Step 44: Sen'jin Village
	-- {area:368} Echo Isles
	["Back east to Sen'jin on the way to the {area:368}."] = "往東回到森金村，前往{area:368}。",

	-- Step 45: Echo Isles: kill these as you meet them
	-- {area:368} Echo Isles
	["{area:368}: kill these as you meet them"] = "{area:368}：遇到就殺",
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there.\nDurotar Tigers roam the isle as well as the shore south of Sen'jin, and the Taillasher eggs sit in nests on the isles and along the beach."] = "涉水到北邊的回音群島。女族長在那裡的迅猛龍之間徘徊。\n杜洛塔猛虎在島上以及森金村南邊的海岸遊蕩，鞭尾蜥蜴的蛋就在群島上和海灘沿岸的巢裡。",

	-- Step 46: Level 9
	["Level 9"] = "等級9",
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll
	["Top up here to level 9 before the southern isles: the Voodoo and Hexed Trolls there are 8-9 and {quest:826} is 10."] = "前往南部島嶼之前，先在這裡練到9級：那裡的巫毒食人妖和妖術食人妖是8-9級，{quest:826}是10級。",
	-- {npc:3121} Durotar Tiger
	["grind on {npc:3121}"] = "擊殺{npc:3121}練級",

	-- Step 47: Echo Isles: kill these as you meet them
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant · Voodoo Trolls = {npc:3206} Voodoo Troll
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle.\nCareful: the trolls stand close together and the Voodoo Trolls cast from range: pull one at a time. {quest:826} himself is level 10."] = "向南穿過群島。洛阿神像遍布南部島嶼；巫毒食人妖和妖術食人妖守著它們，並掉落妖術墜飾。{quest:826}和明希納的囚籠在最南端的島上。\n小心：食人妖站得很近，巫毒食人妖會遠程施法：一次拉一隻。{quest:826}本人是10級。",

	-- Step 48: Deathskip to Sen'jin Village
	-- {area:367} Sen'jin Village
	["Deathskip to {area:367}"] = "死亡跳過到{area:367}",
	-- {npc:3206} Voodoo Troll · {npc:6491} Spirit Healer
	["Die to the mobs at 66.9,87.2 ({npc:3206}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "在66.9,87.2（{npc:3206}）處死在怪物手裡：在那裡死亡會把你送到這個墓地。釋放靈魂，接受{npc:6491}的復活。",

	-- Step 51: Level 10
	["Level 10"] = "10級",
	-- {area:362} Razor Hill · {quest:96825} This Fruit Could Bite Back
	-- plural, as words: Razormane Battleguards = {npc:3114} Razormane Battleguard
	["Train at {area:362} at level 10 before facing the Razormane Battleguards (9-10).\nThe prickly pears for {quest:96825} grow by these huts: pick them while you grind."] = "",
	-- {npc:3111} Razormane Quilboar
	["grind on {npc:3111}"] = "刷{npc:3111}",

	-- Step 52: Razor Hill
	-- {npc:3169} Tarshaw Jaggedscar
	["{npc:3169}, inside"] = "{npc:3169}，在裡面",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}，在旅店旁",

	-- Step 53: Far Watch Post
	-- {area:814} Southfury River · {npc:3337} Kargal Battlescar · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge: {npc:3337} stands at {area:379} above it, on your way to {npc:5907}."] = "向西過{area:814}橋：{npc:3337}站在橋上方的{area:379}，就在去找{npc:5907}的路上。",

	-- Step 58: Kranal Fiss
	-- {area:814} Southfury River · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge, past {area:379} and on along the ridge: {npc:5907} stands alone above the Razormane camp."] = "向西過{area:814}橋，經過{area:379}沿山脊繼續走：{npc:5907}獨自站在鋼鬃營地之上。",

	-- Step 59: Telf Joolam
	-- {zone:1411} Durotar · {npc:5900} Telf Joolam
	["Back over the bridge and south along the {zone:1411} bank of the river to where a narrow trail climbs the mountain: {npc:5900} keeps the shrine at the top. Mind the edges on the way up, and come back down the same trail."] = "返回橋的另一邊，沿河流的{zone:1411}一岸向南，找到一條上山的狹窄小徑：{npc:5900}守著山頂的神龕。上山時小心邊緣，並沿原路下來。",

	-- Step 60: Razormane Grounds
	["Quilboars and scouts hold the huts west of town, where the prickly pears grow; dustrunners and battleguards hold the camps farther west."] = "鋼鬃野豬人和鋼鬃斥候佔據城鎮西邊長著仙人掌果的小屋；鋼鬃傳令兵和鋼鬃衛兵佔據更西邊的營地。",

	-- Step 61: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Head north-east to the road toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "向東北到通往{zone:1454}的路上。{npc:3293}在路邊紮營；被偷的麻袋散落在他以南的路邊。",

	-- Step 62: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb · {area:371} Dustwind Cave · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}. Shamans: the Burning Blade Cultists by {area:371}, at the ravine's south end, drop the {item:6652}."] = "野蠻人和風暴女巫盤踞在{npc:3293}以東的{area:370}。風暴女巫會掉{item:277661}。薩滿注意：峽谷南端{area:371}旁的火刃教徒掉{item:6652}。",

	-- Step 63: Deathskip to Northern Durotar
	["Deathskip to Northern Durotar"] = "死亡跳過到北杜洛塔",
	-- {npc:3118} Dustwind Storm Witch · {npc:6491} Spirit Healer
	["Die to the mobs at 52.0,21.4 ({npc:3118}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "在52.0,21.4（{npc:3118}）處死在怪物手裡：在那裡死亡會把你送到這個墓地。釋放靈魂，接受{npc:6491}的復活。",

	-- Step 66: Thunder Ridge: kill these as you meet them
	-- {area:369} Thunder Ridge
	["{area:369}: kill these as you meet them"] = "{area:369}：遇到就殺",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "雷霆蜥蜴和閃電蜥蜴在{npc:3293}西邊及西南邊不遠處的{area:369}吃草。\n小心：12級精英哈利寇在{area:369}的蜥蜴群中遊蕩：拉怪前先留意他的位置。",

	-- Step 68: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "米莎的小屋在蜥蜴的南邊。西邊{area:814}沿岸的鱷魚身上帶著{item:4891}。",

	-- Step 69: Level 11
	["Level 11"] = "等級11",
	-- {npc:3203} Fizzle Darkstorm · {area:369} Thunder Ridge
	["Fight the Razormane south of Misha's hut until level 11, then return for {npc:3203} (12).\nCareful: Halikor (12 elite) patrols the lizard grounds on {area:369}. Stay off the ridge while you grind."] = "",
	-- {npc:3114} Razormane Battleguard
	["grind on {npc:3114}"] = "",

	-- Step 70: Fizzle Darkstorm
	-- {area:369} Thunder Ridge · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	["Fizzle holds the Burning Blade camp on {area:369}, just north of Misha's hut. Hunters: tame a {npc:3099} with the {item:15908} on the way.\nCareful: Burning Blade cultists surround Fizzle, some linked so they aggro in pairs, and they respawn quickly.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "費索占據著{area:369}上的燃燒之刃營地，就在米莎小屋北邊。獵人：途中用{item:15908}馴服一隻{npc:3099}。\n小心：費索周圍有燃燒之刃信徒，有些兩兩相連，會一起進入戰鬥，而且重生很快。\n小心：12級精英哈利寇在{area:369}的蜥蜴群中遊蕩：拉怪前先留意他的位置。",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "用{item:15908}馴服牠",

	-- Step 71: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657}站在{area:362}東邊的岸上。三叉戟、旗幟和匕首散落在他周圍的海灘上。",

	-- Step 73: Paladin trainer
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:362} Razor Hill
	["{npc:246344} in {zone:1456}; {area:362} has no paladin trainer"] = "{npc:246344}在{zone:1456}；{area:362}沒有聖騎士訓練師",

	-- Step 74: Druid trainer
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:362} Razor Hill
	["{npc:3034} in {zone:1412}; {area:362} has no druid trainer"] = "{npc:3034}在{zone:1412}；{area:362}沒有德魯伊訓練師",

	-- Step 75: Razor Hill
	-- {area:362} Razor Hill · {npc:3139} Gar'Thok · {npc:3142} Orgnil Soulscar
	["Back to {area:362}: {npc:3139}, then {npc:3142}."] = "回到{area:362}：先{npc:3139}，再{npc:3142}。",

	-- Step 76: Spitelash naga
	["Spitelash naga"] = "惡鞭納迦",
	-- {area:370} Drygulch Ravine · {npc:275657} Heglan Shadeeye · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["North-east to the beach below {area:370}, north of {npc:275657}: Spitelash Scouts and Attendants hold it. Hunters: tame a {npc:3107} on the beach."] = "向東北前往{area:370}下方、{npc:275657}北邊的海灘：惡鞭斥候和惡鞭侍從佔據那裡。獵人：在海灘上馴服一隻{npc:3107}。",

	-- Step 77: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828}在納迦海灘西邊的山丘上紮營，位於{quest:827}南邊。",

	-- Step 79: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "{zone:1454}的正門就在{area:817}西邊。{npc:5875}站在{object:172960}，就是{object:172982}下方的峽谷。",

	-- Step 80: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "在這裡時：找{npc:2704}（{object:172958}，10銀）學習法杖；升級期間法杖比單手武器提供更多法術屬性。",

	-- Step 81: Back to Durotar
	-- {zone:1411} Durotar
	["Back to {zone:1411}"] = "返回{zone:1411}",

	-- Step 82: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "{area:817}入口",

	-- Step 83: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}.\nCareful: voidwalkers fight beside the Burning Blade cultists in {quest:827} and {npc:3204} (14) waits at the back with his own: pull one cultist at a time near the entrance for the collars. The {item:4903} is optional: leave {npc:3204} unless you are 13 or have a friend."] = "燃刃氏族的教徒佔據{quest:827}的洞穴；他們都會掉落{item:4871}。{npc:3204}是14級的術士，站在深處，會掉落{item:4903}。\n小心：在{quest:827}裡，虛空行者與燃刃氏族的教徒並肩作戰，{npc:3204}（14級）帶著他自己的虛空行者在最裡面等著：在入口附近一次拉一個教徒來收集項圈。{item:4903}是可選的：除非你已經13級或有朋友同行，否則別碰{npc:3204}。",

	-- Step 84: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "{object:58595}在{area:817}裡，就在你剛才打過的教徒之間。",

	-- Step 86: Razor Hill
	-- {area:362} Razor Hill
	["Back to {area:362}."] = "回到{area:362}。",

	-- Step 87: Razor Hill
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}：{npc:275666}，一個精英海巨人",

	-- Step 88: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "{npc:275666} 是一名年輕的海巨人，在納迦海灘以北、{zone:1411} 的北海岸來回走動。{npc:275666} 是精英：建議組隊。",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}，回到{area:362}",

	-- Step 89: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "硬甲蠍在{area:362}西邊的平原上爬行。馴服一隻，然後回到{npc:3171}那裡。",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "{npc:3171}：{zone:1454}的{npc:3352}教{spell:5149}",

	-- Step 90: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {npc:3337} Kargal Battlescar · {npc:5810} Uzzek · {area:379} Far Watch Post · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["West from {area:362} over the {area:814} bridge: {npc:3337} and {npc:5810} stand together at {area:379} above it. From there the road north through {zone:1411} leads to {zone:1454}."] = "從 {area:362} 向西，過 {area:814} 的橋：{npc:3337} 和 {npc:5810} 一起站在橋上方的 {area:379}。從那裡沿路向北，穿過 {zone:1411} 即可到 {zone:1454}。",

	-- Step 91: Thunder lizards on the way north
	["Thunder lizards on the way north"] = "北上途中的雷霆蜥蜴",
	-- {area:369} Thunder Ridge · {zone:1454} Orgrimmar · {item:6486} Singed Scale · {npc:5810} Uzzek · {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, beside the road north to {zone:1454}; any of them can drop a {item:6486}. {npc:5810} takes it when the next guide passes {area:379}.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "雷霆蜥蜴和閃電蜥蜴在{area:369}吃草，就在往北到{zone:1454}的路旁；任何一隻都可能掉落{item:6486}。下一篇指南經過{area:379}時，把它交給{npc:5810}。\n小心：12級精英哈利寇在{area:369}的蜥蜴群中遊蕩：拉怪前先留意他的位置。",

	-- Step 93: Ormak Grimshot
	-- {area:379} Far Watch Post · {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor
	["Follow the road north from {area:379} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "沿著道路從{area:379}向北前往{zone:1454}的正門，就在{area:817}西邊。{npc:3352}和獵人訓練師們站在{object:172958}。",

	-- Step 94: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "在這裡時：找{npc:2704}（{object:172958}，10銀）學習法杖；獵人的近戰武器主要看屬性，雙手武器屬性最多。",

	-- Step 95: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "前往{zone:1454}",
	-- {area:379} Far Watch Post · {zone:1454} Orgrimmar · {quest:829} Neeru Fireblade · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Follow the road north from {area:379} to {zone:1454}'s main gate. The next guide starts in {zone:1454}: {quest:829} takes the cultists' quest, the trainers teach your new ranks, and the zeppelin leaves from the towers outside the gate for {zone:1420} and {zone:1421}. {zone:1413} come after Silverpine."] = "從 {area:379} 沿路向北到 {zone:1454} 正門。下一篇指南從 {zone:1454} 開始：將邪教徒任務交給 {quest:829}，向訓練師學習新等級技能，再從城門外的飛艇塔乘飛艇前往 {zone:1420} 和 {zone:1421}。銀松森林之後再去 {zone:1413}。",
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "{zone:1454}的{object:172982}",

	-- Step 96: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {item:6535} Tablet of Verga · {item:7464} Glyphs of Summoning · {zone:1454} Orgrimmar
	["{npc:5875} stands in the {object:172960}, the canyon under the {object:172982}. Hand him the {item:6535}, then use the {item:7464} on the summoning circle beside him and defeat the voidwalker to bind it.\nCareful: the voidwalker you summon hits hard and it is the fight Warlocks die to most in {zone:1454}: start at full health and mana, send your imp in, keep Corruption and Immolate on it, and use a healthstone if you have one."] = "{npc:5875}站在{object:172960}，也就是{object:172982}下方的峽谷。把{item:6535}交給他，然後在他旁邊的召喚法陣使用{item:7464}，擊敗虛空行者以束縛它。\n小心：召喚出的虛空行者攻擊很痛，這是術士在{zone:1454}最常陣亡的一場戰鬥：滿血滿魔再開始，先派小鬼上去，在牠身上保持腐蝕術和獻祭，有治療石就用。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to {area:362}."] = "向南回到{area:362}。",
	-- ["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "回到{object:172960}找{npc:5875}。在那裡的召喚法陣使用{item:7464}，擊敗虛空行者以束縛它。",
	-- ["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle."] = "向南穿過群島。洛阿神像遍布南部島嶼；巫毒食人妖和被施妖術的食人妖守著它們，並掉落妖術墜飾。{quest:826}和明希納的囚籠在最南端的島上。",
	-- ["Prickly pears"] = "仙人掌果",
	-- ["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "鋼鬃野豬人和鋼鬃斥候佔據城鎮西邊的小屋；鋼鬃傳令兵和鋼鬃衛兵佔據更西邊的營地。",
	-- ["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "城堡位於{area:362}東南方的海岸上。襲擊者的斧頭、弓和盾牌在城堡外圍。庫爾提拉斯水手和水兵會掉落{item:4870}。{npc:3192}在城堡頂端等候；他的鑰匙可以打開他旁邊的箱子，裡面有{item:4881}。",
	-- ["The prickly pears grow among the quilboar huts just west of town."] = "仙人掌果生長在城鎮西邊的野豬人小屋之間。",
	-- ["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "雷霆蜥蜴和閃電蜥蜴在橋對面的{area:369}吃草；牠們都可能掉落{item:6486}。",
	-- ["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}.\nFizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way.\nCareful: Burning Blade cultists surround Fizzle, some linked so they aggro in pairs, and they respawn quickly.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "雷霆蜥蜴和閃電蜥蜴在{npc:3293}西邊及西南邊不遠處的{area:369}吃草。\n費索占據著{area:362}西北方{area:369}的火刃營地。獵人：途中用{item:15908}馴服一隻{npc:3099}。\n小心：費索周圍有火刃祭司，有些兩兩相連，會一起進入戰鬥，而且重生很快。\n小心：12級精英哈利寇在{area:369}的蜥蜴群中遊蕩：拉怪前先留意他的位置。",
	-- ["Thunder lizards across the river"] = "河對岸的雷霆蜥蜴",
	-- ["Top up here to level 10: {quest:840}, at {area:362}, needs level 10.\nThe prickly pears for {quest:96825} grow by these huts: pick them while you grind."] = "在這裡練到10級：位於{area:362}的{quest:840}需要10級。\n{quest:96825}要的仙人掌果長在這些小屋旁：練功時順便採。",
	-- ["Top up here to level 11 before {npc:3203} (12) and his imp: the Thunder Lizards (9-10) graze on the ridge just west of Misha's hut."] = "挑戰{npc:3203}（12級）和他的小鬼前，先在這裡練到11級：雷霆蜥蜴（9-10級）在米莎小屋西邊不遠的山脊上吃草。",
	-- ["With {skill:129} learned, {npc:265809} also offers its Camping 101: {npc:5943} in {area:362} takes it."] = "學會{skill:129}後，{npc:265809}也會提供他的露營入門：交給{area:362}的{npc:5943}。",
	-- ["With {skill:165} learned, {npc:265809} also offers its Camping 101: {npc:3365} in {zone:1454} (next guide) takes it."] = "學會{skill:165}後，{npc:265809}也會提供他的露營入門：交給{zone:1454}的{npc:3365}（下一份指南）。",
	-- ["With {skill:171} learned, {npc:265809} also offers its Camping 101: {npc:11046} in {zone:1454} (next guide) takes it."] = "學會{skill:171}後，{npc:265809}也會提供他的露營入門：交給{zone:1454}的{npc:11046}（下一份指南）。",
	-- ["With {skill:182} learned, {npc:265809} also offers its Camping 101: {npc:3404} in {zone:1454} (next guide) takes it."] = "學會{skill:182}後，{npc:265809}也會提供他的露營入門：交給{zone:1454}的{npc:3404}（下一份指南）。",
	-- ["With {skill:186} learned, {npc:265809} also offers its Camping 101: {npc:3175} in {area:362} takes it."] = "學會{skill:186}後，{npc:265809}也會提供他的露營入門：交給{area:362}的{npc:3175}。",
	-- ["With {skill:197} learned, {npc:265809} also offers its Camping 101: {npc:2855} in {zone:1454} (next guide) takes it."] = "學會{skill:197}後，{npc:265809}也會提供他的露營入門：交給{zone:1454}的{npc:2855}（下一份指南）。",
	-- ["With {skill:202} learned, {npc:265809} also offers its Camping 101: {npc:11025} in {area:362} takes it."] = "學會{skill:202}後，{npc:265809}也會提供他的露營入門：交給{area:362}的{npc:11025}。",
	-- ["With {skill:333} learned, {npc:265809} also offers its Camping 101: {npc:11066} in {zone:1454} (next guide) takes it."] = "學會{skill:333}後，{npc:265809}也會提供他的露營入門：交給{zone:1454}的{npc:11066}（下一份指南）。",
	-- ["With {skill:393} learned, {npc:265809} also offers its Camping 101: {npc:7088} in {zone:1454} (next guide) takes it."] = "學會{skill:393}後，{npc:265809}也會提供他的露營入門：交給{zone:1454}的{npc:7088}（下一份指南）。",
	-- ["grind on {npc:3130}"] = "擊殺{npc:3130}練級",
	-- ["{npc:265809}: for {npc:11046}"] = "{npc:265809}：交給{npc:11046}",
	-- ["{npc:265809}: for {npc:11066}"] = "{npc:265809}：交給{npc:11066}",
	-- ["{npc:265809}: for {npc:2855}"] = "{npc:265809}：交給{npc:2855}",
	-- ["{npc:265809}: for {npc:3365}"] = "{npc:265809}：交給{npc:3365}",
	-- ["{npc:265809}: for {npc:3404}"] = "{npc:265809}：交給{npc:3404}",
	-- ["{npc:265809}: for {npc:7088}"] = "{npc:265809}：交給{npc:7088}",
}
