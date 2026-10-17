-- French (frFR): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Revenez vers l'ouest jusqu'à la route et suivez-la vers le sud hors du {zone:1432}, par le col, jusqu'aux {zone:1418}. {npc:2910} et {npc:2860} campent côte à côte sur le site de fouilles.",

	-- Step 2: Shadowforge camp
	["Shadowforge camp"] = "Camp Ombreforge",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "Les nains Ombreforge campent juste au nord du site de fouilles ; la carte froissée se trouve parmi leurs tentes. Les Tunneliers Ombreforge et les Tisseurs d'ombre Ombreforge portent la pioche de Ryedol. Des Coyotes des rochers parcourent les pentes alentour.",

	-- Step 3: The excavation crate
	["The excavation crate"] = "La caisse d'excavation",
	["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Partez au nord-est vers le site de fouilles abandonné ; la caisse de ravitaillement s'y trouve, parmi les ogres Crache-poussières.",

	-- Step 4: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "La mission suivante de Ryedol mène à {area:1517} : passez-la.",

	-- Step 5: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618} et {npc:2817} campent ensemble dans {area:1877}, au milieu des {zone:1418}.",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "Les palourdes se trouvent sur la côte nord-ouest de Strangleronce, dans le guide suivant : gardez-la",

	-- Step 6: Ogres and buzzards
	["Ogres and buzzards"] = "Ogres et busards",
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "Les ogres Crache-poussières campent juste au sud de la vallée ; chacun d'eux lâche des morceaux de métal. Des busards tournoient au-dessus de la plaine à l'est.",

	-- Step 7: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "Le squelette de nain décrépi se trouve juste à l'est des ogres, en bordure du camp des troggs Cavepierre ; les Briseurs d'os Cavepierre et les Chamans Cavepierre alentour lâchent les flocons. Theldurin est assis près du camp en ruine plus au sud.",
	-- {zone:1418} Badlands
	["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "La tâche suivante du squelette, Murdaloc, attend le guide des {zone:1418} suivant, au niveau 43.",

	-- Step 8: Valley of Fangs
	-- {npc:4454} Fizzle Brassbolts · {area:439} Shimmering Flats · {zone:1446} Tanaris
	["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "pour {npc:4454} à {area:439} : le guide de {zone:1446} y passe au niveau 45, gardez-la",

	-- Step 9: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Partez à l'ouest dans {area:1878} ; {npc:2921} travaille près de ses machines, en son milieu.",

	-- Step 10: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elémentaires de roche inférieurs",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "Les Elémentaires de roche inférieurs errent dans {area:1878}, à l'ouest de {npc:2921}.",

	-- Step 12: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elémentaires de roche",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Les Elémentaires de roche ({npc:92}) errent au sud-est de {npc:2921} ; Busards géants ({npc:2831}) et Anciens coyotes des rochers ({npc:2729}) se partagent la plaine à leur ouest.",

	-- Step 14: Greater Rock Elementals
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Greater Rock Elementals"] = "Elémentaires de roche supérieurs",
	-- {area:342} Camp Boff
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental · Dustbelcher Wyrmhunters = {npc:2716} Dustbelcher Wyrmhunter
	["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "Les Elémentaires de roche supérieurs (niveau 42) arpentent l'extrême sud-ouest, sous {area:342} ; attirez-les un par un. Les Chasseurs Wyrm Crache-poussières et les Marteleurs Crache-poussières de {area:342} lâchent aussi des morceaux de métal.",

	-- Step 15: Lotwil Veriatus
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, à côté de {npc:2921}",
	-- {item:2868} Patterned Bronze Bracers
	["only if you carry {item:2868} (a blacksmith's craft)"] = "seulement si vous avez des {item:2868} (fabriqués par un forgeron)",
	-- {npc:2921} Lotwil Veriatus
	["{npc:2921}'s next test needs crafted gear: skip it."] = "Le test suivant de {npc:2921} demande de l'équipement fabriqué : passez-le.",

	-- Step 16: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {zone:1418} Badlands · {npc:2745} Ambassador Infernus
	["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Partez au nord-est vers les ruines naines au nord des {zone:1418} ; le coffre se trouve parmi les nains Ombreforge. {npc:2745}, tout près, est élite : gardez vos distances.",

	-- Step 18: Theldurin the Lost
	-- {area:345} Agmond's End
	["Ride south to {area:345}."] = "Partez au sud jusqu'à {area:345}.",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "pour {npc:2786} à {zone:1455} : gardez-la",

	-- Step 19: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn"] = "{npc:1470}, à l'auberge",

	-- Step 20: Menethil Harbor
	["Take the boat to Theramore from the far pier."] = "Prenez le bateau pour Theramore au quai le plus éloigné.",

	-- Step 21: Theramore
	["Theramore"] = "Theramore",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "Le maître de vol se tient près de la porte de {area:514} ; {npc:5083} et {npc:4964} sont dans la citadelle.",
	["for the Dustwallow loop in the next guide"] = "pour la boucle du marécage d'Âprefange, dans le guide suivant",

	-- Step 23: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Suivez la route vers l'ouest à travers le nord de {zone:1443} jusqu'aux ruines d'{area:2405}. La tour d'{npc:11863} se dresse sur la colline, sur le chemin de l'épave.",

	-- Step 24: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "Le coffre du navire échoué se trouve sur le rivage, juste à l'ouest de la tour d'{npc:11863}.",

	-- Step 25: Lord Kragaru
	-- {npc:12369} Lord Kragaru · {npc:11863} Azore Aldamort
	["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}, un chef centaure, campe sur la côte nord-ouest, au nord de la tour d'{npc:11863}.",

	-- Step 27: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {item:6245} Karnitol's Satchel
	["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "La tâche suivante de {npc:5638}, {item:6245}, est un butin sur la côte lointaine : passez-la.",

	-- Step 28: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Suivez la route vers le sud jusqu'à {area:2407}.",

	-- Step 29: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones · {npc:217590} Flesh Picker
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019} se tient en bordure de {area:596}, au sud-ouest de {area:2407} ; des {object:176751} gisent parmi les squelettes. Un {npc:217590} rampe dans le cimetière : attrapez-en un avec le Entomology Starter Kit, puis cochez-le.",
	-- {npc:217590} Flesh Picker
	["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590} : attrapez-le, pour My Little Friends",

	-- Step 30: Maraudine centaurs
	["Maraudine centaurs"] = "Centaures maraudine",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Les centaures maraudine tiennent {area:607}, à l'ouest du cimetière ; tous lâchent les totems.",

	-- Step 31: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277} est retenue dans le camp centaure à l'ouest du cimetière. Libérez-la et gardez-la en vie pendant la sortie ; elle s'arrête près du cimetière.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "escortez {npc:12277} jusqu'au cimetière",

	-- Step 33: Gizelton Caravan
	-- {npc:11626} Rigger Gizelton · {area:606} Gelkis Village · {area:602} Mannoroc Coven · {npc:11596} Smeed Scrabblescrew · {area:596} Kodo Graveyard
	["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "La caravane de {npc:11626} s'arrête sur la route à l'est de {area:606}. Prenez la quête et accompagnez les kodos après {area:602}, en tuant les démons qui les attaquent ; parlez ensuite à {npc:11596}, à son camp à l'est de {area:596}.",

	-- Step 34: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "Les démons se rassemblent à {area:602}, au sud de {zone:1443} : gangrechiens (Mange-mana, Chasseurs de mages et Chasseurs Ley), Vierges du néant et Sœurs du néant, et Capitaines de la Garde funeste autour de la fosse.",

	-- Step 35: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "Des Ravageurs morts-vivants parcourent les champs d'ossements au sud du Village des Magram, à l'est du Convent de Mannoroc ; à l'extrême sud-est, utilisez la {item:15848} pour attirer les Spectres magrami.",

	-- Step 38: Nijel's Point
	-- {area:608} Nijel's Point
	["Follow the road north to {area:608}."] = "Suivez la route vers le nord jusqu'à {area:608}.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "pour {npc:5637} à {zone:1455} : gardez-la",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "pour {npc:3980} à {area:271} : gardez-la",

	-- Step 39: Fly to Theramore
	["Fly to Theramore"] = "Volez jusqu'à Theramore",
	["The next guide starts in Theramore."] = "Le guide suivant commence à Theramore.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "Suivez la route vers l'ouest à travers le nord de {zone:1443} jusqu'aux ruines d'{area:2405} ; le coffre du navire échoué se trouve sur le rivage, juste à l'ouest.",
	-- ["{item:7337} Elementals roam south-east of Lotwil; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Les Elémentaires de roche ({item:7337}) rôdent au sud-est de Lotwil ; des Busards géants et des Anciens coyotes des rochers occupent la plaine à leur ouest.",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "La tour d'{npc:11863} se dresse sur la colline à l'est de l'épave.",
}
