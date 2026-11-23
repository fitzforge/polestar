-- French (frFR): the guide forever/collectibles/mounts/horde/black-war-mounts (forever/collectibles/mounts/horde/black-war-mounts.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Black War Mounts"] = "Montures de guerre noires",

	-- Step 1: PvP rank 11
	["PvP rank 11"] = "Rang JcJ 11",
	-- {spell:1299382} Rank Points · {spell:436438} Lieutenant General · {skill:762} Riding
	["{spell:1299382} come from battlegrounds, PvP quests and the season's weekly tasks, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. The Player vs. Player tab of your character pane shows your rank and what you may buy. {skill:762} one at full speed needs Journeyman {skill:762} (level 60). Polestar cannot read your rank, so this step waits for level 60 and Journeyman {skill:762}."] = "Les {spell:1299382} viennent des champs de bataille, des quêtes JcJ et des tâches hebdomadaires de la saison, avec un plafond hebdomadaire ; {spell:436438} (rang 11) débloque les montures de guerre noires. L'onglet Joueur contre Joueur de votre fiche de personnage montre votre rang et ce que vous pouvez acheter. Pour monter à pleine vitesse, la {skill:762} ne suffit pas : il faut la {skill:762} (compagnon) (niveau 60). Polestar ne peut pas lire votre rang, cette étape attend donc le niveau 60 et la {skill:762} (compagnon).",

	-- Step 2: Raider Bork
	-- {npc:12796} Raider Bork · {area:2917} Hall of Legends · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["{npc:12796} sells the mounts by the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters. The Forever client lists each at 100g. Each one also needs its kind's riding: Orcs ride the wolf, Trolls the raptor, Tauren the kodo, Undead the skeletal warhorse. A Skyborne, or anyone choosing another race's mount, first needs that riding from its trainer (Exalted with the race's city)."] = "{npc:12796} vend les montures près du {area:2917}, dans la {object:172958} d'{zone:1454}, à côté des autres intendants d'honneur. Le client Forever les affiche chacune à 100 po. Chacune demande aussi la monte de son espèce : les Orcs montent le loup, les Trolls le raptor, les Taurens le kodo, les Morts-vivants le cheval de guerre squelette. Un Éolide, ou quiconque choisit la monture d'une autre race, doit d'abord apprendre cette monte auprès de son maître (Exalté auprès de la ville de cette race).",
	-- {npc:14329} Black War Wolf · {spell:825} Wolf Riding
	["{npc:14329}, {spell:825}, 100g"] = "{npc:14329}, {spell:825}, 100 po",
	-- {npc:14330} Black War Raptor · {spell:10861} Raptor Riding
	["{npc:14330}, {spell:10861}, 100g"] = "{npc:14330}, {spell:10861}, 100 po",
	-- {item:18247} Black War Kodo · {spell:18995} Kodo Riding
	["{item:18247}, {spell:18995}, 100g"] = "{item:18247}, {spell:18995}, 100 po",
	-- {item:18248} Red Skeletal Warhorse · {spell:10906} Undead Horsemanship
	["{item:18248}, {spell:10906}, 100g"] = "{item:18248}, {spell:10906}, 100 po",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["100g"] = "100 po",
	-- ["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Les rangs JcJ de Forever viennent des {spell:1299382} gagnés en champs de bataille et en JcJ sauvage, avec un plafond hebdomadaire ; {spell:436438} (rang 11) débloque les montures de guerre noires. Polestar ne peut pas lire votre rang : cette étape attend donc le niveau 40 et la compétence de monte.",
	-- ["{npc:12796} sells the mounts in the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters such as {npc:12799}. The Forever client lists each at 100g; choose one."] = "{npc:12796} vend les montures dans {area:2917}, dans {object:172958} de {zone:1454}, à côté des autres intendants d'honneur comme {npc:12799}. Le client Forever les vend 100 po chacune ; choisissez-en une.",
}
