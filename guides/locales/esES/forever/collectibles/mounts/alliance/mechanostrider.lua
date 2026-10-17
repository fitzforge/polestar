-- Spanish (Spain) (esES): the guide forever/collectibles/mounts/alliance/mechanostrider (forever/collectibles/mounts/alliance/mechanostrider.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Mechanostrider"] = "Mecazancudo",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprende a montar",
	-- {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding
	["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 40 {npc:7954} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:189} está justo al este de {area:131}; {npc:7954} está junto a los mecazancudos de {npc:7955}. A nivel 40 {npc:7954} enseña {skill:762} (100 o según los diseñadores de Blizzard), y al aprenderla recibes una montura. El cliente de Forever permite montarlos a todas las razas de la Alianza.",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, riding trainer"] = "{npc:7954}, instructor de equitación",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Elige un color",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7955} vende los demás colores (20 o cada uno en el cliente de Forever). Compra los que quieras, o ninguno si te gusta la montura que te dieron.",
	-- {item:8563} Red Mechanostrider
	["{item:8563}, 20g"] = "{item:8563}, 20 o",
	-- {item:8595} Blue Mechanostrider
	["{item:8595}, 20g"] = "{item:8595}, 20 o",
	-- {item:13321} Green Mechanostrider
	["{item:13321}, 20g"] = "{item:13321}, 20 o",
	-- {item:13322} Unpainted Mechanostrider
	["{item:13322}, 20g"] = "{item:13322}, 20 o",
	["Era let only Dwarves and Gnomes ride mechanostriders; the Forever client allows every Alliance race."] = "En Era solo los enanos y los gnomos podían montar mecazancudos; el cliente de Forever lo permite a todas las razas de la Alianza.",
}
