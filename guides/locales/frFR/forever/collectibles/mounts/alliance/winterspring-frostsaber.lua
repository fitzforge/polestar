-- French (frFR): the guide forever/collectibles/mounts/alliance/winterspring-frostsaber (forever/collectibles/mounts/alliance/winterspring-frostsaber.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wintersaber Trainers
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring · {faction:589} Wintersaber Trainers
	["{npc:10618} stands on top of {area:2241} in the far north of {zone:1452}. Only the Alliance can earn the {faction:589}' favour, from level 58: three repeatable quests worth 50 each, about 840 turn-ins from Neutral to Exalted. Frostsaber Provisions is open from the start, Winterfall Intrusion from halfway through Neutral and Rampaging Giants from Honored. The Wintersaber Trainers Reputation guide takes you through it."] = "{npc:10618} se tient au sommet du {area:2241}, à l'extrême nord du {zone:1452}. Seule l'Alliance peut gagner la faveur des {faction:589}, dès le niveau 58 : trois quêtes répétables à 50 points chacune, environ 840 quêtes rendues de Neutre à Exalté. Provisions pour sabres-de-givre est ouverte dès le début, Intrusion des Grumegueules à partir de la moitié de Neutre et Géants déchaînés à partir d'Honoré. Le guide de réputation des Éleveurs de sabres-d'hiver vous accompagne.",

	-- Step 2: Reins of the Winterspring Frostsaber
	-- {faction:589} Wintersaber Trainers
	["The Forever client lists it at 200g and level 60. It runs at full speed yet needs no riding training at all, only Honored with the {faction:589}, so you can skip the 1,000g Journeyman Riding if this is your fast mount."] = "Le client Forever l'affiche à 200 po et au niveau 60. Elle va à pleine vitesse mais ne demande aucun apprentissage de monte, seulement Honoré auprès des {faction:589} : vous pouvez donc vous passer de la monte compagnon à 1 000 po si c'est votre monture rapide.",
	-- {npc:10618} Rivern Frostwind
	["{npc:10618}, 200g"] = "{npc:10618}, 200 po",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Le client Forever l'affiche à 200 po au niveau 60, sans rang de monte requis.",
	-- ["{npc:10618} at {area:2241} in northern {zone:1452} offers the repeatable Frostsaber Provisions, Winterfall Intrusion and Rampaging Giants (level 58); they are the whole road to Exalted, so expect weeks of turn-ins."] = "{npc:10618}, au {area:2241} au nord du {zone:1452}, propose les quêtes répétables « Provisions de sabres-de-givre », « L'incursion des Tombe-hiver » et « Géants déchaînés » (niveau 58) ; elles sont la seule voie vers Exalté : comptez des semaines de remises.",
	-- ["{zone:1452} Frostsaber"] = "Sabre-de-givre de {zone:1452}",
}
