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

	-- Step 2: Vilebranch Soothsayers
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Vilebranch Soothsayers"] = "Devins Vilebranch",
	-- {area:355} Altar of Zul · {npc:7996} Qiaga the Keeper · {npc:8636} Morta'gya the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["The Vilebranch Soothsayers (46-47) walk the ground around the foot of the {area:355}: their totems are for Maret Firetend. Careful: {npc:7996} and {npc:8636} (50, elites) stand on the altar's south-east side: take the Soothsayers on its west side, away from them, and stay off the altar."] = "Les Devins Vilebranch (46-47) parcourent le terrain au pied de l'{area:355} : leurs totems sont pour Maret Gardefeu. Attention : {npc:7996} et {npc:8636} (50, élites) se tiennent du côté sud-est de l'autel : attaquez les Devins du côté ouest, loin d'elles, et restez hors de l'autel.",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it.\nCareful: Panthers move around the area in stealth."] = "Chevauchez vers le nord jusqu'à {area:351}, au milieu des {zone:1425}. Des Limaces vertes et des Limons de jade rampent tout autour.\nAttention : des panthères se déplacent camouflées dans le secteur.",

	-- Step 4: Wildkin feathers
	["Wildkin feathers"] = "Plumes de sauvage",
	-- {npc:7916} Erelas Ambersky · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {area:351} Skulk Rock
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["{npc:7916}'s Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam: pick them up as you ride between the altar and {area:351}."] = "Les Plumes de sauvage d'{npc:7916} jonchent le sol des {zone:1425}, au sud et à l'est d'{area:348}, là où rôdent les chouettes-ours : ramassez-les en chevauchant entre l'autel et {area:351}.",

	-- Step 5: Lost Gryphon Eggs
	-- plural, as words: Lost Gryphon Eggs = {item:279229} Lost Gryphon Egg
	["Lost Gryphon Eggs"] = "Œufs de griffon perdus",
	-- {area:348} Aerie Peak
	["On the way back to {area:348}: the lost gryphon eggs lie in the hills just east of the aviary."] = "Sur le chemin du retour vers {area:348} : les œufs de griffon perdus se trouvent dans les collines juste à l'est de la volière.",

	-- Step 6: Aerie Peak
	["Inside"] = "À l'intérieur",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, inside"] = "{npc:5636}, à l'intérieur",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "pour {quest:2990} au {area:1438}, plus tard",
	-- {npc:270263} Farseer Maret Firetend
	["{npc:270263}, just east of the aviary"] = "{npc:270263}, juste à l'est de la volière",

	-- Step 7: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Maître de vol du {area:348}",

	-- Step 8: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 9: Ironforge inn
	-- {area:1537} Ironforge
	["{area:1537} inn"] = "Auberge d'{area:1537}",
	-- {object:26486} Stonefire Tavern · {zone:1427} Searing Gorge · {area:144} Thelsamar
	["Set your hearth at the {object:26486}: the {zone:1427} guide starts with the hearth back here and the gryphon to {area:144}."] = "Liez votre pierre de foyer à {object:26486} : le guide de la {zone:1427} commence par un retour ici avec la pierre de foyer, puis le griffon vers {area:144}.",

	-- Step 10: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Tram pour {zone:1453}",

	-- Step 12: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Prendre un vol pour {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 15: The bloodmages
	["The bloodmages"] = "Les mages de sang",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep
	["The bloodmages' camp is the first stop beside the road into the {zone:1419}, north-west of {area:1438}."] = "Le camp des mages de sang est la première étape au bord de la route qui entre dans les {zone:1419}, au nord-ouest du {area:1438}.",
	-- {npc:7505} Bloodmage Drazial · {zone:1419} Blasted Lands
	["{npc:7505}: keep the five, their beasts (48-53) wait for the level-52 {zone:1419} stop"] = "{npc:7505} : gardez les cinq, leurs bêtes (48-53) attendront l'étape du niveau 52 dans les {zone:1419}",

	-- Step 16: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}."] = "Continuez d'abord vers l'est par la route jusqu'au donjon : la {item:6091} expire une heure après {area:42}.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, au sommet du donjon",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "La tâche suivante de {npc:8022} Grimshade, {item:9471}, est une quête de {area:978} : passez-la.",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "{npc:5385}, à l'étage",

	-- Step 17: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Prendre un vol pour {area:35}",
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "Maître de vol du {area:1438}",

	-- Step 18: Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor"] = "« Loup de mer » MacKinley, au dernier étage",
	["\"Sea Wolf\" MacKinley, if the Stranglethorn guide didn't give it"] = "« Loup de mer » MacKinley, si le guide de Strangleronce ne l'a pas donnée",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor, if the Stranglethorn guide didn't give it"] = "{npc:2487}, dernier étage, si le guide de Strangleronce ne l'a pas donnée",
	-- {npc:2494} Privateer Bloads
	["{npc:2494}, if the Stranglethorn guide didn't give it"] = "{npc:2494}, si le guide de Strangleronce ne l'a pas donnée",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, if the Stranglethorn guide didn't give it"] = "{npc:2498}, à l'intérieur, si le guide de Strangleronce ne l'a pas donnée",

	-- Step 19: Wild Shore: kill these as you meet them
	-- {area:43} Wild Shore
	["{area:43}: kill these as you meet them"] = "{area:43} : tuez-les au passage",
	-- {area:43} Wild Shore · {area:35} Booty Bay
	["The charts and orders lie in the pirate camp on the {area:43}, just south of {area:35}; its Swashbucklers walk the shore. The Warlocks and Swashbucklers (41-43) are under you now."] = "Les cartes et les ordres se trouvent dans le camp pirate de la {area:43}, juste au sud de {area:35} ; ses Bretteurs parcourent le rivage. Les Démonistes et les Bretteurs (41-43) sont maintenant en dessous de votre niveau.",

	-- Step 20: Booty Bay
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}, dernier étage",

	-- Step 21: The Bloodsail captains
	["The Bloodsail captains"] = "Les capitaines de la Voile sanglante",
	-- {area:35} Booty Bay · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["The three Bloodsail ships lie at anchor off the coast just south of {area:35}: {npc:2550} (45) and {npc:2548} (46) on the nearer decks, {npc:2546} (48) on the flagship, each with a crew of 42-45 pirates. Swim out, clear each deck from the edge and pull one at a time."] = "Les trois navires de la Voile sanglante mouillent au large, juste au sud de {area:35} : {npc:2550} (45) et {npc:2548} (46) sur les ponts les plus proches, {npc:2546} (48) sur le vaisseau amiral, chacun avec un équipage de pirates de niveau 42-45. Nagez jusqu'à eux, nettoyez chaque pont depuis le bord et attirez-les un par un.",

	-- Step 23: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "Explorateurs nagas",
	["Leave town by the tunnel and ride north along the coast past the Bloodsail camp: the naga comb the beaches beyond it and drop the reeds."] = "Quittez la ville par le tunnel et chevauchez vers le nord le long de la côte après le camp de la Voile sanglante : les nagas ratissent les plages au-delà et lâchent les roseaux.",

	-- Step 24: Zanzil's village
	["Zanzil's village"] = "Le village de Zanzil",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Ride on north along the coast to Zanzil's village. Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Continuez vers le nord le long de la côte jusqu'au village de Zanzil. Tous les adeptes de Zanzil peuvent lâcher le mélange ; {npc:2537} se promène dans le sud du camp.",

	-- Step 25: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535} et {npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536} stand together in the hills just north of Zanzil's village."] = "{npc:2535} et {npc:2536} se tiennent ensemble dans les collines juste au nord du village de Zanzil.",

	-- Step 26: Gorilla hills
	["Gorilla hills"] = "Collines des gorilles",
	-- {area:35} Booty Bay · {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Gorilla Fangs = {item:2799} Gorilla Fang · Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride back south-east to the Mistvale gorilla hills above {area:35}. {npc:1449} sits among the gorillas: take ten Gorilla Fangs from the Elder Mistvale Gorillas first."] = "Retournez au sud-est vers les collines des gorilles de Valbrume au-dessus de {area:35}. {npc:1449} se trouve parmi les gorilles : prenez d'abord dix Crocs de gorille sur les Anciens gorilles de Valbrume.",

	-- Step 27: Unbagwa's ritual
	["Unbagwa's ritual"] = "Le rituel d'Unbagwa",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "Remettez les crocs et restez sur place : trois vagues de gorilles arrivent, {npc:1514} en dernier.\nAttention : les trois vagues de gorilles s'enchaînent avec peu de répit, puis vient {npc:1514}. Commencez avec toute votre vie et votre mana, et restez près d'Unbagwa. Certaines classes ont du mal seules : avec un ami, c'est facile.",
	-- {npc:1449} Witch Doctor Unbagwa · {area:1742} Spirit Den
	["{npc:1449}, inside {area:1742}"] = "{npc:1449}, à l'intérieur de {area:1742}",

	-- Step 28: Booty Bay
	["Ride back down to town."] = "Redescendez jusqu'à la ville.",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it, the Un'Goro guide lands there"] = "pour le {npc:2616} à Theramore : gardez-le, le guide d'Un'Goro y arrive",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "La course suivante de {npc:2498} concernant Zanzil commence à {zone:1441} : passez-la.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, à l'intérieur",
	["MacKinley's next task sends you after elite ogres: skip it."] = "La tâche suivante de MacKinley vous envoie contre des ogres élites : passez-la.",

	-- Step 29: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {quest:8552} demande un groupe de 2. Passez-la si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- Step 33: Facing Negolash
	-- {npc:1494} Negolash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1494} (level 52 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:1494} (élite de niveau 52) demande un groupe de 2. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Les Sangliers cendrés et les Basilics Rougepierre partagent les pentes au sud-ouest du donjon. Evitez les Sangliers infernaux plus au sud : ils sont de niveau 52.",
	-- ["Back to {area:144}"] = "Retour à {area:144}",
	-- ["Boars and basilisks"] = "Sangliers et basilics",
	-- ["Boat to {area:17203}"] = "Bateau pour {area:17203}",
	-- ["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Volez de {area:144} à {area:150}, prenez le bateau pour {area:442} et volez jusqu'au {area:702}.",
	-- ["Fly from {area:348} to {area:42}."] = "Volez de {area:348} à {area:42}.",
	-- ["Fly to {area:144}"] = "Prendre un vol pour {area:144}",
	-- ["Fly to {area:150}"] = "Prendre un vol pour {area:150}",
	-- ["Fly to {area:442}"] = "Prendre un vol pour {area:442}",
	-- ["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Pierre de foyer vers {area:144}. Le guide de la {zone:1427} commence au {area:1446} : depuis ici, chevauchez vers le sud jusqu'aux {zone:1418}, à l'ouest au-delà de la ville horde de {area:340}, puis montez la piste vers la gorge.",
	-- ["Hearth to {area:348}."] = "Pierre de foyer vers {area:348}.",
	-- ["Hearthstone on cooldown? Ride back north-west."] = "Pierre de foyer en recharge ? Revenez au nord-ouest.",
	-- ["Into {area:38}"] = "Vers le {area:38}",
	-- ["Into {area:3}"] = "Vers les {area:3}",
	-- ["Portal to {area:141}"] = "Portail pour {area:141}",
	-- ["Portal to {zone:1438}"] = "Portail vers {zone:1438}",
	-- ["Ride back east to {area:1438} and fly to {area:144}."] = "Revenez vers l'est jusqu'au {area:1438} et volez jusqu'à {area:144}.",
	-- ["Ride back north to Ironband's camp."] = "Revenez vers le nord jusqu'aux Excavations de Baguefer.",
	-- ["Ride east along the south shore of the loch to Ironband's camp."] = "Chevauchez vers l'est le long de la rive sud du Loch jusqu'aux Excavations de Baguefer.",
	-- ["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Chevauchez vers l'est à travers le {zone:1430} jusqu'au {zone:1435}, puis vers le sud par la route jusqu'aux {zone:1419}. Le camp des mages de sang est le premier arrêt au bord de la route.",
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Chevauchez vers le nord jusqu'à {area:351}, au milieu des {zone:1425}. Des Limaces vertes et des Limons de jade rampent tout autour.",
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and {item:1529} Oozes crawl all around it."] = "Chevauchez vers le nord jusqu'au {area:351} au centre des {zone:1425}. Des Limaces vertes et des Limons de {item:1529} rampent tout autour.",
	-- ["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Continuez d'abord vers l'est par la route jusqu'au donjon : la {item:6091} expire une heure après {area:42}, et les bêtes des mages de sang prennent plus de temps que ça.",
	-- ["Ride south through the pass into the {area:3}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Chevauchez vers le sud par le col jusqu'à la bordure nord des {area:3} : les troggs Cavepierre y creusent devant {area:1517}. Les urnes sculptées et les touffes de champignons magenta se trouvent dans leurs grottes et leurs tunnels, hors du donjon lui-même.",
	-- ["Ride south through the pass into the {zone:1418}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Chevauchez vers le sud par le col jusqu'à la lisière nord des {zone:1418} : les troggs Cavepierre y creusent devant {area:1517}. Les Urnes en pierre gravée et les Champignons magenta se trouvent dans leurs grottes et tunnels, hors du donjon lui-même.",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Chevauchez au sud-est jusqu'à l'{area:355}, le temple à degrés des Vilebranch au sud des {zone:1425}, et montez au sommet. Qiaga la Gardienne et {npc:8636} (élite, 50) s'y tiennent : touchez le sommet et redescendez aussitôt.",
	-- ["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Chevauchez vers l'ouest : les Raillecrocs affamées errent dans les collines arides juste au sud du camp des mages de sang ; les Aiguillonneurs scorpoks (niveau 50) parcourent le centre du nord. Les vautours {npc:5982} tournoient au-dessus de tout cela. Attirez-les un par un.",
	-- ["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time.\nAshmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52.\nCareful: Scorpok Stingers use {spell:5416}; {npc:8301} adds Knockdown.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else."] = "Chevauchez vers l'ouest : des Raillecrocs affamées parcourent les collines arides juste au sud du camp des mages de sang ; des Aiguillonneurs scorpoks (niveau 50) trottinent au milieu du nord. Des {npc:5982} (des vautours) tournoient au-dessus de tout cela. Attirez-les un par un.\nDes Sangliers cendrés et des Basilics Rougepierre partagent les pentes au sud-ouest du donjon. Évitez les Sangliers infernaux plus au sud : ils sont de niveau 52.\nAttention : les Aiguillonneurs scorpoks utilisent {spell:5416} ; {npc:8301} y ajoute Renversement.\nAttention : deux élites rôdent ici : {npc:221740} (50) au milieu de la zone vers 44,34, et {npc:247015} (55) sur la crête vers 39,32. Si vous en voyez un, chassez ailleurs.",
	-- ["Scorpoks and snickerfangs"] = "Scorpoks et Raillecrocs",
	-- ["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Franchissez le portail vers {zone:1457}. Le Temple de la Lune se trouve au sud de la cité.",
	-- ["Temple of the Moon"] = "Temple de la Lune",
	-- ["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "Le second palier des mages de sang paie les mêmes morceaux avec un objet d'amélioration et sans expérience : passez-le.",
	-- ["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Les maîtres druides se trouvent dans l'Enclave cénarienne ; {zone:1455} n'en a aucun",
	-- ["The {area:1517} dig"] = "Les fouilles d'{area:1517}",
	-- ["the book on her table"] = "le livre sur sa table",
	-- ["the soil comes from {zone:1449}, later"] = "la terre vient du {zone:1449}, plus tard",
	-- ["{area:144} flight master"] = "Maître de vol de {area:144}",
	-- ["{area:2418} flight master"] = "Maître de vol de la {area:2418}",
	-- ["{area:42} flight master"] = "Maître de vol de {area:42}",
	-- ["{area:702} flight master"] = "Maître de vol du {area:702}",
	-- ["{item:8047}; below ground"] = "{item:8047} ; sous terre",
	-- ["{npc:1470}, below ground"] = "{npc:1470}, sous terre",
	-- ["{npc:3516}, at the top of the tree"] = "{npc:3516}, au sommet de l'arbre",
	-- ["{npc:7740}, beside her"] = "{npc:7740}, à côté d'elle",
	-- ["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- ["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "La course suivante de {npc:7907} Lightwind mène en {zone:1446} : passez-la.",
	-- ["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916} : gardez-la, les plumes viennent à la fin du guide des {zone:1428}",
	-- ["{object:2743}; below ground"] = "{object:2743} ; sous terre",
	-- ["{zone:1419}: kill these as you meet them"] = "{zone:1419} : tuez-les au passage",
}
