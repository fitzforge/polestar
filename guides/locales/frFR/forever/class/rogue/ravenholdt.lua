-- French (frFR): the guide forever/class/rogue/ravenholdt (forever/class/rogue/ravenholdt.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3486} Ravenholdt Manor
	["Opens {area:3486}, the hidden rogue house in the Alterac hills, and its first jobs."] = "Ouvre {area:3486}, le repaire caché des voleurs dans les collines d'Alterac, et ses premières missions.",
	-- {npc:13936} Ravenholdt
	["{npc:13936} reputation"] = "Réputation {npc:13936}",

	-- Step 1: The Elegant Letter
	-- {item:17126} Elegant Letter
	["The {item:17126}"] = "{item:17126}",
	-- {item:17126} Elegant Letter · {npc:13936} Ravenholdt · {npc:332} Master Mathias Shaw · {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {zone:1454} Orgrimmar · {item:17125} Seal of Ravenholdt · {npc:6707} Fahrad
	["At 24 an {item:17126} from {npc:13936} starts this; the data gives it to you through {npc:332} or {npc:918} in {zone:1453}, or Gest or Ormok in {zone:1454}. The quest hands you the {item:17125} for {npc:6707}."] = "Au niveau 24, une {item:17126} de {npc:13936} lance cette quête ; les données vous la donnent par {npc:332} ou {npc:918} à {zone:1453}, ou par Gest ou Ormok à {zone:1454}. La quête vous remet le {item:17125} pour {npc:6707}.",

	-- Step 2: Ravenholdt Manor
	-- {area:272} Tarren Mill · {area:271} Southshore · {zone:1416} Alterac Mountains
	["Horde fly to {area:272}, Alliance to {area:271}. The manor hides in the hills east of {area:272}, up a path into the {zone:1416}; the Rite of Cunning is passing its way in."] = "La Horde prend un vol pour {area:272}, l'Alliance pour {area:271}. Le manoir se cache dans les collines à l'est de {area:272}, au bout d'un chemin qui monte dans {zone:1416} ; le Rite of Cunning sert à y entrer.",
	["Rite of Cunning"] = "Rite of Cunning",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	["{npc:6766}: {quest:6701}, repeatable"] = "{npc:6766} : {quest:6701}, répétable",

	-- Step 3: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {area:287} Hillsbrad · {npc:13085} Myrokos Silentform
	["{npc:266216} is inside {area:275}, the Syndicate fortress in eastern {area:287}, south of the manor. Quick and quiet, says {npc:13085}."] = "{npc:266216} est à l'intérieur de {area:275}, la forteresse du Syndicat dans l'est de {area:287}, au sud du manoir. Vite et sans bruit, dit {npc:13085}.",

	-- Step 5: What's the Big Idea?
	-- {npc:13085} Myrokos Silentform · {area:280} Strahnbrad · {zone:1416} Alterac Mountains
	["At 36, {npc:13085} sends you after Barton's scouting report. Barton leads a Syndicate party at {area:280}, in the east of the {zone:1416}: pick his pocket, do not kill him."] = "Au niveau 36, {npc:13085} vous envoie chercher le rapport de reconnaissance de Barton. Barton mène un groupe du Syndicat à {area:280}, dans l'est de {zone:1416} : faites-lui les poches, ne le tuez pas.",
	-- {item:275482} Barton's Scouting Report
	["{item:275482}: pickpocket Barton"] = "{item:275482} : faites les poches de Barton",

	-- Step 6: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "Retour auprès de {npc:13085}",
}
