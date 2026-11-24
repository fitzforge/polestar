-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1446} Tanaris · {area:976} Gadgetzan
	["{zone:1446} first ({area:976} hand-ins), then into Un'Goro. For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. This first visit keeps to the crater's eastern half, where the beasts are 48-52, so pull them one at a time; the pylons, the bones and the hive wait for the later Un'Goro visit at about 54."] = "先去{zone:1446}（在{area:976}交任務），再進入安戈洛。適合49到50級的角色，但這裡的大多數任務是51-53級：這是刻意安排的，為了它們的經驗值。第一次來只在環形山東半部活動，那裡的野獸為48-52級，所以一次拉一隻；水晶塔、骨頭和蟲巢留到約54級再來安戈洛時處理。",

	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飛往{area:150}",

	-- Step 3: Theramore
	["Theramore"] = "塞拉摩",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616}站在船靠岸的碼頭上。",

	-- Step 4: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飛往{area:392}",
	-- {npc:7771} Marvon Rivetseeker · {item:10556} Stone Circle · {area:392} Ratchet · {area:976} Gadgetzan
	["{npc:7771}'s {item:10556} stands in {area:392}: fly there first, then on to {area:976}."] = "",
	["Theramore flight master"] = "塞拉摩飛行管理員",

	-- Step 5: The Stone Circle
	-- {quest:3444} The Stone Circle
	["{quest:3444} stands on the hill just south-west of the flight master."] = "",

	-- Step 6: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飛往{area:976}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}飛行管理員",

	-- Step 8: Gadgetzan
	-- {area:976} Gadgetzan
	["The flight lands in {area:976}."] = "",

	-- Step 9: Marin Noggenfogger
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "你在路線之前來這裡時錯過了這一步：現在先做它。它很快，還會開啟後面的任務。",

	-- Step 11: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "向西騎到沙丘中的森提帕爾蟲巢。任何森提帕爾都可能掉落昆蟲部位。\n小心：森提帕爾群居蠍在戰鬥中和戰鬥外都會施放{npc:4196}，召來打斷你的小怪。",

	-- Step 12: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "向南騎到食人魔營地。裡面滿是蠻兵和執行者（46-48級）；{npc:12046}（49級）站在中間，周圍有守衛：先清掉他們。",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "{npc:12046}，地下",

	-- Step 13: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "{quest:3362}：遇到就殺",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride west into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley.\nCareful: the thistleshrubs wander a lot, so you can easily pull extra mobs."] = "向西騎進{quest:3362}。露水收集者會掉落腺體；只有部分是滿的，所以留下飽滿的那個。長瘤的灌木獸和塑根者也在這座山谷。\n小心：灌木獸到處遊走，很容易多拉到怪。",

	-- Step 14: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back north-east to {area:976}: {npc:11758} stands on the east side of town."] = "向東北騎回{area:976}：{npc:11758}站在鎮上東側。",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}，在裡面",

	-- Step 15: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:10556} Stone Circle
	["On the ride south, {npc:7771}'s dig camp stands at the {area:1938}: hand him the {item:10556}."] = "",
	-- {npc:7771} Marvon Rivetseeker · {area:1417} Sunken Temple
	["{npc:7771}'s next task, Into the Depths, is inside the {area:1417}: skip it."] = "",

	-- Step 16: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "向南騎過{area:1938}前往{area:981}，也就是哈札里的隧道；謝申克的設備在深處。\n小心：有一隻蟲子守著設備。許多蟲子在隧道裡巡邏，有些是50級，所以戰鬥常常會引來額外的怪。",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "{item:8593}；地下",

	-- Step 17: Gadgetzan
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus · {zone:1448} Felwood
	["For {npc:7740} in {zone:1457}, on the {zone:1448} guide's {zone:1457} stop: keep it"] = "",

	-- Step 19: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "從{area:976}向西出發，前往通往{zone:1449}的長坡道。{npc:9619}在坡道底部紮營，位於環形山東南角。",

	-- Step 20: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder · {item:280459} Crystal Infused Scale
	-- plural, as words: Venomhide Ravasaurs = {npc:6508} Venomhide Ravasaur
	["The dead Threshadon lies by the water north of {npc:9619}.\nCareful: Venomhide Ravasaurs (50-51) hunt along the water there: pull them one at a time before you loot the carcass.\nAny ravasaur may drop a {item:280459}: right-click it, {npc:9619} takes it."] = "死掉的長頸龍躺在{npc:9619}北邊的水邊。\n小心：毒皮暴掠龍（50-51級）在那一帶水邊獵食：拾取屍體前先一次拉一隻清掉。\n任何暴掠龍都可能掉落{item:280459}：右鍵點擊它，{npc:9619}會收下。",

	-- Step 21: Torwa Pathfinder
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale"] = "{quest:87494}，如果暴掠龍掉落了鱗片",
	-- {area:1943} Ironstone Plateau
	-- was: ["The gorillas on {area:1943} carry the pelts: keep it for the second Un'Goro visit, around 56"] = "{area:1943}的猩猩身上帶有毛皮：保留此任務，留待第二次來安戈洛時（約56級）完成"
	["The gorillas on {area:1943} carry the pelts: keep it for the second Un'Goro visit, around 54"] = "",

	-- Step 22: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "拉克維的配偶與木筏",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "拉克維的配偶在{npc:9619}西邊的叢林中徘徊。破碎的木筏在那裡的湖岸上；小包就在旁邊的水裡。把指南針、地圖和鑰匙留給{npc:8737}。環形山的任何野獸都可能掉落{item:11116}：右鍵點擊它。",
	-- {object:161504} A Small Pack
	["{object:161504}, underwater"] = "{object:161504}，水下",

	-- Step 23: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Back east to {npc:9619} with the glands."] = "帶著腺體向東回到{npc:9619}。",

	-- Step 24: Marshal's Refuge
	-- {npc:271301} Power Crystal · {object:157936} Un'Goro Dirt Pile
	["Ride north-west to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "向西北騎到避難營。\n遠離精英魔暴龍和劍龍。從現在起，拾取沿途經過的每一個{npc:271301}和{object:157936}。",
	-- {npc:9998} Shizzle
	["{npc:9998}: his scales come from the young beasts of the eastern jungle"] = "{npc:9998}：他要的鱗片來自東部叢林的幼獸",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}，在避難營深處",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "在{zone:1452}的{npc:9298}處完成：保留此任務",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117}，在洞穴深處；在地下",
	-- {npc:9272} Spark Nilminer · {npc:9271} Hol'anyee Marshal · {npc:9270} Williden Marshal · {npc:9618} Karna Remtravel
	-- was: ["{npc:9272}, {npc:9271}, {npc:9270} and {npc:9618} have quests among mobs of 51-55: leave them for the later Un'Goro visit, at about 56."] = "{npc:9272}、{npc:9271}、{npc:9270}和{npc:9618}的任務在51-55級怪物之間：留待之後約56級再來安戈洛時完成。"
	["{npc:9272}, {npc:9271}, {npc:9270} and {npc:9618} have quests among mobs of 51-55: leave them for the later Un'Goro visit, at about 54."] = "",

	-- Step 25: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537}與東部叢林",
	-- {quest:3764} Un'Goro Soil · {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:9165} Fledgling Pterrordax
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher · Living Blazes = {npc:6521} Living Blaze · Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride east into the eastern jungle: Bloodpetal Lashers and Threshers (48-50) drop the petals and {quest:3764}. Crystal clusters stand all over the crater, many around the foot of {area:537}: take a few extra of each colour.\nCareful: the Living Blazes (54-55) walk the top of {area:537}, and the Bloodpetal Flayers and Trappers (51-53) hold the jungle's south: take your crystals from the ridge's foot and your petals in the north.\n{npc:9998}'s scales: the {npc:9165} (48-50) glide over the north-east of the jungle and the Young Diemetradons (49-50) graze beside them. There are only ten of those: the Diemetradons (51) on the jungle's western edge, a short way west of the Threshers, drop the scales too. They are a level over you: take them one at a time."] = "向東騎進東部叢林：血瓣花鞭笞者和血瓣花打穀者（48-50）會掉落花瓣和{quest:3764}。水晶簇遍布整個環形山，{area:537}山腳周圍特別多：每種顏色都多拿幾個。\n小心：有生烈焰（54-55）在{area:537}頂上走動，血瓣花撕掠者和血瓣花捕獵者（51-53）佔據叢林南部：水晶在山脊腳下採，花瓣在北部打。\n{npc:9998}的鱗片：{npc:9165}（48-50）在叢林東北部上空滑翔，幼雙帆龍（49-50）就在旁邊吃草。後者只有十隻：叢林西緣、打穀者西邊不遠處的雙帆龍（51）也會掉落鱗片。牠們比你高一級：一次打一隻。",
	-- {item:11316} Bloodpetal
	["{item:11316}, from the Lashers and Threshers"] = "{item:11316}，來自鞭笞者和打穀者",
	-- {quest:3764} Un'Goro Soil
	["{quest:3764}, from the Threshers and the dirt piles"] = "{quest:3764}，來自打穀者和泥土堆",

	-- Step 26: Lakkari Tar Pits
	-- plural, as words: Tar Lords = {npc:6519} Tar Lord
	["Crystal clusters stand all over the crater. The pits' Tar Lords (53-54) and the oozes around them (50-54) are over you: take the clusters on the jungle's north-eastern edge, among the Lashers and young beasts (48-50)."] = "水晶簇遍布整個環形山。焦油坑的焦油獸王（53-54）和周圍的軟泥怪（50-54）等級比你高：去叢林東北緣，在鞭笞者和幼獸（48-50）之間採水晶簇。",

	-- Step 27: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}，地下",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "交給{zone:1444}的{npc:7775}：保留此任務",

	-- Step 28: Level 50
	["Level 50"] = "",
	-- {zone:1455} Ironforge
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Still short of level 50 after the refuge's hand-ins? The next guide opens in {zone:1455} with quests that need level 50: top up on the Bloodpetal Lashers and Threshers (48-50) of the eastern jungle, where you took the petals, before you leave the crater."] = "",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "刷{npc:6511}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Archesonus stands beside King Magni in the {object:171709}."] = "阿克瑟努斯站在{object:171709}的國王麥格尼身旁。",
	-- ["Below ground"] = "地下",
	-- ["Bind and train"] = "綁定爐石並訓練",
	-- ["Bones and equipment"] = "骨頭與裝備",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "穿越環形山南部，前往坡道旁的{npc:9619}。",
	-- ["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "恐龍骨頭散落在西南部的劍龍群中：劍龍是精英，在牠們周圍撿骨頭，其餘的從雙帆龍身上取得。探險隊的{item:11112}在西南部叢林。",
	-- ["Eastern Pylon"] = "東部水晶塔",
	-- ["Escort {npc:9999}"] = "護送{npc:9999}",
	-- ["Fly from {area:144} to {area:1537}."] = "從{area:144}飛往{area:1537}。",
	-- ["Fly to {area:1537}"] = "飛往{area:1537}",
	-- ["Fly to {area:415}"] = "飛往{area:415}",
	-- ["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. The crater's beasts are 48-55 and the Gorishi silithids 51-54, so pull them one at a time."] = "適合49到50級的角色，但這裡的大多數任務是51-53級：這是刻意安排的，為了它們的經驗值。環形山的野獸為48-55級，格里什異種蟲為51-54級，所以一次拉一隻。",
	-- ["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. This first visit keeps to the crater's eastern half, where the beasts are 48-52, so pull them one at a time; the pylons, the bones and the hive wait for the later Un'Goro visit at about 56."] = "適合49到50級的角色，但這裡的大多數任務是51-53級：這是刻意安排的，為了它們的經驗值。第一次來只在環形山東半部活動，那裡的野獸為48-52級，所以一次拉一隻；水晶塔、骨頭和蟲巢留到約56級再來安戈洛時處理。",
	-- ["For {npc:7740} in {zone:1457}, at the end of the {zone:1428} guide: keep it"] = "在{zone:1428}指南的最後，交給{zone:1457}的{npc:7740}：留著它",
	-- ["Four rune rubbings in {zone:1447}: keep it"] = "在{zone:1447}拓印四個符文：保留此任務",
	-- ["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "從{area:144}飛往{area:150}，搭船到塞拉摩，再飛往{area:976}。{npc:9619}在環形山的第一個任務需要等級48：若等級不足，先在這裡練完這一級。",
	-- ["Grind to 50"] = "練到50級",
	-- ["Grind to 51"] = "練到51級",
	-- ["Gryfe"] = "葛萊夫",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "帶{npc:9999}向北前往{area:541}。他昏倒時，對他使用{item:11804}把他叫醒。",
	-- ["Level 49.79"] = "等級 49.79",
	-- ["Northern Pylon"] = "北部水晶塔",
	-- ["Pterrordax"] = "翼手龍",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "沿坡道騎下環形山：{npc:9619}在坡道底部紮營。",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "向東騎往{area:1943}，機器人站在猩猩群中。不要進入那裡的深洞。",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "向東騎往{area:537}，爬上去，在山頂附近的熔岩噴口使用{npc:10541}。",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "沿東側向北騎往猩猩高地。55級的猩猩{npc:9622}在最深的洞穴裡：先清掉洞口的猩猩。",
	-- ["Ride north along the western jungle back to the refuge."] = "沿西部叢林向北騎回避難營。",
	-- ["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "向北騎往{area:1943}，機器人站在猩猩群中。不要進入那裡的深洞。",
	-- ["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "沿東面懸崖向南騎往坡道底部的{npc:9619}。",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales. The crate sits at the abandoned camp in the eastern jungle."] = "沿東側向南騎。幼雙帆龍在東部叢林覓食，{npc:9165}在東面懸崖附近飛行；兩者都會掉落{npc:9998}要的鱗片。箱子在東部叢林的廢棄營地裡。",
	-- ["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "向南騎往環形山中央的{area:537}，然後向東進入東部叢林。水晶簇遍布整個環形山，許多在{area:537}周圍：每種顏色多拿幾個。血瓣花鞭笞者和血瓣花猛擊者會掉落花瓣；探險隊的{item:11113}在東部叢林中一處廢棄的營地裡。",
	-- ["Ride west back to the refuge."] = "向西騎回避難營。",
	-- ["Ride west back to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "向西騎回避難營。\n遠離精英魔暴龍和劍龍。從現在起，拾取沿途經過的每一個{npc:271301}和{object:157936}。",
	-- ["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "從{npc:9619}向西騎：異種蟲巢穴佔據環形山南部。在孵化室（掛著幼蟲的洞室）使用未使用的採集瓶。格里什異種蠍和格里什工蠍會掉落{quest:3764}；若還需要擊殺數，{npc:9166}在南面懸崖築巢。",
	-- ["Ride west out of {area:976} to the long ramp down into {area:490}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "從{area:976}向西出發，前往通往{area:490}的長坡道。{npc:9619}在坡道底部紮營，位於環形山東南角。",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "向西經過{area:541}，再沿西側向南前往{area:543}：哥布林{npc:10302}坐在水邊。",
	-- ["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "組隊打{area:1417}代替練等能更快達到目標。單人練等請跳過此步驟。",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "組隊打{area:978}代替練等能更快達到目標。這座食人妖城市位於{zone:1446}西北部，就在{area:976}北邊。",
	-- ["Still short of level 49.79 after the refuge's hand-ins? Top up on the Bloodpetal Lashers and Threshers (48-50) of the eastern jungle, where you took the petals, before you leave the crater."] = "交完避難營的任務後仍不到49.79級？離開環形山前，先在東部叢林（你打花瓣的地方）的血瓣花鞭笞者和打穀者（48-50）身上練一下。",
	-- ["Still short of level 49.79 after the refuge's hand-ins? Top up on the Pterrordax on the slopes east of {area:541} before you leave the crater."] = "交完避難營的任務後仍不到49.79級？離開火山口前，先在{area:541}東邊山坡上的翼手龍身上練一下。",
	-- ["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "森提帕爾異種蟲在{zone:1446}西部的{area:982}周圍爬行，就在環形山坡道東邊。工蠍最容易拉。",
	-- ["The Gorishi hive"] = "格里什蟲巢",
	-- ["The dead Threshadon lies by the water north of {npc:9619}."] = "死去的蛇頸龍躺在{npc:9619}北邊的水邊。",
	-- ["The east side"] = "東側",
	-- ["The flight from Theramore lands in {area:976}."] = "從塞拉摩起飛的航班降落在{area:976}。",
	-- ["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "猩猩住在{area:541}東邊的{area:1943}。把牠們的毛皮留給{npc:9619}。不要進入最深的洞穴：{npc:9622}是55級。",
	-- ["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "{area:1943}的猩猩成小群出現，目前還不會為你掉落任何東西；{npc:9619}的毛皮任務稍後才有。不要進入最深的洞穴：{npc:9622}是55級。",
	-- ["The gorillas on {area:1943} carry the pelts: keep it for the second Un'Goro visit, around 56"] = "{area:1943}的猩猩身上帶有毛皮：保留此任務，留待第二次來安戈洛時（約56級）完成",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "毛皮在第二輪之後，到猩猩高地取得",
	-- ["The pylon stands on the eastern cliffs."] = "水晶塔位於東面懸崖上。",
	-- ["The pylon stands on the slope east of the refuge. Pterrordax circle the slopes around it: they count for Spraggle and drop {npc:9998}'s scales."] = "水晶塔位於避難營東邊的山坡上。翼手龍在周圍山坡盤旋：擊殺牠們算入斯普拉格的任務，並會掉落{npc:9998}要的鱗片。",
	-- ["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "水晶塔位於西面懸崖上。{npc:9167}在整個西側上空飛行。",
	-- ["The relics are in the {zone:1428}: keep it"] = "聖物在{zone:1428}：保留此任務",
	-- ["The wooden sign beside {npc:9997}"] = "{npc:9997}旁邊的木牌",
	-- ["The {zone:1455} quests were taken at the end of the {zone:1427} guide: fly straight on to {zone:1440} for {zone:1447}."] = "{zone:1455}的任務已在{zone:1427}指南結尾接取：直接飛往{zone:1440}，前往{zone:1447}。",
	-- ["To {zone:1455}"] = "前往{zone:1455}",
	-- ["Western Pylon"] = "西部水晶塔",
	-- ["Xiggs waits in the {object:32359}."] = "希格斯在{object:32359}等候。",
	-- ["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "在{area:976}周圍擊殺廢土強盜或砂槌巨魔練等",
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "在{zone:1446}的{area:982}擊殺{npc:5458}練等",
	-- ["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "在{zone:1449}的{area:1943}擊殺{npc:6514}練等",
	-- ["{area:442} flight master"] = "{area:442}飛行管理員",
	-- ["{area:541} flight master"] = "{area:541}飛行管理員",
	-- ["{area:978} (optional)"] = "{area:978}（可選）",
	-- ["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}：交給{zone:1447}的奧汀克，保留此任務",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}：上一份指南用爐石把你送到這裡，所以這一步通常會立即完成",
	-- ["{npc:7312}, the mage trainer: for {npc:8395} in {zone:1447}, keep it"] = "{npc:7312}，法師訓練師：給{zone:1447}的{npc:8395}，留著",
	-- ["{npc:9272}, {npc:9271}, {npc:9270} and {npc:9618} have quests among mobs of 51-55: leave them for the later Un'Goro visit, at about 56."] = "{npc:9272}、{npc:9271}、{npc:9270}和{npc:9618}的任務在51-55級怪物之間：留待之後約56級再來安戈洛時完成。",
	-- ["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}：軟泥怪在{zone:1448}，保留此任務",
	-- ["{npc:9618} stands just outside the refuge."] = "{npc:9618}就站在避難營外。",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "{npc:9684}的巢穴位於{npc:9619}北邊的叢林，在東面懸崖下方：在那裡使用{item:11568}。{npc:9684}是56級：滿血再開打。",
	-- ["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9997}的朋友{npc:9999}失蹤了。",
	-- ["{npc:9998}, at the refuge entrance"] = "{npc:9998}，在避難營入口",
	-- ["{npc:9998}, at the refuge's entrance"] = "{npc:9998}，在避難營入口",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}坐在環形山中央{area:537}的東南坡上。",
	-- ["{zone:1455} flight master"] = "{zone:1455}飛行管理員",
}
