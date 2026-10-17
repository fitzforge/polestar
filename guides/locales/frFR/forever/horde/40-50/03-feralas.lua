-- French (frFR): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stonard
	-- {area:75} Stonard
	["You start in {area:75}. Bind here: you hearth back after the coast."] = "Vous commencez à {area:75}. Liez votre pierre de foyer ici : vous y reviendrez après la côte.",

	-- Step 2: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Suivez la route vers l'ouest ; le parchemin se trouve au bord de l'eau, à l'extrême ouest du marais.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, later in this guide"] = "pour le {object:2555} à {zone:1445}, plus loin dans ce guide",

	-- Step 3: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "Retournez à l'est après {area:75} : les Artefacts atal'ai se trouvent dans l'eau et sur les rives du Bassin des larmes (quête {quest:1424}).",

	-- Step 4: Monstrous Crawlers
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["Monstrous Crawlers"] = "Clampants monstrueux",
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Les Clampants monstrueux arpentent les plages de la côte est, rares et dispersés : tuez tous ceux que vous voyez en descendant vers le sud.",

	-- Step 5: Misty Reed Post
	["The small Horde post on the southern shore."] = "Le petit poste de la Horde sur la rive sud.",

	-- Step 6: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "Murlocs de Brumejonc",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Les Murlocs des marais vivent sur la grève au sud du poste ; les Cracheurs des marais longent le rivage à l'est et les Dévoreurs des marais sont plus à l'ouest, autour des huttes de la rive ouest.",

	-- Step 8: Continued Threat
	["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Les mêmes murlocs, plus les Oracles des marais, qui restent près des huttes de la rive ouest.",

	-- Step 10: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "pour l'{npc:5598} dans {zone:1425}, vers le niveau 48",

	-- Step 11: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Prendre un vol pour {object:3202}",

	-- Step 12: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "Le zeppelin pour {zone:1454} part de la tour à côté de {object:3202} ; il arrive juste au nord-est de la grande porte de {zone:1454}.",
	["Zeppelin tower"] = "Tour des zeppelins",

	-- Step 13: Orgrimmar
	-- {object:172958} Valley of Honor · {object:172960} Cleft of Shadow · {object:172961} Valley of Spirits
	["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, puis {object:172960} et {object:172961}.",

	-- Step 14: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:496} Brackenwall Village
	["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Votre maître est à {area:1638} : prenez-y un vol (pas encore ce trajet aérien ? prenez un vol pour {area:378} et traversez {zone:1412} vers l'ouest), puis continuez vers {area:496}.",

	-- Step 16: The Wyrmbog
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
	-- {object:2555} Musty Scroll · {area:511} Wyrmbog
	["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Allez au sud-ouest jusqu'au {object:2555}, puis à l'est à travers {area:511}. Les Eclaireurs et Queues-cendrées Crins-de-feu parcourent sa lisière nord avec les Jeunes incendiaires et les Dragonnets incendiaires ; les Plaiedécailles Crins-de-feu gardent les grottes des dragons plus au sud-est. Le Tabac, le Tafia et le Coffre de Mok'Morokk se trouvent dans les camps des draconiens.",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "le {object:2555}",

	-- Step 17: Brackenwall Village
	["Ride back north to Brackenwall."] = "Retournez au nord jusqu'à Mur-de-Fougères.",

	-- Step 18: Onyxia's eggs
	["Onyxia's eggs"] = "Oeufs d'Onyxia",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Les Oeufs d'Onyxia reposent dans les grottes des dragons au sud-est de {area:511}, gardés par les Plaiedécailles Crins-de-feu ; écrasez-en cinq.",
	["Dragon caves"] = "Grottes des dragons",

	-- Step 20: Challenge Overlord Mok'Morokk
	-- {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} est un élite : un groupe est conseillé. Frappez-le jusqu'à ce qu'il abandonne, puis faites votre rapport à {npc:4501}.",

	-- Step 21: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "pour les chouettards de {zone:1425}, vers le niveau 48",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875} : pour {npc:7010} à {zone:1454}, vers le niveau 50",

	-- Step 22: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "Fées fléchetteuses et Marcheurs des bois",
	-- {item:9589} Encrusted Minerals
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs."] = "Les Fées fléchetteuses voltigent au-dessus du bosquet juste à l'ouest du camp et portent les {item:9589} ; les Marcheurs des bois errants, un peu plus à l'ouest, portent les Bûches fendues.",
	["Forest walkers"] = "Marcheurs des bois",

	-- Step 23: Feral Scar Vale
	-- {area:1105} Feral Scar Vale
	["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Au sud-ouest, les yétis ont leur repaire à {area:1105} ; chaque yéti peut y laisser tomber une Peau de yéti épaisse.",

	-- Step 24: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "Hippogryphes Aigreplume",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "Au sud du val, les Hippogryphes Aigreplume nichent sur les pentes ; presque tous laissent tomber des Tendons résistants et des Fragments métalliques.",

	-- Step 25: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Allez au nord-ouest jusqu'à {area:1108} ; {npc:14637} Fandazzle attend sur le quai.",

	-- Step 26: Forgotten Coast
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Des Elémentaires marins et des Embruns longent le rivage autour du quai. Zappez d'abord les géants avec {item:18904} : rétrécis, ils perdent leur force d'élite. Les Marcheurs des rivages pataugent dans l'eau ; les Marcheurs des terres et les Géants des falaises parcourent les collines plus au nord.",

	-- Step 28: Northspring harpies
	["Northspring harpies"] = "Harpies Ruissenord",
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Les Harpies Ruissenord nichent sur les crêtes à l'extrême nord-ouest. Elles sont de niveau 48-50, quelques niveaux au-dessus de vous : les Imploratrices célestes Ruissenord soignent, tuez-les donc en premier et attirez-les une par une.",

	-- Step 30: Rage Scar yetis
	["Rage Scar yetis"] = "Yétis Griffe féroce",
	-- {quest:7738} Perfect Yeti Hide
	["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "Au nord-ouest le long de la route, les Yétis Griffe féroce vivent autour des grottes dans les collines. Chacun peut aussi laisser tomber l'objet qui lance la quête {quest:7738}.",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}, butin rare",

	-- Step 31: Camp Mojache
	-- {area:976} Gadgetzan
	["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Retournez à l'est jusqu'au camp. Restez-y : le guide suivant commence par le vol pour {area:976}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:1108}"] = "{area:1108}",
}
