-- Korean (koKR): the guide forever/class/priest/touch-of-weakness-and-dark-sacrifice (forever/class/priest/touch-of-weakness-and-dark-sacrifice.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["{spell:2652} and {quest:5644}"] = "{spell:2652} 및 {quest:5644}",
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["The Undead priest spells: {spell:2652} at 10, {quest:5644} at 20."] = "언데드 사제 주문: 10레벨에 {spell:2652}, 20레벨에 {quest:5644}.",

	-- Step 1: Touch of Weakness
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {npc:3706} Tai'jin · {area:362} Razor Hill · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff
	["At 10, go to {npc:4606} in the {zone:1458}'s {object:36070}. Priest trainers elsewhere ({npc:6018} in {zone:1454}, {npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to her with a quest of the same name."] = "10레벨에 {zone:1458} {object:36070}의 {npc:4606}에게 가십시오. 다른 곳의 사제 상급자({zone:1454}의 {npc:6018}, {area:362}의 {npc:3706}, {zone:1456}의 {npc:3044})가 같은 이름의 퀘스트로 그녀에게 보냅니다.",

	-- Step 2: Dark Sacrifice
	-- {npc:4606} Aelthalyste · {quest:5644} Dark Sacrifice · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff
	["At 20, {npc:4606} teaches {quest:5644}. {npc:6018} in {zone:1454} and {npc:3044} in {zone:1456} send you to her with a quest of the same name."] = "20레벨에 {npc:4606}이(가) {quest:5644}을(를) 가르칩니다. {zone:1454}의 {npc:6018}과(와) {zone:1456}의 {npc:3044}이(가) 같은 이름의 퀘스트로 그녀에게 보냅니다.",
}
