-- French (frFR): the guide forever/alliance/skyborne/01-zephras-isle (forever/alliance/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Grove
	-- {area:16622} Thendal Grove · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker · {npc:251368} Elatrell Featherlight
	["You wake in {area:16622}. {npc:251362} stands beside you; {npc:251361} is a few steps west, {npc:251368} by the south edge of the grove."] = "Vous vous réveillez à {area:16622}. {npc:251362} est à côté de vous ; {npc:251361} est à quelques pas à l'ouest, {npc:251368} près de la lisière sud du bosquet.",

	-- Step 2: Vuldren and Cirrusflies
	["Vuldren and Cirrusflies"] = "Vuldrènes et mouches-cirrus",
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} and Pesky Cirrusflies roam the meadow just south-east of the grove."] = "{npc:250873} et Mouches-cirrus agaçantes errent dans la prairie juste au sud-est du bosquet.",

	-- Step 3: Back to Thendal Grove
	-- {area:16622} Thendal Grove
	["Back to {area:16622}"] = "Retour à {area:16622}",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361} : {item:4100}",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, dans la tour de guet",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361} : un mot de votre maître",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361} : lisez {item:9547}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}, dans la tour de guet",
	-- {npc:251379} Dorii Brightwhisper · {item:282416} Glowing Recall Crystal
	["{npc:251379}, the mage trainer: read the {item:282416} first"] = "{npc:251379}, le maître des mages : lisez d'abord {item:282416}",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}, le maître des druides, au rez-de-chaussée de l'arbre derrière {npc:251361}",
	["The class trainers stand together in the grove"] = "Les maîtres de classe se tiennent ensemble dans le bosquet",
	-- {npc:257554} Halaan Hawk-Eye
	["Listen to {npc:257554}"] = "Écouter {npc:257554}",
	-- {spell:1259416} Walk on Air
	["Use {spell:1259416}"] = "Utilisez {spell:1259416}",

	-- Step 4: Raw Windstones and the Cirrusfly Queen
	-- {npc:251404} Cirrusfly Queen
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones and the {npc:251404}"] = "Pierres de vent brutes et {npc:251404}",
	-- {quest:92463} The Cirrusfly Queen · {npc:249363} Yala Windwatcher
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones glitter on the ground just south of the grove. {quest:92463} hovers over the meadow further east, on the way to {npc:249363}."] = "Les Pierres de vent brutes scintillent au sol juste au sud du bosquet. {quest:92463} plane au-dessus de la prairie plus à l'est, sur le chemin de {npc:249363}.",

	-- Step 5: Yala Windwatcher
	-- {npc:249363} Yala Windwatcher · {npc:251143} Roiling Winds · {object:460002} Ley Line (no name in this language: may be words) · {spell:1259705} Read Leyline
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your {spell:1259705} racial ability at it."] = "{npc:249363} monte la garde à l'est du bosquet. {npc:251143} et des Convertis al'aketh ({npc:251160}) se rassemblent juste au nord d'elle ; la ligne tellurique s'élève plus au nord : utilisez-y votre capacité raciale {spell:1259705}.",
	-- {spell:1259705} Read Leyline · {object:460002} Ley Line (no name in this language: may be words)
	["Cast {spell:1259705} at the {object:460002}"] = "Utilisez votre capacité raciale {spell:1259705} sur la ligne tellurique",

	-- Step 6: Thendal Grove turn-ins
	-- {area:16622} Thendal Grove
	["{area:16622} turn-ins"] = "Quêtes à rendre à {area:16622}",
	["Level 4 spells"] = "Sorts de niveau 4",

	-- Step 7: Scrawny Ursera and Urs'anah
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	["{npc:250926} and {npc:251115}"] = "{npc:250926} et {npc:251115}",
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	-- plural, as words: Ursera Scavengers = {npc:250937} Ursera Scavenger
	["{npc:250926} prowl the woods just west of the grove; the Ursera Scavengers den further west, with {npc:251115}, the matriarch, at the back of the den."] = "{npc:250926} rôdent dans les bois juste à l'ouest du bosquet ; les Charognards ursera ont leur tanière plus à l'ouest, avec {npc:251115}, la matriarche, au fond.",

	-- Step 8: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {npc:256935} Malduko Cloudcrush
	["{npc:252095} camps south of the Ursera den. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle."] = "{npc:252095} campe au sud de la tanière des ursera. Les voyous al'aketh tiennent le camp au sud-ouest ; {npc:256935} se tient en son centre.",

	-- Step 9: Aetheen of the Gales
	["Level 6 spells"] = "Sorts de niveau 6",

	-- Step 10: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:263664} Raan Wildwind · {npc:251523} Constable Aonda · {npc:251903} Rathiril Sunlance
	["Follow the road south to {area:16624}. {npc:263664} camps by the fire west of the village; {npc:251523} and {npc:251903} stand in its middle."] = "Suivez la route vers le sud jusqu'à {area:16624}. {npc:263664} campe près du feu à l'ouest du village ; {npc:251523} et {npc:251903} se tiennent au centre.",
	-- {npc:251903} Rathiril Sunlance · {npc:254089} Coriella Calmbreeze
	["Speak with {npc:251903} and {npc:254089}, north-west of the village"] = "Parler à {npc:251903} et {npc:254089}, au nord-ouest du village",

	-- Step 11: Raan Wildwind
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "/s'asseoir près du feu de {npc:263664} jusqu'à obtenir {spell:1229451}",

	-- Step 12: Village quests
	["Village quests"] = "Quêtes du village",
	["The bounty board"] = "Le tableau des primes",

	-- Step 13: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "Fièregriffes et trotteurs des trombes",
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders roam the grasslands south of the village. Galestriders drop both the eggs and the meat."] = "Les Fièregriffes et les Trotteurs des trombes errent dans les prairies au sud du village. Les Trotteurs des trombes lâchent les œufs et la viande.",

	-- Step 14: Back to Shen'dar
	["Back to Shen'dar"] = "Retour à Shen'dar",

	-- Step 15: The Highlands bandits
	["The Highlands bandits"] = "Les bandits des hautes-terres",
	-- plural, as words: Highlands Bandits = {npc:251918} Highlands Bandit
	["The Highlands Bandits camp north-east of the village. \"Badwind\" Bennic waits at the far north end of their camp."] = "Les Bandits des hautes-terres campent au nord-est du village. Bennic « Mauvais vent » attend tout au nord de leur camp.",

	-- Step 16: Shen'dar turn-ins
	["Shen'dar turn-ins"] = "Quêtes à rendre à Shen'dar",

	-- Step 17: Falaath Village
	-- {npc:257065} Missionary Jasaan · {quest:92529} Falaath Village · {spell:1254832} Mark of Akir
	["{npc:257065} waits at the entrance to {quest:92529}, south of Shen'dar. The {spell:1254832} lets you walk in among the faithful."] = "{npc:257065} attend à l'entrée de {quest:92529}, au sud de Shen’dar. {spell:1254832} vous permet d'entrer parmi les fidèles.",
	["Search the wardrobe"] = "Fouiller l'armoire",

	-- Step 19: Havoc in Falaath
	["Havoc in Falaath"] = "Chaos à Falaath",
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	["Back in {quest:92529}: Stormcallers and {npc:251662} fill the village, the Stormcallers carry the stolen supplies, and {npc:251966} stands at its south end."] = "De retour à {quest:92529} : des Mande-foudre al'aketh et {npc:251662} emplissent le village, les Mande-foudre portent les provisions volées, et {npc:251966} se tient au sud.",

	-- Step 20: The Western Watch
	-- {npc:252155} Peacekeeper Vaaniel · {npc:256966} Skypriest Aanders
	["{npc:252155} holds the western watch, south-west of Falaath. {npc:256966} and the fallen guards lie just south of her."] = "{npc:252155} tient le poste de guet ouest, au sud-ouest de Falaath. {npc:256966} et les gardes tombés gisent juste au sud.",
	-- {item:254871} Bloody Note
	["The {item:254871}"] = "{item:254871}",

	-- Step 21: The hippogryph roost
	["The hippogryph roost"] = "Le perchoir des hippogriffes",
	-- {item:263493} Hippogryph Down
	["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them."] = "Allez au nord-ouest jusqu'aux nids d'hippogriffes sur les falaises ouest. {item:263493} se trouve autour des nids ; la Matriarche hippogriffe patrouille parmi eux.",

	-- Step 22: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	["{npc:254589} lurks in the hills south-west of the village, on the way back. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} rôde dans les collines au sud-ouest du village, sur le chemin du retour. {npc:254589} est un élite : mieux vaut être en groupe.",

	-- Step 23: Windshaper Novice Seers
	-- plural, as words: Windshaper Novice Seers = {npc:257532} Windshaper Novice Seer
	["Windshaper Novice Seers"] = "Voyants novices des Sculpte-vents",
	["The Novice Seers practise in the clearing west of Shen'dar."] = "Les Voyants novices s'entraînent dans la clairière à l'ouest de Shen'dar.",

	-- Step 24: Shen'dar Village again
	-- {area:16624} Shen'dar Village
	["{area:16624} again"] = "De nouveau {area:16624}",

	-- Step 25: The road to Valanaar
	-- {area:16638} Valanaar
	["The road to {area:16638}"] = "La route de {area:16638}",
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield · {area:16638} Valanaar
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Take the road south-east. {npc:257006} and {npc:252448} stand by the road west of {area:16638}; Windsong Crawlers line the shore further west, around 51,70."] = "Prenez la route vers le sud-est. {npc:257006} et {npc:252448} se tiennent au bord de la route à l'ouest de {area:16638} ; des Clampants chantevent bordent le rivage plus à l'ouest, vers 51,70.",

	-- Step 26: Valanaar
	-- {npc:252383} Valennia Stormfist · {npc:252476} Talaanis Shadowsong · {area:16638} Valanaar · {npc:252475} Elaadrin Evengale · {npc:253204} Dondallion Whisperwind
	["{npc:252383} and {npc:252476} stand at the north end of {area:16638}, {npc:252475} and {npc:253204} at the south end."] = "{npc:252383} et {npc:252476} se tiennent au nord de {area:16638}, {npc:252475} et {npc:253204} au sud.",

	-- Step 27: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Sauteciels",
	-- {area:16638} Valanaar
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers swarm the fields west of {area:16638}."] = "Les Sauteciels pullulent dans les champs à l'ouest de {area:16638}.",

	-- Step 28: The missing scholar
	["The missing scholar"] = "L’érudit disparu",
	-- {object:581822} Bloodstained Satchel · {area:16638} Valanaar
	-- plural, as words: Shriekling Matriarchs = {npc:253283} Shriekling Matriarch
	["The {object:581822} lies by the path west of {area:16638}; Fillion's camp is north-west of it, and the Shriekling Matriarchs nest just west of the camp."] = "{object:581822} est au bord du chemin à l'ouest de {area:16638} ; le camp de Fillion est au nord-ouest, et les Matriarches criailleuses nichent juste à l'ouest du camp.",
	-- {object:581822} Bloodstained Satchel
	["The {object:581822}"] = "{object:581822}",
	["Find Fillion and his bedroll"] = "Trouver Fillion et son sac de couchage",

	-- Step 29: Aamelia Windfield
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} runs the farm in the south-west lowlands."] = "{npc:252800} tient la ferme dans les basses terres du sud-ouest.",

	-- Step 30: The Windfield farm
	["The Windfield farm"] = "La ferme Windfield",
	-- {quest:92683} Flutterfly Dust · {npc:250929} Malfunctioning Cyclone Construct
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple · Hungry Bandits = {npc:252802} Hungry Bandit · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Ripe Stormapples and Hungry Bandits are in the orchard by the farm, {quest:92683} in the fields north-east of it, Ornery Galestriders all around. The {npc:250929} stands in the field north-east of the farm."] = "Les Pommes d’orage mûres et les Bandits affamés sont dans le verger près de la ferme, {quest:92683} dans les champs au nord-est, et les Trotteurs des trombes hargneux tout autour. {npc:250929} se tient dans le champ au nord-est de la ferme.",

	-- Step 31: Aamelia Windfield again
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} again"] = "De nouveau {npc:252800}",

	-- Step 32: Bandit Highwaymen
	["Bandit Highwaymen"] = "Bandits de grand chemin",
	["The Bandit Highwaymen hold the hills north of the farm."] = "Les Bandits de grand chemin tiennent les collines au nord de la ferme.",

	-- Step 33: Standing our ground
	["Standing our ground"] = "Tenir bon",
	-- {npc:252800} Aamelia Windfield · {npc:252863} Ferauu the Bludgeon
	["Stand with {npc:252800} against {npc:252863}"] = "Combattre {npc:252863} aux côtés d'{npc:252800}",

	-- Step 34: Valanaar turn-ins
	-- {area:16638} Valanaar
	["{area:16638} turn-ins"] = "Quêtes à rendre à {area:16638}",
	-- {npc:252377} Seena Skybreaker · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["{npc:252377}: {npc:257196} waits at the {area:16629}"] = "{npc:252377} : {npc:257196} attend à {area:16629}",
	-- {npc:252373} Anathamaas Aetherwind
	["{npc:252373}, the mage trainer"] = "{npc:252373}, le maître des mages",

	-- Step 35: Taming the Beast
	-- {item:15908} Taming Rod · {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {npc:254411} Quel'dora Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler · Vuldren Alphas = {npc:250874} Vuldren Alpha · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Each of Quel'ana's quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her in {area:16638}. Windsong Crawlers line the shore west of town; Vuldren Alphas and Ornery Galestriders roam the {area:16626} around the Windfield farm. Her sister {npc:254411} stands beside her."] = "Chaque quête de Quel'ana vous remet un {item:15908} : utilisez-le sur la bête qu'elle désigne, puis rapportez-le-lui à {area:16638}. Les Clampants chantevent bordent le rivage à l'ouest de la ville ; les Alphas vuldrènes et les Trotteurs des trombes hargneux errent dans {area:16626} autour de la ferme Windfield. Sa sœur {npc:254411} se tient à côté d'elle.",
	-- {npc:254588} Windsong Crawler · {item:15908} Taming Rod
	["{npc:254588}: tame it with the {item:15908}"] = "{npc:254588} : apprivoisez-le avec le {item:15908}",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "L'apprivoiser avec le {item:15908}",

	-- Step 36: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "Les Formations de pierre des vents",
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations stand on the rise west of Fillion's camp."] = "Les Formations de pierre des vents se dressent sur la butte à l'ouest du camp de Fillion.",
	-- {item:262668} Wind-Infused Bough · {quest:92529} Falaath Village
	["{item:262668}: by the wind shrine south of {quest:92529}"] = "{item:262668} : près du sanctuaire du vent au sud de {quest:92529}",

	-- Step 38: The eastern watchtower
	["The eastern watchtower"] = "La tour de guet est",
	-- {npc:252378} Yorana Windyreed · {area:16638} Valanaar · {npc:252666} Commander Belguilos
	["{npc:252378} holds the watchtower north of {area:16638}. The Al'Aketh camp is just west of the tower, its healers around 65,68 and 65,65; {npc:252666} stands at its north end. The Al'Aketh there drop Windstone Charms."] = "{npc:252378} tient la tour de guet au nord de {area:16638}. Le camp al'aketh est juste à l'ouest de la tour, ses soigneurs vers 65,68 et 65,65 ; {npc:252666} se tient au nord du camp. Les Al'aketh y lâchent des Charmes de pierre de vent al’aketh.",

	-- Step 39: Valanaar, the turncoat
	-- {area:16638} Valanaar
	["{area:16638}, the turncoat"] = "{area:16638}, le traître",

	-- Step 40: Urs'endris
	-- {npc:255853} Urs'endris · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands
	["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623} west of {area:16638}, by the road you take next."] = "{npc:255853} attend près des chutes au nord-est de {area:16638}. {npc:258443} rôde dans {area:16623} à l'ouest de {area:16638}, près de la route que vous prendrez ensuite.",

	-- Step 41: The dead cultist
	["The dead cultist"] = "Le cultiste mort",
	-- {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["North-west of Valanaar along the road: {npc:273017} watches the {quest:98512}; the dead cultist lies just north of him."] = "Au nord-ouest de Valanaar, le long de la route : {npc:273017} surveille {quest:98512} ; le cultiste mort gît juste au nord.",
	["Search the dead cultist"] = "Fouiller le cultiste mort",
	-- {npc:258443} Ur'endra
	["{npc:258443}, in the highlands south-west of the cultist"] = "{npc:258443}, dans les hautes-terres au sud-ouest du cultiste",

	-- Step 42: Desperate times
	["Desperate times"] = "Temps désespérés",
	-- {npc:251968} Ayessa Dawnsinger · {npc:252475} Elaadrin Evengale
	["Rally Valennia, {npc:251968} (west of town) and {npc:252475}"] = "Rallier Valennia, {npc:251968} (à l'ouest de la ville) et {npc:252475}",
	["Meet Valennia at the gate"] = "Rejoindre Valennia à la porte",

	-- Step 43: Strength and Mercy
	-- {npc:255853} Urs'endris · {area:16638} Valanaar
	["Back to {npc:255853} by the falls north-east of {area:16638}, on the way north to the shrine."] = "Retournez voir {npc:255853} près des chutes au nord-est de {area:16638}, sur le chemin du sanctuaire au nord.",

	-- Step 44: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {npc:253576} Hyusaa Quickbreeze · {npc:253590} Valennia Stormfist
	["Fight north to the {area:16629}. Guardians, Spiritcallers and Blademasters hold the approach; {npc:253576} waits at the shrine's door, {npc:253590} inside the inner sanctum."] = "Frayez-vous un chemin vers le nord jusqu'à {area:16629}. Des Gardiens, Mande-esprit et Maîtres-lames al'aketh tiennent l'accès ; {npc:253576} attend à la porte du sanctuaire, {npc:253590} dans le sanctum intérieur.",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, in the sanctum"] = "{npc:253590}, dans le sanctum",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}: {npc:257196}, west of the shrine's approach"] = "{item:263993} : {npc:257196}, à l'ouest de l'accès au sanctuaire",

	-- Step 45: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}. {npc:257944} camps in its east."] = "Allez au nord dans {area:16631}. {npc:257944} campe dans sa partie est.",

	-- Step 46: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Stormchasers = {npc:252664} Al'Aketh Stormchaser
	["Al'Aketh Stormchasers and Footsoldiers camp just north of {npc:257944} and drop the heirloom; the Shrieklings west of her drop the feathers and talons; the {item:265105} grows along the stream west of her."] = "Les Chasse-tempêtes et Fantassins al'aketh campent juste au nord d'{npc:257944} et lâchent l'héritage ; les criailleuses à l'ouest lâchent les plumes et les serres ; {item:265105} pousse le long du ruisseau à l'ouest.",

	-- Step 47: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "De nouveau {npc:257944}",

	-- Step 48: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive
	["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}."] = "{npc:254151}, {npc:258130} et {npc:258134} sont au nord-est d'{npc:257944} ; {npc:253622} se tient à l'est d'eux. Haalien lâche aussi {quest:94490}.",
	-- {npc:258130} Jorel Windsinger
	["Heal 7 druids in the Nightfang Den, then find {npc:258130}"] = "Soigner 7 druides dans la tanière, puis trouver {npc:258130}",

	-- Step 49: Elegael Thornpaw, the missive
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the missive"] = "{npc:257944}, la missive",

	-- Step 50: The Strange Hermit
	-- {quest:93159} The Strange Hermit · {npc:257944} Elegael Thornpaw
	-- plural, as words: Zephyrseed Cones = {object:613238} Zephyrseed Cone
	["{quest:93159} lives west of {npc:257944}. The Zephyrseed Cones lie in the woods between his hut and {npc:257944}."] = "{quest:93159} vit à l'ouest d'{npc:257944}. Les Cônes de graine-de-zéphyr ({object:613238}) se trouvent dans les bois entre sa cabane et {npc:257944}.",

	-- Step 51: The refugees' camp
	["The refugees' camp"] = "Le camp des réfugiés",
	-- {item:266433} Abandoned Belongings · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["North of the cones: the Wind Hollows drift around the refugees' camp, the {item:266433} lie between the tents, and {npc:259013} lies at its north end."] = "Au nord des cônes : les Creux du vent dérivent autour du camp des réfugiés, {item:266433} sont entre les tentes, et {npc:259013} gît au nord du camp.",

	-- Step 52: Back to the Hermit
	["Back to the Hermit"] = "Retour à l'ermite",

	-- Step 53: High Priestess Lorthuna
	-- {area:16629} Shrine of Akir
	["Lorthuna waits on the eastern shore of the isle, east of the {area:16629}."] = "Lorthuna attend sur la rive est de l'île, à l'est de {area:16629}.",

	-- Step 54: Valanaar, the fate of Zephras
	-- {area:16638} Valanaar
	["{area:16638}, the fate of Zephras"] = "{area:16638}, le destin de Zephras",
	-- {npc:252475} Elaadrin Evengale · {npc:259084} Denaaris Stargale
	["{npc:252475}: {npc:259084} waits by the Skyborne portal"] = "{npc:252475} : {npc:259084} attend près du portail éolide",

	-- Step 55: The skycutter
	["The skycutter"] = "Le fend-ciel",
	-- {area:16638} Valanaar · {area:279} Dalaran
	["The skycutter docks at the tower south of {area:16638}. It lands by the Kirin Tor camp on the lake shore west of {area:279}."] = "Le fend-ciel accoste à la tour au sud de {area:16638}. Il se pose près du camp du Kirin Tor sur la rive du lac, à l'ouest de {area:279}.",
	-- {area:279} Dalaran
	["Skycutter to {area:279}"] = "Fend-ciel pour {area:279}",

	-- Step 56: Denaaris Stargale
	-- {npc:259084} Denaaris Stargale · {zone:1453} Stormwind
	["{npc:259084} stands beside the Skyborne Portal where the zeppelin lands. The portal takes you to {zone:1453}."] = "{npc:259084} se tient près du portail éolide, là où le zeppelin se pose. Le portail vous mène à {zone:1453}.",
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind
	["{npc:270459}, beside {npc:259084}: for {npc:5504} in {zone:1453}"] = "{npc:270459}, à côté de {npc:259084} : pour {npc:5504} à {zone:1453}",

	-- Step 57: Stormwind Keep
	-- {object:2117} Stormwind Keep · {zone:1436} Westfall
	["Bolvar Fordragon stands in the throne room of {object:2117}, at the north end of the city. Then leave by the main gate for {zone:1436}."] = "Bolvar Fordragon se tient dans la salle du trône de {object:2117}, au nord de la ville. Sortez ensuite par la grande porte vers {zone:1436}.",
	-- {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["For {npc:234} at {area:108}"] = "Pour {npc:234} à {area:108}",

	-- Step 58: Sheldras Moontree
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form · {zone:1439} Darkshore
	["{npc:5504}, {zone:1453}'s druid trainer, teaches you {spell:18960}. {npc:11802}'s welcome waits for your {spell:499} trip at the end of {zone:1439}."] = "{npc:5504}, le maître des druides de {zone:1453}, vous enseigne {spell:18960}. L'accueil de {npc:11802} attend votre voyage en {spell:499} à la fin de {zone:1439}.",

	-- Step 59: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497} se tient dans la tour de {object:2101} ; elle vous donne une flasque pour la cascade de {quest:1861}.",

	-- Step 60: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Quittez {zone:1453} par la grande porte. La cascade de {quest:1861} est au sud-ouest des portes, sur la route de {zone:1436} à l'ouest : remplissez {item:7207} à son pied.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Read Ley Line at the {object:460002}"] = "Utilisez votre capacité raciale de lecture des lignes telluriques sur {object:460002}",
	-- ["Cast Read {object:460002} at the {object:460002}"] = "Lancer Read {object:460002} sur {object:460002}",
	-- ["Rorian: {quest:92485}"] = "Rorian : {quest:92485}",
	-- ["Tame Beast"] = "Apprivoise une bête",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read Ley Line racial ability at it."] = "{npc:249363} monte la garde à l'est du bosquet. {npc:251143} et des Convertis al'aketh ({npc:251160}) se rassemblent juste au nord d'elle ; {object:460002} s'élève plus au nord : utilisez-y votre capacité raciale de lecture des lignes telluriques.",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read {object:460002} racial ability at it."] = "{npc:249363} monte la garde à l'est du bosquet. {npc:251143} et les Convertis al'aketh se rassemblent juste au nord ; {object:460002} s'élève plus au nord : lancez-y votre technique raciale Read {object:460002}.",
	-- ["{npc:252377}: Defensive Stance"] = "{npc:252377} : Posture défensive",
	-- ["{npc:254411}: Beast Training"] = "{npc:254411} : Dressage des bêtes",
	-- ["{npc:255853}: Bear Form"] = "{npc:255853} : Forme d’ours",
	-- ["{npc:5504}, {zone:1453}'s druid trainer, teaches you Teleport: {quest:94914}. {npc:11802}'s welcome waits for your Cat Form trip at the end of {zone:1439}."] = "{npc:5504}, le maître des druides de {zone:1453}, vous apprend Téléportation : {quest:94914}. L'accueil de {npc:11802} attendra votre voyage pour la Forme de félin, à la fin de {zone:1439}.",
	-- ["{quest:93159} lives west of Elegael. The {item:257128} Cones lie in the woods between his hut and Elegael."] = "{quest:93159} vit à l'ouest d'Elegael. Les cônes de {item:257128} jonchent les bois entre sa cabane et Elegael.",
}
