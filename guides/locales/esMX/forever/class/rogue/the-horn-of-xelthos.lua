-- Spanish (Latin America) (esMX): the guide forever/class/rogue/the-horn-of-xelthos (forever/class/rogue/the-horn-of-xelthos.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["The {object:410369} is a chest in a house just outside {area:204} in southern Silverpine, south of {area:236}. Open it and read C's note: the job has to be done alone, out of any group."] = "{object:410369} es un cofre en una casa justo afuera de {area:204}, en el sur de Bosque de Argénteos, al sur de {area:236}. Ábrelo y lee la nota de C: el trabajo hay que hacerlo solo, fuera de cualquier grupo.",

	-- Step 2: Veenix
	-- {npc:4086} Veenix · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {area:467} Stonetalon Peak · {item:210187} Venture Co. Work Order · {spell:921} Pick Pocket
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon, a short way north-east of {area:460}. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers (level 18) working around him carry them in their pockets. Stealth up behind one and {spell:921} it; killing them does not give it."] = "{npc:4086}, un goblin amistoso con las dos facciones, está entre los de Ventura y Cía. en {area:461}, en el este de Sierra Espolón, a poca distancia al noreste de {area:460}. La Horda vuela a {area:460}; la Alianza a {area:467}. Quiere una {item:210187} antes de darte explosivos: los leñadores de Ventura y Cía. (nivel 18) que trabajan a su alrededor las llevan en los bolsillos. Ponte en sigilo detrás de uno y usa {spell:921}; matarlos no te la da.",
	-- {spell:921} Pick Pocket · {npc:3989} Venture Co. Logger · {item:210187} Venture Co. Work Order
	["{spell:921} a {npc:3989} for a {item:210187}"] = "{spell:921} a un {npc:3989} para una {item:210187}",

	-- Step 3: Shadowfang Keep
	-- {item:210186} Breaching Charge · {item:5140} Flash Powder · {item:210213} Sister's Half-Key · {item:210212} Brother's Half-Key
	["Go in alone and use the {item:210186} at the courtyard gate. Players also report a freed prisoner opening the courtyard door for you: if you die while he is opening it, stay dead until it is open; it stays open once you release. If you know Vanish, bring {item:5140} and check its cooldown before entering; keep it ready for a failed approach. Pickpocket the sister in the dining hall for the {item:210213}, then the brother in the room reached by turning right at the top of the stairs for the {item:210212} (a level 20 rogue without Vanish may need ranks in Master of Deception to reach the second one unseen). Combine them somewhere safe: this breaks stealth. Free a bag slot first: opening the chest with full bags can use up the key without giving the horn. Return to the courtyard stables and use the combined key on the chest for the horn. Stay clear of the nearby elites; the minimum quest level does not guarantee a safe approach."] = "Entra solo y usa {item:210186} en la puerta del patio. Los jugadores también dicen que un prisionero liberado te abre la puerta del patio: si mueres mientras la abre, quédate muerto hasta que esté abierta; queda abierta cuando liberas el espíritu. Si conoces Esfumarse, lleva {item:5140} y revisa su reutilización antes de entrar; tenlo listo por si falla el acercamiento. Roba a la hermana en el comedor para {item:210213} y luego al hermano en la sala a la que llegas doblando a la derecha arriba de la escalera para {item:210212} (un pícaro de nivel 20 sin Esfumarse puede necesitar rangos en Maestro del engaño para llegar al segundo sin ser visto). Combínalas en un lugar seguro: esto rompe el sigilo. Libera antes un espacio en las bolsas: abrir el cofre con las bolsas llenas puede gastar la llave sin darte el cuerno. Vuelve a los establos del patio y usa la llave combinada sobre el cofre para el cuerno. Mantente lejos de los élites cercanos; el nivel mínimo de la misión no garantiza un acercamiento seguro.",
	-- {item:210183} Horn of Xelthos · {area:236} Shadowfang Keep
	["{item:210183}, inside {area:236}"] = "{item:210183}, dentro de {area:236}",

	-- Step 4: Back to the dead drop
	["Back to the dead drop"] = "De vuelta al buzón secreto",
	-- {object:410369} Dead Drop
	["Open the {object:410369} again, the chest outside Pyrewood you took the job from, and hand in the horn there. C's payment is a second hand-in at the same chest, with nothing to accept first, and it may not be there right away: players have waited from a quarter of an hour to two hours. Check a capital mailbox for C's follow-up letter on your next planned city visit, then return to this chest for it. Do not repeat the dungeon just because the payment is not yet offered."] = "Abre {object:410369} otra vez, el cofre cerca de Piroleña donde tomaste el trabajo, y entrega ahí el cuerno. El pago de C es una segunda entrega en el mismo cofre, sin nada que aceptar antes, y puede que no esté ahí enseguida: hay jugadores que han esperado de un cuarto de hora a dos horas. Revisa el buzón de una capital en tu próxima visita planeada para ver la carta de C, y luego vuelve a este cofre por él. No repitas la mazmorra solo porque el pago todavía no se ofrece.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Go in alone. The {item:210186} gets you past the courtyard gate; the data does not say where in the keep the horn lies."] = "Entra solo. {item:210186} te permite pasar la puerta del patio; los datos no dicen en qué parte del castillo está el cuerno.",
	-- ["Place the horn in the {object:410369} near Pyrewood. C's payment is the second {item:210183} quest at the same chest."] = "Coloca el cuerno en {object:410369}, cerca de Piroleña. El pago de C es la segunda misión de {item:210183} en el mismo cofre.",
	-- ["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. Read C's note."] = "{object:410369} es un cofre cerca de {area:204}, en el sur de Bosque de Argénteos, justo al sur de {area:236}. Lee la nota de C.",
	-- ["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers around him carry them."] = "{npc:4086}, un goblin amistoso con ambas facciones, está entre los de Ventura y Cía. en {area:461}, al este de Sierra Espolón. La Horda vuela a {area:460}; la Alianza, a {area:467}. Quiere {item:210187} antes de entregarte explosivos: los Madereros de Ventura y Cía. que lo rodean las llevan.",
}
