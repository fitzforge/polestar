-- Korean (koKR): the guide forever/collectibles/pets/excitable-slime (forever/collectibles/pets/excitable-slime.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Nutritious Slime Sludge
	-- {item:278265} Nutritious Slime Sludge · {npc:4612} Boyle · {zone:1458} Undercity
	["Buy {item:278265} from {npc:4612} in the {zone:1458} canals first (25 copper for a stack of 5): you hand it in as soon as the slime offers its quest."] = "먼저 {zone:1458} 수로의 {npc:4612}에게서 {item:278265}을(를) 사세요(5개 묶음 25코퍼). 슬라임이 퀘스트를 주자마자 제출합니다.",
	-- {item:278265} Nutritious Slime Sludge · {npc:4612} Boyle
	["{item:278265}: {npc:4612}, in the canals"] = "{item:278265}: 수로의 {npc:4612}",

	-- Step 2: WRIGGLE.
	-- {npc:269452} Excitable Slime · {npc:4612} Boyle · {quest:97583} WRIGGLE.
	["Find an {npc:269452}, a little critter in the canal water beside {npc:4612}, target it and /dance at it, again and again, until it dances back and offers {quest:97583}; this takes many tries. Hand in the sludge right away. If the slime seems tired, /dance with it again before you hand in."] = "{npc:4612} 곁 수로 물속의 작은 생물 {npc:269452}을(를) 찾아 대상으로 /dance를 계속 입력해 춤을 추고 {quest:97583}을(를) 받으세요. 여러 번 시도해야 합니다. 슬라임이 지친 듯하면 제출 전에 다시 /dance 하세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Find the {npc:269452}, a critter in the {zone:1458} canals, and /dance with it until it offers WRIGGLE. Buy {item:278265} from a vendor in the canals and bring it back; if the slime seems tired, dance with it again."] = "{zone:1458} 수로에 있는 동물 {npc:269452}을(를) 찾아 WRIGGLE을 제안할 때까지 함께 /춤 하세요. 수로의 상인에게서 {item:278265}을(를) 사서 가져오세요. 수액괴물이 지쳐 보이면 다시 함께 춤추세요.",
}
