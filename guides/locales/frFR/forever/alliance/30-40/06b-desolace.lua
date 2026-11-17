-- French (frFR): the guide forever/alliance/30-40/06b-desolace (forever/alliance/30-40/06b-desolace.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1443} Desolace
	["Kodo bones, demons and lost treasure in south {zone:1443}."] = "Os de kodo, démons et trésor perdu dans le sud de {zone:1443}.",
	["Short: about one level of quests"] = "Court : environ un niveau de quêtes",
	-- {zone:1434} Stranglethorn Vale
	["Then on to {zone:1434}"] = "Ensuite, direction {zone:1434}",
	["Stays on the main route"] = "Reste sur l'itinéraire principal",
	["A long trip out to Kalimdor"] = "Un long voyage jusqu'en Kalimdor",

	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Prendre un vol pour {area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maître de vol de {area:144}",

	-- Step 3: Theramore flight master
	["Theramore flight master"] = "Maître de vol de Theramore",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "En descendant du bateau, remontez la jetée jusqu'à Baldruc, le maître de vol près de la porte de {area:514}.",

	-- Step 4: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {npc:11863} Azore Aldamort
	["{npc:5638}, if 30-40/02 didn't take it: the wreck lies below {npc:11863}'s tower"] = "{npc:5638}, si 30-40/02 ne l'a pas prise : l'épave se trouve sous la tour d'{npc:11863}",
	-- {npc:5396} Captain Pentigast
	["{npc:5396}, if 30-40/02 didn't give it"] = "{npc:5396}, si 30-40/02 ne vous l'a pas donnée",

	-- Step 5: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Suivez la route vers le sud jusqu'à {area:2407}.",

	-- Step 6: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019} se tient en bordure de {area:596}, au sud-ouest de {area:2407} ; des {object:176751} gisent parmi les squelettes.",

	-- Step 7: Hornizz Brimbuzzle
	-- {quest:6134} Ghost-o-plasm Round Up · {area:2657} Valley of Bones
	-- plural, as words: Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:6134}'s magnets draw the Magrami Spectres a few yards from the Magram Necrokhans and Corpsefeeders (45, elite) in the {area:2657}. Skip it if you are alone."] = "Ce sont des monstres élites : il est conseillé de former un groupe, cherchez des joueurs avec qui la faire. Les aimants de {quest:6134} attirent les Spectres magrami à quelques mètres des Nécrokhans magram et des Dévoreurs de cadavres (45, élites) dans la {area:2657}. Passez-la si vous êtes seul.",

	-- Step 8: Flesh Picker
	-- {npc:217590} Flesh Picker · {area:596} Kodo Graveyard · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s {item:213565}."] = "Un {npc:217590} rampe dans {area:596} : attrapez-en un avec l'outil du {item:213565} de {npc:217412}.",

	-- Step 9: Maraudine centaurs
	["Maraudine centaurs"] = "Centaures maraudine",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Les centaures maraudine tiennent {area:607}, à l'ouest du cimetière ; tous lâchent les totems.",

	-- Step 10: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} est retenue dans le camp de centaures à l'ouest du cimetière. Libérez-la et gardez-la en vie pendant la sortie ; elle s'arrête près du cimetière.\nAttention : les groupes scriptés sont liés et n'apparaissent que pendant l'escorte : vous ne pouvez ni les éliminer à l'avance ni les attirer un par un. Éliminer les centaures normaux sur le chemin avant de commencer aide quand même.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "escortez {npc:12277} jusqu'au cimetière",

	-- Step 11: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {npc:5760} Lord Azrethoc
	-- plural, as words: Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}. Nether Maidens (37-38) hold its north-west side and drop the wings; Doomwarder Captains (38) stand at the south end and drop the blood.\nCareful: Nether Sorceresses (39-40) stand beside the Doomwarder Captains, and {npc:5760}, a level 40 elite, walks the coven's middle: pull the captains away from them. Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Les démons se rassemblent au {area:602}, dans le sud de {zone:1443}. Les Vierges du néant (37-38) tiennent le côté nord-ouest et lâchent les ailes ; les Capitaines de la Garde funeste (38) se tiennent à l'extrémité sud et lâchent le sang.\nAttention : des Ensorceleuses du Néant (39-40) se tiennent à côté des Capitaines de la Garde funeste, et le {npc:5760}, un élite de niveau 40, arpente le milieu du convent : attirez les capitaines loin d'eux. La plupart des monstres ici patrouillent, vous pouvez donc facilement en attirer d'autres.",
	-- {item:6251} Nether Wing
	-- plural, as words: Nether Maidens = {npc:4679} Nether Maiden
	["{item:6251}, from the Nether Maidens"] = "{item:6251}, sur les Vierges du néant",
	-- {item:6252} Doomwarder Blood
	-- plural, as words: Doomwarder Captains = {npc:4680} Doomwarder Captain
	["{item:6252}, from the Doomwarder Captains"] = "{item:6252}, sur les Capitaines de la Garde funeste",

	-- Step 12: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magram Necrokhans = {npc:253274} Magram Necrokhan · Magram Necromancers = {npc:253272} Magram Necromancer
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields further east, with Magram Necromancers (42): pull the Ravagers to you, away from them."] = "Des Ravageurs morts-vivants parcourent les champs d'ossements au sud du village des Magram, à l'est du Convent : la flèche mène à leur bord ouest. Attention : des Nécrokhans magram et des Dévoreurs de cadavres (45, élites) arpentent les champs d'ossements plus à l'est, avec des Nécromanciens magram (42) : attirez les Ravageurs vers vous, loin d'eux.",

	-- Step 13: The ghost magnets
	["The ghost magnets"] = "Les aimants fantômes",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Magrami Spectres = {npc:11560} Magrami Spectre
	["Use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres; the Necrokhans and Corpsefeeders (45, elite) walk close by: keep the group together."] = "Utilisez la {item:15848} à sa flèche, du côté est des champs, pour attirer les Spectres magrami ; les Nécrokhans et les Dévoreurs de cadavres (45, élites) passent tout près : gardez le groupe groupé.",

	-- Step 14: Mannoroc Coven
	-- {npc:5760} Lord Azrethoc
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Mage Hunters = {npc:4681} Mage Hunter
	["Back at the coven on the way west: the Mana Eaters (37-38) on its north edge and the Mage Hunters (38-39) further in drop the brains. {npc:5760} (40, elite) walks among the Mage Hunters: pull them out to you."] = "De retour au convent en allant vers l'ouest : les Mange-mana (37-38) au bord nord et les Chasseurs de mages (38-39) plus à l'intérieur lâchent les cerveaux. Le {npc:5760} (40, élite) circule parmi les Chasseurs de mages : attirez-les vers vous.",

	-- Step 17: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Suivez la route vers l'ouest à travers le nord de {zone:1443} jusqu'aux ruines d'{area:2405}. La tour d'{npc:11863} se dresse sur la colline, sur le chemin de l'épave.",
	-- {npc:11863} Azore Aldamort · {quest:93464} The Visiting Mage · {zone:1435} Swamp of Sorrows
	["{npc:11863}: {quest:93464}, from Magtoor in the {zone:1435}"] = "{npc:11863} : {quest:93464}, de Magtoor dans le {zone:1435}",

	-- Step 18: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "Le coffre du navire échoué se trouve juste au sud-ouest de la tour d'{npc:11863}.",

	-- Step 19: Claim Rackmore's Treasure!
	-- {object:177787} Rackmore's Log · {object:35251} Karnitol's Chest · {zone:1443} Desolace
	["{object:177787} lies beside {object:35251}, if you didn't take it on your first {zone:1443} visit. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "Le {object:177787} se trouve à côté du {object:35251}, si vous ne l'avez pas pris lors de votre première visite à {zone:1443}. Sa clé en argent est lâchée par les crabes Claquesec autour de l'épave ; la clé en or provient des nagas Ondulame de la côte nord-ouest, ensuite.",
	-- {object:177787} Rackmore's Log
	["{object:177787}, if 30-40/02 didn't take it"] = "{object:177787}, si 30-40/02 ne l'a pas pris",
	["Underwater"] = "Sous l'eau",

	-- Step 20: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598} : tuez-les au passage",
	-- {npc:11863} Azore Aldamort · {area:2406} Ranazjar Isle · {item:15766} Gem of the Serpent · {object:177673} Serpent Statue · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "Les nagas Ondulame tiennent la côte nord-ouest au nord de la tour d'{npc:11863} ; la sacoche de Karnitol gît au fond de la mer, au large, et n'importe quel naga peut lâcher la clé en or de Rackmore. Nagez jusqu'à {area:2406}, au large de la pointe nord, et utilisez la {item:15766} sur la {object:177673} : {npc:12369} (38) surgit ; tuez-le pour le {quest:6027}.",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}, sur les nagas Ondulame",
	-- {item:15766} Gem of the Serpent · {object:177673} Serpent Statue
	["{item:15766}, on the {object:177673}"] = "{item:15766}, sur la {object:177673}",

	-- Step 21: Rackmore's Chest
	-- {object:177673} Serpent Statue
	["Rackmore's chest lies just south-east of the {object:177673}."] = "Le coffre de Rackmore se trouve juste au sud-est de la {object:177673}.",

	-- Step 24: Nijel's Point
	-- {area:608} Nijel's Point · {npc:5396} Captain Pentigast · {npc:5638} Kreldig Ungor · {npc:1182} Brother Anton
	["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "Suivez la route vers le nord jusqu'à {area:608} : {npc:5396} se tient à l'extrémité sud, {npc:5638} au milieu, {npc:1182} au nord.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "pour {npc:5637} à {zone:1455} : gardez-la",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "pour {npc:3980} à {area:271} : gardez-la",

	-- Step 25: Fly to Theramore
	["Fly to Theramore"] = "Volez jusqu'à Theramore",
	["The next guide starts in Theramore."] = "Le guide suivant commence à Theramore.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Les démons se rassemblent au {area:602}, dans le sud de {zone:1443} : des chiens corrompus (Mange-mana, Chasseurs de mages et Chasseurs Ley), des Vierges du néant et des Sœurs du néant, et des Capitaines de la Garde funeste autour de la fosse.\nAttention : la plupart des monstres ici suivent des trajets de patrouille : vous pouvez facilement attirer des monstres en plus.",
	-- ["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Then use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields between the two arrows, with Magram Necromancers (42): pull the Ravagers and the spectres to you, away from them."] = "Des Ravageurs morts-vivants parcourent les champs d'ossements au sud du village des Magram, à l'est du Convent : la flèche mène à leur bord ouest. Utilisez ensuite la {item:15848} à sa flèche, du côté est des champs, pour attirer les Spectres magrami. Attention : des Nécrokhans magram et des Dévoreurs de cadavres (45, élites) arpentent les champs d'ossements entre les deux flèches, avec des Nécromanciens magram (42) : attirez les Ravageurs et les spectres vers vous, loin d'eux.",
	-- ["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787} se trouve à côté de {object:35251}. Sa clé en argent est lâchée par les crabes Claquesec autour de l'épave ; la clé en or provient des nagas Ondulame de la côte nord-ouest, ensuite.",
}
