-- Russian (ruRU): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:814} Southfury River · {area:379} Far Watch Post · {zone:1413} The Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {npc:5810} Uzzek
	["Leave {zone:1454} by the main gate and follow the road south through {zone:1411}, then west over the {area:814} bridge: {area:379} sits just above it on the {zone:1413} side. {npc:3337}, {quest:809} and {npc:5810} stand together."] = "",
	-- {npc:3337} Kargal Battlescar · {quest:840} Conscript of the Horde · {zone:1411} Durotar
	["{npc:3337}: {quest:840}, from {zone:1411}"] = "{npc:3337}: {quest:840}, из зоны {zone:1411}",
	-- {quest:809} Ak'Zeloth · {npc:3337} Kargal Battlescar · {npc:3216} Neeru Fireblade · {zone:1454} Orgrimmar
	["{quest:809}, beside {npc:3337}: from {npc:3216} in {zone:1454}"] = "{quest:809}, рядом с NPC {npc:3337}: от NPC {npc:3216} из города {zone:1454}",

	-- Step 3: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:814} Southfury River · {npc:5810} Uzzek · {area:379} Far Watch Post
	["Leave {zone:1454} by the main gate and follow the road south through {zone:1411}, then west over the {area:814} bridge: {npc:5810} stands at {area:379} just above it, on the road to the Crossroads."] = "Выйдите из города {zone:1454} через главные ворота и идите по дороге на юг через {zone:1411}, затем на запад по мосту через {area:814}: {npc:5810} стоит чуть выше ({area:379}), на дороге к Перекрестку.",

	-- Step 4: The Crossroads
	-- {area:379} Far Watch Post · {npc:3489} Zargh · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger
	["You arrive from {area:379}. {npc:3489} and {npc:3338} stand by the inn, Helbrim and {npc:3464} by the north gate; {npc:3615}, {npc:3429} and {npc:3449} on the tower platform."] = "Вы приходите с заставы {area:379}. {npc:3489} и {npc:3338} стоят у таверны, Хелбрим и {npc:3464} – у северных ворот; {npc:3615}, {npc:3429} и {npc:3449} – на площадке башни.",
	-- {npc:3390} Apothecary Helbrim · {quest:1358} Sample for Helbrim
	["{npc:3390}: {quest:1358}, from Zinge"] = "",
	-- {npc:3615} Devrak
	["{npc:3615}, on the tower"] = "{npc:3615}, на башне",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}: гарпии будут позже – {area:383}",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} стоит лагерем у дороги на восток к месту {area:392}.",

	-- Step 6: Razormane camp
	["Razormane camp"] = "Лагерь Иглогривых",
	-- {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	["The Razormane camp lies east of the Crossroads. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}.\nCareful: The chest stands next to a broken wagon, guarded by a pair of Razormanes, including hunters that can pull more quilboar into the fight."] = "Лагерь Иглогривых находится к востоку от Перекрестка. Воины: {object:58369} стоит в лагере. Шаманы: с кабанолюдов падает {item:5026}.\nОсторожно: сундук стоит рядом со сломанной повозкой, его охраняют двое Иглогривых, включая охотников, которые могут привлечь в бой других кабанолюдов.",

	-- Step 7: Razormane camp: Thork's quilboar
	-- {npc:3429} Thork
	["Razormane camp: {npc:3429}'s quilboar"] = "Лагерь Иглогривых: кабанолюды для NPC {npc:3429}",
	-- {npc:3429} Thork
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["While you are in the camp: {npc:3429}'s Water Seekers and Thornweavers in its western half, the Hunters in the middle, the supply crates at its eastern end.\nCareful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand in the camp's north-east, beside the supply crates: pull the quilboar away from them one at a time."] = "Пока вы в лагере: водоискатели и терноплеты для NPC {npc:3429} – в западной половине, охотники – в середине, ящики с припасами – на восточном краю.\nОсторожно: трупоедки и берсерки из племени Иглогривых (18-19) – элитные противники; они стоят в северо-восточной части лагеря, у ящиков с припасами: выманивайте свинобразов подальше от них по одному.",

	-- Step 9: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["Back east over the bridge and up the trail to {npc:5900}'s shrine again. {npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "Снова на восток через мост и вверх по тропе к святилищу NPC {npc:5900}. {npc:5900} делает из смолы и мешочка предмет {item:6636}. Используйте его у жаровни рядом с ним, чтобы появился {npc:5893}; убейте его ради предмета {item:6655}, затем положите уголек в жаровню.",

	-- Step 11: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, ваш {item:5176} и {item:263412}",

	-- Step 13: The Crossroads
	-- {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3448} Tonga Runetotem
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn: {npc:3338} by the inn, Helbrim and {npc:3464} by the north gate, then up the tower to {npc:3615}, the wind rider master, {npc:3429} and {npc:3449}, and {npc:3448} at the south gate on the way out."] = "",
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, на вершине башни",

	-- Step 14: Raptor Heads as you go
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Raptor Heads as you go"] = "Головы ящеров по пути",
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Sunscale raptors roam the plains north and east of the Crossroads, and about three in four drop a head: kill the ones you pass on the way. Careful: Sunscale Screechers call nearby allies within 30 yd once below 30% health."] = "Яркочешуйчатые ящеры бродят по равнинам к северу и востоку от Перекрестка, примерно с трех из четырех падает голова: убивайте встречных по пути. Осторожно: яркочешуйчатые крикуны при здоровье ниже 30% зовут союзников в радиусе 30 м.",

	-- Step 15: Plainstrider Beaks as you go
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Plainstrider Beaks as you go"] = "Клювы долгоногов по пути",
	-- {zone:1413} The Barrens
	["Plainstriders roam the plains all over the {zone:1413}, and about one in four drops a beak: kill the ones you pass on the way."] = "Долгоноги бродят по всей зоне {zone:1413}, примерно с каждого четвертого падает клюв: убивайте встречных по пути.",

	-- Step 16: Razormane camp
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end.\nPlainstriders here count toward the beaks.\nCareful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand in the camp's north-east, beside the supply crates: pull the quilboar away from them one at a time."] = "В лагере водоискатели и терноплеты держат западную половину, охотники – середину; ящики с припасами стоят на восточном краю.\nДолгоноги здесь тоже дают клювы.\nОсторожно: трупоедки и берсерки из племени Иглогривых (18-19) – элитные противники; они стоят в северо-восточной части лагеря, у ящиков с припасами: выманивайте свинобразов подальше от них по одному.",

	-- Step 17: Finish the Plainstrider Beaks
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Finish the Plainstrider Beaks"] = "Доберите клювы долгоногов",
	["Still short of seven? Plainstriders are thickest on the plains north of the Crossroads, along the road north."] = "Не хватает до семи? Больше всего долгоногов на равнинах к северу от Перекрестка, вдоль дороги на север.",

	-- Step 19: The Zhevra
	-- {area:392} Ratchet
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze along the road east toward {area:392}: take their hooves on the way out."] = "Жевры-бегуны пасутся вдоль дороги на восток к месту {area:392}: соберите копыта по пути.",

	-- Step 20: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Идите по дороге на юго-восток: {area:392} на побережье.",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}, на втором этаже",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}: пульт управления – {area:382}, позже",
	-- {npc:16227} Bragok · {npc:3442} Sputtervalve
	["{npc:16227}, beside {npc:3442}"] = "{npc:16227} – рядом с NPC {npc:3442}",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "Плакат: {object:3972}",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, на причале",
	-- {quest:1492} Wharfmaster Dizzywig · {area:381} Boulder Lode Mine
	["{quest:1492}: the emerald comes from the {area:381}, later"] = "",

	-- Step 21: The Barrens: kill these as you meet them
	-- {zone:1413} The Barrens
	["{zone:1413}: kill these as you meet them"] = "",
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}: the piles of complicated parts lie in the sand among them, and {npc:3467} stands at the camp's southern end."] = "Пираты разбили лагерь на пляже к югу от поселения {area:392}: груды сложных деталей лежат в песке среди них, а {npc:3467} стоит в южном конце лагеря.",

	-- Step 22: Ratchet
	-- {npc:3391} Gazlowe · {area:385} Northwatch Hold
	["{npc:3391}: the crates lie at the south end of the beach camp, on the walk to {area:385} at 18"] = "",

	-- Step 23: Fly to Crossroads
	["Fly to Crossroads"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 25: Gur'ak
	-- {npc:267310} Gur'ak · {quest:97003} Chol'aruk the Ravener · {npc:267307} Chol'aruk · {area:1699} Thorn Hill · {npc:3438} Kreenig Snarlsnout
	["{npc:267310} stands on the north-east side of the Crossroads. {quest:97003} is a group quest: {npc:267307} is a level 20 elite boar in the Razormane's {area:1699} cave, east of the town, where the route goes back for {npc:3438} later."] = "{npc:267310} стоит в северо-восточной части Перекрестка. {quest:97003} – групповое задание: {npc:267307} – элитный вепрь 20-го уровня в пещере Иглогривых ({area:1699}) к востоку от городка, куда маршрут позже вернется за NPC {npc:3438}.",

	-- Step 26: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["West to {npc:3389}'s watch post on the Kolkar border."] = "На запад к сторожевому посту NPC {npc:3389} на границе с Колкар.",

	-- Step 27: The Barrens: kill these as you meet them
	-- {npc:3389} Regthar Deathgate · {npc:3394} Barak Kodobane
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers. {npc:3394} stands in the Kolkar camp west of the pools."] = "Пруды – сразу к северу от NPC {npc:3389}. Зайдите в воду, чтобы исследовать их; спелые грибы для Хелбрима растут вокруг. Убивайте всех встречных Колкар ради наручей. {npc:3394} стоит в лагере Колкар к западу от прудов.",

	-- Step 28: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis
	["{npc:3389}: {npc:3395} walks with the Kolkar at the {area:388}, later"] = "{npc:3389}: {npc:3395} ходит с Колкар у места {area:388}, позже",

	-- Step 29: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg · {npc:3389} Regthar Deathgate
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler · Witchwing Ambushers = {npc:3279} Witchwing Ambusher
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills. Savannah Prowlers hunt the plains between {npc:3389} and the hills: take their claws on the way.\nCareful: There are 2 Witchwing Ambushers (level 17-18). They stay stealthed with Sneak while out of combat."] = "На запад: {area:383}. Гарпии из стаи Зачарованного Крыла гнездятся повсюду; коготь может упасть с любой. {quest:819} лежит в этих холмах. Хищники саванны охотятся на равнинах между NPC {npc:3389} и холмами: соберите их когти по пути.\nОсторожно: здесь 2 засадницы из стаи Зачарованного Крыла (уровень 17-18). Вне боя они скрыты незаметностью.",

	-- Step 30: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it.\nCareful: Several guards stand within aggro range of the valves, respawn in under about 3 minutes, and run at low health to bring back help; nearby mobs also join if you use a valve while they are close."] = "{object:4141} стоит на исследовательской площадке Торговой компании к западу от места {area:382}. Закройте три вентиля вокруг бура, снова используйте пульт, затем заберите {item:5089} у NPC {npc:3471} рядом.\nОсторожно: несколько стражей стоят в зоне агрессии у вентилей, возрождаются менее чем через 3 минуты и при малом здоровье убегают за подмогой; ближайшие противники тоже вмешиваются, если вы используете вентиль рядом с ними.",
	["Inside"] = "Внутри",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: on the next {area:392} stop"] = "{npc:3442} ({area:392}): при следующей остановке там ({area:392})",

	-- Step 31: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout · {npc:267307} Chol'aruk · {area:1699} Thorn Hill
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them. Careful: Razormane Flesheaters and Berserkers (18-19) are elites in the camp's north-east, near {npc:3438} and the supply crates, and {npc:267307} (20, elite) lies in the cave under {area:1699} beside them: pull {npc:3438} and the quilboar away from them one at a time, and leave the cave alone unless you are in a group."] = "Назад в лагерь Иглогривых. Геоманты и защитники держат его восточную половину; среди них ходит {npc:3438}. Осторожно: трупоедки и берсерки из племени Иглогривых (18-19) – элитные противники в северо-восточной части лагеря, рядом с NPC {npc:3438} и ящиками с припасами, а в пещере под местом {area:1699} рядом с ними лежит {npc:267307} (20, элитный): выманивайте {npc:3438} и свинобразов подальше от них по одному и не трогайте пещеру, если вы не в группе.",

	-- Step 32: Chol'aruk
	-- {npc:267307} Chol'aruk · {area:1699} Thorn Hill
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:267307} (level 20 elite) needs a group of 3 and sits deep in the cave under {area:1699}, past the Razormane Flesheaters and Berserkers (18-19, elite). Skip it if you are alone."] = "Это элитные противники: лучше собраться в группу, поищите, с кем пойти. {npc:267307} (элитный, 20-й уровень) требует группы из 3 человек и сидит в глубине пещеры под местом {area:1699}, за трупоедками и берсерками из племени Иглогривых (18-19, элитные). Если вы один, пропустите это.",

	-- Step 33: The Crossroads
	-- {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3432} Mankrik · {npc:3448} Tonga Runetotem · {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {area:383} Dry Hills · {quest:853} Apothecary Zamah · {zone:1456} Thunder Bluff
	["{npc:3338} by the inn first, then Helbrim by the north gate, {npc:3429} and {npc:3449} on the tower platform, {npc:3432} by the inn, and {npc:3448} at the south gate last. His seed test waits for the {npc:3395} pass at the {area:388}: go straight on north-west to the {area:383}. After the spores Helbrim offers {quest:853}, a delivery to {zone:1456} within 45 minutes: this route doesn't go there, so leave it (Druids take it on the next Crossroads stop, right before their flight to {zone:1456})."] = "Сначала {npc:3338} у таверны, затем Хелбрим у северных ворот, {npc:3429} и {npc:3449} на площадке башни, {npc:3432} у таверны и последним – {npc:3448} у южных ворот. Его проверка семян подождет до похода к NPC {npc:3395} ({area:388}): идите прямо на северо-запад сюда: {area:383}. После спор Хелбрим предлагает задание {quest:853} – доставку в {zone:1456} за 45 минут: этот маршрут туда не идет, так что не берите его (друиды берут его при следующем заходе на Перекресток, прямо перед полетом в {zone:1456}).",
	-- {npc:3432} Mankrik
	["{npc:3432}: his wife lies at the north edge of the Bristleback camps, later"] = "",
	-- {npc:3448} Tonga Runetotem · {area:388} Stagnant Oasis · {npc:3395} Verog the Dervish
	["{npc:3448}: the bubbling fissure at the {area:388}, on the {npc:3395} pass"] = "{npc:3448}: бурлящая расщелина ({area:388}), по пути к NPC {npc:3395}",

	-- Step 35: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["North-west to the {area:383}: the Witchwing Slayers hold their western end; they wear the rings.\nCareful: Some stealthed harpy ambushers wait in the area and stay hidden until you get close. A level 19 elite harpy also patrols there."] = "На северо-запад: {area:383}; душегубки из стаи Зачарованного Крыла держат западный край; кольца – у них.\nОсторожно: в округе прячутся невидимые гарпии-засадницы, они не видны, пока вы не подойдете близко. Там же патрулирует гарпия-элита 19 уровня.",

	-- Step 37: Raptor Horns
	-- {quest:881} Echeyakee · {area:383} Dry Hills · {item:5055} Intact Raptor Horn · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["On the way east to {quest:881}: Sunscale Scytheclaws prowl the plains east of the {area:383}; any of them can drop an {item:5055} for {npc:3446} in {area:392}."] = "По пути на восток к {quest:881}: яркочешуйчатые смертехваты рыщут по равнинам к востоку от места {area:383}; с любого может упасть {item:5055} для NPC {npc:3446} ({area:392}).",

	-- Step 38: Echeyakee
	-- {quest:881} Echeyakee
	["South-east on the way back to the Crossroads: {quest:881}, a white lion, prowls the plains north of the Razormane camp.\nCareful: Savannah Huntresses roam around the lair. They respawn quickly and often join the fight alongside {quest:881}, so clear them out before you blow the horn.\nSunscale raptors here count toward the heads."] = "На юго-восток, по пути обратно к Перекрестку: {quest:881}, белый лев, рыщет по равнинам к северу от лагеря Иглогривых.\nОсторожно: вокруг логова бродят охотницы саванны. Они быстро возрождаются и часто вступают в бой вместе с {quest:881}, так что перебейте их, прежде чем трубить в рог.\nЯркочешуйчатые ящеры здесь тоже дают головы.",

	-- Step 39: Finish the Raptor Heads
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Finish the Raptor Heads"] = "Доберите головы ящеров",
	-- {quest:881} Echeyakee
	-- plural, as words: Sunscale Lashtails = {npc:3254} Sunscale Lashtail
	["Still short of twelve? Sunscale Lashtails and Screechers roam the plains north-east of the Crossroads, on the way back south from {quest:881}'s lair."] = "",

	-- Step 40: The Crossroads
	-- {npc:3464} Gazrog · {npc:3338} Sergra Darkthorn · {npc:3449} Darsok Swiftdagger · {npc:3429} Thork
	["In from the north gate: {npc:3464} first, {npc:3338} by the inn, then up to {npc:3449} and {npc:3429} on the tower platform, where the flight master stands."] = "Войдите через северные ворота: сначала {npc:3464}, {npc:3338} у таверны, затем поднимитесь к NPC {npc:3449} и {npc:3429} на площадку башни, где стоит распорядитель полетов.",
	-- {npc:3464} Gazrog · {quest:3281} Stolen Silver · {area:385} Northwatch Hold
	["{npc:3464}: the {quest:3281}, in a raptor nest north-west of {area:385}"] = "",
	-- {npc:3390} Apothecary Helbrim · {zone:1456} Thunder Bluff
	["{npc:3390}: 45 minutes, for Zamah on the {zone:1456} step next"] = "{npc:3390}: 45 минут, для Замы на следующем шаге ({zone:1456})",
	-- {npc:3338} Sergra Darkthorn
	["{npc:3338}: the raptor nests south of the Crossroads"] = "",
	-- {npc:3449} Darsok Swiftdagger · {quest:876} Serena Bloodfeather · {area:383} Dry Hills
	["{npc:3449}, on the tower: {quest:876} leads the harpies in the {area:383}"] = "",
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}, on the tower, from level 17. Keep it: Kadrak at the {area:1703}, next guide"] = "",

	-- Step 41: Thunder Bluff
	-- {area:1638} Thunder Bluff · {quest:853} Apothecary Zamah · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from the Crossroads to {area:1638}. {quest:853} waits in the {area:2197}, the cave under {area:1640}: hand in the spores there first, while their time runs. Then {npc:3033} trains you on {area:1639}."] = "Летите с Перекрестка сюда: {area:1638}. {quest:853} ждет в пещере под возвышенностью {area:1640} ({area:2197}): сначала сдайте там споры, пока не вышло время. Затем {npc:3033} обучит вас здесь: {area:1639}.",
	-- {quest:853} Apothecary Zamah · {area:2197} Pools of Vision
	["{quest:853}, in the {area:2197}"] = "{quest:853} ({area:2197})",

	-- Step 42: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "",

	-- Step 43: Trial of the Lake
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {quest:28} Trial of the Lake
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}. {quest:28} runs on a timer: no teleport or Hearthstone until {npc:11799} has it."] = "{npc:11802} стоит наверху в своем здании – {area:2361}: поднимитесь внутри, стрелка не различает этажи. Безделушки из святилища лежат на дне: {area:656} – и исчезают за несколько минут: плывите с одной прямо к месту {area:2362} на северо-западном берегу, используйте ее там и поговорите с NPC {npc:11799}. У задания {quest:28} есть таймер: никаких телепортов и Камня возвращения, пока его не примет {npc:11799}.",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127}: {area:384}, следующий гайд",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}: из объекта {object:177785} в озере",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}, {area:2362}",
	-- {quest:30} Trial of the Sea Lion · {area:382} Sludge Fen · {area:287} Hillsbrad
	["{quest:30}, carried: one half pendant in the {area:382} in this guide, the other underwater off Silverpine on the way to {area:287} at 21; the pendant is handed in after {area:287}"] = "",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798} ({area:2361}) отправляет туда друидов по воздуху",

	-- Step 44: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",
	-- {zone:1456} Thunder Bluff · {area:392} Ratchet
	["Fly from {zone:1456} straight on to {area:392}."] = "Летите из города {zone:1456} прямо сюда: {area:392}.",

	-- Step 45: Fly to Ratchet
	["Crossroads flight master"] = "",

	-- Step 47: Ratchet
	-- {npc:3446} Mebok Mizzyrix · {object:3972} WANTED · {area:392} Ratchet
	["{npc:3446}, beside the {object:3972} poster: take it now if he did not offer it on the first {area:392} stop"] = "",

	-- Step 48: Ratchet
	-- {npc:3446} Mebok Mizzyrix · {object:3972} WANTED
	["{npc:3446}, beside the {object:3972} poster"] = "{npc:3446}, рядом с плакатом ({object:3972})",

	-- Step 49: Mebok Mizzyrix
	-- {area:718} Wailing Caverns · {npc:3446} Mebok Mizzyrix · {quest:1491} Smart Drinks
	["For your {area:718} run: {npc:3446}'s next errand, {quest:1491}."] = "Для подземелья {area:718}: следующее поручение NPC {npc:3446} – {quest:1491}.",

	-- Step 51: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks · {area:1076} Webwinder Path
	["{npc:3442}: keep it, {quest:1483} is on the {area:1076} in Stonetalon, at the end of this guide"] = "",
	-- {npc:3442} Sputtervalve · {npc:9316} Wenikee Boltbucket · {area:382} Sludge Fen
	["{npc:3442}: {npc:9316} stands on the road north of the Crossroads, on the way to the {area:382}"] = "",

	-- Step 52: Bruuz
	-- {npc:209797} Bruuz
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:209797} (level 20 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 53: Ratchet
	-- {npc:3391} Gazlowe
	["{npc:3391} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 54: Raptor nests
	["Raptor nests"] = "Гнезда ящеров",
	-- {area:392} Ratchet · {area:1697} Raptor Grounds · {item:5165} Sunscale Feather
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["South-west from {area:392} across the plains to the {area:1697}: the three nests sit together south-west of the oasis, and Sunscale Scytheclaws guard them. Each nest needs a {item:5165}: kill Sunscale raptors (most drop one) until you have three, then use a feather at each nest."] = "На юго-запад от места {area:392} через равнины. Цель: {area:1697}. Три гнезда находятся рядом к юго-западу от оазиса, их охраняют яркочешуйчатые смертехваты. Для каждого гнезда нужен предмет {item:5165}: убивайте яркочешуйчатых ящеров (с большинства он падает), пока не наберете три, затем используйте перо у каждого гнезда.",

	-- Step 55: Raptor Grounds: kill these as you meet them
	-- {area:1697} Raptor Grounds
	["{area:1697}: kill these as you meet them"] = "",
	-- {area:1697} Raptor Grounds · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet · {area:385} Northwatch Hold
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains around the {area:1697}; they drop the horns. {npc:3446} takes them when the escort brings you back to {area:392}.\nSouth-east toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "",

	-- Step 56: Stolen Booty
	-- {area:385} Northwatch Hold
	["East to the beach, at the south end of the pirate camp: the crate of boots and the fragile crate with the lens sit there, a short walk north of {area:385}."] = "На восток к пляжу, у южного края лагеря пиратов: там стоят ящик с сапогами и хрупкий ящик с линзой, недалеко к северу от места {area:385}.",

	-- Step 57: Northwatch Hold: kill these as you meet them
	-- {area:385} Northwatch Hold
	["{area:385}: kill these as you meet them"] = "",
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["{area:385}, on the coast just south of the pirate camp. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now.\nCareful: Each named target is linked to a healer and guards, and Fairmount has three extra marines with her. Killing the healer first makes the fight easier."] = "",
	["On the top floor"] = "",
	["Upstairs"] = "Наверху",

	-- Step 58: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} закован в цепи внутри крепости. Поговорите с ним, чтобы начать сопровождение, и держитесь рядом: на выходе нападут солдаты Терамора. Он доведет вас обратно. Цель: {area:392}.",

	-- Step 66: Dreadmist Peak
	-- {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Head north from the Crossroads to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the Crossroads. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449}: продает {npc:3490}; травники собирают на равнинах",

	-- Step 67: Kolkar camp
	["Kolkar camp"] = "Лагерь Колкар",
	-- {npc:3389} Regthar Deathgate · {item:2449} Earthroot
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["Lost Barrens Kodos roam the plains around the Kolkar camp north-west of {npc:3389}; herbalists pick {item:2449} there too."] = "Потерявшиеся степные кодо бродят по равнинам вокруг лагеря Колкар к северо-западу от {npc:3389}; травники там же собирают {item:2449}.",

	-- Step 68: Vrang Wildgore
	-- {area:383} Dry Hills · {npc:3682} Vrang Wildgore · {npc:261366} Walton
	["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "На север. Цель: {area:383}. {npc:3682} стоит лагерем под холмами; у отшельника на гребне за ним ({npc:261366}) найдется работа, только когда {npc:3682} отправит вас наверх.",

	-- Step 69: The Barrens: kill these as you meet them
	-- {quest:876} Serena Bloodfeather
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west.\nCareful: The route in passes stealthed Harpy Ambushers and an elite harpy that patrols."] = "",
	-- {quest:865} Raptor Horns
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["{quest:865}, if still open: Sunscale Scytheclaws prowl among the lions"] = "",

	-- Step 72: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}. The marines are linked: pulling one calls the rest. Pull from the edge and run; they leash short, so you can thin the camp one at a time before tackling the Corporal."] = "",

	-- Step 73: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Помогите NPC {npc:261366}: держитесь рядом, когда на гребень поднимутся {npc:261367} и солдаты ({area:21})",

	-- Step 74: Wenikee Boltbucket
	-- {npc:261366} Walton · {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["East from {npc:261366} toward the {area:382}: {npc:9316} stands at the camp on the road north of the Crossroads."] = "На восток от NPC {npc:261366} к месту {area:382}: {npc:9316} стоит в лагере на дороге к северу от Перекрестка.",

	-- Step 75: Ignition
	-- {npc:3439} Wizzlecrank's Shredder · {area:382} Sludge Fen · {npc:3445} Supervisor Lugwizzle
	["{npc:3439} stands inside the Venture Co. camp in the {area:382}; {npc:3445} carries the key."] = "",

	-- Step 76: Strange Lockbox
	-- {object:177794} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177794} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177794} лежит у северного края места {area:382}, у башни Торговой компании. В нем – {item:15883} для задания {quest:30}.",

	-- Step 77: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}.\nCareful: The route leads west and climbs a ramp. Once you reach the top, two Venture Company mobs ambush you."] = "",

	-- Step 78: Nugget Slugs
	-- {area:382} Sludge Fen
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}."] = "Ведра с инструментами и слизнями лежат вокруг буровой площадки Торговой компании ({area:382}).",

	-- Step 79: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "{item:5097} падает с надзирателей и головорезов Торговой компании у рудника в северо-восточном углу зоны.",

	-- Step 80: Wenikee Boltbucket
	-- {npc:9316} Wenikee Boltbucket
	["West from the mine to {npc:9316}'s camp, then south down the road to the Crossroads."] = "",
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Keep it: {quest:3923} is in {zone:1454}'s {object:172958}, on the {zone:1454} trip at 20"] = "",

	-- Step 81: the Crossroads
	["the Crossroads"] = "",
	-- {npc:3449} Darsok Swiftdagger · {npc:3448} Tonga Runetotem
	["South down the road to the Crossroads: {npc:3449} stands on the tower platform, {npc:3448} at the south gate."] = "",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "Он даст вам {item:15826}",

	-- Step 82: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {npc:3448} Tonga Runetotem
	["{npc:3395} walks among the Kolkar at the {area:388} south-east of the Crossroads. Test {npc:3448}'s seeds at the bubbling fissure on the oasis' east bank while you are there."] = "{npc:3395} ходит среди Колкар у места {area:388} к юго-востоку от Перекрестка. Раз уж вы там, проверьте семена NPC {npc:3448} у бурлящей расщелины на восточном берегу оазиса.",
	["Underwater"] = "",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the Crossroads"] = "",
	-- {npc:12296} Sickly Gazelle
	["Cure {npc:12296}"] = "",

	-- Step 83: Bristleback camps
	["Bristleback camps"] = "Лагеря Дыбогривых",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {npc:3430} Mangletooth · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. {npc:3432}'s wife lies at their north edge, on your way south. Leave the quilboar for now: {npc:3430} in {area:378} wants the same camps cleared. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "",

	-- Step 84: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "Идите по дороге ({area:458}) на юг. Цель: {area:378}.",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, в клетке",

	-- Step 85: Bramblescar
	-- {npc:3432} Mankrik · {npc:3430} Mangletooth · {item:5075} Blood Shard
	["Back north into the Bristleback camps. Any Bristleback can drop a tusk for {npc:3432}, so collect them while you kill these for {npc:3430}. Keep one {item:5075}."] = "",

	-- Step 88: The Crossroads
	-- {area:458} Gold Road · {npc:3448} Tonga Runetotem · {npc:3432} Mankrik · {npc:3428} Korran · {item:5075} Blood Shard · {npc:3430} Mangletooth · {area:378} Camp Taurajo
	["North up the {area:458} to the Crossroads: {npc:3448} at the south gate, {npc:3432} by the inn, {npc:3428} west of the north gate. Keep the {item:5075}: {npc:3430} takes it on the next stop in {area:378}."] = "На север по дороге ({area:458}) к Перекрестку: {npc:3448} – у южных ворот, {npc:3432} – у таверны, {npc:3428} – к западу от северных ворот. Сохраните {item:5075}: {npc:3430} примет его при следующем заходе сюда: {area:378}.",
	-- {npc:3448} Tonga Runetotem · {area:387} Lushwater Oasis · {npc:3396} Hezrul Bloodmark · {zone:1454} Orgrimmar
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["{npc:3448}: the Oasis Snapjaws at {area:387}, with {npc:3396} after the {zone:1454} trip"] = "{npc:3448}: оазисные хрустогрызы – {area:387}, вместе с NPC {npc:3396} после поездки в {zone:1454}",
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} предложит {quest:95774}, когда будет сдано задание {quest:4921}",
	-- {npc:3428} Korran · {area:390} Field of Giants · {area:378} Camp Taurajo · {zone:1454} Orgrimmar
	["{npc:3428}: the eggs are in the {area:390}, south of {area:378}, after the {zone:1454} trip"] = "",

	-- Step 89: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:1637} Orgrimmar · {npc:3615} Devrak
	["Train your level 20 ranks in {area:1637} now: fly from {npc:3615} on the Crossroads' tower."] = "",

	-- Step 90: Orgrimmar
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "",

	-- Step 91: Valley of Honor
	-- {quest:3923} Rilli Greasygob · {object:172958} Valley of Honor
	["{quest:3923} stands by the {object:172958}'s water, east of the Drag."] = "",

	-- Step 92: Shenthul
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382} on the next guide's walk north"] = "",

	-- Step 93: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Классовые задания: {zone:1454}",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} – {object:172961}, на западе города.",

	-- Step 94: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960} – ущелье под местом {object:172982}.",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}, в нескольких шагах",

	-- Step 95: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} стоит здесь: {object:172961}, в западной части города.",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}: {npc:4606} ({zone:1458}), через два гайда",

	-- Step 97: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["Train your level 20 ranks: {npc:246344} teaches Paladins in {area:1638}; {zone:1454} has no Paladin trainer. You have no flight path there yet: fly to {area:378}, head west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "",

	-- Step 99: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:499} Cat Form · {spell:526} Cure Poison · {zone:1450} Moonglade · {npc:11798} Bunthen Plainswind · {area:392} Ratchet
	["Fly from the Crossroads to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}. {spell:499} and {spell:526} follow in {zone:1450} on the same trip, then {npc:11798} flies you back here and on to {area:392}."] = "",

	-- Step 100: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "Примените {spell:18960}. {npc:11802} стоит наверху в своем доме, здесь: {area:2361}. Поднимитесь внутри: стрелка не различает этажи.",

	-- Step 102: Moonglade
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802} стоит на верхнем этаже своего здания ({area:2361}): поднимитесь внутри, стрелка не различает этажи.",

	-- Step 103: Moonglade
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}: приветствие от {npc:3033}",

	-- Step 104: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	-- plural, as words: Territorial Terrans = {npc:230558} Territorial Terran
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. Careful: the spirits are Territorial Terrans (level 60) that kill whoever they see: stay off their paths, and click the statue again before the stealth runs out."] = "Таурены: {npc:11957} ждет на южном холме над мостом. Небеснорожденные: {npc:272054} стоит к югу от двух мостов. Затем – логова к востоку от озера: выйдите из облика, щелкните по статуе у входа, чтобы получить пять минут незаметности, держитесь подальше от духов внутри и возьмите по одной реликвии каждого вида; {item:280680} лежит у подножия статуи белой кошки. Осторожно: духи – это территориальные терраны (60-й уровень), которые убивают всех, кого видят: держитесь подальше от их путей и щелкните по статуе снова, прежде чем незаметность закончится.",

	-- Step 107: Fly to Ratchet
	-- {zone:1456} Thunder Bluff · {area:392} Ratchet
	["Fly from {zone:1456} on to {area:392}."] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 108: Fly to Ratchet
	-- {area:392} Ratchet · {object:172982} Valley of Strength
	["Fly on to {area:392} from Doras on the tower in the {object:172982}."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 110: Ratchet: Wailing Caverns quests
	-- {area:392} Ratchet · {area:718} Wailing Caverns
	["{area:392}: {area:718} quests"] = "{area:392}: задания ({area:718})",
	-- {area:718} Wailing Caverns · {npc:3446} Mebok Mizzyrix · {object:3972} WANTED · {npc:3665} Crane Operator Bigglefuzz · {npc:3396} Hezrul Bloodmark
	["Your {area:718} quests, if you have not taken them yet: {npc:3446} beside the {object:3972} poster, {npc:3665} on the dock by the flight master. The run is later in this guide, after {npc:3396}."] = "Ваши задания для подземелья {area:718}, если вы их еще не взяли: {npc:3446} – рядом с плакатом «{object:3972}», {npc:3665} – на причале у распорядителя полетов. Поход – позже в этом гайде, после NPC {npc:3396}.",

	-- Step 111: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} ждет на холме к югу (ориентир: {area:392}), по пути на север.",

	-- Step 112: Ishamuhale
	-- {quest:882} Ishamuhale · {item:10338} Fresh Zhevra Carcass · {object:147538} Dead Tree (no name in this language: may be words) · {area:392} Ratchet
	["{quest:882}, a big Sunscale raptor, only comes to a fresh kill: loot a {item:10338} from a zhevra, then use it at the {object:147538} north-west of {area:392}, north of the road to the Crossroads, and be ready when he arrives."] = "",
	-- {item:10338} Fresh Zhevra Carcass
	-- plural, as words: Zhevra Chargers = {npc:3426} Zhevra Charger
	["{item:10338}, from any zhevra; Zhevra Chargers graze around the tree"] = "",
	-- {object:147538} Dead Tree (no name in this language: may be words) · {quest:882} Ishamuhale
	["At the {object:147538}: summons {quest:882}"] = "",

	-- Step 113: Gazrog
	-- {npc:3464} Gazrog
	["{npc:3464}, by the Crossroads' north gate"] = "",

	-- Step 116: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} живет здесь: {area:2539} – деревня троллей сразу на входе в Когтистые горы, в конце дороги на запад от {npc:3389}.",

	-- Step 117: To Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["To {npc:3389}"] = "",

	-- Step 119: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate · {npc:3448} Tonga Runetotem
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. He walks that shore, from about 46,36 in the north to 46,42 in the south: if he isn't at the arrow, follow the shore until you meet him. Hand his head to {npc:3389} on your last Crossroads stop. Oasis Snapjaws crawl in the oasis' water there: their shells are for {npc:3448}."] = "{npc:3396} ведет Колкар на западном берегу ({area:387}), к югу от NPC {npc:3389}. Он ходит вдоль этого берега, примерно от 46,36 на севере до 46,42 на юге: если его нет там, куда указывает стрелка, идите вдоль берега, пока не встретите его. Отдайте его голову NPC {npc:3389} при последнем заходе на Перекресток. Там в воде оазиса ползают оазисные хрустогрызы: их панцири нужны NPC {npc:3448}.",

	-- Step 120: Nalpak and Ebru
	-- {npc:5767} Nalpak · {npc:5768} Ebru
	["{npc:5767} and {npc:5768}"] = "{npc:5767} и {npc:5768}",
	-- {area:718} Wailing Caverns · {npc:5767} Nalpak · {npc:5768} Ebru
	["For your {area:718} run: {npc:5767} and {npc:5768} stand in a hidden cave in the rocks above the entrance, at the north end of the oasis' west shore: climb up from the west side. Follow the arrow up."] = "Для подземелья {area:718}: {npc:5767} и {npc:5768} стоят в скрытой пещере в скалах над входом, в северном конце западного берега оазиса: поднимайтесь с западной стороны. Следуйте за стрелкой наверх.",

	-- Step 121: Wailing Caverns
	-- {area:718} Wailing Caverns · {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:5767} Nalpak · {npc:3655} Mad Magglish · {item:5334} 99-Year-Old Port · {npc:5768} Ebru · {item:6464} Wailing Essence · {npc:3678} Disciple of Naralex · {npc:3654} Mutanus the Devourer · {item:10441} Glowing Shard · {area:392} Ratchet · {npc:8418} Falla Sagewind
	["{area:718} is a dungeon for a group of five, about levels 17 to 24, and a full run takes about an hour. Its mouth is just north of {npc:3396}'s shore, at the north end of {area:387}, under {npc:5767}'s cave.\nIn the caves before the portal: {npc:3655}, stealthed, with the {item:5334} (he moves between a few spots and comes back slowly: leave him if he's gone). Inside: the Deviates for {npc:5768}, and their hides for {npc:5767} (they drop rarely: one run may not be enough, so leave the rest for another run), {item:6464} from the Ectoplasms. After the four Fanglords, the {npc:3678} at the entrance leads you to Naralex: {npc:3654} drops the {item:10441}: its quest (someone in {area:392}, then {npc:8418} above the caverns) is not on this route; the Dungeons page's hand-in guide takes it."] = "{area:718} – подземелье для группы из пяти игроков, примерно 17-24-й уровень; полное прохождение занимает около часа. Вход – чуть севернее берега, где стоит {npc:3396}, в северном конце места {area:387}, под пещерой NPC {npc:5767}.\nВ пещерах перед порталом: {npc:3655}, в незаметности, с предметом {item:5334} (он перемещается между несколькими точками и возвращается медленно: если его нет, не ждите). Внутри: загадочные существа для NPC {npc:5768} и их шкуры для NPC {npc:5767} (шкуры падают редко: одного похода может не хватить, так что оставьте остальное на другой поход), {item:6464} – с эктоплазм. После четырех Повелителей Клыка {npc:3678} у входа ведет вас к Наралексу: с NPC {npc:3654} падает {item:10441}; его задание (кто-то в месте {area:392}, затем {npc:8418} над пещерами) не входит в этот маршрут: его берет гайд сдачи на странице «Подземелья».",
	-- {item:6464} Wailing Essence
	["{item:6464}: the Ectoplasms"] = "{item:6464}: эктоплазмы",

	-- Step 122: Nalpak
	["Back out of the caverns and up to the cave above the entrance."] = "Выйдите из пещер и поднимитесь к пещере над входом.",

	-- Step 124: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last Crossroads stop."] = "",

	-- Step 125: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "Снова на юг по дороге ({area:458}). Цель: {area:378}.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Сохраните: {npc:12696} ({zone:1440}), следующий гайд",
	-- {npc:6394} Ruga Ragetotem
	["{npc:6394}, inside"] = "",

	-- Step 127: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "Догран закован в цепи в лагере свинобразов к западу от дороги.",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, on the next guide's {zone:1454} stop"] = "",

	-- Step 128: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	-- plural, as words: Thunderheads = {npc:3239} Thunderhead
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Громоголовы пасутся на равнинах чуть южнее места {area:378}. Среди них бродит синий громоящер {quest:884}: его хвостовой шип начинает задание.",

	-- Step 129: Jorn Skyseer
	-- {quest:1824} Trial at the Field of Giants · {npc:6394} Ruga Ragetotem
	["Warriors: take {quest:1824} from {npc:6394} now: it runs for 30 minutes from the accept. The eggs and the antennae come first, at the same mounds, then straight back to {npc:6394}; the thunderhawks after."] = "Воины: возьмите задание {quest:1824} у NPC {npc:6394} сейчас: с момента принятия у вас 30 минут. Сначала яйца и усики у тех же курганов, затем сразу назад к NPC {npc:6394}; громоястребы – потом.",

	-- Step 130: Field of Giants
	-- {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound · Silithid Swarmers = {npc:3252} Silithid Swarmer
	["South of Camp Taurajo, the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them.\nCareful: Silithid Swarmers in the area release many tiny adds that interrupt spells; damage shields such as Thorns kill them in one hit."] = "",

	-- Step 131: Twitching Antennae
	["Twitching Antennae"] = "Дергающиеся усики",
	-- {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo · {npc:4196} Silithid Swarm · {npc:5781} Silithid Creeper Egg · {npc:3253} Silithid Harvester
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Creepers = {npc:3250} Silithid Creeper
	["The antennae vanish fifteen minutes after they drop: kill the Silithid Swarmers and Creepers at the same mounds until you have five, then take them straight to {npc:6394} in {area:378}, before the thunderhawks. Careful: Silithid Swarmers (level 21-22) cast {npc:4196} both in and out of combat, which brings several small adds; Silithid Creepers (level 20-21) periodically cast {npc:5781} in combat, which spawns extra adds. A {npc:3253} (24, rare) also wanders the mounds: leave it."] = "Усики исчезают через пятнадцать минут после того, как выпадут: убивайте силитидов-роителей и силитидов-ползунов у одних и тех же курганов, пока не наберете пять, затем сразу несите их NPC {npc:6394} ({area:378}), до громоястребов. Осторожно: силитиды-роители (21-22-й уровень) в бою и вне боя применяют {npc:4196}, что приводит несколько мелких противников; силитиды-ползуны (20-21-й уровень) в бою время от времени применяют {npc:5781}, что создает дополнительных противников. По курганам также бродит {npc:3253} (24, редкий): не трогайте его.",
	["Twitching Antennae from the silithid"] = "Дергающиеся усики с силитидов",

	-- Step 132: Ruga Ragetotem
	-- {area:378} Camp Taurajo · {npc:6394} Ruga Ragetotem
	["Back north into {area:378} before the antennae fade: {npc:6394} is inside."] = "Назад на север в {area:378}, пока усики не исчезли: {npc:6394} – внутри.",

	-- Step 133: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the plains south of the camp."] = "Над равнинами к югу от лагеря кружат грозовые змеи-облачники.",

	-- Step 134: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {item:7766} Empty Brown Waterskin
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}: fill the {item:7766} at the watering hole below it."] = "",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "Наполните {item:7766} у водопоя свинобразов",
	-- {object:107045} Spring Well · {area:272} Tarren Mill · {area:287} Hillsbrad
	["Keep it: the {object:107045} is beside {area:272}, on the {area:287} guide"] = "",

	-- Step 135: Camp Taurajo
	-- {area:378} Camp Taurajo
	["Back north into {area:378} on the way to the Crossroads: Jorn takes the thunderhawk wings."] = "",

	-- Step 136: The Crossroads
	-- {area:458} Gold Road · {npc:3448} Tonga Runetotem · {npc:3432} Mankrik · {npc:3428} Korran
	["North up the {area:458} to the Crossroads: {npc:3448} at the south gate, {npc:3432} by the inn, {npc:3428} west of the north gate."] = "На север по дороге ({area:458}) к Перекрестку: {npc:3448} – у южных ворот, {npc:3432} – у таверны, {npc:3428} – к западу от северных ворот.",

	-- Step 137: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze
	["{npc:5878} camps beside the road east of the Crossroads."] = "",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Затем он предложит {quest:1838} (1838, 30-й уровень): для него нужно место {area:1717}, и оно отправит вас по всему Калимдору и Восточным королевствам. Его описывает классовый гайд воина «{quest:1838}».",

	-- Step 139: Counterattack!
	-- {npc:3389} Regthar Deathgate · {npc:9456} Warlord Krom'zar
	["Speak to {npc:3389} again to start the attack: the Kolkar charge the bunkers just west of him in waves. Fight beside the grunts until {npc:9456} (elite, 20) arrives with two bodyguards, usually from the south, then click the banner over his body."] = "",

	-- Step 140: Seereth Stonebreak's camp
	-- {npc:4049} Seereth Stonebreak
	["{npc:4049}'s camp"] = "",

	-- Step 141: Seereth Stonebreak
	-- {npc:4049} Seereth Stonebreak · {npc:11857} Makaba Flathoof
	["{npc:4049} and {npc:11857} share the camp on the road west to Stonetalon."] = "",
	-- {npc:4049} Seereth Stonebreak · {area:461} Windshear Crag
	["{npc:4049}: the Venture loggers at {area:461}"] = "",

	-- Step 142: Grimtotem camp
	["Grimtotem camp"] = "Лагерь Зловещего Тотема",
	-- {npc:11857} Makaba Flathoof
	["The Grimtotem camp is just north of {npc:11857}, a short walk off the road: Ruffians and Mercenaries stand among the tents."] = "",

	-- Step 143: Makaba Flathoof
	-- {npc:11857} Makaba Flathoof
	["Back down to {npc:11857}."] = "",
	-- {npc:11858} Grundig Darkcloud · {area:1076} Webwinder Path
	["{npc:11858} waits up the {area:1076}"] = "",

	-- Step 144: To Malaka'jin
	-- {area:2539} Malaka'jin
	["To {area:2539}"] = "",

	-- Step 145: Malaka'jin
	-- {npc:4049} Seereth Stonebreak · {area:2539} Malaka'jin
	["Follow the road on west from {npc:4049} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "",
	-- {npc:12816} Xen'Zilla · {area:1076} Webwinder Path
	["{npc:12816}: the spiders along the {area:1076}"] = "",

	-- Step 146: Webwinder Path: kill these as you meet them
	-- {area:1076} Webwinder Path
	["{area:1076}: kill these as you meet them"] = "",
	-- {area:2539} Malaka'jin · {npc:11858} Grundig Darkcloud
	-- plural, as words: Grimtotem Brutes = {npc:11912} Grimtotem Brute · Deepmoss Creepers = {npc:4005} Deepmoss Creeper
	["North up the road from {area:2539}: {npc:11858} and his Grimtotem Brutes hold the bend in the road, and the Deepmoss Creepers and Venomspitters lurk in the webs on both sides of the path all the way up."] = "",

	-- Step 147: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "Дорога поднимается на север – {area:1076}. Хижина: {quest:1483} – там, где дорога сворачивает на восток к месту {area:461}.",
	-- {quest:1483} Ziz Fizziks
	["{quest:1483}, inside"] = "",

	-- Step 148: Windshear Crag
	-- {area:461} Windshear Crag
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints."] = "",
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["Venture Co. Loggers, all over the clear-cut"] = "",

	-- Step 149: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276}'s defence is hard alone at this level: grouping up is encouraged, look for people to do it with. Skip it if you are alone.\n{npc:4276} mines at the bottom of the {area:2160} on the east side of the crag, past its kobolds (levels 19-23). Talk to him, then keep him alive for five minutes while he mines: a dozen or more kobolds come at him in waves, melee fighters first, then casters, and the mine's own kobolds respawn into the fight. If he dies, the quest fails."] = "",
	-- {npc:4276} Piznik
	["{npc:4276}, below ground"] = "",

	-- Step 150: Ziz Fizziks: Gerenzo's Orders
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "",

	-- Step 151: Ziz Fizziks
	-- {npc:4201} Ziz Fizziks · {npc:3442} Sputtervalve · {area:392} Ratchet · {zone:1413} The Barrens
	["{npc:4201}: for {npc:3442}, beside {area:392}'s flight master at the end of the {zone:1413} & Stonetalon guide"] = "{npc:4201}: для NPC {npc:3442}, рядом с распорядителем полетов ({area:392}), в конце гайда «{zone:1413} и Когтистые горы»",

	-- Step 152: Kaya Flathoof
	-- {area:1076} Webwinder Path · {npc:11856} Kaya Flathoof · {npc:11858} Grundig Darkcloud · {area:2538} Camp Aparaje
	["On the way back down the {area:1076}, {npc:11856} is held in {npc:11858}'s hut at the bend in the road. Once you take her quest she walks straight off south-east to {area:2538}, the burned village, without waiting: stay close, or the quest fails.\nCareful: Three Grimtotems ambush her at the burned village and go for her, not you: pull them off her and kill their caster quickly."] = "На обратном пути вниз по тропе ({area:1076}) {npc:11856} удерживают в хижине NPC {npc:11858} у поворота дороги. Как только вы возьмете ее задание, она сразу пойдет на юго-восток к месту {area:2538}, в сожженную деревню, не дожидаясь вас: держитесь рядом, иначе задание будет провалено.\nОсторожно: в сожженной деревне на нее нападут трое из племени Зловещего Тотема, и атаковать они будут ее, а не вас: отвлеките их на себя и побыстрее убейте заклинателя.",
	-- {npc:11856} Kaya Flathoof · {npc:11858} Grundig Darkcloud
	["{npc:11856}, inside {npc:11858}'s hut"] = "{npc:11856}, в хижине NPC {npc:11858}",

	-- Step 153: Malaka'jin
	-- {area:2539} Malaka'jin · {npc:12816} Xen'Zilla
	["West from the burned village to {area:2539}: {npc:12816} stands just outside it, before the village."] = "На запад от сожженной деревни к месту {area:2539}: {npc:12816} стоит прямо перед деревней.",

	-- Step 155: Seereth Stonebreak
	-- {npc:4049} Seereth Stonebreak · {npc:11857} Makaba Flathoof
	["East along the road to {npc:4049} and {npc:11857}'s camp, on the way back out of Stonetalon."] = "",
	-- {npc:11857} Makaba Flathoof · {npc:11864} Tammra Windfield · {area:460} Sun Rock Retreat · {zone:1413} The Barrens
	["{npc:11857}: keep it, {npc:11864} at {area:460} in the {zone:1413} & Stonetalon guide"] = "{npc:11857}: сохраните, {npc:11864} ({area:460}) – в гайде «{zone:1413} и Когтистые горы»",
	-- {zone:1413} The Barrens · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["The next guide goes north-east across the {zone:1413} to the {area:1703} and {zone:1440}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end.\nSunscale raptors here count toward the heads."] = "Обратно вниз по пляжу, мимо лагеря пиратов: ящик с сапогами и хрупкий ящик с линзой стоят на его южном краю.\nЯркочешуйчатые ящеры здесь тоже дают головы.",
	-- ["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "Назад в лагерь Иглогривых. Геоманты и защитники держат его восточную половину; среди них ходит {npc:3438}.",
	-- ["Back west along the road."] = "Назад на запад по дороге.",
	-- ["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Сектанты из клана Пылающего Клинка ({npc:3199}) удерживают {area:1898} на севере зоны {zone:1411}; с них падает {item:6652}. {item:5026} добудете у Иглогривых в следующий заход в их лагерь.",
	-- ["East to {area:392}, on the coast."] = "На восток: {area:392}, на побережье.",
	-- ["Follow the road east to the outpost above the {area:814}."] = "Идите по дороге на восток к заставе над рекой ({area:814}).",
	-- ["In from the north gate: {npc:3464}, {npc:3449} on the tower platform, {npc:3338} by the inn, then {npc:3448} and Mura at the south gate. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Войдите через северные ворота: {npc:3464}, {npc:3449} на площадке башни, {npc:3338} у таверны, затем {npc:3448} и Мура у южных ворот. Отсюда начинается следующий гайд; он ведет в {zone:1454} и к дирижаблю в зону {zone:1420}.",
	-- ["In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end.\nPlainstriders here count toward the beaks."] = "В лагере водоискатели и терноплеты держат западную половину, охотники – середину; ящики с припасами стоят на восточном краю.\nДолгоноги здесь тоже дают клювы.",
	-- ["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Сохраните: {quest:3923} стоит у ворот города {zone:1454}; сдадите в одном из следующих гайдов",
	-- ["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Пастухи ({npc:3272}) и буревестницы из племени Колкар занимают лагеря к югу от NPC {npc:3389}.",
	-- ["Kolkar camps"] = "Лагеря Колкар",
	-- ["North-east to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "На северо-восток: {area:1703}; {npc:9316} стоит в лагере сразу к югу.",
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Оазисные хрустогрызы ползают вокруг места {area:387}, к юго-западу от места {area:380}, и вокруг места {area:388}.",
	-- ["Over the {area:814} bridge below {area:379} and south along the {zone:1411} bank to where a narrow trail climbs the mountain: {npc:5900} keeps the shrine at the top. Mind the edges on the way up, and come back down the same trail."] = "По мосту ({area:814}) под местом {area:379} и на юг вдоль берега ({zone:1411}) до узкой тропы, ведущей в гору: {npc:5900} хранит святилище на вершине. Осторожнее с обрывами по пути наверх и спускайтесь по той же тропе.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Равнинные долгоноги и яркочешуйчатые ящеры бродят по равнинам вокруг места {area:380}, гуще всего к северу.",
	-- ["Plainstriders and raptors"] = "Долгоноги и ящеры",
	-- ["Raptor nests"] = "Гнезда ящеров",
	-- ["South-east of the Crossroads. Test the seeds at the bubbling fissure on the oasis' east bank; {npc:3448} takes the result on the next Crossroads stop, so carry on north-west to the {area:383} from here."] = "К юго-востоку от Перекрестка. Проверьте семена у бурлящей расщелины на восточном берегу оазиса; результат {npc:3448} примет при следующем заходе в Перекресток, так что отсюда идите дальше на северо-запад. Цель: {area:383}.",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "К юго-востоку от места {area:380}. Проверьте семена у бурлящей расщелины на восточном берегу оазиса.",
	-- ["Southsea beach"] = "Пляж Южных морей",
	-- ["Still short of twelve? The Sunscale Screechers are thickest on the plains around {quest:881}'s lair, north of the Razormane camp."] = "Не хватает до двенадцати? Больше всего яркочешуйчатых крикунов на равнинах вокруг логова ({quest:881}), к северу от лагеря Иглогривых.",
	-- ["Sunscale raptors here count toward the heads."] = "Яркочешуйчатые ящеры здесь тоже дают головы.",
	-- ["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Хищники саванны ({npc:3425}) охотятся на равнинах между поселением и лагерем Иглогривых к востоку. В лагере водоискатели и терноплеты держат западную половину, охотники – середину; ящики с припасами стоят на восточном краю.",
	-- ["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "Душегубки из стаи Зачарованного Крыла ({npc:3278}) держат запад местности {area:383}; кольца – у них.",
	-- ["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "Пруды – сразу к северу от NPC {npc:3389}. Зайдите в воду, чтобы исследовать их; спелые грибы ({object:3640}) для Хелбрима растут вокруг. Убивайте всех встречных Колкар ради наручей.",
	-- ["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Три гнезда находятся рядом – {area:1697}, к юго-западу от оазиса; их охраняют яркочешуйчатые смертехваты ({npc:3256}).",
	-- ["The {area:383}"] = "{area:383}",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "Тун'грим разбил лагерь у дороги из поселения {area:380} в {area:392}. {object:58369} стоит на юге лагеря Иглогривых, сразу к северу от него.",
	-- ["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Рокочущие ящерицы ({npc:3130}) и бурешкуры ({npc:3131}) пасутся сразу за мостом ниже заставы {area:379}.",
	-- ["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "Рокочущие ящерицы ({npc:3130}) и бурешкуры ({npc:3131}) пасутся сразу за мостом ниже заставы {area:379}.\nОсторожно: Халикор, элитный противник 12-го уровня, бродит среди ящериц ({area:369}): высматривайте его, прежде чем нападать.",
	-- ["Thunder lizards across the river"] = "Рокочущие ящерицы за рекой",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Вернитесь на юг к месту {area:380}. Отсюда начинается следующий гайд; он ведет в {zone:1454} и к дирижаблю в зону {zone:1420}.",
	-- ["Walk back west along the road to the {area:380}."] = "Вернитесь по дороге на запад к месту {area:380}.",
	-- ["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "На запад: {area:383}. Гарпии из стаи Зачарованного Крыла гнездятся повсюду; коготь может упасть с любой. {quest:819} лежит в этих холмах.",
	-- ["While you are in the camp: {npc:3429}'s Water Seekers and Thornweavers in its western half, the Hunters in the middle, the supply crates at its eastern end."] = "Пока вы в лагере: водоискатели и терноплеты для NPC {npc:3429} – в западной половине, охотники – в середине, ящики с припасами – на восточном краю.",
	-- ["Zhevra"] = "Зебры",
	-- ["Zhevra Runners graze north and east of town."] = "Жевры-бегуны ({npc:3242}) пасутся к северу и востоку от поселения.",
	-- ["{area:1898} cultists"] = "Сектанты: {area:1898}",
	-- ["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} – ваша база в этом гайде. Все нужные NPC стоят в нескольких шагах от таверны.",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: используйте половинку здесь: {area:2362}",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the Crossroads. Oasis Snapjaws crawl in the water around it: their shells are for {npc:3448}."] = "{npc:3395} ходит среди Колкар у места {area:388} к юго-востоку от Перекрестка. Вокруг в воде ползают оазисные хрустогрызы: их панцири нужны NPC {npc:3448}.",
	-- ["{npc:3448}: the Oasis Snapjaws at the {area:388}, with {npc:3395}"] = "{npc:3448}: оазисные хрустогрызы – {area:388}, вместе с NPC {npc:3395}",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, распорядитель полетов",
	-- ["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} разбил лагерь у дороги от места {area:380} к месту {area:392}. {object:58369} стоит на юге лагеря Иглогривых, сразу к северу от него.",
	-- ["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} ждет на берегу реки к югу от заставы {area:379}, за мостом.",
	-- ["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} стоит на гребне к северу от лагеря Иглогривых.",
	-- ["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}: {area:228} ({zone:1421}), следующий гайд",
	-- ["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, белый лев, рыщет по равнинам к северу от лагеря Иглогривых.",
}
