-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/horde/wolf (forever/collectibles/mounts/horde/wolf.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Wolf"] = "Lobo",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprende a montar",
	-- {npc:4752} Kildar · {npc:3362} Ogunaro Wolfrunner · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {skill:762} Riding
	["{npc:4752} and {npc:3362}'s kennel are in {zone:1454}'s {object:172958}. At 40 {npc:4752} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:4752} y la perrera de {npc:3362} están en {object:172958}, en {zone:1454}. A nivel 40, {npc:4752} enseña {skill:762} (100 o según los diseñadores de Blizzard), y aprenderla te da una montura. El cliente de Forever permite a todas las razas de la Horda montarlos.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instructor de equitación",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Elige un color",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3362} vende los otros colores (20 o cada uno en el cliente de Forever). Compra los que quieras, o ninguno si te gusta la montura que te dieron.",
	-- {item:1132} Horn of the Timber Wolf
	["{item:1132}, 20g"] = "{item:1132}, 20 o",
	-- {item:5665} Horn of the Dire Wolf
	["{item:5665}, 20g"] = "{item:5665}, 20 o",
	-- {item:5668} Horn of the Brown Wolf
	["{item:5668}, 20g"] = "{item:5668}, 20 o",
	-- {item:1041} Horn of the Black Wolf
	["{item:1041} is in the client (20g) but our data has no vendor selling it."] = "{item:1041} está en el cliente (20 o), pero nuestros datos no tienen ningún mercader que lo venda.",
}
