-- Russian (ruRU): the guide forever/alliance/40-50/03-feralas (forever/alliance/40-50/03-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Feathermoon Stronghold
	-- {area:608} Nijel's Point · {zone:1443} Desolace · {zone:1444} Feralas · {area:1108} Forgotten Coast · {area:1120} Sardor Isle
	["From Theramore, fly to {area:608} and ride south out of {zone:1443} into {zone:1444}; the road leads west to the {area:1108} dock, where the boat crosses to Feathermoon on {area:1120}."] = "Из Терамора летите в {area:608} и езжайте на юг из зоны {zone:1443} в {zone:1444}; дорога ведет на запад к причалу ({area:1108}), откуда корабль идет в Крепость Оперенной Луны ({area:1120}).",
	-- {npc:7877} Latronicus Moonspear
	["{npc:7877}, at the top of the stronghold"] = "{npc:7877}, на вершине крепости",
	-- {npc:3936} Shandris Feathermoon
	["{npc:3936}, beside him"] = "{npc:3936}, рядом с ним",
	-- {npc:7764} Troyas Moonbreeze · {area:702} Rut'theran Village
	["{npc:7764}: his answer waits in {area:702}, later"] = "{npc:7764}: его ответ ждет в месте {area:702}, позже",

	-- Step 2: Ruins of Solarsal
	["Walk south along the island to the naga ruins; the gazebo stands among them."] = "Идите на юг по острову к руинам наг; беседка стоит среди них.",

	-- Step 4: Hatecrest naga
	["Hatecrest naga"] = "Наги из клана Гребня Ненависти",
	-- {area:1117} Ruins of Solarsal
	["Back to the {area:1117}. Every Hatecrest naga there can drop scales."] = "Вернитесь сюда: {area:1117}. С любой наги из клана Гребня Ненависти там может выпасть чешуя.",

	-- Step 5: Feathermoon Stronghold
	-- {npc:8136} Lord Shalzaru
	["{npc:8136} waits for the end of the mainland loop."] = "{npc:8136} ждет до конца круга по материку.",

	-- Step 6: The courier's boat
	["The courier's boat"] = "Лодка курьера",
	-- {area:1108} Forgotten Coast
	["Take the boat to the {area:1108} and follow the shore south to the wrecked row boat on the beach."] = "Плывите на корабле сюда: {area:1108}, и идите вдоль берега на юг к разбитой шлюпке на пляже.",

	-- Step 7: Gordunni ogres
	["Gordunni ogres"] = "Огры из клана Гордунни",
	["Ride east to the Gordunni camp in the hills south-east of the yeti valley: Warlocks and Shaman hold the camp, Brutes wander the slopes around it and further north."] = "Езжайте на восток к Поселению Гордунни на холмах к юго-востоку от долины йети: в лагере чернокнижники и шаманы, громилы бродят по склонам вокруг и севернее.",

	-- Step 8: Feral Scar Vale
	-- {npc:5346} Bloodroar the Stalker
	["Ride north into the yeti valley. Every Feral Scar yeti can drop a thick hide; {npc:5346} (level 48) prowls the middle."] = "Езжайте на север в долину йети. С любого йети со Свирепого Утеса может выпасть толстая шкура; {npc:5346} (уровень 48) рыщет в центре.",

	-- Step 9: Feathermoon Stronghold
	-- {area:1108} Forgotten Coast
	["Ride back north-west to the {area:1108} dock and take the boat to the island."] = "Езжайте обратно на северо-запад к причалу ({area:1108}) и плывите на корабле на остров.",

	-- Step 10: Lord Shalzaru
	-- {area:1121} Isle of Dread · {npc:8136} Lord Shalzaru
	-- plural, as words: Hatecrest Serpent Guards = {npc:5333} Hatecrest Serpent Guard
	["Swim south from the island to the {area:1121}. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "Плывите с острова на юг: {area:1121}. Там змеестражи и колдуньи из клана Гребня Ненависти; {npc:8136} (уровень 47) ждет в пещере на южном краю. Сначала выманите его стражу.",

	-- Step 11: Feathermoon Stronghold
	["Hearth to Feathermoon."] = "Используйте Камень возвращения: Крепость Оперенной Луны.",

	-- Step 12: Grimtotem camp
	["Grimtotem camp"] = "Лагерь Зловещего Тотема",
	-- {area:1108} Forgotten Coast · {zone:1444} Feralas · {npc:7956} Kindal Moonweaver
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Boat to the {area:1108} and ride east across {zone:1444} to the Grimtotem camp north of the road. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "Плывите на корабле сюда: {area:1108}, и езжайте на восток через {zone:1444} к лагерю Зловещего Тотема к северу от дороги. {npc:7956} ждет снаружи; освободите летучих хамелеонов из загона в центре и сохраните жизнь NPC {npc:7956} и хотя бы шести из них.",

	-- Step 13: Grimtotem tauren
	["Grimtotem tauren"] = "Таурены из племени Зловещего Тотема",

	-- Step 14: Jer'kai Moonweaver
	-- {zone:1457} Darnassus
	["for Tyrande in {zone:1457}: the route takes you there at 47"] = "для Тиранды ({zone:1457}): маршрут приведет вас туда на 47-м уровне",

	-- Step 15: The Writhing Deep
	-- {area:489} Thalanaar
	["Ride south-east to the Woodpaw gnolls; the courier's backpacks lie in their southern camp, and a parcel inside them starts a delivery to {area:489}. The Zukk'ash hive is just south: fight down to the pod that holds Raschal, free him and keep him alive on the way out."] = "Езжайте на юго-восток к гноллам из стаи Древолапов; рюкзаки курьера лежат в их южном лагере, а посылка в них начинает доставку в {area:489}. Улей Зуккаш чуть южнее: пробейтесь к коконам, где держат Раскала, освободите его и сохраните ему жизнь на пути наружу.",
	-- {item:11463} Undelivered Parcel
	["{item:11463}, from the backpacks"] = "{item:11463}, из рюкзаков",

	-- Step 16: Thalanaar
	-- {zone:1441} Thousand Needles
	["Ride north-east to the night elf outpost on the {zone:1441} border."] = "Езжайте на северо-восток к заставе ночных эльфов на границе зоны {zone:1441}.",
	-- {quest:1100} Lonebrow's Journal · {zone:1441} Thousand Needles
	["if you carry {quest:1100} from {zone:1441}"] = "если у вас есть {quest:1100} из зоны {zone:1441}",

	-- Step 17: Rage Scar yetis
	["Rage Scar yetis"] = "Йети Бешеного оврага",
	-- {quest:7735} Pristine Yeti Hide · {npc:7852} Pratt McGrubben
	["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide; one may drop a {quest:7735}, which {npc:7852} pays for too."] = "Езжайте обратно на запад по дороге, затем на север к холмам Бешеного оврага. С любого йети здесь может выпасть шкура; с одного может выпасть {quest:7735}, за нее {npc:7852} тоже платит.",

	-- Step 18: Rockbiter
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["Ride west to the friendly mountain giant at the foot of the hills. Land Walkers and Cliff Giants around him are elite: give them room."] = "Езжайте на запад к дружелюбному горному великану у подножия холмов. Сухопутные бродяги и скальные великаны вокруг него — элита: держитесь подальше.",

	-- Step 19: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["{npc:7774} wanders the hills north of {npc:7765}, among the Northspring harpies; her bell is in the chest beside her."] = "{npc:7774} бродит по холмам к северу от NPC {npc:7765}, среди гарпий из стаи Студеных Ключей; ее колокольчик в сундуке рядом.",

	-- Step 20: Shay Leafrunner's escort
	-- {npc:7774} Shay Leafrunner
	["{npc:7774}'s escort"] = "Сопровождение: {npc:7774}",
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Ring the bell whenever {npc:7774} stops to wander, and lead her south to {npc:7765}."] = "Звоните в колокольчик всякий раз, когда {npc:7774} останавливается побродить, и ведите ее на юг к NPC {npc:7765}.",

	-- Step 21: Feathermoon Stronghold
	-- {npc:3936} Shandris Feathermoon · {zone:1457} Darnassus · {area:976} Gadgetzan
	["{npc:3936} then asks you to carry news to {zone:1457}: skip it, {area:976} sends you there instead."] = "Затем {npc:3936} просит отнести вести в {zone:1457}: пропустите, {area:976} сам отправит вас туда.",

	-- Step 22: Zul'Farrak instead of grinding
	-- {area:978} Zul'Farrak
	["{area:978} instead of grinding"] = "{area:978} вместо гринда",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {npc:14637} Zorbin Fandazzle · {area:1108} Forgotten Coast
	["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in northern {zone:1446}, the next zone on the route; come back to {npc:14637} on the {area:1108} afterwards."] = "Прохождение подземелья {area:978} вместо гринда в группе быстрее. Город троллей — на севере зоны {zone:1446}, следующей зоны маршрута; после этого вернитесь к {npc:14637} ({area:1108}).",

	-- Step 23: Grind to 45
	["Grind to 45"] = "Гринд до 45",
	-- {area:1108} Forgotten Coast · {area:1105} Feral Scar Vale · {npc:14637} Zorbin Fandazzle
	["Boat to the {area:1108} and ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45."] = "Плывите на корабле сюда: {area:1108}, и езжайте на восток: {area:1105}. Заданиям {npc:14637} на побережье нужен 45-й уровень.",
	-- {npc:5292} Feral Scar Yeti · {area:1105} Feral Scar Vale · {zone:1444} Feralas
	["grind on {npc:5292} at {area:1105}, {zone:1444}"] = "гринд: {npc:5292}, {area:1105}, {zone:1444}",

	-- Step 24: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast
	["Ride back to the {area:1108}; the goblin stands by the dock."] = "Езжайте обратно сюда: {area:1108}; гоблин стоит у причала.",

	-- Step 25: Giants and elementals
	["Giants and elementals"] = "Великаны и элементали",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Shore Striders = {npc:5359} Shore Strider · Deep Striders = {npc:5360} Deep Strider · Wave Striders = {npc:5361} Wave Strider · Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Shore Striders, Deep Striders and Wave Striders (elite giants) wade along the coast north of the dock: zap one with {item:18904} and kill the shrunken giant. Sea Elementals and Sea Sprays drift in the same surf."] = "Береговые странники, странники глубин и странники волн (элитные великаны) бродят по мелководью к северу от причала: ударьте одного предметом {item:18904} и убейте уменьшенного великана. Морские элементали и морские валы плавают в том же прибое.",

	-- Step 26: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["{npc:14637}'s refills are level 55: skip them."] = "Пополнения {npc:14637} — 55-го уровня: пропустите их.",
	-- {area:1108} Forgotten Coast · {zone:1446} Tanaris
	["You end at the {area:1108} dock: the {zone:1446} guide starts with the trip east from here."] = "Вы заканчиваете у причала ({area:1108}): гайд по зоне {zone:1446} начинается с пути отсюда на восток.",
}
