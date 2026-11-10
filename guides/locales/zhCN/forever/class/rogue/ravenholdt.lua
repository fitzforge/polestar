-- Chinese (simplified) (zhCN): the guide forever/class/rogue/ravenholdt (forever/class/rogue/ravenholdt.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3486} Ravenholdt Manor · {npc:13085} Myrokos Silentform
	["Opens {area:3486}, the hidden rogue house in the Alterac hills, and {npc:13085}'s jobs against the Syndicate."] = "开启{area:3486}——奥特兰克山区隐秘的潜行者宅邸，以及{npc:13085}针对辛迪加的任务。",
	-- {npc:13936} Ravenholdt
	["{npc:13936} reputation"] = "{npc:13936}声望",

	-- Step 1: The Elegant Letter
	-- {item:17126} Elegant Letter
	["The {item:17126}"] = "{item:17126}",
	-- {npc:332} Master Mathias Shaw · {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {zone:1454} Orgrimmar · {item:17126} Elegant Letter · {npc:13936} Ravenholdt · {item:17125} Seal of Ravenholdt · {npc:6707} Fahrad · {spell:1846} Detect Traps
	["At 24 any capital's rogue trainer ({npc:332} or {npc:918} in {zone:1453}, Gest or Ormok in {zone:1454}, and the others) has an {item:17126} from {npc:13936} for you: ask for it in their talk window. Open it: the quest gives you the {item:17125} for {npc:6707}. Learn {spell:1846} from your trainer first if you have not; the way in is a test of it."] = "24级时，任意主城的潜行者训练师（{zone:1453}的{npc:332}或{npc:918}、{zone:1454}的盖斯特或奥莫克，以及其他主城的训练师）都有{npc:13936}送你的{item:17126}：在交谈窗口中索取。打开后，任务会给你送给{npc:6707}的{item:17125}。若还没学会{spell:1846}，先向训练师学习；进去的路线会考验这个技能。",

	-- Step 2: Ravenholdt Manor
	-- {area:272} Tarren Mill · {area:271} Southshore · {area:275} Durnholde Keep · {spell:1846} Detect Traps · {area:3486} Ravenholdt Manor · {npc:6707} Fahrad · {npc:13936} Ravenholdt
	["Horde fly to {area:272}, Alliance to {area:271}. The trail to the manor is hard to see: it starts behind the plateau north of {area:275}, east of {area:272}, climbs into the hills and bends twice to a small tunnel. A chest sits in the tunnel: do not open it. Cast {spell:1846} near it and walk up close; that is the Rite of Cunning (it comes back after 5 minutes). Opening the chest calls Milton, an elite rogue of about level 32. Through the tunnel lies {area:3486}: {npc:6707} is upstairs inside. Do not attack anyone at the manor: it costs {npc:13936} reputation."] = "部落飞往{area:272}，联盟飞往{area:271}。通往庄园的小路很难发现：起点在{area:275}北面高地的后方、{area:272}以东，沿路爬上山丘，拐两次弯后到达一条小隧道。隧道内有个箱子：不要打开。在附近施放{spell:1846}，再走近箱子；这样就完成了入门考验（五分钟后刷新）。打开箱子会召来米尔顿·西弗，一名约32级的精英盗贼。穿过隧道就是{area:3486}：{npc:6707}在屋内楼上。不要攻击庄园中的任何人：会损失{npc:13936}声望。",
	-- {spell:1846} Detect Traps
	["Rite of Cunning: {spell:1846} beside the tunnel chest"] = "狡诈仪式：在隧道宝箱旁使用 {spell:1846}。",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	["{npc:6766}: {quest:6701}, repeatable; take it now, the emblems are quest items"] = "",

	-- Step 3: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {npc:13085} Myrokos Silentform · {quest:6701} Syndicate Emblems
	-- plural, as words: Syndicate Rogues = {npc:2260} Syndicate Rogue
	["{npc:266216} is inside {area:275}, the Syndicate fortress south of the manor; he can stand in any of fifteen spots in the keep, so search. Quick and quiet, says {npc:13085}. Pick the pockets of the level 20-21 Syndicate Rogues, Shadow Mages and Watchmen on your way: they carry {quest:6701} for the guards' repeatable reputation quest."] = "{npc:266216} 位于庄园南侧辛迪加堡垒 {area:275} 内；他可能出现在堡内十五个位置中的任意一处，需要搜索。{npc:13085} 要求行动迅速、保持安静。沿途对 20-21 级的辛迪加潜行者、暗影法师和卫兵使用偷窃：他们携带 {quest:6701}，可用于守卫提供的可重复声望任务。",
	-- {quest:6701} Syndicate Emblems
	["Pick Pocket Syndicate members for {quest:6701}"] = "对辛迪加成员使用搜索，完成{quest:6701}",

	-- Step 4: Myrokos Silentform
	-- {npc:6766} Ravenholdt Guard
	["{npc:6766}: one emblem each time, 100 reputation"] = "",

	-- Step 5: What's the Big Idea?
	-- {npc:13085} Myrokos Silentform · {area:280} Strahnbrad · {zone:1416} Alterac Mountains · {spell:921} Pick Pocket
	["In your mid 30s {npc:13085} has two more jobs; take both. Barton leads a Syndicate scouting party at {area:280}, in the east of the {zone:1416}, inside one of the houses with stealthed Syndicate around him. Pick his pocket for the report and do not kill him: he does not drop it. If you are lower than him he sees through stealth; Master of Deception helps, or Distract him, Vanish and come in from behind. {spell:921} can miss several times in a row."] = "35级左右时，{npc:13085} 还有两项任务，都接下。巴顿 带领一支辛迪加侦察队，位于 {zone:1416} 东部的 {area:280}，在其中一栋房屋内，周围有潜行的辛迪加成员。对他使用偷窃取得报告，不要杀他：他不会掉落报告。如果你等级比他低，他能识破潜行；欺诈高手天赋有帮助，也可以先扰乱他，再消失并绕到背后接近。{spell:921} 可能连续几次未命中。",
	-- {item:275482} Barton's Scouting Report
	["Pick Pocket Barton for {item:275482}"] = "对巴顿使用搜索，获得{item:275482}",

	-- Step 6: Covert Extraction
	-- {npc:13085} Myrokos Silentform · {area:281} Ruins of Alterac · {zone:1416} Alterac Mountains
	["Back to {npc:13085}; the report sends you after the Perenolde heirlooms. Two towers stand among the {area:281}, in the middle of the {zone:1416}, held by ogres: the shield lies in the northern tower, the sword in the southern one, which elite ogres ring and watch from far off. Stay stealthed; nothing guards the heirlooms inside."] = "回到 {npc:13085} 处；提交报告后，他会让你去找匹瑞诺德的传家宝。两座塔楼矗立在 {zone:1416} 中部的 {area:281}，被食人魔占据：盾牌在北塔，剑在南塔，南塔周围有精英食人魔，它们从很远就能发现你。保持潜行；塔内的传家宝旁没有守卫。",
	-- {item:275636} Royal Aegis of Perenolde
	["{item:275636}, in the northern tower"] = "{item:275636}，在北面的塔楼内",
	-- {item:275635} Blade of House Perenolde
	["{item:275635}, in the southern tower"] = "{item:275635}，在南面的塔楼中",

	-- Step 7: A Way In
	-- {area:324} Stromgarde Keep · {area:313} Northfold Manor · {object:656157} Syndicate Footlocker (no name in this language: may be words) · {quest:96783} A Way In
	["{area:324} in western Arathi is a Syndicate stronghold; to get in you need a uniform. {area:313}, in north-western Arathi, is held by Syndicate Highwaymen, Pathstalkers and Mercenaries (level 30-32): find the {object:656157} there and take the uniform; that ends {quest:96783}."] = "阿拉希西部的 {area:324} 是辛迪加的据点；要进去，需要一套制服。阿拉希西北部的 {area:313} 被辛迪加路霸、巡路者和雇佣兵（30-32 级）占据：在那里找到 {object:656157}，取走制服，即可完成 {quest:96783}。",
	-- {quest:96784} Master of Disguise · {item:275706} Syndicate Uniform
	["{quest:96784}: the {item:275706}"] = "{quest:96784}：{item:275706}",

	-- Step 8: Anastasia Miller
	-- {item:275706} Syndicate Uniform · {quest:96784} Master of Disguise · {quest:96785} Ain't No Telling · {npc:266847} Anastasia Miller
	-- plural, as words: Syndicate Prowlers = {npc:2588} Syndicate Prowler
	["Stromgarde's Syndicate Prowlers and Conjurors are elite (level 35-36): a rogue of 36 can slip past them, but fighting one alone is hard, so stay hidden or bring a friend. Put on the {item:275706} ({quest:96784} hands it to you at the footlocker) to pass as one of them; stealth or suspicious acts can break it. If the footlocker gave you no uniform, Anastasia hands you one with {quest:96785}. {npc:266847} is not inside the keep: she stands on a ledge on the outside of the castle wall. Jump across to it from the roof of the house beside the ledge."] = "激流堡的辛迪加潜伏者和召唤师是精英（35-36级）：36级盗贼可以偷偷绕过，但单挑一个也很吃力，因此保持隐蔽或带朋友来。穿上{item:275706}（在手提箱处接受{quest:96784}时会拿到），伪装成他们的一员；潜行或可疑举动可能使伪装失效。如果手提箱没有给你制服，{npc:266847}会在提供{quest:96785}时给你一件。她不在城堡内部：她站在城墙外侧的凸台上。从凸台旁房子的屋顶跳过去。",

	-- Step 9: Ain't No Telling
	-- {item:275709} Stolen Funds
	["She will not talk without something to bargain with. Her stash is upstairs in a house close to the keep: take the {item:275709}. If it is already open, wait for it to come back."] = "没有可供交换的东西，她就不愿交谈。她藏的东西在城堡附近一座房子的楼上：拿走 {item:275709}。如果已经被打开，就等它刷新。",
	-- {item:275709} Stolen Funds
	["{item:275709}: Anastasia's Stash"] = "{item:275709}：她的藏匿处",

	-- Step 10: The Syndicate Sting
	-- {area:1057} Thoradin's Wall · {area:287} Hillsbrad · {item:275882} Intercepted Shipment · {item:275706} Syndicate Uniform · {npc:13085} Myrokos Silentform
	["Falconcrest's men make the handoff at the southern end of {area:1057}, the old wall between Arathi and {area:287}. Kill the two guarding the box and take the {item:275882}. Keep the {item:275706}: {npc:13085} wants it back with the shipment."] = "法库雷斯特的手下在 {area:1057} 南端交接货物，这是阿拉希与 {area:287} 之间的旧城墙。杀死看守箱子的两人，取走 {item:275882}。保留 {item:275706}：{npc:13085} 要你连同货物一起交回。",

	-- Step 11: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "回到{npc:13085}处",
	-- {npc:13085} Myrokos Silentform · {npc:13936} Ravenholdt
	["{npc:13085}: 70 silver, 300 {npc:13936} reputation"] = "{npc:13085}：70银币，300点 {npc:13936} 声望",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 24 an {item:17126} from {npc:13936} starts this; the data gives it to you through {npc:332} or {npc:918} in {zone:1453}, or Gest or Ormok in {zone:1454}. The quest hands you the {item:17125} for {npc:6707}."] = "24级时，一封来自{npc:13936}的{item:17126}开启此任务；数据显示它通过{zone:1453}的{npc:332}或{npc:918}，或{zone:1454}的盖斯特或奥莫克交给你。任务会给你{item:17125}，交给{npc:6707}。",
	-- ["At 36, {npc:13085} sends you after Barton's scouting report. Barton leads a Syndicate party at {area:280}, in the east of the {zone:1416}: pick his pocket, do not kill him."] = "36级时，{npc:13085}派你去取巴顿的侦察报告。巴顿在{zone:1416}东部的{area:280}带领一支辛迪加队伍：偷他的口袋，不要杀他。",
	-- ["Horde fly to {area:272}, Alliance to {area:271}. The manor hides in the hills east of {area:272}, up a path into the {zone:1416}; the Rite of Cunning is passing its way in."] = "部落飞往{area:272}，联盟飞往{area:271}。庄园隐藏在{area:272}东边的山丘中，沿小路进入{zone:1416}；前往庄园的途中会接受狡诈仪式的考验。",
	-- ["Opens {area:3486}, the hidden rogue house in the Alterac hills, and its first jobs."] = "开启{area:3486}——奥特兰克山区隐秘的潜行者宅邸，以及它的首批任务。",
	-- ["Rite of Cunning"] = "狡诈仪式",
	-- ["one emblem each time, 100 reputation"] = "每次一枚徽记，100点声望",
	-- ["{item:275482}: pickpocket Barton"] = "{item:275482}：对巴顿搜索",
	-- ["{npc:266216} is inside {area:275}, the Syndicate fortress in eastern {area:287}, south of the manor. Quick and quiet, says {npc:13085}."] = "{npc:266216}在{area:275}内，即{area:287}东部、庄园南边的辛迪加要塞。{npc:13085}说：要快，要安静。",
	-- ["{npc:6766}: {quest:6701}, repeatable"] = "{npc:6766}：{quest:6701}，可重复",
}
