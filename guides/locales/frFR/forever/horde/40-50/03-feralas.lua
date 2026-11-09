-- French (frFR): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
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

	-- Step 2: Apothecary Zinge
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "",

	-- Step 3: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}, dans le {object:36126}",

	-- Step 4: Riding at 40
	["Riding at 40"] = "Monte au niveau 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, maître de monte",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Chevaux squelettes : {npc:4731}, à côté de {npc:4773} à {area:159}.",

	-- Step 5: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zeppelin pour {object:3202}",

	-- Step 6: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Prendre un vol pour {area:75}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Maître de vol de Grom'gol",

	-- Step 7: Stonard
	-- {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["Coming from Stranglethorn, you carry these already. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, à l'intérieur",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, au dernier étage",

	-- Step 8: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Suivez la route vers l'ouest ; le parchemin se trouve au bord de l'eau, à l'extrême ouest du marais.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, later in this guide"] = "pour le {object:2555} à {zone:1445}, plus loin dans ce guide",

	-- Step 9: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocilisques Dents-de-scie",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "",

	-- Step 10: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "Retournez à l'est après {area:75} : les Artefacts atal'ai se trouvent dans l'eau et sur les rives du Bassin des larmes (quête {quest:1424}).",

	-- Step 11: Misty Reed Post
	-- {npc:5592} Tok'Kar
	["Follow the road south-east to the small Horde post on the shore. {npc:5592} takes the crocolisk flanks from the last swamp visit."] = "",

	-- Step 12: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "{area:2403} : tuez-les au passage",
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too."] = "",
	["Underwater"] = "Sous l'eau",

	-- Step 14: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "Les murlocs de Misty Reed",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Les Murlocs des marais vivent sur la grève au sud du poste ; les Crache-encre sont le long du rivage à l'est et les Mange-chair plus à l'ouest, autour des huttes de la rive ouest.",
	["Below ground"] = "Sous terre",

	-- Step 16: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "",

	-- Step 18: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "pour l'{npc:5598} dans {zone:1425}, vers le niveau 48",

	-- Step 19: To Camp Mojache
	-- {area:1099} Camp Mojache
	["To {area:1099}"] = "Vers {area:1099}",

	-- Step 20: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "pour les chouettards de {zone:1425}, vers le niveau 48",

	-- Step 21: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "Prendre un vol pour {area:496}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Maître de vol de {area:1099}",

	-- Step 22: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "{npc:4501}, sous terre",

	-- Step 23: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "",

	-- Step 24: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "le {object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "Dans {area:498}",

	-- Step 25: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "{area:510} : tuez-les au passage",
	-- {area:511} Wyrmbog
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "{npc:4329} se promène autour de {area:510} : cherchez dans le cercle sur la carte",

	-- Step 26: Brackenwall Village
	["Ride back north to Brackenwall."] = "Retournez au nord jusqu'à Mur-de-Fougères.",

	-- Step 27: Onyxia's eggs
	["Onyxia's eggs"] = "Oeufs d'Onyxia",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Les Oeufs d'Onyxia reposent dans les grottes des dragons au sud-est de {area:511}, gardés par les Plaiedécailles Crins-de-feu ; écrasez-en cinq.",
	["Dragon caves"] = "Grottes des dragons",

	-- Step 29: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {quest:1173} demande un groupe de 3. Passez-la si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.\nLe {npc:4500} est élite : il est conseillé de se grouper. Frappez-le jusqu'à ce qu'il abandonne, puis faites votre rapport à {npc:4501}.",

	-- Step 30: Level 45.41
	["Level 45.41"] = "Niveau 45.41",
	-- {quest:1173} Challenge Overlord Mok'Morokk · {area:978} Zul'Farrak · {area:1517} Uldaman
	["If you skipped {quest:1173}, grind here to level 45.41 to stay on the route's plan. Or, with a group, run the {area:978} dungeon or the {area:1517} dungeon instead."] = "",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "tuez en boucle : {npc:4329}",

	-- Step 31: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Prendre un vol pour {area:1099}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "Maître de vol de {area:496}",

	-- Step 32: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "Fées fléchetteuses et Marcheurs des bois",
	-- {item:9589} Encrusted Minerals
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs."] = "Les Fées fléchetteuses voltigent au-dessus du bosquet juste à l'ouest du camp et portent les {item:9589} ; les Marcheurs des bois errants, un peu plus à l'ouest, portent les Bûches fendues.",

	-- Step 33: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "Hippogryphes Aigreplume",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "Au sud du val, les Hippogryphes Aigreplume nichent sur les pentes ; presque tous laissent tomber des Tendons résistants et des Fragments métalliques.",

	-- Step 34: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Allez au nord-ouest jusqu'à {area:1108} ; {npc:14637} Fandazzle attend sur le quai.",

	-- Step 35: Rogue Vale screechers
	["Rogue Vale screechers"] = "Hurleurs des vallées insoumis",
	-- {npc:14637} Zorbin Fandazzle · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "",

	-- Step 36: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108} : tuez-les au passage",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Des Elémentaires marins et des Embruns longent le rivage autour du quai. Zappez d'abord les géants avec {item:18904} : rétrécis, ils perdent leur force d'élite. Les Marcheurs des rivages pataugent dans l'eau ; les Marcheurs des terres et les Géants des falaises parcourent les collines plus au nord.",

	-- Step 37: Northspring harpies
	["Northspring harpies"] = "Harpies Northspring",
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Les harpies Northspring nichent sur les crêtes tout au nord-ouest. Elles sont de niveau 48-50, quelques niveaux au-dessus de vous : les Implorateurs du vent soignent, tuez-les en premier et attirez-les un par un.",

	-- Step 38: Rage Scar yetis
	["Rage Scar yetis"] = "Yétis Griffe féroce",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}, butin rare",

	-- Step 39: Camp Mojache
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, à l'intérieur",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:976}"] = "Prendre un vol pour {area:976}",
	-- ["Fly to {object:3202}"] = "Prendre un vol pour {object:3202}",
	-- ["Forest walkers"] = "Marcheurs des bois",
	-- ["Hearth to {area:1099}"] = "Pierre de foyer vers {area:1099}",
	-- ["If you skipped {quest:1173}, grind here to level 45.41 to stay on the route's plan."] = "Si vous avez passé {quest:1173}, tuez des monstres ici jusqu'au niveau 45.41 pour rester dans le plan de la route.",
	-- ["Keep {area:1417} for Marvon in {area:440}."] = "Gardez {area:1417} pour Marvon, en {area:440}.",
	-- ["Monstrous Crawlers"] = "Clampants monstrueux",
	-- ["Murlocs of the Misty Reed"] = "Murlocs de Brumejonc",
	-- ["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "Au nord-ouest le long de la route, les Yétis Griffe féroce vivent autour des grottes dans les collines. Chacun peut aussi laisser tomber l'objet qui lance la quête {quest:7738}.",
	-- ["Northspring harpies"] = "Harpies Ruissenord",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Retournez à l'est jusqu'au camp. Restez-y : le guide suivant commence par le vol pour {area:976}.",
	-- ["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Allez au sud-ouest jusqu'au {object:2555}, puis à l'est à travers {area:511}. Les Eclaireurs et Queues-cendrées Crins-de-feu parcourent sa lisière nord avec les Jeunes incendiaires et les Dragonnets incendiaires ; les Plaiedécailles Crins-de-feu gardent les grottes des dragons plus au sud-est. Le Tabac, le Tafia et le Coffre de Mok'Morokk se trouvent dans les camps des draconiens.",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Allez vers l'ouest jusqu'au centre de {zone:1444}. Tuez un {npc:5308}, utilisez la {item:10699} sur son corps et tuez l'esprit qui en sort.",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Au sud-ouest, les yétis ont leur repaire à {area:1105} ; chaque yéti peut y laisser tomber une Peau de yéti épaisse.",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Les Murlocs des marais vivent sur la grève au sud du poste ; les Cracheurs des marais longent le rivage à l'est et les Dévoreurs des marais sont plus à l'ouest, autour des huttes de la rive ouest.",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Les Clampants monstrueux arpentent les plages de la côte est, rares et dispersés : tuez tous ceux que vous voyez en descendant vers le sud.",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Les Harpies Ruissenord nichent sur les crêtes à l'extrême nord-ouest. Elles sont de niveau 48-50, quelques niveaux au-dessus de vous : les Imploratrices célestes Ruissenord soignent, tuez-les donc en premier et attirez-les une par une.",
	-- ["The next guide starts here and takes you to {area:440}.\nThe small Horde post on the southern shore."] = "Le prochain guide commence ici et vous emmène en {area:440}.\nLe petit poste de la Horde sur la rive sud.",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Les mêmes murlocs, plus les Oracles des marais, qui restent près des huttes de la rive ouest.",
	-- ["The small Horde post on the southern shore."] = "Le petit poste de la Horde sur la rive sud.",
	-- ["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Les mordeurs bordent la grève au sud du poste.\nLes Clampants monstrueux parcourent les plages de la côte est, rares et dispersés : tuez tous ceux que vous voyez en descendant vers le sud.",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "Le zeppelin pour {zone:1454} part de la tour à côté de {object:3202} ; il arrive juste au nord-est de la grande porte de {zone:1454}.",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "Vous commencez à {area:75}. Liez votre pierre de foyer ici : vous y reviendrez après la côte.",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Votre maître est à {area:1638} : prenez-y un vol (pas encore ce trajet aérien ? prenez un vol pour {area:378} et traversez {zone:1412} vers l'ouest), puis continuez vers {area:496}.",
	-- ["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",
	-- ["Zeppelin tower"] = "Tour des zeppelins",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "pour le {object:2555} dans le {area:15}, plus tard dans ce guide",
	-- ["for {area:35}, around level 50"] = "pour {area:35}, vers le niveau 50",
	-- ["{area:1136}: kill these as you meet them"] = "{area:1136} : tuez-les au passage",
	-- ["{area:976} flight master"] = "Maître de vol de {area:976}",
	-- ["{item:6168} along the way to {area:1978}"] = "{item:6168} sur le chemin de {area:1978}",
	-- ["{item:6168} on the way"] = "{item:6168} en chemin",
	-- ["{item:6175} along the way to {area:75}"] = "{item:6175} sur le chemin de {area:75}",
	-- ["{item:6175} on the way"] = "{item:6175} en chemin",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} est un élite : un groupe est conseillé. Frappez-le jusqu'à ce qu'il abandonne, puis faites votre rapport à {npc:4501}.",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776} : les ours sont à {zone:1448}",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875} : pour {npc:7010} à {zone:1454}, vers le niveau 50",
	-- ["{npc:7881}, inside"] = "{npc:7881}, à l'intérieur",
	-- ["{npc:7882}, inside"] = "{npc:7882}, à l'intérieur",
	-- ["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579} : les hurleurs vivent en {zone:1444}",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, puis {object:172960} et {object:172961}.",
}
