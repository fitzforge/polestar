-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/weevil-k-neevil (forever/collectibles/pets/weevil-k-neevil.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: My Little Friends
	-- {npc:217412} Amaryllis Webb · {zone:1435} Swamp of Sorrows · {zone:1417} Arathi Highlands · {zone:1443} Desolace
	["{npc:217412}, a Forsaken bug collector, keeps her menagerie in western {zone:1435}. She hands you an Entomology Starter Kit: open it for the tools that catch the three bugs. The bugs are far apart (northern Stranglethorn, {zone:1417} and {zone:1443}), so do them while you pass. If you lose the kit, she sells another for 50s."] = "{npc:217412}, uma coletora de insetos Renegada, mantém o zoológico dela no oeste de {zone:1435}. Ela entrega um Kit Inicial de Entomologia: abra para pegar as ferramentas que capturam os três insetos. Os insetos ficam bem distantes (norte do Espinhaço, {zone:1417} e {zone:1443}), então faça enquanto passa. Se perder o kit, ela vende outro por 50s.",

	-- Step 2: Arbor Tarantula in Stranglethorn Vale
	-- {npc:217588} Arbor Tarantula · {zone:1434} Stranglethorn Vale
	["{npc:217588} in {zone:1434}"] = "{npc:217588} em {zone:1434}",
	-- plural, as words: Arbor Tarantulas = {npc:217588} Arbor Tarantula
	["The Arbor Tarantulas sit in northern Stranglethorn. Use the kit's tool on one to catch it."] = "As Tarântulas Arbóreas ficam no norte do Espinhaço. Use a ferramenta do kit em uma para capturá-la.",

	-- Step 3: Hay Weevil in Arathi Highlands
	-- {npc:217589} Hay Weevil · {zone:1417} Arathi Highlands
	["{npc:217589} in {zone:1417}"] = "{npc:217589} em {zone:1417}",
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["The Hay Weevils crawl in the north-west of {zone:1417}. Use the kit's tool on one."] = "Os Gorgulhos do Feno rastejam no noroeste de {zone:1417}. Use a ferramenta do kit em um.",

	-- Step 4: Flesh Picker in Desolace
	-- {npc:217590} Flesh Picker · {zone:1443} Desolace
	["{npc:217590} in {zone:1443}"] = "{npc:217590} em {zone:1443}",
	-- {area:596} Kodo Graveyard · {zone:1443} Desolace
	-- plural, as words: Flesh Pickers = {npc:217590} Flesh Picker
	["The Flesh Pickers feed in the {area:596} in the middle of southern {zone:1443}. Use the kit's tool on one."] = "Os Flesh Pickers se alimentam em {area:596}, no meio do sul de {zone:1443}. Use a ferramenta do kit em um.",

	-- Step 5: Back to Amaryllis Webb
	-- {npc:217412} Amaryllis Webb
	["Back to {npc:217412}"] = "De volta a {npc:217412}",
	-- {npc:217412} Amaryllis Webb · {item:280456} Weevil K. Neevil
	["Hand {npc:217412} the three specimens: she gives you {item:280456} and 35s."] = "Entregue os três espécimes a {npc:217412}: ela entrega {item:280456} e 35s a você.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:217412} gives you an Entomology Starter Kit: use its items to catch an {npc:217588}, a Hay Weevil Specimen and a {npc:217590}. This quest is named as the weevil's source but gives only money as its reward; the pet may come from the {npc:217589} you catch. If you lose the kit, she sells another."] = "{npc:217412} dá a você um kit inicial de entomologia: use os itens dele para capturar uma {npc:217588}, um espécime de gorgulho-do-feno e um {npc:217590}. Esta missão é indicada como a origem do gorgulho, mas só dá dinheiro como recompensa; o mascote pode vir do {npc:217589} que você capturar. Se perder o kit, ela vende outro.",
}
