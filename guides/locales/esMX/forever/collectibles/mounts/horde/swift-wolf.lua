-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/horde/swift-wolf (forever/collectibles/mounts/horde/swift-wolf.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Wolf"] = "Lobo veloz",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} de oficial",
	-- {npc:4752} Kildar · {npc:3362} Ogunaro Wolfrunner · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {skill:762} Riding
	["{npc:4752} and {npc:3362}'s kennel are in {zone:1454}'s {object:172958}. At 60 {npc:4752} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift wolf for 200g at level 60."] = "{npc:4752} y la perrera de {npc:3362} están en {object:172958} de {zone:1454}. A nivel 60, {npc:4752} enseña {skill:762} de oficial (1,000g según los diseñadores de Blizzard); Blizzard dice que aprender equitación otorga una montura. El cliente de Forever vende cada lobo veloz por 200g a nivel 60.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instructor de equitación",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Elige un color",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3362} vende los demás colores (200g cada uno en el cliente de Forever). Compra los que quieras, o ninguno si te gusta la montura que te dieron.",
	-- {item:18796} Horn of the Swift Brown Wolf
	["{item:18796}, 200g"] = "{item:18796}, 200g",
	-- {item:18797} Horn of the Swift Timber Wolf
	["{item:18797}, 200g"] = "{item:18797}, 200g",
	-- {item:18798} Horn of the Swift Gray Wolf
	["{item:18798}, 200g"] = "{item:18798}, 200g",
}
