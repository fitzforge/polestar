-- Chinese (simplified) (zhCN): the guide forever/class/rogue/poisons-horde (forever/class/rogue/poisons-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2842} Poisons
	["{spell:2842} (Horde)"] = "{spell:2842}（部落）",
	-- {spell:2842} Poisons · {item:7676} Thistle Tea
	["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever通过这条任务线而不是训练师来传授{spell:2842}；同时附带{item:7676}配方。",

	-- Step 1: The Shattered Salute
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["At 20 {npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Target him and type /salute."] = "20级时，{npc:3401}站在{object:172982}下方的峡谷{object:172960}中。选中他并输入/salute。",
	-- {npc:3401} Shenthul
	["/salute {npc:3401}"] = "对{npc:3401}使用/salute",
	-- {quest:2458} Deep Cover · {item:8051} Flare Gun
	["{quest:2458}: keep the {item:8051}"] = "{quest:2458}：保留{item:8051}",

	-- Step 2: Taskmaster Fizzule
	-- {area:380} Crossroads · {area:382} Sludge Fen · {item:8051} Flare Gun · {npc:7233} Taskmaster Fizzule
	["Fly to the {area:380} and ride north to the Venture Co. tower north of the {area:382}. In sight of the tower, fire the {item:8051} twice, then /salute {npc:7233} before he attacks you."] = "飞往{area:380}，向北骑到{area:382}以北的风险投资公司塔楼。在能看到塔楼的地方发射两次{item:8051}，然后在{npc:7233}攻击你之前对他使用/salute。",
	-- {item:8051} Flare Gun
	["{item:8051}, twice, in sight of the tower"] = "{item:8051}，在能看到塔楼处发射两次",

	-- Step 3: Mission: Possible But Not Probable
	-- {npc:7287} Foreman Silixiz
	["Stay stealthed. {npc:7287} carries the tower key; Gallywix (elite) and his lockbox are at the top of the tower. Kill two each of the drones, patrollers and lookouts around it."] = "保持潜行。{npc:7287}带着塔楼钥匙；加里维克斯（精英）和他的保险箱在塔顶。在塔周围的风险投资公司雄蜂、巡逻员和看守各击杀两个。",
	-- {item:8074} Gallywix's Head · {npc:7288} Grand Foreman Puzik Gallywix
	["{item:8074}: {npc:7288} (elite)"] = "{item:8074}：{npc:7288}（精英）",

	-- Step 4: Back to Shenthul
	-- {npc:3401} Shenthul
	["Back to {npc:3401}"] = "回到{npc:3401}处",
	-- {zone:1454} Orgrimmar
	["Fly back to {zone:1454}."] = "飞回{zone:1454}。",

	-- Step 5: Serge Hinott
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:272} Tarren Mill · {area:287} Hillsbrad · {npc:2391} Serge Hinott
	["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south through {zone:1421} to {area:272} in {area:287}. {npc:2391} stands in {area:272}; wait beside him while he brews the cure."] = "从{zone:1454}乘飞艇前往{zone:1458}，向南骑行穿过{zone:1421}，到达{area:287}的{area:272}。{npc:2391}站在{area:272}；在他旁边等他调制解药。",
	["Wait for the cure"] = "等待解药",
}
