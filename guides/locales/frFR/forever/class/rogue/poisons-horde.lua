-- French (frFR): the guide forever/class/rogue/poisons-horde (forever/class/rogue/poisons-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2842} Poisons
	["{spell:2842} (Horde)"] = "{spell:2842} (Horde)",
	-- {spell:2842} Poisons · {item:7676} Thistle Tea
	["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever enseigne {spell:2842} par cette chaîne, et non par le maître ; la recette de {item:7676} l'accompagne.",

	-- Step 1: The Shattered Salute
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["At 20 {npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Target him and type /salute."] = "Au niveau 20, {npc:3401} se tient dans {object:172960}, le canyon sous la {object:172982}. Ciblez-le et tapez /saluer.",
	-- {npc:3401} Shenthul
	["/salute {npc:3401}"] = "/saluer {npc:3401}",
	-- {quest:2458} Deep Cover · {item:8051} Flare Gun
	["{quest:2458}: keep the {item:8051}"] = "{quest:2458} : gardez {item:8051}",

	-- Step 2: Taskmaster Fizzule
	-- {area:380} Crossroads · {area:382} Sludge Fen · {item:8051} Flare Gun · {npc:7233} Taskmaster Fizzule
	["Fly to the {area:380} and ride north to the Venture Co. tower north of the {area:382}. In sight of the tower, fire the {item:8051} twice, then /salute {npc:7233} before he attacks you."] = "Volez jusqu'à {area:380} et allez vers le nord jusqu'à la tour de la KapitalRisk, au nord de {area:382}. En vue de la tour, tirez deux fois avec {item:8051}, puis faites /saluer à {npc:7233} avant qu'il ne vous attaque.",
	-- {item:8051} Flare Gun
	["{item:8051}, twice, in sight of the tower"] = "{item:8051}, deux fois, en vue de la tour",

	-- Step 3: Mission: Possible But Not Probable
	-- {npc:7287} Foreman Silixiz
	["Stay stealthed. {npc:7287} carries the tower key; Gallywix (elite) and his lockbox are at the top of the tower. Kill two each of the drones, patrollers and lookouts around it."] = "Restez camouflé. {npc:7287} porte la clé de la tour ; Gallywix (élite) et son coffret sont au sommet de la tour. Tuez deux Pantins, deux Patrouilleurs et deux Sentinelles de la KapitalRisk autour.",
	-- {item:8074} Gallywix's Head · {npc:7288} Grand Foreman Puzik Gallywix
	["{item:8074}: {npc:7288} (elite)"] = "{item:8074} : {npc:7288} (élite)",

	-- Step 4: Back to Shenthul
	-- {npc:3401} Shenthul
	["Back to {npc:3401}"] = "Retour auprès de {npc:3401}",
	-- {zone:1454} Orgrimmar
	["Fly back to {zone:1454}."] = "Retournez en vol à {zone:1454}.",

	-- Step 5: Serge Hinott
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:272} Tarren Mill · {area:287} Hillsbrad · {npc:2391} Serge Hinott
	["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south through {zone:1421} to {area:272} in {area:287}. {npc:2391} stands in {area:272}; wait beside him while he brews the cure."] = "Prenez le zeppelin d'{zone:1454} à {zone:1458} et descendez vers le sud à travers {zone:1421} jusqu'à {area:272}, à {area:287}. {npc:2391} se tient à {area:272} ; attendez à côté de lui pendant qu'il prépare le remède.",
	["Wait for the cure"] = "Attendez le remède",
}
