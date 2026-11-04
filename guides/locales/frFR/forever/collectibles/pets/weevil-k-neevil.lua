-- French (frFR): the guide forever/collectibles/pets/weevil-k-neevil (forever/collectibles/pets/weevil-k-neevil.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: My Little Friends
	-- {npc:217412} Amaryllis Webb · {zone:1435} Swamp of Sorrows · {zone:1417} Arathi Highlands · {zone:1443} Desolace
	["{npc:217412}, a Forsaken bug collector, keeps her menagerie in western {zone:1435}. She hands you an Entomology Starter Kit: open it for the tools that catch the three bugs. The bugs are far apart (northern Stranglethorn, {zone:1417} and {zone:1443}), so do them while you pass. If you lose the kit, she sells another for 50s."] = "{npc:217412}, une collectionneuse d'insectes réprouvée, garde sa ménagerie dans l'ouest du {zone:1435}. Elle vous remet un kit d'entomologiste débutant : ouvrez-le pour obtenir les outils qui capturent les trois insectes. Les insectes sont loin les uns des autres (nord de Strangleronce, {zone:1417} et {zone:1443}) : capturez-les quand vous passez par là. Si vous perdez le kit, elle en vend un autre pour 50 pa.",

	-- Step 2: Arbor Tarantula in Stranglethorn Vale
	-- {npc:217588} Arbor Tarantula · {zone:1434} Stranglethorn Vale
	["{npc:217588} in {zone:1434}"] = "{npc:217588} dans la {zone:1434}",
	-- plural, as words: Arbor Tarantulas = {npc:217588} Arbor Tarantula
	["The Arbor Tarantulas sit in northern Stranglethorn. Use the kit's tool on one to catch it."] = "Les tarentules ({npc:217588}) se trouvent dans le nord de Strangleronce. Utilisez l'outil du kit sur l'une d'elles pour la capturer.",

	-- Step 3: Hay Weevil in Arathi Highlands
	-- {npc:217589} Hay Weevil · {zone:1417} Arathi Highlands
	["{npc:217589} in {zone:1417}"] = "{npc:217589} dans les {zone:1417}",
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["The Hay Weevils crawl in the north-west of {zone:1417}. Use the kit's tool on one."] = "Les Charançons des foins rampent dans le nord-ouest des {zone:1417}. Utilisez l'outil du kit sur l'un d'eux.",

	-- Step 4: Flesh Picker in Desolace
	-- {npc:217590} Flesh Picker · {zone:1443} Desolace
	["{npc:217590} in {zone:1443}"] = "{npc:217590} en {zone:1443}",
	-- {area:596} Kodo Graveyard · {zone:1443} Desolace
	-- plural, as words: Flesh Pickers = {npc:217590} Flesh Picker
	["The Flesh Pickers feed in the {area:596} in the middle of southern {zone:1443}. Use the kit's tool on one."] = "Les Pique-chair se nourrissent dans le {area:596}, au milieu du sud de {zone:1443}. Utilisez l'outil du kit sur l'un d'eux.",

	-- Step 5: Back to Amaryllis Webb
	-- {npc:217412} Amaryllis Webb
	["Back to {npc:217412}"] = "Retour auprès de {npc:217412}",
	-- {npc:217412} Amaryllis Webb · {item:280456} Weevil K. Neevil
	["Hand {npc:217412} the three specimens: she gives you {item:280456} and 35s."] = "Remettez les trois spécimens à {npc:217412} : elle vous donne {item:280456} et 35 pa.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:217412} gives you an Entomology Starter Kit: use its items to catch an {npc:217588}, a Hay Weevil Specimen and a {npc:217590}. This quest is named as the weevil's source but gives only money as its reward; the pet may come from the {npc:217589} you catch. If you lose the kit, she sells another."] = "{npc:217412} vous donne un Kit d’entomologiste novice : utilisez ses objets pour attraper {npc:217588}, un spécimen de charançon des foins et {npc:217590}. Cette quête est indiquée comme source du charançon mais ne rapporte que de l'argent ; la mascotte peut venir du {npc:217589} que vous attrapez. Si vous perdez le kit, elle en vend un autre.",
}
