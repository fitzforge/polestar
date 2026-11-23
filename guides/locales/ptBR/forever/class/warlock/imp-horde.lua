-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/imp-horde (forever/class/warlock/imp-horde.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Imp (Horde)"] = "Diabrete (Horda)",
	["Your first demon at level 1-4: the imp, with a starter blade or staff for Orcs and Trolls."] = "Seu primeiro demônio no nível 1-4: o diabrete, com uma lâmina ou cajado inicial para Orcs e Trolls.",

	-- Step 1: Ruzan (Orcs and Trolls)
	-- {npc:5765} Ruzan
	["{npc:5765} (Orcs and Trolls)"] = "{npc:5765} (Orcs e Trolls)",
	-- {item:9579} Tainted Parchment · {item:282346} Tainted Tablet · {npc:5765} Ruzan · {area:363} Valley of Trials
	-- plural, as words: Vile Familiar Heads = {item:6487} Vile Familiar Head
	["Your first letter ({item:9579} for Orcs, {item:282346} for Trolls, from Gornek after Cutting Teeth) points you to Nartok, the warlock trainer in the Den. {npc:5765} stands just outside the Den in the {area:363} and asks for six Vile Familiar Heads."] = "Sua primeira carta ({item:9579} para Orcs, {item:282346} para Trolls, de Gornek depois de Dentes cortantes) leva você a Nartok, o instrutor de bruxo na Toca. {npc:5765} fica logo fora da Toca, em {area:363}, e pede seis Cabeças de Demônio Familiar Vil.",

	-- Step 2: Vile Familiars
	-- {quest:1485} Vile Familiars · {area:365} Burning Blade Coven
	["The {quest:1485} (level 3-4) swarm the {area:365}, the cave north of the Den, inside and around its mouth. Almost every kill drops a head (80%), so about eight kills does it; they throw small fireballs, so pull them one at a time. They respawn in just over three minutes. Other classes hunt the same imps for their own {quest:1485} quest."] = "Os {quest:1485} (nível 3-4) infestam {area:365}, a caverna ao norte da Toca, por dentro e em volta da boca. Quase toda morte solta uma cabeça (80%), então umas oito mortes resolvem; eles jogam bolas de fogo pequenas, então puxe um de cada vez. Voltam em pouco mais de três minutos. Outras classes caçam os mesmos diabretes para a própria missão de {quest:1485}.",
	-- plural, as words: Vile Familiar Heads = {item:6487} Vile Familiar Head
	["Vile Familiar Heads"] = "Cabeças de Demônio Familiar Vil",

	-- Step 3: Summon Imp
	-- {npc:5765} Ruzan · {spell:688} Summon Imp · {npc:3145} Zureetha Fargaze
	["{npc:5765} teaches you {spell:688} when you hand in the heads: summon it right away, it costs nothing and fights beside you. Then speak with {npc:3145} a few steps away for a starter weapon."] = "{npc:5765} ensina {spell:688} quando você entrega as cabeças: invoque na hora, não custa nada e luta ao seu lado. Depois fale com {npc:3145}, a poucos passos, para pegar uma arma inicial.",

	-- Step 4: Venya Marthand (Undead)
	-- {npc:5667} Venya Marthand
	["{npc:5667} (Undead)"] = "{npc:5667} (Mortos-vivos)",
	-- {item:9578} Tainted Scroll · {npc:1569} Shadow Priest Sarvis · {area:154} Deathknell · {npc:5667} Venya Marthand
	-- plural, as words: Rattlecage Skulls = {item:6281} Rattlecage Skull
	["Your first letter ({item:9578}, from {npc:1569} after The Mindless Ones) points you to Maximillion, the warlock trainer in {area:154}. {npc:5667} waits inside the building beside him and asks for three Rattlecage Skulls."] = "Sua primeira carta ({item:9578}, de {npc:1569} depois de Os desmiolados) leva você a Maximillion, o instrutor de bruxo em {area:154}. {npc:5667} espera dentro do prédio ao lado dele e pede três Crânios de Range-ossos.",

	-- Step 5: Rattlecage Skulls
	-- plural, as words: Rattlecage Skulls = {item:6281} Rattlecage Skull
	["Rattlecage Skulls"] = "Crânios de Range-ossos",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons (level 2-3) stand around the old smithy buildings just north of {area:154}, often right against the walls. Four kills in five drop a skull, so plan on about five; twenty of them spawn there and each comes back after five minutes."] = "Os Esqueletos Range-ossos (nível 2-3) ficam em volta dos velhos prédios da forja logo ao norte de {area:154}, muitas vezes encostados nas paredes. Quatro mortes em cinco soltam um crânio, então conte com umas cinco; vinte aparecem ali e cada um volta depois de cinco minutos.",

	-- Step 6: Summon Imp
	-- {npc:5667} Venya Marthand · {spell:688} Summon Imp
	["{npc:5667} teaches you {spell:688} when you hand in the skulls: summon it right away, it costs nothing and fights beside you."] = "{npc:5667} ensina {spell:688} quando você entrega os crânios: invoque na hora, não custa nada e luta ao seu lado.",
}
