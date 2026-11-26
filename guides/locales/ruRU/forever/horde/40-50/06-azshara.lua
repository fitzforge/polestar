-- Russian (ruRU): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:35} Booty Bay · {zone:1447} Azshara · {zone:1444} Feralas · {zone:1446} Tanaris
	["{area:35} first, then {zone:1447}, {zone:1444} and {zone:1446}."] = "Сначала {area:35}, затем {zone:1447}, {zone:1444} и {zone:1446}.",

	-- Step 2: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Летите: {area:35}",

	-- Step 3: Booty Bay
	-- {area:75} Stonard · {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["The flight from {area:75} lands on {area:35}'s upper deck. {npc:7406} has his workshop on the upper ring of the bay."] = "Полет из места {area:75} заканчивается на верхней палубе ({area:35}). Мастерская ({npc:7406}) – на верхнем ярусе бухты.",
	-- {npc:7406} Oglethorpe Obnoticus
	["{npc:7406}, inside"] = "{npc:7406}, внутри",
	-- {zone:1446} Tanaris
	["\"Sea Wolf\" MacKinley, on the top floor: Stoley's shipment from {zone:1446}"] = "\"Морской Волк\" Маккинли, на верхнем этаже: груз Стоули из зоны {zone:1446}",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, on the balcony of the same building"] = "",

	-- Step 4: Whiskey Slim
	-- {npc:2491} Whiskey Slim · {area:35} Booty Bay
	["{npc:2491} sits in the {area:35} inn."] = "{npc:2491} сидит в таверне ({area:35}).",
	-- {npc:2491} Whiskey Slim
	["{npc:2491}, in the inn"] = "{npc:2491}, в таверне",

	-- Step 5: The Bloodsail ships
	["The Bloodsail ships"] = "Корабли Кровавого Паруса",
	-- {area:43} Wild Shore · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["South of Booty Bay, three Bloodsail ships lie off the {area:43}: {npc:2550}, {npc:2548} and {npc:2546} each stand on a deck with their crews. Swim out and work from ship to ship."] = "",

	-- Step 7: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 12: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "Летите: {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Распорядитель полетов: {area:35}",

	-- Step 13: Grom'gol Base Camp
	-- {area:117} Grom'gol Base Camp · {npc:2497} Nimboya · {object:2076} Bubbling Cauldron
	["The flight lands at {area:117}; {npc:2497} stands by the {object:2076}."] = "Полет заканчивается здесь: {area:117}; {npc:2497} стоит у объекта {object:2076}.",

	-- Step 14: Back to Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}"] = "Вернитесь: {object:3202}",

	-- Step 15: The Mind's Eye
	-- {npc:818} Mai'Zoth
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:818} (level 47 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\nCareful: Two elite caster guards, around level 45, stand with {npc:818} and join the fight together with him."] = "",
	["Below ground"] = "Под землей",

	-- Step 17: Saving Yenniku
	["while he is alive: the gem fills; don't kill him"] = "пока он жив: камень наполняется; не убивайте его",
	-- {item:3912} Soul Gem
	["Use the {item:3912} on Yenniku"] = "Используйте {item:3912} на Енику",

	-- Step 19: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",

	-- Step 20: Zilzibin Drumlore
	-- {zone:1454} Orgrimmar · {npc:7010} Zilzibin Drumlore · {zone:1446} Tanaris
	["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}."] = "По пути через {zone:1454} к распорядителю полетов загляните на Волок: {npc:7010} принимает отчет о насекомых из зоны {zone:1446}.",
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag"] = "{npc:7010}, Волок",

	-- Step 21: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {zone:1447} Azshara · {area:1237} Valormok
	["{quest:4494} needs level 50: {npc:7010}, in the Drag, gives it from then on. Under 50, it waits: if you reach 50 in {zone:1447}, this guide brings you back for it from {area:1237}; else the {zone:1447} guide at 55 offers it again."] = "",

	-- Step 22: Dran Droffers
	["The Droffers' shop is a few steps further into the Drag."] = "Лавка братьев Дрофферсов – чуть дальше на Волоке.",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, Волок",

	-- Step 23: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172959} The Drag · {quest:4300} Bone-Bladed Weapons · {zone:1447} Azshara
	["{npc:8659}, in {object:172959}, upstairs in one of its tallest buildings, has {quest:4300} for later; then your class trainer before you leave for {zone:1447}."] = "",
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659}, upstairs in {object:172959}"] = "",

	-- Step 24: Zor Lonetree
	-- {npc:4047} Zor Lonetree · {object:172957} Valley of Wisdom · {npc:4791} Nazeer Bloodpike · {zone:1445} Dustwallow Marsh
	["{npc:4047} stands in the {object:172957}: {npc:4791}'s report from {zone:1445}."] = "",

	-- Step 26: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Въезжайте: {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Езжайте на восток по дороге от Заставы Расщепленного Дерева. {npc:11548} ждет здесь: {area:1235}, чуть в стороне от дороги, в нескольких шагах к западу от места {area:3137} (Альянс): подходите с запада и держитесь подальше от часовых Азшары и Джарродена (элита).",

	-- Step 27: Haldarr Encampment: kill these as you meet them
	-- {area:1236} Haldarr Encampment
	["{area:1236}: kill these as you meet them"] = "{area:1236}: убивайте их по пути",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "Призраки высокорожденных бродят по руинам чуть севернее святилища; сатиры из племени Халдарр стоят лагерем немного дальше на север.",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} walks around {area:1235}: look inside the circle on the map"] = "{npc:6117} ходит по месту {area:1235}: ищите внутри круга на карте",

	-- Step 28: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Вернитесь: {npc:11548}, у святилища; держитесь западнее стражи места {area:3137}.",

	-- Step 29: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Идите по дороге на север: {area:1237}, лагерь Орды.",

	-- Step 30: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Летите сюда: {area:1637}",
	-- {zone:1447} Azshara · {area:1637} Orgrimmar · {quest:4493} March of the Silithid · {zone:1456} Thunder Bluff
	["You reached 50 in {zone:1447}: fly back to {area:1637} for {quest:4493} and your level 50 training, then on to {zone:1456}."] = "",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Распорядитель полетов: {area:1237}",

	-- Step 31: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} is in the Drag; your class trainer next."] = "",

	-- Step 32: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Летите сюда: {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 34: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and Magatha are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Летите в {zone:1456}; это по пути к месту {area:1099}. Маршрута полета туда еще нет? Летите в {area:378} и езжайте на запад через {zone:1412}. Хамуул и Магата – здесь: {area:1639}; друиды и паладины обучаются здесь ({npc:3033}, {npc:246344}).",
	-- {npc:6746} Innkeeper Pala
	["{npc:6746}, at the inn: for Hamuul"] = "{npc:6746}, в таверне: для Хамуула",
	-- {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{npc:5769}, on the {area:1639}"] = "{npc:5769}, здесь: {area:1639}",

	-- Step 35: Thunder Bluff
	-- {quest:3761} Un'Goro Soil
	["{quest:3761} is gathered in the next guide."] = "{quest:3761} собирается в следующем гайде.",

	-- Step 36: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Летите сюда: {area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Распорядитель полетов: {zone:1456}",

	-- Step 38: Camp Mojache
	-- {npc:8115} Witch Doctor Uzer'i
	["{npc:8115}, if you don't carry it yet: the materials come on this loop"] = "",
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: медведи — в зоне {zone:1448}",
	-- {npc:7776} Talo Thornhoof
	["{npc:7776}: the Northspring harpies, at the far end of this loop"] = "",

	-- Step 39: Talo Thornhoof
	-- {quest:3062} Dark Heart · {npc:8075} Edana Hatetalon
	["{quest:3062}: {npc:8075} (level 50, elite) roosts above the Northspring harpies this loop ends at. Grouping up is advised: skip it if you are alone."] = "",

	-- Step 40: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Блеклоперые гиппогрифы",
	-- {quest:3128} Natural Materials
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body. Nearly every one also drops the sinew and metallic fragments for {quest:3128}."] = "",

	-- Step 41: Hippogryph nests
	["Hippogryph nests"] = "Гнезда гиппогрифов",
	-- {area:2522} Ruins of Isildien · {object:142071} Egg-O-Matic
	["The hippogryph nests are on the hills to the south, around the {area:2522}; each holds an egg for the {object:142071}."] = "Гнезда гиппогрифов — на холмах к югу, вокруг места {area:2522}; в каждом лежит яйцо для устройства {object:142071}.",

	-- Step 43: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Летучие хамелеоны",
	-- {item:9589} Encrusted Minerals
	-- was: ["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Лесные дракончики порхают в лесу чуть западнее лагеря. Используйте сосуд на каждом убитом."
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill; they carry the {item:9589} too."] = "",

	-- Step 45: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Бродячие лесные древни",
	-- {zone:1444} Feralas · {npc:272401} Vale Screamer
	-- plural, as words: Splintered Logs = {item:9590} Splintered Log
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths. They carry the Splintered Logs too.\nCareful: a {npc:272401} (level 60) flies over the forest west of the camp: keep clear of it."] = "",

	-- Step 47: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	-- was: ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Езжайте на северо-запад: {area:1108}; {npc:14637} ждет на причале."
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "",

	-- Step 48: Forgotten Coast: the water and the shore
	-- {area:1108} Forgotten Coast
	["{area:1108}: the water and the shore"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-48) wash along the shore just south of the dock and drop the Water Elemental Cores, as the Sea Elementals (47-49) do. The Wave and Deep Striders (47-49) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: {npc:14637} has a second round once these are done."] = "",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958} – с морских валов",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904} – на волновых странников и странников глубин в воде",

	-- Step 50: Forgotten Coast: the giants' hills
	-- {area:1108} Forgotten Coast
	["{area:1108}: the giants' hills"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant · Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	-- was: ["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Морские элементали и морские брызги плещутся вдоль берега вокруг причала.\nСухопутные бродяги и скальные великаны бродят по холмам к северу от причала. Сначала ударьте каждого предметом {item:18904}: уменьшенные, они больше не элита. С каждого уменьшенного великана падает осадок; используйте на его теле и сосуд для уменьшенных горных великанов."
	["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too.\nThe Sea Elementals and Sea Sprays along the shore have the last cores."] = "",

	-- Step 52: Northspring harpies
	["Northspring harpies"] = "Гарпии Студеных Ключей",
	["The Northspring harpies nest on the ridges in the far north-west, past the giants' hills. The Windcallers heal, so kill them first and pull one at a time."] = "Гарпии Северного Источника гнездятся на хребтах на дальнем северо-западе, за холмами великанов. Призывательницы ветра лечат: убивайте их первыми и вытягивайте по одной.",

	-- Step 53: Edana Hatetalon
	-- {npc:8075} Edana Hatetalon
	["{npc:8075} (level 50, elite) roosts on the cliff just north of the harpies' nests. Clear the harpies around her first."] = "",

	-- Step 54: Rage Scar yetis
	["Rage Scar yetis"] = "Йети Бешеного оврага",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east towards the camp, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}, редкая добыча",

	-- Step 55: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "Вернитесь: {area:1099}",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, внутри",

	-- Step 57: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Летите сюда: {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Распорядитель полетов: {area:1099}",

	-- Step 58: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, внутри",

	-- Step 61: Gadgetzan
	-- {area:976} Gadgetzan · {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{area:976}'s Auction House is the last one before Un'Goro. There, {npc:9623} (Chasing {npc:9623}) asks for a {item:10561}, an {skill:202} item, before her escort: buy one here if you want that chain."] = "Аукцион в месте {area:976} – последний перед Ун'Горо. Там {npc:9623} (задание «В погоне за {npc:9623}») просит {item:10561}, инженерный предмет ({skill:202}), перед сопровождением: купите здесь, если хотите эту цепочку.",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, рядом с распорядителем ветрокрылов",

	-- Step 62: The Egg-O-Matic
	-- {object:142071} Egg-O-Matic
	["The {object:142071}"] = "{object:142071}",
	-- {object:142071} Egg-O-Matic
	["The {object:142071}, in the middle of town"] = "{object:142071}, в центре города",

	-- Step 63: Marin Noggenfogger
	-- {zone:1449} Un'Goro Crater
	["Pestlezugg's samples come from {zone:1449}."] = "Образцы Пестычинса — из зоны {zone:1449}.",

	-- Step 64: Marvon Rivetseeker
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Езжайте на юг по дороге к месту {area:1938}; {npc:7771} стоит лагерем рядом. Отсюда дорога на запад ведет вниз в {zone:1449}, где начинается следующий гайд.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Сохраните {quest:3444}: сундук {npc:7771} откроется при следующем визите.",

	-- Step 65: The Dunemaul Compound
	-- {area:1938} Broken Pillar · {npc:12046} Gor'marok the Ravager · {npc:11758} Andi Lynn · {zone:1446} Tanaris
	["South of the {area:1938} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end: {npc:11758}'s quest, if you still carry it from {zone:1446}."] = "",

	-- Step 66: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley · {npc:7876} Tran'rek · {zone:1446} Tanaris · {area:976} Gadgetzan
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	-- was: ["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (48-50) are {npc:7876}'s, carried from your first {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop, with {npc:11758}'s."] = "К западу от укрепления, по пути к спуску в Ун'Горо: бугристые шипошкуры и корневеды (48-50) для задания {quest:3362} — от {npc:7876}, взятого при первом визите в зону {zone:1446}. Они много бродят: вытягивайте по одному. {npc:7876} примет их на остановке ({area:976}) в следующем гайде, вместе с заданием от {npc:11758}."
	["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (49-50) are {npc:7876}'s, carried from your second {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back north-east to {npc:8420}."] = "Обратно на северо-восток: {npc:8420}.",
	-- ["Class trainer"] = "Учитель классовых навыков",
	-- ["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Летите из места {area:1237} в {zone:1454}, выйдите из главных ворот к башням дирижаблей и летите на дирижабле: {object:3202}.",
	-- ["Fly to the {area:1497}"] = "Летите: {area:1497}",
	-- ["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Летите в {zone:1456}; это по пути к месту {area:1099}. Маршрута полета туда еще нет? Летите в {area:378} и езжайте на запад через {zone:1412}. Хамуул и {npc:4046} — здесь: {area:1639}; друиды и паладины обучаются здесь ({npc:3033}, {npc:246344}).",
	-- ["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Идите по дороге на юг; василиски греются на камнях к востоку от нее посреди джунглей. Осколки падают часто.",
	-- ["From {area:3317}'s flight master, fly to the {area:1497}."] = "От распорядителя полетов ({area:3317}) летите в {area:1497}.",
	-- ["Highborne and Haldarr satyrs"] = "Высокорожденные и сатиры из племени Халдарр",
	-- ["Ironjaw Basilisks"] = "Железозубые василиски",
	-- ["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Сохраните доставки для {npc:4046}, NPC {npc:8659} и {npc:6522}: позже вы будете проезжать {zone:1456}, {zone:1454} и {zone:1458}.",
	-- ["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Сохраните {area:1417} для {npc:7771} ({zone:1446}).",
	-- ["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Сохраните плату ({npc:8659}) и задание Аг'тора «{quest:3504}»: они вернутся в {area:1237} при следующем визите.",
	-- ["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}, and its experience shortens the top-up to 50 in {zone:1447}."] = "По пути через {zone:1454} к распорядителю полетов загляните на Волок: {npc:7010} принимает отчет о насекомых из зоны {zone:1446}, а его опыт сокращает добор до 50-го уровня в зоне {zone:1447}.",
	-- ["Only once all three robots are home"] = "Только когда все три робота дома",
	-- ["Ride into {area:16}"] = "Въезжайте: {area:16}",
	-- ["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Езжайте на северо-восток к лагерю гоблина на скалах над местом {area:1227}.",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Езжайте на северо-запад: {area:1108}; {npc:14637} ждет на причале.",
	-- ["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Езжайте на юго-запад к руинам. Четыре скрижали лежат среди руин под охраной наг из клана Бича Злобы; у любой сирены или мирмидона может оказаться руна ({npc:8420}).",
	-- ["Ride west back to {area:1237}."] = "Езжайте на запад обратно: {area:1237}.",
	-- ["Sea elementals"] = "Морские элементали",
	-- ["South of the {area:1938} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end: {npc:11758}'s quest, carried from your first {zone:1446} visit."] = "К югу от места {area:1938} огры из племени Тяжкого Молота держат свое укрепление; в его восточном конце — {npc:12046}: задание от {npc:11758}, взятое при первом визите в зону {zone:1446}.",
	-- ["Take the zeppelin back to {zone:1454}."] = "Летите на дирижабле обратно: {zone:1454}.",
	-- ["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Летите на дирижабле в {zone:1454} от башни у города {zone:1458}, затем летите в {area:431}.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Морские элементали и морские валы плещутся у берега вокруг причала.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Морские элементали и морские брызги плещутся вдоль берега вокруг причала.\nСухопутные бродяги и скальные великаны бродят по холмам к северу от причала. Сначала ударьте каждого предметом {item:18904}: уменьшенные, они больше не элита. С каждого уменьшенного великана падает осадок; используйте на его теле и сосуд для уменьшенных горных великанов.",
	-- ["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Громоголовые гиппогрифы летают над холмами чуть южнее места {area:1237}.",
	-- ["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "Лагерь эльфов крови — чуть южнее: {npc:8420}. Четыре предмета его снаряжения лежат в ящиках вокруг лагеря.",
	-- ["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Лесные дракончики порхают в лесу чуть западнее лагеря. Используйте сосуд на каждом убитом.",
	-- ["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Гиппогрифы гнездятся на холмах к юго-западу от лагеря. Убейте одного, затем используйте сосуд для уменьшенных гиппогрифов на его теле.",
	-- ["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Древни бродят по лесным дорогам между лагерем и центром зоны {zone:1444}; их немного, так что ищите вдоль троп.",
	-- ["The {object:2076} beside {npc:2519}"] = "{object:2076} рядом с NPC {npc:2519}",
	-- ["To {object:3202}"] = "Путь: {object:3202}",
	-- ["Undamaged Hippogryph Feathers"] = "Неповрежденные перья гиппогрифа",
	-- ["Upstairs"] = "Наверху",
	-- ["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (48-50) are {npc:7876}'s, carried from your first {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop, with {npc:11758}'s."] = "К западу от укрепления, по пути к спуску в Ун'Горо: бугристые шипошкуры и корневеды (48-50) для задания {quest:3362} — от {npc:7876}, взятого при первом визите в зону {zone:1446}. Они много бродят: вытягивайте по одному. {npc:7876} примет их на остановке ({area:976}) в следующем гайде, вместе с заданием от {npc:11758}.",
	-- ["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "Башня Ксилема стоит на скале чуть севернее места {area:1237}; тропа вьется по ее северной стороне.",
	-- ["Zapped giants"] = "Уменьшенные великаны",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108}: убивайте их по пути",
	-- ["{area:75} flight master"] = "Распорядитель полетов: {area:75}",
	-- ["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} – здесь: {zone:1456}; в городе {zone:1454} нет учителя паладинов",
	-- ["{npc:7010}, the Drag: if you still carry it"] = "{npc:7010}, Волок: если оно еще у вас",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: медведи — в зоне {zone:1448}",
	-- ["{npc:7825} stands in the {object:36082}."] = "{npc:7825} стоит здесь: {object:36082}.",
	-- ["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "Смола ({npc:7876}) и образцы Пестычинса — из зоны {zone:1449}.",
	-- ["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, на восточном краю лагеря: опыта нет, только телепорт в башню Азшары",
	-- ["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- ["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} собирается в следующем гайде; плату {npc:4046} позже отнесете: {npc:8587}.",
	-- ["{quest:4494} needs level 50: {npc:7010}, in the Drag, gives it from then on. Under 50, the {zone:1447} guide at 55 offers it again."] = "{quest:4494} требует 50-го уровня: с этого момента его дает {npc:7010} на Волоке. Если вы ниже 50-го, задание снова предложит гайд по зоне {zone:1447} на 55-м уровне.",
}
