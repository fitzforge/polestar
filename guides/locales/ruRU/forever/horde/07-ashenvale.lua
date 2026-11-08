-- Russian (ruRU): the guide forever/horde/07-ashenvale (forever/horde/07-ashenvale.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Zoram'gar Outpost
	["Fly to Zoram'gar Outpost"] = "",
	["Ratchet flight master"] = "",

	-- Step 2: Zoram'gar Outpost
	["Zoram'gar Outpost"] = "",
	-- {npc:12736} Je'neu Sancrea
	["{npc:12736} stands in the outpost."] = "",

	-- Step 3: Blackfathom Deeps ruins
	["Blackfathom Deeps ruins"] = "",
	["The way to the Sapphires is through the sunken ruins at the north end of the strand: go down the stairs into the pit."] = "Путь к сапфирам – через затонувшие руины в северном конце берега: спуститесь по лестнице в яму.",

	-- Step 4: Sapphires of Aku'Mai
	["Sapphires of Aku'Mai"] = "Сапфиры Аку'май",
	["The Sapphires are blue crystals on the walls of the tunnels leading to the Blackfathom Deeps portal, underground and outside the instance: swim down from the pit, under the wall, into the cave. The satyrs and naga in the tunnels are elite: grouping up is advised. The crystals respawn quickly, so there is no need to go deep."] = "",

	-- Step 5: Zoram'gar Outpost
	["Back to Zoram'gar from the ruins before heading east for good."] = "",
	-- {npc:12736} Je'neu Sancrea
	["{npc:12736} offers a Blackfathom Deeps quest next; leave it unless you have a group."] = "",

	-- Step 6: Ruins of Stardust fountain
	["Ruins of Stardust fountain"] = "",
	-- {npc:12678} Ursangous · {item:7767} Empty Blue Waterskin
	["The fountain stands in the middle of the Ruins of Stardust, where {npc:12678} roams: use the {item:7767} there."] = "",

	-- Step 7: Ursangous
	-- {npc:12678} Ursangous
	["Follow the main road east past Astranaar (Alliance: keep to the road). {npc:12678}, a big grizzly, roams the Ruins of Stardust south of the road, west of Mystral Lake. His paw starts the next hunt quest."] = "",

	-- Step 8: Alonso
	-- {npc:210995} Alonso
	["{npc:210995}, a Forever addition, stands on the west shore of Mystral Lake with three quick Dragonslayer quests."] = "",
	-- {npc:210995} Alonso
	["{npc:210995} may not offer these to every class; if he doesn't, carry on.; walks around The Talondeep Path: the map marks where to look"] = "",

	-- Step 9: Tideress
	-- {npc:12759} Tideress · {item:16408} Befouled Water Globe
	["{npc:12759}, a corrupted water elemental, drifts in Mystral Lake. Her {item:16408} starts a quest for Splintertree."] = "",

	-- Step 10: King of the Foulweald
	-- {item:16972} Karang's Banner · {object:178206} Foulweald Totem Mound (no name in this language: may be words) · {npc:12918} Chief Murgut
	["The Foulweald furbolgs hold the woods east of Mystral Lake, south of the road. Place {item:16972} on the {object:178206} and guard it: the furbolgs come to tear it down. {npc:12918} comes last; his totem drops in the basket."] = "",

	-- Step 11: Torek's Assault
	-- {npc:12858} Torek · {npc:12860} Duriel Moonfire
	["Keep east on the road. {npc:12858} waits south-west of the Warsong lumber camp. He and his grunts storm the Silverwing Outpost: let them take aggro and stay with {npc:12858} until {npc:12860} is dead."] = "",

	-- Step 12: Sharptalon
	-- {npc:12676} Sharptalon
	["{npc:12676}, a big nightsaber, prowls the woods south-east of the Warsong lumber camp, on the way north to Splintertree. Her claw starts the next hunt quest."] = "",

	-- Step 13: Splintertree Post
	["Splintertree Post"] = "",

	-- Step 16: Splintertree Post
	-- {npc:12196} Innkeeper Kaylisk
	["{npc:12196}, beside her"] = "{npc:12196}, рядом с ней",
	-- {npc:12718} Gurda Ragescar
	["{npc:12718}: only if you carry the manual pages"] = "{npc:12718}: только если у вас есть страницы руководства",

	-- Step 17: Felmusk satyrs
	["Felmusk satyrs"] = "Сатиры из племени Мускуса Скверны",
	["North-west of Splintertree, the Felmusk satyrs camp in the woods. Every satyr can drop horns."] = "К северо-западу от заставы Расщепленного Дерева в лесу стоит лагерь сатиров из племени Мускуса Скверны. Рога могут упасть с любого сатира.",

	-- Step 18: Shadumbra
	-- {npc:12677} Shadumbra
	["{npc:12677}, a shadow panther, stalks the woods around Raynewood Retreat, west of the Felmusk camp. Her head starts the next hunt quest."] = "",

	-- Step 22: Fly to Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Fly to {zone:1456}"] = "",
	["Zoram'gar Outpost flight master"] = "",

	-- Step 23: Fly to Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:246344} Alodan the Hopeful
	["Paladins know {zone:1456}'s flight path from {npc:246344}'s training."] = "",

	-- Step 24: Fly to Camp Taurajo
	["Fly to Camp Taurajo"] = "",

	-- Step 27: The Earthen Ring
	["The Earthen Ring"] = "Служители Земли",
	-- {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem · {npc:259118} Muln Earthfury · {zone:1456} Thunder Bluff
	["The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}. From {zone:1456}, take a lift down; coming on foot from Camp Taurajo, keep north past the bluffs."] = "",
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother
	["{npc:259118}: {quest:96261} comes once this is handed in"] = "{npc:259118}: {quest:96261} – после сдачи этого задания",

	-- Step 28: Gloomrise: kill these as you meet them
	["Gloomrise: kill these as you meet them"] = "",
	-- {npc:264074} Mazu'kon · {item:273015} Toxin Extractor · {item:273181} Crystalline Silk · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["North of the camp, spiders overrun the burial ground at Gloomrise. Use {npc:264074}'s {item:273015} on the Gnawed Corpses; the Spinners drop the {item:273181}. {npc:264082} sits at the north end: her {item:273658} starts {quest:96294}."] = "",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}, с прядильщиц ({npc:264081})",
	-- plural, as words: Gloomrise Toxin Samples = {item:273001} Gloomrise Toxin Sample · Gnawed Corpses = {npc:264096} Gnawed Corpse
	["Gloomrise Toxin Samples, from the Gnawed Corpses"] = "{item:273001}, с обглоданных трупов ({npc:264096})",

	-- Step 29: The Earthen Ring
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother · {quest:96259} Defending the Dead
	["{npc:259118} offers {quest:96261} only once {quest:96259} is handed in."] = "{npc:259118} предложит {quest:96261} только после сдачи задания {quest:96259}.",

	-- Step 31: Broodmother Valraxx
	-- {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	["{npc:264082} sits at the north end of Gloomrise; her {item:273658} starts {quest:96294}. {npc:264082} is elite: grouping up is advised."] = "",

	-- Step 32: Gloomrise
	["Gloomrise"] = "",
	-- {item:273658} Bloody Parchment · {npc:264082} Broodmother Valraxx
	["{item:273658}, from {npc:264082}"] = "{item:273658}, с NPC {npc:264082}",

	-- Step 33: The Earthen Ring
	-- {zone:1456} Thunder Bluff
	["Back south to the camp, then up into {zone:1456} for the flight to Camp Taurajo."] = "",

	-- Step 34: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 36: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {zone:1412} Mulgore · {object:2968} Bloodhoof Village (no name in this language: may be words) · {npc:2995} Tal
	["Fly to {zone:1456} if you know the flight path. If not, fly to Camp Taurajo, head west into {zone:1412} past {object:2968} to {zone:1456} and take its flight path from {npc:2995} on the central rise."] = "",
	-- {npc:3057} Cairne Bloodhoof · {zone:1456} Thunder Bluff · {quest:93739} Exploring the Horde
	["Speak with {npc:3057}, in {zone:1456}: {quest:93739}"] = "",
	-- {npc:3057} Cairne Bloodhoof
	["Talk to {npc:3057}"] = "",

	-- Step 37: Ansekhwa
	-- {npc:11869} Ansekhwa
	["While you're here: learn Two-Handed Maces from {npc:11869} (10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 38: Fly to Camp Taurajo
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 39: Brine
	-- {npc:5899} Brine · {object:19844} Great Lift
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole south of Camp Taurajo, on the road to the {object:19844}."] = "",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, south of Ratchet: next guide"] = "",

	-- Step 42: Freewind Post
	-- {object:19840} Freewind Post (no name in this language: may be words)
	["Ride the lift down, then follow the road east through the canyons to {object:19840}, a Tauren village on top of the mesas. Its lift is on the north side."] = "",
	-- {npc:10377} Elu
	["{npc:10377}, by the wind rider master"] = "{npc:10377}, у распорядителя полетов",
	-- {npc:10537} Cliffwatcher Longhorn
	["The Wanted poster beside {npc:10537}"] = "Плакат «Разыскивается» рядом с {npc:10537} утесов",
	-- {npc:4877} Jandia
	["{npc:4877}, the trade supplies vendor: the Screeching harpies of Roguefeather Den; inside the inn"] = "",
	-- {npc:4877} Jandia
	["{npc:4877}: her stolen supplies lie in the same harpy den"] = "",
	-- {npc:11116} Innkeeper Abeqwa · {npc:4877} Jandia
	["{npc:11116}, beside {npc:4877}"] = "{npc:11116}, рядом с NPC {npc:4877}",

	-- Step 43: Alien Egg
	["Take the lift down. The egg lies in a nest on the canyon floor in one of three spots: south-east of the mesas (52.3,55.2), east (56.4,50.4) or south-west (37.6,56.1)."] = "Спуститесь на подъемнике. Яйцо лежит в гнезде на дне каньона в одном из трех мест: к юго-востоку от столовых гор (52.3,55.2), к востоку (56.4,50.4) или к юго-западу (37.6,56.1).",

	-- Step 44: Galak centaurs
	["Galak centaurs"] = "Кентавры из племени Галак",
	-- {npc:10617} Galak Messenger
	["The Galak camps fill the canyon north of Freewind; Scouts, Wranglers and Windchasers share every camp. A lone {npc:10617} walks between the camps: kill him when you meet him, his note starts a quest for Whitereach Post."] = "",

	-- Step 45: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {quest:1149} Test of Faith
	["{npc:2986} stands on a mesa top east of the Galak camps. For the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "{npc:2986} стоит на вершине столовой горы к востоку от лагерей Галак. Для задания {quest:1149} сойдите с края досок рядом с ним: вы приземлитесь невредимым.",
	-- {npc:2986} Dorn Plainstalker
	["{npc:2986}, below ground"] = "",

	-- Step 48: Darkcloud Pinnacle
	["Darkcloud Pinnacle"] = "",
	-- plural, as words: Document Chests = {object:176344} Document Chest
	["West of Freewind, the Grimtotem camps below Darkcloud Pinnacle. The Secret Notes are in Document Chests at the south-east, south-west and north-west camps."] = "",
	-- {object:176344} Document Chest
	["{object:176344}, north-west camp"] = "{object:176344}, северо-западный лагерь",
	-- {object:176344} Document Chest
	["{object:176344}, south-west camp"] = "{object:176344}, юго-западный лагерь",
	-- {object:176344} Document Chest
	["{object:176344}, south-east camp"] = "{object:176344}, юго-восточный лагерь",

	-- Step 49: Level 28.9
	["Level 28.9"] = "",
	-- {npc:10646} Lakota Windsong
	["Short of 28.9? The Grimtotem around these camps (27-29) are the right level: kill a few more before the climb to {npc:10646}. Past it, this step skips itself. Or, with a group, run the Blackfathom Deeps dungeon or the Razorfen Kraul dungeon instead."] = "",
	["Grimtotem camps below Darkcloud Pinnacle"] = "",
	["grind on the Grimtotem below Darkcloud Pinnacle"] = "",

	-- Step 50: Lakota Windsong
	-- {npc:10646} Lakota Windsong · {npc:10896} Arnak Grimtotem
	["Climb the path to the top of Darkcloud Pinnacle. {npc:10646} is held captive beside {npc:10896} (29): clear the guards and {npc:10896} first, then free her and protect her on the walk down; Grimtotem ambushers come at you on the way."] = "",

	-- Step 51: Highperch
	["Highperch"] = "",
	-- {npc:10427} Pao'ka Swiftmountain
	["West of Whitereach the wyverns nest on the Highperch cliffs; the eggs lie in the nests. {npc:10427} waits on the east side of the nesting grounds: free him and keep him alive on the walk back to Whitereach Post.\nCareful: Wyverns at level 28-29 fly overhead and can be pulled without warning. A group of three wyverns can ambush you once you pass the first pillar at the bottom."] = "",

	-- Step 52: Whitereach Post
	["Whitereach Post"] = "",
	-- {npc:10428} Motega Firemane · {zone:1456} Thunder Bluff
	["{npc:10428}'s next quest, Sacred Fire, ends in {zone:1456}, off this route. Skip it."] = "Следующее задание {npc:10428}, «Священное пламя», заканчивается в {zone:1456}, вне маршрута. Пропустите его.",

	-- Step 54: Hypercapacitor Gizmo
	-- {npc:10992} Enraged Panther
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:10992} is a level 30 elite: most classes solo it at level 32, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 55: Whitereach Post
	-- {npc:10720} Galak Assassin · {npc:10638} Kanati Greycloud
	["Kill the {npc:10720} that comes for {npc:10638}"] = "Убейте NPC {npc:10720}, который придет за {npc:10638}",

	-- Step 58: Level 29.49
	["Level 29.49"] = "",
	-- {quest:5151} Hypercapacitor Gizmo
	["If you skipped {quest:5151} and are still short of 29.49, kill harpies here first: Roguefeather Den is your next stop anyway. Past it, this step skips itself. Or, with a group, run the Blackfathom Deeps dungeon or the Scarlet Monastery dungeon (Graveyard) instead."] = "",
	-- {npc:4101} Screeching Roguefeather
	["grind on {npc:4101}"] = "",

	-- Step 59: The Screeching Canyon: kill these as you meet them
	["The Screeching Canyon: kill these as you meet them"] = "",
	-- {npc:4490} Grenka Bloodscreech · {npc:4877} Jandia · {quest:98069} Stolen Freewind Supplies
	["South of Darkcloud, the harpies of Roguefeather Den. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her. The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s; her {quest:98069} lie on the ground along the foot of the cliff and in the cave up on top."] = "",
	-- {quest:98069} Stolen Freewind Supplies
	["{quest:98069}, on the ground around the den"] = "",

	-- Step 60: Freewind Post
	-- {object:19840} Freewind Post (no name in this language: may be words) · {npc:2986} Dorn Plainstalker
	["Back east to {object:19840}: it lies on the way from Roguefeather Den to {npc:2986}'s mesa."] = "",
	-- {npc:10645} Thalia Amberhide
	["{npc:10645}, inside"] = "",
	-- {npc:4877} Jandia
	["{npc:4877}, inside"] = "",

	-- Step 61: Test of Endurance
	-- {npc:2986} Dorn Plainstalker
	["{npc:2986}'s mesa is north-east of Freewind."] = "",
	-- {npc:2986} Dorn Plainstalker · {quest:1151} Test of Strength · {quest:1150} Test of Endurance
	["{npc:2986} offers {quest:1151} once {quest:1150} is in"] = "",

	-- Step 62: Rok'Alim the Pounder
	-- {npc:4499} Rok'Alim the Pounder
	["{npc:4499}, a hard-hitting rock elemental, walks the cliffs of Highperch, back west past Whitereach Post. {npc:4499} is elite: grouping up is advised."] = "",

	-- Step 63: Freewind Post
	-- {object:19840} Freewind Post (no name in this language: may be words) · {object:151976} Shimmering Flats (no name in this language: may be words)
	["Back to {object:19840}. The Mirage Raceway's quests come with the next visit to the {object:151976}, at 33."] = "",
	-- {zone:1454} Orgrimmar
	["The next guide flies on from here to the Crossroads and {zone:1454}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back east to {area:484}: it lies on the way from {area:487} to {npc:2986}'s mesa."] = "Назад на восток: {area:484} – по пути от места {area:487} к плато NPC {npc:2986}.",
	-- ["Back south to the camp, then up into {zone:1456} for the flight to {area:378}."] = "Назад на юг к лагерю, затем наверх: {zone:1456} – для полета в {area:378}.",
	-- ["Back south-west to {area:421}. Befouled Water Elementals drift around its shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "Назад на юго-запад: {area:421}. Злобные элементали воды ({npc:3917}) плавают у берегов; беседка стоит на острове, напротив заставы Альянса.",
	-- ["Back west to Zoram'gar before heading east for good."] = "Вернитесь на запад в форт Зорам'гар, прежде чем окончательно уйти на восток.",
	-- ["Climb the path to the top of {area:2097}. {npc:10646} is held captive beside {npc:10896} (29): clear the guards and {npc:10896} first, then free her and protect her on the walk down; Grimtotem ambushers come at you on the way."] = "Поднимитесь по тропе на вершину: {area:2097}. {npc:10646} в плену рядом с NPC {npc:10896} (29): сначала уберите стражу и {npc:10896}, затем освободите ее и защищайте на спуске; по пути нападут засадники Зловещего Тотема.",
	-- ["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold."] = "К востоку от форта Зорам'гар фурболги из племени Колючего Меха заполняют деревню и холмы вокруг своего логова.",
	-- ["Fly from {area:392} to {area:2897} on the {zone:1440} coast."] = "Летите из поселения {area:392}: {area:2897} на побережье зоны {zone:1440}.",
	-- ["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {zone:1413}."] = "Летите из места {zone:1456}: {area:378} – и идите по дороге на юг: {area:1718}, в самом низу зоны {zone:1413}.",
	-- ["Fly from {zone:1456} to {area:378}. {npc:5899}'s hut stands on the ridge above the quilboar watering hole south of the camp, on the road to the {area:1718}."] = "Летите из места {zone:1456}: {area:378}. Хижина: {npc:5899} – на гребне над водопоем свинобразов к югу от лагеря, на дороге к месту {area:1718}.",
	-- ["Fly to {area:1638} if you know the flight path. If not, fly to {area:378}, ride west into {zone:1412} past {area:222} to {area:1638} and take its flight path from {npc:2995} on the central rise."] = "Летите в {area:1638}, если знаете маршрут. Если нет, летите в {area:378}, езжайте на запад: {zone:1412}, мимо места {area:222}, до {area:1638} – и откройте там маршрут у NPC {npc:2995} на центральном холме.",
	-- ["Follow the canyon east out of the mesas onto the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Идите по каньону на восток из столовых гор на соляные равнины. Гоблины и гномы – {area:2240} – нейтральны и дают задания обеим фракциям.",
	-- ["Follow the canyon west to {area:2237}."] = "Идите по каньону на запад: {area:2237}.",
	-- ["Follow the main road east past {area:415} (Alliance: keep to the road). {npc:12678}, a big grizzly, roams the {area:418} south of the road, west of {area:421}. His paw starts the next hunt quest."] = "Идите по главной дороге на восток мимо места {area:415} (Альянс: держитесь дороги). {npc:12678}, большой медведь-гризли, бродит здесь: {area:418} – к югу от дороги, к западу от места {area:421}. Его лапа начинает следующее охотничье задание.",
	-- ["Gazebo"] = "Беседка",
	-- ["Grimtotem camps"] = "Лагеря Зловещего Тотема",
	-- ["His crate is for Stranglethorn, later on the route"] = "Его ящик – для Тернистой долины, позже по маршруту",
	-- ["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}."] = "Внутри логова вдоль туннелей стоят тролльские сундуки ({object:178144}). {npc:12818} заточен в глубине: освободите его и защищайте до выхода, затем он убежит домой: {area:428}.",
	-- ["Keep east on the road. {npc:12858} waits south-west of the Warsong lumber camp. He and his grunts storm the {area:2360}: let them take aggro and stay with {npc:12858} until {npc:12860} is dead."] = "Продолжайте идти по дороге на восток. {npc:12858} ждет к юго-западу от Лесозаготовок Песни Войны. Он со своими бойцами штурмует {area:2360}: дайте им принять удар на себя и держитесь рядом с NPC {npc:12858}, пока {npc:12860} не погибнет.",
	-- ["Naga brazier"] = "Жаровня наг",
	-- ["North of the camp, spiders overrun the burial ground at {area:17044}. Use {npc:264074}'s {item:273015} on the Gnawed Corpses; the Spinners drop the {item:273181}. {npc:264082} sits at the north end: her {item:273658} starts {quest:96294}."] = "К северу от лагеря пауки заполонили кладбище – {area:17044}. Используйте {item:273015} ({npc:264074}) на обглоданных трупах ({npc:264096}); с прядильщиц падает {item:273181}. {npc:264082} сидит в северном конце: ее {item:273658} начинает задание {quest:96294}.",
	-- ["North up the road to {area:431} and {area:428} beside it."] = "На север по дороге: {area:431} – и {area:428} рядом.",
	-- ["Ride the lift down, then follow the road east through the canyons to {area:484}, a Tauren village on top of the mesas. Its lift is on the north side."] = "Спуститесь на подъемнике, затем идите по дороге на восток через каньоны: {area:484}, деревня тауренов на вершинах столовых гор. Ее подъемник – на северной стороне.",
	-- ["Shadumbra"] = "Тенумбра",
	-- ["Sharptalon"] = "Острокоготь",
	-- ["South of Darkcloud, the harpies of {area:487}. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her. The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s."] = "К югу от Пика Темного Облака – гарпии: {area:487}. {npc:4490} (31) ходит среди них: проредите гарпий вокруг нее, прежде чем тянуть ее. Визгливые гарпии, бродяжницы и призывательницы ветров там – для NPC {npc:4877}.",
	-- ["Speak with {npc:3057}, in {area:1638}: {quest:93739}"] = "Поговорите с NPC {npc:3057} ({area:1638}): {quest:93739}",
	-- ["Take a lift down from {zone:1456}. The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}."] = "Спуститесь на подъемнике: {zone:1456}. Лагерь Служителей Земли – к северу от утесов: {npc:264074}, {npc:264072} и {npc:259118}.",
	-- ["The Foulweald furbolgs hold the woods east of {area:421}, south of the road. Place {item:16972} on the {object:178206} and guard it: the furbolgs come to tear it down. {npc:12918} comes last; his totem drops in the basket."] = "Фурболги из племени Гиблой Чащи занимают лес к востоку от места {area:421}, к югу от дороги. Установите {item:16972} на {object:178206} и охраняйте: фурболги придут его сломать. {npc:12918} придет последним; его тотем падает в корзину.",
	-- ["The Galak camps fill the canyon north of Freewind; Scouts, Wranglers and Windchasers share every camp. A lone {npc:10617} walks between the camps: kill him when you meet him, his note starts a quest for {area:2237}."] = "Лагеря Галак заполняют каньон к северу от заставы Вольного Ветра; разведчики, пастухи и ветроловки есть в каждом лагере. Между лагерями ходит одинокий {npc:10617}: убейте его при встрече, его записка начинает задание для места {area:2237}.",
	-- ["The Sapphires are blue crystals on the walls of the tunnels leading to the {area:2797} portal, underground and outside the instance: swim down from the pit, under the wall, into the cave. The satyrs and naga in the tunnels are elite: grouping up is advised. The crystals respawn quickly, so there is no need to go deep."] = "Сапфиры – синие кристаллы на стенах туннелей, ведущих к порталу ({area:2797}), под землей и вне подземелья: нырните из ямы под стену в пещеру. Сатиры и наги в туннелях – элита: лучше собрать группу. Кристаллы быстро появляются снова, так что глубоко идти не нужно.",
	-- ["The fountain stands in the middle of the {area:418}, where {npc:12678} roams: use the {item:7767} there."] = "Фонтан стоит посреди места {area:418}, где бродит {npc:12678}: используйте там {item:7767}.",
	-- ["The fountain stands in the middle of the {area:418}: use the {item:7767} there."] = "Фонтан стоит посреди места {area:418}: используйте там {item:7767}.",
	-- ["The next guide flies on from here to {zone:1454}."] = "Отсюда следующий гайд летит в {zone:1454}.",
	-- ["The salt flats"] = "Соляные равнины",
	-- ["The {area:1718}"] = "{area:1718}",
	-- ["Thistlefur Hold"] = "Логово Колючего Меха",
	-- ["Tideress"] = "Приливница",
	-- ["Ursangous"] = "Топтыжень",
	-- ["West of Freewind, the Grimtotem camps below {area:2097}. The Secret Notes are in Document Chests at the south-east, south-west and north-west camps."] = "К западу от заставы Вольного Ветра, под местом {area:2097}, – лагеря Зловещего Тотема. Тайные записки лежат в сундучках для бумаг ({object:176344}) в юго-восточном, юго-западном и северо-западном лагерях.",
	-- ["West of Whitereach the wyverns nest on the {area:482} cliffs; the eggs lie in the nests. {npc:10427} waits on the east side of the nesting grounds: free him and keep him alive on the walk back to {area:2237}."] = "К западу от заставы Белого Плеса виверны гнездятся на утесах ({area:482}); яйца лежат в гнездах. {npc:10427} ждет на восточной стороне гнездовий: освободите его и сохраните ему жизнь на пути обратно в {area:2237}.",
	-- ["While you're at the lake: Befouled Water Elementals drift around its shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "Пока вы у озера: злобные элементали воды плавают у берегов; беседка стоит на острове, напротив заставы Альянса.",
	-- ["for {npc:5901}, south of {area:392}: next guide"] = "для NPC {npc:5901}, к югу от поселения {area:392}: следующий гайд",
	-- ["{area:2797} ruins"] = "Руины: {area:2797}",
	-- ["{area:418} fountain"] = "Фонтан: {area:418}",
	-- ["{npc:10079}, at the top of the lift"] = "{npc:10079}, наверху у подъемника",
	-- ["{npc:12676}, a big nightsaber, prowls the woods south-east of the Warsong lumber camp. Her claw starts the next hunt quest."] = "{npc:12676}, большая ночная саблезубая кошка, рыщет в лесу к юго-востоку от Лесозаготовок Песни Войны. Ее коготь начинает следующее охотничье задание.",
	-- ["{npc:12677}, a shadow panther, stalks the woods around {area:426}, west of the Felmusk camp. Her head starts the next hunt quest."] = "{npc:12677}, теневая пантера, рыщет в лесу вокруг места {area:426}, к западу от лагеря сатиров. Ее голова начинает следующее охотничье задание.",
	-- ["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead."] = "{npc:12717} идет на север по берегу к жаровне наг. Потушите жаровню, затем охраняйте его от волн наг, пока Ворша не погибнет.",
	-- ["{npc:12717}: starts his escort at once"] = "{npc:12717}: сопровождение начинается сразу",
	-- ["{npc:12736} offers a {area:2797} quest next; leave it unless you have a group."] = "Затем {npc:12736} предложит задание ({area:2797}); не берите без группы.",
	-- ["{npc:12759}, a corrupted water elemental, drifts in {area:421}. Her {item:16408} starts a quest for Splintertree."] = "{npc:12759}, оскверненная водная элементаль, плавает здесь: {area:421}. Ее {item:16408} начинает задание для заставы Расщепленного Дерева.",
	-- ["{npc:12837}, inside the inn"] = "{npc:12837}, в таверне",
	-- ["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867} стоит на лесозаготовках. Бегуны ночных эльфов рыщут в лесу к юго-востоку; они скрываются, так что смотрите в оба.",
	-- ["{npc:210995}, a Forever addition, stands on the west shore of {area:421} with three quick Dragonslayer quests."] = "{npc:210995}, добавленный в Forever, стоит на западном берегу ({area:421}) с тремя быстрыми заданиями драконоборцев.",
	-- ["{npc:264082} sits at the north end of {area:17044}; her {item:273658} starts {quest:96294}."] = "{npc:264082} сидит в северном конце места {area:17044}; ее {item:273658} начинает задание {quest:96294}.",
	-- ["{npc:2986}'s mesa is north-east of Freewind; from him, head south-east out to the {area:439}."] = "Плато NPC {npc:2986} – к северо-востоку от Привольного; от него идите на юго-восток: {area:439}.",
	-- ["{npc:4454}: his letter goes to Martek in the {zone:1418}, around level 38"] = "{npc:4454}: его письмо – Мартеку ({zone:1418}), около 38-го уровня",
	-- ["{npc:4499}, a hard-hitting rock elemental, walks the cliffs of {area:482}. {npc:4499} is elite: grouping up is advised."] = "{npc:4499}, сильно бьющий каменный элементаль, ходит по утесам: {area:482}. {npc:4499} – элита: лучше собрать группу.",
	-- ["{npc:4877}, the trade supplies vendor: the Screeching harpies of {area:487}"] = "{npc:4877}, торговец товарами: визгливые гарпии ({area:487})",
	-- ["{npc:4877}, the trade supplies vendor: the Screeching harpies of {area:487}; inside the inn"] = "{npc:4877}, торговец товарами: визгливые гарпии ({area:487}); в таверне",
	-- ["{npc:5899}'s hut stands on the ridge above the quilboar watering hole south of {area:378}, on the road to the {area:485}."] = "Хижина: {npc:5899} – на гребне над водопоем свинобразов к югу от места {area:378}, на дороге к месту {area:485}.",
	-- ["{object:19868} lies all over the flats north of the raceway. Scorpid Reavers and Sparkleshell Tortoises roam the north half, Salt Flats Scavengers circle overhead, and Saltstone Basilisks graze west of the track. The Crystalhides roam the middle of the flats and the Gazers (34-35, five levels above you: one at a time) the far south."] = "{object:19868} лежат по всей равнине к северу от трассы. Скорпиды-разорители ({npc:4140}) и блестопанцирные черепахи ({npc:4142}) бродят в северной половине, солончаковые падальщики ({npc:4154}) кружат над головой, а просоленные василиски ({npc:4147}) пасутся к западу от трассы. Просоленные хрусталиски бродят посреди равнины, а просоленные взорни (34-35, на пять уровней выше вас: по одному) – на крайнем юге.",
}
