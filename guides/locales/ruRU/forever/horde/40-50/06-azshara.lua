-- Russian (ruRU): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "Летите: {object:3202}",
	-- {area:75} Stonard
	["{area:75} flight master"] = "",

	-- Step 3: To Grom'gol
	-- {object:3202} Grom'gol
	["To {object:3202}"] = "Путь: {object:3202}",
	-- {area:75} Stonard · {area:117} Grom'gol Base Camp
	["The flight from {area:75} lands at {area:117}."] = "Полет из места {area:75} заканчивается здесь: {area:117}.",

	-- Step 5: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Летите: {area:35}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 6: Booty Bay
	-- {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["Continue south to {area:35}. {npc:7406} has his workshop on the upper ring of the bay."] = "Продолжайте на юг: {area:35}. Мастерская ({npc:7406}) — на верхнем ярусе бухты.",
	-- {npc:7406} Oglethorpe Obnoticus
	["{npc:7406}, inside"] = "",
	["Only once all three robots are home"] = "Только когда все три робота дома",
	-- {npc:2491} Whiskey Slim
	["{npc:2491}, in the inn"] = "",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, on the balcony of the same building"] = "",

	-- Step 7: The Bloodsail ships
	["The Bloodsail ships"] = "Корабли Кровавого Паруса",
	-- {area:43} Wild Shore · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["South of Booty Bay, three Bloodsail ships lie off the {area:43}: {npc:2550}, {npc:2548} and {npc:2546} each stand on a deck with their crews. Swim out and work from ship to ship."] = "",

	-- Step 9: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 14: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 15: Back to Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}"] = "Вернитесь: {object:3202}",

	-- Step 16: The Mind's Eye
	-- {npc:818} Mai'Zoth
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:818} (level 47 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\nCareful: Two elite caster guards, around level 45, stand with {npc:818} and join the fight together with him."] = "",
	["Below ground"] = "",

	-- Step 20: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",

	-- Step 22: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Въезжайте: {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Езжайте на восток по дороге от Заставы Расщепленного Дерева. {npc:11548} ждет здесь: {area:1235}, чуть в стороне от дороги, в нескольких шагах к западу от места {area:3137} (Альянс): подходите с запада и держитесь подальше от часовых Азшары и Джарродена (элита).",

	-- Step 23: Haldarr Encampment: kill these as you meet them
	-- {area:1236} Haldarr Encampment
	["{area:1236}: kill these as you meet them"] = "",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "Призраки высокорожденных бродят по руинам чуть севернее святилища; сатиры из племени Халдарр стоят лагерем немного дальше на север.",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} walks around {area:1235}: look inside the circle on the map"] = "",

	-- Step 24: Level 50
	["Level 50"] = "",
	-- {quest:4493} March of the Silithid · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar · {zone:1447} Azshara · {area:2100} Maraudon · {area:1417} Sunken Temple
	["Top up here to level 50: {quest:4493}, from {npc:7010} in {zone:1454} at the end of {zone:1447}, needs it. Or, with a group, run the {area:2100} dungeon or the {area:1417} dungeon instead."] = "",
	-- {npc:6125} Haldarr Satyr
	["grind on {npc:6125}"] = "",

	-- Step 25: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Вернитесь: {npc:11548}, у святилища; держитесь западнее стражи места {area:3137}.",

	-- Step 26: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Идите по дороге на север: {area:1237}, лагерь Орды.",
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, на восточном краю лагеря: опыта нет, только телепорт в башню Азшары",

	-- Step 28: Undamaged Hippogryph Feathers
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Undamaged Hippogryph Feathers"] = "Неповрежденные перья гиппогрифа",
	-- {area:1237} Valormok
	-- plural, as words: Thunderhead Hippogryphs = {npc:6375} Thunderhead Hippogryph
	["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Громоголовые гиппогрифы летают над холмами чуть южнее места {area:1237}.",

	-- Step 30: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Езжайте на северо-восток к лагерю гоблина на скалах над местом {area:1227}.",

	-- Step 31: Thalassian Base Camp
	-- {npc:8420} Kim'jael
	["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "Лагерь эльфов крови — чуть южнее: {npc:8420}. Четыре предмета его снаряжения лежат в ящиках вокруг лагеря.",

	-- Step 33: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "",
	-- {npc:8420} Kim'jael
	["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Езжайте на юго-запад к руинам. Четыре скрижали лежат среди руин под охраной наг из клана Бича Злобы; у любой сирены или мирмидона может оказаться руна ({npc:8420}).",

	-- Step 34: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-east to {npc:8420}."] = "Обратно на северо-восток: {npc:8420}.",

	-- Step 35: Jediga
	-- {area:1237} Valormok
	["Ride west back to {area:1237}."] = "Езжайте на запад обратно: {area:1237}.",
	-- {npc:4046} Magatha Grimtotem · {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Сохраните доставки для {npc:4046}, NPC {npc:8659} и {npc:6522}: позже вы будете проезжать {zone:1456}, {zone:1454} и {zone:1458}.",

	-- Step 36: Archmage Xylem
	-- {area:1237} Valormok
	["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "Башня Ксилема стоит на скале чуть севернее места {area:1237}; тропа вьется по ее северной стороне.",
	["Upstairs"] = "",

	-- Step 38: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "",

	-- Step 39: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, Волок",

	-- Step 40: Orgrimmar
	-- {npc:8659} Jes'rimon · {quest:3504} Betrayed · {area:1237} Valormok
	["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Сохраните плату ({npc:8659}) и задание Аг'тора «{quest:3504}»: они вернутся в {area:1237} при следующем визите.",

	-- Step 41: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 42: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Летите сюда: {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 43: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Летите в {zone:1456}; это по пути к месту {area:1099}. Маршрута полета туда еще нет? Летите в {area:378} и езжайте на запад через {zone:1412}. Хамуул и {npc:4046} — здесь: {area:1639}; друиды и паладины обучаются здесь ({npc:3033}, {npc:246344}).",

	-- Step 44: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 45: Thunder Bluff
	-- {quest:3761} Un'Goro Soil · {npc:4046} Magatha Grimtotem · {npc:8587} Jediga
	["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} собирается в следующем гайде; плату {npc:4046} позже отнесете: {npc:8587}.",

	-- Step 46: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Летите сюда: {area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 47: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: медведи — в зоне {zone:1448}",

	-- Step 48: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Блеклоперые гиппогрифы",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Гиппогрифы гнездятся на холмах к юго-западу от лагеря. Убейте одного, затем используйте сосуд для уменьшенных гиппогрифов на его теле.",

	-- Step 50: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Летучие хамелеоны",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Лесные дракончики порхают в лесу чуть западнее лагеря. Используйте сосуд на каждом убитом.",

	-- Step 52: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Бродячие лесные древни",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Древни бродят по лесным дорогам между лагерем и центром зоны {zone:1444}; их немного, так что ищите вдоль троп.",

	-- Step 55: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray · Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "",

	-- Step 57: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "Вернитесь: {area:1099}",

	-- Step 58: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Летите сюда: {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 59: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, рядом с распорядителем ветрокрылов",
	-- {npc:7876} Tran'rek · {zone:1449} Un'Goro Crater
	["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "Смола ({npc:7876}) и образцы Пестычинса — из зоны {zone:1449}.",

	-- Step 60: Marvon Rivetseeker
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Езжайте на юг по дороге к месту {area:1938}; {npc:7771} стоит лагерем рядом. Отсюда дорога на запад ведет вниз в {zone:1449}, где начинается следующий гайд.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Сохраните {quest:3444}: сундук {npc:7771} откроется при следующем визите.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Летите из места {area:1237} в {zone:1454}, выйдите из главных ворот к башням дирижаблей и летите на дирижабле: {object:3202}.",
	-- ["Fly to the {area:1497}"] = "Летите: {area:1497}",
	-- ["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Идите по дороге на юг; василиски греются на камнях к востоку от нее посреди джунглей. Осколки падают часто.",
	-- ["From {area:3317}'s flight master, fly to the {area:1497}."] = "От распорядителя полетов ({area:3317}) летите в {area:1497}.",
	-- ["Highborne and Haldarr satyrs"] = "Высокорожденные и сатиры из племени Халдарр",
	-- ["Ironjaw Basilisks"] = "Железозубые василиски",
	-- ["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Сохраните {area:1417} для {npc:7771} ({zone:1446}).",
	-- ["Ride into {area:16}"] = "Въезжайте: {area:16}",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Езжайте на северо-запад: {area:1108}; {npc:14637} ждет на причале.",
	-- ["Sea elementals"] = "Морские элементали",
	-- ["Take the zeppelin back to {zone:1454}."] = "Летите на дирижабле обратно: {zone:1454}.",
	-- ["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Летите на дирижабле в {zone:1454} от башни у города {zone:1458}, затем летите в {area:431}.",
	-- ["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Сухопутные бродяги и скальные великаны бродят по холмам к северу от причала. Сначала ударьте каждого предметом {item:18904}: уменьшенные, они больше не элита. С каждого уменьшенного великана падает осадок; используйте на его теле и сосуд для уменьшенных горных великанов.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Морские элементали и морские валы плещутся у берега вокруг причала.",
	-- ["The {object:2076} beside {npc:2519}"] = "{object:2076} рядом с NPC {npc:2519}",
	-- ["Zapped giants"] = "Уменьшенные великаны",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: медведи — в зоне {zone:1448}",
	-- ["{npc:7825} stands in the {object:36082}."] = "{npc:7825} стоит здесь: {object:36082}.",
}
