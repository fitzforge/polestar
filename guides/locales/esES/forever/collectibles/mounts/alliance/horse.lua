-- Spanish (Spain) (esES): the guide forever/collectibles/mounts/alliance/horse (forever/collectibles/mounts/alliance/horse.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Horse"] = "Caballo",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprende a montar",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4732} y el corral de caballos de {npc:384} están en el {area:88}, en el este del {zone:1429}. A nivel 40, {npc:4732} enseña {skill:762} (100 o según los diseñadores de Blizzard), y aprenderla te da una montura. El cliente de Forever permite a todas las razas de la Alianza montarlos.",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}, instructor de equitación",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Elige un color",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384} vende los demás colores (20 o cada uno en el cliente de Forever). Compra los que quieras, o ninguno si te gusta la montura que te dieron.",
	-- {item:2414} Pinto Bridle
	["{item:2414}, 20g"] = "{item:2414}, 20 o",
	-- {item:5655} Chestnut Mare Bridle
	["{item:5655}, 20g"] = "{item:5655}, 20 o",
	-- {item:5656} Brown Horse Bridle
	["{item:5656}, 20g"] = "{item:5656}, 20 o",
	-- {item:2411} Black Stallion Bridle
	["{item:2411} is in the client, but no vendor is confirmed to sell it in Forever."] = "{item:2411} está en el cliente, pero no hay ningún vendedor confirmado que la venda en Forever.",
}
