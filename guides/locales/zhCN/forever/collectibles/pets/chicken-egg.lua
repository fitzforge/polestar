-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/chicken-egg (forever/collectibles/pets/chicken-egg.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: CLUCK!
	-- {npc:233} Farmer Saldean · {quest:3861} CLUCK! · {item:11109} Special Chicken Feed · {item:11110} Chicken Egg
	["Find a chicken at {npc:233}'s farm and type /chicken at it until it offers {quest:3861}. Buy {item:11109} from {npc:233}, go back, /cheer at the same chicken, then hand in the feed. The chicken lays an egg: loot it for your {item:11110} pet."] = "在{npc:233}的农场找一只小鸡，对它输入/chicken，直到它提供{quest:3861}。向{npc:233}购买{item:11109}，回来对同一只小鸡输入/cheer，然后交上饲料。小鸡会下一个蛋：拾取它获得{item:11110}宠物。",
	-- {item:11109} Special Chicken Feed · {npc:233} Farmer Saldean
	["{item:11109}, from {npc:233}"] = "{item:11109}，来自{npc:233}",
	-- {object:161513} Farm Chicken Egg
	["Loot the {object:161513} the chicken lays"] = "拾取小鸡下的{object:161513}",
}
