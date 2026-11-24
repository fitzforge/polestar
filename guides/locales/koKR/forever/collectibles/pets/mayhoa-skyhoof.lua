-- Korean (koKR): the guide forever/collectibles/pets/mayhoa-skyhoof (forever/collectibles/pets/mayhoa-skyhoof.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mayhoa Skyhoof
	-- {npc:268745} Mayhoa Skyhoof · {zone:1454} Orgrimmar · {object:172957} Valley of Wisdom · {object:172958} Valley of Honor
	["{npc:268745}, the girl with puppies, walks a long loop through {zone:1454}: from the {object:172957} through the Drag to the {object:172958} and back. The waypoint is where she is seen most, on the road between the Drag and the {object:172958}; if she is not there, walk the loop. The carrier costs 60s. She carries one pup at a time: if she has none, another player just bought it, so come back later. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "강아지를 데린 소녀 {npc:268745}은(는) {zone:1454}을 한 바퀴 도는데, {object:172957}에서 드래그를 지나 {object:172958}로 갔다가 돌아옵니다. 지점은 드래그와 {object:172958} 사이 도로로 가장 자주 목격되는 곳입니다. 없으면 순로를 따라 걸어보세요. 운반 상자는 60실버입니다. 한 번에 강아지 한 마리만 있으니 없다면 다른 플레이어가 방금 구매한 것이니 나중에 오세요. 애완동물 아이템을 사용하면 동료를 배우고 목표는 이후에도 체크된 상태로 남습니다.",
	["60s"] = "60실버",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:268745} walks a long loop through {zone:1454} (from the {object:172982} to the Drag); the waypoint is one point on her path. The carrier costs 60s. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:268745}은(는) {zone:1454}을(를) 길게 한 바퀴 돕니다({object:172982}에서 골목길까지). 경유지는 그 경로의 한 지점입니다. 운반통은 60실버입니다. 애완동물 아이템은 사용하면 그 애완동물을 배웁니다. 목표는 그 후에도 완료 표시가 유지됩니다.",
}
