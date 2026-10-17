-- Chinese (traditional) (zhTW): the guide forever/horde/50-60/01-un-goro-crater (forever/horde/50-60/01-un-goro-crater.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Un'Goro Crater
	-- {zone:1449} Un'Goro Crater
	["Into {zone:1449}"] = "進入{zone:1449}",
	-- {area:1938} Broken Pillar · {zone:1449} Un'Goro Crater · {area:541} Marshal's Refuge
	["From the {area:1938} ride west to the long ramp that winds down into {zone:1449}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "從{area:1938}向西騎到蜿蜒而下進入{zone:1449}的長坡道，然後沿著環形山北壁前往{area:541}，一個位於懸崖洞穴中的營地。這裡的所有人都是中立的。",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "{npc:9997}旁邊的木牌",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave"] = "{npc:9117}，在洞穴深處",

	-- Step 2: Out of the refuge
	["Out of the refuge"] = "離開避難營",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}，在避難營入口",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "{npc:9618}，就在外面",
	-- {quest:3761} Un'Goro Soil
	["From here on pick up every Power Crystal (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "從現在起，拾取沿途經過的每一個能量水晶（藍、綠、紅、黃）和每一堆{quest:3761}：共25份土壤，20份給哈繆爾，5份給匹斯特蘇格。",

	-- Step 3: Lakkari Tar Pits
	-- {item:11834} Super Sticky Tar
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "焦油坑就在避難營南邊。焦油獸、焦油潛伏者和焦油爬行者會掉落{item:11834}。",

	-- Step 4: Western jungle
	["Western jungle"] = "西部叢林",
	-- {npc:9167} Frenzied Pterrordax
	-- plural, as words: Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "沿著西側懸崖向西南騎。{npc:9167}在西側上空飛行，血瓣花捕獸者生長在同一片叢林裡。",

	-- Step 5: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "劍龍與暴掠龍",
	-- {npc:9998} Shizzle · {npc:8659} Jes'rimon
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon."] = "在溫泉南邊，劍龍在吃草，恐龍骨頭由牠們掉落或散落在地上；附近的雙帆龍帶著{npc:9998}要的鱗片。暴掠龍在西南方成群狩獵：牠們的爪子交給{npc:8659}，偶爾還會帶著被撕破的日記（稀有掉落：只有拿到時才接它的任務）。避開格魯夫，一頭57級的劍龍。",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}，稀有掉落",
	["Use the Mangled Journal to start it"] = "使用被撕破的日記開始任務",

	-- Step 6: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "探險隊遺失的設備在西南方的叢林裡。",

	-- Step 7: The Gorishi hive
	["The Gorishi hive"] = "格里什蟲巢",
	-- {npc:9166} Pterrordax · {npc:9998} Shizzle
	["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "異種蠍巢穴佔滿環形山南部。格里什異種蠍和格里什工蠍會掉落香味腺體；在第一個巢室內的卵堆上使用採集瓶。底部的格里什蜂后是精英首領：不要進入她的巢室。{npc:9166}在蟲巢上方的懸崖築巢；牠們的鱗片交給{npc:9998}。",

	-- Step 8: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "木筏在東南方湖泊的岸邊；小包就在旁邊的水裡。",

	-- Step 9: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619}在環形山的東南角紮營。",

	-- Step 10: Fresh Threshadon Carcass
	["North of Torwa, a dead Threshadon lies by the water."] = "在托爾瓦北邊，一頭死去的蛇頸龍躺在水邊。",

	-- Step 12: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "拉克維的配偶",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "拉克維的配偶在{npc:9619}西北方的叢林中徘徊。",

	-- Step 13: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "保留誘餌：{npc:9684}是56級，第二圈路線會經過牠的巢穴。",

	-- Step 14: Lashers and Threshers
	["Lashers and Threshers"] = "血瓣花鞭笞者與猛擊者",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "沿著東側向北騎。血瓣花鞭笞者和血瓣花猛擊者佈滿叢林。",

	-- Step 15: Crate of Foodstuffs
	["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "探險隊的箱子在東部叢林中一處廢棄的營地裡。",

	-- Step 16: Gorillas
	["Gorillas"] = "猩猩",
	-- {npc:9622} U'cha
	["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "猩猩住在東北方的高地上。不要進入最深的洞穴：{npc:9622}住在那裡。",
	-- {npc:9623} A-Me 01
	["{npc:9623}, the robot on the plateau"] = "{npc:9623}，高地上的機器人",
	-- {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "{npc:9623}接著會要一個{item:10561}，這是{skill:202}物品。除非你有，否則跳過。",

	-- Step 17: Bloodpetal Flayers
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer
	["Bloodpetal Flayers"] = "血瓣花掠奪者",
	-- {area:537} Fire Plume Ridge
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer
	["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "向西南騎往環形山中央的火山{area:537}。血瓣花掠奪者生長在山腳周圍。",

	-- Step 18: Power Crystals and soil
	["Power Crystals and soil"] = "能量水晶與土壤",
	-- {area:537} Fire Plume Ridge
	["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "水晶簇遍布整個環形山，許多在{area:537}周圍。每種顏色多拿幾個給水晶塔用。",

	-- Step 19: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999}坐在山脊上，迷路又筋疲力盡。",

	-- Step 20: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "護送{npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "帶領{npc:9999}向北前往{area:541}。他昏倒時，對他使用{item:11804}叫醒他。",

	-- Step 21: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "{npc:9998}，在入口",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "保留{npc:9118}的{quest:4147}和{npc:8737}的信，留給之後的指南。",

	-- Step 22: Northern Pylon
	["Northern Pylon"] = "北部水晶塔",
	["The pylon stands on the slope east of the refuge."] = "水晶塔位於避難營東邊的山坡上。",

	-- Step 23: Eastern Pylon
	["Eastern Pylon"] = "東部水晶塔",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "沿著環形山東側往下騎到東邊懸崖上的水晶塔。",

	-- Step 24: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "{npc:9684}的巢穴就在水晶塔南邊。在那裡使用{npc:9619}的誘餌；{npc:9684}是56級且攻擊力強，滿血再開始。",

	-- Step 25: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "{npc:9619}現在要{npc:9622}的毛皮，在東北方的洞穴裡：跳過。",

	-- Step 26: Western Pylon
	["Western Pylon"] = "西部水晶塔",
	["Cross the south of the crater to the pylon on the western cliffs."] = "穿過環形山南部，前往西邊懸崖上的水晶塔。",

	-- Step 27: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "哥布林{npc:10302}坐在{area:543}，就在水晶塔東邊。",

	-- Step 28: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "向東騎往{area:537}，爬上去，在山頂附近的熔岩噴口使用{npc:10541}，然後騎回西邊找{npc:10302}。",

	-- Step 29: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302}要你去找{zone:1452}的{npc:9298}：保留此任務。",

	-- Step 30: J.D. Collie
	-- {area:541} Marshal's Refuge
	["Ride north back to {area:541}."] = "向北騎回{area:541}。",

	-- Step 31: Lakkari Tar Pits
	-- {area:340} Kargath
	-- plural, as words: Tar Lurkers = {npc:6518} Tar Lurker · Tar Lords = {npc:6519} Tar Lord
	["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "塞朵拉在{area:340}的任務需要等級52。避難營南邊的焦油潛伏者和焦油領主是最近的營地。",
	-- {area:538} Lakkari Tar Pits · {zone:1449} Un'Goro Crater
	-- plural, as words: Tar Lurkers = {npc:6518} Tar Lurker
	["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "在{zone:1449}的{area:538}擊殺焦油潛伏者練等",

	-- Step 32: Gadgetzan
	-- {npc:10041} Gorishi Hive Queen
	["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "匹斯特蘇格的下一個任務需要擊殺精英首領{npc:10041}。跳過。",

	-- Step 33: Orgrimmar
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol · {zone:1458} Undercity
	["Fly to {area:1637} and train before the {object:3202} zeppelin: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "飛往{area:1637}，在搭往{object:3202}的飛艇前先訓練：這份指南稍後在{zone:1458}的停留沒有獵人或薩滿訓練師。",

	-- Step 34: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:1637} Orgrimmar · {object:3202} Grom'gol
	["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "飛往{area:1638}，在{area:1639}向{npc:3033}訓練，然後飛往{area:1637}搭乘前往{object:3202}的飛艇。",

	-- Step 35: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "飛往{area:340}",
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol · {area:340} Kargath · {zone:1418} Badlands
	["Fly to {area:1637}, take the zeppelin to {object:3202} and fly from there to {area:340}, built into the cliffs on the {zone:1418}' west edge."] = "飛往{area:1637}，搭飛艇前往{object:3202}，再從那裡飛往{area:340}，它建在{zone:1418}西緣的懸崖中。",

	-- Step 36: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "進入{zone:1427}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {area:254} Blackrock Mountain
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "從{area:340}西側的山口進入{zone:1427}，然後向南穿過峽谷，走長橋進入{area:254}。進去後沿著鐵鍊走道往下，從南側出口離開；不要走往地城傳送門的路。",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "通往{area:254}的橋",

	-- Step 37: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "出了山就在{area:252}旁邊，那裡滿是55-57級的獸人。沿著道路向東，沿北側懸崖前往{area:251}的部落營地。",

	-- Step 38: Black Broodlings
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings"] = "黑色小龍",
	-- {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "黑色小龍在{area:251}東邊的山丘築巢。在小龍快死時對牠使用{npc:10267}的{item:12284}來捕捉牠的精華。",

	-- Step 39: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "沿著懸崖向南前往火腹巨魔的山丘{quest:3821}。{npc:9136}的遺骸在山腳下。",

	-- Step 40: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822}在{quest:3821}的洞穴和礦坑隧道中走動；如果他不在，就清掉入口周圍的巨魔，直到他回來。",

	-- Step 41: Thaurissan dig site
	["Thaurissan dig site"] = "索瑞森挖掘場",
	-- {npc:7039} War Reaver · {quest:4296} Tablet of the Seven
	["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "向西騎往挖掘場。{npc:7039}魔像（53級）在周圍走動，常掉落碎片；{quest:4296}立在挖掘場中央的索瑞森矮人之間。抄錄它。",

	-- Step 42: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "向東北回到{area:251}。",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "保留{npc:10267}的信：{quest:4808}在{zone:1452}的{area:2255}。",

	-- Step 43: Kargath
	-- {area:1584} Blackrock Depths
	["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "塞朵拉的下一個差事要去鎮東找魯特維爾，然後進入{area:1584}：跳過。",

	-- Step 44: Undercity
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{npc:10879}，{object:36078}，在蝙蝠管理員旁邊",
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522}, the {object:36073}"] = "{npc:6522}，{object:36073}",
	-- {npc:8390} Chemist Cuely · {zone:1447} Azshara
	["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "{npc:8390}，皇家藥劑師協會：瓶子稍後在{zone:1447}裝滿",

	-- Step 45: The Bulwark
	-- {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "離開{zone:1458}，沿著道路向東穿過{zone:1420}前往邊境上的被遺忘者要塞{area:152}。",
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions · {quest:5401} Argent Dawn Commission
	["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "從德靈頓旁邊的箱子拿一個{object:176092}，用於{quest:5096}，在回程時完成。裝備{quest:5401}：只有穿戴時才會掉落天譴石。",

	-- Step 46: Augustus the Touched
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "沿著道路向東穿過{zone:1422}，過河進入{zone:1423}；離開道路往北前往西北方的廢墟城鎮{area:2627}。{npc:12384}坐在城鎮邊緣的小屋裡。",

	-- Step 47: Augustus' Receipt Book
	-- {area:2627} Terrordale
	["The book lies in the ruined inn of {area:2627}."] = "帳本在{area:2627}的廢墟旅店裡。",

	-- Step 49: Termite mounds
	["Termite mounds"] = "白蟻丘",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound
	["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "大白蟻丘遍布{area:2627}東邊的山丘。對經過的每個蟻丘使用{item:15042}。",

	-- Step 50: Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "向南騎回道路，沿路向東穿越整個地區前往{area:2268}。",

	-- Step 51: Darrowshire Spirits
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Darrowshire Spirits"] = "達隆郡居民的靈魂",
	-- {npc:11063} Carlin Redpath · {npc:11064} Darrowshire Spirit · {area:2262} Darrowshire
	["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "任務日誌中有{npc:11063}的任務時，被殺死的天譴軍有時會留下{npc:11064}；和它交談來釋放它。在向西南騎往{area:2262}的路上擊殺不死生物。",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "釋放達隆郡居民的靈魂：和它們交談",

	-- Step 52: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "{npc:10926}的鬼魂站在西南方的{area:2262}廢墟中。",

	-- Step 53: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "洋娃娃的腦袋和左右兩側散落在{npc:10926}周圍的房子裡；在背包中將它們組合起來。",

	-- Step 54: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: Marlene lives at {area:197} in the {zone:1422}."] = "保留{quest:5152}：瑪萊恩住在{zone:1422}的{area:197}。",

	-- Step 55: Zaeldarr the Outcast
	-- {npc:12250} Zaeldarr the Outcast · {area:2262} Darrowshire
	["{npc:12250} lurks just west of {area:2262}."] = "{npc:12250}潛伏在{area:2262}西邊。",

	-- Step 56: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "回到{area:2268}",
	["The next guide starts here, at the chapel's flight master."] = "下一份指南從這裡開始，在禮拜堂的飛行管理員處。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "離開{zone:1458}，沿著道路向東穿過{zone:1420}前往邊境上的被遺忘者要塞{area:152}。",
}
