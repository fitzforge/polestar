-- Chinese (traditional) (zhTW): the guide forever/class/rogue/poisons-horde (forever/class/rogue/poisons-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2842} Poisons
	["{spell:2842} (Horde)"] = "{spell:2842}（部落）",
	-- {spell:2842} Poisons · {item:7676} Thistle Tea
	["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever 透過這個任務鏈教授{spell:2842}，而不是由訓練師教授；{item:7676}的配方也會一起給你。",

	-- Step 1: The Shattered Salute
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["At 20 {npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Target him and type /salute."] = "20級時，{npc:3401}站在{object:172960}，也就是{object:172982}下方的峽谷。選取他並輸入 /salute。",
	-- {npc:3401} Shenthul
	["/salute {npc:3401}"] = "對{npc:3401}輸入 /salute",
	-- {quest:2458} Deep Cover · {item:8051} Flare Gun
	["{quest:2458}: keep the {item:8051}"] = "{quest:2458}：保留{item:8051}",

	-- Step 2: Taskmaster Fizzule
	-- {area:380} Crossroads · {area:382} Sludge Fen · {item:8051} Flare Gun · {npc:7233} Taskmaster Fizzule
	["Fly to the {area:380} and ride north to the Venture Co. tower north of the {area:382}. In sight of the tower, fire the {item:8051} twice, then /salute {npc:7233} before he attacks you."] = "飛往{area:380}，向北騎往{area:382}北邊的風險投資公司塔樓。在看得到塔樓的地方發射兩次{item:8051}，然後在{npc:7233}攻擊你之前對他 /salute。",
	-- {item:8051} Flare Gun
	["{item:8051}, twice, in sight of the tower"] = "{item:8051}，兩次，在看得到塔樓的地方",

	-- Step 3: Mission: Possible But Not Probable
	-- {npc:7287} Foreman Silixiz
	["Stay stealthed. {npc:7287} carries the tower key; Gallywix (elite) and his lockbox are at the top of the tower. Kill two each of the drones, patrollers and lookouts around it."] = "保持潛行。{npc:7287}帶著塔樓的鑰匙；加里維克斯（精英）和他的帶鎖箱在塔頂。擊殺塔周圍的風險投資公司雄蜂、巡邏員和看守各兩個。",
	-- {item:8074} Gallywix's Head · {npc:7288} Grand Foreman Puzik Gallywix
	["{item:8074}: {npc:7288} (elite)"] = "{item:8074}：{npc:7288}（精英）",

	-- Step 4: Back to Shenthul
	-- {npc:3401} Shenthul
	["Back to {npc:3401}"] = "返回{npc:3401}",
	-- {zone:1454} Orgrimmar
	["Fly back to {zone:1454}."] = "飛回{zone:1454}。",

	-- Step 5: Serge Hinott
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:272} Tarren Mill · {area:287} Hillsbrad · {npc:2391} Serge Hinott
	["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south through {zone:1421} to {area:272} in {area:287}. {npc:2391} stands in {area:272}; wait beside him while he brews the cure."] = "從{zone:1454}搭飛艇前往{zone:1458}，向南騎過{zone:1421}，前往{area:287}的{area:272}。{npc:2391}站在{area:272}；在他調製解藥時在旁邊等候。",
	["Wait for the cure"] = "等待解藥",
}
