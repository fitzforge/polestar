-- Korean (koKR): the guide forever/class/rogue/poisons-horde (forever/class/rogue/poisons-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2842} Poisons
	["{spell:2842} (Horde)"] = "{spell:2842} (호드)",
	-- {spell:2842} Poisons · {item:7676} Thistle Tea
	["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever에서는 {spell:2842}을(를) 상급자가 아니라 이 연계 퀘스트로 배웁니다. {item:7676} 제조법도 함께 얻습니다.",

	-- Step 1: The Shattered Salute
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["At 20 {npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Target him and type /salute."] = "20레벨에 {npc:3401}은(는) {object:172982} 아래 협곡인 {object:172960}에 서 있습니다. 그를 대상으로 잡고 /경례를 입력하세요.",
	-- {npc:3401} Shenthul
	["/salute {npc:3401}"] = "/경례 {npc:3401}",
	-- {quest:2458} Deep Cover · {item:8051} Flare Gun
	["{quest:2458}: keep the {item:8051}"] = "{quest:2458}: {item:8051}을(를) 보관하세요",

	-- Step 2: Taskmaster Fizzule
	-- {area:380} Crossroads · {area:382} Sludge Fen · {item:8051} Flare Gun · {npc:7233} Taskmaster Fizzule
	["Fly to the {area:380} and ride north to the Venture Co. tower north of the {area:382}. In sight of the tower, fire the {item:8051} twice, then /salute {npc:7233} before he attacks you."] = "{area:380}(으)로 날아가 북쪽으로 {area:382} 북쪽의 투자개발회사 탑까지 가세요. 탑이 보이는 곳에서 {item:8051}을(를) 두 번 쏜 뒤, {npc:7233}이(가) 공격하기 전에 /경례를 하세요.",
	-- {item:8051} Flare Gun
	["{item:8051}, twice, in sight of the tower"] = "{item:8051}, 탑이 보이는 곳에서 두 번",

	-- Step 3: Mission: Possible But Not Probable
	-- {npc:7287} Foreman Silixiz
	["Stay stealthed. {npc:7287} carries the tower key; Gallywix (elite) and his lockbox are at the top of the tower. Kill two each of the drones, patrollers and lookouts around it."] = "은신을 유지하세요. {npc:7287}이(가) 탑 열쇠를 지니고 있습니다. 갤리윅스(정예)와 그의 금고는 탑 꼭대기에 있습니다. 주변의 일꾼, 순찰대원, 망꾼을 각각 두 명씩 처치하세요.",
	-- {item:8074} Gallywix's Head · {npc:7288} Grand Foreman Puzik Gallywix
	["{item:8074}: {npc:7288} (elite)"] = "{item:8074}: {npc:7288} (정예)",

	-- Step 4: Back to Shenthul
	-- {npc:3401} Shenthul
	["Back to {npc:3401}"] = "{npc:3401}에게 돌아가기",
	-- {zone:1454} Orgrimmar
	["Fly back to {zone:1454}."] = "{zone:1454}(으)로 날아 돌아가세요.",

	-- Step 5: Serge Hinott
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:272} Tarren Mill · {area:287} Hillsbrad · {npc:2391} Serge Hinott
	["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south through {zone:1421} to {area:272} in {area:287}. {npc:2391} stands in {area:272}; wait beside him while he brews the cure."] = "{zone:1454}에서 비행선을 타고 {zone:1458}(으)로 간 뒤, 남쪽으로 {zone:1421}을(를) 지나 {area:287}의 {area:272}까지 가세요. {npc:2391}은(는) {area:272}에 서 있습니다. 그가 해독제를 만드는 동안 옆에서 기다리세요.",
	["Wait for the cure"] = "해독제 기다리기",
}
