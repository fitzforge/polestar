-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/03-feralas (forever/alliance/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:1121} Isle of Dread
	["Feathermoon's isle, ogres, yetis and the {area:1121}."] = "羽月的島嶼、食人魔、雪人和{area:1121}。",
	["Two new flight paths for later"] = "兩條之後要用的新飛行路線",
	-- {zone:1446} Tanaris
	["Then on to {zone:1446}"] = "接著前往{zone:1446}",
	["Stays on the main route"] = "留在主要路線上",
	["Boats to and from the island"] = "往返小島的船",

	-- Step 1: Into The Barrens
	-- {zone:1413} The Barrens
	["Into {zone:1413}"] = "進入{zone:1413}",

	-- Step 2: Thalanaar flight master
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "{area:489}飛行管理員",

	-- Step 3: Boat to Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold
	["Boat to {area:1116}"] = "坐船到{area:1116}",

	-- Step 4: Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold · {area:1120} Sardor Isle · {area:1108} Forgotten Coast · {npc:7880} Ginro Hearthkindle
	["{area:1116} stands on {area:1120}, off the {area:1108}: the boat from the coast's dock crosses to it. {npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{area:1116}位於{area:1108}外的{area:1120}上：海岸碼頭的船會開過去。{npc:7880}站在他屋子的樓上：從裡面上樓，箭頭分不清樓層。",
	-- {npc:3936} Shandris Feathermoon
	["{npc:3936}, beside him"] = "{npc:3936}，在他旁邊",
	-- {npc:7877} Latronicus Moonspear
	["{npc:7877}, at the top of the stronghold"] = "{npc:7877}，在要塞頂端",
	-- {npc:7764} Troyas Moonbreeze · {area:702} Rut'theran Village
	["{npc:7764}: his answer waits in {area:702}, later"] = "{npc:7764}：他的回覆稍後在{area:702}等你",

	-- Step 5: Ruins of Solarsal
	["Walk south along the island to the naga ruins; the gazebo stands among them."] = "沿著島嶼向南走到納迦遺跡；涼亭就在遺跡之間。",

	-- Step 7: Hatecrest naga
	["Hatecrest naga"] = "憎世納迦",
	-- {area:1117} Ruins of Solarsal
	["Back to the {area:1117}. Every Hatecrest naga there can drop scales."] = "回到{area:1117}。那裡的每個憎世納迦都可能掉落鱗片。",

	-- Step 8: Feathermoon Stronghold
	-- {npc:8136} Lord Shalzaru
	["{npc:8136} waits for the end of the mainland loop."] = "{npc:8136}留到大陸環線結束時再打。",

	-- Step 9: Boat to Forgotten Coast
	-- {area:1108} Forgotten Coast
	["Boat to {area:1108}"] = "坐船到{area:1108}",

	-- Step 10: Feralas
	["The courier's boat"] = "信使的船",

	-- Step 11: The courier's boat
	-- {area:1108} Forgotten Coast
	["Take the boat to the {area:1108} and follow the shore south to the wrecked row boat on the beach."] = "搭船前往{area:1108}，沿著海岸向南走到海灘上失事的划艇。",

	-- Step 12: Gordunni ogres
	["Gordunni ogres"] = "戈杜尼巨魔",
	-- {npc:5236} Gordunni Shaman
	["Ride east to the Gordunni camp in the hills south-east of the yeti valley: Warlocks and Shaman hold the camp, Brutes wander the slopes around it and further north.\nCareful: the {npc:5236} are 44-45 and the Warlocks 43-44, casters a level or two over you here: pull them one at a time from the camp's edge, and take the Brutes (42-43) on the slopes first."] = "向東騎往雪人山谷東南方山丘上的戈杜尼營地：戈杜尼術士和薩滿佔據營地，戈杜尼蠻兵在周圍和更北邊的山坡上遊蕩。\n小心：{npc:5236}是44-45級，術士是43-44級，這些施法者比你高一兩級：從營地邊緣一次拉一隻，並先打山坡上的蠻兵（42-43級）。",

	-- Step 13: Feral Scar Vale
	-- {npc:5346} Bloodroar the Stalker
	["Ride north into the yeti valley. Every Feral Scar yeti can drop a thick hide; {npc:5346} (level 48) prowls the middle."] = "向北騎進雪人山谷。每隻深痕雪人都可能掉落厚毛皮；{npc:5346}（48級）在中央徘徊。",

	-- Step 14: Ironfur bears
	["Ironfur bears"] = "鐵鬃熊",
	-- {area:1105} Feral Scar Vale · {area:1136} High Wilderness
	-- plural, as words: Ironfur Bears = {npc:5268} Ironfur Bear · Ironfur Patriarchs = {npc:5274} Ironfur Patriarch
	-- was: ["Ride north out of {area:1105}: the Ironfur Bears (41-42) at the foot of the {area:1136} drop Rhapsody's last liver.\nCareful: Ironfur Patriarchs (48-49) and the Rage Scar yetis (46-49) roam the hills further north: stay at their edge."] = "向北騎出{area:1105}：{area:1136}山腳下的鐵鬃熊（41-42級）會掉落拉普索迪的最後一個肝臟。\n小心：鐵鬃熊族王（48-49級）和狂怒之痕雪人（46-49級）在更北邊的山丘上遊蕩：待在牠們的外圍。"
	["Ride north out of {area:1105}: the Ironfur Bears (41-42) at the foot of the {area:1136} drop Rhapsody's Ironfur livers.\nCareful: Ironfur Patriarchs (48-49) and the Rage Scar yetis (46-49) roam the hills further north: stay at their edge."] = "",

	-- Step 15: Isle of Dread
	-- {area:1121} Isle of Dread · {area:1120} Sardor Isle · {npc:8136} Lord Shalzaru
	-- plural, as words: Hatecrest Serpent Guards = {npc:5333} Hatecrest Serpent Guard
	["The {area:1121} is the island just south of {area:1120}: swim over. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "{area:1121}是{area:1120}南邊不遠的小島：游過去。憎世毒蛇守衛和憎世巫師佔據那裡；{npc:8136}（47級）在南端的洞穴裡等著。先拉他的守衛。",
	-- {item:9248} Mysterious Relic
	["{item:9248}; below ground"] = "{item:9248}；地下",

	-- Step 16: Feathermoon Stronghold
	-- {npc:7877} Latronicus Moonspear · {npc:7878} Vestia Moonspear · {npc:7900} Angelas Moonbreeze · {npc:7880} Ginro Hearthkindle · {npc:7852} Pratt McGrubben
	["Coming from the south: {npc:7877} and {npc:7878} first, then {npc:7900} beside {npc:7880}'s building, then the stairs. {npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. {npc:7852} is by the flight master, on the way out."] = "從南邊過來：先找{npc:7877}和{npc:7878}，然後是{npc:7880}那棟樓旁邊的{npc:7900}，再上樓梯。{npc:7880}在他那棟樓的樓上：從裡面上樓，箭頭分不清樓層。{npc:7852}在飛行管理員旁，出去時順路。",
	-- {npc:7879} Quintis Jonespyre
	["{npc:7879}, upstairs"] = "{npc:7879}，樓上",
	-- {npc:7852} Pratt McGrubben
	["{npc:7852}'s next order, Improved Quality, wants Rage Scar hides from yetis of 46-49: skip it."] = "{npc:7852}的下一個訂單「品質提升」需要46-49級雪人的狂怒之痕毛皮：跳過。",

	-- Step 17: Fly to Thalanaar
	-- {area:489} Thalanaar
	["Fly to {area:489}"] = "飛往{area:489}",
	["Feathermoon flight master"] = "羽月飛行管理員",

	-- Step 18: Back to the coast
	["Back to the coast"] = "回到海岸",
	-- {zone:1444} Feralas · {zone:2652} Shen'dralas · {area:489} Thalanaar
	["You came into {zone:1444} from {zone:2652}, so {area:489}'s flight path is still to learn: take the boat back to the coast and ride east along the road; you pick up the flight path when this guide ends at {area:489}."] = "你是從{zone:2652}進入{zone:1444}的，所以還沒學到{area:489}的飛行路線：搭船回到海岸，沿道路向東騎；本指南在{area:489}結束時你會取得該飛行路線。",

	-- Step 19: Feralas
	["Grimtotem camp"] = "恐怖圖騰營地",

	-- Step 20: Grimtotem camp
	-- {area:489} Thalanaar · {npc:7956} Kindal Moonweaver
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["From {area:489} ride west along the road to the Grimtotem camp north of it. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "從{area:489}沿道路向西騎，前往北邊的恐怖圖騰營地。{npc:7956}在營地外等候；放出中央圍欄裡的小精龍，保護{npc:7956}和至少六隻小精龍存活。",

	-- Step 21: Grimtotem tauren
	["Grimtotem tauren"] = "恐怖圖騰牛頭人",
	-- {npc:222286} Namida Grimtotem
	["Careful: {npc:222286}, an elite of level 43, stands at the camp's north-east edge, around 67,39: pull the Naturalists, Raiders and Shamans away from her."] = "小心：{npc:222286}，43級精英，站在營地東北邊，約67,39：把博學者、襲擊者和薩滿從她身邊拉開。",

	-- Step 22: Jer'kai Moonweaver
	-- {zone:1457} Darnassus
	["for Tyrande in {zone:1457}: the route takes you there at 47"] = "給{zone:1457}的泰蘭妲：路線會在47級時帶你去那裡",

	-- Step 23: The Writhing Deep
	-- {area:489} Thalanaar
	["Ride south-east to the Woodpaw gnolls; the courier's backpacks lie in their southern camp, and a parcel inside them starts a delivery to {area:489}. The Zukk'ash hive is just south: fight down to the pod that holds Raschal, free him and keep him alive on the way out."] = "向東南騎往木爪豺狼人處；信使的背包在他們南邊的營地裡，裡面的一個包裹會開始一個送往{area:489}的任務。祖卡什蟲巢就在南邊：一路殺到關著拉斯卡爾的繭，救出他並在離開途中保護他存活。",
	-- {item:11463} Undelivered Parcel
	["{item:11463}, from the backpacks"] = "{item:11463}，來自背包",
	-- {object:164954} Zukk'ash Pod
	["{object:164954}, inside"] = "{object:164954}，室內",

	-- Step 24: Grind to 45
	["Grind to 45"] = "練到45級",
	-- {area:1105} Feral Scar Vale · {area:978} Zul'Farrak
	["Ride west into {area:1105}: its yetis are 43-45. The Rage Scar yetis in the hills to the north are 46-49: leave them. Or, with a group, run the {area:978} dungeon instead."] = "向西騎進{area:1105}：那裡的雪人是43-45級。北邊山丘上的狂怒之痕雪人是46-49級：別碰。或者，有小隊的話改打{area:978}地城。",
	-- {npc:5292} Feral Scar Yeti · {area:1105} Feral Scar Vale · {zone:1444} Feralas
	["grind on {npc:5292} at {area:1105}, {zone:1444}"] = "在{zone:1444}的{area:1105}擊殺{npc:5292}練等",

	-- Step 25: Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold · {area:1108} Forgotten Coast · {area:1099} Camp Mojache · {npc:7880} Ginro Hearthkindle
	["Hearth back to {area:1116} if your stone is bound there and ready. Otherwise ride west to the {area:1108} dock, giving the Horde guards at {area:1099} a wide berth, and take the boat. {npc:7880} waits upstairs."] = "",

	-- Step 26: Feathermoon Stronghold
	-- {npc:3936} Shandris Feathermoon · {zone:1457} Darnassus · {area:976} Gadgetzan
	["{npc:3936} then asks you to carry news to {zone:1457}: skip it, {area:976} sends you there instead."] = "{npc:3936}接著會要你把消息帶到{zone:1457}：跳過，{area:976}會改派你去那裡。",

	-- Step 28: Ride to Thalanaar
	-- {area:489} Thalanaar
	["Ride to {area:489}"] = "騎往{area:489}",
	-- {area:489} Thalanaar · {zone:1441} Thousand Needles
	["No flight path to {area:489} yet: take the boat back to the coast and ride east along the road to {area:489}, on the {zone:1441} border."] = "還沒有到{area:489}的飛行路線：搭船回到海岸，沿道路向東騎往{zone:1441}邊界上的{area:489}。",

	-- Step 29: Thalanaar
	-- {zone:1441} Thousand Needles
	["Ride north-east to the night elf outpost on the {zone:1441} border."] = "向東北騎往{zone:1441}邊界上的夜精靈前哨站。",
	-- {npc:4048} Falfindel Waywarder · {area:489} Thalanaar
	["{npc:4048} walks around {area:489}: look inside the circle on the map"] = "{npc:4048}在{area:489}附近走動：看地圖上的圓圈內",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to the {area:1108} and ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45."] = "搭船前往{area:1108}，向東騎進{area:1105}。{npc:14637}在海岸的任務需要45級。",
	-- ["From Theramore, fly to {area:608} and ride south out of {zone:1443} into {zone:1444}; the road leads west to the {area:1108} dock, where the boat crosses to Feathermoon on {area:1120}."] = "從塞拉摩飛往{area:608}，向南騎出{zone:1443}進入{zone:1444}；道路向西通往{area:1108}的碼頭，船會從那裡渡海前往{area:1120}的羽月要塞。",
	-- ["Giants and elementals"] = "巨人與元素",
	-- ["Hearth to Feathermoon."] = "使用爐石回到羽月要塞。",
	-- ["Rage Scar yetis"] = "怒痕雪人",
	-- ["Ride back north-west to the {area:1108} dock and take the boat to the island."] = "向西北騎回{area:1108}的碼頭，搭船前往島上。",
	-- ["Ride back to the {area:1108}; the goblin stands by the dock."] = "騎回{area:1108}；那個哥布林站在碼頭旁。",
	-- ["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide; one may drop a {quest:7735}, which {npc:7852} pays for too."] = "沿著道路向西騎回去，然後向北進入怒痕雪人的山丘。這裡的每隻雪人都可能掉落毛皮；其中可能會掉落{quest:7735}，{npc:7852}也會為它付錢。",
	-- ["Ride east to the Gordunni camp in the hills south-east of the yeti valley: Warlocks and Shaman hold the camp, Brutes wander the slopes around it and further north."] = "向東騎往雪人山谷東南方山丘上的戈杜尼營地：戈杜尼術士和薩滿佔據營地，戈杜尼蠻兵在周圍和更北邊的山坡上遊蕩。",
	-- ["Ride north out of {area:1105}: the Ironfur Bears (41-42) at the foot of the {area:1136} drop Rhapsody's last liver.\nCareful: Ironfur Patriarchs (48-49) and the Rage Scar yetis (46-49) roam the hills further north: stay at their edge."] = "向北騎出{area:1105}：{area:1136}山腳下的鐵鬃熊（41-42級）會掉落拉普索迪的最後一個肝臟。\n小心：鐵鬃熊族王（48-49級）和狂怒之痕雪人（46-49級）在更北邊的山丘上遊蕩：待在牠們的外圍。",
	-- ["Ride west to the friendly mountain giant at the foot of the hills. Land Walkers and Cliff Giants around him are elite: give them room."] = "向西騎往山丘腳下友善的山嶺巨人。他周圍的大地行者和峭壁巨人是精英：離牠們遠一點。",
	-- ["Ring the bell whenever {npc:7774} stops to wander, and lead her south to {npc:7765}."] = "每當{npc:7774}停下來亂逛時就搖鈴，帶她向南到{npc:7765}處。",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in northern {zone:1446}, the next zone on the route; come back to {npc:14637} on the {area:1108} afterwards."] = "組隊打{area:978}代替練等能更快達到目標。這座食人妖城市位於{zone:1446}北部，也就是路線的下一個地區；之後回到{area:1108}的{npc:14637}處。",
	-- ["Shore Striders, Deep Striders and Wave Striders (elite giants) wade along the coast north of the dock: zap one with {item:18904} and kill the shrunken giant. Sea Elementals and Sea Sprays drift in the same surf."] = "海岸巨人、深海巨人和波濤巨人（精英巨人）在碼頭北邊的海岸涉水：用{item:18904}電擊一隻，然後殺死縮小後的巨人。海元素和巨型海元素在同一片浪中漂浮。",
	-- ["The {zone:1446} guide starts with the trip east, past {area:489}."] = "{zone:1446}指南從向東的行程開始，途經{area:489}。",
	-- ["grind on {npc:5292} at {area:1105}, {area:357}"] = "在{area:357}的{area:1105}擊殺{npc:5292}練等",
	-- ["if you carry {quest:1100} from {zone:1441}"] = "如果你帶著{zone:1441}的{quest:1100}",
	-- ["{area:978} instead of grinding"] = "以{area:978}代替練等",
	-- ["{npc:14637}'s refills are level 55: skip them."] = "{npc:14637}的補充任務是55級：跳過。",
	-- ["{npc:7774} wanders the hills north of {npc:7765}, among the Northspring harpies; her bell is in the chest beside her."] = "{npc:7774}在{npc:7765}北邊的山丘上、北泉鷹身人之間遊蕩；她的鈴鐺在她旁邊的箱子裡。",
	-- ["{npc:7774}'s escort"] = "護送{npc:7774}",
	-- ["{npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:7880}站在他屋子的樓上：從裡面上樓，箭頭分不清樓層。",
}
