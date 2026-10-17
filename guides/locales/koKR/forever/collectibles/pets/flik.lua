-- Korean (koKR): the guide forever/collectibles/pets/flik (forever/collectibles/pets/flik.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darkmoon Faire Frogs"] = "다크문 유랑단 개구리",

	-- Step 1: Flik at the Darkmoon Faire
	-- {npc:14860} Flik
	["{npc:14860} at the Darkmoon Faire"] = "다크문 유랑단의 {npc:14860}",
	-- {npc:14860} Flik · {area:87} Goldshire · {zone:1429} Elwynn Forest · {zone:1456} Thunder Bluff · {zone:1412} Mulgore
	["{npc:14860} sells two frogs (1g each) while the Darkmoon Faire is in town. In Era the Faire sets up south of {area:87} in {zone:1429} one month and near {zone:1456} in {zone:1412} the next; go to whichever is up. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "다크문 유랑단이 열려 있는 동안 {npc:14860}이(가) 개구리 두 종류(각 1골드)를 팝니다. 클래식에서 유랑단은 한 달은 {zone:1429} {area:87} 남쪽에, 다음 달은 {zone:1412}의 {zone:1456} 근처에 자리 잡습니다. 열려 있는 쪽으로 가십시오. 애완동물 아이템을 사용하면 그 애완동물을 배우며, 목표는 그 뒤에도 체크된 채로 남습니다.",
	-- {item:11026} Tree Frog Box
	["{item:11026}, 1g"] = "{item:11026}, 1골드",
	-- {item:11027} Wood Frog Box
	["{item:11027}, 1g"] = "{item:11027}, 1골드",
}
