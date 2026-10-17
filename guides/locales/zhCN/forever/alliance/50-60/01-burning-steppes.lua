-- Chinese (simplified) (zhCN): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ironforge
	-- {npc:5111} Innkeeper Firebrew
	["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",

	-- Step 2: Menethil Harbor
	-- {zone:1455} Ironforge · {area:150} Menethil Harbor · {area:442} Auberdine
	["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "从{zone:1455}飞往{area:150}，乘船前往{area:442}。",

	-- Step 3: Auberdine
	-- {area:442} Auberdine · {area:415} Astranaar
	["From the {area:442} dock, fly to {area:415}."] = "从{area:442}码头飞往{area:415}。",

	-- Step 4: Talrendis Point
	-- {zone:1440} Ashenvale · {zone:1447} Azshara · {area:3137} Talrendis Point
	["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "沿道路向东离开{zone:1440}进入{zone:1447}，前往{area:3137}的哨兵营地。",

	-- Step 5: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "神殿位于{zone:1447}西南角，{area:3137}南边。",

	-- Step 6: Haldarr Encampment
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "上层精灵的鬼魂在神殿周围的废墟中游荡；哈达尔萨特占据神殿北边不远的营地。",

	-- Step 8: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "从神殿向东北骑行：{npc:8405}在道路上方山丘中的{area:1224}扎营。",

	-- Step 9: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "苔蹄快步者",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "最近的苔蹄快步者在{area:1224}东北方的山丘上吃草，朝{area:1219}方向；更大的一群在南边的开阔地游荡。",

	-- Step 11: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "可选：{npc:8395}要两根完好无损的角鹰兽羽毛，从他营地周围的角鹰兽身上获取。数据显示这个任务没有经验。",

	-- Step 12: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420}在北部的{area:1219}扎营；他的设备散落在他东南边不远的{area:1220}各处。",

	-- Step 13: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "{area:1221}的恶鞭纳迦携带{item:13815}。{npc:8507}的四个符文立在废墟中：对每个使用他的{item:10445}。",
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}：{npc:7864}，约10%",

	-- Step 14: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "爬回废墟上方{area:1224}的{npc:8405}处。",

	-- Step 16: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "游到{zone:1447}南端外的小岛：{npc:8392}在雕像旁等候。",

	-- Step 18: Lakeshire
	-- {zone:1455} Ironforge · {area:69} Lakeshire
	["Fly from {zone:1455} to {area:69}."] = "从{zone:1455}飞往{area:69}。",

	-- Step 19: Morgan's Vigil
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "从{area:69}向北穿过山口进入{zone:1428}；{area:2418}在山口顶端，位于燃烧平原东南部。",
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}：黑石兽人掉落奖章，在整个燃烧平原期间保持此任务",

	-- Step 20: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "火腹食人魔占据守望堡北边的巨石，火腹蛮兵在巨石东侧。",

	-- Step 22: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "沿道路向西，然后向北爬到{area:251}上的地精营地。",

	-- Step 23: Thaurissan Relics
	-- plural, as words: Thaurissan Relics = {object:153556} Thaurissan Relic
	["Thaurissan Relics"] = "索瑞森遗物",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "遗物是散布在{area:251}周围{area:250}中的雕刻石块：点击它们直到收集完信息。",

	-- Step 24: The Tablet of the Seven
	-- {quest:4296} Tablet of the Seven
	["The {quest:4296}"] = "{quest:4296}",
	-- {object:147516} Dark Iron · {area:251} Flame Crest
	["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "在{area:251}西南方废墟中的{object:147516}营地阅读石板，抄写文本。",

	-- Step 25: Broodling Essence
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "在{area:251}东边山坡上的{npc:7047}快死时对它使用{item:12284}，然后拾取它留下的精华。",

	-- Step 26: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "在{zone:1452}{area:2255}的{quest:4808}处结束：留着",

	-- Step 27: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176}和黑石兽人占据{area:251}西边、{area:254}脚下的营地和要塞。一次拉一个；每个兽人和座狼都可能掉落奖章，杀到凑够五十个为止。",

	-- Step 28: Franclorn Forgewright
	-- {npc:8888} Franclorn Forgewright · {area:254} Blackrock Mountain
	["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "可选：{npc:8888}的鬼魂站在{area:254}内巨型锁链上他的墓上，只有死者能看见他。如果你反正在山附近死了，复活前让灵魂跑去找他。",

	-- Step 29: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "沿道路向东骑回守望堡。",

	-- Step 30: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "爬到{area:249}顶端，把头颅插在松软的土堆上。",

	-- Step 32: Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}."] = "飞往{area:1438}。",

	-- Step 33: Kum'isha the Collector
	-- {npc:7363} Kum'isha the Collector · {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363}在城堡西南方的山丘{area:2517}等候。沿途的{zone:1419}怪物掉落不完美的德莱尼水晶碎片；把你有的都交给她。",

	-- Step 34: Wildkin feathers
	["Wildkin feathers"] = "枭兽羽毛",
	-- {area:1438} Nethergarde Keep · {area:348} Aerie Peak · {zone:1425} Hinterlands
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "骑回{area:1438}，飞往{area:348}。枭兽羽毛散落在{area:348}南边和东边的{zone:1425}地上，枭兽在那里游荡；这里的怪物现在比你低很多。",

	-- Step 36: Menethil Harbor
	-- {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "飞往{area:150}，乘船前往{area:442}，再乘船前往{area:702}。",

	-- Step 37: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "枭兽在{zone:1452}：留着",

	-- Step 38: Druid training
	["Druid training"] = "德鲁伊训练",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455}没有德鲁伊训练师：乘传送门上到{zone:1457}，在{area:1658}训练，然后回到{area:702}。",
}
