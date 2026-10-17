-- Russian (ruRU): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Летите: {area:1497}",
	-- {area:3317} Revantusk Village · {area:1497} Undercity
	["From {area:3317}'s flight master, fly to the {area:1497}."] = "От распорядителя полетов ({area:3317}) летите в {area:1497}.",

	-- Step 2: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825} стоит здесь: {object:36082}.",

	-- Step 3: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:431} Splintertree Post
	["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Летите на дирижабле в {zone:1454} от башни у города {zone:1458}, затем летите в {area:431}.",

	-- Step 4: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Въезжайте: {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Езжайте на восток по дороге от Заставы Расщепленного Дерева. {npc:11548} ждет здесь: {area:1235}, чуть в стороне от дороги, в нескольких шагах к западу от места {area:3137} (Альянс): подходите с запада и держитесь подальше от часовых Азшары и Джарродена (элита).",

	-- Step 5: Highborne and Haldarr satyrs
	["Highborne and Haldarr satyrs"] = "Высокорожденные и сатиры из племени Халдарр",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "Призраки высокорожденных бродят по руинам чуть севернее святилища; сатиры из племени Халдарр стоят лагерем немного дальше на север.",

	-- Step 6: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Вернитесь: {npc:11548}, у святилища; держитесь западнее стражи места {area:3137}.",

	-- Step 7: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Идите по дороге на север: {area:1237}, лагерь Орды.",
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, на восточном краю лагеря: опыта нет, только телепорт в башню Азшары",

	-- Step 8: Undamaged Hippogryph Feathers
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Undamaged Hippogryph Feathers"] = "Неповрежденные перья гиппогрифа",
	-- {area:1237} Valormok
	-- plural, as words: Thunderhead Hippogryphs = {npc:6375} Thunderhead Hippogryph
	["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Громоголовые гиппогрифы летают над холмами чуть южнее места {area:1237}.",

	-- Step 10: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Езжайте на северо-восток к лагерю гоблина на скалах над местом {area:1227}.",

	-- Step 11: Thalassian Base Camp
	-- {npc:8420} Kim'jael
	["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "Лагерь эльфов крови — чуть южнее: {npc:8420}. Четыре предмета его снаряжения лежат в ящиках вокруг лагеря.",

	-- Step 13: Ruins of Eldarath
	-- {npc:8420} Kim'jael
	["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Езжайте на юго-запад к руинам. Четыре скрижали лежат среди руин под охраной наг из клана Бича Злобы; у любой сирены или мирмидона может оказаться руна ({npc:8420}).",

	-- Step 14: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-east to {npc:8420}."] = "Обратно на северо-восток: {npc:8420}.",

	-- Step 15: Jediga
	-- {area:1237} Valormok
	["Ride west back to {area:1237}."] = "Езжайте на запад обратно: {area:1237}.",
	-- {npc:4046} Magatha Grimtotem · {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Сохраните доставки для {npc:4046}, NPC {npc:8659} и {npc:6522}: позже вы будете проезжать {zone:1456}, {zone:1454} и {zone:1458}.",

	-- Step 16: Archmage Xylem
	-- {area:1237} Valormok
	["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "Башня Ксилема стоит на скале чуть севернее места {area:1237}; тропа вьется по ее северной стороне.",

	-- Step 18: To Grom'gol
	-- {object:3202} Grom'gol
	["To {object:3202}"] = "Путь: {object:3202}",
	-- {area:1237} Valormok · {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Летите из места {area:1237} в {zone:1454}, выйдите из главных ворот к башням дирижаблей и летите на дирижабле: {object:3202}.",

	-- Step 19: Grom'gol Base Camp
	-- {object:2076} Bubbling Cauldron · {npc:2519} Kin'weelay
	["The {object:2076} beside {npc:2519}"] = "{object:2076} рядом с NPC {npc:2519}",

	-- Step 20: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Железозубые василиски",
	["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Идите по дороге на юг; василиски греются на камнях к востоку от нее посреди джунглей. Осколки падают часто.",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["Continue south to {area:35}. {npc:7406} has his workshop on the upper ring of the bay."] = "Продолжайте на юг: {area:35}. Мастерская ({npc:7406}) — на верхнем ярусе бухты.",
	["Only once all three robots are home"] = "Только когда все три робота дома",

	-- Step 22: Back to Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}"] = "Вернитесь: {object:3202}",

	-- Step 23: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Take the zeppelin back to {zone:1454}."] = "Летите на дирижабле обратно: {zone:1454}.",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, Волок",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:8659} Jes'rimon · {quest:3504} Betrayed · {area:1237} Valormok
	["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Сохраните плату ({npc:8659}) и задание Аг'тора «{quest:3504}»: они вернутся в {area:1237} при следующем визите.",

	-- Step 24: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {area:1638}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Летите в {area:1638}; это по пути к месту {area:1099}. Маршрута полета туда еще нет? Летите в {area:378} и езжайте на запад через {zone:1412}. Хамуул и {npc:4046} — здесь: {area:1639}; друиды и паладины обучаются здесь ({npc:3033}, {npc:246344}).",
	-- {quest:3761} Un'Goro Soil · {npc:4046} Magatha Grimtotem · {npc:8587} Jediga
	["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} собирается в следующем гайде; плату {npc:4046} позже отнесете: {npc:8587}.",

	-- Step 25: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: медведи — в зоне {zone:1448}",
	-- {area:1417} Sunken Temple · {npc:7771} Marvon Rivetseeker · {zone:1446} Tanaris
	["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Сохраните {area:1417} для {npc:7771} ({zone:1446}).",

	-- Step 26: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Блеклоперые гиппогрифы",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Гиппогрифы гнездятся на холмах к юго-западу от лагеря. Убейте одного, затем используйте сосуд для уменьшенных гиппогрифов на его теле.",

	-- Step 28: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Летучие хамелеоны",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Лесные дракончики порхают в лесу чуть западнее лагеря. Используйте сосуд на каждом убитом.",

	-- Step 30: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Бродячие лесные древни",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Древни бродят по лесным дорогам между лагерем и центром зоны {zone:1444}; их немного, так что ищите вдоль троп.",

	-- Step 32: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Езжайте на северо-запад: {area:1108}; {npc:14637} ждет на причале.",

	-- Step 33: Zapped giants
	["Zapped giants"] = "Уменьшенные великаны",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Сухопутные бродяги и скальные великаны бродят по холмам к северу от причала. Сначала ударьте каждого предметом {item:18904}: уменьшенные, они больше не элита. С каждого уменьшенного великана падает осадок; используйте на его теле и сосуд для уменьшенных горных великанов.",

	-- Step 34: Sea elementals
	["Sea elementals"] = "Морские элементали",
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Морские элементали и морские валы плещутся у берега вокруг причала.",

	-- Step 36: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "Вернитесь: {area:1099}",

	-- Step 37: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, рядом с распорядителем ветрокрылов",
	-- {npc:7876} Tran'rek · {zone:1449} Un'Goro Crater
	["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "Смола ({npc:7876}) и образцы Пестычинса — из зоны {zone:1449}.",

	-- Step 38: Broken Pillar
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Езжайте на юг по дороге к месту {area:1938}; {npc:7771} стоит лагерем рядом. Отсюда дорога на запад ведет вниз в {zone:1449}, где начинается следующий гайд.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Сохраните {quest:3444}: сундук {npc:7771} откроется при следующем визите.",
}
