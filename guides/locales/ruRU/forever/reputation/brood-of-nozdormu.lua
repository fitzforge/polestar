-- Russian (ruRU): the guide forever/reputation/brood-of-nozdormu (forever/reputation/brood-of-nozdormu.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Brood of Nozdormu Reputation"] = "Репутация: Род Ноздорму",
	["The Bronze Dragonflight's ring, upgraded at every standing; a long climb from Hated, mostly in raids."] = "Кольцо бронзовых драконов улучшается на каждом уровне репутации; долгий путь от ненависти, в основном в рейдах.",
	-- {item:21175} The Scepter of the Shifting Sands
	["{item:21175} quest chain"] = "Цепочка заданий {item:21175}",

	-- Step 1: Baristolth in Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Baristolth in {area:3425}"] = "Баристольт в {area:3425}",
	-- {faction:910} Brood of Nozdormu · {npc:15192} Anachronos · {npc:15180} Baristolth of the Shifting Sands · {area:3425} Cenarion Hold · {area:2677} Blackwing Lair · {area:16076} Temple of Ahn'Qiraj
	["The {faction:910} is not in your reputation list until you meet {npc:15192}. {npc:15180}, in the main building of {area:3425}, sends you to him. Meeting him sets you at Hated, 0 of 36,000: Neutral is 42,000 reputation away, and almost all of it comes from raids. {area:2677} and the {area:16076} are not among the first raids Blizzard has announced for Forever: until one of them opens, the 100 from Baristolth's first quest is all the Brood reputation there is. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{faction:910} нет в вашем списке репутации, пока вы не встретите {npc:15192}. {npc:15180} в главном здании {area:3425} отправляет вас к нему. Встреча с ним ставит вас на уровень «Ненависть», 0 из 36 000: до «Равнодушия» 42 000 репутации, и почти вся она приходит из рейдов. {area:2677} и {area:16076} не входят в число первых рейдов, объявленных Blizzard для Forever: пока один из них не откроется, 100 очков за первое задание Баристольта — это вся репутация Стаи. Талант наследия Дипломат добавляет до 10% к каждой награде; числа в этом гайде — без него.",

	-- Step 2: Anachronos at the Caverns of Time
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time
	["{npc:15192} at the {area:2300}"] = "{npc:15192} у {area:2300}",
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time · {zone:1446} Tanaris · {area:976} Gadgetzan
	["{npc:15192}, a bronze dragon in elf form, stands at the mouth of the {area:2300} in eastern {zone:1446}, south-east of {area:976}. Walk up to him."] = "{npc:15192}, бронзовый дракон в облике эльфа, стоит у входа в {area:2300} на востоке {zone:1446}, юго-восточнее {area:976}. Подойдите к нему.",
	-- {npc:15192} Anachronos
	["Meet {npc:15192}"] = "Встретьте {npc:15192}",

	-- Step 3: Back to Baristolth
	["Back to Baristolth"] = "Назад к Баристольту",
	-- {quest:8288} Only One May Rise · {npc:12017} Broodlord Lashlayer · {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {quest:8286} What Tomorrow Brings
	["{quest:8288} wants the head of {npc:12017}, the third boss of {area:2677} (a 40-player raid in {area:254}). Everything after it needs the head, the fragment turn-ins included: until you have it, {quest:8286} is all the Brood reputation there is, solo or not."] = "{quest:8288} требует голову {npc:12017}, третьего босса {area:2677} (рейд на 40 игроков в {area:254}). Всё после него требует голову, включая сдачу фрагментов: пока у вас её нет, {quest:8286} — это вся репутация Стаи, с группой или без.",

	-- Step 4: Broodlord Lashlayer
	-- {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {npc:12017} Broodlord Lashlayer
	["{area:2677} is a 40-player raid at the top of {area:254}. {npc:12017} always drops his head."] = "{area:2677} — рейд на 40 игроков на вершине {area:254}. {npc:12017} всегда роняет свою голову.",
	-- {item:20383} Head of the Broodlord Lashlayer
	["{item:20383}: raid of 40"] = "{item:20383}: рейд на 40",

	-- Step 5: The Path of the Righteous
	-- {quest:8301} The Path of the Righteous · {area:3425} Cenarion Hold · {area:2743} Hive'Zora · {area:2744} Hive'Regal
	-- plural, as words: Silithid Carapace Fragments = {item:20384} Silithid Carapace Fragment · Hive'Ashi Workers = {npc:11721} Hive'Ashi Worker
	["{quest:8301} wants 200 Silithid Carapace Fragments. Every hive silithid drops one to three on most kills: the Hive'Ashi Workers, Stingers, Swarmers and Defenders north and north-west of {area:3425}, and those of {area:2743} in the west and {area:2744} in the south. Almost all of them are elites of level 57 to 60: one at a time solo, faster in a group."] = "{quest:8301} требует 200 обломков силитидского панциря. Почти каждый силитид улья роняет от одного до трёх: рабочие, жала, рои и защитники Улей Аши севернее и северо-западнее {area:3425}, а также те, что из {area:2743} на западе и {area:2744} на юге. Почти все они — элита 57-60 уровней: по одному в соло, быстрее в группе.",

	-- Step 6: Hated to Neutral
	["Hated to Neutral"] = "От «Ненависти» до «Равнодушия»",
	-- {quest:8302} The Hand of the Righteous · {area:16076} Temple of Ahn'Qiraj · {item:21230} Ancient Qiraji Artifact · {item:21229} Qiraji Lord's Insignia
	["After The Path, Baristolth takes 200 more fragments for {quest:8302}: 200 reputation, again and again, but only until Neutral. From Hated 500 that is 208 turn-ins, 41,600 fragments, 20,000 to 30,000 elite kills: the only way without the Temple, and a very long one. With the {area:16076} open (a 40-player raid) it is far quicker: every Temple trash mob gives 100 until 2,999 of 3,000 Neutral, about 9,500 a full clear, so four to five clears reach Neutral. Save every {item:21230} and {item:21229} you loot until the trash stops counting: they pay the same later."] = "После Пути Баристольт принимает ещё 200 фрагментов для {quest:8302}: 200 репутации, снова и снова, но только до «Равнодушия». От «Ненависти» 500 это 208 сдач, 41 600 фрагментов, 20 000–30 000 убийств элиты: единственный путь без Храма, и очень долгий. С открытым {area:16076} (рейд на 40) это куда быстрее: каждый моб мусора в Храме даёт 100 до 2999 из 3000 «Равнодушия», около 9500 за полный зачист, так что четырёх-пяти зачистов хватает. Копите каждый {item:21230} и {item:21229}, пока мусор считается: потом они платят столько же.",
	-- {quest:8302} The Hand of the Righteous
	["{quest:8302}: 200 fragments, 200"] = "{quest:8302}: 200 фрагментов, 200",

	-- Step 7: Anachronos's quests
	-- {quest:8303} Anachronos
	["{quest:8303}'s quests"] = "Задания {quest:8303}",
	-- {quest:8303} Anachronos
	["Neutral opens the rest of the Scepter of the Shifting Sands chain. Baristolth sends you back to {quest:8303}."] = "«Равнодушие» открывает остальную цепочку Скипетра Песчаных Бурь. Баристольт отправляет вас обратно к {quest:8303}.",

	-- Step 9: The Crystalline Tear
	-- {object:180633} Crystalline Tear
	["The {object:180633}"] = "{object:180633}",
	-- {object:180633} Crystalline Tear · {area:3428} Ahn'Qiraj · {zone:1451} Silithus
	["The {object:180633} is a small red crystal on the ground just outside the gates of {area:3428}, in the far south-west of {zone:1451}. Click it, then stay and watch the vision of the War of the Shifting Sands to its end. If it is cut short, abandon the quest and click the Tear again."] = "{object:180633} — маленький красный кристалл на земле сразу за воротами {area:3428}, на дальнем юго-западе {zone:1451}. Щёлкните по нему, затем останьтесь и досмотрите видение Войны Песчаных Бурь до конца. Если его прервут, откажитесь от задания и щёлкните по Слезе снова.",
	["Watch the vision"] = "Смотрите видение",

	-- Step 10: The Charge of the Dragonflights
	-- {npc:15192} Anachronos · {item:21200} Signet Ring of the Bronze Dragonflight · {quest:8555} The Charge of the Dragonflights
	["{npc:15192} now offers the {item:21200} in three kinds: the Path of the Protector (tanks), of the Conqueror (melee fighters) or of the Invoker (casters). Take one: the other two close. Each standing from Friendly to Exalted brings an upgrade of the same ring, 100 reputation each. {quest:8555} sends you after the three shards of the Scepter of the Shifting Sands."] = "{npc:15192} теперь предлагает {item:21200} трёх видов: Путь Защитника (танки), Завоевателя (бойцы ближнего боя) или Призывателя (заклинатели). Возьмите один: два других закроются. Каждый уровень с «Дружелюбия» по «Превознесение» улучшает то же кольцо, по 100 репутации. {quest:8555} отправляет вас за тремя осколками Скипетра Песчаных Бурь.",
	["Pick one: The Path of the Protector, the Conqueror or the Invoker, 100"] = "Выберите один: Путь Защитника, Завоевателя или Призывателя, 100",

	-- Step 11: The red shard: Vaelastrasz
	["The red shard: Vaelastrasz"] = "Красный осколок: Vaelastrasz",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair · {quest:8730} Nefarius's Corruption · {item:21138} Red Scepter Shard
	["The red shard: {npc:13020}, the second boss of {area:2677}, gives {quest:8730} before his fight; Nefarian, the last boss, drops the {item:21138} for one raider on the quest each kill. The quest lasts five hours."] = "Красный осколок: {npc:13020}, второй босс {area:2677}, даёт {quest:8730} до боя; Нефариан, последний босс, роняет {item:21138} для одного рейдера на задании с каждым убийством. Задание длится пять часов.",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair
	["{npc:13020}, {area:2677}: raid of 40"] = "{npc:13020}, {area:2677}: рейд на 40",
	-- {item:21138} Red Scepter Shard
	["{item:21138}, Nefarian"] = "{item:21138}, Нефариан",

	-- Step 12: The blue shard: Azuregos's ledger
	["The blue shard: Azuregos's ledger"] = "Синий осколок: учётная книга Азурегоса",
	-- {npc:15481} Spirit of Azuregos · {zone:1447} Azshara · {npc:11811} Narain Soothfancy · {zone:1446} Tanaris
	["The {npc:15481} stands on the south coast of {zone:1447}. His ledger starts {npc:11811}'s long chain in {zone:1446}."] = "{npc:15481} стоит на южном побережье {zone:1447}. Его учётная книга запускает длинную цепочку {npc:11811} в {zone:1446}.",

	-- Step 13: Narain Soothfancy
	-- {npc:11811} Narain Soothfancy · {area:976} Gadgetzan · {zone:1421} Silverpine Forest · {zone:1446} Tanaris · {npc:8125} Dirge Quikcleave
	["{npc:11811}, a goblin seer, lives in a hut north-east of {area:976}. He sends you three ways at once: to Stewvul's crate in {zone:1421}, to an island off the south coast of {zone:1446}, and to {npc:8125} in {area:976}."] = "{npc:11811}, гоблин-провидец, живёт в хижине северо-восточнее {area:976}. Он отправляет вас сразу тремя путями: к ящику Стювуль в {zone:1421}, на остров у южного побережья {zone:1446} и к {npc:8125} в {area:976}.",

	-- Step 14: Stewvul's crate
	["Stewvul's crate"] = "Ящик Стювуль",
	-- {object:180642} Inconspicuous Crate · {area:230} Greymane Wall · {zone:1421} Silverpine Forest
	["The {object:180642} leans on the {area:230} at the south end of {zone:1421}, left of the closed gate."] = "{object:180642} прислонён к {area:230} на южном конце {zone:1421}, левее закрытых ворот.",

	-- Step 15: Meridith the Mermaiden
	-- {object:180652} Freshly Dug Dirt · {area:987} Land's End Beach · {npc:15526} Meridith the Mermaiden · {quest:8599} Love Song for Narain
	["The {object:180652} lies on the farther of two islands south of {area:987}, past the fatigue line. {npc:15526}, on the sea floor south of the beach's crashed gyrocopter, gives {quest:8599} and a three-minute swim-speed blessing that gets you across."] = "{object:180652} лежит на дальнем из двух островов южнее {area:987}, за линией усталости. {npc:15526} на морском дне южнее разбитого гирокоптера на пляже даёт {quest:8599} и трёхминутное благословение скорости плавания, которое помогает добраться.",

	-- Step 16: The island off Land's End Beach
	-- {area:987} Land's End Beach
	["The island off {area:987}"] = "Остров у {area:987}",

	-- Step 17: Back to Narain Soothfancy
	-- {npc:11811} Narain Soothfancy
	["Back to {npc:11811}"] = "Вернитесь: {npc:11811}",
	-- {quest:8606} Decoy! · {npc:11811} Narain Soothfancy · {area:2255} Everlook · {zone:1452} Winterspring · {npc:15554} Number Two
	["{quest:8606} sends you, disguised with {npc:11811}'s turban, to a drop-off point south of {area:2255} in {zone:1452}. Leave the bag of gold there: {npc:15554}, a level 61 elite, comes for it (group of 3 to 5)."] = "{quest:8606} отправляет вас, замаскированного под тюрбан {npc:11811}, к точке передачи южнее {area:2255} в {zone:1452}. Оставьте там мешок с золотом: {npc:15554}, элита 61-го уровня, придёт за ним (группа из 3–5).",

	-- Step 18: Decoy!
	-- {npc:15554} Number Two
	["{npc:15554}, elite: group of 3 to 5"] = "{npc:15554}, элита: группа из 3–5",

	-- Step 19: Dirge Quikcleave
	-- {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {area:1121} Isle of Dread · {zone:1444} Feralas
	["{npc:8125} cooks in {area:976}. He sends you to the {area:1121} off southern {zone:1444} for a Chimaerok feast."] = "{npc:8125} готовит в {area:976}. Он отправляет вас на {area:1121} у юга {zone:1444} за пиром Химерока.",

	-- Step 20: The Isle of Dread
	-- {area:1121} Isle of Dread
	["The {area:1121}"] = "{area:1121}",
	-- {npc:12803} Lord Lakmaeran · {area:1121} Isle of Dread
	["{npc:12803} and the Chimaerok on the {area:1121} are elites of level 60 to 62 that respawn every ten minutes: a raid's work. The Chimaerok drop a tenderloin about half the time, Lakmaeran two to four now and then."] = "{npc:12803} и Химерок на {area:1121} — элита 60–62 уровней, возрождаются каждые десять минут: работа для рейда. Химерок роняет вырезку примерно в половине случаев, Лакмаеран — два-четыре время от времени.",
	-- {item:21027} Lakmaeran's Carcass · {npc:12803} Lord Lakmaeran
	["{item:21027}, {npc:12803}: raid"] = "{item:21027}, {npc:12803}: рейд",

	-- Step 21: Draconic for Dummies, Volume II
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}, Volume II"] = "{quest:8597}, том II",
	-- {quest:8620} The Only Prescription · {quest:8597} Draconic for Dummies · {npc:15552} Doctor Weavil · {area:2079} Alcaz Island · {zone:1419} Blasted Lands · {area:2255} Everlook · {zone:1458} Undercity · {npc:11811} Narain Soothfancy
	-- plural, as words: Felguard Elites = {npc:8717} Felguard Elite · Doomguard Commanders = {npc:12396} Doomguard Commander
	["{quest:8620} needs the eight chapters of {quest:8597}, Volume II: from {npc:15552} in his house on {area:2079} (a level 63 elite with guards, raid), the Felguard Elites, Doomguard Commanders and Dreadlords of the {zone:1419}, the Hederine south of {area:2255}, and a book in the {zone:1458}. {npc:11811} hands out the binding when you accept."] = "{quest:8620} требует восемь глав {quest:8597}, том II: от {npc:15552} в его доме на {area:2079} (элита 63-го уровня со стражей, рейд), элитных стражей Скверны, командиров Разрушителей и Ужасников {zone:1419}, Хедерина южнее {area:2255} и книги в {zone:1458}. {npc:11811} выдаёт переплёт при принятии.",
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}: Volume II"] = "{quest:8597}: том II",

	-- Step 22: Dirge Quikcleave's Chops
	-- {npc:8125} Dirge Quikcleave
	["{npc:8125}'s Chops"] = "Отбивная {npc:8125}",
	-- {npc:8125} Dirge Quikcleave · {item:9061} Goblin Rocket Fuel · {item:8150} Deeprock Salt · {npc:11811} Narain Soothfancy · {item:18562} Elementium Ore · {item:21136} Arcanite Buoy · {object:180669} Swirling Maelstrom · {zone:1447} Azshara · {area:1227} Bay of Storms · {npc:15571} Maws · {item:21137} Blue Scepter Shard
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar · Azerothian Diamonds = {item:12800} Azerothian Diamond · Blue Sapphires = {item:12361} Blue Sapphire
	["{npc:8125} wants 20 {item:9061} and 20 {item:8150} with the meat. {npc:11811} then wants 20 Arcanite Bars, 10 {item:18562}, 10 Azerothian Diamonds and 10 Blue Sapphires, and gives you an {item:21136}: placed at the {object:180669} in {zone:1447}'s {area:1227}, it calls up {npc:15571}, a level 63 boss for a raid. {npc:15571} drops the {item:21137} for one raider on the quest each kill."] = "{npc:8125} хочет 20 {item:9061} и 20 {item:8150} вместе с мясом. Затем {npc:11811} хочет 20 арканитовых слитков, 10 {item:18562}, 10 азеротских алмазов и 10 синих сапфиров и даёт вам {item:21136}: установленный у {object:180669} в {area:1227} {zone:1447}, он призывает {npc:15571}, босса 63-го уровня для рейда. {npc:15571} роняет {item:21137} для одного рейдера на задании с каждым убийством.",
	-- {item:12360} Arcanite Bar
	["{item:12360}: Alchemists, or the auction house"] = "{item:12360}: алхимики, или аукцион",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}: {area:2677}, or the auction house"] = "{item:18562}: {area:2677}, или аукцион",

	-- Step 23: Maws
	-- {item:21137} Blue Scepter Shard · {npc:15571} Maws
	["{item:21137}, {npc:15571}: raid"] = "{item:21137}, {npc:15571}: рейд",

	-- Step 24: The green shard: Eranikus
	["The green shard: Eranikus"] = "Зелёный осколок: Эраникус",
	-- {npc:15362} Malfurion Stormrage · {npc:5709} Shade of Eranikus · {area:1477} Temple of Atal'Hakkar · {npc:15624} Forest Wisp · {zone:1457} Darnassus · {npc:11832} Keeper Remulos · {zone:1450} Moonglade
	["{npc:15362} appears beside the {npc:5709} at the bottom of the {area:1477} (a five-player dungeon). He sends you to a {npc:15624} outside {zone:1457} (Horde players walk past the city's guards), then to {npc:11832} in {zone:1450}."] = "{npc:15362} появляется рядом с {npc:5709} на дне {area:1477} (подземелье на пять игроков). Он отправляет вас к {npc:15624} снаружи {zone:1457} (игроки Орды проходят мимо стражи города), затем к {npc:11832} в {zone:1450}.",
	-- {npc:15362} Malfurion Stormrage · {area:1477} Temple of Atal'Hakkar
	["{npc:15362}, inside the {area:1477}"] = "{npc:15362}, внутри {area:1477}",

	-- Step 25: The Forest Wisp
	-- {npc:15624} Forest Wisp
	["The {npc:15624}"] = "{npc:15624}",
	-- {npc:15624} Forest Wisp
	["{npc:15624}: 25 (and 25 Cenarion Circle)"] = "{npc:15624}: 25 (и 25 Кругу Кенария)",

	-- Step 26: Keeper Remulos
	-- {quest:8735} The Nightmare's Corruption · {npc:235289} Dragons of Nightmare · {zone:1440} Ashenvale · {zone:1444} Feralas · {zone:1425} Hinterlands · {npc:15625} Twilight Corrupter · {zone:1431} Duskwood
	["{quest:8735} wants a fragment from each of the four {npc:235289} portals: elite dragonkin at the {zone:1440}, {zone:1444} and {zone:1425} portals (5% each) and the {npc:15625} in {zone:1431}. Raid content."] = "{quest:8735} требует фрагмент с каждого из четырёх порталов {npc:235289}: элитные драконоподобные у порталов {zone:1440}, {zone:1444} и {zone:1425} (по 5%) и {npc:15625} в {zone:1431}. Рейдовый контент.",
	["10 (and 100 Cenarion Circle)"] = "10 (и 100 Кругу Кенария)",

	-- Step 27: The Ashenvale portal
	-- {zone:1440} Ashenvale
	["The {zone:1440} portal"] = "Портал {zone:1440}",
	["The four dream portals sit in groves guarded by elite dragonkin of level 60 to 62 that respawn every 30 minutes; each drops the portal's fragment one time in twenty. Raid content."] = "Четыре портала сна стоят в рощах, охраняемых элитными драконоподобными 60–62 уровней, которые возрождаются каждые 30 минут; каждый роняет фрагмент портала один раз из двадцати. Рейдовый контент.",

	-- Step 28: The Duskwood portal
	-- {zone:1431} Duskwood
	["The {zone:1431} portal"] = "Портал {zone:1431}",
	-- {npc:15625} Twilight Corrupter
	["The {npc:15625} (level 63 boss) always drops its fragment."] = "{npc:15625} (босс 63-го уровня) всегда роняет свой фрагмент.",

	-- Step 29: The Feralas portal
	-- {zone:1444} Feralas
	["The {zone:1444} portal"] = "Портал {zone:1444}",

	-- Step 30: Hinterlands portal
	-- {zone:1425} Hinterlands
	["{zone:1425} portal"] = "Портал {zone:1425}",

	-- Step 31: The Nightmare Manifests
	-- {npc:11832} Keeper Remulos · {area:2361} Nighthaven
	["A raid event: follow {npc:11832} toward {area:2361} and keep him alive against Eranikus and his nightmare adds until Tyrande arrives and redeems Eranikus. Do not kill Eranikus."] = "Рейдовое событие: следуйте за {npc:11832} к {area:2361} и не дайте ему погибнуть против Эраникуса и его порождений сна, пока не придёт Тиранда и не спасёт Эраникуса. Не убивайте Эраникуса.",
	["100 (and 100 Cenarion Circle)"] = "100 (и 100 Кругу Кенария)",
	["The Redemption of Eranikus: raid"] = "Искупление Эраникуса: рейд",
	["200 (and 200 Cenarion Circle)"] = "200 (и 200 Кругу Кенария)",

	-- Step 32: The Scepter of the Shifting Sands
	-- {npc:15192} Anachronos · {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj
	["With the three shards, {npc:15192} makes the Scepter of the Shifting Sands. In Classic its first holder rings the {object:180717} once for the whole realm, opening the gates of {area:3428}, and those who finish within ten hours earn the black qiraji crystal mount; whether Forever's realms get that event is not known."] = "С тремя осколками {npc:15192} создаёт Скипетр Песчаных Бурь. В Classic его первый владелец бьёт в {object:180717} один раз на всю реалм, открывая ворота {area:3428}, а те, кто закончит за десять часов, получают чёрного кираджийского кристаллического маунта; получат ли это событие реалмы Forever — неизвестно.",

	-- Step 33: Scarab Gong
	-- {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj · {npc:15693} Jonathan the Revelator · {quest:8745} Treasure of the Timeless One
	["{object:180717} hangs before the gates of {area:3428}. {npc:15693} appears beside it once the gong has been rung, with {quest:8745}: a weapon and 200 reputation."] = "{object:180717} висит перед воротами {area:3428}. {npc:15693} появляется рядом с ним после удара в гонг, с {quest:8745}: оружие и 200 репутации.",

	-- Step 34: Neutral to Friendly in the Temple
	["Neutral to Friendly in the Temple"] = "От «Равнодушия» до «Дружелюбия» в Храме",
	-- {area:16076} Temple of Ahn'Qiraj · {area:2737} Scarab Wall · {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {area:3454} Ruins of Ahn'Qiraj
	["Neutral to Friendly is 3,000 reputation. Every trash mob of the {area:16076} (a 40-player raid behind the {area:2737}) gives 100, and the Twin Emperors 210 each, until 2,999 of 3,000 Neutral, one point short of Friendly; there they stop. Then hand in one saved {item:21230} (1,000, to {npc:15502}) or {item:21229} (500, to {npc:15503}) to tip you over. The shoulder and boot exchanges of the Temple's tier set need no standing: the token, two idols and ten scarabs to {npc:15502} (shoulders) or {npc:15503} (boots) pay 200 each. The {area:3454} (20 players) give a little from bosses: Kurinnaxx, Moam, Buru and Ayamiss 50 each, Rajaxx 34, Ossirian 100, to Exalted."] = "От «Равнодушия» до «Дружелюбия» — 3000 репутации. Каждый моб мусора {area:16076} (рейд на 40 за {area:2737}) даёт 100, а Близнецы-императоры по 210, до 2999 из 3000 «Равнодушия», на один пункт не доходя «Дружелюбия»; там они останавливаются. Затем сдайте один сохранённый {item:21230} (1000, {npc:15502}) или {item:21229} (500, {npc:15503}), чтобы перешагнуть. Обмены на наплечники и сапоги комплекта Храма не требуют уровня: жетон, два идола и десять скарабеев к {npc:15502} (наплечники) или {npc:15503} (сапоги) платят по 200. {area:3454} (20 игроков) дают понемногу с боссов: Куриннакс, Моам, Буру и Аямисс по 50, Раджакс 34, Оссириан 100, до «Превознесения».",
	-- {item:21229} Qiraji Lord's Insignia
	["{item:21229}, Temple bosses"] = "{item:21229}, боссы Храма",
	-- {npc:15503} Kandrostrasz
	["{npc:15503}: 500, handed in from his window"] = "{npc:15503}: 500, сдается через его окно",

	-- Step 35: The ring at Friendly
	["The ring at Friendly"] = "Кольцо на «Дружелюбии»",
	-- {npc:15192} Anachronos
	["At Friendly, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "На «Дружелюбии» {npc:15192} улучшает кольцо выбранного вами пути: Путь Защитника, Завоевателя или Призывателя. Принесите кольцо, которое носите; 100 репутации.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Friendly ring quest of your path"] = "{npc:15192}: задание на кольцо «Дружелюбие» вашего пути",

	-- Step 36: Friendly to Honored: the turn-ins
	["Friendly to Honored: the turn-ins"] = "От «Дружелюбия» до «Уважения»: сдачи",
	-- {item:21230} Ancient Qiraji Artifact · {quest:8784} Secrets of the Qiraji · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {quest:8595} Mortal Champions · {npc:15727} C'Thun
	["Now hand in what you saved. Each {item:21230} (any Temple trash, 1% to 9%) starts {quest:8784}: 1,000 reputation from {npc:15502}, one of the three bronze dragons inside the Temple. Each {item:21229} (nearly every Temple boss) goes to {npc:15503} for {quest:8595}: 500 here and 100 Cenarion Circle. {npc:15727} gives 2,500, to Exalted. Friendly to Honored is 6,000: six artifacts or twelve insignias. Friendly also opens the helm and leg exchanges of the Temple's tier set (200 reputation each) at {npc:15502} and {npc:15503}."] = "Теперь сдавайте то, что сохранили. Каждый {item:21230} (любой мусор Храма, 1–9%) запускает {quest:8784}: 1000 репутации от {npc:15502}, одного из трёх бронзовых драконов внутри Храма. Каждый {item:21229} (почти каждый босс Храма) идёт к {npc:15503} для {quest:8595}: 500 здесь и 100 Кругу Кенария. {npc:15727} даёт 2500, до «Превознесения». От «Дружелюбия» до «Уважения» — 6000: шесть артефактов или двенадцать знаков. «Дружелюбие» также открывает обмены на шлем и поножи комплекта Храма (по 200 репутации) у {npc:15502} и {npc:15503}.",
	-- {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos
	["{item:21230}: right-click it, then {npc:15502}"] = "{item:21230}: щёлкните по нему, затем {npc:15502}",
	-- {quest:8595} Mortal Champions
	["{quest:8595}: 1 insignia, 500"] = "{quest:8595}: 1 знак, 500",

	-- Step 37: The ring at Honored
	["The ring at Honored"] = "Кольцо на «Уважении»",
	-- {npc:15192} Anachronos
	["At Honored, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "На «Уважении» {npc:15192} улучшает кольцо выбранного вами пути: Путь Защитника, Завоевателя или Призывателя. Принесите кольцо, которое носите; 100 репутации.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Honored ring quest of your path"] = "{npc:15192}: задание на кольцо «Уважение» вашего пути",

	-- Step 38: Honored to Revered
	["Honored to Revered"] = "«Уважение» — «Почтение»",
	-- {npc:15727} C'Thun · {quest:8595} Mortal Champions · {quest:8789} Imperial Qiraji Armaments · {npc:15380} Arygos · {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["Honored to Revered is 12,000: twelve artifacts, 24 insignias, or a mix with {npc:15727} (2,500). After the first, each insignia is the repeatable {quest:8595}. Every Temple boss sometimes drops an {quest:8789} or Regalia (about one time in twenty): {npc:15380} and {npc:15378}, inside the Temple once {npc:15727} is dead, take it with 3 {item:18562} for 200 and a weapon. Honored opens the chest exchange of the tier set (200)."] = "От «Уважения» до «Почтения» — 12 000: двенадцать артефактов, 24 знака или смесь с {npc:15727} (2500). После первого каждый знак — повторяемый {quest:8595}. Каждый босс Храма иногда роняет {quest:8789} или Регалию (примерно один раз из двадцати): {npc:15380} и {npc:15378} внутри Храма, после смерти {npc:15727}, принимают его с 3 {item:18562} за 200 и оружие. «Уважение» открывает обмен на нагрудник комплекта (200).",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}, {area:2677} or the auction house"] = "{item:18562}, {area:2677} или аукцион",
	-- {npc:15380} Arygos · {item:18562} Elementium Ore
	["{npc:15380}: Armaments and 3 {item:18562}, 200"] = "{npc:15380}: Вооружение и 3 {item:18562}, 200",
	-- {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["{npc:15378}: Regalia and 3 {item:18562}, 200"] = "{npc:15378}: Регалия и 3 {item:18562}, 200",

	-- Step 39: The ring at Revered
	["The ring at Revered"] = "Кольцо на «Почтении»",
	-- {npc:15192} Anachronos
	["At Revered, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "На «Почтении» {npc:15192} улучшает кольцо выбранного вами пути: Путь Защитника, Завоевателя или Призывателя. Принесите кольцо, которое носите; 100 репутации.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Revered ring quest of your path"] = "{npc:15192}: задание на кольцо «Почтение» вашего пути",

	-- Step 40: Revered to Exalted
	["Revered to Exalted"] = "От «Почтения» до «Превознесения»",
	-- {npc:15727} C'Thun · {quest:8801} C'Thun's Legacy · {npc:15379} Caelestrasz
	["Revered to Exalted is 21,000: 21 artifacts or 42 insignias, with {npc:15727}'s 2,500 a week. {npc:15727}'s eye starts {quest:8801} for {npc:15379} (200, and 200 Cenarion Circle). At Exalted Anachronos gives the last ring: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker."] = "От «Почтения» до «Превознесения» — 21 000: 21 артефакт или 42 знака, с {npc:15727} по 2500 в неделю. Глаз {npc:15727} запускает {quest:8801} для {npc:15379} (200, и 200 Кругу Кенария). На «Превознесении» Анахронос даёт последнее кольцо: Защитник Калимдора, Завоеватель Кираджи или Великий Призыватель.",

	-- Step 41: The Exalted ring
	["The Exalted ring"] = "Кольцо на «Превознесении»",
	-- {npc:15192} Anachronos
	["At Exalted, {npc:15192} gives the last ring of your path: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker. Bring the Revered ring; 100 reputation."] = "На «Превознесении» {npc:15192} даёт последнее кольцо вашего пути: Защитник Калимдора, Завоеватель Кираджи или Великий Призыватель. Принесите кольцо «Почтение»; 100 репутации.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Exalted ring quest of your path"] = "{npc:15192}: задание на кольцо «Превознесение» вашего пути",
}
