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
	["{npc:3143}, inside"] = "{npc:3143}, внутри",
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
	["{npc:3159}, at the back of the cave; below ground"] = "{npc:3159} – в глубине пещеры; под землей",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}, у костра для готовки",

	-- Step 4: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287} лежит раненый у подножия холмов к северо-западу от Логова.",

	-- Step 5: Valley of Trials: kill these as you meet them
	-- {area:363} Valley of Trials
	["{area:363}: kill these as you meet them"] = "{area:363}: убивайте их по пути",
	-- {npc:3287} Hana'zua · {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["The Scorpid Workers roam the slope south of {npc:3287}; pick the Cactus Apples by the cactuses on the way.\nThe {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "Рабочие скорпиды бродят по склону к югу от персонажа {npc:3287}; по пути собирайте плоды кактуса у кактусов.\nЗлобные фамильяры ({quest:792}) кишат на склоне под пещерой {area:365} на северной стороне долины.",

	-- Step 6: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 7: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:363} Valley of Trials
	["{npc:246344} in {zone:1456}; {area:363} has no paladin trainer"] = "",

	-- Step 8: Druid trainer
	["Druid trainer"] = "Учитель друидов",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:363} Valley of Trials
	["{npc:3034} in {zone:1412}; {area:363} has no druid trainer"] = "{npc:3034} ({zone:1412}); {area:363}: учителя друидов нет",

	-- Step 9: Back to the Den
	["Back to the Den"] = "Назад к Логову",
	-- {npc:11378} Foreman Thazz'ril
	["{npc:11378}, at the lumber pile east of the Den"] = "",

	-- Step 10: Lazy Peons
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "Разбудите батраков ({quest:5441}) предметом {item:16114}",

	-- Step 12: Sarkoth
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua · {area:365} Burning Blade Coven
	["{quest:790}, a large scorpid (level 4), prowls the slope just west of the Den, below {npc:3287}, on the way north to the {area:365}."] = "{quest:790}, крупный скорпид (4-й уровень), бродит по склону чуть к западу от Логова, под персонажем {npc:3287}, по пути на север к месту {area:365}.",

	-- Step 13: Canaga Earthcaller
	-- {npc:3143} Gornek · {quest:804} Sarkoth · {npc:5887} Canaga Earthcaller · {quest:1516} Call of Earth
	["Back to the Den: {npc:3143} takes {quest:804}'s claw and {npc:5887}, just outside, has {quest:1516} now that you are level 4."] = "Обратно в Логово: {npc:3143} примет коготь ({quest:804}), а {npc:5887} снаружи теперь, на 4-м уровне, предлагает задание «{quest:1516}».",

	-- Step 15: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "В пещере на первой развилке идите прямо, затем направо и вдоль ручья слева до водопада: кирка светится у воды, за каменной колонной.",

	-- Step 16: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "В пещере держитесь правой стены по всему кругу, через ручей: {npc:3183} ждет в конце.",
	["Below ground"] = "Под землей",

	-- Step 17: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "Копыта: {npc:3102}",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "Ловцы Скверны бродят по склону под пещерой, на северной стороне долины.",

	-- Step 18: Back to the Den
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "{object:654925} на земле рядом с ней",

	-- Step 19: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887} стоит у Логова. {area:639} – холм чуть к югу: выпейте там {item:6635}, чтобы увидеть персонажа {npc:5891}, затем отнесите предмет {item:6656} {npc:5887}.",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}, ориентир: {area:639}",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}: {npc:5873} и ваш {item:5175}",

	-- Step 20: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786} стоит на дороге у восточного выхода из долины.",

	-- Step 21: Sen'jin Village
	-- {area:362} Razor Hill
	["Careful: Ukorsbane (8) is elite and walks among the Ridgeshade spiders in the camp south of {area:362}: pull the spiders away from him."] = "Осторожно: Ukorsbane (8) – элитный противник, он ходит среди теневых пауков в лагере к югу от места {area:362}: выманивайте пауков подальше от него.",
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}: только для зачарователей – остаток получают, распыляя проклятые подвески",
	-- {npc:5880} Un'Thuwa
	["{npc:5880}, the mage trainer in Sen'jin"] = "",

	-- Step 22: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "Костер: {npc:265809}",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest · {zone:1454} Orgrimmar
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears. With a profession learned, {npc:265809} also offers its Camping 101, which its trainer takes: in {area:362} or in {zone:1454} at the start of the next guide."] = "{npc:265809} стоит лагерем чуть к югу от места {area:362}. Сядьте у его костра (/sit) и ждите, пока не появится эффект {spell:1229451}. Если вы освоили профессию, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает учитель этой профессии – здесь ({area:362}) или в начале следующего руководства, место: {zone:1454}.",

	-- Step 23: Camping 101: Mining
	-- {npc:3175} Krunn · {skill:186} Mining
	["{npc:3175} takes it once your {skill:186} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:3175} примет его, когда ваш навык {skill:186} достигнет 20: до тех пор собирайте или создавайте предметы, гайд тем временем продолжается.",
	-- {npc:265809} Brakk · {npc:3175} Krunn
	["{npc:265809}: for {npc:3175}"] = "{npc:265809}: для персонажа {npc:3175}",

	-- Step 24: Camping 101: Engineering
	-- {npc:11025} Mukdrak · {skill:202} Engineering
	["{npc:11025} takes it once your {skill:202} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:11025} примет его, когда ваш навык {skill:202} достигнет 20: до тех пор собирайте или создавайте предметы, гайд тем временем продолжается.",
	-- {npc:265809} Brakk · {npc:11025} Mukdrak
	["{npc:265809}: for {npc:11025}"] = "{npc:265809}: для персонажа {npc:11025}",

	-- Step 25: Camping 101: First Aid
	-- {npc:5943} Rawrk · {skill:129} First Aid
	["{npc:5943} takes it once your {skill:129} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:5943} примет его, когда ваш навык {skill:129} достигнет 20: до тех пор собирайте или создавайте предметы, гайд тем временем продолжается.",
	-- {npc:265809} Brakk · {npc:5943} Rawrk
	["{npc:265809}: for {npc:5943}"] = "{npc:265809}: для персонажа {npc:5943}",

	-- Step 26: Camping 101: Skinning
	-- {npc:265809} Brakk
	["{npc:265809}: for Thuwd"] = "{npc:265809}: для Тувда",

	-- Step 27: Camping 101: Leatherworking
	-- {npc:265809} Brakk
	["{npc:265809}: for Karolek"] = "{npc:265809}: для Каролека",

	-- Step 28: Camping 101: Herbalism
	-- {npc:265809} Brakk
	["{npc:265809}: for Jandi"] = "{npc:265809}: для Джанди",

	-- Step 29: Camping 101: Enchanting
	-- {npc:265809} Brakk
	["{npc:265809}: for Jhag"] = "{npc:265809}: для Джага",

	-- Step 30: Camping 101: Alchemy
	-- {npc:265809} Brakk · {npc:11046} Whuut
	["{npc:265809}: for {npc:11046}"] = "{npc:265809}: для персонажа {npc:11046}",

	-- Step 31: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town; inside"] = "",

	-- Step 32: Razor Hill
	-- {npc:3191} Cook Torka
	["{npc:3191}: Camping 101 asks you to learn it"] = "",
	-- {npc:6928} Innkeeper Grosk
	["{npc:6928}, inside"] = "{npc:6928}, внутри",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}, в сторожевой башне",

	-- Step 36: Camping 101: Tailoring
	-- {npc:265809} Brakk
	["{npc:265809}: for Snang"] = "{npc:265809}: для Снанга",

	-- Step 37: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}."] = "Крепость стоит на побережье к юго-востоку от места {area:362}. Топор, лук и щит налетчиков лежат на ее окраинах. {item:4870} падают с моряков и морских пехотинцев.",

	-- Step 38: Level 7
	["Level 7"] = "7-й уровень",
	-- {npc:3192} Lieutenant Benedict
	["Top up here to level 7 before {npc:3192} (8) and the marines at the top of the keep."] = "Добейте здесь 7-й уровень, прежде чем идти к NPC {npc:3192} (8) и морским пехотинцам на вершине крепости.",
	-- {npc:3128} Kul Tiras Sailor
	["grind on {npc:3128}"] = "убивайте: {npc:3128}",

	-- Step 39: Lieutenant Benedict
	-- {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["{npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "{npc:3192} ждет на вершине крепости; его ключ открывает сундук рядом, в нем – {item:4881}.",
	["Upstairs"] = "Наверху",

	-- Step 40: Razor Hill
	-- {area:362} Razor Hill · {npc:3139} Gar'Thok · {npc:3147} Furl Scornbrow · {npc:3142} Orgnil Soulscar · {npc:266940} Turroc
	["Back north-west to {area:362}: {npc:3139} first, then {npc:3147} in the watchtower, then {npc:3142} and {npc:266940} on the way out east to the shore."] = "Вернитесь на северо-запад в {area:362}: сначала {npc:3139}, затем {npc:3147} на сторожевой башне, потом {npc:3142} и {npc:266940} по пути на восток к побережью.",
	-- {npc:266940} Turroc
	["{npc:266940}, inside"] = "{npc:266940}, внутри",

	-- Step 41: Scuttle Coast: kill these as you meet them
	-- {area:373} Scuttle Coast
	["{area:373}: kill these as you meet them"] = "{area:373}: убивайте их по пути",
	-- {area:362} Razor Hill
	["The gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin.\nMakrura and surf crawlers line the beaches north-east of Sen'jin."] = "Гномские ящики с инструментами лежат среди обломков на побережье к востоку и юго-востоку от {area:362}. Идите вдоль берега на юг к Сен'джину.\nМакруры и прибойные ползуны встречаются на пляжах к северо-востоку от Сен'джина.",
	["Underwater"] = "Под водой",

	-- Step 42: Sen'jin Village
	-- {area:366} Kolkar Crag · {npc:3304} Master Vornal
	["Through Sen'jin on the way west to {area:366}: {npc:3304} takes the eyes and mucus now."] = "Через Сен'джин по пути на запад к месту {area:366}: {npc:3304} теперь примет глаза и слизь.",

	-- Step 43: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "{area:366} – к западу от Сен'джина. Три плана атаки лежат на земле среди шатров кентавров. {npc:275811} тоже в плену на утесе.",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "Освободите персонажа {npc:275811} и выведите ее с утеса",

	-- Step 44: Sen'jin Village
	-- {area:368} Echo Isles
	["Back east to Sen'jin on the way to the {area:368}."] = "Обратно на восток в Сен'джин по пути к месту {area:368}.",

	-- Step 45: Echo Isles: kill these as you meet them
	-- {area:368} Echo Isles
	["{area:368}: kill these as you meet them"] = "{area:368}: убивайте их по пути",
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there.\nDurotar Tigers roam the isle as well as the shore south of Sen'jin, and the Taillasher eggs sit in nests on the isles and along the beach."] = "Переберитесь вброд на северный остров Эха. Там среди ящеров бродит Матриарх.\nТигры Дуротара бродят по острову, а также по берегу к югу от Сен'джина, а яйца хлыстохвостов лежат в гнездах на островах и вдоль пляжа.",

	-- Step 46: Level 9
	["Level 9"] = "9-й уровень",
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll
	["Top up here to level 9 before the southern isles: the Voodoo and Hexed Trolls there are 8-9 and {quest:826} is 10."] = "Добейте здесь 9-й уровень перед южными островами: тролли-вуду и проклятые тролли там 8-9-го уровня, а {quest:826} – 10-го.",
	-- {npc:3121} Durotar Tiger
	["grind on {npc:3121}"] = "убивайте: {npc:3121}",

	-- Step 47: Echo Isles: kill these as you meet them
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant · Voodoo Trolls = {npc:3206} Voodoo Troll
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle.\nCareful: the trolls stand close together and the Voodoo Trolls cast from range: pull one at a time. {quest:826} himself is level 10."] = "Двигайтесь на юг через острова. Идолы Лоа лежат по всем южным островам; их охраняют тролли-вудуисты и проклятые тролли, с них падают проклятые подвески. {quest:826} и клетка Миншины – на самом южном острове.\nОсторожно: тролли стоят плотно, а тролли-вудуисты атакуют издалека: выманивайте по одному. Сам {quest:826} – 10-го уровня.",

	-- Step 48: Deathskip to Sen'jin Village
	-- {area:367} Sen'jin Village
	["Deathskip to {area:367}"] = "",
	-- {npc:3206} Voodoo Troll · {npc:6491} Spirit Healer
	["Die to the mobs at 66.9,87.2 ({npc:3206}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "",

	-- Step 52: Level 10
	["Level 10"] = "",
	-- {area:362} Razor Hill · {quest:96825} This Fruit Could Bite Back
	-- was: ["Top up here to level 10: {quest:840}, at {area:362}, needs level 10.\nThe prickly pears for {quest:96825} grow by these huts: pick them while you grind."] = "Добейте здесь 10-й уровень: для задания {quest:840} ({area:362}) нужен 10-й уровень.\nКолючие груши для задания {quest:96825} растут у этих хижин: собирайте их, пока убиваете монстров."
	["Top up here to level 10: your class quest at {area:362} needs level 10.\nThe prickly pears for {quest:96825} grow by these huts: pick them while you grind."] = "",
	-- {npc:3111} Razormane Quilboar
	["grind on {npc:3111}"] = "убивайте: {npc:3111}",

	-- Step 53: Razor Hill
	-- {npc:3336} Takrin Pathseeker · {npc:3337} Kargal Battlescar · {npc:5907} Kranal Fiss
	["{npc:3336}: {npc:3337} is on the way to {npc:5907}"] = "",

	-- Step 54: Far Watch Post
	-- {area:814} Southfury River · {npc:3337} Kargal Battlescar · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge: {npc:3337} stands at {area:379} above it, on your way to {npc:5907}."] = "",

	-- Step 59: Kranal Fiss
	-- {area:814} Southfury River · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge, past {area:379} and on along the ridge: {npc:5907} stands alone above the Razormane camp."] = "",

	-- Step 60: Telf Joolam
	-- {zone:1411} Durotar · {npc:5900} Telf Joolam
	["Back over the bridge and south along the {zone:1411} bank of the river to where a narrow trail climbs the mountain: {npc:5900} keeps the shrine at the top. Mind the edges on the way up, and come back down the same trail."] = "",

	-- Step 61: Razormane Grounds
	["Quilboars and scouts hold the huts west of town, where the prickly pears grow; dustrunners and battleguards hold the camps farther west."] = "Свинобразы и разведчики занимают хижины к западу от городка, где растут колючие груши; пылебеги и боевые стражи – лагеря дальше к западу.",

	-- Step 62: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Head north-east to the road toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "",

	-- Step 63: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb · {area:371} Dustwind Cave · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}. Shamans: the Burning Blade Cultists by {area:371}, at the ravine's south end, drop the {item:6652}."] = "",

	-- Step 64: Deathskip to Northern Durotar
	["Deathskip to Northern Durotar"] = "",
	-- {npc:3118} Dustwind Storm Witch · {npc:6491} Spirit Healer
	["Die to the mobs at 52.0,21.4 ({npc:3118}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "",

	-- Step 67: Thunder Ridge: kill these as you meet them
	-- {area:369} Thunder Ridge
	["{area:369}: kill these as you meet them"] = "{area:369}: убивайте их по пути",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "Рокочущие ящерицы и бурешкуры пасутся здесь: {area:369}, чуть западнее и юго-западнее NPC {npc:3293}.\nОсторожно: Халикор, элитный противник 12-го уровня, бродит среди ящериц ({area:369}): высматривайте его, прежде чем нападать.",

	-- Step 69: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "Хижина Майши – к югу от ящеров. {item:4891} – у кроколисков вдоль реки ({area:814}) к западу.",

	-- Step 70: Level 11
	["Level 11"] = "11-й уровень",
	-- {npc:3203} Fizzle Darkstorm
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard
	["Top up here to level 11 before {npc:3203} (12) and his imp: the Thunder Lizards (9-10) graze on the ridge just west of Misha's hut."] = "Добейте здесь 11-й уровень, прежде чем идти на NPC {npc:3203} (12) и его беса: рокочущие ящерицы (9-10) пасутся на гребне чуть западнее хижины Миши.",
	-- {npc:3130} Thunder Lizard
	["grind on {npc:3130}"] = "убивайте: {npc:3130}",

	-- Step 71: Fizzle Darkstorm
	-- {area:369} Thunder Ridge · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	["Fizzle holds the Burning Blade camp on {area:369}, just north of Misha's hut. Hunters: tame a {npc:3099} with the {item:15908} on the way.\nCareful: Burning Blade cultists surround Fizzle, some linked so they aggro in pairs, and they respawn quickly.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "Пшикс удерживает лагерь клана Пылающего Клинка ({area:369}), чуть севернее хижины Миши. Охотникам: по пути приручите вепря ({npc:3099}), используя {item:15908}.\nОсторожно: Пшикса окружают сектанты Пылающего Клинка, некоторые связаны и нападают парами, и они быстро возрождаются.\nОсторожно: Халикор, элитный противник 12-го уровня, бродит среди ящериц ({area:369}): высматривайте его, прежде чем нападать.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Приручите его предметом {item:15908}",

	-- Step 72: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657} стоит на берегу к востоку от места {area:362}. Трезубец, знамя и кинжал лежат на пляже вокруг него.",

	-- Step 74: Paladin trainer
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:362} Razor Hill
	["{npc:246344} in {zone:1456}; {area:362} has no paladin trainer"] = "",

	-- Step 75: Druid trainer
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:362} Razor Hill
	["{npc:3034} in {zone:1412}; {area:362} has no druid trainer"] = "{npc:3034} ({zone:1412}); {area:362}: учителя друидов нет",

	-- Step 76: Razor Hill
	-- {area:362} Razor Hill · {npc:3139} Gar'Thok · {npc:3142} Orgnil Soulscar
	["Back to {area:362}: {npc:3139}, then {npc:3142}."] = "",
	-- {npc:3169} Tarshaw Jaggedscar · {npc:5810} Uzzek · {area:379} Far Watch Post
	["{npc:3169}, inside: for {npc:5810} at {area:379}, on the way out"] = "",
	-- {npc:3294} Ophek · {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["{npc:3294}, by the inn: for {npc:5875} in {zone:1454}"] = "",
	-- {npc:3336} Takrin Pathseeker · {npc:3337} Kargal Battlescar · {area:379} Far Watch Post · {zone:1413} The Barrens
	["{npc:3336}: {npc:3337} stands at {area:379}, on the {zone:1413} guide's road"] = "",

	-- Step 77: Spitelash naga
	["Spitelash naga"] = "Наги Бича Злобы",
	-- {area:370} Drygulch Ravine · {npc:275657} Heglan Shadeeye · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["North-east to the beach below {area:370}, north of {npc:275657}: Spitelash Scouts and Attendants hold it. Hunters: tame a {npc:3107} on the beach."] = "На северо-восток к пляжу под местом {area:370}, к северу от {npc:275657}: его занимают разведчики и прислужники из клана Бича Злобы. Охотники: приручите на пляже монстра {npc:3107}.",

	-- Step 78: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828} стоит лагерем на холме к западу от пляжа наг, к югу от места {quest:827}.",

	-- Step 80: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "Главные ворота ({zone:1454}) – чуть к западу от места {area:817}. {npc:5875} стоит здесь: {object:172960} – каньон под местом {object:172982}.",

	-- Step 81: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Раз уж вы здесь: изучите владение посохами у NPC {npc:2704} ({object:172958}, 10 серебра); при прокачке посох дает больше характеристик для заклинаний, чем одноручное оружие.",

	-- Step 82: Valley of Strength
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:268701} Thatog · {object:172982} Valley of Strength · {object:173016} Borstan's Firepit
	["{zone:1454}'s main gate is just west of {area:817}. {npc:268701} stands by the bank in the {object:172982}; {object:173016} is a few steps north."] = "",

	-- Step 83: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["On through the Drag: {npc:3348} and {npc:3347} run the alchemy shop; {npc:11046} is next door."] = "",

	-- Step 84: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "Рогоз и копейник растут вдоль воды – {object:172958}, к востоку от Волока.",

	-- Step 86: Thrall
	-- {object:172957} Valley of Wisdom · {npc:4949} Thrall · {npc:3230} Nazgrel
	["Grommash Hold stands in the {object:172957} at the end of the Drag: {npc:4949} sits on his throne, {npc:3230} stands beside the door."] = "",
	-- {npc:3230} Nazgrel · {quest:831} The Admiral's Orders
	["{npc:3230}, in Grommash Hold: {quest:831}"] = "",

	-- Step 87: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold; the Smooth Boulders lie around them."] = "",

	-- Step 88: Back to Durotar
	-- {zone:1411} Durotar
	["Back to {zone:1411}"] = "Обратно: {zone:1411}",

	-- Step 89: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "Вход: {area:817}",

	-- Step 90: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}.\nCareful: voidwalkers fight beside the Burning Blade cultists in {quest:827} and {npc:3204} (14) waits at the back with his own: pull one cultist at a time near the entrance for the collars. The {item:4903} is optional: leave {npc:3204} unless you are 13 or have a friend."] = "Культисты (Пылающий Клинок) занимают пещеры ({quest:827}); {item:4871} падает с любого. {npc:3204}, чернокнижник 14-го уровня, стоит в глубине, с него падает {item:4903}.\nОсторожно: в пещерах ({quest:827}) рядом с культистами Пылающего Клинка сражаются демоны Бездны, а {npc:3204} (14) ждет в глубине со своим: выманивайте культистов по одному у входа ради ошейников. {item:4903} – по желанию: не трогайте NPC {npc:3204}, если вы ниже 13-го уровня и без друга.",
	-- {item:14544} Lieutenant's Insignia
	["{item:14544}, from the same cultists; below ground"] = "",

	-- Step 91: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "{object:58595} стоит здесь: {area:817}, среди культистов, с которыми вы только что бились.",

	-- Step 93: Razor Hill
	-- {area:362} Razor Hill · {npc:3171} Thotar · {npc:5810} Uzzek · {area:379} Far Watch Post · {quest:99051} Threat from Below · {npc:3142} Orgnil Soulscar · {zone:1413} The Barrens
	["Back to {area:362}: {npc:3171}'s next beast and {npc:5810}'s road to {area:379} start here. Everyone else hands {quest:99051} to {npc:3142} when the {zone:1413} guide passes {area:362} on its way out."] = "",

	-- Step 94: Razor Hill
	-- {npc:3142} Orgnil Soulscar · {quest:99051} Threat from Below
	["{npc:3142}: {quest:99051}, if not handed in yet"] = "",
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}: {npc:275666}, элитный морской великан",

	-- Step 95: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}, снова здесь: {area:362}",

	-- Step 96: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "Бронескорпы ползают по равнинам к западу от места {area:362}. Приручите одного, затем вернитесь к персонажу {npc:3171}.",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "",

	-- Step 97: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {npc:3337} Kargal Battlescar · {npc:5810} Uzzek · {area:379} Far Watch Post · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["West from {area:362} over the {area:814} bridge: {npc:3337} and {npc:5810} stand together at {area:379} above it. From there the road north through {zone:1411} leads to {zone:1454}."] = "",

	-- Step 98: Thunder lizards on the way north
	["Thunder lizards on the way north"] = "Рокочущие ящерицы по пути на север",
	-- {area:369} Thunder Ridge · {zone:1454} Orgrimmar · {item:6486} Singed Scale · {npc:5810} Uzzek · {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, beside the road north to {zone:1454}; any of them can drop a {item:6486}. {npc:5810} takes it when the next guide passes {area:379}.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "Рокочущие ящерицы и бурешкуры пасутся здесь: {area:369}, у дороги на север к городу {zone:1454}; {item:6486} может упасть с любого. {npc:5810} примет ее, когда следующий гайд будет проходить мимо заставы {area:379}.\nОсторожно: Халикор, элитный противник 12-го уровня, бродит среди ящериц ({area:369}): высматривайте его, прежде чем нападать.",

	-- Step 100: Ormak Grimshot
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor
	-- was: ["Follow the road north from {area:379} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "Идите по дороге на север от места {area:379} к главным воротам ({zone:1454}), чуть к западу от места {area:817}. {npc:3352} стоит с учителями охотников, ориентир: {object:172958}."
	["Head to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "",

	-- Step 101: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Раз уж вы здесь: изучите владение посохами у NPC {npc:2704} ({object:172958}, 10 серебра); у оружия ближнего боя охотника важнее всего характеристики, а у двуручного их больше всего.",

	-- Step 102: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "В {zone:1454}",
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {area:379} Far Watch Post · {quest:829} Neeru Fireblade · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Head to {zone:1454}'s main gate, just west of {area:817} (Warriors: north along the road from {area:379}). The next guide starts in {zone:1454}: {quest:829} takes the cultists' quest, the trainers teach your new ranks, and the zeppelin leaves from the towers outside the gate for {zone:1420} and {zone:1421}. {zone:1413} come after Silverpine."] = "",
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "{zone:1454}: {object:172982}",

	-- Step 103: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {item:6535} Tablet of Verga · {item:7464} Glyphs of Summoning · {zone:1454} Orgrimmar
	["{npc:5875} stands in the {object:172960}, the canyon under the {object:172982}. Hand him the {item:6535}, then use the {item:7464} on the summoning circle beside him and defeat the voidwalker to bind it.\nCareful: the voidwalker you summon hits hard and it is the fight Warlocks die to most in {zone:1454}: start at full health and mana, send your imp in, keep Corruption and Immolate on it, and use a healthstone if you have one."] = "{npc:5875} стоит здесь: {object:172960} – каньон под объектом {object:172982}. Отдайте ему {item:6535}, затем используйте предмет {item:7464} на круге призыва рядом с ним и одолейте демона Бездны, чтобы подчинить его.\nОсторожно: призванный демон Бездны бьет сильно, и в этом бою в зоне {zone:1454} чернокнижники гибнут чаще всего: начинайте с полным здоровьем и маной, отправьте вперед беса, держите на нем «Порчу» и «Жертвенный огонь» и используйте камень здоровья, если он у вас есть.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to {area:362}."] = "Назад на юг сюда: {area:362}.",
	-- ["Back to {area:362}."] = "Назад сюда: {area:362}.",
	-- ["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "Назад к {npc:5875} ({object:172960}). Используйте предмет {item:7464} на круге призыва и одолейте демона Бездны, чтобы подчинить его.",
	-- ["Follow the road north from {area:379} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "Идите по дороге на север от места {area:379} к главным воротам ({zone:1454}), чуть к западу от места {area:817}. {npc:3352} стоит с учителями охотников, ориентир: {object:172958}.",
	-- ["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle."] = "Двигайтесь на юг через острова. Идолы Лоа лежат по всем южным островам; их охраняют тролли-вудуисты и проклятые тролли, с них падают проклятые подвески. {quest:826} и клетка Миншины – на самом южном острове.",
	-- ["Prickly pears"] = "Колючие груши",
	-- ["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "Свинобразы и разведчики занимают хижины к западу от городка; пылебеги и боевые стражи – лагеря дальше к западу.",
	-- ["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "Крепость стоит на побережье к юго-востоку от места {area:362}. Топор, лук и щит налетчиков лежат на ее окраинах. {item:4870} падает с моряков и стражей бухты. {npc:3192} ждет на вершине крепости; его ключ открывает сундук рядом, в нем – {item:4881}.",
	-- ["The prickly pears grow among the quilboar huts just west of town."] = "Колючие груши растут среди хижин свинобразов чуть к западу от городка.",
	-- ["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "Рокочущие ящерицы и бурешкуры пасутся здесь: {area:369}, за мостом; {item:6486} может упасть с любого.",
	-- ["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}.\nFizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way.\nCareful: Burning Blade cultists surround Fizzle, some linked so they aggro in pairs, and they respawn quickly.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "Рокочущие ящерицы и бурешкуры пасутся здесь: {area:369}, чуть западнее и юго-западнее NPC {npc:3293}.\nПшикс удерживает лагерь клана Пылающего Клинка ({area:369}), к северо-западу от места {area:362}. Охотникам: по пути приручите вепря ({npc:3099}), используя {item:15908}.\nОсторожно: Пшикса окружают сектанты Пылающего Клинка, некоторые связаны и нападают парами, и они быстро возрождаются.\nОсторожно: Халикор, элитный противник 12-го уровня, бродит среди ящериц ({area:369}): высматривайте его, прежде чем нападать.",
	-- ["Thunder lizards across the river"] = "Рокочущие ящерицы за рекой",
	-- ["Top up here to level 10: {quest:840}, at {area:362}, needs level 10.\nThe prickly pears for {quest:96825} grow by these huts: pick them while you grind."] = "Добейте здесь 10-й уровень: для задания {quest:840} ({area:362}) нужен 10-й уровень.\nКолючие груши для задания {quest:96825} растут у этих хижин: собирайте их, пока убиваете монстров.",
	-- ["With {skill:129} learned, {npc:265809} also offers its Camping 101: {npc:5943} in {area:362} takes it."] = "Если вы освоили навык {skill:129}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:5943}, место: {area:362}.",
	-- ["With {skill:165} learned, {npc:265809} also offers its Camping 101: {npc:3365} in {zone:1454} (next guide) takes it."] = "Если вы освоили навык {skill:165}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:3365}, место: {zone:1454} (следующее руководство).",
	-- ["With {skill:171} learned, {npc:265809} also offers its Camping 101: {npc:11046} in {zone:1454} (next guide) takes it."] = "Если вы освоили навык {skill:171}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:11046}, место: {zone:1454} (следующее руководство).",
	-- ["With {skill:182} learned, {npc:265809} also offers its Camping 101: {npc:3404} in {zone:1454} (next guide) takes it."] = "Если вы освоили навык {skill:182}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:3404}, место: {zone:1454} (следующее руководство).",
	-- ["With {skill:186} learned, {npc:265809} also offers its Camping 101: {npc:3175} in {area:362} takes it."] = "Если вы освоили навык {skill:186}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:3175}, место: {area:362}.",
	-- ["With {skill:197} learned, {npc:265809} also offers its Camping 101: {npc:2855} in {zone:1454} (next guide) takes it."] = "Если вы освоили навык {skill:197}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:2855}, место: {zone:1454} (следующее руководство).",
	-- ["With {skill:202} learned, {npc:265809} also offers its Camping 101: {npc:11025} in {area:362} takes it."] = "Если вы освоили навык {skill:202}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:11025}, место: {area:362}.",
	-- ["With {skill:333} learned, {npc:265809} also offers its Camping 101: {npc:11066} in {zone:1454} (next guide) takes it."] = "Если вы освоили навык {skill:333}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:11066}, место: {zone:1454} (следующее руководство).",
	-- ["With {skill:393} learned, {npc:265809} also offers its Camping 101: {npc:7088} in {zone:1454} (next guide) takes it."] = "Если вы освоили навык {skill:393}, {npc:265809} также предлагает свое задание «Основы походной жизни»: его принимает {npc:7088}, место: {zone:1454} (следующее руководство).",
	-- ["{npc:265809}: for Whuut"] = "{npc:265809}: для Вуута",
	-- ["{npc:265809}: for {npc:11066}"] = "{npc:265809}: для персонажа {npc:11066}",
	-- ["{npc:265809}: for {npc:2855}"] = "{npc:265809}: для персонажа {npc:2855}",
	-- ["{npc:265809}: for {npc:3365}"] = "{npc:265809}: для персонажа {npc:3365}",
	-- ["{npc:265809}: for {npc:3404}"] = "{npc:265809}: для персонажа {npc:3404}",
	-- ["{npc:265809}: for {npc:7088}"] = "{npc:265809}: для персонажа {npc:7088}",
	-- ["{npc:3169}, inside"] = "{npc:3169}, внутри",
	-- ["{npc:3294}, by the inn"] = "{npc:3294}, у таверны",
	-- ["{npc:3337}, beside {npc:5810}"] = "{npc:3337}, рядом с персонажем {npc:5810}",
}
