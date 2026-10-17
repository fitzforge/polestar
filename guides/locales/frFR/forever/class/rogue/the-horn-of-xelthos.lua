-- French (frFR): the guide forever/class/rogue/the-horn-of-xelthos (forever/class/rogue/the-horn-of-xelthos.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277210} Pyrewood Signet Ring · {area:236} Shadowfang Keep
	["The {item:277210}, C's payment for a solo job inside {area:236}."] = "La {item:277210}, le paiement de C pour une mission en solo dans le {area:236}.",

	-- Step 1: C's dead drop
	["C's dead drop"] = "La boîte aux lettres morte de C",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. Read C's note."] = "La {object:410369} est un coffre près de {area:204}, dans le sud de la Forêt des Pins argentés (Silverpine Forest), juste au sud du {area:236}. Lisez le mot de C.",

	-- Step 2: Veenix
	-- {npc:4086} Veenix · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {area:467} Stonetalon Peak · {item:210187} Venture Co. Work Order
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers around him carry them."] = "{npc:4086}, un gobelin amical envers les deux factions, se tient parmi la KapitalRisk au {area:461}, à l'est des Serres-Rocheuses. La Horde vole jusqu'à la {area:460} ; l'Alliance jusqu'au {area:467}. Il veut un {item:210187} avant de vous remettre des explosifs : les Déboiseurs de la KapitalRisk autour de lui en portent.",

	-- Step 3: Shadowfang Keep
	-- {item:210186} Breaching Charge
	["Go in alone. The {item:210186} gets you past the courtyard gate; the data does not say where in the keep the horn lies."] = "Entrez seul. La {item:210186} vous fait passer la porte de la cour ; les données n'indiquent pas où se trouve la corne dans le donjon.",
	-- {item:210183} Horn of Xelthos · {area:236} Shadowfang Keep
	["{item:210183}, inside {area:236}"] = "{item:210183}, dans le {area:236}",

	-- Step 4: Back to the dead drop
	["Back to the dead drop"] = "Retour à la boîte aux lettres morte",
	-- {object:410369} Dead Drop · {item:210183} Horn of Xelthos
	["Place the horn in the {object:410369} near Pyrewood. C's payment is the second {item:210183} quest at the same chest."] = "Déposez la corne dans la {object:410369} près de Bois-du-Bûcher. Le paiement de C est la deuxième quête {item:210183}, au même coffre.",
}
