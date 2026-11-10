-- French (frFR): the guide forever/reputation/kirin-tor (forever/reputation/kirin-tor.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Kirin Tor Reputation"] = "Réputation : Kirin Tor",
	-- {area:279} Dalaran
	["New in Forever: {area:279}'s mages sell Azure armour recipes at Friendly and their tabard at Exalted."] = "Nouveau dans Forever : les mages de {area:279} vendent des recettes d'armure d'azur à Amical et leur tabard à Exalté.",
	-- {skill:164} Blacksmithing · {skill:165} Leatherworking · {skill:197} Tailoring
	["Eight Azure helm and shoulder recipes at Friendly ({skill:164}, {skill:165}, {skill:197})"] = "Huit recettes de casque et d'épaulières d'azur à Amical ({skill:164}, {skill:165}, {skill:197})",

	-- Step 1: Skyborne: the recipes now
	["Skyborne: the recipes now"] = "Éolides : les recettes tout de suite",
	-- {faction:2740} Kirin Tor · {npc:32287} Archmage Alvareaux · {area:279} Dalaran
	["Alliance Skyborne start Friendly with the {faction:2740}, and their arrival quests The Magical City of Dalaran and Exploring the Alliance pay 100 more each, so {npc:32287} sells you the Azure recipes at once (10g each, they need skill 175). He stands upstairs in the building with the {faction:2740} banners in {area:279}, past the Sky Enclave. Buy the ones for your profession."] = "Les Éolides de l'Alliance commencent à Amical avec le {faction:2740}, et leurs quêtes d'arrivée The Magical City of Dalaran et Exploring the Alliance rapportent 100 de plus chacune : l'{npc:32287} vous vend donc tout de suite les recettes d'azur (10 po chacune, il faut la compétence 175). Il se tient à l'étage du bâtiment aux bannières du {faction:2740}, à {area:279}, après le Sky Enclave. Achetez celles de votre métier.",

	-- Step 2: An Alarming Request
	-- {npc:247264} Emissary Jacques · {faction:2740} Kirin Tor · {area:271} Southshore · {npc:246748} Archmage Modera · {area:1338} Lordamere Lake · {area:279} Dalaran
	["{npc:247264} of the {faction:2740} waits in {area:271}. He sends you to {npc:246748}'s image by the shore of {area:1338}, outside {area:279}'s walls. The {faction:2740} quests start at level 24 to 30 and pay full reputation at any level in Forever."] = "",

	-- Step 3: Archmage Modera's image
	-- {npc:246748} Archmage Modera
	["{npc:246748}'s image"] = "L'image de l'{npc:246748}",
	-- {item:277507} Dalaran Sewer Key
	["you get the {item:277507} with it"] = "vous recevez la {item:277507} avec",

	-- Step 4: The City of Dalaran
	["The City of Dalaran"] = "City of Dalaran",
	-- {quest:92457} Starving Arcane · {npc:246020} Shade of the Archmage · {npc:246748} Archmage Modera · {item:251961} Arcane Mote · {faction:2740} Kirin Tor
	["The City of Dalaran is a dungeon for levels 28 to 33: go in through the sewers with the key Modera gave you. The arcane elementals throughout the city count for {quest:92457}. The {npc:246020}, the last boss, waits in the Purple Parlor above the Violet Citadel (a portal by {npc:246748} in the Citadel takes you up) and drops the {item:251961}. Beta players saw every kill in the dungeon pay {faction:2740} reputation, the bosses the most. Group of five advised below level 35."] = "City of Dalaran est un donjon pour les niveaux 28 à 33 : entrez par les égouts avec la clé que Modera vous a donnée. Les élémentaires des arcanes de toute la ville comptent pour {quest:92457}. L'{npc:246020}, le dernier boss, attend dans le Salon pourpre au-dessus de la Citadelle pourpre (un portail près de l'{npc:246748}, dans la Citadelle, vous y fait monter) et laisse la {item:251961}. Les joueurs de la bêta ont vu chaque victime du donjon rapporter de la réputation auprès du {faction:2740}, les boss le plus. Groupe de cinq conseillé sous le niveau 35.",
	-- {item:251961} Arcane Mote · {npc:246020} Shade of the Archmage
	["{item:251961}, from the {npc:246020}"] = "{item:251961}, sur l'{npc:246020}",

	-- Step 5: Back to Modera's image
	["Back to Modera's image"] = "Retour auprès de l'image de Modera",

	-- Step 6: Archmage Celindra
	-- {npc:252085} Archmage Celindra · {area:279} Dalaran
	["{npc:252085} waits in the Violet Citadel in {area:279}."] = "L'{npc:252085} attend dans la Citadelle pourpre à {area:279}.",

	-- Step 7: Past Due
	-- {npc:264265} Magus Olvek · {area:279} Dalaran · {npc:6487} Arcanist Doan · {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades
	["{npc:264265} in {area:279} wants a book back from {npc:6487}, the last boss of the {area:796}'s Library (levels 33 to 41), in {zone:1420}."] = "Le {npc:264265}, à {area:279}, veut récupérer un livre auprès de l'{npc:6487}, le dernier boss de la Bibliothèque du {area:796} (niveaux 33 à 41), dans les {zone:1420}.",

	-- Step 8: Arcanist Doan
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades
	["The {area:796} stands in the north-east of {zone:1420}; Doan waits at the end of the Library wing. Group of five advised below level 40."] = "Le {area:796} se dresse au nord-est des {zone:1420} ; Doan attend au bout de l'aile de la Bibliothèque. Groupe de cinq conseillé sous le niveau 40.",
	-- {item:273169} The Lost Magic of the Runemasters · {npc:6487} Arcanist Doan
	["{item:273169}, from {npc:6487}"] = "{item:273169}, sur l'{npc:6487}",

	-- Step 9: Back to Magus Olvek
	-- {npc:264265} Magus Olvek
	["Back to {npc:264265}"] = "Retour auprès du {npc:264265}",

	-- Step 10: City of Dalaran runs to Friendly
	["City of Dalaran runs to Friendly"] = "City of Dalaran jusqu'à Amical",
	["The quests leave a non-Skyborne at about 320 of the 3,000 Friendly needs. The rest comes from kills in the City of Dalaran dungeon: run it until Friendly. How much each kill pays is not in the game's data; the bosses pay the most. At 60 you clear it alone."] = "Les quêtes laissent un personnage non Éolide à environ 320 des 3 000 nécessaires pour Amical. Le reste vient des victimes du donjon City of Dalaran : faites-le jusqu'à Amical. Ce que rapporte chaque victime n'est pas dans les données du jeu ; les boss rapportent le plus. Au niveau 60, vous le nettoyez seul.",

	-- Step 11: Archmage Alvareaux: the Azure recipes
	-- {npc:32287} Archmage Alvareaux
	["{npc:32287}: the Azure recipes"] = "{npc:32287} : les recettes d'azur",
	-- {npc:32287} Archmage Alvareaux · {faction:2740} Kirin Tor · {area:279} Dalaran
	["{npc:32287} sells the Azure helm and shoulder recipes at Friendly, 10g each (skill 175). He stands upstairs in the building with the {faction:2740} banners in {area:279}. Buy the ones for your profession."] = "L'{npc:32287} vend les recettes de casque et d'épaulières d'azur à Amical, 10 po chacune (compétence 175). Il se tient à l'étage du bâtiment aux bannières du {faction:2740}, à {area:279}. Achetez celles de votre métier.",

	-- Step 12: City of Dalaran runs to Exalted
	["City of Dalaran runs to Exalted"] = "City of Dalaran jusqu'à Exalté",
	["Nothing is sold at Honored or Revered in the game's data. Friendly to Exalted is 39,000 reputation, all from City of Dalaran kills. In Classic most dungeon kills stop paying at Honored or Revered; whether these do is not known yet."] = "Rien n'est vendu à Honoré ou à Révéré dans les données du jeu. D'Amical à Exalté, il faut 39 000 de réputation, toute venant des victimes de City of Dalaran. Dans Classic, la plupart des victimes de donjon cessent de rapporter à Honoré ou à Révéré ; on ne sait pas encore si c'est le cas ici.",

	-- Step 13: The Kirin Tor Tabard
	-- {item:285327} Kirin Tor Tabard
	["The {item:285327}"] = "Le {item:285327}",
	-- {npc:32287} Archmage Alvareaux · {npc:28776} Elizabeth Ross · {area:279} Dalaran · {item:285327} Kirin Tor Tabard
	["{npc:32287} and {npc:28776}, the tabard vendor in {area:279}, sell the {item:285327} at Exalted for 25g."] = "L'{npc:32287} et {npc:28776}, la vendeuse de tabards de {area:279}, vendent le {item:285327} à Exalté pour 25 po.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:247264} of the {faction:2740} waits in {area:271}. He sends you to {npc:246748}'s image by the shore of {area:1338}, outside {area:279}'s walls. The {faction:2740} quests start at level 24 to 30 and pay full reputation while they are at most 5 levels below you; in Classic a quest 6+ levels below you pays less (a fifth at 60)."] = "L'{npc:247264} du {faction:2740} attend à {area:271}. Il vous envoie auprès de l'image de l'{npc:246748}, au bord du {area:1338}, hors des murs de {area:279}. Les quêtes du {faction:2740} commencent au niveau 24 à 30 et rapportent toute leur réputation tant qu'elles sont au plus 5 niveaux sous le vôtre ; dans Classic, une quête de 6 niveaux ou plus sous le vôtre rapporte moins (un cinquième au niveau 60).",
}
