-- French (frFR): the guide forever/alliance/skyborne/01-zephras-isle (forever/alliance/skyborne/01-zephras-isle.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Grove
	-- {area:16622} Thendal Grove · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker · {npc:251368} Elatrell Featherlight
	["You wake in {area:16622}. {npc:251362} stands beside you; {npc:251361} is a few steps west, {npc:251368} by the south edge of the grove."] = "Vous vous réveillez à {area:16622}. {npc:251362} est à côté de vous ; {npc:251361} est à quelques pas à l'ouest, {npc:251368} près de la lisière sud du bosquet.",

	-- Step 2: Thendal Grove: kill these as you meet them
	-- {area:16622} Thendal Grove
	["{area:16622}: kill these as you meet them"] = "{area:16622} : tuez-les au passage",
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} and Pesky Cirrusflies roam the meadow just south-east of the grove."] = "{npc:250873} et Mouches-cirrus agaçantes errent dans la prairie juste au sud-est du bosquet.",

	-- Step 3: Back to Thendal Grove
	-- {area:16622} Thendal Grove
	["Back to {area:16622}"] = "Retour à {area:16622}",
	-- {npc:257554} Halaan Hawk-Eye · {npc:263113} Myriaal Mistwake · {npc:251368} Elatrell Featherlight
	["{npc:257554} and {npc:263113} stand at the top of the watchtower, a few steps north-east of {npc:251368}."] = "{npc:257554} et {npc:263113} se tiennent au sommet de la tour de guet, à quelques pas au nord-est de {npc:251368}.",
	-- {npc:257554} Halaan Hawk-Eye
	["Listen to {npc:257554}"] = "Écouter {npc:257554}",

	-- Step 4: Rorian the Dayseeker
	-- {spell:1259416} Walk on Air · {npc:251361} Rorian the Dayseeker
	["Jump off the top of the watchtower and use {spell:1259416} to float down to {npc:251361}, west of the tower."] = "Sautez du haut de la tour de guet et utilisez {spell:1259416} pour descendre en planant jusqu'à {npc:251361}, à l'ouest de la tour.",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361} : {item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361} : un mot de votre maître",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361} : lisez {item:9547}",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, dans la tour de guet",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}, dans la tour de guet",
	-- {npc:251379} Dorii Brightwhisper · {item:282416} Glowing Recall Crystal
	["{npc:251379}, the mage trainer: read the {item:282416} first"] = "{npc:251379}, le maître des mages : lisez d'abord {item:282416}",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}, le maître des druides, au rez-de-chaussée de l'arbre derrière {npc:251361}",
	["The class trainers stand together in the grove"] = "Les maîtres de classe se tiennent ensemble dans le bosquet",

	-- Step 5: Raw Windstones and the Cirrusfly Queen
	-- {npc:251404} Cirrusfly Queen
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones and the {npc:251404}"] = "Pierres de vent brutes et {npc:251404}",
	-- {quest:92463} The Cirrusfly Queen · {npc:249363} Yala Windwatcher
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones glitter on the ground just south of the grove. {quest:92463} hovers over the meadow further east, on the way to {npc:249363}."] = "Les Pierres de vent brutes scintillent au sol juste au sud du bosquet. {quest:92463} plane au-dessus de la prairie plus à l'est, sur le chemin de {npc:249363}.",

	-- Step 6: Thendal Grove turn-ins
	-- {area:16622} Thendal Grove
	["{area:16622} turn-ins"] = "Quêtes à rendre à {area:16622}",

	-- Step 7: Yala Windwatcher
	-- {npc:249363} Yala Windwatcher · {npc:251143} Roiling Winds · {object:460002} Ley Line (no name in this language: may be words) · {spell:1259705} Read Leyline
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your {spell:1259705} racial ability at it."] = "{npc:249363} monte la garde à l'est du bosquet. {npc:251143} et des Convertis al'aketh ({npc:251160}) se rassemblent juste au nord d'elle ; la ligne tellurique s'élève plus au nord : utilisez-y votre capacité raciale {spell:1259705}.",
	-- {spell:1259705} Read Leyline · {object:460002} Ley Line (no name in this language: may be words)
	["Cast {spell:1259705} at the {object:460002}"] = "Utilisez votre capacité raciale {spell:1259705} sur la ligne tellurique",

	-- Step 9: Thendal Grove turn-ins
	["Level 4 spells"] = "Sorts de niveau 4",

	-- Step 10: Thendal Grove: kill these as you meet them
	-- {npc:251115} Urs'anah · {npc:250926} Scrawny Ursera
	-- plural, as words: Ursera Scavengers = {npc:250937} Ursera Scavenger
	["The Ursera Scavengers den west of the grove, with {npc:251115}, the matriarch, at the back of the den; {npc:250926} prowl the woods between the den and the grove."] = "",
	["Below ground"] = "Sous terre",
	-- {item:252665} Head of Urs'anah
	["{item:252665}; below ground"] = "{item:252665} ; sous terre",

	-- Step 11: Aetheen of the Gales
	["Back east out of the den to the grove."] = "",

	-- Step 12: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {npc:256935} Malduko Cloudcrush
	["{npc:252095} camps south-west of the grove, south of the Ursera den, on the way south to Shen'dar. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle.\nCareful: {npc:256935} casts shocks; drag him clear of the other cultists before fighting so they don't join in."] = "",

	-- Step 13: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:263664} Raan Wildwind · {npc:251523} Constable Aonda · {npc:251903} Rathiril Sunlance
	["Follow the road south to {area:16624}. {npc:263664} camps by the fire west of the village; {npc:251523} and {npc:251903} stand in its middle."] = "Suivez la route vers le sud jusqu'à {area:16624}. {npc:263664} campe près du feu à l'ouest du village ; {npc:251523} et {npc:251903} se tiennent au centre.",

	-- Step 14: Raan Wildwind
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "/sit près du feu de camp de {npc:263664} jusqu'à obtenir {spell:1229451}",
	-- {npc:251905} Zerril Softbreeze
	["{npc:251905}: Camping 101 asks you to learn it"] = "{npc:251905} : la quête Camping 101 vous demande de l'apprendre",

	-- Step 15: Village quests
	["Village quests"] = "Quêtes du village",

	-- Step 16: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "Fièregriffes et trotteurs des trombes",
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders roam the grasslands around the village. Galestriders drop both the eggs and the meat: most players get the eggs from the ones just west of the village."] = "",

	-- Step 17: Village quests
	["The bounty board"] = "Le tableau des primes",

	-- Step 19: Shen'dar Highlands: kill these as you meet them
	-- {area:16623} Shen'dar Highlands
	["{area:16623}: kill these as you meet them"] = "{area:16623} : tuez-les au passage",
	-- plural, as words: Highlands Bandits = {npc:251918} Highlands Bandit
	["The Highlands Bandits camp north-east of the village. \"Badwind\" Bennic waits at the far north end of their camp."] = "Les Bandits des hautes-terres campent au nord-est du village. Bennic « Mauvais vent » attend tout au nord de leur camp.",
	-- plural, as words: Highlands Bandits = {npc:251918} Highlands Bandit
	["Highlands Bandits"] = "",
	["\"Badwind\" Bennic, below ground"] = "Bennic « Mauvais vent », sous terre",

	-- Step 20: Shen'dar turn-ins
	["Shen'dar turn-ins"] = "Quêtes à rendre à Shen'dar",

	-- Step 21: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 22: Paladin trainer
	["Paladin trainer"] = "Maître des paladins",
	-- {npc:5148} Beldruk Doombrow · {zone:1455} Ironforge · {area:16624} Shen'dar Village
	["{npc:5148} in {zone:1455}; {area:16624} has no paladin trainer"] = "{npc:5148} à {zone:1455} ; {area:16624} n'a pas de maître des paladins",

	-- Step 23: Priest trainer
	["Priest trainer"] = "Maître des prêtres",
	-- {zone:1438} Teldrassil · {area:16624} Shen'dar Village
	["Lariia in {zone:1438}; {area:16624} has no priest trainer"] = "Lariia à {zone:1438} ; {area:16624} n'a pas de maître des prêtres",

	-- Step 24: Shaman trainer
	["Shaman trainer"] = "Maître des chamans",
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {area:16624} Shen'dar Village
	["{npc:258098} in {zone:1455}; {area:16624} has no shaman trainer"] = "{npc:258098} à {zone:1455} ; {area:16624} n'a pas de maître des chamans",

	-- Step 25: Warlock trainer
	["Warlock trainer"] = "Maître des démonistes",
	-- {item:2450} Briarthorn · {zone:1455} Ironforge · {area:16624} Shen'dar Village
	["{item:2450} in {zone:1455}; {area:16624} has no warlock trainer"] = "{item:2450} à {zone:1455} ; {area:16624} n'a pas de maître des démonistes",

	-- Step 26: Falaath Village
	-- {npc:257065} Missionary Jasaan · {quest:92529} Falaath Village · {spell:1254832} Mark of Akir
	["{npc:257065} waits at the entrance to {quest:92529}, south of Shen'dar. The {spell:1254832} lets you walk in among the faithful."] = "{npc:257065} attend à l'entrée de {quest:92529}, au sud de Shen’dar. {spell:1254832} vous permet d'entrer parmi les fidèles.",
	["Search the wardrobe"] = "Fouiller l'armoire",

	-- Step 27: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	["{npc:254589} lurks in the hills south-west of the village, on the way back. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} rôde dans les collines au sud-ouest du village, sur le chemin du retour. {npc:254589} est un élite : mieux vaut être en groupe.",

	-- Step 29: Shen'dar Highlands: kill these as you meet them
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	["Back in {quest:92529}: Stormcallers and {npc:251662} fill the village, the Stormcallers carry the stolen supplies, and {npc:251966} stands at its south end."] = "De retour à {quest:92529} : des Mande-foudre al'aketh et {npc:251662} emplissent le village, les Mande-foudre portent les provisions volées, et {npc:251966} se tient au sud.",

	-- Step 30: The Western Watch
	-- {npc:252155} Peacekeeper Vaaniel · {npc:256966} Skypriest Aanders
	["{npc:252155} holds the western watch, south-west of Falaath. {npc:256966} and the fallen guards lie just south of her."] = "{npc:252155} tient le poste de guet ouest, au sud-ouest de Falaath. {npc:256966} et les gardes tombés gisent juste au sud.",
	-- {item:254871} Bloody Note
	["The {item:254871}"] = "{item:254871}",

	-- Step 31: Shen'dar Highlands: kill these as you meet them
	-- {item:263493} Hippogryph Down
	["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them.\nThe Novice Seers practise in the clearing west of Shen'dar, on the way back to the village."] = "",

	-- Step 32: Shen'dar Village again
	-- {area:16624} Shen'dar Village
	["{area:16624} again"] = "De nouveau {area:16624}",

	-- Step 33: Fendaal Windstone
	-- {area:16638} Valanaar · {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["On the road south-east to {area:16638}, {npc:273017} watches the {quest:98512} just north of him."] = "",

	-- Step 34: Valanaar, the turncoat
	-- {area:16638} Valanaar
	["{area:16638}, the turncoat"] = "{area:16638}, le traître",

	-- Step 35: Valanaar
	-- {npc:252383} Valennia Stormfist · {npc:252476} Talaanis Shadowsong · {area:16638} Valanaar · {npc:252475} Elaadrin Evengale · {npc:253204} Dondallion Whisperwind
	["{npc:252383} and {npc:252476} stand at the north end of {area:16638}, {npc:252475} and {npc:253204} at the south end."] = "{npc:252383} et {npc:252476} se tiennent au nord de {area:16638}, {npc:252475} et {npc:253204} au sud.",
	-- {npc:252476} Talaanis Shadowsong
	["{npc:252476}, upstairs"] = "{npc:252476}, à l'étage",
	-- {npc:252383} Valennia Stormfist
	["{npc:252383}, upstairs"] = "{npc:252383}, à l'étage",

	-- Step 37: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Sauteciels",
	-- {area:16638} Valanaar
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers swarm the fields west of {area:16638}."] = "Les Sauteciels pullulent dans les champs à l'ouest de {area:16638}.",
	-- {npc:260628} Valennia Stormfist
	["{npc:260628}, upstairs"] = "",

	-- Step 38: The road to Valanaar
	-- {area:16638} Valanaar
	["The road to {area:16638}"] = "La route de {area:16638}",
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield · {area:16638} Valanaar · {npc:252377} Seena Skybreaker · {npc:252389} Quel'ana Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["{npc:257006} and {npc:252448} stand on {area:16638}'s west side, beside the inn; {npc:252377} and {npc:252389} train just west of {npc:257006}. Windsong Crawlers line the shore further west, around 51,70."] = "{npc:257006} et {npc:252448} se tiennent du côté ouest de {area:16638}, à côté de l'auberge ; {npc:252377} et {npc:252389} s'entraînent juste à l'ouest de {npc:257006}. Des Clampants chantevent bordent le rivage plus à l'ouest, vers 51,70.",
	-- {npc:252377} Seena Skybreaker · {npc:257006} Nyalah Brightfire · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["{npc:252377}, beside {npc:257006}: {npc:257196} holds the Bulwark at the {area:16629}"] = "{npc:252377}, à côté de {npc:257006} : {npc:257196} détient le Rempart au {area:16629}",
	-- {npc:252389} Quel'ana Quickgale · {npc:257006} Nyalah Brightfire · {item:15908} Taming Rod
	["{npc:252389}, beside {npc:257006}: the first {item:15908}"] = "{npc:252389}, à côté de {npc:257006} : le premier {item:15908}",
	-- {npc:255940} Donaal Downbreeze
	["Innkeeper {npc:255940}, by the west gate"] = "L'aubergiste {npc:255940}, près de la porte ouest",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "Écoutez l'histoire de {npc:252448}",
	-- {npc:257006} Nyalah Brightfire
	["{npc:257006}, inside"] = "{npc:257006}, à l'intérieur",

	-- Step 41: The missing scholar
	["The missing scholar"] = "L’érudit disparu",
	-- {object:581822} Bloodstained Satchel · {area:16638} Valanaar
	["The {object:581822} lies by the path west of {area:16638}."] = "La {object:581822} se trouve près du chemin à l'ouest de {area:16638}.",
	-- {object:581822} Bloodstained Satchel
	["The {object:581822}"] = "{object:581822}",

	-- Step 42: Gustberry Lowlands
	-- {npc:254588} Windsong Crawler · {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:254588}, among the crabs: tame one with {npc:252389}'s first {item:15908} while you are there"] = "{npc:254588}, parmi les crabes : apprivoisez-en un avec le premier {item:15908} de {npc:252389} tant que vous y êtes",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "Apprivoisez : {npc:254588}",
	["Underwater"] = "Sous l'eau",

	-- Step 43: The missing scholar
	-- plural, as words: Shriekling Matriarchs = {npc:253283} Shriekling Matriarch
	["Fillion's camp is north-west of it, and the Shriekling Matriarchs nest just west of the camp."] = "Le camp de Fillion se trouve au nord-ouest, et les Matriarches criailleuses nichent juste à l'ouest du camp.",
	-- {item:257107} Shriekling Matriarch's Head
	["{item:257107}; below ground"] = "{item:257107} ; sous terre",

	-- Step 44: Aamelia Windfield
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} runs the farm in the south-west lowlands."] = "{npc:252800} tient la ferme dans les basses terres du sud-ouest.",

	-- Step 45: Gustberry Lowlands: kill these as you meet them
	-- {area:16626} Gustberry Lowlands
	["{area:16626}: kill these as you meet them"] = "{area:16626} : tuez-les au passage",
	-- {quest:92683} Flutterfly Dust · {npc:250929} Malfunctioning Cyclone Construct
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple · Hungry Bandits = {npc:252802} Hungry Bandit · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Ripe Stormapples and Hungry Bandits are in the orchard by the farm, {quest:92683} in the fields north-east of it, Ornery Galestriders all around. The {npc:250929} stands in the field north-east of the farm."] = "Les Pommes d’orage mûres et les Bandits affamés sont dans le verger près de la ferme, {quest:92683} dans les champs au nord-est, et les Trotteurs des trombes hargneux tout autour. {npc:250929} se tient dans le champ au nord-est de la ferme.",

	-- Step 46: Aamelia Windfield again
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} again"] = "De nouveau {npc:252800}",
	-- {npc:252800} Aamelia Windfield
	["Back to {npc:252800} at the farmhouse."] = "",

	-- Step 47: Bandit Highwaymen
	["Bandit Highwaymen"] = "Bandits de grand chemin",
	["The Bandit Highwaymen hold the hills north of the farm."] = "Les Bandits de grand chemin tiennent les collines au nord de la ferme.",

	-- Step 48: Standing our ground
	["Standing our ground"] = "Tenir bon",
	-- {npc:252800} Aamelia Windfield
	["{npc:252800}, at the farmhouse"] = "",
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "Dites à {npc:252800} que vous êtes prêt",

	-- Step 49: Valanaar turn-ins
	-- {area:16638} Valanaar
	["{area:16638} turn-ins"] = "Quêtes à rendre à {area:16638}",
	-- {npc:252359} Lotheluum Starbreeze · {quest:94006} The Great Ursera Spirit
	["{npc:252359}, between the west gate and Valennia's house: {quest:94006}"] = "",

	-- Step 50: Valanaar turn-ins
	-- {npc:252373} Anathamaas Aetherwind
	["{npc:252373}, the mage trainer"] = "{npc:252373}, le maître des mages",

	-- Step 51: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod · {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider · Vuldren Alphas = {npc:250874} Vuldren Alpha
	["{npc:252389} takes back the first {item:15908} and hands you two more, one at a time: Ornery Galestriders and Vuldren Alphas roam the fields just north of her. Tame each with its rod and bring the rod back to her. {npc:254411}, beside her, teaches {spell:5149}."] = "{npc:252389} reprend le premier {item:15908} et vous en donne deux autres, l'un après l'autre : des Trotteurs des trombes hargneux et des Alphas vuldrènes parcourent les champs juste au nord d'elle. Apprivoisez chacun avec son bâtonnet et rapportez-lui le bâtonnet. {npc:254411}, à côté d'elle, enseigne {spell:5149}.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "L'apprivoiser avec le {item:15908}",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "Apprivoisez : {npc:251707}",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "Apprivoisez : {npc:250874}",

	-- Step 52: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "Les Formations de pierre des vents",
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations stand on the rise west of Fillion's camp."] = "Les Formations de pierre des vents se dressent sur la butte à l'ouest du camp de Fillion.",
	-- {item:262668} Wind-Infused Bough
	["{item:262668}: by the formations"] = "{item:262668} : près des formations",

	-- Step 54: The eastern watchtower
	["The eastern watchtower"] = "La tour de guet est",
	-- {npc:252378} Yorana Windyreed · {area:16638} Valanaar · {npc:252666} Commander Belguilos
	["{npc:252378} holds the watchtower north of {area:16638}. The Al'Aketh camp is just west of the tower, its healers around 65,68 and 65,65; {npc:252666} stands at its north end. The Al'Aketh there drop Windstone Charms."] = "{npc:252378} tient la tour de guet au nord de {area:16638}. Le camp al'aketh est juste à l'ouest de la tour, ses soigneurs vers 65,68 et 65,65 ; {npc:252666} se tient au nord du camp. Les Al'aketh y lâchent des Charmes de pierre de vent al’aketh.",

	-- Step 55: Urs'endris
	-- {npc:255853} Urs'endris · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands · {area:16638} Valanaar
	["{npc:255853} waits by the falls just north of the watchtower. {npc:258443} prowls the {area:16623} south-west of the dead cultist, where you go after {area:16638}."] = "",

	-- Step 57: The dead cultist
	["The dead cultist"] = "Le cultiste mort",
	-- {npc:273017} Fendaal Windstone
	["North-west of Valanaar along the road, past {npc:273017}: the dead cultist lies just north of him."] = "",
	["Search the dead cultist"] = "Fouiller le cultiste mort",
	["Inside"] = "À l'intérieur",
	-- {npc:258443} Ur'endra
	["{npc:258443}, in the highlands south-west of the cultist"] = "{npc:258443}, dans les hautes-terres au sud-ouest du cultiste",

	-- Step 58: Desperate times
	["Desperate times"] = "Temps désespérés",
	["Upstairs"] = "À l'étage",

	-- Step 60: Paladin trainer
	-- {npc:5148} Beldruk Doombrow · {zone:1455} Ironforge · {area:16638} Valanaar
	["{npc:5148} in {zone:1455}; {area:16638} has no paladin trainer"] = "{npc:5148} à {zone:1455} ; {area:16638} n'a pas de maître des paladins",

	-- Step 61: Priest trainer
	-- {npc:5141} Theodrus Frostbeard · {zone:1455} Ironforge · {area:16638} Valanaar
	["{npc:5141} in {zone:1455}; {area:16638} has no priest trainer"] = "{npc:5141} à {zone:1455} ; {area:16638} n'a pas de maître des prêtres",

	-- Step 62: Shaman trainer
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {area:16638} Valanaar
	["{npc:258098} in {zone:1455}; {area:16638} has no shaman trainer"] = "{npc:258098} à {zone:1455} ; {area:16638} n'a pas de maître des chamans",

	-- Step 63: Warlock trainer
	-- {item:2450} Briarthorn · {zone:1455} Ironforge · {area:16638} Valanaar
	["{item:2450} in {zone:1455}; {area:16638} has no warlock trainer"] = "{item:2450} à {zone:1455} ; {area:16638} n'a pas de maître des démonistes",

	-- Step 64: Desperate times
	-- {npc:253844} Valennia Stormfist
	["Meet {npc:253844} at the gate"] = "Retrouvez {npc:253844} à la porte",
	-- {npc:255853} Urs'endris · {area:16638} Valanaar · {spell:5487} Bear Form
	["{npc:255853}, by the falls north-east of {area:16638}, on the way north: {spell:5487}"] = "{npc:255853}, près des chutes au nord-est de {area:16638}, en chemin vers le nord : {spell:5487}",

	-- Step 65: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}. {npc:257944} camps in its east."] = "Allez au nord dans {area:16631}. {npc:257944} campe dans sa partie est.",

	-- Step 66: Shadowgale Forest: kill these as you meet them
	-- {area:16631} Shadowgale Forest
	["{area:16631}: kill these as you meet them"] = "{area:16631} : tuez-les au passage",
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Stormchasers = {npc:252664} Al'Aketh Stormchaser
	["Al'Aketh Stormchasers and Footsoldiers camp just north of {npc:257944} and drop the heirloom; the Shrieklings west of her drop the feathers and talons; the {item:265105} grows along the stream west of her."] = "Les Chasse-tempêtes et Fantassins al'aketh campent juste au nord d'{npc:257944} et lâchent l'héritage ; les criailleuses à l'ouest lâchent les plumes et les serres ; {item:265105} pousse le long du ruisseau à l'ouest.",

	-- Step 67: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "De nouveau {npc:257944}",

	-- Step 68: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:254151}, {npc:258130} et {npc:258134} se trouvent au nord-est de {npc:257944} ; {npc:253622} se tient à l'est d'eux. Haalien laisse aussi tomber une {quest:94490}. Pour {quest:94489}, entrez dans la tanière de Croc-de-nuit, soignez 7 druides blessés et trouvez {npc:258130}.",
	["Heal the injured druids in the Nightfang Den"] = "Soignez les druides blessés dans la tanière des Crocs-de-la-nuit",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "Trouvez {npc:258130}",
	-- {item:258771} Al'Aketh Cultist's Ear · {npc:254151} Vayn Moongaze
	["{item:258771}: the Stormchasers and Footsoldiers around {npc:254151}'s camp"] = "",

	-- Step 69: Elegael Thornpaw, the missive
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the missive"] = "{npc:257944}, la missive",

	-- Step 70: The Strange Hermit
	-- {quest:93159} The Strange Hermit · {npc:257944} Elegael Thornpaw
	-- plural, as words: Zephyrseed Cones = {object:613238} Zephyrseed Cone
	["{quest:93159} lives west of {npc:257944}. The Zephyrseed Cones lie in the woods between his hut and {npc:257944}."] = "{quest:93159} vit à l'ouest d'{npc:257944}. Les Cônes de graine-de-zéphyr ({object:613238}) se trouvent dans les bois entre sa cabane et {npc:257944}.",

	-- Step 71: Ruins of Ban'aethal: kill these as you meet them
	-- {area:16833} Ruins of Ban'aethal
	["{area:16833}: kill these as you meet them"] = "{area:16833} : tuez-les au passage",
	-- {item:266433} Abandoned Belongings · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["North of the cones: the Wind Hollows drift around the refugees' camp, the {item:266433} lie between the tents, and {npc:259013} lies at its north end."] = "Au nord des cônes : les Creux du vent dérivent autour du camp des réfugiés, {item:266433} sont entre les tentes, et {npc:259013} gît au nord du camp.",

	-- Step 72: Back to the Hermit
	["Back to the Hermit"] = "Retour à l'ermite",

	-- Step 73: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {npc:253576} Hyusaa Quickbreeze · {npc:253590} Valennia Stormfist
	["Fight north to the {area:16629}. Guardians, Spiritcallers and Blademasters hold the approach; {npc:253576} waits at the shrine's door, {npc:253590} inside the inner sanctum."] = "Frayez-vous un chemin vers le nord jusqu'à {area:16629}. Des Gardiens, Mande-esprit et Maîtres-lames al'aketh tiennent l'accès ; {npc:253576} attend à la porte du sanctuaire, {npc:253590} dans le sanctum intérieur.",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}: {npc:257196} holds it, west of the shrine's approach; defeat him for it on the way in"] = "{item:263993} : {npc:257196} le détient, à l'ouest de l'approche du sanctuaire ; vainquez-le pour l'obtenir en entrant",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, in the sanctum; upstairs"] = "{npc:253590}, dans le sanctum ; à l'étage",

	-- Step 74: Portal to Rohashi Spires
	-- {area:16630} Rohashi Spires
	["Portal to {area:16630}"] = "Portail vers {area:16630}",

	-- Step 75: High Priestess Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {object:617084} Portal to Valanaar (no name in this language: may be words)
	["Lorthuna waits up on the {area:16630}, east of the shrine: take the Portal to {area:16630} in the inner sanctum, beside Valennia, and cross the heights east to {npc:252475}. When she falls, the {object:617084} beside her takes you back to town."] = "Lorthuna attend en haut des {area:16630}, à l'est du sanctuaire : prenez le portail vers les {area:16630} dans le sanctum intérieur, à côté de Valennia, et traversez les hauteurs vers l'est jusqu'à {npc:252475}. Quand elle tombe, le portail vers Valanaar à côté d'elle vous ramène en ville.",

	-- Step 76: Valanaar, the fate of Zephras
	-- {area:16638} Valanaar
	["{area:16638}, the fate of Zephras"] = "{area:16638}, le destin de Zephras",
	-- {object:617084} Portal to Valanaar (no name in this language: may be words) · {npc:252475} Elaadrin Evengale · {npc:252476} Talaanis Shadowsong · {npc:259012} Ealaane Nimbuswalker
	["The {object:617084} sets you down beside {npc:252475} at the south end of the town. {npc:252476} is at the north end, {npc:259012} a few steps north-west of her."] = "",

	-- Step 79: Elaadrin Evengale
	-- {npc:252475} Elaadrin Evengale · {area:279} Dalaran · {area:16638} Valanaar · {npc:259084} Denaaris Stargale
	["{npc:252475} sends you on to {area:279}. Take the skycutter from the dock tower just south of {area:16638}: it lands by the Kirin Tor camp west of {area:279}, beside {npc:259084} and the Skyborne Portal."] = "",
	-- {npc:252475} Elaadrin Evengale · {npc:259084} Denaaris Stargale
	["{npc:252475}: {npc:259084} waits by the Skyborne portal"] = "{npc:252475} : {npc:259084} attend près du portail éolide",

	-- Step 80: Leave Zephras Isle to Alterac Mountains
	-- {zone:2521} Zephras Isle · {zone:1416} Alterac Mountains
	["Leave {zone:2521} to {zone:1416}"] = "Quittez {zone:2521} pour {zone:1416}",

	-- Step 81: Denaaris Stargale
	-- {npc:259084} Denaaris Stargale · {area:279} Dalaran · {zone:1453} Stormwind
	["{npc:259084} stands beside the Skyborne Portal, where the skycutter lands by the Kirin Tor camp west of {area:279}. The portal takes you to {zone:1453}."] = "{npc:259084} se tient à côté du portail éolide, là où le fend-ciel se pose près du camp du Kirin Tor à l'ouest de {area:279}. Le portail vous mène à {zone:1453}.",
	-- {npc:259084} Denaaris Stargale
	["{npc:259084}, inside"] = "{npc:259084}, à l'intérieur",
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind
	["{npc:270459}, beside {npc:259084}: for {npc:5504} in {zone:1453}"] = "{npc:270459}, à côté de {npc:259084} : pour {npc:5504} à {zone:1453}",
	-- {object:631299} Skyborne Portal to Stormwind
	["{object:631299}, inside"] = "{object:631299}, à l'intérieur",

	-- Step 82: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 83: Stormwind Keep
	-- {object:2117} Stormwind Keep · {zone:1436} Westfall
	["Bolvar Fordragon stands in the throne room of {object:2117}, at the north end of the city. Then leave by the main gate for {zone:1436}."] = "Bolvar Fordragon se tient dans la salle du trône de {object:2117}, au nord de la ville. Sortez ensuite par la grande porte vers {zone:1436}.",
	-- {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["For {npc:234} at {area:108}"] = "Pour {npc:234} à {area:108}",

	-- Step 84: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {zone:1436} Westfall
	["{npc:1646} stands in {object:2098}, on the way from the Keep to the main gate: his compass is in his old house in {zone:1436}, on the way."] = "",

	-- Step 85: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:202} auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 86: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Pendant que vous y êtes : apprenez le maniement des bâtons auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; l'arme de mêlée d'un Chasseur vaut surtout par ses caractéristiques, et les armes à deux mains en portent le plus.",

	-- Step 87: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Pendant que vous y êtes : apprenez le maniement des épées auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; une épée en main droite fait progresser un Voleur régulièrement.",

	-- Step 89: Sheldras Moontree
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form · {zone:1439} Darkshore
	["{npc:5504}, {zone:1453}'s druid trainer, teaches you {spell:18960}. {npc:11802}'s welcome waits for your {spell:499} trip at the end of {zone:1439}."] = "{npc:5504}, le maître des druides de {zone:1453}, vous enseigne {spell:18960}. L'accueil de {npc:11802} attend votre voyage en {spell:499} à la fin de {zone:1439}.",

	-- Step 91: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497} se tient dans la tour de {object:2101} ; elle vous donne une flasque pour la cascade de {quest:1861}.",

	-- Step 92: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Quittez {zone:1453} par la porte principale. La cascade du {quest:1861} se trouve au sud-ouest des portes, sur le chemin de la {zone:1436} à l'ouest : remplissez la {item:7207} à son pied.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Shen'dar"] = "Retour à Shen'dar",
	-- ["Back to {npc:255853} by the falls north-east of {area:16638}, on the way north to the shrine."] = "Retournez voir {npc:255853} près des chutes au nord-est de {area:16638}, sur le chemin du sanctuaire au nord.",
	-- ["Bolvar Fordragon stands in the throne room of {object:2117}, at the north end of the city. Then leave by the main gate for {area:40}."] = "Bolvar Fordragon se tient dans la salle du trône du {object:2117}, au nord de la ville. Partez ensuite par la porte principale vers la {area:40}.",
	-- ["Cast Read Ley Line at the {object:460002}"] = "Utilisez votre capacité raciale de lecture des lignes telluriques sur {object:460002}",
	-- ["Cast Read {object:460002} at the {object:460002}"] = "Lancer Read {object:460002} sur {object:460002}",
	-- ["Each of Quel'ana's quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her in {area:16638}. Windsong Crawlers line the shore west of town; Vuldren Alphas and Ornery Galestriders roam the {area:16626} around the Windfield farm. Her sister {npc:254411} stands beside her."] = "Chaque quête de Quel'ana vous remet un {item:15908} : utilisez-le sur la bête qu'elle désigne, puis rapportez-le-lui à {area:16638}. Les Clampants chantevent bordent le rivage à l'ouest de la ville ; les Alphas vuldrènes et les Trotteurs des trombes hargneux errent dans {area:16626} autour de la ferme Windfield. Sa sœur {npc:254411} se tient à côté d'elle.",
	-- ["Find Fillion and his bedroll"] = "Trouver Fillion et son sac de couchage",
	-- ["Havoc in Falaath"] = "Chaos à Falaath",
	-- ["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them."] = "Allez au nord-ouest jusqu'aux nids d'hippogriffes sur les falaises ouest. {item:263493} se trouve autour des nids ; la Matriarche hippogriffe patrouille parmi eux.",
	-- ["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them.\nThe Novice Seers practise in the clearing west of Shen'dar."] = "Partez vers le nord-ouest jusqu'aux nids d'hippogriffes sur les falaises de l'ouest. Le {item:263493} se trouve autour des nids ; la Matriarche patrouille entre eux.\nLes Voyants novices s'exercent dans la clairière à l'ouest de Shen'dar.",
	-- ["Heal 7 druids in the Nightfang Den, then find {npc:258130}"] = "Soigner 7 druides dans la tanière, puis trouver {npc:258130}",
	-- ["Hearth to {area:16638}"] = "Pierre de foyer vers {area:16638}",
	-- ["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {area:40}: fill {item:7207} at its base."] = "Sortez de {zone:1453} par la porte principale. La cascade du {quest:1861} se trouve au sud-ouest des portes, sur le chemin vers l'ouest et la {area:40} : remplissez la {item:7207} à son pied.",
	-- ["Level 6 spells"] = "Sorts de niveau 6",
	-- ["Lorthuna waits on the eastern shore of the isle, east of the {area:16629}."] = "Lorthuna attend sur la rive est de l'île, à l'est de {area:16629}.",
	-- ["Meet Valennia at the gate"] = "Rejoindre Valennia à la porte",
	-- ["North-west of Valanaar along the road: {npc:273017} watches the {quest:98512}; the dead cultist lies just north of him."] = "Au nord-ouest de Valanaar, le long de la route : {npc:273017} surveille {quest:98512} ; le cultiste mort gît juste au nord.",
	-- ["Prideclaws and Galestriders roam the grasslands south of the village. Galestriders drop both the eggs and the meat."] = "Les Fièregriffes et les Trotteurs des trombes errent dans les prairies au sud du village. Les Trotteurs des trombes lâchent les œufs et la viande.",
	-- ["Rally Valennia, {npc:251968} (west of town) and {npc:252475}"] = "Rallier Valennia, {npc:251968} (à l'ouest de la ville) et {npc:252475}",
	-- ["Rorian: {quest:92485}"] = "Rorian : {quest:92485}",
	-- ["Skycutter to {area:279}"] = "Fend-ciel pour {area:279}",
	-- ["Speak with {npc:251903} and {npc:254089}, north-west of the village"] = "Parler à {npc:251903} et {npc:254089}, au nord-ouest du village",
	-- ["Stand with {npc:252800} against {npc:252863}"] = "Combattre {npc:252863} aux côtés d'{npc:252800}",
	-- ["Take the road south-east. {npc:257006} and {npc:252448} stand by the road west of {area:16638}; Windsong Crawlers line the shore further west, around 51,70."] = "Prenez la route vers le sud-est. {npc:257006} et {npc:252448} se tiennent au bord de la route à l'ouest de {area:16638} ; des Clampants chantevent bordent le rivage plus à l'ouest, vers 51,70.",
	-- ["Talk to {npc:252800}"] = "Parlez à {npc:252800}",
	-- ["Tame Beast"] = "Apprivoiser une bête",
	-- ["The Highlands bandits"] = "Les bandits des hautes-terres",
	-- ["The Novice Seers practise in the clearing west of Shen'dar."] = "Les Voyants novices s'entraînent dans la clairière à l'ouest de Shen'dar.",
	-- ["The Windfield farm"] = "La ferme Windfield",
	-- ["The hippogryph roost"] = "Le perchoir des hippogriffes",
	-- ["The refugees' camp"] = "Le camp des réfugiés",
	-- ["The skycutter"] = "Le fend-ciel",
	-- ["The skycutter docks at the tower south of {area:16638}. It lands by the Kirin Tor camp on the lake shore west of {area:279}."] = "Le fend-ciel accoste à la tour au sud de {area:16638}. Il se pose près du camp du Kirin Tor sur la rive du lac, à l'ouest de {area:279}.",
	-- ["The {object:581822} lies by the path west of {area:16638}; Fillion's camp is north-west of it, and the Shriekling Matriarchs nest just west of the camp."] = "{object:581822} est au bord du chemin à l'ouest de {area:16638} ; le camp de Fillion est au nord-ouest, et les Matriarches criailleuses nichent juste à l'ouest du camp.",
	-- ["Use {spell:1259416}"] = "Utilisez {spell:1259416}",
	-- ["Vuldren and Cirrusflies"] = "Vuldrènes et mouches-cirrus",
	-- ["Windshaper Novice Seers"] = "Voyants novices des Sculpte-vents",
	-- ["{item:262668}: by the wind shrine south of {quest:92529}"] = "{item:262668} : près du sanctuaire du vent au sud de {quest:92529}",
	-- ["{item:263993}: {npc:257196}, west of the shrine's approach"] = "{item:263993} : {npc:257196}, à l'ouest de l'accès au sanctuaire",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read Ley Line racial ability at it."] = "{npc:249363} monte la garde à l'est du bosquet. {npc:251143} et des Convertis al'aketh ({npc:251160}) se rassemblent juste au nord d'elle ; {object:460002} s'élève plus au nord : utilisez-y votre capacité raciale de lecture des lignes telluriques.",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read {object:460002} racial ability at it."] = "{npc:249363} monte la garde à l'est du bosquet. {npc:251143} et les Convertis al'aketh se rassemblent juste au nord ; {object:460002} s'élève plus au nord : lancez-y votre technique raciale Read {object:460002}.",
	-- ["{npc:250926} and {npc:251115}"] = "{npc:250926} et {npc:251115}",
	-- ["{npc:250926} prowl the woods just west of the grove; the Ursera Scavengers den further west, with {npc:251115}, the matriarch, at the back of the den."] = "{npc:250926} rôdent dans les bois juste à l'ouest du bosquet ; les Charognards ursera ont leur tanière plus à l'ouest, avec {npc:251115}, la matriarche, au fond.",
	-- ["{npc:251918} along the way to Shen'dar turn-ins"] = "{npc:251918} en chemin vers les rendus de Shen'dar",
	-- ["{npc:251918} on the way"] = "{npc:251918} en chemin",
	-- ["{npc:252095} camps south of the Ursera den. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle."] = "{npc:252095} campe au sud de la tanière des ursera. Les voyous al'aketh tiennent le camp au sud-ouest ; {npc:256935} se tient en son centre.",
	-- ["{npc:252095} camps south of the Ursera den. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle.\nCareful: {npc:256935} casts shocks; drag him clear of the other cultists before fighting so they don't join in."] = "{npc:252095} campe au sud de la tanière des Ursera. Les malfrats d'Al'Aketh tiennent le camp au sud-ouest d'elle ; {npc:256935} se tient en son centre.\nAttention : {npc:256935} lance des horions ; éloignez-le des autres cultistes avant de le combattre pour qu'ils ne s'en mêlent pas.",
	-- ["{npc:252359}, the druid trainer, stands between the west gate and Valennia's house."] = "{npc:252359}, le maître des druides, se tient entre la porte ouest et la maison de Valennia.",
	-- ["{npc:252359}: {quest:94006} (level 10)"] = "{npc:252359} : {quest:94006} (niveau 10)",
	-- ["{npc:252377}: Defensive Stance"] = "{npc:252377} : Posture défensive",
	-- ["{npc:252377}: {npc:257196} waits at the {area:16629}"] = "{npc:252377} : {npc:257196} attend à {area:16629}",
	-- ["{npc:252475} sends you on to {area:279}. Once you have trained, take the skycutter from the dock tower just south of {area:16638}: it lands by the Kirin Tor camp west of {area:279}, beside {npc:259084} and the Skyborne Portal."] = "{npc:252475} vous envoie ensuite à {area:279}. Une fois entraîné, prenez le fend-ciel à la tour du quai juste au sud de {area:16638} : il se pose près du camp du Kirin Tor à l'ouest de {area:279}, à côté de {npc:259084} et du portail éolide.",
	-- ["{npc:253590}, in the sanctum"] = "{npc:253590}, dans le sanctum",
	-- ["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}."] = "{npc:254151}, {npc:258130} et {npc:258134} sont au nord-est d'{npc:257944} ; {npc:253622} se tient à l'est d'eux. Haalien lâche aussi {quest:94490}.",
	-- ["{npc:254411}: Beast Training"] = "{npc:254411} : Dressage des bêtes",
	-- ["{npc:254588}: tame it with the {item:15908}"] = "{npc:254588} : apprivoisez-le avec le {item:15908}",
	-- ["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623} west of {area:16638}, by the road you take next."] = "{npc:255853} attend près des chutes au nord-est de {area:16638}. {npc:258443} rôde dans {area:16623} à l'ouest de {area:16638}, près de la route que vous prendrez ensuite.",
	-- ["{npc:255853}: Bear Form"] = "{npc:255853} : Forme d’ours",
	-- ["{npc:257532} on the way"] = "{npc:257532} en chemin",
	-- ["{npc:259084} stands beside the Skyborne Portal where the zeppelin lands. The portal takes you to {zone:1453}."] = "{npc:259084} se tient près du portail éolide, là où le zeppelin se pose. Le portail vous mène à {zone:1453}.",
	-- ["{npc:5504}, {zone:1453}'s druid trainer, teaches you Teleport: {quest:94914}. {npc:11802}'s welcome waits for your Cat Form trip at the end of {zone:1439}."] = "{npc:5504}, le maître des druides de {zone:1453}, vous apprend Téléportation : {quest:94914}. L'accueil de {npc:11802} attendra votre voyage pour la Forme de félin, à la fin de {zone:1439}.",
	-- ["{quest:93159} lives west of Elegael. The {item:257128} Cones lie in the woods between his hut and Elegael."] = "{quest:93159} vit à l'ouest d'Elegael. Les cônes de {item:257128} jonchent les bois entre sa cabane et Elegael.",
}
