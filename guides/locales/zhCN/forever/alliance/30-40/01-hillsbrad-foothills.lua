-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hearth to Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["Hearth to {area:2104}"] = "",

	-- Step 2: To Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["To {area:2104}"] = "",

	-- Step 3: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}; on the top floor"] = "",

	-- Step 4: Howin Kindfeather
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "交给{zone:1455}的国王麦格尼·铜须，在本指南结尾",

	-- Step 5: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook (no name in this language: may be words)
	["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "向南到龙喉的{area:1036}：第一架投石车就在路上，{object:671518}在营地里。",

	-- Step 7: Angerfang Encampment
	-- {quest:474} Defeat Nek'rosh
	["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "",
	-- {object:671518} Tattered Spellbook (no name in this language: may be words) · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}：交给{npc:2104}",

	-- Step 8: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "",

	-- Step 9: Golm
	-- {npc:271462} Golm · {item:279996} Goaz Stone
	["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462}站在东南方的山丘上：在它旁边使用{item:279996}。",

	-- Step 10: Dragonmaw Gates
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "向东北前往{area:1038}：{npc:271338}站在大门口，使用{item:279996}。",

	-- Step 11: Raptor Ridge: kill these as you meet them
	-- {area:1017} Raptor Ridge
	["{area:1017}: kill these as you meet them"] = "",

	-- Step 12: Dun Modr
	-- {area:205} Dun Modr · {npc:271460} Modr · {item:279996} Goaz Stone · {npc:271481} Captive Fire Elemental · {npc:1072} Roggo Harlbarrow
	["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "沿道路向北到{area:205}。{npc:271460}站在废墟里（使用{item:279996}）；{npc:271481}被关在西侧：把它带出去交给{npc:1072}。",

	-- Step 14: Whelps, raptors and Neru
	-- {npc:271458} Neru
	["Whelps, raptors and {npc:271458}"] = "雏龙、迅猛龙和{npc:271458}",

	-- Step 16: Prospector Whelgar
	["Below ground"] = "",

	-- Step 17: Menethil Harbor
	["West along the road to Menethil."] = "沿道路向西到米奈希尔港。",
	["On the top floor"] = "",

	-- Step 19: Level 31.33
	["Level 31.33"] = "",
	-- {quest:474} Defeat Nek'rosh
	["If you skipped {quest:474}, grind here to level 31.33 to stay on the route's plan."] = "",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "",

	-- Step 21: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "乘船前往{area:271}",

	-- Step 22: Southshore
	-- {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly
	["Pick up everything in town before heading out. {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}，来自{npc:2381}",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}：狮子稍后再说",

	-- Step 23: Mountain Lion on the way
	-- {npc:2406} Mountain Lion
	["{npc:2406} on the way"] = "",

	-- Step 25: Southshore
	-- {npc:2430} Chef Jessen
	["{npc:2430}, upstairs"] = "",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}，在旅店里：交给{area:35}（04-stranglethorn-vale）",
	-- {npc:2228} Lieutenant Farren Orinelle
	["{npc:2228}, inside"] = "",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}：他的线索指向阿拉希高地",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "",

	-- Step 26: On the way
	["On the way"] = "",

	-- Step 27: Torn Fin murlocs
	["Torn Fin murlocs"] = "碎鳍鱼人",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "",

	-- Step 28: Farren
	["Farren"] = "法尔林·奥里涅尔中尉",
	["Inside"] = "",

	-- Step 29: Murloc heads
	["Murloc heads"] = "鱼人头",
	["Back to the same murlocs; not every one drops a head."] = "回到同一群鱼人那里；不是每只都掉头。",

	-- Step 31: Daggerspine naga
	["Daggerspine naga"] = "刺脊纳迦",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "纳迦占据着{area:271}东南方的海岸。",

	-- Step 34: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "",

	-- Step 35: Southshore
	-- {npc:251493} Captain McManus
	["Off the boat, {npc:251493} is the first you meet, north-west of the flight master."] = "",

	-- Step 36: Yeti cave
	["Yeti cave"] = "雪人洞穴",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "雪人住在{area:271}北边山丘上的洞穴里，就在你向南返回的路上。",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth · {item:2321} Fine Thread · {area:271} Southshore
	["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438}还要一件{item:3719}、一匹{item:2997}和{item:2321}：制作或购买；披风之后回到{area:271}时再交。",

	-- Step 38: Syndicate camp
	["Syndicate camp"] = "辛迪加营地",
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "辛迪加营地在{area:287}北部、奥特兰克边境上，{area:272}（部落）西边；文件在营地里。",

	-- Step 40: Snapjaws
	["Snapjaws"] = "钳嘴龟",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "钳嘴龟在{area:271}东边、{area:272}（部落）南边的河边晒太阳。",

	-- Step 42: Corrahn's Dagger: kill these as you meet them
	-- {area:1679} Corrahn's Dagger
	["{area:1679}: kill these as you meet them"] = "",
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "",

	-- Step 45: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:271} Southshore
	["{area:271} flight master"] = "",

	-- Step 46: Deeprun Tram
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "从{object:28027}乘{area:2257}前往{zone:1455}。",
	["Level 30 and 32 spells"] = "30级和32级法术",

	-- Step 48: Fly to Stormwind City
	-- {zone:1453} Stormwind City
	["Fly to {zone:1453}"] = "飞往{zone:1453}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 49: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479}在{object:2100}的酒馆旁训练战士。{npc:6236}在{zone:1413}的{area:720}等候，在很久之后去{area:392}的路上（40-50/01）。",

	-- Step 50: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "{object:2096}的奶酪店。",

	-- Step 51: Druid training
	["Druid training"] = "德鲁伊训练",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind City
	["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455}没有德鲁伊训练师：乘地铁前先在{zone:1453}找{npc:5504}学习。",

	-- Step 53: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961}在{object:2100}的酒馆里等候；他和两个打手会和你打，但被打败后就会住手。",

	-- Step 55: Cathedral of Light
	["Cathedral of Light"] = "光明大教堂",

	-- Step 56: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:211033} Garion Wendell · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708}在{object:2164}；{npc:211033}在运河附近；{npc:5081}在{object:2101}南边。",
	-- {npc:211033} Garion Wendell
	-- plural, as words: Library Books = {object:386691} Library Book
	["{npc:211033}: only offered once you have handed in library books (the Library Books guide)"] = "{npc:211033}：交过图书馆书籍后才会提供此任务，详见《图书馆藏书》指南",

	-- Step 59: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "新的{item:279996}，用于{zone:1437}各处的四个泰坦守望者",
	-- ["A report for {object:2117}"] = "交给{object:2117}的报告",
	-- ["Back south down the road to the excavation site."] = "沿道路向南返回挖掘场。",
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "为{quest:98221}销毁营地里的四份进攻计划。",
	-- ["Fly to {zone:1453}"] = "飞往{zone:1453}",
	-- ["Follow the road east to {area:118}."] = "沿道路向东到{area:118}。",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "沿道路向东北进入{area:1025}：{npc:270637}在路旁扎营，{npc:1244}在东边不远处。",
	-- ["For {npc:2916} in {zone:1455}, at the end of this guide"] = "交给{zone:1455}的{npc:2916}，在本指南结尾",
	-- ["From {npc:2432} in {area:271}"] = "从{area:271}的{npc:2432}处",
	-- ["Golm"] = "Golm",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "向东北到{area:1038}：{npc:271373}被关押在那里，{npc:271338}站在大门旁（使用{item:279996}）。",
	-- ["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "出发前先接下镇上所有任务。下船后第一个遇到的是飞行管理员西北方的{npc:251493}；{npc:2381}和{npc:2438}站在飞行管理员和旅店之间，法尔林·奥里涅尔中尉和{npc:2366}在旅店，赫尼·马雷布镇长在市政厅。",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "大门西边的山丘上满是红色雏龙，{area:1025}满是{npc:271334}，北坡是刺喉龙；Neru站在东北方（使用{item:279996}）。\n{quest:98283}是精英：建议组队。",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "大门西边的山丘上满是红色雏龙，{area:1025}满是{npc:271334}，北坡是刺喉龙；{npc:271458}站在东北方（使用{item:279996}）。\n{quest:98283}是精英：建议组队。",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "向南到龙喉的{area:1036}；{object:671518}在营地里。",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "{npc:270892}就在勘察员维尔加营地的西边：在其中一个旁边使用他给你的{item:279996}。",
	-- ["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "碎鳍鱼人挤满了{area:271}西南方的{area:295}。",
	-- ["The Villards"] = "维拉德一家",
	-- ["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "下一步“击败纳克罗什”要你对抗一名精英酋长：跳过它。",
	-- ["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "向西到{area:287}的农场：把{item:279386}放在市政厅的记账桌上，{npc:2335}和议员们站在那里。",
	-- ["{area:287} town hall"] = "{area:287}市政厅",
	-- ["{area:287}'s town hall"] = "{area:287}的市政厅",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}：{quest:98283}，一只精英迅猛龙",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104}站在{area:2103}；{npc:2094}和{npc:270844}一起站在北门旁。",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104}站在{area:2103}；{npc:2094}站在北门旁。",
	-- ["{npc:2104}: for {npc:270637}"] = "{npc:2104}：交给{npc:270637}",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}：交给{area:442}的{npc:3649}（02-desolace）",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}，{object:171709}",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683}在{area:205}北边的{area:881}旁等候；{npc:271322}在更东北方不远处。",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455}没有德鲁伊训练师：乘地铁前先在{zone:1453}找{npc:5504}学习。",
}
