-- Spanish (Latin America) (esMX): the guide forever/horde/skyborne/01-zephras-isle (forever/horde/skyborne/01-zephras-isle.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Village
	-- {area:16635} Thendal Village · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker
	["You wake in {area:16635}, in the north of the isle. {npc:251362} stands by the path, {npc:251361} at the village centre."] = "Despiertas en {area:16635}, en el norte de la isla. {npc:251362} está junto al sendero, y {npc:251361} en el centro de la aldea.",

	-- Step 2: Thendal Grove: kill these as you meet them
	-- {area:16622} Thendal Grove
	["{area:16622}: kill these as you meet them"] = "",
	-- {npc:250873} Juvenile Vuldren
	["Pesky Cirrusflies and {npc:250873} roam the grove just south-east of the village."] = "Los Cirrovuelos molestos y {npc:250873} rondan la arboleda justo al sureste de la aldea.",

	-- Step 3: Back to Thendal Village
	-- {area:16635} Thendal Village
	["Back to {area:16635}"] = "De vuelta a {area:16635}",
	-- {npc:257554} Halaan Hawk-Eye · {npc:263113} Myriaal Mistwake · {npc:251368} Elatrell Featherlight
	["{npc:257554} and {npc:263113} stand at the top of the watchtower, a few steps north-east of {npc:251368}."] = "",
	-- {npc:257554} Halaan Hawk-Eye
	["talk to {npc:257554}"] = "habla con {npc:257554}",

	-- Step 4: Rorian the Dayseeker's errands
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}'s errands"] = "Los encargos de {npc:251361}",
	-- {spell:1259416} Walk on Air · {npc:251361} Rorian the Dayseeker
	["Jump off the top of the watchtower and use {spell:1259416} to float down to {npc:251361}, west of the tower."] = "",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}: la {item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}: una nota de tu instructor",
	-- {npc:251361} Rorian the Dayseeker · {item:282418} Humming Recall Crystal
	["{npc:251361}: examine the {item:282418}"] = "{npc:251361}: examina el {item:282418}",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}: lee la {item:9547}",
	-- {npc:251374} Windshaper Boro · {npc:251361} Rorian the Dayseeker
	["{npc:251374}, beside {npc:251361}"] = "",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}, el instructor de druidas, en la planta baja del árbol detrás de {npc:251361}",
	-- {npc:251373} Xyton Silverwind
	["Boro and {npc:251373}, while you stand beside them"] = "",

	-- Step 5: Raw Windstones
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones"] = "Piedras de viento en bruto ({object:613286})",
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones are blue crystals on the slopes around the village."] = "Las Piedras de viento en bruto ({object:613286}) son cristales azules en las laderas alrededor de la aldea.",

	-- Step 7: The standing stones
	["The standing stones"] = "Las piedras erguidas",
	-- {npc:249363} Yala Windwatcher · {area:17678} Thendal Standing Stones · {npc:251143} Roiling Winds · {object:460001} Elemental Convergence (no name in this language: may be words) · {spell:1259686} Skysight
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} stands at the {area:17678}, east of the village. {npc:251143} and Al'Aketh Converts gather just north of her. The {object:460001} is just north-east of her: cast your {spell:1259686} racial ability next to it."] = "{npc:249363} está en {area:17678}, al este de la aldea. {npc:251143} y los Conversos Al'Aketh ({npc:251160}) se reúnen justo al norte de ella. {object:460001} está justo al noreste: usa tu habilidad racial {spell:1259686} a su lado.",
	-- {spell:1259686} Skysight · {object:460001} Elemental Convergence (no name in this language: may be words)
	["Cast {spell:1259686} near the {object:460001}"] = "Lanza {spell:1259686} cerca de {object:460001}",

	-- Step 8: The Cirrusfly Queen
	["The queen hovers at the south-east end of the grove, on your way back from the stones."] = "La reina flota en el extremo sureste de la arboleda, de regreso de las piedras.",

	-- Step 9: Thendal Village turn-ins
	-- {area:16635} Thendal Village
	["{area:16635} turn-ins"] = "Entregas en {area:16635}",
	-- {npc:251376} Tai'ree Farsight · {npc:251361} Rorian the Dayseeker
	["{npc:251376}, beside {npc:251361}"] = "",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}, en la atalaya",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, en la atalaya",

	-- Step 10: Thendal Grove: kill these as you meet them
	-- {npc:250926} Scrawny Ursera · {npc:252095} Hanaa Nightwind · {npc:251115} Urs'anah
	["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}.\nThe Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "",
	["Below ground"] = "",

	-- Step 11: Back to Thendal Village
	-- {npc:257551} Valreaa Valewind · {npc:251366} Aetheen of the Gales · {npc:252095} Hanaa Nightwind
	["Back up from the den to {npc:257551} and {npc:251366} in the village before heading south-west to {npc:252095}: the road from her camp leads on south to Shen'dar."] = "",

	-- Step 12: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {area:16622} Thendal Grove · {npc:256935} Malduko Cloudcrush
	["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it.\nCareful: {npc:256935} casts shocks; drag him clear of the other cultists before fighting so they don't join in."] = "",
	-- {item:251924} Signet of Akir · {npc:252095} Hanaa Nightwind
	["{item:251924}: the Al'Aketh in {npc:252095}'s camp carry it"] = "",

	-- Step 13: Windshaper Boro
	-- {area:16635} Thendal Village
	["Back to Boro in {area:16635} with the Signet."] = "",
	-- {item:6635} Earth Sapta · {area:16988} Rise of Spirits · {npc:251166} Minor Manifestation of Earth
	["drink the {item:6635} at the {area:16988}, just east of the village, to see the {npc:251166}"] = "",
	-- {npc:251374} Windshaper Boro · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {npc:5873} and your {item:5175}"] = "{npc:251374}: {npc:5873} y tu {item:5175}",

	-- Step 14: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:251523} Constable Aonda · {npc:251902} Illaya Amberwind · {npc:254089} Coriella Calmbreeze · {npc:263664} Raan Wildwind
	["Follow the road south to {area:16624}, in the middle of the isle. {npc:251523} stands on its east side, {npc:251902} in the middle, {npc:254089} just north-west of her, {npc:263664} by the campfire on the west side."] = "",
	-- {npc:251902} Illaya Amberwind
	["talk to {npc:251902}"] = "habla con {npc:251902}",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "Usa /sit junto a la fogata de {npc:263664} hasta obtener {spell:1229451}",
	-- {npc:251905} Zerril Softbreeze
	["{npc:251905}: Camping 101 asks you to learn it"] = "",

	-- Step 15: Shen'dar Village: kill these as you meet them
	-- {area:16624} Shen'dar Village
	["{area:16624}: kill these as you meet them"] = "",
	-- {area:16624} Shen'dar Village · {item:5469} Strider Meat · {npc:251905} Zerril Softbreeze
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw · Small Eggs = {item:6889} Small Egg
	["Prideclaws and Galestriders share the meadows around {area:16624}; the Galestriders graze thickest just west of it. They drop both the Small Eggs and the {item:5469} for {npc:251905}."] = "",

	-- Step 16: Shen'dar Village hand-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} hand-ins"] = "",
	-- {npc:251905} Zerril Softbreeze · {npc:251906} Teeri Wellwind · {npc:251991} Taleen Shimmerthread · {npc:252172} Danarii Bellowveil · {npc:251523} Constable Aonda · {area:16624} Shen'dar Village · {item:5469} Strider Meat
	["{npc:251905}, {npc:251906}, {npc:251991}, {npc:252172} and {npc:251523} all stand in {area:16624}. If you are still short of {item:5469}, the Galestriders graze just south of the village."] = "",

	-- Step 17: Shen'dar Highlands: kill these as you meet them
	-- {area:16623} Shen'dar Highlands
	["{area:16623}: kill these as you meet them"] = "",
	["The apprentices practise north-east of the village.\nThe bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "",

	-- Step 18: Shen'dar bounty board
	["Shen'dar bounty board"] = "",
	["the bounty board"] = "el tablón de recompensas",

	-- Step 19: Shen'dar Village turn-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} turn-ins"] = "Entregas en {area:16624}",

	-- Step 20: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["{npc:254589} lurks south of the village, among the Prideclaws. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} acecha al sur de la aldea, entre los Leozarpas. {npc:254589} es élite: se recomienda ir en grupo.",

	-- Step 21: Falaath Village
	-- {quest:92529} Falaath Village · {npc:257065} Missionary Jasaan
	["{quest:92529} lies south of Shen'dar. {npc:257065} meets you at its edge; search the wardrobe in the house behind him."] = "{quest:92529} está al sur de Shen'dar. {npc:257065} te espera en las afueras; registra el ropero de la casa detrás de él.",
	["search the wardrobe"] = "registra el ropero",

	-- Step 22: Constable Aonda
	-- {npc:251523} Constable Aonda · {area:16624} Shen'dar Village
	["{npc:251523} waits in {area:16624} for what you found in the wardrobe."] = "",

	-- Step 23: Shen'dar Highlands: kill these as you meet them
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	-- plural, as words: Supply Caches = {object:576179} Supply Cache
	["Back at {quest:92529}: Stormcallers and {npc:251662} fill the village, the Supply Caches stand among the houses and {npc:251966} waits at its south-east end."] = "De vuelta en {quest:92529}: clamatormentas y {npc:251662} llenan la aldea, los alijos de suministros ({object:576179}) están entre las casas y {npc:251966} espera en el extremo sureste.",

	-- Step 25: The West Pylon Watchtower
	-- {area:17674} West Pylon Watchtower
	["The {area:17674}"] = "{area:17674}",
	-- {area:17674} West Pylon Watchtower · {npc:252155} Peacekeeper Vaaniel · {item:254871} Bloody Note
	["Head south-west to the {area:17674}. {npc:252155} is at the top; the {item:254871} lies beside him."] = "Ve al suroeste hasta {area:17674}. {npc:252155} está en lo alto; la {item:254871} está a su lado.",
	-- {npc:252155} Peacekeeper Vaaniel
	["talk to {npc:252155}"] = "habla con {npc:252155}",

	-- Step 26: Skypriest Aanders
	["Aanders and the fallen guards are just south-west of the tower. Take Raani's feather and the Shadowsong signet from the bodies."] = "Aanders y los guardias caídos están justo al suroeste de la torre. Toma la pluma de Raani y el sello Cantosombrío de los cuerpos.",

	-- Step 27: Shen'dar Highlands: kill these as you meet them
	-- {area:17674} West Pylon Watchtower · {quest:92529} Falaath Village · {item:263493} Hippogryph Down
	["The hippogryph nests are north-west of the {area:17674}, west of {quest:92529}. The Matriarch sits at their western end; {item:263493} lies on the ground around the nests."] = "",

	-- Step 29: Fendaal Windstone
	-- {area:16638} Valanaar · {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["On the road south-east to {area:16638}, {npc:273017} watches the {quest:98512} just north of him."] = "",

	-- Step 30: Valanaar
	-- {npc:252476} Talaanis Shadowsong
	["{npc:252476}, upstairs"] = "",
	-- {npc:252383} Valennia Stormfist
	["{npc:252383}, upstairs"] = "",

	-- Step 31: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "De vuelta a {area:16638}",

	-- Step 32: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Skyhoppers",
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers hop about the fields just west of Valennia."] = "Varios {npc:251727} saltan por los campos justo al oeste de Valennia.",

	-- Step 33: Ayessa Dawnsinger
	-- {npc:260628} Valennia Stormfist
	["{npc:260628}, upstairs"] = "",
	-- {npc:251968} Ayessa Dawnsinger
	["talk to {npc:251968}"] = "habla con {npc:251968}",
	-- {npc:252382} Sessaria Skystride · {npc:251968} Ayessa Dawnsinger · {quest:97243} Call of Fire
	["{npc:252382}, beside {npc:251968}: {quest:97243}"] = "",

	-- Step 34: Nyalah Brightfire and Alvarion Windfield
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield
	["{npc:257006} and {npc:252448}"] = "",
	-- {npc:257006} Nyalah Brightfire · {area:16638} Valanaar · {npc:252448} Alvarion Windfield
	["{npc:257006} waits inside a house on {area:16638}'s western edge; {npc:252448} is close by."] = "",
	-- {npc:255940} Donaal Downbreeze
	["Innkeeper {npc:255940}, by the west gate"] = "",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "Escucha la historia de {npc:252448}",
	-- {npc:252389} Quel'ana Quickgale · {npc:257006} Nyalah Brightfire · {quest:94978} Taming the Beast
	["{npc:252389}, a few steps west of {npc:257006}: {quest:94978}, the first rod"] = "",
	-- {npc:257006} Nyalah Brightfire
	["{npc:257006}, inside"] = "",

	-- Step 35: Riaani Nightwind
	-- {npc:256083} Riaani Nightwind · {area:16626} Gustberry Lowlands
	["{npc:256083} stands in the {area:16626} just north-west of town."] = "{npc:256083} está en {area:16626}, justo al noroeste del pueblo.",
	-- {npc:256083} Riaani Nightwind
	["Listen to {npc:256083}"] = "Escucha a {npc:256083}",
	-- {npc:252377} Seena Skybreaker · {npc:256083} Riaani Nightwind · {quest:94003} The Skybreaker Bulwark
	["{npc:252377}, beside {npc:256083}: {quest:94003}"] = "",

	-- Step 36: Windfield Orchard
	-- {area:16663} Windfield Orchard · {area:16638} Valanaar
	["{area:16663} is west of {area:16638} along the coast road."] = "{area:16663} está al oeste de {area:16638}, por el camino de la costa.",

	-- Step 37: The orchard
	["The orchard"] = "El huerto",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Stormapples and flutterfly dust lie all over the orchard; Hungry Bandits raid it. Galestriders graze in the fields east of it. The broken construct floats at the orchard's north edge."] = "Hay tormanzanas y polvo de alabatiente por todo el huerto; varios {npc:252802} lo saquean. Los Zancavientos pastan en los campos al este. El ensamblaje roto flota en el borde norte del huerto.",
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple
	["Ripe Stormapples"] = "",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Hungry Bandits"] = "",
	-- {npc:268592} Olariaan Swiftburn
	["{npc:268592}, at the Shrine of Flames just south-east of the orchard"] = "",

	-- Step 39: Gustberry Lowlands: kill these as you meet them
	-- {area:16626} Gustberry Lowlands
	["{area:16626}: kill these as you meet them"] = "",
	-- {area:16663} Windfield Orchard
	-- plural, as words: Blood-Stained Bandit Masks = {item:253596} Blood-Stained Bandit Mask
	["The Highwayman Bandits hold the hills north of {area:16663}; they drop the Blood-Stained Bandit Masks."] = "",

	-- Step 40: Standing Our Ground
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "Dile a {npc:252800} que estás listo",

	-- Step 41: Shen'dar Highlands: kill these as you meet them
	-- {item:260881} Crystallized Lightning · {npc:256083} Riaani Nightwind
	["The {item:260881} lies in a cave in the hills north-west of {npc:256083}."] = "",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["tame one with {npc:252389}'s first {item:15908} while you are among them"] = "",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "",

	-- Step 42: Enchanted Gyrozephyr
	-- {area:16624} Shen'dar Village · {area:16625} Windsong Lake
	-- plural, as words: Enchanted Gyrozephyrs = {item:260883} Enchanted Gyrozephyr
	["The Enchanted Gyrozephyrs lie under water far to the north, east of {area:16624} and south-west of {area:16625}."] = "",
	["Underwater"] = "",

	-- Step 43: Alvarion Windfield and Riaani Nightwind
	-- {npc:252448} Alvarion Windfield · {npc:256083} Riaani Nightwind
	["{npc:252448} and {npc:256083}"] = "{npc:252448} y {npc:256083}",

	-- Step 44: Class trainer
	["Class trainer"] = "",

	-- Step 45: Warlock trainer
	["Warlock trainer"] = "",
	-- {npc:2127} Rupert Boch · {zone:1420} Tirisfal Glades · {area:16638} Valanaar
	["{npc:2127} in {zone:1420}; {area:16638} has no warlock trainer"] = "",

	-- Step 47: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod · {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider · Vuldren Alphas = {npc:250874} Vuldren Alpha
	["{npc:252389} takes back the first {item:15908} and hands you two more, one at a time: Ornery Galestriders and Vuldren Alphas roam the fields just north of her. Tame each with its rod and bring the rod back to her. {npc:254411}, beside her, teaches {spell:5149}."] = "",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "",

	-- Step 48: Ayessa Dawnsinger
	-- {npc:256247} Belathaan Brightwish · {area:16638} Valanaar · {area:16629} Shrine of Akir
	["{npc:256247} waits on the road north of {area:16638}, towards the {area:16629}."] = "{npc:256247} espera en el camino al norte de {area:16638}, hacia {area:16629}.",

	-- Step 49: Valennia Stormfist
	["Upstairs"] = "",

	-- Step 50: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar · {npc:255853} Urs'endris · {area:17675} East Pylon Watchtower · {spell:1259416} Walk on Air
	["{npc:252359} stands on {area:16638}'s east side. {npc:255853} waits by the falls just north of the {area:17675}: leave town to the north, climb the ridge east of the road and glide down to him with {spell:1259416}."] = "",

	-- Step 51: The East Pylon Watchtower
	-- {area:17675} East Pylon Watchtower
	["The {area:17675}"] = "{area:17675}",
	-- {area:17675} East Pylon Watchtower · {npc:252666} Commander Belguilos
	["Head north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "",
	-- {npc:268602} Skypriest Faladiel
	["{npc:268602}, on the hill west of the falls just north of the watchtower"] = "",

	-- Step 53: The turncoat
	["The turncoat"] = "El traidor",
	-- {area:16626} Gustberry Lowlands · {area:16638} Valanaar · {npc:273017} Fendaal Windstone
	["The turncoat's house is in the {area:16626} north-west of {area:16638}, just north of {npc:273017}."] = "",
	["search the dead cultist in the house"] = "registra al cultista muerto de la casa",
	-- {npc:253372} Dead Cultist
	["{npc:253372}, inside"] = "",

	-- Step 54: Ur'endra
	-- {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands · {area:16626} Gustberry Lowlands
	["{npc:258443} has her lair in a cave in the bluffs just south of the turncoat's house, where the {area:16623} meet the {area:16626}."] = "",

	-- Step 56: Olariaan Swiftburn
	-- {item:277267} Faladiel's Heart · {npc:268592} Olariaan Swiftburn · {area:16638} Valanaar · {area:16623} Shen'dar Highlands · {npc:268605} Kuramaa
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Take {item:277267} to {npc:268592} at the Shrine of Flames, south-west of {area:16638}, then head west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "",

	-- Step 57: Zephras Isle
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",

	-- Step 58: The Eternal Flame
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Wait for him to light the {npc:268762}, then carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638} before the timer runs out."] = "Vuelve con {npc:268592}. Espera a que encienda {npc:268762} y luego lleva la llama directo a {npc:268679}, junto a {npc:252382} en {area:16638}, antes de que se acabe el tiempo.",
	-- {npc:252382} Sessaria Skystride · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:252382}: {npc:2523}, tu {item:5176} y el {item:263412}",

	-- Step 59: Unfortunate News
	-- {npc:252476} Talaanis Shadowsong
	["talk to {npc:252476}"] = "habla con {npc:252476}",

	-- Step 62: Desperate Times
	-- {npc:253844} Valennia Stormfist
	["talk to {npc:253844}"] = "habla con {npc:253844}",

	-- Step 63: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["{npc:257196} holds the {item:263993} on the west side of the shrine."] = "{npc:257196} tiene el {item:263993} en el lado oeste del santuario.",

	-- Step 64: Strength and Mercy
	-- {npc:255853} Urs'endris · {area:17675} East Pylon Watchtower · {spell:1259416} Walk on Air
	["On your way north from Valennia, {npc:255853} waits by the falls north-east of you, just north of the {area:17675}: from the ridge above them, glide down with {spell:1259416}."] = "",

	-- Step 65: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}; {npc:257944} camps at its southern edge."] = "Ve al norte hacia {area:16631}; {npc:257944} acampa en su borde sur.",

	-- Step 66: Shadowgale Forest: kill these as you meet them
	-- {area:16631} Shadowgale Forest
	["{area:16631}: kill these as you meet them"] = "",
	-- {item:265105} Lady's Tear Moss · {npc:257944} Elegael Thornpaw · {item:265141} Bloody Heirloom
	["{item:265105} grows around {npc:257944}'s camp and Shriekings fly over it. The Al'Aketh camp east of her holds the {item:265141}."] = "{item:265105} crece alrededor del campamento de {npc:257944}, y criaturas chillonas vuelan sobre él. El campamento Al'Aketh al este de ella guarda la {item:265141}.",

	-- Step 67: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "{npc:257944} otra vez",

	-- Step 68: The Al'Aketh camp
	["The Al'Aketh camp"] = "El campamento Al'Aketh",
	-- {npc:253622} Commander Haalien · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:254151} Vayn Moongaze · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:253622}, {npc:258130} and {npc:258134} are in the cult camp east of {npc:257944}. {npc:254151} stands at its edge. Haalien also drops a {quest:94490}: read it to start the next quest. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:253622}, {npc:258130} y {npc:258134} están en el campamento del culto al este de {npc:257944}. {npc:254151} está en su borde. Haalien también suelta una {quest:94490}: léela para empezar la siguiente misión. Para {quest:94489}, entra en la guarida (Nightfang Den), cura a 7 druidas heridos y encuentra a {npc:258130}.",
	["Heal the injured druids in the Nightfang Den"] = "Cura a los druidas heridos de la guarida (Nightfang Den)",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "Encuentra a {npc:258130}",

	-- Step 69: Elegael Thornpaw, last time
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, last time"] = "{npc:257944}, por última vez",

	-- Step 70: The Strange Hermit
	-- {area:16625} Windsong Lake
	["The hermit lives at {area:16625}'s west shore."] = "",
	-- {npc:251684} Strange Hermit
	["talk to {npc:251684}"] = "habla con {npc:251684}",

	-- Step 71: Windsong Lake
	-- {item:257128} Zephyrseed · {npc:254344} Endaria Mistgaze · {quest:93736} Unwelcome Spirits · {area:16625} Windsong Lake · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow · Wind Hollow Essences = {item:262357} Wind Hollow Essence
	["{item:257128} cones grow south of the hermit; the Wind Hollows drift east of the lake and also drop the Wind Hollow Essences for {npc:254344}'s {quest:93736}. The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "",

	-- Step 73: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:253576} Hyusaa Quickbreeze
	["The {area:16629} is north of {area:16638}. Fight through the guards up to {npc:253576} at its east side."] = "{area:16629} está al norte de {area:16638}. Ábrete paso entre los guardias hasta {npc:253576}, en su lado este.",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, upstairs"] = "",

	-- Step 74: Portal to Rohashi Spires
	-- {area:16630} Rohashi Spires
	["Portal to {area:16630}"] = "",

	-- Step 75: Confront Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {object:617084} Portal to Valanaar (no name in this language: may be words)
	["Take the Portal to {area:16630} in the shrine up to the heights. Fight east along the ledge to the Peacekeepers at its end, ride the wind current up to the upper terrace and tell {npc:252475} you are ready. Leave the {object:617084} up there alone until Rohash has withdrawn; then it takes you straight back to town."] = "",

	-- Step 76: The Fate of Zephras
	-- {npc:254344} Endaria Mistgaze · {npc:251968} Ayessa Dawnsinger
	["{npc:254344}, beside {npc:251968}"] = "",

	-- Step 77: Seena Skybreaker
	-- {npc:252377} Seena Skybreaker · {npc:256083} Riaani Nightwind · {area:16638} Valanaar
	["{npc:252377} stands beside {npc:256083}, just north-west of {area:16638}."] = "",

	-- Step 78: Valanaar
	-- {npc:251968} Ayessa Dawnsinger · {area:16638} Valanaar · {zone:1412} Mulgore · {npc:259119} Alaana Stormwalker
	["{npc:251968} sends you on to Kalimdor. Once you have trained, board the skycutter at the dock on {area:16638}'s south-west edge: it flies to northern {zone:1412}, where {npc:259119} waits."] = "",

	-- Step 81: Leave Zephras Isle to Mulgore
	-- {zone:2521} Zephras Isle · {zone:1412} Mulgore
	["Leave {zone:2521} to {zone:1412}"] = "",

	-- Step 82: Northern Mulgore
	-- {zone:1412} Mulgore
	["Northern {zone:1412}"] = "Norte de {zone:1412}",
	-- {npc:259119} Alaana Stormwalker
	["You leave the isle for good. {npc:259119} waits where the airship lands."] = "Dejas la isla para siempre. {npc:259119} espera donde aterriza la aeronave.",
	-- {npc:259119} Alaana Stormwalker · {zone:1454} Orgrimmar
	["{npc:259119}: keep it: Thrall in {zone:1454}, at the start of the next guide"] = "",
	-- {npc:259118} Muln Earthfury · {npc:3033} Turak Runetotem · {zone:1456} Thunder Bluff
	["{npc:259118}, by the landing: for {npc:3033} in {zone:1456}"] = "{npc:259118}, junto al aterrizaje: para {npc:3033} en {zone:1456}",

	-- Step 83: Clarice Foster
	-- {npc:5543} Clarice Foster · {area:2197} Pools of Vision · {area:1640} Spirit Rise
	["{npc:5543} stands in the {area:2197}, the cave under {area:1640}: go down inside, the arrow cannot tell the floors apart."] = "",

	-- Step 85: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068} quiere incienso tauren: compra sus cuatro partes a {npc:3014}, la herborista; a {npc:3012}, proveedora de encantamiento; a {npc:3005}, proveedor de peletería, y a {npc:3027}, proveedor de cocina; luego combínalas en {item:278078}.",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}, de {npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}, de {npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}, de {npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}, de {npc:3027}",

	-- Step 86: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 21 (forever/horde/02-the-barrens)."] = "",

	-- Step 87: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Usa el {item:278078} en la estera ceremonial y el quemador del acantilado sur de {area:1641}.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Esparce el {item:278078} desde {area:1641}",

	-- Step 89: Ansekhwa
	-- {spell:199} Two-Handed Maces · {npc:11869} Ansekhwa
	["While you're here: learn {spell:199} from {npc:11869} (10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 90: Ansekhwa
	-- {npc:11869} Ansekhwa
	["While you're here: learn Staves from {npc:11869} (10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 91: Into Mulgore
	-- {zone:1412} Mulgore
	["Into {zone:1412}"] = "",

	-- Step 92: Into The Barrens
	-- {zone:1413} The Barrens
	["Into {zone:1413}"] = "",

	-- Step 94: The Crossroads
	-- {npc:3615} Devrak · {area:380} The Crossroads · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Learn the flight path from {npc:3615} on the tower platform. {area:380}' own quests come after {zone:1421}, in the {zone:1413} guide."] = "",

	-- Step 95: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "A {zone:1454}",
	-- {area:379} Far Watch Post · {area:815} Southfury River · {zone:1411} Durotar · {zone:1454} Orgrimmar · {quest:95350} Welcome to Azeroth · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	["From the Crossroads follow the road north-east to {area:379}, cross the {area:815} into {zone:1411} and keep north to {zone:1454}'s main gate. The next guide starts in {zone:1454}: Thrall takes {quest:95350}, and the zeppelin leaves for {zone:1420} and {zone:1421}."] = "",
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:16624} with what you found."] = "Vuelve a {area:16624} con lo que encontraste.",
	-- ["Back to {npc:268592}, then west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "Vuelve con {npc:268592} y luego ve al oeste hacia {area:16623}: la casa de {npc:268605} está en las colinas al sur de los lagos de {npc:254588}.",
	-- ["Bandit Highwaymen"] = "Bandit Highwaymen",
	-- ["Climb the watchtower in the village, jump off the top and use {spell:1259416} to float down."] = "Sube a la atalaya de la aldea, salta desde lo alto y usa {spell:1259416} para descender flotando.",
	-- ["Faladiel stands on the hill west of the falls, north of {area:16638}."] = "Faladiel está en la colina al oeste de la cascada, al norte de {area:16638}.",
	-- ["Follow the road south to {area:16624}, in the middle of the isle."] = "Sigue el camino al sur hasta {area:16624}, en el centro de la isla.",
	-- ["High Order Apprentices"] = "{npc:257521} ×varios",
	-- ["Hippogryph nests"] = "Nidos de hipogrifo",
	-- ["Horde airship"] = "Aeronave de la Horda",
	-- ["Kuramaa"] = "Kuramaa",
	-- ["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "Sal de {zone:1456} por un elevador y sigue el camino al sur pasando {area:222} y por el paso del este hasta {zone:1413}; desde el paso, toma {area:458} al norte hasta {area:380}, el pueblo de la Horda en el centro de {zone:1413}.",
	-- ["Leaving {area:16635}"] = "Salida de {area:16635}",
	-- ["On the way north, back to {npc:255853} by the falls."] = "De camino al norte, vuelve con {npc:255853} junto a la cascada.",
	-- ["Prideclaws and Galestriders"] = "Leozarpas y zancavientos",
	-- ["Prideclaws and Galestriders share the meadows south of the village. Keep the {item:5469} for {npc:251905}; the eggs come later from the hippogryphs."] = "Leozarpas y Zancavientos comparten las praderas al sur de la aldea. Guarda la {item:5469} para {npc:251905}; los huevos vienen después, de los hipogrifos.",
	-- ["Ride north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "Cabalga al noreste hasta {area:17675}. El campamento Al'Aketh está justo al oeste, con {npc:252666} en su extremo norte. Cualquier cultista puede soltar un talismán de piedra de viento.",
	-- ["Rorian: {quest:92485}"] = "Rorian: {quest:92485}",
	-- ["Sit by {npc:263664}'s campfire (type /sit) until you get the {spell:1229451} buff, then find {npc:251905} at the cook fire."] = "Siéntate junto a la fogata de {npc:263664} (escribe /sit) hasta obtener el beneficio {spell:1229451}; luego busca a {npc:251905} junto al fuego de cocina.",
	-- ["Take the Torch of Dormant Flame to {npc:268592} at the Shrine of Flames, south-west of {area:16638} in the {area:16626}."] = "Lleva la antorcha a {npc:268592}, en el santuario de las llamas, al suroeste de {area:16638}, en {area:16626}.",
	-- ["Take the portal up to the {area:16630} and join {npc:252475} and {npc:251968} against the High Priestess."] = "Toma el portal para subir a {area:16630} y únete a {npc:252475} y {npc:251968} contra la suma sacerdotisa.",
	-- ["Take the road south-east to {area:16638}, the Skyborne town on the south coast. {npc:257006} and {npc:252448} stand at its western edge."] = "Toma el camino al sureste hasta {area:16638}, el pueblo Cielonato de la costa sur. {npc:257006} y {npc:252448} están en su borde oeste.",
	-- ["Talk to {npc:251902}"] = "Habla con {npc:251902}",
	-- ["Talk to {npc:251968}"] = "Habla con {npc:251968}",
	-- ["Talk to {npc:252383}"] = "Habla con {npc:252383}",
	-- ["Talk to {npc:252800}"] = "Habla con {npc:252800}",
	-- ["Talk to {npc:253576}"] = "Habla con {npc:253576}",
	-- ["Talk to {npc:254089}"] = "Habla con {npc:254089}",
	-- ["The Al'Aketh cultists in the camp beyond {npc:252095} carry the signet."] = "Los cultistas Al'Aketh del campamento más allá de {npc:252095} llevan el sello.",
	-- ["The Horde airship docks at the south-west edge of {area:16638}. Ride it to Kalimdor; it lands in northern {zone:1412}."] = "La aeronave de la Horda atraca en el borde suroeste de {area:16638}. Tómala a Kalimdor; aterriza en el norte de {zone:1412}.",
	-- ["The Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "La guarida ursera está al oeste de la aldea. {npc:251115}, su matriarca, está al fondo.",
	-- ["The airship"] = "La aeronave",
	-- ["The apprentices practise north-east of the village."] = "Los aprendices practican al noreste de la aldea.",
	-- ["The bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "Los campamentos de bandidos están al noreste de la aldea; Bennic \"Badwind\" ocupa el campamento de arriba. Los bandidos llevan las piedras de viento robadas.",
	-- ["The crawlers scuttle along the shore south-west of town."] = "Los reptadores corretean por la orilla al suroeste del pueblo.",
	-- ["The hermit lives at {area:16625}'s west shore. {item:257128} cones grow south of him; the Wind Hollows drift east of the lake."] = "El ermitaño vive en la orilla oeste de {area:16625}. Las piñas de {item:257128} crecen al sur de él; varios {npc:251676} flotan al este del lago.",
	-- ["The highland bandits"] = "Los bandidos de las tierras altas",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616466} lie near the road to {area:16638}."] = "Los salteadores ocupan las colinas al noreste del huerto. Hay más {object:616466} cerca del camino a {area:16638}.",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616468} lie near the road to {area:16638}."] = "Los salteadores ocupan las colinas al noreste del huerto. Hay más {object:616468} cerca del camino a {area:16638}.",
	-- ["The hippogryph nests are north-west of the tower, west of {quest:92529}; the Matriarch sits at the western end. {item:263493} lies on the ground around them, and the hippogryphs drop the Small Eggs."] = "Los nidos de hipogrifo están al noroeste de la torre, al oeste de {quest:92529}; la matriarca está en el extremo oeste. {item:263493} está en el suelo a su alrededor, y los hipogrifos sueltan los Huevos pequeños ({item:6889}).",
	-- ["The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "Las pertenencias de los refugiados están a lo largo de la orilla norte de {area:16625}; {npc:259013} está en su extremo noroeste.",
	-- ["The turncoat's house is in the {area:16626} north-west of {area:16638}. {npc:273017} waits nearby; his assassins lurk around the house."] = "La casa del traidor está en {area:16626}, al noroeste de {area:16638}. {npc:273017} espera cerca; sus asesinos acechan alrededor de la casa.",
	-- ["The watchtower"] = "La atalaya",
	-- ["Walk north to {area:16624}; finish the {item:5469} on the Galestriders along the way if you are short."] = "Camina al norte hasta {area:16624}; si te falta {item:5469}, termina con los Zancavientos por el camino.",
	-- ["Wind Hollows and {object:616466}"] = "{npc:251676} ×varios y {object:616466}",
	-- ["Wind Hollows and {object:616467}"] = "{npc:251676} y {object:616467}",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616466} lie west of the orchard road."] = "Varios {npc:251676} flotan sobre los bajíos alrededor de {area:16638}. Las primeras {object:616466} están al oeste del camino del huerto.",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616467} lie west of the orchard road."] = "Varios {npc:251676} flotan sobre los bajíos alrededor de {area:16638}. Las primeras {object:616467} están al oeste del camino del huerto.",
	-- ["Windsong Crawlers"] = "{npc:254588} ×varios",
	-- ["talk to {npc:251905}"] = "habla con {npc:251905}",
	-- ["{area:1638} is beside the landing: ride up a lift and learn the flight path from {npc:2995}, the wind rider master."] = "{area:1638} está junto al aterrizaje: sube en un elevador y aprende la ruta de vuelo con {npc:2995}, el maestro de jinetes del viento.",
	-- ["{area:16624}, last time"] = "{area:16624}, por última vez",
	-- ["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}."] = "{npc:250926} merodean por las laderas al suroeste de la aldea, de camino a {npc:252095}.",
	-- ["{npc:251374} sends you to the {area:16988}, just east of the village: drink the {item:6635} there to see the {npc:251166}, then take the {item:6656} back to him."] = "{npc:251374} te envía a {area:16988}, justo al este de la aldea: bebe allí la {item:6635} para ver a {npc:251166} y luego llévale el {item:6656}.",
	-- ["{npc:251374} stands in the village."] = "{npc:251374} está en la aldea.",
	-- ["{npc:251374}, at the village centre"] = "{npc:251374}, en el centro de la aldea",
	-- ["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it."] = "{npc:252095} espera en {area:16622}, al suroeste de la aldea. El campamento Al'Aketh está justo más allá; {npc:256935} lo dirige.",
	-- ["{npc:252359} stands on {area:16638}'s east side."] = "{npc:252359} está en el lado este de {area:16638}.",
	-- ["{npc:252377} stands in the middle of {area:16638}."] = "{npc:252377} está en el centro de {area:16638}.",
	-- ["{npc:252382} stands on {area:16638}'s west side."] = "{npc:252382} está en el lado oeste de {area:16638}.",
	-- ["{npc:252389} in {area:16638} hands you a {item:15908} three times: tame a {npc:254588} by the lakes north-west of town, an {npc:251707} in the fields west of town and a {npc:250874} at {area:16663}, returning to her after each. {npc:254411} stands beside her."] = "{npc:252389}, en {area:16638}, te da una {item:15908} tres veces: domestica un {npc:254588} junto a los lagos al noroeste del pueblo, un {npc:251707} en los campos al oeste del pueblo y un {npc:250874} en {area:16663}, y vuelve con ella después de cada uno. {npc:254411} está a su lado.",
	-- ["{npc:255853} waits by the falls just north of the watchtower."] = "{npc:255853} espera junto a la cascada justo al norte de la atalaya.",
	-- ["{npc:258443} roams the slopes just south of the turncoat's house."] = "{npc:258443} recorre las laderas justo al sur de la casa del traidor.",
	-- ["{npc:259119}: keep it, Thrall in {zone:1454} comes two guides later"] = "{npc:259119}: guárdala; Thrall, en {zone:1454}, llega dos guías después",
	-- ["{npc:263664}'s campfire"] = "La fogata de {npc:263664}",
	-- ["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 23 (forever/horde/04-the-barrens)."] = "{npc:3033} entrena druidas en {area:1639}. Te enseña {spell:18960}; la bienvenida de {npc:11802} espera tu viaje de {spell:499} hacia el nivel 23 (forever/horde/04-the-barrens).",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, el maestro de jinetes del viento",
}
