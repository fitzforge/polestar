-- French (frFR): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper · {npc:7996} Qiaga the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down.\nCareful: Elite trolls guard the top platform, including {npc:7996} and {npc:8636}, along with several Vilebranch Soothsayers. The soothsayers cast spells and are linked to the rest of the group."] = "Chevauchez vers le sud-est jusqu'à l'{area:355}, le temple à degrés des Vilebranch au sud des {zone:1425}, et montez au sommet. Qiaga et {npc:8636} (élite, niveau 50) s'y tiennent : touchez le sommet et redescendez aussitôt.\nAttention : des trolls élites gardent la plate-forme du sommet, dont {npc:7996} et {npc:8636}, ainsi que plusieurs Devins Vilebranch. Les devins lancent des sorts et sont liés au reste du groupe.",

	-- Step 2: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it.\nCareful: Panthers move around the area in stealth."] = "Chevauchez vers le nord jusqu'à {area:351}, au milieu des {zone:1425}. Des Limaces vertes et des Limons de jade rampent tout autour.\nAttention : des panthères se déplacent camouflées dans le secteur.",

	-- Step 3: Aerie Peak
	["Inside"] = "À l'intérieur",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, inside"] = "{npc:5636}, à l'intérieur",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "pour {quest:2990} au {area:1438}, plus tard",

	-- Step 4: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Maître de vol du {area:348}",

	-- Step 5: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 6: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Tram pour {zone:1453}",

	-- Step 8: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "Prendre un vol pour {area:69}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 9: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "Maître de vol de la {area:2418}",

	-- Step 10: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Prendre un vol pour {area:144}",

	-- Step 11: Thelsamar
	-- {zone:1427} Searing Gorge · {area:144} Thelsamar
	["Set your hearth here: the {zone:1427} guide starts from {area:144}."] = "",

	-- Step 12: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Prendre un vol pour {area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maître de vol de {area:144}",

	-- Step 15: Rut'theran Village
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "La course suivante de {npc:7907} Lightwind mène en {zone:1446} : passez-la.",
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916} : gardez-la, les plumes viennent à la fin du guide des {zone:1428}",
	["the book on her table"] = "le livre sur sa table",

	-- Step 17: Temple of the Moon
	["Temple of the Moon"] = "Temple de la Lune",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Franchissez le portail vers {zone:1457}. Le Temple de la Lune se trouve au sud de la cité.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, à côté d'elle",

	-- Step 21: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, au sommet de l'arbre",

	-- Step 23: Cenarion Enclave
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "la terre vient du {zone:1449}, plus tard",

	-- Step 24: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portail vers {zone:1438}",

	-- Step 25: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Prendre un vol pour {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maître de vol du {area:702}",

	-- Step 26: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Bateau pour {area:17203}",

	-- Step 27: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "",

	-- Step 30: The bloodmages
	["The bloodmages"] = "Les mages de sang",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep
	["The bloodmages' camp is the first stop beside the road into the {zone:1419}, north-west of {area:1438}."] = "Le camp des mages de sang est la première étape au bord de la route qui entre dans les {zone:1419}, au nord-ouest du {area:1438}.",

	-- Step 31: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Continuez d'abord vers l'est par la route jusqu'au donjon : la {item:6091} expire une heure après {area:42}, et les bêtes des mages de sang prennent plus de temps que ça.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, au sommet du donjon",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "La tâche suivante de {npc:8022} Grimshade, {item:9471}, est une quête de {area:978} : passez-la.",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "{npc:5385}, à l'étage",

	-- Step 32: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "{zone:1419} : tuez-les au passage",
	-- {npc:5982} Black Slayer · {spell:5416} Venom Sting · {npc:8301} Clack the Reaver
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger · Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time.\nAshmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52.\nCareful: Scorpok Stingers use {spell:5416}; {npc:8301} adds Knockdown."] = "Chevauchez vers l'ouest : des Raillecrocs affamées parcourent les collines arides juste au sud du camp des mages de sang ; des Aiguillonneurs scorpoks (niveau 50) trottinent au milieu du nord. Des {npc:5982} (des vautours) tournoient au-dessus de tout cela. Attirez-les un par un.\nDes Sangliers cendrés et des Basilics Rougepierre partagent les pentes au sud-ouest du donjon. Évitez les Sangliers infernaux plus au sud : ils sont de niveau 52.\nAttention : les Aiguillonneurs scorpoks utilisent {spell:5416} ; {npc:8301} y ajoute Renversement.",

	-- Step 33: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "Le second palier des mages de sang paie les mêmes morceaux avec un objet d'amélioration et sans expérience : passez-le.",

	-- Step 34: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Prendre un vol pour {area:35}",
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "Maître de vol du {area:1438}",

	-- Step 35: Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor"] = "« Loup de mer » MacKinley, au dernier étage",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}, dernier étage",

	-- Step 36: The Bloodsail captains
	["The Bloodsail captains"] = "Les capitaines de la Voile sanglante",
	-- {area:35} Booty Bay · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["The three Bloodsail ships lie at anchor off the coast just south of {area:35}: {npc:2550} (45) and {npc:2548} (46) on the nearer decks, {npc:2546} (48) on the flagship, each with a crew of 42-45 pirates. Swim out, clear each deck from the edge and pull one at a time."] = "",

	-- Step 38: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {quest:8552} demande un groupe de 2. Passez-la si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- Step 42: Facing Negolash
	-- {npc:1494} Negolash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1494} (level 52 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:1494} (élite de niveau 52) demande un groupe de 2. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Les Sangliers cendrés et les Basilics Rougepierre partagent les pentes au sud-ouest du donjon. Evitez les Sangliers infernaux plus au sud : ils sont de niveau 52.",
	-- ["Back to {area:144}"] = "Retour à {area:144}",
	-- ["Boars and basilisks"] = "Sangliers et basilics",
	-- ["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Volez de {area:144} à {area:150}, prenez le bateau pour {area:442} et volez jusqu'au {area:702}.",
	-- ["Fly from {area:348} to {area:42}."] = "Volez de {area:348} à {area:42}.",
	-- ["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Pierre de foyer vers {area:144}. Le guide de la {zone:1427} commence au {area:1446} : depuis ici, chevauchez vers le sud jusqu'aux {zone:1418}, à l'ouest au-delà de la ville horde de {area:340}, puis montez la piste vers la gorge.",
	-- ["Hearth to {area:348}."] = "Pierre de foyer vers {area:348}.",
	-- ["Hearthstone on cooldown? Ride back north-west."] = "Pierre de foyer en recharge ? Revenez au nord-ouest.",
	-- ["Into {area:38}"] = "Vers le {area:38}",
	-- ["Into {area:3}"] = "Vers les {area:3}",
	-- ["Portal to {area:141}"] = "Portail pour {area:141}",
	-- ["Ride back east to {area:1438} and fly to {area:144}."] = "Revenez vers l'est jusqu'au {area:1438} et volez jusqu'à {area:144}.",
	-- ["Ride back north to Ironband's camp."] = "Revenez vers le nord jusqu'aux Excavations de Baguefer.",
	-- ["Ride east along the south shore of the loch to Ironband's camp."] = "Chevauchez vers l'est le long de la rive sud du Loch jusqu'aux Excavations de Baguefer.",
	-- ["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Chevauchez vers l'est à travers le {zone:1430} jusqu'au {zone:1435}, puis vers le sud par la route jusqu'aux {zone:1419}. Le camp des mages de sang est le premier arrêt au bord de la route.",
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Chevauchez vers le nord jusqu'à {area:351}, au milieu des {zone:1425}. Des Limaces vertes et des Limons de jade rampent tout autour.",
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and {item:1529} Oozes crawl all around it."] = "Chevauchez vers le nord jusqu'au {area:351} au centre des {zone:1425}. Des Limaces vertes et des Limons de {item:1529} rampent tout autour.",
	-- ["Ride south through the pass into the {area:3}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Chevauchez vers le sud par le col jusqu'à la bordure nord des {area:3} : les troggs Cavepierre y creusent devant {area:1517}. Les urnes sculptées et les touffes de champignons magenta se trouvent dans leurs grottes et leurs tunnels, hors du donjon lui-même.",
	-- ["Ride south through the pass into the {zone:1418}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Chevauchez vers le sud par le col jusqu'à la lisière nord des {zone:1418} : les troggs Cavepierre y creusent devant {area:1517}. Les Urnes en pierre gravée et les Champignons magenta se trouvent dans leurs grottes et tunnels, hors du donjon lui-même.",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Chevauchez au sud-est jusqu'à l'{area:355}, le temple à degrés des Vilebranch au sud des {zone:1425}, et montez au sommet. Qiaga la Gardienne et {npc:8636} (élite, 50) s'y tiennent : touchez le sommet et redescendez aussitôt.",
	-- ["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Chevauchez vers l'ouest : les Raillecrocs affamées errent dans les collines arides juste au sud du camp des mages de sang ; les Aiguillonneurs scorpoks (niveau 50) parcourent le centre du nord. Les vautours {npc:5982} tournoient au-dessus de tout cela. Attirez-les un par un.",
	-- ["Scorpoks and snickerfangs"] = "Scorpoks et Raillecrocs",
	-- ["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Les maîtres druides se trouvent dans l'Enclave cénarienne ; {zone:1455} n'en a aucun",
	-- ["The {area:1517} dig"] = "Les fouilles d'{area:1517}",
	-- ["{area:42} flight master"] = "Maître de vol de {area:42}",
	-- ["{item:8047}; below ground"] = "{item:8047} ; sous terre",
	-- ["{npc:1470}, below ground"] = "{npc:1470}, sous terre",
	-- ["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- ["{object:2743}; below ground"] = "{object:2743} ; sous terre",
}
