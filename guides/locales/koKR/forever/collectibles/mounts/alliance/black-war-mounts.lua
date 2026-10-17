-- Korean (koKR): the guide forever/collectibles/mounts/alliance/black-war-mounts (forever/collectibles/mounts/alliance/black-war-mounts.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Black War Mounts"] = "검은 전투 탈것",

	-- Step 1: PvP rank 11
	["PvP rank 11"] = "PvP 계급 11",
	-- {spell:1299382} Rank Points
	["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Forever의 PvP 계급은 전장과 필드 PvP에서 얻는 {spell:1299382}(으)로 오르며, 주간 상한이 있습니다. 사령관(11계급)이 되면 검은 전투 탈것이 열립니다. Polestar는 계급을 읽을 수 없으므로 이 단계는 40레벨과 탈것 타기 기술을 기다립니다.",

	-- Step 2: Lieutenant Karter
	-- {npc:12783} Lieutenant Karter · {area:2918} Champions' Hall · {zone:1453} Stormwind · {object:2100} Old Town · {npc:12805} Officer Areyn
	["{npc:12783} sells the mounts in the {area:2918} in {zone:1453}'s {object:2100}, beside the other honor quartermasters such as {npc:12805}. The Forever client lists each at 100g; choose one."] = "{npc:12783}은(는) {zone:1453} {object:2100}의 {area:2918}에서 {npc:12805} 같은 다른 명예 병참장교들 옆에서 탈것을 판매합니다. Forever 클라이언트에서는 각각 100골드입니다. 하나를 고르십시오.",
	["100g"] = "100골드",
}
