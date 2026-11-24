-- Spanish (Latin America) (esMX): the guide forever/class/warlock/imp-horde (forever/class/warlock/imp-horde.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Imp (Horde)"] = "Diablillo (Horda)",
	["Your first demon at level 1-4: the imp, with a starter blade or staff for Orcs and Trolls."] = "Tu primer demonio, a nivel 1-4: el diablillo, con una hoja o bastón inicial para orcos y trols.",

	-- Step 1: Ruzan (Orcs and Trolls)
	-- {npc:5765} Ruzan
	["{npc:5765} (Orcs and Trolls)"] = "{npc:5765} (orcos y trols)",
	-- {item:9579} Tainted Parchment · {item:282346} Tainted Tablet · {npc:5765} Ruzan · {area:363} Valley of Trials
	-- plural, as words: Vile Familiar Heads = {item:6487} Vile Familiar Head
	["Your first letter ({item:9579} for Orcs, {item:282346} for Trolls, from Gornek after Cutting Teeth) points you to Nartok, the warlock trainer in the Den. {npc:5765} stands just outside the Den in the {area:363} and asks for six Vile Familiar Heads."] = "Tu primera carta ({item:9579} para orcos, {item:282346} para trols, de Gornek después de Probar los dientes) te lleva con Nartok, el instructor de brujos en la Guarida. {npc:5765} está justo afuera de la Guarida en {area:363} y te pide seis Cabezas de familiar vil.",

	-- Step 2: Vile Familiars
	-- {quest:1485} Vile Familiars · {area:365} Burning Blade Coven
	["The {quest:1485} (level 3-4) swarm the {area:365}, the cave north of the Den, inside and around its mouth. Almost every kill drops a head (80%), so about eight kills does it; they throw small fireballs, so pull them one at a time. They respawn in just over three minutes. Other classes hunt the same imps for their own {quest:1485} quest."] = "{quest:1485} (nivel 3-4) pululan en {area:365}, la cueva al norte de la Guarida, adentro y alrededor de la entrada. Casi todas las muertes sueltan una cabeza (80 %), así que con unas ocho alcanza; lanzan bolitas de fuego, así que atráelos de a uno. Reaparecen en poco más de tres minutos. Otras clases cazan los mismos diablillos para su propia misión {quest:1485}.",
	-- plural, as words: Vile Familiar Heads = {item:6487} Vile Familiar Head
	["Vile Familiar Heads"] = "Cabezas de familiar vil",

	-- Step 3: Summon Imp
	-- {npc:5765} Ruzan · {spell:688} Summon Imp · {npc:3145} Zureetha Fargaze
	["{npc:5765} teaches you {spell:688} when you hand in the heads: summon it right away, it costs nothing and fights beside you. Then speak with {npc:3145} a few steps away for a starter weapon."] = "{npc:5765} te enseña {spell:688} cuando entregas las cabezas: invócalo enseguida, no cuesta nada y pelea a tu lado. Luego habla con {npc:3145}, a pocos pasos, para un arma inicial.",

	-- Step 4: Venya Marthand (Undead)
	-- {npc:5667} Venya Marthand
	["{npc:5667} (Undead)"] = "{npc:5667} (no-muertos)",
	-- {item:9578} Tainted Scroll · {npc:1569} Shadow Priest Sarvis · {area:154} Deathknell · {npc:5667} Venya Marthand
	-- plural, as words: Rattlecage Skulls = {item:6281} Rattlecage Skull
	["Your first letter ({item:9578}, from {npc:1569} after The Mindless Ones) points you to Maximillion, the warlock trainer in {area:154}. {npc:5667} waits inside the building beside him and asks for three Rattlecage Skulls."] = "Tu primera carta ({item:9578}, de {npc:1569} después de Los descerebrados) te lleva con Maximillion, el instructor de brujos en {area:154}. {npc:5667} espera dentro del edificio a su lado y te pide tres Cráneos Jaularraída.",

	-- Step 5: Rattlecage Skulls
	-- plural, as words: Rattlecage Skulls = {item:6281} Rattlecage Skull
	["Rattlecage Skulls"] = "Cráneos Jaularraída",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons (level 2-3) stand around the old smithy buildings just north of {area:154}, often right against the walls. Four kills in five drop a skull, so plan on about five; twenty of them spawn there and each comes back after five minutes."] = "Los esqueletos Jaularraída (nivel 2-3) están alrededor de los viejos edificios de la herrería, justo al norte de {area:154}, muchas veces pegados a las paredes. Cuatro de cada cinco sueltan un cráneo, así que cuenta con unos cinco; aparecen veinte ahí y cada uno vuelve a los cinco minutos.",

	-- Step 6: Summon Imp
	-- {npc:5667} Venya Marthand · {spell:688} Summon Imp
	["{npc:5667} teaches you {spell:688} when you hand in the skulls: summon it right away, it costs nothing and fights beside you."] = "{npc:5667} te enseña {spell:688} cuando entregas los cráneos: invócalo enseguida, no cuesta nada y pelea a tu lado.",
}
