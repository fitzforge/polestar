-- Chinese (simplified) (zhCN): the guide forever/alliance/40-50/01b-riverglades (forever/alliance/40-50/01b-riverglades.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16724} Farholde Keep
	["About 90 quests in Forever's new zone, from {area:16724}: the level for its port and Western Front."] = "Forever新地区的约90个任务，从{area:16724}开始：适合其港口和西部前线的等级。",

	-- Step 1: Ironforge flight master
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}的飞行管理员",
	-- {zone:1426} Dun Morogh · {zone:1455} Ironforge · {area:69} Lakeshire
	["The Stranglethorn guide leaves Dwarves and Gnomes at their riding trainer in {zone:1426}: ride back west into {zone:1455}, where the flight to {area:69} leaves from the gryphon master."] = "荆棘谷指南把矮人和侏儒留在{zone:1426}的骑术训练师处：向西骑回{zone:1455}，从狮鹫管理员处飞往{area:69}。",

	-- Step 2: Into the Riverglades
	-- {zone:2548} Riverglades
	["Into the {zone:2548}"] = "进入{zone:2548}",
	-- {zone:1455} Ironforge · {area:69} Lakeshire · {area:2417} Blackrock Pass · {zone:2548} Riverglades · {area:16737} Bristle Hills
	["Fly from {zone:1455} to {area:69} in Redridge, then follow the road north out of town and up through {area:2417}: it comes down into the western {zone:2548} by the {area:16737}."] = "从{zone:1455}飞往赤脊山的{area:69}，然后沿路向北出镇，穿过{area:2417}：道路会在{area:16737}旁下到{zone:2548}西部。",
	-- {zone:2548} Riverglades
	["The western {zone:2548}"] = "{zone:2548}西部",

	-- Step 3: Scout Bolain
	-- {npc:260026} Scout Bolain · {zone:1434} Stranglethorn Vale · {npc:256881} Overlord Kilgar
	-- plural, as words: Twilight Enforcers = {npc:256800} Twilight Enforcer
	["{npc:260026} waits beside the road east of the pass.\nThis guide is written for levels 41-45: the route comes here at about 41, after {zone:1434}. The port's second wave and the Western Front's camps in the north are 43-45, with elite Twilight Enforcers (45) on patrol and {npc:256881} (46, elite) for groups only: below 41, do Stranglethorn first."] = "",

	-- Step 4: Southern Watch
	-- {area:16744} Southern Watch
	["Follow the road east to {area:16744}, the Alliance outpost above the river. The gnolls you passed on the way in are Captain Dalton's job: you go back for them after the lumber camp."] = "沿路向东前往{area:16744}，即河流上方的联盟前哨。进来时路过的豺狼人是达尔顿上尉的任务：伐木营之后再回去处理。",
	-- {quest:95148} Southern Watch Gnoll Report · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95148}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95148}：交给{area:16724}的{npc:257558}，先留着",

	-- Step 5: Snargl's Snout
	-- {npc:255906} Snargl · {area:16737} Bristle Hills
	["{npc:255906} is an elite gnoll (level 40) who roams the south-western camps of the {area:16737}: grouping up is advised."] = "{npc:255906}是一个精英豺狼人（40级），在{area:16737}西南部的营地游荡：建议组队。",

	-- Step 6: Turner's Logging Camp
	-- {npc:256438} Halligan Turner
	["North up the road to the lumber camp. {npc:256438} runs it; his third job, the saplings, comes once his plant food is in."] = "沿路向北前往伐木营。营地由{npc:256438}负责；交还他的植物肥料后，会接到第三个任务：树苗。",

	-- Step 7: The Bristle Hills
	-- {area:16737} Bristle Hills
	["The {area:16737}"] = "{area:16737}",
	-- {area:16737} Bristle Hills · {npc:255906} Snargl
	["West into the {area:16737}: the Redridge gnolls camp on the slopes all the way from the hills west of the lumber camp to the pass you came in by. The stolen saw blades lie only in the western camps, near the pass.\nCareful: {npc:255906}, an elite gnoll (level 40), roams the south-western camps: pull the gnolls away from him."] = "向西进入{area:16737}：赤脊山豺狼人的营地遍布山坡，从伐木营西边的山丘一直到你进来的山口。被偷的锯片只在靠近山口的西部营地里。\n小心：精英豺狼人{npc:255906}（40级）在西南部营地游荡：把豺狼人拉离他身边再打。",

	-- Step 9: Cedric Dalton
	-- {npc:262399} Gelinda Coppergleam
	["Take the gnoll reward now if you're short of 41. If it brings you to 41, head for {npc:262399}; otherwise go to the Holmsby farm and leave the dragonkin for the return from Turner's camp."] = "",

	-- Step 10: Cedric Dalton
	-- {quest:94679} Snargl's Snout
	["{quest:94679}, if already in your bag"] = "",

	-- Step 11: Gelinda Coppergleam
	-- {npc:262399} Gelinda Coppergleam · {area:16744} Southern Watch
	["{npc:262399} camps by the Cinderscale hollow, west of {area:16744}."] = "",

	-- Step 13: The Cinderscale hollow
	["The Cinderscale hollow"] = "烬鳞洼地",
	-- {item:271611} Cubic Draconia
	["The whelps nest in the hollow; the level 41–42 warriors guard its back beside the {item:271611}. Leave Scaldaron, the rare elite drake, alone."] = "",

	-- Step 14: Cubic Draconia
	-- {item:271611} Cubic Draconia
	["Pick up the {item:271611} at the back of the hollow. The warriors guarding it reach level 42."] = "",

	-- Step 17: Holmsby farm
	["Holmsby farm"] = "霍姆斯比农场",
	-- {area:16744} Southern Watch
	["Follow the river road to the Holmsby farm, south of {area:16744}."] = "",

	-- Step 18: Benjy Wheeler
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner
	["North-east across the fields to {area:16725}: {npc:258317} wants the Mudfin murlocs on the river thinned out, the same murlocs whose heads {npc:256438} needs, so one pass along the river does both."] = "向东北穿过田野前往{area:16725}：{npc:258317}要你清理河边的泥鳍鱼人，{npc:256438}要的鱼人头也来自它们，所以沿河走一趟就能两个都完成。",

	-- Step 19: Meadowsbrook and the river
	-- {area:16735} Meadowsbrook
	["{area:16735} and the river"] = "{area:16735}和河流",
	-- {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner · {npc:258588} Jumbo Crawfish · {npc:258935} Curly · {npc:259049} Robbie Holmsby · {area:16735} Meadowsbrook · {npc:263380} Ghostmaw
	-- plural, as words: Mudfin Warriors = {npc:258574} Mudfin Warrior
	["Back south-west along the river: kill the Mudfin Warriors and Oracles on the banks for {npc:258317} (they drop {npc:256438}'s heads) and the {npc:258588} in the shallows for the shells. {npc:258935}, one of {npc:256438}'s lumberjacks, is stuck on the bank just north-west of the murlocs; {npc:259049}'s hat lies on the riverbank among them; the fresh manure is in the fields of {area:16735}, between the river and the farm. {npc:263380}, an elite (level 42), prowls the river: if he comes your way, back off and let him pass."] = "沿河向西南返回：为{npc:258317}击杀河岸上的泥鳍战士和泥鳍先知（它们掉落{npc:256438}要的头），并击杀浅水中的{npc:258588}获取贝壳。{npc:256438}的伐木工之一{npc:258935}被困在鱼人西北方的河岸上；{npc:259049}的帽子就在鱼人中间的河岸上；新鲜粪肥在{area:16735}的田地里，位于河流和农场之间。精英{npc:263380}（42级）在河中游荡：如果他朝你过来，就后退让他过去。",

	-- Step 21: Watcher Fredericks
	-- {npc:259051} Watcher Fredericks · {area:16744} Southern Watch
	["{npc:259051} keeps the west end of {area:16744}."] = "{npc:259051}在{area:16744}的西端。",

	-- Step 22: Cedric Dalton
	-- {area:16744} Southern Watch
	["Tell Captain Dalton about the gnoll infestation while you're at {area:16744}, then head north to Turner's camp."] = "",

	-- Step 24: Turner's Logging Camp
	["North up the road to the lumber camp."] = "沿路向北前往伐木营地。",

	-- Step 25: Saplings
	["Saplings"] = "树苗",
	-- {npc:256438} Halligan Turner · {item:266161} Tree Sprouting Kit
	["Use {npc:256438}'s {item:266161} on bare ground around the camp: five saplings."] = "在营地周围的空地上使用{npc:256438}的{item:266161}：种五棵树苗。",

	-- Step 26: Hurley
	-- {npc:258963} Hurley · {npc:258935} Curly · {quest:94861} Helping Hands · {npc:263380} Ghostmaw
	["{npc:258963} stands at the camp's south end. He sets off for {npc:258935}, south-east of the camp, as soon as you take {quest:94861}: go with him and keep the attackers off, and wait if {npc:263380} is in sight. If it fails, {npc:258963} offers the quest again."] = "{npc:258963}站在营地南端。你一接受{quest:94861}，他就会出发去营地东南方找{npc:258935}：跟着他并挡住攻击者，如果看到{npc:263380}就先等一等。如果失败，可以找{npc:258963}重新接受任务。",
	-- {npc:258963} Hurley · {npc:258935} Curly
	["go with {npc:258963} to save {npc:258935}"] = "跟随{npc:258963}去救{npc:258935}",

	-- Step 28: Wheeler's Grange
	-- {area:16724} Farholde Keep · {npc:258317} Benjy Wheeler · {area:16725} Wheeler's Grange
	["East along the road towards {area:16724}: hand {npc:258317} his murlocs as you pass {area:16725}."] = "沿路向东前往{area:16724}：经过{area:16725}时把鱼人任务交还给{npc:258317}。",

	-- Step 29: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257087} Gretchen Mayberry · {npc:260070} Bertrand Ironbrow · {npc:260080} Ember Bladewhisper · {npc:263613} Brother Lowley · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["On east along the road to {area:16724}. {npc:257087}, the gryphon master, stands at its western gate; {npc:260070} and {npc:260080} are on the way in, {npc:263613} tends the wounded by the barracks, {npc:257558} and {npc:257591} wait in the keep at the east end, and the inn is in the south of the walls."] = "继续沿路向东前往{area:16724}。狮鹫管理员{npc:257087}站在西门；{npc:260070}和{npc:260080}在进门的路上，{npc:263613}在兵营旁照料伤员，{npc:257558}和{npc:257591}在东端的城堡里，旅店在城墙内南侧。",
	-- {npc:257087} Gretchen Mayberry
	["{npc:257087}, at the western gate"] = "{npc:257087}，在西门",
	-- {npc:257558} Demar Brant
	["{npc:257558}, in the keep"] = "{npc:257558}，在城堡里",
	-- {quest:94877} Saving Sunnyglade
	["{quest:94877}: for later in this guide"] = "{quest:94877}：留到本指南后面",
	-- {npc:257591} Ashe Amberhall · {quest:94881} Curious Trinkets
	["{npc:257591}: {quest:94881}, for later in this guide"] = "{npc:257591}：{quest:94881}，本指南稍后完成",
	-- {quest:94879} Scraps of Knowledge
	["{quest:94879}, for later in this guide"] = "{quest:94879}，本指南稍后完成",
	-- {npc:259863} Cassandra Wheeler · {quest:95330} Love Thy Neighbor · {area:16736} Turner's Logging Camp
	["{npc:259863}, by the inn: {quest:95330}, for {area:16736} later in this guide"] = "{npc:259863}，在旅店旁：{quest:95330}，本指南稍后在{area:16736}完成",
	-- {npc:257595} Barracks Master Harlan
	["{npc:257595}, at the inn"] = "{npc:257595}，在旅店",

	-- Step 30: The cathedral
	["The cathedral"] = "大教堂",
	-- {npc:262031} Sister Rowland · {area:16724} Farholde Keep · {npc:272437} Marla Bell · {npc:271742} Abbot Schuncke
	["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} sells the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031}看守着{area:16724}西南角的旧大教堂。蝙蝠栖息在教堂上层；{npc:272437}在教堂旁出售圣洁蜡烛；坟墓在礼拜堂墓地里。\n{npc:271742}是53级精英，站在大教堂内：他不会主动攻击你，千万别打他，把蝙蝠拉离他身边再打。",
	-- {item:17028} Holy Candle · {npc:272437} Marla Bell
	["{item:17028}, from {npc:272437}"] = "{item:17028}，从{npc:272437}处购买",
	-- {item:269997} Bundle of Candles
	["{item:269997}, on the graves"] = "{item:269997}，放在坟墓上",

	-- Step 31: Wheeler's Grange
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler
	["West to {area:16725}: {npc:258317} stands by the farmhouse."] = "向西前往{area:16725}：{npc:258317}站在农舍旁。",

	-- Step 32: The stables
	["The stables"] = "马厩",
	["Search around the stables south of the farmhouse for the horses' tracks; the bundles of hay lie around the farm."] = "在农舍南边的马厩周围搜寻马的足迹；干草捆散落在农场各处。",

	-- Step 34: The coyote den
	["The coyote den"] = "郊狼巢穴",
	-- {npc:258522} Sootfur
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The coyotes den in the hills south of the farm: {npc:258522}, the big dark one, sits at the back of it; the Plains Coyotes around it drop the pelts."] = "郊狼的巢穴在农场南边的山丘里：{npc:258522}是那只深色的大郊狼，待在巢穴深处；周围的平原郊狼掉落毛皮。",

	-- Step 35: The lost horse
	["The lost horse"] = "走失的马",
	["One of Benjy's horses ran north up the river, past the farm. Give it the feed, then lead it home."] = "本吉的一匹马沿河向北跑过了农场。给它喂饲料，然后把它领回家。",
	-- {area:16725} Wheeler's Grange
	["walk it back to {area:16725}"] = "把它牵回{area:16725}",

	-- Step 37: Foreman's Crate
	-- {area:16729} Terral's Watch
	["North up the track towards {area:16729}: the foreman's crate lies by the road."] = "沿小路向北前往{area:16729}：工头的箱子在路边。",

	-- Step 38: Terral's Watch
	-- {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{npc:259352} holds {area:16729}, the tower on the plains north-east of the crate."] = "{npc:259352}驻守{area:16729}，也就是箱子东北方平原上的那座塔。",

	-- Step 39: The plains
	["The plains"] = "平原",
	-- {quest:95983} A Feast for Buzzards · {npc:263380} Ghostmaw
	-- plural, as words: Rog'mar Poachers = {npc:259052} Rog'mar Poacher
	["The Rog'mar Poachers hunt the plains north of the tower; the Wildplains lions roam among them. A picked carcass lies in the grass east of the tower: its skull starts {quest:95983}.\nCareful: {npc:263380}, an elite (level 42), hunts along the river west of the plains: keep an eye on the riverbank."] = "洛格玛偷猎者在塔北边的平原上狩猎，荒原狮子在他们之间游荡。塔东边的草丛里有一具被啃光的尸骸：它的头骨可以接受任务{quest:95983}。\n小心：{npc:263380}是精英（42级），在平原西边的河岸一带猎食：注意河岸动向。",

	-- Step 40: Terral's Watch
	-- {quest:94928} A Few Furs for Friz · {area:16727} Powderfuse Port
	["{quest:94928}: for {area:16727}, keep it"] = "{quest:94928}：交给{area:16727}，留着",
	-- {quest:95984} Song of the Strider · {npc:263367} Sleebo Fizzlespout
	["{quest:95984}: for later, where the tallstriders graze by {npc:263367}'s workshop; keep it"] = "{quest:95984}：之后在{npc:263367}的工坊旁陆行鸟吃草的地方完成，留着",
	-- {quest:95064} Preventative Measures · {area:16743} Rog'mar
	["{quest:95064}: for later, at the Horde's training grounds north of {area:16743}"] = "{quest:95064}：之后在{area:16743}以北的部落训练场完成",
	-- {quest:96125} In Need of Relief · {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["{quest:96125}: for {npc:259057} in {area:16726}, keep it"] = "{quest:96125}：交给{area:16726}的{npc:259057}，留着",
	-- {quest:95426} Rog'mar Supplies
	["{quest:95426}: for later, the same training grounds"] = "{quest:95426}：之后在同一个训练场完成",

	-- Step 41: Farholde Keep
	-- {area:16724} Farholde Keep
	["South back to {area:16724}."] = "向南返回{area:16724}。",
	-- {quest:96009} High Stakes · {area:16736} Turner's Logging Camp
	["{quest:96009}: for {area:16736} later in this guide"] = "{quest:96009}：本指南稍后在{area:16736}完成",

	-- Step 42: WANTED: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch · {npc:259859} Wheatley
	["{npc:263380} is an elite (level 42) who hunts along the river between {area:16725} and {area:16729}, on your way north later in this guide: grouping up is advised. The poster hangs by the keep; {npc:259859}, who takes the fang, stands south of the inn."] = "{npc:263380}是精英（42级），在{area:16725}和{area:16729}之间的河边游荡，本指南稍后北上时会经过：建议组队。通缉令挂在要塞旁；收取獠牙的{npc:259859}站在旅店南边。",
	-- {object:645166} WANTED! (no name in this language: may be words)
	["the {object:645166} poster"] = "通缉令",

	-- Step 43: WANTED: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo · {area:16743} Rog'mar
	["{npc:263071} is an elite (level 42) at the Horde's training grounds north of {area:16743}, where this guide goes later: grouping up is advised."] = "{npc:263071}是精英（42级），位于{area:16743}以北的部落训练场，本指南稍后会去那里：建议组队。",
	-- {object:707245} Wanted (no name in this language: may be words)
	["the {object:707245} poster"] = "通缉令",

	-- Step 44: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch
	["{npc:263380}, the elite, hunts along the river between {area:16725} and {area:16729}, on your way north."] = "精英{npc:263380}在{area:16725}和{area:16729}之间的河边游荡，就在你北上的路上。",

	-- Step 45: Sunnyglade
	-- {area:16729} Terral's Watch · {area:16743} Rog'mar · {area:16723} Sunnyglade · {npc:259158} Fuzzle
	["Cross the river north of {area:16729} and stay west of {area:16743}, the Horde fort. Start at Elbrim's farm on {area:16723}'s north-eastern edge, then head west to Claire and {npc:259158}. The cult's ritual circles are just south of them."] = "",

	-- Step 46: Into Sunnyglade's cave
	-- {area:16723} Sunnyglade
	["Into {area:16723}'s cave"] = "",
	-- {area:16723} Sunnyglade · {npc:256831} Apprentice Claire
	["The cave mouth is on {area:16723}'s eastern side. Follow the passage west to {npc:256831}; her marker is inside, not on the hillside above."] = "",
	-- {area:16723} Sunnyglade
	["{area:16723} cave mouth"] = "",

	-- Step 48: Fuzzle
	-- {npc:259158} Fuzzle
	["Leave the cave and look for {npc:259158} in the cage south of Claire."] = "",
	-- {npc:259158} Fuzzle
	["{npc:259158} in his cage, not the end of his escort"] = "",

	-- Step 49: The Twilight cult
	["The Twilight cult"] = "暮光教派",
	-- {area:16723} Sunnyglade · {item:266148} Farmers' Mementos · {item:4338} Mageweave Cloth · {npc:263613} Brother Lowley · {area:16724} Farholde Keep · {quest:94885} Field Marshal's Log · {npc:256899} Chogg'Zac · {npc:263380} Ghostmaw
	-- plural, as words: Twilight Raiders = {npc:256952} Twilight Raider
	["The cultists fill the streets and fields of {area:16723}. Start at the ritual circles in the middle (fill Claire's catalyst there), work west through the burnt houses to the edge of town, then back north-east to the loose soil west of Elbrim's farm: bury the {item:266148} the Twilight Raiders drop there. The charms, pages and finger bones drop from the cultists.\nKeep the {item:4338} they drop: {npc:263613} in {area:16724} asks for twenty when you are back there. Now and then a cultist drops the {quest:94885}: right-click it to start the quest.\nCareful: {npc:256899}, an elite ogre (level 41), walks the western streets of {area:16723}, around 44-47,47-52. Pull the cultists out towards you and let him pass; players died here more than anywhere else in the zone.\n{npc:263380}, the river's elite (level 42), can wander up from the south-western fields: let him pass."] = "{area:16723}的街道和田地里到处是邪教徒。先从中央的仪式法阵开始（在那里装满克莱尔的催化剂），向西穿过烧毁的房屋到镇子边缘，再折回东北到埃尔布里姆农场西边的松软泥土：把暮光袭击者掉落的{item:266148}埋在那里。护符、书页和指骨都从邪教徒身上掉落。\n留着他们掉落的{item:4338}：回到{area:16724}时，{npc:263613}要二十块。邪教徒偶尔会掉落{quest:94885}：右键点击它接受任务。\n小心：精英食人魔{npc:256899}（41级）在{area:16723}西侧街道巡逻，大约在44-47,47-52。把邪教徒拉到你这边，等他走过去；这里是本地区玩家死得最多的地方。\n河边的精英{npc:263380}（42级）可能从西南的田地游荡过来：让他过去。",
	-- {item:269990} Crystal Catalyst
	["fill the {item:269990} at the ritual circles"] = "在仪式法阵装满{item:269990}",
	-- {object:621813} Loose Soil (no name in this language: may be words) · {item:266148} Farmers' Mementos
	-- plural, as words: Twilight Raiders = {npc:256952} Twilight Raider
	["{object:621813}, west of Elbrim's farm: each grave takes one of the {item:266148} the Twilight Raiders drop, so loot five first"] = "",
	-- {quest:94885} Field Marshal's Log
	["{quest:94885}: only if a cultist dropped the log"] = "{quest:94885}：仅当邪教徒掉落了日志时",

	-- Step 50: Back into Sunnyglade's cave
	-- {area:16723} Sunnyglade
	["Back into {area:16723}'s cave"] = "",
	["Return by the eastern cave mouth to give Claire the filled catalyst."] = "",

	-- Step 52: Back to Claire with news of the cultists
	["Back to Claire with news of the cultists"] = "",
	["The eastern cave mouth leads back to Claire. Tell her about the cultists inside."] = "",

	-- Step 54: Cut Off the Heads
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{npc:256899}, the two-headed ogre, is an elite (level 41) at the western edge of {area:16723}: grouping up is advised. Claire then has the filled catalyst for {npc:257591} in {area:16724}."] = "双头食人魔{npc:256899}是精英（41级），在{area:16723}西侧边缘：建议组队。之后克莱尔会把装满的催化剂交给你，带给{area:16724}的{npc:257591}。",

	-- Step 55: Back to Claire with the heads
	["Back to Claire with the heads"] = "",
	-- {area:16723} Sunnyglade
	["Take the heads through the cave mouth on the east side of {area:16723}."] = "",

	-- Step 57: Back to Claire for the filled catalyst
	["Back to Claire for the filled catalyst"] = "",
	["If you left after giving Claire the heads, use the cave mouth to collect her delivery for Farholde."] = "",

	-- Step 58: Claire's message for Farholde
	["Claire's message for Farholde"] = "",
	-- {quest:94884} An Unsettling Discovery · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{quest:94884}: for {npc:257591} in {area:16724}"] = "{quest:94884}：交给{area:16724}的{npc:257591}",

	-- Step 59: Fuzzle
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["{npc:259158} wants out of {area:16723}: lead him west to his treasure at the edge of town and keep the cultists off him."] = "{npc:259158}想离开{area:16723}：带他向西走到镇子边缘找他的宝藏，别让教徒靠近他。",
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["lead {npc:259158} out of {area:16723} to his treasure, west of the town"] = "带{npc:259158}离开{area:16723}，去镇子西边找他的宝藏",

	-- Step 60: Farmer Elbrim
	["Back east through the town to Elbrim's farm: the doll and the locket are in the burnt farmhouse beside it."] = "穿过镇子向东回到埃尔布里姆的农场：玩偶和项链盒在旁边烧毁的农舍里。",

	-- Step 61: The Rog'mar training grounds
	-- {area:16743} Rog'mar
	["The {area:16743} training grounds"] = "{area:16743}训练场",
	-- {area:16743} Rog'mar · {npc:263071} Blademaster Kaijo · {npc:263615} Krek the Noxious
	-- plural, as words: Rog'mar Grunts = {npc:255996} Rog'mar Grunt
	["North-east of Elbrim's farm, the Horde drills its trainees in the fields north of {area:16743}. Stay north of the fort: its guards are far above your level. The supply crates lie around the drill grounds. Three elites work this ground: {npc:263071} (42) walks among the trainees, {npc:263615} (42) lurks at the north end, and Komuk (45), a Horde elite, patrols the hills to the east; give each of them room.\nCareful: Rog'mar Grunts (55) guard the fort's north wall, around 59,39 to 61,41. Leave the crates and trainees by the wall and take the ones further north, around 57-61,34-37."] = "在埃尔布里姆农场东北，部落在{area:16743}北边的田野里操练新兵。待在要塞北边：要塞守卫的等级远高于你。补给箱散落在训练场周围。这片区域有三个精英：{npc:263071}（42级）在新兵之间走动，{npc:263615}（42级）潜伏在北端，部落精英科穆克（45级）在东边的山丘上巡逻；离他们都远一点。\n注意：洛格玛步兵（55级）守卫着要塞北墙，约在59,39到61,41。别碰墙边的箱子和新兵，去更北边约57-61,34-37处找。",

	-- Step 62: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo
	["{npc:263071}, the elite, walks the training grounds."] = "精英{npc:263071}在训练场里走动。",

	-- Step 63: Sleebo Fizzlespout's workshop
	-- {npc:263367} Sleebo Fizzlespout
	["{npc:263367}'s workshop"] = "{npc:263367}的工坊",
	-- {area:16743} Rog'mar · {npc:263367} Sleebo Fizzlespout · {area:16726} Bolder'ok
	["South-east, round {area:16743}'s east side, to {npc:263367}'s workshop on the hill. Komuk and the {area:16726} ogres walk the road east of the fort: let them pass before you cross it."] = "向东南绕过{area:16743}东侧，前往山上{npc:263367}的工坊。科穆克和{area:16726}食人魔在要塞东边的路上巡逻：等他们走过再过路。",

	-- Step 64: The tallstriders and the marsh
	["The tallstriders and the marsh"] = "陆行鸟和沼泽",
	-- plural, as words: Roving Tallstriders = {npc:263348} Roving Tallstrider
	["The Roving Tallstriders graze the meadows south-west of the workshop; further south-west the marsh bubbles with gas: fill the vials at the vents."] = "游荡的陆行鸟在工坊西南的草地上吃草；再往西南，沼泽里冒着气体：在喷气口装满瓶子。",

	-- Step 65: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower stands just south-west of the marsh."] = "{npc:259352}的塔楼就在沼泽西南边。",
	-- {quest:95066} The Rog'mar Situation · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95066}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95066}：交给{area:16724}的{npc:257558}，先保留任务",

	-- Step 66: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257591} Ashe Amberhall · {npc:257558} Demar Brant · {area:16723} Sunnyglade · {npc:263089} Tessa Dawnbright · {npc:263613} Brother Lowley
	["South across the plains to {area:16724}: {npc:257591} and {npc:257558} stand together in the keep at the east end, {npc:257591} first, her news is what Brant's next orders wait on. With {area:16723} saved, {npc:263089} by the orchard and {npc:263613} by the barracks have work for you too."] = "向南穿过平原前往{area:16724}：{npc:257591}和{npc:257558}一起站在东端的城堡里，先找{npc:257591}，布兰特的下一步命令要等她的消息。{area:16723}已经得救，果园旁的{npc:263089}和兵营旁的{npc:263613}也有任务给你。",
	-- {quest:94907} A Small Favor
	["{quest:94907}: for later in this guide"] = "{quest:94907}：本指南稍后再做",
	-- {quest:95329} Out in the Field · {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{quest:95329}: for {npc:259352} at {area:16729}, keep it"] = "{quest:95329}：交给{area:16729}的{npc:259352}，先保留任务",
	-- {quest:94886} The Western Front
	["{quest:94886}: for later in this guide"] = "{quest:94886}：本指南稍后再做",
	-- {npc:263613} Brother Lowley · {item:4338} Mageweave Cloth · {area:16723} Sunnyglade
	["{npc:263613}: twenty {item:4338}, from {area:16723}'s cultists and the pirates; hand it in when you are back"] = "{npc:263613}：二十块{item:4338}，来自{area:16723}的教徒和海盗；回来时再交还",

	-- Step 67: Tessa Dawnbright
	-- {npc:263089} Tessa Dawnbright
	["{npc:263089} stands west of the inn, by the orchard: the apples hang on the trees around it."] = "{npc:263089}站在旅店西边的果园旁：苹果就挂在周围的树上。",

	-- Step 68: Coyote pelts
	["Coyote pelts"] = "郊狼皮",
	-- {area:16725} Wheeler's Grange
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The Plains Coyotes roam west and south-west of the keep, towards {area:16725}."] = "平原郊狼在城堡西边和西南边游荡，一直到{area:16725}附近。",

	-- Step 69: Tessa Dawnbright
	-- {quest:95961} Stepped Out · {npc:263120} Gray Dawnbright · {area:16727} Powderfuse Port
	["{quest:95961}: for {npc:263120} in {area:16727}, keep it"] = "{quest:95961}：交给{area:16727}的{npc:263120}，先保留任务",

	-- Step 70: King of the Wild Plains
	-- {npc:263315} Ombassa · {area:16729} Terral's Watch
	["{npc:263315}, an elite lion (level 41), prowls the plains north of {area:16729}, on your way back north: grouping up is advised."] = "{npc:263315}是一只精英狮子（41级），在{area:16729}北边的平原上游荡，就在你回北边的路上：建议组队。",

	-- Step 72: Sleebo Fizzlespout
	-- {npc:263367} Sleebo Fizzlespout
	["North-east to {npc:263367}'s workshop. {npc:263367}'s stress test is a fight with his G45-B4G beside the workshop: hand the quest in once it's beaten."] = "向东北前往{npc:263367}的工坊。{npc:263367}的压力测试是在工坊旁和他的G45-B4G战斗：打败后交还任务。",
	["the stress test: beat G45-B4G beside the workshop"] = "压力测试：在工坊旁打败G45-B4G",

	-- Step 73: Powderfuse Port
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {npc:263120} Gray Dawnbright · {npc:255894} Innkeeper Zizplink · {npc:259962} Fimbo Greasemitz · {npc:259961} Wharfmaster Whizzbuzz · {npc:260487} Gritta Chumwater · {npc:260565} Kor'gar · {npc:260560} Krikshank
	["East down the road to {area:16727}, the goblins' harbour. {npc:255897} keeps a stall at the west end of the docks; {npc:263120}, {npc:255894} and {npc:259962} are at the inn, and {npc:259961} works the north pier. Zizplink's drink needs three things the port's traders sell: the chum from {npc:260487}, the degreaser and the old poison from {npc:260565} and {npc:260560}, by {npc:255897}'s stall."] = "沿路向东前往地精的港口{area:16727}。{npc:255897}在码头西端摆摊；{npc:263120}、{npc:255894}和{npc:259962}在旅店，{npc:259961}在北边的栈桥工作。齐兹普林克的饮料需要三样港口商人出售的东西：{npc:260487}的鱼饵，以及{npc:255897}摊位旁{npc:260565}和{npc:260560}的去污剂和陈年毒药。",
	-- {quest:95059} Frazzlespark's Crate · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95059}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95059}：交给{area:16724}的{npc:257558}，留着",
	-- {item:271657} Fresh Chum · {npc:260487} Gritta Chumwater
	["{item:271657}, from {npc:260487}"] = "{item:271657}，从{npc:260487}处购买",
	-- {item:271653} Goblin Degreaser · {npc:260565} Kor'gar
	["{item:271653}, from {npc:260565}"] = "{item:271653}，从{npc:260565}处购买",
	-- {item:271654} Expired Poison · {npc:260560} Krikshank
	["{item:271654}, from {npc:260560}"] = "{item:271654}，从{npc:260560}处购买",
	-- {object:628948} WANTED! (no name in this language: may be words) · {npc:260235} Trapclaw
	["The {object:628948} poster by the inn: {npc:260235}"] = "旅店旁的{object:628948}告示：{npc:260235}",

	-- Step 74: WANTED: Old Rot-Chum
	-- {npc:257001} Old Rot-Chum
	["{npc:257001} is an elite (level 42) on the south shore: grouping up is advised."] = "{npc:257001}是南岸的精英（42级）：建议组队。",
	-- {object:628948} WANTED! (no name in this language: may be words)
	["The {object:628948} poster by the inn"] = "旅店旁的{object:628948}告示",

	-- Step 75: The murlocs, south-west
	["The murlocs, south-west"] = "西南边的鱼人",
	-- {quest:95260} Terrors From the Deep · {npc:260231} Argo Brinewhistle
	["South-west along the shore from the port: the saltwater murlocs camp on the beaches. On the way, a painted hide is stretched beside the path: it starts {quest:95260} for {npc:260231} at the docks."] = "从港口沿海岸向西南走：咸水鱼人在海滩上扎营。路上小路旁撑着一张彩绘兽皮：它会开始{quest:95260}，交给码头的{npc:260231}。",

	-- Step 77: Back through the port
	["Back through the port"] = "返回穿过港口",
	["Back north along the shore: hand in the murlocs and the hide on the docks on your way to the crawlers."] = "沿海岸往北返回：去找爬行者的路上，在码头交还鱼人任务和兽皮任务。",
	-- {quest:95261} It Takes Guts
	["{quest:95261}: the beasts' entrails come as you go; the mushrooms are for later"] = "{quest:95261}：野兽内脏边走边收集；蘑菇留到之后",

	-- Step 78: The crawlers and Trapclaw
	-- {npc:260235} Trapclaw
	["The crawlers and {npc:260235}"] = "爬行者和{npc:260235}",
	-- {npc:259962} Fimbo Greasemitz · {npc:260231} Argo Brinewhistle · {npc:260235} Trapclaw · {npc:259758} Gul'gash
	["North along the beach from the docks: the crawlers drop the meat for {npc:259962} and the spittle for Zizplink, and their entrails count for {npc:260231}. {npc:260235}, a big crab, scuttles along the rocks east of the docks. {npc:259758}, a rare elite of level 49, roams this coast from the docks up to the pirates' camp: if you see him, keep well away."] = "从码头沿海滩向北：爬行者掉落给{npc:259962}的肉和给齐兹普林克的唾液，它们的内脏也算{npc:260231}的任务。{npc:260235}是一只大螃蟹，在码头东边的岩石上爬行。{npc:259758}是49级稀有精英，在从码头到海盗营地的海岸上游荡：如果看到他，离远点。",

	-- Step 80: Powderfuse Port: Fimbo Greasemitz's pincer
	-- {area:16727} Powderfuse Port · {npc:259962} Fimbo Greasemitz
	["{area:16727}: {npc:259962}'s pincer"] = "",

	-- Step 81: Fimbo Greasemitz's shore meal
	-- {npc:259962} Fimbo Greasemitz
	["{npc:259962}'s shore meal"] = "",

	-- Step 84: Before the Eastsea camp
	["Before the Eastsea camp"] = "",
	-- {npc:259758} Gul'gash · {area:796} Scarlet Monastery
	-- plural, as words: Shore Crawlers = {npc:256807} Shore Crawler
	["Pay any ready shore rewards at Powderfuse first. If you still need 42, stay on the beach with the level 39–40 Shore Crawlers. The musketeers on the cliffs can be 43. Let {npc:259758}, the rare elite, pass before pulling. A group can run the {area:796} instead."] = "",
	-- {area:16727} Powderfuse Port
	-- plural, as words: Shore Crawlers = {npc:256807} Shore Crawler
	["Shore Crawlers beside {area:16727}"] = "",

	-- Step 85: The Eastsea pirates
	["The Eastsea pirates"] = "东海海盗",
	-- {npc:259758} Gul'gash
	["North-east along the coast to the pirates' camp on the cliffs. The buccaneers and musketeers carry the smuggled goods. {npc:259758} walks the camp too: keep an eye out for him."] = "沿海岸向东北前往悬崖上的海盗营地。海盗和火枪手身上带着走私货物。{npc:259758}也在营地里游荡：多加留意。",

	-- Step 87: Wharfmaster Whizzbuzz
	-- {quest:95122} Unchecked Expansion
	["{quest:95122}: when you return to the northern cliffs"] = "",

	-- Step 91: Gray Dawnbright and Zizplink
	-- {npc:263120} Gray Dawnbright
	["{npc:263120} and Zizplink"] = "",

	-- Step 93: Friz Frazzlespark
	-- {npc:260390} Captain Bentcoin
	["Carry this to {npc:260390} when you visit the cliffs at 44"] = "",

	-- Step 95: Beast Entrails as you go
	-- {item:268632} Beast Entrails
	["{item:268632} as you go"] = "顺路收集{item:268632}",
	-- {zone:2548} Riverglades · {item:268632} Beast Entrails · {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum · {npc:263380} Ghostmaw
	["Most beasts in the {zone:2548} drop {item:268632} for {npc:260231}: the shore crawlers on this coast and the boars on the ridge west of the pirates.\nCareful: {npc:257001} (elite, 42), Komuk (a Horde elite, 45) and {npc:263380} (elite, 42) range over the zone's wilds: take your beasts away from them."] = "{zone:2548}的大多数野兽都会掉落{item:268632}，交给{npc:260231}：这片海岸的海滨爬行者和海盗西边山脊上的野猪都行。\n注意：{npc:257001}（精英，42级）、科穆克（部落精英，45级）和{npc:263380}（精英，42级）在该地区野外游荡：把野兽拉离它们再打。",

	-- Step 96: Level 44.4 on the Eastsea pirates
	["Level 44.4 on the Eastsea pirates"] = "在东海海盗身上升到44.4级",
	-- {npc:259758} Gul'gash · {area:1517} Uldaman
	["Before the second wave: its raiders and bombardiers reach 45. At 43 the strongest are still two levels above you. Top up on the first camp's buccaneers and musketeers (41-43) at its south-west end, away from the port. {npc:259758}, a rare elite of level 49, roams these cliffs: if you see him, keep well away. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {npc:257901} Eastsea Buccaneer
	["grind on {npc:257901}"] = "刷{npc:257901}",

	-- Step 97: The pirates' second wave
	["The pirates' second wave"] = "海盗的第二波",
	-- {npc:259758} Gul'gash
	["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. They stand close together: pull them one at a time. {npc:259758}, a rare elite of level 49, roams these cliffs and the beach below: if you see him, keep well away."] = "从港口沿海岸向北：东海袭击者和投弹手据守在海盗营地西边的山坡上，周围都是火药桶。它们站得很近：一次拉一个。{npc:259758}是49级的稀有精英，在这片悬崖和下方海滩游荡：如果看到他，尽量远离。",

	-- Step 98: Captain Bentcoin
	-- {npc:260390} Captain Bentcoin · {npc:260391} Captain Haynes
	["East along the cliffs to the far end of the pirates' camp: {npc:260390} waits by the water, {npc:260391} beside him."] = "沿悬崖向东到海盗营地的最远端：{npc:260390}在水边等候，{npc:260391}在他旁边。",

	-- Step 99: Wharfmaster Whizzbuzz: the raiders
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: the raiders"] = "",

	-- Step 100: Wharfmaster Whizzbuzz: the kegs
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: the kegs"] = "",

	-- Step 101: Wharfmaster Whizzbuzz: the ships
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: the ships"] = "",

	-- Step 103: The pirates' ships
	["The pirates' ships"] = "海盗船",
	-- {quest:95124} Admiral Lamora · {npc:259758} Gul'gash
	["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} patrols the top deck of the middle ship. Once she's down, go below deck for the loot chest in the hold. Keep an eye out for {npc:259758} on the way."] = "",
	-- {item:268505} Remote Explosive Charge
	["{item:268505}, the southern ship"] = "{item:268505}，南边的船",
	["Open Lamora's chest in the hold"] = "",
	["the middle ship"] = "中间的船",
	["the northern ship"] = "北边的船",

	-- Step 104: Rotflesh Mushrooms
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom
	["Rotflesh Mushrooms"] = "腐肉蘑菇",
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom · Mature Paletusks = {npc:255851} Mature Paletusk
	["West from the northern ship, up the ridge: the Rotflesh Mushrooms grow among the rocks, close to the Twilight ogres' camp. The Mature Paletusks on the ridge give entrails too."] = "从北边那艘船向西爬上山脊：腐肉蘑菇长在岩石间，靠近暮光食人魔的营地。山脊上的成年白牙野猪也会掉落内脏。",

	-- Step 105: Bolder'ok
	-- {area:16726} Bolder'ok · {npc:259057} Dunston Willis
	["North-west to {area:16726}, the ogres' town. Its ogres side with the Horde and attack you on sight, and Clugfist on his hill in the middle is an elite (level 50): keep to the town's north-eastern edge, where {npc:259057} hides."] = "向西北前往食人魔的城镇{area:16726}。这里的食人魔与部落结盟，见人就打，中央山丘上的克拉格菲斯特是精英（50级）：沿城镇东北边缘走，{npc:259057}就藏在那里。",

	-- Step 106: Gronok's Key
	-- {npc:263749} Gronok the Butcher · {npc:259057} Dunston Willis · {item:275043} Bloodmaster's Ring
	["{npc:263749} (level 44) carries the key: he paces the lanes south of {npc:259057}'s hut.\nThe {item:275043} lies just west of the lanes: its fighters (elites, 41-45) only fight in a bout, so leave them be."] = "钥匙在{npc:263749}（44级）身上：他在{npc:259057}的小屋南边的小路上来回走动。\n{item:275043}就在小路西边：里面的斗士（精英，41-45级）只在比赛中战斗，别去惹他们。",

	-- Step 107: Dunston Willis
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["Free him, then get him out: {npc:259057} fights his way out of {area:16726}, and you keep the ogres off him. If he falls, take the quest from him again."] = "救出他，再带他出去：{npc:259057}会一路杀出{area:16726}，你负责挡住食人魔。如果他倒下，重新从他那里接受任务。",

	-- Step 108: Dunston Willis: the way out
	-- {npc:259057} Dunston Willis
	["{npc:259057}: the way out"] = "",
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["help {npc:259057} break out of {area:16726}"] = "帮助{npc:259057}逃出{area:16726}",

	-- Step 109: Finish the Beast Entrails
	-- {item:268632} Beast Entrails
	["Finish the {item:268632}"] = "收集完{item:268632}",
	-- {npc:259758} Gul'gash
	["South-east out of the hills towards the port: the shore crawlers on the beach north of the docks are the quickest entrails. {npc:259758} wanders down to this beach too."] = "向东南离开丘陵前往港口：码头北边海滩上的海岸爬行者是最快的内脏来源。{npc:259758}也会游荡到这片海滩。",

	-- Step 110: Powderfuse Port: the charges
	-- {area:16727} Powderfuse Port
	["{area:16727}: the charges"] = "",

	-- Step 111: Wharfmaster Whizzbuzz: Lamora
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: Lamora"] = "",

	-- Step 113: Argo Brinewhistle
	-- {quest:95267} The Monster Surfaces
	["{quest:95267}: the monster in the shallows south-west of the port"] = "",

	-- Step 114: The Monster Surfaces
	-- {npc:260231} Argo Brinewhistle · {item:268647} Big Ball o' Bait · {npc:257001} Old Rot-Chum
	["At the junk in the shallows south-west of the port, use {npc:260231}'s {item:268647}. Kill the threshadon that comes to the bait and take its head. Give {npc:257001}, the elite that walks this shore, plenty of room."] = "",
	-- {item:268647} Big Ball o' Bait
	["{item:268647} at the junk"] = "",
	["Loot the summoned threshadon's head"] = "",

	-- Step 116: The meadows
	["The meadows"] = "草地",
	-- {npc:263367} Sleebo Fizzlespout
	["West of the port, the wildflowers grow in the meadows below {npc:263367}'s workshop."] = "港口西边，野花长在{npc:263367}工坊下方的草地上。",

	-- Step 117: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257558} Demar Brant
	["South-west across the plains to {area:16724}: {npc:257558} in the keep at the east end."] = "向西南穿过平原前往{area:16724}：{npc:257558}在东端的城堡里。",

	-- Step 118: Demar Brant
	-- {quest:94887} Saving Marshal Ryan
	["{quest:94887}: for later in this guide"] = "{quest:94887}：本指南稍后完成",

	-- Step 121: Brother Lowley
	-- {npc:263613} Brother Lowley · {npc:262031} Sister Rowland
	["{npc:263613} tends the wounded beside the barracks: bandage three of his soldiers, then he has a note for {npc:262031} in the cathedral."] = "{npc:263613}在兵营旁照料伤员：给他的三名士兵包扎，然后他会给你一封交给大教堂里{npc:262031}的信。",
	-- {item:272126} Makeshift Bandages
	-- plural, as words: Wounded Soldiers = {npc:263614} Wounded Soldier
	["{item:272126}, on the Wounded Soldiers beside him"] = "{item:272126}，用在他身旁的受伤的士兵身上",

	-- Step 122: Farholde Keep, the west side
	-- {area:16724} Farholde Keep
	["{area:16724}, the west side"] = "{area:16724}西侧",
	-- {npc:263089} Tessa Dawnbright · {npc:259859} Wheatley
	["West through the keep: {npc:263089} by the orchard, then the cathedral and {npc:259859} south of the inn if you have their errands."] = "向西穿过要塞：果园旁的{npc:263089}，如果接了他们的差事，再去大教堂和旅店南边的{npc:259859}。",

	-- Step 123: Sister Rowland
	-- {quest:96084} Something's in the Water
	["{quest:96084}: for later in this guide"] = "{quest:96084}：本指南稍后完成",

	-- Step 125: Something's in the Water
	-- {area:16729} Terral's Watch · {npc:262031} Sister Rowland
	["North past {area:16729}: fill {npc:262031}'s phial in the marsh water north-east of the tower."] = "向北经过{area:16729}：在塔楼东北的沼泽水中装满{npc:262031}的药瓶。",

	-- Step 126: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower."] = "{npc:259352}的塔楼。",

	-- Step 128: Turner's Logging Camp
	-- {area:16736} Turner's Logging Camp · {npc:263380} Ghostmaw
	-- plural, as words: Peasant Woodpiles = {object:645516} Peasant Woodpile
	["West across the river to {area:16736}: the Peasant Woodpiles around the camp give the wood bundles.\nCareful: {npc:263380}, an elite (level 42), prowls the river by the camp: if he comes your way, back off and let him pass."] = "向西过河到{area:16736}：营地周围的农民木堆可以拿到木材捆。\n小心：精英{npc:263380}（42级）在营地旁的河边游荡：如果它朝你过来，就后退让它过去。",

	-- Step 129: Gelinda Coppergleam
	-- {npc:262399} Gelinda Coppergleam
	["From Turner's camp follow the road south-west to {npc:262399}'s camp."] = "",

	-- Step 135: The Western Front
	-- {npc:256881} Overlord Kilgar
	-- plural, as words: Twilight Champions = {npc:256799} Twilight Champion · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["Careful: the Western Front is written for level 44 and up. Its Twilight Champions are 43-44 and its Thralls 44, Twilight Enforcers (elites, 45) patrol through the camps, and {npc:256881} (46, elite) is for a group only. Below 44, top up on the Eastsea pirates by the port first, or come back with a friend."] = "",

	-- Step 136: Sergeant Riftan
	-- {area:16685} Twilight's Shroud · {npc:258023} Sergeant Riftan
	["North up the long valley towards {area:16685}: {npc:258023} holds a small camp below the Twilight cult's fortress."] = "沿狭长的山谷向北前往{area:16685}：{npc:258023}在暮光教派要塞下方守着一个小营地。",

	-- Step 137: The Twilight camps
	["The Twilight camps"] = "暮光营地",
	-- {npc:258652} Twilight Thrall · {npc:257591} Ashe Amberhall · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["The cult's camps fill the valley north and west of Riftan. Free the captive Farholde Scouts as you find them, and kill a {npc:258652} for {npc:257591}: her soulstone takes it. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them."] = "教派的营地遍布里夫坦北边和西边的山谷。沿途解救被俘的法尔霍德斥候，并为{npc:257591}击杀一个{npc:258652}：她的灵魂石会收取它。暮光执行者（精英，45级）在营地间巡逻：每次拉怪前先看清它们的路线。{npc:256881}和{npc:256891}（精英，46级）据守山谷尽头的要塞：把教徒从他们身边拉开。",
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout
	["free five captive Farholde Scouts"] = "解救五名被俘的法尔霍德斥候",
	-- {npc:258652} Twilight Thrall
	["kill a {npc:258652}"] = "击杀一个{npc:258652}",

	-- Step 138: Marshal Ryan
	-- {npc:257250} Marshal Ryan · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	["{npc:257250} lies wounded among the camps at the valley's western edge.\nCareful: {npc:256881} and {npc:256891} (elites, 46) hold the fortress north of him: come at Ryan from the south."] = "{npc:257250}受伤躺在山谷西缘的营地之间。\n小心：{npc:256881}和{npc:256891}（精英，46级）据守他北边的要塞：从南边接近莱恩。",
	-- {npc:257250} Marshal Ryan
	["find {npc:257250} and talk to him"] = "找到{npc:257250}并与他交谈",
	-- {quest:94892} Dying Wish · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:94892}: for {npc:257558} in {area:16724}"] = "{quest:94892}：交给{area:16724}的{npc:257558}",

	-- Step 139: The ogre mine
	["The ogre mine"] = "食人魔矿洞",
	-- plural, as words: Twilight Subjugators = {npc:260996} Twilight Subjugator · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["North of the camps the cult works ogre miners in a mine, driven by the Twilight Subjugators.\nCareful: Twilight Enforcers (elites, level 45) walk past the mine's mouth on their way through the camps. Wait for one to pass before you go in, and pull the miners and Subjugators back out to you."] = "营地北边，教派在一座矿洞里驱使食人魔矿工干活，由暮光征服者监工。\n小心：暮光执行者（精英，45级）穿行营地时会经过矿洞口。等它走过再进去，把矿工和征服者拉到外面打。",

	-- Step 141: Bring Me His Head
	-- {npc:256881} Overlord Kilgar
	["{npc:256881} is an elite (level 46) in the fortress at the head of the valley, with the Enforcers around him: grouping up is advised."] = "{npc:256881}是精英（46级），在山谷尽头的要塞里，身边围着执行者：建议组队。",
	-- {quest:94891} News to Farholde · {npc:257591} Ashe Amberhall
	["{quest:94891}: for {npc:257591}"] = "{quest:94891}：交给{npc:257591}",

	-- Step 142: Back to Farholde Keep
	-- {area:16724} Farholde Keep
	["Back to {area:16724}"] = "返回{area:16724}",
	-- {area:16724} Farholde Keep
	["Your hearthstone is bound at {area:16724}'s inn: use it, or ride back south to the keep."] = "你的炉石绑定在{area:16724}的旅店：使用炉石，或向南骑回要塞。",

	-- Step 143: Farholde Keep
	-- {npc:260070} Bertrand Ironbrow · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["From the inn: {npc:260070} on the way in, then {npc:257558} and {npc:257591} in the keep."] = "从旅店出发：进去路上找{npc:260070}，然后是要塞里的{npc:257558}和{npc:257591}。",

	-- Step 145: Demar Brant
	-- {quest:94893} Delivering Closure · {npc:278088} Abigail Lawson · {zone:1453} Stormwind
	["{quest:94893}: for {npc:278088} in {zone:1453}"] = "{quest:94893}：交给{zone:1453}的{npc:278088}",

	-- Step 146: The Twilight Threat
	-- {npc:257558} Demar Brant · {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:257558}: Kilgar's head for {npc:1748} in {object:2117}"] = "{npc:257558}：把基尔加的头颅交给{object:2117}的{npc:1748}",

	-- Step 147: Sister Rowland
	-- {npc:262031} Sister Rowland
	["{npc:262031}, in the cathedral at the keep's south-west corner."] = "{npc:262031}在要塞西南角的大教堂里。",

	-- Step 148: Stormwind
	-- {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind · {npc:278088} Abigail Lawson · {object:2098} Cathedral Square
	["{npc:257087} flies to {zone:1453}. {npc:278088} waits in the {object:2098}."] = "{npc:257087}可飞往{zone:1453}。{npc:278088}在{object:2098}等候。",

	-- Step 150: Train before the Badlands
	-- {zone:1418} Badlands
	["Train before the {zone:1418}"] = "前往{zone:1418}前先训练",
	-- {zone:2548} Riverglades · {zone:1418} Badlands · {zone:1425} Hinterlands · {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}, and the {zone:1418} & {zone:1425} guide passes none: {npc:257087} flies to {zone:1453}, where you train before you go on."] = "{zone:2548}没有职业训练师，{zone:1418}和{zone:1425}指南途中也没有：找{npc:257087}飞往{zone:1453}，先训练再继续。",

	-- Step 151: Your class trainer
	["Your class trainer"] = "你的职业训练师",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}: train here in {zone:1453} before you fly on."] = "{zone:2548}没有职业训练师：飞走之前先在{zone:1453}训练。",

	-- Step 152: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453}飞行管理员",

	-- Step 153: Shaman trainer
	["Shaman trainer"] = "萨满祭司训练师",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind · {zone:1418} Badlands · {zone:1425} Hinterlands · {area:1537} Ironforge · {area:144} Thelsamar
	["No shaman trainer stands in the {zone:2548} or in {zone:1453}, and the {zone:1418} & {zone:1425} guide passes none: fly to {area:1537} and train there; {area:144} is a short flight on."] = "{zone:2548}和{zone:1453}都没有萨满祭司训练师，{zone:1418}和{zone:1425}指南途中也没有：飞往{area:1537}训练；从那里飞到{area:144}很近。",

	-- Step 154: Leave Stormwind
	-- {zone:1453} Stormwind
	["Leave {zone:1453}"] = "离开{zone:1453}",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar · {zone:1453} Stormwind · {object:2096} Trade District
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}. {zone:1453}'s gryphon master stands in the {object:2096}."] = "下一个指南从{zone:1432}南边的{zone:1418}开始：飞往{area:144}。{zone:1453}的狮鹫管理员在{object:2096}。",

	-- Step 155: Loch Modan
	-- {area:144} Thelsamar · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	["No flight path to {area:144} yet: go to {zone:1455} (by the {area:2257} from {zone:1453}), ride out of its gates east through {zone:1426} and the tunnel into {zone:1432}, and on along the road to {area:144}."] = "还没有前往{area:144}的飞行路线：从{zone:1453}乘{area:2257}前往{zone:1455}，出城门向东穿过{zone:1426}，经隧道进入{zone:1432}，再沿道路前往{area:144}。",

	-- Step 156: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "飞往{area:144}",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}."] = "下一个指南从{zone:1432}南边的{zone:1418}开始：飞往{area:144}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back east along the road to {area:16744}."] = "沿路向东返回{area:16744}。",
	-- ["Back past {area:16744} and south to the Holmsbys' farm by the river."] = "经过{area:16744}返回，向南前往河边的霍姆斯比农场。",
	-- ["Back to the port, from the north pier west through the docks."] = "返回港口，从北码头向西穿过船坞。",
	-- ["Back to the port."] = "返回港口。",
	-- ["Before the second wave: its raiders and bombardiers (43-45) and the pirates' ships after them are a level over you below 44.4. Top up on the first camp's buccaneers and musketeers (41-43) at its south-west end, away from the port. {npc:259758}, a rare elite of level 49, roams these cliffs: if you see him, keep well away. Or, with a group, run the {area:1517} dungeon instead."] = "在打第二波之前：低于44.4级时，第二波的袭击者和投弹手（43-45级）以及之后的海盗船都比你高一级。在第一个营地西南端、远离港口的地方刷海盗和火枪手（41-43级）补经验。{npc:259758}是49级的稀有精英，在这片悬崖游荡：如果看到他，尽量远离。或者，有小队的话改刷{area:1517}地下城。",
	-- ["Down to the port."] = "下到港口。",
	-- ["North from {area:16724}, past {area:16729} and across the river, to {area:16723}, the farm town the Twilight cult holds; keep clear of {area:16743}, the Horde's fort east of the town. {npc:259158} the kobold hides in the middle of the town, {npc:256831} at its eastern edge, and {npc:258697} waits at his farm on the north-eastern edge."] = "从{area:16724}向北，经过{area:16729}并过河，前往被暮光教派占据的农庄小镇{area:16723}；避开镇子东边的部落要塞{area:16743}。狗头人{npc:259158}躲在镇子中央，{npc:256831}在镇子东边，{npc:258697}在东北边缘的农场等你。",
	-- ["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} (level 45) stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way."] = "再次前往海盗悬崖。从南到北，在营地下方停泊的三艘船上安放威兹巴兹的炸药；{quest:95124}（45级）站在中间那艘船旁，她的战利品箱就在旁边。途中留意{npc:259758}。",
	-- ["South-west past {area:16744}: {npc:262399}, a prospector, has camped by the Cinderscale dragonkin's hollow."] = "经过{area:16744}向西南走：勘探者{npc:262399}在烬鳞龙人的洼地旁扎营。",
	-- ["The whelps nest all over the hollow; the warriors (level 41-42) guard its back, by the {item:271611}. Scaldaron, a rare elite drake, can be up here too: leave him be unless you have a group."] = "雏龙遍布整个洼地；战士（41-42级）守在洼地后部的{item:271611}旁。稀有精英幼龙斯卡尔达隆也可能在这里：除非有小队，否则别惹他。",
	-- ["The {npc:260244} prowls the shallows south-west of the port, below the murlocs' beaches. {npc:257001}, an elite, walks the shore close by: give him room."] = "{npc:260244}在港口西南、鱼人海滩下方的浅水中游荡。精英{npc:257001}在附近岸边走动：离他远一点。",
	-- ["{item:17028}, from {npc:272437}"] = "{item:17028}，找{npc:272437}领取",
	-- ["{npc:260026} waits beside the road east of the pass."] = "{npc:260026}在山口东边的路旁等候。",
	-- ["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} hands out the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031}看守着{area:16724}西南角的旧大教堂。蝙蝠栖息在教堂上层；{npc:272437}在教堂旁发放圣洁蜡烛；坟墓在礼拜堂墓地里。\n{npc:271742}是53级精英，站在大教堂内：他不会主动攻击你，千万别打他，把蝙蝠拉离他身边再打。",
	-- ["{object:621813}: bury the mementos"] = "{object:621813}：埋下纪念品",
	-- ["{quest:95122}: for later in this guide"] = "{quest:95122}：留到本指南稍后完成",
	-- ["{quest:95123}: for later in this guide"] = "{quest:95123}：留到本指南稍后完成",
	-- ["{quest:95267}: a big beast in the shallows south-west of the port, near {npc:257001}, the elite"] = "{quest:95267}：港口西南浅水中的一只巨兽，靠近精英{npc:257001}",
	-- ["{quest:95293}: for {npc:260390} at the pirates' camp"] = "{quest:95293}：交给海盗营地的{npc:260390}",
	-- ["{quest:95975}: for later, the wildflowers west of the port"] = "{quest:95975}：稍后完成，野花在港口西边",
}
