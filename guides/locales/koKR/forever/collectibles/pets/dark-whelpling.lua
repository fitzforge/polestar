-- Korean (koKR): the guide forever/collectibles/pets/dark-whelpling (forever/collectibles/pets/dark-whelpling.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Black whelps
	["Black whelps"] = "검은 새끼용",
	-- {area:511} Wyrmbog · {zone:1445} Dustwallow Marsh · {zone:1418} Badlands
	-- plural, as words: Searing Whelps = {npc:4324} Searing Whelp · Scalding Whelps = {npc:2725} Scalding Whelp
	["The Searing Whelps of the {area:511} in southern {zone:1445} (level 42) and the Scalding Whelps of eastern {zone:1418} (level 41) drop it about once in 900 kills in our data. The waypoint is the {area:511}; the {zone:1418} whelps are the same grind."] = "{zone:1445} 남부 {area:511}의 화염 새끼용(레벨 42)과 {zone:1418} 동부의 화염의 새끼비룡(레벨 41)이 우리 데이터상 약 900번 처치에 한 번 떨어뜨립니다. 경유지는 {area:511}이며, {zone:1418}의 새끼용도 똑같이 반복 사냥해야 합니다.",
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
}
