-- Russian (ruRU): the guide forever/horde/07-ashenvale (forever/horde/07-ashenvale.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Zoram'gar Outpost
	-- {area:2897} Zoram'gar Outpost
	["Fly to {area:2897}"] = "",
	-- {area:2897} Zoram'gar Outpost · {area:431} Splintertree Post
	["East along the road from Seereth's camp to the Crossroads' wind rider master, and fly to {area:2897}. Keep your hearthstone: {area:431}'s bind later in this guide saves more."] = "На восток по дороге от лагеря Сирета к распорядителю полетов на Перекрестке, затем летите сюда: {area:2897}. Сохраните камень возвращения: привязка к месту {area:431} позже в этом гайде сэкономит больше.",
	["Crossroads flight master"] = "",

	-- Step 2: Zoram'gar Outpost
	-- {npc:12736} Je'neu Sancrea
	["{npc:12736} stands in the outpost."] = "",

	-- Step 3: Je'neu Sancrea
	-- {area:2797} Blackfathom Deeps · {npc:12736} Je'neu Sancrea
	["For your {area:2797} run, in the same tunnels as the Sapphires: {npc:12736}'s ruins errand. Look for a group now if you have none yet."] = "Для подземелья {area:2797}, в тех же туннелях, что и сапфиры: поручение NPC {npc:12736} в руинах. Поищите группу сейчас, если у вас ее еще нет.",

	-- Step 4: Blackfathom Deeps ruins
	-- {area:2797} Blackfathom Deeps
	["{area:2797} ruins"] = "Руины: {area:2797}",
	["The way to the Sapphires is through the sunken ruins at the north end of the strand: go down the stairs into the pit."] = "Путь к сапфирам – через затонувшие руины в северном конце берега: спуститесь по лестнице в яму.",

	-- Step 5: Sapphires of Aku'Mai
	["Sapphires of Aku'Mai"] = "Сапфиры Аку'май",
	-- {area:2797} Blackfathom Deeps
	["The Sapphires are blue crystals on the walls of the tunnels leading to the {area:2797} portal, underground and outside the instance: swim down from the pit, under the wall, into the cave. The satyrs and naga in the tunnels are elite: grouping up is advised. The crystals respawn quickly, so there is no need to go deep."] = "Сапфиры – синие кристаллы на стенах туннелей, ведущих к порталу ({area:2797}), под землей и вне подземелья: нырните из ямы под стену в пещеру. Сатиры и наги в туннелях – элита: лучше собрать группу. Кристаллы быстро появляются снова, так что глубоко идти не нужно.",

	-- Step 6: Blackfathom Deeps
	-- {area:2797} Blackfathom Deeps · {object:177964} Fathom Stone · {item:16762} Fathom Core · {quest:6922} Baron Aquanis · {item:16782} Strange Water Globe · {npc:12736} Je'neu Sancrea · {item:16790} Damp Note · {npc:4787} Argent Guard Thaelrid · {npc:4832} Twilight Lord Kelris · {npc:9087} Bashana Runetotem · {zone:1456} Thunder Bluff · {area:1639} Elder Rise
	["{area:2797} is a dungeon for a group of five, about levels 22 to 30, and a full run takes about an hour. Its portal is a little further along the tunnels you are in, past the Sapphires.\nInside: the {object:177964} lies under the water of the Moonshrine Ruins' pool, beneath the walkway (clear the crabs first): open it for the {item:16762}, and {quest:6922} comes; open the {item:16782} he drops for a quest for {npc:12736}. The Tide Priestesses sometimes drop a {item:16790}: open it for another quest for {npc:12736}. {npc:4787}, by a campfire in an underwater side room off Ghamoo-ra's room, offers Blackfathom Villainy ({npc:4832}' head, for {npc:9087} on {zone:1456}'s {area:1639})."] = "{area:2797} – подземелье для группы из пяти игроков, примерно 22-30-й уровень; полное прохождение занимает около часа. Его портал – чуть дальше по туннелям, где вы находитесь, за сапфирами.\nВнутри: {object:177964} лежит под водой в бассейне руин Лунного святилища, под мостками (сначала перебейте крабов): откройте его ради предмета {item:16762}, и появится {quest:6922}; откройте выпавший из него предмет {item:16782}, чтобы получить задание для NPC {npc:12736}. С жриц прилива иногда падает {item:16790}: откройте его, чтобы получить еще одно задание для NPC {npc:12736}. {npc:4787}, у костра в подводной боковой комнате рядом с залом Гамо-ры, дает задание «Blackfathom Villainy» (голова NPC {npc:4832} для NPC {npc:9087}, {area:1639}, {zone:1456}).",
	-- {quest:6921} Amongst the Ruins · {item:16762} Fathom Core · {object:177964} Fathom Stone
	["{quest:6921}: the {item:16762}, from the {object:177964}"] = "{quest:6921}: {item:16762} ({object:177964})",

	-- Step 7: Zoram'gar Outpost
	["Back to Zoram'gar from the ruins before heading east for good."] = "Вернитесь от руин в форт Зорам'гар, прежде чем окончательно уйти на восток.",
	-- {npc:12736} Je'neu Sancrea · {area:2797} Blackfathom Deeps
	["{npc:12736} offers a {area:2797} quest next; leave it unless you have a group."] = "Затем {npc:12736} предложит задание ({area:2797}); не берите без группы.",
	-- {npc:12757} Karang Amakkar · {area:421} Mystral Lake · {npc:12918} Chief Murgut
	["{npc:12757}: a banner defence in the Foulweald, east of {area:421}: furbolg waves, then {npc:12918}"] = "{npc:12757}: оборона знамени в Гиблой Чаще, к востоку от места {area:421}: волны фурболгов, затем {npc:12918}",

	-- Step 10: Je'neu Sancrea
	-- {npc:12736} Je'neu Sancrea · {quest:6564} Allegiance to the Old Gods
	["{npc:12736} then offers the next part, {quest:6564}: it is for a second run, so leave it."] = "Затем {npc:12736} предлагает следующую часть, {quest:6564}: она для второго похода, так что не берите ее.",

	-- Step 11: Ruins of Stardust fountain
	-- {area:418} Ruins of Stardust
	["{area:418} fountain"] = "Фонтан: {area:418}",
	-- {area:418} Ruins of Stardust · {npc:12678} Ursangous · {item:7767} Empty Blue Waterskin
	["The fountain stands in the middle of the {area:418}, where {npc:12678} roams: use the {item:7767} there."] = "Фонтан стоит посреди места {area:418}, где бродит {npc:12678}: используйте там {item:7767}.",

	-- Step 12: Ursangous
	-- {area:415} Astranaar · {npc:12678} Ursangous · {area:418} Ruins of Stardust · {area:421} Mystral Lake
	["Follow the main road east past {area:415} (Alliance: keep to the road). {npc:12678}, a big grizzly, roams the {area:418} south of the road, west of {area:421}. His paw starts the next hunt quest."] = "Идите по главной дороге на восток мимо места {area:415} (Альянс: держитесь дороги). {npc:12678}, большой медведь-гризли, бродит здесь: {area:418} – к югу от дороги, к западу от места {area:421}. Его лапа начинает следующее охотничье задание.",

	-- Step 13: King of the Foulweald
	-- {area:421} Mystral Lake · {item:16972} Karang's Banner · {object:178206} Foulweald Totem Mound (no name in this language: may be words) · {npc:12918} Chief Murgut
	["The Foulweald furbolgs hold the woods east of {area:421}, south of the road. Place {item:16972} on the {object:178206} and guard it: the furbolgs come to tear it down. {npc:12918} comes last; his totem drops in the basket."] = "Фурболги из племени Гиблой Чащи занимают лес к востоку от места {area:421}, к югу от дороги. Установите {item:16972} на {object:178206} и охраняйте: фурболги придут его сломать. {npc:12918} придет последним; его тотем падает в корзину.",

	-- Step 14: Torek's Assault
	-- {npc:12858} Torek · {area:2360} Silverwing Outpost · {npc:12860} Duriel Moonfire
	["Keep east on the road. {npc:12858} waits south-west of the Warsong lumber camp. He and his grunts storm the {area:2360}: let them take aggro and stay with {npc:12858} until {npc:12860} is dead."] = "Продолжайте идти по дороге на восток. {npc:12858} ждет к юго-западу от Лесозаготовок Песни Войны. Он со своими бойцами штурмует {area:2360}: дайте им принять удар на себя и держитесь рядом с NPC {npc:12858}, пока {npc:12860} не погибнет.",

	-- Step 15: Warsong lumber camp
	["Warsong lumber camp"] = "Лесозаготовки Песни Войны",
	-- {area:2360} Silverwing Outpost · {npc:12867} Kuray'bin
	["From the {area:2360} head north-east to the Warsong lumber camp on the road: {npc:12867} stands there."] = "От места {area:2360} идите на северо-восток к Лесозаготовкам Песни Войны у дороги: там стоит {npc:12867}.",

	-- Step 16: Ashenvale Outrunners
	-- {quest:6503} Ashenvale Outrunners
	["The night elf {quest:6503} (23-24) stalk the woods south and south-east of the lumber camp; they stealth, so watch for them."] = "Ночные эльфы из задания {quest:6503} (23-24) рыщут в лесах к югу и юго-востоку от лагеря лесорубов; они скрываются, так что смотрите в оба.",

	-- Step 17: Warsong lumber camp
	-- {npc:12867} Kuray'bin
	["Back to {npc:12867} at the lumber camp, on the road north to Splintertree."] = "Назад к NPC {npc:12867} в лагерь лесорубов, на дороге на север к Заставе Расщепленного Дерева.",

	-- Step 19: Senani Thunderheart
	-- {npc:12696} Senani Thunderheart · {area:428} Night Run · {quest:6383} The Ashenvale Hunt · {npc:12678} Ursangous · {npc:12676} Sharptalon · {npc:12677} Shadumbra
	["{npc:12696} keeps the hunt board at {area:428}, by the flight master: take {quest:6383} and hand it straight back. {npc:12678}, {npc:12676} and {npc:12677} drop their trophies only after it."] = "{npc:12696} ведет доску охоты здесь: {area:428}, у распорядителя полетов. Возьмите задание {quest:6383} и сразу сдайте его. {npc:12678}, {npc:12676} и {npc:12677} роняют свои трофеи только после этого.",

	-- Step 21: Splintertree Post
	-- {npc:12196} Innkeeper Kaylisk
	["{npc:12196}, beside her"] = "{npc:12196}, рядом с ней",
	-- {npc:12718} Gurda Ragescar
	["{npc:12718}: only if you carry the manual pages"] = "{npc:12718}: только если у вас есть страницы руководства",

	-- Step 22: Felmusk satyrs
	["Felmusk satyrs"] = "Сатиры из племени Мускуса Скверны",
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["North-west of Splintertree, the Felmusk satyrs camp in the woods. Every satyr can drop horns. Careful: Felmusk Rogues and Shadowstalkers move in stealth and join fights without warning."] = "К северо-западу от заставы Расщепленного Дерева в лесу стоит лагерь сатиров из племени Мускуса Скверны. Рога могут упасть с любого сатира. Осторожно: разбойники и ловцы теней из племени Мускуса Скверны передвигаются незаметно и вступают в бой без предупреждения.",

	-- Step 23: Shadumbra
	-- {npc:12677} Shadumbra · {area:426} Raynewood Retreat
	["{npc:12677}, a shadow panther, stalks the woods around {area:426}, west of the Felmusk camp. Her head starts the next hunt quest."] = "{npc:12677}, теневая пантера, рыщет в лесу вокруг места {area:426}, к западу от лагеря сатиров. Ее голова начинает следующее охотничье задание.",

	-- Step 24: Laughing Sisters
	-- plural, as words: Laughing Sisters = {npc:4054} Laughing Sister
	["Laughing Sisters"] = "Смеющиеся сестры",
	-- {area:426} Raynewood Retreat · {npc:12677} Shadumbra · {npc:4721} Zangen Stonehoof · {item:5867} Etched Phial
	-- plural, as words: Laughing Sisters = {npc:4054} Laughing Sister
	["The Laughing Sisters, dryads, wander {area:426} around {npc:12677}'s woods; one of them drops {npc:4721}'s {item:5867}, which can take several kills."] = "Смеющиеся сестры, дриады, бродят здесь: {area:426} – по лесу, где обитает {npc:12677}; одна из них роняет {item:5867} для NPC {npc:4721}, на это может уйти несколько убийств.",
	-- {item:5867} Etched Phial · {npc:4054} Laughing Sister
	["{item:5867}, from a {npc:4054}"] = "{item:5867}, с NPC {npc:4054}",

	-- Step 25: Ashenvale Moonwell
	-- {area:421} Mystral Lake · {item:5867} Etched Phial
	["South from Raynewood, the moonwell sits in a hollow west of the river, hard to see from the road; {area:421} is west of it. Use the {item:5867} at the moonwell to fill it."] = "К югу от Приюта Чащобы лунный колодец лежит в низине к западу от реки, его трудно заметить с дороги; {area:421} – к западу от него. Используйте {item:5867} у лунного колодца, чтобы наполнить его.",
	-- {item:5867} Etched Phial · {object:20806} Ashenvale Moonwell
	["{item:5867}, at the {object:20806}"] = "{item:5867}, у объекта {object:20806}",

	-- Step 26: Tideress
	-- {area:421} Mystral Lake · {npc:12759} Tideress · {item:16408} Befouled Water Globe · {quest:25} Stonetalon Standstill · {npc:12737} Mastok Wrilehiss
	["Back south-west to {area:421}. {npc:12759}, a corrupted water elemental, drifts around the lake's island and under the water. She drops the {item:16408} only once you have {quest:25} from {npc:12737}; it starts a quest for Splintertree."] = "",

	-- Step 27: Mystral Lake
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["Befouled Water Elementals drift around the lake's shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "Злобные элементали воды плавают у берегов озера; беседка стоит на острове, напротив заставы Альянса.",
	["Underwater"] = "Под водой",
	["Gazebo"] = "Беседка",

	-- Step 28: Ursangous
	-- {npc:12678} Ursangous · {area:418} Ruins of Stardust
	["West of Mystral Lake, {npc:12678}, a big grizzly, roams the {area:418}: his paw now drops for you."] = "К западу от Мистрального озера бродит {npc:12678}, большой медведь-гризли: {area:418}. Теперь с него падает лапа.",

	-- Step 29: Sharptalon
	-- {npc:12676} Sharptalon
	["On the way back north-east to Splintertree: {npc:12676} prowls the woods south-east of the Warsong lumber camp. Her claw starts the next hunt quest. Careful: {npc:12676} is a level 31 nightsaber and hits hard: pull her alone, away from the Outrunners."] = "По пути назад на северо-восток к Заставе Расщепленного Дерева: {npc:12676} рыщет в лесах к юго-востоку от лесозаготовки Песни Войны. Ее коготь начинает следующее охотничье задание. Осторожно: {npc:12676} – ночная саблезубая кошка 31-го уровня и бьет сильно: выманивайте ее одну, подальше от скороходов.",

	-- Step 36: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Летите сюда: {area:1638}",
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore
	["Fly to {area:1638} from Zoram'gar. If you don't know its flight path, fly to {area:378} and walk north through {zone:1412} instead."] = "Летите сюда из форта Зорам'гар: {area:1638}. Если вы не знаете этот маршрут, летите в {area:378} и идите на север через {zone:1412}.",
	-- {area:2897} Zoram'gar Outpost
	["{area:2897} flight master"] = "",

	-- Step 37: Skywatcher Plateau
	-- {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore
	["The Earthen Ring camp and its three quests stand up on {area:17045}, north of {zone:1456}. Fly to {zone:1456} if you know its flight path and take a lift down, else fly to {area:378} and walk north through {zone:1412}; the arrow then leads round to the plateau's north end and up onto it."] = "",
	["North of Thunder Bluff"] = "",

	-- Step 39: The Earthen Ring
	["The Earthen Ring"] = "Служители Земли",
	-- {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem · {npc:259118} Muln Earthfury · {zone:1456} Thunder Bluff · {area:378} Camp Taurajo
	["The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}. From {zone:1456}, take a lift down; coming on foot from {area:378}, keep north past the bluffs."] = "",
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother
	["{npc:259118}: {quest:96261} comes once this is handed in"] = "{npc:259118}: {quest:96261} – после сдачи этого задания",

	-- Step 40: Gloomrise: kill these as you meet them
	-- {area:17044} Gloomrise
	["{area:17044}: kill these as you meet them"] = "",
	-- {area:17044} Gloomrise · {npc:264074} Mazu'kon · {item:273015} Toxin Extractor · {item:273181} Crystalline Silk · {npc:264082} Broodmother Valraxx · {quest:96261} The Broodmother · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["North of the camp, spiders overrun the burial ground at {area:17044}. Use {npc:264074}'s {item:273015} on the Gnawed Corpses; the Spinners drop the {item:273181}. {npc:264082} (30, elite) sits at the north end: leave her unless you do {quest:96261} with a group; her {item:273658} starts {quest:96294}."] = "К северу от лагеря пауки заполонили кладбище – {area:17044}. Используйте {item:273015} ({npc:264074}) на обглоданных трупах; с прядильщиц падает {item:273181}. {npc:264082} (30, элитная) сидит в северном конце: не трогайте ее, если только не выполняете задание {quest:96261} с группой; ее {item:273658} начинает задание {quest:96294}.",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}, с прядильщиц ({npc:264081})",
	-- plural, as words: Gloomrise Toxin Samples = {item:273001} Gloomrise Toxin Sample · Gnawed Corpses = {npc:264096} Gnawed Corpse
	["Gloomrise Toxin Samples, from the Gnawed Corpses"] = "{item:273001}, с обглоданных трупов ({npc:264096})",

	-- Step 41: The Earthen Ring
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother · {quest:96259} Defending the Dead
	["{npc:259118} offers {quest:96261} only once {quest:96259} is handed in."] = "{npc:259118} предложит {quest:96261} только после сдачи задания {quest:96259}.",

	-- Step 43: Broodmother Valraxx
	-- {npc:264082} Broodmother Valraxx · {area:17044} Gloomrise · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	["{npc:264082} sits at the north end of {area:17044}; her {item:273658} starts {quest:96294}. {npc:264082} is elite: grouping up is advised."] = "{npc:264082} сидит в северном конце места {area:17044}; ее {item:273658} начинает задание {quest:96294}. {npc:264082} – элитный противник: лучше собрать группу.",
	-- {item:273658} Bloody Parchment · {npc:264082} Broodmother Valraxx
	["{item:273658}, from {npc:264082}: it does not drop for everyone"] = "{item:273658}, с NPC {npc:264082}: падает не у всех",

	-- Step 44: The Earthen Ring
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo
	["Back south to the camp, then up into {zone:1456} for the flight to {area:378}."] = "Назад на юг к лагерю, затем наверх: {zone:1456} – для полета в {area:378}.",

	-- Step 45: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 46: Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["{zone:1456}'s central rise"] = "{zone:1456}, центральное возвышение",

	-- Step 47: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:2995} Tal
	["Into {area:1638} by a lift: {npc:2995}, the wind rider master, stands on the central rise. Take his flight path if you don't know it yet."] = "",
	-- {npc:3057} Cairne Bloodhoof · {area:1638} Thunder Bluff · {quest:93739} Exploring the Horde
	["Speak with {npc:3057}, in {area:1638}: {quest:93739}"] = "Поговорите с NPC {npc:3057} ({area:1638}): {quest:93739}",
	-- {npc:3057} Cairne Bloodhoof
	["Talk to {npc:3057}"] = "",

	-- Step 48: Zangen Stonehoof
	-- {npc:4721} Zangen Stonehoof · {npc:2995} Tal
	["{npc:4721} stands a short walk east of {npc:2995}."] = "{npc:4721} стоит недалеко к востоку от NPC {npc:2995}.",
	-- {npc:4721} Zangen Stonehoof · {npc:4722} Rau Cliffrunner · {area:484} Freewind Post
	["{npc:4721}: {npc:4722} at {area:484}, later in this guide"] = "{npc:4721}: {npc:4722} ({area:484}), позже в этом гайде",

	-- Step 49: Tah Winterhoof
	-- {npc:3024} Tah Winterhoof · {npc:4721} Zangen Stonehoof · {npc:2995} Tal
	["{npc:3024} stands beside {npc:4721}, east of {npc:2995}."] = "{npc:3024} стоит рядом с NPC {npc:4721}, к востоку от NPC {npc:2995}.",

	-- Step 50: Ansekhwa
	-- {spell:199} Two-Handed Maces · {npc:11869} Ansekhwa
	["While you're here: learn {spell:199} from {npc:11869} (10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 51: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "Летите сюда: {area:378}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 52: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:485} Great Lift
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole south of {area:378}, on the road to the {area:485}."] = "Хижина: {npc:5899} – на гребне над водопоем свинобразов к югу от места {area:378}, на дороге к месту {area:485}.",
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["for {npc:5901}, south of {area:392}: next guide"] = "для NPC {npc:5901}, к югу от поселения {area:392}: следующий гайд",

	-- Step 53: Tear of the Moons
	-- {area:485} Great Lift · {area:359} Bael Modan · {npc:3421} Feegly the Exiled · {object:3646} General Twinbraid's Strongbox · {npc:3414} General Twinbraid
	["On the road south to the {area:485}, turn east into the {area:359} dig. {npc:3421} hides at its south edge. {object:3646} stands on the bottom floor of the dwarves' fortress, beside {npc:3414} (30) and his Officers (26): pull them to you one at a time."] = "",
	-- {object:3646} General Twinbraid's Strongbox
	["{object:3646}; below ground"] = "",

	-- Step 54: Great Lift
	-- {npc:12576} Grish Longrunner · {npc:10079} Brave Moonhorn · {area:485} Great Lift · {area:484} Freewind Post
	["{npc:12576} and {npc:10079} wait at the top of the {area:485}: Maggran's letter is for {npc:12576}, and Moonhorn's message goes down to {area:484} with you."] = "{npc:12576} и {npc:10079} ждут наверху: {area:485}. Письмо Магграна – для NPC {npc:12576}, а весть Лунного Рога вы отнесете вниз, сюда: {area:484}.",
	-- {npc:10079} Brave Moonhorn · {npc:10537} Cliffwatcher Longhorn · {area:484} Freewind Post
	["{npc:10079}, at the top of the lift: {npc:10537} at {area:484}"] = "{npc:10079}, наверху подъемника: {npc:10537} – здесь: {area:484}",

	-- Step 55: Freewind Post's lift
	-- {area:484} Freewind Post
	["{area:484}'s lift"] = "",

	-- Step 56: Freewind Post
	-- {area:484} Freewind Post
	["Ride the lift down, then follow the road east through the canyons to {area:484}, a Tauren village on top of the mesas. Its lift is on the north side."] = "Спуститесь на подъемнике, затем идите по дороге на восток через каньоны: {area:484}, деревня тауренов на вершинах столовых гор. Ее подъемник – на северной стороне.",
	-- {npc:10377} Elu
	["{npc:10377}, by the wind rider master"] = "{npc:10377}, у распорядителя полетов",
	-- {npc:10537} Cliffwatcher Longhorn
	["The Wanted poster beside {npc:10537}"] = "Плакат «Разыскивается» рядом с {npc:10537} утесов",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}, the trade supplies vendor: the Screeching harpies of {area:487}; inside the inn"] = "{npc:4877}, торговец товарами: визгливые гарпии ({area:487}); в таверне",
	-- {npc:4877} Jandia
	["{npc:4877}: her stolen supplies lie in the same harpy den"] = "{npc:4877}: ее украденные припасы лежат в том же логове гарпий",

	-- Step 57: Rau Cliffrunner
	-- {npc:4722} Rau Cliffrunner · {area:484} Freewind Post · {npc:4721} Zangen Stonehoof
	["{npc:4722} stands in {area:484}: {npc:4721}'s filled phial is for him."] = "{npc:4722} стоит здесь: {area:484}. Наполненный фиал от NPC {npc:4721} – для него.",
	-- {npc:4722} Rau Cliffrunner · {object:20807} Ancient Brazier · {area:1557} Splithoof Hold
	["{npc:4722}: the {object:20807} in {area:1557}, among the Galak camps"] = "{npc:4722}: {object:20807} ({area:1557}), среди лагерей Галак",

	-- Step 58: Alien Egg
	["Take the lift down. The egg lies in a nest on the canyon floor in one of three spots: south-east of the mesas (52.3,55.2), east (56.4,50.4) or south-west (37.6,56.1)."] = "Спуститесь на подъемнике. Яйцо лежит в гнезде на дне каньона в одном из трех мест: к юго-востоку от столовых гор (52.3,55.2), к востоку (56.4,50.4) или к юго-западу (37.6,56.1).",

	-- Step 59: Galak centaurs
	["Galak centaurs"] = "Кентавры из племени Галак",
	-- {npc:10617} Galak Messenger · {area:2237} Whitereach Post · {npc:216463} Ailgrha Splittusk
	-- plural, as words: Ravaging Tempests = {npc:216474} Ravaging Tempest
	["The Galak camps fill the canyon north of Freewind; Scouts, Wranglers and Windchasers share every camp. A lone {npc:10617} walks a long path between the camps: if you meet him, kill him, his note starts a quest for {area:2237}. Don't wait for him. Careful: storm elementals roam the canyon floor around the camps: Stormheart (30), the Ravaging Tempests (40) and {npc:216463} (38), all elite. Keep clear of them."] = "Лагеря Галак заполняют каньон к северу от заставы Вольного Ветра; разведчики, пастухи и ветроловки есть в каждом лагере. Одинокий {npc:10617} ходит между лагерями длинным маршрутом: если встретите его, убейте – его записка начинает задание для места {area:2237}. Не ждите его специально. Осторожно: по дну каньона вокруг лагерей бродят элементали бури: Stormheart (30), опустошающие бури (40) и {npc:216463} (38), все элитные. Держитесь от них подальше.",
	-- {npc:10617} Galak Messenger · {quest:4881} Assassination Plot
	["{npc:10617}'s {quest:4881}, if you meet him"] = "{quest:4881} от {npc:10617}, если встретите его",

	-- Step 60: Splithoof Hold
	-- {area:1557} Splithoof Hold · {object:20807} Ancient Brazier · {item:5868} Filled Etched Phial · {item:5869} Cloven Hoof · {npc:2986} Dorn Plainstalker
	-- plural, as words: Galak Flame Guards = {npc:7404} Galak Flame Guard
	["A short walk north of the Galak camps, the cave of {area:1557} leads down to its deepest chamber, where the {object:20807} burns. Use the {item:5868} on it, then loot the {item:5869} at once: the flame only stays out briefly, and if it relights the phial is gone. Then east to {npc:2986}'s mesa.\nCareful: Two Galak Flame Guards (30) stand by the brazier and a centaur guard walks the cave: pull them away one at a time before you douse the flame."] = "Недалеко к северу от лагерей Галак пещера ({area:1557}) ведет вниз к самому дальнему залу, где горит {object:20807}. Используйте на ней {item:5868}, затем сразу заберите {item:5869}: пламя гаснет ненадолго, и если оно разгорится снова, склянка пропадет. Затем идите на восток к плато NPC {npc:2986}.\nОсторожно: у жаровни стоят два огненных стража Галак (30), а по пещере ходит кентавр-стражник: оттяните их по одному, прежде чем гасить пламя.",
	-- {item:5868} Filled Etched Phial · {object:20807} Ancient Brazier
	["{item:5868}, at the {object:20807}"] = "{item:5868}, у объекта {object:20807}",
	-- {item:5869} Cloven Hoof · {object:20807} Ancient Brazier
	["{item:5869}, from the {object:20807}"] = "{item:5869}, из объекта {object:20807}",

	-- Step 61: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {quest:1149} Test of Faith
	["{npc:2986} stands on a mesa top east of the Galak camps. For the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "{npc:2986} стоит на вершине столовой горы к востоку от лагерей Галак. Для задания {quest:1149} сойдите с края досок рядом с ним: вы приземлитесь невредимым.",
	-- {npc:2986} Dorn Plainstalker
	["{npc:2986}, below ground"] = "",

	-- Step 62: Freewind Post
	-- {npc:11116} Innkeeper Abeqwa · {npc:4877} Jandia
	["{npc:11116}, beside {npc:4877}"] = "{npc:11116}, рядом с NPC {npc:4877}",

	-- Step 64: Darkcloud Pinnacle
	-- {area:2097} Darkcloud Pinnacle
	-- plural, as words: Document Chests = {object:176344} Document Chest
	["West of Freewind, the Grimtotem camps below {area:2097}. The Secret Notes are in Document Chests at the south-east, south-west and north-west camps."] = "К западу от заставы Вольного Ветра, под местом {area:2097}, – лагеря Зловещего Тотема. Тайные записки лежат в сундучках для бумаг ({object:176344}) в юго-восточном, юго-западном и северо-западном лагерях.",
	-- {object:176344} Document Chest
	["{object:176344}, south-east camp"] = "{object:176344}, юго-восточный лагерь",
	-- {object:176344} Document Chest
	["{object:176344}, south-west camp"] = "{object:176344}, юго-западный лагерь",
	-- {object:176344} Document Chest
	["{object:176344}, north-west camp"] = "{object:176344}, северо-западный лагерь",

	-- Step 65: Level 28.9
	["Level 28.9"] = "",
	-- {npc:10646} Lakota Windsong · {area:2797} Blackfathom Deeps
	["Short of 28.9? The Grimtotem around these camps (25-28) are the right level: kill a few more before the climb to {npc:10646}. Past it, this step skips itself. Or, with a group, run the {area:2797} dungeon instead."] = "",
	-- {area:2097} Darkcloud Pinnacle
	["Grimtotem camps below {area:2097}"] = "",
	-- {npc:10759} Grimtotem Stomper
	["grind on {npc:10759}"] = "",

	-- Step 66: Lakota Windsong
	-- {area:2097} Darkcloud Pinnacle · {npc:10646} Lakota Windsong · {npc:10896} Arnak Grimtotem
	["Climb the path to the top of {area:2097}. {npc:10646} is held captive beside {npc:10896} (29): clear the guards and {npc:10896} first, then free her and protect her on the walk down; Grimtotem ambushers come at you on the way."] = "Поднимитесь по тропе на вершину: {area:2097}. {npc:10646} в плену рядом с NPC {npc:10896} (29): сначала уберите стражу и {npc:10896}, затем освободите ее и защищайте на спуске; по пути нападут засадники Зловещего Тотема.",

	-- Step 67: Highperch
	-- {area:482} Highperch · {npc:10427} Pao'ka Swiftmountain · {area:2237} Whitereach Post
	["West of Whitereach the wyverns nest on the {area:482} cliffs; the eggs lie in the nests. {npc:10427} waits on the east side of the nesting grounds: free him and keep him alive on the walk back to {area:2237}.\nCareful: Wyverns at level 28-29 fly overhead and can be pulled without warning. A group of three wyverns can ambush you once you pass the first pillar at the bottom."] = "К западу от заставы Белого Плеса виверны гнездятся на утесах ({area:482}); яйца лежат в гнездах. {npc:10427} ждет на восточной стороне гнездовий: освободите его и сохраните ему жизнь на пути обратно в {area:2237}.\nОсторожно: над головой летают виверны 28-29-го уровня, которых можно привлечь без предупреждения. Когда вы минуете первую колонну внизу, на вас может напасть группа из трех виверн.",

	-- Step 68: Whitereach Post
	-- {npc:10428} Motega Firemane · {zone:1456} Thunder Bluff
	["{npc:10428}'s next quest, Sacred Fire, ends in {zone:1456}, off this route. Skip it."] = "Следующее задание {npc:10428}, «Священное пламя», заканчивается в {zone:1456}, вне маршрута. Пропустите его.",

	-- Step 69: Kanati Greycloud
	-- {npc:10617} Galak Messenger · {npc:10638} Kanati Greycloud · {area:2237} Whitereach Post
	["Only if the {npc:10617} dropped his plot for you: {npc:10638} stands at {area:2237}."] = "Только если {npc:10617} выронил для вас свой план: {npc:10638} стоит здесь: {area:2237}.",

	-- Step 71: Hypercapacitor Gizmo
	-- {npc:10992} Enraged Panther
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:10992} is a level 30 elite: most classes solo it at level 32, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 72: Whitereach Post
	-- {npc:10720} Galak Assassin · {npc:10638} Kanati Greycloud
	["Kill the {npc:10720} that comes for {npc:10638}"] = "Убейте NPC {npc:10720}, который придет за {npc:10638}",

	-- Step 75: Level 29.49
	["Level 29.49"] = "",
	-- {quest:5151} Hypercapacitor Gizmo · {area:487} Roguefeather Den · {area:2797} Blackfathom Deeps
	["If you skipped {quest:5151} and are still short of 29.49, kill harpies here first: {area:487} is your next stop anyway. The Screeching Harpies (28-29) at its edge are at your level; the Roguefeathers and Windcallers (29-30) inside hit harder. Past it, this step skips itself. Or, with a group, run the {area:2797} dungeon instead."] = "Если вы пропустили задание {quest:5151} и вам все еще не хватает до уровня 29.49, сначала убивайте гарпий здесь: {area:487} – все равно ваша следующая остановка. Визгливые гарпии (28-29) на ее краю вашего уровня; бродяжницы и призывательницы ветров (29-30) внутри бьют сильнее. После этого уровня шаг пропускается сам. Или, с группой, пройдите вместо этого подземелье {area:2797}.",
	-- {npc:4100} Screeching Harpy
	["grind on {npc:4100}"] = "",

	-- Step 76: The Screeching Canyon: kill these as you meet them
	-- {area:483} The Screeching Canyon
	["{area:483}: kill these as you meet them"] = "",
	-- {area:487} Roguefeather Den · {npc:4490} Grenka Bloodscreech · {npc:4877} Jandia · {quest:98069} Stolen Freewind Supplies
	["South of Darkcloud, the harpies of {area:487}. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her. The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s; her {quest:98069} lie on the ground along the foot of the cliff and in the cave up on top."] = "К югу от Пика Темного Облака – гарпии: {area:487}. {npc:4490} (31) ходит среди них: проредите гарпий вокруг нее, прежде чем тянуть ее. Визгливые гарпии, бродяжницы и призывательницы ветров там – для NPC {npc:4877}.; ее {quest:98069} лежат на земле у подножия утеса и в пещере наверху.",
	-- {quest:98069} Stolen Freewind Supplies
	["{quest:98069}, on the ground around the den"] = "",

	-- Step 77: Freewind Post
	-- {area:484} Freewind Post · {area:487} Roguefeather Den · {npc:2986} Dorn Plainstalker
	["Back east to {area:484}: it lies on the way from {area:487} to {npc:2986}'s mesa."] = "Назад на восток: {area:484} – по пути от места {area:487} к плато NPC {npc:2986}.",
	-- {npc:10645} Thalia Amberhide
	["{npc:10645}, inside"] = "",
	-- {npc:4877} Jandia
	["{npc:4877}, inside"] = "",

	-- Step 78: Test of Endurance
	-- {npc:2986} Dorn Plainstalker
	["{npc:2986}'s mesa is north-east of Freewind."] = "Плато NPC {npc:2986} – к северо-востоку от Привольного.",
	-- {npc:2986} Dorn Plainstalker · {quest:1151} Test of Strength · {quest:1150} Test of Endurance
	["{npc:2986} offers {quest:1151} once {quest:1150} is in"] = "",

	-- Step 79: Rok'Alim the Pounder
	-- {npc:4499} Rok'Alim the Pounder · {area:482} Highperch · {area:2237} Whitereach Post
	["{npc:4499}, a hard-hitting rock elemental, walks the cliffs of {area:482}, back west past {area:2237}. {npc:4499} is elite: grouping up is advised."] = "{npc:4499}, сильно бьющий каменный элементаль, ходит по утесам ({area:482}), обратно на запад мимо места {area:2237}. {npc:4499} – элита: лучше собрать группу.",

	-- Step 80: Freewind Post
	-- {area:484} Freewind Post · {area:2240} Mirage Raceway · {area:439} Shimmering Flats
	["Back to {area:484}. The {area:2240}'s quests come with the next visit to the {area:439}, at 33."] = "",
	-- {zone:1454} Orgrimmar
	["The next guide flies on from here to the Crossroads and {zone:1454}."] = "Отсюда следующий гайд летит к Перекрестку и в {zone:1454}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south-west to {area:421}. Befouled Water Elementals drift around its shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "Назад на юго-запад: {area:421}. Злобные элементали воды ({npc:3917}) плавают у берегов; беседка стоит на острове, напротив заставы Альянса.",
	-- ["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold."] = "К востоку от форта Зорам'гар фурболги из племени Колючего Меха заполняют деревню и холмы вокруг своего логова.",
	-- ["Fly from {area:392} to {area:2897} on the {zone:1440} coast."] = "Летите из поселения {area:392}: {area:2897} на побережье зоны {zone:1440}.",
	-- ["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {zone:1413}."] = "Летите из места {zone:1456}: {area:378} – и идите по дороге на юг: {area:1718}, в самом низу зоны {zone:1413}.",
	-- ["Fly from {zone:1456} to {area:378}. {npc:5899}'s hut stands on the ridge above the quilboar watering hole south of the camp, on the road to the {area:1718}."] = "Летите из места {zone:1456}: {area:378}. Хижина: {npc:5899} – на гребне над водопоем свинобразов к югу от лагеря, на дороге к месту {area:1718}.",
	-- ["Fly to {area:1638} if you know the flight path. If not, fly to {area:378}, ride west into {zone:1412} past {area:222} to {area:1638} and take its flight path from {npc:2995} on the central rise."] = "Летите в {area:1638}, если знаете маршрут. Если нет, летите в {area:378}, езжайте на запад: {zone:1412}, мимо места {area:222}, до {area:1638} – и откройте там маршрут у NPC {npc:2995} на центральном холме.",
	-- ["Follow the canyon east out of the mesas onto the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Идите по каньону на восток из столовых гор на соляные равнины. Гоблины и гномы – {area:2240} – нейтральны и дают задания обеим фракциям.",
	-- ["Follow the canyon west to {area:2237}."] = "Идите по каньону на запад: {area:2237}.",
	-- ["Gazebo"] = "Беседка",
	-- ["Grimtotem camps"] = "Лагеря Зловещего Тотема",
	-- ["His crate is for Stranglethorn, later on the route"] = "Его ящик – для Тернистой долины, позже по маршруту",
	-- ["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}."] = "Внутри логова вдоль туннелей стоят тролльские сундуки ({object:178144}). {npc:12818} заточен в глубине: освободите его и защищайте до выхода, затем он убежит домой: {area:428}.",
	-- ["Naga brazier"] = "Жаровня наг",
	-- ["North up the road to {area:431} and {area:428} beside it."] = "На север по дороге: {area:431} – и {area:428} рядом.",
	-- ["On the way back north-east to Splintertree: {npc:12676} prowls the woods south-east of the Warsong lumber camp."] = "На обратном пути на северо-восток к заставе Расщепленного Дерева: {npc:12676} рыщет в лесу к юго-востоку от Лесозаготовок Песни Войны.",
	-- ["Shadumbra"] = "Тенумбра",
	-- ["Sharptalon"] = "Острокоготь",
	-- ["Take a lift down from {zone:1456}. The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}."] = "Спуститесь на подъемнике: {zone:1456}. Лагерь Служителей Земли – к северу от утесов: {npc:264074}, {npc:264072} и {npc:259118}.",
	-- ["The Galak camps fill the canyon north of Freewind; Scouts, Wranglers and Windchasers share every camp. A lone {npc:10617} walks between the camps: kill him when you meet him, his note starts a quest for {area:2237}."] = "Лагеря Галак заполняют каньон к северу от заставы Вольного Ветра; разведчики, пастухи и ветроловки есть в каждом лагере. Между лагерями ходит одинокий {npc:10617}: убейте его при встрече, его записка начинает задание для места {area:2237}.",
	-- ["The fountain stands in the middle of the {area:418}: use the {item:7767} there."] = "Фонтан стоит посреди места {area:418}: используйте там {item:7767}.",
	-- ["The salt flats"] = "Соляные равнины",
	-- ["The {area:1718}"] = "{area:1718}",
	-- ["Thistlefur Hold"] = "Логово Колючего Меха",
	-- ["Tideress"] = "Приливница",
	-- ["Ursangous"] = "Топтыжень",
	-- ["{npc:10079}, at the top of the lift"] = "{npc:10079}, наверху у подъемника",
	-- ["{npc:12676}, a big nightsaber, prowls the woods south-east of the Warsong lumber camp. Her claw starts the next hunt quest."] = "{npc:12676}, большая ночная саблезубая кошка, рыщет в лесу к юго-востоку от Лесозаготовок Песни Войны. Ее коготь начинает следующее охотничье задание.",
	-- ["{npc:12696}, once all three hunts are in"] = "{npc:12696}, когда все три охоты сданы",
	-- ["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead."] = "{npc:12717} идет на север по берегу к жаровне наг. Потушите жаровню, затем охраняйте его от волн наг, пока Ворша не погибнет.",
	-- ["{npc:12717}: starts his escort at once"] = "{npc:12717}: сопровождение начинается сразу",
	-- ["{npc:12759}, a corrupted water elemental, drifts in {area:421}. Her {item:16408} starts a quest for Splintertree."] = "{npc:12759}, оскверненная водная элементаль, плавает здесь: {area:421}. Ее {item:16408} начинает задание для заставы Расщепленного Дерева.",
	-- ["{npc:12837}, inside the inn"] = "{npc:12837}, в таверне",
	-- ["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867} стоит на лесозаготовках. Бегуны ночных эльфов рыщут в лесу к юго-востоку; они скрываются, так что смотрите в оба.",
	-- ["{npc:210995}, a Forever addition, stands on the west shore of {area:421} with three quick Dragonslayer quests."] = "{npc:210995}, добавленный в Forever, стоит на западном берегу ({area:421}) с тремя быстрыми заданиями драконоборцев.",
	-- ["{npc:4454}: his letter goes to Martek in the {zone:1418}, around level 38"] = "{npc:4454}: его письмо – Мартеку ({zone:1418}), около 38-го уровня",
	-- ["{object:19868} lies all over the flats north of the raceway. Scorpid Reavers and Sparkleshell Tortoises roam the north half, Salt Flats Scavengers circle overhead, and Saltstone Basilisks graze west of the track. The Crystalhides roam the middle of the flats and the Gazers (34-35, five levels above you: one at a time) the far south."] = "{object:19868} лежат по всей равнине к северу от трассы. Скорпиды-разорители ({npc:4140}) и блестопанцирные черепахи ({npc:4142}) бродят в северной половине, солончаковые падальщики ({npc:4154}) кружат над головой, а просоленные василиски ({npc:4147}) пасутся к западу от трассы. Просоленные хрусталиски бродят посреди равнины, а просоленные взорни (34-35, на пять уровней выше вас: по одному) – на крайнем юге.",
}
