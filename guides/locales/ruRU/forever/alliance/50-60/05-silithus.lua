-- Russian (ruRU): the guide forever/alliance/50-60/05-silithus (forever/alliance/50-60/05-silithus.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Silithus
	-- {area:1377} Silithus
	["Into {area:1377}"] = "",

	-- Step 3: Cenarion Hold
	-- {area:1377} Silithus · {area:3425} Cenarion Hold
	["Ride out of the crater's north-western pass into {area:1377} and on to {area:3425}."] = "",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "",

	-- Step 4: Silithus: kill these as you meet them
	-- {area:1377} Silithus
	["{area:1377}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Землечерпы роются в дюнах к северо-западу от крепости; повсюду бродят камнехвостые скорпиды и песчаные пауки-быстроноги.",

	-- Step 6: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Дальше на западе роются земляные сокрушители; в тех же песках охотятся камнехвостые клешневики, камнехвостые живодеры и скальные пауки-скакуны.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "",
	-- {npc:11736} Stonelash Pincer
	["grind on {npc:11736}"] = "",

	-- Step 7: Layo Starstrike
	-- {npc:13220} Layo Starstrike
	["Ride east to {npc:13220}."] = "Езжайте на восток: {npc:13220}.",

	-- Step 8: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Истерзанные друиды и часовые бродят по разрушенной деревне к юго-западу от {npc:13220}.",

	-- Step 10: Level 57.86
	["Level 57.86"] = "",
	-- {area:3077} Valor's Rest
	["Top up here to level 57.86 before the hand-ins at {area:3077}: they take you to level 58."] = "",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "",

	-- Step 11: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "Башня: {area:2742}",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Езжайте на восток к башне ({area:2742}, {area:2738}); поднимитесь на нее и убейте засаду, которая появляется ради покрытого коркой предмета.",

	-- Step 12: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "Умбер ({zone:1450}): сохраните задание",

	-- Step 13: Level 57.92
	["Level 57.92"] = "",
	-- {area:3425} Cenarion Hold
	["Top up here to level 57.92 before the hand-ins at {area:3425}: they take you to level 58."] = "",

	-- Step 15: Cenarion Hold
	-- {npc:15174} Calandrath
	["{npc:15174}, the innkeeper"] = "",

	-- Step 16: Level 58
	["Level 58"] = "",
	-- {area:3425} Cenarion Hold
	["Top up here to level 58: Dearest Natalia, at {area:3425}, needs level 58."] = "",
	-- {npc:12178} Tortured Druid
	["grind on {npc:12178}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Chromie in Andorhal: keep it"] = "Хроми в Андорале: сохраните задание",
	-- ["Dredge and scorpids"] = "Землечерпы и скорпиды",
	-- ["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it."] = "Летите: {area:976} → {area:541}. Хижина ({npc:8737}) стоит к западу от лагеря: {area:538}; {npc:9117} – на холме позади нее.",
	-- ["Fly to {area:271} and ride north up the road toward Alterac: Haggerdin camps at {area:1056} beside it."] = "Летите сюда: {area:271} – и езжайте по дороге на север к Альтеракским горам: лейтенант Мурп стоит лагерем рядом с ней ({area:1056}).",
	-- ["For {area:3197}: keep it"] = "Для места {area:3197}: сохраните задание",
	-- ["For {npc:10778}: keep it"] = "Для персонажа {npc:10778}: сохраните задание",
	-- ["For {zone:1448}: keep it"] = "Для зоны {zone:1448}: сохраните задание",
	-- ["From {area:392}, fly to {area:976}."] = "Летите: {area:392} → {area:976}.",
	-- ["Its jars are filled on the next Un'Goro visit"] = "Его флаконы наполняются при следующем посещении Кратера Ун'Горо",
	-- ["On {npc:7583}"] = "У персонажа {npc:7583}",
	-- ["Ride back to {area:3425} and fly to {area:392}."] = "Езжайте назад: {area:3425}, затем летите сюда: {area:392}.",
	-- ["Ride north to the {area:2277}'s north-eastern edge."] = "Езжайте на север, к северо-восточному краю места {area:2277}.",
	-- ["Ride on north to {area:3197} and fly to {area:2268}."] = "Езжайте дальше на север: {area:3197}, затем летите сюда: {area:2268}.",
	-- ["Ride out of the crater's north-western pass into {zone:1451} and on to {area:3425}."] = "Выезжайте из кратера через северо-западный перевал в зону {zone:1451} и дальше: {area:3425}.",
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "Езжайте на юго-запад к {area:2261}. Холмик земли – внутри. {npc:11886} – элитный противник: лучше собрать группу.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Езжайте на юго-запад к лагерю ({npc:7771}): {area:1938}.",
	-- ["Scourge Champions"] = "Воители Плети",
	-- ["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "Воители Плети (59) бродят здесь: {area:2270}, к северу от места {area:2268}. Проводите предметом {item:13156} {npc:11063} над каждым убитым: нужны ему черепа, которые резонируют. Выманивайте по одному.",
	-- ["Sixty {item:2592}, if you carry them"] = "Шестьдесят шт. {item:2592}, если они у вас есть",
	-- ["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "Плывите на корабле: {area:392} → {area:35}, затем летите в {zone:1453}.",
	-- ["Take the {area:2257} to {zone:1455}."] = "Поезжайте на метро ({area:2257}) сюда: {zone:1455}.",
	-- ["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}."] = "Смоляные твари барахтаются здесь: {area:538}; пепел носят огненные элементали в центре ({area:537}); железу – осы из улья Гориши на юге ({area:540}). С любого существа в кратере может упасть {item:11018}.",
	-- ["The crater"] = "Кратер",
	-- ["The next guide starts here in {area:392}."] = "Следующий гайд начинается здесь: {area:392}.",
	-- ["The western dunes"] = "Западные дюны",
	-- ["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "убивайте мобов ({npc:8532}): {area:2258}, {zone:1423}",
	-- ["{item:13155}, from the Scourge Champions"] = "{item:13155}: с воителей Плети",
	-- ["{item:14613}, from {npc:11886}"] = "{item:14613}: с персонажа {npc:11886}",
	-- ["{npc:14724}, by the tram"] = "{npc:14724} – у метро",
	-- ["{npc:332}, in SI:7"] = "{npc:332} – в здании ШРУ",
	-- ["{npc:3520}, who walks the canals"] = "{npc:3520} – ходит вдоль каналов",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} ждет на кладбище чуть восточнее города; надгробие стоит рядом.",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444} – здесь: {area:392}",
	-- ["{quest:6184} at {area:3197}: keep it"] = "{quest:6184} ({area:3197}): сохраните задание",
}
