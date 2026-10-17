-- French (frFR): the guide forever/collectibles/pets/smolderweb-carrier (forever/collectibles/pets/smolderweb-carrier.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kibler at Flame Crest
	-- {npc:10260} Kibler · {area:251} Flame Crest
	["{npc:10260} at {area:251}"] = "{npc:10260} à {area:251}",
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain
	["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260} se trouve à {area:251}, dans le nord de {zone:1428}, près du chemin de {area:254}.",

	-- Step 2: Lower Blackrock Spire
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}"] = "{area:1583} inférieur",
	-- {area:1583} Blackrock Spire · {npc:10596} Mother Smolderweb
	-- plural, as words: Spire Spider Eggs = {item:12530} Spire Spider Egg
	["Lower {area:1583} is a group of five, level 55-60. Collect 15 Spire Spider Eggs from the nests near {npc:10596}."] = "Le bas du {area:1583} se fait en groupe de cinq, niveau 55-60. Ramassez 15 Oeufs d'araignée du pic ({item:12530}) dans les nids près de {npc:10596}.",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "Retour auprès de {npc:10260}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Lower {area:1583} is a group of five, level 55-60. Collect 15 {npc:10374} Eggs from the nests near {npc:10596}."] = "{area:1583} inférieur se fait en groupe de cinq, niveau 55-60. Ramassez 15 Oeufs d'araignée du pic ({npc:10374}) dans les nids près de {npc:10596}.",
}
