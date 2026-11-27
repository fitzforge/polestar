-- Chinese (simplified) (zhCN): the guide forever/40-50/shendralas (forever/40-50/shendralas.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1444} Feralas
	["About a dozen quests on a short trip into Forever's new zone (about 45-46 for the Alliance, 47 for the Horde), then on to {zone:1444}."] = "前往无限服新增地区的短途之旅，约有十几个任务（联盟约45-46级，部落47级），之后继续前往{zone:1444}。",

	-- Step 1: North into Desolace
	-- {area:405} Desolace
	["North into {area:405}"] = "向北进入{area:405}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {area:1099} Camp Mojache · {area:2577} Dire Maul
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. From {area:1099} ride north-west on the road past {area:2577} and on north into {area:405}: the road comes out on {area:405}'s southern edge."] = "无限服新增内容：本指南依据玩家在{zone:2652}的实际经历编写。如果某个步骤有误，请在Polestar的Discord或GitHub告诉我们，并注明是哪个步骤。\n{zone:2652}位于{area:405}以南，需穿过{area:2657}，该地区没有自己的飞行路线。从{area:1099}沿道路向西北骑行，经过{area:2577}后继续向北进入{area:405}：道路通往{area:405}的南部边缘。",
	-- {area:405} Desolace · {zone:1444} Feralas
	["{area:405}, where the road from {zone:1444} comes in"] = "{area:405}，来自{zone:1444}的道路入口处",

	-- Step 2: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "飞往{area:2408}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {zone:1454} Orgrimmar · {object:3202} Grom'gol · {zone:1458} Undercity
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. Its quests are for levels 41-45. Coming from the Eastern Kingdoms, take the zeppelin to {zone:1454} first (from {object:3202} or the {zone:1458})."] = "无限服新增内容：本指南依据玩家在{zone:2652}的实际经历编写。如果某个步骤有误，请在Polestar的Discord或GitHub告诉我们，并注明是哪个步骤。\n{zone:2652}位于{area:405}以南，需穿过{area:2657}，该地区没有自己的飞行路线。这里的任务为41-45级。如果从东部王国出发，先从{object:3202}或{zone:1458}乘飞艇前往{zone:1454}。",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 3: Fly to Nijel's Point
	-- {area:608} Nijel's Point
	["Fly to {area:608}"] = "飞往{area:608}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {area:150} Menethil Harbor
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. Its quests are for levels 41-45. Coming from the Eastern Kingdoms, take the boat from {area:150} to Theramore first."] = "无限服新增内容：本指南依据玩家在{zone:2652}的实际经历编写。如果某个步骤有误，请在Polestar的Discord或GitHub告诉我们，并注明是哪个步骤。\n{zone:2652}位于{area:405}以南，需穿过{area:2657}，该地区没有自己的飞行路线。这里的任务为41-45级。如果从东部王国出发，先从{area:150}乘船前往塞拉摩。",

	-- Step 4: Into the Valley of Bones
	-- {area:2657} Valley of Bones
	["Into the {area:2657}"] = "进入{area:2657}",
	-- {area:405} Desolace · {area:2408} Shadowprey Village · {area:606} Gelkis Village · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["Ride east along {area:405}'s southern edge (from {area:2408}: past {area:606}): the {area:2657} opens there into {area:16651}."] = "沿{area:405}南部边缘向东骑行（从{area:2408}出发会经过{area:606}）：{area:2657}在那里通往{area:16651}。",

	-- Step 5: Into the Valley of Bones
	-- {area:608} Nijel's Point · {area:405} Desolace · {area:604} Magram Village · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["Ride south from {area:608} down the road through eastern {area:405} to {area:604}: just past its western edge the path climbs into the {area:2657} and {area:16651}."] = "从{area:608}沿道路向南穿过{area:405}东部，前往{area:604}：刚过其西侧边缘，小路便向上进入{area:2657}和{area:16651}。",

	-- Step 6: The Valley of Bones: a Tattered Journal
	-- {area:2657} Valley of Bones · {quest:93644} Tattered Journal
	["The {area:2657}: a {quest:93644}"] = "{area:2657}：{quest:93644}",
	-- {quest:93644} Tattered Journal · {zone:2652} Shen'dralas · {area:2657} Valley of Bones
	-- plural, as words: Outcast Necromancers = {npc:11559} Outcast Necromancer · Magram Necromancers = {npc:253272} Magram Necromancer
	["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. Take it from the Outcast Necromancers and leave the Magram alone: the Magram centaurs leave you be until you attack, but once you have killed Magram the whole clan turns on you, and their Necrokhans (level 45, elites) stand around the western pylon you repair later.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "无限服新增内容。如果某个步骤有误，请在Polestar 的 Discord 或 GitHub反馈，并注明具体步骤。\n山谷里的流放者通灵师和玛格拉姆通灵师都会掉落{quest:93644}，日记作者住在{zone:2652}。有玩家打了几只就拿到了。只打流放者通灵师，别碰玛格拉姆半人马。你不攻击时他们不会主动攻击，但只要杀过玛格拉姆半人马，整个部族就会与你敌对。后面要修的西侧水晶塔周围就有玛格拉姆死灵可汗（45级精英）。\n吉尔吉斯和玛格拉姆半人马在{area:2657}各有任务链，能额外获得约20,000到30,000点经验。每条任务链都要求对应部族的声望达到尊敬。两个部族互为敌对，选一个效力即可。具体做法见声望分类下的《吉尔吉斯和玛格拉姆半人马声望》指南。",

	-- Step 7: The western pylon
	["The western pylon"] = "西侧水晶塔",
	-- {quest:92914} Strange Pylons
	-- plural, as words: Decrepit Pylon Protectors = {npc:252711} Decrepit Pylon Protector · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["East through the valley to the strange crystal on its pedestal: clicking it starts {quest:92914}. The Decrepit Pylon Protectors (levels 42-43) around it are the mana elementals that guard it. Corpsefeeders (level 45, elite) roam the valley east of here.\nCareful: click the crystal from the road on its west side and move on: the Protectors stand two and three together east and north-east of it, where Corpsefeeders and the Magram Necrokhans (elites, 45) walk too."] = "向东穿过山谷，到基座上的奇怪水晶处。点击水晶开启{quest:92914}。附近的法力元素「衰老的水晶塔保护者」（42-43级）看守着它。此处以东的山谷里有食尸者（45级精英）游荡。\n小心，在水晶西侧的路上点击后继续走。保护者在水晶东侧和东北侧两三只扎堆，食尸者和玛格拉姆死灵可汗（45级精英）也在那里巡逻。",

	-- Step 8: Bristleback Retreat: the eastern pylon
	-- {area:16677} Bristleback Retreat
	["{area:16677}: the eastern pylon"] = "{area:16677}：东侧水晶塔",
	-- {area:16677} Bristleback Retreat · {npc:253527} Kog'thug the Brave
	["East along the valley road to the quilboar of {area:16677}: the second pylon stands at the eastern end of their camp. A Corpsefeeder (level 45, elite) walks this road: let it pass. The Bristlebacks (levels 42-43) attack on sight; {npc:253527} (level 43, elite) and his bodyguards hold the south side of the camp."] = "沿山谷道路向东，前往{area:16677}的野猪人：第二座水晶塔位于其营地东端。一只食尸者（45级，精英）在这条路上巡逻：等它走过去。鬃背野猪人（42-43级）会主动攻击；{npc:253527}（43级精英）和他的护卫占据营地南侧。",
	["the eastern pylon"] = "东侧水晶塔",

	-- Step 9: The temple of Shen'dralas: the third pylon
	-- {zone:2652} Shen'dralas
	["The temple of {zone:2652}: the third pylon"] = "{zone:2652}神殿：第三座水晶塔",
	["South to the Shen'dralar temple at the zone's heart, keeping west of Kog'thug's bodyguards: the third pylon stands inside. The temple's guards are neutral: leave them be."] = "向南前往地区中心的辛德拉神殿，注意从考格苏格护卫的西侧绕过：第三座水晶塔就在神殿内。神殿守卫是中立的，别去招惹。",

	-- Step 10: Evenshade's Overlook
	-- {npc:253471} Mordent Evenshade · {quest:93644} Tattered Journal
	["North-west from the temple to {npc:253471}'s camp on the overlook, beside the spirit healer: the {quest:93644} is his, and he wants to hear about the pylons."] = "从神殿向西北前往瞭望台上{npc:253471}的营地，就在灵魂医者旁边：{quest:93644}是他的，他想了解水晶塔的情况。",

	-- Step 11: North into Desolace
	-- {npc:253471} Mordent Evenshade · {area:405} Desolace · {area:604} Magram Village
	["{npc:253471} wants a fragment and a shard of the pylons back from {area:405}'s two centaur villages: {area:604} lies just beyond the valley's northern way out.\nCareful: if you have killed Magram or Gelkis centaurs, that clan's guards may attack you when you walk into its village."] = "{npc:253471}要你从{area:405}的两个半人马村落取回水晶塔的残片和碎片：{area:604}就在山谷北侧出口外。\n注意：如果你杀过玛格拉姆或吉尔吉斯半人马，进入该部族的村落时，其守卫可能会攻击你。",

	-- Step 12: Magram Village
	-- {item:255656} Pylon Fragment
	-- plural, as words: Magram Guardians = {npc:255560} Magram Guardian
	["The {item:255656} lies at the western edge of the village; Magram Guardians (levels 39-41) watch over it. They leave you be unless you have fought the Magram: pick the fragment up without a fight. Every Magram you kill turns the clan against you, and back in the valley that means the Necrokhans (level 45, elites) at the western pylon as well."] = "{item:255656}在村子西缘，由玛格拉姆守护者（39-41级）看守。只要没和玛格拉姆半人马交过手，它们就不会主动攻击，直接捡起残片即可。杀了任何玛格拉姆半人马都会使整个部族与你敌对，回到山谷后，西侧水晶塔旁的玛格拉姆死灵可汗（45级精英）也会攻击你。",

	-- Step 13: Gelkis Village
	-- {area:405} Desolace · {area:606} Gelkis Village · {item:255657} Pylon Shard
	-- plural, as words: Gelkis Guardians = {npc:255561} Gelkis Guardian
	["West along {area:405}'s southern edge to {area:606}: the {item:255657} lies at its southern end, watched by Gelkis Guardians (levels 39-41)."] = "沿{area:405}南缘向西前往{area:606}：{item:255657}在村落南端，有吉尔吉斯守护者（39-41级）看守。",

	-- Step 14: Back into the Valley of Bones
	-- {area:2657} Valley of Bones
	["Back into the {area:2657}"] = "返回{area:2657}",
	-- {area:405} Desolace · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["East again along {area:405}'s southern edge: the {area:2657} opens into {area:16651}."] = "再沿{area:405}南缘向东：{area:2657}通往{area:16651}。",

	-- Step 16: The temple: the Mana Sieve
	-- {item:255662} Mana Sieve
	["The temple: the {item:255662}"] = "神殿：{item:255662}",
	-- {npc:253471} Mordent Evenshade · {item:255662} Mana Sieve · {npc:255486} Historian Biraxas · {quest:96018} Powering the Pylons
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["{npc:253471} sends you for the {item:255662}, kept inside the temple beside {npc:255486}. {quest:96018} asks you to gather mana with the Sieve before you repair the pylons: with it in your bags you can handle the Unstable Mana Rifts, the floating sparks of mana all along the road north."] = "{npc:253471}派你去取{item:255662}，它放在神殿内{npc:255486}旁边。{quest:96018}要求你在修复水晶塔之前用过滤网收集法力：把它放在背包里，就能处理不稳定的法力裂隙，即沿北边道路漂浮的法力火花。",

	-- Step 17: Unstable Mana Rifts: mana for the western pylon
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["Unstable Mana Rifts: mana for the western pylon"] = "从不稳定的法力裂隙为西侧水晶塔收集法力",
	-- {item:255662} Mana Sieve
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift · Coalesced Mana Crystals = {item:255667} Coalesced Mana Crystal
	["Use the {item:255662} on the Unstable Mana Rifts, the floating sparks along the road north: each pylon takes four Coalesced Mana Crystals, and the repair uses them up."] = "沿道路向北，对路边漂浮的火花，也就是不稳定的法力裂隙，使用{item:255662}。每座水晶塔要用四颗凝聚的法力水晶，修复时会消耗掉。",
	-- {item:255667} Coalesced Mana Crystal · {item:255662} Mana Sieve
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["{item:255667}, from the Unstable Mana Rifts with the {item:255662}"] = "用{item:255662}从不稳定的法力裂隙收集{item:255667}",

	-- Step 18: The road south of the western pylon
	["The road south of the western pylon"] = "西侧水晶塔以南的道路",
	-- {npc:252711} Decrepit Pylon Protector · {spell:1289727} Repair and Recharge Pylon
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift · Coalesced Mana Crystals = {item:255667} Coalesced Mana Crystal · Magram Necrokhans = {npc:253274} Magram Necrokhan · Nascent Pylon Protectors = {npc:276401} Nascent Pylon Protector
	["North up the road to the first pylon, gathering mana from the Unstable Mana Rifts on the way. Stop where the arrow points, on the road just south of the pylon, keeping to its west edge: the quiet side, with no Protectors behind you. Pull one {npc:252711} at a time down to that spot, the one nearest the pylon's south side first, and kill it there; then step up to the pylon's west side and use the Pile of Pylon Parts Mordent gave you: its {spell:1289727} takes your four Coalesced Mana Crystals.\nCareful: stay off the pylon's east and north-east side. The Protectors stand there two and three together, a Corpsefeeder (level 45, elite) walks among them and the Magram Necrokhans (elites, 45) stand just beyond: nearly every recorded death at this pylon happened east of it. If the Magram attack you (they do once you have killed Magram), wait at the arrow until any Necrokhan by the pylon walks off before you pull. Nascent Pylon Protectors (elites, 43) wander the road south of it: let them pass.\nIf you die here, walk your ghost back to the arrow before you come back to life: players who rose beside the pylon died again within seconds."] = "沿路向北前往第一座水晶塔，途中从不稳定的法力裂隙收集法力。在塔南边的路上按箭头指示靠西停下，那里比较安全，身后没有保护者。一次只把一只{npc:252711}引到这里击杀，先引最靠近塔南侧的那只。然后到塔西侧使用莫丹特给你的水晶塔零件堆，施放{spell:1289727}会消耗四颗凝聚的法力水晶。\n小心，避开水晶塔的东侧和东北侧。那里的保护者两三只扎堆，有一只食尸者（45级精英）在它们之间巡逻，玛格拉姆死灵可汗（45级精英）就在再往外一点的地方。记录中，这座水晶塔附近的死亡几乎都发生在塔东侧。如果玛格拉姆半人马对你有敌意（杀过他们就会这样），留在箭头指向的位置等塔旁的死灵可汗走远，再引怪。初生水晶塔保护者（43级精英）在塔南边的路上游荡，等它们过去。\n如果在这里死了，先让灵魂走回箭头指向的位置再复活。有玩家在塔旁复活，几秒内又死了。",
	["the road just south of the western pylon"] = "西侧水晶塔正南边的道路",

	-- Step 19: The western pylon: repair it
	["The western pylon: repair it"] = "西侧水晶塔：修复它",
	-- {item:271882} Pile of Pylon Parts
	["Pull a single Protector down to the road, then use the {item:271882} on the pylon's west side."] = "单独引一只保护者到路上，再到水晶塔西侧使用{item:271882}。",
	-- {item:271882} Pile of Pylon Parts · {spell:1289727} Repair and Recharge Pylon
	["{item:271882}: {spell:1289727} on the pylon's west side"] = "在水晶塔西侧用{item:271882}施放{spell:1289727}",

	-- Step 20: Unstable Mana Rifts: mana for the eastern pylon
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["Unstable Mana Rifts: mana for the eastern pylon"] = "从不稳定的法力裂隙为东侧水晶塔收集法力",
	-- {item:255662} Mana Sieve · {item:271882} Pile of Pylon Parts
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift · Coalesced Mana Crystals = {item:255667} Coalesced Mana Crystal
	["The western repair used up your crystals: on the way east, use the {item:255662} on the Unstable Mana Rifts again for four more Coalesced Mana Crystals. The {item:271882} needs all four for the next repair."] = "修复西侧水晶塔用完了水晶。往东走时，再对不稳定的法力裂隙使用{item:255662}，收集四颗凝聚的法力水晶。下次用{item:271882}修复时会消耗全部四颗。",

	-- Step 21: Bristleback Retreat: repair the eastern pylon
	-- {area:16677} Bristleback Retreat
	["{area:16677}: repair the eastern pylon"] = "{area:16677}：修复东侧水晶塔",
	-- {item:271882} Pile of Pylon Parts · {npc:252711} Decrepit Pylon Protector · {npc:253527} Kog'thug the Brave
	["East along the valley road to the eastern pylon and repair it the same way with the {item:271882}, coming in from the west and pulling the nearest {npc:252711} away first: {npc:253527} (level 43, elite) and his bodyguards hold the south side of the quilboar camp, and a Corpsefeeder (level 45, elite) walks the road."] = "沿山谷道路向东到东侧水晶塔，用{item:271882}按同样的方法修复。从西侧接近，先引开最近的{npc:252711}。{npc:253527}（43级精英）和他的护卫守在野猪人营地南侧，路上还有一只食尸者（45级精英）巡逻。",
	-- {item:271882} Pile of Pylon Parts · {spell:1289727} Repair and Recharge Pylon
	["{item:271882}: {spell:1289727} on the eastern pylon"] = "对东侧水晶塔使用{item:271882}施放{spell:1289727}",

	-- Step 22: Evenshade's Overlook
	-- {npc:253471} Mordent Evenshade · {quest:93016} A Brief History Lesson
	["Back west along the valley road and south to {npc:253471}. {quest:93016} asks you to hear him out: talk to him once more, then hand it in."] = "沿山谷道路返回西边，再向南找{npc:253471}。{quest:93016}要求你听他讲完：再和他对话一次，然后交还任务。",
	-- {npc:253471} Mordent Evenshade
	["{npc:253471}: hear him out"] = "{npc:253471}：听他讲完",

	-- Step 23: Liranne
	-- {quest:93568} Partially Digested Collar · {npc:255385} Liranne
	["A Prowler gave up a {quest:93568}: {npc:255385}, north of the temple, knows whose it was."] = "一只潜行者吐出了{quest:93568}：神殿北边的{npc:255385}知道它是谁的。",

	-- Step 24: The temple: Magister Kirandis
	-- {npc:254656} Magister Kirandis
	["The temple: {npc:254656}"] = "神殿：{npc:254656}",
	-- {npc:254656} Magister Kirandis · {npc:254578} Mithera · {quest:93341} Forlorn Gardens
	["{npc:254656} waits inside the temple. Then {npc:254578}, on the temple's eastern side, has work in the {quest:93341}."] = "{npc:254656}在神殿内等候。随后神殿东侧的{npc:254578}有{quest:93341}的任务交给你。",

	-- Step 25: The Forlorn Gardens: the pedestal
	-- {quest:93341} Forlorn Gardens
	["The {quest:93341}: the pedestal"] = "{quest:93341}：基座",
	-- {quest:93341} Forlorn Gardens
	["East of the temple the {quest:93341} have run wild, and their plants attack on sight. Examine the pedestal at the gardens' southern end."] = "神殿东边的{quest:93341}已经荒芜失控，那里的植物见人就攻击。检查花园南端的基座。",

	-- Step 27: The Forlorn Gardens
	-- {quest:93341} Forlorn Gardens
	["The {quest:93341}"] = "{quest:93341}",
	-- {npc:254674} Woodwyrd · {area:2100} Maraudon
	-- plural, as words: Rowdy Roses = {npc:254566} Rowdy Rose · Terrible Tulips = {npc:254567} Terrible Tulip · Malevolent Marigolds = {npc:254572} Malevolent Marigold · Nascent Pylon Protectors = {npc:276401} Nascent Pylon Protector
	["Rowdy Roses and Terrible Tulips grow all over the gardens; the Malevolent Marigolds keep to the northern part. {npc:254674}, the treant in the middle of the gardens, has a request of his own that needs water from {area:2100}, a dungeon: this guide leaves it.\nThe Shen'dralar who wander the gardens are neutral, like the temple's guards: leave them be and pull the flowers away from them. Careful: Nascent Pylon Protectors (elites, 43) wander the zone's middle, the gardens too: keep clear of them."] = "花园各处都长着{npc:254566}和{npc:254567}；{npc:254572}则集中在北部。花园中央的树人{npc:254674}也有自己的请求，需要地下城{area:2100}的水：本指南跳过它。\n在花园里游荡的辛德拉是中立的，和神殿守卫一样：别去惹他们，把花怪从他们身边拉开。小心：{npc:276401}（精英，43级）在地区中部游荡，花园里也有：远离它们。",

	-- Step 28: Mithera
	-- {npc:255486} Historian Biraxas · {npc:254656} Magister Kirandis · {npc:252711} Decrepit Pylon Protector
	["{npc:255486}, inside the temple, has a task for you now that you have met {npc:254656}: the heart of a {npc:252711} (42-43, not elite), a short ride back up the road north."] = "见过{npc:254656}之后，神殿里的{npc:255486}有任务交给你：取一颗{npc:252711}（42-43级，非精英）的心脏，沿路向北骑一小段就到。",

	-- Step 29: A Heart of Crystal
	-- {npc:252711} Decrepit Pylon Protector
	["Use the west face of the western pylon, where you repaired it. Approach on the road from the south and pull one {npc:252711} back to you. Wait for the elite patrols to pass; do not follow a Protector around the east side."] = "沿道路从南边接近西侧水晶塔，把一只{npc:252711}引过来。等巡逻的精英经过，从塔西面之前修复的位置操作，别跟着保护者绕到塔东侧。",

	-- Step 31: Mana Mania
	-- {item:286647} Depleted Crystal Heart · {npc:264149} Unstable Mana Rift · {npc:276401} Nascent Pylon Protector
	["Take the {item:286647} to an {npc:264149} on the road north of the temple and throw it into the rift. The {npc:276401} that comes out is an elite (level 43) but it comes alone: most players in our recordings killed it without a group, from level 41 up."] = "带上{item:286647}，到神殿北边的路上找一个{npc:264149}，把心脏扔进裂隙。出来的{npc:276401}是精英（43级），会单独出现。记录中，大多数玩家从41级起就能单独击杀它。",

	-- Step 32: Shadowprey Village
	-- {zone:2652} Shen'dralas · {area:2657} Valley of Bones · {area:405} Desolace · {area:2408} Shadowprey Village · {area:1637} Orgrimmar · {zone:1444} Feralas · {area:1099} Camp Mojache
	["{zone:2652} is done. Ride back north through the {area:2657} and west along {area:405}'s southern edge to {area:2408} and fly to {area:1637}: the next guide picks up there, with the {zone:1444} guide's hand-ins. Keep your hearthstone (bound at {area:1099}): the next guide uses it to get from {area:1637} back to {area:1099}."] = "{zone:2652}的路线已完成。向北穿过{area:2657}，再沿{area:405}南缘向西回到{area:2408}，飞往{area:1637}。下一份指南从那里接上，交{zone:1444}指南的任务。保持炉石绑定（{area:1099}），下一份指南会用它从{area:1637}回{area:1099}。",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408}的飞行管理员",

	-- Step 33: Back to your route
	["Back to your route"] = "回到你的路线",
	-- {zone:2652} Shen'dralas · {zone:1444} Feralas · {area:2657} Valley of Bones · {area:405} Desolace · {area:1108} Forgotten Coast · {area:1116} Feathermoon Stronghold
	["{zone:2652} is done. Your {zone:1444} guide picks up from here: ride back north through the {area:2657}, west along {area:405}'s southern edge and south into {zone:1444}, to the dock on the {area:1108} where the boat crosses to {area:1116}."] = "{zone:2652}已完成。你的{zone:1444}指南从这里继续：骑马向北穿过{area:2657}，沿{area:405}南缘向西，再向南进入{zone:1444}，前往{area:1108}的码头，从那里坐船去{area:1116}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East along the valley road to the eastern pylon and repair it the same way, a {npc:252711} first, coming in from the west: {npc:253527} (level 43, elite) and his bodyguards hold the south side of the quilboar camp, and a Corpsefeeder (level 45, elite) walks the road."] = "沿山谷道路向东前往东侧水晶塔，用同样方法修复，先杀一个{npc:252711}，从西边接近：{npc:253527}（43级精英）和他的保镖占据着野猪人营地南侧，还有一只食尸者（45级精英）在道路上巡逻。",
	-- ["East through the valley to the strange crystal on its pedestal: clicking it starts {quest:92914}. The Decrepit Pylon Protectors (levels 42-43) around it are the mana elementals that guard it. Corpsefeeders (level 45, elite) roam the valley east of here."] = "向东穿过山谷，前往基座上的奇怪水晶：点击它开始{quest:92914}。周围的衰败的水晶塔守护者（42-43级）是守卫它的法力元素。食尸者（45级，精英）在此处以东的山谷中游荡。",
	-- ["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. The Magram centaurs leave you be until you attack; the Magram Necrokhans among them (level 45) are elites: leave them be.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "无限服新增内容：如果某个步骤有误，请在Polestar的Discord或GitHub告诉我们，并注明是哪个步骤。\n山谷中的流放通灵师和玛格拉姆通灵师会掉落{quest:93644}，其作者住在{zone:2652}：玩家通常杀几只就能拿到。玛格拉姆半人马在你攻击前不会主动攻击；其中的玛格拉姆亡灵可汗（45级）是精英，别去招惹。\n吉尔吉斯和玛格拉姆半人马各有自己的{area:2657}任务链，能额外获得约20000到30000经验，但每条任务链都要求该部族声望达到尊敬。两个部族互为敌对，所以只能为其中一个效力：声望分类下的“吉尔吉斯与玛格拉姆半人马声望”指南会说明做法。",
	-- ["North up the road to the first pylon, gathering mana from the Unstable Mana Rifts on the way. Decrepit Pylon Protectors guard it: kill one beside the pylon, then use {spell:1289727} on it, as players did to repair it.\nCareful: the pylon stands at the edge of the {area:2657}, where Magram Necrokhans and Corpsefeeders (elites, level 45) walk, and Nascent Pylon Protectors (elites, 43) wander the road. Pull the Decrepit Pylon Protectors away from them before you repair it."] = "沿道路向北前往第一座水晶塔，途中从不稳定的法力裂隙收集法力。衰朽的水晶塔守护者守卫着它：在水晶塔旁杀死一个，然后对其使用{spell:1289727}，像玩家修复它那样。\n注意：水晶塔位于{area:2657}边缘，玛格拉姆亡灵可汗和食尸者（45级精英）在此游荡，初生的水晶塔守护者（43级精英）在道路上徘徊。修复前先把衰朽的水晶塔守护者从它们身边引开。",
	-- ["The nearest Decrepit Pylon Protectors stand by the road north, from the middle of the zone up to the western pylon, and around {npc:253471}'s overlook: one of them carries the heart Biraxas wants."] = "最近的{npc:252711}站在北边的路旁，从地区中部一直到西边的水晶塔，以及{npc:253471}的瞭望台周围：其中一只带着毕拉克萨斯要的心脏。",
	-- ["The {item:255656} lies at the western edge of the village; Magram Guardians (levels 39-41) watch over it."] = "{item:255656}位于村落西缘，有玛格拉姆守护者（39-41级）看守。",
	-- ["{npc:252711}, then {spell:1289727} on it"] = "{npc:252711}，然后对其使用{spell:1289727}",
	-- ["{zone:2652} is done. Ride back north through the {area:2657} and west along {area:405}'s southern edge to {area:2408}: the next guide picks up in {area:1637}, with the {zone:1444} guide's hand-ins. Your hearthstone is bound at {area:1099}: if it is ready, hearth there and fly to {area:1637} from {area:1099} instead."] = "{zone:2652}已完成。骑马向北穿过{area:2657}，再沿{area:405}南缘向西前往{area:2408}：下一篇指南从{area:1637}开始，交还{zone:1444}指南的任务。你的炉石绑定在{area:1099}：如果炉石已冷却，就用炉石回去，从{area:1099}飞往{area:1637}。",
	-- ["{zone:2652} is done: ride back north through the {area:2657}; the next step says where your route goes on from there."] = "{zone:2652}已完成：骑马向北穿过{area:2657}返回；下一步会告诉你之后的路线去向。",
}
