-- Chinese (simplified) (zhCN): the guide forever/horde/tauren/01-mulgore (forever/horde/tauren/01-mulgore.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Camp Narache
	-- {area:221} Camp Narache · {npc:2980} Grull Hawkwind
	["You start on the mesa of {area:221}. {npc:2980} and the chief stand by the big tent in the middle."] = "你从{area:221}的台地上出发。{npc:2980}和鹰风酋长站在中央的大帐篷旁。",

	-- Step 2: The Hunt Begins
	["Plainstriders roam the grass all around the camp."] = "平原陆行鸟在营地周围的草地上游荡。",

	-- Step 3: Grull Hawkwind
	-- {npc:3059} Harutt Thunderhorn
	["{npc:3059}, the warrior trainer"] = "{npc:3059}，战士训练师",
	-- {npc:3061} Lanka Farshot
	["{npc:3061}, the hunter trainer"] = "{npc:3061}，猎人训练师",
	-- {npc:3062} Meela Dawnstrider
	["{npc:3062}, the shaman trainer in camp"] = "{npc:3062}，营地里的萨满祭司训练师",
	-- {npc:3060} Gart Mistrunner
	["{npc:3060}, the druid trainer beside him"] = "{npc:3060}，他旁边的德鲁伊训练师",

	-- Step 4: Greatmother Hawkwind
	-- {npc:2991} Greatmother Hawkwind · {object:2907} Water Pitcher
	["{npc:2991} sits by the tent on the camp's eastern edge; the {object:2907} stands next to her."] = "{npc:2991}坐在营地东缘的帐篷旁；{object:2907}就在她旁边。",

	-- Step 6: The Hunt Continues
	-- {npc:6775} Antur Fallow · {npc:2980} Grull Hawkwind
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:6775} stands at the west end of the camp, at the north-west corner of the hills where the Mountain Cougars prowl: take his quest, hunt the cougars from there south and east, then come back up to {npc:2980}."] = "{npc:6775}站在营地西端，位于{npc:2961}出没的山丘西北角：接下他的任务，从那里向南和向东猎杀美洲狮，然后回到{npc:2980}处。",

	-- Step 7: Grull Hawkwind
	-- {npc:3209} Brave Windfeather · {npc:2980} Grull Hawkwind
	["{npc:3209}, next to {npc:2980}"] = "{npc:3209}，在{npc:2980}旁边",

	-- Step 8: Seer Graytongue
	["Follow the path south out of camp to the Seer's tent at the foot of the hills."] = "沿小路向南离开营地，到山脚下灰舌先知的帐篷。",

	-- Step 9: The shrine of An'she and Mu'sha
	["The shrine of An'she and Mu'sha"] = "安瑟与Mu'sha的神龛",
	-- {object:660739} Ritual Fire
	["The incense burns out in ten minutes: run straight east along the southern hills to the {object:660739}."] = "熏香十分钟就会燃尽：沿南边的山丘一直向东跑到{object:660739}。",

	-- Step 10: Brambleblade Ravine
	-- {npc:8554} Chief Sharptusk Thornmantle · {object:3076} Dirt-stained Map
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {object:3076} lies on the ground in the camp."] = "斗猪在神龛北边吃草；刺背野猪人占据着东北方的峡谷。{npc:8554}站在峡谷东端，{object:3076}在营地的地上。",

	-- Step 11: Camp Narache
	["Back west to the camp."] = "向西返回营地。",

	-- Step 12: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache · {quest:1516} Call of Earth
	["{npc:5888} stands in {area:221}. {quest:1516} needs level 4, which you reach with the turn-ins here."] = "{npc:5888}站在{area:221}。{quest:1516}需要4级，交完这里的任务就能达到。",

	-- Step 13: Ritual Salve
	-- {area:358} Brambleblade Ravine
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["Back east to {area:358}: the Bristleback Shamans stand among the quilboar there."] = "向东返回{area:358}：{npc:2953}站在那里的野猪人中间。",

	-- Step 14: Call of Earth
	-- {npc:5888} Seer Ravenfeather · {npc:5891} Minor Manifestation of Earth · {item:6635} Earth Sapta · {item:6656} Rough Quartz
	["Back to {npc:5888} in the camp. The {npc:5891} waits on the mesa east of the camp: drink the {item:6635} there to see it, then take the {item:6656} back to the Seer."] = "回到营地找{npc:5888}。{npc:5891}在营地东边的台地上等候：在那里喝下{item:6635}以看到它，然后把{item:6656}带回给先知。",
	-- {npc:5888} Seer Ravenfeather · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {npc:5873} and your {item:5175}"] = "{npc:5888}：{npc:5873}和你的{item:5175}",

	-- Step 15: Kaga Wildhoof
	-- {area:220} Red Cloud Mesa · {npc:265810} Kaga Wildhoof · {area:222} Bloodhoof Village · {spell:1229451} Boosted Rest
	["Follow the road north out of {area:220}. {npc:265810} waits on the road just south of {area:222}; /sit by her campfire until you get {spell:1229451}."] = "沿道路向北离开{area:220}。{npc:265810}在{area:222}南边不远处的路上等候；在她的营火旁/sit，直到获得{spell:1229451}。",
	-- {spell:1229451} Boosted Rest
	["/sit by Kaga's campfire until you get {spell:1229451}"] = "在Kaga的营火旁/sit，直到获得{spell:1229451}",

	-- Step 16: Bloodhoof Village
	-- {npc:3067} Pyall Silentstride
	["Speak with {npc:3067}"] = "与{npc:3067}交谈",

	-- Step 17: Poison Water
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Prairie Wolves and Adult Plainstriders roam the plains around the village."] = "草原狼和{npc:2956}在村子周围的平原上游荡。",

	-- Step 19: Winterhoof Water Well
	["The well lies south-east of the village."] = "水井在村子东南方。",

	-- Step 21: Chakuyak and Thunderhorn Totem
	-- {quest:96130} Chakuyak · {quest:756} Thunderhorn Totem
	["{quest:96130} and {quest:756}"] = "{quest:96130}和{quest:756}",
	-- {quest:96130} Chakuyak
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker · Flatland Cougars = {npc:3035} Flatland Cougar
	["{quest:96130}, a lone wolf, prowls the plains west of the village. Prairie Stalkers and Flatland Cougars roam the plains north and west of it."] = "{quest:96130}是一只独狼，在村子西边的平原上潜行。{npc:2959}和{npc:3035}在村子北边和西边的平原上游荡。",

	-- Step 22: Back to Bloodhoof
	["Back to Bloodhoof"] = "返回血蹄村",

	-- Step 23: Sparring Match
	-- {npc:3063} Krang Stonehoof
	-- plural, as words: Novice Warriors = {npc:10721} Novice Warrior
	["{npc:3063}'s quest: beat three Novice Warriors (or players in duels) next to him."] = "{npc:3063}的任务：击败他旁边的三名{npc:10721}（或在决斗中击败玩家）。",

	-- Step 25: Ahab Wheathoof
	-- {npc:277182} Ahab Wheathoof · {item:287505} Tender Strider Meat
	["{npc:277182} stands at the north edge of the village. Kyle wants {item:287505} from plainstriders."] = "{npc:277182}站在村子北缘。Kyle想要平原陆行鸟身上的{item:287505}。",

	-- Step 26: Thunderhorn Water Well
	-- {object:2912} Ambercorn · {quest:766} Mazzranache · {quest:761} Swoop Hunting
	-- plural, as words: Well Stones = {object:2910} Well Stone
	["The well lies north of the village. Well Stones sit around the well, {object:2912} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "水井在村子北边。水井石在水井周围，{object:2912}在附近的树下。沿途击杀狼、美洲狮、平原陆行鸟和猛鹫，完成{quest:766}和{quest:761}。",

	-- Step 27: Bloodhoof Village
	-- {npc:277182} Ahab Wheathoof
	["{npc:277182}, at the north end of the village"] = "{npc:277182}，在村子北端",

	-- Step 28: Swoop Hunting
	["Swoops glide over the plains all around Bloodhoof."] = "猛鹫在血蹄村周围的平原上空滑翔。",

	-- Step 29: Morin Cloudstalker
	-- {npc:2988} Morin Cloudstalker · {area:396} Winterhoof Water Well
	["{npc:2988} camps by the {area:396} south-east of Bloodhoof."] = "{npc:2988}在血蹄村东南方的{area:396}旁扎营。",

	-- Step 30: Longwalker Malah
	-- {npc:275789} Malah Longwind · {area:821} Rolling Plains
	["{npc:275789} stands on the {area:821} a little east of the well."] = "漫行者{npc:275789}站在水井东边不远处的{area:821}上。",

	-- Step 31: Prairie Wolf Alphas
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Prairie Wolf Alphas"] = "草原狼前锋",
	-- {npc:275789} Malah Longwind
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Prairie Wolf Alphas roam among the wolves on the plains around {npc:275789} and the Galak camp to the east."] = "草原狼前锋在{npc:275789}和东边加拉克营地周围的平原上，混在狼群中游荡。",

	-- Step 32: The Ravaged Caravan
	-- {zone:1456} Thunder Bluff
	["The wrecked caravan lies north-west of the centaurs, east of the road to {zone:1456}."] = "被毁的商队在半人马西北方、通往{zone:1456}的道路东边。",

	-- Step 34: Mazzranache
	["Finish the wolf heart, cougar femur, plainstrider scale and swoop gizzard on the plains around the village."] = "在村子周围的平原上收集完狼心、美洲狮股骨、陆行鸟鳞片和猛鹫胃。",

	-- Step 36: Morin Cloudstalker
	-- {area:396} Winterhoof Water Well
	["Back south-east to the {area:396}."] = "向东南返回{area:396}。",

	-- Step 37: Galak centaurs
	["Galak centaurs"] = "加拉克半人马",
	-- {npc:275767} Herak the Pillager
	["The Galak centaurs camp on the plains east of the well; {npc:275767} leads them."] = "加拉克半人马在水井东边的平原上扎营；{npc:275767}是他们的首领。",

	-- Step 38: The Venture Co. Mine
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes
	["The goblins work the mine in the hills north-east of the well. {quest:765} stands in the back of the mine; his {item:281031} start {quest:98424}, and the other pages lie inside the mine."] = "地精在水井东北方的山丘里开矿。{quest:765}站在矿洞深处；他的{item:281031}开始{quest:98424}，其余几页在矿洞里。",

	-- Step 39: Wildmane Water Well
	-- {zone:1456} Thunder Bluff · {area:398} Wildmane Water Well · {zone:1412} Mulgore
	["Cross north-west past {zone:1456} to the {area:398} in the far north of {zone:1412}."] = "向西北经过{zone:1456}，到{zone:1412}最北边的{area:398}。",

	-- Step 40: Dangers of the Windfury
	-- {area:819} Windfury Ridge
	["The Windfury harpies hold {area:819}, north and west of the well."] = "风怒鹰身人占据着水井北边和西边的{area:819}。",

	-- Step 41: Seer Wiserunner
	-- {npc:2984} Seer Wiserunner · {area:404} Bael'dun Digsite
	["{npc:2984} stands at the edge of the {area:404}, south of the well."] = "{npc:2984}站在水井南边的{area:404}边缘。",

	-- Step 42: Dwarven Digging
	-- {area:404} Bael'dun Digsite
	-- plural, as words: Prospector's Picks = {item:4702} Prospector's Pick
	["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the dwarves' forge in the digsite."] = "{area:404}的矮人带着勘察员的锄头。在挖掘场里矮人的熔炉上砸碎它们。",
	-- {item:4703} Broken Tools
	["{item:4703}, at the digsite forge"] = "{item:4703}，在挖掘场的熔炉旁",

	-- Step 43: Sharing the Land
	-- {area:818} Palemane Rock · {npc:272203} Perith Stormhoof
	["The Palemane gnolls hold {area:818}, south of the digsite and west of Bloodhoof. {npc:272203} is held in their camp: lead him out."] = "白鬃豺狼人占据着挖掘场南边、血蹄村西边的{area:818}。{npc:272203}被关在他们的营地里：带他出来。",

	-- Step 44: Bloodhoof Village
	-- {npc:2993} Baine Bloodhoof · {npc:3057} Cairne Bloodhoof · {zone:1456} Thunder Bluff
	["{npc:2993}, for {npc:3057} in {zone:1456}"] = "{npc:2993}，交给{zone:1456}的{npc:3057}",
	-- {npc:2948} Mull Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:2948}, for Hamuul in {zone:1456}"] = "{npc:2948}，交给{zone:1456}的大德鲁伊哈缪尔·符文图腾",

	-- Step 46: Red Rocks
	-- {area:225} Red Rocks · {zone:1456} Thunder Bluff · {npc:3233} Lorekeeper Raintotem · {npc:2994} Ancestral Spirit
	-- plural, as words: Bristleback Interlopers = {npc:3232} Bristleback Interloper
	["Head north to {area:225}, east of {zone:1456}. {npc:3233} stands at the foot of the rocks; the Bristleback Interlopers dig at the burial ground and the {npc:2994} waits on top."] = "向北到{zone:1456}东边的{area:225}。{npc:3233}站在岩石脚下；{npc:3232}在墓地里挖掘，{npc:2994}在顶上等候。",
	-- {item:5203} Flatland Prowler Claw · {area:225} Red Rocks
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler
	["{item:5203}: Flatland Prowlers roam the plains around {area:225}"] = "{item:5203}：平原徘徊者在{area:225}周围的平原上游荡",

	-- Step 47: Thunder Bluff
	-- {npc:2995} Tal · {npc:3057} Cairne Bloodhoof
	["Ride a lift up to the mesas. {npc:2995} keeps the wind riders on the central rise; {npc:3057} stands in the great tent there."] = "乘升降梯上到台地。{npc:2995}在中央台地照看双足飞龙；{npc:3057}站在那里的大帐篷里。",

	-- Step 48: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068}想要牛头人熏香：从草药商{npc:3014}、附魔供应商{npc:3012}、制皮供应商{npc:3005}和烹饪供应商{npc:3027}处购买四种材料，然后合成{item:278078}。",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}，来自{npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}，来自{npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}，来自{npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}，来自{npc:3027}",

	-- Step 49: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "在{area:1641}朝南的悬崖上，于仪式垫和香炉处使用{item:278078}。",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "在{area:1641}散播{item:278078}",
	-- {npc:3441} Melor Stonehoof · {quest:860} Sergra Darkthorn · {area:380} Crossroads
	["{npc:3441}: for {quest:860} at the {area:380}"] = "{npc:3441}：交给{area:380}的{quest:860}",

	-- Step 51: Elder Rise
	-- {npc:5769} Arch Druid Hamuul Runetotem · {npc:3448} Tonga Runetotem · {area:380} Crossroads
	["{npc:5769}: for {npc:3448} at the {area:380}"] = "{npc:5769}：交给{area:380}的{npc:3448}",

	-- Step 53: Turak Runetotem
	-- {npc:6746} Innkeeper Pala · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:6746} on the central rise sends you to {npc:3033} on {area:1639}."] = "中央台地的{npc:6746}让你去{area:1639}找{npc:3033}。",

	-- Step 54: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the north-western woods."] = "施放{spell:18960}。{npc:11802}在{area:2361}；{quest:5930}在西北方的树林里。",

	-- Step 55: Back to Thunder Bluff
	-- {area:222} Bloodhoof Village · {area:1639} Elder Rise
	["Hearth to {area:222} and ride north to {area:1639}."] = "用炉石返回{area:222}，然后向北骑到{area:1639}。",

	-- Step 56: Yaw Sharpmane
	-- {area:222} Bloodhoof Village · {item:15908} Taming Rod · {npc:2956} Adult Plainstrider · {npc:2959} Prairie Stalker
	["Ride down to {area:222} and tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a Swoop to the north-west."] = "骑到{area:222}，用{item:15908}驯服：平原上的一只{npc:2956}，村子北边的一只{npc:2959}，西北方的一只猛鹫。",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "用{item:15908}驯服它",

	-- Step 57: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {zone:1412} Mulgore · {item:15710} Cenarion Lunardust
	["The stone stands in the pass out of {zone:1412}, on your way east. Use the {item:15710} there and defeat Lunaclaw."] = "石头在离开{zone:1412}的山口里，就在你向东的路上。在那里使用{item:15710}并击败月爪枭兽。",

	-- Step 58: Crossroads
	-- {zone:1412} Mulgore · {area:380} Crossroads · {quest:860} Sergra Darkthorn · {npc:3448} Tonga Runetotem · {zone:1413} The Barrens
	["Leave {zone:1412} by the south-eastern pass and follow the road to the {area:380}. {quest:860} stands by the inn, {npc:3448} at the south gate. {zone:1413} guide starts here."] = "从东南方的山口离开{zone:1412}，沿道路到{area:380}。{quest:860}站在旅店旁，{npc:3448}在南门。{zone:1413}指南从这里开始。",

	-- Step 59: Class turn-ins in Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Class turn-ins in {area:1638}"] = "在{area:1638}交职业任务",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {item:4851} lies on the ground in the camp."] = "斗猪在神龛北边吃草；刺背野猪人占据着东北方的峡谷。{npc:8554}站在峡谷东端，{item:4851}在营地的地上。",
	-- ["Flatland Prowlers roam the plains around {area:225}"] = "{npc:3566}在{area:225}周围的平原上游荡",
	-- ["Galak centaurs and Prairie Wolf Alphas"] = "加拉克半人马和{npc:2960}",
	-- ["The Galak centaurs camp on the plains north of the {area:821}; Herak leads them. Prairie Wolf Alphas roam among the wolves."] = "加拉克半人马在{area:821}北边的平原上扎营；掠夺者赫拉克是他们的首领。{npc:2960}在狼群中游荡。",
	-- ["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the forge in {area:222}."] = "{area:404}的矮人带着{item:4702}。在{area:222}的熔炉上砸碎它们。",
	-- ["The well lies north of the village. Well Stones sit around the well, {item:4809} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "水井在村子北边。{item:4808}在水井周围，{item:4809}在附近的树下。沿途击杀狼、美洲狮、平原陆行鸟和猛鹫，完成{quest:766}和{quest:761}。",
	-- ["The {area:380}"] = "{area:380}",
	-- ["{npc:2991} sits by the tent on the camp's eastern edge; the {item:4755} stands next to her."] = "{npc:2991}坐在营地东缘的帐篷旁；{item:4755}就在她旁边。",
}
