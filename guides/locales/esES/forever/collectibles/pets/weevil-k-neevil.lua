-- Spanish (Spain) (esES): the guide forever/collectibles/pets/weevil-k-neevil (forever/collectibles/pets/weevil-k-neevil.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: My Little Friends
	-- {npc:217412} Amaryllis Webb · {zone:1435} Swamp of Sorrows · {item:213565} Entomology Starter Kit · {zone:1417} Arathi Highlands · {zone:1443} Desolace
	["{npc:217412}, a Forsaken bug collector, keeps her menagerie in western {zone:1435}. She hands you an {item:213565}: open it for the tools that catch the three bugs. The bugs are far apart (northern Stranglethorn, {zone:1417} and {zone:1443}), so do them while you pass. If you lose the kit, she sells another for 50s."] = "{npc:217412}, una coleccionista de bichos de los Renegados, guarda su colección en el oeste de {zone:1435}. Te entrega un {item:213565}: ábrelo para conseguir las herramientas que atrapan a los tres bichos. Los bichos están muy separados (norte de Tuercespina, {zone:1417} y {zone:1443}), así que hazlos de paso. Si pierdes el kit, ella vende otro por 50 monedas de plata.",

	-- Step 2: Arbor Tarantula in Stranglethorn Vale
	-- {npc:217588} Arbor Tarantula · {zone:1434} Stranglethorn Vale
	["{npc:217588} in {zone:1434}"] = "{npc:217588} en {zone:1434}",
	-- {item:213565} Entomology Starter Kit · {item:213562} Bug Catching Net
	-- plural, as words: Arbor Tarantulas = {npc:217588} Arbor Tarantula
	["The Arbor Tarantulas sit in northern Stranglethorn. Open the {item:213565} and use its {item:213562} on one to catch it: don't kill it."] = "Las tarántulas arbóreas ({npc:217588}) están en el norte de Tuercespina. Abre {item:213565} y usa su {item:213562} en una para atraparla: no la mates.",
	-- {item:213562} Bug Catching Net · {npc:217588} Arbor Tarantula
	["{item:213562}, on an {npc:217588}"] = "{item:213562}, en un {npc:217588}",

	-- Step 3: Hay Weevil in Arathi Highlands
	-- {npc:217589} Hay Weevil · {zone:1417} Arathi Highlands
	["{npc:217589} in {zone:1417}"] = "{npc:217589} en {zone:1417}",
	-- {zone:1417} Arathi Highlands · {item:213562} Bug Catching Net
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["The Hay Weevils crawl in the north-west of {zone:1417}. Use the {item:213562} on one."] = "Los gorgojos del heno ({npc:217589}) se arrastran por el noroeste de {zone:1417}. Usa {item:213562} en uno.",
	-- {item:213562} Bug Catching Net · {npc:217589} Hay Weevil
	["{item:213562}, on a {npc:217589}"] = "{item:213562}, en un {npc:217589}",

	-- Step 4: Flesh Picker in Desolace
	-- {npc:217590} Flesh Picker · {zone:1443} Desolace
	["{npc:217590} in {zone:1443}"] = "{npc:217590} en {zone:1443}",
	-- {area:596} Kodo Graveyard · {zone:1443} Desolace · {item:213562} Bug Catching Net
	-- plural, as words: Flesh Pickers = {npc:217590} Flesh Picker
	["The Flesh Pickers feed in the {area:596} in the middle of southern {zone:1443}. Use the {item:213562} on one."] = "Los Picadores de carne ({npc:217590}) comen en {area:596}, en el centro del sur de {zone:1443}. Usa {item:213562} en uno.",
	-- {item:213562} Bug Catching Net · {npc:217590} Flesh Picker
	["{item:213562}, on a {npc:217590}"] = "{item:213562}, en un {npc:217590}",

	-- Step 5: Back to Amaryllis Webb
	-- {npc:217412} Amaryllis Webb
	["Back to {npc:217412}"] = "Vuelve con {npc:217412}",
	-- {npc:217412} Amaryllis Webb · {item:280456} Weevil K. Neevil
	["Hand {npc:217412} the three specimens: she gives you {item:280456} and 35s."] = "Entrega los tres ejemplares a {npc:217412}: ella te da el {item:280456} y 35 monedas de plata.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Arbor Tarantulas sit in northern Stranglethorn. Use the kit's tool on one to catch it."] = "Las tarántulas del Árbol están en el norte de Tuercespina. Usa la herramienta del kit sobre una para atraparla.",
	-- ["The Flesh Pickers feed in the {area:596} in the middle of southern {zone:1443}. Use the kit's tool on one."] = "Los Carne Lacerada se alimentan en {area:596}, en el centro del sur de {zone:1443}. Usa la herramienta del kit sobre uno.",
	-- ["The Hay Weevils crawl in the north-west of {zone:1417}. Use the kit's tool on one."] = "Los gorgojos del Heno se arrastran por el noroeste de {zone:1417}. Usa la herramienta del kit sobre uno.",
	-- ["{npc:217412} gives you an Entomology Starter Kit: use its items to catch an {npc:217588}, a Hay Weevil Specimen and a {npc:217590}. This quest is named as the weevil's source but gives only money as its reward; the pet may come from the {npc:217589} you catch. If you lose the kit, she sells another."] = "{npc:217412} te da un kit de iniciación a la entomología: usa sus objetos para atrapar una {npc:217588}, un espécimen de gorgojo y un {npc:217590}. Esta misión figura como origen del gorgojo, pero solo da dinero como recompensa; puede que la mascota salga del {npc:217589} que atrapes. Si pierdes el kit, ella vende otro.",
}
