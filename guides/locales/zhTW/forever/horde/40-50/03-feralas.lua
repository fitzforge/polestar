-- Chinese (traditional) (zhTW): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1454} Orgrimmar · {area:1099} Camp Mojache · {area:511} Wyrmbog · {area:496} Brackenwall Village
	["{zone:1454}'s hand-ins, {area:1099}'s Muisek vessel, then Dustwallow's {area:511} and {area:496}."] = "{zone:1454}的繳交任務、{area:1099}的梟獸穆西克之瓶，然後是塵泥沼澤的{area:511}和{area:496}。",
	["Takes you to level 47"] = "帶你升到47級",
	-- {zone:1446} Tanaris
	["Then on to {zone:1446}"] = "接著前往{zone:1446}",
	["Stays on the main route"] = "留在主要路線上",
	-- {zone:2652} Shen'dralas · {zone:1446} Tanaris
	["Skips {zone:2652}: about a dozen fewer quests, a third of a level lower into {zone:1446}"] = "跳過{zone:2652}：少做大約十幾個任務，進入{zone:1446}時低約三分之一級",

	-- Step 1: Orgrimmar
	-- {object:172960} Cleft of Shadow · {object:172958} Valley of Honor
	["From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "從飛行管理員那裡出發：經過{object:172960}，再穿過暗巷，然後到{object:172958}。",
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag"] = "{npc:7010}，暗巷區",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}，在城裡",
	-- {zone:1425} Hinterlands
	-- was: ["for the {zone:1425}, around level 50"] = "給{zone:1425}，約50級時"
	["for the {zone:1425}, around level 49"] = "",

	-- Step 3: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飛往{area:1638}",
	-- {area:1638} Thunder Bluff · {area:1099} Camp Mojache
	["Your trainer is in {area:1638}, on the way to {area:1099}."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}的飛行管理員",

	-- Step 5: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "飛往{area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飛行管理員",

	-- Step 6: Fly to Camp Mojache
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {zone:1446} Tanaris
	["Fly to {area:1099} (or hearth there, if your hearthstone is ready: it is still bound there from the {zone:1444} & {zone:1446} guide)."] = "",

	-- Step 7: Camp Mojache
	-- {zone:1425} Hinterlands
	-- was: ["for the {zone:1425} owlbeasts, around level 48"] = "之後給{zone:1425}的梟獸，約48級"
	["for the {zone:1425} owlbeasts, around level 49"] = "",

	-- Step 8: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "飛往{area:496}",
	-- {zone:1444} Feralas · {zone:1446} Tanaris · {area:496} Brackenwall Village
	["No Muisek vessel to bring Uzer'i (you didn't take the {zone:1444} & {zone:1446} guide's chain): fly from here straight to {area:496}."] = "",

	-- Step 9: Fly to Brackenwall Village
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "{area:1099}飛行管理員",

	-- Step 10: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "{npc:4500}、{npc:4502}和{npc:4501}（在地下）都在村裡；他們的任務是這一趟去{area:511}要做的。",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "{npc:4501}，在地下",

	-- Step 11: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "{object:2555}",

	-- Step 12: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "向西南騎往{object:2555}。",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "在{area:498}內部",

	-- Step 13: The Musty Scroll
	-- {object:2555} Musty Scroll
	["The {object:2555} lies to the south-west."] = "{object:2555}在西南方。",

	-- Step 14: Mudsprocket
	["Mudsprocket"] = "泥鏈營地",
	-- {object:2555} Musty Scroll · {area:511} Wyrmbog · {npc:270723} Drazzit Dripvalve · {npc:270727} Gizzix Grimegurgle · {item:280092} Wyrmtail
	["South-east from the {object:2555} to Mudsprocket, the goblin camp at the {area:511}'s western edge: {npc:270723} and {npc:270727} stand together in the camp. Their whelps, scales and {item:280092} come on the same {area:511} loop as Brackenwall's quests."] = "從{object:2555}向東南前往{area:511}西緣的哥布林營地泥鏈營地：{npc:270723}和{npc:270727}一起站在營地裡。他們要的雛龍、鱗片和{item:280092}在與蕨牆村任務相同的{area:511}路線上。",

	-- Step 15: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "{area:510}：遇到就殺",
	-- {area:511} Wyrmbog · {item:280092} Wyrmtail
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps. The {item:280092} grows in the bog just east of Mudsprocket."] = "向東穿過{area:511}：火鬃斥候和灰尾在其北緣遊蕩，還有灼熱幼龍和雛龍；鱗翼守衛著更東南方的龍洞。莫克莫洛克的鼻菸、烈酒和保險箱在龍人營地裡。{item:280092}長在泥鏈營地東邊的沼澤裡。",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "{npc:4329}在{area:510}一帶走動：檢視地圖上的圓圈範圍",
	["Below ground"] = "地下",

	-- Step 16: Mudsprocket
	["Back to Mudsprocket before you ride north."] = "向北騎行之前先回泥鏈營地。",

	-- Step 17: Brackenwall Village
	["Ride back north to Brackenwall."] = "向北騎回蕨牆村。",

	-- Step 18: Onyxia's eggs
	["Onyxia's eggs"] = "奧妮克希亞的蛋",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "奧妮克希亞的蛋在{area:511}東南部的龍穴中，由火鬃守衛看守；砸碎五個。",

	-- Step 19: Muckshell crabs
	["Muckshell crabs"] = "",
	-- plural, as words: Muckshell Razorclaws = {npc:4405} Muckshell Razorclaw
	["On the way back north from the dragon caves, the Muckshell Razorclaws and Pincers (41-44) crowd the shallows just north of the caves; about one in twenty carries the Jeweled Pendant Marg Speaks asks for."] = "",

	-- Step 20: Level 45.37
	["Level 45.37"] = "等級45.37",
	-- {npc:4500} Overlord Mok'Morokk · {area:511} Wyrmbog · {area:978} Zul'Farrak
	["{npc:4500}'s challenge, back in Brackenwall, needs a group of three. Alone, grind the Firemane scouts here on the {area:511}'s northern edge to level 45.37 before you ride back north, so you don't come back down for it. Or, with a group, run the {area:978} dungeon instead."] = "回到蕨牆村後，{npc:4500}的挑戰需要三人隊伍。單人的話，在騎回北邊之前，先在{area:511}北緣這裡刷火鬃斥候到45.37級，這樣就不用再下來一趟。或者，有隊伍的話，改去打{area:978}地城。",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "刷{npc:4329}",

	-- Step 21: Brackenwall Village
	-- {npc:4791} Nazeer Bloodpike · {item:5942} Jeweled Pendant
	["{npc:4791}: the {item:5942}"] = "",
	-- {npc:4047} Zor Lonetree · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["for {npc:4047} in {zone:1454}, on the {zone:1447} guide's {zone:1454} stop"] = "",
	-- {quest:3128} Natural Materials · {zone:1444} Feralas
	["Keep {quest:3128} and Improved Quality: {zone:1444}' sprites, hippogryphs, Zorbin's coast and the Rage Scar yetis come on your {zone:1444} loop at about 51, with the Muisek chain."] = "",

	-- Step 22: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "這些是精英怪：建議組隊，找人一起做。{quest:1173}需要3人小隊。單人可以跳過：本路線會安排你把經驗刷回來。\n{npc:4500}是精英：建議組隊。把他打到認輸，然後向{npc:4501}覆命。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "向東經過{area:75}：阿塔萊的文物在{quest:1424}的水中和岸邊。",
	-- ["Back to {npc:14637} on the dock."] = "回到碼頭上的{npc:14637}那裡。",
	-- ["Coming from Stranglethorn, you carry these already. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "從荊棘谷過來的話，你已經帶著這些了。從這裡開始：{npc:5591}在{area:75}的大廳裡，{npc:1443}在它的頂層。",
	-- ["Dragon caves"] = "龍穴",
	-- ["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "向東穿過{area:511}：火鬃斥候和火鬃灰尾龍人與灼熱龍崽、灼熱雛龍一起在它北緣遊蕩；碎鱗者守護著更東南的龍穴。莫格穆洛克的鼻菸、烈酒和保險箱都在龍人營地裡。",
	-- ["Fly to {area:75}"] = "飛往{area:75}",
	-- ["Fly to {object:3202}"] = "飛往{object:3202}",
	-- ["Follow the road south-east to the small Horde post on the shore. {npc:5592} takes the crocolisk flanks from the last swamp visit."] = "沿路向東南到岸邊的小部落崗哨。{npc:5592}會收下上次在沼澤打到的鱷魚腹肉。",
	-- ["Forest walkers"] = "森林漫遊者",
	-- ["Frayfeather hippogryphs"] = "亂羽角鷹獸",
	-- ["Hearth to {area:1099}: your hearthstone is still bound there from the {zone:1444} & {zone:1446} guide."] = "用爐石回{area:1099}：你的爐石從{zone:1444}與{zone:1446}指南起就一直綁在那裡。",
	-- ["Monstrous Crawlers"] = "巨型淤泥蟹",
	-- ["Murlocs of the Misty Reed"] = "蘆葦崗哨的魚人",
	-- ["No flight path to {area:75} yet (the {zone:2548} skip the {zone:1435}): ride north-east from {object:3202} through {zone:1431} and {zone:1430} into the swamp, then east along the road to {area:75}, and learn its flight path."] = "還沒有{area:75}的飛行路線（{zone:2548}跳過了{zone:1435}）：從{object:3202}向東北騎，穿過{zone:1431}和{zone:1430}進入沼澤，再沿道路向東前往{area:75}，並學會那裡的飛行路線。",
	-- ["Northspring harpies"] = "北泉鷹身人",
	-- ["On the way back south-east from the coast, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "從海岸往東南回去的路上，狂暴的怒痕雪人住在路旁丘陵中的洞穴周圍。任何一隻也可能掉落{quest:7738}，它會開啟自己的任務。",
	-- ["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "從鷹身人那裡往東南回去的路上，狂暴的怒痕雪人住在路旁丘陵中的洞穴周圍。任何一隻也可能掉落{quest:7738}，它會開啟自己的任務。",
	-- ["Rage Scar yetis"] = "狂暴的怒痕雪人",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "向東騎回營地。留在這裡：下一份指南從飛往{area:976}開始。",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "向西北騎到{area:1108}；{npc:14637}在碼頭上等著。",
	-- ["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "向西南騎到{object:2555}，然後向東穿過{area:511}。火鬃斥候和火鬃灰尾龍人與灼熱幼龍、灼熱雛龍在北緣遊蕩；火鬃守衛守護更東南邊的龍穴。莫格穆洛克大王的鼻煙、烈酒和保險箱在龍人營地中。",
	-- ["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "沿道路向西騎；卷軸在沼澤最西邊的水邊。",
	-- ["Riding at 40"] = "40級騎術",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "騎術需要40級，花費100金幣；學會後會得到一匹坐騎。每個種族都向自己種族的訓練師學習：你的是{area:159}的{npc:4773}，從飛艇塔往北騎一小段就到，旁邊是{npc:4731}的骷髏馬（每匹20金）。之後騎回飛艇塔，搭乘前往{object:3202}的飛艇。",
	-- ["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body before you loot it, then talk to the spirit that rises: it is friendly. Three spirits in all."] = "Rogue Vale就在{npc:14637}碼頭北邊不遠處。擊殺一隻{npc:5308}，拾取之前對屍體使用{item:10699}，然後和出現的靈魂對話：它是友善的。總共三個靈魂。",
	-- ["Rogue Vale screechers"] = "遊蕩的山谷尖嘯者",
	-- ["Sawtooth crocolisks"] = "鹽齒鱷魚",
	-- ["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "海元素和巨型海元素在碼頭周圍的海岸邊漂流。先用{item:18904}電擊巨人：縮小後就失去精英的力量。海岸巨人在水中涉行；大地行者和峭壁巨人在更北邊的山丘遊蕩。",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "骸骨戰馬：{npc:4731}，在{area:159}的{npc:4773}旁邊。",
	-- ["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "山谷南邊，亂羽角鷹獸棲息在山坡上；幾乎每一隻都會掉落肌腱和金屬碎片。",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "往西南，雪人在{area:1105}築巢；那裡的每隻雪人都可能掉落厚皮。",
	-- ["Sprite darters and forest walkers"] = "小精龍與森林漫遊者",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "沼澤魚人住在哨站南邊的海灘；沼澤噴墨魚人在哨站東邊的岸邊，沼澤食腐魚人在更西邊、西岸的小屋周圍。",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "巨型淤泥蟹在東岸的海灘上走動，數量稀少又分散：往南的路上看到就殺。",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "北泉鷹身人在最西北方的山脊上築巢。她們是48-50級，比你高幾級：北泉喚風者會治療，所以先殺她們，並一次只拉一隻。",
	-- ["The Sea Sprays (47-48) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (48-49) do. The Wave and Deep Striders (47-49) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength. Leave the Land Walkers and Cliff Giants (48-50) of the northern hills for your next {zone:1444} visit.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "巨型海元素（47-48級）在碼頭南邊的岸邊遊蕩：牠們和海元素（48-49級）一樣會掉落水元素核心。海浪巨人和深海巨人（47-49級）在同一片海灘外的水中：先用{item:18904}電牠們，縮小後就會失去精英的強度。北邊山丘的大地行者和峭壁巨人（48-50級）留到下次造訪{zone:1444}再打。\n超級壓縮器效果持續兩小時：離開海岸前把兩個任務都交回給{npc:14637}。",
	-- ["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "鱷魚泡在加倫舊營地周圍的水塘裡，就在{area:75}以北，在往東回來的路上；大約四個掉一個側肉。",
	-- ["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "又是同一段魚人海岸：噴墨者在哨站以東，食肉者在西邊的棚屋周圍，神諭者混在兩者中間。",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "同樣的魚人，再加上待在西岸小屋附近的沼澤魚人智者。",
	-- ["The small Horde post on the southern shore."] = "南岸的小型部落哨站。",
	-- ["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too.\nCareful: a {npc:272377} (level 60) walks the south-east strand: give it a wide berth."] = "鉗嘴龜分佈在崗哨南邊的海灘。\n巨型淤泥蟹沿東海岸的沙灘遊蕩，數量少且分散；看到就殺，從水池騎行南下途中遇到的也別漏掉。\n小心：一隻{npc:272377}（60級）在東南部的海灘上走動：遠遠繞開它。",
	-- ["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs.\nCareful: a {npc:272401} (level 60) flies over the forest west of the camp: keep clear of it."] = "小精龍在營地西邊不遠的樹林上空飛舞，身上帶著{item:9589}；再往西一點的森林漫遊者身上帶著斷裂的原木。\n小心：一隻{npc:272401}（60級）在營地西邊的森林上空飛行：遠離牠。",
	-- ["The zeppelin lands at {object:3202}: Stranglethorn's errands are done (40-50/02), so fly straight on to {area:75}."] = "飛艇降落在{object:3202}：荊棘谷的差事已經做完（40-50/02），所以直接飛往{area:75}。",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "前往{zone:1454}的飛艇從{object:3202}旁的塔出發；降落在{zone:1454}正門東北方不遠處。",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["Three zones, lots of travel"] = "三個地區，大量移動",
	-- ["To {area:1099}"] = "前往{area:1099}",
	-- ["To {area:75}"] = "前往{area:75}",
	-- ["Underwater"] = "在水下",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "你從{area:75}開始。在這裡綁定：海岸之後你會用爐石回來。",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "你的訓練師在{area:1638}：飛過去（還沒有那裡的飛行點？飛往{area:378}，向西騎過{zone:1412}），然後繼續前往{area:496}。",
	-- ["Zeppelin to {object:3202}"] = "搭飛艇前往{object:3202}",
	-- ["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",
	-- ["Zeppelin to {zone:1458}"] = "搭飛艇前往{zone:1458}",
	-- ["Zeppelin tower"] = "飛艇塔",
	-- ["for the {npc:5598} in the {zone:1425}, around level 48"] = "之後給{zone:1425}的{npc:5598}，約48級",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "之後在本指南中用於{area:15}的{object:2555}",
	-- ["for the {object:2555} in {zone:1445}, later in this guide"] = "之後在本指南中用於{zone:1445}的{object:2555}",
	-- ["for the {zone:1425} owlbeasts, around level 48"] = "之後給{zone:1425}的梟獸，約48級",
	-- ["for the {zone:1425}, around level 50"] = "給{zone:1425}，約50級時",
	-- ["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "這些差事給{item:8523}：留著，塔納利斯野外取樣會在{area:976}還給你",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108}：遇到就殺",
	-- ["{area:2403}: kill these as you meet them"] = "{area:2403}：遇到就殺",
	-- ["{area:496} flight master"] = "{area:496}飛行管理員",
	-- ["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}，對水中的海浪巨人和深海巨人使用",
	-- ["{item:18958}, from the Sea Sprays"] = "{item:18958}，從巨型海元素身上取得",
	-- ["{npc:1443}, on the top floor"] = "{npc:1443}，在頂樓",
	-- ["{npc:2934}, on the way back to Zinge"] = "{npc:2934}，在回去找辛吉的路上",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500}是精英：建議組隊。把他打到認輸，然後向{npc:4501}報告。",
	-- ["{npc:4773}, riding trainer"] = "騎術訓練師{npc:4773}",
	-- ["{npc:5591}, inside"] = "{npc:5591}，在屋裡",
	-- ["{npc:7776}'s Northspring harpies (48-50) wait for your {zone:1444} visit at about 51: keep the quest."] = "{npc:7776}的北泉鷹身人（48-50級）等你約51級再來{zone:1444}時處理：保留這個任務。",
	-- ["{npc:7825}, the {object:36126}"] = "{npc:7825}，{object:36126}",
	-- ["{npc:7854}, inside"] = "{npc:7854}，在屋裡",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}：之後給{zone:1454}的{npc:7010}，約50級",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}，然後是{object:172960}和{object:172961}。",
	-- ["{object:3202} flight master"] = "{object:3202}飛行管理員",
	-- ["{quest:7738}, a rare drop"] = "{quest:7738}，稀有掉落",
	-- ["{zone:1435} and Dustwallow first, then {zone:1444}."] = "先去{zone:1435}和塵泥沼澤，然後是{zone:1444}。",
}
