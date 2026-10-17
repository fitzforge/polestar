-- Russian (ruRU): the guide forever/alliance/50-60/05-silithus (forever/alliance/50-60/05-silithus.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Gadgetzan
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["From {area:392}, fly to {area:976}."] = "Летите: {area:392} → {area:976}.",
	-- {area:3197} Chillwind Camp
	["For {area:3197}: keep it"] = "Для места {area:3197}: сохраните задание",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "У персонажа {npc:7583}",

	-- Step 2: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} ждет на кладбище чуть восточнее города; надгробие стоит рядом.",

	-- Step 3: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Езжайте на юго-запад к лагерю ({npc:7771}): {area:1938}.",
	-- {quest:3444} The Stone Circle · {area:392} Ratchet
	["{quest:3444} is in {area:392}"] = "{quest:3444} – здесь: {area:392}",

	-- Step 4: Linken
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:8737} Linken · {area:538} Lakkari Tar Pits · {npc:9117} J.D. Collie
	["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it."] = "Летите: {area:976} → {area:541}. Хижина ({npc:8737}) стоит к западу от лагеря: {area:538}; {npc:9117} – на холме позади нее.",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Для зоны {zone:1448}: сохраните задание",

	-- Step 5: The crater
	["The crater"] = "Кратер",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}."] = "Смоляные твари барахтаются здесь: {area:538}; пепел носят огненные элементали в центре ({area:537}); железу – осы из улья Гориши на юге ({area:540}). С любого существа в кратере может упасть {item:11018}.",

	-- Step 6: Cenarion Hold
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["Ride out of the crater's north-western pass into {zone:1451} and on to {area:3425}."] = "Выезжайте из кратера через северо-западный перевал в зону {zone:1451} и дальше: {area:3425}.",

	-- Step 7: Dredge and scorpids
	["Dredge and scorpids"] = "Землечерпы и скорпиды",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Землечерпы роются в дюнах к северо-западу от крепости; повсюду бродят камнехвостые скорпиды и песчаные пауки-быстроноги.",

	-- Step 9: The western dunes
	["The western dunes"] = "Западные дюны",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Дальше на западе роются земляные сокрушители; в тех же песках охотятся камнехвостые клешневики, камнехвостые живодеры и скальные пауки-скакуны.",

	-- Step 11: Layo Starstrike
	-- {npc:13220} Layo Starstrike
	["Ride east to {npc:13220}."] = "Езжайте на восток: {npc:13220}.",

	-- Step 12: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Истерзанные друиды и часовые бродят по разрушенной деревне к юго-западу от {npc:13220}.",

	-- Step 14: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "Башня: {area:2742}",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Езжайте на восток к башне ({area:2742}, {area:2738}); поднимитесь на нее и убейте засаду, которая появляется ради покрытого коркой предмета.",

	-- Step 15: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "Умбер ({zone:1450}): сохраните задание",

	-- Step 16: Ratchet
	-- {area:3425} Cenarion Hold · {area:392} Ratchet
	["Ride back to {area:3425} and fly to {area:392}."] = "Езжайте назад: {area:3425}, затем летите сюда: {area:392}.",

	-- Step 17: Stormwind City
	-- {area:392} Ratchet · {area:35} Booty Bay · {zone:1453} Stormwind City
	["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "Плывите на корабле: {area:392} → {area:35}, затем летите в {zone:1453}.",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520} – ходит вдоль каналов",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "Для персонажа {npc:10778}: сохраните задание",
	-- {item:2592} Wool Cloth
	["Sixty {item:2592}, if you carry them"] = "Шестьдесят шт. {item:2592}, если они у вас есть",

	-- Step 18: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332} – в здании ШРУ",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{quest:6184} ({area:3197}): сохраните задание",

	-- Step 19: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge
	["Take the {area:2257} to {zone:1455}."] = "Поезжайте на метро ({area:2257}) сюда: {zone:1455}.",
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, by the tram"] = "{npc:14724} – у метро",
	["Its jars are filled on the next Un'Goro visit"] = "Его флаконы наполняются при следующем посещении Кратера Ун'Горо",

	-- Step 20: Lieutenant Haggerdin
	-- {area:271} Southshore · {area:1056} Darrow Hill
	["Fly to {area:271} and ride north up the road toward Alterac: Haggerdin camps at {area:1056} beside it."] = "Летите сюда: {area:271} – и езжайте по дороге на север к Альтеракским горам: лейтенант Мурп стоит лагерем рядом с ней ({area:1056}).",

	-- Step 21: Light's Hope Chapel
	-- {area:3197} Chillwind Camp · {area:2268} Light's Hope Chapel
	["Ride on north to {area:3197} and fly to {area:2268}."] = "Езжайте дальше на север: {area:3197}, затем летите сюда: {area:2268}.",

	-- Step 22: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Воители Плети",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "Воители Плети (59) бродят здесь: {area:2270}, к северу от места {area:2268}. Проводите предметом {item:13156} {npc:11063} над каждым убитым: нужны ему черепа, которые резонируют. Выманивайте по одному.",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}: с воителей Плети",

	-- Step 23: Light's Hope Chapel
	["Chromie in Andorhal: keep it"] = "Хроми в Андорале: сохраните задание",

	-- Step 24: Infiltrator Hameya
	-- {area:2277} Plaguewood
	["Ride north to the {area:2277}'s north-eastern edge."] = "Езжайте на север, к северо-восточному краю места {area:2277}.",

	-- Step 25: The Undercroft
	-- {area:2261} The Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "Езжайте на юго-запад к {area:2261}. Холмик земли – внутри. {npc:11886} – элитный противник: лучше собрать группу.",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886}"] = "{item:14613}: с персонажа {npc:11886}",

	-- Step 26: The Fungal Vale
	-- {npc:8532} Diseased Flayer · {area:2258} The Fungal Vale · {zone:1423} Eastern Plaguelands
	["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "убивайте мобов ({npc:8532}): {area:2258}, {zone:1423}",

	-- Step 27: Ratchet
	-- {area:392} Ratchet
	["The next guide starts here in {area:392}."] = "Следующий гайд начинается здесь: {area:392}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "Езжайте на юго-запад: {area:2261}. Холмик земли – внутри. {npc:11886} – элитный противник: лучше собрать группу.",
	-- ["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "Плывите на корабле: {area:392} → {area:35}, затем летите сюда: {zone:1453}.",
	-- ["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "убивайте мобов ({npc:8532}): {area:2258}, {zone:1423}",
}
