-- Russian (ruRU): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {quest:1260} Morgan Stern
	["{quest:1260}, inside"] = "",
	-- {npc:4964} Commander Samaul · {area:514} Foothold Citadel
	["{npc:4964}, on the top floor of {area:514}"] = "",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}: для Ярла «Болотного Глаза»",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "Идите по дороге на северо-запад из Терамора к сторожевой башне ({area:503}). По болоту вокруг нее бродят глинистые землеглоты.",

	-- Step 3: Archmage Tervosh
	-- {area:514} Foothold Citadel
	["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "Назад в Терамор: Тервош ждет вместе с леди Джайной в башне ({area:514}).",
	["Upstairs"] = "",

	-- Step 4: Theramore
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "",
	-- {npc:4794} Morgan Stern · {zone:1435} Swamp of Sorrows
	["{npc:4794}: the crawlers are on the {zone:1435} shore, keep it"] = "",

	-- Step 5: Swamplight Manor
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house. Jarl wants three {quest:1218}: if you passed {npc:4897}, buy them from her in Theramore first."] = "",
	["with the spices from Theramore"] = "со специями из Терамора",

	-- Step 6: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "«Вонючка» Игнац",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "Вонючка ждет к западу от усадьбы, на болоте под башней ({area:504}). Отведите его к листьям болотного боба и не подпускайте к нему болотных тварей.",

	-- Step 7: North Point Tower
	-- {npc:4966} Private Hendel
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields.\nCareful: Hendel has two guards who join the fight when he turns hostile. The guards flee once he surrenders."] = "",

	-- Step 8: Darkmist Cavern
	-- plural, as words: Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "",

	-- Step 9: Mudcrush Durtfeet
	["Ride south to the giant's hut in the middle of the marsh."] = "Езжайте на юг к хижине великана в середине болота.",

	-- Step 10: The Shady Rest Inn
	-- {area:17} Barrens
	["The burned inn stands on the road west, toward the {area:17}; the guard's badge lies in the ashes."] = "",

	-- Step 11: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "Идите по дороге на восток назад в Терамор. Тервош, леди Джайна и офицеры – в башне ({area:514}).",
	-- {npc:4967} Archmage Tervosh
	["{npc:4967}, upstairs"] = "",
	-- {npc:4968} Lady Jaina Proudmoore
	["{npc:4968}, on the top floor"] = "",
	["On the top floor"] = "",
	-- {npc:4948} Adjutant Tesoran
	["{npc:4948}, on the top floor"] = "",

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

	-- Step 18: Foothold Citadel
	-- {npc:4944} Captain Garran Vimes · {area:514} Foothold Citadel
	["The boat leaves from Theramore: report to {npc:4944} on the top floor of {area:514} on the way to the docks."] = "",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "",

	-- Step 19: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Корабль: {area:150}",

	-- Step 20: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Лететь в {zone:1453}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 22: Riding at 40
	["Riding at 40"] = "Верховая езда на 40-м уровне",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "На 40-м уровне, имея 100 золотых, можно научиться верховой езде, и при обучении вы получите транспорт. {npc:4732} обучает людей ({area:88}, восток зоны {zone:1429}) рядом с лошадьми, которых продает {npc:384}. Возможно, в Forever любая раса может учиться у любого учителя верховой езды (не подтверждено). Все цвета – в разделе «Коллекции», «Транспорт · 40-й уровень».",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384}: другие цвета, 20 з.",

	-- Step 23: Riding at 40
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:279} Dalaran
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. Skyborne learn it from {npc:265756}, the stablemaster and riding trainer at the {area:17684} in {area:16638} on Zephras Isle, who also sells the Galestriders: the skyboat to the isle leaves the north side of {area:279} about every five minutes. Collectibles, Mounts · Level 40 lists the Galestriders."] = "",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "",
	-- {area:279} Dalaran
	["Skyboat to Zephras Isle: the north side of {area:279}, about every five minutes."] = "",

	-- Step 24: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Корабль: {area:35}",

	-- Step 45: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Летите: {area:35}",
	-- {area:42} Darkshire
	["{area:42} flight master"] = "",

	-- Step 46: Booty Bay
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "для NPC {npc:770} ({area:99}), на северном круге",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487} – верхний этаж",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the Skullsplitter trolls, on the northern loop"] = "",
	["Inside"] = "Внутри",
	["Seahorn's next errand goes back to Arathi: skip it."] = "Следующее поручение Морского Рога ведет обратно в Нагорье Арати: пропустите его.",
	-- {npc:2542} Catelyn the Blade
	["{npc:2542}, upstairs"] = "",

	-- Step 47: Bloodsail camp
	["Bloodsail camp"] = "Лагерь шайки Кровавого Паруса",
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks."] = "Выйдите из города через туннель и идите вдоль побережья на север; письмо лежит в лагере шайки Кровавого Паруса на пляже, где ходит «Красавчик» Дункан.",

	-- Step 48: Booty Bay
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "",
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624} плавает у северо-западного побережья, на северном круге",

	-- Step 49: Wild Shore: kill these as you meet them
	-- {area:43} Wild Shore
	["{area:43}: kill these as you meet them"] = "",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore · {area:35} Booty Bay
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}."] = "С каждого пирата из шайки Кровавого Паруса падает понюшка, а у одного из них – глаз {npc:2493}; висельники бродят по берегу сразу к северу от города. Карты и приказы лежат в лагере пиратов ({area:43}), к югу от бухты ({area:35}).",

	-- Step 50: Booty Bay
	-- {quest:604} The Bloodsail Buccaneers
	["Seahorn now offers {quest:604}: leave it. Its three captains are level 45-48 with crews around them, and the route brings you back to Seahorn at 48 for it."] = "",

	-- Step 51: Gorilla hills
	["Gorilla hills"] = "Холмы горилл",
	-- {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "Езжайте вглубь суши к холмам горилл Мглистой долины. Потроха падают со старых горилл из Мглистой долины; среди них сидит {npc:1449}.",
	-- {npc:1449} Witch Doctor Unbagwa · {area:1742} Spirit Den
	["{npc:1449}, inside {area:1742}"] = "",

	-- Step 52: Unbagwa's ritual
	["Unbagwa's ritual"] = "Ритуал Унбагвы",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "Сдайте клыки и оставайтесь на месте: придут три волны горилл, последним – {npc:1514}. Бейтесь с полным здоровьем.",

	-- Step 53: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "Наги-исследователи",
	["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "Наги прочесывают пляжи к северу от лагеря шайки Кровавого Паруса; с них падает тростник.",

	-- Step 54: Booty Bay
	["Ride back down to town; Shaky stands at the tunnel mouth."] = "Езжайте назад вниз в город; Трусишка стоит у входа в туннель.",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it"] = "для NPC {npc:2616} (Терамор): сохраните",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}: keep it; on the top floor"] = "",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",

	-- Step 55: The Bloodsail captains
	["The Bloodsail captains"] = "Капитаны шайки Кровавого Паруса",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon
	["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "Капитаны стоят на кораблях, бросивших якорь у берега ({area:43}), у каждого – команда пиратов 42-45-го уровня: Штиллец (45) и Кильватель (46) – на ближних палубах, {npc:2546} (48) – на флагмане. На 42-м уровне это бой для группы или для конца гайда; если пойдете, сначала зачистите каждую палубу. Свиток Кортелло лежит на обломках корабля у берега.",
	-- {zone:1435} Swamp of Sorrows
	["for the {zone:1435} later"] = "для зоны {zone:1435}, позже",

	-- Step 56: Zanzil's village
	["Zanzil's village"] = "Деревня Занзила",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Смесь может выпасть с любого последователя Занзила; {npc:2537} ходит в южной части лагеря.",

	-- Step 57: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535} и {npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "Езжайте на север к холмам к западу от дороги. {npc:2535} и {npc:2536} стоят вместе сразу к северу от деревни Занзила.",

	-- Step 58: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Тропические ловцы",
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers roam the slopes west of the mine."] = "",

	-- Step 59: The north-west coast
	["The north-west coast"] = "Северо-западное побережье",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "Езжайте от шахты на северо-запад к заливу на северо-западном побережье. На его дне лежат гигантские моллюски с жемчугом; среди них плавает {npc:2624}, с него падает {item:4034}.",
	-- {item:4611} Blue Pearl
	["{item:4611}; underwater"] = "",

	-- Step 62: Arbor Tarantula
	-- {npc:217588} Arbor Tarantula · {area:99} Rebel Camp · {npc:217412} Amaryllis Webb
	["An {npc:217588} crawls in the jungle south-east of Nesingwary's camp, on the way to the {area:99}: catch one with the tool from {npc:217412}'s Entomology Starter Kit."] = "",

	-- Step 63: Rebel Camp
	["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale."] = "",

	-- Step 65: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 66: Level 42.16 at Zul'Mamwe
	["Level 42.16 at Zul'Mamwe"] = "",
	-- {npc:737} Kebok · {area:1517} Uldaman
	["Alone, you skip Nesingwary's three elite hunts: take their experience from the Skullsplitter trolls of Zul'Mamwe instead, just east of the mine, so every kill also counts for {npc:737}'s tusks. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {npc:667} Skullsplitter Warrior
	["grind on {npc:667}"] = "",

	-- Step 67: Ruins of Zul'Mamwe: kill these as you meet them
	-- {area:103} Ruins of Zul'Mamwe
	["{area:103}: kill these as you meet them"] = "",
	-- {area:310} Crystalvein Mine
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do.\nFollow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "",

	-- Step 68: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 72: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "",

	-- Step 74: Level 42.16
	["Level 42.16"] = "",
	-- {area:310} Crystalvein Mine · {area:35} Booty Bay · {area:1517} Uldaman
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["Still short of level 42.16 after the hunts you did? Make up the rest on the Cold Eye Basilisks by the {area:310}, on your way south to {area:35}. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {npc:690} Cold Eye Basilisk
	["grind on {npc:690}"] = "",

	-- Step 75: Booty Bay
	-- {area:35} Booty Bay
	["Ride south down the road to {area:35}."] = "",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "Следующее поручение {npc:2498} про Занзила начинается в зоне {zone:1441}: пропустите его.",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	["MacKinley's next task sends you after elite ogres: skip it."] = "Следующее задание Маккинли отправляет вас к элитным ограм: пропустите его.",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773}: для задания «{quest:2864}» (зона {zone:1446}), сохраните",

	-- Step 76: Fly to Stormwind
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 77: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141} готовит в здании {object:2169}; {npc:5384} – {object:28027}.",
	-- {npc:5694} High Sorcerer Andromath · {npc:5464} Watchmaster Sorigal · {area:42} Darkshire
	["{npc:5694}: for {npc:5464} in {area:42}, on the way to the swamp"] = "",

	-- Step 78: Stormwind
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440} – Королевская библиотека ({object:2117})",

	-- Step 80: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "Паладин: {quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171} – в Соборе Света",

	-- Step 81: Stormwind City
	["Stormwind City"] = "Штормград",

	-- Step 82: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Чернокнижник: {quest:3631}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461} – {object:2164}: задание примет {npc:6251} ({area:392}) в конце следующего гайда",

	-- Step 84: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 87: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "На 40-м уровне, имея 100 золотых, можно научиться верховой езде, и при обучении вы получите транспорт. {npc:4753} обучает ночных эльфов (город {zone:1457}) рядом с саблезубами, которых продает {npc:4730}: корабль ({area:17203} – {area:442}), затем полет в {area:702}. Возможно, в Forever любая раса может учиться у любого учителя верховой езды (не подтверждено), например у NPC {npc:4732} ({area:88}, зона {zone:1429}). Все цвета – в разделе «Коллекции», «Транспорт · 40-й уровень».",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730}: другие цвета, 20 з.",

	-- Step 89: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "",

	-- Step 90: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "",

	-- Step 91: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Распорядитель полетов: {zone:1453}",

	-- Step 92: Darkshire
	-- {npc:5464} Watchmaster Sorigal
	["{npc:5464}, by the flight master"] = "{npc:5464}, у распорядителя полетов",

	-- Step 94: Misty Valley
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "Свиток лежит на болоте к северу от Биггса. С тинобродов к северу от него могут выпасть рассуждения Кадгара.",

	-- Step 96: Level 42.46
	["Level 42.46"] = "",
	-- {quest:543} The Perenolde Tiara · {area:1517} Uldaman
	["If you skipped {quest:543}, grind here to level 42.46 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {npc:766} Tangled Horror
	["grind on {npc:766}"] = "",

	-- Step 97: Cortello's Riddle
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412}: {quest:93176}, из гайда по Нагорью Арати (30-40)",

	-- Step 98: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["{npc:5476} stands by the road junction in the west of the swamp."] = "",

	-- Step 99: The sunken temple
	["The sunken temple"] = "Затонувший храм",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "Езжайте на восток; перевитые ужасы по пути тоже роняют рассуждения. Обыщите край озера ({area:74}), где из воды поднимаются руины храма.",

	-- Step 100: Misty Reed Strand
	["The driftwood washes up along the eastern shore."] = "Плавник выносит на восточный берег.",
	-- {item:5938} Pristine Crawler Leg
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler
	["{item:5938}, from the Silt Crawlers on the same shore"] = "",

	-- Step 101: Watcher Biggs
	-- {area:1438} Nethergarde Keep
	["for {area:1438}: keep it"] = "для места {area:1438}: сохраните",

	-- Step 104: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "для NPC {npc:5635} ({area:348}): сохраните",

	-- Step 105: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Поезд до {zone:1455}",

	-- Step 108: Ironforge
	-- {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["{npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:2786} in the {object:32383}."] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "В городе {zone:1453} нет учителя шаманов",

	-- Step 110: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "На 40-м уровне, имея 100 золотых, можно научиться верховой езде, и при обучении вы получите транспорт. {npc:4772} обучает дворфов ({area:803}, к востоку от поселка {area:131} по дороге в зону {zone:1432}) рядом с баранами, которых продает {npc:1261}. Возможно, в Forever любая раса может учиться у любого учителя верховой езды (не подтверждено). Все цвета – в разделе «Коллекции», «Транспорт · 40-й уровень».",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261}: другие цвета, 20 з.",

	-- Step 112: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "На 40-м уровне, имея 100 золотых, можно научиться верховой езде, и при обучении вы получите транспорт. {npc:7954} обучает гномов ({area:189}, сразу к востоку от поселка {area:131}) рядом с механодолгоногами, которых продает {npc:7955}. Возможно, в Forever любая раса может учиться у любого учителя верховой езды (не подтверждено). Все цвета – в разделе «Коллекции», «Транспорт · 40-й уровень».",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955}: другие цвета, 20 з.",

	-- Step 113: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 114: Loch Modan
	-- {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["Ride east out of {zone:1426} through the tunnel into {zone:1432} and on along the road to {area:144}."] = "",

	-- Step 115: Thelsamar
	-- {npc:1470} Ghak Healtouch · {area:144} Thelsamar · {area:1517} Uldaman · {zone:1418} Badlands
	["{npc:1470} is below ground in {area:144}, by the inn. His mushrooms grow in the {area:1517} dig in the {zone:1418}; the next guide takes you there and back through {area:144}."] = "",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "",

	-- Step 117: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Езжайте на юг из зоны {zone:1432} через перевал в зону {zone:1418}; {npc:2860} стоит лагерем у раскопок.",

	-- Step 118: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} стоит лагерем в одиночестве ({area:1898}), к юго-востоку от раскопок.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "На 40-м уровне, имея 100 золотых, можно научиться верховой езде, и при обучении вы получите транспорт. Учитель верховой езды для небеснорожденных неизвестен; клиент Forever относит навык «{spell:1285849}» к общему навыку верховой езды, поэтому обучить ему должен {npc:4732} ({area:88}, восток зоны {zone:1429}), ближайший учитель к городу {zone:1453} (не подтверждено). Буреногов продает {npc:265756} ({area:16638}, остров Зефрис); они перечислены в разделе «Коллекции», «Транспорт · 40-й уровень».",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {area:12}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "На 40-м уровне, имея 100 золотых, можно научиться верховой езде, и при обучении вы получите транспорт. {npc:4732} обучает людей ({area:88}, восток зоны {area:12}) рядом с лошадьми, которых продает {npc:384}. Возможно, в Forever любая раса может учиться у любого учителя верховой езды (не подтверждено). Все цвета – в разделе «Коллекции», «Транспорт · 40-й уровень».",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {area:12}. Collectibles, Mounts · Level 40 lists every colour."] = "На 40-м уровне, имея 100 золотых, можно научиться верховой езде, и при обучении вы получите транспорт. {npc:4753} обучает ночных эльфов (город {zone:1457}) рядом с саблезубами, которых продает {npc:4730}: корабль ({area:17203} – {area:442}), затем полет в {area:702}. Возможно, в Forever любая раса может учиться у любого учителя верховой езды (не подтверждено), например у NPC {npc:4732} ({area:88}, зона {area:12}). Все цвета – в разделе «Коллекции», «Транспорт · 40-й уровень».",
	-- ["Bloodsail pirates"] = "Пираты из шайки Кровавого Паруса",
	-- ["Cold Eye Basilisks"] = "Ледоглазые василиски",
	-- ["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "Летите в поселок {area:42} и езжайте на восток через зону {zone:1430} в зону {zone:1435}; {npc:5476} стоит у дороги сразу за границей.",
	-- ["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "Идите по дороге на северо-восток к лагерю Торговой компании ({area:310}); кристаллы падают с шахтеров, геодезистов и штейгеров.",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Буреноги: {npc:265756}, {area:16638} на острове Зефрис.",
	-- ["Klannoc offers The Windwatcher next (1791): the {spell:1680} weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "Затем Кланнок предлагает задание «Ветростраж» (1791): цепочка оружия ({spell:1680}) с элитным противником в конце описана в классовом гайде воина «Оружие Смерча».",
	-- ["Mudrock tortoises"] = "Глинистые черепахи",
	-- ["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "Езжайте по дороге назад на запад; {npc:217412} стоит немного к северу от Биггса.",
	-- ["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "Езжайте из Терамора на запад по дороге через Пылевые топи в зону {zone:1413} и на север к побережью: {area:392}. Получите маршрут полета у NPC {npc:16227}, затем сядьте на корабль у причала: {area:35}.",
	-- ["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "Езжайте на северо-восток мимо лагеря Эрнестуэя и по дороге на север к лагерю в верхней части долины. По пути в джунглях к юго-востоку от лагеря Эрнестуэя ползает {npc:217588}: поймайте его с помощью набора начинающего энтомолога, затем отметьте.",
	-- ["Ride south out of {zone:1432} through the pass into the {area:3}; {npc:2860} camps at the dig."] = "Езжайте на юг из зоны {zone:1432} через перевал в зону {area:3}; {npc:2860} стоит лагерем у раскопок.",
	-- ["Skullsplitter ruins"] = "Руины Дробителей Черепов",
	-- ["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house."] = "Идите по дороге на север к разрушенной усадьбе; Ярл живет в лачуге рядом с ней, а рыхлая земля – у угла дома.",
	-- ["Take the {area:2257} from the {object:28027}. {npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:1356} in the hall itself, {npc:2786} in the {object:32383}. The next guide flies on to {area:144}."] = "В районе {object:28027} сядьте на поезд ({area:2257}). {npc:5637} – в зале Поисковой корпорации у здания {object:32356}, {npc:1356} – в самом зале, {npc:2786} – {object:32383}. Следующий гайд летит дальше: {area:144}.",
	-- ["The Cold Eye Basilisks lie on the rocks west of the mine."] = "Ледоглазые василиски лежат на скалах к западу от шахты.",
	-- ["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "Пауки Мглистой пещеры гнездятся вокруг пещеры на северо-западе болота; глаза падают с каждого паука.",
	-- ["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "Глинистые черепахи и глинистые колючие черепахи греются на берегу к северо-востоку от усадьбы.",
	-- ["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "Тролли из племени Дробителей Черепов занимают руины сразу к востоку от шахты; клыки может уронить любой из них, а их пантеры – всегда.",
	-- ["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "Сгоревшая таверна стоит у дороги на запад, в сторону зоны {zone:1413}; значок стражника лежит в пепле, а следы копыт – в грязи рядом с таверной.",
	-- ["The riddle's next scroll lies in western Dustwallow: skip it."] = "Следующий свиток загадки лежит на западе Пылевых топей: пропустите его.",
	-- ["for Stoley in {zone:1446}: keep it"] = "для Столи (зона {zone:1446}): сохраните",
	-- ["for the {area:8} later"] = "для зоны {area:8}, позже",
	-- ["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356}: для NPC {npc:1344} (зона {zone:1432}), сохраните",
	-- ["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588}: поймайте для задания «{quest:93176}»",
	-- ["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966} удерживает башню с несколькими дезертирами. Он нападет на вас: бейте его, пока он не сдастся.",
	-- ["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694}: для места {area:1438}, сохраните",
	-- ["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910} – высокое здание над гаванью; большинство дающих задания – на его этажах или на причалах внизу.",
	-- ["{quest:1218}, for \"Swamp Eye\" Jarl"] = "{quest:1218}: для Ярла «Болотного Глаза»",
	-- ["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "Задание «{quest:1260}» – у таверны; {npc:4897}, поставщица в нескольких шагах к югу, продает специи, которые нужны Ярлу.",
}
