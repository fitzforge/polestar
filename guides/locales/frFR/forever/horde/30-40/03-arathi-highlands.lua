-- French (frFR): the guide forever/horde/30-40/03-arathi-highlands (forever/horde/30-40/03-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Volez jusqu'à {object:3202}",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words) · {object:1661} The Undercity
	["From {area:35}, fly to {object:3202}. {object:1661} zeppelin leaves from the tower on the west side of the camp."] = "Depuis {area:35}, volez jusqu'à {object:3202}. Le zeppelin de {object:1661} part de la tour à l'ouest du camp.",
	-- {zone:1458} Undercity
	["Zeppelin to the {zone:1458}"] = "Zeppelin pour {zone:1458}",

	-- Step 2: Orgrimmar
	-- {object:1661} The Undercity · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["{object:1661} has no Hunter or Shaman trainer: take the {zone:1454} zeppelin from the same tower instead and train in the city, then take the {zone:1458} zeppelin from the tower outside {zone:1454}'s main gate."] = "{object:1661} n'a pas de maître des chasseurs ni des chamans : prenez plutôt le zeppelin d'{zone:1454} à la même tour et entraînez-vous en ville, puis prenez le zeppelin de {zone:1458} à la tour devant la porte principale d'{zone:1454}.",

	-- Step 3: Thunder Bluff
	-- {spell:18960} Teleport: Moonglade · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Cast {spell:18960} and take {npc:11798}'s flight to {area:1638}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "Lancez {spell:18960} et prenez le vol de {npc:11798} jusqu'à {area:1638} ; {npc:3033} vous entraîne sur {area:1639}. Volez ensuite jusqu'à {zone:1454} et prenez le zeppelin de {zone:1458} à la tour devant la porte principale.",

	-- Step 4: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Maîtres de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Entraînez-vous pendant que vous êtes à {zone:1458} : les maîtres se trouvent dans {object:36070}, {object:36073} et {object:36082} (paladins : {npc:260093}).",

	-- Step 5: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Volez jusqu'à {area:272}",
	-- {zone:1458} Undercity · {area:272} Tarren Mill
	["The zeppelin lands at the towers outside the {zone:1458}: ride down into the city and fly to {area:272}."] = "Le zeppelin se pose aux tours devant {zone:1458} : descendez en ville et volez jusqu'à {area:272}.",

	-- Step 6: Boulderfist camp
	["Boulderfist camp"] = "Camp Rochepoing",
	-- {area:272} Tarren Mill · {area:1857} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Ride east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "Sortez de {area:272} vers l'est par {area:1857} et suivez la route vers l'est. Les Ogres Rochepoing ({npc:2562}) et les Massacreurs (32-34) campent au sud de la route, au sud-est de {area:313}.",

	-- Step 7: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["The violet shards glow just off the road a short way west of {area:321}."] = "Les éclats violets brillent juste à côté de la route, un peu à l'ouest de {area:321}.",

	-- Step 8: Hammerfall
	["The orc stronghold at the eastern end of the road. Urda, the wind rider master, stands by the gate."] = "La forteresse orque au bout est de la route. Urda, la maîtresse des coursiers du vent, se tient près de la porte.",

	-- Step 9: Highland raptors
	["Highland raptors"] = "Raptors des hautes-terres",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider
	["Highland Striders roam the hills all around {area:321}; both they and the Thrashers further west drop the eyes."] = "Des Arpenteurs des hautes-terres ({npc:2559}) parcourent les collines tout autour de {area:321} ; eux et les Vandales des hautes-terres plus à l'ouest lâchent les yeux.",

	-- Step 11: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael."] = "Au nord-est de Trépas-d'Orgrim, les kobolds Sèche-moustache exploitent la gorge ; les Kobolds à l'entrée, et les Terrassiers et Géomètres plus loin, lâchent tous les Poussières de Myzrael.",

	-- Step 12: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701} se trouvent tout au fond de la gorge.",

	-- Step 13: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}."] = "Chaque {object:180105} est un cercle de pierres levées ; la clé repose sur la pierre en son centre. Le cercle est se trouve sur les collines au nord-ouest de {area:321}.",

	-- Step 14: Witherbark Village
	["The Witherbark trolls hold the village in the south-eastern hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village."] = "Les trolls Witherbark tiennent le village dans les collines du sud-est. Les Lanceurs de haches gardent les huttes extérieures ; les Sorciers-docteurs et Chasseurs de têtes tiennent le cœur du village.",

	-- Step 15: Fleshstalker raptors
	["Fleshstalker raptors"] = "Raptors charognards",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Des Charognards des hautes-terres ({npc:2561}) (36-37) chassent dans le sud des hautes-terres, une meute au nord de {area:316} et une autre dans la plaine à son ouest. Attirez-les un par un.",

	-- Step 16: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Ride south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Chevauchez vers le sud-ouest jusqu'à la crique des gobelins sur la côte sud. {npc:2766} fait le guet sur la falaise au-dessus.",

	-- Step 17: Professor Phizzlethorpe
	["Escort the professor down to the shore. Two Daggerspine naga ambush him on the way: stay close."] = "Escortez le professeur jusqu'au rivage. Deux nagas Daguéchine lui tendent une embuscade en chemin : restez près de lui.",

	-- Step 19: Daggerspine shore
	["Daggerspine shore"] = "Rivage des Daguéchine",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "À l'ouest de la crique, les Ecumeurs ({npc:2595}) et Sorcières Daguéchine (38-40) tiennent le rivage : attirez-les un par un. Les deux épaves gisent dans les hauts-fonds au large, les cartes et journaux à l'intérieur ; les gemmes reposent au fond de la mer autour des épaves.",

	-- Step 20: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 44"] = "pour {npc:2487} à {area:35}, vers le niveau 44",

	-- Step 21: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Ride north; the outer circle stands in the middle of the highlands."] = "Chevauchez vers le nord ; le cercle extérieur se dresse au milieu des hautes-terres.",

	-- Step 22: Northfold Manor
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["The Syndicate hold the walled manor and its farm in the north-west; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets."] = "Le Syndicat tient le manoir fortifié et sa ferme au nord-ouest ; leurs Malandrins, Mercenaires et Eclaireurs portent les Amulettes de pierre de sang ({item:4495}).",

	-- Step 23: The Stone of West Binding
	-- {object:2689} Stone of West Binding
	["The {object:2689}"] = "{object:2689}",
	-- {area:1857} Thoradin's Wall
	["The western circle is near {area:1857}, where you rode in."] = "Le cercle ouest se trouve près de {area:1857}, par où vous êtes arrivé.",

	-- Step 24: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "Le cercle intérieur se trouve au sud du cercle ouest, à l'est de Stromgarde.",
	["The stone's next task needs Fozruk, a level 42 elite: leave it."] = "La tâche suivante de la pierre demande Fozruk, un élite de niveau 42 : laissez-la.",

	-- Step 25: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "Retour à {area:321}",

	-- Step 26: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "Les Brutes Rochepoing ({npc:2566}) campent devant la salle des ogres au sud de {area:321} ; les Magus se tiennent parmi elles. Attirez-les un par un.",

	-- Step 27: Drum Fel
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms
	["{npc:2771}'s next {quest:678} is against Boulderfist elites: leave it."] = "La suite {quest:678} de {npc:2771} vise des élites Rochepoing : laissez-la.",

	-- Step 28: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "Vers {zone:1418}",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor · {zone:1432} Loch Modan · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Ride south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "Quittez Arathi vers le sud-ouest par {area:880}, traversez les {zone:1437} vers le sud (évitez {area:150}) et allez vers l'est au {zone:1432} ; la route quitte le {zone:1432} vers le sud pour entrer dans {zone:1418}. Suivez-la vers le sud jusqu'au camp gobelin de {area:1877}.",

	-- Step 29: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106} : la lettre de Fizzle, de {area:439}",

	-- Step 30: The Dustbowl
	-- {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl · {area:340} Kargath
	["Ride west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "Chevauchez vers l'ouest sur la route ; le camp de {npc:2921} se trouve dans la {area:1878}, à mi-chemin de {area:340}.",

	-- Step 31: Kargath
	-- {area:340} Kargath
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge."] = "{area:340} est la forteresse de la Horde bâtie dans les falaises, à l'extrémité ouest de la zone.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "pour Helgrum l'Agile à {area:75}, vers le niveau 42",

	-- Step 32: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elémentaires de roche inférieurs ({npc:2735})",
	-- {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats just west of {npc:2921}'s camp. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards: keep them."] = "Les petits élémentaires dérivent dans la plaine juste à l'ouest du camp de {npc:2921}. Tout élémentaire de roche de la zone peut lâcher les Fragments d'élémentaire de roche ({item:7848}) de {npc:6868} : gardez-les.",

	-- Step 34: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elémentaires de roche ({npc:92})",
	-- {area:1878} The Dustbowl
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "Les plus gros Elémentaires de roche se tiennent sur les pentes au nord-ouest de la {area:1878} ; chacun lâche une dalle.",

	-- Step 36: Coyotes and buzzards
	["Coyotes and buzzards"] = "Coyotes et busards",
	-- {area:1878} The Dustbowl
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "Les Anciens coyotes des rochers et les Busards géants parcourent le bassin au sud de la {area:1878}. Les coyotes lâchent à la fois les mâchoires et les crocs ; seuls les busards lâchent ailes et gésiers.",

	-- Step 37: Greater Rock Elementals
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Greater Rock Elementals"] = "Elémentaires de roche supérieurs ({npc:2736})",
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["The Greater Rock Elementals (42-44, well above you) wander the gulches in the south-west; the bracers drop about one kill in five. Pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "Les Elémentaires de roche supérieurs ({npc:2736}) (42-44, bien au-dessus de vous) errent dans les ravins du sud-ouest ; les brassards tombent environ une fois sur cinq. Attirez-les un par un et reposez-vous entre les combats, ou laissez-les. Continuez à tuer en chemin les coyotes et busards qu'il vous manque.",

	-- Step 38: Kargath
	-- {area:340} Kargath
	["Ride north back to {area:340}."] = "Retournez vers le nord jusqu'à {area:340}.",

	-- Step 39: The Dustbowl
	-- {npc:2920} Lucien Tosselwrench · {item:2868} Patterned Bronze Bracers · {skill:164} Blacksmithing
	["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920} : seulement si vous avez {item:2868} ({skill:164} ou l'hôtel des ventes)",

	-- Step 41: Stonevault troggs
	["Stonevault troggs"] = "Troggs Cavepierre",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes."] = "Les troggs Cavepierre creusent autour des entrées de grottes au sud de la {area:1877}, sur le chemin de {area:345} ; les Briseurs d'os et Chamans lâchent les éclats.",

	-- Step 42: Agmond's End
	-- {area:345} Agmond's End · {area:1877} Valley of Fangs
	["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "Theldurin l’Egaré se trouve parmi les ruines naines de {area:345}, au sud de la {area:1877}.",

	-- Step 43: Valley of Fangs
	-- {npc:4618} Martek the Exiled
	["Follow the road north; {npc:4618}'s camp is on the way."] = "Suivez la route vers le nord ; le camp de {npc:4618} est sur le chemin.",

	-- Step 44: Ancient Chest
	-- {area:1517} Uldaman
	["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "Continuez vers le nord sur la route ; le coffre se trouve sur le site de fouilles d'{area:1517}, au pied des ruines au nord-ouest de la route.",

	-- Step 45: Agmond's End
	-- {area:1877} Valley of Fangs
	["Ride back south down the road, past the {area:1877}."] = "Redescendez la route vers le sud, en passant la {area:1877}.",

	-- Step 46: Hearth to Kargath
	-- {area:340} Kargath
	["Hearth to {area:340}"] = "Pierre de foyer vers {area:340}",

	-- Step 47: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202}."] = "Prenez le zeppelin d'{zone:1454} à la tour à l'ouest de {object:3202}.",
	["Zeppelin tower"] = "Tour du zeppelin",

	-- Step 49: Thunder Bluff
	-- {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:380} Crossroads
	["Your trainer is in {area:1638}, one flight from {zone:1454}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to the {area:380} from there."] = "Votre maître est à {area:1638}, à un vol d'{zone:1454} : {npc:3033} (druides) sur la {area:1639}, {npc:246344} (paladins). De là, volez jusqu'à {area:380}.",

	-- Step 51: Regthar Deathgate
	-- {area:380} Crossroads · {area:386} Forgotten Pools · {npc:3389} Regthar Deathgate
	["Ride north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "Remontez la route vers le nord depuis {area:380} jusqu'aux {area:386} ; {npc:3389} Seuil-de-mort monte la garde sur l'élévation au-dessus de l'eau.",
	-- {npc:5395} Felgur Twocuts · {zone:1443} Desolace
	["for {npc:5395} in {zone:1443}, in the next guide"] = "pour {npc:5395} en {zone:1443}, dans le prochain guide",

	-- Step 52: Ratchet
	-- {area:380} Crossroads · {area:392} Ratchet
	["Ride back south to the {area:380} and fly to {area:392}."] = "Retournez vers le sud jusqu'à {area:380} et volez jusqu'à {area:392}.",
	-- {item:3713} Soothing Spices · {zone:1445} Dustwallow Marsh
	["{item:3713}, for \"Swamp Eye\" Jarl in {zone:1445}"] = "{item:3713}, pour Jarl « Oeil-des-marais » au {zone:1445}",
	-- {zone:1445} Dustwallow Marsh
	["The next guide heads into {zone:1445}."] = "Le prochain guide part vers le {zone:1445}.",

	-- Step 53: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Longez la côte vers le sud de {area:392} jusqu'à l'{area:720}. {npc:6236} se tient près de l'arène : marchez sur la grille pour lancer le combat ; les adversaires arrivent un par un, puis {npc:6238} (33).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride west along the road; Lotwil's camp sits in the {area:1878} halfway to {area:340}."] = "Chevauchez vers l'ouest sur la route ; le camp de Lotwil se trouve dans la {area:1878}, à mi-chemin de {area:340}.",
	-- ["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "Les Anciens coyotes des rochers ({npc:2729}) et les Busards géants ({npc:2831}) parcourent le bassin au sud de la {area:1878}. Les coyotes lâchent à la fois les mâchoires et les crocs ; seuls les busards lâchent ailes et gésiers.",
	-- ["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "Les plus gros Elémentaires de roche ({npc:92}) se tiennent sur les pentes au nord-ouest de la {area:1878} ; chacun lâche une dalle.",
	-- ["The {area:380}"] = "{area:380}",
}
