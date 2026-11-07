-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/chicken-egg (forever/collectibles/pets/chicken-egg.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Special Chicken Feed
	-- {item:11109} Special Chicken Feed · {npc:233} Farmer Saldean
	["Buy one {item:11109} (25 copper) from {npc:233} at his farm first: it is not a quest item, and the chicken stays friendly only for a short while."] = "Compre antes uma {item:11109} (25 cobres) de {npc:233} na fazenda dele: não é item de missão, e a galinha só fica amigável por pouco tempo.",

	-- Step 2: CLUCK!
	-- {quest:3861} CLUCK! · {item:11110} Chicken Egg
	["Target one of the chickens around Saldean's farm and type /chicken at it, again and again, until it offers {quest:3861}; this can take several minutes. Then /cheer at a chicken until it turns friendly (green) and hand in the feed; right-clicking a chicken before it is friendly attacks it. The chicken lays an egg on the ground: loot it for your {item:11110}."] = "Selecione uma das galinhas em volta da fazenda de Saldean e digite /chicken nela, várias vezes, até ela oferecer {quest:3861}; isso pode levar vários minutos. Depois use /cheer numa galinha até ela ficar amigável (verde) e entregue a ração; clicar com o botão direito numa galinha antes de ela ficar amigável a ataca. A galinha põe um ovo no chão: saqueie para pegar {item:11110}.",
	-- {object:161513} Farm Chicken Egg
	["Loot the {object:161513} the chicken lays"] = "Saqueie o {object:161513} que a galinha botar",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Find a chicken at {npc:233}'s farm and type /chicken at it until it offers {quest:3861}. Buy {item:11109} from {npc:233}, go back, /cheer at the same chicken, then hand in the feed. The chicken lays an egg: loot it for your {item:11110} pet."] = "Encontre uma galinha na fazenda de {npc:233} e digite /chicken para ela até que ofereça {quest:3861}. Compre {item:11109} de {npc:233}, volte, use /cheer na mesma galinha e entregue a ração. A galinha bota um ovo: saqueie-o para obter seu mascote {item:11110}.",
	-- ["{item:11109}, from {npc:233}"] = "{item:11109}, de {npc:233}",
}
