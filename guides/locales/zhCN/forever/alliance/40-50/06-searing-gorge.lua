-- Chinese (simplified) (zhCN): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "前往{area:2101}",

	-- Step 2: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "进入{zone:1427}",

	-- Step 3: Searing Gorge
	["The Grimesilt outhouse"] = "格里塞特厕所",

	-- Step 4: The Grimesilt outhouse
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}: the {area:247} is just inside, in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "从{area:144}向南骑行进入{zone:1418}，再向西经过部落城镇{area:340}（绕远些），沿小径上行进入{zone:1427}：刚进去的东南边就是{area:247}。木制厕所里的囚犯要15块{item:4306}，并要求击杀周围挖掘场的八名黑铁地质学家。如果找到钥匙，也可以用钥匙打开厕所。",

	-- Step 5: The Grimesilt outhouse
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "囚犯的下一个任务“{zone:1446}的账本”会让你去{zone:1435}和{zone:1445}：跳过。",

	-- Step 6: Level 48.27
	["Level 48.27"] = "等级 48.27",
	-- {item:3985} Monogrammed Sash · {area:2100} Maraudon · {area:978} Zul'Farrak
	["If you skipped The {item:3985} or Facing Negolash, grind here to level 48.27 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon or the {area:978} dungeon instead."] = "如果跳过了{item:3985}或《挑战奈古拉什》，在这里刷怪补到48.27级，以跟上路线进度。也可以组队刷{area:2100}或{area:978}地下城。",
	-- {npc:5839} Dark Iron Geologist
	["grind on {npc:5839}"] = "反复击杀{npc:5839}补足经验",

	-- Step 7: Dorius Stonetender
	-- {area:247} Grimesilt Dig Site · {area:1959} Dustfire Valley · {object:175704} Singed Letter
	["Dorius stands by the road beside the {area:247}. Escort him north-east to {area:1959} and keep him alive; when it is over, read the {object:175704} he leaves on the road."] = "",
	-- {npc:8256} Curator Thorius · {area:1537} Ironforge
	["For {npc:8256} in {area:1537}, later"] = "之后交给{area:1537}的{npc:8256}",

	-- Step 8: Thorium Point
	-- {area:1446} Thorium Point
	["Ride west along the north of the Gorge to {area:1446}, the scaffolded camp on the north-west rim."] = "",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "{object:179827}布告板",

	-- Step 10: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "那个暗夜精灵独自站在{area:1446}西边。听他讲述他的故事。",

	-- Step 13: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "{npc:5858}",
	-- {npc:8436} Zamael Lunthistle · {npc:8479} Velarok Windblade
	["The spiders roam the plateaus and lava pools south of {npc:8436}, on the way to {npc:8479}."] = "",

	-- Step 14: Velarok Windblade
	-- {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["{npc:8479} stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "",

	-- Step 17: Golems and elementals
	["Golems and elementals"] = "傀儡和元素",
	-- {npc:8479} Velarok Windblade
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below {npc:8479}; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "",

	-- Step 19: Dark Iron dwarves: kill these as you meet them
	-- {object:147516} Dark Iron
	["{object:147516} dwarves: kill these as you meet them"] = "",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "",

	-- Step 22: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "{zone:1427}：沿途击杀以下目标",
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443}的入口在大熔炉北部。秘密设计图在上层岩架上；{npc:9318}在更深处的熔岩池里游动，把它们拉到池边。远离深处的{npc:14621}和他的精英卫兵。",
	-- {item:18922} Secret Plans: Fiery Flux
	["{item:18922}; below ground"] = "{item:18922}：在地下",

	-- Step 23: Searing Gorge: kill these as you meet them
	-- {npc:14621} Overseer Maltorius
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:14621} is a level 50 elite: most classes solo it at level 52, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:14621}是 50 级精英，多数职业到 52 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- Step 25: Level 48.66
	["Level 48.66"] = "等级 48.66",
	-- {quest:7701} WANTED: Overseer Maltorius · {area:2100} Maraudon · {area:978} Zul'Farrak
	["If you skipped {quest:7701}, grind here to level 48.66 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon or the {area:978} dungeon instead."] = "如果跳过了{quest:7701}，在这里刷怪补到48.66级，以跟上路线进度。也可以组队刷{area:2100}或{area:978}地下城。",
	-- {npc:9318} Incendosaur
	["grind on {npc:9318}"] = "反复击杀{npc:9318}补足经验",

	-- Step 27: The Flame's Casing
	-- {npc:5860} Twilight Dark Shaman
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:5860} (level 50 elite) needs a group of 3. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:5860}（50 级精英）需要 3 人小队。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- Step 29: Level 48.98
	["Level 48.98"] = "等级 48.98",
	-- {quest:3452} The Flame's Casing · {area:2100} Maraudon · {area:978} Zul'Farrak
	["If you skipped {quest:3452}, grind here to level 48.98 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon or the {area:978} dungeon instead."] = "如果跳过了{quest:3452}，在这里刷怪补到48.98级，以跟上路线进度。也可以组队刷{area:2100}或{area:978}地下城。",
	-- {npc:5844} Dark Iron Slaver
	["grind on {npc:5844}"] = "反复击杀{npc:5844}补足经验",

	-- Step 30: Margol's Horn
	-- {quest:3181} The Horn of the Beast
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:3181} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{quest:3181}需要 2 人小队。独自一人时可跳过，路线会安排刷怪补回经验。",
	["Below ground"] = "在地下",

	-- Step 33: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飞往{area:1537}",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "{area:1446}的飞行管理员",

	-- Step 34: Class trainer
	["Class trainer"] = "职业训练师",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back at the {area:247}: Dorius stands by the road. Escort him north-east to {area:1959} and keep him alive; when it is over, read the {object:175704} he leaves on the road."] = "返回{area:247}，杜里奥斯·裂石在道路旁等候。向东北护送他到{area:1959}，确保他存活；结束后阅读他留在道路上的{object:175704}。",
	-- ["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "从{area:144}向南骑进{zone:1418}，然后向西经过部落城镇{area:340}（离远点），沿小路上到{zone:1427}。{area:1446}是西北边缘搭着脚手架的营地。",
	-- ["Golems and elementals"] = "傀儡和元素",
	-- ["Greater Lava Spiders"] = "{npc:5858}",
	-- ["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "{npc:5854}在卡拉然·温布雷下方的大熔炉底部巡逻；{npc:5855}在它们之间飘荡。傀儡和元素掉落油，元素掉落核心。",
	-- ["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts.\nTaskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "重型作战傀儡在卡拉然·温布雷下方的大熔炉底部巡逻，熔岩元素也在其中游荡。傀儡和元素都会掉落油，元素还会掉落心脏。\n工头和奴隶贩子在大熔炉各处驱赶奴隶，都有几率携带{item:10551}。铸造师在中央熔炉处工作，掉落{item:18959}；斥候位于南侧山脊，掉落望远镜。任意{object:147516}均有几率掉落{item:11818}，请保留。\n注意：45–46 级的黑铁奴隶贩子被拉到时，会召唤 15 码内盟友支援，最远可在 15 码处投网，并在近战使用撕裂。",
	-- ["Kalaran Windblade"] = "卡拉然·温布雷",
	-- ["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "卡拉然·温布雷站在{area:1446}南边的大熔炉边缘。听他讲述他的故事。",
	-- ["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "向东骑过大熔炉到东南方的{area:247}。木头厕所里的囚犯想要15块{item:4306}，并要你杀死周围挖掘场的八名{npc:5839}。如果你找到了钥匙，也能用它打开厕所。",
	-- ["Ride north-west across the Cauldron to {area:1446}, the scaffolded camp on the north-west rim."] = "向西北骑行穿过大熔炉，到达{area:1446}，即西北边缘搭着脚手架的营地。",
	-- ["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "黑铁工头和黑铁奴隶贩子在大熔炉各处驱使奴隶，任何一个都可能带着{item:10551}。黑铁锻造师在中间的熔炉旁干活（{item:18959}），黑铁哨兵站在南边的山脊上（侦查员的望远镜）。任何{object:147516}都可能掉落{item:11818}：留着它。",
	-- ["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "那个矮人站在挖掘场的路旁。跟着他沿道路向北，击退{object:147516}的伏击。结束后，阅读他留在{area:1959}路上的{object:175704}。",
	-- ["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "蜘蛛在峡谷西南部的高地和熔岩池中游荡。",
	-- ["The spiders roam the plateaus and lava pools south of {npc:8436}, on the way to Kalaran."] = "蜘蛛在{npc:8436}南面的高地和熔岩池一带游荡，前往卡拉然的路上会经过。",
	-- ["{area:1442}: kill these as you meet them"] = "{area:1442}：沿途击杀以下目标",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}：上一份指南用炉石把你送到这里，所以这一步通常会立即完成",
	-- ["{object:147516} dwarves"] = "{object:147516}矮人",
}
