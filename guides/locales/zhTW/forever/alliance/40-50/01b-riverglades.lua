-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/01b-riverglades (forever/alliance/40-50/01b-riverglades.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16724} Farholde Keep
	["About 90 quests in Forever's new zone, 42 to 45, from {area:16724}: the level for its port and Western Front."] = "Forever新地區約90個任務，42到45級，從{area:16724}出發：正好是前往其港口和西部前線所需的等級。",

	-- Step 1: Ironforge flight master
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飛行管理員",
	-- {zone:1426} Dun Morogh · {zone:1455} Ironforge · {area:69} Lakeshire
	["The Stranglethorn guide leaves Dwarves and Gnomes at their riding trainer in {zone:1426}: ride back west into {zone:1455}, where the flight to {area:69} leaves from the gryphon master."] = "荊棘谷指南讓矮人和地精停在{zone:1426}的騎術訓練師處：向西騎回{zone:1455}，從獅鷲管理員那裡飛往{area:69}。",

	-- Step 2: Into the Riverglades
	-- {zone:2548} Riverglades
	["Into the {zone:2548}"] = "進入{zone:2548}",
	-- {zone:1455} Ironforge · {area:69} Lakeshire · {area:2417} Blackrock Pass · {zone:2548} Riverglades · {area:16737} Bristle Hills
	["Fly from {zone:1455} to {area:69} in Redridge, then follow the road north out of town and up through {area:2417}: it comes down into the western {zone:2548} by the {area:16737}."] = "從{zone:1455}飛往赤脊山的{area:69}，然後沿著道路向北出城，穿過{area:2417}：道路會在{area:16737}旁下到{zone:2548}西部。",
	-- {zone:2548} Riverglades
	["The western {zone:2548}"] = "{zone:2548}西部",

	-- Step 3: Scout Bolain
	-- {npc:260026} Scout Bolain
	["{npc:260026} waits beside the road east of the pass."] = "{npc:260026}在山口東邊的道路旁等著。",

	-- Step 4: Southern Watch
	-- {area:16744} Southern Watch
	["Follow the road east to {area:16744}, the Alliance outpost above the river. The gnolls you passed on the way in are Captain Dalton's job: you go back for them after the lumber camp."] = "沿著道路向東前往{area:16744}，河流上方的聯盟前哨。來時經過的豺狼人是道爾頓隊長的任務：伐木營之後再回去處理。",
	-- {quest:95148} Southern Watch Gnoll Report · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95148}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95148}：給{area:16724}的{npc:257558}，保留此任務",

	-- Step 5: Snargl's Snout
	-- {npc:255906} Snargl · {area:16737} Bristle Hills
	["{npc:255906} is an elite gnoll (level 40) who roams the south-western camps of the {area:16737}: grouping up is advised."] = "{npc:255906}是精英豺狼人（等級40），在{area:16737}西南方的營地遊蕩：建議組小隊。",

	-- Step 6: Turner's Logging Camp
	-- {npc:256438} Halligan Turner
	["North up the road to the lumber camp. {npc:256438} runs it; his third job, the saplings, comes once his plant food is in."] = "沿道路向北前往伐木營。{npc:256438}負責營地；他的第三個任務（樹苗）要在繳交植物養料後才會出現。",

	-- Step 7: The Bristle Hills
	-- {area:16737} Bristle Hills
	["The {area:16737}"] = "{area:16737}",
	-- {area:16737} Bristle Hills · {npc:255906} Snargl
	["West into the {area:16737}: the Redridge gnolls camp on the slopes all the way from the hills west of the lumber camp to the pass you came in by. The stolen saw blades lie only in the western camps, near the pass.\nCareful: {npc:255906}, an elite gnoll (level 40), roams the south-western camps: pull the gnolls away from him."] = "向西進入{area:16737}：赤脊山豺狼人的營地遍布山坡，從伐木營西邊的山丘一直延伸到你進來的山口。被偷的鋸片只在山口附近的西側營地。\n小心：精英豺狼人{npc:255906}（等級40）在西南方營地遊蕩：把豺狼人拉離他。",

	-- Step 9: Southern Watch
	-- {area:16744} Southern Watch
	["Back east along the road to {area:16744}."] = "沿著道路往東回到{area:16744}。",

	-- Step 11: Gelinda Coppergleam
	-- {area:16744} Southern Watch · {npc:262399} Gelinda Coppergleam
	["South-west past {area:16744}: {npc:262399}, a prospector, has camped by the Cinderscale dragonkin's hollow."] = "往西南經過{area:16744}：探勘者{npc:262399}在燼鱗龍族的谷地旁紮營。",

	-- Step 12: The Cinderscale hollow
	["The Cinderscale hollow"] = "燼鱗谷地",
	-- {item:271611} Cubic Draconia
	["The whelps nest all over the hollow; the warriors (level 41-42) guard its back, by the {item:271611}. Scaldaron, a rare elite drake, can be up here too: leave him be unless you have a group."] = "幼龍在谷地各處築巢；戰士（41-42級）守在谷地後方的{item:271611}旁。稀有精英幼龍斯卡達隆也可能出現在這裡：除非有小隊，否則別惹他。",

	-- Step 14: Holmsby farm
	["Holmsby farm"] = "霍姆斯比農場",
	-- {area:16744} Southern Watch
	["Back past {area:16744} and south to the Holmsbys' farm by the river."] = "往回經過{area:16744}，再往南到河邊的霍姆斯比農場。",

	-- Step 15: Benjy Wheeler
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner
	["North-east across the fields to {area:16725}: {npc:258317} wants the Mudfin murlocs on the river thinned out, the same murlocs whose heads {npc:256438} needs, so one pass along the river does both."] = "往東北穿過田野到{area:16725}：{npc:258317}要你清掉河邊的泥鰭魚人，{npc:256438}要的頭也是從這些魚人身上取得，沿河走一趟就能同時完成。",

	-- Step 16: Meadowsbrook and the river
	-- {area:16735} Meadowsbrook
	["{area:16735} and the river"] = "{area:16735}與河流",
	-- {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner · {npc:258588} Jumbo Crawfish · {npc:258935} Curly · {npc:259049} Robbie Holmsby · {area:16735} Meadowsbrook · {npc:263380} Ghostmaw
	-- plural, as words: Mudfin Warriors = {npc:258574} Mudfin Warrior
	["Back south-west along the river: kill the Mudfin Warriors and Oracles on the banks for {npc:258317} (they drop {npc:256438}'s heads) and the {npc:258588} in the shallows for the shells. {npc:258935}, one of {npc:256438}'s lumberjacks, is stuck on the bank just north-west of the murlocs; {npc:259049}'s hat lies on the riverbank among them; the fresh manure is in the fields of {area:16735}, between the river and the farm. {npc:263380}, an elite (level 42), prowls the river: if he comes your way, back off and let him pass."] = "沿河往西南回去：為{npc:258317}擊殺河岸上的泥鰭戰士和神諭者（牠們會掉落{npc:256438}要的頭），並擊殺淺灘中的{npc:258588}取得甲殼。{npc:256438}的伐木工之一{npc:258935}受困在魚人西北方的河岸上；{npc:259049}的帽子就在魚人之間的河岸上；新鮮肥料在{area:16735}的田裡，位於河流和農場之間。精英{npc:263380}（42級）在河邊徘徊：如果他朝你過來，就退開讓他走過。",

	-- Step 18: Watcher Fredericks
	-- {npc:259051} Watcher Fredericks · {area:16744} Southern Watch
	["{npc:259051} keeps the west end of {area:16744}."] = "{npc:259051}守在{area:16744}的西端。",

	-- Step 19: Turner's Logging Camp
	["North up the road to the lumber camp."] = "沿著道路往北到伐木營地。",

	-- Step 20: Saplings
	["Saplings"] = "樹苗",
	-- {npc:256438} Halligan Turner · {item:266161} Tree Sprouting Kit
	["Use {npc:256438}'s {item:266161} on bare ground around the camp: five saplings."] = "在營地周圍的空地上使用{npc:256438}的{item:266161}：種五棵樹苗。",

	-- Step 21: Hurley
	-- {npc:258963} Hurley · {npc:258935} Curly · {quest:94861} Helping Hands · {npc:263380} Ghostmaw
	["{npc:258963} stands at the camp's south end. He sets off for {npc:258935}, south-east of the camp, as soon as you take {quest:94861}: go with him and keep the attackers off, and wait if {npc:263380} is in sight. If it fails, {npc:258963} offers the quest again."] = "{npc:258963}站在營地南端。你一接受{quest:94861}，他就會出發去找營地東南方的{npc:258935}：跟著他並擋住攻擊者，如果看到{npc:263380}就先等一下。失敗的話，{npc:258963}會再次提供任務。",
	-- {npc:258963} Hurley · {npc:258935} Curly
	["go with {npc:258963} to save {npc:258935}"] = "跟著{npc:258963}去救{npc:258935}",

	-- Step 23: Wheeler's Grange
	-- {area:16724} Farholde Keep · {npc:258317} Benjy Wheeler · {area:16725} Wheeler's Grange
	["East along the road towards {area:16724}: hand {npc:258317} his murlocs as you pass {area:16725}."] = "沿著道路往東前往{area:16724}：經過{area:16725}時把魚人任務繳交給{npc:258317}。",

	-- Step 24: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257087} Gretchen Mayberry · {npc:260070} Bertrand Ironbrow · {npc:260080} Ember Bladewhisper · {npc:263613} Brother Lowley · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["On east along the road to {area:16724}. {npc:257087}, the gryphon master, stands at its western gate; {npc:260070} and {npc:260080} are on the way in, {npc:263613} tends the wounded by the barracks, {npc:257558} and {npc:257591} wait in the keep at the east end, and the inn is in the south of the walls."] = "繼續沿著道路往東到{area:16724}。獅鷲管理員{npc:257087}站在西門；{npc:260070}和{npc:260080}在進去的路上，{npc:263613}在兵營旁照顧傷患，{npc:257558}和{npc:257591}在東端的堡壘裡，旅店在城牆內南側。",
	-- {npc:257087} Gretchen Mayberry
	["{npc:257087}, at the western gate"] = "{npc:257087}，在西門",
	-- {npc:257558} Demar Brant
	["{npc:257558}, in the keep"] = "{npc:257558}，在堡壘裡",
	-- {quest:94877} Saving Sunnyglade
	["{quest:94877}: for later in this guide"] = "{quest:94877}：留到本指南稍後",
	-- {npc:257591} Ashe Amberhall · {quest:94881} Curious Trinkets
	["{npc:257591}: {quest:94881}, for later in this guide"] = "{npc:257591}：{quest:94881}，供本指南稍後使用",
	-- {quest:94879} Scraps of Knowledge
	["{quest:94879}, for later in this guide"] = "{quest:94879}，供本指南稍後使用",
	-- {npc:259863} Cassandra Wheeler · {quest:95330} Love Thy Neighbor · {area:16736} Turner's Logging Camp
	["{npc:259863}, by the inn: {quest:95330}, for {area:16736} later in this guide"] = "{npc:259863}，在旅店旁：{quest:95330}，本指南稍後在{area:16736}完成",
	-- {npc:257595} Barracks Master Harlan
	["{npc:257595}, at the inn"] = "{npc:257595}，在旅店",

	-- Step 25: The cathedral
	["The cathedral"] = "大教堂",
	-- {npc:262031} Sister Rowland · {area:16724} Farholde Keep · {npc:272437} Marla Bell · {npc:271742} Abbot Schuncke
	["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} sells the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031}看守著{area:16724}西南角的舊大教堂。蝙蝠棲息在教堂上層；{npc:272437}在教堂旁販售聖潔蠟燭；墳墓在禮拜堂墓園裡。\n{npc:271742}是53級精英，站在大教堂裡：他不會主動攻擊你，千萬別打他，並把蝙蝠拉離他身邊。",
	-- {item:17028} Holy Candle · {npc:272437} Marla Bell
	["{item:17028}, from {npc:272437}"] = "{item:17028}，向{npc:272437}購買",
	-- {item:269997} Bundle of Candles
	["{item:269997}, on the graves"] = "{item:269997}，放在墳墓上",

	-- Step 26: Wheeler's Grange
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler
	["West to {area:16725}: {npc:258317} stands by the farmhouse."] = "向西前往{area:16725}：{npc:258317}站在農舍旁。",

	-- Step 27: The stables
	["The stables"] = "馬廄",
	["Search around the stables south of the farmhouse for the horses' tracks; the bundles of hay lie around the farm."] = "在農舍南邊的馬廄周圍搜尋馬匹的足跡；成捆的乾草散落在農場各處。",

	-- Step 29: The coyote den
	["The coyote den"] = "郊狼巢穴",
	-- {npc:258522} Sootfur
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The coyotes den in the hills south of the farm: {npc:258522}, the big dark one, sits at the back of it; the Plains Coyotes around it drop the pelts."] = "郊狼的巢穴在農場南邊的山丘：{npc:258522}是那隻深色的大郊狼，待在巢穴深處；周圍的平原郊狼會掉落毛皮。",

	-- Step 30: The lost horse
	["The lost horse"] = "走失的馬",
	["One of Benjy's horses ran north up the river, past the farm. Give it the feed, then lead it home."] = "班吉的一匹馬沿著河往北跑，越過了農場。餵牠飼料，然後帶牠回家。",
	-- {area:16725} Wheeler's Grange
	["walk it back to {area:16725}"] = "帶牠走回{area:16725}",

	-- Step 32: Foreman's Crate
	-- {area:16729} Terral's Watch
	["North up the track towards {area:16729}: the foreman's crate lies by the road."] = "沿小路往北朝{area:16729}前進：工頭的箱子就在路旁。",

	-- Step 33: Terral's Watch
	-- {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{npc:259352} holds {area:16729}, the tower on the plains north-east of the crate."] = "{npc:259352}駐守在{area:16729}，就是箱子東北方平原上的那座塔。",

	-- Step 34: The plains
	["The plains"] = "平原",
	-- {quest:95983} A Feast for Buzzards · {npc:263380} Ghostmaw
	-- plural, as words: Rog'mar Poachers = {npc:259052} Rog'mar Poacher
	["The Rog'mar Poachers hunt the plains north of the tower; the Wildplains lions roam among them. A picked carcass lies in the grass east of the tower: its skull starts {quest:95983}.\nCareful: {npc:263380}, an elite (level 42), hunts along the river west of the plains: keep an eye on the riverbank."] = "洛格瑪盜獵者在塔北邊的平原狩獵；荒原獅子在他們之間遊蕩。塔東邊的草叢裡有一具被啃光的屍骸：它的頭骨可開始{quest:95983}。\n小心：{npc:263380}是精英（42級），在平原西邊的河岸一帶獵食：留意河岸。",

	-- Step 35: Terral's Watch
	-- {quest:94928} A Few Furs for Friz · {area:16727} Powderfuse Port
	["{quest:94928}: for {area:16727}, keep it"] = "{quest:94928}：給{area:16727}，保留此任務",
	-- {quest:95984} Song of the Strider · {npc:263367} Sleebo Fizzlespout
	["{quest:95984}: for later, where the tallstriders graze by {npc:263367}'s workshop; keep it"] = "{quest:95984}：之後在{npc:263367}的工坊旁陸行鳥吃草的地方完成，保留此任務",
	-- {quest:95064} Preventative Measures · {area:16743} Rog'mar
	["{quest:95064}: for later, at the Horde's training grounds north of {area:16743}"] = "{quest:95064}：之後在{area:16743}北邊的部落訓練場完成",
	-- {quest:96125} In Need of Relief · {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["{quest:96125}: for {npc:259057} in {area:16726}, keep it"] = "{quest:96125}：給{area:16726}的{npc:259057}，保留此任務",
	-- {quest:95426} Rog'mar Supplies
	["{quest:95426}: for later, the same training grounds"] = "{quest:95426}：之後在同一個訓練場完成",

	-- Step 36: Farholde Keep
	-- {area:16724} Farholde Keep
	["South back to {area:16724}."] = "往南回到{area:16724}。",
	-- {quest:96009} High Stakes · {area:16736} Turner's Logging Camp
	["{quest:96009}: for {area:16736} later in this guide"] = "{quest:96009}：本指南稍後在{area:16736}完成",

	-- Step 37: WANTED: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch · {npc:259859} Wheatley
	["{npc:263380} is an elite (level 42) who hunts along the river between {area:16725} and {area:16729}, on your way north later in this guide: grouping up is advised. The poster hangs by the keep; {npc:259859}, who takes the fang, stands south of the inn."] = "{npc:263380}是精英（42級），在{area:16725}和{area:16729}之間沿河獵食，就在本指南稍後北上的路上：建議組小隊。告示貼在城堡旁；收牙齒的{npc:259859}站在旅店南邊。",
	-- {object:645166} WANTED! (no name in this language: may be words)
	["the {object:645166} poster"] = "{object:645166}告示",

	-- Step 38: WANTED: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo · {area:16743} Rog'mar
	["{npc:263071} is an elite (level 42) at the Horde's training grounds north of {area:16743}, where this guide goes later: grouping up is advised."] = "{npc:263071}是精英（42級），在{area:16743}北邊的部落訓練場，本指南稍後會去那裡：建議組小隊。",
	-- {object:707245} Wanted (no name in this language: may be words)
	["the {object:707245} poster"] = "{object:707245}告示",

	-- Step 39: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch
	["{npc:263380}, the elite, hunts along the river between {area:16725} and {area:16729}, on your way north."] = "精英{npc:263380}在{area:16725}和{area:16729}之間沿河獵食，就在你北上的路上。",

	-- Step 40: Sunnyglade
	-- {area:16724} Farholde Keep · {area:16729} Terral's Watch · {area:16723} Sunnyglade · {area:16743} Rog'mar · {npc:259158} Fuzzle · {npc:256831} Apprentice Claire · {npc:258697} Farmer Elbrim
	["North from {area:16724}, past {area:16729} and across the river, to {area:16723}, the farm town the Twilight cult holds; keep clear of {area:16743}, the Horde's fort east of the town. {npc:259158} the kobold hides in the middle of the town, {npc:256831} at its eastern edge, and {npc:258697} waits at his farm on the north-eastern edge."] = "從{area:16724}往北，經過{area:16729}並渡河，前往暮光教派佔據的農莊小鎮{area:16723}；避開小鎮東邊的部落要塞{area:16743}。狗頭人{npc:259158}躲在鎮中央，{npc:256831}在小鎮東緣，{npc:258697}在東北緣的農場等你。",

	-- Step 41: The Twilight cult
	["The Twilight cult"] = "暮光教派",
	-- {area:16723} Sunnyglade · {item:266148} Farmers' Mementos · {item:4338} Mageweave Cloth · {npc:263613} Brother Lowley · {area:16724} Farholde Keep · {quest:94885} Field Marshal's Log · {npc:256899} Chogg'Zac · {npc:263380} Ghostmaw
	-- plural, as words: Twilight Raiders = {npc:256952} Twilight Raider
	["The cultists fill the streets and fields of {area:16723}. Start at the ritual circles in the middle (fill Claire's catalyst there), work west through the burnt houses to the edge of town, then back north-east to the loose soil west of Elbrim's farm: bury the {item:266148} the Twilight Raiders drop there. The charms, pages and finger bones drop from the cultists.\nKeep the {item:4338} they drop: {npc:263613} in {area:16724} asks for twenty when you are back there. Now and then a cultist drops the {quest:94885}: right-click it to start the quest.\nCareful: {npc:256899}, an elite ogre (level 41), walks the western streets of {area:16723}, around 44-47,47-52. Pull the cultists out towards you and let him pass; players died here more than anywhere else in the zone.\n{npc:263380}, the river's elite (level 42), can wander up from the south-western fields: let him pass."] = "教徒遍布{area:16723}的街道和田野。從中央的儀式法陣開始（在那裡裝滿克萊兒的催化劑），往西穿過燒毀的房屋到鎮邊，再往東北回到艾爾布林農場西邊的鬆軟土堆：把暮光掠奪者掉落的{item:266148}埋在那裡。符咒、書頁和指骨都由教徒掉落。\n保留他們掉落的{item:4338}：你回到{area:16724}時，{npc:263613}會要二十塊。教徒偶爾會掉落{quest:94885}：右鍵點擊它以接受任務。\n小心：精英食人魔{npc:256899}（41級）在{area:16723}西側街道巡邏，約在44-47,47-52。把教徒拉向你，讓他走過去；這裡是本地區玩家死最多的地方。\n河邊的精英{npc:263380}（42級）可能從西南田野晃過來：讓他走過去。",
	-- {item:269990} Crystal Catalyst
	["fill the {item:269990} at the ritual circles"] = "在儀式法陣裝滿{item:269990}",
	-- {object:621813} Loose Soil (no name in this language: may be words)
	["{object:621813}: bury the mementos"] = "{object:621813}：埋下紀念物",
	-- {quest:94885} Field Marshal's Log
	["{quest:94885}: only if a cultist dropped the log"] = "{quest:94885}：僅限教徒掉落了日誌時",

	-- Step 43: Cut Off the Heads
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{npc:256899}, the two-headed ogre, is an elite (level 41) at the western edge of {area:16723}: grouping up is advised. Claire then has the filled catalyst for {npc:257591} in {area:16724}."] = "雙頭食人魔{npc:256899}是精英（41級），在{area:16723}西緣：建議組小隊。之後克萊兒會把裝滿的催化劑交給你，送去{area:16724}給{npc:257591}。",
	-- {quest:94884} An Unsettling Discovery · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{quest:94884}: for {npc:257591} in {area:16724}"] = "{quest:94884}：給{area:16724}的{npc:257591}",

	-- Step 44: Fuzzle
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["{npc:259158} wants out of {area:16723}: lead him west to his treasure at the edge of town and keep the cultists off him."] = "{npc:259158}想離開{area:16723}：帶他向西走到城鎮邊緣的寶藏處，別讓教徒靠近他。",
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["lead {npc:259158} out of {area:16723} to his treasure, west of the town"] = "帶{npc:259158}離開{area:16723}，前往城鎮西邊他的寶藏",

	-- Step 45: Farmer Elbrim
	["Back east through the town to Elbrim's farm: the doll and the locket are in the burnt farmhouse beside it."] = "向東穿過城鎮回到艾爾布林的農場：娃娃和墜飾就在旁邊燒毀的農舍裡。",

	-- Step 46: The Rog'mar training grounds
	-- {area:16743} Rog'mar
	["The {area:16743} training grounds"] = "{area:16743}訓練場",
	-- {area:16743} Rog'mar · {npc:263071} Blademaster Kaijo · {npc:263615} Krek the Noxious
	-- plural, as words: Rog'mar Grunts = {npc:255996} Rog'mar Grunt
	["North-east of Elbrim's farm, the Horde drills its trainees in the fields north of {area:16743}. Stay north of the fort: its guards are far above your level. The supply crates lie around the drill grounds. Three elites work this ground: {npc:263071} (42) walks among the trainees, {npc:263615} (42) lurks at the north end, and Komuk (45), a Horde elite, patrols the hills to the east; give each of them room.\nCareful: Rog'mar Grunts (55) guard the fort's north wall, around 59,39 to 61,41. Leave the crates and trainees by the wall and take the ones further north, around 57-61,34-37."] = "在艾爾布林農場東北邊，部落在{area:16743}北邊的田野操練新兵。待在要塞北邊：那裡的守衛等級遠高於你。補給箱散落在操練場周圍。這一帶有三個精英：{npc:263071}（42）在新兵之間走動，{npc:263615}（42）潛伏在北端，部落精英科穆克（45）在東邊的山丘巡邏；與他們保持距離。\n小心：羅格瑪蠻兵（55）守在要塞北牆，約59,39到61,41。別碰牆邊的箱子和新兵，改打更北邊的，約57-61,34-37。",

	-- Step 47: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo
	["{npc:263071}, the elite, walks the training grounds."] = "精英{npc:263071}在訓練場上走動。",

	-- Step 48: Sleebo Fizzlespout's workshop
	-- {npc:263367} Sleebo Fizzlespout
	["{npc:263367}'s workshop"] = "{npc:263367}的工坊",
	-- {area:16743} Rog'mar · {npc:263367} Sleebo Fizzlespout · {area:16726} Bolder'ok
	["South-east, round {area:16743}'s east side, to {npc:263367}'s workshop on the hill. Komuk and the {area:16726} ogres walk the road east of the fort: let them pass before you cross it."] = "向東南繞過{area:16743}東側，前往山丘上{npc:263367}的工坊。科穆克和{area:16726}食人魔在要塞東邊的道路上走動：等他們過去再穿越道路。",

	-- Step 49: The tallstriders and the marsh
	["The tallstriders and the marsh"] = "陸行鳥與沼澤",
	-- plural, as words: Roving Tallstriders = {npc:263348} Roving Tallstrider
	["The Roving Tallstriders graze the meadows south-west of the workshop; further south-west the marsh bubbles with gas: fill the vials at the vents."] = "遊蕩的陸行鳥在工坊西南的草地上吃草；再往西南，沼澤冒著氣體：在噴氣孔裝滿瓶子。",

	-- Step 50: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower stands just south-west of the marsh."] = "{npc:259352}的塔就在沼澤西南邊。",
	-- {quest:95066} The Rog'mar Situation · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95066}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95066}：給{area:16724}的{npc:257558}，先留著",

	-- Step 51: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257591} Ashe Amberhall · {npc:257558} Demar Brant · {area:16723} Sunnyglade · {npc:263089} Tessa Dawnbright · {npc:263613} Brother Lowley
	["South across the plains to {area:16724}: {npc:257591} and {npc:257558} stand together in the keep at the east end, {npc:257591} first, her news is what Brant's next orders wait on. With {area:16723} saved, {npc:263089} by the orchard and {npc:263613} by the barracks have work for you too."] = "向南穿過平原前往{area:16724}：{npc:257591}和{npc:257558}一起站在東端的要塞裡，先找{npc:257591}，布蘭特的下一道命令要等她的消息。{area:16723}獲救後，果園旁的{npc:263089}和兵營旁的{npc:263613}也有工作給你。",
	-- {quest:94907} A Small Favor
	["{quest:94907}: for later in this guide"] = "{quest:94907}：本指南稍後使用",
	-- {quest:95329} Out in the Field · {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{quest:95329}: for {npc:259352} at {area:16729}, keep it"] = "{quest:95329}：給{area:16729}的{npc:259352}，先留著",
	-- {quest:94886} The Western Front
	["{quest:94886}: for later in this guide"] = "{quest:94886}：本指南稍後使用",
	-- {npc:263613} Brother Lowley · {item:4338} Mageweave Cloth · {area:16723} Sunnyglade
	["{npc:263613}: twenty {item:4338}, from {area:16723}'s cultists and the pirates; hand it in when you are back"] = "{npc:263613}：二十個{item:4338}，從{area:16723}的教徒和海盜身上取得；回來時再繳交",

	-- Step 52: Tessa Dawnbright
	-- {npc:263089} Tessa Dawnbright
	["{npc:263089} stands west of the inn, by the orchard: the apples hang on the trees around it."] = "{npc:263089}站在旅店西邊的果園旁：蘋果就掛在周圍的樹上。",

	-- Step 53: Coyote pelts
	["Coyote pelts"] = "土狼毛皮",
	-- {area:16725} Wheeler's Grange
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The Plains Coyotes roam west and south-west of the keep, towards {area:16725}."] = "平原土狼在要塞西邊和西南邊遊蕩，朝{area:16725}方向。",

	-- Step 54: Tessa Dawnbright
	-- {quest:95961} Stepped Out · {npc:263120} Gray Dawnbright · {area:16727} Powderfuse Port
	["{quest:95961}: for {npc:263120} in {area:16727}, keep it"] = "{quest:95961}：給{area:16727}的{npc:263120}，保留此任務",

	-- Step 55: King of the Wild Plains
	-- {npc:263315} Ombassa · {area:16729} Terral's Watch
	["{npc:263315}, an elite lion (level 41), prowls the plains north of {area:16729}, on your way back north: grouping up is advised."] = "{npc:263315}是一隻精英獅子（41級），在{area:16729}北邊的平原徘徊，就在你往北回去的路上：建議組隊。",

	-- Step 57: Sleebo Fizzlespout
	-- {npc:263367} Sleebo Fizzlespout
	["North-east to {npc:263367}'s workshop. {npc:263367}'s stress test is a fight with his G45-B4G beside the workshop: hand the quest in once it's beaten."] = "往東北前往{npc:263367}的工坊。{npc:263367}的壓力測試是在工坊旁與他的G45-B4G戰鬥：打敗它後就繳交任務。",
	["the stress test: beat G45-B4G beside the workshop"] = "壓力測試：在工坊旁打敗G45-B4G",

	-- Step 58: Powderfuse Port
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {npc:263120} Gray Dawnbright · {npc:255894} Innkeeper Zizplink · {npc:259962} Fimbo Greasemitz · {npc:259961} Wharfmaster Whizzbuzz · {npc:260487} Gritta Chumwater · {npc:260565} Kor'gar · {npc:260560} Krikshank
	["East down the road to {area:16727}, the goblins' harbour. {npc:255897} keeps a stall at the west end of the docks; {npc:263120}, {npc:255894} and {npc:259962} are at the inn, and {npc:259961} works the north pier. Zizplink's drink needs three things the port's traders sell: the chum from {npc:260487}, the degreaser and the old poison from {npc:260565} and {npc:260560}, by {npc:255897}'s stall."] = "沿道路往東到哥布林的港口{area:16727}。{npc:255897}在碼頭西端擺攤；{npc:263120}、{npc:255894}和{npc:259962}在旅店，{npc:259961}在北邊碼頭工作。吉茲普林克的飲料需要三樣港口商人販售的東西：向{npc:260487}買肉餌，向{npc:255897}攤位旁的{npc:260565}和{npc:260560}買去漬劑和過期毒藥。",
	-- {quest:95059} Frazzlespark's Crate · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95059}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95059}：給{area:16724}的{npc:257558}，保留此任務",
	-- {item:271657} Fresh Chum · {npc:260487} Gritta Chumwater
	["{item:271657}, from {npc:260487}"] = "{item:271657}，向{npc:260487}購買",
	-- {item:271653} Goblin Degreaser · {npc:260565} Kor'gar
	["{item:271653}, from {npc:260565}"] = "{item:271653}，向{npc:260565}購買",
	-- {item:271654} Expired Poison · {npc:260560} Krikshank
	["{item:271654}, from {npc:260560}"] = "{item:271654}，向{npc:260560}購買",
	-- {object:628948} WANTED! (no name in this language: may be words) · {npc:260235} Trapclaw
	["The {object:628948} poster by the inn: {npc:260235}"] = "旅店旁的{object:628948}告示：{npc:260235}",

	-- Step 59: WANTED: Old Rot-Chum
	-- {npc:257001} Old Rot-Chum
	["{npc:257001} is an elite (level 42) on the south shore: grouping up is advised."] = "{npc:257001}是南岸的精英（42級）：建議組隊。",
	-- {object:628948} WANTED! (no name in this language: may be words)
	["The {object:628948} poster by the inn"] = "旅店旁的{object:628948}告示",

	-- Step 60: The murlocs, south-west
	["The murlocs, south-west"] = "西南方的魚人",
	-- {quest:95260} Terrors From the Deep · {npc:260231} Argo Brinewhistle
	["South-west along the shore from the port: the saltwater murlocs camp on the beaches. On the way, a painted hide is stretched beside the path: it starts {quest:95260} for {npc:260231} at the docks."] = "從港口沿海岸往西南走：鹹水魚人在海灘上紮營。途中路旁撐著一張彩繪獸皮：它會開始{quest:95260}，交給碼頭的{npc:260231}。",

	-- Step 62: Back through the port
	["Back through the port"] = "穿過港口回去",
	["Back north along the shore: hand in the murlocs and the hide on the docks on your way to the crawlers."] = "沿海岸往北回去：前往爬行者的路上，在碼頭繳交魚人和獸皮任務。",
	-- {quest:95261} It Takes Guts
	["{quest:95261}: the beasts' entrails come as you go; the mushrooms are for later"] = "{quest:95261}：野獸內臟沿途就會拿到；蘑菇留待之後",

	-- Step 63: The crawlers and Trapclaw
	-- {npc:260235} Trapclaw
	["The crawlers and {npc:260235}"] = "爬行者和{npc:260235}",
	-- {npc:259962} Fimbo Greasemitz · {npc:260231} Argo Brinewhistle · {npc:260235} Trapclaw · {npc:259758} Gul'gash
	["North along the beach from the docks: the crawlers drop the meat for {npc:259962} and the spittle for Zizplink, and their entrails count for {npc:260231}. {npc:260235}, a big crab, scuttles along the rocks east of the docks. {npc:259758}, a rare elite of level 49, roams this coast from the docks up to the pirates' camp: if you see him, keep well away."] = "從碼頭沿海灘往北：爬行者會掉落給{npc:259962}的肉和給吉茲普林克的唾液，牠們的內臟也算進{npc:260231}的任務。大螃蟹{npc:260235}在碼頭東邊的岩石間爬行。49級的稀有精英{npc:259758}在碼頭到海盜營地之間的海岸遊蕩：看到他就離遠一點。",

	-- Step 64: The Eastsea pirates
	["The Eastsea pirates"] = "東海海盜",
	-- {npc:259758} Gul'gash
	["North-east along the coast to the pirates' camp on the cliffs. The buccaneers and musketeers carry the smuggled goods. {npc:259758} walks the camp too: keep an eye out for him."] = "沿著海岸向東北前往懸崖上的海盜營地。海盜和火槍手身上帶著走私貨物。{npc:259758}也會在營地裡走動：留意他的蹤影。",

	-- Step 65: Powderfuse Port
	["Back to the port, from the north pier west through the docks."] = "回到港口，從北邊碼頭向西穿過船塢。",
	-- {quest:95122} Unchecked Expansion
	["{quest:95122}: for later in this guide"] = "{quest:95122}：本指南稍後完成",
	-- {quest:95123} A Blast Ye Scurvy Dogs!
	["{quest:95123}: for later in this guide"] = "{quest:95123}：本指南稍後完成",
	-- {quest:95975} Her World
	["{quest:95975}: for later, the wildflowers west of the port"] = "{quest:95975}：稍後完成，野花在港口西邊",
	-- {quest:95293} Smuggler's Special · {npc:260390} Captain Bentcoin
	["{quest:95293}: for {npc:260390} at the pirates' camp"] = "{quest:95293}：交給海盜營地的{npc:260390}",

	-- Step 67: Beast Entrails as you go
	-- {item:268632} Beast Entrails
	["{item:268632} as you go"] = "順路收集{item:268632}",
	-- {zone:2548} Riverglades · {item:268632} Beast Entrails · {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum · {npc:263380} Ghostmaw
	["Most beasts in the {zone:2548} drop {item:268632} for {npc:260231}: the shore crawlers on this coast and the boars on the ridge west of the pirates.\nCareful: {npc:257001} (elite, 42), Komuk (a Horde elite, 45) and {npc:263380} (elite, 42) range over the zone's wilds: take your beasts away from them."] = "{zone:2548}的大多數野獸都會掉落{npc:260231}要的{item:268632}：這片海岸的海岸爬行者，以及海盜西邊山脊上的野豬。\n小心：{npc:257001}（精英，42）、科穆克（部落精英，45）和{npc:263380}（精英，42）在這個地區的荒野中遊蕩：把野獸拉離他們再打。",

	-- Step 68: Level 44.4 on the Eastsea pirates
	["Level 44.4 on the Eastsea pirates"] = "在東海海盜處升到等級44.4",
	-- {npc:259758} Gul'gash · {area:1517} Uldaman
	["Before the second wave: its raiders and bombardiers (43-45) and the pirates' ships after them are a level over you below 44.4. Top up on the first camp's buccaneers and musketeers (41-43) at its south-west end, away from the port. {npc:259758}, a rare elite of level 49, roams these cliffs: if you see him, keep well away. Or, with a group, run the {area:1517} dungeon instead."] = "打第二波之前：低於44.4時，第二波的突襲者和投彈手（43-45）以及之後的海盜船都會比你高一級。在第一個營地西南端、遠離港口的地方，打海盜和火槍手（41-43）補足經驗。{npc:259758}是49級的稀有精英，在這片懸崖遊蕩：如果看到他，請遠遠避開。或者，有小隊的話，改打{area:1517}地城。",
	-- {npc:257901} Eastsea Buccaneer
	["grind on {npc:257901}"] = "刷{npc:257901}",

	-- Step 69: The pirates' second wave
	["The pirates' second wave"] = "海盜的第二波",
	-- {npc:259758} Gul'gash
	["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. They stand close together: pull them one at a time. {npc:259758}, a rare elite of level 49, roams these cliffs and the beach below: if you see him, keep well away."] = "從港口沿著海岸向北：東海突襲者和投彈手在海盜營地西邊的山坡上、火藥桶之間據守。他們站得很近：一次拉一隻。{npc:259758}是49級的稀有精英，在這片懸崖和下方的海灘遊蕩：如果看到他，請遠遠避開。",

	-- Step 70: Captain Bentcoin
	-- {npc:260390} Captain Bentcoin · {npc:260391} Captain Haynes
	["East along the cliffs to the far end of the pirates' camp: {npc:260390} waits by the water, {npc:260391} beside him."] = "沿著懸崖向東前往海盜營地的盡頭：{npc:260390}在水邊等你，{npc:260391}就在他旁邊。",

	-- Step 71: Powderfuse Port
	["Back to the port."] = "回到港口。",

	-- Step 72: The pirates' ships
	["The pirates' ships"] = "海盜船",
	-- {quest:95124} Admiral Lamora · {npc:259758} Gul'gash
	["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} (level 45) stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way."] = "再次前往海盜的懸崖。由南到北，在營地下方停泊的三艘船上安放威茲巴茲的炸藥；{quest:95124}（等級45）站在中間那艘船旁，她的戰利品箱就在旁邊。路上留意{npc:259758}。",
	-- {item:268505} Remote Explosive Charge
	["{item:268505}, the southern ship"] = "{item:268505}，南邊的船",
	["the middle ship"] = "中間的船",
	["the northern ship"] = "北邊的船",

	-- Step 73: Rotflesh Mushrooms
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom
	["Rotflesh Mushrooms"] = "腐肉蘑菇",
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom · Mature Paletusks = {npc:255851} Mature Paletusk
	["West from the northern ship, up the ridge: the Rotflesh Mushrooms grow among the rocks, close to the Twilight ogres' camp. The Mature Paletusks on the ridge give entrails too."] = "從北邊的船往西爬上山脊：腐肉蘑菇長在岩石間，靠近暮光食人魔的營地。山脊上的成年白牙象也會掉內臟。",

	-- Step 74: Bolder'ok
	-- {area:16726} Bolder'ok · {npc:259057} Dunston Willis
	["North-west to {area:16726}, the ogres' town. Its ogres side with the Horde and attack you on sight, and Clugfist on his hill in the middle is an elite (level 50): keep to the town's north-eastern edge, where {npc:259057} hides."] = "往西北前往食人魔的城鎮{area:16726}。那裡的食人魔站在部落那邊，一看到你就會攻擊，而中央山丘上的克拉格拳是精英（50級）：沿著城鎮的東北邊緣走，{npc:259057}就躲在那裡。",

	-- Step 75: Gronok's Key
	-- {npc:263749} Gronok the Butcher · {npc:259057} Dunston Willis · {item:275043} Bloodmaster's Ring
	["{npc:263749} (level 44) carries the key: he paces the lanes south of {npc:259057}'s hut.\nThe {item:275043} lies just west of the lanes: its fighters (elites, 41-45) only fight in a bout, so leave them be."] = "{npc:263749}（44級）帶著鑰匙：他在{npc:259057}小屋南邊的巷道來回走動。\n{item:275043}就在巷道西邊：裡面的鬥士（精英，41-45級）只在比賽時才會戰鬥，別去惹他們。",

	-- Step 76: Dunston Willis
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["Free him, then get him out: {npc:259057} fights his way out of {area:16726}, and you keep the ogres off him. If he falls, take the quest from him again."] = "放他出來，然後帶他離開：{npc:259057}會一路殺出{area:16726}，你負責擋住食人魔。如果他倒下，再向他接受一次任務。",
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["help {npc:259057} break out of {area:16726}"] = "幫助{npc:259057}逃出{area:16726}",

	-- Step 77: Finish the Beast Entrails
	-- {item:268632} Beast Entrails
	["Finish the {item:268632}"] = "收集完{item:268632}",
	-- {npc:259758} Gul'gash
	["South-east out of the hills towards the port: the shore crawlers on the beach north of the docks are the quickest entrails. {npc:259758} wanders down to this beach too."] = "往東南出山丘前往港口：碼頭北邊海灘上的海岸爬行者是取得內臟最快的方式。{npc:259758}也會晃到這片海灘。",

	-- Step 78: Powderfuse Port
	["Down to the port."] = "下到港口。",
	-- {quest:95267} The Monster Surfaces · {npc:257001} Old Rot-Chum
	["{quest:95267}: a big beast in the shallows south-west of the port, near {npc:257001}, the elite"] = "{quest:95267}：港口西南方淺水區的一隻巨獸，靠近精英{npc:257001}",

	-- Step 79: The Monster Surfaces
	-- {npc:260244} Monstrous Threshadon · {npc:257001} Old Rot-Chum
	["The {npc:260244} prowls the shallows south-west of the port, below the murlocs' beaches. {npc:257001}, an elite, walks the shore close by: give him room."] = "{npc:260244}在港口西南方的淺水區徘徊，位於魚人海灘下方。精英{npc:257001}就在附近岸邊走動：離他遠一點。",

	-- Step 81: The meadows
	["The meadows"] = "草原",
	-- {npc:263367} Sleebo Fizzlespout
	["West of the port, the wildflowers grow in the meadows below {npc:263367}'s workshop."] = "港口西邊，野花長在{npc:263367}工坊下方的草原上。",

	-- Step 82: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257558} Demar Brant
	["South-west across the plains to {area:16724}: {npc:257558} in the keep at the east end."] = "往西南穿過平原前往{area:16724}：{npc:257558}在東端的要塞裡。",

	-- Step 83: Demar Brant
	-- {quest:94887} Saving Marshal Ryan
	["{quest:94887}: for later in this guide"] = "{quest:94887}：本指南稍後會用到",

	-- Step 86: Brother Lowley
	-- {npc:263613} Brother Lowley · {npc:262031} Sister Rowland
	["{npc:263613} tends the wounded beside the barracks: bandage three of his soldiers, then he has a note for {npc:262031} in the cathedral."] = "{npc:263613}在兵營旁照顧傷患：替他的三名士兵包紮，然後他會給你一封要交給大教堂裡{npc:262031}的信。",
	-- {item:272126} Makeshift Bandages
	-- plural, as words: Wounded Soldiers = {npc:263614} Wounded Soldier
	["{item:272126}, on the Wounded Soldiers beside him"] = "{item:272126}，用在他身旁的受傷士兵身上",

	-- Step 87: Farholde Keep, the west side
	-- {area:16724} Farholde Keep
	["{area:16724}, the west side"] = "{area:16724}，西側",
	-- {npc:263089} Tessa Dawnbright · {npc:259859} Wheatley
	["West through the keep: {npc:263089} by the orchard, then the cathedral and {npc:259859} south of the inn if you have their errands."] = "往西穿過要塞：果園旁的{npc:263089}，如果你有他們的差事，再去大教堂和旅店南邊的{npc:259859}。",

	-- Step 88: Sister Rowland
	-- {quest:96084} Something's in the Water
	["{quest:96084}: for later in this guide"] = "{quest:96084}：本指南稍後會用到",

	-- Step 90: Something's in the Water
	-- {area:16729} Terral's Watch · {npc:262031} Sister Rowland
	["North past {area:16729}: fill {npc:262031}'s phial in the marsh water north-east of the tower."] = "往北經過{area:16729}：在塔東北方的沼澤水中裝滿{npc:262031}的藥瓶。",

	-- Step 91: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower."] = "{npc:259352}的塔。",

	-- Step 93: Turner's Logging Camp
	-- {area:16736} Turner's Logging Camp · {npc:263380} Ghostmaw
	-- plural, as words: Peasant Woodpiles = {object:645516} Peasant Woodpile
	["West across the river to {area:16736}: the Peasant Woodpiles around the camp give the wood bundles.\nCareful: {npc:263380}, an elite (level 42), prowls the river by the camp: if he comes your way, back off and let him pass."] = "向西過河前往{area:16736}：營地周圍的農夫柴堆可取得木材捆。\n小心：精英{npc:263380}（42級）在營地旁的河邊徘徊：如果他朝你過來，就後退讓他過去。",

	-- Step 94: Sergeant Riftan
	-- {area:16685} Twilight's Shroud · {npc:258023} Sergeant Riftan
	["North up the long valley towards {area:16685}: {npc:258023} holds a small camp below the Twilight cult's fortress."] = "往北沿著長谷前往{area:16685}：{npc:258023}在暮光教派要塞下方守著一座小營地。",

	-- Step 95: The Twilight camps
	["The Twilight camps"] = "暮光營地",
	-- {npc:258652} Twilight Thrall · {npc:257591} Ashe Amberhall · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["The cult's camps fill the valley north and west of Riftan. Free the captive Farholde Scouts as you find them, and kill a {npc:258652} for {npc:257591}: her soulstone takes it. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them."] = "教派的營地遍布瑞夫坦北邊和西邊的山谷。沿途找到被俘的法霍德斥候就解救他們，並為{npc:257591}殺死一個{npc:258652}：她的靈魂石會收取它。暮光執行者（精英，45級）在營地間巡邏：每次拉怪前先看清他們的路線。{npc:256881}和{npc:256891}（精英，46級）守著谷底盡頭的要塞：把教徒拉離他們。",
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout
	["free five captive Farholde Scouts"] = "解救五名被俘的法霍德斥候",
	-- {npc:258652} Twilight Thrall
	["kill a {npc:258652}"] = "殺死一個{npc:258652}",

	-- Step 96: Marshal Ryan
	-- {npc:257250} Marshal Ryan · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	["{npc:257250} lies wounded among the camps at the valley's western edge.\nCareful: {npc:256881} and {npc:256891} (elites, 46) hold the fortress north of him: come at Ryan from the south."] = "{npc:257250}負傷躺在山谷西緣的營地之間。\n小心：{npc:256881}和{npc:256891}（精英，46級）守著他北邊的要塞：從南邊接近萊恩。",
	-- {npc:257250} Marshal Ryan
	["find {npc:257250} and talk to him"] = "找到{npc:257250}並與他交談",
	-- {quest:94892} Dying Wish · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:94892}: for {npc:257558} in {area:16724}"] = "{quest:94892}：交給{area:16724}的{npc:257558}",

	-- Step 97: The ogre mine
	["The ogre mine"] = "食人魔礦坑",
	-- plural, as words: Twilight Subjugators = {npc:260996} Twilight Subjugator · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["North of the camps the cult works ogre miners in a mine, driven by the Twilight Subjugators.\nCareful: Twilight Enforcers (elites, level 45) walk past the mine's mouth on their way through the camps. Wait for one to pass before you go in, and pull the miners and Subjugators back out to you."] = "營地北邊，教派在礦坑裡奴役食人魔礦工，由暮光征服者驅使。\n小心：暮光執行者（精英，45級）穿越營地時會經過礦坑入口。等他們走過再進去，並把礦工和征服者拉到外面來打。",

	-- Step 99: Bring Me His Head
	-- {npc:256881} Overlord Kilgar
	["{npc:256881} is an elite (level 46) in the fortress at the head of the valley, with the Enforcers around him: grouping up is advised."] = "{npc:256881}是精英（46級），位於谷底盡頭的要塞中，身邊有執行者：建議組小隊。",
	-- {quest:94891} News to Farholde · {npc:257591} Ashe Amberhall
	["{quest:94891}: for {npc:257591}"] = "{quest:94891}：交給{npc:257591}",

	-- Step 100: Back to Farholde Keep
	-- {area:16724} Farholde Keep
	["Back to {area:16724}"] = "返回{area:16724}",
	-- {area:16724} Farholde Keep
	["Your hearthstone is bound at {area:16724}'s inn: use it, or ride back south to the keep."] = "你的爐石綁定在{area:16724}的旅店：使用爐石，或往南騎回要塞。",

	-- Step 101: Farholde Keep
	-- {npc:260070} Bertrand Ironbrow · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["From the inn: {npc:260070} on the way in, then {npc:257558} and {npc:257591} in the keep."] = "從旅店出發：進來路上的{npc:260070}，接著是要塞內的{npc:257558}和{npc:257591}。",

	-- Step 103: Demar Brant
	-- {quest:94893} Delivering Closure · {npc:278088} Abigail Lawson · {zone:1453} Stormwind
	["{quest:94893}: for {npc:278088} in {zone:1453}"] = "{quest:94893}：交給{zone:1453}的{npc:278088}",

	-- Step 104: The Twilight Threat
	-- {npc:257558} Demar Brant · {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:257558}: Kilgar's head for {npc:1748} in {object:2117}"] = "{npc:257558}：把基爾加的頭顱交給{object:2117}的{npc:1748}",

	-- Step 105: Sister Rowland
	-- {npc:262031} Sister Rowland
	["{npc:262031}, in the cathedral at the keep's south-west corner."] = "{npc:262031}在要塞西南角的大教堂裡。",

	-- Step 106: Stormwind
	-- {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind · {npc:278088} Abigail Lawson · {object:2098} Cathedral Square
	["{npc:257087} flies to {zone:1453}. {npc:278088} waits in the {object:2098}."] = "{npc:257087}提供前往{zone:1453}的飛行。{npc:278088}在{object:2098}等候。",

	-- Step 108: Train before the Badlands
	-- {zone:1418} Badlands
	["Train before the {zone:1418}"] = "前往{zone:1418}前先訓練",
	-- {zone:2548} Riverglades · {zone:1418} Badlands · {zone:1425} Hinterlands · {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}, and the {zone:1418} & {zone:1425} guide passes none: {npc:257087} flies to {zone:1453}, where you train before you go on."] = "{zone:2548}沒有職業訓練師，{zone:1418}與{zone:1425}指南途中也沒有：找{npc:257087}飛往{zone:1453}，先在那裡訓練再繼續。",

	-- Step 109: Your class trainer
	["Your class trainer"] = "你的職業訓練師",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}: train here in {zone:1453} before you fly on."] = "{zone:2548}沒有職業訓練師：繼續飛行前，先在{zone:1453}這裡訓練。",

	-- Step 110: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 111: Shaman trainer
	["Shaman trainer"] = "",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind · {zone:1418} Badlands · {zone:1425} Hinterlands · {area:1537} Ironforge · {area:144} Thelsamar
	["No shaman trainer stands in the {zone:2548} or in {zone:1453}, and the {zone:1418} & {zone:1425} guide passes none: fly to {area:1537} and train there; {area:144} is a short flight on."] = "{zone:2548}和{zone:1453}都沒有薩滿訓練師，{zone:1418}與{zone:1425}指南途中也沒有：飛往{area:1537}訓練；從那裡再飛一小段就到{area:144}。",

	-- Step 112: Leave Stormwind
	-- {zone:1453} Stormwind
	["Leave {zone:1453}"] = "離開{zone:1453}",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar · {zone:1453} Stormwind · {object:2096} Trade District
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}. {zone:1453}'s gryphon master stands in the {object:2096}."] = "下一份指南從{zone:1432}南邊的{zone:1418}開始：飛往{area:144}。{zone:1453}的獅鷲管理員在{object:2096}。",

	-- Step 113: Loch Modan
	-- {area:144} Thelsamar · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	["No flight path to {area:144} yet: go to {zone:1455} (by the {area:2257} from {zone:1453}), ride out of its gates east through {zone:1426} and the tunnel into {zone:1432}, and on along the road to {area:144}."] = "還沒有前往{area:144}的飛行路線：從{zone:1453}搭{area:2257}到{zone:1455}，出城門向東穿過{zone:1426}，經隧道進入{zone:1432}，再沿道路前往{area:144}。",

	-- Step 114: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "飛往{area:144}",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}."] = "下一份指南從{zone:1432}南邊的{zone:1418}開始：飛往{area:144}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:17028}, from {npc:272437}"] = "{item:17028}，向{npc:272437}索取",
	-- ["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} hands out the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031}看守著{area:16724}西南角的舊大教堂。蝙蝠棲息在教堂上層；{npc:272437}在教堂旁發放聖潔蠟燭；墳墓在禮拜堂墓園裡。\n{npc:271742}是53級精英，站在大教堂裡：他不會主動攻擊你，千萬別打他，並把蝙蝠拉離他身邊。",
}
