-- Russian (ruRU): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} – ваша база в этом гайде. Все нужные NPC стоят в нескольких шагах от таверны.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, распорядитель полетов",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}: гарпии будут позже – {area:383}",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "Долгоноги и ящеры",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Равнинные долгоноги и яркочешуйчатые ящеры бродят по равнинам вокруг места {area:380}, гуще всего к северу.",

	-- Step 4: The Zhevra
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze north and east of town."] = "Жевры-бегуны ({npc:3242}) пасутся к северу и востоку от поселения.",
	["Zhevra"] = "Зебры",

	-- Step 6: Razormane camp
	["Razormane camp"] = "Лагерь Иглогривых",
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Хищники саванны ({npc:3425}) охотятся на равнинах между поселением и лагерем Иглогривых к востоку. В лагере водоискатели и терноплеты держат западную половину, охотники – середину; ящики с припасами стоят на восточном краю.",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} стоит на гребне к северу от лагеря Иглогривых.",

	-- Step 8: Far Watch Post
	-- {area:814} Southfury River
	["Follow the road east to the outpost above the {area:814}."] = "Идите по дороге на восток к заставе над рекой ({area:814}).",

	-- Step 9: Thunder lizards across the river
	["Thunder lizards across the river"] = "Рокочущие ящерицы за рекой",
	-- {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Рокочущие ящерицы ({npc:3130}) и бурешкуры ({npc:3131}) пасутся сразу за мостом ниже заставы {area:379}.",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {area:379} Far Watch Post
	["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} ждет на берегу реки к югу от заставы {area:379}, за мостом.",

	-- Step 12: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Сектанты: {area:1898}",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {item:6652} Reagent Pouch · {item:5026} Fire Tar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Сектанты из клана Пылающего Клинка ({npc:3199}) удерживают {area:1898} на севере зоны {zone:1411}; с них падает {item:6652}. {item:5026} добудете у Иглогривых в следующий заход в их лагерь.",

	-- Step 13: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} The Crossroads · {area:392} Ratchet · {object:58369} Stolen Iron Chest
	["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} разбил лагерь у дороги от места {area:380} к месту {area:392}. {object:58369} стоит на юге лагеря Иглогривых, сразу к северу от него.",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Идите по дороге на юго-восток: {area:392} на побережье.",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}: пульт управления – {area:382}, позже",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, на причале",

	-- Step 15: Southsea beach
	["Southsea beach"] = "Пляж Южных морей",
	-- {area:392} Ratchet
	["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "Пираты разбили лагерь на пляже к югу от поселения {area:392}. Груды сложных деталей лежат в песке среди них.",

	-- Step 17: Stolen Booty
	["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "Обратно вниз по пляжу, мимо лагеря пиратов: ящик с сапогами и хрупкий ящик с линзой стоят на его южном краю.",

	-- Step 19: The Crossroads
	-- {area:380} The Crossroads
	["Walk back west along the road to the {area:380}."] = "Вернитесь по дороге на запад к месту {area:380}.",

	-- Step 20: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "Назад в лагерь Иглогривых. Геоманты и защитники держат его восточную половину; среди них ходит {npc:3438}.",

	-- Step 21: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} делает из смолы и мешочка предмет {item:6636}. Используйте его у жаровни рядом с ним, чтобы появился {npc:5893}; убейте его ради предмета {item:6655}, затем положите уголек в жаровню.",

	-- Step 22: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, ваш {item:5176} и {item:263412}",

	-- Step 23: Echeyakee
	-- {quest:881} Echeyakee
	["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, белый лев, рыщет по равнинам к северу от лагеря Иглогривых.",

	-- Step 24: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "{object:4141} стоит на исследовательской площадке Торговой компании к западу от места {area:382}. Закройте три вентиля вокруг бура, снова используйте пульт, затем заберите {item:5089} у NPC {npc:3471} рядом.",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: later, on the way"] = "{npc:3442} ({area:392}): позже, по пути",

	-- Step 25: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "На запад: {area:383}. Гарпии из стаи Зачарованного Крыла гнездятся повсюду; коготь может упасть с любой. {quest:819} лежит в этих холмах.",

	-- Step 26: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["South to {npc:3389}'s watch post on the Kolkar border."] = "На юг к сторожевому посту NPC {npc:3389} на границе с Колкар.",

	-- Step 27: The Forgotten Pools
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "Пруды – сразу к северу от NPC {npc:3389}. Зайдите в воду, чтобы исследовать их; спелые грибы ({object:3640}) для Хелбрима растут вокруг. Убивайте всех встречных Колкар ради наручей.",

	-- Step 28: Kolkar camps
	["Kolkar camps"] = "Лагеря Колкар",
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Kolkar Wranglers = {npc:3272} Kolkar Wrangler
	["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Пастухи ({npc:3272}) и буревестницы из племени Колкар занимают лагеря к югу от NPC {npc:3389}.",

	-- Step 31: The Stagnant Oasis
	-- {area:380} The Crossroads
	["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "К юго-востоку от места {area:380}. Проверьте семена у бурлящей расщелины на восточном берегу оазиса.",

	-- Step 32: Raptor nests
	["Raptor nests"] = "Гнезда ящеров",
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Три гнезда находятся рядом – {area:1697}, к юго-западу от оазиса; их охраняют яркочешуйчатые смертехваты ({npc:3256}).",

	-- Step 33: Ratchet
	-- {area:392} Ratchet
	["East to {area:392}, on the coast."] = "На восток: {area:392}, на побережье.",

	-- Step 34: The Crossroads
	["Back west along the road."] = "Назад на запад по дороге.",

	-- Step 35: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Оазисные хрустогрызы ползают вокруг места {area:387}, к юго-западу от места {area:380}, и вокруг места {area:388}.",

	-- Step 36: The Crossroads
	-- {quest:3301} Mura Runetotem · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}: {area:228} ({zone:1421}), следующий гайд",

	-- Step 37: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "Душегубки из стаи Зачарованного Крыла ({npc:3278}) держат запад местности {area:383}; кольца – у них.",

	-- Step 38: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "На восток: {area:1703}; {npc:9316} стоит в лагере сразу к югу.",

	-- Step 39: Nugget Slugs
	-- {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "Ведра с инструментами и слизнями лежат вокруг буровой площадки Торговой компании ({area:382}), к востоку от {npc:9316}.",

	-- Step 40: Wenikee Boltbucket
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar
	["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Сохраните: {quest:3923} стоит у ворот города {zone:1454}; сдадите в одном из следующих гайдов",

	-- Step 41: The Crossroads
	-- {area:380} The Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Вернитесь на юг к месту {area:380}. Отсюда начинается следующий гайд; он ведет в {zone:1454} и к дирижаблю в зону {zone:1420}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Оазисные хрустогрызы ({npc:3461}) ползают вокруг места {area:387}, к юго-западу от поселения {area:380}, и вокруг места {area:388}.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Равнинные долгоноги и яркочешуйчатые ящеры бродят по равнинам вокруг поселения {area:380}, гуще всего к северу.",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "К юго-востоку от поселения {area:380}. Проверьте семена у бурлящей расщелины на восточном берегу оазиса.",
	-- ["The {area:383}"] = "{area:383}",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "Тун'грим разбил лагерь у дороги из поселения {area:380} в {area:392}. {object:58369} стоит на юге лагеря Иглогривых, сразу к северу от него.",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Вернитесь на юг: {area:380}. Отсюда начинается следующий гайд; он ведет в {zone:1454} и к дирижаблю в зону {zone:1420}.",
	-- ["Walk back west along the road to the {area:380}."] = "Вернитесь по дороге на запад: {area:380}.",
}
