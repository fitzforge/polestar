-- Russian (ruRU): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Theramore
	["Theramore"] = "Терамор",
	-- {quest:1260} Morgan Stern · {npc:4897} Helenia Olden
	["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "Задание «{quest:1260}» – у таверны; {npc:4897}, поставщица в нескольких шагах к югу, продает специи, которые нужны Ярлу.",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}: для Ярла «Болотного Глаза»",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "Идите по дороге на северо-запад из Терамора к сторожевой башне ({area:503}). По болоту вокруг нее бродят глинистые землеглоты.",

	-- Step 3: Archmage Tervosh
	-- {area:514} Foothold Citadel
	["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "Назад в Терамор: Тервош ждет вместе с леди Джайной в башне ({area:514}).",

	-- Step 4: Swamplight Manor
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house."] = "Идите по дороге на север к разрушенной усадьбе; Ярл живет в лачуге рядом с ней, а рыхлая земля – у угла дома.",
	["with the spices from Theramore"] = "со специями из Терамора",

	-- Step 5: Mudrock tortoises
	["Mudrock tortoises"] = "Глинистые черепахи",
	-- plural, as words: Mudrock Tortoises = {npc:4396} Mudrock Tortoise
	["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "Глинистые черепахи и глинистые колючие черепахи греются на берегу к северо-востоку от усадьбы.",

	-- Step 6: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "«Вонючка» Игнац",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "Вонючка ждет к западу от усадьбы, на болоте под башней ({area:504}). Отведите его к листьям болотного боба и не подпускайте к нему болотных тварей.",

	-- Step 7: North Point Tower
	-- {npc:4966} Private Hendel
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966} удерживает башню с несколькими дезертирами. Он нападет на вас: бейте его, пока он не сдастся.",

	-- Step 8: Darkmist Cavern
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "Пауки Мглистой пещеры гнездятся вокруг пещеры на северо-западе болота; глаза падают с каждого паука.",

	-- Step 9: Mudcrush Durtfeet
	["Ride south to the giant's hut in the middle of the marsh."] = "Езжайте на юг к хижине великана в середине болота.",

	-- Step 10: The Shady Rest Inn
	-- {zone:1413} Barrens
	["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "Сгоревшая таверна стоит у дороги на запад, в сторону зоны {zone:1413}; значок стражника лежит в пепле, а следы копыт – в грязи рядом с таверной.",

	-- Step 11: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "Идите по дороге на восток назад в Терамор. Тервош, леди Джайна и офицеры – в башне ({area:514}).",

	-- Step 12: Mirefin murlocs
	["Mirefin murlocs"] = "Мурлоки из племени Болотного Плавника",
	-- {area:497} Swamplight Manor
	["The Mirefin murlocs crowd the north coast past {area:497}; finish the tongues on the tortoises beside them."] = "Мурлоки из племени Болотного Плавника толпятся на северном побережье за усадьбой ({area:497}); языки добирайте с черепах рядом с ними.",

	-- Step 13: Swamplight Manor
	-- {item:3853} Moonsteel Broadsword
	["only if you carry a {item:3853} (a blacksmith's craft)"] = "только если у вас есть {item:3853} (изготавливает кузнец)",

	-- Step 15: Balos Jacken
	-- {npc:4503} Mudcrush Durtfeet
	["The deserters camp south of the road, west of {npc:4503}'s hut."] = "Дезертиры стоят лагерем к югу от дороги, к западу от хижины {npc:4503}.",

	-- Step 17: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {area:391} Merchant Coast · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "По пути на север в {area:392}: {area:720} лежит у берега ({area:391}) к югу от города, перейдите вброд по отмели. {npc:6236} по одному выпускает против вас четырех соперников, а затем – {npc:6238} (33-й уровень).",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "Победите соперников и NPC {npc:6238}",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236} offers The Windwatcher next (1791): the Whirlwind weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "Затем {npc:6236} предлагает задание «Ветростраж» (1791): цепочка оружия Вихря с элитным противником в конце описана в классовом гайде воина «Оружие Смерча».",

	-- Step 18: Ratchet
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:16227} Bragok · {area:35} Booty Bay
	["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "Езжайте из Терамора на запад по дороге через Пылевые топи в зону {zone:1413} и на север к побережью: {area:392}. Получите маршрут полета у NPC {npc:16227}, затем сядьте на корабль у причала: {area:35}.",
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Корабль: {area:35}",

	-- Step 19: Booty Bay
	-- {object:56910} The Salty Sailor Tavern
	["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910} – высокое здание над гаванью; большинство дающих задания – на его этажах или на причалах внизу.",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}: keep it"] = "для Столи (зона {zone:1446}): сохраните",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773}: для задания «{quest:2864}» (зона {zone:1446}), сохраните",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "для NPC {npc:770} ({area:99}), на северном круге",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487} – верхний этаж",
	["Seahorn's next errand goes back to Arathi: skip it."] = "Следующее поручение Морского Рога ведет обратно в Нагорье Арати: пропустите его.",

	-- Step 20: Bloodsail camp
	["Bloodsail camp"] = "Лагерь шайки Кровавого Паруса",
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks."] = "Выйдите из города через туннель и идите вдоль побережья на север; письмо лежит в лагере шайки Кровавого Паруса на пляже, где ходит «Красавчик» Дункан.",

	-- Step 21: Booty Bay
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624} плавает у северо-западного побережья, на северном круге",

	-- Step 22: Bloodsail pirates
	["Bloodsail pirates"] = "Пираты из шайки Кровавого Паруса",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore · {area:35} Booty Bay
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}."] = "С каждого пирата из шайки Кровавого Паруса падает понюшка, а у одного из них – глаз {npc:2493}; висельники бродят по берегу сразу к северу от города. Карты и приказы лежат в лагере пиратов ({area:43}), к югу от бухты ({area:35}).",

	-- Step 24: The Bloodsail captains
	["The Bloodsail captains"] = "Капитаны шайки Кровавого Паруса",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon
	["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "Капитаны стоят на кораблях, бросивших якорь у берега ({area:43}), у каждого – команда пиратов 42-45-го уровня: Штиллец (45) и Кильватель (46) – на ближних палубах, {npc:2546} (48) – на флагмане. На 42-м уровне это бой для группы или для конца гайда; если пойдете, сначала зачистите каждую палубу. Свиток Кортелло лежит на обломках корабля у берега.",
	-- {zone:1435} Swamp of Sorrows
	["for the {zone:1435} later"] = "для зоны {zone:1435}, позже",

	-- Step 26: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "Наги-исследователи",
	["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "Наги прочесывают пляжи к северу от лагеря шайки Кровавого Паруса; с них падает тростник.",

	-- Step 27: Gorilla hills
	["Gorilla hills"] = "Холмы горилл",
	-- {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "Езжайте вглубь суши к холмам горилл Мглистой долины. Потроха падают со старых горилл из Мглистой долины; среди них сидит {npc:1449}.",

	-- Step 28: Unbagwa's ritual
	["Unbagwa's ritual"] = "Ритуал Унбагвы",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "Сдайте клыки и оставайтесь на месте: придут три волны горилл, последним – {npc:1514}. Бейтесь с полным здоровьем.",

	-- Step 29: Booty Bay
	["Ride back down to town; Shaky stands at the tunnel mouth."] = "Езжайте назад вниз в город; Трусишка стоит у входа в туннель.",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it"] = "для NPC {npc:2616} (Терамор): сохраните",

	-- Step 30: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535} и {npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "Езжайте на север к холмам к западу от дороги. {npc:2535} и {npc:2536} стоят вместе сразу к северу от деревни Занзила.",

	-- Step 31: Zanzil's village
	["Zanzil's village"] = "Деревня Занзила",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Смесь может выпасть с любого последователя Занзила; {npc:2537} ходит в южной части лагеря.",

	-- Step 32: Crystalvein Mine
	-- {area:310} Crystalvein Mine
	["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "Идите по дороге на северо-восток к лагерю Торговой компании ({area:310}); кристаллы падают с шахтеров, геодезистов и штейгеров.",

	-- Step 33: Skullsplitter ruins
	["Skullsplitter ruins"] = "Руины Дробителей Черепов",
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "Тролли из племени Дробителей Черепов занимают руины сразу к востоку от шахты; клыки может уронить любой из них, а их пантеры – всегда.",

	-- Step 34: Cold Eye Basilisks
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["Cold Eye Basilisks"] = "Ледоглазые василиски",
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["The Cold Eye Basilisks lie on the rocks west of the mine."] = "Ледоглазые василиски лежат на скалах к западу от шахты.",

	-- Step 35: The north-west coast
	["The north-west coast"] = "Северо-западное побережье",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "Езжайте от шахты на северо-запад к заливу на северо-западном побережье. На его дне лежат гигантские моллюски с жемчугом; среди них плавает {npc:2624}, с него падает {item:4034}.",

	-- Step 36: Rebel Camp
	-- {npc:217588} Arbor Tarantula
	["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "Езжайте на северо-восток мимо лагеря Эрнестуэя и по дороге на север к лагерю в верхней части долины. По пути в джунглях к юго-востоку от лагеря Эрнестуэя ползает {npc:217588}: поймайте его с помощью набора начинающего энтомолога, затем отметьте.",
	-- {npc:217588} Arbor Tarantula · {quest:93176} My Little Friends
	["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588}: поймайте для задания «{quest:93176}»",

	-- Step 37: Booty Bay
	["MacKinley's next task sends you after elite ogres: skip it."] = "Следующее задание Маккинли отправляет вас к элитным ограм: пропустите его.",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "Следующее поручение {npc:2498} про Занзила начинается в зоне {zone:1441}: пропустите его.",

	-- Step 38: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141} готовит в здании {object:2169}; {npc:5384} – {object:28027}.",
	-- {npc:5694} High Sorcerer Andromath · {area:1438} Nethergarde Keep
	["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694}: для места {area:1438}, сохраните",
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440} – Королевская библиотека ({object:2117})",

	-- Step 39: Riding at 40
	["Riding at 40"] = "Верховая езда на 40-м уровне",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "На 40-м уровне, имея 100 золотых, можно научиться верховой езде, и при обучении вы получите транспорт. {npc:4732} обучает людей ({area:88}, восток зоны {zone:1429}) рядом с лошадьми, которых продает {npc:384}. Возможно, в Forever любая раса может учиться у любого учителя верховой езды (не подтверждено). Все цвета – в разделе «Коллекции», «Транспорт · 40-й уровень».",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384}: другие цвета, 20 з.",

	-- Step 40: Riding at 40
	-- {spell:1285849} Galestrider Riding · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {zone:1453} Stormwind · {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "На 40-м уровне, имея 100 золотых, можно научиться верховой езде, и при обучении вы получите транспорт. Учитель верховой езды для небеснорожденных неизвестен; клиент Forever относит навык «{spell:1285849}» к общему навыку верховой езды, поэтому обучить ему должен {npc:4732} ({area:88}, восток зоны {zone:1429}), ближайший учитель к городу {zone:1453} (не подтверждено). Буреногов продает {npc:265756} ({area:16638}, остров Зефрис); они перечислены в разделе «Коллекции», «Транспорт · 40-й уровень».",
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Буреноги: {npc:265756}, {area:16638} на острове Зефрис.",

	-- Step 41: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "На 40-м уровне, имея 100 золотых, можно научиться верховой езде, и при обучении вы получите транспорт. {npc:4753} обучает ночных эльфов (город {zone:1457}) рядом с саблезубами, которых продает {npc:4730}: корабль ({area:17203} – {area:442}), затем полет в {area:702}. Возможно, в Forever любая раса может учиться у любого учителя верховой езды (не подтверждено), например у NPC {npc:4732} ({area:88}, зона {zone:1429}). Все цвета – в разделе «Коллекции», «Транспорт · 40-й уровень».",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730}: другие цвета, 20 з.",

	-- Step 42: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "Паладин: {quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171} – в Соборе Света",

	-- Step 43: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Чернокнижник: {quest:3631}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461} – {object:2164}: задание примет {npc:6251} ({area:392}) в конце следующего гайда",

	-- Step 44: Watcher Biggs
	-- {area:42} Darkshire · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {npc:5476} Watcher Biggs
	["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "Летите в поселок {area:42} и езжайте на восток через зону {zone:1430} в зону {zone:1435}; {npc:5476} стоит у дороги сразу за границей.",

	-- Step 45: A Soggy Scroll
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "Свиток лежит на болоте к северу от Биггса. С тинобродов к северу от него могут выпасть рассуждения Кадгара.",
	["The riddle's next scroll lies in western Dustwallow: skip it."] = "Следующий свиток загадки лежит на западе Пылевых топей: пропустите его.",

	-- Step 46: The sunken temple
	["The sunken temple"] = "Затонувший храм",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "Езжайте на восток; перевитые ужасы по пути тоже роняют рассуждения. Обыщите край озера ({area:74}), где из воды поднимаются руины храма.",

	-- Step 47: Misty Reed Strand
	["The driftwood washes up along the eastern shore."] = "Плавник выносит на восточный берег.",

	-- Step 48: Watcher Biggs
	-- {npc:217412} Amaryllis Webb
	["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "Езжайте по дороге назад на запад; {npc:217412} стоит немного к северу от Биггса.",
	-- {area:1438} Nethergarde Keep
	["for {area:1438}: keep it"] = "для места {area:1438}: сохраните",
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412}: {quest:93176}, из гайда по Нагорью Арати (30-40)",

	-- Step 49: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "для NPC {npc:5635} ({area:348}): сохраните",

	-- Step 50: Ironforge
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers · {npc:1356} Prospector Stormpike · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern · {area:144} Thelsamar
	["Take the {area:2257} from the {object:28027}. {npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:1356} in the hall itself, {npc:2786} in the {object:32383}. The next guide flies on to {area:144}."] = "В районе {object:28027} сядьте на поезд ({area:2257}). {npc:5637} – в зале Поисковой корпорации у здания {object:32356}, {npc:1356} – в самом зале, {npc:2786} – {object:32383}. Следующий гайд летит дальше: {area:144}.",
	-- {npc:1356} Prospector Stormpike · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356}: для NPC {npc:1344} (зона {zone:1432}), сохраните",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "В городе {zone:1453} нет учителя шаманов",

	-- Step 51: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "На 40-м уровне, имея 100 золотых, можно научиться верховой езде, и при обучении вы получите транспорт. {npc:4772} обучает дворфов ({area:803}, к востоку от поселка {area:131} по дороге в зону {zone:1432}) рядом с баранами, которых продает {npc:1261}. Возможно, в Forever любая раса может учиться у любого учителя верховой езды (не подтверждено). Все цвета – в разделе «Коллекции», «Транспорт · 40-й уровень».",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261}: другие цвета, 20 з.",

	-- Step 52: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "На 40-м уровне, имея 100 золотых, можно научиться верховой езде, и при обучении вы получите транспорт. {npc:7954} обучает гномов ({area:189}, сразу к востоку от поселка {area:131}) рядом с механодолгоногами, которых продает {npc:7955}. Возможно, в Forever любая раса может учиться у любого учителя верховой езды (не подтверждено). Все цвета – в разделе «Коллекции», «Транспорт · 40-й уровень».",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955}: другие цвета, 20 з.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Klannoc offers The Windwatcher next (1791): the {spell:1680} weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "Затем Кланнок предлагает задание «Ветростраж» (1791): цепочка оружия ({spell:1680}) с элитным противником в конце описана в классовом гайде воина «Оружие Смерча».",
}
