-- Korean (koKR): the guide forever/reputation/warsong-gulch (forever/reputation/warsong-gulch.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warsong Gulch Reputation"] = "전쟁노래 협곡 평판",

	-- Step 1: Silverwing Sentinels to Friendly
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Friendly"] = "{faction:890} 우호까지",
	-- {faction:890} Silverwing Sentinels · {zone:1460} Warsong Gulch
	["The {faction:890} are the Night Elves holding {zone:1460}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:890}은(는) {zone:1460}을(를) 지키는 나이트 엘프입니다. 평판은 전장에서 얻습니다. 팀이 적의 깃발을 점령할 때마다 팀 전체가 평판을 얻습니다. 아무 전투관리인에게서나 대기열에 참가하십시오. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- {npc:14733} Sentinel Farsong
	["{npc:14733} takes Warsong Gulch Marks of Honor for Vanquish the Invaders!, once per level bracket (data); check them live."] = "{npc:14733}은(는) 침략자 처단! 퀘스트로 전쟁노래 협곡 명예 훈장을 레벨 구간마다 한 번씩 받습니다(데이터 기준). 게임에서 직접 확인하세요.",

	-- Step 2: Silverwing Sentinels to Honored
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Honored"] = "{faction:890} 우대까지",
	-- {zone:1460} Warsong Gulch · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15351} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "{zone:1460}을(를) 계속 플레이하며 깃발을 쟁취하세요. 전장 이벤트: {zone:1460} 주말에는 수도의 {npc:15351}이(가) 전쟁노래 협곡 명예 훈장 3개를 받고 추가 평판을 줍니다.",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753} hands out one Sentinel care package by level"] = "{npc:14753}이(가) 레벨에 따라 파수대 구급품을 하나 나눠 줍니다",

	-- Step 3: Silverwing Sentinels to Revered
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Revered"] = "{faction:890} 존경까지",
	-- {zone:1460} Warsong Gulch
	["Keep capturing flags in {zone:1460}."] = "{zone:1460}에서 계속 깃발을 점령하십시오.",

	-- Step 4: Silverwing Sentinels to Exalted
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Exalted"] = "{faction:890} 확고한 동맹까지",
	-- {faction:890} Silverwing Sentinels
	["Exalted with the {faction:890} earns a Legacy Point."] = "{faction:890}와(과) 확고한 동맹이 되면 유산 점수를 1 얻습니다.",

	-- Step 5: Warsong Outriders to Friendly
	-- {faction:889} Warsong Outriders
	["{faction:889} to Friendly"] = "{faction:889} 우호까지",
	-- {faction:889} Warsong Outriders · {zone:1440} Ashenvale
	["The {faction:889} are the Orcs logging {zone:1440}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:889}은(는) {zone:1440}에서 벌목하는 오크입니다. 평판은 전장에서 얻습니다. 팀이 적의 깃발을 점령할 때마다 팀 전체가 평판을 얻습니다. 아무 전투관리인에게서나 대기열에 참가하십시오. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- {npc:14781} Captain Shatterskull
	["{npc:14781} takes Warsong Gulch Marks of Honor for Quell the Silverwing Usurpers, once per level bracket (data); check them live."] = "{npc:14781}은(는) 은빛날개 분쟁 진압 퀘스트로 전쟁노래 협곡 명예 훈장을 레벨 구간마다 한 번씩 받습니다(데이터 기준). 게임에서 직접 확인하세요.",

	-- Step 6: Warsong Outriders to Honored
	-- {faction:889} Warsong Outriders
	["{faction:889} to Honored"] = "{faction:889} 우대까지",
	-- {zone:1460} Warsong Gulch · {npc:15350} Horde Warbringer
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15350} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "{zone:1460}을(를) 계속 플레이하며 깃발을 쟁취하세요. 전장 이벤트: {zone:1460} 주말에는 수도의 {npc:15350}이(가) 전쟁노래 협곡 명예 훈장 3개를 받고 추가 평판을 줍니다.",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754} hands out one Outrider care package by level"] = "{npc:14754}이(가) 레벨에 따라 정찰대 구급품을 하나 나눠 줍니다",

	-- Step 7: Warsong Outriders to Revered
	-- {faction:889} Warsong Outriders
	["{faction:889} to Revered"] = "{faction:889} 존경까지",

	-- Step 8: Warsong Outriders to Exalted
	-- {faction:889} Warsong Outriders
	["{faction:889} to Exalted"] = "{faction:889} 확고한 동맹까지",
	-- {faction:889} Warsong Outriders
	["Exalted with the {faction:889} earns a Legacy Point."] = "{faction:889}와(과) 확고한 동맹이 되면 유산 점수를 1 얻습니다.",
}
