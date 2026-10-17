-- Korean (koKR): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "{skill:356} 배우기",
	-- {skill:356} Fishing · {item:6256} Fishing Pole
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "진영의 {skill:356} 상급자 누구에게서나 초급 {skill:356}을(를) 배울 수 있습니다(캐릭터 레벨 5). 화살표가 가장 가까운 상급자를 가리킵니다. 직업용품 상인이나 낚시 상인에게서 {item:6256}을(를) 사서 장착하세요.",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "숙련도 50까지 이곳에서 낚시하세요. 찌가 첨벙이면 클릭하세요. 낚을 때마다 숙련도가 오를 수 있습니다.",

	-- Step 4: Fishing: Darkshore (1-50)
	-- {area:442} Auberdine
	["{area:442} shore"] = "{area:442} 물가",

	-- Step 5: Fishing: Durotar (1-50)
	-- {zone:1411} Durotar
	["{zone:1411} coast"] = "{zone:1411} 해안",

	-- Step 6: Fishing: The Barrens (1-50)
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "{zone:1413} 오아시스",

	-- Step 7: Fishing: Tirisfal Glades (1-50)
	["Vile Fin shore"] = "썩은지느러미 물가",

	-- Step 8: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "수습 {skill:356}",
	-- {skill:356} Fishing
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "수습 {skill:356}은(는) 최대 숙련도를 150(으)로 올립니다. 숙련도 50, 캐릭터 레벨 10이(가) 필요합니다. 화살표는 진영의 가장 가까운 {skill:356} 상급자를 가리킵니다.",

	-- Step 9: Fishing: Westfall (50-125)
	["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "숙련도 125까지 이곳의 낚시터와 탁 트인 물에서 낚시하세요. 낚시터(떠다니는 잔해, 물고기 떼)에서는 추가 전리품도 나옵니다.",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "{zone:1436} 해안",

	-- Step 11: Fishing: Darkshore (50-125)
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "{zone:1439} 해안",

	-- Step 14: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "숙련 {skill:356}",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "숙련 {skill:356}(최대 225)은(는) 상급자가 아니라 책으로 배웁니다. {zone:1434} 남쪽 끝 {area:35}에서 {npc:2626}이(가) 양 진영 모두에게 {item:16083}을(를) 팝니다. 사서 읽으세요. 숙련도 125, 레벨 20이 필요합니다.",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "{item:16083} 사서 읽기 (숙련 {skill:356})",

	-- Step 15: Fishing: Wetlands (125-225)
	["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "숙련도 225까지 이곳의 낚시터에서 낚시하세요. 물고기가 자꾸 달아나면 숙련도가 오를 때까지 더 쉬운 곳에서 낚시하세요.",
	-- {zone:1437} Wetlands
	["{zone:1437} coast"] = "{zone:1437} 해안",

	-- Step 16: Fishing: Ashenvale (125-225)
	-- {zone:1440} Ashenvale
	["{zone:1440} waters"] = "{zone:1440} 바다",

	-- Step 18: Fishing: Hillsbrad Foothills (125-225)
	-- {area:287} Hillsbrad
	["{area:287} coast"] = "{area:287} 해안",

	-- Step 19: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "전문 {skill:356}(최대 300)은(는) {zone:1445}의 {npc:12919}에게서 배웁니다. {zone:1455}의 낚시 상급자가 그에게 보내 줍니다. 퀘스트에는 숙련도 225, 레벨 35가 필요합니다.",

	-- Step 20: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "전문 {skill:356}(최대 300)은(는) {zone:1445}의 {npc:12919}에게서 배웁니다. {zone:1454}의 낚시 상급자가 그에게 보내 줍니다. 퀘스트에는 숙련도 225, 레벨 35가 필요합니다.",

	-- Step 21: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919}은(는) 테라모어 섬 남쪽, 동쪽 해안 앞바다의 작은 섬 물가에서 낚시하고 있습니다.",

	-- Step 22: Sar'theris Striker
	-- {area:598} Sar'theris Strand · {zone:1443} Desolace · {item:16968} Sar'theris Striker
	["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "{item:16968}을(를) 낚을 때까지 {zone:1443} 북서쪽 해안(뱀갈퀴일족 나가 해안)인 {area:598}에서 낚시하세요. 그곳에서만 낚입니다.",

	-- Step 23: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {item:16967} Feralas Ahi
	["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "{item:16967}을(를) 낚을 때까지 {zone:1444}의 {area:2521}에서 낚시하세요. 그곳에서만 낚입니다.",

	-- Step 24: Savage Coast Blue Sailfin
	-- {area:301} Savage Coast · {zone:1434} Stranglethorn Vale · {item:16969} Savage Coast Blue Sailfin
	["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "{item:16969}을(를) 낚을 때까지 {zone:1434} 북서쪽 물가인 {area:301}에서 낚시하세요. 그곳에서만 낚입니다.",

	-- Step 25: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "{item:16970}을(를) 낚을 때까지 {zone:1435} 남동쪽 물가인 {area:300}에서 낚시하세요. 그곳에서만 낚입니다.",

	-- Step 26: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "전문 {skill:356}",

	-- Step 27: Fishing: Stranglethorn Vale (225-300)
	-- {area:35} Booty Bay · {item:6530} Nightcrawlers
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "숙련도 300까지 이곳 해안의 낚시터(장어, 도미, 잔해)에서 낚시하세요. {area:35}에서 미끼와 {item:6530}을(를) 팔며, 낚시 숙련도가 조금 오릅니다.",
	-- {area:35} Booty Bay
	["{area:35} coast"] = "{area:35} 해안",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{zone:1413} oasis"] = "{zone:1413} 오아시스",
}
