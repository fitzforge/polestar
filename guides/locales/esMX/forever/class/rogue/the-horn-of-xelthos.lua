-- Spanish (Latin America) (esMX): the guide forever/class/rogue/the-horn-of-xelthos (forever/class/rogue/the-horn-of-xelthos.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277210} Pyrewood Signet Ring · {area:236} Shadowfang Keep
	["The {item:277210}, C's payment for a solo job inside {area:236}."] = "{item:277210}, el pago de C por un trabajo en solitario dentro de {area:236}.",

	-- Step 1: C's dead drop
	["C's dead drop"] = "El buzón secreto de C",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. Read C's note."] = "{object:410369} es un cofre cerca de {area:204}, en el sur de Bosque de Argénteos, justo al sur de {area:236}. Lee la nota de C.",

	-- Step 2: Veenix
	-- {npc:4086} Veenix · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {area:467} Stonetalon Peak · {item:210187} Venture Co. Work Order
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers around him carry them."] = "{npc:4086}, un goblin amistoso con ambas facciones, está entre los de Ventura y Cía. en {area:461}, al este de Sierra Espolón. La Horda vuela a {area:460}; la Alianza, a {area:467}. Quiere {item:210187} antes de entregarte explosivos: los Madereros de Ventura y Cía. que lo rodean las llevan.",

	-- Step 3: Shadowfang Keep
	-- {item:210186} Breaching Charge
	["Go in alone. The {item:210186} gets you past the courtyard gate; the data does not say where in the keep the horn lies."] = "Entra solo. {item:210186} te permite pasar la puerta del patio; los datos no dicen en qué parte del castillo está el cuerno.",
	-- {item:210183} Horn of Xelthos · {area:236} Shadowfang Keep
	["{item:210183}, inside {area:236}"] = "{item:210183}, dentro de {area:236}",

	-- Step 4: Back to the dead drop
	["Back to the dead drop"] = "De vuelta al buzón secreto",
	-- {object:410369} Dead Drop · {item:210183} Horn of Xelthos
	["Place the horn in the {object:410369} near Pyrewood. C's payment is the second {item:210183} quest at the same chest."] = "Coloca el cuerno en {object:410369}, cerca de Piroleña. El pago de C es la segunda misión de {item:210183} en el mismo cofre.",
}
