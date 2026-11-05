-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 2: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "从安戈洛环形山出来的山口通往{area:3077}，那是{zone:1451}东北部的墓地。{npc:13220}站在坟墓之间。",

	-- Step 3: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "向西南骑往{area:2738}的废墟。给{npc:11801}的{object:179565}在其中一座毁坏的房子里。",

	-- Step 5: Cenarion Hold
	["Ride west to the walled hold in the middle of the desert."] = "向西骑往沙漠中央有城墙环绕的塞纳里奥要塞。",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}，在要塞西侧",

	-- Step 6: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "",

	-- Step 7: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "",

	-- Step 9: On the way
	["On the way"] = "",

	-- Step 10: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "回到南风村，爬上塔。搅动塔顶的虫巢会引出亚什伏击者；其中一个携带{item:17346}。",

	-- Step 11: The Spirits of Southwind
	["Inside"] = "",

	-- Step 12: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "向东南骑往安戈洛悬崖下的{area:3447}。",
	["Below ground"] = "",

	-- Step 13: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "掘泥摧毁者和巨钳蝎",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "沿西部沙丘向北；掘泥摧毁者和石鞭巨钳蝎分布在从这里到要塞的一带。",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "",

	-- Step 14: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "向西骑往{area:2744}北边的部落营地。",

	-- Step 15: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "水晶尘喷泉在南部沙漠各处喷发。走进喷泉留下的水晶尘，把它带到吉里卡营地的部落水晶尘提取器；战斗或骑上坐骑都会让它掉落。",

	-- Step 16: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "石鞭掠夺者和石行蜘蛛",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "石鞭掠夺者和石行蜘蛛在吉里卡营地西南的沙丘上游荡。",

	-- Step 17: Twilight Vanguard
	["Twilight Vanguard"] = "暮光先锋军营地",
	-- {npc:11803} Twilight Keeper Exeter · {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803}在遥远西南的暮光先锋军营地里走动。这里的每个信徒都会掉落暮光密文信，不管你有没有任务：收集二十份，十份给{npc:15306}，十份给奥泰尔。",

	-- Step 19: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200}占据着西边的营地。",

	-- Step 20: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804}站在{area:3425}西边的前哨站里。在这里的信徒身上把暮光密文信补到二十份。",

	-- Step 22: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "向东北骑往{area:3447}。",

	-- Step 23: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "诺格的背包在遥远南方的山里，过了铜须营地。精英蝎子死亡弯钩在附近巡逻：趁它走开时拿走背包。",

	-- Step 25: Twilight Base Camp
	["The spare texts from the cultists"] = "信徒身上多出来的密文信",

	-- Step 26: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "返回{area:3425}",
	-- {quest:8304} Dearest Natalia · {area:2744} Hive'Regal
	["Mar'alith's {quest:8304} needs level 58 and leads into {area:2744} among elites. Skip it."] = "",

	-- Step 28: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "向东北骑往{area:3077}；你从旁边的山口离开{zone:1451}。",

	-- Step 30: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:8737} Linken
	["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; J.D."] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "",

	-- Step 31: Frenzied Pterrordax
	-- {npc:9167} Frenzied Pterrordax
	["{npc:9167} walks around here: look inside the circle on the map"] = "",

	-- Step 32: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "",

	-- Step 33: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "",

	-- Step 34: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "",

	-- Step 36: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "",

	-- Step 37: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "",

	-- Step 38: Un'Goro Crater: kill these as you meet them
	-- {area:490} Un'Goro Crater
	["{area:490}: kill these as you meet them"] = "",
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["Careful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "",

	-- Step 39: Marshal's Refuge
	["Collie is inside it."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {npc:10980} on {npc:10977}"] = "对{npc:10977}使用{npc:10980}",

	-- Step 40: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "",

	-- Step 41: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 43: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "",

	-- Step 45: Gadgetzan
	-- {area:976} Gadgetzan · {object:142071} Egg-O-Matic
	["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "飞往{area:976}。{object:142071}立在镇中央。",

	-- Step 46: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 47: Class trainer
	["Class trainer"] = "",

	-- Step 48: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 51: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 54: Radley and Durgen
	["Radley and Durgen"] = "",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 56: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "圣契在更北边，通往{area:190}的路上。",

	-- Step 57: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 59: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "安多哈尔的哨塔和粮仓",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "向南骑进安多哈尔。{npc:10667}在城镇西侧被毁的旅店里等候。拿着{item:12815}站在四座塔的每一个门口来标记它；沿城镇边缘走。在镇中央的粮仓旁使用{item:12627}引出时光寄生虫。",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}标记{npc:10903}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}标记{npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}标记{npc:10905}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}标记{npc:10902}",

	-- Step 60: Chromie
	["Upstairs"] = "",

	-- Step 62: The Bulwark
	-- {quest:964} Skeletal Fragments · {quest:838} Scholomance
	["Dithers offers {quest:964} ({quest:838}). Skip it."] = "",

	-- Step 64: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "沿道路向东，{npc:11077}守着{area:200}的瘟疫之锅。",

	-- Step 66: Northridge Lumber Camp
	["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "向北前往伐木场；把白蚁桶放在锯木厂中央。",

	-- Step 67: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "盾牌在{npc:1855}小屋南边的{area:201}。",

	-- Step 68: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "向东骑往{area:2619}旁{npc:1855}的小屋，听他把话说完。",

	-- Step 71: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "天灾勇士",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "天灾勇士在教堂北边的{area:2270}游荡。在你杀死的每一个身上晃一晃{npc:11063}的{item:13156}：产生共鸣的头骨就是他要的。",

	-- Step 73: Hameya's scroll
	["Hameya's scroll"] = "",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "",

	-- Step 74: Pamela and the Undercroft
	-- {area:2261} Undercroft
	["Pamela and the {area:2261}"] = "",
	-- {area:2262} Darrowshire · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",

	-- Step 76: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "向西北骑往{npc:1855}的小屋。",

	-- Step 79: Level 59.14
	["Level 59.14"] = "",
	-- {quest:6135} Duskwing, Oh How I Hate Thee...
	["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan."] = "",
	-- {npc:10717} Temporal Parasite
	["grind on {npc:10717}"] = "",

	-- Step 80: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "向西南骑往安多哈尔的{npc:10667}那里。",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "{npc:10667}的达隆郡之战最后要对付精英。跳过它。",

	-- Step 81: Counting Out Time
	["Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 83: The Bulwark
	-- {area:152} The Bulwark · {zone:1458} Undercity
	["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "向西前往{area:152}。下一个指南从西边不远的{zone:1458}开始。",

	-- Step 84: Into Eastern Plaguelands
	-- {area:139} Eastern Plaguelands
	["Into {area:139}"] = "",

	-- Step 86: Of Lost Honor
	["Underwater"] = "",

	-- Step 87: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "",

	-- Step 90: Hameya's mound
	["Hameya's mound"] = "",
	-- {object:177675} Mound of Dirt · {area:2261} Undercroft
	["The {object:177675} is just behind the {area:2261}."] = "",

	-- Step 91: Into Western Plaguelands
	-- {area:28} Western Plaguelands
	["Into {area:28}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "迪瑟斯提供{item:14619}（{quest:838}）。跳过它。",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "掘泥打击者、石鞭蝎和掠沙蜘蛛共处于要塞正北的沙地上。",
	-- ["Dredge and scorpids"] = "掘泥者和蝎子",
	-- ["Fly to {area:1637} and train."] = "飞往{area:1637}训练。",
	-- ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "留着{quest:3942}：{npc:9116}在{area:2479}，下一个指南穿过{zone:1448}时会经过。",
	-- ["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "玛尔利斯的“最亲爱的纳塔莉亚”需要58级，而且要进入满是精英的{area:2744}。跳过它。",
	-- ["Ride east across the plaguelands to the chapel."] = "向东骑过瘟疫之地前往教堂。",
	-- ["Ride east along the road to the {area:152} on the border."] = "沿道路向东骑往边境上的{area:152}。",
	-- ["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "骑往西南的{area:2262}；{npc:10926}在房子间玩耍。{npc:11886}潜伏在城镇正西的墓穴{area:2261}里。",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "在{area:1637}外的塔上乘飞艇前往{zone:1420}，再骑进{zone:1458}。希尔瓦娜斯·风行者在{object:36126}。",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "发光的石板碎片散落在遥远西北的暮光营地周围；那里的灰尘风暴和沙漠奔行者也会掉落碎片。",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "穿过山口，沿北边的悬崖向东前往{area:541}。{npc:8737}站在洞穴旁；{npc:9117}在洞里。",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "向西前往{area:152}。下一个指南从西边不远的{zone:1458}开始。",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "{npc:10778}的农场是{area:152}东边的第一座农场。农场上的{npc:10801}携带她护身符的另一半；{npc:11075}守着田里的瘟疫之锅。",
	-- ["{npc:10926} and the {area:2261}"] = "{npc:10926}和{area:2261}",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "{npc:10926}自己的差事不在本路线上。跳过它。",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "{npc:11878}的差事不在本路线上。跳过它们。",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "{npc:15193}的勇士占据着{area:2261}北边{area:2260}的农舍。",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "{npc:1855}的下一个任务（失落的荣耀）不在本路线上。跳过它。",
}
