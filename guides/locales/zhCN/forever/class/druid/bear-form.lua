-- Chinese (simplified) (zhCN): the guide forever/class/druid/bear-form (forever/class/druid/bear-form.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["Your tanking form: Forever no longer trains {spell:5487}, these quests give it. Opens {area:493} too."] = "你的坦克形态：Forever不再由训练师教授{spell:5487}，而是由这些任务给予。同时也会开启{area:493}。",

	-- Step 1: Heeding the Call
	-- {npc:3602} Kal · {area:186} Dolanaar · {zone:1457} Darnassus · {zone:1453} Stormwind · {npc:4217} Mathrengyl Bearwalker
	["At 10 a druid's call reaches you: {npc:3602} in {area:186}, Denatharion in {zone:1457} or Theridran in {zone:1453}. Any one of them sends you to {npc:4217} in the Cenarion Enclave of Darnassus."] = "10级时会收到德鲁伊的召唤：{area:186}的{npc:3602}、{zone:1457}的德纳萨里安或{zone:1453}的塞瑞德兰。任何一位都会让你去找达纳苏斯塞纳里奥区的{npc:4217}。",
	-- {npc:3602} Kal · {area:186} Dolanaar
	["{npc:3602}, {area:186}; Denatharion's and Theridran's letters lead to the same place"] = "{npc:3602}，{area:186}；德纳萨里安和塞瑞德兰的信也指向同一个地方",

	-- Step 2: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217}站在{area:1658}。",
	["or whichever of the three letters you carry"] = "或你携带的三封信中的任意一封",

	-- Step 3: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {area:493} Moonglade · {area:702} Rut'theran Village · {area:442} Auberdine · {zone:1457} Darnassus
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path, then fly to {area:702} (by way of {area:442}) and take the portal up to {zone:1457}."] = "施放{spell:18960}。{npc:11802}在{area:2361}；{quest:5929}位于西北边的树林里。学会{area:493}的飞行路线，然后飞往{area:702}（经由{area:442}），再乘传送门上到{zone:1457}。",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "与{quest:5929}交谈",

	-- Step 5: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Fly from {area:702} to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "从{area:702}飞往{area:442}。{object:177525}就在村子东边的山丘上：在那里使用{item:15208}，击败月爪枭兽，然后与{npc:12144}交谈。",

	-- Step 6: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker
	["Fly back to {area:702} and take the portal up to {npc:4217}."] = "飞回{area:702}，乘传送门上去找{npc:4217}。",

	-- Step 7: Heeding the Call
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village · {npc:6746} Innkeeper Pala · {zone:1456} Thunder Bluff · {npc:6929} Innkeeper Gryshka · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["At 10 a druid's call reaches you: {npc:3064} in {area:222} or {npc:6746} in {zone:1456} ({npc:6929}'s letter in {zone:1454} works too). Any one of them sends you to {npc:3033} on {area:1639} in {zone:1456}."] = "10级时会收到德鲁伊的召唤：{area:222}的{npc:3064}或{zone:1456}的{npc:6746}（{zone:1454}的{npc:6929}的信也可以）。任何一位都会让你去找{zone:1456}{area:1639}的{npc:3033}。",
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village
	["{npc:3064}, {area:222}; Pala's and Gryshka's letters lead to the same place"] = "{npc:3064}，{area:222}；帕拉和格雷什卡的信也指向同一个地方",

	-- Step 8: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033}站在{area:1639}。",

	-- Step 9: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the woods to the north-west. {npc:11798} in {area:2361} flies druids to {area:1638}."] = "施放{spell:18960}。{npc:11802}在{area:2361}；{quest:5930}位于西北边的树林里。{area:2361}的{npc:11798}可以送德鲁伊飞往{area:1638}。",
	-- {quest:5930} Great Bear Spirit
	["Speak with the {quest:5930}"] = "与{quest:5930}交谈",

	-- Step 11: The Moonkin Stone
	-- {object:177525} Moonkin Stone · {zone:1412} Mulgore · {zone:1413} Barrens · {item:15710} Cenarion Lunardust · {npc:12144} Lunaclaw Spirit
	["The {object:177525} stands in the pass from {zone:1412} into the {zone:1413}. Use the {item:15710} there, defeat Lunaclaw and speak to the {npc:12144}."] = "{object:177525}位于从{zone:1412}进入{zone:1413}的山口。在那里使用{item:15710}，击败月爪枭兽，然后与{npc:12144}交谈。",

	-- Step 12: Body and Heart
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Back to {npc:3033} on {area:1639}."] = "回到{area:1639}的{npc:3033}那里。",

	-- Step 13: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "从{area:279}乘天空飞船",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:279} Dalaran
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the north side of {area:279}."] = "{spell:5487}在{zone:2521}教授。如果你还在岛上就跳过这一步；否则从{area:279}北侧乘天空飞船。",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "乘天空飞船前往{zone:2521}",

	-- Step 14: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "从{zone:1456}乘天空飞船",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the cliffs south of {area:17045}, north of {zone:1456}."] = "{spell:5487}在{zone:2521}教授。如果你还在岛上就跳过这一步；否则从{area:17045}南边的悬崖乘天空飞船，就在{zone:1456}北边。",

	-- Step 15: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands in {area:16638}."] = "{npc:252359}站在{area:16638}。",

	-- Step 16: Urs'endris and Ur'endra
	-- {npc:255853} Urs'endris · {npc:258443} Ur'endra
	["{npc:255853} and {npc:258443}"] = "{npc:255853}和{npc:258443}",
	-- {npc:255853} Urs'endris · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands
	["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623}, west of {area:16638}."] = "{npc:255853}在{area:16638}东北边的瀑布旁等候。{npc:258443}在{area:16638}西边的{area:16623}游荡。",

	-- Step 17: Strength and Mercy
	-- {npc:255853} Urs'endris
	["Back to {npc:255853} by the falls."] = "回到瀑布旁的{npc:255853}那里。",

	-- Step 18: Child of Nature
	-- {npc:259118} Muln Earthfury · {zone:2521} Zephras Isle · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	["{npc:259118} waits where the airship from {zone:2521} lands, in northern {zone:1412} beside {zone:1456}."] = "{npc:259118}在从{zone:2521}来的飞艇降落处等候，位于{zone:1412}北部，{zone:1456}旁边。",

	-- Step 19: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} trains druids on {area:1639}."] = "{npc:3033}在{area:1639}训练德鲁伊。",

	-- Step 20: Child of Nature
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {area:279} Dalaran · {zone:2521} Zephras Isle · {npc:2543} Archmage Ansirem Runeweaver
	["{npc:270459} stands beside {npc:259084} and the Skyborne Portal, west of {area:279}, where the skycutter from {zone:2521} lands. {npc:2543} offers the same quest."] = "{npc:270459}站在{npc:259084}和天裔传送门旁，位于{area:279}西边，从{zone:2521}来的天空快船在此降落。{npc:2543}也提供同样的任务。",

	-- Step 21: Sheldras Moontree
	-- {zone:1453} Stormwind · {npc:5504} Sheldras Moontree
	["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer."] = "天裔传送门会把你送到{zone:1453}。{npc:5504}是该城的德鲁伊训练师。",

	-- Step 22: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:493} Moonglade
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Learn the {area:493} flight path while you are here."] = "施放{spell:18960}。{npc:11802}在{area:2361}。趁在这里学会{area:493}的飞行路线。",
}
