-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/horde/paladin-warhorse (forever/collectibles/mounts/horde/paladin-warhorse.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse (Forsaken)"] = "Cavalo de Guerra de Paladino (Renegados)",
	["Your first mount at 40, summoned at will: a Forsaken paladin buys no horse and pays no riding trainer."] = "Sua primeira montaria no nível 40, evocada à vontade: paladinos renegados não compram cavalo nem pagam instrutor de montaria.",

	-- Step 1: Report to Danitha
	-- {npc:260093} Garen Largo · {zone:1458} Undercity · {npc:246378} Danitha Morr · {area:16602} Bandarion Keep
	["At 40 {npc:260093}, the paladin trainer in the {zone:1458}, sends you to {npc:246378} at {area:16602}. Train your new spells with him while you are there. Already at {area:16602}? Skip this step: {npc:246378} gives you the mount quest without it."] = "No nível 40, {npc:260093}, o instrutor de paladinos em {zone:1458}, manda você até {npc:246378} em {area:16602}. Aprenda seus novos feitiços com ele enquanto estiver lá. Já está em {area:16602}? Pule esta etapa: {npc:246378} dá a missão da montaria sem ela.",
	-- {npc:260093} Garen Largo
	["{npc:260093}: your level 40 spells"] = "{npc:260093}: seus feitiços do nível 40",

	-- Step 2: Danitha Morr
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {zone:1458} Undercity · {area:159} Brill · {npc:246378} Danitha Morr
	["{area:16602} stands on the bluffs in western Tirisfal, north-west of the {area:156}: leave the {zone:1458} and follow the road west past {area:159}. {npc:246378} is inside the keep, upstairs."] = "{area:16602} fica nos penhascos do oeste de Tirisfal, a noroeste de {area:156}: saia de {zone:1458} e siga a estrada para oeste passando por {area:159}. {npc:246378} está dentro da fortaleza, no andar de cima.",
	-- {area:16602} Bandarion Keep
	["{area:16602}'s south gate"] = "Portão sul de {area:16602}",

	-- Step 3: Summon Warhorse
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {quest:94971} A Paladin's Steed · {spell:1279399} Summon Warhorse
	["{npc:246378}, upstairs in {area:16602}, offers {quest:94971} at 40: accept it and hand it straight back. It teaches you {spell:1279399} and Apprentice Riding together, so you need no horse and no riding trainer."] = "{npc:246378}, no andar de cima de {area:16602}, oferece {quest:94971} no nível 40: aceite e entregue logo em seguida. Ela ensina {spell:1279399} e a cavalgar ao mesmo tempo, então você não precisa de cavalo nem de instrutor de montaria.",
}
