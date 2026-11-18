-- Chinese (traditional) (zhTW): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Angerfang Encampment
	-- {object:671518} Tattered Spellbook (no name in this language: may be words) · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}：給{npc:2104}",

	-- Step 2: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook (no name in this language: may be words)
	["South-east from Menethil to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "從米奈希爾港向東南前往龍喉的{area:1036}：第一架投石車就在路上，{object:671518}就在營地裡。",

	-- Step 4: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "這些是精英怪：建議組隊，找人和你一起做。{npc:2091}是32級精英：大多數職業34級能單挑，但你可能需要幫忙。獨自一人就跳過：路線會讓你把經驗刷回來。\n注意：暗影施法者站在他兩側，至少有一個與他連結，所以拉他時它會加入。非精英的百夫長和隊長分散在他那一圈帳篷周圍。",

	-- Step 5: Golm
	-- {npc:271462} Golm · {npc:271338} Ados · {npc:271458} Neru · {npc:271460} Modr · {item:279996} Goaz Stone
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:271462}, {npc:271338}, {npc:271458} and {npc:271460} are level 32 elites, each called up by using the {item:279996} beside it. Skip them if you are alone. {npc:271462} stands in the south-eastern hills."] = "這些是精英怪：建議組隊，找人一起做。{npc:271462}、{npc:271338}、{npc:271458}和{npc:271460}都是32級精英，每隻都要在它旁邊使用{item:279996}才能召喚出來。如果只有你一個人就跳過它們。{npc:271462}站在東南邊的山丘上。",

	-- Step 6: Ados
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "向東北前往{area:1038}：{npc:271338}站在大門旁（使用{item:279996}）。",

	-- Step 7: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "{area:1038}：遇到就殺",
	-- {area:1036} Angerfang Encampment · {quest:98283} Carnage · {area:205} Dun Modr
	["The whelps nest in the hills north-east of the {area:1036}; {quest:98283} prowls further north, and the Razormaw raptors hunt the highlands on the way north to {area:205}.\n{quest:98283} is elite: grouping up is advised."] = "幼龍在{area:1036}東北的山丘裡築巢；{quest:98283}在更北處徘徊，向北去{area:205}途中的高地上還有銳顎迅猛龍捕獵。\n{quest:98283}是精英：建議組隊。",

	-- Step 8: Razormaw nests
	["Razormaw nests"] = "裂齒龍的巢穴",
	-- {quest:98246} Trying Times · {quest:98283} Carnage
	-- plural, as words: Perfect Razormaw Eggs = {item:280132} Perfect Razormaw Egg
	["The Perfect Razormaw Eggs for {quest:98246} lie in the raptors' nests in the hills around {quest:98283}."] = "{quest:98246}要的完好裂齒龍蛋在{quest:98283}周圍山丘上的迅猛龍巢裡。",

	-- Step 9: Neru
	-- {npc:271458} Neru · {area:1038} Dragonmaw Gates · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271458} stands in the hills between the {area:1038} and {area:205} (use the {item:279996})."] = "{npc:271458}站在{area:1038}與{area:205}之間的山丘上（使用{item:279996}）。",

	-- Step 10: The Green Belt
	-- {area:1025} The Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Maddened Rotclaws roam the {area:1025} around {npc:1244}; one of them drops the flesh. {npc:1244} takes the quest only with {quest:98283}'s head too."] = "狂亂的腐爛爪在{npc:1244}周圍的{area:1025}遊蕩；其中一隻會掉肉。{npc:1244}只在你也帶著{quest:98283}的頭時才收任務。",

	-- Step 11: Rethiel the Greenwarden
	-- {quest:98283} Carnage
	["With {quest:98283}'s head and the flesh"] = "帶上{quest:98283}的頭和肉",

	-- Step 12: Dun Modr
	-- {area:205} Dun Modr · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["North along the road to {area:205}. {npc:1071} and {npc:1075} stand together in the dwarves' camp on the east side of the road; the {object:147516} ruins west of it are full of elites."] = "沿路向北到{area:205}。{npc:1071}和{npc:1075}一起站在路東側的矮人營地裡；它西邊的{object:147516}廢墟裡全是精英。",

	-- Step 13: Captive Fire Elemental
	-- {npc:271481} Captive Fire Elemental · {object:147516} Dark Iron · {npc:1364} Balgaras the Foul · {npc:1072} Roggo Harlbarrow
	["These are elite mobs: grouping up is encouraged, look for people to do it with. The {npc:271481} is held at the far west end of the {object:147516} ruins, past level 27-30 elite dwarves, and {npc:1364} (34, elite) can be among them. Lead it east out of the ruins, then hand it in to {npc:1072} in the camp. Skip it if you are alone."] = "這些是精英怪：建議組隊，找幾個人一起做。{npc:271481}守在{object:147516}廢墟最西端，要穿過27-30級的精英矮人，{npc:1364}（34級，精英）也可能在他們中間。把它引出廢墟向東帶，然後交給營地裡的{npc:1072}。只有你一個人就跳過。",

	-- Step 14: Modr
	-- {npc:271460} Modr · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271460} stands in the ruins of {area:205} (use the {item:279996})."] = "{npc:271460}站在{area:205}的廢墟裡（使用{item:279996}）。",

	-- Step 15: Motley Garmason
	-- {quest:303} The Dark Iron War
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["{quest:303} is a group quest: 30 elite Dark Irons (27-31) in the ruins west of the camp. Skip it if you are alone."] = "",
	-- {npc:1074} Motley Garmason
	["{npc:1074}, in the camp"] = "",

	-- Step 16: Ashlan Stonesmirk
	-- {quest:88756} Bring Back a Bang · {item:280806} Stolen Explosives · {object:147516} Dark Iron · {area:1016} Direforge Hill · {area:205} Dun Modr
	["{quest:88756} is a group quest: the {item:280806} lie in the {object:147516} camp on {area:1016}, south-east of {area:205}, among the same elite dwarves. Skip it if you are alone."] = "",
	-- {npc:1073} Ashlan Stonesmirk
	["{npc:1073}, in the camp"] = "",

	-- Step 17: The Dark Iron War
	-- {npc:1364} Balgaras the Foul
	["These are elite mobs: grouping up is encouraged, look for people to do it with. Dark Iron Dwarves, Tunnelers, Saboteurs and Demolitionists (27-31) fill the ruins west of the camp; {npc:1364} (34, elite) walks among them."] = "",

	-- Step 18: Direforge Hill
	-- {area:1016} Direforge Hill · {item:280806} Stolen Explosives · {area:880} Thandol Span
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["These are elite mobs: grouping up is encouraged, look for people to do it with. South-east of Dun Modr, about 500 yards, the Dark Irons camp on {area:1016}: the {item:280806} lie among their tents. Then back past the camp and north to the {area:880}."] = "",

	-- Step 19: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "伊貝尼瑟的屍體",
	-- {area:205} Dun Modr · {area:880} Thandol Span · {npc:1075} Rhag Garmason
	-- plural, as words: Dark Iron Saboteurs = {npc:1052} Dark Iron Saboteur
	["North along the road from {area:205} towards the {area:880}: Ebenezer Rustlocke's corpse lies under the span. Rustlocke's parchment goes back to {npc:1075}.\nTwo elite Dark Iron Saboteurs stand by the corpse inside the span: pull them one at a time, or loot the corpse and run out."] = "沿路從{area:205}向北往{area:880}：埃本尼澤·羅斯洛克的屍體躺在橋洞下。羅斯洛克的羊皮紙要交回給{npc:1075}。\n兩個精英黑鐵破壞者守在橋洞裡的屍體旁：一次拉一個，或者摸了屍體就跑出去。",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "{object:2652}，在裡面",
	["the same corpse"] = "同一具屍體",

	-- Step 20: Rhag Garmason
	-- {area:205} Dun Modr · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["Back down the road to {area:205}: {npc:1075} wants the {object:147516} explosives under the far end of the span destroyed."] = "沿路返回{area:205}：{npc:1075}要你毀掉橋遠端下面的{object:147516}炸藥。",

	-- Step 21: Motley Garmason
	-- {npc:1075} Rhag Garmason
	["in the camp, beside {npc:1075}"] = "",

	-- Step 23: The Cache of Explosives
	-- {object:2704} Cache of Explosives
	["The {object:2704}"] = "{object:2704}",
	-- {area:880} Thandol Span
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["Over the {area:880}: the Dark Irons' cache of explosives sits by its Arathi end."] = "過了{area:880}：黑鐵矮人的炸藥藏匿點就在它靠阿拉希的一端。",

	-- Step 24: Waterlogged Envelope
	["Underwater"] = "在水下",

	-- Step 25: Rhag Garmason again
	-- {npc:1075} Rhag Garmason
	["{npc:1075} again"] = "再次找{npc:1075}",
	-- {area:205} Dun Modr
	["Back over the span and down the road through {area:205} on the way south."] = "折回過橋，沿路向南穿過{area:205}。",
	-- {npc:2700} Captain Nials · {area:320} Refuge Pointe
	["for {npc:2700} at {area:320}, in 05-arathi-highlands"] = "給{area:320}的{npc:2700}，在 05-arathi-highlands 指南中",

	-- Step 27: Rethiel the Greenwarden
	-- {area:17732} Excavation Site: Wetlands · {npc:1244} Rethiel the Greenwarden · {npc:270637} Howin Kindfeather
	["The root core from your {area:17732} run: {npc:1244} stands by the river, just east of {npc:270637}."] = "你{area:17732}之行取得的根核：{npc:1244}站在河邊，就在{npc:270637}東邊。",

	-- Step 28: Howin Kindfeather
	-- {quest:98246} Trying Times
	["{quest:98246}: the eggs"] = "{quest:98246}：那些蛋",

	-- Step 29: Howin Kindfeather
	-- {quest:98291} Death to the Dragonmaw · {area:17716} Dragonmaw Retreat · {npc:270637} Howin Kindfeather
	["{quest:98291} is a group quest: 16 elite Dragonmaw (29-30) in {area:17716}, just east of {npc:270637}. Skip it if you are alone."] = "",

	-- Step 30: Dragonmaw Retreat
	-- {npc:270637} Howin Kindfeather
	-- plural, as words: Dragonmaw Reclaimers = {npc:271351} Dragonmaw Reclaimer
	["These are elite mobs: grouping up is encouraged, look for people to do it with. The Dragonmaw Reclaimers, Soulbinders and Infiltrators (29-30, elite) camp just east of {npc:270637}."] = "",

	-- Step 31: Howin Kindfeather
	-- {npc:270637} Howin Kindfeather
	["back west to {npc:270637}"] = "",

	-- Step 32: Prospector Whelgar
	["Below ground"] = "地下",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "給{zone:1455}的{npc:2916}，在本指南結尾",

	-- Step 33: Prospector Whelgar
	-- {item:270865} Titan Relic · {area:17732} Excavation Site: Wetlands · {npc:1077} Prospector Whelgar
	["The {item:270865} from your {area:17732} run: {npc:1077} is below ground in his dig, south of the road west."] = "你{area:17732}之行取得的{item:270865}：{npc:1077}在他挖掘場的地下，在往西道路的南邊。",
	-- {npc:1077} Prospector Whelgar
	["{npc:1077}, below ground"] = "{npc:1077}，在地下",
	-- {npc:1077} Prospector Whelgar · {npc:5387} High Explorer Magellas · {zone:1455} Ironforge
	["{npc:1077}: for {npc:5387} in {zone:1455}, at the end of this guide"] = "{npc:1077}：給{zone:1455}的{npc:5387}，在本指南結尾",

	-- Step 34: Menethil Harbor
	["West along the road to Menethil."] = "沿著道路向西前往米奈希爾。",
	["On the top floor"] = "在頂層",

	-- Step 35: Menethil Harbor
	-- {npc:4455} Red Jack Flint · {quest:1132} Fiora Longears
	["{npc:4455}, by the keep's door: for {quest:1132} in Theramore, in the next guide"] = "{npc:4455}，在要塞門口：用於塞拉摩的{quest:1132}，見下一篇指南",

	-- Step 36: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104} stands on the top floor of {area:2103}: go up inside, the arrow cannot tell the floors apart."] = "{npc:2104}站在{area:2103}的頂層：從裡面上去，箭頭分不清樓層。",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}, back east along the road"] = "{npc:2104}：給{npc:270637}，沿道路往東回去",

	-- Step 37: Howin Kindfeather
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Back east along the road to the {area:1025}: {npc:270637} camps among the Fenrunners, just west of {npc:1244}. Then west again to Menethil for the boat."] = "沿著道路向東回到{area:1025}：{npc:270637}在沼澤奔行者之間紮營，就在{npc:1244}西邊不遠處。然後再向西回到米奈希爾港搭船。",

	-- Step 38: Menethil Harbor
	-- {npc:2094} James Halloran · {npc:1239} First Mate Fitzsimmons · {area:2104} Deepwater Tavern
	["{npc:2094} stands by the docks; {npc:1239} sits in the {area:2104}, south of the keep."] = "{npc:2094}站在碼頭邊；{npc:1239}坐在要塞南邊的{area:2104}裡。",

	-- Step 39: Captain Halyndor
	-- {npc:1160} Captain Halyndor · {npc:270589} Nightveiled Rotheap · {zone:1437} Wetlands
	["North along the coast from Menethil to the wreck of the Intrepid: {npc:1160} (30) is aboard, and the locked strongbox sits in the wreck. Careful: {npc:270589}, a level 31-32 elite, roams the {zone:1437}: give it a wide berth."] = "從米奈希爾沿海岸往北前往無畏號殘骸：{npc:1160}（30）在船上，上鎖的保險箱就在殘骸裡。小心：31-32級精英{npc:270589}在{zone:1437}遊蕩：離它遠一點。",
	-- {item:2629} Intrepid Strongbox Key · {npc:1160} Captain Halyndor
	["{item:2629}, from {npc:1160}"] = "{item:2629}，來自{npc:1160}",

	-- Step 40: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern
	["Back south to Menethil: {npc:1217} stands in the {area:2104}."] = "往南回到米奈希爾：{npc:1217}站在{area:2104}裡。",
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind
	["For {npc:1284} in {zone:1453}, at the end of this guide"] = "",

	-- Step 41: Level 30.8
	["Level 30.8"] = "30.8級",
	-- {quest:474} Defeat Nek'rosh · {area:133} Gnomeregan · {area:796} Scarlet Monastery
	["Skipped {quest:474} and short of 30.8? Kill the Bluegill murlocs on the coast south of Menethil until level 30.8. Or, with a group, run the {area:133} dungeon or the {area:796} dungeon (Graveyard) instead."] = "跳過了{quest:474}還差30.8級？去米奈希爾以南的海岸殺藍鰓魚人，直到30.8級。或者組隊去刷{area:133}地城或{area:796}地城（墓地）。",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "刷{npc:1418}",

	-- Step 42: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "搭船前往{area:271}",

	-- Step 43: Southshore
	-- {npc:2711} Phin Odelic · {npc:2430} Chef Jessen · {npc:2382} Darren Malvew · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly · {quest:98463} Talk of the Town
	["Off the boat, walk up the pier into town: {npc:2711} and Lieutenant Farren stand by the inn, {npc:2430} upstairs, {npc:2382} east of it; the flight master is at the north end, {npc:2381} and {npc:2438} between her and the inn, Maleb in the town hall at the west side.\n{npc:2366} may not offer {quest:98463} on Forever: if she doesn't, skip it."] = "下船後沿碼頭走進鎮子：{npc:2711}和法倫中尉站在旅店旁，{npc:2430}在樓上，{npc:2382}在旅店東邊；飛行管理員在北端，{npc:2381}和{npc:2438}在她和旅店之間，馬萊布在西側的鎮政廳。\n在 Forever 裡{npc:2366}可能不給{quest:98463}：她不給就跳過。",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}：他的線索通往阿拉希",
	-- {npc:2228} Lieutenant Farren Orinelle
	["{npc:2228}, inside"] = "{npc:2228}，室內",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}，在旅店裡：給{area:35}（04-stranglethorn-vale）",
	-- {npc:2430} Chef Jessen
	["{npc:2430}, upstairs"] = "{npc:2430}，樓上",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}：獅子稍後再打",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}，來自{npc:2381}",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside: keep it, the Syndicate camp waits for the road north to Arathi (05-arathi-highlands)"] = "{npc:2276}，在室內：先保留，辛迪加營地等到往北前往阿拉希的路上再做（05-arathi-highlands）",

	-- Step 44: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {skill:165} Leatherworking · {item:2997} Bolt of Woolen Cloth · {skill:197} Tailoring
	["{npc:2438} makes a yeti fur cloak for anyone who brings a {item:3719} ({skill:165}) and a {item:2997} ({skill:197}); no vendor sells either, so this step shows only when you carry both."] = "{npc:2438}替任何帶來{item:3719}（{skill:165}）和{item:2997}（{skill:197}）的人做一件雪人皮斗篷；這兩樣都沒有商人賣，所以只有你兩樣都帶著時才會顯示這一步。",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth
	["{npc:2438}, between the flight master and the inn: he wants a {item:3719} and a {item:2997} too"] = "{npc:2438}，在飛行管理員和旅店之間：他也要{item:3719}和{item:2997}",

	-- Step 45: Torn Fin murlocs
	["Torn Fin murlocs"] = "碎鰭魚人",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "碎鰭魚人聚集在{area:271}西南方的{area:295}。\n小心：其中一個營地有一群緊挨在一起的神諭者，會一起被引過來。",

	-- Step 46: Farren
	["Farren"] = "法爾林",
	["Inside"] = "在裡面",

	-- Step 47: Murloc heads
	["Murloc heads"] = "魚人頭",
	["Back to the same murlocs; not every one drops a head."] = "回到同一群魚人；不是每隻都會掉落頭。",

	-- Step 49: Daggerspine naga
	["Daggerspine naga"] = "刺脊納迦",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "納迦佔據{area:271}東南方的海岸。",

	-- Step 50: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "給{object:2117}的報告；在裡面",

	-- Step 52: Southshore
	-- {npc:251493} Captain McManus · {quest:98059} Hillsbrad's Hoard · {item:279386} Sealed Company Request · {area:287} Hillsbrad · {area:271} Southshore
	["{npc:251493} stands north-west of the flight master, on the way north to the yeti cave.\n{quest:98059}: {npc:251493} hands you a {item:279386} for the {area:287} council, in the farms west of {area:271}."] = "{npc:251493}站在飛行管理員西北方，就在往北去雪人洞穴的路上。\n{quest:98059}：{npc:251493}給你一份{item:279386}，要交給{area:287}議會，位於{area:271}西邊的農場。",

	-- Step 53: Yeti cave
	["Yeti cave"] = "雪人洞穴",
	-- {area:271} Southshore · {area:277} Foothill Caverns · {npc:13602} The Abominable Greench
	-- plural, as words: Giant Yetis = {npc:2251} Giant Yeti
	["The yetis live in the cave in the hills north of {area:271}.\nStay in the {area:277}: the cave further north has Mountain and Giant Yetis (32-34) in pairs and {npc:13602}, a level 36 elite."] = "雪人住在{area:271}北邊山丘上的洞穴裡。\n待在{area:277}裡：更北邊的洞穴裡有成對出現的山嶺雪人和巨型雪人（32-34級），以及36級精英{npc:13602}。",

	-- Step 54: Hillsbrad Fields
	-- {area:271} Southshore · {area:286} Hillsbrad Fields
	["West from {area:271} to the {area:286} farms."] = "從{area:271}向西前往{area:286}的農場。",

	-- Step 55: Hillsbrad council
	-- {area:287} Hillsbrad
	["{area:287} council"] = "{area:287}議會",
	-- {item:279386} Sealed Company Request · {area:287} Hillsbrad
	["Use the {item:279386} at the {area:287} council."] = "在{area:287}議會處使用{item:279386}。",

	-- Step 56: Snapjaws
	["Snapjaws"] = "鉗嘴龜",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "鉗嘴龜在{area:271}東邊、{area:272}（部落）南邊的河邊曬太陽。",

	-- Step 58: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飛往{area:1537}",
	-- {area:271} Southshore
	["{area:271} flight master"] = "{area:271}飛行管理員",

	-- Step 59: Hall of Explorers
	-- {npc:1356} Prospector Stormpike · {npc:2916} Historian Karnik · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers
	["{npc:1356}, {npc:2916} and {npc:5637} stand in the {object:32356}, north-east of the flight master."] = "{npc:1356}、{npc:2916}和{npc:5637}站在飛行管理員東北邊的{object:32356}裡。",
	["Level 30 and 32 spells"] = "30級和32級法術",

	-- Step 62: Sara Balloo
	-- {npc:2695} Sara Balloo · {zone:1455} Ironforge
	["{npc:2695}: for King Magni, on the same {zone:1455} stop"] = "{npc:2695}：給國王麥格尼·銅鬚，在同一趟{zone:1455}行程中",

	-- Step 64: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飛往{zone:1453}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飛行管理員",

	-- Step 65: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "{object:2096}的乳酪店。",

	-- Step 66: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961}在{object:2100}的酒館裡等候；他和他的兩個打手會跟你打，但被打敗後就會停手。",
	-- {npc:4961} Dashel Stonefist
	["Beat {npc:4961} and his thugs: they give up"] = "打倒{npc:4961}和他的打手：他們會認輸",

	-- Step 67: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479}在{object:2100}的酒館旁訓練戰士。{npc:6236}在{zone:1413}的{area:720}等候，要很久以後前往{area:392}的途中才會經過（40-50/01）。",

	-- Step 69: Cathedral of Light
	["Cathedral of Light"] = "光明大教堂",

	-- Step 71: Mage Quarter
	-- {npc:2708} Archmage Malin · {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} and {npc:4078} are in the {object:2164}; {npc:5081} south of the {object:2101}."] = "{npc:2708}和{npc:4078}在{object:2164}；{npc:5081}在{object:2101}南邊。",
	-- {npc:4078} Collin Mauren · {area:2240} Mirage Raceway
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{npc:4078}: the Saltstone Basilisks at the {area:2240} drop the scales, in the next guide"] = "{npc:4078}：鱗片由{area:2240}的鹽石蜥蜴掉落，在下一份指南",

	-- Step 72: Druid training
	["Druid training"] = "德魯伊訓練",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{zone:1455} has no druid trainer: {npc:5504} stands in {zone:1453}, north-west of the {object:2101}."] = "{zone:1455}沒有德魯伊訓練師：{npc:5504}在{zone:1453}，位於{object:2101}西北方。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "新的{item:279996}，用於{zone:1437}周圍的四個泰坦守望者",
	-- ["Back south down the road to the excavation site."] = "沿著道路向南回到挖掘場。",
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "為了{quest:98221}，摧毀營地裡的四份攻擊計畫。",
	-- ["Fly to {zone:1453}"] = "飛往{zone:1453}",
	-- ["Follow the road east to {area:118}."] = "沿著道路向東前往{area:118}。",
	-- ["For {npc:2916} in {zone:1455}, at the end of this guide"] = "給{zone:1455}的{npc:2916}，在本指南結尾",
	-- ["From {npc:2432} in {area:271}"] = "來自{area:271}的{npc:2432}",
	-- ["Golm"] = "高爾姆",
	-- ["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "沿著道路向北前往{area:205}。{npc:271460}站在遺跡中（使用{item:279996}）；{npc:271481}被關在西側：把它帶出去交給{npc:1072}。",
	-- ["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "出發前先接下城裡的所有任務。下船後，第一個遇到的是飛行管理員西北方的{npc:251493}；{npc:2381}和{npc:2438}站在飛行管理員和旅店之間，法爾林和{npc:2366}在旅店，馬雷布在市政廳。",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "紅色雛龍遍布大門西邊的山丘，{npc:271334}在{area:1025}，刺喉龍在北面山坡；奈爾魯站在東北方（使用{item:279996}）。\n{quest:98283}是精英：建議組隊。",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "紅色雛龍遍布大門西邊的山丘，瘋狂的腐爪龍在{area:1025}，刺喉龍在北面山坡；{npc:271458}站在東北方（使用{item:279996}）。\n{quest:98283}是精英：建議組隊。",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "向南前往龍喉的{area:1036}；{object:671518}就在營地裡。",
	-- ["Syndicate camp"] = "辛迪加營地",
	-- ["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "從{object:28027}搭乘{area:2257}前往{zone:1455}。",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "{npc:270892}就站在維爾加營地西邊：在其中一個旁邊使用他給你的{item:279996}。",
	-- ["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp, and its Footpads and Thieves are the Syndicate Maleb wants."] = "辛迪加營地位於{area:287}北部的奧特蘭克邊界，在{area:272}（部落）西邊；文件就在營地裡，營地裡的辛迪加盜賊和竊賊正是馬勒布要的辛迪加成員。",
	-- ["The Villards"] = "韋拉德一家",
	-- ["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "下一步「{quest:474}」要你對抗一名精英酋長：跳過它。",
	-- ["The yetis live in the cave in the hills north of {area:271}, on the way north to the Syndicate camp.\nStay in the {area:277}: the cave further north has Mountain and Giant Yetis (32-34) in pairs and {npc:13602}, a level 36 elite."] = "雪人住在{area:271}北邊山丘上的洞穴裡，就在往北去辛迪加營地的路上。\n待在{area:277}裡：更北邊的洞穴裡有成對出現的山嶺雪人和巨型雪人（32-34級），以及36級精英{npc:13602}。",
	-- ["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "雪人住在{area:271}北邊山丘的洞穴裡，就在你往南回去的路上。",
	-- ["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "向西前往{area:287}的農場：把{item:279386}放在市政廳裡的帳簿桌上，{npc:2335}和議員們就站在那裡。",
	-- ["Whelps, raptors and {npc:271458}"] = "雛龍、迅猛龍與{npc:271458}",
	-- ["{area:287} town hall"] = "{area:287}市政廳",
	-- ["{area:287}'s town hall"] = "{area:287}的市政廳",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}：{quest:98283}，一隻精英迅猛龍",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104}站在{area:2103}；{npc:2094}和{npc:270844}一起站在北門旁。",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104}站在{area:2103}；{npc:2094}站在北門旁。",
	-- ["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438}還要一件{item:3719}、一匹{item:2997}和{item:2321}：自己製作或購買；斗篷要等你稍後回到{area:271}時才繳交。",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}：給{area:442}的{npc:3649}（02-desolace）",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}，{object:171709}",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683}在{area:205}北邊的{area:881}旁等候；{npc:271322}在東北方不遠處。",
}
