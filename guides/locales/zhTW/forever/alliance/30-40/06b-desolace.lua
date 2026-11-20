-- Chinese (traditional) (zhTW): the guide forever/alliance/30-40/06b-desolace (forever/alliance/30-40/06b-desolace.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1443} Desolace
	["Kodo bones, demons and lost treasure in south {zone:1443}."] = "{zone:1443}南部的科多獸骨、惡魔和失落的寶藏。",
	["Short: about one level of quests"] = "短：約一級的任務量",
	-- {zone:1434} Stranglethorn Vale
	["Then on to {zone:1434}"] = "接著前往{zone:1434}",
	["Stays on the main route"] = "留在主要路線上",
	["A long trip out to Kalimdor"] = "遠赴卡林多的長途旅程",

	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飛往{area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144}飛行管理員",

	-- Step 3: Theramore flight master
	["Theramore flight master"] = "塞拉摩飛行管理員",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "下船後沿碼頭往上走，到{area:514}大門旁的飛行管理員巴德拉克那裡。",

	-- Step 4: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {npc:11863} Azore Aldamort
	["{npc:5638}, if 30-40/02 didn't take it: the wreck lies below {npc:11863}'s tower"] = "{npc:5638}，如果30-40/02沒接過：沉船在{npc:11863}的塔下方",
	-- {npc:5396} Captain Pentigast
	["{npc:5396}, if 30-40/02 didn't give it"] = "{npc:5396}，如果30-40/02沒有接到",

	-- Step 5: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "沿著道路向南前往{area:2407}。",

	-- Step 6: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019}站在{area:596}邊緣，{area:2407}西南方；{object:176751}散落在骨架之間。",

	-- Step 7: Hornizz Brimbuzzle
	-- {quest:6134} Ghost-o-plasm Round Up · {area:2657} Valley of Bones
	-- plural, as words: Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:6134}'s magnets draw the Magrami Spectres a few yards from the Magram Necrokhans and Corpsefeeders (45, elite) in the {area:2657}. Skip it if you are alone."] = "這些是精英怪：建議組隊，找人一起做。{quest:6134}的磁鐵會在{area:2657}把瑪格拉姆幽靈引到離瑪格拉姆死靈可汗和食屍者（45級，精英）只有幾碼的地方。如果你獨自一人就跳過。",

	-- Step 8: Flesh Picker
	-- {npc:217590} Flesh Picker · {area:596} Kodo Graveyard · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s {item:213565}."] = "一隻{npc:217590}在{area:596}爬來爬去：用{npc:217412}給的{item:213565}裡的工具抓一隻。",

	-- Step 9: Maraudine centaurs
	["Maraudine centaurs"] = "瑪勞登半人馬",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "瑪勞登半人馬佔據墓地西邊的{area:607}；每一種都會掉落圖騰。",

	-- Step 10: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277}被關在墓地西邊的半人馬營地。救出她，在走出去的路上保護她存活；她會在墓地旁停下。\n小心：劇本中出現的敵人群彼此連動，只會在護送期間出現，所以無法事先清掉，也無法一次拉一隻。不過開始前先清掉路上一般的半人馬會有幫助。",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "護送{npc:12277}回墓地",

	-- Step 11: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {npc:5760} Lord Azrethoc
	-- plural, as words: Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}. Nether Maidens (37-38) hold its north-west side and drop the wings; Doomwarder Captains (38) stand at the south end and drop the blood.\nCareful: Nether Sorceresses (39-40) stand beside the Doomwarder Captains, and {npc:5760}, a level 40 elite, walks the coven's middle: pull the captains away from them. Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "惡魔聚集在{zone:1443}南部的{area:602}。虛空魔女（37-38級）佔據西北側並掉落魔女之翼；末日守衛隊長（38級）站在南端並掉落血液。\n小心：虛空女巫（39-40級）站在末日守衛隊長旁邊，40級精英{npc:5760}在巫團中央走動：把隊長拉離它們。這裡大多數怪物都會巡邏，很容易多拉到怪。",
	-- {item:6251} Nether Wing
	-- plural, as words: Nether Maidens = {npc:4679} Nether Maiden
	["{item:6251}, from the Nether Maidens"] = "{item:6251}，來自虛空魔女",
	-- {item:6252} Doomwarder Blood
	-- plural, as words: Doomwarder Captains = {npc:4680} Doomwarder Captain
	["{item:6252}, from the Doomwarder Captains"] = "{item:6252}，來自末日守衛隊長",

	-- Step 12: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magram Necrokhans = {npc:253274} Magram Necrokhan · Magram Necromancers = {npc:253272} Magram Necromancer
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields further east, with Magram Necromancers (42): pull the Ravagers to you, away from them."] = "亡靈劫毀者在瑪格拉姆村莊南邊、巫團東邊的骨原上遊蕩：箭頭會帶你到它們的西緣。小心：瑪格拉姆死靈可汗和食屍者（45級，精英）與瑪格拉姆死靈法師（42級）在更東邊的骨原上走動：把劫毀者拉到你這裡，遠離它們。",

	-- Step 13: The ghost magnets
	["The ghost magnets"] = "幽靈磁鐵",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Magrami Spectres = {npc:11560} Magrami Spectre
	["Use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres; the Necrokhans and Corpsefeeders (45, elite) walk close by: keep the group together."] = "在骨原東側的箭頭處使用{item:15848}，引來瑪格拉姆幽靈；死靈可汗和食屍者（45級，精英）就在附近走動：小隊要待在一起。",

	-- Step 14: Mannoroc Coven
	-- {npc:5760} Lord Azrethoc
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Mage Hunters = {npc:4681} Mage Hunter
	["Back at the coven on the way west: the Mana Eaters (37-38) on its north edge and the Mage Hunters (38-39) further in drop the brains. {npc:5760} (40, elite) walks among the Mage Hunters: pull them out to you."] = "往西的途中回到巫團：北緣的噬法魔犬（37-38級）和更裡面的法師獵手（38-39級）會掉落腦。{npc:5760}（40級，精英）在法師獵手之間走動：把它們拉出來。",

	-- Step 17: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "沿著道路向西穿過{zone:1443}北部，前往{area:2405}的廢墟。{npc:11863}的塔就在那裡的山丘上，在前往沉船的路上。",
	-- {npc:11863} Azore Aldamort · {quest:93464} The Visiting Mage · {zone:1435} Swamp of Sorrows
	["{npc:11863}: {quest:93464}, from Magtoor in the {zone:1435}"] = "{npc:11863}：{quest:93464}，來自{zone:1435}的瑪格圖爾",

	-- Step 18: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "沉船的箱子就在{npc:11863}塔西南方不遠處。",

	-- Step 19: Claim Rackmore's Treasure!
	-- {object:177787} Rackmore's Log · {object:35251} Karnitol's Chest · {zone:1443} Desolace
	["{object:177787} lies beside {object:35251}, if you didn't take it on your first {zone:1443} visit. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787}放在{object:35251}旁邊，如果你第一次來{zone:1443}時沒拿的話。他的銀鑰匙由沉船周圍的乾鉗螃蟹掉落；金鑰匙則來自西北海岸的滑刃納迦，接下來就去。",
	-- {object:177787} Rackmore's Log
	["{object:177787}, if 30-40/02 didn't take it"] = "{object:177787}，如果30-40/02沒拿過",
	["Underwater"] = "在水下",

	-- Step 20: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598}：遇到就殺",
	-- {npc:11863} Azore Aldamort · {spell:131} Water Breathing · {area:2406} Ranazjar Isle · {item:15766} Gem of the Serpent · {object:177673} Serpent Statue · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower, on the shore and out in the water. Karnitol's satchel drops now and then from their Tidehunters and Sea Witches, most of them underwater ({spell:131} helps): take it if it comes, it is optional. Any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}，來自滑刃納迦",
	-- {item:15766} Gem of the Serpent · {object:177673} Serpent Statue
	["{item:15766}, on the {object:177673}"] = "{item:15766}，對{object:177673}使用",

	-- Step 21: Rackmore's Chest
	-- {object:177673} Serpent Statue
	["Rackmore's chest lies just south-east of the {object:177673}."] = "拉克摩的箱子就在{object:177673}東南方不遠處。",

	-- Step 24: Nijel's Point
	-- {area:608} Nijel's Point · {npc:5396} Captain Pentigast · {npc:5638} Kreldig Ungor · {npc:1182} Brother Anton
	["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "沿著道路向北前往{area:608}：{npc:5396}站在南端，{npc:5638}在中間，{npc:1182}在北邊。",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "給{zone:1455}的{npc:5637}：先留著",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "給{area:271}的{npc:3980}：先留著",

	-- Step 25: Fly to Theramore
	["Fly to Theramore"] = "飛往塞拉摩",
	["The next guide starts in Theramore."] = "下一份指南從塞拉摩開始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "滑刃納迦佔據{npc:11863}塔北邊的西北海岸；卡尼托的背包在外海的海底，任何納迦都可能掉落拉克摩的金鑰匙。游到最北端外海的{area:2406}，對{object:177673}使用{item:15766}：{npc:12369}（38級）會出現；擊殺他取得{quest:6027}。",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "惡魔聚集在{zone:1443}南部的{area:602}：坑洞周圍有地獄犬（法力吞噬者、法師獵手和魔網獵手）、虛空少女和虛空姐妹，以及末日守衛隊長。\n小心：這裡大部分的怪都有巡邏路線，很容易多拉到怪。",
	-- ["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Then use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields between the two arrows, with Magram Necromancers (42): pull the Ravagers and the spectres to you, away from them."] = "不死掠奪者在瑪格拉姆村莊南邊、巫團東邊的骨原上遊蕩：箭頭會帶你到它們的西緣。然後在骨原東側的箭頭處使用{item:15848}，引來瑪格拉姆幽靈。小心：瑪格拉姆死靈可汗和食屍者（45級，精英）與瑪格拉姆死靈法師（42級）在兩個箭頭之間的骨原上走動：把掠奪者和幽靈拉到你這裡，遠離它們。",
	-- ["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787}放在{object:35251}旁邊。他的銀鑰匙由沉船周圍的乾鉗螃蟹掉落；金鑰匙則來自西北海岸的滑刃納迦，接下來就去。",
}
