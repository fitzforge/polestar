-- French (frFR): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}, {object:172957} : gardez-la pour {zone:1451}",

	-- Step 2: Fly to the Crossroads
	-- {area:380} Crossroads
	["Fly to the {area:380}"] = "Prendre un vol pour {area:380}",

	-- Step 3: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "Les caisses de {npc:256386}",
	-- {npc:256386} Dokimi · {area:380} Crossroads
	["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386} se tient à {area:380}. Ouvrez chaque caisse qu'elle vous remet et rapportez-lui ce qu'elle contient.",

	-- Step 4: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Prendre un vol pour {area:392}",

	-- Step 5: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "L'atelier de Liv Rizzlefix se trouve au bout nord des quais de {area:392} ; le {object:149036} est à l'intérieur.",
	-- {object:149036} Marvon's Chest · {item:10556} Stone Circle
	["Open {object:149036} for the {item:10556}"] = "Ouvrez le {object:149036} pour obtenir le {item:10556}",

	-- Step 6: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901} Waterseer campe sur le rivage, juste au nord de {area:392}.",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "L'eau purifiée retourne à {area:2479}, à {zone:1448} : gardez-la pour plus tard.",

	-- Step 7: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",

	-- Step 8: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "Dans {object:172961}. Ayez l'Etoffe de laine, l'Etoffe de soie et l'Etoffe de tisse-mage dans vos sacs.",

	-- Step 9: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "Dans {object:172958}.",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "Les deux dons d'{item:14047} se rendent plus loin dans l'itinéraire : commencez à mettre de l'{item:14047} de côté.",

	-- Step 10: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Prendre un vol pour {area:1237}",

	-- Step 12: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Allez à l'est jusqu'aux ruines sur la côte. Remplissez les quatre fioles du Chimiste Cuely aux bassins le long du rivage ; des nagas Fouette-bile patrouillent entre eux.",

	-- Step 13: Thalassian Base Camp
	-- {area:1227} Bay of Storms
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}."] = "Les elfes de sang campent sur les falaises au nord-est, près de {area:1227}.",

	-- Step 14: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Le camp de {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "Le camp de Rimtori se trouve à l'extrémité est du camp de base. Lisez-y le {object:151286}, puis tuez le magus.",

	-- Step 15: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Retournez à l'ouest jusqu'à {area:1237}.",

	-- Step 16: Belgrom Rockmaul
	-- {area:1637} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["Fly to {area:1637}; {npc:4485} is in the {object:172958}."] = "Prenez un vol pour {area:1637} ; {npc:4485} Rockmaul se trouve dans {object:172958}.",

	-- Step 17: Zeppelin to the Undercity
	-- {zone:1458} Undercity
	["Zeppelin to the {zone:1458}"] = "Zeppelin pour {zone:1458}",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity
	["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "La tour des zeppelins se trouve juste au nord-est de la grande porte de {zone:1454} ; prenez le zeppelin pour {zone:1458}.",
	["Zeppelin tower"] = "Tour des zeppelins",

	-- Step 18: The Apothecarium
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}, à côté de lui",

	-- Step 19: Royal Quarter
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}, tout près",
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050} se rend à {npc:10778}, dans {zone:1422} : gardez-la.",

	-- Step 21: Prompt Potion Runner
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "{npc:11044}, dans l'Apothicarium",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:11044}, in the {object:36072}"] = "{npc:11044}, dans {object:36072}",
}
