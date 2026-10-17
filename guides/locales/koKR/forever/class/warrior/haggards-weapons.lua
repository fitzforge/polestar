-- Korean (koKR): the guide forever/class/warrior/haggards-weapons (forever/class/warrior/haggards-weapons.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Haggard's Weapons"] = "해거드의 무기",
	-- {spell:71} Defensive Stance
	["{spell:71} and a one-hand weapon of your choice at 10."] = "10레벨에 {spell:71}와(과) 원하는 한손 무기 하나.",

	-- Step 1: Defensive Stance
	-- {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["{npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "{npc:5480}은(는) {object:2100}에서 전사를 훈련시킵니다. {npc:6089}와(과) {npc:6090}은(는) 그곳 {object:2152} 옆에 함께 서 있습니다. {npc:6090}은(는) 자기 잔을 걸고 당신과 싸웁니다.",

	-- Step 2: Marshal Haggard
	-- {npc:294} Marshal Haggard · {zone:1429} Elwynn Forest · {zone:1453} Stormwind
	["{npc:294}'s house is in eastern {zone:1429}, south of the road from {zone:1453} to Redridge."] = "{npc:294}의 집은 {zone:1429} 동부, {zone:1453}에서 붉은마루 산맥으로 가는 길 남쪽에 있습니다.",

	-- Step 3: Dead-tooth Jack
	-- {npc:6093} Dead-Tooth Jack · {zone:1429} Elwynn Forest · {npc:294} Marshal Haggard
	["{npc:6093} camps in the far south-east of {zone:1429}, south-east of {npc:294}. He carries the key to the strongbox in his camp."] = "{npc:6093}은(는) {zone:1429} 남동쪽 끝, {npc:294}의 남동쪽에 진을 치고 있습니다. 그가 야영지 금고의 열쇠를 지니고 있습니다.",
	-- {npc:6093} Dead-Tooth Jack
	["{npc:6093}: his key opens the strongbox"] = "{npc:6093}: 그의 열쇠로 금고를 여세요",

	-- Step 4: Back to Marshal Haggard
	-- {npc:294} Marshal Haggard
	["Back to {npc:294}"] = "{npc:294}에게 돌아가기",
}
