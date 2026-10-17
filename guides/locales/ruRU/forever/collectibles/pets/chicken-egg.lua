-- Russian (ruRU): the guide forever/collectibles/pets/chicken-egg (forever/collectibles/pets/chicken-egg.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: CLUCK!
	-- {npc:233} Farmer Saldean · {quest:3861} CLUCK! · {item:11109} Special Chicken Feed · {item:11110} Chicken Egg
	["Find a chicken at {npc:233}'s farm and type /chicken at it until it offers {quest:3861}. Buy {item:11109} from {npc:233}, go back, /cheer at the same chicken, then hand in the feed. The chicken lays an egg: loot it for your {item:11110} pet."] = "Найдите курицу на ферме (хозяин: {npc:233}) и вводите /chicken, выбрав ее целью, пока она не предложит задание {quest:3861}. Купите {item:11109} у NPC {npc:233}, вернитесь, введите /cheer для той же курицы и сдайте корм. Курица снесет яйцо: заберите его – это ваш питомец {item:11110}.",
	-- {item:11109} Special Chicken Feed · {npc:233} Farmer Saldean
	["{item:11109}, from {npc:233}"] = "{item:11109}: продает {npc:233}",
	-- {object:161513} Farm Chicken Egg
	["Loot the {object:161513} the chicken lays"] = "Заберите {object:161513}, которое снесет курица",
}
