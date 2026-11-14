-- Spanish (Latin America) (esMX): the guide forever/class/mage/astral-knot-garment (forever/class/mage/astral-knot-garment.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a blouse for Alliance mages in their late 20s."] = "Una túnica o una blusa para los magos de la Alianza al final de sus veintes.",

	-- Step 1: Bink (Ironforge)
	-- {npc:5144} Bink · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:5144} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:5144} instruye a los magos en {object:32362}, en {zone:1455}. Después, toma el {area:2257} desde {object:171524} hasta {zone:1453}.",

	-- Step 2: Jennea Cannon (Stormwind)
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter
	["{npc:5497} stands at the top of the Wizard's Sanctum, the violet tower of the {object:2101}; the portal near the top of the spiral ramp takes you to her."] = "{npc:5497} está en lo alto del Santuario del Mago, la torre violeta de {object:2101}; el portal cerca de la cima de la rampa en espiral te lleva hasta ella.",

	-- Step 3: High Sorcerer Andromath (Skyborne)
	-- {quest:1939} High Sorcerer Andromath
	["{quest:1939} (Skyborne)"] = "{quest:1939} (Skyborne)",
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {quest:1939} High Sorcerer Andromath · {npc:5497} Jennea Cannon
	["You do not need a letter: at 26 climb the Wizard's Sanctum, the violet tower of {zone:1453}'s {object:2101}. {quest:1939} waits on the spiral walkway, just past the door of the portal room near the top, and has the quest for you. ({npc:5497} may also offer you {quest:1939}, the pointer quest; it is only a pointer and you can skip it.)"] = "No necesitas carta: a nivel 26 sube al Santuario del Mago, la torre violeta de {object:2101} de {zone:1453}. {quest:1939} espera en la pasarela en espiral, justo pasando la puerta de la sala del portal cerca de la cima, y tiene la misión para ti. ({npc:5497} también puede ofrecerte {quest:1939}, la misión indicadora; es solo una indicación y puedes omitirla.)",

	-- Step 4: High Sorcerer Andromath
	-- {quest:1939} High Sorcerer Andromath
	["{quest:1939} waits on the spiral walkway of the Wizard's Sanctum, just past the door of the portal room as you walk down from the trainers."] = "{quest:1939} espera en la pasarela en espiral del Santuario del Mago, justo pasando la puerta de la sala del portal al bajar desde los instructores.",

	-- Step 5: The Tower of Ilgalar
	-- {area:96} Tower of Ilgalar
	["The {area:96}"] = "{area:96}",
	-- {zone:1429} Elwynn Forest · {area:69} Lakeshire · {area:96} Tower of Ilgalar · {spell:2691} Mana Burn
	["Head east through {zone:1429} into Redridge, or fly to {area:69}. The {area:96} stands alone in the east of the zone. Climb to the very top floor (not the one below): the treatise is the book sticking out of the shelf where the stairs come up. Two gnoll dogs and a gnoll caster guard the shelf; the dogs' {spell:2691} interrupts the click, so fight them on the stairs out of their sight. Morganth (level 26 elite) stands across the top floor: you do not need him, keep to the left edge of the ramp so he stays put. The book is back two seconds after anyone takes it. If you die, your ghost can run up and come back to life beside it."] = "Ve al este por {zone:1429} hasta Montañas Crestagrana, o vuela a {area:69}. {area:96} está sola en el este de la zona. Sube hasta el último piso (no el de abajo): el tratado es el libro que sobresale del estante donde llega la escalera. Dos perros gnoll y un lanzador de hechizos gnoll custodian el estante; el {spell:2691} de los perros interrumpe el clic, así que pelea con ellos en la escalera, fuera de su vista. Morganth (élite de nivel 26) está al otro lado del último piso: no lo necesitas, mantente en el borde izquierdo de la rampa para que no se mueva. El libro vuelve dos segundos después de que alguien lo toma. Si mueres, tu fantasma puede subir y revivir a su lado.",

	-- Step 6: Back to Andromath
	["Back to Andromath"] = "De vuelta con Andromath",

	-- Step 7: Carrion Recluses
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse
	["Carrion Recluses"] = "Ermitaños carroñeros",
	-- {area:492} Raven Hill Cemetery · {zone:1431} Duskwood · {spell:3609} Paralyzing Poison · {npc:522} Mor'Ladim
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Black Widow Hatchlings = {npc:930} Black Widow Hatchling
	["{area:492} in western {zone:1431}: the six Carrion Recluses (level 25-26, green, {spell:3609}) walk the graves, the central statue and the riverbank, and every one drops a silk; they come back after 5 minutes. The Black Widow Hatchlings (24-25) on the slopes east of the cemetery drop it about one time in six, so mix them in while you wait. {npc:522}, a level 35 elite skeleton, walks the cemetery: watch for him."] = "{area:492}, en el oeste de {zone:1431}: las seis reclusas carroñeras (nivel 25-26, verdes, {spell:3609}) recorren las tumbas, la estatua central y la orilla del río, y todas sueltan una seda; vuelven a los 5 minutos. Las crías de viuda negra (24-25) de las laderas al este del cementerio la sueltan más o menos una vez de cada seis, así que mézclalas mientras esperas. {npc:522}, un esqueleto élite de nivel 35, recorre el cementerio: cuidado con él.",

	-- Step 8: Wynne Larson
	-- {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["{npc:1309} works at {object:23296} in the {object:2101}. The robe gives intellect, stamina and spirit; the blouse more intellect and stamina but no spirit."] = "{npc:1309} trabaja en {object:23296}, en {object:2101}. La túnica da intelecto, aguante y espíritu; la blusa, más intelecto y aguante pero sin espíritu.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A robe or a blouse for Human and Gnome mages in their late 20s."] = "Una túnica o una blusa para magos humanos y gnomos a finales de sus 20.",
	-- ["Carrion Recluses lurk in the woods of western {zone:1431} and each one drops the silk. The Black Widow Hatchlings further east drop it now and then."] = "Los Ermitaños carroñeros acechan en los bosques del oeste de {zone:1431} y todos sueltan la seda. Las Proles de viuda negra, más al este, la sueltan de vez en cuando.",
	-- ["Ride east through {zone:1429} into Redridge. The fallen mage's tower of Ilgalar stands in the east of the zone; the treatise is in his library."] = "Cabalga hacia el este por {zone:1429} hasta Montañas Crestagrana. La torre de Ilgalar, el mago caído, está en el este de la zona; el tratado está en su biblioteca.",
	-- ["{npc:1309} works at {object:23296} in the {object:2101}."] = "{npc:1309} trabaja en {object:23296}, en {object:2101}.",
	-- ["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}."] = "{npc:5497} está en el Wizard's Sanctum, la torre de {object:2101}.",
	-- ["{quest:1939} is in the Wizard's Sanctum too."] = "{quest:1939} también está en el Wizard's Sanctum.",
}
