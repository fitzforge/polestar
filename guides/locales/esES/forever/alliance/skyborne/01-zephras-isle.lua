-- Spanish (Spain) (esES): the guide forever/alliance/skyborne/01-zephras-isle (forever/alliance/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Grove
	-- {area:16622} Thendal Grove · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker · {npc:251368} Elatrell Featherlight
	["You wake in {area:16622}. {npc:251362} stands beside you; {npc:251361} is a few steps west, {npc:251368} by the south edge of the grove."] = "Te despiertas en {area:16622}. {npc:251362} está a tu lado; {npc:251361} está a unos pasos al oeste, y {npc:251368}, junto al borde sur de la arboleda.",

	-- Step 2: Vuldren and Cirrusflies
	["Vuldren and Cirrusflies"] = "Vuldren y moscas de cirro",
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} and Pesky Cirrusflies roam the meadow just south-east of the grove."] = "{npc:250873} y moscas de cirro molestas rondan el prado justo al sureste de la arboleda.",

	-- Step 3: Back to Thendal Grove
	-- {area:16622} Thendal Grove
	["Back to {area:16622}"] = "Vuelve a {area:16622}",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}: la {item:4100}",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, en la atalaya",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}: una nota de tu instructor",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}: lee la {item:9547}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}, en la atalaya",
	-- {npc:251379} Dorii Brightwhisper · {item:282416} Glowing Recall Crystal
	["{npc:251379}, the mage trainer: read the {item:282416} first"] = "{npc:251379}, la instructora de magos: lee primero el {item:282416}",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}, el instructor de druidas, en la planta baja del árbol detrás de {npc:251361}",
	["The class trainers stand together in the grove"] = "Los instructores de clase están juntos en la arboleda",
	-- {npc:257554} Halaan Hawk-Eye
	["Listen to {npc:257554}"] = "Escucha a {npc:257554}",
	-- {spell:1259416} Walk on Air
	["Use {spell:1259416}"] = "Usa {spell:1259416}",

	-- Step 4: Raw Windstones and the Cirrusfly Queen
	-- {npc:251404} Cirrusfly Queen
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones and the {npc:251404}"] = "Piedras de viento en bruto y la {npc:251404}",
	-- {quest:92463} The Cirrusfly Queen · {npc:249363} Yala Windwatcher
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones glitter on the ground just south of the grove. {quest:92463} hovers over the meadow further east, on the way to {npc:249363}."] = "Las piedras de viento en bruto brillan en el suelo justo al sur de la arboleda. {quest:92463} revolotea sobre el prado más al este, de camino a {npc:249363}.",

	-- Step 5: Yala Windwatcher
	-- {npc:249363} Yala Windwatcher · {npc:251143} Roiling Winds · {object:460002} Ley Line (no name in this language: may be words) · {spell:1259705} Read Leyline
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your {spell:1259705} racial ability at it."] = "{npc:249363} vigila al este de la arboleda. Los {npc:251143} y los convertidos Al'Aketh ({npc:251160}) se reúnen justo al norte de ella; la línea ley se alza más al norte: lanza sobre ella tu habilidad racial {spell:1259705}.",
	-- {spell:1259705} Read Leyline · {object:460002} Ley Line (no name in this language: may be words)
	["Cast {spell:1259705} at the {object:460002}"] = "Lanza {spell:1259705} sobre la línea ley",

	-- Step 6: Thendal Grove turn-ins
	-- {area:16622} Thendal Grove
	["{area:16622} turn-ins"] = "Entregas en {area:16622}",
	["Level 4 spells"] = "Hechizos de nivel 4",

	-- Step 7: Scrawny Ursera and Urs'anah
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	["{npc:250926} and {npc:251115}"] = "{npc:250926} y {npc:251115}",
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	-- plural, as words: Ursera Scavengers = {npc:250937} Ursera Scavenger
	["{npc:250926} prowl the woods just west of the grove; the Ursera Scavengers den further west, with {npc:251115}, the matriarch, at the back of the den."] = "{npc:250926} merodean por el bosque justo al oeste de la arboleda; los ursera carroñeros tienen su guarida más al oeste, con {npc:251115}, la matriarca, al fondo.",

	-- Step 8: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {npc:256935} Malduko Cloudcrush
	["{npc:252095} camps south of the Ursera den. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle."] = "{npc:252095} acampa al sur de la guarida de los ursera. Los matones Al'Aketh ocupan el campamento al suroeste de ella; {npc:256935} está en el centro.",

	-- Step 9: Aetheen of the Gales
	["Level 6 spells"] = "Hechizos de nivel 6",

	-- Step 10: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:263664} Raan Wildwind · {npc:251523} Constable Aonda · {npc:251903} Rathiril Sunlance
	["Follow the road south to {area:16624}. {npc:263664} camps by the fire west of the village; {npc:251523} and {npc:251903} stand in its middle."] = "Sigue el camino al sur hasta {area:16624}. {npc:263664} acampa junto al fuego al oeste del pueblo; {npc:251523} y {npc:251903} están en el centro.",
	-- {npc:251903} Rathiril Sunlance · {npc:254089} Coriella Calmbreeze
	["Speak with {npc:251903} and {npc:254089}, north-west of the village"] = "Habla con {npc:251903} y {npc:254089}, al noroeste del pueblo",

	-- Step 11: Raan Wildwind
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "Usa /sentarse junto a la hoguera de {npc:263664} hasta obtener {spell:1229451}",

	-- Step 12: Village quests
	["Village quests"] = "Misiones del pueblo",
	["The bounty board"] = "El tablón de recompensas",

	-- Step 13: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "Garramanadas y zancavendavales",
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders roam the grasslands south of the village. Galestriders drop both the eggs and the meat."] = "Las garramanadas y los zancavendavales rondan los pastizales al sur del pueblo. Los zancavendavales sueltan tanto los huevos como la carne.",

	-- Step 14: Back to Shen'dar
	["Back to Shen'dar"] = "Vuelve a Shen'dar",

	-- Step 15: The Highlands bandits
	["The Highlands bandits"] = "Los bandidos de las Tierras Altas",
	-- plural, as words: Highlands Bandits = {npc:251918} Highlands Bandit
	["The Highlands Bandits camp north-east of the village. \"Badwind\" Bennic waits at the far north end of their camp."] = "Los bandidos de las Tierras Altas acampan al noreste del pueblo. \"Malabrisa\" Bennic espera en el extremo norte de su campamento.",

	-- Step 16: Shen'dar turn-ins
	["Shen'dar turn-ins"] = "Entregas en Shen'dar",

	-- Step 17: Falaath Village
	-- {npc:257065} Missionary Jasaan · {quest:92529} Falaath Village · {spell:1254832} Mark of Akir
	["{npc:257065} waits at the entrance to {quest:92529}, south of Shen'dar. The {spell:1254832} lets you walk in among the faithful."] = "{npc:257065} espera en la entrada de {quest:92529}, al sur de Shen'dar. La {spell:1254832} te permite entrar entre los fieles.",
	["Search the wardrobe"] = "Registra el armario",

	-- Step 19: Havoc in Falaath
	["Havoc in Falaath"] = "Caos en Falaath",
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	["Back in {quest:92529}: Stormcallers and {npc:251662} fill the village, the Stormcallers carry the stolen supplies, and {npc:251966} stands at its south end."] = "De vuelta en {quest:92529}: los clamatormentas y {npc:251662} llenan el pueblo, los clamatormentas llevan los suministros robados y {npc:251966} está en el extremo sur.",

	-- Step 20: The Western Watch
	-- {npc:252155} Peacekeeper Vaaniel · {npc:256966} Skypriest Aanders
	["{npc:252155} holds the western watch, south-west of Falaath. {npc:256966} and the fallen guards lie just south of her."] = "{npc:252155} defiende la torre occidental, al suroeste de Falaath. {npc:256966} y los guardias caídos yacen justo al sur de ella.",
	-- {item:254871} Bloody Note
	["The {item:254871}"] = "La {item:254871}",

	-- Step 21: The hippogryph roost
	["The hippogryph roost"] = "El nidal de hipogrifos",
	-- {item:263493} Hippogryph Down
	["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them."] = "Ve al noroeste hasta los nidos de hipogrifo de los acantilados occidentales. El {item:263493} está alrededor de los nidos; la matriarca patrulla entre ellos.",

	-- Step 22: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	["{npc:254589} lurks in the hills south-west of the village, on the way back. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} acecha en las colinas al suroeste del pueblo, de camino de vuelta. {npc:254589} es élite: conviene ir en grupo.",

	-- Step 23: Windshaper Novice Seers
	-- plural, as words: Windshaper Novice Seers = {npc:257532} Windshaper Novice Seer
	["Windshaper Novice Seers"] = "Videntes novatos Formavientos",
	["The Novice Seers practise in the clearing west of Shen'dar."] = "Los videntes novatos practican en el claro al oeste de Shen'dar.",

	-- Step 24: Shen'dar Village again
	-- {area:16624} Shen'dar Village
	["{area:16624} again"] = "De nuevo {area:16624}",

	-- Step 25: The road to Valanaar
	-- {area:16638} Valanaar
	["The road to {area:16638}"] = "El camino a {area:16638}",
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield · {area:16638} Valanaar
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Take the road south-east. {npc:257006} and {npc:252448} stand by the road west of {area:16638}; Windsong Crawlers line the shore further west, around 51,70."] = "Toma el camino al sureste. {npc:257006} y {npc:252448} están junto al camino al oeste de {area:16638}; los reptadores Canzalvaje pueblan la orilla más al oeste, hacia 51,70.",

	-- Step 26: Valanaar
	-- {npc:252383} Valennia Stormfist · {npc:252476} Talaanis Shadowsong · {area:16638} Valanaar · {npc:252475} Elaadrin Evengale · {npc:253204} Dondallion Whisperwind
	["{npc:252383} and {npc:252476} stand at the north end of {area:16638}, {npc:252475} and {npc:253204} at the south end."] = "{npc:252383} y {npc:252476} están en el extremo norte de {area:16638}; {npc:252475} y {npc:253204}, en el extremo sur.",

	-- Step 27: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Saltanubes",
	-- {area:16638} Valanaar
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers swarm the fields west of {area:16638}."] = "Los saltanubes pululan por los campos al oeste de {area:16638}.",

	-- Step 28: The missing scholar
	["The missing scholar"] = "El erudito desaparecido",
	-- {object:581822} Bloodstained Satchel · {area:16638} Valanaar
	-- plural, as words: Shriekling Matriarchs = {npc:253283} Shriekling Matriarch
	["The {object:581822} lies by the path west of {area:16638}; Fillion's camp is north-west of it, and the Shriekling Matriarchs nest just west of the camp."] = "La {object:581822} está junto al sendero al oeste de {area:16638}; el campamento de Fillion está al noroeste, y las matriarcas chilladoras anidan justo al oeste del campamento.",
	-- {object:581822} Bloodstained Satchel
	["The {object:581822}"] = "La {object:581822}",
	["Find Fillion and his bedroll"] = "Encuentra a Fillion y su petate",

	-- Step 29: Aamelia Windfield
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} runs the farm in the south-west lowlands."] = "{npc:252800} lleva la granja de las tierras bajas del suroeste.",

	-- Step 30: The Windfield farm
	["The Windfield farm"] = "La granja de los Campovento",
	-- {quest:92683} Flutterfly Dust · {npc:250929} Malfunctioning Cyclone Construct
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple · Hungry Bandits = {npc:252802} Hungry Bandit · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Ripe Stormapples and Hungry Bandits are in the orchard by the farm, {quest:92683} in the fields north-east of it, Ornery Galestriders all around. The {npc:250929} stands in the field north-east of the farm."] = "Las manzanas tempestuosas maduras y los bandidos hambrientos están en el huerto junto a la granja, {quest:92683} en los campos al noreste, y los zancavendavales malhumorados por todas partes. El {npc:250929} está en el campo al noreste de la granja.",

	-- Step 31: Aamelia Windfield again
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} again"] = "De nuevo {npc:252800}",

	-- Step 32: Bandit Highwaymen
	["Bandit Highwaymen"] = "Bandidos salteadores",
	["The Bandit Highwaymen hold the hills north of the farm."] = "Los bandidos salteadores ocupan las colinas al norte de la granja.",

	-- Step 33: Standing our ground
	["Standing our ground"] = "Nos mantenemos firmes",
	-- {npc:252800} Aamelia Windfield · {npc:252863} Ferauu the Bludgeon
	["Stand with {npc:252800} against {npc:252863}"] = "Lucha junto a {npc:252800} contra {npc:252863}",

	-- Step 34: Valanaar turn-ins
	-- {area:16638} Valanaar
	["{area:16638} turn-ins"] = "Entregas en {area:16638}",
	-- {npc:252377} Seena Skybreaker · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["{npc:252377}: {npc:257196} waits at the {area:16629}"] = "{npc:252377}: {npc:257196} espera en {area:16629}",
	-- {npc:252373} Anathamaas Aetherwind
	["{npc:252373}, the mage trainer"] = "{npc:252373}, el instructor de magos",

	-- Step 35: Taming the Beast
	-- {item:15908} Taming Rod · {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {npc:254411} Quel'dora Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler · Vuldren Alphas = {npc:250874} Vuldren Alpha · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Each of Quel'ana's quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her in {area:16638}. Windsong Crawlers line the shore west of town; Vuldren Alphas and Ornery Galestriders roam the {area:16626} around the Windfield farm. Her sister {npc:254411} stands beside her."] = "Cada misión de Quel'ana te da una {item:15908}: úsala en la bestia que indica y devuélvele la vara en {area:16638}. Los reptadores Canzalvaje pueblan la orilla al oeste del pueblo; los vuldren alfa y los zancavendavales malhumorados rondan {area:16626} alrededor de la granja de los Campovento. Su hermana {npc:254411} está a su lado.",
	-- {npc:254588} Windsong Crawler · {item:15908} Taming Rod
	["{npc:254588}: tame it with the {item:15908}"] = "{npc:254588}: domestícalo con la {item:15908}",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Domestícalo con la {item:15908}",

	-- Step 36: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "Las formaciones de piedras de viento",
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations stand on the rise west of Fillion's camp."] = "Las formaciones de piedras de viento están en la loma al oeste del campamento de Fillion.",
	-- {item:262668} Wind-Infused Bough · {quest:92529} Falaath Village
	["{item:262668}: by the wind shrine south of {quest:92529}"] = "{item:262668}: junto al santuario del viento al sur de {quest:92529}",

	-- Step 38: The eastern watchtower
	["The eastern watchtower"] = "La atalaya oriental",
	-- {npc:252378} Yorana Windyreed · {area:16638} Valanaar · {npc:252666} Commander Belguilos
	["{npc:252378} holds the watchtower north of {area:16638}. The Al'Aketh camp is just west of the tower, its healers around 65,68 and 65,65; {npc:252666} stands at its north end. The Al'Aketh there drop Windstone Charms."] = "{npc:252378} defiende la atalaya al norte de {area:16638}. El campamento Al'Aketh está justo al oeste de la torre, con sus sanadores hacia 65,68 y 65,65; {npc:252666} está en su extremo norte. Los Al'Aketh de allí sueltan Windstone Charms.",

	-- Step 39: Valanaar, the turncoat
	-- {area:16638} Valanaar
	["{area:16638}, the turncoat"] = "{area:16638}, el traidor",

	-- Step 40: Urs'endris
	-- {npc:255853} Urs'endris · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands
	["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623} west of {area:16638}, by the road you take next."] = "{npc:255853} espera junto a las cascadas al noreste de {area:16638}. {npc:258443} merodea por {area:16623} al oeste de {area:16638}, junto al camino que tomarás después.",

	-- Step 41: The dead cultist
	["The dead cultist"] = "El cultor muerto",
	-- {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["North-west of Valanaar along the road: {npc:273017} watches the {quest:98512}; the dead cultist lies just north of him."] = "Al noroeste de Valanaar, siguiendo el camino: {npc:273017} vigila a los {quest:98512}; el cultor muerto yace justo al norte de él.",
	["Search the dead cultist"] = "Registra al cultor muerto",
	-- {npc:258443} Ur'endra
	["{npc:258443}, in the highlands south-west of the cultist"] = "{npc:258443}, en las tierras altas al suroeste del cultor",

	-- Step 42: Desperate times
	["Desperate times"] = "Tiempos desesperados",
	-- {npc:251968} Ayessa Dawnsinger · {npc:252475} Elaadrin Evengale
	["Rally Valennia, {npc:251968} (west of town) and {npc:252475}"] = "Reúne a Valennia, {npc:251968} (al oeste del pueblo) y {npc:252475}",
	["Meet Valennia at the gate"] = "Reúnete con Valennia en la puerta",

	-- Step 43: Strength and Mercy
	-- {npc:255853} Urs'endris · {area:16638} Valanaar
	["Back to {npc:255853} by the falls north-east of {area:16638}, on the way north to the shrine."] = "Vuelve con {npc:255853} junto a las cascadas al noreste de {area:16638}, de camino al norte hacia el santuario.",

	-- Step 44: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {npc:253576} Hyusaa Quickbreeze · {npc:253590} Valennia Stormfist
	["Fight north to the {area:16629}. Guardians, Spiritcallers and Blademasters hold the approach; {npc:253576} waits at the shrine's door, {npc:253590} inside the inner sanctum."] = "Ábrete paso al norte hasta {area:16629}. Guardianes, clamaespíritus y maestros del acero defienden el acceso; {npc:253576} espera en la puerta del santuario, y {npc:253590}, dentro del sanctasanctórum.",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, in the sanctum"] = "{npc:253590}, en el sanctasanctórum",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}: {npc:257196}, west of the shrine's approach"] = "{item:263993}: {npc:257196}, al oeste del acceso al santuario",

	-- Step 45: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}. {npc:257944} camps in its east."] = "Ve al norte hacia {area:16631}. {npc:257944} acampa en su parte este.",

	-- Step 46: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Stormchasers = {npc:252664} Al'Aketh Stormchaser
	["Al'Aketh Stormchasers and Footsoldiers camp just north of {npc:257944} and drop the heirloom; the Shrieklings west of her drop the feathers and talons; the {item:265105} grows along the stream west of her."] = "Los rastreatormentas y soldados de a pie Al'Aketh acampan justo al norte de {npc:257944} y sueltan la reliquia; los chilladores al oeste de ella sueltan las plumas y las garras; el {item:265105} crece junto al arroyo al oeste de ella.",

	-- Step 47: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "De nuevo {npc:257944}",

	-- Step 48: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive
	["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}."] = "{npc:254151}, {npc:258130} y {npc:258134} están al noreste de {npc:257944}; {npc:253622} está al este de ellos. Haalien también suelta una {quest:94490}.",
	-- {npc:258130} Jorel Windsinger
	["Heal 7 druids in the Nightfang Den, then find {npc:258130}"] = "Sana a 7 druidas en la Nightfang Den y luego busca a {npc:258130}",

	-- Step 49: Elegael Thornpaw, the missive
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the missive"] = "{npc:257944}, la misiva",

	-- Step 50: The Strange Hermit
	-- {quest:93159} The Strange Hermit · {npc:257944} Elegael Thornpaw
	-- plural, as words: Zephyrseed Cones = {object:613238} Zephyrseed Cone
	["{quest:93159} lives west of {npc:257944}. The Zephyrseed Cones lie in the woods between his hut and {npc:257944}."] = "{quest:93159} vive al oeste de {npc:257944}. Los conos de semilla de céfiro ({object:613238}) están en el bosque entre su cabaña y {npc:257944}.",

	-- Step 51: The refugees' camp
	["The refugees' camp"] = "El campamento de refugiados",
	-- {item:266433} Abandoned Belongings · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["North of the cones: the Wind Hollows drift around the refugees' camp, the {item:266433} lie between the tents, and {npc:259013} lies at its north end."] = "Al norte de las piñas: los huecos ventosos flotan alrededor del campamento de refugiados, las {item:266433} están entre las tiendas y {npc:259013} yace en su extremo norte.",

	-- Step 52: Back to the Hermit
	["Back to the Hermit"] = "Vuelve con el ermitaño",

	-- Step 53: High Priestess Lorthuna
	-- {area:16629} Shrine of Akir
	["Lorthuna waits on the eastern shore of the isle, east of the {area:16629}."] = "Lorthuna espera en la costa este de la isla, al este de {area:16629}.",

	-- Step 54: Valanaar, the fate of Zephras
	-- {area:16638} Valanaar
	["{area:16638}, the fate of Zephras"] = "{area:16638}, el destino de Zephras",
	-- {npc:252475} Elaadrin Evengale · {npc:259084} Denaaris Stargale
	["{npc:252475}: {npc:259084} waits by the Skyborne portal"] = "{npc:252475}: {npc:259084} espera junto al portal de los cielonatos",

	-- Step 55: The skycutter
	["The skycutter"] = "El cortacielos",
	-- {area:16638} Valanaar · {area:279} Dalaran
	["The skycutter docks at the tower south of {area:16638}. It lands by the Kirin Tor camp on the lake shore west of {area:279}."] = "El cortacielos atraca en la torre al sur de {area:16638}. Aterriza junto al campamento del Kirin Tor en la orilla del lago al oeste de {area:279}.",
	-- {area:279} Dalaran
	["Skycutter to {area:279}"] = "Cortacielos a {area:279}",

	-- Step 56: Denaaris Stargale
	-- {npc:259084} Denaaris Stargale · {zone:1453} Stormwind
	["{npc:259084} stands beside the Skyborne Portal where the zeppelin lands. The portal takes you to {zone:1453}."] = "{npc:259084} está junto al portal de los cielonatos, donde aterriza el zepelín. El portal te lleva a {zone:1453}.",
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind
	["{npc:270459}, beside {npc:259084}: for {npc:5504} in {zone:1453}"] = "{npc:270459}, junto a {npc:259084}: para {npc:5504} en {zone:1453}",

	-- Step 57: Stormwind Keep
	-- {object:2117} Stormwind Keep · {zone:1436} Westfall
	["Bolvar Fordragon stands in the throne room of {object:2117}, at the north end of the city. Then leave by the main gate for {zone:1436}."] = "Bolvar Fordragon está en la sala del trono de {object:2117}, en el extremo norte de la ciudad. Luego sal por la puerta principal hacia {zone:1436}.",
	-- {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["For {npc:234} at {area:108}"] = "Para {npc:234} en {area:108}",

	-- Step 58: Sheldras Moontree
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form · {zone:1439} Darkshore
	["{npc:5504}, {zone:1453}'s druid trainer, teaches you {spell:18960}. {npc:11802}'s welcome waits for your {spell:499} trip at the end of {zone:1439}."] = "{npc:5504}, el instructor de druidas de {zone:1453}, te enseña {spell:18960}. La bienvenida de {npc:11802} espera a tu viaje de {spell:499} al final de {zone:1439}.",

	-- Step 59: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497} está en la torre de {object:2101}; te da un frasco para la cascada de {quest:1861}.",

	-- Step 60: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Sal de {zone:1453} por la puerta principal. La cascada de {quest:1861} está al suroeste de las puertas, de camino al oeste hacia {zone:1436}: llena el {item:7207} en su base.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Read Ley Line at the {object:460002}"] = "Lanza Read Ley Line sobre la {object:460002}",
	-- ["Cast Read {object:460002} at the {object:460002}"] = "Lanza Read {object:460002} sobre la {object:460002}",
	-- ["Rorian: {quest:92485}"] = "Rorian: {quest:92485}",
	-- ["Tame Beast"] = "Domesticar bestia",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read Ley Line racial ability at it."] = "{npc:249363} vigila al este de la arboleda. Los {npc:251143} y los convertidos Al'Aketh ({npc:251160}) se reúnen justo al norte de ella; la {object:460002} se alza más al norte: lanza sobre ella tu habilidad racial Read Ley Line.",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read {object:460002} racial ability at it."] = "{npc:249363} vigila al este de la arboleda. Los {npc:251143} y los convertidos Al'Aketh se reúnen justo al norte de ella; la {object:460002} se alza más al norte: lanza sobre ella tu habilidad racial Read {object:460002}.",
	-- ["{npc:252377}: Defensive Stance"] = "{npc:252377}: Actitud defensiva",
	-- ["{npc:254411}: Beast Training"] = "{npc:254411}: Entrenamiento de bestias",
	-- ["{npc:255853}: Bear Form"] = "{npc:255853}: Forma de oso",
	-- ["{npc:5504}, {zone:1453}'s druid trainer, teaches you Teleport: {quest:94914}. {npc:11802}'s welcome waits for your Cat Form trip at the end of {zone:1439}."] = "{npc:5504}, el instructor de druidas de {zone:1453}, te enseña Teletransporte: {quest:94914}. La bienvenida de {npc:11802} espera a tu viaje de Forma felina al final de {zone:1439}.",
	-- ["{quest:93159} lives west of Elegael. The {item:257128} Cones lie in the woods between his hut and Elegael."] = "{quest:93159} vive al oeste de Elegael. Las piñas de {item:257128} están en el bosque entre su cabaña y Elegael.",
}
