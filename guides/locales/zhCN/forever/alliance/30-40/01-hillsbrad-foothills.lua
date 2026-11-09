-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["To {area:2104}"] = "前往{area:2104}",

	-- Step 2: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook (no name in this language: may be words)
	["South-east from Menethil to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "从米奈希尔向东南前往龙喉的{area:1036}：第一辆投石车在途中，{object:671518}在营地内。",

	-- Step 4: Angerfang Encampment
	-- {quest:474} Defeat Nek'rosh
	["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "后续任务{quest:474}需要挑战精英酋长，跳过即可。",
	-- {object:671518} Tattered Spellbook (no name in this language: may be words) · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}：交给{npc:2104}",

	-- Step 5: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:2091}是 32 级精英，多数职业到 34 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。\n注意：他两侧有暗影法师，至少一名与他联动，拉他时会一同参战。帐篷环周围还分布着非精英百夫长和队长。",

	-- Step 6: Golm
	-- {npc:271462} Golm · {npc:271338} Ados · {npc:271458} Neru · {npc:271460} Modr · {item:279996} Goaz Stone
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:271462}, {npc:271338}, {npc:271458} and {npc:271460} are level 32 elites, each called up by using the {item:279996} beside it. Skip them if you are alone. {npc:271462} stands in the south-eastern hills."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:271462}、{npc:271338}、{npc:271458}和{npc:271460}都是 32 级精英，需要在各自近旁使用{item:279996}召唤。单人时可跳过。{npc:271462}位于东南侧山丘。",

	-- Step 7: Ados
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "向东北前往{area:1038}：{npc:271338}站在大门口，使用{item:279996}。",

	-- Step 8: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "{area:1038}：沿途击杀以下目标",
	-- {area:1036} Angerfang Encampment · {quest:98283} Carnage · {area:205} Dun Modr
	["The whelps nest in the hills north-east of the {area:1036}; {quest:98283} prowls further north, and the Razormaw raptors hunt the highlands on the way north to {area:205}.\n{quest:98283} is elite: grouping up is advised."] = "雏龙栖息在{area:1036}东北的山丘；{quest:98283}在更北面游荡，刺喉迅猛龙则在向北前往{area:205}途中的高地活动。\n{quest:98283}是精英，建议组队。",

	-- Step 9: Razormaw nests
	["Razormaw nests"] = "",
	-- {quest:98246} Trying Times · {quest:98283} Carnage
	-- plural, as words: Perfect Razormaw Eggs = {item:280132} Perfect Razormaw Egg
	["The Perfect Razormaw Eggs for {quest:98246} lie in the raptors' nests in the hills around {quest:98283}."] = "",

	-- Step 10: Neru
	-- {npc:271458} Neru · {area:1038} Dragonmaw Gates · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271458} stands in the hills between the {area:1038} and {area:205} (use the {item:279996})."] = "{npc:271458}位于{area:1038}与{area:205}之间的山丘，使用{item:279996}召唤。",

	-- Step 11: The Green Belt
	-- {area:1025} The Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Maddened Rotclaws roam the {area:1025} around {npc:1244}; one of them drops the flesh. {npc:1244} takes the quest only with {quest:98283}'s head too."] = "",

	-- Step 12: Rethiel the Greenwarden
	-- {quest:98283} Carnage
	["With {quest:98283}'s head and the flesh"] = "",

	-- Step 13: Dun Modr
	-- {area:205} Dun Modr · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["North along the road to {area:205}. {npc:1071} and {npc:1075} stand together in the dwarves' camp on the east side of the road; the {object:147516} ruins west of it are full of elites."] = "",

	-- Step 14: Captive Fire Elemental
	-- {npc:271481} Captive Fire Elemental · {object:147516} Dark Iron · {npc:1364} Balgaras the Foul · {npc:1072} Roggo Harlbarrow
	["These are elite mobs: grouping up is encouraged, look for people to do it with. The {npc:271481} is held at the far west end of the {object:147516} ruins, past level 27-30 elite dwarves, and {npc:1364} (34, elite) can be among them. Lead it east out of the ruins, then hand it in to {npc:1072} in the camp. Skip it if you are alone."] = "",

	-- Step 15: Modr
	-- {npc:271460} Modr · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271460} stands in the ruins of {area:205} (use the {item:279996})."] = "{npc:271460}位于{area:205}废墟内，使用{item:279996}召唤。",

	-- Step 16: The Villards
	["The Villards"] = "维拉德一家",
	-- {npc:5683} Corma Villard · {area:205} Dun Modr · {area:880} Thandol Span · {npc:271322} Essene Villard · {npc:1075} Rhag Garmason · {quest:87318} Hearts of the Lost
	-- plural, as words: Dark Iron Saboteurs = {npc:1052} Dark Iron Saboteur
	["{npc:5683} waits on the road north of {area:205}, towards the {area:880}; {npc:271322} a short walk further north-east, and Ebenezer Rustlocke's corpse lies under the span beside her. Rustlocke's parchment goes back to {npc:1075}.\n{npc:5683} may not offer {quest:87318} yet: if she doesn't, skip it.\nTwo elite Dark Iron Saboteurs stand by the corpse inside the span: pull them one at a time, or loot the corpse and run out."] = "",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "{object:2652}，在里面",
	["the same corpse"] = "同一具尸体",

	-- Step 17: Rhag Garmason
	-- {area:205} Dun Modr · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["Back down the road to {area:205}: {npc:1075} wants the {object:147516} explosives under the far end of the span destroyed."] = "沿路返回{area:205}：{npc:1075}要你摧毁大桥另一端下方的{object:147516}炸药。",

	-- Step 18: The Cache of Explosives
	-- {object:2704} Cache of Explosives
	["The {object:2704}"] = "{object:2704}",
	-- {area:880} Thandol Span
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["Over the {area:880}: the Dark Irons' cache of explosives sits by its Arathi end."] = "",

	-- Step 19: Waterlogged Envelope
	["Underwater"] = "在水下",

	-- Step 20: Rhag Garmason again
	-- {npc:1075} Rhag Garmason
	["{npc:1075} again"] = "再次找{npc:1075}",
	-- {area:205} Dun Modr
	["Back over the span and down the road through {area:205} on the way south."] = "返回大桥另一侧，再沿路向南，经过{area:205}。",
	-- {npc:2700} Captain Nials · {area:320} Refuge Pointe
	["for {npc:2700} at {area:320}, in 05-arathi-highlands"] = "在05-arathi-highlands中交给{area:320}的{npc:2700}",

	-- Step 22: Howin Kindfeather
	-- {quest:98246} Trying Times
	["{quest:98246}: the eggs"] = "",

	-- Step 23: Prospector Whelgar
	["Below ground"] = "在地下",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "交给{zone:1455}的{npc:2916}，在本指南结尾",

	-- Step 24: Menethil Harbor
	["West along the road to Menethil."] = "沿道路向西到米奈希尔港。",
	["On the top floor"] = "在最顶层",
	-- {npc:4455} Red Jack Flint · {quest:1132} Fiora Longears
	["{npc:4455}, by the keep's door: for {quest:1132} in Theramore, in the next guide"] = "",

	-- Step 25: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104} stands on the top floor of {area:2103}: go up inside, the arrow cannot tell the floors apart."] = "{npc:2104}站在{area:2103}的顶层：从里面上楼，箭头无法区分楼层。",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}, back east along the road"] = "{npc:2104}：交给{npc:270637}，沿路向东返回",

	-- Step 26: Howin Kindfeather
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Back east along the road to the {area:1025}: {npc:270637} camps among the Fenrunners, just west of {npc:1244}. Then west again to Menethil for the boat."] = "沿路向东返回{area:1025}：{npc:270637}的营地在{npc:1244}西边不远，周围是藓皮沼泽行者。然后再向西返回米奈希尔坐船。",
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "交给{zone:1455}的国王麦格尼·铜须，在本指南结尾",

	-- Step 27: Level 30.8
	["Level 30.8"] = "30.8级",
	-- {quest:474} Defeat Nek'rosh · {area:133} Gnomeregan · {area:796} Scarlet Monastery
	["Skipped {quest:474} and short of 30.8? Kill the Bluegill murlocs on the coast south of Menethil until level 30.8. Or, with a group, run the {area:133} dungeon or the {area:796} dungeon (Graveyard) instead."] = "跳过了{quest:474}，还没到30.8级？在米奈希尔以南的海岸刷蓝腮鱼人，直到30.8级。也可以组队去{area:133}副本或{area:796}副本（墓地）。",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "反复击杀{npc:1418}补足经验",

	-- Step 29: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "乘船前往{area:271}",

	-- Step 30: Southshore
	-- {npc:2711} Phin Odelic · {npc:2430} Chef Jessen · {npc:2382} Darren Malvew · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly · {quest:98463} Talk of the Town
	["Off the boat, walk up the pier into town: {npc:2711} and Lieutenant Farren stand by the inn, {npc:2430} upstairs, {npc:2382} east of it; the flight master is at the north end, {npc:2381} and {npc:2438} between her and the inn, Maleb in the town hall at the west side.\n{npc:2366} may not offer {quest:98463} on Forever: if she doesn't, skip it."] = "",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}：他的线索指向阿拉希高地",
	-- {npc:2228} Lieutenant Farren Orinelle
	["{npc:2228}, inside"] = "{npc:2228}：在屋内",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}，在旅店里：交给{area:35}（04-stranglethorn-vale）",
	-- {npc:2430} Chef Jessen
	["{npc:2430}, upstairs"] = "{npc:2430}：在楼上",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}：狮子稍后再说",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}，来自{npc:2381}",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "{npc:2276}：在屋内",

	-- Step 31: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {skill:165} Leatherworking · {item:2997} Bolt of Woolen Cloth · {skill:197} Tailoring
	["{npc:2438} makes a yeti fur cloak for anyone who brings a {item:3719} ({skill:165}) and a {item:2997} ({skill:197}); no vendor sells either, so this step shows only when you carry both."] = "",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth
	["{npc:2438}, between the flight master and the inn: he wants a {item:3719} and a {item:2997} too"] = "",

	-- Step 32: Torn Fin murlocs
	["Torn Fin murlocs"] = "碎鳍鱼人",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "碎鳍鱼人密集分布于{area:271}西南侧的{area:295}。\n注意：其中一个营地有一群紧挨着的神谕者，拉怪时会全部参战。",

	-- Step 33: Farren
	["Farren"] = "法尔林·奥里涅尔中尉",
	["Inside"] = "在里面",

	-- Step 34: Murloc heads
	["Murloc heads"] = "鱼人头",
	["Back to the same murlocs; not every one drops a head."] = "回到同一群鱼人那里；不是每只都掉头。",

	-- Step 36: Daggerspine naga
	["Daggerspine naga"] = "刺脊纳迦",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "纳迦占据着{area:271}东南方的海岸。",

	-- Step 37: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "给{object:2117}的报告，进入屋内交付",

	-- Step 39: Southshore
	-- {npc:251493} Captain McManus · {quest:98059} Hillsbrad's Hoard · {item:279386} Sealed Company Request · {area:287} Hillsbrad · {area:271} Southshore
	["{npc:251493} stands north-west of the flight master, on the way north to the yeti cave.\n{quest:98059}: {npc:251493} hands you a {item:279386} for the {area:287} council, in the farms west of {area:271}; you deliver it after the Syndicate camp."] = "",

	-- Step 40: Yeti cave
	["Yeti cave"] = "雪人洞穴",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on the way north to the Syndicate camp."] = "雪人住在{area:271}北边山丘上的洞穴里，就在向北去辛迪加营地的路上。",

	-- Step 41: Alterac Mountains
	["Syndicate camp"] = "辛迪加营地",

	-- Step 42: Syndicate camp
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp, and its Footpads and Thieves are the Syndicate Maleb wants."] = "辛迪加营地在{area:287}北部、奥特兰克边境上，{area:272}（部落）西边；文件在营地里，营地里的辛迪加潜行者和盗贼就是马雷布要找的辛迪加。",

	-- Step 43: Hillsbrad Fields
	-- {area:286} Hillsbrad Fields
	["South-west from the Syndicate camp to the {area:286} farms."] = "",

	-- Step 44: Hillsbrad council
	-- {area:287} Hillsbrad
	["{area:287} council"] = "",
	-- {item:279386} Sealed Company Request · {area:287} Hillsbrad
	["Use the {item:279386} at the {area:287} council."] = "",

	-- Step 45: Snapjaws
	["Snapjaws"] = "钳嘴龟",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "钳嘴龟在{area:271}东边、{area:272}（部落）南边的河边晒太阳。",

	-- Step 47: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飞往{area:1537}",
	-- {area:271} Southshore
	["{area:271} flight master"] = "{area:271}的飞行管理员",

	-- Step 48: Hall of Explorers
	-- {npc:1356} Prospector Stormpike · {npc:2916} Historian Karnik · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers
	["{npc:1356}, {npc:2916} and {npc:5637} stand in the {object:32356}, north-east of the flight master."] = "{npc:1356}、{npc:2916}和{npc:5637}位于飞行管理员东北侧的{object:32356}。",
	["Level 30 and 32 spells"] = "30级和32级法术",

	-- Step 52: King Magni Bronzebeard
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "{npc:2784}，{object:171709}",

	-- Step 53: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飞往{zone:1453}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飞行管理员",

	-- Step 54: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "{object:2096}的奶酪店。",

	-- Step 55: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961}在{object:2100}的酒馆里等候；他和两个打手会和你打，但被打败后就会住手。",
	-- {npc:4961} Dashel Stonefist
	["Beat {npc:4961} and his thugs: they give up"] = "",

	-- Step 56: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479}在{object:2100}的酒馆旁训练战士。{npc:6236}在{zone:1413}的{area:720}等候，在很久之后去{area:392}的路上（40-50/01）。",

	-- Step 58: Cathedral of Light
	["Cathedral of Light"] = "光明大教堂",

	-- Step 60: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:5081} south of the {object:2101}."] = "{npc:2708}在{object:2164}内；{npc:5081}在{object:2101}南面。",

	-- Step 61: Druid training
	["Druid training"] = "德鲁伊训练",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{zone:1455} has no druid trainer: {npc:5504} stands in {zone:1453}, north-west of the {object:2101}."] = "{zone:1455}没有德鲁伊训练师：{npc:5504}在{zone:1453}，位于{object:2101}西北。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "新的{item:279996}，用于{zone:1437}各处的四个泰坦守望者",
	-- ["A report for {object:2117}"] = "交给{object:2117}的报告",
	-- ["Back east along the road to the {area:1025}: {npc:270637} camps among the Fenrunners, just west of {npc:1244}. Then west again to Menethil for the boat."] = "沿路向东返回{area:1025}：{npc:270637}的营地在{npc:1244}西边不远，周围是藓皮沼泽行者。然后再向西返回米奈希尔坐船。",
	-- ["Back south down the road to the excavation site."] = "沿道路向南返回挖掘场。",
	-- ["Comar Villard"] = "Comar Villard",
	-- ["Comar Villard waits on the road north of {area:205}, towards the {area:880}; {npc:271322} a short walk further north-east, and Ebenezer Rustlocke's corpse lies under the span beside her. Rustlocke's parchment goes back to {npc:1075}."] = "Comar Villard在{area:205}以北、通往{area:880}的道路上；再向东北走一小段便是{npc:271322}，伊贝尼瑟的尸体躺在她身旁的大桥下。伊贝尼瑟的羊皮纸要带回给{npc:1075}。",
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "为{quest:98221}销毁营地里的四份进攻计划。",
	-- ["Fly to {zone:1453}"] = "飞往{zone:1453}",
	-- ["Follow the road east to {area:118}."] = "沿道路向东到{area:118}。",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "沿道路向东北进入{area:1025}：{npc:270637}在路旁扎营，{npc:1244}在东边不远处。",
	-- ["For King Magni in {zone:1455}, at the end of this guide"] = "交给{zone:1455}的国王麦格尼·铜须，在本指南结尾",
	-- ["For {npc:2916} in {zone:1455}, at the end of this guide"] = "交给{zone:1455}的{npc:2916}，在本指南结尾",
	-- ["From {npc:2432} in {area:271}"] = "从{area:271}的{npc:2432}处",
	-- ["Golm"] = "Golm",
	-- ["Maddened Rotclaws roam the {area:1025} around {npc:1244}."] = "疯狂的腐爪在{npc:1244}周围的{area:1025}游荡。",
	-- ["North along the road to {area:205}. {npc:1071}, {npc:1075} and {npc:1072} stand together in the dwarves' camp; the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "沿路向北前往{area:205}。{npc:1071}、{npc:1075}和{npc:1072}一起站在矮人营地里；{npc:271481}被关在西侧：把它带出来交给{npc:1072}。",
	-- ["North along the road to {area:205}. {npc:1071}, {npc:1075} and {npc:1072} stand together in the dwarves' camp; {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "沿道路向北到{area:205}。{npc:1071}、{npc:1075}和{npc:1072}一起站在矮人营地里；{npc:271460}站在废墟里（使用{item:279996}）；{npc:271481}被关在西侧：把它带出去交给{npc:1072}。",
	-- ["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "沿道路向北到{area:205}。{npc:271460}站在废墟里（使用{item:279996}）；{npc:271481}被关在西侧：把它带出去交给{npc:1072}。",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "向东北到{area:1038}：{npc:271373}被关押在那里，{npc:271338}站在大门旁（使用{item:279996}）。",
	-- ["Off the boat, walk up the pier into town: {npc:2711} and Lieutenant Farren stand by the inn, {npc:2705} below it and {npc:2430} upstairs, {npc:2382} east of it; the flight master is at the north end, {npc:2381} and {npc:2438} between her and the inn, Maleb in the town hall at the west side."] = "下船后沿码头走进镇子：{npc:2711}和法尔林·奥里涅尔中尉站在旅店旁，{npc:2705}在旅店下面，{npc:2430}在楼上，{npc:2382}在旅店东边；飞行管理员在北端，{npc:2381}和{npc:2438}在她和旅店之间，赫尼·马雷布镇长在西侧的市政厅。",
	-- ["Over the {area:880}: Ebenezer Rustlocke lies under its Arathi end, {npc:2696} a short walk west of it."] = "越过{area:880}：埃比尼泽·拉斯洛克躺在桥的阿拉希一端下方，{npc:2696}在其西边不远处。",
	-- ["Over the {area:880}: the Dark Irons' cache of explosives sits by its Arathi end. {npc:2696} stands a short walk west of it."] = "穿过{area:880}：黑铁的炸药堆就在大桥阿拉希一端旁边。{npc:2696}站在其西面不远处。",
	-- ["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "出发前先接下镇上所有任务。下船后第一个遇到的是飞行管理员西北方的{npc:251493}；{npc:2381}和{npc:2438}站在飞行管理员和旅店之间，法尔林·奥里涅尔中尉和{npc:2366}在旅店，赫尼·马雷布镇长在市政厅。",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "大门西边的山丘上满是红色雏龙，{area:1025}满是{npc:271334}，北坡是刺喉龙；Neru站在东北方（使用{item:279996}）。\n{quest:98283}是精英：建议组队。",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "大门西边的山丘上满是红色雏龙，{area:1025}满是{npc:271334}，北坡是刺喉龙；{npc:271458}站在东北方（使用{item:279996}）。\n{quest:98283}是精英：建议组队。",
	-- ["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "向南到龙喉的{area:1036}：第一架投石车就在路上，{object:671518}在营地里。",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "向南到龙喉的{area:1036}；{object:671518}在营地里。",
	-- ["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "从{object:28027}乘{area:2257}前往{zone:1455}。",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "{npc:270892}就在勘察员维尔加营地的西边：在其中一个旁边使用他给你的{item:279996}。",
	-- ["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "辛迪加营地在{area:287}北部、奥特兰克边境上，{area:272}（部落）西边；文件在营地里。",
	-- ["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "碎鳍鱼人挤满了{area:271}西南方的{area:295}。",
	-- ["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "雪人住在{area:271}北边山丘上的洞穴里，就在你向南返回的路上。",
	-- ["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "向西到{area:287}的农场：把{item:279386}放在市政厅的记账桌上，{npc:2335}和议员们站在那里。",
	-- ["Whelps, raptors and {npc:271458}"] = "雏龙、迅猛龙和{npc:271458}",
	-- ["{area:287} town hall"] = "{area:287}市政厅",
	-- ["{area:287}'s town hall"] = "{area:287}的市政厅",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}：{quest:98283}，一只精英迅猛龙",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104}站在{area:2103}；{npc:2094}和{npc:270844}一起站在北门旁。",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104}站在{area:2103}；{npc:2094}站在北门旁。",
	-- ["{npc:2104}: for {npc:270637}"] = "{npc:2104}：交给{npc:270637}",
	-- ["{npc:2104}: for {npc:270637}, back east along the road"] = "{npc:2104}：交给{npc:270637}，沿路向东返回",
	-- ["{npc:211033}: only offered once you have handed in library books (the Library Books guide)"] = "{npc:211033}：交过图书馆书籍后才会提供此任务，详见《图书馆藏书》指南",
	-- ["{npc:2438} also wants a {item:3719} ({skill:165}), a {item:2997} ({skill:197}) and {item:2321} (any trade supplier): the cloak is turned in when you are back in {area:271} later."] = "{npc:2438}还需要{item:3719}（{skill:165}）、{item:2997}（{skill:197}）和{item:2321}（任意商贸供应商均有出售）：披风等稍后回到{area:271}时再交。",
	-- ["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438}还要一件{item:3719}、一匹{item:2997}和{item:2321}：制作或购买；披风之后回到{area:271}时再交。",
	-- ["{npc:2438}: only if you have or can buy a {item:3719} ({skill:165}) and a {item:2997} ({skill:197}); no vendor sells them"] = "{npc:2438}：仅在已有或能买到{item:3719}（{skill:165}）和{item:2997}（{skill:197}）时接；商人不卖这些",
	-- ["{npc:251493} stands north-west of the flight master, on the way north to the yeti cave."] = "{npc:251493}站在飞行管理员西北方，就在向北去雪人洞穴的路上。",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}：交给{area:442}的{npc:3649}（02-desolace）",
	-- ["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708}在{object:2164}；{npc:211033}在运河附近；{npc:5081}在{object:2101}南边。",
	-- ["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462}站在东南方的山丘上：在它旁边使用{item:279996}。",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}，{object:171709}",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683}在{area:205}北边的{area:881}旁等候；{npc:271322}在更东北方不远处。",
	-- ["{npc:5683} waits on the road north of {area:205}, towards the {area:880}; {npc:271322} a short walk further north-east."] = "{npc:5683}在{area:205}北边、通往{area:880}的路上等候；{npc:271322}在更东北方不远处。",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455}没有德鲁伊训练师：乘地铁前先在{zone:1453}找{npc:5504}学习。",
}
