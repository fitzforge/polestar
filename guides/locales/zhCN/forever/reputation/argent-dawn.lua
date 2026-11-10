-- Chinese (simplified) (zhCN): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "银色黎明声望",
	-- {area:2057} Scholomance · {area:2279} Stratholme
	["Scourgestones, {area:2057} and {area:2279}: the shoulder resistance enchants and a dozen recipes."] = "天灾石、{area:2057}和{area:2279}：肩部抗性附魔和十几种配方。",
	["Recipes for Tailors, Leatherworkers, Blacksmiths, Enchanters and Alchemists from Honored and Revered"] = "尊敬和崇敬时可获得裁缝、制皮、锻造、附魔和炼金术配方",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401}（联盟）",
	-- {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10840} stands in {area:3197}, in the south of the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10840} 站在 {zone:1422} 南部的 {area:3197}。所有人的 {object:2160} 声望都从中立 200 点开始。与天灾军团战斗时要装备委任徽章饰品：只有戴着它才会掉落天灾石。{area:2268} 的 {npc:11039} 也会给予相同的委任徽章；只能领取其中一个。",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401}（部落）",
	-- {npc:10839} Argent Officer Garush · {area:152} Bulwark · {zone:1420} Tirisfal Glades · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10839} stands at the {area:152}, on the road from {zone:1420} into the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10839} 站在 {area:152}，位于从 {zone:1420} 通往 {zone:1422} 的路上。所有人的 {object:2160} 起始声望均为中立200点。与天灾作战时要装备委任徽章饰品：只有佩戴时才会掉落天灾石。{area:2268} 的 {npc:11039} 也会提供同样的委任徽章；只能领取一个。",

	-- Step 3: Neutral to Friendly: Scourge of the Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Neutral to Friendly: Scourge of the {zone:1422}"] = "中立到友善：{zone:1422} 的天灾军团",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {area:202} Writhing Haunt · {area:201} Gahrron's Withering · {quest:5510} Minion's Scourgestones · {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Every Scourge kill in the Plaguelands gives 5 reputation (named ones 15), from the level 50 ghouls and skeletons up; at level 60 pick the level 53 and up ones, since in Classic grey mobs give only about a fifth. Neutral to Friendly is 2,800: about 560 kills, fewer with the Plaguelands quests on the way. The densest Scourge stand around the four Scourge Cauldrons: {area:199} west of Andorhal (skeletons, 50-53), {area:200} north of Andorhal (zombies and ghouls, 52-55), the {area:202} in the south (ghouls, 54-55) and {area:201} in the east (ghosts, 56-57). Keep every Scourgestone and every quest you can save: turn-ins never stop counting, kills do. {quest:5510} drop from about four in ten of these Scourge, Invader's from about a third of the level 56 and up ones. If you die, take the Commission off and put it back on: it can lose its effect. Paladins (Human and Dwarf): {npc:10838} at {area:3197} asks 20 {quest:5510} once for Dispelling Evil, 100 reputation instead of 25. The Legacy perk Diplomat adds up to 10% to every gain."] = "在瘟疫之地，每击杀一只天灾怪物获得5声望（有名字的怪物15），从50级食尸鬼和骷髅起都算；60级时应选53级及以上的，因为经典旧世中灰色怪物只提供约五分之一声望。从中立到友善需要2,800声望：大约560次击杀，沿途做瘟疫之地任务可减少所需击杀数。天灾最密集的地方在四口瘟疫之锅周围：安多哈尔西面的 {area:199}（骷髅，50—53级）、安多哈尔北面的 {area:200}（僵尸和食尸鬼，52—55级）、南面的 {area:202}（食尸鬼，54—55级）和东面的 {area:201}（幽灵，56—57级）。保留所有天灾石，并尽可能留着任务：交还始终能获得声望，击杀则有上限。这些天灾怪物掉落 {quest:5510} 的概率约为十分之四；56级及以上怪物掉落侵略者的天灾石的概率约为三分之一。如果死亡，请卸下委任徽章再重新装备：它可能会失效。圣骑士（人类和矮人）：{area:3197} 的 {npc:10838} 会在“驱散邪恶”中一次性索要20个 {quest:5510}，奖励100声望，而非25。传承特权外交家会使每次声望获取最多提高10%。",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: keep them"] = "{quest:5510}：留着它们",
	-- {area:201} Gahrron's Withering
	-- plural, as words: Hungering Wraiths = {npc:1802} Hungering Wraith
	["Hungering Wraiths at {area:201}; any Scourge counts"] = "{area:201} 的饥饿的鬼魂；任何天灾军团怪物都算",
	-- {area:202} Writhing Haunt
	-- plural, as words: Soulless Ghouls = {npc:1794} Soulless Ghoul
	["Soulless Ghouls at the {area:202}"] = "{area:202} 的没有灵魂的食尸鬼",

	-- Step 4: Plaguelands quests and the Scourge Cauldrons
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Plaguelands quests and the Scourge Cauldrons"] = "瘟疫之地任务与瘟疫之锅",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {npc:11055} Shadow Priestess Vandis · {area:152} Bulwark · {npc:1852} Araj the Summoner · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:12250} Zaeldarr the Outcast · {npc:11038} Caretaker Alen · {npc:11056} Alchemist Arbington · {npc:11057} Apothecary Dithers · {item:13370} Vitreous Focuser · {item:14047} Runecloth · {area:201} Gahrron's Withering · {item:13354} Ectoplasmic Resonator
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["The Plaguelands quests pay in full at 60 from level 55 up and never stop counting, about 1,500 in all; the leveling guides walk them. The cauldron chain from {npc:11053} at {area:3197} (Horde: {npc:11055} at the {area:152}): 150 per cauldron with its return, then Mission Accomplished! 200. Alas, Andorhal 150 ({npc:1852}, elite). At {area:2268}, {npc:11063}'s {area:2262} quests (Brother Carlin 50 from Chromie in Andorhal, Villains of Darrowshire 100, Marauders of Darrowshire 100) and {npc:10926}'s Hidden Treasures 200 at the end of the {area:2262} story; {npc:12250} 75 from {npc:11038}. After Mission Accomplished!, each cauldron takes a repeatable delivery: 25 reputation every time, until Exalted. {npc:11056} at {area:3197} (Horde: {npc:11057} at the {area:152}) gives you a {item:13370}, without which the reagents never drop, and sells Arcane Quickeners for 50 silver (one per delivery; it crumbles after 30 minutes, so buy it last). Each delivery also takes 4 {item:14047}. Farm {area:201}: its ghosts drop an {item:13354} about one time in four, so about 16 kills fill a delivery; the other cauldrons want 5 or 6 reagents that drop one time in ten or less. Once the Plaguelands Scourge stop counting, this earns about four times what their Scourgestones alone do."] = "",
	-- {npc:11056} Alchemist Arbington · {item:13370} Vitreous Focuser
	["{npc:11056}: ask for a {item:13370}"] = "{npc:11056}：索取一个 {item:13370}。",
	-- {npc:11057} Apothecary Dithers · {area:152} Bulwark · {item:13370} Vitreous Focuser
	["{npc:11057}, at the {area:152}: ask for a {item:13370}"] = "{area:152} 的 {npc:11057}：索取一个 {item:13370}",
	-- {area:201} Gahrron's Withering
	["the cauldron at {area:201}"] = "{area:201} 的瘟疫之锅",
	-- plural, as words: Ectoplasmic Resonators = {item:13354} Ectoplasmic Resonator
	["Ectoplasmic Resonators: the ghosts around the cauldron"] = "外膜震荡体：大锅周围的幽灵",
	-- {item:13320} Arcane Quickener
	["{item:13320}, 50 silver"] = "{item:13320}，50银币",

	-- Step 5: Light's Hope Chapel quests
	-- {area:2268} Light's Hope Chapel
	["{area:2268} quests"] = "{area:2268}的任务",
	-- {area:2268} Light's Hope Chapel · {zone:1423} Eastern Plaguelands · {faction:529} Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {npc:11035} Betina Bigglezink · {npc:243254} Leonid Barthalomew · {area:2279} Stratholme · {area:2057} Scholomance · {object:176317} Argent Hold
	["{area:2268}, on the east side of the {zone:1423}, is the {faction:529}'s home: {npc:11039}, {npc:11035} and {npc:243254} give its dungeon quests, 100 to 200 reputation each and about 1,700 in all. They are group quests for {area:2279} and {area:2057} (level 58-60, five players): take the ones your group will run. The Duke's chain ends at the {object:176317}, a chest of {faction:529} gear."] = "{area:2268} 位于 {zone:1423} 东部，是 {faction:529} 的据点：{npc:11039}、{npc:11035} 和 {npc:243254} 会提供地下城任务，每个奖励100到200点声望，总计约1,700点。这些是 {area:2279} 和 {area:2057} 的组队任务（58—60级，五人）：只接你的小队要去的地下城对应的任务。公爵的任务线最终奖励 {object:176317}，这是装有 {faction:529} 装备的箱子。",

	-- Step 6: Stratholme
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare · {item:12843} Corruptor's Scourgestone
	["{area:2279} is a group of five at the north end of the {zone:1423}. Its Scourge give 5 reputation a kill up to the last point of Honored, and its Scourge bosses 25 until Exalted ({npc:10440} 50), each with a {item:12843}. The Black Guard Sentries by the Baron give 5 until Exalted. The Scourge side, through the service entrance, pays far more than the Scarlet side."] = "{area:2279} 是位于 {zone:1423} 最北端的五人地下城。其中的天灾怪物每只提供 5 点声望，直到尊敬的最后一点；天灾首领每只提供 25 点，直到崇拜（{npc:10440} 提供 50 点），而且各掉落一个 {item:12843}。男爵旁的黑衣卫哨兵每只提供 5 点，直到崇拜。从后门进入的天灾区，比血色区提供的声望多得多。",
	-- plural, as words: Plagued Flesh Samples = {item:13174} Plagued Flesh Sample
	["Plagued Flesh Samples: the Scourge inside"] = "瘟疫肉块：由内部的天灾怪物掉落",
	-- {item:13180} Stratholme Holy Water
	["{item:13180}: the supply crates"] = "{item:13180}：补给箱",
	-- {npc:10811} Archivist Galford
	["{npc:10811}, Scarlet side"] = "{npc:10811}，血色区",

	-- Step 7: Scholomance
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {faction:529} Argent Dawn · {quest:5508} Corruptor's Scourgestones · {npc:10508} Ras Frostwhisper · {npc:1853} Darkmaster Gandling
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; your side's {area:2057} quests give the {item:13704} that opens it. It is the best {faction:529} run: its mobs give 5 up to the last point of Honored, and its thirteen bosses about 375 reputation a full clear plus ten or so {quest:5508} (about 250 more). {npc:10508} and {npc:1853} give 50 each."] = "{area:2057} 位于 {zone:1422} 东南方岛上城镇 {area:2298} 的地下；本阵营的 {area:2057} 任务会奖励开门用的 {item:13704}。这是刷 {faction:529} 声望最好的地下城：普通怪每只奖励5点，直到尊敬阶段的最后一点之前；十三名首领完整清理约奖励375点，再加上大约十个 {quest:5508}（约额外250点）。{npc:10508} 和 {npc:1853} 每名奖励50点。",
	-- {quest:5529} Plagued Hatchlings
	["{quest:5529}, in the hatchery"] = "{quest:5529}，在孵化间内",

	-- Step 8: Back at Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back at {area:2268}"] = "回到{area:2268}",
	-- {quest:5212} The Flesh Does Not Lie · {quest:5213} The Active Agent · {item:13176} Scourge Data · {area:2279} Stratholme · {item:13209} Seal of the Dawn · {item:19812} Rune of the Dawn · {quest:5251} The Archivist · {item:13250} Head of Balnazzar · {npc:10440} Baron Rivendare · {item:13920} Healthy Dragon Scale · {quest:5529} Plagued Hatchlings · {npc:10267} Tinkee Steamboil · {zone:1428} Burning Steppes · {area:1583} Blackrock Spire · {npc:243254} Leonid Barthalomew · {npc:11035} Betina Bigglezink · {item:12368} Dawn's Gambit · {area:2057} Scholomance
	["{quest:5212} leads to {quest:5213} (the {item:13176} in a {area:2279} ziggurat), which rewards the {item:13209} or the {item:19812}: better trinkets that also make Scourgestones drop, so they can replace the Commission. {quest:5251} leads on to the {item:13250} and {npc:10440}. A {item:13920}, a rare drop (about 6%) from the {quest:5529} once {quest:5529} is done, starts a quest worth 50 each time: keep them until Revered. {npc:10267} in the {zone:1428}, at the end of her {area:1583} quests, sends you to {npc:243254} (75) and on to {npc:11035}'s {item:12368} in {area:2057} (25 and 200)."] = "{quest:5212} 后续是 {quest:5213}（获取 {area:2279} 通灵塔中的 {item:13176}），奖励 {item:13209} 或 {item:19812}：它们是更好的饰品，同样能让怪物掉落天灾石，因此可以替代委任徽章。{quest:5251} 会继续引向 {item:13250} 和 {npc:10440}。完成 {quest:5529} 后，{quest:5529} 有较低概率（约 6%）掉落 {item:13920}，可开启一个每次提供 50 点声望的任务：留到崇敬再交。{zone:1428} 的 {npc:10267} 在她的 {area:1583} 任务链末尾，会让你去找 {npc:243254}（75 点），再前往 {area:2057} 获取 {npc:11035} 所需的 {item:12368}（25 点和 200 点）。",

	-- Step 9: Friendly to Honored: stones and named Scourge
	["Friendly to Honored: stones and named Scourge"] = "友善到尊敬：天灾石与有名的天灾怪",
	-- {npc:10826} Lord Darkscythe · {npc:10821} Hed'mush the Rotting · {npc:10825} Gish the Unmoving · {area:2057} Scholomance · {area:2279} Stratholme · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {area:3197} Chillwind Camp · {area:152} Bulwark · {item:12844} Argent Dawn Valor Token · {quest:5509} Invader's Scourgestones · {area:2272} Northdale · {item:12843} Corruptor's Scourgestone · {npc:1850} Putridius
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage · Dread Weavers = {npc:8528} Dread Weaver · Scourge Champions = {npc:8529} Scourge Champion · Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Normal Scourge outside the dungeons stop giving reputation halfway through Friendly (3,000 of 6,000); {npc:10826}, {npc:10821} and {npc:10825} stop at the end of Friendly. After that only Araj, the {area:2057} and {area:2279} mobs, the cauldron deliveries and Scourgestones count. Now turn in the stones you saved: {npc:11039} at {area:2268} takes all three kinds, and so do the officers at {area:3197} and the {area:152}. Every turn-in pays 25 and an {item:12844}: keep 35 tokens for the mantles at Revered and Exalted. {quest:5509} are worth twice as much per stone: the Dark Adepts, Shadowmages, Dread Weavers and Scourge Champions (level 58-60) at {area:2272}, just north of {area:2268}, drop them about a third of the time or more, next to the turn-in. The named Scourge below drop a {item:12843} half the time or more ({npc:1850} two times in three, Araj and {npc:10821} half the time) and give 15 a kill, Araj until Exalted; {npc:1850} gives no reputation, only the stone. Friendly opens the Enriched Manna Biscuits (60 silver) at the quartermasters."] = "地下城外的普通天灾怪在友善过半后（6,000中的3,000）就不再奖励声望；{npc:10826}、{npc:10821} 和 {npc:10825} 在友善结束时停止。之后只有阿拉基、{area:2057} 和 {area:2279} 的怪物、瘟疫之锅材料交付以及天灾石还能提供声望。现在交还之前攒下的天灾石：{area:2268} 的 {npc:11039} 接受全部三种，{area:3197} 和 {area:152} 的军官也一样。每次交还奖励25点和一个 {item:12844}：保留35个徽章，用于崇敬和崇拜的衬肩。{quest:5509} 每颗的声望价值是另一种的两倍：{area:2268} 正北方 {area:2272} 的黑暗教徒、暗影法师、恐怖编织者和天灾勇士（58—60级）约有三分之一或更高概率掉落，且就在交还点旁边。下列有名的天灾怪至少有一半概率掉落 {item:12843}（{npc:1850} 为三分之二，阿拉基和 {npc:10821} 为一半），每次击杀还奖励15点，阿拉基可一直奖励到崇拜；{npc:1850} 不奖励声望，只掉天灾石。友善可在军需官处购买可口的魔法点心（60银币）。",
	-- {item:12843} Corruptor's Scourgestone
	["{item:12843}: the named Scourge below, and dungeon bosses"] = "{item:12843}：来自下方列出的具名天灾怪物和地下城首领。",
	-- {area:2272} Northdale
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage
	["Dark Adepts and Shadowmages at {area:2272}"] = "{area:2272} 的黑暗教徒和暗影法师",
	-- {npc:1852} Araj the Summoner
	["{npc:1852}, Andorhal"] = "{npc:1852}，安多哈尔",
	-- {npc:1850} Putridius · {zone:1422} Western Plaguelands
	["{npc:1850}, {zone:1422}: the stone only"] = "{npc:1850}，{zone:1422}：只取石头",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: 20 for 25 reputation"] = "{quest:5510}：20 个换取 25 点声望。",
	-- {quest:5509} Invader's Scourgestones
	["{quest:5509}: 10 for 25 reputation"] = "{quest:5509}：10 个换 25 点声望",
	-- {quest:5508} Corruptor's Scourgestones
	["{quest:5508}: 1 for 25 reputation"] = "{quest:5508}：1个换25声望",

	-- Step 10: Honored to Revered: dungeons and stones
	["Honored to Revered: dungeons and stones"] = "尊敬到崇敬：地下城与天灾石",
	-- {area:2057} Scholomance · {area:2279} Stratholme · {quest:5509} Invader's Scourgestones · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:10856} Argent Quartermaster Hasana · {area:152} Bulwark · {item:22014} Hallowed Brazier
	["Honored to Revered is 12,000: about 2,400 {area:2057} and {area:2279} mobs, fewer with their bosses. Their mobs stop at 11,999 of 12,000 Honored; a boss or a turn-in takes you over. Solo, only Scourgestones, the cauldron deliveries and Araj count: 12,000 is 480 turn-ins, or 4,800 {quest:5509}. Keep the stones you get in the dungeons until their mobs stop counting. Honored opens recipes at all three quartermasters: {npc:11536} at {area:2268}, {npc:10857} at {area:3197}, {npc:10856} at the {area:152}. Also the {item:22014} (133 gold) for the Three Kings of Flame quest."] = "从尊敬到崇敬需要12,000点：约需击杀2,400只 {area:2057} 和 {area:2279} 的普通怪，如果也击杀首领则更少。普通怪到尊敬12,000中的11,999点便停止提供声望；再击杀首领或交还一次物品即可跨过门槛。单人只有天灾石、瘟疫之锅材料交付和阿拉基还能提供声望：12,000点相当于480次交还，或4,800颗 {quest:5509}。地下城中获得的天灾石先保留，等普通怪不再提供声望后再交。尊敬可解锁三位军需官的配方：{area:2268} 的 {npc:11536}、{area:3197} 的 {npc:10857}、{area:152} 的 {npc:10856}。还可购买“烈焰之王”任务需要的 {item:22014}（133金币）。",
	-- {item:19446} Formula: Enchant Bracer - Mana Regeneration
	["{item:19446}, 3 gold"] = "{item:19446}，3 金",
	-- {item:19216} Pattern: Argent Boots · {skill:197} Tailoring
	["{item:19216} ({skill:197}), 2 gold 20 silver"] = "{item:19216}（{skill:197}），2 金 20 银",
	-- {item:19328} Pattern: Dawn Treaders · {skill:165} Leatherworking
	["{item:19328} ({skill:165}), 2 gold 20 silver"] = "{item:19328}（{skill:165}），2 金 20 银",
	-- {item:19203} Plans: Girdle of the Dawn · {skill:164} Blacksmithing
	["{item:19203} ({skill:164}), 2 gold 20 silver"] = "{item:19203}（{skill:164}），2 金 20 银",
	-- {item:13482} Recipe: Transmute Air to Fire · {skill:171} Alchemy
	["{item:13482} ({skill:171}), 1 gold 50 silver"] = "{item:13482}（{skill:171}），1 金 50 银",
	-- {item:19442} Formula: Powerful Anti-Venom · {skill:129} First Aid
	["{item:19442} ({skill:129}), 10 gold"] = "{item:19442}（{skill:129}），10 金",

	-- Step 11: Mantles of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5504} Mantles of the Dawn · {faction:529} Argent Dawn · {item:18173} Shadow Mantle of the Dawn · {item:13810} Blessed Sunfruit
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Revered, {npc:11536} takes 10 Argent Dawn Valor Tokens for {quest:5504} (100 reputation). After it, any {faction:529} quartermaster sells the five shoulder enchants for 10 gold each: Flame, Frost, Arcane, Nature and {item:18173}, +5 to that resistance. Revered also opens the {item:13810} and its juice (60 silver) and the Revered recipes."] = "达到崇敬后，{npc:11536} 会收取 10 枚银色黎明勇气勋章，用于完成 {quest:5504}（100 点声望）。完成后，任意 {faction:529} 军需官都会出售五种肩部附魔，每种 10 金币：火焰、冰霜、奥术、自然和 {item:18173}，对应抗性 +5。崇敬还会解锁 {item:13810} 及其果汁（60 银）和崇敬配方。",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens, from the stone turn-ins"] = "银色黎明勇气勋章，通过交还天灾石获得",
	-- {item:18170} Frost Mantle of the Dawn
	["{item:18170}: pick the resistance you need, 10 gold"] = "{item:18170}：选择所需抗性，10金币",
	-- {item:19447} Formula: Enchant Bracer - Healing
	["{item:19447}, 6 gold"] = "{item:19447}，6 金",
	-- {item:19217} Pattern: Argent Shoulders · {skill:197} Tailoring
	["{item:19217} ({skill:197}), 4 gold"] = "{item:19217}（{skill:197}），4 金",
	-- {item:19329} Pattern: Golden Mantle of the Dawn · {skill:165} Leatherworking
	["{item:19329} ({skill:165}), 4 gold"] = "{item:19329}（{skill:165}），4 金",
	-- {item:19205} Plans: Gloves of the Dawn · {skill:164} Blacksmithing
	["{item:19205} ({skill:164}), 4 gold"] = "{item:19205}（{skill:164}），4 金",

	-- Step 12: Revered to Exalted
	["Revered to Exalted"] = "崇敬到崇拜",
	-- {quest:5508} Corruptor's Scourgestones · {area:2057} Scholomance · {item:13920} Healthy Dragon Scale
	["Revered to Exalted is 21,000: 840 Scourgestone or cauldron turn-ins, or the dungeon bosses with their {quest:5508} (a full {area:2057} clear is about 600). Turn in every stone and {item:13920} you saved."] = "从崇敬到崇拜需要 21,000 点：相当于交还 840 次天灾石或大锅任务，也可以击杀地下城首领并完成对应的 {quest:5508}（完整清理一次 {area:2057} 约提供 600 点）。把之前留存的所有天灾石和 {item:13920} 都交掉。",

	-- Step 13: Chromatic Mantle of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5517} Chromatic Mantle of the Dawn
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Exalted, {npc:11536} takes 25 Argent Dawn Valor Tokens for the {quest:5517} (150 reputation): +5 to every resistance, on your shoulders. After it, the quartermasters sell more for 40 gold each."] = "崇拜后，{npc:11536} 会收取 25 枚银色黎明勇气勋章，完成 {quest:5517}（150 点声望）：肩部附魔，所有抗性 +5。之后军需官会以每个 40 金币出售更多。",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens"] = "银色黎明勇气勋章",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Corruptor's Scourgestones and dungeons to Revered"] = "用堕落者的天灾石和地下城刷到崇敬",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "这里的黑暗教徒和暗影法师（58-60级）掉落侵略者的天灾石，还有爪牙的天灾石和{item:14047}。把侵略者的天灾石每10个、爪牙的天灾石每20个交给{area:2268}的{npc:11039}。在经典版中，两者到尊敬后就不再给声望。",
	-- ["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "从尊敬开始，声望来自堕落者的天灾石（每次交还一个）和在{area:2279}、{area:2057}中击杀天灾军团。堕落者的天灾石由那里的天灾首领（{npc:1853}、{npc:10433}、维克图斯）以及{zone:1422}的{npc:1852}和普特迪乌斯掉落。多刷地下城比任何野外刷怪都快。",
	-- ["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:152}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "{zone:1422}各处的食尸鬼和骷髅约有一半几率掉落爪牙的天灾石；这一片怪物密集。每20个交给任意一位银色黎明军官（{area:3197}的普尔哈特、{area:152}的加鲁什、{area:2268}的{npc:11039}）。每次交还还会得到一枚{item:12844}，可在银色黎明军需官处使用。",
	-- ["Invader's Scourgestones to Honored"] = "用侵略者的天灾石刷到尊敬",
	-- ["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "继续刷{area:2279}和{area:2057}，并在{area:2268}交还每一个{item:12843}，直到崇拜。",
	-- ["Minion's Scourgestones to Friendly"] = "用爪牙的天灾石刷到友善",
	-- ["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "刷{area:2279}（两个区域）和{area:2057}，击杀沿途所有天灾军团。",
	-- ["The Plaguelands quests pay in full at 60 from level 55 up and never stop counting, about 1,500 in all; the leveling guides walk them. The cauldron chain from {npc:11053} at {area:3197} (Horde: {npc:11055} at the {area:152}): 150 per cauldron with its return ({area:199}'s pair is level 53: in Classic it pays three fifths at 60), then Mission Accomplished! 200. Alas, Andorhal 150 ({npc:1852}, elite). At {area:2268}, {npc:11063}'s {area:2262} quests (Brother Carlin 50 from Chromie in Andorhal, Villains of Darrowshire 100, Marauders of Darrowshire 100) and {npc:10926}'s Hidden Treasures 200 at the end of the {area:2262} story; {npc:12250} 75 from {npc:11038}. After Mission Accomplished!, each cauldron takes a repeatable delivery: 25 reputation every time, until Exalted. {npc:11056} at {area:3197} (Horde: {npc:11057} at the {area:152}) gives you a {item:13370}, without which the reagents never drop, and sells Arcane Quickeners for 50 silver (one per delivery; it crumbles after 30 minutes, so buy it last). Each delivery also takes 4 {item:14047}. Farm {area:201}: its ghosts drop an {item:13354} about one time in four, so about 16 kills fill a delivery; the other cauldrons want 5 or 6 reagents that drop one time in ten or less. Once the Plaguelands Scourge stop counting, this earns about four times what their Scourgestones alone do."] = "瘟疫之地中55级及以上的任务，到60级仍会提供完整声望，而且始终有效，合计约1,500点；练级指南会带你完成。{area:3197} 的 {npc:11053}（部落为 {area:152} 的 {npc:11055}）提供瘟疫之锅任务线：每口锅连同回报任务合计150点（{area:199} 的两个任务为53级：经典版中，60级只奖励五分之三），最后“任务完成！”奖励200点。“啊，安多哈尔！”奖励150点（{npc:1852}，精英）。{area:2268} 的 {npc:11063} 提供 {area:2262} 的任务（安多哈尔克罗米提供的“卡林·雷德帕斯”奖励50点，“达隆郡的恶魔”100点，“达隆郡的掠夺者”100点），{npc:10926} 在 {area:2262} 故事末尾提供的“隐藏的宝藏”奖励200点；{npc:11038} 提供的 {npc:12250} 奖励75点。完成“任务完成！”后，每口锅都可重复交付材料：每次25点声望，直到崇拜。{area:3197} 的 {npc:11056}（部落为 {area:152} 的 {npc:11057}）会给你 {item:13370}，没有它就不会掉落试剂；还会以50银币出售奥术催化剂（每次交付需要一个；30分钟后消失，因此最后再买）。每次交付还需要4块 {item:14047}。建议刷 {area:201}：那里的幽灵约每四只掉落一个 {item:13354}，因此约16次击杀就能凑够一次交付；其他锅需要5或6份试剂，而掉率仅为十分之一或更低。瘟疫之地的天灾怪不再直接提供声望后，这种方法的收益约为单交它们的天灾石的四倍。",
	-- ["{faction:529} to Exalted"] = "{faction:529}刷到崇拜",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:152} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}初始为中立。从{area:152}的{npc:10839}处领取委任徽章并装备：在经典版中，只有装备了{quest:5401}饰品时才会掉落天灾石。Forever的传承外交官特权可提高声望获取。",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}初始为中立。从{area:3197}的{npc:10840}处领取委任徽章并装备：在经典版中，只有装备了{quest:5401}饰品时才会掉落天灾石。Forever的传承外交官特权可提高声望获取。",
}
