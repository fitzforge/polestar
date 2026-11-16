-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/alliance/horse (forever/collectibles/mounts/alliance/horse.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Horse"] = "Caballo",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprende a montar",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding · {faction:72} Stormwind
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} to Humans for 100g (10% less at Honored with {faction:72}), and it comes with a horse. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "El corral de caballos de {npc:4732} y {npc:384} está en {area:88}, en el este de {zone:1429}. A nivel 40 {npc:4732} enseña {skill:762} a los humanos por 100 de oro (10% menos en Honorable con {faction:72}), y viene con un caballo. Las demás razas aprenden {skill:762}, con su propia primera montura, con el instructor de equitación de su raza.",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}, instructor de equitación",

	-- Step 2: Horse Riding for other races
	-- {spell:824} Horse Riding
	["{spell:824} for other races"] = "{spell:824} para otras razas",
	-- {spell:824} Horse Riding · {skill:762} Riding · {npc:4732} Randal Hunter · {faction:72} Stormwind
	["Any Alliance race can buy these horses, but riding one also takes {spell:824}, which only Humans get with {skill:762}. {npc:4732} teaches it to other races once they are Exalted with {faction:72} (the Stormwind Reputation guide shows the way). Until then, don't buy a horse for this character."] = "Cualquier raza de la Alianza puede comprar estos caballos, pero para montar uno también hace falta {spell:824}, que solo los humanos reciben con {skill:762}. {npc:4732} se la enseña a las demás razas una vez que están en Exaltado con {faction:72} (la guía de reputación de Ventormenta muestra el camino). Hasta entonces, no le compres un caballo a este personaje.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Elige un color",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384} vende los otros colores (20 o cada uno en el cliente de Forever). Compra los que quieras, o ninguno si te gusta la montura que te dieron.",
	-- {item:2414} Pinto Bridle
	["{item:2414}, 20g"] = "{item:2414}, 20 o",
	-- {item:5655} Chestnut Mare Bridle
	["{item:5655}, 20g"] = "{item:5655}, 20 o",
	-- {item:5656} Brown Horse Bridle
	["{item:5656}, 20g"] = "{item:5656}, 20 o",

	-- Step 4: Black Stallion in Menethil Harbor
	-- {npc:5404} Black Stallion · {area:150} Menethil Harbor
	["{npc:5404} in {area:150}"] = "{npc:5404} en {area:150}",
	-- {npc:5404} Black Stallion · {npc:384} Katie Hunter · {npc:1460} Unger Statforth · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["The {npc:5404} is not at {npc:384}: {npc:1460} sells it, at the stables of {area:150} in the {zone:1437} (20g in the Forever client). Skip this unless you want that colour."] = "El {npc:5404} no lo tiene {npc:384}: lo vende {npc:1460}, en los establos de {area:150} en {zone:1437} (20 de oro en el cliente de Forever). Sáltate esto salvo que quieras ese color.",
	-- {item:2411} Black Stallion Bridle · {npc:1460} Unger Statforth
	["{item:2411}, 20g, {npc:1460}"] = "{item:2411}, 20 de oro, {npc:1460}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:2411} is in the client, but no vendor is confirmed to sell it in Forever."] = "{item:2411} está en el cliente, pero no se ha confirmado ningún mercader que lo venda en Forever.",
	-- ["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4732} y el corral de caballos de {npc:384} están en {area:88}, en el este de {zone:1429}. A nivel 40, {npc:4732} enseña {skill:762} (100 o según los diseñadores de Blizzard), y aprenderla te da una montura. El cliente de Forever permite a todas las razas de la Alianza montarlos.",
}
