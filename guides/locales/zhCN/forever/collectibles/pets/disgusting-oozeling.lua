-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/disgusting-oozeling (forever/collectibles/pets/disgusting-oozeling.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Oozes
	["Oozes"] = "软泥怪",
	-- {item:20768} Oozing Bag · {npc:12387} Large Vile Slime · {zone:1422} Western Plaguelands · {item:20769} Disgusting Oozeling
	-- plural, as words: Vile Slimes = {npc:1806} Vile Slime · Devouring Oozes = {npc:1808} Devouring Ooze
	["Oozes drop the {item:20768} about once in 20-30 kills; the best are the Vile Slimes, Devouring Oozes and the {npc:12387} in the ooze field of eastern {zone:1422} (level 54-57). Open every bag: most hold potions or herbs, and only about one bag in 50 holds the {item:20769}, so expect over a thousand kills. Both the bags and the pet can be traded: unopened bags on the Auction House are lottery tickets, the pet itself the sure buy."] = "软泥怪大约每击杀 20-30 只会掉落一个 {item:20768}；最佳目标是 {zone:1422} 东部软泥怪聚集地的可憎的软泥怪、吞噬淤泥怪和 {npc:12387}（54-57 级）。每个袋子都要打开：大多数装的是药水或草药，只有约五十分之一的袋子装有 {item:20769}，因此预计要击杀上千只。袋子和宠物都可以交易：拍卖行未打开的袋子如同彩票，直接买宠物才是稳妥的办法。",
	-- plural, as words: Oozing Bags = {item:20768} Oozing Bag
	["Open your Oozing Bags"] = "打开你的沾满淤泥的袋子",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Oozes drop the {item:20768}: the Vile Slimes, Large Vile Slimes and Devouring Oozes of Western Plaguelands, and the oozes of {zone:1448}, {zone:1449} and {zone:1423}, at about 0.07-0.09% per kill in our data. The waypoint is a {npc:1806} spawn in eastern {zone:1422}."] = "软泥怪会掉落{item:20768}：西瘟疫之地的可憎的软泥怪、{npc:12387}和{npc:1808}，以及{zone:1448}、{zone:1449}和{zone:1423}的软泥怪，我们的数据显示每次击杀约0.07-0.09%。路径点是{zone:1422}东部的一个{npc:1806}刷新点。",
	-- ["Open the {item:20768}"] = "打开{item:20768}",
	-- ["Open the {item:20768} from your bags."] = "从背包中打开{item:20768}。",
	-- ["Vile Slimes, {zone:1422}"] = "{npc:1806}，{zone:1422}",
}
