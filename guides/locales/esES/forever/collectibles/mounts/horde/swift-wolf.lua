-- Spanish (Spain) (esES): the guide forever/collectibles/mounts/horde/swift-wolf (forever/collectibles/mounts/horde/swift-wolf.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Wolf"] = "Lobo veloz",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} de oficial",
	-- {npc:4752} Kildar · {npc:3362} Ogunaro Wolfrunner · {faction:76} Orgrimmar · {object:172958} Valley of Honor · {skill:762} Riding
	["{npc:4752} and {npc:3362}'s kennel are in {faction:76}'s {object:172958}. At 60 {npc:4752} teaches Journeyman {skill:762} to Orcs for 1,000g (10% less at Honored with {faction:76}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift wolf costs 200g here."] = "El criadero de {npc:4752} y {npc:3362} está en el {object:172958} de {faction:76}. A nivel 60 {npc:4752} enseña {skill:762} de oficial a los orcos por 1000 de oro (un 10% menos con {faction:76} en Honor); Blizzard dice que viene con una montura. Las demás razas lo entrenan con el instructor de equitación de su raza. Cada lobo veloz cuesta 200 de oro aquí.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instructor de equitación",

	-- Step 2: Wolf Riding for other races
	-- {spell:825} Wolf Riding
	["{spell:825} for other races"] = "{spell:825} para otras razas",
	-- {spell:825} Wolf Riding · {skill:762} Riding · {npc:4752} Kildar · {faction:76} Orgrimmar
	["Any Horde race can buy these wolves, but riding one also takes {spell:825}, which only Orcs get with {skill:762}. {npc:4752} teaches it to other races once they are Exalted with {faction:76} (the Orgrimmar Reputation guide shows the way). Until then, don't buy a wolf for this character."] = "Cualquier raza de la Horda puede comprar estos lobos, pero montar uno también requiere {spell:825}, que solo los orcos obtienen con {skill:762}. {npc:4752} lo enseña a las demás razas cuando son Exaltadas con {faction:76} (la guía de reputación de Orgrimmar marca el camino). Hasta entonces, no compres un lobo para este personaje.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Elige un color",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3362} vende los demás colores (200 o cada uno en el cliente de Forever). Compra los que quieras, o ninguno si te gusta la montura que te dieron.",
	-- {item:18796} Horn of the Swift Brown Wolf
	["{item:18796}, 200g"] = "{item:18796}, 200 o",
	-- {item:18797} Horn of the Swift Timber Wolf
	["{item:18797}, 200g"] = "{item:18797}, 200 o",
	-- {item:18798} Horn of the Swift Gray Wolf
	["{item:18798}, 200g"] = "{item:18798}, 200 o",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4752} and {npc:3362}'s kennel are in {zone:1454}'s {object:172958}. At 60 {npc:4752} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift wolf for 200g at level 60."] = "{npc:4752} y la perrera de {npc:3362} están en {object:172958} de {zone:1454}. A nivel 60, {npc:4752} enseña {skill:762} de oficial (1000 o según los diseñadores de Blizzard); Blizzard dice que aprender equitación da una montura. El cliente de Forever vende cada lobo veloz por 200 o a nivel 60.",
}
