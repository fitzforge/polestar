-- Korean (koKR): the guide forever/collectibles/pets/lil-timmy (forever/collectibles/pets/lil-timmy.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Lil Timmy
	-- {npc:8666} Lil Timmy · {npc:7386} White Kitten · {object:2098} Cathedral Square · {object:2096} Trade District · {object:2100} Old Town · {object:28027} Dwarven District
	["{npc:8666} sells the {npc:7386} (60s). He starts at {object:2098} and walks through the {object:2096}, {object:2100} and the {object:28027} before he vanishes near the square again; if he is not around, wait for him at {object:2098}. By beta reports he carries one kitten at a time: if he has none, someone just bought it. Each pet item teaches its companion when you use it; the goal stays ticked afterwards."] = "",
	-- {item:8489} Cat Carrier (White Kitten)
	["{item:8489}, 60s"] = "{item:8489}, 60실버",

	-- Step 2: Xaphod Bizznox
	-- {npc:7386} White Kitten · {npc:262471} Xaphod Bizznox · {area:2539} Malaka'jin · {zone:1442} Stonetalon Mountains · {zone:1413} Barrens
	["Horde players buy the {npc:7386} (60s) from {npc:262471}, a trader new in Forever, at {area:2539}, the Darkspear camp at the southern tip of {zone:1442}, on the way up from the {zone:1413}. He keeps one kitten at a time: if he has none, someone just bought it. Each pet item teaches its companion when you use it; the goal stays ticked afterwards."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:8666} sells the {npc:7386} (60s). He walks around the city, so the waypoint is only one point on his path; look along the nearby streets if he is not there. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8666}이(가) {npc:7386}을(를) 판매합니다(60실버). 도시를 돌아다니므로 경유지는 경로상의 한 지점일 뿐입니다. 없으면 근처 거리를 둘러보십시오. 애완동물 아이템을 사용하면 해당 동물을 배우며, 목표는 그 후에도 체크된 상태로 남습니다.",
}
