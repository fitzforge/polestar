-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/06b-desolace (forever/alliance/30-40/06b-desolace.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飞往{area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144}的飞行管理员",

	-- Step 3: Theramore flight master
	["Theramore flight master"] = "塞拉摩飞行管理员",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "下船后沿码头走到{area:514}大门旁的飞行管理员巴德拉克处。",

	-- Step 4: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {npc:11863} Azore Aldamort
	["{npc:5638}, if 30-40/02 didn't take it: the wreck lies below {npc:11863}'s tower"] = "{npc:5638}，如果30-40/02没有交还：沉船就在{npc:11863}的塔下方",

	-- Step 5: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "沿道路向南前往{area:2407}。",

	-- Step 6: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019}站在{area:596}边缘，{area:2407}西南方；{object:176751}散落在骨架之间。",

	-- Step 7: Flesh Picker
	-- {npc:217590} Flesh Picker · {area:596} Kodo Graveyard · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s {item:213565}."] = "{area:596}一带有{npc:217590}爬行：用{npc:217412}的{item:213565}中的工具捕捉一只。",

	-- Step 8: Maraudine centaurs
	["Maraudine centaurs"] = "玛洛迪半人马",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "玛洛迪半人马占据着墓地西边的{area:607}；每种半人马都会掉落图腾。",

	-- Step 9: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277}被关在墓地西边的半人马营地；救出她，在离开途中保护她的安全；她会在墓地旁停下。\n小心：脚本刷出的敌群会一起行动，而且仅在护送期间出现，因此无法提前清理，也无法逐个引出。开始前先清理路上的普通半人马仍有帮助。",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "护送{npc:12277}返回墓地方向",

	-- Step 10: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "恶魔聚集在{zone:1443}南部的{area:602}：坑边有地狱犬（噬法魔犬、法师猎手和灵能猎犬）、虚空少女和虚空姐妹，以及末日守卫队长。\n小心：这里的大多数怪物都会沿路线巡逻，很容易引来额外的怪。",

	-- Step 11: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan · Magram Necromancers = {npc:253272} Magram Necromancer
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Then use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields between the two arrows, with Magram Necromancers (42): pull the Ravagers and the spectres to you, away from them."] = "亡灵劫掠者在玛格拉姆村庄南边、集会所东边的白骨荒地游荡：箭头会指向它们的西缘。然后在荒地东侧的另一个箭头处使用{item:15848}，引来玛格拉姆鬼魂。小心：玛格拉姆死灵可汗和玛格拉姆食尸者（45级，精英）在两个箭头之间的白骨荒地上走动，还有玛格拉姆死灵法师（42级）：把劫掠者和鬼魂引到你身边，远离它们。",

	-- Step 14: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "沿道路向西穿过{zone:1443}北部，前往{area:2405}的废墟。{npc:11863}的塔就在那里的山丘上，在前往沉船的路上。",

	-- Step 15: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "沉船的箱子就在{npc:11863}的塔西南方不远处。",

	-- Step 16: Claim Rackmore's Treasure!
	-- {object:177787} Rackmore's Log · {object:35251} Karnitol's Chest
	["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787}在{object:35251}旁边。他的银钥匙由沉船周围的干钳蟹掉落；金钥匙则来自西北海岸的滑刃纳迦，下一步就去。",
	["Underwater"] = "在水下",

	-- Step 17: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598}：遇到就杀",
	-- {npc:11863} Azore Aldamort · {area:2406} Ranazjar Isle · {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words) · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "滑刃纳迦占据着{npc:11863}的塔北边的西北海岸；卡尼托的挎包就在近海的海底，任何纳迦都可能掉落拉克摩尔的金钥匙。游到最北端外的{area:2406}，对{object:177673}使用{item:15766}：{npc:12369}（38级）会出现；杀死他获得{quest:6027}。",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}，击杀滑刃纳迦获取",
	-- {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words)
	["{item:15766}, on the {object:177673}"] = "{item:15766}，对{object:177673}使用",

	-- Step 18: Rackmore's Chest
	-- {object:177673} Serpent Statue (no name in this language: may be words)
	["Rackmore's chest lies just south-east of the {object:177673}."] = "拉克摩尔的箱子就在{object:177673}东南方不远处。",

	-- Step 21: Nijel's Point
	-- {area:608} Nijel's Point · {npc:5396} Captain Pentigast · {npc:5638} Kreldig Ungor · {npc:1182} Brother Anton
	["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "沿道路向北前往{area:608}：{npc:5396}站在南端，{npc:5638}在中间，{npc:1182}在北边。",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "交给{zone:1455}的{npc:5637}：先留着",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "交给{area:271}的{npc:3980}：先留着",

	-- Step 22: Fly to Theramore
	["Fly to Theramore"] = "飞往塞拉摩岛",
	["The next guide starts in Theramore."] = "下一份指南从塞拉摩岛开始。",
}
