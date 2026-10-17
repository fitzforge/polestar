-- Chinese (simplified) (zhCN): the guide forever/class/warlock/orb-of-orahil (forever/class/warlock/orb-of-orahil.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orb of Orahil"] = "奥拉赫宝珠",
	["An off-hand orb or a staff for your late 30s, down the felhound's or the infernal's path, your pick."] = "三十多级的副手宝珠或法杖，可选地狱犬或地狱火路线。",

	-- Step 1: Knowledge of the Orb of Orahil (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "35级时，{object:2101}{object:2164}的{npc:461}会让你去{area:392}找{npc:6266}。",

	-- Step 2: Knowledge of the Orb of Orahil (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "35级时，{zone:1455}的{npc:5172}会让你去{area:392}找{npc:6266}。",

	-- Step 3: Knowledge of the Orb of Orahil (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "35级时，{object:172960}的{npc:3326}会让你去{area:392}找{npc:6266}。",

	-- Step 4: Knowledge of the Orb of Orahil (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 35 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "35级时，{object:36082}的{npc:4563}会让你去{area:392}找{npc:6266}。从{zone:1420}出发的飞艇飞往{zone:1411}。",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["{npc:6266} and her two acolytes stand in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266}和她的两名侍僧站在{area:392}上方山丘的塔里，就在{npc:6251}旁边。",

	-- Step 6: Choose an acolyte
	["Choose an acolyte"] = "选择一名侍僧",
	-- {npc:6254} Acolyte Wytula · {item:15106} Staff of Dar'Orahil · {npc:6252} Acolyte Magaz · {item:15105} Staff of Noh'Orahil
	["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, {npc:6252}'s infernal path with the Orb or {item:15105}. The guide follows the one you take."] = "选择一名侍僧：你只能接其中一人的任务。{npc:6254}的地狱犬路线最终奖励宝珠或{item:15106}，{npc:6252}的地狱火路线最终奖励宝珠或{item:15105}。本指南会跟随你选择的路线。",
	-- {npc:6254} Acolyte Wytula · {item:12647} Felhas Ruby
	["{npc:6254}: she gives you the {item:12647}"] = "{npc:6254}：她给你{item:12647}",
	-- {npc:6252} Acolyte Magaz · {item:12646} Infus Emerald
	["{npc:6252}: he gives you the {item:12646}"] = "{npc:6252}：他给你{item:12646}",

	-- Step 7: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {item:7291} Infernal Orb · {item:12647} Felhas Ruby · {npc:4678} Mana Eater · {item:12646} Infus Emerald · {npc:4676} Lesser Infernal
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["The demons of {area:602}, in southern {zone:1443}, have all you need. Burning Blade Summoners carry the {item:7291}. On the felhound path, use the {item:12647} on a {npc:4678}, a felhound, and kill it for its spirit; on the infernal path, use the {item:12646} on a {npc:4676} and kill it."] = "{zone:1443}南部{area:602}的恶魔身上有你需要的一切。{npc:4668}携带{item:7291}。地狱犬路线：对一只地狱犬{npc:4678}使用{item:12647}，然后杀死它取得其灵魂；地狱火路线：对一只{npc:4676}使用{item:12646}并杀死它。",
	-- {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["{item:7291}, from the Burning Blade Summoners"] = "{item:7291}，来自{npc:4668}",
	-- {item:12648} Imprisoned Felhound Spirit · {npc:4678} Mana Eater
	["{item:12648}, from a {npc:4678}"] = "{item:12648}，来自{npc:4678}",
	-- {item:12649} Imprisoned Infernal Spirit · {npc:4676} Lesser Infernal
	["{item:12649}, from a {npc:4676}"] = "{item:12649}，来自{npc:4676}",

	-- Step 8: The demon's spirit
	["The demon's spirit"] = "恶魔的灵魂",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6546} Tabetha
	["Back to {npc:6266} in the tower above {area:392} with the spirit first: {npc:6546}'s cleansing follows it."] = "先带着灵魂回到{area:392}上方塔里找{npc:6266}：之后是{npc:6546}的净化。",

	-- Step 9: Tabetha
	-- {npc:6546} Tabetha · {zone:1445} Dustwallow Marsh · {npc:6549} Demon of the Orb · {item:7291} Infernal Orb
	["{npc:6546} lives at her farm in western {zone:1445}. She calls the {npc:6549} out of the {item:7291}; it is elite: grouping up is advised."] = "{npc:6546}住在{zone:1445}西部她的农场里。她会从{item:7291}中召唤出{npc:6549}；它是精英：建议组队。",

	-- Step 10: The Orb of Dar'Orahil
	-- {item:15108} Orb of Dar'Orahil
	["The {item:15108}"] = "{item:15108}",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:15108} Orb of Dar'Orahil
	["Back to {npc:6266} in the tower above {area:392} with the cleansed orb. On the felhound path, wait while she completes the {item:15108}, then speak to her again."] = "带着净化后的宝珠回到{area:392}上方塔里找{npc:6266}。地狱犬路线：等她完成{item:15108}，然后再次与她交谈。",
	["Wait for the orb"] = "等待宝珠",

	-- Step 11: The Orb of Noh'Orahil
	-- {item:15107} Orb of Noh'Orahil
	["The {item:15107}"] = "{item:15107}",
	-- {npc:6266} Menara Voidrender · {item:15107} Orb of Noh'Orahil
	["On the infernal path, wait while {npc:6266} completes the {item:15107}, then speak to her again."] = "地狱火路线：等{npc:6266}完成{item:15107}，然后再次与她交谈。",
}
