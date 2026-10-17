-- Korean (koKR): the guide forever/collectibles/pets/yarlyn-amberstill (forever/collectibles/pets/yarlyn-amberstill.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:1263} Yarlyn Amberstill
	["{npc:1263}'s Rabbits"] = "{npc:1263}의 토끼",

	-- Step 1: Yarlyn Amberstill
	-- {npc:1263} Yarlyn Amberstill · {area:803} Amberstill Ranch · {area:131} Kharanos
	["{npc:1263} stands at {area:803}, east of {area:131}. Each rabbit crate costs 20s; the Arctic and Brown crates are new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:1263}은(는) {area:131} 동쪽 {area:803}에 있습니다. 토끼 상자는 각각 20실버이며, 북극 상자와 갈색 상자는 Forever에 새로 추가되었습니다. 애완동물 아이템을 사용하면 해당 동물을 배우며, 목표는 그 후에도 체크된 상태로 남습니다.",
	-- {item:8497} Rabbit Crate (Snowshoe)
	["{item:8497}, 20s"] = "{item:8497}, 20실버",
	["20s"] = "20실버",
}
