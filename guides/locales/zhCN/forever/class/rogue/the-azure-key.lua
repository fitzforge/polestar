-- Chinese (simplified) (zhCN): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Classic's item choice may be gone on Forever."] = "50级的拉文霍德声望和经验；Forever 可能已移除经典版的物品选择。",
	["Ravenholdt reputation"] = "拉文霍德声望",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233}（联盟）",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} in {zone:1455}."] = "",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233}（部落）",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "50级时，{object:172960}的{npc:3328}提供此任务；{zone:1458}{object:36073}的{npc:4583}也提供。",

	-- Step 3: Lord Jorach Ravenholdt
	-- {object:1772} Tarren Mill (no name in this language: may be words) · {object:1776} Durnholde Keep (no name in this language: may be words) · {zone:1416} Alterac Mountains
	["Ravenholdt Manor hides in the hills east of {object:1772}. Horde fly to {object:1772}, Alliance to Southshore. The trail starts behind the plateau north of {object:1776}, climbs into the hills and runs through a small tunnel into the {zone:1416}; Lord Jorach is inside the manor. Do not attack anyone at the manor: lost Ravenholdt reputation makes him refuse to speak to you."] = "",

	-- Step 4: Sealed Azure Bag
	-- {zone:1447} Azshara
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to Talrendis Point, Horde to Valormok. Only the level 50-51 Timbermaw Shamans in the furbolg hills of northern {zone:1447} carry the bag (the level 47-49 furbolgs further south do not): about one kill in thirty drops it. Pick Pocket them instead and you lose no Timbermaw reputation; if you are Unfriendly or better with Timbermaw Hold, mark them At War in your reputation panel first. They cast Lightning Bolt and Lightning Cloud, heal each other and run at low health."] = "",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, camped below the cliffs just east of Valormok, teleports you up (dismount first); a trail leads to Xylem's tower."] = "",

	-- Step 6: Encoded Fragments
	-- {zone:1447} Azshara
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze · Mistwing Ravagers = {npc:8764} Mistwing Ravager
	["The Forest Oozes (level 52-53, Diseased Slime up close) drop a fragment four times in five: the biggest group, seven of them, is in the Bitter Reaches hills of north-eastern {zone:1447}, four more south-east of Valormok. Pick their pockets before the kill for an extra fragment or two. Killing the Mistwing Ravagers and hippogryphs that share their spots makes more oozes appear."] = "",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "回到克希雷姆处",

	-- Step 8: Morphaz in the Sunken Temple
	["Morphaz in the Sunken Temple"] = "",
	-- {npc:5710} Jammal'an the Prophet
	["Morphaz, a level 52 elite green drake, lives deep in the Sunken Temple: a group of five, level 50-54. The temple stands in the Pool of Tears; climb into the sunken building, swim down through it and follow the passage to the portal. Horde: fly to Stonard; Alliance: fly to Nethergarde Keep and ride on. He is not there when you arrive: first kill the six troll guardians (elites of 50-52) on the platforms around the upper ring, which opens the way down (the left-hand ramp from the entrance) to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe; when both are dead, Morphaz and Hazzas appear together and fight as a pair. Their Acid Breath is nature damage: nature protection potions help; poisons and Blind do not work on them. The key always drops. Hunters, Priests and Mages of 50 need Morphaz too: one clear serves them all."] = "",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}：神庙内的摩弗拉斯",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "拉文霍德公爵",
	-- {item:19982} Duskbat Drape · {item:19984} Ebon Mask · {item:20255} Whisperwalk Boots
	["Look at the reward window before you hand in: Classic offered the {item:19982}, the {item:19984} or the {item:20255}, and Forever's notes say the choice may be gone."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "联盟飞往{area:3137}，部落飞往{area:1237}。{zone:1447}北部山丘的木喉萨满祭司掉落袋子，约三十分之一。",
	-- ["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "50级时，{zone:1453}{object:2100}的{npc:918}提供此任务；{zone:1457}的塞尤娜以及{zone:1455}的{npc:5165}和芬斯维克也提供。",
	-- ["Morphaz in the {area:1417}"] = "{area:1417}中的摩弗拉斯",
	-- ["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "摩弗拉斯是一条绿色幼龙，是50级地下城{area:1417}深处的精英首领：组一支五人小队。神庙位于{area:74}；向下游到入口。部落：飞往{area:75}；联盟：飞往{area:1438}后继续骑行。",
	-- ["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "50级的拉文霍德声望和经验；Forever 移除了经典版的物品选择。",
	-- ["The Forest Oozes of southern {zone:1447} drop the fragments."] = "{zone:1447}南部的森林软泥怪掉落碎片。",
	-- ["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486}隐藏在{area:272}东边的山丘中，沿小路进入{zone:1416}。部落飞往{area:272}，联盟飞往{area:271}。",
	-- ["{npc:6768}: no item choices in Forever"] = "{npc:6768}：Forever 中没有物品选择",
}
