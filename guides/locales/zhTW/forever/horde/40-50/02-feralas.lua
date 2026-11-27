-- Chinese (traditional) (zhTW): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1434} Stranglethorn Vale · {area:75} Stonard · {zone:1446} Tanaris · {zone:1444} Feralas
	["{zone:1434} and {area:75} first, then {zone:1446} and {zone:1444}."] = "先去{zone:1434}和{area:75}，再去{zone:1446}和{zone:1444}。",

	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飛往{object:3202}",
	-- {zone:2548} Riverglades · {area:340} Kargath
	["Coming from the {zone:2548}: {area:340}'s flight master stands at the foot of the fortress."] = "從{zone:2548}過來：{area:340}的飛行管理員站在要塞腳下。",
	-- {area:340} Kargath
	["{area:340} flight master"] = "{area:340}飛行管理員",

	-- Step 2: Fly to Grom'gol
	-- {area:75} Stonard
	["{area:75} flight master"] = "{area:75}飛行管理員",

	-- Step 3: Grom'gol Base Camp
	-- {object:3202} Grom'gol · {area:35} Booty Bay · {npc:1514} Mokk the Savage · {zone:1435} Swamp of Sorrows · {zone:1458} Undercity · {object:2076} Bubbling Cauldron
	-- was: ["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "飛行降落在{object:3202}。你第一次來時帶著的荊棘谷較難任務，現在正適合你：碎顱者酋長、贊吉爾的營地、{area:35}的海盜、娜迦海岸和{npc:1514}，之後再搭飛艇前往{zone:1454}。尼姆布亞旁邊的{object:2076}有碎顱者酋長的任務。"
	["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the {zone:1435} and the {zone:1458}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "",
	-- {object:2076} Bubbling Cauldron · {quest:586} Speaking with Gan'zulah
	["the {object:2076}: {quest:586}"] = "{object:2076}：{quest:586}",

	-- Step 4: Tusks and necklaces on the Skullsplitter hunt
	["Tusks and necklaces on the Skullsplitter hunt"] = "",
	-- {npc:737} Kebok · {npc:2519} Kin'weelay
	["The hunters also drop {npc:737}'s tusks and {npc:2519}'s necklaces. Collect any you still need during the cauldron hunt."] = "",

	-- Step 5: Zul'Mamwe
	["Zul'Mamwe"] = "祖瑪維廢墟",
	-- {npc:1059} Ana'thek the Cruel · {quest:586} Speaking with Gan'zulah · {npc:1060} Mogh the Undying
	["Ride east to the Skullsplitter ruins east of the Venture Co. mine. The headhunters, berserkers and hunters roam the ruins.\n{npc:1059} (45) carries the Broken Armor for {quest:586}: he walks the south-western ruins with two guards and sometimes stands in a small cave there. Pull the guards first.\nCareful: {npc:1060}, an elite troll (level 44), stands in the southern ruins around 47.7,44.3: pull the headhunters and berserkers away from him."] = "向東騎到風險投資公司礦坑東邊的碎顱者廢墟。獵頭者、狂暴者和獵手在廢墟中遊蕩。\n{npc:1059}（45級）身上帶著{quest:586}所需的破損盔甲：他帶著兩名守衛在西南方的廢墟巡邏，有時會站在那裡的小洞穴裡。先拉守衛。\n小心：{npc:1060}是一隻精英食人妖（44級），站在南邊廢墟47.7,44.3附近：把獵頭者和狂暴者拉離他身邊。",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669}在這附近走動：看地圖上的圓圈內",

	-- Step 6: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Back west to {object:3202}."] = "向西回到{object:3202}。",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "再次到{object:2076}處：耶尼庫的命運",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks bask beside the road south, on the ride to {area:35}"] = "{npc:2519}：蜥蜴在往南的路邊曬太陽，就在前往{area:35}的路上",

	-- Step 8: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "鐵齶蜥蜴",
	-- {area:35} Booty Bay
	["Ride south along the road towards {area:35}; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "沿著道路往南騎向{area:35}；蜥蜴在道路東邊叢林中央的岩石上曬太陽。牠們經常掉落碎片。",
	["Below ground"] = "地下",

	-- Step 9: Pirate ghosts and Zanzil's camps
	["Pirate ghosts and Zanzil's camps"] = "海盜幽靈與贊吉爾的營地",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2537} Chucky "Ten Thumbs" · {npc:2534} Zanzil the Outcast
	-- plural, as words: Zanzil Witch Doctors = {npc:1490} Zanzil Witch Doctor
	-- was: ["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "繼續往西南到迷霧谷東北邊的叢林：三個海盜幽靈在贊吉爾的營地旁出沒。{npc:2535}和{npc:2536}站在一起，{npc:2537}在更東邊。贊吉爾的每個追隨者都可能帶著混合物。\n小心：贊吉爾巫醫（44級）會施法，而且營地很擁擠：從邊緣一次拉一隻。{npc:2534}（46級）本人站在南邊營地39.6,58.6附近，離{npc:2537}的幽靈只有幾步：與他戰鬥前，先把{npc:2537}往北或往東拉出來。"
	["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and Jon-Jon stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "",

	-- Step 10: Witch Doctor Unbagwa
	-- {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["West into Mistvale: {npc:1449} sits among the gorillas. Any gorilla can drop a fang: hand him ten and stay by him, he calls three waves of gorillas, then {npc:1514}.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "往西進入迷霧谷：{npc:1449}坐在大猩猩之間。任何大猩猩都可能掉落獠牙：交給他十個並待在他身邊，他會召來三波大猩猩，然後是{npc:1514}。\n小心：三波大猩猩接連而來，中間幾乎沒有休息，之後是{npc:1514}。滿血滿魔再開始，並待在安巴格瓦附近。有些職業單人會很吃力：找個朋友就輕鬆了。",

	-- Step 11: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "{area:1577}：遇到就殺",
	-- {object:759} Holy Spring · {area:43} Wild Shore · {area:35} Booty Bay
	["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them.\nFollow the coast south. If you still need the {area:43} pirates, take the road past the {area:35} tunnel to the beach before going into town."] = "",

	-- Step 12: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:35} Booty Bay
	["From the north, take the outer shore east of the {area:35} tunnel. Work south-west through the swashbucklers (41-43) into the camp; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Stay ashore."] = "",

	-- Step 13: Bloodsail tents and rowboat
	["Bloodsail tents and rowboat"] = "",
	["Search the tents and the rowboat for both papers; if one place is empty, try the next. Neither paper is on a ship."] = "",

	-- Step 16: Booty Bay
	-- {area:35} Booty Bay · {npc:2494} Privateer Bloads · {npc:2498} Crank Fizzlebub · {npc:737} Kebok · {npc:773} Krazek
	["In {area:35}: {npc:2494} on the docks, {npc:2498} inside the inn, MacKinley, {npc:737} and {npc:773} upstairs."] = "在{area:35}：{npc:2494}在碼頭上，{npc:2498}在旅店裡，麥金利、{npc:737}和{npc:773}在樓上。",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}，室內",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "“海狼”麥金利，在頂層",

	-- Step 17: Fin Fizracket
	-- {npc:2486} Fin Fizracket
	["{npc:2486}, by the inn"] = "",

	-- Step 18: Whiskey Slim and Fin Fizracket
	-- {npc:2491} Whiskey Slim · {npc:2486} Fin Fizracket
	["{npc:2491} and {npc:2486}"] = "",
	-- {area:35} Booty Bay · {npc:2491} Whiskey Slim
	["Under 40 on your first {area:35} visit? {npc:2491}, in the inn, and \"Sea Wolf\" MacKinley, on the top floor, have their quests for you now."] = "第一次來{area:35}時還不到40級？旅店裡的{npc:2491}和頂樓的“海狼”麥金利現在就有任務給你。",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "{npc:2491}，在旅店裡：他的酒瓶衝到{zone:1425}海岸上，大約48級",
	-- {quest:2872} Stoley's Debt · {npc:7881} Stoley · {zone:1446} Tanaris
	["MacKinley, on the top floor: {quest:2872}, for {npc:7881} in {zone:1446} on this guide"] = "",

	-- Step 19: Fin Fizracket
	-- {quest:348} Stranglethorn Fever · {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["Group quest: {quest:348} ends at {npc:1449} in Mistvale. Hand him ten gorilla fangs and he calls three waves of gorillas (41-42), one after another, then {npc:1514} (44). In players' recordings, 12 of the 27 people who started it died there. Take it if you have a friend or two along."] = "小隊任務：{quest:348}在薄霧山谷的{npc:1449}處結束。交給他十顆大猩猩獠牙，他會召來三波大猩猩（41-42），一波接一波，然後是{npc:1514}（44）。玩家記錄中，開始此任務的27人裡有12人死在那裡。如果有一兩個朋友同行就接。",
	-- {npc:2486} Fin Fizracket · {quest:348} Stranglethorn Fever
	["{npc:2486}, beside the inn: {quest:348}"] = "{npc:2486}，在旅店旁邊：{quest:348}",

	-- Step 20: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["North into Mistvale, a short ride from {area:35}: {npc:1449} sits among the gorillas. Hand him ten gorilla fangs and stay by him: three waves of gorillas, then {npc:1514}. Start at full health and mana."] = "",

	-- Step 22: Kebok
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}，樓上",

	-- Step 23: Krazek
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}, later in this guide"] = "{npc:773}，在樓上：用於本指南稍後在{area:976}的{quest:2864}",

	-- Step 26: Unfinished Wild Shore errands
	-- {area:43} Wild Shore
	["Unfinished {area:43} errands"] = "",
	["If the town rewards just brought you to 42 and you still owe pirate work, use the shore tents, not the ships."] = "",

	-- Step 30: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35}飛行管理員",

	-- Step 31: Grom'gol Base Camp
	-- {object:3202} Grom'gol · {npc:2519} Kin'weelay · {npc:2465} Far Seer Mok'thardin
	["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then back to the flight master."] = "",

	-- Step 34: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "飛往{area:75}",
	-- {object:3202} Grom'gol · {area:75} Stonard · {area:1978} Misty Reed Post
	["Stranglethorn's errands are done: from {object:3202}'s flight master, fly on to {area:75} for the swamp's coast and {area:1978}, which fit you now."] = "",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 35: To Stonard
	-- {area:75} Stonard
	["To {area:75}"] = "前往{area:75}",
	-- {area:75} Stonard · {object:3202} Grom'gol · {zone:1431} Duskwood · {zone:1430} Deadwind Pass
	["No flight path to {area:75} yet: ride north-east from {object:3202} through {zone:1431} and {zone:1430} into the swamp, then east along the road to {area:75}, and learn its flight path."] = "",

	-- Step 36: Stonard
	-- {quest:698} Lack of Surplus · {quest:1424} Pool of Tears · {quest:1430} Fresh Meat · {npc:5593} Katar · {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["The Stranglethorn & Swamp guide already finished {quest:698}' first part and the {quest:1424} with you; its {quest:1430} and {npc:5593}'s murlocs are in your log. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}，在裡面",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}，在頂層",

	-- Step 37: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "沿道路向西騎；卷軸在沼澤最西邊的水邊。",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, on the Dustwallow guide"] = "",

	-- Step 38: A Soggy Scroll
	["The scroll lies at the water's edge in the swamp's far west."] = "卷軸在沼澤最西邊的水邊。",

	-- Step 39: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "鹽齒鱷魚",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "鱷魚泡在加倫舊營地周圍的水塘裡，就在{area:75}以北，在往東回來的路上；大約四個掉一個側肉。",

	-- Step 40: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "向東經過{area:75}：阿塔萊的文物在{quest:1424}的水中和岸邊。",

	-- Step 41: Misty Reed Post
	-- {npc:5592} Tok'Kar · {npc:5593} Katar
	["Follow the road south-east to the small Horde post on the shore: {npc:5592} and {npc:5593}."] = "",

	-- Step 42: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "{area:2403}：遇到就殺",
	-- {npc:272377} Methuselah Crab
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too.\nCareful: a {npc:272377} (level 60) walks the south-east strand: give it a wide berth."] = "鉗嘴龜分佈在崗哨南邊的海灘。\n巨型淤泥蟹沿東海岸的沙灘遊蕩，數量少且分散；看到就殺，從水池騎行南下途中遇到的也別漏掉。\n小心：一隻{npc:272377}（60級）在東南部的海灘上走動：遠遠繞開它。",
	["Underwater"] = "在水下",

	-- Step 44: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "蘆葦崗哨的魚人",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "沼澤魚人住在哨站南邊的海灘；沼澤噴墨魚人在哨站東邊的岸邊，沼澤食腐魚人在更西邊、西岸的小屋周圍。",

	-- Step 46: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "又是同一段魚人海岸：噴墨者在哨站以東，食肉者在西邊的棚屋周圍，神諭者混在兩者中間。",

	-- Step 48: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 49"] = "",

	-- Step 49: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "飛往{area:1497}",
	-- {area:75} Stonard · {area:1497} Undercity · {area:340} Kargath · {npc:5204} Apothecary Zinge · {zone:1454} Orgrimmar
	["From {area:75}'s flight master, fly to the {area:1497} (by way of {area:340}): {npc:5204}'s errands and your {area:1497} training, then the zeppelin from the towers outside the city to {zone:1454}."] = "",

	-- Step 50: Apothecary Zinge
	-- {npc:2934} Keeper Bel'dugur
	["{npc:2934}, on the way back to Zinge"] = "{npc:2934}，在回去找辛吉的路上",
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "這些差事給{item:8523}：留著，塔納利斯野外取樣會在{area:976}還給你",

	-- Step 51: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}，{object:36126}",

	-- Step 52: Riding at 40
	["Riding at 40"] = "40級騎術",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {zone:1454} Orgrimmar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {zone:1454} zeppelin."] = "",
	-- {npc:4773} Velma Warnam
	-- was: ["{npc:4773}, riding trainer"] = "{npc:4773}，騎術訓練師"
	["{npc:4773}, riding trainer"] = "",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "骷髏馬：{npc:4731}，在{area:159}的{npc:4773}旁邊。",

	-- Step 53: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",

	-- Step 54: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "{zone:1454}中部",

	-- Step 55: Orgrimmar
	-- {zone:1458} Undercity
	["the {zone:1458}'s classes trained there on the way"] = "",

	-- Step 56: Riding at 40
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "騎術需要40級，費用100金；學會後會得到一匹坐騎。{npc:4752}在{object:172958}教導獸人，位於{npc:3362}的狼舍旁。天裔精靈向微風島{area:16638}的{area:17684}的{npc:265756}學習，並得到一隻逐風者：前往島上的天空船約每五分鐘從{zone:1456}北邊、{area:17045}南側的懸崖出發。你種族的其他坐騎每匹20金：收藏品的「坐騎 · 40級」每一匹都有指南。",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}，騎術訓練師",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "狼：{npc:3362}，在{npc:4752}旁邊。",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "騎術與逐風者：{npc:265756}，在微風島{area:16638}的{area:17684}。",

	-- Step 58: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "騎術需要40級，花費100金；學會即獲得坐騎。每個種族向本族的訓練師學習：你的是{area:367}的{npc:7953}，沿{zone:1411}大道從{zone:1454}向南騎一小段就到，旁邊是佐爾尼爾的迅猛龍（每隻20金）。之後騎回{zone:1454}的飛行管理員那裡。",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "騎術訓練師{npc:7953}",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "迅猛龍：祖尼爾，在{area:367}的{npc:7953}旁邊。",

	-- Step 59: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飛往{area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}的飛行管理員",

	-- Step 61: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins)."] = "你的訓練師在{zone:1456}：{npc:3033}（德魯伊）在{area:1639}，{npc:246344}（聖騎士）。",

	-- Step 63: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "騎術需要40級，費用100金；學會後會得到一匹坐騎。每個種族都向自己種族的訓練師學習：你的訓練師是{area:222}的{npc:3690}，{npc:3685}的科多獸（每隻20金）就在他旁邊。之後騎回{zone:1456}的飛行管理員那裡。",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}，騎術訓練師",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "科多獸：{npc:3685}，在{area:222}的{npc:3690}旁邊。",

	-- Step 64: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "飛往{area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飛行管理員",

	-- Step 65: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飛往{area:976}",

	-- Step 68: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "前往{area:392}學地獄戰馬",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to {area:392}; {npc:6251} stands on the hill above the docks."] = "從{zone:1454}飛往{area:392}；{npc:6251}站在碼頭上方的山丘上。",

	-- Step 69: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}飛行管理員",

	-- Step 75: Gadgetzan
	-- {area:976} Gadgetzan · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["Flown in: {area:976}'s quests first, by the flight master, then the {area:2240} is a short ride north over the {zone:1446} border."] = "飛抵後：先做{area:976}飛行管理員旁的任務，然後越過{zone:1446}邊界往北騎一小段就到{area:2240}。",
	-- {npc:7407} Chief Engineer Bilgewhizzle · {npc:5204} Apothecary Zinge · {item:8523} Field Testing Kit · {zone:1458} Undercity
	["{npc:7407}: {npc:5204}'s {item:8523}, from the {zone:1458}"] = "",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}: the water pouches come from the same Wastewander camps"] = "",

	-- Step 76: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7804} Trenton Lighthammer · {quest:3042} Troll Temper
	["For your {area:978} run, in the next guide: {quest:2864} wants scarab shells, and {npc:7804}, a short walk from the flight master, {quest:3042} from the Sandfury trolls."] = "為了你在下一份指南中的{area:978}之行：{quest:2864}要聖甲蟲殼，離飛行管理員不遠的{npc:7804}要沙怒食人妖身上的{quest:3042}。",

	-- Step 77: Mirage Raceway
	-- {area:976} Gadgetzan · {zone:1446} Tanaris · {area:484} Freewind Post · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["Flown in to {area:976}: the raceway is a short ride north over the {zone:1446} border.\nThe road from {area:484} to {zone:1446} runs past the {area:2240} on the {area:439}: {npc:4454} is in the gnomes' camp beside the track, {npc:4630} and {npc:4709} by the goblins' camp. {npc:4630} first, then {npc:4709}, who runs off to keep Rizzle busy; then take Rizzle's plans from the gnomes' camp and bring them back to {npc:4630}."] = "飛到{area:976}後：賽道就在北邊不遠處，越過{zone:1446}邊界即到。\n從{area:484}通往{zone:1446}的道路經過{area:439}的{area:2240}：{npc:4454}在賽道旁的侏儒營地，{npc:4630}和{npc:4709}在地精營地旁。先找{npc:4630}，再找{npc:4709}；後者會跑去分散瑞茲爾·銅栓的注意力。趁機從侏儒營地拿走瑞茲爾·銅栓的計劃，帶回給{npc:4630}。",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "{npc:4454}：{quest:1137}，來自 {zone:1418} 的馬特克",
	-- {npc:4630} Pozzik · {npc:2496} Baron Revilgaz · {area:35} Booty Bay
	["{npc:4630}: {npc:2496}'s word, from {area:35}"] = "",
	-- {npc:4706} Razzeric · {npc:4630} Pozzik
	["{npc:4706}, beside {npc:4630}"] = "{npc:4706}，在{npc:4630}旁邊",

	-- Step 78: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "前往{area:976}",

	-- Step 79: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976}是剛過{zone:1446}邊界、有圍牆的哥布林城鎮。",

	-- Step 81: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "{area:1937}：遇到就殺",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	-- was: ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "強盜和竊賊在{area:976}東邊的沙丘上紮營。每個廢土敵人都可能帶著水袋：魯葛蘭克要五個。\n小心：廢土遊蕩者（43-44級）會潛行移動，可能在你沒察覺時接近。"
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five, and Bilgewhizzle five more.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "",

	-- Step 82: Gadgetzan
	-- {zone:1446} Tanaris
	["Keep the Model 4711-FTZ Power Source Bilgewhizzle gave you: it starts Tanaris Field Sampling, a two-hour timer, for the {zone:1446} guide at about 48, on the way back north from Scrimshank's hive."] = "",

	-- Step 83: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "向東北騎往海岸上的哥布林港口。",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "{npc:7882}，在屋裡",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "{npc:7881}，在屋裡",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on this guide's west sweep"] = "",
	-- {npc:260405} Wharfmaster Steamfizzle · {zone:2548} Riverglades
	["{npc:260405}, on the pier: Friz's errand from the {zone:2548}, if you carry it"] = "{npc:260405}，在碼頭上：如果你帶著弗利茲從{zone:2548}託付的差事",

	-- Step 84: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "{area:1336}：遇到就殺",
	-- {npc:7883} Andre Firebeard · {item:9276} Pirate's Footlocker · {item:9250} Ship Schedule · {area:977} Steamwheedle Port
	-- was: ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "沿著海岸往南，南海海盜佔據著海灣。{npc:7883}和被偷的貨物在海灣盡頭的碼頭上。任何海盜都可能掉落帽子，南海綁匪最常掉。\n小心：{npc:7883}（45級）身邊站著兩三個海盜，戰鬥一開始，城裡還會有更多海盜加入：先把他的護衛從他身邊拉開。"
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first.\nThe cove's pirates sometimes drop a {item:9276}: open it, and if it holds a {item:9250}, read it to start a quest for the Security Chief in {area:977}."] = "",
	["Upstairs"] = "樓上",
	-- {item:9250} Ship Schedule · {item:9276} Pirate's Footlocker
	["{item:9250}, from a {item:9276}"] = "",

	-- Step 85: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "{area:985}：遇到就殺",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "廢土暗法師、盜賊和刺客在{area:976}東南方紮營。\n加基森東南方，廢土強盜在沙丘裡紮營；{npc:7847}在東邊的營地。\n注意：廢土盜賊脫戰時一直保持潛行，所以你在營地開打時可能有隱藏的盜賊加入。\n注意：兩名潛行的廢土盜賊無論他走到哪都跟著。在他出現的營地，兩名暗法師及其僕從離得很近，會加入戰鬥。在瞭望塔那邊可以單獨打他。",

	-- Step 86: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what {area:1336} gave you. {area:976} is west of it."] = "向東北騎回港口：{npc:7881}、{npc:15165}和保安隊長會收下{area:1336}給你的東西。{area:976}在它西邊。",
	-- {area:35} Booty Bay
	["for {area:35}, around level 51 (40-50/06)"] = "給{area:35}，約51級時（40-50/06）",
	-- {npc:7882} Security Chief Bilgewhizzle · {item:9250} Ship Schedule
	["{npc:7882}: the {item:9250}, if the cove gave you one"] = "",

	-- Step 88: Fly to Freewind Post
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}飛行管理員",

	-- Step 90: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "{npc:7777}在{area:1099}一帶走動：檢視地圖上的圓圈範圍",
	-- {npc:8115} Witch Doctor Uzer'i · {npc:263190} Tan'jani · {zone:2548} Riverglades
	["{npc:8115}: {npc:263190}'s errand from the {zone:2548}, if you carry it"] = "{npc:8115}：如果你帶著{npc:263190}從{zone:2548}託付的差事",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	-- was: ["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}：給{zone:1454}，約45級時"
	["{npc:8115}: for {zone:1454}, around level 47"] = "",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}，在屋裡",

	-- Step 91: Gordunni Outpost
	-- {npc:222233} Ohk'zi · {item:9466} Orwin's Shovel · {object:144064} Gordunni Dirt Mound
	-- was: ["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "在豺狼人北邊，巨魔佔據山頂的前哨站；把巨魔法師拉過來打。鈷礦在前哨站周圍的土堆裡，卷軸就在前哨站裡的地上。\n小心：{npc:222233}（43級，精英）站在前哨站裡：把巨魔拉出來，遠離他。"
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him.\nUse {item:9466} on each {object:144064} around the outpost: the arrow goes from mound to mound."] = "",

	-- Step 92: Woodpaw north camp
	["Woodpaw north camp"] = "木爪北方營地",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "木爪豺狼人在莫沙徹營地西北方的山丘上紮營；他們每一個都可能掉落鬃毛。\n小心：除了突擊隊員以外，每個木爪豺狼人血量降到15%時都會跑去求援，可能把更多豺狼人引進戰鬥。",

	-- Step 93: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}：從現在起一小時內",

	-- Step 94: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "{zone:1444}：沿途遇到就擊殺",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "小精龍在莫沙徹營地西邊的樹林上空飛舞；幾乎每一隻都會掉落翅膀。木爪突擊隊員帶領著西南方的營地：在一小時內殺掉他們。\n小心：大多數突擊隊員待在小帳篷營地裡，身邊有2-4隻其他豺狼人會一起參戰，還有其他豺狼人在營地之間巡邏。",

	-- Step 96: Grimtotem camp
	["Grimtotem camp"] = "恐怖圖騰營地",
	-- {npc:222286} Namida Grimtotem
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns.\nCareful: {npc:222286} (level 43, elite) stands in the camp: pull the raiders and shamans away from her."] = "恐怖圖騰牛頭人在小精龍的樹林旁紮營；恐怖圖騰襲擊者、博學者和薩滿都帶著角。\n小心：{npc:222286}（43級，精英）站在營地裡：把襲擊者和薩滿從她身邊拉開。",

	-- Step 97: Woodpaw battle map
	["Woodpaw battle map"] = "木爪戰鬥地圖",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "戰鬥地圖在莫沙徹營地南邊的木爪營地裡。",

	-- Step 98: Camp Mojache
	-- {npc:7875} Hadoken Swiftstrider · {quest:7731} Stinglasher · {zone:1445} Dustwallow Marsh
	["Carrying Tabetha's Task? {npc:7875} doesn't offer {quest:7731} while it is in your quest log: hand it in to Tabetha in {zone:1445} or abandon it first."] = "",
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 47"] = "",

	-- Step 99: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber.\nCareful: {quest:7731} is level 47: clear the hive around him and pull him alone at full health."] = "祖卡什蟲巢鑽進營地東南方的山丘裡；{quest:7731}在最深處的洞室等著。\n小心：{quest:7731}是47級：先清掉他周圍的蟲子，滿血時單獨把他拉出來。",

	-- Step 100: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "{area:2522}：遇到就殺",
	-- {area:1105} Feral Scar Vale
	["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb.\nCareful: the Mage-Lords (45-46) and the Shamans cast from range and the ruins are packed: pull one at a time from the edge."] = "從蟲巢向西騎往{area:1105}下方的食人魔遺跡。裡面滿是戈杜尼薩滿、術士和虐待者；南端的戈杜尼大法師帶著寶珠。\n小心：大法師（45-46級）和薩滿會遠程施法，遺跡裡敵人密集：從邊緣一次拉一隻。",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "{npc:5234}在{area:2522}一帶走動：檢視地圖上的圓圈範圍",

	-- Step 101: Feral Scar Vale yetis
	-- {area:1105} Feral Scar Vale
	["{area:1105} yetis"] = "{area:1105}的雪人",
	-- {area:1105} Feral Scar Vale
	["North-west of the ruins, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "在廢墟西北，雪人在{area:1105}築巢；那裡的每個雪人都可能掉落厚重的雪人皮。",

	-- Step 102: Rogue Vale screechers
	["Rogue Vale screechers"] = "遊蕩的山谷尖嘯者",
	-- {area:1099} Camp Mojache · {area:1105} Feral Scar Vale · {item:10699} Yeh'kinya's Bramble · {npc:8579} Yeh'kinya · {area:977} Steamwheedle Port · {zone:1446} Tanaris
	-- plural, as words: Rogue Vale Screechers = {npc:5308} Rogue Vale Screecher
	["On the way back north-east towards {area:1099}, the Rogue Vale Screechers (44-46) hunt the open ground north of {area:1105}. Kill one, use {item:10699} on its body before you loot it, then talk to the spirit that rises: it is friendly. Three spirits in all; {npc:8579} takes them in {area:977} on your next {zone:1446} visit."] = "",

	-- Step 103: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "僅當你有定位器時：{zone:1444}的任何野獸、豺狼人或食人魔都可能掉落它，大約每殺一百隻掉一個；使用它開始任務。機器人在{area:1105}北側的一個小山洞裡，就在廢墟西北不遠。護送它到{area:1108}的碼頭；途中會有雪人和猩猩伏擊你。它的獎勵在{area:35}，留到之後再去領取。\n小心：護送過程中會出現三次伏擊，機器人每次都會提前警告你。第一次是3隻雪人，就在機器人離開山洞、爬向道路之後。第二次是3隻猩猩，在沿懸崖延伸的小路上。第三次是大約4個豺狼人，其中一個是施法者，在路線轉向碼頭的地方。",

	-- Step 104: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "狂怒疤痕雪人，下次來{zone:1444}時",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "{npc:7875}：為{zone:1454}的{npc:7010}",
	-- {zone:1454} Orgrimmar · {zone:2652} Shen'dralas
	["for {zone:1454}, after {zone:2652}"] = "給{zone:1454}，在{zone:2652}之後",
	-- {zone:2652} Shen'dralas · {area:1099} Camp Mojache · {zone:1443} Desolace · {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {npc:7311} Uthel'nay
	["{zone:2652} is next, a ride north from {area:1099} into {zone:1443}: keep your {zone:1454} hand-ins (Neeru, Zilzibin, {npc:4485}, {npc:7311}) for the flight there after it."] = "下一站是{zone:2652}，從{area:1099}往北騎進{zone:1443}：{zone:1454}的繳交任務（尼魯、齊茲畢、{npc:4485}、{npc:7311}）留到之後飛過去時再交。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into town. The ships' captains, Seahorn's next request, are for your Stranglethorn stop at about 50."] = "回到鎮上。船長們是希爾霍恩的下一個請求，留到你大約50級回荊棘谷時再做。",
	-- ["Eastern Wastewander camps"] = "東部廢土營地",
	-- ["Fly to {area:1637}"] = "飛往{area:1637}",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "飛往{area:1637}。杜佛斯兄弟在城裡開店。",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "飛往{area:484}，搭崗哨東邊的升降梯下去，穿過鹽灘，再向南進入{zone:1446}。",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "飛往{area:484}，然後向西騎過峽谷經過{area:2237}；道路爬升進入{zone:1444}的叢林，一路通往{area:1099}。",
	-- ["Fly to {zone:1454}. From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "飛往{zone:1454}。從飛行管理員出發：先到{object:172960}，再到暗巷區，然後是{object:172958}。",
	-- ["Hearth to {area:1099}"] = "使用爐石前往{area:1099}",
	-- ["In {area:35}: {npc:2494} on the docks, {npc:2486} by the inn, {npc:2498} inside it, MacKinley, {npc:737} and {npc:773} upstairs."] = "在{area:35}：{npc:2494}在碼頭上，{npc:2486}在旅店旁，{npc:2498}在旅店裡，麥金利、{npc:737}和{npc:773}在樓上。",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "繼續向西騎到海岸。海灘上的海灘龍蝦人先知和海灘利爪龍蝦人大約每擊殺四十隻會掉落一個OOX-22/FE定位器：如果掉了，使用它開始任務。",
	-- ["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "在豺狼人北邊，巨魔佔據山頂的前哨站；把巨魔法師拉過來打。鈷礦在前哨站周圍的土堆裡，卷軸就在前哨站裡的地上。\n小心：{npc:222233}（43級，精英）站在前哨站裡：把巨魔拉出來，遠離他。",
	-- ["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "繼續往西南到迷霧谷東北邊的叢林：三個海盜幽靈在贊吉爾的營地旁出沒。{npc:2535}和{npc:2536}站在一起，{npc:2537}在更東邊。贊吉爾的每個追隨者都可能帶著混合物。\n小心：贊吉爾巫醫（44級）會施法，而且營地很擁擠：從邊緣一次拉一隻。{npc:2534}（46級）本人站在南邊營地39.6,58.6附近，離{npc:2537}的幽靈只有幾步：與他戰鬥前，先把{npc:2537}往北或往東拉出來。",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "只有在你有定位器時：機器人在{area:1105}北側的小洞穴裡。護送它到{area:1108}的碼頭；途中雪人和猩猩會伏擊你。它的獎勵在{area:35}等你稍後去領。",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "從{area:1978}向西北騎回{area:75}，飛往{object:3202}。",
	-- ["Ride back west to {area:976}."] = "向西騎回{area:976}。",
	-- ["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "從蟲巢向西騎往{area:1105}下方的巨魔遺跡。裡面滿是戈杜尼薩滿、術士和虐待者；南端的戈杜尼大法師帶著寶珠。",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "向西騎進{zone:1444}中部。擊殺一隻{npc:5308}，對牠的屍體使用{item:10699}，並擊殺升起的靈魂。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "騎術需要40級，費用100金；學會後會得到一匹坐騎。在經典版中，每個種族都向自己種族的訓練師學習：你的訓練師是{area:159}的{npc:4773}，{npc:4731}的骸骨戰馬（每匹20金）就在她旁邊。Forever 可能允許任何種族向任何騎術訓練師學習（未確認）：先試試{zone:1454}{object:172958}的{npc:4752}，因為他最近；如果他能教你，就跳過此步驟。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "騎術需要40級，費用100金；學會後會得到一匹坐騎。在經典版中，每個種族都向自己種族的訓練師學習：你的訓練師是{zone:1411}海岸{area:367}的{npc:7953}，祖尼爾的迅猛龍（每隻20金）就在他旁邊。Forever 可能允許任何種族向任何騎術訓練師學習（未確認）：先試試{zone:1454}{object:172958}的{npc:4752}，因為他最近；如果他能教你，就跳過此步驟。",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "骸骨戰馬：{npc:4731}，在{area:159}的{npc:4773}旁邊。",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "沿著海岸往南，南海海盜佔據著海灣。{npc:7883}和被偷的貨物在海灣盡頭的碼頭上。任何海盜都可能掉落帽子，南海綁匪最常掉。\n小心：{npc:7883}（45級）身邊站著兩三個海盜，戰鬥一開始，城裡還會有更多海盜加入：先把他的護衛從他身邊拉開。",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "沿著海岸往南，南海海盜佔據著海灣。{npc:7883}和被偷的貨物在海灣盡頭的碼頭上。任何海盜都可能掉落帽子，南海綁匪最常掉。\n小心：{npc:7883}身邊站著兩三個海盜，戰鬥一開始，城裡還會有更多海盜加入。",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "在藏寶海灣南邊，血帆流氓在{area:43}紮營；海圖和命令在他們的帳篷裡，以及較大營地旁的小船裡。任何血帆海盜都可能帶著鼻煙和{npc:2493}的眼睛，所以持續擊殺直到兩樣都拿到。",
	-- ["Southern Gordunni ruins"] = "南部戈杜尼遺跡",
	-- ["Southern Wastewander camps"] = "南部廢土營地",
	-- ["Sprite darters and Woodpaw alphas"] = "小精龍與木爪突擊隊員",
	-- ["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "祖卡什蟲巢鑽進營地東南方的山丘裡；{quest:7731}在最深處的洞室等著。",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "強盜和竊賊在{area:976}東邊的沙丘上紮營。每個廢土敵人都可能帶著水袋：魯葛蘭克要五個。\n小心：廢土遊蕩者（43-44級）會潛行移動，可能在你沒察覺時接近。",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "強盜和竊賊在{area:976}東邊的沙丘上紮營。每個廢土敵人都可能帶著水袋：保留十個，魯葛蘭克的兩個懸賞各五個。\n小心：廢土遊蕩者（43-44級）會潛行移動，可能在你沒察覺時接近。",
	-- ["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "飛行降落在{object:3202}。你第一次來時帶著的荊棘谷較難任務，現在正適合你：碎顱者酋長、贊吉爾的營地、{area:35}的海盜、娜迦海岸和{npc:1514}，之後再搭飛艇前往{zone:1454}。尼姆布亞旁邊的{object:2076}有碎顱者酋長的任務。",
	-- ["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then the zeppelin tower."] = "飛行降落在{object:3202}：{npc:2519}和{npc:2465}，然後前往飛艇塔。",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "暗法師、遊蕩者和刺客在{area:976}東南方紮營。",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "前往{object:3202}的飛艇從{zone:1454}正門東北方不遠處的塔出發。",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "前往{zone:1454}的飛艇從{object:3202}旁的塔出發；它降落在{zone:1454}正門外不遠處。",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "飛行管理員塞斯塔就站在飛艇塔東邊。飛往{area:75}：下一份指南從那裡開始。",
	-- ["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them. Then follow the coast south to {area:35}."] = "往西到海岸：娜迦探險者在岸邊涉水，身上帶著蘆葦束；{object:759}就在牠們東邊不遠的山丘上冒泡。然後沿著海岸往南到{area:35}。",
	-- ["Zeppelin to {object:3202}"] = "搭飛艇前往{object:3202}",
	-- ["Zeppelin tower"] = "飛艇塔",
	-- ["for the {zone:1425}, around level 48"] = "給{zone:1425}，約48級時",
	-- ["for {area:35}, around level 50"] = "給{area:35}，約50級時",
	-- ["for {zone:1454}, around level 45"] = "給{zone:1454}，約45級時",
	-- ["the {object:150075} in the square"] = "廣場上的{object:150075}",
	-- ["water pouches in your bags"] = "背包裡的水袋",
	-- ["{area:1099} flight master"] = "{area:1099}飛行管理員",
	-- ["{area:976} is the walled goblin town just past the {area:440} border."] = "{area:976}是剛過{area:440}邊界、有圍牆的哥布林城鎮。",
	-- ["{npc:2488}, on the top floor"] = "{npc:2488}，在頂層",
	-- ["{npc:4630}: the {item:5852} from {npc:2496}, if you carry them"] = "{npc:4630}：如果你身上有{npc:2496}給的{item:5852}，交給他",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}，騎術訓練師",
	-- ["{npc:6986}, the Drag"] = "{npc:6986}，在城裡",
	-- ["{npc:7010}, the Drag"] = "{npc:7010}，暗巷區",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}，騎術訓練師",
	-- ["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}：給{zone:1454}，約45級時",
	-- ["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "{npc:8579}：尖嘯者住在{zone:1444}，下次造訪{zone:1444}時",
}
