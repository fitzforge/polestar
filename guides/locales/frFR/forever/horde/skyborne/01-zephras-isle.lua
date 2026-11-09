-- French (frFR): the guide forever/horde/skyborne/01-zephras-isle (forever/horde/skyborne/01-zephras-isle.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Village
	-- {area:16635} Thendal Village · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker
	["You wake in {area:16635}, in the north of the isle. {npc:251362} stands by the path, {npc:251361} at the village centre."] = "Vous vous réveillez à {area:16635}, au nord de l'île. {npc:251362} se tient près du chemin, {npc:251361} au centre du village.",

	-- Step 2: Thendal Grove: kill these as you meet them
	-- {area:16622} Thendal Grove
	["{area:16622}: kill these as you meet them"] = "{area:16622} : tuez-les au passage",
	-- {npc:250873} Juvenile Vuldren
	["Pesky Cirrusflies and {npc:250873} roam the grove just south-east of the village."] = "Des Mouches-cirrus agaçantes et des {npc:250873} parcourent le bosquet juste au sud-est du village.",

	-- Step 3: Back to Thendal Village
	-- {area:16635} Thendal Village
	["Back to {area:16635}"] = "Retour à {area:16635}",
	-- {npc:257554} Halaan Hawk-Eye · {npc:263113} Myriaal Mistwake · {npc:251368} Elatrell Featherlight
	["{npc:257554} and {npc:263113} stand at the top of the watchtower, a few steps north-east of {npc:251368}."] = "{npc:257554} et {npc:263113} se tiennent au sommet de la tour de guet, à quelques pas au nord-est de {npc:251368}.",
	-- {npc:257554} Halaan Hawk-Eye
	["talk to {npc:257554}"] = "parlez à {npc:257554}",

	-- Step 4: Rorian the Dayseeker's errands
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}'s errands"] = "Les commissions de {npc:251361}",
	-- {spell:1259416} Walk on Air · {npc:251361} Rorian the Dayseeker
	["Jump off the top of the watchtower and use {spell:1259416} to float down to {npc:251361}, west of the tower."] = "Sautez du haut de la tour de guet et utilisez {spell:1259416} pour descendre en planant jusqu'à {npc:251361}, à l'ouest de la tour.",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361} : {item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361} : un mot de votre maître",
	-- {npc:251361} Rorian the Dayseeker · {item:282418} Humming Recall Crystal
	["{npc:251361}: examine the {item:282418}"] = "{npc:251361} : examinez {item:282418}",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361} : lisez {item:9547}",
	-- {npc:251374} Windshaper Boro · {npc:251361} Rorian the Dayseeker
	["{npc:251374}, beside {npc:251361}"] = "{npc:251374}, à côté de {npc:251361}",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}, le maître des druides, au rez-de-chaussée de l'arbre derrière {npc:251361}",
	-- {npc:251373} Xyton Silverwind
	["Boro and {npc:251373}, while you stand beside them"] = "Boro et {npc:251373}, en restant à côté d'eux",

	-- Step 5: Raw Windstones
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones"] = "Pierres de vent brutes ({object:613286})",
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones are blue crystals on the slopes around the village."] = "Les Pierres de vent brutes ({object:613286}) sont des cristaux bleus sur les pentes autour du village.",

	-- Step 7: The standing stones
	["The standing stones"] = "Les pierres dressées",
	-- {npc:249363} Yala Windwatcher · {area:17678} Thendal Standing Stones · {npc:251143} Roiling Winds · {object:460001} Elemental Convergence (no name in this language: may be words) · {spell:1259686} Skysight
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} stands at the {area:17678}, east of the village. {npc:251143} and Al'Aketh Converts gather just north of her. The {object:460001} is just north-east of her: cast your {spell:1259686} racial ability next to it."] = "{npc:249363} se tient près de {area:17678}, à l'est du village. Des {npc:251143} et des Convertis al'aketh se rassemblent juste au nord d'elle. La Convergence élémentaire se trouve juste au nord-est d'elle : lancez votre technique raciale {spell:1259686} à côté.",
	-- {spell:1259686} Skysight · {object:460001} Elemental Convergence (no name in this language: may be words)
	["Cast {spell:1259686} near the {object:460001}"] = "Lancez {spell:1259686} près de la Convergence élémentaire",

	-- Step 8: The Cirrusfly Queen
	["The queen hovers at the south-east end of the grove, on your way back from the stones."] = "La reine plane à l'extrémité sud-est du bosquet, sur le chemin du retour depuis les pierres.",

	-- Step 9: Thendal Village turn-ins
	-- {area:16635} Thendal Village
	["{area:16635} turn-ins"] = "Quêtes à rendre à {area:16635}",
	-- {npc:251376} Tai'ree Farsight · {npc:251361} Rorian the Dayseeker
	["{npc:251376}, beside {npc:251361}"] = "{npc:251376}, à côté de {npc:251361}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}, dans la tour de guet",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, dans la tour de guet",

	-- Step 10: Thendal Grove: kill these as you meet them
	-- {npc:250926} Scrawny Ursera · {npc:252095} Hanaa Nightwind · {npc:251115} Urs'anah
	["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}.\nThe Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "Des {npc:250926} rôdent sur les pentes au sud-ouest du village, sur le chemin de {npc:252095}.\nLa tanière des Ursera se trouve à l'ouest du village. {npc:251115}, leur matriarche, se tient tout au fond.",
	["Below ground"] = "Sous terre",

	-- Step 11: Back to Thendal Village
	-- {npc:257551} Valreaa Valewind · {npc:251366} Aetheen of the Gales · {npc:252095} Hanaa Nightwind
	["Back up from the den to {npc:257551} and {npc:251366} in the village before heading south-west to {npc:252095}: the road from her camp leads on south to Shen'dar."] = "",

	-- Step 12: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {area:16622} Thendal Grove · {npc:256935} Malduko Cloudcrush
	["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it.\nCareful: {npc:256935} casts shocks; drag him clear of the other cultists before fighting so they don't join in."] = "{npc:252095} attend à {area:16622}, au sud-ouest du village. Le camp al'aketh se trouve juste derrière elle ; {npc:256935} le dirige.\nAttention : {npc:256935} lance des horions ; éloignez-le des autres sectateurs avant de le combattre pour qu'ils ne s'en mêlent pas.",
	-- {item:251924} Signet of Akir · {npc:252095} Hanaa Nightwind
	["{item:251924}: the Al'Aketh in {npc:252095}'s camp carry it"] = "{item:251924} : les Al'aketh du camp près de {npc:252095} le portent",

	-- Step 13: Windshaper Boro
	-- {area:16635} Thendal Village
	["Back to Boro in {area:16635} with the Signet."] = "",
	-- {item:6635} Earth Sapta · {area:16988} Rise of Spirits · {npc:251166} Minor Manifestation of Earth
	["drink the {item:6635} at the {area:16988}, just east of the village, to see the {npc:251166}"] = "buvez {item:6635} à {area:16988}, juste à l'est du village, pour voir la {npc:251166}",
	-- {npc:251374} Windshaper Boro · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {npc:5873} and your {item:5175}"] = "{npc:251374} : {npc:5873} et votre {item:5175}",

	-- Step 14: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:251523} Constable Aonda · {npc:251902} Illaya Amberwind · {npc:254089} Coriella Calmbreeze · {npc:263664} Raan Wildwind
	["Follow the road south to {area:16624}, in the middle of the isle. {npc:251523} stands on its east side, {npc:251902} in the middle, {npc:254089} just north-west of her, {npc:263664} by the campfire on the west side."] = "",
	-- {npc:251902} Illaya Amberwind
	["talk to {npc:251902}"] = "parlez à {npc:251902}",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "/sit près du feu de camp de {npc:263664} jusqu'à obtenir {spell:1229451}",
	-- {npc:251905} Zerril Softbreeze
	["{npc:251905}: Camping 101 asks you to learn it"] = "{npc:251905} : la quête Camping 101 vous demande de l'apprendre",

	-- Step 15: Shen'dar Village: kill these as you meet them
	-- {area:16624} Shen'dar Village
	["{area:16624}: kill these as you meet them"] = "{area:16624} : tuez-les au passage",
	-- {area:16624} Shen'dar Village · {item:5469} Strider Meat · {npc:251905} Zerril Softbreeze
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw · Small Eggs = {item:6889} Small Egg
	["Prideclaws and Galestriders share the meadows around {area:16624}; the Galestriders graze thickest just west of it. They drop both the Small Eggs and the {item:5469} for {npc:251905}."] = "",

	-- Step 16: Shen'dar Village hand-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} hand-ins"] = "Quêtes à rendre à {area:16624}",
	-- {npc:251905} Zerril Softbreeze · {npc:251906} Teeri Wellwind · {npc:251991} Taleen Shimmerthread · {npc:252172} Danarii Bellowveil · {npc:251523} Constable Aonda · {area:16624} Shen'dar Village · {item:5469} Strider Meat
	["{npc:251905}, {npc:251906}, {npc:251991}, {npc:252172} and {npc:251523} all stand in {area:16624}. If you are still short of {item:5469}, the Galestriders graze just south of the village."] = "{npc:251905}, {npc:251906}, {npc:251991}, {npc:252172} et {npc:251523} se tiennent tous à {area:16624}. S'il vous manque encore de la {item:5469}, les Trotteurs des trombes paissent juste au sud du village.",

	-- Step 17: Shen'dar Highlands: kill these as you meet them
	-- {area:16623} Shen'dar Highlands
	["{area:16623}: kill these as you meet them"] = "{area:16623} : tuez-les au passage",
	["The apprentices practise north-east of the village.\nThe bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "Les apprentis s'entraînent au nord-est du village.\nLes camps de bandits se trouvent au nord-est du village ; \"Badwind\" Bennic tient le camp du haut. Les bandits portent les pierres de vent volées.",

	-- Step 18: Shen'dar bounty board
	["Shen'dar bounty board"] = "Tableau des primes de Shen'dar",
	["the bounty board"] = "le tableau des primes",

	-- Step 19: Shen'dar Village turn-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} turn-ins"] = "Quêtes à rendre à {area:16624}",

	-- Step 20: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["{npc:254589} lurks south of the village, among the Prideclaws. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} rôde au sud du village, parmi les Fièregriffes. {npc:254589} est un élite : mieux vaut être en groupe.",

	-- Step 21: Falaath Village
	-- {quest:92529} Falaath Village · {npc:257065} Missionary Jasaan
	["{quest:92529} lies south of Shen'dar. {npc:257065} meets you at its edge; search the wardrobe in the house behind him."] = "{quest:92529} se trouve au sud de Shen’dar. {npc:257065} vous attend à son entrée ; fouillez l'armoire de la maison derrière lui.",
	["search the wardrobe"] = "fouillez l'armoire",

	-- Step 22: Constable Aonda
	-- {npc:251523} Constable Aonda · {area:16624} Shen'dar Village
	["{npc:251523} waits in {area:16624} for what you found in the wardrobe."] = "{npc:251523} attend à {area:16624} ce que vous avez trouvé dans l'armoire.",

	-- Step 23: Shen'dar Highlands: kill these as you meet them
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	-- plural, as words: Supply Caches = {object:576179} Supply Cache
	["Back at {quest:92529}: Stormcallers and {npc:251662} fill the village, the Supply Caches stand among the houses and {npc:251966} waits at its south-east end."] = "De retour à {quest:92529} : des Mande-foudre al'aketh et {npc:251662} emplissent le village, les Caches de fournitures ({object:576179}) se trouvent entre les maisons et {npc:251966} attend à son extrémité sud-est.",

	-- Step 25: The West Pylon Watchtower
	-- {area:17674} West Pylon Watchtower
	["The {area:17674}"] = "{area:17674}",
	-- {area:17674} West Pylon Watchtower · {npc:252155} Peacekeeper Vaaniel · {item:254871} Bloody Note
	["Head south-west to the {area:17674}. {npc:252155} is at the top; the {item:254871} lies beside him."] = "Allez au sud-ouest jusqu'à la {area:17674}. {npc:252155} est au sommet ; {item:254871} se trouve à côté de lui.",
	-- {npc:252155} Peacekeeper Vaaniel
	["talk to {npc:252155}"] = "parlez à {npc:252155}",

	-- Step 26: Skypriest Aanders
	["Aanders and the fallen guards are just south-west of the tower. Take Raani's feather and the Shadowsong signet from the bodies."] = "Aanders et les gardes tombés sont juste au sud-ouest de la tour. Prenez la Plume porte-bonheur de Raani et la chevalière Shadowsong sur les corps.",

	-- Step 27: Shen'dar Highlands: kill these as you meet them
	-- {area:17674} West Pylon Watchtower · {quest:92529} Falaath Village · {item:263493} Hippogryph Down
	["The hippogryph nests are north-west of the {area:17674}, west of {quest:92529}. The Matriarch sits at their western end; {item:263493} lies on the ground around the nests."] = "Les nids d'hippogriffes se trouvent au nord-ouest de {area:17674}, à l'ouest de {quest:92529}. La Matriarche se tient à leur extrémité ouest ; {item:263493} jonche le sol autour des nids.",

	-- Step 29: Fendaal Windstone
	-- {area:16638} Valanaar · {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["On the road south-east to {area:16638}, {npc:273017} watches the {quest:98512} just north of him."] = "",

	-- Step 30: Valanaar
	-- {npc:252476} Talaanis Shadowsong
	["{npc:252476}, upstairs"] = "{npc:252476}, à l'étage",
	-- {npc:252383} Valennia Stormfist
	["{npc:252383}, upstairs"] = "{npc:252383}, à l'étage",

	-- Step 31: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "Retour à {area:16638}",

	-- Step 32: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Sauteciels",
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers hop about the fields just west of Valennia."] = "Des Sauteciels ({npc:251727}) sautillent dans les champs juste à l'ouest de Valennia.",

	-- Step 33: Ayessa Dawnsinger
	-- {npc:260628} Valennia Stormfist
	["{npc:260628}, upstairs"] = "",
	-- {npc:251968} Ayessa Dawnsinger
	["talk to {npc:251968}"] = "parlez à {npc:251968}",
	-- {npc:252382} Sessaria Skystride · {npc:251968} Ayessa Dawnsinger · {quest:97243} Call of Fire
	["{npc:252382}, beside {npc:251968}: {quest:97243}"] = "{npc:252382}, à côté de {npc:251968} : {quest:97243}",

	-- Step 34: Nyalah Brightfire and Alvarion Windfield
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield
	["{npc:257006} and {npc:252448}"] = "{npc:257006} et {npc:252448}",
	-- {npc:257006} Nyalah Brightfire · {area:16638} Valanaar · {npc:252448} Alvarion Windfield
	["{npc:257006} waits inside a house on {area:16638}'s western edge; {npc:252448} is close by."] = "{npc:257006} attend dans une maison à la lisière ouest de {area:16638} ; {npc:252448} est tout près.",
	-- {npc:255940} Donaal Downbreeze
	["Innkeeper {npc:255940}, by the west gate"] = "L'aubergiste {npc:255940}, près de la porte ouest",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "Écoutez l'histoire de {npc:252448}",
	-- {npc:252389} Quel'ana Quickgale · {npc:257006} Nyalah Brightfire · {quest:94978} Taming the Beast
	["{npc:252389}, a few steps west of {npc:257006}: {quest:94978}, the first rod"] = "{npc:252389}, à quelques pas à l'ouest de {npc:257006} : {quest:94978}, le premier bâtonnet",
	-- {npc:257006} Nyalah Brightfire
	["{npc:257006}, inside"] = "{npc:257006}, à l'intérieur",

	-- Step 35: Riaani Nightwind
	-- {npc:256083} Riaani Nightwind · {area:16626} Gustberry Lowlands
	["{npc:256083} stands in the {area:16626} just north-west of town."] = "{npc:256083} se tient dans les {area:16626}, juste au nord-ouest de la ville.",
	-- {npc:256083} Riaani Nightwind
	["Listen to {npc:256083}"] = "Écoutez {npc:256083}",
	-- {npc:252377} Seena Skybreaker · {npc:256083} Riaani Nightwind · {quest:94003} The Skybreaker Bulwark
	["{npc:252377}, beside {npc:256083}: {quest:94003}"] = "{npc:252377}, à côté de {npc:256083} : {quest:94003}",

	-- Step 36: Windfield Orchard
	-- {area:16663} Windfield Orchard · {area:16638} Valanaar
	["{area:16663} is west of {area:16638} along the coast road."] = "Le {area:16663} est à l'ouest de {area:16638}, sur la route côtière.",

	-- Step 37: The orchard
	["The orchard"] = "Le verger",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Stormapples and flutterfly dust lie all over the orchard; Hungry Bandits raid it. Galestriders graze in the fields east of it. The broken construct floats at the orchard's north edge."] = "Des Pommes d’orage mûres et de la Poussière de voltemouche jonchent le verger ; des Bandits affamés ({npc:252802}) le pillent. Des trotteurs des trombes paissent dans les champs à l'est. L'assemblage brisé flotte à la lisière nord du verger.",
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple
	["Ripe Stormapples"] = "",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Hungry Bandits"] = "",
	-- {npc:268592} Olariaan Swiftburn
	["{npc:268592}, at the Shrine of Flames just south-east of the orchard"] = "{npc:268592}, au sanctuaire des Flammes juste au sud-est du verger",

	-- Step 39: Gustberry Lowlands: kill these as you meet them
	-- {area:16626} Gustberry Lowlands
	["{area:16626}: kill these as you meet them"] = "{area:16626} : tuez-les au passage",
	-- {area:16663} Windfield Orchard
	-- plural, as words: Blood-Stained Bandit Masks = {item:253596} Blood-Stained Bandit Mask
	["The Highwayman Bandits hold the hills north of {area:16663}; they drop the Blood-Stained Bandit Masks."] = "Les Bandits de grand chemin tiennent les collines au nord de {area:16663} ; ils lâchent les Masques de bandit tachés de sang.",

	-- Step 40: Standing Our Ground
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "Dites à {npc:252800} que vous êtes prêt",

	-- Step 41: Shen'dar Highlands: kill these as you meet them
	-- {item:260881} Crystallized Lightning · {npc:256083} Riaani Nightwind
	["The {item:260881} lies in a cave in the hills north-west of {npc:256083}."] = "{item:260881} se trouve dans une grotte des collines au nord-ouest de {npc:256083}.",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["tame one with {npc:252389}'s first {item:15908} while you are among them"] = "apprivoisez-en un avec le premier {item:15908} de {npc:252389} pendant que vous êtes parmi eux",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "Apprivoisez : {npc:254588}",

	-- Step 42: Enchanted Gyrozephyr
	-- {area:16624} Shen'dar Village · {area:16625} Windsong Lake
	-- plural, as words: Enchanted Gyrozephyrs = {item:260883} Enchanted Gyrozephyr
	["The Enchanted Gyrozephyrs lie under water far to the north, east of {area:16624} and south-west of {area:16625}."] = "Les Gyrozéphyrs enchantés reposent sous l'eau loin au nord, à l'est de {area:16624} et au sud-ouest de {area:16625}.",
	["Underwater"] = "Sous l'eau",

	-- Step 43: Alvarion Windfield and Riaani Nightwind
	-- {npc:252448} Alvarion Windfield · {npc:256083} Riaani Nightwind
	["{npc:252448} and {npc:256083}"] = "{npc:252448} et {npc:256083}",

	-- Step 44: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 45: Warlock trainer
	["Warlock trainer"] = "Maître des démonistes",
	-- {npc:2127} Rupert Boch · {zone:1420} Tirisfal Glades · {area:16638} Valanaar
	["{npc:2127} in {zone:1420}; {area:16638} has no warlock trainer"] = "{npc:2127} ({zone:1420}) ; {area:16638} n'a pas de maître des démonistes",

	-- Step 47: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod · {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider · Vuldren Alphas = {npc:250874} Vuldren Alpha
	["{npc:252389} takes back the first {item:15908} and hands you two more, one at a time: Ornery Galestriders and Vuldren Alphas roam the fields just north of her. Tame each with its rod and bring the rod back to her. {npc:254411}, beside her, teaches {spell:5149}."] = "{npc:252389} reprend le premier {item:15908} et vous en donne deux autres, l'un après l'autre : des Trotteurs des trombes hargneux et des Alphas vuldrènes parcourent les champs juste au nord d'elle. Apprivoisez chacun avec son bâtonnet et rapportez-lui le bâtonnet. {npc:254411}, à côté d'elle, enseigne {spell:5149}.",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "Apprivoisez : {npc:251707}",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "Apprivoisez : {npc:250874}",

	-- Step 48: Ayessa Dawnsinger
	-- {npc:256247} Belathaan Brightwish · {area:16638} Valanaar · {area:16629} Shrine of Akir
	["{npc:256247} waits on the road north of {area:16638}, towards the {area:16629}."] = "{npc:256247} attend sur la route au nord de {area:16638}, en direction du {area:16629}.",

	-- Step 49: Valennia Stormfist
	["Upstairs"] = "À l'étage",

	-- Step 50: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar · {npc:255853} Urs'endris · {area:17675} East Pylon Watchtower · {spell:1259416} Walk on Air
	["{npc:252359} stands on {area:16638}'s east side. {npc:255853} waits by the falls just north of the {area:17675}: leave town to the north, climb the ridge east of the road and glide down to him with {spell:1259416}."] = "{npc:252359} se tient du côté est de {area:16638}. {npc:255853} attend près des chutes juste au nord de {area:17675} : quittez la ville par le nord, grimpez sur la crête à l'est de la route et descendez en planant jusqu'à lui avec {spell:1259416}.",

	-- Step 51: The East Pylon Watchtower
	-- {area:17675} East Pylon Watchtower
	["The {area:17675}"] = "{area:17675}",
	-- {area:17675} East Pylon Watchtower · {npc:252666} Commander Belguilos
	["Head north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "Dirigez-vous vers le nord-est jusqu'à {area:17675}. Le camp al'aketh se trouve juste à l'ouest, avec {npc:252666} à son extrémité nord. Chaque sectateur peut lâcher un charme de pierre de vent.",
	-- {npc:268602} Skypriest Faladiel
	["{npc:268602}, on the hill west of the falls just north of the watchtower"] = "{npc:268602}, sur la colline à l'ouest des chutes, juste au nord de la tour de guet",

	-- Step 53: The turncoat
	["The turncoat"] = "Le traître",
	-- {area:16626} Gustberry Lowlands · {area:16638} Valanaar · {npc:273017} Fendaal Windstone
	["The turncoat's house is in the {area:16626} north-west of {area:16638}, just north of {npc:273017}."] = "",
	["search the dead cultist in the house"] = "fouillez le cultiste mort dans la maison",
	-- {npc:253372} Dead Cultist
	["{npc:253372}, inside"] = "{npc:253372}, à l'intérieur",

	-- Step 54: Ur'endra
	-- {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands · {area:16626} Gustberry Lowlands
	["{npc:258443} has her lair in a cave in the bluffs just south of the turncoat's house, where the {area:16623} meet the {area:16626}."] = "{npc:258443} a son repaire dans une grotte des falaises juste au sud de la maison du traître, là où {area:16623} rejoignent {area:16626}.",

	-- Step 56: Olariaan Swiftburn
	-- {item:277267} Faladiel's Heart · {npc:268592} Olariaan Swiftburn · {area:16638} Valanaar · {area:16623} Shen'dar Highlands · {npc:268605} Kuramaa
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Take {item:277267} to {npc:268592} at the Shrine of Flames, south-west of {area:16638}, then head west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "Apportez {item:277267} à {npc:268592} au sanctuaire des Flammes, au sud-ouest de {area:16638}, puis partez vers l'ouest dans {area:16623} : la demeure de {npc:268605} se trouve dans les collines au sud des lacs des Clampants chantevent.",

	-- Step 57: Zephras Isle
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",

	-- Step 58: The Eternal Flame
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Wait for him to light the {npc:268762}, then carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638} before the timer runs out."] = "Retournez voir {npc:268592}. Attendez qu'il allume {npc:268762}, puis portez la flamme directement jusqu'à {npc:268679}, à côté de {npc:252382} à {area:16638}, avant la fin du temps imparti.",
	-- {npc:252382} Sessaria Skystride · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:252382} : {npc:2523}, votre {item:5176} et {item:263412}",

	-- Step 59: Unfortunate News
	-- {npc:252476} Talaanis Shadowsong
	["talk to {npc:252476}"] = "parlez à {npc:252476}",

	-- Step 62: Desperate Times
	-- {npc:253844} Valennia Stormfist
	["talk to {npc:253844}"] = "parlez à {npc:253844}",

	-- Step 63: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["{npc:257196} holds the {item:263993} on the west side of the shrine."] = "{npc:257196} tient {item:263993} du côté ouest du sanctuaire.",

	-- Step 64: Strength and Mercy
	-- {npc:255853} Urs'endris · {area:17675} East Pylon Watchtower · {spell:1259416} Walk on Air
	["On your way north from Valennia, {npc:255853} waits by the falls north-east of you, just north of the {area:17675}: from the ridge above them, glide down with {spell:1259416}."] = "En repartant vers le nord depuis Valennia, {npc:255853} attend près des chutes au nord-est, juste au nord de {area:17675} : depuis la crête qui les surplombe, descendez en planant avec {spell:1259416}.",

	-- Step 65: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}; {npc:257944} camps at its southern edge."] = "Allez vers le nord dans la {area:16631} ; {npc:257944} campe à sa lisière sud.",

	-- Step 66: Shadowgale Forest: kill these as you meet them
	-- {area:16631} Shadowgale Forest
	["{area:16631}: kill these as you meet them"] = "{area:16631} : tuez-les au passage",
	-- {item:265105} Lady's Tear Moss · {npc:257944} Elegael Thornpaw · {item:265141} Bloody Heirloom
	["{item:265105} grows around {npc:257944}'s camp and Shriekings fly over it. The Al'Aketh camp east of her holds the {item:265141}."] = "{item:265105} pousse autour du camp d'{npc:257944} et des criailleuses le survolent. Le camp al'aketh à l'est d'elle contient {item:265141}.",

	-- Step 67: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "De nouveau {npc:257944}",

	-- Step 68: The Al'Aketh camp
	["The Al'Aketh camp"] = "Le camp al'aketh",
	-- {npc:253622} Commander Haalien · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:254151} Vayn Moongaze · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:253622}, {npc:258130} and {npc:258134} are in the cult camp east of {npc:257944}. {npc:254151} stands at its edge. Haalien also drops a {quest:94490}: read it to start the next quest. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:253622}, {npc:258130} et {npc:258134} sont dans le camp du culte à l'est d'{npc:257944}. {npc:254151} se tient à sa lisière. Haalien lâche aussi {quest:94490} : lisez-la pour commencer la quête suivante. Pour {quest:94489}, entrez dans la tanière des Crocs-de-la-nuit, soignez 7 druides blessés et trouvez {npc:258130}.",
	["Heal the injured druids in the Nightfang Den"] = "Soignez les druides blessés dans la tanière des Crocs-de-la-nuit",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "Trouvez {npc:258130}",

	-- Step 69: Elegael Thornpaw, last time
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, last time"] = "{npc:257944}, une dernière fois",

	-- Step 70: The Strange Hermit
	-- {area:16625} Windsong Lake
	["The hermit lives at {area:16625}'s west shore."] = "",
	-- {npc:251684} Strange Hermit
	["talk to {npc:251684}"] = "parlez à {npc:251684}",

	-- Step 71: Windsong Lake
	-- {item:257128} Zephyrseed · {npc:254344} Endaria Mistgaze · {quest:93736} Unwelcome Spirits · {area:16625} Windsong Lake · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow · Wind Hollow Essences = {item:262357} Wind Hollow Essence
	["{item:257128} cones grow south of the hermit; the Wind Hollows drift east of the lake and also drop the Wind Hollow Essences for {npc:254344}'s {quest:93736}. The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "",

	-- Step 73: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:253576} Hyusaa Quickbreeze
	["The {area:16629} is north of {area:16638}. Fight through the guards up to {npc:253576} at its east side."] = "Le {area:16629} est au nord de {area:16638}. Frayez-vous un chemin à travers les gardes jusqu'à {npc:253576}, du côté est.",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, upstairs"] = "{npc:253590}, à l'étage",

	-- Step 74: Portal to Rohashi Spires
	-- {area:16630} Rohashi Spires
	["Portal to {area:16630}"] = "Portail vers {area:16630}",

	-- Step 75: Confront Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {object:617084} Portal to Valanaar (no name in this language: may be words)
	["Take the Portal to {area:16630} in the shrine up to the heights. Fight east along the ledge to the Peacekeepers at its end, ride the wind current up to the upper terrace and tell {npc:252475} you are ready. Leave the {object:617084} up there alone until Rohash has withdrawn; then it takes you straight back to town."] = "Prenez le portail vers {area:16630} dans le sanctuaire pour monter sur les hauteurs. Frayez-vous un chemin vers l'est le long de la corniche jusqu'aux Gardiens de la paix au bout, empruntez le courant d'air jusqu'à la terrasse supérieure et dites à {npc:252475} que vous êtes prêt. Ne touchez pas au portail vers Valanaar là-haut tant que Rohash ne s'est pas retiré ; ensuite, il vous ramène directement en ville.",

	-- Step 76: The Fate of Zephras
	-- {npc:254344} Endaria Mistgaze · {npc:251968} Ayessa Dawnsinger
	["{npc:254344}, beside {npc:251968}"] = "{npc:254344}, à côté de {npc:251968}",

	-- Step 77: Seena Skybreaker
	-- {npc:252377} Seena Skybreaker · {npc:256083} Riaani Nightwind · {area:16638} Valanaar
	["{npc:252377} stands beside {npc:256083}, just north-west of {area:16638}."] = "{npc:252377} se tient à côté de {npc:256083}, juste au nord-ouest de {area:16638}.",

	-- Step 78: Valanaar
	-- {npc:251968} Ayessa Dawnsinger · {area:16638} Valanaar · {zone:1412} Mulgore · {npc:259119} Alaana Stormwalker
	["{npc:251968} sends you on to Kalimdor. Once you have trained, board the skycutter at the dock on {area:16638}'s south-west edge: it flies to northern {zone:1412}, where {npc:259119} waits."] = "{npc:251968} vous envoie vers Kalimdor. Une fois entraîné, montez à bord du coupe-ciel au quai, à la lisière sud-ouest de {area:16638} : il vole jusqu'au nord de {zone:1412}, où {npc:259119} vous attend.",

	-- Step 81: Leave Zephras Isle to Mulgore
	-- {zone:2521} Zephras Isle · {zone:1412} Mulgore
	["Leave {zone:2521} to {zone:1412}"] = "Quittez {zone:2521} pour {zone:1412}",

	-- Step 82: Northern Mulgore
	-- {zone:1412} Mulgore
	["Northern {zone:1412}"] = "Nord de {zone:1412}",
	-- {npc:259119} Alaana Stormwalker
	["You leave the isle for good. {npc:259119} waits where the airship lands."] = "Vous quittez l'île pour de bon. {npc:259119} attend là où se pose le dirigeable.",
	-- {npc:259119} Alaana Stormwalker · {zone:1454} Orgrimmar
	["{npc:259119}: keep it: Thrall in {zone:1454}, at the start of the next guide"] = "",
	-- {npc:259118} Muln Earthfury · {npc:3033} Turak Runetotem · {zone:1456} Thunder Bluff
	["{npc:259118}, by the landing: for {npc:3033} in {zone:1456}"] = "{npc:259118}, près de l'aire d'atterrissage : pour {npc:3033} à {zone:1456}",

	-- Step 83: Clarice Foster
	-- {npc:5543} Clarice Foster · {area:2197} Pools of Vision · {area:1640} Spirit Rise
	["{npc:5543} stands in the {area:2197}, the cave under {area:1640}: go down inside, the arrow cannot tell the floors apart."] = "",

	-- Step 85: Traditions of the Bluff
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

	-- Step 86: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 21 (forever/horde/02-the-barrens)."] = "",

	-- Step 87: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Utilisez l'{item:278078} sur le tapis et le brûleur de cérémonie, sur la falaise sud de {area:1641}.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Répandez l'{item:278078} depuis {area:1641}",

	-- Step 89: Ansekhwa
	-- {spell:199} Two-Handed Maces · {npc:11869} Ansekhwa
	["While you're here: learn {spell:199} from {npc:11869} (10 silver); two-handers level a Warrior fastest."] = "Tant que vous y êtes : apprenez {spell:199} auprès de {npc:11869} (10 pièces d'argent) ; les armes à deux mains font monter un guerrier le plus vite.",

	-- Step 90: Ansekhwa
	-- {npc:11869} Ansekhwa
	["While you're here: learn Staves from {npc:11869} (10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Tant que vous y êtes : apprenez les Bâtons auprès de {npc:11869} (10 pièces d'argent) ; l'arme de mêlée d'un chasseur compte surtout pour ses caractéristiques, et les armes à deux mains en apportent le plus.",

	-- Step 91: Into Mulgore
	-- {zone:1412} Mulgore
	["Into {zone:1412}"] = "Vers {zone:1412}",

	-- Step 92: Into The Barrens
	-- {zone:1413} The Barrens
	["Into {zone:1413}"] = "Vers les {zone:1413}",

	-- Step 94: The Crossroads
	-- {npc:3615} Devrak · {area:380} The Crossroads · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Learn the flight path from {npc:3615} on the tower platform. {area:380}' own quests come after {zone:1421}, in the {zone:1413} guide."] = "",

	-- Step 95: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "Vers {zone:1454}",
	-- {area:379} Far Watch Post · {area:815} Southfury River · {zone:1411} Durotar · {zone:1454} Orgrimmar · {quest:95350} Welcome to Azeroth · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	["From the Crossroads follow the road north-east to {area:379}, cross the {area:815} into {zone:1411} and keep north to {zone:1454}'s main gate. The next guide starts in {zone:1454}: Thrall takes {quest:95350}, and the zeppelin leaves for {zone:1420} and {zone:1421}."] = "",
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:16624} with what you found."] = "Retournez à {area:16624} avec ce que vous avez trouvé.",
	-- ["Back to {npc:268592}, then west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "Retournez voir {npc:268592}, puis allez vers l'ouest dans les {area:16623} : la demeure de {npc:268605} est dans les collines au sud des lacs des Clampants chantevent.",
	-- ["Bandit Highwaymen"] = "Bandits de grand chemin",
	-- ["Climb the watchtower in the village, jump off the top and use {spell:1259416} to float down."] = "Montez en haut de la tour de guet du village, sautez du sommet et utilisez {spell:1259416} pour redescendre en planant.",
	-- ["Faladiel stands on the hill west of the falls, north of {area:16638}."] = "Faladiel se tient sur la colline à l'ouest des chutes, au nord de {area:16638}.",
	-- ["Follow the road south to {area:16624}, in the middle of the isle."] = "Suivez la route vers le sud jusqu'à {area:16624}, au milieu de l'île.",
	-- ["Hearth to {area:16638}"] = "Pierre de foyer vers {area:16638}",
	-- ["High Order Apprentices"] = "Apprentis de l'Ordre suprême ({npc:257521})",
	-- ["Hippogryph nests"] = "Nids d'hippogriffes",
	-- ["Horde airship"] = "Dirigeable de la Horde",
	-- ["Into {area:17}"] = "Vers {area:17}",
	-- ["Kuramaa"] = "Kuramaa",
	-- ["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "Quittez {zone:1456} par un ascenseur et suivez la route vers le sud en passant {area:222}, puis le col oriental pour entrer dans {zone:1413} ; depuis le col, prenez la {area:458} vers le nord jusqu'à la {area:380}, la ville de la Horde au milieu de {zone:1413}.",
	-- ["Leaving {area:16635}"] = "Départ de {area:16635}",
	-- ["On the way"] = "En chemin",
	-- ["On the way north, back to {npc:255853} by the falls."] = "En remontant vers le nord, retournez voir {npc:255853} près des chutes.",
	-- ["Prideclaws and Galestriders"] = "Fièregriffes et trotteurs des trombes",
	-- ["Prideclaws and Galestriders share the meadows south of the village. Keep the {item:5469} for {npc:251905}; the eggs come later from the hippogryphs."] = "Fièregriffes et trotteurs des trombes se partagent les prés au sud du village. Gardez la {item:5469} pour {npc:251905} ; les œufs viendront plus tard des hippogriffes.",
	-- ["Prideclaws and Galestriders share the meadows south of {area:16624}. The Galestriders drop both the Small Eggs and the {item:5469} for {npc:251905}."] = "Fièregriffes et Trotteurs des trombes se partagent les prairies au sud de {area:16624}. Les Trotteurs des trombes lâchent à la fois les Petits œufs et la {item:5469} pour {npc:251905}.",
	-- ["Ride north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "Chevauchez vers le nord-est jusqu'à la {area:17675}. Le camp al'aketh se trouve juste à l'ouest, avec {npc:252666} à son extrémité nord. Chaque cultiste peut lâcher un Charme de pierre de vent al’aketh.",
	-- ["Rorian: {quest:92485}"] = "Rorian : {quest:92485}",
	-- ["Sit by {npc:263664}'s campfire (type /sit) until you get the {spell:1229451} buff, then find {npc:251905} at the cook fire."] = "Asseyez-vous près du feu de camp de {npc:263664} (tapez /sit) jusqu'à obtenir l'amélioration {spell:1229451}, puis trouvez {npc:251905} près du feu de cuisson.",
	-- ["Sit by {npc:263664}'s campfire (type /sit) until you get the {spell:1229451} buff, then learn {skill:185} from {npc:251905} at the cook fire."] = "Asseyez-vous près du feu de camp de {npc:263664} (tapez /sit) jusqu'à obtenir l'effet {spell:1229451}, puis apprenez {skill:185} auprès de {npc:251905}, au feu de cuisine.",
	-- ["Take the Torch of Dormant Flame to {npc:268592} at the Shrine of Flames, south-west of {area:16638} in the {area:16626}."] = "Apportez la Torche de la flamme dormante à {npc:268592}, au sanctuaire des Flammes, au sud-ouest de {area:16638} dans les {area:16626}.",
	-- ["Take the portal up to the {area:16630} and join {npc:252475} and {npc:251968} against the High Priestess."] = "Prenez le portail pour monter aux {area:16630} et rejoignez {npc:252475} et {npc:251968} contre la grande prêtresse.",
	-- ["Take the road south-east to {area:16638}, the Skyborne town on the south coast. {npc:257006} and {npc:252448} stand at its western edge."] = "Prenez la route vers le sud-est jusqu'à {area:16638}, la ville céleste de la côte sud. {npc:257006} et {npc:252448} se tiennent à sa lisière ouest.",
	-- ["Talk to {npc:251902}"] = "Parlez à {npc:251902}",
	-- ["Talk to {npc:251968}"] = "Parlez à {npc:251968}",
	-- ["Talk to {npc:252383}"] = "Parlez à {npc:252383}",
	-- ["Talk to {npc:252800}"] = "Parlez à {npc:252800}",
	-- ["Talk to {npc:253576}"] = "Parlez à {npc:253576}",
	-- ["Talk to {npc:254089}"] = "Parlez à {npc:254089}",
	-- ["The Al'Aketh cultists in the camp beyond {npc:252095} carry the signet."] = "Les cultistes al'aketh du camp derrière {npc:252095} portent la chevalière.",
	-- ["The Horde airship docks at the south-west edge of {area:16638}. Ride it to Kalimdor; it lands in northern {zone:1412}."] = "Le dirigeable de la Horde est amarré à la lisière sud-ouest de {area:16638}. Prenez-le pour Kalimdor ; il se pose dans le nord de {zone:1412}.",
	-- ["The Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "La tanière des ursera est à l'ouest du village. {npc:251115}, leur matriarche, se trouve tout au fond.",
	-- ["The airship"] = "Le dirigeable",
	-- ["The apprentices practise north-east of the village."] = "Les apprentis s'entraînent au nord-est du village.",
	-- ["The bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "Les camps de bandits sont au nord-est du village ; Bennic « Mauvais vent » tient le camp le plus haut. Les bandits portent les pierres de vent volées.",
	-- ["The crawlers scuttle along the shore south-west of town."] = "Les clampants trottinent le long du rivage au sud-ouest de la ville.",
	-- ["The hermit lives at {area:16625}'s west shore. {item:257128} cones grow south of him; the Wind Hollows drift east of the lake and also drop the Wind Hollow Essences for {npc:254344}'s {quest:93736}."] = "L'ermite vit sur la rive ouest de {area:16625}. Des cônes de {item:257128} poussent au sud de chez lui ; les Creux du vent flottent à l'est du lac et lâchent aussi les Essences de creux du vent pour {quest:93736} de {npc:254344}.",
	-- ["The hermit lives at {area:16625}'s west shore. {item:257128} cones grow south of him; the Wind Hollows drift east of the lake."] = "L'ermite vit sur la rive ouest du {area:16625}. Les cônes de {item:257128} poussent au sud de chez lui ; les Creux du vent ({npc:251676}) dérivent à l'est du lac.",
	-- ["The highland bandits"] = "Les bandits des hautes-terres",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616466} lie near the road to {area:16638}."] = "Les bandits de grand chemin tiennent les collines au nord-est du verger. D'autres {object:616466} se trouvent près de la route de {area:16638}.",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616468} lie near the road to {area:16638}."] = "Les bandits de grand chemin tiennent les collines au nord-est du verger. D'autres {object:616468} se trouvent près de la route de {area:16638}.",
	-- ["The hippogryph nests are north-west of the tower, west of {quest:92529}; the Matriarch sits at the western end. {item:263493} lies on the ground around them, and the hippogryphs drop the Small Eggs."] = "Les nids d'hippogriffes sont au nord-ouest de la tour, à l'ouest de {quest:92529} ; la Matriarche se tient à l'extrémité ouest. {item:263493} se trouve au sol autour d'eux, et les hippogriffes lâchent les Petits oeufs ({item:6889}).",
	-- ["The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "Les affaires des réfugiés sont éparpillées le long de la rive nord du {area:16625} ; {npc:259013} est à son extrémité nord-ouest.",
	-- ["The turncoat's house is in the {area:16626} north-west of {area:16638}. {npc:273017} waits nearby; his assassins lurk around the house."] = "La maison du traître se trouve dans les {area:16626}, au nord-ouest de {area:16638}. {npc:273017} attend tout près ; ses assassins rôdent autour de la maison.",
	-- ["The watchtower"] = "La tour de guet",
	-- ["To {area:1637}"] = "Vers {area:1637}",
	-- ["Walk north to {area:16624}; finish the {item:5469} on the Galestriders along the way if you are short."] = "Marchez vers le nord jusqu'à {area:16624} ; finissez la {item:5469} sur les trotteurs des trombes en chemin s'il vous en manque.",
	-- ["Wind Hollows and {object:616466}"] = "Creux du vent ({npc:251676}) et {object:616466}",
	-- ["Wind Hollows and {object:616467}"] = "Creux du vent et {object:616467}",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616466} lie west of the orchard road."] = "Des Creux du vent ({npc:251676}) dérivent au-dessus des plaines autour de {area:16638}. Les premières {object:616466} se trouvent à l'ouest de la route du verger.",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616467} lie west of the orchard road."] = "Des Creux du vent dérivent au-dessus des plaines autour de {area:16638}. Les premières {object:616467} se trouvent à l'ouest de la route du verger.",
	-- ["Windsong Crawlers"] = "Clampants chantevent ({npc:254588})",
	-- ["talk to {npc:251905}"] = "parlez à {npc:251905}",
	-- ["talk to {npc:252383}"] = "parlez à {npc:252383}",
	-- ["{area:1638} is beside the landing: ride up a lift and learn the flight path from {npc:2995}, the wind rider master."] = "{area:1638} est à côté de l'aire d'atterrissage : montez par un ascenseur et apprenez le trajet aérien auprès de {npc:2995}, le maître des coursiers du vent.",
	-- ["{area:16624}, last time"] = "{area:16624}, une dernière fois",
	-- ["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} est votre base pour ce guide. Tous ceux dont vous avez besoin se tiennent à quelques pas de l'auberge.",
	-- ["{item:253591} along the way to {npc:252800}"] = "{item:253591} sur le chemin de {npc:252800}",
	-- ["{item:257128} on the way"] = "{item:257128} en chemin",
	-- ["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}."] = "Des {npc:250926} rôdent sur les pentes au sud-ouest du village, sur le chemin de {npc:252095}.",
	-- ["{npc:251291} along the way to {area:16624} hand-ins"] = "{npc:251291} sur le chemin des quêtes à rendre à {area:16624}",
	-- ["{npc:251291} on the way"] = "{npc:251291} en chemin",
	-- ["{npc:251374} sends you to the {area:16988}, just east of the village: drink the {item:6635} there to see the {npc:251166}, then take the {item:6656} back to him."] = "{npc:251374} vous envoie à la {area:16988}, juste à l'est du village : buvez-y {item:6635} pour voir {npc:251166}, puis rapportez-lui {item:6656}.",
	-- ["{npc:251374} stands in the village."] = "{npc:251374} se tient dans le village.",
	-- ["{npc:251374}, at the village centre"] = "{npc:251374}, au centre du village",
	-- ["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it."] = "{npc:252095} attend au {area:16622}, au sud-ouest du village. Le camp al'aketh se trouve juste derrière elle ; {npc:256935} le dirige.",
	-- ["{npc:252359} stands on {area:16638}'s east side."] = "{npc:252359} se tient à l'est de {area:16638}.",
	-- ["{npc:252377} stands in the middle of {area:16638}."] = "{npc:252377} se tient au milieu de {area:16638}.",
	-- ["{npc:252377}: Defensive Stance"] = "{npc:252377} : Posture défensive",
	-- ["{npc:252382} stands on {area:16638}'s west side."] = "{npc:252382} se tient à l'ouest de {area:16638}.",
	-- ["{npc:252389} in {area:16638} hands you a {item:15908} three times: tame a {npc:254588} by the lakes north-west of town, an {npc:251707} in the fields west of town and a {npc:250874} at {area:16663}, returning to her after each. {npc:254411} stands beside her."] = "{npc:252389}, à {area:16638}, vous remet trois fois un {item:15908} : apprivoisez un {npc:254588} près des lacs au nord-ouest de la ville, un {npc:251707} dans les champs à l'ouest de la ville et un {npc:250874} au {area:16663}, en revenant la voir après chacun. {npc:254411} se tient à côté d'elle.",
	-- ["{npc:252802} along the way to {npc:252800}"] = "{npc:252802} sur le chemin de {npc:252800}",
	-- ["{npc:254411}: Beast Training"] = "{npc:254411} : Dressage des bêtes",
	-- ["{npc:255853} waits by the falls just north of the watchtower."] = "{npc:255853} attend près des chutes juste au nord de la tour de guet.",
	-- ["{npc:255853}: Bear Form"] = "{npc:255853} : Forme d’ours",
	-- ["{npc:258443} roams the slopes just south of the turncoat's house."] = "{npc:258443} parcourt les pentes juste au sud de la maison du traître.",
	-- ["{npc:259119}: keep it, Thrall in {zone:1454} comes two guides later"] = "{npc:259119} : gardez-la, Thrall à {zone:1454} vient deux guides plus tard",
	-- ["{npc:263664}'s campfire"] = "Le feu de camp de {npc:263664}",
	-- ["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 23 (forever/horde/04-the-barrens)."] = "{npc:3033} entraîne les druides sur {area:1639}. Il vous apprend {spell:18960} ; l'accueil de {npc:11802} attend votre voyage pour {spell:499} vers le niveau 23 (forever/horde/04-the-barrens).",
	-- ["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449} : les harpies viendront plus tard, dans {area:383}",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, le maître des coursiers du vent",
}
