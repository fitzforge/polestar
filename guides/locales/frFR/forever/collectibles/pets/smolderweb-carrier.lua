-- French (frFR): the guide forever/collectibles/pets/smolderweb-carrier (forever/collectibles/pets/smolderweb-carrier.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
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
	["Back to {npc:10260}"] = "Retour auprès de {npc:10260}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Lower {area:1583}"] = "{area:1583} inférieur",
	-- ["Lower {area:1583} is a group of five, level 55-60, inside {area:254}. The Spire Spider Eggs lie around {npc:10596}'s nest in the Skitterweb Tunnels, the spider halls: click them until you have 15 (each gives one to three). Hard-hitting spiderlings can hatch as you loot. By player reports the eggs cannot be looted in a raid group, so keep the party at five or fewer."] = "Le {area:1583} inférieur est un donjon pour un groupe de cinq, niveau 55-60, dans le {area:254}. Les Œufs d'araignée du pic se trouvent autour du nid de la {npc:10596}, dans les tunnels des araignées : cliquez dessus jusqu'à en avoir 15 (chacun en donne un à trois). Des araignées qui frappent fort peuvent éclore pendant que vous ramassez. D'après des joueurs, les œufs ne peuvent pas être ramassés en groupe de raid : restez à cinq au maximum.",
	-- ["Lower {area:1583} is a group of five, level 55-60. Collect 15 Spire Spider Eggs from the nests near {npc:10596}."] = "Le bas du {area:1583} se fait en groupe de cinq, niveau 55-60. Ramassez 15 Oeufs d'araignée du pic ({item:12530}) dans les nids près de {npc:10596}.",
	-- ["Lower {area:1583} is a group of five, level 55-60. Collect 15 {npc:10374} Eggs from the nests near {npc:10596}."] = "{area:1583} inférieur se fait en groupe de cinq, niveau 55-60. Ramassez 15 Oeufs d'araignée du pic ({npc:10374}) dans les nids près de {npc:10596}.",
	-- ["{npc:10260} at {area:251}"] = "{npc:10260} à {area:251}",
	-- ["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260} se trouve à {area:251}, dans le nord de {zone:1428}, près du chemin de {area:254}.",
	-- ["{npc:10260} stands inside the cave at {area:251}, the camp in northern {zone:1428} east of {area:254}. He also gives {npc:10260}'s Exotic Pets (the {item:12264}): take both, they are done in the same run."] = "{npc:10260} se tient dans la grotte de {area:251}, le camp du nord des {zone:1428}, à l'est du {area:254}. Il donne aussi Les animaux exotiques de {npc:10260} (la {item:12264}) : acceptez les deux, elles se font dans la même expédition.",
}
