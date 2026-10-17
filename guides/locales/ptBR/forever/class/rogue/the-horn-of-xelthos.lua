-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/the-horn-of-xelthos (forever/class/rogue/the-horn-of-xelthos.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277210} Pyrewood Signet Ring · {area:236} Shadowfang Keep
	["The {item:277210}, C's payment for a solo job inside {area:236}."] = "O {item:277210}, o pagamento de C por um serviço solo dentro do {area:236}.",

	-- Step 1: C's dead drop
	["C's dead drop"] = "O esconderijo de C",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. Read C's note."] = "{object:410369} é um baú perto de {area:204}, no sul da Floresta de Pinhaprata, logo ao sul do {area:236}. Leia o bilhete de C.",

	-- Step 2: Veenix
	-- {npc:4086} Veenix · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {area:467} Stonetalon Peak · {item:210187} Venture Co. Work Order
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers around him carry them."] = "{npc:4086}, um goblin amigável às duas facções, fica entre a Empreendimentos S.A. no {area:461}, no leste da Cordilheira das Torres de Pedra. A Horda voa até o {area:460}; a Aliança, até o {area:467}. Ele quer uma {item:210187} antes de entregar explosivos: os Madeireiros da Empreendimentos S.A. em volta dele as carregam.",

	-- Step 3: Shadowfang Keep
	-- {item:210186} Breaching Charge
	["Go in alone. The {item:210186} gets you past the courtyard gate; the data does not say where in the keep the horn lies."] = "Entre sozinho. A {item:210186} passa pelo portão do pátio; os dados não dizem onde a trompa está no castelo.",
	-- {item:210183} Horn of Xelthos · {area:236} Shadowfang Keep
	["{item:210183}, inside {area:236}"] = "{item:210183}, dentro do {area:236}",

	-- Step 4: Back to the dead drop
	["Back to the dead drop"] = "Volte ao esconderijo",
	-- {object:410369} Dead Drop · {item:210183} Horn of Xelthos
	["Place the horn in the {object:410369} near Pyrewood. C's payment is the second {item:210183} quest at the same chest."] = "Coloque a trompa na {object:410369} perto da vila. O pagamento de C é a segunda missão {item:210183} no mesmo baú.",
}
