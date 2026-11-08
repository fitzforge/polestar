-- Russian (ruRU): the guide forever/horde/30-40/02-stranglethorn-vale (forever/horde/30-40/02-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 2: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "Дирижабль: {object:3202}",

	-- Step 3: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "Летите: {object:3202}",
	["The zeppelin lands at the tower on the west side of the camp."] = "Дирижабль приземляется у башни на западной стороне лагеря.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: для Нагорья Арати, позже по маршруту",

	-- Step 4: Islen Waterseer
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Take the {area:1637} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short walk south of it."] = "",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}: {npc:3527} и ваш {item:5177}",

	-- Step 5: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 7: Nesingwary's camp
	["Nesingwary's camp"] = "Лагерь Эрнестуэя",
	-- {object:3202} Grom'gol · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Идите по дороге на север из места {object:3202}; охотничий лагерь Эрнестуэя — на холме к северо-востоку от реки. С этого момента сохраняйте каждую страницу из книги «{quest:338}»: позже их попросит {npc:716}.",

	-- Step 8: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it.\nHead west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it.\nCareful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "",

	-- Step 9: Booty Bay
	-- {area:35} Booty Bay · {npc:2858} Gringer
	["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "Идите по дороге на юг к месту {area:35} на южной оконечности долины и войдите через туннель в скалах. Не сходите с дороги: джунгли рядом намного выше вашего уровня. {npc:2858}, распорядитель полетов Орды, ждет на верхней палубе.",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	["Upstairs"] = "",

	-- Step 10: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 11: Grom'gol
	-- {npc:2497} Nimboya · {object:3202} Grom'gol
	["{npc:2497} waits in {object:3202}, near the zeppelin tower."] = "",

	-- Step 13: The camp by the river
	["The camp by the river"] = "Лагерь у реки",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "Лагерь пропавших охотников ({npc:773}) — это лагерь Эрнестуэя: пройдите между палатками, и расследование завершится. Речные кроколиски лежат вдоль реки ниже лагеря.",

	-- Step 15: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers and Panthers (32-33) roam the hills east of the camp, along the lake shore."] = "Тигры Тернистой долины и пантеры (32-33) бродят по холмам к востоку от лагеря, вдоль берега озера.",

	-- Step 16: Nesingwary's camp
	-- {object:3202} Grom'gol
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "Тенебрюхие пантеры будут гораздо позже, у объекта {object:3202}",

	-- Step 17: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "Старые тигры и ящеры-кнутохвосты",
	-- {object:3202} Grom'gol
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}.\nCareful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "",

	-- Step 18: Nesingwary's camp
	["Back north to the camp."] = "Обратно на север к лагерю.",

	-- Step 19: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 21: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Летите: {area:35}",
	-- {object:3202} Grom'gol · {area:35} Booty Bay
	["Head south down the coast to {object:3202} and fly to {area:35}."] = "",

	-- Step 23: Stranglethorn Vale: kill these as you meet them
	-- {object:3202} Grom'gol
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Ящеры-кнутохвосты (35-36) охотятся в джунглях чуть северо-восточнее места {object:3202}.",

	-- Step 24: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "К северо-западу от Лагеря Гром'гол под водой у побережья лежит {area:104}. {item:4094} лежит на морском дне у затонувших руин; следите за дыханием и мурлоками.",
	["Underwater"] = "",

	-- Step 25: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "",

	-- Step 26: Grom'gol
	-- {zone:1425} Hinterlands
	["for later: the {zone:1425}, around level 48"] = "",

	-- Step 27: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}.\nCareful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "",

	-- Step 28: Green Hills pages
	["Green Hills pages"] = "Страницы «Зеленых холмов»",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Страницы книги «{item:2755}» падают с шансом около 1% каждая с троллей из племен Кровавого Скальпа и Дробителей Черепов; сохраняйте каждую найденную страницу, а остальные поищите на аукционе. {npc:716} принимает главы позже в этом гайде.",

	-- Step 29: Shadowmaw panthers
	["Shadowmaw panthers"] = "Тенебрюхие пантеры",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Тенебрюхие пантеры (37-38) крадутся по джунглям к востоку от холмов Мош'Огг и на северо-восток к озеру; они нападают из невидимости. Собирайте по пути каждую страницу «Зеленых холмов».",
	-- {npc:684} Shadowmaw Panther
	["grind on {npc:684}"] = "",

	-- Step 30: Venture Co. camp
	["Venture Co. camp"] = "Лагерь Торговой компании",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Head north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "",

	-- Step 31: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "",
	-- {object:3202} Grom'gol
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "",

	-- Step 32: Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}."] = "Вернитесь: {object:3202}.",

	-- Step 33: Level 36
	["Level 36"] = "",
	-- {area:321} Hammerfall
	["Top up here to level 36 before the hand-ins at {area:321}: they take you to level 37."] = "",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {object:3202}"] = "Вернитесь: {object:3202}",
	-- ["Basilisks and the Bloodscalp village"] = "Василиски и деревня Кровавого Скальпа",
	-- ["Bloodscalp headhunters"] = "Охотники за головами из племени Кровавого Скальпа",
	-- ["Bloodscalp ruins"] = "Руины Кровавого Скальпа",
	-- ["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}."] = "К востоку от огров тенебрюхие пантеры (37-38) крадутся незаметно, пока не нападут; там же бродят тигрицы Тернистой долины, иногда роняющие безупречный клык. Кроколиски-хрустогрызы лежат вдоль реки чуть западнее джунглей; сохраните их шкуры для NPC {npc:2495}.",
	-- ["Follow the road north to the camp."] = "Идите по дороге на север к лагерю.",
	-- ["Follow the road on south into {area:35}."] = "Идите по дороге дальше на юг: {area:35}.",
	-- ["Follow the road south to {object:3202}."] = "Идите по дороге на юг: {object:3202}.",
	-- ["Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it."] = "Идите на запад мимо лагеря. Ящеры Тернистой долины (33-34) охотятся на полянах, а тролли из племени Кровавого Скальпа занимают руины на побережье: с любого из них может выпасть бивень. {item:4614} падает с них очень редко: если выпадет, прочтите ее.",
	-- ["Hearth to {area:35}"] = "Используйте Камень возвращения: {area:35}",
	-- ["Hearth to {object:3202}"] = "Используйте Камень возвращения: {object:3202}",
	-- ["Jungle Stalkers"] = "Тропические ловцы",
	-- ["Lashtail raptors"] = "Ящеры-кнутохвосты",
	-- ["Leave the {zone:1458} by the lift and walk up through the ruins to the zeppelin towers; the {object:3202} zeppelin is the one on the south-west tower."] = "Выйдите из города {zone:1458} на лифте и поднимитесь через руины к башням дирижаблей; дирижабль ({object:3202}) — на юго-западной башне.",
	-- ["Mistvale gorillas"] = "Гориллы Мглистой долины",
	-- ["Mosh'Ogg camp"] = "Лагерь Мош'Огг",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; take what drops and check the Auction House for the rest."] = "Страницы книги «{item:2755}» падают с шансом около 1% каждая с троллей из племен Кровавого Скальпа и Дробителей Черепов; берите, что выпадет, а остальное ищите на аукционе.",
	-- ["Raptors and the Bloodscalp trolls"] = "Ящеры и тролли из племени Кровавого Скальпа",
	-- ["Ride back south to {object:3202}."] = "Езжайте обратно на юг: {object:3202}.",
	-- ["Ride north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "Езжайте на север мимо лагеря Эрнестуэя к озеру. Геологи Торговой компании (34-36) работают в лагерях вдоль его западного берега; у них упавшие кристаллы.",
	-- ["Ride south down the coast to {object:3202} and fly to {area:35}."] = "Езжайте на юг вдоль побережья к месту {object:3202} и летите в {area:35}.",
	-- ["Shadowmaw jungle and the Snapjaw river"] = "Джунгли тенебрюхих пантер и река хрустогрызов",
	-- ["Take the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "Идите по дороге на юг к месту {area:35}. Старые гориллы Мглистой долины (40-41) живут здесь: {area:1737}, к востоку от дороги; примерно у одной из двадцати есть старое сухожилие.",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short ride south of it."] = "Летите на дирижабле ({zone:1454}) от башни на западной стороне места {object:3202} и летите в {area:392}. {npc:5901} стоит лагерем на побережье недалеко к югу.",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and train in the city before you fly on."] = "Летите на дирижабле ({zone:1454}) от башни на западной стороне места {object:3202} и обучитесь в городе перед дальнейшим полетом.",
	-- ["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads."] = "Сушеные головы у охотников за головами из племени Кровавого Скальпа (36-37) в деревне на побережье.",
	-- ["The Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "Тролли из племени Кровавого Скальпа занимают руины на побережье к северу от рифа и деревню дальше; с любого может выпасть {item:3915}. Продолжайте собирать страницы из книги «{quest:338}».",
	-- ["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}."] = "Старые тигры Тернистой долины (34-35) бродят по холмам к юго-западу от лагеря; ящеры-кнутохвосты (35-36) охотятся южнее, в сторону места {object:3202}.",
	-- ["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Тропические ловцы (40-41) охотятся на побережье к югу от места {object:3202}. Они намного выше вас: выманивайте по одному и отдыхайте между боями.",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Огры из клана Мош'Огг стоят лагерем на холмах чуть восточнее места {object:3202}. Убейте одного громилу и одного знахаря (36-37); выманивайте по одному.",
	-- ["The next guide flies you north to {area:272} and into the {zone:1417}."] = "Следующий гайд ведет вас на север в {area:272} и в {zone:1417}.",
	-- ["Tigers and panthers"] = "Тигры и пантеры",
	-- ["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear."] = "К западу от лагеря на камнях сидят хрустальные василиски (34-35); с любого тролля из племени Кровавого Скальпа в деревне дальше может выпасть ухо.",
	-- ["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it."] = "Молодые тигры Тернистой долины рыщут к западу от лагеря, молодые пантеры — к югу и востоку.",
	-- ["Young tigers and panthers"] = "Молодые тигры и пантеры",
	-- ["Zeppelin towers"] = "Башни дирижаблей",
	-- ["{npc:2495}: the Snapjaw skins gathered earlier"] = "{npc:2495}: собранные ранее шкуры хрустогрызов",
	-- ["{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp."] = "{npc:729}, тигр 37-го уровня, рыщет на вершине холма к юго-западу от лагеря.",
}
