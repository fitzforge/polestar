-- Chinese (traditional) (zhTW): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "銀色黎明聲望",
	-- {area:2057} Scholomance · {area:2279} Stratholme
	["Scourgestones, {area:2057} and {area:2279}: the shoulder resistance enchants and a dozen recipes."] = "天災石、{area:2057}和{area:2279}：肩部抗性附魔和十幾種配方。",
	["Recipes for Tailors, Leatherworkers, Blacksmiths, Enchanters and Alchemists from Honored and Revered"] = "尊敬和崇敬時可獲得裁縫、制皮、鍛造、附魔和鍊金術配方",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401}（聯盟）",
	-- {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10840} stands in {area:3197}, in the south of the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10840}站在{area:3197}，在{zone:1422}南部。{object:2160}對所有人從中立200開始。打天災時戴上委任狀飾品：只有戴著它天災石才會掉落。{area:2268}的{npc:11039}給同樣的委任狀；你只能拿一個。",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5405} Argent Dawn Commission
	["{quest:5405} (Horde)"] = "{quest:5405}（部落）",
	-- {npc:10839} Argent Officer Garush · {area:152} Bulwark · {zone:1420} Tirisfal Glades · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10839} stands at the {area:152}, on the road from {zone:1420} into the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10839}站在{area:152}，位於從{zone:1420}進入{zone:1422}的路上。{object:2160}對所有人從中立200開始。打天災時戴上委任狀飾品：只有戴著它天災石才會掉落。{area:2268}的{npc:11039}給同樣的委任狀；你只能拿一個。",

	-- Step 3: Neutral to Friendly: Scourge of the Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Neutral to Friendly: Scourge of the {zone:1422}"] = "中立到友善：{zone:1422}的天災",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {area:202} Writhing Haunt · {area:201} Gahrron's Withering · {quest:5510} Minion's Scourgestones · {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Every Scourge kill in the Plaguelands gives 5 reputation (named ones 15), from the level 50 ghouls and skeletons up; at level 60 pick the level 53 and up ones, since in Classic grey mobs give only about a fifth. Neutral to Friendly is 2,800: about 560 kills, fewer with the Plaguelands quests on the way. The densest Scourge stand around the four Scourge Cauldrons: {area:199} west of Andorhal (skeletons, 50-53), {area:200} north of Andorhal (zombies and ghouls, 52-55), the {area:202} in the south (ghouls, 54-55) and {area:201} in the east (ghosts, 56-57). Keep every Scourgestone and every quest you can save: turn-ins never stop counting, kills do. {quest:5510} drop from about four in ten of these Scourge, Invader's from about a third of the level 56 and up ones. If you die, take the Commission off and put it back on: it can lose its effect. Paladins (Human and Dwarf): {npc:10838} at {area:3197} asks 20 {quest:5510} once for Dispelling Evil, 100 reputation instead of 25. The Legacy perk Diplomat adds up to 10% to every gain."] = "在瘟疫之地每殺一個天災給5聲望（具名的給15），從50級的食屍鬼和骷髏起；60級時挑53級及以上的，因為經典舊世中灰色怪物只給約五分之一。中立到友善需2,800：約560殺，路上做瘟疫之地任務會更少。天災最密集的地方在四口天災瘟疫鍋周圍：安多哈爾以西的{area:199}（骷髏，50-53）、安多哈爾以北的{area:200}（殭屍和食屍鬼，52-55）、南部的{area:202}（食屍鬼，54-55）和東部的{area:201}（鬼魂，56-57）。每塊天災石和每個能攢的任務都留著：交付永遠算數，殺怪則不然。這些天災約十分之四掉{quest:5510}，56級及以上的約三分之一掉入侵者之天災石。若你死了，把委任狀摘下來再戴上：它可能失效。聖騎士（人類和矮人）：{area:3197}的{npc:10838}會一次性索要20個{quest:5510}，換取“驅除邪惡”，給100聲望而非25。傳承特長“外交家”使所有獲取提高最多10%。",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: keep them"] = "{quest:5510}：留著",
	-- {area:201} Gahrron's Withering
	-- plural, as words: Hungering Wraiths = {npc:1802} Hungering Wraith
	["Hungering Wraiths at {area:201}; any Scourge counts"] = "{area:201}的飢餓怨靈；任何天災都算",
	-- {area:202} Writhing Haunt
	-- plural, as words: Soulless Ghouls = {npc:1794} Soulless Ghoul
	["Soulless Ghouls at the {area:202}"] = "{area:202}的無魂食屍鬼",

	-- Step 4: Plaguelands quests and the Scourge Cauldrons
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Plaguelands quests and the Scourge Cauldrons"] = "瘟疫之地任務與天災瘟疫鍋",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {npc:11055} Shadow Priestess Vandis · {area:152} Bulwark · {npc:1852} Araj the Summoner · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:12250} Zaeldarr the Outcast · {npc:11038} Caretaker Alen · {npc:11056} Alchemist Arbington · {npc:11057} Apothecary Dithers · {item:13370} Vitreous Focuser · {item:14047} Runecloth · {area:201} Gahrron's Withering · {item:13354} Ectoplasmic Resonator
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["The Plaguelands quests pay in full at 60 from level 55 up and never stop counting, about 1,500 in all; the leveling guides walk them. The cauldron chain from {npc:11053} at {area:3197} (Horde: {npc:11055} at the {area:152}): 150 per cauldron with its return, then Mission Accomplished! 200. Alas, Andorhal 150 ({npc:1852}, elite). At {area:2268}, {npc:11063}'s {area:2262} quests (Brother Carlin 50 from Chromie in Andorhal, Villains of Darrowshire 100, Marauders of Darrowshire 100) and {npc:10926}'s Hidden Treasures 200 at the end of the {area:2262} story; {npc:12250} 75 from {npc:11038}. After Mission Accomplished!, each cauldron takes a repeatable delivery: 25 reputation every time, until Exalted. {npc:11056} at {area:3197} (Horde: {npc:11057} at the {area:152}) gives you a {item:13370}, without which the reagents never drop, and sells Arcane Quickeners for 50 silver (one per delivery; it crumbles after 30 minutes, so buy it last). Each delivery also takes 4 {item:14047}. Farm {area:201}: its ghosts drop an {item:13354} about one time in four, so about 16 kills fill a delivery; the other cauldrons want 5 or 6 reagents that drop one time in ten or less. Once the Plaguelands Scourge stop counting, this earns about four times what their Scourgestones alone do."] = "瘟疫之地的任務從55級起在60級足額給分，而且一直計入，總共約1,500點；練級指南會走過它們。{area:3197}的{npc:11053}（部落：{area:152}的{npc:11055}）的大鍋任務鏈：每口大鍋連同交回給150點，然後是“任務完成！”200點。“唉，安多哈爾”150點（{npc:1852}，精英）。在{area:2268}，{npc:11063}的{area:2262}任務（從安多哈爾的克羅米處接的“卡林修士”50點、“達隆郡的惡徒”100點、“達隆郡的掠奪者”100點）和{area:2262}故事結尾{npc:10926}的“隱藏的寶藏”200點；{npc:11038}處的{npc:12250} 75點。“任務完成！”之後，每口大鍋接受一次可重複交付：每次25點聲望，直到崇拜。{area:3197}的{npc:11056}（部落：{area:152}的{npc:11057}）會給你一個{item:13370}，沒有它材料就不會掉，他還賣50銀的奧術快速劑（每次交付一瓶；30分鐘後失效，所以最後再買）。每次交付還要4塊{item:14047}。刷{area:201}：那裡的幽靈大約四次掉一個{item:13354}，所以約16次擊殺就夠一次交付；其他大鍋要5或6個材料，掉率十分之一或更低。瘟疫之地的天災怪停止計分之後，這條路線的收益大約是隻交天災石的四倍。",
	-- {npc:11056} Alchemist Arbington · {item:13370} Vitreous Focuser
	["{npc:11056}: ask for a {item:13370}"] = "{npc:11056}：索要{item:13370}",
	-- {npc:11057} Apothecary Dithers · {area:152} Bulwark · {item:13370} Vitreous Focuser
	["{npc:11057}, at the {area:152}: ask for a {item:13370}"] = "{npc:11057}，在{area:152}：索要{item:13370}",
	-- plural, as words: Ectoplasmic Resonators = {item:13354} Ectoplasmic Resonator
	["Ectoplasmic Resonators: the ghosts around the cauldron"] = "靈質共振器：瘟疫鍋周圍的鬼魂",
	-- {item:13320} Arcane Quickener
	["{item:13320}, 50 silver"] = "{item:13320}，50銀",
	-- {area:201} Gahrron's Withering
	["the cauldron at {area:201}: handed in from its window, never in the log"] = "{area:201}的大鍋：在它的視窗中直接繳交，不會出現在任務日誌中",

	-- Step 5: Light's Hope Chapel quests
	-- {area:2268} Light's Hope Chapel
	["{area:2268} quests"] = "{area:2268}的任務",
	-- {area:2268} Light's Hope Chapel · {zone:1423} Eastern Plaguelands · {faction:529} Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {npc:11035} Betina Bigglezink · {npc:243252} Leonid Barthalomew · {area:2279} Stratholme · {area:2057} Scholomance · {object:176317} Argent Hold
	["{area:2268}, on the east side of the {zone:1423}, is the {faction:529}'s home: {npc:11039}, {npc:11035} and {npc:243252} give its dungeon quests, 100 to 200 reputation each and about 1,700 in all. They are group quests for {area:2279} and {area:2057} (level 58-60, five players): take the ones your group will run. The Duke's chain ends at the {object:176317}, a chest of {faction:529} gear."] = "",

	-- Step 6: Stratholme
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare · {item:12843} Corruptor's Scourgestone
	["{area:2279} is a group of five at the north end of the {zone:1423}. Its Scourge give 5 reputation a kill up to the last point of Honored, and its Scourge bosses 25 until Exalted ({npc:10440} 50), each with a {item:12843}. The Black Guard Sentries by the Baron give 5 until Exalted. The Scourge side, through the service entrance, pays far more than the Scarlet side."] = "{area:2279}是{zone:1423}北端的五人副本。其中的天災每殺一個給5聲望，直到尊敬最後一點；天災首領給25直到崇拜（{npc:10440}給50），每人還掉一塊{item:12843}。男爵身邊的黑衛哨兵給5直到崇拜。走服務入口進去的天災一側，收益遠高於血色一側。",
	-- plural, as words: Plagued Flesh Samples = {item:13174} Plagued Flesh Sample
	["Plagued Flesh Samples: the Scourge inside"] = "瘟疫血肉樣本：裡面的天災",
	-- {item:13180} Stratholme Holy Water
	["{item:13180}: the supply crates"] = "{item:13180}：補給箱",
	-- {npc:10811} Archivist Galford
	["{npc:10811}, Scarlet side"] = "{npc:10811}，血色一側",

	-- Step 7: Scholomance
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {faction:529} Argent Dawn · {quest:5508} Corruptor's Scourgestones · {npc:10508} Ras Frostwhisper · {npc:1853} Darkmaster Gandling
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; your side's {area:2057} quests give the {item:13704} that opens it. It is the best {faction:529} run: its mobs give 5 up to the last point of Honored, and its thirteen bosses about 375 reputation a full clear plus ten or so {quest:5508} (about 250 more). {npc:10508} and {npc:1853} give 50 each."] = "{area:2057}位於{area:2298}之下，那是{zone:1422}東南的島嶼城鎮；你方陣營的{area:2057}任務會給開啟它的{item:13704}。這是刷{faction:529}最好的副本：其中的怪物一直給5點直到尊敬最後一點，十三個首領一次全清約375聲望，外加十來個{quest:5508}（再多約250）。{npc:10508}和{npc:1853}各給50。",
	-- {quest:5529} Plagued Hatchlings
	["{quest:5529}, in the hatchery"] = "{quest:5529}，在孵化間",

	-- Step 8: Back at Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back at {area:2268}"] = "回到{area:2268}",
	-- {quest:5212} The Flesh Does Not Lie · {quest:5213} The Active Agent · {item:13176} Scourge Data · {area:2279} Stratholme · {item:13209} Seal of the Dawn · {item:19812} Rune of the Dawn · {quest:5251} The Archivist · {item:13250} Head of Balnazzar · {npc:10440} Baron Rivendare · {item:13920} Healthy Dragon Scale · {quest:5529} Plagued Hatchlings · {npc:10267} Tinkee Steamboil · {zone:1428} Burning Steppes · {area:1583} Blackrock Spire · {npc:243252} Leonid Barthalomew · {npc:11035} Betina Bigglezink · {item:12368} Dawn's Gambit · {area:2057} Scholomance
	["{quest:5212} leads to {quest:5213} (the {item:13176} in a {area:2279} ziggurat), which rewards the {item:13209} or the {item:19812}: better trinkets that also make Scourgestones drop, so they can replace the Commission. {quest:5251} leads on to the {item:13250} and {npc:10440}. A {item:13920}, a rare drop (about 6%) from the {quest:5529} once {quest:5529} is done, starts a quest worth 50 each time: keep them until Revered. {npc:10267} in the {zone:1428}, at the end of her {area:1583} quests, sends you to {npc:243252} (75) and on to {npc:11035}'s {item:12368} in {area:2057} (25 and 200)."] = "",

	-- Step 9: Friendly to Honored: stones and named Scourge
	["Friendly to Honored: stones and named Scourge"] = "友善到尊敬：石頭與具名天災",
	-- {npc:10826} Lord Darkscythe · {npc:10821} Hed'mush the Rotting · {npc:10825} Gish the Unmoving · {area:2057} Scholomance · {area:2279} Stratholme · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {area:3197} Chillwind Camp · {area:152} Bulwark · {item:12844} Argent Dawn Valor Token · {quest:5509} Invader's Scourgestones · {area:2272} Northdale · {item:12843} Corruptor's Scourgestone · {npc:1850} Putridius
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage · Dread Weavers = {npc:8528} Dread Weaver · Scourge Champions = {npc:8529} Scourge Champion · Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Normal Scourge outside the dungeons stop giving reputation halfway through Friendly (3,000 of 6,000); {npc:10826}, {npc:10821} and {npc:10825} stop at the end of Friendly. After that only Araj, the {area:2057} and {area:2279} mobs, the cauldron deliveries and Scourgestones count. Now turn in the stones you saved: {npc:11039} at {area:2268} takes all three kinds, and so do the officers at {area:3197} and the {area:152}. Every turn-in pays 25 and an {item:12844}: keep 35 tokens for the mantles at Revered and Exalted. {quest:5509} are worth twice as much per stone: the Dark Adepts, Shadowmages, Dread Weavers and Scourge Champions (level 58-60) at {area:2272}, just north of {area:2268}, drop them about a third of the time or more, next to the turn-in. The named Scourge below drop a {item:12843} half the time or more ({npc:1850} two times in three, Araj and {npc:10821} half the time) and give 15 a kill, Araj until Exalted; {npc:1850} gives no reputation, only the stone. Friendly opens the Enriched Manna Biscuits (60 silver) at the quartermasters."] = "副本外的普通天災在友善過半時（6,000中的3,000）就不再給聲望；{npc:10826}、{npc:10821}和{npc:10825}在友善結束時停止。此後只有阿拉基、{area:2057}和{area:2279}的怪物、瘟疫鍋交付和天災石算數。現在把攢下的石頭交掉：{area:2268}的{npc:11039}收全部三種，{area:3197}和{area:152}的軍官也一樣。每次交付給25聲望和一枚{item:12844}：留35枚勳章換崇敬和崇拜時的斗篷。{quest:5509}每塊石頭價值翻倍：{area:2268}正北方{area:2272}的黑暗專家、暗影法師、恐懼編織者和天災勇士（58-60級）約三分之一或更高几率掉落，就在交付點旁邊。下列具名天災有一半或更高几率掉{item:12843}（{npc:1850}三分之二，阿拉基和{npc:10821}一半），每殺一個給15聲望，阿拉基直到崇拜；{npc:1850}不給聲望，只給石頭。友善時軍需官開放強化瑪納餅乾（60銀）。",
	-- {item:12843} Corruptor's Scourgestone
	["{item:12843}: the named Scourge below, and dungeon bosses"] = "{item:12843}：下列有名字的天譴軍，以及地城首領",
	-- {area:2272} Northdale
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage
	["Dark Adepts and Shadowmages at {area:2272}"] = "{area:2272}的黑暗專家和暗影法師",
	-- {npc:1852} Araj the Summoner
	["{npc:1852}, Andorhal"] = "{npc:1852}，安多哈爾",
	-- {npc:1850} Putridius · {zone:1422} Western Plaguelands
	["{npc:1850}, {zone:1422}: the stone only"] = "{npc:1850}，{zone:1422}：只有石頭",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: 20 for 25 reputation"] = "{quest:5510}：20個換25聲望",
	-- {quest:5509} Invader's Scourgestones
	["{quest:5509}: 10 for 25 reputation"] = "{quest:5509}：10個換25聲望",
	-- {quest:5508} Corruptor's Scourgestones
	["{quest:5508}: 1 for 25 reputation"] = "{quest:5508}：1個換25聲望",

	-- Step 10: Honored to Revered: dungeons and stones
	["Honored to Revered: dungeons and stones"] = "尊敬到崇敬：副本與石頭",
	-- {area:2057} Scholomance · {area:2279} Stratholme · {quest:5509} Invader's Scourgestones · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:10856} Argent Quartermaster Hasana · {area:152} Bulwark · {item:22014} Hallowed Brazier
	["Honored to Revered is 12,000: about 2,400 {area:2057} and {area:2279} mobs, fewer with their bosses. Their mobs stop at 11,999 of 12,000 Honored; a boss or a turn-in takes you over. Solo, only Scourgestones, the cauldron deliveries and Araj count: 12,000 is 480 turn-ins, or 4,800 {quest:5509}. Keep the stones you get in the dungeons until their mobs stop counting. Honored opens recipes at all three quartermasters: {npc:11536} at {area:2268}, {npc:10857} at {area:3197}, {npc:10856} at the {area:152}. Also the {item:22014} (133 gold) for the Three Kings of Flame quest."] = "尊敬到崇敬需12,000：約2,400個{area:2057}和{area:2279}的怪物，加上它們的首領會更少。它們的怪物在尊敬11,999/12,000時停止；一個首領或一次交付就能帶你越線。單刷時只有天災石、瘟疫鍋交付和阿拉基算數：12,000等於480次交付，或4,800個{quest:5509}。把副本里拿到的石頭留到其中的怪物停止計數。尊敬開放三位軍需官的配方：{area:2268}的{npc:11536}、{area:3197}的{npc:10857}、{area:152}的{npc:10856}。還有“烈焰三王”任務所需的{item:22014}（133金）。",
	-- {item:19446} Formula: Enchant Bracer - Mana Regeneration
	["{item:19446}, 3 gold"] = "{item:19446}，3金",
	-- {item:19216} Pattern: Argent Boots · {skill:197} Tailoring
	["{item:19216} ({skill:197}), 2 gold 20 silver"] = "{item:19216}（{skill:197}），2金20銀",
	-- {item:19328} Pattern: Dawn Treaders · {skill:165} Leatherworking
	["{item:19328} ({skill:165}), 2 gold 20 silver"] = "{item:19328}（{skill:165}），2金20銀",
	-- {item:19203} Plans: Girdle of the Dawn · {skill:164} Blacksmithing
	["{item:19203} ({skill:164}), 2 gold 20 silver"] = "{item:19203}（{skill:164}），2金20銀",
	-- {item:13482} Recipe: Transmute Air to Fire · {skill:171} Alchemy
	["{item:13482} ({skill:171}), 1 gold 50 silver"] = "{item:13482}（{skill:171}），1金50銀",
	-- {item:19442} Formula: Powerful Anti-Venom · {skill:129} First Aid
	["{item:19442} ({skill:129}), 10 gold"] = "{item:19442}（{skill:129}），10金",

	-- Step 11: Mantles of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5513} Mantles of the Dawn · {faction:529} Argent Dawn · {item:18173} Shadow Mantle of the Dawn · {item:13810} Blessed Sunfruit
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Revered, {npc:11536} takes 10 Argent Dawn Valor Tokens for {quest:5513} (100 reputation). After it, any {faction:529} quartermaster sells the five shoulder enchants for 10 gold each: Flame, Frost, Arcane, Nature and {item:18173}, +5 to that resistance. Revered also opens the {item:13810} and its juice (60 silver) and the Revered recipes."] = "",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens, from the stone turn-ins"] = "銀色黎明勇氣勳章，來自交石頭",
	-- {item:18170} Frost Mantle of the Dawn
	["{item:18170}: pick the resistance you need, 10 gold"] = "{item:18170}：挑選你需要的抗性，10金",
	-- {item:19447} Formula: Enchant Bracer - Healing
	["{item:19447}, 6 gold"] = "{item:19447}，6金",
	-- {item:19217} Pattern: Argent Shoulders · {skill:197} Tailoring
	["{item:19217} ({skill:197}), 4 gold"] = "{item:19217}（{skill:197}），4金",
	-- {item:19329} Pattern: Golden Mantle of the Dawn · {skill:165} Leatherworking
	["{item:19329} ({skill:165}), 4 gold"] = "{item:19329}（{skill:165}），4金",
	-- {item:19205} Plans: Gloves of the Dawn · {skill:164} Blacksmithing
	["{item:19205} ({skill:164}), 4 gold"] = "{item:19205}（{skill:164}），4金",

	-- Step 12: Revered to Exalted
	["Revered to Exalted"] = "崇敬到崇拜",
	-- {quest:5508} Corruptor's Scourgestones · {area:2057} Scholomance · {item:13920} Healthy Dragon Scale
	["Revered to Exalted is 21,000: 840 Scourgestone or cauldron turn-ins, or the dungeon bosses with their {quest:5508} (a full {area:2057} clear is about 600). Turn in every stone and {item:13920} you saved."] = "崇敬到崇拜需21,000：840次天災石或瘟疫鍋交付，或用副本首領及其{quest:5508}（一次{area:2057}全清約600）。把攢下的每一塊天災石和{item:13920}都交掉。",

	-- Step 13: Chromatic Mantle of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5517} Chromatic Mantle of the Dawn
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Exalted, {npc:11536} takes 25 Argent Dawn Valor Tokens for the {quest:5517} (150 reputation): +5 to every resistance, on your shoulders. After it, the quartermasters sell more for 40 gold each."] = "崇拜時，{npc:11536}收25枚銀色黎明勇氣勳章，換取{quest:5517}（150聲望）：肩部裝備，所有抗性+5。之後，軍需官以每件40金出售更多。",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens"] = "銀色黎明勇氣勳章",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "黑暗教徒和暗影法師（58-60級）在這裡會掉落侵略者的天譴石，還有爪牙的天譴石和{item:14047}。侵略者的每次10個、爪牙的每次20個交給{area:2268}的{npc:11039}。在經典版中，兩者到尊敬後就不再提供聲望。",
	-- ["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "從尊敬開始，墮落者的天譴石（每次繳交一個）和在{area:2279}及{area:2057}擊殺天譴軍團可提升聲望。墮落者的天譴石由那裡的天譴首領（{npc:1853}、{npc:10433}、維克圖斯）以及{zone:1422}的{npc:1852}和普特迪烏斯掉落。多跑地城比任何野外刷怪都快。",
	-- ["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:152}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "{zone:1422}各處的食屍鬼和骷髏約有一半機率掉落爪牙的天譴石；這一帶很密集。每次20個交給任一銀色黎明軍官（{area:3197}的普爾哈特、{area:152}的加魯什、{area:2268}的{npc:11039}）。每次繳交也會得到一個{item:12844}，可在銀色黎明軍需官處使用。",
	-- ["Invader's Scourgestones to Honored"] = "侵略者的天譴石到尊敬",
	-- ["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "持續跑{area:2279}和{area:2057}，並在{area:2268}繳交每一個{item:12843}，直到崇拜。",
	-- ["Minion's Scourgestones to Friendly"] = "爪牙的天譴石到友好",
	-- ["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "跑{area:2279}（兩個區域）和{area:2057}，擊殺沿途每一隻天譴軍團。",
	-- ["{faction:529} to Exalted"] = "{faction:529}到崇拜",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:152} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}初始為中立。向{area:152}的{npc:10839}領取委任狀並裝備：在經典版中，只有裝備{quest:5401}飾品時才會掉落天譴石。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}初始為中立。向{area:3197}的{npc:10840}領取委任狀並裝備：在經典版中，只有裝備{quest:5401}飾品時才會掉落天譴石。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{quest:5401} (Horde)"] = "{quest:5401}（部落）",
}
