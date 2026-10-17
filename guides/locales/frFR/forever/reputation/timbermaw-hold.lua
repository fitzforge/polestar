-- French (frFR): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "Réputation : Les Grumegueules",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold
	["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576} commence Hostile, et ses furbolgs des tunnels attaquent jusqu'à ce que vous soyez Inamical. Chaque furbolg Mort-bois ou Tombe-hiver tué l'augmente : les quêtes ci-dessous rapportent donc deux fois. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:11554} Grazle · {npc:15395} Nafien
	["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "Les furbolgs Mort-bois (niveau 48-50) campent à l'extrémité sud de {zone:1448}. Gardez chaque {item:21377} qu'ils lâchent : {npc:11554} et {npc:15395} les prennent plus tard.",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "Retour à {npc:11554}",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood · {faction:576} Timbermaw Hold
	["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395} attend au nord de {zone:1448}, au tunnel menant chez {faction:576}.",

	-- Step 5: Deadwood of the North
	["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "Les Mort-bois du nord (niveau 53-55) tiennent les camps juste au sud du tunnel. Gardez aussi leurs plumes.",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "Retour à {npc:15395}",

	-- Step 7: Salfa
	-- {faction:576} Timbermaw Hold · {zone:1452} Winterspring · {npc:11556} Salfa
	["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "Traversez le territoire de {faction:576} jusqu'à la sortie de {zone:1452} ; {npc:11556} se tient juste dehors. Les quêtes et victimes jusqu'ici suffisent en général pour Inamical, et les Grumegueules vous laissent alors passer. S'ils apparaissent encore en rouge, tuez d'abord d'autres Mort-bois près du tunnel.",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {item:21383} Winterfall Spirit Beads · {npc:11556} Salfa
	["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "Le {area:2244} est à l'est de {zone:1452}. Gardez chaque {item:21383} ramassée : {npc:11556} les prend.",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "Retour à {npc:11556}",

	-- Step 10: Feathers and beads to Friendly
	["Feathers and beads to Friendly"] = "Plumes et perles jusqu'à Amical",
	-- {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {item:21383} Winterfall Spirit Beads · {area:2244} Winterfall Village
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "Des plumes pour {npc:11554} et Des plumes pour {npc:15395} (Coiffures de plumes mort-bois) et Des perles pour {npc:11556} ({item:21383}) se répètent à volonté ; chaque Mort-bois ou Tombe-hiver tué compte aussi. Le {area:2244} est le meilleur endroit pour les perles.",
	-- {npc:11556} Salfa
	["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556} : Des perles pour {npc:11556}",

	-- Step 11: Feathers to Honored
	["Feathers to Honored"] = "Plumes jusqu'à Honoré",
	-- {npc:15395} Nafien · {npc:11554} Grazle
	["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "Les camps Mort-bois du nord près du tunnel sont le meilleur endroit pour les plumes (35 % de chances de butin). Donnez les plumes à {npc:15395} au tunnel, ou à {npc:11554} au sud.",
	-- {npc:15395} Nafien
	["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395} : Des plumes pour {npc:15395}",

	-- Step 12: Timbermaw Hold to Revered
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Revered"] = "{faction:576} jusqu'à Révéré",
	-- {npc:15395} Nafien · {npc:11556} Salfa
	["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "Alternez plumes Mort-bois ({npc:15395}) et perles Tombe-hiver ({npc:11556}), selon le camp le moins fréquenté.",

	-- Step 13: Timbermaw Hold to Exalted
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Exalted"] = "{faction:576} jusqu'à Exalté",
	["Keep turning in feathers and beads until Exalted."] = "Continuez à rendre plumes et perles jusqu'à Exalté.",
}
