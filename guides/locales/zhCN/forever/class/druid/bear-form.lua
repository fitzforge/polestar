-- Chinese (simplified) (zhCN): the guide forever/class/druid/bear-form (forever/class/druid/bear-form.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:5487} Bear Form · {area:493} Moonglade
	["{spell:5487} and {area:493}"] = "{spell:5487}和{area:493}",
	-- {spell:5487} Bear Form · {area:493} Moonglade
	["Your tanking form: Forever no longer trains {spell:5487}, these quests give it. Opens {area:493} too."] = "你的坦克形态：无限不再由训练师教授{spell:5487}，而是由这些任务给予。同时也会开启{area:493}。",

	-- Step 1: Heeding the Call
	-- {npc:3602} Kal · {area:186} Dolanaar · {zone:1457} Darnassus · {zone:1453} Stormwind · {npc:4217} Mathrengyl Bearwalker
	["At 10 a druid's call reaches you: {npc:3602} in {area:186}, Denatharion in {zone:1457} or Theridran in {zone:1453}. Any one of them sends you to {npc:4217} in the Cenarion Enclave of Darnassus."] = "10级时会收到德鲁伊的召唤：{area:186}的{npc:3602}、{zone:1457}的德纳萨里安或{zone:1453}的塞瑞德兰。任何一位都会让你去找达纳苏斯塞纳里奥区的{npc:4217}。",
	-- {npc:3602} Kal · {area:186} Dolanaar
	["{npc:3602}, {area:186}; Denatharion's and Theridran's letters lead to the same place"] = "{npc:3602}，{area:186}；德纳萨里安和塞瑞德兰的信也指向同一个地方",

	-- Step 2: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:18960} Teleport: Moonglade
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. He teaches you {spell:18960} with the quest (it stays in your spellbook, Balance tab)."] = "{npc:4217}站在{area:1658}德鲁伊建筑的楼上。他会在任务中教你{spell:18960}（会保留在法术书的平衡页中）。",

	-- Step 3: Mathrengyl Bearwalker
	["or whichever of the three letters you carry"] = "或你携带的三封信中的任意一封",

	-- Step 4: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:5929} Great Bear Spirit · {area:2361} Nighthaven · {area:493} Moonglade · {npc:10897} Sindrayl · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960}: it lands you beside the building where {npc:11802} stands upstairs, past the armor vendor. The {quest:5929} sits in the woods to the north-west. Speak to it and go through all of its words (what it represents, the strength of the body, the strength of the heart, then ask for its blessing): the talk is the objective, there is no fight. It blends into the ground, has no quest mark and gives off a faint blue-grey glow by a group of three trees: from {area:2361} go west along the foot of the northern mountains, through the gap between the trees and the hills. If {npc:11802} is missing when you return, step outside and cast {spell:18960} again. Learn the {area:493} flight path ({npc:10897}, south of the lake) for later, then take {npc:11800}'s flight from the middle of {area:2361}: she flies druids straight to {area:702}, no flight path needed. Take the portal up to {zone:1457}."] = "施放 {spell:18960}：你会来到一栋建筑旁，{npc:11802} 就在楼上，经过护甲商人便能找到。{quest:5929} 位于西北面的树林里。与它交谈，依次听完所有内容（它所代表的意义、身躯的力量、心灵的力量，最后请求它的祝福）：完成交谈即可达成目标，无需战斗。它与地面融为一体，没有任务标记，在三棵树旁散发微弱的蓝灰色光芒：从 {area:2361} 沿北部山脚向西，穿过树木与山丘间的缺口。如果返回时找不到 {npc:11802}，走到室外再施放一次 {spell:18960}。先解锁 {area:493} 的飞行路线（湖泊南面的 {npc:10897}），以便日后使用，再去搭乘 {area:2361} 中部 {npc:11800} 的航班：她会将德鲁伊直接送到 {area:702}，无需解锁飞行路线。随后通过传送门前往上方的 {zone:1457}。",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "与{quest:5929}交谈",

	-- Step 7: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Fly from {area:702} to {area:442}. The {object:177525} stands inside the nearest moonkin cave east of the village: the northern of two small rock-pile caves where the {area:442} road meets the main north-south road. Moonkin (level 11-13) stand outside, the cave is empty: slip past them. Use the {item:15208} by the stone: Lunaclaw (level 12-13) walks in towards you and stays three minutes. Kill her, then speak to the {npc:12144} that appears and ask for the strength of her body and heart: the talk is the credit. Another druid's Lunaclaw gives you the spirit too."] = "从 {area:702} 飞往 {area:442}。{object:177525} 位于村庄东面最近的枭兽洞穴内：{area:442} 的道路与南北主路交会处有两个小石堆洞穴，目标在北面的那个。洞外有11—13级枭兽，洞内没有敌人：绕过它们进去。在石头旁使用 {item:15208}：月爪枭兽（12—13级）会朝你走来，并停留三分钟。击杀她后，与出现的 {npc:12144} 交谈，请求获得她身躯和心灵的力量：交谈后才会计入进度。击杀其他德鲁伊召唤的月爪枭兽，也能见到这个灵魂。",

	-- Step 8: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker
	["Fly back to {area:702} and take the portal up to {npc:4217}."] = "飞回{area:702}，乘传送门上去找{npc:4217}。",

	-- Step 9: Heeding the Call
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village · {npc:6746} Innkeeper Pala · {zone:1456} Thunder Bluff · {npc:6929} Innkeeper Gryshka · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["At 10 a druid's call reaches you: {npc:3064} in {area:222} or {npc:6746} in {zone:1456} ({npc:6929}'s letter in {zone:1454} works too). Any one of them sends you to {npc:3033} on {area:1639} in {zone:1456}."] = "10级时会收到德鲁伊的召唤：{area:222}的{npc:3064}或{zone:1456}的{npc:6746}（{zone:1454}的{npc:6929}的信也可以）。任何一位都会让你去找{zone:1456}{area:1639}的{npc:3033}。",
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village
	["{npc:3064}, {area:222}; Pala's and Gryshka's letters lead to the same place"] = "{npc:3064}，{area:222}；帕拉和格雷什卡的信也指向同一个地方",

	-- Step 10: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade
	["{npc:3033} stands in the druids' hut on {area:1639}, over the rope bridges east of the lifts. He teaches you {spell:18960} with the quest (it stays in your spellbook, Balance tab)."] = "{npc:3033} 站在 {area:1639} 的德鲁伊小屋中，从升降梯东边走过绳桥即可到达。接到任务时，他会教你 {spell:18960}（会保留在法术书的平衡分类中）。",

	-- Step 11: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:5930} Great Bear Spirit · {area:2361} Nighthaven · {quest:5922} Moonglade · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}: it lands you beside the building where {npc:11802} stands upstairs. The {quest:5930} sits in the woods to the north-west. Speak to it and go through all of its words (what it represents, the strength of the body, the strength of the heart, then ask for its blessing): the talk is the objective, there is no fight. It blends into the ground, has no quest mark and gives off a faint blue-grey glow by a group of three trees: from {area:2361} go west along the foot of the northern mountains, through the gap between the trees and the hills. If {npc:11802} is missing when you return, step outside and cast {spell:18960} again. Learn the {quest:5922} flight path (Faustron, south-west of the lake); {npc:11798} in {area:2361} flies druids to {area:1638}."] = "施放 {spell:18960}：你会来到一栋建筑旁，{npc:11802} 就在楼上。{quest:5930} 位于西北面的树林里。与它交谈，依次听完所有内容（它所代表的意义、身躯的力量、心灵的力量，最后请求它的祝福）：完成交谈即可达成目标，无需战斗。它与地面融为一体，没有任务标记，在三棵树旁散发微弱的蓝灰色光芒：从 {area:2361} 沿北部山脚向西，穿过树木与山丘间的缺口。如果返回时找不到 {npc:11802}，走到室外再施放一次 {spell:18960}。解锁 {quest:5922} 的飞行路线（湖泊西南面的法斯托恩）；{area:2361} 的 {npc:11798} 会将德鲁伊送到 {area:1638}。",
	-- {quest:5930} Great Bear Spirit
	["Speak with the {quest:5930}"] = "与{quest:5930}交谈",

	-- Step 13: The Moonkin Stone
	-- {object:177525} Moonkin Stone · {zone:1413} Barrens · {area:378} Camp Taurajo · {zone:1412} Mulgore · {item:15710} Cenarion Lunardust · {npc:12144} Lunaclaw Spirit
	["The {object:177525} stands in the {zone:1413} just south-west of {area:378}, by the road out of {zone:1412}. Level 20 Thunderheads roam close by: clear the way first. Use the {item:15710} by the stone: Lunaclaw (level 12-13) appears for three minutes. Kill her, then speak to the {npc:12144} that appears and ask for the strength of her body and heart: the talk is the credit. Die in the fight? Lunaclaw stays by the stone: run back and finish her."] = "{object:177525} 位于 {zone:1413} 的 {area:378} 西南边，靠近离开 {zone:1412} 的道路。附近有 20 级的雷鹰游荡：先清出安全通道。在石头旁使用 {item:15710}：月爪（12-13 级）会出现并停留三分钟。杀死她，然后与出现的 {npc:12144} 交谈，请求获得她身体和心灵的力量：完成对话才算达成目标。如果战斗中死了，月爪会留在石头旁，跑回来把她杀掉即可。",

	-- Step 14: Body and Heart
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Back to {npc:3033} on {area:1639}."] = "回到{area:1639}的{npc:3033}那里。",

	-- Step 15: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "从{area:279}乘天空飞船",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:279} Dalaran
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the north side of {area:279}."] = "{spell:5487}在{zone:2521}教授。如果你还在岛上就跳过这一步；否则从{area:279}北侧乘天空飞船。",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "乘天空飞船前往{zone:2521}",

	-- Step 16: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "从{zone:1456}乘天空飞船",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the cliffs south of {area:17045}, north of {zone:1456}."] = "{spell:5487}在{zone:2521}教授。如果你还在岛上就跳过这一步；否则从{area:17045}南边的悬崖乘天空飞船，就在{zone:1456}北边。",

	-- Step 17: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands in {area:16638}."] = "{npc:252359}站在{area:16638}。",

	-- Step 18: Urs'endris and Ur'endra
	-- {npc:255853} Urs'endris · {npc:258443} Ur'endra
	["{npc:255853} and {npc:258443}"] = "{npc:255853}和{npc:258443}",
	-- {npc:255853} Urs'endris · {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands · {area:16626} Gustberry Lowlands
	["{npc:255853} waits by the waterfall below the {area:16629}, north-east of {area:16638}. {npc:258443} (the bear you must defeat) lairs in an unmarked cave high on the cliff face west of him, where the {area:16623} meet the {area:16626}: take the path west out of {area:16638} (not north), cross the river on the log bridge and reach the cave from the cliff's upper, northern side. The cave at the foot of the cliffs and the foggy cave are the wrong ones."] = "{npc:255853} 在 {area:16638} 东北方、{area:16629} 下方的瀑布旁等待。{npc:258443}（你必须击败的熊）栖居在他西侧崖壁高处一座未标记的洞穴里，那里是 {area:16623} 与 {area:16626} 的交界处：从 {area:16638} 沿小路向西走（不要向北），经独木桥过河，再从悬崖上方的北侧进入洞穴。崖脚下的洞穴和雾气弥漫的洞穴都不是目标。",

	-- Step 19: Strength and Mercy
	-- {npc:255853} Urs'endris
	["Back to {npc:255853} by the falls."] = "回到瀑布旁的{npc:255853}那里。",

	-- Step 20: Child of Nature
	-- {npc:259118} Muln Earthfury · {zone:2521} Zephras Isle · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	["{npc:259118} waits where the airship from {zone:2521} lands, in northern {zone:1412} beside {zone:1456}."] = "{npc:259118}在从{zone:2521}来的飞艇降落处等候，位于{zone:1412}北部，{zone:1456}旁边。",

	-- Step 21: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade
	["{npc:3033} trains druids in the druids' hut on {area:1639}, over the rope bridges east of the lifts. He teaches you {spell:18960} with the next quest (it stays in your spellbook, Balance tab)."] = "{npc:3033} 在 {area:1639} 的德鲁伊小屋内训练德鲁伊，穿过升降梯东侧的绳桥便能到达。他会在下一个任务中教你 {spell:18960}（学会后会一直保留在法术书的平衡分页中）。",

	-- Step 22: Child of Nature
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {area:279} Dalaran · {zone:2521} Zephras Isle · {npc:2543} Archmage Ansirem Runeweaver
	["{npc:270459} stands beside {npc:259084} and the Skyborne Portal, west of {area:279}, where the skycutter from {zone:2521} lands. {npc:2543} offers the same quest."] = "{npc:270459}站在{npc:259084}和天裔传送门旁，位于{area:279}西边，从{zone:2521}来的天空快船在此降落。{npc:2543}也提供同样的任务。",

	-- Step 23: Sheldras Moontree
	-- {zone:1453} Stormwind · {npc:5504} Sheldras Moontree · {spell:18960} Teleport: Moonglade
	["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer (the arrow points at him); he teaches you {spell:18960} with the next quest (it stays in your spellbook, Balance tab)."] = "天裔传送门会将你送到{zone:1453}。{npc:5504}是城里的德鲁伊训练师（箭头指向他）；通过下一个任务，他会教你{spell:18960}（学会后会一直保留在法术书的平衡分页中）。",

	-- Step 24: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:493} Moonglade · {npc:10897} Sindrayl
	["Cast {spell:18960}: it lands you beside the building where {npc:11802} stands upstairs, in {area:2361}. Learn the {area:493} flight path while you are here (Faustron for the Horde, south-west of the lake; {npc:10897} for the Alliance, south of it)."] = "施放 {spell:18960}：落点旁的建筑里，{npc:11802} 就在 {area:2361} 的楼上。趁在这里，学会 {area:493} 的飞行路线（部落找湖西南的浮士德；联盟找湖南边的 {npc:10897}）。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Learn the {area:493} flight path while you are here."] = "施放{spell:18960}。{npc:11802}在{area:2361}。趁在这里学会{area:493}的飞行路线。",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path, then fly to {area:702} (by way of {area:442}) and take the portal up to {zone:1457}."] = "施放{spell:18960}。{npc:11802}在{area:2361}；{quest:5929}位于西北边的树林里。学会{area:493}的飞行路线，然后飞往{area:702}（经由{area:442}），再乘传送门上到{zone:1457}。",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the woods to the north-west. {npc:11798} in {area:2361} flies druids to {area:1638}."] = "施放{spell:18960}。{npc:11802}在{area:2361}；{quest:5930}位于西北边的树林里。{area:2361}的{npc:11798}可以送德鲁伊飞往{area:1638}。",
	-- ["Fly from {area:702} to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "从{area:702}飞往{area:442}。{object:177525}就在村子东边的山丘上：在那里使用{item:15208}，击败月爪枭兽，然后与{npc:12144}交谈。",
	-- ["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer."] = "天裔传送门会把你送到{zone:1453}。{npc:5504}是该城的德鲁伊训练师。",
	-- ["The {object:177525} stands in the pass from {zone:1412} into the {zone:1413}. Use the {item:15710} there, defeat Lunaclaw and speak to the {npc:12144}."] = "{object:177525}位于从{zone:1412}进入{zone:1413}的山口。在那里使用{item:15710}，击败月爪枭兽，然后与{npc:12144}交谈。",
	-- ["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623}, west of {area:16638}."] = "{npc:255853}在{area:16638}东北边的瀑布旁等候。{npc:258443}在{area:16638}西边的{area:16623}游荡。",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033}站在{area:1639}。",
	-- ["{npc:3033} trains druids on {area:1639}."] = "{npc:3033}在{area:1639}训练德鲁伊。",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217}站在{area:1658}。",
}
