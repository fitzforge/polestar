-- French (frFR): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Valley of Fangs
	-- {npc:2817} Rigglefuzz
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["{npc:2817}: Blue Pearls from Stranglethorn"] = "",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "La quête suivante de {npc:2817} ne rapporte pas d'expérience : passez-la.",

	-- Step 3: Boss Tho'grun
	-- {zone:1418} Badlands · {area:342} Camp Boff · {npc:2944} Boss Tho'grun
	["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Traversez les {zone:1418} vers l'ouest jusqu'au camp Crache-poussières de {area:342}. {npc:2944} se tient au centre, entouré de Chasseurs Wyrm et de Marteleurs Crache-poussières.",

	-- Step 4: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "Revenez à l'est jusqu'à {area:1898}.",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "La tâche suivante de {npc:2888} est une chasse élite : passez-la.",

	-- Step 5: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "Les Dragonnets flamboyants nichent dans le ravin à l'est de {npc:2888} ; laissez tranquilles les Gardiens des terres brûlées (élites). Le {item:4612} tombe rarement : prenez-le s'il tombe pendant que vous tuez des monstres.",

	-- Step 7: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "Vers le {zone:1432}",

	-- Step 8: Ironband's Excavation Site
	-- {zone:1432} Loch Modan
	["Ride north through the pass into {zone:1432} and east along the south shore to Ironband's camp."] = "",

	-- Step 9: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "Vers les {zone:1418}",

	-- Step 10: Badlands
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "Les fouilles d'{area:1517}",

	-- Step 11: The Uldaman dig
	-- {area:1517} Uldaman · {zone:1418} Badlands
	["Back through the pass: the Stonevault troggs dig outside {area:1517} at the {zone:1418}' northern edge. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "",
	-- {item:8047} Magenta Fungus Cap
	["{item:8047}; below ground"] = "{item:8047} ; sous terre",
	-- {object:2743} Carved Stone Urn
	["{object:2743}; below ground"] = "{object:2743} ; sous terre",

	-- Step 12: Back to Loch Modan
	-- {zone:1432} Loch Modan
	["Back to {zone:1432}"] = "",

	-- Step 13: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Revenez vers le nord jusqu'aux Excavations de Baguefer.",

	-- Step 14: Thelsamar
	-- {area:144} Thelsamar
	["Ride west along the loch to {area:144}."] = "",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}, sous terre",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Prendre un vol pour {area:271}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maître de vol de {area:144}",

	-- Step 16: Southshore
	-- {npc:3980} Raleigh the Devout
	["{npc:3980} preaches by the inn."] = "",
	-- {npc:3980} Raleigh the Devout
	["{npc:3980}, upstairs"] = "{npc:3980}, à l'étage",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "La mission suivante de Raleigh se déroule au {area:796} : passez-la.",

	-- Step 18: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Partez au nord-est hors d'{area:271} par la route des {zone:1425} ; {area:348} se trouve juste après la frontière. {npc:5635} tient sa cour au sommet, {quest:1450} s'occupe de la volière et {npc:7884} se tient près de l'auberge.",
	-- {quest:1450} Gryphon Master Talonaxe
	["{quest:1450}, inside"] = "{quest:1450}, à l'intérieur",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "{npc:7884}, à l'intérieur",
	-- {npc:7744} Innkeeper Thulfram
	["{npc:7744}: the last guide binds here, so this usually ticks at once; below ground"] = "{npc:7744} : le guide précédent vous fait lier votre pierre de foyer ici, donc ceci se coche généralement tout de suite ; sous terre",

	-- Step 19: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634} campe sur la route à l'est de {area:348}.",

	-- Step 20: Witherbark villages
	["Witherbark villages"] = "Villages de Fanécorce",
	-- {npc:5634} Rhapsody Shindigger
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace."] = "Les deux premières cages se trouvent ensemble dans le village de Fanécorce au sud de {npc:5634} ; la troisième est dans le village suivant, à l'est. Chaque troll Witherbark peut lâcher un collier.",

	-- Step 21: Aerie Peak
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884} paie toujours les colliers : rendez ceux en trop",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top; inside"] = "{npc:5636}, à côté du maître de vol au sommet ; à l'intérieur",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "La tâche suivante de Talonaxe attend un guide des {zone:1425} ultérieur.",

	-- Step 22: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Prendre un vol pour {area:150}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Maître de vol du {area:348}",

	-- Step 24: Theramore
	["Theramore"] = "Theramore",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} se tient sur les quais où accoste le bateau.",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "{npc:4944}, au dernier étage",
	-- {npc:4968} Lady Jaina Proudmoore
	["{npc:4968}, on the top floor"] = "{npc:4968}, au dernier étage",
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}, à l'intérieur",

	-- Step 25: Cortello's Riddle
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "À l'intérieur de {area:498}",

	-- Step 26: Theramore flight master
	["Theramore flight master"] = "Maître de vol de Theramore",

	-- Step 28: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Démoniste : {quest:3631}",
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["From Theramore, ride north into the {zone:1413} to {area:392}, or fly if you know its flight path. {npc:6251} teaches in the house by the bank."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Blue Pearls from Stranglethorn"] = "Perles bleues de Strangleronce",
	-- ["Fly to {area:144}"] = "Prendre un vol pour {area:144}",
	-- ["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "Volez jusqu'à {area:392} ; {npc:6251} enseigne dans la maison près de la banque. Revenez ensuite à Theramore en vol.",
	-- ["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "Volez jusqu'à {area:608}, descendez vers le sud à travers {zone:1443} jusqu'en {zone:1444} et suivez la route jusqu'au quai de {area:1108} ; le bateau rejoint {area:1116}, où commence le guide suivant.",
	-- ["Into {area:38}"] = "Vers le {area:38}",
	-- ["On to Feathermoon"] = "En route pour le Bastion de Pennelune",
	-- ["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "Partez au nord jusqu'à {area:144} et volez jusqu'à {area:271}. {npc:3980} prêche près de l'auberge.",
	-- ["Ride north-east out of {area:271} on the road into the {area:47}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Chevauchez vers le nord-est en sortant d'{area:271} par la route jusque dans les {area:47} ; {area:348} se trouve juste après la frontière. {npc:5635} tient sa cour au sommet, {quest:1450} s'occupe de la volière et {npc:7884} se tient près de l'auberge.",
	-- ["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. Falstad holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Partez au nord-est hors d'{area:271} par la route des {zone:1425} ; {area:348} se trouve juste après la frontière. Falstad tient sa cour au sommet, {quest:1450} s'occupe de la volière et {npc:7884} se tient près de l'auberge.",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Partez au sud hors du {zone:1432}, par le col, jusqu'aux {zone:1418} ; {npc:2860} campe sur le site de fouilles.",
	-- ["Ride west across the {area:3} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Chevauchez vers l'ouest à travers les {area:3} jusqu'au camp Crache-poussières du {area:342}. {npc:2944} se tient au milieu, entouré de Chasseurs Wyrm et de Marteleurs.",
	-- ["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "Partez à l'ouest vers {area:1877}, au milieu des {zone:1418} ; {npc:2817} campe à côté de Martek.",
	-- ["Take the boat to Theramore from the far pier."] = "Prenez le bateau pour Theramore au quai le plus éloigné.",
	-- ["Talonaxe's next task waits for a later {area:47} guide."] = "La tâche suivante de Talonaxe attend un guide des {area:47} ultérieur.",
	-- ["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "Le squelette de nain décrépi se trouve en bordure du camp des troggs Cavepierre ; {quest:739}, le meurtrier d'Agmond, rôde parmi les Briseurs d'os Cavepierre.",
	-- ["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "pour {npc:4454} aux {area:439} : le guide de {zone:1446} les traverse au niveau 45, gardez-le",
	-- ["grind on {npc:2725} at {area:339}, {zone:1418}"] = "tuez des {npc:2725} au {area:339}, {zone:1418}",
	-- ["{npc:1573}, the {object:32372}"] = "{npc:1573}, {object:32372}",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} campe seul dans {area:1898}, au sud-est du site de fouilles.",
	-- ["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "Le cocktail de {npc:5634} demande des ingrédients de Kalimdor : passez-le.",
	-- ["{npc:5636}, beside the flight master at the top"] = "{npc:5636}, à côté du maître de vol au sommet",
	-- ["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",
}
