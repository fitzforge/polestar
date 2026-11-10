-- Chinese (simplified) (zhCN): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Classic's item choice may be gone on Forever."] = "50级的拉文霍德声望和经验；无限 可能已移除经典版的物品选择。",
	["Ravenholdt reputation"] = "拉文霍德声望",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233}（联盟）",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} in {zone:1455}."] = "50级时，{zone:1453} 的 {object:2100} 中的 {npc:918} 会提供此任务；{zone:1457} 的塞尤娜和 {zone:1455} 的 {npc:5165} 也会提供。",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233}（部落）",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "50级时，{object:172960}的{npc:3328}提供此任务；{zone:1458}{object:36073}的{npc:4583}也提供。",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {area:271} Southshore · {area:275} Durnholde Keep · {zone:1416} Alterac Mountains
	["{area:3486} hides in the hills east of {area:272}. Horde fly to {area:272}, Alliance to {area:271}. The trail starts behind the plateau north of {area:275}, climbs into the hills and runs through a small tunnel into the {zone:1416}; Lord Jorach is inside the manor. Do not attack anyone at the manor: lost Ravenholdt reputation makes him refuse to speak to you."] = "{area:3486}藏在{area:272}东侧的山丘中。部落飞往{area:272}，联盟飞往{area:271}。小路从{area:275}北面高地的后方开始，爬上山丘，再穿过一条小隧道进入{zone:1416}；乔拉齐·拉文霍德公爵就在庄园内。不要攻击庄园中的任何人：失去拉文霍德声望会让他拒绝与你交谈。",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara · {spell:921} Pick Pocket · {area:1769} Timbermaw Hold · {spell:403} Lightning Bolt · {spell:6535} Lightning Cloud
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. Only the level 50-51 Timbermaw Shamans in the furbolg hills of northern {zone:1447} carry the bag (the level 47-49 furbolgs further south do not): about one kill in thirty drops it. {spell:921} them instead and you lose no Timbermaw reputation; if you are Unfriendly or better with {area:1769}, mark them At War in your reputation panel first. They cast {spell:403} and {spell:6535}, heal each other and run at low health."] = "联盟飞往{area:3137}，部落飞往{area:1237}。只有{zone:1447}北部熊怪山丘里的50-51级木喉萨满祭司携带袋子（更南面的47-49级熊怪没有）：大约每击杀30个掉落一次。改用{spell:921}偷取就不会损失木喉声望；如果你与{area:1769}的关系为冷淡或更好，先在声望面板勾选“交战”。它们会施放{spell:403}和{spell:6535}，互相治疗，并在低血量时逃跑。",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo · {area:1237} Valormok
	["{npc:8395}, camped below the cliffs just east of {area:1237}, teleports you up (dismount first); a trail leads to Xylem's tower."] = "{npc:8395} 在 {area:1237} 东侧不远的悬崖下扎营，会把你传送上去（先解除骑乘）；上方有一条小路通往大法师克希雷姆的塔。",

	-- Step 6: Encoded Fragments
	-- {spell:6907} Diseased Slime · {area:2497} Bitter Reaches · {zone:1447} Azshara · {area:1237} Valormok
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze · Mistwing Ravagers = {npc:8764} Mistwing Ravager
	["The Forest Oozes (level 52-53, {spell:6907} up close) drop a fragment four times in five: the biggest group, seven of them, is in the {area:2497} hills of north-eastern {zone:1447}, four more south-east of {area:1237}. Pick their pockets before the kill for an extra fragment or two. Killing the Mistwing Ravagers and hippogryphs that share their spots makes more oozes appear."] = "森林软泥怪（52-53 级，近身会使用 {spell:6907}）有五分之四的概率掉落碎片：数量最多的一群共七只，位于 {zone:1447} 东北部的 {area:2497} 丘陵，{area:1237} 东南方还有四只。击杀前先偷窃，可额外获得一两个碎片。击杀同一地点的雾翼掠夺者和角鹰兽，能让更多软泥怪出现。",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "回到克希雷姆处",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}中的摩弗拉斯",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep · {npc:5710} Jammal'an the Prophet · {spell:12533} Acid Breath · {spell:2094} Blind
	["Morphaz, a level 52 elite green drake, lives deep in the {area:1417}: a group of five, level 50-54. The temple stands in the {area:74}; climb into the sunken building, swim down through it and follow the passage to the portal. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on. He is not there when you arrive: first kill the six troll guardians (elites of 50-52) on the platforms around the upper ring, which opens the way down (the left-hand ramp from the entrance) to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe; when both are dead, Morphaz and Hazzas appear together and fight as a pair. Their {spell:12533} is nature damage: nature protection potions help; poisons and {spell:2094} do not work on them. The key always drops. Hunters, Priests and Mages of 50 need Morphaz too: one clear serves them all."] = "摩弗拉斯是一只52级精英绿龙，位于 {area:1417} 深处：需要50—54级的五人小队。神庙位于 {area:74}；爬进沉没的建筑，向下游穿过建筑，再沿通道走到传送门。部落：飞往 {area:75}；联盟：飞往 {area:1438} 后骑乘前进。刚抵达时他不会出现：先击杀上层环廊各平台上的六名巨魔守护者（50—52级精英），才会打开通往献祭之坑中 {npc:5710} 的下行道路（从入口左侧坡道下去）。迦玛兰死亡后会出现两条幼龙德拉维沃尔和德姆塞卡尔；两条都死后，摩弗拉斯和哈扎斯会一起出现并联手战斗。它们的 {spell:12533} 造成自然伤害：自然防护药水有帮助；毒药和 {spell:2094} 对它们无效。钥匙必定掉落。50级的猎人、牧师和法师也需要击杀摩弗拉斯：打通一次就能一起完成。",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}：神庙内的摩弗拉斯",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "拉文霍德公爵",
	-- {item:19982} Duskbat Drape · {item:19984} Ebon Mask · {item:20255} Whisperwalk Boots
	["Look at the reward window before you hand in: Classic offered the {item:19982}, the {item:19984} or the {item:20255}, and Forever's notes say the choice may be gone."] = "交还前先查看奖励窗口：经典版可选{item:19982}、{item:19984}或{item:20255}，而无限服的说明称这个选择可能已移除。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "联盟飞往{area:3137}，部落飞往{area:1237}。{zone:1447}北部山丘的木喉萨满祭司掉落袋子，约三十分之一。",
	-- ["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "50级时，{zone:1453}{object:2100}的{npc:918}提供此任务；{zone:1457}的塞尤娜以及{zone:1455}的{npc:5165}和芬斯维克也提供。",
	-- ["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "摩弗拉斯是一条绿色幼龙，是50级地下城{area:1417}深处的精英首领：组一支五人小队。神庙位于{area:74}；向下游到入口。部落：飞往{area:75}；联盟：飞往{area:1438}后继续骑行。",
	-- ["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "50级的拉文霍德声望和经验；Forever 移除了经典版的物品选择。",
	-- ["The Forest Oozes of southern {zone:1447} drop the fragments."] = "{zone:1447}南部的森林软泥怪掉落碎片。",
	-- ["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486}隐藏在{area:272}东边的山丘中，沿小路进入{zone:1416}。部落飞往{area:272}，联盟飞往{area:271}。",
	-- ["{npc:6768}: no item choices in Forever"] = "{npc:6768}：Forever 中没有物品选择",
}
