-- Russian (ruRU): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Езжайте на запад к обнесенной стеной крепости в центре пустыни. {npc:15189} стоит наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи.",

	-- Step 2: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Землечерпы, камнехвостые скорпиды и песчаные пауки-быстроноги бродят по пескам чуть к северу от крепости.",

	-- Step 3: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Светящиеся осколки табличек лежат вокруг лагеря Сумеречного Молота на дальнем северо-западе; они падают и с пылевихрей и пустынных грохотунов.",

	-- Step 4: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} стоит наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи.",

	-- Step 5: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "Вернитесь в Южный Ветер и поднимитесь на башню. Если потревожить улей наверху, вылезут душители из улья Аши; у одного из них – {item:17346}.",

	-- Step 6: The Spirits of Southwind
	["The Spirits of Southwind"] = "",
	["Inside"] = "Внутри",

	-- Step 7: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Езжайте на юго-восток сюда: {area:3447}, под скалами Ун'Горо.",
	["Below ground"] = "",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "{item:20377} – с NPC {npc:11739}, в 130 м к юго-западу",

	-- Step 8: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Земляные сокрушители и клешневики",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Двигайтесь на север вдоль западных дюн; земляные сокрушители и камнехвостые клешневики встречаются отсюда до крепости.",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "",

	-- Step 9: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "Езжайте на запад к лагерю Орды к северу от места {area:2744}.",

	-- Step 10: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Гейзеры силитиста извергаются по всей южной пустыне. Войдите в оставленный гейзером силитист и отнесите его к экстрактору Орды в лагере Кирики; в бою или верхом вы его теряете.",

	-- Step 11: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Живодеры и скальные пауки-скакуны",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Камнехвостые живодеры и скальные пауки-скакуны бродят по дюнам к юго-западу от лагеря Кирики.",

	-- Step 12: Twilight Vanguard
	["Twilight Vanguard"] = "Авангард Сумеречного Молота",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "",

	-- Step 14: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} занимает лагерь на западе.",

	-- Step 15: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "",

	-- Step 16: Level 58
	["Level 58"] = "",
	-- {npc:15181} Commander Mar'alith · {quest:8304} Dearest Natalia · {area:3425} Cenarion Hold · {area:1583} Blackrock Spire · {quest:838} Scholomance
	-- plural, as words: Twilight Avengers = {npc:11880} Twilight Avenger
	["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Twilight Avengers, Geolords and Stonecallers west of the outpost. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "",
	-- {npc:11880} Twilight Avenger
	["grind on {npc:11880}"] = "",

	-- Step 17: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} и {npc:15190} стоят наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи.",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, в западной части крепости",

	-- Step 18: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "Езжайте на северо-восток сюда: {area:3447}.",

	-- Step 19: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "Сумка лежит в горах на дальнем юге, за Лагерем Бронзоборода. Рядом патрулирует Смертехват, элитный скорпид: хватайте сумку, пока его нет.",

	-- Step 20: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "",

	-- Step 21: Twilight Base Camp
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell."] = "",
	-- {npc:15306} Bor Wildmane
	["ten for each quest: {npc:15306} takes his ten before Ortell"] = "",

	-- Step 22: Twilight Base Camp
	["The spare texts from the cultists"] = "Лишние тексты с культистов",

	-- Step 23: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Назад: {area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} стоит наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи.",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "",

	-- Step 25: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Езжайте на северо-восток сюда: {area:3077}; из края {zone:1451} вы уйдете через перевал рядом.",

	-- Step 27: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock
	["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "",

	-- Step 28: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "Гоблин {npc:10302} сидит здесь: {area:543}, чуть к востоку от пилона.",

	-- Step 29: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Езжайте на восток сюда: {area:537}, поднимитесь и используйте предмет {npc:10541} у лавового жерла у вершины, затем возвращайтесь на запад к персонажу {npc:10302}.",

	-- Step 30: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} отправляет вас к персонажу {npc:9298} ({zone:1452}): сохраните задание.",

	-- Step 31: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "",

	-- Step 32: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Сохраните приманку: {npc:9684} – 56-го уровня, а второй круг проходит мимо его логова.",

	-- Step 33: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "Логово ({npc:9684}) – чуть к югу от пилона. Используйте там приманку {npc:9619}; {npc:9684} – 56-го уровня и бьет сильно, начинайте с полным здоровьем.",

	-- Step 34: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "",
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["Careful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "",

	-- Step 35: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117} is inside the cave."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Сохраните задание {quest:3942}: {npc:9116} – здесь: {area:2479}, по пути следующего руководства через край {zone:1448}.",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {npc:10980} on {npc:10977}"] = "Используйте игрушку {npc:10980} на персонаже {npc:10977}",
	-- {npc:10977} Quixxil · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10977} with {npc:10980}"] = "",

	-- Step 36: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} сидит на хребте, заблудившийся и обессиленный.",

	-- Step 37: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Сопроводите NPC {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 39: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "Теперь {npc:9619} просит шкуру ({npc:9622}) из северо-восточной пещеры: пропустите.",

	-- Step 41: Gadgetzan
	-- {area:976} Gadgetzan · {object:142071} Egg-O-Matic
	["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Летите сюда: {area:976}. {object:142071} стоит в центре города.",

	-- Step 42: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 43: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 44: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 47: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 50: Radley and Durgen
	["Radley and Durgen"] = "Рэдли и Дурген",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 51: Northridge Lumber Camp
	-- {npc:11615} Mickey Levine
	["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "",

	-- Step 53: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "Либрам лежит дальше к северу, по пути к месту {area:190}.",

	-- Step 54: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 56: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Сторожевые башни и силосы Андорала",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Езжайте на юг в Андорал. {npc:10667} ждет в разрушенной таверне в западной части города. Встаньте в дверях каждой из четырех башен с предметом {item:12815}, чтобы отметить ее; держитесь окраин города. Используйте предмет {item:12627} у силосов в центре города, чтобы выманить временных паразитов.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10903}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10905}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10902}",

	-- Step 57: Chromie
	["Upstairs"] = "",

	-- Step 58: Counting Out Time
	-- {npc:10667} Chromie
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "Сундучки стоят в разрушенных домах Андорала вокруг таверны, где находится {npc:10667}. Осторожно: рядом с сундучками обычно стоят вурдалаки и скелеты, они нападают, когда вы подходите. Обжигающие вурдалаки также ранят всех поблизости и выводят из незаметности.",

	-- Step 63: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "На восток по дороге: {npc:11077} охраняет котел ({area:200}).",

	-- Step 65: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "Щит лежит здесь: {area:201}, к югу от хижины {npc:1855}.",

	-- Step 66: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Езжайте на восток к хижине {npc:1855} у места {area:2619} и выслушайте его.",

	-- Step 69: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Воители Плети",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Воители Плети бродят здесь: {area:2270}, к северу от часовни. Проведите предметом {npc:11063} ({item:13156}) над каждым убитым: нужны черепа, которые отзываются.",

	-- Step 71: Hameya's scroll
	["Hameya's scroll"] = "Свиток Хамейи",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Рваный свиток лежит у входа сюда: {area:2261} – склеп к югу от места {area:2260}.",

	-- Step 72: Pamela and the Undercroft
	-- {area:2261} Undercroft
	["Pamela and the {area:2261}"] = "",
	-- {area:2262} Darrowshire · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",

	-- Step 74: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "Езжайте на северо-запад к хижине {npc:1855}.",

	-- Step 77: Level 59.14
	["Level 59.14"] = "",
	-- {quest:6135} Duskwing, Oh How I Hate Thee... · {quest:838} Scholomance · {area:2279} Stratholme
	["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan. Or, with a group, run the {quest:838} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:10717} Temporal Parasite
	["grind on {npc:10717}"] = "",

	-- Step 78: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "Езжайте на юго-запад к персонажу {npc:10667} в Андорал.",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "Битва за Дарроушир ({npc:10667}) заканчивается боем с элитой. Пропустите.",

	-- Step 79: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "",

	-- Step 80: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "",

	-- Step 81: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "",

	-- Step 82: Of Lost Honor
	["Underwater"] = "",

	-- Step 83: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "",

	-- Step 85: Hameya's mound
	["Hameya's mound"] = "Курган Хамейи",
	-- {npc:1855} Tirion Fordring · {area:2261} Undercroft · {object:177675} Mound of Dirt
	["Ride south-east from {npc:1855} to the {area:2261}; the {object:177675} is just behind it."] = "",

	-- Step 86: Into Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Into {zone:1422}"] = "",

	-- Step 89: Target: Writhing Haunt
	-- {npc:11055} Shadow Priestess Vandis · {area:152} The Bulwark
	["from the cauldron, for {npc:11055} at the {area:152}"] = "",

	-- Step 91: Target: Gahrron's Withering
	-- {area:202} Writhing Haunt · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Back east past the {area:202} to {area:201}, the farm under the eastern hills: {npc:11078} guards its cauldron. Kill him for the key, then use the cauldron."] = "",

	-- Step 92: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152} one last time."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "Дитерс предлагает {item:14619} ({quest:838}). Пропустите.",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Землечерпы, камнехвостые скорпиды и песчаные пауки-быстроноги бродят по пескам чуть к северу от крепости.",
	-- ["Dredge and scorpids"] = "Землечерпы и скорпиды",
	-- ["Fly to {area:1637} and train."] = "Летите сюда: {area:1637} и обучитесь.",
	-- ["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "Задание Мар'алита о Наталии требует 58-го уровня и ведет сюда: {area:2744}, к элите. Пропустите.",
	-- ["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "На север к лесопилке; поставьте бочку с термитами в центре лесопилки.",
	-- ["Ride east across the plaguelands to the chapel."] = "Езжайте на восток через Чумные земли к часовне.",
	-- ["Ride east along the road to the {area:152} on the border."] = "Езжайте на восток по дороге к {area:152} на границе.",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Езжайте на юго-запад к руинам ({area:2738}). {object:179565} для персонажа {npc:11801} – в одном из разрушенных домов.",
	-- ["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "Езжайте сюда: {area:2262}, на юго-запад; {npc:10926} играет среди домов. {npc:11886} прячется здесь: {area:2261} – склеп чуть к западу от города.",
	-- ["Ride west to the walled hold in the middle of the desert."] = "Езжайте на запад к обнесенной стеной крепости в центре пустыни.",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Садитесь на дирижабль с башни у города {area:1637} в край {zone:1420} и езжайте в город {zone:1458}. Леди Сильвана – здесь: {object:36126}.",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Светящиеся осколки табличек лежат вокруг лагеря Сумеречного Молота на дальнем северо-западе; они падают и с пылевихрей и пустынных грохотунов.",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Перевал из Ун'Горо выходит сюда: {area:3077} – кладбище на северо-востоке края {zone:1451}. {npc:13220} стоит среди могил.",
	-- ["The wooden sign beside {npc:9997}"] = "Деревянная табличка рядом с NPC {npc:9997}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} – сразу за местом {area:2261}.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "Через перевал и на восток вдоль северных скал сюда: {area:541}. {npc:8737} стоит у пещеры; {npc:9117} – внутри.",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "На запад к {area:152}. Следующее руководство начинается здесь: {zone:1458}, недалеко к западу.",
	-- ["{item:20375} on the way"] = "{item:20375} по пути",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "Ферма ({npc:10778}) – первая к востоку от {area:152}. У болтливых вурдалаков на ферме – вторая половина ее талисмана; {npc:11075} охраняет котел в поле.",
	-- ["{npc:10926} and the {area:2261}"] = "{npc:10926} и {area:2261}",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "Поручение самой {npc:10926} не входит в маршрут. Пропустите.",
	-- ["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803} бродит по лагерю авангарда на дальнем юго-западе. С каждого культиста падают зашифрованные сумеречные тексты ({item:20404}), с заданием или без: соберите двадцать – десять для персонажа {npc:15306} и десять для Ортелла.",
	-- ["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804} стоит на заставе к западу от места {area:3425}. Доберите зашифрованные сумеречные тексты ({item:20404}) до двадцати с культистов здесь.",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "Поручения {npc:11878} не входят в маршрут. Пропустите.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Защитник ({npc:15193}) занимает дом на ферме ({area:2260}) к северу от места {area:2261}.",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, в западной части крепости",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "Следующее задание {npc:1855}, о потерянной чести, не входит в маршрут. Пропустите.",
}
