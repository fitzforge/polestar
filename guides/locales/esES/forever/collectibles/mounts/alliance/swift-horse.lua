-- Spanish (Spain) (esES): the guide forever/collectibles/mounts/alliance/swift-horse (forever/collectibles/mounts/alliance/swift-horse.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Horse"] = "Caballo veloz",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (oficial)",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 60 {npc:4732} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift horse for 200g at level 60."] = "{npc:4732} y el corral de caballos de {npc:384} están en {area:88}, en el este de {zone:1429}. A nivel 60, {npc:4732} enseña {skill:762} de oficial (1000 o según los diseñadores de Blizzard); Blizzard dice que aprender a montar te da una montura. El cliente de Forever vende cada caballo veloz por 200 o a nivel 60.",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}, instructor de equitación",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Elige un color",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384} vende los demás colores (200 o cada uno en el cliente de Forever). Compra los que quieras, o ninguno si te gusta la montura que te dieron.",
	-- {item:18776} Swift Palomino
	["{item:18776}, 200g"] = "{item:18776}, 200 o",
	-- {item:18777} Swift Brown Steed
	["{item:18777}, 200g"] = "{item:18777}, 200 o",
	-- {item:18778} Swift White Steed
	["{item:18778}, 200g"] = "{item:18778}, 200 o",
}
