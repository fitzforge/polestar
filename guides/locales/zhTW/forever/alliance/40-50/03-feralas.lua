-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/03-feralas (forever/alliance/40-50/03-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Feathermoon Stronghold
	-- {area:608} Nijel's Point · {zone:1443} Desolace · {zone:1444} Feralas · {area:1108} Forgotten Coast · {area:1120} Sardor Isle
	["From Theramore, fly to {area:608} and ride south out of {zone:1443} into {zone:1444}; the road leads west to the {area:1108} dock, where the boat crosses to Feathermoon on {area:1120}."] = "從塞拉摩飛往{area:608}，向南騎出{zone:1443}進入{zone:1444}；道路向西通往{area:1108}的碼頭，船會從那裡渡海前往{area:1120}的羽月要塞。",
	-- {npc:7877} Latronicus Moonspear
	["{npc:7877}, at the top of the stronghold"] = "{npc:7877}，在要塞頂端",
	-- {npc:3936} Shandris Feathermoon
	["{npc:3936}, beside him"] = "{npc:3936}，在他旁邊",
	-- {npc:7764} Troyas Moonbreeze · {area:702} Rut'theran Village
	["{npc:7764}: his answer waits in {area:702}, later"] = "{npc:7764}：他的回覆稍後在{area:702}等你",

	-- Step 2: Ruins of Solarsal
	["Walk south along the island to the naga ruins; the gazebo stands among them."] = "沿著島嶼向南走到納迦遺跡；涼亭就在遺跡之間。",

	-- Step 4: Hatecrest naga
	["Hatecrest naga"] = "憎世納迦",
	-- {area:1117} Ruins of Solarsal
	["Back to the {area:1117}. Every Hatecrest naga there can drop scales."] = "回到{area:1117}。那裡的每個憎世納迦都可能掉落鱗片。",

	-- Step 5: Feathermoon Stronghold
	-- {npc:8136} Lord Shalzaru
	["{npc:8136} waits for the end of the mainland loop."] = "{npc:8136}留到大陸環線結束時再打。",

	-- Step 6: The courier's boat
	["The courier's boat"] = "信使的船",
	-- {area:1108} Forgotten Coast
	["Take the boat to the {area:1108} and follow the shore south to the wrecked row boat on the beach."] = "搭船前往{area:1108}，沿著海岸向南走到海灘上失事的划艇。",

	-- Step 7: Gordunni ogres
	["Gordunni ogres"] = "戈杜尼巨魔",
	["Ride east to the Gordunni camp in the hills south-east of the yeti valley: Warlocks and Shaman hold the camp, Brutes wander the slopes around it and further north."] = "向東騎往雪人山谷東南方山丘上的戈杜尼營地：戈杜尼術士和薩滿佔據營地，戈杜尼蠻兵在周圍和更北邊的山坡上遊蕩。",

	-- Step 8: Feral Scar Vale
	-- {npc:5346} Bloodroar the Stalker
	["Ride north into the yeti valley. Every Feral Scar yeti can drop a thick hide; {npc:5346} (level 48) prowls the middle."] = "向北騎進雪人山谷。每隻深痕雪人都可能掉落厚毛皮；{npc:5346}（48級）在中央徘徊。",

	-- Step 9: Feathermoon Stronghold
	-- {area:1108} Forgotten Coast
	["Ride back north-west to the {area:1108} dock and take the boat to the island."] = "向西北騎回{area:1108}的碼頭，搭船前往島上。",

	-- Step 10: Lord Shalzaru
	-- {area:1121} Isle of Dread · {npc:8136} Lord Shalzaru
	-- plural, as words: Hatecrest Serpent Guards = {npc:5333} Hatecrest Serpent Guard
	["Swim south from the island to the {area:1121}. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "從島上向南游到{area:1121}。憎世毒蛇守衛和憎世巫師佔據那裡；{npc:8136}（47級）在南端的洞穴裡等著。先拉他的守衛。",

	-- Step 11: Feathermoon Stronghold
	["Hearth to Feathermoon."] = "使用爐石回到羽月要塞。",

	-- Step 12: Grimtotem camp
	["Grimtotem camp"] = "恐怖圖騰營地",
	-- {area:1108} Forgotten Coast · {zone:1444} Feralas · {npc:7956} Kindal Moonweaver
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Boat to the {area:1108} and ride east across {zone:1444} to the Grimtotem camp north of the road. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "搭船前往{area:1108}，向東騎過{zone:1444}，前往道路北邊的恐怖圖騰營地。{npc:7956}在營地外等候；放出中央圍欄裡的小精龍，保護{npc:7956}和至少六隻小精龍存活。",

	-- Step 13: Grimtotem tauren
	["Grimtotem tauren"] = "恐怖圖騰牛頭人",

	-- Step 14: Jer'kai Moonweaver
	-- {zone:1457} Darnassus
	["for Tyrande in {zone:1457}: the route takes you there at 47"] = "給{zone:1457}的泰蘭妲：路線會在47級時帶你去那裡",

	-- Step 15: The Writhing Deep
	-- {area:489} Thalanaar
	["Ride south-east to the Woodpaw gnolls; the courier's backpacks lie in their southern camp, and a parcel inside them starts a delivery to {area:489}. The Zukk'ash hive is just south: fight down to the pod that holds Raschal, free him and keep him alive on the way out."] = "向東南騎往木爪豺狼人處；信使的背包在他們南邊的營地裡，裡面的一個包裹會開始一個送往{area:489}的任務。祖卡什蟲巢就在南邊：一路殺到關著拉斯卡爾的繭，救出他並在離開途中保護他存活。",
	-- {item:11463} Undelivered Parcel
	["{item:11463}, from the backpacks"] = "{item:11463}，來自背包",

	-- Step 16: Thalanaar
	-- {zone:1441} Thousand Needles
	["Ride north-east to the night elf outpost on the {zone:1441} border."] = "向東北騎往{zone:1441}邊界上的夜精靈前哨站。",
	-- {quest:1100} Lonebrow's Journal · {zone:1441} Thousand Needles
	["if you carry {quest:1100} from {zone:1441}"] = "如果你帶著{zone:1441}的{quest:1100}",

	-- Step 17: Rage Scar yetis
	["Rage Scar yetis"] = "怒痕雪人",
	-- {quest:7735} Pristine Yeti Hide · {npc:7852} Pratt McGrubben
	["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide; one may drop a {quest:7735}, which {npc:7852} pays for too."] = "沿著道路向西騎回去，然後向北進入怒痕雪人的山丘。這裡的每隻雪人都可能掉落毛皮；其中可能會掉落{quest:7735}，{npc:7852}也會為它付錢。",

	-- Step 18: Rockbiter
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["Ride west to the friendly mountain giant at the foot of the hills. Land Walkers and Cliff Giants around him are elite: give them room."] = "向西騎往山丘腳下友善的山嶺巨人。他周圍的大地行者和峭壁巨人是精英：離牠們遠一點。",

	-- Step 19: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["{npc:7774} wanders the hills north of {npc:7765}, among the Northspring harpies; her bell is in the chest beside her."] = "{npc:7774}在{npc:7765}北邊的山丘上、北泉鷹身人之間遊蕩；她的鈴鐺在她旁邊的箱子裡。",

	-- Step 20: Shay Leafrunner's escort
	-- {npc:7774} Shay Leafrunner
	["{npc:7774}'s escort"] = "護送{npc:7774}",
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Ring the bell whenever {npc:7774} stops to wander, and lead her south to {npc:7765}."] = "每當{npc:7774}停下來亂逛時就搖鈴，帶她向南到{npc:7765}處。",

	-- Step 21: Feathermoon Stronghold
	-- {npc:3936} Shandris Feathermoon · {zone:1457} Darnassus · {area:976} Gadgetzan
	["{npc:3936} then asks you to carry news to {zone:1457}: skip it, {area:976} sends you there instead."] = "{npc:3936}接著會要你把消息帶到{zone:1457}：跳過，{area:976}會改派你去那裡。",

	-- Step 22: Zul'Farrak instead of grinding
	-- {area:978} Zul'Farrak
	["{area:978} instead of grinding"] = "以{area:978}代替練等",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {npc:14637} Zorbin Fandazzle · {area:1108} Forgotten Coast
	["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in northern {zone:1446}, the next zone on the route; come back to {npc:14637} on the {area:1108} afterwards."] = "組隊打{area:978}代替練等能更快達到目標。這座食人妖城市位於{zone:1446}北部，也就是路線的下一個地區；之後回到{area:1108}的{npc:14637}處。",

	-- Step 23: Grind to 45
	["Grind to 45"] = "練到45級",
	-- {area:1108} Forgotten Coast · {area:1105} Feral Scar Vale · {npc:14637} Zorbin Fandazzle
	["Boat to the {area:1108} and ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45."] = "搭船前往{area:1108}，向東騎進{area:1105}。{npc:14637}在海岸的任務需要45級。",
	-- {npc:5292} Feral Scar Yeti · {area:1105} Feral Scar Vale · {zone:1444} Feralas
	["grind on {npc:5292} at {area:1105}, {zone:1444}"] = "在{zone:1444}的{area:1105}擊殺{npc:5292}練等",

	-- Step 24: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast
	["Ride back to the {area:1108}; the goblin stands by the dock."] = "騎回{area:1108}；那個哥布林站在碼頭旁。",

	-- Step 25: Giants and elementals
	["Giants and elementals"] = "巨人與元素",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Shore Striders = {npc:5359} Shore Strider · Deep Striders = {npc:5360} Deep Strider · Wave Striders = {npc:5361} Wave Strider · Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Shore Striders, Deep Striders and Wave Striders (elite giants) wade along the coast north of the dock: zap one with {item:18904} and kill the shrunken giant. Sea Elementals and Sea Sprays drift in the same surf."] = "海岸巨人、深海巨人和波濤巨人（精英巨人）在碼頭北邊的海岸涉水：用{item:18904}電擊一隻，然後殺死縮小後的巨人。海元素和巨型海元素在同一片浪中漂浮。",

	-- Step 26: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["{npc:14637}'s refills are level 55: skip them."] = "{npc:14637}的補充任務是55級：跳過。",
	-- {area:1108} Forgotten Coast · {zone:1446} Tanaris
	["You end at the {area:1108} dock: the {zone:1446} guide starts with the trip east from here."] = "你在{area:1108}的碼頭結束：{zone:1446}指南從這裡向東出發開始。",
}
