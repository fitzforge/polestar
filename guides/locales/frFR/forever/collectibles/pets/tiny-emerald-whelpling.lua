-- French (frFR): the guide forever/collectibles/pets/tiny-emerald-whelpling (forever/collectibles/pets/tiny-emerald-whelpling.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Dreaming Whelps
	-- plural, as words: Dreaming Whelps = {npc:741} Dreaming Whelp
	["Dreaming Whelps"] = "Dragonnets rêveurs",
	-- {zone:1435} Swamp of Sorrows · {zone:1430} Deadwind Pass
	-- plural, as words: Dreaming Whelps = {npc:741} Dreaming Whelp
	["The Dreaming Whelps (levels 35-36) live in western {zone:1435}, near the {zone:1430} border. They drop it about once in 1,250 kills, and there are only a handful, back about every five minutes, so expect days of farming; it can be traded, so the Auction House may be quicker."] = "Les Dragonnets rêveurs (niveaux 35-36) vivent dans l'ouest du {zone:1435}, près de la frontière du {zone:1430}. Ils le lâchent environ une fois sur 1 250, et ils ne sont qu'une poignée, de retour environ toutes les cinq minutes : attendez-vous à des jours de chasse ; il peut s'échanger, l'hôtel des ventes peut donc être plus rapide.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Dreaming Whelps (level 35) in western {zone:1435} drop it about once in 1,250 kills in our data."] = "Les Dragonnets rêveurs (niveau 35) de l'ouest de {zone:1435} le laissent tomber environ une fois sur 1 250 victimes selon nos données.",
}
