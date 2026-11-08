-- French (frFR): the guide forever/collectibles/pets/black-tabby (forever/collectibles/pets/black-tabby.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Dalaran mages
	-- {area:279} Dalaran
	["{area:279} mages"] = "Mages de {area:279}",
	-- {npc:1920} Dalaran Spellscribe · {area:233} Ambermill · {zone:1421} Silverpine Forest · {npc:7383} Black Tabby · {area:279} Dalaran · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills
	-- plural, as words: Dalaran Shield Guards = {npc:2271} Dalaran Shield Guard
	["The {npc:1920}, a rare level 21 mage at {area:233} in southern {zone:1421}, drops the {npc:7383} about once in 6 kills. It has a single spot and can take hours to come back, so check it whenever you pass. While it is down, the Dalaran Shield Guards, Theurgists and Summoners (level 31-35) at the {area:279} crater, where {zone:1416} meet {zone:1424}, drop it too, but only about once in 500 kills. The cat can be traded: look at the Auction House as well."] = "Le {npc:1920}, un mage rare de niveau 21 à {area:233}, dans le sud de la {zone:1421}, lâche le {npc:7383} environ une fois sur 6. Il n'a qu'un seul point d'apparition et peut mettre des heures à revenir : vérifiez-le chaque fois que vous passez. Tant qu'il est mort, les Défenseurs de Dalaran, les Théurges et les Invocateurs (niveau 31-35) du cratère de {area:279}, là où les {zone:1416} rejoignent les {zone:1424}, le lâchent aussi, mais seulement environ une fois sur 500. Le chat peut être échangé : regardez aussi à l'hôtel des ventes.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {npc:1920}, a rare spawn among the mages at {area:233} in southern {zone:1421}, drops it about 17% of the time in our data; the other {area:279} mages at {area:233} and around the {area:279} crater drop it at about 0.2%. Kill the mages until the Spellscribe appears. Alliance players buy it on the Auction House."] = "Le {npc:1920}, un monstre rare parmi les mages d'{area:233} au sud de {zone:1421}, le lâche environ 17 % du temps selon nos données ; les autres mages de {area:279} à {area:233} et autour du cratère de {area:279} le lâchent à environ 0,2 %. Tuez les mages jusqu'à ce que le Copiste apparaisse. Les joueurs de l'Alliance l'achètent à l'hôtel des ventes.",
}
