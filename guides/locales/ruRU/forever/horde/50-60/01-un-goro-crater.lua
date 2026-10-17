-- Russian (ruRU): the guide forever/horde/50-60/01-un-goro-crater (forever/horde/50-60/01-un-goro-crater.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Un'Goro Crater
	-- {zone:1449} Un'Goro Crater
	["Into {zone:1449}"] = "В край {zone:1449}",
	-- {area:1938} Broken Pillar · {zone:1449} Un'Goro Crater · {area:541} Marshal's Refuge
	["From the {area:1938} ride west to the long ramp that winds down into {zone:1449}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "От места {area:1938} езжайте на запад к длинному извилистому спуску в край {zone:1449}, затем вдоль северной стены кратера сюда: {area:541} – лагерь в пещерах скалы. Все здесь нейтральны.",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "Деревянная табличка рядом с {npc:9997}",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave"] = "{npc:9117}, в глубине пещеры",

	-- Step 2: Out of the refuge
	["Out of the refuge"] = "Снаружи лагеря",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, у входа в лагерь",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "{npc:9618}, сразу снаружи",
	-- {quest:3761} Un'Goro Soil
	["From here on pick up every Power Crystal (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "Отсюда собирайте все кристаллы силы (синие, зеленые, красные, желтые) и все кучи земли ({quest:3761}) по пути: всего 25 земли – 20 для Хамуула и 5 для Пестычинса.",

	-- Step 3: Lakkari Tar Pits
	-- {item:11834} Super Sticky Tar
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "Смоляные ямы – чуть к югу от лагеря. {item:11834} падает со смоляных тварей, скрытней и ползунов.",

	-- Step 4: Western jungle
	["Western jungle"] = "Западные джунгли",
	-- {npc:9167} Frenzied Pterrordax
	-- plural, as words: Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Езжайте на юго-запад вдоль западных скал. Над западной частью летают монстры {npc:9167}, а в тех же джунглях растут кровоцветы-звероловы.",

	-- Step 5: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "Стегодоны и равазавры",
	-- {npc:9998} Shizzle · {npc:8659} Jes'rimon
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon."] = "К югу от горячих источников пасутся стегодоны; кости динозавров падают с них или лежат на земле; у деметродонов рядом – чешуя для персонажа {npc:9998}. Равазавры охотятся стаями на юго-западе: их когти – для персонажа {npc:8659}, а иногда с них падает истрепанный дневник (редкая добыча: берите задание, только если он выпадет). Избегайте Граффа – стегодона 57-го уровня.",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}, редкая добыча",
	["Use the Mangled Journal to start it"] = "Используйте истрепанный дневник, чтобы начать задание",

	-- Step 6: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "Потерянное снаряжение экспедиции лежит в юго-западных джунглях.",

	-- Step 7: The Gorishi hive
	["The Gorishi hive"] = "Улей Гориши",
	-- {npc:9166} Pterrordax · {npc:9998} Shizzle
	["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "Улей силитидов занимает юг кратера. С ос и рабочих из улья Гориши падает пахучая железа; используйте склянку для соскобов на кладке яиц в первой камере. Матка улья внизу – элитный босс: не заходите в ее камеру. Монстры {npc:9166} гнездятся на скалах над ульем; их чешуя – для персонажа {npc:9998}.",

	-- Step 8: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "Плот лежит на берегу юго-восточного озера; небольшой рюкзак – в воде рядом.",

	-- Step 9: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619} стоит лагерем в юго-восточном углу кратера.",

	-- Step 10: Fresh Threshadon Carcass
	["North of Torwa, a dead Threshadon lies by the water."] = "К северу от Торвы у воды лежит мертвый жесткозуб.",

	-- Step 12: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "Самки Лар'корви",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "Самки Лар'корви бродят по джунглям к северо-западу от {npc:9619}.",

	-- Step 13: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Сохраните приманку: {npc:9684} – 56-го уровня, а второй круг проходит мимо его логова.",

	-- Step 14: Lashers and Threshers
	["Lashers and Threshers"] = "Хлыстуны и крепкозубы",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Езжайте на север вдоль восточной части. Джунгли полны кровоцветов-хлыстунов и крепкозубов.",

	-- Step 15: Crate of Foodstuffs
	["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "Ящик экспедиции стоит в заброшенном лагере в восточных джунглях.",

	-- Step 16: Gorillas
	["Gorillas"] = "Гориллы",
	-- {npc:9622} U'cha
	["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "Гориллы живут на северо-восточном плато. Не заходите в самую дальнюю пещеру: там живет {npc:9622}.",
	-- {npc:9623} A-Me 01
	["{npc:9623}, the robot on the plateau"] = "{npc:9623}, робот на плато",
	-- {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "Затем {npc:9623} просит предмет {item:10561} (профессия {skill:202}). Пропустите, если его у вас нет.",

	-- Step 17: Bloodpetal Flayers
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer
	["Bloodpetal Flayers"] = "Кровоцветы-живодеры",
	-- {area:537} Fire Plume Ridge
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer
	["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "Езжайте на юго-запад сюда: {area:537} – вулкан в центре кратера. У его подножия растут кровоцветы-живодеры.",

	-- Step 18: Power Crystals and soil
	["Power Crystals and soil"] = "Кристаллы силы и земля",
	-- {area:537} Fire Plume Ridge
	["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "Кристаллы растут по всему кратеру, много – вокруг места {area:537}. Возьмите по несколько лишних каждого цвета для пилонов.",

	-- Step 19: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} сидит на хребте, заблудившийся и обессиленный.",

	-- Step 20: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Сопровождение: {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Ведите персонажа {npc:9999} на север сюда: {area:541}. Когда он падает в обморок, используйте на нем предмет {item:11804}, чтобы привести его в чувство.",

	-- Step 21: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "{npc:9998}, у входа",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "Сохраните задание {quest:4147} ({npc:9118}) и письмо ({npc:8737}) для следующих руководств.",

	-- Step 22: Northern Pylon
	["Northern Pylon"] = "Северный пилон",
	["The pylon stands on the slope east of the refuge."] = "Пилон стоит на склоне к востоку от лагеря.",

	-- Step 23: Eastern Pylon
	["Eastern Pylon"] = "Восточный пилон",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "Спуститесь по восточной части кратера к пилону на восточных скалах.",

	-- Step 24: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "Логово ({npc:9684}) – чуть к югу от пилона. Используйте там приманку {npc:9619}; {npc:9684} – 56-го уровня и бьет сильно, начинайте с полным здоровьем.",

	-- Step 25: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "Теперь {npc:9619} просит шкуру ({npc:9622}) из северо-восточной пещеры: пропустите.",

	-- Step 26: Western Pylon
	["Western Pylon"] = "Западный пилон",
	["Cross the south of the crater to the pylon on the western cliffs."] = "Пересеките юг кратера к пилону на западных скалах.",

	-- Step 27: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "Гоблин {npc:10302} сидит здесь: {area:543}, чуть к востоку от пилона.",

	-- Step 28: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Езжайте на восток сюда: {area:537}, поднимитесь и используйте предмет {npc:10541} у лавового жерла у вершины, затем возвращайтесь на запад к персонажу {npc:10302}.",

	-- Step 29: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} отправляет вас к персонажу {npc:9298} ({zone:1452}): сохраните задание.",

	-- Step 30: J.D. Collie
	-- {area:541} Marshal's Refuge
	["Ride north back to {area:541}."] = "Возвращайтесь на север сюда: {area:541}.",

	-- Step 31: Lakkari Tar Pits
	-- {area:340} Kargath
	-- plural, as words: Tar Lurkers = {npc:6518} Tar Lurker · Tar Lords = {npc:6519} Tar Lord
	["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "Задание Теодоры ({area:340}) требует 52-го уровня. Смоляные скрытни и смоляные господа чуть к югу от лагеря – ближайшее место.",
	-- {area:538} Lakkari Tar Pits · {zone:1449} Un'Goro Crater
	-- plural, as words: Tar Lurkers = {npc:6518} Tar Lurker
	["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "бейте смоляных скрытней: {area:538}, {zone:1449}",

	-- Step 32: Gadgetzan
	-- {npc:10041} Gorishi Hive Queen
	["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "Следующее задание Пестычинса требует убить элитного босса ({npc:10041}). Пропустите.",

	-- Step 33: Orgrimmar
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol · {zone:1458} Undercity
	["Fly to {area:1637} and train before the {object:3202} zeppelin: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "Летите сюда: {area:1637} и обучитесь до дирижабля ({object:3202}): там ({zone:1458}), куда вы попадете позже, нет учителей охотников и шаманов.",

	-- Step 34: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:1637} Orgrimmar · {object:3202} Grom'gol
	["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "Летите сюда: {area:1638}, учитель: {npc:3033} ({area:1639}), затем летите сюда: {area:1637} к дирижаблю ({object:3202}).",

	-- Step 35: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "Летите сюда: {area:340}",
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol · {area:340} Kargath · {zone:1418} Badlands
	["Fly to {area:1637}, take the zeppelin to {object:3202} and fly from there to {area:340}, built into the cliffs on the {zone:1418}' west edge."] = "Летите сюда: {area:1637}, садитесь на дирижабль ({object:3202}) и оттуда летите сюда: {area:340} – крепость в скалах у западного края ({zone:1418}).",

	-- Step 36: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "В край {zone:1427}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {area:254} Blackrock Mountain
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "Через перевал на западе ({area:340}) езжайте в край {zone:1427}, затем на юг через ущелье к длинному мосту ({area:254}). Внутри спускайтесь по цепным мосткам и выходите через южный выход; не сворачивайте к порталам подземелий.",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "Мост: {area:254}",

	-- Step 37: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "Из горы вы выйдете рядом с местом {area:252}, полным орков 55-57 уровня. Езжайте по дороге на восток вдоль северных скал к лагерю Орды ({area:251}).",

	-- Step 38: Black Broodlings
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings"] = "Детеныши черного дракона",
	-- {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Детеныши черного дракона гнездятся на холмах чуть к востоку от места {area:251}. Примените предмет {npc:10267} ({item:12284}) на почти убитом детеныше, чтобы поймать его сущность.",

	-- Step 39: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "Идите вдоль скал на юг сюда: {quest:3821} – холм огров клана Огненного Чрева. Останки ({npc:9136}) лежат у подножия.",

	-- Step 40: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822} бродит по пещерам и штольням ({quest:3821}); если его нет, бейте огров у входов, пока он не вернется.",

	-- Step 41: Thaurissan dig site
	["Thaurissan dig site"] = "Раскопки Тауриссана",
	-- {npc:7039} War Reaver · {quest:4296} Tablet of the Seven
	["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "Езжайте на запад к раскопкам. Големы ({npc:7039}, 53) топчутся вокруг, осколки с них падают часто; табличка ({quest:4296}) стоит в центре среди дворфов Тауриссана. Скопируйте ее.",

	-- Step 42: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "Назад на северо-восток сюда: {area:251}.",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "Сохраните письмо {npc:10267}: {quest:4808} – здесь: {area:2255}, {zone:1452}.",

	-- Step 43: Kargath
	-- {area:1584} Blackrock Depths
	["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "Следующее поручение Теодоры ведет к Лотвилю к востоку от города, а затем сюда: {area:1584}: пропустите.",

	-- Step 44: Undercity
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{npc:10879}, {object:36078}, рядом с распорядителем полетов",
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522}, the {object:36073}"] = "{npc:6522}, {object:36073}",
	-- {npc:8390} Chemist Cuely · {zone:1447} Azshara
	["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "{npc:8390}, Район Фармацевтов: склянки наполните позже ({zone:1447})",

	-- Step 45: The Bulwark
	-- {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "Покиньте город {zone:1458} и езжайте на восток по дороге через край {zone:1420} к {area:152} – форту Отрекшихся на границе.",
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions · {quest:5401} Argent Dawn Commission
	["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "Возьмите {object:176092} из ящика рядом с Деррингтоном для задания {quest:5096} – выполните его на обратном пути. Наденьте {quest:5401}: камни Плети падают, только пока он надет.",

	-- Step 46: Augustus the Touched
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Езжайте по дороге на восток через край {zone:1422} и за реку в край {zone:1423}; сверните на север сюда: {area:2627} – разрушенный город на северо-западе. {npc:12384} сидит в хижине на его краю.",

	-- Step 47: Augustus' Receipt Book
	-- {area:2627} Terrordale
	["The book lies in the ruined inn of {area:2627}."] = "Книга лежит в разрушенной таверне ({area:2627}).",

	-- Step 49: Termite mounds
	["Termite mounds"] = "Термитники",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound
	["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Большие термитники стоят по всем холмам к востоку от места {area:2627}. Используйте предмет {item:15042} на каждом термитнике по пути.",

	-- Step 50: Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "Возвращайтесь на юг к дороге и езжайте по ней на восток через всю зону сюда: {area:2268}.",

	-- Step 51: Darrowshire Spirits
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Darrowshire Spirits"] = "Духи Дарроушира",
	-- {npc:11063} Carlin Redpath · {npc:11064} Darrowshire Spirit · {area:2262} Darrowshire
	["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "Пока у вас есть задание {npc:11063}, после убитых воинов Плети иногда остается {npc:11064}; поговорите с ним, чтобы освободить. Убивайте нежить по пути на юго-запад сюда: {area:2262}.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Освободите духов Дарроушира: поговорите с ними",

	-- Step 52: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "Призрак {npc:10926} стоит в руинах ({area:2262}) на юго-западе.",

	-- Step 53: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "Голова куклы и две ее половины лежат в домах вокруг {npc:10926}; соедините их в сумках.",

	-- Step 54: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: Marlene lives at {area:197} in the {zone:1422}."] = "Сохраните задание {quest:5152}: Марлен живет здесь: {area:197}, {zone:1422}.",

	-- Step 55: Zaeldarr the Outcast
	-- {npc:12250} Zaeldarr the Outcast · {area:2262} Darrowshire
	["{npc:12250} lurks just west of {area:2262}."] = "{npc:12250} прячется чуть к западу от места {area:2262}.",

	-- Step 56: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "Назад: {area:2268}",
	["The next guide starts here, at the chapel's flight master."] = "Следующее руководство начинается здесь, у распорядителя полетов часовни.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "Покиньте город {zone:1458} и езжайте на восток по дороге через край {zone:1420} сюда: {area:152} – форт Отрекшихся на границе.",
}
