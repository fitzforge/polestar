-- Spanish (Spain) (esES): the guide forever/collectibles/pets/spectral-bear-cub (forever/collectibles/pets/spectral-bear-cub.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Innkeeper Wiley in Ratchet
	-- {npc:6791} Innkeeper Wiley · {area:392} Ratchet
	["{npc:6791} in {area:392}"] = "",
	-- {item:281060} Replica Ironforge Air Rifle · {item:277714} Spectral Bear Cub · {item:277717} Spectral Bear Tabard · {item:277718} Reins of the Spectral Bear · {npc:6791} Innkeeper Wiley · {area:392} Ratchet · {zone:1413} Barrens · {area:35} Booty Bay · {quest:96383} Legacy Reward: Spectral Bear Cub
	["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, a crafting profession at 150, 225 and 300, PvP ranks and battleground reputations, exploring, dungeons and raids) is worth one, and the track counts points earned, not spent. It gives the {item:281060} at 15, the {item:277714} at 25, the {item:277717} at 40 and the {item:277718} at 55. The rewards are claimed as quests from {npc:6791} in the inn at {area:392}, the goblin port on the {zone:1413} coast (Alliance players come by the boat from {area:35}): with 25 points he offers {quest:96383}; hand it straight back for the cub."] = "",
	["Without PvP one character can earn 17 points: its class at 25, 45 and 60, two professions to 300, the two adventure challenges, the three dungeon tiers and the three raids. A second class or more professions on an alt make up the rest; the Legacy Challenges guide plans them."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["25 Legacy Points"] = "25 puntos de Legado",
	-- ["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, professions, PvP, exploring) is worth one. The Progress Track gives the {item:281060} at 15, the {item:277714} at 25, the {item:277717} at 40 and the {item:277718} at 55. How rewards are delivered is not known yet (perhaps by mail); this goal ticks once the cub is in your bags."] = "Los puntos de Legado son de toda la cuenta: cada desafío de Legado (una clase que llega a 25, 45 y 60, profesiones, JcJ, exploración) vale uno. El registro de progreso da {item:281060} con 15, {item:277714} con 25, {item:277717} con 40 y {item:277718} con 55. Aún no se sabe cómo se entregan las recompensas (quizá por correo); este objetivo se marca cuando tengas el cachorro en las bolsas.",
}
