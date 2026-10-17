-- Korean (koKR): the guide forever/exploration/kalimdor-30-45 (forever/exploration/kalimdor-30-45.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1414} Kalimdor
	["Exploration: {zone:1414} 30-45"] = "탐험: {zone:1414} 30-45",

	-- Step 1: Desolace (1/2)
	-- {zone:1413} Barrens · {zone:1443} Desolace · {zone:1445} Dustwallow Marsh
	["Picks up west of the {zone:1413}, in {zone:1443}, and ends in {zone:1445}. 15 areas to discover here, levels 30-39."] = "{zone:1413} 서쪽의 {zone:1443}에서 이어지며 {zone:1445}에서 끝납니다. 이곳에서 발견할 지역은 15곳, 30-39레벨입니다.",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "한 캐릭터로 세계 지도 전체를 탐험하는 것은 Forever 유산 도전입니다(계정 공통 유산 점수 1점).",
	-- {zone:1442} Stonetalon Mountains · {zone:1443} Desolace · {area:608} Nijel's Point
	["Take the road south-west out of the {zone:1442} into {zone:1443}; {area:608} in the north is the Alliance town."] = "남서쪽 길로 {zone:1442}을(를) 빠져나가 {zone:1443}(으)로 가십시오. 북쪽의 {area:608}은(는) 얼라이언스 마을입니다.",
	-- {area:460} Sun Rock Retreat · {zone:1443} Desolace · {area:2408} Shadowprey Village
	["Fly to {area:460} and take the road south-west into {zone:1443}; {area:2408} on the west coast is the Horde town."] = "{area:460}(으)로 비행한 뒤 남서쪽 길로 {zone:1443}에 가십시오. 서해안의 {area:2408}은(는) 호드 마을입니다.",
	-- {area:608} Nijel's Point · {npc:6706} Baritanas Skyriver
	["Flight path here: {area:608} ({npc:6706})."] = "이곳의 비행 경로: {area:608} ({npc:6706}).",
	-- {area:2408} Shadowprey Village
	["Flight path here: {area:2408} (Thalon)."] = "이곳의 비행 경로: {area:2408} (탈론).",
	["Alliance town: Horde characters only need to touch its edge (guards)"] = "얼라이언스 마을: 호드 캐릭터는 가장자리만 밟으면 됩니다(경비병)",

	-- Step 2: Desolace (2/2)
	["Horde town: Alliance characters only need to touch its edge (guards)"] = "호드 마을: 얼라이언스 캐릭터는 가장자리만 밟으면 됩니다(경비병)",

	-- Step 3: Shen'dralas
	["7 areas to discover here."] = "이곳에서 발견할 지역은 7곳입니다.",
	-- {zone:2652} Shen'dralas · {zone:1443} Desolace · {zone:1412} Mulgore · {area:2657} Valley of Bones
	["{zone:2652}, the ruins between {zone:1443} and {zone:1412}, is entered from southern {zone:1443} through the {area:2657}."] = "{zone:1443}와(과) {zone:1412} 사이의 폐허인 {zone:2652}은(는) {zone:1443} 남부에서 {area:2657}을(를) 지나 들어갑니다.",

	-- Step 4: Feralas (1/2)
	["16 areas to discover here, levels 41-60."] = "이곳에서 발견할 지역은 16곳, 41-60레벨입니다.",
	-- {zone:1443} Desolace · {zone:1444} Feralas
	["Go back into southern {zone:1443}; the road continues south into {zone:1444}."] = "{zone:1443} 남부로 돌아가십시오. 길은 남쪽 {zone:1444}(으)로 이어집니다.",
	-- {area:1116} Feathermoon Stronghold · {area:1120} Sardor Isle · {area:1108} Forgotten Coast
	["{area:1116} on {area:1120} is the Alliance town (boat from the {area:1108})."] = "{area:1120}의 {area:1116}은(는) 얼라이언스 마을입니다({area:1108}에서 배).",
	-- {area:1099} Camp Mojache
	["{area:1099} in the east is the Horde town."] = "동쪽의 {area:1099}은(는) 호드 마을입니다.",
	-- {area:489} Thalanaar · {npc:8019} Fyldren Moonfeather
	["Flight paths here: {area:489} (Thyssiana), Feathermoon ({npc:8019})."] = "이곳의 비행 경로: {area:489} (티시아나), 페더문 요새 ({npc:8019}).",
	-- {area:1099} Camp Mojache
	["Flight path here: {area:1099} (Shyn)."] = "이곳의 비행 경로: {area:1099} (쉬인).",
	["level 60 area, well above this guide's range"] = "60레벨 지역으로, 이 가이드 범위보다 훨씬 높습니다",

	-- Step 6: Dustwallow Marsh
	["7 areas to discover here, levels 36-61."] = "이곳에서 발견할 지역은 7곳, 36-61레벨입니다.",
	-- {area:150} Menethil Harbor · {area:513} Theramore Isle
	["Fly to Theramore (or take the boat from {area:150}); {area:513} is the Alliance town."] = "테라모어 섬으로 비행하십시오(또는 {area:150}에서 배를 타십시오). {area:513}은(는) 얼라이언스 마을입니다.",
	-- {zone:1445} Dustwallow Marsh · {zone:1413} Barrens · {area:496} Brackenwall Village
	["{zone:1445} is east of the southern {zone:1413}; {area:496} in the north-west is the Horde town."] = "{zone:1445}은(는) {zone:1413} 남부의 동쪽에 있습니다. 북서쪽의 {area:496}은(는) 호드 마을입니다.",
	["Flight path here: Theramore (Baldruc)."] = "이곳의 비행 경로: 테라모어 섬 (발드럭).",
	-- {area:496} Brackenwall Village
	["Flight path here: {area:496} (Shardi)."] = "이곳의 비행 경로: {area:496} (샤르디).",
	["any one of these names counts"] = "이 이름 중 하나만 떠도 됩니다",
	["Horde town: Alliance characters only need to touch its edge (guards); any one of these names counts"] = "호드 마을: 얼라이언스 캐릭터는 가장자리만 밟으면 됩니다(경비병). 이 이름 중 하나만 떠도 됩니다",
	["level 61 area, well above this guide's range"] = "61레벨 지역으로, 이 가이드 범위보다 훨씬 높습니다",
	["Alliance town: Horde characters only need to touch its edge (guards); any one of these names counts"] = "얼라이언스 마을: 호드 캐릭터는 가장자리만 밟으면 됩니다(경비병). 이 이름 중 하나만 떠도 됩니다",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:1108}"] = "{area:1108}",
}
