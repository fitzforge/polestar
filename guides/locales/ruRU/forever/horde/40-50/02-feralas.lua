-- Russian (ruRU): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "Летите сюда: {object:3202}",
	-- {zone:2548} Riverglades · {area:340} Kargath
	["Coming from the {zone:2548}: {area:340}'s flight master stands at the foot of the fortress."] = "Если вы прибыли из зоны {zone:2548}: распорядитель полетов ({area:340}) стоит у подножия крепости.",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Распорядитель полетов: {area:340}",

	-- Step 2: Fly to Grom'gol
	-- {area:75} Stonard
	["{area:75} flight master"] = "Распорядитель полетов: {area:75}",

	-- Step 3: Grom'gol Base Camp
	-- {object:3202} Grom'gol · {area:35} Booty Bay · {npc:1514} Mokk the Savage · {zone:1454} Orgrimmar · {object:2076} Bubbling Cauldron
	["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "Полет заканчивается здесь: {object:3202}. Более сложные поручения Тернистой долины, оставшиеся с первого визита, теперь вам по силам: вождь Череполомов, лагеря Занзила, пираты {area:35}, побережье наг и {npc:1514} – затем дирижабль в {zone:1454}. Задание на вождя Череполомов дает {object:2076} рядом с Нимбоей.",
	-- {object:2076} Bubbling Cauldron · {quest:586} Speaking with Gan'zulah
	["the {object:2076}: {quest:586}"] = "{object:2076}: {quest:586}",

	-- Step 4: Zul'Mamwe
	["Zul'Mamwe"] = "Зул'Мамбве",
	-- {npc:1059} Ana'thek the Cruel · {quest:586} Speaking with Gan'zulah · {npc:1060} Mogh the Undying
	["Ride east to the Skullsplitter ruins east of the Venture Co. mine. The headhunters, berserkers and hunters roam the ruins.\n{npc:1059} (45) carries the Broken Armor for {quest:586}: he walks the south-western ruins with two guards and sometimes stands in a small cave there. Pull the guards first.\nCareful: {npc:1060}, an elite troll (level 44), stands in the southern ruins around 47.7,44.3: pull the headhunters and berserkers away from him."] = "Езжайте на восток к руинам Череполомов к востоку от шахты Торговой компании. По руинам бродят охотники за головами, берсерки и охотники.\nУ NPC {npc:1059} (45) – сломанный доспех для задания «{quest:586}»: он ходит по юго-западным руинам с двумя стражами и иногда стоит в небольшой пещере там. Сначала выманите стражей.\nОсторожно: {npc:1060}, элитный тролль (44-й уровень), стоит в южных руинах около 47.7,44.3: оттаскивайте охотников за головами и берсерков подальше от него.",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "",

	-- Step 5: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Back west to {object:3202}."] = "Возвращайтесь на запад: {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks bask beside the road south, on the ride to {area:35}"] = "{npc:2519}: василиски греются у дороги на юг, по пути в {area:35}",

	-- Step 6: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Железозубые василиски",
	-- {area:35} Booty Bay
	["Ride south along the road towards {area:35}; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Езжайте на юг по дороге к {area:35}; василиски греются на камнях к востоку от нее посреди джунглей. Осколки падают часто.",
	["Below ground"] = "Под землей",

	-- Step 7: Pirate ghosts and Zanzil's camps
	["Pirate ghosts and Zanzil's camps"] = "Призраки пиратов и лагеря Занзила",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs" · {npc:2534} Zanzil the Outcast
	-- plural, as words: Zanzil Witch Doctors = {npc:1490} Zanzil Witch Doctor
	["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "Далее на юго-запад, в джунгли к северо-востоку от Туманной долины: там бродят три пирата-призрака рядом с лагерями Занзила. {npc:2535} и {npc:2536} стоят вместе, {npc:2537} – дальше к востоку. Смесь может быть у любого последователя Занзила.\nОсторожно: знахари Занзила (44) колдуют, а лагеря плотные: выманивайте с краю по одному. {npc:2534} (46) стоит в южном лагере около 39.6,58.6, в паре шагов от призрака {npc:2537}: выманите {npc:2537} на север или восток, прежде чем сражаться с Занзилом.",

	-- Step 8: Witch Doctor Unbagwa
	-- {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["West into Mistvale: {npc:1449} sits among the gorillas. Any gorilla can drop a fang: hand him ten and stay by him, he calls three waves of gorillas, then {npc:1514}.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "На запад в Туманную долину: {npc:1449} сидит среди горилл. Клык может упасть с любой гориллы: отдайте ему десять и оставайтесь рядом – он призовет три волны горилл, затем NPC {npc:1514}.\nОсторожно: три волны горилл идут одна за другой почти без передышки, затем {npc:1514}. Начинайте с полным здоровьем и маной и держитесь рядом с Унбагвой. Некоторым классам в одиночку тяжело: с другом будет легко.",

	-- Step 9: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "{area:1577}: убивайте их по пути",
	-- {object:759} Holy Spring · {area:43} Wild Shore · {area:35} Booty Bay
	["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them.\nFollow the coast south. If you still need the {area:43} pirates, take the road past the {area:35} tunnel to the beach before going into town."] = "",

	-- Step 10: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	["Stay on the beach with the swashbucklers (41-43); the charts and the orders lie in their tents and in the rowboat beside the larger camp. Leave the ships alone."] = "",

	-- Step 12: Dudd Fizzlescroll
	-- {quest:95384} Partial Mystical Notes · {npc:260873} Dudd Fizzlescroll · {area:35} Booty Bay
	["If you already have the {quest:95384}, give them to {npc:260873} here in {area:35}."] = "",

	-- Step 14: Booty Bay
	-- {area:35} Booty Bay · {npc:2494} Privateer Bloads · {npc:2486} Fin Fizracket · {npc:2498} Crank Fizzlebub · {npc:737} Kebok · {npc:773} Krazek
	["In {area:35}: {npc:2494} on the docks, {npc:2486} by the inn, {npc:2498} inside it, MacKinley, {npc:737} and {npc:773} upstairs."] = "{area:35}: {npc:2494} на причалах, {npc:2486} у таверны, {npc:2498} внутри, Маккинли, {npc:737} и {npc:773} наверху.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, внутри",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, наверху",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}, later in this guide"] = "{npc:773}, наверху: для задания «{quest:2864}» ({area:976}), позже в этом гайде",

	-- Step 17: Unfinished Wild Shore errands
	-- {area:43} Wild Shore
	["Unfinished {area:43} errands"] = "",
	["If the town rewards just brought you to 42 and you still owe pirate work, use the shore tents, not the ships."] = "",

	-- Step 21: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Распорядитель полетов: {area:35}",

	-- Step 22: Grom'gol Base Camp
	-- {object:3202} Grom'gol · {npc:2519} Kin'weelay · {npc:2465} Far Seer Mok'thardin
	["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then the zeppelin tower."] = "Полет заканчивается здесь: {object:3202}. Сначала {npc:2519} и {npc:2465}, затем башня дирижаблей.",

	-- Step 24: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",

	-- Step 25: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 27: Riding at 40
	["Riding at 40"] = "Верховая езда на 40-м уровне",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Верховая езда требует 40-го уровня и стоит 100 золотых; при обучении вы получаете транспорт. {npc:4752} обучает орков, ориентир: {object:172958}, у псарни ({npc:3362}). Небеснорожденные учатся у NPC {npc:265756} ({area:17684}, {area:16638}, остров Зефрис), вместе с буреногом: небесный корабль на остров отходит с утесов к югу от места {area:17045}, к северу от города {zone:1456}, примерно каждые пять минут. Другой транспорт вашей расы стоит по 20 золотых: в разделе «Коллекции», «Транспорт · 40-й уровень» есть гайд для каждого.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, учитель верховой езды",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Волки: {npc:3362}, рядом: {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "Верховая езда и буреступы: {npc:265756}, ориентир: {area:17684} ({area:16638}), остров Зефрис.",

	-- Step 29: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, учитель верховой езды",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Ящеры: Зьольнир, рядом с персонажем {npc:7953} ({area:367}).",

	-- Step 30: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Летите сюда: {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 32: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins)."] = "Ваш учитель – в городе {zone:1456}: {npc:3033} (друиды), ориентир: {area:1639}; {npc:246344} (паладины).",

	-- Step 34: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "Верховая езда требует 40-го уровня и стоит 100 золотых; при обучении вы получаете ездовое животное. Каждая раса учится у своего учителя: ваш – {npc:3690} ({area:222}), рядом кодо ({npc:3685}, по 20 золотых). Потом поднимитесь обратно к распорядителю полетов города {zone:1456}.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, учитель верховой езды",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Кодо: {npc:3685}, рядом с персонажем {npc:3690} ({area:222}).",

	-- Step 35: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Летите сюда: {area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Распорядитель полетов: {zone:1456}",

	-- Step 36: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Летите сюда: {area:976}",

	-- Step 39: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392} – для коня Скверны",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to {area:392}; {npc:6251} stands on the hill above the docks."] = "",

	-- Step 40: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Распорядитель полетов: {area:392}",

	-- Step 46: Gadgetzan
	-- {area:976} Gadgetzan · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["Flown in: {area:976}'s quests first, by the flight master, then the {area:2240} is a short ride north over the {zone:1446} border."] = "Прилетели: сначала задания ({area:976}) у распорядителя полетов, затем {area:2240} – недалеко на север через границу зоны {zone:1446}.",

	-- Step 47: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7804} Trenton Lighthammer · {quest:3042} Troll Temper
	["For your {area:978} run, in the next guide: {quest:2864} wants scarab shells, and {npc:7804}, a short walk from the flight master, {quest:3042} from the Sandfury trolls."] = "Для подземелья {area:978}, в следующем гайде: {quest:2864} просит панцири скарабеев, а {npc:7804}, недалеко от распорядителя полетов, – {quest:3042} с троллей из племени Песчаной Бури.",

	-- Step 48: Mirage Raceway
	-- {area:976} Gadgetzan · {zone:1446} Tanaris · {area:484} Freewind Post · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["Flown in to {area:976}: the raceway is a short ride north over the {zone:1446} border.\nThe road from {area:484} to {zone:1446} runs past the {area:2240} on the {area:439}: {npc:4454} is in the gnomes' camp beside the track, {npc:4630} and {npc:4709} by the goblins' camp. {npc:4630} first, then {npc:4709}, who runs off to keep Rizzle busy; then take Rizzle's plans from the gnomes' camp and bring them back to {npc:4630}."] = "",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "",

	-- Step 49: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "В место {area:976}",

	-- Step 50: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} – обнесенный стеной гоблинский город сразу за границей края {zone:1446}.",

	-- Step 52: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "{area:1937}: убивайте их по пути",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Бандиты и воры стоят лагерем в дюнах к востоку от места {area:976}. С любого Скитальца Пустыни может упасть бурдюк с водой: Люглункету нужно пять.\nОсторожно: разбойники Скитальцев Пустыни (43-44-й уровень) передвигаются в незаметности, так что могут подойти незамеченными.",

	-- Step 54: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Езжайте на северо-восток к гоблинской гавани на побережье.",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "{npc:7882}, внутри",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "{npc:7881}, внутри",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "{npc:8579}: крикуны живут здесь: {zone:1444}, при следующем визите в {zone:1444}",
	-- {npc:260405} Wharfmaster Steamfizzle · {zone:2548} Riverglades
	["{npc:260405}, on the pier: Friz's errand from the {zone:2548}, if you carry it"] = "{npc:260405}, на пирсе: поручение Фриза из зоны {zone:2548}, если оно у вас есть",

	-- Step 55: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "{area:1336}: убивайте их по пути",
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "Дальше на юг вдоль берега бухту занимают пираты Южных морей. {npc:7883} и украденный груз – на причале в дальнем конце. Шляпа может упасть с любого пирата, чаще всего с похитителей.\nОсторожно: рядом с NPC {npc:7883} (45) стоят два-три пирата, а как только начнется бой, в него вступят многие пираты из городка: сначала выманите его охрану.",
	["Upstairs"] = "Наверху",

	-- Step 56: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "{area:985}: убивайте их по пути",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "",

	-- Step 57: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what {area:1336} gave you. {area:976} is west of it."] = "",
	-- {area:35} Booty Bay
	["for {area:35}, around level 51 (40-50/06)"] = "для места {area:35}, примерно на 51-м уровне (40-50/06)",

	-- Step 59: Fly to Freewind Post
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Распорядитель полетов: {area:976}",

	-- Step 61: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "{npc:7777} ходит по месту {area:1099}: ищите внутри круга на карте",
	-- {npc:8115} Witch Doctor Uzer'i · {npc:263190} Tan'jani · {zone:2548} Riverglades
	["{npc:8115}: {npc:263190}'s errand from the {zone:2548}, if you carry it"] = "{npc:8115}: поручение от NPC {npc:263190} из зоны {zone:2548}, если оно у вас есть",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: для города {zone:1454}, примерно на 45-м уровне",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, внутри",

	-- Step 62: Gordunni Outpost
	-- {npc:222233} Ohk'zi
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "К северу от гноллов огры занимают заставу на холме; выманивайте огров-магов к себе. Кобальт – в кучах земли вокруг заставы, а свиток лежит на земле внутри.\nОсторожно: на заставе стоит {npc:222233} (43-й уровень, элитный): выманивайте огров к себе, подальше от него.",

	-- Step 63: Woodpaw north camp
	["Woodpaw north camp"] = "Северный лагерь Древолапов",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "Гноллы из стаи Древолапов стоят лагерем на холмах чуть к северо-западу от Лагеря Мохаче; грива может упасть с любого.\nОсторожно: все гноллы Древолапов, кроме вожаков, при 15% здоровья убегают за подмогой, что может привлечь в бой других гноллов.",

	-- Step 64: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}: в течение часа",

	-- Step 65: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "{zone:1444}: убивайте их по пути",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "Летучие хамелеоны порхают над рощей чуть к западу от Лагеря Мохаче; крыло падает почти с каждого. Вожаки стаи Древолапов возглавляют лагеря к юго-западу: убейте их в течение часа.\nОсторожно: большинство вожаков сидят в небольших лагерях с палатками вместе с 2-4 другими гноллами, которые вступают в бой, а между лагерями патрулируют другие гноллы.",

	-- Step 67: Grimtotem camp
	["Grimtotem camp"] = "Лагерь Зловещего Тотема",
	-- {npc:222286} Namida Grimtotem
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns.\nCareful: {npc:222286} (level 43, elite) stands in the camp: pull the raiders and shamans away from her."] = "Таурены племени Зловещего Тотема стоят лагерем у рощи хамелеонов; рога есть у налетчиков, натуралистов и шаманов.\nОсторожно: в лагере стоит {npc:222286} (43-й уровень, элитная): выманивайте налетчиков и шаманов подальше от нее.",

	-- Step 68: Woodpaw battle map
	["Woodpaw battle map"] = "Тактическая карта Древолапов",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "Тактическая карта лежит в лагере Древолапов к югу от Лагеря Мохаче.",

	-- Step 69: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "для города {zone:1454}, примерно на 45-м уровне",

	-- Step 70: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber.\nCareful: {quest:7731} is level 47: clear the hive around him and pull him alone at full health."] = "Улей Цуккаш врыт в холмы к юго-востоку от лагеря; {quest:7731} ждет в самой дальней камере.\nОсторожно: {quest:7731} – 47-го уровня: зачистите улей вокруг него и выманивайте его в одиночку с полным здоровьем.",

	-- Step 71: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "{area:2522}: убивайте их по пути",
	-- {area:1105} Feral Scar Vale
	["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb.\nCareful: the Mage-Lords (45-46) and the Shamans cast from range and the ruins are packed: pull one at a time from the edge."] = "Езжайте на запад от улья к руинам огров ниже места {area:1105}. Там шаманы, чернокнижники и изверги; сфера – у магов-лордов в южной части.\nОсторожно: маги-лорды (45-46) и шаманы атакуют издалека, а в руинах тесно: выманивайте по одному с края.",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "{npc:5234} ходит по месту {area:2522}: ищите внутри круга на карте",

	-- Step 72: Feral Scar Vale yetis
	-- {area:1105} Feral Scar Vale
	["{area:1105} yetis"] = "Йети: {area:1105}",
	-- {area:1105} Feral Scar Vale · {npc:5346} Bloodroar the Stalker
	["North-west of the ruins, pull one yeti at a time at the eastern mouth of {area:1105} for thick hides. Careful: larger yetis crowd the cave further west, and {npc:5346}, a level 48 rare, lurks at the far end."] = "",

	-- Step 73: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "Только с аварийным маяком: он может упасть с любого зверя, гнолла или огра в краю {zone:1444}, примерно один раз из ста; используйте его, чтобы начать задание. Робот сидит в небольшой пещере в северной части места {area:1105}, чуть к северо-западу от руин. Сопроводите его к причалу в месте {area:1108}; по пути нападут йети и гориллы. Награда ждет здесь: {area:35} – заберете позже.\nОсторожно: во время сопровождения будет три засады, и робот предупреждает перед каждой. Первая – 3 йети, сразу после того, как робот выйдет из пещеры и поднимется к дороге. Вторая – 3 гориллы, на тропе вдоль утеса. Третья – около 4 гноллов, один из них заклинатель, там, где маршрут сворачивает к причалу.",

	-- Step 74: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "йети Яростного Шрама – при следующем посещении края {zone:1444}",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "{npc:7875}: для персонажа {npc:7010} ({zone:1454})",
	-- {zone:1454} Orgrimmar · {zone:2652} Shen'dralas
	["for {zone:1454}, after {zone:2652}"] = "для города {zone:1454}, после зоны {zone:2652}",
	-- {zone:2652} Shen'dralas · {area:1099} Camp Mojache · {zone:1443} Desolace · {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {npc:7311} Uthel'nay
	["{zone:2652} is next, a ride north from {area:1099} into {zone:1443}: keep your {zone:1454} hand-ins (Neeru, Zilzibin, {npc:4485}, {npc:7311}) for the flight there after it."] = "Следующая зона – {zone:2652}, на север от места {area:1099} в край {zone:1443}: сдачу заданий в городе {zone:1454} (Нееру, Зилзибин, {npc:4485}, {npc:7311}) оставьте на полет туда после нее.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into town. The ships' captains, Seahorn's next request, are for your Stranglethorn stop at about 50."] = "Возвращайтесь в город. Капитаны кораблей, следующая просьба Морского Рога, – для визита в Тернистую долину примерно на 50-м уровне.",
	-- ["Eastern Wastewander camps"] = "Восточные лагеря Скитальцев Пустыни",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Летите сюда: {area:1637}. Лавка братьев Дрофферсов – на Волоке.",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Летите сюда: {area:484}, спуститесь на подъемнике к востоку от лагеря, пересеките солончаки и езжайте на юг в край {zone:1446}.",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Летите сюда: {area:484}, затем езжайте на запад через каньоны мимо места {area:2237}; дорога поднимается в джунгли ({zone:1444}) и ведет сюда: {area:1099}.",
	-- ["Fly to {area:75}"] = "Летите сюда: {area:75}",
	-- ["Fly to {zone:1454}. From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "Летите в {zone:1454}. От распорядителя полетов: {object:172960}, затем Волок, затем {object:172958}.",
	-- ["Hearth to {area:1099}"] = "Камень возвращения: {area:1099}",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Езжайте дальше на запад к побережью. С береговых глубинников и клешнехватов на пляжах примерно один раз из сорока падает аварийный маяк OOX-22/FE: если выпадет, используйте его, чтобы начать задание.",
	-- ["North-west of the ruins, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "К северо-западу от руин, в месте {area:1105}, логово йети; толстая шкура может упасть с любого йети там.",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Только с аварийным маяком: робот сидит в небольшой пещере в северной части места {area:1105}. Сопроводите его к причалу в месте {area:1108}; по пути нападут йети и гориллы. Награда ждет здесь: {area:35} – заберете позже.",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Возвращайтесь на северо-запад от места {area:1978} сюда: {area:75} и летите сюда: {object:3202}.",
	-- ["Ride back west to {area:976}."] = "Возвращайтесь на запад сюда: {area:976}.",
	-- ["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Езжайте на юго-запад к руинам огров ниже места {area:1105}. Там шаманы, чернокнижники и изверги; сфера – у магов-лордов в южной части.",
	-- ["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Езжайте на запад от улья к руинам огров ниже места {area:1105}. Там шаманы, чернокнижники и изверги; сфера – у магов-лордов в южной части.",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Езжайте на запад в центр края {zone:1444}. Убейте монстра {npc:5308}, примените на тело предмет {item:10699} и убейте поднявшийся дух.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Верховая езда требует 40-го уровня и стоит 100 золотых; при обучении вы получаете ездовое животное. В Classic каждая раса учится у своего учителя: ваш – {npc:4773} ({area:159}), рядом кони-скелеты ({npc:4731}, по 20 золотых). В Forever, возможно, любая раса может учиться у любого учителя (не подтверждено): сначала попробуйте персонажа {npc:4752} ({zone:1454}, {object:172958}) – он ближе всех, и пропустите этот шаг, если он вас обучит.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Верховая езда требует 40-го уровня и стоит 100 золотых; при обучении вы получаете ездовое животное. В Classic каждая раса учится у своего учителя: ваш – {npc:7953} ({area:367}, побережье края {zone:1411}), рядом ящеры Зьольнира (по 20 золотых). В Forever, возможно, любая раса может учиться у любого учителя (не подтверждено): сначала попробуйте персонажа {npc:4752} ({zone:1454}, {object:172958}) – он ближе всех, и пропустите этот шаг, если он вас обучит.",
	-- ["Rogue Vale screechers"] = "Крикуны Разбойничьей долины",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Кони-скелеты: {npc:4731}, рядом с персонажем {npc:4773} ({area:159}).",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "Дальше на юг вдоль берега бухту занимают пираты Южных морей. {npc:7883} и украденный груз – на причале в дальнем конце. Шляпа может упасть с любого пирата, чаще всего с похитителей.\nОсторожно: рядом с NPC {npc:7883} стоят два-три пирата, а как только начнется бой, к нему присоединятся многие пираты из городка.",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "К югу от Пиратской бухты висельники из шайки Кровавого Паруса стоят лагерем здесь: {area:43}; карты и приказы лежат в их палатках и в шлюпке рядом с большим лагерем. Нюхательный табак и глаз {npc:2493} может нести любой пират Кровавого Паруса: убивайте, пока не получите оба.",
	-- ["Southern Gordunni ruins"] = "Южные руины Гордунни",
	-- ["Southern Wastewander camps"] = "Южные лагеря Скитальцев Пустыни",
	-- ["Sprite darters and Woodpaw alphas"] = "Летучие хамелеоны и вожаки Древолапов",
	-- ["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "Улей Цуккаш врыт в холмы к юго-востоку от лагеря; {quest:7731} ждет в самой дальней камере.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Бандиты и воры стоят лагерем в дюнах к востоку от места {area:976}. С любого Скитальца Пустыни может упасть бурдюк с водой: сохраните десять, по пять для каждой награды Тормозиллера.\nОсторожно: разбойники Скитальцев Пустыни (43-44-й уровень) передвигаются в незаметности, так что могут подойти незамеченными.",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Темные маги, разбойники и убийцы стоят лагерем к юго-востоку от места {area:976}.",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "Дирижабль ({object:3202}) отправляется с башни чуть к северо-востоку от главных ворот ({zone:1454}).",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "Дирижабль ({zone:1454}) отправляется с башни у лагеря {object:3202}; он причаливает у главных ворот ({zone:1454}).",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Тиста, распорядитель полетов, стоит чуть к востоку от башни дирижаблей. Летите сюда: {area:75} – там начинается следующее руководство.",
	-- ["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them. Then follow the coast south to {area:35}."] = "На запад к побережью: наги-исследователи бродят по мелководью, у них связки тростника; {object:759} бьет в холмах чуть к востоку от них. Затем идите вдоль побережья на юг в {area:35}.",
	-- ["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "Ваш учитель – в городе {area:1638}: {npc:3033} (друиды), ориентир: {area:1639}; {npc:246344} (паладины). Летите туда из города {zone:1454}, затем дальше сюда: {area:484}.",
	-- ["Zeppelin to {object:3202}"] = "Дирижабль: {object:3202}",
	-- ["Zeppelin tower"] = "Башня дирижаблей",
	-- ["for the {zone:1425}, around level 48"] = "для края {zone:1425}, примерно на 48-м уровне",
	-- ["for {area:35}, around level 50"] = "для места {area:35}, примерно на 50-м уровне",
	-- ["the {object:150075} in the square"] = "{object:150075} на площади",
	-- ["water pouches in your bags"] = "бурдюки с водой в сумках",
	-- ["{area:1099} flight master"] = "Распорядитель полетов: {area:1099}",
	-- ["{area:976} is the walled goblin town just past the {area:440} border."] = "{area:976} – обнесенный стеной гоблинский город сразу за границей края {area:440}.",
	-- ["{npc:4630}: the {item:5852} from {npc:2496}, if you carry them"] = "{npc:4630}: {item:5852} от персонажа {npc:2496}, если они у вас есть",
	-- ["{npc:4706}, beside {npc:4630}"] = "{npc:4706}, рядом: {npc:4630}",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}, учитель верховой езды",
	-- ["{npc:6986}, the Drag"] = "{npc:6986}, Волок",
	-- ["{npc:7010}, the Drag"] = "{npc:7010}, Волок",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}, учитель верховой езды",
}
