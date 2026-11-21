-- Chinese (simplified) (zhCN): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "飞往{area:2255}",
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "{area:489}的飞行管理员",

	-- Step 2: Everlook
	-- {area:2255} Everlook · {npc:11754} Meggi Peppinrocker
	["The flight lands in {area:2255}: {npc:11754} and Umi stand around the town before you ride west."] = "",
	-- {npc:11754} Meggi Peppinrocker · {npc:9298} Donova Snowden · {area:2255} Everlook
	-- was: ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754}在{area:2255}巡逻，请在地图标示的圆圈内寻找"
	["{npc:11754}, for {npc:9298}: walks around {area:2255}, look inside the circle on the map"] = "",
	-- {npc:10305} Umi Rumplesnicker
	-- plural, as words: Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle
	["{npc:10305}: the Rogue Ice Thistles on the road west carry the furs"] = "",

	-- Step 3: The road west: feathers, furs and horns
	["The road west: feathers, furs and horns"] = "",
	-- {npc:9298} Donova Snowden · {item:12366} Thick Yeti Fur · {item:12444} Uncracked Chillwind Horn · {npc:10468} Felnok Steelspring
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather · Ragged Owlbeasts = {npc:7450} Ragged Owlbeast · Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["Moontouched Feathers lie on the ground all along the road west to {npc:9298}, where the Ragged Owlbeasts (53) roam: pick them up as you ride.\nThe same road crosses the Rogue Ice Thistles' ground (about one in three drops a {item:12366} for Umi) and the Fledgling Chillwinds' (about one in five drops an {item:12444} for {npc:10468}): work both here, around the road's middle.\nCareful: both are 53-55: pull the lower ones and take them one at a time."] = "",
	-- {item:12366} Thick Yeti Fur
	-- plural, as words: Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle
	["{item:12366}, from the Rogue Ice Thistles"] = "",
	-- {item:12444} Uncracked Chillwind Horn
	-- plural, as words: Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["{item:12444}, from the Fledgling Chillwinds"] = "",

	-- Step 4: Donova Snowden
	-- {npc:9298} Donova Snowden
	["{npc:9298} camps beside the hot springs at the western end of the road."] = "",
	-- {item:11243} Videre Elixir
	["With the {item:11243} from Gregan"] = "",
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299}, at the graveyard just east of {area:976}, later in this guide"] = "",

	-- Step 5: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}：沿途击杀以下目标",
	-- {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {item:14047} Runecloth · {npc:11557} Meilosh
	-- plural, as words: Winterfall Ritual Totems = {quest:8471} Winterfall Ritual Totem
	["The western Winterfall camp sits in the hills between {npc:9298} and the tunnel. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need): right-click it. They also drop Winterfall Ritual Totems (about one in thirty) and {item:14047}, which only matter if you are Neutral (the totem) or Friendly ({npc:11557}'s {item:14047}) with the Timbermaw: keep them then.\nCareful: the Pathfinders are 53 and the Totemics 54, but the Den Watchers inside the camp are 55: take the camp from its edge and pull one at a time."] = "",
	-- {item:14047} Runecloth · {npc:11557} Meilosh
	["{item:14047}, for {npc:11557}, if you are Friendly with the Timbermaw"] = "",

	-- Step 6: Winterfall Ritual Totem
	-- {npc:11558} Kernda
	["{npc:11558} takes the totem; the quest needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["For {npc:11558} in {area:1769}, later in this guide: keep it"] = "",

	-- Step 7: Donova Snowden
	-- {area:1762} Felpaw Village · {zone:1448} Felwood
	["The Deadwood cauldron in {area:1762}, at the {zone:1448} end of the tunnel"] = "",

	-- Step 8: Felwood
	-- {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden · {zone:1448} Felwood
	["Through {area:1769}'s tunnel, just north of {npc:9298}, to {zone:1448}."] = "",
	-- {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["{area:1769}, {zone:1448} side"] = "",

	-- Step 9: Deadwood Cauldron
	-- {area:1762} Felpaw Village
	["The Deadwood cauldron stands at the top of {area:1762}, just west of the cave mouth."] = "",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298}, on this guide's {zone:1452} loop: keep it"] = "",

	-- Step 10: Talonbranch Glade
	-- {area:1998} Talonbranch Glade
	["Ride south from the cave to {area:1998}, the night elves' camp on the road."] = "",

	-- Step 11: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飞往{area:392}",

	-- Step 12: Fly to Theramore
	["Fly to Theramore"] = "飞往塞拉摩岛",

	-- Step 13: The Barrens
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "从塞拉摩出发，向西骑入{zone:1413}，再沿海岸向北到{area:392}。",

	-- Step 14: Ratchet
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: the ash is in Un'Goro; inside"] = "",

	-- Step 15: The Stone Circle
	-- {quest:3444} The Stone Circle
	["{quest:3444} stands on the hill just south-west of the flight master."] = "",

	-- Step 16: Islen Waterseer
	-- {npc:5901} Islen Waterseer
	["{npc:5901} stands on the coast south-east of town."] = "",
	-- {zone:1448} Felwood
	["For Greta in {zone:1448}, later in this guide: keep it"] = "",

	-- Step 17: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飞往{area:976}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}的飞行管理员",

	-- Step 18: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}：在屋内",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro"] = "",

	-- Step 19: Gaeriyan
	-- {npc:9299} Gaeriyan · {item:11243} Videre Elixir
	["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299}是镇子东边不远处墓地里的鬼魂：在那里喝下一瓶{item:11243}，它会杀死你，释放灵魂后以鬼魂形态和他交谈。然后跑回尸体处复活：墓碑就在附近。",
	-- {npc:8737} Linken · {area:541} Marshal's Refuge
	["{npc:8737} in {area:541}, Un'Goro: keep it"] = "",

	-- Step 20: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "向西南骑行到{area:1938}的{npc:7771}营地。",
	-- {npc:7771} Marvon Rivetseeker · {area:1417} Sunken Temple
	["{npc:7771}'s next task, Into the Depths, is inside the {area:1417}: skip it."] = "",

	-- Step 22: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "飞往{area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 23: Marshal's Refuge
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:9999} Ringo · {npc:8737} Linken · {npc:9117} J.D. Collie · {npc:9618} Karna Remtravel
	["Fly from {area:976} to {area:541}. {npc:9997}'s friend {npc:9999} has gone missing; {npc:8737} stands at the back of the refuge, with {npc:9117} in the cave behind him; {npc:9618} stands just outside, on the way out east."] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "{npc:9997}旁边的木牌",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}：在地下",
	-- {npc:9116} Eridan Bluewind · {zone:1448} Felwood
	["For {npc:9116} in {zone:1448}, later in this guide: keep it"] = "",

	-- Step 24: Northern Pylon
	["Northern Pylon"] = "北部水晶塔",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:6584} King Mosh
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}.\nCareful: {npc:6584} (60), a rare devilsaur, roams the crater's west around 27,46: if you meet him, ride away."] = "",

	-- Step 25: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "向东骑行到{area:1943}，机器人站在猩猩中间。别进那里的深洞。",
	["Below ground"] = "在地下",

	-- Step 26: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau
	["{area:1943}: kill these as you meet them"] = "{area:1943}：沿途击杀以下目标",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "猩猩生活在水晶塔东边不远处的{area:1943}：趁着人在上面，现在就收集交给{npc:9619}的毛皮。不要进入最深处的洞穴，里面的{npc:9622}为 55 级。\n注意：50–51 级的安戈洛猩猩生命值降到 25% 时，会召集 20 码内盟友支援。这里有一座满是猩猩的洞穴，在洞内战斗会引来许多额外敌人。",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "{item:11478}：在地下",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "{item:11479}：在地下",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "{item:11480}：在地下",

	-- Step 28: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}：沿途击杀以下目标",
	-- {area:538} Lakkari Tar Pits
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Tar Lords = {npc:6519} Tar Lord
	["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "焦油兽和焦油领主在{area:538}打滚，位于避难所南边、下到环形山的路上。",

	-- Step 29: The crater
	["The crater"] = "环形山",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "焦油兽在{area:538}打滚，中央{area:537}的火元素携带灰烬，南侧{area:540}的格里什毒蜂携带腺体。环形山内所有生物都有几率掉落{item:11018}。\n注意：格里什工蝎生命值低于 45% 时，有 50% 几率呼叫 25 码内盟友支援。",

	-- Step 30: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "{npc:9619}的营地在进入环形山的斜坡底部。",
	-- {quest:4291} The Scent of Lar'korwi
	["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}，如果第一次来时接的还在身上",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "毛皮由{area:1943}上的猩猩掉落",
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}，如果第一次来之后有迅猛龙掉落了鳞片",

	-- Step 31: Damaged Blue Crystal
	-- {item:280417} Damaged Blue Crystal · {npc:9619} Torwa Pathfinder
	["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "{item:280417}在{npc:9619}营地西边不远处。",

	-- Step 34: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "猩猩生活在{area:541}以东的{area:1943}，保留毛皮交给{npc:9619}。不要进入最深处的洞穴，里面的{npc:9622}为 55 级。\n注意：50–51 级的安戈洛猩猩生命值降到 25% 时，会召集 20 码内盟友支援。这里有一座满是猩猩的洞穴，在洞内战斗会引来许多额外敌人。",

	-- Step 36: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "沿东侧向北骑行到猩猩高地。55级的猩猩{npc:9622}坐在最深的洞里：先清理洞口的猩猩。",

	-- Step 37: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there.\nCareful: {npc:9684} is level 56, a level or two over you here: start at full health, and clear the raptors around the lair first."] = "",

	-- Step 38: Eastern Pylon and the crate
	["Eastern Pylon and the crate"] = "东部水晶塔和箱子",
	-- {npc:9684} Lar'korwi · {item:11113} Crate of Foodstuffs
	["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "水晶塔位于{npc:9684}巢穴上方的东部悬崖上；考察队的{item:11113}在东部丛林的废弃营地里。",

	-- Step 39: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "穿过环形山南部，到坡道旁找{npc:9619}。",

	-- Step 40: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "{area:1942}：沿途击杀以下目标",

	-- Step 41: The Gorishi hive
	["The Gorishi hive"] = "格里什虫巢",
	["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "沿环形山南部向西：这里全是格雷什虫巢。对孵化室（挂着幼虫的房间）使用刮擦瓶。",

	-- Step 42: Bones and equipment
	["Bones and equipment"] = "骨头和设备",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle.\nCareful: Gruff (57), a rare devilsaur, prowls the south around 38,75: if you meet him, ride away."] = "",

	-- Step 43: Western Pylon
	["Western Pylon"] = "西部水晶塔",
	["The pylon stands on the western cliffs."] = "水晶塔位于西部悬崖上。",

	-- Step 44: Krakle
	-- {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["North-east from the pylon to {area:543}: {npc:10302} the goblin sits by the water."] = "",

	-- Step 45: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "向东骑行到{area:537}，爬上去，在山顶附近的熔岩喷口使用{npc:10541}。",

	-- Step 46: Krakle
	-- {npc:10302} Krakle
	["Back west to {npc:10302} at the hot springs."] = "",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}, later in this guide: keep it"] = "",

	-- Step 47: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}坐在环形山中央{area:537}的东南坡上。",

	-- Step 48: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "护送{npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 50: Fly to Gadgetzan
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "",

	-- Step 51: Gadgetzan
	-- {npc:10041} Gorishi Hive Queen · {area:540} Slithering Scar
	["Pestlezugg's next task, Pawn Captures Queen, sends you back to the {npc:10041} in the {area:540}: skip it."] = "",

	-- Step 53: Liv Rizzlefix
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}：在屋内",

	-- Step 54: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "飞往{area:415}",

	-- Step 55: Felwood
	-- {area:415} Astranaar · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "从{area:415}骑马向北进入{zone:1448}，前往路旁的德鲁伊营地{area:2479}。",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 56: The Emerald Sanctuary
	-- {npc:10924} Ivy Leafrunner · {npc:11079} Wynd Nightchaser · {area:2253} Starfall Village
	["{npc:10924}: for {npc:11079} in {area:2253}, later in this guide; keep it"] = "",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}：在屋内",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "稍等{npc:9116}片刻",
	-- {npc:9116} Eridan Bluewind · {npc:222647} Ancient Spirit · {npc:3848} Kayneth Stillwind · {area:2358} Forest Song · {zone:1448} Felwood
	["{npc:9116}'s next task, {npc:222647}, ends with {npc:3848} at {area:2358}, south of the route once {zone:1448} is done: skip it."] = "",
	-- {npc:9116} Eridan Bluewind
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["{npc:9116}'s next task, Silver Heart, sends you to the Irontree Stompers in the north and back here: skip it."] = "",

	-- Step 57: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "{area:1770}的火盆",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Darkweavers = {npc:7118} Jaedenar Darkweaver
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns: pull at the edge of each group and fight one pack at a time.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "{object:176159}：在地下",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "{object:176160}：在地下",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "{object:176158}：在地下",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "{object:176161}：在地下",
	-- {item:11515} Corrupted Soul Shard · {npc:9528} Arathandris Silversky
	["{item:11515}, from the same cultists: {npc:9528} takes six by the Sanctuary if you did Cleansing Felwood"] = "",
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, in her cell; below ground"] = "{npc:11016}，在地下的牢房内",

	-- Step 58: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "带她离开{area:1770}，在出洞前确保她存活：先清理回程路上的怪物。",

	-- Step 60: Greta Mosshoof: A Final Blow
	-- {quest:5242} A Final Blow · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold
	["{quest:5242} is a group quest at this level: {npc:9861} (52), {npc:9860} (54) and {npc:9517} (57) fight together at the back of {area:1770}. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "",

	-- Step 61: Rakaiah
	-- {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["Back into {area:1770}: the succubus {npc:9518} (56) waits on the way to its deepest chamber, with Trey Lightforge's remains beside her.\nCareful: {npc:9518} is level 56: clear the cultists around her first and fight her at full health."] = "",
	-- {npc:9518} Rakaiah
	["{npc:9518}, below ground"] = "{npc:9518}：在地下",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "{npc:11020}：在地下",

	-- Step 62: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["{npc:9861} and {npc:9860} guard {npc:9517} in {area:1770}'s deepest chamber, just past {npc:9518}.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "{npc:9861}：在地下",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "{npc:9860}：在地下",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "{npc:9517}：在地下",

	-- Step 63: The Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "向东南骑回翡翠圣地。",

	-- Step 64: Arathandris Silversky
	-- {npc:9528} Arathandris Silversky · {area:1770} Shadow Hold
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["{npc:9528} is in the ruins just down the road from the Sanctuary: he takes the six Corrupted Soul Shards (from both trips into {area:1770}) on the spot."] = "",

	-- Step 66: Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Ride north up the road to the cave mouth of {area:1769}."] = "",

	-- Step 67: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["{npc:11558} stands just inside the {area:1769} cave: she needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}在附近走动：到地图标示的圆圈内寻找",

	-- Step 69: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "{npc:11557}，在地下",

	-- Step 70: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "进入{zone:1452}",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Through {area:1769}'s tunnel to its {zone:1452} end."] = "",

	-- Step 71: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride on to {npc:9298}'s camp beside the hot springs."] = "",
	-- {quest:980} The New Springs · {area:2256} Darkwhisper Gorge
	["{quest:980}' follow-up, Strange Sources, is at {area:2256}'s mouth among elite giants and Hederine: skip it."] = "",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["The {quest:5086} are just back through the tunnel, in {zone:1448}"] = "",

	-- Step 72: Felwood
	-- {zone:1448} Felwood · {area:1998} Talonbranch Glade · {quest:5086} Toxic Horrors · {area:1767} Irontree Woods
	["Back through the tunnel to {zone:1448} and south past {area:1998}: the {quest:5086} (53) roam the north-eastern tip of {area:1767}."] = "",
	-- {quest:5086} Toxic Horrors
	["The {quest:5086}"] = "{quest:5086}",

	-- Step 73: Toxic Horrors
	-- {quest:5086} Toxic Horrors
	-- plural, as words: Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "小心：59级精英古老铁木行者站在{quest:5086}的目标之间：在营地东北角（约50.6,22.4）一次一只地打恐魔，每次拉怪前都先看看有没有行者。",

	-- Step 74: Winterspring
	-- {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["Back north through {area:1769}'s tunnel to {npc:9298}."] = "",

	-- Step 76: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "{zone:1452}：沿途击杀以下目标",
	-- {quest:5087} Winterfall Runners · {area:2246} Frostfire Hot Springs · {zone:1448} Felwood · {spell:5384} Feign Death
	["The {quest:5087} (57) carry their crates along the road between {area:2246} and {zone:1448}'s tunnel.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest.\nCareful: the {quest:5087} are 57, over you here: pull one at a time, away from the camp."] = "",

	-- Step 78: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "沿道路向东骑往{area:2255}。",
	-- {npc:11755} Harlo Wigglesworth · {npc:10301} Jaron Stoneshaper · {area:2253} Starfall Village
	["{npc:11755}: for {npc:10301} in {area:2253}, just back up the road"] = "",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep it for the Plaguelands, on the next guide; inside"] = "",

	-- Step 79: Starfall Village
	-- {area:2253} Starfall Village · {npc:11079} Wynd Nightchaser · {npc:10301} Jaron Stoneshaper
	["Ride back north-west to {area:2253} on its hill: {npc:11079} and {npc:10301} stand together."] = "",
	-- {quest:5250} Starfall
	["The relics are in the ruins just south of {quest:5250}"] = "",

	-- Step 80: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village · {npc:10304} Aurora Skycaller · {zone:1423} Eastern Plaguelands
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins: {npc:10304} in the {zone:1423} takes them, on the next guide."] = "",

	-- Step 81: The road to Everlook: furs and horns
	-- {area:2255} Everlook
	["The road to {area:2255}: furs and horns"] = "",
	-- {area:2255} Everlook · {npc:9298} Donova Snowden
	-- plural, as words: Thick Yeti Furs = {item:12366} Thick Yeti Fur · Uncracked Chillwind Horns = {item:12444} Uncracked Chillwind Horn · Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind · Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti · Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Still short of Thick Yeti Furs or Uncracked Chillwind Horns? The Rogue Ice Thistles and the Fledgling Chillwinds (both 53-55) live along the road west of {area:2255}, toward {npc:9298}. The hills east of {area:2255} hold only the Ice Thistle Yetis (55-56), Matriarchs and Patriarchs, and the Chillwind Chimaeras (55-57) and Ravagers (57-59): don't hunt the furs and horns there."] = "",

	-- Step 83: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "完美的雪人角",
	["Check the two outdoor Matriarchs (56) on the western slope of the yetis' hills. Leave the Patriarchs (57) and the cave alone. If you don't get both horns on this pass, skip the hunt and Umi's hand-in."] = "",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Loot the horns from Ice Thistle Matriarchs"] = "",

	-- Step 84: Everlook
	-- {area:2255} Everlook · {area:976} Gadgetzan
	["Umi's next task scares three goblins in {area:2255}, {area:976} and Un'Goro, behind the route now: skip it."] = "",

	-- Step 85: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "{npc:10301}的营地",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	-- was: ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "向东南沿山谷而下，到{area:2245}雪地里{npc:10301}的破损箱子处，他被毁的马车就在东边。"
	["Ride south-east from {area:2255} down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "",

	-- Step 86: Sindrayl
	-- {zone:1452} Winterspring · {area:1769} Timbermaw Hold · {area:493} Moonglade · {npc:10897} Sindrayl · {area:2361} Nighthaven
	["Ride back north up the valley and west along the road to the tunnel at {zone:1452}'s western end, where Salfa stands. Walk into {area:1769} and take the {area:493} branch of the tunnel down to {area:493}. {npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn. The next guide flies on from here."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can drop the totem, about one kill in thirty: if the top-up did not bring one, keep killing them here until it drops, then right-click it."] = "任何冬泉熊怪都有几率掉落图腾，平均每击杀三十只掉落一个。若补经验时没有获得，就在这里继续击杀，直到掉落，再右键点击。",
	-- ["Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh."] = "这里的熊怪都可能掉落{item:12771}（约每十只掉一个，完成这些任务所需的击杀过程中就能拿到）和{quest:8471}（约每三十只掉一个）：掉了哪个就右键点击哪个。熊怪掉落的{item:14047}留给梅罗什。",
	-- ["Back to the hills: only the Ice Thistle Matriarchs (56-57) and Patriarchs (57-58) carry the horns.\nCareful: take the Matriarchs at the edge of the hills, one at a time, and leave the Patriarchs: their horns drop from both."] = "回到丘陵：只有冰蓟雪人女王（56-57级）和冰蓟雪人族长（57-58级）身上有角。\n注意：在丘陵边缘逐个击杀冰蓟雪人女王，别碰族长：两者都会掉落角。",
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "返回山丘：只有冰蓟雪人女王和冰蓟雪人王携带角。",
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "回到山丘：只有冰蓟雪人女王和冰蓟雪人族长携带角。一直杀雪人到54级：在此之前哈尔罗·巴纳比的枭兽任务是红色的。",
	-- ["Back to {npc:11053} at {area:3197}."] = "回到{area:3197}找{npc:11053}。",
	-- ["Boat to {area:150}"] = "乘船前往{area:150}",
	-- ["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "注意：{npc:10411}在非战斗状态下会隐形，开战后会召唤石翼石像鬼。总共只有三个刷新点，刷新间隔为 15 分钟。",
	-- ["Fly to {area:271}"] = "飞往{area:271}",
	-- ["Fly to {area:3197}"] = "飞往{area:3197}",
	-- ["Follow the road east across the zone to the chapel."] = "沿道路向东穿过该地区前往圣光之愿礼拜堂。",
	-- ["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "沿道路向西前往温泉旁{npc:9298}的营地。",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "沿南边的道路向东进入{area:139}；{area:2262}的废墟在道路以南。{npc:10926}的鬼魂在南端的废屋旁玩耍。",
	-- ["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "沿南边的道路向东进入{zone:1423}；{area:2262}的废墟在道路以南。{npc:10926}的鬼魂在南端的废屋旁玩耍。",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "按{npc:9298}的指引前往{area:2256}入口，途经霜槌巨人：一次只引一个过去。",
	-- ["For Kernda in {area:1769}: keep it"] = "交给{area:1769}的克尔达：保留它",
	-- ["Free Darrowshire Spirits: talk to them"] = "解放{npc:11064}：与它们交谈",
	-- ["From {area:271}, ride north up the road through Alterac to {area:3197}."] = "从{area:271}出发，沿道路向北穿过奥特兰克前往{area:3197}。",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "冰蓟雪人住在{area:2244}以南的山丘，冰风奇美拉在通往{area:2255}的山谷中。",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}.\nCareful: the Ice Thistle Yetis are 55-56 and the Chimaeras 55-57: take the Rogue Ice Thistles (53-55) and the Fledgling Chillwinds (53-55) at the edge of the hills, and leave the Chillwind Ravagers (57-59) alone."] = "冰蓟雪人住在{area:2244}以南的丘陵，冰风奇美拉在通往{area:2255}的山谷中。\n注意：冰蓟雪人为55-56级，冰风奇美拉为55-57级：在丘陵边缘击杀游荡的冰蓟雪人（53-55级）和冰风奇美拉幼兽（53-55级），别碰冰风破坏者（57-59级）。",
	-- ["Inside"] = "在里面",
	-- ["Into {zone:1423}"] = "进入{zone:1423}",
	-- ["Its jars are filled on the {zone:1451} guide's Un'Goro visit: keep it"] = "罐子会在{zone:1451}指南前往安戈洛时装满：保留它",
	-- ["Keep it: Gregan in {zone:1444} brews the elixir later"] = "保留它：之后{zone:1444}的格雷甘·山酒会调制药剂",
	-- ["Level 55 at {area:2246}"] = "在{area:2246}升到55级",
	-- ["Level 55.05"] = "等级 55.05",
	-- ["North-west out of the camp to {area:199}, west of Andorhal: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54)."] = "从营地向西北前往安多哈尔以西的{area:199}：{npc:11075}（53级）在喋喋不休的食尸鬼（54级）之间守着大锅。",
	-- ["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the same ghost in {area:2262}."] = "沿道路向东离开{area:3197}，{npc:10927}的农舍位于{area:197}：她的{quest:5142}也是交给{area:2262}的那个鬼魂。",
	-- ["On {npc:10978}, by the inn"] = "在旅店旁的{npc:10978}处",
	-- ["Optional: {area:1417}"] = "可选：{area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "拾取马车周围的补给，并从附近的枭兽身上夺回{npc:10301}的护符。",
	-- ["Pristine Yeti Horns"] = "完美的雪人角",
	-- ["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "纯心、杜玛、瓦罗菲斯特和麦克唐奈站在营地中央附近，飞行管理员旁边。",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "向北骑到{area:2627}。{npc:12384}住在破屋里，他的收据簿在附近的废弃旅店里。",
	-- ["Ride north up the valley, past {area:2255}, to {area:2253}."] = "沿山谷向北骑行，经过 {area:2255}，到达 {area:2253}。",
	-- ["Ride north-west back to the village."] = "向西北骑回村子。",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "向东南沿山谷而下，到{area:2245}雪地里{npc:10301}的破损箱子处，他被毁的马车就在东边。",
	-- ["Ride west along the road to the night elf village."] = "沿道路向西骑到暗夜精灵的村子（坠星村）。",
	-- ["Ride west along the road to {npc:10301}."] = "沿道路向西骑到{npc:10301}处。",
	-- ["Scare {npc:10978} with {item:12928}"] = "用{item:12928}吓唬{npc:10978}",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "打完雪人还不到54级？组队刷{area:1417}（50-54）比练级更快。之后回到{area:2255}。",
	-- ["The Deadwood cauldron in {zone:1448}: keep it"] = "{zone:1448}的死木熊怪大锅：保留它",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "{area:2264}周围、礼拜堂西边的天灾军团会掉落两种天灾石；{npc:11064}会从它们身上升起：和每一个交谈以解放它。",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "礼拜堂西侧、{area:2264}周围的天灾怪物会掉落两种天灾石，击杀后会出现达隆郡居民的灵魂：逐一交谈，解放它们。\n注意：{npc:10411}在非战斗状态下会隐身，进入战斗后会召唤石翼石像鬼。这种眼球只有3只，每15分钟刷新一次。",
	-- ["The Winterfall camp"] = "冬泉熊怪营地",
	-- ["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "冬泉熊怪的村子位于{area:2255}以东：冬泉萨满祭司（56-57）、冬泉巢穴守卫（55-56）和冬泉巨熊怪（57-58），都比你等级高。先杀萨满祭司，它们会治疗，从边缘开始引怪。后方洞穴里的{npc:10738}是精英：别进去。",
	-- ["The next guide starts here and flies to {area:3197}."] = "下一份指南从这里开始，飞往{area:3197}。",
	-- ["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "废墟位于{area:2253}以南的冰湖周围。拾取废墟中的四块遗物碎片，以及枭兽游荡处地上的月光羽毛。",
	-- ["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "娃娃的三个部件在{area:2262}的废屋里；拾取时可能引出鬼魂。把它们合成娃娃。",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "西边的冬泉熊怪营地位于{npc:11556}和{npc:9298}之间的山丘。这里任何熊怪都可能掉落{item:12771}（约十分之一），少数会掉落{quest:8471}：掉落哪个就右键点击哪个。保留熊怪掉落的{quest:6031}，交给梅罗什。",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty: it comes within the top-ups): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh.\nThe rest of {zone:1452}'s work is level 55-58: stay on this camp until level 54, so your first kills also count for {npc:9298} and {npc:11556}."] = "西侧的冬泉熊怪营地位于{npc:11556}与{npc:9298}之间的丘陵。这里的熊怪都可能掉落{item:12771}（约每十只掉一个，完成这些任务所需的击杀过程中就能拿到）和{quest:8471}（约每三十只掉一个，补经验时就能拿到）：掉了哪个就右键点击哪个。熊怪掉落的{item:14047}留给梅罗什。\n{zone:1452}余下的任务为55-58级：先在这处营地刷到54级，让前面的击杀也计入{npc:9298}和{npc:11556}的任务进度。",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Top up here first to level 55 on its Pathfinders (53-54) at the camp's edge: the Den Watchers inside are 55-56. Killing them raises your Timbermaw reputation and fills your bags with {item:14047} for Meilosh. Or, with a group, run {area:1584} or {area:2577} instead."] = "西侧的冬泉熊怪营地位于{npc:11556}与{npc:9298}之间的丘陵。先在这里营地边缘击杀冬泉探路者（53-54级），补到55级：营地内的冬泉巢穴守卫为55-56级。击杀它们能提升木喉声望，还能攒下留给梅罗什的{item:14047}。也可以组队去{area:1584}或{area:2577}。",
	-- ["The western Winterfall furbolgs drop the beads."] = "西边的冬泉熊怪掉落珠子。",
	-- ["The {area:2247}"] = "{area:2247}",
	-- ["To {zone:1455}"] = "前往{zone:1455}",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for."] = "先在这里补到55.05级，再去{area:2255}交还任务，交完会升到56级。击杀{area:2246}附近营地的冬泉熊怪（冬泉探路者、冬泉图腾师、冬泉巢穴守卫）：既能提升木喉声望，满足这里的任务和穿越{area:1769}的要求，又能拿到它们掉落的{quest:8471}，并攒够梅罗什需要的三十块符文布。",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for. Or, with a group, run {area:1584} or {area:2577} instead."] = "先在这里补到55.05级，再去{area:2255}交还任务，交完会升到56级。击杀{area:2246}附近营地的冬泉熊怪（冬泉探路者、冬泉图腾师、冬泉巢穴守卫）：既能提升木喉声望，满足这里的任务和穿越{area:1769}的要求，又能拿到它们掉落的{quest:8471}，并攒够梅罗什需要的三十块符文布。也可以组队去{area:1584}或{area:2577}。",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "在这里补到55.05级，再去{area:2255}交任务，交完会升到56级。刷{area:2246}附近营地的冬泉熊怪（冬泉探路者、冬泉图腾师、冬泉巢穴守卫）：击杀可提升木喉声望，这里的任务和穿越{area:1769}都需要。也可以组队去{area:1584}副本或{area:1583}副本（下层）。",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "穿过{area:1769}前往{zone:1448}，再飞往东部王国（{area:442}，乘船前往{area:150}）。飞往{area:271}，沿道路向北穿过奥特兰克前往{area:3197}。",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there at 47, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "你的炉石没有绑定在{zone:1455}（{zone:1425}指南会在47级时绑定在那里，本指南也会经由那里离开{zone:1452}）：改为绑定在{area:2255}，方便往返城镇。",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "你的炉石没有绑定在{zone:1455}（{zone:1425}指南会绑定在那里，本指南也会经由那里离开{zone:1452}）：改为绑定在{area:2255}，方便往返城镇。",
	-- ["Your Hearthstone is still set at {zone:1455}: from there the gryphon to {area:3197} is about ten minutes quicker than {area:2255}'s flight to Theramore and the boat."] = "你的炉石仍绑定在{zone:1455}：从那里乘狮鹫飞往{area:3197}，比从{area:2255}飞往塞拉摩岛再乘船快大约十分钟。",
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "流亡者塞达尔是精英：建议组队。他在该地区西南的墓穴{area:2261}底层等候。",
	-- ["grind on {npc:7442}"] = "刷{npc:7442}升级",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "在{zone:1452}的{area:2247}刷{npc:7460}",
	-- ["{area:150} flight master"] = "{area:150}的飞行管理员",
	-- ["{area:199} cauldron"] = "{area:199}的大锅",
	-- ["{area:2247}: kill these as you meet them"] = "{area:2247}：沿途击杀以下目标",
	-- ["{area:2255} flight master"] = "{area:2255}的飞行管理员",
	-- ["{area:2255}'s inn"] = "{area:2255}的旅店",
	-- ["{area:2269}: kill these as you meet them"] = "{area:2269}：沿途击杀以下目标",
	-- ["{item:12383}, 110 yd north"] = "{item:12383}，往北110码",
	-- ["{item:12771}, a rare drop"] = "{item:12771}，稀有掉落",
	-- ["{item:12886}; inside"] = "{item:12886}：在屋内",
	-- ["{item:12888}; inside"] = "{item:12888}：在屋内",
	-- ["{item:15785}; below ground"] = "{item:15785}：在地下",
	-- ["{npc:10301}'s supplies"] = "{npc:10301}的补给",
	-- ["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}：两样都保留，用于瘟疫之地",
	-- ["{npc:10431}: keep both for the Plaguelands; inside"] = "{npc:10431}位于屋内：保留两个任务，留待瘟疫之地处理",
	-- ["{npc:10431}: keep it for the Plaguelands; inside"] = "{npc:10431}：留待瘟疫之地处理；在屋内",
	-- ["{npc:10739} stands by the farm at the {area:202}, on the road east to the {zone:1423}."] = "{npc:10739}站在{area:202}的农场旁，沿路向东前往{zone:1423}时会经过。",
	-- ["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "{npc:10838}：哨塔在安多哈尔，先留着",
	-- ["{npc:10926}'s doll"] = "{npc:10926}的娃娃",
	-- ["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}：保留它，用于{area:2262}",
	-- ["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}：{npc:7583}和{npc:10977}之后再去",
	-- ["{npc:11038}: Zaeldarr is a level 54 elite"] = "{npc:11038}：流亡者塞达尔是 54 级精英",
	-- ["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}：{npc:12250}是54级精英",
	-- ["{npc:11053}: the cauldron is at {area:200}, keep it"] = "{npc:11053}：瘟疫之锅在{area:200}，先留着",
	-- ["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "{npc:11063}的后续任务在{area:2264}，周围是57-60级的天灾军团：跳过。",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556}守在{npc:9298}西北的{area:1769}入口处。",
	-- ["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556}就站在{area:1769}隧道的{zone:1452}出口处，也就是你出来的地方。",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}：白蚁之后在{area:2627}收集",
	-- ["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}：保留它，用于{area:2262}",
	-- ["{npc:11629}: keep it for {area:2262}; inside"] = "{npc:11629}位于屋内：保留任务，等前往{area:2262}时处理",
	-- ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754}在{area:2255}巡逻，请在地图标示的圆圈内寻找",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250}是精英：建议组队。他在该地区西南的墓穴{area:2261}底层等候。",
	-- ["{npc:9616} works in the {object:32356}: hand him {zone:1448}'s ooze jars now, on your way through."] = "{npc:9616}在{object:32356}工作：顺路现在就把{zone:1448}的软泥罐交给他。",
	-- ["{object:175894}, inside"] = "{object:175894}：在屋内",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{quest:5152}，在{area:28}：保留它",
	-- ["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}，在{zone:1422}：保留它",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}，之后交给梅罗什",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}，稀有掉落",
	-- ["{zone:1455} flight master"] = "{zone:1455}的飞行管理员",
	-- ["{zone:1455} inn"] = "{zone:1455}旅店",
}
