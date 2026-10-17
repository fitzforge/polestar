-- Korean (koKR): the guide forever/class/priest/divine-grace-and-feedback (forever/class/priest/divine-grace-and-feedback.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["{quest:94773} and {spell:13896}"] = "{quest:94773} 및 {spell:13896}",
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["The Human priest spells: {quest:94773} at 10, {spell:13896} at 20."] = "인간 사제 주문: 10레벨에 {quest:94773}, 20레벨에 {spell:13896}.",

	-- Step 1: Divine Grace
	-- {npc:376} High Priestess Laurena · {npc:377} Priestess Josetta · {area:87} Goldshire
	["At 10, go to {npc:376} in the Cathedral of Light. {npc:377} in {area:87} sends you to her with a quest of the same name."] = "10레벨에 빛의 대성당의 {npc:376}에게 가십시오. {area:87}의 {npc:377}이(가) 같은 이름의 퀘스트로 그녀에게 보냅니다.",

	-- Step 2: Arcane Feedback
	-- {npc:376} High Priestess Laurena · {spell:13896} Feedback · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 20, {npc:376} teaches {spell:13896}. {npc:11406} in {zone:1455} and {npc:11401} in {zone:1457} send you to her with a quest of the same name."] = "20레벨에 {npc:376}이(가) {spell:13896}을(를) 가르칩니다. {zone:1455}의 {npc:11406}와(과) {zone:1457}의 {npc:11401}이(가) 같은 이름의 퀘스트로 그녀에게 보냅니다.",
}
