-- Spanish (Spain) (esES): the guide forever/collectibles/mounts/alliance/swift-ram (forever/collectibles/mounts/alliance/swift-ram.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Ram"] = "Carnero veloz",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} de oficial",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 60 {npc:4772} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift ram for 200g at level 60."] = "{area:803} está al este de {area:131}, en el camino a {zone:1432}; {npc:4772} está junto a los carneros de {npc:1261}. A nivel 60 {npc:4772} enseña {skill:762} de oficial (1000 o según los diseñadores de Blizzard); Blizzard dice que aprender equitación otorga una montura. El cliente de Forever vende cada carnero veloz por 200 o a nivel 60.",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}, instructor de equitación",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Elige un color",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261} vende los demás colores (200 o cada uno en el cliente de Forever). Compra los que quieras, o ninguno si te gusta la montura que te dieron.",
	-- {item:18785} Swift White Ram
	["{item:18785}, 200g"] = "{item:18785}, 200 o",
	-- {item:18786} Swift Brown Ram
	["{item:18786}, 200g"] = "{item:18786}, 200 o",
	-- {item:18787} Swift Gray Ram
	["{item:18787}, 200g"] = "{item:18787}, 200 o",
}
