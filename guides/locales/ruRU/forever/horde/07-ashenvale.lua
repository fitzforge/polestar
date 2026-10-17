-- Russian (ruRU): the guide forever/horde/07-ashenvale (forever/horde/07-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zoram'gar Outpost
	-- {area:392} Ratchet · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale
	["Fly from {area:392} to {area:2897} on the {zone:1440} coast."] = "Летите из поселения {area:392}: {area:2897} на побережье зоны {zone:1440}.",
	-- {npc:12717} Muglash
	["{npc:12717}: starts his escort at once"] = "{npc:12717}: сопровождение начинается сразу",

	-- Step 2: Vorsha the Lasher
	-- {npc:12717} Muglash
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead."] = "{npc:12717} идет на север по берегу к жаровне наг. Потушите жаровню, затем охраняйте его от волн наг, пока Ворша не погибнет.",
	["Naga brazier"] = "Жаровня наг",

	-- Step 3: Blackfathom Deeps ruins
	-- {area:2797} Blackfathom Deeps
	["{area:2797} ruins"] = "Руины: {area:2797}",
	["The way to the Sapphires is through the sunken ruins at the north end of the strand: go down the stairs into the pit."] = "Путь к сапфирам – через затонувшие руины в северном конце берега: спуститесь по лестнице в яму.",

	-- Step 4: Sapphires of Aku'Mai
	["Sapphires of Aku'Mai"] = "Сапфиры Аку'май",
	-- {area:2797} Blackfathom Deeps
	["The Sapphires are blue crystals on the walls of the tunnels leading to the {area:2797} portal, underground and outside the instance: swim down from the pit, under the wall, into the cave. The satyrs and naga in the tunnels are elite: grouping up is advised. The crystals respawn quickly, so there is no need to go deep."] = "Сапфиры – синие кристаллы на стенах туннелей, ведущих к порталу ({area:2797}), под землей и вне подземелья: нырните из ямы под стену в пещеру. Сатиры и наги в туннелях – элита: лучше собрать группу. Кристаллы быстро появляются снова, так что глубоко идти не нужно.",

	-- Step 5: Zoram'gar Outpost
	-- {npc:12736} Je'neu Sancrea · {area:2797} Blackfathom Deeps
	["{npc:12736} offers a {area:2797} quest next; leave it unless you have a group."] = "Затем {npc:12736} предложит задание ({area:2797}); не берите без группы.",

	-- Step 6: Thistlefur Village
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold."] = "К востоку от форта Зорам'гар фурболги из племени Колючего Меха заполняют деревню и холмы вокруг своего логова.",

	-- Step 7: Thistlefur Hold
	["Thistlefur Hold"] = "Логово Колючего Меха",
	-- {npc:12818} Ruul Snowhoof · {area:428} Night Run
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}."] = "Внутри логова вдоль туннелей стоят тролльские сундуки ({object:178144}). {npc:12818} заточен в глубине: освободите его и защищайте до выхода, затем он убежит домой: {area:428}.",

	-- Step 8: Zoram'gar Outpost
	["Back west to Zoram'gar before heading east for good."] = "Вернитесь на запад в форт Зорам'гар, прежде чем окончательно уйти на восток.",

	-- Step 9: Ursangous
	-- {area:415} Astranaar · {npc:12678} Ursangous · {area:418} Ruins of Stardust · {area:421} Mystral Lake
	["Follow the main road east past {area:415} (Alliance: keep to the road). {npc:12678}, a big grizzly, roams the {area:418} south of the road, west of {area:421}. His paw starts the next hunt quest."] = "Идите по главной дороге на восток мимо места {area:415} (Альянс: держитесь дороги). {npc:12678}, большой медведь-гризли, бродит здесь: {area:418} – к югу от дороги, к западу от места {area:421}. Его лапа начинает следующее охотничье задание.",

	-- Step 10: Ruins of Stardust fountain
	-- {area:418} Ruins of Stardust
	["{area:418} fountain"] = "Фонтан: {area:418}",
	-- {area:418} Ruins of Stardust · {item:7767} Empty Blue Waterskin
	["The fountain stands in the middle of the {area:418}: use the {item:7767} there."] = "Фонтан стоит посреди места {area:418}: используйте там {item:7767}.",

	-- Step 11: Alonso
	-- {npc:210995} Alonso · {area:421} Mystral Lake
	["{npc:210995}, a Forever addition, stands on the west shore of {area:421} with three quick Dragonslayer quests."] = "{npc:210995}, добавленный в Forever, стоит на западном берегу ({area:421}) с тремя быстрыми заданиями драконоборцев.",

	-- Step 12: Tideress
	-- {npc:12759} Tideress · {area:421} Mystral Lake · {item:16408} Befouled Water Globe
	["{npc:12759}, a corrupted water elemental, drifts in {area:421}. Her {item:16408} starts a quest for Splintertree."] = "{npc:12759}, оскверненная водная элементаль, плавает здесь: {area:421}. Ее {item:16408} начинает задание для заставы Расщепленного Дерева.",

	-- Step 13: King of the Foulweald
	-- {area:421} Mystral Lake · {item:16972} Karang's Banner · {object:178206} Foulweald Totem Mound (no name in this language: may be words) · {npc:12918} Chief Murgut
	["The Foulweald furbolgs hold the woods east of {area:421}, south of the road. Place {item:16972} on the {object:178206} and guard it: the furbolgs come to tear it down. {npc:12918} comes last; his totem drops in the basket."] = "Фурболги из племени Гиблой Чащи занимают лес к востоку от места {area:421}, к югу от дороги. Установите {item:16972} на {object:178206} и охраняйте: фурболги придут его сломать. {npc:12918} придет последним; его тотем падает в корзину.",

	-- Step 14: Torek's Assault
	-- {npc:12858} Torek · {area:2360} Silverwing Outpost · {npc:12860} Duriel Moonfire
	["Keep east on the road. {npc:12858} waits south-west of the Warsong lumber camp. He and his grunts storm the {area:2360}: let them take aggro and stay with {npc:12858} until {npc:12860} is dead."] = "Продолжайте идти по дороге на восток. {npc:12858} ждет к юго-западу от Лесозаготовок Песни Войны. Он со своими бойцами штурмует {area:2360}: дайте им принять удар на себя и держитесь рядом с NPC {npc:12858}, пока {npc:12860} не погибнет.",

	-- Step 15: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867} стоит на лесозаготовках. Бегуны ночных эльфов рыщут в лесу к юго-востоку; они скрываются, так что смотрите в оба.",

	-- Step 16: Splintertree Post
	-- {area:431} Splintertree Post · {area:428} Night Run
	["North up the road to {area:431} and {area:428} beside it."] = "На север по дороге: {area:431} – и {area:428} рядом.",
	-- {npc:12718} Gurda Ragescar
	["{npc:12718}: only if you carry the manual pages"] = "{npc:12718}: только если у вас есть страницы руководства",

	-- Step 17: Sharptalon
	-- {npc:12676} Sharptalon
	["{npc:12676}, a big nightsaber, prowls the woods south-east of the Warsong lumber camp. Her claw starts the next hunt quest."] = "{npc:12676}, большая ночная саблезубая кошка, рыщет в лесу к юго-востоку от Лесозаготовок Песни Войны. Ее коготь начинает следующее охотничье задание.",

	-- Step 18: Felmusk satyrs
	["Felmusk satyrs"] = "Сатиры из племени Мускуса Скверны",
	["North-west of Splintertree, the Felmusk satyrs camp in the woods. Every satyr can drop horns."] = "К северо-западу от заставы Расщепленного Дерева в лесу стоит лагерь сатиров из племени Мускуса Скверны. Рога могут упасть с любого сатира.",

	-- Step 19: Shadumbra
	-- {npc:12677} Shadumbra · {area:426} Raynewood Retreat
	["{npc:12677}, a shadow panther, stalks the woods around {area:426}, west of the Felmusk camp. Her head starts the next hunt quest."] = "{npc:12677}, теневая пантера, рыщет в лесу вокруг места {area:426}, к западу от лагеря сатиров. Ее голова начинает следующее охотничье задание.",

	-- Step 20: Mystral Lake
	-- {area:421} Mystral Lake
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["Back south-west to {area:421}. Befouled Water Elementals drift around its shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "Назад на юго-запад: {area:421}. Злобные элементали воды ({npc:3917}) плавают у берегов; беседка стоит на острове, напротив заставы Альянса.",
	["Gazebo"] = "Беседка",

	-- Step 23: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:222} Bloodhoof Village · {npc:2995} Tal
	["Fly to {area:1638} if you know the flight path. If not, fly to {area:378}, ride west into {zone:1412} past {area:222} to {area:1638} and take its flight path from {npc:2995} on the central rise."] = "Летите в {area:1638}, если знаете маршрут. Если нет, летите в {area:378}, езжайте на запад: {zone:1412}, мимо места {area:222}, до {area:1638} – и откройте там маршрут у NPC {npc:2995} на центральном холме.",
	-- {npc:3057} Cairne Bloodhoof · {area:1638} Thunder Bluff · {quest:93739} Exploring the Horde
	["Speak with {npc:3057}, in {area:1638}: {quest:93739}"] = "Поговорите с NPC {npc:3057} ({area:1638}): {quest:93739}",

	-- Step 24: The Earthen Ring
	["The Earthen Ring"] = "Служители Земли",
	-- {zone:1456} Thunder Bluff · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem · {npc:259118} Muln Earthfury
	["Take a lift down from {zone:1456}. The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}."] = "Спуститесь на подъемнике: {zone:1456}. Лагерь Служителей Земли – к северу от утесов: {npc:264074}, {npc:264072} и {npc:259118}.",

	-- Step 25: Gloomrise
	-- {area:17044} Gloomrise · {npc:264074} Mazu'kon · {item:273015} Toxin Extractor · {item:273181} Crystalline Silk · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["North of the camp, spiders overrun the burial ground at {area:17044}. Use {npc:264074}'s {item:273015} on the Gnawed Corpses; the Spinners drop the {item:273181}. {npc:264082} sits at the north end: her {item:273658} starts {quest:96294}."] = "К северу от лагеря пауки заполонили кладбище – {area:17044}. Используйте {item:273015} ({npc:264074}) на обглоданных трупах ({npc:264096}); с прядильщиц падает {item:273181}. {npc:264082} сидит в северном конце: ее {item:273658} начинает задание {quest:96294}.",
	-- plural, as words: Gloomrise Toxin Samples = {item:273001} Gloomrise Toxin Sample · Gnawed Corpses = {npc:264096} Gnawed Corpse
	["Gloomrise Toxin Samples, from the Gnawed Corpses"] = "{item:273001}, с обглоданных трупов ({npc:264096})",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}, с прядильщиц ({npc:264081})",
	-- {item:273658} Bloody Parchment · {npc:264082} Broodmother Valraxx
	["{item:273658}, from {npc:264082}"] = "{item:273658}, с NPC {npc:264082}",

	-- Step 26: The Earthen Ring
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo
	["Back south to the camp, then up into {zone:1456} for the flight to {area:378}."] = "Назад на юг к лагерю, затем наверх: {zone:1456} – для полета в {area:378}.",

	-- Step 27: Brine
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {npc:5899} Brine · {area:1718} Great Lift
	["Fly from {zone:1456} to {area:378}. {npc:5899}'s hut stands on the ridge above the quilboar watering hole south of the camp, on the road to the {area:1718}."] = "Летите из места {zone:1456}: {area:378}. Хижина: {npc:5899} – на гребне над водопоем свинобразов к югу от лагеря, на дороге к месту {area:1718}.",
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["for {npc:5901}, south of {area:392}: next guide"] = "для NPC {npc:5901}, к югу от поселения {area:392}: следующий гайд",

	-- Step 28: Great Lift
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {area:1718} Great Lift · {zone:1413} Barrens
	["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {zone:1413}."] = "Летите из места {zone:1456}: {area:378} – и идите по дороге на юг: {area:1718}, в самом низу зоны {zone:1413}.",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}, наверху у подъемника",

	-- Step 29: Freewind Post
	-- {area:484} Freewind Post
	["Ride the lift down, then follow the road east through the canyons to {area:484}, a Tauren village on top of the mesas. Its lift is on the north side."] = "Спуститесь на подъемнике, затем идите по дороге на восток через каньоны: {area:484}, деревня тауренов на вершинах столовых гор. Ее подъемник – на северной стороне.",
	-- {npc:10377} Elu
	["{npc:10377}, by the wind rider master"] = "{npc:10377}, у распорядителя полетов",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}, the trade supplies vendor: the Screeching harpies of {area:487}"] = "{npc:4877}, торговец товарами: визгливые гарпии ({area:487})",
	-- {npc:10537} Cliffwatcher Longhorn
	["The Wanted poster beside {npc:10537}"] = "Плакат «Разыскивается» рядом с {npc:10537} утесов",

	-- Step 30: Alien Egg
	["Take the lift down. The egg lies in a nest on the canyon floor in one of three spots: south-east of the mesas (52.3,55.2), east (56.4,50.4) or south-west (37.6,56.1)."] = "Спуститесь на подъемнике. Яйцо лежит в гнезде на дне каньона в одном из трех мест: к юго-востоку от столовых гор (52.3,55.2), к востоку (56.4,50.4) или к юго-западу (37.6,56.1).",

	-- Step 32: Galak centaurs
	["Galak centaurs"] = "Кентавры из племени Галак",
	-- {npc:10617} Galak Messenger · {area:2237} Whitereach Post
	["The Galak camps fill the canyon north of Freewind; Scouts, Wranglers and Windchasers share every camp. A lone {npc:10617} walks between the camps: kill him when you meet him, his note starts a quest for {area:2237}."] = "Лагеря Галак заполняют каньон к северу от заставы Вольного Ветра; разведчики, пастухи и ветроловки есть в каждом лагере. Между лагерями ходит одинокий {npc:10617}: убейте его при встрече, его записка начинает задание для места {area:2237}.",

	-- Step 33: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {quest:1149} Test of Faith
	["{npc:2986} stands on a mesa top east of the Galak camps. For the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "{npc:2986} стоит на вершине столовой горы к востоку от лагерей Галак. Для задания {quest:1149} сойдите с края досок рядом с ним: вы приземлитесь невредимым.",

	-- Step 35: Grimtotem camps
	["Grimtotem camps"] = "Лагеря Зловещего Тотема",
	-- {area:2097} Darkcloud Pinnacle
	-- plural, as words: Document Chests = {object:176344} Document Chest
	["West of Freewind, the Grimtotem camps below {area:2097}. The Secret Notes are in Document Chests at the south-east, south-west and north-west camps."] = "К западу от заставы Вольного Ветра, под местом {area:2097}, – лагеря Зловещего Тотема. Тайные записки лежат в сундучках для бумаг ({object:176344}) в юго-восточном, юго-западном и северо-западном лагерях.",
	-- {object:176344} Document Chest
	["{object:176344}, south-east camp"] = "{object:176344}, юго-восточный лагерь",
	-- {object:176344} Document Chest
	["{object:176344}, south-west camp"] = "{object:176344}, юго-западный лагерь",
	-- {object:176344} Document Chest
	["{object:176344}, north-west camp"] = "{object:176344}, северо-западный лагерь",

	-- Step 36: Lakota Windsong
	-- {area:2097} Darkcloud Pinnacle · {npc:10646} Lakota Windsong · {npc:10896} Arnak Grimtotem
	["Climb the path to the top of {area:2097}. {npc:10646} is held captive beside {npc:10896} (29): clear the guards and {npc:10896} first, then free her and protect her on the walk down; Grimtotem ambushers come at you on the way."] = "Поднимитесь по тропе на вершину: {area:2097}. {npc:10646} в плену рядом с NPC {npc:10896} (29): сначала уберите стражу и {npc:10896}, затем освободите ее и защищайте на спуске; по пути нападут засадники Зловещего Тотема.",

	-- Step 37: Whitereach Post
	-- {area:2237} Whitereach Post
	["Follow the canyon west to {area:2237}."] = "Идите по каньону на запад: {area:2237}.",
	-- {npc:10428} Motega Firemane · {zone:1456} Thunder Bluff
	["{npc:10428}'s next quest, Sacred Fire, ends in {zone:1456}, off this route. Skip it."] = "Следующее задание {npc:10428}, «Священное пламя», заканчивается в {zone:1456}, вне маршрута. Пропустите его.",
	-- {npc:10720} Galak Assassin · {npc:10638} Kanati Greycloud
	["Kill the {npc:10720} that comes for {npc:10638}"] = "Убейте NPC {npc:10720}, который придет за {npc:10638}",

	-- Step 38: Highperch
	-- {area:482} Highperch · {npc:10427} Pao'ka Swiftmountain · {area:2237} Whitereach Post
	["West of Whitereach the wyverns nest on the {area:482} cliffs; the eggs lie in the nests. {npc:10427} waits on the east side of the nesting grounds: free him and keep him alive on the walk back to {area:2237}."] = "К западу от заставы Белого Плеса виверны гнездятся на утесах ({area:482}); яйца лежат в гнездах. {npc:10427} ждет на восточной стороне гнездовий: освободите его и сохраните ему жизнь на пути обратно в {area:2237}.",

	-- Step 40: Roguefeather Den
	-- {area:487} Roguefeather Den · {npc:4490} Grenka Bloodscreech · {npc:4877} Jandia
	["South of Darkcloud, the harpies of {area:487}. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her. The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s."] = "К югу от Пика Темного Облака – гарпии: {area:487}. {npc:4490} (31) ходит среди них: проредите гарпий вокруг нее, прежде чем тянуть ее. Визгливые гарпии, бродяжницы и призывательницы ветров там – для NPC {npc:4877}.",

	-- Step 43: Rok'Alim the Pounder
	-- {npc:4499} Rok'Alim the Pounder · {area:482} Highperch
	["{npc:4499}, a hard-hitting rock elemental, walks the cliffs of {area:482}. {npc:4499} is elite: grouping up is advised."] = "{npc:4499}, сильно бьющий каменный элементаль, ходит по утесам: {area:482}. {npc:4499} – элита: лучше собрать группу.",

	-- Step 44: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyon east out of the mesas onto the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Идите по каньону на восток из столовых гор на соляные равнины. Гоблины и гномы – {area:2240} – нейтральны и дают задания обеим фракциям.",
	["His crate is for Stranglethorn, later on the route"] = "Его ящик – для Тернистой долины, позже по маршруту",

	-- Step 45: The salt flats
	["The salt flats"] = "Соляные равнины",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{object:19868} lies all over the flats north of the raceway. Scorpid Reavers and Sparkleshell Tortoises roam the north half, Salt Flats Scavengers circle overhead, and Saltstone Basilisks graze west of the track. The Crystalhides roam the middle of the flats and the Gazers (34-35, five levels above you: one at a time) the far south."] = "{object:19868} лежат по всей равнине к северу от трассы. Скорпиды-разорители ({npc:4140}) и блестопанцирные черепахи ({npc:4142}) бродят в северной половине, солончаковые падальщики ({npc:4154}) кружат над головой, а просоленные василиски ({npc:4147}) пасутся к западу от трассы. Просоленные хрусталиски бродят посреди равнины, а просоленные взорни (34-35, на пять уровней выше вас: по одному) – на крайнем юге.",

	-- Step 46: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, around level 38"] = "{npc:4454}: его письмо – Мартеку ({zone:1418}), около 38-го уровня",

	-- Step 47: Freewind Post
	-- {zone:1454} Orgrimmar
	["The next guide flies on from here to {zone:1454}."] = "Отсюда следующий гайд летит в {zone:1454}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Shadumbra"] = "Тенумбра",
	-- ["Sharptalon"] = "Острокоготь",
	-- ["The {area:1718}"] = "{area:1718}",
	-- ["Tideress"] = "Приливница",
	-- ["Ursangous"] = "Топтыжень",
}
