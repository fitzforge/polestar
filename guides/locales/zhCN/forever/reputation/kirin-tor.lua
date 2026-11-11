-- Chinese (simplified) (zhCN): the guide forever/reputation/kirin-tor (forever/reputation/kirin-tor.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Kirin Tor Reputation"] = "肯瑞托声望",
	-- {area:279} Dalaran
	["New in Forever: {area:279}'s mages sell Azure armour recipes at Friendly and their tabard at Exalted."] = "无限新增：{area:279}的法师在友善时出售蔚蓝护甲配方，在崇拜时出售其战袍。",
	-- {skill:164} Blacksmithing · {skill:165} Leatherworking · {skill:197} Tailoring
	["Eight Azure helm and shoulder recipes at Friendly ({skill:164}, {skill:165}, {skill:197})"] = "友善时可购八种蔚蓝头盔和护肩配方（{skill:164}、{skill:165}、{skill:197}）",

	-- Step 1: Skyborne: the recipes now
	["Skyborne: the recipes now"] = "天裔：现在领取配方",
	-- {faction:2740} Kirin Tor · {npc:32287} Archmage Alvareaux · {area:279} Dalaran
	["Alliance Skyborne start Friendly with the {faction:2740}, and their arrival quests The Magical City of Dalaran and Exploring the Alliance pay 100 more each, so {npc:32287} sells you the Azure recipes at once (10g each, they need skill 175). He stands upstairs in the building with the {faction:2740} banners in {area:279}, past the Sky Enclave. Buy the ones for your profession."] = "联盟天裔起始对 {faction:2740} 为友善，到达后的 魔法之城达拉然 和 联盟之旅 任务又各奖励100点，因此可以立即向 {npc:32287} 购买碧蓝圣殿骑士配方（每张10金币，需要技能175）。他在 {area:279} 经过苍穹领地后那栋挂着 {faction:2740} 旗帜的建筑楼上。购买你专业对应的配方。",

	-- Step 2: An Alarming Request
	-- {npc:247264} Emissary Jacques · {faction:2740} Kirin Tor · {area:271} Southshore · {npc:246748} Archmage Modera · {area:1338} Lordamere Lake · {area:279} Dalaran
	["{npc:247264} of the {faction:2740} waits in {area:271}. He sends you to {npc:246748}'s image by the shore of {area:1338}, outside {area:279}'s walls. The {faction:2740} quests start at level 24 to 30 and pay full reputation at any level in Forever."] = "",

	-- Step 3: Archmage Modera's image
	-- {npc:246748} Archmage Modera
	["{npc:246748}'s image"] = "{npc:246748} 的影像",
	-- {item:277507} Dalaran Sewer Key
	["you get the {item:277507} with it"] = "还会一并获得 {item:277507}",

	-- Step 4: The City of Dalaran
	["The City of Dalaran"] = "达拉然城",
	-- {quest:92457} Starving Arcane · {npc:246020} Shade of the Archmage · {npc:246748} Archmage Modera · {item:251961} Arcane Mote · {faction:2740} Kirin Tor
	["The City of Dalaran is a dungeon for levels 28 to 33: go in through the sewers with the key Modera gave you. The arcane elementals throughout the city count for {quest:92457}. The {npc:246020}, the last boss, waits in the Purple Parlor above the Violet Citadel (a portal by {npc:246748} in the Citadel takes you up) and drops the {item:251961}. Beta players saw every kill in the dungeon pay {faction:2740} reputation, the bosses the most. Group of five advised below level 35."] = "达拉然城是 28 至 33 级地下城：用茉德拉给你的钥匙，从下水道进入。城内各处的奥术元素都计入 {quest:92457}。最终首领 {npc:246020} 在紫罗兰城堡上方的紫色天台等待（城堡内 {npc:246748} 旁的传送门可将你送上去），会掉落 {item:251961}。测试版玩家发现，地下城内每次击杀都能获得 {faction:2740} 声望，首领给得最多。35 级以下建议五人组队。",
	-- {item:251961} Arcane Mote · {npc:246020} Shade of the Archmage
	["{item:251961}, from the {npc:246020}"] = "{item:251961}，来自{npc:246020}",

	-- Step 5: Back to Modera's image
	["Back to Modera's image"] = "返回大法师茉德拉的影像的影像处",

	-- Step 6: Archmage Celindra
	-- {npc:252085} Archmage Celindra · {area:279} Dalaran
	["{npc:252085} waits in the Violet Citadel in {area:279}."] = "{npc:252085} 在 {area:279} 的紫罗兰城堡中等待。",

	-- Step 7: Past Due
	-- {npc:264265} Magus Olvek · {area:279} Dalaran · {npc:6487} Arcanist Doan · {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades
	["{npc:264265} in {area:279} wants a book back from {npc:6487}, the last boss of the {area:796}'s Library (levels 33 to 41), in {zone:1420}."] = "{area:279} 的 {npc:264265} 要你从 {npc:6487} 处取回一本书，他是 {zone:1420} 的 {area:796} 图书馆区的最终首领（33到41级）。",

	-- Step 8: Arcanist Doan
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades
	["The {area:796} stands in the north-east of {zone:1420}; Doan waits at the end of the Library wing. Group of five advised below level 40."] = "{area:796} 位于 {zone:1420} 东北；杜安在图书馆区的尽头等候。低于 40 级建议五人组队。",
	-- {item:273169} The Lost Magic of the Runemasters · {npc:6487} Arcanist Doan
	["{item:273169}, from {npc:6487}"] = "{item:273169}，由{npc:6487}掉落",

	-- Step 9: Back to Magus Olvek
	-- {npc:264265} Magus Olvek
	["Back to {npc:264265}"] = "返回{npc:264265}处",

	-- Step 10: City of Dalaran runs to Friendly
	["City of Dalaran runs to Friendly"] = "反复打达拉然城至友善",
	["The quests leave a non-Skyborne at about 320 of the 3,000 Friendly needs. The rest comes from kills in the City of Dalaran dungeon: run it until Friendly. How much each kill pays is not in the game's data; the bosses pay the most. At 60 you clear it alone."] = "完成这些任务后，非天裔角色的声望约为320点，达到友善需要3,000点。剩下的靠击杀 达拉然城 地下城中的敌人获得：反复刷到友善。游戏数据中没有每次击杀的具体奖励；首领奖励最多。60级时可以单刷。",

	-- Step 11: Archmage Alvareaux: the Azure recipes
	-- {npc:32287} Archmage Alvareaux
	["{npc:32287}: the Azure recipes"] = "{npc:32287}：碧蓝圣殿骑士配方",
	-- {npc:32287} Archmage Alvareaux · {faction:2740} Kirin Tor · {area:279} Dalaran
	["{npc:32287} sells the Azure helm and shoulder recipes at Friendly, 10g each (skill 175). He stands upstairs in the building with the {faction:2740} banners in {area:279}. Buy the ones for your profession."] = "{npc:32287} 在友善后出售碧蓝圣殿骑士头盔和肩部配方，每张 10 金币（技能 175）。他位于 {area:279} 内、挂有 {faction:2740} 旗帜的建筑楼上。购买适合自己专业的配方。",

	-- Step 12: City of Dalaran runs to Exalted
	["City of Dalaran runs to Exalted"] = "跑达拉然城的任务至崇拜",
	["Nothing is sold at Honored or Revered in the game's data. Friendly to Exalted is 39,000 reputation, all from City of Dalaran kills. In Classic most dungeon kills stop paying at Honored or Revered; whether these do is not known yet."] = "游戏数据中没有任何物品要求尊敬或崇敬才能购买。从友善到崇拜需要39,000声望，全部来自达拉然城的击杀。在经典旧世中，多数地下城击杀会在尊敬或崇敬后停止提供声望；这里是否如此尚不清楚。",

	-- Step 13: The Kirin Tor Tabard
	-- {item:285327} Kirin Tor Tabard
	["The {item:285327}"] = "{item:285327}",
	-- {npc:32287} Archmage Alvareaux · {npc:28776} Elizabeth Ross · {area:279} Dalaran · {item:285327} Kirin Tor Tabard
	["{npc:32287} and {npc:28776}, the tabard vendor in {area:279}, sell the {item:285327} at Exalted for 25g."] = "{npc:32287}及{area:279}的战袍商人{npc:28776}会在崇拜后出售{item:285327}，售价25金币。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:247264} of the {faction:2740} waits in {area:271}. He sends you to {npc:246748}'s image by the shore of {area:1338}, outside {area:279}'s walls. The {faction:2740} quests start at level 24 to 30 and pay full reputation while they are at most 5 levels below you; in Classic a quest 6+ levels below you pays less (a fifth at 60)."] = "{faction:2740} 的 {npc:247264} 在 {area:271} 等候。他会让你去 {area:279} 城墙外、{area:1338} 岸边找 {npc:246748} 的影像。{faction:2740} 的任务起始等级为 24 至 30 级，最多比你低 5 级时仍给予完整声望；经典怀旧服中，比你低 6 级及以上的任务会减少奖励（60 级时只有五分之一）。",
}
