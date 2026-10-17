-- Korean (koKR): the guide forever/collectibles/pets/halpa (forever/collectibles/pets/halpa.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8401} Halpa
	-- plural, as words: Prairie Dogs = {npc:2620} Prairie Dog
	["{npc:8401}'s Prairie Dogs"] = "{npc:8401}의 땅다람쥐",

	-- Step 1: Halpa
	-- {npc:8401} Halpa · {zone:1456} Thunder Bluff
	["{npc:8401} sells three whistles in {zone:1456} (50s each); the two ground squirrels are new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8401}이(가) {zone:1456}에서 호루라기 세 개를 판매합니다(각 50실버). 땅다람쥐 두 종류는 Forever에 새로 추가되었습니다. 애완동물 아이템을 사용하면 해당 동물을 배우며, 목표는 그 후에도 체크된 상태로 남습니다.",
	-- {item:10394} Prairie Dog Whistle
	["{item:10394}, 50s"] = "{item:10394}, 50실버",
	["50s"] = "50실버",
}
