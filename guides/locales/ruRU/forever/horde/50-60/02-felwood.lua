-- Russian (ruRU): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "Он стоит лагерем у места {area:202}, к юго-востоку от места {area:200}.",
	["Inside"] = "Внутри",

	-- Step 2: Diseased Wolves
	["Diseased Wolves"] = "Больные волки",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east. Careful: the biggest are 54: pull them one at a time."] = "Волки бродят по полям между Андоралом, местом {area:200} и местом {area:202}. Добейте их по пути обратно на восток. Осторожно: самые крупные – 54 уровня, тяните их по одному.",

	-- Step 3: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "Дом фермы: {area:200}",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "Дневник лежит в доме, шкаф стоит внутри, а уборная – за домом. Ключ от уборной у монстра {npc:10816}; {npc:10836} выходит, когда вы открываете уборную, – у него ключ от шкафа.",

	-- Step 4: Mulgris Deepriver
	["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands guide's sweep at about 55."] = "",

	-- Step 6: High Executor Derrington
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nTake a {object:176092} from the crate next to Derrington for {quest:5096}."] = "Вы пропустили это при прошлом посещении этих мест по маршруту: теперь это идёт первым. Это быстро и открывает следующие задания.\nВозьмите {object:176092} из ящика рядом с Деррингтоном для задания {quest:5096}.",

	-- Step 7: Scarlet forward camp
	["Scarlet forward camp"] = "Передовой лагерь Алого ордена",
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands · {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "От места {area:152} езжайте по дороге на восток в край {zone:1422}. Палатки Алого ордена стоят сразу за фермой Фелстоунов, между местами {area:199} и {area:200}. Подожгите командную палатку ({object:176092}) и установите знамя Плети. Осторожно: воины Алого ордена у палаток – до 54 уровня, а заклинатели колдуют: заходите со стороны, ближайшей к командной палатке, и не трогайте остальных.",

	-- Step 8: The Bulwark
	-- {area:152} The Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "Езжайте на юго-запад мимо фермы Фелстоунов и по дороге на запад обратно сюда: {area:152}.",
	["Derrington's watchtowers and Vandis' cauldron are done on a later visit: keep them."] = "Сторожевые башни Деррингтона и котел Вандис – в следующий визит: сохраните эти задания.",

	-- Step 10: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246152} Shari Stilwell · {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["{npc:246152} in {zone:1420}; {zone:1454} has no paladin trainer"] = "{npc:246152} – здесь: {zone:1420}; в городе {zone:1454} нет учителя паладинов",

	-- Step 11: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",

	-- Step 12: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 13: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659} takes the ravasaur claws from Un'Goro; he stands in the {object:172960}, a short walk from the middle of the city."] = "{npc:8659} принимает когти равазавров из Ун'Горо; он стоит здесь: {object:172960}, недалеко от центра города.",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",

	-- Step 14: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Летите сюда: {area:1237}",
	-- {zone:1447} Azshara · {zone:1454} Orgrimmar
	["{zone:1447} is a short flight from {zone:1454}: its quests are 51-55, at your level now."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 15: Valormok
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}: {quest:91569}, жезл с чародеев эльфов крови",

	-- Step 16: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221}: убивайте их по пути",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "Езжайте на восток к руинам на побережье. Четыре скрижали лежат среди руин под охраной наг из племени Хлещущих Злобой (52-55): выманивайте по одному.",

	-- Step 17: Ruins of Eldarath
	-- {area:1231} Southridge Beach
	["Fill Cuely's four vials at the tide pools on the shore, from {area:1231} north up the coast; Spitelash naga patrol between them."] = "",
	-- {item:10691} Filled Vial Labeled #1 · {area:1231} Southridge Beach
	["{item:10691}: the tide pool on {area:1231}"] = "",
	["#2, north along the shore"] = "",

	-- Step 18: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "Макриннские землерои",
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower · Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment
	["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "Макриннские землерои (50-51) роются в песках чуть к востоку от руин, по пути на северо-восток; с них и из закопанных тайников там добываются фрагменты сокровища высокорожденных.",

	-- Step 19: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "Дальше на северо-восток через середину зоны {zone:1447}: {npc:235903} стоит лагерем у дороги.",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}: {quest:86746}, сатиры к северу от лагеря эльфов крови",

	-- Step 20: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "Езжайте на северо-восток к лагерю гоблина на скалах над местом {area:1227}, чуть к северу от эльфов крови.",

	-- Step 21: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Эльфы крови стоят лагерем на скалах на северо-востоке, у места {area:1227}. Четыре предмета снаряжения для {npc:8420} лежат в ящиках вокруг лагеря; у чародеев эльфов крови – жезл для {npc:247473}.\nОсторожно: у западного края лагеря стоит {npc:250023}, элитный противник 55-57 уровня: бейте эльфов крови с восточной стороны лагеря.",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680} – с чародеев эльфов крови",

	-- Step 22: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Лагерь: {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "Лагерь Римтори – в восточной части лагеря. Прочитайте там {object:151286}: на Forever лежащий рядом фолиант син'дорай затем потребует печати трех офицеров лагеря.",

	-- Step 23: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "У каждого из трех офицеров лагеря (53) есть печать: {npc:247006} – в центре лагеря, {npc:247013} – в его восточном конце, а {npc:246991} ходит по западной половине: атакуйте его в восточной части маршрута, куда указывает стрелка.\nОсторожно: {npc:250023}, элита 55-57 уровня, стоит у западного края лагеря, рядом с дальним концом маршрута Ястребиного Шлема: дождитесь, пока он вернется на восток.",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{item:246725}, с NPC {npc:247006}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{item:246721}, с NPC {npc:246991}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{item:246722}, с NPC {npc:247013}",

	-- Step 24: Magus Rimtori
	-- {npc:8578} Magus Rimtori
	["Back to the Sin'dorei Tome: hand in the seals, then use it to call {npc:8578}.\nCareful: Rimtori is level 55, and which crystal is linked to him is random: each of the other two summons a hostile infernal instead. Start at full health."] = "",
	-- {quest:91538} Sin'dorei Tome of Summoning · {npc:8587} Jediga · {area:1237} Valormok
	["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}: для NPC {npc:8587} ({area:1237})",

	-- Step 25: The Legashi satyrs
	["The Legashi satyrs"] = "Сатиры Легаши",
	-- {npc:235903} Ekkal · {npc:235892} Prince Halanox
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind.\nCareful: {npc:235892} (55, elite) stands among the satyrs at the north-east end of their hills, around 67,19: take the satyrs nearer the camp and leave him be."] = "",

	-- Step 26: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-west to {npc:8420}."] = "Возвращайтесь на северо-запад к NPC {npc:8420}.",

	-- Step 27: Ruins of Eldarath: Some Rune
	-- {area:1221} Ruins of Eldarath · {npc:8420} Kim'jael
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "Езжайте на юг к северному краю места {area:1221}. Сирены и мирмидоны из клана Бича Злобы (50-52) носят руну для NPC {npc:8420}; она падает нечасто, так что продвигайтесь вдоль края, пока не выпадет.",

	-- Step 28: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north to {npc:8420} with the rune, then south-west along the road."] = "Возвращайтесь на север к NPC {npc:8420} с руной, затем на юго-запад по дороге.",

	-- Step 29: Ekkal
	-- {npc:235903} Ekkal
	["South-west along the road: {npc:235903} takes the satyrs."] = "На юго-запад по дороге: {npc:235903} принимает сатиров.",

	-- Step 30: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Возвращайтесь на запад сюда: {area:1237}.",
	-- {npc:8576} Ag'tor Bloodfist · {quest:91531} Revenge Exacted · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}: {quest:91531}, для NPC {npc:4485} ({zone:1454})",
	-- {npc:8587} Jediga · {npc:3326} Zevrost · {zone:1454} Orgrimmar
	["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}: фолиант нужно отнести NPC {npc:3326} ({zone:1454})",
	-- {npc:8659} Jes'rimon · {npc:4485} Belgrom Rockmaul · {npc:3326} Zevrost · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {npc:6522} Andron Gant · {zone:1458} Undercity
	["Keep the deliveries: {npc:8659}, {npc:4485} and {npc:3326} are in {zone:1454} next, Magatha in {zone:1456} and {npc:6522} in the {zone:1458} on the next guides."] = "",

	-- Step 31: Sanath Lim-yo
	-- {area:1237} Valormok · {npc:8379} Archmage Xylem
	["Ride east from {area:1237} to Sanath's camp at the foot of the cliff and get off your mount: he teleports you up to {npc:8379}'s tower."] = "",

	-- Step 32: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "",
	["Upstairs"] = "Наверху",

	-- Step 34: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Распорядитель полетов: {area:1237}",

	-- Step 35: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {npc:3326} Zevrost · {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:4485} is in the {object:172958}, {npc:3326} and {npc:8659} in the {object:172960}."] = "",
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow
	["{npc:3326}, the {object:172960}"] = "{npc:3326}, {object:172960}",
	-- {npc:8659} Jes'rimon · {npc:8587} Jediga
	["{npc:8659}: his payment goes back to {npc:8587}, on the flight out"] = "",

	-- Step 36: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 37: Druid trainer
	["Druid trainer"] = "Учитель друидов",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034}, Зона: {zone:1412}; в зоне {zone:1454} нет учителя друидов",

	-- Step 38: Fly to Valormok
	-- {zone:1448} Felwood · {area:1237} Valormok · {npc:8587} Jediga · {npc:8659} Jes'rimon · {area:431} Splintertree Post
	["{zone:1448} is next: fly by way of {area:1237}, where {npc:8587} takes {npc:8659}'s payment, then on to {area:431}."] = "",

	-- Step 40: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Летите сюда: {area:431}",

	-- Step 42: Emerald Sanctuary
	["The druids' camp is just past the border."] = "Лагерь друидов – сразу за границей.",
	-- {npc:10920} Kelek Skykeeper · {npc:10921} Taronn Redfeather · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}, beside {npc:10921}: {quest:86577}, the organs of {zone:1448}'s bears and wolves"] = "{npc:10920}, рядом с NPC {npc:10921}: {quest:86577} – органы медведей и волков ({zone:1448})",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}, на южном краю лагеря",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the camp"] = "{npc:9529}, в западной части лагеря",

	-- Step 43: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "",

	-- Step 44: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "Юг: {area:1763}",
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: pull the cultists and hounds away from him."] = "",

	-- Step 46: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "Лунный колодец: {area:1763}",
	-- {area:1763} Jaedenar
	["Back north to {area:1763}. Fill Greta's canteen at the corrupted moonwell in the middle of the southern camp."] = "Назад на север сюда: {area:1763}. Наполните флягу Греты у оскверненного лунного колодца в центре южного лагеря.",

	-- Step 47: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "Лагерь Орды чуть к северу от места {area:1763}.",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}: совухи – здесь: {zone:1452}",

	-- Step 48: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "К востоку от Заставы Отравленной Крови – долина с кратерами, где бродят энтропические звери и ужасы. Убейте по два каждого, затем подойдите к каждому из трех кратеров с водой Скверны.",
	["Southern crater"] = "Южный кратер",
	["Western crater"] = "Западный кратер",
	["Northern crater"] = "Северный кратер",

	-- Step 49: Statue of Malorne
	-- {object:661778} Statue of Malorne (no name in this language: may be words) · {npc:9996} Winna Hazzard · {area:1997} Bloodvenom Post
	["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996} at {area:1997}."] = "Статуя Малорна ({object:661778}) стоит чуть южнее долины, у дороги на север: ее безделушка начинает задание для NPC {npc:9996} ({area:1997}).",

	-- Step 50: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber · {npc:10920} Kelek Skykeeper
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s."] = "",
	-- {item:277958} Putrescent Bear Organs
	["{item:277958}, from the Angerclaw bears"] = "{item:277958} – с медведей злобных когтей",
	-- {item:277959} Putrescent Wolf Organs
	["{item:277959}, from the Felpaw wolves"] = "{item:277959} – с волков-сквернолапов",

	-- Step 51: Irontree Woods
	["Below ground"] = "Под землей",

	-- Step 52: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {quest:6031} Runecloth · {area:1769} Timbermaw Hold
	["Only from Friendly with the Timbermaw: {npc:11557}, in the tunnel near its {zone:1448} mouth, gives {quest:6031} then (the {area:1769} reputation guide gets you there)."] = "",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; below ground"] = "",

	-- Step 53: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "Дорога заканчивается у персонажа {npc:15395}, у входа в туннель ({area:1769}) на дальнем северо-востоке.",

	-- Step 54: Felpaw Village
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nIf one drops a {quest:8470} (about one kill in thirty), right-click it; don't stay to farm one. {npc:11558} in {area:1769} takes it only from Neutral with the Timbermaw (the {area:1769} reputation guide gets you there): now if they already are, or on the last guide's pass of the cave."] = "",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop from the Deadwood furbolgs"] = "",

	-- Step 55: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "Сохраните задание {quest:8465} для края {zone:1452}.",

	-- Step 56: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She speaks to you only from Neutral with the Timbermaw."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: use it to start the quest, then free {npc:11018} from her cage in {area:1770}, the cave at the north end of {area:1763}."] = "Выпал предмет {item:13140}: используйте его, чтобы начать задание, затем освободите персонажа {npc:11018} из клетки ({area:1770} – пещера в северной части места {area:1763}).",
	-- ["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "Снова здесь: {area:1762} – фурболги Мертвого Леса (53-54) рядом с туннелем, и каждое убийство повышает репутацию у Древобрюхов.",
	-- ["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "Осторожно: дозорные – 53-54 уровня, мстители из племени Мертвого Леса – 54-55; при здоровье ниже 50% они зовут союзников в радиусе 25 м, а ниже 15% убегают за помощью.\nУбивайте их, пока не выпадет {quest:8470} (примерно один на тридцать), затем нажмите на него правой кнопкой: {npc:11558} ({area:1769}) примет его, когда Древобрюхи станут к вам равнодушны – сейчас, если уже, или когда последний гайд снова пройдет мимо пещеры на 59.",
	-- ["Cross the river east into {area:2627}, the ruined town in the north-west of the {zone:1423}. {npc:12384} sits in a hut at its edge."] = "Переправьтесь через реку на восток в место {area:2627} – разрушенный город на северо-западе края {zone:1423}. {npc:12384} сидит в хижине на его окраине.",
	-- ["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "Сторожевые башни Деррингтона, котел Вандис и бочка {npc:11615} – в следующий визит: сохраните эти задания.",
	-- ["Diseased Grizzlies"] = "Больные гризли",
	-- ["Fly to the {area:1497}"] = "Летите сюда: {area:1497}",
	-- ["Fly to {area:272}"] = "Летите сюда: {area:272}",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s.\n{area:1762}'s Deadwood Den Watchers (53-54) and Avengers (54-55) are next: below level 54, keep hunting the grizzlies and ravagers (51-52) here until 54. The hand-ins at {area:1769}, the {area:2479} and {area:1997} that follow take you most of the way to 55. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Езжайте по дороге на северо-восток сюда: {area:1767}. У криводревов-моходеров и криводревов-живорезов в восточной части леса – {item:11503}; в том же лесу бродят гризли злобных когтей и опустошители-сквернолапы для Тало, а их органы нужны NPC {npc:10920}.\nДальше – дозорные (53-54) и мстители (54-55) из племени Мертвого Леса ({area:1762}): если вы ниже 54 уровня, охотьтесь здесь на гризли и опустошителей (51-52) до 54. Сдача заданий ({area:1769}, {area:2479} и {area:1997}) почти доведет вас до 55. Или с группой пройдите подземелье {area:1417} или {area:1584}.",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo. Below level 54.21, keep hunting the grizzlies and ravagers: the hand-ins at {area:1997} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Езжайте по дороге на северо-восток сюда: {area:1767}. У криводревов и криводревов-живорезов в восточной части леса – {item:11503}; в том же лесу бродят гризли злобных когтей и разорители-сквернолапы для Тало. Если вы ниже уровня 54.21, продолжайте охоту на гризли и разорителей: сдача заданий ({area:1997} и {area:2479}) доведет вас до 55-го уровня. Или с группой пройдите подземелье {area:1584} или {area:1417}.",
	-- ["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "Езжайте по дороге на северо-запад. Юг места {area:1763}, вокруг оскверненного лунного колодца, занимают культисты, адепты, стражники Совета Теней и их гончие.",
	-- ["From {area:2268}'s flight master, fly to the {area:1497}."] = "От распорядителя полетов ({area:2268}) летите сюда: {area:1497}.",
	-- ["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands visit at about 58."] = "Его следующая охота – на больных гризли (55-56) – подождет визита в Чумные земли примерно на 58 уровне.",
	-- ["Jadefire moonwell"] = "Лунный колодец Нефритового Пламени",
	-- ["Keep Little Pamela: Pamela is in {area:2262}, visited again later."] = "Сохраните задание Малышка Памела: Памела – здесь: {area:2262}, вы вернетесь туда позже.",
	-- ["Keep the branch: {npc:5770} is in {zone:1456}."] = "Сохраните ветвь: {npc:5770} – здесь: {zone:1456}.",
	-- ["Keep the parcel: {npc:10781} is in the {area:1497}."] = "Сохраните посылку: {npc:10781} – здесь: {area:1497}.",
	-- ["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "Сохраните задание {quest:5158}: {npc:5901} – здесь: {zone:1413}.",
	-- ["Keep {quest:6164}: {npc:12384} takes it back on the {zone:1423} guide's {area:2627} stop."] = "Сохраните задание {quest:6164}: {npc:12384} заберет его на остановке «{area:2627}» руководства по краю {zone:1423}.",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "Рыцари и волхвы работают здесь: {area:192}; медики и охотники стоят лагерем к югу.",
	-- ["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "Покиньте город {area:1497} и езжайте на восток по дороге через край {zone:1420}, мимо места {area:152}. Ферма Фелстоунов – первая ферма у дороги; {npc:10778} ждет в доме.",
	-- ["Level 53"] = "Уровень 53",
	-- ["Level 55"] = "Уровень 55",
	-- ["Only with 5 Deadwood Headdress Feathers"] = "Только с 5 перьями ({item:21377})",
	-- ["Radley and Durgen"] = "Рэдли и Дурген",
	-- ["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "Возвращайтесь на юг мимо места {area:1763} к оскверненному лунному колодцу сатиров Нефритового Пламени и наполните там фляжку {npc:9996}.",
	-- ["Ride back south-east to the Sanctuary."] = "Возвращайтесь на юго-восток в Изумрудное святилище.",
	-- ["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "Вернитесь сюда: {area:1497}, садитесь на дирижабль ({zone:1454}) и летите сюда: {area:431}. Езжайте по дороге на запад от Заставы Расщепленного Дерева и на развилке сверните на север в край {zone:1448}.",
	-- ["Ride back west over the river and on to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Езжайте обратно на запад через реку и дальше сюда: {area:192}; {npc:11610} прячется на холме к северо-востоку.",
	-- ["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Езжайте на восток к руинам на побережье. Наполните четыре склянки Карабоса в приливных лужах вдоль берега; между ними патрулируют наги клана Бича Злобы.",
	-- ["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "Езжайте на север вдоль восточных холмов; {npc:1855} живет в маленьком доме у места {area:2619}, на границе с краем {zone:1423}.",
	-- ["Ride north up the road again."] = "Снова езжайте на север по дороге.",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Езжайте на северо-запад в Андорал. {npc:10667} ждет в разрушенной таверне в западной части города; скелеты внутри 54-57 уровня, держитесь окраин.",
	-- ["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "Езжайте на юг мимо места {area:202} сюда: {area:197}; дом {npc:10927} стоит у дороги, а памятник ({npc:10936}) – на кладбище за ним. По пути убивайте больных волков в полях.",
	-- ["Ride the road south through {area:361} to the Sanctuary."] = "Езжайте по дороге на юг через край {area:361} к святилищу.",
	-- ["Ride the road south through {zone:1448} to the Sanctuary."] = "Езжайте по дороге на юг через край {zone:1448} к святилищу.",
	-- ["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Езжайте на запад сюда: {area:192}; {npc:11610} прячется на холме к северо-востоку.",
	-- ["Ror stands at the far south end of {area:1761}."] = "Рор стоит в дальней южной части места {area:1761}.",
	-- ["Scarlet Crusade"] = "Алый орден",
	-- ["Scarlet forward camp"] = "Передовой лагерь Алого ордена",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "Войдите в пещеру: {npc:11558} стоит сразу у входа.",
	-- ["Take the kitten to the same moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Отнесите котенка к тому же лунному колодцу и выпустите его там с помощью предмета {item:12565}; когда он превратится в монстра {npc:10042}, приведите его к {npc:9996} и щелкните по нему, чтобы передать.",
	-- ["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Отнесите котенка к тому же лунному колодцу и выпустите его; когда он превратится в монстра {npc:10042}, приведите его к {npc:9996} и щелкните по нему, чтобы передать.",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Летопись лежит среди затхлых фолиантов ({object:176150}) в ратуше Андорала; открывайте их, пока не найдете нужный.",
	-- ["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "Деревня фурболгов Мертвого Леса чуть к западу от туннеля. {npc:9462} (56) стоит среди них. {npc:11557}, дружелюбный фурболг, сидит в северной части деревни.",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers. Keep killing them until level 53.92: the Sanctuary's next hand-ins and {area:1763} want it. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Деревня фурболгов племени Мертвого Леса – чуть к югу от святилища. Каждое убийство фурболга Мертвого Леса повышает репутацию ({area:1769}); сохраняйте перья из головных уборов. Убивайте их до уровня 53.92: этого требуют следующие задания святилища и {area:1763}. Или с группой пройдите подземелье {area:1417} или {area:1584}.",
	-- ["The Jadefire moonwell"] = "Лунный колодец Нефритового Пламени",
	-- ["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "Сатиры Легаши (51-52) занимают холмы к северу от лагеря эльфов крови: {npc:235903} нужно по пять каждого вида.",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "Палатки Алого ордена стоят между местами {area:199} и {area:200}. Подожгите командную палатку ({object:176092}) и установите знамя Плети.",
	-- ["The bears roam the hills north and east of the {area:202}."] = "Медведи бродят по холмам к северу и востоку от места {area:202}.",
	-- ["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Книга лежит в разрушенной таверне {area:2627}; нежить в городе 54-56 уровня, так что выманивайте их по одному.\nБольшие термитники стоят по всем холмам к востоку от {area:2627}. Используйте {item:15042} на каждом термитнике, мимо которого проходите.",
	-- ["The succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "Суккуб {npc:9518} ждет в центре места {area:1763}, рядом: {npc:11020}.",
	-- ["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "Волки бродят по полям между Андоралом, местом {area:200} и местом {area:202}. Добейте их по пути обратно на восток.",
	-- ["The {area:152}"] = "{area:152}",
	-- ["Through {area:1769}"] = "Через {area:1769}",
	-- ["To {zone:1448}"] = "В край {zone:1448}",
	-- ["Top up here to level 52.63 before the hand-ins at {area:200}: they take you to level 53. The Carrion Lurkers (52-53) west of the Scarlet camp are at your level; the Scarlet Mages and Knights (54-56) are higher. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Наберите здесь уровень 52.63, прежде чем сдавать задания здесь: {area:200}; они поднимут вас до 53-го уровня. Carrion Lurkers (52-53) к западу от лагеря Алого ордена вашего уровня; маги и рыцари Алого ордена (54-56) выше. Или, с группой, пройдите вместо этого подземелье {area:1417} или подземелье {area:2100}.",
	-- ["Top up here to level 53 before {npc:10739} sends you after the Diseased Grizzlies (55-56): the Carrion Lurkers (52-53) on the way from {area:200} to the {area:202} are at your level. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Наберите здесь 53-й уровень, прежде чем {npc:10739} отправит вас за больными гризли (55-56): Carrion Lurkers (52-53) по пути от места {area:200} к месту {area:202} вашего уровня. Или, с группой, пройдите вместо этого подземелье {area:1417} или подземелье {area:1584}.",
	-- ["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "Войдите в туннель ({area:1769}) рядом с персонажем {npc:15395} и не нападайте на фурболгов Древобрюхов внутри. Туннель выходит в край {zone:1452}; езжайте по дороге на восток сюда: {area:2255} – гоблинский город, где начинается следующее руководство.",
	-- ["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "бейте мстителей из племени Мертвого Леса: {area:1762}, {zone:1448}",
	-- ["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "бейте рыцарей из Алого ордена: {area:192}, {zone:1422}",
	-- ["grind on {npc:7157}"] = "Убивайте: {npc:7157}",
	-- ["grind on {npc:8957}"] = "убивайте: {npc:8957}",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "Воины Алого ордена ({area:190}) – 58-60 уровня. Доберитесь до отмеченной на карте высокой точки, осмотрите город и уходите.",
	-- ["{area:2627}: kill these as you meet them"] = "{area:2627}: убивайте их по мере встречи",
	-- ["{item:12565}, at the Jadefire moonwell"] = "{item:12565}, у лунного колодца Нефритового Пламени",
	-- ["{npc:10840}, at the graveyard's south end"] = "{npc:10840}, в южной части кладбища",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw; below ground"] = "{npc:11557}: сохраните для него 30 шт. ({quest:6031}); он торгует только при нейтральном отношении Древобрюхов; под землей",
	-- ["{npc:11558}, at the tunnel mouth"] = "{npc:11558}, у входа в туннель",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: Древобрюхи разговаривают с вами только начиная с уровня «Равнодушие»; ходит здесь: ищите внутри круга на карте",
	-- ["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "Последнее задание {npc:11610} требует 53-го уровня. Рыцари и волхвы из Алого ордена (54-55) на лесопилке чуть к юго-западу от нее – ближайшее место.",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613} стоит к востоку от лесопилки; {npc:11611} охраняет дорогу к северо-востоку от {npc:11610}, в сторону места {area:190}.",
	-- ["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "Охоты от {npc:1855} – здесь: {zone:1423}: сохраните их на потом.",
	-- ["{npc:9529}, just west of the camp"] = "{npc:9529}, чуть к западу от лагеря",
	-- ["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, в западной части святилища",
	-- ["{npc:9996}'s kitten"] = "Котенок {npc:9996}",
	-- ["{npc:9996}: the {quest:86612}"] = "{npc:9996}: {quest:86612}",
	-- ["{object:175894}, beside the house"] = "{object:175894}, у дома",
	-- ["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210} сдается здесь: {area:2268} – сохраните на потом.",
	-- ["{quest:5408}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5408}: нежить ({area:2627}) роняет их, пока на вас надет предмет {item:12846}",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, редкая добыча",
	-- ["{zone:1452}'s quests are 55-58. Below 55 after {npc:9996}'s hand-ins? {area:1762}'s Deadwood furbolgs (53-55) are at your level and on your way north to {area:1769}'s tunnel: kill them until level 55. Every kill also raises your Timbermaw reputation. Careful: the Den Watchers and Avengers call nearby allies once below half health and run off for help when nearly dead: pull one at a time from the village's edge. This is a long top-up for a player who follows only this route. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Задания в зоне {zone:1452} – 55-58 уровня. Ниже 55-го после сдачи заданий {npc:9996}? Фурболги Мертвого Леса (53-55) в месте {area:1762} как раз вашего уровня и по пути на север к туннелю ({area:1769}): убивайте их до 55 уровня. Каждое убийство также повышает репутацию у Древобрюхов. Осторожно: дозорные и мстители зовут союзников, когда у них меньше половины здоровья, и убегают за помощью, когда почти мертвы: выманивайте по одному с края деревни. Для игрока, идущего только по этому маршруту, это долгая прокачка. Или с группой пройдите подземелье {area:1584} или подземелье {area:1417}.",
}
