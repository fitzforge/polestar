-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/horde/paladin-warhorse (forever/collectibles/mounts/horde/paladin-warhorse.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse (Forsaken)"] = "Caballo de guerra de paladín (Renegados)",
	["Your first mount at 40, summoned at will: a Forsaken paladin buys no horse and pays no riding trainer."] = "Tu primera montura a nivel 40, invocada a voluntad: un paladín renegado no compra caballo ni le paga a un instructor de equitación.",

	-- Step 1: Report to Danitha
	-- {npc:260093} Garen Largo · {zone:1458} Undercity · {npc:246378} Danitha Morr · {area:16602} Bandarion Keep
	["At 40 {npc:260093}, the paladin trainer in the {zone:1458}, sends you to {npc:246378} at {area:16602}. Train your new spells with him while you are there. Already at {area:16602}? Skip this step: {npc:246378} gives you the mount quest without it."] = "A nivel 40, {npc:260093}, el instructor de paladines de {zone:1458}, te manda con {npc:246378} a {area:16602}. Aprende tus nuevos hechizos con él mientras estás ahí. ¿Ya estás en {area:16602}? Sáltate este paso: {npc:246378} te da la misión de la montura sin él.",
	-- {npc:260093} Garen Largo
	["{npc:260093}: your level 40 spells"] = "{npc:260093}: tus hechizos de nivel 40",

	-- Step 2: Danitha Morr
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {zone:1458} Undercity · {area:159} Brill · {npc:246378} Danitha Morr
	["{area:16602} stands on the bluffs in western Tirisfal, north-west of the {area:156}: leave the {zone:1458} and follow the road west past {area:159}. {npc:246378} is inside the keep, upstairs."] = "{area:16602} está sobre los riscos del oeste de Tirisfal, al noroeste de {area:156}: sal de {zone:1458} y sigue el camino hacia el oeste pasando {area:159}. {npc:246378} está dentro del bastión, en el piso de arriba.",
	-- {area:16602} Bandarion Keep
	["{area:16602}'s south gate"] = "Puerta sur de {area:16602}",

	-- Step 3: Summon Warhorse
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {quest:94971} A Paladin's Steed · {spell:1279399} Summon Warhorse
	["{npc:246378}, upstairs in {area:16602}, offers {quest:94971} at 40: accept it and hand it straight back. It teaches you {spell:1279399} and Apprentice Riding together, so you need no horse and no riding trainer."] = "{npc:246378}, en el piso de arriba de {area:16602}, ofrece {quest:94971} a nivel 40: acéptala y entrégala de inmediato. Te enseña {spell:1279399} y a montar al mismo tiempo, así que no necesitas caballo ni instructor de equitación.",
}
