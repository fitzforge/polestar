-- French (frFR): the guide forever/horde/30-40/03-arathi-highlands (forever/horde/30-40/03-arathi-highlands.guide).
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

	-- Step 2: Orgrimmar
	-- {object:1661} The Undercity · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["{object:1661} has no Hunter or Shaman trainer: take the {zone:1454} zeppelin from the same tower instead and train in the city, then take the {zone:1458} zeppelin from the tower outside {zone:1454}'s main gate."] = "{object:1661} n'a pas de maître des chasseurs ni des chamans : prenez plutôt le zeppelin d'{zone:1454} à la même tour et entraînez-vous en ville, puis prenez le zeppelin de {zone:1458} à la tour devant la porte principale d'{zone:1454}.",

	-- Step 3: Thunder Bluff
	-- {zone:1450} Moonglade · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Cast Teleport: {zone:1450} and take {npc:11798}'s flight to {area:1638}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "",

	-- Step 4: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Maîtres de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Entraînez-vous pendant que vous êtes à {zone:1458} : les maîtres se trouvent dans {object:36070}, {object:36073} et {object:36082} (paladins : {npc:260093}).",

	-- Step 5: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Volez jusqu'à {area:272}",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Maître de vol de {zone:1458}",

	-- Step 7: Boulderfist camp
	["Boulderfist camp"] = "Camp Rochepoing",
	-- {area:272} Tarren Mill · {area:1857} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "Allez vers l'est en quittant {area:272} par {area:1857} et suivez la route vers l'est. Les Ogres et les Exécuteurs Rochepoing (32-34) campent au sud de la route, au sud-est de {area:313}.",
	["Below ground"] = "Sous terre",

	-- Step 8: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["The violet shards glow just off the road a short way west of {area:321}."] = "Les éclats violets brillent juste à côté de la route, un peu à l'ouest de {area:321}.",

	-- Step 10: Hammerfall
	-- {npc:2851} Urda
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "La forteresse orque au bout est de la route. {npc:2851}, la maîtresse des coursiers du vent, se tient près de la porte.",

	-- Step 11: Highland raptors
	["Highland raptors"] = "Raptors des hautes-terres",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider
	["Highland Striders roam the hills all around {area:321}; both they and the Thrashers further west drop the eyes."] = "Des Arpenteurs des hautes-terres ({npc:2559}) parcourent les collines tout autour de {area:321} ; eux et les Vandales des hautes-terres plus à l'ouest lâchent les yeux.",

	-- Step 13: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "Au nord-est de Trépas-d'Orgrim, les kobolds Drywhisker exploitent la gorge ; les Kobolds à l'entrée, et les Fouilleurs et les Géomètres plus loin, lâchent tous des Particules de Myzrael.\nAttention : chaque type de kobold fuit chercher de l'aide quand sa vie est basse (les Kobolds à 30 %, les Géomètres et les Fouilleurs à 15 %), ce qui peut en attirer d'autres.",

	-- Step 14: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701} se trouvent tout au fond de la gorge.",

	-- Step 15: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Chaque {object:180105} est un anneau de pierres levées ; la clé repose sur la pierre en son centre. Le cercle de l'est se trouve sur les collines au nord-ouest de {area:321}.\nAttention : chaque pierre centrale est gardée par environ trois élémentaires proches du niveau 39, qui attaquent ensemble si vous cliquez sur la pierre sans les avoir éliminés : des Exilés ardents à l'ouest, des Exilés foudroyants au cercle extérieur, des Exilés grimpeurs à l'est.",

	-- Step 16: Witherbark Village
	["The Witherbark trolls hold the village in the south-eastern hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village.\nCareful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "Les trolls Witherbark tiennent le village dans les collines du sud-est. Les Lanceurs de hache gardent les huttes extérieures ; les Sorciers-docteurs et les Chasseurs de têtes tiennent le cœur du village.\nAttention : les trois types de trolls fuient chercher de l'aide à 15 % de vie, ce qui peut attirer d'autres trolls des camps voisins.",

	-- Step 17: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head north; the outer circle stands in the middle of the highlands."] = "Allez vers le nord ; le cercle extérieur se dresse au milieu des hautes-terres.",

	-- Step 18: Fleshstalker raptors
	["Fleshstalker raptors"] = "Raptors charognards",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Des Charognards des hautes-terres ({npc:2561}) (36-37) chassent dans le sud des hautes-terres, une meute au nord de {area:316} et une autre dans la plaine à son ouest. Attirez-les un par un.",

	-- Step 19: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Allez vers le sud-ouest jusqu'à la crique des gobelins sur la côte sud. {npc:2766} monte la garde sur la falaise au-dessus.",

	-- Step 20: Professor Phizzlethorpe
	["Escort the professor down to the shore. Two Daggerspine naga ambush him on the way: stay close.\nCareful: The ambush is two level 40 water elementals, and they are immune to frost. If the fight happens inside the cave, the professor joins in instead of working and further elementals keep appearing; holding the elementals at the cave entrance, away from him, lets him finish with only the first two to deal with."] = "Escortez le professeur jusqu'au rivage. Deux nagas Épine-de-dague lui tendent une embuscade en chemin : restez près de lui.\nAttention : l'embuscade est composée de deux élémentaires d'eau de niveau 40, insensibles au givre. Si le combat a lieu dans la grotte, le professeur s'y joint au lieu de travailler et d'autres élémentaires continuent d'apparaître ; retenir les élémentaires à l'entrée de la grotte, loin de lui, lui permet de terminer avec seulement les deux premiers à affronter.",

	-- Step 22: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328} : tuez-les au passage",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "À l'ouest de la crique, les Ecumeurs ({npc:2595}) et Sorcières Daguéchine (38-40) tiennent le rivage : attirez-les un par un. Les deux épaves gisent dans les hauts-fonds au large, les cartes et journaux à l'intérieur ; les gemmes reposent au fond de la mer autour des épaves.",
	["Underwater"] = "Sous l'eau",

	-- Step 23: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 44"] = "pour {npc:2487} à {area:35}, vers le niveau 44",

	-- Step 24: Circle of West Binding: kill these as you meet them
	-- {area:334} Circle of West Binding
	["{area:334}: kill these as you meet them"] = "{area:334} : tuez-les au passage",
	-- {area:1857} Thoradin's Wall
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["The western circle is near {area:1857}, where you came in.\nThe Syndicate hold the walled manor and its farm in the north-west; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "Le cercle de l'ouest est près de {area:1857}, par où vous êtes entré.\nLe Syndicat tient le manoir fortifié et sa ferme au nord-ouest ; ses Bandits de grand chemin, ses Mercenaires et ses Rôdeurs portent les Amulettes de pierre de sang.\nAttention : les Bandits de grand chemin (niveau 30-31) peuvent être camouflés et donc cachés quand vous approchez.",

	-- Step 25: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "Le cercle intérieur se trouve au sud du cercle ouest, à l'est de Stromgarde.",
	["The stone's next task needs Fozruk, a level 42 elite: leave it."] = "La tâche suivante de la pierre demande Fozruk, un élite de niveau 42 : laissez-la.",

	-- Step 26: Hearth to Hammerfall
	-- {area:321} Hammerfall
	["Hearth to {area:321}"] = "Pierre de foyer vers {area:321}",

	-- Step 27: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "Retour à {area:321}",

	-- Step 28: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "Les Brutes Rochepoing ({npc:2566}) campent devant la salle des ogres au sud de {area:321} ; les Magus se tiennent parmi elles. Attirez-les un par un.",

	-- Step 29: Drum Fel
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms
	["{npc:2771}'s next {quest:678} is against Boulderfist elites: leave it."] = "La suite {quest:678} de {npc:2771} vise des élites Rochepoing : laissez-la.",

	-- Step 30: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "Vers {zone:1418}",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor · {zone:1432} Loch Modan · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Head south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "Quittez Arathi vers le sud-ouest par {area:880}, allez vers le sud à travers les {zone:1437} (en évitant {area:150}) puis vers l'est dans le {zone:1432} ; la route quitte le {zone:1432} vers le sud pour entrer dans les {zone:1418}. Suivez-la vers le sud jusqu'au camp gobelin de {area:1877}.",

	-- Step 31: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106} : la lettre de Fizzle, de {area:439}",

	-- Step 32: Kargath
	-- {area:340} Kargath
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge."] = "{area:340} est la forteresse de la Horde bâtie dans les falaises, à l'extrémité ouest de la zone.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "pour Helgrum l'Agile à {area:75}, vers le niveau 42",
	-- {npc:6868} Jarkal Mossmeld
	["{npc:6868}, inside"] = "{npc:6868}, à l'intérieur",

	-- Step 33: The Dustbowl
	-- {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl · {area:340} Kargath
	["Head west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "Allez vers l'ouest par la route ; le camp de {npc:2921} se trouve dans {area:1878}, à mi-chemin de {area:340}.",

	-- Step 34: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elémentaires de roche inférieurs ({npc:2735})",
	-- {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats just west of {npc:2921}'s camp. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards: keep them."] = "Les petits élémentaires dérivent dans la plaine juste à l'ouest du camp de {npc:2921}. Tout élémentaire de roche de la zone peut lâcher les Fragments d'élémentaire de roche ({item:7848}) de {npc:6868} : gardez-les.",

	-- Step 36: Badlands: kill these as you meet them
	-- {zone:1418} Badlands
	["{zone:1418}: kill these as you meet them"] = "{zone:1418} : tuez-les au passage",
	-- {area:1878} The Dustbowl
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard · Rock Elementals = {npc:92} Rock Elemental
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards.\nThe bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "Les Anciens coyotes des rochers et les Busards géants parcourent le bassin au sud de {area:1878}. Les coyotes lâchent à la fois les mâchoires et les crocs ; seuls les busards lâchent les ailes et les gésiers.\nLes Élémentaires de roche, plus grands, se tiennent sur les pentes au nord-ouest de {area:1878} ; chacun lâche une dalle.",

	-- Step 38: Agmond's End
	-- {area:345} Agmond's End · {area:1877} Valley of Fangs
	["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "Theldurin l’Egaré se trouve parmi les ruines naines de {area:345}, au sud de la {area:1877}.",

	-- Step 39: Stonevault troggs
	["Stonevault troggs"] = "Troggs Stonevault",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes."] = "Les troggs Stonevault creusent autour des entrées de grottes au sud de {area:1877}, sur le chemin de {area:345} ; les Briseurs d'os et les Chamans lâchent les éclats.",

	-- Step 40: Ancient Chest
	-- {area:1517} Uldaman
	["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "Continuez vers le nord sur la route ; le coffre se trouve sur le site de fouilles d'{area:1517}, au pied des ruines au nord-ouest de la route.",

	-- Step 41: Agmond's End
	-- {area:1877} Valley of Fangs
	["Head back south down the road, past the {area:1877}."] = "Redescendez la route vers le sud, en passant {area:1877}.",

	-- Step 44: The Dustbowl: kill these as you meet them
	-- {area:1878} The Dustbowl
	["{area:1878}: kill these as you meet them"] = "{area:1878} : tuez-les au passage",
	-- {zone:1418} Badlands · {npc:6868} Jarkal Mossmeld · {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Every rock elemental in the {zone:1418} drops {npc:6868}'s shards: the Lesser Rock Elementals (37) on the flats west of {npc:2921}'s camp are the safe ones, about one kill in five. Only the Greater Rock Elementals (42-44, well above you) in the south-western gulches drop {npc:2921}'s bracers, also about one kill in five: pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "Tous les élémentaires de roche des {zone:1418} lâchent les éclats de {npc:6868} : les Élémentaires de roche inférieurs (37), sur les plaines à l'ouest du camp de {npc:2921}, sont les plus sûrs, environ une fois sur cinq. Seuls les Élémentaires de roche supérieurs (42-44, bien au-dessus de vous) dans les ravins du sud-ouest lâchent les brassards de {npc:2921}, également environ une fois sur cinq : attirez-les un par un et reposez-vous entre les combats, ou laissez-les. Continuez à tuer en chemin les coyotes et les busards qui vous manquent encore.",

	-- Step 45: The Dustbowl
	-- {npc:2920} Lucien Tosselwrench · {item:2868} Patterned Bronze Bracers · {skill:164} Blacksmithing
	["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920} : seulement si vous avez {item:2868} ({skill:164} ou l'hôtel des ventes)",

	-- Step 46: Kargath
	-- {area:340} Kargath
	["Head north back to {area:340}."] = "Retournez vers le nord jusqu'à {area:340}.",

	-- Step 47: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Volez jusqu'à {object:3202}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Maître de vol de {area:340}",

	-- Step 48: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",

	-- Step 50: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, pour « Swamp Eye » Jarl",

	-- Step 52: Orgrimmar flight master
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 53: Thunder Bluff
	-- {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:380} Crossroads
	["Your trainer is in {area:1638}, one flight from {zone:1454}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to the {area:380} from there."] = "Votre maître est à {area:1638}, à un vol d'{zone:1454} : {npc:3033} (druides) sur la {area:1639}, {npc:246344} (paladins). De là, volez jusqu'à {area:380}.",

	-- Step 54: Fly to Crossroads
	-- {area:380} Crossroads
	["Fly to {area:380}"] = "Prendre un vol pour {area:380}",

	-- Step 57: Regthar Deathgate
	-- {area:380} Crossroads · {area:386} Forgotten Pools · {npc:3389} Regthar Deathgate
	["Head north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "Remontez la route vers le nord depuis la {area:380} jusqu'à {area:386} ; {npc:3389} monte la garde sur l'éminence au-dessus de l'eau.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960} and take {npc:11798}'s flight to {area:1638}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "Lancez {spell:18960} et prenez le vol de {npc:11798} jusqu'aux {area:1638} ; {npc:3033} vous entraîne sur la {area:1639}. Volez ensuite jusqu'à {zone:1454} et prenez le zeppelin pour {zone:1458} à la tour devant la grande porte.",
	-- ["Coyotes and buzzards"] = "Coyotes et busards",
	-- ["Daggerspine shore"] = "Rivage des Daguéchine",
	-- ["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}."] = "Chaque {object:180105} est un cercle de pierres levées ; la clé repose sur la pierre en son centre. Le cercle est se trouve sur les collines au nord-ouest de {area:321}.",
	-- ["Escort the professor down to the shore. Two Daggerspine naga ambush him on the way: stay close."] = "Escortez le professeur jusqu'au rivage. Deux nagas Daguéchine lui tendent une embuscade en chemin : restez près de lui.",
	-- ["Follow the road north; {npc:4618}'s camp is on the way."] = "Suivez la route vers le nord ; le camp de {npc:4618} est sur le chemin.",
	-- ["From {area:35}, fly to {object:3202}. {object:1661} zeppelin leaves from the tower on the west side of the camp."] = "Depuis {area:35}, volez jusqu'à {object:3202}. Le zeppelin de {object:1661} part de la tour à l'ouest du camp.",
	-- ["Greater Rock Elementals"] = "Elémentaires de roche supérieurs ({npc:2736})",
	-- ["Hearth to {area:340}"] = "Pierre de foyer vers {area:340}",
	-- ["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael."] = "Au nord-est de Trépas-d'Orgrim, les kobolds Sèche-moustache exploitent la gorge ; les Kobolds à l'entrée, et les Terrassiers et Géomètres plus loin, lâchent tous les Poussières de Myzrael.",
	-- ["Ride back south down the road, past the {area:1877}."] = "Redescendez la route vers le sud, en passant la {area:1877}.",
	-- ["Ride back south to the {area:380} and fly to {area:392}."] = "Retournez vers le sud jusqu'à {area:380} et volez jusqu'à {area:392}.",
	-- ["Ride east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "Sortez de {area:272} vers l'est par {area:1857} et suivez la route vers l'est. Les Ogres Rochepoing ({npc:2562}) et les Massacreurs (32-34) campent au sud de la route, au sud-est de {area:313}.",
	-- ["Ride north back to {area:340}."] = "Retournez vers le nord jusqu'à {area:340}.",
	-- ["Ride north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "Remontez la route vers le nord depuis {area:380} jusqu'aux {area:386} ; {npc:3389} Seuil-de-mort monte la garde sur l'élévation au-dessus de l'eau.",
	-- ["Ride north; the outer circle stands in the middle of the highlands."] = "Chevauchez vers le nord ; le cercle extérieur se dresse au milieu des hautes-terres.",
	-- ["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Longez la côte vers le sud de {area:392} jusqu'à l'{area:720}. {npc:6236} se tient près de l'arène : marchez sur la grille pour lancer le combat ; les adversaires arrivent un par un, puis {npc:6238} (33).",
	-- ["Ride south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "Quittez Arathi vers le sud-ouest par {area:880}, traversez les {zone:1437} vers le sud (évitez {area:150}) et allez vers l'est au {zone:1432} ; la route quitte le {zone:1432} vers le sud pour entrer dans {zone:1418}. Suivez-la vers le sud jusqu'au camp gobelin de {area:1877}.",
	-- ["Ride south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Chevauchez vers le sud-ouest jusqu'à la crique des gobelins sur la côte sud. {npc:2766} fait le guet sur la falaise au-dessus.",
	-- ["Ride west along the road; Lotwil's camp sits in the {area:1878} halfway to {area:340}."] = "Chevauchez vers l'ouest sur la route ; le camp de Lotwil se trouve dans la {area:1878}, à mi-chemin de {area:340}.",
	-- ["Ride west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "Chevauchez vers l'ouest sur la route ; le camp de {npc:2921} se trouve dans la {area:1878}, à mi-chemin de {area:340}.",
	-- ["Rock Elementals"] = "Elémentaires de roche ({npc:92})",
	-- ["Stonevault troggs"] = "Troggs Cavepierre",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202}."] = "Prenez le zeppelin d'{zone:1454} à la tour à l'ouest de {object:3202}.",
	-- ["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "Les Anciens coyotes des rochers et les Busards géants parcourent le bassin au sud de la {area:1878}. Les coyotes lâchent à la fois les mâchoires et les crocs ; seuls les busards lâchent ailes et gésiers.",
	-- ["The Greater Rock Elementals (42-44, well above you) wander the gulches in the south-west; the bracers drop about one kill in five. Pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "Les Elémentaires de roche supérieurs ({npc:2736}) (42-44, bien au-dessus de vous) errent dans les ravins du sud-ouest ; les brassards tombent environ une fois sur cinq. Attirez-les un par un et reposez-vous entre les combats, ou laissez-les. Continuez à tuer en chemin les coyotes et busards qu'il vous manque.",
	-- ["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes."] = "Les troggs Cavepierre creusent autour des entrées de grottes au sud de la {area:1877}, sur le chemin de {area:345} ; les Briseurs d'os et Chamans lâchent les éclats.",
	-- ["The Syndicate hold the walled manor and its farm in the north-west; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets."] = "Le Syndicat tient le manoir fortifié et sa ferme au nord-ouest ; leurs Malandrins, Mercenaires et Eclaireurs portent les Amulettes de pierre de sang ({item:4495}).",
	-- ["The Witherbark trolls hold the village in the south-eastern hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village."] = "Les trolls Witherbark tiennent le village dans les collines du sud-est. Les Lanceurs de haches gardent les huttes extérieures ; les Sorciers-docteurs et Chasseurs de têtes tiennent le cœur du village.",
	-- ["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "Les plus gros Elémentaires de roche se tiennent sur les pentes au nord-ouest de la {area:1878} ; chacun lâche une dalle.",
	-- ["The next guide heads into {zone:1445}."] = "Le prochain guide part vers le {zone:1445}.",
	-- ["The western circle is near {area:1857}, where you rode in."] = "Le cercle ouest se trouve près de {area:1857}, par où vous êtes arrivé.",
	-- ["The zeppelin lands at the towers outside the {zone:1458}: ride down into the city and fly to {area:272}."] = "Le zeppelin se pose aux tours devant {zone:1458} : descendez en ville et volez jusqu'à {area:272}.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {object:2689}"] = "{object:2689}",
	-- ["Zeppelin to the {zone:1458}"] = "Zeppelin pour {zone:1458}",
	-- ["Zeppelin tower"] = "Tour du zeppelin",
	-- ["for {npc:5395} in {zone:1443}, in the next guide"] = "pour {npc:5395} en {zone:1443}, dans le prochain guide",
	-- ["{item:3713}, for \"Swamp Eye\" Jarl in {zone:1445}"] = "{item:3713}, pour Jarl « Oeil-des-marais » au {zone:1445}",
}
