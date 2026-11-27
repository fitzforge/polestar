-- Chinese (traditional) (zhTW): the guide forever/reputation/ravenholdt (forever/reputation/ravenholdt.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt Reputation"] = "拉文霍德聲望",
	["The assassins' guild: Forever's new rogue quests, then Syndicate kills and Heavy Junkboxes to Exalted."] = "刺客公會：先做Forever新增的盜賊任務，然後擊殺辛迪加成員並上交沉重的垃圾箱，直到崇拜。",
	-- {faction:349} Ravenholdt
	["{faction:349} reputation (no vendor or reward in Forever's data)"] = "{faction:349}聲望（Forever資料中沒有商人或獎勵）",

	-- Step 1: The Manor, Ravenholdt
	-- {item:17126} Elegant Letter · {area:275} Durnholde Keep · {npc:6707} Fahrad
	["Rogues from level 24: ask your class trainer in a capital \"May I have it, please?\" for the {item:17126}, and read it. The path up to the manor starts in the hills north of {area:275}. In the tunnel on the way lies a chest: do not open it (an elite guard jumps out), just walk past it to earn the Rite of Cunning. {npc:6707} waits on the manor's balcony."] = "24級起的盜賊：在主城的職業訓練師那裡說“請把它給我好嗎？”來索要{item:17126}，然後閱讀它。通往莊園的路從{area:275}北面的丘陵開始。途中隧道裡有個箱子：不要開啟（會跳出一個精英守衛），直接走過去就能獲得“狡詐儀式”。{npc:6707}在莊園的陽臺上等你。",
	-- {item:17126} Elegant Letter
	["{item:17126}, from your class trainer"] = "{item:17126}，來自你的職業訓練師",
	["walk past the trapped chest in the tunnel"] = "走過隧道裡那個有陷阱的箱子",
	-- {npc:6707} Fahrad
	["{npc:6707}: 100 reputation"] = "{npc:6707}：100點聲望",

	-- Step 2: Myrokos Silentform
	-- {npc:13085} Myrokos Silentform · {quest:96779} Syndicate Sabotage · {quest:96781} What's the Big Idea? · {quest:96782} Covert Extraction · {quest:96786} The Syndicate Sting · {quest:96783} A Way In · {item:5140} Flash Powder
	["{npc:13085}, in the manor, has Forever's new rogue quests: 100 reputation each for {quest:96779}, {quest:96781} and {quest:96782}, which follows it, and 300 for {quest:96786} at the end of the Stromgarde chain ({quest:96783} and the two quests after it pay nothing). All can be done solo with stealth from level 30; below that, the Master of Deception talent and a {item:5140} for Vanish help."] = "莊園裡的{npc:13085}有Forever新增的盜賊任務：{quest:96779}、{quest:96781}和緊隨其後的{quest:96782}各給100點聲望，激流堡任務鏈最後的{quest:96786}給300點（{quest:96783}及其後的兩個任務不給聲望）。從30級起都能靠潛行單人完成；等級更低時，“詭計大師”天賦和用於“消失”的{item:5140}會有幫助。",

	-- Step 3: Durnholde Keep: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {area:271} Southshore
	["{npc:266216} is inside {area:275}, the Syndicate fortress east of {area:271}. Stealth past the guards in the courtyard."] = "{npc:266216}在{area:271}以東的辛迪加堡壘{area:275}內。潛行繞過庭院裡的守衛。",

	-- Step 4: Strahnbrad: Barton
	-- {npc:266357} Barton · {area:280} Strahnbrad
	["{npc:266357} hides in a house in {area:280}, among stealthed Syndicate. Pick his pocket for the report; Distract turns him around if you are under his level."] = "{npc:266357} 藏在 {area:280} 的一棟房屋裡，周圍是潛行的辛迪加成員。對他使用偷竊取得報告；如果等級比他低，可用擾亂讓他轉身。",
	-- {item:275482} Barton's Scouting Report · {npc:266357} Barton
	["{item:275482}: pickpocket {npc:266357}"] = "{item:275482}：對{npc:266357}偷竊",

	-- Step 5: Northfold Manor: a uniform
	-- {area:313} Northfold Manor
	["{area:313}: a uniform"] = "{area:313}：一套制服",
	-- {object:656157} Syndicate Footlocker (no name in this language: may be words) · {area:313} Northfold Manor · {quest:96783} A Way In · {item:275706} Syndicate Uniform
	["The {object:656157} stands among the Syndicate camps of {area:313}, north of Stromgarde. Open it to finish {quest:96783} and take the {item:275706}."] = "{object:656157}立在激流堡以北{area:313}的辛迪加營地之間。開啟它即可完成{quest:96783}並拿到{item:275706}。",

	-- Step 6: Stromgarde: Anastasia Miller
	-- {npc:266847} Anastasia Miller
	["Stromgarde: {npc:266847}"] = "激流堡：{npc:266847}",
	-- {item:275706} Syndicate Uniform · {npc:266847} Anastasia Miller
	["Put on the {item:275706} and go into Stromgarde. {npc:266847} waits on a ledge just outside the castle; players reach her by jumping from the roof of the house beside the ledge. Her stash is upstairs in a house near the keep."] = "穿上{item:275706}，進入激流堡。{npc:266847}在城堡外的一處壁架上等候；玩家從壁架旁那棟房子的屋頂跳過去找她。她的藏匿物在城堡主樓附近一棟房子的樓上。",
	-- {item:275709} Stolen Funds · {object:656405} Anastasia's Stash (no name in this language: may be words)
	["{item:275709}, in {object:656405} upstairs"] = "{item:275709}，在樓上的{object:656405}裡",

	-- Step 7: Thoradin's Wall: the shipment
	-- {area:1057} Thoradin's Wall
	["{area:1057}: the shipment"] = "{area:1057}：那批貨物",
	-- {area:1057} Thoradin's Wall · {zone:1417} Arathi Highlands · {item:275882} Intercepted Shipment · {npc:13085} Myrokos Silentform
	["The hand-off is at the southern end of {area:1057}, in the west of the {zone:1417}: two Syndicate guard the box. Kill them or lure them off, then take the {item:275882}. Keep the uniform: {npc:13085} wants it back."] = "交接點在{zone:1417}西部{area:1057}的南端：兩名辛迪加看守著箱子。殺掉他們或把他們引開，然後拿走{item:275882}。留著制服：{npc:13085}要收回。",

	-- Step 8: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "返回{npc:13085}",
	-- {quest:96782} Covert Extraction · {quest:96781} What's the Big Idea?
	["{quest:96782}, after {quest:96781}"] = "{quest:96782}，在{quest:96781}之後",

	-- Step 9: Ruins of Alterac: the Perenolde heirlooms
	-- {area:281} Ruins of Alterac
	["{area:281}: the Perenolde heirlooms"] = "{area:281}：佩瑞諾德家族的傳家寶",
	-- {area:281} Ruins of Alterac · {zone:1416} Alterac Mountains
	["The two heirlooms lie in two towers of the {area:281}, the ogre-held ruin in the middle of the {zone:1416}. The tower with the sword is ringed by elite ogres: stay in stealth. Neither item is guarded once you are inside."] = "兩件傳家寶分別放在{area:281}的兩座塔中，那是{zone:1416}中部被食人魔佔據的廢墟。放劍的塔周圍有精英食人魔：保持潛行。進去之後兩件物品都沒人看守。",
	-- {item:275636} Royal Aegis of Perenolde
	["{item:275636}, the shield"] = "{item:275636}，那面盾",
	-- {item:275635} Blade of House Perenolde
	["{item:275635}, the sword"] = "{item:275635}，那把劍",

	-- Step 10: Syndicate Emblems to Friendly
	-- {quest:6701} Syndicate Emblems
	["{quest:6701} to Friendly"] = "{quest:6701} 到友善",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	-- plural, as words: Syndicate Prowlers = {npc:2588} Syndicate Prowler
	["Neutral to Friendly is 3,000 reputation; the quests above pay 700 of it. Any {npc:6766} on the path takes {quest:6701}, 100 reputation each, until you reach Friendly: 23 emblems after the quests. Pick the pockets of Syndicate humans; they never drop emblems when killed. The Arathi camps pay best: Syndicate Prowlers and Conjurors carry one about a quarter of the time. Kill what you have robbed so the next ones respawn fresh."] = "從中立到友善是3,000點聲望；上面的任務給了其中700點。路上任何{npc:6766}都收{quest:6701}，每枚徽記100點，直到你達到友善：做完任務後還需23枚徽記。去扒辛迪加人類的口袋；殺死他們永遠不會掉徽記。阿拉希的營地收益最好：辛迪加遊蕩者和咒術師約有四分之一攜帶徽記。把扒過的怪殺掉，好讓下一批重新出現。",
	-- {item:17124} Syndicate Emblem
	["{item:17124}: pickpocket Syndicate"] = "{item:17124}：扒辛迪加的口袋",
	-- {npc:6766} Ravenholdt Guard
	["a {npc:6766}: 100 per emblem, handed in from his window"] = "{npc:6766}：每枚徽記100點，在他的視窗中直接繳交",

	-- Step 11: Syndicate kills to the end of Honored
	["Syndicate kills to the end of Honored"] = "擊殺辛迪加至尊敬結束",
	-- {faction:349} Ravenholdt · {zone:1416} Alterac Mountains
	-- plural, as words: Syndicate Assassins = {npc:2246} Syndicate Assassin
	["Everyone, not only rogues: in Classic every Syndicate human gave {faction:349} 5 reputation up to the end of Honored (11,999 of 12,000) and not one point more, so 0 to there is 4,200 kills (3,600 after a rogue's quests and emblems). This step ticks at Honored; keep killing until the bar stops moving, then go on to the junkboxes. The highest Syndicate are in the north-west of the {zone:1416}, Syndicate Assassins and Enforcers (level 38-40), with Syndicate Sentries (36-37) nearer the middle. At 60 all Syndicate are grey, and in Classic grey kills gave about a fifth: farm them before 48 if you can. Legacy Diplomat adds up to 10%."] = "所有人，不只是盜賊：在經典舊世中，每個辛迪加人類成員在尊敬結束前（12,000中的11,999）都給{faction:349} 5點聲望，絕不多給一點，所以從0到那裡需要擊殺4,200次（做完盜賊任務和徽記後為3,600次）。這一步在尊敬時勾選；繼續殺到聲望條不再移動，再去弄垃圾箱。等級最高的辛迪加在{zone:1416}西北部：辛迪加刺客和執法者（38-40級），更靠中部的是辛迪加哨兵（36-37級）。到60級時所有辛迪加都是灰色，而經典舊世中殺灰名只有約五分之一：如果可能，就在48級前刷。傳承“外交家”最多加10%。",
	-- {npc:2246} Syndicate Assassin
	["{npc:2246}, level 38-39"] = "{npc:2246}，38-39級",
	-- {npc:2247} Syndicate Enforcer
	["{npc:2247}, level 39-40"] = "{npc:2247}，39-40級",
	-- {npc:2243} Syndicate Sentry
	["{npc:2243}, level 36-37"] = "{npc:2243}，36-37級",

	-- Step 12: A Simple Request, rogues 50+
	-- {quest:8233} A Simple Request
	["{quest:8233}, rogues 50+"] = "{quest:8233}，盜賊50級以上",
	-- {npc:6768} Lord Jorach Ravenholdt · {quest:8234} Sealed Azure Bag · {zone:1447} Azshara · {quest:8235} Encoded Fragments · {quest:8236} The Azure Key · {area:1477} Temple of Atal'Hakkar
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman · Forest Oozes = {npc:8766} Forest Ooze
	["At level 50 your class trainer has another letter for you, and {npc:6768} a short chain: 360 reputation in all. The {quest:8234} drops from Timbermaw Shamans in northern {zone:1447} (about 1 in 27, or pick their pockets); the {quest:8235} from Forest Oozes in {zone:1447} (4 in 5). {quest:8236} comes from Morphaz, an elite drake deep in the {area:1477}: a five-player dungeon, group up."] = "50 級時，職業訓練師會再給你一封信，{npc:6768} 也有一條簡短任務鏈：總共 360 點聲望。{quest:8234} 由 {zone:1447} 北部的木喉薩滿祭司掉落（約二十七分之一，也可以偷竊）；{quest:8235} 由 {zone:1447} 的森林軟泥怪掉落（五分之四）。{quest:8236} 來自 {area:1477} 深處的精英幼龍摩弗拉斯：這是五人地下城，要組隊。",
	-- {quest:8234} Sealed Azure Bag
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["{quest:8234}: Timbermaw Shamans"] = "{quest:8234}：木喉薩滿",
	-- {item:20023} Encoded Fragment
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["{item:20023}: Forest Oozes"] = "{item:20023}：森林軟泥怪",
	-- {item:20022} Azure Key · {area:1477} Temple of Atal'Hakkar
	["{item:20022}: Morphaz, {area:1477} (group)"] = "{item:20022}：莫法茲，{area:1477}（組隊）",

	-- Step 13: Heavy Junkboxes to Exalted
	["Heavy Junkboxes to Exalted"] = "用重垃圾箱衝到崇拜",
	-- {quest:8249} Junkboxes Needed · {npc:6707} Fahrad · {item:20086} Dusksteel Throwing Knife · {area:1583} Blackrock Spire · {area:1584} Blackrock Depths
	["From the top of Honored to Exalted is 21,001 reputation, and {quest:8249} is the only way: {npc:6707} pays 50 and a {item:20086} for every five Heavy Junkboxes (Classic Era paid 75), 421 turn-ins and 2,105 boxes. Boxes count at any standing, so take the cheap kills to their cap first. Any class can hand them in. Rogues get them by picking the pockets of humanoids around level 50 and up: Lower {area:1583} and {area:1584} are the classic spots, pick every pocket, reset and go again. The boxes do not bind, so everyone else buys them from rogues or at the auction house. Hand them in unopened; an opened box you empty vanishes, so leave one item in it."] = "從尊敬滿到崇拜是21,001點聲望，而{quest:8249}是唯一的途徑：{npc:6707}每五個重垃圾箱支付50點和一把{item:20086}（經典舊世時期為75），共需421次上交、2,105個箱子。箱子在任何聲望等級都計數，所以先用便宜的擊殺刷到上限。任何職業都能上交。盜賊靠扒50級以上人形生物的口袋獲得：下層{area:1583}和{area:1584}是經典地點，每個口袋都扒，重置後再來。箱子不繫結，所以其他人可以向盜賊買或在拍賣行買。上交時不要開啟；開啟並清空的箱子會消失，所以留一件物品在裡面。",
	-- {item:16885} Heavy Junkbox · {area:1445} Blackrock Mountain
	["{item:16885}: pickpocket level 50+ humanoids, {area:1445}"] = "{item:16885}：扒50級以上人形生物的口袋，{area:1445}",
	-- {npc:6707} Fahrad
	["{npc:6707}: 50 per five boxes, handed in from his window"] = "{npc:6707}：每五個箱子換50點聲望，在他的視窗中直接繳交",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:275709}, in Anastasia's Stash upstairs"] = "{item:275709}，在樓上阿納斯塔西婭的藏匿物中",
}
