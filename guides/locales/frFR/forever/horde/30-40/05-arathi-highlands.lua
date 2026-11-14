-- French (frFR): the guide forever/horde/30-40/05-arathi-highlands (forever/horde/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin pour {zone:1458}",

	-- Step 2: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Maîtres de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Entraînez-vous pendant que vous êtes à {zone:1458} : les maîtres se trouvent dans {object:36070}, {object:36073} et {object:36082} (paladins : {npc:260093}).",

	-- Step 3: Calder Gray
	-- {npc:270038} Calder Gray
	["{npc:270038} stands in the Apothecarium."] = "{npc:270038} se tient dans l'Apothicarium.",
	-- {npc:270038} Calder Gray · {zone:1441} Thousand Needles
	["{npc:270038}: Stormheart's heart from {zone:1441}"] = "{npc:270038} : le cœur de Stormheart, de {zone:1441}",

	-- Step 4: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Prendre un vol pour {area:272}",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Maître de vol de {zone:1458}",

	-- Step 5: Tarren Mill
	-- {npc:2229} Krusk
	["{npc:2229}, inside the inn"] = "{npc:2229}, à l'intérieur de l'auberge",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "L'affiche {object:1763} près de l'auberge",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "{npc:2437}, à l'intérieur",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "{npc:2410}, à l'intérieur",

	-- Step 7: Gol'dir
	-- {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north past Valik's camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "Allez vers le nord au-delà du camp de Valik jusqu'à {area:280}, le village tenu par le Syndicat (35-37). {npc:2431} porte la {item:3704} ; {quest:503} est enfermé dans une cage, dans la maison du côté nord.\nAttention : des espions camouflés du Syndicat rôdent dans {area:280}, et les bâtiments abritent de nombreux membres du Syndicat, dont des mages.",
	["Inside"] = "À l'intérieur",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "Trouvez où {quest:503} est retenu, au dernier étage",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "{quest:503}, au dernier étage",

	-- Step 9: Tarren Mill
	-- {npc:2229} Krusk · {area:272} Tarren Mill
	["{npc:2229} waits inside the inn at {area:272}, back south down the road."] = "{npc:2229} attend à l'intérieur de l'auberge de {area:272}, en redescendant la route vers le sud.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, à l'intérieur",

	-- Step 10: Baron Vardus
	-- {npc:2306} Baron Vardus · {area:280} Strahnbrad · {quest:503} Gol'dir
	["{npc:2306} (40) carries the head. He turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village, which lie on your way to the Perenolde manor. If you already met him while freeing {quest:503}, this step is done."] = "{npc:2306} (40) porte la tête. Il n'apparaît qu'à un endroit à la fois : la cave de l'auberge de {area:280}, ou l'un des camps de tentes du Syndicat sur les hauteurs au nord et au nord-ouest du village, qui se trouvent sur votre chemin vers le manoir de Perenolde. Si vous l'avez déjà rencontré en libérant {quest:503}, cette étape est faite.",

	-- Step 11: Alterac Mountains
	["Perenolde manor"] = "Manoir de Perenolde",

	-- Step 12: Lord Aliden Perenolde
	-- {area:1339} Lordamere Lake · {quest:507} Lord Aliden Perenolde · {npc:2317} Elysa
	["Head north-west through the mountains to the Perenolde manor on the northern shore of {area:1339}. {quest:507} (41) waits in a room upstairs: he shields himself, puts you to sleep and heals below half health. {npc:2317} stands beside him."] = "Allez vers le nord-ouest à travers les montagnes jusqu'au manoir de Perenolde, sur la rive nord du {area:1339}. {quest:507} (41) attend dans une pièce à l'étage : il se protège d'un bouclier, vous endort et se soigne sous la moitié de sa vie. {npc:2317} se tient à côté de lui.",

	-- Step 13: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "{area:17707} : tuez-les au passage",
	-- {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave · Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["South along the lake shore to the ruins around the {area:279} crater. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "Longez la rive du lac vers le sud jusqu'aux ruines autour du cratère de {area:279}. Les Invocateurs de Dalaran mènent des Esclaves élémentaires ; les brassards tombent sur les esclaves. Attention : des Sentinelles arcaniques (55, élites) et des Gardes du Kirin Tor (55) gardent le dôme lui-même et attaquent la Horde : restez au bord extérieur des ruines et ne montez pas jusqu'au dôme.",

	-- Step 15: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back east to {area:272}."] = "Retournez vers l'est jusqu'à {area:272}.",
	["The magus offers a dungeon errand next: leave it."] = "Le magus propose ensuite une mission de donjon : laissez-la.",

	-- Step 16: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "La route vers l'est par le {area:1057}",

	-- Step 17: Northfold Manor
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["Head east out of {area:272} through {area:1057}. The Syndicate hold the walled manor and its farm north of the road; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "Sortez de {area:272} vers l'est par le {area:1057}. Le Syndicat tient le manoir fortifié et sa ferme au nord de la route ; ses Bandits de grand chemin, Mercenaires et Rôdeurs portent les Amulettes de pierre de sang.\nAttention : les Bandits de grand chemin (niveau 30-31) peuvent être en Furtivité, donc cachés quand vous approchez.",

	-- Step 18: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "Suivez la route vers l'est. Les éclats violets brillent juste à côté de la route, un peu à l'ouest de {area:321}.",

	-- Step 19: Hammerfall
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "{npc:12920}, à la porte sud",

	-- Step 20: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "Quêtes de Stromgarde en groupe",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "La {quest:639} de {npc:2703} tombe sur les membres élites du Syndicat (35-38) dans les ruines de Stromgarde, à l'ouest des Hautes-terres. Excellente XP si vous avez un groupe pour cela : la route passe par Stromgarde en allant au cercle intérieur.",

	-- Step 21: Foul Magics with a group
	-- {quest:671} Foul Magics
	["{quest:671} with a group"] = "{quest:671} en groupe",
	-- {npc:2706} Tor'gan · {quest:671} Foul Magics · {npc:2783} Marez Cowl
	["{npc:2706}'s next {quest:671} is {npc:2783}, a level 40 elite warlock in Stromgarde's Syndicate quarter."] = "La {quest:671} suivante de {npc:2706}, c'est {npc:2783}, un démoniste élite de niveau 40 dans le quartier du Syndicat de Stromgarde.",

	-- Step 22: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "Au nord-est de Trépas-d'Orgrim, les kobolds Drywhisker exploitent la gorge ; les Kobolds à l'entrée, et les Fouilleurs et les Géomètres plus loin, lâchent tous des Particules de Myzrael.\nAttention : chaque type de kobold fuit chercher de l'aide quand sa vie est basse (les Kobolds à 30 %, les Géomètres et les Fouilleurs à 15 %), ce qui peut en attirer d'autres.",

	-- Step 23: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701} se trouvent tout au fond de la gorge.",
	["Below ground"] = "Sous terre",

	-- Step 24: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Chaque {object:180105} est un anneau de pierres levées ; la clé repose sur la pierre en son centre. Le cercle de l'est se trouve sur les collines au nord-ouest de {area:321}.\nAttention : chaque pierre centrale est gardée par environ trois élémentaires proches du niveau 39, qui attaquent ensemble si vous cliquez sur la pierre sans les avoir éliminés : des Exilés ardents à l'ouest, des Exilés foudroyants au cercle extérieur, des Exilés grimpeurs à l'est.",

	-- Step 25: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "Les Brutes Rochepoing campent devant la salle des ogres, loin au sud-ouest de {area:321} ; les Magus se tiennent parmi elles. Attirez-les un par un.",

	-- Step 26: Fleshstalker raptors
	["Fleshstalker raptors"] = "Raptors charognards",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Des Charognards des hautes-terres ({npc:2561}) (36-37) chassent dans le sud des hautes-terres, une meute au nord de {area:316} et une autre dans la plaine à son ouest. Attirez-les un par un.",

	-- Step 27: Go'shek Farm
	["Go'shek Farm"] = "Ferme de Go'shek",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "La cabane-laboratoire de {npc:2733} se trouve à la ferme de Go'shek, au nord-est de la plaine des raptors, sur le chemin du retour vers {area:321} ; la caisse de {item:278462} est à l'intérieur.",

	-- Step 28: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "Retour à {area:321}",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "Retournez au nord-est à {area:321}.",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "{npc:2792}, près de la porte",

	-- Step 29: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "Quêtes Rochepoing en groupe",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "La {quest:678} suivante de {npc:2771} et la {quest:680} de {npc:2772} concernent les ogres élites (38-40) du quartier ogre de Stromgarde, lors de la même sortie de groupe que le Sceau.",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "{npc:2772}, à côté de lui",

	-- Step 30: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "Allez vers l'ouest ; le cercle extérieur se dresse au milieu des Hautes-terres.",

	-- Step 31: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "Le cercle ouest se trouve près du {area:1057}, au nord-ouest du cercle extérieur.",

	-- Step 32: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "Le cercle intérieur se trouve au sud du cercle ouest, à l'est de Stromgarde.",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "La tâche suivante de la pierre demande Fozruk, un élite de niveau 42 qui rôde à l'ouest de {area:321} : laissez-la.",

	-- Step 33: Stromgarde
	["Stromgarde"] = "Stromgarde",
	-- {npc:2783} Marez Cowl · {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi; {npc:2783} is among them), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "À l'ouest du cercle intérieur, les ruines de Stromgarde : le Syndicat tient la moitié est (le Sceau tombe sur ses Conjurateurs, Rôdeurs et Mages ; {npc:2783} est parmi eux), les Rochepoing la moitié ouest, près de la {area:325} ({npc:2773} attend dans l'une des maisons sans toit à côté).",

	-- Step 34: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Allez vers le sud jusqu'à la crique des gobelins sur la côte sud. {npc:2766} monte la garde sur la falaise au-dessus.",

	-- Step 35: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "Escortez le professeur en haut de la colline jusqu'à la grotte au-dessus de la crique et protégez-le pendant qu'il travaille. Deux élémentaires d'eau de niveau 40 lui tendent une embuscade là-haut, et ils sont insensibles au givre. Retenez-les à l'entrée de la grotte, loin de lui : si le combat a lieu dans la grotte, il s'y joint au lieu de travailler et d'autres élémentaires continuent d'arriver.",

	-- Step 37: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328} : tuez-les au passage",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "À l'ouest de la crique, les Ecumeurs ({npc:2595}) et Sorcières Daguéchine (38-40) tiennent le rivage : attirez-les un par un. Les deux épaves gisent dans les hauts-fonds au large, les cartes et journaux à l'intérieur ; les gemmes reposent au fond de la mer autour des épaves.",
	["Underwater"] = "Sous l'eau",

	-- Step 38: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "pour {npc:2487} à {area:35}, vers le niveau 41",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "Le prochain guide traverse le {area:880} vers {zone:1437} et se dirige vers {zone:1418}.",

	-- Step 39: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "Seulement si vous avez fait Stromgarde en groupe : retournez à {area:321} pour rendre ses quêtes, puis continuez jusqu'au {area:880}.",
}
