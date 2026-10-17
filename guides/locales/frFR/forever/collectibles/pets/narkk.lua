-- French (frFR): the guide forever/collectibles/pets/narkk (forever/collectibles/pets/narkk.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:2663} Narkk
	["{npc:2663}'s Parrots"] = "Perroquets de {npc:2663}",

	-- Step 1: Narkk
	-- {npc:2663} Narkk · {area:35} Booty Bay · {area:392} Ratchet
	["{npc:2663}, the pirate supplier in {area:35}, sells two parrots (40s each). {area:35} is neutral: the boat from {area:392} and the Stranglethorn road both arrive there. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:2663}, le fournisseur des pirates à {area:35}, vend deux perroquets (40 pa chacun). {area:35} est neutre : le bateau de {area:392} et la route de Strangleronce y mènent. Chaque objet de mascotte apprend sa mascotte quand vous l'utilisez ; les objectifs restent cochés ensuite.",
	-- {item:8495} Parrot Cage (Senegal)
	["{item:8495}, 40s"] = "{item:8495}, 40 pa",
	-- {item:8496} Parrot Cage (Cockatiel)
	["{item:8496}, 40s"] = "{item:8496}, 40 pa",
}
