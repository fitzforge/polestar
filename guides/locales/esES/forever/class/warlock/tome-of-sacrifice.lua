-- Spanish (Spain) (esES): the guide forever/class/warlock/tome-of-sacrifice (forever/class/warlock/tome-of-sacrifice.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14463} Daio the Decrepit · {npc:12396} Doomguard Commander · {zone:1419} Blasted Lands
	["A rare off-hand at 60, {npc:14463}'s payment for capturing a {npc:12396} in the {zone:1419}."] = "Un objeto de mano izquierda raro a nivel 60, el pago de {npc:14463} por capturar a un {npc:12396} en {zone:1419}.",

	-- Step 1: Daio the Decrepit
	-- {npc:14463} Daio the Decrepit · {area:73} Tainted Scar · {zone:1419} Blasted Lands
	["At 60 {npc:14463} waits in the {area:73}, in western {zone:1419}."] = "A nivel 60 {npc:14463} espera en {area:73}, al oeste de {zone:1419}.",

	-- Step 2: Satyr Blood
	-- {area:2577} Dire Maul · {area:2518} Lariss Pavilion · {area:1099} Camp Mojache · {item:18249} Crescent Key
	["The Wildspawn satyrs of the Warpwood Quarter, {area:2577}'s eastern wing, carry the blood. The back door at {area:2518}, north of {area:1099}, needs the {item:18249}; otherwise go in by {area:2577}'s main entrance. Bring a group."] = "Los sátiros Mala Hierba del ala este de {area:2577} llevan la sangre. La puerta trasera en {area:2518}, al norte de {area:1099}, requiere la {item:18249}; si no, entra por la entrada principal de {area:2577}. Lleva un grupo.",
	-- {item:18603} Satyr Blood
	["{item:18603}, inside the Warpwood Quarter"] = "{item:18603}, dentro del ala este",

	-- Step 3: Tears of the Hederine
	-- {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring
	["The Hederine demons hold {area:2256}, in southern {zone:1452}. They are elite: grouping up is advised."] = "Los demonios Hederine ocupan {area:2256}, al sur de {zone:1452}. Son élite: se recomienda ir en grupo.",

	-- Step 4: Suppression
	-- {npc:14463} Daio the Decrepit · {npc:12396} Doomguard Commander · {area:73} Tainted Scar · {item:18601} Glowing Crystal Prison
	["Hand both in to {npc:14463}, then find the {npc:12396} in the {area:73} and use the {item:18601} on him. He is elite and fights to escape: grouping up is advised."] = "Entrégale ambas cosas a {npc:14463}, luego busca al {npc:12396} en {area:73} y usa la {item:18601} en él. Es élite y lucha por escapar: se recomienda ir en grupo.",
	-- {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander
	["{item:18601}, on the {npc:12396}"] = "{item:18601}, en el {npc:12396}",

	-- Step 5: Back to Daio the Decrepit
	-- {npc:14463} Daio the Decrepit
	["Back to {npc:14463}"] = "Vuelve con {npc:14463}",
}
