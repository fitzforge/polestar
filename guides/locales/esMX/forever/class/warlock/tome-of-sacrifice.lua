-- Spanish (Latin America) (esMX): the guide forever/class/warlock/tome-of-sacrifice (forever/class/warlock/tome-of-sacrifice.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14463} Daio the Decrepit · {npc:12396} Doomguard Commander · {zone:1419} Blasted Lands
	["A rare off-hand at 60, {npc:14463}'s payment for capturing a {npc:12396} in the {zone:1419}."] = "Una pieza rara de mano izquierda a nivel 60, el pago de {npc:14463} por capturar a un {npc:12396} en {zone:1419}.",

	-- Step 1: Daio the Decrepit
	-- {npc:14463} Daio the Decrepit · {area:73} Tainted Scar · {zone:1419} Blasted Lands
	["At 60 {npc:14463} waits in the {area:73}, the demon-filled hollow in the west of the {zone:1419}. The Scar is full of hard-hitting elites: Soulstone yourself first, then keep to the right-hand wall going in, or ride through mounted. {npc:14463} gives you two errands at once."] = "A nivel 60, {npc:14463} espera en {area:73}, la hondonada llena de demonios en el oeste de {zone:1419}. La Cicatriz está llena de élites que pegan fuerte: ponte antes una piedra de alma y mantente pegado a la pared derecha al entrar, o pasa montado. {npc:14463} te da dos encargos a la vez.",

	-- Step 2: Satyr Blood
	-- {area:2577} Dire Maul · {area:2518} Lariss Pavilion · {item:18249} Crescent Key · {zone:1444} Feralas
	["The Wildspawn satyrs (level 55-57, elite) fill the Warpwood Quarter, {area:2577}'s eastern wing: bring a group of five. Four in five drop a blood, but they do not come back for two hours and one full clear may come up short of fifteen; reset and run it again. The back door at {area:2518} needs the {item:18249}, which drops inside this wing; until someone has it, go in by {area:2577}'s main gate in central {zone:1444}."] = "Los sátiros Engendro Salvaje (nivel 55-57, élite) llenan el Barrio Madeguerra, el ala este de {area:2577}: lleva un grupo de cinco. Cuatro de cada cinco sueltan una sangre, pero no vuelven en dos horas y una limpieza completa puede quedarse corta de quince; reinicia y vuelve a hacerla. La puerta trasera de {area:2518} necesita {item:18249}, que cae dentro de esta ala; hasta que alguien la tenga, entra por la puerta principal de {area:2577}, en el centro de {zone:1444}.",
	-- {item:18603} Satyr Blood
	["{item:18603}, from the Wildspawn inside"] = "{item:18603}, de los Engendro Salvaje de adentro",

	-- Step 3: Tears of the Hederine
	-- {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring · {spell:7645} Dominate Mind · {spell:710} Banish
	["The Hederine demons (level 57-60, elite) hold {area:2256} in the far south of {zone:1452}: grouping up is encouraged. Two Slayers guard the gorge past the bridge; the western tunnel leads to more Initiates, the easiest of them (watch for their {spell:7645}). A warlock can solo them one at a time with Fear or {spell:710} and damage over time, but slowly. Any of them can drop the Tears, four kills in five."] = "Los demonios Hederine (nivel 57-60, élite) ocupan {area:2256}, en el extremo sur de {zone:1452}: se recomienda agruparse. Dos destripadores custodian la garganta pasando el puente; el túnel del oeste lleva a más iniciados, los más fáciles (cuidado con su {spell:7645}). Un brujo puede hacerlos solo de a uno con Miedo o {spell:710} y daño en el tiempo, pero despacio. Cualquiera puede soltar las Lágrimas, cuatro de cada cinco veces.",

	-- Step 4: Suppression
	-- {npc:14463} Daio the Decrepit · {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander · {area:73} Tainted Scar · {spell:45} War Stomp · {item:18605} Imprisoned Doomguard
	["Hand both in to {npc:14463} and take the {item:18601}. Find a {npc:12396} (level 61, elite) standing alone in the {area:73}, open from about 30 yards with your voidwalker on him, and channel the prison on him for about 20 seconds: he attacks you to break free, and his {spell:45} can interrupt the channel, so sacrifice the voidwalker for its shield if you must. Grouping up is encouraged: a second player to tank makes it easy. When the channel finishes he becomes the {item:18605}: click it. If the channel breaks, kill him or run, and try another."] = "Entrégale ambas a {npc:14463} y toma {item:18601}. Busca un {npc:12396} (nivel 61, élite) solo en {area:73}, empieza desde unos 30 m con tu abisario sobre él y canaliza la prisión sobre él unos 20 segundos: te ataca para liberarse, y su {spell:45} puede interrumpir la canalización, así que sacrifica al abisario por su escudo si hace falta. Se recomienda agruparse: un segundo jugador como tanque lo hace fácil. Cuando termina la canalización, se convierte en {item:18605}: haz clic en él. Si la canalización se rompe, mátalo o huye, y prueba con otro.",
	-- {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander
	["{item:18601}, on a {npc:12396}"] = "{item:18601}, sobre un {npc:12396}",
	-- {item:18605} Imprisoned Doomguard
	["{item:18605}, click it"] = "{item:18605}, haz clic en él",

	-- Step 5: Back to Daio the Decrepit
	-- {npc:14463} Daio the Decrepit
	["Back to {npc:14463}"] = "Vuelve con {npc:14463}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 60 {npc:14463} waits in the {area:73}, in western {zone:1419}."] = "A nivel 60, {npc:14463} espera en la {area:73}, al oeste de {zone:1419}.",
	-- ["Hand both in to {npc:14463}, then find the {npc:12396} in the {area:73} and use the {item:18601} on him. He is elite and fights to escape: grouping up is advised."] = "Entrega ambas a {npc:14463}, luego busca al {npc:12396} en la {area:73} y usa la {item:18601} en él. Es élite y pelea para escapar: se recomienda ir en grupo.",
	-- ["The Hederine demons hold {area:2256}, in southern {zone:1452}. They are elite: grouping up is advised."] = "Los demonios Hederine ocupan la {area:2256}, al sur de {zone:1452}. Son élite: se recomienda ir en grupo.",
	-- ["The Wildspawn satyrs of the Warpwood Quarter, {area:2577}'s eastern wing, carry the blood. The back door at {area:2518}, north of {area:1099}, needs the {item:18249}; otherwise go in by {area:2577}'s main entrance. Bring a group."] = "Los sátiros Mala Hierba del Barrio Alabeo, el ala este de {area:2577}, llevan la sangre. La puerta trasera del {area:2518}, al norte del {area:1099}, requiere la {item:18249}; si no, entra por la entrada principal de {area:2577}. Lleva un grupo.",
	-- ["{item:18601}, on the {npc:12396}"] = "{item:18601}, en el {npc:12396}",
	-- ["{item:18603}, inside the Warpwood Quarter"] = "{item:18603}, dentro del Barrio Alabeo",
}
