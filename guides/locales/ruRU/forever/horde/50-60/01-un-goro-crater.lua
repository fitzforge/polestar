-- Russian (ruRU): the guide forever/horde/50-60/01-un-goro-crater (forever/horde/50-60/01-un-goro-crater.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Into Un'Goro Crater
	-- {zone:1449} Un'Goro Crater
	["Into {zone:1449}"] = "В край {zone:1449}",
	-- {area:1938} Broken Pillar · {zone:1449} Un'Goro Crater · {area:541} Marshal's Refuge
	["From the {area:1938} ride west to the long ramp that winds down into {zone:1449}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "От места {area:1938} езжайте на запад к длинному извилистому спуску в край {zone:1449}, затем вдоль северной стены кратера сюда: {area:541} – лагерь в пещерах скалы. Все здесь нейтральны.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117}, в глубине пещеры; под землей",
	-- {npc:9997} Spraggle Frock · {npc:9167} Frenzied Pterrordax
	["the wooden sign beside {npc:9997}, by the flight master: the {npc:9167} (51-54) come on the pylon loop"] = "деревянная табличка рядом с {npc:9997}, у распорядителя полетов: {npc:9167} (51-54) — на маршруте по пилонам",

	-- Step 3: Out of the refuge
	["Out of the refuge"] = "Снаружи лагеря",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, у входа в лагерь",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "{npc:9618}, сразу снаружи",
	-- {npc:271301} Power Crystal · {quest:3761} Un'Goro Soil · {quest:4496} Bungle in the Jungle
	["From here on pick up every {npc:271301} (blue, green, red, yellow) and every {quest:3761} pile you pass: 20 for Hamuul, and 5 more for Pestlezugg if you carry {quest:4496}."] = "Отсюда собирайте все {npc:271301} (синие, зеленые, красные, желтые) и все кучи земли ({quest:3761}) по пути: 20 для Хамуула и еще 5 для Пестычинса, если у вас есть {quest:4496}.",

	-- Step 4: Lakkari Tar Pits
	-- {item:11834} Super Sticky Tar
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Tar Lords = {npc:6519} Tar Lord
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}. Careful: the Lurkers reach 54 and the Tar Lords stand among them: take the Tar Beasts (50-51) and Creepers (51-52)."] = "Смоляные ямы – чуть к югу от лагеря. {item:11834} падает со смоляных тварей, скрытней и ползунов. Осторожно: скрытни доходят до 54-го уровня, а среди них стоят смоляные господины: бейте смоляных тварей (50-51) и ползунов (51-52).",

	-- Step 5: Level 51
	["Level 51"] = "Уровень 51",
	-- {npc:9166} Pterrordax · {npc:9118} Larion · {area:1417} Sunken Temple · {area:2100} Maraudon
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Bloodpetal Threshers = {npc:6511} Bloodpetal Thresher
	["Top up here to level 51 before the crater's loop: its {npc:9166} and Bloodpetal Flayers are up to level 52. The Bloodpetal Threshers (49-50) on the slopes south-east of the refuge are under your level, and {npc:9118} wants five of them. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Доберите здесь 51-й уровень до маршрута по кратеру: жутедактили ({npc:9166}) и кровоцветы-живодеры там до 52-го уровня. Кровоцветы-крепкозубы (49-50) на склонах к юго-востоку от лагеря ниже вас по уровню, а {npc:9118} просит пятерых из них. Или, с группой, пройдите вместо этого подземелье {area:1417} или {area:2100}.",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "убивайте: {npc:6511}",

	-- Step 6: Pterrordax
	-- {npc:9166} Pterrordax · {npc:9998} Shizzle · {npc:9997} Spraggle Frock · {npc:9167} Frenzied Pterrordax
	["{npc:9166} (50-52) fly over the east of the crater, from the slopes below the refuge southward; their webbed scales are for {npc:9998}, and {npc:9997}'s sign wants ten of them. Leave the {npc:9167} over the west for the pylon loop."] = "Жутедактили ({npc:9166}, 50-52) летают над востоком кратера, от склонов под лагерем на юг; их перепончатая чешуя — для персонажа {npc:9998}, а табличка ({npc:9997}) просит десять из них. Бесноватых жутедактилей ({npc:9167}) над западом оставьте для маршрута по пилонам.",

	-- Step 7: Power Crystals and soil
	-- plural, as words: Power Crystals = {npc:271301} Power Crystal
	["Power Crystals and soil"] = "Кристаллы силы и земля",
	-- {area:537} Fire Plume Ridge
	["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "Кристаллы растут по всему кратеру, много – вокруг места {area:537}. Возьмите по несколько лишних каждого цвета для пилонов.",

	-- Step 8: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}: убивайте их по пути",
	-- {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:8659} Jes'rimon
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Dinosaur Bones = {item:11114} Dinosaur Bone · Elder Diemetradons = {npc:9164} Elder Diemetradon · Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot.\nSouth of the hot springs, Dinosaur Bones lie on the ground among the Stegodons and drop from the Diemetradons nearby, which also carry the scales {npc:9998} wants. Careful: the Stegodons are elites (52-53): pick the bones up around them, don't pull them; the Elder Diemetradons are 53-55, take the smaller ones. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon.\nRide south-west along the western cliffs. Bloodpetal Trappers grow in the jungle there. Careful: the biggest Trappers are 53: pull them one at a time."] = "Езжайте на юго-запад: {area:537}, вулкан в центре кратера. У его подножия растут кровоцветы-живодеры.\nК югу от горячих источников кости динозавров лежат на земле среди стегодонов и падают с деметродонов рядом, у которых также чешуя для персонажа {npc:9998}. Осторожно: стегодоны — элита (52-53): собирайте кости вокруг них, не агрите их; старые деметродоны — 53-55, бейте тех, что поменьше. Равазавры охотятся стаями на юго-западе: их когти – для персонажа {npc:8659}, а иногда с них падает истрепанный дневник (редкая добыча: берите задание, только если он выпадет). Избегайте Граффа – стегодона 57-го уровня.\nЕзжайте на юго-запад вдоль западных утесов. Там в джунглях растут кровоцветы-звероловы. Осторожно: самые крупные звероловы — 53-го уровня: вытягивайте по одному.",

	-- Step 9: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "Потерянное снаряжение экспедиции лежит в юго-западных джунглях.",

	-- Step 10: The Slithering Scar
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd. The Hive Guards (54) and the Queen stand inside the hive: work the Workers and Wasps outside it."] = "Осторожно: рабочие из улья Гориши при здоровье ниже 45% с шансом 50% зовут на помощь союзников в радиусе 25 м. Стражи улья (54) и королева — внутри улья: бейте рабочих и ос снаружи.",

	-- Step 12: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "Стегодоны и равазавры",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}, редкая добыча",
	["Use the Mangled Journal to start it"] = "Используйте истрепанный дневник, чтобы начать задание",
	-- {item:280459} Crystal Infused Scale
	["{item:280459}, a rare drop from the ravasaurs and Diemetradons"] = "{item:280459}, редкая добыча с равазавров и деметродонов",
	-- {quest:87494} Microcrystal Contamination · {npc:9619} Torwa Pathfinder
	["Use the scale to start {quest:87494}, for {npc:9619}"] = "Используйте чешую, чтобы начать {quest:87494}, для NPC {npc:9619}",

	-- Step 13: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619} стоит лагерем в юго-восточном углу кратера.",
	-- {npc:9619} Torwa Pathfinder · {quest:87492} Uncanny Crystal
	["{npc:9619}: {quest:87492}, a short ride west of his camp"] = "{npc:9619}: {quest:87492}, недалеко к западу от его лагеря",
	-- {npc:9619} Torwa Pathfinder · {quest:4289} The Apes of Un'Goro
	["{npc:9619}: {quest:4289}, the gorillas of the north-east plateau on the pylon loop"] = "{npc:9619}: {quest:4289}, гориллы северо-восточного плато на маршруте по пилонам",

	-- Step 14: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {quest:87494} Microcrystal Contamination
	["{npc:9619}: {quest:87494}, if the scale dropped"] = "{npc:9619}: {quest:87494}, если чешуя выпала",

	-- Step 15: Fresh Threshadon Carcass
	-- {item:280417} Damaged Blue Crystal · {npc:9619} Torwa Pathfinder
	["North of Torwa, a dead Threshadon lies by the water. The {item:280417} lies on the ground a short ride west of {npc:9619}'s camp."] = "К северу от Торвы у воды лежит мертвый молотильщик. {item:280417} лежит на земле недалеко к западу от лагеря ({npc:9619}).",

	-- Step 17: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "Самки Лар'корви",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "Самки Лар'корви бродят по джунглям к северо-западу от {npc:9619}.",

	-- Step 18: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "Плот лежит на берегу юго-восточного озера; небольшой рюкзак – в воде рядом.",
	["Underwater"] = "Под водой",

	-- Step 20: Lashers and Threshers
	["Lashers and Threshers"] = "Хлыстуны и крепкозубы",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Езжайте на север вдоль восточной части. Джунгли полны кровоцветов-хлыстунов и крепкозубов.",

	-- Step 21: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "{zone:1449}: убивайте их по пути",
	["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "Ящик экспедиции стоит в заброшенном лагере в восточных джунглях.",

	-- Step 22: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "{npc:9998}, у входа",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, под землей",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "Сохраните задание {quest:4147} ({npc:9118}) и письмо ({npc:8737}) для следующих руководств.",

	-- Step 23: Northern Pylon
	["Northern Pylon"] = "Северный пилон",
	["The pylon stands on the slope east of the refuge."] = "Пилон стоит на склоне к востоку от лагеря.",

	-- Step 24: Gorillas
	["Gorillas"] = "Гориллы",
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas live on the north-east plateau: {npc:9619} wants two pelts of each kind, and the Thunderers (52-53) are the biggest. Stay out of the deepest cave: {npc:9622} lives there."] = "Гориллы живут на северо-восточном плато: {npc:9619} просит по две шкуры каждого вида, громовержцы (52-53) — самые крупные. Не заходите в самую дальнюю пещеру: там живет {npc:9622}.",
	-- {npc:9623} A-Me 01
	["{npc:9623}, the robot on the plateau; below ground"] = "{npc:9623}, робот на плато; под землей",
	-- {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "Затем {npc:9623} просит предмет {item:10561} (профессия {skill:202}). Пропустите, если его у вас нет.",

	-- Step 25: Un'Goro Crater: kill these as you meet them
	-- {spell:8137} Silithid Pox · {spell:14120} Tunneler Acid
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers may call for help within 25 yd when below 45% health; silithids cast {spell:8137} and Tunnelers and the Hive Guard use {spell:14120}."] = "",

	-- Step 26: Eastern Pylon
	["Eastern Pylon"] = "Восточный пилон",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "Спуститесь по восточной части кратера к пилону на восточных скалах.",

	-- Step 27: The Marshlands
	["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time."] = "Осторожно: здесь бродит много равазавров, легко сагрить нескольких сразу.",

	-- Step 28: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {area:1942} The Marshlands
	["{npc:9619}'s camp is in the south-east corner, a short ride from the {area:1942}."] = "Лагерь NPC {npc:9619} находится в юго-восточном углу, недалеко от места {area:1942}.",

	-- Step 30: Western Pylon
	["Western Pylon"] = "Западный пилон",
	["Cross the south of the crater to the pylon on the western cliffs."] = "Пересеките юг кратера к пилону на западных скалах.",

	-- Step 31: Frenzied Pterrordax: kill these as you meet them
	-- {npc:9167} Frenzied Pterrordax
	["{npc:9167}: kill these as you meet them"] = "{npc:9167}: убивайте по пути",
	-- {npc:9167} Frenzied Pterrordax
	["The {npc:9167} fly over the western cliffs around the pylon. Careful: the biggest are 54: pull them one at a time."] = "Жутедактили ({npc:9167}) летают над западными скалами вокруг пилона. Осторожно: самые крупные – 54 уровня, тяните их по одному.",

	-- Step 32: J.D. Collie
	-- {area:541} Marshal's Refuge · {npc:9117} J.D. Collie · {npc:9997} Spraggle Frock
	["Ride north back to {area:541}: {npc:9117} below ground, {npc:9997} beside the flight master."] = "Езжайте на север обратно к месту {area:541}: {npc:9117} под землей, {npc:9997} рядом с распорядителем полетов.",
	-- {npc:9997} Spraggle Frock
	["{npc:9997}, beside the flight master"] = "",
	["Below ground"] = "Под землей",

	-- Step 33: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "В место {area:976}",

	-- Step 34: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn · {area:983} Dunemaul Compound
	["The hearth lands in {area:976}: {npc:11758} takes the {area:983} and Tran'rek Thistleshrub Valley, both done on the way into the crater."] = "Камень возвращения перенесет вас сюда: {area:976}. {npc:11758} принимает задания ({area:983} и долина Колючего Куста Тран'река) – оба выполняются по пути в кратер.",

	-- Step 35: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, внутри",

	-- Step 36: Orgrimmar
	-- {area:1637} Orgrimmar · {area:16727} Powderfuse Port · {zone:1458} Undercity
	["Fly to {area:1637} and train before the boat to {area:16727}: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "Летите сюда: {area:1637} и обучитесь до корабля в {area:16727}: там ({zone:1458}), куда вы попадете позже в этом гайде, нет учителей охотников и шаманов.",

	-- Step 37: Back to Gadgetzan
	-- {area:976} Gadgetzan
	["Back to {area:976}"] = "Назад: {area:976}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 38: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "Корабль: {area:16727}",
	-- {npc:9706} Yorba Screwspigot · {quest:4324} Yuka Screwspigot · {area:251} Flame Crest
	["{npc:9706}, by the dock: for {quest:4324} at {area:251}, later in this guide"] = "",

	-- Step 39: Badlands
	-- {zone:2548} Riverglades · {area:16685} Twilight's Shroud · {zone:1418} Badlands
	["Leave {zone:2548} on foot to the north-west, north of {area:16685}, into the {zone:1418}."] = "",

	-- Step 40: Kargath
	-- {area:340} Kargath · {zone:1418} Badlands
	["{area:340} is built into the cliffs on the {zone:1418}' west edge."] = "{area:340} – крепость в скалах у западного края ({zone:1418}).",

	-- Step 41: The WANTED poster
	-- {object:164867} WANTED
	["The {object:164867} poster"] = "Плакат «{object:164867}»",
	-- {area:1584} Blackrock Depths · {area:254} Blackrock Mountain · {object:164867} WANTED · {area:340} Kargath
	["For your {area:1584} run, next, on the way through {area:254}: the {object:164867} poster in {area:340} wants the Anvilrage dwarves inside thinned out."] = "Для подземелья {area:1584}, далее, по пути через {area:254}: плакат «{object:164867}» ({area:340}) просит проредить дворфов из клана Гнева Наковальни внутри.",

	-- Step 42: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "В край {zone:1427}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {area:254} Blackrock Mountain
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "Через перевал на западе ({area:340}) езжайте в край {zone:1427}, затем на юг через ущелье к длинному мосту ({area:254}). Внутри спускайтесь по цепным мосткам и выходите через южный выход; не сворачивайте к порталам подземелий.",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "Мост: {area:254}",

	-- Step 43: Blackrock Depths
	-- {area:1584} Blackrock Depths · {zone:1428} Burning Steppes
	["{area:1584} is a dungeon for a group of five from about level 48, the biggest in the mountain: its Anvilrage dwarves are this quest's, and you need not go further in than they are. Its portal is deep inside the mountain, down the chain walkways from the bridge.\nInside: the Anvilrage Guardsmen, Wardens and Footmen. Then back out of the portal and on through the mountain's southern exit to the {zone:1428}."] = "{area:1584} – подземелье для группы из пяти игроков примерно с 48-го уровня, самое большое в горе: его дворфы из клана Гнева Наковальни нужны для этого задания, и дальше них заходить не нужно. Его портал – глубоко внутри горы, вниз по цепным мосткам от моста.\nВнутри: стражники, надзиратели и пехотинцы из клана Гнева Наковальни. Затем назад через портал и дальше через южный выход из горы в зону {zone:1428}.",
	-- {quest:4081} KILL ON SIGHT: Dark Iron Dwarves
	["{quest:4081}: the Anvilrage dwarves, inside"] = "{quest:4081}: дворфы из клана Гнева Наковальни, внутри",

	-- Step 44: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "Из горы вы выйдете рядом с местом {area:252}, полным орков 55-57 уровня. Езжайте по дороге на восток вдоль северных скал к лагерю Орды ({area:251}).",

	-- Step 45: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "Идите вдоль скал на юг сюда: {quest:3821} – холм огров клана Огненного Чрева. Останки ({npc:9136}) лежат у подножия.",

	-- Step 46: Sha'ni Proudtusk
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["Only from level 53: her next errand is {quest:3822} (54), who walks the caves of {quest:3821} among ogres of 50-53."] = "Только с 53 уровня: следующее ее поручение – {quest:3822} (54), который бродит по пещерам ({quest:3821}) среди огров 50-53 уровня.",

	-- Step 47: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822} бродит по пещерам и штольням ({quest:3821}); если его нет, бейте огров у входов, пока он не вернется.",

	-- Step 48: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250}: убивайте их по пути",
	-- {quest:4296} Tablet of the Seven · {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900 · {npc:7040} Black Dragonspawn · {npc:7044} Black Drake
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Ride west to the dig site. The {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence.\nCareful: a {npc:7040} and a {npc:7044}, elites of 50-53, wander the same hills: pull the broodlings away from them, or bring a group."] = "Езжайте на запад к раскопкам. Табличка ({quest:4296}) стоит в центре среди дворфов Тауриссана. Скопируйте ее.\nДетеныши черного дракона гнездятся на холмах чуть восточнее места {area:251}. Используйте {item:12284} (от NPC {npc:10267}) на почти мертвом детеныше, чтобы поймать его сущность.\nОсторожно: по тем же холмам бродят {npc:7040} и {npc:7044} – элита 50-53 уровня. Оттягивайте детенышей подальше от них или возьмите группу.",

	-- Step 49: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "Назад на северо-восток сюда: {area:251}.",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "Сохраните письмо {npc:10267}: {quest:4808} – здесь: {area:2255}, {zone:1452}.",

	-- Step 52: Warlord Goretooth
	-- {area:1584} Blackrock Depths · {npc:9077} Warlord Goretooth · {area:340} Kargath
	["The Anvilrage dwarves of your {area:1584} run: {npc:9077}, in {area:340}."] = "Дворфы из клана Гнева Наковальни из подземелья {area:1584}: {npc:9077}, здесь: {area:340}.",

	-- Step 53: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "Летите сюда: {area:1497}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Распорядитель полетов: {area:340}",

	-- Step 54: Harbinger Balthazad
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{npc:10879}, {object:36078}, рядом с распорядителем полетов",

	-- Step 55: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825} стоит здесь: {object:36082}.",

	-- Step 56: Undercity
	-- {npc:8390} Chemist Cuely · {zone:1447} Azshara
	["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "{npc:8390}, Район Фармацевтов: склянки наполните позже ({zone:1447})",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, near Cuely in the Apothecarium"] = "",

	-- Step 58: The Bulwark
	-- {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "Покиньте город {zone:1458} и езжайте на восток по дороге через край {zone:1420} к {area:152} – форту Отрекшихся на границе.",
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions · {quest:5405} Argent Dawn Commission
	["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5405}: Scourgestones only drop while you wear it."] = "Возьмите {object:176092} из ящика рядом с Деррингтоном для задания {quest:5096} – выполните его на обратном пути. Наденьте {quest:5405}: камни Плети падают, только пока он надет.",

	-- Step 59: Scarlet forward camp
	["Scarlet forward camp"] = "Передовой лагерь Алого ордена",
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands · {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "От места {area:152} езжайте по дороге на восток в край {zone:1422}. Палатки Алого ордена стоят сразу за фермой Фелстоунов, между местами {area:199} и {area:200}. Подожгите командную палатку ({object:176092}) и установите знамя Плети. Осторожно: воины Алого ордена у палаток – до 54 уровня, а заклинатели колдуют: заходите со стороны, ближайшей к командной палатке, и не трогайте остальных.",

	-- Step 60: Janice Felstone
	-- {npc:10778} Janice Felstone
	["Back a few steps west to Felstone Farm, the first farm along the road; {npc:10778} waits in the house."] = "Вернитесь немного на запад к ферме Фелстоунов – первой ферме у дороги; {npc:10778} ждет в доме.",
	["Upstairs"] = "Наверху",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house; inside"] = "",
	-- {npc:10781} Royal Overseer Bauhaus · {zone:1458} Undercity · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["Keep the parcel: {npc:10781} is in the {zone:1458}. The next guide starts with {npc:10739} by the {area:202}, south-east of here."] = "Сохраните посылку: {npc:10781} находится в городе {zone:1458}. Следующий гайд начинается с NPC {npc:10739} у места {area:202}, к юго-востоку отсюда.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:2268}"] = "Назад: {area:2268}",
	-- ["Black Broodlings"] = "Детеныши черного дракона",
	-- ["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Детеныши черного дракона гнездятся на холмах чуть к востоку от места {area:251}. Примените предмет {npc:10267} ({item:12284}) на почти убитом детеныше, чтобы поймать его сущность.",
	-- ["Bloodpetal Flayers"] = "Кровоцветы-живодеры",
	-- ["Darrowshire Spirits"] = "Духи Дарроушира",
	-- ["Escort {npc:9999}"] = "Сопровождение: {npc:9999}",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "Летите сюда: {area:1638}, учитель: {npc:3033} ({area:1639}), затем летите сюда: {area:1637} к дирижаблю ({object:3202}).",
	-- ["Fly to {area:272}"] = "Летите сюда: {area:272}",
	-- ["Fly to {area:340}"] = "Летите сюда: {area:340}",
	-- ["Follow the road east through the {area:28} and across the river into the {area:139}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Езжайте по дороге на восток через край {area:28} и за реку в край {area:139}; сверните на север сюда: {area:2627} – разрушенный город на северо-западе. {npc:12384} сидит в хижине на его краю.",
	-- ["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Езжайте по дороге на восток через край {zone:1422} и за реку в край {zone:1423}; сверните на север сюда: {area:2627} – разрушенный город на северо-западе. {npc:12384} сидит в хижине на его краю.",
	-- ["Free Darrowshire Spirits: talk to them"] = "Освободите духов Дарроушира: поговорите с ними",
	-- ["From here on pick up every {npc:271301} (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "Отсюда собирайте все {npc:271301} (синие, зеленые, красные, желтые) и все кучи земли ({quest:3761}) по пути: всего 25 земли – 20 для Хамуула и 5 для Пестычинса.",
	-- ["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "От места {area:152} езжайте по дороге на восток в край {zone:1422}. Палатки Алого ордена стоят сразу за фермой Фелстоунов, между местами {area:199} и {area:200}. Подожгите командную палатку ({object:176092}) и установите знамя Плети.",
	-- ["From the {area:1938} ride west to the long ramp that winds down into {area:490}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "От места {area:1938} езжайте на запад к длинному извилистому спуску в край {area:490}, затем вдоль северной стены кратера сюда: {area:541} – лагерь в пещерах скалы. Все здесь нейтральны.",
	-- ["Gorillas"] = "Гориллы",
	-- ["Inside"] = "Внутри",
	-- ["Into {area:490}"] = "В край {area:490}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Сохраните приманку: {npc:9684} – 56-го уровня, а второй круг проходит мимо его логова.",
	-- ["Keep the parcel: {npc:10781} is in the {zone:1458}. Keep {quest:5901}: its termite mounds are in {area:2627}, on the next guide's ride to Tirion. The next guide starts with {npc:10739} by the {area:202}, south-east of here."] = "Сохраните посылку: {npc:10781} находится здесь: {zone:1458}. Сохраните задание {quest:5901}: его термитники находятся здесь: {area:2627}, по пути к Тириону в следующем руководстве. Следующее руководство начинается с персонажа {npc:10739} у места {area:202}, к юго-востоку отсюда.",
	-- ["Keep {quest:5152}: Marlene lives at {area:197} in the {zone:1422}."] = "Сохраните задание {quest:5152}: Марлен живет здесь: {area:197}, {zone:1422}.",
	-- ["Keep {quest:5901}: its termite mounds are in {area:2627}, on the next guide's ride to Tirion. The next guide starts with {npc:10739} by the {area:202}, south-east of here."] = "Сохраните задание {quest:5901}: его термитники находятся здесь: {area:2627}, по пути к Тириону в следующем руководстве. Следующее руководство начинается с персонажа {npc:10739} у места {area:202}, к юго-востоку отсюда.",
	-- ["Lashers and Threshers"] = "Хлыстуны и крепкозубы",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Ведите персонажа {npc:9999} на север сюда: {area:541}. Когда он падает в обморок, используйте на нем предмет {item:11804}, чтобы привести его в чувство.",
	-- ["Leave the {zone:1458} and ride east along the road through {area:85} to the {area:152}, the Forsaken fort on the border."] = "Покиньте город {zone:1458} и езжайте на восток по дороге через край {area:85} к {area:152} – форту Отрекшихся на границе.",
	-- ["North of Torwa, a dead Threshadon lies by the water."] = "К северу от Торвы у воды лежит мертвый жесткозуб.",
	-- ["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "Следующее задание Пестычинса требует убить элитного босса ({npc:10041}). Пропустите.",
	-- ["Power Crystals and soil"] = "Кристаллы силы и земля",
	-- ["Pterrordax"] = "Жутедактиль",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Езжайте на восток сюда: {area:537}, поднимитесь и используйте предмет {npc:10541} у лавового жерла у вершины, затем возвращайтесь на запад к персонажу {npc:10302}.",
	-- ["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Езжайте на север вдоль восточной части. Джунгли полны кровоцветов-хлыстунов и крепкозубов.",
	-- ["Ride north back to {area:541}."] = "Возвращайтесь на север сюда: {area:541}.",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Езжайте на северо-запад в Андорал. {npc:10667} ждет в разрушенной таверне в западной части города; скелеты внутри 54-57 уровня, держитесь окраин.",
	-- ["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "Возвращайтесь на юг к дороге и езжайте по ней на восток через всю зону сюда: {area:2268}.",
	-- ["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Езжайте на юго-запад вдоль западных скал. Над западной частью летают монстры {npc:9167}, а в тех же джунглях растут кровоцветы-звероловы.",
	-- ["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "Езжайте на юго-запад сюда: {area:537} – вулкан в центре кратера. У его подножия растут кровоцветы-живодеры.",
	-- ["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot.\nSouth of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon.\nRide south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Езжайте на юго-запад: {area:537}, вулкан в центре кратера. У его подножия растут кровоцветы-живодеры.\nК югу от горячих источников пасутся стегодоны; кости динозавров падают с них или лежат на земле; у деметродонов рядом – чешуя для персонажа {npc:9998}. Равазавры охотятся стаями на юго-западе: их когти – для персонажа {npc:8659}, а иногда с них падает истрепанный дневник (редкая добыча: берите задание, только если он выпадет). Избегайте Граффа – стегодона 57-го уровня.\nЕзжайте на юго-запад вдоль западных утесов. Над западной частью летают {npc:9167}, а в тех же джунглях растут кровоцветы-ловцы.",
	-- ["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Езжайте на запад к раскопкам. Големы ({npc:7039}, 53) топчутся вокруг, осколки с них падают часто; табличка ({quest:4296}) стоит в центре среди дворфов Тауриссана. Скопируйте ее.\nЧерные дракончики гнездятся на холмах чуть восточнее места {area:251}. Используйте {item:12284} (от NPC {npc:10267}) на почти мертвом дракончике, чтобы поймать его сущность.",
	-- ["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "Возьмите {object:176092} из ящика рядом с Деррингтоном для задания {quest:5096} – выполните его на обратном пути. Наденьте {quest:5401}: камни Плети падают, только пока он надет.",
	-- ["Termite mounds"] = "Термитники",
	-- ["Thaurissan dig site"] = "Раскопки Тауриссана",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Летопись лежит среди затхлых фолиантов ({object:176150}) в ратуше Андорала; открывайте их, пока не найдете нужный.",
	-- ["The Gorishi hive"] = "Улей Гориши",
	-- ["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Большие термитники стоят по всем холмам к востоку от места {area:2627}. Используйте предмет {item:15042} на каждом термитнике по пути.",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "Палатки Алого ордена стоят между местами {area:199} и {area:200}. Подожгите командную палатку ({object:176092}) и установите знамя Плети.",
	-- ["The book lies in the ruined inn of {area:2627}."] = "Книга лежит в разрушенной таверне ({area:2627}).",
	-- ["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "Голова куклы и две ее половины лежат в домах вокруг {npc:10926}; соедините их в сумках.",
	-- ["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "Ящик экспедиции стоит в заброшенном лагере в восточных джунглях.",
	-- ["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "Гориллы живут на северо-восточном плато. Не заходите в самую дальнюю пещеру: там живет {npc:9622}.",
	-- ["The next guide starts here, at the chapel's flight master."] = "Следующее руководство начинается здесь, у распорядителя полетов часовни.",
	-- ["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "Улей силитидов занимает юг кратера. С ос и рабочих из улья Гориши падает пахучая железа; используйте склянку для соскобов на кладке яиц в первой камере. Матка улья внизу – элитный босс: не заходите в ее камеру. Монстры {npc:9166} гнездятся на скалах над ульем; их чешуя – для персонажа {npc:9998}.",
	-- ["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "Смоляные ямы – чуть к югу от лагеря. {item:11834} падает со смоляных тварей, скрытней и ползунов.",
	-- ["The wooden sign beside {npc:9997}"] = "Деревянная табличка рядом с {npc:9997}",
	-- ["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "Следующее поручение Теодоры ведет к Лотвилю к востоку от города, а затем сюда: {area:1584}: пропустите.",
	-- ["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "Задание Теодоры ({area:340}) требует 52-го уровня. Смоляные скрытни и смоляные господа чуть к югу от лагеря – ближайшее место.",
	-- ["To {area:197}"] = "Сюда: {area:197}",
	-- ["Western jungle"] = "Западные джунгли",
	-- ["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "Пока у вас есть задание {npc:11063}, после убитых воинов Плети иногда остается {npc:11064}; поговорите с ним, чтобы освободить. Убивайте нежить по пути на юго-запад сюда: {area:2262}.",
	-- ["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "бейте смоляных скрытней: {area:538}, {zone:1449}",
	-- ["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} отправляет вас к персонажу {npc:9298} ({zone:1452}): сохраните задание.",
	-- ["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "Гоблин {npc:10302} сидит здесь: {area:543}, чуть к востоку от пилона.",
	-- ["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "Призрак {npc:10926} стоит в руинах ({area:2262}) на юго-западе.",
	-- ["{npc:12250} lurks just west of {area:2262}."] = "{npc:12250} прячется чуть к западу от места {area:2262}.",
	-- ["{npc:6522}, the {object:36073}"] = "{npc:6522}, {object:36073}",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "Теперь {npc:9619} просит шкуру ({npc:9622}) из северо-восточной пещеры: пропустите.",
	-- ["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "Затем {npc:9623} просит предмет {item:10561} (профессия {skill:202}). Пропустите, если его у вас нет.",
	-- ["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "Логово ({npc:9684}) – чуть к югу от пилона. Используйте там приманку {npc:9619}; {npc:9684} – 56-го уровня и бьет сильно, начинайте с полным здоровьем.",
	-- ["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} сидит на хребте, заблудившийся и обессиленный.",
	-- ["{quest:5211}'s spirits come with the {zone:1423} guide's {area:2264} stop: keep it."] = "Духи для задания {quest:5211} будут на остановке {area:2264} в руководстве по краю {zone:1423}: сохраните задание.",
}
