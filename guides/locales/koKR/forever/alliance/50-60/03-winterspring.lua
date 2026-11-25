-- Korean (koKR): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2255} Everlook · {zone:1448} Felwood · {zone:1452} Winterspring
	["{area:2255} first, then Un'Goro, then {zone:1448} and {zone:1452} again."] = "먼저 {area:2255}, 그다음 운고로, 그리고 다시 {zone:1448}, {zone:1452}.",

	-- Step 1: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "{area:2255}(으)로 날아가기",

	-- Step 2: Everlook
	-- {area:2255} Everlook · {npc:11754} Meggi Peppinrocker
	["The flight lands in {area:2255}: {npc:11754} and Umi stand around the town before you ride west."] = "",
	-- {npc:11754} Meggi Peppinrocker · {npc:9298} Donova Snowden · {area:2255} Everlook
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

	-- Step 5: Donova Snowden
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299}, at the graveyard just east of {area:976}, later in this guide"] = "",

	-- Step 6: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: 만나는 대로 처치하세요",
	-- {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {item:14047} Runecloth · {npc:11557} Meilosh
	-- plural, as words: Winterfall Ritual Totems = {quest:8471} Winterfall Ritual Totem
	["The western Winterfall camp sits in the hills between {npc:9298} and the tunnel. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need): right-click it. They also drop Winterfall Ritual Totems (about one in thirty) and {item:14047}, which only matter if you are Neutral (the totem) or Friendly ({npc:11557}'s {item:14047}) with the Timbermaw: keep them then.\nCareful: the Pathfinders are 53 and the Totemics 54, but the Den Watchers inside the camp are 55: take the camp from its edge and pull one at a time."] = "",
	-- {item:14047} Runecloth · {npc:11557} Meilosh
	["{item:14047}, for {npc:11557}, if you are Friendly with the Timbermaw"] = "",

	-- Step 7: Winterfall Ritual Totem
	-- {npc:11558} Kernda
	["{npc:11558} takes the totem; the quest needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["For {npc:11558} in {area:1769}, later in this guide: keep it"] = "",

	-- Step 8: Donova Snowden
	-- {area:1762} Felpaw Village · {zone:1448} Felwood
	["The Deadwood cauldron in {area:1762}, at the {zone:1448} end of the tunnel"] = "",

	-- Step 9: Felwood
	-- {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden · {zone:1448} Felwood
	["Through {area:1769}'s tunnel, just north of {npc:9298}, to {zone:1448}."] = "",
	-- {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["{area:1769}, {zone:1448} side"] = "",

	-- Step 10: Deadwood Cauldron
	-- {area:1762} Felpaw Village
	["The Deadwood cauldron stands at the top of {area:1762}, just west of the cave mouth."] = "",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298}, on this guide's {zone:1452} loop: keep it"] = "",

	-- Step 11: Talonbranch Glade
	-- {area:1998} Talonbranch Glade
	["Ride south from the cave to {area:1998}, the night elves' camp on the road."] = "",

	-- Step 12: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",

	-- Step 13: Fly to Theramore
	["Fly to Theramore"] = "테라모어 섬으로 비행",

	-- Step 14: The Barrens
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "",

	-- Step 15: Ratchet
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: the ash is in Un'Goro; inside"] = "",

	-- Step 16: The Stone Circle
	-- {quest:3444} The Stone Circle
	["{quest:3444} stands on the hill just south-west of the flight master."] = "",

	-- Step 17: Islen Waterseer
	-- {npc:5901} Islen Waterseer
	["{npc:5901} stands on the coast south-east of town."] = "",
	-- {zone:1448} Felwood
	["For Greta in {zone:1448}, later in this guide: keep it"] = "",

	-- Step 18: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392} 비행 조련사",

	-- Step 19: Gadgetzan
	-- {area:976} Gadgetzan · {npc:9623} A-Me 01 · {quest:4243} Chasing A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{area:976}'s Auction House is the last one before Un'Goro. There, {npc:9623} ({quest:4243}) asks for a {item:10561}, an {skill:202} item, before her escort: buy one here if you want that chain."] = "{area:976}의 경매장은 운고로 전 마지막 경매장입니다. 그곳에서 {npc:9623}({quest:4243})이(가) 호위 전에 {skill:202} 아이템인 {item:10561}을(를) 요구합니다: 이 연계를 하려면 여기서 하나 사십시오.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, 내부",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro"] = "",

	-- Step 20: Gaeriyan
	-- {npc:9299} Gaeriyan · {item:11243} Videre Elixir
	["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299}은(는) 마을 바로 동쪽 묘지에 있는 유령입니다. 그곳에서 {item:11243}을(를) 마시면 죽습니다. 영혼을 해방한 뒤 유령 상태로 그에게 말을 거세요. 그런 다음 시체로 달려가 되살아나세요. 묘비는 근처에 있습니다.",
	-- {npc:8737} Linken · {area:541} Marshal's Refuge
	["{npc:8737} in {area:541}, Un'Goro: keep it"] = "",

	-- Step 21: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "남서쪽으로 {area:1938}의 {npc:7771} 야영지로 가세요.",
	-- {npc:7771} Marvon Rivetseeker · {area:1417} Sunken Temple
	["{npc:7771}'s next task, Into the Depths, is inside the {area:1417}: skip it."] = "",

	-- Step 23: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "{area:541}(으)로 날아가기",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976} 비행 조련사",

	-- Step 24: Marshal's Refuge
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:9999} Ringo · {npc:8737} Linken · {npc:9117} J.D. Collie · {npc:9618} Karna Remtravel
	["Fly from {area:976} to {area:541}. {npc:9997}'s friend {npc:9999} has gone missing; {npc:8737} stands at the back of the refuge, with {npc:9117} in the cave behind him; {npc:9618} stands just outside, on the way out east."] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "{npc:9997} 옆의 나무 표지판",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, 지하",
	-- {npc:9116} Eridan Bluewind · {zone:1448} Felwood
	["For {npc:9116} in {zone:1448}, later in this guide: keep it"] = "",

	-- Step 25: Northern Pylon
	["Northern Pylon"] = "북쪽 수정탑",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:6584} King Mosh
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}.\nCareful: {npc:6584} (60), a rare devilsaur, roams the crater's west around 27,46: if you meet him, ride away."] = "",

	-- Step 26: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "동쪽으로 {area:1943}까지 가세요. 로봇은 고릴라들 사이에 서 있습니다. 그곳의 깊은 동굴에는 들어가지 마세요.",
	["Below ground"] = "지하",

	-- Step 27: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau
	["{area:1943}: kill these as you meet them"] = "{area:1943}: 만나는 대로 처치하세요",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "고릴라는 수정탑 바로 동쪽의 {area:1943}에 삽니다. 여기 올라온 김에 지금 {npc:9619}에게 줄 가죽을 모으세요. 가장 깊은 동굴에는 들어가지 마세요. {npc:9622}은(는) 55레벨입니다.\n주의: 운고로 고릴라(50-51레벨)는 생명력이 25%로 떨어지면 20미터 안의 동료를 불러 도움을 요청합니다. 이 지역에는 고릴라로 가득한 동굴이 있어, 그곳에서 싸우면 많은 적이 몰려듭니다.",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "",

	-- Step 29: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}: 만나는 대로 처치하세요",
	-- {area:538} Lakkari Tar Pits
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Tar Lords = {npc:6519} Tar Lord
	["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "타르 야수와 타르 군주는 분화구로 내려가는 길에 있는 피난처 남쪽의 {area:538}에서 뒹굴고 있습니다.",

	-- Step 30: The crater
	["The crater"] = "분화구",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "",

	-- Step 31: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "",
	-- {quest:4291} The Scent of Lar'korwi
	["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}, 첫 방문 때부터 아직 가지고 있다면",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "가죽은 {area:1943}의 고릴라에게서 모읍니다",
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}, 첫 방문 이후 라바사우루스가 비늘을 떨어뜨렸다면",

	-- Step 32: Damaged Blue Crystal
	-- {item:280417} Damaged Blue Crystal · {npc:9619} Torwa Pathfinder
	["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "{item:280417}은(는) {npc:9619}의 야영지에서 서쪽으로 조금만 가면 있습니다.",

	-- Step 35: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "",

	-- Step 37: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "동쪽을 따라 북쪽의 고릴라 고원으로 가세요. 55레벨 고릴라 {npc:9622}은(는) 가장 깊은 동굴에 있습니다. 먼저 동굴 입구의 고릴라를 정리하세요.",

	-- Step 38: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there.\nCareful: {npc:9684} is level 56, a level or two over you here: start at full health, and clear the raptors around the lair first."] = "",

	-- Step 39: Eastern Pylon and the crate
	["Eastern Pylon and the crate"] = "동쪽 수정탑과 상자",
	-- {npc:9684} Lar'korwi · {item:11113} Crate of Foodstuffs
	["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "수정탑은 {npc:9684}의 굴 위 동쪽 절벽에 있습니다. 탐험대의 {item:11113}은(는) 동쪽 밀림의 버려진 야영지에 있습니다.",

	-- Step 40: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "분화구 남쪽을 가로질러 비탈 옆의 {npc:9619}에게 가세요.",

	-- Step 41: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "{area:1942}: 만나는 대로 처치하세요",

	-- Step 42: The Gorishi hive
	["The Gorishi hive"] = "고리쉬 벌집",
	["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "분화구 남쪽을 따라 서쪽으로 가세요. 고리시 벌집이 그곳을 채우고 있습니다. 애벌레가 매달린 방인 부화장에 긁개 유리병을 사용하세요.",

	-- Step 43: Bones and equipment
	["Bones and equipment"] = "뼈와 장비",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle.\nCareful: Gruff (57), a rare devilsaur, prowls the south around 38,75: if you meet him, ride away."] = "",

	-- Step 44: Western Pylon
	["Western Pylon"] = "서쪽 수정탑",
	["The pylon stands on the western cliffs."] = "수정탑은 서쪽 절벽에 있습니다.",

	-- Step 45: Krakle
	-- {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["North-east from the pylon to {area:543}: {npc:10302} the goblin sits by the water."] = "",

	-- Step 46: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "동쪽으로 {area:537}까지 가서 올라간 뒤, 꼭대기 근처 용암 분출구에서 {npc:10541}을(를) 사용하세요.",

	-- Step 47: Krakle
	-- {npc:10302} Krakle
	["Back west to {npc:10302} at the hot springs."] = "",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}, later in this guide: keep it"] = "",

	-- Step 48: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}은(는) 분화구 한가운데 {area:537}의 남동쪽 비탈에 앉아 있습니다.",

	-- Step 49: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "{npc:9999} 호위",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 51: Fly to Gadgetzan
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "{area:541} 비행 조련사",

	-- Step 52: Gadgetzan
	-- {npc:10041} Gorishi Hive Queen · {area:540} Slithering Scar
	["Pestlezugg's next task, Pawn Captures Queen, sends you back to the {npc:10041} in the {area:540}: skip it."] = "",

	-- Step 54: Liv Rizzlefix
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}, 내부",

	-- Step 55: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "{area:415}(으)로 날아가기",

	-- Step 56: Felwood
	-- {area:415} Astranaar · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 57: Eridan Bluewind
	-- {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary
	["{npc:9116} stands inside, in the {area:2479}."] = "{npc:9116}은(는) {area:2479} 안에 서 있습니다.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, 내부",

	-- Step 58: The Emerald Sanctuary
	-- {npc:10924} Ivy Leafrunner · {npc:11079} Wynd Nightchaser · {area:2253} Starfall Village
	["{npc:10924}: for {npc:11079} in {area:2253}, later in this guide; keep it"] = "",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "{npc:9116}을(를) 잠시 기다리세요",
	-- {npc:9116} Eridan Bluewind · {npc:222647} Ancient Spirit · {npc:3848} Kayneth Stillwind · {area:2358} Forest Song · {zone:1448} Felwood
	["{npc:9116}'s next task, {npc:222647}, ends with {npc:3848} at {area:2358}, south of the route once {zone:1448} is done: skip it."] = "",
	-- {npc:9116} Eridan Bluewind
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["{npc:9116}'s next task, Silver Heart, sends you to the Irontree Stompers in the north and back here: skip it."] = "",

	-- Step 59: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "{area:1770} 화로",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Darkweavers = {npc:7118} Jaedenar Darkweaver
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns: pull at the edge of each group and fight one pack at a time.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "{object:176159}, 지하",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "{object:176160}, 지하",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "{object:176158}, 지하",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "{object:176161}, 지하",
	-- {item:11515} Corrupted Soul Shard · {npc:9528} Arathandris Silversky
	["{item:11515}, from the same cultists: {npc:9528} takes six by the Sanctuary if you did Cleansing Felwood"] = "",
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, in her cell; below ground"] = "{npc:11016}, 그녀의 감방에; 지하",

	-- Step 60: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "그녀를 {area:1770} 밖으로 인도하고 동굴 밖에 나올 때까지 살려 두세요. 먼저 돌아오는 길을 정리하세요.",

	-- Step 62: Greta Mosshoof: A Final Blow
	-- {quest:5242} A Final Blow · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold
	["{quest:5242} is a group quest at this level: {npc:9861} (52), {npc:9860} (54) and {npc:9517} (57) fight together at the back of {area:1770}. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "",

	-- Step 63: Rakaiah
	-- {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["Back into {area:1770}: the succubus {npc:9518} (56) waits on the way to its deepest chamber, with Trey Lightforge's remains beside her.\nCareful: {npc:9518} is level 56: clear the cultists around her first and fight her at full health."] = "",
	-- {npc:9518} Rakaiah
	["{npc:9518}, below ground"] = "{npc:9518}, 지하",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "{npc:11020}, 지하",

	-- Step 64: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["{npc:9861} and {npc:9860} guard {npc:9517} in {area:1770}'s deepest chamber, just past {npc:9518}.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "{npc:9861}, 지하",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "{npc:9860}, 지하",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "{npc:9517}; 지하",

	-- Step 65: The Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "남동쪽의 성소로 돌아가세요.",

	-- Step 66: Arathandris Silversky
	-- {npc:9528} Arathandris Silversky · {area:1770} Shadow Hold
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["{npc:9528} is in the ruins just down the road from the Sanctuary: he takes the six Corrupted Soul Shards (from both trips into {area:1770}) on the spot."] = "",

	-- Step 68: Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Ride north up the road to the cave mouth of {area:1769}."] = "",

	-- Step 69: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["{npc:11558} stands just inside the {area:1769} cave: she needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}: 여기 돌아다닙니다: 지도에서 원 안을 보세요",

	-- Step 71: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "{npc:11557}; 지하",

	-- Step 72: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "{zone:1452}(으)로",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Through {area:1769}'s tunnel to its {zone:1452} end."] = "",

	-- Step 73: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride on to {npc:9298}'s camp beside the hot springs."] = "",
	-- {quest:980} The New Springs · {area:2256} Darkwhisper Gorge
	["{quest:980}' follow-up, Strange Sources, is at {area:2256}'s mouth among elite giants and Hederine: skip it."] = "",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["The {quest:5086} are just back through the tunnel, in {zone:1448}"] = "",

	-- Step 74: Felwood
	-- {zone:1448} Felwood · {area:1998} Talonbranch Glade · {quest:5086} Toxic Horrors · {area:1767} Irontree Woods
	["Back through the tunnel to {zone:1448} and south past {area:1998}: the {quest:5086} (53) roam the north-eastern tip of {area:1767}."] = "",
	-- {quest:5086} Toxic Horrors
	["The {quest:5086}"] = "{quest:5086}",

	-- Step 75: Toxic Horrors
	-- {quest:5086} Toxic Horrors
	-- plural, as words: Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "주의: 59레벨 정예 Ancient Irontree Walker가 {quest:5086} 사이에 서 있습니다. 야영지 북동쪽 끝(약 50.6,22.4)의 소산물을 하나씩 처치하고, 끌어오기 전마다 보행자가 있는지 살피십시오.",

	-- Step 76: Winterspring
	-- {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["Back north through {area:1769}'s tunnel to {npc:9298}."] = "",

	-- Step 78: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "{zone:1452}: 길에서 만나는 대로 잡으세요",
	-- {quest:5087} Winterfall Runners · {area:2246} Frostfire Hot Springs · {zone:1448} Felwood · {spell:5384} Feign Death
	["The {quest:5087} (57) carry their crates along the road between {area:2246} and {zone:1448}'s tunnel.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest.\nCareful: the {quest:5087} are 57, over you here: pull one at a time, away from the camp."] = "",

	-- Step 80: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "길을 따라 동쪽 {area:2255}(으)로 가세요.",
	-- {npc:11755} Harlo Wigglesworth · {npc:10301} Jaron Stoneshaper · {area:2253} Starfall Village
	["{npc:11755}: for {npc:10301} in {area:2253}, just back up the road"] = "",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep it for the Plaguelands, on the next guide; inside"] = "",

	-- Step 81: Starfall Village
	-- {area:2253} Starfall Village · {npc:11079} Wynd Nightchaser · {npc:10301} Jaron Stoneshaper
	["Ride back north-west to {area:2253} on its hill: {npc:11079} and {npc:10301} stand together."] = "",
	-- {quest:5250} Starfall
	["The relics are in the ruins just south of {quest:5250}"] = "",

	-- Step 82: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village · {npc:10304} Aurora Skycaller · {zone:1423} Eastern Plaguelands
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins: {npc:10304} in the {zone:1423} takes them, on the next guide."] = "",

	-- Step 83: The road to Everlook: furs and horns
	-- {area:2255} Everlook
	["The road to {area:2255}: furs and horns"] = "",
	-- {area:2255} Everlook · {npc:9298} Donova Snowden
	-- plural, as words: Thick Yeti Furs = {item:12366} Thick Yeti Fur · Uncracked Chillwind Horns = {item:12444} Uncracked Chillwind Horn · Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind · Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti · Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Still short of Thick Yeti Furs or Uncracked Chillwind Horns? The Rogue Ice Thistles and the Fledgling Chillwinds (both 53-55) live along the road west of {area:2255}, toward {npc:9298}. The hills east of {area:2255} hold only the Ice Thistle Yetis (55-56), Matriarchs and Patriarchs, and the Chillwind Chimaeras (55-57) and Ravagers (57-59): don't hunt the furs and horns there."] = "",

	-- Step 85: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "온전한 설인 뿔",
	["Check the two outdoor Matriarchs (56) on the western slope of the yetis' hills. Leave the Patriarchs (57) and the cave alone. If you don't get both horns on this pass, skip the hunt and Umi's hand-in."] = "",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Loot the horns from Ice Thistle Matriarchs"] = "",

	-- Step 86: Everlook
	-- {area:2255} Everlook · {area:976} Gadgetzan
	["Umi's next task scares three goblins in {area:2255}, {area:976} and Un'Goro, behind the route now: skip it."] = "",

	-- Step 87: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "{npc:10301}의 야영지",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	-- was: ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "계곡을 따라 남동쪽으로 내려가 {area:2245}의 눈 속에 있는 {npc:10301}의 부서진 상자로 가세요. 부서진 마차가 그 바로 동쪽에 있습니다."
	["Ride south-east from {area:2255} down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "",

	-- Step 88: Sindrayl
	-- {zone:1452} Winterspring · {area:1769} Timbermaw Hold · {area:493} Moonglade · {npc:10897} Sindrayl · {area:2361} Nighthaven
	["Ride back north up the valley and west along the road to the tunnel at {zone:1452}'s western end, where Salfa stands. Walk into {area:1769} and take the {area:493} branch of the tunnel down to {area:493}. {npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn. The next guide flies on from here."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh."] = "이곳의 퍼볼그는 누구든 {item:12771}(약 10분의 1 확률: 이 퀘스트들에 필요한 처치 수 안에 나옵니다)과 {quest:8471}(약 30분의 1 확률)을(를) 떨어뜨릴 수 있습니다. 떨어진 것을 오른쪽 클릭하세요. 퍼볼그가 떨어뜨리는 {item:14047}은(는) 메일로쉬를 위해 보관하세요.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs (56-57) and Patriarchs (57-58) carry the horns.\nCareful: take the Matriarchs at the edge of the hills, one at a time, and leave the Patriarchs: their horns drop from both."] = "언덕으로 돌아가세요. 뿔은 맹렬한 얼음엉겅퀴설인(56-57)과 얼음엉겅퀴설인 우두머리(57-58)만 가지고 있습니다.\n주의: 맹렬한 얼음엉겅퀴설인을 언덕 가장자리에서 하나씩 잡고, 우두머리는 피하세요. 뿔은 둘 다에게서 나옵니다.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "언덕으로 돌아가세요. 맹렬한 얼음엉겅퀴설인과 덩치큰 얼음엉겅퀴설인만 뿔을 지니고 있습니다.",
	-- ["Back to {npc:11053} at {area:3197}."] = "{area:3197}의 {npc:11053}에게 돌아가세요.",
	-- ["Boat to {area:150}"] = "배를 타고 {area:150}(으)로",
	-- ["Fly to {area:271}"] = "{area:271}(으)로 날아가세요",
	-- ["Fly to {area:3197}"] = "{area:3197}(으)로 비행",
	-- ["Follow the road east across the zone to the chapel."] = "길을 따라 동쪽으로 지역을 가로질러 예배당까지 가세요.",
	-- ["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "길을 따라 서쪽으로 온천 옆 {npc:9298}의 야영지까지 가세요.",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "남쪽 길을 따라 동쪽으로 {area:139}에 들어가세요. {area:2262}의 폐허는 그 남쪽에 있습니다. {npc:10926}의 유령은 남쪽 끝의 무너진 집 옆에서 놀고 있습니다.",
	-- ["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "남쪽 길을 따라 동쪽으로 {zone:1423}에 들어가세요. {area:2262}의 폐허는 그 남쪽에 있습니다. {npc:10926}의 유령은 남쪽 끝의 무너진 집 옆에서 놀고 있습니다.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "{npc:9298}의 안내를 따라 서리망치거인들을 지나 {area:2256} 입구로 가세요. 거인은 하나씩 지나가세요.",
	-- ["For Kernda in {area:1769}: keep it"] = "{area:1769}의 케른다에게: 보관하세요",
	-- ["Free Darrowshire Spirits: talk to them"] = "{npc:11064} 해방: 대화하기",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "얼음엉겅퀴설인은 {area:2244} 남쪽 언덕에, 서리바람 키메라는 {area:2255} 쪽 계곡에 삽니다.",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}.\nCareful: the Ice Thistle Yetis are 55-56 and the Chimaeras 55-57: take the Rogue Ice Thistles (53-55) and the Fledgling Chillwinds (53-55) at the edge of the hills, and leave the Chillwind Ravagers (57-59) alone."] = "얼음엉겅퀴설인은 {area:2244} 남쪽 언덕에, 서리바람 키메라는 {area:2255} 쪽 골짜기에 삽니다.\n주의: 얼음엉겅퀴설인은 55-56레벨, 키메라는 55-57레벨입니다. 언덕 가장자리의 떠도는 얼음엉겅퀴설인(53-55)과 어린 서리바람 키메라(53-55)를 잡고, 갈퀴발톱 서리바람 키메라(57-59)는 피하세요.",
	-- ["Inside"] = "내부",
	-- ["Into {zone:1423}"] = "{zone:1423}(으)로",
	-- ["Its jars are filled on the {zone:1451} guide's Un'Goro visit: keep it"] = "단지는 {zone:1451} 가이드의 운고로 방문 때 채웁니다: 보관하세요",
	-- ["Keep it: Gregan in {zone:1444} brews the elixir later"] = "보관하세요: 나중에 {zone:1444}의 그레간이 비약을 만듭니다",
	-- ["Level 55 at {area:2246}"] = "{area:2246}에서 55레벨",
	-- ["North-west out of the camp to {area:199}, west of Andorhal: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54)."] = "야영지에서 북서쪽으로 안돌할 서쪽의 {area:199}까지 가세요. {npc:11075}(53)이(가) 비명소리 구울(54) 사이에서 가마솥을 지킵니다.",
	-- ["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the same ghost in {area:2262}."] = "{area:3197}에서 동쪽으로 난 길가, {area:197}에 {npc:10927}의 농가가 있습니다. 그녀의 {quest:5142} 퀘스트는 {area:2262}의 같은 유령에게 이어집니다.",
	-- ["On {npc:10978}, by the inn"] = "{npc:10978}에게, 여관 옆",
	-- ["Optional: {area:1417}"] = "선택: {area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "마차 주변의 보급품을 줍고, 근처 올빼미야수에게서 {npc:10301}의 목걸이를 되찾으세요.",
	-- ["Pristine Yeti Horns"] = "온전한 설인 뿔",
	-- ["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "퓨어하트, 두마, 밸러피스트, 맥도넬은 야영지 한가운데, 비행 조련사 옆에 서 있습니다.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "북쪽으로 {area:2627}까지 가세요. {npc:12384}은(는) 무너진 오두막에 살고, 그의 영수증 장부는 근처의 무너진 여관에 있습니다.",
	-- ["Ride north-west back to the village."] = "북서쪽으로 마을까지 돌아가세요.",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "계곡을 따라 남동쪽으로 내려가 {area:2245}의 눈 속에 있는 {npc:10301}의 부서진 상자로 가세요. 부서진 마차가 그 바로 동쪽에 있습니다.",
	-- ["Ride west along the road to the night elf village."] = "길을 따라 서쪽으로 나이트 엘프 마을까지 가세요.",
	-- ["Ride west along the road to {npc:10301}."] = "길을 따라 서쪽으로 {npc:10301}에게 가세요.",
	-- ["Scare {npc:10978} with {item:12928}"] = "{item:12928}(으)로 {npc:10978} 겁주기",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "설인 사냥 후에도 54레벨이 안 되나요? 사냥 대신 파티로 {area:1417}(50-54)을(를) 돌면 더 빨리 도달합니다. 그 후 {area:2255}(으)로 돌아오세요.",
	-- ["The Deadwood cauldron in {zone:1448}: keep it"] = "{zone:1448}의 마른가지일족 가마솥: 보관하세요",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "예배당 서쪽, {area:2264} 주변의 스컬지는 두 종류의 스컬지석을 모두 떨어뜨립니다. 그들에게서 대로우샤이어의 영혼이 솟아오르니 하나하나 대화해 풀어 주세요.\n주의: {npc:10411}은(는) 전투 밖에서는 보이지 않으며, 싸움이 시작되면 바위날개 가고일을 부릅니다. 3마리만 있으며 15분마다 다시 나타납니다.",
	-- ["The Winterfall camp"] = "눈사태일족 야영지",
	-- ["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "눈사태일족 펄볼그 마을은 {area:2255} 동쪽에 있습니다. 주술사(56-57), 보초(55-56), 펄볼그(57-58) 모두 당신보다 높습니다. 치유하는 주술사를 먼저 처치하고, 가장자리부터 끌어오세요. 뒤쪽 동굴의 {npc:10738}은(는) 정예이니 들어가지 마세요.",
	-- ["The next guide starts here and flies to {area:3197}."] = "다음 가이드는 여기서 시작해 {area:3197}(으)로 날아갑니다.",
	-- ["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "폐허는 {area:2253} 남쪽의 얼어붙은 호수 주변에 있습니다. 폐허에 놓인 유물 조각 네 개를 줍고, 올빼미야수가 돌아다니는 땅에서 달빛 깃든 깃털을 주우세요.",
	-- ["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "인형 조각 세 개는 {area:2262}의 무너진 집들에 있습니다. 하나를 주울 때 유령이 나타날 수 있습니다. 조각을 합쳐 인형을 만드세요.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "서쪽 눈사태일족 야영지는 {npc:11556}와(과) {npc:9298} 사이의 언덕에 있습니다. 이곳의 펄볼그는 누구든 {item:12771}(약 10분의 1 확률)을, 드물게 {quest:8471}을(를) 떨어뜨릴 수 있습니다. 떨어진 것을 오른쪽 클릭하세요. 펄볼그가 떨어뜨리는 {quest:6031}은(는) 메일로쉬를 위해 보관하세요.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Top up here first to level 55 on its Pathfinders (53-54) at the camp's edge: the Den Watchers inside are 55-56. Killing them raises your Timbermaw reputation and fills your bags with {item:14047} for Meilosh. Or, with a group, run {area:1584} or {area:2577} instead."] = "서쪽 눈사태일족 야영지는 {npc:11556}와(과) {npc:9298} 사이의 언덕에 있습니다. 먼저 야영지 가장자리의 눈사태일족 길잡이(53-54)를 잡아 55레벨까지 올리세요. 안쪽의 눈사태일족 굴 감시자는 55-56레벨입니다. 이들을 처치하면 나무구렁 평판이 오르고, 메일로쉬에게 줄 {item:14047}도 가방에 쌓입니다. 파티가 있다면 대신 {area:1584}이나 {area:2577}을(를) 도세요.",
	-- ["The western Winterfall furbolgs drop the beads."] = "서쪽 눈사태일족 펄볼그가 구슬을 떨어뜨립니다.",
	-- ["The {area:2247}"] = "{area:2247}",
	-- ["To {zone:1455}"] = "{zone:1455}(으)로",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for. Or, with a group, run {area:1584} or {area:2577} instead."] = "{area:2255}에서 퀘스트를 제출하기 전에 여기서 55.05레벨까지 올리세요. 제출하면 56레벨이 됩니다. {area:2246} 옆에 진을 친 눈사태일족 펄볼그(길잡이, 토템술사, 굴 감시자)를 사냥하세요. 이들을 처치하면 이곳 퀘스트와 {area:1769} 통과에 필요한 나무구렁 평판이 오르고, 그중 하나가 {quest:8471}을(를) 떨어뜨리며, 메일로쉬가 요구하는 룬무늬 옷감 30개도 모입니다. 파티가 있다면 대신 {area:1584}이나 {area:2577}을(를) 도세요.",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "{area:1769}을(를) 지나 {zone:1448}(으)로 간 뒤 동부 왕국으로 날아가세요({area:442}, {area:150}행 배). {area:271}(으)로 날아가 알터랙을 지나는 길을 따라 북쪽으로 {area:3197}까지 가세요.",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there at 47, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "귀환석이 {zone:1455}에 설정되어 있지 않습니다({zone:1425} 가이드는 47레벨에 그곳에 귀환 지점을 정하고, 이 가이드는 그곳을 통해 {zone:1452}을(를) 떠납니다). 대신 마을로 돌아올 때를 위해 {area:2255}에 귀환 지점을 정하세요.",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "귀환석이 {zone:1455}에 설정되어 있지 않습니다({zone:1425} 가이드가 그곳에 귀환 지점을 정하고, 이 가이드는 그곳을 통해 {zone:1452}을(를) 떠납니다). 대신 마을로 돌아올 때를 위해 {area:2255}에 귀환 지점을 정하세요.",
	-- ["Your Hearthstone is still set at {zone:1455}: from there the gryphon to {area:3197} is about ten minutes quicker than {area:2255}'s flight to Theramore and the boat."] = "귀환석이 아직 {zone:1455}에 설정되어 있습니다. 그곳에서 {area:3197}행 그리폰을 타는 것이 {area:2255}에서 테라모어 섬으로 날아가 배를 타는 것보다 약 10분 빠릅니다.",
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "잴다르는 정예이니 파티를 권장합니다. 그는 지역 남서쪽의 지하실인 {area:2261}의 맨 아래에서 기다립니다.",
	-- ["grind on {npc:7442}"] = "{npc:7442} 사냥",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "{zone:1452}의 {area:2247}에서 {npc:7460}을(를) 사냥하세요",
	-- ["{area:150} flight master"] = "{area:150} 비행 조련사",
	-- ["{area:199} cauldron"] = "{area:199} 가마솥",
	-- ["{area:2247}: kill these as you meet them"] = "{area:2247}: 만나는 대로 처치하세요",
	-- ["{area:2255} flight master"] = "{area:2255} 비행 조련사",
	-- ["{area:2255}'s inn"] = "{area:2255} 여관",
	-- ["{area:489} flight master"] = "{area:489} 비행 조련사",
	-- ["{item:12771}, a rare drop"] = "{item:12771}, 드문 전리품",
	-- ["{npc:10301}'s supplies"] = "{npc:10301}의 보급품",
	-- ["{npc:10431}: keep both for the Plaguelands; inside"] = "{npc:10431}: 둘 다 역병지대를 위해 보관하세요. 안",
	-- ["{npc:10431}: keep it for the Plaguelands; inside"] = "{npc:10431}: 역병지대를 위해 보관하세요. 안쪽",
	-- ["{npc:10926}'s doll"] = "{npc:10926}의 인형",
	-- ["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}: {area:2262}을(를) 위해 보관하세요",
	-- ["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583}와(과) {npc:10977}은(는) 나중에",
	-- ["{npc:11038}: Zaeldarr is a level 54 elite"] = "{npc:11038}: 추방자 자엘다르는 54레벨 정예입니다",
	-- ["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "{npc:11063}의 다음 임무는 {area:2264}의 57-60레벨 스컬지 사이에서 해야 하니 건너뛰세요.",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556}은(는) {npc:9298} 북서쪽의 {area:1769} 입구를 지킵니다.",
	-- ["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556}은(는) {area:1769} 터널의 {zone:1452} 쪽 출구, 나오는 바로 그 자리에 서 있습니다.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: 흰개미는 나중에 {area:2627}에서 모읍니다",
	-- ["{npc:11629}: keep it for {area:2262}; inside"] = "{npc:11629}: {area:2262}을(를) 위해 보관하세요. 안",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250}은(는) 정예이니 파티를 권장합니다. 그는 지역 남서쪽의 지하실인 {area:2261}의 맨 아래에서 기다립니다.",
	-- ["{npc:9616} works in the {object:32356}: hand him {zone:1448}'s ooze jars now, on your way through."] = "{npc:9616}은(는) 탐험가의 전당에서 일합니다. 지나가는 길에 {zone:1448}의 수액 단지를 지금 건네주세요.",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{quest:5152}, {area:28}에서: 보관하세요",
	-- ["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, {zone:1422}에서: 보관하세요",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}, 나중에 메일로쉬에게",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}, 드문 전리품",
	-- ["{zone:1455} flight master"] = "{zone:1455} 비행 조련사",
	-- ["{zone:1455} inn"] = "{zone:1455} 여관",
}
