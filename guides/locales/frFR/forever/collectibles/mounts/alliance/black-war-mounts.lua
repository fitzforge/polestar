-- French (frFR): the guide forever/collectibles/mounts/alliance/black-war-mounts (forever/collectibles/mounts/alliance/black-war-mounts.guide).
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
	-- {spell:1299382} Rank Points · {skill:762} Riding
	["{spell:1299382} come from battlegrounds, PvP quests and the season's weekly tasks, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. The Player vs. Player tab of your character pane shows your rank and what you may buy. {skill:762} one at full speed needs Journeyman {skill:762} (level 60). Polestar cannot read your rank, so this step waits for level 60 and Journeyman {skill:762}."] = "Les {spell:1299382} viennent des champs de bataille, des quêtes JcJ et des tâches hebdomadaires de la saison, avec un plafond hebdomadaire ; Commandant (rang 11) débloque les montures de guerre noires. L'onglet Joueur contre Joueur de votre fiche de personnage montre votre rang et ce que vous pouvez acheter. Pour monter à pleine vitesse, la {skill:762} ne suffit pas : il faut la {skill:762} (compagnon) (niveau 60). Polestar ne peut pas lire votre rang, cette étape attend donc le niveau 60 et la {skill:762} (compagnon).",

	-- Step 2: Lieutenant Karter
	-- {npc:12783} Lieutenant Karter · {zone:1453} Stormwind · {object:2100} Old Town · {area:2918} Champions' Hall
	["{npc:12783} sells the mounts in {zone:1453}'s {object:2100} by the {area:2918}, beside the other honor quartermasters. The Forever client lists each at 100g. Each one also needs its kind's riding: Humans ride the steed, Night Elves the tiger, Gnomes the battlestrider, Dwarves the ram. A Skyborne, or anyone choosing another race's mount, first needs that riding from its trainer (Exalted with the race's city)."] = "{npc:12783} vend les montures dans la {object:2100} de {zone:1453}, près du {area:2918}, à côté des autres intendants d'honneur. Le client Forever les affiche chacune à 100 po. Chacune demande aussi la monte de son espèce : les Humains montent le destrier, les Elfes de la nuit le tigre, les Gnomes le trotteur de bataille, les Nains le bélier. Un Éolide, ou quiconque choisit la monture d'une autre race, doit d'abord apprendre cette monte auprès de son maître (Exalté auprès de la ville de cette race).",
	-- {npc:14332} Black War Steed · {spell:824} Horse Riding
	["{npc:14332}, {spell:824}, 100g"] = "{npc:14332}, {spell:824}, 100 po",
	-- {spell:22723} Black War Tiger · {spell:828} Tiger Riding
	["{spell:22723}, {spell:828}, 100g"] = "{spell:22723}, {spell:828}, 100 po",
	-- {item:18243} Black Battlestrider · {spell:10907} Mechanostrider Piloting
	["{item:18243}, {spell:10907}, 100g"] = "{item:18243}, {spell:10907}, 100 po",
	-- {item:18244} Black War Ram · {spell:826} Ram Riding
	["{item:18244}, {spell:826}, 100g"] = "{item:18244}, {spell:826}, 100 po",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["100g"] = "100 po",
	-- ["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Les rangs JcJ de Forever viennent des {spell:1299382} gagnés en champs de bataille et en JcJ sauvage, avec un plafond hebdomadaire ; Commandant (rang 11) débloque les montures de guerre noires. Polestar ne peut pas lire votre rang : cette étape attend donc le niveau 40 et la compétence de monte.",
	-- ["{npc:12783} sells the mounts in the {area:2918} in {zone:1453}'s {object:2100}, beside the other honor quartermasters such as {npc:12805}. The Forever client lists each at 100g; choose one."] = "{npc:12783} vend les montures dans le {area:2918}, dans la {object:2100} de {zone:1453}, à côté des autres intendants d'honneur comme {npc:12805}. Le client Forever les affiche à 100 po chacune ; choisissez-en une.",
}
