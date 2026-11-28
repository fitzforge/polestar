-- French (frFR): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1434} Stranglethorn Vale · {area:75} Stonard · {zone:1446} Tanaris · {zone:1444} Feralas
	["{zone:1434} and {area:75} first, then {zone:1446} and {zone:1444}."] = "D'abord {zone:1434} et {area:75}, puis {zone:1446} et {zone:1444}.",

	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Prendre un vol pour {object:3202}",
	-- {zone:2548} Riverglades · {area:340} Kargath
	["Coming from the {zone:2548}: {area:340}'s flight master stands at the foot of the fortress."] = "En venant des {zone:2548} : le maître de vol de {area:340} se tient au pied de la forteresse.",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Maître de vol de {area:340}",

	-- Step 2: Fly to Grom'gol
	-- {area:75} Stonard
	["{area:75} flight master"] = "Maître de vol de {area:75}",

	-- Step 3: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay · {npc:1514} Mokk the Savage · {zone:1435} Swamp of Sorrows · {zone:1458} Undercity · {object:2076} Bubbling Cauldron
	-- was: ["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "Le vol atterrit à {object:3202}. Les missions plus difficiles de Strangleronce, rapportées de votre première visite, sont à votre portée : le chef Brise-crâne, les camps de Zanzil, les pirates de {area:35}, la côte des nagas et {npc:1514}, avant le zeppelin pour {zone:1454}. Le {object:2076} près de Nimboya donne la quête du chef Brise-crâne."
	["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the {zone:1435} and the {zone:1458}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "",
	-- {object:2076} Bubbling Cauldron · {quest:586} Speaking with Gan'zulah
	["the {object:2076}: {quest:586}"] = "le {object:2076} : {quest:586}",

	-- Step 4: Tusks and necklaces on the Skullsplitter hunt
	["Tusks and necklaces on the Skullsplitter hunt"] = "",
	-- {npc:737} Kebok · {npc:2519} Kin'weelay
	["The hunters also drop {npc:737}'s tusks and {npc:2519}'s necklaces. Collect any you still need during the cauldron hunt."] = "",

	-- Step 5: Zul'Mamwe
	["Zul'Mamwe"] = "Ruines de Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel · {quest:586} Speaking with Gan'zulah · {npc:1060} Mogh the Undying
	["Ride east to the Skullsplitter ruins east of the Venture Co. mine. The headhunters, berserkers and hunters roam the ruins.\n{npc:1059} (45) carries the Broken Armor for {quest:586}: he walks the south-western ruins with two guards and sometimes stands in a small cave there. Pull the guards first.\nCareful: {npc:1060}, an elite troll (level 44), stands in the southern ruins around 47.7,44.3: pull the headhunters and berserkers away from him."] = "Allez à l'est jusqu'aux ruines Brise-crâne, à l'est de la mine de la KapitalRisk. Les chasseurs de têtes, berserkers et chasseurs parcourent les ruines.\n{npc:1059} (45) porte l'Armure brisée pour {quest:586} : il arpente les ruines du sud-ouest avec deux gardes et se tient parfois dans une petite grotte. Attaquez d'abord les gardes.\nAttention : {npc:1060}, un troll élite (niveau 44), se tient dans les ruines du sud vers 47.7,44.3 : attirez les chasseurs de têtes et berserkers loin de lui.",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669} se promène par ici : cherchez dans le cercle sur la carte",

	-- Step 6: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back west to {object:3202}."] = "Retournez à l'ouest jusqu'à {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "le {object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "le {object:2076} à nouveau : le sort de Yenniku",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks bask beside the road south, on the ride to {area:35}"] = "{npc:2519} : les basilics se prélassent au bord de la route au sud, sur le chemin de {area:35}",

	-- Step 8: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Basilics gueule de fer",
	-- {area:35} Booty Bay
	["Ride south along the road towards {area:35}; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Allez au sud par la route vers {area:35} ; les basilics se prélassent sur les rochers à l'est, au milieu de la jungle. Leurs éclats tombent souvent.",
	["Below ground"] = "Sous terre",

	-- Step 9: Pirate ghosts and Zanzil's camps
	["Pirate ghosts and Zanzil's camps"] = "Fantômes pirates et camps de Zanzil",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2537} Chucky "Ten Thumbs" · {npc:2534} Zanzil the Outcast
	-- plural, as words: Zanzil Witch Doctors = {npc:1490} Zanzil Witch Doctor
	-- was: ["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "Continuez au sud-ouest vers la jungle au nord-est de Val-Brumeux : les trois pirates fantômes la hantent près des camps de Zanzil. {npc:2535} et {npc:2536} se tiennent ensemble, {npc:2537} plus à l'est. Tous les fidèles de Zanzil peuvent porter la mixture.\nAttention : les Sorciers-docteurs Zanzil (44) lancent des sorts et les camps sont bondés : attirez-les depuis le bord, un à la fois. {npc:2534} (46) lui-même se tient dans le camp sud vers 39.6,58.6, à quelques pas du fantôme de {npc:2537} : attirez {npc:2537} au nord ou à l'est avant de l'affronter."
	["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and Jon-Jon stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "",

	-- Step 10: Witch Doctor Unbagwa
	-- {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["West into Mistvale: {npc:1449} sits among the gorillas. Any gorilla can drop a fang: hand him ten and stay by him, he calls three waves of gorillas, then {npc:1514}.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "À l'ouest dans Val-Brumeux : {npc:1449} est assis parmi les gorilles. Tout gorille peut lâcher un croc : donnez-lui-en dix et restez près de lui, il appelle trois vagues de gorilles, puis {npc:1514}.\nAttention : les trois vagues arrivent l'une après l'autre avec peu de répit, puis {npc:1514}. Commencez avec toute votre vie et votre mana, et restez près d'Unbagwa. Certaines classes ont du mal seules : un ami rend la chose facile.",

	-- Step 11: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "{area:1577} : tuez-les au passage",
	-- {object:759} Holy Spring · {area:43} Wild Shore · {area:35} Booty Bay
	["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them.\nFollow the coast south. If you still need the {area:43} pirates, take the road past the {area:35} tunnel to the beach before going into town."] = "",

	-- Step 12: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:35} Booty Bay
	["From the north, take the outer shore east of the {area:35} tunnel. Work south-west through the swashbucklers (41-43) into the camp; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Stay ashore."] = "",

	-- Step 13: Bloodsail tents and rowboat
	["Bloodsail tents and rowboat"] = "",
	["Search the tents and the rowboat for both papers; if one place is empty, try the next. Neither paper is on a ship."] = "",

	-- Step 16: Booty Bay
	-- {area:35} Booty Bay · {npc:2494} Privateer Bloads · {npc:2498} Crank Fizzlebub · {npc:737} Kebok · {npc:773} Krazek
	["In {area:35}: {npc:2494} on the docks, {npc:2498} inside the inn, MacKinley, {npc:737} and {npc:773} upstairs."] = "À {area:35} : {npc:2494} sur les quais, {npc:2498} dans l'auberge, MacKinley, {npc:737} et {npc:773} à l'étage.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, à l'intérieur",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "« Loup de mer » MacKinley, au dernier étage",

	-- Step 17: Fin Fizracket
	-- {npc:2486} Fin Fizracket
	["{npc:2486}, by the inn"] = "",

	-- Step 18: Whiskey Slim and Fin Fizracket
	-- {npc:2491} Whiskey Slim · {npc:2486} Fin Fizracket
	["{npc:2491} and {npc:2486}"] = "",
	-- {area:35} Booty Bay · {npc:2491} Whiskey Slim
	["Under 40 on your first {area:35} visit? {npc:2491}, in the inn, and \"Sea Wolf\" MacKinley, on the top floor, have their quests for you now."] = "Moins de 40 à votre première visite à {area:35} ? {npc:2491}, à l'auberge, et « Loup de mer » MacKinley, au dernier étage, ont déjà des quêtes pour vous.",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "{npc:2491}, dans l'auberge : ses bouteilles s'échouent sur la côte des {zone:1425}, vers le niveau 48",
	-- {quest:2872} Stoley's Debt · {npc:7881} Stoley · {zone:1446} Tanaris
	["MacKinley, on the top floor: {quest:2872}, for {npc:7881} in {zone:1446} on this guide"] = "",

	-- Step 19: Fin Fizracket
	-- {quest:348} Stranglethorn Fever · {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["Group quest: {quest:348} ends at {npc:1449} in Mistvale. Hand him ten gorilla fangs and he calls three waves of gorillas (41-42), one after another, then {npc:1514} (44). In players' recordings, 12 of the 27 people who started it died there. Take it if you have a friend or two along."] = "Quête de groupe : {quest:348} se termine auprès de {npc:1449} à Valbrume. Donnez-lui dix crocs de gorille et il appelle trois vagues de gorilles (41-42), l'une après l'autre, puis {npc:1514} (44). Dans les enregistrements des joueurs, 12 des 27 personnes qui l'ont commencée y sont mortes. Prenez-la si vous avez un ami ou deux avec vous.",
	-- {npc:2486} Fin Fizracket · {quest:348} Stranglethorn Fever
	["{npc:2486}, beside the inn: {quest:348}"] = "{npc:2486}, à côté de l'auberge : {quest:348}",

	-- Step 20: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["North into Mistvale, a short ride from {area:35}: {npc:1449} sits among the gorillas. Hand him ten gorilla fangs and stay by him: three waves of gorillas, then {npc:1514}. Start at full health and mana."] = "",

	-- Step 22: Kebok
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, à l'étage",

	-- Step 23: Krazek
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}, later in this guide"] = "{npc:773}, à l'étage : pour {quest:2864} à {area:976}, plus loin dans ce Guide",

	-- Step 26: Unfinished Wild Shore errands
	-- {area:43} Wild Shore
	["Unfinished {area:43} errands"] = "",
	["If the town rewards just brought you to 42 and you still owe pirate work, use the shore tents, not the ships."] = "",

	-- Step 30: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maître de vol de {area:35}",

	-- Step 31: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:2519} Kin'weelay · {npc:2465} Far Seer Mok'thardin
	["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then back to the flight master."] = "",

	-- Step 34: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Prendre un vol pour {area:75}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:75} Stonard · {area:1978} Misty Reed Post
	["Stranglethorn's errands are done: from {object:3202}'s flight master, fly on to {area:75} for the swamp's coast and {area:1978}, which fit you now."] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Maître de vol de Grom'gol",

	-- Step 35: To Stonard
	-- {area:75} Stonard
	["To {area:75}"] = "Vers {area:75}",
	-- {area:75} Stonard · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1431} Duskwood · {zone:1430} Deadwind Pass
	["No flight path to {area:75} yet: ride north-east from {object:3202} through {zone:1431} and {zone:1430} into the swamp, then east along the road to {area:75}, and learn its flight path."] = "",

	-- Step 36: Stonard
	-- {quest:698} Lack of Surplus · {quest:1424} Pool of Tears · {quest:1430} Fresh Meat · {npc:5593} Katar · {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["The Stranglethorn & Swamp guide already finished {quest:698}' first part and the {quest:1424} with you; its {quest:1430} and {npc:5593}'s murlocs are in your log. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, à l'intérieur",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, au dernier étage",

	-- Step 37: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Suivez la route vers l'ouest ; le parchemin se trouve au bord de l'eau, à l'extrême ouest du marais.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, on the Dustwallow guide"] = "",

	-- Step 38: A Soggy Scroll
	["The scroll lies at the water's edge in the swamp's far west."] = "Le parchemin se trouve au bord de l'eau, à l'extrême ouest du marais.",

	-- Step 39: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocilisques Dents-de-scie",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "Les crocilisques se vautrent dans les mares autour de l'ancien camp de Galen, juste au nord de {area:75}, sur le chemin du retour vers l'est ; environ un sur quatre laisse tomber un flanc.",

	-- Step 40: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "Retournez à l'est après {area:75} : les Artefacts atal'ai se trouvent dans l'eau et sur les rives du Bassin des larmes (quête {quest:1424}).",

	-- Step 41: Misty Reed Post
	-- {npc:5592} Tok'Kar · {npc:5593} Katar
	["Follow the road south-east to the small Horde post on the shore: {npc:5592} and {npc:5593}."] = "",

	-- Step 42: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "{area:2403} : tuez-les au passage",
	-- {npc:272377} Methuselah Crab
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too.\nCareful: a {npc:272377} (level 60) walks the south-east strand: give it a wide berth."] = "Les mordeurs bordent la grève au sud du poste.\nLes Clampants monstrueux parcourent les plages de la côte est, rares et dispersés : tuez tous ceux que vous voyez ainsi que ceux sur le trajet depuis le bassin.\nAttention : un {npc:272377} (niveau 60) arpente la grève sud-est : gardez vos distances.",
	["Underwater"] = "Sous l'eau",

	-- Step 44: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "Les murlocs de Misty Reed",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Les Murlocs des marais vivent sur la grève au sud du poste ; les Crache-encre sont le long du rivage à l'est et les Mange-chair plus à l'ouest, autour des huttes de la rive ouest.",

	-- Step 46: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "Encore le même rivage des murlocs : les Cracheurs d'encre à l'est du poste, les Mangeurs de chair autour des huttes de l'ouest, et les Oracles parmi les deux.",

	-- Step 48: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 49"] = "",

	-- Step 49: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Prendre un vol pour {area:1497}",
	-- {area:75} Stonard · {area:1497} Undercity · {area:340} Kargath · {npc:5204} Apothecary Zinge · {zone:1454} Orgrimmar
	["From {area:75}'s flight master, fly to the {area:1497} (by way of {area:340}): {npc:5204}'s errands and your {area:1497} training, then the zeppelin from the towers outside the city to {zone:1454}."] = "",

	-- Step 50: Apothecary Zinge
	-- {npc:2934} Keeper Bel'dugur
	["{npc:2934}, on the way back to Zinge"] = "{npc:2934}, sur le chemin du retour vers Zinge",
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "la {item:8523} de ces missions : gardez-la, la quête Les échantillons du désert de Tanaris vous la redonne à {area:976}",

	-- Step 51: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "",

	-- Step 52: Riding at 40
	["Riding at 40"] = "Monte au niveau 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {zone:1454} Orgrimmar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {zone:1454} zeppelin."] = "",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, maîtresse de monte",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Chevaux squelettes : {npc:4731}, à côté de {npc:4773} à {area:159}.",

	-- Step 53: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",

	-- Step 54: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "Le centre d'{zone:1454}",

	-- Step 55: Orgrimmar
	-- {zone:1458} Undercity
	["the {zone:1458}'s classes trained there on the way"] = "",

	-- Step 56: Riding at 40
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. {npc:4752} l'enseigne aux Orcs dans la {object:172958}, près du chenil de {npc:3362}. Les Éolides l'apprennent auprès de {npc:265756} aux {area:17684} à {area:16638}, sur l'île de Zéphras, avec un Trotteur des trombes : l'aéronef pour l'île part des falaises au sud de {area:17045}, au nord des {zone:1456}, toutes les cinq minutes environ. Les autres montures de votre race coûtent 20 pièces d'or chacune : Objets de collection, Montures · Niveau 40 a un guide pour chacune.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, maître de monte",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Loups : {npc:3362}, à côté de {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "Monte et Trotteurs des trombes : {npc:265756}, aux {area:17684} à {area:16638}, sur l'île de Zéphras.",

	-- Step 58: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. Chaque race l'apprend auprès du maître de sa propre race : le vôtre est {npc:7953} à {area:367}, à une courte chevauchée au sud d'{zone:1454} par la route de {zone:1411}, avec les raptors de Zjolnir (20 pièces d'or chacun) à côté de lui. Revenez ensuite au maître de vol d'{zone:1454}.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, maître de monte",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptors : Zjolnir, à côté de {npc:7953} à {area:367}.",

	-- Step 59: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Prendre un vol pour {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 61: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins)."] = "Votre maître est aux {zone:1456} : {npc:3033} (druides) sur {area:1639}, {npc:246344} (paladins).",

	-- Step 63: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. Chaque race l'apprend auprès de son propre maître : le vôtre est {npc:3690}, à {area:222}, avec les kodos de {npc:3685} (20 pièces d'or chacun) à côté de lui. Remontez ensuite jusqu'au maître de vol des {zone:1456}.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, maître de monte",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Kodos : {npc:3685}, à côté de {npc:3690} à {area:222}.",

	-- Step 64: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Prendre un vol pour {area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maître de vol des {zone:1456}",

	-- Step 65: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Prendre un vol pour {area:976}",

	-- Step 68: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392} pour le Palefroi corrompu",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to {area:392}; {npc:6251} stands on the hill above the docks."] = "Prenez un vol d'{zone:1454} pour {area:392} ; {npc:6251} se tient sur la colline au-dessus des quais.",

	-- Step 69: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maître de vol de {area:392}",

	-- Step 75: Gadgetzan
	-- {area:976} Gadgetzan · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["Flown in: {area:976}'s quests first, by the flight master, then the {area:2240} is a short ride north over the {zone:1446} border."] = "Arrivée en vol : d'abord les quêtes de {area:976}, près du maître de vol, puis la {area:2240} est à courte distance au nord, de l'autre côté de la frontière de {zone:1446}.",
	-- {npc:7407} Chief Engineer Bilgewhizzle · {npc:5204} Apothecary Zinge · {item:8523} Field Testing Kit · {zone:1458} Undercity
	["{npc:7407}: {npc:5204}'s {item:8523}, from the {zone:1458}"] = "",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}: the water pouches come from the same Wastewander camps"] = "",

	-- Step 76: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7804} Trenton Lighthammer · {quest:3042} Troll Temper
	["For your {area:978} run, in the next guide: {quest:2864} wants scarab shells, and {npc:7804}, a short walk from the flight master, {quest:3042} from the Sandfury trolls."] = "Pour votre expédition dans {area:978}, dans le prochain guide : {quest:2864} veut des carapaces de scarabée, et {npc:7804}, à quelques pas du maître de vol, de la {quest:3042} des trolls Furie-des-sables.",

	-- Step 77: Mirage Raceway
	-- {area:976} Gadgetzan · {zone:1446} Tanaris · {area:484} Freewind Post · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["Flown in to {area:976}: the raceway is a short ride north over the {zone:1446} border.\nThe road from {area:484} to {zone:1446} runs past the {area:2240} on the {area:439}: {npc:4454} is in the gnomes' camp beside the track, {npc:4630} and {npc:4709} by the goblins' camp. {npc:4630} first, then {npc:4709}, who runs off to keep Rizzle busy; then take Rizzle's plans from the gnomes' camp and bring them back to {npc:4630}."] = "Arrivé en vol à {area:976} : la piste n'est qu'à une courte chevauchée au nord, de l'autre côté de la frontière de {zone:1446}.\nLa route de {area:484} à {zone:1446} passe devant {area:2240}, sur les {area:439} : {npc:4454} est dans le camp des gnomes à côté de la piste, {npc:4630} et {npc:4709} près du camp des gobelins. D'abord {npc:4630}, puis {npc:4709}, qui part occuper Rizzle ; prenez ensuite les plans de Rizzle dans le camp des gnomes et rapportez-les à {npc:4630}.",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "{npc:4454} : {quest:1137}, de la part de Martek dans {zone:1418}",
	-- {npc:4630} Pozzik · {npc:2496} Baron Revilgaz · {area:35} Booty Bay
	["{npc:4630}: {npc:2496}'s word, from {area:35}"] = "",
	-- {npc:4706} Razzeric · {npc:4630} Pozzik
	["{npc:4706}, beside {npc:4630}"] = "{npc:4706}, à côté de {npc:4630}",

	-- Step 78: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "Vers {area:976}",

	-- Step 79: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} est la ville gobeline fortifiée juste après la frontière de {zone:1446}.",

	-- Step 81: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "{area:1937} : tuez-les au passage",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	-- was: ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Les bandits et les voleurs campent dans les dunes à l'est de {area:976}. Chaque Bat-le-désert peut porter une outre d'eau : Luglunket en veut cinq.\nAttention : les Voleurs Bat-le-désert (niveau 43-44) se déplacent camouflés et peuvent donc approcher sans être vus."
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five, and Bilgewhizzle five more.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "",

	-- Step 82: Gadgetzan
	-- {zone:1446} Tanaris
	["Keep the Model 4711-FTZ Power Source Bilgewhizzle gave you: it starts Tanaris Field Sampling, a two-hour timer, for the {zone:1446} guide at about 48, on the way back north from Scrimshank's hive."] = "",

	-- Step 83: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Allez au nord-est jusqu'au port gobelin sur la côte.",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "{npc:7882}, à l'intérieur",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "{npc:7881}, à l'intérieur",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on this guide's west sweep"] = "",
	-- {npc:260405} Wharfmaster Steamfizzle · {zone:2548} Riverglades
	["{npc:260405}, on the pier: Friz's errand from the {zone:2548}, if you carry it"] = "{npc:260405}, sur la jetée : la course de Friz depuis les {zone:2548}, si vous l'avez",

	-- Step 84: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "{area:1336} : tuez-les au passage",
	-- {npc:7883} Andre Firebeard · {item:9276} Pirate's Footlocker · {item:9250} Ship Schedule · {area:977} Steamwheedle Port
	-- was: ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "Au sud le long de la côte, les pirates des Mers du Sud tiennent la crique. {npc:7883} et la cargaison volée sont sur les quais, tout au bout. N'importe quel pirate peut lâcher un chapeau, les kidnappeurs le plus souvent.\nAttention : deux ou trois pirates se tiennent avec {npc:7883} (45), et beaucoup d'autres pirates de la ville rejoignent le combat une fois qu'il a commencé : éloignez d'abord ses gardes de lui."
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first.\nThe cove's pirates sometimes drop a {item:9276}: open it, and if it holds a {item:9250}, read it to start a quest for the Security Chief in {area:977}."] = "",
	["Upstairs"] = "À l'étage",
	-- {item:9250} Ship Schedule · {item:9276} Pirate's Footlocker
	["{item:9250}, from a {item:9276}"] = "",

	-- Step 85: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "{area:985} : tuez-les au passage",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "Les mages des ombres, les voleurs et les assassins campent au sud-est de {area:976}.\nAu sud-est de Gadgetzan, les bandits Bat-le-désert campent dans les dunes ; {npc:7847} se tient dans le camp est.\nAttention : les Voleurs Bat-le-désert restent camouflés hors combat, des voleurs cachés peuvent donc rejoindre un combat que vous lancez dans un camp.\nAttention : deux Voleurs Bat-le-désert camouflés l'accompagnent partout. À son camp d'apparition, deux mages des ombres et leurs serviteurs sont assez proches pour se joindre au combat. Près des tours, vous pouvez l'affronter sans eux.",

	-- Step 86: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what {area:1336} gave you. {area:976} is west of it."] = "Retournez au nord-est jusqu'au port : {npc:7881}, la {npc:15165} et le chef de la sécurité prennent ce que {area:1336} vous a donné. {area:976} se trouve à l'ouest.",
	-- {area:35} Booty Bay
	["for {area:35}, around level 51 (40-50/06)"] = "pour {area:35}, vers le niveau 51 (40-50/06)",
	-- {npc:7882} Security Chief Bilgewhizzle · {item:9250} Ship Schedule
	["{npc:7882}: the {item:9250}, if the cove gave you one"] = "",

	-- Step 88: Fly to Freewind Post
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maître de vol de {area:976}",

	-- Step 90: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "{npc:7777} se promène autour de {area:1099} : cherchez dans le cercle sur la carte",
	-- {npc:8115} Witch Doctor Uzer'i · {npc:263190} Tan'jani · {zone:2548} Riverglades
	["{npc:8115}: {npc:263190}'s errand from the {zone:2548}, if you carry it"] = "{npc:8115} : la course de {npc:263190} depuis les {zone:2548}, si vous l'avez",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	-- was: ["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115} : pour {zone:1454}, vers le niveau 45"
	["{npc:8115}: for {zone:1454}, around level 47"] = "",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, à l'intérieur",

	-- Step 91: Gordunni Outpost
	-- {npc:222233} Ohk'zi · {item:9466} Orwin's Shovel · {object:144064} Gordunni Dirt Mound
	-- was: ["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "Au nord des gnolls, les ogres tiennent un avant-poste sur une colline ; attirez les Ogres-mages Gordunni vers vous. Le Cobalt Gordunni est dans les tas de terre autour de l'avant-poste, et le Parchemin Gordunni est par terre à l'intérieur.\nAttention : {npc:222233} (niveau 43, élite) se tient dans l'avant-poste : attirez les ogres jusqu'à vous, loin de lui."
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him.\nUse {item:9466} on each {object:144064} around the outpost: the arrow goes from mound to mound."] = "",

	-- Step 92: Woodpaw north camp
	["Woodpaw north camp"] = "Camp Griffebois du nord",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "Les gnolls Patte-de-bois campent dans les collines juste au nord-ouest de Mojache ; n'importe lequel peut lâcher une crinière.\nAttention : tous les gnolls Patte-de-bois sauf l'Alpha fuient chercher de l'aide à 15 % de vie, ce qui peut attirer d'autres gnolls dans le combat.",

	-- Step 93: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863} : dans une heure",

	-- Step 94: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "{zone:1444} : tuez-les au passage",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "Les fées fléchetteuses voltigent au-dessus du bosquet juste à l'ouest de Mojache ; presque toutes lâchent une aile. Les alphas Patte-de-bois dirigent les camps au sud-ouest : tuez-les dans l'heure.\nAttention : la plupart des Alphas se tiennent dans de petits camps de tentes avec 2 à 4 autres gnolls qui se joignent au combat, et d'autres gnolls patrouillent entre les camps.",

	-- Step 96: Grimtotem camp
	["Grimtotem camp"] = "Camp du Totem sinistre",
	-- {npc:222286} Namida Grimtotem
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns.\nCareful: {npc:222286} (level 43, elite) stands in the camp: pull the raiders and shamans away from her."] = "Les taurens du Totem sinistre campent à côté du bosquet des Fées fléchetteuses ; Ecumeurs, Naturalistes et Chamans portent tous des Cornes de Totem sinistre.\nAttention : {npc:222286} (niveau 43, élite) se tient dans le camp : attirez les Ecumeurs et les Chamans loin d'elle.",

	-- Step 97: Woodpaw battle map
	["Woodpaw battle map"] = "Plan de bataille des Griffebois",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "Le Plan de bataille des Griffebois se trouve dans le camp Griffebois au sud de Mojache.",

	-- Step 98: Camp Mojache
	-- {npc:7875} Hadoken Swiftstrider · {quest:7731} Stinglasher · {zone:1445} Dustwallow Marsh
	["Carrying Tabetha's Task? {npc:7875} doesn't offer {quest:7731} while it is in your quest log: hand it in to Tabetha in {zone:1445} or abandon it first."] = "",
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 47"] = "",

	-- Step 99: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber.\nCareful: {quest:7731} is level 47: clear the hive around him and pull him alone at full health."] = "La ruche des Zukk'ash s'enfonce dans les collines au sud-est du camp ; {quest:7731} attend dans sa chambre la plus profonde.\nAttention : {quest:7731} est de niveau 47 : nettoyez la ruche autour de lui et attirez-le seul, avec toute votre vie.",

	-- Step 100: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "{area:2522} : tuez-les au passage",
	-- {area:1105} Feral Scar Vale
	["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb.\nCareful: the Mage-Lords (45-46) and the Shamans cast from range and the ruins are packed: pull one at a time from the edge."] = "Allez vers l'ouest depuis la ruche jusqu'aux ruines ogres sous {area:1105}. Chamans, démonistes et marteleurs les peuplent ; les Seigneurs-mages, au bout sud, portent l'orbe.\nAttention : les Seigneurs-mages (45-46) et les Chamans attaquent à distance et les ruines sont bondées : attirez-les un par un depuis le bord.",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "{npc:5234} se promène autour de {area:2522} : cherchez dans le cercle sur la carte",

	-- Step 101: Feral Scar Vale yetis
	-- {area:1105} Feral Scar Vale
	["{area:1105} yetis"] = "Yétis du {area:1105}",
	-- {area:1105} Feral Scar Vale
	["North-west of the ruins, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Au nord-ouest des ruines, les yétis ont leur tanière dans le {area:1105} ; chaque yéti peut y laisser tomber une peau épaisse.",

	-- Step 102: Rogue Vale screechers
	["Rogue Vale screechers"] = "Hurleurs des vallées insoumis",
	-- {area:1099} Camp Mojache · {area:1105} Feral Scar Vale · {item:10699} Yeh'kinya's Bramble · {npc:8579} Yeh'kinya · {area:977} Steamwheedle Port · {zone:1446} Tanaris
	-- plural, as words: Rogue Vale Screechers = {npc:5308} Rogue Vale Screecher
	["On the way back north-east towards {area:1099}, the Rogue Vale Screechers (44-46) hunt the open ground north of {area:1105}. Kill one, use {item:10699} on its body before you loot it, then talk to the spirit that rises: it is friendly. Three spirits in all; {npc:8579} takes them in {area:977} on your next {zone:1446} visit."] = "",

	-- Step 103: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "Seulement avec la balise de détresse : n'importe quelle bête, gnoll ou ogre de {zone:1444} peut la lâcher, environ une victime sur cent ; utilisez-la pour lancer la quête. Le robot se trouve dans une petite grotte du côté nord de {area:1105}, juste au nord-ouest des ruines. Escortez-le jusqu'au quai de la {area:1108} ; des yétis et des gorilles vous tendent des embuscades en chemin. Sa récompense vous attend à {area:35} pour une visite ultérieure.\nAttention : trois embuscades surviennent pendant l'escorte, et le robot vous prévient avant chacune. La première, 3 yétis, juste après que le robot a quitté la grotte et monte vers la route. La deuxième, 3 gorilles, sur le chemin qui longe la falaise. La troisième, environ 4 gnolls dont un lanceur de sorts, là où la route bifurque vers le quai.",

	-- Step 104: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "les yétis de la Balafre de rage, lors de la prochaine visite de {zone:1444}",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "{npc:7875} : pour {npc:7010} à {zone:1454}",
	-- {zone:1454} Orgrimmar · {zone:2652} Shen'dralas
	["for {zone:1454}, after {zone:2652}"] = "pour {zone:1454}, après {zone:2652}",
	-- {zone:2652} Shen'dralas · {area:1099} Camp Mojache · {zone:1443} Desolace · {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {npc:7311} Uthel'nay
	["{zone:2652} is next, a ride north from {area:1099} into {zone:1443}: keep your {zone:1454} hand-ins (Neeru, Zilzibin, {npc:4485}, {npc:7311}) for the flight there after it."] = "{zone:2652} est la suite, à une chevauchée au nord de {area:1099} en {zone:1443} : gardez vos quêtes à rendre à {zone:1454} (Neeru, Zilzibin, {npc:4485}, {npc:7311}) pour le vol qui suivra.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into town. The ships' captains, Seahorn's next request, are for your Stranglethorn stop at about 50."] = "Retournez en ville. Les capitaines de navires, prochaine demande de Seahorn, sont pour votre passage à Strangleronce vers le niveau 50.",
	-- ["Back to {area:976}"] = "Retour à {area:976}",
	-- ["Eastern Wastewander camps"] = "Camps Bat-le-désert de l'est",
	-- ["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Volez jusqu'à {area:1637}. Les frères Droffers tiennent leur boutique dans la Herse.",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the {object:172959}."] = "Prenez un vol pour {area:1637}. Dran et Malton Droffers tiennent leur boutique dans {object:172959}.",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Prenez un vol pour {area:484}, descendez par l'ascenseur à l'est du poste et traversez les Salines, puis allez au sud jusqu'à {zone:1446}.",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Prenez un vol pour {area:484}, puis allez à l'ouest par les canyons après {area:2237} ; la route monte dans la jungle de {zone:1444} jusqu'à {area:1099}.",
	-- ["Fly to {area:976}"] = "Prendre un vol pour {area:976}",
	-- ["Fly to {zone:1454}"] = "Prendre un vol pour {zone:1454}",
	-- ["Fly to {zone:1454}. From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "Volez jusqu'à {zone:1454}. Depuis le maître de vol : {object:172960}, puis la Herse, puis {object:172958}.",
	-- ["Fly to {zone:1454}. The Droffers brothers run their shop in the Drag.\n{object:172958}, then the {object:172960} and the {object:172961}."] = "Volez jusqu'à {zone:1454}. Les frères Droffers tiennent leur boutique dans la Herse.\n{object:172958}, puis {object:172960} et la {object:172961}.",
	-- ["Fly to {zone:1456}"] = "Prendre un vol pour {zone:1456}",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Galestriders : {npc:265756}, à {area:16638} sur l'Île de Zéphras.",
	-- ["Hearth to {area:1099}"] = "Pierre de foyer vers {area:1099}",
	-- ["In {area:35}: {npc:2494} on the docks, {npc:2486} by the inn, {npc:2498} inside it, MacKinley, {npc:737} and {npc:773} upstairs."] = "À {area:35} : {npc:2494} sur les quais, {npc:2486} près de l'Auberge, {npc:2498} à l'intérieur, MacKinley, {npc:737} et {npc:773} à l'étage.",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Continuez à l'ouest jusqu'à la côte. Les Enfouisseurs côtiers et les Claque-pinces côtiers des plages laissent tomber la Balise de détresse OOX-22/FE environ une fois sur quarante : si vous l'obtenez, utilisez-la pour commencer la quête.",
	-- ["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "Au nord des gnolls, les ogres tiennent un avant-poste sur une colline ; attirez les Ogres-mages Gordunni vers vous. Le Cobalt Gordunni est dans les tas de terre autour de l'avant-poste, et le Parchemin Gordunni est par terre à l'intérieur.\nAttention : {npc:222233} (niveau 43, élite) se tient dans l'avant-poste : attirez les ogres jusqu'à vous, loin de lui.",
	-- ["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "Continuez au sud-ouest vers la jungle au nord-est de Val-Brumeux : les trois pirates fantômes la hantent près des camps de Zanzil. {npc:2535} et {npc:2536} se tiennent ensemble, {npc:2537} plus à l'est. Tous les fidèles de Zanzil peuvent porter la mixture.\nAttention : les Sorciers-docteurs Zanzil (44) lancent des sorts et les camps sont bondés : attirez-les depuis le bord, un à la fois. {npc:2534} (46) lui-même se tient dans le camp sud vers 39.6,58.6, à quelques pas du fantôme de {npc:2537} : attirez {npc:2537} au nord ou à l'est avant de l'affronter.",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Seulement avec la balise de détresse : le robot se trouve dans une petite grotte au nord de {area:1105}. Escortez-le jusqu'au quai de la {area:1108} ; des yétis et des gorilles vous tendent des embuscades en chemin. Sa récompense vous attend à {area:35}, lors d'une visite ultérieure.",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Depuis {area:1978}, retournez au nord-ouest jusqu'à {area:75} et prenez un vol pour {object:3202}.",
	-- ["Ride back west to {area:976}."] = "Retournez à l'ouest jusqu'à {area:976}.",
	-- ["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Allez vers l'ouest depuis la ruche jusqu'aux ruines ogres sous {area:1105}. Chamans, Démonistes et Marteleurs Gordunni les peuplent ; les Seigneurs-mages Gordunni, au bout sud, portent l'Orbe Gordunni.",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Allez à l'ouest jusqu'au centre de {zone:1444}. Tuez un {npc:5308}, utilisez {item:10699} sur son cadavre et tuez l'esprit qui s'en élève.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Another race's trainer ({npc:4752} in {zone:1454}) teaches you only once you are Exalted with his city."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. Chaque race l'apprend auprès de son propre maître : le vôtre est {npc:4773}, à {area:159}, avec les chevaux squelettes de {npc:4731} (20 pièces d'or chacun) à côté d'elle. Le maître d'une autre race ({npc:4752} à {zone:1454}) ne vous l'enseigne qu'une fois Exalté auprès de sa ville.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. En Classic, chaque race l'apprend auprès du maître de sa race : le vôtre est {npc:3690} à {area:222}, avec les kodos de {npc:3685} (20 pièces d'or chacun) à côté de lui. Forever permet peut-être à toute race d'apprendre auprès de n'importe quel maître de monte (non confirmé) : essayez d'abord {npc:4752}, dans {object:172958} de {zone:1454}, car c'est le plus proche, et passez cette étape s'il vous l'enseigne.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. En Classic, chaque race l'apprend auprès du maître de sa race : le vôtre est {npc:4773} à {area:159}, avec les chevaux squelettes de {npc:4731} (20 pièces d'or chacun) à côté d'elle. Forever permet peut-être à toute race d'apprendre auprès de n'importe quel maître de monte (non confirmé) : essayez d'abord {npc:4752}, dans {object:172958} de {zone:1454}, car c'est le plus proche, et passez cette étape s'il vous l'enseigne.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. En Classic, chaque race l'apprend auprès du maître de sa race : le vôtre est {npc:7953} à {area:367}, sur la côte de {zone:1411}, avec les raptors de Zjolnir (20 pièces d'or chacun) à côté de lui. Forever permet peut-être à toute race d'apprendre auprès de n'importe quel maître de monte (non confirmé) : essayez d'abord {npc:4752}, dans {object:172958} de {zone:1454}, car c'est le plus proche, et passez cette étape s'il vous l'enseigne.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. {npc:4752} l'enseigne aux orcs dans {object:172958}, près du chenil de {npc:3362} ; aucun maître de monte skyborne n'est connu, les Éolides essaient donc aussi {npc:4752}. Les autres montures de votre race coûtent 20 pièces d'or chacune : Objets de collection, Montures · Niveau 40 a un guide pour chacune.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "Plus au sud sur la côte, les pirates des Mers du sud tiennent la crique. {npc:7883} et la cargaison volée sont sur les quais, tout au fond. Tout pirate peut laisser tomber un Chapeau de pirate des Mers du sud, les Kidnappeurs des mers du Sud le plus souvent.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "Au sud le long de la côte, les pirates des Mers du Sud tiennent la crique. {npc:7883} et la cargaison volée sont sur les quais, tout au bout. N'importe quel pirate peut lâcher un chapeau, les kidnappeurs le plus souvent.\nAttention : deux ou trois pirates se tiennent avec {npc:7883} (45), et beaucoup d'autres pirates de la ville rejoignent le combat une fois qu'il a commencé : éloignez d'abord ses gardes de lui.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "Au sud le long de la côte, les pirates des Mers du Sud tiennent la crique. {npc:7883} et la cargaison volée sont sur les quais, tout au bout. N'importe quel pirate peut lâcher un chapeau, les kidnappeurs le plus souvent.\nAttention : deux ou trois pirates se tiennent avec {npc:7883}, et beaucoup d'autres pirates de la ville rejoignent le combat une fois qu'il a commencé.",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Au sud de Baie-du-Butin, les bretteurs de la Voile sanglante campent sur {area:43} ; les cartes et les ordres se trouvent dans leurs tentes et dans la barque à côté du plus grand camp. Tout pirate de la Voile sanglante peut porter le tabac et l'œil de {npc:2493} : continuez jusqu'à avoir les deux.",
	-- ["Southern Gordunni ruins"] = "Ruines Gordunni du sud",
	-- ["Southern Wastewander camps"] = "Camps Bat-le-désert du sud",
	-- ["Sprite darters and Woodpaw alphas"] = "Fées fléchetteuses et Alphas Griffebois",
	-- ["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "Les gnolls Griffebois campent dans les collines juste au nord-ouest de Mojache ; chacun peut laisser tomber une Crinière de gnoll Griffebois.",
	-- ["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "La ruche des Zukk'ash s'enfonce dans les collines au sud-est du camp ; {quest:7731} attend dans sa chambre la plus profonde.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Les bandits et les voleurs campent dans les dunes à l'est de {area:976}. Chaque Bat-le-désert peut porter une outre d'eau : Luglunket en veut cinq.\nAttention : les Voleurs Bat-le-désert (niveau 43-44) se déplacent camouflés et peuvent donc approcher sans être vus.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "Les Bandits et Larrons Bat-le-désert campent dans les dunes à l'est de {area:976}. Chaque Bat-le-désert peut porter une Outre de Bat-le-désert : gardez-en dix, cinq pour chaque prime de l'Opérateur du robinet Luglunket.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Les bandits et les voleurs campent dans les dunes à l'est de {area:976}. Chaque Bat-le-désert peut porter une outre d'eau : gardez-en dix, cinq pour chacune des primes de Luglunket.\nAttention : les Voleurs Bat-le-désert (niveau 43-44) se déplacent camouflés et peuvent donc approcher sans être vus.",
	-- ["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "Le vol atterrit à {object:3202}. Les missions plus difficiles de Strangleronce, rapportées de votre première visite, sont à votre portée : le chef Brise-crâne, les camps de Zanzil, les pirates de {area:35}, la côte des nagas et {npc:1514}, avant le zeppelin pour {zone:1454}. Le {object:2076} près de Nimboya donne la quête du chef Brise-crâne.",
	-- ["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then the zeppelin tower."] = "Le vol atterrit à {object:3202} : {npc:2519} et {npc:2465}, puis la tour du zeppelin.",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Les Mages de l'ombre, Voleurs et Assassins Bat-le-désert campent au sud-est de {area:976}.",
	-- ["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "Les Fées fléchetteuses voltigent au-dessus du bosquet juste à l'ouest de Mojache ; presque toutes laissent tomber une aile. Les Alphas Griffebois dirigent les camps au sud-ouest : tuez-les dans l'heure.",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "Le zeppelin pour {object:3202} part de la tour juste au nord-est de la grande porte de {zone:1454}.",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "Le zeppelin pour {zone:1454} part de la tour à côté de {object:3202} ; il arrive juste devant la grande porte de {zone:1454}.",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Thysta, la maîtresse de vol, se tient juste à l'est de la tour des zeppelins. Prenez un vol pour {area:75} : le guide suivant commence là.",
	-- ["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them. Then follow the coast south to {area:35}."] = "À l'ouest jusqu'à la côte : les explorateurs nagas pataugent le long du rivage et portent les bottes de roseaux ; {object:759} bouillonne dans les collines juste à l'est. Suivez ensuite la côte au sud jusqu'à {area:35}.",
	-- ["Zeppelin to {object:3202}"] = "Zeppelin pour {object:3202}",
	-- ["Zeppelin to {zone:1458}"] = "Zeppelin pour {zone:1458}",
	-- ["Zeppelin tower"] = "Tour des zeppelins",
	-- ["for the {zone:1425}, around level 48"] = "pour {zone:1425}, vers le niveau 48",
	-- ["for {area:35}, around level 50"] = "pour {area:35}, vers le niveau 50",
	-- ["for {zone:1454}, around level 45"] = "pour {zone:1454}, vers le niveau 45",
	-- ["the {object:150075} in the square"] = "l'{object:150075} sur la place",
	-- ["water pouches in your bags"] = "Outres de Bat-le-désert dans vos sacs",
	-- ["{area:1099} flight master"] = "Maître de vol de {area:1099}",
	-- ["{area:976} is the walled goblin town just past the {area:440} border."] = "{area:976} est la ville gobeline fortifiée juste après la frontière de {area:440}.",
	-- ["{npc:2488}, on the top floor"] = "{npc:2488}, au dernier étage",
	-- ["{npc:4630}: the {item:5852} from {npc:2496}, if you carry them"] = "{npc:4630} : les {item:5852} de {npc:2496}, si vous les avez sur vous",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}, maîtresse de monte",
	-- ["{npc:6986}, the Drag"] = "{npc:6986}, la Herse",
	-- ["{npc:7010}, the Drag"] = "{npc:7010}, la Herse",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}, maître de monte",
	-- ["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115} : pour {zone:1454}, vers le niveau 45",
	-- ["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "{npc:8579} : les hurleurs vivent à {zone:1444}, lors de la prochaine visite de {zone:1444}",
}
