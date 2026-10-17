-- Chinese (traditional) (zhTW): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "從安戈洛來的山道出口在{area:3077}，也就是{zone:1451}東北部的墓地。{npc:13220}站在墳墓之間。",

	-- Step 2: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "往西南騎到{area:2738}的廢墟。要交給{npc:11801}的{object:179565}就在其中一間破屋裡。",

	-- Step 4: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "回到南風村並爬上塔。攪動塔頂的蟲巢會引出亞什伏擊者；其中一隻帶著{item:17346}。",

	-- Step 5: Cenarion Hold
	["Ride west to the walled hold in the middle of the desert."] = "往西騎到沙漠中央有城牆的城堡。",

	-- Step 6: Dredge and scorpids
	["Dredge and scorpids"] = "掘泥者與蠍子",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "掘泥打擊者、石鞭蠍和掠沙蜘蛛都在城堡北邊不遠的沙地上。",

	-- Step 7: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "發光的石碑碎片散落在極西北的暮光營地周圍；那裡的灰塵風暴和沙漠奔行者也會掉落。",

	-- Step 9: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "往東南騎到安戈洛懸崖下的{area:3447}。",

	-- Step 10: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "往西騎到{area:2744}北邊的部落營地。",

	-- Step 11: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "南部沙漠各處會有希利蘇斯之塵間歇泉噴發。走進噴發後留下的希利蘇斯之塵，把它帶到奇立卡營地的部落希利蘇斯之塵提取器；戰鬥或騎乘坐騎會讓它掉落。",

	-- Step 12: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "掠奪者與石行蜘蛛",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "石鞭掠奪者和石行蜘蛛在奇立卡營地西南的沙丘上遊蕩。",

	-- Step 13: Twilight Vanguard
	["Twilight Vanguard"] = "暮光先鋒",
	-- {npc:11803} Twilight Keeper Exeter · {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803}在極西南的先鋒營地巡邏。不論有沒有任務，這裡每個信徒都會掉落暮光加密文件：收集二十份，十份給{npc:15306}，十份給奧泰爾。",

	-- Step 14: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "掘泥摧毀者與巨鉗蠍",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "沿著西側沙丘往北走；從這裡到城堡一帶都有掘泥摧毀者和石鞭巨鉗蠍。",

	-- Step 15: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200}守在西邊的營地。",

	-- Step 16: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804}站在{area:3425}西邊的前哨站。在這裡的信徒身上把暮光加密文件補到二十份。",

	-- Step 17: Cenarion Hold
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}，在城堡西側",

	-- Step 18: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "背包在極南方的山裡，過了銅鬚營地就是。精英蠍子死亡彎鉤在附近巡邏：趁牠離開時拿走。",

	-- Step 19: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "往東北騎到{area:3447}。",
	["The spare texts from the cultists"] = "從信徒身上多拿的文件",

	-- Step 20: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "回到{area:3425}",
	-- {area:2744} Hive'Regal
	["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "瑪爾利斯的「親愛的娜塔莉雅」需要等級 58，而且要深入精英環伺的{area:2744}。跳過。",

	-- Step 21: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "往東北騎到{area:3077}；從旁邊的山道離開{zone:1451}。",

	-- Step 22: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:8737} Linken · {npc:9117} J.D. Collie
	["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "穿過山道，沿北側懸崖往東到{area:541}。{npc:8737}站在洞口旁；{npc:9117}在洞裡。",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {npc:10980} on {npc:10977}"] = "對{npc:10977}使用{npc:10980}",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "保留{quest:3942}：{npc:9116}在{area:2479}，下一份指南經過{zone:1448}時會路過。",

	-- Step 23: Gadgetzan
	-- {area:976} Gadgetzan · {object:142071} Egg-O-Matic
	["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "飛往{area:976}。{object:142071}就在鎮中央。",

	-- Step 24: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637} and train."] = "飛往{area:1637}並訓練。",

	-- Step 25: The Undercity
	-- {area:1637} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {object:36126} Royal Quarter
	["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "在{area:1637}外的塔上搭飛艇到{zone:1420}，再騎進{zone:1458}。希瓦娜斯女士在{object:36126}。",

	-- Step 26: The Bulwark
	-- {area:152} The Bulwark
	["Ride east along the road to the {area:152} on the border."] = "沿著道路往東騎到邊界上的{area:152}。",

	-- Step 27: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "{npc:10778}的農場是{area:152}以東的第一座。農場上的喋喋不休的食屍鬼身上有她護符的另一半；{npc:11075}守著田裡的大鍋。",

	-- Step 28: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "安多哈爾的哨塔與穀倉",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "往南騎進安多哈爾。{npc:10667}在鎮西側的旅店廢墟裡等著。帶著{item:12815}站在四座哨塔各自的門口來標記；沿著鎮的外緣走。在鎮中央的穀倉旁使用{item:12627}，引出時光寄生蟲。",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}標記{npc:10904}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}標記{npc:10903}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}標記{npc:10902}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}標記{npc:10905}",

	-- Step 29: The Bulwark
	-- {item:14619} Skeletal Fragments · {quest:838} Scholomance
	["Dithers offers {item:14619} ({quest:838}). Skip it."] = "迪瑟斯提供{item:14619}（{quest:838}）。跳過。",

	-- Step 30: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "沿著道路往東，{npc:11077}守著{area:200}的大鍋。",

	-- Step 31: Northridge Lumber Camp
	["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "往北到伐木場；把白蟻桶放在鋸木廠中央。",

	-- Step 32: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "聖契在更北邊，前往{area:190}的路上。",

	-- Step 33: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "往東騎到{area:2619}旁{npc:1855}的小屋，聽他把話說完。",

	-- Step 34: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "盾牌在{npc:1855}小屋南邊的{area:201}。",

	-- Step 35: Light's Hope Chapel
	["Ride east across the plaguelands to the chapel."] = "往東穿過瘟疫之地到禮拜堂。",

	-- Step 36: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "天災勇士",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "天災勇士在禮拜堂北邊的{area:2270}遊蕩。每殺一隻就用{npc:11063}的{item:13156}掃過屍體：產生共鳴的頭骨就是他要的。",

	-- Step 38: Pamela Redpath and the Undercroft
	-- {npc:10926} Pamela Redpath · {area:2261} Undercroft
	["{npc:10926} and the {area:2261}"] = "{npc:10926}與{area:2261}",
	-- {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "騎到西南方的{area:2262}；{npc:10926}在房屋之間玩耍。{npc:11886}潛伏在{area:2261}，就是鎮西邊不遠的墓穴。",
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s own errand is not on this route. Skip it."] = "{npc:10926}自己的差事不在這條路線上。跳過。",

	-- Step 39: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "{npc:15193}的勇士守在{area:2261}北邊的{area:2260}農舍。",
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}' errands are not on this route. Skip them."] = "{npc:11878}的差事不在這條路線上。跳過。",

	-- Step 40: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "往西北騎到{npc:1855}的小屋。",
	-- {npc:1855} Tirion Fordring
	["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "{npc:1855}的下一個任務「失落的榮耀」不在這條路線上。跳過。",

	-- Step 41: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "往西南騎到安多哈爾找{npc:10667}。",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "{npc:10667}的達隆郡之戰最後要對付精英。跳過。",

	-- Step 42: The Bulwark
	-- {area:152} The Bulwark · {zone:1458} Undercity
	["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "往西到{area:152}。下一份指南從往西騎不遠的{zone:1458}開始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride east along the road to the {area:152} on the border."] = "沿著道路往東騎到邊界上的{area:152}。",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "往西到{area:152}。下一份指南從往西騎不遠的{zone:1458}開始。",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "{npc:10778}的農場是{area:152}以東的第一座。農場上的喋喋不休的食屍鬼身上有她護符的另一半；{npc:11075}守著田裡的大鍋。",
}
