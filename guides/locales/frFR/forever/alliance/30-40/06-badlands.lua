-- French (frFR): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "Vers les {zone:1418}",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Head back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Retournez vers l'ouest jusqu'à la route et suivez-la vers le sud hors du {zone:1432}, par le col, jusqu'aux {zone:1418}. {npc:2910} et {npc:2860} campent côte à côte au site de fouilles.",

	-- Step 4: Hammertoe's Digsite: kill these as you meet them
	-- {area:346} Hammertoe's Digsite
	["{area:346}: kill these as you meet them"] = "{area:346} : tuez-les au passage",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "Les nains Ombreforge campent juste au nord du site de fouilles ; la carte froissée se trouve parmi leurs tentes. Les Tunneliers Ombreforge et les Tisseurs d'ombre Ombreforge portent la pioche de Ryedol. Des Coyotes des rochers parcourent les pentes alentour.",

	-- Step 5: The excavation crate
	["The excavation crate"] = "La caisse d'excavation",
	["Head north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Allez au nord-est jusqu'au site de fouilles abandonné ; la caisse de ravitaillement s'y trouve, parmi les ogres Crache-poussières.",

	-- Step 6: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "La mission suivante de Ryedol mène à {area:1517} : passez-la.",

	-- Step 7: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618} et {npc:2817} campent ensemble dans {area:1877}, au milieu des {zone:1418}.",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "Les palourdes se trouvent sur la côte nord-ouest de Strangleronce, dans le guide suivant : gardez-la",

	-- Step 8: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "Le squelette abîmé se trouve juste à l'est des ogres, en bordure du camp des troggs Cavepierre ; les Briseurs d'os et les Chamans alentour lâchent les éclats. Theldurin est assis près du camp en ruine plus au sud.",

	-- Step 9: Agmond's End: kill these as you meet them
	-- {area:345} Agmond's End
	["{area:345}: kill these as you meet them"] = "{area:345} : tuez-les au passage",
	-- {quest:739} Murdaloc · {spell:5242} Battle Shout · {spell:1160} Demoralizing Shout · {area:340} Kargath
	-- plural, as words: Dustbelcher Lords = {npc:2719} Dustbelcher Lord
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east.\nThe battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers.\nCareful: Dustbelcher Lords are level 44-45. They use {spell:5242} and {spell:1160}, and below 50% health they call for help from allies within 15 yd. Seven of them stand about 750 yd south of {area:340}."] = "",
	-- {quest:739} Murdaloc · {zone:1418} Badlands
	["{quest:739} himself (42) walks among the Bonesnappers: leave him for the later {zone:1418} guide at 43, and kill the Bonesnappers for this quest now."] = "",

	-- Step 10: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Head west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Allez vers l'ouest dans {area:1878} ; {npc:2921} travaille près de ses machines, au milieu.",

	-- Step 11: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elémentaires de roche inférieurs ({npc:2735})",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus · {npc:1470} Ghak Healtouch
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}; every rock elemental can drop {npc:1470}'s Rock Elemental Shards."] = "",

	-- Step 13: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {zone:1418} Badlands · {npc:2745} Ambassador Infernus
	["Head north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Allez au nord-est jusqu'aux ruines naines au nord des {zone:1418} ; le coffre se trouve parmi les nains Ombreforge. {npc:2745}, tout près, est un élite : gardez vos distances.",
	-- {item:4631} Tablet of Ryun'eh
	["{item:4631}; below ground"] = "{item:4631} ; sous terre",

	-- Step 14: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {area:345} Agmond's End
	["Head south down the road: {npc:4618} and {npc:2817} camp in the {area:1877}, on the way to {area:345}."] = "",
	-- {npc:4454} Fizzle Brassbolts · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["For {npc:4454} at the {area:2240}: the {zone:1446} guide passes him at 45, keep it"] = "",

	-- Step 15: Theldurin the Lost
	-- {area:345} Agmond's End
	["Head south to {area:345}."] = "Allez au sud jusqu'à {area:345}.",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "pour {npc:2786} à {zone:1455} : gardez-la",

	-- Step 16: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elémentaires de roche",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Les Elémentaires de roche ({npc:92}) errent au sud-est de {npc:2921} ; Busards géants ({npc:2831}) et Anciens coyotes des rochers ({npc:2729}) se partagent la plaine à leur ouest.",

	-- Step 17: Lotwil Veriatus
	-- {npc:2921} Lotwil Veriatus · {item:4628} Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s last test is optional: five {item:4628}, which only the Greater Rock Elementals (42-44) in the south-western gulches drop, about one kill in five, well above your level. Take it only if you can handle them one at a time; otherwise hand in the slabs and move on."] = "",

	-- Step 18: Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["South-west into the gulches: only the Greater Rock Elementals there drop the bracers."] = "",

	-- Step 20: Lucien Tosselwrench
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus · {item:2868} Patterned Bronze Bracers
	["{npc:2920}, beside {npc:2921}, trades for {item:2868}, a blacksmith's craft: this step shows only when you carry a pair."] = "",
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, à côté de {npc:2921}",

	-- Step 21: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "Vers {area:2101}",

	-- Step 22: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn; below ground"] = "{npc:1470}, dans l'auberge ; sous terre",

	-- Step 23: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Prendre un vol pour {area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maître de vol de {area:144}",

	-- Step 25: Theramore flight master
	["Theramore flight master"] = "Maître de vol de Theramore",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "",

	-- Step 26: Nijel's Point
	-- {npc:5638} Kreldig Ungor
	["{npc:5638}: the wreck is on the north-west coast, at the end of the loop"] = "",

	-- Step 27: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Suivez la route vers le sud jusqu'à {area:2407}.",

	-- Step 28: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones · {npc:217590} Flesh Picker
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019} se tient en bordure de {area:596}, au sud-ouest de {area:2407} ; des {object:176751} gisent parmi les squelettes. Un {npc:217590} rampe dans le cimetière : attrapez-en un avec le Entomology Starter Kit, puis cochez-le.",
	-- {npc:217590} Flesh Picker
	["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590} : attrapez-le, pour My Little Friends",

	-- Step 29: Maraudine centaurs
	["Maraudine centaurs"] = "Centaures maraudine",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Les centaures maraudine tiennent {area:607}, à l'ouest du cimetière ; tous lâchent les totems.",

	-- Step 30: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} est retenue dans le camp de centaures à l'ouest du cimetière. Libérez-la et gardez-la en vie pendant la sortie ; elle s'arrête près du cimetière.\nAttention : les groupes scriptés sont liés et n'apparaissent que pendant l'escorte : vous ne pouvez ni les éliminer à l'avance ni les attirer un par un. Éliminer les centaures normaux sur le chemin avant de commencer aide quand même.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "escortez {npc:12277} jusqu'au cimetière",

	-- Step 31: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Les démons se rassemblent au {area:602}, dans le sud de {zone:1443} : des chiens corrompus (Mange-mana, Chasseurs de mages et Chasseurs Ley), des Vierges du néant et des Sœurs du néant, et des Capitaines de la Garde funeste autour de la fosse.\nAttention : la plupart des monstres ici suivent des trajets de patrouille : vous pouvez facilement attirer des monstres en plus.",

	-- Step 32: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "Des Ravageurs morts-vivants parcourent les champs d'ossements au sud du Village des Magram, à l'est du Convent de Mannoroc ; à l'extrême sud-est, utilisez la {item:15848} pour attirer les Spectres magrami.",

	-- Step 35: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Suivez la route vers l'ouest à travers le nord de {zone:1443} jusqu'aux ruines d'{area:2405}. La tour d'{npc:11863} se dresse sur la colline, sur le chemin de l'épave.",

	-- Step 36: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "Le coffre du navire échoué se trouve sur le rivage, juste à l'ouest de la tour d'{npc:11863}.",

	-- Step 37: Claim Rackmore's Treasure!
	["Underwater"] = "Sous l'eau",

	-- Step 38: Nijel's Point
	-- {area:608} Nijel's Point
	["Follow the road north to {area:608}."] = "Suivez la route vers le nord jusqu'à {area:608}.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "pour {npc:5637} à {zone:1455} : gardez-la",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "pour {npc:3980} à {area:271} : gardez-la",

	-- Step 39: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598} : tuez-les au passage",
	-- {npc:12369} Lord Kragaru · {npc:11863} Azore Aldamort
	["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}, un chef centaure, campe sur la côte nord-ouest, au nord de la tour d'{npc:11863}.",

	-- Step 44: Fly to Theramore
	["Fly to Theramore"] = "Volez jusqu'à Theramore",
	["The next guide starts in Theramore."] = "Le guide suivant commence à Theramore.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "Suivez la route vers l'ouest à travers le nord de {zone:1443} jusqu'aux ruines d'{area:2405} ; le coffre du navire échoué se trouve sur le rivage, juste à l'ouest.",
	-- ["Greater Rock Elementals"] = "Elémentaires de roche supérieurs",
	-- ["Hearth to {area:2101}"] = "Pierre de foyer vers {area:2101}",
	-- ["Hearth to {area:608}"] = "Pierre de foyer vers {area:608}",
	-- ["Lesser Rock Elementals"] = "Elémentaires de roche inférieurs",
	-- ["Ogres and buzzards"] = "Ogres et busards",
	-- ["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Revenez vers l'ouest jusqu'à la route et suivez-la vers le sud hors du {zone:1432}, par le col, jusqu'aux {zone:1418}. {npc:2910} et {npc:2860} campent côte à côte sur le site de fouilles.",
	-- ["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Partez au nord-est vers le site de fouilles abandonné ; la caisse de ravitaillement s'y trouve, parmi les ogres Crache-poussières.",
	-- ["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Partez au nord-est vers les ruines naines au nord des {zone:1418} ; le coffre se trouve parmi les nains Ombreforge. {npc:2745}, tout près, est élite : gardez vos distances.",
	-- ["Ride south to {area:345}."] = "Partez au sud jusqu'à {area:345}.",
	-- ["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Partez à l'ouest dans {area:1878} ; {npc:2921} travaille près de ses machines, en son milieu.",
	-- ["Shadowforge camp"] = "Camp Ombreforge",
	-- ["Take the boat to Theramore from the far pier."] = "Prenez le bateau pour Theramore au quai le plus éloigné.",
	-- ["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "Les ogres Crache-poussières campent juste au sud de la vallée ; chacun d'eux lâche des morceaux de métal. Des busards tournoient au-dessus de la plaine à l'est.",
	-- ["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east.\nThe battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers.\nThe Lesser Rock Elementals wander the {area:1878} west of {npc:2921}.\nCareful: Dustbelcher Lords are level 44-45. They use {spell:5242} and {spell:1160}, and below 50% health they call for help from allies within 15 yd. Seven of them stand about 750 yd south of {area:340}."] = "Les ogres Crache-poussières campent juste au sud de la vallée ; tous lâchent de la ferraille. Des busards tournoient au-dessus de la plaine à l'est.\nLe squelette abîmé se trouve en bordure du camp des troggs Cavepierre ; {quest:739}, le meurtrier d'Agmond, rôde parmi les Briseurs d'os.\nLes Élémentaires de roche inférieurs errent dans {area:1878} à l'ouest de {npc:2921}.\nAttention : les Seigneurs Crache-poussières sont de niveau 44-45. Ils utilisent {spell:5242} et {spell:1160}, et sous 50 % de vie ils appellent à l'aide les alliés dans un rayon de 15 m. Sept d'entre eux se tiennent à environ 750 m au sud de {area:340}.",
	-- ["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "Les Elémentaires de roche supérieurs (niveau 42) arpentent l'extrême sud-ouest, sous {area:342} ; attirez-les un par un. Les Chasseurs Wyrm Crache-poussières et les Marteleurs Crache-poussières de {area:342} lâchent aussi des morceaux de métal.",
	-- ["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "Les Elémentaires de roche inférieurs errent dans {area:1878}, à l'ouest de {npc:2921}.",
	-- ["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "Le squelette de nain décrépi se trouve juste à l'est des ogres, en bordure du camp des troggs Cavepierre ; les Briseurs d'os Cavepierre et les Chamans Cavepierre alentour lâchent les flocons. Theldurin est assis près du camp en ruine plus au sud.",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "Les démons se rassemblent à {area:602}, au sud de {zone:1443} : gangrechiens (Mange-mana, Chasseurs de mages et Chasseurs Ley), Vierges du néant et Sœurs du néant, et Capitaines de la Garde funeste autour de la fosse.",
	-- ["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "Le maître de vol se tient près de la porte de {area:514} ; {npc:5083} et {npc:4964} sont dans la citadelle.",
	-- ["The next guide starts in Theramore."] = "Le guide suivant commence à Theramore.",
	-- ["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "La tâche suivante du squelette, Murdaloc, attend le guide des {zone:1418} suivant, au niveau 43.",
	-- ["The skeleton's next task, {quest:739}, waits until the later {area:3} guide at 43."] = "La tâche suivante du squelette, {quest:739}, attend le guide des {area:3} suivant, au niveau 43.",
	-- ["Theramore"] = "Theramore",
	-- ["for the Dustwallow loop in the next guide"] = "pour la boucle du marécage d'Âprefange, dans le guide suivant",
	-- ["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "pour {npc:4454} à {area:439} : le guide de {zone:1446} y passe au niveau 45, gardez-la",
	-- ["only if you carry {item:2868} (a blacksmith's craft)"] = "seulement si vous avez des {item:2868} (fabriqués par un forgeron)",
	-- ["{item:5797} on the way"] = "{item:5797} en chemin",
	-- ["{item:7337} Elementals roam south-east of Lotwil; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Les Elémentaires de roche ({item:7337}) rôdent au sud-est de Lotwil ; des Busards géants et des Anciens coyotes des rochers occupent la plaine à leur ouest.",
	-- ["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "La caravane de {npc:11626} s'arrête sur la route à l'est de {area:606}. Prenez la quête et accompagnez les kodos après {area:602}, en tuant les démons qui les attaquent ; parlez ensuite à {npc:11596}, à son camp à l'est de {area:596}.",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "La tour d'{npc:11863} se dresse sur la colline à l'est de l'épave.",
	-- ["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277} est retenue dans le camp centaure à l'ouest du cimetière. Libérez-la et gardez-la en vie pendant la sortie ; elle s'arrête près du cimetière.",
	-- ["{npc:1470}, in the inn"] = "{npc:1470}, à l'auberge",
	-- ["{npc:2893} on the way"] = "{npc:2893} en chemin",
	-- ["{npc:2921}'s next test needs crafted gear: skip it."] = "Le test suivant de {npc:2921} demande de l'équipement fabriqué : passez-le.",
	-- ["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {area:3}."] = "{npc:4618} et {npc:2817} campent ensemble dans la {area:1877}, au milieu des {area:3}.",
	-- ["{npc:4964}, on the top floor"] = "{npc:4964}, au dernier étage",
	-- ["{npc:5083}, on the top floor"] = "{npc:5083}, au dernier étage",
	-- ["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "La tâche suivante de {npc:5638}, {item:6245}, est un butin sur la côte lointaine : passez-la.",
}
