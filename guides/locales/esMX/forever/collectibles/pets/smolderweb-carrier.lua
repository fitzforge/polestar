-- Spanish (Latin America) (esMX): the guide forever/collectibles/pets/smolderweb-carrier (forever/collectibles/pets/smolderweb-carrier.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kibler at Flame Crest
	-- {npc:10260} Kibler · {area:251} Flame Crest
	["{npc:10260} at {area:251}"] = "{npc:10260} en {area:251}",
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain
	["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260} está en {area:251}, en el norte de {zone:1428}, cerca del camino a {area:254}.",

	-- Step 2: Lower Blackrock Spire
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}"] = "{area:1583} inferior",
	-- {area:1583} Blackrock Spire · {npc:10596} Mother Smolderweb
	-- plural, as words: Spire Spider Eggs = {item:12530} Spire Spider Egg
	["Lower {area:1583} is a group of five, level 55-60. Collect 15 Spire Spider Eggs from the nests near {npc:10596}."] = "{area:1583} inferior es para un grupo de cinco, nivel 55-60. Recoge 15 Huevos de araña de la cumbre ({item:12530}) de los nidos cerca de {npc:10596}.",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "Regresa con {npc:10260}",
}
