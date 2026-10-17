-- Korean (koKR): the guide forever/collectibles/pets/shylenai (forever/collectibles/pets/shylenai.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8665} Shylenai
	["{npc:8665}'s Owls"] = "{npc:8665}의 부엉이",

	-- Step 1: Shylenai
	-- {npc:8665} Shylenai · {zone:1457} Darnassus · {item:280803} Eagle Owl
	["{npc:8665} sells three owls in {zone:1457} (50s each); the {item:280803} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8665}이(가) {zone:1457}에서 부엉이 세 종류를 판매합니다(각 50실버). {item:280803}은(는) Forever에 새로 추가되었습니다. 애완동물 아이템을 사용하면 해당 동물을 배우며, 목표는 그 후에도 체크된 상태로 남습니다.",
	-- {item:8500} Great Horned Owl
	["{item:8500}, 50s"] = "{item:8500}, 50실버",
	-- {item:8501} Hawk Owl
	["{item:8501}, 50s"] = "{item:8501}, 50실버",
	["50s"] = "50실버",
}
