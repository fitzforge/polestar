-- Korean (koKR): the guide forever/collectibles/pets/xantish (forever/collectibles/pets/xantish.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8404} Xan'tish
	["{npc:8404}'s Snakes"] = "{npc:8404}의 뱀",

	-- Step 1: Xan'tish
	-- {npc:8404} Xan'tish · {object:172961} Valley of Spirits · {item:280703} Jungle Boa
	["{npc:8404}, the snake vendor, walks with his three snakes: from the {object:172961} north along the city's west side to the battleground emissaries and back. The waypoint is where his walk starts; if he is not there, follow the road north. He sells four snakes (50s each); the {item:280703} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "뱀 상인 {npc:8404}은(는) 뱀 세 마리와 함께 {object:172961}에서 도시 서쪽을 따라 북쪽 전장 사절단까지 갔다가 돌아옵니다. 지점은 산책이 시작되는 곳이며 없으면 도로를 따라 북쪽으로 가세요. 뱀 네 마리를 팝니다(각 50실버). {item:280703}은(는) Forever에 새로 추가된 아이템입니다. 애완동물 아이템을 사용하면 동료를 배우고 목표는 이후에도 체크된 상태로 남습니다.",
	-- {item:10360} Black Kingsnake
	["{item:10360}, 50s"] = "{item:10360}, 50실버",
	-- {item:10361} Brown Snake
	["{item:10361}, 50s"] = "{item:10361}, 50실버",
	-- {item:10392} Crimson Snake
	["{item:10392}, 50s"] = "{item:10392}, 50실버",
	["50s"] = "50실버",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:8404} sells four snakes in {zone:1454} (50s each); the {item:280703} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8404}은(는) {zone:1454}에서 뱀 네 종류를 팝니다(각 50실버). {item:280703}은(는) Forever에 새로 추가되었습니다. 애완동물 아이템을 사용하면 해당 애완동물을 배우며, 그 후에도 목표는 체크된 상태로 남습니다.",
}
