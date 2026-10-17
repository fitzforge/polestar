-- Korean (koKR): the guide forever/collectibles/mounts/alliance/paladin-warhorse (forever/collectibles/mounts/alliance/paladin-warhorse.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse"] = "성기사 군마",
	["Your first mount at 40, summoned at will: a paladin buys no horse."] = "40레벨에 얻는 첫 탈것으로, 언제든 소환할 수 있습니다: 성기사는 말을 구매하지 않습니다.",

	-- Step 1: The Tome of Nobility (Ironforge)
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {zone:1455} Ironforge
	["At 40 {npc:5149} in the {object:32362} sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "40레벨에 {object:32362}의 {npc:5149}이(가) {zone:1453} 빛의 대성당의 {npc:6171}에게 보냅니다. {zone:1455}에서 {zone:1453}까지는 깊은굴 지하철을 타십시오.",

	-- Step 2: Summon Warhorse
	-- {npc:6171} Duthorian Rall · {item:6779} Tome of Nobility · {spell:13819} Summon Warhorse
	["{npc:6171} stands in the Cathedral of Light. Turning in the {item:6779} teaches {spell:13819}; Paladins do not buy a mount."] = "{npc:6171}은(는) 빛의 대성당에 있습니다. {item:6779}을(를) 제출하면 {spell:13819}을(를) 배웁니다. 성기사는 탈것을 구매하지 않습니다.",
}
