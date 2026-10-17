-- Russian (ruRU): the guide forever/horde/orc-troll/01-durotar (forever/horde/orc-troll/01-durotar.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}, там, где вы начинаете",

	-- Step 2: Gornek
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143} ждет внутри Логова – здания чуть к западу от персонажа {npc:10176}.",

	-- Step 3: Training weapons and boars
	["Training weapons and boars"] = "Учебное оружие и вепри",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "Оружие лежит вокруг Логова и тренировочной площадки; пятнистые вепри бродят по всей долине.",

	-- Step 4: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143} стоит сразу у входа в пещеру; {npc:3159} – в глубине пещеры за ним.",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave"] = "{npc:3159}, в глубине пещеры",
	-- {npc:3156} Nartok
	["{npc:3156}, the warlock trainer at the back of the cave"] = "{npc:3156}, учитель чернокнижников, в глубине пещеры",
	-- {npc:3155} Rwag
	["{npc:3155}, the rogue trainer in the Den"] = "{npc:3155}, учитель разбойников, в Логове",
	-- {npc:3153} Frang
	["{npc:3153}, the warrior trainer beside the Den"] = "{npc:3153}, учитель воинов, у Логова",
	-- {npc:3154} Jen'shan
	["{npc:3154}, the hunter trainer beside the Den"] = "{npc:3154}, учитель охотников, у Логова",
	-- {npc:3707} Ken'jai
	["{npc:3707}, the priest trainer at the Den"] = "{npc:3707}, учитель жрецов, у Логова",
	-- {npc:3157} Shikrik
	["{npc:3157}, the shaman trainer beside the Den"] = "{npc:3157}, учитель шаманов, у Логова",
	-- {npc:5884} Mai'ah
	["{npc:5884}, the mage trainer, at the entrance to the Den"] = "{npc:5884}, учитель магов, у входа в Логово",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}, у костра для готовки",

	-- Step 5: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287} лежит раненый у подножия холмов к северо-западу от Логова.",

	-- Step 6: Sarkoth
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["{quest:790}, a large scorpid, prowls the slope south of {npc:3287} among the Scorpid Workers; pick the Cactus Apples by the cactuses on the way."] = "{quest:790}, большой скорпид, бродит по склону к югу от персонажа {npc:3287} среди рабочих скорпидов; по пути собирайте плоды кактуса у кактусов.",

	-- Step 8: Back to the Den
	["Back to the Den"] = "Назад к Логову",

	-- Step 9: Foreman Thazz'ril
	["The foreman stands at the lumber pile east of the Den."] = "Штейгер стоит у штабеля бревен к востоку от Логова.",

	-- Step 10: Lazy Peons
	-- {item:16114} Foreman's Blackjack
	["Hit the sleeping peons north of the Den with the {item:16114}."] = "Бейте спящих батраков к северу от Логова предметом {item:16114}.",
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "Разбудите батраков ({quest:5441}) предметом {item:16114}",

	-- Step 12: North end of the valley
	["North end of the valley"] = "Северный конец долины",
	-- {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	["The {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "Фамилиары ({quest:792}) кишат на склоне под местом {area:365} – пещерой на северной стороне долины.",

	-- Step 13: Back at the Den
	["Back at the Den"] = "Снова у Логова",

	-- Step 14: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller
	["{npc:5887} stands just outside the Den."] = "{npc:5887} стоит сразу у Логова.",

	-- Step 16: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "В пещере на первой развилке идите прямо, затем направо и вдоль ручья слева до водопада: кирка светится у воды, за каменной колонной.",

	-- Step 17: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "В пещере держитесь правой стены по всему кругу, через ручей: {npc:3183} ждет в конце.",

	-- Step 18: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "Копыта: {npc:3102}",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "Ловцы Скверны бродят по склону под пещерой, на северной стороне долины.",

	-- Step 20: Zureetha Fargaze
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "{object:654925} на земле рядом с ней",

	-- Step 21: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887} стоит у Логова. {area:639} – холм чуть к югу: выпейте там {item:6635}, чтобы увидеть персонажа {npc:5891}, затем отнесите предмет {item:6656} {npc:5887}.",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}, ориентир: {area:639}",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}: {npc:5873} и ваш {item:5175}",

	-- Step 22: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786} стоит на дороге у восточного выхода из долины.",

	-- Step 23: Sen'jin Village
	-- {area:367} Sen'jin Village
	["Follow the road east out of the valley to {area:367} on the coast."] = "Идите по дороге на восток из долины сюда: {area:367}, на побережье.",

	-- Step 24: Ridgeshade spiders
	["Ridgeshade spiders"] = "Темногорные пауки",
	-- {area:362} Razor Hill
	["The spiders lurk in the hills along the road north toward {area:362}."] = "Пауки прячутся на холмах вдоль дороги на север к месту {area:362}.",

	-- Step 25: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "Костер: {npc:265809}",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears."] = "{npc:265809} стоит лагерем чуть к югу от места {area:362}. Сядьте у его костра (/sit), пока не появится эффект {spell:1229451}.",

	-- Step 26: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town"] = "{npc:266940}, в восточной части городка",
	-- {npc:3191} Cook Torka
	["Talk to {npc:3191}"] = "Поговорите с персонажем {npc:3191}",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}, в сторожевой башне",

	-- Step 27: Prickly pears
	["Prickly pears"] = "Колючие груши",
	["The prickly pears grow among the quilboar huts just west of town."] = "Колючие груши растут среди хижин свинобразов чуть к западу от городка.",

	-- Step 29: Razormane Grounds
	["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "Свинобразы и разведчики занимают хижины к западу от городка; пылебеги и боевые стражи – лагеря дальше к западу.",

	-- Step 31: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps · {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "Крепость стоит на побережье к юго-востоку от места {area:362}. Топор, лук и щит налетчиков лежат на ее окраинах. {item:4870} падает с моряков и стражей бухты. {npc:3192} ждет на вершине крепости; его ключ открывает сундук рядом, в нем – {item:4881}.",

	-- Step 33: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Follow the road north toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "Идите по дороге на север к городу {zone:1454}. {npc:3293} стоит лагерем у дороги; украденные мешки лежат вдоль дороги к югу от него.",

	-- Step 34: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}."] = "Дикарки и грозовые ведьмы из стаи Пыльного Ветра гнездятся здесь: {area:370}, к востоку от персонажа {npc:3293}. {item:277661} падает с грозовой ведьмы.",

	-- Step 36: Thunder lizards
	["Thunder lizards"] = "Рокочущие ящерицы",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}."] = "Рокочущие ящерицы и бурешкуры пасутся здесь: {area:369}, чуть к западу и юго-западу от персонажа {npc:3293}.",

	-- Step 38: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "Хижина Майши – к югу от ящеров. {item:4891} – у кроколисков вдоль реки ({area:814}) к западу.",

	-- Step 39: The wreckage
	["The wreckage"] = "Обломки",
	-- {area:362} Razor Hill
	["The gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin."] = "Гномские ящики с инструментами лежат среди обломков на берегу к востоку и юго-востоку от места {area:362}. Идите по берегу на юг к Сен'джину.",

	-- Step 40: Sen'jin Village
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}: только для зачарователей – остаток получают, распыляя проклятые подвески",

	-- Step 41: Makrura and crawlers
	["Makrura and crawlers"] = "Макруры и крабы",
	["Makrura and surf crawlers line the beaches north-east of Sen'jin."] = "Макруры и приливные крабы занимают пляжи к северо-востоку от Сен'джина.",

	-- Step 42: Bloodtalon Matriarch
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there."] = "Перейдите вброд на северный из Островов Эха. Там среди ящеров бродит матриарх.",

	-- Step 43: Echo Isles
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle."] = "Двигайтесь на юг через острова. Идолы Лоа лежат по всем южным островам; их охраняют тролли-вудуисты и проклятые тролли, с них падают проклятые подвески. {quest:826} и клетка Миншины – на самом южном острове.",

	-- Step 44: South-east shore
	["South-east shore"] = "Юго-восточный берег",
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade back west to the shore south of Sen'jin. Durotar Tigers roam it and the Taillasher eggs sit in nests along the beach."] = "Вернитесь вброд на запад к берегу к югу от Сен'джина. Там бродят дуротарские тигры, а яйца кнутохвостов лежат в гнездах вдоль пляжа.",

	-- Step 46: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "{area:366} – к западу от Сен'джина. Три плана атаки лежат на земле среди шатров кентавров. {npc:275811} тоже в плену на утесе.",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "Освободите персонажа {npc:275811} и выведите ее с утеса",

	-- Step 48: Razor Hill
	-- {area:362} Razor Hill
	["Follow the road north to {area:362}."] = "Идите по дороге на север сюда: {area:362}.",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}, у таверны",
	-- {npc:3706} Tai'jin · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["{npc:3706}, for {npc:6018} in {zone:1454}: keep it"] = "{npc:3706}, для персонажа {npc:6018} ({zone:1454}): сохраните задание",

	-- Step 49: Fizzle Darkstorm
	-- {area:369} Thunder Ridge · {area:362} Razor Hill · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	["Fizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way."] = "Пшикс занимает лагерь культистов (Пылающий Клинок) здесь: {area:369}, к северо-западу от места {area:362}. Охотники: по пути приручите монстра {npc:3099} предметом {item:15908}.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Приручите его предметом {item:15908}",

	-- Step 51: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657} стоит на берегу к востоку от места {area:362}. Трезубец, знамя и кинжал лежат на пляже вокруг него.",

	-- Step 52: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828} стоит лагерем на холме к западу от пляжа наг, к югу от места {quest:827}.",

	-- Step 53: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "Главные ворота ({zone:1454}) – чуть к западу от места {area:817}. {npc:5875} стоит здесь: {object:172960} – каньон под местом {object:172982}.",

	-- Step 54: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "Вход: {area:817}",

	-- Step 55: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}."] = "Культисты (Пылающий Клинок) занимают пещеры ({quest:827}); {item:4871} падает с любого. {npc:3204}, чернокнижник 14-го уровня, стоит в глубине, с него падает {item:4903}.",

	-- Step 56: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "{object:58595} стоит здесь: {area:817}, среди культистов, с которыми вы только что бились.",

	-- Step 57: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:7464} Glyphs of Summoning
	["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "Назад к {npc:5875} ({object:172960}). Используйте предмет {item:7464} на круге призыва и одолейте демона Бездны, чтобы подчинить его.",

	-- Step 59: Razor Hill
	-- {area:362} Razor Hill
	["Back south to {area:362}."] = "Назад на юг сюда: {area:362}.",

	-- Step 60: Spitelash naga
	["Spitelash naga"] = "Наги Бича Злобы",
	-- {npc:275657} Heglan Shadeeye · {area:370} Drygulch Ravine · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["Back east to the shore north of {npc:275657}. Spitelash Scouts and Attendants hold the beach below {area:370}. Hunters: tame a {npc:3107} on the beach."] = "Назад на восток к берегу к северу от {npc:275657}. Разведчики и прислужники из клана Бича Злобы занимают пляж под местом {area:370}. Охотники: приручите на пляже монстра {npc:3107}.",

	-- Step 61: Razor Hill
	-- {area:362} Razor Hill
	["Back to {area:362}."] = "Назад сюда: {area:362}.",
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}: {npc:275666}, элитный морской великан",

	-- Step 62: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "{npc:275666}, молодой морской великан, бродит по северному побережью ({zone:1411}), к северу от пляжа наг. {npc:275666} – элита: лучше собрать группу.",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}, снова здесь: {area:362}",

	-- Step 63: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "Бронескорпы ползают по равнинам к западу от места {area:362}. Приручите одного, затем вернитесь к персонажу {npc:3171}.",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "{npc:3171}: {npc:3352} ({zone:1454}) обучает навыку {spell:5149}",

	-- Step 64: Ormak Grimshot
	-- {area:362} Razor Hill · {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor
	["Follow the road north from {area:362} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "Идите по дороге на север от места {area:362} к главным воротам ({zone:1454}), чуть к западу от места {area:817}. {npc:3352} стоит с учителями охотников, ориентир: {object:172958}.",

	-- Step 65: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {area:379} Far Watch Post · {zone:1413} Barrens
	["Follow the road west from {area:362} over the {area:814} bridge; {area:379} sits just above it on the {zone:1413} side."] = "Идите по дороге на запад от места {area:362} через мост ({area:814}); {area:379} – чуть выше, на стороне края {zone:1413}.",

	-- Step 66: Thunder lizards across the river
	["Thunder lizards across the river"] = "Рокочущие ящерицы за рекой",
	-- {area:369} Thunder Ridge · {item:6486} Singed Scale
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "Рокочущие ящерицы и бурешкуры пасутся здесь: {area:369}, за мостом; {item:6486} может упасть с любого.",

	-- Step 68: The Crossroads
	-- {area:379} Far Watch Post · {area:380} The Crossroads · {zone:1413} Barrens
	["Follow the road south-west from {area:379} to the {area:380}. {zone:1413} guide starts here."] = "Идите по дороге на юго-запад от места {area:379} к месту {area:380}. Здесь начинается руководство: {zone:1413}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road south-west from {area:379} to the {area:380}. {zone:1413} guide starts here."] = "Идите по дороге на юго-запад от места {area:379} сюда: {area:380}. Здесь начинается руководство: {zone:1413}.",
	-- ["{area:364}'s cave mouth"] = "Вход в пещеру: {area:364}",
}
