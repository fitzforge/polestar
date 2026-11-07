-- Russian (ruRU): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:379} Far Watch Post · {npc:3489} Zargh · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger
	["You arrive from {area:379}. {npc:3489} and {npc:3338} stand by the inn, Helbrim and {npc:3464} by the north gate; {npc:3615}, {npc:3429} and {npc:3449} on the tower platform."] = "Вы приходите с заставы {area:379}. {npc:3489} и {npc:3338} стоят у таверны, Хелбрим и {npc:3464} – у северных ворот; {npc:3615}, {npc:3429} и {npc:3449} – на площадке башни.",
	-- {npc:3615} Devrak
	["{npc:3615}, on the tower"] = "{npc:3615}, на башне",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}: гарпии будут позже – {area:383}",

	-- Step 2: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} стоит лагерем у дороги на восток к месту {area:392}.",

	-- Step 9: Razormane camp
	["Razormane camp"] = "Лагерь Иглогривых",
	-- {area:380} The Crossroads · {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	["The Razormane camp lies east of the {area:380}. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}.\nCareful: The chest stands next to a broken wagon, guarded by a pair of Razormanes, including hunters that can pull more quilboar into the fight."] = "Лагерь Иглогривых находится к востоку от места {area:380}. Воины: {object:58369} стоит в лагере. Шаманы: с кабанолюдов падает {item:5026}.\nОсторожно: сундук стоит рядом со сломанной повозкой, его охраняют двое Иглогривых, включая охотников, которые могут привлечь в бой других кабанолюдов.",

	-- Step 10: Razormane camp: Thork's quilboar
	-- {npc:3429} Thork
	["Razormane camp: {npc:3429}'s quilboar"] = "Лагерь Иглогривых: кабанолюды для NPC {npc:3429}",
	-- {npc:3429} Thork
	["While you are in the camp: {npc:3429}'s Water Seekers and Thornweavers in its western half, the Hunters in the middle, the supply crates at its eastern end."] = "Пока вы в лагере: водоискатели и терноплеты для NPC {npc:3429} – в западной половине, охотники – в середине, ящики с припасами – на восточном краю.",

	-- Step 12: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["Back east over the bridge and up the trail to {npc:5900}'s shrine, as at 10. {npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "",

	-- Step 13: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, ваш {item:5176} и {item:263412}",

	-- Step 15: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} – ваша база в этом гайде. Все нужные NPC стоят в нескольких шагах от таверны.",

	-- Step 16: Raptor Heads as you go
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Raptor Heads as you go"] = "Головы ящеров по пути",
	-- {area:380} The Crossroads
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Sunscale raptors roam the plains north and east of the {area:380}, and about three in four drop a head: kill the ones you pass on the way. Careful: Sunscale Screechers call nearby allies within 30 yd once below 30% health."] = "Яркочешуйчатые ящеры бродят по равнинам к северу и востоку от места {area:380}, примерно с трех из четырех падает голова: убивайте встречных по пути. Осторожно: яркочешуйчатые крикуны при здоровье ниже 30% зовут союзников в радиусе 30 м.",

	-- Step 17: Plainstrider Beaks as you go
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Plainstrider Beaks as you go"] = "Клювы долгоногов по пути",
	-- {area:17} The Barrens
	["Plainstriders roam the plains all over the {area:17}, and about one in four drops a beak: kill the ones you pass on the way."] = "Долгоноги бродят по всей зоне {area:17}, примерно с каждого четвертого падает клюв: убивайте встречных по пути.",

	-- Step 18: Razormane camp
	["In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end.\nPlainstriders here count toward the beaks."] = "В лагере водоискатели и терноплеты держат западную половину, охотники – середину; ящики с припасами стоят на восточном краю.\nДолгоноги здесь тоже дают клювы.",

	-- Step 19: Finish the Plainstrider Beaks
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Finish the Plainstrider Beaks"] = "Доберите клювы долгоногов",
	-- {area:380} The Crossroads
	["Still short of seven? Plainstriders are thickest on the plains north of the {area:380}, along the road north."] = "Не хватает до семи? Больше всего долгоногов на равнинах к северу от места {area:380}, вдоль дороги на север.",

	-- Step 21: The Zhevra
	-- {area:392} Ratchet
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze along the road east toward {area:392}: take their hooves on the way out."] = "Жевры-бегуны пасутся вдоль дороги на восток к месту {area:392}: соберите копыта по пути.",

	-- Step 25: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} стоит на гребне к северу от лагеря Иглогривых.",

	-- Step 26: Far Watch Post
	-- {area:814} Southfury River
	["Follow the road east to the outpost above the {area:814}."] = "Идите по дороге на восток к заставе над рекой ({area:814}).",

	-- Step 28: Thunder lizards across the river
	["Thunder lizards across the river"] = "Рокочущие ящерицы за рекой",
	-- {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Рокочущие ящерицы ({npc:3130}) и бурешкуры ({npc:3131}) пасутся сразу за мостом ниже заставы {area:379}.",

	-- Step 30: Telf Joolam
	-- {npc:5900} Telf Joolam · {area:379} Far Watch Post
	["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} ждет на берегу реки к югу от заставы {area:379}, за мостом.",

	-- Step 31: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Сектанты: {area:1898}",
	-- {area:1898} Dustwind Gulch · {area:14} Durotar · {item:6652} Reagent Pouch · {item:5026} Fire Tar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {area:14}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "",

	-- Step 34: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} The Crossroads · {area:392} Ratchet · {object:58369} Stolen Iron Chest
	["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} разбил лагерь у дороги от места {area:380} к месту {area:392}. {object:58369} стоит на юге лагеря Иглогривых, сразу к северу от него.",

	-- Step 36: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Идите по дороге на юго-восток: {area:392} на побережье.",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}: пульт управления – {area:382}, позже",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, на причале",

	-- Step 37: The Barrens: kill these as you meet them
	-- {area:17} The Barrens
	["{area:17}: kill these as you meet them"] = "",
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them.\nThe pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "",

	-- Step 39: Stolen Booty
	["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end.\nSunscale raptors here count toward the heads."] = "Обратно вниз по пляжу, мимо лагеря пиратов: ящик с сапогами и хрупкий ящик с линзой стоят на его южном краю.\nЯркочешуйчатые ящеры здесь тоже дают головы.",

	-- Step 41: Fly to The Crossroads
	-- {area:380} The Crossroads
	["Fly to {area:380}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 43: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["South to {npc:3389}'s watch post on the Kolkar border."] = "На юг к сторожевому посту NPC {npc:3389} на границе с Колкар.",

	-- Step 44: The Barrens: kill these as you meet them
	-- {npc:3389} Regthar Deathgate · {npc:3394} Barak Kodobane
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers. {npc:3394} stands in the Kolkar camp west of the pools."] = "Пруды – сразу к северу от NPC {npc:3389}. Зайдите в воду, чтобы исследовать их; спелые грибы для Хелбрима растут вокруг. Убивайте всех встречных Колкар ради наручей. {npc:3394} стоит в лагере Колкар к западу от прудов.",

	-- Step 45: Regthar Deathgate
	-- {area:388} Stagnant Oasis · {area:17} The Barrens
	["Verog walks with the Kolkar at the {area:388}: later, in the 19-23 {area:17} guide"] = "Верог ходит с Колкар у места {area:388}: позже, в гайде {area:17} 19-23",

	-- Step 46: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg · {npc:3389} Regthar Deathgate
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler · Witchwing Ambushers = {npc:3279} Witchwing Ambusher
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills. Savannah Prowlers hunt the plains between {npc:3389} and the hills: take their claws on the way.\nCareful: There are 2 Witchwing Ambushers (level 17-18). They stay stealthed with Sneak while out of combat."] = "На запад: {area:383}. Гарпии из стаи Зачарованного Крыла гнездятся повсюду; коготь может упасть с любой. {quest:819} лежит в этих холмах. Хищники саванны охотятся на равнинах между NPC {npc:3389} и холмами: соберите их когти по пути.\nОсторожно: здесь 2 засадницы из стаи Зачарованного Крыла (уровень 17-18). Вне боя они скрыты незаметностью.",

	-- Step 47: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it.\nCareful: Several guards stand within aggro range of the valves, respawn in under about 3 minutes, and run at low health to bring back help; nearby mobs also join if you use a valve while they are close."] = "",
	["Inside"] = "",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: later, on the way"] = "{npc:3442} ({area:392}): позже, по пути",

	-- Step 48: Ratchet
	-- {area:392} Ratchet
	["East to {area:392}, on the coast."] = "На восток: {area:392}, на побережье.",

	-- Step 49: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "Назад в лагерь Иглогривых. Геоманты и защитники держат его восточную половину; среди них ходит {npc:3438}.",

	-- Step 51: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} делает из смолы и мешочка предмет {item:6636}. Используйте его у жаровни рядом с ним, чтобы появился {npc:5893}; убейте его ради предмета {item:6655}, затем положите уголек в жаровню.",

	-- Step 52: The Barrens
	["Sunscale raptors here count toward the heads."] = "Яркочешуйчатые ящеры здесь тоже дают головы.",

	-- Step 55: The Stagnant Oasis
	-- {area:380} The Crossroads
	["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "К юго-востоку от места {area:380}. Проверьте семена у бурлящей расщелины на восточном берегу оазиса.",
	["Underwater"] = "",

	-- Step 56: The Crossroads
	["Back west along the road."] = "Назад на запад по дороге.",

	-- Step 57: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Оазисные хрустогрызы ползают вокруг места {area:387}, к юго-западу от места {area:380}, и вокруг места {area:388}.",

	-- Step 58: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["North-west to the {area:383}: the Witchwing Slayers hold their western end; they wear the rings.\nCareful: Some stealthed harpy ambushers wait in the area and stay hidden until you get close. A level 19 elite harpy also patrols there."] = "На северо-запад: {area:383}; душегубки из стаи Зачарованного Крыла держат западный край; кольца – у них.\nОсторожно: в округе прячутся невидимые гарпии-засадницы, они не видны, пока вы не подойдете близко. Там же патрулирует гарпия-элита 19 уровня.",

	-- Step 60: Raptor Horns
	-- {npc:9316} Wenikee Boltbucket · {area:383} Dry Hills · {item:5055} Intact Raptor Horn · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["On the way north-east to {npc:9316}: Sunscale Scytheclaws prowl the plains east of the {area:383}; any of them can drop an {item:5055} for {npc:3446} in {area:392}."] = "По пути на северо-восток к NPC {npc:9316}: яркочешуйчатые смертехваты рыщут по равнинам к востоку от места {area:383}; с любого может упасть {item:5055} для NPC {npc:3446} ({area:392}).",

	-- Step 61: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["North-east to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "На северо-восток: {area:1703}; {npc:9316} стоит в лагере сразу к югу.",

	-- Step 62: Nugget Slugs
	-- {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "Ведра с инструментами и слизнями лежат вокруг буровой площадки Торговой компании ({area:382}), к востоку от {npc:9316}.",

	-- Step 63: Ignition
	-- {area:382} Sludge Fen · {npc:3439} Wizzlecrank's Shredder · {npc:3445} Supervisor Lugwizzle
	["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "",

	-- Step 64: Wenikee Boltbucket
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Keep it: {quest:3923} is in {zone:1454}'s {object:172958}, on the next guide's {zone:1454} visit"] = "",

	-- Step 65: Echeyakee
	-- {area:380} The Crossroads · {quest:881} Echeyakee
	["South-east on the way back to the {area:380}: {quest:881}, a white lion, prowls the plains north of the Razormane camp.\nCareful: Savannah Huntresses roam around the lair. They respawn quickly and often join the fight alongside {quest:881}, so clear them out before you blow the horn.\nSunscale raptors here count toward the heads."] = "На юго-восток, по пути обратно к месту {area:380}: {quest:881}, белый лев, рыщет по равнинам к северу от лагеря Иглогривых.\nОсторожно: вокруг логова бродят охотницы саванны. Они быстро возрождаются и часто вступают в бой вместе с {quest:881}, так что перебейте их, прежде чем трубить в рог.\nЯркочешуйчатые ящеры здесь тоже дают головы.",

	-- Step 66: Finish the Raptor Heads
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Finish the Raptor Heads"] = "Доберите головы ящеров",
	-- {quest:881} Echeyakee
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Still short of twelve? The Sunscale Screechers are thickest on the plains around {quest:881}'s lair, north of the Razormane camp."] = "Не хватает до двенадцати? Больше всего яркочешуйчатых крикунов на равнинах вокруг логова ({quest:881}), к северу от лагеря Иглогривых.",

	-- Step 67: The Crossroads
	-- {npc:3464} Gazrog · {npc:3449} Darsok Swiftdagger · {npc:3338} Sergra Darkthorn · {npc:3448} Tonga Runetotem · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["In from the north gate: {npc:3464}, {npc:3449} on the tower platform, {npc:3338} by the inn, then {npc:3448} and Mura at the south gate. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Войдите через северные ворота: {npc:3464}, {npc:3449} на площадке башни, {npc:3338} у таверны, затем {npc:3448} и Мура у южных ворот. Отсюда начинается следующий гайд; он ведет в {zone:1454} и к дирижаблю в зону {zone:1420}.",
	-- {quest:3301} Mura Runetotem · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}: {area:228} ({zone:1421}), следующий гайд",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "Обратно вниз по пляжу, мимо лагеря пиратов: ящик с сапогами и хрупкий ящик с линзой стоят на его южном краю.",
	-- ["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Сектанты из клана Пылающего Клинка ({npc:3199}) удерживают {area:1898} на севере зоны {zone:1411}; с них падает {item:6652}. {item:5026} добудете у Иглогривых в следующий заход в их лагерь.",
	-- ["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "На восток: {area:1703}; {npc:9316} стоит в лагере сразу к югу.",
	-- ["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Сохраните: {quest:3923} стоит у ворот города {zone:1454}; сдадите в одном из следующих гайдов",
	-- ["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Пастухи ({npc:3272}) и буревестницы из племени Колкар занимают лагеря к югу от NPC {npc:3389}.",
	-- ["Kolkar camps"] = "Лагеря Колкар",
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Оазисные хрустогрызы ({npc:3461}) ползают вокруг места {area:387}, к юго-западу от поселения {area:380}, и вокруг места {area:388}.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Равнинные долгоноги и яркочешуйчатые ящеры бродят по равнинам вокруг места {area:380}, гуще всего к северу.",
	-- ["Plainstriders and raptors"] = "Долгоноги и ящеры",
	-- ["Raptor nests"] = "Гнезда ящеров",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "К юго-востоку от поселения {area:380}. Проверьте семена у бурлящей расщелины на восточном берегу оазиса.",
	-- ["Southsea beach"] = "Пляж Южных морей",
	-- ["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Хищники саванны ({npc:3425}) охотятся на равнинах между поселением и лагерем Иглогривых к востоку. В лагере водоискатели и терноплеты держат западную половину, охотники – середину; ящики с припасами стоят на восточном краю.",
	-- ["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "Душегубки из стаи Зачарованного Крыла ({npc:3278}) держат запад местности {area:383}; кольца – у них.",
	-- ["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "Пираты разбили лагерь на пляже к югу от поселения {area:392}. Груды сложных деталей лежат в песке среди них.",
	-- ["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "Пруды – сразу к северу от NPC {npc:3389}. Зайдите в воду, чтобы исследовать их; спелые грибы ({object:3640}) для Хелбрима растут вокруг. Убивайте всех встречных Колкар ради наручей.",
	-- ["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Три гнезда находятся рядом – {area:1697}, к юго-западу от оазиса; их охраняют яркочешуйчатые смертехваты ({npc:3256}).",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "{object:4141} стоит на исследовательской площадке Торговой компании к западу от места {area:382}. Закройте три вентиля вокруг бура, снова используйте пульт, затем заберите {item:5089} у NPC {npc:3471} рядом.",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "Тун'грим разбил лагерь у дороги из поселения {area:380} в {area:392}. {object:58369} стоит на юге лагеря Иглогривых, сразу к северу от него.",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Вернитесь на юг к месту {area:380}. Отсюда начинается следующий гайд; он ведет в {zone:1454} и к дирижаблю в зону {zone:1420}.",
	-- ["Walk back west along the road to the {area:380}."] = "Вернитесь по дороге на запад к месту {area:380}.",
	-- ["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "На запад: {area:383}. Гарпии из стаи Зачарованного Крыла гнездятся повсюду; коготь может упасть с любой. {quest:819} лежит в этих холмах.",
	-- ["Zhevra"] = "Зебры",
	-- ["Zhevra Runners graze north and east of town."] = "Жевры-бегуны ({npc:3242}) пасутся к северу и востоку от поселения.",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, распорядитель полетов",
	-- ["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, белый лев, рыщет по равнинам к северу от лагеря Иглогривых.",
}
