-- Russian (ruRU): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. This first visit keeps to the crater's eastern half, where the beasts are 48-52, so pull them one at a time; the pylons, the bones and the hive wait for the later Un'Goro visit at about 56."] = "Для персонажей 49-50 уровня, но большинство заданий здесь 51-53 уровня: намеренно, ради опыта. Этот первый визит ограничен восточной половиной кратера, где звери 48-52 уровня, так что выманивайте их по одному; пилоны, кости и улей подождут следующего визита в Ун'Горо примерно на 56 уровне.",

	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Летите сюда: {area:150}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Распорядитель полетов ({zone:1455})",

	-- Step 3: Theramore
	["Theramore"] = "",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} стоит на причале, куда прибывает корабль.",

	-- Step 4: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Летите сюда: {area:976}",
	["Theramore flight master"] = "Распорядитель полетов: Терамор",

	-- Step 5: Gadgetzan
	-- {area:976} Gadgetzan
	["The flight from Theramore lands in {area:976}."] = "Полет из Терамора приземляется в городе {area:976}.",

	-- Step 6: Marin Noggenfogger
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Вы пропустили это при прошлом посещении этих мест по маршруту: теперь это идёт первым. Это быстро и открывает следующие задания.",

	-- Step 8: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "Езжайте на запад к улью сентипааров в дюнах. С любого сентипаара могут выпасть части насекомых.\nОсторожно: членистоноги-сентипаары призывают {npc:4196} и в бою, и вне боя – появляются мелкие помощники, которые прерывают вас.",

	-- Step 9: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "Езжайте на юг к лагерю огров. Он полон громил и силовиков (46-48); {npc:12046} (49) стоит в центре с охраной: сначала разберитесь с ней.",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "",

	-- Step 10: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride west into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley.\nCareful: the thistleshrubs wander a lot, so you can easily pull extra mobs."] = "Езжайте на запад к месту {quest:3362}. Железы падают с собирателей росы; полные бывают не всегда, так что берите наполненную. В долине также бродят бугристые шипошкуры и корнеформовщики.\nОсторожно: шипошкуры много бродят, так что легко нацеплять лишних мобов.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back north-east to {area:976}: {npc:11758} stands on the east side of town."] = "Езжайте обратно на северо-восток в {area:976}: {npc:11758} стоит в восточной части города.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 12: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "Езжайте на юг мимо места {area:1938} к месту {area:981} – туннелям Хаззали; снаряжение Холстомера лежит глубоко внутри.\nОсторожно: снаряжение охраняет один жук. По туннелям патрулирует много жуков, некоторые из них 50-го уровня, так что в бою часто привлекаются лишние противники.",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "",

	-- Step 13: Gadgetzan
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus · {zone:1428} Burning Steppes
	["For {npc:7740} in {zone:1457}, at the end of the {zone:1428} guide: keep it"] = "Для NPC {npc:7740} ({zone:1457}), в конце гайда по зоне {zone:1428}: сохраните",

	-- Step 15: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Езжайте на запад из города {area:976} к длинному спуску в зону {zone:1449}. {npc:9619} стоит лагерем у подножия спуска, в юго-восточном углу кратера.",

	-- Step 16: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder · {item:280459} Crystal Infused Scale
	-- plural, as words: Venomhide Ravasaurs = {npc:6508} Venomhide Ravasaur
	["The dead Threshadon lies by the water north of {npc:9619}.\nCareful: Venomhide Ravasaurs (50-51) hunt along the water there: pull them one at a time before you loot the carcass.\nAny ravasaur may drop a {item:280459}: right-click it, {npc:9619} takes it."] = "Мертвый молотильщик лежит у воды к северу от NPC {npc:9619}.\nОсторожно: там у воды охотятся ядовитые равазавры (50-51): выманивайте их по одному, прежде чем обыскать тушу.\nС любого равазавра может выпасть {item:280459}: нажмите на нее правой кнопкой, {npc:9619} ее примет.",

	-- Step 17: Torwa Pathfinder
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale"] = "{quest:87494}, если с равазавра выпала чешуя",
	-- {area:1943} Ironstone Plateau
	["The gorillas on {area:1943} carry the pelts: keep it for the second Un'Goro visit, around 56"] = "Шкуры носят гориллы на плато ({area:1943}): сохраните для второго визита в Ун'Горо, около 56-го уровня",

	-- Step 18: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "Самки Лар'корви и плот",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "Самки Лар'корви рыщут по джунглям к западу от {npc:9619}. Разбитый плот лежит там на берегу озера; маленький рюкзак – в воде рядом с ним. Компас, карту и ключ сохраните для NPC {npc:8737}. С любого зверя в кратере может выпасть {item:11116}: щелкните по нему правой кнопкой.",
	-- {object:161504} A Small Pack
	["{object:161504}, underwater"] = "",

	-- Step 19: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Back east to {npc:9619} with the glands."] = "Обратно на восток к NPC {npc:9619} с железами.",

	-- Step 20: Marshal's Refuge
	-- {npc:271301} Power Crystal · {object:157936} Un'Goro Dirt Pile
	["Ride north-west to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "Езжайте на северо-запад к укрытию.\nОбходите элитных девизавров и стегодонов стороной. Отсюда и дальше подбирайте каждый объект {npc:271301} и каждый объект {object:157936} по пути.",
	-- {npc:9998} Shizzle
	["{npc:9998}: his scales come from the young beasts of the eastern jungle"] = "{npc:9998}: его чешуя падает с молодых зверей восточных джунглей",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737} – в глубине лагеря",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Завершается у NPC {npc:9298} (зона {zone:1452}): сохраните",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117} – в глубине пещеры; под землей",
	-- {npc:9272} Spark Nilminer · {npc:9271} Hol'anyee Marshal · {npc:9270} Williden Marshal · {npc:9618} Karna Remtravel
	["{npc:9272}, {npc:9271}, {npc:9270} and {npc:9618} have quests among mobs of 51-55: leave them for the later Un'Goro visit, at about 56."] = "У NPC {npc:9272}, {npc:9271}, {npc:9270} и {npc:9618} есть задания на мобов 51-55 уровня: оставьте их на следующий визит в Ун'Горо, около 56-го уровня.",

	-- Step 21: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537} и восточные джунгли",
	-- {quest:3764} Un'Goro Soil · {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:9165} Fledgling Pterrordax
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher · Living Blazes = {npc:6521} Living Blaze · Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride east into the eastern jungle: Bloodpetal Lashers and Threshers (48-50) drop the petals and {quest:3764}. Crystal clusters stand all over the crater, many around the foot of {area:537}: take a few extra of each colour.\nCareful: the Living Blazes (54-55) walk the top of {area:537}, and the Bloodpetal Flayers and Trappers (51-53) hold the jungle's south: take your crystals from the ridge's foot and your petals in the north.\n{npc:9998}'s scales: the {npc:9165} (48-50) glide over the north-east of the jungle and the Young Diemetradons (49-50) graze beside them. There are only ten of those: the Diemetradons (51) on the jungle's western edge, a short way west of the Threshers, drop the scales too. They are a level over you: take them one at a time."] = "Езжайте на восток в восточные джунгли: с кровоцветов-хлыстунов и молотильщиков (48-50) падают лепестки и {quest:3764}. Скопления кристаллов есть по всему кратеру, многие – у подножия хребта ({area:537}): возьмите по несколько лишних каждого цвета.\nОсторожно: по вершине хребта ({area:537}) ходят Живые пламена (54-55), а кровоцветы-живодеры и ловцы (51-53) занимают юг джунглей: собирайте кристаллы у подножия хребта, а лепестки – на севере.\nЧешуя для NPC {npc:9998}: {npc:9165} (48-50) парят над северо-востоком джунглей, а рядом пасутся молодые деметродоны (49-50). Их всего десять: деметродоны (51) на западной окраине джунглей, чуть западнее молотильщиков, тоже дают чешую. Они на уровень выше вас: бейте их по одному.",
	-- {item:11316} Bloodpetal
	["{item:11316}, from the Lashers and Threshers"] = "{item:11316} – с хлыстунов и молотильщиков",
	-- {quest:3764} Un'Goro Soil
	["{quest:3764}, from the Threshers and the dirt piles"] = "{quest:3764} – с молотильщиков и из куч земли",

	-- Step 22: Lakkari Tar Pits
	-- plural, as words: Tar Lords = {npc:6519} Tar Lord
	["Crystal clusters stand all over the crater. The pits' Tar Lords (53-54) and the oozes around them (50-54) are over you: take the clusters on the jungle's north-eastern edge, among the Lashers and young beasts (48-50)."] = "Скопления кристаллов есть по всему кратеру. Смоляные господины в ямах (53-54) и слизни вокруг них (50-54) сильнее вас: собирайте кристаллы на северо-восточной окраине джунглей, среди хлыстунов и молодых зверей (48-50).",

	-- Step 23: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "Для NPC {npc:7775} (зона {zone:1444}): сохраните",

	-- Step 24: Level 49.79
	["Level 49.79"] = "",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Still short of level 49.79 after the refuge's hand-ins? Top up on the Bloodpetal Lashers and Threshers (48-50) of the eastern jungle, where you took the petals, before you leave the crater."] = "После сдачи заданий в лагере все еще не хватает до уровня 49.79? Доберите опыт на кровоцветах-хлыстунах и молотильщиках (48-50) в восточных джунглях, где собирали лепестки, прежде чем покинуть кратер.",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "",

	-- Step 25: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",
	-- {zone:1455} Ironforge · {zone:1427} Searing Gorge · {zone:1440} Ashenvale · {zone:1447} Azshara
	["The {zone:1455} quests were taken at the end of the {zone:1427} guide: fly straight on to {zone:1440} for {zone:1447}."] = "Задания из зоны {zone:1455} были взяты в конце гайда по зоне {zone:1427}: летите сразу дальше в зону {zone:1440}, чтобы попасть в зону {zone:1447}.",
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "Распорядитель полетов ({area:541})",

	-- Step 26: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "В таверну: {zone:1455}",

	-- Step 27: Mystic Ward
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}: для Огтинка (зона {zone:1447}), сохраните",
	-- {npc:7312} Dink · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara
	["{npc:7312}, the mage trainer: for {npc:8395} in {zone:1447}, keep it"] = "",

	-- Step 30: Fly to Astranaar
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Archesonus stands beside King Magni in the {object:171709}."] = "Аркессон стоит рядом с королем Магни ({object:171709}).",
	-- ["Below ground"] = "Под землей",
	-- ["Bind and train"] = "Привяжите камень и обучитесь",
	-- ["Bones and equipment"] = "Кости и оборудование",
	-- ["Class trainer"] = "Учитель классовых навыков",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "Пересеките юг кратера и вернитесь к {npc:9619} у спуска.",
	-- ["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Кости динозавров лежат на земле на юго-западе, среди стегодонов: они элитные, поэтому подбирайте кости вокруг них, а остальные добывайте с деметродонов. {item:11112} экспедиции лежит в юго-западных джунглях.",
	-- ["Eastern Pylon"] = "Восточный пилон",
	-- ["Escort {npc:9999}"] = "Сопроводите NPC {npc:9999}",
	-- ["Fly from {area:144} to {area:1537}."] = "Летите из поселка {area:144} в {area:1537}.",
	-- ["Fly to {area:1537}"] = "Лететь в {area:1537}",
	-- ["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. The crater's beasts are 48-55 and the Gorishi silithids 51-54, so pull them one at a time."] = "Для персонажей 49-50 уровня, но большинство заданий здесь 51-53 уровня: намеренно, ради опыта. Звери кратера – 48-55 уровня, силитиды из улья Гориши – 51-54, так что выманивайте их по одному.",
	-- ["Four rune rubbings in {zone:1447}: keep it"] = "Четыре оттиска рун в зоне {zone:1447}: сохраните",
	-- ["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "Из поселка {area:144} летите в {area:150}, сядьте на корабль до Терамора и летите дальше в {area:976}. Первое задание {npc:9619} в кратере требует 48-го уровня: если не хватает, доберите уровень здесь.",
	-- ["Grind to 50"] = "Добейте 50-й уровень",
	-- ["Grind to 51"] = "Добейте 51-й уровень",
	-- ["Gryfe"] = "Грайф",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Отведите NPC {npc:9999} на север: {area:541}. Когда он упадет в обморок, используйте на нем {item:11804}, чтобы привести его в чувство.",
	-- ["Northern Pylon"] = "Северный пилон",
	-- ["Pterrordax"] = "Жутедактиль",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Езжайте по спуску вниз в кратер: {npc:9619} стоит лагерем у его подножия.",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Езжайте на восток: {area:1943}, где робот стоит среди горилл. Не заходите там в глубокую пещеру.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Езжайте на восток к вулкану ({area:537}), поднимитесь на него и используйте {npc:10541} у лавовых отдушин у вершины.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Езжайте на север по восточной стороне к плато горилл. {npc:9622}, горилла 55-го уровня, сидит в самой глубокой пещере: сначала перебейте горилл у входа.",
	-- ["Ride north along the western jungle back to the refuge."] = "Езжайте на север через западные джунгли назад в укрытие.",
	-- ["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Езжайте на север: {area:1943}, где робот стоит среди горилл. Не заходите там в глубокую пещеру.",
	-- ["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "Езжайте на юг вдоль восточных утесов к {npc:9619} у подножия спуска.",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales. The crate sits at the abandoned camp in the eastern jungle."] = "Езжайте на юг по восточной стороне. Молодые деметродоны пасутся в восточных джунглях, а у восточных утесов летает {npc:9165}; с тех и других падает чешуя для NPC {npc:9998}. Ящик стоит в заброшенном лагере в восточных джунглях.",
	-- ["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "Езжайте на юг: {area:537} в середине кратера, затем на восток в восточные джунгли. Скопления кристаллов стоят по всему кратеру, многие – вокруг места {area:537}: возьмите по несколько лишних каждого цвета. Лепестки падают с кровоцветов-хлыстунов и кровоцветов-крепкозубов; {item:11113} экспедиции лежит в заброшенном лагере в восточных джунглях.",
	-- ["Ride west back to the refuge."] = "Езжайте на запад назад в укрытие.",
	-- ["Ride west back to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "Езжайте на запад обратно к укрытию.\nОбходите элитных девизавров и стегодонов стороной. Отсюда и дальше подбирайте каждый объект {npc:271301} и каждый объект {object:157936} по пути.",
	-- ["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "Езжайте от {npc:9619} на запад: улей силитидов занимает юг кратера. Используйте фиал для образцов на инкубаторе – камере со свисающими личинками. С ос и рабочих из улья Гориши падает предмет для задания «{quest:3764}»; если вам еще нужны убийства, на южных утесах гнездится {npc:9166}.",
	-- ["Ride west out of {area:976} to the long ramp down into {area:490}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Езжайте на запад из города {area:976} к длинному спуску в зону {area:490}. {npc:9619} стоит лагерем у подножия спуска, в юго-восточном углу кратера.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Езжайте на запад мимо места {area:541} и на юг по западной стороне: {area:543}. {npc:10302}, гоблин, сидит у воды.",
	-- ["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Пройти {area:1417} вместо убийства монстров в группе быстрее. Пропустите этот шаг, чтобы качаться в одиночку.",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "Пройти {area:978} вместо убийства монстров в группе быстрее. Город троллей лежит на северо-западе зоны {zone:1446}, сразу к северу от города {area:976}.",
	-- ["Still short of level 49.79 after the refuge's hand-ins? Top up on the Pterrordax on the slopes east of {area:541} before you leave the crater."] = "После сдачи заданий в лагере все еще не хватает до уровня 49.79? Доберите опыт на жутедактилях на склонах к востоку от места {area:541}, прежде чем покинуть кратер.",
	-- ["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "Силитиды-сентипаары ползают вокруг улья ({area:982}) на западе зоны {zone:1446}, сразу к востоку от спуска в кратер. Легче всего выманивать рабочих.",
	-- ["The Gorishi hive"] = "Улей Гориши",
	-- ["The dead Threshadon lies by the water north of {npc:9619}."] = "Мертвый жесткозуб лежит у воды к северу от {npc:9619}.",
	-- ["The east side"] = "Восточная сторона",
	-- ["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "Гориллы живут здесь: {area:1943}, к востоку от места {area:541}. Их шкуры сохраните для NPC {npc:9619}. Не заходите в самую глубокую пещеру: {npc:9622} – 55-го уровня.",
	-- ["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "Гориллы на плато ({area:1943}) ходят небольшими группами, и пока с них ничего не падает для вас; задание {npc:9619} на шкуры будет позже. Не заходите в самую глубокую пещеру: {npc:9622} – 55-го уровня.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "Шкуры – после 2-го круга, на плато горилл",
	-- ["The pylon stands on the eastern cliffs."] = "Пилон стоит на восточных утесах.",
	-- ["The pylon stands on the slope east of the refuge. Pterrordax circle the slopes around it: they count for Spraggle and drop {npc:9998}'s scales."] = "Пилон стоит на склоне к востоку от укрытия. Жутедактили кружат над склонами вокруг него, засчитываются для Спраггла и роняют чешую для NPC {npc:9998}.",
	-- ["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "Пилон стоит на западных утесах. {npc:9167}: летают над всей западной стороной.",
	-- ["The relics are in the {zone:1428}: keep it"] = "Реликвии – в зоне {zone:1428}: сохраните",
	-- ["The wooden sign beside {npc:9997}"] = "Деревянная табличка рядом с NPC {npc:9997}",
	-- ["Western Pylon"] = "Западный пилон",
	-- ["Xiggs waits in the {object:32359}."] = "Зиггс ждет здесь: {object:32359}.",
	-- ["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "убивайте Скитальцев Пустыни или огров из клана Песчаного Молота вокруг города {area:976}",
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "убивайте: {npc:5458} ({area:982}, {zone:1446})",
	-- ["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "убивайте: {npc:6514} ({area:1943}, {zone:1449})",
	-- ["{area:978} (optional)"] = "{area:978} (необязательно)",
	-- ["{item:11834} from {npc:6518} and {npc:6519}, 60 yd south"] = "{item:11834}: падает с NPC {npc:6518} и {npc:6519}, в 60 м к югу",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: предыдущий гайд возвращает вас сюда камнем возвращения, так что это обычно отмечается сразу",
	-- ["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: слизни – в зоне {zone:1448}, сохраните",
	-- ["{npc:9618} stands just outside the refuge."] = "{npc:9618} стоит сразу у входа в укрытие.",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Логово зверя {npc:9684} – в джунглях к северу от {npc:9619}, под восточными утесами: используйте там {item:11568}. {npc:9684} – 56-го уровня: начинайте бой с полным здоровьем.",
	-- ["{npc:9997}'s friend {npc:9999} has gone missing."] = "Пропал друг {npc:9997} – {npc:9999}.",
	-- ["{npc:9998}, at the refuge entrance"] = "{npc:9998} – у входа в укрытие",
	-- ["{npc:9998}, at the refuge's entrance"] = "{npc:9998} – у входа в укрытие",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} сидит на юго-восточном склоне вулкана ({area:537}) в середине кратера.",
}
