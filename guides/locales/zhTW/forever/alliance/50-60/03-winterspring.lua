-- Chinese (traditional) (zhTW): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "飛往{area:2255}",
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "{area:489}飛行管理員",

	-- Step 2: Everlook
	-- {area:2255} Everlook · {npc:11754} Meggi Peppinrocker
	["The flight lands in {area:2255}: {npc:11754} and Umi stand around the town before you ride west."] = "",
	-- {npc:11754} Meggi Peppinrocker · {npc:9298} Donova Snowden · {area:2255} Everlook
	-- was: ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754}在{area:2255}附近走動：看地圖上的圓圈內"
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
	["{area:2246}: kill these as you meet them"] = "{area:2246}：遇到就殺",
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
	["Fly to {area:392}"] = "飛往{area:392}",

	-- Step 12: Fly to Theramore
	["Fly to Theramore"] = "飛往塞拉摩",

	-- Step 13: The Barrens
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "從塞拉摩出發，向西騎入{zone:1413}，再沿海岸向北到{area:392}。",

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
	["Fly to {area:976}"] = "飛往{area:976}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}飛行管理員",

	-- Step 18: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro"] = "",

	-- Step 19: Gaeriyan
	-- {npc:9299} Gaeriyan · {item:11243} Videre Elixir
	["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299}是鎮東邊不遠墓地裡的鬼魂：在那裡喝下{item:11243}，你會死亡，釋放靈魂後以鬼魂狀態和他交談。然後跑回屍體復活：墓碑就在附近。",
	-- {npc:8737} Linken · {area:541} Marshal's Refuge
	["{npc:8737} in {area:541}, Un'Goro: keep it"] = "",

	-- Step 20: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "向西南騎往{area:1938}的{npc:7771}營地。",
	-- {npc:7771} Marvon Rivetseeker · {area:1417} Sunken Temple
	["{npc:7771}'s next task, Into the Depths, is inside the {area:1417}: skip it."] = "",

	-- Step 22: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "飛往{area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}飛行管理員",

	-- Step 23: Marshal's Refuge
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:9999} Ringo · {npc:8737} Linken · {npc:9117} J.D. Collie · {npc:9618} Karna Remtravel
	["Fly from {area:976} to {area:541}. {npc:9997}'s friend {npc:9999} has gone missing; {npc:8737} stands at the back of the refuge, with {npc:9117} in the cave behind him; {npc:9618} stands just outside, on the way out east."] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "{npc:9997}旁邊的木牌",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}，地下",
	-- {npc:9116} Eridan Bluewind · {zone:1448} Felwood
	["For {npc:9116} in {zone:1448}, later in this guide: keep it"] = "",

	-- Step 24: Northern Pylon
	["Northern Pylon"] = "北部水晶塔",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:6584} King Mosh
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}.\nCareful: {npc:6584} (60), a rare devilsaur, roams the crater's west around 27,46: if you meet him, ride away."] = "",

	-- Step 25: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "向東騎往{area:1943}，機器人站在猩猩群中。不要進入那裡的深洞。",
	["Below ground"] = "地下",

	-- Step 26: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau
	["{area:1943}: kill these as you meet them"] = "{area:1943}：遇到時順手擊殺",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "猩猩住在水晶塔東邊不遠的{area:1943}：趁你在上面時，現在就替{npc:9619}收集毛皮。別進最深的洞穴：{npc:9622}是55級。\n小心：安戈洛猩猩（50-51級）血量降到25%時會向20碼內的同伴求援。這一帶有個滿是猩猩的洞穴，在那裡戰鬥會引來大量怪物。",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "{item:11478}；地下",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "{item:11479}；地下",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "{item:11480}；地下",

	-- Step 28: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "",
	-- {area:538} Lakkari Tar Pits
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Tar Lords = {npc:6519} Tar Lord
	["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "焦油怪和焦油領主在{area:538}裡打滾，位於避難所南邊、往下進入環形山的路上。",

	-- Step 29: The crater
	["The crater"] = "環形山",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "焦油獸在{area:538}裡打滾；中部{area:537}的火元素攜帶著灰燼；南部{area:540}的格里什黃蜂攜帶著腺體。環形山裡的每種生物都可能掉落{item:11018}。\n注意：生命值降到45%以下的格里什工蜂有50%機率呼叫25碼內的同伴支援。",

	-- Step 30: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "{npc:9619}在進入環形山的坡道腳下紮營。",
	-- {quest:4291} The Scent of Lar'korwi
	["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}，如果你身上還帶著第一次來時的任務",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "毛皮來自{area:1943}的猩猩",
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}，如果第一次來之後有暴掠龍掉落了鱗片",

	-- Step 31: Damaged Blue Crystal
	-- {item:280417} Damaged Blue Crystal · {npc:9619} Torwa Pathfinder
	["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "{item:280417}在{npc:9619}營地西邊，騎一小段路就到。",

	-- Step 34: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "大猩猩生活在{area:541}東邊的{area:1943}。把它們的毛皮留給{npc:9619}。別進最深的洞穴：{npc:9622}是55級。\n注意：安戈洛大猩猩（50-51級）生命值降到25%後會呼叫20碼內的同伴支援。該區域有一個滿是猩猩的洞穴，在那裡戰鬥會引來大量增援。",

	-- Step 36: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "沿東側向北騎往猩猩高地。55級的猩猩{npc:9622}在最深的洞穴裡：先清掉洞口的猩猩。",

	-- Step 37: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there.\nCareful: {npc:9684} is level 56, a level or two over you here: start at full health, and clear the raptors around the lair first."] = "",

	-- Step 38: Eastern Pylon and the crate
	["Eastern Pylon and the crate"] = "東部水晶塔與箱子",
	-- {npc:9684} Lar'korwi · {item:11113} Crate of Foodstuffs
	["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "水晶塔位於{npc:9684}巢穴上方的東面懸崖上；探險隊的{item:11113}在東部叢林的廢棄營地裡。",

	-- Step 39: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "穿越環形山南部，前往坡道旁的{npc:9619}。",

	-- Step 40: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "{area:1942}：遇到就殺",

	-- Step 41: The Gorishi hive
	["The Gorishi hive"] = "格里什蟲巢",
	["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "沿著環形山南側向西走：這裡滿是格瑞希蟲巢。在孵化室（掛著幼蟲的房間）使用刮取瓶。",

	-- Step 42: Bones and equipment
	["Bones and equipment"] = "骨頭與裝備",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle.\nCareful: Gruff (57), a rare devilsaur, prowls the south around 38,75: if you meet him, ride away."] = "",

	-- Step 43: Western Pylon
	["Western Pylon"] = "西部水晶塔",
	["The pylon stands on the western cliffs."] = "水晶塔位於西面懸崖上。",

	-- Step 44: Krakle
	-- {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["North-east from the pylon to {area:543}: {npc:10302} the goblin sits by the water."] = "",

	-- Step 45: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "向東騎往{area:537}，爬上去，在山頂附近的熔岩噴口使用{npc:10541}。",

	-- Step 46: Krakle
	-- {npc:10302} Krakle
	["Back west to {npc:10302} at the hot springs."] = "",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}, later in this guide: keep it"] = "",

	-- Step 47: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}坐在環形山中央{area:537}的東南坡上。",

	-- Step 48: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "護送{npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 50: Fly to Gadgetzan
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "{area:541}飛行管理員",

	-- Step 51: Gadgetzan
	-- {npc:10041} Gorishi Hive Queen · {area:540} Slithering Scar
	["Pestlezugg's next task, Pawn Captures Queen, sends you back to the {npc:10041} in the {area:540}: skip it."] = "",

	-- Step 53: Liv Rizzlefix
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}，在裡面",

	-- Step 54: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "飛往{area:415}",

	-- Step 55: Felwood
	-- {area:415} Astranaar · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "從{area:415}騎馬向北進入{zone:1448}，前往路旁的德魯伊營地{area:2479}。",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 56: The Emerald Sanctuary
	-- {npc:10924} Ivy Leafrunner · {npc:11079} Wynd Nightchaser · {area:2253} Starfall Village
	["{npc:10924}: for {npc:11079} in {area:2253}, later in this guide; keep it"] = "",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}，在裡面",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "稍等一下{npc:9116}",
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
	["{object:176159}, below ground"] = "{object:176159}，地下",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "{object:176160}，地下",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "{object:176158}，地下",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "{object:176161}，地下",
	-- {item:11515} Corrupted Soul Shard · {npc:9528} Arathandris Silversky
	["{item:11515}, from the same cultists: {npc:9528} takes six by the Sanctuary if you did Cleansing Felwood"] = "",
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, in her cell; below ground"] = "{npc:11016}，在她的牢房裡；在地下",

	-- Step 58: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "把她帶出{area:1770}，一直保住她到出洞為止：先清掉回程的路。",

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
	["{npc:9861}, below ground"] = "{npc:9861}，地下",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "{npc:9860}，地下",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "{npc:9517}；地下",

	-- Step 63: The Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "騎回東南方的聖地。",

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
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}：在這一帶走動：看地圖上的圓圈裡",

	-- Step 69: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "{npc:11557}；在地下",

	-- Step 70: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "進入{zone:1452}",
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
	["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "小心：59級精英遠古鐵木行者站在{quest:5086}之間：在營地東北角（約50.6,22.4）一次打一隻恐魔，每次拉怪前先看看附近有沒有行者。",

	-- Step 74: Winterspring
	-- {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["Back north through {area:1769}'s tunnel to {npc:9298}."] = "",

	-- Step 76: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "{zone:1452}：沿途擊殺以下目標",
	-- {quest:5087} Winterfall Runners · {area:2246} Frostfire Hot Springs · {zone:1448} Felwood · {spell:5384} Feign Death
	["The {quest:5087} (57) carry their crates along the road between {area:2246} and {zone:1448}'s tunnel.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest.\nCareful: the {quest:5087} are 57, over you here: pull one at a time, away from the camp."] = "",

	-- Step 78: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "沿著道路向東騎往{area:2255}。",
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
	["{npc:10301}'s camp"] = "{npc:10301}的營地",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	-- was: ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "沿著山谷向東南騎往{area:2245}雪地中{npc:10301}的受損箱子，他的馬車殘骸就在它東邊。"
	["Ride south-east from {area:2255} down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "",

	-- Step 86: Sindrayl
	-- {zone:1452} Winterspring · {area:1769} Timbermaw Hold · {area:493} Moonglade · {npc:10897} Sindrayl · {area:2361} Nighthaven
	["Ride back north up the valley and west along the road to the tunnel at {zone:1452}'s western end, where Salfa stands. Walk into {area:1769} and take the {area:493} branch of the tunnel down to {area:493}. {npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn. The next guide flies on from here."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can drop the totem, about one kill in thirty: if the top-up did not bring one, keep killing them here until it drops, then right-click it."] = "任何冬泉熊怪都可能掉圖騰，大約三十隻裡有一個：如果補齊等級時沒出，就在這裡繼續殺到掉為止，然後右鍵點它。",
	-- ["Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh."] = "這裡的任何熊怪都可能掉落{item:12771}（約十分之一：任務所需的擊殺數內就會掉）和{quest:8471}（約三十分之一）：掉了哪個就右鍵點擊它。保留熊怪掉落的{item:14047}給梅羅什。",
	-- ["Back to the hills: only the Ice Thistle Matriarchs (56-57) and Patriarchs (57-58) carry the horns.\nCareful: take the Matriarchs at the edge of the hills, one at a time, and leave the Patriarchs: their horns drop from both."] = "回到山丘：只有冰薊雪人女王（56-57）和冰薊雪人族長（57-58）身上有角。\n小心：在山丘邊緣一次打一隻冰薊雪人女王，別碰族長：兩者都會掉角。",
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "回到山丘：只有冰薊雪人女王和冰薊雪人王身上帶著角。",
	-- ["Back to {npc:11053} at {area:3197}."] = "回到{area:3197}找{npc:11053}。",
	-- ["Boat to {area:150}"] = "搭船前往{area:150}",
	-- ["Fly to {area:271}"] = "飛往{area:271}",
	-- ["Fly to {area:3197}"] = "飛往{area:3197}",
	-- ["Follow the road east across the zone to the chapel."] = "沿著道路向東穿過本區前往禮拜堂。",
	-- ["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "沿著道路向西前往溫泉旁{npc:9298}的營地。",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "沿著南邊的道路向東進入{area:139}；{area:2262}的廢墟在道路南邊。{npc:10926}的鬼魂在南端的廢屋旁玩耍。",
	-- ["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "沿著南邊的道路向東進入{zone:1423}；{area:2262}的廢墟在道路南邊。{npc:10926}的鬼魂在南端的廢屋旁玩耍。",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "依照{npc:9298}的指示前往{area:2256}入口，途中經過霜槌巨人：一次通過一個。",
	-- ["For Kernda in {area:1769}: keep it"] = "給{area:1769}的克爾達：保留此任務",
	-- ["Free Darrowshire Spirits: talk to them"] = "解放達隆郡居民的靈魂：與他們交談",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "冰薊雪人住在{area:2244}南邊的山丘上，冰風奇美拉在往{area:2255}方向的山谷裡。",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}.\nCareful: the Ice Thistle Yetis are 55-56 and the Chimaeras 55-57: take the Rogue Ice Thistles (53-55) and the Fledgling Chillwinds (53-55) at the edge of the hills, and leave the Chillwind Ravagers (57-59) alone."] = "冰薊雪人住在{area:2244}南邊的山丘，冰風奇美拉在通往{area:2255}的山谷裡。\n小心：冰薊雪人是55-56級，冰風奇美拉是55-57級：打山丘邊緣的遊蕩的冰薊雪人（53-55）和冰風奇美拉幼獸（53-55），別碰冰風劫毀者（57-59）。",
	-- ["Inside"] = "在裡面",
	-- ["Into {zone:1423}"] = "進入{zone:1423}",
	-- ["Its jars are filled on the {zone:1451} guide's Un'Goro visit: keep it"] = "罐子會在{zone:1451}指南的安戈洛行程中裝滿：保留此任務",
	-- ["Keep it: Gregan in {zone:1444} brews the elixir later"] = "保留此任務：{zone:1444}的格雷甘稍後會調製藥劑",
	-- ["Level 55 at {area:2246}"] = "在{area:2246}升到55級",
	-- ["Level 55.05"] = "55.05級",
	-- ["North-west out of the camp to {area:199}, west of Andorhal: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54)."] = "從營地向西北前往安多哈爾西邊的{area:199}：{npc:11075}（53）在喋喋不休的食屍鬼（54）之間守著大鍋。",
	-- ["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the same ghost in {area:2262}."] = "在{area:3197}往東的道路上，{npc:10927}的農舍位於{area:197}：她的{quest:5142}也是交給{area:2262}的同一個鬼魂。",
	-- ["On {npc:10978}, by the inn"] = "在旅店旁的{npc:10978}處",
	-- ["Optional: {area:1417}"] = "可選：{area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "撿起馬車周圍的補給物資，並從附近的梟獸身上奪回{npc:10301}的護符。",
	-- ["Pristine Yeti Horns"] = "完美的雪人角",
	-- ["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "純心、杜瑪、瓦洛菲斯特和麥克唐奈站在營地中央附近，飛行管理員旁邊。",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "向北騎往{area:2627}。{npc:12384}住在廢棄的小屋裡，他的收據冊在附近的旅店廢墟中。",
	-- ["Ride north up the valley, past {area:2255}, to {area:2253}."] = "沿山谷向北騎行，經過{area:2255}，前往{area:2253}。",
	-- ["Ride north-west back to the village."] = "向西北騎回村莊。",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "沿著山谷向東南騎往{area:2245}雪地中{npc:10301}的受損箱子，他的馬車殘骸就在它東邊。",
	-- ["Ride west along the road to the night elf village."] = "沿著道路向西騎往夜精靈村莊。",
	-- ["Ride west along the road to {npc:10301}."] = "沿著道路向西騎往{npc:10301}處。",
	-- ["Scare {npc:10978} with {item:12928}"] = "用{item:12928}嚇唬{npc:10978}",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "打完雪人後還不到54級？組隊打{area:1417}（50-54級）代替練等能更快達到目標。之後回到{area:2255}。",
	-- ["The Deadwood cauldron in {zone:1448}: keep it"] = "{zone:1448}的死木大鍋：保留此任務",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "禮拜堂西邊{area:2264}周圍的天譴軍會掉落兩種天譴石；達隆郡居民的靈魂會從牠們身上升起：與每一個交談以解放它。\n小心：{npc:10411}在戰鬥外會隱形，戰鬥一開始就會召來岩翼石像鬼。牠們只有3隻，每15分鐘重生一次。",
	-- ["The Winterfall camp"] = "冬泉營地",
	-- ["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "冬泉熊怪的村莊位於{area:2255}東邊：冬泉薩滿（56-57級）、冬泉巢穴守衛（55-56級）和冬泉巨熊怪（57-58級），都比你高。先殺薩滿，他們會治療，並從邊緣開始拉。後方洞穴裡的{npc:10738}是精英：不要進去。",
	-- ["The next guide starts here and flies to {area:3197}."] = "下一份指南從這裡開始，然後飛往{area:3197}。",
	-- ["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "遺跡位於{area:2253}南邊結冰湖泊的周圍。拾取散落在遺跡中的四塊遺物碎片，以及梟獸遊蕩處地上的月光羽毛。",
	-- ["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "洋娃娃的三個部分在{area:2262}的廢屋裡；撿起其中一個可能會引出鬼魂。把它們組合成洋娃娃。",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "冬泉西部營地位於{npc:11556}和{npc:9298}之間的山丘上。這裡的任何熊怪都可能掉落{item:12771}（約十分之一），極少數會掉落{quest:8471}：掉了哪個就右鍵點擊它。保留熊怪掉落的{quest:6031}給梅羅什。",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Top up here first to level 55 on its Pathfinders (53-54) at the camp's edge: the Den Watchers inside are 55-56. Killing them raises your Timbermaw reputation and fills your bags with {item:14047} for Meilosh. Or, with a group, run {area:1584} or {area:2577} instead."] = "冬泉西部營地位於{npc:11556}和{npc:9298}之間的山丘上。先在這裡營地邊緣的冬泉探路者（53-54）身上練到55級：裡面的冬泉巢穴守衛是55-56級。擊殺牠們能提升木喉要塞聲望，背包也會塞滿要給梅羅什的{item:14047}。或者，有小隊的話改刷{area:1584}或{area:2577}。",
	-- ["The western Winterfall furbolgs drop the beads."] = "西部的冬泉熊怪會掉落珠串。",
	-- ["The {area:2247}"] = "{area:2247}",
	-- ["To {zone:1455}"] = "前往{zone:1455}",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for. Or, with a group, run {area:1584} or {area:2577} instead."] = "在{area:2255}繳交任務前先在這裡練到55.05級：繳交後會升到56級。刷{area:2246}旁紮營的冬泉熊怪（探路者、圖騰師、巢穴守衛）：擊殺牠們能提升木喉要塞聲望，這裡的任務和穿過{area:1769}都需要；其中一隻會掉落{quest:8471}，背包也會塞滿梅羅什要的三十塊符文布。或者，有小隊的話改刷{area:1584}或{area:2577}。",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "穿過{area:1769}前往{zone:1448}，再飛往東部王國（{area:442}，搭船到{area:150}）。飛往{area:271}，沿著道路向北穿過奧特蘭克前往{area:3197}。",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there at 47, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "你的爐石沒有設定在{zone:1455}（{zone:1425}指南在47級時於那裡綁定，而本指南會透過爐石離開{zone:1452}）：改為綁定在{area:2255}，方便往返城鎮。",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "你的爐石沒有設定在{zone:1455}（{zone:1425}指南在那裡綁定，而本指南會透過爐石離開{zone:1452}）：改為綁定在{area:2255}，方便往返城鎮。",
	-- ["Your Hearthstone is still set at {zone:1455}: from there the gryphon to {area:3197} is about ten minutes quicker than {area:2255}'s flight to Theramore and the boat."] = "你的爐石仍設定在{zone:1455}：從那裡搭乘獅鷲飛往{area:3197}，比從{area:2255}飛往塞拉摩再搭船快大約十分鐘。",
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "塞達爾是精英：建議組隊。他在本區西南部的地穴{area:2261}最底層等著。",
	-- ["grind on {npc:7442}"] = "刷{npc:7442}",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "在{zone:1452}的{area:2247}擊殺{npc:7460}練等",
	-- ["{area:150} flight master"] = "{area:150}飛行管理員",
	-- ["{area:199} cauldron"] = "{area:199}的瘟疫之鍋",
	-- ["{area:2247}: kill these as you meet them"] = "{area:2247}：遇到就殺",
	-- ["{area:2255} flight master"] = "{area:2255}飛行管理員",
	-- ["{area:2255}'s inn"] = "{area:2255}的旅店",
	-- ["{item:12771}, a rare drop"] = "{item:12771}，稀有掉落",
	-- ["{item:12886}; inside"] = "{item:12886}；室內",
	-- ["{item:12888}; inside"] = "{item:12888}；室內",
	-- ["{item:15785}; below ground"] = "{item:15785}；地下",
	-- ["{npc:10301}'s supplies"] = "{npc:10301}的補給物資",
	-- ["{npc:10431}: keep both for the Plaguelands; inside"] = "{npc:10431}：兩個都保留給瘟疫之地；在裡面",
	-- ["{npc:10431}: keep it for the Plaguelands; inside"] = "{npc:10431}：保留給瘟疫之地；在裡面",
	-- ["{npc:10739} stands by the farm at the {area:202}, on the road east to the {zone:1423}."] = "{npc:10739}站在{area:202}的農場旁，沿路向東前往{zone:1423}時會經過。",
	-- ["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "{npc:10838}：哨塔在安多哈爾，留著",
	-- ["{npc:10926}'s doll"] = "{npc:10926}的洋娃娃",
	-- ["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}：保留給{area:2262}",
	-- ["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}：{npc:7583}和{npc:10977}稍後再找",
	-- ["{npc:11038}: Zaeldarr is a level 54 elite"] = "{npc:11038}：薩爾達爾是54級精英",
	-- ["{npc:11053}: the cauldron is at {area:200}, keep it"] = "{npc:11053}：大鍋在{area:200}，留著",
	-- ["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "{npc:11063}的下一個任務在{area:2264}，那裡都是57-60級的天譴軍：跳過。",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556}守衛著{npc:9298}西北方的{area:1769}入口。",
	-- ["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556}就站在{area:1769}隧道的{zone:1452}出口，也就是你出來的地方。",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}：白蟻稍後在{area:2627}處理",
	-- ["{npc:11629}: keep it for {area:2262}; inside"] = "{npc:11629}：保留給{area:2262}；在裡面",
	-- ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754}在{area:2255}附近走動：看地圖上的圓圈內",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250}是精英：建議組隊。他在本區西南部的地穴{area:2261}最底層等著。",
	-- ["{npc:9616} works in the {object:32356}: hand him {zone:1448}'s ooze jars now, on your way through."] = "{npc:9616}在{object:32356}工作：路過時就把{zone:1448}的軟泥罐交給他。",
	-- ["{object:175894}, inside"] = "{object:175894}，室內",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{area:28}的{quest:5152}：保留此任務",
	-- ["{quest:5152}, in the {zone:1422}: keep it"] = "{zone:1422}的{quest:5152}：保留此任務",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}，稍後給梅羅什",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}，稀有掉落",
	-- ["{zone:1455} flight master"] = "{zone:1455}的飛行管理員",
	-- ["{zone:1455} inn"] = "{zone:1455}旅店",
}
