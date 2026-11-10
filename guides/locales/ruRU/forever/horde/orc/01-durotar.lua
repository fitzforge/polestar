-- Russian (ruRU): the guide forever/horde/orc/01-durotar (forever/horde/orc/01-durotar.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143} ждет внутри Логова – здания чуть к западу от персонажа {npc:10176}.",
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}, там, где вы начинаете",
	["Inside"] = "Внутри",

	-- Step 2: Training weapons and boars
	["Training weapons and boars"] = "Учебное оружие и вепри",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "Оружие лежит вокруг Логова и тренировочной площадки; пятнистые вепри бродят по всей долине.",

	-- Step 3: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143} стоит сразу у входа в пещеру; {npc:3159} – в глубине пещеры за ним.",
	-- {npc:3143} Gornek
	["{npc:3143}, inside"] = "",
	-- {npc:3156} Nartok
	["{npc:3156}, the warlock trainer at the back of the cave"] = "{npc:3156}, учитель чернокнижников, в глубине пещеры",
	-- {npc:3155} Rwag
	["{npc:3155}, the rogue trainer in the Den"] = "{npc:3155}, учитель разбойников, в Логове",
	-- {npc:3153} Frang
	["{npc:3153}, the warrior trainer beside the Den"] = "{npc:3153}, учитель воинов, у Логова",
	-- {npc:3154} Jen'shan
	["{npc:3154}, the hunter trainer beside the Den"] = "{npc:3154}, учитель охотников, у Логова",
	-- {npc:3157} Shikrik
	["{npc:3157}, the shaman trainer beside the Den"] = "{npc:3157}, учитель шаманов, у Логова",
	-- {npc:5884} Mai'ah
	["{npc:5884}, the mage trainer, at the entrance to the Den"] = "{npc:5884}, учитель магов, у входа в Логово",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave; below ground"] = "",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}, у костра для готовки",

	-- Step 4: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287} лежит раненый у подножия холмов к северо-западу от Логова.",

	-- Step 5: Valley of Trials: kill these as you meet them
	-- {area:363} Valley of Trials
	["{area:363}: kill these as you meet them"] = "",
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua · {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["{quest:790}, a large scorpid, prowls the slope south of {npc:3287} among the Scorpid Workers; pick the Cactus Apples by the cactuses on the way.\nThe {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "",

	-- Step 6: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 7: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:363} Valley of Trials
	["{npc:246344} in {zone:1456}; {area:363} has no paladin trainer"] = "",

	-- Step 8: Druid trainer
	["Druid trainer"] = "Учитель друидов",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:363} Valley of Trials
	["{npc:3034} in {zone:1412}; {area:363} has no druid trainer"] = "",

	-- Step 9: Back to the Den
	["Back to the Den"] = "Назад к Логову",
	-- {npc:11378} Foreman Thazz'ril
	["{npc:11378}, at the lumber pile east of the Den"] = "",

	-- Step 10: Lazy Peons
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "Разбудите батраков ({quest:5441}) предметом {item:16114}",

	-- Step 13: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "В пещере на первой развилке идите прямо, затем направо и вдоль ручья слева до водопада: кирка светится у воды, за каменной колонной.",

	-- Step 14: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "В пещере держитесь правой стены по всему кругу, через ручей: {npc:3183} ждет в конце.",
	["Below ground"] = "",

	-- Step 15: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "Копыта: {npc:3102}",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "Ловцы Скверны бродят по склону под пещерой, на северной стороне долины.",

	-- Step 16: Back to the Den
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "{object:654925} на земле рядом с ней",

	-- Step 17: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887} стоит у Логова. {area:639} – холм чуть к югу: выпейте там {item:6635}, чтобы увидеть персонажа {npc:5891}, затем отнесите предмет {item:6656} {npc:5887}.",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}, ориентир: {area:639}",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}: {npc:5873} и ваш {item:5175}",

	-- Step 18: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786} стоит на дороге у восточного выхода из долины.",

	-- Step 19: Sen'jin Village
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}: только для зачарователей – остаток получают, распыляя проклятые подвески",
	-- {npc:5880} Un'Thuwa
	["{npc:5880}, the mage trainer in Sen'jin"] = "",

	-- Step 20: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "Костер: {npc:265809}",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears."] = "",

	-- Step 21: Camping 101: Mining
	-- {skill:186} Mining · {npc:265809} Brakk · {npc:3175} Krunn · {area:362} Razor Hill
	["With {skill:186} learned, {npc:265809} also offers its Camping 101: {npc:3175} in {area:362} takes it."] = "Если вы освоили навык {skill:186}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:3175}, место: {area:362}.",
	-- {npc:265809} Brakk · {npc:3175} Krunn
	["{npc:265809}: for {npc:3175}"] = "{npc:265809}: для персонажа {npc:3175}",

	-- Step 22: Camping 101: Engineering
	-- {skill:202} Engineering · {npc:265809} Brakk · {npc:11025} Mukdrak · {area:362} Razor Hill
	["With {skill:202} learned, {npc:265809} also offers its Camping 101: {npc:11025} in {area:362} takes it."] = "Если вы освоили навык {skill:202}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:11025}, место: {area:362}.",
	-- {npc:265809} Brakk · {npc:11025} Mukdrak
	["{npc:265809}: for {npc:11025}"] = "{npc:265809}: для персонажа {npc:11025}",

	-- Step 23: Camping 101: First Aid
	-- {skill:129} First Aid · {npc:265809} Brakk · {npc:5943} Rawrk · {area:362} Razor Hill
	["With {skill:129} learned, {npc:265809} also offers its Camping 101: {npc:5943} in {area:362} takes it."] = "Если вы освоили навык {skill:129}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:5943}, место: {area:362}.",
	-- {npc:265809} Brakk · {npc:5943} Rawrk
	["{npc:265809}: for {npc:5943}"] = "{npc:265809}: для персонажа {npc:5943}",

	-- Step 24: Camping 101: Skinning
	-- {skill:393} Skinning · {npc:265809} Brakk · {npc:7088} Thuwd · {zone:1454} Orgrimmar
	["With {skill:393} learned, {npc:265809} also offers its Camping 101: {npc:7088} in {zone:1454} (next guide) takes it."] = "Если вы освоили навык {skill:393}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:7088}, место: {zone:1454} (следующее руководство).",
	-- {npc:265809} Brakk · {npc:7088} Thuwd
	["{npc:265809}: for {npc:7088}"] = "{npc:265809}: для персонажа {npc:7088}",

	-- Step 25: Camping 101: Leatherworking
	-- {skill:165} Leatherworking · {npc:265809} Brakk · {npc:3365} Karolek · {zone:1454} Orgrimmar
	["With {skill:165} learned, {npc:265809} also offers its Camping 101: {npc:3365} in {zone:1454} (next guide) takes it."] = "Если вы освоили навык {skill:165}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:3365}, место: {zone:1454} (следующее руководство).",
	-- {npc:265809} Brakk · {npc:3365} Karolek
	["{npc:265809}: for {npc:3365}"] = "{npc:265809}: для персонажа {npc:3365}",

	-- Step 26: Camping 101: Tailoring
	-- {skill:197} Tailoring · {npc:265809} Brakk · {npc:2855} Snang · {zone:1454} Orgrimmar
	["With {skill:197} learned, {npc:265809} also offers its Camping 101: {npc:2855} in {zone:1454} (next guide) takes it."] = "Если вы освоили навык {skill:197}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:2855}, место: {zone:1454} (следующее руководство).",
	-- {npc:265809} Brakk · {npc:2855} Snang
	["{npc:265809}: for {npc:2855}"] = "{npc:265809}: для персонажа {npc:2855}",

	-- Step 27: Camping 101: Herbalism
	-- {skill:182} Herbalism · {npc:265809} Brakk · {npc:3404} Jandi · {zone:1454} Orgrimmar
	["With {skill:182} learned, {npc:265809} also offers its Camping 101: {npc:3404} in {zone:1454} (next guide) takes it."] = "Если вы освоили навык {skill:182}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:3404}, место: {zone:1454} (следующее руководство).",
	-- {npc:265809} Brakk · {npc:3404} Jandi
	["{npc:265809}: for {npc:3404}"] = "{npc:265809}: для персонажа {npc:3404}",

	-- Step 28: Camping 101: Enchanting
	-- {skill:333} Enchanting · {npc:265809} Brakk · {npc:11066} Jhag · {zone:1454} Orgrimmar
	["With {skill:333} learned, {npc:265809} also offers its Camping 101: {npc:11066} in {zone:1454} (next guide) takes it."] = "Если вы освоили навык {skill:333}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:11066}, место: {zone:1454} (следующее руководство).",
	-- {npc:265809} Brakk · {npc:11066} Jhag
	["{npc:265809}: for {npc:11066}"] = "{npc:265809}: для персонажа {npc:11066}",

	-- Step 29: Camping 101: Alchemy
	-- {skill:171} Alchemy · {npc:265809} Brakk · {npc:11046} Whuut · {zone:1454} Orgrimmar
	["With {skill:171} learned, {npc:265809} also offers its Camping 101: {npc:11046} in {zone:1454} (next guide) takes it."] = "Если вы освоили навык {skill:171}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:11046}, место: {zone:1454} (следующее руководство).",
	-- {npc:265809} Brakk · {npc:11046} Whuut
	["{npc:265809}: for {npc:11046}"] = "{npc:265809}: для персонажа {npc:11046}",

	-- Step 30: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town; inside"] = "",

	-- Step 31: Razor Hill
	-- {npc:3191} Cook Torka
	["{npc:3191}: Camping 101 asks you to learn it"] = "",
	-- {npc:6928} Innkeeper Grosk
	["{npc:6928}, inside"] = "",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}, в сторожевой башне",

	-- Step 35: Prickly pears
	["Prickly pears"] = "Колючие груши",
	["The prickly pears grow among the quilboar huts just west of town."] = "Колючие груши растут среди хижин свинобразов чуть к западу от городка.",

	-- Step 37: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps · {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "Крепость стоит на побережье к юго-востоку от места {area:362}. Топор, лук и щит налетчиков лежат на ее окраинах. {item:4870} падает с моряков и стражей бухты. {npc:3192} ждет на вершине крепости; его ключ открывает сундук рядом, в нем – {item:4881}.",
	["Upstairs"] = "",

	-- Step 38: Razor Hill
	-- {area:362} Razor Hill · {npc:3139} Gar'Thok · {npc:3147} Furl Scornbrow · {npc:3142} Orgnil Soulscar · {npc:266940} Turroc
	["Back north-west to {area:362}: {npc:3139} first, then {npc:3147} in the watchtower, then {npc:3142} and {npc:266940} on the way out east to the shore."] = "Вернитесь на северо-запад в {area:362}: сначала {npc:3139}, затем {npc:3147} на сторожевой башне, потом {npc:3142} и {npc:266940} по пути на восток к побережью.",
	-- {npc:266940} Turroc
	["{npc:266940}, inside"] = "",

	-- Step 39: Scuttle Coast: kill these as you meet them
	-- {area:373} Scuttle Coast
	["{area:373}: kill these as you meet them"] = "",
	-- {area:362} Razor Hill
	["The gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin.\nMakrura and surf crawlers line the beaches north-east of Sen'jin."] = "Гномские ящики с инструментами лежат среди обломков на побережье к востоку и юго-востоку от {area:362}. Идите вдоль берега на юг к Сен'джину.\nМакруры и прибойные ползуны встречаются на пляжах к северо-востоку от Сен'джина.",
	["Underwater"] = "",

	-- Step 40: Echo Isles: kill these as you meet them
	-- {area:368} Echo Isles
	["{area:368}: kill these as you meet them"] = "",
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there.\nDurotar Tigers roam the isle as well as the shore south of Sen'jin, and the Taillasher eggs sit in nests on the isles and along the beach."] = "Переберитесь вброд на северный остров Эха. Там среди ящеров бродит Матриарх.\nТигры Дуротара бродят по острову, а также по берегу к югу от Сен'джина, а яйца хлыстохвостов лежат в гнездах на островах и вдоль пляжа.",

	-- Step 41: Echo Isles: kill these as you meet them
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle."] = "Двигайтесь на юг через острова. Идолы Лоа лежат по всем южным островам; их охраняют тролли-вудуисты и проклятые тролли, с них падают проклятые подвески. {quest:826} и клетка Миншины – на самом южном острове.",

	-- Step 42: Deathskip to Sen'jin Village
	-- {area:367} Sen'jin Village
	["Deathskip to {area:367}"] = "",
	-- {npc:3206} Voodoo Troll · {npc:6491} Spirit Healer
	["Die to the mobs at 66.9,87.2 ({npc:3206}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "",

	-- Step 44: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "{area:366} – к западу от Сен'джина. Три плана атаки лежат на земле среди шатров кентавров. {npc:275811} тоже в плену на утесе.",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "Освободите персонажа {npc:275811} и выведите ее с утеса",

	-- Step 47: Level 10
	["Level 10"] = "",
	-- {quest:840} Conscript of the Horde · {area:362} Razor Hill
	["Top up here to level 10: {quest:840}, at {area:362}, needs level 10."] = "",
	-- {npc:3111} Razormane Quilboar
	["grind on {npc:3111}"] = "",

	-- Step 48: Razor Hill
	-- {npc:3169} Tarshaw Jaggedscar
	["{npc:3169}, inside"] = "",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}, у таверны",

	-- Step 49: Far Watch Post
	-- {area:814} Southfury River · {npc:3337} Kargal Battlescar · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge: {npc:3337} stands at {area:379} above it, on your way to {npc:5907}."] = "",

	-- Step 54: Kranal Fiss
	-- {area:814} Southfury River · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge, past {area:379} and on along the ridge: {npc:5907} stands alone above the Razormane camp."] = "",

	-- Step 55: Telf Joolam
	-- {zone:1411} Durotar · {npc:5900} Telf Joolam
	["Back over the bridge and south along the {zone:1411} bank of the river to where a narrow trail climbs the mountain: {npc:5900} keeps the shrine at the top. Mind the edges on the way up, and come back down the same trail."] = "",

	-- Step 56: Razormane Grounds
	["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "Свинобразы и разведчики занимают хижины к западу от городка; пылебеги и боевые стражи – лагеря дальше к западу.",

	-- Step 57: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Head north-east to the road toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "",

	-- Step 58: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb · {area:371} Dustwind Cave · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}. Shamans: the Burning Blade Cultists by {area:371}, at the ravine's south end, drop the {item:6652}."] = "",

	-- Step 59: Deathskip to Northern Durotar
	["Deathskip to Northern Durotar"] = "",
	-- {npc:3118} Dustwind Storm Witch · {npc:6491} Spirit Healer
	["Die to the mobs at 52.0,21.4 ({npc:3118}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "",

	-- Step 61: Thunder Ridge: kill these as you meet them
	-- {area:369} Thunder Ridge
	["{area:369}: kill these as you meet them"] = "",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}.\nFizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way.\nCareful: Burning Blade cultists surround Fizzle, some linked so they aggro in pairs, and they respawn quickly."] = "",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Приручите его предметом {item:15908}",

	-- Step 62: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "Хижина Майши – к югу от ящеров. {item:4891} – у кроколисков вдоль реки ({area:814}) к западу.",

	-- Step 64: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657} стоит на берегу к востоку от места {area:362}. Трезубец, знамя и кинжал лежат на пляже вокруг него.",

	-- Step 66: Paladin trainer
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:362} Razor Hill
	["{npc:246344} in {zone:1456}; {area:362} has no paladin trainer"] = "",

	-- Step 67: Mage trainer
	["Mage trainer"] = "",
	-- {npc:5884} Mai'ah · {zone:1411} Durotar · {area:362} Razor Hill
	["{npc:5884} in {zone:1411}; {area:362} has no mage trainer"] = "",

	-- Step 68: Druid trainer
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:362} Razor Hill
	["{npc:3034} in {zone:1412}; {area:362} has no druid trainer"] = "",

	-- Step 69: Razor Hill
	-- {area:362} Razor Hill · {npc:3139} Gar'Thok · {npc:3142} Orgnil Soulscar
	["Back to {area:362}: {npc:3139}, then {npc:3142}."] = "",

	-- Step 70: Spitelash naga
	["Spitelash naga"] = "Наги Бича Злобы",
	-- {area:370} Drygulch Ravine · {npc:275657} Heglan Shadeeye · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["North-east to the beach below {area:370}, north of {npc:275657}: Spitelash Scouts and Attendants hold it. Hunters: tame a {npc:3107} on the beach."] = "",

	-- Step 71: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828} стоит лагерем на холме к западу от пляжа наг, к югу от места {quest:827}.",

	-- Step 73: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "Главные ворота ({zone:1454}) – чуть к западу от места {area:817}. {npc:5875} стоит здесь: {object:172960} – каньон под местом {object:172982}.",

	-- Step 74: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 75: Back to Durotar
	-- {zone:1411} Durotar
	["Back to {zone:1411}"] = "",

	-- Step 76: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "Вход: {area:817}",

	-- Step 77: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}."] = "Культисты (Пылающий Клинок) занимают пещеры ({quest:827}); {item:4871} падает с любого. {npc:3204}, чернокнижник 14-го уровня, стоит в глубине, с него падает {item:4903}.",

	-- Step 78: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "{object:58595} стоит здесь: {area:817}, среди культистов, с которыми вы только что бились.",

	-- Step 80: Razor Hill
	-- {area:362} Razor Hill
	["Back to {area:362}."] = "Назад сюда: {area:362}.",

	-- Step 81: Razor Hill
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}: {npc:275666}, элитный морской великан",

	-- Step 82: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}, снова здесь: {area:362}",

	-- Step 83: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "Бронескорпы ползают по равнинам к западу от места {area:362}. Приручите одного, затем вернитесь к персонажу {npc:3171}.",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "",

	-- Step 84: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {npc:3337} Kargal Battlescar · {npc:5810} Uzzek · {area:379} Far Watch Post · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["West from {area:362} over the {area:814} bridge: {npc:3337} and {npc:5810} stand together at {area:379} above it. From there the road north through {zone:1411} leads to {zone:1454}."] = "",

	-- Step 85: Thunder lizards on the way north
	["Thunder lizards on the way north"] = "",
	-- {area:369} Thunder Ridge · {zone:1454} Orgrimmar · {item:6486} Singed Scale · {npc:5810} Uzzek · {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, beside the road north to {zone:1454}; any of them can drop a {item:6486}. {npc:5810} takes it when the next guide passes {area:379}."] = "",

	-- Step 87: Ormak Grimshot
	-- {area:379} Far Watch Post · {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor
	["Follow the road north from {area:379} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "",

	-- Step 88: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 89: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "В {zone:1454}",
	-- {area:379} Far Watch Post · {zone:1454} Orgrimmar · {quest:829} Neeru Fireblade · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Follow the road north from {area:379} to {zone:1454}'s main gate. The next guide starts in {zone:1454}: {quest:829} takes the cultists' quest, the trainers teach your new ranks, and the zeppelin leaves from the towers outside the gate for {zone:1420} and {zone:1421}. {zone:1413} come after Silverpine."] = "",
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "",

	-- Step 90: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {item:6535} Tablet of Verga · {item:7464} Glyphs of Summoning
	["{npc:5875} stands in the {object:172960}, the canyon under the {object:172982}. Hand him the {item:6535}, then use the {item:7464} on the summoning circle beside him and defeat the voidwalker to bind it."] = "{npc:5875} стоит здесь: {object:172960} – каньон под объектом {object:172982}. Отдайте ему {item:6535}, затем используйте предмет {item:7464} на круге призыва рядом с ним и одолейте демона Бездны, чтобы подчинить его.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back east to the shore north of {npc:275657}. Spitelash Scouts and Attendants hold the beach below {area:370}. Hunters: tame a {npc:3107} on the beach."] = "Назад на восток к берегу к северу от {npc:275657}. Разведчики и прислужники из клана Бича Злобы занимают пляж под местом {area:370}. Охотники: приручите на пляже монстра {npc:3107}.",
	-- ["Back south to {area:362}."] = "Назад на юг сюда: {area:362}.",
	-- ["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "Назад к {npc:5875} ({object:172960}). Используйте предмет {item:7464} на круге призыва и одолейте демона Бездны, чтобы подчинить его.",
	-- ["Follow the road north from {area:362} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "Идите по дороге на север от места {area:362} к главным воротам ({zone:1454}), чуть к западу от места {area:817}. {npc:3352} стоит с учителями охотников, ориентир: {object:172958}.",
	-- ["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "Рокочущие ящерицы и бурешкуры пасутся здесь: {area:369}, за мостом; {item:6486} может упасть с любого.",
	-- ["Thunder lizards across the river"] = "Рокочущие ящерицы за рекой",
	-- ["{npc:3337}, beside {npc:5810}"] = "{npc:3337}, рядом с персонажем {npc:5810}",
}
