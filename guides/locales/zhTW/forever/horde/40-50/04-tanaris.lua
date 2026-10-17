-- Chinese (traditional) (zhTW): the guide forever/horde/40-50/04-tanaris (forever/horde/40-50/04-tanaris.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飛往{area:976}",
	-- {area:1099} Camp Mojache
	["From {area:1099}'s flight master."] = "從{area:1099}的飛行管理員處出發。",

	-- Step 2: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}，在雙足飛龍管理員旁邊",
	-- {object:150075} Wanted Poster
	["the {object:150075} in the square"] = "廣場上的{object:150075}",

	-- Step 3: Sandsorrow Watch
	-- {item:8584} Untapped Dowsing Widget
	["West of Gadgetzan, use the {item:8584} beside the water hole in the troll camp."] = "在加基森西邊，於食人妖營地的水池旁使用{item:8584}。",

	-- Step 5: Caliph Scorpidsting
	-- {npc:7847} Caliph Scorpidsting
	["South-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp."] = "在加基森東南方，廢土強盜在沙丘間紮營；{npc:7847}站在東邊的營地裡。",

	-- Step 6: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:9978} Gahz'ridian Detector · {area:983} Dunemaul Compound
	["West along the road south; {npc:7771} camps by the ruins at the {area:1938}. Put on his {item:9978}: it shows the buried ornaments, here and around the {area:983}."] = "沿著往南的道路向西走；{npc:7771}在{area:1938}的廢墟旁紮營。戴上他的{item:9978}：它會顯示埋在地下的飾品，在這裡和{area:983}周圍都有。",

	-- Step 7: The Noxious Lair
	["West, the Centipaar insects swarm around their hives; any of them drops the parts."] = "往西，森提帕爾蟲子在牠們的蟲巢周圍聚集；牠們都會掉落肢體。",

	-- Step 8: Dunemaul Compound
	-- {area:982} The Noxious Lair · {npc:12046} Gor'marok the Ravager · {quest:3161} Gahz'ridian
	["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "{area:982}南邊，砂槌巨魔佔據他們的營地，{npc:12046}在營地東端。在戰鬥之間挖出{quest:3161}飾品。",

	-- Step 9: Thistleshrub Valley
	-- {zone:1446} Tanaris
	["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one."] = "營地西邊的山谷滿是仙人掌生物；只有灌木露水收集者帶著露水腺體。{zone:1446}的大部分怪物都可能掉落OOX-17/TN定位器，但很稀有：看到就保留。",
	-- {item:8623} OOX-17/TN Distress Beacon
	["{item:8623}, a rare drop"] = "{item:8623}，稀有掉落",

	-- Step 10: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "護送{npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port · {npc:8579} Yeh'kinya
	["{npc:5955} waits in the valley. Walk him all the way to his wife {npc:6015} in {area:977}, north-east across the desert: stay close, slow down for him and fight off what attacks him. Do not mount or hearth out of his reach. {npc:8579} stands in the port too."] = "{npc:5955}在山谷裡等候。一路護送他向東北穿過沙漠，到{area:977}找他的妻子{npc:6015}：跟緊他，放慢速度配合他，擊退攻擊他的敵人。不要騎坐騎或用爐石離開他的範圍。{npc:8579}也在港口裡。",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride south-west to {area:976}."] = "向西南騎往{area:976}。",
	-- {item:8526} Violet Tragan · {zone:1425} Hinterlands
	["the {item:8526} grows in the {zone:1425}, around level 48"] = "{item:8526}生長在{zone:1425}，大約48級",

	-- Step 12: Marvon Rivetseeker
	["South down the road again."] = "再次沿著道路往南走。",

	-- Step 13: Scrimshank's gear
	["Scrimshank's gear"] = "謝申克的設備",
	["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive."] = "更往南，謝申克的勘探設備在一個森提帕爾蟲巢的入口處。",

	-- Step 14: OOX-17/TN
	["OOX-17/TN"] = "OOX-17/TN",
	-- {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}."] = "僅限持有定位器時：OOX-17/TN在謝申克蟲巢的東南方。護送它向北前往{area:977}；獎勵在{area:35}的奧格索普那裡等著。",

	-- Step 15: Gadgetzan
	-- {npc:7010} Zilzibin Drumlore · {area:1637} Orgrimmar
	["for {npc:7010} in {area:1637}, around level 50"] = "交給{area:1637}的{npc:7010}，大約50級",

	-- Step 16: Orgrimmar
	-- {area:1637} Orgrimmar · {zone:1458} Undercity · {area:392} Ratchet
	["Fly to {area:1637} and train: the next guide's training stop is the {zone:1458}, which has no Hunter or Shaman trainer. Then fly to {area:392}."] = "飛往{area:1637}並訓練：下一份指南的訓練點是{zone:1458}，那裡沒有獵人或薩滿訓練師。然後飛往{area:392}。",

	-- Step 17: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:392} Ratchet
	["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:392}."] = "飛往{area:1638}，在{area:1639}向{npc:3033}訓練，然後飛往{area:392}。",

	-- Step 18: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飛往{area:392}",

	-- Step 19: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "搭船前往{area:35}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["The boat to {area:35} docks at {area:392}'s pier, below the flight master's hill."] = "前往{area:35}的船停靠在{area:392}的碼頭，就在飛行管理員所在山丘的下方。",
	-- {area:392} Ratchet
	["{area:392} pier"] = "{area:392}碼頭",

	-- Step 20: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "飛往{area:340}",
	-- {area:35} Booty Bay
	["From the {area:35} flight master, above the harbour."] = "從{area:35}港口上方的飛行管理員處出發。",

	-- Step 21: The Grimesilt Dig Site
	-- {area:247} Grimesilt Dig Site
	["The {area:247}"] = "{area:247}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {object:173265} Wooden Outhouse · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "從{area:340}西側的山口進入{zone:1427}，然後向西南騎往挖掘場。{object:173265}在挖掘場南端；黑鐵地質學家就在它北邊挖掘。帶15塊{item:4306}（拍賣場有賣）。",
	-- {object:173265} Wooden Outhouse
	["the {object:173265}"] = "{object:173265}",

	-- Step 22: Thorium Point
	-- {area:1446} Thorium Point
	["Ride north-west across the gorge; {area:1446} is the scaffolded camp in the north-west."] = "向西北騎過峽谷；{area:1446}是西北方搭著鷹架的營地。",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "{object:179827}告示板",

	-- Step 23: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "卡拉然獨自站在{area:1446}南邊，大熔爐的邊緣。聽他說他的故事。",

	-- Step 24: The Cauldron
	-- {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Blazing Elementals = {npc:5850} Blazing Elemental · Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster
	["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "重型作戰傀儡在卡拉然下方的大熔爐巡邏，會掉落油；在牠們之間飄移的熔岩元素和熾熱元素會掉落核心。黑鐵工頭和黑鐵奴隸販子在小路上驅趕奴隸；奴隸販子可能掉落{item:11818}：保留它。",
	-- {item:11818} Grimesilt Outhouse Key
	["{item:11818}, a rare drop"] = "{item:11818}，稀有掉落",

	-- Step 26: The Steamsmiths' furnaces
	["The Steamsmiths' furnaces"] = "鍛造師的熔爐",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith
	["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "黑鐵鍛造師在大熔爐中央操作熔爐；一半帶有{item:10551}，十分之一帶有{item:18959}。奴隸工、奴隸販子和工頭也帶著匕首。",

	-- Step 27: Kalaran Windblade
	-- {item:10552} Symbol of Ragnaros
	["His next request needs the {item:10552} from elite cultists: leave it."] = "他的下一個請求需要精英教徒身上的{item:10552}：別管它。",

	-- Step 28: The Slag Pit
	-- {area:1443} The Slag Pit
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge."] = "{area:1443}在大熔爐北部。燻火龍在它的熔岩池裡游動：把牠們拉到邊緣。秘密設計圖在坑的上層岩架上。",

	-- Step 29: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "巨型熔岩蜘蛛",
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["The Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge."] = "巨型熔岩蜘蛛在峽谷西南部的高地和熔岩池周圍遊蕩。",

	-- Step 30: Dark Iron Lookouts
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["Dark Iron Lookouts"] = "黑鐵哨兵",
	-- {item:18960} Lookout's Spyglass
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "黑鐵哨兵站在大熔爐南邊哨塔周圍的山脊上；大約十分之一帶有{item:18960}。",

	-- Step 31: The Key to Freedom
	-- {item:11818} Grimesilt Outhouse Key · {object:173265} Wooden Outhouse
	["Only with the {item:11818}: back east to the {object:173265} at the dig site."] = "僅限持有{item:11818}時：向東回到挖掘場的{object:173265}。",

	-- Step 32: Thorium Point
	-- {area:1446} Thorium Point · {area:75} Stonard
	["Ride back north to {area:1446}. Stay here: the next guide starts with the flight to {area:75}."] = "向北騎回{area:1446}。留在這裡：下一份指南從飛往{area:75}開始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "{area:982}南邊，砂槌巨魔佔據他們的營地，{npc:12046}在營地東端。在戰鬥之間挖出{quest:3161}飾品。",
}
