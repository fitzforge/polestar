-- Chinese (simplified) (zhCN): the guide forever/reputation/nightclaw-druids (forever/reputation/nightclaw-druids.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Nightclaw Druids = {npc:254152} Nightclaw Druid
	["Nightclaw Druids Reputation"] = "夜爪德鲁伊声望",
	-- {zone:2521} Zephras Isle
	["{zone:2521}'s hidden druids: five cultist ears pay 1000 reputation, best done before you outlevel the isle."] = "{zone:2521}的隐秘德鲁伊：交出五只邪教徒耳朵可获得1000点声望，最好在等级超过该岛之前完成。",
	-- {skill:164} Blacksmithing · {skill:165} Leatherworking · {skill:197} Tailoring
	["48 {skill:164}, {skill:165} and {skill:197} patterns"] = "48个{skill:164}、{skill:165}和{skill:197}图样",

	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "从{area:279}乘天空飞船",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island, open to everyone. A skyboat leaves the north side of {area:279} about every five minutes; another flies from north of {zone:1456}, and either faction may take either."] = "{zone:2521}是天裔的初始岛屿，对所有人开放。{area:279}北侧约每5分钟有一艘空中船出发；{zone:1456}北面也有另一艘，两个阵营都可乘坐任意一艘。",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "乘天空飞船前往{zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "从{zone:1456}乘天空飞船",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island, open to everyone. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes; another flies from {area:279}, and either faction may take either."] = "{zone:2521}是天裔的初始岛屿，对所有人开放。一艘飞空船约每五分钟从{zone:1456}以北、{area:17045}以南的悬崖出发；另一艘从{area:279}起飞，任意阵营都能搭乘这两艘船。",

	-- Step 3: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands in {area:16638}, the Skyborne town in the south of the isle, and has heard nothing from the druids up north. His errand is the start of the Nightclaw storyline (level 8 and up, any race). Every quest of it pays Nightclaw reputation: 4100 in all, enough for Friendly. Players' turn-ins paid their full reputation well above these quests' level."] = "",

	-- Step 4: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into the {area:16631}. {npc:257944} holds the druids' camp in its north-east."] = "向北进入{area:16631}。{npc:257944}在其东北部驻守德鲁伊营地。",

	-- Step 5: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:257944} Elegael Thornpaw · {area:16720} Nightclaw Cavern
	["{npc:254151}, the druids' quartermaster, waits inside their den: the cave just across the clearing north-east of {npc:257944} ({area:16720} on the map; {npc:257944} calls it the Nightfang Den). Take his ear quest now: the cultists you fight for {npc:257944} drop ears for it."] = "德鲁伊军需官 {npc:254151} 在他们的兽穴里等候：从 {npc:257944} 向东北穿过空地，对面就是洞口（地图上标为 {area:16720}；{npc:257944} 称其为夜牙兽穴）。现在接下他的耳朵任务：你为 {npc:257944} 对付的教徒会掉落所需耳朵。",

	-- Step 6: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Footsoldiers = {npc:252665} Al'Aketh Footsoldier · Bloody Heirlooms = {item:265141} Bloody Heirloom · Shadowgale Shrieklings = {npc:256092} Shadowgale Shriekling
	["The Al'Aketh Footsoldiers and Stormchasers camp just north of {npc:257944} and drop the Bloody Heirlooms (and ears, about one kill in four). The Shadowgale Shrieklings flying west of her drop the feathers; the {item:265105} grows on the trees along the stream west of her."] = "奥拉凯斯步兵和奥拉凯斯逐暴者在{npc:257944}北面不远处扎营，会掉落被汗水浸透的传家宝（也掉落耳朵，约四分之一概率）。她西面飞行的影风尖啸幼兽会掉落羽毛；{item:265105}长在她西面溪流沿岸的树上。",
	-- {npc:254151} Vayn Moongaze
	["ears for {npc:254151}: keep every one"] = "交给{npc:254151}的耳朵：每个都留着",

	-- Step 7: Elegael Thornpaw's next tasks
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}'s next tasks"] = "{npc:257944} 的后续任务",
	["500 reputation"] = "500 点声望",

	-- Step 8: The Nightfang Den and Commander Haalien
	-- {npc:253622} Commander Haalien
	["The Nightfang Den and {npc:253622}"] = "夜牙兽穴和 {npc:253622}",
	-- {npc:257944} Elegael Thornpaw · {npc:258134} Naaleos Leafwhisper · {npc:258130} Jorel Windsinger · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive
	["The Nightfang Den is the cave north across the clearing from {npc:257944}. Heal the seven injured druids inside ({npc:258134} among them) and find {npc:258130}. {npc:253622} stands east of the den: he drops his head and a {quest:94490}; right-click the missive to start its quest."] = "夜牙兽穴是 {npc:257944} 北侧、穿过空地后的洞穴。治疗洞内七名受伤的德鲁伊（其中包括 {npc:258134}），并找到 {npc:258130}。{npc:253622} 站在洞穴东侧：他会掉落头颅和一份 {quest:94490}；右键点击信件可开始其任务。",
	-- {npc:253622} Commander Haalien
	["from {npc:253622}"] = "由 {npc:253622} 掉落",

	-- Step 9: Elegael Thornpaw, the den's fate
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the den's fate"] = "{npc:257944}，巢穴的命运",
	["1000 reputation"] = "1000声望",

	-- Step 10: Ears at the Shrine of Akir
	-- {area:16629} Shrine of Akir
	["Ears at the {area:16629}"] = "在 {area:16629} 收集耳朵。",
	-- {area:16629} Shrine of Akir · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Honor Guards = {npc:3083} Honor Guard
	["The best ears are south of the forest at the {area:16629}: Skypriests drop one in more than half their kills, Guardians in four of ten, Spiritcallers and Honor Guards in a third. The {area:16626} just north-west of {area:16638} are next best (Brawlers and Pillagers, about four in ten). All cultists are level 8 to 10."] = "刷耳朵最佳地点是森林南边的 {area:16629}：天空祭司 的掉率超过一半，艾露恩的卫士约十分之四，奥拉凯斯唤灵者 和荣誉卫兵约三分之一。其次是 {area:16638} 西北不远的 {area:16626}（布劳勒尔和 奥拉凯斯掠夺者，约十分之四）。所有教徒都是 8 至 10 级。",

	-- Step 11: Mercy Falls on Deaf Ears
	-- {npc:254151} Vayn Moongaze
	["Back to {npc:254151} inside the den. Ten ears for 1000 reputation and a green piece: leather gloves, cloth pants or mail boots. {npc:254151} then takes ears five at a time, for 1000 each, as often as you like, up to level 18; in Classic the pay drops from level 19 and is 200 from level 22. The Legacy perk Diplomat adds up to 10% to every gain."] = "返回巢穴内的{npc:254151}身边。10只耳朵可换1,000声望及一件绿色装备：皮甲手套、布甲长裤或锁甲靴子。之后{npc:254151}每次接收5只耳朵，奖励1,000声望，可无限重复，18级及以下均为此数值；经典旧世中从19级起奖励下降，22级起为200。传承系统特长“外交家”使每次声望获取最多增加10%。",

	-- Step 12: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "返回{area:16638}",
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar · {area:16626} Gustberry Lowlands
	["{npc:252359} waits in {area:16638}. Hand in on your way to a skyboat or to the {area:16626}."] = "{npc:252359}在{area:16638}等候。去乘空中船或前往{area:16626}时顺路交还。",

	-- Step 13: Friendly to Honored
	["Friendly to Honored"] = "友善到尊敬",
	-- {npc:254151} Vayn Moongaze
	["The storyline and {npc:254151}'s first quest leave you at Friendly with 2100 to spare. Honored is 3900 more: four turn-ins of five ears up to level 18, twenty from level 22. Friendly opens 32 of {npc:254151}'s patterns, in two colours, Cloudy and Azure: Blacksmithing Skyforged Wristguards and Chain (skill 50, 9s 50c), Gauntlets and Greaves (55, 11s); Leatherworking Gustwoven and Windraveled bracers and belts (50) and gloves and boots (55); Tailoring Stormsewn Cuffs and Cord (50), Handwraps and Shoes (55). They bind when you buy them, so buy them on the crafter."] = "故事线加上 {npc:254151} 的首个任务，会让你达到友善并多出 2100 点。到尊敬还差 3900 点：18 级及以下，每次交五只耳朵，交四次即可；22 级起则需交二十次。友善后开放 {npc:254151} 的 32 张图样，分 黯云 和碧蓝圣殿骑士两种颜色：锻造的 天铸 护腕和链带（技能 50，9 银 50 铜）、护手和胫甲（55，11 银币）；制皮的 风织 与 风缠 护腕和腰带（50）、手套和靴子（55）；裁缝的 雷缝 护腕和束带（50）、裹手和鞋（55）。购买后绑定，因此要由制造角色购买。",
	["five ears per turn-in"] = "每次交还五只耳朵",
	-- {quest:93459} More Al'Aketh Ears
	["{quest:93459}: 1000 reputation"] = "{quest:93459}：1000声望",
	-- {npc:254151} Vayn Moongaze
	["{npc:254151}'s patterns"] = "{npc:254151}的图样",

	-- Step 14: Honored to Revered
	["Honored to Revered"] = "尊敬到崇敬",
	["Honored opens the chest and leg patterns (skill 60, 12s 50c): Skyforged chainmail and legguards, Gustwoven harness and trousers, Windraveled jerkin and pants, Stormsewn vest and leggings. Revered is 12000 more: 12 turn-ins (60 ears, about 160 cultist kills at the Shrine) up to level 18, 60 turn-ins (300 ears) from level 22."] = "尊敬可解锁胸甲和腿部装备图样（技能60，12银币50铜币）：天铸链甲、天铸腿甲、风织束甲、风织长裤、风缠夹克、风缠短裤、雷缝外衣 和 雷缝护腿。到崇敬还需12000点：18级及以下需交还12次（60只耳朵，约需在神殿击杀160名教徒），22级起需交还60次（300只耳朵）。",

	-- Step 15: Revered to Exalted
	["Revered to Exalted"] = "崇敬到崇拜",
	-- {item:280347} Shadowgale Squirrel
	["Revered opens the {item:280347}, a companion pet, for 50s. Exalted is 21000 more: 21 turn-ins (105 ears, about 280 kills) up to level 18, 105 turn-ins (525 ears) from level 22."] = "崇敬后，可花 50 银购买小伙伴宠物 {item:280347}。升到崇拜还需 21000 点：18 级及以下需要交还 21 次（105 只耳朵，约击杀 280 个目标），22 级起需要交还 105 次（525 只耳朵）。",
	-- {item:280347} Shadowgale Squirrel
	["{item:280347}, 50s"] = "{item:280347}，50银",

	-- Step 16: The Nightclaw Mantle
	-- {item:280363} Nightclaw Mantle
	["The {item:280363}"] = "{item:280363}",
	-- {item:280363} Nightclaw Mantle
	["Exalted opens the {item:280363}, green cloth shoulders for level 15, for 8s 16c."] = "崇拜后解锁{item:280363}，一件15级绿色布甲护肩，售价8银16铜。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:252359} stands in {area:16638}, the Skyborne town in the south of the isle, and has heard nothing from the druids up north. His errand is the start of the Nightclaw storyline (level 8 and up, any race). Every quest of it pays Nightclaw reputation: 4100 in all, enough for Friendly. Come early: in Classic a quest pays less once you are 6 levels above it, a fifth at most from 9 levels up, and these are level 11 to 13 quests."] = "{npc:252359} 站在岛屿南部的天裔城镇 {area:16638}，一直没有收到北边德鲁伊的消息。他的差事是 夜爪 故事线的开端（8 级起，所有种族均可）。这条线的每个任务都会奖励 夜爪 声望：总共 4100 点，足够到友善。尽早来做：经典怀旧服中，超过任务 6 级后奖励会减少，超过 9 级及以上时最多只能获得五分之一，而这些任务是 11 至 13 级。",
}
