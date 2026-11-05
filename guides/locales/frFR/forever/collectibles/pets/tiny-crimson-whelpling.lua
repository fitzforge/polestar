-- French (frFR): the guide forever/collectibles/pets/tiny-crimson-whelpling (forever/collectibles/pets/tiny-crimson-whelpling.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wetlands whelps
	-- {zone:1437} Wetlands
	["{zone:1437} whelps"] = "Dragonnets des {zone:1437}",
	-- {zone:1437} Wetlands · {area:1037} Grim Batol
	-- plural, as words: Red Whelps = {npc:1042} Red Whelp · Crimson Whelps = {npc:1069} Crimson Whelp · Flamesnorting Whelps = {npc:1044} Flamesnorting Whelp
	["The red whelps live in the hills of the eastern {zone:1437}, towards {area:1037}: about 50 of them, back about five minutes after a kill in Classic's data. Red Whelps (levels 23-24) and Crimson Whelps (25-26) drop the whelpling about once in 650 kills, the Flamesnorting Whelps (26-27) mixed in with them only once in 1,600, so expect a long farm. It can be traded, so the Auction House may be quicker."] = "Les dragonnets rouges vivent dans les collines de l'est des {zone:1437}, vers {area:1037} : une cinquantaine, qui réapparaissent environ cinq minutes après leur mort d'après les données de Classic. Les Dragonnets rouges (niveaux 23-24) et les Dragonnets cramoisis (25-26) le lâchent environ une fois sur 650, les Dragonnets crache-flammes (26-27) mêlés à eux une fois sur 1 600 seulement : attendez-vous à chasser longtemps. Il peut s'échanger, l'hôtel des ventes peut donc être plus rapide.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Red, Crimson and Flamesnorting Whelps (levels 23-26) in the eastern {zone:1437} drop it about once in 600-1,600 kills in our data."] = "Les Dragonnets rouges, Dragonnets cramoisis et Dragonnets crache-flammes (niveaux 23-26) de l'est des {zone:1437} le laissent tomber environ une fois sur 600 à 1 600 morts selon nos données.",
}
