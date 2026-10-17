-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/horde/skeletal-warhorse (forever/collectibles/mounts/horde/skeletal-warhorse.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Skeletal Warhorse"] = "Caballo de guerra esquelético",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} de oficial",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each skeletal warhorse for 200g at level 60."] = "{npc:4773} y el establo de {npc:4731} están en {area:159}, {zone:1420}. A nivel 60, {npc:4773} enseña {skill:762} de oficial (1,000 o según los diseñadores de Blizzard); Blizzard dice que aprender equitación otorga una montura. El cliente de Forever vende cada caballo de guerra esquelético por 200 o a nivel 60.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, instructora de equitación",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Elige un color",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731} vende los otros colores (200 o cada uno en el cliente de Forever). Compra los que quieras, o ninguno si te gusta la montura que te dieron.",
	-- {item:13334} Green Skeletal Warhorse
	["{item:13334}, 200g"] = "{item:13334}, 200 o",
	-- {item:18791} Purple Skeletal Warhorse
	["{item:18791}, 200g"] = "{item:18791}, 200 o",
	-- {npc:265653} Ochre Skeletal Warhorse
	-- plural, as words: Purple Skeletal Horses = {item:265840} Purple Skeletal Horse
	["The new Forever Green, Dark and Purple Skeletal Horses and the {npc:265653} (level 60) have no known source yet."] = "Los nuevos Caballos esqueléticos verde, oscuro y púrpura de Forever y {npc:265653} (nivel 60) aún no tienen fuente conocida.",
}
