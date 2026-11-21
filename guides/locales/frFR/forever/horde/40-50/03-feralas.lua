-- French (frFR): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1454} Orgrimmar · {area:1099} Camp Mojache · {area:511} Wyrmbog · {area:496} Brackenwall Village
	["{zone:1454}'s hand-ins, {area:1099}'s Muisek vessel, then Dustwallow's {area:511} and {area:496}."] = "",
	["Takes you to level 47"] = "Vous amène au niveau 47",
	-- {zone:1446} Tanaris
	["Then on to {zone:1446}"] = "Puis direction {zone:1446}",
	["Stays on the main route"] = "Reste sur l'itinéraire principal",
	-- {zone:2652} Shen'dralas · {zone:1446} Tanaris
	["Skips {zone:2652}: about a dozen fewer quests, a third of a level lower into {zone:1446}"] = "",

	-- Step 1: Orgrimmar
	-- {object:172960} Cleft of Shadow · {object:172958} Valley of Honor
	["From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "Depuis le maître de vol : {object:172960}, puis la Herse, puis la {object:172958}.",
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag"] = "{npc:7010}, la Herse",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, la Herse",
	-- {zone:1425} Hinterlands
	-- was: ["for the {zone:1425}, around level 50"] = "pour les {zone:1425}, vers le niveau 50"
	["for the {zone:1425}, around level 49"] = "",

	-- Step 3: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "",
	-- {area:1638} Thunder Bluff · {area:1099} Camp Mojache
	["Your trainer is in {area:1638}, on the way to {area:1099}."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 5: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Prendre un vol pour {area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 6: Fly to Camp Mojache
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {zone:1446} Tanaris
	["Fly to {area:1099} (or hearth there, if your hearthstone is ready: it is still bound there from the {zone:1444} & {zone:1446} guide)."] = "",

	-- Step 7: Camp Mojache
	-- {zone:1425} Hinterlands
	-- was: ["for the {zone:1425} owlbeasts, around level 48"] = "pour les chouettards de {zone:1425}, vers le niveau 48"
	["for the {zone:1425} owlbeasts, around level 49"] = "",

	-- Step 8: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "Prendre un vol pour {area:496}",
	-- {zone:1444} Feralas · {zone:1446} Tanaris · {area:496} Brackenwall Village
	["No Muisek vessel to bring Uzer'i (you didn't take the {zone:1444} & {zone:1446} guide's chain): fly from here straight to {area:496}."] = "",

	-- Step 9: Fly to Brackenwall Village
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Maître de vol de {area:1099}",

	-- Step 10: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "{npc:4500}, {npc:4502} et {npc:4501} (sous terre) sont dans le village ; leurs quêtes concernent la {area:511} lors de ce passage.",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "{npc:4501}, sous terre",

	-- Step 11: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "Le {object:2555}",

	-- Step 12: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "Allez au sud-ouest jusqu'au {object:2555}.",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "le {object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "Dans {area:498}",

	-- Step 13: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "{area:510} : tuez-les au passage",
	-- {area:511} Wyrmbog
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Vers l'est à travers la {area:511} : les éclaireurs et les queues-de-cendre Crins-de-feu parcourent sa lisière nord avec les jeunes dragons et les dragonnets brûlants ; les Fléaux-d'écailles gardent les grottes des dragons plus au sud-est. Le tabac à priser, le grog et le coffre-fort de Mok'Morokk se trouvent dans les camps des draconiens.",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "{npc:4329} se promène autour de {area:510} : cherchez dans le cercle sur la carte",
	["Below ground"] = "Sous terre",

	-- Step 14: Brackenwall Village
	["Ride back north to Brackenwall."] = "Retournez au nord jusqu'à Mur-de-Fougères.",

	-- Step 15: Onyxia's eggs
	["Onyxia's eggs"] = "Oeufs d'Onyxia",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Les Oeufs d'Onyxia reposent dans les grottes des dragons au sud-est de {area:511}, gardés par les Plaiedécailles Crins-de-feu ; écrasez-en cinq.",

	-- Step 16: Muckshell crabs
	["Muckshell crabs"] = "",
	-- plural, as words: Muckshell Razorclaws = {npc:4405} Muckshell Razorclaw
	["On the way back north from the dragon caves, the Muckshell Razorclaws and Pincers (41-44) crowd the shallows just north of the caves; about one in twenty carries the Jeweled Pendant Marg Speaks asks for."] = "",

	-- Step 17: Level 45.37
	["Level 45.37"] = "Niveau 45.37",
	-- {npc:4500} Overlord Mok'Morokk · {area:511} Wyrmbog · {area:978} Zul'Farrak
	["{npc:4500}'s challenge, back in Brackenwall, needs a group of three. Alone, grind the Firemane scouts here on the {area:511}'s northern edge to level 45.37 before you ride back north, so you don't come back down for it. Or, with a group, run the {area:978} dungeon instead."] = "Le défi de {npc:4500}, de retour à Mur-de-Fougères, demande un groupe de trois. Seul, tuez en boucle les Eclaireurs Crins-de-feu ici, sur la lisière nord de {area:511}, jusqu'au niveau 45.37 avant de repartir vers le nord, pour ne pas avoir à redescendre. Ou, en groupe, faites plutôt le donjon {area:978}.",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "tuez en boucle : {npc:4329}",

	-- Step 18: Brackenwall Village
	-- {npc:4791} Nazeer Bloodpike · {item:5942} Jeweled Pendant
	["{npc:4791}: the {item:5942}"] = "",
	-- {npc:4047} Zor Lonetree · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["for {npc:4047} in {zone:1454}, on the {zone:1447} guide's {zone:1454} stop"] = "",
	-- {quest:3128} Natural Materials · {zone:1444} Feralas
	["Keep {quest:3128} and Improved Quality: {zone:1444}' sprites, hippogryphs, Zorbin's coast and the Rage Scar yetis come on your {zone:1444} loop at about 51, with the Muisek chain."] = "",

	-- Step 19: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {quest:1173} demande un groupe de 3. Passez-la si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.\nLe {npc:4500} est élite : il est conseillé de se grouper. Frappez-le jusqu'à ce qu'il abandonne, puis faites votre rapport à {npc:4501}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "Retournez à l'est après {area:75} : les Artefacts atal'ai se trouvent dans l'eau et sur les rives du Bassin des larmes (quête {quest:1424}).",
	-- ["Back to {npc:14637} on the dock."] = "Retournez voir {npc:14637} sur le quai.",
	-- ["Coming from Stranglethorn, you carry these already. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "Si vous venez de Strangleronce, vous les avez déjà. Si vous commencez ici : {npc:5591} se tient dans la grande salle de {area:75} et {npc:1443} à son dernier étage.",
	-- ["Dragon caves"] = "Grottes des dragons",
	-- ["Fly to {area:75}"] = "Prendre un vol pour {area:75}",
	-- ["Fly to {area:976}"] = "Prendre un vol pour {area:976}",
	-- ["Fly to {object:3202}"] = "Prendre un vol pour {object:3202}",
	-- ["Follow the road south-east to the small Horde post on the shore. {npc:5592} takes the crocolisk flanks from the last swamp visit."] = "Suivez la route vers le sud-est jusqu'au petit poste de la Horde sur le rivage. {npc:5592} prend les flancs de crocilisque de la dernière visite des marais.",
	-- ["Forest walkers"] = "Marcheurs des bois",
	-- ["Frayfeather hippogryphs"] = "Hippogryphes Aigreplume",
	-- ["Hearth to {area:1099}"] = "Pierre de foyer vers {area:1099}",
	-- ["Hearth to {area:1099}: your hearthstone is still bound there from the {zone:1444} & {zone:1446} guide."] = "Pierre de foyer vers {area:1099} : votre pierre de foyer y est toujours liée depuis le guide {zone:1444} & {zone:1446}.",
	-- ["If you skipped {quest:1173}, grind here to level 45.41 to stay on the route's plan."] = "Si vous avez passé {quest:1173}, tuez des monstres ici jusqu'au niveau 45.41 pour rester dans le plan de la route.",
	-- ["Keep {area:1417} for Marvon in {area:440}."] = "Gardez {area:1417} pour Marvon, en {area:440}.",
	-- ["Level 45.41"] = "Niveau 45.41",
	-- ["Monstrous Crawlers"] = "Clampants monstrueux",
	-- ["Murlocs of the Misty Reed"] = "Les murlocs de Misty Reed",
	-- ["No flight path to {area:75} yet (the {zone:2548} skip the {zone:1435}): ride north-east from {object:3202} through {zone:1431} and {zone:1430} into the swamp, then east along the road to {area:75}, and learn its flight path."] = "Pas encore de trajet aérien vers {area:75} (les {zone:2548} sautent le {zone:1435}) : chevauchez vers le nord-est depuis {object:3202} à travers {zone:1431} et le {zone:1430} jusqu'au marais, puis vers l'est par la route jusqu'à {area:75}, et apprenez son trajet aérien.",
	-- ["Northspring harpies"] = "Harpies Northspring",
	-- ["On the way back south-east from the coast, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "Sur le chemin du retour vers le sud-est depuis la côte, les Yétis Griffe féroce vivent autour des grottes dans les collines près de la route. Chacun peut aussi laisser tomber {quest:7738}, qui lance sa propre quête.",
	-- ["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "Sur le chemin du retour vers le sud-est depuis les harpies, les Yétis Griffe féroce vivent autour des grottes dans les collines près de la route. Chacun peut aussi laisser tomber {quest:7738}, qui lance sa propre quête.",
	-- ["Rage Scar yetis"] = "Yétis Griffe féroce",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Retournez à l'est jusqu'au camp. Restez-y : le guide suivant commence par le vol pour {area:976}.",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Allez au nord-ouest jusqu'à {area:1108} ; {npc:14637} Fandazzle attend sur le quai.",
	-- ["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Allez au sud-ouest jusqu'au {object:2555}, puis à l'est à travers {area:511}. Les Eclaireurs et Queues-cendrées Crins-de-feu parcourent sa lisière nord avec les Jeunes incendiaires et les Dragonnets incendiaires ; les Plaiedécailles Crins-de-feu gardent les grottes des dragons plus au sud-est. Le Tabac, le Tafia et le Coffre de Mok'Morokk se trouvent dans les camps des draconiens.",
	-- ["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Suivez la route vers l'ouest ; le parchemin se trouve au bord de l'eau, à l'extrême ouest du marais.",
	-- ["Riding at 40"] = "Monte au niveau 40",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. Chaque race l'apprend auprès du maître de sa propre race : le vôtre est {npc:4773} à {area:159}, à une courte chevauchée au nord des tours des zeppelins, avec les chevaux squelettes de {npc:4731} (20 pièces d'or chacun) à côté d'elle. Revenez ensuite aux tours pour le zeppelin de {object:3202}.",
	-- ["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body before you loot it, then talk to the spirit that rises: it is friendly. Three spirits in all."] = "Le Val des voleurs s'ouvre juste au nord du quai de {npc:14637}. Tuez un {npc:5308}, utilisez la {item:10699} sur son corps avant de le fouiller, puis parlez à l'esprit qui en sort : il est amical. Trois esprits en tout.",
	-- ["Rogue Vale screechers"] = "Hurleurs des vallées insoumis",
	-- ["Sawtooth crocolisks"] = "Crocilisques Dents-de-scie",
	-- ["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Des Elémentaires marins et des Embruns longent le rivage autour du quai. Zappez d'abord les géants avec {item:18904} : rétrécis, ils perdent leur force d'élite. Les Marcheurs des rivages pataugent dans l'eau ; les Marcheurs des terres et les Géants des falaises parcourent les collines plus au nord.",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Chevaux squelettes : {npc:4731}, à côté de {npc:4773} à {area:159}.",
	-- ["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "Au sud du val, les Hippogryphes Aigreplume nichent sur les pentes ; presque tous laissent tomber des Tendons résistants et des Fragments métalliques.",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Au sud-ouest, les yétis ont leur repaire à {area:1105} ; chaque yéti peut y laisser tomber une Peau de yéti épaisse.",
	-- ["Sprite darters and forest walkers"] = "Fées fléchetteuses et Marcheurs des bois",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Les Murlocs des marais vivent sur la grève au sud du poste ; les Crache-encre sont le long du rivage à l'est et les Mange-chair plus à l'ouest, autour des huttes de la rive ouest.",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Les Clampants monstrueux arpentent les plages de la côte est, rares et dispersés : tuez tous ceux que vous voyez en descendant vers le sud.",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Les harpies Northspring nichent sur les crêtes tout au nord-ouest. Elles sont de niveau 48-50, quelques niveaux au-dessus de vous : les Implorateurs du vent soignent, tuez-les en premier et attirez-les un par un.",
	-- ["The Sea Sprays (47-48) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (48-49) do. The Wave and Deep Striders (47-49) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength. Leave the Land Walkers and Cliff Giants (48-50) of the northern hills for your next {zone:1444} visit.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "Les Embruns (47-48) longent le rivage juste au sud du quai : ils lâchent les Noyaux d'élémentaire d'eau tout comme les Elémentaires marins (48-49). Les Marcheurs des vagues et des profondeurs (47-49) avancent dans l'eau au large de la même plage : touchez-les d'abord avec l'{item:18904} ; réduits, ils perdent leur force d'élite. Laissez les Marcheurs des terres et les Géants des falaises (48-50) des collines du nord pour votre prochaine visite en {zone:1444}.\nL'Ultra-réducteur dure deux heures : rendez les deux quêtes à {npc:14637} avant de quitter la côte.",
	-- ["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "Les crocilisques se vautrent dans les mares autour de l'ancien camp de Galen, juste au nord de {area:75}, sur le chemin du retour vers l'est ; environ un sur quatre laisse tomber un flanc.",
	-- ["The next guide starts here and takes you to {area:440}.\nThe small Horde post on the southern shore."] = "Le prochain guide commence ici et vous emmène en {area:440}.\nLe petit poste de la Horde sur la rive sud.",
	-- ["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "Encore le même rivage des murlocs : les Cracheurs d'encre à l'est du poste, les Mangeurs de chair autour des huttes de l'ouest, et les Oracles parmi les deux.",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Les mêmes murlocs, plus les Oracles des marais, qui restent près des huttes de la rive ouest.",
	-- ["The small Horde post on the southern shore."] = "Le petit poste de la Horde sur la rive sud.",
	-- ["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too.\nCareful: a {npc:272377} (level 60) walks the south-east strand: give it a wide berth."] = "Les mordeurs bordent la grève au sud du poste.\nLes Clampants monstrueux parcourent les plages de la côte est, rares et dispersés : tuez tous ceux que vous voyez ainsi que ceux sur le trajet depuis le bassin.\nAttention : un {npc:272377} (niveau 60) arpente la grève sud-est : gardez vos distances.",
	-- ["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs.\nCareful: a {npc:272401} (level 60) flies over the forest west of the camp: keep clear of it."] = "Les Fées fléchetteuses voltigent au-dessus du bosquet juste à l'ouest du camp et portent les {item:9589} ; les Marcheurs des bois errants, un peu plus à l'ouest, portent les Bûches fendues.\nAttention : un {npc:272401} (niveau 60) survole la forêt à l'ouest du camp : tenez-vous à l'écart.",
	-- ["The zeppelin lands at {object:3202}: Stranglethorn's errands are done (40-50/02), so fly straight on to {area:75}."] = "Le zeppelin atterrit à Grom'gol : les courses de Strangleronce sont faites (40-50/02), prenez donc directement un vol pour {area:75}.",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "Le zeppelin pour {zone:1454} part de la tour à côté de {object:3202} ; il arrive juste au nord-est de la grande porte de {zone:1454}.",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["Three zones, lots of travel"] = "Trois zones, beaucoup de trajets",
	-- ["To {area:1099}"] = "Vers {area:1099}",
	-- ["To {area:75}"] = "Vers {area:75}",
	-- ["Underwater"] = "Sous l'eau",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "Vous commencez à {area:75}. Liez votre pierre de foyer ici : vous y reviendrez après la côte.",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Votre maître est à {area:1638} : prenez-y un vol (pas encore ce trajet aérien ? prenez un vol pour {area:378} et traversez {zone:1412} vers l'ouest), puis continuez vers {area:496}.",
	-- ["Zeppelin to {object:3202}"] = "Zeppelin pour {object:3202}",
	-- ["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",
	-- ["Zeppelin to {zone:1458}"] = "Zeppelin pour {zone:1458}",
	-- ["Zeppelin tower"] = "Tour des zeppelins",
	-- ["for the {npc:5598} in the {zone:1425}, around level 48"] = "pour l'{npc:5598} dans {zone:1425}, vers le niveau 48",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "pour le {object:2555} dans le {area:15}, plus tard dans ce guide",
	-- ["for the {object:2555} in {zone:1445}, later in this guide"] = "pour le {object:2555} à {zone:1445}, plus loin dans ce guide",
	-- ["for the {zone:1425} owlbeasts, around level 48"] = "pour les chouettards de {zone:1425}, vers le niveau 48",
	-- ["for the {zone:1425}, around level 50"] = "pour les {zone:1425}, vers le niveau 50",
	-- ["for {area:35}, around level 50"] = "pour {area:35}, vers le niveau 50",
	-- ["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "la {item:8523} de ces missions : gardez-la, la quête Les échantillons du désert de Tanaris vous la redonne à {area:976}",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108} : tuez-les au passage",
	-- ["{area:1136}: kill these as you meet them"] = "{area:1136} : tuez-les au passage",
	-- ["{area:2403}: kill these as you meet them"] = "{area:2403} : tuez-les au passage",
	-- ["{area:496} flight master"] = "Maître de vol de {area:496}",
	-- ["{area:976} flight master"] = "Maître de vol de {area:976}",
	-- ["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}, sur les Marcheurs des vagues et des profondeurs dans l'eau",
	-- ["{item:18958}, from the Sea Sprays"] = "{item:18958}, sur les Embruns",
	-- ["{item:6168} along the way to {area:1978}"] = "{item:6168} sur le chemin de {area:1978}",
	-- ["{item:6168} on the way"] = "{item:6168} en chemin",
	-- ["{item:6175} along the way to {area:75}"] = "{item:6175} sur le chemin de {area:75}",
	-- ["{item:6175} on the way"] = "{item:6175} en chemin",
	-- ["{npc:1443}, on the top floor"] = "{npc:1443}, au dernier étage",
	-- ["{npc:2934}, on the way back to Zinge"] = "{npc:2934}, sur le chemin du retour vers Zinge",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} est un élite : un groupe est conseillé. Frappez-le jusqu'à ce qu'il abandonne, puis faites votre rapport à {npc:4501}.",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}, maître de monte",
	-- ["{npc:5591}, inside"] = "{npc:5591}, à l'intérieur",
	-- ["{npc:7776}'s Northspring harpies (48-50) wait for your {zone:1444} visit at about 51: keep the quest."] = "Les harpies Rive-nord (48-50) de {npc:7776} attendent votre passage en {zone:1444} vers le niveau 51 : gardez la quête.",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776} : les ours sont à {zone:1448}",
	-- ["{npc:7825}, the {object:36126}"] = "{npc:7825}, dans le {object:36126}",
	-- ["{npc:7854}, inside"] = "{npc:7854}, à l'intérieur",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875} : pour {npc:7010} à {zone:1454}, vers le niveau 50",
	-- ["{npc:7881}, inside"] = "{npc:7881}, à l'intérieur",
	-- ["{npc:7882}, inside"] = "{npc:7882}, à l'intérieur",
	-- ["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579} : les hurleurs vivent en {zone:1444}",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, puis {object:172960} et {object:172961}.",
	-- ["{object:3202} flight master"] = "Maître de vol de Grom'gol",
	-- ["{quest:7738}, a rare drop"] = "{quest:7738}, butin rare",
	-- ["{zone:1435} and Dustwallow first, then {zone:1444}."] = "{zone:1435} et le Marécage d'Âprefange d'abord, puis {zone:1444}.",
}
