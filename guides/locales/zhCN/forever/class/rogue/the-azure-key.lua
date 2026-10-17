-- Chinese (simplified) (zhCN): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "50级的拉文霍德声望和经验；Forever 移除了经典版的物品选择。",
	["Ravenholdt reputation"] = "拉文霍德声望",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233}（联盟）",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "50级时，{zone:1453}{object:2100}的{npc:918}提供此任务；{zone:1457}的塞尤娜以及{zone:1455}的{npc:5165}和芬斯维克也提供。",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233}（部落）",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "50级时，{object:172960}的{npc:3328}提供此任务；{zone:1458}{object:36073}的{npc:4583}也提供。",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {zone:1416} Alterac Mountains · {area:271} Southshore
	["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486}隐藏在{area:272}东边的山丘中，沿小路进入{zone:1416}。部落飞往{area:272}，联盟飞往{area:271}。",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "联盟飞往{area:3137}，部落飞往{area:1237}。{zone:1447}北部山丘的木喉萨满祭司掉落袋子，约三十分之一。",

	-- Step 6: Encoded Fragments
	-- {zone:1447} Azshara
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["The Forest Oozes of southern {zone:1447} drop the fragments."] = "{zone:1447}南部的森林软泥怪掉落碎片。",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "回到克希雷姆处",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}中的摩弗拉斯",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep
	["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "摩弗拉斯是一条绿色幼龙，是50级地下城{area:1417}深处的精英首领：组一支五人小队。神庙位于{area:74}；向下游到入口。部落：飞往{area:75}；联盟：飞往{area:1438}后继续骑行。",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}：神庙内的摩弗拉斯",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "拉文霍德公爵",
	-- {npc:6768} Lord Jorach Ravenholdt
	["{npc:6768}: no item choices in Forever"] = "{npc:6768}：Forever 中没有物品选择",
}
