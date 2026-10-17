-- Russian (ruRU): the guide forever/alliance/07-thousand-needles (forever/alliance/07-thousand-needles.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Darkshire
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["No {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too."] = "Нет предмета {item:4371} для задания «{quest:174}»? Его продает {npc:3133} в доме рядом с {npc:276}, запас ограничен; продает его и {npc:1448} ({area:150}).",
	-- {npc:352} Dungar Longdrink · {zone:1453} Stormwind
	["From {npc:352} in {zone:1453}"] = "Выдает {npc:352} ({zone:1453})",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790} – таверна «Scarlet Raven»",
	-- {npc:840} Watcher Backus
	["{npc:840}, at the north entrance of town"] = "{npc:840} – у северного въезда в город",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267} – в ратуше",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663} – у ратуши",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}: продает {npc:3133}, если у вас его нет",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, at the east end of town"] = "{npc:276} – в восточной части города",

	-- Step 2: Nightbane Shadow Weavers
	-- plural, as words: Nightbane Shadow Weavers = {npc:533} Nightbane Shadow Weaver
	["Nightbane Shadow Weavers"] = "Тенеткачи Ночной Погибели",
	-- {area:42} Darkshire
	["The worgen hold the woods of Brightwood, west of {area:42} and north of the road. Pull them one at a time."] = "Ворги занимают лес Светлой рощи к западу от поселка {area:42} и к северу от дороги. Выманивайте их по одному.",

	-- Step 4: Nightbane Dark Runners
	-- plural, as words: Nightbane Dark Runners = {npc:205} Nightbane Dark Runner
	["Nightbane Dark Runners"] = "Вестники Тьмы из стаи Ночной Погибели",
	-- {area:42} Darkshire
	["The Dark Runners prowl the woods south of the road, west of {area:42}."] = "Вестники Тьмы рыщут по лесу к югу от дороги, к западу от поселка {area:42}.",

	-- Step 6: Blind Mary
	-- {area:42} Darkshire
	["Her house stands on the hill south-east of {area:42}."] = "Ее дом стоит на холме к юго-востоку от поселка {area:42}.",

	-- Step 7: Nightbane Vile Fangs and the Insane Ghoul
	-- {npc:511} Insane Ghoul
	-- plural, as words: Nightbane Vile Fangs = {npc:206} Nightbane Vile Fang
	["Nightbane Vile Fangs and the {npc:511}"] = "Ярые Клыки Ночной Погибели и {npc:511}",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery · {npc:511} Insane Ghoul
	["The strongest worgen roam the woods south of {area:42}, west and south of the {area:121}. The {npc:511} hides in the small crypt by the cemetery."] = "Самые сильные ворги бродят по лесу к югу от поселка {area:42}, к западу и югу от места {area:121}. {npc:511} прячется в маленьком склепе у кладбища.",

	-- Step 8: Darkshire
	-- {npc:661} Jonathan Carevin · {npc:633} Elaine Carevin
	["{npc:661}, by {npc:633}'s house"] = "{npc:661} – у дома, где живет {npc:633}",

	-- Step 9: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["Ride west along the road; the hermit's shack stands north-east of the {area:492}."] = "Езжайте по дороге на запад; хижина отшельника стоит к северо-востоку от кладбища (ориентир: {area:492}).",

	-- Step 10: Plague Spreaders
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["Plague Spreaders"] = "Распространители чумы",
	-- {area:492} Raven Hill Cemetery · {npc:522} Mor'Ladim
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["The Plague Spreaders walk the northern half of the {area:492}. {npc:522}, an elite, wanders the graves: keep away from him."] = "Распространители чумы бродят по северной части кладбища ({area:492}). Среди могил бродит элитный противник {npc:522}: держитесь от него подальше.",

	-- Step 11: Sven Yorgen's Camp
	-- {npc:311} Sven Yorgen
	["{npc:311}'s Camp"] = "Лагерь {npc:311}",

	-- Step 12: Raven Hill Cemetery, west
	-- {area:492} Raven Hill Cemetery
	["{area:492}, west"] = "{area:492}, запад",
	-- {npc:311} Sven Yorgen
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["Skeletal Raiders, Healers and Warders hold the west part of the cemetery, just east of {npc:311}'s camp."] = "Скелеты-налетчики, скелеты-лекари и скелеты-хранители занимают западную часть кладбища, сразу к востоку от лагеря {npc:311}.",

	-- Step 13: Sven Yorgen's Camp
	-- {npc:1212} Bishop Farthing · {zone:1453} Stormwind
	["For {npc:1212} in {zone:1453}, in the next guide"] = "Для NPC {npc:1212} ({zone:1453}), в следующем гайде",

	-- Step 14: Defias Strongbox
	-- {zone:1431} Duskwood · {area:94} Raven Hill · {zone:1436} Westfall
	["The Defias camp lies in the south-west of {zone:1431}, south of {area:94} near the {zone:1436} border. The strongbox stands among the tents."] = "Лагерь Братства Справедливости лежит на юго-западе зоны {zone:1431}, к югу от деревни {area:94}, у границы с зоной {zone:1436}. Сундук стоит среди палаток.",

	-- Step 15: Vul'Gol Ogre Mound
	-- {object:119} Abercrombie's Crate
	["Ride east to the ogre mound. {object:119} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "Езжайте на восток к кургану огров. {object:119} лежит в лагере у входа; его охраняют огры из клана Дробящего Кулака.",
	-- {npc:272273} Lost Watcher · {quest:96138} Merrick's Bow
	["Only if a {npc:272273} dropped {quest:96138}: right-click it"] = "Только если с противника {npc:272273} выпал предмет «{quest:96138}»: щелкните по нему правой кнопкой",

	-- Step 17: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Назад: {area:42}",
	-- {npc:482} Elling Trias · {zone:1453} Stormwind
	["For {npc:482} in {zone:1453}, in the next guide"] = "Для NPC {npc:482} ({zone:1453}), в следующем гайде",
	-- {npc:263} Lord Ello Ebonlocke
	["{npc:263}, in the town hall"] = "{npc:263} – в ратуше",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268} – в доме за ратушей",
	["Wait a moment, then speak with her again"] = "Подождите немного, затем поговорите с ней снова",

	-- Step 18: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239} – в таверне",
	-- {item:2594} Flagon of Mead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}: продает {npc:1464}",
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217}, upstairs in the inn"] = "{npc:1217} – наверху в таверне",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep"] = "{npc:2104} – у крепости",

	-- Step 19: The wreck of the Third Fleet
	["The wreck of the Third Fleet"] = "Обломки Третьей флотилии",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it."] = "Идите вдоль побережья на север к разбитому кораблю. Проклятые матросы бродят по пляжу, проклятые стражи бухты – по палубе; {npc:1159} стоит на пляже у носа корабля. Огромные болотные кроколиски прячутся на побережье сразу к северу от него.",

	-- Step 20: Bluegill Raiders
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Bluegill Raiders"] = "Налетчики из племени Синежабрых",
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Follow the coast north-east past the wreck: the Bluegill Raiders hold the marsh beyond the Giant Crocolisks."] = "Идите вдоль побережья на северо-восток мимо обломков: налетчики из племени Синежабрых занимают болото за огромными кроколисками.",

	-- Step 22: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "Капитан ходит по палубе разбитого корабля; его сундук стоит в трюме.",

	-- Step 23: Glorin Steelbrow
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind
	["For {npc:1284} in {zone:1453}, in the next guide"] = "Для NPC {npc:1284} ({zone:1453}), в следующем гайде",

	-- Step 24: Whelgar's Excavation Site
	["Follow the road east to the excavation site."] = "Идите по дороге на восток к раскопкам.",

	-- Step 25: The dig and Sarltooth
	-- {npc:1353} Sarltooth
	["The dig and {npc:1353}"] = "Раскопки и {npc:1353}",
	-- {npc:1353} Sarltooth
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "Реликвии лежат прямо на раскопках. {npc:1353}, крупный острозуб, рыщет в долине ящеров сразу к западу от них.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}: {object:331}",

	-- Step 26: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078} и Вельгар",

	-- Step 27: Dragonmaw camp
	["Dragonmaw camp"] = "Лагерь клана Драконьей Пасти",
	["The Dragonmaw orcs camp east of the excavation site. Raiders and Swamprunners carry the war banners."] = "Орки из клана Драконьей Пасти стоят лагерем к востоку от раскопок. Боевые знамена носят налетчики и болотные бегуны.",

	-- Step 28: Captain Stoutfist
	-- {area:150} Menethil Harbor
	["Ride back west along the road to {area:150}."] = "Езжайте по дороге назад на запад: {area:150}.",
	-- {quest:98221} From the Ashes · {quest:465} Nek'rosh's Gambit
	["{quest:98221}: {quest:465} comes after it on Forever"] = "{quest:98221}: в Forever задание {quest:465} идет после него",

	-- Step 29: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {npc:2091} Chieftain Nek'rosh
	["Ride east again to the Dragonmaw camp. The four sets of Attack Plans lie in the {area:1036}; {npc:2091}, an elite, stands in the camp too."] = "Снова езжайте на восток к лагерю клана Драконьей Пасти. Четыре комплекта планов атаки лежат здесь: {area:1036}; {npc:2091}, элитный противник, тоже стоит в лагере.",

	-- Step 30: To Theramore
	["To Theramore"] = "На остров Терамор",
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104}, in {area:2103}"] = "{npc:2104} – здесь: {area:2103}",
	-- {zone:1437} Wetlands
	["For the Dragonmaw catapult, on the {zone:1437} loop of the next guide"] = "Для катапульты клана Драконьей Пасти – на круге по зоне {zone:1437} в следующем гайде",
	-- {area:513} Theramore Isle · {zone:1445} Dustwallow Marsh
	["Take the boat from Menethil's pier to {area:513} in {zone:1445}."] = "Сядьте на корабль у причала Гавани Менетилов: {area:513} ({zone:1445}).",

	-- Step 31: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "По пути на юг через зону {zone:1413}: {npc:6244} стоит лагерем к востоку от дороги, к северо-востоку от места {area:378}; подходите с востока и держитесь подальше от стражей Орды.",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}: в зоне {zone:1440}, по пути в зону {zone:1443}",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}: инкуб, рядом с суккубом; {item:190309} – рядом с целью задания «{quest:1738}»",

	-- Step 32: The Great Lift
	-- {zone:1413} Barrens · {area:378} Camp Taurajo · {area:485} The Great Lift · {zone:1441} Thousand Needles
	["From Theramore follow the road west out of Dustwallow into the {zone:1413} and south along it; give {area:378} a wide berth. {area:485} at the {zone:1413}' south end takes you down into {zone:1441}. The journal lies at the foot of the lift."] = "С острова Терамор идите по дороге на запад из Пылевых топей в зону {zone:1413} и по ней на юг; обходите {area:378} стороной. {area:485} в южной части зоны {zone:1413} спустит вас в зону {zone:1441}. Дневник лежит у подножия подъемника.",
	-- {npc:4048} Falfindel Waywarder · {zone:1444} Feralas
	["For {npc:4048} in {zone:1444}, much later"] = "Для NPC {npc:4048} ({zone:1444}), гораздо позже",

	-- Step 33: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Идите по каньонам на восток к соляным равнинам. Гоблины и гномы ({area:2240}) нейтральны и дают задания обеим фракциям.",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "Для задания «{quest:5762}» в Тернистой долине, позже",

	-- Step 34: The salt flats
	["The salt flats"] = "Соляные равнины",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Scorpid Terrors = {npc:4139} Scorpid Terror
	["{object:19868} lies all over the flats. Scorpid Reavers, Sparkleshell Tortoises and Saltstone Basilisks roam the north half, Crystalhides, Scorpid Terrors and Snappers the middle, and the Gazers (34-35, five levels above you: one at a time) the far south. Vultures circle over all of it."] = "{object:19868} – по всей равнине. Скорпиды-разорители, блестопанцирные черепахи и просоленные василиски бродят в северной части, просоленные хрусталиски, скорпиды-убийцы и блестопанцирные крепкохваты – в середине, а просоленные взорени (34-35, на пять уровней выше вас: по одному) – на дальнем юге. Над всем этим кружат стервятники соляных равнин.",

	-- Step 35: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, later"] = "{npc:4454}: для Мартека (зона {zone:1418}), позже",

	-- Step 36: Back to Menethil
	["Back to Menethil"] = "Назад в Гавань Менетилов",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dragonmaw catapult"] = "Катапульта клана Драконьей Пасти",
	-- ["Ride east again; the catapult stands at the Dragonmaw camp south of the road."] = "Снова езжайте на восток; катапульта стоит в лагере клана Драконьей Пасти к югу от дороги.",
	-- ["Ride east to the ogre mound. {item:1349} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "Езжайте на восток к кургану огров. {item:1349} лежит в лагере у входа; его охраняют огры из клана Дробящего Кулака.",
	-- ["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "Следующий шаг, «Убить Нек'роша», сталкивает вас с элитным вождем: пропустите его.",
}
