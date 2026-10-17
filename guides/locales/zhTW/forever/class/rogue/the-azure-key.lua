-- Chinese (traditional) (zhTW): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "50級時取得拉文霍德聲望和經驗值；Forever移除了經典版的物品選擇。",
	["Ravenholdt reputation"] = "拉文霍德聲望",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233}（聯盟）",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "50級時，{zone:1453}{object:2100}的{npc:918}提供此任務；{zone:1457}的塞尤娜，以及{zone:1455}的{npc:5165}和芬斯維克也有。",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233}（部落）",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "50級時，{object:172960}的{npc:3328}提供此任務；{zone:1458}{object:36073}的{npc:4583}也有。",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {zone:1416} Alterac Mountains · {area:271} Southshore
	["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486}隱藏在{area:272}東邊的山丘中，沿小路往上進入{zone:1416}。部落飛往{area:272}，聯盟飛往{area:271}。",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "聯盟飛往{area:3137}，部落飛往{area:1237}。{zone:1447}北部丘陵的木喉薩滿會掉落袋子，機率約三十分之一。",

	-- Step 6: Encoded Fragments
	-- {zone:1447} Azshara
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["The Forest Oozes of southern {zone:1447} drop the fragments."] = "{zone:1447}南部的森林軟泥怪會掉落碎片。",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "返回大法師克希雷姆",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}的摩弗拉斯",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep
	["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "綠色幼龍摩弗拉斯是{area:1417}（50級地城）深處的精英首領：找五人小隊一起去。神廟位於{area:74}；游下去到入口。部落：飛往{area:75}；聯盟：飛往{area:1438}再騎過去。",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}：神廟內的摩弗拉斯",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "拉文霍德領主",
	-- {npc:6768} Lord Jorach Ravenholdt
	["{npc:6768}: no item choices in Forever"] = "{npc:6768}：Forever中沒有物品選擇",
}
