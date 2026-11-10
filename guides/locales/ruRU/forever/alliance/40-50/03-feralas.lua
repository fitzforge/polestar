-- Russian (ruRU): the guide forever/alliance/40-50/03-feralas (forever/alliance/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into The Barrens
	-- {zone:1413} The Barrens
	["Into {zone:1413}"] = "",

	-- Step 2: Thalanaar flight master
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "",

	-- Step 3: Boat to Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold
	["Boat to {area:1116}"] = "",

	-- Step 4: Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold · {area:1120} Sardor Isle · {area:1108} Forgotten Coast · {npc:7880} Ginro Hearthkindle
	["{area:1116} stands on {area:1120}, off the {area:1108}: the boat from the coast's dock crosses to it. {npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:3936} Shandris Feathermoon
	["{npc:3936}, beside him"] = "{npc:3936}, рядом с ним",
	-- {npc:7877} Latronicus Moonspear
	["{npc:7877}, at the top of the stronghold"] = "{npc:7877}, на вершине крепости",
	-- {npc:7764} Troyas Moonbreeze · {area:702} Rut'theran Village
	["{npc:7764}: his answer waits in {area:702}, later"] = "{npc:7764}: его ответ ждет в месте {area:702}, позже",

	-- Step 5: Ruins of Solarsal
	["Walk south along the island to the naga ruins; the gazebo stands among them."] = "Идите на юг по острову к руинам наг; беседка стоит среди них.",

	-- Step 7: Hatecrest naga
	["Hatecrest naga"] = "Наги из клана Гребня Ненависти",
	-- {area:1117} Ruins of Solarsal
	["Back to the {area:1117}. Every Hatecrest naga there can drop scales."] = "Вернитесь сюда: {area:1117}. С любой наги из клана Гребня Ненависти там может выпасть чешуя.",

	-- Step 8: Feathermoon Stronghold
	-- {npc:8136} Lord Shalzaru
	["{npc:8136} waits for the end of the mainland loop."] = "{npc:8136} ждет до конца круга по материку.",

	-- Step 9: Boat to Forgotten Coast
	-- {area:1108} Forgotten Coast
	["Boat to {area:1108}"] = "",

	-- Step 10: Feralas
	["The courier's boat"] = "Лодка курьера",

	-- Step 11: The courier's boat
	-- {area:1108} Forgotten Coast
	["Take the boat to the {area:1108} and follow the shore south to the wrecked row boat on the beach."] = "Плывите на корабле сюда: {area:1108}, и идите вдоль берега на юг к разбитой шлюпке на пляже.",

	-- Step 12: Gordunni ogres
	["Gordunni ogres"] = "Огры из клана Гордунни",
	["Ride east to the Gordunni camp in the hills south-east of the yeti valley: Warlocks and Shaman hold the camp, Brutes wander the slopes around it and further north."] = "Езжайте на восток к Поселению Гордунни на холмах к юго-востоку от долины йети: в лагере чернокнижники и шаманы, громилы бродят по склонам вокруг и севернее.",

	-- Step 13: Feral Scar Vale
	-- {npc:5346} Bloodroar the Stalker
	["Ride north into the yeti valley. Every Feral Scar yeti can drop a thick hide; {npc:5346} (level 48) prowls the middle."] = "Езжайте на север в долину йети. С любого йети со Свирепого Утеса может выпасть толстая шкура; {npc:5346} (уровень 48) рыщет в центре.",

	-- Step 14: Isle of Dread
	-- {area:1121} Isle of Dread · {area:1120} Sardor Isle · {npc:8136} Lord Shalzaru
	-- plural, as words: Hatecrest Serpent Guards = {npc:5333} Hatecrest Serpent Guard
	["The {area:1121} is the island just south of {area:1120}: swim over. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "",
	-- {item:9248} Mysterious Relic
	["{item:9248}; below ground"] = "",

	-- Step 15: Feathermoon Stronghold
	-- {npc:7877} Latronicus Moonspear · {npc:7878} Vestia Moonspear · {npc:7900} Angelas Moonbreeze · {npc:7880} Ginro Hearthkindle · {npc:7852} Pratt McGrubben
	["Coming from the south: {npc:7877} and {npc:7878} first, then {npc:7900} beside {npc:7880}'s building, then the stairs. {npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. {npc:7852} is by the flight master, on the way out."] = "",
	-- {npc:7879} Quintis Jonespyre
	["{npc:7879}, upstairs"] = "",

	-- Step 16: Fly to Thalanaar
	-- {area:489} Thalanaar
	["Fly to {area:489}"] = "",
	["Feathermoon flight master"] = "",

	-- Step 17: Feralas
	["Grimtotem camp"] = "Лагерь Зловещего Тотема",

	-- Step 18: Grimtotem camp
	-- {area:489} Thalanaar · {npc:7956} Kindal Moonweaver
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["From {area:489} ride west along the road to the Grimtotem camp north of it. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "",

	-- Step 19: Grimtotem tauren
	["Grimtotem tauren"] = "Таурены из племени Зловещего Тотема",

	-- Step 20: Jer'kai Moonweaver
	-- {zone:1457} Darnassus
	["for Tyrande in {zone:1457}: the route takes you there at 47"] = "для Тиранды ({zone:1457}): маршрут приведет вас туда на 47-м уровне",

	-- Step 21: The Writhing Deep
	-- {area:489} Thalanaar
	["Ride south-east to the Woodpaw gnolls; the courier's backpacks lie in their southern camp, and a parcel inside them starts a delivery to {area:489}. The Zukk'ash hive is just south: fight down to the pod that holds Raschal, free him and keep him alive on the way out."] = "Езжайте на юго-восток к гноллам из стаи Древолапов; рюкзаки курьера лежат в их южном лагере, а посылка в них начинает доставку в {area:489}. Улей Зуккаш чуть южнее: пробейтесь к коконам, где держат Раскала, освободите его и сохраните ему жизнь на пути наружу.",
	-- {item:11463} Undelivered Parcel
	["{item:11463}, from the backpacks"] = "{item:11463}, из рюкзаков",
	-- {object:164954} Zukk'ash Pod
	["{object:164954}, inside"] = "",

	-- Step 22: High Wilderness: kill these as you meet them
	-- {area:1136} High Wilderness
	["{area:1136}: kill these as you meet them"] = "",
	-- {quest:7735} Pristine Yeti Hide · {npc:7852} Pratt McGrubben · {npc:14637} Zorbin Fandazzle · {area:978} Zul'Farrak
	["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide, and about one in thirty a {quest:7735}, which {npc:7852} pays for too.\n{npc:14637}'s quests on the coast need level 45: grind the yetis here until level 44.5, so the kills also bring {npc:7852}'s hides. Or, with a group, run the {area:978} dungeon instead."] = "",
	-- {npc:5296} Rage Scar Yeti
	["grind on {npc:5296}"] = "",

	-- Step 23: Rage Scar Hold
	-- {quest:7735} Pristine Yeti Hide
	["No {quest:7735} yet? Keep killing the Rage Scar yetis until one drops, then right-click it."] = "",

	-- Step 24: Feathermoon Stronghold
	-- {npc:7880} Ginro Hearthkindle
	["{npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 25: Feathermoon Stronghold
	-- {npc:3936} Shandris Feathermoon · {zone:1457} Darnassus · {area:976} Gadgetzan
	["{npc:3936} then asks you to carry news to {zone:1457}: skip it, {area:976} sends you there instead."] = "Затем {npc:3936} просит отнести вести в {zone:1457}: пропустите, {area:976} сам отправит вас туда.",

	-- Step 27: Grind to 45
	["Grind to 45"] = "Гринд до 45",
	-- {area:1105} Feral Scar Vale · {npc:14637} Zorbin Fandazzle · {area:978} Zul'Farrak · {area:1517} Uldaman
	["Ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45. Or, with a group, run the {area:978} dungeon or the {area:1517} dungeon instead."] = "",
	-- {npc:5292} Feral Scar Yeti · {area:1105} Feral Scar Vale · {zone:1444} Feralas
	["grind on {npc:5292} at {area:1105}, {zone:1444}"] = "гринд: {npc:5292}, {area:1105}, {zone:1444}",

	-- Step 28: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast
	["Ride back to the {area:1108}; the goblin stands by the dock."] = "Езжайте обратно сюда: {area:1108}; гоблин стоит у причала.",

	-- Step 29: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Shore Striders = {npc:5359} Shore Strider · Deep Striders = {npc:5360} Deep Strider · Wave Striders = {npc:5361} Wave Strider · Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Shore Striders, Deep Striders and Wave Striders (elite giants) wade along the coast north of the dock: zap one with {item:18904} and kill the shrunken giant. Sea Elementals and Sea Sprays drift in the same surf."] = "Береговые странники, странники глубин и странники волн (элитные великаны) бродят по мелководью к северу от причала: ударьте одного предметом {item:18904} и убейте уменьшенного великана. Морские элементали и морские валы плавают в том же прибое.",

	-- Step 30: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["{npc:14637}'s refills are level 55: skip them."] = "Пополнения {npc:14637} — 55-го уровня: пропустите их.",
	-- {zone:1446} Tanaris · {area:489} Thalanaar
	["The {zone:1446} guide starts with the trip east, past {area:489}."] = "",

	-- Step 31: Thalanaar
	-- {zone:1441} Thousand Needles
	["Ride north-east to the night elf outpost on the {zone:1441} border."] = "Езжайте на северо-восток к заставе ночных эльфов на границе зоны {zone:1441}.",
	-- {npc:4048} Falfindel Waywarder · {area:489} Thalanaar
	["{npc:4048} walks around {area:489}: look inside the circle on the map"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to the {area:1108} and ride east across {zone:1444} to the Grimtotem camp north of the road. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "Плывите на корабле сюда: {area:1108}, и езжайте на восток через {zone:1444} к лагерю Зловещего Тотема к северу от дороги. {npc:7956} ждет снаружи; освободите летучих хамелеонов из загона в центре и сохраните жизнь NPC {npc:7956} и хотя бы шести из них.",
	-- ["Boat to the {area:1108} and ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45."] = "Плывите на корабле сюда: {area:1108}, и езжайте на восток: {area:1105}. Заданиям {npc:14637} на побережье нужен 45-й уровень.",
	-- ["From Theramore, fly to {area:608} and ride south out of {zone:1443} into {zone:1444}; the road leads west to the {area:1108} dock, where the boat crosses to Feathermoon on {area:1120}."] = "Из Терамора летите в {area:608} и езжайте на юг из зоны {zone:1443} в {zone:1444}; дорога ведет на запад к причалу ({area:1108}), откуда корабль идет в Крепость Оперенной Луны ({area:1120}).",
	-- ["Giants and elementals"] = "Великаны и элементали",
	-- ["Hearth to Feathermoon."] = "Используйте Камень возвращения: Крепость Оперенной Луны.",
	-- ["Rage Scar yetis"] = "Йети Бешеного оврага",
	-- ["Ride back north-west to the {area:1108} dock and take the boat to the island."] = "Езжайте обратно на северо-запад к причалу ({area:1108}) и плывите на корабле на остров.",
	-- ["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide; one may drop a {quest:7735}, which {npc:7852} pays for too."] = "Езжайте обратно на запад по дороге, затем на север к холмам Бешеного оврага. С любого йети здесь может выпасть шкура; с одного может выпасть {quest:7735}, за нее {npc:7852} тоже платит.",
	-- ["Ride west to the friendly mountain giant at the foot of the hills. Land Walkers and Cliff Giants around him are elite: give them room."] = "Езжайте на запад к дружелюбному горному великану у подножия холмов. Сухопутные бродяги и скальные великаны вокруг него — элита: держитесь подальше.",
	-- ["Ring the bell whenever {npc:7774} stops to wander, and lead her south to {npc:7765}."] = "Звоните в колокольчик всякий раз, когда {npc:7774} останавливается побродить, и ведите ее на юг к NPC {npc:7765}.",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in northern {zone:1446}, the next zone on the route; come back to {npc:14637} on the {area:1108} afterwards."] = "Прохождение подземелья {area:978} вместо гринда в группе быстрее. Город троллей — на севере зоны {zone:1446}, следующей зоны маршрута; после этого вернитесь к {npc:14637} ({area:1108}).",
	-- ["Swim south from the island to the {area:1121}. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "Плывите с острова на юг: {area:1121}. Там змеестражи и колдуньи из клана Гребня Ненависти; {npc:8136} (уровень 47) ждет в пещере на южном краю. Сначала выманите его стражу.",
	-- ["You end at the {area:1108} dock: the {zone:1446} guide starts with the trip east from here."] = "Вы заканчиваете у причала ({area:1108}): гайд по зоне {zone:1446} начинается с пути отсюда на восток.",
	-- ["grind on {npc:5292} at {area:1105}, {area:357}"] = "гринд: {npc:5292}, {area:1105}, {area:357}",
	-- ["if you carry {quest:1100} from {zone:1441}"] = "если у вас есть {quest:1100} из зоны {zone:1441}",
	-- ["{area:978} instead of grinding"] = "{area:978} вместо гринда",
	-- ["{npc:7774} wanders the hills north of {npc:7765}, among the Northspring harpies; her bell is in the chest beside her."] = "{npc:7774} бродит по холмам к северу от NPC {npc:7765}, среди гарпий из стаи Студеных Ключей; ее колокольчик в сундуке рядом.",
	-- ["{npc:7774}'s escort"] = "Сопровождение: {npc:7774}",
}
