-- French (frFR): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aerie Peak
	-- {npc:7744} Innkeeper Thulfram
	["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",

	-- Step 2: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Chevauchez au sud-est jusqu'à l'{area:355}, le temple à degrés des Vilebranch au sud des {zone:1425}, et montez au sommet. Qiaga la Gardienne et {npc:8636} (élite, 50) s'y tiennent : touchez le sommet et redescendez aussitôt.",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Chevauchez vers le nord jusqu'à {area:351}, au milieu des {zone:1425}. Des Limaces vertes et des Limons de jade rampent tout autour.",

	-- Step 4: Aerie Peak
	-- {area:348} Aerie Peak
	["Hearth to {area:348}."] = "Pierre de foyer vers {area:348}.",
	["Hearthstone on cooldown? Ride back north-west."] = "Pierre de foyer en recharge ? Revenez au nord-ouest.",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "pour {quest:2990} au {area:1438}, plus tard",

	-- Step 5: Darkshire
	-- {area:348} Aerie Peak · {area:42} Darkshire
	["Fly from {area:348} to {area:42}."] = "Volez de {area:348} à {area:42}.",

	-- Step 6: The bloodmages
	["The bloodmages"] = "Les mages de sang",
	-- {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands
	["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Chevauchez vers l'est à travers le {zone:1430} jusqu'au {zone:1435}, puis vers le sud par la route jusqu'aux {zone:1419}. Le camp des mages de sang est le premier arrêt au bord de la route.",

	-- Step 7: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Continuez d'abord vers l'est par la route jusqu'au donjon : la {item:6091} expire une heure après {area:42}, et les bêtes des mages de sang prennent plus de temps que ça.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, au sommet du donjon",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "La tâche suivante de {npc:8022} Grimshade, {item:9471}, est une quête de {area:978} : passez-la.",

	-- Step 8: Boars and basilisks
	["Boars and basilisks"] = "Sangliers et basilics",
	-- plural, as words: Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Les Sangliers cendrés et les Basilics Rougepierre partagent les pentes au sud-ouest du donjon. Evitez les Sangliers infernaux plus au sud : ils sont de niveau 52.",

	-- Step 9: Scorpoks and snickerfangs
	["Scorpoks and snickerfangs"] = "Scorpoks et Raillecrocs",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Chevauchez vers l'ouest : les Raillecrocs affamées errent dans les collines arides juste au sud du camp des mages de sang ; les Aiguillonneurs scorpoks (niveau 50) parcourent le centre du nord. Les vautours {npc:5982} tournoient au-dessus de tout cela. Attirez-les un par un.",

	-- Step 10: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "Le second palier des mages de sang paie les mêmes morceaux avec un objet d'amélioration et sans expérience : passez-le.",

	-- Step 11: Thelsamar
	-- {area:1438} Nethergarde Keep · {area:144} Thelsamar
	["Ride back east to {area:1438} and fly to {area:144}."] = "Revenez vers l'est jusqu'au {area:1438} et volez jusqu'à {area:144}.",

	-- Step 12: Ironband's Excavation Site
	["Ride east along the south shore of the loch to Ironband's camp."] = "Chevauchez vers l'est le long de la rive sud du Loch jusqu'aux Excavations de Baguefer.",

	-- Step 13: The Uldaman dig
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "Les fouilles d'{area:1517}",
	-- {zone:1418} Badlands · {area:1517} Uldaman
	["Ride south through the pass into the {zone:1418}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Chevauchez vers le sud par le col jusqu'à la lisière nord des {zone:1418} : les troggs Cavepierre y creusent devant {area:1517}. Les Urnes en pierre gravée et les Champignons magenta se trouvent dans leurs grottes et tunnels, hors du donjon lui-même.",

	-- Step 14: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Revenez vers le nord jusqu'aux Excavations de Baguefer.",

	-- Step 16: Rut'theran Village
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Volez de {area:144} à {area:150}, prenez le bateau pour {area:442} et volez jusqu'au {area:702}.",
	["the book on her table"] = "le livre sur sa table",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "La course suivante de {npc:7907} Lightwind mène en {zone:1446} : passez-la.",
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916} : gardez-la, les plumes viennent à la fin du guide des {zone:1428}",

	-- Step 17: Temple of the Moon
	["Temple of the Moon"] = "Temple de la Lune",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Franchissez le portail vers {zone:1457}. Le Temple de la Lune se trouve au sud de la cité.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, à côté d'elle",

	-- Step 19: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, au sommet de l'arbre",
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "la terre vient du {zone:1449}, plus tard",
	-- {zone:1455} Ironforge
	["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Les maîtres druides se trouvent dans l'Enclave cénarienne ; {zone:1455} n'en a aucun",

	-- Step 20: Back to Thelsamar
	-- {area:144} Thelsamar
	["Back to {area:144}"] = "Retour à {area:144}",
	-- {area:144} Thelsamar · {zone:1427} Searing Gorge · {area:1446} Thorium Point · {zone:1418} Badlands · {area:340} Kargath
	["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Pierre de foyer vers {area:144}. Le guide de la {zone:1427} commence au {area:1446} : depuis ici, chevauchez vers le sud jusqu'aux {zone:1418}, à l'ouest au-delà de la ville horde de {area:340}, puis montez la piste vers la gorge.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Chevauchez vers le nord jusqu'à {area:351}, au milieu de {zone:1425}. Des Limaces vertes ({npc:2655}) et des Limons de jade ({npc:2656}) rampent tout autour.",
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and {item:1529} Oozes crawl all around it."] = "Chevauchez vers le nord jusqu'au {area:351} au centre des {zone:1425}. Des Limaces vertes et des Limons de {item:1529} rampent tout autour.",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Chevauchez au sud-est jusqu'à l'{area:355}, le temple à degrés des Vilebranch au sud des {zone:1425}, et montez au sommet. Qiaga la Gardienne et {npc:8636} (élite, 50) s'y tiennent : touchez le sommet et redescendez aussitôt.",
}
