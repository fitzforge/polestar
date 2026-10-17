-- Korean (koKR): the guide forever/collectibles/mounts/neutral/spectral-bear (forever/collectibles/mounts/neutral/spectral-bear.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "수습 {skill:762}",
	-- {skill:762} Riding
	["The reins need level 60 and Journeyman {skill:762} (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "고삐를 사용하려면 60레벨과 수습 {skill:762}이(가) 필요합니다(Forever 클라이언트). 종족의 탈것 상급자에게 배우세요. 60레벨 탈것 가이드를 참고하세요.",

	-- Step 2: 55 Legacy Points
	["55 Legacy Points"] = "유산 점수 55점",
	-- {item:281060} Replica Ironforge Air Rifle · {npc:268840} Spectral Bear Cub · {item:277717} Spectral Bear Tabard
	["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, professions, PvP, exploring) is worth one. The Progress Track gives the {item:281060} at 15, the {npc:268840} at 25, the {item:277717} at 40 and the reins at 55. How rewards are delivered is not known yet (perhaps by mail); this goal ticks once the reins are in your bags."] = "유산 점수는 계정 공유입니다. 유산 도전(직업 하나가 25, 45, 60레벨 달성, 전문 기술, PvP, 탐험)마다 1점입니다. 진행 트랙에서 15점에 {item:281060}, 25점에 {npc:268840}, 40점에 {item:277717}, 55점에 고삐를 줍니다. 보상 지급 방식은 아직 알려지지 않았습니다(아마 우편). 고삐가 가방에 들어오면 이 목표가 체크됩니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Spectral Bear"] = "유령 곰",
}
