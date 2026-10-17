-- Chinese (traditional) (zhTW): the guide forever/class/warlock/shard-of-the-green-flame (forever/class/warlock/shard-of-the-green-flame.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood
	["A rare off-hand for your 50s from {npc:14469} and {npc:14470} in {zone:1448}, the camp that also offers An Imp's Request."] = "50多級時從{zone:1448}{npc:14469}和{npc:14470}取得的稀有副手，這個營地也提供「小鬼的要求」。",

	-- Step 1: Niby the Almighty
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood · {area:1763} Jaedenar
	["At 50 {npc:14469} and his imp {npc:14470} wait in central {zone:1448}, just east of {area:1763}."] = "50級時，{npc:14469}和他的小鬼{npc:14470}在{zone:1448}中部、{area:1763}東邊等候。",

	-- Step 2: Jaedenar
	-- {npc:14469} Niby the Almighty · {area:1763} Jaedenar
	-- plural, as words: Jaedenar Legionnaires = {npc:9862} Jaedenar Legionnaire
	["The Jaedenar Legionnaires, a short way west of {npc:14469}, carry {area:1763}'s essence."] = "在{npc:14469}西邊不遠處的加德納爾軍團士兵帶著{area:1763}的精華。",

	-- Step 3: Azshara
	-- {zone:1447} Azshara
	["The Legashi satyrs of northern {zone:1447} carry {zone:1447}'s essence."] = "{zone:1447}北部的雷加斯薩特帶著{zone:1447}的精華。",

	-- Step 4: The Dark Portal
	-- {area:72} The Dark Portal · {zone:1419} Blasted Lands
	["The Felguard Sentries around the {area:72}, in southern {zone:1419}, carry its essence."] = "{zone:1419}南部{area:72}周圍的地獄衛士斥候帶著它的精華。",

	-- Step 6: Kroshius
	-- {npc:14467} Kroshius · {area:1766} Shatter Scar Vale · {npc:14469} Niby the Almighty · {item:18626} Fel Fire
	["{npc:14467}' remains lie in {area:1766}, north of {npc:14469}. Use the {item:18626} beside them and kill the infernal when he wakes. {npc:14467} is elite: grouping up is advised."] = "{npc:14467}的遺骸在{npc:14469}北邊的{area:1766}。在遺骸旁使用{item:18626}，等地獄火醒來後擊殺他。{npc:14467}是精英：建議組隊。",
	-- {item:18626} Fel Fire · {object:179677} Kroshius' Remains (no name in this language: may be words)
	["{item:18626}, at {object:179677}"] = "{item:18626}，在{object:179677}",

	-- Step 7: Back to Niby the Almighty
	-- {npc:14469} Niby the Almighty
	["Back to {npc:14469}"] = "回到{npc:14469}那裡",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Felguard Sentries around the {area:72}, in southern {zone:1419}, carry its essence."] = "{zone:1419}南部{area:72}周圍的地獄衛士斥候帶著它的精華。",
}
