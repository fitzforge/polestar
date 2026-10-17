-- Chinese (simplified) (zhCN): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:6734} Innkeeper Hearthstove
	["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}：上一份指南用炉石把你送到这里，所以这一步通常会立即完成",

	-- Step 2: Thorium Point
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:1446} Thorium Point
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "从{area:144}向南骑进{zone:1418}，然后向西经过部落城镇{area:340}（离远点），沿小路上到{zone:1427}。{area:1446}是西北边缘搭着脚手架的营地。",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "{object:179827}布告板",

	-- Step 3: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "那个暗夜精灵独自站在{area:1446}西边。听他讲述他的故事。",

	-- Step 4: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "卡拉然·温布雷站在{area:1446}南边的大熔炉边缘。听他讲述他的故事。",

	-- Step 5: Golems and elementals
	["Golems and elementals"] = "傀儡和元素",
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "{npc:5854}在卡拉然·温布雷下方的大熔炉底部巡逻；{npc:5855}在它们之间飘荡。傀儡和元素掉落油，元素掉落核心。",

	-- Step 7: Dark Iron dwarves
	-- {object:147516} Dark Iron
	["{object:147516} dwarves"] = "{object:147516}矮人",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "黑铁工头和黑铁奴隶贩子在大熔炉各处驱使奴隶，任何一个都可能带着{item:10551}。黑铁锻造师在中间的熔炉旁干活（{item:18959}），黑铁哨兵站在南边的山脊上（侦查员的望远镜）。任何{object:147516}都可能掉落{item:11818}：留着它。",

	-- Step 8: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "{npc:5858}",
	["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "蜘蛛在峡谷西南部的高地和熔岩池中游荡。",

	-- Step 10: The Slag Pit
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443}的入口在大熔炉北部。秘密设计图在上层岩架上；{npc:9318}在更深处的熔岩池里游动，把它们拉到池边。远离深处的{npc:14621}和他的精英卫兵。",

	-- Step 12: The Grimesilt outhouse
	["The Grimesilt outhouse"] = "格里塞特厕所",
	-- {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "向东骑过大熔炉到东南方的{area:247}。木头厕所里的囚犯想要15块{item:4306}，并要你杀死周围挖掘场的八名{npc:5839}。如果你找到了钥匙，也能用它打开厕所。",
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "囚犯的下一个任务“{zone:1446}的账本”会让你去{zone:1435}和{zone:1445}：跳过。",

	-- Step 13: Dorius Stonetender
	-- {object:147516} Dark Iron · {object:175704} Singed Letter · {area:1959} Dustfire Valley
	["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "那个矮人站在挖掘场的路旁。跟着他沿道路向北，击退{object:147516}的伏击。结束后，阅读他留在{area:1959}路上的{object:175704}。",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, later"] = "之后交给{zone:1455}的{npc:8256}",
}
