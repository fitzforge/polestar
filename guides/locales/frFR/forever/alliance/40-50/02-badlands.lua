-- French (frFR): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge
	["{npc:1573}, the {object:32372}"] = "{npc:1573}, {object:32372}",

	-- Step 2: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Partez au sud hors du {zone:1432}, par le col, jusqu'aux {zone:1418} ; {npc:2860} campe sur le site de fouilles.",

	-- Step 3: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} campe seul dans {area:1898}, au sud-est du site de fouilles.",

	-- Step 4: Agmond's End
	-- {quest:739} Murdaloc
	["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "Le squelette de nain décrépi se trouve en bordure du camp des troggs Cavepierre ; {quest:739}, le meurtrier d'Agmond, rôde parmi les Briseurs d'os Cavepierre.",

	-- Step 5: Rigglefuzz
	-- {area:1877} Valley of Fangs · {zone:1418} Badlands · {npc:2817} Rigglefuzz
	["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "Partez à l'ouest vers {area:1877}, au milieu des {zone:1418} ; {npc:2817} campe à côté de Martek.",
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["Blue Pearls from Stranglethorn"] = "Perles bleues de Strangleronce",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "La quête suivante de {npc:2817} ne rapporte pas d'expérience : passez-la.",

	-- Step 6: Boss Tho'grun
	-- {zone:1418} Badlands · {area:342} Camp Boff · {npc:2944} Boss Tho'grun
	["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Traversez les {zone:1418} vers l'ouest jusqu'au camp Crache-poussières de {area:342}. {npc:2944} se tient au centre, entouré de Chasseurs Wyrm et de Marteleurs Crache-poussières.",

	-- Step 7: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "Revenez à l'est jusqu'à {area:1898}.",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "La tâche suivante de {npc:2888} est une chasse élite : passez-la.",

	-- Step 8: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "Les Dragonnets flamboyants nichent dans le ravin à l'est de {npc:2888} ; laissez tranquilles les Gardiens des terres brûlées (élites). Le {item:4612} tombe rarement : prenez-le s'il tombe pendant que vous tuez des monstres.",
	-- {npc:2725} Scalding Whelp · {area:339} Lethlor Ravine · {zone:1418} Badlands
	["grind on {npc:2725} at {area:339}, {zone:1418}"] = "tuez des {npc:2725} au {area:339}, {zone:1418}",

	-- Step 10: Southshore
	-- {area:144} Thelsamar · {area:271} Southshore · {npc:3980} Raleigh the Devout
	["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "Partez au nord jusqu'à {area:144} et volez jusqu'à {area:271}. {npc:3980} prêche près de l'auberge.",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "La mission suivante de Raleigh se déroule au {area:796} : passez-la.",

	-- Step 11: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Partez au nord-est hors d'{area:271} par la route des {zone:1425} ; {area:348} se trouve juste après la frontière. {npc:5635} tient sa cour au sommet, {quest:1450} s'occupe de la volière et {npc:7884} se tient près de l'auberge.",

	-- Step 12: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634} campe sur la route à l'est de {area:348}.",
	-- {npc:5634} Rhapsody Shindigger
	["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "Le cocktail de {npc:5634} demande des ingrédients de Kalimdor : passez-le.",

	-- Step 13: Witherbark villages
	["Witherbark villages"] = "Villages de Fanécorce",
	-- {npc:5634} Rhapsody Shindigger
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace."] = "Les deux premières cages se trouvent ensemble dans le village de Fanécorce au sud de {npc:5634} ; la troisième est dans le village suivant, à l'est. Chaque troll Witherbark peut lâcher un collier.",

	-- Step 14: Aerie Peak
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884} paie toujours les colliers : rendez ceux en trop",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top"] = "{npc:5636}, à côté du maître de vol au sommet",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "La tâche suivante de Talonaxe attend un guide des {zone:1425} ultérieur.",

	-- Step 15: Menethil Harbor
	["Take the boat to Theramore from the far pier."] = "Prenez le bateau pour Theramore au quai le plus éloigné.",

	-- Step 16: Theramore
	["Theramore"] = "Theramore",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} se tient sur les quais où accoste le bateau.",

	-- Step 17: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Démoniste : {quest:3631}",
	-- {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "Volez jusqu'à {area:392} ; {npc:6251} enseigne dans la maison près de la banque. Revenez ensuite à Theramore en vol.",

	-- Step 18: On to Feathermoon
	["On to Feathermoon"] = "En route pour le Bastion de Pennelune",
	-- {area:608} Nijel's Point · {zone:1443} Desolace · {zone:1444} Feralas · {area:1108} Forgotten Coast · {area:1116} Feathermoon Stronghold
	["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "Volez jusqu'à {area:608}, descendez vers le sud à travers {zone:1443} jusqu'en {zone:1444} et suivez la route jusqu'au quai de {area:1108} ; le bateau rejoint {area:1116}, où commence le guide suivant.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. Falstad holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Partez au nord-est hors d'{area:271} par la route des {zone:1425} ; {area:348} se trouve juste après la frontière. Falstad tient sa cour au sommet, {quest:1450} s'occupe de la volière et {npc:7884} se tient près de l'auberge.",
	-- ["Talonaxe's next task waits for a later {zone:1425} guide."] = "La tâche suivante de Talonaxe attend un guide des {zone:1425} ultérieur.",
}
