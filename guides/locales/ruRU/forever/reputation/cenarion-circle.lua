-- Russian (ruRU): the guide forever/reputation/cenarion-circle (forever/reputation/cenarion-circle.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Cenarion Circle Reputation"] = "Репутация: Круг Кенария",
	-- {zone:1451} Silithus
	["Nature resistance enchants and patterns, badge gear and Forever's new {zone:1451} patterns, from {zone:1451}'s camps."] = "Чары и выкройки сопротивления силам природы, снаряжение за знаки и новые выкройки Forever для зоны {zone:1451} – из лагерей зоны {zone:1451}.",
	-- {zone:1451} Silithus
	["Forever's new {zone:1451} patterns for Tailors, Leatherworkers and Blacksmiths, Friendly and Honored"] = "Новые выкройки Forever для зоны {zone:1451} для портных, кожевников и кузнецов, «Дружелюбие» и «Уважение»",

	-- Step 1: The emissary in Ironforge
	-- {zone:1455} Ironforge
	["The emissary in {zone:1455}"] = "Эмиссар в {zone:1455}",
	-- {npc:15187} Cenarion Emissary Jademoon · {zone:1451} Silithus · {quest:8275} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15187} sends you to {zone:1451} with {quest:8275}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "Необязательно, и нужно только для заданий дреджей позже: {npc:15187} отправляет вас в {zone:1451} с {quest:8275}, письмом на 10 репутации. Пропустите, если вы уже в {zone:1451}.",

	-- Step 2: The emissary in Orgrimmar
	-- {zone:1454} Orgrimmar
	["The emissary in {zone:1454}"] = "Эмиссар в {zone:1454}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {zone:1451} Silithus · {quest:8276} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15188} sends you to {zone:1451} with {quest:8276}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "Необязательно, и нужно только для заданий дреджей позже: {npc:15188} отправляет вас в {zone:1451} с {quest:8276}, письмом на 10 репутации. Пропустите, если вы уже в {zone:1451}.",

	-- Step 3: Cenarion Hold
	-- {area:3425} Cenarion Hold · {zone:1451} Silithus · {faction:609} Cenarion Circle · {npc:15270} Huum Wildmane · {quest:8318} Secret Communication · {item:20404} Encrypted Twilight Text
	["{area:3425} is the walled druid camp in north-central {zone:1451}, with flight points for both sides. Everyone starts Neutral with the {faction:609} (druids at 2,000 of 3,000). Bor and {npc:15270} stand together in the main building. {quest:8318} opens the {item:20404} turn-ins for good. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{area:3425} — огороженный лагерь друидов в северной части {zone:1451}, с точками полёта для обеих фракций. Все начинают с уровнем «Равнодушие» у {faction:609} (у друидов 2 000 из 3 000). Бор и {npc:15270} стоят вместе в главном здании. {quest:8318} навсегда открывает сдачу {item:20404}. Талант наследия Дипломат добавляет до 10% к каждой награде; числа в этом гайде — без него.",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, level 60"] = "{npc:15270}, 60 уровень",

	-- Step 4: The cultist camp west of Cenarion Hold
	-- {area:3425} Cenarion Hold
	["The cultist camp west of {area:3425}"] = "Лагерь культистов западнее {area:3425}",
	-- {item:20404} Encrypted Twilight Text · {npc:11804} Twilight Keeper Havunth
	-- plural, as words: Wind Stones = {object:180461} Wind Stone
	["The nearest Twilight's Hammer camp lies just south-west of the Hold. Avengers, Geolords and Stonecallers (level 57 to 59) each drop an {item:20404} about a third of the time, and every cultist kill is 1 reputation. {npc:11804} walks the edge of the camp. Keep every cultist robe, cowl and mantle you loot: they are the Twilight Trappings for the Wind Stones later."] = "Ближайший лагерь Сумеречного Молота лежит сразу юго-западнее Заставы. Мстители, геолорды и заклинатели камня (57–59 уровни) роняют {item:20404} примерно в трети случаев, а каждое убийство культиста — 1 репутация. {npc:11804} ходит по краю лагеря. Сохраняйте каждое одеяние, капюшон и мантию культиста: это Одеяния Сумеречного Молота для камней Ветров позже.",

	-- Step 5: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Вернитесь: {area:3425}",

	-- Step 6: Cultists until the top of Friendly, texts saved
	["Cultists until the top of Friendly, texts saved"] = "Культисты до вершины «Дружелюбия», тексты сохранены",
	-- {npc:11880} Twilight Avenger · {item:20404} Encrypted Twilight Text · {area:2742} Hive'Ashi · {npc:15308} Twilight Prophet · {npc:15306} Bor Wildmane
	["Neutral to Honored is 9,000 reputation (7,000 for druids). Every {npc:11880}, Geolord, Stonecaller, Master and Overlord gives 1 reputation until 5,999 of 6,000 Friendly, one point short of Honored; there they stop. Save every {item:20404} and leave the quests of the next steps for later: each kill below that point is a free point on top of its text, and the texts and quests pay the same at any standing. A text drops about every third kill, so 30 kills make 30 reputation and 10 texts (100 reputation later). Four camps: south-west of the Hold (39,44), the far west (26,34), the far south-west (19,84) and the north-east below {area:2742} (66,18: Overlords, and Flamereavers that count until the top of Honored). The {npc:15308} (87% text) walks between 18,31 and 23,69. Texts sell on the auction house if you would rather buy. At 5,999 Friendly the last point into Honored comes from a Flamereaver, Twilight Keeper or Marauder, or from your first 10 texts at {npc:15306}."] = "От «Равнодушия» до «Уважения» — 9 000 репутации (7 000 для друидов). Каждый {npc:11880}, геолорд, заклинатель камня, мастер и властелин даёт 1 репутацию до 5 999 из 6 000 «Дружелюбия», на один пункт не доходя «Уважения»; там они останавливаются. Сохраняйте каждый {item:20404} и отложите задания следующих шагов на потом: каждое убийство ниже этой точки — бесплатный пункт сверх текста, а тексты и задания платят одинаково на любом уровне. Текст падает примерно с каждого третьего убийства, так что 30 убийств дают 30 репутации и 10 текстов (100 репутации позже). Четыре лагеря: юго-западнее Заставы (39,44), дальний запад (26,34), дальний юго-запад (19,84) и северо-восток под {area:2742} (66,18: властелины, и огнепожиратели, которые считаются до вершины «Уважения»). {npc:15308} (текст 87%) ходит между 18,31 и 23,69. Тексты продаются на аукционе, если вы предпочитаете купить. На 5 999 «Дружелюбия» последний пункт до «Уважения» приходит от огнепожирателя, хранителя Сумеречного Молота или мародёра, либо от ваших первых 10 текстов у {npc:15306}.",
	["Kills alone to the top of Friendly is 8,999 kills (6,999 for druids), but the texts they drop (about 3,000) are worth 30,000 more: most of the way to Exalted."] = "Одни убийства до вершины «Дружелюбия» — 8 999 убийств (6 999 для друидов), но тексты, которые они роняют (около 3 000), стоят ещё 30 000: большая часть пути до «Превознесения».",
	-- {item:20732} Formula: Enchant Cloak - Greater Fire Resistance · {item:22251} Cenarion Herb Bag · {item:22758} Sylvan Shoulders
	["Friendly (3,000) opens Kania's {item:20732} (10g), Mishta's {item:22251} (2g) and {item:22758} (5g), and Forever's new Friendly gloves patterns (7g 50s)."] = "«Дружелюбие» (3 000) открывает {item:20732} Кании (10з), {item:22251} Мишты (2з) и {item:22758} (5з), а также новые выкройки перчаток «Дружелюбия» от Forever (7з 50с).",
	-- {item:20404} Encrypted Twilight Text
	["{item:20404}: save them"] = "{item:20404}: сохраняйте их",
	-- {npc:15201} Twilight Flamereaver
	["{npc:15201}: still counts at 5,999 Friendly"] = "{npc:15201}: всё ещё считается на 5 999 «Дружелюбия»",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100, for the last point"] = "{npc:15306}: 10 текстов, 100, для последнего пункта",

	-- Step 7: Vyral the Vile
	-- {quest:8321} Vyral the Vile · {area:3446} Twilight's Run · {zone:1451} Silithus
	-- plural, as words: Twilight Masters = {npc:11883} Twilight Master
	["{quest:8321} (level 61, not elite) waits at the back of {area:3446}, the cave in the north-east of {zone:1451}. Flamereavers and Twilight Masters guard the way: the Flamereavers count until the top of Honored, the Masters stop at the top of Friendly like the other cultists."] = "{quest:8321} (61 уровень, не элита) ждёт в глубине {area:3446}, пещеры на северо-востоке {zone:1451}. Путь охраняют огнепожиратели и мастера Сумеречного Молота: огнепожиратели считаются до вершины «Уважения», мастера останавливаются на вершине «Дружелюбия», как остальные культисты.",

	-- Step 8: Silithus quests at Cenarion Hold
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["{zone:1451} quests at {area:3425}"] = "Задания {zone:1451} в {area:3425}",
	-- {quest:8280} Securing the Supply Lines · {quest:8275} Taking Back Silithus · {npc:15196} Deathclasp · {npc:15174} Calandrath · {quest:8307} Desert Recipe · {item:20452} Smoked Desert Dumplings · {npc:15189} Beetix Ficklespragg
	["Now cash in the one-time quests: about 1,700 reputation alone, 2,400 with the group quests. They are level 55 to 60, so they pay in full at 60. {quest:8280} needs {quest:8275} first. {npc:15196} is an elite scorpid with two guards (group of 2 or 3). {npc:15174}'s {quest:8307} is for Cooks: its recipe makes the {item:20452} he wants. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Теперь сдайте одноразовые задания: около 1700 репутации в одиночку, 2400 с групповыми. Они 55–60-го уровня, так что на 60-м дают репутацию полностью. Для задания {quest:8280} сначала нужно выполнить {quest:8275}. {npc:15196} – элитный скорпид с двумя стражами (группа из 2–3 человек). Задание {quest:8307} от NPC {npc:15174} – для кулинаров: его рецепт позволяет приготовить нужный ему предмет {item:20452}. {npc:15189} стоит на верхнем этаже своего здания: поднимитесь внутри, Стрелка не различает этажи.",
	-- {npc:15191} Windcaller Proudhorn · {quest:8275} Taking Back Silithus
	["{npc:15191}, after {quest:8275}"] = "{npc:15191}, после {quest:8275}",
	-- {npc:15196} Deathclasp
	["Wanted poster: {npc:15196}, elite"] = "Объявление о награду: {npc:15196}, элита",
	-- {npc:15174} Calandrath
	["{npc:15174}, for Cooks"] = "{npc:15174}, для поваров",

	-- Step 9: Around Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Around {area:3425}"] = "Вокруг {area:3425}",
	-- {object:180503} Sandy Cookbook
	-- plural, as words: Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer · Dredge Strikers = {npc:11740} Dredge Striker
	["Stonelash Scorpids and Sand Skitterers roam the sands around the Hold; Dredge Strikers dig north-east of it. The {object:180503} lies in the cultist camp south-west of the Hold."] = "Камнехвостые скорпиды и песчаные пауки-быстроноги бродят по пескам вокруг Заставы; землечерпы роют северо-восточнее неё. {object:180503} лежит в лагере культистов юго-западнее Заставы.",

	-- Step 10: Back at the Hold
	["Back at the Hold"] = "Назад к Заставе",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} стоит на верхнем этаже своего здания: поднимитесь внутри, Стрелка не различает этажи.",

	-- Step 11: Stonelash and Dredge Crushers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash and Dredge Crushers"] = "Камнехвостые живодеры и земляные сокрушители",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker · Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash Flayers, Pincers and Rock Stalkers live south and south-west of the Hold; their stingers and fangs drop about one time in ten. Dredge Crushers dig south and west of the Hold."] = "Камнехвостые живодеры, клешневики и скальные пауки-скакуны живут южнее и юго-западнее Заставы; их жала и клыки падают примерно один раз из десяти. Земляные сокрушители роют южнее и западнее Заставы.",
	-- {item:20452} Smoked Desert Dumplings · {object:180503} Sandy Cookbook
	["{item:20452}, from the {object:180503}"] = "{item:20452}, из ящика ({object:180503})",
	-- {item:20452} Smoked Desert Dumplings · {item:20424} Sandworm Meat · {item:3713} Soothing Spices
	["{item:20452}, from {item:20424} and {item:3713}"] = "{item:20452}, из {item:20424} и {item:3713}",

	-- Step 12: Noggle Ficklespragg and Proudhorn
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} and Proudhorn"] = "{npc:15190} и Горн",
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} и {npc:15190} стоят на верхнем этаже своего здания: поднимитесь внутри, Стрелка не различает этажи.",

	-- Step 13: The Ravaged Twilight Camp
	-- {area:3100} Ravaged Twilight Camp
	["The {area:3100}"] = "{area:3100}",
	-- {zone:1451} Silithus
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["The broken camp in the far north-west of {zone:1451}: the Twilight Tablet Fragments lie on the ground among the ruins."] = "Разрушенный лагерь на дальнем северо-западе {zone:1451}: фрагменты табличек Сумеречного Молота лежат на земле среди руин.",

	-- Step 14: Larksbane
	["Larksbane"] = "Ларксбейн",

	-- Step 15: Hermit Ortell
	-- {npc:15194} Hermit Ortell · {zone:1451} Silithus · {quest:8319} Encrypted Twilight Texts · {quest:8349} Bor Wildmane
	["{npc:15194} hides in the hills of eastern {zone:1451}. He also decodes {quest:8319} for a chance at a scroll of beckoning, but {quest:8349} pays the reputation: keep the texts for Bor."] = "{npc:15194} скрывается в холмах восточного {zone:1451}. Он же расшифровывает {quest:8319} ради шанса на свиток призыва, но {quest:8349} платит репутацией: оставьте тексты Бору.",

	-- Step 16: The three Twilight Keepers
	["The three Twilight Keepers"] = "Три хранителя Сумеречного Молота",
	["Each Keeper is a level 60, not elite, alone at a camp edge, and always drops its chapter: Mayna in the far west camp, Havunth in the camp south-west of the Hold, Exeter in the far south-west camp beside the Twilight Lord."] = "Каждый хранитель — 60 уровень, не элита, один на краю лагеря, и всегда роняет свою главу: Майна в дальнем западном лагере, Хавунт в лагере юго-западнее Заставы, Эксетер в дальнем юго-западном лагере рядом с лордом Сумеречного Молота.",

	-- Step 17: Back to Ortell
	["Back to Ortell"] = "Назад к Ортеллу",

	-- Step 18: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Лагерь Бронзоборода",
	-- {zone:1451} Silithus · {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {quest:8304} Dearest Natalia · {item:20379} Noggle's Satchel · {npc:15196} Deathclasp · {spell:10101} Knock Away
	["The dwarves' camp in the south of {zone:1451}. Talk {npc:15171} and {npc:15170} through their whole stories for {quest:8304}. {item:20379} lies on the mountain south-east of the camp. {npc:15196} lives up the trail east of the camp: an elite, and his {spell:10101} can throw you off the cliff."] = "Лагерь дворфов на юге {zone:1451}. Поговорите с {npc:15171} и {npc:15170} по всей их истории для {quest:8304}. {item:20379} лежит на горе юго-восточнее лагеря. {npc:15196} живёт по тропе восточнее лагеря: элита, и его {spell:10101} может столкнуть вас со скалы.",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170}"] = "{npc:15171} и {npc:15170}",
	-- {item:20385} Deathclasp's Pincer
	["{item:20385}, elite: group of 2 or 3"] = "{item:20385}, элита: группа из 2–3",

	-- Step 19: Back to Cenarion Hold with news
	-- {area:3425} Cenarion Hold
	["Back to {area:3425} with news"] = "Назад к {area:3425} с новостями",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} стоит на верхнем этаже своего здания: поднимитесь внутри, Стрелка не различает этажи.",
	["Natalia, elite: group up"] = "Наталья, элита: соберите группу",

	-- Step 20: Rubbings and brains
	["Rubbings and brains"] = "Оттиски и мозги",
	-- {object:210337} Glyphed Crystal · {item:20453} Geologist's Transcription Kit · {area:2742} Hive'Ashi · {area:2743} Hive'Zora · {area:2744} Hive'Regal · {quest:8308} Brann Bronzebeard's Lost Letter
	["Rutgar and Frankal hand out the next two quests at their camp. Each hive has a {object:210337} to rub with the {item:20453}, and its silithid drop the brains: {area:2742} north of the Hold, {area:2743} in the west, {area:2744} in the south. Inside {area:2744} waits Mistress Natalia (level 62 elite, mind control and fear; group of 3 to 5). Now and then a hive silithid drops {quest:8308}: it starts a quest for Rutgar worth 100."] = "Рутгар и Фрэнкал выдают следующие два задания в своём лагере. В каждом улье есть {object:210337}, который нужно зарисовать с помощью {item:20453}, а его силитиды роняют мозги: {area:2742} севернее Заставы, {area:2743} на западе, {area:2744} на юге. Внутри {area:2744} ждёт госпожа Наталья (62 уровень, элита, контроль разума и страх; группа из 3–5). Время от времени силитид улья роняет {quest:8308}: он запускает задание для Рутгара на 100.",
	-- {item:20456} Hive'Regal Rubbing · {area:2744} Hive'Regal
	["{item:20456}, deep in {area:2744}"] = "{item:20456}, в глубине {area:2744}",
	-- {quest:8308} Brann Bronzebeard's Lost Letter
	["{quest:8308}, a rare drop"] = "{quest:8308}, редкая добыча",

	-- Step 21: Mistress Natalia
	["Mistress Natalia"] = "Госпожа Наталья",
	-- {area:2744} Hive'Regal · {zone:1451} Silithus
	["Optional: Natalia waits deep in {area:2744}, the hive in the south of {zone:1451}. She is a level 62 elite who mind-controls, fears and heals herself below half health: bring a group of 3 to 5 and interrupt her heals."] = "Необязательно: Наталья ждёт в глубине {area:2744}, улья на юге {zone:1451}. Это элита 62 уровня, которая берёт в контроль разум, наводит страх и лечит себя ниже половины здоровья: приведите группу из 3–5 и сбивайте её лечение.",
	["Mistress Natalia: group of 3 to 5"] = "Госпожа Наталья: группа из 3–5",

	-- Step 22: The Calling
	-- {quest:8314} Unraveling the Mystery · {quest:8315} The Calling · {npc:15183} Geologist Larksbane · {area:3257} Bones of Grakkarond · {npc:14862} Emissary Roman'khan
	["{quest:8314} leads to {quest:8315}: {npc:15183} sends you to the {area:3257} to summon {npc:14862}, a level 63 boss for a raid of about 20. Take it only with a raid."] = "{quest:8314} ведёт к {quest:8315}: {npc:15183} отправляет вас к {area:3257} призвать {npc:14862}, босса 63 уровня для рейда примерно из 20. Берите только с рейдом.",
	["raid of 20"] = "рейд из 20",
	-- {item:20465} Crystal Unlocking Mechanism · {npc:14862} Emissary Roman'khan
	["{item:20465}, {npc:14862}: raid of 20"] = "{item:20465}, {npc:14862}: рейд из 20",

	-- Step 23: The New Frontier, Thunder Bluff
	-- {quest:1123} Rabine Saturna · {npc:10881} Bluff Runner Windstrider · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:1123}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10881} sends you to {npc:5769} on {area:1639}, who sends you to {quest:1123} in {area:2361}, {zone:1450}."] = "Необязательно: цепочка {quest:1123} платит 525 репутации Круга за семь заданий 55–57 уровней, полностью на 60. {npc:10881} отправляет вас к {npc:5769} на {area:1639}, который отправляет вас к {quest:1123} в {area:2361}, {zone:1450}.",

	-- Step 24: The New Frontier, Darnassus
	-- {quest:6762} Rabine Saturna · {npc:10878} Herald Moonstalker · {npc:3516} Arch Druid Fandral Staghelm · {npc:4217} Mathrengyl Bearwalker · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:6762}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10878} sends you to {npc:3516}, who sends you to {npc:4217}, who sends you to {quest:6762} in {area:2361}, {zone:1450}."] = "Необязательно: цепочка {quest:6762} платит 525 репутации Круга за семь заданий 55–57 уровней, полностью на 60. {npc:10878} отправляет вас к {npc:3516}, который отправляет вас к {npc:4217}, который отправляет вас к {quest:6762} в {area:2361}, {zone:1450}.",

	-- Step 25: Rabine Saturna
	-- {quest:1123} Rabine Saturna · {area:2361} Nighthaven · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest · {zone:1451} Silithus
	["{quest:1123} lives in {area:2361}. She sends you to {npc:13220} at {area:3077}, the camp in the north-east corner of {zone:1451}."] = "{quest:1123} живёт в {area:2361}. Она отправляет вас к {npc:13220} в {area:3077}, лагере в северо-восточном углу {zone:1451}.",

	-- Step 26: Southwind Village
	-- {area:2738} Southwind Village · {area:3425} Cenarion Hold · {object:178553} Hive'Ashi Pod
	-- plural, as words: Tortured Druids = {npc:12178} Tortured Druid
	["The Tortured Druids and Sentinels roam the ruins of {area:2738}, south-east of {area:3425}; the {object:178553} sits on the top floor of its wasp-circled tower."] = "Истерзанные друиды и стражи бродят по руинам {area:2738}, юго-восточнее {area:3425}; {object:178553} стоит на верхнем этаже его башни, оплетённой осами.",

	-- Step 27: Umber in Nighthaven
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} in {area:2361}"] = "{npc:11939} ({area:2361})",

	-- Step 28: Quests elsewhere
	["Quests elsewhere"] = "Задания в других местах",
	-- {faction:609} Cenarion Circle · {zone:1414} Kalimdor · {npc:10739} Mulgris Deepriver · {zone:1422} Western Plaguelands · {area:2100} Maraudon · {quest:1123} Rabine Saturna · {item:18501} Felvine Shard · {area:2577} Dire Maul
	["The {faction:609}'s other quests are spread over {zone:1414} and the Plaguelands. Forever pays them in full at any level: The Wildlife Suffers Too ({npc:10739}, {zone:1422}, levels 54 and 56) 75 and 75, Corruption of Earth and Seed ({area:2100}, level 51) 150. Shards of the Felvine ({quest:1123}, level 60, the {item:18501} from Alzzin in {area:2577}) pays 150 and its Reliquary 100 at any level."] = "Остальные задания {faction:609} разбросаны по {zone:1414} и Чумным землям. Forever платит их полностью на любом уровне: «Животные страдают тоже» ({npc:10739}, {zone:1422}, уровни 54 и 56) 75 и 75, «Осквернение земли и зерно» ({area:2100}, 51 уровень) 150. «Осколки Сквернолесья» ({quest:1123}, 60 уровень, {item:18501} от Алзина в {area:2577}) платит 150, а его Реликварий 100 на любом уровне.",
	-- {zone:1422} Western Plaguelands · {area:2100} Maraudon
	["Do the {zone:1422} and {area:2100} quests while you level; at 60 they may pay a fraction."] = "Делайте задания {zone:1422} и {area:2100}, пока качаетесь; на 60 они могут платить лишь часть.",

	-- Step 29: Encrypted Twilight Texts to Revered
	-- {quest:8319} Encrypted Twilight Texts
	["{quest:8319} to Revered"] = "{quest:8319} до уровня «Почтение»",
	-- {npc:15306} Bor Wildmane · {quest:8319} Encrypted Twilight Texts · {npc:14479} Twilight Lord Everun · {item:20733} Formula: Enchant Cloak - Greater Nature Resistance · {item:22773} Pattern: Sylvan Crown
	["Honored to Revered is 12,000 reputation. {npc:15306} takes 10 {quest:8319} for 100 reputation, again and again, until Exalted: 120 turn-ins (1,200 texts) to Revered without the quests, or about 950 texts after them. Hand in the texts you saved now. The cultists no longer count, but the Flamereavers, Twilight Keepers, Marauders and Templars count until 11,999 of 12,000 Honored, and the {npc:14479} and Prophet until Exalted. Honored opens Kania's {item:20733} (10g), Mishta's {item:22773} (5g) and Forever's new Honored patterns (7g 50s each)."] = "От «Уважения» до «Почтения» — 12 000 репутации. {npc:15306} берёт 10 {quest:8319} за 100 репутации, снова и снова, до «Превознесения»: 120 сдач (1 200 текстов) до «Почтения» без заданий, или около 950 текстов после них. Сдайте сохранённые тексты сейчас. Культисты больше не считаются, но огнепожиратели, хранители Сумеречного Молота, мародёры и храмовники считаются до 11 999 из 12 000 «Уважения», а {npc:14479} и пророк — до «Превознесения». «Уважение» открывает {item:20733} Кании (10з), {item:22773} Мишты (5з) и новые выкройки «Уважения» от Forever (7з 50с каждая).",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100"] = "{npc:15306}: 10 текстов, 100",

	-- Step 30: Field Duty, level 60
	-- {quest:8507} Field Duty
	["{quest:8507}, level 60"] = "{quest:8507}, 60 уровень",
	-- {npc:15540} Windcaller Kaldon · {area:3425} Cenarion Hold · {quest:8507} Field Duty · {npc:15440} Captain Blackanvil · {area:2743} Hive'Zora · {npc:15612} Krug Skullsplit · {area:2744} Hive'Regal · {item:20809} Tactical Assignment · {item:7936} Ornate Mithril Boots · {npc:15542} Twilight Marauder · {quest:9338} Allegiance to Cenarion Circle
	-- plural, as words: Heavy Runecloth Bandages = {item:14530} Heavy Runecloth Bandage
	["{npc:15540} stands by the moonwell of {area:3425}. {quest:8507} (25 reputation, repeatable) sends you with unsigned papers to your side's captain: {npc:15440}'s Ironforge Brigade outside {area:2743} (Alliance) or {npc:15612}'s Orgrimmar Legion outside {area:2744} (Horde). Use the papers first, then talk to the captain: a level 60 elite silithid attacks; keep the captain alive and he signs. Kaldon then lets you pick a Combat, Logistics or {item:20809}, each holding a random briefing worth 50 reputation and a badge: 30 hive silithid kills (elites), goods such as 30 Heavy Runecloth Bandages or 3 {item:7936}, or one Templar, {npc:15542} or scout report. One badge of each kind buys {quest:9338} at Kaldon: 200 reputation, repeatable. A full round is about 375 reputation."] = "{npc:15540} стоит у лунного колодца {area:3425}. {quest:8507} (25 репутации, повторяемое) отправляет вас с неподписанными бумагами к капитану своей фракции: Железноградской бригаде {npc:15440} под {area:2743} (Альянс) или Оргриммарскому легиону {npc:15612} под {area:2744} (Орда). Используйте бумаги, затем поговорите с капитаном: нападает элитный силитид 60 уровня; не дайте капитану погибнуть, и он подпишет. Затем Калдон даёт выбрать «Бой», «Снабжение» или {item:20809}, каждое с случайным приказом на 50 репутации и значком: 30 убийств силитидов улья (элита), припасы вроде 30 плотных бинтов из рунной ткани или 3 {item:7936}, либо один отчёт храмовника, {npc:15542} или разведчика. По одному значку каждого вида покупает {quest:9338} у Калдона: 200 репутации, повторяемое. Полный круг — около 375 репутации.",
	["Allegiance: one Combat, Logistics and Tactical badge, 200"] = "Верность: один значок «Бой», «Снабжение» и «Тактика», 200",
	-- {quest:8800} Cenarion Battlegear · {npc:15176} Vargus
	["{quest:8800}: {npc:15176}'s badge gear"] = "{quest:8800}: доспех за значки от {npc:15176}",

	-- Step 31: Templars and the Abyssal Council
	["Templars and the Abyssal Council"] = "Храмовники и Совет Бездны",
	-- {object:180456} Lesser Wind Stone · {item:20513} Abyssal Crest · {quest:8361} Abyssal Contacts · {npc:15270} Huum Wildmane · {quest:8331} Aurel Goldleaf · {item:14344} Large Brilliant Shard · {object:180461} Wind Stone · {item:20514} Abyssal Signet
	["Wearing a full set of Twilight Trappings (cultist Cowl, Mantle and Robe, about 8%, 8% and 6% per cultist) lets you use a {object:180456}: two stand in each of the three western camps. A random Abyssal Templar appears: a level 60 elite for 1 to 3 players, 5 reputation until the top of Honored and an {item:20513} 93% of the time. The summon uses up the set (and later the medallion and ring too), and if the elemental gets away they are gone: summon only when you can win. {quest:8361} pays 100 for the first crest; after that Bor takes 3 crests for 50. From Friendly, {npc:15270} sends you to {quest:8331}: 3 crests and a {item:14344} buy the Medallion of Station that, worn with a set, opens the larger {object:180461} for a Duke (level 62 elite, group of 5; 25 reputation, {item:20514} 85%)."] = "Надевая полный комплект Одеяний Сумеречного Молота (капюшон, мантия и одеяние культиста, примерно 8%, 8% и 6% с каждого культиста), вы можете использовать {object:180456}: по два стоят в каждом из трёх западных лагерей. Появляется случайный храмовник Бездны: элита 60 уровня для 1–3 игроков, 5 репутации до вершины «Уважения» и {item:20513} в 93% случаев. Призыв тратит комплект (а позже и медальон с кольцом), и если элементаль уйдёт, они пропали: призывайте, только если можете победить. {quest:8361} платит 100 за первую печать; после Бор берёт 3 печати за 50. С «Дружелюбия» {npc:15270} отправляет вас к {quest:8331}: 3 печати и {item:14344} покупают Медальон Стоянки, который в комплекте открывает больший {object:180461} для герцога (элита 62 уровня, группа из 5; 25 репутации, {item:20514} 85%).",
	-- {item:20513} Abyssal Crest
	["{item:20513}: Templar, group of 1 to 3"] = "{item:20513}: храмовник, группа из 1–3",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Friendly"] = "{npc:15270}, «Дружелюбие»",
	-- {item:14344} Large Brilliant Shard
	["3 crests and a {item:14344}: the Medallion of Station"] = "3 печати и {item:14344}: Медальон Стоянки",
	-- {item:20514} Abyssal Signet
	["{item:20514}: Duke, group of 5"] = "{item:20514}: герцог, группа из 5",

	-- Step 32: Signets and scepters to Exalted
	["Signets and scepters to Exalted"] = "Кольца и скипетры до «Превознесения»",
	-- {quest:8363} Abyssal Signets · {npc:15282} Aurel Goldleaf · {item:20515} Abyssal Scepter · {quest:9248} A Humble Offering · {quest:8343} Goldleaf's Discovery · {quest:8341} Lords of the Council · {object:180466} Greater Wind Stone · {item:22252} Satchel of Cenarius · {item:22660} Gaea's Embrace · {item:22756} Sylvan Vest · {npc:15176} Vargus
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["Revered to Exalted is 21,000 reputation: 210 text turn-ins (2,100 texts), or less with the rest. From Honored, Bor takes 3 {quest:8363} for 100 (each Duke also gives 25, to Exalted), and {npc:15282} takes one {item:20515} for {quest:9248} (200, once). From Revered, {quest:8343} leads to {quest:8341}: 3 signets and 5 Large Brilliant Shards buy the Ring of Lordship, and set, medallion and ring open the {object:180466} for an Abyssal Lord: a level 63 boss for a raid of about 20, 50 reputation, and an {item:20515}. Bor pays 200 for the first scepter and 150 for each 3 after. Revered opens Mishta's {item:22252} (5g), {item:22660} (9g) and {item:22756} (5g); Exalted is the standing for Champion's Battlegear at {npc:15176}."] = "От «Почтения» до «Превознесения» — 21 000 репутации: 210 сдач текстов (2 100 текстов), или меньше с остальным. С «Уважения» Бор берёт 3 {quest:8363} за 100 (каждый герцог также даёт 25, до «Превознесения»), а {npc:15282} берёт один {item:20515} для {quest:9248} (200, один раз). С «Почтения» {quest:8343} ведёт к {quest:8341}: 3 кольца и 5 больших сверкающих осколков покупают Кольцо Владычества, а комплект, медальон и кольцо открывают {object:180466} для лорда Бездны: босс 63 уровня для рейда примерно из 20, 50 репутации, и {item:20515}. Бор платит 200 за первый скипетр и 150 за каждые 3 после. «Почтение» открывает {item:22252} Мишты (5з), {item:22660} (9з) и {item:22756} (5з); «Превознесение» — уровень для боевого доспеха чемпиона у {npc:15176}.",
	["10 texts: 100"] = "10 текстов: 100",
	-- {quest:8363} Abyssal Signets
	["3 {quest:8363}: 100, Honored"] = "3 {quest:8363}: 100, «Уважение»",
	-- {item:20515} Abyssal Scepter
	["{item:20515}: Lord, raid of 20"] = "{item:20515}: лорд, рейд из 20",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Revered"] = "{npc:15270}, «Почтение»",
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["3 signets and 5 Large Brilliant Shards: the Ring of Lordship"] = "3 кольца и 5 больших сверкающих осколков: Кольцо Владычества",
	-- {quest:8364} Abyssal Scepters
	["3 {quest:8364}: 150, Revered"] = "3 {quest:8364}: 150, «Почтение»",

	-- Step 33: The Ruins of Ahn'Qiraj, when they open
	-- {area:3454} Ruins of Ahn'Qiraj
	["The {area:3454}, when they open"] = "{area:3454}, когда откроются",
	-- {area:2737} Scarab Wall · {zone:1451} Silithus · {quest:8791} The Fall of Ossirian · {npc:15185} Brood of Nozdormu · {npc:15498} Windcaller Yessendra · {npc:15500} Keyl Swiftclaw · {npc:15499} Warden Haro · {npc:16091} Dirk Thunderwood · {quest:9023} The Perfect Poison · {item:22217} Kurinnaxx's Venom Sac · {area:19} Zul'Gurub · {npc:15471} Lieutenant General Andorov · {item:22219} Plans: Jagged Obsidian Shield · {item:22191} Obsidian Mail Tunic
	["A 20-player raid behind the {area:2737} in the far south-west of {zone:1451}. A full clear is about 1,600 Cenarion reputation: the trash 3 each until 20,999 of 21,000 Revered, Kurinnaxx, Moam, Buru and Ayamiss 150 each and Ossirian 300, to Exalted. Ossirian's head starts {quest:8791} (200 here and 200 {npc:15185}). Their drops buy the ring (Honored), cloak (Revered) and weapon (Exalted) quests of {npc:15498}, {npc:15500} and {npc:15499} in the Hold, 100 reputation each. {npc:16091} in the Hold pays 100 once for {quest:9023}: {item:22217} from here and Venoxis's from {area:19}. {npc:15471} sells {item:22219} (Revered, 5g) and {item:22191} (Exalted, 8g) inside."] = "Рейд на 20 игроков за {area:2737} на дальнем юго-западе {zone:1451}. Полный зачист — около 1 600 репутации Круга: мусор по 3 до 20 999 из 21 000 «Почтения», Куриннакс, Моам, Буру и Аямисс по 150 и Оссириан 300, до «Превознесения». Голова Оссириана запускает {quest:8791} (200 здесь и 200 {npc:15185}). Их добыча покупает задания на кольцо («Уважение»), плащ («Почтение») и оружие («Превознесение») у {npc:15498}, {npc:15500} и {npc:15499} в Заставе, по 100 репутации. {npc:16091} в Заставе платит 100 один раз за {quest:9023}: {item:22217} отсюда и от Веноксиса из {area:19}. {npc:15471} продаёт {item:22219} («Почтение», 5з) и {item:22191} («Превознесение», 8з) внутри.",

	-- Step 34: Venoxis's Venom Sac, Zul'Gurub
	-- {quest:9023} The Perfect Poison · {npc:14507} High Priest Venoxis · {area:19} Zul'Gurub · {zone:1434} Stranglethorn Vale
	["Optional, for {quest:9023}: {npc:14507} is the first boss of {area:19}, a 20-player raid in north-east {zone:1434}."] = "Необязательно, для {quest:9023}: {npc:14507} — первый босс {area:19}, рейда на 20 игроков на северо-востоке {zone:1434}.",
	-- {item:22216} Venoxis's Venom Sac
	["{item:22216}: raid of 20"] = "{item:22216}: рейд из 20",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Abyssal Crests, Abyssal Signets and Abyssal Scepters are repeatable at {npc:15306} once their opening quests are done."] = "{item:20513}, {item:20514} и {item:20515} можно сдавать NPC {npc:15306} повторно после вводных заданий.",
	-- ["Encrypted Twilight Texts repeats: {npc:15306} takes more texts again and again. The cultist camps are the place to farm them."] = "Задание с текстами повторяется: {npc:15306} принимает: {item:20404} – снова и снова. Фармите их в лагерях культистов.",
	-- ["From here on, the {area:3454} raid and the Abyssal Council turn-ins (crests, signets, scepters) carry most of the reputation."] = "Дальше основную репутацию дают рейд {area:3454} и сдача знаков Совета Бездны (талисманы, перстни, скипетры).",
	-- ["Keep farming the Twilight camps. Wearing the Twilight Trappings (the Twilight cultist set plus a Medallion of Station, from {npc:15282}'s Medallion of Station quest) lets you summon Abyssal Templars at the Wind Stones; their Abyssal Crests go to {npc:15306}."] = "Продолжайте фармить лагеря Сумеречного Молота. В облачении культиста Сумеречного Молота и со станционным медальоном (задание «Станционный медальон» от NPC {npc:15282}) можно призывать храмовников у камней ветра ({object:180461}); {item:20513} с них сдавайте NPC {npc:15306}.",
	-- ["Keep running the {area:3454} and turning in Abyssal Council insignia until Exalted."] = "Проходите {area:3454} и сдавайте знаки Совета Бездны до превознесения.",
	-- ["Optional, 100 reputation once: {quest:9419}. Your side's camp sits by a hive: {npc:17080}'s by {area:2743} (Alliance), {npc:17079}'s by {area:2744} (Horde). Silithyst rises from glowing geysers around the desert: walk through one, carry the Silithyst to your camp's Silithyst Extractor, then talk to the camp's leader. It is a world PvP objective: players of the other side can take it from you."] = "Необязательно, 100 репутации один раз: {quest:9419}. Лагерь вашей фракции стоит у улья: {npc:17080} у {area:2743} (Альянс), {npc:17079} у {area:2744} (Орда). Силитист поднимается из светящихся гейзеров вокруг пустыни: пройдите через один, отнесите силитист в экстрактор силитиста вашего лагеря, затем поговорите с лидером лагеря. Это мировская PvP-цель: игроки другой фракции могут забрать его у вас.",
	-- ["Silithyst"] = "Силитист",
	-- ["Twilight's Hammer cultists hold the camps in western {zone:1451}. {quest:8320} and Stonecallers mix here; any cultist can drop an {item:20404}. Every cultist kill also counts toward the {faction:609}. The Geolords count for {quest:8320} only if you are 60 and took it."] = "Культисты Сумеречного Молота занимают лагеря на западе зоны {zone:1451}. Здесь вперемешку геолорды ({quest:8320}) и камнезовы; с любого культиста может упасть {item:20404}. Каждое убийство культиста также дает репутацию ({faction:609}). Геолорды засчитываются для задания {quest:8320}, только если вам 60 и вы его взяли.",
	-- ["deliver Silithyst at the extractor"] = "доставьте силитист в экстрактор",
	-- ["{area:3425} is the walled town in north-central {zone:1451}. Bor and {npc:15270} stand together inside. The {faction:609} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:3425} – обнесенный стеной городок в центре севера зоны {zone:1451}. Бор и {npc:15270} стоят внутри рядом. {faction:609}: начальная репутация – равнодушие. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- ["{faction:609} to Exalted"] = "{faction:609} до уровня «Превознесение»",
	-- ["{faction:609} to Honored"] = "{faction:609} до уровня «Уважение»",
	-- ["{faction:609} to Revered"] = "{faction:609} до уровня «Почтение»",
	-- ["{npc:15306}: Encrypted Twilight Texts"] = "{npc:15306}: {item:20404}",
	-- ["{quest:8320} needs level 60"] = "{quest:8320}: нужен 60-й уровень",
}
