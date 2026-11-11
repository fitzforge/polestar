-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/neutral/warlock-felsteed (forever/collectibles/mounts/neutral/warlock-felsteed.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Felsteed"] = "术士地狱战马",
	["Your own mount at 40, summoned anywhere: no 100g riding training needed."] = "40级时获得你自己的坐骑，随处召唤：无需花100金学习骑术。",

	-- Step 1: Summon Felsteed (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:461}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6251} in {area:392}. No quest offered? Finish the felhunter chain first: players report the mount comes after it."] = "40级时，{object:2101}的{object:2164}地下室里的{npc:461}会让你去找{area:392}的{npc:6251}。没有任务可接？先完成地狱猎犬任务链：玩家报告说坐骑任务在那之后才开放。",

	-- Step 2: Summon Felsteed (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:5172}, by the warlock trainers in {zone:1455}, sends you to {npc:6251} in {area:392}. No quest offered? Finish the felhunter chain first: players report the mount comes after it."] = "40 级时，{zone:1455} 术士训练师旁的 {npc:5172} 会让你去 {area:392} 找 {npc:6251}。没有任务可接？先完成地狱猎犬任务链：玩家反映坐骑任务会在它之后开放。",

	-- Step 3: Summon Felsteed (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:3326}, in the {object:172960}, sends you to {npc:6251} in {area:392}. No quest offered? Finish the felhunter chain first: players report the mount comes after it."] = "40 级时，{object:172960} 内的 {npc:3326} 会让你去 {area:392} 找 {npc:6251}。没有任务可接？先完成地狱猎犬任务链：玩家反映坐骑任务会在它之后开放。",

	-- Step 4: Summon Felsteed (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["At 40 {npc:4563}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}; {area:392} is a short flight from {zone:1454}. No quest offered? Finish the felhunter chain first: players report the mount comes after it."] = "40 级时，{object:36082} 内的 {npc:4563} 会让你去 {area:392} 找 {npc:6251}。从 {zone:1420} 出发的飞艇飞往 {zone:1411}；从 {zone:1454} 飞到 {area:392} 只需很短时间。没有任务可接？先完成地狱猎犬任务链：玩家反映坐骑任务会在它之后开放。",

	-- Step 5: Strahad Farsan in Ratchet
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:6251} in {area:392}"] = "{area:392}的{npc:6251}",
	-- {area:392} Ratchet · {zone:1413} Barrens · {area:35} Booty Bay · {npc:6251} Strahad Farsan · {quest:3631} Summon Felsteed
	["{area:392} is the goblin port on the {zone:1413} coast, east of the Crossroads; from the Alliance side take the boat from {area:35}. {npc:6251} stands by his small tower on the hill above the town, not down at the docks. Hand in, then take his own {quest:3631} and hand it straight back: that teaches you the mount. No fight, and the quests ask for nothing."] = "{area:392}是{zone:1413}海岸的地精港口，在十字路口以东；联盟从{area:35}坐船前往。{npc:6251}站在镇子上方山丘的小塔旁，不在下面的码头。交完任务，再接他提供的{quest:3631}并直接交回，即可学会坐骑。无需战斗，任务也不要求任何物品。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 40 {npc:3326} in the {object:172960} sends you to {npc:6251} in {area:392}."] = "40级时，{object:172960}的{npc:3326}会让你去{area:392}找{npc:6251}。",
	-- ["At 40 {npc:4563} in the {object:36082} sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "40级时，{object:36082}的{npc:4563}会让你去{area:392}找{npc:6251}。从{zone:1420}出发的飞艇飞往{zone:1411}。",
	-- ["At 40 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "40级时，{object:2101}{object:2164}的{npc:461}会让你去{area:392}找{npc:6251}。",
	-- ["At 40 {npc:5172} in {zone:1455} sends you to {npc:6251} in {area:392}."] = "40级时，{zone:1455}的{npc:5172}会让你去{area:392}找{npc:6251}。",
	-- ["Your own mount at 40, summoned anywhere, with no gold spent on a riding horse."] = "40级时获得你自己的坐骑，随处召唤，不必花金币买骑乘用的马。",
	-- ["{area:392} is on the {zone:1413} coast east of the {area:380}; from the Alliance side, take the boat from {area:35}. {npc:6251}'s follow-up teaches {quest:3631}."] = "{area:392}位于{zone:1413}海岸、{area:380}东边；联盟一方从{area:35}乘船前往。{npc:6251}的后续任务教授{quest:3631}。",
}
