-- Chinese (simplified) (zhCN): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Undertaker Mordo
	-- {area:154} Deathknell · {npc:1568} Undertaker Mordo
	["You rise in the crypt at the south end of {area:154}. {npc:1568} waits just outside."] = "你在{area:154}南端的墓穴中苏醒。{npc:1568}就在外面等候。",

	-- Step 2: Shadow Priest Sarvis
	-- {area:154} Deathknell
	["Follow the path north into {area:154}; Sarvis stands in front of the church."] = "沿小路向北进入{area:154}；暗影牧师萨维斯站在教堂前。",
	["Inside"] = "在里面",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "{npc:1501}",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "僵尸在墓地和教堂东边的房屋周围蹒跚游荡。",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}：给{npc:244808}的卷轴",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church; inside"] = "{npc:1661}，在教堂旁；位于内部",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer; inside"] = "{npc:2119}，战士训练师；在室内。",
	-- {npc:2122} David Trias
	["{npc:2122}, the rogue trainer"] = "{npc:2122}，潜行者训练师",
	-- {npc:2123} Dark Cleric Duesten
	["{npc:2123}, the priest trainer in the church"] = "{npc:2123}，教堂里的牧师训练师",
	-- {npc:2124} Isabella
	["{npc:2124}, the mage trainer, in the church"] = "{npc:2124}，法师训练师，在教堂里",
	-- {npc:2126} Maximillion
	["{npc:2126}, the warlock trainer"] = "{npc:2126}，术士训练师",
	-- {area:154} Deathknell
	["The {area:154} trainers stand around the church"] = "{area:154}的训练师站在教堂周围",

	-- Step 5: Injured Deathguard
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["{quest:90902}: the {npc:259377} lie around the church. Heal five of them with {spell:635}."] = "{quest:90902}：{npc:259377}躺在教堂周围，用{spell:635}治疗其中5人。",

	-- Step 6: Deathknell: kill these as you meet them
	-- {area:154} Deathknell
	["{area:154}: kill these as you meet them"] = "{area:154}：沿途遇到就击杀",
	-- {area:154} Deathknell · {npc:1661} Novice Elreth
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side. {npc:1661} wants their paws and wings: kill them as you meet them while you clear the skeletons."] = "{npc:1890}在{area:154}北半部的废弃房屋里游荡。{npc:1508}和夜行蝙蝠在村子周围游荡；{npc:1509}和{npc:1513}在村子东侧。{npc:1661}需要它们的爪子和翅膀：清理骷髅时顺路击杀遇到的它们。",

	-- Step 7: Back to the church
	["Back to the church"] = "返回教堂",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, inside"] = "{npc:1661}：在屋内",
	-- {npc:244808} Aramis Hammerhand · {spell:635} Holy Light · {npc:259377} Injured Deathguard
	["{npc:244808}: {spell:635}, once five {npc:259377} are healed"] = "{npc:244808}：用{spell:635}治疗5名{npc:259377}后交谈",
	-- {npc:1569} Shadow Priest Sarvis
	["{npc:1569}, inside"] = "{npc:1569}：在屋内",
	-- {npc:244808} Aramis Hammerhand
	["{npc:244808}, inside"] = "{npc:244808}：在屋内",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}，在教堂里",

	-- Step 8: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "{object:164662}在{area:154}北部的废弃房屋旁。",

	-- Step 9: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "返回{area:154}",

	-- Step 10: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "{npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin · {area:155} Night Web's Hollow
	["{quest:91208}: the {npc:246143} fled into the hills west of the church, on the way to {area:155}."] = "{quest:91208}：{npc:246143} 逃进了教堂西边的山丘，就在前往 {area:155} 的路上。",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "向{npc:246143}提供帮助",

	-- Step 11: Night Web's Hollow
	-- {npc:271961} Webbed Forsaken
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the cocooned {npc:271961} are inside.\nCareful: A low-level character can die quickly if it pulls several Night Web Spiders in the cave at the same time."] = "向西前往洞穴。小夜行蜘蛛在洞外；夜行蜘蛛和被蛛茧包裹的 {npc:271961} 在洞内。\n小心：低等级角色如果在洞内同时引到多只夜行蜘蛛，很容易迅速死亡。",
	["Below ground"] = "在地下",
	["attack the cocoons inside the cave to free them; below ground"] = "攻击洞内的茧以释放他们；位于地下。",
	-- {npc:271961} Webbed Forsaken
	["Free the {npc:271961}"] = "救出 {npc:271961}",

	-- Step 13: The Scarlet farm
	["The Scarlet farm"] = "血色农场",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "{npc:1506}和血色新兵占据着{area:154}东边的农场。{npc:1919}在农舍之间游荡：他的遗骸用于{quest:6395}。",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{item:16333}，来自{npc:1919}",

	-- Step 14: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "{object:178090}在教堂旁的{area:154}墓地里。",

	-- Step 16: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm.\nCareful: He is flanked by two Scarlet guards, one a convert and the other an initiate, who may join the fight."] = "{npc:1667}站在血色农场南端。\n小心：他两侧有两名血色守卫，一名新兵、一名新教徒，可能加入战斗。",

	-- Step 18: Solliden Farmstead
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead · {npc:1519} Deathguard Simmer
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}; {npc:1519} stands by the road just past it."] = "沿东北方的道路离开{area:154}。{npc:6784}站在{area:156}的农舍旁；{npc:1519}站在农舍过去不远处的路边。",

	-- Step 19: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "{object:375}",
	["The pumpkins grow in the Scarlet-held fields just north-west of the farmhouse.\nCareful: Farmers stand close to the pumpkins, so you can pull more than one at once. Scarlet mobs are found around the edges of the farm and a bit to the northwest."] = "南瓜生长在农舍西北方不远处、血色十字军占据的田里。\n小心：农夫站在南瓜附近，可能一次拉到多个。血色怪物分布在农场边缘及稍偏西北处。",

	-- Step 20: Gordo
	-- {npc:10666} Gordo · {area:166} Cold Hearth Manor · {area:159} Brill · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road from here east past {area:166} almost to {area:159}, and back: if he isn't at the arrow, follow the road east until you meet him. The {item:12737} grows along the road around him."] = "{npc:10666} 是一只巨大的憎恶，沿道路从这里向东经过 {area:166}，一直走到接近 {area:159} 的地方后折返：如果箭头位置没有他，就沿道路向东寻找。{item:12737} 生长在他周围的道路沿线。",

	-- Step 21: Deathguard Dillinger
	-- {npc:1496} Deathguard Dillinger · {npc:1742} Deathguard Bartholomew · {area:159} Brill
	["{npc:1496} and {npc:1742} stand at the west end of {area:159}, where the road from Solliden comes in."] = "{npc:1496}和{npc:1742}站在{area:159}西端，索利丹农场方向的道路入口处。",
	-- {npc:1742} Deathguard Bartholomew
	["{npc:1742}, beside Dillinger"] = "{npc:1742}，在亡灵卫兵迪林格尔旁边",

	-- Step 22: Junior Apothecary Holland
	-- {area:159} Brill
	["Holland walks around the north side of {area:159}, a few steps from Dillinger."] = "初级药剂师霍兰德在{area:159}北侧走动，离迪林格不远。",
	-- {npc:10665} Junior Apothecary Holland · {area:159} Brill
	["{npc:10665} walks around {area:159}: look inside the circle on the map"] = "{npc:10665}在{area:159}附近巡逻，请在地图标出的圆圈内寻找",

	-- Step 23: Dry Branches
	["Dry Branches"] = "干枯的树枝",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "干枯的树枝散落在{area:159}西南边缘的地上。",

	-- Step 24: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "埃莉诺·沙克尔顿在镇子西南方不远处扎营。",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "在她的营火旁/sit，直到获得{spell:1229451}",

	-- Step 25: Brill
	-- {npc:1518} Apothecary Johaan · {npc:1515} Executor Zygand · {npc:1499} Magistrate Sevren
	["{npc:1518} is in the apothecary's house on the west side of the square, {npc:1515} in front of the inn with the Wanted poster beside him, {npc:1499} in the town hall on the square's north side. The inn comes last, in one go."] = "{npc:1518}在广场西侧的药剂师房子里，{npc:1515}在旅店前，旁边有通缉告示，{npc:1499}在广场北侧的市政厅里。旅店放在最后，一次完成。",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "{npc:1518}：在屋内",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}，圣骑士训练师",
	-- {npc:1515} Executor Zygand
	["{npc:1515}, in front of the inn"] = "{npc:1515}，在旅店前",
	["The Wanted poster by the inn"] = "旅店旁的通缉布告",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}，在城镇大厅里",

	-- Step 26: Carolai Anise
	-- {npc:2132} Carolai Anise · {area:159} Brill
	["From level 7 {npc:2132}, beside Johaan in the apothecary's house, offers her elixir quest; below 7 it waits for the next {area:159} visit."] = "从7级起，药剂师屋内药剂师乔汉身旁的 {npc:2132} 会提供她的药剂任务；未到7级，就等下次拜访 {area:159} 再做。",
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan; inside"] = "{npc:2132}，在乔汉旁；位于内部",

	-- Step 27: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "对镇子周围五名闲着的亡灵卫兵使用{item:286176}",

	-- Step 29: Gallows' End Tavern
	-- {npc:5688} Innkeeper Renee · {npc:265944} William Pickman · {npc:1931} Captured Scarlet Zealot · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Everything here is inside the inn, through its door on the south side: {npc:5688} at the bar, {npc:265944} at the north end of the ground floor, the {npc:1931} in the cellar under that end, and {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) upstairs: take the stairs inside, the arrow cannot tell the floors apart."] = "这里的一切都在旅店里，从南侧的门进入：{npc:5688}在吧台，{npc:265944}在一楼北端，{npc:1931}在那一端下方的地窖里，{npc:2128}（法师）、{npc:2129}（牧师）、{npc:2127}（术士）和{npc:2130}（潜行者）在楼上：从室内楼梯上去，箭头无法区分楼层。",
	-- {npc:265944} William Pickman
	["{npc:265944}, at the inn's north end: Camping 101 asks you to learn it"] = "{npc:265944}，在旅店北端：野营入门需要你学会它",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the inn's cellar"] = "{npc:1931}，在旅店地窖里",
	-- {area:159} Brill · {npc:2131} Austil de Mon · {npc:246152} Shari Stilwell
	["The {area:159} trainers are in the inn ({npc:2131} downstairs, the rest upstairs); {npc:246152}, the Paladin trainer, by the square"] = "{area:159}的训练师在旅店里（{npc:2131}在楼下，其余在楼上）；圣骑士训练师{npc:246152}在广场旁",

	-- Step 30: Coleman Farthing and Gretchen Dedmar
	-- {npc:1500} Coleman Farthing · {npc:1521} Gretchen Dedmar
	["{npc:1500} and {npc:1521}"] = "{npc:1500}和{npc:1521}",
	-- {npc:1500} Coleman Farthing · {npc:1521} Gretchen Dedmar · {area:159} Brill
	["Still in the inn: from level 7 {npc:1500} on the ground floor and {npc:1521} upstairs offer their quests; below 7 they wait for the next {area:159} visit."] = "仍在旅店内：达到7级后，底楼的{npc:1500}和楼上的{npc:1521}会提供各自的任务；不到7级则留到下次来{area:159}时再接。",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}，在旅店里",
	-- {npc:1521} Gretchen Dedmar
	["{npc:1521}, upstairs"] = "{npc:1521}：在楼上",

	-- Step 31: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "{npc:1495}的营地",
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "沿道路从{area:159}向东南经过飞艇塔。亡灵卫兵林奈、亡灵卫兵克里斯托弗和{npc:3549}在路旁扎营。",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "向{npc:251001}索取报告",

	-- Step 32: Deathguard Dillinger
	-- {area:159} Brill
	["Back up the road and through {area:159} to its west end."] = "沿道路返回并穿过{area:159}到其西端。",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "向{npc:1496}索取报告",

	-- Step 33: Cold Hearth Manor: kill these as you meet them
	-- {area:166} Cold Hearth Manor
	["{area:166}: kill these as you meet them"] = "{area:166}：沿途遇到就击杀",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo · {npc:3549} Shelene Rhobart
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse · Decrepit Darkhounds = {npc:1547} Decrepit Darkhound
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Decrepit Darkhounds roam there and on west along the road toward {npc:10666}. Johaan wants their blood, {npc:3549} their hides."] = "{npc:1525}和{npc:1526}在{area:159}西边的田野里蹒跚游荡；{npc:1547}在那里以及沿道路向西往{npc:10666}方向游荡。约翰需要它们的血，{npc:3549}需要它们的皮。",

	-- Step 34: Gordo
	-- {npc:10666} Gordo · {area:159} Brill · {area:166} Cold Hearth Manor
	["{npc:10666} walks the long road west of {area:159}, past {area:166}, and back: the arrow follows his road west until you meet him."] = "{npc:10666}沿着{area:159}以西的长路行走，经过{area:166}后返回：箭头会沿他的路线向西指引，直到你遇到他。",
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "向{npc:10666}索取报告",

	-- Step 35: Calvin Montague
	-- {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["{npc:6784} stands by the farmhouse at the {area:156}, on the way to the Crusader's Outpost."] = "{npc:6784}站在{area:156}的农舍旁，在前往十字军前哨的路上。",
	-- {npc:6784} Calvin Montague · {npc:5688} Innkeeper Renee
	["{npc:6784}, by the farmhouse: talk to him for the duel; he offers it once {npc:5688} has his letter"] = "{npc:6784}，在农舍旁：与他交谈开始决斗；{npc:5688} 收到他的信后，他才会提供这个任务",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "在决斗中击败{npc:6784}",

	-- Step 36: Crusader's Outpost
	["Crusader's Outpost"] = "十字军前哨",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost north-west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out.\nCareful: Scarlet Warriors are level 6-7 and not elite. Once their health falls to 15% they run off to bring help, so more of them may join the fight."] = "{npc:1535}守卫着南瓜田西北方的前哨。{npc:275954}被关在里面：和他交谈，一直跟着他直到他离开。\n小心：{npc:1535}为6-7级，非精英。生命值降到15%时会逃跑求援，因此可能有更多加入战斗。",
	-- {npc:275954} Bareth Dawnstone
	["{npc:275954}, on the top floor"] = "{npc:275954}，位于最顶层",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "护送{npc:275954}离开前哨",

	-- Step 37: Brill
	-- {area:159} Brill · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Back east along the road to {area:159}. {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "沿道路向东返回{area:159}。{npc:2128}（法师）、{npc:2129}（牧师）、{npc:2127}（术士）和{npc:2130}（潜行者）在旅店楼上：从室内楼梯上去，箭头无法区分楼层。",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "从{npc:2118}处购买{item:2320}，交给格莉丝·戴玛",

	-- Step 38: Tirisfal Glades: kill these as you meet them
	-- {zone:1420} Tirisfal Glades
	["{zone:1420}: kill these as you meet them"] = "{zone:1420}：沿途遇到就击杀",
	-- {area:159} Brill · {npc:3549} Shelene Rhobart · {quest:5482} Doom Weed · {npc:1753} Maggot Eye
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat · Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber · Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["Greater Duskbats fly over the fields around {area:159} and along the road north: Gretchen wants their pelts, {npc:3549} their wings.\nThe {quest:5482} grows in the graveyard fields just north of {area:159}, where the Rot Hide Graverobbers dig; all the Rot Hides drop the ichor.\nThe Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first.\nCareful: Gnoll guards stand outside the hut and can join the fight. If you slip past them and fight him inside, he fights alone.\nThe Vile Fin murlocs line the north shore: they all drop the scales, and the Minor Oracles and Muckdwellers the skins for {npc:3549}."] = "{npc:1553}在{area:159}周围的田野上空和北边的道路沿线飞行：格蕾琴需要它们的毛皮，{npc:3549}需要它们的翅膀。\n{quest:5482}生长在{area:159}北边不远处的墓地田野里，{npc:1941}在那里挖掘；所有腐皮豺狼人都会掉落脓液。\n{npc:1675}占据着更北边的山丘。{npc:1753}（11级）站在海岸南边山丘上的营地里：先清理他周围的豺狼人。\n小心：豺狼人守卫站在小屋外，可能加入战斗。如果你绕过它们在屋内与他战斗，他就只能单打独斗。\n邪鳍鱼人遍布北部海岸：它们都会掉落鳞片，小型先知和泥居者会掉落给{npc:3549}的皮。",
	-- {npc:1675} Rot Hide Mongrel · {area:164} Garren's Haunt
	["{npc:1675} walks around {area:164}: look inside the circle on the map"] = "{npc:1675}在{area:164}附近巡逻，请在地图标出的圆圈内寻找",
	-- {item:3635} Maggot Eye's Paw
	["{item:3635}; inside"] = "{item:3635}：在屋内",

	-- Step 39: Brill
	-- {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["{npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:2128}（法师）、{npc:2129}（牧师）、{npc:2127}（术士）和{npc:2130}（潜行者）在旅店楼上：从室内楼梯上去，箭头无法区分楼层。",
	-- {npc:246152} Shari Stilwell · {quest:91282} A Second Home · {quest:96899} Bandarion Keep
	["{npc:246152}, the Paladin trainer: {quest:91282}, to {quest:96899}"] = "圣骑士训练师 {npc:246152}：{quest:91282}，前往 {quest:96899}",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, inside"] = "{npc:1499}：在屋内",

	-- Step 40: Deathguard Terrence
	-- {npc:1738} Deathguard Terrence · {quest:96895} The Argent Emissary · {npc:267009} Hadric Harlson · {area:159} Brill · {area:157} Agamand Mills
	["From level 10 {npc:1738} offers {quest:96895}: {npc:267009} waits at Linnea's camp, the next stop. Below 10 it waits for the {area:159} visit after {area:157}."] = "从10级起，{npc:1738} 会提供 {quest:96895}：{npc:267009} 在下一站的琳妮亚营地等候。未到10级则留到完成 {area:157}、再次前往 {area:159} 时再做。",

	-- Step 41: Deathguard Linnea's camp
	-- {area:159} Brill
	["Follow the road south-east from {area:159} past the zeppelin towers."] = "沿道路从{area:159}向东南经过飞艇塔。",

	-- Step 42: Hadric Harlson
	-- {npc:267009} Hadric Harlson
	["{npc:267009} stands at the camp beside Linnea."] = "{npc:267009} 站在林妮亚身边的营地里。",

	-- Step 43: Magistrate Sevren
	-- {area:159} Brill · {area:157} Agamand Mills
	["Back up the road to {area:159}, on the way north-west to {area:157}."] = "沿道路返回{area:159}，顺路向西北前往{area:157}。",

	-- Step 44: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}.\nCareful: Rotting undead and Darkeye Bonecasters near the Agamands can join a fight as adds."] = "沿道路向西北到{area:157}。{npc:1657}在磨坊南边的墓地里游荡；妮萨·阿加曼德、格里高·阿加曼德和{npc:1656}在磨坊里出没。断骨士兵和{npc:1523}掉落肋骨，{npc:1522}掉落头骨，其中任何一个都可能掉落{item:2839}。\n小心：阿加曼德家族附近的腐烂亡灵和{npc:1522}可能加入战斗。",
	-- {npc:1655} Nissa Agamand
	["{npc:1655}; upstairs"] = "{npc:1655}；在楼上。",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}，稀有掉落",
	["Only if the letter dropped"] = "仅当信件已掉落",

	-- Step 45: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}，在旅店里",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}：交给{zone:1458}的{npc:4568}",
	-- {npc:1738} Deathguard Terrence · {area:159} Brill
	["{npc:1738}, if you were below 10 on the last {area:159} visit"] = "{npc:1738}，如果上次拜访 {area:159} 时还没到10级",

	-- Step 46: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:6390}在镇子北边不远处山丘上的陵墓里等候：打开大门与他战斗。",

	-- Step 47: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "从{area:159}向南走到{area:153}，再往下进入{zone:1458}。{npc:5675}站在{object:36082}。血色营地就在废墟西边。",

	-- Step 48: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "从{area:159}向南走到{area:153}，再往下进入{zone:1458}。{npc:4568}站在{object:36082}。血色营地就在废墟西边。",

	-- Step 49: Back to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Back to {zone:1420}"] = "返回{zone:1420}",
	["The Scarlet camp"] = "血色营地",

	-- Step 50: Tirisfal Glades: kill these as you meet them
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "沿道路从{area:159}向西南到血色十字军营地。{npc:1662}站在营地南端；那里的每个血色十字军都可能掉落戒指。",
	-- {npc:1537} Scarlet Zealot
	["{npc:1537} walks around here: look inside the circle on the map"] = "{npc:1537}在附近巡逻，请在地图标示的圆圈内寻找",

	-- Step 51: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "{object:37098}在营地南端的{npc:1662}旁边。",

	-- Step 53: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp, on the road to the cult's farm."] = "{npc:267009} 站在 {npc:1495} 的营地，位于通往教徒农场的路上。",

	-- Step 54: Tirisfal Glades: kill these as you meet them
	-- {npc:1495} Deathguard Linnea
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["Follow the road south-east past {npc:1495}'s camp: the Cult of the Damned holds the farm just south-east of it. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "沿路向东南经过 {npc:1495} 的营地：诅咒教派占据着营地东南方不远的农场。死灵水晶碎片散落在教徒之间的地面上，教徒身上也带着一些。",

	-- Step 55: Balnir Farmstead: kill these as you meet them
	-- {area:165} Balnir Farmstead
	["{area:165}: kill these as you meet them"] = "{area:165}：沿途遇到就击杀",
	-- {quest:99142} Tomb Weed · {npc:1664} Captain Vachon
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit · Scarlet Friars = {npc:1538} Scarlet Friar
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows: Linnea wants eight of each.\nThe Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them.\nThe spiders lurk in the woods at the far east end of the glades."] = "沿道路向东。{npc:1529}和{npc:1532}在农场东侧的墓地里出没，{quest:99142}也生长在那里：琳妮娅各需要八个。\n{npc:1538}在墓地东北方不远处扎营；{npc:1664}站在他们中间。\n蜘蛛潜伏在林地最东端的树林里。",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}，在农场的花园里",

	-- Step 57: Brill
	-- {area:159} Brill · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Back up the road to {area:159}. {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "沿道路返回{area:159}。{npc:2128}（法师）、{npc:2129}（牧师）、{npc:2127}（术士）和{npc:2130}（潜行者）在旅店楼上：从室内楼梯上去，箭头无法区分楼层。",
	-- {npc:1518} Apothecary Johaan · {area:228} Sepulcher
	["{npc:1518}: for Renferrel at the {area:228}"] = "{npc:1518}：交给{area:228}的药剂师伦弗利尔",
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the inn's cellar"] = "{npc:2211}，在旅店的地下室里",

	-- Step 58: Leonid Barthalomew the Revered
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {quest:96896} A Righteous Cause · {area:16881} Shadowvale
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp.\n{npc:246389} and {npc:259190} camp at the forest's edge just south of Leonid. Every class can take both quests once {quest:96896} is handed in (level 10). They send you into the cellar under {area:16881}, the next stop."] = "沿路向西经过{area:157}，前往{area:16616}。莱尼德·巴萨罗梅就在{npc:246389}营地北边不远处。\n{npc:246389}和{npc:259190}的营地在森林边缘，就在莱尼德·巴萨罗梅南边。所有职业交完{quest:96896}后（10级）都能接这两个任务。任务会让你进入{area:16881}下方的地窖，下一站就去那里。",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "听莱尼德·巴萨罗梅和{npc:246378}说话，然后再次与他交谈",

	-- Step 59: Paladin: Bandarion Keep
	-- {quest:96899} Bandarion Keep
	["Paladin: {quest:96899}"] = "圣骑士：{quest:96899}",
	-- {npc:246349} Breton Samuels
	["{npc:246349} waits at the keep's gate beside Leonid."] = "{npc:246349} 在城堡大门旁、莱昂尼德身边等候。",

	-- Step 60: Paladin: Murlocs at the Gates
	-- {quest:91285} Murlocs at the Gates
	["Paladin: {quest:91285}"] = "圣骑士：{quest:91285}",
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs lurk on the bluffs just east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "邪鳍鱼人潜伏在堡垒东侧不远处的高地上，以及西南面湖泊周围的营地里，位于向下通往 {area:16881} 的路上。",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "{npc:250283}",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "{npc:250282}",

	-- Step 61: Shadowvale
	-- {area:16881} Shadowvale · {area:16616} Whispering Forest
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades, south-west of the {area:16616}. Go down into the big basement under the ruined house (only a floor and a few pillars left, not the two-storey house): the bottles lie on its floor among the Shadowvale Lurchers and Mystics."] = "{area:16881} 是林地西边缘、{area:16616} 西南面的洼地。进入破屋下方的大地窖（破屋只剩地板和几根柱子，不是那栋两层房屋）：瓶子就在地窖地面上，周围有影谷潜伏者和秘法师雅尔金。",
	["the basement under the ruined house"] = "废屋下方的地下室",
	-- {item:286269} Glowing Crystal Fragment
	["the {item:286269}, at the basement's south end"] = "{item:286269}，在地下室南端",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["the Shadowvale Lurchers and Mystics drop the bones; below ground"] = "影谷潜伏者和秘法师掉落骨头；在地下",

	-- Step 62: Hilda the Breaker and Ephram Barbaro
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190}"] = "{npc:246389}和{npc:259190}",
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Back up to the forest's edge south of the keep's gate: {npc:246389} and {npc:259190} take the bones and the crystal."] = "返回城堡大门南边的森林边缘：把骸骨和水晶交给 {npc:246389} 和 {npc:259190}。",

	-- Step 63: Paladin: Bandarion Keep
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker · {npc:246349} Breton Samuels · {npc:246393} Jorin Croge · {npc:246394} Ander Solliden · {npc:246378} Danitha Morr
	["{npc:259190} and {npc:246389} at the forest's edge, {npc:246349} at the gate, {npc:246393} and {npc:246394} nearby, {npc:246378} inside."] = "{npc:259190} 和 {npc:246389} 在森林边缘，{npc:246349} 在大门处，{npc:246393} 和 {npc:246394} 在附近，{npc:246378} 在里面。",
	-- {npc:246378} Danitha Morr
	["{npc:246378}, inside the keep"] = "{npc:246378}，在城堡内",

	-- Step 64: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661}在{area:153}下方，飞艇塔旁边。{npc:5675}在{object:36082}：在他旁边的召唤法阵上使用{item:6284}，击败虚空行者。{npc:4606}在{object:36070}。{npc:4568}也在{object:36082}。",

	-- Step 66: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, inside"] = "{npc:2132}：在屋内",
	-- {area:159} Brill · {zone:1421} Silverpine Forest
	["The next guide walks south from {area:159} into {zone:1421}."] = "下篇指南从{area:159}向南步行进入{zone:1421}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:159}."] = "返回{area:159}。",
	-- ["Back to {area:16881} and down into the basement under the ruined house: the Shadowvale Lurchers and Mystics there drop the bones, and the {item:286269} is at the basement's south end."] = "返回{area:16881}，进入废屋下方的地下室。里面的影谷潜伏者和影谷秘法师会掉落骨头，{item:286269}在地下室南端。",
	-- ["Back up the road to {area:159}."] = "沿道路返回{area:159}。",
	-- ["Balnir graves"] = "巴尼尔墓地",
	-- ["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "夜行蝙蝠和黑暗犬在向西返回的道路沿线游荡；顺路收集完翅膀和皮。",
	-- ["Fields west of {area:159}"] = "{area:159}西边的田野",
	-- ["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "沿道路向东到{area:159}。{npc:10665}站在镇子西北边缘；{area:2119}是镇中央的大旅店，{npc:1515}站在旅店前。",
	-- ["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "沿道路向东。{npc:1529}和{npc:1532}在农场东侧的墓地里出没，{quest:99142}也生长在那里。",
	-- ["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "沿道路从{area:159}向东北经过{area:162}。{npc:1665}和他的两名{npc:1660}占据着{area:459}北边、东北海岸上的血色瞭望塔：先拉保镖。",
	-- ["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "沿道路向西北到{area:157}。{npc:1657}在磨坊南边的墓地里游荡；妮萨·阿加曼德、格里高·阿加曼德和{npc:1656}在磨坊里出没。断骨士兵和{npc:1523}掉落肋骨，{npc:1522}掉落头骨，其中任何一个都可能掉落{item:2839}。从这里开始，击杀路过的夜行蝙蝠和黑暗犬：{npc:3549}需要它们的翅膀和皮。",
	-- ["Follow the road south back to {area:159}."] = "沿道路向南返回{area:159}。",
	-- ["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "沿道路向西经过{area:157}到{area:16616}。莱尼德·巴萨罗梅站在{npc:246389}营地北边不远处。",
	-- ["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp.\n{npc:246389} and {npc:259190} camp at the forest's edge just south of Leonid. Every class can take both quests once {quest:96896} is handed in (level 10); take them if they are offered. They send you into the cellar under {area:16881}, the next stop."] = "沿道路向西经过{area:157}到{area:16616}。莱尼德·巴萨罗梅站在{npc:246389}营地北边不远处。\n{npc:246389}和{npc:259190}在莱尼德南边不远处的森林边缘扎营。交还{quest:96896}（10级）后，所有职业都可以接受这两个任务；如果提供就接受。它们会让你进入{area:16881}下方的地下室，也就是下一站。",
	-- ["Free six Webbed Victims inside the cave for {npc:244808}"] = "为{npc:244808}解救洞内六名被网住的被遗忘者",
	-- ["Greater Duskbats"] = "{npc:1553}",
	-- ["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "{npc:1553}在{area:159}周围的田野上空和北边的道路沿线飞行。",
	-- ["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "向西进入{area:16616}；{npc:246389}和{npc:259190}在森林边缘扎营。",
	-- ["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "向西前往洞穴。{npc:1504}在洞外；{npc:1505}和被网住的被遗忘者在洞内。",
	-- ["Hearth to {area:159}"] = "用炉石返回{area:159}",
	-- ["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "沿东北方的道路离开{area:154}。{npc:6784}站在{area:156}的农舍旁。",
	-- ["More Vile Fin murlocs walk the shore just north of the outpost."] = "前哨北边的海岸上还有更多邪鳍鱼人。",
	-- ["Paladin: {area:16616}"] = "圣骑士：{area:16616}",
	-- ["Paladin: {area:16881}"] = "圣骑士：{area:16881}",
	-- ["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "圣骑士：用{spell:635}治疗教堂周围的五名{npc:259377}后，{quest:90902}即完成。",
	-- ["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "{npc:1890}在{area:154}北半部的废弃房屋里游荡。{npc:1508}和夜行蝙蝠在村子周围游荡；{npc:1509}和{npc:1513}在村子东侧。",
	-- ["Rattlecage skulls"] = "骷髅的头骨",
	-- ["Rattlecages, scavengers and duskbats"] = "骷髅、食腐狼和夜行蝙蝠",
	-- ["Rot Hide graveyards"] = "腐皮豺狼人墓地",
	-- ["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "{npc:1535}守卫着南瓜田西边不远处的前哨。{npc:275954}被关在里面：和他交谈，一直跟着他直到他离开。",
	-- ["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "沿东南方的道路离开{area:159}；亡灵卫兵特伦斯站在飞艇塔之前的路上。",
	-- ["Talk to {npc:265944}"] = "与{npc:265944}交谈",
	-- ["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "废弃房屋里的{npc:1890}掉落头骨。",
	-- ["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "{npc:1941}在{area:159}北边的墓地里挖掘；所有腐皮豺狼人都会掉落脓液。",
	-- ["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "{npc:1675}占据着更北边的山丘。{npc:1753}（11级）站在海岸南边山丘上的营地里：先清理他周围的豺狼人。",
	-- ["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "{npc:1538}在墓地东北方不远处扎营；{npc:1664}站在他们中间。",
	-- ["The Vile Fin murlocs line the north shore."] = "邪鳍鱼人遍布北部海岸。",
	-- ["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "南瓜生长在索利丹农场西北方、血色十字军占据的田里。",
	-- ["The spiders lurk in the woods at the far east end of the glades."] = "蜘蛛潜伏在林地最东端的树林里。",
	-- ["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "蜘蛛潜伏在林地最东端的树林里。{npc:276020}是一个失控的憎恶，在它们西北方不远处游荡。{npc:276020}是精英：建议组队。",
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "飞艇停靠在{zone:1454}正门东北方的塔上。沿道路向南进入{zone:1411}，从{area:379}下方过{area:815}的桥，然后沿道路向西到{area:380}。",
	-- ["The {area:159} trainers are in and around the inn"] = "{area:159}的训练师在旅店内外",
	-- ["The {npc:1931}, in the town hall basement"] = "{npc:1931}，在城镇大厅的地下室",
	-- ["The {npc:2211}, in the town hall basement"] = "{npc:2211}，在城镇大厅的地下室",
	-- ["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "{quest:5482}生长在{area:159}北边的墓地田野里。",
	-- ["Vicious Night Web Spiders"] = "{npc:1555}",
	-- ["Vile Fin murlocs"] = "邪鳍鱼人",
	-- ["Vile Fin shore"] = "邪鳍海岸",
	-- ["Walk on west to the {area:156}. {npc:1519} stands at the farm; {npc:6784}, by the farmhouse, wants a duel: talk to him."] = "继续向西走到{area:156}。{npc:1519}站在农场里；农舍旁的{npc:6784}想和你决斗：和他对话。",
	-- ["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "继续向西走到{npc:6784}处并与他交谈：他想和你决斗。",
	-- ["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "从{area:159}向东南走到{area:153}外的飞艇塔，登上前往{zone:1454}的飞艇（另一艘前往{object:3202}）。",
	-- ["Walk south-west from the mills: the pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "从磨坊向西南走：南瓜生长在索利丹农场西北方、血色十字军占据的田里。",
	-- ["Walk south-west to the {area:156}; Simmer stands at the farm."] = "向西南走到{area:156}；亡灵卫兵希米尔站在农场里。",
	-- ["Webbed Victims"] = "被网住的被遗忘者",
	-- ["Zeppelin to {zone:1411}"] = "乘飞艇前往{zone:1411}",
	-- ["Zeppelin tower"] = "飞艇塔",
	-- ["in the inn: ask him about cooking"] = "在旅店里：向他询问烹饪",
	-- ["{area:16881} is the hollow at the west edge of the glades. Go down into the big basement under the ruined house (only a floor and a few pillars left, not the two-storey house): the bottles lie on its floor among the Shadowvale Lurchers and Mystics."] = "{area:16881}位于这片林地的西端。进入废屋下方的大地下室：废屋只剩地板和几根柱子，不是那栋两层楼的房子。瓶子散落在地下室地面上，周围有影谷潜伏者和影谷秘法师。",
	-- ["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881}是林地西缘的洼地。{npc:260428}和影谷秘法师掉落骨头；瓶子散落在它们中间的地上，{item:286269}在南端。",
	-- ["{item:286326}, from {npc:276020}"] = "{item:286326}，来自{npc:276020}",
	-- ["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "{npc:10666}是一个巨大的憎恶，在稍往东的路上巡逻。{item:12737}生长在他周围的路旁。",
	-- ["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}：{npc:276020}，东边的一个精英憎恶",
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496}站在{area:159}。{npc:6390}在镇子北边山丘上的陵墓里等候：打开大门与他战斗。",
	-- ["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525}和{npc:1526}在{area:159}西边的田野里蹒跚游荡；黑暗犬在更西边、靠近{npc:10666}的地方游荡。",
	-- ["{npc:1661}, beside the church"] = "{npc:1661}，在教堂旁",
	-- ["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667}站在血色农场南端。",
	-- ["{npc:2119}, the warrior trainer"] = "{npc:2119}，战士训练师",
	-- ["{npc:2132}, beside Johaan"] = "{npc:2132}，在药剂师乔汉旁",
	-- ["{npc:244808} and {npc:5667}"] = "{npc:244808}和{npc:5667}",
	-- ["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808}和{npc:5667}站在教堂旁。",
	-- ["{npc:246389} and {npc:259190} camp at the forest's edge, just south of Leonid. Their quests need level 10."] = "{npc:246389}和{npc:259190}在森林边缘扎营，就在莱尼德·巴萨罗梅南边。他们的任务要求10级。",
	-- ["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009}站在{npc:1495}的营地。",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}，双足飞龙管理员",
	-- ["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}：{npc:246143}逃进了教堂西边的山丘。",
	-- ["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897}占据着营地东南方不远处的农场。{item:275851}散落在教徒之间的地面上，教徒身上也带有一些。",
}
