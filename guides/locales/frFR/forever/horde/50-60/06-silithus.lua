-- French (frFR): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Le col venant d'Un'Goro débouche sur {area:3077}, le cimetière du nord-est de {zone:1451}. {npc:13220} se tient parmi les tombes.",

	-- Step 2: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Allez vers le sud-ouest jusqu'aux ruines du {area:2738}. Le {object:179565} pour {npc:11801} se trouve dans l'une des maisons en ruine.",

	-- Step 4: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "Retournez à Sudevent et montez dans la tour. Remuer la ruche au sommet fait sortir des Embusquées de la Ruche'Ashi ({npc:13301}) ; l'une porte {item:17346}.",

	-- Step 5: Cenarion Hold
	["Ride west to the walled hold in the middle of the desert."] = "Allez vers l'ouest jusqu'au fort fortifié au milieu du désert.",

	-- Step 6: Dredge and scorpids
	["Dredge and scorpids"] = "Térébrants et scorpides",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Les Frappeurs térébrants, les Scorpides Cinglepierre et les Glisseuses du sable se partagent les sables juste au nord du fort.",

	-- Step 7: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Les fragments de tablette luisants jonchent le Campement du crépuscule, à l'extrême nord-ouest ; les Tempétueux de poussière et les Grondeurs du désert de l'endroit en laissent aussi tomber.",

	-- Step 9: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Allez vers le sud-est jusqu'à {area:3447}, au pied des falaises d'Un'Goro.",

	-- Step 10: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "Allez vers l'ouest jusqu'au camp de la Horde au nord de la {area:2744}.",

	-- Step 11: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Des Geysers de silithyste jaillissent dans le désert du sud. Marchez dans le silithyste qu'ils laissent et portez-le à l'extracteur de silithyste de la Horde, au camp de Kirika ; combattre ou monter en selle vous le fait lâcher.",

	-- Step 12: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Écorcheurs et Traqueuses des rochers",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Les Ecorcheurs Cinglepierre et les Traqueuses des rochers parcourent les dunes au sud-ouest du camp de Kirika.",

	-- Step 13: Twilight Vanguard
	["Twilight Vanguard"] = "Avant-garde du Crépuscule",
	-- {npc:11803} Twilight Keeper Exeter · {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803} arpente le camp de l'Avant-garde, à l'extrême sud-ouest. Chaque cultiste ici laisse tomber des Textes du crépuscule cryptés, quête ou non : récupérez-en vingt, dix pour {npc:15306} et dix pour Ortell.",

	-- Step 14: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Écraseurs térébrants et Pinceurs",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Remontez vers le nord le long des dunes de l'ouest ; les Ecraseurs térébrants et les Pinceurs Cinglepierre rôdent d'ici jusqu'au fort.",

	-- Step 15: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} tient le camp de l'ouest.",

	-- Step 16: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804} se tient dans l'avant-poste à l'ouest du {area:3425}. Complétez vos Textes du crépuscule cryptés jusqu'à vingt sur les cultistes du coin.",

	-- Step 17: Cenarion Hold
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, du côté ouest du fort",

	-- Step 18: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "La sacoche se trouve dans les montagnes de l'extrême sud, au-delà du Campement de Bronzebeard. Poigne-de-mort, un scorpide élite, patrouille à proximité : prenez-la pendant qu'il s'éloigne.",

	-- Step 19: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "Allez vers le nord-est jusqu'à {area:3447}.",
	["The spare texts from the cultists"] = "Les textes en trop des cultistes",

	-- Step 20: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Retour au {area:3425}",
	-- {area:2744} Hive'Regal
	["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "Chère Natalia, la quête de Mar'alith, demande le niveau 58 et mène dans la {area:2744}, parmi des élites. Passez-la.",

	-- Step 21: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Allez vers le nord-est jusqu'au cimetière ({area:3077}) ; vous quittez {zone:1451} par le col tout proche.",

	-- Step 22: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:8737} Linken · {npc:9117} J.D. Collie
	["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "Passez le col puis longez les falaises du nord vers l'est jusqu'au {area:541}. {npc:8737} se tient près de la grotte ; {npc:9117} est à l'intérieur.",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {npc:10980} on {npc:10977}"] = "Utilisez {npc:10980} sur {npc:10977}",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Gardez {quest:3942} : {npc:9116} est au {area:2479}, sur le chemin du prochain guide à travers {zone:1448}.",

	-- Step 23: Gadgetzan
	-- {area:976} Gadgetzan · {object:142071} Egg-O-Matic
	["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Volez jusqu'à {area:976}. L'{object:142071} se dresse au milieu de la ville.",

	-- Step 24: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637} and train."] = "Volez jusqu'à {area:1637} et entraînez-vous.",

	-- Step 25: The Undercity
	-- {area:1637} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {object:36126} Royal Quarter
	["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Prenez le zeppelin depuis la tour à l'extérieur d'{area:1637} jusqu'à {zone:1420} et entrez dans {zone:1458}. Dame Sylvanas règne sur le {object:36126}.",

	-- Step 26: The Bulwark
	-- {area:152} The Bulwark
	["Ride east along the road to the {area:152} on the border."] = "Suivez la route vers l'est jusqu'à la {area:152}, à la frontière.",

	-- Step 27: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "La ferme de {npc:10778} est la première à l'est de la {area:152}. Les Goules jacassantes de la ferme portent l'autre moitié de son talisman ; {npc:11075} garde le chaudron dans le champ.",

	-- Step 28: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Tours de guet et silos d'Andorhal",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Allez vers le sud jusqu'à Andorhal. {npc:10667} attend dans l'auberge en ruine à l'ouest de la ville. Placez-vous sur le seuil de chacune des quatre tours avec {item:12815} pour la marquer ; restez en bordure de la ville. Utilisez {item:12627} près des silos au centre de la ville pour faire apparaître des Parasites temporels.",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marquez {npc:10904} avec {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marquez {npc:10903} avec {item:12815}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marquez {npc:10902} avec {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marquez {npc:10905} avec {item:12815}",

	-- Step 29: The Bulwark
	-- {item:14619} Skeletal Fragments · {quest:838} Scholomance
	["Dithers offers {item:14619} ({quest:838}). Skip it."] = "Dithers propose {item:14619} ({quest:838}). Passez-la.",

	-- Step 30: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "Plus à l'est sur la route, {npc:11077} garde le chaudron des {area:200}.",

	-- Step 31: Northridge Lumber Camp
	["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "Au nord, jusqu'au camp de bûcherons ; posez le tonneau de termites au milieu de la scierie.",

	-- Step 32: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "Le libram se trouve plus au nord, sur la route de {area:190}.",

	-- Step 33: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Allez vers l'est jusqu'à la cabane de {npc:1855}, au bord de {area:2619}, et écoutez-le.",

	-- Step 34: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "Le bouclier se trouve à {area:201}, au sud de la cabane de {npc:1855}.",

	-- Step 35: Light's Hope Chapel
	["Ride east across the plaguelands to the chapel."] = "Traversez les maleterres vers l'est jusqu'à la chapelle.",

	-- Step 36: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Champions du Fléau",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Les Champions du Fléau parcourent {area:2270}, au nord de la chapelle. Passez {item:13156} de {npc:11063} sur chacun de ceux que vous tuez : les crânes qui résonnent sont ceux qu'il veut.",

	-- Step 38: Pamela Redpath and the Undercroft
	-- {npc:10926} Pamela Redpath · {area:2261} Undercroft
	["{npc:10926} and the {area:2261}"] = "{npc:10926} et {area:2261}",
	-- {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "Allez jusqu'à {area:2262}, au sud-ouest ; {npc:10926} joue entre les maisons. {npc:11886} rôde dans {area:2261}, la crypte juste à l'ouest du village.",
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s own errand is not on this route. Skip it."] = "La quête propre à {npc:10926} ne fait pas partie de cet itinéraire. Passez-la.",

	-- Step 39: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Le champion de {npc:15193} occupe la maison de {area:2260}, au nord de la crypte ({area:2261}).",
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}' errands are not on this route. Skip them."] = "Les quêtes de {npc:11878} ne font pas partie de cet itinéraire. Passez-les.",

	-- Step 40: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "Allez vers le nord-ouest jusqu'à la cabane de {npc:1855}.",
	-- {npc:1855} Tirion Fordring
	["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "La tâche suivante de {npc:1855}, De l'honneur perdu, ne fait pas partie de cet itinéraire. Passez-la.",

	-- Step 41: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "Allez vers le sud-ouest jusqu'à {npc:10667}, à Andorhal.",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "La bataille de Comté-de-Darrow, quête de {npc:10667}, se termine contre des élites. Passez-la.",

	-- Step 42: The Bulwark
	-- {area:152} The Bulwark · {zone:1458} Undercity
	["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Vers l'ouest jusqu'à la {area:152}. Le prochain guide commence à {zone:1458}, un peu plus à l'ouest.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Southwind and climb the tower. Stirring the hive at the top brings out {area:2742} Ambushers; one carries the {item:17346}."] = "Retournez à Sudevent et montez dans la tour. Remuer la ruche au sommet fait sortir des Embusquées de la {area:2742} ; l'une d'elles porte {item:17346}.",
	-- ["Ride east along the road to the {area:152} on the border."] = "Suivez la route vers l'est jusqu'à {area:152}, à la frontière.",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Vers l'ouest jusqu'à {area:152}. Le prochain guide commence à {zone:1458}, un peu plus à l'ouest.",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "La ferme de {npc:10778} est la première à l'est de {area:152}. Les Goules jacassantes de la ferme portent l'autre moitié de son talisman ; {npc:11075} garde le chaudron dans le champ.",
}
