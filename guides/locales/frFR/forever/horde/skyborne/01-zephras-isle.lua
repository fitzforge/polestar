-- French (frFR): the guide forever/horde/skyborne/01-zephras-isle (forever/horde/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Village
	-- {area:16635} Thendal Village · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker
	["You wake in {area:16635}, in the north of the isle. {npc:251362} stands by the path, {npc:251361} at the village centre."] = "Vous vous réveillez à {area:16635}, au nord de l'île. {npc:251362} se tient près du chemin, {npc:251361} au centre du village.",

	-- Step 2: Thendal Grove
	-- {npc:250873} Juvenile Vuldren
	["Pesky Cirrusflies and {npc:250873} roam the grove just south-east of the village."] = "Des Mouches-cirrus agaçantes et des {npc:250873} parcourent le bosquet juste au sud-est du village.",

	-- Step 3: Back to Thendal Village
	-- {area:16635} Thendal Village
	["Back to {area:16635}"] = "Retour à {area:16635}",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361} : {item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361} : un mot de votre maître",
	-- {npc:251361} Rorian the Dayseeker · {item:282418} Humming Recall Crystal
	["{npc:251361}: examine the {item:282418}"] = "{npc:251361} : examinez {item:282418}",
	-- {npc:257554} Halaan Hawk-Eye
	["talk to {npc:257554}"] = "parlez à {npc:257554}",

	-- Step 4: The watchtower
	["The watchtower"] = "La tour de guet",
	-- {spell:1259416} Walk on Air
	["Climb the watchtower in the village, jump off the top and use {spell:1259416} to float down."] = "Montez en haut de la tour de guet du village, sautez du sommet et utilisez {spell:1259416} pour redescendre en planant.",

	-- Step 5: Rorian the Dayseeker's errands
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}'s errands"] = "Les commissions de {npc:251361}",

	-- Step 6: Raw Windstones
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones"] = "Pierres de vent brutes ({object:613286})",
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones are blue crystals on the slopes around the village."] = "Les Pierres de vent brutes ({object:613286}) sont des cristaux bleus sur les pentes autour du village.",

	-- Step 8: The standing stones
	["The standing stones"] = "Les pierres dressées",
	-- {npc:249363} Yala Windwatcher · {area:17678} Thendal Standing Stones · {npc:251143} Roiling Winds · {object:460001} Elemental Convergence (no name in this language: may be words) · {spell:1259686} Skysight
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} stands at the {area:17678}, east of the village. {npc:251143} and Al'Aketh Converts gather just north of her. The {object:460001} is just north-east of her: cast your {spell:1259686} racial ability next to it."] = "{npc:249363} se tient aux {area:17678}, à l'est du village. {npc:251143} et des Convertis al'aketh ({npc:251160}) se rassemblent juste au nord d'elle. {object:460001} se trouve juste au nord-est d'elle : lancez votre capacité raciale {spell:1259686} à côté.",
	-- {spell:1259686} Skysight · {object:460001} Elemental Convergence (no name in this language: may be words)
	["Cast {spell:1259686} near the {object:460001}"] = "Lancez {spell:1259686} près de {object:460001}",

	-- Step 9: The Cirrusfly Queen
	["The queen hovers at the south-east end of the grove, on your way back from the stones."] = "La reine plane à l'extrémité sud-est du bosquet, sur le chemin du retour depuis les pierres.",

	-- Step 10: Thendal Village turn-ins
	-- {area:16635} Thendal Village
	["{area:16635} turn-ins"] = "Quêtes à rendre à {area:16635}",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361} : lisez {item:9547}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}, dans la tour de guet",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, dans la tour de guet",
	-- {npc:251374} Windshaper Boro
	["{npc:251374}, at the village centre"] = "{npc:251374}, au centre du village",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}, le maître des druides, au rez-de-chaussée de l'arbre derrière {npc:251361}",

	-- Step 11: Windshaper Boro
	-- {npc:251374} Windshaper Boro
	["{npc:251374} stands in the village."] = "{npc:251374} se tient dans le village.",

	-- Step 12: Scrawny Ursera
	-- {npc:250926} Scrawny Ursera · {npc:252095} Hanaa Nightwind
	["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}."] = "Des {npc:250926} rôdent sur les pentes au sud-ouest du village, sur le chemin de {npc:252095}.",

	-- Step 13: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {area:16622} Thendal Grove · {npc:256935} Malduko Cloudcrush
	["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it."] = "{npc:252095} attend au {area:16622}, au sud-ouest du village. Le camp al'aketh se trouve juste derrière elle ; {npc:256935} le dirige.",

	-- Step 14: Signet of Akir
	-- {npc:252095} Hanaa Nightwind
	["The Al'Aketh cultists in the camp beyond {npc:252095} carry the signet."] = "Les cultistes al'aketh du camp derrière {npc:252095} portent la chevalière.",

	-- Step 15: Urs'anah
	-- {npc:251115} Urs'anah
	["The Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "La tanière des ursera est à l'ouest du village. {npc:251115}, leur matriarche, se trouve tout au fond.",

	-- Step 16: Leaving Thendal Village
	-- {area:16635} Thendal Village
	["Leaving {area:16635}"] = "Départ de {area:16635}",

	-- Step 17: Call of Earth
	-- {npc:251374} Windshaper Boro · {area:16988} Rise of Spirits · {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:251374} sends you to the {area:16988}, just east of the village: drink the {item:6635} there to see the {npc:251166}, then take the {item:6656} back to him."] = "{npc:251374} vous envoie à la {area:16988}, juste à l'est du village : buvez-y {item:6635} pour voir {npc:251166}, puis rapportez-lui {item:6656}.",
	-- {npc:251374} Windshaper Boro · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {npc:5873} and your {item:5175}"] = "{npc:251374} : {npc:5873} et votre {item:5175}",

	-- Step 18: Shen'dar Village
	-- {area:16624} Shen'dar Village
	["Follow the road south to {area:16624}, in the middle of the isle."] = "Suivez la route vers le sud jusqu'à {area:16624}, au milieu de l'île.",
	-- {npc:251902} Illaya Amberwind
	["talk to {npc:251902}"] = "parlez à {npc:251902}",

	-- Step 19: Raan Wildwind's campfire
	-- {npc:263664} Raan Wildwind
	["{npc:263664}'s campfire"] = "Le feu de camp de {npc:263664}",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest · {npc:251905} Zerril Softbreeze
	["Sit by {npc:263664}'s campfire (type /sit) until you get the {spell:1229451} buff, then find {npc:251905} at the cook fire."] = "Asseyez-vous près du feu de camp de {npc:263664} (tapez /sit) jusqu'à obtenir l'amélioration {spell:1229451}, puis trouvez {npc:251905} près du feu de cuisson.",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "/sit près du feu de camp de {npc:263664} jusqu'à obtenir {spell:1229451}",
	-- {npc:251905} Zerril Softbreeze
	["talk to {npc:251905}"] = "parlez à {npc:251905}",

	-- Step 20: Welcome to Shen'dar Village
	-- {npc:251902} Illaya Amberwind
	["Talk to {npc:251902}"] = "Parlez à {npc:251902}",
	-- {npc:254089} Coriella Calmbreeze
	["Talk to {npc:254089}"] = "Parlez à {npc:254089}",
	["the bounty board"] = "le tableau des primes",

	-- Step 21: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "Fièregriffes et trotteurs des trombes",
	-- {item:5469} Strider Meat · {npc:251905} Zerril Softbreeze
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders share the meadows south of the village. Keep the {item:5469} for {npc:251905}; the eggs come later from the hippogryphs."] = "Fièregriffes et trotteurs des trombes se partagent les prés au sud du village. Gardez la {item:5469} pour {npc:251905} ; les œufs viendront plus tard des hippogriffes.",

	-- Step 22: High Order Apprentices
	-- plural, as words: High Order Apprentices = {npc:257521} High Order Apprentice
	["High Order Apprentices"] = "Apprentis de l'Ordre suprême ({npc:257521})",
	["The apprentices practise north-east of the village."] = "Les apprentis s'entraînent au nord-est du village.",

	-- Step 23: The highland bandits
	["The highland bandits"] = "Les bandits des hautes-terres",
	["The bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "Les camps de bandits sont au nord-est du village ; Bennic « Mauvais vent » tient le camp le plus haut. Les bandits portent les pierres de vent volées.",

	-- Step 24: Shen'dar Village turn-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} turn-ins"] = "Quêtes à rendre à {area:16624}",

	-- Step 25: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["{npc:254589} lurks south of the village, among the Prideclaws. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} rôde au sud du village, parmi les Fièregriffes. {npc:254589} est un élite : mieux vaut être en groupe.",

	-- Step 26: Falaath Village
	-- {quest:92529} Falaath Village · {npc:257065} Missionary Jasaan
	["{quest:92529} lies south of Shen'dar. {npc:257065} meets you at its edge; search the wardrobe in the house behind him."] = "{quest:92529} se trouve au sud de Shen’dar. {npc:257065} vous attend à son entrée ; fouillez l'armoire de la maison derrière lui.",
	["search the wardrobe"] = "fouillez l'armoire",

	-- Step 27: Constable Aonda
	-- {area:16624} Shen'dar Village
	["Back to {area:16624} with what you found."] = "Retournez à {area:16624} avec ce que vous avez trouvé.",

	-- Step 28: Havoc in the Highlands
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	-- plural, as words: Supply Caches = {object:576179} Supply Cache
	["Back at {quest:92529}: Stormcallers and {npc:251662} fill the village, the Supply Caches stand among the houses and {npc:251966} waits at its south-east end."] = "De retour à {quest:92529} : des Mande-foudre al'aketh et {npc:251662} emplissent le village, les Caches de fournitures ({object:576179}) se trouvent entre les maisons et {npc:251966} attend à son extrémité sud-est.",

	-- Step 29: The West Pylon Watchtower
	-- {area:17674} West Pylon Watchtower
	["The {area:17674}"] = "{area:17674}",
	-- {area:17674} West Pylon Watchtower · {npc:252155} Peacekeeper Vaaniel · {item:254871} Bloody Note
	["Head south-west to the {area:17674}. {npc:252155} is at the top; the {item:254871} lies beside him."] = "Allez au sud-ouest jusqu'à la {area:17674}. {npc:252155} est au sommet ; {item:254871} se trouve à côté de lui.",
	-- {npc:252155} Peacekeeper Vaaniel
	["talk to {npc:252155}"] = "parlez à {npc:252155}",

	-- Step 30: Skypriest Aanders
	["Aanders and the fallen guards are just south-west of the tower. Take Raani's feather and the Shadowsong signet from the bodies."] = "Aanders et les gardes tombés sont juste au sud-ouest de la tour. Prenez la Plume porte-bonheur de Raani et la chevalière Shadowsong sur les corps.",

	-- Step 31: Hippogryph nests
	["Hippogryph nests"] = "Nids d'hippogriffes",
	-- {quest:92529} Falaath Village · {item:263493} Hippogryph Down
	-- plural, as words: Small Eggs = {item:6889} Small Egg
	["The hippogryph nests are north-west of the tower, west of {quest:92529}; the Matriarch sits at the western end. {item:263493} lies on the ground around them, and the hippogryphs drop the Small Eggs."] = "Les nids d'hippogriffes sont au nord-ouest de la tour, à l'ouest de {quest:92529} ; la Matriarche se tient à l'extrémité ouest. {item:263493} se trouve au sol autour d'eux, et les hippogriffes lâchent les Petits oeufs ({item:6889}).",

	-- Step 32: Shen'dar Village, last time
	-- {area:16624} Shen'dar Village
	["{area:16624}, last time"] = "{area:16624}, une dernière fois",
	-- {area:16624} Shen'dar Village · {item:5469} Strider Meat
	["Walk north to {area:16624}; finish the {item:5469} on the Galestriders along the way if you are short."] = "Marchez vers le nord jusqu'à {area:16624} ; finissez la {item:5469} sur les trotteurs des trombes en chemin s'il vous en manque.",

	-- Step 33: To Valanaar
	-- {area:16638} Valanaar · {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield
	["Take the road south-east to {area:16638}, the Skyborne town on the south coast. {npc:257006} and {npc:252448} stand at its western edge."] = "Prenez la route vers le sud-est jusqu'à {area:16638}, la ville céleste de la côte sud. {npc:257006} et {npc:252448} se tiennent à sa lisière ouest.",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "Écoutez l'histoire de {npc:252448}",

	-- Step 34: Windsong Crawlers
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers"] = "Clampants chantevent ({npc:254588})",
	["The crawlers scuttle along the shore south-west of town."] = "Les clampants trottinent le long du rivage au sud-ouest de la ville.",

	-- Step 36: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Sauteciels",
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers hop about the fields just west of Valennia."] = "Des Sauteciels ({npc:251727}) sautillent dans les champs juste à l'ouest de Valennia.",

	-- Step 37: Ayessa Dawnsinger
	-- {npc:251968} Ayessa Dawnsinger
	["talk to {npc:251968}"] = "parlez à {npc:251968}",

	-- Step 38: Riaani Nightwind
	-- {npc:256083} Riaani Nightwind · {area:16626} Gustberry Lowlands
	["{npc:256083} stands in the {area:16626} just north-west of town."] = "{npc:256083} se tient dans les {area:16626}, juste au nord-ouest de la ville.",
	-- {npc:256083} Riaani Nightwind
	["Listen to {npc:256083}"] = "Écoutez {npc:256083}",

	-- Step 39: Wind Hollows and Construct Parts
	-- {object:616467} Construct Parts
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows and {object:616467}"] = "Creux du vent et {object:616467}",
	-- {area:16638} Valanaar · {object:616467} Construct Parts
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616467} lie west of the orchard road."] = "Des Creux du vent dérivent au-dessus des plaines autour de {area:16638}. Les premières {object:616467} se trouvent à l'ouest de la route du verger.",

	-- Step 41: Windfield Orchard
	-- {area:16663} Windfield Orchard · {area:16638} Valanaar
	["{area:16663} is west of {area:16638} along the coast road."] = "Le {area:16663} est à l'ouest de {area:16638}, sur la route côtière.",
	-- {npc:252800} Aamelia Windfield
	["Talk to {npc:252800}"] = "Parlez à {npc:252800}",

	-- Step 42: The orchard
	["The orchard"] = "Le verger",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Stormapples and flutterfly dust lie all over the orchard; Hungry Bandits raid it. Galestriders graze in the fields east of it. The broken construct floats at the orchard's north edge."] = "Des Pommes d’orage mûres et de la Poussière de voltemouche jonchent le verger ; des Bandits affamés ({npc:252802}) le pillent. Des trotteurs des trombes paissent dans les champs à l'est. L'assemblage brisé flotte à la lisière nord du verger.",

	-- Step 44: Bandit Highwaymen
	["Bandit Highwaymen"] = "Bandits de grand chemin",
	-- {object:616468} Construct Parts · {area:16638} Valanaar
	["The highwaymen hold the hills north-east of the orchard. More {object:616468} lie near the road to {area:16638}."] = "Les bandits de grand chemin tiennent les collines au nord-est du verger. D'autres {object:616468} se trouvent près de la route de {area:16638}.",

	-- Step 45: Standing Our Ground
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "Dites à {npc:252800} que vous êtes prêt",

	-- Step 46: Alvarion Windfield and Riaani Nightwind
	-- {npc:252448} Alvarion Windfield · {npc:256083} Riaani Nightwind
	["{npc:252448} and {npc:256083}"] = "{npc:252448} et {npc:256083}",

	-- Step 47: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {item:15908} Taming Rod · {npc:254588} Windsong Crawler · {npc:251707} Ornery Galestrider · {npc:250874} Vuldren Alpha · {area:16663} Windfield Orchard · {npc:254411} Quel'dora Quickgale
	["{npc:252389} in {area:16638} hands you a {item:15908} three times: tame a {npc:254588} by the lakes north-west of town, an {npc:251707} in the fields west of town and a {npc:250874} at {area:16663}, returning to her after each. {npc:254411} stands beside her."] = "{npc:252389}, à {area:16638}, vous remet trois fois un {item:15908} : apprivoisez un {npc:254588} près des lacs au nord-ouest de la ville, un {npc:251707} dans les champs à l'ouest de la ville et un {npc:250874} au {area:16663}, en revenant la voir après chacun. {npc:254411} se tient à côté d'elle.",

	-- Step 48: Belathaan Brightwish
	-- {npc:256247} Belathaan Brightwish · {area:16638} Valanaar · {area:16629} Shrine of Akir
	["{npc:256247} waits on the road north of {area:16638}, towards the {area:16629}."] = "{npc:256247} attend sur la route au nord de {area:16638}, en direction du {area:16629}.",

	-- Step 50: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands on {area:16638}'s east side."] = "{npc:252359} se tient à l'est de {area:16638}.",

	-- Step 51: The East Pylon Watchtower
	-- {area:17675} East Pylon Watchtower
	["The {area:17675}"] = "{area:17675}",
	-- {area:17675} East Pylon Watchtower · {npc:252666} Commander Belguilos
	["Ride north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "Chevauchez vers le nord-est jusqu'à la {area:17675}. Le camp al'aketh se trouve juste à l'ouest, avec {npc:252666} à son extrémité nord. Chaque cultiste peut lâcher un Charme de pierre de vent al’aketh.",

	-- Step 52: Urs'endris
	-- {npc:255853} Urs'endris
	["{npc:255853} waits by the falls just north of the watchtower."] = "{npc:255853} attend près des chutes juste au nord de la tour de guet.",

	-- Step 53: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "Retour à {area:16638}",

	-- Step 54: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} stands in the middle of {area:16638}."] = "{npc:252377} se tient au milieu de {area:16638}.",

	-- Step 55: Sessaria Skystride
	-- {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["{npc:252382} stands on {area:16638}'s west side."] = "{npc:252382} se tient à l'ouest de {area:16638}.",

	-- Step 56: The turncoat
	["The turncoat"] = "Le traître",
	-- {area:16626} Gustberry Lowlands · {area:16638} Valanaar · {npc:273017} Fendaal Windstone
	["The turncoat's house is in the {area:16626} north-west of {area:16638}. {npc:273017} waits nearby; his assassins lurk around the house."] = "La maison du traître se trouve dans les {area:16626}, au nord-ouest de {area:16638}. {npc:273017} attend tout près ; ses assassins rôdent autour de la maison.",
	["search the dead cultist in the house"] = "fouillez le cultiste mort dans la maison",

	-- Step 57: Ur'endra
	-- {npc:258443} Ur'endra
	["{npc:258443} roams the slopes just south of the turncoat's house."] = "{npc:258443} parcourt les pentes juste au sud de la maison du traître.",

	-- Step 58: Olariaan Swiftburn
	-- {npc:268592} Olariaan Swiftburn · {area:16638} Valanaar · {area:16626} Gustberry Lowlands
	["Take the Torch of Dormant Flame to {npc:268592} at the Shrine of Flames, south-west of {area:16638} in the {area:16626}."] = "Apportez la Torche de la flamme dormante à {npc:268592}, au sanctuaire des Flammes, au sud-ouest de {area:16638} dans les {area:16626}.",

	-- Step 59: Skypriest Faladiel
	-- {area:16638} Valanaar
	["Faladiel stands on the hill west of the falls, north of {area:16638}."] = "Faladiel se tient sur la colline à l'ouest des chutes, au nord de {area:16638}.",

	-- Step 60: Kuramaa
	-- {npc:268592} Olariaan Swiftburn · {area:16623} Shen'dar Highlands · {npc:268605} Kuramaa
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Back to {npc:268592}, then west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "Retournez voir {npc:268592}, puis allez vers l'ouest dans les {area:16623} : la demeure de {npc:268605} est dans les collines au sud des lacs des Clampants chantevent.",

	-- Step 61: The Eternal Flame
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Wait for him to light the {npc:268762}, then carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638} before the timer runs out."] = "Retournez voir {npc:268592}. Attendez qu'il allume {npc:268762}, puis portez la flamme directement jusqu'à {npc:268679}, à côté de {npc:252382} à {area:16638}, avant la fin du temps imparti.",
	-- {npc:252382} Sessaria Skystride · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:252382} : {npc:2523}, votre {item:5176} et {item:263412}",

	-- Step 62: Unfortunate News
	-- {npc:252476} Talaanis Shadowsong
	["talk to {npc:252476}"] = "parlez à {npc:252476}",

	-- Step 63: Desperate Times
	-- {npc:252383} Valennia Stormfist
	["Talk to {npc:252383}"] = "Parlez à {npc:252383}",
	-- {npc:251968} Ayessa Dawnsinger
	["Talk to {npc:251968}"] = "Parlez à {npc:251968}",
	-- {npc:252383} Valennia Stormfist
	["talk to {npc:252383}"] = "parlez à {npc:252383}",

	-- Step 64: Strength and Mercy
	-- {npc:255853} Urs'endris
	["On the way north, back to {npc:255853} by the falls."] = "En remontant vers le nord, retournez voir {npc:255853} près des chutes.",

	-- Step 65: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:253576} Hyusaa Quickbreeze
	["The {area:16629} is north of {area:16638}. Fight through the guards up to {npc:253576} at its east side."] = "Le {area:16629} est au nord de {area:16638}. Frayez-vous un chemin à travers les gardes jusqu'à {npc:253576}, du côté est.",
	-- {npc:253576} Hyusaa Quickbreeze
	["Talk to {npc:253576}"] = "Parlez à {npc:253576}",

	-- Step 66: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["{npc:257196} holds the {item:263993} on the west side of the shrine."] = "{npc:257196} tient {item:263993} du côté ouest du sanctuaire.",

	-- Step 67: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}; {npc:257944} camps at its southern edge."] = "Allez vers le nord dans la {area:16631} ; {npc:257944} campe à sa lisière sud.",

	-- Step 68: Shadowgale Forest
	-- {item:265105} Lady's Tear Moss · {npc:257944} Elegael Thornpaw · {item:265141} Bloody Heirloom
	["{item:265105} grows around {npc:257944}'s camp and Shriekings fly over it. The Al'Aketh camp east of her holds the {item:265141}."] = "{item:265105} pousse autour du camp d'{npc:257944} et des criailleuses le survolent. Le camp al'aketh à l'est d'elle contient {item:265141}.",

	-- Step 69: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "De nouveau {npc:257944}",

	-- Step 70: The Al'Aketh camp
	["The Al'Aketh camp"] = "Le camp al'aketh",
	-- {npc:253622} Commander Haalien · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:254151} Vayn Moongaze · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:253622}, {npc:258130} and {npc:258134} are in the cult camp east of {npc:257944}. {npc:254151} stands at its edge. Haalien also drops a {quest:94490}: read it to start the next quest. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:253622}, {npc:258130} et {npc:258134} sont dans le camp du culte à l'est d'{npc:257944}. {npc:254151} se tient à sa lisière. Haalien lâche aussi {quest:94490} : lisez-la pour commencer la quête suivante. Pour {quest:94489}, entrez dans la tanière des Crocs-de-la-nuit, soignez 7 druides blessés et trouvez {npc:258130}.",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "Trouvez {npc:258130}",
	["Heal the injured druids in the Nightfang Den"] = "Soignez les druides blessés dans la tanière des Crocs-de-la-nuit",

	-- Step 71: Elegael Thornpaw, last time
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, last time"] = "{npc:257944}, une dernière fois",

	-- Step 72: Windsong Lake
	-- {area:16625} Windsong Lake · {npc:259013} Resaan Nimbuswalker
	["The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "Les affaires des réfugiés sont éparpillées le long de la rive nord du {area:16625} ; {npc:259013} est à son extrémité nord-ouest.",

	-- Step 73: The Strange Hermit
	-- {area:16625} Windsong Lake · {item:257128} Zephyrseed
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["The hermit lives at {area:16625}'s west shore. {item:257128} cones grow south of him; the Wind Hollows drift east of the lake."] = "L'ermite vit sur la rive ouest du {area:16625}. Les cônes de {item:257128} poussent au sud de chez lui ; les Creux du vent ({npc:251676}) dérivent à l'est du lac.",
	-- {npc:251684} Strange Hermit
	["talk to {npc:251684}"] = "parlez à {npc:251684}",

	-- Step 74: Confront Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {npc:251968} Ayessa Dawnsinger
	["Take the portal up to the {area:16630} and join {npc:252475} and {npc:251968} against the High Priestess."] = "Prenez le portail pour monter aux {area:16630} et rejoignez {npc:252475} et {npc:251968} contre la grande prêtresse.",

	-- Step 77: The airship
	["The airship"] = "Le dirigeable",
	-- {area:16638} Valanaar · {zone:1412} Mulgore
	["The Horde airship docks at the south-west edge of {area:16638}. Ride it to Kalimdor; it lands in northern {zone:1412}."] = "Le dirigeable de la Horde est amarré à la lisière sud-ouest de {area:16638}. Prenez-le pour Kalimdor ; il se pose dans le nord de {zone:1412}.",
	["Horde airship"] = "Dirigeable de la Horde",

	-- Step 78: Northern Mulgore
	-- {zone:1412} Mulgore
	["Northern {zone:1412}"] = "Nord de {zone:1412}",
	-- {npc:259119} Alaana Stormwalker
	["You leave the isle for good. {npc:259119} waits where the airship lands."] = "Vous quittez l'île pour de bon. {npc:259119} attend là où se pose le dirigeable.",
	-- {npc:259119} Alaana Stormwalker · {zone:1454} Orgrimmar
	["{npc:259119}: keep it, Thrall in {zone:1454} comes two guides later"] = "{npc:259119} : gardez-la, Thrall à {zone:1454} vient deux guides plus tard",
	-- {npc:259118} Muln Earthfury · {npc:3033} Turak Runetotem · {zone:1456} Thunder Bluff
	["{npc:259118}, by the landing: for {npc:3033} in {zone:1456}"] = "{npc:259118}, près de l'aire d'atterrissage : pour {npc:3033} à {zone:1456}",

	-- Step 79: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:2995} Tal
	["{area:1638} is beside the landing: ride up a lift and learn the flight path from {npc:2995}, the wind rider master."] = "{area:1638} est à côté de l'aire d'atterrissage : montez par un ascenseur et apprenez le trajet aérien auprès de {npc:2995}, le maître des coursiers du vent.",

	-- Step 80: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068} veut de l'encens tauren : achetez ses quatre ingrédients à {npc:3014} l'herboriste, {npc:3012} la fournisseuse en enchantement, {npc:3005} le fournisseur en travail du cuir et {npc:3027} le fournisseur en cuisine, puis combinez-les en {item:278078}.",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}, chez {npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}, chez {npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}, chez {npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}, chez {npc:3027}",

	-- Step 81: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Utilisez l'{item:278078} sur le tapis et le brûleur de cérémonie, sur la falaise sud de {area:1641}.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Répandez l'{item:278078} depuis {area:1641}",

	-- Step 83: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 23 (forever/horde/04-the-barrens)."] = "{npc:3033} entraîne les druides sur la {area:1639}. Il vous enseigne {spell:18960} ; l'accueil de {npc:11802} attend votre voyage en {spell:499} vers le niveau 23 (forever/horde/04-the-barrens).",

	-- Step 84: The Crossroads
	-- {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {zone:1413} Barrens · {area:458} Gold Road · {area:380} The Crossroads
	["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "Quittez {zone:1456} par un ascenseur et suivez la route vers le sud en passant {area:222}, puis le col oriental pour entrer dans {zone:1413} ; depuis le col, prenez la {area:458} vers le nord jusqu'à la {area:380}, la ville de la Horde au milieu de {zone:1413}.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, le maître des coursiers du vent",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Kuramaa"] = "Kuramaa",
	-- ["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "Quittez {zone:1456} par un ascenseur et suivez la route vers le sud en passant {area:222}, puis le col oriental pour entrer dans {zone:1413} ; depuis le col, prenez la {area:458} vers le nord jusqu'à {area:380}, la ville de la Horde au milieu de {zone:1413}.",
	-- ["Rorian: {quest:92485}"] = "Rorian : {quest:92485}",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616466} lie near the road to {area:16638}."] = "Les bandits de grand chemin tiennent les collines au nord-est du verger. D'autres {object:616466} se trouvent près de la route de {area:16638}.",
	-- ["Wind Hollows and {object:616466}"] = "Creux du vent ({npc:251676}) et {object:616466}",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616466} lie west of the orchard road."] = "Des Creux du vent ({npc:251676}) dérivent au-dessus des plaines autour de {area:16638}. Les premières {object:616466} se trouvent à l'ouest de la route du verger.",
}
