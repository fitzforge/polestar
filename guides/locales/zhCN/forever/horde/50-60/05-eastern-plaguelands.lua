-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1423} Eastern Plaguelands · {zone:1448} Felwood
	["Western & {zone:1423} & {zone:1448}"] = "西瘟疫之地, {zone:1423} & {zone:1448}",
	-- {area:152} The Bulwark · {zone:1448} Felwood · {zone:1452} Winterspring
	["{area:152} and both Plaguelands, then {zone:1448} and {zone:1452}."] = "{area:152}和东西两片瘟疫之地，然后是{zone:1448}和{zone:1452}。",

	-- Step 1: The Bulwark
	-- {area:199} Felstone Field · {area:152} The Bulwark · {npc:11055} Shadow Priestess Vandis
	["Back west along the road from {area:199} to the {area:152}: {npc:11055} takes the cauldron's report."] = "",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: his termites are in {area:2627}, later in this guide"] = "",

	-- Step 2: Dalson's Tears
	-- {area:199} Felstone Field · {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road past {area:199}, {npc:11077} guards the cauldron at {area:200}: kill him for the key, then use the cauldron."] = "",

	-- Step 4: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "安多哈尔的哨塔和粮仓",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite · Skeletal Warlords = {npc:1788} Skeletal Warlord
	["Ride south-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by each grain silo on the north side of town, one silo after another, to bring out Temporal Parasites (55-57): fight them one at a time and let the biggest go.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room.\nCareful: Skeletal Warlords, level 56-57 elites, stand by the first and second towers (the south-western and the western one): mark those towers from the far side of the doorway once the Warlord has turned away, and never pull one. Putridius (58, rare) walks among the silos."] = "向西南骑进安多哈尔。{npc:10667}在镇子西侧被毁的旅店里等候。拿着{item:12815}站在四座塔每座的门口来标记它；沿着镇子边缘走。在镇子北侧的每个粮仓旁使用{item:12627}，一个接一个，引出时间寄生虫（{npc:10717}，55-57）：一次打一只，放过最大的。\n小心：{npc:10996}，58-59级精英，可能站在安多哈尔，就像在{zone:1422}的许多其他地点一样：离它远点。\n小心：骷髅督军（{npc:1788}），56-57级精英，站在第一和第二座塔旁（西南和西边的那座）：等督军转过身后，从门口的远侧标记这些塔，绝不要拉它们。普崔迪乌斯（58，稀有）在粮仓之间走动。",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}：在楼上",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}标记{npc:10903}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}标记{npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}标记{npc:10905}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}标记{npc:10902}",

	-- Step 5: Chromie
	["Upstairs"] = "在楼上",

	-- Step 6: Counting Out Time
	-- {npc:10667} Chromie · {npc:1805} Flesh Golem
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth. A {npc:1805}, a level 56-57 elite, stands among the houses just east of the inn: take the boxes on the west side first and keep clear of it."] = "",

	-- Step 9: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "向西前往 {area:152}。",

	-- Step 10: Apothecary Dithers
	-- {quest:838} Scholomance · {area:152} The Bulwark
	["Derrington's {quest:838} is offered from level 55: still under 55 here, the next {area:152} stop offers it again."] = "",

	-- Step 11: Skeletal Fragments
	-- {area:152} The Bulwark
	["The skeletons on the fields east of the {area:152} drop the fragments: take them on the ride east."] = "",

	-- Step 12: Target: Writhing Haunt
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt · {npc:11076} Cauldron Lord Razarch
	["East past {area:200} to the {area:202}: {npc:11076} guards its cauldron."] = "",
	-- {npc:11055} Shadow Priestess Vandis · {area:152} The Bulwark · {zone:1423} Eastern Plaguelands
	["from the cauldron, for {npc:11055} at the {area:152}: on the way back west, after the {zone:1423}"] = "",

	-- Step 13: Mulgris Deepriver
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "你在路线之前来这里时错过了这一步：现在先做它。它很快，还会开启后面的任务。",
	["Inside"] = "在里面",

	-- Step 16: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1423} Eastern Plaguelands
	["{npc:10739} waits inside the farmhouse at the {area:202}, by the cauldron; his bears roam the hills north and east of it, towards the {zone:1423}."] = "",

	-- Step 17: Diseased Grizzlies
	["Diseased Grizzlies"] = "生病的灰熊",
	["Careful: the grizzlies are 55-56: pull them one at a time."] = "",

	-- Step 19: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "进入{zone:1423}",

	-- Step 20: Tirion Fordring
	-- {zone:1423} Eastern Plaguelands · {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east along the road into the {zone:1423}. {npc:1855} lives in a small house by the {area:2619}, just north of the road at the border; his three hunts are on this guide's ground."] = "沿道路向东骑入{zone:1423}。{npc:1855}住在{area:2619}边的一座小屋里，就在边界处道路北侧；他的三个狩猎任务都在本指南的区域内。",

	-- Step 22: Light's Hope Chapel
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {object:92525} Argent Dawn
	["Follow the road east from the {zone:1422}, over the river and across the whole {zone:1423}, to the {object:92525}'s chapel in the far east."] = "沿道路从{zone:1422}向东走，过河后穿越整个{zone:1423}，前往最东边{object:92525}的礼拜堂。",

	-- Step 23: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "{npc:10926}的鬼魂站在西南方{area:2262}的废墟中。",

	-- Step 24: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "娃娃的头和两侧身体散落在{npc:10926}周围的房屋里；在背包里把它们组合起来。",

	-- Step 25: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}"] = "带给{area:2268}的{npc:11063}的口信",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "留着{quest:5152}：{npc:10927}住在{zone:1422}的{area:197}。",

	-- Step 26: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "扎尔达尔潜伏在{area:2262}西边不远处。",
	["Below ground"] = "在地下",

	-- Step 27: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "小心：{npc:10411}脱离战斗时会隐形，战斗开始后会召唤岩翼石像鬼。它们只有3只，每15分钟刷新一次。",

	-- Step 28: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "返回{area:2268}",
	-- {quest:5211} Defenders of Darrowshire · {area:2264} Corin's Crossing
	["{quest:5211}'s spirits come with the {area:2264} stop later in this guide: keep it."] = "{quest:5211}的灵魂会在本指南稍后前往{area:2264}时完成：留着它。",

	-- Step 29: Caretaker Alen
	-- {npc:11038} Caretaker Alen · {quest:5281} The Restless Souls · {spell:437801} Light's Hope
	["{npc:11038} offers {quest:5281} from level 55; under it, the next {spell:437801} stop offers it again."] = "",
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}: for {npc:11140} in {area:2627} later in this guide"] = "",

	-- Step 30: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "飞往{area:272}",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "{area:2268}的飞行管理员",

	-- Step 31: To Sorrow Hill
	-- {area:197} Sorrow Hill
	["To {area:197}"] = "前往{area:197}",

	-- Step 32: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "从{area:272}沿道路向北骑行。{npc:10927}的房子就在{area:197}的路边，{npc:10936}的纪念碑在房子后面的墓地里。",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "{npc:10927}，在楼上",

	-- Step 33: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "向西北骑进安多哈尔。{npc:10667}在镇子西侧被毁的旅店里等候；里面的骷髅是54-57级，所以沿着边缘走。",

	-- Step 34: The Annals of Darrowshire
	-- {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room."] = "编年史混在安多哈尔市政厅的发霉的书籍中；逐一打开，直到找到正确的那本。\n小心：安多哈尔可能有{npc:10996}（58-59级精英），{zone:1422}的许多其他地点也会出现：离它远点。",

	-- Step 36: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "飞往{area:2268}",
	-- {area:272} Tarren Mill · {area:2268} Light's Hope Chapel
	["Ride back south to {area:272} and fly to {area:2268}."] = "向南骑回{area:272}，然后飞往{area:2268}。",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "{area:272}的飞行管理员",

	-- Step 37: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen · {quest:5281} The Restless Souls
	["{npc:11038}, if you didn't take {quest:5281} on the last stop"] = "",
	-- {npc:11063} Carlin Redpath · {area:190} Hearthglen
	["{npc:11063}'s Heroes of Darrowshire needs a group in {area:190} and a ride back here at the end: leave it."] = "",

	-- Step 38: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}：沿途击杀以下目标",
	-- {item:12957} Shattered Sword of Marduk · {area:2264} Corin's Crossing
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground. The {item:12957} lies at the bottom of the gorge west of {area:2264}. Careful: the biggest Plaguehounds are 56, pull them one at a time."] = "",
	-- {area:2264} Corin's Crossing
	["At the bottom of the gorge west of {area:2264}"] = "",

	-- Step 39: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His Ranger hunt (Rangers 59-60, in the north) is above you on this trip: leave it."] = "",

	-- Step 40: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "瘟疫幼犬和瘟疫蝙蝠在{area:2260}北边的山丘上游荡，腐肉虫在它们中间爬行；一路向北朝{area:2627}推进。",

	-- Step 41: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale · {npc:12384} Augustus the Touched · {npc:16184} Nerubian Overseer · {area:2626} Terrorweb Tunnel
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit · Crypt Horrors = {npc:8557} Crypt Horror · Crypt Walkers = {npc:8556} Crypt Walker
	-- was: ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut.\nCareful: Terrordale Spirits (59-60) drift through the north-west corner just north of {npc:11140}'s hut, and Crypt Horrors (57-58) and Crypt Walkers (55-56) stand around it; some of them root you. Walk in slowly and pull one at a time."] = "幽灵{npc:11140}站在{area:2627}西北角的一间小屋旁；{npc:12384}坐在小屋里。\n小心：恐惧谷之魂（{npc:14564}，59-60）在{npc:11140}的小屋以北的西北角飘荡，墓穴恐魔（{npc:8557}，57-58）和墓穴行者（{npc:8556}，55-56）站在周围；其中一些会定身你。慢慢走进去，一次拉一只。"
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut.\nCareful: Terrordale Spirits (59-60) drift through the north-west corner just north of {npc:11140}'s hut, and Crypt Horrors (57-58) and Crypt Walkers (55-56) stand around it; some of them root you. Walk in slowly and pull one at a time.\nCareful: a {npc:16184} (60, elite) walks {area:2627} and the {area:2626} south-west of it. Look for him before you ride in, and wait for him to pass."] = "",
	-- {npc:12384} Augustus the Touched
	["{npc:12384}, inside"] = "{npc:12384}，在屋内",

	-- Step 42: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "{area:2627}：遇到就顺手击杀",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound · Ziggurat Protectors = {npc:12262} Ziggurat Protector
	["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass.\nCareful: Ziggurat Protectors (58, elite) stand by the ziggurats east and north-east of the town: take the mounds nearer the town and stay clear of them."] = "书在{area:2627}被毁的旅店里；镇上的亡灵是54-56级，一次引一只。\n大白蚁丘遍布{area:2627}东边的山丘。路过每个白蚁丘时都对它使用{item:15042}。\n小心：通灵塔保护者（58级，精英）守在镇子东边和东北边的通灵塔旁：选靠近镇子的白蚁丘，远离它们。",
	-- {quest:5510} Minion's Scourgestones · {area:2627} Terrordale · {item:12846} Argent Dawn Commission
	["{quest:5510}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5510}：佩戴{item:12846}时，{area:2627}的亡灵会掉落",

	-- Step 43: Augustus the Touched
	-- {npc:11615} Mickey Levine · {area:152} The Bulwark
	["Keep the termites: {npc:11615} at the {area:152} takes them on this guide's ride back west."] = "",

	-- Step 44: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}：沿途击杀以下目标",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the Monstrous Plaguebats up to 58: take the 57s one at a time and leave the 58s."] = "",

	-- Step 45: Eastern Plaguelands: kill these as you meet them
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "头骨就在{area:2622}里，周围是荒芜水元素和瘟疫水元素。",
	["Underwater"] = "在水下",

	-- Step 46: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility · {quest:5211} Defenders of Darrowshire · {npc:11063} Carlin Redpath
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant · Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Ride south to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "沿道路向南骑往{area:2264}。{item:15447}十分钟内就会变质：快速杀死镇上的天灾军团，然后立刻用{item:15454}把七块研磨好。\n小心：无影仆从血量降到40%时会呼叫25码内的同伴求援。脱离战斗时它们还会用{spell:10228}隐形。如果在镇子里触发求援，大量怪物可能加入战斗。在镇子外围战斗可以降低这种风险。\n如果你的任务日志里有{quest:5211}（来自本指南开头的{npc:11063}），镇子周围的天灾军团死后会留下达隆郡居民的灵魂：与每一个交谈以解放它。先解放它们，再开始收集{item:15447}。",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "解放达隆郡之魂：与它们交谈",
	-- {npc:8530} Cannibal Ghoul · {npc:11064} Darrowshire Spirit
	["{npc:8530}: a {npc:11064} rises where one dies"] = "{npc:8530}：一个死去的地方会升起{npc:11064}",
	-- {npc:8531} Gibbering Ghoul
	["{npc:8531}: leaves a spirit too"] = "{npc:8531}：也会留下一个灵魂",
	-- {npc:8532} Diseased Flayer
	["{npc:8532}: leaves a spirit too"] = "{npc:8532}：也会留下一个灵魂",

	-- Step 47: Carlin Redpath
	-- {area:2268} Light's Hope Chapel
	["Ride east along the road to {area:2268}."] = "",

	-- Step 48: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride back west along the road to the {area:2260}."] = "",

	-- Step 49: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride north-west to {npc:1855}'s hut by the {area:2619} and hear him out."] = "",

	-- Step 50: Undercroft
	-- {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft · {area:2260} Marris Stead
	["{npc:11886} lurks in the {area:2261}, the crypt just south of the {area:2260}.\nCareful: about four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",

	-- Step 51: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Back north-west to {npc:1855}'s hut."] = "",
	-- {npc:1855} Tirion Fordring
	["{npc:1855}'s next errand, Of Lost Honor, leads into the Mossflayer trolls (57-59) of the far north-east: leave it."] = "",

	-- Step 52: Kirsta Deepshadow
	-- {npc:1855} Tirion Fordring · {zone:1422} Western Plaguelands · {npc:11610} Kirsta Deepshadow · {area:192} Northridge Lumber Camp · {area:152} The Bulwark
	["Ride west from {npc:1855}'s hut into the {zone:1422}: {npc:11610} hides on the hill north-east of the {area:192}, on the way to the {area:152}."] = "",
	-- {npc:11615} Mickey Levine · {area:152} The Bulwark
	["Her Scarlets wait until {npc:11615} has given you the termite barrel at the {area:152}: the barrel goes down in the same lumber mill."] = "",

	-- Step 54: The Bulwark
	-- {area:152} The Bulwark
	["On west to the {area:152}."] = "",

	-- Step 56: High Executor Derrington
	-- {area:152} The Bulwark · {quest:838} Scholomance · {quest:964} Skeletal Fragments · {area:201} Gahrron's Withering
	["Under 55 on the first {area:152} stop? Derrington's {quest:838} is offered now: Dithers' {quest:964} come from the skeletons on the ride back west from {area:201}."] = "",

	-- Step 58: Scarlet Crusade
	["Scarlet Crusade"] = "血色十字军",
	-- {area:192} Northridge Lumber Camp · {npc:11615} Mickey Levine · {item:15044} Barrel of Plagueland Termites · {object:177491} Termite Barrel · {quest:5902} A Plague Upon Thee · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	["Back north-east to the {area:192}: knights and magi work the camp, the medics and hunters camp south of it. In the middle of the lumber mill, stand by the crate and use {npc:11615}'s {item:15044} from your bags to set it on top; then click the {object:177491} that appears: it finishes {quest:5902} and gives the next part for {npc:11615}. Careful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "",

	-- Step 60: Radley and Durgen
	["Radley and Durgen"] = "",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} 站在伐木营地东边；{npc:11611} 守在 {npc:11610} 东北、通往 {area:190} 的道路旁。\n小心：塔底有守卫，另有一名绕塔巡逻。与杜根·挽锤交战前先清掉它们，避免它们加入战斗。",

	-- Step 61: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11610}'s last errand looks over {area:190}, among Scarlets of 58-60: leave it."] = "",

	-- Step 62: Target: Gahrron's Withering
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south-east to {area:201}, the farm under the eastern hills: {npc:11078} (58) guards its cauldron. Kill him for the key, then use the cauldron.\nCareful: Soulwrath is about two levels over you here: clear the ghouls around the cauldron first, start at full health and use your cooldowns on him."] = "",

	-- Step 63: Skeletal Fragments
	-- {area:200} Dalson's Tears · {area:199} Felstone Field
	["On the ride back west, the skeletons on the fields around {area:200} and {area:199} (50-53) drop the fragments."] = "",

	-- Step 64: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152} one last time."] = "最后一次向西返回{area:152}。",

	-- Step 66: Class trainer
	["Class trainer"] = "职业训练师",
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop (Mages teleport). Train before the flight."] = "",

	-- Step 67: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飞往{area:1638}",
	-- {area:1638} Thunder Bluff · {quest:1000} The New Frontier · {zone:1452} Winterspring · {quest:1123} Rabine Saturna · {zone:1450} Moonglade · {zone:1451} Silithus
	["Only if {area:1638}'s {quest:1000} is still open for you (the {zone:1452} guide's stop offers it from level 54): it opens {quest:1123} in {zone:1450} and her {zone:1451} chain, so fly there first."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 68: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "飞往{area:431}",
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop (Mages teleport). Then the flight master."] = "",

	-- Step 69: Fly to Thunder Bluff
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop. Then the flight master."] = "",

	-- Step 70: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "{npc:3033}（德鲁伊）在{area:1639}提供训练，{npc:246344}（圣骑士）也在城里。",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{area:1639}的{npc:3033}；{npc:246344}",

	-- Step 71: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {area:1641} Hunter Rise
	["{npc:10881} stands on {area:1641}."] = "",

	-- Step 72: Arch Druid Hamuul Runetotem
	-- {area:1639} Elder Rise
	["Hamuul is on {area:1639}."] = "",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} is in {zone:1450}, later in this guide."] = "",

	-- Step 73: Fly to Splintertree Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飞行管理员",

	-- Step 74: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "",
	-- {npc:10922} Greta Mosshoof · {zone:1413} Barrens
	["{npc:10922}: the Cleansed Water from Islen in the {zone:1413}"] = "",

	-- Step 75: Dousing the Flames of Protection
	-- {area:1763} Jaedenar · {area:1770} Shadow Hold · {item:12906} Purified Moonwell Water
	["Ride north-west to {area:1763} and go down into {area:1770}, the cave in its north: the four braziers stand inside. Use Greta's {item:12906} from your bags on each one. Careful: Shadow Council mobs of level 53-55 fill the cave and often come in linked groups, many with stuns: pull them one group at a time."] = "",

	-- Step 76: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "向南回到翡翠圣地，路程很短。",

	-- Step 77: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar · {npc:9529} Maybess Riverbreeze · {item:11511} Cenarion Beacon
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["{npc:9861}, {npc:9860} and {npc:9517} (57) wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go. Careful: the three bosses fight as a group: kill the nearby mobs first so you don't pull extra enemies. The cultists' Corrupted Soul Shards show only while you carry {npc:9529}'s {item:11511} (from Cleansing Felwood): without it, skip them."] = "",
	-- {npc:9529} Maybess Riverbreeze
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["Corrupted Soul Shards from the cultists, for {npc:9529}' Salve via Hunting"] = "",

	-- Step 78: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Enforcers = {npc:7114} Jaedenar Enforcer
	["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "掉落了一把{item:13140}：暗影堡的加德纳尔执行者、织暗者、术士和军团士兵偶尔会携带。使用它接取任务，离开时顺便把{npc:11018}从洞穴南端的笼子里救出来。",

	-- Step 79: Captured Arko'narin
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, below ground"] = "{npc:11016}：在地下",
	-- {npc:11016} Captured Arko'narin · {area:1770} Shadow Hold
	["{npc:11016}: lead her out of {area:1770}"] = "",

	-- Step 80: Rescue From Jaedenar
	-- {npc:11018} Arko'narin · {npc:11019} Jessir Moonbow · {area:2479} Emerald Sanctuary
	["Escort {npc:11018}: she first goes to where Lightforge and her gear are held, then out through the cave. Keep her alive: she fights beside you, and the cultists you didn't clear on the way in come at you both. {npc:11019} takes her report at the {area:2479}, next."] = "",
	-- {area:1770} Shadow Hold
	["out of {area:1770}, at its mouth"] = "",

	-- Step 81: Maybess Riverbreeze
	-- {npc:9529} Maybess Riverbreeze
	["Back south to the Sanctuary: {npc:9529} takes the shards on the west side of the camp."] = "",

	-- Step 83: Jessir Moonbow
	-- {npc:11019} Jessir Moonbow · {npc:11018} Arko'narin
	["{npc:11019}, at the Sanctuary's east side, takes {npc:11018}'s report."] = "",
	-- {npc:11019} Jessir Moonbow · {npc:9518} Rakaiah · {area:1763} Jaedenar · {zone:1448} Felwood
	["{npc:11019}: {npc:9518}, in {area:1763}, on the last guide's ride north through {zone:1448}"] = "",

	-- Step 84: Deadwood Cauldron
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	-- was: ["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "沿路向北骑行。大锅在{area:1769}西南不远处的{area:1762}；那里的死木熊怪是敌对的。"
	["Ride north up the whole {zone:1448} road, past {area:1997}. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "",

	-- Step 85: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {area:1769} Timbermaw Hold · {npc:11558} Kernda · {zone:1448} Felwood
	["Only if a {quest:8471} dropped for you and you are Neutral with the Timbermaw (the {area:1769} reputation guide gets you there): {npc:11558} waits at the {zone:1448} entrance of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558}在附近巡逻，请在地图标示的圆圈内寻找",

	-- Step 87: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {quest:5527} A Reliquary of Purity · {area:2577} Dire Maul
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}.\n{npc:11801} offers {quest:5527} only after you have been inside {area:2577} once: if he doesn't offer it, carry on without it."] = "",

	-- Step 88: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "两个任务都通往{zone:1451}：留着它们。",

	-- Step 90: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["From the tunnel's {zone:1452} exit, ride south to {area:2246}."] = "从隧道的{zone:1452}出口向南骑往{area:2246}。",

	-- Step 91: Donova Snowden
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "{quest:5086}在{zone:1448}，以后才会去，先保留任务。",

	-- Step 92: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "月光枭兽",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Careful: they are 57-58: pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "向东骑往{area:2255}，再从那里向北出去；月光枭兽在{area:2241}南坡的山丘上游荡。小心：它们是57-58级：一次引一只。\n小心：60级精英冰雹怨灵聚集在{area:2255}东南方的雪原上，那里也有少量月光枭兽游荡：待在镇子北边的山坡上。",

	-- Step 93: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "完美的雪人角",
	-- {area:2255} Everlook
	["Umi's horns, carried from your last {area:2255} stop: the yeti hills start just south-east of {area:2255}. Only Matriarchs and Patriarchs drop horns, and the Patriarchs reach 58: pull them one at a time."] = "乌米的角，从上次{area:2255}之行带过来的任务：雪人山丘就在{area:2255}东南不远处。只有雪人女族长和雪人族长会掉落角，族长最高58级：一次引一只。",

	-- Step 94: Umi Rumplesnicker
	-- {area:976} Gadgetzan · {area:2255} Everlook · {zone:2482} Mount Hyjal · {zone:1451} Silithus
	["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it. {zone:2482} is next: its way in starts here in {area:2255}; {area:976}, Linken's sword and {zone:1451} follow it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "一张破损的卷轴在{area:2260}南边的墓穴{area:2261}的入口处。",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "穿过隧道回去，走{area:618}出口，然后向南骑往{area:2246}。",
	-- ["Back through the tunnel and take the {zone:1452} exit: {npc:11556} stands right where it comes out."] = "穿过隧道回去，走{zone:1452}出口：{npc:11556}就站在出口处。",
	-- ["Back to {area:1638}"] = "返回{area:1638}",
	-- ["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "在{area:976}东边不远处的墓地喝下{item:11243}：它会杀死你，只有以鬼魂形态才能看到{npc:9299}，他在墓地正北方山丘中的一道岩缝里。在那里和他交谈，然后跑回尸体处复活：他让你去找的显眼的墓碑就在那片墓地里。",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "飞往{zone:1458}，乘飞艇前往{zone:1454}，再继续飞往{area:1638}。",
	-- ["Fly to {area:1099}"] = "飞往{area:1099}",
	-- ["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "飞往{area:1099}。角鹰兽的巢在{zone:1444}南部；每个巢里都有一个蛋，用于{object:142071}。",
	-- ["Fly to {area:1497}"] = "飞往{area:1497}",
	-- ["Fly to {area:1997}"] = "飞往{area:1997}",
	-- ["Fly to {area:541}"] = "飞往{area:541}",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "飞往{area:541}，然后向西南穿过安戈洛环形山，前往进入{zone:1451}的山口。下一个指南从山口出口处的{area:3077}开始。",
	-- ["Fly to {area:976}"] = "飞往{area:976}",
	-- ["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "狂怒的瘟疫犬和巨型瘟疫蝙蝠共处于{area:2273}南边、{area:2272}和{area:2271}周围的田野上。",
	-- ["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the biggest Monstrous Plaguebats 58: pull them one at a time."] = "狂怒的瘟疫犬分布在{area:2273}南边{area:2272}和{area:2271}周围的田野；毒性瘟疫蝙蝠在北部田野上空飞行，巨型瘟疫蝙蝠在{area:2272}和{area:2271}周围。小心：瘟疫犬是57-58级，最大的巨型瘟疫蝙蝠是58级：一次引一只。",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "穿过{area:1769}，走隧道通往{area:493}的岔路。{npc:11801}在{area:2361}。",
	-- ["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "穿过{area:1769}，走隧道通往{zone:1450}的岔路。{npc:11801}在{area:2361}。",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "哈米亚躲在东北角{area:2273}的烂苔巨魔中间。",
	-- ["Hameya's mound"] = "哈米亚的土堆",
	-- ["Hameya's scroll"] = "哈米亚的卷轴",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Then the flight master."] = "用炉石回{zone:1454}：炉石自{zone:1447}指南起仍绑定在那里（法师可传送）。然后去找飞行管理员。",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Train before the flight."] = "用炉石回{zone:1454}：炉石自{zone:1447}指南起仍绑定在那里（法师可传送）。坐飞机前先训练。",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide. Then the flight master."] = "用炉石回{zone:1454}：炉石自{zone:1447}指南起仍绑定在那里。然后去找飞行管理员。",
	-- ["Hippogryph eggs"] = "角鹰兽蛋",
	-- ["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "屋内：{quest:4493}，如果你在{zone:1447}指南中于{zone:1454}接了它",
	-- ["Keep the termites: {npc:11615} at the {area:813} takes them on the next guide's ride into the {zone:1422}."] = "保留白蚁：下一份指南骑往{zone:1422}时交给{area:813}的{npc:11615}。",
	-- ["Level 56"] = "56级",
	-- ["On to {zone:1451}"] = "继续前往{zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "在{area:1641}。把毛料、丝绸和魔纹布带在背包里。",
	-- ["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "仅当你掉落了{quest:8471}时：{npc:11558}在{area:1769}的{zone:1448}入口处等候，只有你在木喉要塞声望达到中立时才会和你说话。",
	-- ["Only if you found a {item:12820} flask in {area:618}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "仅当你在{area:618}找到了一瓶{item:12820}时：沿道路向北骑行。大锅在{area:1769}西南不远的{area:1762}；那里的死木熊怪是敌对的。",
	-- ["Only if you still carry {quest:2741}: ride south from {area:1099}; the hippogryph nests are in the south of {zone:1444}, each holds an egg for the Egg-O-Matic."] = "仅当你还带着{quest:2741}时：从{area:1099}向南骑行；角鹰兽的巢在{zone:1444}南部，每个巢里都有一个蛋，用于超级蛋蛋机。",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "瘟疫犬和瘟疫幼犬在教堂西南的湖岸上游荡。",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground.\nThe shattered sword lies on the ground north-west of the lake."] = "瘟疫犬和瘟疫犬幼崽在礼拜堂西南方的湖岸游荡，瘟疫蝙蝠和腐肉虫也在同一带活动。\n破碎的剑在湖泊西北方的地面上。",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground. Careful: the biggest Plaguehounds are 56, pull them one at a time.\nThe shattered sword lies on the ground north-west of the lake."] = "瘟疫犬和瘟疫犬幼崽在礼拜堂西南方的湖岸游荡，瘟疫蝙蝠和腐肉虫也在同一带活动。小心：最大的瘟疫犬是56级，一次引一只。\n破碎的剑在湖泊西北方的地面上。",
	-- ["Ride east out of the {area:1497} along the road; the {area:152} guards the way into the {area:28}."] = "沿道路向东骑出{area:1497}；{area:152}守卫着进入{area:28}的通道。",
	-- ["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "向东骑往{area:2255}，再从那里向北出去；月光枭兽在{area:2241}南坡的山丘上游荡。一次引一只。\n小心：60级精英Hailspite聚集在{area:2255}东南方的雪原上，那里也有少量月光枭兽游荡：待在镇子北边的山坡上。",
	-- ["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "沿路向北骑行。大锅在{area:1769}西南不远处的{area:1762}；那里的死木熊怪是敌对的。",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk."] = "从小屋沿道路向南骑往{area:2264}。{item:15447}十分钟内就会变质：快速杀死镇上的天灾军团，然后立刻用{item:15454}把七块研磨好。\n小心：隐形仆从血量降到40%时会呼叫25码内的同伴求援。脱离战斗时它们还会用{spell:10228}隐形。如果在镇子里触发求援，大量怪物可能加入战斗。在镇子外围战斗可以降低这种风险。",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the end of the Un'Goro guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "从小屋沿道路向南骑往{area:2264}。{item:15447}十分钟内就会变质：快速杀死镇上的天灾军团，然后立刻用{item:15454}把七块研磨好。\n小心：隐形仆从血量降到40%时会呼叫25码内的同伴求援。脱离战斗时它们还会用{spell:10228}隐形。如果在镇子里触发求援，大量怪物可能加入战斗。在镇子外围战斗可以降低这种风险。\n如果你的任务日志里有{quest:5211}（来自安戈洛指南末尾的{npc:11063}），镇子周围的天灾军团死后会留下达隆郡之魂：与每一个交谈以解放它。先解放它们，再开始收集{item:15447}。",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "从小屋沿道路向南骑往{area:2264}。{item:15447}十分钟内就会变质：快速杀死镇上的天灾军团，然后立刻用{item:15454}把七块研磨好。\n小心：隐形仆从血量降到40%时会呼叫25码内的同伴求援。脱离战斗时它们还会用{spell:10228}隐形。如果在镇子里触发求援，大量怪物可能加入战斗。在镇子外围战斗可以降低这种风险。\n如果你的任务日志里有{quest:5211}（来自本指南开头的{npc:11063}），镇子周围的天灾军团死后会留下达隆郡之魂：与每一个交谈以解放它。先解放它们，再开始收集{item:15447}。",
	-- ["Ride south from {area:1099}: the hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "从{area:1099}向南骑行：角鹰兽的巢在{zone:1444}南部；每个巢里都有一个蛋，用于{object:142071}。",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {quest:1123} sits inside one of the ruined houses."] = "向西南骑到{area:2738}的废墟，{quest:1123}所需的{object:179565}就在一栋破屋内。",
	-- ["Ride west to the {area:2260}."] = "向西骑往{area:2260}。",
	-- ["Scare {npc:7583} with {item:12928}"] = "用{item:12928}吓唬{npc:7583}",
	-- ["Sword of Marduk"] = "马杜克的破碎之剑",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "编年史混在安多哈尔市政厅的霉烂的书卷中；逐一打开，直到找到正确的那本。",
	-- ["The flight from {area:1997} lands in {zone:1456}: {npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "从{area:1997}起飞的航班降落在{zone:1456}：{npc:3033}（德鲁伊）在{area:1639}训练，{npc:246344}（圣骑士）也在城里。",
	-- ["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. {npc:9997}'s work is in Un'Goro on the next guide's way back north."] = "飞行落点在{area:541}：{npc:9997}站在飞行管理员旁，{npc:8737}在几步外的洞穴边。{npc:9997}的差事要到安戈洛环形山完成，下份指南向北返回时会顺路去。",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "高等精灵游侠、巡路者和护林者守卫着{area:2275}旁的奎尔林斯小屋；奎尔萨拉斯名册就在小屋里。游侠最高60级：一次引一个。路上的田野上空有毒性瘟疫蝙蝠飞过。",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "高等精灵游侠、巡路者和伐木工守卫着{area:2275}旁的小屋；登记册在屋内。游侠最高60级：逐个引怪。途中田野上空有毒性瘟疫蝙蝠飞过。\n头骨在{area:2622}，周围有荒芜水元素和瘟疫畸兽。",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "从安戈洛环形山出来的山口通往{area:3077}，那是{zone:1451}东北部的墓地。{npc:13220}站在坟墓之间。",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "马杜克的破碎之剑就躺在湖西北的地上。",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "头骨就在{area:2622}里，周围是荒芜水元素和瘟疫水元素。",
	-- ["The western hills"] = "西部山丘",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:142071} machine"] = "{object:142071}机器",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675}就在{area:2261}后面。",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: most classes solo it at level 62, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英怪：建议组队，找人一起做。{npc:11897} 是 60 级精英：多数职业在 62 级能单人击败，但你可能需要帮助。独自一人就跳过：路线会让你打怪补回这部分经验。",
	-- ["Top up here to level 56 before the Frenzied Plaguehounds of Northdale (57-58): the Noxious Plaguebats (54-56) over the fields on the way east are at your level, and {npc:11878} wants twenty of them. Or, with a group, run the {area:1583} dungeon (Lower) instead."] = "在对付北谷的狂怒的瘟疫犬（57-58级）之前，先在这里升到56级：向东途中田野上空的毒性瘟疫蝙蝠（54-56级）与你等级相当，{npc:11878}正好要你杀二十只。或者组队去打{area:1583}地下城（下层）。",
	-- ["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it for later."] = "乌米的第三个恶作剧目标是{area:976}、安戈洛环形山和{area:2255}的地精：先留着以后做。",
	-- ["Upstairs"] = "在楼上",
	-- ["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "对{area:976}的地精女孩{npc:7583}使用{item:12928}。{npc:10977}和{npc:10978}在路线后面再吓唬。",
	-- ["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",
	-- ["grind on {npc:8601}"] = "刷{npc:8601}",
	-- ["keep it: the Rangers (59-60) wait for the next guide's second ride into the north"] = "先保留：游侠（59-60级）留到下一份指南第二次骑往北部时再打",
	-- ["{area:1099} flight master"] = "{area:1099}的飞行管理员",
	-- ["{area:2255} flight master"] = "{area:2255}的飞行管理员",
	-- ["{area:976} flight master"] = "{area:976}的飞行管理员",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447}十分钟内就会变质：快速杀死镇上的天灾军团，然后立刻用{item:15454}把七块研磨好。",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "{npc:10778}的农场是{area:152}以东第一座农场。农场里的喋喋不休的食尸鬼携带她护符的另一半；{npc:11075}守着田里的大锅。\n小心：通常有一两只亡灵与他并肩战斗，使用大锅后还可能有更多护锅者来袭。",
	-- ["{npc:10880} walks the {object:172982} and the streets off it: look for him on the way to the flight master's tower; the circle on the map is his walk."] = "{npc:10880}在{object:172982}及其周边街道巡逻：在前往飞行管理员塔楼的路上留意他；地图上的圆圈就是他的巡逻范围。",
	-- ["{npc:10880}: for {npc:7776} at {quest:7492}, at the end of this guide"] = "{npc:10880}：交给{quest:7492}的{npc:7776}，在本指南末尾",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "鬼魂{npc:11140}站在西北角{area:2627}的一间小屋旁。",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut."] = "鬼魂{npc:11140}站在西北角{area:2627}的一间小屋旁；{npc:12384}坐在小屋里。",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut.\nCareful: Terrordale Spirits (59-60) drift through the north-west corner just north of {npc:11140}'s hut, and Crypt Horrors (57-58) and Crypt Walkers (55-56) stand around it; some of them root you. Walk in slowly and pull one at a time."] = "幽灵{npc:11140}站在{area:2627}西北角的一间小屋旁；{npc:12384}坐在小屋里。\n小心：恐惧谷之魂（{npc:14564}，59-60）在{npc:11140}的小屋以北的西北角飘荡，墓穴恐魔（{npc:8557}，57-58）和墓穴行者（{npc:8556}，55-56）站在周围；其中一些会定身你。慢慢走进去，一次拉一只。",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "{npc:15193}的勇士占据着{area:2261}北边{area:2260}的农舍。",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His {npc:8564} hunt, in the north of the zone, waits for the next guide's Plaguelands trip."] = "{npc:15193}的勇士占据着{area:2261}北边{area:2260}的农舍。他的{npc:8564}狩猎任务在本地区北部，留到下一份指南再来瘟疫之地时完成。",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "{npc:15193}的勇士占据着{area:2260}的农舍。",
	-- ["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771}在{area:976}南边通往{area:1336}的路旁扎营。",
	-- ["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565}在{area:2276}附近巡逻，请在地图标出的圆圈内寻找",
	-- ["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299}是{area:976}正北墓地里的一个鬼魂；明显的墓碑在它南边、城墙外面。",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "{object:1661}的飞行管理员在{object:36078}城墙外的西塔上。",
	-- ["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914}要交还给安戈洛的{npc:8737}：留着它。",
	-- ["{quest:3941} goes to {npc:9117} in the cave here, on the next guide's return to {area:541}: keep it."] = "{quest:3941}要交给这里洞穴中的{npc:9117}，下一份指南返回{area:541}时再交，先保留任务。",
	-- ["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086}在{zone:1448}，之后那一趟再去：如果你有就留着。",
	-- ["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "{quest:5168}要的物品在之后的瘟疫之地地区：留着它。",
}
