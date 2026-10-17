-- Chinese (traditional) (zhTW): the guide forever/class/warlock/impsys-request (forever/class/warlock/impsys-request.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14470} Impsy
	["A staff, off-hand or robe for your 50s; {npc:14470}'s own errand, not a step of the Dreadsteed chain."] = "50多級用的法杖、副手或長袍；{npc:14470}自己的差事，不屬於恐懼戰馬任務鏈。",

	-- Step 1: An Imp's Request (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:14470} Impsy · {zone:1448} Felwood
	["At 50 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:14470} in {zone:1448}."] = "50級時，{object:2101}{object:2164}的{npc:461}會派你去找{zone:1448}的{npc:14470}。",

	-- Step 2: An Imp's Request (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:14470} Impsy · {zone:1448} Felwood
	["At 50 {npc:5172} in {zone:1455} sends you to {npc:14470} in {zone:1448}."] = "50級時，{zone:1455}的{npc:5172}會派你去找{zone:1448}的{npc:14470}。",

	-- Step 3: An Imp's Request (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:14470} Impsy · {zone:1448} Felwood
	["At 50 {npc:3326} in the {object:172960} sends you to {npc:14470} in {zone:1448}."] = "50級時，{object:172960}的{npc:3326}會派你去找{zone:1448}的{npc:14470}。",

	-- Step 4: An Imp's Request (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:14470} Impsy · {zone:1448} Felwood
	["At 50 {npc:4563} in the {object:36082} sends you to {npc:14470} in {zone:1448}."] = "50級時，{object:36082}的{npc:4563}會派你去找{zone:1448}的{npc:14470}。",

	-- Step 5: Felcloth
	-- {npc:14470} Impsy · {item:14256} Felcloth · {area:1763} Jaedenar
	["{npc:14470} wants one {item:14256}: the Jadefire satyrs and the demons of {area:1763} drop it."] = "{npc:14470}要一塊{item:14256}：碧火薩特和{area:1763}的惡魔會掉落。",

	-- Step 6: Impsy
	-- {npc:14470} Impsy · {npc:14469} Niby the Almighty · {zone:1448} Felwood · {area:1763} Jaedenar · {item:18762} Shard of the Green Flame
	["{npc:14470} waits beside {npc:14469} in central {zone:1448}, just east of {area:1763}. This chain is {npc:14470}'s own and is not part of the Dreadsteed chain; Niby and {npc:14470} also give the {item:18762} chain here."] = "{npc:14470}在{zone:1448}中部、{area:1763}東邊不遠處，待在{npc:14469}旁邊。此任務鏈是{npc:14470}自己的，不屬於恐懼戰馬任務鏈；尼比和{npc:14470}也在這裡提供{item:18762}任務鏈。",

	-- Step 7: Rotting Wood and Bloodvenom
	-- {item:20613} Rotting Wood
	["{item:20613} and Bloodvenom"] = "{item:20613}與血毒",
	-- {zone:1448} Felwood · {item:20613} Rotting Wood · {area:1763} Jaedenar · {item:20614} Bloodvenom Essence
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Irontree treants in northern {zone:1448} drop the {item:20613}; the Tainted Oozes around {area:1763} the {item:20614}."] = "{zone:1448}北部的鐵木樹人會掉落{item:20613}；{area:1763}周圍的被污染的軟泥怪會掉落{item:20614}。",

	-- Step 8: Impsy again
	-- {npc:14470} Impsy
	["{npc:14470} again"] = "再次找{npc:14470}",

	-- Step 9: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears
	["The six troll guardians of the {area:1417}, a level 50 dungeon, each drop a Voodoo Feather: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance."] = "{area:1417}（50級地城）的六名食人妖守護者各掉落一根巫毒羽毛：找五人小隊一起去。神廟位於{area:74}中央；游下去即可到達入口。",
}
