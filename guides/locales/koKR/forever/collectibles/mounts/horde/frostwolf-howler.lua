-- Korean (koKR): the guide forever/collectibles/mounts/horde/frostwolf-howler (forever/collectibles/mounts/horde/frostwolf-howler.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Frostwolf Clan
	-- {area:2839} Alterac Valley · {faction:729} Frostwolf Clan · {npc:13219} Jekyll Flandring · {zone:1416} Alterac Mountains · {npc:13218} Grunnda Wolfheart
	["{area:2839} (level 51+) raises {faction:729}: win, capture towers and graveyards, and hand in the battleground's turn-ins. {npc:13219} waits at the Horde end of {zone:1416} outside the battleground; {npc:13218} inside {area:2839} sells the same mount."] = "{area:2839}(51레벨 이상)에서 {faction:729} 평판이 오릅니다. 승리하고, 경비탑과 무덤을 점령하고, 전장의 반복 퀘스트를 제출하십시오. {npc:13219}은(는) 전장 밖 {zone:1416}의 호드 쪽 끝에서 기다리며, {area:2839} 안의 {npc:13218}도 같은 탈것을 판매합니다.",

	-- Step 2: Horn of the Frostwolf Howler
	["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Forever 클라이언트에서는 200골드, 60레벨이며 탈것 기술 등급은 요구하지 않습니다.",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}, 200g"] = "{npc:13219}, 200골드",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Frostwolf Howler"] = "전투서리늑대",
}
