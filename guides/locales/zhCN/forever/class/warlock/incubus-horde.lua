-- Chinese (simplified) (zhCN): the guide forever/class/warlock/incubus-horde (forever/class/warlock/incubus-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Succubus and Incubus (Horde)"] = "魅魔和夜魔（部落）",
	["At 20: the succubus and Forever's incubus, its male twin, each with a soul pouch for your shards."] = "20级：魅魔和无限服的夜魔（魅魔的男性孪生版本），各附赠一个装灵魂碎片的灵魂袋。",

	-- Step 1: Devourer of Souls (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:5909} Cazul · {npc:5675} Carendin Halgar · {zone:1458} Undercity · {quest:1472} Devourer of Souls · {zone:1454} Orgrimmar
	["At 20 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:5909} a few steps away. Two trainers start these demons, {npc:5875} here and {npc:5675} in the {zone:1458}, and you can take only one; this guide follows whichever {quest:1472} you took. {npc:5909} offers both of {zone:1454}'s branches: take both."] = "达到 20 级后，{object:172982} 下方 {object:172960} 中的 {npc:5875} 会让你去找几步之外的 {npc:5909}。两名训练师可开启这些恶魔任务，分别是这里的 {npc:5875} 和 {zone:1458} 的 {npc:5675}，但你只能选择其中一人；本指南会跟随你已接受的 {quest:1472} 继续引导。{npc:5909} 提供 {zone:1454} 的两个分支：两个都接。",
	["the succubus"] = "魅魔",
	["the incubus"] = "男魅魔",

	-- Step 2: Zankaja
	-- {npc:5910} Zankaja · {object:172982} Valley of Strength
	["{npc:5910} lives in a hut up on the cliffs on the west side of the city, above the {object:172982}: climb the wind rider tower, cross the bridge at its top to the west and turn right off it. She sends you to the Crossroads."] = "{npc:5910}住在城市西侧悬崖上的小屋里，就在{object:172982}上方：爬上风骑士塔，从塔顶向西过桥，下桥后右转。她会派你去十字路口。",

	-- Step 3: Magar
	-- {npc:3363} Magar · {object:173018} Magar's Cloth Goods · {object:172960} Cleft of Shadow · {zone:1440} Ashenvale
	["{npc:3363} keeps {object:173018} on the main street east of the {object:172960}. He asks you to look for his mate Krilge in {zone:1440}."] = "{npc:3363}经营着{object:172960}以东主街上的{object:173018}。他要你去{zone:1440}寻找伴侣 格莱基。",

	-- Step 4: Gazrog
	-- {npc:3464} Gazrog · {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {zone:1442} Stonetalon Mountains
	["{npc:3464} waits in front of the inn at the Crossroads. He sends you on to {npc:4197} at {area:2539}, in {zone:1442}."] = "{npc:3464}在十字路口旅店前。他会让你继续去找{zone:1442}的{area:2539}里的{npc:4197}。",

	-- Step 5: Ken'zigla
	-- {zone:1442} Stonetalon Mountains · {area:2539} Malaka'jin · {npc:4197} Ken'zigla · {npc:5911} Grunt Logmar
	["Take the road west from the Crossroads into {zone:1442} and, just past the border, the faint trail up to the left (south): {area:2539} cannot be reached from the main road. {npc:4197} hands you her draught for {npc:5911}."] = "从十字路口沿路向西进入{zone:1442}，刚过边界就走左侧（南面）向上的隐约小径：从大路无法到达{area:2539}。{npc:4197}会将药剂交给你，送给{npc:5911}。",

	-- Step 6: Grunt Dogran
	-- {npc:5911} Grunt Logmar · {area:378} Camp Taurajo · {npc:5875} Gan'rul Bloodeye
	["{npc:5911} stands at {area:378}, south down the road from the Crossroads. He sends you north to the quilboar camp where Dogran is held: the camp with two huts side by side, north-west of a decoy camp whose huts stand apart. A rare level 22 elite quilboar sometimes guards the huts: send your voidwalker in, sacrifice it if you must, and talk to Dogran. He gives you a pendant for {npc:5875}. Keep it."] = "从十字路口沿路向南，{npc:5911}就在{area:378}。他会派你向北前往关押多格兰的野猪人营地：那里有两间并排的小屋，位于一处小屋分散的诱饵营地西北。有时会有一只22级稀有精英野猪人守在小屋旁：先让虚空行者冲进去，必要时牺牲它，然后与多格兰交谈。他会给你一条坠饰，交给{npc:5875}。留好它。",

	-- Step 7: The Binding: succubus (Orgrimmar)
	-- {quest:1513} The Binding · {zone:1454} Orgrimmar
	["{quest:1513}: succubus ({zone:1454})"] = "{quest:1513}：魅魔（{zone:1454}）",
	-- {npc:5875} Gan'rul Bloodeye · {item:6626} Dogran's Pendant · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade
	["Back to {npc:5875} with the pendant. He hands you {item:6626}: take it across the {object:172960} to {npc:3216}'s tent, stand on the purple circle and use it. Summon your voidwalker first and let it tank: the succubus (level 20, not elite) charms and lashes; keep your damage over time on her. If she wins, use the pendant again. Keep the pendant: {npc:5875} takes it back."] = "带着坠饰返回 {npc:5875} 处。他会给你 {item:6626}：穿过 {object:172960}，到 {npc:3216} 的帐篷，站在紫色法阵上使用。先召唤虚空行者，让它扛住攻击：魅魔（20级，非精英）会魅惑和鞭打，持续给她挂上持续伤害效果。如果她赢了，再次使用坠饰。保留坠饰：{npc:5875} 会收回它。",
	-- {item:6626} Dogran's Pendant
	["{item:6626}, on the circle in Neeru's tent"] = "在尼尔鲁帐篷里的法阵上使用{item:6626}",

	-- Step 8: Fallen Sky Lake
	-- {area:422} Fallen Sky Lake · {zone:1440} Ashenvale · {area:431} Splintertree Post · {item:190232} Withered Scarf · {npc:3931} Shadethicket Oracle
	-- plural, as words: Shadethicket Stone Movers = {npc:3782} Shadethicket Stone Mover
	["{area:422} lies in southern {zone:1440}, south-west of {area:431}. The Shadethicket Stone Movers and Bark Rippers (level 25-26) around the lake drop the {item:190232} about one time in twenty, and the lone {npc:3931} (30) can drop it too: plan on a good number of kills, so come at 25 or later (Forever made this quest level 27); with the succubus already bound you can leave it for your 20s leveling in {zone:1440}. They respawn in five minutes."] = "{area:422} 位于 {zone:1440} 南部、{area:431} 西南方。湖周围的移石沼泽兽和碎木沼泽兽（25-26 级）掉落 {item:190232} 的概率约为二十分之一，独自出现的 {npc:3931}（30 级）也可能掉落：预计需要击杀不少怪物，因此等到 25 级或更高再来（无限将本任务等级改为了 27 级）；若你已经绑定了魅魔，可以留到 20 多级在 {zone:1440} 升级时再做。它们每五分钟刷新。",

	-- Step 9: The Binding: incubus (Orgrimmar)
	-- {quest:65604} The Binding · {zone:1454} Orgrimmar
	["{quest:65604}: incubus ({zone:1454})"] = "{quest:65604}：梦魇（{zone:1454}）",
	-- {npc:5875} Gan'rul Bloodeye · {item:190232} Withered Scarf
	["Back to {npc:5875} with the scarf, then use the {item:190232} on the same circle in Neeru's tent and defeat the incubus it calls (level 20, not elite) with your voidwalker tanking. Keep the scarf: {npc:5875} takes it back."] = "带着围巾返回 {npc:5875} 处，再到尼尔鲁帐篷中的同一个法阵上使用 {item:190232}，击败召来的梦魇（20 级，非精英），让虚空行者扛住攻击。保留围巾：{npc:5875} 会收回它。",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the circle in Neeru's tent"] = "{npc:185335}，在尼尔鲁帐篷里的法阵处",

	-- Step 10: Devourer of Souls (Undercity)
	-- {object:1661} The Undercity · {npc:5675} Carendin Halgar · {quest:1472} Devourer of Souls · {npc:5875} Gan'rul Bloodeye · {object:36082} Magic Quarter · {npc:5693} Godrick Farsan
	["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of {npc:5875}'s. At 20 {npc:5675}, in the {object:36082}, sends you to {npc:5693} close by. {npc:5693} shows you an image of each quarry and offers both branches: take both."] = "这是 {object:1661} 的版本，适用于接受了 {npc:5675} 而非 {npc:5875} 的 {quest:1472} 的术士。达到 20 级后，{object:36082} 中的 {npc:5675} 会让你去找附近的 {npc:5693}。{npc:5693} 会展示每个目标的影像，并提供两个分支：两个都接。",

	-- Step 11: Silverpine hearts
	["Silverpine hearts"] = "银松森林的心脏",
	-- {npc:185333} Avelina Lilly · {area:279} Dalaran · {area:233} Ambermill · {npc:5682} Dalin Forgewright · {area:230} Greymane Wall
	["{npc:185333} (level 22) works as a tailor for the {area:279} wizards at {area:233}, in eastern Silverpine: the wizards around her are hostile. {npc:5682} (level 20, not elite) patrols near the {area:230} in the far south. Both are Alliance-friendly humans: attacking them can flag you for PvP. Each drops her or his heart."] = "{npc:185333}（22级）在银松森林东部的 {area:233} 为 {area:279} 的巫师担任裁缝：她周围的巫师是敌对的。{npc:5682}（20级，非精英）在最南端 {area:230} 附近巡逻。两者都是对联盟友善的人类：攻击可能使你进入PvP状态。他们各自掉落自己的心脏。",

	-- Step 12: Corma Villard
	-- {npc:5683} Corma Villard · {zone:1437} Wetlands · {area:881} Thandol Span · {zone:1458} Undercity · {area:287} Hillsbrad · {zone:1417} Arathi Highlands
	["{npc:5683} (level 22, not elite; Comar in older records) wanders the north of the {zone:1437} just past the {area:881}, to the right as you come off the bridge. From the {zone:1458} head through {area:287} and {zone:1417}, where the mobs are 30 and up. Attacking her flags you for PvP."] = "{npc:5683}（22级，非精英；旧记录中称为Comar）在{zone:1437}北部、刚过{area:881}的地方游荡，下桥后往右找。从{zone:1458}出发，穿过{area:287}和{zone:1417}，沿途怪物都在30级及以上。攻击她会使你进入PvP状态。",

	-- Step 13: The Binding: succubus (Undercity)
	-- {quest:1474} The Binding · {zone:1458} Undercity
	["{quest:1474}: succubus ({zone:1458})"] = "{quest:1474}：魅魔（{zone:1458}）",
	-- {npc:5675} Carendin Halgar · {npc:5683} Corma Villard · {item:6286} Pure Hearts
	["Back to {npc:5675} with Dalin's and {npc:5683}'s hearts. He hands you the {item:6286}: go down to the summoning circle below him, stand on it and use them. Summon your voidwalker first and keep the fight on the circle, or the guards may kill her and the kill does not count. If she wins, use the hearts again; keep them, {npc:5675} takes them back."] = "带着达林和{npc:5683}的心脏返回{npc:5675}。他会给你{item:6286}：下到他下方的召唤法阵，站在阵中使用。先召出虚空行者，并将战斗保持在法阵内，否则卫兵可能杀掉她，导致击杀不算数。如果你输了，再次使用心脏即可；记得保留，{npc:5675}会收回。",
	-- {item:6286} Pure Hearts · {npc:5675} Carendin Halgar
	["{item:6286}, on the circle below {npc:5675}"] = "{item:6286}，在 {npc:5675} 下方的法阵上",

	-- Step 14: Isaac Pearson
	-- {npc:185334} Isaac Pearson · {area:392} Ratchet · {zone:1413} Barrens · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["{npc:185334} (level 22) works in {area:392}, on the {zone:1413} coast, at one of two spots in town: take the zeppelin to {zone:1411} and head south, or fly from {zone:1454}. He is an Alliance-friendly human: attacking him can flag you for PvP."] = "{npc:185334}（22级）在{zone:1413}海岸的{area:392}工作，会出现在镇内两个位置之一：乘飞艇到{zone:1411}后向南走，或从{zone:1454}飞过去。他是对联盟友善的人类：攻击他可能使你进入 PvP 状态。",

	-- Step 15: The Binding: incubus (Undercity)
	-- {quest:65597} The Binding · {zone:1458} Undercity
	["{quest:65597}: incubus ({zone:1458})"] = "{quest:65597}：梦魇（{zone:1458}）",
	-- {npc:5675} Carendin Halgar · {item:190181} Lovers' Hearts
	["Back to {npc:5675} with the lovers' hearts, then place the {item:190181} on the same circle and defeat the incubus they call (level 20, not elite; it can charm you). Keep the hearts: {npc:5675} takes them back."] = "带着恋人的心脏返回 {npc:5675} 处，再将 {item:190181} 放在同一个法阵上，击败召来的梦魇（20 级，非精英；会魅惑你）。保留心脏：{npc:5675} 会收回它们。",
	-- {npc:185335} Summoned Incubus · {npc:5675} Carendin Halgar
	["{npc:185335}, at the circle below {npc:5675}"] = "{npc:185335}，在 {npc:5675} 下方法阵处",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "第二个魅魔类恶魔，即男性萨亚德，外加一个装灵魂碎片的灵魂碎片包。",
	-- ["At 20 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:5909} a few steps away. Two trainers offer the incubus, {npc:5875} here and {npc:5675} in the {zone:1458}, and you can take only one: this guide follows whichever {quest:1472} you took."] = "20级时，{object:172982}下方{object:172960}的{npc:5875}会让你去找几步之外的{npc:5909}。有两位训练师提供夜魔任务，这里的{npc:5875}和{zone:1458}的{npc:5675}，你只能接其中一个：本指南会跟随你接的那个{quest:1472}。",
	-- ["Back to {npc:5675} in the {object:36082}. Place the hearts at the summoning circle below him and defeat the incubus they call."] = "回到{object:36082}找{npc:5675}。把心脏放在他下方的召唤法阵上，击败它们召唤出的夜魔。",
	-- ["Back to {npc:5875} in the {object:172960}. Take the scarf to the summoning circle in {npc:3216}'s tent nearby and defeat the incubus it calls."] = "回到{object:172960}找{npc:5875}。把围巾带到附近{npc:3216}帐篷里的召唤法阵，击败它召唤出的夜魔。",
	-- ["Incubus (Horde)"] = "夜魔（部落）",
	-- ["{area:422} lies in southern {zone:1440}, south of {area:431}. The Shadethicket bog beasts around the lake drop the {item:190232}, about one in twenty."] = "{area:422}位于{zone:1440}南部、{area:431}南边。湖边的沼泽兽会掉落{item:190232}，大约二十只掉一次。",
	-- ["{npc:185333} works as a tailor for the {area:279} wizards at {area:233}, in eastern {zone:1421}. Take her heart."] = "{npc:185333}在{zone:1421}东部的{area:233}为{area:279}的法师们做裁缝。取走她的心脏。",
	-- ["{npc:185334} works in {area:392}, on the {zone:1413} coast. Take the zeppelin to {zone:1411} and ride or fly on to {area:392}."] = "{npc:185334}在{zone:1413}海岸的{area:392}工作。乘飞艇前往{zone:1411}，再骑行或飞往{area:392}。",
	-- ["{npc:3363} keeps {object:173018}, east of the {object:172960} along the main street. He asks you to look for his mate, Krilge."] = "{npc:3363}经营着{object:172960}东边主街上的{object:173018}。他请你去寻找他的伴侣。",
	-- ["{npc:5675}: he binds the incubus to you"] = "{npc:5675}：他把夜魔束缚给你",
	-- ["{npc:5875}: he binds the incubus to you"] = "{npc:5875}：他把夜魔束缚给你",
	-- ["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of {npc:5875}'s. At 20 {npc:5675}, in the {object:36082}, sends you to {npc:5693} in the Temple of the Damned, just north of him."] = "{object:1661}的版本，适合接了{npc:5675}而非{npc:5875}的{quest:1472}的术士。20级时，{object:36082}的{npc:5675}会让你去他北边不远处的神殿找{npc:5693}。",
}
