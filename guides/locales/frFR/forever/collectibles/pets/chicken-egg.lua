-- French (frFR): the guide forever/collectibles/pets/chicken-egg (forever/collectibles/pets/chicken-egg.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Special Chicken Feed
	-- {item:11109} Special Chicken Feed · {npc:233} Farmer Saldean
	["Buy one {item:11109} (25 copper) from {npc:233} at his farm first: it is not a quest item, and the chicken stays friendly only for a short while."] = "Achetez d'abord un {item:11109} (25 pièces de cuivre) à {npc:233}, dans sa ferme : ce n'est pas un objet de quête, et le poulet ne reste amical que peu de temps.",

	-- Step 2: CLUCK!
	-- {quest:3861} CLUCK! · {item:11110} Chicken Egg
	["Target one of the chickens around Saldean's farm and type /chicken at it, again and again, until it offers {quest:3861}; this can take several minutes. Then /cheer at a chicken until it turns friendly (green) and hand in the feed; right-clicking a chicken before it is friendly attacks it. The chicken lays an egg on the ground: loot it for your {item:11110}."] = "Ciblez l'un des poulets autour de la ferme de Saldean et tapez /poulet sur lui, encore et encore, jusqu'à ce qu'il propose {quest:3861} ; cela peut prendre plusieurs minutes. Puis faites /acclamer sur un poulet jusqu'à ce qu'il devienne amical (vert) et rendez-lui la nourriture ; un clic droit sur un poulet avant qu'il soit amical l'attaque. Le poulet pond un œuf au sol : ramassez-le pour obtenir votre {item:11110}.",
	-- {object:161513} Farm Chicken Egg
	["Loot the {object:161513} the chicken lays"] = "Ramassez l'{object:161513} pondu par la poule",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Find a chicken at {npc:233}'s farm and type /chicken at it until it offers {quest:3861}. Buy {item:11109} from {npc:233}, go back, /cheer at the same chicken, then hand in the feed. The chicken lays an egg: loot it for your {item:11110} pet."] = "Trouvez une poule à la ferme de {npc:233} et tapez /chicken en la ciblant jusqu'à ce qu'elle propose {quest:3861}. Achetez {item:11109} à {npc:233}, revenez, faites /cheer à la même poule, puis rendez le grain. La poule pond un œuf : ramassez-le pour obtenir votre mascotte {item:11110}.",
	-- ["{item:11109}, from {npc:233}"] = "{item:11109}, auprès de {npc:233}",
}
