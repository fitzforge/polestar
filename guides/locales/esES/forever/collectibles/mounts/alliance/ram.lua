-- Spanish (Spain) (esES): the guide forever/collectibles/mounts/alliance/ram (forever/collectibles/mounts/alliance/ram.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ram"] = "Carnero",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprende a montar",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 40 {npc:4772} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:803} está al este de {area:131}, en el camino a {zone:1432}; {npc:4772} está junto a los carneros de {npc:1261}. A nivel 40 {npc:4772} enseña {skill:762} (100 o según los diseñadores de Blizzard), y al aprenderla recibes una montura. El cliente de Forever permite montarlos a todas las razas de la Alianza.",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}, instructor de equitación",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Elige un color",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261} vende los demás colores (20 o cada uno en el cliente de Forever). Compra los que quieras, o ninguno si te gusta la montura que te dieron.",
	-- {item:5864} Gray Ram
	["{item:5864}, 20g"] = "{item:5864}, 20 o",
	-- {item:5872} Brown Ram
	["{item:5872}, 20g"] = "{item:5872}, 20 o",
	-- {item:5873} White Ram
	["{item:5873}, 20g"] = "{item:5873}, 20 o",
}
