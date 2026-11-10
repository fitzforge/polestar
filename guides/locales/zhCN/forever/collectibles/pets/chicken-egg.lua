-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/chicken-egg (forever/collectibles/pets/chicken-egg.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Special Chicken Feed
	-- {item:11109} Special Chicken Feed · {npc:233} Farmer Saldean
	["Buy one {item:11109} (25 copper) from {npc:233} at his farm first: it is not a quest item, and the chicken stays friendly only for a short while."] = "先在{npc:233}的农场向他买一个{item:11109}（25铜）：它不是任务物品，而且小鸡只会短暂保持友好。",

	-- Step 2: CLUCK!
	-- {quest:3861} CLUCK! · {item:11110} Chicken Egg
	["Target one of the chickens around Saldean's farm and type /chicken at it, again and again, until it offers {quest:3861}; this can take several minutes. Then /cheer at a chicken until it turns friendly (green) and hand in the feed; right-clicking a chicken before it is friendly attacks it. The chicken lays an egg on the ground: loot it for your {item:11110}."] = "选中萨丁农场周围的一只鸡，反复对它输入 /chicken，直到它提供 {quest:3861}；这可能要花几分钟。然后对一只鸡使用 /cheer，直到它变为友善（绿色），再交还饲料；鸡还未变为友善时，右键点击会攻击它。鸡会在地上下一枚蛋：拾取即可获得你的 {item:11110}。",
	-- {object:161513} Farm Chicken Egg
	["Loot the {object:161513} the chicken lays"] = "拾取小鸡下的{object:161513}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Find a chicken at {npc:233}'s farm and type /chicken at it until it offers {quest:3861}. Buy {item:11109} from {npc:233}, go back, /cheer at the same chicken, then hand in the feed. The chicken lays an egg: loot it for your {item:11110} pet."] = "在{npc:233}的农场找一只小鸡，对它输入/chicken，直到它提供{quest:3861}。向{npc:233}购买{item:11109}，回来对同一只小鸡输入/cheer，然后交上饲料。小鸡会下一个蛋：拾取它获得{item:11110}宠物。",
	-- ["{item:11109}, from {npc:233}"] = "{item:11109}，来自{npc:233}",
}
