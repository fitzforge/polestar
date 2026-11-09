-- Chinese (traditional) (zhTW): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 2: Apothecary Zinge
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "",

	-- Step 3: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}，{object:36126}",

	-- Step 4: Riding at 40
	["Riding at 40"] = "40級騎術",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "騎術訓練師{npc:4773}",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "骸骨戰馬：{npc:4731}，在{area:159}的{npc:4773}旁邊。",

	-- Step 5: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "搭飛艇前往{object:3202}",

	-- Step 6: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "飛往{area:75}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 7: Stonard
	-- {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["Coming from Stranglethorn, you carry these already. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 8: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "沿道路向西騎；卷軸在沼澤最西邊的水邊。",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, later in this guide"] = "之後在本指南中用於{zone:1445}的{object:2555}",

	-- Step 9: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "鹽齒鱷魚",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "",

	-- Step 10: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "向東經過{area:75}：阿塔萊的文物在{quest:1424}的水中和岸邊。",

	-- Step 11: Misty Reed Post
	-- {npc:5592} Tok'Kar
	["Follow the road south-east to the small Horde post on the shore. {npc:5592} takes the crocolisk flanks from the last swamp visit."] = "",

	-- Step 12: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "",
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too."] = "",
	["Underwater"] = "",

	-- Step 14: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "蘆葦崗哨的魚人",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "沼澤魚人住在哨站南邊的海灘；沼澤噴墨魚人在哨站東邊的岸邊，沼澤食腐魚人在更西邊、西岸的小屋周圍。",
	["Below ground"] = "",

	-- Step 16: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "",

	-- Step 18: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "之後給{zone:1425}的{npc:5598}，約48級",

	-- Step 19: To Camp Mojache
	-- {area:1099} Camp Mojache
	["To {area:1099}"] = "",

	-- Step 20: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "之後給{zone:1425}的梟獸，約48級",

	-- Step 21: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 22: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "",

	-- Step 23: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "",

	-- Step 24: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "",

	-- Step 25: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "",
	-- {area:511} Wyrmbog
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "",

	-- Step 26: Brackenwall Village
	["Ride back north to Brackenwall."] = "向北騎回蕨牆村。",

	-- Step 27: Onyxia's eggs
	["Onyxia's eggs"] = "奧妮克希亞的蛋",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "奧妮克希亞的蛋在{area:511}東南部的龍穴中，由火鬃守衛看守；砸碎五個。",
	["Dragon caves"] = "龍穴",

	-- Step 29: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "",

	-- Step 30: Level 45.41
	["Level 45.41"] = "",
	-- {quest:1173} Challenge Overlord Mok'Morokk · {area:978} Zul'Farrak · {area:1517} Uldaman
	["If you skipped {quest:1173}, grind here to level 45.41 to stay on the route's plan. Or, with a group, run the {area:978} dungeon or the {area:1517} dungeon instead."] = "",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "",

	-- Step 31: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "飛往{area:1099}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "",

	-- Step 32: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "小精龍與森林漫遊者",
	-- {item:9589} Encrusted Minerals
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs."] = "小精龍在營地西邊不遠的樹林上空飛舞，身上帶著{item:9589}；再往西一點的森林漫遊者身上帶著斷裂的原木。",

	-- Step 33: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "亂羽角鷹獸",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "山谷南邊，亂羽角鷹獸棲息在山坡上；幾乎每一隻都會掉落肌腱和金屬碎片。",

	-- Step 34: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "向西北騎到{area:1108}；{npc:14637}在碼頭上等著。",

	-- Step 35: Rogue Vale screechers
	["Rogue Vale screechers"] = "遊蕩的山谷尖嘯者",
	-- {npc:14637} Zorbin Fandazzle · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "",

	-- Step 36: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "海元素和巨型海元素在碼頭周圍的海岸邊漂流。先用{item:18904}電擊巨人：縮小後就失去精英的力量。海岸巨人在水中涉行；大地行者和峭壁巨人在更北邊的山丘遊蕩。",

	-- Step 37: Northspring harpies
	["Northspring harpies"] = "北泉鷹身人",
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "北泉鷹身人在最西北方的山脊上築巢。她們是48-50級，比你高幾級：北泉喚風者會治療，所以先殺她們，並一次只拉一隻。",

	-- Step 38: Rage Scar yetis
	["Rage Scar yetis"] = "狂暴的怒痕雪人",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}，稀有掉落",

	-- Step 39: Camp Mojache
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {object:3202}"] = "飛往{object:3202}",
	-- ["Forest walkers"] = "森林漫遊者",
	-- ["Monstrous Crawlers"] = "巨型淤泥蟹",
	-- ["Murlocs of the Misty Reed"] = "蘆葦崗哨的魚人",
	-- ["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "沿道路往西北，狂暴的怒痕雪人住在丘陵中的洞穴周圍。任何一隻也可能掉落{quest:7738}，它會開啟自己的任務。",
	-- ["Northspring harpies"] = "北泉鷹身人",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "向東騎回營地。留在這裡：下一份指南從飛往{area:976}開始。",
	-- ["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "向西南騎到{object:2555}，然後向東穿過{area:511}。火鬃斥候和火鬃灰尾龍人與灼熱幼龍、灼熱雛龍在北緣遊蕩；火鬃守衛守護更東南邊的龍穴。莫格穆洛克大王的鼻煙、烈酒和保險箱在龍人營地中。",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "往西南，雪人在{area:1105}築巢；那裡的每隻雪人都可能掉落厚皮。",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "沼澤魚人住在哨站南邊的海灘；沼澤噴墨魚人在哨站東邊的岸邊，沼澤食腐魚人在更西邊、西岸的小屋周圍。",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "巨型淤泥蟹在東岸的海灘上走動，數量稀少又分散：往南的路上看到就殺。",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "北泉鷹身人在最西北方的山脊上築巢。她們是48-50級，比你高幾級：北泉喚風者會治療，所以先殺她們，並一次只拉一隻。",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "同樣的魚人，再加上待在西岸小屋附近的沼澤魚人智者。",
	-- ["The small Horde post on the southern shore."] = "南岸的小型部落哨站。",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "前往{zone:1454}的飛艇從{object:3202}旁的塔出發；降落在{zone:1454}正門東北方不遠處。",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "你從{area:75}開始。在這裡綁定：海岸之後你會用爐石回來。",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "你的訓練師在{area:1638}：飛過去（還沒有那裡的飛行點？飛往{area:378}，向西騎過{zone:1412}），然後繼續前往{area:496}。",
	-- ["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",
	-- ["Zeppelin tower"] = "飛艇塔",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "之後在本指南中用於{area:15}的{object:2555}",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500}是精英：建議組隊。把他打到認輸，然後向{npc:4501}報告。",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}：之後給{zone:1454}的{npc:7010}，約50級",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}，然後是{object:172960}和{object:172961}。",
}
