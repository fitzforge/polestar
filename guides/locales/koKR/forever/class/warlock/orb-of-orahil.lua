-- Korean (koKR): the guide forever/class/warlock/orb-of-orahil (forever/class/warlock/orb-of-orahil.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orb of Orahil"] = "오라힐의 보주",
	["An off-hand orb or a staff for your late 30s, down the felhound's or the infernal's path, your pick."] = "30대 후반에 얻는 보조장비 보주 또는 지팡이입니다. 지옥사냥개 경로와 지옥불정령 경로 중 원하는 쪽을 고르십시오.",

	-- Step 1: Knowledge of the Orb of Orahil (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "35레벨에 {object:2101} {object:2164}의 {npc:461}이(가) {area:392}의 {npc:6266}에게 보냅니다.",

	-- Step 2: Knowledge of the Orb of Orahil (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "35레벨에 {zone:1455}의 {npc:5172}이(가) {area:392}의 {npc:6266}에게 보냅니다.",

	-- Step 3: Knowledge of the Orb of Orahil (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "35레벨에 {object:172960}의 {npc:3326}이(가) {area:392}의 {npc:6266}에게 보냅니다.",

	-- Step 4: Knowledge of the Orb of Orahil (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 35 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "35레벨에 {object:36082}의 {npc:4563}이(가) {area:392}의 {npc:6266}에게 보냅니다. {zone:1420}에서 출발하는 비행선은 {zone:1411}(으)로 갑니다.",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["{npc:6266} and her two acolytes stand in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266}와(과) 두 수행사제는 {area:392} 위 언덕의 탑 안, {npc:6251} 옆에 있습니다.",

	-- Step 6: Choose an acolyte
	["Choose an acolyte"] = "수행사제 고르기",
	-- {npc:6254} Acolyte Wytula · {item:15106} Staff of Dar'Orahil · {npc:6252} Acolyte Magaz · {item:15105} Staff of Noh'Orahil
	["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, {npc:6252}'s infernal path with the Orb or {item:15105}. The guide follows the one you take."] = "수행사제 하나를 고르십시오. 퀘스트는 한 명의 것만 수락할 수 있습니다. {npc:6254}의 지옥사냥개 경로는 보주 또는 {item:15106}(으)로, {npc:6252}의 지옥불정령 경로는 보주 또는 {item:15105}(으)로 끝납니다. 가이드는 수락한 쪽을 따라갑니다.",
	-- {npc:6254} Acolyte Wytula · {item:12647} Felhas Ruby
	["{npc:6254}: she gives you the {item:12647}"] = "{npc:6254}: {item:12647}을(를) 줍니다",
	-- {npc:6252} Acolyte Magaz · {item:12646} Infus Emerald
	["{npc:6252}: he gives you the {item:12646}"] = "{npc:6252}: {item:12646}을(를) 줍니다",

	-- Step 7: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {item:7291} Infernal Orb · {item:12647} Felhas Ruby · {npc:4678} Mana Eater · {item:12646} Infus Emerald · {npc:4676} Lesser Infernal
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["The demons of {area:602}, in southern {zone:1443}, have all you need. Burning Blade Summoners carry the {item:7291}. On the felhound path, use the {item:12647} on a {npc:4678}, a felhound, and kill it for its spirit; on the infernal path, use the {item:12646} on a {npc:4676} and kill it."] = "{zone:1443} 남부 {area:602}의 악마들에게서 필요한 것을 모두 얻을 수 있습니다. 불타는칼날단 소환사가 {item:7291}을(를) 가지고 있습니다. 지옥사냥개 경로라면 지옥사냥개인 {npc:4678}에게 {item:12647}을(를) 사용하고 처치해 영혼을 얻으십시오. 지옥불정령 경로라면 {npc:4676}에게 {item:12646}을(를) 사용하고 처치하십시오.",
	-- {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["{item:7291}, from the Burning Blade Summoners"] = "{item:7291}, 불타는칼날단 소환사에게서",
	-- {item:12648} Imprisoned Felhound Spirit · {npc:4678} Mana Eater
	["{item:12648}, from a {npc:4678}"] = "{item:12648}, {npc:4678}에게서",
	-- {item:12649} Imprisoned Infernal Spirit · {npc:4676} Lesser Infernal
	["{item:12649}, from a {npc:4676}"] = "{item:12649}, {npc:4676}에게서",

	-- Step 8: The demon's spirit
	["The demon's spirit"] = "악마의 영혼",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6546} Tabetha
	["Back to {npc:6266} in the tower above {area:392} with the spirit first: {npc:6546}'s cleansing follows it."] = "먼저 영혼을 가지고 {area:392} 위 탑의 {npc:6266}에게 돌아가십시오. 그다음 {npc:6546}의 정화가 이어집니다.",

	-- Step 9: Tabetha
	-- {npc:6546} Tabetha · {zone:1445} Dustwallow Marsh · {npc:6549} Demon of the Orb · {item:7291} Infernal Orb
	["{npc:6546} lives at her farm in western {zone:1445}. She calls the {npc:6549} out of the {item:7291}; it is elite: grouping up is advised."] = "{npc:6546}은(는) {zone:1445} 서부의 농장에 삽니다. 그녀가 {item:7291}에서 {npc:6549}을(를) 불러냅니다. 정예이므로 파티를 권장합니다.",

	-- Step 10: The Orb of Dar'Orahil
	-- {item:15108} Orb of Dar'Orahil
	["The {item:15108}"] = "{item:15108}",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:15108} Orb of Dar'Orahil
	["Back to {npc:6266} in the tower above {area:392} with the cleansed orb. On the felhound path, wait while she completes the {item:15108}, then speak to her again."] = "정화된 보주를 가지고 {area:392} 위 탑의 {npc:6266}에게 돌아가십시오. 지옥사냥개 경로라면 그녀가 {item:15108}을(를) 완성할 때까지 기다린 뒤 다시 대화하십시오.",
	["Wait for the orb"] = "보주 기다리기",

	-- Step 11: The Orb of Noh'Orahil
	-- {item:15107} Orb of Noh'Orahil
	["The {item:15107}"] = "{item:15107}",
	-- {npc:6266} Menara Voidrender · {item:15107} Orb of Noh'Orahil
	["On the infernal path, wait while {npc:6266} completes the {item:15107}, then speak to her again."] = "지옥불정령 경로라면 {npc:6266}이(가) {item:15107}을(를) 완성할 때까지 기다린 뒤 다시 대화하십시오.",
}
