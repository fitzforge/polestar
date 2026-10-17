-- Russian (ruRU): the guide forever/horde/30-40/01-desolace (forever/horde/30-40/01-desolace.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Летите сюда: {area:1637}",
	-- {area:484} Freewind Post · {area:1637} Orgrimmar
	["From {area:484}, fly to {area:1637}."] = "Из точки {area:484} летите сюда: {area:1637}.",

	-- Step 2: Alliance Relations
	-- {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits · {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city. Skyborne: {npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:5639} ждет на Волоке; {npc:5640} – здесь: {object:172961}, в западной части города. Небеснорожденные: {npc:4949} ждет в Крепости Громмаш, ориентир: {object:172957}.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Крепость Громмаш, если у вас есть это задание",

	-- Step 3: Train
	["Train"] = "Обучение",
	["Train your new spells."] = "Изучите новые заклинания.",

	-- Step 4: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:460} Sun Rock Retreat
	["Your trainer is in {area:1638}, one flight away: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to {area:460} from there."] = "Ваш учитель – в городе {area:1638}, в одном перелете отсюда: {npc:3033} (друиды), ориентир: {area:1639}; {npc:246344} (паладины). Оттуда летите дальше сюда: {area:460}.",

	-- Step 5: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Классовые задания: {zone:1454}",
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892} стоит здесь: {object:172957}.",

	-- Step 6: Ratchet
	-- {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly to {area:392}. {npc:5901} camps on the coast a short ride south of the town."] = "Летите сюда: {area:392}. {npc:5901} стоит лагерем на побережье, недалеко к югу от городка.",

	-- Step 7: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post."] = "Летите сюда: {area:484}. {npc:5905} прячется в небольшой пещере в стене каньона к северо-востоку от лагеря.",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: ваш предмет – {item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905} также выдает задание о помощи стихий ({area:1717}) – цепочку 33-40 к оружию бури: forever/class/shaman/call-of-air-horde.",

	-- Step 8: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "Летите сюда: {area:460}",

	-- Step 9: Gizelton caravan
	["Gizelton caravan"] = "Караван Гизлтона",
	-- {zone:1443} Desolace · {area:608} Nijel's Point · {npc:11625} Cork Gizelton · {area:609} Kolkar Village
	["Follow the road south-west out of Sun Rock into {zone:1443} and on south past {area:608}. {npc:11625}'s kodo caravan waits by the road north of {area:609}; if it has already left, ride on."] = "Идите по дороге на юго-запад от Приюта у Солнечного Камня в край {zone:1443} и дальше на юг, мимо места {area:608}. Караван кодо ждет у дороги к северу от места {area:609} (хозяин: {npc:11625}); если он уже ушел, езжайте дальше.",

	-- Step 10: Bodyguard for Hire
	-- {area:609} Kolkar Village · {npc:11625} Cork Gizelton · {area:2617} Scrabblescrew's Camp · {area:597} Ghost Walker Post
	["The caravan rolls south past {area:609}. Kolkar raiders ambush it in waves: kill them before they reach {npc:11625}. It stops by {area:2617}, east of {area:597}."] = "Караван идет на юг мимо места {area:609}. Кентавры племени Колкар нападают волнами: убивайте их, пока они не добрались до {npc:11625}. Караван остановится у места {area:2617}, к востоку от места {area:597}.",

	-- Step 12: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395} стоит в лагере; {npc:5641} и {npc:4498} ждут на холме к западу от него, над местом {area:596}.",

	-- Step 13: Kodo Roundup
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. Five kodos, one at a time."] = "Примените предмет {npc:11596} ({item:13892}) на старом, умирающем кодо или на этом: {npc:4702} на кладбище и отведите прирученного кодо к {npc:11596}. Пять кодо, по одному.",

	-- Step 14: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	["Ride north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "Езжайте на северо-восток сюда: {area:609}. {quest:1365} (35) ходит среди шатров в восточной части с одним-двумя полководцами (32-33): расчистите все вокруг, затем выманите его одного при полном здоровье.",

	-- Step 15: Sargeron
	-- {area:603} Sargeron
	["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not."] = "К северу, вдоль восточных холмов, сатиры занимают руины: {area:603}. Тенеловы невидимы; четыре нужных вам вида – нет.",

	-- Step 16: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {item:20310} Flayed Demon Skin
	["Ride west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "Езжайте на запад сюда: {area:599}. Измотайте культиста (Пылающий Клинок) и до его смерти примените на нем предмет {item:6436}, чтобы получить {item:6435}. Иногда с них падает {item:20310} (1-5%); если выпадет, прочтите его.",

	-- Step 17: Ghost Walker Post
	["Ride back south to the post."] = "Возвращайтесь на юг в лагерь.",
	-- {npc:5641} Takata Steelblade · {quest:1431} Alliance Relations · {zone:1454} Orgrimmar
	["{npc:5641}'s next {quest:1431} sends you back to {zone:1454} for nothing: leave it."] = "Следующее задание {npc:5641} ({quest:1431}) зря отправит вас обратно в город {zone:1454}: не берите его.",

	-- Step 18: Kolkar ears
	["Kolkar ears"] = "Уши кентавров Колкар",
	-- {area:609} Kolkar Village
	["Back at {area:609}, every Kolkar can drop an ear."] = "Вернитесь сюда: {area:609}. С любого кентавра Колкар может упасть ухо.",

	-- Step 19: Shadowstalker scalp
	["Shadowstalker scalp"] = "Скальп тенелова",
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Shadowstalkers = {npc:4674} Hatefury Shadowstalker
	["The Hatefury Shadowstalkers at {area:603} walk unseen until they strike; about one in three carries a scalp."] = "Тенеловы из племени Ярой Ненависти ({area:603}) невидимы до нападения; скальп примерно у каждого третьего.",

	-- Step 21: Shadowprey Village
	-- {area:606} Gelkis Village
	["Ride south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "Езжайте на юго-запад к деревне троллей на побережье, по пути обходите место {area:606}.",
	-- {npc:11877} Roon Wildmane · {npc:715} Hemet Nesingwary
	["{npc:11877}: for {npc:715} in Stranglethorn"] = "{npc:11877}: для задания в Тернистой долине ({npc:715})",

	-- Step 22: Clam beds
	["Clam beds"] = "Отмели с моллюсками",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler
	["Ride north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "Езжайте на север вдоль берега. Гигантские моллюски в мягком панцире лежат на мелководье, а разъяренные рифовые крабы бродят по пляжу; открывайте моллюсков в сумках, чтобы достать мясо.",

	-- Step 23: Slitherblade Oracles
	-- plural, as words: Slitherblade Oracles = {npc:4718} Slitherblade Oracle
	["Slitherblade Oracles"] = "Оракулы из клана Скользящего Плавника",
	-- {area:598} Sar'theris Strand
	["Keep north to {area:598}. The Oracles stand among the other naga at its north end; pull one at a time."] = "Идите дальше на север сюда: {area:598}. Оракулы стоят среди других наг в северной части; выманивайте по одному.",

	-- Step 24: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["{npc:11863} waits in the ruined tower of {area:2405}, inland to the south-east."] = "{npc:11863} ждет в разрушенной башне ({area:2405}), вглубь суши к юго-востоку.",

	-- Step 25: Burning Blade Seer
	-- {area:599} Thunder Axe Fortress · {area:2405} Ethel Rethor
	["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "Ясновидец стоит в южной части места {area:599}, к востоку от места {area:2405}. Сначала перебейте культистов вокруг.",

	-- Step 26: Ethel Rethor
	["His next errand is not on this route."] = "Его следующее поручение не входит в этот маршрут.",

	-- Step 27: Ghost Walker Post
	["Ride south-east to the post."] = "Езжайте на юго-восток в лагерь.",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "Следующее поручение {npc:5641} – повелитель демонов с элитной охраной: пропустите его.",

	-- Step 28: Gelkis Village
	["Ride south-west towards Shadowprey. The Gelkis centaurs (32-35) around their village are a good camp; fight them until level 32."] = "Езжайте на юго-запад к Деревне Ночных Охотников. Кентавры племени Гелкис (32-35) вокруг своей деревни – хорошее место: бейте их до 32-го уровня.",
	-- {area:606} Gelkis Village · {zone:1443} Desolace
	-- plural, as words: Gelkis Stampers = {npc:4648} Gelkis Stamper
	["grind on Gelkis Stampers and Windchasers at the {area:606}, {zone:1443}"] = "бейте чеканщиков и ветроловок из племени Гелкис: {area:606}, {zone:1443}",

	-- Step 30: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638} from Shadowprey and train with {npc:3033} on {area:1639}, then fly on to {zone:1454}."] = "Из Деревни Ночных Охотников летите сюда: {area:1638}, учитель: {npc:3033} ({area:1639}), затем летите дальше: {zone:1454}.",

	-- Step 31: Fly to Orgrimmar
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Распорядитель полетов: {area:2408}",

	-- Step 32: Zeppelin to the Undercity
	-- {area:1497} Undercity
	["Zeppelin to the {area:1497}"] = "Дирижабль: {area:1497}",
	-- {zone:1454} Orgrimmar · {area:1497} Undercity
	["Leave {zone:1454} by the main gate; the zeppelin tower stands just north-east of it. Take the {area:1497} zeppelin."] = "Выйдите из города {zone:1454} через главные ворота; башня дирижаблей – чуть к северо-востоку. Садитесь на дирижабль: {area:1497}.",
	["Zeppelin tower"] = "Башня дирижаблей",

	-- Step 33: Garen Largo
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093} trains Paladins in the {area:1497}."] = "{npc:260093} обучает паладинов. Город: {area:1497}.",

	-- Step 34: Brazier of Everfount
	-- {area:1497} Undercity · {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Do your shopping in the {area:1497} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "Сначала сделайте покупки ({area:1497}), затем летите сюда: {area:228}. {object:113791} стоит на холме чуть к юго-западу: одолейте оскверненное проявление {npc:5901} рядом, положите его наручи в жаровню, поговорите с персонажем {npc:5895} и сохраните {item:7813} для Айслен. Из места {area:228} летите дальше: {area:272}.",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}: from Stranglethorn, next guide"] = "для персонажа {npc:5901}: из Тернистой долины, в следующем руководстве",

	-- Step 35: Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Strong Troll's Blood Potion · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house here if you can (or ask an alchemist). No potion: skip the Elixir steps in {area:287}."] = "Для задания {quest:515} нужен предмет {item:3388} (профессия {skill:171}): купите на аукционе, если можете (или попросите алхимика). Нет зелья – пропустите шаги с эликсиром ({area:287}).",
	-- {item:3388} Strong Troll's Blood Potion · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388}: аукцион или алхимик, для задания {quest:515}.",
	-- {npc:4551} Michael Garrett
	["{npc:4551}, the bat handler"] = "{npc:4551}, укротитель летучих мышей",

	-- Step 36: Tarren Mill
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, для персонажа {npc:2333}",
	-- {npc:2770} Tallow · {area:321} Hammerfall
	["{npc:2770}: for {area:321} in Arathi, later on the route"] = "{npc:2770}: для места {area:321} в Арати, позже по маршруту",
	-- {npc:2229} Krusk · {zone:1413} Barrens
	["{npc:2229}: for the {zone:1413}, later on the route"] = "{npc:2229}: для края {zone:1413}, позже по маршруту",

	-- Step 37: Daggerspine naga
	["Daggerspine naga"] = "Наги Пронзающего Гребня",
	-- {area:271} Southshore
	["Ride south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "Езжайте на юг, к востоку от места {area:271}, к побережью. Наги клана Пронзающего Гребня занимают берег к юго-востоку от городка.",
	["Daggerspine shore"] = "Берег наг Пронзающего Гребня",

	-- Step 38: Torn Fin murlocs
	["Torn Fin murlocs"] = "Мурлоки Рваного Плавника",
	-- {area:271} Southshore
	["Follow the shore west past {area:271}'s bay; the Torn Fin murlocs camp on the beaches beyond it."] = "Идите по берегу на запад мимо залива ({area:271}); мурлоки племени Рваного Плавника живут на пляжах за ним.",
	["Torn Fin beach"] = "Пляж мурлоков Рваного Плавника",

	-- Step 39: Apothecary Lydon
	-- {area:272} Tarren Mill · {area:271} Southshore
	["Ride back north to {area:272}, keeping west of {area:271}."] = "Возвращайтесь на север сюда: {area:272}, держась к западу от места {area:271}.",

	-- Step 40: Shindigger keg
	["Shindigger keg"] = "Бочонок «Землекопского крепкого»",
	-- {area:287} Hillsbrad
	["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "Бочонок стоит с несколькими другими в лагере Синдиката на юго-восточном побережье ({area:287}).",

	-- Step 41: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "Назад: {area:272}",
	["Hearth back (or ride north if it is on cooldown)."] = "Вернитесь камнем возвращения (или езжайте на север, если он еще не готов).",
	-- {object:1729} Tainted Keg · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn"] = "Поставьте предмет {object:1729} сюда: {object:1728} (у таверны)",

	-- Step 42: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik
	["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Идите по дороге на север от места {area:272} в предгорья Альтерака. {quest:535} ждет у лагеря Синдиката; отдайте ему пиво.",

	-- Step 43: Syndicate missives
	["Syndicate missives"] = "Донесения Синдиката",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Преступники и воры Синдиката (32-33) у лагерей к западу от дороги носят донесения; примерно с каждого третьего падает одно.",

	-- Step 44: Helcular's Rod
	-- {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-31) fill the caves in the hills west of {area:272}; about one in sixteen carries the rod."] = "К юго-западу пещерные и лютые йети (30-31) населяют пещеры в холмах к западу от места {area:272}; жезл примерно у одного из шестнадцати.",

	-- Step 45: The Dalaran traitors
	-- {area:279} Dalaran
	["The {area:279} traitors"] = "Предатели: {area:279}",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens."] = "Идите на запад вдоль подножия гор к фиолетовому куполу ({area:279}). {npc:2411}, {npc:2412} и {npc:2413} (33-34) стоят вместе у восточного края кратера, {npc:2414} (35) – чуть западнее; у каждого по куску Кровавого камня. С даларанских стражников со щитом и чудотворцев (31-32) вокруг падают истертые каменные талисманы.",

	-- Step 46: Tarren Mill
	-- {area:272} Tarren Mill
	["Ride back east to {area:272}."] = "Возвращайтесь на восток сюда: {area:272}.",
	-- {area:271} Southshore
	["Thaivand's next task ends at {area:271}'s graveyard and the magus offers a dungeon errand: leave both."] = "Следующее задание Тайлванда ведет на кладбище ({area:271}), а маг предлагает поручение в подземелье: не берите оба.",

	-- Step 47: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Ride north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side."] = "Езжайте на север мимо лагеря ({quest:535}) сюда: {area:280} – деревня Синдиката (35-37). {item:3704} – у персонажа {npc:2431}; {quest:503} сидит в клетке в доме в северной части.",

	-- Step 48: Tarren Mill
	-- {area:272} Tarren Mill
	["Ride back south to {area:272}."] = "Возвращайтесь на юг сюда: {area:272}.",

	-- Step 49: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Летите сюда: {area:1497}",
	-- {area:1497} Undercity · {object:3202} Grom'gol
	["The next guide starts in the {area:1497}, at the {object:3202} zeppelin."] = "Следующее руководство начинается здесь: {area:1497}, у дирижабля ({object:3202}).",
}
