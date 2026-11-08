-- Spanish (Spain) (esES): the guide forever/collectibles/pets/weevil-k-neevil (forever/collectibles/pets/weevil-k-neevil.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: My Little Friends
	-- {npc:217412} Amaryllis Webb · {zone:1435} Swamp of Sorrows · {zone:1417} Arathi Highlands · {zone:1443} Desolace
	["{npc:217412}, a Forsaken bug collector, keeps her menagerie in western {zone:1435}. She hands you an Entomology Starter Kit: open it for the tools that catch the three bugs. The bugs are far apart (northern Stranglethorn, {zone:1417} and {zone:1443}), so do them while you pass. If you lose the kit, she sells another for 50s."] = "",

	-- Step 2: Arbor Tarantula in Stranglethorn Vale
	-- {npc:217588} Arbor Tarantula · {zone:1434} Stranglethorn Vale
	["{npc:217588} in {zone:1434}"] = "",
	-- plural, as words: Arbor Tarantulas = {npc:217588} Arbor Tarantula
	["The Arbor Tarantulas sit in northern Stranglethorn. Use the kit's tool on one to catch it."] = "",

	-- Step 3: Hay Weevil in Arathi Highlands
	-- {npc:217589} Hay Weevil · {zone:1417} Arathi Highlands
	["{npc:217589} in {zone:1417}"] = "",
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["The Hay Weevils crawl in the north-west of {zone:1417}. Use the kit's tool on one."] = "",

	-- Step 4: Flesh Picker in Desolace
	-- {npc:217590} Flesh Picker · {zone:1443} Desolace
	["{npc:217590} in {zone:1443}"] = "",
	-- {zone:1443} Desolace
	-- plural, as words: Flesh Pickers = {npc:217590} Flesh Picker
	["The Flesh Pickers feed in the Kodo Graveyard in the middle of southern {zone:1443}. Use the kit's tool on one."] = "",

	-- Step 5: Back to Amaryllis Webb
	-- {npc:217412} Amaryllis Webb
	["Back to {npc:217412}"] = "",
	-- {npc:217412} Amaryllis Webb · {item:280456} Weevil K. Neevil
	["Hand {npc:217412} the three specimens: she gives you {item:280456} and 35s."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:217412} gives you an Entomology Starter Kit: use its items to catch an {npc:217588}, a Hay Weevil Specimen and a {npc:217590}. This quest is named as the weevil's source but gives only money as its reward; the pet may come from the {npc:217589} you catch. If you lose the kit, she sells another."] = "{npc:217412} te da un kit de iniciación a la entomología: usa sus objetos para atrapar una {npc:217588}, un espécimen de gorgojo y un {npc:217590}. Esta misión figura como origen del gorgojo, pero solo da dinero como recompensa; puede que la mascota salga del {npc:217589} que atrapes. Si pierdes el kit, ella vende otro.",
}
