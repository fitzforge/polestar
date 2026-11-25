-- Korean (koKR): the guide forever/collectibles/pets/baby-crocolisk (forever/collectibles/pets/baby-crocolisk.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sewer Beast
	-- {npc:3581} Sewer Beast · {zone:1453} Stormwind · {item:282047} Baby Crocolisk
	["The {npc:3581} is a rare level 50 crocolisk, much tougher than a normal mob of its level. It swims {zone:1453}'s canals and appears at one of six spots, about two hours after it last died; the arrow takes you round them. Below 60, bring a group; at 60, a well-geared character can try it alone. It drops the {item:282047} about once in 70 kills, and the pet binds when picked up, so the Auction House never has it. Horde players can farm it too, but inside an enemy capital."] = "{npc:3581}은(는) 50레벨 희귀 악어로 같은 레벨 일반 몹보다 훨씬 강합니다. {zone:1453} 운하를 헤엄치며 여섯 지점 중 한 곳에 나타나고 마지막으로 죽은 지 약 두 시간 후에 다시 나옵니다. 화살표가 지점을 돌아가게 안내합니다. 60레벨 미만이라면 파티를 꾸리세요. 60레벨이라면 장비가 좋은 캐릭터가 혼자 시도할 수 있습니다. {item:282047}은(는) 약 70회 처치에 한 번 떨어지며 주우면 귀속되므로 경매장에는 올라오지 않습니다. 호드도 잡을 수 있지만 적 진영 수도 안에서입니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {npc:3581} is a rare level 50 crocolisk that swims {zone:1453}'s canals; early kill counts give about 1.5% per kill. It is friendly to nobody: Horde players can farm it too, but they are in an enemy capital."] = "{npc:3581}은(는) {zone:1453}의 수로를 헤엄치는 50레벨 희귀 악어입니다. 초기 처치 집계로는 처치당 약 1.5%입니다. 누구에게도 우호적이지 않으므로 호드 플레이어도 사냥할 수 있지만, 적 수도 안에 있게 됩니다.",
}
