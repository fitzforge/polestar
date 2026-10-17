-- Russian (ruRU): the guide forever/alliance/skyborne/01-zephras-isle (forever/alliance/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Grove
	-- {area:16622} Thendal Grove · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker · {npc:251368} Elatrell Featherlight
	["You wake in {area:16622}. {npc:251362} stands beside you; {npc:251361} is a few steps west, {npc:251368} by the south edge of the grove."] = "Вы просыпаетесь здесь: {area:16622}. {npc:251362} стоит рядом с вами; {npc:251361} – в нескольких шагах к западу, {npc:251368} – у южного края рощи.",

	-- Step 2: Vuldren and Cirrusflies
	["Vuldren and Cirrusflies"] = "Лисвены и щетинистые осы",
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} and Pesky Cirrusflies roam the meadow just south-east of the grove."] = "{npc:250873} и назойливые щетинистые осы бродят по лугу чуть юго-восточнее рощи.",

	-- Step 3: Back to Thendal Grove
	-- {area:16622} Thendal Grove
	["Back to {area:16622}"] = "Назад: {area:16622}",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}: {item:4100}",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964} – в сторожевой башне",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}: записка от вашего учителя",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}: прочитайте предмет {item:9547}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389} – в сторожевой башне",
	-- {npc:251379} Dorii Brightwhisper · {item:282416} Glowing Recall Crystal
	["{npc:251379}, the mage trainer: read the {item:282416} first"] = "{npc:251379} – учитель магов: сначала прочитайте предмет {item:282416}",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373} – учитель друидов, на первом этаже древа за {npc:251361}",
	["The class trainers stand together in the grove"] = "Учителя классов стоят вместе в роще",
	-- {npc:257554} Halaan Hawk-Eye
	["Listen to {npc:257554}"] = "Выслушайте {npc:257554}",
	-- {spell:1259416} Walk on Air
	["Use {spell:1259416}"] = "Используйте: {spell:1259416}",

	-- Step 4: Raw Windstones and the Cirrusfly Queen
	-- {npc:251404} Cirrusfly Queen
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones and the {npc:251404}"] = "Ветрокаменное сырье и {npc:251404}",
	-- {quest:92463} The Cirrusfly Queen · {npc:249363} Yala Windwatcher
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones glitter on the ground just south of the grove. {quest:92463} hovers over the meadow further east, on the way to {npc:249363}."] = "Ветрокаменное сырье блестит на земле чуть южнее рощи. {quest:92463} парит над лугом дальше к востоку, по пути к NPC {npc:249363}.",

	-- Step 5: Yala Windwatcher
	-- {npc:249363} Yala Windwatcher · {npc:251143} Roiling Winds · {object:460002} Ley Line (no name in this language: may be words) · {spell:1259705} Read Leyline
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your {spell:1259705} racial ability at it."] = "{npc:249363} несет дозор к востоку от рощи. {npc:251143} и ал'акетские новообращенные собираются чуть севернее нее; лей-линия поднимается дальше к северу: примените на ней расовую способность {spell:1259705}.",
	-- {spell:1259705} Read Leyline · {object:460002} Ley Line (no name in this language: may be words)
	["Cast {spell:1259705} at the {object:460002}"] = "Примените расовую способность {spell:1259705} на лей-линии",

	-- Step 6: Thendal Grove turn-ins
	-- {area:16622} Thendal Grove
	["{area:16622} turn-ins"] = "Сдача заданий: {area:16622}",
	["Level 4 spells"] = "Заклинания 4-го уровня",

	-- Step 7: Scrawny Ursera and Urs'anah
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	["{npc:250926} and {npc:251115}"] = "{npc:250926} и {npc:251115}",
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	-- plural, as words: Ursera Scavengers = {npc:250937} Ursera Scavenger
	["{npc:250926} prowl the woods just west of the grove; the Ursera Scavengers den further west, with {npc:251115}, the matriarch, at the back of the den."] = "{npc:250926} рыщут в лесу чуть западнее рощи; медверы-падальщики живут в логове дальше на западе, в глубине которого – матриарх {npc:251115}.",

	-- Step 8: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {npc:256935} Malduko Cloudcrush
	["{npc:252095} camps south of the Ursera den. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle."] = "{npc:252095} стоит лагерем к югу от логова медвер. Ал'акетские громилы удерживают лагерь к юго-западу от нее; {npc:256935} стоит в его центре.",

	-- Step 9: Aetheen of the Gales
	["Level 6 spells"] = "Заклинания 6-го уровня",

	-- Step 10: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:263664} Raan Wildwind · {npc:251523} Constable Aonda · {npc:251903} Rathiril Sunlance
	["Follow the road south to {area:16624}. {npc:263664} camps by the fire west of the village; {npc:251523} and {npc:251903} stand in its middle."] = "Идите по дороге на юг: {area:16624}. {npc:263664} стоит лагерем у костра к западу от деревни; {npc:251523} и {npc:251903} – в ее центре.",
	-- {npc:251903} Rathiril Sunlance · {npc:254089} Coriella Calmbreeze
	["Speak with {npc:251903} and {npc:254089}, north-west of the village"] = "Поговорите: {npc:251903} и {npc:254089}, к северо-западу от деревни",

	-- Step 11: Raan Wildwind
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "Сядьте (/sit) у костра {npc:263664}, пока не получите эффект «{spell:1229451}»",

	-- Step 12: Village quests
	["Village quests"] = "Задания деревни",
	["The bounty board"] = "Доска объявлений о награде",

	-- Step 13: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "Когти прайда и буреноги",
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders roam the grasslands south of the village. Galestriders drop both the eggs and the meat."] = "Когти прайда и буреноги бродят по лугам к югу от деревни. С буреногов падают и яйца, и мясо.",

	-- Step 14: Back to Shen'dar
	["Back to Shen'dar"] = "Назад в Шен'дар",

	-- Step 15: The Highlands bandits
	["The Highlands bandits"] = "Бандиты нагорья",
	-- plural, as words: Highlands Bandits = {npc:251918} Highlands Bandit
	["The Highlands Bandits camp north-east of the village. \"Badwind\" Bennic waits at the far north end of their camp."] = "Бандиты нагорья стоят лагерем к северо-востоку от деревни. Бенник-Баламут ждет в дальней северной части их лагеря.",

	-- Step 16: Shen'dar turn-ins
	["Shen'dar turn-ins"] = "Сдача заданий в Шен'даре",

	-- Step 17: Falaath Village
	-- {npc:257065} Missionary Jasaan · {quest:92529} Falaath Village · {spell:1254832} Mark of Akir
	["{npc:257065} waits at the entrance to {quest:92529}, south of Shen'dar. The {spell:1254832} lets you walk in among the faithful."] = "{npc:257065} ждет у входа в деревню ({quest:92529}) к югу от Шен'дара. {spell:1254832} позволяет вам ходить среди верующих.",
	["Search the wardrobe"] = "Обыщите шкаф",

	-- Step 19: Havoc in Falaath
	["Havoc in Falaath"] = "Хаос в Фалаате",
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	["Back in {quest:92529}: Stormcallers and {npc:251662} fill the village, the Stormcallers carry the stolen supplies, and {npc:251966} stands at its south end."] = "Снова здесь: {quest:92529}. Деревню заполняют призыватели бури и {npc:251662}; украденные припасы носят призыватели бури, а {npc:251966} стоит в южной части деревни.",

	-- Step 20: The Western Watch
	-- {npc:252155} Peacekeeper Vaaniel · {npc:256966} Skypriest Aanders
	["{npc:252155} holds the western watch, south-west of Falaath. {npc:256966} and the fallen guards lie just south of her."] = "{npc:252155} удерживает западный дозор к юго-западу от Фалаата. {npc:256966} и павшие стражи лежат чуть южнее нее.",
	-- {item:254871} Bloody Note
	["The {item:254871}"] = "{item:254871}",

	-- Step 21: The hippogryph roost
	["The hippogryph roost"] = "Гнездовье гиппогрифов",
	-- {item:263493} Hippogryph Down
	["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them."] = "Идите на северо-запад к гнездам гиппогрифов на западных утесах. {item:263493} лежит вокруг гнезд; среди них патрулирует гиппогриф-матриарх.",

	-- Step 22: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	["{npc:254589} lurks in the hills south-west of the village, on the way back. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} прячется в холмах к юго-западу от деревни, на обратном пути. {npc:254589} – элитный противник: лучше собрать группу.",

	-- Step 23: Windshaper Novice Seers
	-- plural, as words: Windshaper Novice Seers = {npc:257532} Windshaper Novice Seer
	["Windshaper Novice Seers"] = "Провидцы-новички Ваятелей Ветра",
	["The Novice Seers practise in the clearing west of Shen'dar."] = "Провидцы-новички упражняются на поляне к западу от Шен'дара.",

	-- Step 24: Shen'dar Village again
	-- {area:16624} Shen'dar Village
	["{area:16624} again"] = "Снова здесь: {area:16624}",

	-- Step 25: The road to Valanaar
	-- {area:16638} Valanaar
	["The road to {area:16638}"] = "Дорога: {area:16638}",
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield · {area:16638} Valanaar
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Take the road south-east. {npc:257006} and {npc:252448} stand by the road west of {area:16638}; Windsong Crawlers line the shore further west, around 51,70."] = "Идите по дороге на юго-восток. {npc:257006} и {npc:252448} стоят у дороги к западу от места {area:16638}; ветроозерные крабы – на берегу дальше к западу, около 51,70.",

	-- Step 26: Valanaar
	-- {npc:252383} Valennia Stormfist · {npc:252476} Talaanis Shadowsong · {area:16638} Valanaar · {npc:252475} Elaadrin Evengale · {npc:253204} Dondallion Whisperwind
	["{npc:252383} and {npc:252476} stand at the north end of {area:16638}, {npc:252475} and {npc:253204} at the south end."] = "{npc:252383} и {npc:252476} стоят в северной части города ({area:16638}), {npc:252475} и {npc:253204} – в южной.",

	-- Step 27: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Небопрыги",
	-- {area:16638} Valanaar
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers swarm the fields west of {area:16638}."] = "Небопрыги кишат на полях к западу от места {area:16638}.",

	-- Step 28: The missing scholar
	["The missing scholar"] = "Пропавший ученый",
	-- {object:581822} Bloodstained Satchel · {area:16638} Valanaar
	-- plural, as words: Shriekling Matriarchs = {npc:253283} Shriekling Matriarch
	["The {object:581822} lies by the path west of {area:16638}; Fillion's camp is north-west of it, and the Shriekling Matriarchs nest just west of the camp."] = "{object:581822} лежит у тропы к западу от места {area:16638}; лагерь Филлиона – к северо-западу от нее, а визгуны-матриархи гнездятся чуть западнее лагеря.",
	-- {object:581822} Bloodstained Satchel
	["The {object:581822}"] = "{object:581822}",
	["Find Fillion and his bedroll"] = "Найдите Филлиона и его спальный мешок",

	-- Step 29: Aamelia Windfield
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} runs the farm in the south-west lowlands."] = "{npc:252800} управляет фермой в юго-западной низине.",

	-- Step 30: The Windfield farm
	["The Windfield farm"] = "Ферма Ветрополей",
	-- {quest:92683} Flutterfly Dust · {npc:250929} Malfunctioning Cyclone Construct
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple · Hungry Bandits = {npc:252802} Hungry Bandit · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Ripe Stormapples and Hungry Bandits are in the orchard by the farm, {quest:92683} in the fields north-east of it, Ornery Galestriders all around. The {npc:250929} stands in the field north-east of the farm."] = "Спелые буреяблоки и голодные бандиты – в саду у фермы, {quest:92683} – на полях к северо-востоку от нее, задиристые буреноги – повсюду. {npc:250929} стоит на поле к северо-востоку от фермы.",

	-- Step 31: Aamelia Windfield again
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} again"] = "Снова {npc:252800}",

	-- Step 32: Bandit Highwaymen
	["Bandit Highwaymen"] = "Придорожные бандиты",
	["The Bandit Highwaymen hold the hills north of the farm."] = "Придорожные бандиты занимают холмы к северу от фермы.",

	-- Step 33: Standing our ground
	["Standing our ground"] = "Держим оборону",
	-- {npc:252800} Aamelia Windfield · {npc:252863} Ferauu the Bludgeon
	["Stand with {npc:252800} against {npc:252863}"] = "Сражайтесь вместе с {npc:252800} против врага: {npc:252863}",

	-- Step 34: Valanaar turn-ins
	-- {area:16638} Valanaar
	["{area:16638} turn-ins"] = "Сдача заданий: {area:16638}",
	-- {npc:252377} Seena Skybreaker · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["{npc:252377}: {npc:257196} waits at the {area:16629}"] = "{npc:252377}: {npc:257196} ждет здесь: {area:16629}",
	-- {npc:252373} Anathamaas Aetherwind
	["{npc:252373}, the mage trainer"] = "{npc:252373} – учитель магов",

	-- Step 35: Taming the Beast
	-- {item:15908} Taming Rod · {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {npc:254411} Quel'dora Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler · Vuldren Alphas = {npc:250874} Vuldren Alpha · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Each of Quel'ana's quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her in {area:16638}. Windsong Crawlers line the shore west of town; Vuldren Alphas and Ornery Galestriders roam the {area:16626} around the Windfield farm. Her sister {npc:254411} stands beside her."] = "Каждое задание Кве'ланы дает вам предмет {item:15908}: примените его на названном звере, затем верните жезл ей ({area:16638}). Ветроозерные крабы – на берегу к западу от города; вожаки лисвенов ({npc:250874}) и задиристые буреноги бродят здесь: {area:16626}, вокруг фермы Ветрополей. Рядом с ней стоит ее сестра {npc:254411}.",
	-- {npc:254588} Windsong Crawler · {item:15908} Taming Rod
	["{npc:254588}: tame it with the {item:15908}"] = "{npc:254588}: приручите его с помощью предмета {item:15908}",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Приручите его с помощью предмета {item:15908}",

	-- Step 36: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "Огромные ветрокамни",
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations stand on the rise west of Fillion's camp."] = "Огромные ветрокамни стоят на возвышенности к западу от лагеря Филлиона.",
	-- {item:262668} Wind-Infused Bough · {quest:92529} Falaath Village
	["{item:262668}: by the wind shrine south of {quest:92529}"] = "{item:262668}: у святилища ветра к югу от деревни ({quest:92529})",

	-- Step 38: The eastern watchtower
	["The eastern watchtower"] = "Восточная сторожевая башня",
	-- {npc:252378} Yorana Windyreed · {area:16638} Valanaar · {npc:252666} Commander Belguilos
	["{npc:252378} holds the watchtower north of {area:16638}. The Al'Aketh camp is just west of the tower, its healers around 65,68 and 65,65; {npc:252666} stands at its north end. The Al'Aketh there drop Windstone Charms."] = "{npc:252378} удерживает сторожевую башню к северу от места {area:16638}. Ал'акетский лагерь – чуть западнее башни, его целители – около 65,68 и 65,65; {npc:252666} стоит в его северной части. С тамошних ал'акетцев падают ал'акетские ветрокаменные талисманы.",

	-- Step 39: Valanaar, the turncoat
	-- {area:16638} Valanaar
	["{area:16638}, the turncoat"] = "{area:16638}: предатель",

	-- Step 40: Urs'endris
	-- {npc:255853} Urs'endris · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands
	["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623} west of {area:16638}, by the road you take next."] = "{npc:255853} ждет у водопада к северо-востоку от места {area:16638}. {npc:258443} рыщет здесь: {area:16623}, к западу от места {area:16638}, у дороги, по которой вы пойдете дальше.",

	-- Step 41: The dead cultist
	["The dead cultist"] = "Мертвый культист",
	-- {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["North-west of Valanaar along the road: {npc:273017} watches the {quest:98512}; the dead cultist lies just north of him."] = "К северо-западу от Валанаара по дороге: {npc:273017} следит за врагами ({quest:98512}); мертвый культист лежит чуть севернее него.",
	["Search the dead cultist"] = "Обыщите мертвого культиста",
	-- {npc:258443} Ur'endra
	["{npc:258443}, in the highlands south-west of the cultist"] = "{npc:258443} – на нагорье к юго-западу от культиста",

	-- Step 42: Desperate times
	["Desperate times"] = "Отчаянные времена",
	-- {npc:251968} Ayessa Dawnsinger · {npc:252475} Elaadrin Evengale
	["Rally Valennia, {npc:251968} (west of town) and {npc:252475}"] = "Соберите Валеннию, Айессу ({npc:251968}, к западу от города) и {npc:252475}",
	["Meet Valennia at the gate"] = "Встретьтесь с Валеннией у ворот",

	-- Step 43: Strength and Mercy
	-- {npc:255853} Urs'endris · {area:16638} Valanaar
	["Back to {npc:255853} by the falls north-east of {area:16638}, on the way north to the shrine."] = "Назад: {npc:255853} у водопада к северо-востоку от места {area:16638}, по пути на север к святилищу.",

	-- Step 44: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {npc:253576} Hyusaa Quickbreeze · {npc:253590} Valennia Stormfist
	["Fight north to the {area:16629}. Guardians, Spiritcallers and Blademasters hold the approach; {npc:253576} waits at the shrine's door, {npc:253590} inside the inner sanctum."] = "С боем пробивайтесь на север: {area:16629}. Подступы удерживают ал'акетские стражи, призыватели духов и мастера клинка; {npc:253576} ждет у двери святилища, {npc:253590} – во внутреннем святилище.",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, in the sanctum"] = "{npc:253590} – во внутреннем святилище",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}: {npc:257196}, west of the shrine's approach"] = "{item:263993}: {npc:257196}, к западу от подступов к святилищу",

	-- Step 45: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}. {npc:257944} camps in its east."] = "Идите на север: {area:16631}. {npc:257944} стоит лагерем в восточной части леса.",

	-- Step 46: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Stormchasers = {npc:252664} Al'Aketh Stormchaser
	["Al'Aketh Stormchasers and Footsoldiers camp just north of {npc:257944} and drop the heirloom; the Shrieklings west of her drop the feathers and talons; the {item:265105} grows along the stream west of her."] = "Ал'акетские ловцы бурь и пехотинцы стоят лагерем чуть севернее {npc:257944}; с них падает реликвия. С визгунов к западу от нее падают перья и когти; {item:265105} растет вдоль ручья к западу от нее.",

	-- Step 47: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "Снова {npc:257944}",

	-- Step 48: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive
	["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}."] = "{npc:254151}, {npc:258130} и {npc:258134} – к северо-востоку от {npc:257944}; {npc:253622} стоит к востоку от них. С Хаалиена также падает {quest:94490}.",
	-- {npc:258130} Jorel Windsinger
	["Heal 7 druids in the Nightfang Den, then find {npc:258130}"] = "Исцелите 7 друидов в логове Ночного Клыка, затем найдите NPC {npc:258130}",

	-- Step 49: Elegael Thornpaw, the missive
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the missive"] = "{npc:257944}: послание",

	-- Step 50: The Strange Hermit
	-- {quest:93159} The Strange Hermit · {npc:257944} Elegael Thornpaw
	-- plural, as words: Zephyrseed Cones = {object:613238} Zephyrseed Cone
	["{quest:93159} lives west of {npc:257944}. The Zephyrseed Cones lie in the woods between his hut and {npc:257944}."] = "{quest:93159} живет к западу от {npc:257944}. Бризошишки лежат в лесу между его хижиной и {npc:257944}.",

	-- Step 51: The refugees' camp
	["The refugees' camp"] = "Лагерь беженцев",
	-- {item:266433} Abandoned Belongings · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["North of the cones: the Wind Hollows drift around the refugees' camp, the {item:266433} lie between the tents, and {npc:259013} lies at its north end."] = "К северу от шишек: вокруг лагеря беженцев парят ветряные мертвени, {item:266433} лежат между палатками, а {npc:259013} лежит в северной части лагеря.",

	-- Step 52: Back to the Hermit
	["Back to the Hermit"] = "Назад к отшельнику",

	-- Step 53: High Priestess Lorthuna
	-- {area:16629} Shrine of Akir
	["Lorthuna waits on the eastern shore of the isle, east of the {area:16629}."] = "Лортуна ждет на восточном берегу острова, к востоку от места {area:16629}.",

	-- Step 54: Valanaar, the fate of Zephras
	-- {area:16638} Valanaar
	["{area:16638}, the fate of Zephras"] = "{area:16638}: судьба Зефриса",
	-- {npc:252475} Elaadrin Evengale · {npc:259084} Denaaris Stargale
	["{npc:252475}: {npc:259084} waits by the Skyborne portal"] = "{npc:252475}: {npc:259084} ждет у портала небеснорожденных",

	-- Step 55: The skycutter
	["The skycutter"] = "Небесный катер",
	-- {area:16638} Valanaar · {area:279} Dalaran
	["The skycutter docks at the tower south of {area:16638}. It lands by the Kirin Tor camp on the lake shore west of {area:279}."] = "Небесный катер причаливает у башни к югу от места {area:16638}. Он приземляется у лагеря Кирин-Тора на берегу озера к западу от места {area:279}.",
	-- {area:279} Dalaran
	["Skycutter to {area:279}"] = "Небесный катер: {area:279}",

	-- Step 56: Denaaris Stargale
	-- {npc:259084} Denaaris Stargale · {zone:1453} Stormwind
	["{npc:259084} stands beside the Skyborne Portal where the zeppelin lands. The portal takes you to {zone:1453}."] = "{npc:259084} стоит у портала небеснорожденных, где приземляется дирижабль. Портал переносит вас сюда: {zone:1453}.",
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind
	["{npc:270459}, beside {npc:259084}: for {npc:5504} in {zone:1453}"] = "{npc:270459} – рядом с {npc:259084}: для персонажа {npc:5504} ({zone:1453})",

	-- Step 57: Stormwind Keep
	-- {object:2117} Stormwind Keep · {zone:1436} Westfall
	["Bolvar Fordragon stands in the throne room of {object:2117}, at the north end of the city. Then leave by the main gate for {zone:1436}."] = "Верховный лорд Болвар Фордрагон стоит в тронном зале ({object:2117}) в северной части города. Затем выходите через главные ворота: {zone:1436}.",
	-- {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["For {npc:234} at {area:108}"] = "Для персонажа {npc:234} ({area:108})",

	-- Step 58: Sheldras Moontree
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form · {zone:1439} Darkshore
	["{npc:5504}, {zone:1453}'s druid trainer, teaches you {spell:18960}. {npc:11802}'s welcome waits for your {spell:499} trip at the end of {zone:1439}."] = "{npc:5504}, учитель друидов ({zone:1453}), обучит вас заклинанию «{spell:18960}». Приветствие ({npc:11802}) будет ждать вашего путешествия за заклинанием «{spell:499}» в конце отрезка «{zone:1439}».",

	-- Step 59: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497} стоит в Святилище волшебника – башне в квартале ({object:2101}); она дает вам флягу для водопада ({quest:1861}).",

	-- Step 60: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Выходите из города ({zone:1453}) через главные ворота. Водопад ({quest:1861}) – к юго-западу от ворот, по пути на запад, в зону {zone:1436}: наполните {item:7207} у его подножия.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Read Ley Line at the {object:460002}"] = "Примените расовую способность чтения лей-линий: {object:460002}",
	-- ["Rorian: {quest:92485}"] = "Рориан: {quest:92485}",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read Ley Line racial ability at it."] = "{npc:249363} несет дозор к востоку от рощи. {npc:251143} и ал'акетские новообращенные собираются чуть севернее нее; {object:460002} поднимается дальше к северу: примените на ней расовую способность чтения лей-линий.",
}
