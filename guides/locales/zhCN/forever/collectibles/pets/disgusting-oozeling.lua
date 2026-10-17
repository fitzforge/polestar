-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/disgusting-oozeling (forever/collectibles/pets/disgusting-oozeling.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Oozing Bag
	-- {item:20768} Oozing Bag · {zone:1448} Felwood · {zone:1449} Un'Goro Crater · {zone:1423} Eastern Plaguelands · {npc:1806} Vile Slime · {zone:1422} Western Plaguelands
	-- plural, as words: Vile Slimes = {npc:1806} Vile Slime · Large Vile Slimes = {npc:12387} Large Vile Slime · Devouring Oozes = {npc:1808} Devouring Ooze
	["Oozes drop the {item:20768}: the Vile Slimes, Large Vile Slimes and Devouring Oozes of Western Plaguelands, and the oozes of {zone:1448}, {zone:1449} and {zone:1423}, at about 0.07-0.09% per kill in our data. The waypoint is a {npc:1806} spawn in eastern {zone:1422}."] = "软泥怪会掉落{item:20768}：西瘟疫之地的可憎的软泥怪、{npc:12387}和{npc:1808}，以及{zone:1448}、{zone:1449}和{zone:1423}的软泥怪，我们的数据显示每次击杀约0.07-0.09%。路径点是{zone:1422}东部的一个{npc:1806}刷新点。",
	-- {zone:1422} Western Plaguelands
	-- plural, as words: Vile Slimes = {npc:1806} Vile Slime
	["Vile Slimes, {zone:1422}"] = "{npc:1806}，{zone:1422}",

	-- Step 2: Open the Oozing Bag
	-- {item:20768} Oozing Bag
	["Open the {item:20768}"] = "打开{item:20768}",
	-- {item:20768} Oozing Bag
	["Open the {item:20768} from your bags."] = "从背包中打开{item:20768}。",
}
