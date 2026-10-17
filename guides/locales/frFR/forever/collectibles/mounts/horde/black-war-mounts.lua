-- French (frFR): the guide forever/collectibles/mounts/horde/black-war-mounts (forever/collectibles/mounts/horde/black-war-mounts.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {spell:1299382} Rank Points · {spell:436438} Lieutenant General
	["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Les rangs JcJ de Forever viennent des {spell:1299382} gagnés en champs de bataille et en JcJ sauvage, avec un plafond hebdomadaire ; {spell:436438} (rang 11) débloque les montures de guerre noires. Polestar ne peut pas lire votre rang : cette étape attend donc le niveau 40 et la compétence de monte.",

	-- Step 2: Raider Bork
	-- {npc:12796} Raider Bork · {area:2917} Hall of Legends · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:12799} Sergeant Ba'sha
	["{npc:12796} sells the mounts in the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters such as {npc:12799}. The Forever client lists each at 100g; choose one."] = "{npc:12796} vend les montures dans {area:2917}, dans {object:172958} de {zone:1454}, à côté des autres intendants d'honneur comme {npc:12799}. Le client Forever les vend 100 po chacune ; choisissez-en une.",
	["100g"] = "100 po",
}
