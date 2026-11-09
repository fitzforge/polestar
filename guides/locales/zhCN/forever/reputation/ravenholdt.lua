-- Chinese (simplified) (zhCN): the guide forever/reputation/ravenholdt (forever/reputation/ravenholdt.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt Reputation"] = "拉文霍德声望",
	["The assassins' guild: Forever's new rogue quests, then Syndicate kills and Heavy Junkboxes to Exalted."] = "刺客公会：先做无限新增的潜行者任务，然后击杀辛迪加成员并上交沉重的垃圾箱，直到崇拜。",
	-- {faction:349} Ravenholdt
	["{faction:349} reputation (no vendor or reward in Forever's data)"] = "{faction:349}声望（无限数据中没有商人或奖励）",

	-- Step 1: The Manor, Ravenholdt
	-- {item:17126} Elegant Letter · {area:275} Durnholde Keep · {npc:6707} Fahrad
	["Rogues from level 24: ask your class trainer in a capital \"May I have it, please?\" for the {item:17126}, and read it. The path up to the manor starts in the hills north of {area:275}. In the tunnel on the way lies a chest: do not open it (an elite guard jumps out), just walk past it to earn the Rite of Cunning. {npc:6707} waits on the manor's balcony."] = "潜行者 24 级起：向主城的职业训练师选择“可以给我一份吗？”，领取并阅读 {item:17126}。通往庄园的上山小路起于 {area:275} 北边的山中。沿途隧道里有一个箱子：不要打开（会跳出一名精英守卫），直接走过就能完成狡诈仪式。{npc:6707} 在庄园阳台等候。",
	-- {item:17126} Elegant Letter
	["{item:17126}, from your class trainer"] = "{item:17126}，向你的职业训练师获取。",
	["walk past the trapped chest in the tunnel"] = "走过隧道中设有陷阱的宝箱。",
	-- {npc:6707} Fahrad
	["{npc:6707}: 100 reputation"] = "{npc:6707}：100 点声望",

	-- Step 2: Myrokos Silentform
	-- {npc:13085} Myrokos Silentform · {quest:96779} Syndicate Sabotage · {quest:96781} What's the Big Idea? · {quest:96782} Covert Extraction · {quest:96786} The Syndicate Sting · {quest:96783} A Way In · {item:5140} Flash Powder
	["{npc:13085}, in the manor, has Forever's new rogue quests: 100 reputation each for {quest:96779}, {quest:96781} and {quest:96782}, which follows it, and 300 for {quest:96786} at the end of the Stromgarde chain ({quest:96783} and the two quests after it pay nothing). All can be done solo with stealth from level 30; below that, the Master of Deception talent and a {item:5140} for Vanish help."] = "庄园内的 {npc:13085} 提供无限服新增的潜行者任务：{quest:96779}、{quest:96781} 及其后续 {quest:96782} 各给100声望，激流堡任务链末尾的 {quest:96786} 给300（{quest:96783} 及之后的两个任务不给声望）。30级起可通过潜行独自完成全部任务；低于30级时，欺诈高手天赋和用于消失的 {item:5140} 会有帮助。",

	-- Step 3: Durnholde Keep: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {area:271} Southshore
	["{npc:266216} is inside {area:275}, the Syndicate fortress east of {area:271}. Stealth past the guards in the courtyard."] = "{npc:266216} 在 {area:271} 以东的辛迪加堡垒 {area:275} 内。潜行绕过庭院里的守卫。",

	-- Step 4: Strahnbrad: Barton
	-- {area:280} Strahnbrad
	["{area:280}: Barton"] = "{area:280}：巴顿",
	-- {area:280} Strahnbrad
	["Barton hides in a house in {area:280}, among stealthed Syndicate. Pick his pocket for the report; Distract turns him around if you are under his level."] = "巴顿 藏在 {area:280} 的一栋房屋里，周围是潜行的辛迪加成员。对他使用偷窃取得报告；如果等级比他低，可用扰乱让他转身。",
	-- {item:275482} Barton's Scouting Report
	["{item:275482}: pickpocket Barton"] = "{item:275482}：对巴顿使用偷窃",

	-- Step 5: Northfold Manor: a uniform
	-- {area:313} Northfold Manor
	["{area:313}: a uniform"] = "{area:313}：一套制服",
	-- {object:656157} Syndicate Footlocker (no name in this language: may be words) · {area:313} Northfold Manor · {quest:96783} A Way In · {item:275706} Syndicate Uniform
	["The {object:656157} stands among the Syndicate camps of {area:313}, north of Stromgarde. Open it to finish {quest:96783} and take the {item:275706}."] = "{object:656157} 位于激流堡以北 {area:313} 的辛迪加营地之间。打开它，完成 {quest:96783} 并取得 {item:275706}。",

	-- Step 6: Stromgarde: Anastasia Miller
	-- {npc:266847} Anastasia Miller
	["Stromgarde: {npc:266847}"] = "激流堡：{npc:266847}",
	-- {item:275706} Syndicate Uniform · {npc:266847} Anastasia Miller
	["Put on the {item:275706} and go into Stromgarde. {npc:266847} waits on a ledge just outside the castle; players reach her by jumping from the roof of the house beside the ledge. Her stash is upstairs in a house near the keep."] = "穿上{item:275706}后进入激流堡。{npc:266847}在城堡外侧的一处台沿等候；玩家可从台沿旁房屋的屋顶跳过去。她的藏品在要塞附近一栋房子的楼上。",
	-- {item:275709} Stolen Funds
	["{item:275709}, in Anastasia's Stash upstairs"] = "{item:275709}，在她位于楼上的藏匿处内",

	-- Step 7: Thoradin's Wall: the shipment
	-- {area:1057} Thoradin's Wall
	["{area:1057}: the shipment"] = "{area:1057}：货物",
	-- {area:1057} Thoradin's Wall · {zone:1417} Arathi Highlands · {item:275882} Intercepted Shipment · {npc:13085} Myrokos Silentform
	["The hand-off is at the southern end of {area:1057}, in the west of the {zone:1417}: two Syndicate guard the box. Kill them or lure them off, then take the {item:275882}. Keep the uniform: {npc:13085} wants it back."] = "交接地点在{zone:1417}西部{area:1057}的南端：两个辛迪加成员守着箱子。杀掉或引开他们，然后取走{item:275882}。保留制服：{npc:13085}会收回。",

	-- Step 8: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "回到{npc:13085}处",
	-- {quest:96782} Covert Extraction · {quest:96781} What's the Big Idea?
	["{quest:96782}, after {quest:96781}"] = "{quest:96782}，在 {quest:96781} 之后",

	-- Step 9: Ruins of Alterac: the Perenolde heirlooms
	-- {area:281} Ruins of Alterac
	["{area:281}: the Perenolde heirlooms"] = "{area:281}：匹瑞诺德的传家宝",
	-- {area:281} Ruins of Alterac · {zone:1416} Alterac Mountains
	["The two heirlooms lie in two towers of the {area:281}, the ogre-held ruin in the middle of the {zone:1416}. The tower with the sword is ringed by elite ogres: stay in stealth. Neither item is guarded once you are inside."] = "两件传家宝位于{zone:1416}中部、被食人魔占据的废墟{area:281}中的两座塔内。放剑的塔周围有精英食人魔：保持潜行。进入塔内后，两件物品都无人看守。",
	-- {item:275636} Royal Aegis of Perenolde
	["{item:275636}, the shield"] = "{item:275636}，盾牌",
	-- {item:275635} Blade of House Perenolde
	["{item:275635}, the sword"] = "{item:275635}，那把剑",

	-- Step 10: Syndicate Emblems to Friendly
	-- {quest:6701} Syndicate Emblems
	["{quest:6701} to Friendly"] = "交还{quest:6701}至友善",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	-- plural, as words: Syndicate Prowlers = {npc:2588} Syndicate Prowler
	["Neutral to Friendly is 3,000 reputation; the quests above pay 700 of it. Any {npc:6766} on the path takes {quest:6701}, 100 reputation each, until you reach Friendly: 23 emblems after the quests. Pick the pockets of Syndicate humans; they never drop emblems when killed. The Arathi camps pay best: Syndicate Prowlers and Conjurors carry one about a quarter of the time. Kill what you have robbed so the next ones respawn fresh."] = "中立到友善需要3,000声望；上面的任务奖励700。路上的任意{npc:6766}都接受{quest:6701}，每次100声望，直到友善：做完任务后需23枚徽章。偷窃辛迪加人类的口袋；杀死他们从不掉徽章。阿拉希营地最划算：辛迪加潜伏者和召唤师约有四分之一携带徽章。偷完后杀掉，让下一批刷新时口袋里有新东西。",
	-- {item:17124} Syndicate Emblem
	["{item:17124}: pickpocket Syndicate"] = "{item:17124}：偷窃辛迪加成员",
	-- {npc:6766} Ravenholdt Guard
	["a {npc:6766}: 100 per emblem"] = "{npc:6766}：每枚徽记100点",

	-- Step 11: Syndicate kills to the end of Honored
	["Syndicate kills to the end of Honored"] = "击杀辛迪加，直到尊敬满",
	-- {faction:349} Ravenholdt · {zone:1416} Alterac Mountains
	-- plural, as words: Syndicate Assassins = {npc:2246} Syndicate Assassin
	["Everyone, not only rogues: in Classic every Syndicate human gave {faction:349} 5 reputation up to the end of Honored (11,999 of 12,000) and not one point more, so 0 to there is 4,200 kills (3,600 after a rogue's quests and emblems). This step ticks at Honored; keep killing until the bar stops moving, then go on to the junkboxes. The highest Syndicate are in the north-west of the {zone:1416}, Syndicate Assassins and Enforcers (level 38-40), with Syndicate Sentries (36-37) nearer the middle. At 60 all Syndicate are grey, and in Classic grey kills gave about a fifth: farm them before 48 if you can. Legacy Diplomat adds up to 10%."] = "所有职业都可做，不限盗贼：经典版每杀一个辛迪加人类可获5点{faction:349}声望，最多到尊敬末尾（11,999/12,000），之后一点都没有，因此从0开始共需击杀4,200名（盗贼做完任务和交徽章后需3,600名）。此步骤在尊敬时勾选；继续杀到声望条不再增长，再去交垃圾箱。等级最高的辛迪加在{zone:1416}西北部，是辛迪加刺客和执行者（38-40级），中部附近有辛迪加哨兵（36-37级）。60级时所有辛迪加都是灰色，经典版灰色击杀仅奖励约五分之一：尽量在48级以前刷。传承的外交家最多增加10%。",
	-- {npc:2246} Syndicate Assassin
	["{npc:2246}, level 38-39"] = "{npc:2246}，38—39级",
	-- {npc:2247} Syndicate Enforcer
	["{npc:2247}, level 39-40"] = "{npc:2247}，39-40 级。",
	-- {npc:2243} Syndicate Sentry
	["{npc:2243}, level 36-37"] = "{npc:2243}，36-37 级",

	-- Step 12: A Simple Request, rogues 50+
	-- {quest:8233} A Simple Request
	["{quest:8233}, rogues 50+"] = "{quest:8233}，50级及以上盗贼",
	-- {npc:6768} Lord Jorach Ravenholdt · {quest:8234} Sealed Azure Bag · {zone:1447} Azshara · {quest:8235} Encoded Fragments · {quest:8236} The Azure Key · {area:1477} Temple of Atal'Hakkar
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman · Forest Oozes = {npc:8766} Forest Ooze
	["At level 50 your class trainer has another letter for you, and {npc:6768} a short chain: 360 reputation in all. The {quest:8234} drops from Timbermaw Shamans in northern {zone:1447} (about 1 in 27, or pick their pockets); the {quest:8235} from Forest Oozes in {zone:1447} (4 in 5). {quest:8236} comes from Morphaz, an elite drake deep in the {area:1477}: a five-player dungeon, group up."] = "50 级时，职业训练师会再给你一封信，{npc:6768} 也有一条简短任务链：总共 360 点声望。{quest:8234} 由 {zone:1447} 北部的木喉萨满祭司掉落（约二十七分之一，也可以偷窃）；{quest:8235} 由 {zone:1447} 的森林软泥怪掉落（五分之四）。{quest:8236} 来自 {area:1477} 深处的精英幼龙摩弗拉斯：这是五人地下城，要组队。",
	-- {quest:8234} Sealed Azure Bag
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["{quest:8234}: Timbermaw Shamans"] = "{quest:8234}：木喉萨满祭司。",
	-- {item:20023} Encoded Fragment
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["{item:20023}: Forest Oozes"] = "{item:20023}：森林软泥怪",
	-- {item:20022} Azure Key · {area:1477} Temple of Atal'Hakkar
	["{item:20022}: Morphaz, {area:1477} (group)"] = "{item:20022}：摩弗拉斯，{area:1477}（组队）",

	-- Step 13: Heavy Junkboxes to Exalted
	["Heavy Junkboxes to Exalted"] = "交还重垃圾箱至崇拜",
	-- {quest:8249} Junkboxes Needed · {npc:6707} Fahrad · {item:20086} Dusksteel Throwing Knife · {area:1583} Blackrock Spire · {area:1584} Blackrock Depths
	["From the top of Honored to Exalted is 21,001 reputation, and {quest:8249} is the only way: {npc:6707} pays 50 and a {item:20086} for every five Heavy Junkboxes (Classic Era paid 75), 421 turn-ins and 2,105 boxes. Boxes count at any standing, so take the cheap kills to their cap first. Any class can hand them in. Rogues get them by picking the pockets of humanoids around level 50 and up: Lower {area:1583} and {area:1584} are the classic spots, pick every pocket, reset and go again. The boxes do not bind, so everyone else buys them from rogues or at the auction house. Hand them in unopened; an opened box you empty vanishes, so leave one item in it."] = "尊敬满到崇拜需要 21,001 点声望，唯一途径是 {quest:8249}：{npc:6707} 每收取五个重垃圾箱，奖励 50 点声望和一个 {item:20086}（经典旧世为 75 点），共需交还 421 次、2,105 个箱子。任何声望阶段都能交箱子，所以先靠便宜的击杀声望刷到上限。任何职业都能交还。潜行者可从约 50 级及以上的人型生物身上偷到：{area:1583} 下层和 {area:1584} 是经典地点，逐个偷遍、重置，再来一遍。箱子不绑定，其他职业可向潜行者购买，或去拍卖行购买。交还时不要打开；开过的箱子如果取空就会消失，因此要在里面留一件物品。",
	-- {item:16885} Heavy Junkbox · {area:1445} Blackrock Mountain
	["{item:16885}: pickpocket level 50+ humanoids, {area:1445}"] = "{item:16885}：对50级以上人型生物使用偷窃，地点为 {area:1445}",
	-- {npc:6707} Fahrad
	["{npc:6707}: 50 per five boxes"] = "{npc:6707}：每五个箱子换 50 点声望",
}
