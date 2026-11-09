-- German (deDE): the guide forever/collectibles/pets/weevil-k-neevil (forever/collectibles/pets/weevil-k-neevil.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: My Little Friends
	-- {npc:217412} Amaryllis Webb · {zone:1435} Swamp of Sorrows · {zone:1417} Arathi Highlands · {zone:1443} Desolace
	["{npc:217412}, a Forsaken bug collector, keeps her menagerie in western {zone:1435}. She hands you an Entomology Starter Kit: open it for the tools that catch the three bugs. The bugs are far apart (northern Stranglethorn, {zone:1417} and {zone:1443}), so do them while you pass. If you lose the kit, she sells another for 50s."] = "{npc:217412}, eine Verlassene Käfersammlerin, hält ihre Menagerie im Westen des {zone:1435}. Sie gibt dir ein Entomology Starter Kit: Öffne es für die Werkzeuge, mit denen man die drei Käfer fängt. Die Käfer sind weit verstreut (nördliches Stranglethorn, {zone:1417} und {zone:1443}), erledige sie also im Vorbeigehen. Verlierst du das Kit, verkauft sie dir ein neues für 50s.",

	-- Step 2: Arbor Tarantula in Stranglethorn Vale
	-- {npc:217588} Arbor Tarantula · {zone:1434} Stranglethorn Vale
	["{npc:217588} in {zone:1434}"] = "{npc:217588} in {zone:1434}",
	-- plural, as words: Arbor Tarantulas = {npc:217588} Arbor Tarantula
	["The Arbor Tarantulas sit in northern Stranglethorn. Use the kit's tool on one to catch it."] = "Die Arbor Tarantulas sitzen im Norden von Stranglethorn. Benutze das Werkzeug des Kits an einer, um sie zu fangen.",

	-- Step 3: Hay Weevil in Arathi Highlands
	-- {npc:217589} Hay Weevil · {zone:1417} Arathi Highlands
	["{npc:217589} in {zone:1417}"] = "{npc:217589} in {zone:1417}",
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["The Hay Weevils crawl in the north-west of {zone:1417}. Use the kit's tool on one."] = "Die Hay Weevils kriechen im Nordwesten von {zone:1417}. Benutze das Werkzeug des Kits an einem.",

	-- Step 4: Flesh Picker in Desolace
	-- {npc:217590} Flesh Picker · {zone:1443} Desolace
	["{npc:217590} in {zone:1443}"] = "{npc:217590} in {zone:1443}",
	-- {area:596} Kodo Graveyard · {zone:1443} Desolace
	-- plural, as words: Flesh Pickers = {npc:217590} Flesh Picker
	["The Flesh Pickers feed in the {area:596} in the middle of southern {zone:1443}. Use the kit's tool on one."] = "Die Flesh Pickers fressen im {area:596} in der Mitte des Südens von {zone:1443}. Benutze das Werkzeug des Kits an einem.",

	-- Step 5: Back to Amaryllis Webb
	-- {npc:217412} Amaryllis Webb
	["Back to {npc:217412}"] = "Zurück zu {npc:217412}",
	-- {npc:217412} Amaryllis Webb · {item:280456} Weevil K. Neevil
	["Hand {npc:217412} the three specimens: she gives you {item:280456} and 35s."] = "Gib {npc:217412} die drei Exemplare: Sie gibt dir {item:280456} und 35s.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:217412} gives you an Entomology Starter Kit: use its items to catch an {npc:217588}, a Hay Weevil Specimen and a {npc:217590}. This quest is named as the weevil's source but gives only money as its reward; the pet may come from the {npc:217589} you catch. If you lose the kit, she sells another."] = "{npc:217412} gibt dir ein Einsteigerpaket für Entomologen: Benutze seine Gegenstände, um {npc:217588}, ein Heurüsselkäfer-Exemplar und {npc:217590} zu fangen. Diese Quest gilt als Quelle des Rüsselkäfers, gibt aber nur Geld als Belohnung; das Haustier kommt vielleicht vom gefangenen {npc:217589}. Verlierst du das Paket, verkauft sie dir ein neues.",
}
