-- Spanish (Latin America) (esMX): the guide forever/collectibles/pets/smolderweb-carrier (forever/collectibles/pets/smolderweb-carrier.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kibler at Flame Crest
	-- {npc:10260} Kibler
	["{npc:10260} at Flame Crest"] = "",
	-- {npc:10260} Kibler · {zone:1428} Burning Steppes · {item:12264} Worg Carrier
	["{npc:10260} stands inside the cave at Flame Crest, the camp in northern {zone:1428} east of Blackrock Mountain. He also gives {npc:10260}'s Exotic Pets (the {item:12264}): take both, they are done in the same run."] = "",

	-- Step 2: Lower Blackrock Spire
	["Lower Blackrock Spire"] = "",
	-- {npc:10596} Mother Smolderweb
	-- plural, as words: Spire Spider Eggs = {item:12530} Spire Spider Egg
	["Lower Blackrock Spire is a group of five, level 55-60, inside Blackrock Mountain. The Spire Spider Eggs lie around {npc:10596}'s nest in the Skitterweb Tunnels, the spider halls: click them until you have 15 (each gives one to three). Hard-hitting spiderlings can hatch as you loot. By player reports the eggs cannot be looted in a raid group, so keep the party at five or fewer."] = "",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "Regresa con {npc:10260}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Lower {area:1583}"] = "{area:1583} inferior",
	-- ["Lower {area:1583} is a group of five, level 55-60. Collect 15 Spire Spider Eggs from the nests near {npc:10596}."] = "{area:1583} inferior es para un grupo de cinco, nivel 55-60. Recoge 15 Huevos de araña de la cumbre ({item:12530}) de los nidos cerca de {npc:10596}.",
	-- ["{npc:10260} at {area:251}"] = "{npc:10260} en {area:251}",
	-- ["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260} está en {area:251}, en el norte de {zone:1428}, cerca del camino a {area:254}.",
}
