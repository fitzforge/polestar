-- Korean (koKR): the guide forever/class/warlock/shard-of-the-green-flame (forever/class/warlock/shard-of-the-green-flame.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood
	["A rare off-hand for your 50s from {npc:14469} and {npc:14470} in {zone:1448}, the camp that also offers An Imp's Request."] = "{zone:1448}의 {npc:14469}와(과) {npc:14470}이(가) 주는 50레벨대 희귀 보조장비입니다. 임프의 부탁도 주는 곳입니다.",

	-- Step 1: Niby the Almighty
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood · {area:1763} Jaedenar
	["At 50 {npc:14469} and his imp {npc:14470} wait in central {zone:1448}, just east of {area:1763}."] = "50레벨에 {npc:14469}과(와) 그의 임프 {npc:14470}이(가) {zone:1448} 중앙, {area:1763} 바로 동쪽에서 기다립니다.",

	-- Step 2: Jaedenar
	-- {npc:14469} Niby the Almighty · {area:1763} Jaedenar
	-- plural, as words: Jaedenar Legionnaires = {npc:9862} Jaedenar Legionnaire
	["The Jaedenar Legionnaires, a short way west of {npc:14469}, carry {area:1763}'s essence."] = "{npc:14469}의 서쪽 조금 떨어진 곳의 {npc:9862}이(가) {area:1763}의 정수를 가지고 있습니다.",

	-- Step 3: Azshara
	-- {zone:1447} Azshara
	["The Legashi satyrs of northern {zone:1447} carry {zone:1447}'s essence."] = "{zone:1447} 북쪽의 레가쉬 사티로스가 {zone:1447}의 정수를 가지고 있습니다.",

	-- Step 4: The Dark Portal
	-- {area:72} The Dark Portal · {zone:1419} Blasted Lands
	["The Felguard Sentries around the {area:72}, in southern {zone:1419}, carry its essence."] = "{zone:1419} 남쪽 {area:72} 주변의 지옥군단병 보초가 그 정수를 가지고 있습니다.",

	-- Step 6: Kroshius
	-- {npc:14467} Kroshius · {area:1766} Shatter Scar Vale · {npc:14469} Niby the Almighty · {item:18626} Fel Fire
	["{npc:14467}' remains lie in {area:1766}, north of {npc:14469}. Use the {item:18626} beside them and kill the infernal when he wakes. {npc:14467} is elite: grouping up is advised."] = "{npc:14467}의 유해는 {npc:14469} 북쪽 {area:1766}에 있습니다. 그 옆에서 {item:18626}을(를) 사용하고 깨어나는 지옥불정령을 처치하십시오. {npc:14467}은(는) 정예입니다. 파티를 권장합니다.",
	-- {item:18626} Fel Fire · {object:179677} Kroshius' Remains (no name in this language: may be words)
	["{item:18626}, at {object:179677}"] = "{item:18626}, {object:179677}에서",

	-- Step 7: Back to Niby the Almighty
	-- {npc:14469} Niby the Almighty
	["Back to {npc:14469}"] = "{npc:14469}에게 돌아가기",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Felguard Sentries around the {area:72}, in southern {zone:1419}, carry its essence."] = "{zone:1419} 남쪽 {area:72} 주변의 지옥군단병 보초가 그 정수를 가지고 있습니다.",
}
