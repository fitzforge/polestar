-- Chinese (simplified) (zhCN): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1448} Felwood · {area:2255} Everlook · {zone:1457} Darnassus · {zone:1444} Feralas
	["{zone:1448} and a stop in {area:2255}, then {zone:1457} and {zone:1444}."] = "{zone:1448}，途中在{area:2255}停留，然后是{zone:1457}和{zone:1444}。",

	-- Step 1: Felwood
	-- {area:3137} Talrendis Point · {area:2358} Forest Song · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride west along the road past {area:2358}, then north-west into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "从{area:3137}沿路向西，经过{area:2358}后转向西北进入{zone:1448}。{area:2479}是德鲁伊的营地，就在刚过{zone:1440}边界的路旁。",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["The {area:2479} is the druids' camp by the road in southern {zone:1448}."] = "{area:2479}是德鲁伊的营地，就在{zone:1448}南部的路旁。",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}，在{npc:11554}东边不远的废墟中",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}：在屋内",
	-- {npc:10920} Kelek Skykeeper · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}: {quest:86577}, from the bears and wolves you meet in {zone:1448}"] = "{npc:10920}：{quest:86577}，来自你在{zone:1448}遇到的熊和狼",

	-- Step 3: Grazle
	-- {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["{npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "熊怪{npc:11554}站在{area:2479}南边不远的路旁。",

	-- Step 4: Deadwood Village
	-- {npc:11554} Grazle · {npc:15395} Nafien
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop: {npc:11554} and {npc:15395} each take five."] = "死木熊怪住在{npc:11554}西南方不远的村子里。留好它们掉落的死木头饰羽毛，{npc:11554}和{npc:15395}各要五根。",

	-- Step 5: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395}在{zone:1448}北端等候",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras · {spell:7992} Slowing Poison
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker · Cursed Oozes = {npc:7086} Cursed Ooze
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back.\nCareful: Jadefire Shadowstalkers (level 51-52) use Sneak and {spell:7992} and are stealthed, so they often join fights uninvited.\nCursed Oozes slide about the glen's streams: kill them and use Laris's Empty Ooze Jar on their remains."] = "碧火萨特占据道路西边的山谷，{npc:9454}在山谷深处。\n小心：碧火捕猎者（51-52级）会使用潜行和{spell:7992}，且处于潜行状态，经常不请自来加入战斗。\n被诅咒的软泥怪在山谷的溪流中滑行：杀死它们，对残骸使用拉里斯给的空采样瓶。",

	-- Step 7: Ruins of Constellas
	-- {npc:9454} Xavathras · {area:2481} Ruins of Constellas
	["Careful: {npc:9454} (54) stands at the back of the {area:2481}, at about 32.2,67.1, with Shadowstalkers around him: clear them one at a time, then pull him alone at full health."] = "注意：{npc:9454}（54级）站在{area:2481}后方约32.2,67.1处，周围有暗影猎手：逐个清掉，再在满血时单独拉他。",

	-- Step 8: Jaedenar
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge · {item:11948} Empty Tainted Ooze Jar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{area:1763} is the ruined temple north of the glen.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: work the south-east, where the arrow points, and pull the cultists and hounds away from him.\nTainted Oozes slide about {area:1763}'s fel pools: kill them and use the {item:11948} on their remains."] = "{area:1763}是山谷北边的神殿废墟。\n小心，{npc:11141}（53级精英）在{area:1763}西端约35,60处游荡。去箭头指向的东南部，把教徒和猎犬拉离他再打。\n被污染的软泥怪在{area:1763}的邪能池附近游荡。杀死它们后，对残骸使用{item:11948}。",
	-- {item:11949} Filled Tainted Ooze Jar · {area:1763} Jaedenar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{item:11949}: Tainted Oozes slide about {area:1763}'s fel pools"] = "{item:11949}：被污染的软泥怪在{area:1763}的邪能池中滑行",

	-- Step 9: Putrescent organs: kill these as you meet them
	["Putrescent organs: kill these as you meet them"] = "腐烂的器官：沿途击杀以下目标",
	-- {zone:1448} Felwood · {npc:10920} Kelek Skykeeper · {area:1763} Jaedenar
	["{zone:1448}'s Angerclaw bears and Felpaw wolves carry the putrescent organs {npc:10920} wants: the Bears and Wolves (47-48) of the south and the Maulers and Scavengers (49-50) along the road north of {area:1763}. Kill them as you ride between the stops."] = "{zone:1448}的怒爪熊和魔爪狼身上有{npc:10920}需要的腐烂器官：南部的熊和狼（47-48级），以及{area:1763}以北道路沿线的重殴者和食腐者（49-50级）。在各站点之间骑行时顺手击杀。",

	-- Step 11: Shatter Scar Vale
	-- {npc:7136} Infernal Sentry
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them.\nCareful: an {npc:7136} (53, elite) stands among the craters: walk round it."] = "沿道路向北前往布满弹坑的山谷，走到每个弹坑处，杀死途中的热能野兽和热能恐兽。\n注意：弹坑之间站着一只{npc:7136}（53级精英）：绕开它。",
	["First crater"] = "第一个弹坑",
	["Second crater"] = "第二个弹坑",
	["Third crater"] = "第三个弹坑",

	-- Step 12: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "{area:2618}东边{area:1767}的扭木树人携带{item:11503}。",
	["Below ground"] = "在地下",

	-- Step 13: Jadefire Run: kill these as you meet them
	-- {area:2618} Jadefire Run
	["{area:2618}: kill these as you meet them"] = "{area:2618}：沿途击杀以下目标",
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}.\nCareful: {npc:10648} (55) stands at the valley's far end with Hellcallers (53-54) around him: clear them one at a time before you pull him."] = "{area:2618}是西北部的萨特山谷，{npc:10648}在最深处。他掉落{quest:939}；每个碧火萨特都可能掉落{item:11674}。\n注意：{npc:10648}（55级）站在山谷最深处，周围有地狱召唤者（53-54级）：先逐个清掉，再拉他。",

	-- Step 14: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "再次前往{area:1763}",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}."] = "在{area:1763}中央被腐化的月亮井使用{item:12922}。",

	-- Step 15: The Emerald Sanctuary
	-- {area:1763} Jaedenar · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Ride south-east from {area:1763} to the {area:2479}, the druids' camp by the road in southern {zone:1448}."] = "从{area:1763}向东南骑行到{area:2479}，即{zone:1448}南部路旁的德鲁伊营地。",

	-- Step 16: The Emerald Sanctuary
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}, later in this guide: keep it; inside"] = "在屋里接任务，先留着。本篇后段到{zone:1457}时再装满瓶子",
	-- {area:392} Ratchet
	["Ends in {area:392}, on the next guide: keep it"] = "任务在{area:392}交，下一篇指南会去那里，先留着",

	-- Step 17: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Ride north up the road from the Sanctuary, all the way to the cave mouth of {area:1769}; {npc:15395} guards it."] = "从圣地沿道路向北骑，一直到{area:1769}的洞口；{npc:15395}守在那里。",

	-- Step 18: Felpaw Village
	-- {area:1762} Felpaw Village
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "{area:1762}的死木熊怪遍布洞穴以西的山丘。\n小心，死木守卫是53-54级，死木复仇者是54-55级。生命值低于50%时，它们会呼叫25码内的同伴，低于15%时会逃跑求援。",

	-- Step 19: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["Only if the Timbermaw are already Neutral to you: the Deadwood furbolgs drop a {quest:8470} about one kill in thirty, and {npc:11558} just inside {area:1769} takes it. Below Neutral the quest is refused: it needs Neutral with the Timbermaw; the reputation guide gets you there."] = "木喉熊怪声望达到中立后再做。死木熊怪大约每打三十只掉一个{quest:8470}，交给{npc:11558}，她就在{area:1769}入口内侧。声望低于中立时无法接任务，可按声望指南提升。",

	-- Step 20: Nafien
	-- {npc:11556} Salfa · {zone:1452} Winterspring
	["{npc:11556} stands at the {zone:1452} end of the tunnel"] = "{npc:11556}在隧道通往{zone:1452}的那一头",

	-- Step 22: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She needs Neutral with the Timbermaw; the reputation guide gets you there."] = "进洞找{npc:11558}，她就在入口内侧。任务要求木喉熊怪声望达到中立，可按声望指南提升。",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}在附近走动：到地图标示的圆圈内寻找",

	-- Step 23: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "进入{zone:1452}",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Walk through {area:1769}'s tunnel to its {zone:1452} end."] = "穿过{area:1769}的隧道，走到通往{zone:1452}的那一头。",

	-- Step 24: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556}就站在{area:1769}隧道的{zone:1452}出口处，也就是你出来的地方。",

	-- Step 25: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride south to {npc:9298}'s camp beside the hot springs."] = "向南前往{npc:9298}在温泉旁的营地。",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["Keep it: {npc:7775} in {zone:1444}, later in this guide, brews the elixir"] = "任务先留着。{npc:7775}会调制药剂，本篇后段去{zone:1444}时再找他",

	-- Step 26: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "沿道路向东骑往{area:2255}。",
	-- {zone:1452} Winterspring
	["The Chillwind horns come on the next guide's {zone:1452} loop: keep it"] = "任务先留着。走下一篇指南的{zone:1452}路线时再收集完整的冰风奇美拉角",

	-- Step 27: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "飞往{area:702}",
	-- {npc:11138} Maethrya
	["{npc:11138}, the Alliance flight master"] = "{npc:11138}，联盟飞行管理员",

	-- Step 28: Rut'theran Village
	-- {npc:7916} Erelas Ambersky · {quest:3661} Favored of Elune? · {zone:1425} Hinterlands
	["{npc:7916}: {quest:3661}, the feathers from the {zone:1425}"] = "找{npc:7916}交{quest:3661}，羽毛来自{zone:1425}",

	-- Step 29: Rut'theran Village
	-- {npc:7916} Erelas Ambersky · {zone:1452} Winterspring
	["{npc:7916}: the wildkin feathers lie along {zone:1452}'s road, on the next guide; {npc:7916} takes them on the Plaguelands guide's way through: keep it"] = "在{npc:7916}处接任务，先留着。下一篇指南经过{zone:1452}时，沿路拾取月光羽毛。走瘟疫之地路线再经过这里时，把羽毛交给{npc:7916}",

	-- Step 30: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907}在楼上，就在{npc:7916}上方：从室内上楼，箭头无法区分楼层。",

	-- Step 33: The Temple Gardens
	-- {item:11682} Eridan's Vial
	["Fill {item:11682} at the moonwell inside the Temple of the Moon."] = "在月神殿内的月亮井装满{item:11682}。",

	-- Step 34: Astarii Starseeker
	-- {npc:4090} Astarii Starseeker · {quest:3378} Prayer to Elune · {zone:1427} Searing Gorge
	["{npc:4090}, in the Temple of the Moon: {quest:3378}, from the {zone:1427}"] = "在月神殿找{npc:4090}交{quest:3378}，任务来自{zone:1427}",

	-- Step 35: Gracina Spiritmight
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740} stands beside Tyrande in the Temple of the Moon."] = "{npc:7740}在月神殿里，站在泰兰德身旁。",
	-- {npc:7740} Gracina Spiritmight · {quest:162} Rise of the Silithid · {area:976} Gadgetzan
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}：{quest:162}，来自{area:976}",
	-- {npc:5594} Alchemist Pestlezugg · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1452} Winterspring
	["For {npc:5594} in {area:976}, on the {zone:1446} and {zone:1452} guide: keep it"] = "接下任务先留着。{npc:5594}在{area:976}，走{zone:1446}和{zone:1452}篇时再去找他",

	-- Step 36: Jenal
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047} waits in the {area:1658}, west of the druids' building."] = "{npc:9047}在{area:1658}等你，就在德鲁伊所在建筑的西边。",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave · {quest:3764} Un'Goro Soil
	["{npc:9047}, in the {area:1658}: {quest:3764}"] = "{npc:9047}在{area:1658}，找他交{quest:3764}",

	-- Step 38: Arch Druid Fandral Staghelm
	-- {npc:4217} Mathrengyl Bearwalker
	["Fandral stands at the top of the druids' building; {npc:4217}, next, is lower down inside it."] = "范达尔站在德鲁伊所在建筑的顶层。下一站找{npc:4217}，他在同一栋楼的下层。",
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, upstairs"] = "{npc:3516}，在楼上",

	-- Step 40: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}：在楼上",
	-- {npc:4217} Mathrengyl Bearwalker · {item:11040} Morrowgrain
	["{npc:4217}'s next task grows ten {item:11040} from a pouch over several hours: skip it."] = "{npc:4217}的后续任务要用袋子种出十份{item:11040}，需要几个小时，跳过即可。",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455}没有德鲁伊训练师",

	-- Step 41: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "通往{zone:1438}的传送门",

	-- Step 42: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702}的飞行管理员",

	-- Step 43: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "从{area:702}飞往{area:1116}。",

	-- Step 45: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "乘船前往{area:1108}",

	-- Step 46: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Take the boat to the mainland: {npc:14637} waits on the dock where it lands."] = "坐船去大陆，{npc:14637}就在下船的码头等你。",

	-- Step 47: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}：沿途击杀以下目标",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-47) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (47) do. The Wave and Deep Striders (47) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "巨型海元素（46-47级）在码头以南不远的岸边游荡，和海元素（47级）一样会掉落水元素核心。波涛巨人和深海巨人（47级）在同一片海滩外的浅水里走动。先用{item:18904}电它们，缩小后就没有精英怪的强度了。\n超级压缩器只保留两小时，离开海岸前把两个任务都交给{npc:14637}。",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958}，从巨型海元素身上获取",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}，对水中的海浪巨人和深海巨人使用",

	-- Step 48: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637} on the dock."] = "回到码头上的{npc:14637}处。",

	-- Step 49: Gregan Brewspewer
	-- {area:1119} Twin Colossals · {npc:7775} Gregan Brewspewer · {item:11243} Videre Elixir · {item:11242} Evoroot
	["Ride north-east from the dock past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "从码头向东北出发，经过{area:1119}到{npc:7775}的营地。要调制{item:11243}，他需要一株{item:11242}。接下差事去找一株。",

	-- Step 50: Rockbiter
	-- {npc:7765} Rockbiter · {npc:7775} Gregan Brewspewer
	["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "巨人{npc:7765}就在{npc:7775}营地的西北侧。",

	-- Step 51: Evoroot
	-- {item:11242} Evoroot · {npc:7765} Rockbiter · {npc:9467} Miblon Snarltooth
	["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it.\nOr the front door: {npc:9467} guards it, and the Bait Gregan sells draws him off when you use it beside him. Half the players in our recordings went in that way, half through the wall."] = "{item:11242}长在{npc:7765}北边的建筑废墟里。从旁边的平台爬过墙上的缺口进去。\n也可以走正门。{npc:9467}守在门口，在他身边使用格雷甘卖的诱饵就能把他引开。实录里一半玩家走正门，另一半从墙洞进去。",

	-- Step 52: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {item:9189} Shay's Bell
	["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "向西骑行进入鸦风废墟：{npc:7774}躲在后方的小圆形建筑里。打开她身旁的箱子获得{item:9189}：它和任务一样持续15分钟。",

	-- Step 53: Wandering Shay
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "步行带{npc:7774}返回{npc:7765}身边。她会走开，需在非战斗状态下摇铃叫她回来；提前清除沿途鹰身人，别让她靠近它们。",

	-- Step 54: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {npc:7765} Rockbiter · {item:11242} Evoroot · {npc:9298} Donova Snowden · {area:976} Gadgetzan
	-- plural, as words: Videre Elixirs = {item:11243} Videre Elixir
	["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one at the start of the next guide, and Gaeriyan in {area:976} shows himself only to someone who has drunk one."] = "回到{npc:7775}的营地，就在{npc:7765}东南方不远处。拿{item:11242}换三瓶视灵药剂，先留着。下一篇指南开头要交一瓶给{npc:9298}，加里杨在{area:976}，只会在喝过一瓶的人面前现身。",

	-- Step 55: Feralas
	-- {area:489} Thalanaar · {zone:1441} Thousand Needles
	["Ride east along the road to {area:489}, on the {zone:1441} border: the next guide flies from there."] = "沿路往东前往{area:489}，就在{zone:1441}边界。下一篇指南从那里起飞。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ends in the {zone:1413}: keep it"] = "在{zone:1413}结束：留着",
	-- ["Five feathers buy a little Timbermaw reputation"] = "五根羽毛换少量木喉熊怪声望",
	-- ["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "从{area:1998}飞往道路上避难所那一端，或沿路向南骑行。",
	-- ["Fly to {area:415}"] = "飞往{area:415}",
	-- ["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "沿道路向北前往布满弹坑的山谷，走到每个弹坑处，杀死途中的热能野兽和热能恐兽。",
	-- ["If you skipped The Horn of the Beast or The {item:9328}, grind here to level 52.58 to stay on the route's plan."] = "如果跳过了玛尔戈的巨角或{item:9328}，就在这里刷到52.58级，以跟上路线进度。",
	-- ["Keep her alive until she is out of the cave"] = "保护她直到离开洞穴",
	-- ["Level 52.58"] = "等级 52.58",
	-- ["Level 52.69"] = "等级 52.69",
	-- ["Level 52.9"] = "等级 52.9",
	-- ["Oozes"] = "软泥怪",
	-- ["Ride east to the night elf camp at {area:1998}."] = "向东骑行到{area:1998}的暗夜精灵营地。",
	-- ["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "从{area:415}骑马向北进入{zone:1448}，前往路旁的德鲁伊营地{area:2479}。",
	-- ["Ride north out of {area:415} into {zone:1448}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "从{area:415}向北骑行进入{zone:1448}。熊怪{npc:11554}站在{area:2479}南边不远的路旁。",
	-- ["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "向北骑到{area:1769}（或先飞回{area:1998}），穿过隧道进入{zone:1452}；沿道路向东前往地精城镇{area:2255}。",
	-- ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "萨尔法站在隧道的{zone:1452}一端：留着",
	-- ["Step into the cave: {npc:11558} and {npc:11557} stand just inside."] = "走进洞穴：{npc:11558}和{npc:11557}就站在入口内。",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "走进洞穴：{npc:11558}就在入口内侧。",
	-- ["Still short of level 52.9 after the {area:2479}'s hand-ins? Top up on the Entropic Beasts in {area:1766}, the next stop north."] = "在{area:2479}交完任务后仍不到52.9级？在下一站、北边的{area:1766}击杀熵能野兽补足经验。",
	-- ["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "从{area:702}乘船前往{area:442}，飞往{area:415}。",
	-- ["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "被诅咒的软泥怪和被污染的软泥怪在{area:1763}和{area:1765}周围的溪流和邪能池中滑行：杀死它们，对残骸使用拉里斯给的空采样瓶。",
	-- ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "死木熊怪住在{npc:11554}西南方不远的村子里；保留它们掉落的死木头饰羽毛。",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "{area:1762}的死木熊怪遍布洞穴西侧的山丘。持续击杀，直到掉落{quest:8470}，平均每击杀三十只掉落一个，然后右键点击。木喉熊怪声望达到中立后，即可交给{area:1769}的{npc:11558}；若已中立，现在就能交还，否则等最后一篇指南在58级再次经过洞穴时交还。\n注意：死木守卫为53-54级，复仇者为54-55级；生命值低于50%时会呼叫25码内的盟友，低于15%时会逃跑求援。",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "{area:1762}的死木熊怪遍布洞穴西侧的山丘。持续击杀，直到掉落{quest:8470}，平均每击杀三十只掉落一个，然后右键点击。木喉熊怪声望达到中立后，即可交给{area:1769}的{npc:11558}；若已中立，现在就能交还，否则等最后一篇指南在58级再次经过洞穴时交还。\n注意：死木守卫为53-54级，生命值低于50%时会呼叫25码内的盟友，低于15%时会逃跑求援。",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "{area:1762}的死木熊怪遍布洞穴西边的山丘。死木复仇者可能掉落{quest:8470}。",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "死木熊怪占据{area:1762}洞穴以西的山丘，复仇者有几率掉落{quest:8470}。\n注意：巢穴看守者为 53–54 级，生命值低于 50% 时会呼叫 25 码内的盟友，低于 15% 时逃跑求援。",
	-- ["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "碧火萨特占据道路西边的山谷，{npc:9454}在山谷深处。",
	-- ["The vial is filled in {zone:1457}: keep it"] = "药瓶在{zone:1457}装满：留着",
	-- ["The vial is filled in {zone:1457}: keep it; inside"] = "药瓶需在{zone:1457}装满，先保留；任务在屋内接取",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "{item:11242}长在{npc:7765}北边的一座废墟建筑里：从旁边的岩架穿过墙上的缺口爬进去。",
	-- ["Top up here to level 52.69 before the hand-ins at {area:1763}: they take you to level 53."] = "在这里补到52.69级，再去{area:1763}交任务，交完会升到53级。",
	-- ["Top up here to level 52.9 before the hand-ins at {area:2479}: they take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "在这里补到52.9级，再去{area:2479}交任务，交完会升到53级。也可以组队去{area:1417}副本或{area:2100}副本。",
	-- ["Trey Lightforge's remains lie beside her."] = "特雷·莱弗治的残骸的遗骸就在她身旁。",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}."] = "在{area:1763}中央被腐化的月亮井使用{item:12922}。如果救出了{npc:11018}，返回{area:1770}寻找魅魔{npc:9518}。",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "在{area:1763}中央被污染的月亮井使用{item:12922}。如果你救出了{npc:11018}，回到{area:1770}找魅魔{npc:9518}；特雷·莱弗治的残骸就在她旁边。",
	-- ["grind on {npc:7109}"] = "反复击杀{npc:7109}补足经验",
	-- ["grind on {npc:7153}"] = "反复击杀{npc:7153}补足经验",
	-- ["grind on {npc:7155}"] = "反复击杀{npc:7155}补足经验",
	-- ["grind on {npc:9878}"] = "反复击杀{npc:9878}补足经验",
	-- ["{area:1763} is the ruined temple north of the glen."] = "{area:1763}是谷地北面的神殿废墟。",
	-- ["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763}是山谷北边的废弃神殿。其中一些信徒会掉落{item:13140}，约三十次击杀一次：它能打开后方洞穴{area:1770}中{npc:11018}的牢房。掉落了就先清出退路再放她出来；没掉就跳过她的任务。",
	-- ["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618}是西北部的萨特山谷，{npc:10648}在最深处。他掉落{quest:939}；每个碧火萨特都可能掉落{item:11674}。",
	-- ["{item:13140}, a rare drop"] = "{item:13140}，稀有掉落",
	-- ["{npc:10924}: for {npc:11079} in {zone:1452}, keep it"] = "{npc:10924}：交给{zone:1452}的{npc:11079}，先留着",
	-- ["{npc:11016}, in {area:1770}"] = "{npc:11016}，在{area:1770}",
	-- ["{npc:11016}, in {area:1770}; below ground"] = "{npc:11016}，位于{area:1770}地下",
	-- ["{npc:11020}, below ground"] = "{npc:11020}：在地下",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}：三十个{quest:6031}，57级再次经过时交还",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57; below ground"] = "{npc:11557}位于地下：收集三十个{quest:6031}，等 57 级再次经过时交付",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558}：木喉熊怪只有在中立时才会和你说话",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}：木喉熊怪只会在声望达到中立后与你交谈；他在附近巡逻，请在地图标示的圆圈内寻找",
	-- ["{npc:15395} waits at the north end of {area:361}"] = "{npc:15395}在{area:361}北端等候",
	-- ["{npc:9518}, below ground"] = "{npc:9518}：在地下",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}，稀有掉落",
}
