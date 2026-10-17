-- Korean (koKR): the guide forever/collectibles/mounts/horde/black-war-mounts (forever/collectibles/mounts/horde/black-war-mounts.guide).
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
	["PvP rank 11"] = "PvP 11계급",
	-- {spell:1299382} Rank Points · {spell:436438} Lieutenant General
	["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Forever의 PvP 계급은 전장과 필드 PvP에서 얻는 {spell:1299382}(으)로 오르며, 주간 상한이 있습니다. {spell:436438}(11계급)이 되면 검은 전투 탈것이 열립니다. Polestar는 계급을 읽을 수 없으므로 이 단계는 40레벨과 탈것 타기 기술을 기다립니다.",

	-- Step 2: Raider Bork
	-- {npc:12796} Raider Bork · {area:2917} Hall of Legends · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:12799} Sergeant Ba'sha
	["{npc:12796} sells the mounts in the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters such as {npc:12799}. The Forever client lists each at 100g; choose one."] = "{npc:12796}은(는) {zone:1454} {object:172958}의 {area:2917}에서 {npc:12799} 같은 다른 명예 병참장교 옆에서 탈것을 팝니다. Forever 클라이언트 기준 각 100골드이며, 하나를 고르십시오.",
	["100g"] = "100골드",
}
