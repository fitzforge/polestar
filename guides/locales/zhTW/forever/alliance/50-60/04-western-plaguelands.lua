-- Chinese (traditional) (zhTW): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Argent Officer Pureheart
	-- {quest:5401} Argent Dawn Commission · {spell:437801} Light's Hope · {zone:1452} Winterspring
	["No {quest:5401} yet ({spell:437801} gives it on the {zone:1452} guide's way through)? Pureheart gives you one here: the scourgestone quests need it."] = "還沒有{quest:5401}？（{zone:1452}那篇指南路過時{spell:437801}會給）純淨之心會在這裡給你一個：天災石任務需要它。",

	-- Step 3: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}：遇到就殺",
	-- {quest:5401} Argent Dawn Commission · {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones while you wear the {quest:5401} (equip it as a trinket first).\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "骷髏撕掠者和被奴役的食屍鬼在營地北邊的田野遊蕩；裝備{quest:5401}時，這裡所有天譴軍都會掉落天譴石（先把它裝備在飾品欄）。\n小心：這些不死生物很遠就會發現你，拉到一隻時附近其他不死生物也會加入戰鬥。\n小心：{npc:10411}（3個重生點，15分鐘重生）脫戰時會隱形，戰鬥開始後會召喚石翼石像鬼。",

	-- Step 4: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "{npc:10927}的農舍在營地東邊的山丘上；{npc:10936}的紀念碑就在它北邊。",
	["Upstairs"] = "樓上",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}，在紀念碑旁",

	-- Step 5: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "向西北騎往達爾松的農場。日記在穀倉裡；一具遊蕩的骷髏帶著廁所的鑰匙，{npc:10836}在廁所裡等著，身上有櫃子的鑰匙。",

	-- Step 6: The Writhing Haunt: kill these as you meet them
	-- {area:202} The Writhing Haunt
	["{area:202}: kill these as you meet them"] = "{area:202}：遇到就殺",
	-- {item:12841} Invader's Scourgestone · {quest:5401} Argent Dawn Commission
	["{item:12841}: wear the {quest:5401} while you kill"] = "{item:12841}：擊殺時要裝備{quest:5401}",

	-- Step 7: Dalson's Tears
	-- {object:177289} Scourge Cauldron
	["After the farm's keys: the {object:177289} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "拿到農場的鑰匙之後：{object:177289}就在農舍西南邊不遠處，旁邊的護鍋者身上帶著鑰匙。",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "{object:175924}，在農舍裡；在裡面",

	-- Step 8: Chillwind Camp
	["Ride back south to the camp."] = "向南騎回營地。",

	-- Step 9: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "安多哈爾哨塔",
	-- {item:12815} Beacon Torch · {npc:7572} Fallen Hero of the Horde
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "在營地北邊、安多哈爾外圍的四座瞭望塔底下各使用一次{item:12815}。\n小心：骷髏督軍和血肉魔像（57，精英）在安多哈爾街上巡邏，{npc:7572}（59，精英）在安多哈爾和北谷之間遊蕩：待在鎮邊的塔旁，讓它們走過去。",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}標記{npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}標記{npc:10903}",

	-- Step 10: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667}在安多哈爾西側的旅店廢墟裡等候。",

	-- Step 11: The Andorhal watchtowers
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}標記{npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}標記{npc:10905}",

	-- Step 12: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852}是61級精英",

	-- Step 13: Andorhal
	["Andorhal"] = "安多哈爾",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite · Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass."] = "在穀倉旁使用{item:12627}引出時光寄生蟲。{quest:5154}是市政廳裡發霉的書籍之一。城裡的每具骷髏都會掉落{quest:5537}。\n小心：時光寄生蟲是55-57級，骷髏督軍和血肉魔像（57，精英）在街上巡邏：在穀倉旁一次引一隻寄生蟲，讓精英走過去。",

	-- Step 14: The Writhing Haunt cauldron
	-- {area:202} The Writhing Haunt
	["{area:202} cauldron"] = "{area:202}的瘟疫之鍋",
	-- {area:202} The Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "瘟疫之鍋位於{area:202}，在{npc:10739}的農場旁。",

	-- Step 15: Mulgris Deepriver
	["Inside"] = "在裡面",

	-- Step 16: Diseased Grizzlies
	["Diseased Grizzlies"] = "生病的灰熊",

	-- Step 17: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "給{zone:1457}的德魯伊：保留此任務",

	-- Step 18: Chillwind Camp
	-- {area:201} Gahrron's Withering · {zone:1451} Silithus
	["MacDonnell's next task, {area:201}'s cauldron, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "瑪多妮爾的下一個任務，{area:201}的大鍋，留到{zone:1451}指南的瘟疫之地行程：到時再接。",

	-- Step 19: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}，在{area:2268}：保留此任務",

	-- Step 20: Sorrow Hill: kill these as you meet them
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "{npc:1852}是精英：建議組隊。他在安多哈爾中部守護著自己的命匣。\n安多哈爾各處的瓦礫中散落著小鎖箱；每個裡面都有一隻懷錶。\n注意：食屍鬼和骷髏通常站在箱子旁，你一靠近就會攻擊。灼熱食屍鬼還會傷害附近的人，並會打破潛行。",

	-- Step 22: More watches
	["More watches"] = "更多懷錶",

	-- Step 24: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "沿著道路向北騎往北山伐木場；{npc:11610}躲在營地邊緣。",

	-- Step 25: The Scarlet Crusade
	["The Scarlet Crusade"] = "血色十字軍",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "血色醫護員、血色獵人、血色騎士和血色法師在伐木場和通往{area:190}的道路上巡邏。",

	-- Step 26: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow · {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {zone:1451} Silithus
	["{npc:11610}'s next task, {npc:11613} and {npc:11611}, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "{npc:11610}的下一個任務，{npc:11613}和{npc:11611}，留到{zone:1451}指南的瘟疫之地行程：到時再接。",

	-- Step 27: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "向東騎往邊界河：{npc:1855}住在河岸的小屋裡。",

	-- Step 28: Chillwind Camp
	["Ride south-west to the camp."] = "向西南騎回營地。",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{area:976}的{npc:5411}：保留此任務",

	-- Step 29: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "飛往{area:2268}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "{area:3197}飛行管理員",

	-- Step 31: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "向西北騎往{area:2277}邊緣的{area:2276}。",

	-- Step 32: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "霍古斯的顱骨在{area:2624}，馬杜克的劍在{area:2623}，各自位於鬼魂交戰之處；成年的瘟疫犬在兩地之間的平原上獵食。",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "{item:12956}；水下",

	-- Step 33: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}：沿途擊殺以下目標",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "向西騎往{area:2627}。瘟疫幼犬、瘟疫蝙蝠和腐肉蟲在樹林中遊蕩；在大白蟻丘裝滿{item:15042}，並擊殺更北邊的狂怒的瘟疫犬。",

	-- Step 34: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby.\nCareful: the Frenzied Plaguehounds north-east of the hut are 57-58, a level or two over you: pull them one at a time."] = "向北騎往{area:2627}。{npc:12384}住在廢棄的小屋裡，他的收據冊在附近的旅店廢墟中。\n小心：小屋東北方的狂怒的瘟疫犬是57-58級，比你高一兩級：一次拉一隻。",

	-- Step 35: Augustus the Touched
	-- {npc:8598} Frenzied Plaguehound
	["{npc:8598}, 170 yd north-east"] = "{npc:8598}，東北方170碼",

	-- Step 36: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}：遇到就殺",
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Careful: the Frenzied Plaguehounds are 57-58: pull them one at a time."] = "小心：狂怒的瘟疫犬是57-58級：一次只拉一隻。",

	-- Step 37: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "向西渡河前往{npc:1855}的小屋。",

	-- Step 39: Tirion Fordring
	["Listen to his story"] = "聆聽他的故事",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886}是精英：建議組隊",

	-- Step 40: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954}在{npc:1855}西邊{area:190}的市政廳裡：血色衛兵站得很密集。",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "{item:12954}；室內",

	-- Step 42: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "向東渡河前往{area:2261}，也就是本區西南部的地穴。{object:177667}就在裡面：它的鑰匙在遠處東北方的{npc:12248}身上，在下一份指南完成。\n小心：米庫提奧會帶來大約四隻非精英的幫手。牠們是走到墳墓那裡，而不是當場出現。",
	-- {object:177667} Torn Scroll
	["{object:177667}, below ground"] = "{object:177667}，地下",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886} (57, elite): grouping up is advised"] = "{item:14613}，來自{npc:11886}（57級，精英）：建議組隊",

	-- Step 44: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飛往{area:271}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "{area:348}飛行管理員",

	-- Step 46: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "飛往{area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "{area:442}飛行管理員",

	-- Step 47: Rut'theran Village
	-- {zone:1452} Winterspring
	["Ranshalla in {zone:1452}: keep it"] = "{zone:1452}的蘭莎爾拉：保留此任務",

	-- Step 49: The Temple Gardens
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878}和{npc:7740}站在月神殿旁；在殿內的月井裝滿{item:11682}。",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}：保留給{area:976}",

	-- Step 53: Darnassus
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "下一份指南學習技能的{zone:1455}沒有德魯伊訓練師",
	-- {zone:1457} Darnassus
	["their trainers are in {zone:1457} too"] = "他們的訓練師也在{zone:1457}",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "從{item:11020}取得十個{item:11040}",
	-- {quest:6762} Rabine Saturna · {area:493} Moonglade
	["{quest:6762} in {area:493}: keep it"] = "{area:493}的{quest:6762}：保留此任務",

	-- Step 54: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "傳送門前往{zone:1438}",

	-- Step 55: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702}飛行管理員",

	-- Step 56: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "從{area:702}飛往{area:1116}。",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}：保留給{zone:1446}",

	-- Step 58: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "坐船到{area:1108}",

	-- Step 59: Gregan Brewspewer
	-- {area:1119} Twin Colossals · {npc:7775} Gregan Brewspewer · {item:11243} Videre Elixir · {item:11242} Evoroot
	["Take the boat to the mainland and ride north-east past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "搭船回到大陸，向東北騎過{area:1119}，前往{npc:7775}的營地。他用{item:11242}釀製{item:11243}：接下他的差事來換一瓶。",

	-- Step 60: Rockbiter
	-- {npc:7765} Rockbiter · {npc:7775} Gregan Brewspewer
	["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "巨人{npc:7765}就坐在{npc:7775}營地的西北邊。",

	-- Step 61: Evoroot
	-- {item:11242} Evoroot · {npc:7765} Rockbiter
	["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "{item:11242}生長在{npc:7765}北邊一棟廢墟建築裡：從旁邊的岩架穿過牆上的破口爬進去。",

	-- Step 62: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {item:9189} Shay's Bell
	["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "向西騎進鴉風廢墟：{npc:7774}躲在後方的小圓形建築裡。打開她旁邊的箱子取得{item:9189}：效果持續15分鐘，和任務時限一樣。",

	-- Step 63: Wandering Shay
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "以步行速度把{npc:7774}帶回{npc:7765}那裡：她會走開，所以搖鈴把她叫回來（戰鬥時不行），並在她走到之前先清掉路上的鷹身人。",

	-- Step 64: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {npc:7765} Rockbiter · {item:11242} Evoroot · {npc:9298} Donova Snowden · {npc:9299} Gaeriyan · {area:976} Gadgetzan
	-- plural, as words: Videre Elixirs = {item:11243} Videre Elixir
	["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one, and {npc:9299} in {area:976} shows himself only to someone who has drunk one."] = "回到{npc:7765}東南邊不遠的{npc:7775}營地：{item:11242}可換三瓶維迪爾藥劑。留著它們：{npc:9298}要一瓶，而{area:976}的{npc:9299}只會現身給喝過藥劑的人看。",

	-- Step 66: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飛往{area:392}",
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "{area:489}飛行管理員",

	-- Step 67: Fly to Theramore
	["Fly to Theramore"] = "飛往塞拉摩",

	-- Step 68: The Barrens
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "從塞拉摩出發，向西騎入{zone:1413}，再沿海岸向北到{area:392}。",

	-- Step 69: Ratchet
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}，在城鎮北邊的海岸",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "給{zone:1448}：保留此任務",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro; inside"] = "{npc:8496}：保留給安戈洛；在裡面",

	-- Step 70: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "飛往{area:2255}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}飛行管理員",

	-- Step 72: Donova Snowden
	["Ride west along the road to the hot springs."] = "沿著道路向西騎往溫泉。",
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} in {area:976}: keep it"] = "{area:976}的{npc:9299}：保留此任務",

	-- Step 74: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {area:493} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "走進{area:1769}，沿著隧道的{area:493}岔路前往{area:2361}。",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "給{zone:1451}：保留此任務",

	-- Step 75: Sindrayl
	-- {npc:10897} Sindrayl · {area:493} Moonglade · {area:2361} Nighthaven · {zone:2482} Mount Hyjal · {zone:1451} Silithus
	["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path now; the {zone:2482} guide flies to {area:493}, and the {zone:1451} guide comes back here."] = "{area:493}的飛行管理員{npc:10897}站在湖的南邊，{area:2361}外面：現在就學會這條飛行路線；{zone:2482}指南會飛往{area:493}，{zone:1451}指南則會再回到這裡。",

	-- Step 76: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飛往{area:976}",
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["Hearth to {area:392} (bound there earlier on this guide), then fly on to {area:976}."] = "使用爐石回到{area:392}（本指南稍早已在那裡綁定），再飛往{area:976}。",

	-- Step 77: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}，室內",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "關於{npc:7583}",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "用{item:12928}嚇唬{npc:7583}",
	-- {area:3197} Chillwind Camp
	["For {area:3197}: keep it"] = "交給{area:3197}：保留此任務",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro, keep it"] = "{npc:7876}，在城鎮北邊：焦油在安戈洛，留著",

	-- Step 78: Gaeriyan
	-- {npc:9299} Gaeriyan · {item:11243} Videre Elixir
	["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299}是鎮東邊不遠墓地裡的鬼魂：在那裡喝下{item:11243}，你會死亡，釋放靈魂後以鬼魂狀態和他交談。然後跑回屍體復活：墓碑就在附近。",

	-- Step 79: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "向西南騎往{area:1938}的{npc:7771}營地。",
	-- {quest:3444} The Stone Circle · {area:392} Ratchet
	["{quest:3444} is in {area:392}"] = "{quest:3444}在{area:392}",

	-- Step 81: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "飛往{area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}飛行管理員",

	-- Step 82: Linken
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:8737} Linken · {npc:9117} J.D. Collie · {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["Fly from {area:976} to {area:541}. {npc:8737} stands at the back of the refuge; {npc:9117} is in the cave behind him.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "從{area:976}飛往{area:541}。{npc:8737}站在避難所後方；{npc:9117}在他身後的洞穴裡。\n{npc:9997}的朋友{npc:9999}失蹤了。",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}，地下",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "{npc:9997}旁邊的木牌",

	-- Step 83: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "進入{zone:1451}",

	-- Step 84: Layo Starstrike
	-- {zone:1451} Silithus · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["Ride out of the crater's north-western pass into {zone:1451}: {npc:13220} stands at {area:3077}, where the pass comes out."] = "從環形山西北的山口騎出去到{zone:1451}：{npc:13220}站在山口出來的地方、{area:3077}。",

	-- Step 86: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "繼續向西騎到{area:3425}。{npc:15189}在他那棟樓的樓上：從裡面上樓，箭頭分不清樓層。",

	-- Step 87: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}：沿途擊殺以下目標",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "掘泥打擊者在要塞西北方的沙丘中挖掘；石鞭蠍和掠沙蜘蛛在四周遊蕩。",

	-- Step 88: Level 56.89
	["Level 56.89"] = "56.89級",
	-- {item:9328} Super Snapper FX
	["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan."] = "",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "刷{npc:11740}",

	-- Step 89: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "繼續向西騎到{area:3425}。{npc:15189}在他那棟樓的樓上：從裡面上樓，箭頭分不清樓層。",
	-- {npc:15189} Beetix Ficklespragg · {npc:15191} Windcaller Proudhorn · {zone:1451} Silithus · {area:3425} Cenarion Hold
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["{npc:15189}'s and {npc:15191}'s next tasks (the Stonelash scorpids and the Dredge Crushers) wait for the {zone:1451} guide's {area:3425} stop: take them then."] = "{npc:15189}和{npc:15191}的下一個任務（石鞭蠍和掘泥摧毀者）留到{zone:1451}指南的{area:3425}站再接。",

	-- Step 90: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "被折磨的德魯伊和被折磨的哨兵在{npc:13220}西南方的廢墟村莊出沒。",

	-- Step 92: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "{area:2742}高塔",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride back south-west to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "向西南騎回{area:2738}的{area:2742}高塔；爬上去，擊殺為了異種蠍粘液包裹的物體而出現的伏擊者。",

	-- Step 93: Layo Starstrike
	-- {area:493} Moonglade
	["Umber in {area:493}: keep it"] = "{area:493}的阿姆伯爾：保留此任務",

	-- Step 95: Krakle
	-- {zone:1451} Silithus · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Coming in from {zone:1451}, {area:543} is just inside the crater: {npc:10302} the goblin sits by the water."] = "從{zone:1451}進來，{area:543}就在環形山裡側：地精{npc:10302}坐在水邊。",

	-- Step 96: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "{zone:1449}：沿途擊殺以下目標",

	-- Step 97: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "向東騎往{area:537}，爬上去，在山頂附近的熔岩噴口使用{npc:10541}。",

	-- Step 98: Krakle
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "在{zone:1452}的{npc:9298}處完成：保留此任務",

	-- Step 99: Marshal's Refuge
	-- {npc:9618} Karna Remtravel · {npc:9117} J.D. Collie
	["North to the refuge, for the quests the first Un'Goro visit left: {npc:9618} stands just outside and {npc:9117} in the cave at the back; the expedition's other three wait for your next stop here."] = "向北前往避難所，處理第一次來安戈洛時留下的任務：{npc:9618}站在外面不遠處，{npc:9117}在後方的洞穴裡；探險隊的另外三人等你下次來這裡時再找。",

	-- Step 100: Northern Pylon
	["Northern Pylon"] = "北部水晶塔",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}."] = "水晶塔位於避難所東邊的山坡上。{npc:9166}在周圍的山坡上盤旋：牠們算在{npc:9997}的任務裡。",

	-- Step 101: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "向東騎往{area:1943}，機器人站在猩猩群中。不要進入那裡的深洞。",
	["Below ground"] = "地下",

	-- Step 102: Ironstone Plateau: kill these as you meet them
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

	-- Step 104: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}：遇到就殺",
	-- {area:538} Lakkari Tar Pits
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Tar Lords = {npc:6519} Tar Lord
	["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "焦油怪和焦油領主在{area:538}裡打滾，位於避難所南邊、往下進入環形山的路上。",

	-- Step 105: The crater
	["The crater"] = "環形山",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "焦油獸在{area:538}裡打滾；中部{area:537}的火元素攜帶著灰燼；南部{area:540}的格里什黃蜂攜帶著腺體。環形山裡的每種生物都可能掉落{item:11018}。\n注意：生命值降到45%以下的格里什工蜂有50%機率呼叫25碼內的同伴支援。",

	-- Step 106: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "{npc:9619}在進入環形山的坡道腳下紮營。",
	-- {quest:4291} The Scent of Lar'korwi
	["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}，如果你身上還帶著第一次來時的任務",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "毛皮來自{area:1943}的猩猩",
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}，如果第一次來之後有暴掠龍掉落了鱗片",

	-- Step 107: Damaged Blue Crystal
	-- {item:280417} Damaged Blue Crystal · {npc:9619} Torwa Pathfinder
	["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "{item:280417}在{npc:9619}營地西邊，騎一小段路就到。",

	-- Step 110: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "大猩猩生活在{area:541}東邊的{area:1943}。把它們的毛皮留給{npc:9619}。別進最深的洞穴：{npc:9622}是55級。\n注意：安戈洛大猩猩（50-51級）生命值降到25%後會呼叫20碼內的同伴支援。該區域有一個滿是猩猩的洞穴，在那裡戰鬥會引來大量增援。",

	-- Step 112: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "沿東側向北騎往猩猩高地。55級的猩猩{npc:9622}在最深的洞穴裡：先清掉洞口的猩猩。",

	-- Step 113: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "{npc:9684}的巢穴位於{npc:9619}北邊的叢林，在東面懸崖下方：在那裡使用{item:11568}。{npc:9684}是56級：滿血再開打。",

	-- Step 114: Eastern Pylon and the crate
	["Eastern Pylon and the crate"] = "東部水晶塔與箱子",
	-- {npc:9684} Lar'korwi · {item:11113} Crate of Foodstuffs
	["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "水晶塔位於{npc:9684}巢穴上方的東面懸崖上；探險隊的{item:11113}在東部叢林的廢棄營地裡。",

	-- Step 115: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "穿越環形山南部，前往坡道旁的{npc:9619}。",

	-- Step 116: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "{area:1942}：遇到就殺",

	-- Step 117: The Gorishi hive
	["The Gorishi hive"] = "格里什蟲巢",
	["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "沿著環形山南側向西走：這裡滿是格瑞希蟲巢。在孵化室（掛著幼蟲的房間）使用刮取瓶。",

	-- Step 118: Bones and equipment
	["Bones and equipment"] = "骨頭與裝備",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "向西穿過環形山南側：恐龍骨頭散落在西南方的地上，周圍有劍龍：牠們是精英，避開牠們撿骨頭，其餘的從異齒龍身上取得。探險隊的{item:11112}在西南方的叢林裡。",

	-- Step 119: Western Pylon
	["Western Pylon"] = "西部水晶塔",
	["The pylon stands on the western cliffs."] = "水晶塔位於西面懸崖上。",

	-- Step 120: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}坐在環形山中央{area:537}的東南坡上。",

	-- Step 121: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "護送{npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "把{npc:9999}向北帶到{area:541}。他昏倒時，對他使用{item:11804}喚醒他。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal Watches"] = "安多哈爾懷錶",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "向北回到{area:202}：瘟疫之鍋現在會提供自己的任務。附近的食屍鬼會掉落細胞增強劑。",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "出發前才向{npc:11056}購買一個{item:13320}，用於費爾斯通的瘟疫之鍋：催化劑30分鐘後就會消失。",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "為{area:202}和達爾松的瘟疫之鍋再購買兩個{item:13320}，然後直接騎過去：它們30分鐘後就會消失。",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "爬上{area:190}西邊的山丘俯瞰城鎮。",
	-- ["Diseased Wolves"] = "生病的狼",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "掘泥摧毀者在更西邊挖掘；石鞭巨鉗蠍、石鞭掠奪者和石行蜘蛛在同一片沙地上狩獵。",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "在{area:618}的{npc:9298}處完成：保留此任務",
	-- ["Fly to {area:392}."] = "飛往{area:392}。",
	-- ["For {area:1377}: keep it"] = "給{area:1377}：保留此任務",
	-- ["For {zone:1453}: keep it"] = "給{zone:1453}：保留此任務",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "從{area:392}飛往{area:2255}，再向南騎往{area:2250}。",
	-- ["Radley and Durgen"] = "萊德雷與杜爾根",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "騎回{area:3197}並飛往{area:150}，搭船前往{area:442}，再飛往{area:702}；傳送門通往上方的{zone:1457}。",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "沿坡道騎下環形山：{npc:9619}在坡道底部紮營。",
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "向東騎往{area:2738}的{area:2742}高塔；爬上去，擊殺為了異種蠍粘液包裹的物體而出現的亞什伏擊者。",
	-- ["Ride east to {npc:13220}."] = "向東騎往{npc:13220}。",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "向北騎往{area:2627}。{npc:12384}住在廢棄的小屋裡，他的收據冊在附近的旅店廢墟中。",
	-- ["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "向南騎往{area:201}，{npc:11078}在那裡守護著瘟疫之鍋。",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "向西經過{area:541}，再沿西側向南前往{area:543}：哥布林{npc:10302}坐在水邊。",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "骷髏剝皮者和被奴役的食屍鬼在營地北邊的田野中遊蕩；這裡所有的天譴軍都會掉落天譴石。",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "安多哈爾各處的瓦礫堆中散落著小型保險箱；每個裡面都有一只懷錶。",
	-- ["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "搭船前往大陸，向東北騎往{area:1119}旁{npc:14637}的營地。",
	-- ["Temple of the Moon"] = "月神殿",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "瘟疫之鍋現在會提供自己的任務；周圍的骷髏會掉落骨質分離素。",
	-- ["The fields"] = "田野",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "下一份指南從{area:392}這裡開始，然後飛往{area:976}。",
	-- ["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "被縮小的巨人在{area:1119}遊蕩；海元素沿著西邊的海岸涉水而行。",
	-- ["Umber in {area:493}: keep it"] = "{area:493}的阿姆伯爾：保留此任務",
	-- ["Umber in {zone:1450}: keep it"] = "{zone:1450}的阿姆伯爾：保留此任務",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "在穀倉旁使用{item:12627}引出時光寄生蟲。{quest:5154}是市政廳裡發霉的書籍之一。城裡的每具骷髏都會掉落{quest:5537}。",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "在營地北邊、安多哈爾周圍四座哨塔的塔底各使用一次{item:12815}。",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "走進{area:1769}，沿著隧道的{area:493}岔路前往{area:2361}。",
	-- ["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "走進{area:1769}，沿著隧道的{zone:1450}岔路前往{area:2361}。",
	-- ["Zapped giants and sea elementals"] = "被縮小的巨人與海元素",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "在{zone:1422}的{area:202}擊殺{npc:1796}練等",
	-- ["{area:190} overlook"] = "{area:190}瞭望點",
	-- ["{area:199} cauldron"] = "{area:199}的瘟疫之鍋",
	-- ["{area:200} cauldron"] = "{area:200}的瘟疫之鍋",
	-- ["{area:201} cauldron"] = "{area:201}的瘟疫之鍋",
	-- ["{item:12955} lies east of the barn at {area:201}."] = "{item:12955}在{area:201}穀倉的東邊。",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}，來自{npc:11056}",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}：她的護送任務在路線稍後",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739}站在田野東北方{area:202}的農場旁。",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}的鬼魂在{area:200}西邊{area:199}的農舍旁徘徊；她的包裹就在屋裡。",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}，在禮拜堂南邊的墳墓旁",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}守護著安多哈爾西邊{area:199}的瘟疫之鍋。",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140}站在{area:2627}奧古斯圖斯的小屋旁。",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613}在{npc:11610}東邊的北山營地走動；{npc:11611}守衛著{area:190}南側通道的塔樓。\n小心：塔樓底部站著守衛，另有一名在周圍巡邏。和杜爾根開打前先清掉他們，以免他們加入戰鬥。",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}：白蟻稍後在{area:2627}處理",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}，在聯盟帳篷旁",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852}是精英：建議組隊。他在安多哈爾中央守著他的護符匣。",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "{npc:7775}的營地在{area:1119}北邊。他用{item:11242}釀製{item:11243}：接下他的差事來換一瓶。",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "{npc:7775}的營地在{area:1119}北邊。他拿到誘餌後就會販售{item:11243}。",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900}：保留給{area:440}",
	-- ["{npc:9047}, in the {area:1658}"] = "{npc:9047}，在{area:1658}",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299}在城鎮東邊的墓地等候；墓碑就在附近。",
	-- ["{quest:6762} in {area:493}: keep it"] = "{area:493}的{quest:6762}：保留此任務",
	-- ["{quest:6762} in {zone:1450}: keep it"] = "{zone:1450}的{quest:6762}：保留此任務",
}
