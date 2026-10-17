-- Spanish (Latin America) (esMX): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "Reputación: Bastión Fauces de Madera",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold
	["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576} empieza en Hostil, y sus fúrbolgs de los túneles atacan hasta que llegues a Adverso. Cada fúrbolg Muertobosque y Nevada que mates la sube, así que las misiones de abajo rinden el doble. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:11554} Grazle · {npc:15395} Nafien
	["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "Los fúrbolgs Muertobosque (nivel 48-50) acampan en el extremo sur de {zone:1448}. Guarda cada {item:21377} que suelten: {npc:11554} y {npc:15395} los aceptan después.",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "Vuelve con {npc:11554}",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood · {faction:576} Timbermaw Hold
	["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395} espera en el norte de {zone:1448}, en el túnel hacia {faction:576}.",

	-- Step 5: Deadwood of the North
	["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "Los Muertobosque del norte (nivel 53-55) ocupan los campamentos justo al sur del túnel. Guarda también sus plumas.",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "Vuelve con {npc:15395}",

	-- Step 7: Salfa
	-- {faction:576} Timbermaw Hold · {zone:1452} Winterspring · {npc:11556} Salfa
	["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "Atraviesa {faction:576} hasta su salida a {zone:1452}; {npc:11556} está justo afuera. Las misiones y muertes hasta ahora suelen llegar a Adverso, y entonces los Fauces de Madera te dejan pasar. Si siguen en rojo, mata primero más Muertobosque junto al túnel.",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {item:21383} Winterfall Spirit Beads · {npc:11556} Salfa
	["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "{area:2244} está en el lado este de {zone:1452}. Guarda cada {item:21383} que obtengas: {npc:11556} los acepta.",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "Vuelve con {npc:11556}",

	-- Step 10: Feathers and beads to Friendly
	["Feathers and beads to Friendly"] = "Plumas y cuentas hasta Amistoso",
	-- {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {item:21383} Winterfall Spirit Beads · {area:2244} Winterfall Village
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "Plumas para {npc:11554}, Plumas para {npc:15395} (Plumas de penacho de Muertobosque) y Cuentas para {npc:11556} ({item:21383}) se repiten cuantas veces quieras; cada muerte de Muertobosque o Nevada también cuenta. {area:2244} es el mejor lugar para cuentas.",
	-- {npc:11556} Salfa
	["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}: Cuentas para {npc:11556}",

	-- Step 11: Feathers to Honored
	["Feathers to Honored"] = "Plumas hasta Honorable",
	-- {npc:15395} Nafien · {npc:11554} Grazle
	["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "Los campamentos Muertobosque del norte junto al túnel son el mejor lugar para plumas (35% de probabilidad allí). Entrega las plumas a {npc:15395} en el túnel, o a {npc:11554} en el sur.",
	-- {npc:15395} Nafien
	["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}: Plumas para {npc:15395}",

	-- Step 12: Timbermaw Hold to Revered
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Revered"] = "{faction:576} hasta Venerado",
	-- {npc:15395} Nafien · {npc:11556} Salfa
	["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "Alterna entre plumas Muertobosque ({npc:15395}) y cuentas Nevada ({npc:11556}), según qué campamento esté menos concurrido.",

	-- Step 13: Timbermaw Hold to Exalted
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Exalted"] = "{faction:576} hasta Exaltado",
	["Keep turning in feathers and beads until Exalted."] = "Sigue entregando plumas y cuentas hasta Exaltado.",
}
