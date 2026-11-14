-- Spanish (Latin America) (esMX): the guide forever/class/mage/teleports-alliance (forever/class/mage/teleports-alliance.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Teleports and Portals (Alliance)"] = "Teletransportes y portales (Alianza)",
	["Your city teleports at 20 and 30 and the group portals at 40 and 50, from each city's portal trainer."] = "Los teletransportes a tus ciudades a nivel 20 y 30, y los portales de grupo a nivel 40 y 50, del instructor de portales de cada ciudad.",

	-- Step 1: Teleport: Stormwind
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:2485} Larimaine Purdue · {spell:3561} Teleport: Stormwind · {item:17031} Rune of Teleportation · {npc:1308} Owen Vaughn
	["At 20 go to the Wizard's Sanctum, the violet tower of {zone:1453}'s {object:2101}. {npc:2485}, the portal trainer, stands at the very top: climb the spiral ramp and take the portal near the top. She teaches {spell:3561} for 20 silver. Every teleport burns one {item:17031} (10 silver at any reagent vendor; {npc:1308} sells them at the foot of the tower), so carry a few."] = "A nivel 20 ve al Santuario del Mago, la torre violeta de {object:2101} de {zone:1453}. {npc:2485}, la instructora de portales, está en lo más alto: sube por la rampa en espiral y toma el portal cerca de la cima. Enseña {spell:3561} por 20 de plata. Cada teletransporte gasta una {item:17031} (10 de plata en cualquier vendedor de componentes; {npc:1308} las vende al pie de la torre), así que lleva algunas.",
	-- {item:17031} Rune of Teleportation
	["{item:17031}, 10s each"] = "{item:17031}, 10 p cada una",

	-- Step 2: Teleport: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:2489} Milstaff Stormeye · {object:32362} Mystic Ward (no name in this language: may be words) · {spell:3562} Teleport: Ironforge
	["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455}. {npc:2489}, the portal trainer, stands with the mage trainers in the {object:32362} at the back of the city: {spell:3562}, 20 silver."] = "Toma {area:2257} desde {object:28027} de {zone:1453} hasta {zone:1455}. {npc:2489}, el instructor de portales, está con los instructores de magos en {object:32362}, al fondo de la ciudad: {spell:3562}, 20 de plata.",

	-- Step 3: Teleport: Darnassus
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1439} Darkshore · {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:4165} Elissa Dumas · {spell:3565} Teleport: Darnassus
	["At 30. Take the boat from {area:17203} to {area:442} in {zone:1439}, then the boat to {area:702} and the pink portal up into {zone:1457}. {npc:4165}, the portal trainer, teaches {spell:3565} for 80 silver."] = "A nivel 30. Toma el barco de {area:17203} a {area:442} en {zone:1439}, luego el barco a {area:702} y el portal rosa para subir a {zone:1457}. {npc:4165}, la instructora de portales, enseña {spell:3565} por 80 de plata.",

	-- Step 4: Portals to Stormwind and Ironforge
	-- {zone:1453} Stormwind · {zone:1455} Ironforge
	["Portals to {zone:1453} and {zone:1455}"] = "Portales a {zone:1453} y {zone:1455}",
	-- {item:17032} Rune of Portals · {npc:2485} Larimaine Purdue · {spell:10059} Portal: Stormwind · {npc:2489} Milstaff Stormeye · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {spell:11416} Portal: Ironforge
	["At 40 the portal trainers teach the portals: a gateway your whole group can step through, for 1 gold 50 silver each. Each portal burns one {item:17032} (20 silver at any reagent vendor). {npc:2485} has {spell:10059} at the top of the Wizard's Sanctum; then the tram to {npc:2489} in {zone:1455}'s {object:32362} for {spell:11416}."] = "A nivel 40, los instructores de portales enseñan los portales: una entrada que todo tu grupo puede cruzar, por 1 de oro 50 de plata cada uno. Cada portal gasta una {item:17032} (20 de plata en cualquier vendedor de componentes). {npc:2485} tiene {spell:10059} en lo alto del Santuario del Mago; luego el tranvía hasta {npc:2489}, en {object:32362} de {zone:1455}, para {spell:11416}.",
	-- {item:17032} Rune of Portals
	["{item:17032}, 20s each"] = "{item:17032}, 20 p cada una",

	-- Step 5: Portal: Darnassus
	-- {npc:4165} Elissa Dumas · {zone:1457} Darnassus · {spell:11419} Portal: Darnassus · {spell:3565} Teleport: Darnassus
	["At 50 {npc:4165} in {zone:1457} teaches the last one, {spell:11419}, for 3 gold 20 silver. Use your {spell:3565} to get there."] = "A nivel 50, {npc:4165} en {zone:1457} enseña el último, {spell:11419}, por 3 de oro 20 de plata. Usa tu {spell:3565} para llegar.",
}
