-- French (frFR): the guide forever/class/warlock/imp-horde (forever/class/warlock/imp-horde.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Imp (Horde)"] = "Diablotin (Horde)",
	["Your first demon at level 1-4: the imp, with a starter blade or staff for Orcs and Trolls."] = "Votre premier démon, au niveau 1-4 : le diablotin, avec une lame ou un bâton de départ pour les Orcs et les Trolls.",

	-- Step 1: Ruzan (Orcs and Trolls)
	-- {npc:5765} Ruzan
	["{npc:5765} (Orcs and Trolls)"] = "{npc:5765} (Orcs et Trolls)",
	-- {item:9579} Tainted Parchment · {item:282346} Tainted Tablet · {npc:5765} Ruzan
	-- plural, as words: Vile Familiar Heads = {item:6487} Vile Familiar Head
	["Your first letter ({item:9579} for Orcs, {item:282346} for Trolls, from Gornek after Cutting Teeth) points you to Nartok, the warlock trainer in the Den. {npc:5765} stands just outside the Den in the Valley of Trials and asks for six Vile Familiar Heads."] = "",

	-- Step 2: Vile Familiars
	-- {quest:1485} Vile Familiars
	["The {quest:1485} (level 3-4) swarm the Burning Blade Coven, the cave north of the Den, inside and around its mouth. Almost every kill drops a head (80%), so about eight kills does it; they throw small fireballs, so pull them one at a time. They respawn in just over three minutes. Other classes hunt the same imps for their own {quest:1485} quest."] = "",
	-- plural, as words: Vile Familiar Heads = {item:6487} Vile Familiar Head
	["Vile Familiar Heads"] = "Têtes de Vil quasit",

	-- Step 3: Summon Imp
	-- {npc:5765} Ruzan · {spell:688} Summon Imp · {npc:3145} Zureetha Fargaze
	["{npc:5765} teaches you {spell:688} when you hand in the heads: summon it right away, it costs nothing and fights beside you. Then speak with {npc:3145} a few steps away for a starter weapon."] = "{npc:5765} vous apprend {spell:688} quand vous rendez les têtes : invoquez-le tout de suite, il ne coûte rien et combat à vos côtés. Parlez ensuite à {npc:3145}, à quelques pas, pour une arme de départ.",

	-- Step 4: Venya Marthand (Undead)
	-- {npc:5667} Venya Marthand
	["{npc:5667} (Undead)"] = "{npc:5667} (Morts-vivants)",
	-- {item:9578} Tainted Scroll · {npc:1569} Shadow Priest Sarvis · {npc:5667} Venya Marthand
	-- plural, as words: Rattlecage Skulls = {item:6281} Rattlecage Skull
	["Your first letter ({item:9578}, from {npc:1569} after The Mindless Ones) points you to Maximillion, the warlock trainer in Deathknell. {npc:5667} waits inside the building beside him and asks for three Rattlecage Skulls."] = "",

	-- Step 5: Rattlecage Skulls
	-- plural, as words: Rattlecage Skulls = {item:6281} Rattlecage Skull
	["Rattlecage Skulls"] = "Crânes de Cliquethorax",
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons (level 2-3) stand around the old smithy buildings just north of Deathknell, often right against the walls. Four kills in five drop a skull, so plan on about five; twenty of them spawn there and each comes back after five minutes."] = "",

	-- Step 6: Summon Imp
	-- {npc:5667} Venya Marthand · {spell:688} Summon Imp
	["{npc:5667} teaches you {spell:688} when you hand in the skulls: summon it right away, it costs nothing and fights beside you."] = "{npc:5667} vous apprend {spell:688} quand vous rendez les crânes : invoquez-le tout de suite, il ne coûte rien et combat à vos côtés.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Rattlecage Skeletons (level 2-3) stand around the old smithy buildings just north of {area:154}, often right against the walls. Four kills in five drop a skull, so plan on about five; twenty of them spawn there and each comes back after five minutes."] = "Les Squelettes Cliquethorax (niveau 2-3) se tiennent autour des vieux bâtiments de la forge, juste au nord de {area:154}, souvent collés aux murs. Quatre fois sur cinq, ils lâchent un crâne, comptez donc environ cinq victimes ; vingt d'entre eux apparaissent là et chacun revient au bout de cinq minutes.",
	-- ["The {quest:1485} (level 3-4) swarm the {area:365}, the cave north of the Den, inside and around its mouth. Almost every kill drops a head (80%), so about eight kills does it; they throw small fireballs, so pull them one at a time. They respawn in just over three minutes. Other classes hunt the same imps for their own {quest:1485} quest."] = "Les {quest:1485} (niveau 3-4) grouillent dans le {area:365}, la grotte au nord de l'Antre, à l'intérieur et autour de l'entrée. Presque chaque victime lâche une tête (80 %), environ huit suffisent donc ; ils lancent de petites boules de feu, attirez-les donc un par un. Ils réapparaissent en un peu plus de trois minutes. Les autres classes chassent les mêmes diablotins pour leur propre quête {quest:1485}.",
	-- ["Your first letter ({item:9578}, from {npc:1569} after The Mindless Ones) points you to Maximillion, the warlock trainer in {area:154}. {npc:5667} waits inside the building beside him and asks for three Rattlecage Skulls."] = "Votre première lettre ({item:9578}, de {npc:1569} après Les Déchus) vous mène à Maximillion, le maître des démonistes à {area:154}. {npc:5667} attend dans le bâtiment à côté de lui et demande trois Crânes de Cliquethorax.",
	-- ["Your first letter ({item:9579} for Orcs, {item:282346} for Trolls, from Gornek after Cutting Teeth) points you to Nartok, the warlock trainer in the Den. {npc:5765} stands just outside the Den in the {area:363} and asks for six Vile Familiar Heads."] = "Votre première lettre ({item:9579} pour les Orcs, {item:282346} pour les Trolls, de Gornek après La dent tranchante) vous mène à Nartok, le maître des démonistes dans l'Antre. {npc:5765} se tient juste devant l'Antre, dans la {area:363}, et demande six Têtes de Vil quasit.",
}
